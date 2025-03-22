using System;
#if !NET10
using System.Runtime.InteropServices;
#endif
using ScopedObjectPin.IlHelpers;

namespace ScopedObjectPin;

public static unsafe partial class Pin
{
#if NET10_0_OR_GREATER
    private struct TempPinHolder : IDisposable
    {
        private readonly PinnedGCHandle<object?>? _handle;
        private bool _disposed;

        [ThreadStatic]
        private static PinnedGCHandle<object?> _staticHandle;

        public PinnedGCHandle<object?> GCHandle => _handle ?? _staticHandle;
        
        internal TempPinHolder(object? o)
        {
            switch (_staticHandle)
            {
                case { IsAllocated: true, Target: null }:
                    _staticHandle.Target = o;
                    break;
                case { IsAllocated: true }:
                    _handle = new PinnedGCHandle<object?>(o);
                    break;
                case { IsAllocated: false }:
                    _staticHandle = new PinnedGCHandle<object?>(o);
                    break;
            }
        }

        public void Dispose()
        {
            if (_disposed) return;
            _disposed = true;

            if (_handle is { } handle)
            {
                handle.Dispose();
            }
            else
            {
                _staticHandle.Target = null;
            }
        }

    }
#else
    private static readonly nint ObjectDataOffset = Helper.GetObjectDataOffset();
#endif
    
    public static void Handle(object? o, PtrAction callback)
    {
#if NET10_0_OR_GREATER
        using var handle = new TempPinHolder(o);
        callback((void*)PinnedGCHandle<object?>.ToIntPtr(handle.GCHandle));
#else
        Helper.PinObjectWithOffset(o, default, callback);
#endif
    }

    public static void Object(object? o, PtrAction callback)
    {
        switch (o)
        {
            case string s:
                fixed (char* p = s)
                {
                    callback(p);
                }
                break;
            case null:
                callback(null);
                break;
#if NET10_0_OR_GREATER
            case Array a:
                using (var handle = new TempPinHolder(a))
                {
                    callback((void*)Marshal.UnsafeAddrOfPinnedArrayElement(a, 0));
                }
                break;
            default:
                using (var handle = new TempPinHolder(o))
                {
                    callback(handle.GCHandle.GetAddressOfObjectData());
                }
                break;
#else
            case Array a:
                Helper.PinArray(a, callback);
                break;
            default:
                Helper.PinObjectWithOffset(o, ObjectDataOffset, callback);
                break;
#endif
        }
    }

    public static void Array(Array? a, PtrAction callback)
    {
        if (a is null)
        {
            callback(null);
        }
        else
        {
#if NET10_0_OR_GREATER
            using var handle = new TempPinHolder(a);
            callback((void*)Marshal.UnsafeAddrOfPinnedArrayElement(a, 0));
#else
            Helper.PinArray(a, callback);
#endif
        }
    }
}
