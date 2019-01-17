unit Win32.MPEG2Structs;

{$mode delphi}

interface

uses
    Windows, Classes, SysUtils;

const
    MPEG2_FILTER_VERSION_1_SIZE = 124;
    MPEG2_FILTER_VERSION_2_SIZE = 133;

type
  {$Z1}
    TPID_BITS_MIDL = record
        Bits: word;
    end;

    TMPEG_HEADER_BITS_MIDL = record
        Bits: word;
    end;

    TMPEG_HEADER_VERSION_BITS_MIDL = record
        Bits: byte;
    end;

    TPID = word;
    PPID = ^TPID;

    TTID = byte;
    PTID = ^TTID;

    TTEID = word;
    PTEID = ^TTEID;

    TClientKey = UINT;
    PClientKey = ^TClientKey;


    TMPEG_CURRENT_NEXT_BIT = (

        MPEG_SECTION_IS_NEXT = 0,
        MPEG_SECTION_IS_CURRENT = 1
        );

    TTID_EXTENSION = record
        wTidExt: word;
        wCount: word;
    end;

    PTID_EXTENSION = ^TTID_EXTENSION;



    TSECTION = record
        TableId: TTID;
        Header: record
            case integer of

                0: (S: TMPEG_HEADER_BITS_MIDL);
                1: (W: word);
        end;
        SectionData: PBYTE;
    end;

    PSECTION = ^TSECTION;



    TLONG_SECTION = record
        TableId: TTID;
        Header: record
            case integer of
                0: (S: TMPEG_HEADER_BITS_MIDL);
                1: (W: word);
        end;
        TableIdExtension: TTEID;
        Version: record
            case integer of

                0: (S: TMPEG_HEADER_VERSION_BITS_MIDL);
                1: (B: byte);
        end;
        SectionNumber: byte;
        LastSectionNumber: byte;
        RemainingData: PBYTE;
    end;

    PLONG_SECTION = ^TLONG_SECTION;

    TDSMCC_SECTION = record
        TableId: TTID;
        Header: record
            case integer of
                0: (S: TMPEG_HEADER_BITS_MIDL);
                1: (W: word);
        end;
        TableIdExtension: TTEID;
        Version: record
            case integer of
                0: (S: TMPEG_HEADER_VERSION_BITS_MIDL);
                1: (B: byte);
        end;
        SectionNumber: byte;
        LastSectionNumber: byte;
        ProtocolDiscriminator: byte;
        DsmccType: byte;
        MessageId: word;
        TransactionId: DWORD;
        Reserved: byte;
        AdaptationLength: byte;
        MessageLength: word;
        RemainingData: PBYTE;
    end;

    PDSMCC_SECTION = ^TDSMCC_SECTION;

    TMPEG_RQST_PACKET = record
        dwLength: DWORD;
        pSection: PSECTION;
    end;

    PMPEG_RQST_PACKET = ^TMPEG_RQST_PACKET;


    TMPEG_PACKET_LIST = record
        wPacketCount: word;
        PacketList {array}: PMPEG_RQST_PACKET;
    end;
    PMPEG_PACKET_LIST = ^TMPEG_PACKET_LIST;



    TDSMCC_FILTER_OPTIONS = record
        fSpecifyProtocol: longbool;
        Protocol: byte;
        fSpecifyType: longbool;
        _Type: byte;
        fSpecifyMessageId: longbool;
        MessageId: word;
        fSpecifyTransactionId: longbool;
        fUseTrxIdMessageIdMask: longbool;
        TransactionId: DWORD;
        fSpecifyModuleVersion: longbool;
        ModuleVersion: byte;
        fSpecifyBlockNumber: longbool;
        BlockNumber: word;
        fGetModuleCall: longbool;
        NumberOfBlocksInModule: word;
    end;

    TATSC_FILTER_OPTIONS = record
        fSpecifyEtmId: longbool;
        EtmId: DWORD;
    end;

    TDVB_EIT_FILTER_OPTIONS = record
        fSpecifySegment: longbool;
        bSegment: byte;
    end;

    TMPEG2_FILTER = record
        bVersionNumber: byte;
        wFilterSize: word;
        fUseRawFilteringBits: longbool;
        Filter: array[0.. 15] of byte;
        Mask: array [0.. 15] of byte;
        fSpecifyTableIdExtension: longbool;
        TableIdExtension: word;
        fSpecifyVersion: longbool;
        Version: byte;
        fSpecifySectionNumber: longbool;
        SectionNumber: byte;
        fSpecifyCurrentNext: longbool;
        fNext: longbool;
        fSpecifyDsmccOptions: longbool;
        Dsmcc: TDSMCC_FILTER_OPTIONS;
        fSpecifyAtscOptions: longbool;
        Atsc: TATSC_FILTER_OPTIONS;
    end;
    PMPEG2_FILTER = ^TMPEG2_FILTER;



    TMPEG2_FILTER2 = record
        case integer of
            0: (
                bVersionNumber: byte;
                wFilterSize: word;
                fUseRawFilteringBits: longbool;
                Filter: array[0..15] of byte;
                Mask: array[0..15] of byte;
                fSpecifyTableIdExtension: longbool;
                TableIdExtension: word;
                fSpecifyVersion: longbool;
                Version: byte;
                fSpecifySectionNumber: longbool;
                SectionNumber: byte;
                fSpecifyCurrentNext: longbool;
                fNext: longbool;
                fSpecifyDsmccOptions: longbool;
                Dsmcc: TDSMCC_FILTER_OPTIONS;
                fSpecifyAtscOptions: longbool;
                Atsc: TATSC_FILTER_OPTIONS;

                fSpecifyDvbEitOptions: longbool;
                DvbEit: TDVB_EIT_FILTER_OPTIONS;
            );
            1: (bVersion1Bytes: array [0.. 123] of byte);

    end;

    PMPEG2_FILTER2 = ^TMPEG2_FILTER2;


    TMPEG_STREAM_BUFFER = record
        hr: HRESULT;
        dwDataBufferSize: DWORD;
        dwSizeOfDataRead: DWORD;
        pDataBuffer: PBYTE;
    end;

    PMPEG_STREAM_BUFFER = ^TMPEG_STREAM_BUFFER;


    TMPEG_TIME = record
        Hours: byte;
        Minutes: byte;
        Seconds: byte;
    end;

    TMPEG_DURATION = TMPEG_TIME;

    TMPEG_DATE = record
        Date: byte;
        Month: byte;
        Year: word;
    end;

    TMPEG_DATE_AND_TIME = record
        D: TMPEG_DATE;
        T: TMPEG_TIME;
    end;

    TMPEG_CONTEXT_TYPE = (
        MPEG_CONTEXT_BCS_DEMUX = 0,
        MPEG_CONTEXT_WINSOCK = (MPEG_CONTEXT_BCS_DEMUX + 1)
        );

    TMPEG_BCS_DEMUX = record
        AVMGraphId: DWORD;
    end;

    TMPEG_WINSOCK = record
        AVMGraphId: DWORD;
    end;

    TMPEG_CONTEXT = record
        _Type: TMPEG_CONTEXT_TYPE;
        u: record
            case integer of
                0: (Demux: TMPEG_BCS_DEMUX);
                1: (Winsock: TMPEG_WINSOCK);
        end;
    end;
    PMPEG_CONTEXT = ^TMPEG_CONTEXT;


    TMPEG_REQUEST_TYPE = (
        MPEG_RQST_UNKNOWN = 0,
        MPEG_RQST_GET_SECTION = (MPEG_RQST_UNKNOWN + 1),
        MPEG_RQST_GET_SECTION_ASYNC = (MPEG_RQST_GET_SECTION + 1),
        MPEG_RQST_GET_TABLE = (MPEG_RQST_GET_SECTION_ASYNC + 1),
        MPEG_RQST_GET_TABLE_ASYNC = (MPEG_RQST_GET_TABLE + 1),
        MPEG_RQST_GET_SECTIONS_STREAM = (MPEG_RQST_GET_TABLE_ASYNC + 1),
        MPEG_RQST_GET_PES_STREAM = (MPEG_RQST_GET_SECTIONS_STREAM + 1),
        MPEG_RQST_GET_TS_STREAM = (MPEG_RQST_GET_PES_STREAM + 1),
        MPEG_RQST_START_MPE_STREAM = (MPEG_RQST_GET_TS_STREAM + 1)
        );

    TMPEG_SERVICE_REQUEST = record
        _Type: TMPEG_REQUEST_TYPE;
        Context: TMPEG_CONTEXT;
        Pid: TPID;
        TableId: TTID;
        Filter: TMPEG2_FILTER;
        Flags: DWORD;
    end;
    PMPEG_SERVICE_REQUEST = ^TMPEG_SERVICE_REQUEST;



    TMPEG_SERVICE_RESPONSE = record
        IPAddress: DWORD;
        Port: word;
    end;

    PMPEG_SERVICE_RESPONSE = ^TMPEG_SERVICE_RESPONSE;

    PDSMCC_ELEMENT = ^TDSMCC_ELEMENT;

    TDSMCC_ELEMENT = record
        pid: TPID;
        bComponentTag: byte;
        dwCarouselId: DWORD;
        dwTransactionId: DWORD;
        pNext: PDSMCC_ELEMENT;
    end;


    PMPE_ELEMENT = ^TMPE_ELEMENT;

    TMPE_ELEMENT = record
        pid: TPID;
        bComponentTag: byte;
        pNext: PMPE_ELEMENT;
    end;




    TMPEG_STREAM_FILTER = record
        wPidValue: word;
        dwFilterSize: DWORD;
        fCrcEnabled: longbool;
        rgchFilter: array[0.. 15] of byte;
        rgchMask: array [0.. 15] of byte;
    end;
    PMPEG_STREAM_FILTER = ^TMPEG_STREAM_FILTER;

{$Z4}




implementation

end.
