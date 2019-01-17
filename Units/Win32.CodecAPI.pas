(*++

Copyright (c) Microsoft Corporation. All rights reserved.

Module Name:

    codecapi.h

Abstract:

    CodecAPI Definitions.

--*)

// Updated to SDK 10.0.17763.0
// (c) Translation to Pascal by Norbert Sonnleitner

unit Win32.CodecAPI;

{$mode delphi}

interface

uses
    Windows, Classes, SysUtils;

const

    // Windows CodecAPI Properties

    // Legend for the
    //  Reference   VariantType VariantField
    //  UINT8       VT_UI1      bVal
    //  UINT16      VT_UI2      uiVal
    //  UINT32      VT_UI4      ulVal
    //  UINT64      VT_UI8      ullVal
    //  INT8        VT_I1       eVal
    //  INT16       VT_I2       iVal
    //  INT32       VT_I4       lVal
    //  INT64       VT_I8       llVal
    //  BOOL        VT_BOOL     boolVal
    //  GUID        VT_BSTR     bstrVal (guid string)
    //  UINT32/UNINT32 VT_UI8   ullVal  (ratio)

    // { Static definitions
    STATIC_CODECAPI_AVEncCommonFormatConstraint: TGUID = '{57cbb9b8-116f-4951-b40c-c2a035ed8f17}';
    STATIC_CODECAPI_GUID_AVEncCommonFormatUnSpecified: TGUID = '{af46a35a-6024-4525-a48a-094b97f5b3c2}';
    STATIC_CODECAPI_GUID_AVEncCommonFormatDVD_V: TGUID = '{cc9598c4-e7fe-451d-b1ca-761bc840b7f3}';
    STATIC_CODECAPI_GUID_AVEncCommonFormatDVD_DashVR: TGUID = '{e55199d6-044c-4dae-a488-531ed306235b}';
    STATIC_CODECAPI_GUID_AVEncCommonFormatDVD_PlusVR: TGUID = '{e74c6f2e-ec37-478d-9af4-a5e135b6271c}';
    STATIC_CODECAPI_GUID_AVEncCommonFormatVCD: TGUID = '{95035bf7-9d90-40ff-ad5c-5cf8cf71ca1d}';
    STATIC_CODECAPI_GUID_AVEncCommonFormatSVCD: TGUID = '{51d85818-8220-448c-8066-d69bed16c9ad}';
    STATIC_CODECAPI_GUID_AVEncCommonFormatATSC: TGUID = '{8d7b897c-a019-4670-aa76-2edcac7ac296}';
    STATIC_CODECAPI_GUID_AVEncCommonFormatDVB: TGUID = '{71830d8f-6c33-430d-844b-c2705baae6db}';
    STATIC_CODECAPI_GUID_AVEncCommonFormatMP3: TGUID = '{349733cd-eb08-4dc2-8197-e49835ef828b}';
    STATIC_CODECAPI_GUID_AVEncCommonFormatHighMAT: TGUID = '{1eabe760-fb2b-4928-90d1-78db88eee889}';
    STATIC_CODECAPI_GUID_AVEncCommonFormatHighMPV: TGUID = '{a2d25db8-b8f9-42c2-8bc7-0b93cf604788}';
    STATIC_CODECAPI_AVEncCodecType: TGUID = '{08af4ac1-f3f2-4c74-9dcf-37f2ec79f826}';
    STATIC_CODECAPI_GUID_AVEncMPEG1Video: TGUID = '{c8dafefe-da1e-4774-b27d-11830c16b1fe}';
    STATIC_CODECAPI_GUID_AVEncMPEG2Video: TGUID = '{046dc19a-6677-4aaa-a31d-c1ab716f4560}';
    STATIC_CODECAPI_GUID_AVEncMPEG1Audio: TGUID = '{d4dd1362-cd4a-4cd6-8138-b94db4542b04}';
    STATIC_CODECAPI_GUID_AVEncMPEG2Audio: TGUID = '{ee4cbb1f-9c3f-4770-92b5-fcb7c2a8d381}';
    STATIC_CODECAPI_GUID_AVEncWMV: TGUID = '{4e0fef9b-1d43-41bd-b8bd-4d7bf7457a2a}';
    STATIC_CODECAPI_GUID_AVEndMPEG4Video: TGUID = '{dd37b12a-9503-4f8b-b8d0-324a00c0a1cf}';
    STATIC_CODECAPI_GUID_AVEncH264Video: TGUID = '{95044eab-31b3-47de-8e75-38a42bb03e28}';
    STATIC_CODECAPI_GUID_AVEncDV: TGUID = '{09b769c7-3329-44fb-8954-fa30937d3d5a}';
    STATIC_CODECAPI_GUID_AVEncWMAPro: TGUID = '{1955f90c-33f7-4a68-ab81-53f5657125c4}';
    STATIC_CODECAPI_GUID_AVEncWMALossless: TGUID = '{55ca7265-23d8-4761-9031-b74fbe12f4c1}';
    STATIC_CODECAPI_GUID_AVEncWMAVoice: TGUID = '{13ed18cb-50e8-4276-a288-a6aa228382d9}';
    STATIC_CODECAPI_GUID_AVEncDolbyDigitalPro: TGUID = '{f5be76cc-0ff8-40eb-9cb1-bba94004d44f}';
    STATIC_CODECAPI_GUID_AVEncDolbyDigitalConsumer: TGUID = '{c1a7bf6c-0059-4bfa-94ef-ef747a768d52}';
    STATIC_CODECAPI_GUID_AVEncDolbyDigitalPlus: TGUID = '{698d1b80-f7dd-415c-971c-42492a2056c6}';
    STATIC_CODECAPI_GUID_AVEncDTSHD: TGUID = '{2052e630-469d-4bfb-80ca-1d656e7e918f}';
    STATIC_CODECAPI_GUID_AVEncDTS: TGUID = '{45fbcaa2-5e6e-4ab0-8893-5903bee93acf}';
    STATIC_CODECAPI_GUID_AVEncMLP: TGUID = '{05f73e29-f0d1-431e-a41c-a47432ec5a66}';
    STATIC_CODECAPI_GUID_AVEncPCM: TGUID = '{844be7f4-26cf-4779-b386-cc05d187990c}';
    STATIC_CODECAPI_GUID_AVEncSDDS: TGUID = '{1dc1b82f-11c8-4c71-b7b6-ee3eb9bc2b94}';
    STATIC_CODECAPI_AVEncCommonRateControlMode: TGUID = '{1c0608e9-370c-4710-8a58-cb6181c42423}';
    STATIC_CODECAPI_AVEncCommonLowLatency: TGUID = '{9d3ecd55-89e8-490a-970a-0c9548d5a56e}';
    STATIC_CODECAPI_AVEncCommonMultipassMode: TGUID = '{22533d4c-47e1-41b5-9352-a2b7780e7ac4}';
    STATIC_CODECAPI_AVEncCommonPassStart: TGUID = '{6a67739f-4eb5-4385-9928-f276a939ef95}';
    STATIC_CODECAPI_AVEncCommonPassEnd: TGUID = '{0e3d01bc-c85c-467d-8b60-c41012ee3bf6}';
    STATIC_CODECAPI_AVEncCommonRealTime: TGUID = '{143a0ff6-a131-43da-b81e-98fbb8ec378e}';
    STATIC_CODECAPI_AVEncCommonQuality: TGUID = '{fcbf57a3-7ea5-4b0c-9644-69b40c39c391}';
    STATIC_CODECAPI_AVEncCommonQualityVsSpeed: TGUID = '{98332df8-03cd-476b-89fa-3f9e442dec9f}';
    STATIC_CODECAPI_AVEncCommonTranscodeEncodingProfile: TGUID = '{6947787C-F508-4EA9-B1E9-A1FE3A49FBC9}';
    STATIC_CODECAPI_AVEncCommonMeanBitRate: TGUID = '{f7222374-2144-4815-b550-a37f8e12ee52}';
    STATIC_CODECAPI_AVEncCommonMeanBitRateInterval: TGUID = '{bfaa2f0c-cb82-4bc0-8474-f06a8a0d0258}';
    STATIC_CODECAPI_AVEncCommonMaxBitRate: TGUID = '{9651eae4-39b9-4ebf-85ef-d7f444ec7465}';
    STATIC_CODECAPI_AVEncCommonMinBitRate: TGUID = '{101405b2-2083-4034-a806-efbeddd7c9ff}';
    STATIC_CODECAPI_AVEncCommonBufferSize: TGUID = '{0db96574-b6a4-4c8b-8106-3773de0310cd}';
    STATIC_CODECAPI_AVEncCommonBufferInLevel: TGUID = '{d9c5c8db-fc74-4064-94e9-cd19f947ed45}';
    STATIC_CODECAPI_AVEncCommonBufferOutLevel: TGUID = '{ccae7f49-d0bc-4e3d-a57e-fb5740140069}';
    STATIC_CODECAPI_AVEncCommonStreamEndHandling: TGUID = '{6aad30af-6ba8-4ccc-8fca-18d19beaeb1c}';
    STATIC_CODECAPI_AVEncStatCommonCompletedPasses: TGUID = '{3e5de533-9df7-438c-854f-9f7dd3683d34}';
    STATIC_CODECAPI_AVEncVideoOutputFrameRate: TGUID = '{ea85e7c3-9567-4d99-87c4-02c1c278ca7c}';
    STATIC_CODECAPI_AVEncVideoOutputFrameRateConversion: TGUID = '{8c068bf4-369a-4ba3-82fd-b2518fb3396e}';
    STATIC_CODECAPI_AVEncVideoPixelAspectRatio: TGUID = '{3cdc718f-b3e9-4eb6-a57f-cf1f1b321b87}';
    STATIC_CODECAPI_AVEncVideoForceSourceScanType: TGUID = '{1ef2065f-058a-4765-a4fc-8a864c103012}';
    STATIC_CODECAPI_AVEncVideoNoOfFieldsToEncode: TGUID = '{61e4bbe2-4ee0-40e7-80ab-51ddeebe6291}';
    STATIC_CODECAPI_AVEncVideoNoOfFieldsToSkip: TGUID = '{a97e1240-1427-4c16-a7f7-3dcfd8ba4cc5}';
    STATIC_CODECAPI_AVEncVideoEncodeDimension: TGUID = '{1074df28-7e0f-47a4-a453-cdd73870f5ce}';
    STATIC_CODECAPI_AVEncVideoEncodeOffsetOrigin: TGUID = '{6bc098fe-a71a-4454-852e-4d2ddeb2cd24}';
    STATIC_CODECAPI_AVEncVideoDisplayDimension: TGUID = '{de053668-f4ec-47a9-86d0-836770f0c1d5}';

    STATIC_CODECAPI_AVEncVideoOutputScanType: TGUID = '{460b5576-842e-49ab-a62d-b36f7312c9db}';
    STATIC_CODECAPI_AVEncVideoInverseTelecineEnable: TGUID = '{2ea9098b-e76d-4ccd-a030-d3b889c1b64c}';
    STATIC_CODECAPI_AVEncVideoInverseTelecineThreshold: TGUID = '{40247d84-e895-497f-b44c-b74560acfe27}';
    STATIC_CODECAPI_AVEncVideoSourceFilmContent: TGUID = '{1791c64b-ccfc-4827-a0ed-2557793b2b1c}';
    STATIC_CODECAPI_AVEncVideoSourceIsBW: TGUID = '{42ffc49b-1812-4fdc-8d24-7054c521e6eb}';
    STATIC_CODECAPI_AVEncVideoFieldSwap: TGUID = '{fefd7569-4e0a-49f2-9f2b-360ea48c19a2}';
    STATIC_CODECAPI_AVEncVideoInputChromaResolution: TGUID = '{bb0cec33-16f1-47b0-8a88-37815bee1739}';
    STATIC_CODECAPI_AVEncVideoOutputChromaResolution: TGUID = '{6097b4c9-7c1d-4e64-bfcc-9e9765318ae7}';
    STATIC_CODECAPI_AVEncVideoInputChromaSubsampling: TGUID = '{a8e73a39-4435-4ec3-a6ea-98300f4b36f7}';
    STATIC_CODECAPI_AVEncVideoOutputChromaSubsampling: TGUID = '{fa561c6c-7d17-44f0-83c9-32ed12e96343}';
    STATIC_CODECAPI_AVEncVideoInputColorPrimaries: TGUID = '{c24d783f-7ce6-4278-90ab-28a4f1e5f86c}';
    STATIC_CODECAPI_AVEncVideoOutputColorPrimaries: TGUID = '{be95907c-9d04-4921-8985-a6d6d87d1a6c}';
    STATIC_CODECAPI_AVEncVideoInputColorTransferFunction: TGUID = '{8c056111-a9c3-4b08-a0a0-ce13f8a27c75}';
    STATIC_CODECAPI_AVEncVideoOutputColorTransferFunction: TGUID = '{4a7f884a-ea11-460d-bf57-b88bc75900de}';
    STATIC_CODECAPI_AVEncVideoInputColorTransferMatrix: TGUID = '{52ed68b9-72d5-4089-958d-f5405d55081c}';
    STATIC_CODECAPI_AVEncVideoOutputColorTransferMatrix: TGUID = '{a9b90444-af40-4310-8fbe-ed6d933f892b}';
    STATIC_CODECAPI_AVEncVideoInputColorLighting: TGUID = '{46a99549-0015-4a45-9c30-1d5cfa258316}';
    STATIC_CODECAPI_AVEncVideoOutputColorLighting: TGUID = '{0e5aaac6-ace6-4c5c-998e-1a8c9c6c0f89}';
    STATIC_CODECAPI_AVEncVideoInputColorNominalRange: TGUID = '{16cf25c6-a2a6-48e9-ae80-21aec41d427e}';
    STATIC_CODECAPI_AVEncVideoOutputColorNominalRange: TGUID = '{972835ed-87b5-4e95-9500-c73958566e54}';
    STATIC_CODECAPI_AVEncInputVideoSystem: TGUID = '{bede146d-b616-4dc7-92b2-f5d9fa9298f7}';
    STATIC_CODECAPI_AVEncVideoHeaderDropFrame: TGUID = '{6ed9e124-7925-43fe-971b-e019f62222b4}';
    STATIC_CODECAPI_AVEncVideoHeaderHours: TGUID = '{2acc7702-e2da-4158-bf9b-88880129d740}';
    STATIC_CODECAPI_AVEncVideoHeaderMinutes: TGUID = '{dc1a99ce-0307-408b-880b-b8348ee8ca7f}';
    STATIC_CODECAPI_AVEncVideoHeaderSeconds: TGUID = '{4a2e1a05-a780-4f58-8120-9a449d69656b}';
    STATIC_CODECAPI_AVEncVideoHeaderFrames: TGUID = '{afd5f567-5c1b-4adc-bdaf-735610381436}';
    STATIC_CODECAPI_AVEncVideoDefaultUpperFieldDominant: TGUID = '{810167c4-0bc1-47ca-8fc2-57055a1474a5}';
    STATIC_CODECAPI_AVEncVideoCBRMotionTradeoff: TGUID = '{0d49451e-18d5-4367-a4ef-3240df1693c4}';
    STATIC_CODECAPI_AVEncVideoCodedVideoAccessUnitSize: TGUID = '{b4b10c15-14a7-4ce8-b173-dc90a0b4fcdb}';
    STATIC_CODECAPI_AVEncVideoMaxKeyframeDistance: TGUID = '{2987123a-ba93-4704-b489-ec1e5f25292c}';
    STATIC_CODECAPI_AVEncH264CABACEnable: TGUID = '{ee6cad62-d305-4248-a50e-e1b255f7caf8}';

    STATIC_CODECAPI_AVEncVideoContentType: TGUID = '{66117aca-eb77-459d-930c-a48d9d0683fc}';
    STATIC_CODECAPI_AVEncNumWorkerThreads: TGUID = '{b0c8bf60-16f7-4951-a30b-1db1609293d6}';
    STATIC_CODECAPI_AVEncVideoEncodeQP: TGUID = '{2cb5696b-23fb-4ce1-a0f9-ef5b90fd55ca}';
    STATIC_CODECAPI_AVEncVideoMinQP: TGUID = '{0ee22c6a-a37c-4568-b5f1-9d4c2b3ab886}';
    STATIC_CODECAPI_AVEncVideoForceKeyFrame: TGUID = '{398c1b98-8353-475a-9ef2-8f265d260345}';
    STATIC_CODECAPI_AVEncH264SPSID: TGUID = '{50f38f51-2b79-40e3-b39c-7e9fa0770501}';
    STATIC_CODECAPI_AVEncH264PPSID: TGUID = '{bfe29ec2-056c-4d68-a38d-ae5944c8582e}';
    STATIC_CODECAPI_AVEncAdaptiveMode: TGUID = '{4419b185-da1f-4f53-bc76-097d0c1efb1e}';
    STATIC_CODECAPI_AVEncVideoTemporalLayerCount: TGUID = '{19caebff-b74d-4cfd-8c27-c2f9d97d5f52}';
    STATIC_CODECAPI_AVEncVideoUsage: TGUID = '{1f636849-5dc1-49f1-b1d8-ce3cf62ea385}';
    STATIC_CODECAPI_AVEncVideoSelectLayer: TGUID = '{eb1084f5-6aaa-4914-bb2f-6147227f12e7}';
    STATIC_CODECAPI_AVEncVideoRateControlParams: TGUID = '{87d43767-7645-44ec-b438-d3322fbca29f}';
    STATIC_CODECAPI_AVEncVideoSupportedControls: TGUID = '{d3f40fdd-77b9-473d-8196-061259e69cff}';
    STATIC_CODECAPI_AVEncVideoEncodeFrameTypeQP: TGUID = '{aa70b610-e03f-450c-ad07-07314e639ce7}';
    STATIC_CODECAPI_AVEncSliceControlMode: TGUID = '{e9e782ef-5f18-44c9-a90b-e9c3c2c17b0b}';
    STATIC_CODECAPI_AVEncSliceControlSize: TGUID = '{92f51df3-07a5-4172-aefe-c69ca3b60e35}';
    STATIC_CODECAPI_AVEncSliceGenerationMode: TGUID = '{8a6bc67f-9497-4286-b46b-02db8d60edbc}';
    STATIC_CODECAPI_AVEncVideoMaxNumRefFrame: TGUID = '{964829ed-94f9-43b4-b74d-ef40944b69a0}';
    STATIC_CODECAPI_AVEncVideoMeanAbsoluteDifference: TGUID = '{e5c0c10f-81a4-422d-8c3f-b474a4581336}';
    STATIC_CODECAPI_AVEncVideoMaxQP: TGUID = '{3daf6f66-a6a7-45e0-a8e5-f2743f46a3a2}';
    STATIC_CODECAPI_AVEncVideoLTRBufferControl: TGUID = '{a4a0e93d-4cbc-444c-89f4-826d310e92a7}';
    STATIC_CODECAPI_AVEncVideoMarkLTRFrame: TGUID = '{e42f4748-a06d-4ef9-8cea-3d05fde3bd3b}';
    STATIC_CODECAPI_AVEncVideoUseLTRFrame: TGUID = '{00752db8-55f7-4f80-895b-27639195f2ad}';
    STATIC_CODECAPI_AVEncVideoROIEnabled: TGUID = '{d74f7f18-44dd-4b85-aba3-05d9f42a8280}';
    STATIC_CODECAPI_AVEncVideoDirtyRectEnabled: TGUID = '{8acb8fdd-5e0c-4c66-8729-b8f629ab04fb}';
    STATIC_CODECAPI_AVScenarioInfo: TGUID = '{b28a6e64-3ff9-446a-8a4b-0d7a53413236}';
    STATIC_CODECAPI_AVEncMPVGOPSizeMin: TGUID = '{7155cf20-d440-4852-ad0f-9c4abfe37a6a}';
    STATIC_CODECAPI_AVEncMPVGOPSizeMax: TGUID = '{fe7de4c4-1936-4fe2-bdf7-1f18ca1d001f}';
    STATIC_CODECAPI_AVEncVideoMaxCTBSize: TGUID = '{822363ff-cec8-43e5-92fd-e097488485e9}';
    STATIC_CODECAPI_AVEncVideoCTBSize: TGUID = '{d47db8b2-e73b-4cb9-8c3e-bd877d06d77b}';

    STATIC_CODECAPI_VideoEncoderDisplayContentType: TGUID = '{79b90b27-f4b1-42dc-9dd7-cdaf8135c400}';
    STATIC_CODECAPI_AVEncEnableVideoProcessing: TGUID = '{006f4bf6-0ea3-4d42-8702-b5d8be0f7a92}';
    STATIC_CODECAPI_AVEncVideoGradualIntraRefresh: TGUID = '{8f347dee-cb0d-49ba-b462-db6927ee2101}';
    STATIC_CODECAPI_GetOPMContext: TGUID = '{2f036c05-4c14-4689-8839-294c6d73e053}';
    STATIC_CODECAPI_SetHDCPManagerContext: TGUID = '{6d2d1fc8-3dc9-47eb-a1a2-471c80cd60d0}';
    STATIC_CODECAPI_AVEncVideoMaxTemporalLayers: TGUID = '{9c668cfe-08e1-424a-934e-b764b064802a}';
    STATIC_CODECAPI_AVEncVideoNumGOPsPerIDR: TGUID = '{83bc5bdb-5b89-4521-8f66-33151c373176}';
    STATIC_CODECAPI_AVEncCommonAllowFrameDrops: TGUID = '{d8477dcb-9598-48e3-8d0c-752bf206093e}';
    STATIC_CODECAPI_AVEncVideoIntraLayerPrediction: TGUID = '{d3af46b8-bf47-44bb-a283-69f0b0228ff9}';
    STATIC_CODECAPI_AVEncVideoInstantTemporalUpSwitching: TGUID = '{a3308307-0d96-4ba4-b1f0-b91a5e49df10}';
    STATIC_CODECAPI_AVEncLowPowerEncoder: TGUID = '{b668d582-8bad-4f6a-9141-375a95358b6d}';
    STATIC_CODECAPI_AVEnableInLoopDeblockFilter: TGUID = '{d2e8e399-0623-4bf3-92a8-4d1818529ded}';
    STATIC_CODECAPI_AVEncMuxOutputStreamType: TGUID = '{cedd9e8f-34d3-44db-a1d8-f81520254f3e}';

    STATIC_CODECAPI_AVEncStatVideoOutputFrameRate: TGUID = '{be747849-9ab4-4a63-98fe-f143f04f8ee9}';
    STATIC_CODECAPI_AVEncStatVideoCodedFrames: TGUID = '{d47f8d61-6f5a-4a26-bb9f-cd9518462bcd}';
    STATIC_CODECAPI_AVEncStatVideoTotalFrames: TGUID = '{fdaa9916-119a-4222-9ad6-3f7cab99cc8b}';
    STATIC_CODECAPI_AVEncAudioIntervalToEncode: TGUID = '{866e4b4d-725a-467c-bb01-b496b23b25f9}';
    STATIC_CODECAPI_AVEncAudioIntervalToSkip: TGUID = '{88c15f94-c38c-4796-a9e8-96e967983f26}';
    STATIC_CODECAPI_AVEncAudioDualMono: TGUID = '{3648126b-a3e8-4329-9b3a-5ce566a43bd3}';
    STATIC_CODECAPI_AVEncAudioMeanBitRate: TGUID = '{921295bb-4fca-4679-aab8-9e2a1d753384}';

    STATIC_CODECAPI_AVEncAudioMapDestChannel0: TGUID = '{bc5d0b60-df6a-4e16-9803-b82007a30c8d}';
    STATIC_CODECAPI_AVEncAudioMapDestChannel1: TGUID = '{bc5d0b61-df6a-4e16-9803-b82007a30c8d}';
    STATIC_CODECAPI_AVEncAudioMapDestChannel2: TGUID = '{bc5d0b62-df6a-4e16-9803-b82007a30c8d}';
    STATIC_CODECAPI_AVEncAudioMapDestChannel3: TGUID = '{bc5d0b63-df6a-4e16-9803-b82007a30c8d}';
    STATIC_CODECAPI_AVEncAudioMapDestChannel4: TGUID = '{bc5d0b64-df6a-4e16-9803-b82007a30c8d}';
    STATIC_CODECAPI_AVEncAudioMapDestChannel5: TGUID = '{bc5d0b65-df6a-4e16-9803-b82007a30c8d}';
    STATIC_CODECAPI_AVEncAudioMapDestChannel6: TGUID = '{bc5d0b66-df6a-4e16-9803-b82007a30c8d}';
    STATIC_CODECAPI_AVEncAudioMapDestChannel7: TGUID = '{bc5d0b67-df6a-4e16-9803-b82007a30c8d}';
    STATIC_CODECAPI_AVEncAudioMapDestChannel8: TGUID = '{bc5d0b68-df6a-4e16-9803-b82007a30c8d}';
    STATIC_CODECAPI_AVEncAudioMapDestChannel9: TGUID = '{bc5d0b69-df6a-4e16-9803-b82007a30c8d}';
    STATIC_CODECAPI_AVEncAudioMapDestChannel10: TGUID = '{bc5d0b6a-df6a-4e16-9803-b82007a30c8d}';
    STATIC_CODECAPI_AVEncAudioMapDestChannel11: TGUID = '{bc5d0b6b-df6a-4e16-9803-b82007a30c8d}';
    STATIC_CODECAPI_AVEncAudioMapDestChannel12: TGUID = '{bc5d0b6c-df6a-4e16-9803-b82007a30c8d}';
    STATIC_CODECAPI_AVEncAudioMapDestChannel13: TGUID = '{bc5d0b6d-df6a-4e16-9803-b82007a30c8d}';
    STATIC_CODECAPI_AVEncAudioMapDestChannel14: TGUID = '{bc5d0b6e-df6a-4e16-9803-b82007a30c8d}';
    STATIC_CODECAPI_AVEncAudioMapDestChannel15: TGUID = '{bc5d0b6f-df6a-4e16-9803-b82007a30c8d}';

    STATIC_CODECAPI_AVEncAudioInputContent: TGUID = '{3e226c2b-60b9-4a39-b00b-a7b40f70d566}';
    STATIC_CODECAPI_AVEncStatAudioPeakPCMValue: TGUID = '{dce7fd34-dc00-4c16-821b-35d9eb00fb1a}';
    STATIC_CODECAPI_AVEncStatAudioAveragePCMValue: TGUID = '{979272f8-d17f-4e32-bb73-4e731c68ba2d}';
    STATIC_CODECAPI_AVEncStatAudioAverageBPS: TGUID = '{ca6724db-7059-4351-8b43-f82198826a14}';
    STATIC_CODECAPI_AVEncStatAverageBPS: TGUID = '{ca6724db-7059-4351-8b43-f82198826a14}';
    STATIC_CODECAPI_AVEncStatHardwareProcessorUtilitization: TGUID = '{995dc027-cb95-49e6-b91b-5967753cdcb8}';
    STATIC_CODECAPI_AVEncStatHardwareBandwidthUtilitization: TGUID = '{0124ba9b-dc41-4826-b45f-18ac01b3d5a8}';
    STATIC_CODECAPI_AVEncMPVGOPSize: TGUID = '{95f31b26-95a4-41aa-9303-246a7fc6eef1}';
    STATIC_CODECAPI_AVEncMPVGOPOpen: TGUID = '{b1d5d4a6-3300-49b1-ae61-a09937ab0e49}';
    STATIC_CODECAPI_AVEncMPVDefaultBPictureCount: TGUID = '{8d390aac-dc5c-4200-b57f-814d04babab2}';
    STATIC_CODECAPI_AVEncMPVProfile: TGUID = '{dabb534a-1d99-4284-975a-d90e2239baa1}';
    STATIC_CODECAPI_AVEncMPVLevel: TGUID = '{6ee40c40-a60c-41ef-8f50-37c2249e2cb3}';
    STATIC_CODECAPI_AVEncMPVFrameFieldMode: TGUID = '{acb5de96-7b93-4c2f-8825-b0295fa93bf4}';
    STATIC_CODECAPI_AVEncMPVAddSeqEndCode: TGUID = '{a823178f-57df-4c7a-b8fd-e5ec8887708d}';
    STATIC_CODECAPI_AVEncMPVGOPSInSeq: TGUID = '{993410d4-2691-4192-9978-98dc2603669f}';
    STATIC_CODECAPI_AVEncMPVUseConcealmentMotionVectors: TGUID = '{ec770cf3-6908-4b4b-aa30-7fb986214fea}';
    STATIC_CODECAPI_AVEncMPVSceneDetection: TGUID = '{552799f1-db4c-405b-8a3a-c93f2d0674dc}';
    STATIC_CODECAPI_AVEncMPVGenerateHeaderSeqExt: TGUID = '{d5e78611-082d-4e6b-98af-0f51ab139222}';
    STATIC_CODECAPI_AVEncMPVGenerateHeaderSeqDispExt: TGUID = '{6437aa6f-5a3c-4de9-8a16-53d9c4ad326f}';
    STATIC_CODECAPI_AVEncMPVGenerateHeaderPicExt: TGUID = '{1b8464ab-944f-45f0-b74e-3a58dad11f37}';
    STATIC_CODECAPI_AVEncMPVGenerateHeaderPicDispExt: TGUID = '{c6412f84-c03f-4f40-a00c-4293df8395bb}';
    STATIC_CODECAPI_AVEncMPVGenerateHeaderSeqScaleExt: TGUID = '{0722d62f-dd59-4a86-9cd5-644f8e2653d8}';
    STATIC_CODECAPI_AVEncMPVScanPattern: TGUID = '{7f8a478e-7bbb-4ae2-b2fc-96d17fc4a2d6}';
    STATIC_CODECAPI_AVEncMPVIntraDCPrecision: TGUID = '{a0116151-cbc8-4af3-97dc-d00cceb82d79}';
    STATIC_CODECAPI_AVEncMPVQScaleType: TGUID = '{2b79ebb7-f484-4af7-bb58-a2a188c5cbbe}';
    STATIC_CODECAPI_AVEncMPVIntraVLCTable: TGUID = '{a2b83ff5-1a99-405a-af95-c5997d558d3a}';
    STATIC_CODECAPI_AVEncMPVQuantMatrixIntra: TGUID = '{9bea04f3-6621-442c-8ba1-3ac378979698}';
    STATIC_CODECAPI_AVEncMPVQuantMatrixNonIntra: TGUID = '{87f441d8-0997-4beb-a08e-8573d409cf75}';
    STATIC_CODECAPI_AVEncMPVQuantMatrixChromaIntra: TGUID = '{9eb9ecd4-018d-4ffd-8f2d-39e49f07b17a}';

    STATIC_CODECAPI_AVEncMPVQuantMatrixChromaNonIntra: TGUID = '{1415b6b1-362a-4338-ba9a-1ef58703c05b}';
    STATIC_CODECAPI_AVEncMPALayer: TGUID = '{9d377230-f91b-453d-9ce0-78445414c22d}';
    STATIC_CODECAPI_AVEncMPACodingMode: TGUID = '{b16ade03-4b93-43d7-a550-90b4fe224537}';
    STATIC_CODECAPI_AVEncDDService: TGUID = '{d2e1bec7-5172-4d2a-a50e-2f3b82b1ddf8}';
    STATIC_CODECAPI_AVEncDDDialogNormalization: TGUID = '{d7055acf-f125-437d-a704-79c79f0404a8}';
    STATIC_CODECAPI_AVEncDDCentreDownMixLevel: TGUID = '{e285072c-c958-4a81-afd2-e5e0daf1b148}';
    STATIC_CODECAPI_AVEncDDSurroundDownMixLevel: TGUID = '{7b20d6e5-0bcf-4273-a487-506b047997e9}';
    STATIC_CODECAPI_AVEncDDProductionInfoExists: TGUID = '{b0b7fe5f-b6ab-4f40-964d-8d91f17c19e8}';
    STATIC_CODECAPI_AVEncDDProductionRoomType: TGUID = '{dad7ad60-23d8-4ab7-a284-556986d8a6fe}';
    STATIC_CODECAPI_AVEncDDProductionMixLevel: TGUID = '{301d103a-cbf9-4776-8899-7c15b461ab26}';
    STATIC_CODECAPI_AVEncDDCopyright: TGUID = '{8694f076-cd75-481d-a5c6-a904dcc828f0}';
    STATIC_CODECAPI_AVEncDDOriginalBitstream: TGUID = '{966ae800-5bd3-4ff9-95b9-d30566273856}';
    STATIC_CODECAPI_AVEncDDDigitalDeemphasis: TGUID = '{e024a2c2-947c-45ac-87d8-f1030c5c0082}';
    STATIC_CODECAPI_AVEncDDDCHighPassFilter: TGUID = '{9565239f-861c-4ac8-bfda-e00cb4db8548}';
    STATIC_CODECAPI_AVEncDDChannelBWLowPassFilter: TGUID = '{e197821d-d2e7-43e2-ad2c-00582f518545}';
    STATIC_CODECAPI_AVEncDDLFELowPassFilter: TGUID = '{d3b80f6f-9d15-45e5-91be-019c3fab1f01}';
    STATIC_CODECAPI_AVEncDDSurround90DegreeePhaseShift: TGUID = '{25ecec9d-3553-42c0-bb56-d25792104f80}';
    STATIC_CODECAPI_AVEncDDSurround3dBAttenuation: TGUID = '{4d43b99d-31e2-48b9-bf2e-5cbf1a572784}';
    STATIC_CODECAPI_AVEncDDDynamicRangeCompressionControl: TGUID = '{cfc2ff6d-79b8-4b8d-a8aa-a0c9bd1c2940}';
    STATIC_CODECAPI_AVEncDDRFPreEmphasisFilter: TGUID = '{21af44c0-244e-4f3d-a2cc-3d3068b2e73f}';
    STATIC_CODECAPI_AVEncDDSurroundExMode: TGUID = '{91607cee-dbdd-4eb6-bca2-aadfafa3dd68}';
    STATIC_CODECAPI_AVEncDDPreferredStereoDownMixMode: TGUID = '{7f4e6b31-9185-403d-b0a2-763743e6f063}';
    STATIC_CODECAPI_AVEncDDLtRtCenterMixLvl_x10: TGUID = '{dca128a2-491f-4600-b2da-76e3344b4197}';
    STATIC_CODECAPI_AVEncDDLtRtSurroundMixLvl_x10: TGUID = '{212246c7-3d2c-4dfa-bc21-652a9098690d}';
    STATIC_CODECAPI_AVEncDDLoRoCenterMixLvl_x10: TGUID = '{1cfba222-25b3-4bf4-9bfd-e7111267858c}';
    STATIC_CODECAPI_AVEncDDLoRoSurroundMixLvl_x10: TGUID = '{e725cff6-eb56-40c7-8450-2b9367e91555}';
    STATIC_CODECAPI_AVEncDDAtoDConverterType: TGUID = '{719f9612-81a1-47e0-9a05-d94ad5fca948}';
    STATIC_CODECAPI_AVEncDDHeadphoneMode: TGUID = '{4052dbec-52f5-42f5-9b00-d134b1341b9d}';
    STATIC_CODECAPI_AVEncWMVKeyFrameDistance: TGUID = '{5569055e-e268-4771-b83e-9555ea28aed3}';

    STATIC_CODECAPI_AVEncWMVInterlacedEncoding: TGUID = '{e3d00f8a-c6f5-4e14-a588-0ec87a726f9b}';

    STATIC_CODECAPI_AVEncWMVDecoderComplexity: TGUID = '{f32c0dab-f3cb-4217-b79f-8762768b5f67}';
    STATIC_CODECAPI_AVEncWMVKeyFrameBufferLevelMarker: TGUID = '{51ff1115-33ac-426c-a1b1-09321bdf96b4}';
    STATIC_CODECAPI_AVEncWMVProduceDummyFrames: TGUID = '{d669d001-183c-42e3-a3ca-2f4586d2396c}';
    STATIC_CODECAPI_AVEncStatWMVCBAvg: TGUID = '{6aa6229f-d602-4b9d-b68c-c1ad78884bef}';
    STATIC_CODECAPI_AVEncStatWMVCBMax: TGUID = '{e976bef8-00fe-44b4-b625-8f238bc03499}';
    STATIC_CODECAPI_AVEncStatWMVDecoderComplexityProfile: TGUID = '{89e69fc3-0f9b-436c-974a-df821227c90d}';
    STATIC_CODECAPI_AVEncStatMPVSkippedEmptyFrames: TGUID = '{32195fd3-590d-4812-a7ed-6d639a1f9711}';
    STATIC_CODECAPI_AVEncMP12PktzSTDBuffer: TGUID = '{0b751bd0-819e-478c-9435-75208926b377}';
    STATIC_CODECAPI_AVEncMP12PktzStreamID: TGUID = '{c834d038-f5e8-4408-9b60-88f36493fedf}';
    STATIC_CODECAPI_AVEncMP12PktzInitialPTS: TGUID = '{2a4f2065-9a63-4d20-ae22-0a1bc896a315}';
    STATIC_CODECAPI_AVEncMP12PktzPacketSize: TGUID = '{ab71347a-1332-4dde-a0e5-ccf7da8a0f22}';
    STATIC_CODECAPI_AVEncMP12PktzCopyright: TGUID = '{c8f4b0c1-094c-43c7-8e68-a595405a6ef8}';
    STATIC_CODECAPI_AVEncMP12PktzOriginal: TGUID = '{6b178416-31b9-4964-94cb-6bff866cdf83}';
    STATIC_CODECAPI_AVEncMP12MuxPacketOverhead: TGUID = '{e40bd720-3955-4453-acf9-b79132a38fa0}';
    STATIC_CODECAPI_AVEncMP12MuxNumStreams: TGUID = '{f7164a41-dced-4659-a8f2-fb693f2a4cd0}';
    STATIC_CODECAPI_AVEncMP12MuxEarliestPTS: TGUID = '{157232b6-f809-474e-9464-a7f93014a817}';
    STATIC_CODECAPI_AVEncMP12MuxLargestPacketSize: TGUID = '{35ceb711-f461-4b92-a4ef-17b6841ed254}';
    STATIC_CODECAPI_AVEncMP12MuxInitialSCR: TGUID = '{3433ad21-1b91-4a0b-b190-2b77063b63a4}';
    STATIC_CODECAPI_AVEncMP12MuxMuxRate: TGUID = '{ee047c72-4bdb-4a9d-8e21-41926c823da7}';
    STATIC_CODECAPI_AVEncMP12MuxPackSize: TGUID = '{f916053a-1ce8-4faf-aa0b-ba31c80034b8}';
    STATIC_CODECAPI_AVEncMP12MuxSysSTDBufferBound: TGUID = '{35746903-b545-43e7-bb35-c5e0a7d5093c}';
    STATIC_CODECAPI_AVEncMP12MuxSysRateBound: TGUID = '{05f0428a-ee30-489d-ae28-205c72446710}';
    STATIC_CODECAPI_AVEncMP12MuxTargetPacketizer: TGUID = '{d862212a-2015-45dd-9a32-1b3aa88205a0}';
    STATIC_CODECAPI_AVEncMP12MuxSysFixed: TGUID = '{cefb987e-894f-452e-8f89-a4ef8cec063a}';
    STATIC_CODECAPI_AVEncMP12MuxSysCSPS: TGUID = '{7952ff45-9c0d-4822-bc82-8ad772e02993}';
    STATIC_CODECAPI_AVEncMP12MuxSysVideoLock: TGUID = '{b8296408-2430-4d37-a2a1-95b3e435a91d}';
    STATIC_CODECAPI_AVEncMP12MuxSysAudioLock: TGUID = '{0fbb5752-1d43-47bf-bd79-f2293d8ce337}';
    STATIC_CODECAPI_AVEncMP12MuxDVDNavPacks: TGUID = '{c7607ced-8cf1-4a99-83a1-ee5461be3574}';

    STATIC_CODECAPI_AVEncMPACopyright: TGUID = '{a6ae762a-d0a9-4454-b8ef-f2dbeefdd3bd}';
    STATIC_CODECAPI_AVEncMPAOriginalBitstream: TGUID = '{3cfb7855-9cc9-47ff-b829-b36786c92346}';
    STATIC_CODECAPI_AVEncMPAEnableRedundancyProtection: TGUID = '{5e54b09e-b2e7-4973-a89b-0b3650a3beda}';
    STATIC_CODECAPI_AVEncMPAPrivateUserBit: TGUID = '{afa505ce-c1e3-4e3d-851b-61b700e5e6cc}';
    STATIC_CODECAPI_AVEncMPAEmphasisType: TGUID = '{2d59fcda-bf4e-4ed6-b5df-5b03b36b0a1f}';


    STATIC_CODECAPI_AVDecCommonMeanBitRate: TGUID = '{59488217-007a-4f7a-8e41-5c48b1eac5c6}';
    STATIC_CODECAPI_AVDecCommonMeanBitRateInterval: TGUID = '{0ee437c6-38a7-4c5c-944c-68ab42116b85}';
    STATIC_CODECAPI_AVDecCommonInputFormat: TGUID = '{e5005239-bd89-4be3-9c0f-5dde317988cc}';
    STATIC_CODECAPI_AVDecCommonOutputFormat: TGUID = '{3c790028-c0ce-4256-b1a2-1b0fc8b1dcdc}';

    STATIC_CODECAPI_GUID_AVDecAudioOutputFormat_PCM_Stereo_MatrixEncoded: TGUID = '{696e1d30-548f-4036-825f-7026c60011bd}';
    STATIC_CODECAPI_GUID_AVDecAudioOutputFormat_PCM: TGUID = '{696e1d31-548f-4036-825f-7026c60011bd}';
    STATIC_CODECAPI_GUID_AVDecAudioOutputFormat_SPDIF_PCM: TGUID = '{696e1d32-548f-4036-825f-7026c60011bd}';
    STATIC_CODECAPI_GUID_AVDecAudioOutputFormat_SPDIF_Bitstream: TGUID = '{696e1d33-548f-4036-825f-7026c60011bd}';
    STATIC_CODECAPI_GUID_AVDecAudioOutputFormat_PCM_Headphones: TGUID = '{696e1d34-548f-4036-825f-7026c60011bd}';
    STATIC_CODECAPI_GUID_AVDecAudioOutputFormat_PCM_Stereo_Auto: TGUID = '{696e1d35-548f-4036-825f-7026c60011bd}';

    STATIC_CODECAPI_AVDecVideoImageSize: TGUID = '{5ee5747c-6801-4cab-aaf1-6248fa841ba4}';
    STATIC_CODECAPI_AVDecVideoInputScanType: TGUID = '{38477e1f-0ea7-42cd-8cd1-130ced57c580}';
    STATIC_CODECAPI_AVDecVideoPixelAspectRatio: TGUID = '{b0cf8245-f32d-41df-b02c-87bd304d12ab}';
    STATIC_CODECAPI_AVDecVideoAcceleration_MPEG2: TGUID = '{f7db8a2e-4f48-4ee8-ae31-8b6ebe558ae2}';
    STATIC_CODECAPI_AVDecVideoAcceleration_H264: TGUID = '{f7db8a2f-4f48-4ee8-ae31-8b6ebe558ae2}';
    STATIC_CODECAPI_AVDecVideoAcceleration_VC1: TGUID = '{f7db8a30-4f48-4ee8-ae31-8b6ebe558ae2}';
    STATIC_CODECAPI_AVDecVideoProcDeinterlaceCSC: TGUID = '{f7db8a31-4f48-4ee8-ae31-8b6ebe558ae2}';

    STATIC_CODECAPI_AVDecVideoThumbnailGenerationMode: TGUID = '{2efd8eee-1150-4328-9cf5-66dce933fcf4}';
    STATIC_CODECAPI_AVDecVideoDropPicWithMissingRef: TGUID = '{f8226383-14c2-4567-9734-5004e96ff887}';
    STATIC_CODECAPI_AVDecVideoSoftwareDeinterlaceMode: TGUID = '{0c08d1ce-9ced-4540-bae3-ceb380141109}';
    STATIC_CODECAPI_AVDecVideoFastDecodeMode: TGUID = '{6b529f7d-d3b1-49c6-a999-9ec6911bedbf}';
    STATIC_CODECAPI_AVLowLatencyMode: TGUID = '{9c27891a-ed7a-40e1-88e8-b22727a024ee}';
    STATIC_CODECAPI_AVDecVideoH264ErrorConcealment: TGUID = '{ececace8-3436-462c-9294-cd7bacd758a9}';
    STATIC_CODECAPI_AVDecVideoMPEG2ErrorConcealment: TGUID = '{9d2bfe18-728d-48d2-b358-bc7e436c6674}';
    STATIC_CODECAPI_AVDecVideoCodecType: TGUID = '{434528e5-21f0-46b6-b62c-9b1b6b658cd1}';
    STATIC_CODECAPI_AVDecVideoDXVAMode: TGUID = '{f758f09e-7337-4ae7-8387-73dc2d54e67d}';
    STATIC_CODECAPI_AVDecVideoDXVABusEncryption: TGUID = '{42153c8b-fd0b-4765-a462-ddd9e8bcc388}';
    STATIC_CODECAPI_AVDecVideoSWPowerLevel: TGUID = '{fb5d2347-4dd8-4509-aed0-db5fa9aa93f4}';
    STATIC_CODECAPI_AVDecVideoMaxCodedWidth: TGUID = '{5ae557b8-77af-41f5-9fa6-4db2fe1d4bca}';
    STATIC_CODECAPI_AVDecVideoMaxCodedHeight: TGUID = '{7262a16a-d2dc-4e75-9ba8-65c0c6d32b13}';
    STATIC_CODECAPI_AVDecNumWorkerThreads: TGUID = '{9561c3e8-ea9e-4435-9b1e-a93e691894d8}';
    STATIC_CODECAPI_AVDecSoftwareDynamicFormatChange: TGUID = '{862e2f0a-507b-47ff-af47-01e2624298b7}';
    STATIC_CODECAPI_AVDecDisableVideoPostProcessing: TGUID = '{f8749193-667a-4f2c-a9e8-5d4af924f08f}';

    STATIC_CODECAPI_GUID_AVDecAudioInputWMA: TGUID = '{c95e8dcf-4058-4204-8c42-cb24d91e4b9b}';
    STATIC_CODECAPI_GUID_AVDecAudioInputWMAPro: TGUID = '{0128b7c7-da72-4fe3-bef8-5c52e3557704}';
    STATIC_CODECAPI_GUID_AVDecAudioInputDolby: TGUID = '{8e4228a0-f000-4e0b-8f54-ab8d24ad61a2}';
    STATIC_CODECAPI_GUID_AVDecAudioInputDTS: TGUID = '{600bc0ca-6a1f-4e91-b241-1bbeb1cb19e0}';
    STATIC_CODECAPI_GUID_AVDecAudioInputPCM: TGUID = '{f2421da5-bbb4-4cd5-a996-933c6b5d1347}';
    STATIC_CODECAPI_GUID_AVDecAudioInputMPEG: TGUID = '{91106f36-02c5-4f75-9719-3b7abf75e1f6}';
    STATIC_CODECAPI_GUID_AVDecAudioInputAAC: TGUID = '{97df7828-b94a-47e2-a4bc-51194db22a4d}';
    STATIC_CODECAPI_GUID_AVDecAudioInputHEAAC: TGUID = '{16efb4aa-330e-4f5c-98a8-cf6ac55cbe60}';
    STATIC_CODECAPI_GUID_AVDecAudioInputDolbyDigitalPlus: TGUID = '{0803e185-8f5d-47f5-9908-19a5bbc9fe34}';

    STATIC_CODECAPI_AVDecAACDownmixMode: TGUID = '{01274475-f6bb-4017-b084-81a763c942d4}';
    STATIC_CODECAPI_AVDecHEAACDynamicRangeControl: TGUID = '{287c8abe-69a4-4d39-8080-d3d9712178a0}';

    STATIC_CODECAPI_AVDecAudioDualMono: TGUID = '{4a52cda8-30f8-4216-be0f-ba0b2025921d}';
    STATIC_CODECAPI_AVDecAudioDualMonoReproMode: TGUID = '{a5106186-cc94-4bc9-8cd9-aa2f61f6807e}';

    STATIC_CODECAPI_AVAudioChannelCount: TGUID = '{1d3583c4-1583-474e-b71a-5ee463c198e4}';
    STATIC_CODECAPI_AVAudioChannelConfig: TGUID = '{17f89cb3-c38d-4368-9ede-63b94d177f9f}';
    STATIC_CODECAPI_AVAudioSampleRate: TGUID = '{971d2723-1acb-42e7-855c-520a4b70a5f2}';

    STATIC_CODECAPI_AVDDSurroundMode: TGUID = '{99f2f386-98d1-4452-a163-abc78a6eb770}';
    STATIC_CODECAPI_AVDecDDOperationalMode: TGUID = '{d6d6c6d1-064e-4fdd-a40e-3ecbfcb7ebd0}';
    STATIC_CODECAPI_AVDecDDMatrixDecodingMode: TGUID = '{ddc811a5-04ed-4bf3-a0ca-d00449f9355f}';
    STATIC_CODECAPI_AVDecDDDynamicRangeScaleHigh: TGUID = '{50196c21-1f33-4af5-b296-11426d6c8789}';
    STATIC_CODECAPI_AVDecDDDynamicRangeScaleLow: TGUID = '{044e62e4-11a5-42d5-a3b2-3bb2c7c2d7cf}';
    STATIC_CODECAPI_AVDecDDStereoDownMixMode: TGUID = '{6ce4122c-3ee9-4182-b4ae-c10fc088649d}';

    STATIC_CODECAPI_AVDSPLoudnessEqualization: TGUID = '{8afd1a15-1812-4cbf-9319-433a5b2a3b27}';
    STATIC_CODECAPI_AVDSPSpeakerFill: TGUID = '{5612bca1-56da-4582-8da1-ca8090f92768}';

    STATIC_CODECAPI_AVPriorityControl: TGUID = '{54ba3dc8-bdde-4329-b187-2018bc5c2ba1}';
    STATIC_CODECAPI_AVRealtimeControl: TGUID = '{6f440632-c4ad-4bf7-9e52-456942b454b0}';
    STATIC_CODECAPI_AVEncMaxFrameRate: TGUID = '{b98e1b31-19fa-4d4f-9931-d6a5b8aab93c}';

    STATIC_CODECAPI_AVEncNoInputCopy: TGUID = '{d2b46a2a-e8ee-4ec5-869e-449b6c62c81a}';
    STATIC_CODECAPI_AVEncChromaEncodeMode: TGUID = '{8a47ab5a-4798-4c93-b5a5-554f9a3b9f50}';
    // end of static definitions




    // Common Parameters


    // AVEncCommonFormatConstraint (GUID)

    AVEncCommonFormatConstraint: TGUID = '{57cbb9b8-116f-4951-b40c-c2a035ed8f17}';

    GUID_AVEncCommonFormatUnSpecified: TGUID = '{af46a35a-6024-4525-a48a-094b97f5b3c2}';
    GUID_AVEncCommonFormatDVD_V: TGUID = '{cc9598c4-e7fe-451d-b1ca-761bc840b7f3}';
    GUID_AVEncCommonFormatDVD_DashVR: TGUID = '{e55199d6-044c-4dae-a488-531ed306235b}';
    GUID_AVEncCommonFormatDVD_PlusVR: TGUID = '{e74c6f2e-ec37-478d-9af4-a5e135b6271c}';
    GUID_AVEncCommonFormatVCD: TGUID = '{95035bf7-9d90-40ff-ad5c-5cf8cf71ca1d}';
    GUID_AVEncCommonFormatSVCD: TGUID = '{51d85818-8220-448c-8066-d69bed16c9ad}';
    GUID_AVEncCommonFormatATSC: TGUID = '{8d7b897c-a019-4670-aa76-2edcac7ac296}';
    GUID_AVEncCommonFormatDVB: TGUID = '{71830d8f-6c33-430d-844b-c2705baae6db}';
    GUID_AVEncCommonFormatMP3: TGUID = '{349733cd-eb08-4dc2-8197-e49835ef828b}';
    GUID_AVEncCommonFormatHighMAT: TGUID = '{1eabe760-fb2b-4928-90d1-78db88eee889}';
    GUID_AVEncCommonFormatHighMPV: TGUID = '{a2d25db8-b8f9-42c2-8bc7-0b93cf604788}';

    // AVEncCodecType (GUID)
    AVEncCodecType: TGUID = '{08af4ac1-f3f2-4c74-9dcf-37f2ec79f826}';

    GUID_AVEncMPEG1Video: TGUID = '{c8dafefe-da1e-4774-b27d-11830c16b1fe}';
    GUID_AVEncMPEG2Video: TGUID = '{046dc19a-6677-4aaa-a31d-c1ab716f4560}';
    GUID_AVEncMPEG1Audio: TGUID = '{d4dd1362-cd4a-4cd6-8138-b94db4542b04}';
    GUID_AVEncMPEG2Audio: TGUID = '{ee4cbb1f-9c3f-4770-92b5-fcb7c2a8d381}';
    GUID_AVEncWMV: TGUID = '{4e0fef9b-1d43-41bd-b8bd-4d7bf7457a2a}';
    GUID_AVEndMPEG4Video: TGUID = '{dd37b12a-9503-4f8b-b8d0-324a00c0a1cf}';
    GUID_AVEncH264Video: TGUID = '{95044eab-31b3-47de-8e75-38a42bb03e28}';
    GUID_AVEncDV: TGUID = '{09b769c7-3329-44fb-8954-fa30937d3d5a}';
    GUID_AVEncWMAPro: TGUID = '{1955f90c-33f7-4a68-ab81-53f5657125c4}';
    GUID_AVEncWMALossless: TGUID = '{55ca7265-23d8-4761-9031-b74fbe12f4c1}';
    GUID_AVEncWMAVoice: TGUID = '{13ed18cb-50e8-4276-a288-a6aa228382d9}';
    GUID_AVEncDolbyDigitalPro: TGUID = '{f5be76cc-0ff8-40eb-9cb1-bba94004d44f}';
    GUID_AVEncDolbyDigitalConsumer: TGUID = '{c1a7bf6c-0059-4bfa-94ef-ef747a768d52}';
    GUID_AVEncDolbyDigitalPlus: TGUID = '{698d1b80-f7dd-415c-971c-42492a2056c6}';
    GUID_AVEncDTSHD: TGUID = '{2052e630-469d-4bfb-80ca-1d656e7e918f}';
    GUID_AVEncDTS: TGUID = '{45fbcaa2-5e6e-4ab0-8893-5903bee93acf}';
    GUID_AVEncMLP: TGUID = '{05f73e29-f0d1-431e-a41c-a47432ec5a66}';
    GUID_AVEncPCM: TGUID = '{844be7f4-26cf-4779-b386-cc05d187990c}';
    GUID_AVEncSDDS: TGUID = '{1dc1b82f-11c8-4c71-b7b6-ee3eb9bc2b94}';




    // AVEncCommonRateControlMode (UINT32)
    AVEncCommonRateControlMode: TGUID = '{1c0608e9-370c-4710-8a58-cb6181c42423}';

    // AVEncCommonLowLatency (BOOL)
    AVEncCommonLowLatency: TGUID = '{9d3ecd55-89e8-490a-970a-0c9548d5a56e}';

    // AVEncCommonMultipassMode (UINT32)
    AVEncCommonMultipassMode: TGUID = '{22533d4c-47e1-41b5-9352-a2b7780e7ac4}'; // 22533d4c-47e1-41b5-93-52-a2-b7-78-0e-7a-c4 )

    // AVEncCommonPassStart (UINT32)
    AVEncCommonPassStart: TGUID = '{6a67739f-4eb5-4385-9928-f276a939ef95}'; // 6a67739f-4eb5-4385-99-28-f2-76-a9-39-ef-95 )

    // AVEncCommonPassEnd (UINT32)
    AVEncCommonPassEnd: TGUID = '{0e3d01bc-c85c-467d-8b60-c41012ee3bf6}'; // 0e3d01bc-c85c-467d-8b-60-c4-10-12-ee-3b-f6 )

    // AVEncCommonRealTime (BOOL)
    AVEncCommonRealTime: TGUID = '{143a0ff6-a131-43da-b81e-98fbb8ec378e}'; // 143a0ff6-a131-43da-b8-1e-98-fb-b8-ec-37-8e )

    // AVEncCommonQuality (UINT32)
    AVEncCommonQuality: TGUID = '{fcbf57a3-7ea5-4b0c-9644-69b40c39c391}'; // fcbf57a3-7ea5-4b0c-96-44-69-b4-0c-39-c3-91 )

    // AVEncCommonQualityVsSpeed (UINT32)
    AVEncCommonQualityVsSpeed: TGUID = '{98332df8-03cd-476b-89fa-3f9e442dec9f}'; // 98332df8-03cd-476b-89-fa-3f-9e-44-2d-ec-9f )

    // AVEncCommonTranscodeEncodingProfile (BSTR)
    AVEncCommonTranscodeEncodingProfile: TGUID = '{6947787C-F508-4EA9-B1E9-A1FE3A49FBC9}'; // 6947787C-F508-4EA9-B1-E9-A1-FE-3A-49-FB-C9 )

    // AVEncCommonMeanBitRate (UINT32)
    AVEncCommonMeanBitRate: TGUID = '{f7222374-2144-4815-b550-a37f8e12ee52}'; // f7222374-2144-4815-b5-50-a3-7f-8e-12-ee-52 )

    // AVEncCommonMeanBitRateInterval (UINT64)
    AVEncCommonMeanBitRateInterval: TGUID = '{bfaa2f0c-cb82-4bc0-8474-f06a8a0d0258}'; // bfaa2f0c-cb82-4bc0-84-74-f0-6a-8a-0d-02-58 )

    // AVEncCommonMaxBitRate (UINT32)
    AVEncCommonMaxBitRate: TGUID = '{9651eae4-39b9-4ebf-85ef-d7f444ec7465}'; // 9651eae4-39b9-4ebf-85-ef-d7-f4-44-ec-74-65 )

    // AVEncCommonMinBitRate (UINT32)
    AVEncCommonMinBitRate: TGUID = '{101405b2-2083-4034-a806-efbeddd7c9ff}'; // 101405b2-2083-4034-a8-06-ef-be-dd-d7-c9-ff )

    // AVEncCommonBufferSize (UINT32)
    AVEncCommonBufferSize: TGUID = '{0db96574-b6a4-4c8b-8106-3773de0310cd}'; // 0db96574-b6a4-4c8b-81-06-37-73-de-03-10-cd )

    // AVEncCommonBufferInLevel (UINT32)
    AVEncCommonBufferInLevel: TGUID = '{d9c5c8db-fc74-4064-94e9-cd19f947ed45}'; // d9c5c8db-fc74-4064-94-e9-cd-19-f9-47-ed-45 )

    // AVEncCommonBufferOutLevel (UINT32)
    AVEncCommonBufferOutLevel: TGUID = '{ccae7f49-d0bc-4e3d-a57e-fb5740140069}'; // ccae7f49-d0bc-4e3d-a5-7e-fb-57-40-14-00-69 )

    // AVEncCommonStreamEndHandling (UINT32)
    AVEncCommonStreamEndHandling: TGUID = '{6aad30af-6ba8-4ccc-8fca-18d19beaeb1c}'; // 6aad30af-6ba8-4ccc-8f-ca-18-d1-9b-ea-eb-1c )




    // Common Post Encode Statistical Parameters


    // AVEncStatCommonCompletedPasses (UINT32)
    AVEncStatCommonCompletedPasses: TGUID = '{3e5de533-9df7-438c-854f-9f7dd3683d34}'; // 3e5de533-9df7-438c-85-4f-9f-7d-d3-68-3d-34 )


    // Common Video Parameters


    // AVEncVideoOutputFrameRate (UINT32)
    AVEncVideoOutputFrameRate: TGUID = '{ea85e7c3-9567-4d99-87c4-02c1c278ca7c}'; // ea85e7c3-9567-4d99-87-c4-02-c1-c2-78-ca-7c )

    // AVEncVideoOutputFrameRateConversion (UINT32)
    AVEncVideoOutputFrameRateConversion: TGUID = '{8c068bf4-369a-4ba3-82fd-b2518fb3396e}'; // 8c068bf4-369a-4ba3-82-fd-b2-51-8f-b3-39-6e )



    // AVEncVideoPixelAspectRatio (UINT32 as UINT16/UNIT16) <---- You have WORD in the doc
    AVEncVideoPixelAspectRatio: TGUID = '{3cdc718f-b3e9-4eb6-a57f-cf1f1b321b87}'; // 3cdc718f-b3e9-4eb6-a5-7f-cf-1f-1b-32-1b-87 )

    // AVDecVideoAcceleration_MPEG2 (UINT32)
    AVDecVideoAcceleration_MPEG2: TGUID = '{f7db8a2e-4f48-4ee8-ae31-8b6ebe558ae2}'; // f7db8a2e-4f48-4ee8-ae-31-8b-6e-be-55-8a-e2 )
    AVDecVideoAcceleration_H264: TGUID = '{f7db8a2f-4f48-4ee8-ae31-8b6ebe558ae2}'; // f7db8a2f-4f48-4ee8-ae-31-8b-6e-be-55-8a-e2 )
    AVDecVideoAcceleration_VC1: TGUID = '{f7db8a30-4f48-4ee8-ae31-8b6ebe558ae2}'; // f7db8a30-4f48-4ee8-ae-31-8b-6e-be-55-8a-e2 )

    // AVDecVideoProcDeinterlaceCSC (UINT32)
    AVDecVideoProcDeinterlaceCSC: TGUID = '{f7db8a31-4f48-4ee8-ae31-8b6ebe558ae2}'; // f7db8a31-4f48-4ee8-ae-31-8b-6e-be-55-8a-e2 )


    // AVDecVideoThumbnailGenerationMode (BOOL)
    // Related to video thumbnail generation.
    // Video decoders can have special configurations for fast thumbnail generation.
    // For example:
    //   - They can use only one decoding thread so that multiple instances can be used at the same time.
    //   - They can also decode I frames only.
    AVDecVideoThumbnailGenerationMode: TGUID = '{2EFD8EEE-1150-4328-9CF5-66DCE933FCF4}'; // 2efd8eee-1150-4328-9c-f5-66-dc-e9-33-fc-f4)

    // AVDecVideoMaxCodedWidth and AVDecVideoMaxCodedHeight
    // Maximum codec width and height for current stream.
    // This is used to optimize memory usage for a particular stream.
    AVDecVideoMaxCodedWidth: TGUID = '{5AE557B8-77AF-41f5-9FA6-4DB2FE1D4BCA}'; // 5ae557b8-77af-41f5-9f-a6-4d-b2-fe-1d-4b-ca)
    AVDecVideoMaxCodedHeight: TGUID = '{7262A16A-D2DC-4e75-9BA8-65C0C6D32B13}'; // 7262a16a-d2dc-4e75-9b-a8-65-c0-c6-d3-2b-13)

    // AVDecNumWorkerThreads (INT32)
    // Number of worker threads used in decoder core.
    // If this number is set to -1, it means that the decoder will decide how many threads to create.
    AVDecNumWorkerThreads: TGUID = '{9561C3E8-EA9E-4435-9B1E-A93E691894D8}'; // 9561c3e8-ea9e-4435-9b-1e-a9-3e-69-18-94-d8)

    // AVDecSoftwareDynamicFormatChange (BOOL)
    // Set whether to use software dynamic format change to internal resizing
    AVDecSoftwareDynamicFormatChange: TGUID = '{862E2F0A-507B-47FF-AF47-01E2624298B7}'; // 862e2f0a-507b-47ff-af-47-1-e2-62-42-98-b7)

    // AVDecDisableVideoPostProcessing (UINT32)
    // Default value is 0
    // If this is non-zero, decoder should not do post processing like deblocking/deringing. This only controls the out of loop post processing
    // all processing required by video standard (like in-loop deblocking) should still be performed.
    AVDecDisableVideoPostProcessing: TGUID = '{F8749193-667A-4F2C-A9E8-5D4AF924F08F}'; // f8749193-667a-4f2c-a9-e8-5d-4a-f9-24-f0-8f);

    // AVDecVideoDropPicWithMissingRef (BOOL)
    // Related to Video decoding mode of whether to drop pictures with missing references.
    // For DVD playback, we may want to do so to avoid bad blocking.  For Digital TV, we may
    // want to decode all pictures no matter what.
    AVDecVideoDropPicWithMissingRef: TGUID = '{F8226383-14C2-4567-9734-5004E96FF887}'; // f8226383-14c2-4567-97-34-50-4-e9-6f-f8-87)


    // AVDecSoftwareVideoDeinterlaceMode (UINT32)
    AVDecVideoSoftwareDeinterlaceMode: TGUID = '{0c08d1ce-9ced-4540-bae3-ceb380141109}'; // 0c08d1ce-9ced-4540-ba-e3-ce-b3-80-14-11-09);



    // AVDecVideoFastDecodeMode (UINT32)
    // 0: normal decoding
    // 1-32 : Where 32 is fastest decoding. Any value between (and including) 1 to 32 is valid
    AVDecVideoFastDecodeMode: TGUID = '{6B529F7D-D3B1-49c6-A999-9EC6911BEDBF}'; // 6b529f7d-d3b1-49c6-a9-99-9e-c6-91-1b-ed-bf);



    // AVLowLatencyMode (DWORD)
    // Related to low latency processing/decoding.
    // This GUID lets the application to decrease latency.
    AVLowLatencyMode: TGUID = '{9C27891A-ED7A-40e1-88E8-B22727A024EE}'; // 9c27891a-ed7a-40e1-88-e8-b2-27-27-a0-24-ee)

    // AVDecVideoH264ErrorConcealment (UINT32)
    // Related to Video decoding mode of whether to conceal pictures with corruptions.
    // For DVD playback, we may not want to do so to avoid unnecessary computation.  For Digital TV, we may
    // want to perform error concealment.
    AVDecVideoH264ErrorConcealment: TGUID = '{ECECACE8-3436-462c-9294-CD7BACD758A9}'; // ececace8-3436-462c-92-94-cd-7b-ac-d7-58-a9)




    // AVDecVideoMPEG2ErrorConcealment (UINT32)
    // Related to Video decoding mode of whether to conceal pictures with corruptions.
    // For DVD playback, we may not want to do so to avoid unnecessary computation.  For Digital TV, we may
    // want to perform error concealment.
    AVDecVideoMPEG2ErrorConcealment: TGUID = '{9D2BFE18-728D-48d2-B358-BC7E436C6674}'; // 9d2bfe18-728d-48d2-b3-58-bc-7e-43-6c-66-74)




    // CODECAPI_AVDecVideoCodecType (UINT32)
    AVDecVideoCodecType: TGUID = '{434528E5-21F0-46b6-B62C-9B1B6B658CD1}'; // 434528e5-21f0-46b6-b6-2c-9b-1b-6b-65-8c-d1);



    // CODECAPI_AVDecVideoDXVAMode (UINT32)
    AVDecVideoDXVAMode: TGUID = '{F758F09E-7337-4ae7-8387-73DC2D54E67D}'; // f758f09e-7337-4ae7-83-87-73-dc-2d-54-e6-7d);


    // CODECAPI_AVDecVideoDXVABusEncryption (UINT32)
    AVDecVideoDXVABusEncryption: TGUID = '{42153C8B-FD0B-4765-A462-DDD9E8BCC388}'; // 42153c8b-fd0b-4765-a4-62-dd-d9-e8-bc-c3-88);


    // AVEncVideoForceSourceScanType (UINT32)
    AVEncVideoForceSourceScanType: TGUID = '{1ef2065f-058a-4765-a4fc-8a864c103012}'; // 1ef2065f-058a-4765-a4-fc-8a-86-4c-10-30-12 )

    // AVEncVideoNoOfFieldsToEncode (UINT64)
    AVEncVideoNoOfFieldsToEncode: TGUID = '{61e4bbe2-4ee0-40e7-80ab-51ddeebe6291}'; // 61e4bbe2-4ee0-40e7-80-ab-51-dd-ee-be-62-91 )

    // AVEncVideoNoOfFieldsToSkip (UINT64)
    AVEncVideoNoOfFieldsToSkip: TGUID = '{a97e1240-1427-4c16-a7f7-3dcfd8ba4cc5}'; // a97e1240-1427-4c16-a7-f7-3d-cf-d8-ba-4c-c5 )

    // AVEncVideoEncodeDimension (UINT32)
    AVEncVideoEncodeDimension: TGUID = '{1074df28-7e0f-47a4-a453-cdd73870f5ce}'; // 1074df28-7e0f-47a4-a4-53-cd-d7-38-70-f5-ce )

    // AVEncVideoEncodeOffsetOrigin (UINT32)
    AVEncVideoEncodeOffsetOrigin: TGUID = '{6bc098fe-a71a-4454-852e-4d2ddeb2cd24}'; // 6bc098fe-a71a-4454-85-2e-4d-2d-de-b2-cd-24 )

    // AVEncVideoDisplayDimension (UINT32)
    AVEncVideoDisplayDimension: TGUID = '{de053668-f4ec-47a9-86d0-836770f0c1d5}'; // de053668-f4ec-47a9-86-d0-83-67-70-f0-c1-d5 )

    // AVEncVideoOutputScanType (UINT32)
    AVEncVideoOutputScanType: TGUID = '{460b5576-842e-49ab-a62d-b36f7312c9db}'; // 460b5576-842e-49ab-a6-2d-b3-6f-73-12-c9-db )

    // AVEncVideoInverseTelecineEnable (BOOL)
    AVEncVideoInverseTelecineEnable: TGUID = '{2ea9098b-e76d-4ccd-a030-d3b889c1b64c}'; // 2ea9098b-e76d-4ccd-a0-30-d3-b8-89-c1-b6-4c )

    // AVEncVideoInverseTelecineThreshold (UINT32)
    AVEncVideoInverseTelecineThreshold: TGUID = '{40247d84-e895-497f-b44c-b74560acfe27}'; // 40247d84-e895-497f-b4-4c-b7-45-60-ac-fe-27 )

    // AVEncVideoSourceFilmContent (UINT32)
    AVEncVideoSourceFilmContent: TGUID = '{1791c64b-ccfc-4827-a0ed-2557793b2b1c}'; // 1791c64b-ccfc-4827-a0-ed-25-57-79-3b-2b-1c )

    // AVEncVideoSourceIsBW (BOOL)
    AVEncVideoSourceIsBW: TGUID = '{42ffc49b-1812-4fdc-8d24-7054c521e6eb}'; // 42ffc49b-1812-4fdc-8d-24-70-54-c5-21-e6-eb )

    // AVEncVideoFieldSwap (BOOL)
    AVEncVideoFieldSwap: TGUID = '{fefd7569-4e0a-49f2-9f2b-360ea48c19a2}'; // fefd7569-4e0a-49f2-9f-2b-36-0e-a4-8c-19-a2 )

    // AVEncVideoInputChromaResolution (UINT32)
    // AVEncVideoOutputChromaSubsamplingFormat (UINT32)
    AVEncVideoInputChromaResolution: TGUID = '{bb0cec33-16f1-47b0-8a88-37815bee1739}'; // bb0cec33-16f1-47b0-8a-88-37-81-5b-ee-17-39 )
    AVEncVideoOutputChromaResolution: TGUID = '{6097b4c9-7c1d-4e64-bfcc-9e9765318ae7}'; // 6097b4c9-7c1d-4e64-bf-cc-9e-97-65-31-8a-e7 )

    // AVEncVideoInputChromaSubsampling (UINT32)
    // AVEncVideoOutputChromaSubsampling (UINT32)
    AVEncVideoInputChromaSubsampling: TGUID = '{a8e73a39-4435-4ec3-a6ea-98300f4b36f7}'; // a8e73a39-4435-4ec3-a6-ea-98-30-0f-4b-36-f7 )
    AVEncVideoOutputChromaSubsampling: TGUID = '{fa561c6c-7d17-44f0-83c9-32ed12e96343}'; // fa561c6c-7d17-44f0-83-c9-32-ed-12-e9-63-43 )



    // AVEncVideoInputColorPrimaries (UINT32)
    // AVEncVideoOutputColorPrimaries (UINT32)
    AVEncVideoInputColorPrimaries: TGUID = '{c24d783f-7ce6-4278-90ab-28a4f1e5f86c}'; // c24d783f-7ce6-4278-90-ab-28-a4-f1-e5-f8-6c )
    AVEncVideoOutputColorPrimaries: TGUID = '{be95907c-9d04-4921-8985-a6d6d87d1a6c}'; // be95907c-9d04-4921-89-85-a6-d6-d8-7d-1a-6c )


    // AVEncVideoInputColorTransferFunction (UINT32)
    // AVEncVideoOutputColorTransferFunction (UINT32)
    AVEncVideoInputColorTransferFunction: TGUID = '{8c056111-a9c3-4b08-a0a0-ce13f8a27c75}'; // 8c056111-a9c3-4b08-a0-a0-ce-13-f8-a2-7c-75 )
    AVEncVideoOutputColorTransferFunction: TGUID = '{4a7f884a-ea11-460d-bf57-b88bc75900de}'; // 4a7f884a-ea11-460d-bf-57-b8-8b-c7-59-00-de )

    // AVEncVideoInputColorTransferMatrix (UINT32)
    // AVEncVideoOutputColorTransferMatrix (UINT32)
    AVEncVideoInputColorTransferMatrix: TGUID = '{52ed68b9-72d5-4089-958d-f5405d55081c}'; // 52ed68b9-72d5-4089-95-8d-f5-40-5d-55-08-1c )
    AVEncVideoOutputColorTransferMatrix: TGUID = '{a9b90444-af40-4310-8fbe-ed6d933f892b}'; // a9b90444-af40-4310-8f-be-ed-6d-93-3f-89-2b )

    // AVEncVideoInputColorLighting (UINT32)
    // AVEncVideoOutputColorLighting (UINT32)
    AVEncVideoInputColorLighting: TGUID = '{46a99549-0015-4a45-9c30-1d5cfa258316}'; // 46a99549-0015-4a45-9c-30-1d-5c-fa-25-83-16 )
    AVEncVideoOutputColorLighting: TGUID = '{0e5aaac6-ace6-4c5c-998e-1a8c9c6c0f89}'; // 0e5aaac6-ace6-4c5c-99-8e-1a-8c-9c-6c-0f-89 )

    // AVEncVideoInputColorNominalRange (UINT32)
    // AVEncVideoOutputColorNominalRange (UINT32)
    AVEncVideoInputColorNominalRange: TGUID = '{16cf25c6-a2a6-48e9-ae80-21aec41d427e}'; // 16cf25c6-a2a6-48e9-ae-80-21-ae-c4-1d-42-7e )
    AVEncVideoOutputColorNominalRange: TGUID = '{972835ed-87b5-4e95-9500-c73958566e54}'; // 972835ed-87b5-4e95-95-00-c7-39-58-56-6e-54 )

    // AVEncInputVideoSystem (UINT32)
    AVEncInputVideoSystem: TGUID = '{bede146d-b616-4dc7-92b2-f5d9fa9298f7}'; // bede146d-b616-4dc7-92-b2-f5-d9-fa-92-98-f7 )

    // AVEncVideoHeaderDropFrame (UINT32)
    AVEncVideoHeaderDropFrame: TGUID = '{6ed9e124-7925-43fe-971b-e019f62222b4}'; // 6ed9e124-7925-43fe-97-1b-e0-19-f6-22-22-b4 )

    // AVEncVideoHeaderHours (UINT32)
    AVEncVideoHeaderHours: TGUID = '{2acc7702-e2da-4158-bf9b-88880129d740}'; // 2acc7702-e2da-4158-bf-9b-88-88-01-29-d7-40 )

    // AVEncVideoHeaderMinutes (UINT32)
    AVEncVideoHeaderMinutes: TGUID = '{dc1a99ce-0307-408b-880b-b8348ee8ca7f}'; // dc1a99ce-0307-408b-88-0b-b8-34-8e-e8-ca-7f )

    // AVEncVideoHeaderSeconds (UINT32)
    AVEncVideoHeaderSeconds: TGUID = '{4a2e1a05-a780-4f58-8120-9a449d69656b}'; // 4a2e1a05-a780-4f58-81-20-9a-44-9d-69-65-6b )

    // AVEncVideoHeaderFrames (UINT32)
    AVEncVideoHeaderFrames: TGUID = '{afd5f567-5c1b-4adc-bdaf-735610381436}'; // afd5f567-5c1b-4adc-bd-af-73-56-10-38-14-36 )

    // AVEncVideoDefaultUpperFieldDominant (BOOL)
    AVEncVideoDefaultUpperFieldDominant: TGUID = '{810167c4-0bc1-47ca-8fc2-57055a1474a5}'; // 810167c4-0bc1-47ca-8f-c2-57-05-5a-14-74-a5 )

    // AVEncVideoCBRMotionTradeoff (UINT32)
    AVEncVideoCBRMotionTradeoff: TGUID = '{0d49451e-18d5-4367-a4ef-3240df1693c4}'; // 0d49451e-18d5-4367-a4-ef-32-40-df-16-93-c4 )

    // AVEncVideoCodedVideoAccessUnitSize (UINT32)
    AVEncVideoCodedVideoAccessUnitSize: TGUID = '{b4b10c15-14a7-4ce8-b173-dc90a0b4fcdb}'; // b4b10c15-14a7-4ce8-b1-73-dc-90-a0-b4-fc-db )

    // AVEncVideoMaxKeyframeDistance (UINT32)
    AVEncVideoMaxKeyframeDistance: TGUID = '{2987123a-ba93-4704-b489-ec1e5f25292c}'; // 2987123a-ba93-4704-b4-89-ec-1e-5f-25-29-2c )

    // AVEncH264CABACEnable (BOOL)
    AVEncH264CABACEnable: TGUID = '{EE6CAD62-D305-4248-A50E-E1B255F7CAF8}'; // ee6cad62-d305-4248-a5-e-e1-b2-55-f7-ca-f8 )

    // AVEncVideoContentType (UINT32)
    AVEncVideoContentType: TGUID = '{66117ACA-EB77-459D-930C-A48D9D0683FC}'; // 66117aca-eb77-459d-93-c-a4-8d-9d-6-83-fc )

    // AVEncNumWorkerThreads (UINT32)
    AVEncNumWorkerThreads: TGUID = '{B0C8BF60-16F7-4951-A30B-1DB1609293D6}'; // b0c8bf60-16f7-4951-a3-b-1d-b1-60-92-93-d6 )

    // AVEncVideoEncodeQP (UINT64)
    AVEncVideoEncodeQP: TGUID = '{2cb5696b-23fb-4ce1-a0f9-ef5b90fd55ca}'; // 2cb5696b-23fb-4ce1-a0-f9-ef-5b-90-fd-55-ca )

    // AVEncVideoMinQP (UINT32)
    AVEncVideoMinQP: TGUID = '{0ee22c6a-a37c-4568-b5f1-9d4c2b3ab886}'; // ee22c6a-a37c-4568,  : TGUID = '{b5-f1-9d-4c-2b-3a-b8-86 )

    // AVEncVideoForceKeyFrame (UINT32)
    AVEncVideoForceKeyFrame: TGUID = '{398c1b98-8353-475a-9ef2-8f265d260345}'; // 398c1b98-8353-475a-9e-f2-8f-26-5d-26-3-45 )

    // AVEncH264SPSID (UINT32)
    AVEncH264SPSID: TGUID = '{50f38f51-2b79-40e3-b39c-7e9fa0770501}'; // 50f38f51-2b79-40e3-b3-9c-7e-9f-a0-77-5-1 )

    // AVEncH264PPSID (UINT32)
    AVEncH264PPSID: TGUID = '{BFE29EC2-056C-4D68-A38D-AE5944C8582E}'; // bfe29ec2-56c-4d68-a3-8d-ae-59-44-c8-58-2e )

    // AVEncAdaptiveMode (UINT32)
    AVEncAdaptiveMode: TGUID = '{4419b185-da1f-4f53-bc76-097d0c1efb1e}'; // 4419b185-da1f-4f53-bc-76-9-7d-c-1e-fb-1e )

    // AVScenarioInfo (UINT32)
    AVScenarioInfo: TGUID = '{b28a6e64-3ff9-446a-8a4b-0d7a53413236}'; // b28a6e64-3ff9-446a-8a-4b-0d-7a-53-41-32-36 )

    // AVEncMPVGOPSizeMin (UINT32)
    AVEncMPVGOPSizeMin: TGUID = '{7155cf20-d440-4852-ad0f-9c4abfe37a6a}'; // 7155cf20-d440-4852-ad-0f-9c-4a-bf-e3-7a-6a )

    //AVEncMPVGOPSizeMax (UINT32)
    AVEncMPVGOPSizeMax: TGUID = '{fe7de4c4-1936-4fe2-bdf7-1f18ca1d001f}'; // fe7de4c4-1936-4fe2-bd-f7-1f-18-ca-1d-00-1f )

    // AVEncVideoMaxCTBSize (UINT32)
    AVEncVideoMaxCTBSize: TGUID = '{822363ff-cec8-43e5-92fd-e097488485e9}'; // 822363ff-cec8-43e5-92-fd-e0-97-48-84-85-e9 )

    // AVEncVideoCTBSize (UINT32)
    AVEncVideoCTBSize: TGUID = '{d47db8b2-e73b-4cb9-8c3e-bd877d06d77b}'; // d47db8b2-e73b-4cb9-8c-3e-bd-87-7d-06-d7-7b )

    // VideoEncoderDisplayContentType (UINT32)
    VideoEncoderDisplayContentType: TGUID = '{79b90b27-f4b1-42dc-9dd7-cdaf8135c400}'; // 79b90b27-f4b1-42dc-9d-d7-cd-af-81-35-c4-00 )

    // AVEncEnableVideoProcessing (UINT32)
    AVEncEnableVideoProcessing: TGUID = '{006f4bf6-0ea3-4d42-8702-b5d8be0f7a92}'; // 006f4bf6-0ea3-4d42-87-02-b5-d8-be-0f-7a-92 )

    // AVEncVideoGradualIntraRefresh (UINT32)
    AVEncVideoGradualIntraRefresh: TGUID = '{8f347dee-cb0d-49ba-b462-db6927ee2101}'; // 8f347dee-cb0d-49ba-b4-62-db-69-27-ee-21-01 )

    // GetOPMContext (UINT64)
    GetOPMContext: TGUID = '{2f036c05-4c14-4689-8839-294c6d73e053}'; // 2f036c05-4c14-4689-88-39-29-4c-6d-73-e0-53 )

    // SetHDCPManagerContext (VOID)
    SetHDCPManagerContext: TGUID = '{6d2d1fc8-3dc9-47eb-a1a2-471c80cd60d0}'; // 6d2d1fc8-3dc9-47eb-a1-a2-47-1c-80-cd-60-d0 )

    // AVEncVideoMaxTemporalLayers (UINT32)
    AVEncVideoMaxTemporalLayers: TGUID = '{9c668cfe-08e1-424a-934e-b764b064802a}'; // 9c668cfe-08e1-424a-93-4e-b7-64-b0-64-80-2a )

    // AVEncVideoNumGOPsPerIDR (UINT32)
    AVEncVideoNumGOPsPerIDR: TGUID = '{83bc5bdb-5b89-4521-8f66-33151c373176}'; // 83bc5bdb-5b89-4521-8f-66-33-15-1c-37-31-76 )

    // AVEncCommonAllowFrameDrops (UINT32)
    AVEncCommonAllowFrameDrops: TGUID = '{d8477dcb-9598-48e3-8d0c-752bf206093e}'; // d8477dcb-9598-48e3-8d-0c-75-2b-f2-06-09-3e )

    // AVEncVideoIntraLayerPrediction (UINT32)
    AVEncVideoIntraLayerPrediction: TGUID = '{d3af46b8-bf47-44bb-a283-69f0b0228ff9}'; // d3af46b8-bf47-44bb-a2-83-69-f0-b0-22-8f-f9 )

    // AVEncVideoInstantTemporalUpSwitching (UINT32)
    AVEncVideoInstantTemporalUpSwitching: TGUID = '{a3308307-0d96-4ba4-b1f0-b91a5e49df10}'; // a3308307-0d96-4ba4-b1-f0-b9-1a-5e-49-df-10 )

    // AVEncLowPowerEncoder (UINT32)
    AVEncLowPowerEncoder: TGUID = '{b668d582-8bad-4f6a-9141-375a95358b6d}'; // b668d582-8bad-4f6a-91-41-37-5a-95-35-8b-6d )

    // AVEnableInLoopDeblockFilter (UINT32)
    AVEnableInLoopDeblockFilter: TGUID = '{d2e8e399-0623-4bf3-92a8-4d1818529ded}'; // d2e8e399-0623-4bf3-92-a8-4d-18-18-52-9d-ed )




    // AVEncVideoSelectLayer (UINT32)
    AVEncVideoSelectLayer: TGUID = '{EB1084F5-6AAA-4914-BB2F-6147227F12E7}'; // eb1084f5-6aaa-4914-bb-2f-61-47-22-7f-12-e7 )

    // AVEncVideoTemporalLayerCount (UINT32)
    AVEncVideoTemporalLayerCount: TGUID = '{19CAEBFF-B74D-4CFD-8C27-C2F9D97D5F52}'; // 19caebff-b74d-4cfd-8c-27-c2-f9-d9-7d-5f-52 )

    // AVEncVideoUsage (UINT32)
    AVEncVideoUsage: TGUID = '{1f636849-5dc1-49f1-b1d8-ce3cf62ea385}'; // 1f636849-5dc1-49f1-b1-d8-ce-3c-f6-2e-a3-85 )

    // AVEncVideoRateControlParams (UINT64)
    AVEncVideoRateControlParams: TGUID = '{87D43767-7645-44ec-B438-D3322FBCA29F}'; // 87d43767-7645-44ec-b4-38-d3-32-2f-bc-a2-9f )

    // AVEncVideoSupportedControls (UINT64)
    AVEncVideoSupportedControls: TGUID = '{D3F40FDD-77B9-473d-8196-061259E69CFF}'; // d3f40fdd-77b9-473d-81-96-06-12-59-e6-9c-ff )

    // AVEncVideoEncodeFrameTypeQP (UINT64)
    AVEncVideoEncodeFrameTypeQP: TGUID = '{aa70b610-e03f-450c-ad07-07314e639ce7}'; // aa70b610-e03f-450c-ad-07-07-31-4e-63-9c-e7 )

    // AVEncSliceControlMode (UINT32)
    AVEncSliceControlMode: TGUID = '{e9e782ef-5f18-44c9-a90b-e9c3c2c17b0b}'; // e9e782ef-5f18-44c9-a9-0b-e9-c3-c2-c1-7b-0b )

    // AVEncSliceControlSize (UINT32)
    AVEncSliceControlSize: TGUID = '{92f51df3-07a5-4172-aefe-c69ca3b60e35}'; // 92f51df3-07a5-4172-ae-fe-c6-9c-a3-b6-0e-35 )

    // CODECAPI_AVEncSliceGenerationMode (UINT32)
    AVEncSliceGenerationMode: TGUID = '{8a6bc67f-9497-4286-b46b-02db8d60edbc}'; // 8a6bc67f-9497-4286-b4-6b-02-db-8d-60-ed-bc )

    // AVEncVideoMaxNumRefFrame (UINT32)
    AVEncVideoMaxNumRefFrame: TGUID = '{964829ed-94f9-43b4-b74d-ef40944b69a0}'; // 964829ed-94f9-43b4-b7-4d-ef-40-94-4b-69-a0 )

    // AVEncVideoMeanAbsoluteDifference (UINT32)
    AVEncVideoMeanAbsoluteDifference: TGUID = '{e5c0c10f-81a4-422d-8c3f-b474a4581336}'; // e5c0c10f-81a4-422d-8c-3f-b4-74-a4-58-13-36 )

    // AVEncVideoMaxQP (UINT32)
    AVEncVideoMaxQP: TGUID = '{3daf6f66-a6a7-45e0-a8e5-f2743f46a3a2}'; // 3daf6f66-a6a7-45e0-a8-e5-f2-74-3f-46-a3-a2 )

    // AVEncVideoLTRBufferControl (UINT32)
    AVEncVideoLTRBufferControl: TGUID = '{a4a0e93d-4cbc-444c-89f4-826d310e92a7}'; // a4a0e93d-4cbc-444c-89-f4-82-6d-31-0e-92-a7 )

    // AVEncVideoMarkLTRFrame (UINT32)
    AVEncVideoMarkLTRFrame: TGUID = '{e42f4748-a06d-4ef9-8cea-3d05fde3bd3b}'; // e42f4748-a06d-4ef9-8c-ea-3d-05-fd-e3-bd-3b )

    // AVEncVideoUseLTRFrame (UINT32)
    AVEncVideoUseLTRFrame: TGUID = '{00752db8-55f7-4f80-895b-27639195f2ad}'; // 00752db8-55f7-4f80-89-5b-27-63-91-95-f2-ad )

    // AVEncVideoROIEnabled (UINT32)
    AVEncVideoROIEnabled: TGUID = '{d74f7f18-44dd-4b85-aba3-05d9f42a8280}'; // d74f7f18-44dd-4b85-ab-a3-5-d9-f4-2a-82-80 )

    // AVEncVideoDirtyRectEnabled (UINT32)
    AVEncVideoDirtyRectEnabled: TGUID = '{8acb8fdd-5e0c-4c66-8729-b8f629ab04fb}'; // 8acb8fdd-5e0c-4c66-87-29-b8-f6-29-ab-04-fb )

    // AVEncMaxFrameRate (UINT64)
    AVEncMaxFrameRate: TGUID = '{B98E1B31-19FA-4D4F-9931-D6A5B8AAB93C}'; // b98e1b31-19fa-4d4f-99-31-d6-a5-b8-aa-b9-3c )


    // Audio/Video Mux


    // AVEncMuxOutputStreamType (UINT32)
    AVEncMuxOutputStreamType: TGUID = '{CEDD9E8F-34D3-44db-A1D8-F81520254F3E}'; // cedd9e8f-34d3-44db-a1-d8-f8-15-20-25-4f-3e)




    // Common Post-Encode Video Statistical Parameters


    // AVEncStatVideoOutputFrameRate (UINT32/UINT32)
    AVEncStatVideoOutputFrameRate: TGUID = '{be747849-9ab4-4a63-98fe-f143f04f8ee9}'; // be747849-9ab4-4a63-98-fe-f1-43-f0-4f-8e-e9 )

    // AVEncStatVideoCodedFrames (UINT32)
    AVEncStatVideoCodedFrames: TGUID = '{d47f8d61-6f5a-4a26-bb9f-cd9518462bcd}'; // d47f8d61-6f5a-4a26-bb-9f-cd-95-18-46-2b-cd )

    // AVEncStatVideoTotalFrames (UINT32)
    AVEncStatVideoTotalFrames: TGUID = '{fdaa9916-119a-4222-9ad6-3f7cab99cc8b}'; // fdaa9916-119a-4222-9a-d6-3f-7c-ab-99-cc-8b )


    // Common Audio Parameters


    // AVEncAudioIntervalToEncode (UINT64)
    AVEncAudioIntervalToEncode: TGUID = '{866e4b4d-725a-467c-bb01-b496b23b25f9}'; // 866e4b4d-725a-467c-bb-01-b4-96-b2-3b-25-f9 )

    // AVEncAudioIntervalToSkip (UINT64)
    AVEncAudioIntervalToSkip: TGUID = '{88c15f94-c38c-4796-a9e8-96e967983f26}'; // 88c15f94-c38c-4796-a9-e8-96-e9-67-98-3f-26 )

    // AVEncAudioDualMono (UINT32) - Read/Write
    // Some audio encoders can encode 2 channel input as "dual mono". Use this
    // property to set the appropriate field in the bitstream header to indicate that the
    // 2 channel bitstream is or isn't dual mono.
    // For encoding MPEG audio, use the DualChannel option in AVEncMPACodingMode instead
    AVEncAudioDualMono: TGUID = '{3648126b-a3e8-4329-9b3a-5ce566a43bd3}'; // 3648126b-a3e8-4329-9b-3a-5c-e5-66-a4-3b-d3 )


    // AVEncAudioMeanBitRate (UINT32) - Read/Write - Used to specify audio bitrate (in bits per second) when the encoder is instantiated as an audio+video encoder.
    AVEncAudioMeanBitRate: TGUID = '{921295bb-4fca-4679-aab8-9e2a1d753384}'; // 921295bb-4fca-4679-aa-b8-9e-2a-1d-75-33-84 )

    // AVEncAudioMapDestChannel0..15 (UINT32)
    AVEncAudioMapDestChannel0: TGUID = '{bc5d0b60-df6a-4e16-9803-b82007a30c8d}'; // bc5d0b60-df6a-4e16-98-03-b8-20-07-a3-0c-8d )
    AVEncAudioMapDestChannel1: TGUID = '{bc5d0b61-df6a-4e16-9803-b82007a30c8d}'; // bc5d0b61-df6a-4e16-98-03-b8-20-07-a3-0c-8d )
    AVEncAudioMapDestChannel2: TGUID = '{bc5d0b62-df6a-4e16-9803-b82007a30c8d}'; // bc5d0b62-df6a-4e16-98-03-b8-20-07-a3-0c-8d )
    AVEncAudioMapDestChannel3: TGUID = '{bc5d0b63-df6a-4e16-9803-b82007a30c8d}'; // bc5d0b63-df6a-4e16-98-03-b8-20-07-a3-0c-8d )
    AVEncAudioMapDestChannel4: TGUID = '{bc5d0b64-df6a-4e16-9803-b82007a30c8d}'; // bc5d0b64-df6a-4e16-98-03-b8-20-07-a3-0c-8d )
    AVEncAudioMapDestChannel5: TGUID = '{bc5d0b65-df6a-4e16-9803-b82007a30c8d}'; // bc5d0b65-df6a-4e16-98-03-b8-20-07-a3-0c-8d )
    AVEncAudioMapDestChannel6: TGUID = '{bc5d0b66-df6a-4e16-9803-b82007a30c8d}'; // bc5d0b66-df6a-4e16-98-03-b8-20-07-a3-0c-8d )
    AVEncAudioMapDestChannel7: TGUID = '{bc5d0b67-df6a-4e16-9803-b82007a30c8d}'; // bc5d0b67-df6a-4e16-98-03-b8-20-07-a3-0c-8d )
    AVEncAudioMapDestChannel8: TGUID = '{bc5d0b68-df6a-4e16-9803-b82007a30c8d}'; // bc5d0b68-df6a-4e16-98-03-b8-20-07-a3-0c-8d )
    AVEncAudioMapDestChannel9: TGUID = '{bc5d0b69-df6a-4e16-9803-b82007a30c8d}'; // bc5d0b69-df6a-4e16-98-03-b8-20-07-a3-0c-8d )
    AVEncAudioMapDestChannel10: TGUID = '{bc5d0b6a-df6a-4e16-9803-b82007a30c8d}'; // bc5d0b6a-df6a-4e16-98-03-b8-20-07-a3-0c-8d )
    AVEncAudioMapDestChannel11: TGUID = '{bc5d0b6b-df6a-4e16-9803-b82007a30c8d}'; // bc5d0b6b-df6a-4e16-98-03-b8-20-07-a3-0c-8d )
    AVEncAudioMapDestChannel12: TGUID = '{bc5d0b6c-df6a-4e16-9803-b82007a30c8d}'; // bc5d0b6c-df6a-4e16-98-03-b8-20-07-a3-0c-8d )
    AVEncAudioMapDestChannel13: TGUID = '{bc5d0b6d-df6a-4e16-9803-b82007a30c8d}'; // bc5d0b6d-df6a-4e16-98-03-b8-20-07-a3-0c-8d )
    AVEncAudioMapDestChannel14: TGUID = '{bc5d0b6e-df6a-4e16-9803-b82007a30c8d}'; // bc5d0b6e-df6a-4e16-98-03-b8-20-07-a3-0c-8d )
    AVEncAudioMapDestChannel15: TGUID = '{bc5d0b6f-df6a-4e16-9803-b82007a30c8d}'; // bc5d0b6f-df6a-4e16-98-03-b8-20-07-a3-0c-8d )

    // AVEncAudioInputContent (UINT32) <---- You have ENUM in the doc
    AVEncAudioInputContent: TGUID = '{3e226c2b-60b9-4a39-b00b-a7b40f70d566}'; // 3e226c2b-60b9-4a39-b0-0b-a7-b4-0f-70-d5-66 )



    // Common Post-Encode Audio Statistical Parameters


    // AVEncStatAudioPeakPCMValue (UINT32)
    AVEncStatAudioPeakPCMValue: TGUID = '{dce7fd34-dc00-4c16-821b-35d9eb00fb1a}'; // dce7fd34-dc00-4c16-82-1b-35-d9-eb-00-fb-1a )

    // AVEncStatAudioAveragePCMValue (UINT32)
    AVEncStatAudioAveragePCMValue: TGUID = '{979272f8-d17f-4e32-bb73-4e731c68ba2d}'; // 979272f8-d17f-4e32-bb-73-4e-73-1c-68-ba-2d )

    // AVEncStatAverageBPS (UINT32)
    AVEncStatAudioAverageBPS: TGUID = '{ca6724db-7059-4351-8b43-f82198826a14}'; // ca6724db-7059-4351-8b-43-f8-21-98-82-6a-14 )
    AVEncStatAverageBPS: TGUID = '{ca6724db-7059-4351-8b43-f82198826a14}'; // ca6724db-7059-4351-8b-43-f8-21-98-82-6a-14 )

    // AVEncStatHardwareProcessorUtilitization (UINT32)
    // HW usage % x 1000
    AVEncStatHardwareProcessorUtilitization: TGUID = '{995dc027-cb95-49e6-b91b-5967753cdcb8}'; // 995dc027-cb95-49e6-b9-1b-59-67-75-3c-dc-b8 )

    // AVEncStatHardwareBandwidthUtilitization (UINT32)
    // HW usage % x 1000
    AVEncStatHardwareBandwidthUtilitization: TGUID = '{0124ba9b-dc41-4826-b45f-18ac01b3d5a8}'; // 0124ba9b-dc41-4826-b4-5f-18-ac-01-b3-d5-a8 )


    // MPEG Video Encoding Interface



    // MPV Encoder Specific Parameters


    // AVEncMPVGOPSize (UINT32)
    AVEncMPVGOPSize: TGUID = '{95f31b26-95a4-41aa-9303-246a7fc6eef1}'; // 95f31b26-95a4-41aa-93-03-24-6a-7f-c6-ee-f1 )

    // AVEncMPVGOPOpen (BOOL)
    AVEncMPVGOPOpen: TGUID = '{b1d5d4a6-3300-49b1-ae61-a09937ab0e49}'; // b1d5d4a6-3300-49b1-ae-61-a0-99-37-ab-0e-49 )

    // AVEncMPVDefaultBPictureCount (UINT32)
    AVEncMPVDefaultBPictureCount: TGUID = '{8d390aac-dc5c-4200-b57f-814d04babab2}'; // 8d390aac-dc5c-4200-b5-7f-81-4d-04-ba-ba-b2 )

    // AVEncMPVProfile (UINT32) <---- You have GUID in the doc
    AVEncMPVProfile: TGUID = '{dabb534a-1d99-4284-975a-d90e2239baa1}'; // dabb534a-1d99-4284-97-5a-d9-0e-22-39-ba-a1 )


    // AVEncMPVLevel (UINT32) <---- You have GUID in the doc
    AVEncMPVLevel: TGUID = '{6ee40c40-a60c-41ef-8f50-37c2249e2cb3}'; // 6ee40c40-a60c-41ef-8f-50-37-c2-24-9e-2c-b3 )




    // AVEncMPVFrameFieldMode (UINT32)
    AVEncMPVFrameFieldMode: TGUID = '{acb5de96-7b93-4c2f-8825-b0295fa93bf4}'; // acb5de96-7b93-4c2f-88-25-b0-29-5f-a9-3b-f4 )




    // Advanced MPV Encoder Specific Parameters


    // AVEncMPVAddSeqEndCode (BOOL)
    AVEncMPVAddSeqEndCode: TGUID = '{a823178f-57df-4c7a-b8fd-e5ec8887708d}'; // a823178f-57df-4c7a-b8-fd-e5-ec-88-87-70-8d )

    // AVEncMPVGOPSInSeq (UINT32)
    AVEncMPVGOPSInSeq: TGUID = '{993410d4-2691-4192-9978-98dc2603669f}'; // 993410d4-2691-4192-99-78-98-dc-26-03-66-9f )

    // AVEncMPVUseConcealmentMotionVectors (BOOL)
    AVEncMPVUseConcealmentMotionVectors: TGUID = '{ec770cf3-6908-4b4b-aa30-7fb986214fea}'; // ec770cf3-6908-4b4b-aa-30-7f-b9-86-21-4f-ea )

    // AVEncMPVSceneDetection (UINT32)
    AVEncMPVSceneDetection: TGUID = '{552799f1-db4c-405b-8a3a-c93f2d0674dc}'; // 552799f1-db4c-405b-8a-3a-c9-3f-2d-06-74-dc )



    // AVEncMPVGenerateHeaderSeqExt (BOOL)
    AVEncMPVGenerateHeaderSeqExt: TGUID = '{d5e78611-082d-4e6b-98af-0f51ab139222}'; // d5e78611-082d-4e6b-98-af-0f-51-ab-13-92-22 )

    // AVEncMPVGenerateHeaderSeqDispExt (BOOL)
    AVEncMPVGenerateHeaderSeqDispExt: TGUID = '{6437aa6f-5a3c-4de9-8a16-53d9c4ad326f}'; // 6437aa6f-5a3c-4de9-8a-16-53-d9-c4-ad-32-6f )

    // AVEncMPVGenerateHeaderPicExt (BOOL)
    AVEncMPVGenerateHeaderPicExt: TGUID = '{1b8464ab-944f-45f0-b74e-3a58dad11f37}'; // 1b8464ab-944f-45f0-b7-4e-3a-58-da-d1-1f-37 )

    // AVEncMPVGenerateHeaderPicDispExt (BOOL)
    AVEncMPVGenerateHeaderPicDispExt: TGUID = '{c6412f84-c03f-4f40-a00c-4293df8395bb}'; // c6412f84-c03f-4f40-a0-0c-42-93-df-83-95-bb )

    // AVEncMPVGenerateHeaderSeqScaleExt (BOOL)
    AVEncMPVGenerateHeaderSeqScaleExt: TGUID = '{0722d62f-dd59-4a86-9cd5-644f8e2653d8}'; // 0722d62f-dd59-4a86-9c-d5-64-4f-8e-26-53-d8 )

    // AVEncMPVScanPattern (UINT32)
    AVEncMPVScanPattern: TGUID = '{7f8a478e-7bbb-4ae2-b2fc-96d17fc4a2d6}'; // 7f8a478e-7bbb-4ae2-b2-fc-96-d1-7f-c4-a2-d6 )



    // AVEncMPVIntraDCPrecision (UINT32)
    AVEncMPVIntraDCPrecision: TGUID = '{a0116151-cbc8-4af3-97dc-d00cceb82d79}'; // a0116151-cbc8-4af3-97-dc-d0-0c-ce-b8-2d-79 )

    // AVEncMPVQScaleType (UINT32)
    AVEncMPVQScaleType: TGUID = '{2b79ebb7-f484-4af7-bb58-a2a188c5cbbe}'; // 2b79ebb7-f484-4af7-bb-58-a2-a1-88-c5-cb-be )



    // AVEncMPVIntraVLCTable (UINT32)
    AVEncMPVIntraVLCTable: TGUID = '{a2b83ff5-1a99-405a-af95-c5997d558d3a}'; // a2b83ff5-1a99-405a-af-95-c5-99-7d-55-8d-3a )



    // AVEncMPVQuantMatrixIntra (BYTE[64] encoded as a string of 128 hex digits)
    AVEncMPVQuantMatrixIntra: TGUID = '{9bea04f3-6621-442c-8ba1-3ac378979698}'; // 9bea04f3-6621-442c-8b-a1-3a-c3-78-97-96-98 )

    // AVEncMPVQuantMatrixNonIntra (BYTE[64] encoded as a string of 128 hex digits)
    AVEncMPVQuantMatrixNonIntra: TGUID = '{87f441d8-0997-4beb-a08e-8573d409cf75}'; // 87f441d8-0997-4beb-a0-8e-85-73-d4-09-cf-75 )

    // AVEncMPVQuantMatrixChromaIntra (BYTE[64] encoded as a string of 128 hex digits)
    AVEncMPVQuantMatrixChromaIntra: TGUID = '{9eb9ecd4-018d-4ffd-8f2d-39e49f07b17a}'; // 9eb9ecd4-018d-4ffd-8f-2d-39-e4-9f-07-b1-7a )

    // AVEncMPVQuantMatrixChromaNonIntra (BYTE[64] encoded as a string of 128 hex digits)
    AVEncMPVQuantMatrixChromaNonIntra: TGUID = '{1415b6b1-362a-4338-ba9a-1ef58703c05b}'; // 1415b6b1-362a-4338-ba-9a-1e-f5-87-03-c0-5b )


    // MPEG1 Audio Encoding Interface



    // MPEG1 Audio Specific Parameters


    // AVEncMPALayer (UINT)
    AVEncMPALayer: TGUID = '{9d377230-f91b-453d-9ce0-78445414c22d}'; // 9d377230-f91b-453d-9c-e0-78-44-54-14-c2-2d )



    // AVEncMPACodingMode (UINT)
    AVEncMPACodingMode: TGUID = '{b16ade03-4b93-43d7-a550-90b4fe224537}'; // b16ade03-4b93-43d7-a5-50-90-b4-fe-22-45-37 )



    // AVEncMPACopyright (BOOL) - default state to encode into the stream (may be overridden by input)
    // 1 (true)  - copyright protected
    // 0 (false) - not copyright protected
    AVEncMPACopyright: TGUID = '{a6ae762a-d0a9-4454-b8ef-f2dbeefdd3bd}'; // a6ae762a-d0a9-4454-b8-ef-f2-db-ee-fd-d3-bd )

    // AVEncMPAOriginalBitstream (BOOL) - default value to encode into the stream (may be overridden by input)
    // 1 (true)  - for original bitstream
    // 0 (false) - for copy bitstream
    AVEncMPAOriginalBitstream: TGUID = '{3cfb7855-9cc9-47ff-b829-b36786c92346}'; // 3cfb7855-9cc9-47ff-b8-29-b3-67-86-c9-23-46 )

    // AVEncMPAEnableRedundancyProtection (BOOL)
    // 1 (true)  -  Redundancy should be added to facilitate error detection and concealment (CRC)
    // 0 (false) -  No redundancy should be added
    AVEncMPAEnableRedundancyProtection: TGUID = '{5e54b09e-b2e7-4973-a89b-0b3650a3beda}'; // 5e54b09e-b2e7-4973-a8-9b-0b-36-50-a3-be-da )

    // AVEncMPAPrivateUserBit (UINT) - User data bit value to encode in the stream
    AVEncMPAPrivateUserBit: TGUID = '{afa505ce-c1e3-4e3d-851b-61b700e5e6cc}'; // afa505ce-c1e3-4e3d-85-1b-61-b7-00-e5-e6-cc )

    // AVEncMPAEmphasisType (UINT)
    // Indicates type of de-emphasis filter to be used
    AVEncMPAEmphasisType: TGUID = '{2d59fcda-bf4e-4ed6-b5df-5b03b36b0a1f}'; // 2d59fcda-bf4e-4ed6-b5-df-5b-03-b3-6b-0a-1f )




    // Dolby Digital(TM) Audio Encoding Interface



    // Dolby Digital(TM) Audio Specific Parameters


    // AVEncDDService (UINT)
    AVEncDDService: TGUID = '{d2e1bec7-5172-4d2a-a50e-2f3b82b1ddf8}'; // d2e1bec7-5172-4d2a-a5-0e-2f-3b-82-b1-dd-f8 )



    // AVEncDDDialogNormalization (UINT32)
    AVEncDDDialogNormalization: TGUID = '{d7055acf-f125-437d-a704-79c79f0404a8}'; // d7055acf-f125-437d-a7-04-79-c7-9f-04-04-a8 )

    // AVEncDDCentreDownMixLevel (UINT32)
    AVEncDDCentreDownMixLevel: TGUID = '{e285072c-c958-4a81-afd2-e5e0daf1b148}'; // e285072c-c958-4a81-af-d2-e5-e0-da-f1-b1-48 )

    // AVEncDDSurroundDownMixLevel (UINT32)
    AVEncDDSurroundDownMixLevel: TGUID = '{7b20d6e5-0bcf-4273-a487-506b047997e9}'; // 7b20d6e5-0bcf-4273-a4-87-50-6b-04-79-97-e9 )

    // AVEncDDProductionInfoExists (BOOL)
    AVEncDDProductionInfoExists: TGUID = '{b0b7fe5f-b6ab-4f40-964d-8d91f17c19e8}'; // b0b7fe5f-b6ab-4f40-96-4d-8d-91-f1-7c-19-e8 )

    // AVEncDDProductionRoomType (UINT32)
    AVEncDDProductionRoomType: TGUID = '{dad7ad60-23d8-4ab7-a284-556986d8a6fe}'; // dad7ad60-23d8-4ab7-a2-84-55-69-86-d8-a6-fe )



    // AVEncDDProductionMixLevel (UINT32)
    AVEncDDProductionMixLevel: TGUID = '{301d103a-cbf9-4776-8899-7c15b461ab26}'; // 301d103a-cbf9-4776-88-99-7c-15-b4-61-ab-26 )

    // AVEncDDCopyright (BOOL)
    AVEncDDCopyright: TGUID = '{8694f076-cd75-481d-a5c6-a904dcc828f0}'; // 8694f076-cd75-481d-a5-c6-a9-04-dc-c8-28-f0 )

    // AVEncDDOriginalBitstream (BOOL)
    AVEncDDOriginalBitstream: TGUID = '{966ae800-5bd3-4ff9-95b9-d30566273856}'; // 966ae800-5bd3-4ff9-95-b9-d3-05-66-27-38-56 )

    // AVEncDDDigitalDeemphasis (BOOL)
    AVEncDDDigitalDeemphasis: TGUID = '{e024a2c2-947c-45ac-87d8-f1030c5c0082}'; // e024a2c2-947c-45ac-87-d8-f1-03-0c-5c-00-82 )

    // AVEncDDDCHighPassFilter (BOOL)
    AVEncDDDCHighPassFilter: TGUID = '{9565239f-861c-4ac8-bfda-e00cb4db8548}'; // 9565239f-861c-4ac8-bf-da-e0-0c-b4-db-85-48 )

    // AVEncDDChannelBWLowPassFilter (BOOL)
    AVEncDDChannelBWLowPassFilter: TGUID = '{e197821d-d2e7-43e2-ad2c-00582f518545}'; // e197821d-d2e7-43e2-ad-2c-00-58-2f-51-85-45 )

    // AVEncDDLFELowPassFilter (BOOL)
    AVEncDDLFELowPassFilter: TGUID = '{d3b80f6f-9d15-45e5-91be-019c3fab1f01}'; // d3b80f6f-9d15-45e5-91-be-01-9c-3f-ab-1f-01 )

    // AVEncDDSurround90DegreeePhaseShift (BOOL)
    AVEncDDSurround90DegreeePhaseShift: TGUID = '{25ecec9d-3553-42c0-bb56-d25792104f80}'; // 25ecec9d-3553-42c0-bb-56-d2-57-92-10-4f-80 )

    // AVEncDDSurround3dBAttenuation (BOOL)
    AVEncDDSurround3dBAttenuation: TGUID = '{4d43b99d-31e2-48b9-bf2e-5cbf1a572784}'; // 4d43b99d-31e2-48b9-bf-2e-5c-bf-1a-57-27-84 )

    // AVEncDDDynamicRangeCompressionControl (UINT32)
    AVEncDDDynamicRangeCompressionControl: TGUID = '{cfc2ff6d-79b8-4b8d-a8aa-a0c9bd1c2940}'; // cfc2ff6d-79b8-4b8d-a8-aa-a0-c9-bd-1c-29-40 )



    // AVEncDDRFPreEmphasisFilter (BOOL)
    AVEncDDRFPreEmphasisFilter: TGUID = '{21af44c0-244e-4f3d-a2cc-3d3068b2e73f}'; // 21af44c0-244e-4f3d-a2-cc-3d-30-68-b2-e7-3f )

    // AVEncDDSurroundExMode (UINT32)
    AVEncDDSurroundExMode: TGUID = '{91607cee-dbdd-4eb6-bca2-aadfafa3dd68}'; // 91607cee-dbdd-4eb6-bc-a2-aa-df-af-a3-dd-68 )

    // AVEncDDPreferredStereoDownMixMode (UINT32)
    AVEncDDPreferredStereoDownMixMode: TGUID = '{7f4e6b31-9185-403d-b0a2-763743e6f063}'; // 7f4e6b31-9185-403d-b0-a2-76-37-43-e6-f0-63 )

    // AVEncDDLtRtCenterMixLvl_x10 (INT32)
    AVEncDDLtRtCenterMixLvl_x10: TGUID = '{dca128a2-491f-4600-b2da-76e3344b4197}'; // dca128a2-491f-4600-b2-da-76-e3-34-4b-41-97 )

    // AVEncDDLtRtSurroundMixLvl_x10 (INT32)
    AVEncDDLtRtSurroundMixLvl_x10: TGUID = '{212246c7-3d2c-4dfa-bc21-652a9098690d}'; // 212246c7-3d2c-4dfa-bc-21-65-2a-90-98-69-0d )

    // AVEncDDLoRoCenterMixLvl (INT32)
    AVEncDDLoRoCenterMixLvl_x10: TGUID = '{1cfba222-25b3-4bf4-9bfd-e7111267858c}'; // 1cfba222-25b3-4bf4-9b-fd-e7-11-12-67-85-8c )

    // AVEncDDLoRoSurroundMixLvl_x10 (INT32)
    AVEncDDLoRoSurroundMixLvl_x10: TGUID = '{e725cff6-eb56-40c7-8450-2b9367e91555}'; // e725cff6-eb56-40c7-84-50-2b-93-67-e9-15-55 )

    // AVEncDDAtoDConverterType (UINT32)
    AVEncDDAtoDConverterType: TGUID = '{719f9612-81a1-47e0-9a05-d94ad5fca948}'; // 719f9612-81a1-47e0-9a-05-d9-4a-d5-fc-a9-48 )

    // AVEncDDHeadphoneMode (UINT32)
    AVEncDDHeadphoneMode: TGUID = '{4052dbec-52f5-42f5-9b00-d134b1341b9d}'; // 4052dbec-52f5-42f5-9b-00-d1-34-b1-34-1b-9d )


    // WMV Video Encoding Interface



    // WMV Video Specific Parameters


    // AVEncWMVKeyFrameDistance (UINT32)
    AVEncWMVKeyFrameDistance: TGUID = '{5569055e-e268-4771-b83e-9555ea28aed3}'; // 5569055e-e268-4771-b8-3e-95-55-ea-28-ae-d3 )

    // AVEncWMVInterlacedEncoding (UINT32)
    AVEncWMVInterlacedEncoding: TGUID = '{e3d00f8a-c6f5-4e14-a588-0ec87a726f9b}'; // e3d00f8a-c6f5-4e14-a5-88-0e-c8-7a-72-6f-9b )

    // AVEncWMVDecoderComplexity (UINT32)
    AVEncWMVDecoderComplexity: TGUID = '{f32c0dab-f3cb-4217-b79f-8762768b5f67}'; // f32c0dab-f3cb-4217-b7-9f-87-62-76-8b-5f-67 )

    // AVEncWMVHasKeyFrameBufferLevelMarker (BOOL)
    AVEncWMVKeyFrameBufferLevelMarker: TGUID = '{51ff1115-33ac-426c-a1b1-09321bdf96b4}'; // 51ff1115-33ac-426c-a1-b1-09-32-1b-df-96-b4 )

    // AVEncWMVProduceDummyFrames (UINT32)
    AVEncWMVProduceDummyFrames: TGUID = '{d669d001-183c-42e3-a3ca-2f4586d2396c}'; // d669d001-183c-42e3-a3-ca-2f-45-86-d2-39-6c )


    // WMV Post-Encode Statistical Parameters


    // AVEncStatWMVCBAvg (UINT32/UINT32)
    AVEncStatWMVCBAvg: TGUID = '{6aa6229f-d602-4b9d-b68c-c1ad78884bef}'; // 6aa6229f-d602-4b9d-b6-8c-c1-ad-78-88-4b-ef )

    // AVEncStatWMVCBMax (UINT32/UINT32)
    AVEncStatWMVCBMax: TGUID = '{e976bef8-00fe-44b4-b625-8f238bc03499}'; // e976bef8-00fe-44b4-b6-25-8f-23-8b-c0-34-99 )

    // AVEncStatWMVDecoderComplexityProfile (UINT32)
    AVEncStatWMVDecoderComplexityProfile: TGUID = '{89e69fc3-0f9b-436c-974a-df821227c90d}'; // 89e69fc3-0f9b-436c-97-4a-df-82-12-27-c9-0d )

    // AVEncStatMPVSkippedEmptyFrames (UINT32)
    AVEncStatMPVSkippedEmptyFrames: TGUID = '{32195fd3-590d-4812-a7ed-6d639a1f9711}'; // 32195fd3-590d-4812-a7-ed-6d-63-9a-1f-97-11 )


    // MPEG1/2 Multiplexer Interfaces



    // MPEG1/2 Packetizer Interface


    // Shared with Mux:
    // AVEncMP12MuxEarliestPTS (UINT32)
    // AVEncMP12MuxLargestPacketSize (UINT32)
    // AVEncMP12MuxSysSTDBufferBound (UINT32)

    // AVEncMP12PktzSTDBuffer (UINT32)
    AVEncMP12PktzSTDBuffer: TGUID = '{0b751bd0-819e-478c-9435-75208926b377}'; // 0b751bd0-819e-478c-94-35-75-20-89-26-b3-77 )

    // AVEncMP12PktzStreamID (UINT32)
    AVEncMP12PktzStreamID: TGUID = '{c834d038-f5e8-4408-9b60-88f36493fedf}'; // c834d038-f5e8-4408-9b-60-88-f3-64-93-fe-df )

    // AVEncMP12PktzInitialPTS (UINT32)
    AVEncMP12PktzInitialPTS: TGUID = '{2a4f2065-9a63-4d20-ae22-0a1bc896a315}'; // 2a4f2065-9a63-4d20-ae-22-0a-1b-c8-96-a3-15 )

    // AVEncMP12PktzPacketSize (UINT32)
    AVEncMP12PktzPacketSize: TGUID = '{ab71347a-1332-4dde-a0e5-ccf7da8a0f22}'; // ab71347a-1332-4dde-a0-e5-cc-f7-da-8a-0f-22 )

    // AVEncMP12PktzCopyright (BOOL)
    AVEncMP12PktzCopyright: TGUID = '{c8f4b0c1-094c-43c7-8e68-a595405a6ef8}'; // c8f4b0c1-094c-43c7-8e-68-a5-95-40-5a-6e-f8 )

    // AVEncMP12PktzOriginal (BOOL)
    AVEncMP12PktzOriginal: TGUID = '{6b178416-31b9-4964-94cb-6bff866cdf83}'; // 6b178416-31b9-4964-94-cb-6b-ff-86-6c-df-83 )


    // MPEG1/2 Multiplexer Interface


    // AVEncMP12MuxPacketOverhead (UINT32)
    AVEncMP12MuxPacketOverhead: TGUID = '{e40bd720-3955-4453-acf9-b79132a38fa0}'; // e40bd720-3955-4453-ac-f9-b7-91-32-a3-8f-a0 )

    // AVEncMP12MuxNumStreams (UINT32)
    AVEncMP12MuxNumStreams: TGUID = '{f7164a41-dced-4659-a8f2-fb693f2a4cd0}'; // f7164a41-dced-4659-a8-f2-fb-69-3f-2a-4c-d0 )

    // AVEncMP12MuxEarliestPTS (UINT32)
    AVEncMP12MuxEarliestPTS: TGUID = '{157232b6-f809-474e-9464-a7f93014a817}'; // 157232b6-f809-474e-94-64-a7-f9-30-14-a8-17 )

    // AVEncMP12MuxLargestPacketSize (UINT32)
    AVEncMP12MuxLargestPacketSize: TGUID = '{35ceb711-f461-4b92-a4ef-17b6841ed254}'; // 35ceb711-f461-4b92-a4-ef-17-b6-84-1e-d2-54 )

    // AVEncMP12MuxInitialSCR (UINT32)
    AVEncMP12MuxInitialSCR: TGUID = '{3433ad21-1b91-4a0b-b190-2b77063b63a4}'; // 3433ad21-1b91-4a0b-b1-90-2b-77-06-3b-63-a4 )

    // AVEncMP12MuxMuxRate (UINT32)
    AVEncMP12MuxMuxRate: TGUID = '{ee047c72-4bdb-4a9d-8e21-41926c823da7}'; // ee047c72-4bdb-4a9d-8e-21-41-92-6c-82-3d-a7 )

    // AVEncMP12MuxPackSize (UINT32)
    AVEncMP12MuxPackSize: TGUID = '{f916053a-1ce8-4faf-aa0b-ba31c80034b8}'; // f916053a-1ce8-4faf-aa-0b-ba-31-c8-00-34-b8 )

    // AVEncMP12MuxSysSTDBufferBound (UINT32)
    AVEncMP12MuxSysSTDBufferBound: TGUID = '{35746903-b545-43e7-bb35-c5e0a7d5093c}'; // 35746903-b545-43e7-bb-35-c5-e0-a7-d5-09-3c )

    // AVEncMP12MuxSysRateBound (UINT32)
    AVEncMP12MuxSysRateBound: TGUID = '{05f0428a-ee30-489d-ae28-205c72446710}'; // 05f0428a-ee30-489d-ae-28-20-5c-72-44-67-10 )

    // AVEncMP12MuxTargetPacketizer (UINT32)
    AVEncMP12MuxTargetPacketizer: TGUID = '{d862212a-2015-45dd-9a32-1b3aa88205a0}'; // d862212a-2015-45dd-9a-32-1b-3a-a8-82-05-a0 )

    // AVEncMP12MuxSysFixed (UINT32)
    AVEncMP12MuxSysFixed: TGUID = '{cefb987e-894f-452e-8f89-a4ef8cec063a}'; // cefb987e-894f-452e-8f-89-a4-ef-8c-ec-06-3a )

    // AVEncMP12MuxSysCSPS (UINT32)
    AVEncMP12MuxSysCSPS: TGUID = '{7952ff45-9c0d-4822-bc82-8ad772e02993}'; // 7952ff45-9c0d-4822-bc-82-8a-d7-72-e0-29-93 )

    // AVEncMP12MuxSysVideoLock (BOOL)
    AVEncMP12MuxSysVideoLock: TGUID = '{b8296408-2430-4d37-a2a1-95b3e435a91d}'; // b8296408-2430-4d37-a2-a1-95-b3-e4-35-a9-1d )

    // AVEncMP12MuxSysAudioLock (BOOL)
    AVEncMP12MuxSysAudioLock: TGUID = '{0fbb5752-1d43-47bf-bd79-f2293d8ce337}'; // 0fbb5752-1d43-47bf-bd-79-f2-29-3d-8c-e3-37 )

    // AVEncMP12MuxDVDNavPacks (BOOL)
    AVEncMP12MuxDVDNavPacks: TGUID = '{c7607ced-8cf1-4a99-83a1-ee5461be3574}'; // c7607ced-8cf1-4a99-83-a1-ee-54-61-be-35-74 )


    // Decoding Interface



    // format values are GUIDs as VARIANT BSTRs
    AVDecCommonInputFormat: TGUID = '{E5005239-BD89-4be3-9C0F-5DDE317988CC}'; // e5005239-bd89-4be3-9c-0f-5d-de-31-79-88-cc)
    AVDecCommonOutputFormat: TGUID = '{3c790028-c0ce-4256-b1a2-1b0fc8b1dcdc}'; // 3c790028-c0ce-4256-b1-a2-1b-0f-c8-b1-dc-dc)

    // AVDecCommonMeanBitRate - Mean bitrate in mbits/sec (UINT32)
    AVDecCommonMeanBitRate: TGUID = '{59488217-007A-4f7a-8E41-5C48B1EAC5C6}'; // 59488217-007a-4f7a-8e-41-5c-48-b1-ea-c5-c6)
    // AVDecCommonMeanBitRateInterval - Mean bitrate interval (in 100ns) (UINT64)
    AVDecCommonMeanBitRateInterval: TGUID = '{0EE437C6-38A7-4c5c-944C-68AB42116B85}'; // 0ee437c6-38a7-4c5c-94-4c-68-ab-42-11-6b-85)


    // Audio Decoding Interface


    // Value GUIDS
    // The following 6 GUIDs are values of the AVDecCommonOutputFormat property

    // Stereo PCM output using matrix-encoded stereo down mix (aka Lt/Rt)
    GUID_AVDecAudioOutputFormat_PCM_Stereo_MatrixEncoded: TGUID = '{696E1D30-548F-4036-825F-7026C60011BD}';
    // 696e1d30-548f-4036-82-5f-70-26-c6-00-11-bd)

    // Regular PCM output (any number of channels)
    GUID_AVDecAudioOutputFormat_PCM: TGUID = '{696E1D31-548F-4036-825F-7026C60011BD}'; // 696e1d31-548f-4036-82-5f-70-26-c6-00-11-bd)

    // SPDIF PCM (IEC 60958) stereo output. Type of stereo down mix should
    // be specified by the application.
    GUID_AVDecAudioOutputFormat_SPDIF_PCM: TGUID = '{696E1D32-548F-4036-825F-7026C60011BD}'; // 696e1d32-548f-4036-82-5f-70-26-c6-00-11-bd)

    // SPDIF bitstream (IEC 61937) output, such as AC3, MPEG or DTS.
    GUID_AVDecAudioOutputFormat_SPDIF_Bitstream: TGUID = '{696E1D33-548F-4036-825F-7026C60011BD}'; // 696e1d33-548f-4036-82-5f-70-26-c6-00-11-bd)

    // Stereo PCM output using regular stereo down mix (aka Lo/Ro)
    GUID_AVDecAudioOutputFormat_PCM_Headphones: TGUID = '{696E1D34-548F-4036-825F-7026C60011BD}'; // 696e1d34-548f-4036-82-5f-70-26-c6-00-11-bd)

    // Stereo PCM output using automatic selection of stereo down mix
    // mode (Lo/Ro or Lt/Rt). Use this when the input stream includes
    // information about the preferred downmix mode (such as Annex D of AC3).
    // Default down mix mode should be specified by the application.
    GUID_AVDecAudioOutputFormat_PCM_Stereo_Auto: TGUID = '{696E1D35-548F-4036-825F-7026C60011BD}'; // 696e1d35-548f-4036-82-5f-70-26-c6-00-11-bd)


    // Video Decoder properties


    // AVDecVideoImageSize (UINT32) - High UINT16 width, low UINT16 height
    AVDecVideoImageSize: TGUID = '{5EE5747C-6801-4cab-AAF1-6248FA841BA4}'; // 5ee5747c-6801-4cab-aa-f1-62-48-fa-84-1b-a4)

    // AVDecVideoPixelAspectRatio (UINT32 as UINT16/UNIT16) - High UINT16 width, low UINT16 height
    AVDecVideoPixelAspectRatio: TGUID = '{B0CF8245-F32D-41df-B02C-87BD304D12AB}'; // b0cf8245-f32d-41df-b0-2c-87-bd-30-4d-12-ab)

    // AVDecVideoInputScanType (UINT32)
    AVDecVideoInputScanType: TGUID = '{38477E1F-0EA7-42cd-8CD1-130CED57C580}'; // 38477e1f-0ea7-42cd-8c-d1-13-0c-ed-57-c5-80)


    // AVDecVideoSWPowerLevel (UINT32)
    // Related to video decoder software power saving level in MPEG4 Part 2, VC1 and H264.
    // "SW Power Level" will take a range from 0 to 100 to indicate the current power saving level. 0 - Optimize for battery life, 50 - balanced, 100 - Optimize for video quality.
    AVDecVideoSWPowerLevel: TGUID = '{FB5D2347-4DD8-4509-AED0-DB5FA9AA93F4}'; // fb5d2347-4dd8-4509-ae-d0-db-5f-a9-aa-93-f4)



    // Audio Decoder properties



    GUID_AVDecAudioInputWMA: TGUID = '{C95E8DCF-4058-4204-8C42-CB24D91E4B9B}'; // c95e8dcf-4058-4204-8c-42-cb-24-d9-1e-4b-9b)
    GUID_AVDecAudioInputWMAPro: TGUID = '{0128B7C7-DA72-4fe3-BEF8-5C52E3557704}'; // 0128b7c7-da72-4fe3-be-f8-5c-52-e3-55-77-04)
    GUID_AVDecAudioInputDolby: TGUID = '{8E4228A0-F000-4e0b-8F54-AB8D24AD61A2}'; // 8e4228a0-f000-4e0b-8f-54-ab-8d-24-ad-61-a2)
    GUID_AVDecAudioInputDTS: TGUID = '{600BC0CA-6A1F-4e91-B241-1BBEB1CB19E0}'; // 600bc0ca-6a1f-4e91-b2-41-1b-be-b1-cb-19-e0)
    GUID_AVDecAudioInputPCM: TGUID = '{F2421DA5-BBB4-4cd5-A996-933C6B5D1347}'; // f2421da5-bbb4-4cd5-a9-96-93-3c-6b-5d-13-47)
    GUID_AVDecAudioInputMPEG: TGUID = '{91106F36-02C5-4f75-9719-3B7ABF75E1F6}'; // 91106f36-02c5-4f75-97-19-3b-7a-bf-75-e1-f6)
    GUID_AVDecAudioInputAAC: TGUID = '{97DF7828-B94A-47e2-A4BC-51194DB22A4D}'; // 97df7828-b94a-47e2-a4-bc-51-19-4d-b2-2a-4d)
    GUID_AVDecAudioInputHEAAC: TGUID = '{16EFB4AA-330E-4f5c-98A8-CF6AC55CBE60}'; // 16efb4aa-330e-4f5c-98-a8-cf-6a-c5-5c-be-60)
    GUID_AVDecAudioInputDolbyDigitalPlus: TGUID = '{0803E185-8F5D-47f5-9908-19A5BBC9FE34}'; // 0803e185-8f5d-47f5-99-08-19-a5-bb-c9-fe-34)

    // AVDecAACDownmixMode (UINT32)
    // AAC/HE-AAC Decoder uses standard ISO/IEC MPEG-2/MPEG-4 stereo downmix equations or uses
    // non-standard downmix. An example of a non standard downmix would be the one defined by ARIB document STD-B21 version 4.4.
    AVDecAACDownmixMode: TGUID = '{01274475-F6BB-4017-B084-81A763C942D4}'; // 1274475-f6bb-4017,  : TGUID = '{b0-84-81-a7-63-c9-42-d4)



    // AVDecHEAACDynamicRangeControl (UINT32)
    // Set this property on an AAC/HE-AAC decoder to select whether Dynamic Range Control (DRC) should be applied or not.
    // If DRC is ON and the AAC/HE-AAC stream includes extension payload of type EXT_DYNAMIC_RANGE, DRC will be applied.
    AVDecHEAACDynamicRangeControl: TGUID = '{287C8ABE-69A4-4d39-8080-D3D9712178A0}'; // 287c8abe-69a4-4d39-80-80-d3-d9-71-21-78-a0);



    // AVDecAudioDualMono (UINT32) - Read only
    // The input bitstream header might have a field indicating whether the 2-ch bitstream
    // is dual mono or not. Use this property to read this field.
    // If it's dual mono, the application can set AVDecAudioDualMonoReproMode to determine
    // one of 4 reproduction modes
    AVDecAudioDualMono: TGUID = '{4a52cda8-30f8-4216-be0f-ba0b2025921d}'; // 4a52cda8-30f8-4216-be-0f-ba-0b-20-25-92-1d )



    // AVDecAudioDualMonoReproMode (UINT32)
    // Reproduction modes for programs containing two independent mono channels (Ch1 & Ch2).
    // In case of 2-ch input, the decoder should get AVDecAudioDualMono to check if the input
    // is regular stereo or dual mono. If dual mono, the application can ask the user to set the playback
    // mode by setting AVDecAudioDualReproMonoMode. If output is not stereo, use AVDecDDMatrixDecodingMode or
    // equivalent.
    AVDecAudioDualMonoReproMode: TGUID = '{a5106186-cc94-4bc9-8cd9-aa2f61f6807e}'; // a5106186-cc94-4bc9-8c-d9-aa-2f-61-f6-80-7e )




    // Audio Common Properties


    // AVAudioChannelCount (UINT32)
    // Total number of audio channels, including LFE if it exists.
    AVAudioChannelCount: TGUID = '{1d3583c4-1583-474e-b71a-5ee463c198e4}'; // 1d3583c4-1583-474e-b7-1a-5e-e4-63-c1-98-e4 )

    // AVAudioChannelConfig (UINT32)
    // A bit-wise OR of any number of enum values specified by eAVAudioChannelConfig
    AVAudioChannelConfig: TGUID = '{17f89cb3-c38d-4368-9ede-63b94d177f9f}'; // 17f89cb3-c38d-4368-9e-de-63-b9-4d-17-7f-9f )

    // Enumerated values for  AVAudioChannelConfig are identical
    // to the speaker positions defined in ksmedia.h and used
    // in WAVE_FORMAT_EXTENSIBLE. Configurations for 5.1 and
    // 7.1 channels should be identical to KSAUDIO_SPEAKER_5POINT1_SURROUND
    // and KSAUDIO_SPEAKER_7POINT1_SURROUND in ksmedia.h. This means:
    // 5.1 ch -> LOW_FREQUENCY | FRONT_LEFT | FRONT_RIGHT | FRONT_CENTER | SIDE_LEFT | SIDE_RIGHT
    // 7.1 ch -> LOW_FREQUENCY | FRONT_LEFT | FRONT_RIGHT | FRONT_CENTER | SIDE_LEFT | SIDE_RIGHT | BACK_LEFT | BACK_RIGHT


    // AVAudioSampleRate (UINT32)
    // In samples per second (Hz)
    AVAudioSampleRate: TGUID = '{971d2723-1acb-42e7-855c-520a4b70a5f2}'; // 971d2723-1acb-42e7-85-5c-52-0a-4b-70-a5-f2 )


    // Dolby Digital(TM) Audio Specific Parameters


    // AVDDSurroundMode (UINT32) common to encoder/decoder
    AVDDSurroundMode: TGUID = '{99f2f386-98d1-4452-a163-abc78a6eb770}'; // 99f2f386-98d1-4452-a1-63-ab-c7-8a-6e-b7-70 )



    // AVDecDDOperationalMode (UINT32)
    AVDecDDOperationalMode: TGUID = '{d6d6c6d1-064e-4fdd-a40e-3ecbfcb7ebd0}'; // d6d6c6d1-064e-4fdd-a4-0e-3e-cb-fc-b7-eb-d0 )



    // AVDecDDMatrixDecodingMode(UINT32)
    // A ProLogic decoder has a built-in auto-detection feature. When the Dolby Digital decoder
    // is set to the 6-channel output configuration and it is fed a 2/0 bit stream to decode, it can
    // do one of the following:
    // a) decode the bit stream and output it on the two front channels (eAVDecDDMatrixDecodingMode_OFF),
    // b) decode the bit stream followed by ProLogic decoding to create 6-channels (eAVDecDDMatrixDecodingMode_ON).
    // c) the decoder will look at the Surround bit ("dsurmod") in the bit stream to determine whether
    //    apply ProLogic decoding or not (eAVDecDDMatrixDecodingMode_AUTO).
    AVDecDDMatrixDecodingMode: TGUID = '{ddc811a5-04ed-4bf3-a0ca-d00449f9355f}'; // ddc811a5-04ed-4bf3-a0-ca-d0-04-49-f9-35-5f )


    // AVDecDDDynamicRangeScaleHigh (UINT32)
    // Indicates what fraction of the dynamic range compression
    // to apply. Relevant for negative values of dynrng only.
    // Linear range 0-100, where:
    //   0 - No dynamic range compression (preserve full dynamic range)
    // 100 - Apply full dynamic range compression
    AVDecDDDynamicRangeScaleHigh: TGUID = '{50196c21-1f33-4af5-b296-11426d6c8789}'; // 50196c21-1f33-4af5-b2-96-11-42-6d-6c-87-89 )


    // AVDecDDDynamicRangeScaleLow (UINT32)
    // Indicates what fraction of the dynamic range compression
    // to apply. Relevant for positive values of dynrng only.
    // Linear range 0-100, where:
    //   0 - No dynamic range compression (preserve full dynamic range)
    // 100 - Apply full dynamic range compression
    AVDecDDDynamicRangeScaleLow: TGUID = '{044e62e4-11a5-42d5-a3b2-3bb2c7c2d7cf}'; // 044e62e4-11a5-42d5-a3-b2-3b-b2-c7-c2-d7-cf )


    // AVDecDDStereoDownMixMode (UINT32)
    // A Dolby Digital Decoder may apply stereo downmix in one of several ways, after decoding multichannel PCM.
    // Use one of the UINT32 values specified by eAVDecDDStereoDownMixMode to set stereo downmix mode.
    // Only relevant when the decoder's output is set to stereo.
    AVDecDDStereoDownMixMode: TGUID = '{6CE4122C-3EE9-4182-B4AE-C10FC088649D}'; // 6ce4122c-3ee9-4182-b4-ae-c1-0f-c0-88-64-9d )



    // AVDSPLoudnessEqualization (UINT32)
    // Related to audio digital signal processing (DSP).
    // Apply "Loudness Equalization" to the audio stream, so users will not have to adjust volume control when audio stream changes.
    AVDSPLoudnessEqualization: TGUID = '{8AFD1A15-1812-4cbf-9319-433A5B2A3B27}'; // 8afd1a15-1812-4cbf-93-19-43-3a-5b-2a-3b-27)



    // AVDSPSpeakerFill (UINT32)
    // Related to audio digital signal processing (DSP).
    // "Speaker Fill" will take a mono or stereo audio stream and convert it to a multi channel (e.g. 5.1) audio stream.
    AVDSPSpeakerFill: TGUID = '{5612BCA1-56DA-4582-8DA1-CA8090F92768}'; // 5612bca1-56da-4582-8d-a1-ca-80-90-f9-27-68)



    // AVPriorityControl (UINT32)
    // Indicates the task priority when not realtime (0..15)
    // Linear range 0-15, where:
    //   0 - idle
    // 15 - Highest
    AVPriorityControl: TGUID = '{54ba3dc8-bdde-4329-b187-2018bc5c2ba1}'; // 54ba3dc8-bdde-4329-b1-87-20-18-bc-5c-2b-a1 )

    // AVRealtimeControl (UINT32)
    // Indicates the task is realtime or not
    // Linear range 0-1, where:
    //   0 - no realtime
    //   1 - realtime
    AVRealtimeControl: TGUID = '{6f440632-c4ad-4bf7-9e52-456942b454b0}'; // 6f440632-c4ad-4bf7-9e-52-45-69-42-b4-54-b0 )

    // AVEncNoInputCopy (UINT32)
    // Enables the encoder to avoid copying the input buffer
    // 0 - default behavior (copy input buffer to encoder internal buffer)
    // 1 - use input buffer directly
    // Input color space must be IYUV or YV12 for this to be effective.  Input buffers must be fully contiguous.  Input buffers
    // must be macroblock-aligned (width and height divisible by 16).
    AVEncNoInputCopy: TGUID = '{d2b46a2a-e8ee-4ec5-869e-449b6c62c81a}'; // d2b46a2a-e8ee-4ec5-86-9e-44-9b-6c-62-c8-1a )

    // AVEncChromaEncodeMode (UINT32)
    // Change the mode used to encode chroma-only frames
    // A member of the eAVChromaEncodeMode structure, where:
    //   eAVChromaEncodeMode_420 - default encoding
    //   eAVChromaEncodeMode_444 - enhanced encoding of chroma for repeated input frames
    //   eAVChromaEncodeMode_444_v2 - encoder will skip non-chroma macroblocks, in addition to functionality for eAVChromaEncodeMode_444

    AVEncChromaEncodeMode: TGUID = '{8a47ab5a-4798-4c93-b5a5-554f9a3b9f50}'; // 8a47ab5a-4798-4c93-b5-a5-55-4f-9a-3b-9f-50 )

const
    AVENC_H263V_LEVELCOUNT = 8;
    AVENC_H264V_LEVELCOUNT = 16;
    AVENC_H264V_MAX_MBBITS = 3200; //Only applies to Baseline, Main, Extended profiles

type
    eAVEncCommonRateControlMode = (
        eAVEncCommonRateControlMode_CBR = 0,
        eAVEncCommonRateControlMode_PeakConstrainedVBR = 1,
        eAVEncCommonRateControlMode_UnconstrainedVBR = 2,
        eAVEncCommonRateControlMode_Quality = 3,
        eAVEncCommonRateControlMode_LowDelayVBR = 4,
        eAVEncCommonRateControlMode_GlobalVBR = 5,
        eAVEncCommonRateControlMode_GlobalLowDelayVBR = 6);

    eAVEncCommonStreamEndHandling = (
        eAVEncCommonStreamEndHandling_DiscardPartial = 0,
        eAVEncCommonStreamEndHandling_EnsureComplete = 1);


    eAVEncVideoOutputFrameRateConversion = (
        eAVEncVideoOutputFrameRateConversion_Disable = 0,
        eAVEncVideoOutputFrameRateConversion_Enable = 1,
        eAVEncVideoOutputFrameRateConversion_Alias = 2);

    eAVDecVideoSoftwareDeinterlaceMode = (
        eAVDecVideoSoftwareDeinterlaceMode_NoDeinterlacing = 0, // do not use software deinterlace
        eAVDecVideoSoftwareDeinterlaceMode_ProgressiveDeinterlacing = 1, // Use progressive deinterlace
        eAVDecVideoSoftwareDeinterlaceMode_BOBDeinterlacing = 2, // BOB deinterlacing
        eAVDecVideoSoftwareDeinterlaceMode_SmartBOBDeinterlacing = 3  // Smart BOB deinterlacing
        );

    eAVFastDecodeMode = (
        eVideoDecodeCompliant = 0,
        eVideoDecodeOptimalLF = 1, // Optimal Loop Filter
        eVideoDecodeDisableLF = 2, // Disable Loop Filter
        eVideoDecodeFastest = 32
        );

    eAVDecVideoH264ErrorConcealment = (
        eErrorConcealmentTypeDrop = 0,  // ERR_CONCEALMENT_TYPE_DROP
        eErrorConcealmentTypeBasic = 1,  // ERR_CONCEALMENT_TYPE_BASIC  (the default, and good mode used most of the time)
        eErrorConcealmentTypeAdvanced = 2,  // ERR_CONCEALMENT_TYPE_ADVANCED
        eErrorConcealmentTypeDXVASetBlack = 3  // ERR_CONCEALMENT_TYPE_DXVA_SET_BLACK
        );

    eAVDecVideoMPEG2ErrorConcealment = (
        eErrorConcealmentOff = 0,
        eErrorConcealmentOn = 1  //  the default and good mode used most of the time
        );


    eAVDecVideoCodecType = (
        eAVDecVideoCodecType_NOTPLAYING = 0,
        eAVDecVideoCodecType_MPEG2 = 1,
        eAVDecVideoCodecType_H264 = 2);


    eAVDecVideoDXVAMode = (
        eAVDecVideoDXVAMode_NOTPLAYING = 0,
        eAVDecVideoDXVAMode_SW = 1,
        eAVDecVideoDXVAMode_MC = 2,
        eAVDecVideoDXVAMode_IDCT = 3,
        eAVDecVideoDXVAMode_VLD = 4);


    eAVDecVideoDXVABusEncryption = (
        eAVDecVideoDXVABusEncryption_NONE = 0,
        eAVDecVideoDXVABusEncryption_PRIVATE = 1,
        eAVDecVideoDXVABusEncryption_AES = 2);


    eAVEncVideoSourceScanType = (
        eAVEncVideoSourceScan_Automatic = 0,
        eAVEncVideoSourceScan_Interlaced = 1,
        eAVEncVideoSourceScan_Progressive = 2
        );

    eAVEncVideoOutputScanType = (
        eAVEncVideoOutputScan_Progressive = 0,
        eAVEncVideoOutputScan_Interlaced = 1,
        eAVEncVideoOutputScan_SameAsInput = 2,
        eAVEncVideoOutputScan_Automatic = 3);



    eAVEncVideoFilmContent = (
        eAVEncVideoFilmContent_VideoOnly = 0,
        eAVEncVideoFilmContent_FilmOnly = 1,
        eAVEncVideoFilmContent_Mixed = 2);


    eAVEncVideoChromaResolution = (
        eAVEncVideoChromaResolution_SameAsSource = 0,
        eAVEncVideoChromaResolution_444 = 1,
        eAVEncVideoChromaResolution_422 = 2,
        eAVEncVideoChromaResolution_420 = 3,
        eAVEncVideoChromaResolution_411 = 4);


    eAVEncVideoChromaSubsampling = (
        eAVEncVideoChromaSubsamplingFormat_SameAsSource = 0,
        eAVEncVideoChromaSubsamplingFormat_ProgressiveChroma = $8,
        eAVEncVideoChromaSubsamplingFormat_Horizontally_Cosited = $4,
        eAVEncVideoChromaSubsamplingFormat_Vertically_Cosited = $2,
        eAVEncVideoChromaSubsamplingFormat_Vertically_AlignedChromaPlanes = $1
        );


    eAVEncVideoColorPrimaries = (
        eAVEncVideoColorPrimaries_SameAsSource = 0,
        eAVEncVideoColorPrimaries_Reserved = 1,
        eAVEncVideoColorPrimaries_BT709 = 2,
        eAVEncVideoColorPrimaries_BT470_2_SysM = 3,
        eAVEncVideoColorPrimaries_BT470_2_SysBG = 4,
        eAVEncVideoColorPrimaries_SMPTE170M = 5,
        eAVEncVideoColorPrimaries_SMPTE240M = 6,
        eAVEncVideoColorPrimaries_EBU3231 = 7,
        eAVEncVideoColorPrimaries_SMPTE_C = 8);

    eAVEncVideoColorTransferFunction = (
        eAVEncVideoColorTransferFunction_SameAsSource = 0,
        eAVEncVideoColorTransferFunction_10 = 1,  // (Linear, scRGB)
        eAVEncVideoColorTransferFunction_18 = 2,
        eAVEncVideoColorTransferFunction_20 = 3,
        eAVEncVideoColorTransferFunction_22 = 4,  // (BT470-2 SysM)
        eAVEncVideoColorTransferFunction_22_709 = 5,  // (BT709,  SMPTE296M, SMPTE170M, BT470, SMPTE274M, BT.1361)
        eAVEncVideoColorTransferFunction_22_240M = 6,  // (SMPTE240M, interim 274M)
        eAVEncVideoColorTransferFunction_22_8bit_sRGB = 7,  // (sRGB)
        eAVEncVideoColorTransferFunction_28 = 8
        );


    eAVEncVideoColorTransferMatrix = (
        eAVEncVideoColorTransferMatrix_SameAsSource = 0,
        eAVEncVideoColorTransferMatrix_BT709 = 1,
        eAVEncVideoColorTransferMatrix_BT601 = 2,  // (601, BT470-2 B,B, 170M)
        eAVEncVideoColorTransferMatrix_SMPTE240M = 3);

    eAVEncVideoColorLighting = (
        eAVEncVideoColorLighting_SameAsSource = 0,
        eAVEncVideoColorLighting_Unknown = 1,
        eAVEncVideoColorLighting_Bright = 2,
        eAVEncVideoColorLighting_Office = 3,
        eAVEncVideoColorLighting_Dim = 4,
        eAVEncVideoColorLighting_Dark = 5);


    eAVEncVideoColorNominalRange = (
        eAVEncVideoColorNominalRange_SameAsSource = 0,
        eAVEncVideoColorNominalRange_0_255 = 1,  // (8 bit: 0..255, 10 bit: 0..1023)
        eAVEncVideoColorNominalRange_16_235 = 2,  // (16..235, 64..940 (16*4...235*4)
        eAVEncVideoColorNominalRange_48_208 = 3   // (48..208)
        );


    eAVEncInputVideoSystem = (
        eAVEncInputVideoSystem_Unspecified = 0,
        eAVEncInputVideoSystem_PAL = 1,
        eAVEncInputVideoSystem_NTSC = 2,
        eAVEncInputVideoSystem_SECAM = 3,
        eAVEncInputVideoSystem_MAC = 4,
        eAVEncInputVideoSystem_HDV = 5,
        eAVEncInputVideoSystem_Component = 6);


    eAVEncVideoContentType = (
        eAVEncVideoContentType_Unknown = 0,
        eAVEncVideoContentType_FixedCameraAngle = 1);

    eAVEncAdaptiveMode = (
        eAVEncAdaptiveMode_None = 0,
        eAVEncAdaptiveMode_Resolution = 1,
        eAVEncAdaptiveMode_FrameRate = 2
        );

    eAVScenarioInfo = (
        eAVScenarioInfo_Unknown = 0,
        eAVScenarioInfo_DisplayRemoting = 1,
        eAVScenarioInfo_VideoConference = 2,
        eAVScenarioInfo_Archive = 3,
        eAVScenarioInfo_LiveStreaming = 4,
        eAVScenarioInfo_CameraRecord = 5,
        eAVScenarioInfo_DisplayRemotingWithFeatureMap = 6);

    eVideoEncoderDisplayContentType = (
        eVideoEncoderDisplayContent_Unknown = 0,
        eVideoEncoderDisplayContent_FullScreenVideo = 1);


    eAVEncMuxOutput = (
        eAVEncMuxOutputAuto = 0, // Decision is made automatically be the mux (elementary stream, program stream or transport stream)
        eAVEncMuxOutputPS = 1, // Program stream
        eAVEncMuxOutputTS = 2  // Transport stream
        );

    eAVEncAudioDualMono = (
        eAVEncAudioDualMono_SameAsInput = 0, // As indicated by input media type
        eAVEncAudioDualMono_Off = 1,  // 2-ch output bitstream should not be dual mono
        eAVEncAudioDualMono_On = 2   // 2-ch output bitstream should be dual mono
        );


    eAVEncAudioInputContent = (
        AVEncAudioInputContent_Unknown = 0,
        AVEncAudioInputContent_Voice = 1,
        AVEncAudioInputContent_Music = 2);

    eAVEncMPVProfile = (
        eAVEncMPVProfile_unknown = 0,
        eAVEncMPVProfile_Simple = 1,
        eAVEncMPVProfile_Main = 2,
        eAVEncMPVProfile_High = 3,
        eAVEncMPVProfile_422 = 4);

    eAVEncMPVLevel = (
        eAVEncMPVLevel_Low = 1,
        eAVEncMPVLevel_Main = 2,
        eAVEncMPVLevel_High1440 = 3,
        eAVEncMPVLevel_High = 4);

    eAVEncH263VProfile = (
        eAVEncH263VProfile_Base = 0,
        eAVEncH263VProfile_CompatibilityV2 = 1,
        eAVEncH263VProfile_CompatibilityV1 = 2,
        eAVEncH263VProfile_WirelessV2 = 3,
        eAVEncH263VProfile_WirelessV3 = 4,
        eAVEncH263VProfile_HighCompression = 5,
        eAVEncH263VProfile_Internet = 6,
        eAVEncH263VProfile_Interlace = 7,
        eAVEncH263VProfile_HighLatency = 8);

    eAVEncH264VProfile = (
        eAVEncH264VProfile_unknown = 0,
        eAVEncH264VProfile_Simple = 66,
        eAVEncH264VProfile_Base = 66,
        eAVEncH264VProfile_Main = 77,
        eAVEncH264VProfile_High = 100,
        eAVEncH264VProfile_422 = 122,
        eAVEncH264VProfile_High10 = 110,
        eAVEncH264VProfile_444 = 244,
        eAVEncH264VProfile_Extended = 88,

        // UVC 1.2 H.264 extension
        eAVEncH264VProfile_ScalableBase = 83,
        eAVEncH264VProfile_ScalableHigh = 86,
        eAVEncH264VProfile_MultiviewHigh = 118,
        eAVEncH264VProfile_StereoHigh = 128,
        eAVEncH264VProfile_ConstrainedBase = 256,
        eAVEncH264VProfile_UCConstrainedHigh = 257,
        eAVEncH264VProfile_ConstrainedHigh = 257,
        eAVEncH264VProfile_UCScalableConstrainedBase = 258,
        eAVEncH264VProfile_UCScalableConstrainedHigh = 259);


    eAVEncH265VProfile = (
        eAVEncH265VProfile_unknown = 0,
        eAVEncH265VProfile_Main_420_8 = 1,
        eAVEncH265VProfile_Main_420_10 = 2,
        eAVEncH265VProfile_Main_420_12 = 3,
        eAVEncH265VProfile_Main_422_10 = 4,
        eAVEncH265VProfile_Main_422_12 = 5,
        eAVEncH265VProfile_Main_444_8 = 6,
        eAVEncH265VProfile_Main_444_10 = 7,
        eAVEncH265VProfile_Main_444_12 = 8,
        eAVEncH265VProfile_Monochrome_12 = 9,
        eAVEncH265VProfile_Monochrome_16 = 10,
        eAVEncH265VProfile_MainIntra_420_8 = 11,
        eAVEncH265VProfile_MainIntra_420_10 = 12,
        eAVEncH265VProfile_MainIntra_420_12 = 13,
        eAVEncH265VProfile_MainIntra_422_10 = 14,
        eAVEncH265VProfile_MainIntra_422_12 = 15,
        eAVEncH265VProfile_MainIntra_444_8 = 16,
        eAVEncH265VProfile_MainIntra_444_10 = 17,
        eAVEncH265VProfile_MainIntra_444_12 = 18,
        eAVEncH265VProfile_MainIntra_444_16 = 19,
        eAVEncH265VProfile_MainStill_420_8 = 20,
        eAVEncH265VProfile_MainStill_444_8 = 21,
        eAVEncH265VProfile_MainStill_444_16 = 22);

    eAVEncVP9VProfile = (
        eAVEncVP9VProfile_unknown = 0,
        eAVEncVP9VProfile_420_8 = 1,
        eAVEncVP9VProfile_420_10 = 2,
        eAVEncVP9VProfile_420_12 = 3);

    eAVEncH263PictureType = (
        eAVEncH263PictureType_I = 0,
        eAVEncH263PictureType_P,
        eAVEncH263PictureType_B);

    eAVEncH264PictureType = (
        eAVEncH264PictureType_IDR = 0,
        eAVEncH264PictureType_P,
        eAVEncH264PictureType_B);

    eAVEncH263VLevel = (
        eAVEncH263VLevel1 = 10,
        eAVEncH263VLevel2 = 20,
        eAVEncH263VLevel3 = 30,
        eAVEncH263VLevel4 = 40,
        eAVEncH263VLevel4_5 = 45,
        eAVEncH263VLevel5 = 50,
        eAVEncH263VLevel6 = 60,
        eAVEncH263VLevel7 = 70);


    eAVEncH264VLevel = (
        eAVEncH264VLevel1 = 10,
        eAVEncH264VLevel1_b = 11,
        eAVEncH264VLevel1_1 = 11,
        eAVEncH264VLevel1_2 = 12,
        eAVEncH264VLevel1_3 = 13,
        eAVEncH264VLevel2 = 20,
        eAVEncH264VLevel2_1 = 21,
        eAVEncH264VLevel2_2 = 22,
        eAVEncH264VLevel3 = 30,
        eAVEncH264VLevel3_1 = 31,
        eAVEncH264VLevel3_2 = 32,
        eAVEncH264VLevel4 = 40,
        eAVEncH264VLevel4_1 = 41,
        eAVEncH264VLevel4_2 = 42,
        eAVEncH264VLevel5 = 50,
        eAVEncH264VLevel5_1 = 51,
        eAVEncH264VLevel5_2 = 52);

    eAVEncH265VLevel = (
        eAVEncH265VLevel1 = 30,
        eAVEncH265VLevel2 = 60,
        eAVEncH265VLevel2_1 = 63,
        eAVEncH265VLevel3 = 90,
        eAVEncH265VLevel3_1 = 93,
        eAVEncH265VLevel4 = 120,
        eAVEncH265VLevel4_1 = 123,
        eAVEncH265VLevel5 = 150,
        eAVEncH265VLevel5_1 = 153,
        eAVEncH265VLevel5_2 = 156,
        eAVEncH265VLevel6 = 180,
        eAVEncH265VLevel6_1 = 183,
        eAVEncH265VLevel6_2 = 186);

    eAVEncMPVFrameFieldMode = (
        eAVEncMPVFrameFieldMode_FieldMode = 0,
        eAVEncMPVFrameFieldMode_FrameMode = 1);

    eAVEncMPVSceneDetection = (
        eAVEncMPVSceneDetection_None = 0,
        eAVEncMPVSceneDetection_InsertIPicture = 1,
        eAVEncMPVSceneDetection_StartNewGOP = 2,
        eAVEncMPVSceneDetection_StartNewLocatableGOP = 3
        );

    eAVEncMPVScanPattern = (
        eAVEncMPVScanPattern_Auto = 0,
        eAVEncMPVScanPattern_ZigZagScan = 1,
        eAVEncMPVScanPattern_AlternateScan = 2);

    eAVEncMPVQScaleType = (
        eAVEncMPVQScaleType_Auto = 0,
        eAVEncMPVQScaleType_Linear = 1,
        eAVEncMPVQScaleType_NonLinear = 2);

    eAVEncMPVIntraVLCTable = (
        eAVEncMPVIntraVLCTable_Auto = 0,
        eAVEncMPVIntraVLCTable_MPEG1 = 1,
        eAVEncMPVIntraVLCTable_Alternate = 2);



    eAVEncMPALayer = (
        eAVEncMPALayer_1 = 1,
        eAVEncMPALayer_2 = 2,
        eAVEncMPALayer_3 = 3);


    eAVEncMPACodingMode = (
        eAVEncMPACodingMode_Mono = 0,
        eAVEncMPACodingMode_Stereo = 1,
        eAVEncMPACodingMode_DualChannel = 2,
        eAVEncMPACodingMode_JointStereo = 3,
        eAVEncMPACodingMode_Surround = 4);

    eAVEncMPAEmphasisType = (
        eAVEncMPAEmphasisType_None = 0,
        eAVEncMPAEmphasisType_50_15 = 1,
        eAVEncMPAEmphasisType_Reserved = 2,
        eAVEncMPAEmphasisType_CCITT_J17 = 3);

    eAVEncDDService = (
        eAVEncDDService_CM = 0,  // (Main Service: Complete Main)
        eAVEncDDService_ME = 1,  // (Main Service: Music and Effects (ME))
        eAVEncDDService_VI = 2,  // (Associated Service: Visually-Impaired (VI)
        eAVEncDDService_HI = 3,  // (Associated Service: Hearing-Impaired (HI))
        eAVEncDDService_D = 4,  // (Associated Service: Dialog (D))
        eAVEncDDService_C = 5,  // (Associated Service: Commentary (C))
        eAVEncDDService_E = 6,  // (Associated Service: Emergency (E))
        eAVEncDDService_VO = 7   // (Associated Service: Voice Over (VO) / Karaoke)
        );

    eAVEncDDProductionRoomType = (
        eAVEncDDProductionRoomType_NotIndicated = 0,
        eAVEncDDProductionRoomType_Large = 1,
        eAVEncDDProductionRoomType_Small = 2);

    eAVEncDDDynamicRangeCompressionControl = (
        eAVEncDDDynamicRangeCompressionControl_None = 0,
        eAVEncDDDynamicRangeCompressionControl_FilmStandard = 1,
        eAVEncDDDynamicRangeCompressionControl_FilmLight = 2,
        eAVEncDDDynamicRangeCompressionControl_MusicStandard = 3,
        eAVEncDDDynamicRangeCompressionControl_MusicLight = 4,
        eAVEncDDDynamicRangeCompressionControl_Speech = 5);




    eAVEncDDSurroundExMode = (
        eAVEncDDSurroundExMode_NotIndicated = 0,
        eAVEncDDSurroundExMode_No = 1,
        eAVEncDDSurroundExMode_Yes = 2);

    eAVEncDDPreferredStereoDownMixMode = (
        eAVEncDDPreferredStereoDownMixMode_LtRt = 0,
        eAVEncDDPreferredStereoDownMixMode_LoRo = 1);


    eAVEncDDAtoDConverterType = (
        eAVEncDDAtoDConverterType_Standard = 0,
        eAVEncDDAtoDConverterType_HDCD = 1);


    eAVEncDDHeadphoneMode = (
        eAVEncDDHeadphoneMode_NotIndicated = 0,
        eAVEncDDHeadphoneMode_NotEncoded = 1,
        eAVEncDDHeadphoneMode_Encoded = 2);


    eAVDecVideoInputScanType = (
        eAVDecVideoInputScan_Unknown = 0,
        eAVDecVideoInputScan_Progressive = 1,
        eAVDecVideoInputScan_Interlaced_UpperFieldFirst = 2,
        eAVDecVideoInputScan_Interlaced_LowerFieldFirst = 3);


    eAVDecVideoSWPowerLevel = (
        eAVDecVideoSWPowerLevel_BatteryLife = 0,
        eAVDecVideoSWPowerLevel_Balanced = 50,
        eAVDecVideoSWPowerLevel_VideoQuality = 100);

    eAVDecAACDownmixMode = (
        eAVDecAACUseISODownmix = 0,
        eAVDecAACUseARIBDownmix = 1);

    eAVDecHEAACDynamicRangeControl = (
        eAVDecHEAACDynamicRangeControl_OFF = 0,
        eAVDecHEAACDynamicRangeControl_ON = 1);

    eAVDecAudioDualMono = (
        eAVDecAudioDualMono_IsNotDualMono = 0, // 2-ch bitstream input is not dual mono
        eAVDecAudioDualMono_IsDualMono = 1, // 2-ch bitstream input is dual mono
        eAVDecAudioDualMono_UnSpecified = 2  // There is no indication in the bitstream
        );


    eAVDecAudioDualMonoReproMode = (
        eAVDecAudioDualMonoReproMode_STEREO = 0, // Ch1+Ch2 for mono output, (Ch1 left,     Ch2 right) for stereo output
        eAVDecAudioDualMonoReproMode_LEFT_MONO = 1, // Ch1 for mono output,     (Ch1 left,     Ch1 right) for stereo output
        eAVDecAudioDualMonoReproMode_RIGHT_MONO = 2, // Ch2 for mono output,     (Ch2 left,     Ch2 right) for stereo output
        eAVDecAudioDualMonoReproMode_MIX_MONO = 3 // Ch1+Ch2 for mono output, (Ch1+Ch2 left, Ch1+Ch2 right) for stereo output
        );

    eAVAudioChannelConfig = (
        eAVAudioChannelConfig_FRONT_LEFT = $1,
        eAVAudioChannelConfig_FRONT_RIGHT = $2,
        eAVAudioChannelConfig_FRONT_CENTER = $4,
        eAVAudioChannelConfig_LOW_FREQUENCY = $8,  // aka LFE
        eAVAudioChannelConfig_BACK_LEFT = $10,
        eAVAudioChannelConfig_BACK_RIGHT = $20,
        eAVAudioChannelConfig_FRONT_LEFT_OF_CENTER = $40,
        eAVAudioChannelConfig_FRONT_RIGHT_OF_CENTER = $80,
        eAVAudioChannelConfig_BACK_CENTER = $100,  // aka Mono Surround
        eAVAudioChannelConfig_SIDE_LEFT = $200,  // aka Left Surround
        eAVAudioChannelConfig_SIDE_RIGHT = $400,  // aka Right Surround
        eAVAudioChannelConfig_TOP_CENTER = $800,
        eAVAudioChannelConfig_TOP_FRONT_LEFT = $1000,
        eAVAudioChannelConfig_TOP_FRONT_CENTER = $2000,
        eAVAudioChannelConfig_TOP_FRONT_RIGHT = $4000,
        eAVAudioChannelConfig_TOP_BACK_LEFT = $8000,
        eAVAudioChannelConfig_TOP_BACK_CENTER = $10000,
        eAVAudioChannelConfig_TOP_BACK_RIGHT = $20000);

    eAVDDSurroundMode = (
        eAVDDSurroundMode_NotIndicated = 0,
        eAVDDSurroundMode_No = 1,
        eAVDDSurroundMode_Yes = 2);

    eAVDecDDOperationalMode = (
        eAVDecDDOperationalMode_NONE = 0,
        eAVDecDDOperationalMode_LINE = 1,// Dialnorm enabled, dialogue at -31dBFS, dynrng used, high/low scaling allowed
        eAVDecDDOperationalMode_RF = 2,
        // Dialnorm enabled, dialogue at -20dBFS, dynrng & compr used, high/low scaling NOT allowed (always fully compressed)
        eAVDecDDOperationalMode_CUSTOM0 = 3,// Analog dialnorm (dialogue normalization not part of the decoder)
        eAVDecDDOperationalMode_CUSTOM1 = 4,// Digital dialnorm (dialogue normalization is part of the decoder)
        eAVDecDDOperationalMode_PORTABLE8 = 5,
        // Dialnorm enabled, dialogue at -8dBFS, dynrng & compr used, high/low scaling NOT allowed (always fully compressed)
        eAVDecDDOperationalMode_PORTABLE11 = 6,
        // Dialnorm enabled, dialogue at -11dBFS, dynrng & compr used, high/low scaling NOT allowed (always fully compressed)
        eAVDecDDOperationalMode_PORTABLE14 =
        7 // Dialnorm enabled, dialogue at -14dBFS, dynrng & compr used, high/low scaling NOT allowed (always fully compressed)
        );


    eAVDecDDMatrixDecodingMode = (
        eAVDecDDMatrixDecodingMode_OFF = 0,
        eAVDecDDMatrixDecodingMode_ON = 1,
        eAVDecDDMatrixDecodingMode_AUTO = 2);


    eAVDecDDStereoDownMixMode = (
        eAVDecDDStereoDownMixMode_Auto = 0, // Automatic detection
        eAVDecDDStereoDownMixMode_LtRt = 1, // Surround compatible (Lt/Rt)
        eAVDecDDStereoDownMixMode_LoRo = 2  // Stereo (Lo/Ro)
        );

    eAVDSPLoudnessEqualization = (
        eAVDSPLoudnessEqualization_OFF = 0,
        eAVDSPLoudnessEqualization_ON = 1,
        eAVDSPLoudnessEqualization_AUTO = 2);


    eAVDSPSpeakerFill = (
        eAVDSPSpeakerFill_OFF = 0,
        eAVDSPSpeakerFill_ON = 1,
        eAVDSPSpeakerFill_AUTO = 2);

    eAVEncChromaEncodeMode = (
        eAVEncChromaEncodeMode_420,
        eAVEncChromaEncodeMode_444,
        eAVEncChromaEncodeMode_444_v2);


implementation

end.

