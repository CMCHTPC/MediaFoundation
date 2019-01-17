unit Win32.strmif;
//+-------------------------------------------------------------------------
//  Copyright (C) Microsoft Corporation, 1999-2002.
//--------------------------------------------------------------------------


{$mode delphi}

interface

uses
    Windows, Classes, SysUtils,
    ActiveX, Direct3D, DirectDraw;

const
    IID_ICreateDevEnum: TGUID = '{29840822-5B84-11D0-BD3B-00A0C911CE86}';
    IID_IPin: TGUID = '{56a86891-0ad4-11ce-b03a-0020af0ba770}';
    IID_IEnumPins: TGUID = '{56a86892-0ad4-11ce-b03a-0020af0ba770}';
    IID_IEnumMediaTypes: TGUID = '{89c31040-846b-11ce-97d3-00aa0055595a}';
    IID_IFilterGraph: TGUID = '{56a8689f-0ad4-11ce-b03a-0020af0ba770}';
    IID_IEnumFilters: TGUID = '{56a86893-0ad4-11ce-b03a-0020af0ba770}';
    IID_IMediaFilter: TGUID = '{56a86899-0ad4-11ce-b03a-0020af0ba770}';
    IID_IBaseFilter: TGUID = '{56a86895-0ad4-11ce-b03a-0020af0ba770}';
    IID_IReferenceClock: TGUID =
        '{56a86897-0ad4-11ce-b03a-0020af0ba770}';
    IID_IReferenceClockTimerControl: TGUID =
        '{ebec459c-2eca-4d42-a8af-30df557614b8}';
    IID_IReferenceClock2: TGUID = '{36b73885-c2c8-11cf-8b46-00805f6cef60}';
    IID_IMediaSample: TGUID = '{56a8689a-0ad4-11ce-b03a-0020af0ba770}';
    IID_IMediaSample2: TGUID = '{36b73884-c2c8-11cf-8b46-00805f6cef60}';
    IID_IMediaSample2Config: TGUID = '{68961E68-832B-41ea-BC91-63593F3E70E3}';
    IID_IMemAllocator: TGUID = '{56a8689c-0ad4-11ce-b03a-0020af0ba770}';
    IID_IMemAllocatorCallbackTemp: TGUID =
        '{379a0cf0-c1de-11d2-abf5-00a0c905f375}';
    IID_IMemAllocatorNotifyCallbackTemp: TGUID =
        '{92980b30-c1de-11d2-abf5-00a0c905f375}';
    IID_IMemInputPin: TGUID = '{56a8689d-0ad4-11ce-b03a-0020af0ba770}';
    IID_IAMovieSetup: TGUID = '{a3d8cec0-7e5a-11cf-bbc5-00805f6cef20}';



    IID_IMediaSeeking: TGUID = '{36b73880-c2c8-11cf-8b46-00805f6cef60}';
    IID_ICodecAPI: TGUID = '{901db4c7-31ce-41a2-85dc-8fa0bf41b8da}';
    IID_IEnumRegFilters: TGUID = '{56a868a4-0ad4-11ce-b03a-0020af0ba770}';

    IID_IFilterMapper: TGUID = '{56a868a3-0ad4-11ce-b03a-0020af0ba770}';
    IID_IFilterMapper2: TGUID = '{b79bb0b0-33c1-11d1-abe1-00a0c905f375}';
    IID_IFilterMapper3: TGUID = '{b79bb0b1-33c1-11d1-abe1-00a0c905f375}';
    IID_IQualityControl: TGUID = '{56a868a5-0ad4-11ce-b03a-0020af0ba770}';

    IID_IOverlayNotify: TGUID = '{56a868a0-0ad4-11ce-b03a-0020af0ba770}';
    IID_IOverlayNotify2: TGUID = '{680EFA10-D535-11D1-87C8-00A0C9223196}';
    IID_IOverlay: TGUID = '{56a868a1-0ad4-11ce-b03a-0020af0ba770}';
    IID_IMediaEventSink: TGUID = '{56a868a2-0ad4-11ce-b03a-0020af0ba770}';
    IID_IFileSourceFilter: TGUID = '{56a868a6-0ad4-11ce-b03a-0020af0ba770}';

    IID_IFileSinkFilter: TGUID = '{a2104830-7c70-11cf-8bce-00aa00a3f1a6}';
    IID_IFileSinkFilter2: TGUID = '{00855B90-CE1B-11d0-BD4F-00A0C911CE86}';
    IID_IGraphBuilder: TGUID = '{56a868a9-0ad4-11ce-b03a-0020af0ba770}';
    IID_ICaptureGraphBuilder: TGUID =
        '{bf87b6e0-8c27-11d0-b3f0-00aa003761c5}';
    IID_IAMCopyCaptureFileProgress: TGUID =
        '{670d1d20-a068-11d0-b3f0-00aa003761c5}';
    IID_ICaptureGraphBuilder2: TGUID =
        '{93E5A4E0-2D50-11d2-ABFA-00A0C9C6E38D}';
    IID_IFilterGraph2: TGUID = '{36b73882-c2c8-11cf-8b46-00805f6cef60}';
    IID_IFilterGraph3: TGUID = '{aaf38154-b80b-422f-91e6-b66467509a07}';


    IID_IStreamBuilder: TGUID = '{56a868bf-0ad4-11ce-b03a-0020af0ba770}';
    IID_IAsyncReader: TGUID = '{56a868aa-0ad4-11ce-b03a-0020af0ba770}';
    IID_IGraphVersion: TGUID = '{56a868ab-0ad4-11ce-b03a-0020af0ba770}';
    IID_IResourceConsumer: TGUID = '{56a868ad-0ad4-11ce-b03a-0020af0ba770}';
    IID_IResourceManager: TGUID = '{56a868ac-0ad4-11ce-b03a-0020af0ba770}';

    IID_IDistributorNotify: TGUID =
        '{56a868af-0ad4-11ce-b03a-0020af0ba770}';
    IID_IAMStreamControl: TGUID = '{36b73881-c2c8-11cf-8b46-00805f6cef60}';
    IID_ISeekingPassThru: TGUID = '{36b73883-c2c8-11cf-8b46-00805f6cef60}';
    IID_IAMStreamConfig: TGUID = '{C6E13340-30AC-11d0-A18C-00A0C9118956}';
    IID_IConfigInterleaving: TGUID =
        '{BEE3D220-157B-11d0-BD23-00A0C911CE86}';
    IID_IConfigAviMux: TGUID = '{5ACD6AA0-F482-11ce-8B67-00AA00A3F1A6}';
    IID_IAMVideoCompression: TGUID =
        '{C6E13343-30AC-11d0-A18C-00A0C9118956}';
    IID_IAMVfwCaptureDialogs: TGUID =
        '{D8D715A0-6E5E-11D0-B3F0-00AA003761C5}';
    IID_IAMVfwCompressDialogs: TGUID =
        '{D8D715A3-6E5E-11D0-B3F0-00AA003761C5}';
    IID_IAMDroppedFrames: TGUID = '{C6E13344-30AC-11d0-A18C-00A0C9118956}';
    IID_IAMAudioInputMixer: TGUID =
        '{54C39221-8380-11d0-B3F0-00AA003761C5}';
    IID_IAMBufferNegotiation: TGUID =
        '{56ED71A0-AF5F-11D0-B3F0-00AA003761C5}';
    IID_IAMAnalogVideoDecoder: TGUID =
        '{C6E13350-30AC-11d0-A18C-00A0C9118956}';
    IID_IAMVideoProcAmp: TGUID = '{C6E13360-30AC-11d0-A18C-00A0C9118956}';
    IID_IAMCameraControl: TGUID = '{C6E13370-30AC-11d0-A18C-00A0C9118956}';
    IID_IAMVideoControl: TGUID = '{6a2e0670-28e4-11d0-a18c-00a0c9118956}';
    IID_IAMCrossbar: TGUID = '{C6E13380-30AC-11d0-A18C-00A0C9118956}';
    IID_IAMTuner: TGUID = '{211A8761-03AC-11d1-8D13-00AA00BD8339}';
    IID_IAMTunerNotification: TGUID =
        '{211A8760-03AC-11d1-8D13-00AA00BD8339}';
    IID_IAMTVTuner: TGUID = '{211A8766-03AC-11d1-8D13-00AA00BD8339}';
    IID_IBPCSatelliteTuner: TGUID = '{211A8765-03AC-11d1-8D13-00AA00BD8339}';
    IID_IAMTVAudio: TGUID = '{83EC1C30-23D1-11d1-99E6-00A0C9560266}';
    IID_IAMTVAudioNotification: TGUID =
        '{83EC1C33-23D1-11d1-99E6-00A0C9560266}';
    IID_IAMAnalogVideoEncoder: TGUID =
        '{C6E133B0-30AC-11d0-A18C-00A0C9118956}';
    IID_IKsPropertySet: TGUID = '{31EFAC30-515C-11d0-A9AA-00AA0061BE93}';
    IID_IMediaPropertyBag: TGUID = '{6025A880-C0D5-11d0-BD4E-00A0C911CE86}';
    IID_IPersistMediaPropertyBag: TGUID =
        '{5738E040-B67F-11d0-BD4D-00A0C911CE86}';
    IID_IAMPhysicalPinInfo: TGUID = '{F938C991-3029-11cf-8C44-00AA006B6814}';


    IID_IAMExtDevice: TGUID = '{B5730A90-1A2C-11cf-8C23-00AA006B6814}';
    IID_IAMExtTransport: TGUID = '{A03CD5F0-3045-11cf-8C44-00AA006B6814}';
    IID_IAMTimecodeReader: TGUID =
        '{9B496CE1-811B-11cf-8C77-00AA006B6814}';
    IID_IAMTimecodeGenerator: TGUID =
        '{9B496CE0-811B-11cf-8C77-00AA006B6814}';
    IID_IAMTimecodeDisplay: TGUID =
        '{9B496CE2-811B-11cf-8C77-00AA006B6814}';
    IID_IAMDevMemoryAllocator: TGUID =
        '{c6545bf0-e76b-11d0-bd52-00a0c911ce86}';
    IID_IAMDevMemoryControl: TGUID =
        '{c6545bf1-e76b-11d0-bd52-00a0c911ce86}';
    IID_IAMStreamSelect: TGUID =
        '{c1960960-17f5-11d1-abe1-00a0c905f375}';
    IID_IAMResourceControl: TGUID =
        '{8389d2d0-77d7-11d1-abe6-00a0c905f375}';
    IID_IAMClockAdjust: TGUID = '{4d5466b0-a49c-11d1-abe8-00a0c905f375}';
    IID_IAMFilterMiscFlags: TGUID =
        '{2dd74950-a890-11d1-abe8-00a0c905f375}';
    IID_IDrawVideoImage: TGUID = '{48efb120-ab49-11d2-aed2-00a0c995e8d5}';
    IID_IDecimateVideoImage: TGUID =
        '{2e5ea3e0-e924-11d2-b6da-00a0c995e8df}';
    IID_IAMVideoDecimationProperties: TGUID =
        '{60d32930-13da-11d3-9ec6-c4fcaef5c7be}';
    IID_IVideoFrameStep: TGUID = '{e46a9787-2b71-444d-a4b5-1fab7b708d6a}';
    IID_IAMLatency: TGUID = '{62EA93BA-EC62-11d2-B770-00C04FB6BD3D}';
    IID_IAMPushSource: TGUID = '{F185FE76-E64E-11d2-B76E-00C04FB6BD3D}';
    IID_IAMDeviceRemoval: TGUID =
        '{f90a6130-b658-11d2-ae49-0000f8754b99}';
    IID_IDVEnc: TGUID = '{d18e17a0-aacb-11d0-afb0-00aa00b67a42}';


    IID_IIPDVDec: TGUID = '{b8e8bd60-0bfe-11d0-af91-00aa00b67a42}';
    IID_IDVRGB219: TGUID = '{58473A19-2BC8-4663-8012-25F81BABDDD1}';
    IID_IDVSplitter: TGUID = '{92a3a302-da7c-4a1f-ba7e-1802bb5d2d02}';
    IID_IAMAudioRendererStats: TGUID =
        '{22320CB2-D41A-11d2-BF7C-D7CB9DF0BF93}';
    IID_IAMGraphStreams: TGUID = '{632105FA-072E-11d3-8AF9-00C04FB6BD3D}';
    IID_IAMOverlayFX: TGUID = '{62fae250-7e65-4460-bfc9-6398b322073c}';
    IID_IAMOpenProgress: TGUID = '{8E1C39A1-DE53-11cf-AA63-0080C744528D}';
    IID_IMpeg2Demultiplexer: TGUID =
        '{436eee9c-264f-4242-90e1-4e330c107512}';
    IID_IEnumStreamIdMap: TGUID = '{945C1566-6202-46fc-96C7-D87F289C6534}';
    IID_IMPEG2StreamIdMap: TGUID = '{D0E04C47-25B8-4369-925A-362A01D95444}';
    IID_IRegisterServiceProvider: TGUID =
        '{7B3A2F01-0751-48DD-B556-004785171C54}';
    IID_IAMClockSlave: TGUID = '{9FD52741-176D-4b36-8F51-CA8F933223BE}';
    IID_IAMGraphBuilderCallback: TGUID =
        '{4995f511-9ddb-4f12-bd3b-f04611807b79}';

    IID_IAMFilterGraphCallback: TGUID =
        '{56a868fd-0ad4-11ce-b0a3-0020af0ba770}';
    IID_IGetCapabilitiesKey: TGUID =
        '{a8809222-07bb-48ea-951c-33158100625b}';
    IID_IEncoderAPI: TGUID = '{70423839-6ACC-4b23-B079-21DBF08156A5}';
    IID_IVideoEncoder: TGUID = '{02997C3B-8E1B-460e-9270-545E0DE9563E}';
    IID_IAMDecoderCaps: TGUID = '{c0dff467-d499-4986-972b-e1d9090fa941}';
    IID_IAMCertifiedOutputProtection: TGUID =
        '{6feded3e-0ff1-4901-a2f1-43f7012c8515}';
    IID_IAMAsyncReaderTimestampScaling: TGUID =
        '{cf7b26fc-9a00-485b-8147-3e789d5e8f67}';
    IID_IAMPluginControl: TGUID = '{0e26a181-f40c-4635-8786-976284b52981}';
    IID_IPinConnection: TGUID = '{4a9a62d3-27d4-403d-91e9-89f540e55534}';
    IID_IPinFlowControl: TGUID = '{c56e9858-dbf3-4f6b-8119-384af2060deb}';
    IID_IGraphConfig: TGUID = '{03A1EB8E-32BF-4245-8502-114D08A9CB88}';
    IID_IGraphConfigCallback: TGUID =
        '{ade0fd60-d19d-11d2-abf6-00a0c905f375}';
    IID_IFilterChain: TGUID = '{DCFBDCF6-0DC2-45f5-9AB2-7C330EA09C29}';
    IID_IVMRImagePresenter: TGUID =
        '{CE704FE7-E71E-41fb-BAA2-C4403E1182F5}';
    IID_IVMRSurfaceAllocator: TGUID =
        '{31ce832e-4484-458b-8cca-f4d7e3db0b52}';
    IID_IVMRSurfaceAllocatorNotify: TGUID =
        '{aada05a8-5a4e-4729-af0b-cea27aed51e2}';
    IID_IVMRWindowlessControl: TGUID =
        '{0eb1088c-4dcd-46f0-878f-39dae86a51b7}';
    IID_IVMRMixerControl: TGUID = '{1c1a17b0-bed0-415d-974b-dc6696131599}';
    IID_IVMRMonitorConfig: TGUID =
        '{9cf0b1b6-fbaa-4b7f-88cf-cf1f130a0dce}';
    IID_IVMRFilterConfig: TGUID =
        '{9e5530c5-7034-48b4-bb46-0b8a6efc8e36}';
    IID_IVMRAspectRatioControl: TGUID =
        '{ede80b5c-bad6-4623-b537-65586c9f8dfd}';
    IID_IVMRDeinterlaceControl: TGUID =
        '{bb057577-0db8-4e6a-87a7-1a8c9a505a0f}';
    IID_IVMRMixerBitmap: TGUID = '{1E673275-0257-40aa-AF20-7C608D4A0428}';
    IID_IVMRImageCompositor: TGUID =
        '{7a4fb5af-479f-4074-bb40-ce6722e43c82}';
    IID_IVMRVideoStreamControl: TGUID =
        '{058d1f11-2a54-4bef-bd54-df706626b727}';
    IID_IVMRSurface: TGUID = '{a9849bbe-9ec8-4263-b764-62730f0d15d0}';
    IID_IVMRImagePresenterConfig: TGUID =
        '{9f3a1c85-8555-49ba-935f-be5b5b29d178}';
    IID_IVMRImagePresenterExclModeConfig: TGUID =
        '{e6f7ce40-4673-44f1-8f77-5499d68cb4ea}';
    IID_IVPManager: TGUID = '{aac18c18-e186-46d2-825d-a1f8dc8e395a}';
    IID_IDvdControl: TGUID = '{A70EFE61-E2A3-11d0-A9BE-00AA0061BE93}';
    IID_IDvdInfo: TGUID = '{A70EFE60-E2A3-11d0-A9BE-00AA0061BE93}';
    IID_IDvdCmd: TGUID = '{5a4a97e4-94ee-4a55-9751-74b5643aa27d}';
    IID_IDvdState: TGUID = '{86303d6d-1c4a-4087-ab42-f711167048ef}';
    IID_IDvdControl2: TGUID = '{33BC7430-EEC0-11D2-8201-00A0C9D74842}';
    IID_IDvdInfo2: TGUID = '{34151510-EEC0-11D2-8201-00A0C9D74842}';
    IID_IDvdGraphBuilder: TGUID =
        '{FCC152B6-F372-11d0-8E00-00C04FD7C08B}';
    IID_IDDrawExclModeVideo: TGUID =
        '{153ACC21-D83B-11d1-82BF-00A0C9696C8F}';
    IID_IDDrawExclModeVideoCallback: TGUID =
        '{913c24a0-20ab-11d2-9038-00a0c9697298}';


const

    CDEF_CLASS_DEFAULT = $0001;
    CDEF_BYPASS_CLASS_MANAGER = $0002;
    CDEF_MERIT_ABOVE_DO_NOT_USE = $0008;
    CDEF_DEVMON_CMGR_DEVICE = $0010;
    CDEF_DEVMON_DMO = $0020;
    CDEF_DEVMON_PNP_DEVICE = $0040;
    CDEF_DEVMON_FILTER = $0080;
    CDEF_DEVMON_SELECTIVE_MASK = $00f0;

    CHARS_IN_GUID = 39;

    MAX_PIN_NAME = 128;
    MAX_FILTER_NAME = 128;

    AM_GBF_PREVFRAMESKIPPED = 1;
    AM_GBF_NOTASYNCPOINT = 2;
    AM_GBF_NOWAIT = 4;
    AM_GBF_NODDSURFACELOCK = 8;

    AMF_AUTOMATICGAIN = -1.0;

    AnalogVideo_NTSC_Mask = $00000007;
    AnalogVideo_PAL_Mask = $00100FF0;
    AnalogVideo_SECAM_Mask = $000FF000;


    MPEG2_PROGRAM_STREAM_MAP = $00000000;
    MPEG2_PROGRAM_ELEMENTARY_STREAM = $00000001;
    MPEG2_PROGRAM_DIRECTORY_PES_PACKET = $00000002;
    MPEG2_PROGRAM_PACK_HEADER = $00000003;
    MPEG2_PROGRAM_PES_STREAM = $00000004;
    MPEG2_PROGRAM_SYSTEM_HEADER = $00000005;
    SUBSTREAM_FILTER_VAL_NONE = $10000000;

    AM_GETDECODERCAP_QUERY_VMR_SUPPORT = $00000001;
    VMR_NOTSUPPORTED = $00000000;
    VMR_SUPPORTED = $00000001;
    AM_QUERY_DECODER_VMR_SUPPORT = $00000001;
    AM_QUERY_DECODER_DXVA_1_SUPPORT = $00000002;
    AM_QUERY_DECODER_DVD_SUPPORT = $00000003;
    AM_QUERY_DECODER_ATSC_SD_SUPPORT = $00000004;
    AM_QUERY_DECODER_ATSC_HD_SUPPORT = $00000005;
    AM_GETDECODERCAP_QUERY_VMR9_SUPPORT = $00000006;
    AM_GETDECODERCAP_QUERY_EVR_SUPPORT = $00000007;
    DECODER_CAP_NOTSUPPORTED = $00000000;
    DECODER_CAP_SUPPORTED = $00000001;


    VMRBITMAP_DISABLE = $00000001;
    VMRBITMAP_HDC = $00000002;
    VMRBITMAP_ENTIREDDS = $00000004;
    VMRBITMAP_SRCCOLORKEY = $00000008;
    VMRBITMAP_SRCRECT = $00000010;

    DVD_TITLE_MENU = $000;
    DVD_STREAM_DATA_CURRENT = $800;
    DVD_STREAM_DATA_VMGM = $400;
    DVD_STREAM_DATA_VTSM = $401;
    DVD_DEFAULT_AUDIO_STREAM = $0f;

    DVD_AUDIO_CAPS_AC3 = $00000001;
    DVD_AUDIO_CAPS_MPEG2 = $00000002;
    DVD_AUDIO_CAPS_LPCM = $00000004;
    DVD_AUDIO_CAPS_DTS = $00000008;
    DVD_AUDIO_CAPS_SDDS = $00000010;

    // Each filter is registered with a merit value. When the filter graph manager builds a graph, it enumerates all the filters registered with the correct media type. Then it tries them in order of merit, from highest to lowest. (It uses additional criteria to choose between filters with equal merit.) It never tries filters with a merit value less than or equal to MERIT_DO_NOT_USE.
    // A filter that should never be considered for ordinary playback should have a merit of MERIT_DO_NOT_USE or less. Filters can be registered with intermediate values not defined by this enumeration, such as MERIT_NORMAL + 1.
    MERIT_PREFERRED = $800000;
    MERIT_NORMAL = $600000;
    MERIT_UNLIKELY = $400000;
    MERIT_DO_NOT_USE = $200000;
    MERIT_SW_COMPRESSOR = $100000;
    MERIT_HW_COMPRESSOR = $100050;


    REG_PINFLAG_B_ZERO = $1;
    REG_PINFLAG_B_RENDERER = $2;
    REG_PINFLAG_B_MANY = $4;
    REG_PINFLAG_B_OUTPUT = $8;

    CK_NOCOLORKEY = 0;
    CK_INDEX = $1;
    CK_RGB = $2;


    ADVISE_NONE = 0;
    ADVISE_CLIPPING = $1;
    ADVISE_PALETTE = $2;
    ADVISE_COLORKEY = $4;
    ADVISE_POSITION = $8;
    ADVISE_DISPLAY_CHANGE = $10;


    ADVISE_ALL = ADVISE_CLIPPING or ADVISE_PALETTE or ADVISE_COLORKEY or ADVISE_POSITION;

    ADVISE_ALL2 = ADVISE_ALL or ADVISE_DISPLAY_CHANGE;

    KSPROPERTY_SUPPORT_GET = 1;
    KSPROPERTY_SUPPORT_SET = 2;

    MAX_NUMBER_OF_STREAMS = 16;

type

    TVARIANT = variant;
    PCOLORREF = ^TCOLORREF;
    PDirectDrawSurface7 = ^IDirectDrawSurface7;
    PDIRECTDRAW7 = ^IDIRECTDRAW7;

    IBaseFilter = interface;
    IEnumMediaTypes = interface;
    IEnumFilters = interface;
    IReferenceClock = interface;
    IMemAllocatorNotifyCallbackTemp = interface;
    IAMCopyCaptureFileProgress = interface;
    IAMTunerNotification = interface;
    IGraphConfigCallback = interface;
    IVMRSurfaceAllocatorNotify = interface;
    IVMRImageCompositor = interface;
    IDDrawExclModeVideoCallback = interface;


    ICreateDevEnum = interface(IUnknown)
        ['{29840822-5B84-11D0-BD3B-00A0C911CE86}']
        function CreateClassEnumerator(clsidDeviceClass: PCLSID; out ppEnumMoniker: IEnumMoniker;
            dwFlags: DWORD): HResult; stdcall;
    end;


    TAM_MEDIA_TYPE = record
        majortype: TGUID;
        subtype: TGUID;
        bFixedSizeSamples: longbool;
        bTemporalCompression: longbool;
        lSampleSize: ULONG;
        formattype: TGUID;
        pUnk: IUnknown;
        cbFormat: ULONG;
        pbFormat: PBYTE;
    end;

    PAM_MEDIA_TYPE = ^TAM_MEDIA_TYPE;

    TPIN_DIRECTION = (
        PINDIR_INPUT = 0,
        PINDIR_OUTPUT = (PINDIR_INPUT + 1)
        );


    TREFERENCE_TIME = LONGLONG;
    PREFERENCE_TIME = ^TREFERENCE_TIME;

    TREFTIME = double;

    THSEMAPHORE = DWORD_PTR;

    THEVENT = DWORD_PTR;

    TALLOCATOR_PROPERTIES = record
        cBuffers: long;
        cbBuffer: long;
        cbAlign: long;
        cbPrefix: long;
    end;

    PALLOCATOR_PROPERTIES = ^TALLOCATOR_PROPERTIES;


    TPIN_INFO = record
        pFilter: IBaseFilter;
        dir: TPIN_DIRECTION;
        achName: array[0.. 127] of WCHAR;
    end;


    IPin = interface(IUnknown)
        ['{56a86891-0ad4-11ce-b03a-0020af0ba770}']
        function Connect(pReceivePin: IPin; const pmt: PAM_MEDIA_TYPE): HResult; stdcall;
        function ReceiveConnection(pConnector: IPin; const pmt: PAM_MEDIA_TYPE): HResult; stdcall;
        function Disconnect(): HResult; stdcall;
        function ConnectedTo(out pPin: IPin): HResult; stdcall;
        function ConnectionMediaType(out pmt: TAM_MEDIA_TYPE): HResult; stdcall;
        function QueryPinInfo(out pInfo: TPIN_INFO): HResult;
            stdcall;
        function QueryDirection(out pPinDir: TPIN_DIRECTION): HResult; stdcall;
        function QueryId(out Id: LPWSTR): HResult; stdcall;
        function QueryAccept(const pmt: PAM_MEDIA_TYPE): HResult;
            stdcall;
        function EnumMediaTypes(out ppEnum: IEnumMediaTypes): HResult; stdcall;
        function QueryInternalConnections(out apPin {nPin, nPin}: IPin; var nPin: ULONG): HResult; stdcall;
        function EndOfStream(): HResult; stdcall;
        function BeginFlush(): HResult; stdcall;
        function EndFlush(): HResult; stdcall;
        function NewSegment(tStart: TREFERENCE_TIME; tStop: TREFERENCE_TIME; dRate: double): HResult;
            stdcall;
    end;


    PPIN = ^IPin;


    IEnumPins = interface(IUnknown)
        ['{56a86892-0ad4-11ce-b03a-0020af0ba770}']
        function Next(cPins: ULONG; out ppPins {cPins, pcFetched}: IPin;
            out pcFetched: ULONG): HResult; stdcall;
        function Skip(cPins: ULONG): HResult; stdcall;
        function Reset(): HResult; stdcall;
        function Clone(out ppEnum: IEnumPins): HResult; stdcall;
    end;


    PENUMPINS = ^IEnumPins;


    IEnumMediaTypes = interface(IUnknown)
        ['{89c31040-846b-11ce-97d3-00aa0055595a}']
        function Next(cMediaTypes: ULONG; out ppMediaTypes {cMediaTypes, pcFetched}: PAM_MEDIA_TYPE;
            out pcFetched: ULONG): HResult; stdcall;
        function Skip(cMediaTypes: ULONG): HResult; stdcall;
        function Reset(): HResult; stdcall;
        function Clone(out ppEnum: IEnumMediaTypes): HResult;
            stdcall;
    end;


    PENUMMEDIATYPES = ^IEnumMediaTypes;


    IFilterGraph = interface(IUnknown)
        ['{56a8689f-0ad4-11ce-b03a-0020af0ba770}']
        function AddFilter(pFilter: IBaseFilter; pName: LPCWSTR): HResult; stdcall;
        function RemoveFilter(pFilter: IBaseFilter): HResult;
            stdcall;
        function EnumFilters(out ppEnum: IEnumFilters): HResult;
            stdcall;
        function FindFilterByName(pName: LPCWSTR; out ppFilter: IBaseFilter): HResult; stdcall;
        function ConnectDirect(ppinOut: IPin; ppinIn: IPin; const pmt: PAM_MEDIA_TYPE): HResult;
            stdcall;
        function Reconnect(ppin: IPin): HResult; stdcall;
        function Disconnect(ppin: IPin): HResult; stdcall;
        function SetDefaultSyncSource(): HResult; stdcall;
    end;


    PFILTERGRAPH = ^IFilterGraph;



    IEnumFilters = interface(IUnknown)
        ['{56a86893-0ad4-11ce-b03a-0020af0ba770}']
        function Next(cFilters: ULONG; out ppFilter {cFilters, pcFetched}: IBaseFilter;
            out pcFetched: ULONG): HResult; stdcall;
        function Skip(cFilters: ULONG): HResult; stdcall;
        function Reset(): HResult; stdcall;
        function Clone(out ppEnum: IEnumFilters): HResult;
            stdcall;
    end;

    PENUMFILTERS = ^IEnumFilters;

    TFILTER_STATE = (
        State_Stopped = 0,
        State_Paused = (State_Stopped + 1),
        State_Running = (State_Paused + 1)
        );

    IMediaFilter = interface(IPersist)
        ['{56a86899-0ad4-11ce-b03a-0020af0ba770}']
        function Stop(): HResult; stdcall;
        function Pause(): HResult; stdcall;
        function Run(tStart: TREFERENCE_TIME): HResult; stdcall;
        function GetState(dwMilliSecsTimeout: DWORD; out State: TFILTER_STATE): HResult; stdcall;
        function SetSyncSource(pClock: IReferenceClock): HResult;
            stdcall;
        function GetSyncSource(out pClock: IReferenceClock): HResult;
            stdcall;
    end;

    PMEDIAFILTER = ^IMediaFilter;

    TFILTER_INFO = record
        achName: array[0.. 127] of WCHAR;
        pGraph: IFilterGraph;
    end;

    IBaseFilter = interface(IMediaFilter)
        ['{56a86895-0ad4-11ce-b03a-0020af0ba770}']
        function EnumPins(out ppEnum: IEnumPins): HResult;
            stdcall;
        function FindPin(Id: LPCWSTR; out ppPin: IPin): HResult;
            stdcall;
        function QueryFilterInfo(out pInfo: TFILTER_INFO): HResult;
            stdcall;
        function JoinFilterGraph(pGraph: IFilterGraph; pName: LPCWSTR): HResult; stdcall;
        function QueryVendorInfo(out pVendorInfo: LPWSTR): HResult;
            stdcall;
    end;

    PFILTER = ^IBaseFilter;

    IReferenceClock = interface(IUnknown)
        ['{56a86897-0ad4-11ce-b03a-0020af0ba770}']
        function GetTime(out pTime: TREFERENCE_TIME): HResult;
            stdcall;
        function AdviseTime(baseTime: TREFERENCE_TIME; streamTime: TREFERENCE_TIME;
            hEvent: THEVENT; out pdwAdviseCookie: DWORD_PTR): HResult; stdcall;
        function AdvisePeriodic(startTime: TREFERENCE_TIME; periodTime: TREFERENCE_TIME;
            hSemaphore: THSEMAPHORE; out pdwAdviseCookie: DWORD_PTR): HResult; stdcall;
        function Unadvise(dwAdviseCookie: DWORD_PTR): HResult;
            stdcall;
    end;

    PREFERENCECLOCK = ^IReferenceClock;

    IReferenceClockTimerControl = interface(IUnknown)
        ['{ebec459c-2eca-4d42-a8af-30df557614b8}']
        function SetDefaultTimerResolution(timerResolution: TREFERENCE_TIME): HResult; stdcall;
        function GetDefaultTimerResolution(out pTimerResolution: TREFERENCE_TIME): HResult; stdcall;
    end;

    IReferenceClock2 = interface(IReferenceClock)
        ['{36b73885-c2c8-11cf-8b46-00805f6cef60}']
    end;

    PREFERENCECLOCK2 = ^IReferenceClock2;

    IMediaSample = interface(IUnknown)
        ['{56a8689a-0ad4-11ce-b03a-0020af0ba770}']
        function GetPointer(out ppBuffer: PBYTE): HResult;
            stdcall;
        function GetSize(): long; stdcall;
        function GetTime(out pTimeStart: TREFERENCE_TIME; out pTimeEnd: TREFERENCE_TIME): HResult; stdcall;
        function SetTime(pTimeStart: PREFERENCE_TIME; pTimeEnd: PREFERENCE_TIME): HResult; stdcall;
        function IsSyncPoint(): HResult; stdcall;
        function SetSyncPoint(bIsSyncPoint: longbool): HResult;
            stdcall;
        function IsPreroll(): HResult; stdcall;
        function SetPreroll(bIsPreroll: longbool): HResult;
            stdcall;
        function GetActualDataLength(): long; stdcall;
        function SetActualDataLength(lLen: long): HResult;
            stdcall;
        function GetMediaType(out ppMediaType: PAM_MEDIA_TYPE): HResult; stdcall;
        function SetMediaType(pMediaType: PAM_MEDIA_TYPE): HResult;
            stdcall;
        function IsDiscontinuity(): HResult; stdcall;
        function SetDiscontinuity(bDiscontinuity: longbool): HResult;
            stdcall;
        function GetMediaTime(out pTimeStart: LONGLONG; out pTimeEnd: LONGLONG): HResult; stdcall;
        function SetMediaTime(pTimeStart: PLONGLONG; pTimeEnd: PLONGLONG): HResult; stdcall;
    end;

    PMEDIASAMPLE = ^IMediaSample;

    TAM_SAMPLE_PROPERTY_FLAGS = (
        AM_SAMPLE_SPLICEPOINT = $1,
        AM_SAMPLE_PREROLL = $2,
        AM_SAMPLE_DATADISCONTINUITY = $4,
        AM_SAMPLE_TYPECHANGED = $8,
        AM_SAMPLE_TIMEVALID = $10,
        AM_SAMPLE_TIMEDISCONTINUITY = $40,
        AM_SAMPLE_FLUSH_ON_PAUSE = $80,
        AM_SAMPLE_STOPVALID = $100,
        AM_SAMPLE_ENDOFSTREAM = $200,
        AM_STREAM_MEDIA = 0,
        AM_STREAM_CONTROL = 1
        );

    TAM_SAMPLE2_PROPERTIES = record
        cbData: DWORD;
        dwTypeSpecificFlags: DWORD;
        dwSampleFlags: DWORD;
        lActual: LONG;
        tStart: TREFERENCE_TIME;
        tStop: TREFERENCE_TIME;
        dwStreamId: DWORD;
        pMediaType: PAM_MEDIA_TYPE;
        pbBuffer: PBYTE;
        cbBuffer: LONG;
    end;


    IMediaSample2 = interface(IMediaSample)
        ['{36b73884-c2c8-11cf-8b46-00805f6cef60}']
        function GetProperties(cbProperties: DWORD; var pbProperties: PBYTE): HResult; stdcall;
        function SetProperties(cbProperties: DWORD; const pbProperties{cbProperties}: PBYTE): HResult;
            stdcall;
    end;

    PMEDIASAMPLE2 = ^IMediaSample2;

    IMediaSample2Config = interface(IUnknown)
        ['{68961E68-832B-41ea-BC91-63593F3E70E3}']
        function GetSurface(out ppDirect3DSurface9: IUnknown): HResult; stdcall;
    end;

    IMemAllocator = interface(IUnknown)
        ['{56a8689c-0ad4-11ce-b03a-0020af0ba770}']
        function SetProperties(pRequest: PALLOCATOR_PROPERTIES;
            out pActual: TALLOCATOR_PROPERTIES): HResult; stdcall;
        function GetProperties(out pProps: TALLOCATOR_PROPERTIES): HResult; stdcall;
        function Commit(): HResult; stdcall;
        function Decommit(): HResult; stdcall;
        function GetBuffer(out ppBuffer: IMediaSample; pStartTime: PREFERENCE_TIME;
            pEndTime: PREFERENCE_TIME; dwFlags: DWORD): HResult;
            stdcall;
        function ReleaseBuffer(pBuffer: IMediaSample): HResult;
            stdcall;
    end;

    PMEMALLOCATOR = ^IMemAllocator;

    IMemAllocatorCallbackTemp = interface(IMemAllocator)
        ['{379a0cf0-c1de-11d2-abf5-00a0c905f375}']
        function SetNotify(pNotify: IMemAllocatorNotifyCallbackTemp): HResult; stdcall;
        function GetFreeCount(out plBuffersFree: LONG): HResult;
            stdcall;
    end;

    IMemAllocatorNotifyCallbackTemp = interface(IUnknown)
        ['{92980b30-c1de-11d2-abf5-00a0c905f375}']
        function NotifyRelease(): HResult; stdcall;
    end;

    IMemInputPin = interface(IUnknown)
        ['{56a8689d-0ad4-11ce-b03a-0020af0ba770}']
        function GetAllocator(out ppAllocator: IMemAllocator): HResult; stdcall;
        function NotifyAllocator(pAllocator: IMemAllocator; bReadOnly: longbool): HResult; stdcall;
        function GetAllocatorRequirements(out pProps: TALLOCATOR_PROPERTIES): HResult; stdcall;
        function Receive(pSample: IMediaSample): HResult;
            stdcall;
        function ReceiveMultiple(pSamples{nSamples}: IMediaSample; nSamples: long;
            out nSamplesProcessed: long): HResult;
            stdcall;
        function ReceiveCanBlock(): HResult; stdcall;
    end;

    PMEMINPUTPIN = ^IMemInputPin;

    IAMovieSetup = interface(IUnknown)
        ['{a3d8cec0-7e5a-11cf-bbc5-00805f6cef20}']
        function Register(): HResult; stdcall;
        function Unregister(): HResult; stdcall;
    end;

    PAMOVIESETUP = ^IAMovieSetup;

    TAM_SEEKING_SEEKING_FLAGS = (
        AM_SEEKING_NoPositioning = 0,
        AM_SEEKING_AbsolutePositioning = $1,
        AM_SEEKING_RelativePositioning = $2,
        AM_SEEKING_IncrementalPositioning = $3,
        AM_SEEKING_PositioningBitsMask = $3,
        AM_SEEKING_SeekToKeyFrame = $4,
        AM_SEEKING_ReturnTime = $8,
        AM_SEEKING_Segment = $10,
        AM_SEEKING_NoFlush = $20
        );

    TAM_SEEKING_SEEKING_CAPABILITIES = (
        AM_SEEKING_CanSeekAbsolute = $1,
        AM_SEEKING_CanSeekForwards = $2,
        AM_SEEKING_CanSeekBackwards = $4,
        AM_SEEKING_CanGetCurrentPos = $8,
        AM_SEEKING_CanGetStopPos = $10,
        AM_SEEKING_CanGetDuration = $20,
        AM_SEEKING_CanPlayBackwards = $40,
        AM_SEEKING_CanDoSegments = $80,
        AM_SEEKING_Source = $100
        );


    IMediaSeeking = interface(IUnknown)
        ['{36b73880-c2c8-11cf-8b46-00805f6cef60}']
        function GetCapabilities(out pCapabilities: DWORD): HResult;
            stdcall;
        function CheckCapabilities(var pCapabilities: DWORD): HResult; stdcall;
        function IsFormatSupported(const pFormat: TGUID): HResult;
            stdcall;
        function QueryPreferredFormat(out pFormat: TGUID): HResult;
            stdcall;
        function GetTimeFormat(out pFormat: TGUID): HResult;
            stdcall;
        function IsUsingTimeFormat(const pFormat: TGUID): HResult;
            stdcall;
        function SetTimeFormat(const pFormat: TGUID): HResult;
            stdcall;
        function GetDuration(out pDuration: LONGLONG): HResult;
            stdcall;
        function GetStopPosition(out pStop: LONGLONG): HResult;
            stdcall;
        function GetCurrentPosition(out pCurrent: LONGLONG): HResult;
            stdcall;
        function ConvertTimeFormat(out pTarget: LONGLONG; const pTargetFormat: TGUID;
            Source: LONGLONG; const pSourceFormat: TGUID): HResult; stdcall;
        function SetPositions(var pCurrent: LONGLONG; dwCurrentFlags: DWORD; var pStop: LONGLONG;
            dwStopFlags: DWORD): HResult; stdcall;
        function GetPositions(out pCurrent: LONGLONG; out pStop: LONGLONG): HResult; stdcall;
        function GetAvailable(out pEarliest: LONGLONG; out pLatest: LONGLONG): HResult; stdcall;
        function SetRate(dRate: double): HResult; stdcall;
        function GetRate(out pdRate: double): HResult; stdcall;
        function GetPreroll(out pllPreroll: LONGLONG): HResult;
            stdcall;
    end;

    PMEDIASEEKING = ^IMediaSeeking;

    TAM_MEDIAEVENT_FLAGS = (
        AM_MEDIAEVENT_NONOTIFY = $01);

    TCodecAPIEventData = record
        TGUID: TGUID;
        dataLength: DWORD;
        reserved: array [0..2] of DWORD;
    end;

    ICodecAPI = interface(IUnknown)
        ['{901db4c7-31ce-41a2-85dc-8fa0bf41b8da}']
        function IsSupported(const Api: TGUID): HResult; stdcall;
        function IsModifiable(const Api: TGUID): HResult; stdcall;
        function GetParameterRange(const Api: TGUID; out ValueMin: TVARIANT; out ValueMax: TVARIANT;
            out SteppingDelta: TVARIANT): HResult; stdcall;
        function GetParameterValues(const Api: TGUID; out Values{ValuesCount}: PVARIANT;
            out ValuesCount: ULONG): HResult; stdcall;
        function GetDefaultValue(const Api: TGUID; out Value: TVARIANT): HResult; stdcall;
        function GetValue(const Api: TGUID; out Value: TVARIANT): HResult; stdcall;
        function SetValue(const Api: TGUID; Value: PVARIANT): HResult; stdcall;
        function RegisterForEvent(const Api: TGUID; userData: LONG_PTR): HResult; stdcall;
        function UnregisterForEvent(const Api: TGUID): HResult;
            stdcall;
        function SetAllDefaults(): HResult; stdcall;
        function SetValueWithNotify(const Api: TGUID; Value: PVARIANT;
            out ChangedParam{ChangedParamCount}: PGUID; out ChangedParamCount: ULONG): HResult; stdcall;
        function SetAllDefaultsWithNotify(out ChangedParam{ChangedParamCount}: PGUID;
            out ChangedParamCount: ULONG): HResult; stdcall;
        function GetAllSettings(pStream: IStream): HResult;
            stdcall;
        function SetAllSettings(pStream: IStream): HResult;
            stdcall;
        function SetAllSettingsWithNotify(pStream: IStream; out ChangedParam{ChangedParamCount}: PGUID;
            out ChangedParamCount: ULONG): HResult; stdcall;
    end;

    TREGFILTER = record
        Clsid: TCLSID;
        Name: LPWSTR;
    end;

    PREGFILTER = ^TREGFILTER;

    IEnumRegFilters = interface(IUnknown)
        ['{56a868a4-0ad4-11ce-b03a-0020af0ba770}']
        function Next(cFilters: ULONG; out apRegFilter{cFilters, pcFetched}: PREGFILTER;
            var pcFetched: ULONG): HResult; stdcall;
        function Skip(cFilters: ULONG): HResult; stdcall;
        function Reset(): HResult; stdcall;
        function Clone(out ppEnum: IEnumRegFilters): HResult;
            stdcall;
    end;



    PENUMREGFILTERS = ^IEnumRegFilters;



    IFilterMapper = interface(IUnknown)
        ['{56a868a3-0ad4-11ce-b03a-0020af0ba770}']
        function RegisterFilter(clsid: CLSID; Name: LPCWSTR; dwMerit: DWORD): HResult; stdcall;
        function RegisterFilterInstance(clsid: CLSID; Name: LPCWSTR; out MRId: CLSID): HResult; stdcall;
        function RegisterPin(Filter: CLSID; Name: LPCWSTR; bRendered: longbool;
            bOutput: longbool; bZero: longbool; bMany: longbool; ConnectsToFilter: CLSID;
            ConnectsToPin: LPCWSTR): HResult; stdcall;
        function RegisterPinType(clsFilter: CLSID; strName: LPCWSTR; clsMajorType: CLSID;
            clsSubType: CLSID): HResult; stdcall;
        function UnregisterFilter(Filter: CLSID): HResult;
            stdcall;
        function UnregisterFilterInstance(MRId: CLSID): HResult;
            stdcall;
        function UnregisterPin(Filter: CLSID; Name: LPCWSTR): HResult; stdcall;
        function EnumMatchingFilters(out ppEnum: IEnumRegFilters; dwMerit: DWORD;
            bInputNeeded: longbool; clsInMaj: CLSID; clsInSub: CLSID; bRender: longbool;
            bOututNeeded: longbool; clsOutMaj: CLSID; clsOutSub: CLSID): HResult; stdcall;
    end;


    TREGPINTYPES = record
        clsMajorType: PCLSID;
        clsMinorType: PCLSID;
    end;

    PREGPINTYPES = ^TREGPINTYPES;

    TREGFILTERPINS = record
        strName: LPWSTR;
        bRendered: longbool;
        bOutput: longbool;
        bZero: longbool;
        bMany: longbool;
        clsConnectsToFilter: PCLSID;
        strConnectsToPin: PWCHAR;
        nMediaTypes: UINT;
        lpMediaType: PREGPINTYPES;
    end;

    PREGFILTERPINS = ^TREGFILTERPINS;

    TREGPINMEDIUM = record
        clsMedium: CLSID;
        dw1: DWORD;
        dw2: DWORD;
    end;
    PREGPINMEDIUM = ^TREGPINMEDIUM;


    TREGFILTERPINS2 = record
        dwFlags: DWORD;
        cInstances: UINT;
        nMediaTypes: UINT;
        lpMediaType: PREGPINTYPES;
        nMediums: UINT;
        lpMedium: PREGPINMEDIUM;
        clsPinCategory: PCLSID;
    end;

    PREGFILTERPINS2 = ^TREGFILTERPINS2;

    TREGFILTER2 = record
        dwVersion: DWORD;
        dwMerit: DWORD;
        case integer of
            0: (cPins: ULONG;
                rgPins: PREGFILTERPINS);
            1: (cPins2: ULONG;
                rgPins2: PREGFILTERPINS2);
    end;


    PREGFILTER2 = ^TREGFILTER2;


    IFilterMapper2 = interface(IUnknown)
        ['{b79bb0b0-33c1-11d1-abe1-00a0c905f375}']
        function CreateCategory(clsidCategory: PCLSID; dwCategoryMerit: DWORD;
            Description: LPCWSTR): HResult;
            stdcall;
        function UnregisterFilter(const pclsidCategory: PCLSID; szInstance: POLESTR;
            Filter: PCLSID): HResult;
            stdcall;
        function RegisterFilter(clsidFilter: PCLSID; Name: LPCWSTR; var ppMoniker: IMoniker;
            const pclsidCategory: PCLSID; szInstance: POLESTR; const prf2: PREGFILTER2): HResult; stdcall;
        function EnumMatchingFilters(out ppEnum: IEnumMoniker; dwFlags: DWORD;
            bExactMatch: longbool; dwMerit: DWORD; bInputNeeded: longbool; cInputTypes: DWORD;
            const pInputTypes{cInputTypes * 2}: PGUID; const pMedIn: PREGPINMEDIUM;
            const pPinCategoryIn: PCLSID; bRender: longbool; bOutputNeeded: longbool;
            cOutputTypes: DWORD; const pOutputTypes{cOutputTypes * 2}: PGUID;
            const pMedOut: PREGPINMEDIUM; const pPinCategoryOut: PCLSID): HResult; stdcall;
    end;


    IFilterMapper3 = interface(IFilterMapper2)
        ['{b79bb0b1-33c1-11d1-abe1-00a0c905f375}']
        function GetICreateDevEnum(out ppEnum: ICreateDevEnum): HResult;
            stdcall;
    end;

    TQualityMessageType = (
        Famine = 0,
        Flood = (Famine + 1)
        );

    TQuality = record
        _Type: TQualityMessageType;
        Proportion: long;
        Late: TREFERENCE_TIME;
        TimeStamp: TREFERENCE_TIME;
    end;

    PQUALITYCONTROL = ^IQualityControl;


    IQualityControl = interface(IUnknown)
        ['{56a868a5-0ad4-11ce-b03a-0020af0ba770}']
        function Notify(pSelf: IBaseFilter; q: TQuality): HResult; stdcall;
        function SetSink(piqc: IQualityControl): HResult;
            stdcall;
    end;


    TCOLORKEY = record
        KeyType: DWORD;
        PaletteIndex: DWORD;
        LowColorValue: TCOLORREF;
        HighColorValue: TCOLORREF;
    end;

    PCOLORKEY = ^TCOLORKEY;

    TRGNDATAHEADER = record
        dwSize: DWORD;
        iType: DWORD;
        nCount: DWORD;
        nRgnSize: DWORD;
        rcBound: TRECT;
    end;

    PRGNDATAHEADER = ^TRGNDATAHEADER;

    TRGNDATA = record
        rdh: TRGNDATAHEADER;
        Buffer: PByte;
    end;

    PRGNDATA = ^TRGNDATA;



    IOverlayNotify = interface(IUnknown)
        ['{56a868a0-0ad4-11ce-b03a-0020af0ba770}']
        function OnPaletteChange(dwColors: DWORD; const pPalette: PPALETTEENTRY): HResult; stdcall;
        function OnClipChange(const pSourceRect: TRECT; const pDestinationRect: TRECT;
            const pRgnData: PRGNDATA): HResult; stdcall;
        function OnColorKeyChange(const ColorKey: PCOLORKEY): HResult; stdcall;
        function OnPositionChange(const pSourceRect: TRECT; const pDestinationRect: TRECT): HResult;
            stdcall;
    end;

    POVERLAYNOTIFY = ^IOverlayNotify;

    THMONITOR = THANDLE;

    IOverlayNotify2 = interface(IOverlayNotify)
        ['{680EFA10-D535-11D1-87C8-00A0C9223196}']
        function OnDisplayChange(hMonitor: THMONITOR): HResult;
            stdcall;
    end;

    POVERLAYNOTIFY2 = ^IOverlayNotify2;


    IOverlay = interface(IUnknown)
        ['{56a868a1-0ad4-11ce-b03a-0020af0ba770}']
        function GetPalette(var pdwColors: DWORD;
            out ppPalette{pdwColors, pdwColors}: PPALETTEENTRY): HResult;
            stdcall;
        function SetPalette(dwColors: DWORD; pPalette{arraysize dwColors}: PPALETTEENTRY): HResult; stdcall;
        function GetDefaultColorKey(out pColorKey: TCOLORKEY): HResult; stdcall;
        function GetColorKey(out pColorKey: TCOLORKEY): HResult;
            stdcall;
        function SetColorKey(var pColorKey: TCOLORKEY): HResult;
            stdcall;
        function GetWindowHandle(out pHwnd: HWND): HResult;
            stdcall;
        function GetClipList(out pSourceRect: TRECT; out pDestinationRect: TRECT;
            out ppRgnData: PRGNDATA): HResult; stdcall;
        function GetVideoPosition(out pSourceRect: TRECT; out pDestinationRect: TRECT): HResult; stdcall;
        function Advise(pOverlayNotify: IOverlayNotify; dwInterests: DWORD): HResult; stdcall;
        function Unadvise(): HResult; stdcall;
    end;

    POVERLAY = ^IOverlay;

    IMediaEventSink = interface(IUnknown)
        ['{56a868a2-0ad4-11ce-b03a-0020af0ba770}']
        function Notify(EventCode: long; EventParam1: LONG_PTR; EventParam2: LONG_PTR): HResult; stdcall;
    end;

    PMEDIAEVENTSINK = ^IMediaEventSink;


    IFileSourceFilter = interface(IUnknown)
        ['{56a868a6-0ad4-11ce-b03a-0020af0ba770}']
        function Load(pszFileName: POLESTR; const pmt: PAM_MEDIA_TYPE): HResult; stdcall;
        function GetCurFile(out ppszFileName: POLESTR; out pmt: TAM_MEDIA_TYPE): HResult; stdcall;
    end;

    PFILTERFILESOURCE = ^IFileSourceFilter;

    IFileSinkFilter = interface(IUnknown)
        ['{a2104830-7c70-11cf-8bce-00aa00a3f1a6}']
        function SetFileName(pszFileName: POLESTR; const pmt: PAM_MEDIA_TYPE): HResult; stdcall;
        function GetCurFile(out ppszFileName: LPOLESTR; out pmt: TAM_MEDIA_TYPE): HResult; stdcall;
    end;

    PFILTERFILESINK = ^IFileSinkFilter;

    IFileSinkFilter2 = interface(IFileSinkFilter)
        ['{00855B90-CE1B-11d0-BD4F-00A0C911CE86}']
        function SetMode(dwFlags: DWORD): HResult; stdcall;
        function GetMode(out pdwFlags: DWORD): HResult; stdcall;
    end;

    PFILESINKFILTER2 = ^IFileSinkFilter2;

    TAM_FILESINK_FLAGS = (
        AM_FILE_OVERWRITE = $1
        );

    IGraphBuilder = interface(IFilterGraph)
        ['{56a868a9-0ad4-11ce-b03a-0020af0ba770}']
        function Connect(ppinOut: IPin; ppinIn: IPin): HResult; stdcall;
        function Render(ppinOut: IPin): HResult; stdcall;
        function RenderFile(lpcwstrFile: LPCWSTR; lpcwstrPlayList: LPCWSTR): HResult; stdcall;
        function AddSourceFilter(lpcwstrFileName: LPCWSTR; lpcwstrFilterName: LPCWSTR;
            out ppFilter: IBaseFilter): HResult; stdcall;
        function SetLogFile(hFile: DWORD_PTR): HResult; stdcall;
        function Abort(): HResult; stdcall;
        function ShouldOperationContinue(): HResult; stdcall;
    end;


    ICaptureGraphBuilder = interface(IUnknown)
        ['{bf87b6e0-8c27-11d0-b3f0-00aa003761c5}']
        function SetFiltergraph(pfg: IGraphBuilder): HResult;
            stdcall;
        function GetFiltergraph(out ppfg: IGraphBuilder): HResult;
            stdcall;
        function SetOutputFileName(const pType: TGUID; lpstrFile: POLESTR; out ppf: IBaseFilter;
            out ppSink: IFileSinkFilter): HResult; stdcall;
        function FindInterface(const pCategory: TGUID; pf: IBaseFilter; riid: TREFIID;
            out ppint): HResult; stdcall;
        function RenderStream(const pCategory: TGUID; pSource: IUnknown; pfCompressor: IBaseFilter;
            pfRenderer: IBaseFilter): HResult; stdcall;
        function ControlStream(const pCategory: TGUID; pFilter: IBaseFilter;
            pstart: PREFERENCE_TIME; pstop: PREFERENCE_TIME; wStartCookie: word;
            wStopCookie: word): HResult; stdcall;
        function AllocCapFile(lpstr: POLESTR; dwlSize: DWORDLONG): HResult; stdcall;
        function CopyCaptureFile(lpwstrOld: LPOLESTR; lpwstrNew: LPOLESTR; fAllowEscAbort: integer;
            pCallback: IAMCopyCaptureFileProgress): HResult; stdcall;
    end;


    IAMCopyCaptureFileProgress = interface(IUnknown)
        ['{670d1d20-a068-11d0-b3f0-00aa003761c5}']
        function Progress(iProgress: integer): HResult; stdcall;
    end;


    ICaptureGraphBuilder2 = interface(IUnknown)
        ['{93E5A4E0-2D50-11d2-ABFA-00A0C9C6E38D}']
        function SetFiltergraph(pfg: IGraphBuilder): HResult;
            stdcall;
        function GetFiltergraph(out ppfg: IGraphBuilder): HResult;
            stdcall;
        function SetOutputFileName(const pType: TGUID; lpstrFile: POLESTR; out ppf: IBaseFilter;
            out ppSink: IFileSinkFilter): HResult; stdcall;
        function FindInterface(const pCategory: PGUID; const pType: TGUID; pf: IBaseFilter;
            riid: REFIID; out ppint): HResult; stdcall;
        function RenderStream(const pCategory: PGUID; const pType: TGUID; pSource: IUnknown;
            pfCompressor: IBaseFilter; pfRenderer: IBaseFilter): HResult; stdcall;
        function ControlStream(const pCategory: TGUID; const pType: TGUID; pFilter: IBaseFilter;
            pstart: PREFERENCE_TIME; pstop: PREFERENCE_TIME; wStartCookie: word; wStopCookie: word): HResult;
            stdcall;
        function AllocCapFile(lpstr: POLESTR; dwlSize: DWORDLONG): HResult; stdcall;
        function CopyCaptureFile(lpwstrOld: LPOLESTR; lpwstrNew: LPOLESTR; fAllowEscAbort: integer;
            pCallback: IAMCopyCaptureFileProgress): HResult; stdcall;
        function FindPin(pSource: IUnknown; pindir: TPIN_DIRECTION; const pCategory: TGUID;
            const pType: TGUID; fUnconnected: longbool; num: integer; out ppPin: IPin): HResult; stdcall;
    end;

    TAM_RENSDEREXFLAGS = (
        AM_RENDEREX_RENDERTOEXISTINGRENDERERS = $1
        );


    IFilterGraph2 = interface(IGraphBuilder)
        ['{36b73882-c2c8-11cf-8b46-00805f6cef60}']
        function AddSourceFilterForMoniker(pMoniker: IMoniker; pCtx: IBindCtx;
            lpcwstrFilterName: LPCWSTR; out ppFilter: IBaseFilter): HResult; stdcall;
        function ReconnectEx(ppin: IPin; const pmt: PAM_MEDIA_TYPE = nil): HResult; stdcall;
        function RenderEx(pPinOut: IPin; dwFlags: DWORD; var pvContext: DWORD): HResult;
            stdcall;
    end;

    IFilterGraph3 = interface(IFilterGraph2)
        ['{aaf38154-b80b-422f-91e6-b66467509a07}']
        function SetSyncSourceEx(pClockForMostOfFilterGraph: IReferenceClock;
            pClockForFilter: IReferenceClock; pFilter: IBaseFilter): HResult; stdcall;
    end;

    IStreamBuilder = interface(IUnknown)
        ['{56a868bf-0ad4-11ce-b03a-0020af0ba770}']
        function Render(ppinOut: IPin; pGraph: IGraphBuilder): HResult; stdcall;
        function Backout(ppinOut: IPin; pGraph: IGraphBuilder): HResult; stdcall;
    end;


    IAsyncReader = interface(IUnknown)
        ['{56a868aa-0ad4-11ce-b03a-0020af0ba770}']
        function RequestAllocator(pPreferred: IMemAllocator; pProps: PALLOCATOR_PROPERTIES;
            out ppActual: IMemAllocator): HResult; stdcall;
        function Request(pSample: IMediaSample; dwUser: DWORD_PTR): HResult; stdcall;
        function WaitForNext(dwTimeout: DWORD; out ppSample: IMediaSample;
            out pdwUser: DWORD_PTR): HResult; stdcall;
        function SyncReadAligned(pSample: IMediaSample): HResult;
            stdcall;
        function SyncRead(llPosition: LONGLONG; lLength: LONG; out pBuffer {lLength}: PBYTE): HResult;
            stdcall;
        function Length(out pTotal: LONGLONG; out pAvailable: LONGLONG): HResult; stdcall;
        function BeginFlush(): HResult; stdcall;
        function EndFlush(): HResult; stdcall;
    end;

    IGraphVersion = interface(IUnknown)
        ['{56a868ab-0ad4-11ce-b03a-0020af0ba770}']
        function QueryVersion(out pVersion: LONG): HResult;
            stdcall;
    end;

    IResourceConsumer = interface(IUnknown)
        ['{56a868ad-0ad4-11ce-b03a-0020af0ba770}']
        function AcquireResource(idResource: LONG): HResult;
            stdcall;
        function ReleaseResource(idResource: LONG): HResult;
            stdcall;
    end;

    IResourceManager = interface(IUnknown)
        ['{56a868ac-0ad4-11ce-b03a-0020af0ba770}']
        function Register(pName: LPCWSTR; cResource: LONG; out plToken: LONG): HResult;
            stdcall;
        function RegisterGroup(pName: LPCWSTR; cResource: LONG; palTokens{arraysize cResource}: PLONG;
            out plToken: LONG): HResult; stdcall;
        function RequestResource(idResource: LONG; pFocusObject: IUnknown;
            pConsumer: IResourceConsumer): HResult; stdcall;
        function NotifyAcquire(idResource: LONG; pConsumer: IResourceConsumer; hr: HRESULT): HResult;
            stdcall;
        function NotifyRelease(idResource: LONG; pConsumer: IResourceConsumer;
            bStillWant: longbool): HResult; stdcall;
        function CancelRequest(idResource: LONG; pConsumer: IResourceConsumer): HResult; stdcall;
        function SetFocus(pFocusObject: IUnknown): HResult;
            stdcall;
        function ReleaseFocus(pFocusObject: IUnknown): HResult;
            stdcall;
    end;

    IDistributorNotify = interface(IUnknown)
        ['{56a868af-0ad4-11ce-b03a-0020af0ba770}']
        function Stop(): HResult; stdcall;
        function Pause(): HResult; stdcall;
        function Run(tStart: TREFERENCE_TIME): HResult; stdcall;
        function SetSyncSource(pClock: IReferenceClock): HResult;
            stdcall;
        function NotifyGraphChange(): HResult; stdcall;
    end;

    TAM_STREAM_INFO_FLAGS = (
        AM_STREAM_INFO_START_DEFINED = $1,
        AM_STREAM_INFO_STOP_DEFINED = $2,
        AM_STREAM_INFO_DISCARDING = $4,
        AM_STREAM_INFO_STOP_SEND_EXTRA = $10
        );

    TAM_STREAM_INFO = record
        tStart: TREFERENCE_TIME;
        tStop: TREFERENCE_TIME;
        dwStartCookie: DWORD;
        dwStopCookie: DWORD;
        dwFlags: DWORD;
    end;


    IAMStreamControl = interface(IUnknown)
        ['{36b73881-c2c8-11cf-8b46-00805f6cef60}']
        function StartAt(const ptStart: PREFERENCE_TIME; dwCookie: DWORD): HResult; stdcall;
        function StopAt(const ptStop: PREFERENCE_TIME; bSendExtra: longbool; dwCookie: DWORD): HResult;
            stdcall;
        function GetInfo(out pInfo: TAM_STREAM_INFO): HResult;
            stdcall;
    end;

    ISeekingPassThru = interface(IUnknown)
        ['{36b73883-c2c8-11cf-8b46-00805f6cef60}']
        function Init(bSupportRendering: longbool; pPin: IPin): HResult; stdcall;
    end;

    TVIDEO_STREAM_CONFIG_CAPS = record
        GUID: TGUID;
        VideoStandard: ULONG;
        InputSize: SIZE;
        MinCroppingSize: SIZE;
        MaxCroppingSize: SIZE;
        CropGranularityX: integer;
        CropGranularityY: integer;
        CropAlignX: integer;
        CropAlignY: integer;
        MinOutputSize: SIZE;
        MaxOutputSize: SIZE;
        OutputGranularityX: integer;
        OutputGranularityY: integer;
        StretchTapsX: integer;
        StretchTapsY: integer;
        ShrinkTapsX: integer;
        ShrinkTapsY: integer;
        MinFrameInterval: LONGLONG;
        MaxFrameInterval: LONGLONG;
        MinBitsPerSecond: LONG;
        MaxBitsPerSecond: LONG;
    end;

    TAUDIO_STREAM_CONFIG_CAPS = record
        GUID: TGUID;
        MinimumChannels: ULONG;
        MaximumChannels: ULONG;
        ChannelsGranularity: ULONG;
        MinimumBitsPerSample: ULONG;
        MaximumBitsPerSample: ULONG;
        BitsPerSampleGranularity: ULONG;
        MinimumSampleFrequency: ULONG;
        MaximumSampleFrequency: ULONG;
        SampleFrequencyGranularity: ULONG;
    end;


    IAMStreamConfig = interface(IUnknown)
        ['{C6E13340-30AC-11d0-A18C-00A0C9118956}']
        function SetFormat(pmt: PAM_MEDIA_TYPE): HResult;
            stdcall;
        function GetFormat(out ppmt: PAM_MEDIA_TYPE): HResult;
            stdcall;
        function GetNumberOfCapabilities(out piCount: integer; out piSize: integer): HResult; stdcall;
        function GetStreamCaps(iIndex: integer; out ppmt: PAM_MEDIA_TYPE; out pSCC: PBYTE): HResult;
            stdcall;
    end;

    TInterleavingMode = (
        INTERLEAVE_NONE = 0,
        INTERLEAVE_CAPTURE = (INTERLEAVE_NONE + 1),
        INTERLEAVE_FULL = (INTERLEAVE_CAPTURE + 1),
        INTERLEAVE_NONE_BUFFERED = (INTERLEAVE_FULL + 1)
        );

    IConfigInterleaving = interface(IUnknown)
        ['{BEE3D220-157B-11d0-BD23-00A0C911CE86}']
        function put_Mode(mode: TInterleavingMode): HResult;
            stdcall;
        function get_Mode(out pMode: TInterleavingMode): HResult;
            stdcall;
        function put_Interleaving(const prtInterleave: PREFERENCE_TIME;
            const prtPreroll: PREFERENCE_TIME): HResult; stdcall;
        function get_Interleaving(out prtInterleave: TREFERENCE_TIME;
            out prtPreroll: TREFERENCE_TIME): HResult; stdcall;
    end;


    IConfigAviMux = interface(IUnknown)
        ['{5ACD6AA0-F482-11ce-8B67-00AA00A3F1A6}']
        function SetMasterStream(iStream: LONG): HResult;
            stdcall;
        function GetMasterStream(out pStream: LONG): HResult;
            stdcall;
        function SetOutputCompatibilityIndex(fOldIndex: longbool): HResult; stdcall;
        function GetOutputCompatibilityIndex(out pfOldIndex: longbool): HResult; stdcall;
    end;

    TCompressionCaps = (
        CompressionCaps_CanQuality = $1,
        CompressionCaps_CanCrunch = $2,
        CompressionCaps_CanKeyFrame = $4,
        CompressionCaps_CanBFrame = $8,
        CompressionCaps_CanWindow = $10
        );


    IAMVideoCompression = interface(IUnknown)
        ['{C6E13343-30AC-11d0-A18C-00A0C9118956}']
        function put_KeyFrameRate(KeyFrameRate: long): HResult;
            stdcall;
        function get_KeyFrameRate(out pKeyFrameRate: long): HResult;
            stdcall;
        function put_PFramesPerKeyFrame(PFramesPerKeyFrame: long): HResult; stdcall;
        function get_PFramesPerKeyFrame(out pPFramesPerKeyFrame: long): HResult; stdcall;
        function put_Quality(Quality: double): HResult; stdcall;
        function get_Quality(out pQuality: double): HResult;
            stdcall;
        function put_WindowSize(WindowSize: DWORDLONG): HResult;
            stdcall;
        function get_WindowSize(out pWindowSize: DWORDLONG): HResult;
            stdcall;
        function GetInfo(out pszVersion{pcbVersion}: LPWSTR; var pcbVersion: integer;
            out pszDescription{pcbDescription}: LPWSTR; var pcbDescription: integer;
            out pDefaultKeyFrameRate: long; out pDefaultPFramesPerKey: long;
            out pDefaultQuality: double; out pCapabilities: long): HResult; stdcall;
        function OverrideKeyFrame(FrameNumber: long): HResult;
            stdcall;
        function OverrideFrameSize(FrameNumber: long; Size: long): HResult; stdcall;
    end;


    TVfwCaptureDialogs = (
        VfwCaptureDialog_Source = $1,
        VfwCaptureDialog_Format = $2,
        VfwCaptureDialog_Display = $4
        );

    TVfwCompressDialogs = (
        VfwCompressDialog_Config = $1,
        VfwCompressDialog_About = $2,
        VfwCompressDialog_QueryConfig = $4,
        VfwCompressDialog_QueryAbout = $8
        );

    IAMVfwCaptureDialogs = interface(IUnknown)
        ['{D8D715A0-6E5E-11D0-B3F0-00AA003761C5}']
        function HasDialog(iDialog: integer): HResult; stdcall;
        function ShowDialog(iDialog: integer; hwnd: HWND): HResult; stdcall;
        function SendDriverMessage(iDialog: integer; uMsg: integer; dw1: long; dw2: long): HResult; stdcall;
    end;

    IAMVfwCompressDialogs = interface(IUnknown)
        ['{D8D715A3-6E5E-11D0-B3F0-00AA003761C5}']
        function ShowDialog(iDialog: integer; hwnd: HWND): HResult; stdcall;
        function GetState(out pState{pcbState}: pointer; var pcbState: integer): HResult; stdcall;
        function SetState(pState{cbState}: Pointer; cbState: integer): HResult; stdcall;
        function SendDriverMessage(uMsg: integer; dw1: long; dw2: long): HResult; stdcall;
    end;

    IAMDroppedFrames = interface(IUnknown)
        ['{C6E13344-30AC-11d0-A18C-00A0C9118956}']
        function GetNumDropped(out plDropped: long): HResult;
            stdcall;
        function GetNumNotDropped(out plNotDropped: long): HResult;
            stdcall;
        function GetDroppedInfo(lSize: long; out plArray: long; out plNumCopied: long): HResult;
            stdcall;
        function GetAverageFrameSize(out plAverageSize: long): HResult; stdcall;
    end;

    IAMAudioInputMixer = interface(IUnknown)
        ['{54C39221-8380-11d0-B3F0-00AA003761C5}']
        function put_Enable(fEnable: longbool): HResult; stdcall;
        function get_Enable(out pfEnable: longbool): HResult;
            stdcall;
        function put_Mono(fMono: longbool): HResult; stdcall;
        function get_Mono(out pfMono: longbool): HResult;
            stdcall;
        function put_MixLevel(Level: double): HResult; stdcall;
        function get_MixLevel(out pLevel: double): HResult;
            stdcall;
        function put_Pan(Pan: double): HResult; stdcall;
        function get_Pan(out pPan: double): HResult; stdcall;
        function put_Loudness(fLoudness: longbool): HResult;
            stdcall;
        function get_Loudness(out pfLoudness: longbool): HResult;
            stdcall;
        function put_Treble(Treble: double): HResult; stdcall;
        function get_Treble(out pTreble: double): HResult;
            stdcall;
        function get_TrebleRange(out pRange: double): HResult;
            stdcall;
        function put_Bass(Bass: double): HResult; stdcall;
        function get_Bass(out pBass: double): HResult; stdcall;
        function get_BassRange(out pRange: double): HResult;
            stdcall;
    end;


    IAMBufferNegotiation = interface(IUnknown)
        ['{56ED71A0-AF5F-11D0-B3F0-00AA003761C5}']
        function SuggestAllocatorProperties(const pprop: PALLOCATOR_PROPERTIES): HResult; stdcall;
        function GetAllocatorProperties(out pprop: TALLOCATOR_PROPERTIES): HResult; stdcall;
    end;

    TAnalogVideoStandard = (
        AnalogVideo_None = 0,
        AnalogVideo_NTSC_M = $1,
        AnalogVideo_NTSC_M_J = $2,
        AnalogVideo_NTSC_433 = $4,
        AnalogVideo_PAL_B = $10,
        AnalogVideo_PAL_D = $20,
        AnalogVideo_PAL_G = $40,
        AnalogVideo_PAL_H = $80,
        AnalogVideo_PAL_I = $100,
        AnalogVideo_PAL_M = $200,
        AnalogVideo_PAL_N = $400,
        AnalogVideo_PAL_60 = $800,
        AnalogVideo_SECAM_B = $1000,
        AnalogVideo_SECAM_D = $2000,
        AnalogVideo_SECAM_G = $4000,
        AnalogVideo_SECAM_H = $8000,
        AnalogVideo_SECAM_K = $10000,
        AnalogVideo_SECAM_K1 = $20000,
        AnalogVideo_SECAM_L = $40000,
        AnalogVideo_SECAM_L1 = $80000,
        AnalogVideo_PAL_N_COMBO = $100000,
        AnalogVideoMask_MCE_NTSC = Ord(AnalogVideo_NTSC_M) or Ord(AnalogVideo_NTSC_M_J) or
        Ord(AnalogVideo_NTSC_433) or Ord(AnalogVideo_PAL_M) or Ord(AnalogVideo_PAL_N) or
        Ord(AnalogVideo_PAL_60) or Ord(AnalogVideo_PAL_N_COMBO),
        AnalogVideoMask_MCE_PAL = Ord(AnalogVideo_PAL_B) or Ord(AnalogVideo_PAL_D) or
        Ord(AnalogVideo_PAL_G) or Ord(AnalogVideo_PAL_H) or Ord(AnalogVideo_PAL_I),
        AnalogVideoMask_MCE_SECAM = Ord(AnalogVideo_SECAM_B) or Ord(AnalogVideo_SECAM_D) or
        Ord(AnalogVideo_SECAM_G) or Ord(AnalogVideo_SECAM_H) or Ord(AnalogVideo_SECAM_K) or
        Ord(AnalogVideo_SECAM_K1) or Ord(AnalogVideo_SECAM_L) or Ord(AnalogVideo_SECAM_L1)
        );

    TTunerInputType = (
        TunerInputCable = 0,
        TunerInputAntenna = (TunerInputCable + 1)
        );

    TVideoCopyProtectionType = (
        VideoCopyProtectionMacrovisionBasic = 0,
        VideoCopyProtectionMacrovisionCBI =
        (VideoCopyProtectionMacrovisionBasic + 1)
        );

    TPhysicalConnectorType = (
        PhysConn_Video_Tuner = 1,
        PhysConn_Video_Composite = (PhysConn_Video_Tuner + 1),
        PhysConn_Video_SVideo = (PhysConn_Video_Composite + 1),
        PhysConn_Video_RGB = (PhysConn_Video_SVideo + 1),
        PhysConn_Video_YRYBY = (PhysConn_Video_RGB + 1),
        PhysConn_Video_SerialDigital = (PhysConn_Video_YRYBY + 1),
        PhysConn_Video_ParallelDigital = (PhysConn_Video_SerialDigital + 1),
        PhysConn_Video_SCSI = (PhysConn_Video_ParallelDigital + 1),
        PhysConn_Video_AUX = (PhysConn_Video_SCSI + 1),
        PhysConn_Video_1394 = (PhysConn_Video_AUX + 1),
        PhysConn_Video_USB = (PhysConn_Video_1394 + 1),
        PhysConn_Video_VideoDecoder = (PhysConn_Video_USB + 1),
        PhysConn_Video_VideoEncoder = (PhysConn_Video_VideoDecoder + 1),
        PhysConn_Video_SCART = (PhysConn_Video_VideoEncoder + 1),
        PhysConn_Video_Black = (PhysConn_Video_SCART + 1),
        PhysConn_Audio_Tuner = $1000,
        PhysConn_Audio_Line = (PhysConn_Audio_Tuner + 1),
        PhysConn_Audio_Mic = (PhysConn_Audio_Line + 1),
        PhysConn_Audio_AESDigital = (PhysConn_Audio_Mic + 1),
        PhysConn_Audio_SPDIFDigital = (PhysConn_Audio_AESDigital + 1),
        PhysConn_Audio_SCSI = (PhysConn_Audio_SPDIFDigital + 1),
        PhysConn_Audio_AUX = (PhysConn_Audio_SCSI + 1),
        PhysConn_Audio_1394 = (PhysConn_Audio_AUX + 1),
        PhysConn_Audio_USB = (PhysConn_Audio_1394 + 1),
        PhysConn_Audio_AudioDecoder = (PhysConn_Audio_USB + 1)
        );

    IAMAnalogVideoDecoder = interface(IUnknown)
        ['{C6E13350-30AC-11d0-A18C-00A0C9118956}']
        function get_AvailableTVFormats(out lAnalogVideoStandard: long): HResult; stdcall;
        function put_TVFormat(lAnalogVideoStandard: long): HResult;
            stdcall;
        function get_TVFormat(out plAnalogVideoStandard: long): HResult; stdcall;
        function get_HorizontalLocked(out plLocked: long): HResult;
            stdcall;
        function put_VCRHorizontalLocking(lVCRHorizontalLocking: long): HResult; stdcall;
        function get_VCRHorizontalLocking(out plVCRHorizontalLocking: long): HResult; stdcall;
        function get_NumberOfLines(out plNumberOfLines: long): HResult; stdcall;
        function put_OutputEnable(lOutputEnable: long): HResult;
            stdcall;
        function get_OutputEnable(out plOutputEnable: long): HResult;
            stdcall;
    end;

    TVideoProcAmpProperty = (
        VideoProcAmp_Brightness = 0,
        VideoProcAmp_Contrast = (VideoProcAmp_Brightness + 1),
        VideoProcAmp_Hue = (VideoProcAmp_Contrast + 1),
        VideoProcAmp_Saturation = (VideoProcAmp_Hue + 1),
        VideoProcAmp_Sharpness = (VideoProcAmp_Saturation + 1),
        VideoProcAmp_Gamma = (VideoProcAmp_Sharpness + 1),
        VideoProcAmp_ColorEnable = (VideoProcAmp_Gamma + 1),
        VideoProcAmp_WhiteBalance = (VideoProcAmp_ColorEnable + 1),
        VideoProcAmp_BacklightCompensation =
        (VideoProcAmp_WhiteBalance + 1),
        VideoProcAmp_Gain = (VideoProcAmp_BacklightCompensation + 1)
        );

    TVideoProcAmpFlags = (
        VideoProcAmp_Flags_Auto = $1,
        VideoProcAmp_Flags_Manual = $2
        );

    IAMVideoProcAmp = interface(IUnknown)
        ['{C6E13360-30AC-11d0-A18C-00A0C9118956}']
        function GetRange(_Property: long; out pMin: long; out pMax: long; out pSteppingDelta: long;
            out pDefault: long; out pCapsFlags: long): HResult; stdcall;
        function _Set(_Property: long; lValue: long; Flags: long): HResult; stdcall;
        function _Get(_Property: long; out lValue: long; out Flags: long): HResult; stdcall;
    end;

    TCameraControlProperty = (
        CameraControl_Pan = 0,
        CameraControl_Tilt = (CameraControl_Pan + 1),
        CameraControl_Roll = (CameraControl_Tilt + 1),
        CameraControl_Zoom = (CameraControl_Roll + 1),
        CameraControl_Exposure = (CameraControl_Zoom + 1),
        CameraControl_Iris = (CameraControl_Exposure + 1),
        CameraControl_Focus = (CameraControl_Iris + 1)
        );

    TCameraControlFlags = (
        CameraControl_Flags_Auto = $1,
        CameraControl_Flags_Manual = $2
        );

    IAMCameraControl = interface(IUnknown)
        ['{C6E13370-30AC-11d0-A18C-00A0C9118956}']
        function GetRange(_Property: long; out pMin: long; out pMax: long; out pSteppingDelta: long;
            out pDefault: long; out pCapsFlags: long): HResult; stdcall;
        function _Set(_Property: long; lValue: long; Flags: long): HResult; stdcall;
        function Get(_Property: long; out lValue: long; out Flags: long): HResult;
            stdcall;
    end;

    TVideoControlFlags = (
        VideoControlFlag_FlipHorizontal = $1,
        VideoControlFlag_FlipVertical = $2,
        VideoControlFlag_ExternalTriggerEnable = $4,
        VideoControlFlag_Trigger = $8
        );

    IAMVideoControl = interface(IUnknown)
        ['{6a2e0670-28e4-11d0-a18c-00a0c9118956}']
        function GetCaps(pPin: IPin; out pCapsFlags: long): HResult;
            stdcall;
        function SetMode(pPin: IPin; Mode: long): HResult; stdcall;
        function GetMode(pPin: IPin; out Mode: long): HResult;
            stdcall;
        function GetCurrentActualFrameRate(pPin: IPin; out ActualFrameRate: LONGLONG): HResult; stdcall;
        function GetMaxAvailableFrameRate(pPin: IPin; iIndex: long; Dimensions: SIZE;
            out MaxAvailableFrameRate: LONGLONG): HResult; stdcall;
        function GetFrameRateList(pPin: IPin; iIndex: long; Dimensions: SIZE; out ListSize: long;
            out FrameRates: PLONGLONG): HResult; stdcall;
    end;

    IAMCrossbar = interface(IUnknown)
        ['{C6E13380-30AC-11d0-A18C-00A0C9118956}']
        function get_PinCounts(out OutputPinCount: long; out InputPinCount: long): HResult; stdcall;
        function CanRoute(OutputPinIndex: long; InputPinIndex: long): HResult; stdcall;
        function Route(OutputPinIndex: long; InputPinIndex: long): HResult; stdcall;
        function get_IsRoutedTo(OutputPinIndex: long; out InputPinIndex: long): HResult; stdcall;
        function get_CrossbarPinInfo(IsInputPin: longbool; PinIndex: long; out PinIndexRelated: long;
            out PhysicalType: long): HResult; stdcall;
    end;


    TAMTunerSubChannel = (
        AMTUNER_SUBCHAN_NO_TUNE = -2,
        AMTUNER_SUBCHAN_DEFAULT = -1
        );

    TAMTunerSignalStrength = (
        AMTUNER_HASNOSIGNALSTRENGTH = -1,
        AMTUNER_NOSIGNAL = 0,
        AMTUNER_SIGNALPRESENT = 1
        );

    TAMTunerModeType = (
        AMTUNER_MODE_DEFAULT = 0,
        AMTUNER_MODE_TV = $1,
        AMTUNER_MODE_FM_RADIO = $2,
        AMTUNER_MODE_AM_RADIO = $4,
        AMTUNER_MODE_DSS = $8
        );

    TAMTunerEventType = (
        AMTUNER_EVENT_CHANGED = $1
        );

    IAMTuner = interface(IUnknown)
        ['{211A8761-03AC-11d1-8D13-00AA00BD8339}']
        function put_Channel(lChannel: long; lVideoSubChannel: long;
            lAudioSubChannel: long): HResult; stdcall;
        function get_Channel(out plChannel: long; out plVideoSubChannel: long;
            out plAudioSubChannel: long): HResult; stdcall;
        function ChannelMinMax(out lChannelMin: long; out lChannelMax: long): HResult; stdcall;
        function put_CountryCode(lCountryCode: long): HResult;
            stdcall;
        function get_CountryCode(out plCountryCode: long): HResult;
            stdcall;
        function put_TuningSpace(lTuningSpace: long): HResult;
            stdcall;
        function get_TuningSpace(out plTuningSpace: long): HResult;
            stdcall;
        function Logon(hCurrentUser: THANDLE): HResult; stdcall;
        function Logout(): HResult; stdcall;
        function SignalPresent(out plSignalStrength: long): HResult;
            stdcall;
        function put_Mode(lMode: TAMTunerModeType): HResult;
            stdcall;
        function get_Mode(out plMode: TAMTunerModeType): HResult;
            stdcall;
        function GetAvailableModes(out plModes: long): HResult;
            stdcall;
        function RegisterNotificationCallBack(pNotify: IAMTunerNotification;
            lEvents: long): HResult; stdcall;
        function UnRegisterNotificationCallBack(pNotify: IAMTunerNotification): HResult; stdcall;
    end;


    IAMTunerNotification = interface(IUnknown)
        ['{211A8760-03AC-11d1-8D13-00AA00BD8339}']
        function OnEvent(Event: TAMTunerEventType): HResult;
            stdcall;
    end;

    IAMTVTuner = interface(IAMTuner)
        ['{211A8766-03AC-11d1-8D13-00AA00BD8339}']
        function get_AvailableTVFormats(out lAnalogVideoStandard: long): HResult; stdcall;
        function get_TVFormat(out plAnalogVideoStandard: long): HResult; stdcall;
        function AutoTune(lChannel: long; out plFoundSignal: long): HResult; stdcall;
        function StoreAutoTune(): HResult; stdcall;
        function get_NumInputConnections(out plNumInputConnections: long): HResult; stdcall;
        function put_InputType(lIndex: long; InputType: TTunerInputType): HResult; stdcall;
        function get_InputType(lIndex: long; out pInputType: TTunerInputType): HResult; stdcall;
        function put_ConnectInput(lIndex: long): HResult;
            stdcall;
        function get_ConnectInput(out plIndex: long): HResult;
            stdcall;
        function get_VideoFrequency(out lFreq: long): HResult;
            stdcall;
        function get_AudioFrequency(out lFreq: long): HResult;
            stdcall;
    end;


    IBPCSatelliteTuner = interface(IAMTuner)
        ['{211A8765-03AC-11d1-8D13-00AA00BD8339}']
        function get_DefaultSubChannelTypes(out plDefaultVideoType: long;
            out plDefaultAudioType: long): HResult; stdcall;
        function put_DefaultSubChannelTypes(lDefaultVideoType: long;
            lDefaultAudioType: long): HResult; stdcall;
        function IsTapingPermitted(): HResult; stdcall;
    end;

    TTVAudioMode = (
        AMTVAUDIO_MODE_MONO = $1,
        AMTVAUDIO_MODE_STEREO = $2,
        AMTVAUDIO_MODE_LANG_A = $10,
        AMTVAUDIO_MODE_LANG_B = $20,
        AMTVAUDIO_MODE_LANG_C = $40,
        AMTVAUDIO_PRESET_STEREO = $200,
        AMTVAUDIO_PRESET_LANG_A = $1000,
        AMTVAUDIO_PRESET_LANG_B = $2000,
        AMTVAUDIO_PRESET_LANG_C = $4000
        );

    TAMTVAudioEventType = (
        AMTVAUDIO_EVENT_CHANGED = $1
        );


    IAMTVAudio = interface(IUnknown)
        ['{83EC1C30-23D1-11d1-99E6-00A0C9560266}']
        function GetHardwareSupportedTVAudioModes(out plModes: long): HResult; stdcall;
        function GetAvailableTVAudioModes(out plModes: long): HResult; stdcall;
        function get_TVAudioMode(out plMode: long): HResult;
            stdcall;
        function put_TVAudioMode(lMode: long): HResult; stdcall;
        function RegisterNotificationCallBack(pNotify: IAMTunerNotification;
            lEvents: long): HResult; stdcall;
        function UnRegisterNotificationCallBack(pNotify: IAMTunerNotification): HResult; stdcall;
    end;


    IAMTVAudioNotification = interface(IUnknown)
        ['{83EC1C33-23D1-11d1-99E6-00A0C9560266}']
        function OnEvent(Event: TAMTVAudioEventType): HResult;
            stdcall;
    end;

    IAMAnalogVideoEncoder = interface(IUnknown)
        ['{C6E133B0-30AC-11d0-A18C-00A0C9118956}']
        function get_AvailableTVFormats(out lAnalogVideoStandard: long): HResult; stdcall;
        function put_TVFormat(lAnalogVideoStandard: long): HResult;
            stdcall;
        function get_TVFormat(out plAnalogVideoStandard: long): HResult; stdcall;
        function put_CopyProtection(lVideoCopyProtection: long): HResult; stdcall;
        function get_CopyProtection(out lVideoCopyProtection: long): HResult; stdcall;
        function put_CCEnable(lCCEnable: long): HResult; stdcall;
        function get_CCEnable(out lCCEnable: long): HResult;
            stdcall;
    end;


    TAMPROPERTY_PIN = (
        AMPROPERTY_PIN_CATEGORY = 0,
        AMPROPERTY_PIN_MEDIUM = (AMPROPERTY_PIN_CATEGORY + 1)
        );

    IKsPropertySet = interface(IUnknown)
        ['{31EFAC30-515C-11d0-A9AA-00AA0061BE93}']
        function _Set(guidPropSet: PGUID; dwPropID: DWORD; pInstanceData{cbInstanceData}: pointer;
            cbInstanceData: DWORD; pPropData{cbPropData}: pointer; cbPropData: DWORD): HResult; stdcall;
        function Get(guidPropSet: PGUID; dwPropID: DWORD; pInstanceData{cbInstanceData}: pointer;
            cbInstanceData: DWORD; out pPropData {cbPropData, pcbReturned}: Pointer;
            cbPropData: DWORD; out pcbReturned: DWORD): HResult;
            stdcall;
        function QuerySupported(guidPropSet: PGUID; dwPropID: DWORD; out pTypeSupport: DWORD): HResult;
            stdcall;
    end;


    PMEDIAPROPERTYBAG = ^IMediaPropertyBag;

    IMediaPropertyBag = interface(IPropertyBag)
        ['{6025A880-C0D5-11d0-BD4E-00A0C911CE86}']
        function EnumProperty(iProperty: ULONG; var pvarPropertyName: TVARIANT;
            var pvarPropertyValue: TVARIANT): HResult; stdcall;
    end;

    PPERSISTMEDIAPROPERTYBAG = ^IPersistMediaPropertyBag;


    IPersistMediaPropertyBag = interface(IPersist)
        ['{5738E040-B67F-11d0-BD4D-00A0C911CE86}']
        function InitNew(): HResult; stdcall;
        function Load(pPropBag: IMediaPropertyBag; pErrorLog: IErrorLog): HResult; stdcall;
        function Save(pPropBag: IMediaPropertyBag; fClearDirty: longbool;
            fSaveAllProperties: longbool): HResult; stdcall;
    end;

    IAMPhysicalPinInfo = interface(IUnknown)
        ['{F938C991-3029-11cf-8C44-00AA006B6814}']
        function GetPhysicalType(out pType: long; out ppszType: POLESTR): HResult; stdcall;
    end;

    PAMPHYSICALPININFO = ^IAMPhysicalPinInfo;




    IAMExtDevice = interface(IUnknown)
        ['{B5730A90-1A2C-11cf-8C23-00AA006B6814}']
        function GetCapability(Capability: long; out pValue: long; out pdblValue: double): HResult;
            stdcall;
        function get_ExternalDeviceID(out ppszData: POLESTR): HResult; stdcall;
        function get_ExternalDeviceVersion(out ppszData: POLESTR): HResult; stdcall;
        function put_DevicePower(PowerMode: long): HResult;
            stdcall;
        function get_DevicePower(out pPowerMode: long): HResult;
            stdcall;
        function Calibrate(hEvent: THEVENT; Mode: long; out pStatus: long): HResult; stdcall;
        function put_DevicePort(DevicePort: long): HResult;
            stdcall;
        function get_DevicePort(out pDevicePort: long): HResult;
            stdcall;
    end;

    PEXTDEVICE = ^IAMExtDevice;

    IAMExtTransport = interface(IUnknown)
        ['{A03CD5F0-3045-11cf-8C44-00AA006B6814}']
        function GetCapability(Capability: long; out pValue: long; out pdblValue: double): HResult;
            stdcall;
        function put_MediaState(State: long): HResult; stdcall;
        function get_MediaState(out pState: long): HResult;
            stdcall;
        function put_LocalControl(State: long): HResult; stdcall;
        function get_LocalControl(out pState: long): HResult;
            stdcall;
        function GetStatus(StatusItem: long; out pValue: long): HResult; stdcall;
        function GetTransportBasicParameters(Param: long; var pValue: long;
            var ppszData: LPOLESTR): HResult;
            stdcall;
        function SetTransportBasicParameters(Param: long; Value: long; pszData: POLESTR): HResult; stdcall;
        function GetTransportVideoParameters(Param: long; out pValue: long): HResult; stdcall;
        function SetTransportVideoParameters(Param: long; Value: long): HResult; stdcall;
        function GetTransportAudioParameters(Param: long; out pValue: long): HResult; stdcall;
        function SetTransportAudioParameters(Param: long; Value: long): HResult; stdcall;
        function put_Mode(Mode: long): HResult; stdcall;
        function get_Mode(out pMode: long): HResult; stdcall;
        function put_Rate(dblRate: double): HResult; stdcall;
        function get_Rate(out pdblRate: double): HResult; stdcall;
        function GetChase(out pEnabled: long; out pOffset: long; out phEvent: THEVENT): HResult;
            stdcall;
        function SetChase(Enable: long; Offset: long; hEvent: THEVENT): HResult; stdcall;
        function GetBump(out pSpeed: long; out pDuration: long): HResult; stdcall;
        function SetBump(Speed: long; Duration: long): HResult;
            stdcall;
        function get_AntiClogControl(out pEnabled: long): HResult;
            stdcall;
        function put_AntiClogControl(Enable: long): HResult;
            stdcall;
        function GetEditPropertySet(EditID: long; out pState: long): HResult; stdcall;
        function SetEditPropertySet(var pEditID: long; State: long): HResult; stdcall;
        function GetEditProperty(EditID: long; Param: long; out pValue: long): HResult; stdcall;
        function SetEditProperty(EditID: long; Param: long; Value: long): HResult; stdcall;
        function get_EditStart(out pValue: long): HResult;
            stdcall;
        function put_EditStart(Value: long): HResult; stdcall;
    end;

    PIAMEXTTRANSPORT = ^IAMExtTransport;


    TTIMECODE = record
        case integer of
            0: (
                wFrameRate: word;
                wFrameFract: word;
                dwFrames: DWORD);
            1: (
                qw: DWORDLONG);
    end;

    TTIMECODE_SAMPLE = record
        qwTick: LONGLONG;
        timecode: TTIMECODE;
        dwUser: DWORD;
        dwFlags: DWORD;
    end;

    PTIMECODE = ^TTIMECODE;

    PTIMECODE_SAMPLE = ^TTIMECODE_SAMPLE;


    IAMTimecodeReader = interface(IUnknown)
        ['{9B496CE1-811B-11cf-8C77-00AA006B6814}']
        function GetTCRMode(Param: long; out pValue: long): HResult; stdcall;
        function SetTCRMode(Param: long; Value: long): HResult; stdcall;
        function put_VITCLine(Line: long): HResult; stdcall;
        function get_VITCLine(out pLine: long): HResult; stdcall;
        function GetTimecode(out pTimecodeSample: PTIMECODE_SAMPLE): HResult; stdcall;
    end;

    PIAMTIMECODEREADER = ^IAMTimecodeReader;

    IAMTimecodeGenerator = interface(IUnknown)
        ['{9B496CE0-811B-11cf-8C77-00AA006B6814}']
        function GetTCGMode(Param: long; out pValue: long): HResult; stdcall;
        function SetTCGMode(Param: long; Value: long): HResult; stdcall;
        function put_VITCLine(Line: long): HResult; stdcall;
        function get_VITCLine(out pLine: long): HResult;
            stdcall;
        function SetTimecode(pTimecodeSample: PTIMECODE_SAMPLE): HResult; stdcall;
        function GetTimecode(out pTimecodeSample: PTIMECODE_SAMPLE): HResult; stdcall;
    end;


    PIAMTIMECODEGENERATOR = ^IAMTimecodeGenerator;


    IAMTimecodeDisplay = interface(IUnknown)
        ['{9B496CE2-811B-11cf-8C77-00AA006B6814}']
        function GetTCDisplayEnable(out pState: long): HResult;
            stdcall;
        function SetTCDisplayEnable(State: long): HResult;
            stdcall;
        function GetTCDisplay(Param: long; out pValue: long): HResult; stdcall;
        function SetTCDisplay(Param: long; Value: long): HResult; stdcall;
    end;


    PIAMTIMECODEDISPLAY = ^IAMTimecodeDisplay;

    IAMDevMemoryAllocator = interface(IUnknown)
        ['{c6545bf0-e76b-11d0-bd52-00a0c911ce86}']
        function GetInfo(out pdwcbTotalFree: DWORD; out pdwcbLargestFree: DWORD;
            out pdwcbTotalMemory: DWORD; out pdwcbMinimumChunk: DWORD): HResult; stdcall;
        function CheckMemory(const pBuffer: PBYTE): HResult;
            stdcall;
        function Alloc(out ppBuffer {pdwcbBuffer}: PBYTE; var pdwcbBuffer: DWORD): HResult; stdcall;
        function Free(pBuffer: PBYTE): HResult; stdcall;
        function GetDevMemoryObject(out ppUnkInnner: IUnknown; pUnkOuter: IUnknown): HResult; stdcall;
    end;

    PAMDEVMEMORYALLOCATOR = IAMDevMemoryAllocator;

    IAMDevMemoryControl = interface(IUnknown)
        ['{c6545bf1-e76b-11d0-bd52-00a0c911ce86}']
        function QueryWriteSync(): HResult; stdcall;
        function WriteSync(): HResult; stdcall;
        function GetDevId(out pdwDevId: DWORD): HResult;
            stdcall;
    end;

    PAMDEVMEMORYCONTROL = ^IAMDevMemoryControl;

    TAMSTREAMSELECTINFOFLAGS = (
        AMSTREAMSELECTINFO_ENABLED = $1,
        AMSTREAMSELECTINFO_EXCLUSIVE = $2
        );

    TAMSTREAMSELECTENABLEFLAGS = (
        AMSTREAMSELECTENABLE_ENABLE = $1,
        AMSTREAMSELECTENABLE_ENABLEALL = $2
        );

    IAMStreamSelect = interface(IUnknown)
        ['{c1960960-17f5-11d1-abe1-00a0c905f375}']
        function Count(out pcStreams: DWORD): HResult; stdcall;
        function Info(lIndex: long; out ppmt: PAM_MEDIA_TYPE; out pdwFlags: DWORD;
            out plcid: LCID; out pdwGroup: DWORD; out ppszName: LPWSTR; out ppObject: IUnknown;
            out ppUnk: IUnknown): HResult; stdcall;
        function Enable(lIndex: long; dwFlags: DWORD): HResult;
            stdcall;
    end;

    PAMSTREAMSELECT = ^IAMStreamSelect;

    TAMRESCTL_RESERVEFLAGS = (
        AMRESCTL_RESERVEFLAGS_RESERVE = 0,
        AMRESCTL_RESERVEFLAGS_UNRESERVE = $1
        );

    IAMResourceControl = interface(IUnknown)
        ['{8389d2d0-77d7-11d1-abe6-00a0c905f375}']
        function Reserve(dwFlags: DWORD; pvReserved: Pointer): HResult; stdcall;
    end;


    IAMClockAdjust = interface(IUnknown)
        ['{4d5466b0-a49c-11d1-abe8-00a0c905f375}']
        function SetClockDelta(rtDelta: TREFERENCE_TIME): HResult;
            stdcall;
    end;


    TAM_FILTER_MISC_FLAGS = (
        AM_FILTER_MISC_FLAGS_IS_RENDERER = $1,
        AM_FILTER_MISC_FLAGS_IS_SOURCE = $2
        );


    IAMFilterMiscFlags = interface(IUnknown)
        ['{2dd74950-a890-11d1-abe8-00a0c905f375}']
        function GetMiscFlags(): ULONG; stdcall;
    end;


    IDrawVideoImage = interface(IUnknown)
        ['{48efb120-ab49-11d2-aed2-00a0c995e8d5}']
        function DrawVideoImageBegin(): HResult; stdcall;
        function DrawVideoImageEnd(): HResult; stdcall;
        function DrawVideoImageDraw(hdc: HDC; lprcSrc: LPRECT; lprcDst: LPRECT): HResult; stdcall;
    end;


    IDecimateVideoImage = interface(IUnknown)
        ['{2e5ea3e0-e924-11d2-b6da-00a0c995e8df}']
        function SetDecimationImageSize(lWidth: long; lHeight: long): HResult; stdcall;
        function ResetDecimationImageSize(): HResult; stdcall;
    end;


    TDECIMATION_USAGE = (
        DECIMATION_LEGACY = 0,
        DECIMATION_USE_DECODER_ONLY = (DECIMATION_LEGACY + 1),
        DECIMATION_USE_VIDEOPORT_ONLY = (DECIMATION_USE_DECODER_ONLY + 1),
        DECIMATION_USE_OVERLAY_ONLY = (DECIMATION_USE_VIDEOPORT_ONLY + 1),
        DECIMATION_DEFAULT = (DECIMATION_USE_OVERLAY_ONLY + 1)
        );

    IAMVideoDecimationProperties = interface(IUnknown)
        ['{60d32930-13da-11d3-9ec6-c4fcaef5c7be}']
        function QueryDecimationUsage(out lpUsage: TDECIMATION_USAGE): HResult; stdcall;
        function SetDecimationUsage(Usage: TDECIMATION_USAGE): HResult; stdcall;
    end;


    IVideoFrameStep = interface(IUnknown)
        ['{e46a9787-2b71-444d-a4b5-1fab7b708d6a}']
        function Step(dwFrames: DWORD; pStepObject: IUnknown = nil): HResult; stdcall;
        function CanStep(bMultiple: long; pStepObject: IUnknown = nil): HResult; stdcall;
        function CancelStep(): HResult; stdcall;
    end;


    TAM_PUSHSOURCE_FLAGS = (
        AM_PUSHSOURCECAPS_INTERNAL_RM = $1,
        AM_PUSHSOURCECAPS_NOT_LIVE = $2,
        AM_PUSHSOURCECAPS_PRIVATE_CLOCK = $4,
        AM_PUSHSOURCEREQS_USE_STREAM_CLOCK = $10000,
        AM_PUSHSOURCEREQS_USE_CLOCK_CHAIN = $20000
        );

    IAMLatency = interface(IUnknown)
        ['{62EA93BA-EC62-11d2-B770-00C04FB6BD3D}']
        function GetLatency(out prtLatency: TREFERENCE_TIME): HResult; stdcall;
    end;


    IAMPushSource = interface(IAMLatency)
        ['{F185FE76-E64E-11d2-B76E-00C04FB6BD3D}']
        function GetPushSourceFlags(out pFlags: ULONG): HResult;
            stdcall;
        function SetPushSourceFlags(Flags: ULONG): HResult;
            stdcall;
        function SetStreamOffset(rtOffset: TREFERENCE_TIME): HResult;
            stdcall;
        function GetStreamOffset(out prtOffset: TREFERENCE_TIME): HResult; stdcall;
        function GetMaxStreamOffset(out prtMaxOffset: TREFERENCE_TIME): HResult; stdcall;
        function SetMaxStreamOffset(rtMaxOffset: TREFERENCE_TIME): HResult; stdcall;
    end;


    IAMDeviceRemoval = interface(IUnknown)
        ['{f90a6130-b658-11d2-ae49-0000f8754b99}']
        function DeviceInfo(out pclsidInterfaceClass: CLSID; out pwszSymbolicLink: LPWSTR): HResult;
            stdcall;
        function Reassociate(): HResult; stdcall;
        function Disassociate(): HResult; stdcall;
    end;



    TDVINFO = record
        dwDVAAuxSrc: DWORD;
        dwDVAAuxCtl: DWORD;
        dwDVAAuxSrc1: DWORD;
        dwDVAAuxCtl1: DWORD;
        dwDVVAuxSrc: DWORD;
        dwDVVAuxCtl: DWORD;
        dwDVReserved: array [0..1] of DWORD;
    end;

    PDVINFO = ^TDVINFO;


    TDVENCODERRESOLUTION = (
        DVENCODERRESOLUTION_720x480 = 2012,
        DVENCODERRESOLUTION_360x240 = 2013,
        DVENCODERRESOLUTION_180x120 = 2014,
        DVENCODERRESOLUTION_88x60 = 2015
        );

    TDVENCODERVIDEOFORMAT = (
        DVENCODERVIDEOFORMAT_NTSC = 2000,
        DVENCODERVIDEOFORMAT_PAL = 2001
        );

    TDVENCODERFORMAT = (
        DVENCODERFORMAT_DVSD = 2007,
        DVENCODERFORMAT_DVHD = 2008,
        DVENCODERFORMAT_DVSL = 2009
        );

    IDVEnc = interface(IUnknown)
        ['{d18e17a0-aacb-11d0-afb0-00aa00b67a42}']
        function get_IFormatResolution(out VideoFormat: integer; out DVFormat: integer;
            out Resolution: integer; fDVInfo: byte; out sDVInfo: TDVINFO): HResult;
            stdcall;
        function put_IFormatResolution(VideoFormat: integer; DVFormat: integer;
            Resolution: integer; fDVInfo: byte; sDVInfo: PDVINFO): HResult; stdcall;
    end;


    TDVDECODERRESOLUTION = (
        DVDECODERRESOLUTION_720x480 = 1000,
        DVDECODERRESOLUTION_360x240 = 1001,
        DVDECODERRESOLUTION_180x120 = 1002,
        DVDECODERRESOLUTION_88x60 = 1003
        );

    TDVRESOLUTION = (
        DVRESOLUTION_FULL = 1000,
        DVRESOLUTION_HALF = 1001,
        DVRESOLUTION_QUARTER = 1002,
        DVRESOLUTION_DC = 1003
        );


    IIPDVDec = interface(IUnknown)
        ['{b8e8bd60-0bfe-11d0-af91-00aa00b67a42}']
        function get_IPDisplay(out displayPix: integer): HResult;
            stdcall;
        function put_IPDisplay(displayPix: integer): HResult;
            stdcall;
    end;

    IDVRGB219 = interface(IUnknown)
        ['{58473A19-2BC8-4663-8012-25F81BABDDD1}']
        function SetRGB219(bState: longbool): HResult; stdcall;
    end;

    IDVSplitter = interface(IUnknown)
        ['{92a3a302-da7c-4a1f-ba7e-1802bb5d2d02}']
        function DiscardAlternateVideoFrames(nDiscard: integer): HResult; stdcall;
    end;

    TAM_AUDIO_RENDERER_STAT_PARAM = (
        AM_AUDREND_STAT_PARAM_BREAK_COUNT = 1,
        AM_AUDREND_STAT_PARAM_SLAVE_MODE =
        (AM_AUDREND_STAT_PARAM_BREAK_COUNT + 1),
        AM_AUDREND_STAT_PARAM_SILENCE_DUR =
        (AM_AUDREND_STAT_PARAM_SLAVE_MODE + 1),
        AM_AUDREND_STAT_PARAM_LAST_BUFFER_DUR =
        (AM_AUDREND_STAT_PARAM_SILENCE_DUR + 1),
        AM_AUDREND_STAT_PARAM_DISCONTINUITIES =
        (AM_AUDREND_STAT_PARAM_LAST_BUFFER_DUR + 1),
        AM_AUDREND_STAT_PARAM_SLAVE_RATE =
        (AM_AUDREND_STAT_PARAM_DISCONTINUITIES + 1),
        AM_AUDREND_STAT_PARAM_SLAVE_DROPWRITE_DUR =
        (AM_AUDREND_STAT_PARAM_SLAVE_RATE + 1),
        AM_AUDREND_STAT_PARAM_SLAVE_HIGHLOWERROR =
        (AM_AUDREND_STAT_PARAM_SLAVE_DROPWRITE_DUR + 1),
        AM_AUDREND_STAT_PARAM_SLAVE_LASTHIGHLOWERROR =
        (AM_AUDREND_STAT_PARAM_SLAVE_HIGHLOWERROR + 1),
        AM_AUDREND_STAT_PARAM_SLAVE_ACCUMERROR =
        (AM_AUDREND_STAT_PARAM_SLAVE_LASTHIGHLOWERROR + 1),
        AM_AUDREND_STAT_PARAM_BUFFERFULLNESS =
        (AM_AUDREND_STAT_PARAM_SLAVE_ACCUMERROR + 1),
        AM_AUDREND_STAT_PARAM_JITTER =
        (AM_AUDREND_STAT_PARAM_BUFFERFULLNESS + 1)
        );

    IAMAudioRendererStats = interface(IUnknown)
        ['{22320CB2-D41A-11d2-BF7C-D7CB9DF0BF93}']
        function GetStatParam(dwParam: DWORD; out pdwParam1: DWORD; out pdwParam2: DWORD): HResult; stdcall;
    end;


    TAM_INTF_SEARCH_FLAGS = (
        AM_INTF_SEARCH_INPUT_PIN = $1,
        AM_INTF_SEARCH_OUTPUT_PIN = $2,
        AM_INTF_SEARCH_FILTER = $4
        );


    IAMGraphStreams = interface(IUnknown)
        ['{632105FA-072E-11d3-8AF9-00C04FB6BD3D}']
        function FindUpstreamInterface(pPin: IPin; riid: REFIID; out ppvInterface: pointer;
            dwFlags: DWORD): HResult; stdcall;
        function SyncUsingStreamOffset(bUseStreamOffset: longbool): HResult; stdcall;
        function SetMaxGraphLatency(rtMaxGraphLatency: TREFERENCE_TIME): HResult; stdcall;
    end;

    TAMOVERLAYFX = (
        AMOVERFX_NOFX = 0,
        AMOVERFX_MIRRORLEFTRIGHT = $2,
        AMOVERFX_MIRRORUPDOWN = $4,
        AMOVERFX_DEINTERLACE = $8
        );


    IAMOverlayFX = interface(IUnknown)
        ['{62fae250-7e65-4460-bfc9-6398b322073c}']
        function QueryOverlayFXCaps(out lpdwOverlayFXCaps: DWORD): HResult; stdcall;
        function SetOverlayFX(dwOverlayFX: DWORD): HResult;
            stdcall;
        function GetOverlayFX(out lpdwOverlayFX: DWORD): HResult;
            stdcall;
    end;


    IAMOpenProgress = interface(IUnknown)
        ['{8E1C39A1-DE53-11cf-AA63-0080C744528D}']
        function QueryProgress(out pllTotal: LONGLONG; out pllCurrent: LONGLONG): HResult; stdcall;
        function AbortOperation(): HResult; stdcall;
    end;


    IMpeg2Demultiplexer = interface(IUnknown)
        ['{436eee9c-264f-4242-90e1-4e330c107512}']
        function CreateOutputPin(pMediaType: PAM_MEDIA_TYPE; pszPinName: LPWSTR; out ppIPin: IPin): HResult;
            stdcall;
        function SetOutputPinMediaType(pszPinName: LPWSTR; pMediaType: PAM_MEDIA_TYPE): HResult; stdcall;
        function DeleteOutputPin(pszPinName: LPWSTR): HResult;
            stdcall;
    end;

    TSTREAM_ID_MAP = record
        stream_id: ULONG;
        dwMediaSampleContent: DWORD;
        ulSubstreamFilterValue: ULONG;
        iDataOffset: integer;
    end;
    PSTREAM_ID_MAP = ^TSTREAM_ID_MAP;


    IEnumStreamIdMap = interface(IUnknown)
        ['{945C1566-6202-46fc-96C7-D87F289C6534}']
        function Next(cRequest: ULONG; out pStreamIdMap{cRequest, pcReceived}: PSTREAM_ID_MAP;
            out pcReceived: ULONG): HResult; stdcall;
        function Skip(cRecords: ULONG): HResult; stdcall;
        function Reset(): HResult; stdcall;
        function Clone(out ppIEnumStreamIdMap: IEnumStreamIdMap): HResult; stdcall;
    end;


    IMPEG2StreamIdMap = interface(IUnknown)
        ['{D0E04C47-25B8-4369-925A-362A01D95444}']
        function MapStreamId(ulStreamId: ULONG; MediaSampleContent: DWORD;
            ulSubstreamFilterValue: ULONG; iDataOffset: integer): HResult; stdcall;
        function UnmapStreamId(culStreamId: ULONG; pulStreamId {culStreamId}: PULONG): HResult; stdcall;
        function EnumStreamIdMap(out ppIEnumStreamIdMap: IEnumStreamIdMap): HResult; stdcall;
    end;

    IRegisterServiceProvider = interface(IUnknown)
        ['{7B3A2F01-0751-48DD-B556-004785171C54}']
        function RegisterService(guidService: PGUID; pUnkObject: IUnknown): HResult; stdcall;
    end;

    IAMClockSlave = interface(IUnknown)
        ['{9FD52741-176D-4b36-8F51-CA8F933223BE}']
        function SetErrorTolerance(dwTolerance: DWORD): HResult;
            stdcall;
        function GetErrorTolerance(out pdwTolerance: DWORD): HResult;
            stdcall;
    end;


    IAMGraphBuilderCallback = interface(IUnknown)
        ['{4995f511-9ddb-4f12-bd3b-f04611807b79}']
        function SelectedFilter(pMon: IMoniker): HResult;
            stdcall;
        function CreatedFilter(pFil: IBaseFilter): HResult;
            stdcall;
    end;

    // Note: Because this interface was not defined as a proper interface it is
    //       supported under C++ only. Methods aren't stdcall.

(* ToDo
interface IAMFilterGraphCallback  = interface (IUnknown)
['{56a868fd-0ad4-11ce-b0a3-0020af0ba770}']
    // S_OK means rendering complete, S_FALSE means retry now.
    function UnableToRender(pPin:IPin): HResult;

end;
   *)


    IGetCapabilitiesKey = interface(IUnknown)
        ['{a8809222-07bb-48ea-951c-33158100625b}']
        function GetCapabilitiesKey(out pHKey: HKEY): HResult;
            stdcall;
    end;

    IEncoderAPI = interface(IUnknown)
        ['{70423839-6ACC-4b23-B079-21DBF08156A5}']
        function IsSupported(const Api: PGUID): HResult; stdcall;
        function IsAvailable(const Api: PGUID): HResult; stdcall;
        function GetParameterRange(const Api: PGUID; out ValueMin: TVARIANT; out ValueMax: TVARIANT;
            out SteppingDelta: TVARIANT): HResult; stdcall;
        function GetParameterValues(const Api: PGUID; out Values {ValuesCount}: PVARIANT;
            out ValuesCount: ULONG): HResult; stdcall;
        function GetDefaultValue(const Api: PGUID; out Value: TVARIANT): HResult; stdcall;
        function GetValue(const Api: PGUID; out Value: TVARIANT): HResult; stdcall;
        function SetValue(const Api: PGUID; Value: TVARIANT): HResult; stdcall;
    end;

    IVideoEncoder = interface(IEncoderAPI)
        ['{02997C3B-8E1B-460e-9270-545E0DE9563E}']
    end;

    TVIDEOENCODER_BITRATE_MODE = (
        ConstantBitRate = 0,
        VariableBitRateAverage = (ConstantBitRate + 1),
        VariableBitRatePeak = (VariableBitRateAverage + 1)
        );


    IAMDecoderCaps = interface(IUnknown)
        ['{c0dff467-d499-4986-972b-e1d9090fa941}']
        function GetDecoderCaps(dwCapIndex: DWORD; out lpdwCap: DWORD): HResult; stdcall;
    end;

    TAMCOPPSignature = record
        Signature: array [0.. 255] of byte;
    end;

    PAMCOPPSignature = ^TAMCOPPSignature;

    TAMCOPPCommand = record
        macKDI: TGUID;
        guidCommandID: TGUID;
        dwSequence: DWORD;
        cbSizeData: DWORD;
        CommandData: array[0.. 4055] of byte;
    end;

    PAMCOPPCommand = ^TAMCOPPCommand;

    TAMCOPPStatusInput = record
        rApp: TGUID;
        guidStatusRequestID: TGUID;
        dwSequence: DWORD;
        cbSizeData: DWORD;
        StatusData: array[0.. 4055] of byte;
    end;

    PAMCOPPStatusInput = ^TAMCOPPStatusInput;

    TAMCOPPStatusOutput = record
        macKDI: TGUID;
        cbSizeData: DWORD;
        COPPStatus: array[0.. 4075] of byte;
    end;

    PAMCOPPStatusOutput = ^TAMCOPPStatusOutput;

    IAMCertifiedOutputProtection = interface(IUnknown)
        ['{6feded3e-0ff1-4901-a2f1-43f7012c8515}']
        function KeyExchange(out pRandom: TGUID; out VarLenCertGH{pdwLengthCertGH}: PBYTE;
            out pdwLengthCertGH: DWORD): HResult; stdcall;
        function SessionSequenceStart(pSig: PAMCOPPSignature): HResult; stdcall;
        function ProtectionCommand(const cmd: PAMCOPPCommand): HResult; stdcall;
        function ProtectionStatus(const pStatusInput: PAMCOPPStatusInput;
            out pStatusOutput: TAMCOPPStatusOutput): HResult; stdcall;
    end;

    IAMAsyncReaderTimestampScaling = interface(IUnknown)
        ['{cf7b26fc-9a00-485b-8147-3e789d5e8f67}']
        function GetTimestampMode(out pfRaw: longbool): HResult;
            stdcall;
        function SetTimestampMode(fRaw: longbool): HResult;
            stdcall;
    end;

    IAMPluginControl = interface(IUnknown)
        ['{0e26a181-f40c-4635-8786-976284b52981}']
        function GetPreferredClsid(subType: PGUID; out clsid: CLSID): HResult; stdcall;
        function GetPreferredClsidByIndex(index: DWORD; out subType: TGUID; out clsid: CLSID): HResult;
            stdcall;
        function SetPreferredClsid(subType: PGUID; const clsid: PCLSID): HResult; stdcall;
        function IsDisabled(clsid: PCLSID): HResult; stdcall;
        function GetDisabledByIndex(index: DWORD; out clsid: CLSID): HResult; stdcall;
        function SetDisabled(clsid: PCLSID; disabled: longbool): HResult; stdcall;
        function IsLegacyDisabled(dllName: LPCWSTR): HResult;
            stdcall;
    end;

    IPinConnection = interface(IUnknown)
        ['{4a9a62d3-27d4-403d-91e9-89f540e55534}']
        function DynamicQueryAccept(const pmt: PAM_MEDIA_TYPE): HResult; stdcall;
        function NotifyEndOfStream(hNotifyEvent: THANDLE): HResult; stdcall;
        function IsEndPin(): HResult; stdcall;
        function DynamicDisconnect(): HResult; stdcall;
    end;

    IPinFlowControl = interface(IUnknown)
        ['{c56e9858-dbf3-4f6b-8119-384af2060deb}']
        function Block(dwBlockFlags: DWORD; hEvent: THANDLE): HResult; stdcall;
    end;

    TAM_PIN_FLOW_CONTROL_BLOCK_FLAGS = (
        AM_PIN_FLOW_CONTROL_BLOCK = $1
        );

    TAM_GRAPH_CONFIG_RECONNECT_FLAGS = (
        AM_GRAPH_CONFIG_RECONNECT_DIRECTCONNECT = $1,
        AM_GRAPH_CONFIG_RECONNECT_CACHE_REMOVED_FILTERS = $2,
        AM_GRAPH_CONFIG_RECONNECT_USE_ONLY_CACHED_FILTERS = $4
        );

    TREM_FILTER_FLAGS = (
        REMFILTERF_LEAVECONNECTED = $1
        );

    TAM_FILTER_FLAGSHANDLE = (
        AM_FILTER_FLAGS_REMOVABLE = $1
        );


    IGraphConfig = interface(IUnknown)
        ['{03A1EB8E-32BF-4245-8502-114D08A9CB88}']
        function Reconnect(pOutputPin: IPin; pInputPin: IPin; const pmtFirstConnection: PAM_MEDIA_TYPE;
            pUsingFilter: IBaseFilter; hAbortEvent: THANDLE; dwFlags: DWORD): HResult; stdcall;
        function Reconfigure(pCallback: IGraphConfigCallback; pvContext: pointer;
            dwFlags: DWORD; hAbortEvent: THANDLE): HResult; stdcall;
        function AddFilterToCache(pFilter: IBaseFilter): HResult;
            stdcall;
        function EnumCacheFilter(out pEnum: IEnumFilters): HResult;
            stdcall;
        function RemoveFilterFromCache(pFilter: IBaseFilter): HResult; stdcall;
        function GetStartTime(out prtStart: TREFERENCE_TIME): HResult; stdcall;
        function PushThroughData(pOutputPin: IPin; pConnection: IPinConnection;
            hEventAbort: THANDLE): HResult; stdcall;
        function SetFilterFlags(pFilter: IBaseFilter; dwFlags: DWORD): HResult; stdcall;
        function GetFilterFlags(pFilter: IBaseFilter; out pdwFlags: DWORD): HResult; stdcall;
        function RemoveFilterEx(pFilter: IBaseFilter; Flags: DWORD): HResult; stdcall;
    end;


    IGraphConfigCallback = interface(IUnknown)
        ['{ade0fd60-d19d-11d2-abf6-00a0c905f375}']
        function Reconfigure(pvContext: pointer; dwFlags: DWORD): HResult; stdcall;
    end;


    IFilterChain = interface(IUnknown)
        ['{DCFBDCF6-0DC2-45f5-9AB2-7C330EA09C29}']
        function StartChain(pStartFilter: IBaseFilter; pEndFilter: IBaseFilter): HResult; stdcall;
        function PauseChain(pStartFilter: IBaseFilter; pEndFilter: IBaseFilter): HResult; stdcall;
        function StopChain(pStartFilter: IBaseFilter; pEndFilter: IBaseFilter): HResult; stdcall;
        function RemoveChain(pStartFilter: IBaseFilter; pEndFilter: IBaseFilter): HResult; stdcall;
    end;


    TDDCOLORKEY = record
        dw1: DWORD;
        dw2: DWORD;
    end;

    PDDCOLORKEY = ^TDDCOLORKEY;

    TVMRPresentationFlags = (
        VMRSample_SyncPoint = $1,
        VMRSample_Preroll = $2,
        VMRSample_Discontinuity = $4,
        VMRSample_TimeValid = $8,
        VMRSample_SrcDstRectsValid = $10
        );



    TVMRPRESENTATIONINFO = record
        dwFlags: DWORD;
        lpSurf: PDirectDrawSurface7;
        rtStart: TREFERENCE_TIME;
        rtEnd: TREFERENCE_TIME;
        szAspectRatio: SIZE;
        rcSrc: TRECT;
        rcDst: TRECT;
        dwTypeSpecificFlags: DWORD;
        dwInterlaceFlags: DWORD;
    end;

    PVMRPRESENTATIONINFO = ^TVMRPRESENTATIONINFO;

    IVMRImagePresenter = interface(IUnknown)
        ['{CE704FE7-E71E-41fb-BAA2-C4403E1182F5}']
        function StartPresenting(dwUserID: DWORD_PTR): HResult;
            stdcall;
        function StopPresenting(dwUserID: DWORD_PTR): HResult;
            stdcall;
        function PresentImage(dwUserID: DWORD_PTR; lpPresInfo: PVMRPRESENTATIONINFO): HResult; stdcall;
    end;

    TVMRSurfaceAllocationFlags = (
        AMAP_PIXELFORMAT_VALID = $1,
        AMAP_3D_TARGET = $2,
        AMAP_ALLOW_SYSMEM = $4,
        AMAP_FORCE_SYSMEM = $8,
        AMAP_DIRECTED_FLIP = $10,
        AMAP_DXVA_TARGET = $20
        );

    PVMRSurfaceAllocationFlags = ^TVMRSurfaceAllocationFlags;

    TVMRALLOCATIONINFO = record
        dwFlags: DWORD;
        lpHdr: PBITMAPINFOHEADER;
        lpPixFmt: PDDPIXELFORMAT;
        szAspectRatio: SIZE;
        dwMinBuffers: DWORD;
        dwMaxBuffers: DWORD;
        dwInterlaceFlags: DWORD;
        szNativeSize: SIZE;
    end;
    PVMRALLOCATIONINFO = ^TVMRALLOCATIONINFO;

    IVMRSurfaceAllocator = interface(IUnknown)
        ['{31ce832e-4484-458b-8cca-f4d7e3db0b52}']
        function AllocateSurface(dwUserID: DWORD_PTR; lpAllocInfo: PVMRALLOCATIONINFO;
            var lpdwActualBuffers: DWORD; out lplpSurface: PDIRECTDRAWSURFACE7): HResult; stdcall;
        function FreeSurface(dwID: DWORD_PTR): HResult; stdcall;
        function PrepareSurface(dwUserID: DWORD_PTR; lpSurface: PDIRECTDRAWSURFACE7;
            dwSurfaceFlags: DWORD): HResult; stdcall;
        function AdviseNotify(lpIVMRSurfAllocNotify: IVMRSurfaceAllocatorNotify): HResult;
            stdcall;
    end;


    IVMRSurfaceAllocatorNotify = interface(IUnknown)
        ['{aada05a8-5a4e-4729-af0b-cea27aed51e2}']
        function AdviseSurfaceAllocator(dwUserID: DWORD_PTR;
            lpIVRMSurfaceAllocator: IVMRSurfaceAllocator): HResult; stdcall;
        function SetDDrawDevice(lpDDrawDevice: PDIRECTDRAW7; hMonitor: THMONITOR): HResult; stdcall;
        function ChangeDDrawDevice(lpDDrawDevice: PDIRECTDRAW7; hMonitor: THMONITOR): HResult; stdcall;
        function RestoreDDrawSurfaces(): HResult; stdcall;
        function NotifyEvent(EventCode: LONG; Param1: LONG_PTR; Param2: LONG_PTR): HResult; stdcall;
        function SetBorderColor(clrBorder: TCOLORREF): HResult;
            stdcall;
    end;


    TVMR_ASPECT_RATIO_MODE = (
        VMR_ARMODE_NONE = 0,
        VMR_ARMODE_LETTER_BOX = (VMR_ARMODE_NONE + 1)
        );

    IVMRWindowlessControl = interface(IUnknown)
        ['{0eb1088c-4dcd-46f0-878f-39dae86a51b7}']
        function GetNativeVideoSize(out lpWidth: LONG; out lpHeight: LONG; out lpARWidth: LONG;
            out lpARHeight: LONG): HResult; stdcall;
        function GetMinIdealVideoSize(out lpWidth: LONG; out lpHeight: LONG): HResult; stdcall;
        function GetMaxIdealVideoSize(out lpWidth: LONG; out lpHeight: LONG): HResult; stdcall;
        function SetVideoPosition(const lpSRCRect: PRECT; const lpDSTRect: PRECT): HResult; stdcall;
        function GetVideoPosition(out lpSRCRect: TRECT; out lpDSTRect: TRECT): HResult; stdcall;
        function GetAspectRatioMode(out lpAspectRatioMode: DWORD): HResult; stdcall;
        function SetAspectRatioMode(AspectRatioMode: DWORD): HResult;
            stdcall;
        function SetVideoClippingWindow(hwnd: HWND): HResult;
            stdcall;
        function RepaintVideo(hwnd: HWND; hdc: HDC): HResult;
            stdcall;
        function DisplayModeChanged(): HResult; stdcall;
        function GetCurrentImage(out lpDib: PBYTE): HResult;
            stdcall;
        function SetBorderColor(Clr: TCOLORREF): HResult;
            stdcall;
        function GetBorderColor(out lpClr: TCOLORREF): HResult;
            stdcall;
        function SetColorKey(Clr: TCOLORREF): HResult; stdcall;
        function GetColorKey(out lpClr: TCOLORREF): HResult;
            stdcall;
    end;


    TVMRMixerPrefs = (
        MixerPref_NoDecimation = $1,
        MixerPref_DecimateOutput = $2,
        MixerPref_ARAdjustXorY = $4,
        MixerPref_DecimationReserved = $8,
        MixerPref_DecimateMask = $f,
        MixerPref_BiLinearFiltering = $10,
        MixerPref_PointFiltering = $20,
        MixerPref_FilteringMask = $f0,
        MixerPref_RenderTargetRGB = $100,
        MixerPref_RenderTargetYUV = $1000,
        MixerPref_RenderTargetYUV420 = $200,
        MixerPref_RenderTargetYUV422 = $400,
        MixerPref_RenderTargetYUV444 = $800,
        MixerPref_RenderTargetReserved = $e000,
        MixerPref_RenderTargetMask = $ff00,
        MixerPref_DynamicSwitchToBOB = $10000,
        MixerPref_DynamicDecimateBy2 = $20000,
        MixerPref_DynamicReserved = $c0000,
        MixerPref_DynamicMask = $f0000
        );

    TNORMALIZEDRECT = record
        left: single;
        top: single;
        right: single;
        bottom: single;
    end;

    PNORMALIZEDRECT = ^TNORMALIZEDRECT;

    IVMRMixerControl = interface(IUnknown)
        ['{1c1a17b0-bed0-415d-974b-dc6696131599}']
        function SetAlpha(dwStreamID: DWORD; Alpha: single): HResult; stdcall;
        function GetAlpha(dwStreamID: DWORD; out pAlpha: single): HResult; stdcall;
        function SetZOrder(dwStreamID: DWORD; dwZ: DWORD): HResult; stdcall;
        function GetZOrder(dwStreamID: DWORD; out pZ: DWORD): HResult; stdcall;
        function SetOutputRect(dwStreamID: DWORD; const pRect: PNORMALIZEDRECT): HResult; stdcall;
        function GetOutputRect(dwStreamID: DWORD; out pRect: TNORMALIZEDRECT): HResult; stdcall;
        function SetBackgroundClr(ClrBkg: TCOLORREF): HResult;
            stdcall;
        function GetBackgroundClr(lpClrBkg: PCOLORREF): HResult;
            stdcall;
        function SetMixingPrefs(dwMixerPrefs: DWORD): HResult;
            stdcall;
        function GetMixingPrefs(out pdwMixerPrefs: DWORD): HResult;
            stdcall;
    end;

    TVMRGUID = record
        pGUID: PGUID;
        GUID: TGUID;
    end;

    PVMRGUID = ^TVMRGUID;

    TVMRMONITORINFO = record
        GUID: TVMRGUID;
        rcMonitor: TRECT;
        hMon: THMONITOR;
        dwFlags: DWORD;
        szDevice: array[0.. 31] of widechar;
        szDescription: array[0..255] of widechar;
        liDriverVersion: LARGE_INTEGER;
        dwVendorId: DWORD;
        dwDeviceId: DWORD;
        dwSubSysId: DWORD;
        dwRevision: DWORD;
    end;

    PVMRMONITORINFO = ^TVMRMONITORINFO;

    IVMRMonitorConfig = interface(IUnknown)
        ['{9cf0b1b6-fbaa-4b7f-88cf-cf1f130a0dce}']
        function SetMonitor(const pGUID: PVMRGUID): HResult;
            stdcall;
        function GetMonitor(out pGUID: TVMRGUID): HResult;
            stdcall;
        function SetDefaultMonitor(const pGUID: PVMRGUID): HResult;
            stdcall;
        function GetDefaultMonitor(out pGUID: TVMRGUID): HResult;
            stdcall;
        function GetAvailableMonitors(out pInfo{arraysize}: PVMRMONITORINFO;
            dwMaxInfoArraySize: DWORD; out pdwNumDevices: DWORD): HResult; stdcall;
    end;

    TVMRRenderPrefs = (
        RenderPrefs_RestrictToInitialMonitor = 0,
        RenderPrefs_ForceOffscreen = $1,
        RenderPrefs_ForceOverlays = $2,
        RenderPrefs_AllowOverlays = 0,
        RenderPrefs_AllowOffscreen = 0,
        RenderPrefs_DoNotRenderColorKeyAndBorder = $8,
        RenderPrefs_Reserved = $10,
        RenderPrefs_PreferAGPMemWhenMixing = $20,
        RenderPrefs_Mask = $3f
        );

    TVMRMode = (
        VMRMode_Windowed = $1,
        VMRMode_Windowless = $2,
        VMRMode_Renderless = $4,
        VMRMode_Mask = $7
        );

    IVMRFilterConfig = interface(IUnknown)
        ['{9e5530c5-7034-48b4-bb46-0b8a6efc8e36}']
        function SetImageCompositor(lpVMRImgCompositor: IVMRImageCompositor): HResult; stdcall;
        function SetNumberOfStreams(dwMaxStreams: DWORD): HResult;
            stdcall;
        function GetNumberOfStreams(out pdwMaxStreams: DWORD): HResult; stdcall;
        function SetRenderingPrefs(dwRenderFlags: DWORD): HResult;
            stdcall;
        function GetRenderingPrefs(out pdwRenderFlags: DWORD): HResult; stdcall;
        function SetRenderingMode(Mode: DWORD): HResult; stdcall;
        function GetRenderingMode(out pMode: DWORD): HResult;
            stdcall;
    end;

    IVMRAspectRatioControl = interface(IUnknown)
        ['{ede80b5c-bad6-4623-b537-65586c9f8dfd}']
        function GetAspectRatioMode(out lpdwARMode: DWORD): HResult;
            stdcall;
        function SetAspectRatioMode(dwARMode: DWORD): HResult;
            stdcall;
    end;


    TVMRDeinterlacePrefs = (
        DeinterlacePref_NextBest = $1,
        DeinterlacePref_BOB = $2,
        DeinterlacePref_Weave = $4,
        DeinterlacePref_Mask = $7
        );

    TVMRDeinterlaceTech = (
        DeinterlaceTech_Unknown = 0,
        DeinterlaceTech_BOBLineReplicate = $1,
        DeinterlaceTech_BOBVerticalStretch = $2,
        DeinterlaceTech_MedianFiltering = $4,
        DeinterlaceTech_EdgeFiltering = $10,
        DeinterlaceTech_FieldAdaptive = $20,
        DeinterlaceTech_PixelAdaptive = $40,
        DeinterlaceTech_MotionVectorSteered = $80
        );

    TVMRFrequency = record
        dwNumerator: DWORD;
        dwDenominator: DWORD;
    end;

    TVMRVideoDesc = record
        dwSize: DWORD;
        dwSampleWidth: DWORD;
        dwSampleHeight: DWORD;
        SingleFieldPerSample: longbool;
        dwFourCC: DWORD;
        InputSampleFreq: TVMRFrequency;
        OutputFrameFreq: TVMRFrequency;
    end;

    PVMRVideoDesc = ^TVMRVideoDesc;

    TVMRDeinterlaceCaps = record
        dwSize: DWORD;
        dwNumPreviousOutputFrames: DWORD;
        dwNumForwardRefSamples: DWORD;
        dwNumBackwardRefSamples: DWORD;
        DeinterlaceTechnology: TVMRDeinterlaceTech;
    end;

    PVMRDeinterlaceCaps = ^TVMRDeinterlaceCaps;

    IVMRDeinterlaceControl = interface(IUnknown)
        ['{bb057577-0db8-4e6a-87a7-1a8c9a505a0f}']
        function GetNumberOfDeinterlaceModes(lpVideoDescription: PVMRVideoDesc;
            var lpdwNumDeinterlaceModes: DWORD; out lpDeinterlaceModes: PGUID): HResult; stdcall;
        function GetDeinterlaceModeCaps(lpDeinterlaceMode: PGUID; lpVideoDescription: PVMRVideoDesc;
            var lpDeinterlaceCaps: TVMRDeinterlaceCaps): HResult; stdcall;
        function GetDeinterlaceMode(dwStreamID: DWORD; out lpDeinterlaceMode: TGUID): HResult; stdcall;
        function SetDeinterlaceMode(dwStreamID: DWORD; lpDeinterlaceMode: TGUID): HResult; stdcall;
        function GetDeinterlacePrefs(out lpdwDeinterlacePrefs: DWORD): HResult; stdcall;
        function SetDeinterlacePrefs(dwDeinterlacePrefs: DWORD): HResult; stdcall;
        function GetActualDeinterlaceMode(dwStreamID: DWORD; out lpDeinterlaceMode: TGUID): HResult;
            stdcall;
    end;


    TVMRALPHABITMAP = record
        dwFlags: DWORD;
        hdc: HDC;
        pDDS: PDIRECTDRAWSURFACE7;
        rSrc: TRECT;
        rDest: TNORMALIZEDRECT;
        fAlpha: single;
        clrSrcKey: TCOLORREF;
    end;

    PVMRALPHABITMAP = ^TVMRALPHABITMAP;

    IVMRMixerBitmap = interface(IUnknown)
        ['{1E673275-0257-40aa-AF20-7C608D4A0428}']
        function SetAlphaBitmap(const pBmpParms: PVMRALPHABITMAP): HResult; stdcall;
        function UpdateAlphaBitmapParameters(pBmpParms: PVMRALPHABITMAP): HResult; stdcall;
        function GetAlphaBitmapParameters(out pBmpParms: TVMRALPHABITMAP): HResult; stdcall;
    end;


    TVMRVIDEOSTREAMINFO = record
        pddsVideoSurface: PDIRECTDRAWSURFACE7;
        dwWidth: DWORD;
        dwHeight: DWORD;
        dwStrmID: DWORD;
        fAlpha: single;
        ddClrKey: TDDCOLORKEY;
        rNormal: TNORMALIZEDRECT;
    end;

    PVMRVIDEOSTREAMINFO = ^TVMRVIDEOSTREAMINFO;

    IVMRImageCompositor = interface(IUnknown)
        ['{7a4fb5af-479f-4074-bb40-ce6722e43c82}']
        function InitCompositionTarget(pD3DDevice: IUnknown;
            pddsRenderTarget: PDIRECTDRAWSURFACE7): HResult; stdcall;
        function TermCompositionTarget(pD3DDevice: IUnknown;
            pddsRenderTarget: PDIRECTDRAWSURFACE7): HResult; stdcall;
        function SetStreamMediaType(dwStrmID: DWORD; pmt: PAM_MEDIA_TYPE; fTexture: longbool): HResult;
            stdcall;
        function CompositeImage(pD3DDevice: IUnknown; pddsRenderTarget: PDIRECTDRAWSURFACE7;
            pmtRenderTarget: PAM_MEDIA_TYPE; rtStart: TREFERENCE_TIME; rtEnd: TREFERENCE_TIME;
            dwClrBkGnd: DWORD; pVideoStreamInfo: PVMRVIDEOSTREAMINFO; cStreams: UINT): HResult; stdcall;
    end;


    IVMRVideoStreamControl = interface(IUnknown)
        ['{058d1f11-2a54-4bef-bd54-df706626b727}']
        function SetColorKey(lpClrKey: PDDCOLORKEY): HResult;
            stdcall;
        function GetColorKey(out lpClrKey: TDDCOLORKEY): HResult;
            stdcall;
        function SetStreamActiveState(fActive: longbool): HResult;
            stdcall;
        function GetStreamActiveState(out lpfActive: longbool): HResult; stdcall;
    end;


    IVMRSurface = interface(IUnknown)
        ['{a9849bbe-9ec8-4263-b764-62730f0d15d0}']
        function IsSurfaceLocked(): HResult; stdcall;
        function LockSurface(out lpSurface: PBYTE): HResult;
            stdcall;
        function UnlockSurface(): HResult; stdcall;
        function GetSurface(out lplpSurface: PDIRECTDRAWSURFACE7): HResult; stdcall;
    end;


    IVMRImagePresenterConfig = interface(IUnknown)
        ['{9f3a1c85-8555-49ba-935f-be5b5b29d178}']
        function SetRenderingPrefs(dwRenderFlags: DWORD): HResult;
            stdcall;
        function GetRenderingPrefs(out dwRenderFlags: DWORD): HResult; stdcall;
    end;

    IVMRImagePresenterExclModeConfig = interface(IVMRImagePresenterConfig)
        ['{e6f7ce40-4673-44f1-8f77-5499d68cb4ea}']
        function SetXlcModeDDObjAndPrimarySurface(lpDDObj: PDIRECTDRAW7;
            lpPrimarySurf: PDIRECTDRAWSURFACE7): HResult; stdcall;
        function GetXlcModeDDObjAndPrimarySurface(out lpDDObj: PDIRECTDRAW7;
            out lpPrimarySurf: PDIRECTDRAWSURFACE7): HResult; stdcall;
    end;

    IVPManager = interface(IUnknown)
        ['{aac18c18-e186-46d2-825d-a1f8dc8e395a}']
        function SetVideoPortIndex(dwVideoPortIndex: DWORD): HResult;
            stdcall;
        function GetVideoPortIndex(out pdwVideoPortIndex: DWORD): HResult; stdcall;
    end;

    TDVD_DOMAIN = (
        DVD_DOMAIN_FirstPlay = 1,
        DVD_DOMAIN_VideoManagerMenu = (DVD_DOMAIN_FirstPlay + 1),
        DVD_DOMAIN_VideoTitleSetMenu = (DVD_DOMAIN_VideoManagerMenu + 1),
        DVD_DOMAIN_Title = (DVD_DOMAIN_VideoTitleSetMenu + 1),
        DVD_DOMAIN_Stop = (DVD_DOMAIN_Title + 1)
        );

    TDVD_MENU_ID = (
        DVD_MENU_Title = 2,
        DVD_MENU_Root = 3,
        DVD_MENU_Subpicture = 4,
        DVD_MENU_Audio = 5,
        DVD_MENU_Angle = 6,
        DVD_MENU_Chapter = 7
        );

    TDVD_DISC_SIDE = (
        DVD_SIDE_A = 1,
        DVD_SIDE_B = 2
        );

    TDVD_PREFERRED_DISPLAY_MODE = (
        DISPLAY_CONTENT_DEFAULT = 0,
        DISPLAY_16x9 = 1,
        DISPLAY_4x3_PANSCAN_PREFERRED = 2,
        DISPLAY_4x3_LETTERBOX_PREFERRED = 3
        );

    TDVD_REGISTER = word;

    TGPRMARRAY = array [0.. 15] of TDVD_REGISTER;

    TSPRMARRAY = array [0.. 23] of TDVD_REGISTER;

    TDVD_ATR = record
        ulCAT: ULONG;
        pbATRI: array[0.. 767] of byte;
    end;

    TDVD_VideoATR = array [0..1] of byte;

    TDVD_AudioATR = array[0..7] of byte;

    TDVD_SubpictureATR = array [0..5] of byte;

    TDVD_FRAMERATE = (
        DVD_FPS_25 = 1,
        DVD_FPS_30NonDrop = 3
        );

    TDVD_TIMECODE = record
        Hours1: 0..15; // Hours
        Hours10: 0..15; // Tens of Hours

        Minutes1: 0..15; // Minutes
        Minutes10: 0..15; // Tens of Minutes

        Seconds1: 0..15; // Seconds
        Seconds10: 0..15; // Tens of Seconds

        Frames1: 0..15; // Frames
        Frames10: 0..3; // Tens of Frames

        FrameRateCode: 0..3;
        // use DVD_FRAMERATE to indicate frames/sec and drop/non-drop
    end;

    TDVD_NavCmdType = (
        DVD_NavCmdType_Pre = 1,
        DVD_NavCmdType_Post = 2,
        DVD_NavCmdType_Cell = 3,
        DVD_NavCmdType_Button = 4
        );

    TDVD_TIMECODE_FLAGS = (
        DVD_TC_FLAG_25fps = $1,
        DVD_TC_FLAG_30fps = $2,
        DVD_TC_FLAG_DropFrame = $4,
        DVD_TC_FLAG_Interpolated = $8
        );

    TDVD_HMSF_TIMECODE = record
        bHours: byte;
        bMinutes: byte;
        bSeconds: byte;
        bFrames: byte;
    end;

    PDVD_HMSF_TIMECODE = ^TDVD_HMSF_TIMECODE;

    TDVD_PLAYBACK_LOCATION2 = record
        TitleNum: ULONG;
        ChapterNum: ULONG;
        TimeCode: TDVD_HMSF_TIMECODE;
        TimeCodeFlags: ULONG;
    end;

    PDVD_PLAYBACK_LOCATION2 = ^TDVD_PLAYBACK_LOCATION2;

    TDVD_PLAYBACK_LOCATION = record
        TitleNum: ULONG;
        ChapterNum: ULONG;
        TimeCode: ULONG;
    end;

    PDVD_PLAYBACK_LOCATION = ^TDVD_PLAYBACK_LOCATION;

    TVALID_UOP_SOMTHING_OR_OTHER = DWORD;

    TVALID_UOP_FLAG = (
        UOP_FLAG_Play_Title_Or_AtTime = $1,
        UOP_FLAG_Play_Chapter = $2,
        UOP_FLAG_Play_Title = $4,
        UOP_FLAG_Stop = $8,
        UOP_FLAG_ReturnFromSubMenu = $10,
        UOP_FLAG_Play_Chapter_Or_AtTime = $20,
        UOP_FLAG_PlayPrev_Or_Replay_Chapter = $40,
        UOP_FLAG_PlayNext_Chapter = $80,
        UOP_FLAG_Play_Forwards = $100,
        UOP_FLAG_Play_Backwards = $200,
        UOP_FLAG_ShowMenu_Title = $400,
        UOP_FLAG_ShowMenu_Root = $800,
        UOP_FLAG_ShowMenu_SubPic = $1000,
        UOP_FLAG_ShowMenu_Audio = $2000,
        UOP_FLAG_ShowMenu_Angle = $4000,
        UOP_FLAG_ShowMenu_Chapter = $8000,
        UOP_FLAG_Resume = $10000,
        UOP_FLAG_Select_Or_Activate_Button = $20000,
        UOP_FLAG_Still_Off = $40000,
        UOP_FLAG_Pause_On = $80000,
        UOP_FLAG_Select_Audio_Stream = $100000,
        UOP_FLAG_Select_SubPic_Stream = $200000,
        UOP_FLAG_Select_Angle = $400000,
        UOP_FLAG_Select_Karaoke_Audio_Presentation_Mode = $800000,
        UOP_FLAG_Select_Video_Mode_Preference = $1000000
        );

    TDVD_CMD_FLAGS = (
        DVD_CMD_FLAG_None = 0,
        DVD_CMD_FLAG_Flush = $1,
        DVD_CMD_FLAG_SendEvents = $2,
        DVD_CMD_FLAG_Block = $4,
        DVD_CMD_FLAG_StartWhenRendered = $8,
        DVD_CMD_FLAG_EndAfterRendered = $10
        );

    TDVD_OPTION_FLAG = (
        DVD_ResetOnStop = 1,
        DVD_NotifyParentalLevelChange = 2,
        DVD_HMSF_TimeCodeEvents = 3,
        DVD_AudioDuringFFwdRew = 4,
        DVD_EnableNonblockingAPIs = 5,
        DVD_CacheSizeInMB = 6,
        DVD_EnablePortableBookmarks = 7,
        DVD_EnableExtendedCopyProtectErrors = 8,
        DVD_NotifyPositionChange = 9,
        DVD_IncreaseOutputControl = 10,
        DVD_EnableStreaming = 11,
        DVD_EnableESOutput = 12,
        DVD_EnableTitleLength = 13,
        DVD_DisableStillThrottle = 14,
        DVD_EnableLoggingEvents = 15,
        DVD_MaxReadBurstInKB = 16,
        DVD_ReadBurstPeriodInMS = 17,
        DVD_RestartDisc = 18,
        DVD_EnableCC = 19
        );

    TDVD_RELATIVE_BUTTON = (
        DVD_Relative_Upper = 1,
        DVD_Relative_Lower = 2,
        DVD_Relative_Left = 3,
        DVD_Relative_Right = 4
        );

    TDVD_PARENTAL_LEVEL = (
        DVD_PARENTAL_LEVEL_8 = $8000,
        DVD_PARENTAL_LEVEL_7 = $4000,
        DVD_PARENTAL_LEVEL_6 = $2000,
        DVD_PARENTAL_LEVEL_5 = $1000,
        DVD_PARENTAL_LEVEL_4 = $800,
        DVD_PARENTAL_LEVEL_3 = $400,
        DVD_PARENTAL_LEVEL_2 = $200,
        DVD_PARENTAL_LEVEL_1 = $100
        );

    TDVD_AUDIO_LANG_EXT = (
        DVD_AUD_EXT_NotSpecified = 0,
        DVD_AUD_EXT_Captions = 1,
        DVD_AUD_EXT_VisuallyImpaired = 2,
        DVD_AUD_EXT_DirectorComments1 = 3,
        DVD_AUD_EXT_DirectorComments2 = 4
        );

    TDVD_SUBPICTURE_LANG_EXT = (
        DVD_SP_EXT_NotSpecified = 0,
        DVD_SP_EXT_Caption_Normal = 1,
        DVD_SP_EXT_Caption_Big = 2,
        DVD_SP_EXT_Caption_Children = 3,
        DVD_SP_EXT_CC_Normal = 5,
        DVD_SP_EXT_CC_Big = 6,
        DVD_SP_EXT_CC_Children = 7,
        DVD_SP_EXT_Forced = 9,
        DVD_SP_EXT_DirectorComments_Normal = 13,
        DVD_SP_EXT_DirectorComments_Big = 14,
        DVD_SP_EXT_DirectorComments_Children = 15
        );

    TDVD_AUDIO_APPMODE = (
        DVD_AudioMode_None = 0,
        DVD_AudioMode_Karaoke = 1,
        DVD_AudioMode_Surround = 2,
        DVD_AudioMode_Other = 3
        );

    TDVD_AUDIO_FORMAT = (
        DVD_AudioFormat_AC3 = 0,
        DVD_AudioFormat_MPEG1 = 1,
        DVD_AudioFormat_MPEG1_DRC = 2,
        DVD_AudioFormat_MPEG2 = 3,
        DVD_AudioFormat_MPEG2_DRC = 4,
        DVD_AudioFormat_LPCM = 5,
        DVD_AudioFormat_DTS = 6,
        DVD_AudioFormat_SDDS = 7,
        DVD_AudioFormat_Other = 8
        );

    TDVD_KARAOKE_DOWNMIX = (
        DVD_Mix_0to0 = $1,
        DVD_Mix_1to0 = $2,
        DVD_Mix_2to0 = $4,
        DVD_Mix_3to0 = $8,
        DVD_Mix_4to0 = $10,
        DVD_Mix_Lto0 = $20,
        DVD_Mix_Rto0 = $40,
        DVD_Mix_0to1 = $100,
        DVD_Mix_1to1 = $200,
        DVD_Mix_2to1 = $400,
        DVD_Mix_3to1 = $800,
        DVD_Mix_4to1 = $1000,
        DVD_Mix_Lto1 = $2000,
        DVD_Mix_Rto1 = $4000
        );


    TDVD_AudioAttributes = record
        AppMode: TDVD_AUDIO_APPMODE;
        AppModeData: byte;
        AudioFormat: TDVD_AUDIO_FORMAT;
        Language: LCID;
        LanguageExtension: TDVD_AUDIO_LANG_EXT;
        fHasMultichannelInfo: longbool;
        dwFrequency: DWORD;
        bQuantization: byte;
        bNumberOfChannels: byte;
        dwReserved: array[0..1] of DWORD;
    end;


    TDVD_MUA_MixingInfo = record
        fMixTo0: longbool;
        fMixTo1: longbool;
        fMix0InPhase: longbool;
        fMix1InPhase: longbool;
        dwSpeakerPosition: DWORD;
    end;

    TDVD_MUA_Coeff = record
        log2_alpha: double;
        log2_beta: double;
    end;

    TDVD_MultichannelAudioAttributes = record
        Info: array [0..7] of TDVD_MUA_MixingInfo;
        Coeff: array[0..7] of TDVD_MUA_Coeff;
    end;

    TDVD_KARAOKE_CONTENTS = (
        DVD_Karaoke_GuideVocal1 = $1,
        DVD_Karaoke_GuideVocal2 = $2,
        DVD_Karaoke_GuideMelody1 = $4,
        DVD_Karaoke_GuideMelody2 = $8,
        DVD_Karaoke_GuideMelodyA = $10,
        DVD_Karaoke_GuideMelodyB = $20,
        DVD_Karaoke_SoundEffectA = $40,
        DVD_Karaoke_SoundEffectB = $80
        );

    TDVD_KARAOKE_ASSIGNMENT = (
        DVD_Assignment_reserved0 = 0,
        DVD_Assignment_reserved1 = 1,
        DVD_Assignment_LR = 2,
        DVD_Assignment_LRM = 3,
        DVD_Assignment_LR1 = 4,
        DVD_Assignment_LRM1 = 5,
        DVD_Assignment_LR12 = 6,
        DVD_Assignment_LRM12 = 7
        );


    TDVD_KaraokeAttributes = record
        bVersion: byte;
        fMasterOfCeremoniesInGuideVocal1: longbool;
        fDuet: longbool;
        ChannelAssignment: TDVD_KARAOKE_ASSIGNMENT;
        wChannelContents: array [0..7] of word;
    end;


    TDVD_VIDEO_COMPRESSION = (
        DVD_VideoCompression_Other = 0,
        DVD_VideoCompression_MPEG1 = 1,
        DVD_VideoCompression_MPEG2 = 2
        );

    TDVD_VideoAttributes = record
        fPanscanPermitted: longbool;
        fLetterboxPermitted: longbool;
        ulAspectX: ULONG;
        ulAspectY: ULONG;
        ulFrameRate: ULONG;
        ulFrameHeight: ULONG;
        Compression: TDVD_VIDEO_COMPRESSION;
        fLine21Field1InGOP: longbool;
        fLine21Field2InGOP: longbool;
        ulSourceResolutionX: ULONG;
        ulSourceResolutionY: ULONG;
        fIsSourceLetterboxed: longbool;
        fIsFilmMode: longbool;
    end;

    TDVD_SUBPICTURE_TYPE = (
        DVD_SPType_NotSpecified = 0,
        DVD_SPType_Language = 1,
        DVD_SPType_Other = 2
        );

    TDVD_SUBPICTURE_CODING = (
        DVD_SPCoding_RunLength = 0,
        DVD_SPCoding_Extended = 1,
        DVD_SPCoding_Other = 2
        );

    TDVD_SubpictureAttributes = record
        _Type: TDVD_SUBPICTURE_TYPE;
        CodingMode: TDVD_SUBPICTURE_CODING;
        Language: LCID;
        LanguageExtension: TDVD_SUBPICTURE_LANG_EXT;
    end;

    TDVD_TITLE_APPMODE = (
        DVD_AppMode_Not_Specified = 0,
        DVD_AppMode_Karaoke = 1,
        DVD_AppMode_Other = 3
        );


    TDVD_TitleAttributes = record
        case integer of
            0: (AppMode: TDVD_TITLE_APPMODE;
                VideoAttributes: TDVD_VideoAttributes;
                ulNumberOfAudioStreams: ULONG;
                AudioAttributes: array[0.. 7] of TDVD_AudioAttributes;
                MultichannelAudioAttributes: array [0..7] of
                TDVD_MultichannelAudioAttributes;
                ulNumberOfSubpictureStreams: ULONG;
                SubpictureAttributes: array[0.. 31] of
                TDVD_SubpictureAttributes;
            );
            1: (TitleLength: TDVD_HMSF_TIMECODE);
    end;


    TDVD_MenuAttributes = record
        fCompatibleRegion: array [0..7] of longbool;
        VideoAttributes: TDVD_VideoAttributes;
        fAudioPresent: longbool;
        AudioAttributes: TDVD_AudioAttributes;
        fSubpicturePresent: longbool;
        SubpictureAttributes: TDVD_SubpictureAttributes;
    end;

    IDvdControl = interface(IUnknown)
        ['{A70EFE61-E2A3-11d0-A9BE-00AA0061BE93}']
        function TitlePlay(ulTitle: ULONG): HResult; stdcall;
        function ChapterPlay(ulTitle: ULONG; ulChapter: ULONG): HResult; stdcall;
        function TimePlay(ulTitle: ULONG; bcdTime: ULONG): HResult; stdcall;
        function StopForResume(): HResult; stdcall;
        function GoUp(): HResult; stdcall;
        function TimeSearch(bcdTime: ULONG): HResult; stdcall;
        function ChapterSearch(ulChapter: ULONG): HResult; stdcall;
        function PrevPGSearch(): HResult; stdcall;
        function TopPGSearch(): HResult; stdcall;
        function NextPGSearch(): HResult; stdcall;
        function ForwardScan(dwSpeed: double): HResult; stdcall;
        function BackwardScan(dwSpeed: double): HResult; stdcall;
        function MenuCall(MenuID: TDVD_MENU_ID): HResult; stdcall;
        function Resume(): HResult; stdcall;
        function UpperButtonSelect(): HResult; stdcall;
        function LowerButtonSelect(): HResult; stdcall;
        function LeftButtonSelect(): HResult; stdcall;
        function RightButtonSelect(): HResult; stdcall;
        function ButtonActivate(): HResult; stdcall;
        function ButtonSelectAndActivate(ulButton: ULONG): HResult; stdcall;
        function StillOff(): HResult; stdcall;
        function PauseOn(): HResult; stdcall;
        function PauseOff(): HResult; stdcall;
        function MenuLanguageSelect(Language: LCID): HResult;
            stdcall;
        function AudioStreamChange(ulAudio: ULONG): HResult;
            stdcall;
        function SubpictureStreamChange(ulSubPicture: ULONG; bDisplay: longbool): HResult; stdcall;
        function AngleChange(ulAngle: ULONG): HResult; stdcall;
        function ParentalLevelSelect(ulParentalLevel: ULONG): HResult; stdcall;
        function ParentalCountrySelect(wCountry: word): HResult;
            stdcall;
        function KaraokeAudioPresentationModeChange(ulMode: ULONG): HResult; stdcall;
        function VideoModePreferrence(ulPreferredDisplayMode: ULONG): HResult; stdcall;
        function SetRoot(pszPath: LPCWSTR): HResult; stdcall;
        function MouseActivate(point: TPOINT): HResult; stdcall;
        function MouseSelect(point: TPOINT): HResult; stdcall;
        function ChapterPlayAutoStop(ulTitle: ULONG; ulChapter: ULONG; ulChaptersToPlay: ULONG): HResult;
            stdcall;
    end;


    IDvdInfo = interface(IUnknown)
        ['{A70EFE60-E2A3-11d0-A9BE-00AA0061BE93}']
        function GetCurrentDomain(out pDomain: TDVD_DOMAIN): HResult;
            stdcall;
        function GetCurrentLocation(out pLocation: TDVD_PLAYBACK_LOCATION): HResult; stdcall;
        function GetTotalTitleTime(out pulTotalTime: ULONG): HResult;
            stdcall;
        function GetCurrentButton(out pulButtonsAvailable: ULONG;
            out pulCurrentButton: ULONG): HResult; stdcall;
        function GetCurrentAngle(out pulAnglesAvailable: ULONG; out pulCurrentAngle: ULONG): HResult;
            stdcall;
        function GetCurrentAudio(out pulStreamsAvailable: ULONG;
            out pulCurrentStream: ULONG): HResult; stdcall;
        function GetCurrentSubpicture(out pulStreamsAvailable: ULONG; out pulCurrentStream: ULONG;
            out pIsDisabled: longbool): HResult; stdcall;
        function GetCurrentUOPS(out pUOP: TVALID_UOP_SOMTHING_OR_OTHER): HResult; stdcall;
        function GetAllSPRMs(out pRegisterArray: TSPRMARRAY): HResult; stdcall;
        function GetAllGPRMs(out pRegisterArray: TGPRMARRAY): HResult; stdcall;
        function GetAudioLanguage(ulStream: ULONG; out pLanguage: LCID): HResult; stdcall;
        function GetSubpictureLanguage(ulStream: ULONG; out pLanguage: LCID): HResult; stdcall;
        function GetTitleAttributes(ulTitle: ULONG; out pATR: TDVD_ATR): HResult; stdcall;
        function GetVMGAttributes(out pATR: TDVD_ATR): HResult;
            stdcall;
        function GetCurrentVideoAttributes(out pATR: TDVD_VideoATR): HResult; stdcall;
        function GetCurrentAudioAttributes(out pATR: TDVD_AudioATR): HResult; stdcall;
        function GetCurrentSubpictureAttributes(out pATR: TDVD_SubpictureATR): HResult; stdcall;
        function GetCurrentVolumeInfo(out pulNumOfVol: ULONG; out pulThisVolNum: ULONG;
            out pSide: TDVD_DISC_SIDE; out pulNumOfTitles: ULONG): HResult; stdcall;
        function GetDVDTextInfo(out pTextManager{ulBufSize, pulActualSize}: PBYTE;
            ulBufSize: ULONG; out pulActualSize: ULONG): HResult; stdcall;
        function GetPlayerParentalLevel(out pulParentalLevel: ULONG;
            out pulCountryCode: ULONG): HResult; stdcall;
        function GetNumberOfChapters(ulTitle: ULONG; out pulNumberOfChapters: ULONG): HResult; stdcall;
        function GetTitleParentalLevels(ulTitle: ULONG; out pulParentalLevels: ULONG): HResult; stdcall;
        function GetRoot(out pRoot{ulBufSize, pulActualSize}: LPSTR; ulBufSize: ULONG;
            out pulActualSize: ULONG): HResult; stdcall;
    end;

    IDvdCmd = interface(IUnknown)
        ['{5a4a97e4-94ee-4a55-9751-74b5643aa27d}']
        function WaitForStart(): HResult; stdcall;
        function WaitForEnd(): HResult; stdcall;
    end;


    IDvdState = interface(IUnknown)
        ['{86303d6d-1c4a-4087-ab42-f711167048ef}']
        function GetDiscID(out pullUniqueID: ULONGLONG): HResult;
            stdcall;
        function GetParentalLevel(out pulParentalLevel: ULONG): HResult; stdcall;
    end;

    TCountryCode = array [0..1] of byte;
    PCountryCode = ^TCountryCode;

    IDvdControl2 = interface(IUnknown)
        ['{33BC7430-EEC0-11D2-8201-00A0C9D74842}']
        function PlayTitle(ulTitle: ULONG; dwFlags: DWORD; out ppCmd: IDvdCmd): HResult;
            stdcall;
        function PlayChapterInTitle(ulTitle: ULONG; ulChapter: ULONG; dwFlags: DWORD;
            out ppCmd: IDvdCmd): HResult; stdcall;
        function PlayAtTimeInTitle(ulTitle: ULONG; pStartTime: PDVD_HMSF_TIMECODE;
            dwFlags: DWORD; out ppCmd: IDvdCmd): HResult; stdcall;
        function Stop(): HResult; stdcall;
        function ReturnFromSubmenu(dwFlags: DWORD; out ppCmd: IDvdCmd): HResult; stdcall;
        function PlayAtTime(pTime: PDVD_HMSF_TIMECODE; dwFlags: DWORD; out ppCmd: IDvdCmd): HResult;
            stdcall;
        function PlayChapter(ulChapter: ULONG; dwFlags: DWORD; out ppCmd: IDvdCmd): HResult;
            stdcall;
        function PlayPrevChapter(dwFlags: DWORD; out ppCmd: IDvdCmd): HResult; stdcall;
        function ReplayChapter(dwFlags: DWORD; out ppCmd: IDvdCmd): HResult; stdcall;
        function PlayNextChapter(dwFlags: DWORD; out ppCmd: IDvdCmd): HResult; stdcall;
        function PlayForwards(dSpeed: double; dwFlags: DWORD; out ppCmd: IDvdCmd): HResult;
            stdcall;
        function PlayBackwards(dSpeed: double; dwFlags: DWORD; out ppCmd: IDvdCmd): HResult;
            stdcall;
        function ShowMenu(MenuID: TDVD_MENU_ID; dwFlags: DWORD; out ppCmd: IDvdCmd): HResult;
            stdcall;
        function Resume(dwFlags: DWORD; out ppCmd: IDvdCmd): HResult; stdcall;
        function SelectRelativeButton(buttonDir: TDVD_RELATIVE_BUTTON): HResult; stdcall;
        function ActivateButton(): HResult; stdcall;
        function SelectButton(ulButton: ULONG): HResult; stdcall;
        function SelectAndActivateButton(ulButton: ULONG): HResult;
            stdcall;
        function StillOff(): HResult; stdcall;
        function Pause(bState: longbool): HResult; stdcall;
        function SelectAudioStream(ulAudio: ULONG; dwFlags: DWORD; out ppCmd: IDvdCmd): HResult;
            stdcall;
        function SelectSubpictureStream(ulSubPicture: ULONG; dwFlags: DWORD; out ppCmd: IDvdCmd): HResult;
            stdcall;
        function SetSubpictureState(bState: longbool; dwFlags: DWORD; out ppCmd: IDvdCmd): HResult;
            stdcall;
        function SelectAngle(ulAngle: ULONG; dwFlags: DWORD; out ppCmd: IDvdCmd): HResult;
            stdcall;
        function SelectParentalLevel(ulParentalLevel: ULONG): HResult; stdcall;
        function SelectParentalCountry(bCountry: TCountryCode): HResult; stdcall;
        function SelectKaraokeAudioPresentationMode(ulMode: ULONG): HResult; stdcall;
        function SelectVideoModePreference(ulPreferredDisplayMode: ULONG): HResult; stdcall;
        function SetDVDDirectory(pszwPath: LPCWSTR): HResult;
            stdcall;
        function ActivateAtPosition(point: TPOINT): HResult;
            stdcall;
        function SelectAtPosition(point: TPOINT): HResult;
            stdcall;
        function PlayChaptersAutoStop(ulTitle: ULONG; ulChapter: ULONG; ulChaptersToPlay: ULONG;
            dwFlags: DWORD; out ppCmd: IDvdCmd): HResult;
            stdcall;
        function AcceptParentalLevelChange(bAccept: longbool): HResult; stdcall;
        function SetOption(flag: TDVD_OPTION_FLAG; fState: longbool): HResult; stdcall;
        function SetState(pState: IDvdState; dwFlags: DWORD; out ppCmd: IDvdCmd): HResult;
            stdcall;
        function PlayPeriodInTitleAutoStop(ulTitle: ULONG; pStartTime: PDVD_HMSF_TIMECODE;
            pEndTime: PDVD_HMSF_TIMECODE; dwFlags: DWORD; out ppCmd: IDvdCmd): HResult; stdcall;
        function SetGPRM(ulIndex: ULONG; wValue: word; dwFlags: DWORD;
            out ppCmd: IDvdCmd): HResult; stdcall;
        function SelectDefaultMenuLanguage(Language: LCID): HResult;
            stdcall;
        function SelectDefaultAudioLanguage(Language: LCID; audioExtension: TDVD_AUDIO_LANG_EXT): HResult;
            stdcall;
        function SelectDefaultSubpictureLanguage(Language: LCID;
            subpictureExtension: TDVD_SUBPICTURE_LANG_EXT): HResult; stdcall;
    end;

    TDVD_TextStringType = (
        DVD_Struct_Volume = $1,
        DVD_Struct_Title = $2,
        DVD_Struct_ParentalID = $3,
        DVD_Struct_PartOfTitle = $4,
        DVD_Struct_Cell = $5,
        DVD_Stream_Audio = $10,
        DVD_Stream_Subpicture = $11,
        DVD_Stream_Angle = $12,
        DVD_Channel_Audio = $20,
        DVD_General_Name = $30,
        DVD_General_Comments = $31,
        DVD_Title_Series = $38,
        DVD_Title_Movie = $39,
        DVD_Title_Video = $3a,
        DVD_Title_Album = $3b,
        DVD_Title_Song = $3c,
        DVD_Title_Other = $3f,
        DVD_Title_Sub_Series = $40,
        DVD_Title_Sub_Movie = $41,
        DVD_Title_Sub_Video = $42,
        DVD_Title_Sub_Album = $43,
        DVD_Title_Sub_Song = $44,
        DVD_Title_Sub_Other = $47,
        DVD_Title_Orig_Series = $48,
        DVD_Title_Orig_Movie = $49,
        DVD_Title_Orig_Video = $4a,
        DVD_Title_Orig_Album = $4b,
        DVD_Title_Orig_Song = $4c,
        DVD_Title_Orig_Other = $4f,
        DVD_Other_Scene = $50,
        DVD_Other_Cut = $51,
        DVD_Other_Take = $52
        );

    TDVD_TextCharSet = (
        DVD_CharSet_Unicode = 0,
        DVD_CharSet_ISO646 = 1,
        DVD_CharSet_JIS_Roman_Kanji = 2,
        DVD_CharSet_ISO8859_1 = 3,
        DVD_CharSet_ShiftJIS_Kanji_Roman_Katakana = 4
        );

    TDVD_DECODER_CAPS = record
        dwSize: DWORD;
        dwAudioCaps: DWORD;
        dFwdMaxRateVideo: double;
        dFwdMaxRateAudio: double;
        dFwdMaxRateSP: double;
        dBwdMaxRateVideo: double;
        dBwdMaxRateAudio: double;
        dBwdMaxRateSP: double;
        dwRes1: DWORD;
        dwRes2: DWORD;
        dwRes3: DWORD;
        dwRes4: DWORD;
    end;


    IDvdInfo2 = interface(IUnknown)
        ['{34151510-EEC0-11D2-8201-00A0C9D74842}']
        function GetCurrentDomain(out pDomain: TDVD_DOMAIN): HResult;
            stdcall;
        function GetCurrentLocation(out pLocation: TDVD_PLAYBACK_LOCATION2): HResult; stdcall;
        function GetTotalTitleTime(out pTotalTime: TDVD_HMSF_TIMECODE;
            out ulTimeCodeFlags: ULONG): HResult; stdcall;
        function GetCurrentButton(out pulButtonsAvailable: ULONG;
            out pulCurrentButton: ULONG): HResult; stdcall;
        function GetCurrentAngle(out pulAnglesAvailable: ULONG; out pulCurrentAngle: ULONG): HResult;
            stdcall;
        function GetCurrentAudio(out pulStreamsAvailable: ULONG;
            out pulCurrentStream: ULONG): HResult; stdcall;
        function GetCurrentSubpicture(out pulStreamsAvailable: ULONG; out pulCurrentStream: ULONG;
            out pbIsDisabled: longbool): HResult; stdcall;
        function GetCurrentUOPS(out pulUOPs: ULONG): HResult;
            stdcall;
        function GetAllSPRMs(out pRegisterArray: TSPRMARRAY): HResult; stdcall;
        function GetAllGPRMs(out pRegisterArray: TGPRMARRAY): HResult; stdcall;
        function GetAudioLanguage(ulStream: ULONG; out pLanguage: LCID): HResult; stdcall;
        function GetSubpictureLanguage(ulStream: ULONG; out pLanguage: LCID): HResult; stdcall;
        function GetTitleAttributes(ulTitle: ULONG; out pMenu: TDVD_MenuAttributes;
            out pTitle: TDVD_TitleAttributes): HResult; stdcall;
        function GetVMGAttributes(out pATR: TDVD_MenuAttributes): HResult; stdcall;
        function GetCurrentVideoAttributes(out pATR: TDVD_VideoAttributes): HResult; stdcall;
        function GetAudioAttributes(ulStream: ULONG; out pATR: TDVD_AudioAttributes): HResult; stdcall;
        function GetKaraokeAttributes(ulStream: ULONG; out pAttributes: TDVD_KaraokeAttributes): HResult;
            stdcall;
        function GetSubpictureAttributes(ulStream: ULONG; out pATR: TDVD_SubpictureAttributes): HResult;
            stdcall;
        function GetDVDVolumeInfo(out pulNumOfVolumes: ULONG; out pulVolume: ULONG;
            out pSide: TDVD_DISC_SIDE; out pulNumOfTitles: ULONG): HResult; stdcall;
        function GetDVDTextNumberOfLanguages(out pulNumOfLangs: ULONG): HResult; stdcall;
        function GetDVDTextLanguageInfo(ulLangIndex: ULONG; out pulNumOfStrings: ULONG;
            out pLangCode: LCID; out pbCharacterSet: TDVD_TextCharSet): HResult; stdcall;
        function GetDVDTextStringAsNative(ulLangIndex: ULONG; ulStringIndex: ULONG;
            out pbBuffer: PBYTE; ulMaxBufferSize: ULONG; out pulActualSize: ULONG;
            out pType: TDVD_TextStringType): HResult; stdcall;
        function GetDVDTextStringAsUnicode(ulLangIndex: ULONG; ulStringIndex: ULONG;
            out pchwBuffer: PWideCHAR; ulMaxBufferSize: ULONG; out pulActualSize: ULONG;
            out pType: TDVD_TextStringType): HResult; stdcall;
        function GetPlayerParentalLevel(out pulParentalLevel: ULONG;
            out pbCountryCode: TCountryCode): HResult; stdcall;
        function GetNumberOfChapters(ulTitle: ULONG; out pulNumOfChapters: ULONG): HResult; stdcall;
        function GetTitleParentalLevels(ulTitle: ULONG; out pulParentalLevels: ULONG): HResult; stdcall;
        function GetDVDDirectory(out pszwPath{ulMaxSize, pulActualSize}: LPWSTR;
            ulMaxSize: ULONG; out pulActualSize: ULONG): HResult;
            stdcall;
        function IsAudioStreamEnabled(ulStreamNum: ULONG; out pbEnabled: longbool): HResult; stdcall;
        function GetDiscID(pszwPath: LPCWSTR; out pullDiscID: ULONGLONG): HResult; stdcall;
        function GetState(out pStateData: IDvdState): HResult;
            stdcall;
        function GetMenuLanguages(out pLanguages: LCID; ulMaxLanguages: ULONG;
            out pulActualLanguages: ULONG): HResult; stdcall;
        function GetButtonAtPosition(point: TPOINT; out pulButtonIndex: ULONG): HResult; stdcall;
        function GetCmdFromEvent(lParam1: LONG_PTR; out pCmdObj: IDvdCmd): HResult; stdcall;
        function GetDefaultMenuLanguage(out pLanguage: LCID): HResult; stdcall;
        function GetDefaultAudioLanguage(out pLanguage: LCID;
            out pAudioExtension: TDVD_AUDIO_LANG_EXT): HResult; stdcall;
        function GetDefaultSubpictureLanguage(out pLanguage: LCID;
            out pSubpictureExtension: TDVD_SUBPICTURE_LANG_EXT): HResult;
            stdcall;
        function GetDecoderCaps(out pCaps: TDVD_DECODER_CAPS): HResult; stdcall;
        function GetButtonRect(ulButton: ULONG; out pRect: TRECT): HResult; stdcall;
        function IsSubpictureStreamEnabled(ulStreamNum: ULONG; out pbEnabled: longbool): HResult; stdcall;
    end;


    TAM_DVD_GRAPH_FLAGS = (
        AM_DVD_HWDEC_PREFER = $1,
        AM_DVD_HWDEC_ONLY = $2,
        AM_DVD_SWDEC_PREFER = $4,
        AM_DVD_SWDEC_ONLY = $8,
        AM_DVD_NOVPE = $100,
        AM_DVD_DO_NOT_CLEAR = $200,
        AM_DVD_VMR9_ONLY = $800,
        AM_DVD_EVR_ONLY = $1000,
        AM_DVD_EVR_QOS = $2000,
        AM_DVD_ADAPT_GRAPH = $4000,
        AM_DVD_MASK = $ffff
        );

    TAM_DVD_STREAM_FLAGS = (
        AM_DVD_STREAM_VIDEO = $1,
        AM_DVD_STREAM_AUDIO = $2,
        AM_DVD_STREAM_SUBPIC = $4
        );

    TAM_DVD_RENDERSTATUS = record
        hrVPEStatus: HRESULT;
        bDvdVolInvalid: longbool;
        bDvdVolUnknown: longbool;
        bNoLine21In: longbool;
        bNoLine21Out: longbool;
        iNumStreams: integer;
        iNumStreamsFailed: integer;
        dwFailedStreamsFlag: DWORD;
    end;


    IDvdGraphBuilder = interface(IUnknown)
        ['{FCC152B6-F372-11d0-8E00-00C04FD7C08B}']
        function GetFiltergraph(out ppGB: IGraphBuilder): HResult;
            stdcall;
        function GetDvdInterface(riid: REFIID; out ppvIF): HResult; stdcall;
        function RenderDvdVideoVolume(lpcwszPathName: LPCWSTR; dwFlags: DWORD;
            out pStatus: TAM_DVD_RENDERSTATUS): HResult; stdcall;
    end;


    IDDrawExclModeVideo = interface(IUnknown)
        ['{153ACC21-D83B-11d1-82BF-00A0C9696C8F}']
        function SetDDrawObject(pDDrawObject: IDirectDraw): HResult;
            stdcall;
        function GetDDrawObject(out ppDDrawObject: IDirectDraw;
            out pbUsingExternal: longbool): HResult; stdcall;
        function SetDDrawSurface(pDDrawSurface: IDirectDrawSurface): HResult; stdcall;
        function GetDDrawSurface(out ppDDrawSurface: IDirectDrawSurface;
            out pbUsingExternal: longbool): HResult; stdcall;
        function SetDrawParameters(const prcSource: PRECT; const prcTarget: PRECT): HResult; stdcall;
        function GetNativeVideoProps(out pdwVideoWidth: DWORD; out pdwVideoHeight: DWORD;
            out pdwPictAspectRatioX: DWORD; out pdwPictAspectRatioY: DWORD): HResult; stdcall;
        function SetCallbackInterface(pCallback: IDDrawExclModeVideoCallback;
            dwFlags: DWORD): HResult; stdcall;
    end;

    TAM_OVERLAY_NOTIFY_FLAGS = (
        AM_OVERLAY_NOTIFY_VISIBLE_CHANGE = $1,
        AM_OVERLAY_NOTIFY_SOURCE_CHANGE = $2,
        AM_OVERLAY_NOTIFY_DEST_CHANGE = $4
        );


    IDDrawExclModeVideoCallback = interface(IUnknown)
        ['{913c24a0-20ab-11d2-9038-00a0c9697298}']
        function OnUpdateOverlay(bBefore: longbool; dwFlags: DWORD; bOldVisible: longbool;
            const prcOldSrc: PRECT; const prcOldDest: PRECT; bNewVisible: longbool;
            const prcNewSrc: PRECT; const prcNewDest: PRECT): HResult; stdcall;
        function OnUpdateColorKey(const pKey: PCOLORKEY; dwColor: DWORD): HResult; stdcall;
        function OnUpdateSize(dwWidth: DWORD; dwHeight: DWORD; dwARWidth: DWORD;
            dwARHeight: DWORD): HResult; stdcall;
    end;



implementation

end.
