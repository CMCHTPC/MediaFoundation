//------------------------------------------------------------------------------
// File: dxva2Trace.h

// Desc: DirectX Video Acceleration 2 header file for ETW data

// Copyright (c) 1999 - 2005, Microsoft Corporation.  All rights reserved.
//------------------------------------------------------------------------------

unit CMC.DXVA2Trace;

{$IFDEF FPC}
{$mode delphi}
{$ENDIF}

interface

uses
    Windows, Classes, SysUtils,
    CMC.EVNTrace;

const
    DXVA2Trace_Control: TGUID = '{a0386e75-f70c-464c-a9ce-33c44e091623}';
    DXVA2Trace_DecodeDevCreated: TGUID = '{b4de17a1-c5b2-44fe-86d5-d97a648114ff}';
    DXVA2Trace_DecodeDevDestroyed: TGUID = '{853ebdf2-4160-421d-8893-63dcea4f18bb}';
    DXVA2Trace_DecodeDevBeginFrame: TGUID = '{9fd1acf6-44cb-4637-bc62-2c11a9608f90}';
    DXVA2Trace_DecodeDevExecute: TGUID = '{850aeb4c-d19a-4609-b3b4-bcbf0e22121e}';
    DXVA2Trace_DecodeDevGetBuffer: TGUID = '{57b128fb-72cb-4137-a575-d91fa3160897}';
    DXVA2Trace_DecodeDevEndFrame: TGUID = '{9fb3cb33-47dc-4899-98c8-c0c6cd7cd3cb}';
    DXVA2Trace_VideoProcessDevCreated: TGUID = '{895508c6-540d-4c87-98f8-8dcbf2dabb2a}';
    DXVA2Trace_VideoProcessDevDestroyed: TGUID = '{f97f30b1-fb49-42c7-8ee8-88bdfa92d4e2}';
    DXVA2Trace_VideoProcessBlt: TGUID = '{69089cc0-71ab-42d0-953a-2887bf05a8af}';

type

    // -------------------------------------------------------------------------
    // DXVA2 Video Decoder ETW definitions

    // There are event for:
    //      Device creation
    //      Device destruction

    // When the device is being used there are events for:
    //      Begin frame
    //      Begin execute
    //      End execute
    //      End frame
    // -------------------------------------------------------------------------

    TDXVA2Trace_DecodeDevCreatedData = record
{$IFNDEF DXVA2Trace_PostProcessing}
        wmiHeader: TEVENT_TRACE_HEADER;
{$ENDIF}
        pObject: ULONGLONG;
        pD3DDevice: ULONGLONG;
        DeviceGuid: TGUID;
        Width: ULONG;
        Height: ULONG;
        Enter: boolean;
    end;

    TDXVA2Trace_DecodeDeviceData = record
{$IFNDEF DXVA2Trace_PostProcessing}
        wmiHeader: TEVENT_TRACE_HEADER;
{$ENDIF}
        pObject: ULONGLONG;
        Enter: boolean;
    end;

    TDXVA2Trace_DecodeDevDestroyedData = TDXVA2Trace_DecodeDeviceData;
    TDXVA2Trace_DecodeDevExecuteData = TDXVA2Trace_DecodeDeviceData;
    TDXVA2Trace_DecodeDevEndFrameData = TDXVA2Trace_DecodeDeviceData;

    TDXVA2Trace_DecodeDevBeginFrameData = record
{$IFNDEF DXVA2Trace_PostProcessing}
        wmiHeader: TEVENT_TRACE_HEADER;
{$ENDIF}
        pObject: ULONGLONG;
        pRenderTarget: ULONGLONG;
        Enter: boolean;
    end;

    TDXVA2Trace_DecodeDevGetBufferData = record
{$IFNDEF DXVA2Trace_PostProcessing}
        wmiHeader: TEVENT_TRACE_HEADER;
{$ENDIF}
        pObject: ULONGLONG;
        BufferType: UINT;
        Enter: boolean;
    end;


    // -------------------------------------------------------------------------
    // DXVA2 Video Processing ETW definitions

    // There are event for:
    //      Device creation
    //      Device destruction

    // When the device is being used there are events for:
    //      Begin VideoProcessBlt
    //      End VideoProcessBlt
    // -------------------------------------------------------------------------

    TDXVA2Trace_VideoProcessDevCreatedData = record
{$IFNDEF DXVA2Trace_PostProcessing}
        wmiHeader: TEVENT_TRACE_HEADER;
{$ENDIF}
        pObject: ULONGLONG;
        pD3DDevice: ULONGLONG;
        DeviceGuid: TGUID;
        RTFourCC: ULONG;
        Width: ULONG;
        Height: ULONG;
        Enter: boolean;
    end;


    TDXVA2Trace_VideoProcessDeviceData = record
{$IFNDEF DXVA2Trace_PostProcessing}
        wmiHeader: TEVENT_TRACE_HEADER;
{$ENDIF}
        pObject: ULONGLONG;
        Enter: boolean;
    end;

    TDXVA2Trace_VideoProcessDevDestroyedData = TDXVA2Trace_VideoProcessDeviceData;
    TDXVA2Trace_VideoProcessBltEndData = TDXVA2Trace_VideoProcessDeviceData;

    TDXVA2TraceVideoProcessBltData = record
{$IFNDEF DXVA2Trace_PostProcessing}
        wmiHeader: TEVENT_TRACE_HEADER;
{$ENDIF}
        pObject: ULONGLONG;
        pRenderTarget: ULONGLONG;
        TargetFrameTime: ULONGLONG;
        TargetRect: TRECT;
        Enter: boolean;
    end;

    TDXVA2TraceVideoProcessBltDataData = TDXVA2TraceVideoProcessBltData;


implementation

end.





