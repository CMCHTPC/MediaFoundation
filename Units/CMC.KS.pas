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
    Windows, Win32.DEVIOCTL;

const
    _KS_NO_ANONYMOUS_STRUCTURES_ = 1;

const
    STATIC_GUID_NULL: TGUID = '{00000000-0000-0000-0000-000000000000}';
    GUID_NULL: TGUID = '{00000000-0000-0000-0000-000000000000}';

    // : TGUID ='{}';
    KSPROPTYPESETID_General: TGUID = '{97E99BA0-BDEA-11CF-A5D6-28DB04C10000}';

    KSPROPSETID_General: TGUID = '{1464EDA5-6A8F-11D1-9AA7-00A0C9223196}';
    KSMETHODSETID_StreamIo: TGUID = '{65D003CA-1523-11D2-B27A-00A0C9223196}';
    KSPROPSETID_MediaSeeking: TGUID = '{EE904F0C-D09B-11D0-ABE9-00A0C9223196}';
    KSPROPSETID_Topology: TGUID = '{720D4AC0-7533-11D0-A5D6-28DB04C10000}';
    // properties used by graph manager to talk to particular filters
    KSPROPSETID_GM: TGUID = '{AF627536-E719-11D2-8A1D-006097D2DF5D}';

    KSCATEGORY_BRIDGE: TGUID = '{085AFF00-62CE-11CF-A5D6-28DB04C10000}';
    KSCATEGORY_CAPTURE: TGUID = '{65E8773D-8F56-11D0-A3B9-00A0C9223196}';
    KSCATEGORY_VIDEO_CAMERA: TGUID = '{E5323777-F976-4f5b-9B55-B94699C46E44}';
    KSCATEGORY_SENSOR_CAMERA: TGUID = '{24E552D7-6523-47F7-A647-D3465BF1F5CA}';
    KSCATEGORY_SENSOR_GROUP: TGUID = '{669C7214-0A88-4311-A7F3-4E79820E33BD}';
    KSCATEGORY_RENDER: TGUID = '{65E8773E-8F56-11D0-A3B9-00A0C9223196}';
    KSCATEGORY_MIXER: TGUID = '{AD809C00-7B88-11D0-A5D6-28DB04C10000}';
    KSCATEGORY_SPLITTER: TGUID = '{0A4252A0-7E70-11D0-A5D6-28DB04C10000}';
    KSCATEGORY_DATACOMPRESSOR: TGUID =
        '{1E84C900-7E70-11D0-A5D6-28DB04C10000}';
    KSCATEGORY_DATADECOMPRESSOR: TGUID =
        '{2721AE20-7E70-11D0-A5D6-28DB04C10000}';
    KSCATEGORY_DATATRANSFORM: TGUID = '{2EB07EA0-7E70-11D0-A5D6-28DB04C10000}';

    // KSMFT_CATEGORY_XXX are MF Transform category guids redefined in ks.h
    // to facilitate KS Mini drivers to register KS Filters under MF Transform categories.
    KSMFT_CATEGORY_VIDEO_DECODER: TGUID =
        '{d6c02d4b-6833-45b4-971a-05a4b04bab91}';
    KSMFT_CATEGORY_VIDEO_ENCODER: TGUID =
        '{f79eac7d-e545-4387-bdee-d647d7bde42a}';
    KSMFT_CATEGORY_VIDEO_EFFECT: TGUID =
        '{12e17c21-532c-4a6e-8a1c-40825a736397}';
    KSMFT_CATEGORY_MULTIPLEXER: TGUID =
        '{059c561e-05ae-4b61-b69d-55b61ee54a7b}';
    KSMFT_CATEGORY_DEMULTIPLEXER: TGUID =
        '{a8700a7a-939b-44c5-99d7-76226b23b3f1}';
    KSMFT_CATEGORY_AUDIO_DECODER: TGUID =
        '{9ea73fb4-ef7a-4559-8d5d-719d8f0426c7}';
    KSMFT_CATEGORY_AUDIO_ENCODER: TGUID =
        '{91c64bd0-f91e-4d8c-9276-db248279d975}';
    KSMFT_CATEGORY_AUDIO_EFFECT: TGUID =
        '{11064c48-3648-4ed0-932e-05ce8ac811b7}';
    KSMFT_CATEGORY_VIDEO_PROCESSOR: TGUID =
        '{302ea3fc-aa5f-47f9-9f7a-c2188bb16302}';
    KSMFT_CATEGORY_OTHER: TGUID = '{90175d57-b7ea-4901-aeb3-933a8747756f}';
    KSCATEGORY_COMMUNICATIONSTRANSFORM: TGUID =
        '{CF1DDA2C-9743-11D0-A3EE-00A0C9223196}';
    KSCATEGORY_INTERFACETRANSFORM: TGUID =
        '{CF1DDA2D-9743-11D0-A3EE-00A0C9223196}';
    KSCATEGORY_MEDIUMTRANSFORM: TGUID =
        '{CF1DDA2E-9743-11D0-A3EE-00A0C9223196}';
    KSCATEGORY_FILESYSTEM: TGUID = '{760FED5E-9357-11D0-A3CC-00A0C9223196}';
    // KSNAME_Clock
    KSCATEGORY_CLOCK: TGUID = '{53172480-4791-11D0-A5D6-28DB04C10000}';
    KSCATEGORY_PROXY: TGUID = '{97EBAACA-95BD-11D0-A3EA-00A0C9223196}';
    KSCATEGORY_QUALITY: TGUID = '{97EBAACB-95BD-11D0-A3EA-00A0C9223196}';

    // TIME_FORMAT_FRAME
    KSTIME_FORMAT_FRAME: TGUID = '{7b785570-8c82-11cf-bc0c-00aa00ac74f6}';

    // TIME_FORMAT_BYTE
    KSTIME_FORMAT_BYTE: TGUID = '{7b785571-8c82-11cf-bc0c-00aa00ac74f6}';

    // TIME_FORMAT_SAMPLE
    KSTIME_FORMAT_SAMPLE: TGUID = '{7b785572-8c82-11cf-bc0c-00aa00ac74f6}';

    // TIME_FORMAT_FIELD
    KSTIME_FORMAT_FIELD: TGUID = '{7b785573-8c82-11cf-bc0c-00aa00ac74f6}';

    // TIME_FORMAT_MEDIA_TIME
    KSTIME_FORMAT_MEDIA_TIME: TGUID = '{7b785574-8c82-11cf-bc0c-00aa00ac74f6}';

    KSINTERFACESETID_Standard: TGUID =
        '{1A8766A0-62CE-11CF-A5D6-28DB04C10000}';
    KSINTERFACESETID_FileIo: TGUID = '{8C6F932C-E771-11D0-B8FF-00A0C9223196}';
    KSMEDIUMSETID_Standard: TGUID = '{4747B320-62CE-11CF-A5D6-28DB04C10000}';
    KSPROPSETID_Pin: TGUID = '{8C134960-51AD-11CF-878A-94F801C10000}';

    KSEVENTSETID_PinCapsChange: TGUID =
        '{DD4F192E-3B78-49AD-A534-2C315B822000}';
    KSEVENTSETID_VolumeLimit: TGUID = '{DA168465-3A7C-4858-9D4A-3E8E24701AEF}';
    KSNAME_Filter: TGUID = '{9b365890-165f-11d0-a195-0020afd156e4}';
    KSNAME_Pin: TGUID = '{146F1A80-4791-11D0-A5D6-28DB04C10000}';
    KSNAME_Clock: TGUID = '{53172480-4791-11D0-A5D6-28DB04C10000}';
    KSNAME_Allocator: TGUID = '{642F5D00-4791-11D0-A5D6-28DB04C10000}';
    KSNAME_AllocatorEx: TGUID = '{091BB63B-603F-11D1-B067-00A0C9062802}';
    KSNAME_TopologyNode: TGUID = '{0621061A-EE75-11D0-B915-00A0C9223196}';

    // MEDIATYPE_NULL
    KSDATAFORMAT_TYPE_WILDCARD: TGUID =
        '{00000000-0000-0000-0000-000000000000}';

    // MEDIASUBTYPE_NULL
    KSDATAFORMAT_SUBTYPE_WILDCARD: TGUID =
        '{00000000-0000-0000-0000-000000000000}';

    // MEDIATYPE_Stream
    KSDATAFORMAT_TYPE_STREAM: TGUID = '{E436EB83-524F-11CE-9F53-0020AF0BA770}';


    // MEDIASUBTYPE_None
    KSDATAFORMAT_SUBTYPE_NONE: TGUID =
        '{E436EB8E-524F-11CE-9F53-0020AF0BA770}';
    KSDATAFORMAT_SPECIFIER_WILDCARD: TGUID =
        '{00000000-0000-0000-0000-000000000000}';
    KSDATAFORMAT_SPECIFIER_FILENAME: TGUID =
        '{AA797B40-E974-11CF-A5D6-28DB04C10000}';
    KSDATAFORMAT_SPECIFIER_FILEHANDLE: TGUID =
        '{65E8773C-8F56-11D0-A3B9-00A0C9223196}';


    // FORMAT_None
    KSDATAFORMAT_SPECIFIER_NONE: TGUID =
        '{0F6417D6-C318-11D0-A43F-00A0C9223196}';

    KSPROPSETID_Quality: TGUID = '{D16AD380-AC1A-11CF-A5D6-28DB04C10000}';

    // TIME_FORMAT_NONE
    KSTIME_FORMAT_NONE: TGUID = '{00000000-0000-0000-0000-000000000000}';


    // define memory type GUIDs

    KSMEMORY_TYPE_WILDCARD: TGUID = '{00000000-0000-0000-0000-000000000000}';
    KSMEMORY_TYPE_DONT_CARE: TGUID = '{00000000-0000-0000-0000-000000000000}';
    KS_TYPE_DONT_CARE: TGUID = '{00000000-0000-0000-0000-000000000000}';
    KSMEMORY_TYPE_SYSTEM: TGUID = '{091bb638-603f-11d1-b067-00a0c9062802}';
    KSMEMORY_TYPE_USER: TGUID = '{8cb0fc28-7893-11d1-b069-00a0c9062802}';
    KSMEMORY_TYPE_KERNEL_PAGED: TGUID =
        '{d833f8f8-7894-11d1-b069-00a0c9062802}';
    KSMEMORY_TYPE_KERNEL_NONPAGED: TGUID =
        '{4a6d5fc4-7895-11d1-b069-00a0c9062802}';

    // old KS clients did not specify the device memory type
    KSMEMORY_TYPE_DEVICE_UNKNOWN: TGUID =
        '{091bb639-603f-11d1-b067-00a0c9062802}';

    // KSEVENTSETID_StreamAllocator: {75D95571-073C-11d0-A161-0020AFD156E4}
    KSEVENTSETID_StreamAllocator: TGUID =
        '{75d95571-073c-11d0-a161-0020afd156e4}';
    KSMETHODSETID_StreamAllocator: TGUID =
        '{cf6e4341-ec87-11cf-a130-0020afd156e4}';

    KSPROPSETID_StreamAllocator: TGUID =
        '{cf6e4342-ec87-11cf-a130-0020afd156e4}';

    KSPROPSETID_StreamInterface: TGUID =
        '{1fdd8ee1-9cd3-11d0-82aa-0000f822fe8a}';
    KSPROPSETID_Stream: TGUID = '{65aaba60-98ae-11cf-a10d-0020afd156e4}';

    KSPROPSETID_PinMDLCacheClearProp: TGUID =
        '{BD718A7B-97FC-40C7-88CE-D3FF06F55B16}';

    KSPROPSETID_Clock: TGUID = '{DF12A4C0-AC17-11CF-A5D6-28DB04C10000}';

    KSEVENTSETID_Clock: TGUID = '{364D8E20-62C7-11CF-A5D6-28DB04C10000}';
    KSEVENTSETID_Connection: TGUID = '{7f4bcbe0-9ea5-11cf-a5d6-28db04c10000}';
    KSEVENTSETID_Device: TGUID = '{288296EC-9F94-41b4-A153-AA31AEECB33F}';
    KSDEGRADESETID_Standard: TGUID = '{9F564180-704C-11D0-A5D6-28DB04C10000}';



    IOCTL_KS_PROPERTY =
        (FILE_DEVICE_KS shl 16) or ($000 shl 14) or
        (METHOD_NEITHER shl 2) or FILE_ANY_ACCESS;

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
    KSPROPERTY_TYPE_FSFILTERSCOPE = $40000000;
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

    KSRELATIVEEVENT_FLAG_HANDLE = $00000001;
    KSRELATIVEEVENT_FLAG_POINTER = $00000002;

    KSFILTER_NODE = ULONG(-1);
    KSALL_NODES = ULONG(-1);

    KSMEDIUM_TYPE_ANYINSTANCE = 0;
    //For compatibility only
    KSMEDIUM_STANDARD_DEVIO = KSMEDIUM_TYPE_ANYINSTANCE;

    KSPROPERTY_PIN_FLAGS_ATTRIBUTE_RANGE_AWARE = $00000001;
    KSPROPERTY_PIN_FLAGS_MASK = KSPROPERTY_PIN_FLAGS_ATTRIBUTE_RANGE_AWARE;

    KSINSTANCE_INDETERMINATE = ULONG(-1);


    KSDATAFORMAT_BIT_TEMPORAL_COMPRESSION = 0;
    KSDATAFORMAT_TEMPORAL_COMPRESSION =
        (1 shl KSDATAFORMAT_BIT_TEMPORAL_COMPRESSION);
    KSDATAFORMAT_BIT_ATTRIBUTES = 1;
    KSDATAFORMAT_ATTRIBUTES = (1 shl KSDATAFORMAT_BIT_ATTRIBUTES);

    KSDATARANGE_BIT_ATTRIBUTES = 1;
    KSDATARANGE_ATTRIBUTES = (1 shl KSDATARANGE_BIT_ATTRIBUTES);
    KSDATARANGE_BIT_REQUIRED_ATTRIBUTES = 2;
    KSDATARANGE_REQUIRED_ATTRIBUTES =
        (1 shl KSDATARANGE_BIT_REQUIRED_ATTRIBUTES);

    KSATTRIBUTE_REQUIRED = $00000001;

    KSSTRING_Filter: WideString = '{9B365890-165F-11D0-A195-0020AFD156E4}';
    KSSTRING_Pin: WideString = '{146F1A80-4791-11D0-A5D6-28DB04C10000}';
    KSSTRING_Clock: WideString = '{53172480-4791-11D0-A5D6-28DB04C10000}';
    KSSTRING_Allocator: WideString = '{642F5D00-4791-11D0-A5D6-28DB04C10000}';
    KSSTRING_AllocatorEx: WideString =
        '{091BB63B-603F-11D1-B067-00A0C9062802}';
    KSSTRING_TopologyNode: WideString =
        '{0621061A-EE75-11D0-B915-00A0C9223196}';
    KSPROPSETID_Connection: TGUID = '{1D58C920-AC9B-11CF-A5D6-28DB04C10000}';
    KSPROPSETID_MemoryTransport: TGUID =
        '{0A3D1C5D-5243-4819-9ED0-AEE8044CEE2B}';

    // a value of zero is ignored
    KSPROPERTY_MEMORY_TRANSPORT = 1;
    //Sets pin's memory transport mechanism e.g. VRAM or SYSMEM


    //===========================================================================

    // pins flags

    KSALLOCATOR_REQUIREMENTF_INPLACE_MODIFIER = $00000001;
    KSALLOCATOR_REQUIREMENTF_SYSTEM_MEMORY = $00000002;
    KSALLOCATOR_REQUIREMENTF_FRAME_INTEGRITY = $00000004;
    KSALLOCATOR_REQUIREMENTF_MUST_ALLOCATE = $00000008;
    KSALLOCATOR_REQUIREMENTF_SYSTEM_MEMORY_CUSTOM_ALLOCATION =
        $00000010;
    KSALLOCATOR_REQUIREMENTF_PREFERENCES_ONLY =
        $80000000;

    KSALLOCATOR_OPTIONF_COMPATIBLE = $00000001;
    KSALLOCATOR_OPTIONF_SYSTEM_MEMORY = $00000002;
    KSALLOCATOR_OPTIONF_VALID = $00000003;

    // pins extended framing flags

    KSALLOCATOR_FLAG_PARTIAL_READ_SUPPORT = $00000010;
    KSALLOCATOR_FLAG_DEVICE_SPECIFIC = $00000020;
    KSALLOCATOR_FLAG_CAN_ALLOCATE = $00000040;
    KSALLOCATOR_FLAG_INSIST_ON_FRAMESIZE_RATIO = $00000080;


    // allocator pipes flags

    // there is at least one data modification in a pipe
    KSALLOCATOR_FLAG_NO_FRAME_INTEGRITY = $00000100;
    KSALLOCATOR_FLAG_MULTIPLE_OUTPUT = $00000200;
    KSALLOCATOR_FLAG_CYCLE = $00000400;
    KSALLOCATOR_FLAG_ALLOCATOR_EXISTS = $00000800;
    // there is no framing dependency between neighbouring pipes.
    KSALLOCATOR_FLAG_INDEPENDENT_RANGES = $00001000;
    KSALLOCATOR_FLAG_ATTENTION_STEPPING = $00002000;


    KSALLOCATOR_FLAG_ENABLE_CACHED_MDL = $00004000;
    KSALLOCATOR_FLAG_2D_BUFFER_REQUIRED = $00008000;




    KSSTREAM_HEADER_OPTIONSF_SPLICEPOINT = $00000001;
    KSSTREAM_HEADER_OPTIONSF_PREROLL = $00000002;
    KSSTREAM_HEADER_OPTIONSF_DATADISCONTINUITY = $00000004;
    KSSTREAM_HEADER_OPTIONSF_TYPECHANGED = $00000008;
    KSSTREAM_HEADER_OPTIONSF_TIMEVALID = $00000010;
    KSSTREAM_HEADER_OPTIONSF_TIMEDISCONTINUITY = $00000040;
    KSSTREAM_HEADER_OPTIONSF_FLUSHONPAUSE = $00000080;
    KSSTREAM_HEADER_OPTIONSF_DURATIONVALID = $00000100;
    KSSTREAM_HEADER_OPTIONSF_ENDOFSTREAM = $00000200;
    KSSTREAM_HEADER_OPTIONSF_BUFFEREDTRANSFER = $00000400;
    KSSTREAM_HEADER_OPTIONSF_VRAM_DATA_TRANSFER = $00000800;
    KSSTREAM_HEADER_OPTIONSF_METADATA = $00001000;
    KSSTREAM_HEADER_OPTIONSF_ENDOFPHOTOSEQUENCE = $00002000;
    KSSTREAM_HEADER_OPTIONSF_FRAMEINFO = $00004000;

    //Start of MDL caching related definitions

    KSSTREAM_HEADER_OPTIONSF_PERSIST_SAMPLE = $00008000;
    KSSTREAM_HEADER_OPTIONSF_SAMPLE_PERSISTED = $00010000;


    // This flag tells the user mode to look at frame completion numbers

    KSSTREAM_HEADER_TRACK_COMPLETION_NUMBERS = $00020000;


    //End of MDL caching related definitions
    KSSTREAM_HEADER_OPTIONSF_SECUREBUFFERTRANSFER = $00040000;
    KSSTREAM_HEADER_OPTIONSF_LOOPEDDATA = $80000000;


    KSSTREAM_UVC_SECURE_ATTRIBUTE_SIZE = ($2000);

    KSFRAMETIME_VARIABLESIZE = $00000001;

    KSRATE_NOPRESENTATIONSTART = $00000001;
    KSRATE_NOPRESENTATIONDURATION = $00000002;

    NANOSECONDS = 10000000;

    KSPROBE_STREAMREAD = $00000000;
    KSPROBE_STREAMWRITE = $00000001;
    KSPROBE_ALLOCATEMDL = $00000010;
    KSPROBE_PROBEANDLOCK = $00000020;
    KSPROBE_SYSTEMADDRESS = $00000040;
    KSPROBE_MODIFY = $00000200;
    KSPROBE_STREAMWRITEMODIFY = (KSPROBE_MODIFY or KSPROBE_STREAMWRITE);
    KSPROBE_ALLOWFORMATCHANGE = $00000080;

    KSSTREAM_READ = KSPROBE_STREAMREAD;
    KSSTREAM_WRITE = KSPROBE_STREAMWRITE;
    KSSTREAM_PAGED_DATA = $00000000;
    KSSTREAM_NONPAGED_DATA = $00000100;
    KSSTREAM_SYNCHRONOUS = $00001000;
    KSSTREAM_FAILUREEXCEPTION = $00002000;



type

    NTSTATUS = LONG;

    TKSRESET = (KSRESET_BEGIN, KSRESET_END);

    TKSSTATE = (KSSTATE_STOP, KSSTATE_ACQUIRE, KSSTATE_PAUSE, KSSTATE_RUN);
    PKSSTATE = ^TKSSTATE;

    TKSPRIORITY = record
        PriorityClass: ULONG;
        PrioritySubClass: ULONG;
    end;

    PKSPRIORITY = ^TKSPRIORITY;

    TKSIDENTIFIER = record
        case integer of
            0: (_IDENTIFIER: record
                    _Set: TGUID;
                    Id: ULONG;
                    Flags: ULONG;
                end);
            1: (Alignment: LONGLONG);

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

    TVARENUM = (
        VT_EMPTY = 0,
        VT_NULL = 1,
        VT_I2 = 2,
        VT_I4 = 3,
        VT_R4 = 4,
        VT_R8 = 5,
        VT_CY = 6,
        VT_DATE = 7,
        VT_BSTR = 8,
        VT_DISPATCH = 9,
        VT_ERROR = 10,
        VT_BOOL = 11,
        VT_VARIANT = 12,
        VT_UNKNOWN = 13,
        VT_DECIMAL = 14,
        VT_I1 = 16,
        VT_UI1 = 17,
        VT_UI2 = 18,
        VT_UI4 = 19,
        VT_I8 = 20,
        VT_UI8 = 21,
        VT_INT = 22,
        VT_UINT = 23,
        VT_VOID = 24,
        VT_HRESULT = 25,
        VT_PTR = 26,
        VT_SAFEARRAY = 27,
        VT_CARRAY = 28,
        VT_USERDEFINED = 29,
        VT_LPSTR = 30,
        VT_LPWSTR = 31,
        VT_FILETIME = 64,
        VT_BLOB = 65,
        VT_STREAM = 66,
        VT_STORAGE = 67,
        VT_STREAMED_OBJECT = 68,
        VT_STORED_OBJECT = 69,
        VT_BLOB_OBJECT = 70,
        VT_CF = 71,
        VT_CLSID = 72,
        VT_VECTOR = $1000,
        VT_ARRAY = $2000,
        VT_BYREF = $4000,
        VT_RESERVED = $8000,
        VT_ILLEGAL = $ffff,
        VT_ILLEGALMASKED = $fff,
        VT_TYPEMASK = $fff);


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
        case integer of
            0: (_SIGNED: record
                    SignedMinimum: longint;
                    SignedMaximum: longint;
                end;);
            1: (_UNSIGNED: record
                    UnsignedMinimum: ULONG;
                    UnsignedMaximum: ULONG;
                end)
    end;

    PKSPROPERTY_BOUNDS_LONG = ^TKSPROPERTY_BOUNDS_LONG;


    TKSPROPERTY_BOUNDS_LONGLONG = record
        case integer of
            0: (SIGNED64: record
                    SignedMinimum: LONGLONG;
                    SignedMaximum: LONGLONG;
                end);
            1: (_UNSIGNED64: record
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




    // Structure forward declarations.

    PKSDEVICE_DESCRIPTOR = ^TKSDEVICE_DESCRIPTOR;
    PKSDEVICE_DISPATCH = ^TKSDEVICE_DISPATCH;
    PKSDEVICE = ^TKSDEVICE;
    PKSFILTERFACTORY = ^TKSFILTERFACTORY;
    PKSFILTER_DESCRIPTOR = ^TKSFILTER_DESCRIPTOR;
    PKSFILTER_DISPATCH = ^TKSFILTER_DISPATCH;
    PKSFILTER = ^TKSFILTER;
    PKSPIN_DESCRIPTOR_EX = ^TKSPIN_DESCRIPTOR_EX;
    PKSPIN_DISPATCH = ^TKSPIN_DISPATCH;
    PKSCLOCK_DISPATCH = ^TKSCLOCK_DISPATCH;
    PKSALLOCATOR_DISPATCH = ^TKSALLOCATOR_DISPATCH;
    PKSPIN = ^TKSPIN;
    PKSNODE_DESCRIPTOR = ^TKSNODE_DESCRIPTOR;
    PKSSTREAM_POINTER_OFFSET = ^TKSSTREAM_POINTER_OFFSET;
    PKSSTREAM_POINTER = ^TKSSTREAM_POINTER;
    PKSMAPPING = ^TKSMAPPING;
    PKSPROCESSPIN = ^TKSPROCESSPIN;
    PKSPROCESSPIN_INDEXENTRY = ^TKSPROCESSPIN_INDEXENTRY;


    PKSWORKER = pointer;

    TKSEVENTDATA = record
        NotificationType: ULONG;
        case integer of
            0: (EventHandle: record
                    Event: THANDLE;
                    Reserved: array [0..1] of ULONG_PTR;
                end);
            1: (SemaphoreHandle: record
                    Semaphore: THANDLE;
                    Reserved: ULONG;
                    Adjustment: LONG;
                end);
        {$IF defined(_NTDDK_)}
            2: (EventObject: record
                    Event: pointer;
                    Increment: TKPRIORITY;
                    Reserved: ULONG_PTR;
                end);
            3: (SemaphoreObject: record
                    Semaphore: pointer;
                    Increment: TKPRIORITY;
                    Adjustment: LONG;
                end);
            4: (Dpc: record
                    Dpc: PKDPC;
                    ReferenceCount: ULONG;
                    Reserved: ULONG_PTR;
                end);
            5: (WorkItem: record
                    WorkQueueItem: PWORK_QUEUE_ITEM;
                    WorkQueueType: TWORK_QUEUE_TYPE;
                    Reserved: ULONG_PTR;
                end);
            6: (KsWorkItem: record
                    WorkQueueItem: PWORK_QUEUE_ITEM;
                    KsWorkerObject: PKSWORKER;
                    Reserved: ULONG_PTR;
                end);
        {$endif}// defined(_NTDDK_)
            7: (Alignment: record
                    Unused: Pointer;
                    Alignment: array [0..1] of LONG_PTR;
                end);

    end;
    PKSEVENTDATA = ^TKSEVENTDATA;




    TKSQUERYBUFFER = record
        Event: TKSEVENT;
        EventData: PKSEVENTDATA;
        Reserved: pointer;
    end;
    PKSQUERYBUFFER = ^TKSQUERYBUFFER;

    TKSRELATIVEEVENT = record
        Size: ULONG;
        Flags: ULONG;
        case integer of
            0: (ObjectHandle: THANDLE;
                Reserved: pointer;
                Event: TKSEVENT;
                EventData: TKSEVENTDATA);
            1: (ObjectPointer: pointer);

    end;



    TKSEVENT_TIME_MARK = record
        EventData: TKSEVENTDATA;
        MarkTime: LONGLONG;
    end;
    PKSEVENT_TIME_MARK = ^TKSEVENT_TIME_MARK;

    TKSEVENT_TIME_INTERVAL = record
        EventData: TKSEVENTDATA;
        TimeBase: LONGLONG;
        Interval: LONGLONG;
    end;
    PKSEVENT_TIME_INTERVAL = ^TKSEVENT_TIME_INTERVAL;

    TKSINTERVAL = record
        TimeBase: LONGLONG;
        Interval: LONGLONG;
    end;
    PKSINTERVAL = TKSINTERVAL;


    TKSPROPERTY_GENERAL = (
        KSPROPERTY_GENERAL_COMPONENTID);


    TKSCOMPONENTID = record
        Manufacturer: TGUID;
        Product: TGUID;
        Component: TGUID;
        Name: TGUID;
        Version: ULONG;
        Revision: ULONG;
    end;
    PKSCOMPONENTID = ^TKSCOMPONENTID;

    TKSMETHOD_STREAMIO = (
        KSMETHOD_STREAMIO_READ,
        KSMETHOD_STREAMIO_WRITE);

    TKSPROPERTY_MEDIASEEKING = (
        KSPROPERTY_MEDIASEEKING_CAPABILITIES,
        KSPROPERTY_MEDIASEEKING_FORMATS,
        KSPROPERTY_MEDIASEEKING_TIMEFORMAT,
        KSPROPERTY_MEDIASEEKING_POSITION,
        KSPROPERTY_MEDIASEEKING_STOPPOSITION,
        KSPROPERTY_MEDIASEEKING_POSITIONS,
        KSPROPERTY_MEDIASEEKING_DURATION,
        KSPROPERTY_MEDIASEEKING_AVAILABLE,
        KSPROPERTY_MEDIASEEKING_PREROLL,
        KSPROPERTY_MEDIASEEKING_CONVERTTIMEFORMAT);

    TKS_SEEKING_FLAGS = (
        KS_SEEKING_NoPositioning,
        KS_SEEKING_AbsolutePositioning,
        KS_SEEKING_RelativePositioning,
        KS_SEEKING_IncrementalPositioning,
        KS_SEEKING_PositioningBitsMask = $3,
        KS_SEEKING_SeekToKeyFrame,
        KS_SEEKING_ReturnTime = $8);

    TKS_SEEKING_CAPABILITIES = (
        KS_SEEKING_CanSeekAbsolute = $1,
        KS_SEEKING_CanSeekForwards = $2,
        KS_SEEKING_CanSeekBackwards = $4,
        KS_SEEKING_CanGetCurrentPos = $8,
        KS_SEEKING_CanGetStopPos = $10,
        KS_SEEKING_CanGetDuration = $20,
        KS_SEEKING_CanPlayBackwards = $40);

    TKSPROPERTY_POSITIONS = record
        Current: LONGLONG;
        Stop: LONGLONG;
        CurrentFlags: TKS_SEEKING_FLAGS;
        StopFlags: TKS_SEEKING_FLAGS;
    end;
    PKSPROPERTY_POSITIONS = ^TKSPROPERTY_POSITIONS;

    TKSPROPERTY_MEDIAAVAILABLE = record
        Earliest: LONGLONG;
        Latest: LONGLONG;
    end;
    PKSPROPERTY_MEDIAAVAILABLE = ^TKSPROPERTY_MEDIAAVAILABLE;

    TKSP_TIMEFORMAT = record
        _Property: TKSPROPERTY;
        SourceFormat: TGUID;
        TargetFormat: TGUID;
        Time: LONGLONG;
    end;
    PKSP_TIMEFORMAT = ^TKSP_TIMEFORMAT;

    TKSPROPERTY_TOPOLOGY = (
        KSPROPERTY_TOPOLOGY_CATEGORIES,
        KSPROPERTY_TOPOLOGY_NODES,
        KSPROPERTY_TOPOLOGY_CONNECTIONS,
        KSPROPERTY_TOPOLOGY_NAME);


    // in Wdm.h
    TFILE_OBJECT = record
    end;
    PFILE_OBJECT = ^TFILE_OBJECT;

    //=============================================================================
    // properties used by graph manager to talk to particular filters



    PFNKSGRAPHMANAGER_NOTIFY = function(GraphManager: PFILE_OBJECT;
        EventId: ULONG; Filter: pointer; Pin: pointer;
        Frame: pointer; Duration: ULONG): pointer;

    TKSGRAPHMANAGER_FUNCTIONTABLE = record
        NotifyEvent: PFNKSGRAPHMANAGER_NOTIFY;
    end;
    PKSGRAPHMANAGER_FUNCTIONTABLE = ^TKSGRAPHMANAGER_FUNCTIONTABLE;


    TKSPROPERTY_GRAPHMANAGER_INTERFACE = record
        GraphManager: PFILE_OBJECT;
        FunctionTable: TKSGRAPHMANAGER_FUNCTIONTABLE;
    end;
    PKSPROPERTY_GRAPHMANAGER_INTERFACE = ^TKSPROPERTY_GRAPHMANAGER_INTERFACE;



    // Commands

    TKSPROPERTY_GM = (
        KSPROPERTY_GM_GRAPHMANAGER,
        KSPROPERTY_GM_TIMESTAMP_CLOCK,
        KSPROPERTY_GM_RATEMATCH,
        KSPROPERTY_GM_RENDER_CLOCK);


    TKSTOPOLOGY_CONNECTION = record
        FromNode: ULONG;
        FromNodePin: ULONG;
        ToNode: ULONG;
        ToNodePin: ULONG;
    end;
    PKSTOPOLOGY_CONNECTION = ^TKSTOPOLOGY_CONNECTION;

    TKSTOPOLOGY = record
        CategoriesCount: ULONG;
        Categories {arraysize CategoriesCount}: PGUID;
        TopologyNodesCount: ULONG;
        TopologyNodes: PGUID;
        TopologyConnectionsCount: ULONG;

        TopologyConnections{arraysize TopologyConnectionsCount}:
        PKSTOPOLOGY_CONNECTION;
        TopologyNodesNames {arraysize TopologyNodesCount}: PGUID;
        Reserved: ULONG;
    end;
    PKSTOPOLOGY = ^TKSTOPOLOGY;



    TKSNODE_CREATE = record
        CreateFlags: ULONG;
        Node: ULONG;
    end;
    PKSNODE_CREATE = ^TKSNODE_CREATE;



    TKSPIN_INTERFACE = TKSIDENTIFIER;
    PKSPIN_INTERFACE = ^TKSPIN_INTERFACE;

    TKSINTERFACE_STANDARD = (
        KSINTERFACE_STANDARD_STREAMING,
        KSINTERFACE_STANDARD_LOOPED_STREAMING,
        KSINTERFACE_STANDARD_CONTROL        //Reserved for system use
        );



    TKSINTERFACE_FILEIO = (
        KSINTERFACE_FILEIO_STREAMING);




    TKSPROPERTY_PIN = (
        KSPROPERTY_PIN_CINSTANCES,
        KSPROPERTY_PIN_CTYPES,
        KSPROPERTY_PIN_DATAFLOW,
        KSPROPERTY_PIN_DATARANGES,
        KSPROPERTY_PIN_DATAINTERSECTION,
        KSPROPERTY_PIN_INTERFACES,
        KSPROPERTY_PIN_MEDIUMS,
        KSPROPERTY_PIN_COMMUNICATION,
        KSPROPERTY_PIN_GLOBALCINSTANCES,
        KSPROPERTY_PIN_NECESSARYINSTANCES,
        KSPROPERTY_PIN_PHYSICALCONNECTION,
        KSPROPERTY_PIN_CATEGORY,
        KSPROPERTY_PIN_NAME,
        KSPROPERTY_PIN_CONSTRAINEDDATARANGES,
        KSPROPERTY_PIN_PROPOSEDATAFORMAT,
        KSPROPERTY_PIN_PROPOSEDATAFORMAT2);



    TKSP_PIN = record
        _Property: TKSPROPERTY;
        PinId: ULONG;
        case integer of
            0: (Reserved: ULONG);
            1: (Flags: ULONG);

    end;
    PKSP_PIN = ^TKSP_PIN;

    TKSE_PIN = record
        Event: TKSEVENT;
        PinId: ULONG;
        Reserved: ULONG;
    end;
    PKSE_PIN = ^TKSE_PIN;



    TKSPIN_CINSTANCES = record
        PossibleCount: ULONG;
        CurrentCount: ULONG;
    end;
    PKSPIN_CINSTANCES = ^TKSPIN_CINSTANCES;

    TKSPIN_DATAFLOW = (
        KSPIN_DATAFLOW_IN = 1,
        KSPIN_DATAFLOW_OUT);
    PKSPIN_DATAFLOW = ^TKSPIN_DATAFLOW;



    TKSDATAFORMAT = record
        case integer of
            0: (
                FormatSize: ULONG;
                Flags: ULONG;
                SampleSize: ULONG;
                Reserved: ULONG;
                MajorFormat: TGUID;
                SubFormat: TGUID;
                Specifier: TGUID);
            1: (Alignment: LONGLONG);
    end;
    PKSDATAFORMAT = ^TKSDATAFORMAT;
    TKSDATARANGE = TKSDATAFORMAT;
    PKSDATARANGE = ^TKSDATARANGE;
    PPKSDATARANGE = ^PKSDATARANGE;



    TKSATTRIBUTE = record
        Size: ULONG;
        Flags: ULONG;
        Attribute: TGUID;
    end;
    PKSATTRIBUTE = ^TKSATTRIBUTE;


    TKSATTRIBUTE_LIST = record
        Count: ULONG;
        Attributes {arraysize Count}: PKSATTRIBUTE;
    end;
    PKSATTRIBUTE_LIST = ^TKSATTRIBUTE_LIST;


    TKSPIN_COMMUNICATION = (
        KSPIN_COMMUNICATION_NONE,
        KSPIN_COMMUNICATION_SINK,
        KSPIN_COMMUNICATION_SOURCE,
        KSPIN_COMMUNICATION_BOTH,
        KSPIN_COMMUNICATION_BRIDGE);
    PKSPIN_COMMUNICATION = ^TKSPIN_COMMUNICATION;

    TKSPIN_MEDIUM = TKSIDENTIFIER;
    PKSPIN_MEDIUM = ^TKSPIN_MEDIUM;

    TKSPIN_CONNECT = record
        _Interface: TKSPIN_INTERFACE;
        Medium: TKSPIN_MEDIUM;
        PinId: ULONG;
        PinToHandle: THANDLE;
        Priority: TKSPRIORITY;
    end;
    PKSPIN_CONNECT = ^TKSPIN_CONNECT;

    TKSPIN_PHYSICALCONNECTION = record
        Size: ULONG;
        Pin: ULONG;
        SymbolicLinkName: PWideChar;
    end;
    PKSPIN_PHYSICALCONNECTION = ^TKSPIN_PHYSICALCONNECTION;



    TKSEVENT_PINCAPS_CHANGENOTIFICATIONS = (
        KSEVENT_PINCAPS_FORMATCHANGE,
        KSEVENT_PINCAPS_JACKINFOCHANGE);



    TKSEVENT_VOLUMELIMIT = (
        KSEVENT_VOLUMELIMIT_CHANGED);


    TKSPIN_DESCRIPTOR = record
        InterfacesCount: ULONG;
        Interfaces{InterfacesCount}: PKSPIN_INTERFACE;
        MediumsCount: ULONG;

        Mediums{MediumsCount}: PKSPIN_MEDIUM;
        DataRangesCount: ULONG;

        DataRanges{DataRangesCount}: PPKSDATARANGE;
        DataFlow: TKSPIN_DATAFLOW;
        Communication: TKSPIN_COMMUNICATION;
        Category: PGUID;
        Name: PGUID;
        case integer of
            0: (Reserved: LONGLONG);
            1: (
                ConstrainedDataRangesCount: ULONG;
                ConstrainedDataRanges{ConstrainedDataRangesCount}:
                PPKSDATARANGE;
            );
    end;
    PKSPIN_DESCRIPTOR = ^TKSPIN_DESCRIPTOR;


    TKSPROPERTY_QUALITY = (
        KSPROPERTY_QUALITY_REPORT,
        KSPROPERTY_QUALITY_ERROR);


    TKSPROPERTY_CONNECTION = (
        KSPROPERTY_CONNECTION_STATE,
        KSPROPERTY_CONNECTION_PRIORITY,
        KSPROPERTY_CONNECTION_DATAFORMAT,
        KSPROPERTY_CONNECTION_ALLOCATORFRAMING,
        KSPROPERTY_CONNECTION_PROPOSEDATAFORMAT,
        KSPROPERTY_CONNECTION_ACQUIREORDERING,
        KSPROPERTY_CONNECTION_ALLOCATORFRAMING_EX,
        KSPROPERTY_CONNECTION_STARTAT);




    // old Framing structure

    TKSALLOCATOR_FRAMING = record
        case integer of
            0: (OptionsFlags: ULONG;       // allocator options (create)

       {$if defined(_NTDDK_)}
                PoolType: POOL_TYPE;
       {$else}  // !_NTDDK_
                PoolType: ULONG;
       {$endif} // !_NTDDK_
                Frames: ULONG;
                // total number of allowable outstanding frames
                FrameSize: ULONG;  // total size of frame
                case integer of
                    0: (FileAlignment: ULONG;
                    Reserved: ULONG;);
                    1: (FramePitch: LONG)
                // When KSALLOCATOR_FLAG_2D_BUFFER_REQUIRED is set this field specifies the required 2d pitch for the buffer i.e. the width + stride
            );

            1: (RequirementsFlags: ULONG);  // allocation requirements (query)
    end;
    PKSALLOCATOR_FRAMING = ^TKSALLOCATOR_FRAMING;



    PFNKSDEFAULTALLOCATE = function(Context: Pointer): Pointer;

    PFNKSDEFAULTFREE = procedure(Context: Pointer; Buffer: Pointer);

    PFNKSINITIALIZEALLOCATOR = function(InitialContext: Pointer;
        AllocatorFraming: PKSALLOCATOR_FRAMING;
        out Context: Pointer): NTSTATUS;

    PFNKSDELETEALLOCATOR = procedure(Context: Pointer);




    // new Framing structure, eventually will replace KSALLOCATOR_FRAMING.

    TKS_FRAMING_RANGE = record
        MinFrameSize: ULONG;
        MaxFrameSize: ULONG;
        Stepping: ULONG;
    end;
    PKS_FRAMING_RANGE = ^TKS_FRAMING_RANGE;


    TKS_FRAMING_RANGE_WEIGHTED = record
        Range: TKS_FRAMING_RANGE;
        InPlaceWeight: ULONG;
        NotInPlaceWeight: ULONG;
    end;
    PKS_FRAMING_RANGE_WEIGHTED = ^TKS_FRAMING_RANGE_WEIGHTED;


    TKS_COMPRESSION = record
        RatioNumerator: ULONG;      // compression/expansion ratio
        RatioDenominator: ULONG;
        RatioConstantMargin: ULONG;
    end;
    PKS_COMPRESSION = ^TKS_COMPRESSION;



    // Memory Types and Buses are repeated in each entry.
    // Easiest to use but takes a little more memory than the varsize layout Pin\Memories\Buses\Ranges.

    TKS_FRAMING_ITEM = record
        MemoryType: TGUID;
        BusType: TGUID;
        MemoryFlags: ULONG;
        BusFlags: ULONG;
        Flags: ULONG;
        Frames: ULONG;
            // total number of allowable outstanding frames
        case integer of
            0: (FileAlignment: ULONG;
                MemoryTypeWeight: ULONG;    // this memory type Weight pin-wide
                PhysicalRange: TKS_FRAMING_RANGE;
                FramingRange: TKS_FRAMING_RANGE_WEIGHTED;
            );
            1: (FramePitch: LONG);
        // When KSALLOCATOR_FLAG_2D_BUFFER_REQUIRED is set this field specifies the required 2d pitch for the buffer i.e. the width + stride

    end;
    PKS_FRAMING_ITEM = ^TKS_FRAMING_ITEM;


    TKSALLOCATOR_FRAMING_EX = record
        CountItems: ULONG;         // count of FramingItem-s below.
        PinFlags: ULONG;
        OutputCompression: TKS_COMPRESSION;
        PinWeight: ULONG;
        // this pin framing's Weight graph-wide
        FramingItem: PKS_FRAMING_ITEM;
    end;
    PKSALLOCATOR_FRAMING_EX = ^TKSALLOCATOR_FRAMING_EX;



    TKSEVENT_STREAMALLOCATOR = (
        KSEVENT_STREAMALLOCATOR_INTERNAL_FREEFRAME,
        KSEVENT_STREAMALLOCATOR_FREEFRAME);

    TKSMETHOD_STREAMALLOCATOR = (
        KSMETHOD_STREAMALLOCATOR_ALLOC,
        KSMETHOD_STREAMALLOCATOR_FREE);


    TKSPROPERTY_STREAMALLOCATOR = (
        KSPROPERTY_STREAMALLOCATOR_FUNCTIONTABLE,
        KSPROPERTY_STREAMALLOCATOR_STATUS);


    PFNALLOCATOR_ALLOCATEFRAME = function(FileObject: PFILE_OBJECT;
        out Frame: pointer): NTSTATUS; stdcall;

    PFNALLOCATOR_FREEFRAME = procedure(FileObject: PFILE_OBJECT;
        Frame: Pointer); stdcall;

    TKSSTREAMALLOCATOR_FUNCTIONTABLE = record
        AllocateFrame: PFNALLOCATOR_ALLOCATEFRAME;
        FreeFrame: PFNALLOCATOR_FREEFRAME;
    end;
    PKSSTREAMALLOCATOR_FUNCTIONTABLE = ^TKSSTREAMALLOCATOR_FUNCTIONTABLE;


    TKSSTREAMALLOCATOR_STATUS = record
        Framing: TKSALLOCATOR_FRAMING;
        AllocatedFrames: ULONG;
        Reserved: ULONG;
    end;
    PKSSTREAMALLOCATOR_STATUS = ^TKSSTREAMALLOCATOR_STATUS;

    TKSSTREAMALLOCATOR_STATUS_EX = record
        Framing: TKSALLOCATOR_FRAMING_EX;
        AllocatedFrames: ULONG;
        Reserved: ULONG;
    end;
    PKSSTREAMALLOCATOR_STATUS_EX = ^TKSSTREAMALLOCATOR_STATUS_EX;

    TKSTIME = record
        Time: LONGLONG;
        Numerator: ULONG;
        Denominator: ULONG;
    end;
    PKSTIME = ^TKSTIME;

    TKSSTREAM_HEADER = record
        Size: ULONG;
        TypeSpecificFlags: ULONG;
        PresentationTime: TKSTIME;
        Duration: LONGLONG;
        FrameExtent: ULONG;
        DataUsed: ULONG;
        Data {size FrameExtent}: pointer;
        OptionsFlags: ULONG;
        {$IFDEF WIN64}
        Reserved: ULONG;
        {$endif}
    end;
    PKSSTREAM_HEADER = ^TKSSTREAM_HEADER;

    TKSSTREAM_METADATA_INFO = record
        BufferSize: ULONG;
        UsedSize: ULONG;
        Data {BufferSize}: pointer;
        // Metadata buffer passed down by user mode (mapped to SystemVa)
        SystemVa {BufferSize}: pointer;
        // Metadata buffer that driver will fill metadata to
        Flags: ULONG;
        Reserved: ULONG;
    end;
    PKSSTREAM_METADATA_INFO = ^TKSSTREAM_METADATA_INFO;

    TKSSTREAM_UVC_METADATATYPE_TIMESTAMP = record
        PresentationTimeStamp: ULONG;
        SourceClockReference: ULONG;
        case integer of
            0: (
                Counter: 0..(1 shl 11) - 1;
                Reserved: 0..(1 shl 5) - 1;
                Reserved0: USHORT;
                Reserved1: ULONG;
            );
            1: (SCRToken: USHORT);


    end;
    PKSSTREAM_UVC_METADATATYPE_TIMESTAMP =
        ^TKSSTREAM_UVC_METADATATYPE_TIMESTAMP;

    TKSSTREAM_UVC_METADATA = record
        StartOfFrameTimestamp: TKSSTREAM_UVC_METADATATYPE_TIMESTAMP;
        EndOfFrameTimestamp: TKSSTREAM_UVC_METADATATYPE_TIMESTAMP;
    end;
    PKSSTREAM_UVC_METADATA = ^TKSSTREAM_UVC_METADATA;


    // Additional space for UVC Attribute data to be stamped in the payload by the
    // Inbox UVC driver



    TKSPIN_MDL_CACHING_EVENT = (
        KSPIN_MDL_CACHING_NOTIFY_CLEANUP,
        KSPIN_MDL_CACHING_NOTIFY_CLEANALL_WAIT,
        KSPIN_MDL_CACHING_NOTIFY_CLEANALL_NOWAIT,
        KSPIN_MDL_CACHING_NOTIFY_ADDSAMPLE);

    TKSPIN_MDL_CACHING_NOTIFICATION = record
        Event: TKSPIN_MDL_CACHING_EVENT;
        Buffer: pointer;
    end;
    PKSPIN_MDL_CACHING_NOTIFICATION = ^TKSPIN_MDL_CACHING_NOTIFICATION;

    TKSPIN_MDL_CACHING_NOTIFICATION32 = record
        Event: TKSPIN_MDL_CACHING_EVENT;
        Buffer: ULONG;
    end;
    PKSPIN_MDL_CACHING_NOTIFICATION32 = ^TKSPIN_MDL_CACHING_NOTIFICATION32;

    TKSPROPERTY_STREAMINTERFACE = (
        KSPROPERTY_STREAMINTERFACE_HEADERSIZE);


    TKSPROPERTY_STREAM = (
        KSPROPERTY_STREAM_ALLOCATOR,
        KSPROPERTY_STREAM_QUALITY,
        KSPROPERTY_STREAM_DEGRADATION,
        KSPROPERTY_STREAM_MASTERCLOCK,
        KSPROPERTY_STREAM_TIMEFORMAT,
        KSPROPERTY_STREAM_PRESENTATIONTIME,
        KSPROPERTY_STREAM_PRESENTATIONEXTENT,
        KSPROPERTY_STREAM_FRAMETIME,
        KSPROPERTY_STREAM_RATECAPABILITY,
        KSPROPERTY_STREAM_RATE,
        KSPROPERTY_STREAM_PIPE_ID);


    TKSPPROPERTY_ALLOCATOR_MDLCACHING = (
        KSPROPERTY_ALLOCATOR_CLEANUP_CACHEDMDLPAGES = 1);


    TKSQUALITY_MANAGER = record
        QualityManager: THANDLE;
        Context: pointer;
    end;
    PKSQUALITY_MANAGER = ^TKSQUALITY_MANAGER;


    TKSFRAMETIME = record
        Duration: LONGLONG;
        FrameFlags: ULONG;
        Reserved: ULONG;
    end;
    PKSFRAMETIME = ^TKSFRAMETIME;



    TKSRATE = record
        PresentationStart: LONGLONG;
        Duration: LONGLONG;
        _Interface: TKSPIN_INTERFACE;
        Rate: LONG;
        Flags: ULONG;
    end;
    PKSRATE = ^TKSRATE;



    TKSRATE_CAPABILITY = record
        _Property: TKSPROPERTY;
        Rate: TKSRATE;
    end;
    PKSRATE_CAPABILITY = ^TKSRATE_CAPABILITY;


    TKSCLOCK_CREATE = record
        CreateFlags: ULONG;
    end;
    PKSCLOCK_CREATE = ^TKSCLOCK_CREATE;

    TKSCORRELATED_TIME = record
        Time: LONGLONG;
        SystemTime: LONGLONG;
    end;
    PKSCORRELATED_TIME = ^TKSCORRELATED_TIME;

    TKSRESOLUTION = record
        Granularity: LONGLONG;
        Error: LONGLONG;
    end;
    PKSRESOLUTION = ^TKSRESOLUTION;

    TKSPROPERTY_CLOCK = (
        KSPROPERTY_CLOCK_TIME,
        KSPROPERTY_CLOCK_PHYSICALTIME,
        KSPROPERTY_CLOCK_CORRELATEDTIME,
        KSPROPERTY_CLOCK_CORRELATEDPHYSICALTIME,
        KSPROPERTY_CLOCK_RESOLUTION,
        KSPROPERTY_CLOCK_STATE,
        KSPROPERTY_CLOCK_FUNCTIONTABLE);


    PFNKSCLOCK_GETTIME = function(FileObject: PFILE_OBJECT): LONGLONG;
        register; // fastcall !!! --> WORK not in Pascal --> ToDo

    PFNKSCLOCK_CORRELATEDTIME = function(FileObject: PFILE_OBJECT;
        out SystemTime: LONGLONG): LONGLONG; register;
    // fastcall !!! --> WORK not in Pascal --> ToDo

    TKSCLOCK_FUNCTIONTABLE = record
        GetTime: PFNKSCLOCK_GETTIME;
        GetPhysicalTime: PFNKSCLOCK_GETTIME;
        GetCorrelatedTime: PFNKSCLOCK_CORRELATEDTIME;
        GetCorrelatedPhysicalTime: PFNKSCLOCK_CORRELATEDTIME;
    end;
    PKSCLOCK_FUNCTIONTABLE = ^TKSCLOCK_FUNCTIONTABLE;

    PKTIMER = pointer;
    PKDPC = pointer;
    PIRP = pointer;
    PIO_STATUS_BLOCK = pointer;

    PFNKSSETTIMER = function(Context: Pointer; Timer: PKTIMER;
        DueTime: LARGE_INTEGER; Dpc: PKDPC): boolean;



    PFNKSCANCELTIMER = function(Context: Pointer;
        Timer: PKTIMER): boolean;

    PFNKSCORRELATEDTIME = function(Context: Pointer;
        out SystemTime: LONGLONG): LONGLONG; register;


    PKSDEFAULTCLOCK = pointer;


    TKSEVENT_CLOCK_POSITION = (
        KSEVENT_CLOCK_INTERVAL_MARK,
        KSEVENT_CLOCK_POSITION_MARK);




    TKSEVENT_CONNECTION = (
        KSEVENT_CONNECTION_POSITIONUPDATE,
        KSEVENT_CONNECTION_DATADISCONTINUITY,
        KSEVENT_CONNECTION_TIMEDISCONTINUITY,
        KSEVENT_CONNECTION_PRIORITY,
        KSEVENT_CONNECTION_ENDOFSTREAM);

    TKSQUALITY = record
        Context: Pointer;
        Proportion: ULONG;
        DeltaTime: LONGLONG;
    end;
    PKSQUALITY = ^TKSQUALITY;

    TKSERROR = record
        Context: pointer;
        Status: ULONG;
    end;
    PKSERROR = ^TKSERROR;

    TKSDEVICE_THERMAL_STATE = (
        KSDEVICE_THERMAL_STATE_LOW,
        KSDEVICE_THERMAL_STATE_HIGH);


    TKSEVENT_DEVICE = (
        KSEVENT_DEVICE_LOST,
        KSEVENT_DEVICE_PREEMPTED,
        KSEVENT_DEVICE_THERMAL_HIGH,
        KSEVENT_DEVICE_THERMAL_LOW);

    TKSDEGRADE = TKSIDENTIFIER;
    PKSDEGRADE = ^TKSDEGRADE;

    TKSDEGRADE_STANDARD = (
        KSDEGRADE_STANDARD_SAMPLE,
        KSDEGRADE_STANDARD_QUALITY,
        KSDEGRADE_STANDARD_COMPUTATION,
        KSDEGRADE_STANDARD_SKIP);



    PFNKSCONTEXT_DISPATCH = function(Context: Pointer;
        Irp: PIRP): NTSTATUS; stdcall;

    PFNKSHANDLER = function(Irp: PIRP; Request: PKSIDENTIFIER;
        var Data: pointer): NTSTATUS; stdcall;

    PFNKSFASTHANDLER = function(FileObject: PFILE_OBJECT;
        Request {RequestLength}: PKSIDENTIFIER; RequestLength: ULONG;
        var Data {DataLength}: Pointer; DataLength: ULONG;
        out IoStatus: PIO_STATUS_BLOCK): boolean; stdcall;

    PFNKSALLOCATOR = function(Irp: PIRP; BufferSize: ULONG;
        InputOperation: boolean): NTSTATUS; stdcall;

    TKSPROPERTY_MEMBERSLIST = record
        MembersHeader: TKSPROPERTY_MEMBERSHEADER;
        Members: pointer;
    end;
    PKSPROPERTY_MEMBERSLIST = ^TKSPROPERTY_MEMBERSLIST;

    TKSPROPERTY_VALUES = record
        PropTypeSet: TKSIDENTIFIER;
        MembersListCount: ULONG;
        MembersList {MembersListCount}: PKSPROPERTY_MEMBERSLIST;
    end;
    PKSPROPERTY_VALUES = ^TKSPROPERTY_VALUES;



















    //  xxx



    TWAVEFORMATEX = record



        // todo
    end;


    TKSPROPERTY_ITEM = record
        PropertyId: ULONG;
        case integer of
            0: (
                GetPropertyHandler: PFNKSHANDLER;
                MinProperty: ULONG;
                MinData: ULONG;
                case integer of
                    0: (
                    SetPropertyHandler: PFNKSHANDLER;
                    Values: PKSPROPERTY_VALUES;
                    RelationsCount: ULONG;
                    Relations {arraysize RelationsCount}: PKSPROPERTY;
                    SupportHandler: PFNKSHANDLER;
                    SerializedSize: ULONG);
                    1: (SetSupported: boolean)
            );
            1: (GetSupported: boolean);
    end;
    PKSPROPERTY_ITEM = ^TKSPROPERTY_ITEM;


    // ToDo

    TKSDEVICE_DESCRIPTOR = record

    end;


    TKSDEVICE_DISPATCH= record

    end;

    TKSDEVICE= record

    end;

    TKSFILTERFACTORY= record

    end;

    TKSFILTER_DESCRIPTOR= record

    end;

    TKSFILTER_DISPATCH= record

    end;

    TKSFILTER= record

    end;

    TKSPIN_DESCRIPTOR_EX= record

    end;

    TKSPIN_DISPATCH= record

    end;

    TKSCLOCK_DISPATCH= record

    end;

    TKSALLOCATOR_DISPATCH= record

    end;

    TKSPIN= record

    end;

    TKSNODE_DESCRIPTOR= record

    end;

    TKSSTREAM_POINTER_OFFSET= record

    end;

    TKSSTREAM_POINTER= record

    end;

    TKSMAPPING= record

    end;

    TKSPROCESSPIN= record

    end;
    TKSPROCESSPIN_INDEXENTRY= record

    end;

function DEFINE_KSPROPERTY_ITEM_GENERAL_COMPONENTID(
    Handler: PFNKSHANDLER): TKSPROPERTY_ITEM;


implementation



function DEFINE_KSPROPERTY_ITEM_GENERAL_COMPONENTID(
    Handler: PFNKSHANDLER): TKSPROPERTY_ITEM;
begin
    {
    Result.PropertyId := KSPROPERTY_GENERAL_COMPONENTID;
    Result.GetPropertyHandler := Handler;
    Result.MinProperty := sizeof(TKSPROPERTY);
    Result.MinData := sizeof(TKSCOMPONENTID);

    Result.SetPropertyHandler := nil;
    Result.Values := nil;
    RelationsCount := 0;
    Relations := nil;
    SupportHandler := nil;
    SerializedSize := 0;      }
end;

end.
