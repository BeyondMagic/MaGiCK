import Service from '../service.js';
type PlaybackStatus = 'Playing' | 'Paused' | 'Stopped';
type LoopStatus = 'None' | 'Track' | 'Playlist';
export declare class MprisPlayer extends Service {
    get bus_name(): string;
    get name(): string;
    get entry(): string;
    get identity(): string;
    get trackid(): string;
    get track_artists(): string[];
    get track_title(): string;
    get track_cover_url(): string;
    get cover_path(): string;
    get play_back_status(): PlaybackStatus;
    get can_go_next(): boolean;
    get can_go_prev(): boolean;
    get can_play(): boolean;
    get shuffle_status(): boolean | null;
    get loop_status(): LoopStatus | null;
    get length(): number;
    private _busName;
    private _name;
    private _entry;
    private _identity;
    private _trackid;
    private _trackArtists;
    private _trackTitle;
    private _trackCoverUrl;
    private _coverPath;
    private _playBackStatus;
    private _canGoNext;
    private _canGoPrev;
    private _canPlay;
    private _shuffleStatus;
    private _loopStatus;
    private _length;
    private _binding;
    private _mprisProxy;
    private _playerProxy;
    constructor(busName: string);
    close(): void;
    private _onMprisProxyReady;
    private _onPlayerProxyReady;
    private _updateState;
    private _cacheCoverArt;
    get volume(): number;
    set volume(value: number);
    get position(): number;
    set position(time: number);
    playPause(): void;
    play(): void;
    stop(): void;
    next(): void;
    previous(): void;
    shuffle(): void;
    loop(): void;
}
export declare class Mpris extends Service {
    private _proxy;
    private _players;
    get players(): MprisPlayer[];
    constructor();
    private _addPlayer;
    private _onProxyReady;
    private _onNameOwnerChanged;
    getPlayer(name?: string): MprisPlayer | null;
}
export declare const mpris: Mpris;
export default mpris;
