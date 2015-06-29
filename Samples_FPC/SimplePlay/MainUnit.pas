//////////////////////////////////////////////////////////////////////////

// SimplePlay sample

// THIS CODE AND INFORMATION IS PROVIDED "AS IS" WITHOUT WARRANTY OF
// ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO
// THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A
// PARTICULAR PURPOSE.

// Copyright (c) Microsoft Corporation. All rights reserved.


// This sample demonstrates how to use the MFPlay API for simple video
// playback.

//////////////////////////////////////////////////////////////////////////

unit MainUnit;

{$mode delphi}{$H+}

interface

uses
    Windows, Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs,
    ActiveX,
    Menus, CMC.MFPlay;

type

    { TMFPlaySample }

    TMFPlaySample = class(TForm)
        MainMenu1: TMainMenu;
        MenuItem1: TMenuItem;
        menuFileOpen: TMenuItem;
        MenuItem3: TMenuItem;
        menuClose: TMenuItem;
        OpenDialog1: TOpenDialog;
        procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
        procedure FormCreate(Sender: TObject);
        procedure FormDestroy(Sender: TObject);
        procedure FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
        procedure FormPaint(Sender: TObject);
        procedure FormResize(Sender: TObject);
        procedure menuCloseClick(Sender: TObject);
        procedure menuFileOpenClick(Sender: TObject);
    private
        { private declarations }
        function PlayMediaFile(hwnd: HWnd; sURL: PWideChar): HResult;

    public
        { public declarations }
    end;


    { TMediaPlayerCallback }

    //-------------------------------------------------------------------
    // MediaPlayerCallback class
    // Implements the callback interface for MFPlay events.
    //-------------------------------------------------------------------

    TMediaPlayerCallback = class(TInterfacedObject, IMFPMediaPlayerCallback)
    public
        constructor Create;
        destructor Destroy; override;
        procedure OnMediaPlayerEvent(pEventHeader: PMFP_EVENT_HEADER); stdcall;

    end;

var
    MFPlaySample: TMFPlaySample;

    // Global variables

    g_pPlayer: IMFPMediaPlayer = nil;      // The MFPlay player object.
    g_pPlayerCB: IMFPMediaPlayerCallback = nil;    // Application callback object.

    g_bHasVideo: boolean = False;

// MFPlay event handler functions.
procedure OnMediaItemCreated(pEvent: PMFP_MEDIAITEM_CREATED_EVENT);
procedure OnMediaItemSet(pEvent: PMFP_MEDIAITEM_SET_EVENT);

procedure ShowErrorMessage(format: PCWSTR; hrErr: HRESULT);

implementation

{$R *.lfm}

{ TMediaPlayerCallback }

constructor TMediaPlayerCallback.Create;
begin

end;



destructor TMediaPlayerCallback.Destroy;
begin
    inherited Destroy;
end;

//-------------------------------------------------------------------
// OnMediaPlayerEvent

// Implements IMFPMediaPlayerCallback::OnMediaPlayerEvent.
// This callback method handles events from the MFPlay object.
//-------------------------------------------------------------------
procedure TMediaPlayerCallback.OnMediaPlayerEvent(pEventHeader: PMFP_EVENT_HEADER); stdcall;
begin
    if (FAILED(pEventHeader^.hrEvent)) then
    begin
        ShowErrorMessage('Playback error', pEventHeader.hrEvent);
        exit;
    end;

    case (pEventHeader^.eEventType) of
        MFP_EVENT_TYPE_MEDIAITEM_CREATED:
        begin
            OnMediaItemCreated(MFP_GET_MEDIAITEM_CREATED_EVENT(pEventHeader));
        end;

        MFP_EVENT_TYPE_MEDIAITEM_SET:
        begin
            OnMediaItemSet(MFP_GET_MEDIAITEM_SET_EVENT(pEventHeader));
        end;
    end;
end;

{ TMFPlaySample }

procedure TMFPlaySample.FormCreate(Sender: TObject);
begin
    CoInitializeEx(nil, COINIT_APARTMENTTHREADED or COINIT_DISABLE_OLE1DDE);
end;


//-------------------------------------------------------------------
// OnClose

// Handles the WM_CLOSE message.
//-------------------------------------------------------------------

procedure TMFPlaySample.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
    if (g_pPlayer <> nil) then
    begin
        g_pPlayer.Shutdown();
        g_pPlayer := nil;
    end;

    if (g_pPlayerCB <> nil) then
        g_pPlayerCB := nil;

end;



procedure TMFPlaySample.FormDestroy(Sender: TObject);
begin
    CoUninitialize();
end;


//-------------------------------------------------------------------
// OnKeyDown

// Handles the WM_KEYDOWN message.
//-------------------------------------------------------------------
procedure TMFPlaySample.FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
var
    hr: HResult;
    state: TMFP_MEDIAPLAYER_STATE;
begin
    hr := S_OK;

    case (Key) of
        VK_SPACE:

            // Toggle between playback and paused/stopped.
            if (g_pPlayer <> nil) then
            begin
                state := MFP_MEDIAPLAYER_STATE_EMPTY;

                hr := g_pPlayer.GetState(state);

                if (SUCCEEDED(hr)) then
                begin
                    if (state = MFP_MEDIAPLAYER_STATE_PAUSED) or (state = MFP_MEDIAPLAYER_STATE_STOPPED) then
                    begin
                        hr := g_pPlayer.Play();
                    end
                    else if (state = MFP_MEDIAPLAYER_STATE_PLAYING) then
                    begin
                        hr := g_pPlayer.Pause();
                    end;
                end;
            end;

    end;

    if (FAILED(hr)) then
    begin
        ShowErrorMessage('Playback Error', hr);
    end;
end;


//-------------------------------------------------------------------
// OnPaint

// Handles the WM_PAINT message.
//-------------------------------------------------------------------

procedure TMFPlaySample.FormPaint(Sender: TObject);
var
    ps: PAINTSTRUCT;
    lhdc: HDC;

begin
    lhdc := BeginPaint(Handle, ps);
    if ((g_pPlayer <> nil) and g_bHasVideo) then
    begin
        // Playback has started and there is video.

        // Do not draw the window background, because the video
        // frame fills the entire client area.

        g_pPlayer.UpdateVideo();
    end

    else
    begin
        // There is no video stream, or playback has not started.
        // Paint the entire client area.

        FillRect(lhdc, ps.rcPaint, HBRUSH(COLOR_WINDOW + 1));
    end;
    EndPaint(Handle, ps);
end;


//-------------------------------------------------------------------
// OnSize

// Handles the WM_SIZE message.
//-------------------------------------------------------------------
procedure TMFPlaySample.FormResize(Sender: TObject);
begin
    if (g_pPlayer <> nil) then
    begin
        // Resize the video.
        g_pPlayer.UpdateVideo();
    end;
end;



procedure TMFPlaySample.menuCloseClick(Sender: TObject);
begin
    Close;
end;


//-------------------------------------------------------------------
// OnFileOpen

// Handles the "File Open" command.
//-------------------------------------------------------------------

procedure TMFPlaySample.menuFileOpenClick(Sender: TObject);
var
    hr: HResult;
    lString: string;
    pwszFilePath: pWideChar;
begin
    hr := S_OK;

    OpenDialog1.Title := 'Select a File to Play';
    if OpenDialog1.Execute then
    begin
        lString := OpenDialog1.FileName;
        pwszFilePath := pWideChar(UTF8Decode(lString));
        // Open the media file.
        hr := PlayMediaFile(Handle, pwszFilePath);
        if hr = s_OK then
            Exit;
    end;
end;




//-------------------------------------------------------------------
// PlayMediaFile

// Plays a media file, using the IMFPMediaPlayer interface.
//-------------------------------------------------------------------
function TMFPlaySample.PlayMediaFile(hwnd: HWnd; sURL: PWideChar): HResult;
var
    lMediaItem: IMFPMediaItem;
begin
    Result := S_OK;

    // Create the MFPlayer object.
    if (g_pPlayer = nil) then
    begin
        g_pPlayerCB := TMediaPlayerCallback.Create();

        if (g_pPlayerCB = nil) then
        begin
            Result := E_OUTOFMEMORY;
            exit;
        end;

        Result := MFPCreateMediaPlayer(nil, False,          // Start playback automatically?
            MFP_OPTION_NONE,              // Flags
            g_pPlayerCB,    // Callback pointer
            hwnd,           // Video window
            g_pPlayer);

        if (FAILED(Result)) then
            Exit;
    end;

    // Create a new media item for this URL.
    Result := g_pPlayer.CreateMediaItemFromURL(sURL, False, 0, lMediaItem);

    // The CreateMediaItemFromURL method completes asynchronously.
    // The application will receive an MFP_EVENT_TYPE_MEDIAITEM_CREATED
    // event. See MediaPlayerCallback::OnMediaPlayerEvent().

end;



procedure ShowErrorMessage(format: PCWSTR; hrErr: HRESULT);
var
    hr: HResult;
    msg: string;
begin
    hr := S_OK;

    msg := format + ' (0x' + IntToHex(hrErr, 8) + ')';
    if (SUCCEEDED(hr)) then
    begin
        Application.MessageBox(PChar(msg), 'Error', MB_ICONERROR);
    end;

end;

//-------------------------------------------------------------------
// OnMediaItemCreated

// Called when the IMFPMediaPlayer::CreateMediaItemFromURL method
// completes.
//-------------------------------------------------------------------
procedure OnMediaItemCreated(pEvent: PMFP_MEDIAITEM_CREATED_EVENT);
var
    hr: HResult;
    bHasVideo, bIsSelected: boolean;
begin
    hr := S_OK;

    // The media item was created successfully.

    if (g_pPlayer <> nil) then
    begin
        bHasVideo := False;
        bIsSelected := False;

        // Check if the media item contains video.
        hr := pEvent^.pMediaItem.HasVideo(bHasVideo, bIsSelected);

        if hr = S_OK then
        begin
            g_bHasVideo := bHasVideo and bIsSelected;
            // Set the media item on the player. This method completes asynchronously.
            hr := g_pPlayer.SetMediaItem(pEvent^.pMediaItem);
        end;
    end;

    if (FAILED(hr)) then
    begin
        ShowErrorMessage('Error playing this file.', hr);
    end;
end;


//-------------------------------------------------------------------
// OnMediaItemSet

// Called when the IMFPMediaPlayer::SetMediaItem method completes.
//-------------------------------------------------------------------

procedure OnMediaItemSet(pEvent: PMFP_MEDIAITEM_SET_EVENT);
var
    hr: HRESULT;
begin
    hr := g_pPlayer.Play();
    if (FAILED(hr)) then
    begin
        ShowErrorMessage('IMFPMediaPlayer.Play failed.', hr);
    end;
end;

end.
