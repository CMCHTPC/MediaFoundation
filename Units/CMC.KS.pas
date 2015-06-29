(* ++

  Copyright (c) Microsoft Corporation. All rights reserved.

  Module Name:

  ks.h

  Abstract:

  Windows Driver Model/Connection and Streaming Architecture (WDM-CSA)
  core definitions.
  -- *)

unit CMC.KS;

interface

uses
    Windows;

const
    _KS_NO_ANONYMOUS_STRUCTURES_ = 1;

const
    KSPRIORITY_LOW = $00000001;
    KSPRIORITY_NORMAL = $40000000;
    KSPRIORITY_HIGH = $80000000;
    KSPRIORITY_EXCLUSIVE = $FFFFFFFF;

    KSMETHOD_TYPE_NONE = $00000000;
    KSMETHOD_TYPE_READ = $00000001;
    KSMETHOD_TYPE_WRITE = $00000002;
    KSMETHOD_TYPE_MODIFY = $00000003;
    KSMETHOD_TYPE_SOURCE = $00000004;

    KSMETHOD_TYPE_SEND = $00000001;
    KSMETHOD_TYPE_SETSUPPORT = $00000100;
    KSMETHOD_TYPE_BASICSUPPORT = $00000200;

    KSMETHOD_TYPE_TOPOLOGY = $10000000;

    KSPROPERTY_TYPE_GET = $00000001;
    KSPROPERTY_TYPE_SET = $00000002;
    KSPROPERTY_TYPE_SETSUPPORT = $00000100;
    KSPROPERTY_TYPE_BASICSUPPORT = $00000200;
    KSPROPERTY_TYPE_RELATIONS = $00000400;
    KSPROPERTY_TYPE_SERIALIZESET = $00000800;
    KSPROPERTY_TYPE_UNSERIALIZESET = $00001000;
    KSPROPERTY_TYPE_SERIALIZERAW = $00002000;
    KSPROPERTY_TYPE_UNSERIALIZERAW = $00004000;
    KSPROPERTY_TYPE_SERIALIZESIZE = $00008000;
    KSPROPERTY_TYPE_DEFAULTVALUES = $00010000;

    KSPROPERTY_TYPE_TOPOLOGY = $10000000;
    KSPROPERTY_TYPE_HIGHPRIORITY = $08000000;
    KSPROPERTY_TYPE_COPYPAYLOAD = $80000000;

    KSPROPERTY_MEMBER_RANGES = $00000001;
    KSPROPERTY_MEMBER_STEPPEDRANGES = $00000002;
    KSPROPERTY_MEMBER_VALUES = $00000003;

    KSPROPERTY_MEMBER_FLAG_DEFAULT = $00000001;

    KSPROPERTY_MEMBER_FLAG_BASICSUPPORT_MULTICHANNEL = $00000002;
    KSPROPERTY_MEMBER_FLAG_BASICSUPPORT_UNIFORM = $00000004;

    KSEVENTF_EVENT_HANDLE = $00000001;
    KSEVENTF_SEMAPHORE_HANDLE = $00000002;

    KSEVENTF_EVENT_OBJECT = $00000004;
    KSEVENTF_SEMAPHORE_OBJECT = $00000008;
    KSEVENTF_DPC = $00000010;
    KSEVENTF_WORKITEM = $00000020;
    KSEVENTF_KSWORKITEM = $00000080;

    KSEVENT_TYPE_ENABLE = $00000001;
    KSEVENT_TYPE_ONESHOT = $00000002;
    KSEVENT_TYPE_ENABLEBUFFERED = $00000004;
    KSEVENT_TYPE_SETSUPPORT = $00000100;
    KSEVENT_TYPE_BASICSUPPORT = $00000200;
    KSEVENT_TYPE_QUERYBUFFER = $00000400;

    KSEVENT_TYPE_TOPOLOGY = $10000000;

type
    TKSRESET = (KSRESET_BEGIN, KSRESET_END);

    TKSSTATE = (KSSTATE_STOP, KSSTATE_ACQUIRE, KSSTATE_PAUSE, KSSTATE_RUN);
    PKSSTATE = ^TKSSTATE;

    TKSPRIORITY = record
        PriorityClass: ULONG;
        PrioritySubClass: ULONG;
    end;

    PKSPRIORITY = ^TKSPRIORITY;

    TKSIDENTIFIER = record
        case Integer of
            0:
                (_IDENTIFIER: record _Set: TGUID;
                    Id: ULONG;
                    Flags: ULONG;
                    end);
            1:
                (Alignment: LONGLONG);

    end;

    PKSIDENTIFIER = ^TKSIDENTIFIER;

    TKSPROPERTY = TKSIDENTIFIER;
    PKSPROPERTY = ^TKSPROPERTY;

    TKSMETHOD = TKSIDENTIFIER;
    PKSMETHOD = ^TKSMETHOD;

    TKSEVENT = TKSIDENTIFIER;
    PKSEVENT = ^TKSEVENT;

    TKSP_NODE = record
        _Property: TKSPROPERTY;
        NodeId: ULONG;
        Reserved: ULONG;
    end;

    PKSP_NODE = ^TKSP_NODE;

    TKSM_NODE = record
        Method: TKSMETHOD;
        NodeId: ULONG;
        Reserved: ULONG;
    end;

    PKSM_NODE = ^TKSM_NODE;

    TKSE_NODE = record
        Event: TKSEVENT;
        NodeId: ULONG;
        Reserved: ULONG;
    end;

    PKSE_NODE = ^TKSE_NODE;

    TKSMULTIPLE_ITEM = record
        Size: ULONG;
        Count: ULONG;
    end;

    PKSMULTIPLE_ITEM = ^TKSMULTIPLE_ITEM;

    TKSPROPERTY_DESCRIPTION = record
        AccessFlags: ULONG;
        DescriptionSize: ULONG;
        PropTypeSet: TKSIDENTIFIER;
        MembersListCount: ULONG;
        Reserved: ULONG;
    end;

    PKSPROPERTY_DESCRIPTION = ^TKSPROPERTY_DESCRIPTION;

    TKSPROPERTY_MEMBERSHEADER = record
        MembersFlags: ULONG;
        MembersSize: ULONG;
        MembersCount: ULONG;
        Flags: ULONG;
    end;

    PKSPROPERTY_MEMBERSHEADER = ^TKSPROPERTY_MEMBERSHEADER;

    TKSPROPERTY_BOUNDS_LONG = record
        case Integer of
            0:
                (_SIGNED: record SignedMinimum: LONGINT;
                    SignedMaximum: LONGINT;
                    end; );
            1:
                (_UNSIGNED: record UnsignedMinimum: ULONG;
                    UnsignedMaximum: ULONG;
                    end)
    end;

    PKSPROPERTY_BOUNDS_LONG = ^TKSPROPERTY_BOUNDS_LONG;

    TKSPROPERTY_BOUNDS_LONGLONG = record
        case Integer of
            0:
                (SIGNED64: record SignedMinimum: LONGLONG;
                    SignedMaximum: LONGLONG;
                    end);
            1:
                (_UNSIGNED64: record
{$IFDEF _NTDDK_}
                    UnsignedMinimum: ULONGLONG;
                    UnsignedMaximum: ULONGLONG;
{$ELSE}
                    UnsignedMinimum: DWORDLONG;
                    UnsignedMaximum: DWORDLONG;
{$ENDIF}
                    end);
    end;

    PKSPROPERTY_BOUNDS_LONGLONG = ^TKSPROPERTY_BOUNDS_LONGLONG;

    TKSPROPERTY_STEPPING_LONG = record
        SteppingDelta: ULONG;
        Reserved: ULONG;
        Bounds: TKSPROPERTY_BOUNDS_LONG;
    end;

    PKSPROPERTY_STEPPING_LONG = ^TKSPROPERTY_STEPPING_LONG;

    TKSPROPERTY_STEPPING_LONGLONG = record
{$IFDEF _NTDDK_}
        SteppingDelta: ULONGLONG;
{$ELSE}
        SteppingDelta: DWORDLONG;
{$ENDIF}
        Bounds: TKSPROPERTY_BOUNDS_LONGLONG;
    end;

    PKSPROPERTY_STEPPING_LONGLONG = ^TKSPROPERTY_STEPPING_LONGLONG;

    PKSWORKER = pointer;


    TKSDATAFORMAT=record
        // todo
    end;

    TWAVEFORMATEX= record
        // todo
    end;

implementation

end.
