unit CMC.EVNTrace;

(*++

Copyright (c) Microsoft Corporation.  All rights reserved.

Module Name:

    EvnTrace.h

Abstract:

    Public headers for event tracing control applications,
    consumers and providers

--*)

{$IFDEF FPC}
{$mode delphi}
{$ENDIF}

interface

uses
    Windows, Classes, SysUtils;

const

    // EventTraceGuid is used to identify a event tracing session
    EventTraceGuid: TGUID = '{68fdd900-4a3e-11d1-84f4-0000f80464e3}';


    // SystemTraceControlGuid. Used to specify event tracing for kernel
    SystemTraceControlGuid: TGUID = '{9e814aad-3204-11d2-9a82-006008a86939}';


    // EventTraceConfigGuid. Used to report system configuration records
    EventTraceConfigGuid: TGUID = '{01853a65-418f-4f36-aefc-dc0f1d2fd235}';



    // DefaultTraceSecurityGuid. Specifies the default event tracing security
    DefaultTraceSecurityGuid: TGUID = '{0811c1af-7a07-4a06-82ed-869455cdf713}';



    // PrivateLoggerNotificationGuid
    // Used for private cross-process logger notifications.
    PrivateLoggerNotificationGuid: TGUID = '{3595ab5c-042a-4c8e-b942-2d059bfeb1b1}';

    KERNEL_LOGGER_NAMEW: PWideChar = 'NT Kernel Logger';
    GLOBAL_LOGGER_NAMEW: PWideChar = 'GlobalLogger';
    EVENT_LOGGER_NAMEW: PWideChar = 'EventLog';
    DIAG_LOGGER_NAMEW: PWideChar = 'DiagLog';

    KERNEL_LOGGER_NAMEA: PAnsiChar = 'NT Kernel Logger';
    GLOBAL_LOGGER_NAMEA: PAnsiChar = 'GlobalLogger';
    EVENT_LOGGER_NAMEA: PAnsiChar = 'EventLog';
    DIAG_LOGGER_NAMEA: PAnsiChar = 'DiagLog';

    MAX_MOF_FIELDS = 16;  // Limit of USE_MOF_PTR fields



    //types for event data going to System Event Logger
    // SYSTEM_EVENT_TYPE                        1


    // predefined generic event types ($00 to $09 reserved).


    EVENT_TRACE_TYPE_INFO = $00;  // Info or point event
    EVENT_TRACE_TYPE_START = $01;  // Start event
    EVENT_TRACE_TYPE_END = $02;  // End event
    EVENT_TRACE_TYPE_STOP = $02;  // Stop event (WinEvent compatible)
    EVENT_TRACE_TYPE_DC_START = $03;  // Collection start marker
    EVENT_TRACE_TYPE_DC_END = $04;  // Collection end marker
    EVENT_TRACE_TYPE_EXTENSION = $05;  // Extension/continuation
    EVENT_TRACE_TYPE_REPLY = $06;  // Reply event
    EVENT_TRACE_TYPE_DEQUEUE = $07;  // De-queue event
    EVENT_TRACE_TYPE_RESUME = $07;  // Resume event (WinEvent compatible)
    EVENT_TRACE_TYPE_CHECKPOINT = $08;  // Generic checkpoint event
    EVENT_TRACE_TYPE_SUSPEND = $08;  // Suspend event (WinEvent compatible)
    EVENT_TRACE_TYPE_WINEVT_SEND = $09;  // Send Event (WinEvent compatible)
    EVENT_TRACE_TYPE_WINEVT_RECEIVE = $F0;  // Receive Event (WinEvent compatible)


    // Predefined Event Tracing Levels for Software/Debug Tracing


    // Trace Level is UCHAR and passed in through the EnableLevel parameter
    // in EnableTrace API. It is retrieved by the provider using the
    // GetTraceEnableLevel macro.It should be interpreted as an integer value
    // to mean everything at or below that level will be traced.

    // Here are the possible Levels.


    TRACE_LEVEL_NONE = 0;   // Tracing is not on
    TRACE_LEVEL_CRITICAL = 1;   // Abnormal exit or termination
    TRACE_LEVEL_FATAL = 1;   // Deprecated name for Abnormal exit or termination
    TRACE_LEVEL_ERROR = 2;   // Severe errors that need logging
    TRACE_LEVEL_WARNING = 3;   // Warnings such as allocation failure
    TRACE_LEVEL_INFORMATION = 4;   // Includes non-error cases(e.g.,Entry-Exit)
    TRACE_LEVEL_VERBOSE = 5;   // Detailed traces from intermediate steps
    TRACE_LEVEL_RESERVED6 = 6;
    TRACE_LEVEL_RESERVED7 = 7;
    TRACE_LEVEL_RESERVED8 = 8;
    TRACE_LEVEL_RESERVED9 = 9;



    // Event types for Process & Threads


    EVENT_TRACE_TYPE_LOAD = $0A;     // Load image
    EVENT_TRACE_TYPE_TERMINATE = $0B;     // Terminate Process


    // Event types for IO subsystem


    EVENT_TRACE_TYPE_IO_READ = $0A;
    EVENT_TRACE_TYPE_IO_WRITE = $0B;
    EVENT_TRACE_TYPE_IO_READ_INIT = $0C;
    EVENT_TRACE_TYPE_IO_WRITE_INIT = $0D;
    EVENT_TRACE_TYPE_IO_FLUSH = $0E;
    EVENT_TRACE_TYPE_IO_FLUSH_INIT = $0F;
    EVENT_TRACE_TYPE_IO_REDIRECTED_INIT = $10;


    // Event types for Memory subsystem


    EVENT_TRACE_TYPE_MM_TF = $0A;     // Transition fault
    EVENT_TRACE_TYPE_MM_DZF = $0B;     // Demand Zero fault
    EVENT_TRACE_TYPE_MM_COW = $0C;     // Copy on Write
    EVENT_TRACE_TYPE_MM_GPF = $0D;     // Guard Page fault
    EVENT_TRACE_TYPE_MM_HPF = $0E;     // Hard page fault
    EVENT_TRACE_TYPE_MM_AV = $0F;     // Access violation


    // Event types for Network subsystem, all protocols


    EVENT_TRACE_TYPE_SEND = $0A;    // Send
    EVENT_TRACE_TYPE_RECEIVE = $0B;    // Receive
    EVENT_TRACE_TYPE_CONNECT = $0C;    // Connect
    EVENT_TRACE_TYPE_DISCONNECT = $0D;    // Disconnect
    EVENT_TRACE_TYPE_RETRANSMIT = $0E;    // ReTransmit
    EVENT_TRACE_TYPE_ACCEPT = $0F;    // Accept
    EVENT_TRACE_TYPE_RECONNECT = $10;    // ReConnect
    EVENT_TRACE_TYPE_CONNFAIL = $11;    // Fail
    EVENT_TRACE_TYPE_COPY_TCP = $12;    // Copy in PendData
    EVENT_TRACE_TYPE_COPY_ARP = $13;    // NDIS_STATUS_RESOURCES Copy
    EVENT_TRACE_TYPE_ACKFULL = $14;    // A full data ACK
    EVENT_TRACE_TYPE_ACKPART = $15;    // A Partial data ACK
    EVENT_TRACE_TYPE_ACKDUP = $16;    // A Duplicate data ACK



    // Event Types for the Header (to handle internal event headers)


    EVENT_TRACE_TYPE_GUIDMAP = $0A;
    EVENT_TRACE_TYPE_CONFIG = $0B;
    EVENT_TRACE_TYPE_SIDINFO = $0C;
    EVENT_TRACE_TYPE_SECURITY = $0D;
    EVENT_TRACE_TYPE_DBGID_RSDS = $40;


    // Event Types for Registry subsystem


    EVENT_TRACE_TYPE_REGCREATE = $0A;     // NtCreateKey
    EVENT_TRACE_TYPE_REGOPEN = $0B;    // NtOpenKey
    EVENT_TRACE_TYPE_REGDELETE = $0C;    // NtDeleteKey
    EVENT_TRACE_TYPE_REGQUERY = $0D;    // NtQueryKey
    EVENT_TRACE_TYPE_REGSETVALUE = $0E;    // NtSetValueKey
    EVENT_TRACE_TYPE_REGDELETEVALUE = $0F;    // NtDeleteValueKey
    EVENT_TRACE_TYPE_REGQUERYVALUE = $10;    // NtQueryValueKey
    EVENT_TRACE_TYPE_REGENUMERATEKEY = $11;    // NtEnumerateKey
    EVENT_TRACE_TYPE_REGENUMERATEVALUEKEY = $12;    // NtEnumerateValueKey
    EVENT_TRACE_TYPE_REGQUERYMULTIPLEVALUE = $13;    // NtQueryMultipleValueKey
    EVENT_TRACE_TYPE_REGSETINFORMATION = $14;    // NtSetInformationKey
    EVENT_TRACE_TYPE_REGFLUSH = $15;    // NtFlushKey
    EVENT_TRACE_TYPE_REGKCBCREATE = $16;    // KcbCreate
    EVENT_TRACE_TYPE_REGKCBDELETE = $17;    // KcbDelete
    EVENT_TRACE_TYPE_REGKCBRUNDOWNBEGIN = $18;    // KcbRundownBegin
    EVENT_TRACE_TYPE_REGKCBRUNDOWNEND = $19;    // KcbRundownEnd
    EVENT_TRACE_TYPE_REGVIRTUALIZE = $1A;    // VirtualizeKey
    EVENT_TRACE_TYPE_REGCLOSE = $1B;    // NtClose (KeyObject)
    EVENT_TRACE_TYPE_REGSETSECURITY = $1C;    // SetSecurityDescriptor (KeyObject)
    EVENT_TRACE_TYPE_REGQUERYSECURITY = $1D;    // QuerySecurityDescriptor (KeyObject)
    EVENT_TRACE_TYPE_REGCOMMIT = $1E;    // CmKtmNotification (TRANSACTION_NOTIFY_COMMIT)
    EVENT_TRACE_TYPE_REGPREPARE = $1F;    // CmKtmNotification (TRANSACTION_NOTIFY_PREPARE)
    EVENT_TRACE_TYPE_REGROLLBACK = $20;    // CmKtmNotification (TRANSACTION_NOTIFY_ROLLBACK)
    EVENT_TRACE_TYPE_REGMOUNTHIVE = $21;    // NtLoadKey variations + system hives


    // Event types for system configuration records

    EVENT_TRACE_TYPE_CONFIG_CPU = $0A;   // CPU Configuration
    EVENT_TRACE_TYPE_CONFIG_PHYSICALDISK = $0B;   // Physical Disk Configuration
    EVENT_TRACE_TYPE_CONFIG_LOGICALDISK = $0C;   // Logical Disk Configuration
    EVENT_TRACE_TYPE_CONFIG_NIC = $0D;   // NIC Configuration
    EVENT_TRACE_TYPE_CONFIG_VIDEO = $0E;   // Video Adapter Configuration
    EVENT_TRACE_TYPE_CONFIG_SERVICES = $0F;   // Active Services
    EVENT_TRACE_TYPE_CONFIG_POWER = $10;   // ACPI Configuration
    EVENT_TRACE_TYPE_CONFIG_NETINFO = $11;   // Networking Configuration
    EVENT_TRACE_TYPE_CONFIG_OPTICALMEDIA = $12;   // Optical Media Configuration

    EVENT_TRACE_TYPE_CONFIG_IRQ = $15;    // IRQ assigned to devices
    EVENT_TRACE_TYPE_CONFIG_PNP = $16;    // PnP device info
    EVENT_TRACE_TYPE_CONFIG_IDECHANNEL = $17;    // Primary/Secondary IDE channel Configuration
    EVENT_TRACE_TYPE_CONFIG_NUMANODE = $18;    // Numa configuration
    EVENT_TRACE_TYPE_CONFIG_PLATFORM = $19;    // Platform Configuration
    EVENT_TRACE_TYPE_CONFIG_PROCESSORGROUP = $1A;    // Processor Group Configuration
    EVENT_TRACE_TYPE_CONFIG_PROCESSORNUMBER = $1B;    // ProcessorIndex -> ProcNumber mapping
    EVENT_TRACE_TYPE_CONFIG_DPI = $1C;    // Display DPI Configuration
    EVENT_TRACE_TYPE_CONFIG_CI_INFO = $1D;    // Display System Code Integrity Information
    EVENT_TRACE_TYPE_CONFIG_MACHINEID = $1E;    // SQM Machine Id
    EVENT_TRACE_TYPE_CONFIG_DEFRAG = $1F;    // Logical Disk Defragmenter Information
    EVENT_TRACE_TYPE_CONFIG_MOBILEPLATFORM = $20;    // Mobile Platform Configuration
    EVENT_TRACE_TYPE_CONFIG_DEVICEFAMILY = $21;    // Device Family Information
    EVENT_TRACE_TYPE_CONFIG_FLIGHTID = $22;   // Flights on the machine
    EVENT_TRACE_TYPE_CONFIG_PROCESSOR = $23;   // CentralProcessor records


    // Event types for Optical IO subsystem


    EVENT_TRACE_TYPE_OPTICAL_IO_READ = $37;
    EVENT_TRACE_TYPE_OPTICAL_IO_WRITE = $38;
    EVENT_TRACE_TYPE_OPTICAL_IO_FLUSH = $39;
    EVENT_TRACE_TYPE_OPTICAL_IO_READ_INIT = $3a;
    EVENT_TRACE_TYPE_OPTICAL_IO_WRITE_INIT = $3b;
    EVENT_TRACE_TYPE_OPTICAL_IO_FLUSH_INIT = $3c;


    // Event types for Filter Manager


    EVENT_TRACE_TYPE_FLT_PREOP_INIT = $60;   // Minifilter preop initiation
    EVENT_TRACE_TYPE_FLT_POSTOP_INIT = $61;   // Minifilter postop initiation
    EVENT_TRACE_TYPE_FLT_PREOP_COMPLETION = $62;   // Minifilter preop completion
    EVENT_TRACE_TYPE_FLT_POSTOP_COMPLETION = $63;   // Minifilter postop completion
    EVENT_TRACE_TYPE_FLT_PREOP_FAILURE = $64;   // Minifilter failed preop
    EVENT_TRACE_TYPE_FLT_POSTOP_FAILURE = $65;   // Minifilter failed postop


    // Enable flags for Kernel Events

    EVENT_TRACE_FLAG_PROCESS = $00000001;  // process start & end
    EVENT_TRACE_FLAG_THREAD = $00000002;  // thread start & end
    EVENT_TRACE_FLAG_IMAGE_LOAD = $00000004;  // image load

    EVENT_TRACE_FLAG_DISK_IO = $00000100;  // physical disk IO
    EVENT_TRACE_FLAG_DISK_FILE_IO = $00000200;  // requires disk IO

    EVENT_TRACE_FLAG_MEMORY_PAGE_FAULTS = $00001000;  // all page faults
    EVENT_TRACE_FLAG_MEMORY_HARD_FAULTS = $00002000;  // hard faults only

    EVENT_TRACE_FLAG_NETWORK_TCPIP = $00010000;  // tcpip send & receive

    EVENT_TRACE_FLAG_REGISTRY = $00020000;  // registry calls
    EVENT_TRACE_FLAG_DBGPRINT = $00040000;  // DbgPrint(ex) Calls


    // Enable flags for Kernel Events on Vista and above

    EVENT_TRACE_FLAG_PROCESS_COUNTERS = $00000008;  // process perf counters
    EVENT_TRACE_FLAG_CSWITCH = $00000010;  // context switches
    EVENT_TRACE_FLAG_DPC = $00000020;  // deferred procedure calls
    EVENT_TRACE_FLAG_INTERRUPT = $00000040;  // interrupts
    EVENT_TRACE_FLAG_SYSTEMCALL = $00000080;  // system calls

    EVENT_TRACE_FLAG_DISK_IO_INIT = $00000400;  // physical disk IO initiation
    EVENT_TRACE_FLAG_ALPC = $00100000;  // ALPC traces
    EVENT_TRACE_FLAG_SPLIT_IO = $00200000;  // split io traces (VolumeManager)

    EVENT_TRACE_FLAG_DRIVER = $00800000;  // driver delays
    EVENT_TRACE_FLAG_PROFILE = $01000000;  // sample based profiling
    EVENT_TRACE_FLAG_FILE_IO = $02000000;  // file IO
    EVENT_TRACE_FLAG_FILE_IO_INIT = $04000000;  // file IO initiation


    // Enable flags for Kernel Events on Win7 and above

    EVENT_TRACE_FLAG_DISPATCHER = $00000800;  // scheduler (ReadyThread)
    EVENT_TRACE_FLAG_VIRTUAL_ALLOC = $00004000;  // VM operations


    // Enable flags for Kernel Events on Win8 and above

    EVENT_TRACE_FLAG_VAMAP = $00008000; // map/unmap (excluding images)
    EVENT_TRACE_FLAG_NO_SYSCONFIG = $10000000; // Do not do sys config rundown


    // Enable flags for Kernel Events on Threshold and above

    EVENT_TRACE_FLAG_JOB = $00080000; // job start & end
    EVENT_TRACE_FLAG_DEBUG_EVENTS = $00400000;  // debugger events (break/continue/...)


    // Pre-defined Enable flags for everybody else

    EVENT_TRACE_FLAG_EXTENSION = $80000000;  // Indicates more flags
    EVENT_TRACE_FLAG_FORWARD_WMI = $40000000;  // Can forward to WMI
    EVENT_TRACE_FLAG_ENABLE_RESERVE = $20000000;  // Reserved


    // Logger Mode flags

    EVENT_TRACE_FILE_MODE_NONE = $00000000;  // Logfile is off
    EVENT_TRACE_FILE_MODE_SEQUENTIAL = $00000001;  // Log sequentially
    EVENT_TRACE_FILE_MODE_CIRCULAR = $00000002;  // Log in circular manner
    EVENT_TRACE_FILE_MODE_APPEND = $00000004;  // Append sequential log

    EVENT_TRACE_REAL_TIME_MODE = $00000100;  // Real time mode on
    EVENT_TRACE_DELAY_OPEN_FILE_MODE = $00000200;  // Delay opening file
    EVENT_TRACE_BUFFERING_MODE = $00000400;  // Buffering mode only
    EVENT_TRACE_PRIVATE_LOGGER_MODE = $00000800;  // Process Private Logger
    EVENT_TRACE_ADD_HEADER_MODE = $00001000;  // Add a logfile header

    EVENT_TRACE_USE_GLOBAL_SEQUENCE = $00004000;  // Use global sequence no.
    EVENT_TRACE_USE_LOCAL_SEQUENCE = $00008000;  // Use local sequence no.

    EVENT_TRACE_RELOG_MODE = $00010000;  // Relogger

    EVENT_TRACE_USE_PAGED_MEMORY = $01000000;  // Use pageable buffers


    // Logger Mode flags on XP and above


    EVENT_TRACE_FILE_MODE_NEWFILE = $00000008; // Auto-switch log file
    EVENT_TRACE_FILE_MODE_PREALLOCATE = $00000020;  // Pre-allocate mode


    // Logger Mode flags on Vista and above


    EVENT_TRACE_NONSTOPPABLE_MODE = $00000040;  // Session cannot be stopped (Autologger only)
    EVENT_TRACE_SECURE_MODE = $00000080;  // Secure session
    EVENT_TRACE_USE_KBYTES_FOR_SIZE = $00002000;  // Use KBytes as file size unit
    EVENT_TRACE_PRIVATE_IN_PROC = $00020000;  // In process private logger

    EVENT_TRACE_MODE_RESERVED = $00100000;  // Reserved bit, used to signal Heap/Critsec tracing


    // Logger Mode flags on Win7 and above


    EVENT_TRACE_NO_PER_PROCESSOR_BUFFERING = $10000000;  // Use this for low frequency sessions.


    // Logger Mode flags on Win8 and above


    EVENT_TRACE_SYSTEM_LOGGER_MODE = $02000000;  // Receive events from SystemTraceProvider
    EVENT_TRACE_ADDTO_TRIAGE_DUMP = $80000000;  // Add ETW buffers to triage dumps
    EVENT_TRACE_STOP_ON_HYBRID_SHUTDOWN = $00400000;  // Stop on hybrid shutdown
    EVENT_TRACE_PERSIST_ON_HYBRID_SHUTDOWN = $00800000; // Persist on hybrid shutdown


    // Logger Mode flags on Blue and above


    EVENT_TRACE_INDEPENDENT_SESSION_MODE = $08000000;  // Independent logger session


    // Logger Mode flags on Redstone and above


    EVENT_TRACE_COMPRESSED_MODE = $04000000; // Compressed logger session.


    // ControlTrace Codes


    EVENT_TRACE_CONTROL_QUERY = 0;
    EVENT_TRACE_CONTROL_STOP = 1;
    EVENT_TRACE_CONTROL_UPDATE = 2;


    // Flush ControlTrace Codes for XP and above


    EVENT_TRACE_CONTROL_FLUSH = 3;       // Flushes all the buffers

    EVENT_TRACE_CONTROL_INCREMENT_FILE = 4;       // Causes a session with EVENT_TRACE_FILE_MODE_NEWFILE
    // to switch to the next file before the automatic
    // switching criteria is met


    // Flags used by WMI Trace Message
    // Note that the order or value of these flags should NOT be changed as they are processed
    // in this order.


    TRACE_MESSAGE_SEQUENCE = 1;  // Message should include a sequence number
    TRACE_MESSAGE_GUID = 2;  // Message includes a GUID
    TRACE_MESSAGE_COMPONENTID = 4; // Message has no GUID, Component ID instead
    TRACE_MESSAGE_TIMESTAMP = 8;  // Message includes a timestamp
    TRACE_MESSAGE_PERFORMANCE_TIMESTAMP = 16; // *Obsolete* Clock type is controlled by the logger
    TRACE_MESSAGE_SYSTEMINFO = 32; // Message includes system information TID,PID


    // Vista flags set by system to indicate provider pointer size.


    TRACE_MESSAGE_POINTER32 = $0040;   // Message logged by 32 bit provider
    TRACE_MESSAGE_POINTER64 = $0080;  // Message logged by 64 bit provider

    TRACE_MESSAGE_FLAG_MASK = $FFFF;   // Only the lower 16 bits of flags are placed in the message
    // those above 16 bits are reserved for local processing

    // Maximum size allowed for a single TraceMessage message.

    // N.B. This limit was increased from 8K to 64K in Win8.


    TRACE_MESSAGE_MAXIMUM_SIZE = (64 * 1024);


    // Flags to indicate to consumer which fields
    // in the EVENT_TRACE_HEADER are valid


    EVENT_TRACE_USE_PROCTIME = $0001;    // ProcessorTime field is valid
    EVENT_TRACE_USE_NOCPUTIME = $0002;    // No Kernel/User/Processor Times


    // TRACE_HEADER_FLAG values are used in the Flags field of EVENT_TRACE_HEADER
    // structure while calling into TraceEvent API


    TRACE_HEADER_FLAG_USE_TIMESTAMP = $00000200;
    TRACE_HEADER_FLAG_TRACED_GUID = $00020000; // denotes a trace
    TRACE_HEADER_FLAG_LOG_WNODE = $00040000; // request to log Wnode
    TRACE_HEADER_FLAG_USE_GUID_PTR = $00080000; // Guid is actually a pointer
    TRACE_HEADER_FLAG_USE_MOF_PTR = $00100000; // MOF data are dereferenced



    // Following are structures and macros for use with USE_MOF_PTR


    // Trace data types
    ETW_NULL_TYPE_VALUE = 0;
    ETW_OBJECT_TYPE_VALUE = 1;
    ETW_STRING_TYPE_VALUE = 2;
    ETW_SBYTE_TYPE_VALUE = 3;
    ETW_BYTE_TYPE_VALUE = 4;
    ETW_INT16_TYPE_VALUE = 5;
    ETW_UINT16_TYPE_VALUE = 6;
    ETW_INT32_TYPE_VALUE = 7;
    ETW_UINT32_TYPE_VALUE = 8;
    ETW_INT64_TYPE_VALUE = 9;
    ETW_UINT64_TYPE_VALUE = 10;
    ETW_CHAR_TYPE_VALUE = 11;
    ETW_SINGLE_TYPE_VALUE = 12;
    ETW_DOUBLE_TYPE_VALUE = 13;
    ETW_BOOLEAN_TYPE_VALUE = 14;
    ETW_DECIMAL_TYPE_VALUE = 15;
    // Extended types
    ETW_GUID_TYPE_VALUE = 101;
    ETW_ASCIICHAR_TYPE_VALUE = 102;
    ETW_ASCIISTRING_TYPE_VALUE = 103;
    ETW_COUNTED_STRING_TYPE_VALUE = 104;
    ETW_POINTER_TYPE_VALUE = 105;
    ETW_SIZET_TYPE_VALUE = 106;
    ETW_HIDDEN_TYPE_VALUE = 107;
    ETW_BOOL_TYPE_VALUE = 108;
    ETW_COUNTED_ANSISTRING_TYPE_VALUE = 109;
    ETW_REVERSED_COUNTED_STRING_TYPE_VALUE = 110;
    ETW_REVERSED_COUNTED_ANSISTRING_TYPE_VALUE = 111;
    ETW_NON_NULL_TERMINATED_STRING_TYPE_VALUE = 112;
    ETW_REDUCED_ANSISTRING_TYPE_VALUE = 113;
    ETW_REDUCED_STRING_TYPE_VALUE = 114;
    ETW_SID_TYPE_VALUE = 115;
    ETW_VARIANT_TYPE_VALUE = 116;
    ETW_PTVECTOR_TYPE_VALUE = 117;
    ETW_WMITIME_TYPE_VALUE = 118;
    ETW_DATETIME_TYPE_VALUE = 119;
    ETW_REFRENCE_TYPE_VALUE = 120;

type

    TTRACEHANDLE = ULONG64;
    PTRACEHANDLE = ^TTRACEHANDLE;

    TETW_COMPRESSION_RESUMPTION_MODE = (
        EtwCompressionModeRestart = 0,
        EtwCompressionModeNoDisable = 1,
        EtwCompressionModeNoRestart = 2);


    // Trace header for all legacy events.
    {$IFNDEF FPC}
    ULONG64 = UInt64;
    {$ENDIF}

    TEVENT_TRACE_HEADER = record        // overlays WNODE_HEADER
        Size: USHORT;      // Size of entire record
        DUMMYUNIONNAME: record
            case integer of
                0: (FieldTypeFlags: USHORT); // Indicates valid fields
                1: (HeaderType: UCHAR;       // Header type - internal use only
                    MarkerFlags: UCHAR);     // Marker - internal use only
        end;
        DUMMYUNIONNAME2: record
            case integer of
                0: (Version: ULONG);
                1: (_Type: UCHAR;            // event type
                    Level: UCHAR;            // trace instrumentation level
                    _Version: USHORT);       // version of trace record
        end;
        ThreadId: ULONG;                     // Thread Id
        ProcessId: ULONG;                    // Process Id
        TimeStamp: LARGE_INTEGER;            // time when event happens
        DUMMYUNIONNAME3: record
            case integer of
                0: (Guid: TGUID);                   // Guid that identifies event
                1: (GuidPtr: ULONGLONG);                // use with WNODE_FLAG_USE_GUID_PTR

        end;
        DUMMYUNIONNAME4: record
            case integer of
                0: (KernelTime: ULONG;                 // Kernel Mode CPU ticks
                    UserTime: ULONG);                  // User mode CPU ticks
                1: (ProcessorTime: ULONG64);           // Processor Clock
                2: (ClientContext: ULONG;              // Reserved
                    Flags: ULONG);                     // Event Flags
        end;
    end;

    PEVENT_TRACE_HEADER = ^TEVENT_TRACE_HEADER;


implementation

end.
