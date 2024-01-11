#pragma warning disable CS9113

namespace System
{
    public class Object;
    public abstract class ValueType;
    public abstract class Enum : ValueType;
    public struct Void;
    public struct Byte;
    public struct Int32;
    public struct IntPtr;
    public struct Boolean;
    public struct Char;
    public sealed class String;
    public abstract class Attribute;
    public abstract class Array;
    
    public abstract class Delegate;
    public abstract class MulticastDelegate : Delegate;

    public class Exception;

    public class NullReferenceException : Exception;

    public sealed class AttributeUsageAttribute(AttributeTargets targets)
    {
        public bool AllowMultiple { get; set; }
        public bool Inherited { get; set; }
    }

    public enum AttributeTargets;

    namespace Runtime
    {
        namespace Versioning
        {
            public sealed class TargetFrameworkAttribute(string frameworkName) : Attribute
            {
                public string FrameworkDisplayName { get; set; }
            }
        }

        namespace CompilerServices
        {
            public static class RuntimeHelpers
            {
                public static int OffsetToStringData { get; }
            }
        }
    }

    namespace Reflection
    {
        public abstract class Type;
        public sealed class AssemblyCompanyAttribute(string s) : Attribute;
        public sealed class AssemblyConfigurationAttribute(string s) : Attribute;
        public sealed class AssemblyFileVersionAttribute(string s) : Attribute;
        public sealed class AssemblyInformationalVersionAttribute(string s) : Attribute;
        public sealed class AssemblyProductAttribute(string s) : Attribute;
        public sealed class AssemblyTitleAttribute(string s) : Attribute;
        public sealed class AssemblyVersionAttribute(string s) : Attribute;
        public sealed class AssemblyCopyrightAttribute(string s) : Attribute;
        public sealed class AssemblyDescriptionAttribute(string s) : Attribute;
    }
}
