unit CMC.EVNTrace;

{$IFDEF FPC}
{$mode delphi}
{$ENDIF}

interface

uses
    Windows, Classes, SysUtils;

type

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
