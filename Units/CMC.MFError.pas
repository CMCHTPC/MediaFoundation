unit CMC.MFError;

(* ++

  Microsoft Windows Media Foundation
  Copyright (C) Microsoft Corporation. All rights reserved.

  Module Name:

  mferror.mc

  Abstract:

  Definitions for MediaFoundation events.

  Author:


  Revision History:

  Notes:

  This file is used by the MC tool to generate the mferror.h file

  **************************** READ ME ******************************************

  Here are the commented error ranges for the Windows Media Technologies Group


  RANGES

  14000 - 14999 = General Media Foundation errors

  15000 - 15999 = ASF parsing errors

  16000 - 16999 = Media Source errors

  17000 - 17999 = MEDIAFOUNDATION Network Error Events

  18000 - 18999 = MEDIAFOUNDATION WMContainer Error Events

  19000 - 19999 = MEDIAFOUNDATION Media Sink Error Events

  20000 - 20999 = Renderer errors

  21000 - 21999 = Topology Errors

  25000 - 25999 = Timeline Errors

  26000 - 26999 = Unused

  28000 - 28999 = Transform errors

  29000 - 29999 = Content Protection errors

  40000 - 40999 = Clock errors

  41000 - 41999 = MF Quality Management Errors

  42000 - 42999 = MF Transcode API Errors

  43000 - 43999 = MF HW Device Proxy errors

  44000 - 44999 = MF Capture Engine errors

  **************************** READ ME ******************************************

  -- *)

interface

uses
    Windows, Classes;

const

    /// //////////////////////////////////////////////////////////////////////
    //
    // MEDIAFOUNDATION Success Events
    //
    /// //////////////////////////////////////////////////////////////////////

    /// //////////////////////////////////////////////////////////////////////
    //
    // MEDIAFOUNDATION Warning Events
    //
    /// //////////////////////////////////////////////////////////////////////

    /// //////////////////////////////////////////////////////////////////////
    //
    // MEDIAFOUNDATION Error Events
    //
    /// //////////////////////////////////////////////////////////////////////

    //
    // Values are 32 bit values laid out as follows:
    //
    // 3 3 2 2 2 2 2 2 2 2 2 2 1 1 1 1 1 1 1 1 1 1
    // 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
    // +---+-+-+-----------------------+-------------------------------+
    // |Sev|C|R|     Facility          |               Code            |
    // +---+-+-+-----------------------+-------------------------------+
    //
    // where
    //
    // Sev - is the severity code
    //
    // 00 - Success
    // 01 - Informational
    // 10 - Warning
    // 11 - Error
    //
    // C - is the Customer code flag
    //
    // R - is a reserved bit
    //
    // Facility - is the facility code
    //
    // Code - is the facility's status code
    //
    //
    // Define the facility codes
    //
    FACILITY_MF_WIN32 = $7;
    FACILITY_MF = $D;

    //
    // Define the severity codes
    //
    STATUS_SEVERITY_WARNING = $2;
    STATUS_SEVERITY_SUCCESS = $0;
    STATUS_SEVERITY_INFORMATIONAL = $1;
    STATUS_SEVERITY_ERROR = $3;

    //
    // MessageId: MF_E_PLATFORM_NOT_INITIALIZED
    //
    // MessageText:
    //
    // Platform not initialized. Please call MFStartup().%0
    //
    MF_E_PLATFORM_NOT_INITIALIZED = HRESULT($C00D36B0);

    //
    // MessageId: MF_E_BUFFERTOOSMALL
    //
    // MessageText:
    //
    // The buffer was too small to carry out the requested action.%0
    //
    MF_E_BUFFERTOOSMALL = HRESULT($C00D36B1);

    //
    // MessageId: MF_E_INVALIDREQUEST
    //
    // MessageText:
    //
    // The request is invalid in the current state.%0
    //
    MF_E_INVALIDREQUEST = HRESULT($C00D36B2);

    //
    // MessageId: MF_E_INVALIDSTREAMNUMBER
    //
    // MessageText:
    //
    // The stream number provided was invalid.%0
    //
    MF_E_INVALIDSTREAMNUMBER = HRESULT($C00D36B3);

    //
    // MessageId: MF_E_INVALIDMEDIATYPE
    //
    // MessageText:
    //
    // The data specified for the media type is invalid, inconsistent, or not supported by this object.%0
    //
    MF_E_INVALIDMEDIATYPE = HRESULT($C00D36B4);

    //
    // MessageId: MF_E_NOTACCEPTING
    //
    // MessageText:
    //
    // The callee is currently not accepting further input.%0
    //
    MF_E_NOTACCEPTING = HRESULT($C00D36B5);

    //
    // MessageId: MF_E_NOT_INITIALIZED
    //
    // MessageText:
    //
    // This object needs to be initialized before the requested operation can be carried out.%0
    //
    MF_E_NOT_INITIALIZED = HRESULT($C00D36B6);

    //
    // MessageId: MF_E_UNSUPPORTED_REPRESENTATION
    //
    // MessageText:
    //
    // The requested representation is not supported by this object.%0
    //
    MF_E_UNSUPPORTED_REPRESENTATION = HRESULT($C00D36B7);

    //
    // MessageId: MF_E_NO_MORE_TYPES
    //
    // MessageText:
    //
    // An object ran out of media types to suggest therefore the requested chain of streaming objects cannot be completed.%0
    //
    MF_E_NO_MORE_TYPES = HRESULT($C00D36B9);

    //
    // MessageId: MF_E_UNSUPPORTED_SERVICE
    //
    // MessageText:
    //
    // The object does not support the specified service.%0
    //
    MF_E_UNSUPPORTED_SERVICE = HRESULT($C00D36BA);

    //
    // MessageId: MF_E_UNEXPECTED
    //
    // MessageText:
    //
    // An unexpected error has occurred in the operation requested.%0
    //
    MF_E_UNEXPECTED = HRESULT($C00D36BB);

    //
    // MessageId: MF_E_INVALIDNAME
    //
    // MessageText:
    //
    // Invalid name.%0
    //
    MF_E_INVALIDNAME = HRESULT($C00D36BC);

    //
    // MessageId: MF_E_INVALIDTYPE
    //
    // MessageText:
    //
    // Invalid type.%0
    //
    MF_E_INVALIDTYPE = HRESULT($C00D36BD);

    //
    // MessageId: MF_E_INVALID_FILE_FORMAT
    //
    // MessageText:
    //
    // The file does not conform to the relevant file format specification.%0
    //
    MF_E_INVALID_FILE_FORMAT = HRESULT($C00D36BE);

    //
    // MessageId: MF_E_INVALIDINDEX
    //
    // MessageText:
    //
    // Invalid index.%0
    //
    MF_E_INVALIDINDEX = HRESULT($C00D36BF);

    //
    // MessageId: MF_E_INVALID_TIMESTAMP
    //
    // MessageText:
    //
    // An invalid timestamp was given.%0
    //
    MF_E_INVALID_TIMESTAMP = HRESULT($C00D36C0);

    //
    // MessageId: MF_E_UNSUPPORTED_SCHEME
    //
    // MessageText:
    //
    // The scheme of the given URL is unsupported.%0
    //
    MF_E_UNSUPPORTED_SCHEME = HRESULT($C00D36C3);

    //
    // MessageId: MF_E_UNSUPPORTED_BYTESTREAM_TYPE
    //
    // MessageText:
    //
    // The byte stream type of the given URL is unsupported.%0
    //
    MF_E_UNSUPPORTED_BYTESTREAM_TYPE = HRESULT($C00D36C4);

    //
    // MessageId: MF_E_UNSUPPORTED_TIME_FORMAT
    //
    // MessageText:
    //
    // The given time format is unsupported.%0
    //
    MF_E_UNSUPPORTED_TIME_FORMAT = HRESULT($C00D36C5);

    //
    // MessageId: MF_E_NO_SAMPLE_TIMESTAMP
    //
    // MessageText:
    //
    // The Media Sample does not have a timestamp.%0
    //
    MF_E_NO_SAMPLE_TIMESTAMP = HRESULT($C00D36C8);

    //
    // MessageId: MF_E_NO_SAMPLE_DURATION
    //
    // MessageText:
    //
    // The Media Sample does not have a duration.%0
    //
    MF_E_NO_SAMPLE_DURATION = HRESULT($C00D36C9);

    //
    // MessageId: MF_E_INVALID_STREAM_DATA
    //
    // MessageText:
    //
    // The request failed because the data in the stream is corrupt.%0
    //
    MF_E_INVALID_STREAM_DATA = HRESULT($C00D36CB);

    //
    // MessageId: MF_E_RT_UNAVAILABLE
    //
    // MessageText:
    //
    // Real time services are not available.%0
    //
    MF_E_RT_UNAVAILABLE = HRESULT($C00D36CF);

    //
    // MessageId: MF_E_UNSUPPORTED_RATE
    //
    // MessageText:
    //
    // The specified rate is not supported.%0
    //
    MF_E_UNSUPPORTED_RATE = HRESULT($C00D36D0);

    //
    // MessageId: MF_E_THINNING_UNSUPPORTED
    //
    // MessageText:
    //
    // This component does not support stream-thinning.%0
    //
    MF_E_THINNING_UNSUPPORTED = HRESULT($C00D36D1);

    //
    // MessageId: MF_E_REVERSE_UNSUPPORTED
    //
    // MessageText:
    //
    // The call failed because no reverse playback rates are available.%0
    //
    MF_E_REVERSE_UNSUPPORTED = HRESULT($C00D36D2);

    //
    // MessageId: MF_E_UNSUPPORTED_RATE_TRANSITION
    //
    // MessageText:
    //
    // The requested rate transition cannot occur in the current state.%0
    //
    MF_E_UNSUPPORTED_RATE_TRANSITION = HRESULT($C00D36D3);

    //
    // MessageId: MF_E_RATE_CHANGE_PREEMPTED
    //
    // MessageText:
    //
    // The requested rate change has been pre-empted and will not occur.%0
    //
    MF_E_RATE_CHANGE_PREEMPTED = HRESULT($C00D36D4);

    //
    // MessageId: MF_E_NOT_FOUND
    //
    // MessageText:
    //
    // The specified object or value does not exist.%0
    //
    MF_E_NOT_FOUND = HRESULT($C00D36D5);

    //
    // MessageId: MF_E_NOT_AVAILABLE
    //
    // MessageText:
    //
    // The requested value is not available.%0
    //
    MF_E_NOT_AVAILABLE = HRESULT($C00D36D6);

    //
    // MessageId: MF_E_NO_CLOCK
    //
    // MessageText:
    //
    // The specified operation requires a clock and no clock is available.%0
    //
    MF_E_NO_CLOCK = HRESULT($C00D36D7);

    //
    // MessageId: MF_S_MULTIPLE_BEGIN
    //
    // MessageText:
    //
    // This callback and state had already been passed in to this event generator earlier.%0
    //
    MF_S_MULTIPLE_BEGIN = HRESULT($000D36D8);

    //
    // MessageId: MF_E_MULTIPLE_BEGIN
    //
    // MessageText:
    //
    // This callback has already been passed in to this event generator.%0
    //
    MF_E_MULTIPLE_BEGIN = HRESULT($C00D36D9);

    //
    // MessageId: MF_E_MULTIPLE_SUBSCRIBERS
    //
    // MessageText:
    //
    // Some component is already listening to events on this event generator.%0
    //
    MF_E_MULTIPLE_SUBSCRIBERS = HRESULT($C00D36DA);

    //
    // MessageId: MF_E_TIMER_ORPHANED
    //
    // MessageText:
    //
    // This timer was orphaned before its callback time arrived.%0
    //
    MF_E_TIMER_ORPHANED = HRESULT($C00D36DB);

    //
    // MessageId: MF_E_STATE_TRANSITION_PENDING
    //
    // MessageText:
    //
    // A state transition is already pending.%0
    //
    MF_E_STATE_TRANSITION_PENDING = HRESULT($C00D36DC);

    //
    // MessageId: MF_E_UNSUPPORTED_STATE_TRANSITION
    //
    // MessageText:
    //
    // The requested state transition is unsupported.%0
    //
    MF_E_UNSUPPORTED_STATE_TRANSITION = HRESULT($C00D36DD);

    //
    // MessageId: MF_E_UNRECOVERABLE_ERROR_OCCURRED
    //
    // MessageText:
    //
    // An unrecoverable error has occurred.%0
    //
    MF_E_UNRECOVERABLE_ERROR_OCCURRED = HRESULT($C00D36DE);

    //
    // MessageId: MF_E_SAMPLE_HAS_TOO_MANY_BUFFERS
    //
    // MessageText:
    //
    // The provided sample has too many buffers.%0
    //
    MF_E_SAMPLE_HAS_TOO_MANY_BUFFERS = HRESULT($C00D36DF);

    //
    // MessageId: MF_E_SAMPLE_NOT_WRITABLE
    //
    // MessageText:
    //
    // The provided sample is not writable.%0
    //
    MF_E_SAMPLE_NOT_WRITABLE = HRESULT($C00D36E0);

    //
    // MessageId: MF_E_INVALID_KEY
    //
    // MessageText:
    //
    // The specified key is not valid.%0
    //
    MF_E_INVALID_KEY = HRESULT($C00D36E2);

    //
    // MessageId: MF_E_BAD_STARTUP_VERSION
    //
    // MessageText:
    //
    // You are calling MFStartup with the wrong MF_VERSION. Mismatched bits?%0
    //
    MF_E_BAD_STARTUP_VERSION = HRESULT($C00D36E3);

    //
    // MessageId: MF_E_UNSUPPORTED_CAPTION
    //
    // MessageText:
    //
    // The caption of the given URL is unsupported.%0
    //
    MF_E_UNSUPPORTED_CAPTION = HRESULT($C00D36E4);

    //
    // MessageId: MF_E_INVALID_POSITION
    //
    // MessageText:
    //
    // The operation on the current offset is not permitted.%0
    //
    MF_E_INVALID_POSITION = HRESULT($C00D36E5);

    //
    // MessageId: MF_E_ATTRIBUTENOTFOUND
    //
    // MessageText:
    //
    // The requested attribute was not found.%0
    //
    MF_E_ATTRIBUTENOTFOUND = HRESULT($C00D36E6);

    //
    // MessageId: MF_E_PROPERTY_TYPE_NOT_ALLOWED
    //
    // MessageText:
    //
    // The specified property type is not allowed in this context.%0
    //
    MF_E_PROPERTY_TYPE_NOT_ALLOWED = HRESULT($C00D36E7);

    //
    // MessageId: MF_E_PROPERTY_TYPE_NOT_SUPPORTED
    //
    // MessageText:
    //
    // The specified property type is not supported.%0
    //
    MF_E_PROPERTY_TYPE_NOT_SUPPORTED = HRESULT($C00D36E8);

    //
    // MessageId: MF_E_PROPERTY_EMPTY
    //
    // MessageText:
    //
    // The specified property is empty.%0
    //
    MF_E_PROPERTY_EMPTY = HRESULT($C00D36E9);

    //
    // MessageId: MF_E_PROPERTY_NOT_EMPTY
    //
    // MessageText:
    //
    // The specified property is not empty.%0
    //
    MF_E_PROPERTY_NOT_EMPTY = HRESULT($C00D36EA);

    //
    // MessageId: MF_E_PROPERTY_VECTOR_NOT_ALLOWED
    //
    // MessageText:
    //
    // The vector property specified is not allowed in this context.%0
    //
    MF_E_PROPERTY_VECTOR_NOT_ALLOWED = HRESULT($C00D36EB);

    //
    // MessageId: MF_E_PROPERTY_VECTOR_REQUIRED
    //
    // MessageText:
    //
    // A vector property is required in this context.%0
    //
    MF_E_PROPERTY_VECTOR_REQUIRED = HRESULT($C00D36EC);

    //
    // MessageId: MF_E_OPERATION_CANCELLED
    //
    // MessageText:
    //
    // The operation is cancelled.%0
    //
    MF_E_OPERATION_CANCELLED = HRESULT($C00D36ED);

    //
    // MessageId: MF_E_BYTESTREAM_NOT_SEEKABLE
    //
    // MessageText:
    //
    // The provided bytestream was expected to be seekable and it is not.%0
    //
    MF_E_BYTESTREAM_NOT_SEEKABLE = HRESULT($C00D36EE);

    //
    // MessageId: MF_E_DISABLED_IN_SAFEMODE
    //
    // MessageText:
    //
    // The Media Foundation platform is disabled when the system is running in Safe Mode.%0
    //
    MF_E_DISABLED_IN_SAFEMODE = HRESULT($C00D36EF);

    //
    // MessageId: MF_E_CANNOT_PARSE_BYTESTREAM
    //
    // MessageText:
    //
    // The Media Source could not parse the byte stream.%0
    //
    MF_E_CANNOT_PARSE_BYTESTREAM = HRESULT($C00D36F0);

    //
    // MessageId: MF_E_SOURCERESOLVER_MUTUALLY_EXCLUSIVE_FLAGS
    //
    // MessageText:
    //
    // Mutually exclusive flags have been specified to source resolver. This flag combination is invalid.%0
    //
    MF_E_SOURCERESOLVER_MUTUALLY_EXCLUSIVE_FLAGS = HRESULT($C00D36F1);

    //
    // MessageId: MF_E_MEDIAPROC_WRONGSTATE
    //
    // MessageText:
    //
    // MediaProc is in the wrong state.%0
    //
    MF_E_MEDIAPROC_WRONGSTATE = HRESULT($C00D36F2);

    //
    // MessageId: MF_E_RT_THROUGHPUT_NOT_AVAILABLE
    //
    // MessageText:
    //
    // Real time I/O service can not provide requested throughput.%0
    //
    MF_E_RT_THROUGHPUT_NOT_AVAILABLE = HRESULT($C00D36F3);

    //
    // MessageId: MF_E_RT_TOO_MANY_CLASSES
    //
    // MessageText:
    //
    // The workqueue cannot be registered with more classes.%0
    //
    MF_E_RT_TOO_MANY_CLASSES = HRESULT($C00D36F4);

    //
    // MessageId: MF_E_RT_WOULDBLOCK
    //
    // MessageText:
    //
    // This operation cannot succeed because another thread owns this object.%0
    //
    MF_E_RT_WOULDBLOCK = HRESULT($C00D36F5);

    //
    // MessageId: MF_E_NO_BITPUMP
    //
    // MessageText:
    //
    // Internal. Bitpump not found.%0
    //
    MF_E_NO_BITPUMP = HRESULT($C00D36F6);

    //
    // MessageId: MF_E_RT_OUTOFMEMORY
    //
    // MessageText:
    //
    // No more RT memory available.%0
    //
    MF_E_RT_OUTOFMEMORY = HRESULT($C00D36F7);

    //
    // MessageId: MF_E_RT_WORKQUEUE_CLASS_NOT_SPECIFIED
    //
    // MessageText:
    //
    // An MMCSS class has not been set for this work queue.%0
    //
    MF_E_RT_WORKQUEUE_CLASS_NOT_SPECIFIED = HRESULT($C00D36F8);

    //
    // MessageId: MF_E_INSUFFICIENT_BUFFER
    //
    // MessageText:
    //
    // Insufficient memory for response.%0
    //
    MF_E_INSUFFICIENT_BUFFER = HRESULT($C00D7170);

    //
    // MessageId: MF_E_CANNOT_CREATE_SINK
    //
    // MessageText:
    //
    // Activate failed to create mediasink. Call OutputNode::GetUINT32(MF_TOPONODE_MAJORTYPE) for more information.%0
    //
    MF_E_CANNOT_CREATE_SINK = HRESULT($C00D36FA);

    //
    // MessageId: MF_E_BYTESTREAM_UNKNOWN_LENGTH
    //
    // MessageText:
    //
    // The length of the provided bytestream is unknown.%0
    //
    MF_E_BYTESTREAM_UNKNOWN_LENGTH = HRESULT($C00D36FB);

    //
    // MessageId: MF_E_SESSION_PAUSEWHILESTOPPED
    //
    // MessageText:
    //
    // The media session cannot pause from a stopped state.%0
    //
    MF_E_SESSION_PAUSEWHILESTOPPED = HRESULT($C00D36FC);

    //
    // MessageId: MF_S_ACTIVATE_REPLACED
    //
    // MessageText:
    //
    // The activate could not be created in the remote process for some reason it was replaced with empty one.%0
    //
    MF_S_ACTIVATE_REPLACED = HRESULT($000D36FD);

    //
    // MessageId: MF_E_FORMAT_CHANGE_NOT_SUPPORTED
    //
    // MessageText:
    //
    // The data specified for the media type is supported, but would require a format change, which is not supported by this object.%0
    //
    MF_E_FORMAT_CHANGE_NOT_SUPPORTED = HRESULT($C00D36FE);

    //
    // MessageId: MF_E_INVALID_WORKQUEUE
    //
    // MessageText:
    //
    // The operation failed because an invalid combination of workqueue ID and flags was specified.%0
    //
    MF_E_INVALID_WORKQUEUE = HRESULT($C00D36FF);

    //
    // MessageId: MF_E_DRM_UNSUPPORTED
    //
    // MessageText:
    //
    // No DRM support is available.%0
    //
    MF_E_DRM_UNSUPPORTED = HRESULT($C00D3700);

    //
    // MessageId: MF_E_UNAUTHORIZED
    //
    // MessageText:
    //
    // This operation is not authorized.%0
    //
    MF_E_UNAUTHORIZED = HRESULT($C00D3701);

    //
    // MessageId: MF_E_OUT_OF_RANGE
    //
    // MessageText:
    //
    // The value is not in the specified or valid range.%0
    //
    MF_E_OUT_OF_RANGE = HRESULT($C00D3702);

    //
    // MessageId: MF_E_INVALID_CODEC_MERIT
    //
    // MessageText:
    //
    // The registered codec merit is not valid.%0
    //
    MF_E_INVALID_CODEC_MERIT = HRESULT($C00D3703);

    //
    // MessageId: MF_E_HW_MFT_FAILED_START_STREAMING
    //
    // MessageText:
    //
    // Hardware MFT failed to start streaming due to lack of hardware resources.%0
    //
    MF_E_HW_MFT_FAILED_START_STREAMING = HRESULT($C00D3704);

    //
    // MessageId: MF_E_OPERATION_IN_PROGRESS
    //
    // MessageText:
    //
    // The operation is already in progress.%0
    //
    MF_E_OPERATION_IN_PROGRESS = HRESULT($C00D3705);

    //
    // MessageId: MF_E_HARDWARE_DRM_UNSUPPORTED
    //
    // MessageText:
    //
    // No Hardware DRM support is available.%0
    //
    MF_E_HARDWARE_DRM_UNSUPPORTED = HRESULT($C00D3706);

    /// //////////////////////////////////////////////////////////////////////
    //
    // MEDIAFOUNDATION ASF Parsing Informational Events
    //
    /// //////////////////////////////////////////////////////////////////////

    //
    // MessageId: MF_S_ASF_PARSEINPROGRESS
    //
    // MessageText:
    //
    // Parsing is still in progress and is not yet complete.%0
    //
    MF_S_ASF_PARSEINPROGRESS = HRESULT($400D3A98);

    /// //////////////////////////////////////////////////////////////////////
    //
    // MEDIAFOUNDATION ASF Parsing Error Events
    //
    /// //////////////////////////////////////////////////////////////////////

    //
    // MessageId: MF_E_ASF_PARSINGINCOMPLETE
    //
    // MessageText:
    //
    // Not enough data have been parsed to carry out the requested action.%0
    //
    MF_E_ASF_PARSINGINCOMPLETE = HRESULT($C00D3A98);

    //
    // MessageId: MF_E_ASF_MISSINGDATA
    //
    // MessageText:
    //
    // There is a gap in the ASF data provided.%0
    //
    MF_E_ASF_MISSINGDATA = HRESULT($C00D3A99);

    //
    // MessageId: MF_E_ASF_INVALIDDATA
    //
    // MessageText:
    //
    // The data provided are not valid ASF.%0
    //
    MF_E_ASF_INVALIDDATA = HRESULT($C00D3A9A);

    //
    // MessageId: MF_E_ASF_OPAQUEPACKET
    //
    // MessageText:
    //
    // The packet is opaque, so the requested information cannot be returned.%0
    //
    MF_E_ASF_OPAQUEPACKET = HRESULT($C00D3A9B);

    //
    // MessageId: MF_E_ASF_NOINDEX
    //
    // MessageText:
    //
    // The requested operation failed since there is no appropriate ASF index.%0
    //
    MF_E_ASF_NOINDEX = HRESULT($C00D3A9C);

    //
    // MessageId: MF_E_ASF_OUTOFRANGE
    //
    // MessageText:
    //
    // The value supplied is out of range for this operation.%0
    //
    MF_E_ASF_OUTOFRANGE = HRESULT($C00D3A9D);

    //
    // MessageId: MF_E_ASF_INDEXNOTLOADED
    //
    // MessageText:
    //
    // The index entry requested needs to be loaded before it can be available.%0
    //
    MF_E_ASF_INDEXNOTLOADED = HRESULT($C00D3A9E);

    //
    // MessageId: MF_E_ASF_TOO_MANY_PAYLOADS
    //
    // MessageText:
    //
    // The packet has reached the maximum number of payloads.%0
    //
    MF_E_ASF_TOO_MANY_PAYLOADS = HRESULT($C00D3A9F);

    //
    // MessageId: MF_E_ASF_UNSUPPORTED_STREAM_TYPE
    //
    // MessageText:
    //
    // Stream type is not supported.%0
    //
    MF_E_ASF_UNSUPPORTED_STREAM_TYPE = HRESULT($C00D3AA0);

    //
    // MessageId: MF_E_ASF_DROPPED_PACKET
    //
    // MessageText:
    //
    // One or more ASF packets were dropped.%0
    //
    MF_E_ASF_DROPPED_PACKET = HRESULT($C00D3AA1);

    /// //////////////////////////////////////////////////////////////////////
    //
    // MEDIAFOUNDATION Media Source Error Events
    //
    /// //////////////////////////////////////////////////////////////////////

    //
    // MessageId: MF_E_NO_EVENTS_AVAILABLE
    //
    // MessageText:
    //
    // There are no events available in the queue.%0
    //
    MF_E_NO_EVENTS_AVAILABLE = HRESULT($C00D3E80);

    //
    // MessageId: MF_E_INVALID_STATE_TRANSITION
    //
    // MessageText:
    //
    // A media source cannot go from the stopped state to the paused state.%0
    //
    MF_E_INVALID_STATE_TRANSITION = HRESULT($C00D3E82);

    //
    // MessageId: MF_E_END_OF_STREAM
    //
    // MessageText:
    //
    // The media stream cannot process any more samples because there are no more samples in the stream.%0
    //
    MF_E_END_OF_STREAM = HRESULT($C00D3E84);

    //
    // MessageId: MF_E_SHUTDOWN
    //
    // MessageText:
    //
    // The request is invalid because Shutdown() has been called.%0
    //
    MF_E_SHUTDOWN = HRESULT($C00D3E85);

    //
    // MessageId: MF_E_MP3_NOTFOUND
    //
    // MessageText:
    //
    // The MP3 object was not found.%0
    //
    MF_E_MP3_NOTFOUND = HRESULT($C00D3E86);

    //
    // MessageId: MF_E_MP3_OUTOFDATA
    //
    // MessageText:
    //
    // The MP3 parser ran out of data before finding the MP3 object.%0
    //
    MF_E_MP3_OUTOFDATA = HRESULT($C00D3E87);

    //
    // MessageId: MF_E_MP3_NOTMP3
    //
    // MessageText:
    //
    // The file is not really a MP3 file.%0
    //
    MF_E_MP3_NOTMP3 = HRESULT($C00D3E88);

    //
    // MessageId: MF_E_MP3_NOTSUPPORTED
    //
    // MessageText:
    //
    // The MP3 file is not supported.%0
    //
    MF_E_MP3_NOTSUPPORTED = HRESULT($C00D3E89);

    //
    // MessageId: MF_E_NO_DURATION
    //
    // MessageText:
    //
    // The Media stream has no duration.%0
    //
    MF_E_NO_DURATION = HRESULT($C00D3E8A);

    //
    // MessageId: MF_E_INVALID_FORMAT
    //
    // MessageText:
    //
    // The Media format is recognized but is invalid.%0
    //
    MF_E_INVALID_FORMAT = HRESULT($C00D3E8C);

    //
    // MessageId: MF_E_PROPERTY_NOT_FOUND
    //
    // MessageText:
    //
    // The property requested was not found.%0
    //
    MF_E_PROPERTY_NOT_FOUND = HRESULT($C00D3E8D);

    //
    // MessageId: MF_E_PROPERTY_READ_ONLY
    //
    // MessageText:
    //
    // The property is read only.%0
    //
    MF_E_PROPERTY_READ_ONLY = HRESULT($C00D3E8E);

    //
    // MessageId: MF_E_PROPERTY_NOT_ALLOWED
    //
    // MessageText:
    //
    // The specified property is not allowed in this context.%0
    //
    MF_E_PROPERTY_NOT_ALLOWED = HRESULT($C00D3E8F);

    //
    // MessageId: MF_E_MEDIA_SOURCE_NOT_STARTED
    //
    // MessageText:
    //
    // The media source is not started.%0
    //
    MF_E_MEDIA_SOURCE_NOT_STARTED = HRESULT($C00D3E91);

    //
    // MessageId: MF_E_UNSUPPORTED_FORMAT
    //
    // MessageText:
    //
    // The Media format is recognized but not supported.%0
    //
    MF_E_UNSUPPORTED_FORMAT = HRESULT($C00D3E98);

    //
    // MessageId: MF_E_MP3_BAD_CRC
    //
    // MessageText:
    //
    // The MPEG frame has bad CRC.%0
    //
    MF_E_MP3_BAD_CRC = HRESULT($C00D3E99);

    //
    // MessageId: MF_E_NOT_PROTECTED
    //
    // MessageText:
    //
    // The file is not protected.%0
    //
    MF_E_NOT_PROTECTED = HRESULT($C00D3E9A);

    //
    // MessageId: MF_E_MEDIA_SOURCE_WRONGSTATE
    //
    // MessageText:
    //
    // The media source is in the wrong state.%0
    //
    MF_E_MEDIA_SOURCE_WRONGSTATE = HRESULT($C00D3E9B);

    //
    // MessageId: MF_E_MEDIA_SOURCE_NO_STREAMS_SELECTED
    //
    // MessageText:
    //
    // No streams are selected in source presentation descriptor.%0
    //
    MF_E_MEDIA_SOURCE_NO_STREAMS_SELECTED = HRESULT($C00D3E9C);

    //
    // MessageId: MF_E_CANNOT_FIND_KEYFRAME_SAMPLE
    //
    // MessageText:
    //
    // No key frame sample was found.%0
    //
    MF_E_CANNOT_FIND_KEYFRAME_SAMPLE = HRESULT($C00D3E9D);

    //
    // MessageId: MF_E_UNSUPPORTED_CHARACTERISTICS
    //
    // MessageText:
    //
    // The characteristics of the media source are not supported.%0
    //
    MF_E_UNSUPPORTED_CHARACTERISTICS = HRESULT($C00D3E9E);

    //
    // MessageId: MF_E_NO_AUDIO_RECORDING_DEVICE
    //
    // MessageText:
    //
    // No audio recording device was found.%0
    //
    MF_E_NO_AUDIO_RECORDING_DEVICE = HRESULT($C00D3E9F);

    //
    // MessageId: MF_E_AUDIO_RECORDING_DEVICE_IN_USE
    //
    // MessageText:
    //
    // The requested audio recording device is currently in use.%0
    //
    MF_E_AUDIO_RECORDING_DEVICE_IN_USE = HRESULT($C00D3EA0);

    //
    // MessageId: MF_E_AUDIO_RECORDING_DEVICE_INVALIDATED
    //
    // MessageText:
    //
    // The audio recording device is no longer present.%0
    //
    MF_E_AUDIO_RECORDING_DEVICE_INVALIDATED = HRESULT($C00D3EA1);

    //
    // MessageId: MF_E_VIDEO_RECORDING_DEVICE_INVALIDATED
    //
    // MessageText:
    //
    // The video recording device is no longer present.%0
    //
    MF_E_VIDEO_RECORDING_DEVICE_INVALIDATED = HRESULT($C00D3EA2);

    //
    // MessageId: MF_E_VIDEO_RECORDING_DEVICE_PREEMPTED
    //
    // MessageText:
    //
    // The video recording device is preempted by another immersive application.%0
    //
    MF_E_VIDEO_RECORDING_DEVICE_PREEMPTED = HRESULT($C00D3EA3);

    /// //////////////////////////////////////////////////////////////////////
    //
    // MEDIAFOUNDATION Network Error Events
    //
    /// //////////////////////////////////////////////////////////////////////

    //
    // MessageId: MF_E_NETWORK_RESOURCE_FAILURE
    //
    // MessageText:
    //
    // An attempt to acquire a network resource failed.%0
    //
    MF_E_NETWORK_RESOURCE_FAILURE = HRESULT($C00D4268);

    //
    // MessageId: MF_E_NET_WRITE
    //
    // MessageText:
    //
    // Error writing to the network.%0
    //
    MF_E_NET_WRITE = HRESULT($C00D4269);

    //
    // MessageId: MF_E_NET_READ
    //
    // MessageText:
    //
    // Error reading from the network.%0
    //
    MF_E_NET_READ = HRESULT($C00D426A);

    //
    // MessageId: MF_E_NET_REQUIRE_NETWORK
    //
    // MessageText:
    //
    // Internal. Entry cannot complete operation without network.%0
    //
    MF_E_NET_REQUIRE_NETWORK = HRESULT($C00D426B);

    //
    // MessageId: MF_E_NET_REQUIRE_ASYNC
    //
    // MessageText:
    //
    // Internal. Async op is required.%0
    //
    MF_E_NET_REQUIRE_ASYNC = HRESULT($C00D426C);

    //
    // MessageId: MF_E_NET_BWLEVEL_NOT_SUPPORTED
    //
    // MessageText:
    //
    // Internal. Bandwidth levels are not supported.%0
    //
    MF_E_NET_BWLEVEL_NOT_SUPPORTED = HRESULT($C00D426D);

    //
    // MessageId: MF_E_NET_STREAMGROUPS_NOT_SUPPORTED
    //
    // MessageText:
    //
    // Internal. Stream groups are not supported.%0
    //
    MF_E_NET_STREAMGROUPS_NOT_SUPPORTED = HRESULT($C00D426E);

    //
    // MessageId: MF_E_NET_MANUALSS_NOT_SUPPORTED
    //
    // MessageText:
    //
    // Manual stream selection is not supported.%0
    //
    MF_E_NET_MANUALSS_NOT_SUPPORTED = HRESULT($C00D426F);

    //
    // MessageId: MF_E_NET_INVALID_PRESENTATION_DESCRIPTOR
    //
    // MessageText:
    //
    // Invalid presentation descriptor.%0
    //
    MF_E_NET_INVALID_PRESENTATION_DESCRIPTOR = HRESULT($C00D4270);

    //
    // MessageId: MF_E_NET_CACHESTREAM_NOT_FOUND
    //
    // MessageText:
    //
    // Cannot find cache stream.%0
    //
    MF_E_NET_CACHESTREAM_NOT_FOUND = HRESULT($C00D4271);

    //
    // MessageId: MF_I_MANUAL_PROXY
    //
    // MessageText:
    //
    // The proxy setting is manual.%0
    //
    MF_I_MANUAL_PROXY = HRESULT($400D4272);

    // duplicate removed
    // MessageId=17011 Severity=Informational Facility=MEDIAFOUNDATION SymbolicName=MF_E_INVALID_REQUEST
    // Language=English
    // The request is invalid in the current state.%0
    // .
    //
    // MessageId: MF_E_NET_REQUIRE_INPUT
    //
    // MessageText:
    //
    // Internal. Entry cannot complete operation without input.%0
    //
    MF_E_NET_REQUIRE_INPUT = HRESULT($C00D4274);

    //
    // MessageId: MF_E_NET_REDIRECT
    //
    // MessageText:
    //
    // The client redirected to another server.%0
    //
    MF_E_NET_REDIRECT = HRESULT($C00D4275);

    //
    // MessageId: MF_E_NET_REDIRECT_TO_PROXY
    //
    // MessageText:
    //
    // The client is redirected to a proxy server.%0
    //
    MF_E_NET_REDIRECT_TO_PROXY = HRESULT($C00D4276);

    //
    // MessageId: MF_E_NET_TOO_MANY_REDIRECTS
    //
    // MessageText:
    //
    // The client reached maximum redirection limit.%0
    //
    MF_E_NET_TOO_MANY_REDIRECTS = HRESULT($C00D4277);

    //
    // MessageId: MF_E_NET_TIMEOUT
    //
    // MessageText:
    //
    // The server, a computer set up to offer multimedia content to other computers, could not handle your request for multimedia content in a timely manner.  Please try again later.%0
    //
    MF_E_NET_TIMEOUT = HRESULT($C00D4278);

    //
    // MessageId: MF_E_NET_CLIENT_CLOSE
    //
    // MessageText:
    //
    // The control socket is closed by the client.%0
    //
    MF_E_NET_CLIENT_CLOSE = HRESULT($C00D4279);

    //
    // MessageId: MF_E_NET_BAD_CONTROL_DATA
    //
    // MessageText:
    //
    // The server received invalid data from the client on the control connection.%0
    //
    MF_E_NET_BAD_CONTROL_DATA = HRESULT($C00D427A);

    //
    // MessageId: MF_E_NET_INCOMPATIBLE_SERVER
    //
    // MessageText:
    //
    // The server is not a compatible streaming media server.%0
    //
    MF_E_NET_INCOMPATIBLE_SERVER = HRESULT($C00D427B);

    //
    // MessageId: MF_E_NET_UNSAFE_URL
    //
    // MessageText:
    //
    // Url.%0
    //
    MF_E_NET_UNSAFE_URL = HRESULT($C00D427C);

    //
    // MessageId: MF_E_NET_CACHE_NO_DATA
    //
    // MessageText:
    //
    // Data is not available.%0
    //
    MF_E_NET_CACHE_NO_DATA = HRESULT($C00D427D);

    //
    // MessageId: MF_E_NET_EOL
    //
    // MessageText:
    //
    // End of line.%0
    //
    MF_E_NET_EOL = HRESULT($C00D427E);

    //
    // MessageId: MF_E_NET_BAD_REQUEST
    //
    // MessageText:
    //
    // The request could not be understood by the server.%0
    //
    MF_E_NET_BAD_REQUEST = HRESULT($C00D427F);

    //
    // MessageId: MF_E_NET_INTERNAL_SERVER_ERROR
    //
    // MessageText:
    //
    // The server encountered an unexpected condition which prevented it from fulfilling the request.%0
    //
    MF_E_NET_INTERNAL_SERVER_ERROR = HRESULT($C00D4280);

    //
    // MessageId: MF_E_NET_SESSION_NOT_FOUND
    //
    // MessageText:
    //
    // Session not found.%0
    //
    MF_E_NET_SESSION_NOT_FOUND = HRESULT($C00D4281);

    //
    // MessageId: MF_E_NET_NOCONNECTION
    //
    // MessageText:
    //
    // There is no connection established with the Windows Media server. The operation failed.%0
    //
    MF_E_NET_NOCONNECTION = HRESULT($C00D4282);

    //
    // MessageId: MF_E_NET_CONNECTION_FAILURE
    //
    // MessageText:
    //
    // The network connection has failed.%0
    //
    MF_E_NET_CONNECTION_FAILURE = HRESULT($C00D4283);

    //
    // MessageId: MF_E_NET_INCOMPATIBLE_PUSHSERVER
    //
    // MessageText:
    //
    // The Server service that received the HTTP push request is not a compatible version of Windows Media Services (WMS).  This error may indicate the push request was received by IIS instead of WMS.  Ensure WMS is started and has the HTTP Server control protocol properly enabled and try again.%0
    //
    MF_E_NET_INCOMPATIBLE_PUSHSERVER = HRESULT($C00D4284);

    //
    // MessageId: MF_E_NET_SERVER_ACCESSDENIED
    //
    // MessageText:
    //
    // The Windows Media server is denying access.  The username and/or password might be incorrect.%0
    //
    MF_E_NET_SERVER_ACCESSDENIED = HRESULT($C00D4285);

    //
    // MessageId: MF_E_NET_PROXY_ACCESSDENIED
    //
    // MessageText:
    //
    // The proxy server is denying access.  The username and/or password might be incorrect.%0
    //
    MF_E_NET_PROXY_ACCESSDENIED = HRESULT($C00D4286);

    //
    // MessageId: MF_E_NET_CANNOTCONNECT
    //
    // MessageText:
    //
    // Unable to establish a connection to the server.%0
    //
    MF_E_NET_CANNOTCONNECT = HRESULT($C00D4287);

    //
    // MessageId: MF_E_NET_INVALID_PUSH_TEMPLATE
    //
    // MessageText:
    //
    // The specified push template is invalid.%0
    //
    MF_E_NET_INVALID_PUSH_TEMPLATE = HRESULT($C00D4288);

    //
    // MessageId: MF_E_NET_INVALID_PUSH_PUBLISHING_POINT
    //
    // MessageText:
    //
    // The specified push publishing point is invalid.%0
    //
    MF_E_NET_INVALID_PUSH_PUBLISHING_POINT = HRESULT($C00D4289);

    //
    // MessageId: MF_E_NET_BUSY
    //
    // MessageText:
    //
    // The requested resource is in use.%0
    //
    MF_E_NET_BUSY = HRESULT($C00D428A);

    //
    // MessageId: MF_E_NET_RESOURCE_GONE
    //
    // MessageText:
    //
    // The Publishing Point or file on the Windows Media Server is no longer available.%0
    //
    MF_E_NET_RESOURCE_GONE = HRESULT($C00D428B);

    //
    // MessageId: MF_E_NET_ERROR_FROM_PROXY
    //
    // MessageText:
    //
    // The proxy experienced an error while attempting to contact the media server.%0
    //
    MF_E_NET_ERROR_FROM_PROXY = HRESULT($C00D428C);

    //
    // MessageId: MF_E_NET_PROXY_TIMEOUT
    //
    // MessageText:
    //
    // The proxy did not receive a timely response while attempting to contact the media server.%0
    //
    MF_E_NET_PROXY_TIMEOUT = HRESULT($C00D428D);

    //
    // MessageId: MF_E_NET_SERVER_UNAVAILABLE
    //
    // MessageText:
    //
    // The server is currently unable to handle the request due to a temporary overloading or maintenance of the server.%0
    //
    MF_E_NET_SERVER_UNAVAILABLE = HRESULT($C00D428E);

    //
    // MessageId: MF_E_NET_TOO_MUCH_DATA
    //
    // MessageText:
    //
    // The encoding process was unable to keep up with the amount of supplied data.%0
    //
    MF_E_NET_TOO_MUCH_DATA = HRESULT($C00D428F);

    //
    // MessageId: MF_E_NET_SESSION_INVALID
    //
    // MessageText:
    //
    // Session not found.%0
    //
    MF_E_NET_SESSION_INVALID = HRESULT($C00D4290);

    //
    // MessageId: MF_E_OFFLINE_MODE
    //
    // MessageText:
    //
    // The requested URL is not available in offline mode.%0
    //
    MF_E_OFFLINE_MODE = HRESULT($C00D4291);

    //
    // MessageId: MF_E_NET_UDP_BLOCKED
    //
    // MessageText:
    //
    // A device in the network is blocking UDP traffic.%0
    //
    MF_E_NET_UDP_BLOCKED = HRESULT($C00D4292);

    //
    // MessageId: MF_E_NET_UNSUPPORTED_CONFIGURATION
    //
    // MessageText:
    //
    // The specified configuration value is not supported.%0
    //
    MF_E_NET_UNSUPPORTED_CONFIGURATION = HRESULT($C00D4293);

    //
    // MessageId: MF_E_NET_PROTOCOL_DISABLED
    //
    // MessageText:
    //
    // The networking protocol is disabled.%0
    //
    MF_E_NET_PROTOCOL_DISABLED = HRESULT($C00D4294);

    //
    // MessageId: MF_E_NET_COMPANION_DRIVER_DISCONNECT
    //
    // MessageText:
    //
    // The companion driver asked the OS to disconnect from the receiver.%0
    //
    MF_E_NET_COMPANION_DRIVER_DISCONNECT = HRESULT($C00D4295);

    /// //////////////////////////////////////////////////////////////////////
    //
    // MEDIAFOUNDATION WMContainer Error Events
    //
    /// //////////////////////////////////////////////////////////////////////

    //
    // MessageId: MF_E_ALREADY_INITIALIZED
    //
    // MessageText:
    //
    // This object has already been initialized and cannot be re-initialized at this time.%0
    //
    MF_E_ALREADY_INITIALIZED = HRESULT($C00D4650);

    //
    // MessageId: MF_E_BANDWIDTH_OVERRUN
    //
    // MessageText:
    //
    // The amount of data passed in exceeds the given bitrate and buffer window.%0
    //
    MF_E_BANDWIDTH_OVERRUN = HRESULT($C00D4651);

    //
    // MessageId: MF_E_LATE_SAMPLE
    //
    // MessageText:
    //
    // The sample was passed in too late to be correctly processed.%0
    //
    MF_E_LATE_SAMPLE = HRESULT($C00D4652);

    //
    // MessageId: MF_E_FLUSH_NEEDED
    //
    // MessageText:
    //
    // The requested action cannot be carried out until the object is flushed and the queue is emptied.%0
    //
    MF_E_FLUSH_NEEDED = HRESULT($C00D4653);

    //
    // MessageId: MF_E_INVALID_PROFILE
    //
    // MessageText:
    //
    // The profile is invalid.%0
    //
    MF_E_INVALID_PROFILE = HRESULT($C00D4654);

    //
    // MessageId: MF_E_INDEX_NOT_COMMITTED
    //
    // MessageText:
    //
    // The index that is being generated needs to be committed before the requested action can be carried out.%0
    //
    MF_E_INDEX_NOT_COMMITTED = HRESULT($C00D4655);

    //
    // MessageId: MF_E_NO_INDEX
    //
    // MessageText:
    //
    // The index that is necessary for the requested action is not found.%0
    //
    MF_E_NO_INDEX = HRESULT($C00D4656);

    //
    // MessageId: MF_E_CANNOT_INDEX_IN_PLACE
    //
    // MessageText:
    //
    // The requested index cannot be added in-place to the specified ASF content.%0
    //
    MF_E_CANNOT_INDEX_IN_PLACE = HRESULT($C00D4657);

    //
    // MessageId: MF_E_MISSING_ASF_LEAKYBUCKET
    //
    // MessageText:
    //
    // The ASF leaky bucket parameters must be specified in order to carry out this request.%0
    //
    MF_E_MISSING_ASF_LEAKYBUCKET = HRESULT($C00D4658);

    //
    // MessageId: MF_E_INVALID_ASF_STREAMID
    //
    // MessageText:
    //
    // The stream id is invalid. The valid range for ASF stream id is from 1 to 127.%0
    //
    MF_E_INVALID_ASF_STREAMID = HRESULT($C00D4659);

    /// //////////////////////////////////////////////////////////////////////
    //
    // MEDIAFOUNDATION Media Sink Error Events
    //
    /// //////////////////////////////////////////////////////////////////////

    //
    // MessageId: MF_E_STREAMSINK_REMOVED
    //
    // MessageText:
    //
    // The requested Stream Sink has been removed and cannot be used.%0
    //
    MF_E_STREAMSINK_REMOVED = HRESULT($C00D4A38);

    //
    // MessageId: MF_E_STREAMSINKS_OUT_OF_SYNC
    //
    // MessageText:
    //
    // The various Stream Sinks in this Media Sink are too far out of sync for the requested action to take place.%0
    //
    MF_E_STREAMSINKS_OUT_OF_SYNC = HRESULT($C00D4A3A);

    //
    // MessageId: MF_E_STREAMSINKS_FIXED
    //
    // MessageText:
    //
    // Stream Sinks cannot be added to or removed from this Media Sink because its set of streams is fixed.%0
    //
    MF_E_STREAMSINKS_FIXED = HRESULT($C00D4A3B);

    //
    // MessageId: MF_E_STREAMSINK_EXISTS
    //
    // MessageText:
    //
    // The given Stream Sink already exists.%0
    //
    MF_E_STREAMSINK_EXISTS = HRESULT($C00D4A3C);

    //
    // MessageId: MF_E_SAMPLEALLOCATOR_CANCELED
    //
    // MessageText:
    //
    // Sample allocations have been canceled.%0
    //
    MF_E_SAMPLEALLOCATOR_CANCELED = HRESULT($C00D4A3D);

    //
    // MessageId: MF_E_SAMPLEALLOCATOR_EMPTY
    //
    // MessageText:
    //
    // The sample allocator is currently empty, due to outstanding requests.%0
    //
    MF_E_SAMPLEALLOCATOR_EMPTY = HRESULT($C00D4A3E);

    //
    // MessageId: MF_E_SINK_ALREADYSTOPPED
    //
    // MessageText:
    //
    // When we try to stop a stream sink, it is already stopped.%0
    //
    MF_E_SINK_ALREADYSTOPPED = HRESULT($C00D4A3F);

    //
    // MessageId: MF_E_ASF_FILESINK_BITRATE_UNKNOWN
    //
    // MessageText:
    //
    // The ASF file sink could not reserve AVIO because the bitrate is unknown.%0
    //
    MF_E_ASF_FILESINK_BITRATE_UNKNOWN = HRESULT($C00D4A40);

    //
    // MessageId: MF_E_SINK_NO_STREAMS
    //
    // MessageText:
    //
    // No streams are selected in sink presentation descriptor.%0
    //
    MF_E_SINK_NO_STREAMS = HRESULT($C00D4A41);

    //
    // MessageId: MF_S_SINK_NOT_FINALIZED
    //
    // MessageText:
    //
    // The sink has not been finalized before shut down. This may cause sink to generate corrupted content.%0
    //
    MF_S_SINK_NOT_FINALIZED = HRESULT($000D4A42);

    //
    // MessageId: MF_E_METADATA_TOO_LONG
    //
    // MessageText:
    //
    // A metadata item was too long to write to the output container.%0
    //
    MF_E_METADATA_TOO_LONG = HRESULT($C00D4A43);

    //
    // MessageId: MF_E_SINK_NO_SAMPLES_PROCESSED
    //
    // MessageText:
    //
    // The operation failed because no samples were processed by the sink.%0
    //
    MF_E_SINK_NO_SAMPLES_PROCESSED = HRESULT($C00D4A44);

    //
    // MessageId: MF_E_SINK_HEADERS_NOT_FOUND
    //
    // MessageText:
    //
    // Sink could not create valid output file because required headers were not provided to the sink.%0
    //
    MF_E_SINK_HEADERS_NOT_FOUND = HRESULT($C00D4A45);

    /// //////////////////////////////////////////////////////////////////////
    //
    // MEDIAFOUNDATION Renderer Error Events
    //
    /// //////////////////////////////////////////////////////////////////////

    //
    // MessageId: MF_E_VIDEO_REN_NO_PROCAMP_HW
    //
    // MessageText:
    //
    // There is no available procamp hardware with which to perform color correction.%0
    //
    MF_E_VIDEO_REN_NO_PROCAMP_HW = HRESULT($C00D4E20);

    //
    // MessageId: MF_E_VIDEO_REN_NO_DEINTERLACE_HW
    //
    // MessageText:
    //
    // There is no available deinterlacing hardware with which to deinterlace the video stream.%0
    //
    MF_E_VIDEO_REN_NO_DEINTERLACE_HW = HRESULT($C00D4E21);

    //
    // MessageId: MF_E_VIDEO_REN_COPYPROT_FAILED
    //
    // MessageText:
    //
    // A video stream requires copy protection to be enabled, but there was a failure in attempting to enable copy protection.%0
    //
    MF_E_VIDEO_REN_COPYPROT_FAILED = HRESULT($C00D4E22);

    //
    // MessageId: MF_E_VIDEO_REN_SURFACE_NOT_SHARED
    //
    // MessageText:
    //
    // A component is attempting to access a surface for sharing that is not shared.%0
    //
    MF_E_VIDEO_REN_SURFACE_NOT_SHARED = HRESULT($C00D4E23);

    //
    // MessageId: MF_E_VIDEO_DEVICE_LOCKED
    //
    // MessageText:
    //
    // A component is attempting to access a shared device that is already locked by another component.%0
    //
    MF_E_VIDEO_DEVICE_LOCKED = HRESULT($C00D4E24);

    //
    // MessageId: MF_E_NEW_VIDEO_DEVICE
    //
    // MessageText:
    //
    // The device is no longer available. The handle should be closed and a new one opened.%0
    //
    MF_E_NEW_VIDEO_DEVICE = HRESULT($C00D4E25);

    //
    // MessageId: MF_E_NO_VIDEO_SAMPLE_AVAILABLE
    //
    // MessageText:
    //
    // A video sample is not currently queued on a stream that is required for mixing.%0
    //
    MF_E_NO_VIDEO_SAMPLE_AVAILABLE = HRESULT($C00D4E26);

    //
    // MessageId: MF_E_NO_AUDIO_PLAYBACK_DEVICE
    //
    // MessageText:
    //
    // No audio playback device was found.%0
    //
    MF_E_NO_AUDIO_PLAYBACK_DEVICE = HRESULT($C00D4E84);

    //
    // MessageId: MF_E_AUDIO_PLAYBACK_DEVICE_IN_USE
    //
    // MessageText:
    //
    // The requested audio playback device is currently in use.%0
    //
    MF_E_AUDIO_PLAYBACK_DEVICE_IN_USE = HRESULT($C00D4E85);

    //
    // MessageId: MF_E_AUDIO_PLAYBACK_DEVICE_INVALIDATED
    //
    // MessageText:
    //
    // The audio playback device is no longer present.%0
    //
    MF_E_AUDIO_PLAYBACK_DEVICE_INVALIDATED = HRESULT($C00D4E86);

    //
    // MessageId: MF_E_AUDIO_SERVICE_NOT_RUNNING
    //
    // MessageText:
    //
    // The audio service is not running.%0
    //
    MF_E_AUDIO_SERVICE_NOT_RUNNING = HRESULT($C00D4E87);

    /// //////////////////////////////////////////////////////////////////////
    //
    // MEDIAFOUNDATION Topology Error Events
    //
    /// //////////////////////////////////////////////////////////////////////

    //
    // MessageId: MF_E_TOPO_INVALID_OPTIONAL_NODE
    //
    // MessageText:
    //
    // The topology contains an invalid optional node.  Possible reasons are incorrect number of outputs and inputs or optional node is at the beginning or end of a segment.%0
    //
    MF_E_TOPO_INVALID_OPTIONAL_NODE = HRESULT($C00D520E);

    //
    // MessageId: MF_E_TOPO_CANNOT_FIND_DECRYPTOR
    //
    // MessageText:
    //
    // No suitable transform was found to decrypt the content.%0
    //
    MF_E_TOPO_CANNOT_FIND_DECRYPTOR = HRESULT($C00D5211);

    //
    // MessageId: MF_E_TOPO_CODEC_NOT_FOUND
    //
    // MessageText:
    //
    // No suitable transform was found to encode or decode the content.%0
    //
    MF_E_TOPO_CODEC_NOT_FOUND = HRESULT($C00D5212);

    //
    // MessageId: MF_E_TOPO_CANNOT_CONNECT
    //
    // MessageText:
    //
    // Unable to find a way to connect nodes.%0
    //
    MF_E_TOPO_CANNOT_CONNECT = HRESULT($C00D5213);

    //
    // MessageId: MF_E_TOPO_UNSUPPORTED
    //
    // MessageText:
    //
    // Unsupported operations in topoloader.%0
    //
    MF_E_TOPO_UNSUPPORTED = HRESULT($C00D5214);

    //
    // MessageId: MF_E_TOPO_INVALID_TIME_ATTRIBUTES
    //
    // MessageText:
    //
    // The topology or its nodes contain incorrectly set time attributes.%0
    //
    MF_E_TOPO_INVALID_TIME_ATTRIBUTES = HRESULT($C00D5215);

    //
    // MessageId: MF_E_TOPO_LOOPS_IN_TOPOLOGY
    //
    // MessageText:
    //
    // The topology contains loops, which are unsupported in media foundation topologies.%0
    //
    MF_E_TOPO_LOOPS_IN_TOPOLOGY = HRESULT($C00D5216);

    //
    // MessageId: MF_E_TOPO_MISSING_PRESENTATION_DESCRIPTOR
    //
    // MessageText:
    //
    // A source stream node in the topology does not have a presentation descriptor.%0
    //
    MF_E_TOPO_MISSING_PRESENTATION_DESCRIPTOR = HRESULT($C00D5217);

    //
    // MessageId: MF_E_TOPO_MISSING_STREAM_DESCRIPTOR
    //
    // MessageText:
    //
    // A source stream node in the topology does not have a stream descriptor.%0
    //
    MF_E_TOPO_MISSING_STREAM_DESCRIPTOR = HRESULT($C00D5218);

    //
    // MessageId: MF_E_TOPO_STREAM_DESCRIPTOR_NOT_SELECTED
    //
    // MessageText:
    //
    // A stream descriptor was set on a source stream node but it was not selected on the presentation descriptor.%0
    //
    MF_E_TOPO_STREAM_DESCRIPTOR_NOT_SELECTED = HRESULT($C00D5219);

    //
    // MessageId: MF_E_TOPO_MISSING_SOURCE
    //
    // MessageText:
    //
    // A source stream node in the topology does not have a source.%0
    //
    MF_E_TOPO_MISSING_SOURCE = HRESULT($C00D521A);

    //
    // MessageId: MF_E_TOPO_SINK_ACTIVATES_UNSUPPORTED
    //
    // MessageText:
    //
    // The topology loader does not support sink activates on output nodes.%0
    //
    MF_E_TOPO_SINK_ACTIVATES_UNSUPPORTED = HRESULT($C00D521B);

    /// //////////////////////////////////////////////////////////////////////
    //
    // MEDIAFOUNDATION Timeline Error Events
    //
    /// //////////////////////////////////////////////////////////////////////

    //
    // MessageId: MF_E_SEQUENCER_UNKNOWN_SEGMENT_ID
    //
    // MessageText:
    //
    // The sequencer cannot find a segment with the given ID.%0
    //
    MF_E_SEQUENCER_UNKNOWN_SEGMENT_ID = HRESULT($C00D61AC);

    //
    // MessageId: MF_S_SEQUENCER_CONTEXT_CANCELED
    //
    // MessageText:
    //
    // The context was canceled.%0
    //
    MF_S_SEQUENCER_CONTEXT_CANCELED = HRESULT($000D61AD);

    //
    // MessageId: MF_E_NO_SOURCE_IN_CACHE
    //
    // MessageText:
    //
    // Cannot find source in source cache.%0
    //
    MF_E_NO_SOURCE_IN_CACHE = HRESULT($C00D61AE);

    //
    // MessageId: MF_S_SEQUENCER_SEGMENT_AT_END_OF_STREAM
    //
    // MessageText:
    //
    // Cannot update topology flags.%0
    //
    MF_S_SEQUENCER_SEGMENT_AT_END_OF_STREAM = HRESULT($000D61AF);

    /// ///////////////////////////////////////////////////////////////////////////
    //
    // Transform errors
    //
    /// ///////////////////////////////////////////////////////////////////////////

    //
    // MessageId: MF_E_TRANSFORM_TYPE_NOT_SET
    //
    // MessageText:
    //
    // A valid type has not been set for this stream or a stream that it depends on.%0
    //
    MF_E_TRANSFORM_TYPE_NOT_SET = HRESULT($C00D6D60);

    //
    // MessageId: MF_E_TRANSFORM_STREAM_CHANGE
    //
    // MessageText:
    //
    // A stream change has occurred. Output cannot be produced until the streams have been renegotiated.%0
    //
    MF_E_TRANSFORM_STREAM_CHANGE = HRESULT($C00D6D61);

    //
    // MessageId: MF_E_TRANSFORM_INPUT_REMAINING
    //
    // MessageText:
    //
    // The transform cannot take the requested action until all of the input data it currently holds is processed or flushed.%0
    //
    MF_E_TRANSFORM_INPUT_REMAINING = HRESULT($C00D6D62);

    //
    // MessageId: MF_E_TRANSFORM_PROFILE_MISSING
    //
    // MessageText:
    //
    // The transform requires a profile but no profile was supplied or found.%0
    //
    MF_E_TRANSFORM_PROFILE_MISSING = HRESULT($C00D6D63);

    //
    // MessageId: MF_E_TRANSFORM_PROFILE_INVALID_OR_CORRUPT
    //
    // MessageText:
    //
    // The transform requires a profile but the supplied profile was invalid or corrupt.%0
    //
    MF_E_TRANSFORM_PROFILE_INVALID_OR_CORRUPT = HRESULT($C00D6D64);

    //
    // MessageId: MF_E_TRANSFORM_PROFILE_TRUNCATED
    //
    // MessageText:
    //
    // The transform requires a profile but the supplied profile ended unexpectedly while parsing.%0
    //
    MF_E_TRANSFORM_PROFILE_TRUNCATED = HRESULT($C00D6D65);

    //
    // MessageId: MF_E_TRANSFORM_PROPERTY_PID_NOT_RECOGNIZED
    //
    // MessageText:
    //
    // The property ID does not match any property supported by the transform.%0
    //
    MF_E_TRANSFORM_PROPERTY_PID_NOT_RECOGNIZED = HRESULT($C00D6D66);

    //
    // MessageId: MF_E_TRANSFORM_PROPERTY_VARIANT_TYPE_WRONG
    //
    // MessageText:
    //
    // The variant does not have the type expected for this property ID.%0
    //
    MF_E_TRANSFORM_PROPERTY_VARIANT_TYPE_WRONG = HRESULT($C00D6D67);

    //
    // MessageId: MF_E_TRANSFORM_PROPERTY_NOT_WRITEABLE
    //
    // MessageText:
    //
    // An attempt was made to set the value on a read-only property.%0
    //
    MF_E_TRANSFORM_PROPERTY_NOT_WRITEABLE = HRESULT($C00D6D68);

    //
    // MessageId: MF_E_TRANSFORM_PROPERTY_ARRAY_VALUE_WRONG_NUM_DIM
    //
    // MessageText:
    //
    // The array property value has an unexpected number of dimensions.%0
    //
    MF_E_TRANSFORM_PROPERTY_ARRAY_VALUE_WRONG_NUM_DIM = HRESULT($C00D6D69);

    //
    // MessageId: MF_E_TRANSFORM_PROPERTY_VALUE_SIZE_WRONG
    //
    // MessageText:
    //
    // The array or blob property value has an unexpected size.%0
    //
    MF_E_TRANSFORM_PROPERTY_VALUE_SIZE_WRONG = HRESULT($C00D6D6A);

    //
    // MessageId: MF_E_TRANSFORM_PROPERTY_VALUE_OUT_OF_RANGE
    //
    // MessageText:
    //
    // The property value is out of range for this transform.%0
    //
    MF_E_TRANSFORM_PROPERTY_VALUE_OUT_OF_RANGE = HRESULT($C00D6D6B);

    //
    // MessageId: MF_E_TRANSFORM_PROPERTY_VALUE_INCOMPATIBLE
    //
    // MessageText:
    //
    // The property value is incompatible with some other property or mediatype set on the transform.%0
    //
    MF_E_TRANSFORM_PROPERTY_VALUE_INCOMPATIBLE = HRESULT($C00D6D6C);

    //
    // MessageId: MF_E_TRANSFORM_NOT_POSSIBLE_FOR_CURRENT_OUTPUT_MEDIATYPE
    //
    // MessageText:
    //
    // The requested operation is not supported for the currently set output mediatype.%0
    //
    MF_E_TRANSFORM_NOT_POSSIBLE_FOR_CURRENT_OUTPUT_MEDIATYPE = HRESULT($C00D6D6D);

    //
    // MessageId: MF_E_TRANSFORM_NOT_POSSIBLE_FOR_CURRENT_INPUT_MEDIATYPE
    //
    // MessageText:
    //
    // The requested operation is not supported for the currently set input mediatype.%0
    //
    MF_E_TRANSFORM_NOT_POSSIBLE_FOR_CURRENT_INPUT_MEDIATYPE = HRESULT($C00D6D6E);

    //
    // MessageId: MF_E_TRANSFORM_NOT_POSSIBLE_FOR_CURRENT_MEDIATYPE_COMBINATION
    //
    // MessageText:
    //
    // The requested operation is not supported for the currently set combination of mediatypes.%0
    //
    MF_E_TRANSFORM_NOT_POSSIBLE_FOR_CURRENT_MEDIATYPE_COMBINATION = HRESULT($C00D6D6F);

    //
    // MessageId: MF_E_TRANSFORM_CONFLICTS_WITH_OTHER_CURRENTLY_ENABLED_FEATURES
    //
    // MessageText:
    //
    // The requested feature is not supported in combination with some other currently enabled feature.%0
    //
    MF_E_TRANSFORM_CONFLICTS_WITH_OTHER_CURRENTLY_ENABLED_FEATURES = HRESULT($C00D6D70);

    //
    // MessageId: MF_E_TRANSFORM_NEED_MORE_INPUT
    //
    // MessageText:
    //
    // The transform cannot produce output until it gets more input samples.%0
    //
    MF_E_TRANSFORM_NEED_MORE_INPUT = HRESULT($C00D6D72);

    //
    // MessageId: MF_E_TRANSFORM_NOT_POSSIBLE_FOR_CURRENT_SPKR_CONFIG
    //
    // MessageText:
    //
    // The requested operation is not supported for the current speaker configuration.%0
    //
    MF_E_TRANSFORM_NOT_POSSIBLE_FOR_CURRENT_SPKR_CONFIG = HRESULT($C00D6D73);

    //
    // MessageId: MF_E_TRANSFORM_CANNOT_CHANGE_MEDIATYPE_WHILE_PROCESSING
    //
    // MessageText:
    //
    // The transform cannot accept mediatype changes in the middle of processing.%0
    //
    MF_E_TRANSFORM_CANNOT_CHANGE_MEDIATYPE_WHILE_PROCESSING = HRESULT($C00D6D74);

    //
    // MessageId: MF_S_TRANSFORM_DO_NOT_PROPAGATE_EVENT
    //
    // MessageText:
    //
    // The caller should not propagate this event to downstream components.%0
    //
    MF_S_TRANSFORM_DO_NOT_PROPAGATE_EVENT = HRESULT($000D6D75);

    //
    // MessageId: MF_E_UNSUPPORTED_D3D_TYPE
    //
    // MessageText:
    //
    // The input type is not supported for D3D device.%0
    //
    MF_E_UNSUPPORTED_D3D_TYPE = HRESULT($C00D6D76);

    //
    // MessageId: MF_E_TRANSFORM_ASYNC_LOCKED
    //
    // MessageText:
    //
    // The caller does not appear to support this transform's asynchronous capabilities.%0
    //
    MF_E_TRANSFORM_ASYNC_LOCKED = HRESULT($C00D6D77);

    //
    // MessageId: MF_E_TRANSFORM_CANNOT_INITIALIZE_ACM_DRIVER
    //
    // MessageText:
    //
    // An audio compression manager driver could not be initialized by the transform.%0
    //
    MF_E_TRANSFORM_CANNOT_INITIALIZE_ACM_DRIVER = HRESULT($C00D6D78);

    /// ///////////////////////////////////////////////////////////////////////////
    //
    // Content Protection errors
    //
    /// ///////////////////////////////////////////////////////////////////////////

    //
    // MessageId: MF_E_LICENSE_INCORRECT_RIGHTS
    //
    // MessageText:
    //
    // You are not allowed to open this file. Contact the content provider for further assistance.%0
    //
    MF_E_LICENSE_INCORRECT_RIGHTS = HRESULT($C00D7148);

    //
    // MessageId: MF_E_LICENSE_OUTOFDATE
    //
    // MessageText:
    //
    // The license for this media file has expired. Get a new license or contact the content provider for further assistance.%0
    //
    MF_E_LICENSE_OUTOFDATE = HRESULT($C00D7149);

    //
    // MessageId: MF_E_LICENSE_REQUIRED
    //
    // MessageText:
    //
    // You need a license to perform the requested operation on this media file.%0
    //
    MF_E_LICENSE_REQUIRED = HRESULT($C00D714A);

    //
    // MessageId: MF_E_DRM_HARDWARE_INCONSISTENT
    //
    // MessageText:
    //
    // The licenses for your media files are corrupted. Contact Microsoft product support.%0
    //
    MF_E_DRM_HARDWARE_INCONSISTENT = HRESULT($C00D714B);

    //
    // MessageId: MF_E_NO_CONTENT_PROTECTION_MANAGER
    //
    // MessageText:
    //
    // The APP needs to provide IMFContentProtectionManager callback to access the protected media file.%0
    //
    MF_E_NO_CONTENT_PROTECTION_MANAGER = HRESULT($C00D714C);

    //
    // MessageId: MF_E_LICENSE_RESTORE_NO_RIGHTS
    //
    // MessageText:
    //
    // Client does not have rights to restore licenses.%0
    //
    MF_E_LICENSE_RESTORE_NO_RIGHTS = HRESULT($C00D714D);

    //
    // MessageId: MF_E_BACKUP_RESTRICTED_LICENSE
    //
    // MessageText:
    //
    // Licenses are restricted and hence can not be backed up.%0
    //
    MF_E_BACKUP_RESTRICTED_LICENSE = HRESULT($C00D714E);

    //
    // MessageId: MF_E_LICENSE_RESTORE_NEEDS_INDIVIDUALIZATION
    //
    // MessageText:
    //
    // License restore requires machine to be individualized.%0
    //
    MF_E_LICENSE_RESTORE_NEEDS_INDIVIDUALIZATION = HRESULT($C00D714F);

    //
    // MessageId: MF_S_PROTECTION_NOT_REQUIRED
    //
    // MessageText:
    //
    // Protection for stream is not required.%0
    //
    MF_S_PROTECTION_NOT_REQUIRED = HRESULT($000D7150);

    //
    // MessageId: MF_E_COMPONENT_REVOKED
    //
    // MessageText:
    //
    // Component is revoked.%0
    //
    MF_E_COMPONENT_REVOKED = HRESULT($C00D7151);

    //
    // MessageId: MF_E_TRUST_DISABLED
    //
    // MessageText:
    //
    // Trusted functionality is currently disabled on this component.%0
    //
    MF_E_TRUST_DISABLED = HRESULT($C00D7152);

    //
    // MessageId: MF_E_WMDRMOTA_NO_ACTION
    //
    // MessageText:
    //
    // No Action is set on WMDRM Output Trust Authority.%0
    //
    MF_E_WMDRMOTA_NO_ACTION = HRESULT($C00D7153);

    //
    // MessageId: MF_E_WMDRMOTA_ACTION_ALREADY_SET
    //
    // MessageText:
    //
    // Action is already set on WMDRM Output Trust Authority.%0
    //
    MF_E_WMDRMOTA_ACTION_ALREADY_SET = HRESULT($C00D7154);

    //
    // MessageId: MF_E_WMDRMOTA_DRM_HEADER_NOT_AVAILABLE
    //
    // MessageText:
    //
    // DRM Heaader is not available.%0
    //
    MF_E_WMDRMOTA_DRM_HEADER_NOT_AVAILABLE = HRESULT($C00D7155);

    //
    // MessageId: MF_E_WMDRMOTA_DRM_ENCRYPTION_SCHEME_NOT_SUPPORTED
    //
    // MessageText:
    //
    // Current encryption scheme is not supported.%0
    //
    MF_E_WMDRMOTA_DRM_ENCRYPTION_SCHEME_NOT_SUPPORTED = HRESULT($C00D7156);

    //
    // MessageId: MF_E_WMDRMOTA_ACTION_MISMATCH
    //
    // MessageText:
    //
    // Action does not match with current configuration.%0
    //
    MF_E_WMDRMOTA_ACTION_MISMATCH = HRESULT($C00D7157);

    //
    // MessageId: MF_E_WMDRMOTA_INVALID_POLICY
    //
    // MessageText:
    //
    // Invalid policy for WMDRM Output Trust Authority.%0
    //
    MF_E_WMDRMOTA_INVALID_POLICY = HRESULT($C00D7158);

    //
    // MessageId: MF_E_POLICY_UNSUPPORTED
    //
    // MessageText:
    //
    // The policies that the Input Trust Authority requires to be enforced are unsupported by the outputs.%0
    //
    MF_E_POLICY_UNSUPPORTED = HRESULT($C00D7159);

    //
    // MessageId: MF_E_OPL_NOT_SUPPORTED
    //
    // MessageText:
    //
    // The OPL that the license requires to be enforced are not supported by the Input Trust Authority.%0
    //
    MF_E_OPL_NOT_SUPPORTED = HRESULT($C00D715A);

    //
    // MessageId: MF_E_TOPOLOGY_VERIFICATION_FAILED
    //
    // MessageText:
    //
    // The topology could not be successfully verified.%0
    //
    MF_E_TOPOLOGY_VERIFICATION_FAILED = HRESULT($C00D715B);

    //
    // MessageId: MF_E_SIGNATURE_VERIFICATION_FAILED
    //
    // MessageText:
    //
    // Signature verification could not be completed successfully for this component.%0
    //
    MF_E_SIGNATURE_VERIFICATION_FAILED = HRESULT($C00D715C);

    //
    // MessageId: MF_E_DEBUGGING_NOT_ALLOWED
    //
    // MessageText:
    //
    // Running this process under a debugger while using protected content is not allowed.%0
    //
    MF_E_DEBUGGING_NOT_ALLOWED = HRESULT($C00D715D);

    //
    // MessageId: MF_E_CODE_EXPIRED
    //
    // MessageText:
    //
    // MF component has expired.%0
    //
    MF_E_CODE_EXPIRED = HRESULT($C00D715E);

    //
    // MessageId: MF_E_GRL_VERSION_TOO_LOW
    //
    // MessageText:
    //
    // The current GRL on the machine does not meet the minimum version requirements.%0
    //
    MF_E_GRL_VERSION_TOO_LOW = HRESULT($C00D715F);

    //
    // MessageId: MF_E_GRL_RENEWAL_NOT_FOUND
    //
    // MessageText:
    //
    // The current GRL on the machine does not contain any renewal entries for the specified revocation.%0
    //
    MF_E_GRL_RENEWAL_NOT_FOUND = HRESULT($C00D7160);

    //
    // MessageId: MF_E_GRL_EXTENSIBLE_ENTRY_NOT_FOUND
    //
    // MessageText:
    //
    // The current GRL on the machine does not contain any extensible entries for the specified extension GUID.%0
    //
    MF_E_GRL_EXTENSIBLE_ENTRY_NOT_FOUND = HRESULT($C00D7161);

    //
    // MessageId: MF_E_KERNEL_UNTRUSTED
    //
    // MessageText:
    //
    // The kernel isn't secure for high security level content.%0
    //
    MF_E_KERNEL_UNTRUSTED = HRESULT($C00D7162);

    //
    // MessageId: MF_E_PEAUTH_UNTRUSTED
    //
    // MessageText:
    //
    // The response from protected environment driver isn't valid.%0
    //
    MF_E_PEAUTH_UNTRUSTED = HRESULT($C00D7163);

    //
    // MessageId: MF_E_NON_PE_PROCESS
    //
    // MessageText:
    //
    // A non-PE process tried to talk to PEAuth.%0
    //
    MF_E_NON_PE_PROCESS = HRESULT($C00D7165);

    //
    // MessageId: MF_E_REBOOT_REQUIRED
    //
    // MessageText:
    //
    // We need to reboot the machine.%0
    //
    MF_E_REBOOT_REQUIRED = HRESULT($C00D7167);

    //
    // MessageId: MF_S_WAIT_FOR_POLICY_SET
    //
    // MessageText:
    //
    // Protection for this stream is not guaranteed to be enforced until the MEPolicySet event is fired.%0
    //
    MF_S_WAIT_FOR_POLICY_SET = HRESULT($000D7168);

    //
    // MessageId: MF_S_VIDEO_DISABLED_WITH_UNKNOWN_SOFTWARE_OUTPUT
    //
    // MessageText:
    //
    // This video stream is disabled because it is being sent to an unknown software output.%0
    //
    MF_S_VIDEO_DISABLED_WITH_UNKNOWN_SOFTWARE_OUTPUT = HRESULT($000D7169);

    //
    // MessageId: MF_E_GRL_INVALID_FORMAT
    //
    // MessageText:
    //
    // The GRL file is not correctly formed, it may have been corrupted or overwritten.%0
    //
    MF_E_GRL_INVALID_FORMAT = HRESULT($C00D716A);

    //
    // MessageId: MF_E_GRL_UNRECOGNIZED_FORMAT
    //
    // MessageText:
    //
    // The GRL file is in a format newer than those recognized by this GRL Reader.%0
    //
    MF_E_GRL_UNRECOGNIZED_FORMAT = HRESULT($C00D716B);

    //
    // MessageId: MF_E_ALL_PROCESS_RESTART_REQUIRED
    //
    // MessageText:
    //
    // The GRL was reloaded and required all processes that can run protected media to restart.%0
    //
    MF_E_ALL_PROCESS_RESTART_REQUIRED = HRESULT($C00D716C);

    //
    // MessageId: MF_E_PROCESS_RESTART_REQUIRED
    //
    // MessageText:
    //
    // The GRL was reloaded and the current process needs to restart.%0
    //
    MF_E_PROCESS_RESTART_REQUIRED = HRESULT($C00D716D);

    //
    // MessageId: MF_E_USERMODE_UNTRUSTED
    //
    // MessageText:
    //
    // The user space is untrusted for protected content play.%0
    //
    MF_E_USERMODE_UNTRUSTED = HRESULT($C00D716E);

    //
    // MessageId: MF_E_PEAUTH_SESSION_NOT_STARTED
    //
    // MessageText:
    //
    // PEAuth communication session hasn't been started.%0
    //
    MF_E_PEAUTH_SESSION_NOT_STARTED = HRESULT($C00D716F);

    //
    // MessageId: MF_E_PEAUTH_PUBLICKEY_REVOKED
    //
    // MessageText:
    //
    // PEAuth's public key is revoked.%0
    //
    MF_E_PEAUTH_PUBLICKEY_REVOKED = HRESULT($C00D7171);

    //
    // MessageId: MF_E_GRL_ABSENT
    //
    // MessageText:
    //
    // The GRL is absent.%0
    //
    MF_E_GRL_ABSENT = HRESULT($C00D7172);

    //
    // MessageId: MF_S_PE_TRUSTED
    //
    // MessageText:
    //
    // The Protected Environment is trusted.%0
    //
    MF_S_PE_TRUSTED = HRESULT($000D7173);

    //
    // MessageId: MF_E_PE_UNTRUSTED
    //
    // MessageText:
    //
    // The Protected Environment is untrusted.%0
    //
    MF_E_PE_UNTRUSTED = HRESULT($C00D7174);

    //
    // MessageId: MF_E_PEAUTH_NOT_STARTED
    //
    // MessageText:
    //
    // The Protected Environment Authorization service (PEAUTH) has not been started.%0
    //
    MF_E_PEAUTH_NOT_STARTED = HRESULT($C00D7175);

    //
    // MessageId: MF_E_INCOMPATIBLE_SAMPLE_PROTECTION
    //
    // MessageText:
    //
    // The sample protection algorithms supported by components are not compatible.%0
    //
    MF_E_INCOMPATIBLE_SAMPLE_PROTECTION = HRESULT($C00D7176);

    //
    // MessageId: MF_E_PE_SESSIONS_MAXED
    //
    // MessageText:
    //
    // No more protected environment sessions can be supported.%0
    //
    MF_E_PE_SESSIONS_MAXED = HRESULT($C00D7177);

    //
    // MessageId: MF_E_HIGH_SECURITY_LEVEL_CONTENT_NOT_ALLOWED
    //
    // MessageText:
    //
    // WMDRM ITA does not allow protected content with high security level for this release.%0
    //
    MF_E_HIGH_SECURITY_LEVEL_CONTENT_NOT_ALLOWED = HRESULT($C00D7178);

    //
    // MessageId: MF_E_TEST_SIGNED_COMPONENTS_NOT_ALLOWED
    //
    // MessageText:
    //
    // WMDRM ITA cannot allow the requested action for the content as one or more components is not properly signed.%0
    //
    MF_E_TEST_SIGNED_COMPONENTS_NOT_ALLOWED = HRESULT($C00D7179);

    //
    // MessageId: MF_E_ITA_UNSUPPORTED_ACTION
    //
    // MessageText:
    //
    // WMDRM ITA does not support the requested action.%0
    //
    MF_E_ITA_UNSUPPORTED_ACTION = HRESULT($C00D717A);

    //
    // MessageId: MF_E_ITA_ERROR_PARSING_SAP_PARAMETERS
    //
    // MessageText:
    //
    // WMDRM ITA encountered an error in parsing the Secure Audio Path parameters.%0
    //
    MF_E_ITA_ERROR_PARSING_SAP_PARAMETERS = HRESULT($C00D717B);

    //
    // MessageId: MF_E_POLICY_MGR_ACTION_OUTOFBOUNDS
    //
    // MessageText:
    //
    // The Policy Manager action passed in is invalid.%0
    //
    MF_E_POLICY_MGR_ACTION_OUTOFBOUNDS = HRESULT($C00D717C);

    //
    // MessageId: MF_E_BAD_OPL_STRUCTURE_FORMAT
    //
    // MessageText:
    //
    // The structure specifying Output Protection Level is not the correct format.%0
    //
    MF_E_BAD_OPL_STRUCTURE_FORMAT = HRESULT($C00D717D);

    //
    // MessageId: MF_E_ITA_UNRECOGNIZED_ANALOG_VIDEO_PROTECTION_GUID
    //
    // MessageText:
    //
    // WMDRM ITA does not recognize the Explicite Analog Video Output Protection guid specified in the license.%0
    //
    MF_E_ITA_UNRECOGNIZED_ANALOG_VIDEO_PROTECTION_GUID = HRESULT($C00D717E);

    //
    // MessageId: MF_E_NO_PMP_HOST
    //
    // MessageText:
    //
    // IMFPMPHost object not available.%0
    //
    MF_E_NO_PMP_HOST = HRESULT($C00D717F);

    //
    // MessageId: MF_E_ITA_OPL_DATA_NOT_INITIALIZED
    //
    // MessageText:
    //
    // WMDRM ITA could not initialize the Output Protection Level data.%0
    //
    MF_E_ITA_OPL_DATA_NOT_INITIALIZED = HRESULT($C00D7180);

    //
    // MessageId: MF_E_ITA_UNRECOGNIZED_ANALOG_VIDEO_OUTPUT
    //
    // MessageText:
    //
    // WMDRM ITA does not recognize the Analog Video Output specified by the OTA.%0
    //
    MF_E_ITA_UNRECOGNIZED_ANALOG_VIDEO_OUTPUT = HRESULT($C00D7181);

    //
    // MessageId: MF_E_ITA_UNRECOGNIZED_DIGITAL_VIDEO_OUTPUT
    //
    // MessageText:
    //
    // WMDRM ITA does not recognize the Digital Video Output specified by the OTA.%0
    //
    MF_E_ITA_UNRECOGNIZED_DIGITAL_VIDEO_OUTPUT = HRESULT($C00D7182);

    //
    // MessageId: MF_E_RESOLUTION_REQUIRES_PMP_CREATION_CALLBACK
    //
    // MessageText:
    //
    // The protected stream cannot be resolved without the callback PKEY_PMP_Creation_Callback in the configuration property store.%0
    //
    MF_E_RESOLUTION_REQUIRES_PMP_CREATION_CALLBACK = HRESULT($C00D7183);

    //
    // MessageId: MF_E_INVALID_AKE_CHANNEL_PARAMETERS
    //
    // MessageText:
    //
    // A valid hostname and port number could not be found in the DTCP parameters.%0
    //
    MF_E_INVALID_AKE_CHANNEL_PARAMETERS = HRESULT($C00D7184);

    //
    // MessageId: MF_E_CONTENT_PROTECTION_SYSTEM_NOT_ENABLED
    //
    // MessageText:
    //
    // The content protection system was not enabled by the application.%0
    //
    MF_E_CONTENT_PROTECTION_SYSTEM_NOT_ENABLED = HRESULT($C00D7185);

    //
    // MessageId: MF_E_UNSUPPORTED_CONTENT_PROTECTION_SYSTEM
    //
    // MessageText:
    //
    // The content protection system is not supported.%0
    //
    MF_E_UNSUPPORTED_CONTENT_PROTECTION_SYSTEM = HRESULT($C00D7186);

    //
    // MessageId: MF_E_DRM_MIGRATION_NOT_SUPPORTED
    //
    // MessageText:
    //
    // DRM migration is not supported for the content.%0
    //
    MF_E_DRM_MIGRATION_NOT_SUPPORTED = HRESULT($C00D7187);

    //
    // MessageId: MF_E_HDCP_AUTHENTICATION_FAILURE
    //
    // MessageText:
    //
    // Authentication of the HDCP link failed.%0
    //
    MF_E_HDCP_AUTHENTICATION_FAILURE = HRESULT($C00D7188);

    //
    // MessageId: MF_E_HDCP_LINK_FAILURE
    //
    // MessageText:
    //
    // The HDCP link failed after being established.%0
    //
    MF_E_HDCP_LINK_FAILURE = HRESULT($C00D7189);

    /// ///////////////////////////////////////////////////////////////////////////
    //
    // Clock errors
    //
    /// ///////////////////////////////////////////////////////////////////////////

    //
    // MessageId: MF_E_CLOCK_INVALID_CONTINUITY_KEY
    //
    // MessageText:
    //
    // The continuity key supplied is not currently valid.%0
    //
    MF_E_CLOCK_INVALID_CONTINUITY_KEY = HRESULT($C00D9C40);

    //
    // MessageId: MF_E_CLOCK_NO_TIME_SOURCE
    //
    // MessageText:
    //
    // No Presentation Time Source has been specified.%0
    //
    MF_E_CLOCK_NO_TIME_SOURCE = HRESULT($C00D9C41);

    //
    // MessageId: MF_E_CLOCK_STATE_ALREADY_SET
    //
    // MessageText:
    //
    // The clock is already in the requested state.%0
    //
    MF_E_CLOCK_STATE_ALREADY_SET = HRESULT($C00D9C42);

    //
    // MessageId: MF_E_CLOCK_NOT_SIMPLE
    //
    // MessageText:
    //
    // The clock has too many advanced features to carry out the request.%0
    //
    MF_E_CLOCK_NOT_SIMPLE = HRESULT($C00D9C43);

    //
    // MessageId: MF_S_CLOCK_STOPPED
    //
    // MessageText:
    //
    // Timer::SetTimer returns this success code if called happened while timer is stopped. Timer is not going to be dispatched until clock is running.%0
    //
    MF_S_CLOCK_STOPPED = HRESULT($000D9C44);

    /// ///////////////////////////////////////////////////////////////////////////
    //
    // MF Quality Management errors
    //
    /// ///////////////////////////////////////////////////////////////////////////

    //
    // MessageId: MF_E_NO_MORE_DROP_MODES
    //
    // MessageText:
    //
    // The component does not support any more drop modes.%0
    //
    MF_E_NO_MORE_DROP_MODES = HRESULT($C00DA028);

    //
    // MessageId: MF_E_NO_MORE_QUALITY_LEVELS
    //
    // MessageText:
    //
    // The component does not support any more quality levels.%0
    //
    MF_E_NO_MORE_QUALITY_LEVELS = HRESULT($C00DA029);

    //
    // MessageId: MF_E_DROPTIME_NOT_SUPPORTED
    //
    // MessageText:
    //
    // The component does not support drop time functionality.%0
    //
    MF_E_DROPTIME_NOT_SUPPORTED = HRESULT($C00DA02A);

    //
    // MessageId: MF_E_QUALITYKNOB_WAIT_LONGER
    //
    // MessageText:
    //
    // Quality Manager needs to wait longer before bumping the Quality Level up.%0
    //
    MF_E_QUALITYKNOB_WAIT_LONGER = HRESULT($C00DA02B);

    //
    // MessageId: MF_E_QM_INVALIDSTATE
    //
    // MessageText:
    //
    // Quality Manager is in an invalid state. Quality Management is off at this moment.%0
    //
    MF_E_QM_INVALIDSTATE = HRESULT($C00DA02C);

    /// ///////////////////////////////////////////////////////////////////////////
    //
    // MF Transcode errors
    //
    /// ///////////////////////////////////////////////////////////////////////////

    //
    // MessageId: MF_E_TRANSCODE_NO_CONTAINERTYPE
    //
    // MessageText:
    //
    // No transcode output container type is specified.%0
    //
    MF_E_TRANSCODE_NO_CONTAINERTYPE = HRESULT($C00DA410);

    //
    // MessageId: MF_E_TRANSCODE_PROFILE_NO_MATCHING_STREAMS
    //
    // MessageText:
    //
    // The profile does not have a media type configuration for any selected source streams.%0
    //
    MF_E_TRANSCODE_PROFILE_NO_MATCHING_STREAMS = HRESULT($C00DA411);

    //
    // MessageId: MF_E_TRANSCODE_NO_MATCHING_ENCODER
    //
    // MessageText:
    //
    // Cannot find an encoder MFT that accepts the user preferred output type.%0
    //
    MF_E_TRANSCODE_NO_MATCHING_ENCODER = HRESULT($C00DA412);

    //
    // MessageId: MF_E_TRANSCODE_INVALID_PROFILE
    //
    // MessageText:
    //
    // The profile is invalid.%0
    //
    MF_E_TRANSCODE_INVALID_PROFILE = HRESULT($C00DA413);

    /// ///////////////////////////////////////////////////////////////////////////
    //
    // MF HW Device Proxy errors
    //
    /// ///////////////////////////////////////////////////////////////////////////

    //
    // MessageId: MF_E_ALLOCATOR_NOT_INITIALIZED
    //
    // MessageText:
    //
    // Memory allocator is not initialized.%0
    //
    MF_E_ALLOCATOR_NOT_INITIALIZED = HRESULT($C00DA7F8);

    //
    // MessageId: MF_E_ALLOCATOR_NOT_COMMITED
    //
    // MessageText:
    //
    // Memory allocator is not committed yet.%0
    //
    MF_E_ALLOCATOR_NOT_COMMITED = HRESULT($C00DA7F9);

    //
    // MessageId: MF_E_ALLOCATOR_ALREADY_COMMITED
    //
    // MessageText:
    //
    // Memory allocator has already been committed.%0
    //
    MF_E_ALLOCATOR_ALREADY_COMMITED = HRESULT($C00DA7FA);

    //
    // MessageId: MF_E_STREAM_ERROR
    //
    // MessageText:
    //
    // An error occurred in media stream.%0
    //
    MF_E_STREAM_ERROR = HRESULT($C00DA7FB);

    //
    // MessageId: MF_E_INVALID_STREAM_STATE
    //
    // MessageText:
    //
    // Stream is not in a state to handle the request.%0
    //
    MF_E_INVALID_STREAM_STATE = HRESULT($C00DA7FC);

    //
    // MessageId: MF_E_HW_STREAM_NOT_CONNECTED
    //
    // MessageText:
    //
    // Hardware stream is not connected yet.%0
    //
    MF_E_HW_STREAM_NOT_CONNECTED = HRESULT($C00DA7FD);

    /// ///////////////////////////////////////////////////////////////////////////
    //
    // MF Capture Engine and MediaCapture errors
    //
    /// ///////////////////////////////////////////////////////////////////////////

    //
    // MessageId: MF_E_NO_CAPTURE_DEVICES_AVAILABLE
    //
    // MessageText:
    //
    // No capture devices are available.%0
    //
    MF_E_NO_CAPTURE_DEVICES_AVAILABLE = HRESULT($C00DABE0);

    //
    // MessageId: MF_E_CAPTURE_SINK_OUTPUT_NOT_SET
    //
    // MessageText:
    //
    // No output was set for recording.%0
    //
    MF_E_CAPTURE_SINK_OUTPUT_NOT_SET = HRESULT($C00DABE1);

    //
    // MessageId: MF_E_CAPTURE_SINK_MIRROR_ERROR
    //
    // MessageText:
    //
    // The current capture sink configuration does not support mirroring.%0
    //
    MF_E_CAPTURE_SINK_MIRROR_ERROR = HRESULT($C00DABE2);

    //
    // MessageId: MF_E_CAPTURE_SINK_ROTATE_ERROR
    //
    // MessageText:
    //
    // The current capture sink configuration does not support rotation.%0
    //
    MF_E_CAPTURE_SINK_ROTATE_ERROR = HRESULT($C00DABE3);

    //
    // MessageId: MF_E_CAPTURE_ENGINE_INVALID_OP
    //
    // MessageText:
    //
    // The op is invalid.%0
    //
    MF_E_CAPTURE_ENGINE_INVALID_OP = HRESULT($C00DABE4);

    //
    // MessageId: MF_E_CAPTURE_ENGINE_ALL_EFFECTS_REMOVED
    //
    // MessageText:
    //
    // The effects previously added were incompatible with the new topology which caused all effects to be removed.%0
    //
    MF_E_CAPTURE_ENGINE_ALL_EFFECTS_REMOVED = HRESULT($C00DABE5);

    //
    // MessageId: MF_E_CAPTURE_SOURCE_NO_INDEPENDENT_PHOTO_STREAM_PRESENT
    //
    // MessageText:
    //
    // The current capture source does not have an independent photo stream.%0
    //
    MF_E_CAPTURE_SOURCE_NO_INDEPENDENT_PHOTO_STREAM_PRESENT = HRESULT($C00DABE6);

    //
    // MessageId: MF_E_CAPTURE_SOURCE_NO_VIDEO_STREAM_PRESENT
    //
    // MessageText:
    //
    // The current capture source does not have a video stream.%0
    //
    MF_E_CAPTURE_SOURCE_NO_VIDEO_STREAM_PRESENT = HRESULT($C00DABE7);

    //
    // MessageId: MF_E_CAPTURE_SOURCE_NO_AUDIO_STREAM_PRESENT
    //
    // MessageText:
    //
    // The current capture source does not have an audio stream.%0
    //
    MF_E_CAPTURE_SOURCE_NO_AUDIO_STREAM_PRESENT = HRESULT($C00DABE8);

    //
    // MessageId: MF_E_CAPTURE_SOURCE_DEVICE_EXTENDEDPROP_OP_IN_PROGRESS
    //
    // MessageText:
    //
    // The capture source device has an asynchronous extended property operation in progress.%0
    //
    MF_E_CAPTURE_SOURCE_DEVICE_EXTENDEDPROP_OP_IN_PROGRESS = HRESULT($C00DABE9);

    //
    // MessageId: MF_E_CAPTURE_PROPERTY_SET_DURING_PHOTO
    //
    // MessageText:
    //
    // A property cannot be set because a photo or photo sequence is in progress.%0
    //
    MF_E_CAPTURE_PROPERTY_SET_DURING_PHOTO = HRESULT($C00DABEA);

    //
    // MessageId: MF_E_CAPTURE_NO_SAMPLES_IN_QUEUE
    //
    // MessageText:
    //
    // No more samples in queue.%0
    //
    MF_E_CAPTURE_NO_SAMPLES_IN_QUEUE = HRESULT($C00DABEB);

    //
    // MessageId: MF_E_HW_ACCELERATED_THUMBNAIL_NOT_SUPPORTED
    //
    // MessageText:
    //
    // Hardware accelerated thumbnail generation is not supported for the currently selected mediatype on the mediacapture stream.%0
    //
    MF_E_HW_ACCELERATED_THUMBNAIL_NOT_SUPPORTED = HRESULT($C00DABEC);

    /// ///////////////////////////////////////////////////////////////////////////
    //
    // MF Media Engine errors - see W3C definitions for details
    //
    /// ///////////////////////////////////////////////////////////////////////////

    MF_INDEX_SIZE_ERR = $80700001;
    MF_NOT_FOUND_ERR = $80700008;
    MF_NOT_SUPPORTED_ERR = $80700009;
    MF_INVALID_STATE_ERR = $8070000B;
    MF_SYNTAX_ERR = $8070000C;
    MF_INVALID_ACCESS_ERR = $8070000F;
    MF_QUOTA_EXCEEDED_ERR = $80700016;
    MF_PARSE_ERR = $80700051;

function STATUS_SEVERITY(Hr: HRESULT): dword; inline;

implementation

function STATUS_SEVERITY(Hr: HRESULT): dword; inline;
begin
    result := ((Hr shl 30) AND $3);
end;

end.
