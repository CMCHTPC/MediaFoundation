// +-------------------------------------------------------------------------

// Microsoft Windows
// Copyright (c) Microsoft Corporation. All rights reserved.

// --------------------------------------------------------------------------

unit CMC.HString;
{$IFDEF FPC}
{$MODE delphi}
{$ENDIF}

interface

uses
    Windows, Classes, SysUtils;

type

    // Declaring a handle dummy struct for HSTRING the same way DECLARE_HANDLE does.
    HSTRING__ = record
        unused: integer;
    end;

    // Declare the HSTRING handle for C/C++
    HString = ^HSTRING__;

    // Declare the HSTRING_HEADER
    THSTRING_HEADER = record
        case integer of
            0:
                (Reserved1: pointer);
            1:
                (
{$IFDEF WIN64}
                    Reserved2: array [0 .. 23] of char;
{$ELSE}
                    Reserved2: array [0 .. 19] of char;
{$ENDIF}
                );
    end;

    // Declare the HSTRING_BUFFER for the HSTRING's two-phase construction functions.

    // This route eliminates the PCWSTR string copy that happens when passing it to
    // the traditional WindowsCreateString().  The caller preallocates a string buffer,
    // sets the wide character string values in that buffer, and finally promotes the
    // buffer to an HSTRING.  If a buffer is never promoted, it can still be deleted.

    HSTRING_BUFFER = pointer;

implementation

end.
