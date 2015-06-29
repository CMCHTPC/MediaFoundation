// *@@@+++@@@@******************************************************************

// Microsoft Windows Media Foundation
// Copyright (C) Microsoft Corporation. All rights reserved.

// *@@@---@@@@******************************************************************


// MFAPI.h is the header containing the APIs for using the MF platform.

unit CMC.MFAPI;
{$IFDEF FPC}
{$MODE delphi}
{$ENDIF}

interface

uses
    Windows, Classes, SysUtils, ActiveX,
    DX12.DXGI,
    CMC.MFObjects, CMC.MediaObj, CMC.MMReg, CMC.AMVideo, CMC.DVDMedia, CMC.KSMedia;

const
    MFPlat_DLL = 'mfplat.dll';
    EVR_DLL = 'evr.dll';

const
{$IFDEF WINVER= WIN32_VISTA}
    MF_SDK_VERSION = $0001;
{$ELSE}
    MF_SDK_VERSION = $0002;
{$ENDIF}
    MF_API_VERSION = $0070; // This value is unused in the Win7 release and left at its Vista release value
    MF_VERSION = (MF_SDK_VERSION shl 16 or MF_API_VERSION);

    MFSTARTUP_NOSOCKET = $1;
    MFSTARTUP_LITE = MFSTARTUP_NOSOCKET;
    MFSTARTUP_FULL = 0;

    MF_E_DXGI_DEVICE_NOT_INITIALIZED = HRESULT($80041000); // DXVA2_E_NOT_INITIALIZED
    MF_E_DXGI_NEW_VIDEO_DEVICE = HRESULT($80041001); // DXVA2_E_NEW_VIDEO_DEVICE
    MF_E_DXGI_VIDEO_DEVICE_LOCKED = HRESULT($80041002); // DXVA2_E_VIDEO_DEVICE_LOCKED

    // Create an aligned memory buffer.
    // The following constants were chosen for parity with the alignment constants
    // in ntioapi.h

    MF_1_BYTE_ALIGNMENT = $00000000;
    MF_2_BYTE_ALIGNMENT = $00000001;
    MF_4_BYTE_ALIGNMENT = $00000003;
    MF_8_BYTE_ALIGNMENT = $00000007;
    MF_16_BYTE_ALIGNMENT = $0000000F;
    MF_32_BYTE_ALIGNMENT = $0000001F;
    MF_64_BYTE_ALIGNMENT = $0000003F;
    MF_128_BYTE_ALIGNMENT = $0000007F;
    MF_256_BYTE_ALIGNMENT = $000000FF;
    MF_512_BYTE_ALIGNMENT = $000001FF;
    MF_1024_BYTE_ALIGNMENT = $000003FF;
    MF_2048_BYTE_ALIGNMENT = $000007FF;
    MF_4096_BYTE_ALIGNMENT = $00000FFF;
    MF_8192_BYTE_ALIGNMENT = $00001FFF;

    // Session capabilities bitflags
    MFSESSIONCAP_START = $00000001;
    MFSESSIONCAP_SEEK = $00000002;
    MFSESSIONCAP_PAUSE = $00000004;
    MFSESSIONCAP_RATE_FORWARD = $00000010;
    MFSESSIONCAP_RATE_REVERSE = $00000020;
    MFSESSIONCAP_DOES_NOT_USE_NETWORK = $00000040;

    MFSampleExtension_ClosedCaption_CEA708_MAX_SIZE = 256;

    MF_METADATAFACIALEXPRESSION_SMILE = $00000001;

    MF_METADATATIMESTAMPS_DEVICE = $00000001;
    MF_METADATATIMESTAMPS_PRESENTATION = $00000002;

    MF_HISTOGRAM_CHANNEL_Y = $00000001;
    MF_HISTOGRAM_CHANNEL_R = $00000002;
    MF_HISTOGRAM_CHANNEL_G = $00000004;
    MF_HISTOGRAM_CHANNEL_B = $00000008;
    MF_HISTOGRAM_CHANNEL_Cb = $00000010;
    MF_HISTOGRAM_CHANNEL_Cr = $00000020;

const
    CLSID_MFSourceResolver: TGUID = '{90eab60f-e43a-4188-bcc4-e47fdf04868c}';
    MF_EVENT_SESSIONCAPS: TGUID = '{7E5EBCD0-11B8-4abe-AFAD-10F6599A7F42}';
    MF_EVENT_SESSIONCAPS_DELTA: TGUID = '{7E5EBCD1-11B8-4abe-AFAD-10F6599A7F42}';
    MF_EVENT_TOPOLOGY_STATUS: TGUID = '{30c5018d-9a53-454b-ad9e-6d5f8fa7c43b}';
    MF_EVENT_START_PRESENTATION_TIME: TGUID = '{5ad914d0-9b45-4a8d-a2c0-81d1e50bfb07}';
    MF_EVENT_PRESENTATION_TIME_OFFSET: TGUID = '{5ad914d1-9b45-4a8d-a2c0-81d1e50bfb07}';
    MF_EVENT_START_PRESENTATION_TIME_AT_OUTPUT: TGUID = '{5ad914d2-9b45-4a8d-a2c0-81d1e50bfb07}';

    // MESourceStarted attributes
    MF_EVENT_SOURCE_FAKE_START: TGUID = '{a8cc55a7-6b31-419f-845d-ffb351a2434b}'; // Type: UINT32
    MF_EVENT_SOURCE_PROJECTSTART: TGUID = '{a8cc55a8-6b31-419f-845d-ffb351a2434b}'; // Type: UINT64
    MF_EVENT_SOURCE_ACTUAL_START: TGUID = '{a8cc55a9-6b31-419f-845d-ffb351a2434b}'; // Type: UINT64

    // MEEndOfPresentationSegment attributes

    // Sample attributes
    // These are the well-known attributes that can be present on an MF Sample's
    // IMFAttributes store

    // @@MFSampleExtension_MaxDecodeFrameSize
    /// <summary>
    // {D3CC654F-F9F3-4A13-889F-F04EB2B5B957} MFSampleExtension_MaxDecodeFrameSize                {UINT64 (HI32(Width),LO32(Height))}
    // specify the maxiumum resolution of compressed input bitstream,
    // the decoder shall decode any comressed pictures below the specified maximum resolution
    // any input compressed pictures beyond the maximum resolution shall not be decoded and dropped by the decoder
    // the attribute shall be set on input sample
    /// </summary>
    MFSampleExtension_MaxDecodeFrameSize: TGUID = '{d3cc654f-f9f3-4a13-889f-f04eb2b5b957}';

    // @@MFSampleExtension_AccumulatedNonRefPicPercent
    /// <summary>
    // {79EA74DF-A740-445B-BC98-C9ED1F260EEE} MFSampleExtension_AccumulatedNonRefPicPercent
    // Type: UINT32
    // specify the percentage of accumulated non-reference pictures up to this output sample in decoding order
    // The most common examples are,
    // 1. if the sequence has the GOP structure of IPPPP......,   the value will be 0
    // 2. if the sequence has the GOP structure of IPBPB......,   the percentage will be around 40%~50%. The value is 40~50.
    // 3. if the sequence has the GOP structure of IPBBPBB......, the percentage will be around 50%~66%. The value is 50~60.
    // where B frames are not used for reference.
    // This is some statistic to application or pipeline whether decoder alone can have graceful degradation on quality management
    // In the above example,
    // 1. Decoder alone can't have graceful quality management. Because it can only have full frame rate or 1/15 of full frame rate when GOP size is 15 frames or 1/30 when GOP size is 30 frames
    // 2. Decoder alone can   have quality management. Because it can have full frame rate or 1/2 of full frame rate or 1/GOPSize
    // 2. Decoder alone can   have quality management. Because it can have full frame rate,  or down to 1/3 of full frame rate or 1/GOPSize
    // the attribute could be set on output sample from decoders
    /// </summary>
    // {79EA74DF-A740-445B-BC98-C9ED1F260EEE}
    MFSampleExtension_AccumulatedNonRefPicPercent: TGUID = '{79ea74df-a740-445b-bc98-c9ed1f260eee}';


    // Attributes for HW-DRM support

    // @@MFSampleExtension_Encryption_SubSample_Mapping
    /// <summary>
    /// The data blob associated with this attribute should contain an array of byte
    /// ranges as DWORDs where every two DWORDs make a set. The first DWORD in each set
    /// is the number of clear bytes and the second DWORD of the set is the number of
    /// encrypted bytes.
    /// Note that a pair of 0s is not a valid set (either value can be 0, but not both).
    /// The array of byte ranges that indicate which ranges to decrypt, including the
    /// possibility that the entire sample should NOT be decrypted.
    /// It must be set on an IMFSample using SetBlob
    /// </summary>
    MFSampleExtension_Encryption_SubSample_Mapping: TGUID = '{8444F27A-69A1-48DA-BD08-11CEF36830D2}';

    // MFSampleExtension_Encryption_ClearSliceHeaderData {5509A4F4-320D-4E6C-8D1A-94C66DD20CB0}
    (*
      The MF blob should be parsed in the way below defined in SliceHeaderSet, with proper verifications

      =============================================================================================================
      Note the slice header data here DO NOT have all bits for all the syntaxes.
      Some bits are removed on purpose to send out a lossy compressed slice header in order to be 100% secure
      The partial slice header data here SHALL not include any bits for emulation prevention byte $03
      =============================================================================================================

      typedef struct SliceHeader_tag {
      WORD dSliceHeaderLen;                   // indicate the length of the following slice header in byte, it shall not be more than 1024
      BYTE SliceHeaderBytes[0];               // slice header data, the last byte might contain some bits not used, leave them random
      } SliceHeader;

      With dSliceHeaderLen bytes serialized after the SliceHeader struct.
      And then use an array of these serialized consecutively,

      typedef struct SliceHeaderSet_tag {
      WORD dNumHeaders;                       // indicate the number of slice headers in the input sample
      SliceHeader rgstSliceheader[0];         // cNumHeaders slice header data
      } SliceHeaderSet;
      *)
    // Type: BLOB
    MFSampleExtension_Encryption_ClearSliceHeaderData: TGUID = '{5509a4f4-320d-4e6c-8d1a-94c66dd20cb0}';

    // MFSampleExtension_Encryption_HardwareProtection_KeyInfoID {8CBFCCEB-94A5-4DE1-8231-A85E47CF81E7}
    // Type: GUID
    // This attribute applies to media samples. The GUID associated with this
    // attribute indicates an identifier (KID/LID) for the hardware protection to be
    // used for the given sample. All hardware protected samples flowing out of the
    // MFT decryptor should have this attribute set with the proper GUID.
    MFSampleExtension_Encryption_HardwareProtection_KeyInfoID: TGUID = '{8cbfcceb-94a5-4de1-8231-a85e47cf81e7}';

    // MFSampleExtension_Encryption_HardwareProtection_KeyInfo {B2372080-455B-4DD7-9989-1A955784B754}
    // Type: BLOB
    // This attribute applies to media samples. The data blob associated with this
    // sample has all the information relative to the slot/ID for the hardware
    // protection to be used for the given sample. All hardware protected samples
    // flowing out of the MFT decryptor should have this attribute set with the
    // proper blob.
    MFSampleExtension_Encryption_HardwareProtection_KeyInfo: TGUID = '{b2372080-455b-4dd7-9989-1a955784b754}';

    // MFSampleExtension_Encryption_HardwareProtection_VideoDecryptorContext {693470C8-E837-47A0-88CB-535B905E3582}
    // Data type: IUnknown * (IMFContentDecryptorContext)
    // This attribute applies to media samples. It associates a sample with a
    // given IMFContentDecryptorContext which is needed to be able to to
    // decrypt/decode the sample properly when using hardware protection.
    MFSampleExtension_Encryption_HardwareProtection_VideoDecryptorContext: TGUID = '{693470c8-e837-47a0-88cb-535b905e3582}';

    // MFSampleExtension_Encryption_Opaque_Data {224D77E5-1391-4FFB-9F41-B432F68C611D}
    // Data type : BLOB
    // This attribute applies to media samples.The data blob associated with this sample has some private information
    // set by OEM secure environment to be used for the given sample.The hardware protected samples flowing out of the
    // MFT decryptor might have this attribute set with the proper blob.
    // When present, this attribute is set by the decryptor MFT with data that originates from the OEM secure environment.
    // The host decoder may extract this and provide the data to the D3D11 device for VLD decoding through(UINT  PrivateDataSize, void* pPrivateData)
    // of D3D11_VIDEO_DECODER_BEGIN_FRAME_CRYPTO_SESSION data structure in the DecoderBeginFrame() call, when present.
    MFSampleExtension_Encryption_Opaque_Data: TGUID = '{224d77e5-1391-4ffb-9f41-b432f68c611d}';


    // MFSampleExtension_NALULengthInfo. This is an alias of  MF_NALU_LENGTH_INFORMATION
    // Type: BLOB
    // Set MFSampleExtension_NALULengthInfo as a BLOB on the input sample,
    // with one DWORD for each NALU including start code and NALU type in the sample. For example, if
    // there are AUD (9 bytes), SPS (25 bytes), PPS (10 bytes), IDR slice1 (50 k), IDR slice 2 (60 k),
    // then there should be 5 DWORDs with values 9, 25, 10, 50 k, 60 k in the BLOB.

    MFSampleExtension_NALULengthInfo: TGUID = '{19124E7C-AD4B-465F-BB18-20186287B6AF}';

    // MFSampleExtension_Encryption_NALUTypes. {B0F067C7-714C-416C-8D59-5F4DDF8913B6}
    // Type: BLOB
    // The MF blob contains all the NALU type byte for different NALUs in the MF sample.One NALU type is one byte, including the syntaxes forbidden_zero_bit, nal_ref_idc, and nal_unit_type.
    MFSampleExtension_Encryption_NALUTypes: TGUID = '{b0f067c7-714c-416c-8d59-5f4ddf8913b6}';

    // MFSampleExtension_Encryption_SPSPPSData {AEDE0FA2-0E0C-453C-B7F3-DE8693364D11}
    // Type : BLOB
    // When present, the MF blob contains all SPS(s) and / or PPS(s) NALUs inside the MF sample.
    // SPSs and PPSs shall be present in the same order as that in the MF sample and in the format of AvcC,
    // which is DWORD, four - byte length inforamtion for the bytes followed, and NALU data of SPS or PPS, for each NALU.
    // For example, the layout could be 10 in DWORD, 10 bytes data for SPS, 5 in DWORD, and 5 bytes data for PPS.In total, it has 4 + 10 + 4 + 5 = 23 bytes.
    MFSampleExtension_Encryption_SPSPPSData: TGUID = '{aede0fa2-0e0c-453c-b7f3-de8693364d11}';


    // MFSampleExtension_Encryption_SEIData {3CF0E972-4542-4687-9999-585F565FBA7D}
    // Type : BLOB
    // When present, the MF blob contains all SEI NALUs inside the MF sample. (If there are multiple SEIs in the protected MF sample, all the SEIs shall be present in the blob.)
    // SEIs shall be present in the same order as that in the MF sample and in the format of AvcC,
    // which is DWORD, four - byte length inforamtion for the bytes followed, and NALU data of SEI.
    // For example, the layout could be 10 in DWORD, 10 bytes data for the first SEI, 5 in DWORD, and 5 bytes data for the second SEI.In total, it has 4 + 10 + 4 + 5 = 23 bytes.

    // Some note about  how to process the SEI NALUs in the blob of MFSampleExtension_Encryption_SEIData
    // Decoder should verify every byte of an SEI NALU is clear, not protected, before parsing the SEI NALU
    // otherwise, decoder should treat the SEI NALU as corrupted by encryption and skip the parsing of the SEI NALU
    MFSampleExtension_Encryption_SEIData: TGUID = '{3cf0e972-4542-4687-9999-585f565fba7d}';

    // MFSampleExtension_Encryption_HardwareProtection {9A2B2D2B-8270-43E3-8448-994F426E8886}
    // Type: UINT32
    // When present, this UINT32 attribute indicates whether the sample is hardware protected.
    // 0 = not hardware protected, nonzero = hardware protected
    MFSampleExtension_Encryption_HardwareProtection: TGUID = '{9a2b2d2b-8270-43e3-8448-994f426e8886}';

    // MFSampleExtension_CleanPoint {9cdf01d8-a0f0-43ba-b077-eaa06cbd728a}
    // Type: UINT32
    // If present and nonzero, indicates that the sample is a clean point (key
    // frame), and decoding can begin at this sample.
    MFSampleExtension_CleanPoint: TGUID = '{9cdf01d8-a0f0-43ba-b077-eaa06cbd728a}';

    // MFSampleExtension_Discontinuity {9cdf01d9-a0f0-43ba-b077-eaa06cbd728a}
    // Type: UINT32
    // If present and nonzero, indicates that the sample data represents the first
    // sample following a discontinuity (gap) in the stream of samples.
    // This can happen, for instance, if the previous sample was lost in
    // transmission.
    MFSampleExtension_Discontinuity: TGUID = '{9cdf01d9-a0f0-43ba-b077-eaa06cbd728a}';

    // MFSampleExtension_Token {8294da66-f328-4805-b551-00deb4c57a61}
    // Type: IUNKNOWN
    // When an IMFMediaStream delivers a sample via MEMediaStream, this attribute
    // should be set to the IUnknown *pToken argument that was passed with the
    // IMFMediaStream::RequestSample call to which this sample corresponds.
    MFSampleExtension_Token: TGUID = '{8294da66-f328-4805-b551-00deb4c57a61}';

    // MFSampleExtension_ClosedCaption_CEA708 {26f09068-e744-47dc-aa03-dbf20403bde6}
    // Type: BLOB
    // MF sample attribute contained the closed caption data in CEA-708 format.
    MFSampleExtension_ClosedCaption_CEA708: TGUID = '{26f09068-e744-47dc-aa03-dbf20403bde6}';

    // MFSampleExtension_DecodeTimestamp {73A954D4-09E2-4861-BEFC-94BD97C08E6E}
    // Type : UINT64
    // If present, contains the DTS (Decoding Time Stamp) of the sample.
    MFSampleExtension_DecodeTimestamp: TGUID = '{73a954d4-09e2-4861-befc-94bd97c08e6e}';

    // MFSampleExtension_VideoEncodeQP {B2EFE478-F979-4C66-B95E-EE2B82C82F36}
    // Type: UINT64
    // Used by video encoders to specify the QP used to encode the output sample.
    MFSampleExtension_VideoEncodeQP: TGUID = '{b2efe478-f979-4c66-b95e-ee2b82c82f36}';

    // MFSampleExtension_VideoEncPictureType {973704E6-CD14-483C-8F20-C9FC0928BAD5}
    // Type: UINT32
    // Used by video encoders to specify the output sample's picture type.
    MFSampleExtension_VideoEncodePictureType: TGUID = '{973704e6-cd14-483c-8f20-c9fc0928bad5}';

    // MFSampleExtension_FrameCorruption {B4DD4A8C-0BEB-44C4-8B75-B02B913B04F0}
    // Type: UINT32
    // Indicates whether the frame in the sample has corruption or not
    // value 0 indicates that there is no corruption, or it is unknown
    // Value 1 indicates that some corruption was detected e.g, during decoding
    MFSampleExtension_FrameCorruption: TGUID = '{b4dd4a8c-0beb-44c4-8b75-b02b913b04f0}';

    // MFSampleExtension_DirtyRects {9BA70225-B342-4E97-9126-0B566AB7EA7E}
    // Type: BLOB
    // This is a blob containing information about the dirty rectangles within
    // a frame. The blob is a struct of type DIRTYRECT_INFO containing an array
    // of NumDirtyRects number of DirtyRects elements.
    MFSampleExtension_DirtyRects: TGUID = '{9ba70225-b342-4e97-9126-0b566ab7ea7e}';

    // MFSampleExtension_MoveRegions {E2A6C693-3A8B-4B8D-95D0-F60281A12FB7}
    // Type: BLOB
    // This is a blob containing information about the moved regions within
    // a frame. The blob is a struct of type MOVEREGION_INFO containing an array
    // of NumMoveRegions number of MoveRegions elements.
    MFSampleExtension_MoveRegions: TGUID = '{e2a6c693-3a8b-4b8d-95d0-f60281a12fb7}';

    MF_EVENT_SOURCE_TOPOLOGY_CANCELED: TGUID = '{db62f650-9a5e-4704-acf3-563bc6a73364}'; // Type: UINT32

    /// / MESourceCharacteristicsChanged attributes

    MF_EVENT_SOURCE_CHARACTERISTICS: TGUID = '{47db8490-8b22-4f52-afda-9ce1b2d3cfa8}'; // Type: UINT32

    MF_EVENT_SOURCE_CHARACTERISTICS_OLD: TGUID = '{47db8491-8b22-4f52-afda-9ce1b2d3cfa8}'; // Type: UINT32


    // MESourceRateChangeRequested attributes

    MF_EVENT_DO_THINNING: TGUID = '{321ea6fb-dad9-46e4-b31d-d2eae7090e30}'; // Type: UINT32

    // MEStreamSinkScrubSampleComplete attributes

    MF_EVENT_SCRUBSAMPLE_TIME: TGUID = '{9ac712b3-dcb8-44d5-8d0c-37455a2782e3}'; // Type: UINT64


    // MESinkInvalidated and MESessionStreamSinkFormatChanged attributes

    MF_EVENT_OUTPUT_NODE: TGUID = '{830f1a8b-c060-46dd-a801-1c95dec9b107}'; // Type: UINT64


    // METransformNeedInput attributes

    MF_EVENT_MFT_INPUT_STREAM_ID: TGUID = '{f29c2cca-7ae6-42d2-b284-bf837cc874e2}'; // Type: UINT32


    // METransformDrainComplete and METransformMarker attributes

    MF_EVENT_MFT_CONTEXT: TGUID = '{b7cd31f1-899e-4b41-80c9-26a896d32977}'; // Type: UINT64


    // MEContentProtectionMetadata attributes

    MF_EVENT_STREAM_METADATA_KEYDATA: TGUID = '{cd59a4a1-4a3b-4bbd-8665-72a40fbea776}'; // Type: BLOB

    MF_EVENT_STREAM_METADATA_CONTENT_KEYIDS: TGUID = '{5063449d-cc29-4fc6-a75a-d247b35af85c}'; // Type: BLOB

    MF_EVENT_STREAM_METADATA_SYSTEMID: TGUID = '{1ea2ef64-ba16-4a36-8719-fe7560ba32ad}'; // Type: BLOB

    // (MFSampleExtension_HDCP_FrameCounter
    // Type: BLOB
    // This blob contains the PES_private_data section of a PES packet according to the
    // HDCP 2.2/2.1 specification.  This blob should contain the stream counter and
    // input counter.
    MFSampleExtension_HDCP_FrameCounter: TGUID = '{9d389c60-f507-4aa6-a40a-71027a02f3de}';

    /// //////////////////////////////////////////////////////////////////////////

    // The following sample attributes are used for encrypted samples

    /// //////////////////////////////////////////////////////////////////////////

    // MFSampleExtension_DescrambleData {43483BE6-4903-4314-B032-2951365936FC}
    // Type: UINT64
    MFSampleExtension_DescrambleData: TGUID = '{43483be6-4903-4314-b032-2951365936fc}';

    // MFSampleExtension_SampleKeyID {9ED713C8-9B87-4B26-8297-A93B0C5A8ACC}
    // Type: UINT32
    MFSampleExtension_SampleKeyID: TGUID = '{9ed713c8-9b87-4b26-8297-a93b0c5a8acc}';

    // MFSampleExtension_GenKeyFunc {441CA1EE-6B1F-4501-903A-DE87DF42F6ED}
    // Type: UINT64
    MFSampleExtension_GenKeyFunc: TGUID = '{441ca1ee-6b1f-4501-903a-de87df42f6ed}';

    // MFSampleExtension_GenKeyCtx {188120CB-D7DA-4B59-9B3E-9252FD37301C}
    // Type: UINT64
    MFSampleExtension_GenKeyCtx: TGUID = '{188120cb-d7da-4b59-9b3e-9252fd37301c}';

    // MFSampleExtension_PacketCrossOffsets {2789671D-389F-40BB-90D9-C282F77F9ABD}
    // Type: BLOB
    MFSampleExtension_PacketCrossOffsets: TGUID = '{2789671d-389f-40bb-90d9-c282f77f9abd}';

    // MFSampleExtension_Encryption_SampleID {6698B84E-0AFA-4330-AEB2-1C0A98D7A44D}
    // Type: BLOB
    MFSampleExtension_Encryption_SampleID: TGUID = '{6698b84e-0afa-4330-aeb2-1c0a98d7a44d}';

    // MFSampleExtension_Encryption_KeyID {76376591-795F-4DA1-86ED-9D46ECA109A9}
    // Type: BLOB
    MFSampleExtension_Encryption_KeyID: TGUID = '{76376591-795f-4da1-86ed-9d46eca109a9}';

    // MFSampleExtension_Content_KeyID {C6C7F5B0-ACCA-415B-87D9-10441469EFC6}
    // Type: GUID
    MFSampleExtension_Content_KeyID: TGUID = '{c6c7f5b0-acca-415b-87d9-10441469efc6}';

    // MFSampleExtension_Encryption_SubSampleMappingSplit {FE0254B9-2AA5-4EDC-99F7-17E89DBF9174}
    // Type: BLOB
    MFSampleExtension_Encryption_SubSampleMappingSplit: TGUID = '{fe0254b9-2aa5-4edc-99f7-17e89dbf9174}';

    /// //////////////////////////////////////////////////////////////////////////

    // MFSample STANDARD EXTENSION ATTRIBUTE GUIDs

    /// //////////////////////////////////////////////////////////////////////////

    // {b1d5830a-deb8-40e3-90fa-389943716461}   MFSampleExtension_Interlaced                {UINT32 (BOOL)}
    MFSampleExtension_Interlaced: TGUID = '{b1d5830a-deb8-40e3-90fa-389943716461}';

    // {941ce0a3-6ae3-4dda-9a08-a64298340617}   MFSampleExtension_BottomFieldFirst          {UINT32 (BOOL)}
    MFSampleExtension_BottomFieldFirst: TGUID = '{941ce0a3-6ae3-4dda-9a08-a64298340617}';

    // {304d257c-7493-4fbd-b149-9228de8d9a99}   MFSampleExtension_RepeatFirstField          {UINT32 (BOOL)}
    MFSampleExtension_RepeatFirstField: TGUID = '{304d257c-7493-4fbd-b149-9228de8d9a99}';

    // {9d85f816-658b-455a-bde0-9fa7e15ab8f9}   MFSampleExtension_SingleField               {UINT32 (BOOL)}
    MFSampleExtension_SingleField: TGUID = '{9d85f816-658b-455a-bde0-9fa7e15ab8f9}';

    // {6852465a-ae1c-4553-8e9b-c3420fcb1637}   MFSampleExtension_DerivedFromTopField       {UINT32 (BOOL)}
    MFSampleExtension_DerivedFromTopField: TGUID = '{6852465a-ae1c-4553-8e9b-c3420fcb1637}';

    // MFSampleExtension_MeanAbsoluteDifference {1cdbde11-08b4-4311-a6dd-0f9f371907aa}
    // Type: UINT32
    MFSampleExtension_MeanAbsoluteDifference: TGUID = '{1cdbde11-08b4-4311-a6dd-0f9f371907aa}';

    // MFSampleExtension_LongTermReferenceFrameInfo {9154733f-e1bd-41bf-81d3-fcd918f71332}
    // Type: UINT32
    MFSampleExtension_LongTermReferenceFrameInfo: TGUID = '{9154733f-e1bd-41bf-81d3-fcd918f71332}';

    // MFSampleExtension_ROIRectangle {3414a438-4998-4d2c-be82-be3ca0b24d43}
    // Type: BLOB
    MFSampleExtension_ROIRectangle: TGUID = '{3414a438-4998-4d2c-be82-be3ca0b24d43}';

    /// ////////////////////////////////////////////////////////////////////////////
    /// These are the attribute GUIDs that need to be used by MFT0 to provide
    /// thumbnail support.  We are declaring these in our internal idl first and
    /// once we pass API spec review, we can move it to the public header.
    /// ////////////////////////////////////////////////////////////////////////////
    // MFSampleExtension_PhotoThumbnail
    // {74BBC85C-C8BB-42DC-B586DA17FFD35DCC}
    // Type: IUnknown
    // If this attribute is set on the IMFSample provided by the MFT0, this will contain the IMFMediaBuffer which contains
    // the Photo Thumbnail as configured using the KSPROPERTYSETID_ExtendedCameraControl.
    MFSampleExtension_PhotoThumbnail: TGUID = '{74BBC85C-C8BB-42DC-B586-DA17FFD35DCC}';

    // MFSampleExtension_PhotoThumbnailMediaType
    // {61AD5420-EBF8-4143-89AF6BF25F672DEF}
    // Type: IUnknown
    // This attribute will contain the IMFMediaType which describes the image format type contained in the
    // MFSampleExtension_PhotoThumbnail attribute.  If the MFSampleExtension_PhotoThumbnail attribute
    // is present on the photo sample, the MFSampleExtension_PhotoThumbnailMediaType is required.
    MFSampleExtension_PhotoThumbnailMediaType: TGUID = '{61AD5420-EBF8-4143-89AF-6BF25F672DEF}';

    // MFSampleExtension_CaptureMetadata
    // Type: IUnknown (IMFAttributes)
    // This is the IMFAttributes store for all the metadata related to the capture
    // pipeline.  It can be potentially present on any IMFSample.
    MFSampleExtension_CaptureMetadata: TGUID = '{2EBE23A8-FAF5-444A-A6A2-EB810880AB5D}';

    // MFSampleExtension_MDLCacheCookie
    // Type: IUnknown (IMFAttributes)
    // This is the IMFAttributes stored in the sample if the mini driver
    // desires to cache MDL's. This is used internally by the pipeline.
    // {5F002AF9-D8F9-41A3-B6C3-A2AD43F647AD}

    MFSampleExtension_MDLCacheCookie: TGUID = '{5F002AF9-D8F9-41A3-B6C3-A2AD43F647AD}';

    // Put all MF_CAPTURE_METADATA_* here.
    // {0F9DD6C6-6003-45D8-BD59-F1F53E3D04E8}   MF_CAPTURE_METADATA_PHOTO_FRAME_FLASH       {UINT32}
    // 0 - No flash triggered on this frame.
    // non-0 - Flash triggered on this frame.
    // Do not explicitly check for a value of 1 here, we may overload this to
    // indicate special types of flash going forward (applications should only
    // check for != 0 to indicate flash took place).
    MF_CAPTURE_METADATA_PHOTO_FRAME_FLASH: TGUID = '{0F9DD6C6-6003-45D8-BD59-F1F53E3D04E8}';

    // The raw IUnknown corresponding to the IMFMediaBuffer that contains the metadata
    // stream as written by the camera driver.  This may be a mix of pre-defined metadata
    // such as photo confirmation, focus notification, or custom metadata that only
    // the MFT0 can parse.
    MF_CAPTURE_METADATA_FRAME_RAWSTREAM: TGUID = '{9252077B-2680-49B9-AE02-B19075973B70}';

    // {A87EE154-997F-465D-B91F-29D53B982B88}
    // TYPE: UINT32
    MF_CAPTURE_METADATA_FOCUSSTATE: TGUID = '{a87ee154-997f-465d-b91f-29d53b982b88}';

    // {BB3716D9-8A61-47A4-8197-459C7FF174D5}
    // TYPE: UINT32
    MF_CAPTURE_METADATA_REQUESTED_FRAME_SETTING_ID: TGUID = '{bb3716d9-8a61-47a4-8197-459c7ff174d5}';

    // {16B9AE99-CD84-4063-879D-A28C7633729E}
    // TYPE: UINT32
    MF_CAPTURE_METADATA_EXPOSURE_TIME: TGUID = '{16b9ae99-cd84-4063-879d-a28c7633729e}';

    // {D198AA75-4B62-4345-ABF3-3C31FA12C299}
    MF_CAPTURE_METADATA_EXPOSURE_COMPENSATION: TGUID = '{d198aa75-4b62-4345-abf3-3c31fa12c299}';

    // {E528A68F-B2E3-44FE-8B65-07BF4B5A13FF}
    // TYPE: UINT32
    MF_CAPTURE_METADATA_ISO_SPEED: TGUID = '{e528a68f-b2e3-44fe-8b65-07bf4b5a13ff}';

    // {B5FC8E86-11D1-4E70-819B-723A89FA4520}
    // TYPE: UINT32
    MF_CAPTURE_METADATA_LENS_POSITION: TGUID = '{b5fc8e86-11d1-4e70-819b-723a89fa4520}';

    // {9CC3B54D-5ED3-4BAE-B388-7670AEF59E13}
    // TYPE: UINT64
    MF_CAPTURE_METADATA_SCENE_MODE: TGUID = '{9cc3b54d-5ed3-4bae-b388-7670aef59e13}';

    // {4A51520B-FB36-446C-9DF2-68171B9A0389}
    // TYPE: UINT32
    MF_CAPTURE_METADATA_FLASH: TGUID = '{4a51520b-fb36-446c-9df2-68171b9a0389}';

    // {9C0E0D49-0205-491A-BC9D-2D6E1F4D5684}
    // TYPE: UINT32
    MF_CAPTURE_METADATA_FLASH_POWER: TGUID = '{9c0e0d49-0205-491a-bc9d-2d6e1f4d5684}';

    // {C736FD77-0FB9-4E2E-97A2-FCD490739EE9}
    // TYPE: UINT32
    MF_CAPTURE_METADATA_WHITEBALANCE: TGUID = '{c736fd77-0fb9-4e2e-97a2-fcd490739ee9}';

    // {E50B0B81-E501-42C2-ABF2-857ECB13FA5C}
    // TYPE: UINT32
    MF_CAPTURE_METADATA_ZOOMFACTOR: TGUID = '{e50b0b81-e501-42c2-abf2-857ecb13fa5c}';

    // {864F25A6-349F-46B1-A30E-54CC22928A47}
    // TYPE: BLOB
    MF_CAPTURE_METADATA_FACEROIS: TGUID = '{864f25a6-349f-46b1-a30e-54cc22928a47}';

    // {E94D50CC-3DA0-44d4-BB34-83198A741868}
    // TYPE: BLOB
    MF_CAPTURE_METADATA_FACEROITIMESTAMPS: TGUID = '{e94d50cc-3da0-44d4-bb34-83198a741868}';

    // {B927A1A8-18EF-46d3-B3AF-69372F94D9B2}
    // TYPE: BLOB
    MF_CAPTURE_METADATA_FACEROICHARACTERIZATIONS: TGUID = '{b927a1a8-18ef-46d3-b3af-69372f94d9b2}';

    // {05802AC9-0E1D-41c7-A8C8-7E7369F84E1E}
    // TYPE: BLOB
    MF_CAPTURE_METADATA_ISO_GAINS: TGUID = '{05802ac9-0e1d-41c7-a8c8-7e7369f84e1e}';

    // {DB51357E-9D3D-4962-B06D-07CE650D9A0A}
    // TYPE: UINT64
    MF_CAPTURE_METADATA_SENSORFRAMERATE: TGUID = '{db51357e-9d3d-4962-b06d-07ce650d9a0a}';

    // {E7570C8F-2DCB-4c7c-AACE-22ECE7CCE647}
    // TYPE: BLOB
    MF_CAPTURE_METADATA_WHITEBALANCE_GAINS: TGUID = '{e7570c8f-2dcb-4c7c-aace-22ece7cce647}';

    // {85358432-2EF6-4ba9-A3FB-06D82974B895}
    // TYPE: BLOB
    MF_CAPTURE_METADATA_HISTOGRAM: TGUID = '{85358432-2ef6-4ba9-a3fb-06d82974b895}';

    // {2e9575b8-8c31-4a02-8575-42b197b71592}
    // TYPE: BLOB
    MF_CAPTURE_METADATA_EXIF: TGUID = '{2e9575b8-8c31-4a02-8575-42b197b71592}';


    // MFT Registry categories


    // ifdef MF_INIT_GUIDS
    // include <initguid.h>
    // endif

    // {d6c02d4b-6833-45b4-971a-05a4b04bab91}   MFT_CATEGORY_VIDEO_DECODER
    MFT_CATEGORY_VIDEO_DECODER: TGUID = '{d6c02d4b-6833-45b4-971a-05a4b04bab91}';

    // {f79eac7d-e545-4387-bdee-d647d7bde42a}   MFT_CATEGORY_VIDEO_ENCODER
    MFT_CATEGORY_VIDEO_ENCODER: TGUID = '{f79eac7d-e545-4387-bdee-d647d7bde42a}';

    // {12e17c21-532c-4a6e-8a1c-40825a736397}   MFT_CATEGORY_VIDEO_EFFECT
    MFT_CATEGORY_VIDEO_EFFECT: TGUID = '{12e17c21-532c-4a6e-8a1c-40825a736397}';

    // {059c561e-05ae-4b61-b69d-55b61ee54a7b}   MFT_CATEGORY_MULTIPLEXER
    MFT_CATEGORY_MULTIPLEXER: TGUID = '{059c561e-05ae-4b61-b69d-55b61ee54a7b}';

    // {a8700a7a-939b-44c5-99d7-76226b23b3f1}   MFT_CATEGORY_DEMULTIPLEXER
    MFT_CATEGORY_DEMULTIPLEXER: TGUID = '{a8700a7a-939b-44c5-99d7-76226b23b3f1}';

    // {9ea73fb4-ef7a-4559-8d5d-719d8f0426c7}   MFT_CATEGORY_AUDIO_DECODER
    MFT_CATEGORY_AUDIO_DECODER: TGUID = '{9ea73fb4-ef7a-4559-8d5d-719d8f0426c7}';

    // {91c64bd0-f91e-4d8c-9276-db248279d975}   MFT_CATEGORY_AUDIO_ENCODER
    MFT_CATEGORY_AUDIO_ENCODER: TGUID = '{91c64bd0-f91e-4d8c-9276-db248279d975}';

    // {11064c48-3648-4ed0-932e-05ce8ac811b7}   MFT_CATEGORY_AUDIO_EFFECT
    MFT_CATEGORY_AUDIO_EFFECT: TGUID = '{11064c48-3648-4ed0-932e-05ce8ac811b7}';

    // {302EA3FC-AA5F-47f9-9F7A-C2188BB163021}...MFT_CATEGORY_VIDEO_PROCESSOR
    MFT_CATEGORY_VIDEO_PROCESSOR: TGUID = '{302ea3fc-aa5f-47f9-9f7a-c2188bb16302}';

    // {90175d57-b7ea-4901-aeb3-933a8747756f}   MFT_CATEGORY_OTHER
    MFT_CATEGORY_OTHER: TGUID = '{90175d57-b7ea-4901-aeb3-933a8747756f}';

    /// ////////////////////////////////////////////////////////////////////////////////////////////////////////////  MFT  Attributes GUIDs ////////////////////////////
    // {53476A11-3F13-49fb-AC42-EE2733C96741} MFT_SUPPORT_DYNAMIC_FORMAT_CHANGE {UINT32 (BOOL)}
    MFT_SUPPORT_DYNAMIC_FORMAT_CHANGE: TGUID = '{53476a11-3f13-49fb-ac42-ee2733c96741}';

    /// ////////////////////////////////////////////////////////////////////////////////////////////////////////////  Media Type GUIDs ////////////////////////////
    /// /////////////////////////////////////////////////////////////////////////////


    // GUIDs for media types


    // In MF, media types for uncompressed video formats MUST be composed from a FourCC or D3DFORMAT combined with
    // the "base GUID" {00000000-0000-0010-8000-00AA00389B71} by replacing the initial 32 bits with the FourCC/D3DFORMAT

    // Audio media types for types which already have a defined wFormatTag value can be constructed similarly, by
    // putting the wFormatTag (zero-extended to 32 bits) into the first 32 bits of the base GUID.

    // Compressed video or audio can also use any well-known GUID that exists, or can create a new GUID.

    // GUIDs for common media types are defined below.


    // video media types


    // If no D3D headers have been included yet, define local versions of D3DFMT constants we use.
    // We can't include D3D headers from this header because we need it to be compatible with all versions
    // of D3D.

    D3DFMT_R8G8B8 = 20;
    D3DFMT_A8R8G8B8 = 21;
    D3DFMT_X8R8G8B8 = 22;
    D3DFMT_R5G6B5 = 23;
    D3DFMT_X1R5G5B5 = 24;
    D3DFMT_P8 = 41;
    LOCAL_D3DFMT_DEFINES = 1;
{$IFDEF FPC}
    MFVideoFormat_Base: TGUID = (Data1: $00000000; Data2: 0000; Data3: 0010; Data4: ($80, $00, $00, $AA, $00, $38, $9B, $71));

    MFVideoFormat_RGB32: TGUID = (Data1: D3DFMT_X8R8G8B8; Data2: 0000; Data3: 0010; Data4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_ARGB32: TGUID = (Data1: D3DFMT_A8R8G8B8; Data2: 0000; Data3: 0010; Data4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_RGB24: TGUID = (Data1: D3DFMT_R8G8B8; Data2: 0000; Data3: 0010; Data4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_RGB555: TGUID = (Data1: D3DFMT_X1R5G5B5; Data2: 0000; Data3: 0010; Data4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_RGB565: TGUID = (Data1: D3DFMT_R5G6B5; Data2: 0000; Data3: 0010; Data4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_RGB8: TGUID = (Data1: D3DFMT_P8; Data2: 0000; Data3: 0010; Data4: ($80, $00, $00, $AA, $00, $38, $9B, $71));

    MFVideoFormat_AI44: TGUID = (Data1: Ord('A') or (Ord('I') shl 8) or (Ord('4') shl 16) or (Ord('4') shl 24); Data2: 0000; Data3: 0010;
        Data4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_AYUV: TGUID = (Data1: Ord('A') or (Ord('Y') shl 8) or (Ord('U') shl 16) or (Ord('V') shl 24); Data2: 0000; Data3: 0010;
        Data4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_YUY2: TGUID = (Data1: Ord('Y') or (Ord('U') shl 8) or (Ord('Y') shl 16) or (Ord('2') shl 24); Data2: 0000; Data3: 0010;
        Data4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_YVYU: TGUID = (Data1: Ord('Y') or (Ord('V') shl 8) or (Ord('Y') shl 16) or (Ord('U') shl 24); Data2: 0000; Data3: 0010;
        Data4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_YVU9: TGUID = (Data1: Ord('Y') or (Ord('V') shl 8) or (Ord('U') shl 16) or (Ord('9') shl 24); Data2: 0000; Data3: 0010;
        Data4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_UYVY: TGUID = (Data1: Ord('U') or (Ord('Y') shl 8) or (Ord('V') shl 16) or (Ord('Y') shl 24); Data2: 0000; Data3: 0010;
        Data4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_NV11: TGUID = (Data1: Ord('N') or (Ord('V') shl 8) or (Ord('1') shl 16) or (Ord('1') shl 24); Data2: 0000; Data3: 0010;
        Data4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_NV12: TGUID = (Data1: Ord('N') or (Ord('V') shl 8) or (Ord('1') shl 16) or (Ord('2') shl 24); Data2: 0000; Data3: 0010;
        Data4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_YV12: TGUID = (Data1: Ord('Y') or (Ord('V') shl 8) or (Ord('1') shl 16) or (Ord('2') shl 24); Data2: 0000; Data3: 0010;
        Data4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_I420: TGUID = (Data1: Ord('I') or (Ord('4') shl 8) or (Ord('2') shl 16) or (Ord('0') shl 24); Data2: 0000; Data3: 0010;
        Data4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_IYUV: TGUID = (Data1: Ord('I') or (Ord('Y') shl 8) or (Ord('U') shl 16) or (Ord('V') shl 24); Data2: 0000; Data3: 0010;
        Data4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_Y210: TGUID = (Data1: Ord('Y') or (Ord('2') shl 8) or (Ord('1') shl 16) or (Ord('0') shl 24); Data2: 0000; Data3: 0010;
        Data4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_Y216: TGUID = (Data1: Ord('Y') or (Ord('2') shl 8) or (Ord('1') shl 16) or (Ord('6') shl 24); Data2: 0000; Data3: 0010;
        Data4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_Y410: TGUID = (Data1: Ord('Y') or (Ord('4') shl 8) or (Ord('1') shl 16) or (Ord('0') shl 24); Data2: 0000; Data3: 0010;
        Data4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_Y416: TGUID = (Data1: Ord('Y') or (Ord('4') shl 8) or (Ord('1') shl 16) or (Ord('6') shl 24); Data2: 0000; Data3: 0010;
        Data4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_Y41P: TGUID = (Data1: Ord('Y') or (Ord('4') shl 8) or (Ord('1') shl 16) or (Ord('P') shl 24); Data2: 0000; Data3: 0010;
        Data4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_Y41T: TGUID = (Data1: Ord('Y') or (Ord('4') shl 8) or (Ord('1') shl 16) or (Ord('T') shl 24); Data2: 0000; Data3: 0010;
        Data4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_Y42T: TGUID = (Data1: Ord('Y') or (Ord('4') shl 8) or (Ord('2') shl 16) or (Ord('T') shl 24); Data2: 0000; Data3: 0010;
        Data4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_P210: TGUID = (Data1: Ord('P') or (Ord('2') shl 8) or (Ord('1') shl 16) or (Ord('0') shl 24); Data2: 0000; Data3: 0010;
        Data4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_P216: TGUID = (Data1: Ord('P') or (Ord('2') shl 8) or (Ord('1') shl 16) or (Ord('6') shl 24); Data2: 0000; Data3: 0010;
        Data4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_P010: TGUID = (Data1: Ord('P') or (Ord('0') shl 8) or (Ord('1') shl 16) or (Ord('0') shl 24); Data2: 0000; Data3: 0010;
        Data4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_P016: TGUID = (Data1: Ord('P') or (Ord('0') shl 8) or (Ord('1') shl 16) or (Ord('6') shl 24); Data2: 0000; Data3: 0010;
        Data4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_v210: TGUID = (Data1: Ord('v') or (Ord('2') shl 8) or (Ord('1') shl 16) or (Ord('0') shl 24); Data2: 0000; Data3: 0010;
        Data4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_v216: TGUID = (Data1: Ord('v') or (Ord('2') shl 8) or (Ord('1') shl 16) or (Ord('6') shl 24); Data2: 0000; Data3: 0010;
        Data4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_v410: TGUID = (Data1: Ord('v') or (Ord('4') shl 8) or (Ord('1') shl 16) or (Ord('0') shl 24); Data2: 0000; Data3: 0010;
        Data4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_MP43: TGUID = (Data1: Ord('M') or (Ord('P') shl 8) or (Ord('4') shl 16) or (Ord('3') shl 24); Data2: 0000; Data3: 0010;
        Data4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_MP4S: TGUID = (Data1: Ord('M') or (Ord('P') shl 8) or (Ord('4') shl 16) or (Ord('S') shl 24); Data2: 0000; Data3: 0010;
        Data4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_M4S2: TGUID = (Data1: Ord('M') or (Ord('4') shl 8) or (Ord('S') shl 16) or (Ord('2') shl 24); Data2: 0000; Data3: 0010;
        Data4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_MP4V: TGUID = (Data1: Ord('M') or (Ord('P') shl 8) or (Ord('4') shl 16) or (Ord('V') shl 24); Data2: 0000; Data3: 0010;
        Data4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_WMV1: TGUID = (Data1: Ord('W') or (Ord('M') shl 8) or (Ord('V') shl 16) or (Ord('1') shl 24); Data2: 0000; Data3: 0010;
        Data4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_WMV2: TGUID = (Data1: Ord('W') or (Ord('M') shl 8) or (Ord('V') shl 16) or (Ord('2') shl 24); Data2: 0000; Data3: 0010;
        Data4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_WMV3: TGUID = (Data1: Ord('W') or (Ord('M') shl 8) or (Ord('V') shl 16) or (Ord('3') shl 24); Data2: 0000; Data3: 0010;
        Data4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_WVC1: TGUID = (Data1: Ord('W') or (Ord('V') shl 8) or (Ord('C') shl 16) or (Ord('1') shl 24); Data2: 0000; Data3: 0010;
        Data4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_MSS1: TGUID = (Data1: Ord('M') or (Ord('S') shl 8) or (Ord('S') shl 16) or (Ord('1') shl 24); Data2: 0000; Data3: 0010;
        Data4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_MSS2: TGUID = (Data1: Ord('M') or (Ord('S') shl 8) or (Ord('S') shl 16) or (Ord('2') shl 24); Data2: 0000; Data3: 0010;
        Data4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_MPG1: TGUID = (Data1: Ord('M') or (Ord('P') shl 8) or (Ord('G') shl 16) or (Ord('1') shl 24); Data2: 0000; Data3: 0010;
        Data4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_DVSL: TGUID = (Data1: Ord('d') or (Ord('v') shl 8) or (Ord('s') shl 16) or (Ord('l') shl 24); Data2: 0000; Data3: 0010;
        Data4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_DVSD: TGUID = (Data1: Ord('d') or (Ord('v') shl 8) or (Ord('s') shl 16) or (Ord('d') shl 24); Data2: 0000; Data3: 0010;
        Data4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_DVHD: TGUID = (Data1: Ord('d') or (Ord('v') shl 8) or (Ord('h') shl 16) or (Ord('d') shl 24); Data2: 0000; Data3: 0010;
        Data4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_DV25: TGUID = (Data1: Ord('d') or (Ord('v') shl 8) or (Ord('2') shl 16) or (Ord('5') shl 24); Data2: 0000; Data3: 0010;
        Data4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_DV50: TGUID = (Data1: Ord('d') or (Ord('v') shl 8) or (Ord('5') shl 16) or (Ord('0') shl 24); Data2: 0000; Data3: 0010;
        Data4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_DVH1: TGUID = (Data1: Ord('d') or (Ord('v') shl 8) or (Ord('h') shl 16) or (Ord('1') shl 24); Data2: 0000; Data3: 0010;
        Data4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_DVC: TGUID = (Data1: Ord('d') or (Ord('v') shl 8) or (Ord('c') shl 16) or (Ord(' ') shl 24); Data2: 0000; Data3: 0010;
        Data4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_H264: TGUID = (Data1: Ord('H') or (Ord('2') shl 8) or (Ord('6') shl 16) or (Ord('4') shl 24);
        // assume MFVideoFormat_H264 is frame aligned. that is, each input sample has one complete compressed frame (one frame picture, two field pictures or a single unpaired field picture)
        Data2: 0000; Data3: 0010; Data4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_H265: TGUID = (Data1: Ord('H') or (Ord('2') shl 8) or (Ord('6') shl 16) or (Ord('5') shl 24); Data2: 0000; Data3: 0010;
        Data4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_MJPG: TGUID = (Data1: Ord('M') or (Ord('J') shl 8) or (Ord('P') shl 16) or (Ord('G') shl 24); Data2: 0000; Data3: 0010;
        Data4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_420O: TGUID = (Data1: Ord('4') or (Ord('2') shl 8) or (Ord('0') shl 16) or (Ord('O') shl 24); Data2: 0000; Data3: 0010;
        Data4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_HEVC: TGUID = (Data1: Ord('H') or (Ord('E') shl 8) or (Ord('V') shl 16) or (Ord('C') shl 24); Data2: 0000; Data3: 0010;
        Data4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_HEVC_ES: TGUID = (Data1: Ord('H') or (Ord('E') shl 8) or (Ord('V') shl 16) or (Ord('S') shl 24); Data2: 0000; Data3: 0010;
        Data4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_VP80: TGUID = (Data1: Ord('V') or (Ord('P') shl 8) or (Ord('8') shl 16) or (Ord('0') shl 24); Data2: 0000; Data3: 0010;
        Data4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_VP90: TGUID = (Data1: Ord('V') or (Ord('P') shl 8) or (Ord('9') shl 16) or (Ord('0') shl 24); Data2: 0000; Data3: 0010;
        Data4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_H263: TGUID = (Data1: Ord('H') or (Ord('2') shl 8) or (Ord('6') shl 16) or (Ord('3') shl 24); Data2: 0000; Data3: 0010;
        Data4: ($80, $00, $00, $AA, $00, $38, $9B, $71));


    // audio media types

    MFAudioFormat_Base: TGUID = (Data1: $00000000; Data2: 0000; Data3: 0010; Data4: ($80, $00, $00, $AA, $00, $38, $9B, $71));

    MFAudioFormat_PCM: TGUID = (Data1: WAVE_FORMAT_PCM; Data2: 0000; Data3: 0010; Data4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFAudioFormat_Float: TGUID = (Data1: WAVE_FORMAT_IEEE_FLOAT; Data2: 0000; Data3: 0010; Data4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFAudioFormat_DTS: TGUID = (Data1: WAVE_FORMAT_DTS; Data2: 0000; Data3: 0010; Data4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFAudioFormat_Dolby_AC3_SPDIF: TGUID = (Data1: WAVE_FORMAT_DOLBY_AC3_SPDIF; Data2: 0000; Data3: 0010; Data4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFAudioFormat_DRM: TGUID = (Data1: WAVE_FORMAT_DRM; Data2: 0000; Data3: 0010; Data4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFAudioFormat_WMAudioV8: TGUID = (Data1: WAVE_FORMAT_WMAUDIO2; Data2: 0000; Data3: 0010; Data4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFAudioFormat_WMAudioV9: TGUID = (Data1: WAVE_FORMAT_WMAUDIO3; Data2: 0000; Data3: 0010; Data4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFAudioFormat_WMAudio_Lossless: TGUID = (Data1: WAVE_FORMAT_WMAUDIO_LOSSLESS; Data2: 0000; Data3: 0010; Data4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFAudioFormat_WMASPDIF: TGUID = (Data1: WAVE_FORMAT_WMASPDIF; Data2: 0000; Data3: 0010; Data4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFAudioFormat_MSP1: TGUID = (Data1: WAVE_FORMAT_WMAVOICE9; Data2: 0000; Data3: 0010; Data4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFAudioFormat_MP3: TGUID = (Data1: WAVE_FORMAT_MPEGLAYER3; Data2: 0000; Data3: 0010; Data4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFAudioFormat_MPEG: TGUID = (Data1: WAVE_FORMAT_MPEG; Data2: 0000; Data3: 0010; Data4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFAudioFormat_AAC: TGUID = (Data1: WAVE_FORMAT_MPEG_HEAAC; Data2: 0000; Data3: 0010; Data4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFAudioFormat_ADTS: TGUID = (Data1: WAVE_FORMAT_MPEG_ADTS_AAC; Data2: 0000; Data3: 0010; Data4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFAudioFormat_AMR_NB: TGUID = (Data1: WAVE_FORMAT_AMR_NB; Data2: 0000; Data3: 0010; Data4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFAudioFormat_AMR_WB: TGUID = (Data1: WAVE_FORMAT_AMR_WB; Data2: 0000; Data3: 0010; Data4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFAudioFormat_AMR_WP: TGUID = (Data1: WAVE_FORMAT_AMR_WP; Data2: 0000; Data3: 0010; Data4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFAudioFormat_FLAC: TGUID = (Data1: WAVE_FORMAT_FLAC; Data2: 0000; Data3: 0010; Data4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFAudioFormat_ALAC: TGUID = (Data1: Ord('a') or (Ord('l') shl 8) or (Ord('a') shl 16) or (Ord('c') shl 24); Data2: 0000; Data3: 0010;
        Data4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
{$ELSE}
    MFVideoFormat_Base: TGUID = (D1: $00000000; D2: 0000; D3: 0010; D4: ($80, $00, $00, $AA, $00, $38, $9B, $71));

    MFVideoFormat_RGB32: TGUID = (D1: D3DFMT_X8R8G8B8; D2: 0000; D3: 0010; D4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_ARGB32: TGUID = (D1: D3DFMT_A8R8G8B8; D2: 0000; D3: 0010; D4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_RGB24: TGUID = (D1: D3DFMT_R8G8B8; D2: 0000; D3: 0010; D4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_RGB555: TGUID = (D1: D3DFMT_X1R5G5B5; D2: 0000; D3: 0010; D4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_RGB565: TGUID = (D1: D3DFMT_R5G6B5; D2: 0000; D3: 0010; D4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_RGB8: TGUID = (D1: D3DFMT_P8; D2: 0000; D3: 0010; D4: ($80, $00, $00, $AA, $00, $38, $9B, $71));

    MFVideoFormat_AI44: TGUID = (D1: Ord('A') or (Ord('I') shl 8) or (Ord('4') shl 16) or (Ord('4') shl 24); D2: 0000; D3: 0010;
        D4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_AYUV: TGUID = (D1: Ord('A') or (Ord('Y') shl 8) or (Ord('U') shl 16) or (Ord('V') shl 24); D2: 0000; D3: 0010;
        D4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_YUY2: TGUID = (D1: Ord('Y') or (Ord('U') shl 8) or (Ord('Y') shl 16) or (Ord('2') shl 24); D2: 0000; D3: 0010;
        D4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_YVYU: TGUID = (D1: Ord('Y') or (Ord('V') shl 8) or (Ord('Y') shl 16) or (Ord('U') shl 24); D2: 0000; D3: 0010;
        D4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_YVU9: TGUID = (D1: Ord('Y') or (Ord('V') shl 8) or (Ord('U') shl 16) or (Ord('9') shl 24); D2: 0000; D3: 0010;
        D4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_UYVY: TGUID = (D1: Ord('U') or (Ord('Y') shl 8) or (Ord('V') shl 16) or (Ord('Y') shl 24); D2: 0000; D3: 0010;
        D4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_NV11: TGUID = (D1: Ord('N') or (Ord('V') shl 8) or (Ord('1') shl 16) or (Ord('1') shl 24); D2: 0000; D3: 0010;
        D4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_NV12: TGUID = (D1: Ord('N') or (Ord('V') shl 8) or (Ord('1') shl 16) or (Ord('2') shl 24); D2: 0000; D3: 0010;
        D4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_YV12: TGUID = (D1: Ord('Y') or (Ord('V') shl 8) or (Ord('1') shl 16) or (Ord('2') shl 24); D2: 0000; D3: 0010;
        D4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_I420: TGUID = (D1: Ord('I') or (Ord('4') shl 8) or (Ord('2') shl 16) or (Ord('0') shl 24); D2: 0000; D3: 0010;
        D4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_IYUV: TGUID = (D1: Ord('I') or (Ord('Y') shl 8) or (Ord('U') shl 16) or (Ord('V') shl 24); D2: 0000; D3: 0010;
        D4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_Y210: TGUID = (D1: Ord('Y') or (Ord('2') shl 8) or (Ord('1') shl 16) or (Ord('0') shl 24); D2: 0000; D3: 0010;
        D4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_Y216: TGUID = (D1: Ord('Y') or (Ord('2') shl 8) or (Ord('1') shl 16) or (Ord('6') shl 24); D2: 0000; D3: 0010;
        D4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_Y410: TGUID = (D1: Ord('Y') or (Ord('4') shl 8) or (Ord('1') shl 16) or (Ord('0') shl 24); D2: 0000; D3: 0010;
        D4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_Y416: TGUID = (D1: Ord('Y') or (Ord('4') shl 8) or (Ord('1') shl 16) or (Ord('6') shl 24); D2: 0000; D3: 0010;
        D4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_Y41P: TGUID = (D1: Ord('Y') or (Ord('4') shl 8) or (Ord('1') shl 16) or (Ord('P') shl 24); D2: 0000; D3: 0010;
        D4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_Y41T: TGUID = (D1: Ord('Y') or (Ord('4') shl 8) or (Ord('1') shl 16) or (Ord('T') shl 24); D2: 0000; D3: 0010;
        D4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_Y42T: TGUID = (D1: Ord('Y') or (Ord('4') shl 8) or (Ord('2') shl 16) or (Ord('T') shl 24); D2: 0000; D3: 0010;
        D4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_P210: TGUID = (D1: Ord('P') or (Ord('2') shl 8) or (Ord('1') shl 16) or (Ord('0') shl 24); D2: 0000; D3: 0010;
        D4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_P216: TGUID = (D1: Ord('P') or (Ord('2') shl 8) or (Ord('1') shl 16) or (Ord('6') shl 24); D2: 0000; D3: 0010;
        D4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_P010: TGUID = (D1: Ord('P') or (Ord('0') shl 8) or (Ord('1') shl 16) or (Ord('0') shl 24); D2: 0000; D3: 0010;
        D4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_P016: TGUID = (D1: Ord('P') or (Ord('0') shl 8) or (Ord('1') shl 16) or (Ord('6') shl 24); D2: 0000; D3: 0010;
        D4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_v210: TGUID = (D1: Ord('v') or (Ord('2') shl 8) or (Ord('1') shl 16) or (Ord('0') shl 24); D2: 0000; D3: 0010;
        D4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_v216: TGUID = (D1: Ord('v') or (Ord('2') shl 8) or (Ord('1') shl 16) or (Ord('6') shl 24); D2: 0000; D3: 0010;
        D4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_v410: TGUID = (D1: Ord('v') or (Ord('4') shl 8) or (Ord('1') shl 16) or (Ord('0') shl 24); D2: 0000; D3: 0010;
        D4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_MP43: TGUID = (D1: Ord('M') or (Ord('P') shl 8) or (Ord('4') shl 16) or (Ord('3') shl 24); D2: 0000; D3: 0010;
        D4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_MP4S: TGUID = (D1: Ord('M') or (Ord('P') shl 8) or (Ord('4') shl 16) or (Ord('S') shl 24); D2: 0000; D3: 0010;
        D4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_M4S2: TGUID = (D1: Ord('M') or (Ord('4') shl 8) or (Ord('S') shl 16) or (Ord('2') shl 24); D2: 0000; D3: 0010;
        D4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_MP4V: TGUID = (D1: Ord('M') or (Ord('P') shl 8) or (Ord('4') shl 16) or (Ord('V') shl 24); D2: 0000; D3: 0010;
        D4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_WMV1: TGUID = (D1: Ord('W') or (Ord('M') shl 8) or (Ord('V') shl 16) or (Ord('1') shl 24); D2: 0000; D3: 0010;
        D4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_WMV2: TGUID = (D1: Ord('W') or (Ord('M') shl 8) or (Ord('V') shl 16) or (Ord('2') shl 24); D2: 0000; D3: 0010;
        D4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_WMV3: TGUID = (D1: Ord('W') or (Ord('M') shl 8) or (Ord('V') shl 16) or (Ord('3') shl 24); D2: 0000; D3: 0010;
        D4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_WVC1: TGUID = (D1: Ord('W') or (Ord('V') shl 8) or (Ord('C') shl 16) or (Ord('1') shl 24); D2: 0000; D3: 0010;
        D4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_MSS1: TGUID = (D1: Ord('M') or (Ord('S') shl 8) or (Ord('S') shl 16) or (Ord('1') shl 24); D2: 0000; D3: 0010;
        D4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_MSS2: TGUID = (D1: Ord('M') or (Ord('S') shl 8) or (Ord('S') shl 16) or (Ord('2') shl 24); D2: 0000; D3: 0010;
        D4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_MPG1: TGUID = (D1: Ord('M') or (Ord('P') shl 8) or (Ord('G') shl 16) or (Ord('1') shl 24); D2: 0000; D3: 0010;
        D4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_DVSL: TGUID = (D1: Ord('d') or (Ord('v') shl 8) or (Ord('s') shl 16) or (Ord('l') shl 24); D2: 0000; D3: 0010;
        D4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_DVSD: TGUID = (D1: Ord('d') or (Ord('v') shl 8) or (Ord('s') shl 16) or (Ord('d') shl 24); D2: 0000; D3: 0010;
        D4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_DVHD: TGUID = (D1: Ord('d') or (Ord('v') shl 8) or (Ord('h') shl 16) or (Ord('d') shl 24); D2: 0000; D3: 0010;
        D4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_DV25: TGUID = (D1: Ord('d') or (Ord('v') shl 8) or (Ord('2') shl 16) or (Ord('5') shl 24); D2: 0000; D3: 0010;
        D4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_DV50: TGUID = (D1: Ord('d') or (Ord('v') shl 8) or (Ord('5') shl 16) or (Ord('0') shl 24); D2: 0000; D3: 0010;
        D4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_DVH1: TGUID = (D1: Ord('d') or (Ord('v') shl 8) or (Ord('h') shl 16) or (Ord('1') shl 24); D2: 0000; D3: 0010;
        D4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_DVC: TGUID = (D1: Ord('d') or (Ord('v') shl 8) or (Ord('c') shl 16) or (Ord(' ') shl 24); D2: 0000; D3: 0010;
        D4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_H264: TGUID = (D1: Ord('H') or (Ord('2') shl 8) or (Ord('6') shl 16) or (Ord('4') shl 24);
        // assume MFVideoFormat_H264 is frame aligned. that is, each input sample has one complete compressed frame (one frame picture, two field pictures or a single unpaired field picture)
        D2: 0000; D3: 0010; D4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_H265: TGUID = (D1: Ord('H') or (Ord('2') shl 8) or (Ord('6') shl 16) or (Ord('5') shl 24); D2: 0000; D3: 0010;
        D4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_MJPG: TGUID = (D1: Ord('M') or (Ord('J') shl 8) or (Ord('P') shl 16) or (Ord('G') shl 24); D2: 0000; D3: 0010;
        D4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_420O: TGUID = (D1: Ord('4') or (Ord('2') shl 8) or (Ord('0') shl 16) or (Ord('O') shl 24); D2: 0000; D3: 0010;
        D4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_HEVC: TGUID = (D1: Ord('H') or (Ord('E') shl 8) or (Ord('V') shl 16) or (Ord('C') shl 24); D2: 0000; D3: 0010;
        D4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_HEVC_ES: TGUID = (D1: Ord('H') or (Ord('E') shl 8) or (Ord('V') shl 16) or (Ord('S') shl 24); D2: 0000; D3: 0010;
        D4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_VP80: TGUID = (D1: Ord('V') or (Ord('P') shl 8) or (Ord('8') shl 16) or (Ord('0') shl 24); D2: 0000; D3: 0010;
        D4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_VP90: TGUID = (D1: Ord('V') or (Ord('P') shl 8) or (Ord('9') shl 16) or (Ord('0') shl 24); D2: 0000; D3: 0010;
        D4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFVideoFormat_H263: TGUID = (D1: Ord('H') or (Ord('2') shl 8) or (Ord('6') shl 16) or (Ord('3') shl 24); D2: 0000; D3: 0010;
        D4: ($80, $00, $00, $AA, $00, $38, $9B, $71));


    // audio media types

    MFAudioFormat_Base: TGUID = (D1: $00000000; D2: 0000; D3: 0010; D4: ($80, $00, $00, $AA, $00, $38, $9B, $71));

    MFAudioFormat_PCM: TGUID = (D1: WAVE_FORMAT_PCM; D2: 0000; D3: 0010; D4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFAudioFormat_Float: TGUID = (D1: WAVE_FORMAT_IEEE_FLOAT; D2: 0000; D3: 0010; D4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFAudioFormat_DTS: TGUID = (D1: WAVE_FORMAT_DTS; D2: 0000; D3: 0010; D4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFAudioFormat_Dolby_AC3_SPDIF: TGUID = (D1: WAVE_FORMAT_DOLBY_AC3_SPDIF; D2: 0000; D3: 0010; D4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFAudioFormat_DRM: TGUID = (D1: WAVE_FORMAT_DRM; D2: 0000; D3: 0010; D4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFAudioFormat_WMAudioV8: TGUID = (D1: WAVE_FORMAT_WMAUDIO2; D2: 0000; D3: 0010; D4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFAudioFormat_WMAudioV9: TGUID = (D1: WAVE_FORMAT_WMAUDIO3; D2: 0000; D3: 0010; D4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFAudioFormat_WMAudio_Lossless: TGUID = (D1: WAVE_FORMAT_WMAUDIO_LOSSLESS; D2: 0000; D3: 0010; D4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFAudioFormat_WMASPDIF: TGUID = (D1: WAVE_FORMAT_WMASPDIF; D2: 0000; D3: 0010; D4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFAudioFormat_MSP1: TGUID = (D1: WAVE_FORMAT_WMAVOICE9; D2: 0000; D3: 0010; D4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFAudioFormat_MP3: TGUID = (D1: WAVE_FORMAT_MPEGLAYER3; D2: 0000; D3: 0010; D4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFAudioFormat_MPEG: TGUID = (D1: WAVE_FORMAT_MPEG; D2: 0000; D3: 0010; D4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFAudioFormat_AAC: TGUID = (D1: WAVE_FORMAT_MPEG_HEAAC; D2: 0000; D3: 0010; D4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFAudioFormat_ADTS: TGUID = (D1: WAVE_FORMAT_MPEG_ADTS_AAC; D2: 0000; D3: 0010; D4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFAudioFormat_AMR_NB: TGUID = (D1: WAVE_FORMAT_AMR_NB; D2: 0000; D3: 0010; D4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFAudioFormat_AMR_WB: TGUID = (D1: WAVE_FORMAT_AMR_WB; D2: 0000; D3: 0010; D4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFAudioFormat_AMR_WP: TGUID = (D1: WAVE_FORMAT_AMR_WP; D2: 0000; D3: 0010; D4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFAudioFormat_FLAC: TGUID = (D1: WAVE_FORMAT_FLAC; D2: 0000; D3: 0010; D4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
    MFAudioFormat_ALAC: TGUID = (D1: Ord('a') or (Ord('l') shl 8) or (Ord('a') shl 16) or (Ord('c') shl 24); D2: 0000; D3: 0010;
        D4: ($80, $00, $00, $AA, $00, $38, $9B, $71));
{$ENDIF}

    // assume MFVideoFormat_H264_ES may not be frame aligned. that is, each input sample may have one partial frame,
    // multiple frames, some frames plus some partial frame
    // or more general, N.M frames, N is the integer part and M is the fractional part.

    // {3F40F4F0-5622-4FF8-B6D8-A17A584BEE5E}       MFVideoFormat_H264_ES
    MFVideoFormat_H264_ES: TGUID = '{3f40f4f0-5622-4ff8-b6d8-a17a584bee5e}';


    // some legacy formats that don't fit the common pattern

    // {e06d8026-db46-11cf-b4d1-00805f6cbbea}       MFVideoFormat_MPEG2
    MFVideoFormat_MPEG2: TGUID = '{e06d8026-db46-11cf-b4d1-00805f6cbbea}';
    MFVideoFormat_MPG2: TGUID = '{e06d8026-db46-11cf-b4d1-00805f6cbbea}';

    // These audio types are not derived from an existing wFormatTag
    MFAudioFormat_Dolby_AC3: TGUID = '{e06d802c-db46-11cf-b4d1-0080056cbbea}'; // == MEDIASUBTYPE_DOLBY_AC3 defined in ksuuids.h
    MFAudioFormat_Dolby_DDPlus: TGUID = '{a7fb87af-2d02-42fb-a4d4-05cd93843bdd}'; // == MEDIASUBTYPE_DOLBY_DDPLUS defined in wmcodecdsp.h
    MFAudioFormat_Vorbis: TGUID = '{8D2FD10B-5841-4a6b-8905-588FEC1ADED9}'; // {8D2FD10B-5841-4a6b-8905-588FEC1ADED9}

    // LPCM audio with headers for encapsulation in an MPEG2 bitstream
    MFAudioFormat_LPCM: TGUID = '{e06d8032-db46-11cf-b4d1-00805f6cbbea}'; // == MEDIASUBTYPE_LPCM defined in ksmedia.h
    MFAudioFormat_PCM_HDCP: TGUID = '{a5e7ff01-8411-4acc-a865-5f4941288d80}';
    MFAudioFormat_Dolby_AC3_HDCP: TGUID = '{97663a80-8ffb-4445-a6ba-792d908f497f}';
    MFAudioFormat_AAC_HDCP: TGUID = '{419bce76-8b72-400f-adeb-84b57d63484d}';
    MFAudioFormat_ADTS_HDCP: TGUID = '{da4963a3-14d8-4dcf-92b7-193eb84363db}';
    MFAudioFormat_Base_HDCP: TGUID = '{3884b5bc-e277-43fd-983d-038aa8d9b605}';
    MFVideoFormat_H264_HDCP: TGUID = '{5d0ce9dd-9817-49da-bdfd-f5f5b98f18a6}';
    MFVideoFormat_Base_HDCP: TGUID = '{eac3b9d5-bd14-4237-8f1f-bab428e49312}';


    // MPEG-4 media types

    // {00000000-767a-494d-b478-f29d25dc9037}       MFMPEG4Format_Base
    MFMPEG4Format_Base: TGUID = '{00000000-767a-494d-b478-f29d25dc9037}';


    // Subtitle media types

    // {73E73992-9a10-4356-9557-7194E91E3E54}      MFSubtitleFormat_TTML
    MFSubtitleFormat_TTML: TGUID = '{73e73992-9a10-4356-9557-7194e91e3e54}';

    // {7FA7FAA3-FEAE-4E16-AEDF-36B9ACFBB099}      MFSubtitleFormat_ATSC
    MFSubtitleFormat_ATSC: TGUID = '{7fa7faa3-feae-4e16-aedf-36b9acfbb099}';

    // {C886D215-F485-40BB-8DB6-FADBC619A45D}      MFSubtitleFormat_WebVTT
    MFSubtitleFormat_WebVTT: TGUID = '{c886d215-f485-40bb-8db6-fadbc619a45d}';

    // {5E467F2E-77CA-4CA5-8391-D142ED4B76C8}      MFSubtitleFormat_SRT
    MFSubtitleFormat_SRT: TGUID = '{5e467f2e-77ca-4ca5-8391-d142ed4b76c8}';

    // {57176A1B-1A9E-4EEA-ABEF-C61760198AC4}      MFSubtitleFormat_SSA
    MFSubtitleFormat_SSA: TGUID = '{57176a1b-1a9e-4eea-abef-c61760198ac4}';

    // {1BB3D849-6614-4D80-8882-ED24AA82DA92}      MFSubtitleFormat_CustomUserData
    MFSubtitleFormat_CustomUserData: TGUID = '{1bb3d849-6614-4d80-8882-ed24aa82da92}';

    /// ////////////////////////////////////////////////////////////////////////////////////////////////////////////  Media Type Attributes GUIDs ////////////////////////////
    /// /////////////////////////////////////////////////////////////////////////////


    // GUIDs for IMFMediaType properties - prefix 'MF_MT_' - basic prop type in {},
    // with type to cast to in ().


    // core info for all types

    // {48eba18e-f8c9-4687-bf11-0a74c9f96a8f}   MF_MT_MAJOR_TYPE                {GUID}
    MF_MT_MAJOR_TYPE: TGUID = '{48eba18e-f8c9-4687-bf11-0a74c9f96a8f}';

    // {f7e34c9a-42e8-4714-b74b-cb29d72c35e5}   MF_MT_SUBTYPE                   {GUID}
    MF_MT_SUBTYPE: TGUID = '{f7e34c9a-42e8-4714-b74b-cb29d72c35e5}';

    // {c9173739-5e56-461c-b713-46fb995cb95f}   MF_MT_ALL_SAMPLES_INDEPENDENT   {UINT32 (BOOL)}
    MF_MT_ALL_SAMPLES_INDEPENDENT: TGUID = '{c9173739-5e56-461c-b713-46fb995cb95f}';

    // {b8ebefaf-b718-4e04-b0a9-116775e3321b}   MF_MT_FIXED_SIZE_SAMPLES        {UINT32 (BOOL)}
    MF_MT_FIXED_SIZE_SAMPLES: TGUID = '{b8ebefaf-b718-4e04-b0a9-116775e3321b}';

    // {3afd0cee-18f2-4ba5-a110-8bea502e1f92}   MF_MT_COMPRESSED                {UINT32 (BOOL)}
    MF_MT_COMPRESSED: TGUID = '{3afd0cee-18f2-4ba5-a110-8bea502e1f92}';


    // MF_MT_SAMPLE_SIZE is only valid if MF_MT_FIXED_SIZED_SAMPLES is TRUE

    // {dad3ab78-1990-408b-bce2-eba673dacc10}   MF_MT_SAMPLE_SIZE               {UINT32}
    MF_MT_SAMPLE_SIZE: TGUID = '{dad3ab78-1990-408b-bce2-eba673dacc10}';

    // 4d3f7b23-d02f-4e6c-9bee-e4bf2c6c695d     MF_MT_WRAPPED_TYPE              {Blob}
    MF_MT_WRAPPED_TYPE: TGUID = '{4d3f7b23-d02f-4e6c-9bee-e4bf2c6c695d}';


    // Media Type & Sample attributes for 3D Video

    // {CB5E88CF-7B5B-476b-85AA-1CA5AE187555}        MF_MT_VIDEO_3D                 {UINT32 (BOOL)}
    MF_MT_VIDEO_3D: TGUID = '{cb5e88cf-7b5b-476b-85aa-1ca5ae187555}';

    // {5315d8a0-87c5-4697-b793-666c67c49b}         MF_MT_VIDEO_3D_FORMAT           {UINT32 (anyof MFVideo3DFormat)}
    MF_MT_VIDEO_3D_FORMAT: TGUID = '{5315d8a0-87c5-4697-b793-6606c67c049b}';

    // {BB077E8A-DCBF-42eb-AF60-418DF98AA495}       MF_MT_VIDEO_3D_NUM_VIEW         {UINT32}
    MF_MT_VIDEO_3D_NUM_VIEWS: TGUID = '{bb077e8a-dcbf-42eb-af60-418df98aa495}';

    // {6D4B7BFF-5629-4404-948C-C634F4CE26D4}       MF_MT_VIDEO_3D_LEFT_IS_BASE     {UINT32}
    MF_MT_VIDEO_3D_LEFT_IS_BASE: TGUID = '{6d4b7bff-5629-4404-948c-c634f4ce26d4}';

    // {EC298493-0ADA-4ea1-A4FE-CBBD36CE9331}       MF_MT_VIDEO_3D_FIRST_IS_LEFT    {UINT32 (BOOL)}
    MF_MT_VIDEO_3D_FIRST_IS_LEFT: TGUID = '{ec298493-0ada-4ea1-a4fe-cbbd36ce9331}';

    // MFSampleExtension_3DVideo                    {F86F97A4-DD54-4e2e-9A5E-55FC2D74A005}
    // Type: UINT32
    // If present and nonzero, indicates that the sample contains 3D Video data
    MFSampleExtension_3DVideo: TGUID = '{f86f97a4-dd54-4e2e-9a5e-55fc2d74a005}';

    // MFSampleExtension_3DVideo_SampleFormat       {08671772-E36F-4cff-97B3-D72E20987A48}
    // Type: UINT32
    // The value of this attribute is a member of the MFVideo3DSampleFormat enumeration.
    // MFVideo3DSampleFormat enumeration identifies how 3D views are stored in the sample
    // - in a packed representation, all views are stored in a single buffer
    // - in a multiview representation, each view is stored in its own buffer
    MFSampleExtension_3DVideo_SampleFormat: TGUID = '{08671772-e36f-4cff-97b3-d72e20987a48}';

    // MF_MT_VIDEO_ROTATION      {C380465D-2271-428C-9B83-ECEA3B4A85C1}
    // Type: UINT32
    // Description: MF_MT_VIDEO_ROTATION attribute means the degree that the content
    // has already been rotated in the counter clockwise direction.
    // Currently, only the values of 0, 90, 180, and 270 are valid for MF_MT_VIDEO_ROTATION.
    // For convenience, these currently supported values are enumerated in MFVideoRotationFormat.
    // Example: if the media type has MF_MT_VIDEO_ROTATION set as MFVideoRotationFormat_90,
    // it means the content has been rotated 90 degree in the counter clockwise direction.
    // If the content was actually rotated 90 degree in the clockwise direction, 90 degree in
    // clockwise should be converted into 270 degree in the counter clockwise direction and set
    // the attribute MF_MT_VIDEO_ROTATION as MFVideoRotationFormat_270 accordingly.
    MF_MT_VIDEO_ROTATION: TGUID = '{c380465d-2271-428c-9b83-ecea3b4a85c1}';

    // MF_MT_SECURE     {c5acc4fd-0304-4ecf-809f-47bc97ff63bd }
    // Type: UINT32 (BOOL)
    // Description: MF_MT_SECURE attribute indicates that the content will be using
    // secure D3D surfaces.  These surfaces can only be accessed by trusted hardware.
    MF_MT_SECURE: TGUID = '{c5acc4fd-0304-4ecf-809f-47bc97ff63bd}';


    // MF_MT_VIDEO_NO_FRAME_ORDERING {3F5B106F-6BC2-4EE3-B7ED-8902C18F5351}
    // Type: UINT32
    // Description: MF_MT_VIDEO_NO_FRAME_ORDERING set to non-zero (true) means external users/apps know
    // that input video bitstream has no frame rerodering,
    // that is, the output and display order is the same as the input and decoding order
    // it will overwrite bitstream syntaxes even if bitstream syntaxes do not indicate
    // that the output and display order is the same as the input and decoding order

    // it is an attribute set on input media type

    MF_MT_VIDEO_NO_FRAME_ORDERING: TGUID = '{3f5b106f-6bc2-4ee3-b7ed-8902c18f5351}';


    // MF_MT_VIDEO_H264_NO_FMOASO {ED461CD6-EC9F-416A-A8A3-26D7D31018D7}
    // Type: UINT32
    // Description: MF_MT_VIDEO_H264_NO_FMOASO set to non-zero (true) means external users/apps know
    // that H.264 input video bitstream has no FMO/ASO enabled,
    // that is, even if the bitstream has baseline profile and constraint_set1_flag equal to 0,
    // the bitstream shall not have FMO/ASO
    // then H.264 decoder uses DXVA decoding and doesn't fall back to software decoding
    // it improves power consumption, memory usage, performance and user experiences
    // (without unnecessary glitches on low end devices)

    // it is an attribute set on input media type

    MF_MT_VIDEO_H264_NO_FMOASO: TGUID = '{ed461cd6-ec9f-416a-a8a3-26d7d31018d7}';


    // AUDIO data

    // {37e48bf5-645e-4c5b-89de-ada9e29b696a}   MF_MT_AUDIO_NUM_CHANNELS            {UINT32}
    MF_MT_AUDIO_NUM_CHANNELS: TGUID = '{37e48bf5-645e-4c5b-89de-ada9e29b696a}';

    // {5faeeae7-0290-4c31-9e8a-c534f68d9dba}   MF_MT_AUDIO_SAMPLES_PER_SECOND      {UINT32}
    MF_MT_AUDIO_SAMPLES_PER_SECOND: TGUID = '{5faeeae7-0290-4c31-9e8a-c534f68d9dba}';

    // {fb3b724a-cfb5-4319-aefe-6e42b2406132}   MF_MT_AUDIO_FLOAT_SAMPLES_PER_SECOND {double}
    MF_MT_AUDIO_FLOAT_SAMPLES_PER_SECOND: TGUID = '{fb3b724a-cfb5-4319-aefe-6e42b2406132}';

    // {1aab75c8-cfef-451c-ab95-ac034b8e1731}   MF_MT_AUDIO_AVG_BYTES_PER_SECOND    {UINT32}
    MF_MT_AUDIO_AVG_BYTES_PER_SECOND: TGUID = '{1aab75c8-cfef-451c-ab95-ac034b8e1731}';

    // {322de230-9eeb-43bd-ab7a-ff412251541d}   MF_MT_AUDIO_BLOCK_ALIGNMENT         {UINT32}
    MF_MT_AUDIO_BLOCK_ALIGNMENT: TGUID = '{322de230-9eeb-43bd-ab7a-ff412251541d}';

    // {f2deb57f-40fa-4764-aa33-ed4f2d1ff669}   MF_MT_AUDIO_BITS_PER_SAMPLE         {UINT32}
    MF_MT_AUDIO_BITS_PER_SAMPLE: TGUID = '{f2deb57f-40fa-4764-aa33-ed4f2d1ff669}';

    // {d9bf8d6a-9530-4b7c-9ddf-ff6fd58bbd06}   MF_MT_AUDIO_VALID_BITS_PER_SAMPLE   {UINT32}
    MF_MT_AUDIO_VALID_BITS_PER_SAMPLE: TGUID = '{d9bf8d6a-9530-4b7c-9ddf-ff6fd58bbd06}';

    // {aab15aac-e13a-4995-9222-501ea15c6877}   MF_MT_AUDIO_SAMPLES_PER_BLOCK       {UINT32}
    MF_MT_AUDIO_SAMPLES_PER_BLOCK: TGUID = '{aab15aac-e13a-4995-9222-501ea15c6877}';

    // {55fb5765-644a-4caf-8479-938983bb1588}`  MF_MT_AUDIO_CHANNEL_MASK            {UINT32}
    MF_MT_AUDIO_CHANNEL_MASK: TGUID = '{55fb5765-644a-4caf-8479-938983bb1588}';

    // {9d62927c-36be-4cf2-b5c4-a3926e3e8711}`  MF_MT_AUDIO_FOLDDOWN_MATRIX         {BLOB, MFFOLDDOWN_MATRIX}
    MF_MT_AUDIO_FOLDDOWN_MATRIX: TGUID = '{9d62927c-36be-4cf2-b5c4-a3926e3e8711}';

    // {$9d62927d-36be-4cf2-b5c4-a3926e3e8711}`  MF_MT_AUDIO_WMADRC_PEAKREF         {UINT32}
    MF_MT_AUDIO_WMADRC_PEAKREF: TGUID = '{9d62927d-36be-4cf2-b5c4-a3926e3e8711}';

    // {$9d62927e-36be-4cf2-b5c4-a3926e3e8711}`  MF_MT_AUDIO_WMADRC_PEAKTARGET        {UINT32}
    MF_MT_AUDIO_WMADRC_PEAKTARGET: TGUID = '{9d62927e-36be-4cf2-b5c4-a3926e3e8711}';

    // {$9d62927f-36be-4cf2-b5c4-a3926e3e8711}`  MF_MT_AUDIO_WMADRC_AVGREF         {UINT32}
    MF_MT_AUDIO_WMADRC_AVGREF: TGUID = '{9d62927f-36be-4cf2-b5c4-a3926e3e8711}';

    // {$9d629280-36be-4cf2-b5c4-a3926e3e8711}`  MF_MT_AUDIO_WMADRC_AVGTARGET      {UINT32}
    MF_MT_AUDIO_WMADRC_AVGTARGET: TGUID = '{9d629280-36be-4cf2-b5c4-a3926e3e8711}';


    // MF_MT_AUDIO_PREFER_WAVEFORMATEX tells the converter to prefer a plain WAVEFORMATEX rather than
    // a WAVEFORMATEXTENSIBLE when converting to a legacy type. It is set by the WAVEFORMATEX->IMFMediaType
    // conversion routines when the original format block is a non-extensible WAVEFORMATEX.

    // This preference can be overridden and does not guarantee that the type can be correctly expressed
    // by a non-extensible type.

    // {a901aaba-e037-458a-bdf6-545be2074042}   MF_MT_AUDIO_PREFER_WAVEFORMATEX     {UINT32 (BOOL)}
    MF_MT_AUDIO_PREFER_WAVEFORMATEX: TGUID = '{a901aaba-e037-458a-bdf6-545be2074042}';


    // AUDIO - AAC extra data

    // {BFBABE79-7434-4d1c-94F0-72A3B9E17188} MF_MT_AAC_PAYLOAD_TYPE       {UINT32}
    MF_MT_AAC_PAYLOAD_TYPE: TGUID = '{bfbabe79-7434-4d1c-94f0-72a3b9e17188}';

    // {7632F0E6-9538-4d61-ACDA-EA29C8C14456} MF_MT_AAC_AUDIO_PROFILE_LEVEL_INDICATION       {UINT32}
    MF_MT_AAC_AUDIO_PROFILE_LEVEL_INDICATION: TGUID = '{7632f0e6-9538-4d61-acda-ea29c8c14456}';


    // AUDIO - FLAC extra data

    // {8B81ADAE-4B5A-4D40-8022-F38D09CA3C5C} MF_MT_AUDIO_FLAC_MAX_BLOCK_SIZE       {UINT32}
    MF_MT_AUDIO_FLAC_MAX_BLOCK_SIZE: TGUID = '{8b81adae-4b5a-4d40-8022-f38d09ca3c5c}';


    // VIDEO core data

    // {1652c33d-d6b2-4012-b834-72030849a37d}   MF_MT_FRAME_SIZE                {UINT64 (HI32(Width),LO32(Height))}
    MF_MT_FRAME_SIZE: TGUID = '{1652c33d-d6b2-4012-b834-72030849a37d}';

    // {c459a2e8-3d2c-4e44-b132-fee5156c7bb0}   MF_MT_FRAME_RATE                {UINT64 (HI32(Numerator),LO32(Denominator))}
    MF_MT_FRAME_RATE: TGUID = '{c459a2e8-3d2c-4e44-b132-fee5156c7bb0}';

    // {c6376a1e-8d0a-4027-be45-6d9a0ad39bb6}   MF_MT_PIXEL_ASPECT_RATIO        {UINT64 (HI32(Numerator),LO32(Denominator))}
    MF_MT_PIXEL_ASPECT_RATIO: TGUID = '{c6376a1e-8d0a-4027-be45-6d9a0ad39bb6}';

    // {8772f323-355a-4cc7-bb78-6d61a048ae82}   MF_MT_DRM_FLAGS                 {UINT32 (anyof MFVideoDRMFlags)}
    MF_MT_DRM_FLAGS: TGUID = '{8772f323-355a-4cc7-bb78-6d61a048ae82}';

    // {24974215-1B7B-41e4-8625-AC469F2DEDAA}   MF_MT_TIMESTAMP_CAN_BE_DTS      {UINT32 (BOOL)}
    MF_MT_TIMESTAMP_CAN_BE_DTS: TGUID = '{24974215-1b7b-41e4-8625-ac469f2dedaa}';

    // {4d0e73e5-80ea-4354-a9d0-1176ceb028ea}   MF_MT_PAD_CONTROL_FLAGS         {UINT32 (oneof MFVideoPadFlags)}
    MF_MT_PAD_CONTROL_FLAGS: TGUID = '{4d0e73e5-80ea-4354-a9d0-1176ceb028ea}';

    // {68aca3cc-22d0-44e6-85f8-28167197fa38}   MF_MT_SOURCE_CONTENT_HINT       {UINT32 (oneof MFVideoSrcContentHintFlags)}
    MF_MT_SOURCE_CONTENT_HINT: TGUID = '{68aca3cc-22d0-44e6-85f8-28167197fa38}';

    // {65df2370-c773-4c33-aa64-843e068efb0c}   MF_MT_CHROMA_SITING             {UINT32 (anyof MFVideoChromaSubsampling)}
    MF_MT_VIDEO_CHROMA_SITING: TGUID = '{65df2370-c773-4c33-aa64-843e068efb0c}';

    // {e2724bb8-e676-4806-b4b2-a8d6efb44ccd}   MF_MT_INTERLACE_MODE            {UINT32 (oneof MFVideoInterlaceMode)}
    MF_MT_INTERLACE_MODE: TGUID = '{e2724bb8-e676-4806-b4b2-a8d6efb44ccd}';

    // {5fb0fce9-be5c-4935-a811-ec838f8eed93}   MF_MT_TRANSFER_FUNCTION         {UINT32 (oneof MFVideoTransferFunction)}
    MF_MT_TRANSFER_FUNCTION: TGUID = '{5fb0fce9-be5c-4935-a811-ec838f8eed93}';

    // {dbfbe4d7-0740-4ee0-8192-850ab0e21935}   MF_MT_VIDEO_PRIMARIES           {UINT32 (oneof MFVideoPrimaries)}
    MF_MT_VIDEO_PRIMARIES: TGUID = '{dbfbe4d7-0740-4ee0-8192-850ab0e21935}';

    // {47537213-8cfb-4722-aa34-fbc9e24d77b8}   MF_MT_CUSTOM_VIDEO_PRIMARIES    {BLOB (MT_CUSTOM_VIDEO_PRIMARIES)}
    MF_MT_CUSTOM_VIDEO_PRIMARIES: TGUID = '{47537213-8cfb-4722-aa34-fbc9e24d77b8}';

    // {3e23d450-2c75-4d25-a00e-b91670d12327}   MF_MT_YUV_MATRIX                {UINT32 (oneof MFVideoTransferMatrix)}
    MF_MT_YUV_MATRIX: TGUID = '{3e23d450-2c75-4d25-a00e-b91670d12327}';

    // {53a0529c-890b-4216-8bf9-599367ad6d20}   MF_MT_VIDEO_LIGHTING            {UINT32 (oneof MFVideoLighting)}
    MF_MT_VIDEO_LIGHTING: TGUID = '{53a0529c-890b-4216-8bf9-599367ad6d20}';

    // {c21b8ee5-b956-4071-8daf-325edf5cab11}   MF_MT_VIDEO_NOMINAL_RANGE       {UINT32 (oneof MFNominalRange)}
    MF_MT_VIDEO_NOMINAL_RANGE: TGUID = '{c21b8ee5-b956-4071-8daf-325edf5cab11}';

    // {66758743-7e5f-400d-980a-aa8596c85696}   MF_MT_GEOMETRIC_APERTURE        {BLOB (MFVideoArea)}
    MF_MT_GEOMETRIC_APERTURE: TGUID = '{66758743-7e5f-400d-980a-aa8596c85696}';

    // {d7388766-18fe-48c6-a177-ee894867c8c4}   MF_MT_MINIMUM_DISPLAY_APERTURE  {BLOB (MFVideoArea)}
    MF_MT_MINIMUM_DISPLAY_APERTURE: TGUID = '{d7388766-18fe-48c6-a177-ee894867c8c4}';

    // {79614dde-9187-48fb-b8c7-4d52689de649}   MF_MT_PAN_SCAN_APERTURE         {BLOB (MFVideoArea)}
    MF_MT_PAN_SCAN_APERTURE: TGUID = '{79614dde-9187-48fb-b8c7-4d52689de649}';

    // {4b7f6bc3-8b13-40b2-a993-abf630b8204e}   MF_MT_PAN_SCAN_ENABLED          {UINT32 (BOOL)}
    MF_MT_PAN_SCAN_ENABLED: TGUID = '{4b7f6bc3-8b13-40b2-a993-abf630b8204e}';

    // {20332624-fb0d-4d9e-bd0d-cbf6786c102e}   MF_MT_AVG_BITRATE               {UINT32}
    MF_MT_AVG_BITRATE: TGUID = '{20332624-fb0d-4d9e-bd0d-cbf6786c102e}';

    // {799cabd6-3508-4db4-a3c7-569cd533deb1}   MF_MT_AVG_BIT_ERROR_RATE        {UINT32}
    MF_MT_AVG_BIT_ERROR_RATE: TGUID = '{799cabd6-3508-4db4-a3c7-569cd533deb1}';

    // {c16eb52b-73a1-476f-8d62-839d6a020652}   MF_MT_MAX_KEYFRAME_SPACING      {UINT32}
    MF_MT_MAX_KEYFRAME_SPACING: TGUID = '{c16eb52b-73a1-476f-8d62-839d6a020652}';

    // {b6bc765f-4c3b-40a4-bd51-2535b66fe09d}   MF_MT_USER_DATA                 {BLOB}
    MF_MT_USER_DATA: TGUID = '{b6bc765f-4c3b-40a4-bd51-2535b66fe09d}';

    // {a505d3ac-f930-436e-8ede-93a509ce23b2} MF_MT_OUTPUT_BUFFER_NUM {UINT32}
    MF_MT_OUTPUT_BUFFER_NUM: TGUID = '{a505d3ac-f930-436e-8ede-93a509ce23b2}';


    // VIDEO - uncompressed format data

    // {644b4e48-1e02-4516-b0eb-c01ca9d49ac6}   MF_MT_DEFAULT_STRIDE            {UINT32 (INT32)} // in bytes
    MF_MT_DEFAULT_STRIDE: TGUID = '{644b4e48-1e02-4516-b0eb-c01ca9d49ac6}';

    // {6d283f42-9846-4410-afd9-654d503b1a54}   MF_MT_PALETTE                   {BLOB (array of MFPaletteEntry - usually 256)}
    MF_MT_PALETTE: TGUID = '{6d283f42-9846-4410-afd9-654d503b1a54}';


    // the following is only used for legacy data that was stuck at the end of the format block when the type
    // was converted from a VIDEOINFOHEADER or VIDEOINFOHEADER2 block in an AM_MEDIA_TYPE.

    // {73d1072d-1870-4174-a063-29ff4ff6c11e}
    MF_MT_AM_FORMAT_TYPE: TGUID = '{73d1072d-1870-4174-a063-29ff4ff6c11e}';


    // VIDEO - Generic compressed video extra data

    // {ad76a80b-2d5c-4e0b-b375-64e520137036}   MF_MT_VIDEO_PROFILE             {UINT32}    This is an alias of  MF_MT_MPEG2_PROFILE
    MF_MT_VIDEO_PROFILE: TGUID = '{ad76a80b-2d5c-4e0b-b375-64e520137036}';

    // {96f66574-11c5-4015-8666-bff516436da7}   MF_MT_VIDEO_LEVEL               {UINT32}    This is an alias of  MF_MT_MPEG2_LEVEL
    MF_MT_VIDEO_LEVEL: TGUID = '{96f66574-11c5-4015-8666-bff516436da7}';


    // VIDEO - MPEG1/2 extra data

    // {91f67885-4333-4280-97cd-bd5a6c03a06e}   MF_MT_MPEG_START_TIME_CODE      {UINT32}
    MF_MT_MPEG_START_TIME_CODE: TGUID = '{91f67885-4333-4280-97cd-bd5a6c03a06e}';

    // {ad76a80b-2d5c-4e0b-b375-64e520137036}   MF_MT_MPEG2_PROFILE             {UINT32 (oneof AM_MPEG2Profile)}
    MF_MT_MPEG2_PROFILE: TGUID = '{ad76a80b-2d5c-4e0b-b375-64e520137036}';

    // {96f66574-11c5-4015-8666-bff516436da7}   MF_MT_MPEG2_LEVEL               {UINT32 (oneof AM_MPEG2Level)}
    MF_MT_MPEG2_LEVEL: TGUID = '{96f66574-11c5-4015-8666-bff516436da7}';

    // {31e3991d-f701-4b2f-b426-8ae3bda9e04b}   MF_MT_MPEG2_FLAGS               {UINT32 (anyof AMMPEG2_xxx flags)}
    MF_MT_MPEG2_FLAGS: TGUID = '{31e3991d-f701-4b2f-b426-8ae3bda9e04b}';

    // {3c036de7-3ad0-4c9e-9216-ee6d6ac21cb3}   MF_MT_MPEG_SEQUENCE_HEADER      {BLOB}
    MF_MT_MPEG_SEQUENCE_HEADER: TGUID = '{3c036de7-3ad0-4c9e-9216-ee6d6ac21cb3}';

    // {A20AF9E8-928A-4B26-AAA9-F05C74CAC47C}   MF_MT_MPEG2_STANDARD            {UINT32 (0 for default MPEG2, 1  to use ATSC standard, 2 to use DVB standard, 3 to use ARIB standard)}
    MF_MT_MPEG2_STANDARD: TGUID = '{a20af9e8-928a-4b26-aaa9-f05c74cac47c}';

    // {5229BA10-E29D-4F80-A59C-DF4F180207D2}   MF_MT_MPEG2_TIMECODE            {UINT32 (0 for no timecode, 1 to append an 4 byte timecode to the front of each transport packet)}
    MF_MT_MPEG2_TIMECODE: TGUID = '{5229ba10-e29d-4f80-a59c-df4f180207d2}';

    // {825D55E4-4F12-4197-9EB3-59B6E4710F06}   MF_MT_MPEG2_CONTENT_PACKET      {UINT32 (0 for no content packet, 1 to append a 14 byte Content Packet header according to the ARIB specification to the beginning a transport packet at 200-1000 ms intervals.)}
    MF_MT_MPEG2_CONTENT_PACKET: TGUID = '{825d55e4-4f12-4197-9eb3-59b6e4710f06}';

    // {91a49eb5-1d20-4b42-ace8-804269bf95ed}   MF_MT_MPEG2_ONE_FRAME_PER_PACKET      {UINT32 (BOOL) -- 0 for default behavior of splitting large video frames into multiple PES packets, 1 for always putting a full frame inside a PES packet, even if that requires setting the PES packet size to undefined (0)}
    MF_MT_MPEG2_ONE_FRAME_PER_PACKET: TGUID = '{91a49eb5-1d20-4b42-ace8-804269bf95ed}';

    // {168f1b4a-3e91-450f-aea7-e4baeadae5ba} MF_MT_MPEG2_HDCP  {UINT32 (BOOL) -- 0 for default behavior of clear MPEG2 stream, 1 for adding the HDCP descriptor to the PMT
    MF_MT_MPEG2_HDCP: TGUID = '{168f1b4a-3e91-450f-aea7-e4baeadae5ba}';


    // VIDEO - H264 extra data

    // {F5929986-4C45-4FBB-BB49-6CC534D05B9B}  {UINT32, UVC 1.5 H.264 format descriptor: bMaxCodecConfigDelay}
    MF_MT_H264_MAX_CODEC_CONFIG_DELAY: TGUID = '{f5929986-4c45-4fbb-bb49-6cc534d05b9b}';

    // {C8BE1937-4D64-4549-8343-A8086C0BFDA5} {UINT32, UVC 1.5 H.264 format descriptor: bmSupportedSliceModes}
    MF_MT_H264_SUPPORTED_SLICE_MODES: TGUID = '{c8be1937-4d64-4549-8343-a8086c0bfda5}';

    // {89A52C01-F282-48D2-B522-22E6AE633199} {UINT32, UVC 1.5 H.264 format descriptor: bmSupportedSyncFrameTypes}
    MF_MT_H264_SUPPORTED_SYNC_FRAME_TYPES: TGUID = '{89a52c01-f282-48d2-b522-22e6ae633199}';

    // {E3854272-F715-4757-BA90-1B696C773457} {UINT32, UVC 1.5 H.264 format descriptor: bResolutionScaling}
    MF_MT_H264_RESOLUTION_SCALING: TGUID = '{e3854272-f715-4757-ba90-1b696c773457}';

    // {9EA2D63D-53F0-4A34-B94E-9DE49A078CB3} {UINT32, UVC 1.5 H.264 format descriptor: bSimulcastSupport}
    MF_MT_H264_SIMULCAST_SUPPORT: TGUID = '{9ea2d63d-53f0-4a34-b94e-9de49a078cb3}';

    // {6A8AC47E-519C-4F18-9BB3-7EEAAEA5594D} {UINT32, UVC 1.5 H.264 format descriptor: bmSupportedRateControlModes}
    MF_MT_H264_SUPPORTED_RATE_CONTROL_MODES: TGUID = '{6a8ac47e-519c-4f18-9bb3-7eeaaea5594d}';

    // {45256D30-7215-4576-9336-B0F1BCD59BB2}  {Blob of size 20 * sizeof(WORD), UVC 1.5 H.264 format descriptor: wMaxMBperSec*}
    MF_MT_H264_MAX_MB_PER_SEC: TGUID = '{45256d30-7215-4576-9336-b0f1bcd59bb2}';

    // {60B1A998-DC01-40CE-9736-ABA845A2DBDC}         {UINT32, UVC 1.5 H.264 frame descriptor: bmSupportedUsages}
    MF_MT_H264_SUPPORTED_USAGES: TGUID = '{60b1a998-dc01-40ce-9736-aba845a2dbdc}';

    // {BB3BD508-490A-11E0-99E4-1316DFD72085}         {UINT32, UVC 1.5 H.264 frame descriptor: bmCapabilities}
    MF_MT_H264_CAPABILITIES: TGUID = '{bb3bd508-490a-11e0-99e4-1316dfd72085}';

    // {F8993ABE-D937-4A8F-BBCA-6966FE9E1152}         {UINT32, UVC 1.5 H.264 frame descriptor: bmSVCCapabilities}
    MF_MT_H264_SVC_CAPABILITIES: TGUID = '{f8993abe-d937-4a8f-bbca-6966fe9e1152}';

    // {359CE3A5-AF00-49CA-A2F4-2AC94CA82B61}         {UINT32, UVC 1.5 H.264 Probe/Commit Control: bUsage}
    MF_MT_H264_USAGE: TGUID = '{359ce3a5-af00-49ca-a2f4-2ac94ca82b61}';

    // {705177D8-45CB-11E0-AC7D-B91CE0D72085}          {UINT32, UVC 1.5 H.264 Probe/Commit Control: bmRateControlModes}
    MF_MT_H264_RATE_CONTROL_MODES: TGUID = '{705177d8-45cb-11e0-ac7d-b91ce0d72085}';

    // {85E299B2-90E3-4FE8-B2F5-C067E0BFE57A}          {UINT64, UVC 1.5 H.264 Probe/Commit Control: bmLayoutPerStream}
    MF_MT_H264_LAYOUT_PER_STREAM: TGUID = '{85e299b2-90e3-4fe8-b2f5-c067e0bfe57a}';

    // According to Mpeg4 spec, SPS and PPS of H.264/HEVC codec could appear in sample data.
    // description box. Mpeg4 sink filters out the SPS and PPS NALU and do not support in band SPS and PPS NALU.
    // This attribute enables support for in band SPS and PPS to appear in the elementary stream.
    // HEVC will have in-band parameter set by default with MP4 recording for broad support.  H.264 will have out - of - band parameter set by default for historical reason.
    // {75DA5090-910B-4A03-896C-7B898FEEA5AF}
    MF_MT_IN_BAND_PARAMETER_SET: TGUID = '{75da5090-910b-4a03-896c-7b898feea5af}';


    // INTERLEAVED - DV extra data

    // {84bd5d88-0fb8-4ac8-be4b-a8848bef98f3}   MF_MT_DV_AAUX_SRC_PACK_0        {UINT32}
    MF_MT_DV_AAUX_SRC_PACK_0: TGUID = '{84bd5d88-0fb8-4ac8-be4b-a8848bef98f3}';

    // {f731004e-1dd1-4515-aabe-f0c06aa536ac}   MF_MT_DV_AAUX_CTRL_PACK_0       {UINT32}
    MF_MT_DV_AAUX_CTRL_PACK_0: TGUID = '{f731004e-1dd1-4515-aabe-f0c06aa536ac}';

    // {720e6544-0225-4003-a651-0196563a958e}   MF_MT_DV_AAUX_SRC_PACK_1        {UINT32}
    MF_MT_DV_AAUX_SRC_PACK_1: TGUID = '{720e6544-0225-4003-a651-0196563a958e}';

    // {cd1f470d-1f04-4fe0-bfb9-d07ae0386ad8}   MF_MT_DV_AAUX_CTRL_PACK_1       {UINT32}
    MF_MT_DV_AAUX_CTRL_PACK_1: TGUID = '{cd1f470d-1f04-4fe0-bfb9-d07ae0386ad8}';

    // {41402d9d-7b57-43c6-b129-2cb997f15009}   MF_MT_DV_VAUX_SRC_PACK          {UINT32}
    MF_MT_DV_VAUX_SRC_PACK: TGUID = '{41402d9d-7b57-43c6-b129-2cb997f15009}';

    // {2f84e1c4-0da1-4788-938e-0dfbfbb34b48}   MF_MT_DV_VAUX_CTRL_PACK         {UINT32}
    MF_MT_DV_VAUX_CTRL_PACK: TGUID = '{2f84e1c4-0da1-4788-938e-0dfbfbb34b48}';

    // {9E6BD6F5-0109-4f95-84AC-9309153A19FC}   MF_MT_ARBITRARY_HEADER          {MT_ARBITRARY_HEADER}
    MF_MT_ARBITRARY_HEADER: TGUID = '{9e6bd6f5-0109-4f95-84ac-9309153a19fc}';

    // {5A75B249-0D7D-49a1-A1C3-E0D87F0CADE5}   MF_MT_ARBITRARY_FORMAT          {Blob}
    MF_MT_ARBITRARY_FORMAT: TGUID = '{5a75b249-0d7d-49a1-a1c3-e0d87f0cade5}';


    // IMAGE

    // {ED062CF4-E34E-4922-BE99-934032133D7C}   MF_MT_IMAGE_LOSS_TOLERANT       {UINT32 (BOOL)}
    MF_MT_IMAGE_LOSS_TOLERANT: TGUID = '{ed062cf4-e34e-4922-be99-934032133d7c}';


    // MPEG-4 Media Type Attributes

    // {261E9D83-9529-4B8F-A111-8B9C950A81A9}   MF_MT_MPEG4_SAMPLE_DESCRIPTION   {BLOB}
    MF_MT_MPEG4_SAMPLE_DESCRIPTION: TGUID = '{261e9d83-9529-4b8f-a111-8b9c950a81a9}';

    // {9aa7e155-b64a-4c1d-a500-455d600b6560}   MF_MT_MPEG4_CURRENT_SAMPLE_ENTRY {UINT32}
    MF_MT_MPEG4_CURRENT_SAMPLE_ENTRY: TGUID = '{9aa7e155-b64a-4c1d-a500-455d600b6560}';


    // Save original format information for AVI and WAV files

    // {d7be3fe0-2bc7-492d-b843-61a1919b70c3}   MF_MT_ORIGINAL_4CC               (UINT32)
    MF_MT_ORIGINAL_4CC: TGUID = '{d7be3fe0-2bc7-492d-b843-61a1919b70c3}';

    // {8cbbc843-9fd9-49c2-882f-a72586c408ad}   MF_MT_ORIGINAL_WAVE_FORMAT_TAG   (UINT32)
    MF_MT_ORIGINAL_WAVE_FORMAT_TAG: TGUID = '{8cbbc843-9fd9-49c2-882f-a72586c408ad}';


    // Video Capture Media Type Attributes

    // {D2E7558C-DC1F-403f-9A72-D28BB1EB3B5E}   MF_MT_FRAME_RATE_RANGE_MIN      {UINT64 (HI32(Numerator),LO32(Denominator))}
    MF_MT_FRAME_RATE_RANGE_MIN: TGUID = '{d2e7558c-dc1f-403f-9a72-d28bb1eb3b5e}';

    // {E3371D41-B4CF-4a05-BD4E-20B88BB2C4D6}   MF_MT_FRAME_RATE_RANGE_MAX      {UINT64 (HI32(Numerator),LO32(Denominator))}
    MF_MT_FRAME_RATE_RANGE_MAX: TGUID = '{e3371d41-b4cf-4a05-bd4e-20b88bb2c4d6}';

    // {9C27891A-ED7A-40e1-88E8-B22727A024EE}   MF_LOW_LATENCY                  {UINT32 (BOOL)}
    // Same GUID as CODECAPI_AVLowLatencyMode
    MF_LOW_LATENCY: TGUID = '{9c27891a-ed7a-40e1-88e8-b22727a024ee}';

    // {E3F2E203-D445-4B8C-9211-AE390D3BA017}  {UINT32} Maximum macroblocks per second that can be handled by MFT
    MF_VIDEO_MAX_MB_PER_SEC: TGUID = '{e3f2e203-d445-4b8c-9211-ae390d3ba017}';

    // {7086E16C-49C5-4201-882A-8538F38CF13A} {UINT32 (BOOL)} Enables(0, default)/disables(1) the DXVA decode status queries in decoders. When disabled decoder won't provide MFSampleExtension_FrameCorruption
    MF_DISABLE_FRAME_CORRUPTION_INFO: TGUID = '{7086e16c-49c5-4201-882a-8538f38cf13a}';

    /// /////////////////////////////////////////////////////////////////////////////
    /// ////////////////////////////  Media Type GUIDs //////////////////////////////
    /// /////////////////////////////////////////////////////////////////////////////


    // Major types

    MFMediaType_Default: TGUID = '{81A412E6-8103-4B06-857F-1862781024AC}';
    MFMediaType_Audio: TGUID = '{73647561-0000-0010-8000-00AA00389B71}';
    MFMediaType_Video: TGUID = '{73646976-0000-0010-8000-00AA00389B71}';
    MFMediaType_Protected: TGUID = '{7b4b6fe6-9d04-4494-be14-7e0bd076c8e4}';
    MFMediaType_SAMI: TGUID = '{e69669a0-3dcd-40cb-9e2e-3708387c0616}';
    MFMediaType_Script: TGUID = '{72178C22-E45B-11D5-BC2A-00B0D0F3F4AB}';
    MFMediaType_Image: TGUID = '{72178C23-E45B-11D5-BC2A-00B0D0F3F4AB}';
    MFMediaType_HTML: TGUID = '{72178C24-E45B-11D5-BC2A-00B0D0F3F4AB}';
    MFMediaType_Binary: TGUID = '{72178C25-E45B-11D5-BC2A-00B0D0F3F4AB}';
    MFMediaType_FileTransfer: TGUID = '{72178C26-E45B-11D5-BC2A-00B0D0F3F4AB}';
    MFMediaType_Stream: TGUID = '{e436eb83-524f-11ce-9f53-0020af0ba770}';


    // Image subtypes (MFMediaType_Image major type)

    // JPEG subtype: same as GUID_ContainerFormatJpeg
    MFImageFormat_JPEG: TGUID = '{19e4a5aa-5662-4fc5-a0c0-1758028e1057}';

    // RGB32 subtype: same as MFVideoFormat_RGB32
    MFImageFormat_RGB32: TGUID = '{00000016-0000-0010-8000-00aa00389b71}';


    // MPEG2 Stream subtypes (MFMediaType_Stream major type)

    MFStreamFormat_MPEG2Transport: TGUID = '{e06d8023-db46-11cf-b4d1-00805f6cbbea}';
    MFStreamFormat_MPEG2Program: TGUID = '{263067d1-d330-45dc-b669-34d986e4e3e1}';

    // Representations

    AM_MEDIA_TYPE_REPRESENTATION: TGUID = '{e2e42ad2-132c-491e-a268-3c7c2dca181f}';
    FORMAT_MFVideoFormat: TGUID = '{aed4ab2d-7326-43cb-9464-c879cab9c43d}';

type

    // MF workitem functions

    TMFWORKITEM_KEY = UINT64;
    TMFPERIODICCALLBACK = function(pContext: IUnknown): Pointer;

    // MFASYNC_WORKQUEUE_TYPE: types of work queue used by MFAllocateWorkQueueEx

    TMFASYNC_WORKQUEUE_TYPE = (
        // MF_STANDARD_WORKQUEUE: Work queue in a thread without Window
        // message loop.
        MF_STANDARD_WORKQUEUE = 0,
        // MF_WINDOW_WORKQUEUE: Work queue in a thread running Window
        // Message loop that calls PeekMessage() / DispatchMessage()..
        MF_WINDOW_WORKQUEUE = 1, MF_MULTITHREADED_WORKQUEUE = 2 // common MT threadpool
      );

    // MFASYNCRESULT struct.
    // Any implementation of IMFAsyncResult must inherit from this struct;
    // the Media Foundation workqueue implementation depends on this.

    TtagMFASYNCRESULT = record
        AsyncResult: IMFAsyncResult;
        overlapped: TOVERLAPPED;
        pCallback: IMFAsyncCallback;
        hrStatusResult: HRESULT;
        dwBytesTransferred: DWORD;
        hEvent: THANDLE;
    end;

    TMFASYNCRESULT = TtagMFASYNCRESULT;

    // Possible values for MF_EVENT_TOPOLOGY_STATUS attribute.

    // For a given topology, these status values will arrive via
    // MESessionTopologyStatus in the order below.

    // However, there are no guarantees about how these status values will be
    // ordered between two consecutive topologies.  For example,
    // MF_TOPOSTATUS_READY could arrive for topology n+1 before
    // MF_TOPOSTATUS_ENDED arrives for topology n if the application called
    // IMFMediaSession::SetTopology for topology n+1 well enough in advance of the
    // end of topology n.  Conversely, if topology n ends before the application
    // calls IMFMediaSession::SetTopology for topology n+1, then
    // MF_TOPOSTATUS_ENDED will arrive for topology n before MF_TOPOSTATUS_READY
    // arrives for topology n+1.
    TMF_TOPOSTATUS = (
        // MF_TOPOSTATUS_INVALID: Invalid value; will not be sent
        MF_TOPOSTATUS_INVALID = 0,

        // MF_TOPOSTATUS_READY: The topology has been put in place and is
        // ready to start.  All GetService calls to the Media Session will use
        // this topology.
        MF_TOPOSTATUS_READY = 100,

        // MF_TOPOSTATUS_STARTED_SOURCE: The Media Session has started to read
        // and process data from the Media Source(s) in this topology.
        MF_TOPOSTATUS_STARTED_SOURCE = 200,

        // MF_TOPOSTATUS_DYNAMIC_CHANGED: The topology has been dynamic changed
        // due to the format change.
        MF_TOPOSTATUS_DYNAMIC_CHANGED = 210,

        // MF_TOPOSTATUS_SINK_SWITCHED: The Media Sinks in the pipeline have
        // switched from a previous topology to this topology.
        // Note that this status does not get sent for the first topology;
        // applications can assume that the sinks are playing the first
        // topology when they receive MESessionStarted.
        MF_TOPOSTATUS_SINK_SWITCHED = 300,

        // MF_TOPOSTATUS_ENDED: Playback of this topology is complete.
        // Before deleting this topology, however, the application should wait
        // for either MESessionEnded or the MF_TOPOSTATUS_STARTED_SOURCE status
        // on the next topology to ensure that the Media Session is no longer
        // using this topology.
        MF_TOPOSTATUS_ENDED = 400);

    TMOVE_RECT = record
        SourcePoint: TPOINT;
        DestRect: TRECT;
    end;

    PMOVE_RECT = ^TMOVE_RECT;

    TDIRTYRECT_INFO = record
        FrameNumber: UINT;
        NumDirtyRects: UINT;
        DirtyRects: PRECT;
    end;

    TMOVEREGION_INFO = record
        FrameNumber: UINT;
        NumMoveRegions: UINT;
        MoveRegions: PMOVE_RECT;
    end;

    TROI_AREA = record
        rect: TRECT;
        QPDelta: INT32;
    end;

    PROI_AREA = ^TROI_AREA;

    TtagFaceRectInfoBlobHeader = record
        Size: ULONG; // Size of this header + all FaceRectInfo following
        Count: ULONG; // Number of FaceRectInfo's in the blob
    end;

    TFaceRectInfoBlobHeader = TtagFaceRectInfoBlobHeader;

    TtagFaceRectInfo = record
        Region: TRECT; // Relative coordinates on the frame (Q31 format)
        confidenceLevel: LONG; // Confidence Level of the region being a face
    end;

    TFaceRectInfo = TtagFaceRectInfo;

    TtagFaceCharacterizationBlobHeader = record
        Size: ULONG; // Size of this header + all FaceCharacterization following
        Count: ULONG; // Number of FaceCharacterization's in the blob. Must match the number of FaceRectInfo's in FaceRectInfoBlobHeader
    end;

    TFaceCharacterizationBlobHeader = TtagFaceCharacterizationBlobHeader;

    TtagFaceCharacterization = record
        BlinkScoreLeft: ULONG; // [0, 100]. 0 indicates no blink for the left eye. 100 indicates definite blink for the left eye
        BlinkScoreRight: ULONG; // [0, 100]. 0 indicates no blink for the right eye. 100 indicates definite blink for the right eye
        FacialExpression: ULONG; // Any one of the MF_METADATAFACIALEXPRESSION_XXX defined
        FacialExpressionScore: ULONG;
        // [0, 100]. 0 indicates no such facial expression as identified. 100 indicates definite such facial expression as defined
    end;

    TFaceCharacterization = TtagFaceCharacterization;

    TtagCapturedMetadataExposureCompensation = record
        Flags: UINT64; // KSCAMERA_EXTENDEDPROP_EVCOMP_XXX step flag
        Value: INT32; // EV Compensation value in units of the step
    end;

    TCapturedMetadataExposureCompensation = TtagCapturedMetadataExposureCompensation;

    TtagCapturedMetadataISOGains = record
        AnalogGain: single;
        DigitalGain: single;
    end;

    TCapturedMetadataISOGains = TtagCapturedMetadataISOGains;

    TtagCapturedMetadataWhiteBalanceGains = record
        R: single;
        G: single;
        B: single;
    end;

    TCapturedMetadataWhiteBalanceGains = TtagCapturedMetadataWhiteBalanceGains;

    TtagMetadataTimeStamps = record
        Flags: ULONG; // Bitwise OR of MF_METADATATIMESTAMPS_XXX flags
        Device: LONGLONG; // QPC time for the sample where the metadata is derived from (in 100ns)
        Presentation: LONGLONG; // PTS for the sample where the metadata is derived from (in 100ns)
    end;

    TMetadataTimeStamps = TtagMetadataTimeStamps;

    TtagHistogramGrid = record
        Width: ULONG; // Width of the sensor output that histogram is collected from
        Height: ULONG; // Height of the sensor output that histogram is collected from

        Region: TRECT; // Absolute coordinates of the region on the sensor output that the histogram is collected for
    end;

    THistogramGrid = TtagHistogramGrid;

    TtagHistogramBlobHeader = record
        Size: ULONG; // Size of the entire histogram blob in bytes
        Histograms: ULONG; // Number of histograms in the blob. Each histogram is identified by a HistogramHeader
    end;

    THistogramBlobHeader = TtagHistogramBlobHeader;

    TtagHistogramHeader = record
        Size: ULONG; // Size in bytes of this header + (HistogramDataHeader + histogram data following)*number of channels available
        Bins: ULONG; // Number of bins in the histogram
        FourCC: ULONG; // Color space that the histogram is collected from
        ChannelMasks: ULONG; // Masks of the color channels that the histogram is collected for
        Grid: THistogramGrid; // Grid that the histogram is collected from
    end;

    THistogramHeader = TtagHistogramHeader;

    TtagHistogramDataHeader = record
        Size: ULONG; // Size in bytes of this header + histogram data following
        ChannelMask: ULONG; // Mask of the color channel for the histogram data
        Linear: ULONG; // 1, if linear; 0 nonlinear
    end;

    THistogramDataHeader = TtagHistogramDataHeader;

    TMFT_ENUM_FLAG = (MFT_ENUM_FLAG_SYNCMFT = $00000001, // Enumerates V1 MFTs. This is default.
        MFT_ENUM_FLAG_ASYNCMFT = $00000002, // Enumerates only software async MFTs also known as V2 MFTs
        MFT_ENUM_FLAG_HARDWARE = $00000004, // Enumerates V2 hardware async MFTs
        MFT_ENUM_FLAG_FIELDOFUSE = $00000008, // Enumerates MFTs that require unlocking
        MFT_ENUM_FLAG_LOCALMFT = $00000010, // Enumerates Locally (in-process) registered MFTs
        MFT_ENUM_FLAG_TRANSCODE_ONLY = $00000020, // Enumerates decoder MFTs used by transcode only
        MFT_ENUM_FLAG_SORTANDFILTER = $00000040, // Apply system local, do not use and preferred sorting and filtering
        MFT_ENUM_FLAG_SORTANDFILTER_APPROVED_ONLY = $000000C0,
        // Similar to MFT_ENUM_FLAG_SORTANDFILTER, but apply a local policy of: MF_PLUGIN_CONTROL_POLICY_USE_APPROVED_PLUGINS
        MFT_ENUM_FLAG_SORTANDFILTER_WEB_ONLY = $00000140,
        // Similar to MFT_ENUM_FLAG_SORTANDFILTER, but apply a local policy of: MF_PLUGIN_CONTROL_POLICY_USE_WEB_PLUGINS
        MFT_ENUM_FLAG_SORTANDFILTER_WEB_ONLY_EDGEMODE = $00000240,
        // Similar to MFT_ENUM_FLAG_SORTANDFILTER, but apply a local policy of: MF_PLUGIN_CONTROL_POLICY_USE_WEB_PLUGINS_EDGEMODE
        MFT_ENUM_FLAG_ALL = $0000003F // Enumerates all MFTs including SW and HW MFTs and applies filtering
      );

    // Enum describing the packing for 3D video frames
    TMFVideo3DFormat = (MFVideo3DSampleFormat_BaseView = 0, MFVideo3DSampleFormat_MultiView = 1, MFVideo3DSampleFormat_Packed_LeftRight = 2,
        MFVideo3DSampleFormat_Packed_TopBottom = 3);

    // Enum describing the packing for 3D video frames in a sample
    TMFVideo3DSampleFormat = (MFSampleExtension_3DVideo_MultiView = 1, MFSampleExtension_3DVideo_Packed = 0);

    // Enum describing the video rotation formats
    // Only the values of 0, 90, 180, and 270 are valid.
    TMFVideoRotationFormat = (MFVideoRotationFormat_0 = 0, MFVideoRotationFormat_90 = 90, MFVideoRotationFormat_180 = 180, MFVideoRotationFormat_270 = 270);


    // MF_MT_AUDIO_FOLDDOWN_MATRIX stores folddown structure from multichannel to stereo

    TMFFOLDDOWN_MATRIX = record
        cbSize: UINT32;
        cSrcChannels: UINT32; // number of source channels
        cDstChannels: UINT32; // number of destination channels
        dwChannelMask: UINT32; // mask
        Coeff: array [0 .. 63] of LONG;
    end;

    TMFVideoDRMFlags = (MFVideoDRMFlag_None = 0, MFVideoDRMFlag_AnalogProtected = 1, MFVideoDRMFlag_DigitallyProtected = 2);

    TMFVideoPadFlags = (MFVideoPadFlag_PAD_TO_None = 0, MFVideoPadFlag_PAD_TO_4x3 = 1, MFVideoPadFlag_PAD_TO_16x9 = 2);
    TMFVideoSrcContentHintFlags = (MFVideoSrcContentHintFlag_None = 0, MFVideoSrcContentHintFlag_16x9 = 1, MFVideoSrcContentHintFlag_235_1 = 2);

    TMT_CUSTOM_VIDEO_PRIMARIES = record
        fRx: single;
        fRy: single;
        fGx: single;
        fGy: single;
        fBx: single;
        fBy: single;
        fWx: single;
        fWy: single;
    end;

    // MT_ARBITRARY_HEADER stores information about the format of an arbitrary media type

    TMT_ARBITRARY_HEADER = record
        majortype: TGUID;
        subtype: TGUID;
        bFixedSizeSamples: boolean;
        bTemporalCompression: boolean;
        lSampleSize: ULONG;
        formattype: TGUID;
    end;


    // Heap alloc/free

    TEAllocationType = (eAllocationTypeDynamic, eAllocationTypeRT, eAllocationTypePageable, eAllocationTypeIgnore);


    // Forward declaration

    { TVIDEOINFOHEADER = TtagVIDEOINFOHEADER;

      TVIDEOINFOHEADER2 = TtagVIDEOINFOHEADER2;

      TMPEG1VIDEOINFO = TtagMPEG1VIDEOINFO;

      TMPEG2VIDEOINFO = TtagMPEG2VIDEOINFO; }

    // from strmif.h
    TAMMediaType = record

        majortype: TGUID;
        subtype: TGUID;
        bFixedSizeSamples: boolean;
        bTemporalCompression: boolean;
        lSampleSize: ULONG;
        formattype: TGUID;
        pUnk: IUnknown;
        cbFormat: ULONG;
        pbFormat: PBYTE;
    end;

    TAM_MEDIA_TYPE = TAMMediaType;

    PAM_MEDIA_TYPE = ^TAM_MEDIA_TYPE;

    TMFWaveFormatExConvertFlags = (MFWaveFormatExConvertFlag_Normal = 0, MFWaveFormatExConvertFlag_ForceExtensible = 1);


    { DLL Functions }

    /// /////////////////////////////////////////////////////////////////////////////
    /// ////////////////////////////   Startup/Shutdown  ////////////////////////////
    /// /////////////////////////////////////////////////////////////////////////////


    // Initializes the platform object.
    // Must be called before using Media Foundation.
    // A matching MFShutdown call must be made when the application is done using
    // Media Foundation.
    // The "Version" parameter should be set to MF_API_VERSION.
    // Application should not call MFStartup / MFShutdown from workqueue threads

function MFStartup(Version: ULONG; dwFlags: DWORD = MFSTARTUP_FULL): HRESULT; stdcall; external MFPlat_DLL;
{ function MFStartup(Version: ULONG; dwFlags: DWORD): HResult;
  stdcall; external MFPlat_DLL; }


// Shuts down the platform object.
// Releases all resources including threads.
// Application should call MFShutdown the same number of times as MFStartup
// Application should not call MFStartup / MFShutdown from workqueue threads

function MFShutdown(): HRESULT; stdcall; external MFPlat_DLL;

/// /////////////////////////////////////////////////////////////////////////////
/// //////////////////////////////    Platform    ///////////////////////////////
/// /////////////////////////////////////////////////////////////////////////////


// These functions can be used to keep the MF platform object in place.
// Every call to MFLockPlatform should have a matching call to MFUnlockPlatform

function MFLockPlatform(): HRESULT; stdcall; external MFPlat_DLL;
function MFUnlockPlatform(): HRESULT; stdcall; external MFPlat_DLL;

/// ////////////////////////////////////////////////////////////////////////////

function MFPutWorkItem(dwQueue: DWORD; pCallback: IMFAsyncCallback; pState: IUnknown): HRESULT; stdcall; external MFPlat_DLL;

function MFPutWorkItem2(dwQueue: DWORD; Priority: LONG; pCallback: IMFAsyncCallback; pState: IUnknown): HRESULT; stdcall; external MFPlat_DLL;

function MFPutWorkItemEx(dwQueue: DWORD; pResult: IMFAsyncResult): HRESULT; stdcall; external MFPlat_DLL;

function MFPutWorkItemEx2(dwQueue: DWORD; Priority: LONG; pResult: IMFAsyncResult): HRESULT; stdcall; external MFPlat_DLL;

function MFPutWaitingWorkItem(hEvent: THANDLE; Priority: LONG; pResult: IMFAsyncResult; out pKey: TMFWORKITEM_KEY): HRESULT; stdcall; external MFPlat_DLL;

function MFAllocateSerialWorkQueue(dwWorkQueue: DWORD; OUT pdwWorkQueue: DWORD): HRESULT; stdcall; external MFPlat_DLL;

function MFScheduleWorkItem(pCallback: IMFAsyncCallback; pState: IUnknown; Timeout: int64; out pKey: TMFWORKITEM_KEY): HRESULT; stdcall; external MFPlat_DLL;

function MFScheduleWorkItemEx(pResult: IMFAsyncResult; Timeout: int64; out pKey: TMFWORKITEM_KEY): HRESULT; stdcall; external MFPlat_DLL;


// The CancelWorkItem method is used by objects to cancel scheduled operation
// Due to asynchronous nature of timers, application might still get a
// timer callback after MFCancelWorkItem has returned.

function MFCancelWorkItem(Key: TMFWORKITEM_KEY): HRESULT; stdcall; external MFPlat_DLL;

/// ////////////////////////////////////////////////////////////////////////////


// MF periodic callbacks

function MFGetTimerPeriodicity(out Periodicity: DWORD): HRESULT; stdcall; external MFPlat_DLL;

function MFAddPeriodicCallback(Callback: TMFPERIODICCALLBACK; pContext: IUnknown; out pdwKey: DWORD): HRESULT; stdcall; external MFPlat_DLL;

function MFRemovePeriodicCallback(dwKey: DWORD): HRESULT; stdcall; external MFPlat_DLL;

/// ////////////////////////////////////////////////////////////////////////////


// MF work queues

function MFAllocateWorkQueueEx(WorkQueueType: TMFASYNC_WORKQUEUE_TYPE; OUT pdwWorkQueue: DWORD): HRESULT; stdcall; external MFPlat_DLL;


// Allocate a standard work queue. the behaviour is the same with:
// MFAllocateWorkQueueEx( MF_STANDARD_WORKQUEUE, pdwWorkQueue )

function MFAllocateWorkQueue(OUT pdwWorkQueue: DWORD): HRESULT; stdcall; external MFPlat_DLL;

function MFLockWorkQueue(dwWorkQueue: DWORD): HRESULT; stdcall; external MFPlat_DLL;

function MFUnlockWorkQueue(dwWorkQueue: DWORD): HRESULT; stdcall; external MFPlat_DLL;

function MFBeginRegisterWorkQueueWithMMCSS(dwWorkQueueId: DWORD; wszClass: LPCWSTR; dwTaskId: DWORD; pDoneCallback: IMFAsyncCallback;
    pDoneState: IUnknown): HRESULT; stdcall; external MFPlat_DLL;

function MFBeginRegisterWorkQueueWithMMCSSEx(dwWorkQueueId: DWORD; wszClass: LPCWSTR; dwTaskId: DWORD; lPriority: LONG; pDoneCallback: IMFAsyncCallback;
    pDoneState: IUnknown): HRESULT; stdcall; external MFPlat_DLL;

function MFEndRegisterWorkQueueWithMMCSS(pResult: IMFAsyncResult; out pdwTaskId: DWORD): HRESULT; stdcall; external MFPlat_DLL;

function MFBeginUnregisterWorkQueueWithMMCSS(dwWorkQueueId: DWORD; pDoneCallback: IMFAsyncCallback; pDoneState: IUnknown): HRESULT; stdcall;
external MFPlat_DLL;

function MFEndUnregisterWorkQueueWithMMCSS(pResult: IMFAsyncResult): HRESULT; stdcall; external MFPlat_DLL;

function MFGetWorkQueueMMCSSClass(dwWorkQueueId: DWORD; out pwszClass: LPWSTR; var pcchClass: DWORD): HRESULT; stdcall; external MFPlat_DLL;

function MFGetWorkQueueMMCSSTaskId(dwWorkQueueId: DWORD; out pdwTaskId: LPDWORD): HRESULT; stdcall; external MFPlat_DLL;

function MFRegisterPlatformWithMMCSS(wszClass: PWideChar; var pdwTaskId: DWORD; lPriority: LONG): HRESULT; stdcall; external MFPlat_DLL;

function MFUnregisterPlatformFromMMCSS(): HRESULT; stdcall; external MFPlat_DLL;

function MFLockSharedWorkQueue(wszClass: PWideChar; BasePriority: LONG; var pdwTaskId: DWORD; out pID: DWORD): HRESULT; stdcall; external MFPlat_DLL;

function MFGetWorkQueueMMCSSPriority(dwWorkQueueId: DWORD; out lPriority: LONG): HRESULT; stdcall; external MFPlat_DLL;

/// ////////////////////////////////////////////////////////////////////////////
/// //////////////////////////////    Async Model //////////////////////////////
/// ////////////////////////////////////////////////////////////////////////////


// Instantiates the MF-provided Async Result implementation

function MFCreateAsyncResult(punkObject: IUnknown; pCallback: IMFAsyncCallback; punkState: IUnknown; out ppAsyncResult: IMFAsyncResult): HRESULT; stdcall;
external MFPlat_DLL;


// Helper for calling IMFAsyncCallback::Invoke

function MFInvokeCallback(pAsyncResult: IMFAsyncResult): HRESULT; stdcall; external MFPlat_DLL;

/// ////////////////////////////////////////////////////////////////////////////
/// //////////////////////////////    Files       //////////////////////////////
/// ////////////////////////////////////////////////////////////////////////////


// Regardless of the access mode with which the file is opened, the sharing
// permissions will allow shared reading and deleting.

function MFCreateFile(AccessMode: TMF_FILE_ACCESSMODE; OpenMode: TMF_FILE_OPENMODE; fFlags: TMF_FILE_FLAGS; pwszFileURL: LPCWSTR;
    out ppIByteStream: IMFByteStream): HRESULT; stdcall; external MFPlat_DLL;

function MFCreateTempFile(AccessMode: TMF_FILE_ACCESSMODE; OpenMode: TMF_FILE_OPENMODE; fFlags: TMF_FILE_FLAGS; out ppIByteStream: IMFByteStream): HRESULT;
  stdcall; external MFPlat_DLL;

function MFBeginCreateFile(AccessMode: TMF_FILE_ACCESSMODE; OpenMode: TMF_FILE_OPENMODE; fFlags: TMF_FILE_FLAGS; pwszFilePath: LPCWSTR;
    pCallback: IMFAsyncCallback; pState: IUnknown; out ppCancelCookie: IUnknown): HRESULT; stdcall; external MFPlat_DLL;

function MFEndCreateFile(pResult: IMFAsyncResult; out ppFile: IMFByteStream): HRESULT; stdcall; external MFPlat_DLL;

function MFCancelCreateFile(pCancelCookie: IUnknown): HRESULT; stdcall; external MFPlat_DLL;

/// ////////////////////////////////////////////////////////////////////////////
/// //////////////////////////////    Buffers     //////////////////////////////
/// ////////////////////////////////////////////////////////////////////////////


// Creates an IMFMediaBuffer in memory

function MFCreateMemoryBuffer(cbMaxLength: DWORD; out ppBuffer: IMFMediaBuffer): HRESULT; stdcall; external MFPlat_DLL;


// Creates an IMFMediaBuffer wrapper at the given offset and length
// within an existing IMFMediaBuffer

function MFCreateMediaBufferWrapper(pBuffer: IMFMediaBuffer; cbOffset: DWORD; dwLength: DWORD; out ppBuffer: IMFMediaBuffer): HRESULT; stdcall;
external MFPlat_DLL;


// Creates a legacy buffer (IMediaBuffer) wrapper at the given offset within
// an existing IMFMediaBuffer.
// pSample is optional.  It can point to the original IMFSample from which this
// IMFMediaBuffer came.  If provided, then *ppMediaBuffer will succeed
// QueryInterface for IID_IMFSample, from which the original sample's attributes
// can be obtained

function MFCreateLegacyMediaBufferOnMFMediaBuffer(pSample: IMFSample; pMFMediaBuffer: IMFMediaBuffer; cbOffset: DWORD;
    out ppMediaBuffer: IMediaBuffer): HRESULT; stdcall; external MFPlat_DLL;


// Create a DirectX surface buffer

// include <dxgiformat.h>

function MFMapDX9FormatToDXGIFormat(dx9: DWORD): TDXGI_FORMAT; stdcall; external MFPlat_DLL;
function MFMapDXGIFormatToDX9Format(dx11: TDXGI_FORMAT): DWORD; stdcall; external MFPlat_DLL;

function MFLockDXGIDeviceManager(out pResetToken: UINT; out ppManager: IMFDXGIDeviceManager): HRESULT; stdcall; external MFPlat_DLL;

function MFUnlockDXGIDeviceManager(): HRESULT; stdcall; external MFPlat_DLL;

function MFCreateDXSurfaceBuffer(const riid: TGUID; punkSurface: IUnknown; fBottomUpWhenLinear: boolean; out ppBuffer: IMFMediaBuffer): HRESULT; stdcall;
external EVR_DLL;

function MFCreateWICBitmapBuffer(const riid: TGUID; punkSurface: IUnknown; out ppBuffer: IMFMediaBuffer): HRESULT; stdcall; external MFPlat_DLL;

function MFCreateDXGISurfaceBuffer(const riid: TGUID; punkSurface: IUnknown; uSubresourceIndex: UINT; fBottomUpWhenLinear: boolean;
    out ppBuffer: IMFMediaBuffer): HRESULT; stdcall; external MFPlat_DLL;

function MFCreateVideoSampleAllocatorEx(const riid: TGUID; out ppSampleAllocator): HRESULT; stdcall; external MFPlat_DLL;

function MFCreateDXGIDeviceManager(out resetToken: UINT; out ppDeviceManager: IMFDXGIDeviceManager): HRESULT; stdcall; external MFPlat_DLL;

function MFCreateAlignedMemoryBuffer(cbMaxLength: DWORD; cbAligment: DWORD; out ppBuffer: IMFMediaBuffer): HRESULT; stdcall; external MFPlat_DLL;


// Instantiates the MF-provided Media Event implementation.

function MFCreateMediaEvent(met: TMediaEventType; const guidExtendedType: TGUID; hrStatus: HRESULT; const pvValue: PROPVARIANT;
    out ppEvent: IMFMediaEvent): HRESULT; stdcall; external MFPlat_DLL;


// Instantiates an object that implements IMFMediaEventQueue.
// Components that provide an IMFMediaEventGenerator can use this object
// internally to do their Media Event Generator work for them.
// IMFMediaEventGenerator calls should be forwarded to the similar call
// on this object's IMFMediaEventQueue interface (e.g. BeginGetEvent,
// EndGetEvent), and the various IMFMediaEventQueue::QueueEventXXX methods
// can be used to queue events that the caller will consume.

function MFCreateEventQueue(out ppMediaEventQueue: IMFMediaEventQueue): HRESULT; stdcall; external MFPlat_DLL;

// Creates an instance of the Media Foundation implementation of IMFSample
function MFCreateSample(out ppIMFSample: IMFSample): HRESULT; stdcall; external MFPlat_DLL;

/// ////////////////////////////////////////////////////////////////////////////////////////////////////////////  Attributes ////////////////////////////////////

function MFCreateAttributes(out ppMFAttributes: IMFAttributes; cInitialSize: UINT32): HRESULT; stdcall; external MFPlat_DLL;

function MFInitAttributesFromBlob(pAttributes: IMFAttributes; const pBuf: PUINT8; cbBufSize: UINT): HRESULT; stdcall; external MFPlat_DLL;

function MFGetAttributesAsBlobSize(pAttributes: IMFAttributes; out pcbBufSize: UINT32): HRESULT; stdcall; external MFPlat_DLL;

function MFGetAttributesAsBlob(pAttributes: IMFAttributes; out pBuf: PUINT8; cbBufSize: UINT): HRESULT; stdcall; external MFPlat_DLL;

/// ////////////////////////////////////////////////////////////////////////////////////////////////////////////  MFT Register & Enum ////////////////////////////
// "Flags" is for future expansion - for now must be 0
function MFTRegister(clsidMFT: CLSID; guidCategory: TGUID; pszName: LPWSTR; Flags: UINT32; cInputTypes: UINT32; pInputTypes: PMFT_REGISTER_TYPE_INFO;
    cOutputTypes: UINT32; pOutputTypes: PMFT_REGISTER_TYPE_INFO; pAttributes: IMFAttributes): HRESULT; stdcall; external MFPlat_DLL;

function MFTUnregister(clsidMFT: CLSID): HRESULT; stdcall; external MFPlat_DLL;

// Register an MFT class in-process
function MFTRegisterLocal(pClassFactory: IClassFactory; const guidCategory: TGUID; pszName: LPCWSTR; Flags: UINT32; cInputTypes: UINT32;
    const pInputTypes: PMFT_REGISTER_TYPE_INFO; cOutputTypes: UINT32; const pOutputTypes: PMFT_REGISTER_TYPE_INFO): HRESULT; stdcall; external MFPlat_DLL;

// Unregister locally registered MFT
// If pClassFactory is NULL all local MFTs are unregistered
function MFTUnregisterLocal(pClassFactory: IClassFactory): HRESULT; stdcall; external MFPlat_DLL;

// Register an MFT class in-process, by CLSID
function MFTRegisterLocalByCLSID(const clisdMFT: CLSID; const guidCategory: TGUID; pszName: LPCWSTR; Flags: UINT32; cInputTypes: UINT32;
    const pInputTypes: PMFT_REGISTER_TYPE_INFO; cOutputTypes: UINT32; const pOutputTypes: PMFT_REGISTER_TYPE_INFO): HRESULT; stdcall; external MFPlat_DLL;

// Unregister locally registered MFT by CLSID
function MFTUnregisterLocalByCLSID(clsidMFT: CLSID): HRESULT; stdcall; external MFPlat_DLL;


// result *ppclsidMFT must be freed with CoTaskMemFree.

function MFTEnum(guidCategory: TGUID; Flags: UINT32; const pInputType: TMFT_REGISTER_TYPE_INFO; const pOutputType: TMFT_REGISTER_TYPE_INFO;
    pAttributes: IMFAttributes; out ppclsidMFT: PCLSID; // must be freed with CoTaskMemFree
    out pcMFTs: UINT32): HRESULT; stdcall; external MFPlat_DLL;


// result *pppMFTActivate must be freed with CoTaskMemFree. Each IMFActivate pointer inside this
// buffer should be released.

function MFTEnumEx(guidCategory: TGUID; Flags: UINT32; const pInputType: PMFT_REGISTER_TYPE_INFO; const pOutputType: PMFT_REGISTER_TYPE_INFO;
    out pppMFTActivate: PIMFActivate; out pnumMFTActivate: UINT32): HRESULT; stdcall; external MFPlat_DLL;


// results *pszName, *ppInputTypes, and *ppOutputTypes must be freed with CoTaskMemFree.
// *ppAttributes must be released.

function MFTGetInfo(clsidMFT: CLSID; out pszName: LPWSTR; out ppInputTypes: PMFT_REGISTER_TYPE_INFO; out pcInputTypes: UINT32;
    out ppOutputTypes: PMFT_REGISTER_TYPE_INFO; out pcOutputTypes: UINT32; out ppAttributes: IMFAttributes): HRESULT; stdcall; external MFPlat_DLL;


// Get the plugin control API

function MFGetPluginControl(out ppPluginControl: IMFPluginControl): HRESULT; stdcall; external MFPlat_DLL;


// Get MFT's merit - checking that is has a valid certificate

function MFGetMFTMerit(var pMFT: IUnknown; cbVerifier: UINT32; const verifier: PBYTE; out merit: DWORD): HRESULT; stdcall; external MFPlat_DLL;

function MFRegisterLocalSchemeHandler(szScheme: PWideChar; pActivate: IMFActivate): HRESULT; stdcall; external MFPlat_DLL;

function MFRegisterLocalByteStreamHandler(szFileExtension: PWideChar; szMimeType: PWideChar; pActivate: IMFActivate): HRESULT; stdcall; external MFPlat_DLL;


// Wrap a bytestream so that calling Close() on the wrapper
// closes the wrapper but not the original bytestream. The
// original bytestream can then be passed to another
// media source for instance.

function MFCreateMFByteStreamWrapper(pStream: IMFByteStream; out ppStreamWrapper: IMFByteStream): HRESULT; stdcall; external MFPlat_DLL;


// Create a MF activate object that can instantiate media extension objects.
// The activate object supports both IMFActivate and IClassFactory.

function MFCreateMediaExtensionActivate(szActivatableClassId: PWideChar; pConfiguration: IUnknown; const riid: TGUID; out ppvObject: Pointer): HRESULT;
  stdcall; external MFPlat_DLL;

/// ////////////////////////////////////////////////////////////////////////////////////////////////////////////  Media Type functions //////////////////////////
/// /////////////////////////////////////////////////////////////////////////////

function MFValidateMediaTypeSize(formattype: TGUID; pBlock: PUINT8; cbSize: UINT32): HRESULT; stdcall; external MFPlat_DLL;

function MFCreateMediaType(out ppMFType: IMFMediaType): HRESULT; stdcall; external MFPlat_DLL;

function MFCreateMFVideoFormatFromMFMediaType(pMFType: IMFMediaType; out ppMFVF: TMFVIDEOFORMAT;
    // must be deleted with CoTaskMemFree
    out pcbSize: UINT32): HRESULT; stdcall; external MFPlat_DLL;


// declarations with default parameters

function MFCreateWaveFormatExFromMFMediaType(pMFType: IMFMediaType; out ppWF: TWAVEFORMATEX; out pcbSize: UINT32;
    Flags: UINT32 = Ord(MFWaveFormatExConvertFlag_Normal)): HRESULT; stdcall; external MFPlat_DLL;

function MFInitMediaTypeFromVideoInfoHeader(pMFType: IMFMediaType; const pVIH: PVIDEOINFOHEADER; cbBufSize: UINT32; const pSubtype: TGUID): HRESULT; stdcall;
external MFPlat_DLL;

function MFInitMediaTypeFromVideoInfoHeader2(pMFType: IMFMediaType; const pVIH2: PVIDEOINFOHEADER2; cbBufSize: UINT32; const pSubtype: TGUID): HRESULT;
  stdcall; external MFPlat_DLL;

function MFInitMediaTypeFromMPEG1VideoInfo(pMFType: IMFMediaType; const pMP1VI: PMPEG1VIDEOINFO; cbBufSize: UINT32; const pSubtype: PGUID = nil): HRESULT;
  stdcall; external MFPlat_DLL;

function MFInitMediaTypeFromMPEG2VideoInfo(pMFType: IMFMediaType; const pMP2VI: PMPEG2VIDEOINFO; cbBufSize: UINT32; const pSubtype: PGUID = nil): HRESULT;
  stdcall; external MFPlat_DLL;

function MFCalculateBitmapImageSize(const pBMIH: PBITMAPINFOHEADER; cbBufSize: UINT32; out pcbImageSize: UINT32; out pbKnown: boolean): HRESULT; stdcall;
external MFPlat_DLL;

function MFCalculateImageSize(guidSubtype: TREFGUID; unWidth: UINT32; unHeight: UINT32; out pcbImageSize: UINT32): HRESULT; stdcall; external MFPlat_DLL;

function MFFrameRateToAverageTimePerFrame(unNumerator: UINT32; unDenominator: UINT32; out punAverageTimePerFrame: UINT64): HRESULT; stdcall;
external MFPlat_DLL;

function MFAverageTimePerFrameToFrameRate(unAverageTimePerFrame: UINT64; out punNumerator: UINT32; out punDenominator: UINT32): HRESULT; stdcall;
external MFPlat_DLL;

function MFInitMediaTypeFromMFVideoFormat(pMFType: IMFMediaType; const pMFVF: PMFVIDEOFORMAT; cbBufSize: UINT32): HRESULT; stdcall; external MFPlat_DLL;

function MFInitMediaTypeFromWaveFormatEx(pMFType: IMFMediaType; const pWaveFormat: PWAVEFORMATEX; cbBufSize: UINT32): HRESULT; stdcall; external MFPlat_DLL;

function MFInitMediaTypeFromAMMediaType(pMFType: IMFMediaType; const pAMType: TAM_MEDIA_TYPE): HRESULT; stdcall; external MFPlat_DLL;

function MFInitAMMediaTypeFromMFMediaType(pMFType: IMFMediaType; guidFormatBlockType: TGUID; var pAMType: TAM_MEDIA_TYPE): HRESULT; stdcall;
external MFPlat_DLL;

function MFCreateAMMediaTypeFromMFMediaType(pMFType: IMFMediaType; guidFormatBlockType: TGUID; var ppAMType: PAM_MEDIA_TYPE // delete with DeleteMediaType
  ): HRESULT; stdcall; external MFPlat_DLL;


// This function compares a full media type to a partial media type.

// A "partial" media type is one that is given out by a component as a possible
// media type it could accept. Many attributes may be unset, which represents
// a "don't care" status for that attribute.

// For example, a video effect may report that it supports YV12,
// but not want to specify a particular size. It simply creates a media type and sets
// the major type to MFMediaType_Video and the subtype to MEDIASUBTYPE_YV12.

// The comparison function succeeds if the partial type contains at least a major type,
// and all of the attributes in the partial type exist in the full type and are set to
// the same value.

function MFCompareFullToPartialMediaType(pMFTypeFull: IMFMediaType; pMFTypePartial: IMFMediaType): boolean; stdcall; external MFPlat_DLL;

function MFWrapMediaType(pOrig: IMFMediaType; const majortype: TGUID; const subtype: TGUID; out ppWrap: IMFMediaType): HRESULT; stdcall; external MFPlat_DLL;

function MFUnwrapMediaType(pWrap: IMFMediaType; out ppOrig: IMFMediaType): HRESULT; stdcall; external MFPlat_DLL;


// MFCreateVideoMediaType

function MFCreateVideoMediaTypeFromVideoInfoHeader(const PVIDEOINFOHEADER: TKS_VIDEOINFOHEADER; cbVideoInfoHeader: DWORD; dwPixelAspectRatioX: DWORD;
    dwPixelAspectRatioY: DWORD; InterlaceMode: TMFVideoInterlaceMode; VideoFlags: QWORD; const pSubtype: TGUID;
    out ppIVideoMediaType: IMFVideoMediaType): HRESULT; stdcall; external MFPlat_DLL;

function MFCreateVideoMediaTypeFromVideoInfoHeader2(const PVIDEOINFOHEADER: TKS_VIDEOINFOHEADER2; cbVideoInfoHeader: DWORD; AdditionalVideoFlags: QWORD;
    const pSubtype: TGUID; out ppIVideoMediaType: IMFVideoMediaType): HRESULT; stdcall; external MFPlat_DLL;

function MFCreateVideoMediaType(const pVideoFormat: TMFVIDEOFORMAT; out ppIVideoMediaType: IMFVideoMediaType): HRESULT; stdcall; external MFPlat_DLL;

function MFCreateVideoMediaTypeFromSubtype(const pAMSubtype: TGUID; out ppIVideoMediaType: IMFVideoMediaType): HRESULT; stdcall; external MFPlat_DLL;

function MFIsFormatYUV(Format: DWORD): boolean; stdcall; external EVR_DLL;


// These depend on BITMAPINFOHEADER being defined

function MFCreateVideoMediaTypeFromBitMapInfoHeader(const pbmihBitMapInfoHeader: TBITMAPINFOHEADER; dwPixelAspectRatioX: DWORD; dwPixelAspectRatioY: DWORD;
    InterlaceMode: TMFVideoInterlaceMode; VideoFlags: QWORD; qwFramesPerSecondNumerator: QWORD; qwFramesPerSecondDenominator: QWORD; dwMaxBitRate: DWORD;
    out ppIVideoMediaType: IMFVideoMediaType): HRESULT; stdcall; external MFPlat_DLL;

function MFGetStrideForBitmapInfoHeader(Format: DWORD; dwWidth: DWORD; out pStride: LONG): HRESULT; stdcall; external MFPlat_DLL;

function MFGetPlaneSize(Format: DWORD; dwWidth: DWORD; dwHeight: DWORD; out pdwPlaneSize: DWORD): HRESULT; stdcall; external MFPlat_DLL;


// MFCreateVideoMediaTypeFromBitMapInfoHeaderEx

function MFCreateVideoMediaTypeFromBitMapInfoHeaderEx(const pbmihBitMapInfoHeader: PBITMAPINFOHEADER; cbBitMapInfoHeader: UINT32; dwPixelAspectRatioX: DWORD;
    dwPixelAspectRatioY: DWORD; InterlaceMode: TMFVideoInterlaceMode; VideoFlags: QWORD; dwFramesPerSecondNumerator: DWORD;
    dwFramesPerSecondDenominator: DWORD; dwMaxBitRate: DWORD; out ppIVideoMediaType: IMFVideoMediaType): HRESULT; stdcall; external MFPlat_DLL;


// MFCreateMediaTypeFromRepresentation

function MFCreateMediaTypeFromRepresentation(guidRepresentation: TGUID; pvRepresentation: Pointer; out ppIMediaType: IMFMediaType): HRESULT; stdcall;
external MFPlat_DLL;


// MFCreateAudioMediaType

function MFCreateAudioMediaType(const pAudioFormat: TWAVEFORMATEX; out ppIAudioMediaType: IMFAudioMediaType): HRESULT; stdcall; external MFPlat_DLL;

function MFGetUncompressedVideoFormat(const pVideoFormat: TMFVIDEOFORMAT): DWORD; stdcall; external MFPlat_DLL;

function MFInitVideoFormat(pVideoFormat: PMFVIDEOFORMAT; _stype: TMFStandardVideoFormat): HRESULT; stdcall; external MFPlat_DLL;

function MFInitVideoFormat_RGB(pVideoFormat: PMFVIDEOFORMAT; dwWidth: DWORD; dwHeight: DWORD; D3Dfmt: DWORD (* 0 indicates sRGB *)
): HRESULT; stdcall; external MFPlat_DLL;

function MFConvertColorInfoToDXVA(out pdwToDXVA: DWORD; const pFromFormat: TMFVIDEOFORMAT): HRESULT; stdcall; external MFPlat_DLL;

function MFConvertColorInfoFromDXVA(var pToFormat: TMFVIDEOFORMAT; dwFromDXVA: DWORD): HRESULT; stdcall; external MFPlat_DLL;


// Optimized stride copy function

function MFCopyImage(out pDest: PBYTE; lDestStride: LONG; const pSrc: PBYTE; lSrcStride: LONG; out dwWidthInBytes: DWORD; dwLines: DWORD): HRESULT; stdcall;
external MFPlat_DLL;

function MFConvertFromFP16Array(out pDest: PSingle; const pSrc: PWORD; dwCount: DWORD): HRESULT; stdcall; external MFPlat_DLL;

function MFConvertToFP16Array(out pDest: PWORD; const pSrc: PSingle; dwCount: DWORD): HRESULT; stdcall; external MFPlat_DLL;

function MFCreate2DMediaBuffer(dwWidth: DWORD; dwHeight: DWORD; dwFourCC: DWORD; fBottomUp: boolean; out ppBuffer: IMFMediaBuffer): HRESULT; stdcall;
external MFPlat_DLL;


// Creates an optimal system memory media buffer from a media type

function MFCreateMediaBufferFromMediaType(pMediaType: IMFMediaType; llDuration: LONGLONG; // Sample Duration, needed for audio
    dwMinLength: DWORD; // 0 means optimized default
    dwMinAlignment: DWORD; // 0 means optimized default
    out ppBuffer: IMFMediaBuffer): HRESULT; stdcall; external MFPlat_DLL;


// Instantiates the MF-provided IMFCollection implementation

function MFCreateCollection(out ppIMFCollection: IMFCollection): HRESULT; stdcall; external MFPlat_DLL;

function MFHeapAlloc(nSize: size_t; dwFlags: ULONG; pszFile: PChar; line: integer; eat: TEAllocationType): Pointer; stdcall; external MFPlat_DLL;

procedure MFHeapFree(pv: Pointer); stdcall; external MFPlat_DLL;


// Return (a * b + d) / c
// Returns _I64_MAX or LLONG_MIN on failure or _I64_MAX if mplat.dll is not available

function MFllMulDiv(a: LONGLONG; B: LONGLONG; c: LONGLONG; d: LONGLONG): LONGLONG; stdcall; external MFPlat_DLL;

/// ///////////////////////    Content Protection    ////////////////////////////
/// /////////////////////////////////////////////////////////////////////////////

function MFGetContentProtectionSystemCLSID(const guidProtectionSystemID: TGUID; out PCLSID: CLSID): HRESULT; stdcall; external MFPlat_DLL;

implementation

// IMFAttributes inline UTILITY FUNCTIONS - used for IMFMediaType as well

function HI32(unPacked: UINT64): UINT32; inline;
begin
    Result := UINT32(unPacked shr 32);
end;

function LO32(unPacked: UINT64): UINT32; inline;
begin
    Result := UINT32(unPacked);
end;

function Pack2UINT32AsUINT64(unHigh: UINT32; unLow: UINT32): UINT64; inline;
begin
    Result := UINT64(unHigh shl 32) or unLow;
end;

procedure Unpack2UINT32AsUINT64(unPacked: UINT64; out punHigh: UINT32; out punLow: UINT32); inline;
begin
    punHigh := HI32(unPacked);
    punLow := LO32(unPacked);
end;

function PackSize(unWidth: UINT32; unHeight: UINT32): UINT64; inline;
begin
    Result := Pack2UINT32AsUINT64(unWidth, unHeight);
end;

procedure UnpackSize(unPacked: UINT64; out punWidth: UINT32; out punHeight: UINT32); inline;
begin
    Unpack2UINT32AsUINT64(unPacked, punWidth, punHeight);
end;

function PackRatio(nNumerator: INT32; unDenominator: UINT32): UINT64; inline;
begin
    Result := Pack2UINT32AsUINT64(UINT32(nNumerator), unDenominator);
end;

procedure UnpackRatio(unPacked: UINT64; out pnNumerator: INT32; out punDenominator: UINT32); inline;
begin
    Unpack2UINT32AsUINT64(unPacked, UINT32(pnNumerator), punDenominator);
end;


// "failsafe" inline get methods - return the stored value or return a default

function MFGetAttributeUINT32(pAttributes: IMFAttributes; const guidKey: TGUID; unDefault: UINT32): UINT32; inline;
var
    unRet: UINT32;
begin

    if (FAILED(pAttributes.GetUINT32(guidKey, unRet))) then
    begin
        unRet := unDefault;
    end;
    Result := unRet;
end;

function MFGetAttributeUINT64(pAttributes: IMFAttributes; const guidKey: TGUID; unDefault: UINT64): UINT64; inline;
var
    unRet: UINT64;
begin

    if (FAILED(pAttributes.GetUINT64(guidKey, unRet))) then
    begin
        unRet := unDefault;
    end;
    Result := unRet;
end;

function MFGetAttributeDouble(pAttributes: IMFAttributes; const guidKey: TGUID; fDefault: double): double; inline;
var
    fRet: double;
begin

    if (FAILED(pAttributes.GetDouble(guidKey, fRet))) then
    begin
        fRet := fDefault;
    end;
    Result := fRet;
end;


// helpers for getting/setting ratios and sizes

function MFGetAttribute2UINT32asUINT64(pAttributes: IMFAttributes; const guidKey: TGUID; out punHigh32: UINT32; out punLow32: UINT32): HRESULT; inline;
var
    unPacked: UINT64;
begin

    Result := S_OK;

    Result := pAttributes.GetUINT64(guidKey, unPacked);
    if (FAILED(Result)) then
        Exit;

    Unpack2UINT32AsUINT64(unPacked, punHigh32, punLow32);
end;

function MFSetAttribute2UINT32asUINT64(pAttributes: IMFAttributes; const guidKey: TGUID; unHigh32: UINT32; unLow32: UINT32): HRESULT; inline;
begin
    Result := pAttributes.SetUINT64(guidKey, Pack2UINT32AsUINT64(unHigh32, unLow32));
end;

function MFGetAttributeRatio(pAttributes: IMFAttributes; const guidKey: TGUID; out punNumerator: UINT32; out punDenominator: UINT32): HRESULT; inline;
begin
    Result := MFGetAttribute2UINT32asUINT64(pAttributes, guidKey, punNumerator, punDenominator);
end;

function MFGetAttributeSize(pAttributes: IMFAttributes; const guidKey: TGUID; out punWidth: UINT32; out punHeight: UINT32): HRESULT; inline;
begin
    Result := MFGetAttribute2UINT32asUINT64(pAttributes, guidKey, punWidth, punHeight);
end;

function MFSetAttributeRatio(pAttributes: IMFAttributes; const guidKey: TGUID; unNumerator: UINT32; unDenominator: UINT32): HRESULT; inline;
begin
    Result := MFSetAttribute2UINT32asUINT64(pAttributes, guidKey, unNumerator, unDenominator);
end;

function MFSetAttributeSize(pAttributes: IMFAttributes; const guidKey: TGUID; unWidth: UINT32; unHeight: UINT32): HRESULT; inline;
begin
    Result := MFSetAttribute2UINT32asUINT64(pAttributes, guidKey, unWidth, unHeight);
end;

function MFGetAttributeString(pAttributes: IMFAttributes; const guidKey: TGUID; out ppsz: PWideChar // PWSTR
  ): HRESULT; inline;
var
    length: UINT32;
    psz: PWideChar; // PWSTR
    cb: size_t;
begin
    psz := nil;
    ppsz := nil;
    result:=pAttributes.GetStringLength(guidKey, length);
    // add NULL to length
    if (SUCCEEDED(result)) then
    begin
        inc(length); // should be save, cause we are using PASCAl and not C++
    end;
    if (SUCCEEDED(result))  then
    begin
        cb:=length*sizeof(WCHAR);// should be save, cause we are using PASCAl and not C++
        // result:= SizeTMult(length,sizeof(WCHAR) , cb);
        if( SUCCEEDED( result ) )          then
        begin
            psz := PWideChar( CoTaskMemAlloc( cb ) );
            if( psz=nil )             then
             begin
                result:= E_OUTOFMEMORY;
            end;
        end;
    end;
    if (SUCCEEDED(result))  then begin
        result:= pAttributes.GetString(guidKey, psz, length, length);
    end;
    if (SUCCEEDED(result))  then begin
        ppsz := psz;
    end else begin
        CoTaskMemFree(psz);
    end;
end;

end.
