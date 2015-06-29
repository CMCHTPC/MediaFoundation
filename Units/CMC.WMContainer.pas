unit CMC.WMContainer;

{$IFDEF FPC}
{$mode delphi}
{$ENDIF}

interface

uses
    Windows, Classes, SysUtils, shlobj, ActiveX,
    CMC.MFIdl, CMC.WTypes, CMC.MFObjects;

const
    MF_DLL = 'mf.dll';

const

    IID_IMFASFContentInfo: TGUID = '{B1DCA5CD-D5DA-4451-8E9E-DB5C59914EAD}';
    IID_IMFASFProfile: TGUID = '{D267BF6A-028B-4e0d-903D-43F0EF82D0D4}';
    IID_IMFASFStreamConfig: TGUID = '{9E8AE8D2-DBBD-4200-9ACA-06E6DF484913}';
    IID_IMFASFMutualExclusion: TGUID = '{12558291-E399-11D5-BC2A-00B0D0F3F4AB}';
    IID_IMFASFStreamPrioritization: TGUID = '{699bdc27-bbaf-49ff-8e38-9c39c9b5e088}';
    IID_IMFASFSplitter: TGUID = '{12558295-E399-11D5-BC2A-00B0D0F3F4AB}';
    IID_IMFASFMultiplexer: TGUID = '{57BDD80A-9B38-4838-B737-C58F670D7D4F}';
    IID_IMFASFIndexer: TGUID = '{53590F48-DC3B-4297-813F-787761AD7B3E}';
    IID_IMFASFStreamSelector: TGUID = '{d01bad4a-4fa0-4a60-9349-c27e62da9d41}';
    IID_IMFDRMNetHelper: TGUID = '{3D1FF0EA-679A-4190-8D46-7FA69E8C7E15}';


const
    MF_PD_ASF_FILEPROPERTIES_FILE_ID: TGUID = '{3de649b4-d76d-4e66-9ec9-78120fb4c7e3}';
    MF_PD_ASF_FILEPROPERTIES_CREATION_TIME: TGUID = '{3de649b6-d76d-4e66-9ec9-78120fb4c7e3}';
    MF_PD_ASF_FILEPROPERTIES_PACKETS: TGUID = '{3de649b7-d76d-4e66-9ec9-78120fb4c7e3}';
    MF_PD_ASF_FILEPROPERTIES_PLAY_DURATION: TGUID = '{3de649b8-d76d-4e66-9ec9-78120fb4c7e3}';
    MF_PD_ASF_FILEPROPERTIES_SEND_DURATION: TGUID = '{3de649b9-d76d-4e66-9ec9-78120fb4c7e3}';
    MF_PD_ASF_FILEPROPERTIES_PREROLL: TGUID = '{3de649ba-d76d-4e66-9ec9-78120fb4c7e3}';
    MF_PD_ASF_FILEPROPERTIES_FLAGS: TGUID = '{3de649bb-d76d-4e66-9ec9-78120fb4c7e3}';
    MF_PD_ASF_FILEPROPERTIES_MIN_PACKET_SIZE: TGUID = '{3de649bc-d76d-4e66-9ec9-78120fb4c7e3}';
    MF_PD_ASF_FILEPROPERTIES_MAX_PACKET_SIZE: TGUID = '{3de649bd-d76d-4e66-9ec9-78120fb4c7e3}';
    MF_PD_ASF_FILEPROPERTIES_MAX_BITRATE: TGUID = '{3de649be-d76d-4e66-9ec9-78120fb4c7e3}';
    CLSID_WMDRMSystemID: TGUID = '{8948BB22-11BD-4796-93E3-974D1B575678}';
    MF_PD_ASF_CONTENTENCRYPTION_TYPE: TGUID = '{8520fe3d-277e-46ea-99e4-e30a86db12be}';
    MF_PD_ASF_CONTENTENCRYPTION_KEYID: TGUID = '{8520fe3e-277e-46ea-99e4-e30a86db12be}';
    MF_PD_ASF_CONTENTENCRYPTION_SECRET_DATA: TGUID = '{8520fe3f-277e-46ea-99e4-e30a86db12be}';
    MF_PD_ASF_CONTENTENCRYPTION_LICENSE_URL: TGUID = '{8520fe40-277e-46ea-99e4-e30a86db12be}';
    MF_PD_ASF_CONTENTENCRYPTIONEX_ENCRYPTION_DATA: TGUID = '{62508be5-ecdf-4924-a359-72bab3397b9d}';
    MF_PD_ASF_LANGLIST: TGUID = '{f23de43c-9977-460d-a6ec-32937f160f7d}';
    MF_PD_ASF_LANGLIST_LEGACYORDER: TGUID = '{f23de43d-9977-460d-a6ec-32937f160f7d}';
    MF_PD_ASF_MARKER: TGUID = '{5134330e-83a6-475e-a9d5-4fb875fb2e31}';
    MF_PD_ASF_SCRIPT: TGUID = '{e29cd0d7-d602-4923-a7fe-73fd97ecc650}';
    MF_PD_ASF_CODECLIST: TGUID = '{e4bb3509-c18d-4df1-bb99-7a36b3cc4119}';
    MF_PD_ASF_METADATA_IS_VBR: TGUID = '{5fc6947a-ef60-445d-b449-442ecc78b4c1}';
    MF_PD_ASF_METADATA_V8_VBRPEAK: TGUID = '{5fc6947b-ef60-445d-b449-442ecc78b4c1}';
    MF_PD_ASF_METADATA_V8_BUFFERAVERAGE: TGUID = '{5fc6947c-ef60-445d-b449-442ecc78b4c1}';
    MF_PD_ASF_METADATA_LEAKY_BUCKET_PAIRS: TGUID = '{5fc6947d-ef60-445d-b449-442ecc78b4c1}';
    MF_PD_ASF_DATA_START_OFFSET: TGUID = '{e7d5b3e7-1f29-45d3-8822-3e78fae272ed}';
    MF_PD_ASF_DATA_LENGTH: TGUID = '{e7d5b3e8-1f29-45d3-8822-3e78fae272ed}';
    MF_SD_ASF_EXTSTRMPROP_LANGUAGE_ID_INDEX: TGUID = '{48f8a522-305d-422d-8524-2502dda33680}';
    MF_SD_ASF_EXTSTRMPROP_AVG_DATA_BITRATE: TGUID = '{48f8a523-305d-422d-8524-2502dda33680}';
    MF_SD_ASF_EXTSTRMPROP_AVG_BUFFERSIZE: TGUID = '{48f8a524-305d-422d-8524-2502dda33680}';
    MF_SD_ASF_EXTSTRMPROP_MAX_DATA_BITRATE: TGUID = '{48f8a525-305d-422d-8524-2502dda33680}';
    MF_SD_ASF_EXTSTRMPROP_MAX_BUFFERSIZE: TGUID = '{48f8a526-305d-422d-8524-2502dda33680}';
    MF_SD_ASF_STREAMBITRATES_BITRATE: TGUID = '{a8e182ed-afc8-43d0-b0d1-f65bad9da558}';
    MF_SD_ASF_METADATA_DEVICE_CONFORMANCE_TEMPLATE: TGUID = '{245e929d-c44e-4f7e-bb3c-77d4dfd27f8a}';
    MF_PD_ASF_INFO_HAS_AUDIO: TGUID = '{80e62295-2296-4a44-b31c-d103c6fed23c}';
    MF_PD_ASF_INFO_HAS_VIDEO: TGUID = '{80e62296-2296-4a44-b31c-d103c6fed23c}';
    MF_PD_ASF_INFO_HAS_NON_AUDIO_VIDEO: TGUID = '{80e62297-2296-4a44-b31c-d103c6fed23c}';
    MF_ASFPROFILE_MINPACKETSIZE: TGUID = '{22587626-47de-4168-87f5-b5aa9b12a8f0}';
    MF_ASFPROFILE_MAXPACKETSIZE: TGUID = '{22587627-47de-4168-87f5-b5aa9b12a8f0}';
    MF_ASFSTREAMCONFIG_LEAKYBUCKET1: TGUID = '{c69b5901-ea1a-4c9b-b692-e2a0d29a8add}';
    MF_ASFSTREAMCONFIG_LEAKYBUCKET2: TGUID = '{c69b5902-ea1a-4c9b-b692-e2a0d29a8add}';
    MFASFSampleExtension_SampleDuration: TGUID = '{c6bd9450-867f-4907-83a3-c77921b733ad}';
    MFASFSampleExtension_OutputCleanPoint: TGUID = '{f72a3c6f-6eb4-4ebc-b192-09ad9759e828}';
    MFASFSampleExtension_SMPTE: TGUID = '{399595ec-8667-4e2d-8fdb-98814ce76c1e}';
    MFASFSampleExtension_FileName: TGUID = '{e165ec0e-19ed-45d7-b4a7-25cbd1e28e9b}';
    MFASFSampleExtension_ContentType: TGUID = '{d590dc20-07bc-436c-9cf7-f3bbfbf1a4dc}';
    MFASFSampleExtension_PixelAspectRatio: TGUID = '{1b1ee554-f9ea-4bc8-821a-376b74e4c4b8}';
    MFASFSampleExtension_Encryption_SampleID: TGUID = '{6698B84E-0AFA-4330-AEB2-1C0A98D7A44D}';
    MFASFSampleExtension_Encryption_KeyID: TGUID = '{76376591-795f-4da1-86ed-9d46eca109a9}';
    MFASFMutexType_Language: TGUID = '{72178C2B-E45B-11D5-BC2A-00B0D0F3F4AB}';
    MFASFMutexType_Bitrate: TGUID = '{72178C2C-E45B-11D5-BC2A-00B0D0F3F4AB}';
    MFASFMutexType_Presentation: TGUID = '{72178C2D-E45B-11D5-BC2A-00B0D0F3F4AB}';
    MFASFMutexType_Unknown: TGUID = '{72178C2E-E45B-11D5-BC2A-00B0D0F3F4AB}';
    MFASFSPLITTER_PACKET_BOUNDARY: TGUID = '{fe584a05-e8d6-42e3-b176-f1211705fb6f}';
    MFASFINDEXER_TYPE_TIMECODE: TGUID = '{49815231-6bad-44fd-810a-3f60984ec7fd}';


const


    MFPKEY_ASFMEDIASINK_BASE_SENDTIME: TPROPERTYKEY = (fmtid: '{cddcbc82-3411-4119-9135-8423c41b3957}'; pid: 3);
    MFPKEY_ASFMEDIASINK_AUTOADJUST_BITRATE: TPROPERTYKEY = (fmtid: '{cddcbc82-3411-4119-9135-8423c41b3957}'; pid: 4);
    MFPKEY_ASFMEDIASINK_DRMACTION: TPROPERTYKEY = (fmtid: '{a1db6f6c-1d0a-4cb6-8254-cb36beedbc48}'; pid: 5);
    MFPKEY_ASFSTREAMSINK_CORRECTED_LEAKYBUCKET: TPROPERTYKEY = (fmtid: '{a2f152fb-8ad9-4a11-b345-2ce2fad8723d}'; pid: 1);


const
    MFASFINDEXER_PER_ENTRY_BYTES_DYNAMIC = $ffff;
    MFASFINDEXER_NO_FIXED_INTERVAL = $ffffffff;
    MFASFINDEXER_READ_FOR_REVERSEPLAYBACK_OUTOFDATASEGMENT = $ffffffffffffffff;
    MFASFINDEXER_APPROX_SEEK_TIME_UNKNOWN = $ffffffffffffffff;


    // Define WMContainer constants

    MFASF_MAX_STREAM_NUMBER = 127;
    MFASF_INVALID_STREAM_NUMBER = (MFASF_MAX_STREAM_NUMBER + 1);
    MFASF_PAYLOADEXTENSION_MAX_SIZE = $ff;
    MFASF_PAYLOADEXTENSION_VARIABLE_SIZE = $ffff;
    MFASF_DEFAULT_BUFFER_WINDOW_MS = 3000;


    MFASF_MIN_HEADER_BYTES = (sizeof(TGUID) + sizeof(QWORD));

type

     {$IFNDEF FPC}
     BSTR = POLESTR;
    {$ENDIF}

    IMFASFProfile = interface;
    IMFASFStreamConfig = interface;
    IMFASFMutualExclusion = interface;
    IMFASFStreamPrioritization = interface;

    IMFASFContentInfo = interface(IUnknown)
        ['{B1DCA5CD-D5DA-4451-8E9E-DB5C59914EAD}']
        function GetHeaderSize(pIStartOfContent: IMFMediaBuffer; out cbHeaderSize: QWORD): HResult; stdcall;
        function ParseHeader(pIHeaderBuffer: IMFMediaBuffer; cbOffsetWithinHeader: QWORD): HResult; stdcall;
        function GenerateHeader(var pIHeader: IMFMediaBuffer; out pcbHeader: DWORD): HResult; stdcall;
        function GetProfile(out ppIProfile: IMFASFProfile): HResult; stdcall;
        function SetProfile(pIProfile: IMFASFProfile): HResult; stdcall;
        function GeneratePresentationDescriptor(out ppIPresentationDescriptor: IMFPresentationDescriptor): HResult; stdcall;
        function GetEncodingConfigurationPropertyStore(wStreamNumber: word; out ppIStore: IPropertyStore): HResult; stdcall;
    end;


    IMFASFProfile = interface(IMFAttributes)
        ['{D267BF6A-028B-4e0d-903D-43F0EF82D0D4}']
        function GetStreamCount(out pcStreams: DWORD): HResult; stdcall;
        function GetStream(dwStreamIndex: DWORD; out pwStreamNumber: word; out ppIStream: IMFASFStreamConfig): HResult; stdcall;
        function GetStreamByNumber(wStreamNumber: word; out ppIStream: IMFASFStreamConfig): HResult; stdcall;
        function SetStream(pIStream: IMFASFStreamConfig): HResult; stdcall;
        function RemoveStream(wStreamNumber: word): HResult; stdcall;
        function CreateStream(pIMediaType: IMFMediaType; out ppIStream: IMFASFStreamConfig): HResult; stdcall;
        function GetMutualExclusionCount(out pcMutexs: DWORD): HResult; stdcall;
        function GetMutualExclusion(dwMutexIndex: DWORD; out ppIMutex: IMFASFMutualExclusion): HResult; stdcall;
        function AddMutualExclusion(pIMutex: IMFASFMutualExclusion): HResult; stdcall;
        function RemoveMutualExclusion(dwMutexIndex: DWORD): HResult; stdcall;
        function CreateMutualExclusion(out ppIMutex: IMFASFMutualExclusion): HResult; stdcall;
        function GetStreamPrioritization(out ppIStreamPrioritization: IMFASFStreamPrioritization): HResult; stdcall;
        function AddStreamPrioritization(pIStreamPrioritization: IMFASFStreamPrioritization): HResult; stdcall;
        function RemoveStreamPrioritization(): HResult; stdcall;
        function CreateStreamPrioritization(out ppIStreamPrioritization: IMFASFStreamPrioritization): HResult; stdcall;
        function Clone(out ppIProfile: IMFASFProfile): HResult; stdcall;
    end;


    IMFASFStreamConfig = interface(IMFAttributes)
        ['{9E8AE8D2-DBBD-4200-9ACA-06E6DF484913}']
        function GetStreamType(out pguidStreamType: TGUID): HResult; stdcall;
        function GetStreamNumber(): word; stdcall;
        function SetStreamNumber(wStreamNum: word): HResult; stdcall;
        function GetMediaType(out ppIMediaType: IMFMediaType): HResult; stdcall;
        function SetMediaType(pIMediaType: IMFMediaType): HResult; stdcall;
        function GetPayloadExtensionCount(out pcPayloadExtensions: word): HResult; stdcall;
        function GetPayloadExtension(wPayloadExtensionNumber: word; out pguidExtensionSystemID: TGUID;
            out pcbExtensionDataSize: word; out pbExtensionSystemInfo: PBYTE; var pcbExtensionSystemInfo: DWORD): HResult; stdcall;
        function AddPayloadExtension(guidExtensionSystemID: TGUID; cbExtensionDataSize: word; pbExtensionSystemInfo: PBYTE;
            cbExtensionSystemInfo: DWORD): HResult; stdcall;
        function RemoveAllPayloadExtensions(): HResult; stdcall;
        function Clone(out ppIStreamConfig: IMFASFStreamConfig): HResult; stdcall;
    end;

    IMFASFMutualExclusion = interface(IUnknown)
        ['{12558291-E399-11D5-BC2A-00B0D0F3F4AB}']
        function GetType(out pguidType: TGUID): HResult; stdcall;
        function SetType(const guidType: TGUID): HResult; stdcall;
        function GetRecordCount(out pdwRecordCount: DWORD): HResult; stdcall;
        function GetStreamsForRecord(dwRecordNumber: DWORD; out pwStreamNumArray: word; var pcStreams: DWORD): HResult; stdcall;
        function AddStreamForRecord(dwRecordNumber: DWORD; wStreamNumber: word): HResult; stdcall;
        function RemoveStreamFromRecord(dwRecordNumber: DWORD; wStreamNumber: word): HResult; stdcall;
        function RemoveRecord(dwRecordNumber: DWORD): HResult; stdcall;
        function AddRecord(out pdwRecordNumber: DWORD): HResult; stdcall;
        function Clone(out ppIMutex: IMFASFMutualExclusion): HResult; stdcall;
    end;


    IMFASFStreamPrioritization = interface(IUnknown)
        ['{699bdc27-bbaf-49ff-8e38-9c39c9b5e088}']
        function GetStreamCount(out pdwStreamCount: DWORD): HResult; stdcall;
        function GetStream(dwStreamIndex: DWORD; out pwStreamNumber: word; out pwStreamFlags: word): HResult; stdcall;
        function AddStream(wStreamNumber: word; wStreamFlags: word): HResult; stdcall;
        function RemoveStream(dwStreamIndex: DWORD): HResult; stdcall;
        function Clone(out ppIStreamPrioritization: IMFASFStreamPrioritization): HResult; stdcall;
    end;


    TMFASF_SPLITTERFLAGS = (
        MFASF_SPLITTER_REVERSE = $1,
        MFASF_SPLITTER_WMDRM = $2
        );


    IMFASFSplitter = interface(IUnknown)
        ['{12558295-E399-11D5-BC2A-00B0D0F3F4AB}']
        function Initialize(pIContentInfo: IMFASFContentInfo): HResult; stdcall;
        function SetFlags(dwFlags: DWORD): HResult; stdcall;
        function GetFlags(out pdwFlags: DWORD): HResult; stdcall;
        function SelectStreams(pwStreamNumbers: PWORD; wNumStreams: word): HResult; stdcall;
        function GetSelectedStreams(out pwStreamNumbers: PWORD; var pwNumStreams: word): HResult; stdcall;
        function ParseData(pIBuffer: IMFMediaBuffer; cbBufferOffset: DWORD; cbLength: DWORD): HResult; stdcall;
        function GetNextSample(out pdwStatusFlags: DWORD; out pwStreamNumber: word; out ppISample: IMFSample): HResult; stdcall;
        function Flush(): HResult; stdcall;
        function GetLastSendTime(out pdwLastSendTime: DWORD): HResult; stdcall;
    end;


    TASF_STATUSFLAGS = (
        ASF_STATUSFLAGS_INCOMPLETE = $1,
        ASF_STATUSFLAGS_NONFATAL_ERROR = $2
        );


    TASF_MUX_STATISTICS = record
        cFramesWritten: DWORD;
        cFramesDropped: DWORD;
    end;


    IMFASFMultiplexer = interface(IUnknown)
        ['{57BDD80A-9B38-4838-B737-C58F670D7D4F}']
        function Initialize(pIContentInfo: IMFASFContentInfo): HResult; stdcall;
        function SetFlags(dwFlags: DWORD): HResult; stdcall;
        function GetFlags(out pdwFlags: DWORD): HResult; stdcall;
        function ProcessSample(wStreamNumber: word; pISample: IMFSample; hnsTimestampAdjust: LONGLONG): HResult; stdcall;
        function GetNextPacket(out pdwStatusFlags: DWORD; out ppIPacket: IMFSample): HResult; stdcall;
        function Flush(): HResult; stdcall;
        function Ende(var pIContentInfo: IMFASFContentInfo): HResult; stdcall;
        function GetStatistics(wStreamNumber: word; out pMuxStats: TASF_MUX_STATISTICS): HResult; stdcall;
        function SetSyncTolerance(msSyncTolerance: DWORD): HResult; stdcall;
    end;


    TMFASF_INDEXERFLAGS = (
        MFASF_INDEXER_WRITE_NEW_INDEX = $1,
        MFASF_INDEXER_READ_FOR_REVERSEPLAYBACK = $2,
        MFASF_INDEXER_WRITE_FOR_LIVEREAD = $4
        );

    TASF_INDEX_IDENTIFIER = record
        guidIndexType: TGUID;
        wStreamNumber: word;
    end;

    PASF_INDEX_IDENTIFIER = ^TASF_INDEX_IDENTIFIER;

    TASF_INDEX_DESCRIPTOR = record
        Identifier: TASF_INDEX_IDENTIFIER;
        cPerEntryBytes: word;
        szDescription: array[0.. 31] of WCHAR;
        dwInterval: DWORD;
    end;

    PASF_INDEX_DESCRIPTOR = ^TASF_INDEX_DESCRIPTOR;


    IMFASFIndexer = interface(IUnknown)
        ['{53590F48-DC3B-4297-813F-787761AD7B3E}']
        function SetFlags(dwFlags: DWORD): HResult; stdcall;
        function GetFlags(out pdwFlags: DWORD): HResult; stdcall;
        function Initialize(pIContentInfo: IMFASFContentInfo): HResult; stdcall;
        function GetIndexPosition(pIContentInfo: IMFASFContentInfo; out pcbIndexOffset: QWORD): HResult; stdcall;
        function SetIndexByteStreams(ppIByteStreams: PIMFByteStream; cByteStreams: DWORD): HResult; stdcall;
        function GetIndexByteStreamCount(out pcByteStreams: DWORD): HResult; stdcall;
        function GetIndexStatus(const pIndexIdentifier: TASF_INDEX_IDENTIFIER; out pfIsIndexed: boolean;
            out pbIndexDescriptor: PBYTE; var pcbIndexDescriptor: DWORD): HResult; stdcall;
        function SetIndexStatus(pbIndexDescriptor: PBYTE; cbIndexDescriptor: DWORD; fGenerateIndex: boolean): HResult; stdcall;
        function GetSeekPositionForValue(const pvarValue: PROPVARIANT; pIndexIdentifier: PASF_INDEX_IDENTIFIER;
            out pcbOffsetWithinData: QWORD; out phnsApproxTime: TMFTIME; out pdwPayloadNumberOfStreamWithinPacket: DWORD): HResult;
            stdcall;
        function GenerateIndexEntries(pIASFPacketSample: IMFSample): HResult; stdcall;
        function CommitIndex(pIContentInfo: IMFASFContentInfo): HResult; stdcall;
        function GetIndexWriteSpace(out pcbIndexWriteSpace: QWORD): HResult; stdcall;
        function GetCompletedIndex(pIIndexBuffer: IMFMediaBuffer; cbOffsetWithinIndex: QWORD): HResult; stdcall;
    end;


    TMFASF_STREAMSELECTORFLAGS = (
        MFASF_STREAMSELECTOR_DISABLE_THINNING = $1,
        MFASF_STREAMSELECTOR_USE_AVERAGE_BITRATE = $2);

    TASF_SELECTION_STATUS = (
        ASF_STATUS_NOTSELECTED = 0,
        ASF_STATUS_CLEANPOINTSONLY = 1,
        ASF_STATUS_ALLDATAUNITS = 2
        );

    PASF_SELECTION_STATUS = ^TASF_SELECTION_STATUS;


    IMFASFStreamSelector = interface(IUnknown)
        ['{d01bad4a-4fa0-4a60-9349-c27e62da9d41}']
        function GetStreamCount(out pcStreams: DWORD): HResult; stdcall;
        function GetOutputCount(out pcOutputs: DWORD): HResult; stdcall;
        function GetOutputStreamCount(dwOutputNum: DWORD; out pcStreams: DWORD): HResult; stdcall;
        function GetOutputStreamNumbers(dwOutputNum: DWORD; out rgwStreamNumbers: word): HResult; stdcall;
        function GetOutputFromStream(wStreamNum: word; out pdwOutput: DWORD): HResult; stdcall;
        function GetOutputOverride(dwOutputNum: DWORD; out pSelection: TASF_SELECTION_STATUS): HResult; stdcall;
        function SetOutputOverride(dwOutputNum: DWORD; Selection: TASF_SELECTION_STATUS): HResult; stdcall;
        function GetOutputMutexCount(dwOutputNum: DWORD; out pcMutexes: DWORD): HResult; stdcall;
        function GetOutputMutex(dwOutputNum: DWORD; dwMutexNum: DWORD; out ppMutex: IUnknown): HResult; stdcall;
        function SetOutputMutexSelection(dwOutputNum: DWORD; dwMutexNum: DWORD; wSelectedRecord: word): HResult; stdcall;
        function GetBandwidthStepCount(out pcStepCount: DWORD): HResult; stdcall;
        function GetBandwidthStep(dwStepNum: DWORD; out pdwBitrate: DWORD; out rgwStreamNumbers: word;
            out rgSelections: PASF_SELECTION_STATUS): HResult; stdcall;
        function BitrateToStepNumber(dwBitrate: DWORD; out pdwStepNum: DWORD): HResult; stdcall;
        function SetStreamSelectorFlags(dwStreamSelectorFlags: DWORD): HResult; stdcall;
    end;


    TMFSINK_WMDRMACTION = (
        MFSINK_WMDRMACTION_UNDEFINED = 0,
        MFSINK_WMDRMACTION_ENCODE = 1,
        MFSINK_WMDRMACTION_TRANSCODE = 2,
        MFSINK_WMDRMACTION_TRANSCRYPT = 3,
        MFSINK_WMDRMACTION_LAST = 3
        );



    IMFDRMNetHelper = interface(IUnknown)
        ['{3D1FF0EA-679A-4190-8D46-7FA69E8C7E15}']
        function ProcessLicenseRequest(pLicenseRequest: PBYTE; cbLicenseRequest: DWORD; out ppLicenseResponse: PBYTE;
            out pcbLicenseResponse: DWORD; out pbstrKID: BSTR): HResult; stdcall;
        function GetChainedLicenseResponse(out ppLicenseResponse: PBYTE; out pcbLicenseResponse: DWORD): HResult; stdcall;
    end;

    TMFASF_MULTIPLEXERFLAGS = (
        MFASF_MULTIPLEXER_AUTOADJUST_BITRATE = $1
        );


{ Functions }

function MFCreateASFContentInfo(out ppIContentInfo: IMFASFContentInfo): HResult; stdcall; external MF_DLL;


function MFCreateASFProfile(out ppIProfile: IMFASFProfile): HResult; stdcall; external MF_DLL;

function MFCreateASFProfileFromPresentationDescriptor(pIPD: IMFPresentationDescriptor; out ppIProfile: IMFASFProfile): HResult;
    stdcall; external MF_DLL;

function MFCreatePresentationDescriptorFromASFProfile(pIProfile: IMFASFProfile; out ppIPD: IMFPresentationDescriptor): HResult;
    stdcall; external MF_DLL;


function MFCreateASFSplitter(out ppISplitter: IMFASFSplitter): HResult; stdcall; external MF_DLL;


function MFCreateASFMultiplexer(out ppIMultiplexer: IMFASFMultiplexer): HResult; stdcall; external MF_DLL;


function MFCreateASFIndexer(out ppIIndexer: IMFASFIndexer): HResult; stdcall; external MF_DLL;

function MFCreateASFIndexerByteStream(pIContentByteStream: IMFByteStream; cbIndexStartOffset: QWORD;
    out pIIndexByteStream: IMFByteStream): HResult; stdcall; external MF_DLL;

function MFCreateASFStreamSelector(pIASFProfile: IMFASFProfile; out ppSelector: IMFASFStreamSelector): HResult; stdcall; external MF_DLL;

function MFCreateASFMediaSink(pIByteStream: IMFByteStream; out ppIMediaSink: IMFMediaSink): HResult; stdcall; external MF_DLL;

function MFCreateASFMediaSinkActivate(pwszFileName: LPCWSTR; pContentInfo: IMFASFContentInfo; out ppIActivate: IMFActivate): HResult;
    stdcall; external MF_DLL;

function MFCreateWMVEncoderActivate(pMediaType: IMFMediaType; pEncodingConfigurationProperties: IPropertyStore;
    out ppActivate: IMFActivate): HResult; stdcall; external MF_DLL;

function MFCreateWMAEncoderActivate(pMediaType: IMFMediaType; pEncodingConfigurationProperties: IPropertyStore;
    out ppActivate: IMFActivate): HResult; stdcall; external MF_DLL;

function MFCreateASFStreamingMediaSink(pIByteStream: IMFByteStream; out ppIMediaSink: IMFMediaSink): HResult; stdcall; external MF_DLL;

function MFCreateASFStreamingMediaSinkActivate(pByteStreamActivate: IMFActivate; pContentInfo: IMFASFContentInfo;
    out ppIActivate: IMFActivate): HResult; stdcall; external MF_DLL;

implementation

end.

