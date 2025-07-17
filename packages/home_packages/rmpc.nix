{ pkgs, userSettings, ... }:
{
	imports = [
		./mpd.nix
	];

	programs.rmpc = {
		enable = true;
		package = pkgs.rmpc;
	};

	home.file."/home/${userSettings.username}/.config/rmpc/config.ron".text = ''
#![enable(implicit_some)]
#![enable(unwrap_newtypes)]
#![enable(unwrap_variant_newtypes)]
(
    address: "127.0.0.1:6600",
    password: None,
    theme: Some("default"),
    cache_dir: None,
    lyrics_dir: Some("${userSettings.musicDir}"),
    on_song_change: None,
    volume_step: 5,
    max_fps: 30,
    scrolloff: 0,
    wrap_navigation: false,
    enable_mouse: true,
    status_update_interval_ms: 1000,
    select_current_song_on_change: false,
    album_art: (
        method: Auto,
        max_size_px: (width: 1200, height: 1200),
        disabled_protocols: ["http://", "https://"],
        vertical_align: Center,
        horizontal_align: Center,
    ),
    keybinds: (
        global: {
            ":":       CommandMode,
            ",":       VolumeDown,
            "s":       Stop,
            ".":       VolumeUp,
            "<Tab>":   NextTab,
            "<S-Tab>": PreviousTab,
            "1":       SwitchToTab("Queue"),
            "2":       SwitchToTab("Albums"),
            "3":       SwitchToTab("Album Artists"),
            "4":       SwitchToTab("Playlists"),
            "5":       SwitchToTab("Search"),
            "q":       Quit,
            ">":       NextTrack,
            "p":       TogglePause,
            "<":       PreviousTrack,
            "f":       SeekForward,
            "x":       ToggleRepeat,
            "c":       ToggleRandom,
            "v":       ToggleConsume,
            "z":       ToggleSingle,
            "b":       SeekBack,
            "~":       ShowHelp,
            "I":       ShowCurrentSongInfo,
            "O":       ShowOutputs,
            "P":       ShowDecoders,
        },
        navigation: {
            "k":         Up,
            "j":         Down,
            "h":         Left,
            "l":         Right,
            "<Up>":      Up,
            "<Down>":    Down,
            "<Left>":    Left,
            "<Right>":   Right,
            "<C-k>":     PaneUp,
            "<C-j>":     PaneDown,
            "<C-h>":     PaneLeft,
            "<C-l>":     PaneRight,
            "<C-u>":     UpHalf,
            "N":         PreviousResult,
            "a":         Add,
            "A":         AddAll,
            "r":         Rename,
            "n":         NextResult,
            "g":         Top,
            "<Space>":   Select,
            "<C-Space>": InvertSelection,
            "G":         Bottom,
            "<CR>":      Confirm,
            "i":         FocusInput,
            "J":         MoveDown,
            "<C-d>":     DownHalf,
            "/":         EnterSearch,
            "<C-c>":     Close,
            "<Esc>":     Close,
            "K":         MoveUp,
            "D":         Delete,
        },
        queue: {
            "D":       DeleteAll,
            "<CR>":    Play,
            "<C-s>":   Save,
            "a":       AddToPlaylist,
            "d":       Delete,
            "i":       ShowInfo,
            "C":       JumpToCurrent,
        },
    ),
    search: (
        case_sensitive: false,
        mode: Contains,
        tags: [
            (value: "any",         label: "Any Tag"),
            (value: "artist",      label: "Artist"),
            (value: "album",       label: "Album"),
            (value: "albumartist", label: "Album Artist"),
            (value: "title",       label: "Title"),
            (value: "filename",    label: "Filename"),
            (value: "genre",       label: "Genre"),
        ],
    ),
    artists: (
        album_display_mode: SplitByDate,
        album_sort_by: Date,
    ),
    tabs: [
        (
            name: "Queue",
            pane: Split(
                direction: Vertical,
                panes: [
                    (
                        size: "100%",
                        borders: "NONE",
                        pane: Split(
                            direction: Horizontal,
                            borders: "NONE",
                            panes: [
                                (
                                    size: "75%",
                                    borders: "ALL",
                                    pane: Pane(Queue),
                                ),
                                (
                                    size: "25%",
                                    borders: "ALL",
                                    pane: Split(
                                        direction: Vertical,
                                        panes: [
                                            (
                                                size: "60%",
                                                borders: "ALL",
                                                pane: Pane(AlbumArt),
                                            ),
                                            (
                                                size: "40%",
                                                borders: "NONE",
                                                pane: Pane(Lyrics),
                                            ),
                                        ],
                                    ),
                                ),
                            ],
                        ),
                    ),
                ],
            ),
        ),
        (
            name: "Albums",
            pane: Split(
                direction: Horizontal,
                panes: [
                    (
                        size: "100%",
                        borders: "ALL",
                        pane: Pane(Albums),
                    )
                ]
            )
        ),
        (
            name: "Album Artists",
            pane: Split(
                direction: Horizontal,
                panes: [
                    (
                        size: "100%",
                        borders: "ALL",
                        pane: Pane(AlbumArtists),
                    )
                ]
            )
        ),
        (
            name: "Playlists",
            pane: Split(
                direction: Horizontal,
                panes: [
                    (
                        size: "100%",
                        borders: "ALL",
                        pane: Pane(Playlists),
                    )
                ]
            )
        ),
        (
            name: "Search",
            pane: Split(
                direction: Horizontal,
                panes: [
                    (
                        size: "100%",
                        borders: "ALL",
                        pane: Pane(Search),
                    )
                ]
            )
        ),
    ],
)
	'';

	home.file."/home/${userSettings.username}/.config/rmpc/themes/default.ron".text = ''
#![enable(implicit_some)]
#![enable(unwrap_newtypes)]
#![enable(unwrap_variant_newtypes)]
(
    default_album_art_path: None,
    show_song_table_header: true,
    draw_borders: true,
    browser_column_widths: [20, 38, 42],

    background_color: None,
    text_color: None,
    header_background_color: None,
    modal_background_color: None,

    tab_bar: (
        enabled: true,
        active_style: (fg: "black", bg: "blue", modifiers: "Bold"),
        inactive_style: (),
    ),
    highlighted_item_style: (fg: "blue", modifiers: "Bold"),
    current_item_style: (fg: "black", bg: "blue", modifiers: "Bold"),
    borders_style: (fg: "blue", modifiers: "Bold"),
    highlight_border_style: (fg: "blue"),
    symbols: (song: "S", dir: "D", marker: "M", ellipsis: "..."),
    progress_bar: (
        symbols: [ "█", "█", "█" ],
        track_style: (fg: "black", bg: "gray"),
        elapsed_style: (fg: "blue"),
        thumb_style: (fg: "blue"),
    ),
    scrollbar: (
        symbols: ["│", "│", "▲", "▼"],
        track_style: (),
        ends_style: (),
        thumb_style: (fg: "blue"),
    ),
    song_table_format: [
        (
            prop: (kind: Property(Artist),
                default: (kind: Text("Unknown"))
            ),
            width: "20%",
        ),
        (
            prop: (kind: Property(Title),
                default: (kind: Text("Unknown"))
            ),
            width: "35%",
        ),
        (
            prop: (kind: Property(Album), style: (fg: "white"),
                default: (kind: Text("Unknown Album"), style: (fg: "white"))
            ),
            width: "30%",
        ),
        (
            prop: (kind: Property(Duration),
                default: (kind: Text("-"))
            ),
            width: "15%",
            alignment: Right,
        ),
    ],
    layout: Split(
        direction: Vertical,
        panes: [
            (
                size: "3",
                pane: Pane(Tabs),
            ),
            (
                size: "4",
                borders: "ALL",
                pane: Pane(Header),
            ),
            (
                size: "100%",
                pane: Pane(TabContent),
                panes: Split(
                    direction: Horizontal,
                    panes: [
                        (
                            size: "100%",
                            borders: "NONE",
                            pane: Pane(TabContent),
                        ),
                    ],
                ),
            ),
            (
                size: "3",
                borders: "TOP | BOTTOM",
                pane: Pane(ProgressBar),
            ),
        ],
    ),
    header: (
        rows: [
            (
                left: [
                    (kind: Text("["), style: (fg: "yellow", modifiers: "Bold")),
                    (kind: Property(Status(StateV2(playing_label: "Playing", paused_label: "Paused", stopped_label: "Stopped"))), style: (fg: "yellow", modifiers: "Bold")),
                    (kind: Text("]"), style: (fg: "yellow", modifiers: "Bold"))
                ],
                center: [
                    (kind: Property(Song(Title)), style: (modifiers: "Bold"),
                        default: (kind: Text("No Song"), style: (modifiers: "Bold"))
                    )
                ],
                right: [
                    (kind: Property(Widget(Volume)), style: (fg: "blue"))
                ]
            ),
            (
                left: [
                    (kind: Property(Status(Elapsed))),
                    (kind: Text(" / ")),
                    (kind: Property(Status(Duration))),
                    (kind: Text(" (")),
                    (kind: Property(Status(Bitrate))),
                    (kind: Text(" kbps)"))
                ],
                center: [
                    (kind: Property(Song(Artist)), style: (fg: "yellow", modifiers: "Bold"),
                        default: (kind: Text("Unknown"), style: (fg: "yellow", modifiers: "Bold"))
                    ),
                    (kind: Text(" - ")),
                    (kind: Property(Song(Album)),
                        default: (kind: Text("Unknown Album"))
                    )
                ],
                right: [
                    (
                        kind: Property(Widget(States(
                            active_style: (fg: "white", modifiers: "Bold"),
                            separator_style: (fg: "white")))
                        ),
                        style: (fg: "dark_gray")
                    ),
                ]
            ),
        ],
    ),
    browser_song_format: [
        (
            kind: Group([
                (kind: Property(Track)),
                (kind: Text(" ")),
            ])
        ),
        (
            kind: Group([
                (kind: Property(Artist)),
                (kind: Text(" - ")),
                (kind: Property(Title)),
            ]),
            default: (kind: Property(Filename))
        ),
    ],
)
	'';
}