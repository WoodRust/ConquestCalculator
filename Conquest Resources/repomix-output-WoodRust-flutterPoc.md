This file is a merged representation of a subset of the codebase, containing specifically included files and files not matching ignore patterns, combined into a single document by Repomix. The content has been processed where line numbers have been added, security check has been disabled.

# File Summary

## Purpose
This file contains a packed representation of the entire repository's contents.
It is designed to be easily consumable by AI systems for analysis, code review,
or other automated processes.

## File Format
The content is organized as follows:
1. This summary section
2. Repository information
3. Directory structure
4. Multiple file entries, each consisting of:
  a. A header with the file path (## File: path/to/file)
  b. The full contents of the file in a code block

## Usage Guidelines
- This file should be treated as read-only. Any changes should be made to the
  original repository files, not this packed version.
- When processing this file, use the file path to distinguish
  between different files in the repository.
- Be aware that this file may contain sensitive information. Handle it with
  the same level of security as you would the original repository.

## Notes
- Some files may have been excluded based on .gitignore rules and Repomix's configuration
- Binary files are not included in this packed representation. Please refer to the Repository Structure section for a complete list of file paths, including binary files
- Only files matching these patterns are included: **/*.dart, **/lib/**/, **/pubspec.yaml, **/analysis_options.yaml, **/android/app/src/main/**/, **/ios/Runner/**/, **/assets/**/, **/l10n/**/, **/*.md, **/models/**/, **/providers/**/, **/blocs/**/*
- Files matching these patterns are excluded: **/.dart_tool/**/, **/build/**/, **/.idea/**/, **/.vscode/**/, **/.flutter-plugins*, **/.packages, **/generated_plugin*, **/*.g.dart, **/*.freezed.dart, **/ios/Pods/**/, **/.symlinks/**/
- Files matching patterns in .gitignore are excluded
- Files matching default ignore patterns are excluded
- Line numbers have been added to the beginning of each line
- Security check has been disabled - content may contain sensitive information

## Additional Info

# Directory Structure
```
.github/
  PULL_REQUEST_TEMPLATE.md
samples/
  ads/
    assets/
      music/
        README.md
      sfx/
        README.md
    ios/
      Runner/
        Assets.xcassets/
          LaunchImage.imageset/
            README.md
    lib/
      ads/
        my_banner_ad.dart
      app_lifecycle/
        app_lifecycle.dart
      audio/
        audio_controller.dart
        songs.dart
        sounds.dart
      game_internals/
        level_state.dart
        score.dart
      level_selection/
        level_selection_screen.dart
        levels.dart
      main_menu/
        main_menu_screen.dart
      play_session/
        game_widget.dart
        play_session_screen.dart
      player_progress/
        persistence/
          local_storage_player_progress_persistence.dart
          memory_player_progress_persistence.dart
          player_progress_persistence.dart
        player_progress.dart
      settings/
        persistence/
          local_storage_settings_persistence.dart
          memory_settings_persistence.dart
          settings_persistence.dart
        custom_name_dialog.dart
        settings_screen.dart
        settings.dart
      style/
        confetti.dart
        my_button.dart
        my_transition.dart
        palette.dart
        responsive_screen.dart
      win_game/
        win_game_screen.dart
      main.dart
      router.dart
    test/
      smoke_test.dart
    analysis_options.yaml
    pubspec.yaml
    README.md
  crossword/
    ios/
      Runner/
        Assets.xcassets/
          LaunchImage.imageset/
            README.md
    lib/
      widgets/
        crossword_generator_widget.dart
        crossword_puzzle_app.dart
        crossword_puzzle_widget.dart
        puzzle_completed_widget.dart
      isolates.dart
      main.dart
      model.dart
      providers.dart
      utils.dart
    test/
      model_test.dart
    analysis_options.yaml
    pubspec.yaml
  multiplayer/
    assets/
      music/
        README.md
      sfx/
        README.md
    ios/
      Runner/
        Assets.xcassets/
          LaunchImage.imageset/
            README.md
    lib/
      app_lifecycle/
        app_lifecycle.dart
      audio/
        audio_controller.dart
        songs.dart
        sounds.dart
      game_internals/
        board_state.dart
        card_suit.dart
        player.dart
        playing_area.dart
        playing_card.dart
        score.dart
      main_menu/
        main_menu_screen.dart
      multiplayer/
        firestore_controller.dart
      play_session/
        board_widget.dart
        play_session_screen.dart
        player_hand_widget.dart
        playing_area_widget.dart
        playing_card_widget.dart
      player_progress/
        persistence/
          local_storage_player_progress_persistence.dart
          memory_player_progress_persistence.dart
          player_progress_persistence.dart
        player_progress.dart
      settings/
        persistence/
          local_storage_settings_persistence.dart
          memory_settings_persistence.dart
          settings_persistence.dart
        custom_name_dialog.dart
        settings_screen.dart
        settings.dart
      style/
        confetti.dart
        my_button.dart
        my_transition.dart
        palette.dart
        responsive_screen.dart
      win_game/
        win_game_screen.dart
      firebase_options.dart
      main.dart
      router.dart
    test/
      smoke_test.dart
    analysis_options.yaml
    pubspec.yaml
    README.md
templates/
  basic/
    assets/
      music/
        README.md
      sfx/
        README.md
    ios/
      Runner/
        Assets.xcassets/
          LaunchImage.imageset/
            README.md
    lib/
      app_lifecycle/
        app_lifecycle.dart
      audio/
        audio_controller.dart
        songs.dart
        sounds.dart
      game_internals/
        level_state.dart
        score.dart
      level_selection/
        level_selection_screen.dart
        levels.dart
      main_menu/
        main_menu_screen.dart
      play_session/
        game_widget.dart
        play_session_screen.dart
      player_progress/
        persistence/
          local_storage_player_progress_persistence.dart
          memory_player_progress_persistence.dart
          player_progress_persistence.dart
        player_progress.dart
      settings/
        persistence/
          local_storage_settings_persistence.dart
          memory_settings_persistence.dart
          settings_persistence.dart
        custom_name_dialog.dart
        settings_screen.dart
        settings.dart
      style/
        confetti.dart
        my_button.dart
        my_transition.dart
        palette.dart
        responsive_screen.dart
      win_game/
        win_game_screen.dart
      main.dart
      router.dart
    test/
      smoke_test.dart
    analysis_options.yaml
    pubspec.yaml
    README.md
  card/
    assets/
      music/
        README.md
      sfx/
        README.md
    ios/
      Runner/
        Assets.xcassets/
          LaunchImage.imageset/
            README.md
    lib/
      app_lifecycle/
        app_lifecycle.dart
      audio/
        audio_controller.dart
        songs.dart
        sounds.dart
      game_internals/
        board_state.dart
        card_suit.dart
        player.dart
        playing_area.dart
        playing_card.dart
        score.dart
      main_menu/
        main_menu_screen.dart
      play_session/
        battlefield.dart
        board_widget.dart
        d6_Dice_Roller.dart
        play_session_screen.dart
        player_hand_widget.dart
        playing_area_widget.dart
        playing_card_widget.dart
        simple_battlefield.dart
        target_selector.dart
        wave_painter.dart
        wave_screen.dart
        wave_slider.dart
      player_progress/
        persistence/
          local_storage_player_progress_persistence.dart
          memory_player_progress_persistence.dart
          player_progress_persistence.dart
        player_progress.dart
      settings/
        persistence/
          local_storage_settings_persistence.dart
          memory_settings_persistence.dart
          settings_persistence.dart
        custom_name_dialog.dart
        settings_screen.dart
        settings.dart
      style/
        confetti.dart
        my_button.dart
        my_transition.dart
        palette.dart
        responsive_screen.dart
      win_game/
        win_game_screen.dart
      main.dart
      router.dart
    test/
      smoke_test.dart
    analysis_options.yaml
    pubspec.yaml
    README.md
  endless_runner/
    assets/
      images/
        README.md
      sfx/
        README.md
    ios/
      Runner/
        Assets.xcassets/
          LaunchImage.imageset/
            README.md
    lib/
      app_lifecycle/
        app_lifecycle.dart
      audio/
        audio_controller.dart
        songs.dart
        sounds.dart
      flame_game/
        components/
          background.dart
          obstacle.dart
          player.dart
          point.dart
        effects/
          hurt_effect.dart
          jump_effect.dart
        endless_runner.dart
        endless_world.dart
        game_screen.dart
        game_win_dialog.dart
      level_selection/
        instructions_dialog.dart
        level_selection_screen.dart
        levels.dart
      main_menu/
        main_menu_screen.dart
      player_progress/
        persistence/
          local_storage_player_progress_persistence.dart
          memory_player_progress_persistence.dart
          player_progress_persistence.dart
        player_progress.dart
      settings/
        persistence/
          local_storage_settings_persistence.dart
          memory_settings_persistence.dart
          settings_persistence.dart
        custom_name_dialog.dart
        settings_screen.dart
        settings.dart
      style/
        page_transition.dart
        palette.dart
        responsive_screen.dart
        wobbly_button.dart
      main.dart
      router.dart
    test/
      smoke_test.dart
    analysis_options.yaml
    pubspec.yaml
    README.md
CONTRIBUTING.md
README.md
```

# Files

## File: .github/PULL_REQUEST_TEMPLATE.md
````markdown
 1: *Replace this paragraph with a description of what this PR is changing or adding, and why. Consider including before/after screenshots.*
 2: 
 3: *List which issues are fixed by this PR. For larger changes, raising an issue first helps
 4: reduce redundant work.*
 5: 
 6: ## Pre-launch Checklist
 7: 
 8: - [ ] I read the [Flutter Style Guide] _recently_, and have followed its advice.
 9: - [ ] I signed the [CLA].
10: - [ ] I read the [Contributors Guide].
11: - [ ] I updated/added relevant documentation (doc comments with `///`).
12: - [ ] All existing and new tests are passing.
13: 
14: If you need help, consider asking for advice on the #hackers-devrel channel on [Discord].
15: 
16: <!-- Links -->
17: [Flutter Style Guide]: https://github.com/flutter/flutter/blob/master/docs/contributing/Style-guide-for-Flutter-repo.md
18: [CLA]: https://cla.developers.google.com/
19: [Discord]: https://github.com/flutter/flutter/blob/master/docs/contributing/Chat.md
20: [Contributors Guide]: https://github.com/flutter/games/blob/main/CONTRIBUTING.md
````

## File: samples/ads/assets/music/README.md
````markdown
1: Music in the template is by Mr Smith, and licensed under Creative Commons
2: Attribution 4.0 International (CC BY 4.0).
3: 
4: https://freemusicarchive.org/music/mr-smith
5: 
6: Mr Smith's music is used in this template project with his explicit permission.
````

## File: samples/ads/assets/sfx/README.md
````markdown
1: Sounds in this folder are made by Filip Hracek and are CC0 (Public Domain).
````

## File: samples/ads/ios/Runner/Assets.xcassets/LaunchImage.imageset/README.md
````markdown
1: # Launch Screen Assets
2: 
3: You can customize the launch screen with your own desired assets by replacing the image files in this directory.
4: 
5: You can also do it by opening your Flutter project's Xcode project with `open ios/Runner.xcworkspace`, selecting `Runner/Assets.xcassets` in the Project Navigator and dropping in the desired images.
````

## File: samples/ads/lib/ads/my_banner_ad.dart
````dart
 1: import 'dart:io';
 2: 
 3: import 'package:flutter/widgets.dart';
 4: import 'package:google_mobile_ads/google_mobile_ads.dart';
 5: 
 6: class MyBannerAdWidget extends StatefulWidget {
 7:   /// The requested size of the banner. Defaults to [AdSize.banner].
 8:   final AdSize adSize;
 9: 
10:   /// The AdMob ad unit to show.
11:   ///
12:   /// TODO: replace this test ad unit with your own ad unit
13:   final String adUnitId = Platform.isAndroid
14:       // Use this ad unit on Android...
15:       ? 'ca-app-pub-3940256099942544/6300978111'
16:       // ... or this one on iOS.
17:       : 'ca-app-pub-3940256099942544/2934735716';
18: 
19:   MyBannerAdWidget({
20:     super.key,
21:     this.adSize = AdSize.banner,
22:   });
23: 
24:   @override
25:   State<MyBannerAdWidget> createState() => _MyBannerAdWidgetState();
26: }
27: 
28: class _MyBannerAdWidgetState extends State<MyBannerAdWidget> {
29:   /// The banner ad to show. This is `null` until the ad is actually loaded.
30:   BannerAd? _bannerAd;
31: 
32:   @override
33:   Widget build(BuildContext context) {
34:     return SafeArea(
35:       child: SizedBox(
36:         width: widget.adSize.width.toDouble(),
37:         height: widget.adSize.height.toDouble(),
38:         child: _bannerAd == null
39:             // Nothing to render yet.
40:             ? const SizedBox()
41:             // The actual ad.
42:             : AdWidget(ad: _bannerAd!),
43:       ),
44:     );
45:   }
46: 
47:   @override
48:   void initState() {
49:     super.initState();
50: 
51:     // Consider using a ChangeNotifier, a BLoC, a controller, or whatever
52:     // else you are using for app-level state to pre-load your banner ads,
53:     // so that you avoid the delay before an ad is shown.
54:     _loadAd();
55:   }
56: 
57:   @override
58:   void dispose() {
59:     _bannerAd?.dispose();
60:     super.dispose();
61:   }
62: 
63:   /// Loads a banner ad.
64:   void _loadAd() {
65:     final bannerAd = BannerAd(
66:       size: widget.adSize,
67:       adUnitId: widget.adUnitId,
68:       request: const AdRequest(),
69:       listener: BannerAdListener(
70:         // Called when an ad is successfully received.
71:         onAdLoaded: (ad) {
72:           if (!mounted) {
73:             ad.dispose();
74:             return;
75:           }
76:           setState(() {
77:             _bannerAd = ad as BannerAd;
78:           });
79:         },
80:         // Called when an ad request failed.
81:         onAdFailedToLoad: (ad, error) {
82:           debugPrint('BannerAd failed to load: $error');
83:           ad.dispose();
84:         },
85:       ),
86:     );
87: 
88:     // Start loading.
89:     bannerAd.load();
90:   }
91: }
````

## File: samples/ads/lib/app_lifecycle/app_lifecycle.dart
````dart
 1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: import 'package:flutter/widgets.dart';
 6: import 'package:logging/logging.dart';
 7: import 'package:provider/provider.dart';
 8: 
 9: typedef AppLifecycleStateNotifier = ValueNotifier<AppLifecycleState>;
10: 
11: class AppLifecycleObserver extends StatefulWidget {
12:   final Widget child;
13: 
14:   const AppLifecycleObserver({required this.child, super.key});
15: 
16:   @override
17:   State<AppLifecycleObserver> createState() => _AppLifecycleObserverState();
18: }
19: 
20: class _AppLifecycleObserverState extends State<AppLifecycleObserver> {
21:   static final _log = Logger('AppLifecycleObserver');
22:   late final AppLifecycleListener _appLifecycleListener;
23: 
24:   final ValueNotifier<AppLifecycleState> lifecycleListenable =
25:       ValueNotifier(AppLifecycleState.inactive);
26: 
27:   @override
28:   Widget build(BuildContext context) {
29:     // Using InheritedProvider because we don't want to use Consumer
30:     // or context.watch or anything like that to listen to this. We want
31:     // to manually add listeners. We're interested in the _events_ of lifecycle
32:     // state changes, and not so much in the state itself. (For example,
33:     // we want to stop sound when the app goes into the background, and
34:     // restart sound again when the app goes back into focus. We're not
35:     // rebuilding any widgets.)
36:     //
37:     // Provider, by default, throws when one
38:     // is trying to provide a Listenable (such as ValueNotifier) without using
39:     // something like ValueListenableProvider. InheritedProvider is more
40:     // low-level and doesn't have this problem.
41:     return InheritedProvider<AppLifecycleStateNotifier>.value(
42:       value: lifecycleListenable,
43:       child: widget.child,
44:     );
45:   }
46: 
47:   @override
48:   void dispose() {
49:     _appLifecycleListener.dispose();
50:     super.dispose();
51:   }
52: 
53:   @override
54:   void initState() {
55:     super.initState();
56:     _appLifecycleListener = AppLifecycleListener(
57:       onStateChange: (s) => lifecycleListenable.value = s,
58:     );
59:     _log.info('Subscribed to app lifecycle updates');
60:   }
61: }
````

## File: samples/ads/lib/audio/audio_controller.dart
````dart
  1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
  2: // for details. All rights reserved. Use of this source code is governed by a
  3: // BSD-style license that can be found in the LICENSE file.
  4: 
  5: import 'dart:async';
  6: import 'dart:collection';
  7: import 'dart:math';
  8: 
  9: import 'package:audioplayers/audioplayers.dart';
 10: import 'package:flutter/foundation.dart';
 11: import 'package:flutter/widgets.dart';
 12: import 'package:logging/logging.dart';
 13: 
 14: import '../app_lifecycle/app_lifecycle.dart';
 15: import '../settings/settings.dart';
 16: import 'songs.dart';
 17: import 'sounds.dart';
 18: 
 19: /// Allows playing music and sound. A facade to `package:audioplayers`.
 20: class AudioController {
 21:   static final _log = Logger('AudioController');
 22: 
 23:   final AudioPlayer _musicPlayer;
 24: 
 25:   /// This is a list of [AudioPlayer] instances which are rotated to play
 26:   /// sound effects.
 27:   final List<AudioPlayer> _sfxPlayers;
 28: 
 29:   int _currentSfxPlayer = 0;
 30: 
 31:   final Queue<Song> _playlist;
 32: 
 33:   final Random _random = Random();
 34: 
 35:   SettingsController? _settings;
 36: 
 37:   ValueNotifier<AppLifecycleState>? _lifecycleNotifier;
 38: 
 39:   /// Creates an instance that plays music and sound.
 40:   ///
 41:   /// Use [polyphony] to configure the number of sound effects (SFX) that can
 42:   /// play at the same time. A [polyphony] of `1` will always only play one
 43:   /// sound (a new sound will stop the previous one). See discussion
 44:   /// of [_sfxPlayers] to learn why this is the case.
 45:   ///
 46:   /// Background music does not count into the [polyphony] limit. Music will
 47:   /// never be overridden by sound effects because that would be silly.
 48:   AudioController({int polyphony = 2})
 49:       : assert(polyphony >= 1),
 50:         _musicPlayer = AudioPlayer(playerId: 'musicPlayer'),
 51:         _sfxPlayers = Iterable.generate(
 52:                 polyphony, (i) => AudioPlayer(playerId: 'sfxPlayer#$i'))
 53:             .toList(growable: false),
 54:         _playlist = Queue.of(List<Song>.of(songs)..shuffle()) {
 55:     _musicPlayer.onPlayerComplete.listen(_handleSongFinished);
 56:     unawaited(_preloadSfx());
 57:   }
 58: 
 59:   /// Makes sure the audio controller is listening to changes
 60:   /// of both the app lifecycle (e.g. suspended app) and to changes
 61:   /// of settings (e.g. muted sound).
 62:   void attachDependencies(AppLifecycleStateNotifier lifecycleNotifier,
 63:       SettingsController settingsController) {
 64:     _attachLifecycleNotifier(lifecycleNotifier);
 65:     _attachSettings(settingsController);
 66:   }
 67: 
 68:   void dispose() {
 69:     _lifecycleNotifier?.removeListener(_handleAppLifecycle);
 70:     _stopAllSound();
 71:     _musicPlayer.dispose();
 72:     for (final player in _sfxPlayers) {
 73:       player.dispose();
 74:     }
 75:   }
 76: 
 77:   /// Plays a single sound effect, defined by [type].
 78:   ///
 79:   /// The controller will ignore this call when the attached settings'
 80:   /// [SettingsController.audioOn] is `true` or if its
 81:   /// [SettingsController.soundsOn] is `false`.
 82:   void playSfx(SfxType type) {
 83:     final audioOn = _settings?.audioOn.value ?? false;
 84:     if (!audioOn) {
 85:       _log.fine(() => 'Ignoring playing sound ($type) because audio is muted.');
 86:       return;
 87:     }
 88:     final soundsOn = _settings?.soundsOn.value ?? false;
 89:     if (!soundsOn) {
 90:       _log.fine(() =>
 91:           'Ignoring playing sound ($type) because sounds are turned off.');
 92:       return;
 93:     }
 94: 
 95:     _log.fine(() => 'Playing sound: $type');
 96:     final options = soundTypeToFilename(type);
 97:     final filename = options[_random.nextInt(options.length)];
 98:     _log.fine(() => '- Chosen filename: $filename');
 99: 
100:     final currentPlayer = _sfxPlayers[_currentSfxPlayer];
101:     currentPlayer.play(AssetSource('sfx/$filename'),
102:         volume: soundTypeToVolume(type));
103:     _currentSfxPlayer = (_currentSfxPlayer + 1) % _sfxPlayers.length;
104:   }
105: 
106:   /// Enables the [AudioController] to listen to [AppLifecycleState] events,
107:   /// and therefore do things like stopping playback when the game
108:   /// goes into the background.
109:   void _attachLifecycleNotifier(AppLifecycleStateNotifier lifecycleNotifier) {
110:     _lifecycleNotifier?.removeListener(_handleAppLifecycle);
111: 
112:     lifecycleNotifier.addListener(_handleAppLifecycle);
113:     _lifecycleNotifier = lifecycleNotifier;
114:   }
115: 
116:   /// Enables the [AudioController] to track changes to settings.
117:   /// Namely, when any of [SettingsController.audioOn],
118:   /// [SettingsController.musicOn] or [SettingsController.soundsOn] changes,
119:   /// the audio controller will act accordingly.
120:   void _attachSettings(SettingsController settingsController) {
121:     if (_settings == settingsController) {
122:       // Already attached to this instance. Nothing to do.
123:       return;
124:     }
125: 
126:     // Remove handlers from the old settings controller if present
127:     final oldSettings = _settings;
128:     if (oldSettings != null) {
129:       oldSettings.audioOn.removeListener(_audioOnHandler);
130:       oldSettings.musicOn.removeListener(_musicOnHandler);
131:       oldSettings.soundsOn.removeListener(_soundsOnHandler);
132:     }
133: 
134:     _settings = settingsController;
135: 
136:     // Add handlers to the new settings controller
137:     settingsController.audioOn.addListener(_audioOnHandler);
138:     settingsController.musicOn.addListener(_musicOnHandler);
139:     settingsController.soundsOn.addListener(_soundsOnHandler);
140: 
141:     if (settingsController.audioOn.value && settingsController.musicOn.value) {
142:       if (kIsWeb) {
143:         _log.info('On the web, music can only start after user interaction.');
144:       } else {
145:         _playCurrentSongInPlaylist();
146:       }
147:     }
148:   }
149: 
150:   void _audioOnHandler() {
151:     _log.fine('audioOn changed to ${_settings!.audioOn.value}');
152:     if (_settings!.audioOn.value) {
153:       // All sound just got un-muted. Audio is on.
154:       if (_settings!.musicOn.value) {
155:         _startOrResumeMusic();
156:       }
157:     } else {
158:       // All sound just got muted. Audio is off.
159:       _stopAllSound();
160:     }
161:   }
162: 
163:   void _handleAppLifecycle() {
164:     switch (_lifecycleNotifier!.value) {
165:       case AppLifecycleState.paused:
166:       case AppLifecycleState.detached:
167:       case AppLifecycleState.hidden:
168:         _stopAllSound();
169:       case AppLifecycleState.resumed:
170:         if (_settings!.audioOn.value && _settings!.musicOn.value) {
171:           _startOrResumeMusic();
172:         }
173:       case AppLifecycleState.inactive:
174:         // No need to react to this state change.
175:         break;
176:     }
177:   }
178: 
179:   void _handleSongFinished(void _) {
180:     _log.info('Last song finished playing.');
181:     // Move the song that just finished playing to the end of the playlist.
182:     _playlist.addLast(_playlist.removeFirst());
183:     // Play the song at the beginning of the playlist.
184:     _playCurrentSongInPlaylist();
185:   }
186: 
187:   void _musicOnHandler() {
188:     if (_settings!.musicOn.value) {
189:       // Music got turned on.
190:       if (_settings!.audioOn.value) {
191:         _startOrResumeMusic();
192:       }
193:     } else {
194:       // Music got turned off.
195:       _musicPlayer.pause();
196:     }
197:   }
198: 
199:   Future<void> _playCurrentSongInPlaylist() async {
200:     _log.info(() => 'Playing ${_playlist.first} now.');
201:     try {
202:       await _musicPlayer.play(AssetSource('music/${_playlist.first.filename}'));
203:     } catch (e) {
204:       _log.severe('Could not play song ${_playlist.first}', e);
205:     }
206:   }
207: 
208:   /// Preloads all sound effects.
209:   Future<void> _preloadSfx() async {
210:     _log.info('Preloading sound effects');
211:     // This assumes there is only a limited number of sound effects in the game.
212:     // If there are hundreds of long sound effect files, it's better
213:     // to be more selective when preloading.
214:     await AudioCache.instance.loadAll(SfxType.values
215:         .expand(soundTypeToFilename)
216:         .map((path) => 'sfx/$path')
217:         .toList());
218:   }
219: 
220:   void _soundsOnHandler() {
221:     for (final player in _sfxPlayers) {
222:       if (player.state == PlayerState.playing) {
223:         player.stop();
224:       }
225:     }
226:   }
227: 
228:   void _startOrResumeMusic() async {
229:     if (_musicPlayer.source == null) {
230:       _log.info('No music source set. '
231:           'Start playing the current song in playlist.');
232:       await _playCurrentSongInPlaylist();
233:       return;
234:     }
235: 
236:     _log.info('Resuming paused music.');
237:     try {
238:       _musicPlayer.resume();
239:     } catch (e) {
240:       // Sometimes, resuming fails with an "Unexpected" error.
241:       _log.severe('Error resuming music', e);
242:       // Try starting the song from scratch.
243:       _playCurrentSongInPlaylist();
244:     }
245:   }
246: 
247:   void _stopAllSound() {
248:     _log.info('Stopping all sound');
249:     _musicPlayer.pause();
250:     for (final player in _sfxPlayers) {
251:       player.stop();
252:     }
253:   }
254: }
````

## File: samples/ads/lib/audio/songs.dart
````dart
 1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: const Set<Song> songs = {
 6:   // Filenames with whitespace break package:audioplayers on iOS
 7:   // (as of February 2022), so we use no whitespace.
 8:   Song('Mr_Smith-Azul.mp3', 'Azul', artist: 'Mr Smith'),
 9:   Song('Mr_Smith-Sonorus.mp3', 'Sonorus', artist: 'Mr Smith'),
10:   Song('Mr_Smith-Sunday_Solitude.mp3', 'SundaySolitude', artist: 'Mr Smith'),
11: };
12: 
13: class Song {
14:   final String filename;
15: 
16:   final String name;
17: 
18:   final String? artist;
19: 
20:   const Song(this.filename, this.name, {this.artist});
21: 
22:   @override
23:   String toString() => 'Song<$filename>';
24: }
````

## File: samples/ads/lib/audio/sounds.dart
````dart
 1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: List<String> soundTypeToFilename(SfxType type) {
 6:   switch (type) {
 7:     case SfxType.huhsh:
 8:       return const [
 9:         'hash1.mp3',
10:         'hash2.mp3',
11:         'hash3.mp3',
12:       ];
13:     case SfxType.wssh:
14:       return const [
15:         'wssh1.mp3',
16:         'wssh2.mp3',
17:         'dsht1.mp3',
18:         'ws1.mp3',
19:         'spsh1.mp3',
20:         'hh1.mp3',
21:         'hh2.mp3',
22:         'kss1.mp3',
23:       ];
24:     case SfxType.buttonTap:
25:       return const [
26:         'k1.mp3',
27:         'k2.mp3',
28:         'p1.mp3',
29:         'p2.mp3',
30:       ];
31:     case SfxType.congrats:
32:       return const [
33:         'yay1.mp3',
34:         'wehee1.mp3',
35:         'oo1.mp3',
36:       ];
37:     case SfxType.erase:
38:       return const [
39:         'fwfwfwfwfw1.mp3',
40:         'fwfwfwfw1.mp3',
41:       ];
42:     case SfxType.swishSwish:
43:       return const [
44:         'swishswish1.mp3',
45:       ];
46:   }
47: }
48: 
49: /// Allows control over loudness of different SFX types.
50: double soundTypeToVolume(SfxType type) {
51:   switch (type) {
52:     case SfxType.huhsh:
53:       return 0.4;
54:     case SfxType.wssh:
55:       return 0.2;
56:     case SfxType.buttonTap:
57:     case SfxType.congrats:
58:     case SfxType.erase:
59:     case SfxType.swishSwish:
60:       return 1.0;
61:   }
62: }
63: 
64: enum SfxType {
65:   huhsh,
66:   wssh,
67:   buttonTap,
68:   congrats,
69:   erase,
70:   swishSwish,
71: }
````

## File: samples/ads/lib/game_internals/level_state.dart
````dart
 1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: import 'package:flutter/foundation.dart';
 6: 
 7: /// An extremely silly example of a game state.
 8: ///
 9: /// Tracks only a single variable, [progress], and calls [onWin] when
10: /// the value of [progress] reaches [goal].
11: class LevelState extends ChangeNotifier {
12:   final VoidCallback onWin;
13: 
14:   final int goal;
15: 
16:   LevelState({required this.onWin, this.goal = 100});
17: 
18:   int _progress = 0;
19: 
20:   int get progress => _progress;
21: 
22:   void setProgress(int value) {
23:     _progress = value;
24:     notifyListeners();
25:   }
26: 
27:   void evaluate() {
28:     if (_progress >= goal) {
29:       onWin();
30:     }
31:   }
32: }
````

## File: samples/ads/lib/game_internals/score.dart
````dart
 1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: /// Encapsulates a score and the arithmetic to compute it.
 6: class Score {
 7:   final int score;
 8: 
 9:   final Duration duration;
10: 
11:   final int level;
12: 
13:   factory Score(int level, int difficulty, Duration duration) {
14:     // The higher the difficulty, the higher the score.
15:     var score = difficulty;
16:     // The lower the time to beat the level, the higher the score.
17:     score *= 10000 ~/ (duration.inSeconds.abs() + 1);
18:     return Score._(score, duration, level);
19:   }
20: 
21:   const Score._(this.score, this.duration, this.level);
22: 
23:   String get formattedTime {
24:     final buf = StringBuffer();
25:     if (duration.inHours > 0) {
26:       buf.write('${duration.inHours}');
27:       buf.write(':');
28:     }
29:     final minutes = duration.inMinutes % Duration.minutesPerHour;
30:     if (minutes > 9) {
31:       buf.write('$minutes');
32:     } else {
33:       buf.write('0');
34:       buf.write('$minutes');
35:     }
36:     buf.write(':');
37:     buf.write((duration.inSeconds % Duration.secondsPerMinute)
38:         .toString()
39:         .padLeft(2, '0'));
40:     return buf.toString();
41:   }
42: 
43:   @override
44:   String toString() => 'Score<$score,$formattedTime,$level>';
45: }
````

## File: samples/ads/lib/level_selection/level_selection_screen.dart
````dart
 1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: import 'package:flutter/material.dart';
 6: import 'package:go_router/go_router.dart';
 7: import 'package:provider/provider.dart';
 8: 
 9: import '../audio/audio_controller.dart';
10: import '../audio/sounds.dart';
11: import '../player_progress/player_progress.dart';
12: import '../style/my_button.dart';
13: import '../style/palette.dart';
14: import '../style/responsive_screen.dart';
15: import 'levels.dart';
16: 
17: class LevelSelectionScreen extends StatelessWidget {
18:   const LevelSelectionScreen({super.key});
19: 
20:   @override
21:   Widget build(BuildContext context) {
22:     final palette = context.watch<Palette>();
23:     final playerProgress = context.watch<PlayerProgress>();
24: 
25:     return Scaffold(
26:       backgroundColor: palette.backgroundLevelSelection,
27:       body: ResponsiveScreen(
28:         squarishMainArea: Column(
29:           children: [
30:             const Padding(
31:               padding: EdgeInsets.all(16),
32:               child: Center(
33:                 child: Text(
34:                   'Select level',
35:                   style:
36:                       TextStyle(fontFamily: 'Permanent Marker', fontSize: 30),
37:                 ),
38:               ),
39:             ),
40:             const SizedBox(height: 50),
41:             Expanded(
42:               child: ListView(
43:                 children: [
44:                   for (final level in gameLevels)
45:                     ListTile(
46:                       enabled: playerProgress.highestLevelReached >=
47:                           level.number - 1,
48:                       onTap: () {
49:                         final audioController = context.read<AudioController>();
50:                         audioController.playSfx(SfxType.buttonTap);
51: 
52:                         GoRouter.of(context)
53:                             .go('/play/session/${level.number}');
54:                       },
55:                       leading: Text(level.number.toString()),
56:                       title: Text('Level #${level.number}'),
57:                     )
58:                 ],
59:               ),
60:             ),
61:           ],
62:         ),
63:         rectangularMenuArea: MyButton(
64:           onPressed: () {
65:             GoRouter.of(context).go('/');
66:           },
67:           child: const Text('Back'),
68:         ),
69:       ),
70:     );
71:   }
72: }
````

## File: samples/ads/lib/level_selection/levels.dart
````dart
 1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: const gameLevels = [
 6:   GameLevel(
 7:     number: 1,
 8:     difficulty: 5,
 9:     // TODO: When ready, change these achievement IDs.
10:     // You configure this in App Store Connect.
11:     achievementIdIOS: 'first_win',
12:     // You get this string when you configure an achievement in Play Console.
13:     achievementIdAndroid: 'NhkIwB69ejkMAOOLDb',
14:   ),
15:   GameLevel(
16:     number: 2,
17:     difficulty: 42,
18:   ),
19:   GameLevel(
20:     number: 3,
21:     difficulty: 100,
22:     achievementIdIOS: 'finished',
23:     achievementIdAndroid: 'CdfIhE96aspNWLGSQg',
24:   ),
25: ];
26: 
27: class GameLevel {
28:   final int number;
29: 
30:   final int difficulty;
31: 
32:   /// The achievement to unlock when the level is finished, if any.
33:   final String? achievementIdIOS;
34: 
35:   final String? achievementIdAndroid;
36: 
37:   bool get awardsAchievement => achievementIdAndroid != null;
38: 
39:   const GameLevel({
40:     required this.number,
41:     required this.difficulty,
42:     this.achievementIdIOS,
43:     this.achievementIdAndroid,
44:   }) : assert(
45:             (achievementIdAndroid != null && achievementIdIOS != null) ||
46:                 (achievementIdAndroid == null && achievementIdIOS == null),
47:             'Either both iOS and Android achievement ID must be provided, '
48:             'or none');
49: }
````

## File: samples/ads/lib/main_menu/main_menu_screen.dart
````dart
 1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: import 'package:flutter/material.dart';
 6: import 'package:go_router/go_router.dart';
 7: import 'package:provider/provider.dart';
 8: 
 9: import '../audio/audio_controller.dart';
10: import '../audio/sounds.dart';
11: import '../settings/settings.dart';
12: import '../style/my_button.dart';
13: import '../style/palette.dart';
14: import '../style/responsive_screen.dart';
15: 
16: class MainMenuScreen extends StatelessWidget {
17:   const MainMenuScreen({super.key});
18: 
19:   @override
20:   Widget build(BuildContext context) {
21:     final palette = context.watch<Palette>();
22:     final settingsController = context.watch<SettingsController>();
23:     final audioController = context.watch<AudioController>();
24: 
25:     return Scaffold(
26:       backgroundColor: palette.backgroundMain,
27:       body: ResponsiveScreen(
28:         squarishMainArea: Center(
29:           child: Transform.rotate(
30:             angle: -0.1,
31:             child: const Text(
32:               'Flutter Game Template!',
33:               textAlign: TextAlign.center,
34:               style: TextStyle(
35:                 fontFamily: 'Permanent Marker',
36:                 fontSize: 55,
37:                 height: 1,
38:               ),
39:             ),
40:           ),
41:         ),
42:         rectangularMenuArea: Column(
43:           mainAxisAlignment: MainAxisAlignment.end,
44:           children: [
45:             MyButton(
46:               onPressed: () {
47:                 audioController.playSfx(SfxType.buttonTap);
48:                 GoRouter.of(context).go('/play');
49:               },
50:               child: const Text('Play'),
51:             ),
52:             _gap,
53:             MyButton(
54:               onPressed: () => GoRouter.of(context).push('/settings'),
55:               child: const Text('Settings'),
56:             ),
57:             _gap,
58:             Padding(
59:               padding: const EdgeInsets.only(top: 32),
60:               child: ValueListenableBuilder<bool>(
61:                 valueListenable: settingsController.audioOn,
62:                 builder: (context, audioOn, child) {
63:                   return IconButton(
64:                     onPressed: () => settingsController.toggleAudioOn(),
65:                     icon: Icon(audioOn ? Icons.volume_up : Icons.volume_off),
66:                   );
67:                 },
68:               ),
69:             ),
70:             _gap,
71:             const Text('Music by Mr Smith'),
72:             _gap,
73:           ],
74:         ),
75:       ),
76:     );
77:   }
78: 
79:   static const _gap = SizedBox(height: 10);
80: }
````

## File: samples/ads/lib/play_session/game_widget.dart
````dart
 1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: import 'package:flutter/material.dart';
 6: import 'package:provider/provider.dart';
 7: 
 8: import '../audio/audio_controller.dart';
 9: import '../audio/sounds.dart';
10: import '../game_internals/level_state.dart';
11: import '../level_selection/levels.dart';
12: 
13: /// This widget defines the game UI itself, without things like the settings
14: /// button or the back button.
15: class GameWidget extends StatelessWidget {
16:   const GameWidget({super.key});
17: 
18:   @override
19:   Widget build(BuildContext context) {
20:     final level = context.watch<GameLevel>();
21:     final levelState = context.watch<LevelState>();
22: 
23:     return Column(
24:       children: [
25:         Text('Drag the slider to ${level.difficulty}% or above!'),
26:         Slider(
27:           label: 'Level Progress',
28:           autofocus: true,
29:           value: levelState.progress / 100,
30:           onChanged: (value) => levelState.setProgress((value * 100).round()),
31:           onChangeEnd: (value) {
32:             context.read<AudioController>().playSfx(SfxType.wssh);
33:             levelState.evaluate();
34:           },
35:         ),
36:       ],
37:     );
38:   }
39: }
````

## File: samples/ads/lib/play_session/play_session_screen.dart
````dart
  1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
  2: // for details. All rights reserved. Use of this source code is governed by a
  3: // BSD-style license that can be found in the LICENSE file.
  4: 
  5: import 'dart:async';
  6: 
  7: import 'package:flutter/material.dart';
  8: import 'package:go_router/go_router.dart';
  9: import 'package:logging/logging.dart' hide Level;
 10: import 'package:provider/provider.dart';
 11: 
 12: import '../audio/audio_controller.dart';
 13: import '../audio/sounds.dart';
 14: import '../game_internals/level_state.dart';
 15: import '../game_internals/score.dart';
 16: import '../level_selection/levels.dart';
 17: import '../player_progress/player_progress.dart';
 18: import '../style/confetti.dart';
 19: import '../style/my_button.dart';
 20: import '../style/palette.dart';
 21: import 'game_widget.dart';
 22: 
 23: /// This widget defines the entirety of the screen that the player sees when
 24: /// they are playing a level.
 25: ///
 26: /// It is a stateful widget because it manages some state of its own,
 27: /// such as whether the game is in a "celebration" state.
 28: class PlaySessionScreen extends StatefulWidget {
 29:   final GameLevel level;
 30: 
 31:   const PlaySessionScreen(this.level, {super.key});
 32: 
 33:   @override
 34:   State<PlaySessionScreen> createState() => _PlaySessionScreenState();
 35: }
 36: 
 37: class _PlaySessionScreenState extends State<PlaySessionScreen> {
 38:   static final _log = Logger('PlaySessionScreen');
 39: 
 40:   static const _celebrationDuration = Duration(milliseconds: 2000);
 41: 
 42:   static const _preCelebrationDuration = Duration(milliseconds: 500);
 43: 
 44:   bool _duringCelebration = false;
 45: 
 46:   late DateTime _startOfPlay;
 47: 
 48:   @override
 49:   void initState() {
 50:     super.initState();
 51: 
 52:     _startOfPlay = DateTime.now();
 53:   }
 54: 
 55:   @override
 56:   Widget build(BuildContext context) {
 57:     final palette = context.watch<Palette>();
 58: 
 59:     return MultiProvider(
 60:       providers: [
 61:         Provider.value(value: widget.level),
 62:         // Create and provide the [LevelState] object that will be used
 63:         // by widgets below this one in the widget tree.
 64:         ChangeNotifierProvider(
 65:           create: (context) => LevelState(
 66:             goal: widget.level.difficulty,
 67:             onWin: _playerWon,
 68:           ),
 69:         ),
 70:       ],
 71:       child: IgnorePointer(
 72:         // Ignore all input during the celebration animation.
 73:         ignoring: _duringCelebration,
 74:         child: Scaffold(
 75:           backgroundColor: palette.backgroundPlaySession,
 76:           // The stack is how you layer widgets on top of each other.
 77:           // Here, it is used to overlay the winning confetti animation on top
 78:           // of the game.
 79:           body: Stack(
 80:             children: [
 81:               // This is the main layout of the play session screen,
 82:               // with a settings button on top, the actual play area
 83:               // in the middle, and a back button at the bottom.
 84:               Column(
 85:                 mainAxisAlignment: MainAxisAlignment.center,
 86:                 children: [
 87:                   Align(
 88:                     alignment: Alignment.centerRight,
 89:                     child: InkResponse(
 90:                       onTap: () => GoRouter.of(context).push('/settings'),
 91:                       child: Image.asset(
 92:                         'assets/images/settings.png',
 93:                         semanticLabel: 'Settings',
 94:                       ),
 95:                     ),
 96:                   ),
 97:                   const Spacer(),
 98:                   const Expanded(
 99:                     // The actual UI of the game.
100:                     child: GameWidget(),
101:                   ),
102:                   const Spacer(),
103:                   Padding(
104:                     padding: const EdgeInsets.all(8.0),
105:                     child: MyButton(
106:                       onPressed: () => GoRouter.of(context).go('/play'),
107:                       child: const Text('Back'),
108:                     ),
109:                   ),
110:                 ],
111:               ),
112:               // This is the confetti animation that is overlaid on top of the
113:               // game when the player wins.
114:               SizedBox.expand(
115:                 child: Visibility(
116:                   visible: _duringCelebration,
117:                   child: IgnorePointer(
118:                     child: Confetti(
119:                       isStopped: !_duringCelebration,
120:                     ),
121:                   ),
122:                 ),
123:               ),
124:             ],
125:           ),
126:         ),
127:       ),
128:     );
129:   }
130: 
131:   Future<void> _playerWon() async {
132:     _log.info('Level ${widget.level.number} won');
133: 
134:     final score = Score(
135:       widget.level.number,
136:       widget.level.difficulty,
137:       DateTime.now().difference(_startOfPlay),
138:     );
139: 
140:     final playerProgress = context.read<PlayerProgress>();
141:     playerProgress.setLevelReached(widget.level.number);
142: 
143:     // Let the player see the game just after winning for a bit.
144:     await Future<void>.delayed(_preCelebrationDuration);
145:     if (!mounted) return;
146: 
147:     setState(() {
148:       _duringCelebration = true;
149:     });
150: 
151:     final audioController = context.read<AudioController>();
152:     audioController.playSfx(SfxType.congrats);
153: 
154:     /// Give the player some time to see the celebration animation.
155:     await Future<void>.delayed(_celebrationDuration);
156:     if (!mounted) return;
157: 
158:     GoRouter.of(context).go('/play/won', extra: {'score': score});
159:   }
160: }
````

## File: samples/ads/lib/player_progress/persistence/local_storage_player_progress_persistence.dart
````dart
 1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: import 'package:shared_preferences/shared_preferences.dart';
 6: 
 7: import 'player_progress_persistence.dart';
 8: 
 9: /// An implementation of [PlayerProgressPersistence] that uses
10: /// `package:shared_preferences`.
11: class LocalStoragePlayerProgressPersistence extends PlayerProgressPersistence {
12:   final Future<SharedPreferences> instanceFuture =
13:       SharedPreferences.getInstance();
14: 
15:   @override
16:   Future<int> getHighestLevelReached() async {
17:     final prefs = await instanceFuture;
18:     return prefs.getInt('highestLevelReached') ?? 0;
19:   }
20: 
21:   @override
22:   Future<void> saveHighestLevelReached(int level) async {
23:     final prefs = await instanceFuture;
24:     await prefs.setInt('highestLevelReached', level);
25:   }
26: }
````

## File: samples/ads/lib/player_progress/persistence/memory_player_progress_persistence.dart
````dart
 1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: import 'player_progress_persistence.dart';
 6: 
 7: /// An in-memory implementation of [PlayerProgressPersistence].
 8: /// Useful for testing.
 9: class MemoryOnlyPlayerProgressPersistence implements PlayerProgressPersistence {
10:   int level = 0;
11: 
12:   @override
13:   Future<int> getHighestLevelReached() async {
14:     await Future<void>.delayed(const Duration(milliseconds: 500));
15:     return level;
16:   }
17: 
18:   @override
19:   Future<void> saveHighestLevelReached(int level) async {
20:     await Future<void>.delayed(const Duration(milliseconds: 500));
21:     this.level = level;
22:   }
23: }
````

## File: samples/ads/lib/player_progress/persistence/player_progress_persistence.dart
````dart
 1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: /// An interface of persistence stores for the player's progress.
 6: ///
 7: /// Implementations can range from simple in-memory storage through
 8: /// local preferences to cloud saves.
 9: abstract class PlayerProgressPersistence {
10:   Future<int> getHighestLevelReached();
11: 
12:   Future<void> saveHighestLevelReached(int level);
13: }
````

## File: samples/ads/lib/player_progress/player_progress.dart
````dart
 1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: import 'dart:async';
 6: 
 7: import 'package:flutter/foundation.dart';
 8: 
 9: import 'persistence/local_storage_player_progress_persistence.dart';
10: import 'persistence/player_progress_persistence.dart';
11: 
12: /// Encapsulates the player's progress.
13: class PlayerProgress extends ChangeNotifier {
14:   static const maxHighestScoresPerPlayer = 10;
15: 
16:   /// By default, settings are persisted using
17:   /// [LocalStoragePlayerProgressPersistence] (i.e. NSUserDefaults on iOS,
18:   /// SharedPreferences on Android or local storage on the web).
19:   final PlayerProgressPersistence _store;
20: 
21:   int _highestLevelReached = 0;
22: 
23:   /// Creates an instance of [PlayerProgress] backed by an injected
24:   /// persistence [store].
25:   PlayerProgress({PlayerProgressPersistence? store})
26:       : _store = store ?? LocalStoragePlayerProgressPersistence() {
27:     _getLatestFromStore();
28:   }
29: 
30:   /// The highest level that the player has reached so far.
31:   int get highestLevelReached => _highestLevelReached;
32: 
33:   /// Resets the player's progress so it's like if they just started
34:   /// playing the game for the first time.
35:   void reset() {
36:     _highestLevelReached = 0;
37:     notifyListeners();
38:     _store.saveHighestLevelReached(_highestLevelReached);
39:   }
40: 
41:   /// Registers [level] as reached.
42:   ///
43:   /// If this is higher than [highestLevelReached], it will update that
44:   /// value and save it to the injected persistence store.
45:   void setLevelReached(int level) {
46:     if (level > _highestLevelReached) {
47:       _highestLevelReached = level;
48:       notifyListeners();
49: 
50:       unawaited(_store.saveHighestLevelReached(level));
51:     }
52:   }
53: 
54:   /// Fetches the latest data from the backing persistence store.
55:   Future<void> _getLatestFromStore() async {
56:     final level = await _store.getHighestLevelReached();
57:     if (level > _highestLevelReached) {
58:       _highestLevelReached = level;
59:       notifyListeners();
60:     } else if (level < _highestLevelReached) {
61:       await _store.saveHighestLevelReached(_highestLevelReached);
62:     }
63:   }
64: }
````

## File: samples/ads/lib/settings/persistence/local_storage_settings_persistence.dart
````dart
 1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: import 'package:shared_preferences/shared_preferences.dart';
 6: 
 7: import 'settings_persistence.dart';
 8: 
 9: /// An implementation of [SettingsPersistence] that uses
10: /// `package:shared_preferences`.
11: class LocalStorageSettingsPersistence extends SettingsPersistence {
12:   final Future<SharedPreferences> instanceFuture =
13:       SharedPreferences.getInstance();
14: 
15:   @override
16:   Future<bool> getAudioOn({required bool defaultValue}) async {
17:     final prefs = await instanceFuture;
18:     return prefs.getBool('audioOn') ?? defaultValue;
19:   }
20: 
21:   @override
22:   Future<bool> getMusicOn({required bool defaultValue}) async {
23:     final prefs = await instanceFuture;
24:     return prefs.getBool('musicOn') ?? defaultValue;
25:   }
26: 
27:   @override
28:   Future<String> getPlayerName() async {
29:     final prefs = await instanceFuture;
30:     return prefs.getString('playerName') ?? 'Player';
31:   }
32: 
33:   @override
34:   Future<bool> getSoundsOn({required bool defaultValue}) async {
35:     final prefs = await instanceFuture;
36:     return prefs.getBool('soundsOn') ?? defaultValue;
37:   }
38: 
39:   @override
40:   Future<void> saveAudioOn(bool value) async {
41:     final prefs = await instanceFuture;
42:     await prefs.setBool('audioOn', value);
43:   }
44: 
45:   @override
46:   Future<void> saveMusicOn(bool value) async {
47:     final prefs = await instanceFuture;
48:     await prefs.setBool('musicOn', value);
49:   }
50: 
51:   @override
52:   Future<void> savePlayerName(String value) async {
53:     final prefs = await instanceFuture;
54:     await prefs.setString('playerName', value);
55:   }
56: 
57:   @override
58:   Future<void> saveSoundsOn(bool value) async {
59:     final prefs = await instanceFuture;
60:     await prefs.setBool('soundsOn', value);
61:   }
62: }
````

## File: samples/ads/lib/settings/persistence/memory_settings_persistence.dart
````dart
 1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: import 'settings_persistence.dart';
 6: 
 7: /// An in-memory implementation of [SettingsPersistence].
 8: /// Useful for testing.
 9: class MemoryOnlySettingsPersistence implements SettingsPersistence {
10:   bool musicOn = true;
11: 
12:   bool soundsOn = true;
13: 
14:   bool audioOn = true;
15: 
16:   String playerName = 'Player';
17: 
18:   @override
19:   Future<bool> getAudioOn({required bool defaultValue}) async => audioOn;
20: 
21:   @override
22:   Future<bool> getMusicOn({required bool defaultValue}) async => musicOn;
23: 
24:   @override
25:   Future<String> getPlayerName() async => playerName;
26: 
27:   @override
28:   Future<bool> getSoundsOn({required bool defaultValue}) async => soundsOn;
29: 
30:   @override
31:   Future<void> saveAudioOn(bool value) async => audioOn = value;
32: 
33:   @override
34:   Future<void> saveMusicOn(bool value) async => musicOn = value;
35: 
36:   @override
37:   Future<void> savePlayerName(String value) async => playerName = value;
38: 
39:   @override
40:   Future<void> saveSoundsOn(bool value) async => soundsOn = value;
41: }
````

## File: samples/ads/lib/settings/persistence/settings_persistence.dart
````dart
 1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: /// An interface of persistence stores for settings.
 6: ///
 7: /// Implementations can range from simple in-memory storage through
 8: /// local preferences to cloud-based solutions.
 9: abstract class SettingsPersistence {
10:   Future<bool> getAudioOn({required bool defaultValue});
11: 
12:   Future<bool> getMusicOn({required bool defaultValue});
13: 
14:   Future<String> getPlayerName();
15: 
16:   Future<bool> getSoundsOn({required bool defaultValue});
17: 
18:   Future<void> saveAudioOn(bool value);
19: 
20:   Future<void> saveMusicOn(bool value);
21: 
22:   Future<void> savePlayerName(String value);
23: 
24:   Future<void> saveSoundsOn(bool value);
25: }
````

## File: samples/ads/lib/settings/custom_name_dialog.dart
````dart
 1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: import 'package:flutter/material.dart';
 6: import 'package:flutter/services.dart';
 7: import 'package:provider/provider.dart';
 8: 
 9: import 'settings.dart';
10: 
11: void showCustomNameDialog(BuildContext context) {
12:   showGeneralDialog(
13:       context: context,
14:       pageBuilder: (context, animation, secondaryAnimation) =>
15:           CustomNameDialog(animation: animation));
16: }
17: 
18: class CustomNameDialog extends StatefulWidget {
19:   final Animation<double> animation;
20: 
21:   const CustomNameDialog({required this.animation, super.key});
22: 
23:   @override
24:   State<CustomNameDialog> createState() => _CustomNameDialogState();
25: }
26: 
27: class _CustomNameDialogState extends State<CustomNameDialog> {
28:   final TextEditingController _controller = TextEditingController();
29: 
30:   @override
31:   Widget build(BuildContext context) {
32:     return ScaleTransition(
33:       scale: CurvedAnimation(
34:         parent: widget.animation,
35:         curve: Curves.easeOutCubic,
36:       ),
37:       child: SimpleDialog(
38:         title: const Text('Change name'),
39:         children: [
40:           TextField(
41:             controller: _controller,
42:             autofocus: true,
43:             maxLength: 12,
44:             maxLengthEnforcement: MaxLengthEnforcement.enforced,
45:             textAlign: TextAlign.center,
46:             textCapitalization: TextCapitalization.words,
47:             textInputAction: TextInputAction.done,
48:             onChanged: (value) {
49:               context.read<SettingsController>().setPlayerName(value);
50:             },
51:             onSubmitted: (value) {
52:               // Player tapped 'Submit'/'Done' on their keyboard.
53:               Navigator.pop(context);
54:             },
55:           ),
56:           TextButton(
57:             onPressed: () => Navigator.pop(context),
58:             child: const Text('Close'),
59:           ),
60:         ],
61:       ),
62:     );
63:   }
64: 
65:   @override
66:   void dispose() {
67:     _controller.dispose();
68:     super.dispose();
69:   }
70: 
71:   @override
72:   void initState() {
73:     super.initState();
74:     _controller.text = context.read<SettingsController>().playerName.value;
75:   }
76: }
````

## File: samples/ads/lib/settings/settings_screen.dart
````dart
  1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
  2: // for details. All rights reserved. Use of this source code is governed by a
  3: // BSD-style license that can be found in the LICENSE file.
  4: 
  5: import 'package:flutter/material.dart';
  6: import 'package:go_router/go_router.dart';
  7: import 'package:provider/provider.dart';
  8: 
  9: import '../player_progress/player_progress.dart';
 10: import '../style/my_button.dart';
 11: import '../style/palette.dart';
 12: import '../style/responsive_screen.dart';
 13: import 'custom_name_dialog.dart';
 14: import 'settings.dart';
 15: 
 16: class SettingsScreen extends StatelessWidget {
 17:   const SettingsScreen({super.key});
 18: 
 19:   static const _gap = SizedBox(height: 60);
 20: 
 21:   @override
 22:   Widget build(BuildContext context) {
 23:     final settings = context.watch<SettingsController>();
 24:     final palette = context.watch<Palette>();
 25: 
 26:     return Scaffold(
 27:       backgroundColor: palette.backgroundSettings,
 28:       body: ResponsiveScreen(
 29:         squarishMainArea: ListView(
 30:           children: [
 31:             _gap,
 32:             const Text(
 33:               'Settings',
 34:               textAlign: TextAlign.center,
 35:               style: TextStyle(
 36:                 fontFamily: 'Permanent Marker',
 37:                 fontSize: 55,
 38:                 height: 1,
 39:               ),
 40:             ),
 41:             _gap,
 42:             const _NameChangeLine(
 43:               'Name',
 44:             ),
 45:             ValueListenableBuilder<bool>(
 46:               valueListenable: settings.soundsOn,
 47:               builder: (context, soundsOn, child) => _SettingsLine(
 48:                 'Sound FX',
 49:                 Icon(soundsOn ? Icons.graphic_eq : Icons.volume_off),
 50:                 onSelected: () => settings.toggleSoundsOn(),
 51:               ),
 52:             ),
 53:             ValueListenableBuilder<bool>(
 54:               valueListenable: settings.musicOn,
 55:               builder: (context, musicOn, child) => _SettingsLine(
 56:                 'Music',
 57:                 Icon(musicOn ? Icons.music_note : Icons.music_off),
 58:                 onSelected: () => settings.toggleMusicOn(),
 59:               ),
 60:             ),
 61:             _SettingsLine(
 62:               'Reset progress',
 63:               const Icon(Icons.delete),
 64:               onSelected: () {
 65:                 context.read<PlayerProgress>().reset();
 66: 
 67:                 final messenger = ScaffoldMessenger.of(context);
 68:                 messenger.showSnackBar(
 69:                   const SnackBar(
 70:                       content: Text('Player progress has been reset.')),
 71:                 );
 72:               },
 73:             ),
 74:             _gap,
 75:           ],
 76:         ),
 77:         rectangularMenuArea: MyButton(
 78:           onPressed: () {
 79:             GoRouter.of(context).pop();
 80:           },
 81:           child: const Text('Back'),
 82:         ),
 83:       ),
 84:     );
 85:   }
 86: }
 87: 
 88: class _NameChangeLine extends StatelessWidget {
 89:   final String title;
 90: 
 91:   const _NameChangeLine(this.title);
 92: 
 93:   @override
 94:   Widget build(BuildContext context) {
 95:     final settings = context.watch<SettingsController>();
 96: 
 97:     return InkResponse(
 98:       highlightShape: BoxShape.rectangle,
 99:       onTap: () => showCustomNameDialog(context),
100:       child: Padding(
101:         padding: const EdgeInsets.symmetric(horizontal: 8),
102:         child: Row(
103:           mainAxisAlignment: MainAxisAlignment.center,
104:           children: [
105:             Text(title,
106:                 style: const TextStyle(
107:                   fontFamily: 'Permanent Marker',
108:                   fontSize: 30,
109:                 )),
110:             const Spacer(),
111:             ValueListenableBuilder(
112:               valueListenable: settings.playerName,
113:               builder: (context, name, child) => Text(
114:                 '‘$name’',
115:                 style: const TextStyle(
116:                   fontFamily: 'Permanent Marker',
117:                   fontSize: 30,
118:                 ),
119:               ),
120:             ),
121:           ],
122:         ),
123:       ),
124:     );
125:   }
126: }
127: 
128: class _SettingsLine extends StatelessWidget {
129:   final String title;
130: 
131:   final Widget icon;
132: 
133:   final VoidCallback? onSelected;
134: 
135:   const _SettingsLine(this.title, this.icon, {this.onSelected});
136: 
137:   @override
138:   Widget build(BuildContext context) {
139:     return InkResponse(
140:       highlightShape: BoxShape.rectangle,
141:       onTap: onSelected,
142:       child: Padding(
143:         padding: const EdgeInsets.symmetric(horizontal: 8),
144:         child: Row(
145:           mainAxisAlignment: MainAxisAlignment.start,
146:           children: [
147:             Expanded(
148:               child: Text(
149:                 title,
150:                 maxLines: 1,
151:                 overflow: TextOverflow.ellipsis,
152:                 style: const TextStyle(
153:                   fontFamily: 'Permanent Marker',
154:                   fontSize: 30,
155:                 ),
156:               ),
157:             ),
158:             icon,
159:           ],
160:         ),
161:       ),
162:     );
163:   }
164: }
````

## File: samples/ads/lib/settings/settings.dart
````dart
 1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: import 'package:flutter/foundation.dart';
 6: import 'package:logging/logging.dart';
 7: 
 8: import 'persistence/local_storage_settings_persistence.dart';
 9: import 'persistence/settings_persistence.dart';
10: 
11: /// An class that holds settings like [playerName] or [musicOn],
12: /// and saves them to an injected persistence store.
13: class SettingsController {
14:   static final _log = Logger('SettingsController');
15: 
16:   /// The persistence store that is used to save settings.
17:   final SettingsPersistence _store;
18: 
19:   /// Whether or not the audio is on at all. This overrides both music
20:   /// and sounds (sfx).
21:   ///
22:   /// This is an important feature especially on mobile, where players
23:   /// expect to be able to quickly mute all the audio. Having this as
24:   /// a separate flag (as opposed to some kind of {off, sound, everything}
25:   /// enum) means that the player will not lose their [soundsOn] and
26:   /// [musicOn] preferences when they temporarily mute the game.
27:   ValueNotifier<bool> audioOn = ValueNotifier(true);
28: 
29:   /// The player's name. Used for things like high score lists.
30:   ValueNotifier<String> playerName = ValueNotifier('Player');
31: 
32:   /// Whether or not the sound effects (sfx) are on.
33:   ValueNotifier<bool> soundsOn = ValueNotifier(true);
34: 
35:   /// Whether or not the music is on.
36:   ValueNotifier<bool> musicOn = ValueNotifier(true);
37: 
38:   /// Creates a new instance of [SettingsController] backed by [store].
39:   ///
40:   /// By default, settings are persisted using [LocalStorageSettingsPersistence]
41:   /// (i.e. NSUserDefaults on iOS, SharedPreferences on Android or
42:   /// local storage on the web).
43:   SettingsController({SettingsPersistence? store})
44:       : _store = store ?? LocalStorageSettingsPersistence() {
45:     _loadStateFromPersistence();
46:   }
47: 
48:   void setPlayerName(String name) {
49:     playerName.value = name;
50:     _store.savePlayerName(playerName.value);
51:   }
52: 
53:   void toggleAudioOn() {
54:     audioOn.value = !audioOn.value;
55:     _store.saveAudioOn(audioOn.value);
56:   }
57: 
58:   void toggleMusicOn() {
59:     musicOn.value = !musicOn.value;
60:     _store.saveMusicOn(musicOn.value);
61:   }
62: 
63:   void toggleSoundsOn() {
64:     soundsOn.value = !soundsOn.value;
65:     _store.saveSoundsOn(soundsOn.value);
66:   }
67: 
68:   /// Asynchronously loads values from the injected persistence store.
69:   Future<void> _loadStateFromPersistence() async {
70:     final loadedValues = await Future.wait([
71:       _store.getAudioOn(defaultValue: true).then((value) {
72:         if (kIsWeb) {
73:           // On the web, sound can only start after user interaction, so
74:           // we start muted there on every game start.
75:           return audioOn.value = false;
76:         }
77:         // On other platforms, we can use the persisted value.
78:         return audioOn.value = value;
79:       }),
80:       _store
81:           .getSoundsOn(defaultValue: true)
82:           .then((value) => soundsOn.value = value),
83:       _store
84:           .getMusicOn(defaultValue: true)
85:           .then((value) => musicOn.value = value),
86:       _store.getPlayerName().then((value) => playerName.value = value),
87:     ]);
88: 
89:     _log.fine(() => 'Loaded settings: $loadedValues');
90:   }
91: }
````

## File: samples/ads/lib/style/confetti.dart
````dart
  1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
  2: // for details. All rights reserved. Use of this source code is governed by a
  3: // BSD-style license that can be found in the LICENSE file.
  4: 
  5: import 'dart:collection';
  6: import 'dart:math';
  7: 
  8: import 'package:flutter/widgets.dart';
  9: 
 10: /// Shows a confetti (celebratory) animation: paper snippings falling down.
 11: ///
 12: /// The widget fills the available space (like [SizedBox.expand] would).
 13: ///
 14: /// When [isStopped] is `true`, the animation will not run. This is useful
 15: /// when the widget is not visible yet, for example. Provide [colors]
 16: /// to make the animation look good in context.
 17: ///
 18: /// This is a partial port of this CodePen by Hemn Chawroka:
 19: /// https://codepen.io/iprodev/pen/azpWBr
 20: class Confetti extends StatefulWidget {
 21:   static const _defaultColors = [
 22:     Color(0xffd10841),
 23:     Color(0xff1d75fb),
 24:     Color(0xff0050bc),
 25:     Color(0xffa2dcc7),
 26:   ];
 27: 
 28:   final bool isStopped;
 29: 
 30:   final List<Color> colors;
 31: 
 32:   const Confetti({
 33:     this.colors = _defaultColors,
 34:     this.isStopped = false,
 35:     super.key,
 36:   });
 37: 
 38:   @override
 39:   State<Confetti> createState() => _ConfettiState();
 40: }
 41: 
 42: class ConfettiPainter extends CustomPainter {
 43:   final defaultPaint = Paint();
 44: 
 45:   final int snippingsCount = 200;
 46: 
 47:   late final List<_PaperSnipping> _snippings;
 48: 
 49:   Size? _size;
 50: 
 51:   DateTime _lastTime = DateTime.now();
 52: 
 53:   final UnmodifiableListView<Color> colors;
 54: 
 55:   ConfettiPainter(
 56:       {required Listenable animation, required Iterable<Color> colors})
 57:       : colors = UnmodifiableListView(colors),
 58:         super(repaint: animation);
 59: 
 60:   @override
 61:   void paint(Canvas canvas, Size size) {
 62:     if (_size == null) {
 63:       // First time we have a size.
 64:       _snippings = List.generate(
 65:           snippingsCount,
 66:           (i) => _PaperSnipping(
 67:                 frontColor: colors[i % colors.length],
 68:                 bounds: size,
 69:               ));
 70:     }
 71: 
 72:     final didResize = _size != null && _size != size;
 73:     final now = DateTime.now();
 74:     final dt = now.difference(_lastTime);
 75:     for (final snipping in _snippings) {
 76:       if (didResize) {
 77:         snipping.updateBounds(size);
 78:       }
 79:       snipping.update(dt.inMilliseconds / 1000);
 80:       snipping.draw(canvas);
 81:     }
 82: 
 83:     _size = size;
 84:     _lastTime = now;
 85:   }
 86: 
 87:   @override
 88:   bool shouldRepaint(covariant CustomPainter oldDelegate) {
 89:     return true;
 90:   }
 91: }
 92: 
 93: class _ConfettiState extends State<Confetti>
 94:     with SingleTickerProviderStateMixin {
 95:   late AnimationController _controller;
 96: 
 97:   @override
 98:   Widget build(BuildContext context) {
 99:     return CustomPaint(
100:       painter: ConfettiPainter(
101:         colors: widget.colors,
102:         animation: _controller,
103:       ),
104:       willChange: true,
105:       child: const SizedBox.expand(),
106:     );
107:   }
108: 
109:   @override
110:   void didUpdateWidget(covariant Confetti oldWidget) {
111:     super.didUpdateWidget(oldWidget);
112:     if (oldWidget.isStopped && !widget.isStopped) {
113:       _controller.repeat();
114:     } else if (!oldWidget.isStopped && widget.isStopped) {
115:       _controller.stop(canceled: false);
116:     }
117:   }
118: 
119:   @override
120:   void dispose() {
121:     _controller.dispose();
122:     super.dispose();
123:   }
124: 
125:   @override
126:   void initState() {
127:     super.initState();
128:     _controller = AnimationController(
129:       // We don't really care about the duration, since we're going to
130:       // use the controller on loop anyway.
131:       duration: const Duration(seconds: 1),
132:       vsync: this,
133:     );
134: 
135:     if (!widget.isStopped) {
136:       _controller.repeat();
137:     }
138:   }
139: }
140: 
141: class _PaperSnipping {
142:   static final Random _random = Random();
143: 
144:   static const degToRad = pi / 180;
145: 
146:   static const backSideBlend = Color(0x70EEEEEE);
147: 
148:   Size _bounds;
149: 
150:   late final _Vector position = _Vector(
151:     _random.nextDouble() * _bounds.width,
152:     _random.nextDouble() * _bounds.height,
153:   );
154: 
155:   final double rotationSpeed = 800 + _random.nextDouble() * 600;
156: 
157:   final double angle = _random.nextDouble() * 360 * degToRad;
158: 
159:   double rotation = _random.nextDouble() * 360 * degToRad;
160: 
161:   double cosA = 1.0;
162: 
163:   final double size = 7.0;
164: 
165:   final double oscillationSpeed = 0.5 + _random.nextDouble() * 1.5;
166: 
167:   final double xSpeed = 40;
168: 
169:   final double ySpeed = 50 + _random.nextDouble() * 60;
170: 
171:   late List<_Vector> corners = List.generate(4, (i) {
172:     final angle = this.angle + degToRad * (45 + i * 90);
173:     return _Vector(cos(angle), sin(angle));
174:   });
175: 
176:   double time = _random.nextDouble();
177: 
178:   final Color frontColor;
179: 
180:   late final Color backColor = Color.alphaBlend(backSideBlend, frontColor);
181: 
182:   final paint = Paint()..style = PaintingStyle.fill;
183: 
184:   _PaperSnipping({
185:     required this.frontColor,
186:     required Size bounds,
187:   }) : _bounds = bounds;
188: 
189:   void draw(Canvas canvas) {
190:     if (cosA > 0) {
191:       paint.color = frontColor;
192:     } else {
193:       paint.color = backColor;
194:     }
195: 
196:     final path = Path()
197:       ..addPolygon(
198:         List.generate(
199:             4,
200:             (index) => Offset(
201:                   position.x + corners[index].x * size,
202:                   position.y + corners[index].y * size * cosA,
203:                 )),
204:         true,
205:       );
206:     canvas.drawPath(path, paint);
207:   }
208: 
209:   void update(double dt) {
210:     time += dt;
211:     rotation += rotationSpeed * dt;
212:     cosA = cos(degToRad * rotation);
213:     position.x += cos(time * oscillationSpeed) * xSpeed * dt;
214:     position.y += ySpeed * dt;
215:     if (position.y > _bounds.height) {
216:       // Move the snipping back to the top.
217:       position.x = _random.nextDouble() * _bounds.width;
218:       position.y = 0;
219:     }
220:   }
221: 
222:   void updateBounds(Size newBounds) {
223:     if (!newBounds.contains(Offset(position.x, position.y))) {
224:       position.x = _random.nextDouble() * newBounds.width;
225:       position.y = _random.nextDouble() * newBounds.height;
226:     }
227:     _bounds = newBounds;
228:   }
229: }
230: 
231: class _Vector {
232:   double x, y;
233:   _Vector(this.x, this.y);
234: }
````

## File: samples/ads/lib/style/my_button.dart
````dart
 1: // Copyright 2023, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: import 'dart:math';
 6: 
 7: import 'package:flutter/material.dart';
 8: 
 9: class MyButton extends StatefulWidget {
10:   final Widget child;
11: 
12:   final VoidCallback? onPressed;
13: 
14:   const MyButton({super.key, required this.child, this.onPressed});
15: 
16:   @override
17:   State<MyButton> createState() => _MyButtonState();
18: }
19: 
20: class _MyButtonState extends State<MyButton>
21:     with SingleTickerProviderStateMixin {
22:   late final AnimationController _controller = AnimationController(
23:     duration: const Duration(milliseconds: 300),
24:     vsync: this,
25:   );
26: 
27:   @override
28:   void dispose() {
29:     _controller.dispose();
30:     super.dispose();
31:   }
32: 
33:   @override
34:   Widget build(BuildContext context) {
35:     return MouseRegion(
36:       onEnter: (event) {
37:         _controller.repeat();
38:       },
39:       onExit: (event) {
40:         _controller.stop(canceled: false);
41:       },
42:       child: RotationTransition(
43:         turns: _controller.drive(const _MySineTween(0.005)),
44:         child: FilledButton(
45:           onPressed: widget.onPressed,
46:           child: widget.child,
47:         ),
48:       ),
49:     );
50:   }
51: }
52: 
53: class _MySineTween extends Animatable<double> {
54:   final double maxExtent;
55: 
56:   const _MySineTween(this.maxExtent);
57: 
58:   @override
59:   double transform(double t) {
60:     return sin(t * 2 * pi) * maxExtent;
61:   }
62: }
````

## File: samples/ads/lib/style/my_transition.dart
````dart
 1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: import 'package:flutter/material.dart';
 6: import 'package:go_router/go_router.dart';
 7: 
 8: CustomTransitionPage<T> buildMyTransition<T>({
 9:   required Widget child,
10:   required Color color,
11:   String? name,
12:   Object? arguments,
13:   String? restorationId,
14:   LocalKey? key,
15: }) {
16:   return CustomTransitionPage<T>(
17:     child: child,
18:     transitionsBuilder: (context, animation, secondaryAnimation, child) {
19:       return _MyReveal(
20:         animation: animation,
21:         color: color,
22:         child: child,
23:       );
24:     },
25:     key: key,
26:     name: name,
27:     arguments: arguments,
28:     restorationId: restorationId,
29:     transitionDuration: const Duration(milliseconds: 700),
30:   );
31: }
32: 
33: class _MyReveal extends StatelessWidget {
34:   final Widget child;
35: 
36:   final Animation<double> animation;
37: 
38:   final Color color;
39: 
40:   final _slideTween = Tween(begin: const Offset(0, -1), end: Offset.zero);
41: 
42:   final _fadeTween = TweenSequence([
43:     TweenSequenceItem(tween: ConstantTween(0.0), weight: 1),
44:     TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0), weight: 1),
45:   ]);
46: 
47:   _MyReveal({
48:     required this.child,
49:     required this.animation,
50:     required this.color,
51:   });
52: 
53:   @override
54:   Widget build(BuildContext context) {
55:     return Stack(
56:       fit: StackFit.expand,
57:       children: [
58:         SlideTransition(
59:           position: _slideTween.animate(
60:             CurvedAnimation(
61:               parent: animation,
62:               curve: Curves.easeOutCubic,
63:               reverseCurve: Curves.easeOutCubic,
64:             ),
65:           ),
66:           child: Container(
67:             color: color,
68:           ),
69:         ),
70:         FadeTransition(
71:           opacity: _fadeTween.animate(animation),
72:           child: child,
73:         ),
74:       ],
75:     );
76:   }
77: }
````

## File: samples/ads/lib/style/palette.dart
````dart
 1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: import 'package:flutter/material.dart';
 6: 
 7: /// A palette of colors to be used in the game.
 8: ///
 9: /// The reason we're not going with something like Material Design's
10: /// `Theme` is simply that this is simpler to work with and yet gives
11: /// us everything we need for a game.
12: ///
13: /// Games generally have more radical color palettes than apps. For example,
14: /// every level of a game can have radically different colors.
15: /// At the same time, games rarely support dark mode.
16: ///
17: /// Colors taken from this fun palette:
18: /// https://lospec.com/palette-list/crayola84
19: ///
20: /// Colors here are implemented as getters so that hot reloading works.
21: /// In practice, we could just as easily implement the colors
22: /// as `static const`. But this way the palette is more malleable:
23: /// we could allow players to customize colors, for example,
24: /// or even get the colors from the network.
25: class Palette {
26:   Color get pen => const Color(0xff1d75fb);
27:   Color get darkPen => const Color(0xFF0050bc);
28:   Color get redPen => const Color(0xFFd10841);
29:   Color get inkFullOpacity => const Color(0xff352b42);
30:   Color get ink => const Color(0xee352b42);
31:   Color get backgroundMain => const Color(0xffffffd1);
32:   Color get backgroundLevelSelection => const Color(0xffa2dcc7);
33:   Color get backgroundPlaySession => const Color(0xffffebb5);
34:   Color get background4 => const Color(0xffffd7ff);
35:   Color get backgroundSettings => const Color(0xffbfc8e3);
36:   Color get trueWhite => const Color(0xffffffff);
37: }
````

## File: samples/ads/lib/style/responsive_screen.dart
````dart
  1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
  2: // for details. All rights reserved. Use of this source code is governed by a
  3: // BSD-style license that can be found in the LICENSE file.
  4: 
  5: import 'package:flutter/material.dart';
  6: 
  7: /// A widget that makes it easy to create a screen with a square-ish
  8: /// main area, a smaller menu area, and a small area for a message on top.
  9: /// It works in both orientations on mobile- and tablet-sized screens.
 10: class ResponsiveScreen extends StatelessWidget {
 11:   /// This is the "hero" of the screen. It's more or less square, and will
 12:   /// be placed in the visual "center" of the screen.
 13:   final Widget squarishMainArea;
 14: 
 15:   /// The second-largest area after [squarishMainArea]. It can be narrow
 16:   /// or wide.
 17:   final Widget rectangularMenuArea;
 18: 
 19:   /// An area reserved for some static text close to the top of the screen.
 20:   final Widget topMessageArea;
 21: 
 22:   const ResponsiveScreen({
 23:     required this.squarishMainArea,
 24:     required this.rectangularMenuArea,
 25:     this.topMessageArea = const SizedBox.shrink(),
 26:     super.key,
 27:   });
 28: 
 29:   @override
 30:   Widget build(BuildContext context) {
 31:     return LayoutBuilder(
 32:       builder: (context, constraints) {
 33:         // This widget wants to fill the whole screen.
 34:         final size = constraints.biggest;
 35:         final padding = EdgeInsets.all(size.shortestSide / 30);
 36: 
 37:         if (size.height >= size.width) {
 38:           // "Portrait" / "mobile" mode.
 39:           return Column(
 40:             crossAxisAlignment: CrossAxisAlignment.stretch,
 41:             children: [
 42:               SafeArea(
 43:                 bottom: false,
 44:                 child: Padding(
 45:                   padding: padding,
 46:                   child: topMessageArea,
 47:                 ),
 48:               ),
 49:               Expanded(
 50:                 child: SafeArea(
 51:                   top: false,
 52:                   bottom: false,
 53:                   minimum: padding,
 54:                   child: squarishMainArea,
 55:                 ),
 56:               ),
 57:               SafeArea(
 58:                 top: false,
 59:                 maintainBottomViewPadding: true,
 60:                 child: Padding(
 61:                   padding: padding,
 62:                   child: Center(
 63:                     child: rectangularMenuArea,
 64:                   ),
 65:                 ),
 66:               ),
 67:             ],
 68:           );
 69:         } else {
 70:           // "Landscape" / "tablet" mode.
 71:           final isLarge = size.width > 900;
 72: 
 73:           return Row(
 74:             crossAxisAlignment: CrossAxisAlignment.stretch,
 75:             children: [
 76:               Expanded(
 77:                 flex: isLarge ? 7 : 5,
 78:                 child: SafeArea(
 79:                   right: false,
 80:                   maintainBottomViewPadding: true,
 81:                   minimum: padding,
 82:                   child: squarishMainArea,
 83:                 ),
 84:               ),
 85:               Expanded(
 86:                 flex: 3,
 87:                 child: Column(
 88:                   children: [
 89:                     SafeArea(
 90:                       bottom: false,
 91:                       left: false,
 92:                       maintainBottomViewPadding: true,
 93:                       child: Padding(
 94:                         padding: padding,
 95:                         child: topMessageArea,
 96:                       ),
 97:                     ),
 98:                     Expanded(
 99:                       child: SafeArea(
100:                         top: false,
101:                         left: false,
102:                         maintainBottomViewPadding: true,
103:                         child: Align(
104:                           alignment: Alignment.bottomCenter,
105:                           child: Padding(
106:                             padding: padding,
107:                             child: rectangularMenuArea,
108:                           ),
109:                         ),
110:                       ),
111:                     )
112:                   ],
113:                 ),
114:               ),
115:             ],
116:           );
117:         }
118:       },
119:     );
120:   }
121: }
````

## File: samples/ads/lib/win_game/win_game_screen.dart
````dart
 1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: import 'package:flutter/material.dart';
 6: import 'package:go_router/go_router.dart';
 7: import 'package:provider/provider.dart';
 8: 
 9: import '../ads/my_banner_ad.dart';
10: import '../game_internals/score.dart';
11: import '../style/my_button.dart';
12: import '../style/palette.dart';
13: import '../style/responsive_screen.dart';
14: 
15: class WinGameScreen extends StatelessWidget {
16:   final Score score;
17: 
18:   const WinGameScreen({
19:     super.key,
20:     required this.score,
21:   });
22: 
23:   @override
24:   Widget build(BuildContext context) {
25:     final palette = context.watch<Palette>();
26: 
27:     const gap = SizedBox(height: 10);
28: 
29:     return Scaffold(
30:       backgroundColor: palette.backgroundPlaySession,
31:       body: ResponsiveScreen(
32:         squarishMainArea: Column(
33:           mainAxisAlignment: MainAxisAlignment.center,
34:           children: <Widget>[
35:             gap,
36:             MyBannerAdWidget(),
37:             gap,
38:             const Center(
39:               child: Text(
40:                 'You won!',
41:                 style: TextStyle(fontFamily: 'Permanent Marker', fontSize: 50),
42:               ),
43:             ),
44:             gap,
45:             Center(
46:               child: Text(
47:                 'Score: ${score.score}\n'
48:                 'Time: ${score.formattedTime}',
49:                 style: const TextStyle(
50:                     fontFamily: 'Permanent Marker', fontSize: 20),
51:               ),
52:             ),
53:           ],
54:         ),
55:         rectangularMenuArea: MyButton(
56:           onPressed: () {
57:             GoRouter.of(context).go('/play');
58:           },
59:           child: const Text('Continue'),
60:         ),
61:       ),
62:     );
63:   }
64: }
````

## File: samples/ads/lib/main.dart
````dart
  1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
  2: // for details. All rights reserved. Use of this source code is governed by a
  3: // BSD-style license that can be found in the LICENSE file.
  4: 
  5: import 'dart:async';
  6: import 'dart:developer' as dev;
  7: 
  8: import 'package:flutter/foundation.dart';
  9: import 'package:flutter/material.dart';
 10: import 'package:flutter/services.dart';
 11: import 'package:google_mobile_ads/google_mobile_ads.dart';
 12: import 'package:logging/logging.dart';
 13: import 'package:provider/provider.dart';
 14: 
 15: import 'app_lifecycle/app_lifecycle.dart';
 16: import 'audio/audio_controller.dart';
 17: import 'player_progress/player_progress.dart';
 18: import 'router.dart';
 19: import 'settings/settings.dart';
 20: import 'style/palette.dart';
 21: 
 22: void main() async {
 23:   // Basic logging setup.
 24:   Logger.root.level = kDebugMode ? Level.FINE : Level.INFO;
 25:   Logger.root.onRecord.listen((record) {
 26:     dev.log(
 27:       record.message,
 28:       time: record.time,
 29:       level: record.level.value,
 30:       name: record.loggerName,
 31:     );
 32:   });
 33: 
 34:   WidgetsFlutterBinding.ensureInitialized();
 35:   // Put game into full screen mode on mobile devices.
 36:   await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
 37:   // Lock the game to portrait mode on mobile devices.
 38:   await SystemChrome.setPreferredOrientations([
 39:     DeviceOrientation.portraitUp,
 40:     DeviceOrientation.portraitDown,
 41:   ]);
 42: 
 43:   unawaited(MobileAds.instance.initialize());
 44: 
 45:   runApp(const MyApp());
 46: }
 47: 
 48: class MyApp extends StatelessWidget {
 49:   const MyApp({super.key});
 50: 
 51:   @override
 52:   Widget build(BuildContext context) {
 53:     return AppLifecycleObserver(
 54:       child: MultiProvider(
 55:         // This is where you add objects that you want to have available
 56:         // throughout your game.
 57:         //
 58:         // Every widget in the game can access these objects by calling
 59:         // `context.watch()` or `context.read()`.
 60:         // See `lib/main_menu/main_menu_screen.dart` for example usage.
 61:         providers: [
 62:           Provider(create: (context) => SettingsController()),
 63:           Provider(create: (context) => Palette()),
 64:           ChangeNotifierProvider(create: (context) => PlayerProgress()),
 65:           // Set up audio.
 66:           ProxyProvider2<AppLifecycleStateNotifier, SettingsController,
 67:               AudioController>(
 68:             create: (context) => AudioController(),
 69:             update: (context, lifecycleNotifier, settings, audio) {
 70:               audio!.attachDependencies(lifecycleNotifier, settings);
 71:               return audio;
 72:             },
 73:             dispose: (context, audio) => audio.dispose(),
 74:             // Ensures that music starts immediately.
 75:             lazy: false,
 76:           ),
 77:         ],
 78:         child: Builder(builder: (context) {
 79:           final palette = context.watch<Palette>();
 80: 
 81:           return MaterialApp.router(
 82:             title: 'My Flutter Game',
 83:             theme: ThemeData.from(
 84:               colorScheme: ColorScheme.fromSeed(
 85:                 seedColor: palette.darkPen,
 86:                 surface: palette.backgroundMain,
 87:               ),
 88:               textTheme: TextTheme(
 89:                 bodyMedium: TextStyle(color: palette.ink),
 90:               ),
 91:               useMaterial3: true,
 92:             ).copyWith(
 93:               // Make buttons more fun.
 94:               filledButtonTheme: FilledButtonThemeData(
 95:                 style: FilledButton.styleFrom(
 96:                   textStyle: const TextStyle(
 97:                     fontWeight: FontWeight.bold,
 98:                     fontSize: 20,
 99:                   ),
100:                 ),
101:               ),
102:             ),
103:             routeInformationProvider: router.routeInformationProvider,
104:             routeInformationParser: router.routeInformationParser,
105:             routerDelegate: router.routerDelegate,
106:           );
107:         }),
108:       ),
109:     );
110:   }
111: }
````

## File: samples/ads/lib/router.dart
````dart
 1: // Copyright 2023, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: import 'package:flutter/foundation.dart';
 6: import 'package:go_router/go_router.dart';
 7: import 'package:provider/provider.dart';
 8: 
 9: import 'game_internals/score.dart';
10: import 'level_selection/level_selection_screen.dart';
11: import 'level_selection/levels.dart';
12: import 'main_menu/main_menu_screen.dart';
13: import 'play_session/play_session_screen.dart';
14: import 'settings/settings_screen.dart';
15: import 'style/my_transition.dart';
16: import 'style/palette.dart';
17: import 'win_game/win_game_screen.dart';
18: 
19: /// The router describes the game's navigational hierarchy, from the main
20: /// screen through settings screens all the way to each individual level.
21: final router = GoRouter(
22:   routes: [
23:     GoRoute(
24:       path: '/',
25:       builder: (context, state) => const MainMenuScreen(key: Key('main menu')),
26:       routes: [
27:         GoRoute(
28:             path: 'play',
29:             pageBuilder: (context, state) => buildMyTransition<void>(
30:                   key: const ValueKey('play'),
31:                   color: context.watch<Palette>().backgroundLevelSelection,
32:                   child: const LevelSelectionScreen(
33:                     key: Key('level selection'),
34:                   ),
35:                 ),
36:             routes: [
37:               GoRoute(
38:                 path: 'session/:level',
39:                 pageBuilder: (context, state) {
40:                   final levelNumber = int.parse(state.pathParameters['level']!);
41:                   final level =
42:                       gameLevels.singleWhere((e) => e.number == levelNumber);
43:                   return buildMyTransition<void>(
44:                     key: const ValueKey('level'),
45:                     color: context.watch<Palette>().backgroundPlaySession,
46:                     child: PlaySessionScreen(
47:                       level,
48:                       key: const Key('play session'),
49:                     ),
50:                   );
51:                 },
52:               ),
53:               GoRoute(
54:                 path: 'won',
55:                 redirect: (context, state) {
56:                   if (state.extra == null) {
57:                     // Trying to navigate to a win screen without any data.
58:                     // Possibly by using the browser's back button.
59:                     return '/';
60:                   }
61: 
62:                   // Otherwise, do not redirect.
63:                   return null;
64:                 },
65:                 pageBuilder: (context, state) {
66:                   final map = state.extra! as Map<String, dynamic>;
67:                   final score = map['score'] as Score;
68: 
69:                   return buildMyTransition<void>(
70:                     key: const ValueKey('won'),
71:                     color: context.watch<Palette>().backgroundPlaySession,
72:                     child: WinGameScreen(
73:                       score: score,
74:                       key: const Key('win game'),
75:                     ),
76:                   );
77:                 },
78:               )
79:             ]),
80:         GoRoute(
81:           path: 'settings',
82:           builder: (context, state) =>
83:               const SettingsScreen(key: Key('settings')),
84:         ),
85:       ],
86:     ),
87:   ],
88: );
````

## File: samples/ads/test/smoke_test.dart
````dart
 1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: import 'package:ads/ads/my_banner_ad.dart';
 6: import 'package:ads/main.dart';
 7: import 'package:flutter/material.dart';
 8: import 'package:flutter_test/flutter_test.dart';
 9: 
10: void main() {
11:   testWidgets('smoke test', (tester) async {
12:     // Build our game and trigger a frame.
13:     await tester.pumpWidget(MyApp());
14: 
15:     // Verify that the 'Play' button is shown.
16:     expect(find.text('Play'), findsOneWidget);
17: 
18:     // Tap 'Play'.
19:     await tester.tap(find.text('Play'));
20:     await tester.pumpAndSettle();
21:     expect(find.text('Select level'), findsOneWidget);
22: 
23:     // Tap level 1.
24:     await tester.tap(find.text('Level #1'));
25:     await tester.pumpAndSettle();
26: 
27:     // Find the first level's "tutorial" text.
28:     expect(find.text('Drag the slider to 5% or above!'), findsOneWidget);
29: 
30:     // Win game by tapping into the middle of the slider.
31:     await tester.tap(find.byType(Slider));
32: 
33:     // Wait for success animation.
34:     await tester.pumpAndSettle(const Duration(seconds: 2));
35: 
36:     // Expect the banner.
37:     expect(find.byType(MyBannerAdWidget), findsOneWidget);
38:   });
39: }
````

## File: samples/ads/analysis_options.yaml
````yaml
 1: include: package:flutter_lints/flutter.yaml
 2: 
 3: analyzer:
 4:   language:
 5:     strict-casts: true
 6: 
 7: linter:
 8:   rules:
 9:     # Remove or force lint rules by adding lines like the following.
10:     # The lints below are disabled in order to make things smoother in early
11:     # development. Consider enabling them once development is further along.
12:     prefer_const_constructors: false  # Annoying in early development
13:     prefer_single_quotes: false  # Annoying in early development
````

## File: samples/ads/pubspec.yaml
````yaml
 1: name: ads
 2: description: A basic game with a banner ad.
 3: 
 4: # Prevent accidental publishing to pub.dev.
 5: publish_to: 'none'
 6: 
 7: version: 0.0.1+1
 8: 
 9: environment:
10:   sdk: ^3.5.0
11: 
12: dependencies:
13:   flutter:
14:     sdk: flutter
15: 
16:   audioplayers: ^6.0.0
17:   go_router: ^14.0.0
18:   google_mobile_ads: ^3.1.0
19:   logging: ^1.2.0
20:   provider: ^6.1.2
21:   shared_preferences: ^2.2.3
22: 
23: dev_dependencies:
24:   flutter_lints: ^5.0.0
25:   flutter_test:
26:     sdk: flutter
27:   flutter_launcher_icons: ^0.13.1
28:   test: ^1.24.3
29: 
30: flutter:
31:   uses-material-design: true
32: 
33:   assets:
34:     - assets/images/
35:     - assets/music/
36:     - assets/sfx/
37: 
38:   fonts:
39:     - family: Permanent Marker
40:       fonts:
41:         - asset: assets/fonts/Permanent_Marker/PermanentMarker-Regular.ttf
42: 
43: flutter_launcher_icons:
44:   android: true
45:   ios: true
46:   image_path: "assets/icons/icon.png"
47:   adaptive_icon_background: "#FFFFFF"
48:   adaptive_icon_foreground: "assets/icons/icon-adaptive-foreground.png"
````

## File: samples/ads/README.md
````markdown
 1: A sample project based on the
 2: [`basic` template](https://github.com/flutter/games/tree/main/templates/basic)
 3: that shows a banner ad on the "win" screen.
 4: 
 5: Read more about adding ads to your mobile game
 6: in this cookbook recipe:
 7: 
 8: https://flutter.dev/cookbook/plugins/google-mobile-ads/
 9: 
10: 
11: ## How to get this sample
12: 
13: You can clone this whole repository and find this sample in your local copy.
14: 
15: For convenience, though, we also provide a command line tool that downloads
16: just the project you want.
17: 
18: On the command line, while having the
19: [Flutter SDK installed](https://docs.flutter.dev/get-started/install),
20: run the following command:
21: 
22: ```shell
23: dart pub global activate sample_downloader
24: ```
25: 
26: Then, from any directory, run the newly installed tool
27: and follow its instructions.
28: 
29: ```shell
30: sample_downloader
31: ```
````

## File: samples/crossword/ios/Runner/Assets.xcassets/LaunchImage.imageset/README.md
````markdown
1: # Launch Screen Assets
2: 
3: You can customize the launch screen with your own desired assets by replacing the image files in this directory.
4: 
5: You can also do it by opening your Flutter project's Xcode project with `open ios/Runner.xcworkspace`, selecting `Runner/Assets.xcassets` in the Project Navigator and dropping in the desired images.
````

## File: samples/crossword/lib/widgets/crossword_generator_widget.dart
````dart
 1: // Copyright 2024 The Flutter Authors. All rights reserved.
 2: // Use of this source code is governed by a BSD-style license that can be
 3: // found in the LICENSE file.
 4: 
 5: import 'package:flutter/material.dart';
 6: import 'package:flutter_riverpod/flutter_riverpod.dart';
 7: import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';
 8: 
 9: import '../model.dart';
10: import '../providers.dart';
11: 
12: class CrosswordGeneratorWidget extends ConsumerWidget {
13:   const CrosswordGeneratorWidget({super.key});
14: 
15:   @override
16:   Widget build(BuildContext context, WidgetRef ref) {
17:     final size = ref.watch(sizeProvider);
18:     return TableView.builder(
19:       diagonalDragBehavior: DiagonalDragBehavior.free,
20:       cellBuilder: _buildCell,
21:       columnCount: size.width,
22:       columnBuilder: (index) => _buildSpan(context, index),
23:       rowCount: size.height,
24:       rowBuilder: (index) => _buildSpan(context, index),
25:     );
26:   }
27: 
28:   TableViewCell _buildCell(BuildContext context, TableVicinity vicinity) {
29:     final location = Location.at(vicinity.column, vicinity.row);
30: 
31:     return TableViewCell(
32:       child: Consumer(
33:         builder: (context, ref, _) {
34:           final character = ref.watch(
35:             workQueueProvider.select(
36:               (workQueueAsync) => workQueueAsync.when(
37:                 data: (workQueue) => workQueue.crossword.characters[location],
38:                 error: (error, stackTrace) => null,
39:                 loading: () => null,
40:               ),
41:             ),
42:           );
43:           final explorationCell = ref.watch(
44:             workQueueProvider.select(
45:               (workQueueAsync) => workQueueAsync.when(
46:                 data: (workQueue) =>
47:                     workQueue.locationsToTry.keys.contains(location),
48:                 error: (error, stackTrace) => false,
49:                 loading: () => false,
50:               ),
51:             ),
52:           );
53:           final colorScheme = Theme.of(context).colorScheme;
54: 
55:           if (character != null) {
56:             return AnimatedContainer(
57:               duration: Durations.extralong1,
58:               curve: Curves.easeInOut,
59:               color:
60:                   explorationCell ? colorScheme.primary : colorScheme.onPrimary,
61:               child: Center(
62:                 child: AnimatedDefaultTextStyle(
63:                   duration: Durations.extralong1,
64:                   curve: Curves.easeInOut,
65:                   style: TextStyle(
66:                     fontSize: 24,
67:                     color: explorationCell
68:                         ? colorScheme.onPrimary
69:                         : colorScheme.primary,
70:                   ),
71:                   child: const Text(
72:                       '•'), // https://www.compart.com/en/unicode/U+2022
73:                 ),
74:               ),
75:             );
76:           }
77: 
78:           return ColoredBox(
79:             color: colorScheme.primaryContainer,
80:           );
81:         },
82:       ),
83:     );
84:   }
85: 
86:   TableSpan _buildSpan(BuildContext context, int index) {
87:     return TableSpan(
88:       extent: const FixedTableSpanExtent(32),
89:       foregroundDecoration: TableSpanDecoration(
90:         border: TableSpanBorder(
91:           leading: BorderSide(
92:               color: Theme.of(context).colorScheme.onPrimaryContainer),
93:           trailing: BorderSide(
94:               color: Theme.of(context).colorScheme.onPrimaryContainer),
95:         ),
96:       ),
97:     );
98:   }
99: }
````

## File: samples/crossword/lib/widgets/crossword_puzzle_app.dart
````dart
 1: // Copyright 2024 The Flutter Authors. All rights reserved.
 2: // Use of this source code is governed by a BSD-style license that can be
 3: // found in the LICENSE file.
 4: 
 5: import 'package:flutter/material.dart';
 6: import 'package:flutter_riverpod/flutter_riverpod.dart';
 7: 
 8: import '../providers.dart';
 9: import 'crossword_generator_widget.dart';
10: import 'crossword_puzzle_widget.dart';
11: import 'puzzle_completed_widget.dart';
12: 
13: class CrosswordPuzzleApp extends StatelessWidget {
14:   const CrosswordPuzzleApp({super.key});
15: 
16:   @override
17:   Widget build(BuildContext context) {
18:     return _EagerInitialization(
19:       child: Scaffold(
20:         appBar: AppBar(
21:           actions: [_CrosswordPuzzleAppMenu()],
22:           titleTextStyle: TextStyle(
23:             color: Theme.of(context).colorScheme.primary,
24:             fontSize: 16,
25:             fontWeight: FontWeight.bold,
26:           ),
27:           title: const Text('Crossword Puzzle'),
28:         ),
29:         body: SafeArea(
30:           child: Consumer(builder: (context, ref, _) {
31:             final workQueueAsync = ref.watch(workQueueProvider);
32:             final puzzleSolved =
33:                 ref.watch(puzzleProvider.select((puzzle) => puzzle.solved));
34: 
35:             return workQueueAsync.when(
36:               data: (workQueue) {
37:                 if (puzzleSolved) {
38:                   return const PuzzleCompletedWidget();
39:                 }
40:                 if (workQueue.isCompleted &&
41:                     workQueue.crossword.characters.isNotEmpty) {
42:                   return const CrosswordPuzzleWidget();
43:                 }
44:                 return const CrosswordGeneratorWidget();
45:               },
46:               loading: () => const Center(child: CircularProgressIndicator()),
47:               error: (error, stackTrace) => Center(child: Text('$error')),
48:             );
49:           }),
50:         ),
51:       ),
52:     );
53:   }
54: }
55: 
56: class _EagerInitialization extends ConsumerWidget {
57:   const _EagerInitialization({required this.child});
58:   final Widget child;
59: 
60:   @override
61:   Widget build(BuildContext context, WidgetRef ref) {
62:     ref.watch(wordListProvider);
63:     return child;
64:   }
65: }
66: 
67: class _CrosswordPuzzleAppMenu extends ConsumerWidget {
68:   @override
69:   Widget build(BuildContext context, WidgetRef ref) => MenuAnchor(
70:         menuChildren: [
71:           for (final entry in CrosswordSize.values)
72:             MenuItemButton(
73:               onPressed: () => ref.read(sizeProvider.notifier).setSize(entry),
74:               leadingIcon: entry == ref.watch(sizeProvider)
75:                   ? const Icon(Icons.radio_button_checked_outlined)
76:                   : const Icon(Icons.radio_button_unchecked_outlined),
77:               child: Text(entry.label),
78:             ),
79:         ],
80:         builder: (context, controller, child) => IconButton(
81:           onPressed: () => controller.open(),
82:           icon: const Icon(Icons.settings),
83:         ),
84:       );
85: }
````

## File: samples/crossword/lib/widgets/crossword_puzzle_widget.dart
````dart
  1: // Copyright 2024 The Flutter Authors. All rights reserved.
  2: // Use of this source code is governed by a BSD-style license that can be
  3: // found in the LICENSE file.
  4: 
  5: import 'package:built_collection/built_collection.dart';
  6: import 'package:flutter/material.dart';
  7: import 'package:flutter_riverpod/flutter_riverpod.dart';
  8: import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';
  9: 
 10: import '../model.dart';
 11: import '../providers.dart';
 12: 
 13: class CrosswordPuzzleWidget extends ConsumerWidget {
 14:   const CrosswordPuzzleWidget({super.key});
 15: 
 16:   @override
 17:   Widget build(BuildContext context, WidgetRef ref) {
 18:     final size = ref.watch(sizeProvider);
 19:     return TableView.builder(
 20:       diagonalDragBehavior: DiagonalDragBehavior.free,
 21:       cellBuilder: _buildCell,
 22:       columnCount: size.width,
 23:       columnBuilder: (index) => _buildSpan(context, index),
 24:       rowCount: size.height,
 25:       rowBuilder: (index) => _buildSpan(context, index),
 26:     );
 27:   }
 28: 
 29:   TableViewCell _buildCell(BuildContext context, TableVicinity vicinity) {
 30:     final location = Location.at(vicinity.column, vicinity.row);
 31: 
 32:     return TableViewCell(
 33:       child: Consumer(
 34:         builder: (context, ref, _) {
 35:           final character = ref.watch(puzzleProvider
 36:               .select((puzzle) => puzzle.crossword.characters[location]));
 37:           final selectedCharacter = ref.watch(puzzleProvider.select((puzzle) =>
 38:               puzzle.crosswordFromSelectedWords.characters[location]));
 39:           final alternateWords = ref
 40:               .watch(puzzleProvider.select((puzzle) => puzzle.alternateWords));
 41: 
 42:           if (character != null) {
 43:             final acrossWord = character.acrossWord;
 44:             var acrossWords = BuiltList<String>();
 45:             if (acrossWord != null) {
 46:               acrossWords = acrossWords.rebuild((b) => b
 47:                 ..add(acrossWord.word)
 48:                 ..addAll(alternateWords[acrossWord.location]
 49:                         ?[acrossWord.direction] ??
 50:                     [])
 51:                 ..sort());
 52:             }
 53: 
 54:             final downWord = character.downWord;
 55:             var downWords = BuiltList<String>();
 56:             if (downWord != null) {
 57:               downWords = downWords.rebuild((b) => b
 58:                 ..add(downWord.word)
 59:                 ..addAll(alternateWords[downWord.location]
 60:                         ?[downWord.direction] ??
 61:                     [])
 62:                 ..sort());
 63:             }
 64: 
 65:             return MenuAnchor(
 66:               builder: (context, controller, _) {
 67:                 return GestureDetector(
 68:                   onTapDown: (details) =>
 69:                       controller.open(position: details.localPosition),
 70:                   child: AnimatedContainer(
 71:                     duration: Durations.extralong1,
 72:                     curve: Curves.easeInOut,
 73:                     color: Theme.of(context).colorScheme.onPrimary,
 74:                     child: Center(
 75:                       child: AnimatedDefaultTextStyle(
 76:                         duration: Durations.extralong1,
 77:                         curve: Curves.easeInOut,
 78:                         style: TextStyle(
 79:                           fontSize: 24,
 80:                           color: Theme.of(context).colorScheme.primary,
 81:                         ),
 82:                         child: Text(selectedCharacter?.character ?? ''),
 83:                       ),
 84:                     ),
 85:                   ),
 86:                 );
 87:               },
 88:               menuChildren: [
 89:                 if (acrossWords.isNotEmpty && downWords.isNotEmpty)
 90:                   const Padding(
 91:                     padding: EdgeInsets.all(4),
 92:                     child: Text('Across'),
 93:                   ),
 94:                 for (final word in acrossWords)
 95:                   _WordSelectMenuItem(
 96:                     location: acrossWord!.location,
 97:                     word: word,
 98:                     selectedCharacter: selectedCharacter,
 99:                     direction: Direction.across,
100:                   ),
101:                 if (acrossWords.isNotEmpty && downWords.isNotEmpty)
102:                   const Padding(
103:                     padding: EdgeInsets.all(4),
104:                     child: Text('Down'),
105:                   ),
106:                 for (final word in downWords)
107:                   _WordSelectMenuItem(
108:                     location: downWord!.location,
109:                     word: word,
110:                     selectedCharacter: selectedCharacter,
111:                     direction: Direction.down,
112:                   ),
113:               ],
114:             );
115:           }
116: 
117:           return ColoredBox(
118:             color: Theme.of(context).colorScheme.primaryContainer,
119:           );
120:         },
121:       ),
122:     );
123:   }
124: 
125:   TableSpan _buildSpan(BuildContext context, int index) {
126:     return TableSpan(
127:       extent: const FixedTableSpanExtent(32),
128:       foregroundDecoration: TableSpanDecoration(
129:         border: TableSpanBorder(
130:           leading: BorderSide(
131:               color: Theme.of(context).colorScheme.onPrimaryContainer),
132:           trailing: BorderSide(
133:               color: Theme.of(context).colorScheme.onPrimaryContainer),
134:         ),
135:       ),
136:     );
137:   }
138: }
139: 
140: class _WordSelectMenuItem extends ConsumerWidget {
141:   const _WordSelectMenuItem({
142:     required this.location,
143:     required this.word,
144:     required this.selectedCharacter,
145:     required this.direction,
146:   });
147: 
148:   final Location location;
149:   final String word;
150:   final CrosswordCharacter? selectedCharacter;
151:   final Direction direction;
152: 
153:   @override
154:   Widget build(BuildContext context, WidgetRef ref) {
155:     final notifier = ref.read(puzzleProvider.notifier);
156:     return MenuItemButton(
157:       onPressed: ref.watch(puzzleProvider.select((puzzle) =>
158:               puzzle.canSelectWord(
159:                   location: location, word: word, direction: direction)))
160:           ? () => notifier.selectWord(
161:               location: location, word: word, direction: direction)
162:           : null,
163:       leadingIcon: switch (direction) {
164:         Direction.across => selectedCharacter?.acrossWord?.word == word,
165:         Direction.down => selectedCharacter?.downWord?.word == word,
166:       }
167:           ? const Icon(Icons.radio_button_checked_outlined)
168:           : const Icon(Icons.radio_button_unchecked_outlined),
169:       child: Text(word),
170:     );
171:   }
172: }
````

## File: samples/crossword/lib/widgets/puzzle_completed_widget.dart
````dart
 1: // Copyright 2024 The Flutter Authors. All rights reserved.
 2: // Use of this source code is governed by a BSD-style license that can be
 3: // found in the LICENSE file.
 4: 
 5: import 'package:flutter/material.dart';
 6: 
 7: class PuzzleCompletedWidget extends StatelessWidget {
 8:   const PuzzleCompletedWidget({super.key});
 9: 
10:   @override
11:   Widget build(BuildContext context) {
12:     return const Center(
13:       child: Text(
14:         'Puzzle Completed!',
15:         style: TextStyle(
16:           fontSize: 36,
17:           fontWeight: FontWeight.bold,
18:         ),
19:       ),
20:     );
21:   }
22: }
````

## File: samples/crossword/lib/isolates.dart
````dart
  1: // Copyright 2024 The Flutter Authors. All rights reserved.
  2: // Use of this source code is governed by a BSD-style license that can be
  3: // found in the LICENSE file.
  4: 
  5: import 'package:built_collection/built_collection.dart';
  6: import 'package:characters/characters.dart';
  7: import 'package:flutter/foundation.dart';
  8: 
  9: import 'model.dart';
 10: import 'utils.dart';
 11: 
 12: Stream<WorkQueue> exploreCrosswordSolutions({
 13:   required Crossword crossword,
 14:   required BuiltSet<String> wordList,
 15:   required int maxWorkerCount,
 16: }) async* {
 17:   final start = DateTime.now();
 18:   var workQueue = WorkQueue.from(
 19:     crossword: crossword,
 20:     candidateWords: wordList,
 21:     startLocation: Location.at(0, 0),
 22:   );
 23:   while (!workQueue.isCompleted) {
 24:     try {
 25:       workQueue = await compute(_generate, (workQueue, maxWorkerCount));
 26:       yield workQueue;
 27:     } catch (e) {
 28:       debugPrint('Error running isolate: $e');
 29:     }
 30:   }
 31: 
 32:   debugPrint('Generated ${workQueue.crossword.width} x '
 33:       '${workQueue.crossword.height} crossword in '
 34:       '${DateTime.now().difference(start).formatted} '
 35:       'with $maxWorkerCount workers.');
 36: }
 37: 
 38: Future<WorkQueue> _generate((WorkQueue, int) workMessage) async {
 39:   var (workQueue, maxWorkerCount) = workMessage;
 40:   final candidateGeneratorFutures = <Future<(Location, Direction, String?)>>[];
 41:   final locations = workQueue.locationsToTry.keys.toBuiltList().rebuild((b) => b
 42:     ..shuffle()
 43:     ..take(maxWorkerCount));
 44: 
 45:   for (final location in locations) {
 46:     final direction = workQueue.locationsToTry[location]!;
 47: 
 48:     candidateGeneratorFutures.add(compute(_generateCandidate,
 49:         (workQueue.crossword, workQueue.candidateWords, location, direction)));
 50:   }
 51: 
 52:   try {
 53:     final results = await candidateGeneratorFutures.wait;
 54:     var crossword = workQueue.crossword;
 55:     for (final (location, direction, word) in results) {
 56:       if (word != null) {
 57:         final candidate = crossword.addWord(
 58:             location: location, word: word, direction: direction);
 59:         if (candidate != null) {
 60:           crossword = candidate;
 61:         }
 62:       } else {
 63:         workQueue = workQueue.remove(location);
 64:       }
 65:     }
 66: 
 67:     workQueue = workQueue.updateFrom(crossword);
 68:   } catch (e) {
 69:     debugPrint('$e');
 70:   }
 71: 
 72:   return workQueue;
 73: }
 74: 
 75: (Location, Direction, String?) _generateCandidate(
 76:     (Crossword, BuiltSet<String>, Location, Direction) searchDetailMessage) {
 77:   final (crossword, candidateWords, location, direction) = searchDetailMessage;
 78: 
 79:   final target = crossword.characters[location];
 80:   if (target == null) {
 81:     return (location, direction, candidateWords.randomElement());
 82:   }
 83: 
 84:   // Filter down the candidate word list to those that contain the letter
 85:   // at the current location
 86:   final words = candidateWords.toBuiltList().rebuild((b) => b
 87:     ..where((b) => b.characters.contains(target.character))
 88:     ..shuffle());
 89:   int tryCount = 0;
 90:   final start = DateTime.now();
 91:   for (final word in words) {
 92:     tryCount++;
 93:     for (final (index, character) in word.characters.indexed) {
 94:       if (character != target.character) continue;
 95: 
 96:       final candidate = crossword.addWord(
 97:         location: switch (direction) {
 98:           Direction.across => location.leftOffset(index),
 99:           Direction.down => location.upOffset(index),
100:         },
101:         word: word,
102:         direction: direction,
103:       );
104:       if (candidate != null) {
105:         return switch (direction) {
106:           Direction.across => (location.leftOffset(index), direction, word),
107:           Direction.down => (location.upOffset(index), direction, word),
108:         };
109:       }
110:       final deltaTime = DateTime.now().difference(start);
111:       if (tryCount >= 1000 || deltaTime > const Duration(seconds: 10)) {
112:         return (location, direction, null);
113:       }
114:     }
115:   }
116: 
117:   return (location, direction, null);
118: }
````

## File: samples/crossword/lib/main.dart
````dart
 1: // Copyright 2024 The Flutter Authors. All rights reserved.
 2: // Use of this source code is governed by a BSD-style license that can be
 3: // found in the LICENSE file.
 4: 
 5: import 'package:flutter/material.dart';
 6: import 'package:flutter_riverpod/flutter_riverpod.dart';
 7: 
 8: import 'widgets/crossword_puzzle_app.dart';
 9: 
10: void main() {
11:   runApp(
12:     ProviderScope(
13:       child: MaterialApp(
14:         title: 'Crossword Puzzle',
15:         debugShowCheckedModeBanner: false,
16:         theme: ThemeData(
17:           useMaterial3: true,
18:           colorSchemeSeed: Colors.blueGrey,
19:           brightness: Brightness.light,
20:         ),
21:         home: const CrosswordPuzzleApp(),
22:       ),
23:     ),
24:   );
25: }
````

## File: samples/crossword/lib/model.dart
````dart
  1: // Copyright 2024 The Flutter Authors. All rights reserved.
  2: // Use of this source code is governed by a BSD-style license that can be
  3: // found in the LICENSE file.
  4: 
  5: import 'package:built_collection/built_collection.dart';
  6: import 'package:built_value/built_value.dart';
  7: import 'package:built_value/serializer.dart';
  8: import 'package:characters/characters.dart';
  9: import 'package:intl/intl.dart';
 10: 
 11: part 'model.g.dart';
 12: 
 13: /// A location in a crossword.
 14: abstract class Location implements Built<Location, LocationBuilder> {
 15:   static Serializer<Location> get serializer => _$locationSerializer;
 16: 
 17:   /// The horizontal part of the location. The location is 0 based.
 18:   int get x;
 19: 
 20:   /// The vertical part of the location. The location is 0 based.
 21:   int get y;
 22: 
 23:   /// Returns a new location that is one step to the left of this location.
 24:   Location get left => rebuild((b) => b.x = x - 1);
 25: 
 26:   /// Returns a new location that is one step to the right of this location.
 27:   Location get right => rebuild((b) => b.x = x + 1);
 28: 
 29:   /// Returns a new location that is one step up from this location.
 30:   Location get up => rebuild((b) => b.y = y - 1);
 31: 
 32:   /// Returns a new location that is one step down from this location.
 33:   Location get down => rebuild((b) => b.y = y + 1);
 34: 
 35:   /// Returns a new location that is [offset] steps to the left of this location.
 36:   Location leftOffset(int offset) => rebuild((b) => b.x = x - offset);
 37: 
 38:   /// Returns a new location that is [offset] steps to the right of this location.
 39:   Location rightOffset(int offset) => rebuild((b) => b.x = x + offset);
 40: 
 41:   /// Returns a new location that is [offset] steps up from this location.
 42:   Location upOffset(int offset) => rebuild((b) => b.y = y - offset);
 43: 
 44:   /// Returns a new location that is [offset] steps down from this location.
 45:   Location downOffset(int offset) => rebuild((b) => b.y = y + offset);
 46: 
 47:   /// Pretty print a location as a (x,y) coordinate.
 48:   String prettyPrint() => '($x,$y)';
 49: 
 50:   /// Returns a new location built from [updates]. Both [x] and [y] are
 51:   /// required to be non-null.
 52:   factory Location([void Function(LocationBuilder)? updates]) = _$Location;
 53:   Location._();
 54: 
 55:   /// Returns a location at the given coordinates.
 56:   factory Location.at(int x, int y) {
 57:     return Location((b) {
 58:       b
 59:         ..x = x
 60:         ..y = y;
 61:     });
 62:   }
 63: }
 64: 
 65: /// The direction of a word in a crossword.
 66: enum Direction {
 67:   across,
 68:   down;
 69: 
 70:   @override
 71:   String toString() => name;
 72: }
 73: 
 74: /// A word in a crossword. This is a word at a location in a crossword, in either
 75: /// the across or down direction.
 76: abstract class CrosswordWord
 77:     implements Built<CrosswordWord, CrosswordWordBuilder> {
 78:   static Serializer<CrosswordWord> get serializer => _$crosswordWordSerializer;
 79: 
 80:   /// The word itself.
 81:   String get word;
 82: 
 83:   /// The location of this word in the crossword.
 84:   Location get location;
 85: 
 86:   /// The direction of this word in the crossword.
 87:   Direction get direction;
 88: 
 89:   /// Compare two CrosswordWord by coordinates, x then y.
 90:   static int locationComparator(CrosswordWord a, CrosswordWord b) {
 91:     final compareRows = a.location.y.compareTo(b.location.y);
 92:     final compareColumns = a.location.x.compareTo(b.location.x);
 93:     return switch (compareColumns) {
 94:       0 => compareRows,
 95:       _ => compareColumns,
 96:     };
 97:   }
 98: 
 99:   /// Constructor for [CrosswordWord].
100:   factory CrosswordWord.word({
101:     required String word,
102:     required Location location,
103:     required Direction direction,
104:   }) {
105:     return CrosswordWord((b) => b
106:       ..word = word
107:       ..direction = direction
108:       ..location.replace(location));
109:   }
110: 
111:   /// Constructor for [CrosswordWord].
112:   /// Use [CrosswordWord.word] instead.
113:   factory CrosswordWord([void Function(CrosswordWordBuilder)? updates]) =
114:       _$CrosswordWord;
115:   CrosswordWord._();
116: }
117: 
118: /// A character in a crossword. This is a single character at a location in a
119: /// crossword. It may be part of an across word, a down word, both, but not
120: /// neither. The neither constraint is enforced elsewhere.
121: abstract class CrosswordCharacter
122:     implements Built<CrosswordCharacter, CrosswordCharacterBuilder> {
123:   static Serializer<CrosswordCharacter> get serializer =>
124:       _$crosswordCharacterSerializer;
125: 
126:   /// The character at this location.
127:   String get character;
128: 
129:   /// The across word that this character is a part of.
130:   CrosswordWord? get acrossWord;
131: 
132:   /// The down word that this character is a part of.
133:   CrosswordWord? get downWord;
134: 
135:   /// Constructor for [CrosswordCharacter].
136:   /// [acrossWord] and [downWord] are optional.
137:   factory CrosswordCharacter.character({
138:     required String character,
139:     CrosswordWord? acrossWord,
140:     CrosswordWord? downWord,
141:   }) {
142:     return CrosswordCharacter((b) {
143:       b.character = character;
144:       if (acrossWord != null) {
145:         b.acrossWord.replace(acrossWord);
146:       }
147:       if (downWord != null) {
148:         b.downWord.replace(downWord);
149:       }
150:     });
151:   }
152: 
153:   /// Constructor for [CrosswordCharacter].
154:   /// Use [CrosswordCharacter.character] instead.
155:   factory CrosswordCharacter(
156:           [void Function(CrosswordCharacterBuilder)? updates]) =
157:       _$CrosswordCharacter;
158:   CrosswordCharacter._();
159: }
160: 
161: /// A crossword puzzle. This is a grid of characters with words placed in it.
162: /// The puzzle constraint is in the English crossword puzzle tradition.
163: abstract class Crossword implements Built<Crossword, CrosswordBuilder> {
164:   /// Serializes and deserializes the [Crossword] class.
165:   static Serializer<Crossword> get serializer => _$crosswordSerializer;
166: 
167:   /// Width across the [Crossword] puzzle.
168:   int get width;
169: 
170:   /// Height down the [Crossword] puzzle.
171:   int get height;
172: 
173:   /// The words in the crossword.
174:   BuiltList<CrosswordWord> get words;
175: 
176:   /// The characters by location. Useful for displaying the crossword,
177:   /// or checking the proposed solution.
178:   BuiltMap<Location, CrosswordCharacter> get characters;
179: 
180:   /// Checks if this crossword is valid.
181:   bool get valid {
182:     // Check that there are no duplicate words.
183:     final wordSet = words.map((word) => word.word).toBuiltSet();
184:     if (wordSet.length != words.length) {
185:       return false;
186:     }
187: 
188:     for (final MapEntry(key: location, value: character)
189:         in characters.entries) {
190:       // All characters must be a part of an across or down word.
191:       if (character.acrossWord == null && character.downWord == null) {
192:         return false;
193:       }
194: 
195:       // All characters must be within the crossword puzzle.
196:       // No drawing outside the lines.
197:       if (location.x < 0 ||
198:           location.y < 0 ||
199:           location.x >= width ||
200:           location.y >= height) {
201:         return false;
202:       }
203: 
204:       // Characters above and below this character must be related
205:       // by a vertical word
206:       if (characters[location.up] case final up?) {
207:         if (character.downWord == null) {
208:           return false;
209:         }
210:         if (up.downWord != character.downWord) {
211:           return false;
212:         }
213:       }
214: 
215:       if (characters[location.down] case final down?) {
216:         if (character.downWord == null) {
217:           return false;
218:         }
219:         if (down.downWord != character.downWord) {
220:           return false;
221:         }
222:       }
223: 
224:       // Characters to the left and right of this character must be
225:       // related by a horizontal word
226:       final left = characters[location.left];
227:       if (left != null) {
228:         if (character.acrossWord == null) {
229:           return false;
230:         }
231:         if (left.acrossWord != character.acrossWord) {
232:           return false;
233:         }
234:       }
235: 
236:       final right = characters[location.right];
237:       if (right != null) {
238:         if (character.acrossWord == null) {
239:           return false;
240:         }
241:         if (right.acrossWord != character.acrossWord) {
242:           return false;
243:         }
244:       }
245:     }
246: 
247:     return true;
248:   }
249: 
250:   /// Add a word to the crossword at the given location and direction.
251:   Crossword? addWord({
252:     required Location location,
253:     required String word,
254:     required Direction direction,
255:     bool requireOverlap = true,
256:   }) {
257:     // Require that the word is not already in the crossword.
258:     if (words.map((crosswordWord) => crosswordWord.word).contains(word)) {
259:       return null;
260:     }
261: 
262:     final wordCharacters = word.characters;
263:     bool overlap = false;
264: 
265:     // Check that the word fits in the crossword.
266:     for (final (index, character) in wordCharacters.indexed) {
267:       final characterLocation = switch (direction) {
268:         Direction.across => location.rightOffset(index),
269:         Direction.down => location.downOffset(index),
270:       };
271: 
272:       final target = characters[characterLocation];
273:       if (target != null) {
274:         overlap = true;
275:         if (target.character != character) {
276:           return null;
277:         }
278:         if (direction == Direction.across && target.acrossWord != null ||
279:             direction == Direction.down && target.downWord != null) {
280:           return null;
281:         }
282:       }
283:     }
284: 
285:     // If overlap is required, make sure that the word overlaps with an existing
286:     // word. Skip this test if the crossword is empty.
287:     if (words.isNotEmpty && !overlap && requireOverlap) {
288:       return null;
289:     }
290: 
291:     final candidate = rebuild(
292:       (b) => b
293:         ..words.add(
294:           CrosswordWord.word(
295:             word: word,
296:             direction: direction,
297:             location: location,
298:           ),
299:         ),
300:     );
301: 
302:     if (candidate.valid) {
303:       return candidate;
304:     } else {
305:       return null;
306:     }
307:   }
308: 
309:   /// As a finalize step, fill in the characters map.
310:   @BuiltValueHook(finalizeBuilder: true)
311:   static void _fillCharacters(CrosswordBuilder b) {
312:     b.characters.clear();
313: 
314:     for (final word in b.words.build()) {
315:       for (final (idx, character) in word.word.characters.indexed) {
316:         switch (word.direction) {
317:           case Direction.across:
318:             b.characters.updateValue(
319:               word.location.rightOffset(idx),
320:               (b) => b.rebuild((bInner) => bInner.acrossWord.replace(word)),
321:               ifAbsent: () => CrosswordCharacter.character(
322:                 acrossWord: word,
323:                 character: character,
324:               ),
325:             );
326:           case Direction.down:
327:             b.characters.updateValue(
328:               word.location.downOffset(idx),
329:               (b) => b.rebuild((bInner) => bInner.downWord.replace(word)),
330:               ifAbsent: () => CrosswordCharacter.character(
331:                 downWord: word,
332:                 character: character,
333:               ),
334:             );
335:         }
336:       }
337:     }
338:   }
339: 
340:   /// Pretty print a crossword. Generates the character grid, and lists
341:   /// the down words and across words sorted by location.
342:   String prettyPrintCrossword() {
343:     final buffer = StringBuffer();
344:     final grid = List.generate(
345:       height,
346:       (_) => List.generate(
347:         width, (_) => '░', // https://www.compart.com/en/unicode/U+2591
348:       ),
349:     );
350: 
351:     for (final MapEntry(key: Location(:x, :y), value: character)
352:         in characters.entries) {
353:       grid[y][x] = character.character;
354:     }
355: 
356:     for (final row in grid) {
357:       buffer.writeln(row.join());
358:     }
359: 
360:     buffer.writeln();
361:     buffer.writeln('Across:');
362:     for (final word
363:         in words.where((word) => word.direction == Direction.across).toList()
364:           ..sort(CrosswordWord.locationComparator)) {
365:       buffer.writeln('${word.location.prettyPrint()}: ${word.word}');
366:     }
367: 
368:     buffer.writeln();
369:     buffer.writeln('Down:');
370:     for (final word
371:         in words.where((word) => word.direction == Direction.down).toList()
372:           ..sort(CrosswordWord.locationComparator)) {
373:       buffer.writeln('${word.location.prettyPrint()}: ${word.word}');
374:     }
375: 
376:     return buffer.toString();
377:   }
378: 
379:   /// Constructor for [Crossword].
380:   factory Crossword.crossword({
381:     required int width,
382:     required int height,
383:     Iterable<CrosswordWord>? words,
384:   }) {
385:     return Crossword((b) {
386:       b
387:         ..width = width
388:         ..height = height;
389:       if (words != null) {
390:         b.words.addAll(words);
391:       }
392:     });
393:   }
394: 
395:   /// Constructor for [Crossword].
396:   /// Use [Crossword.crossword] instead.
397:   factory Crossword([void Function(CrosswordBuilder)? updates]) = _$Crossword;
398:   Crossword._();
399: }
400: 
401: /// A work queue for a worker to process. The work queue contains a crossword
402: /// and a list of locations to try, along with candidate words to add to the
403: /// crossword.
404: abstract class WorkQueue implements Built<WorkQueue, WorkQueueBuilder> {
405:   static Serializer<WorkQueue> get serializer => _$workQueueSerializer;
406: 
407:   /// The crossword the worker is working on.
408:   Crossword get crossword;
409: 
410:   /// The outstanding queue of locations to try.
411:   BuiltMap<Location, Direction> get locationsToTry;
412: 
413:   /// Known bad locations.
414:   BuiltSet<Location> get badLocations;
415: 
416:   /// The list of unused candidate words that can be added to this crossword.
417:   BuiltSet<String> get candidateWords;
418: 
419:   /// Returns true if the work queue is complete.
420:   bool get isCompleted => locationsToTry.isEmpty || candidateWords.isEmpty;
421: 
422:   /// Create a work queue from a crossword.
423:   static WorkQueue from({
424:     required Crossword crossword,
425:     required Iterable<String> candidateWords,
426:     required Location startLocation,
427:   }) =>
428:       WorkQueue((b) {
429:         if (crossword.words.isEmpty) {
430:           // Strip candidate words too long to fit in the crossword
431:           b.candidateWords.addAll(candidateWords
432:               .where((word) => word.characters.length <= crossword.width));
433: 
434:           b.crossword.replace(crossword);
435: 
436:           b.locationsToTry.addAll({startLocation: Direction.across});
437:         } else {
438:           // Assuming words have already been stripped to length
439:           b.candidateWords.addAll(
440:             candidateWords.toBuiltSet().rebuild(
441:                 (b) => b.removeAll(crossword.words.map((word) => word.word))),
442:           );
443:           b.crossword.replace(crossword);
444:           crossword.characters
445:               .rebuild((b) => b.removeWhere((location, character) {
446:                     if (character.acrossWord != null &&
447:                         character.downWord != null) {
448:                       return true;
449:                     }
450:                     final left = crossword.characters[location.left];
451:                     if (left != null && left.downWord != null) return true;
452:                     final right = crossword.characters[location.right];
453:                     if (right != null && right.downWord != null) return true;
454:                     final up = crossword.characters[location.up];
455:                     if (up != null && up.acrossWord != null) return true;
456:                     final down = crossword.characters[location.down];
457:                     if (down != null && down.acrossWord != null) return true;
458:                     return false;
459:                   }))
460:               .forEach((location, character) {
461:             b.locationsToTry.addAll({
462:               location: switch ((character.acrossWord, character.downWord)) {
463:                 (null, null) =>
464:                   throw StateError('Character is not part of a word'),
465:                 (null, _) => Direction.across,
466:                 (_, null) => Direction.down,
467:                 (_, _) => throw StateError('Character is part of two words'),
468:               }
469:             });
470:           });
471:         }
472:       });
473: 
474:   WorkQueue remove(Location location) => rebuild((b) => b
475:     ..locationsToTry.remove(location)
476:     ..badLocations.add(location));
477: 
478:   /// Update the work queue from a crossword derived from the current crossword
479:   /// that this work queue is built from.
480:   WorkQueue updateFrom(final Crossword crossword) => WorkQueue.from(
481:         crossword: crossword,
482:         candidateWords: candidateWords,
483:         startLocation: locationsToTry.isNotEmpty
484:             ? locationsToTry.keys.first
485:             : Location.at(0, 0),
486:       ).rebuild((b) => b
487:         ..badLocations.addAll(badLocations)
488:         ..locationsToTry
489:             .removeWhere((location, _) => badLocations.contains(location)));
490: 
491:   /// Factory constructor for [WorkQueue]
492:   factory WorkQueue([void Function(WorkQueueBuilder)? updates]) = _$WorkQueue;
493: 
494:   WorkQueue._();
495: }
496: 
497: /// Display information for the current state of the crossword solve.
498: abstract class DisplayInfo implements Built<DisplayInfo, DisplayInfoBuilder> {
499:   static Serializer<DisplayInfo> get serializer => _$displayInfoSerializer;
500: 
501:   /// The number of words in the grid.
502:   String get wordsInGridCount;
503: 
504:   /// The number of candidate words.
505:   String get candidateWordsCount;
506: 
507:   /// The number of locations to explore.
508:   String get locationsToExploreCount;
509: 
510:   /// The number of known bad locations.
511:   String get knownBadLocationsCount;
512: 
513:   /// The percentage of the grid filled.
514:   String get gridFilledPercentage;
515: 
516:   /// Construct a [DisplayInfo] instance from a [WorkQueue].
517:   factory DisplayInfo.from({required WorkQueue workQueue}) {
518:     final gridFilled = (workQueue.crossword.characters.length /
519:         (workQueue.crossword.width * workQueue.crossword.height));
520:     final fmt = NumberFormat.decimalPattern();
521: 
522:     return DisplayInfo((b) => b
523:       ..wordsInGridCount = fmt.format(workQueue.crossword.words.length)
524:       ..candidateWordsCount = fmt.format(workQueue.candidateWords.length)
525:       ..locationsToExploreCount = fmt.format(workQueue.locationsToTry.length)
526:       ..knownBadLocationsCount = fmt.format(workQueue.badLocations.length)
527:       ..gridFilledPercentage = '${(gridFilled * 100).toStringAsFixed(2)}%');
528:   }
529: 
530:   /// An empty [DisplayInfo] instance.
531:   static DisplayInfo get empty => DisplayInfo((b) => b
532:     ..wordsInGridCount = '0'
533:     ..candidateWordsCount = '0'
534:     ..locationsToExploreCount = '0'
535:     ..knownBadLocationsCount = '0'
536:     ..gridFilledPercentage = '0%');
537: 
538:   factory DisplayInfo([void Function(DisplayInfoBuilder)? updates]) =
539:       _$DisplayInfo;
540:   DisplayInfo._();
541: }
542: 
543: /// Creates a puzzle from a crossword and a set of candidate words.
544: abstract class CrosswordPuzzleGame
545:     implements Built<CrosswordPuzzleGame, CrosswordPuzzleGameBuilder> {
546:   static Serializer<CrosswordPuzzleGame> get serializer =>
547:       _$crosswordPuzzleGameSerializer;
548: 
549:   /// The [Crossword] that this puzzle is based on.
550:   Crossword get crossword;
551: 
552:   /// The alternate words for each [CrosswordWord] in the crossword.
553:   BuiltMap<Location, BuiltMap<Direction, BuiltList<String>>> get alternateWords;
554: 
555:   /// The player's selected words.
556:   BuiltList<CrosswordWord> get selectedWords;
557: 
558:   bool canSelectWord({
559:     required Location location,
560:     required String word,
561:     required Direction direction,
562:   }) {
563:     final crosswordWord = CrosswordWord.word(
564:       word: word,
565:       location: location,
566:       direction: direction,
567:     );
568: 
569:     if (selectedWords.contains(crosswordWord)) {
570:       return true;
571:     }
572: 
573:     var puzzle = this;
574: 
575:     if (puzzle.selectedWords
576:         .where((b) => b.direction == direction && b.location == location)
577:         .isNotEmpty) {
578:       puzzle = puzzle.rebuild((b) => b
579:         ..selectedWords.removeWhere(
580:           (selectedWord) =>
581:               selectedWord.location == location &&
582:               selectedWord.direction == direction,
583:         ));
584:     }
585: 
586:     return null !=
587:         puzzle.crosswordFromSelectedWords.addWord(
588:             location: location,
589:             word: word,
590:             direction: direction,
591:             requireOverlap: false);
592:   }
593: 
594:   CrosswordPuzzleGame? selectWord({
595:     required Location location,
596:     required String word,
597:     required Direction direction,
598:   }) {
599:     final crosswordWord = CrosswordWord.word(
600:       word: word,
601:       location: location,
602:       direction: direction,
603:     );
604: 
605:     if (selectedWords.contains(crosswordWord)) {
606:       return rebuild((b) => b.selectedWords.remove(crosswordWord));
607:     }
608: 
609:     var puzzle = this;
610: 
611:     if (puzzle.selectedWords
612:         .where((b) => b.direction == direction && b.location == location)
613:         .isNotEmpty) {
614:       puzzle = puzzle.rebuild((b) => b
615:         ..selectedWords.removeWhere(
616:           (selectedWord) =>
617:               selectedWord.location == location &&
618:               selectedWord.direction == direction,
619:         ));
620:     }
621: 
622:     // Check if the selected word meshes with the already selected words.
623:     // Note this version of the crossword does not enforce overlap to
624:     // allow the player to select words anywhere on the grid. Enforcing words
625:     // to be solved in order is a possible alternative.
626:     final updatedSelectedWordsCrossword =
627:         puzzle.crosswordFromSelectedWords.addWord(
628:       location: location,
629:       word: word,
630:       direction: direction,
631:       requireOverlap: false,
632:     );
633: 
634:     // Make sure the selected word is in the crossword or is an alternate word.
635:     if (updatedSelectedWordsCrossword != null) {
636:       if (puzzle.crossword.words.contains(crosswordWord) ||
637:           puzzle.alternateWords[location]?[direction]?.contains(word) == true) {
638:         return puzzle.rebuild((b) => b
639:           ..selectedWords.add(CrosswordWord.word(
640:               word: word, location: location, direction: direction)));
641:       }
642:     }
643:     return null;
644:   }
645: 
646:   /// The crossword from the selected words.
647:   Crossword get crosswordFromSelectedWords => Crossword.crossword(
648:       width: crossword.width, height: crossword.height, words: selectedWords);
649: 
650:   /// Test if the puzzle is solved. Note, this allows for the possibility of
651:   /// multiple solutions.
652:   bool get solved =>
653:       crosswordFromSelectedWords.valid &&
654:       crosswordFromSelectedWords.words.length == crossword.words.length &&
655:       crossword.words.isNotEmpty;
656: 
657:   /// Create a crossword puzzle game from a crossword and a set of candidate
658:   /// words.
659:   factory CrosswordPuzzleGame.from({
660:     required Crossword crossword,
661:     required BuiltSet<String> candidateWords,
662:   }) {
663:     // Remove all of the currently used words from the list of candidates
664:     candidateWords = candidateWords
665:         .rebuild((p0) => p0.removeAll(crossword.words.map((p1) => p1.word)));
666: 
667:     // This is the list of alternate words for each word in the crossword
668:     var alternates =
669:         BuiltMap<Location, BuiltMap<Direction, BuiltList<String>>>();
670: 
671:     // Build the alternate words for each word in the crossword
672:     for (final crosswordWord in crossword.words) {
673:       final alternateWords = candidateWords.toBuiltList().rebuild((b) => b
674:         ..where((b) => b.length == crosswordWord.word.length)
675:         ..shuffle()
676:         ..take(4)
677:         ..sort());
678: 
679:       candidateWords =
680:           candidateWords.rebuild((b) => b.removeAll(alternateWords));
681: 
682:       alternates = alternates.rebuild(
683:         (b) => b.updateValue(
684:           crosswordWord.location,
685:           (b) => b.rebuild(
686:             (b) => b.updateValue(
687:               crosswordWord.direction,
688:               (b) => b.rebuild((b) => b.replace(alternateWords)),
689:               ifAbsent: () => alternateWords,
690:             ),
691:           ),
692:           ifAbsent: () => {crosswordWord.direction: alternateWords}.build(),
693:         ),
694:       );
695:     }
696: 
697:     return CrosswordPuzzleGame((b) {
698:       b
699:         ..crossword.replace(crossword)
700:         ..alternateWords.replace(alternates);
701:     });
702:   }
703: 
704:   factory CrosswordPuzzleGame(
705:           [void Function(CrosswordPuzzleGameBuilder)? updates]) =
706:       _$CrosswordPuzzleGame;
707:   CrosswordPuzzleGame._();
708: }
709: 
710: /// Construct the serialization/deserialization code for the data model.
711: @SerializersFor([
712:   Location,
713:   Crossword,
714:   CrosswordWord,
715:   CrosswordCharacter,
716:   WorkQueue,
717:   DisplayInfo,
718:   CrosswordPuzzleGame,
719: ])
720: final Serializers serializers = _$serializers;
````

## File: samples/crossword/lib/providers.dart
````dart
  1: // Copyright 2024 The Flutter Authors. All rights reserved.
  2: // Use of this source code is governed by a BSD-style license that can be
  3: // found in the LICENSE file.
  4: 
  5: import 'dart:convert';
  6: 
  7: import 'package:built_collection/built_collection.dart';
  8: import 'package:flutter/foundation.dart';
  9: import 'package:flutter/services.dart';
 10: import 'package:riverpod/riverpod.dart';
 11: import 'package:riverpod_annotation/riverpod_annotation.dart';
 12: 
 13: import 'isolates.dart';
 14: import 'model.dart' as model;
 15: 
 16: part 'providers.g.dart';
 17: 
 18: const backgroundWorkerCount = 4;
 19: 
 20: /// A provider for the wordlist to use when generating the crossword.
 21: @riverpod
 22: Future<BuiltSet<String>> wordList(Ref ref) async {
 23:   // This codebase requires that all words consist of lowercase characters
 24:   // in the range 'a'-'z'. Words containing uppercase letters will be
 25:   // lowercased, and words containing runes outside this range will
 26:   // be removed.
 27: 
 28:   final re = RegExp(r'^[a-z]+$');
 29:   final words = await rootBundle.loadString('assets/words.txt');
 30:   return const LineSplitter().convert(words).toBuiltSet().rebuild((b) => b
 31:     ..map((word) => word.toLowerCase().trim())
 32:     ..where((word) => word.length > 2)
 33:     ..where((word) => re.hasMatch(word)));
 34: }
 35: 
 36: /// An enumeration for different sizes of [model.Crossword]s.
 37: enum CrosswordSize {
 38:   small(width: 20, height: 11),
 39:   medium(width: 40, height: 22),
 40:   large(width: 80, height: 44),
 41:   xlarge(width: 160, height: 88),
 42:   xxlarge(width: 500, height: 500);
 43: 
 44:   const CrosswordSize({
 45:     required this.width,
 46:     required this.height,
 47:   });
 48: 
 49:   final int width;
 50:   final int height;
 51:   String get label => '$width x $height';
 52: }
 53: 
 54: /// A provider that holds the current size of the crossword to generate.
 55: @Riverpod(keepAlive: true)
 56: class Size extends _$Size {
 57:   var _size = CrosswordSize.medium;
 58: 
 59:   @override
 60:   CrosswordSize build() => _size;
 61: 
 62:   void setSize(CrosswordSize size) {
 63:     _size = size;
 64:     ref.invalidateSelf();
 65:   }
 66: }
 67: 
 68: @riverpod
 69: Stream<model.WorkQueue> workQueue(Ref ref) async* {
 70:   final size = ref.watch(sizeProvider);
 71:   final wordListAsync = ref.watch(wordListProvider);
 72:   final emptyCrossword =
 73:       model.Crossword.crossword(width: size.width, height: size.height);
 74:   final emptyWorkQueue = model.WorkQueue.from(
 75:     crossword: emptyCrossword,
 76:     candidateWords: BuiltSet<String>(),
 77:     startLocation: model.Location.at(0, 0),
 78:   );
 79: 
 80:   yield* wordListAsync.when(
 81:     data: (wordList) => exploreCrosswordSolutions(
 82:       crossword: emptyCrossword,
 83:       wordList: wordList,
 84:       maxWorkerCount: backgroundWorkerCount,
 85:     ),
 86:     error: (error, stackTrace) async* {
 87:       debugPrint('Error loading word list: $error');
 88:       yield emptyWorkQueue;
 89:     },
 90:     loading: () async* {
 91:       yield emptyWorkQueue;
 92:     },
 93:   );
 94: }
 95: 
 96: @riverpod
 97: class Puzzle extends _$Puzzle {
 98:   model.CrosswordPuzzleGame _puzzle = model.CrosswordPuzzleGame.from(
 99:     crossword: model.Crossword.crossword(width: 0, height: 0),
100:     candidateWords: BuiltSet<String>(),
101:   );
102: 
103:   @override
104:   model.CrosswordPuzzleGame build() {
105:     final size = ref.watch(sizeProvider);
106:     final wordList = ref.watch(wordListProvider).value;
107:     final workQueue = ref.watch(workQueueProvider).value;
108: 
109:     if (wordList != null &&
110:         workQueue != null &&
111:         workQueue.isCompleted &&
112:         (_puzzle.crossword.height != size.height ||
113:             _puzzle.crossword.width != size.width ||
114:             _puzzle.crossword != workQueue.crossword)) {
115:       compute(_puzzleFromCrosswordTrampoline, (workQueue.crossword, wordList))
116:           .then((puzzle) {
117:         _puzzle = puzzle;
118:         ref.invalidateSelf();
119:       });
120:     }
121: 
122:     return _puzzle;
123:   }
124: 
125:   Future<void> selectWord({
126:     required model.Location location,
127:     required String word,
128:     required model.Direction direction,
129:   }) async {
130:     final candidate = await compute(
131:         _puzzleSelectWordTrampoline, (_puzzle, location, word, direction));
132: 
133:     if (candidate != null) {
134:       _puzzle = candidate;
135:       ref.invalidateSelf();
136:     } else {
137:       debugPrint('Invalid word selection: $word');
138:     }
139:   }
140: 
141:   bool canSelectWord({
142:     required model.Location location,
143:     required String word,
144:     required model.Direction direction,
145:   }) {
146:     return _puzzle.canSelectWord(
147:       location: location,
148:       word: word,
149:       direction: direction,
150:     );
151:   }
152: }
153: 
154: // Trampoline functions to disentangle these Isolate target calls from the
155: // unsendable reference to the [Puzzle] provider.
156: 
157: Future<model.CrosswordPuzzleGame> _puzzleFromCrosswordTrampoline(
158:         (model.Crossword, BuiltSet<String>) args) async =>
159:     model.CrosswordPuzzleGame.from(crossword: args.$1, candidateWords: args.$2);
160: 
161: model.CrosswordPuzzleGame? _puzzleSelectWordTrampoline(
162:         (
163:           model.CrosswordPuzzleGame,
164:           model.Location,
165:           String,
166:           model.Direction
167:         ) args) =>
168:     args.$1.selectWord(location: args.$2, word: args.$3, direction: args.$4);
````

## File: samples/crossword/lib/utils.dart
````dart
 1: // Copyright 2024 The Flutter Authors. All rights reserved.
 2: // Use of this source code is governed by a BSD-style license that can be
 3: // found in the LICENSE file.
 4: 
 5: import 'dart:math';
 6: 
 7: import 'package:built_collection/built_collection.dart';
 8: 
 9: /// A [Random] instance for generating random numbers.
10: final _random = Random();
11: 
12: /// An extension on [BuiltSet] that adds a method to get a random element.
13: extension RandomElements<E> on BuiltSet<E> {
14:   E randomElement() {
15:     return elementAt(_random.nextInt(length));
16:   }
17: }
18: 
19: /// An extension on [Duration] that adds a method to format the duration.
20: extension DurationFormat on Duration {
21:   /// A human-readable string representation of the duration.
22:   /// This format is tuned for durations in the seconds to days range.
23:   String get formatted {
24:     final hours = inHours.remainder(24).toString().padLeft(2, '0');
25:     final minutes = inMinutes.remainder(60).toString().padLeft(2, '0');
26:     final seconds = inSeconds.remainder(60).toString().padLeft(2, '0');
27:     return switch ((inDays, inHours, inMinutes, inSeconds)) {
28:       (0, 0, 0, _) => '${inSeconds}s',
29:       (0, 0, _, _) => '$inMinutes:$seconds',
30:       (0, _, _, _) => '$inHours:$minutes:$seconds',
31:       _ => '$inDays days, $hours:$minutes:$seconds',
32:     };
33:   }
34: }
````

## File: samples/crossword/test/model_test.dart
````dart
  1: // Copyright 2024 The Flutter Authors. All rights reserved.
  2: // Use of this source code is governed by a BSD-style license that can be
  3: // found in the LICENSE file.
  4: 
  5: import 'package:built_collection/built_collection.dart';
  6: import 'package:flutter/services.dart';
  7: import 'package:flutter_test/flutter_test.dart';
  8: import 'package:crossword/model.dart';
  9: 
 10: void main() {
 11:   TestWidgetsFlutterBinding.ensureInitialized();
 12: 
 13:   test('Empty crossword is valid', () {
 14:     final Crossword crossword = Crossword.crossword(height: 50, width: 50);
 15: 
 16:     expect(crossword.words.isEmpty, isTrue);
 17:     expect(crossword.characters.isEmpty, isTrue);
 18:     expect(crossword.valid, isTrue);
 19:   });
 20: 
 21:   test('Minimal valid crossword', () {
 22:     final topLeft = Location.at(0, 0);
 23:     final thisWord = CrosswordWord.word(
 24:       word: 'this',
 25:       location: topLeft,
 26:       direction: Direction.across,
 27:     );
 28:     final thatWord = CrosswordWord.word(
 29:       word: 'that',
 30:       location: topLeft,
 31:       direction: Direction.down,
 32:     );
 33: 
 34:     Crossword crossword = Crossword.crossword(
 35:       height: 50,
 36:       width: 50,
 37:       words: [thisWord, thatWord],
 38:     );
 39: 
 40:     expect(crossword.words.isNotEmpty, true);
 41:     expect(crossword.words.length, 2);
 42:     expect(crossword.words.where((b) => b.direction == Direction.across).length,
 43:         1);
 44:     expect(
 45:         crossword.words.where((b) => b.direction == Direction.down).length, 1);
 46:     expect(crossword.characters.isNotEmpty, isTrue);
 47:     expect(crossword.characters.length, 7);
 48:     expect(
 49:         crossword.characters[topLeft],
 50:         CrosswordCharacter.character(
 51:           acrossWord: thisWord,
 52:           downWord: thatWord,
 53:           character: 't',
 54:         ));
 55:     expect(crossword.valid, isTrue);
 56:   });
 57: 
 58:   test('Minimal invalid crossword', () {
 59:     final topLeft = Location.at(0, 0);
 60:     final oneDown = topLeft.down;
 61:     final thisWord = CrosswordWord.word(
 62:       word: 'this',
 63:       direction: Direction.across,
 64:       location: topLeft,
 65:     );
 66:     final thatWord = CrosswordWord.word(
 67:       word: 'that',
 68:       direction: Direction.across,
 69:       location: oneDown,
 70:     );
 71: 
 72:     final Crossword crossword = Crossword.crossword(
 73:       height: 50,
 74:       width: 50,
 75:       words: [thisWord, thatWord],
 76:     );
 77: 
 78:     expect(crossword.words.isNotEmpty, true);
 79:     expect(
 80:         crossword.words
 81:             .rebuild(
 82:               (b) => b.where((b) => b.direction == Direction.across),
 83:             )
 84:             .length,
 85:         2);
 86:     expect(
 87:         crossword.words
 88:             .rebuild(
 89:               (b) => b.where((b) => b.direction == Direction.down),
 90:             )
 91:             .isEmpty,
 92:         true);
 93:     expect(crossword.characters.isNotEmpty, isTrue);
 94:     expect(crossword.characters.length, 8);
 95:     expect(crossword.valid, isFalse);
 96:   });
 97: 
 98:   test('Adding detached words returns null', () {
 99:     Crossword crossword = Crossword.crossword(width: 50, height: 50);
100:     expect(crossword.valid, true);
101: 
102:     crossword = crossword.addWord(
103:       direction: Direction.across,
104:       location: Location.at(0, 0),
105:       word: 'this',
106:     )!;
107:     expect(crossword.valid, true);
108: 
109:     final crossword2 = crossword.addWord(
110:       direction: Direction.across,
111:       location: Location.at(4, 4),
112:       word: 'detached',
113:     );
114:     expect(crossword2, isNull);
115:   });
116: 
117:   test('Adding across and down words', () {
118:     Crossword? crossword = Crossword.crossword(width: 50, height: 50);
119:     expect(crossword.valid, true);
120: 
121:     final topLeft = Location.at(0, 0);
122:     crossword = crossword.addWord(
123:       direction: Direction.across,
124:       location: topLeft,
125:       word: 'this',
126:     );
127:     if (crossword == null) fail("crossword shouldn't be null");
128:     expect(crossword.valid, isTrue);
129: 
130:     crossword = crossword.addWord(
131:       direction: Direction.down,
132:       location: topLeft,
133:       word: 'that',
134:     );
135:     if (crossword == null) fail("crossword shouldn't be null");
136:     expect(crossword.valid, isTrue);
137:   });
138: 
139:   test('Adding overlapping across words returns null', () {
140:     Crossword? crossword = Crossword.crossword(width: 50, height: 50);
141:     expect(crossword.valid, isTrue);
142: 
143:     final topLeft = Location.at(0, 0);
144: 
145:     crossword = crossword.addWord(
146:       direction: Direction.across,
147:       location: topLeft,
148:       word: 'this',
149:     );
150:     if (crossword == null) fail("crossword shouldn't be null");
151:     expect(crossword.valid, true);
152: 
153:     final crossword2 = crossword.addWord(
154:       direction: Direction.across,
155:       location: topLeft,
156:       word: 'that',
157:     );
158:     expect(crossword2, isNull);
159:   });
160: 
161:   test('Adding overlapping down words returns null', () {
162:     Crossword? crossword = Crossword.crossword(width: 50, height: 50);
163: 
164:     expect(crossword.valid, true);
165: 
166:     final topLeft = Location.at(0, 0);
167: 
168:     crossword = crossword
169:         .addWord(
170:           location: topLeft,
171:           word: 'this',
172:           direction: Direction.down,
173:         )!
174:         .addWord(
175:           location: topLeft,
176:           word: 'total',
177:           direction: Direction.across,
178:         )!;
179: 
180:     expect(crossword.valid, isTrue);
181: 
182:     final crossword2 = crossword.addWord(
183:       direction: Direction.down,
184:       location: topLeft,
185:       word: 'that',
186:     );
187:     expect(crossword2, isNull);
188:   });
189: 
190:   test('Adding words out of bounds returns null', () {
191:     final crossword = Crossword.crossword(width: 50, height: 50);
192: 
193:     expect(crossword.valid, true);
194: 
195:     // Above the top of the board
196:     final crossword1 = crossword.addWord(
197:       direction: Direction.down,
198:       location: Location.at(0, -1),
199:       word: 'this',
200:     );
201:     expect(crossword1, isNull);
202: 
203:     // To the left of the board
204:     final crossword2 = crossword.addWord(
205:       direction: Direction.down,
206:       location: Location.at(-1, 0),
207:       word: 'that',
208:     );
209:     expect(crossword2, isNull);
210: 
211:     // To the right of the board
212:     final crossword3 = crossword.addWord(
213:       direction: Direction.down,
214:       location: Location.at(51, 0),
215:       word: 'this',
216:     );
217:     expect(crossword3, isNull);
218: 
219:     // Below the bottom of the board
220:     final crossword4 = crossword.addWord(
221:       direction: Direction.down,
222:       location: Location.at(0, 51),
223:       word: 'that',
224:     );
225:     expect(crossword4, isNull);
226:   });
227: 
228:   test('Crossword is not valid with run-on across words', () {
229:     Crossword crossword =
230:         Crossword.crossword(width: 50, height: 50).rebuild((b) => b
231:           ..words.addAll([
232:             CrosswordWord.word(
233:               direction: Direction.across,
234:               location: Location.at(0, 0),
235:               word: 'word',
236:             ),
237:             CrosswordWord.word(
238:               direction: Direction.across,
239:               location: Location.at(4, 0),
240:               word: 'another',
241:             ),
242:           ]));
243: 
244:     expect(crossword.valid, false);
245:   });
246: 
247:   test('Crossword is not valid with run-on down words', () {
248:     Crossword crossword =
249:         Crossword.crossword(width: 50, height: 50).rebuild((b) => b
250:           ..words.addAll([
251:             CrosswordWord.word(
252:               direction: Direction.down,
253:               location: Location.at(0, 0),
254:               word: 'word',
255:             ),
256:             CrosswordWord.word(
257:               direction: Direction.down,
258:               location: Location.at(0, 4),
259:               word: 'another',
260:             ),
261:           ]));
262: 
263:     expect(crossword.valid, false);
264:   });
265: 
266:   test('Crossword is not valid with run-on across/down words', () {
267:     Crossword crossword =
268:         Crossword.crossword(width: 50, height: 50).rebuild((b) => b
269:           ..words.addAll([
270:             CrosswordWord.word(
271:               direction: Direction.across,
272:               location: Location.at(0, 0),
273:               word: 'word',
274:             ),
275:             CrosswordWord.word(
276:               direction: Direction.down,
277:               location: Location.at(4, 0),
278:               word: 'another',
279:             ),
280:           ]));
281: 
282:     expect(crossword.valid, false);
283:   });
284: 
285:   test('Crossword is not valid with run-on down/across words', () {
286:     Crossword? crossword =
287:         Crossword.crossword(width: 50, height: 50).rebuild((b) => b
288:           ..words.addAll([
289:             CrosswordWord.word(
290:               direction: Direction.down,
291:               location: Location.at(0, 0),
292:               word: 'word',
293:             ),
294:             CrosswordWord.word(
295:               direction: Direction.across,
296:               location: Location.at(0, 4),
297:               word: 'another',
298:             ),
299:           ]));
300: 
301:     expect(crossword.valid, false);
302:   });
303: 
304:   test('Adding duplicate across words returns null', () {
305:     Crossword? crossword = Crossword.crossword(width: 50, height: 50);
306: 
307:     crossword = crossword.addWord(
308:       direction: Direction.across,
309:       location: Location.at(0, 0),
310:       word: 'duplicated',
311:     )!;
312: 
313:     expect(
314:         crossword.addWord(
315:           direction: Direction.across,
316:           location: Location.at(4, 4),
317:           word: 'duplicated',
318:         ),
319:         isNull);
320:   });
321: 
322:   test('Crossword is not valid with duplicate across words', () {
323:     Crossword? crossword =
324:         Crossword.crossword(width: 50, height: 50).rebuild((b) => b
325:           ..words.addAll([
326:             CrosswordWord.word(
327:               direction: Direction.across,
328:               location: Location.at(0, 0),
329:               word: 'duplicated',
330:             ),
331:             CrosswordWord.word(
332:               direction: Direction.across,
333:               location: Location.at(4, 4),
334:               word: 'duplicated',
335:             ),
336:           ]));
337: 
338:     expect(crossword.valid, false);
339:   });
340: 
341:   test('Adding duplicate down words returns null', () {
342:     Crossword? crossword = Crossword.crossword(width: 50, height: 50);
343: 
344:     crossword = crossword.addWord(
345:       direction: Direction.down,
346:       location: Location.at(0, 0),
347:       word: 'duplicated',
348:     )!;
349: 
350:     expect(
351:         crossword.addWord(
352:           direction: Direction.down,
353:           location: Location.at(4, 4),
354:           word: 'duplicated',
355:         ),
356:         isNull);
357:   });
358: 
359:   test('Crossword is not valid with duplicate down words', () {
360:     Crossword? crossword =
361:         Crossword.crossword(width: 50, height: 50).rebuild((b) => b
362:           ..words.addAll([
363:             CrosswordWord.word(
364:               direction: Direction.down,
365:               location: Location.at(0, 0),
366:               word: 'duplicated',
367:             ),
368:             CrosswordWord.word(
369:               direction: Direction.down,
370:               location: Location.at(4, 4),
371:               word: 'duplicated',
372:             ),
373:           ]));
374: 
375:     expect(crossword.valid, false);
376:   });
377: 
378:   test('WorkQueue from a crossword', () {
379:     Crossword crossword = Crossword.crossword(width: 50, height: 50);
380:     WorkQueue queue = WorkQueue.from(
381:       crossword: crossword,
382:       candidateWords: ['words', 'and', 'moar', 'wordz'],
383:       startLocation: Location.at(0, 0),
384:     );
385:     expect(queue.locationsToTry.length, 1);
386: 
387:     crossword = crossword.addWord(
388:         direction: Direction.across,
389:         location: Location.at(0, 0),
390:         word: 'word')!;
391:     queue = WorkQueue.from(
392:       crossword: crossword,
393:       candidateWords: ['words', 'and', 'moar', 'wordz'],
394:       startLocation: Location.at(0, 0),
395:     );
396:     expect(queue.locationsToTry.length, 4);
397:     expect(
398:         queue.locationsToTry.entries
399:             .every((element) => element.value == Direction.down),
400:         isTrue);
401:     final entries = queue.locationsToTry.entries;
402:     expect(entries.every((element) => element.key.y == 0), isTrue);
403:     expect(entries.map((element) => element.key.x).toBuiltSet(),
404:         equals(BuiltSet([0, 1, 2, 3])));
405:   });
406: 
407:   test('WorkQueue from down word', () {
408:     Crossword crossword = Crossword.crossword(width: 50, height: 50).addWord(
409:       direction: Direction.down,
410:       location: Location.at(0, 0),
411:       word: 'word',
412:     )!;
413: 
414:     WorkQueue queue = WorkQueue.from(
415:       crossword: crossword,
416:       candidateWords: ['words', 'and', 'moar', 'wordz'],
417:       startLocation: Location.at(0, 0),
418:     );
419:     expect(queue.locationsToTry.length, 4);
420:     expect(
421:         queue.locationsToTry.entries
422:             .every((element) => element.value == Direction.across),
423:         isTrue);
424:     final entries = queue.locationsToTry.entries;
425:     expect(entries.every((element) => element.key.x == 0), isTrue);
426:     expect(entries.map((element) => element.key.y).toBuiltSet(),
427:         equals(BuiltSet([0, 1, 2, 3])));
428:   });
429: 
430:   test('WorkQueue from two words', () {
431:     Crossword crossword = Crossword.crossword(width: 50, height: 50)
432:         .addWord(
433:           direction: Direction.across,
434:           location: Location.at(0, 0),
435:           word: 'word',
436:         )!
437:         .addWord(
438:           direction: Direction.down,
439:           location: Location.at(0, 0),
440:           word: 'work',
441:         )!;
442: 
443:     WorkQueue queue = WorkQueue.from(
444:       crossword: crossword,
445:       candidateWords: ['word', 'work'],
446:       startLocation: Location.at(0, 0),
447:     );
448:     expect(
449:         queue.locationsToTry,
450:         equals(BuiltMap<Location, Direction>({
451:           Location.at(2, 0): Direction.down,
452:           Location.at(0, 2): Direction.across,
453:           Location.at(3, 0): Direction.down,
454:           Location.at(0, 3): Direction.across,
455:         })));
456:   });
457: 
458:   test('WorkQueue removes used words from candidate list', () {
459:     Crossword crossword = Crossword.crossword(width: 50, height: 50)
460:         .addWord(
461:           direction: Direction.across,
462:           location: Location.at(0, 0),
463:           word: 'word',
464:         )!
465:         .addWord(
466:           direction: Direction.down,
467:           location: Location.at(0, 0),
468:           word: 'work',
469:         )!;
470: 
471:     WorkQueue queue = WorkQueue.from(
472:       crossword: crossword,
473:       candidateWords: ['word', 'work'],
474:       startLocation: Location.at(0, 0),
475:     );
476:     expect(queue.candidateWords.length, equals(0));
477:   });
478: 
479:   test('CrosswordPuzzleGame from a crossword', () async {
480:     Crossword crossword = Crossword.crossword(
481:       width: 50,
482:       height: 50,
483:       words: [
484:         CrosswordWord.word(
485:           word: 'word',
486:           location: Location.at(0, 0),
487:           direction: Direction.across,
488:         ),
489:         CrosswordWord.word(
490:           word: 'works',
491:           location: Location.at(0, 0),
492:           direction: Direction.down,
493:         )
494:       ],
495:     );
496: 
497:     final re = RegExp('^[a-z]+\$');
498:     final str = await rootBundle.loadString('assets/words.txt');
499:     final words = str.split('\n').toBuiltSet().rebuild((b) => b
500:       ..map((str) => str.toLowerCase().trim())
501:       ..removeWhere((str) => str.length < 3)
502:       ..removeWhere((str) => re.stringMatch(str) == null));
503: 
504:     final puzzle = CrosswordPuzzleGame.from(
505:       crossword: crossword,
506:       candidateWords: words,
507:     );
508: 
509:     expect(puzzle.crossword.words.length, 2);
510:     expect(puzzle.alternateWords.keys.length, 1);
511:     expect(puzzle.alternateWords[Location.at(0, 0)]?.keys.length, 2);
512:     expect(
513:         puzzle.alternateWords[Location.at(0, 0)]?[Direction.down]?.length, 4);
514:     expect(
515:         puzzle.alternateWords[Location.at(0, 0)]?[Direction.across]?.length, 4);
516:   });
517: 
518:   test('Allow non-overlapping words with requireOverlap: false', () {
519:     Crossword? crossword = Crossword.crossword(width: 50, height: 50);
520: 
521:     crossword = crossword.addWord(
522:         direction: Direction.across,
523:         location: Location.at(0, 0),
524:         word: 'word',
525:         requireOverlap: false);
526: 
527:     if (crossword == null) fail("crossword shouldn't be null");
528: 
529:     crossword = crossword.addWord(
530:         direction: Direction.across,
531:         location: Location.at(3, 3),
532:         word: 'another',
533:         requireOverlap: false);
534: 
535:     if (crossword == null) fail("crossword shouldn't be null");
536:   });
537: 
538:   test(
539:       'Adding overlapping across words returns null with requireOverlap: false',
540:       () {
541:     Crossword? crossword = Crossword.crossword(width: 50, height: 50);
542:     expect(crossword.valid, isTrue);
543: 
544:     final topLeft = Location.at(0, 0);
545: 
546:     crossword = crossword.addWord(
547:       direction: Direction.across,
548:       location: topLeft,
549:       word: 'this',
550:       requireOverlap: false,
551:     );
552:     if (crossword == null) fail("crossword shouldn't be null");
553:     expect(crossword.valid, true);
554: 
555:     final crossword2 = crossword.addWord(
556:       direction: Direction.across,
557:       location: topLeft,
558:       word: 'that',
559:       requireOverlap: false,
560:     );
561:     expect(crossword2, isNull);
562:   });
563: 
564:   test('Adding overlapping down words returns null with requireOverlap: false',
565:       () {
566:     Crossword? crossword = Crossword.crossword(width: 50, height: 50);
567: 
568:     expect(crossword.valid, true);
569: 
570:     final topLeft = Location.at(0, 0);
571: 
572:     crossword = crossword
573:         .addWord(
574:           location: topLeft,
575:           word: 'this',
576:           direction: Direction.down,
577:           requireOverlap: false,
578:         )!
579:         .addWord(
580:           location: topLeft,
581:           word: 'total',
582:           direction: Direction.across,
583:           requireOverlap: false,
584:         )!;
585: 
586:     expect(crossword.valid, isTrue);
587: 
588:     final crossword2 = crossword.addWord(
589:       direction: Direction.down,
590:       location: topLeft,
591:       word: 'that',
592:       requireOverlap: false,
593:     );
594:     expect(crossword2, isNull);
595:   });
596: 
597:   test('Adding words out of bounds returns null with requireOverlap: false',
598:       () {
599:     final crossword = Crossword.crossword(width: 50, height: 50);
600: 
601:     expect(crossword.valid, true);
602: 
603:     // Above the top of the board
604:     final crossword1 = crossword.addWord(
605:       direction: Direction.down,
606:       location: Location.at(0, -1),
607:       word: 'this',
608:       requireOverlap: false,
609:     );
610:     expect(crossword1, isNull);
611: 
612:     // To the left of the board
613:     final crossword2 = crossword.addWord(
614:       direction: Direction.down,
615:       location: Location.at(-1, 0),
616:       word: 'that',
617:       requireOverlap: false,
618:     );
619:     expect(crossword2, isNull);
620: 
621:     // To the right of the board
622:     final crossword3 = crossword.addWord(
623:       direction: Direction.down,
624:       location: Location.at(51, 0),
625:       word: 'this',
626:       requireOverlap: false,
627:     );
628:     expect(crossword3, isNull);
629: 
630:     // Below the bottom of the board
631:     final crossword4 = crossword.addWord(
632:       direction: Direction.down,
633:       location: Location.at(0, 51),
634:       word: 'that',
635:       requireOverlap: false,
636:     );
637:     expect(crossword4, isNull);
638:   });
639: 
640:   test('CrosswordPuzzleGame allows alternate play', () async {
641:     final topLeft = Location.at(0, 0);
642:     final downBy4 = topLeft.downOffset(4);
643:     Crossword crossword = Crossword.crossword(
644:       width: 50,
645:       height: 50,
646:       words: [
647:         CrosswordWord.word(
648:           word: 'word',
649:           location: topLeft,
650:           direction: Direction.across,
651:         ),
652:         CrosswordWord.word(
653:           word: 'works',
654:           location: topLeft,
655:           direction: Direction.down,
656:         ),
657:         CrosswordWord.word(
658:           word: 'silent',
659:           location: downBy4,
660:           direction: Direction.across,
661:         ),
662:       ],
663:     );
664: 
665:     expect(crossword.valid, true);
666: 
667:     final re = RegExp('^[a-z]+\$');
668:     final str = await rootBundle.loadString('assets/words.txt');
669:     final words = str.split('\n').toBuiltSet().rebuild((b) => b
670:       ..map((str) => str.toLowerCase().trim())
671:       ..removeWhere((str) => str.length < 3)
672:       ..removeWhere((str) => re.stringMatch(str) == null));
673: 
674:     CrosswordPuzzleGame? puzzle = CrosswordPuzzleGame.from(
675:       crossword: crossword,
676:       candidateWords: words,
677:     );
678: 
679:     expect(puzzle.crossword.words.length, 3);
680:     expect(puzzle.alternateWords.keys.length, 2);
681: 
682:     final topLeftAcrossAlternates =
683:         puzzle.alternateWords[topLeft]?[Direction.across];
684:     if (topLeftAcrossAlternates == null) {
685:       fail('topLeftAcrossAlternates should not be null');
686:     }
687: 
688:     final downBy4AcrossAlternates =
689:         puzzle.alternateWords[downBy4]?[Direction.across];
690:     if (downBy4AcrossAlternates == null) {
691:       fail('topLeftAcrossAlternates should not be null');
692:     }
693: 
694:     puzzle = puzzle.selectWord(
695:         location: topLeft,
696:         word: topLeftAcrossAlternates.first,
697:         direction: Direction.across);
698:     if (puzzle == null) {
699:       fail('puzzle should not be null');
700:     }
701: 
702:     puzzle = puzzle.selectWord(
703:         location: downBy4,
704:         word: downBy4AcrossAlternates.first,
705:         direction: Direction.across);
706:     if (puzzle == null) {
707:       fail('puzzle should not be null');
708:     }
709: 
710:     expect(puzzle.solved, false);
711:   });
712: 
713:   test('CrosswordPuzzleGame succeeds with expected words', () async {
714:     final topLeft = Location.at(0, 0);
715:     final downBy4 = topLeft.downOffset(4);
716:     Crossword crossword = Crossword.crossword(
717:       width: 50,
718:       height: 50,
719:       words: [
720:         CrosswordWord.word(
721:           word: 'word',
722:           location: topLeft,
723:           direction: Direction.across,
724:         ),
725:         CrosswordWord.word(
726:           word: 'works',
727:           location: topLeft,
728:           direction: Direction.down,
729:         ),
730:         CrosswordWord.word(
731:           word: 'silent',
732:           location: downBy4,
733:           direction: Direction.across,
734:         ),
735:       ],
736:     );
737: 
738:     expect(crossword.valid, true);
739: 
740:     final re = RegExp('^[a-z]+\$');
741:     final str = await rootBundle.loadString('assets/words.txt');
742:     final words = str.split('\n').toBuiltSet().rebuild((b) => b
743:       ..map((str) => str.toLowerCase().trim())
744:       ..removeWhere((str) => str.length < 3)
745:       ..removeWhere((str) => re.stringMatch(str) == null));
746: 
747:     CrosswordPuzzleGame? puzzle = CrosswordPuzzleGame.from(
748:       crossword: crossword,
749:       candidateWords: words,
750:     );
751: 
752:     puzzle = puzzle.selectWord(
753:         location: topLeft, word: 'word', direction: Direction.across);
754:     if (puzzle == null) {
755:       fail('puzzle should not be null');
756:     }
757: 
758:     puzzle = puzzle.selectWord(
759:         location: topLeft, word: 'works', direction: Direction.down);
760:     if (puzzle == null) {
761:       fail('puzzle should not be null');
762:     }
763: 
764:     puzzle = puzzle.selectWord(
765:         location: downBy4, word: 'silent', direction: Direction.across);
766:     if (puzzle == null) {
767:       fail('puzzle should not be null');
768:     }
769: 
770:     expect(puzzle.solved, true);
771:   });
772: }
````

## File: samples/crossword/analysis_options.yaml
````yaml
1: include: package:flutter_lints/flutter.yaml
2: 
3: linter:
4:   rules:
5:     prefer_single_quotes: true
````

## File: samples/crossword/pubspec.yaml
````yaml
 1: name: crossword
 2: description: A crossword game built with Flutter.
 3: publish_to: none
 4: version: 0.1.0
 5: 
 6: environment:
 7:   sdk: ^3.5.0
 8: 
 9: dependencies:
10:   built_collection: ^5.1.1
11:   built_value: ^8.9.2
12:   characters: ^1.3.0
13:   flutter:
14:     sdk: flutter
15:   flutter_riverpod: ^2.6.1
16:   intl: ^0.19.0
17:   riverpod: ^2.6.1
18:   riverpod_annotation: ^2.6.1
19:   two_dimensional_scrollables: ^0.2.1
20: 
21: dev_dependencies:
22:   flutter_test:
23:     sdk: flutter
24:   flutter_lints: ^5.0.0
25:   build_runner: ^2.4.10
26:   built_value_generator: ^8.9.2
27:   custom_lint: ^0.6.8
28:   riverpod_generator: ^2.6.1
29:   riverpod_lint: ^2.6.1
30: 
31: flutter:
32:   uses-material-design: true
33:   assets:
34:     - assets/words.txt
````

## File: samples/multiplayer/assets/music/README.md
````markdown
1: Music in the template is by Mr Smith, and licensed under Creative Commons
2: Attribution 4.0 International (CC BY 4.0).
3: 
4: https://freemusicarchive.org/music/mr-smith
5: 
6: Mr Smith's music is used in this template project with his explicit permission.
````

## File: samples/multiplayer/assets/sfx/README.md
````markdown
1: Sounds in this folder are made by Filip Hracek and are CC0 (Public Domain).
````

## File: samples/multiplayer/ios/Runner/Assets.xcassets/LaunchImage.imageset/README.md
````markdown
1: # Launch Screen Assets
2: 
3: You can customize the launch screen with your own desired assets by replacing the image files in this directory.
4: 
5: You can also do it by opening your Flutter project's Xcode project with `open ios/Runner.xcworkspace`, selecting `Runner/Assets.xcassets` in the Project Navigator and dropping in the desired images.
````

## File: samples/multiplayer/lib/app_lifecycle/app_lifecycle.dart
````dart
 1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: import 'package:flutter/widgets.dart';
 6: import 'package:logging/logging.dart';
 7: import 'package:provider/provider.dart';
 8: 
 9: typedef AppLifecycleStateNotifier = ValueNotifier<AppLifecycleState>;
10: 
11: class AppLifecycleObserver extends StatefulWidget {
12:   final Widget child;
13: 
14:   const AppLifecycleObserver({required this.child, super.key});
15: 
16:   @override
17:   State<AppLifecycleObserver> createState() => _AppLifecycleObserverState();
18: }
19: 
20: class _AppLifecycleObserverState extends State<AppLifecycleObserver> {
21:   static final _log = Logger('AppLifecycleObserver');
22:   late final AppLifecycleListener _appLifecycleListener;
23: 
24:   final ValueNotifier<AppLifecycleState> lifecycleListenable =
25:       ValueNotifier(AppLifecycleState.inactive);
26: 
27:   @override
28:   Widget build(BuildContext context) {
29:     // Using InheritedProvider because we don't want to use Consumer
30:     // or context.watch or anything like that to listen to this. We want
31:     // to manually add listeners. We're interested in the _events_ of lifecycle
32:     // state changes, and not so much in the state itself. (For example,
33:     // we want to stop sound when the app goes into the background, and
34:     // restart sound again when the app goes back into focus. We're not
35:     // rebuilding any widgets.)
36:     //
37:     // Provider, by default, throws when one
38:     // is trying to provide a Listenable (such as ValueNotifier) without using
39:     // something like ValueListenableProvider. InheritedProvider is more
40:     // low-level and doesn't have this problem.
41:     return InheritedProvider<AppLifecycleStateNotifier>.value(
42:       value: lifecycleListenable,
43:       child: widget.child,
44:     );
45:   }
46: 
47:   @override
48:   void dispose() {
49:     _appLifecycleListener.dispose();
50:     super.dispose();
51:   }
52: 
53:   @override
54:   void initState() {
55:     super.initState();
56:     _appLifecycleListener = AppLifecycleListener(
57:       onStateChange: (s) => lifecycleListenable.value = s,
58:     );
59:     _log.info('Subscribed to app lifecycle updates');
60:   }
61: }
````

## File: samples/multiplayer/lib/audio/audio_controller.dart
````dart
  1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
  2: // for details. All rights reserved. Use of this source code is governed by a
  3: // BSD-style license that can be found in the LICENSE file.
  4: 
  5: import 'dart:async';
  6: import 'dart:collection';
  7: import 'dart:math';
  8: 
  9: import 'package:audioplayers/audioplayers.dart';
 10: import 'package:flutter/foundation.dart';
 11: import 'package:flutter/widgets.dart';
 12: import 'package:logging/logging.dart';
 13: 
 14: import '../app_lifecycle/app_lifecycle.dart';
 15: import '../settings/settings.dart';
 16: import 'songs.dart';
 17: import 'sounds.dart';
 18: 
 19: /// Allows playing music and sound. A facade to `package:audioplayers`.
 20: class AudioController {
 21:   static final _log = Logger('AudioController');
 22: 
 23:   final AudioPlayer _musicPlayer;
 24: 
 25:   /// This is a list of [AudioPlayer] instances which are rotated to play
 26:   /// sound effects.
 27:   final List<AudioPlayer> _sfxPlayers;
 28: 
 29:   int _currentSfxPlayer = 0;
 30: 
 31:   final Queue<Song> _playlist;
 32: 
 33:   final Random _random = Random();
 34: 
 35:   SettingsController? _settings;
 36: 
 37:   ValueNotifier<AppLifecycleState>? _lifecycleNotifier;
 38: 
 39:   /// Creates an instance that plays music and sound.
 40:   ///
 41:   /// Use [polyphony] to configure the number of sound effects (SFX) that can
 42:   /// play at the same time. A [polyphony] of `1` will always only play one
 43:   /// sound (a new sound will stop the previous one). See discussion
 44:   /// of [_sfxPlayers] to learn why this is the case.
 45:   ///
 46:   /// Background music does not count into the [polyphony] limit. Music will
 47:   /// never be overridden by sound effects because that would be silly.
 48:   AudioController({int polyphony = 2})
 49:       : assert(polyphony >= 1),
 50:         _musicPlayer = AudioPlayer(playerId: 'musicPlayer'),
 51:         _sfxPlayers = Iterable.generate(
 52:                 polyphony, (i) => AudioPlayer(playerId: 'sfxPlayer#$i'))
 53:             .toList(growable: false),
 54:         _playlist = Queue.of(List<Song>.of(songs)..shuffle()) {
 55:     _musicPlayer.onPlayerComplete.listen(_handleSongFinished);
 56:     unawaited(_preloadSfx());
 57:   }
 58: 
 59:   /// Makes sure the audio controller is listening to changes
 60:   /// of both the app lifecycle (e.g. suspended app) and to changes
 61:   /// of settings (e.g. muted sound).
 62:   void attachDependencies(AppLifecycleStateNotifier lifecycleNotifier,
 63:       SettingsController settingsController) {
 64:     _attachLifecycleNotifier(lifecycleNotifier);
 65:     _attachSettings(settingsController);
 66:   }
 67: 
 68:   void dispose() {
 69:     _lifecycleNotifier?.removeListener(_handleAppLifecycle);
 70:     _stopAllSound();
 71:     _musicPlayer.dispose();
 72:     for (final player in _sfxPlayers) {
 73:       player.dispose();
 74:     }
 75:   }
 76: 
 77:   /// Plays a single sound effect, defined by [type].
 78:   ///
 79:   /// The controller will ignore this call when the attached settings'
 80:   /// [SettingsController.audioOn] is `true` or if its
 81:   /// [SettingsController.soundsOn] is `false`.
 82:   void playSfx(SfxType type) {
 83:     final audioOn = _settings?.audioOn.value ?? false;
 84:     if (!audioOn) {
 85:       _log.fine(() => 'Ignoring playing sound ($type) because audio is muted.');
 86:       return;
 87:     }
 88:     final soundsOn = _settings?.soundsOn.value ?? false;
 89:     if (!soundsOn) {
 90:       _log.fine(() =>
 91:           'Ignoring playing sound ($type) because sounds are turned off.');
 92:       return;
 93:     }
 94: 
 95:     _log.fine(() => 'Playing sound: $type');
 96:     final options = soundTypeToFilename(type);
 97:     final filename = options[_random.nextInt(options.length)];
 98:     _log.fine(() => '- Chosen filename: $filename');
 99: 
100:     final currentPlayer = _sfxPlayers[_currentSfxPlayer];
101:     currentPlayer.play(AssetSource('sfx/$filename'),
102:         volume: soundTypeToVolume(type));
103:     _currentSfxPlayer = (_currentSfxPlayer + 1) % _sfxPlayers.length;
104:   }
105: 
106:   /// Enables the [AudioController] to listen to [AppLifecycleState] events,
107:   /// and therefore do things like stopping playback when the game
108:   /// goes into the background.
109:   void _attachLifecycleNotifier(AppLifecycleStateNotifier lifecycleNotifier) {
110:     _lifecycleNotifier?.removeListener(_handleAppLifecycle);
111: 
112:     lifecycleNotifier.addListener(_handleAppLifecycle);
113:     _lifecycleNotifier = lifecycleNotifier;
114:   }
115: 
116:   /// Enables the [AudioController] to track changes to settings.
117:   /// Namely, when any of [SettingsController.audioOn],
118:   /// [SettingsController.musicOn] or [SettingsController.soundsOn] changes,
119:   /// the audio controller will act accordingly.
120:   void _attachSettings(SettingsController settingsController) {
121:     if (_settings == settingsController) {
122:       // Already attached to this instance. Nothing to do.
123:       return;
124:     }
125: 
126:     // Remove handlers from the old settings controller if present
127:     final oldSettings = _settings;
128:     if (oldSettings != null) {
129:       oldSettings.audioOn.removeListener(_audioOnHandler);
130:       oldSettings.musicOn.removeListener(_musicOnHandler);
131:       oldSettings.soundsOn.removeListener(_soundsOnHandler);
132:     }
133: 
134:     _settings = settingsController;
135: 
136:     // Add handlers to the new settings controller
137:     settingsController.audioOn.addListener(_audioOnHandler);
138:     settingsController.musicOn.addListener(_musicOnHandler);
139:     settingsController.soundsOn.addListener(_soundsOnHandler);
140: 
141:     if (settingsController.audioOn.value && settingsController.musicOn.value) {
142:       if (kIsWeb) {
143:         _log.info('On the web, music can only start after user interaction.');
144:       } else {
145:         _playCurrentSongInPlaylist();
146:       }
147:     }
148:   }
149: 
150:   void _audioOnHandler() {
151:     _log.fine('audioOn changed to ${_settings!.audioOn.value}');
152:     if (_settings!.audioOn.value) {
153:       // All sound just got un-muted. Audio is on.
154:       if (_settings!.musicOn.value) {
155:         _startOrResumeMusic();
156:       }
157:     } else {
158:       // All sound just got muted. Audio is off.
159:       _stopAllSound();
160:     }
161:   }
162: 
163:   void _handleAppLifecycle() {
164:     switch (_lifecycleNotifier!.value) {
165:       case AppLifecycleState.paused:
166:       case AppLifecycleState.detached:
167:       case AppLifecycleState.hidden:
168:         _stopAllSound();
169:       case AppLifecycleState.resumed:
170:         if (_settings!.audioOn.value && _settings!.musicOn.value) {
171:           _startOrResumeMusic();
172:         }
173:       case AppLifecycleState.inactive:
174:         // No need to react to this state change.
175:         break;
176:     }
177:   }
178: 
179:   void _handleSongFinished(void _) {
180:     _log.info('Last song finished playing.');
181:     // Move the song that just finished playing to the end of the playlist.
182:     _playlist.addLast(_playlist.removeFirst());
183:     // Play the song at the beginning of the playlist.
184:     _playCurrentSongInPlaylist();
185:   }
186: 
187:   void _musicOnHandler() {
188:     if (_settings!.musicOn.value) {
189:       // Music got turned on.
190:       if (_settings!.audioOn.value) {
191:         _startOrResumeMusic();
192:       }
193:     } else {
194:       // Music got turned off.
195:       _musicPlayer.pause();
196:     }
197:   }
198: 
199:   Future<void> _playCurrentSongInPlaylist() async {
200:     _log.info(() => 'Playing ${_playlist.first} now.');
201:     try {
202:       await _musicPlayer.play(AssetSource('music/${_playlist.first.filename}'));
203:     } catch (e) {
204:       _log.severe('Could not play song ${_playlist.first}', e);
205:     }
206:   }
207: 
208:   /// Preloads all sound effects.
209:   Future<void> _preloadSfx() async {
210:     _log.info('Preloading sound effects');
211:     // This assumes there is only a limited number of sound effects in the game.
212:     // If there are hundreds of long sound effect files, it's better
213:     // to be more selective when preloading.
214:     await AudioCache.instance.loadAll(SfxType.values
215:         .expand(soundTypeToFilename)
216:         .map((path) => 'sfx/$path')
217:         .toList());
218:   }
219: 
220:   void _soundsOnHandler() {
221:     for (final player in _sfxPlayers) {
222:       if (player.state == PlayerState.playing) {
223:         player.stop();
224:       }
225:     }
226:   }
227: 
228:   void _startOrResumeMusic() async {
229:     if (_musicPlayer.source == null) {
230:       _log.info('No music source set. '
231:           'Start playing the current song in playlist.');
232:       await _playCurrentSongInPlaylist();
233:       return;
234:     }
235: 
236:     _log.info('Resuming paused music.');
237:     try {
238:       _musicPlayer.resume();
239:     } catch (e) {
240:       // Sometimes, resuming fails with an "Unexpected" error.
241:       _log.severe('Error resuming music', e);
242:       // Try starting the song from scratch.
243:       _playCurrentSongInPlaylist();
244:     }
245:   }
246: 
247:   void _stopAllSound() {
248:     _log.info('Stopping all sound');
249:     _musicPlayer.pause();
250:     for (final player in _sfxPlayers) {
251:       player.stop();
252:     }
253:   }
254: }
````

## File: samples/multiplayer/lib/audio/songs.dart
````dart
 1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: const Set<Song> songs = {
 6:   // Filenames with whitespace break package:audioplayers on iOS
 7:   // (as of February 2022), so we use no whitespace.
 8:   Song('Mr_Smith-Azul.mp3', 'Azul', artist: 'Mr Smith'),
 9:   Song('Mr_Smith-Sonorus.mp3', 'Sonorus', artist: 'Mr Smith'),
10:   Song('Mr_Smith-Sunday_Solitude.mp3', 'SundaySolitude', artist: 'Mr Smith'),
11: };
12: 
13: class Song {
14:   final String filename;
15: 
16:   final String name;
17: 
18:   final String? artist;
19: 
20:   const Song(this.filename, this.name, {this.artist});
21: 
22:   @override
23:   String toString() => 'Song<$filename>';
24: }
````

## File: samples/multiplayer/lib/audio/sounds.dart
````dart
 1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: List<String> soundTypeToFilename(SfxType type) {
 6:   switch (type) {
 7:     case SfxType.huhsh:
 8:       return const [
 9:         'hash1.mp3',
10:         'hash2.mp3',
11:         'hash3.mp3',
12:       ];
13:     case SfxType.wssh:
14:       return const [
15:         'wssh1.mp3',
16:         'wssh2.mp3',
17:         'dsht1.mp3',
18:         'ws1.mp3',
19:         'spsh1.mp3',
20:         'hh1.mp3',
21:         'hh2.mp3',
22:         'kss1.mp3',
23:       ];
24:     case SfxType.buttonTap:
25:       return const [
26:         'k1.mp3',
27:         'k2.mp3',
28:         'p1.mp3',
29:         'p2.mp3',
30:       ];
31:     case SfxType.congrats:
32:       return const [
33:         'yay1.mp3',
34:         'wehee1.mp3',
35:         'oo1.mp3',
36:       ];
37:     case SfxType.erase:
38:       return const [
39:         'fwfwfwfwfw1.mp3',
40:         'fwfwfwfw1.mp3',
41:       ];
42:     case SfxType.swishSwish:
43:       return const [
44:         'swishswish1.mp3',
45:       ];
46:   }
47: }
48: 
49: /// Allows control over loudness of different SFX types.
50: double soundTypeToVolume(SfxType type) {
51:   switch (type) {
52:     case SfxType.huhsh:
53:       return 0.4;
54:     case SfxType.wssh:
55:       return 0.2;
56:     case SfxType.buttonTap:
57:     case SfxType.congrats:
58:     case SfxType.erase:
59:     case SfxType.swishSwish:
60:       return 1.0;
61:   }
62: }
63: 
64: enum SfxType {
65:   huhsh,
66:   wssh,
67:   buttonTap,
68:   congrats,
69:   erase,
70:   swishSwish,
71: }
````

## File: samples/multiplayer/lib/game_internals/board_state.dart
````dart
 1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: import 'package:flutter/foundation.dart';
 6: 
 7: import 'player.dart';
 8: import 'playing_area.dart';
 9: 
10: class BoardState {
11:   final VoidCallback onWin;
12: 
13:   final PlayingArea areaOne = PlayingArea();
14: 
15:   final PlayingArea areaTwo = PlayingArea();
16: 
17:   final Player player = Player();
18: 
19:   BoardState({required this.onWin}) {
20:     player.addListener(_handlePlayerChange);
21:   }
22: 
23:   List<PlayingArea> get areas => [areaOne, areaTwo];
24: 
25:   void dispose() {
26:     player.removeListener(_handlePlayerChange);
27:     areaOne.dispose();
28:     areaTwo.dispose();
29:   }
30: 
31:   void _handlePlayerChange() {
32:     if (player.hand.isEmpty) {
33:       onWin();
34:     }
35:   }
36: }
````

## File: samples/multiplayer/lib/game_internals/card_suit.dart
````dart
 1: enum CardSuit {
 2:   clubs(1),
 3:   spades(2),
 4:   hearts(3),
 5:   diamonds(4);
 6: 
 7:   final int internalRepresentation;
 8: 
 9:   const CardSuit(this.internalRepresentation);
10: 
11:   String get asCharacter {
12:     switch (this) {
13:       case CardSuit.spades:
14:         return '♠';
15:       case CardSuit.hearts:
16:         return '♥';
17:       case CardSuit.diamonds:
18:         return '♦';
19:       case CardSuit.clubs:
20:         return '♣';
21:     }
22:   }
23: 
24:   CardSuitColor get color {
25:     switch (this) {
26:       case CardSuit.spades:
27:       case CardSuit.clubs:
28:         return CardSuitColor.black;
29:       case CardSuit.hearts:
30:       case CardSuit.diamonds:
31:         return CardSuitColor.red;
32:     }
33:   }
34: 
35:   @override
36:   String toString() => asCharacter;
37: }
38: 
39: enum CardSuitColor {
40:   black,
41:   red,
42: }
````

## File: samples/multiplayer/lib/game_internals/player.dart
````dart
 1: import 'package:flutter/foundation.dart';
 2: 
 3: import 'playing_card.dart';
 4: 
 5: class Player extends ChangeNotifier {
 6:   static const maxCards = 7;
 7: 
 8:   final List<PlayingCard> hand =
 9:       List.generate(maxCards, (index) => PlayingCard.random());
10: 
11:   void removeCard(PlayingCard card) {
12:     hand.remove(card);
13:     notifyListeners();
14:   }
15: }
````

## File: samples/multiplayer/lib/game_internals/playing_area.dart
````dart
 1: import 'dart:async';
 2: 
 3: import 'package:async/async.dart';
 4: 
 5: import 'playing_card.dart';
 6: 
 7: class PlayingArea {
 8:   /// The maximum number of cards in this playing area.
 9:   static const int maxCards = 6;
10: 
11:   /// The current cards in this area.
12:   final List<PlayingCard> cards = [];
13: 
14:   final StreamController<void> _playerChanges =
15:       StreamController<void>.broadcast();
16: 
17:   final StreamController<void> _remoteChanges =
18:       StreamController<void>.broadcast();
19: 
20:   PlayingArea();
21: 
22:   /// A [Stream] that fires an event every time any change to this area is made.
23:   Stream<void> get allChanges =>
24:       StreamGroup.mergeBroadcast([remoteChanges, playerChanges]);
25: 
26:   /// A [Stream] that fires an event every time a change is made _locally_,
27:   /// by the player.
28:   Stream<void> get playerChanges => _playerChanges.stream;
29: 
30:   /// A [Stream] that fires an event every time a change is made _remotely_,
31:   /// by another player.
32:   Stream<void> get remoteChanges => _remoteChanges.stream;
33: 
34:   /// Accepts the [card] into the area.
35:   void acceptCard(PlayingCard card) {
36:     cards.add(card);
37:     _maybeTrim();
38:     _playerChanges.add(null);
39:   }
40: 
41:   void dispose() {
42:     _remoteChanges.close();
43:     _playerChanges.close();
44:   }
45: 
46:   /// Removes the first card in the area, if any.
47:   void removeFirstCard() {
48:     if (cards.isEmpty) return;
49:     cards.removeAt(0);
50:     _playerChanges.add(null);
51:   }
52: 
53:   /// Replaces the cards in the area with [cards].
54:   ///
55:   /// This method is meant to be called when the cards are updated from
56:   /// a server.
57:   void replaceWith(List<PlayingCard> cards) {
58:     this.cards.clear();
59:     this.cards.addAll(cards);
60:     _maybeTrim();
61:     _remoteChanges.add(null);
62:   }
63: 
64:   void _maybeTrim() {
65:     if (cards.length > maxCards) {
66:       cards.removeRange(0, cards.length - maxCards);
67:     }
68:   }
69: }
````

## File: samples/multiplayer/lib/game_internals/playing_card.dart
````dart
 1: import 'dart:math';
 2: 
 3: import 'package:flutter/foundation.dart';
 4: 
 5: import 'card_suit.dart';
 6: 
 7: @immutable
 8: class PlayingCard {
 9:   static final _random = Random();
10: 
11:   final CardSuit suit;
12: 
13:   final int value;
14: 
15:   const PlayingCard(this.suit, this.value);
16: 
17:   factory PlayingCard.fromJson(Map<String, dynamic> json) {
18:     return PlayingCard(
19:       CardSuit.values
20:           .singleWhere((e) => e.internalRepresentation == json['suit']),
21:       json['value'] as int,
22:     );
23:   }
24: 
25:   factory PlayingCard.random([Random? random]) {
26:     random ??= _random;
27:     return PlayingCard(
28:       CardSuit.values[random.nextInt(CardSuit.values.length)],
29:       2 + random.nextInt(9),
30:     );
31:   }
32: 
33:   @override
34:   int get hashCode => Object.hash(suit, value);
35: 
36:   @override
37:   bool operator ==(Object other) {
38:     return other is PlayingCard && other.suit == suit && other.value == value;
39:   }
40: 
41:   Map<String, dynamic> toJson() => {
42:         'suit': suit.internalRepresentation,
43:         'value': value,
44:       };
45: 
46:   @override
47:   String toString() {
48:     return '$suit$value';
49:   }
50: }
````

## File: samples/multiplayer/lib/game_internals/score.dart
````dart
 1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: /// Encapsulates a score and the arithmetic to compute it.
 6: class Score {
 7:   final int score;
 8: 
 9:   final Duration duration;
10: 
11:   final int level;
12: 
13:   factory Score(int level, int difficulty, Duration duration) {
14:     // The higher the difficulty, the higher the score.
15:     var score = difficulty;
16:     // The lower the time to beat the level, the higher the score.
17:     score *= 10000 ~/ (duration.inSeconds.abs() + 1);
18:     return Score._(score, duration, level);
19:   }
20: 
21:   const Score._(this.score, this.duration, this.level);
22: 
23:   String get formattedTime {
24:     final buf = StringBuffer();
25:     if (duration.inHours > 0) {
26:       buf.write('${duration.inHours}');
27:       buf.write(':');
28:     }
29:     final minutes = duration.inMinutes % Duration.minutesPerHour;
30:     if (minutes > 9) {
31:       buf.write('$minutes');
32:     } else {
33:       buf.write('0');
34:       buf.write('$minutes');
35:     }
36:     buf.write(':');
37:     buf.write((duration.inSeconds % Duration.secondsPerMinute)
38:         .toString()
39:         .padLeft(2, '0'));
40:     return buf.toString();
41:   }
42: 
43:   @override
44:   String toString() => 'Score<$score,$formattedTime,$level>';
45: }
````

## File: samples/multiplayer/lib/main_menu/main_menu_screen.dart
````dart
 1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: import 'package:flutter/material.dart';
 6: import 'package:go_router/go_router.dart';
 7: import 'package:provider/provider.dart';
 8: 
 9: import '../audio/audio_controller.dart';
10: import '../audio/sounds.dart';
11: import '../settings/settings.dart';
12: import '../style/my_button.dart';
13: import '../style/palette.dart';
14: import '../style/responsive_screen.dart';
15: 
16: class MainMenuScreen extends StatelessWidget {
17:   const MainMenuScreen({super.key});
18: 
19:   @override
20:   Widget build(BuildContext context) {
21:     final palette = context.watch<Palette>();
22:     final settingsController = context.watch<SettingsController>();
23:     final audioController = context.watch<AudioController>();
24: 
25:     return Scaffold(
26:       backgroundColor: palette.backgroundMain,
27:       body: ResponsiveScreen(
28:         squarishMainArea: Center(
29:           child: Transform.rotate(
30:             angle: -0.1,
31:             child: const Text(
32:               'Drag&Drop Cards!',
33:               textAlign: TextAlign.center,
34:               style: TextStyle(
35:                 fontFamily: 'Permanent Marker',
36:                 fontSize: 55,
37:                 height: 1,
38:               ),
39:             ),
40:           ),
41:         ),
42:         rectangularMenuArea: Column(
43:           mainAxisAlignment: MainAxisAlignment.end,
44:           children: [
45:             MyButton(
46:               onPressed: () {
47:                 audioController.playSfx(SfxType.buttonTap);
48:                 GoRouter.of(context).go('/play');
49:               },
50:               child: const Text('Play'),
51:             ),
52:             _gap,
53:             MyButton(
54:               onPressed: () => GoRouter.of(context).push('/settings'),
55:               child: const Text('Settings'),
56:             ),
57:             _gap,
58:             Padding(
59:               padding: const EdgeInsets.only(top: 32),
60:               child: ValueListenableBuilder<bool>(
61:                 valueListenable: settingsController.audioOn,
62:                 builder: (context, audioOn, child) {
63:                   return IconButton(
64:                     onPressed: () => settingsController.toggleAudioOn(),
65:                     icon: Icon(audioOn ? Icons.volume_up : Icons.volume_off),
66:                   );
67:                 },
68:               ),
69:             ),
70:             _gap,
71:             const Text('Music by Mr Smith'),
72:             _gap,
73:           ],
74:         ),
75:       ),
76:     );
77:   }
78: 
79:   static const _gap = SizedBox(height: 10);
80: }
````

## File: samples/multiplayer/lib/multiplayer/firestore_controller.dart
````dart
  1: import 'dart:async';
  2: 
  3: import 'package:cloud_firestore/cloud_firestore.dart';
  4: import 'package:flutter/foundation.dart';
  5: import 'package:logging/logging.dart';
  6: 
  7: import '../game_internals/board_state.dart';
  8: import '../game_internals/playing_area.dart';
  9: import '../game_internals/playing_card.dart';
 10: 
 11: class FirestoreController {
 12:   static final _log = Logger('FirestoreController');
 13: 
 14:   final FirebaseFirestore instance;
 15: 
 16:   final BoardState boardState;
 17: 
 18:   /// For now, there is only one match. But in order to be ready
 19:   /// for match-making, put it in a Firestore collection called matches.
 20:   late final _matchRef = instance.collection('matches').doc('match_1');
 21: 
 22:   late final _areaOneRef = _matchRef
 23:       .collection('areas')
 24:       .doc('area_one')
 25:       .withConverter<List<PlayingCard>>(
 26:           fromFirestore: _cardsFromFirestore, toFirestore: _cardsToFirestore);
 27: 
 28:   late final _areaTwoRef = _matchRef
 29:       .collection('areas')
 30:       .doc('area_two')
 31:       .withConverter<List<PlayingCard>>(
 32:           fromFirestore: _cardsFromFirestore, toFirestore: _cardsToFirestore);
 33: 
 34:   StreamSubscription<void>? _areaOneFirestoreSubscription;
 35:   StreamSubscription<void>? _areaTwoFirestoreSubscription;
 36: 
 37:   StreamSubscription<void>? _areaOneLocalSubscription;
 38:   StreamSubscription<void>? _areaTwoLocalSubscription;
 39: 
 40:   FirestoreController({required this.instance, required this.boardState}) {
 41:     // Subscribe to the remote changes (from Firestore).
 42:     _areaOneFirestoreSubscription = _areaOneRef.snapshots().listen((snapshot) {
 43:       _updateLocalFromFirestore(boardState.areaOne, snapshot);
 44:     });
 45:     _areaTwoFirestoreSubscription = _areaTwoRef.snapshots().listen((snapshot) {
 46:       _updateLocalFromFirestore(boardState.areaTwo, snapshot);
 47:     });
 48: 
 49:     // Subscribe to the local changes in game state.
 50:     _areaOneLocalSubscription = boardState.areaOne.playerChanges.listen((_) {
 51:       _updateFirestoreFromLocalAreaOne();
 52:     });
 53:     _areaTwoLocalSubscription = boardState.areaTwo.playerChanges.listen((_) {
 54:       _updateFirestoreFromLocalAreaTwo();
 55:     });
 56: 
 57:     _log.fine('Initialized');
 58:   }
 59: 
 60:   void dispose() {
 61:     _areaOneFirestoreSubscription?.cancel();
 62:     _areaTwoFirestoreSubscription?.cancel();
 63:     _areaOneLocalSubscription?.cancel();
 64:     _areaTwoLocalSubscription?.cancel();
 65: 
 66:     _log.fine('Disposed');
 67:   }
 68: 
 69:   /// Takes the raw JSON snapshot coming from Firestore and attempts to
 70:   /// convert it into a list of [PlayingCard]s.
 71:   List<PlayingCard> _cardsFromFirestore(
 72:     DocumentSnapshot<Map<String, dynamic>> snapshot,
 73:     SnapshotOptions? options,
 74:   ) {
 75:     final data = snapshot.data()?['cards'] as List?;
 76: 
 77:     if (data == null) {
 78:       _log.info('No data found on Firestore, returning empty list');
 79:       return [];
 80:     }
 81: 
 82:     final list = List.castFrom<Object?, Map<String, Object?>>(data);
 83: 
 84:     try {
 85:       return list.map((raw) => PlayingCard.fromJson(raw)).toList();
 86:     } catch (e) {
 87:       throw FirebaseControllerException(
 88:           'Failed to parse data from Firestore: $e');
 89:     }
 90:   }
 91: 
 92:   /// Takes a list of [PlayingCard]s and converts it into a JSON object
 93:   /// that can be saved into Firestore.
 94:   Map<String, Object?> _cardsToFirestore(
 95:     List<PlayingCard> cards,
 96:     SetOptions? options,
 97:   ) {
 98:     return {'cards': cards.map((c) => c.toJson()).toList()};
 99:   }
100: 
101:   /// Updates Firestore with the local state of [area].
102:   void _updateFirestoreFromLocal(
103:       PlayingArea area, DocumentReference<List<PlayingCard>> ref) async {
104:     try {
105:       _log.fine('Updating Firestore with local data (${area.cards}) ...');
106:       await ref.set(area.cards);
107:       _log.fine('... done updating.');
108:     } catch (e) {
109:       throw FirebaseControllerException(
110:           'Failed to update Firestore with local data (${area.cards}): $e');
111:     }
112:   }
113: 
114:   /// Sends the local state of [boardState.areaOne] to Firestore.
115:   void _updateFirestoreFromLocalAreaOne() {
116:     _updateFirestoreFromLocal(boardState.areaOne, _areaOneRef);
117:   }
118: 
119:   /// Sends the local state of [boardState.areaTwo] to Firestore.
120:   void _updateFirestoreFromLocalAreaTwo() {
121:     _updateFirestoreFromLocal(boardState.areaTwo, _areaTwoRef);
122:   }
123: 
124:   /// Updates the local state of [area] with the data from Firestore.
125:   void _updateLocalFromFirestore(
126:       PlayingArea area, DocumentSnapshot<List<PlayingCard>> snapshot) {
127:     _log.fine('Received new data from Firestore (${snapshot.data()})');
128: 
129:     final cards = snapshot.data() ?? [];
130: 
131:     if (listEquals(cards, area.cards)) {
132:       _log.fine('No change');
133:     } else {
134:       _log.fine('Updating local data with Firestore data ($cards)');
135:       area.replaceWith(cards);
136:     }
137:   }
138: }
139: 
140: class FirebaseControllerException implements Exception {
141:   final String message;
142: 
143:   FirebaseControllerException(this.message);
144: 
145:   @override
146:   String toString() => 'FirebaseControllerException: $message';
147: }
````

## File: samples/multiplayer/lib/play_session/board_widget.dart
````dart
 1: // Copyright 2023, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: import 'package:flutter/material.dart';
 6: import 'package:provider/provider.dart';
 7: 
 8: import '../game_internals/board_state.dart';
 9: import 'player_hand_widget.dart';
10: import 'playing_area_widget.dart';
11: 
12: /// This widget defines the game UI itself, without things like the settings
13: /// button or the back button.
14: class BoardWidget extends StatefulWidget {
15:   const BoardWidget({super.key});
16: 
17:   @override
18:   State<BoardWidget> createState() => _BoardWidgetState();
19: }
20: 
21: class _BoardWidgetState extends State<BoardWidget> {
22:   @override
23:   Widget build(BuildContext context) {
24:     final boardState = context.watch<BoardState>();
25: 
26:     return Column(
27:       mainAxisAlignment: MainAxisAlignment.center,
28:       crossAxisAlignment: CrossAxisAlignment.stretch,
29:       children: [
30:         Padding(
31:           padding: const EdgeInsets.all(10),
32:           child: Row(
33:             children: [
34:               Expanded(child: PlayingAreaWidget(boardState.areaOne)),
35:               const SizedBox(width: 20),
36:               Expanded(child: PlayingAreaWidget(boardState.areaTwo)),
37:             ],
38:           ),
39:         ),
40:         const PlayerHandWidget(),
41:       ],
42:     );
43:   }
44: }
````

## File: samples/multiplayer/lib/play_session/play_session_screen.dart
````dart
  1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
  2: // for details. All rights reserved. Use of this source code is governed by a
  3: // BSD-style license that can be found in the LICENSE file.
  4: 
  5: import 'dart:async';
  6: 
  7: import 'package:cloud_firestore/cloud_firestore.dart';
  8: import 'package:flutter/material.dart';
  9: import 'package:go_router/go_router.dart';
 10: import 'package:logging/logging.dart' hide Level;
 11: import 'package:provider/provider.dart';
 12: 
 13: import '../audio/audio_controller.dart';
 14: import '../audio/sounds.dart';
 15: import '../game_internals/board_state.dart';
 16: import '../game_internals/score.dart';
 17: import '../multiplayer/firestore_controller.dart';
 18: import '../style/confetti.dart';
 19: import '../style/my_button.dart';
 20: import '../style/palette.dart';
 21: import 'board_widget.dart';
 22: 
 23: /// This widget defines the entirety of the screen that the player sees when
 24: /// they are playing a level.
 25: ///
 26: /// It is a stateful widget because it manages some state of its own,
 27: /// such as whether the game is in a "celebration" state.
 28: class PlaySessionScreen extends StatefulWidget {
 29:   const PlaySessionScreen({super.key});
 30: 
 31:   @override
 32:   State<PlaySessionScreen> createState() => _PlaySessionScreenState();
 33: }
 34: 
 35: class _PlaySessionScreenState extends State<PlaySessionScreen> {
 36:   static final _log = Logger('PlaySessionScreen');
 37: 
 38:   static const _celebrationDuration = Duration(milliseconds: 2000);
 39: 
 40:   static const _preCelebrationDuration = Duration(milliseconds: 500);
 41: 
 42:   bool _duringCelebration = false;
 43: 
 44:   late DateTime _startOfPlay;
 45: 
 46:   late final BoardState _boardState;
 47: 
 48:   FirestoreController? _firestoreController;
 49: 
 50:   @override
 51:   Widget build(BuildContext context) {
 52:     final palette = context.watch<Palette>();
 53: 
 54:     return MultiProvider(
 55:       providers: [
 56:         Provider.value(value: _boardState),
 57:       ],
 58:       child: IgnorePointer(
 59:         // Ignore all input during the celebration animation.
 60:         ignoring: _duringCelebration,
 61:         child: Scaffold(
 62:           backgroundColor: palette.backgroundPlaySession,
 63:           // The stack is how you layer widgets on top of each other.
 64:           // Here, it is used to overlay the winning confetti animation on top
 65:           // of the game.
 66:           body: Stack(
 67:             children: [
 68:               // This is the main layout of the play session screen,
 69:               // with a settings button at top, the actual play area
 70:               // in the middle, and a back button at the bottom.
 71:               Column(
 72:                 mainAxisAlignment: MainAxisAlignment.center,
 73:                 children: [
 74:                   Align(
 75:                     alignment: Alignment.centerRight,
 76:                     child: InkResponse(
 77:                       onTap: () => GoRouter.of(context).push('/settings'),
 78:                       child: Image.asset(
 79:                         'assets/images/settings.png',
 80:                         semanticLabel: 'Settings',
 81:                       ),
 82:                     ),
 83:                   ),
 84:                   const Spacer(),
 85:                   // The actual UI of the game.
 86:                   const BoardWidget(),
 87:                   const Text('Drag cards to the two areas above.'),
 88:                   const Spacer(),
 89:                   Padding(
 90:                     padding: const EdgeInsets.all(8.0),
 91:                     child: MyButton(
 92:                       onPressed: () => GoRouter.of(context).go('/'),
 93:                       child: const Text('Back'),
 94:                     ),
 95:                   ),
 96:                 ],
 97:               ),
 98:               SizedBox.expand(
 99:                 child: Visibility(
100:                   visible: _duringCelebration,
101:                   child: IgnorePointer(
102:                     child: Confetti(
103:                       isStopped: !_duringCelebration,
104:                     ),
105:                   ),
106:                 ),
107:               ),
108:             ],
109:           ),
110:         ),
111:       ),
112:     );
113:   }
114: 
115:   @override
116:   void dispose() {
117:     _boardState.dispose();
118:     _firestoreController?.dispose();
119:     super.dispose();
120:   }
121: 
122:   @override
123:   void initState() {
124:     super.initState();
125:     _startOfPlay = DateTime.now();
126:     _boardState = BoardState(onWin: _playerWon);
127: 
128:     final firestore = context.read<FirebaseFirestore?>();
129:     if (firestore == null) {
130:       _log.warning("Firestore instance wasn't provided. "
131:           'Running without _firestoreController.');
132:     } else {
133:       _firestoreController = FirestoreController(
134:         instance: firestore,
135:         boardState: _boardState,
136:       );
137:     }
138:   }
139: 
140:   Future<void> _playerWon() async {
141:     _log.info('Player won');
142: 
143:     // TODO: replace with some meaningful score for the card game
144:     final score = Score(1, 1, DateTime.now().difference(_startOfPlay));
145: 
146:     // final playerProgress = context.read<PlayerProgress>();
147:     // playerProgress.setLevelReached(widget.level.number);
148: 
149:     // Let the player see the game just after winning for a bit.
150:     await Future<void>.delayed(_preCelebrationDuration);
151:     if (!mounted) return;
152: 
153:     setState(() {
154:       _duringCelebration = true;
155:     });
156: 
157:     final audioController = context.read<AudioController>();
158:     audioController.playSfx(SfxType.congrats);
159: 
160:     /// Give the player some time to see the celebration animation.
161:     await Future<void>.delayed(_celebrationDuration);
162:     if (!mounted) return;
163: 
164:     GoRouter.of(context).go('/play/won', extra: {'score': score});
165:   }
166: }
````

## File: samples/multiplayer/lib/play_session/player_hand_widget.dart
````dart
 1: import 'package:flutter/material.dart';
 2: import 'package:provider/provider.dart';
 3: 
 4: import '../game_internals/board_state.dart';
 5: import 'playing_card_widget.dart';
 6: 
 7: class PlayerHandWidget extends StatelessWidget {
 8:   const PlayerHandWidget({super.key});
 9: 
10:   @override
11:   Widget build(BuildContext context) {
12:     final boardState = context.watch<BoardState>();
13: 
14:     return Padding(
15:       padding: const EdgeInsets.all(10),
16:       child: ConstrainedBox(
17:         constraints: const BoxConstraints(minHeight: PlayingCardWidget.height),
18:         child: ListenableBuilder(
19:           // Make sure we rebuild every time there's an update
20:           // to the player's hand.
21:           listenable: boardState.player,
22:           builder: (context, child) {
23:             return Wrap(
24:               alignment: WrapAlignment.center,
25:               spacing: 10,
26:               runSpacing: 10,
27:               children: [
28:                 ...boardState.player.hand.map((card) =>
29:                     PlayingCardWidget(card, player: boardState.player)),
30:               ],
31:             );
32:           },
33:         ),
34:       ),
35:     );
36:   }
37: }
````

## File: samples/multiplayer/lib/play_session/playing_area_widget.dart
````dart
  1: import 'dart:math';
  2: 
  3: import 'package:flutter/material.dart';
  4: import 'package:provider/provider.dart';
  5: 
  6: import '../audio/audio_controller.dart';
  7: import '../audio/sounds.dart';
  8: import '../game_internals/playing_area.dart';
  9: import '../game_internals/playing_card.dart';
 10: import '../style/palette.dart';
 11: import 'playing_card_widget.dart';
 12: 
 13: class PlayingAreaWidget extends StatefulWidget {
 14:   final PlayingArea area;
 15: 
 16:   const PlayingAreaWidget(this.area, {super.key});
 17: 
 18:   @override
 19:   State<PlayingAreaWidget> createState() => _PlayingAreaWidgetState();
 20: }
 21: 
 22: class _PlayingAreaWidgetState extends State<PlayingAreaWidget> {
 23:   bool isHighlighted = false;
 24: 
 25:   @override
 26:   Widget build(BuildContext context) {
 27:     final palette = context.watch<Palette>();
 28: 
 29:     return LimitedBox(
 30:       maxHeight: 200,
 31:       child: AspectRatio(
 32:         aspectRatio: 1 / 1,
 33:         child: DragTarget<PlayingCardDragData>(
 34:           builder: (context, candidateData, rejectedData) => Material(
 35:             color: isHighlighted ? palette.accept : palette.trueWhite,
 36:             shape: const CircleBorder(),
 37:             clipBehavior: Clip.hardEdge,
 38:             child: InkWell(
 39:               splashColor: palette.redPen,
 40:               onTap: _onAreaTap,
 41:               child: StreamBuilder(
 42:                 // Rebuild the card stack whenever the area changes
 43:                 // (either by a player action, or remotely).
 44:                 stream: widget.area.allChanges,
 45:                 builder: (context, child) => _CardStack(widget.area.cards),
 46:               ),
 47:             ),
 48:           ),
 49:           onWillAcceptWithDetails: _onDragWillAccept,
 50:           onLeave: _onDragLeave,
 51:           onAcceptWithDetails: _onDragAccept,
 52:         ),
 53:       ),
 54:     );
 55:   }
 56: 
 57:   void _onAreaTap() {
 58:     widget.area.removeFirstCard();
 59: 
 60:     final audioController = context.read<AudioController>();
 61:     audioController.playSfx(SfxType.huhsh);
 62:   }
 63: 
 64:   void _onDragAccept(DragTargetDetails<PlayingCardDragData> details) {
 65:     widget.area.acceptCard(details.data.card);
 66:     details.data.holder.removeCard(details.data.card);
 67:     setState(() => isHighlighted = false);
 68:   }
 69: 
 70:   void _onDragLeave(PlayingCardDragData? data) {
 71:     setState(() => isHighlighted = false);
 72:   }
 73: 
 74:   bool _onDragWillAccept(DragTargetDetails<PlayingCardDragData> details) {
 75:     setState(() => isHighlighted = true);
 76:     return true;
 77:   }
 78: }
 79: 
 80: class _CardStack extends StatelessWidget {
 81:   static const int _maxCards = 6;
 82: 
 83:   static const _leftOffset = 10.0;
 84: 
 85:   static const _topOffset = 5.0;
 86: 
 87:   static const double _maxWidth =
 88:       _maxCards * _leftOffset + PlayingCardWidget.width;
 89: 
 90:   static const _maxHeight = _maxCards * _topOffset + PlayingCardWidget.height;
 91: 
 92:   final List<PlayingCard> cards;
 93: 
 94:   const _CardStack(this.cards);
 95: 
 96:   @override
 97:   Widget build(BuildContext context) {
 98:     return Center(
 99:       child: SizedBox(
100:         width: _maxWidth,
101:         height: _maxHeight,
102:         child: Stack(
103:           children: [
104:             for (var i = max(0, cards.length - _maxCards);
105:                 i < cards.length;
106:                 i++)
107:               Positioned(
108:                 top: i * _topOffset,
109:                 left: i * _leftOffset,
110:                 child: PlayingCardWidget(cards[i]),
111:               ),
112:           ],
113:         ),
114:       ),
115:     );
116:   }
117: }
````

## File: samples/multiplayer/lib/play_session/playing_card_widget.dart
````dart
 1: import 'package:flutter/material.dart';
 2: import 'package:provider/provider.dart';
 3: 
 4: import '../audio/audio_controller.dart';
 5: import '../audio/sounds.dart';
 6: import '../game_internals/card_suit.dart';
 7: import '../game_internals/player.dart';
 8: import '../game_internals/playing_card.dart';
 9: import '../style/palette.dart';
10: 
11: class PlayingCardWidget extends StatelessWidget {
12:   // A standard playing card is 57.1mm x 88.9mm.
13:   static const double width = 57.1;
14: 
15:   static const double height = 88.9;
16: 
17:   final PlayingCard card;
18: 
19:   final Player? player;
20: 
21:   const PlayingCardWidget(this.card, {this.player, super.key});
22: 
23:   @override
24:   Widget build(BuildContext context) {
25:     final palette = context.watch<Palette>();
26:     final textColor =
27:         card.suit.color == CardSuitColor.red ? palette.redPen : palette.ink;
28: 
29:     final cardWidget = DefaultTextStyle(
30:       style: Theme.of(context).textTheme.bodyMedium!.apply(color: textColor),
31:       child: Container(
32:         width: width,
33:         height: height,
34:         decoration: BoxDecoration(
35:           color: palette.trueWhite,
36:           border: Border.all(color: palette.ink),
37:           borderRadius: BorderRadius.circular(5),
38:         ),
39:         child: Center(
40:           child: Text('${card.suit.asCharacter}\n${card.value}',
41:               textAlign: TextAlign.center),
42:         ),
43:       ),
44:     );
45: 
46:     /// Cards that aren't in a player's hand are not draggable.
47:     if (player == null) return cardWidget;
48: 
49:     return Draggable(
50:       feedback: Transform.rotate(
51:         angle: 0.1,
52:         child: cardWidget,
53:       ),
54:       data: PlayingCardDragData(card, player!),
55:       childWhenDragging: Opacity(
56:         opacity: 0.5,
57:         child: cardWidget,
58:       ),
59:       onDragStarted: () {
60:         final audioController = context.read<AudioController>();
61:         audioController.playSfx(SfxType.huhsh);
62:       },
63:       onDragEnd: (details) {
64:         final audioController = context.read<AudioController>();
65:         audioController.playSfx(SfxType.wssh);
66:       },
67:       child: cardWidget,
68:     );
69:   }
70: }
71: 
72: @immutable
73: class PlayingCardDragData {
74:   final PlayingCard card;
75: 
76:   final Player holder;
77: 
78:   const PlayingCardDragData(this.card, this.holder);
79: }
````

## File: samples/multiplayer/lib/player_progress/persistence/local_storage_player_progress_persistence.dart
````dart
 1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: import 'package:shared_preferences/shared_preferences.dart';
 6: 
 7: import 'player_progress_persistence.dart';
 8: 
 9: /// An implementation of [PlayerProgressPersistence] that uses
10: /// `package:shared_preferences`.
11: class LocalStoragePlayerProgressPersistence extends PlayerProgressPersistence {
12:   final Future<SharedPreferences> instanceFuture =
13:       SharedPreferences.getInstance();
14: 
15:   @override
16:   Future<int> getHighestLevelReached() async {
17:     final prefs = await instanceFuture;
18:     return prefs.getInt('highestLevelReached') ?? 0;
19:   }
20: 
21:   @override
22:   Future<void> saveHighestLevelReached(int level) async {
23:     final prefs = await instanceFuture;
24:     await prefs.setInt('highestLevelReached', level);
25:   }
26: }
````

## File: samples/multiplayer/lib/player_progress/persistence/memory_player_progress_persistence.dart
````dart
 1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: import 'player_progress_persistence.dart';
 6: 
 7: /// An in-memory implementation of [PlayerProgressPersistence].
 8: /// Useful for testing.
 9: class MemoryOnlyPlayerProgressPersistence implements PlayerProgressPersistence {
10:   int level = 0;
11: 
12:   @override
13:   Future<int> getHighestLevelReached() async {
14:     await Future<void>.delayed(const Duration(milliseconds: 500));
15:     return level;
16:   }
17: 
18:   @override
19:   Future<void> saveHighestLevelReached(int level) async {
20:     await Future<void>.delayed(const Duration(milliseconds: 500));
21:     this.level = level;
22:   }
23: }
````

## File: samples/multiplayer/lib/player_progress/persistence/player_progress_persistence.dart
````dart
 1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: /// An interface of persistence stores for the player's progress.
 6: ///
 7: /// Implementations can range from simple in-memory storage through
 8: /// local preferences to cloud saves.
 9: abstract class PlayerProgressPersistence {
10:   Future<int> getHighestLevelReached();
11: 
12:   Future<void> saveHighestLevelReached(int level);
13: }
````

## File: samples/multiplayer/lib/player_progress/player_progress.dart
````dart
 1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: import 'dart:async';
 6: 
 7: import 'package:flutter/foundation.dart';
 8: 
 9: import 'persistence/local_storage_player_progress_persistence.dart';
10: import 'persistence/player_progress_persistence.dart';
11: 
12: /// Encapsulates the player's progress.
13: class PlayerProgress extends ChangeNotifier {
14:   static const maxHighestScoresPerPlayer = 10;
15: 
16:   /// By default, settings are persisted using
17:   /// [LocalStoragePlayerProgressPersistence] (i.e. NSUserDefaults on iOS,
18:   /// SharedPreferences on Android or local storage on the web).
19:   final PlayerProgressPersistence _store;
20: 
21:   int _highestLevelReached = 0;
22: 
23:   /// Creates an instance of [PlayerProgress] backed by an injected
24:   /// persistence [store].
25:   PlayerProgress({PlayerProgressPersistence? store})
26:       : _store = store ?? LocalStoragePlayerProgressPersistence() {
27:     _getLatestFromStore();
28:   }
29: 
30:   /// The highest level that the player has reached so far.
31:   int get highestLevelReached => _highestLevelReached;
32: 
33:   /// Resets the player's progress so it's like if they just started
34:   /// playing the game for the first time.
35:   void reset() {
36:     _highestLevelReached = 0;
37:     notifyListeners();
38:     _store.saveHighestLevelReached(_highestLevelReached);
39:   }
40: 
41:   /// Registers [level] as reached.
42:   ///
43:   /// If this is higher than [highestLevelReached], it will update that
44:   /// value and save it to the injected persistence store.
45:   void setLevelReached(int level) {
46:     if (level > _highestLevelReached) {
47:       _highestLevelReached = level;
48:       notifyListeners();
49: 
50:       unawaited(_store.saveHighestLevelReached(level));
51:     }
52:   }
53: 
54:   /// Fetches the latest data from the backing persistence store.
55:   Future<void> _getLatestFromStore() async {
56:     final level = await _store.getHighestLevelReached();
57:     if (level > _highestLevelReached) {
58:       _highestLevelReached = level;
59:       notifyListeners();
60:     } else if (level < _highestLevelReached) {
61:       await _store.saveHighestLevelReached(_highestLevelReached);
62:     }
63:   }
64: }
````

## File: samples/multiplayer/lib/settings/persistence/local_storage_settings_persistence.dart
````dart
 1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: import 'package:shared_preferences/shared_preferences.dart';
 6: 
 7: import 'settings_persistence.dart';
 8: 
 9: /// An implementation of [SettingsPersistence] that uses
10: /// `package:shared_preferences`.
11: class LocalStorageSettingsPersistence extends SettingsPersistence {
12:   final Future<SharedPreferences> instanceFuture =
13:       SharedPreferences.getInstance();
14: 
15:   @override
16:   Future<bool> getAudioOn({required bool defaultValue}) async {
17:     final prefs = await instanceFuture;
18:     return prefs.getBool('audioOn') ?? defaultValue;
19:   }
20: 
21:   @override
22:   Future<bool> getMusicOn({required bool defaultValue}) async {
23:     final prefs = await instanceFuture;
24:     return prefs.getBool('musicOn') ?? defaultValue;
25:   }
26: 
27:   @override
28:   Future<String> getPlayerName() async {
29:     final prefs = await instanceFuture;
30:     return prefs.getString('playerName') ?? 'Player';
31:   }
32: 
33:   @override
34:   Future<bool> getSoundsOn({required bool defaultValue}) async {
35:     final prefs = await instanceFuture;
36:     return prefs.getBool('soundsOn') ?? defaultValue;
37:   }
38: 
39:   @override
40:   Future<void> saveAudioOn(bool value) async {
41:     final prefs = await instanceFuture;
42:     await prefs.setBool('audioOn', value);
43:   }
44: 
45:   @override
46:   Future<void> saveMusicOn(bool value) async {
47:     final prefs = await instanceFuture;
48:     await prefs.setBool('musicOn', value);
49:   }
50: 
51:   @override
52:   Future<void> savePlayerName(String value) async {
53:     final prefs = await instanceFuture;
54:     await prefs.setString('playerName', value);
55:   }
56: 
57:   @override
58:   Future<void> saveSoundsOn(bool value) async {
59:     final prefs = await instanceFuture;
60:     await prefs.setBool('soundsOn', value);
61:   }
62: }
````

## File: samples/multiplayer/lib/settings/persistence/memory_settings_persistence.dart
````dart
 1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: import 'settings_persistence.dart';
 6: 
 7: /// An in-memory implementation of [SettingsPersistence].
 8: /// Useful for testing.
 9: class MemoryOnlySettingsPersistence implements SettingsPersistence {
10:   bool musicOn = true;
11: 
12:   bool soundsOn = true;
13: 
14:   bool audioOn = true;
15: 
16:   String playerName = 'Player';
17: 
18:   @override
19:   Future<bool> getAudioOn({required bool defaultValue}) async => audioOn;
20: 
21:   @override
22:   Future<bool> getMusicOn({required bool defaultValue}) async => musicOn;
23: 
24:   @override
25:   Future<String> getPlayerName() async => playerName;
26: 
27:   @override
28:   Future<bool> getSoundsOn({required bool defaultValue}) async => soundsOn;
29: 
30:   @override
31:   Future<void> saveAudioOn(bool value) async => audioOn = value;
32: 
33:   @override
34:   Future<void> saveMusicOn(bool value) async => musicOn = value;
35: 
36:   @override
37:   Future<void> savePlayerName(String value) async => playerName = value;
38: 
39:   @override
40:   Future<void> saveSoundsOn(bool value) async => soundsOn = value;
41: }
````

## File: samples/multiplayer/lib/settings/persistence/settings_persistence.dart
````dart
 1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: /// An interface of persistence stores for settings.
 6: ///
 7: /// Implementations can range from simple in-memory storage through
 8: /// local preferences to cloud-based solutions.
 9: abstract class SettingsPersistence {
10:   Future<bool> getAudioOn({required bool defaultValue});
11: 
12:   Future<bool> getMusicOn({required bool defaultValue});
13: 
14:   Future<String> getPlayerName();
15: 
16:   Future<bool> getSoundsOn({required bool defaultValue});
17: 
18:   Future<void> saveAudioOn(bool value);
19: 
20:   Future<void> saveMusicOn(bool value);
21: 
22:   Future<void> savePlayerName(String value);
23: 
24:   Future<void> saveSoundsOn(bool value);
25: }
````

## File: samples/multiplayer/lib/settings/custom_name_dialog.dart
````dart
 1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: import 'package:flutter/material.dart';
 6: import 'package:flutter/services.dart';
 7: import 'package:provider/provider.dart';
 8: 
 9: import 'settings.dart';
10: 
11: void showCustomNameDialog(BuildContext context) {
12:   showGeneralDialog(
13:       context: context,
14:       pageBuilder: (context, animation, secondaryAnimation) =>
15:           CustomNameDialog(animation: animation));
16: }
17: 
18: class CustomNameDialog extends StatefulWidget {
19:   final Animation<double> animation;
20: 
21:   const CustomNameDialog({required this.animation, super.key});
22: 
23:   @override
24:   State<CustomNameDialog> createState() => _CustomNameDialogState();
25: }
26: 
27: class _CustomNameDialogState extends State<CustomNameDialog> {
28:   final TextEditingController _controller = TextEditingController();
29: 
30:   @override
31:   Widget build(BuildContext context) {
32:     return ScaleTransition(
33:       scale: CurvedAnimation(
34:         parent: widget.animation,
35:         curve: Curves.easeOutCubic,
36:       ),
37:       child: SimpleDialog(
38:         title: const Text('Change name'),
39:         children: [
40:           TextField(
41:             controller: _controller,
42:             autofocus: true,
43:             maxLength: 12,
44:             maxLengthEnforcement: MaxLengthEnforcement.enforced,
45:             textAlign: TextAlign.center,
46:             textCapitalization: TextCapitalization.words,
47:             textInputAction: TextInputAction.done,
48:             onChanged: (value) {
49:               context.read<SettingsController>().setPlayerName(value);
50:             },
51:             onSubmitted: (value) {
52:               // Player tapped 'Submit'/'Done' on their keyboard.
53:               Navigator.pop(context);
54:             },
55:           ),
56:           TextButton(
57:             onPressed: () => Navigator.pop(context),
58:             child: const Text('Close'),
59:           ),
60:         ],
61:       ),
62:     );
63:   }
64: 
65:   @override
66:   void dispose() {
67:     _controller.dispose();
68:     super.dispose();
69:   }
70: 
71:   @override
72:   void initState() {
73:     super.initState();
74:     _controller.text = context.read<SettingsController>().playerName.value;
75:   }
76: }
````

## File: samples/multiplayer/lib/settings/settings_screen.dart
````dart
  1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
  2: // for details. All rights reserved. Use of this source code is governed by a
  3: // BSD-style license that can be found in the LICENSE file.
  4: 
  5: import 'package:flutter/material.dart';
  6: import 'package:go_router/go_router.dart';
  7: import 'package:provider/provider.dart';
  8: 
  9: import '../player_progress/player_progress.dart';
 10: import '../style/my_button.dart';
 11: import '../style/palette.dart';
 12: import '../style/responsive_screen.dart';
 13: import 'custom_name_dialog.dart';
 14: import 'settings.dart';
 15: 
 16: class SettingsScreen extends StatelessWidget {
 17:   const SettingsScreen({super.key});
 18: 
 19:   static const _gap = SizedBox(height: 60);
 20: 
 21:   @override
 22:   Widget build(BuildContext context) {
 23:     final settings = context.watch<SettingsController>();
 24:     final palette = context.watch<Palette>();
 25: 
 26:     return Scaffold(
 27:       backgroundColor: palette.backgroundSettings,
 28:       body: ResponsiveScreen(
 29:         squarishMainArea: ListView(
 30:           children: [
 31:             _gap,
 32:             const Text(
 33:               'Settings',
 34:               textAlign: TextAlign.center,
 35:               style: TextStyle(
 36:                 fontFamily: 'Permanent Marker',
 37:                 fontSize: 55,
 38:                 height: 1,
 39:               ),
 40:             ),
 41:             _gap,
 42:             const _NameChangeLine(
 43:               'Name',
 44:             ),
 45:             ValueListenableBuilder<bool>(
 46:               valueListenable: settings.soundsOn,
 47:               builder: (context, soundsOn, child) => _SettingsLine(
 48:                 'Sound FX',
 49:                 Icon(soundsOn ? Icons.graphic_eq : Icons.volume_off),
 50:                 onSelected: () => settings.toggleSoundsOn(),
 51:               ),
 52:             ),
 53:             ValueListenableBuilder<bool>(
 54:               valueListenable: settings.musicOn,
 55:               builder: (context, musicOn, child) => _SettingsLine(
 56:                 'Music',
 57:                 Icon(musicOn ? Icons.music_note : Icons.music_off),
 58:                 onSelected: () => settings.toggleMusicOn(),
 59:               ),
 60:             ),
 61:             _SettingsLine(
 62:               'Reset progress',
 63:               const Icon(Icons.delete),
 64:               onSelected: () {
 65:                 context.read<PlayerProgress>().reset();
 66: 
 67:                 final messenger = ScaffoldMessenger.of(context);
 68:                 messenger.showSnackBar(
 69:                   const SnackBar(
 70:                       content: Text('Player progress has been reset.')),
 71:                 );
 72:               },
 73:             ),
 74:             _gap,
 75:           ],
 76:         ),
 77:         rectangularMenuArea: MyButton(
 78:           onPressed: () {
 79:             GoRouter.of(context).pop();
 80:           },
 81:           child: const Text('Back'),
 82:         ),
 83:       ),
 84:     );
 85:   }
 86: }
 87: 
 88: class _NameChangeLine extends StatelessWidget {
 89:   final String title;
 90: 
 91:   const _NameChangeLine(this.title);
 92: 
 93:   @override
 94:   Widget build(BuildContext context) {
 95:     final settings = context.watch<SettingsController>();
 96: 
 97:     return InkResponse(
 98:       highlightShape: BoxShape.rectangle,
 99:       onTap: () => showCustomNameDialog(context),
100:       child: Padding(
101:         padding: const EdgeInsets.symmetric(horizontal: 8),
102:         child: Row(
103:           mainAxisAlignment: MainAxisAlignment.center,
104:           children: [
105:             Text(title,
106:                 style: const TextStyle(
107:                   fontFamily: 'Permanent Marker',
108:                   fontSize: 30,
109:                 )),
110:             const Spacer(),
111:             ValueListenableBuilder(
112:               valueListenable: settings.playerName,
113:               builder: (context, name, child) => Text(
114:                 '‘$name’',
115:                 style: const TextStyle(
116:                   fontFamily: 'Permanent Marker',
117:                   fontSize: 30,
118:                 ),
119:               ),
120:             ),
121:           ],
122:         ),
123:       ),
124:     );
125:   }
126: }
127: 
128: class _SettingsLine extends StatelessWidget {
129:   final String title;
130: 
131:   final Widget icon;
132: 
133:   final VoidCallback? onSelected;
134: 
135:   const _SettingsLine(this.title, this.icon, {this.onSelected});
136: 
137:   @override
138:   Widget build(BuildContext context) {
139:     return InkResponse(
140:       highlightShape: BoxShape.rectangle,
141:       onTap: onSelected,
142:       child: Padding(
143:         padding: const EdgeInsets.symmetric(horizontal: 8),
144:         child: Row(
145:           mainAxisAlignment: MainAxisAlignment.start,
146:           children: [
147:             Expanded(
148:               child: Text(
149:                 title,
150:                 maxLines: 1,
151:                 overflow: TextOverflow.ellipsis,
152:                 style: const TextStyle(
153:                   fontFamily: 'Permanent Marker',
154:                   fontSize: 30,
155:                 ),
156:               ),
157:             ),
158:             icon,
159:           ],
160:         ),
161:       ),
162:     );
163:   }
164: }
````

## File: samples/multiplayer/lib/settings/settings.dart
````dart
 1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: import 'package:flutter/foundation.dart';
 6: import 'package:logging/logging.dart';
 7: 
 8: import 'persistence/local_storage_settings_persistence.dart';
 9: import 'persistence/settings_persistence.dart';
10: 
11: /// An class that holds settings like [playerName] or [musicOn],
12: /// and saves them to an injected persistence store.
13: class SettingsController {
14:   static final _log = Logger('SettingsController');
15: 
16:   /// The persistence store that is used to save settings.
17:   final SettingsPersistence _store;
18: 
19:   /// Whether or not the audio is on at all. This overrides both music
20:   /// and sounds (sfx).
21:   ///
22:   /// This is an important feature especially on mobile, where players
23:   /// expect to be able to quickly mute all the audio. Having this as
24:   /// a separate flag (as opposed to some kind of {off, sound, everything}
25:   /// enum) means that the player will not lose their [soundsOn] and
26:   /// [musicOn] preferences when they temporarily mute the game.
27:   ValueNotifier<bool> audioOn = ValueNotifier(true);
28: 
29:   /// The player's name. Used for things like high score lists.
30:   ValueNotifier<String> playerName = ValueNotifier('Player');
31: 
32:   /// Whether or not the sound effects (sfx) are on.
33:   ValueNotifier<bool> soundsOn = ValueNotifier(true);
34: 
35:   /// Whether or not the music is on.
36:   ValueNotifier<bool> musicOn = ValueNotifier(true);
37: 
38:   /// Creates a new instance of [SettingsController] backed by [store].
39:   ///
40:   /// By default, settings are persisted using [LocalStorageSettingsPersistence]
41:   /// (i.e. NSUserDefaults on iOS, SharedPreferences on Android or
42:   /// local storage on the web).
43:   SettingsController({SettingsPersistence? store})
44:       : _store = store ?? LocalStorageSettingsPersistence() {
45:     _loadStateFromPersistence();
46:   }
47: 
48:   void setPlayerName(String name) {
49:     playerName.value = name;
50:     _store.savePlayerName(playerName.value);
51:   }
52: 
53:   void toggleAudioOn() {
54:     audioOn.value = !audioOn.value;
55:     _store.saveAudioOn(audioOn.value);
56:   }
57: 
58:   void toggleMusicOn() {
59:     musicOn.value = !musicOn.value;
60:     _store.saveMusicOn(musicOn.value);
61:   }
62: 
63:   void toggleSoundsOn() {
64:     soundsOn.value = !soundsOn.value;
65:     _store.saveSoundsOn(soundsOn.value);
66:   }
67: 
68:   /// Asynchronously loads values from the injected persistence store.
69:   Future<void> _loadStateFromPersistence() async {
70:     final loadedValues = await Future.wait([
71:       _store.getAudioOn(defaultValue: true).then((value) {
72:         if (kIsWeb) {
73:           // On the web, sound can only start after user interaction, so
74:           // we start muted there on every game start.
75:           return audioOn.value = false;
76:         }
77:         // On other platforms, we can use the persisted value.
78:         return audioOn.value = value;
79:       }),
80:       _store
81:           .getSoundsOn(defaultValue: true)
82:           .then((value) => soundsOn.value = value),
83:       _store
84:           .getMusicOn(defaultValue: true)
85:           .then((value) => musicOn.value = value),
86:       _store.getPlayerName().then((value) => playerName.value = value),
87:     ]);
88: 
89:     _log.fine(() => 'Loaded settings: $loadedValues');
90:   }
91: }
````

## File: samples/multiplayer/lib/style/confetti.dart
````dart
  1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
  2: // for details. All rights reserved. Use of this source code is governed by a
  3: // BSD-style license that can be found in the LICENSE file.
  4: 
  5: import 'dart:collection';
  6: import 'dart:math';
  7: 
  8: import 'package:flutter/widgets.dart';
  9: 
 10: /// Shows a confetti (celebratory) animation: paper snippings falling down.
 11: ///
 12: /// The widget fills the available space (like [SizedBox.expand] would).
 13: ///
 14: /// When [isStopped] is `true`, the animation will not run. This is useful
 15: /// when the widget is not visible yet, for example. Provide [colors]
 16: /// to make the animation look good in context.
 17: ///
 18: /// This is a partial port of this CodePen by Hemn Chawroka:
 19: /// https://codepen.io/iprodev/pen/azpWBr
 20: class Confetti extends StatefulWidget {
 21:   static const _defaultColors = [
 22:     Color(0xffd10841),
 23:     Color(0xff1d75fb),
 24:     Color(0xff0050bc),
 25:     Color(0xffa2dcc7),
 26:   ];
 27: 
 28:   final bool isStopped;
 29: 
 30:   final List<Color> colors;
 31: 
 32:   const Confetti({
 33:     this.colors = _defaultColors,
 34:     this.isStopped = false,
 35:     super.key,
 36:   });
 37: 
 38:   @override
 39:   State<Confetti> createState() => _ConfettiState();
 40: }
 41: 
 42: class ConfettiPainter extends CustomPainter {
 43:   final defaultPaint = Paint();
 44: 
 45:   final int snippingsCount = 200;
 46: 
 47:   late final List<_PaperSnipping> _snippings;
 48: 
 49:   Size? _size;
 50: 
 51:   DateTime _lastTime = DateTime.now();
 52: 
 53:   final UnmodifiableListView<Color> colors;
 54: 
 55:   ConfettiPainter(
 56:       {required Listenable animation, required Iterable<Color> colors})
 57:       : colors = UnmodifiableListView(colors),
 58:         super(repaint: animation);
 59: 
 60:   @override
 61:   void paint(Canvas canvas, Size size) {
 62:     if (_size == null) {
 63:       // First time we have a size.
 64:       _snippings = List.generate(
 65:           snippingsCount,
 66:           (i) => _PaperSnipping(
 67:                 frontColor: colors[i % colors.length],
 68:                 bounds: size,
 69:               ));
 70:     }
 71: 
 72:     final didResize = _size != null && _size != size;
 73:     final now = DateTime.now();
 74:     final dt = now.difference(_lastTime);
 75:     for (final snipping in _snippings) {
 76:       if (didResize) {
 77:         snipping.updateBounds(size);
 78:       }
 79:       snipping.update(dt.inMilliseconds / 1000);
 80:       snipping.draw(canvas);
 81:     }
 82: 
 83:     _size = size;
 84:     _lastTime = now;
 85:   }
 86: 
 87:   @override
 88:   bool shouldRepaint(covariant CustomPainter oldDelegate) {
 89:     return true;
 90:   }
 91: }
 92: 
 93: class _ConfettiState extends State<Confetti>
 94:     with SingleTickerProviderStateMixin {
 95:   late AnimationController _controller;
 96: 
 97:   @override
 98:   Widget build(BuildContext context) {
 99:     return CustomPaint(
100:       painter: ConfettiPainter(
101:         colors: widget.colors,
102:         animation: _controller,
103:       ),
104:       willChange: true,
105:       child: const SizedBox.expand(),
106:     );
107:   }
108: 
109:   @override
110:   void didUpdateWidget(covariant Confetti oldWidget) {
111:     super.didUpdateWidget(oldWidget);
112:     if (oldWidget.isStopped && !widget.isStopped) {
113:       _controller.repeat();
114:     } else if (!oldWidget.isStopped && widget.isStopped) {
115:       _controller.stop(canceled: false);
116:     }
117:   }
118: 
119:   @override
120:   void dispose() {
121:     _controller.dispose();
122:     super.dispose();
123:   }
124: 
125:   @override
126:   void initState() {
127:     super.initState();
128:     _controller = AnimationController(
129:       // We don't really care about the duration, since we're going to
130:       // use the controller on loop anyway.
131:       duration: const Duration(seconds: 1),
132:       vsync: this,
133:     );
134: 
135:     if (!widget.isStopped) {
136:       _controller.repeat();
137:     }
138:   }
139: }
140: 
141: class _PaperSnipping {
142:   static final Random _random = Random();
143: 
144:   static const degToRad = pi / 180;
145: 
146:   static const backSideBlend = Color(0x70EEEEEE);
147: 
148:   Size _bounds;
149: 
150:   late final _Vector position = _Vector(
151:     _random.nextDouble() * _bounds.width,
152:     _random.nextDouble() * _bounds.height,
153:   );
154: 
155:   final double rotationSpeed = 800 + _random.nextDouble() * 600;
156: 
157:   final double angle = _random.nextDouble() * 360 * degToRad;
158: 
159:   double rotation = _random.nextDouble() * 360 * degToRad;
160: 
161:   double cosA = 1.0;
162: 
163:   final double size = 7.0;
164: 
165:   final double oscillationSpeed = 0.5 + _random.nextDouble() * 1.5;
166: 
167:   final double xSpeed = 40;
168: 
169:   final double ySpeed = 50 + _random.nextDouble() * 60;
170: 
171:   late List<_Vector> corners = List.generate(4, (i) {
172:     final angle = this.angle + degToRad * (45 + i * 90);
173:     return _Vector(cos(angle), sin(angle));
174:   });
175: 
176:   double time = _random.nextDouble();
177: 
178:   final Color frontColor;
179: 
180:   late final Color backColor = Color.alphaBlend(backSideBlend, frontColor);
181: 
182:   final paint = Paint()..style = PaintingStyle.fill;
183: 
184:   _PaperSnipping({
185:     required this.frontColor,
186:     required Size bounds,
187:   }) : _bounds = bounds;
188: 
189:   void draw(Canvas canvas) {
190:     if (cosA > 0) {
191:       paint.color = frontColor;
192:     } else {
193:       paint.color = backColor;
194:     }
195: 
196:     final path = Path()
197:       ..addPolygon(
198:         List.generate(
199:             4,
200:             (index) => Offset(
201:                   position.x + corners[index].x * size,
202:                   position.y + corners[index].y * size * cosA,
203:                 )),
204:         true,
205:       );
206:     canvas.drawPath(path, paint);
207:   }
208: 
209:   void update(double dt) {
210:     time += dt;
211:     rotation += rotationSpeed * dt;
212:     cosA = cos(degToRad * rotation);
213:     position.x += cos(time * oscillationSpeed) * xSpeed * dt;
214:     position.y += ySpeed * dt;
215:     if (position.y > _bounds.height) {
216:       // Move the snipping back to the top.
217:       position.x = _random.nextDouble() * _bounds.width;
218:       position.y = 0;
219:     }
220:   }
221: 
222:   void updateBounds(Size newBounds) {
223:     if (!newBounds.contains(Offset(position.x, position.y))) {
224:       position.x = _random.nextDouble() * newBounds.width;
225:       position.y = _random.nextDouble() * newBounds.height;
226:     }
227:     _bounds = newBounds;
228:   }
229: }
230: 
231: class _Vector {
232:   double x, y;
233:   _Vector(this.x, this.y);
234: }
````

## File: samples/multiplayer/lib/style/my_button.dart
````dart
 1: // Copyright 2023, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: import 'dart:math';
 6: 
 7: import 'package:flutter/material.dart';
 8: 
 9: class MyButton extends StatefulWidget {
10:   final Widget child;
11: 
12:   final VoidCallback? onPressed;
13: 
14:   const MyButton({super.key, required this.child, this.onPressed});
15: 
16:   @override
17:   State<MyButton> createState() => _MyButtonState();
18: }
19: 
20: class _MyButtonState extends State<MyButton>
21:     with SingleTickerProviderStateMixin {
22:   late final AnimationController _controller = AnimationController(
23:     duration: const Duration(milliseconds: 300),
24:     vsync: this,
25:   );
26: 
27:   @override
28:   void dispose() {
29:     _controller.dispose();
30:     super.dispose();
31:   }
32: 
33:   @override
34:   Widget build(BuildContext context) {
35:     return MouseRegion(
36:       onEnter: (event) {
37:         _controller.repeat();
38:       },
39:       onExit: (event) {
40:         _controller.stop(canceled: false);
41:       },
42:       child: RotationTransition(
43:         turns: _controller.drive(const _MySineTween(0.005)),
44:         child: FilledButton(
45:           onPressed: widget.onPressed,
46:           child: widget.child,
47:         ),
48:       ),
49:     );
50:   }
51: }
52: 
53: class _MySineTween extends Animatable<double> {
54:   final double maxExtent;
55: 
56:   const _MySineTween(this.maxExtent);
57: 
58:   @override
59:   double transform(double t) {
60:     return sin(t * 2 * pi) * maxExtent;
61:   }
62: }
````

## File: samples/multiplayer/lib/style/my_transition.dart
````dart
 1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: import 'package:flutter/material.dart';
 6: import 'package:go_router/go_router.dart';
 7: 
 8: CustomTransitionPage<T> buildMyTransition<T>({
 9:   required Widget child,
10:   required Color color,
11:   String? name,
12:   Object? arguments,
13:   String? restorationId,
14:   LocalKey? key,
15: }) {
16:   return CustomTransitionPage<T>(
17:     child: child,
18:     transitionsBuilder: (context, animation, secondaryAnimation, child) {
19:       return _MyReveal(
20:         animation: animation,
21:         color: color,
22:         child: child,
23:       );
24:     },
25:     key: key,
26:     name: name,
27:     arguments: arguments,
28:     restorationId: restorationId,
29:     transitionDuration: const Duration(milliseconds: 700),
30:   );
31: }
32: 
33: class _MyReveal extends StatelessWidget {
34:   final Widget child;
35: 
36:   final Animation<double> animation;
37: 
38:   final Color color;
39: 
40:   final _slideTween = Tween(begin: const Offset(0, -1), end: Offset.zero);
41: 
42:   final _fadeTween = TweenSequence([
43:     TweenSequenceItem(tween: ConstantTween(0.0), weight: 1),
44:     TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0), weight: 1),
45:   ]);
46: 
47:   _MyReveal({
48:     required this.child,
49:     required this.animation,
50:     required this.color,
51:   });
52: 
53:   @override
54:   Widget build(BuildContext context) {
55:     return Stack(
56:       fit: StackFit.expand,
57:       children: [
58:         SlideTransition(
59:           position: _slideTween.animate(
60:             CurvedAnimation(
61:               parent: animation,
62:               curve: Curves.easeOutCubic,
63:               reverseCurve: Curves.easeOutCubic,
64:             ),
65:           ),
66:           child: Container(
67:             color: color,
68:           ),
69:         ),
70:         FadeTransition(
71:           opacity: _fadeTween.animate(animation),
72:           child: child,
73:         ),
74:       ],
75:     );
76:   }
77: }
````

## File: samples/multiplayer/lib/style/palette.dart
````dart
 1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: import 'package:flutter/material.dart';
 6: 
 7: /// A palette of colors to be used in the game.
 8: ///
 9: /// The reason we're not going with something like Material Design's
10: /// `Theme` is simply that this is simpler to work with and yet gives
11: /// us everything we need for a game.
12: ///
13: /// Games generally have more radical color palettes than apps. For example,
14: /// every level of a game can have radically different colors.
15: /// At the same time, games rarely support dark mode.
16: ///
17: /// Colors taken from this fun palette:
18: /// https://lospec.com/palette-list/crayola84
19: ///
20: /// Colors here are implemented as getters so that hot reloading works.
21: /// In practice, we could just as easily implement the colors
22: /// as `static const`. But this way the palette is more malleable:
23: /// we could allow players to customize colors, for example,
24: /// or even get the colors from the network.
25: class Palette {
26:   Color get pen => const Color(0xff1d75fb);
27:   Color get darkPen => const Color(0xFF0050bc);
28:   Color get redPen => const Color(0xFFd10841);
29:   Color get inkFullOpacity => const Color(0xff352b42);
30:   Color get ink => const Color(0xee352b42);
31:   Color get accept => const Color(0xff15a44d);
32:   Color get backgroundMain => const Color(0xffffd7ff);
33:   Color get backgroundLevelSelection => const Color(0xffa2dcc7);
34:   Color get backgroundPlaySession => const Color(0xffffebb5);
35:   Color get background4 => const Color(0xffffffd1);
36:   Color get backgroundSettings => const Color(0xffbfc8e3);
37:   Color get trueWhite => const Color(0xffffffff);
38: }
````

## File: samples/multiplayer/lib/style/responsive_screen.dart
````dart
  1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
  2: // for details. All rights reserved. Use of this source code is governed by a
  3: // BSD-style license that can be found in the LICENSE file.
  4: 
  5: import 'package:flutter/material.dart';
  6: 
  7: /// A widget that makes it easy to create a screen with a square-ish
  8: /// main area, a smaller menu area, and a small area for a message on top.
  9: /// It works in both orientations on mobile- and tablet-sized screens.
 10: class ResponsiveScreen extends StatelessWidget {
 11:   /// This is the "hero" of the screen. It's more or less square, and will
 12:   /// be placed in the visual "center" of the screen.
 13:   final Widget squarishMainArea;
 14: 
 15:   /// The second-largest area after [squarishMainArea]. It can be narrow
 16:   /// or wide.
 17:   final Widget rectangularMenuArea;
 18: 
 19:   /// An area reserved for some static text close to the top of the screen.
 20:   final Widget topMessageArea;
 21: 
 22:   const ResponsiveScreen({
 23:     required this.squarishMainArea,
 24:     required this.rectangularMenuArea,
 25:     this.topMessageArea = const SizedBox.shrink(),
 26:     super.key,
 27:   });
 28: 
 29:   @override
 30:   Widget build(BuildContext context) {
 31:     return LayoutBuilder(
 32:       builder: (context, constraints) {
 33:         // This widget wants to fill the whole screen.
 34:         final size = constraints.biggest;
 35:         final padding = EdgeInsets.all(size.shortestSide / 30);
 36: 
 37:         if (size.height >= size.width) {
 38:           // "Portrait" / "mobile" mode.
 39:           return Column(
 40:             crossAxisAlignment: CrossAxisAlignment.stretch,
 41:             children: [
 42:               SafeArea(
 43:                 bottom: false,
 44:                 child: Padding(
 45:                   padding: padding,
 46:                   child: topMessageArea,
 47:                 ),
 48:               ),
 49:               Expanded(
 50:                 child: SafeArea(
 51:                   top: false,
 52:                   bottom: false,
 53:                   minimum: padding,
 54:                   child: squarishMainArea,
 55:                 ),
 56:               ),
 57:               SafeArea(
 58:                 top: false,
 59:                 maintainBottomViewPadding: true,
 60:                 child: Padding(
 61:                   padding: padding,
 62:                   child: Center(
 63:                     child: rectangularMenuArea,
 64:                   ),
 65:                 ),
 66:               ),
 67:             ],
 68:           );
 69:         } else {
 70:           // "Landscape" / "tablet" mode.
 71:           final isLarge = size.width > 900;
 72: 
 73:           return Row(
 74:             crossAxisAlignment: CrossAxisAlignment.stretch,
 75:             children: [
 76:               Expanded(
 77:                 flex: isLarge ? 7 : 5,
 78:                 child: SafeArea(
 79:                   right: false,
 80:                   maintainBottomViewPadding: true,
 81:                   minimum: padding,
 82:                   child: squarishMainArea,
 83:                 ),
 84:               ),
 85:               Expanded(
 86:                 flex: 3,
 87:                 child: Column(
 88:                   children: [
 89:                     SafeArea(
 90:                       bottom: false,
 91:                       left: false,
 92:                       maintainBottomViewPadding: true,
 93:                       child: Padding(
 94:                         padding: padding,
 95:                         child: topMessageArea,
 96:                       ),
 97:                     ),
 98:                     Expanded(
 99:                       child: SafeArea(
100:                         top: false,
101:                         left: false,
102:                         maintainBottomViewPadding: true,
103:                         child: Align(
104:                           alignment: Alignment.bottomCenter,
105:                           child: Padding(
106:                             padding: padding,
107:                             child: rectangularMenuArea,
108:                           ),
109:                         ),
110:                       ),
111:                     )
112:                   ],
113:                 ),
114:               ),
115:             ],
116:           );
117:         }
118:       },
119:     );
120:   }
121: }
````

## File: samples/multiplayer/lib/win_game/win_game_screen.dart
````dart
 1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: import 'package:flutter/material.dart';
 6: import 'package:go_router/go_router.dart';
 7: import 'package:provider/provider.dart';
 8: 
 9: import '../game_internals/score.dart';
10: import '../style/my_button.dart';
11: import '../style/palette.dart';
12: import '../style/responsive_screen.dart';
13: 
14: class WinGameScreen extends StatelessWidget {
15:   final Score score;
16: 
17:   const WinGameScreen({
18:     super.key,
19:     required this.score,
20:   });
21: 
22:   @override
23:   Widget build(BuildContext context) {
24:     final palette = context.watch<Palette>();
25: 
26:     const gap = SizedBox(height: 10);
27: 
28:     return Scaffold(
29:       backgroundColor: palette.backgroundPlaySession,
30:       body: ResponsiveScreen(
31:         squarishMainArea: Column(
32:           mainAxisAlignment: MainAxisAlignment.center,
33:           children: <Widget>[
34:             gap,
35:             const Center(
36:               child: Text(
37:                 'You won!',
38:                 style: TextStyle(fontFamily: 'Permanent Marker', fontSize: 50),
39:               ),
40:             ),
41:             gap,
42:             Center(
43:               child: Text(
44:                 'Score: ${score.score}\n'
45:                 'Time: ${score.formattedTime}',
46:                 style: const TextStyle(
47:                     fontFamily: 'Permanent Marker', fontSize: 20),
48:               ),
49:             ),
50:           ],
51:         ),
52:         rectangularMenuArea: MyButton(
53:           onPressed: () {
54:             GoRouter.of(context).go('/');
55:           },
56:           child: const Text('Continue'),
57:         ),
58:       ),
59:     );
60:   }
61: }
````

## File: samples/multiplayer/lib/firebase_options.dart
````dart
 1: // File generated by FlutterFire CLI.
 2: // ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
 3: import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
 4: import 'package:flutter/foundation.dart'
 5:     show defaultTargetPlatform, kIsWeb, TargetPlatform;
 6: 
 7: /// Default [FirebaseOptions] for use with your Firebase apps.
 8: ///
 9: /// Example:
10: /// ```dart
11: /// import 'firebase_options.dart';
12: /// // ...
13: /// await Firebase.initializeApp(
14: ///   options: DefaultFirebaseOptions.currentPlatform,
15: /// );
16: /// ```
17: class DefaultFirebaseOptions {
18:   static FirebaseOptions get currentPlatform {
19:     if (kIsWeb) {
20:       return web;
21:     }
22:     switch (defaultTargetPlatform) {
23:       case TargetPlatform.android:
24:         return android;
25:       case TargetPlatform.iOS:
26:         return ios;
27:       case TargetPlatform.macOS:
28:         return macos;
29:       case TargetPlatform.windows:
30:         throw UnsupportedError(
31:           'DefaultFirebaseOptions have not been configured for windows - '
32:           'you can reconfigure this by running the FlutterFire CLI again.',
33:         );
34:       case TargetPlatform.linux:
35:         throw UnsupportedError(
36:           'DefaultFirebaseOptions have not been configured for linux - '
37:           'you can reconfigure this by running the FlutterFire CLI again.',
38:         );
39:       default:
40:         throw UnsupportedError(
41:           'DefaultFirebaseOptions are not supported for this platform.',
42:         );
43:     }
44:   }
45: 
46:   static const FirebaseOptions web = FirebaseOptions(
47:     apiKey: 'AIzaSyCqtOUMCYmxzC5bBDJGUqe4nNbcsZYxHgQ',
48:     appId: '1:279016704934:web:a659939a71c4c69e10dd67',
49:     messagingSenderId: '279016704934',
50:     projectId: 'card-game-eea6d',
51:     authDomain: 'card-game-eea6d.firebaseapp.com',
52:     storageBucket: 'card-game-eea6d.appspot.com',
53:   );
54: 
55:   static const FirebaseOptions android = FirebaseOptions(
56:     apiKey: 'AIzaSyBj32JbbKHD2UgP8aoQRuEjkexEUzR1hXE',
57:     appId: '1:279016704934:android:88be1397c39d5ae110dd67',
58:     messagingSenderId: '279016704934',
59:     projectId: 'card-game-eea6d',
60:     storageBucket: 'card-game-eea6d.appspot.com',
61:   );
62: 
63:   static const FirebaseOptions ios = FirebaseOptions(
64:     apiKey: 'AIzaSyD6KsB6n5jsvLf2apddzFIoo2ZPbbwMbdk',
65:     appId: '1:279016704934:ios:3ea782755a91ada110dd67',
66:     messagingSenderId: '279016704934',
67:     projectId: 'card-game-eea6d',
68:     storageBucket: 'card-game-eea6d.appspot.com',
69:     iosBundleId: 'com.example.card',
70:   );
71: 
72:   static const FirebaseOptions macos = FirebaseOptions(
73:     apiKey: 'AIzaSyD6KsB6n5jsvLf2apddzFIoo2ZPbbwMbdk',
74:     appId: '1:279016704934:ios:faac0650d42695f210dd67',
75:     messagingSenderId: '279016704934',
76:     projectId: 'card-game-eea6d',
77:     storageBucket: 'card-game-eea6d.appspot.com',
78:     iosBundleId: 'com.example.card.RunnerTests',
79:   );
80: }
````

## File: samples/multiplayer/lib/main.dart
````dart
  1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
  2: // for details. All rights reserved. Use of this source code is governed by a
  3: // BSD-style license that can be found in the LICENSE file.
  4: 
  5: import 'dart:developer' as dev;
  6: 
  7: import 'package:cloud_firestore/cloud_firestore.dart';
  8: import 'package:firebase_core/firebase_core.dart';
  9: import 'package:flutter/foundation.dart';
 10: import 'package:flutter/material.dart';
 11: import 'package:flutter/services.dart';
 12: import 'package:logging/logging.dart';
 13: import 'package:provider/provider.dart';
 14: 
 15: import 'app_lifecycle/app_lifecycle.dart';
 16: import 'audio/audio_controller.dart';
 17: import 'firebase_options.dart';
 18: import 'player_progress/player_progress.dart';
 19: import 'router.dart';
 20: import 'settings/settings.dart';
 21: import 'style/palette.dart';
 22: 
 23: void main() async {
 24:   // Basic logging setup.
 25:   Logger.root.level = kDebugMode ? Level.FINE : Level.INFO;
 26:   Logger.root.onRecord.listen((record) {
 27:     dev.log(
 28:       record.message,
 29:       time: record.time,
 30:       level: record.level.value,
 31:       name: record.loggerName,
 32:     );
 33:   });
 34: 
 35:   WidgetsFlutterBinding.ensureInitialized();
 36:   // Put game into full screen mode on mobile devices.
 37:   await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
 38:   // Lock the game to portrait mode on mobile devices.
 39:   await SystemChrome.setPreferredOrientations([
 40:     DeviceOrientation.portraitUp,
 41:     DeviceOrientation.portraitDown,
 42:   ]);
 43: 
 44:   await Firebase.initializeApp(
 45:     options: DefaultFirebaseOptions.currentPlatform,
 46:   );
 47: 
 48:   runApp(
 49:     Provider.value(
 50:       value: FirebaseFirestore.instance,
 51:       child: const MyApp(),
 52:     ),
 53:   );
 54: }
 55: 
 56: class MyApp extends StatelessWidget {
 57:   const MyApp({super.key});
 58: 
 59:   @override
 60:   Widget build(BuildContext context) {
 61:     return AppLifecycleObserver(
 62:       child: MultiProvider(
 63:         // This is where you add objects that you want to have available
 64:         // throughout your game.
 65:         //
 66:         // Every widget in the game can access these objects by calling
 67:         // `context.watch()` or `context.read()`.
 68:         // See `lib/main_menu/main_menu_screen.dart` for example usage.
 69:         providers: [
 70:           Provider(create: (context) => SettingsController()),
 71:           Provider(create: (context) => Palette()),
 72:           ChangeNotifierProvider(create: (context) => PlayerProgress()),
 73:           // Set up audio.
 74:           ProxyProvider2<AppLifecycleStateNotifier, SettingsController,
 75:               AudioController>(
 76:             create: (context) => AudioController(),
 77:             update: (context, lifecycleNotifier, settings, audio) {
 78:               audio!.attachDependencies(lifecycleNotifier, settings);
 79:               return audio;
 80:             },
 81:             dispose: (context, audio) => audio.dispose(),
 82:             // Ensures that music starts immediately.
 83:             lazy: false,
 84:           ),
 85:         ],
 86:         child: Builder(builder: (context) {
 87:           final palette = context.watch<Palette>();
 88: 
 89:           return MaterialApp.router(
 90:             title: 'My Flutter Game',
 91:             theme: ThemeData.from(
 92:               colorScheme: ColorScheme.fromSeed(
 93:                 seedColor: palette.darkPen,
 94:                 surface: palette.backgroundMain,
 95:               ),
 96:               textTheme: TextTheme(
 97:                 bodyMedium: TextStyle(color: palette.ink),
 98:               ),
 99:               useMaterial3: true,
100:             ).copyWith(
101:               // Make buttons more fun.
102:               filledButtonTheme: FilledButtonThemeData(
103:                 style: FilledButton.styleFrom(
104:                   textStyle: const TextStyle(
105:                     fontWeight: FontWeight.bold,
106:                     fontSize: 20,
107:                   ),
108:                 ),
109:               ),
110:             ),
111:             routeInformationProvider: router.routeInformationProvider,
112:             routeInformationParser: router.routeInformationParser,
113:             routerDelegate: router.routerDelegate,
114:           );
115:         }),
116:       ),
117:     );
118:   }
119: }
````

## File: samples/multiplayer/lib/router.dart
````dart
 1: // Copyright 2023, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: import 'package:flutter/foundation.dart';
 6: import 'package:go_router/go_router.dart';
 7: import 'package:provider/provider.dart';
 8: 
 9: import 'game_internals/score.dart';
10: import 'main_menu/main_menu_screen.dart';
11: import 'play_session/play_session_screen.dart';
12: import 'settings/settings_screen.dart';
13: import 'style/my_transition.dart';
14: import 'style/palette.dart';
15: import 'win_game/win_game_screen.dart';
16: 
17: /// The router describes the game's navigational hierarchy, from the main
18: /// screen through settings screens all the way to each individual level.
19: final router = GoRouter(
20:   routes: [
21:     GoRoute(
22:       path: '/',
23:       builder: (context, state) => const MainMenuScreen(key: Key('main menu')),
24:       routes: [
25:         GoRoute(
26:           path: 'play',
27:           pageBuilder: (context, state) => buildMyTransition<void>(
28:             key: const ValueKey('play'),
29:             color: context.watch<Palette>().backgroundPlaySession,
30:             child: const PlaySessionScreen(
31:               key: Key('level selection'),
32:             ),
33:           ),
34:           routes: [
35:             GoRoute(
36:               path: 'won',
37:               redirect: (context, state) {
38:                 if (state.extra == null) {
39:                   // Trying to navigate to a win screen without any data.
40:                   // Possibly by using the browser's back button.
41:                   return '/';
42:                 }
43: 
44:                 // Otherwise, do not redirect.
45:                 return null;
46:               },
47:               pageBuilder: (context, state) {
48:                 final map = state.extra! as Map<String, dynamic>;
49:                 final score = map['score'] as Score;
50: 
51:                 return buildMyTransition<void>(
52:                   key: const ValueKey('won'),
53:                   color: context.watch<Palette>().backgroundPlaySession,
54:                   child: WinGameScreen(
55:                     score: score,
56:                     key: const Key('win game'),
57:                   ),
58:                 );
59:               },
60:             )
61:           ],
62:         ),
63:         GoRoute(
64:           path: 'settings',
65:           builder: (context, state) =>
66:               const SettingsScreen(key: Key('settings')),
67:         ),
68:       ],
69:     ),
70:   ],
71: );
````

## File: samples/multiplayer/test/smoke_test.dart
````dart
 1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: import 'package:flutter_test/flutter_test.dart';
 6: import 'package:multiplayer/main.dart';
 7: import 'package:multiplayer/play_session/playing_card_widget.dart';
 8: 
 9: void main() {
10:   testWidgets('smoke test', (tester) async {
11:     // Build our game and trigger a frame.
12:     await tester.pumpWidget(MyApp());
13: 
14:     // Verify that the 'Play' button is shown.
15:     expect(find.text('Play'), findsOneWidget);
16: 
17:     // Verify that the 'Settings' button is shown.
18:     expect(find.text('Settings'), findsOneWidget);
19: 
20:     // Go to 'Settings'.
21:     await tester.tap(find.text('Settings'));
22:     await tester.pumpAndSettle();
23:     expect(find.text('Music'), findsOneWidget);
24: 
25:     // Go back to main menu.
26:     await tester.tap(find.text('Back'));
27:     await tester.pumpAndSettle();
28: 
29:     // Tap 'Play'.
30:     await tester.tap(find.text('Play'));
31:     await tester.pumpAndSettle();
32:     expect(find.byType(PlayingCardWidget), findsWidgets);
33: 
34:     // Tap 'Back'.
35:     await tester.tap(find.text('Back'));
36:     await tester.pumpAndSettle();
37: 
38:     // Verify we're back on the homepage.
39:     expect(find.text('Play'), findsOneWidget);
40:   });
41: }
````

## File: samples/multiplayer/analysis_options.yaml
````yaml
 1: include: package:flutter_lints/flutter.yaml
 2: 
 3: analyzer:
 4:   language:
 5:     strict-casts: true
 6: 
 7: linter:
 8:   rules:
 9:     # Remove or force lint rules by adding lines like the following.
10:     # The lints below are disabled in order to make things smoother in early
11:     # development. Consider enabling them once development is further along.
12:     prefer_const_constructors: false  # Annoying in early development
13:     prefer_single_quotes: false  # Annoying in early development
````

## File: samples/multiplayer/pubspec.yaml
````yaml
 1: name: multiplayer
 2: description: A game with basic multiplayer support.
 3: 
 4: # Prevent accidental publishing to pub.dev.
 5: publish_to: 'none'
 6: 
 7: version: 0.0.1+1
 8: 
 9: environment:
10:   sdk: ^3.5.0
11: 
12: dependencies:
13:   flutter:
14:     sdk: flutter
15: 
16:   async: ^2.11.0
17:   audioplayers: ^6.0.0
18:   cloud_firestore: ^4.17.3
19:   firebase_core: ^2.31.0
20:   go_router: ^14.0.0
21:   logging: ^1.2.0
22:   provider: ^6.1.2
23:   shared_preferences: ^2.2.3
24: 
25: dev_dependencies:
26:   flutter_lints: ^5.0.0
27:   flutter_test:
28:     sdk: flutter
29:   flutter_launcher_icons: ^0.13.1
30:   test: ^1.24.3
31: 
32: flutter:
33:   uses-material-design: true
34: 
35:   assets:
36:     - assets/images/
37:     - assets/music/
38:     - assets/sfx/
39: 
40:   fonts:
41:     - family: Permanent Marker
42:       fonts:
43:         - asset: assets/fonts/Permanent_Marker/PermanentMarker-Regular.ttf
44: 
45: flutter_launcher_icons:
46:   android: true
47:   ios: true
48:   image_path: "assets/icons/icon.png"
49:   adaptive_icon_background: "#FFFFFF"
50:   adaptive_icon_foreground: "assets/icons/icon-adaptive-foreground.png"
````

## File: samples/multiplayer/README.md
````markdown
 1: A sample project based on the
 2: [`card` template](https://github.com/flutter/games/tree/main/templates/card)
 3: that adds multiplayer functionality through Firebase's
 4: [Cloud Firestore](https://firebase.google.com/docs/firestore).
 5: 
 6: Read about adding multiplayer to your mobile game
 7: in this cookbook recipe:
 8: 
 9: https://flutter.dev/cookbook/games/firestore-multiplayer/
10: 
11: **Warning:** This sample will only work for you _after_ you install
12: Firestore and run `flutterfire configure`. 
13: Please do read the cookbook recipe above.
14: 
15: 
16: ## How to get this sample
17: 
18: You can clone this whole repository and find this sample in your local copy.
19: 
20: For convenience, though, we also provide a command line tool that downloads
21: just the project you want.
22: 
23: On the command line, while having the
24: [Flutter SDK installed](https://docs.flutter.dev/get-started/install),
25: run the following command:
26: 
27: ```shell
28: dart pub global activate sample_downloader
29: ```
30: 
31: Then, from any directory, run the newly installed tool
32: and follow its instructions.
33: 
34: ```shell
35: sample_downloader
36: ```
````

## File: templates/basic/assets/music/README.md
````markdown
1: Music in the template is by Mr Smith, and licensed under Creative Commons
2: Attribution 4.0 International (CC BY 4.0).
3: 
4: https://freemusicarchive.org/music/mr-smith
5: 
6: Mr Smith's music is used in this template project with his explicit permission.
````

## File: templates/basic/assets/sfx/README.md
````markdown
1: Sounds in this folder are made by Filip Hracek and are CC0 (Public Domain).
````

## File: templates/basic/ios/Runner/Assets.xcassets/LaunchImage.imageset/README.md
````markdown
1: # Launch Screen Assets
2: 
3: You can customize the launch screen with your own desired assets by replacing the image files in this directory.
4: 
5: You can also do it by opening your Flutter project's Xcode project with `open ios/Runner.xcworkspace`, selecting `Runner/Assets.xcassets` in the Project Navigator and dropping in the desired images.
````

## File: templates/basic/lib/app_lifecycle/app_lifecycle.dart
````dart
 1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: import 'package:flutter/widgets.dart';
 6: import 'package:logging/logging.dart';
 7: import 'package:provider/provider.dart';
 8: 
 9: typedef AppLifecycleStateNotifier = ValueNotifier<AppLifecycleState>;
10: 
11: class AppLifecycleObserver extends StatefulWidget {
12:   final Widget child;
13: 
14:   const AppLifecycleObserver({required this.child, super.key});
15: 
16:   @override
17:   State<AppLifecycleObserver> createState() => _AppLifecycleObserverState();
18: }
19: 
20: class _AppLifecycleObserverState extends State<AppLifecycleObserver> {
21:   static final _log = Logger('AppLifecycleObserver');
22:   late final AppLifecycleListener _appLifecycleListener;
23: 
24:   final ValueNotifier<AppLifecycleState> lifecycleListenable =
25:       ValueNotifier(AppLifecycleState.inactive);
26: 
27:   @override
28:   Widget build(BuildContext context) {
29:     // Using InheritedProvider because we don't want to use Consumer
30:     // or context.watch or anything like that to listen to this. We want
31:     // to manually add listeners. We're interested in the _events_ of lifecycle
32:     // state changes, and not so much in the state itself. (For example,
33:     // we want to stop sound when the app goes into the background, and
34:     // restart sound again when the app goes back into focus. We're not
35:     // rebuilding any widgets.)
36:     //
37:     // Provider, by default, throws when one
38:     // is trying to provide a Listenable (such as ValueNotifier) without using
39:     // something like ValueListenableProvider. InheritedProvider is more
40:     // low-level and doesn't have this problem.
41:     return InheritedProvider<AppLifecycleStateNotifier>.value(
42:       value: lifecycleListenable,
43:       child: widget.child,
44:     );
45:   }
46: 
47:   @override
48:   void dispose() {
49:     _appLifecycleListener.dispose();
50:     super.dispose();
51:   }
52: 
53:   @override
54:   void initState() {
55:     super.initState();
56:     _appLifecycleListener = AppLifecycleListener(
57:       onStateChange: (s) => lifecycleListenable.value = s,
58:     );
59:     _log.info('Subscribed to app lifecycle updates');
60:   }
61: }
````

## File: templates/basic/lib/audio/audio_controller.dart
````dart
  1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
  2: // for details. All rights reserved. Use of this source code is governed by a
  3: // BSD-style license that can be found in the LICENSE file.
  4: 
  5: import 'dart:async';
  6: import 'dart:collection';
  7: import 'dart:math';
  8: 
  9: import 'package:audioplayers/audioplayers.dart';
 10: import 'package:flutter/foundation.dart';
 11: import 'package:flutter/widgets.dart';
 12: import 'package:logging/logging.dart';
 13: 
 14: import '../app_lifecycle/app_lifecycle.dart';
 15: import '../settings/settings.dart';
 16: import 'songs.dart';
 17: import 'sounds.dart';
 18: 
 19: /// Allows playing music and sound. A facade to `package:audioplayers`.
 20: class AudioController {
 21:   static final _log = Logger('AudioController');
 22: 
 23:   final AudioPlayer _musicPlayer;
 24: 
 25:   /// This is a list of [AudioPlayer] instances which are rotated to play
 26:   /// sound effects.
 27:   final List<AudioPlayer> _sfxPlayers;
 28: 
 29:   int _currentSfxPlayer = 0;
 30: 
 31:   final Queue<Song> _playlist;
 32: 
 33:   final Random _random = Random();
 34: 
 35:   SettingsController? _settings;
 36: 
 37:   ValueNotifier<AppLifecycleState>? _lifecycleNotifier;
 38: 
 39:   /// Creates an instance that plays music and sound.
 40:   ///
 41:   /// Use [polyphony] to configure the number of sound effects (SFX) that can
 42:   /// play at the same time. A [polyphony] of `1` will always only play one
 43:   /// sound (a new sound will stop the previous one). See discussion
 44:   /// of [_sfxPlayers] to learn why this is the case.
 45:   ///
 46:   /// Background music does not count into the [polyphony] limit. Music will
 47:   /// never be overridden by sound effects because that would be silly.
 48:   AudioController({int polyphony = 2})
 49:       : assert(polyphony >= 1),
 50:         _musicPlayer = AudioPlayer(playerId: 'musicPlayer'),
 51:         _sfxPlayers = Iterable.generate(
 52:                 polyphony, (i) => AudioPlayer(playerId: 'sfxPlayer#$i'))
 53:             .toList(growable: false),
 54:         _playlist = Queue.of(List<Song>.of(songs)..shuffle()) {
 55:     _musicPlayer.onPlayerComplete.listen(_handleSongFinished);
 56:     unawaited(_preloadSfx());
 57:   }
 58: 
 59:   /// Makes sure the audio controller is listening to changes
 60:   /// of both the app lifecycle (e.g. suspended app) and to changes
 61:   /// of settings (e.g. muted sound).
 62:   void attachDependencies(AppLifecycleStateNotifier lifecycleNotifier,
 63:       SettingsController settingsController) {
 64:     _attachLifecycleNotifier(lifecycleNotifier);
 65:     _attachSettings(settingsController);
 66:   }
 67: 
 68:   void dispose() {
 69:     _lifecycleNotifier?.removeListener(_handleAppLifecycle);
 70:     _stopAllSound();
 71:     _musicPlayer.dispose();
 72:     for (final player in _sfxPlayers) {
 73:       player.dispose();
 74:     }
 75:   }
 76: 
 77:   /// Plays a single sound effect, defined by [type].
 78:   ///
 79:   /// The controller will ignore this call when the attached settings'
 80:   /// [SettingsController.audioOn] is `true` or if its
 81:   /// [SettingsController.soundsOn] is `false`.
 82:   void playSfx(SfxType type) {
 83:     final audioOn = _settings?.audioOn.value ?? false;
 84:     if (!audioOn) {
 85:       _log.fine(() => 'Ignoring playing sound ($type) because audio is muted.');
 86:       return;
 87:     }
 88:     final soundsOn = _settings?.soundsOn.value ?? false;
 89:     if (!soundsOn) {
 90:       _log.fine(() =>
 91:           'Ignoring playing sound ($type) because sounds are turned off.');
 92:       return;
 93:     }
 94: 
 95:     _log.fine(() => 'Playing sound: $type');
 96:     final options = soundTypeToFilename(type);
 97:     final filename = options[_random.nextInt(options.length)];
 98:     _log.fine(() => '- Chosen filename: $filename');
 99: 
100:     final currentPlayer = _sfxPlayers[_currentSfxPlayer];
101:     currentPlayer.play(AssetSource('sfx/$filename'),
102:         volume: soundTypeToVolume(type));
103:     _currentSfxPlayer = (_currentSfxPlayer + 1) % _sfxPlayers.length;
104:   }
105: 
106:   /// Enables the [AudioController] to listen to [AppLifecycleState] events,
107:   /// and therefore do things like stopping playback when the game
108:   /// goes into the background.
109:   void _attachLifecycleNotifier(AppLifecycleStateNotifier lifecycleNotifier) {
110:     _lifecycleNotifier?.removeListener(_handleAppLifecycle);
111: 
112:     lifecycleNotifier.addListener(_handleAppLifecycle);
113:     _lifecycleNotifier = lifecycleNotifier;
114:   }
115: 
116:   /// Enables the [AudioController] to track changes to settings.
117:   /// Namely, when any of [SettingsController.audioOn],
118:   /// [SettingsController.musicOn] or [SettingsController.soundsOn] changes,
119:   /// the audio controller will act accordingly.
120:   void _attachSettings(SettingsController settingsController) {
121:     if (_settings == settingsController) {
122:       // Already attached to this instance. Nothing to do.
123:       return;
124:     }
125: 
126:     // Remove handlers from the old settings controller if present
127:     final oldSettings = _settings;
128:     if (oldSettings != null) {
129:       oldSettings.audioOn.removeListener(_audioOnHandler);
130:       oldSettings.musicOn.removeListener(_musicOnHandler);
131:       oldSettings.soundsOn.removeListener(_soundsOnHandler);
132:     }
133: 
134:     _settings = settingsController;
135: 
136:     // Add handlers to the new settings controller
137:     settingsController.audioOn.addListener(_audioOnHandler);
138:     settingsController.musicOn.addListener(_musicOnHandler);
139:     settingsController.soundsOn.addListener(_soundsOnHandler);
140: 
141:     if (settingsController.audioOn.value && settingsController.musicOn.value) {
142:       if (kIsWeb) {
143:         _log.info('On the web, music can only start after user interaction.');
144:       } else {
145:         _playCurrentSongInPlaylist();
146:       }
147:     }
148:   }
149: 
150:   void _audioOnHandler() {
151:     _log.fine('audioOn changed to ${_settings!.audioOn.value}');
152:     if (_settings!.audioOn.value) {
153:       // All sound just got un-muted. Audio is on.
154:       if (_settings!.musicOn.value) {
155:         _startOrResumeMusic();
156:       }
157:     } else {
158:       // All sound just got muted. Audio is off.
159:       _stopAllSound();
160:     }
161:   }
162: 
163:   void _handleAppLifecycle() {
164:     switch (_lifecycleNotifier!.value) {
165:       case AppLifecycleState.paused:
166:       case AppLifecycleState.detached:
167:       case AppLifecycleState.hidden:
168:         _stopAllSound();
169:       case AppLifecycleState.resumed:
170:         if (_settings!.audioOn.value && _settings!.musicOn.value) {
171:           _startOrResumeMusic();
172:         }
173:       case AppLifecycleState.inactive:
174:         // No need to react to this state change.
175:         break;
176:     }
177:   }
178: 
179:   void _handleSongFinished(void _) {
180:     _log.info('Last song finished playing.');
181:     // Move the song that just finished playing to the end of the playlist.
182:     _playlist.addLast(_playlist.removeFirst());
183:     // Play the song at the beginning of the playlist.
184:     _playCurrentSongInPlaylist();
185:   }
186: 
187:   void _musicOnHandler() {
188:     if (_settings!.musicOn.value) {
189:       // Music got turned on.
190:       if (_settings!.audioOn.value) {
191:         _startOrResumeMusic();
192:       }
193:     } else {
194:       // Music got turned off.
195:       _musicPlayer.pause();
196:     }
197:   }
198: 
199:   Future<void> _playCurrentSongInPlaylist() async {
200:     _log.info(() => 'Playing ${_playlist.first} now.');
201:     try {
202:       await _musicPlayer.play(AssetSource('music/${_playlist.first.filename}'));
203:     } catch (e) {
204:       _log.severe('Could not play song ${_playlist.first}', e);
205:     }
206:   }
207: 
208:   /// Preloads all sound effects.
209:   Future<void> _preloadSfx() async {
210:     _log.info('Preloading sound effects');
211:     // This assumes there is only a limited number of sound effects in the game.
212:     // If there are hundreds of long sound effect files, it's better
213:     // to be more selective when preloading.
214:     await AudioCache.instance.loadAll(SfxType.values
215:         .expand(soundTypeToFilename)
216:         .map((path) => 'sfx/$path')
217:         .toList());
218:   }
219: 
220:   void _soundsOnHandler() {
221:     for (final player in _sfxPlayers) {
222:       if (player.state == PlayerState.playing) {
223:         player.stop();
224:       }
225:     }
226:   }
227: 
228:   void _startOrResumeMusic() async {
229:     if (_musicPlayer.source == null) {
230:       _log.info('No music source set. '
231:           'Start playing the current song in playlist.');
232:       await _playCurrentSongInPlaylist();
233:       return;
234:     }
235: 
236:     _log.info('Resuming paused music.');
237:     try {
238:       _musicPlayer.resume();
239:     } catch (e) {
240:       // Sometimes, resuming fails with an "Unexpected" error.
241:       _log.severe('Error resuming music', e);
242:       // Try starting the song from scratch.
243:       _playCurrentSongInPlaylist();
244:     }
245:   }
246: 
247:   void _stopAllSound() {
248:     _log.info('Stopping all sound');
249:     _musicPlayer.pause();
250:     for (final player in _sfxPlayers) {
251:       player.stop();
252:     }
253:   }
254: }
````

## File: templates/basic/lib/audio/songs.dart
````dart
 1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: const Set<Song> songs = {
 6:   // Filenames with whitespace break package:audioplayers on iOS
 7:   // (as of February 2022), so we use no whitespace.
 8:   Song('Mr_Smith-Azul.mp3', 'Azul', artist: 'Mr Smith'),
 9:   Song('Mr_Smith-Sonorus.mp3', 'Sonorus', artist: 'Mr Smith'),
10:   Song('Mr_Smith-Sunday_Solitude.mp3', 'SundaySolitude', artist: 'Mr Smith'),
11: };
12: 
13: class Song {
14:   final String filename;
15: 
16:   final String name;
17: 
18:   final String? artist;
19: 
20:   const Song(this.filename, this.name, {this.artist});
21: 
22:   @override
23:   String toString() => 'Song<$filename>';
24: }
````

## File: templates/basic/lib/audio/sounds.dart
````dart
 1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: List<String> soundTypeToFilename(SfxType type) => switch (type) {
 6:       SfxType.huhsh => const [
 7:           'hash1.mp3',
 8:           'hash2.mp3',
 9:           'hash3.mp3',
10:         ],
11:       SfxType.wssh => const [
12:           'wssh1.mp3',
13:           'wssh2.mp3',
14:           'dsht1.mp3',
15:           'ws1.mp3',
16:           'spsh1.mp3',
17:           'hh1.mp3',
18:           'hh2.mp3',
19:           'kss1.mp3',
20:         ],
21:       SfxType.buttonTap => const [
22:           'k1.mp3',
23:           'k2.mp3',
24:           'p1.mp3',
25:           'p2.mp3',
26:         ],
27:       SfxType.congrats => const [
28:           'yay1.mp3',
29:           'wehee1.mp3',
30:           'oo1.mp3',
31:         ],
32:       SfxType.erase => const [
33:           'fwfwfwfwfw1.mp3',
34:           'fwfwfwfw1.mp3',
35:         ],
36:       SfxType.swishSwish => const [
37:           'swishswish1.mp3',
38:         ]
39:     };
40: 
41: /// Allows control over loudness of different SFX types.
42: double soundTypeToVolume(SfxType type) {
43:   switch (type) {
44:     case SfxType.huhsh:
45:       return 0.4;
46:     case SfxType.wssh:
47:       return 0.2;
48:     case SfxType.buttonTap:
49:     case SfxType.congrats:
50:     case SfxType.erase:
51:     case SfxType.swishSwish:
52:       return 1.0;
53:   }
54: }
55: 
56: enum SfxType {
57:   huhsh,
58:   wssh,
59:   buttonTap,
60:   congrats,
61:   erase,
62:   swishSwish,
63: }
````

## File: templates/basic/lib/game_internals/level_state.dart
````dart
 1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: import 'package:flutter/foundation.dart';
 6: 
 7: /// An extremely silly example of a game state.
 8: ///
 9: /// Tracks only a single variable, [progress], and calls [onWin] when
10: /// the value of [progress] reaches [goal].
11: class LevelState extends ChangeNotifier {
12:   final VoidCallback onWin;
13: 
14:   final int goal;
15: 
16:   LevelState({required this.onWin, this.goal = 100});
17: 
18:   int _progress = 0;
19: 
20:   int get progress => _progress;
21: 
22:   void setProgress(int value) {
23:     _progress = value;
24:     notifyListeners();
25:   }
26: 
27:   void evaluate() {
28:     if (_progress >= goal) {
29:       onWin();
30:     }
31:   }
32: }
````

## File: templates/basic/lib/game_internals/score.dart
````dart
 1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: /// Encapsulates a score and the arithmetic to compute it.
 6: class Score {
 7:   final int score;
 8: 
 9:   final Duration duration;
10: 
11:   final int level;
12: 
13:   factory Score(int level, int difficulty, Duration duration) {
14:     // The higher the difficulty, the higher the score.
15:     var score = difficulty;
16:     // The lower the time to beat the level, the higher the score.
17:     score *= 10000 ~/ (duration.inSeconds.abs() + 1);
18:     return Score._(score, duration, level);
19:   }
20: 
21:   const Score._(this.score, this.duration, this.level);
22: 
23:   String get formattedTime {
24:     final buf = StringBuffer();
25:     if (duration.inHours > 0) {
26:       buf.write('${duration.inHours}');
27:       buf.write(':');
28:     }
29:     final minutes = duration.inMinutes % Duration.minutesPerHour;
30:     if (minutes > 9) {
31:       buf.write('$minutes');
32:     } else {
33:       buf.write('0');
34:       buf.write('$minutes');
35:     }
36:     buf.write(':');
37:     buf.write((duration.inSeconds % Duration.secondsPerMinute)
38:         .toString()
39:         .padLeft(2, '0'));
40:     return buf.toString();
41:   }
42: 
43:   @override
44:   String toString() => 'Score<$score,$formattedTime,$level>';
45: }
````

## File: templates/basic/lib/level_selection/level_selection_screen.dart
````dart
 1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: import 'package:flutter/material.dart';
 6: import 'package:go_router/go_router.dart';
 7: import 'package:provider/provider.dart';
 8: 
 9: import '../audio/audio_controller.dart';
10: import '../audio/sounds.dart';
11: import '../player_progress/player_progress.dart';
12: import '../style/my_button.dart';
13: import '../style/palette.dart';
14: import '../style/responsive_screen.dart';
15: import 'levels.dart';
16: 
17: class LevelSelectionScreen extends StatelessWidget {
18:   const LevelSelectionScreen({super.key});
19: 
20:   @override
21:   Widget build(BuildContext context) {
22:     final palette = context.watch<Palette>();
23:     final playerProgress = context.watch<PlayerProgress>();
24: 
25:     return Scaffold(
26:       backgroundColor: palette.backgroundLevelSelection,
27:       body: ResponsiveScreen(
28:         squarishMainArea: Column(
29:           children: [
30:             const Padding(
31:               padding: EdgeInsets.all(16),
32:               child: Center(
33:                 child: Text(
34:                   'Select level',
35:                   style:
36:                       TextStyle(fontFamily: 'Permanent Marker', fontSize: 30),
37:                 ),
38:               ),
39:             ),
40:             const SizedBox(height: 50),
41:             Expanded(
42:               child: ListView(
43:                 children: [
44:                   for (final level in gameLevels)
45:                     ListTile(
46:                       enabled: playerProgress.highestLevelReached >=
47:                           level.number - 1,
48:                       onTap: () {
49:                         final audioController = context.read<AudioController>();
50:                         audioController.playSfx(SfxType.buttonTap);
51: 
52:                         GoRouter.of(context)
53:                             .go('/play/session/${level.number}');
54:                       },
55:                       leading: Text(level.number.toString()),
56:                       title: Text('Level #${level.number}'),
57:                     )
58:                 ],
59:               ),
60:             ),
61:           ],
62:         ),
63:         rectangularMenuArea: MyButton(
64:           onPressed: () {
65:             GoRouter.of(context).go('/');
66:           },
67:           child: const Text('Back'),
68:         ),
69:       ),
70:     );
71:   }
72: }
````

## File: templates/basic/lib/level_selection/levels.dart
````dart
 1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: const gameLevels = [
 6:   GameLevel(
 7:     number: 1,
 8:     difficulty: 5,
 9:     // TODO: When ready, change these achievement IDs.
10:     // You configure this in App Store Connect.
11:     achievementIdIOS: 'first_win',
12:     // You get this string when you configure an achievement in Play Console.
13:     achievementIdAndroid: 'NhkIwB69ejkMAOOLDb',
14:   ),
15:   GameLevel(
16:     number: 2,
17:     difficulty: 42,
18:   ),
19:   GameLevel(
20:     number: 3,
21:     difficulty: 100,
22:     achievementIdIOS: 'finished',
23:     achievementIdAndroid: 'CdfIhE96aspNWLGSQg',
24:   ),
25: ];
26: 
27: class GameLevel {
28:   final int number;
29: 
30:   final int difficulty;
31: 
32:   /// The achievement to unlock when the level is finished, if any.
33:   final String? achievementIdIOS;
34: 
35:   final String? achievementIdAndroid;
36: 
37:   bool get awardsAchievement => achievementIdAndroid != null;
38: 
39:   const GameLevel({
40:     required this.number,
41:     required this.difficulty,
42:     this.achievementIdIOS,
43:     this.achievementIdAndroid,
44:   }) : assert(
45:             (achievementIdAndroid != null && achievementIdIOS != null) ||
46:                 (achievementIdAndroid == null && achievementIdIOS == null),
47:             'Either both iOS and Android achievement ID must be provided, '
48:             'or none');
49: }
````

## File: templates/basic/lib/main_menu/main_menu_screen.dart
````dart
 1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: import 'package:flutter/material.dart';
 6: import 'package:go_router/go_router.dart';
 7: import 'package:provider/provider.dart';
 8: 
 9: import '../audio/audio_controller.dart';
10: import '../audio/sounds.dart';
11: import '../settings/settings.dart';
12: import '../style/my_button.dart';
13: import '../style/palette.dart';
14: import '../style/responsive_screen.dart';
15: 
16: class MainMenuScreen extends StatelessWidget {
17:   const MainMenuScreen({super.key});
18: 
19:   @override
20:   Widget build(BuildContext context) {
21:     final palette = context.watch<Palette>();
22:     final settingsController = context.watch<SettingsController>();
23:     final audioController = context.watch<AudioController>();
24: 
25:     return Scaffold(
26:       backgroundColor: palette.backgroundMain,
27:       body: ResponsiveScreen(
28:         squarishMainArea: Center(
29:           child: Transform.rotate(
30:             angle: -0.1,
31:             child: const Text(
32:               'Flutter Game Template!',
33:               textAlign: TextAlign.center,
34:               style: TextStyle(
35:                 fontFamily: 'Permanent Marker',
36:                 fontSize: 55,
37:                 height: 1,
38:               ),
39:             ),
40:           ),
41:         ),
42:         rectangularMenuArea: Column(
43:           mainAxisAlignment: MainAxisAlignment.end,
44:           children: [
45:             MyButton(
46:               onPressed: () {
47:                 audioController.playSfx(SfxType.buttonTap);
48:                 GoRouter.of(context).go('/play');
49:               },
50:               child: const Text('Play'),
51:             ),
52:             _gap,
53:             MyButton(
54:               onPressed: () => GoRouter.of(context).push('/settings'),
55:               child: const Text('Settings'),
56:             ),
57:             _gap,
58:             Padding(
59:               padding: const EdgeInsets.only(top: 32),
60:               child: ValueListenableBuilder<bool>(
61:                 valueListenable: settingsController.audioOn,
62:                 builder: (context, audioOn, child) {
63:                   return IconButton(
64:                     onPressed: settingsController.toggleAudioOn,
65:                     icon: Icon(audioOn ? Icons.volume_up : Icons.volume_off),
66:                   );
67:                 },
68:               ),
69:             ),
70:             _gap,
71:             const Text('Music by Mr Smith'),
72:             _gap,
73:           ],
74:         ),
75:       ),
76:     );
77:   }
78: 
79:   static const _gap = SizedBox(height: 10);
80: }
````

## File: templates/basic/lib/play_session/game_widget.dart
````dart
 1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: import 'package:flutter/material.dart';
 6: import 'package:provider/provider.dart';
 7: 
 8: import '../audio/audio_controller.dart';
 9: import '../audio/sounds.dart';
10: import '../game_internals/level_state.dart';
11: import '../level_selection/levels.dart';
12: 
13: /// This widget defines the game UI itself, without things like the settings
14: /// button or the back button.
15: class GameWidget extends StatelessWidget {
16:   const GameWidget({super.key});
17: 
18:   @override
19:   Widget build(BuildContext context) {
20:     final level = context.watch<GameLevel>();
21:     final levelState = context.watch<LevelState>();
22: 
23:     return Column(
24:       children: [
25:         Text('Drag the slider to ${level.difficulty}% or above!'),
26:         Slider(
27:           label: 'Level Progress',
28:           autofocus: true,
29:           value: levelState.progress / 100,
30:           onChanged: (value) => levelState.setProgress((value * 100).round()),
31:           onChangeEnd: (value) {
32:             context.read<AudioController>().playSfx(SfxType.wssh);
33:             levelState.evaluate();
34:           },
35:         ),
36:       ],
37:     );
38:   }
39: }
````

## File: templates/basic/lib/play_session/play_session_screen.dart
````dart
  1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
  2: // for details. All rights reserved. Use of this source code is governed by a
  3: // BSD-style license that can be found in the LICENSE file.
  4: 
  5: import 'dart:async';
  6: 
  7: import 'package:flutter/material.dart';
  8: import 'package:go_router/go_router.dart';
  9: import 'package:logging/logging.dart' hide Level;
 10: import 'package:provider/provider.dart';
 11: 
 12: import '../audio/audio_controller.dart';
 13: import '../audio/sounds.dart';
 14: import '../game_internals/level_state.dart';
 15: import '../game_internals/score.dart';
 16: import '../level_selection/levels.dart';
 17: import '../player_progress/player_progress.dart';
 18: import '../style/confetti.dart';
 19: import '../style/my_button.dart';
 20: import '../style/palette.dart';
 21: import 'game_widget.dart';
 22: 
 23: /// This widget defines the entirety of the screen that the player sees when
 24: /// they are playing a level.
 25: ///
 26: /// It is a stateful widget because it manages some state of its own,
 27: /// such as whether the game is in a "celebration" state.
 28: class PlaySessionScreen extends StatefulWidget {
 29:   final GameLevel level;
 30: 
 31:   const PlaySessionScreen(this.level, {super.key});
 32: 
 33:   @override
 34:   State<PlaySessionScreen> createState() => _PlaySessionScreenState();
 35: }
 36: 
 37: class _PlaySessionScreenState extends State<PlaySessionScreen> {
 38:   static final _log = Logger('PlaySessionScreen');
 39: 
 40:   static const _celebrationDuration = Duration(milliseconds: 2000);
 41: 
 42:   static const _preCelebrationDuration = Duration(milliseconds: 500);
 43: 
 44:   bool _duringCelebration = false;
 45: 
 46:   late DateTime _startOfPlay;
 47: 
 48:   @override
 49:   void initState() {
 50:     super.initState();
 51: 
 52:     _startOfPlay = DateTime.now();
 53:   }
 54: 
 55:   @override
 56:   Widget build(BuildContext context) {
 57:     final palette = context.watch<Palette>();
 58: 
 59:     return MultiProvider(
 60:       providers: [
 61:         Provider.value(value: widget.level),
 62:         // Create and provide the [LevelState] object that will be used
 63:         // by widgets below this one in the widget tree.
 64:         ChangeNotifierProvider(
 65:           create: (context) => LevelState(
 66:             goal: widget.level.difficulty,
 67:             onWin: _playerWon,
 68:           ),
 69:         ),
 70:       ],
 71:       child: IgnorePointer(
 72:         // Ignore all input during the celebration animation.
 73:         ignoring: _duringCelebration,
 74:         child: Scaffold(
 75:           backgroundColor: palette.backgroundPlaySession,
 76:           // The stack is how you layer widgets on top of each other.
 77:           // Here, it is used to overlay the winning confetti animation on top
 78:           // of the game.
 79:           body: Stack(
 80:             children: [
 81:               // This is the main layout of the play session screen,
 82:               // with a settings button on top, the actual play area
 83:               // in the middle, and a back button at the bottom.
 84:               Column(
 85:                 mainAxisAlignment: MainAxisAlignment.center,
 86:                 children: [
 87:                   Align(
 88:                     alignment: Alignment.centerRight,
 89:                     child: InkResponse(
 90:                       onTap: () => GoRouter.of(context).push('/settings'),
 91:                       child: Image.asset(
 92:                         'assets/images/settings.png',
 93:                         semanticLabel: 'Settings',
 94:                       ),
 95:                     ),
 96:                   ),
 97:                   const Spacer(),
 98:                   const Expanded(
 99:                     // The actual UI of the game.
100:                     child: GameWidget(),
101:                   ),
102:                   const Spacer(),
103:                   Padding(
104:                     padding: const EdgeInsets.all(8.0),
105:                     child: MyButton(
106:                       onPressed: () => GoRouter.of(context).go('/play'),
107:                       child: const Text('Back'),
108:                     ),
109:                   ),
110:                 ],
111:               ),
112:               // This is the confetti animation that is overlaid on top of the
113:               // game when the player wins.
114:               SizedBox.expand(
115:                 child: Visibility(
116:                   visible: _duringCelebration,
117:                   child: IgnorePointer(
118:                     child: Confetti(
119:                       isStopped: !_duringCelebration,
120:                     ),
121:                   ),
122:                 ),
123:               ),
124:             ],
125:           ),
126:         ),
127:       ),
128:     );
129:   }
130: 
131:   Future<void> _playerWon() async {
132:     _log.info('Level ${widget.level.number} won');
133: 
134:     final score = Score(
135:       widget.level.number,
136:       widget.level.difficulty,
137:       DateTime.now().difference(_startOfPlay),
138:     );
139: 
140:     final playerProgress = context.read<PlayerProgress>();
141:     playerProgress.setLevelReached(widget.level.number);
142: 
143:     // Let the player see the game just after winning for a bit.
144:     await Future<void>.delayed(_preCelebrationDuration);
145:     if (!mounted) return;
146: 
147:     setState(() {
148:       _duringCelebration = true;
149:     });
150: 
151:     final audioController = context.read<AudioController>();
152:     audioController.playSfx(SfxType.congrats);
153: 
154:     /// Give the player some time to see the celebration animation.
155:     await Future<void>.delayed(_celebrationDuration);
156:     if (!mounted) return;
157: 
158:     GoRouter.of(context).go('/play/won', extra: {'score': score});
159:   }
160: }
````

## File: templates/basic/lib/player_progress/persistence/local_storage_player_progress_persistence.dart
````dart
 1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: import 'package:shared_preferences/shared_preferences.dart';
 6: 
 7: import 'player_progress_persistence.dart';
 8: 
 9: /// An implementation of [PlayerProgressPersistence] that uses
10: /// `package:shared_preferences`.
11: class LocalStoragePlayerProgressPersistence extends PlayerProgressPersistence {
12:   final Future<SharedPreferences> instanceFuture =
13:       SharedPreferences.getInstance();
14: 
15:   @override
16:   Future<int> getHighestLevelReached() async {
17:     final prefs = await instanceFuture;
18:     return prefs.getInt('highestLevelReached') ?? 0;
19:   }
20: 
21:   @override
22:   Future<void> saveHighestLevelReached(int level) async {
23:     final prefs = await instanceFuture;
24:     await prefs.setInt('highestLevelReached', level);
25:   }
26: }
````

## File: templates/basic/lib/player_progress/persistence/memory_player_progress_persistence.dart
````dart
 1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: import 'player_progress_persistence.dart';
 6: 
 7: /// An in-memory implementation of [PlayerProgressPersistence].
 8: /// Useful for testing.
 9: class MemoryOnlyPlayerProgressPersistence implements PlayerProgressPersistence {
10:   int level = 0;
11: 
12:   @override
13:   Future<int> getHighestLevelReached() async {
14:     await Future<void>.delayed(const Duration(milliseconds: 500));
15:     return level;
16:   }
17: 
18:   @override
19:   Future<void> saveHighestLevelReached(int level) async {
20:     await Future<void>.delayed(const Duration(milliseconds: 500));
21:     this.level = level;
22:   }
23: }
````

## File: templates/basic/lib/player_progress/persistence/player_progress_persistence.dart
````dart
 1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: /// An interface of persistence stores for the player's progress.
 6: ///
 7: /// Implementations can range from simple in-memory storage through
 8: /// local preferences to cloud saves.
 9: abstract class PlayerProgressPersistence {
10:   Future<int> getHighestLevelReached();
11: 
12:   Future<void> saveHighestLevelReached(int level);
13: }
````

## File: templates/basic/lib/player_progress/player_progress.dart
````dart
 1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: import 'dart:async';
 6: 
 7: import 'package:flutter/foundation.dart';
 8: 
 9: import 'persistence/local_storage_player_progress_persistence.dart';
10: import 'persistence/player_progress_persistence.dart';
11: 
12: /// Encapsulates the player's progress.
13: class PlayerProgress extends ChangeNotifier {
14:   static const maxHighestScoresPerPlayer = 10;
15: 
16:   /// By default, settings are persisted using
17:   /// [LocalStoragePlayerProgressPersistence] (i.e. NSUserDefaults on iOS,
18:   /// SharedPreferences on Android or local storage on the web).
19:   final PlayerProgressPersistence _store;
20: 
21:   int _highestLevelReached = 0;
22: 
23:   /// Creates an instance of [PlayerProgress] backed by an injected
24:   /// persistence [store].
25:   PlayerProgress({PlayerProgressPersistence? store})
26:       : _store = store ?? LocalStoragePlayerProgressPersistence() {
27:     _getLatestFromStore();
28:   }
29: 
30:   /// The highest level that the player has reached so far.
31:   int get highestLevelReached => _highestLevelReached;
32: 
33:   /// Resets the player's progress so it's like if they just started
34:   /// playing the game for the first time.
35:   void reset() {
36:     _highestLevelReached = 0;
37:     notifyListeners();
38:     _store.saveHighestLevelReached(_highestLevelReached);
39:   }
40: 
41:   /// Registers [level] as reached.
42:   ///
43:   /// If this is higher than [highestLevelReached], it will update that
44:   /// value and save it to the injected persistence store.
45:   void setLevelReached(int level) {
46:     if (level > _highestLevelReached) {
47:       _highestLevelReached = level;
48:       notifyListeners();
49: 
50:       unawaited(_store.saveHighestLevelReached(level));
51:     }
52:   }
53: 
54:   /// Fetches the latest data from the backing persistence store.
55:   Future<void> _getLatestFromStore() async {
56:     final level = await _store.getHighestLevelReached();
57:     if (level > _highestLevelReached) {
58:       _highestLevelReached = level;
59:       notifyListeners();
60:     } else if (level < _highestLevelReached) {
61:       await _store.saveHighestLevelReached(_highestLevelReached);
62:     }
63:   }
64: }
````

## File: templates/basic/lib/settings/persistence/local_storage_settings_persistence.dart
````dart
 1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: import 'package:shared_preferences/shared_preferences.dart';
 6: 
 7: import 'settings_persistence.dart';
 8: 
 9: /// An implementation of [SettingsPersistence] that uses
10: /// `package:shared_preferences`.
11: class LocalStorageSettingsPersistence extends SettingsPersistence {
12:   final Future<SharedPreferences> instanceFuture =
13:       SharedPreferences.getInstance();
14: 
15:   @override
16:   Future<bool> getAudioOn({required bool defaultValue}) async {
17:     final prefs = await instanceFuture;
18:     return prefs.getBool('audioOn') ?? defaultValue;
19:   }
20: 
21:   @override
22:   Future<bool> getMusicOn({required bool defaultValue}) async {
23:     final prefs = await instanceFuture;
24:     return prefs.getBool('musicOn') ?? defaultValue;
25:   }
26: 
27:   @override
28:   Future<String> getPlayerName() async {
29:     final prefs = await instanceFuture;
30:     return prefs.getString('playerName') ?? 'Player';
31:   }
32: 
33:   @override
34:   Future<bool> getSoundsOn({required bool defaultValue}) async {
35:     final prefs = await instanceFuture;
36:     return prefs.getBool('soundsOn') ?? defaultValue;
37:   }
38: 
39:   @override
40:   Future<void> saveAudioOn(bool value) async {
41:     final prefs = await instanceFuture;
42:     await prefs.setBool('audioOn', value);
43:   }
44: 
45:   @override
46:   Future<void> saveMusicOn(bool value) async {
47:     final prefs = await instanceFuture;
48:     await prefs.setBool('musicOn', value);
49:   }
50: 
51:   @override
52:   Future<void> savePlayerName(String value) async {
53:     final prefs = await instanceFuture;
54:     await prefs.setString('playerName', value);
55:   }
56: 
57:   @override
58:   Future<void> saveSoundsOn(bool value) async {
59:     final prefs = await instanceFuture;
60:     await prefs.setBool('soundsOn', value);
61:   }
62: }
````

## File: templates/basic/lib/settings/persistence/memory_settings_persistence.dart
````dart
 1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: import 'settings_persistence.dart';
 6: 
 7: /// An in-memory implementation of [SettingsPersistence].
 8: /// Useful for testing.
 9: class MemoryOnlySettingsPersistence implements SettingsPersistence {
10:   bool musicOn = true;
11: 
12:   bool soundsOn = true;
13: 
14:   bool audioOn = true;
15: 
16:   String playerName = 'Player';
17: 
18:   @override
19:   Future<bool> getAudioOn({required bool defaultValue}) async => audioOn;
20: 
21:   @override
22:   Future<bool> getMusicOn({required bool defaultValue}) async => musicOn;
23: 
24:   @override
25:   Future<String> getPlayerName() async => playerName;
26: 
27:   @override
28:   Future<bool> getSoundsOn({required bool defaultValue}) async => soundsOn;
29: 
30:   @override
31:   Future<void> saveAudioOn(bool value) async => audioOn = value;
32: 
33:   @override
34:   Future<void> saveMusicOn(bool value) async => musicOn = value;
35: 
36:   @override
37:   Future<void> savePlayerName(String value) async => playerName = value;
38: 
39:   @override
40:   Future<void> saveSoundsOn(bool value) async => soundsOn = value;
41: }
````

## File: templates/basic/lib/settings/persistence/settings_persistence.dart
````dart
 1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: /// An interface of persistence stores for settings.
 6: ///
 7: /// Implementations can range from simple in-memory storage through
 8: /// local preferences to cloud-based solutions.
 9: abstract class SettingsPersistence {
10:   Future<bool> getAudioOn({required bool defaultValue});
11: 
12:   Future<bool> getMusicOn({required bool defaultValue});
13: 
14:   Future<String> getPlayerName();
15: 
16:   Future<bool> getSoundsOn({required bool defaultValue});
17: 
18:   Future<void> saveAudioOn(bool value);
19: 
20:   Future<void> saveMusicOn(bool value);
21: 
22:   Future<void> savePlayerName(String value);
23: 
24:   Future<void> saveSoundsOn(bool value);
25: }
````

## File: templates/basic/lib/settings/custom_name_dialog.dart
````dart
 1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: import 'package:flutter/material.dart';
 6: import 'package:flutter/services.dart';
 7: import 'package:provider/provider.dart';
 8: 
 9: import 'settings.dart';
10: 
11: void showCustomNameDialog(BuildContext context) {
12:   showGeneralDialog(
13:       context: context,
14:       pageBuilder: (context, animation, secondaryAnimation) =>
15:           CustomNameDialog(animation: animation));
16: }
17: 
18: class CustomNameDialog extends StatefulWidget {
19:   final Animation<double> animation;
20: 
21:   const CustomNameDialog({required this.animation, super.key});
22: 
23:   @override
24:   State<CustomNameDialog> createState() => _CustomNameDialogState();
25: }
26: 
27: class _CustomNameDialogState extends State<CustomNameDialog> {
28:   final TextEditingController _controller = TextEditingController();
29: 
30:   @override
31:   Widget build(BuildContext context) {
32:     return ScaleTransition(
33:       scale: CurvedAnimation(
34:         parent: widget.animation,
35:         curve: Curves.easeOutCubic,
36:       ),
37:       child: SimpleDialog(
38:         title: const Text('Change name'),
39:         children: [
40:           TextField(
41:             controller: _controller,
42:             autofocus: true,
43:             maxLength: 12,
44:             maxLengthEnforcement: MaxLengthEnforcement.enforced,
45:             textAlign: TextAlign.center,
46:             textCapitalization: TextCapitalization.words,
47:             textInputAction: TextInputAction.done,
48:             onChanged: (value) {
49:               context.read<SettingsController>().setPlayerName(value);
50:             },
51:             onSubmitted: (value) {
52:               // Player tapped 'Submit'/'Done' on their keyboard.
53:               Navigator.pop(context);
54:             },
55:           ),
56:           TextButton(
57:             onPressed: () => Navigator.pop(context),
58:             child: const Text('Close'),
59:           ),
60:         ],
61:       ),
62:     );
63:   }
64: 
65:   @override
66:   void dispose() {
67:     _controller.dispose();
68:     super.dispose();
69:   }
70: 
71:   @override
72:   void initState() {
73:     super.initState();
74:     _controller.text = context.read<SettingsController>().playerName.value;
75:   }
76: }
````

## File: templates/basic/lib/settings/settings_screen.dart
````dart
  1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
  2: // for details. All rights reserved. Use of this source code is governed by a
  3: // BSD-style license that can be found in the LICENSE file.
  4: 
  5: import 'package:flutter/material.dart';
  6: import 'package:go_router/go_router.dart';
  7: import 'package:provider/provider.dart';
  8: 
  9: import '../player_progress/player_progress.dart';
 10: import '../style/my_button.dart';
 11: import '../style/palette.dart';
 12: import '../style/responsive_screen.dart';
 13: import 'custom_name_dialog.dart';
 14: import 'settings.dart';
 15: 
 16: class SettingsScreen extends StatelessWidget {
 17:   const SettingsScreen({super.key});
 18: 
 19:   static const _gap = SizedBox(height: 60);
 20: 
 21:   @override
 22:   Widget build(BuildContext context) {
 23:     final settings = context.watch<SettingsController>();
 24:     final palette = context.watch<Palette>();
 25: 
 26:     return Scaffold(
 27:       backgroundColor: palette.backgroundSettings,
 28:       body: ResponsiveScreen(
 29:         squarishMainArea: ListView(
 30:           children: [
 31:             _gap,
 32:             const Text(
 33:               'Settings',
 34:               textAlign: TextAlign.center,
 35:               style: TextStyle(
 36:                 fontFamily: 'Permanent Marker',
 37:                 fontSize: 55,
 38:                 height: 1,
 39:               ),
 40:             ),
 41:             _gap,
 42:             const _NameChangeLine(
 43:               'Name',
 44:             ),
 45:             ValueListenableBuilder<bool>(
 46:               valueListenable: settings.soundsOn,
 47:               builder: (context, soundsOn, child) => _SettingsLine(
 48:                 'Sound FX',
 49:                 Icon(soundsOn ? Icons.graphic_eq : Icons.volume_off),
 50:                 onSelected: settings.toggleSoundsOn,
 51:               ),
 52:             ),
 53:             ValueListenableBuilder<bool>(
 54:               valueListenable: settings.musicOn,
 55:               builder: (context, musicOn, child) => _SettingsLine(
 56:                 'Music',
 57:                 Icon(musicOn ? Icons.music_note : Icons.music_off),
 58:                 onSelected: settings.toggleMusicOn,
 59:               ),
 60:             ),
 61:             _SettingsLine(
 62:               'Reset progress',
 63:               const Icon(Icons.delete),
 64:               onSelected: () {
 65:                 context.read<PlayerProgress>().reset();
 66: 
 67:                 final messenger = ScaffoldMessenger.of(context);
 68:                 messenger.showSnackBar(
 69:                   const SnackBar(
 70:                       content: Text('Player progress has been reset.')),
 71:                 );
 72:               },
 73:             ),
 74:             _gap,
 75:           ],
 76:         ),
 77:         rectangularMenuArea: MyButton(
 78:           onPressed: () {
 79:             GoRouter.of(context).pop();
 80:           },
 81:           child: const Text('Back'),
 82:         ),
 83:       ),
 84:     );
 85:   }
 86: }
 87: 
 88: class _NameChangeLine extends StatelessWidget {
 89:   final String title;
 90: 
 91:   const _NameChangeLine(this.title);
 92: 
 93:   @override
 94:   Widget build(BuildContext context) {
 95:     final settings = context.watch<SettingsController>();
 96: 
 97:     return InkResponse(
 98:       highlightShape: BoxShape.rectangle,
 99:       onTap: () => showCustomNameDialog(context),
100:       child: Padding(
101:         padding: const EdgeInsets.symmetric(horizontal: 8),
102:         child: Row(
103:           mainAxisAlignment: MainAxisAlignment.center,
104:           children: [
105:             Text(title,
106:                 style: const TextStyle(
107:                   fontFamily: 'Permanent Marker',
108:                   fontSize: 30,
109:                 )),
110:             const Spacer(),
111:             ValueListenableBuilder(
112:               valueListenable: settings.playerName,
113:               builder: (context, name, child) => Text(
114:                 '‘$name’',
115:                 style: const TextStyle(
116:                   fontFamily: 'Permanent Marker',
117:                   fontSize: 30,
118:                 ),
119:               ),
120:             ),
121:           ],
122:         ),
123:       ),
124:     );
125:   }
126: }
127: 
128: class _SettingsLine extends StatelessWidget {
129:   final String title;
130: 
131:   final Widget icon;
132: 
133:   final VoidCallback? onSelected;
134: 
135:   const _SettingsLine(this.title, this.icon, {this.onSelected});
136: 
137:   @override
138:   Widget build(BuildContext context) {
139:     return InkResponse(
140:       highlightShape: BoxShape.rectangle,
141:       onTap: onSelected,
142:       child: Padding(
143:         padding: const EdgeInsets.symmetric(horizontal: 8),
144:         child: Row(
145:           mainAxisAlignment: MainAxisAlignment.start,
146:           children: [
147:             Expanded(
148:               child: Text(
149:                 title,
150:                 maxLines: 1,
151:                 overflow: TextOverflow.ellipsis,
152:                 style: const TextStyle(
153:                   fontFamily: 'Permanent Marker',
154:                   fontSize: 30,
155:                 ),
156:               ),
157:             ),
158:             icon,
159:           ],
160:         ),
161:       ),
162:     );
163:   }
164: }
````

## File: templates/basic/lib/settings/settings.dart
````dart
 1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: import 'package:flutter/foundation.dart';
 6: import 'package:logging/logging.dart';
 7: 
 8: import 'persistence/local_storage_settings_persistence.dart';
 9: import 'persistence/settings_persistence.dart';
10: 
11: /// An class that holds settings like [playerName] or [musicOn],
12: /// and saves them to an injected persistence store.
13: class SettingsController {
14:   static final _log = Logger('SettingsController');
15: 
16:   /// The persistence store that is used to save settings.
17:   final SettingsPersistence _store;
18: 
19:   /// Whether or not the audio is on at all. This overrides both music
20:   /// and sounds (sfx).
21:   ///
22:   /// This is an important feature especially on mobile, where players
23:   /// expect to be able to quickly mute all the audio. Having this as
24:   /// a separate flag (as opposed to some kind of {off, sound, everything}
25:   /// enum) means that the player will not lose their [soundsOn] and
26:   /// [musicOn] preferences when they temporarily mute the game.
27:   ValueNotifier<bool> audioOn = ValueNotifier(true);
28: 
29:   /// The player's name. Used for things like high score lists.
30:   ValueNotifier<String> playerName = ValueNotifier('Player');
31: 
32:   /// Whether or not the sound effects (sfx) are on.
33:   ValueNotifier<bool> soundsOn = ValueNotifier(true);
34: 
35:   /// Whether or not the music is on.
36:   ValueNotifier<bool> musicOn = ValueNotifier(true);
37: 
38:   /// Creates a new instance of [SettingsController] backed by [store].
39:   ///
40:   /// By default, settings are persisted using [LocalStorageSettingsPersistence]
41:   /// (i.e. NSUserDefaults on iOS, SharedPreferences on Android or
42:   /// local storage on the web).
43:   SettingsController({SettingsPersistence? store})
44:       : _store = store ?? LocalStorageSettingsPersistence() {
45:     _loadStateFromPersistence();
46:   }
47: 
48:   void setPlayerName(String name) {
49:     playerName.value = name;
50:     _store.savePlayerName(playerName.value);
51:   }
52: 
53:   void toggleAudioOn() {
54:     audioOn.value = !audioOn.value;
55:     _store.saveAudioOn(audioOn.value);
56:   }
57: 
58:   void toggleMusicOn() {
59:     musicOn.value = !musicOn.value;
60:     _store.saveMusicOn(musicOn.value);
61:   }
62: 
63:   void toggleSoundsOn() {
64:     soundsOn.value = !soundsOn.value;
65:     _store.saveSoundsOn(soundsOn.value);
66:   }
67: 
68:   /// Asynchronously loads values from the injected persistence store.
69:   Future<void> _loadStateFromPersistence() async {
70:     final loadedValues = await Future.wait([
71:       _store.getAudioOn(defaultValue: true).then((value) {
72:         if (kIsWeb) {
73:           // On the web, sound can only start after user interaction, so
74:           // we start muted there on every game start.
75:           return audioOn.value = false;
76:         }
77:         // On other platforms, we can use the persisted value.
78:         return audioOn.value = value;
79:       }),
80:       _store
81:           .getSoundsOn(defaultValue: true)
82:           .then((value) => soundsOn.value = value),
83:       _store
84:           .getMusicOn(defaultValue: true)
85:           .then((value) => musicOn.value = value),
86:       _store.getPlayerName().then((value) => playerName.value = value),
87:     ]);
88: 
89:     _log.fine(() => 'Loaded settings: $loadedValues');
90:   }
91: }
````

## File: templates/basic/lib/style/confetti.dart
````dart
  1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
  2: // for details. All rights reserved. Use of this source code is governed by a
  3: // BSD-style license that can be found in the LICENSE file.
  4: 
  5: import 'dart:collection';
  6: import 'dart:math';
  7: 
  8: import 'package:flutter/widgets.dart';
  9: 
 10: /// Shows a confetti (celebratory) animation: paper snippings falling down.
 11: ///
 12: /// The widget fills the available space (like [SizedBox.expand] would).
 13: ///
 14: /// When [isStopped] is `true`, the animation will not run. This is useful
 15: /// when the widget is not visible yet, for example. Provide [colors]
 16: /// to make the animation look good in context.
 17: ///
 18: /// This is a partial port of this CodePen by Hemn Chawroka:
 19: /// https://codepen.io/iprodev/pen/azpWBr
 20: class Confetti extends StatefulWidget {
 21:   static const _defaultColors = [
 22:     Color(0xffd10841),
 23:     Color(0xff1d75fb),
 24:     Color(0xff0050bc),
 25:     Color(0xffa2dcc7),
 26:   ];
 27: 
 28:   final bool isStopped;
 29: 
 30:   final List<Color> colors;
 31: 
 32:   const Confetti({
 33:     this.colors = _defaultColors,
 34:     this.isStopped = false,
 35:     super.key,
 36:   });
 37: 
 38:   @override
 39:   State<Confetti> createState() => _ConfettiState();
 40: }
 41: 
 42: class ConfettiPainter extends CustomPainter {
 43:   final defaultPaint = Paint();
 44: 
 45:   final int snippingsCount = 200;
 46: 
 47:   late final List<_PaperSnipping> _snippings;
 48: 
 49:   Size? _size;
 50: 
 51:   DateTime _lastTime = DateTime.now();
 52: 
 53:   final UnmodifiableListView<Color> colors;
 54: 
 55:   ConfettiPainter(
 56:       {required Listenable animation, required Iterable<Color> colors})
 57:       : colors = UnmodifiableListView(colors),
 58:         super(repaint: animation);
 59: 
 60:   @override
 61:   void paint(Canvas canvas, Size size) {
 62:     if (_size == null) {
 63:       // First time we have a size.
 64:       _snippings = List.generate(
 65:           snippingsCount,
 66:           (i) => _PaperSnipping(
 67:                 frontColor: colors[i % colors.length],
 68:                 bounds: size,
 69:               ));
 70:     }
 71: 
 72:     final didResize = _size != null && _size != size;
 73:     final now = DateTime.now();
 74:     final dt = now.difference(_lastTime);
 75:     for (final snipping in _snippings) {
 76:       if (didResize) {
 77:         snipping.updateBounds(size);
 78:       }
 79:       snipping.update(dt.inMilliseconds / 1000);
 80:       snipping.draw(canvas);
 81:     }
 82: 
 83:     _size = size;
 84:     _lastTime = now;
 85:   }
 86: 
 87:   @override
 88:   bool shouldRepaint(covariant CustomPainter oldDelegate) {
 89:     return true;
 90:   }
 91: }
 92: 
 93: class _ConfettiState extends State<Confetti>
 94:     with SingleTickerProviderStateMixin {
 95:   late AnimationController _controller;
 96: 
 97:   @override
 98:   Widget build(BuildContext context) {
 99:     return CustomPaint(
100:       painter: ConfettiPainter(
101:         colors: widget.colors,
102:         animation: _controller,
103:       ),
104:       willChange: true,
105:       child: const SizedBox.expand(),
106:     );
107:   }
108: 
109:   @override
110:   void didUpdateWidget(covariant Confetti oldWidget) {
111:     super.didUpdateWidget(oldWidget);
112:     if (oldWidget.isStopped && !widget.isStopped) {
113:       _controller.repeat();
114:     } else if (!oldWidget.isStopped && widget.isStopped) {
115:       _controller.stop(canceled: false);
116:     }
117:   }
118: 
119:   @override
120:   void dispose() {
121:     _controller.dispose();
122:     super.dispose();
123:   }
124: 
125:   @override
126:   void initState() {
127:     super.initState();
128:     _controller = AnimationController(
129:       // We don't really care about the duration, since we're going to
130:       // use the controller on loop anyway.
131:       duration: const Duration(seconds: 1),
132:       vsync: this,
133:     );
134: 
135:     if (!widget.isStopped) {
136:       _controller.repeat();
137:     }
138:   }
139: }
140: 
141: class _PaperSnipping {
142:   static final Random _random = Random();
143: 
144:   static const degToRad = pi / 180;
145: 
146:   static const backSideBlend = Color(0x70EEEEEE);
147: 
148:   Size _bounds;
149: 
150:   late final _Vector position = _Vector(
151:     _random.nextDouble() * _bounds.width,
152:     _random.nextDouble() * _bounds.height,
153:   );
154: 
155:   final double rotationSpeed = 800 + _random.nextDouble() * 600;
156: 
157:   final double angle = _random.nextDouble() * 360 * degToRad;
158: 
159:   double rotation = _random.nextDouble() * 360 * degToRad;
160: 
161:   double cosA = 1.0;
162: 
163:   final double size = 7.0;
164: 
165:   final double oscillationSpeed = 0.5 + _random.nextDouble() * 1.5;
166: 
167:   final double xSpeed = 40;
168: 
169:   final double ySpeed = 50 + _random.nextDouble() * 60;
170: 
171:   late List<_Vector> corners = List.generate(4, (i) {
172:     final angle = this.angle + degToRad * (45 + i * 90);
173:     return _Vector(cos(angle), sin(angle));
174:   });
175: 
176:   double time = _random.nextDouble();
177: 
178:   final Color frontColor;
179: 
180:   late final Color backColor = Color.alphaBlend(backSideBlend, frontColor);
181: 
182:   final paint = Paint()..style = PaintingStyle.fill;
183: 
184:   _PaperSnipping({
185:     required this.frontColor,
186:     required Size bounds,
187:   }) : _bounds = bounds;
188: 
189:   void draw(Canvas canvas) {
190:     if (cosA > 0) {
191:       paint.color = frontColor;
192:     } else {
193:       paint.color = backColor;
194:     }
195: 
196:     final path = Path()
197:       ..addPolygon(
198:         List.generate(
199:             4,
200:             (index) => Offset(
201:                   position.x + corners[index].x * size,
202:                   position.y + corners[index].y * size * cosA,
203:                 )),
204:         true,
205:       );
206:     canvas.drawPath(path, paint);
207:   }
208: 
209:   void update(double dt) {
210:     time += dt;
211:     rotation += rotationSpeed * dt;
212:     cosA = cos(degToRad * rotation);
213:     position.x += cos(time * oscillationSpeed) * xSpeed * dt;
214:     position.y += ySpeed * dt;
215:     if (position.y > _bounds.height) {
216:       // Move the snipping back to the top.
217:       position.x = _random.nextDouble() * _bounds.width;
218:       position.y = 0;
219:     }
220:   }
221: 
222:   void updateBounds(Size newBounds) {
223:     if (!newBounds.contains(Offset(position.x, position.y))) {
224:       position.x = _random.nextDouble() * newBounds.width;
225:       position.y = _random.nextDouble() * newBounds.height;
226:     }
227:     _bounds = newBounds;
228:   }
229: }
230: 
231: class _Vector {
232:   double x, y;
233:   _Vector(this.x, this.y);
234: }
````

## File: templates/basic/lib/style/my_button.dart
````dart
 1: // Copyright 2023, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: import 'dart:math';
 6: 
 7: import 'package:flutter/material.dart';
 8: 
 9: class MyButton extends StatefulWidget {
10:   final Widget child;
11: 
12:   final VoidCallback? onPressed;
13: 
14:   const MyButton({super.key, required this.child, this.onPressed});
15: 
16:   @override
17:   State<MyButton> createState() => _MyButtonState();
18: }
19: 
20: class _MyButtonState extends State<MyButton>
21:     with SingleTickerProviderStateMixin {
22:   late final AnimationController _controller = AnimationController(
23:     duration: const Duration(milliseconds: 300),
24:     vsync: this,
25:   );
26: 
27:   @override
28:   void dispose() {
29:     _controller.dispose();
30:     super.dispose();
31:   }
32: 
33:   @override
34:   Widget build(BuildContext context) {
35:     return MouseRegion(
36:       onEnter: (event) {
37:         _controller.repeat();
38:       },
39:       onExit: (event) {
40:         _controller.stop(canceled: false);
41:       },
42:       child: RotationTransition(
43:         turns: _controller.drive(const _MySineTween(0.005)),
44:         child: FilledButton(
45:           onPressed: widget.onPressed,
46:           child: widget.child,
47:         ),
48:       ),
49:     );
50:   }
51: }
52: 
53: class _MySineTween extends Animatable<double> {
54:   final double maxExtent;
55: 
56:   const _MySineTween(this.maxExtent);
57: 
58:   @override
59:   double transform(double t) {
60:     return sin(t * 2 * pi) * maxExtent;
61:   }
62: }
````

## File: templates/basic/lib/style/my_transition.dart
````dart
 1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: import 'package:flutter/material.dart';
 6: import 'package:go_router/go_router.dart';
 7: 
 8: CustomTransitionPage<T> buildMyTransition<T>({
 9:   required Widget child,
10:   required Color color,
11:   String? name,
12:   Object? arguments,
13:   String? restorationId,
14:   LocalKey? key,
15: }) {
16:   return CustomTransitionPage<T>(
17:     child: child,
18:     transitionsBuilder: (context, animation, secondaryAnimation, child) {
19:       return _MyReveal(
20:         animation: animation,
21:         color: color,
22:         child: child,
23:       );
24:     },
25:     key: key,
26:     name: name,
27:     arguments: arguments,
28:     restorationId: restorationId,
29:     transitionDuration: const Duration(milliseconds: 700),
30:   );
31: }
32: 
33: class _MyReveal extends StatelessWidget {
34:   final Widget child;
35: 
36:   final Animation<double> animation;
37: 
38:   final Color color;
39: 
40:   final _slideTween = Tween(begin: const Offset(0, -1), end: Offset.zero);
41: 
42:   final _fadeTween = TweenSequence([
43:     TweenSequenceItem(tween: ConstantTween(0.0), weight: 1),
44:     TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0), weight: 1),
45:   ]);
46: 
47:   _MyReveal({
48:     required this.child,
49:     required this.animation,
50:     required this.color,
51:   });
52: 
53:   @override
54:   Widget build(BuildContext context) {
55:     return Stack(
56:       fit: StackFit.expand,
57:       children: [
58:         SlideTransition(
59:           position: _slideTween.animate(
60:             CurvedAnimation(
61:               parent: animation,
62:               curve: Curves.easeOutCubic,
63:               reverseCurve: Curves.easeOutCubic,
64:             ),
65:           ),
66:           child: Container(
67:             color: color,
68:           ),
69:         ),
70:         FadeTransition(
71:           opacity: _fadeTween.animate(animation),
72:           child: child,
73:         ),
74:       ],
75:     );
76:   }
77: }
````

## File: templates/basic/lib/style/palette.dart
````dart
 1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: import 'package:flutter/material.dart';
 6: 
 7: /// A palette of colors to be used in the game.
 8: ///
 9: /// The reason we're not going with something like Material Design's
10: /// `Theme` is simply that this is simpler to work with and yet gives
11: /// us everything we need for a game.
12: ///
13: /// Games generally have more radical color palettes than apps. For example,
14: /// every level of a game can have radically different colors.
15: /// At the same time, games rarely support dark mode.
16: ///
17: /// Colors taken from this fun palette:
18: /// https://lospec.com/palette-list/crayola84
19: ///
20: /// Colors here are implemented as getters so that hot reloading works.
21: /// In practice, we could just as easily implement the colors
22: /// as `static const`. But this way the palette is more malleable:
23: /// we could allow players to customize colors, for example,
24: /// or even get the colors from the network.
25: class Palette {
26:   Color get pen => const Color(0xff1d75fb);
27:   Color get darkPen => const Color(0xFF0050bc);
28:   Color get redPen => const Color(0xFFd10841);
29:   Color get inkFullOpacity => const Color(0xff352b42);
30:   Color get ink => const Color(0xee352b42);
31:   Color get backgroundMain => const Color(0xffffffd1);
32:   Color get backgroundLevelSelection => const Color(0xffa2dcc7);
33:   Color get backgroundPlaySession => const Color(0xffffebb5);
34:   Color get background4 => const Color(0xffffd7ff);
35:   Color get backgroundSettings => const Color(0xffbfc8e3);
36:   Color get trueWhite => const Color(0xffffffff);
37: }
````

## File: templates/basic/lib/style/responsive_screen.dart
````dart
  1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
  2: // for details. All rights reserved. Use of this source code is governed by a
  3: // BSD-style license that can be found in the LICENSE file.
  4: 
  5: import 'package:flutter/material.dart';
  6: 
  7: /// A widget that makes it easy to create a screen with a square-ish
  8: /// main area, a smaller menu area, and a small area for a message on top.
  9: /// It works in both orientations on mobile- and tablet-sized screens.
 10: class ResponsiveScreen extends StatelessWidget {
 11:   /// This is the "hero" of the screen. It's more or less square, and will
 12:   /// be placed in the visual "center" of the screen.
 13:   final Widget squarishMainArea;
 14: 
 15:   /// The second-largest area after [squarishMainArea]. It can be narrow
 16:   /// or wide.
 17:   final Widget rectangularMenuArea;
 18: 
 19:   /// An area reserved for some static text close to the top of the screen.
 20:   final Widget topMessageArea;
 21: 
 22:   const ResponsiveScreen({
 23:     required this.squarishMainArea,
 24:     required this.rectangularMenuArea,
 25:     this.topMessageArea = const SizedBox.shrink(),
 26:     super.key,
 27:   });
 28: 
 29:   @override
 30:   Widget build(BuildContext context) {
 31:     return LayoutBuilder(
 32:       builder: (context, constraints) {
 33:         // This widget wants to fill the whole screen.
 34:         final size = constraints.biggest;
 35:         final padding = EdgeInsets.all(size.shortestSide / 30);
 36: 
 37:         if (size.height >= size.width) {
 38:           // "Portrait" / "mobile" mode.
 39:           return Column(
 40:             crossAxisAlignment: CrossAxisAlignment.stretch,
 41:             children: [
 42:               SafeArea(
 43:                 bottom: false,
 44:                 child: Padding(
 45:                   padding: padding,
 46:                   child: topMessageArea,
 47:                 ),
 48:               ),
 49:               Expanded(
 50:                 child: SafeArea(
 51:                   top: false,
 52:                   bottom: false,
 53:                   minimum: padding,
 54:                   child: squarishMainArea,
 55:                 ),
 56:               ),
 57:               SafeArea(
 58:                 top: false,
 59:                 maintainBottomViewPadding: true,
 60:                 child: Padding(
 61:                   padding: padding,
 62:                   child: Center(
 63:                     child: rectangularMenuArea,
 64:                   ),
 65:                 ),
 66:               ),
 67:             ],
 68:           );
 69:         } else {
 70:           // "Landscape" / "tablet" mode.
 71:           final isLarge = size.width > 900;
 72: 
 73:           return Row(
 74:             crossAxisAlignment: CrossAxisAlignment.stretch,
 75:             children: [
 76:               Expanded(
 77:                 flex: isLarge ? 7 : 5,
 78:                 child: SafeArea(
 79:                   right: false,
 80:                   maintainBottomViewPadding: true,
 81:                   minimum: padding,
 82:                   child: squarishMainArea,
 83:                 ),
 84:               ),
 85:               Expanded(
 86:                 flex: 3,
 87:                 child: Column(
 88:                   children: [
 89:                     SafeArea(
 90:                       bottom: false,
 91:                       left: false,
 92:                       maintainBottomViewPadding: true,
 93:                       child: Padding(
 94:                         padding: padding,
 95:                         child: topMessageArea,
 96:                       ),
 97:                     ),
 98:                     Expanded(
 99:                       child: SafeArea(
100:                         top: false,
101:                         left: false,
102:                         maintainBottomViewPadding: true,
103:                         child: Align(
104:                           alignment: Alignment.bottomCenter,
105:                           child: Padding(
106:                             padding: padding,
107:                             child: rectangularMenuArea,
108:                           ),
109:                         ),
110:                       ),
111:                     )
112:                   ],
113:                 ),
114:               ),
115:             ],
116:           );
117:         }
118:       },
119:     );
120:   }
121: }
````

## File: templates/basic/lib/win_game/win_game_screen.dart
````dart
 1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: import 'package:flutter/material.dart';
 6: import 'package:go_router/go_router.dart';
 7: import 'package:provider/provider.dart';
 8: 
 9: import '../game_internals/score.dart';
10: import '../style/my_button.dart';
11: import '../style/palette.dart';
12: import '../style/responsive_screen.dart';
13: 
14: class WinGameScreen extends StatelessWidget {
15:   final Score score;
16: 
17:   const WinGameScreen({
18:     super.key,
19:     required this.score,
20:   });
21: 
22:   @override
23:   Widget build(BuildContext context) {
24:     final palette = context.watch<Palette>();
25: 
26:     const gap = SizedBox(height: 10);
27: 
28:     return Scaffold(
29:       backgroundColor: palette.backgroundPlaySession,
30:       body: ResponsiveScreen(
31:         squarishMainArea: Column(
32:           mainAxisAlignment: MainAxisAlignment.center,
33:           children: <Widget>[
34:             gap,
35:             const Center(
36:               child: Text(
37:                 'You won!',
38:                 style: TextStyle(fontFamily: 'Permanent Marker', fontSize: 50),
39:               ),
40:             ),
41:             gap,
42:             Center(
43:               child: Text(
44:                 'Score: ${score.score}\n'
45:                 'Time: ${score.formattedTime}',
46:                 style: const TextStyle(
47:                     fontFamily: 'Permanent Marker', fontSize: 20),
48:               ),
49:             ),
50:           ],
51:         ),
52:         rectangularMenuArea: MyButton(
53:           onPressed: () {
54:             GoRouter.of(context).go('/play');
55:           },
56:           child: const Text('Continue'),
57:         ),
58:       ),
59:     );
60:   }
61: }
````

## File: templates/basic/lib/main.dart
````dart
  1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
  2: // for details. All rights reserved. Use of this source code is governed by a
  3: // BSD-style license that can be found in the LICENSE file.
  4: 
  5: import 'dart:developer' as dev;
  6: 
  7: import 'package:flutter/foundation.dart';
  8: import 'package:flutter/material.dart';
  9: import 'package:flutter/services.dart';
 10: import 'package:logging/logging.dart';
 11: import 'package:provider/provider.dart';
 12: 
 13: import 'app_lifecycle/app_lifecycle.dart';
 14: import 'audio/audio_controller.dart';
 15: import 'player_progress/player_progress.dart';
 16: import 'router.dart';
 17: import 'settings/settings.dart';
 18: import 'style/palette.dart';
 19: 
 20: void main() async {
 21:   // Basic logging setup.
 22:   Logger.root.level = kDebugMode ? Level.FINE : Level.INFO;
 23:   Logger.root.onRecord.listen((record) {
 24:     dev.log(
 25:       record.message,
 26:       time: record.time,
 27:       level: record.level.value,
 28:       name: record.loggerName,
 29:     );
 30:   });
 31: 
 32:   WidgetsFlutterBinding.ensureInitialized();
 33:   // Put game into full screen mode on mobile devices.
 34:   await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
 35:   // Lock the game to portrait mode on mobile devices.
 36:   await SystemChrome.setPreferredOrientations([
 37:     DeviceOrientation.portraitUp,
 38:     DeviceOrientation.portraitDown,
 39:   ]);
 40: 
 41:   runApp(MyApp());
 42: }
 43: 
 44: class MyApp extends StatelessWidget {
 45:   const MyApp({super.key});
 46: 
 47:   @override
 48:   Widget build(BuildContext context) {
 49:     return AppLifecycleObserver(
 50:       child: MultiProvider(
 51:         // This is where you add objects that you want to have available
 52:         // throughout your game.
 53:         //
 54:         // Every widget in the game can access these objects by calling
 55:         // `context.watch()` or `context.read()`.
 56:         // See `lib/main_menu/main_menu_screen.dart` for example usage.
 57:         providers: [
 58:           Provider(create: (context) => SettingsController()),
 59:           Provider(create: (context) => Palette()),
 60:           ChangeNotifierProvider(create: (context) => PlayerProgress()),
 61:           // Set up audio.
 62:           ProxyProvider2<AppLifecycleStateNotifier, SettingsController,
 63:               AudioController>(
 64:             create: (context) => AudioController(),
 65:             update: (context, lifecycleNotifier, settings, audio) {
 66:               audio!.attachDependencies(lifecycleNotifier, settings);
 67:               return audio;
 68:             },
 69:             dispose: (context, audio) => audio.dispose(),
 70:             // Ensures that music starts immediately.
 71:             lazy: false,
 72:           ),
 73:         ],
 74:         child: Builder(builder: (context) {
 75:           final palette = context.watch<Palette>();
 76: 
 77:           return MaterialApp.router(
 78:             title: 'My Flutter Game',
 79:             theme: ThemeData.from(
 80:               colorScheme: ColorScheme.fromSeed(
 81:                 seedColor: palette.darkPen,
 82:                 surface: palette.backgroundMain,
 83:               ),
 84:               textTheme: TextTheme(
 85:                 bodyMedium: TextStyle(color: palette.ink),
 86:               ),
 87:               useMaterial3: true,
 88:             ).copyWith(
 89:               // Make buttons more fun.
 90:               filledButtonTheme: FilledButtonThemeData(
 91:                 style: FilledButton.styleFrom(
 92:                   textStyle: TextStyle(
 93:                     fontWeight: FontWeight.bold,
 94:                     fontSize: 20,
 95:                   ),
 96:                 ),
 97:               ),
 98:             ),
 99:             routerConfig: router,
100:           );
101:         }),
102:       ),
103:     );
104:   }
105: }
````

## File: templates/basic/lib/router.dart
````dart
 1: // Copyright 2023, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: import 'package:flutter/foundation.dart';
 6: import 'package:go_router/go_router.dart';
 7: import 'package:provider/provider.dart';
 8: 
 9: import 'game_internals/score.dart';
10: import 'level_selection/level_selection_screen.dart';
11: import 'level_selection/levels.dart';
12: import 'main_menu/main_menu_screen.dart';
13: import 'play_session/play_session_screen.dart';
14: import 'settings/settings_screen.dart';
15: import 'style/my_transition.dart';
16: import 'style/palette.dart';
17: import 'win_game/win_game_screen.dart';
18: 
19: /// The router describes the game's navigational hierarchy, from the main
20: /// screen through settings screens all the way to each individual level.
21: final router = GoRouter(
22:   routes: [
23:     GoRoute(
24:       path: '/',
25:       builder: (context, state) => const MainMenuScreen(key: Key('main menu')),
26:       routes: [
27:         GoRoute(
28:             path: 'play',
29:             pageBuilder: (context, state) => buildMyTransition<void>(
30:                   key: const ValueKey('play'),
31:                   color: context.watch<Palette>().backgroundLevelSelection,
32:                   child: const LevelSelectionScreen(
33:                     key: Key('level selection'),
34:                   ),
35:                 ),
36:             routes: [
37:               GoRoute(
38:                 path: 'session/:level',
39:                 pageBuilder: (context, state) {
40:                   final levelNumber = int.parse(state.pathParameters['level']!);
41:                   final level =
42:                       gameLevels.singleWhere((e) => e.number == levelNumber);
43:                   return buildMyTransition<void>(
44:                     key: const ValueKey('level'),
45:                     color: context.watch<Palette>().backgroundPlaySession,
46:                     child: PlaySessionScreen(
47:                       level,
48:                       key: const Key('play session'),
49:                     ),
50:                   );
51:                 },
52:               ),
53:               GoRoute(
54:                 path: 'won',
55:                 redirect: (context, state) {
56:                   if (state.extra == null) {
57:                     // Trying to navigate to a win screen without any data.
58:                     // Possibly by using the browser's back button.
59:                     return '/';
60:                   }
61: 
62:                   // Otherwise, do not redirect.
63:                   return null;
64:                 },
65:                 pageBuilder: (context, state) {
66:                   final map = state.extra! as Map<String, dynamic>;
67:                   final score = map['score'] as Score;
68: 
69:                   return buildMyTransition<void>(
70:                     key: const ValueKey('won'),
71:                     color: context.watch<Palette>().backgroundPlaySession,
72:                     child: WinGameScreen(
73:                       score: score,
74:                       key: const Key('win game'),
75:                     ),
76:                   );
77:                 },
78:               )
79:             ]),
80:         GoRoute(
81:           path: 'settings',
82:           builder: (context, state) =>
83:               const SettingsScreen(key: Key('settings')),
84:         ),
85:       ],
86:     ),
87:   ],
88: );
````

## File: templates/basic/test/smoke_test.dart
````dart
 1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: import 'package:basic/main.dart';
 6: import 'package:flutter_test/flutter_test.dart';
 7: 
 8: void main() {
 9:   testWidgets('smoke test', (tester) async {
10:     // Build our game and trigger a frame.
11:     await tester.pumpWidget(MyApp());
12: 
13:     // Verify that the 'Play' button is shown.
14:     expect(find.text('Play'), findsOneWidget);
15: 
16:     // Verify that the 'Settings' button is shown.
17:     expect(find.text('Settings'), findsOneWidget);
18: 
19:     // Go to 'Settings'.
20:     await tester.tap(find.text('Settings'));
21:     await tester.pumpAndSettle();
22:     expect(find.text('Music'), findsOneWidget);
23: 
24:     // Go back to main menu.
25:     await tester.tap(find.text('Back'));
26:     await tester.pumpAndSettle();
27: 
28:     // Tap 'Play'.
29:     await tester.tap(find.text('Play'));
30:     await tester.pumpAndSettle();
31:     expect(find.text('Select level'), findsOneWidget);
32: 
33:     // Tap level 1.
34:     await tester.tap(find.text('Level #1'));
35:     await tester.pumpAndSettle();
36: 
37:     // Find the first level's "tutorial" text.
38:     expect(find.text('Drag the slider to 5% or above!'), findsOneWidget);
39:   });
40: }
````

## File: templates/basic/analysis_options.yaml
````yaml
 1: include: package:flutter_lints/flutter.yaml
 2: 
 3: analyzer:
 4:   language:
 5:     strict-casts: true
 6: 
 7: linter:
 8:   rules:
 9:     # Remove or force lint rules by adding lines like the following.
10:     # The lints below are disabled in order to make things smoother in early
11:     # development. Consider enabling them once development is further along.
12:     prefer_const_constructors: false  # Annoying in early development
````

## File: templates/basic/pubspec.yaml
````yaml
 1: name: basic
 2: description: A basic game built in Flutter.
 3: 
 4: # Prevent accidental publishing to pub.dev.
 5: publish_to: 'none'
 6: 
 7: version: 0.0.1+1
 8: 
 9: environment:
10:   sdk: ^3.5.0
11: 
12: dependencies:
13:   flutter:
14:     sdk: flutter
15: 
16:   audioplayers: ^6.0.0
17:   go_router: ^14.0.0
18:   logging: ^1.2.0
19:   provider: ^6.1.2
20:   shared_preferences: ^2.2.3
21: 
22: dev_dependencies:
23:   flutter_lints: ^5.0.0
24:   flutter_test:
25:     sdk: flutter
26:   flutter_launcher_icons: ^0.14.0
27:   test: ^1.24.3
28: 
29: flutter:
30:   uses-material-design: true
31: 
32:   assets:
33:     - assets/images/
34:     - assets/music/
35:     - assets/sfx/
36: 
37:   fonts:
38:     - family: Permanent Marker
39:       fonts:
40:         - asset: assets/fonts/Permanent_Marker/PermanentMarker-Regular.ttf
41: 
42: flutter_launcher_icons:
43:   android: true
44:   ios: true
45:   image_path: "assets/icons/icon.png"
46:   adaptive_icon_background: "#FFFFFF"
47:   adaptive_icon_foreground: "assets/icons/icon-adaptive-foreground.png"
````

## File: templates/basic/README.md
````markdown
  1: A starter Flutter project with a minimal shell of a game
  2: including the following features:
  3: 
  4: - main menu screen
  5: - basic navigation
  6: - game-y theming
  7: - settings
  8: - sound
  9: 
 10: You can jump directly into building your game in `lib/play_session/`.
 11: 
 12: When you're ready for things like ads, in-app purchases, achievements,
 13: analytics, crash reporting, and so on, 
 14: there are resources ready for you
 15: at [flutter.dev/games](https://flutter.dev/games).
 16: 
 17: 
 18: ## How to get this sample
 19: 
 20: You can clone this whole repository and find this sample in your local copy.
 21: 
 22: For convenience, though, we also provide a command line tool that downloads
 23: just the project you want.
 24: 
 25: On the command line, while having the
 26: [Flutter SDK installed](https://docs.flutter.dev/get-started/install),
 27: run the following command:
 28: 
 29: ```shell
 30: dart pub global activate sample_downloader
 31: ```
 32: 
 33: Then, from any directory, run the newly installed tool
 34: and follow its instructions.
 35: 
 36: ```shell
 37: sample_downloader
 38: ```
 39: 
 40: 
 41: # Development
 42: 
 43: To run the app in debug mode:
 44: 
 45:     flutter run
 46: 
 47: It is often convenient to develop your game as a desktop app.
 48: For example, you can run `flutter run -d macOS`, and get the same UI
 49: in a desktop window on a Mac. That way, you don't need to use a
 50: simulator/emulator or attach a mobile device.
 51: 
 52: 
 53: ## Code organization
 54: 
 55: Code is organized in a loose and shallow feature-first fashion.
 56: In `lib/`, you'll therefore find directories such as `audio`,
 57: `main_menu` or `settings`. Nothing fancy, but usable.
 58: 
 59: ```text
 60: lib
 61: ├── app_lifecycle
 62: ├── audio
 63: ├── game_internals
 64: ├── level_selection
 65: ├── main_menu
 66: ├── play_session
 67: ├── player_progress
 68: ├── settings
 69: ├── style
 70: ├── win_game
 71: │
 72: ├── main.dart
 73: └── router.dart
 74: ```
 75: 
 76: The state management approach is intentionally low-level. That way, it's easy to
 77: take this project and run with it, without having to learn new paradigms, or having
 78: to remember to run `flutter pub run build_runner watch`. You are,
 79: of course, encouraged to use whatever paradigm, helper package or code generation
 80: scheme that you prefer.
 81: 
 82: 
 83: ## Building for production
 84: 
 85: To build the app for iOS (and open Xcode when finished):
 86: 
 87: ```shell
 88: flutter build ipa && open build/ios/archive/Runner.xcarchive
 89: ```
 90: 
 91: To build the app for Android (and open the folder with the bundle when finished):
 92: 
 93: ```shell
 94: flutter build appbundle && open build/app/outputs/bundle/release
 95: ```
 96: 
 97: While the template is primarily meant for mobile games, you can also publish
 98: for the web. This might be useful for web-based demos, for example,
 99: or for rapid play-testing. The following command requires installing
100: [`peanut`](https://pub.dev/packages/peanut/install).
101: 
102: ```bash
103: flutter pub global run peanut \
104: --web-renderer canvaskit \
105: --extra-args "--base-href=/name_of_your_github_repo/" \
106: && git push origin --set-upstream gh-pages
107: ```
108: 
109: The last line of the command above automatically pushes
110: your newly built web game to GitHub pages, assuming that you have
111: that set up.
112: 
113: Lastly, it is of course possible to build your game for desktop platforms:
114: Windows, Linux and macOS. 
115: Follow the [standard instructions](https://docs.flutter.dev/platform-integration/desktop).
116: 
117: 
118: # Integrations
119: 
120: Focus on making your core gameplay fun first. Don't worry about
121: integrations like ads, in-app purchases, analytics, and so on.
122: It's easy to add them later, and you can find recipes and codelabs
123: for them at [flutter.dev/games](https://flutter.dev/games).
124: 
125: Change the package name of your game
126: before you start any of the deeper integrations.
127: [StackOverflow has instructions](https://stackoverflow.com/a/51550358/1416886)
128: for this, and the [`rename`](https://pub.dev/packages/rename) tool
129: (on pub.dev) automates the process.
130: 
131: 
132: ## Audio
133: 
134: Audio is enabled by default and ready to go. You can modify code
135: in `lib/audio/` to your liking.
136: 
137: You can find some music
138: tracks in `assets/music` — these are Creative Commons Attribution (CC-BY)
139: licensed, and are included in this repository with permission. If you decide
140: to keep these tracks in your game, please don't forget to give credit
141: to the musician, [Mr Smith][].
142: 
143: [Mr Smith]: https://freemusicarchive.org/music/mr-smith
144: 
145: The repository also includes a few sound effect samples in `assets/sfx`.
146: These are public domain (CC0) and you will almost surely want to replace
147: them because they're just recordings of a developer doing silly sounds
148: with their mouth.
149: 
150: ## Logging
151: 
152: The template uses the [`logging`](https://pub.dev/packages/logging) package
153: to log messages to the console. This makes it very easy to log messages
154: from anywhere with something like the following:
155: 
156: ```dart
157: import 'package:logging/logging.dart';
158: 
159: final _log = Logger('Foo');
160: 
161: void foo() {
162:   _log.info('Hello, world!');
163: }
164: ```
165: 
166: This will show up in the console as:
167: 
168: ```text
169: [Foo] Hello, world!
170: ```
171: 
172: When using Flutter DevTools, all the metadata of the log message is preserved, 
173: so you can filter by logger name, log level, and so on.
174: 
175: Later, when you're closer to production, you can gather these log messages
176: (see `lib/main.dart`) and send them to a service like Firebase Crashlytics
177: when appropriate.
178: See [`firebase_crashlytics`](https://pub.dev/packages/firebase_crashlytics)
179: for more information.
180: 
181: 
182: ## Settings
183: 
184: The settings page is enabled by default, and accessible both
185: from the main menu and through the "gear" button in the play session screen.
186: 
187: Settings are saved to local storage using the 
188: [`shared_preferences`](https://pub.dev/packages/shared_preferences)
189: package.
190: To change what preferences are saved and how, edit files in
191: `lib/settings/persistence`.
192: 
193: 
194: # Icon
195: 
196: To update the launcher icon, first change the files
197: `assets/icon-adaptive-foreground.png` and `assets/icon.png`.
198: Then, run the following:
199: 
200: ```bash
201: dart run flutter_launcher_icons:main
202: ```
203: 
204: You can [configure](https://github.com/fluttercommunity/flutter_launcher_icons#book-guide)
205: the look of the icon in the `flutter_icons:` section of `pubspec.yaml`.
206: 
207: 
208: # Troubleshooting
209: 
210: ## CocoaPods
211: 
212: When upgrading to higher versions of Flutter or plugins, you might encounter an error when
213: building the iOS or macOS app. A good first thing to try is to delete the `ios/Podfile.lock`
214: file (or `macos/Podfile.lock`, respectively), then trying to build again. (You can achieve
215: a more thorough cleanup by running `flutter clean` instead.)
216: 
217: If this doesn't help, here are some more methods:
218: 
219: - See if everything is still okay with your Flutter and CocoaPods installation
220:   by running `flutter doctor`. Revisit the macOS 
221:   [Flutter installation guide](https://docs.flutter.dev/get-started/install/macos)
222:   if needed.
223: - Update CocoaPods specs directory:
224: 
225:   ```sh
226:   cd ios
227:   pod repo update
228:   cd ..
229:   ```
230: 
231:   (Substitute `ios` for `macos` when appropriate.)
232: - Open the project in Xcode, 
233:   [increase the build target](https://stackoverflow.com/a/38602597/1416886),
234:   then select _Product_ > _Clean Build Folder_.
235: 
236: ## Warnings in console
237: 
238: When running the game for the first time, you might see warnings like the following:
239: 
240: > Note: Some input files use or override a deprecated API.
241: 
242: or
243: 
244: > warning: 'viewState' was deprecated in macOS 11.0: Use -initWithState: instead
245: 
246: These warning come from the various plugins that are used by the template. They are not harmful 
247: and can be ignored. The warnings are meant for the plugin authors, not for you, the game developer.
````

## File: templates/card/assets/music/README.md
````markdown
1: Music in the template is by Mr Smith, and licensed under Creative Commons
2: Attribution 4.0 International (CC BY 4.0).
3: 
4: https://freemusicarchive.org/music/mr-smith
5: 
6: Mr Smith's music is used in this template project with his explicit permission.
````

## File: templates/card/assets/sfx/README.md
````markdown
1: Sounds in this folder are made by Filip Hracek and are CC0 (Public Domain).
````

## File: templates/card/ios/Runner/Assets.xcassets/LaunchImage.imageset/README.md
````markdown
1: # Launch Screen Assets
2: 
3: You can customize the launch screen with your own desired assets by replacing the image files in this directory.
4: 
5: You can also do it by opening your Flutter project's Xcode project with `open ios/Runner.xcworkspace`, selecting `Runner/Assets.xcassets` in the Project Navigator and dropping in the desired images.
````

## File: templates/card/lib/app_lifecycle/app_lifecycle.dart
````dart
 1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: import 'package:flutter/widgets.dart';
 6: import 'package:logging/logging.dart';
 7: import 'package:provider/provider.dart';
 8: 
 9: typedef AppLifecycleStateNotifier = ValueNotifier<AppLifecycleState>;
10: 
11: class AppLifecycleObserver extends StatefulWidget {
12:   final Widget child;
13: 
14:   const AppLifecycleObserver({required this.child, super.key});
15: 
16:   @override
17:   State<AppLifecycleObserver> createState() => _AppLifecycleObserverState();
18: }
19: 
20: class _AppLifecycleObserverState extends State<AppLifecycleObserver> {
21:   static final _log = Logger('AppLifecycleObserver');
22:   late final AppLifecycleListener _appLifecycleListener;
23: 
24:   final ValueNotifier<AppLifecycleState> lifecycleListenable =
25:       ValueNotifier(AppLifecycleState.inactive);
26: 
27:   @override
28:   Widget build(BuildContext context) {
29:     // Using InheritedProvider because we don't want to use Consumer
30:     // or context.watch or anything like that to listen to this. We want
31:     // to manually add listeners. We're interested in the _events_ of lifecycle
32:     // state changes, and not so much in the state itself. (For example,
33:     // we want to stop sound when the app goes into the background, and
34:     // restart sound again when the app goes back into focus. We're not
35:     // rebuilding any widgets.)
36:     //
37:     // Provider, by default, throws when one
38:     // is trying to provide a Listenable (such as ValueNotifier) without using
39:     // something like ValueListenableProvider. InheritedProvider is more
40:     // low-level and doesn't have this problem.
41:     return InheritedProvider<AppLifecycleStateNotifier>.value(
42:       value: lifecycleListenable,
43:       child: widget.child,
44:     );
45:   }
46: 
47:   @override
48:   void dispose() {
49:     _appLifecycleListener.dispose();
50:     super.dispose();
51:   }
52: 
53:   @override
54:   void initState() {
55:     super.initState();
56:     _appLifecycleListener = AppLifecycleListener(
57:       onStateChange: (s) => lifecycleListenable.value = s,
58:     );
59:     _log.info('Subscribed to app lifecycle updates');
60:   }
61: }
````

## File: templates/card/lib/audio/audio_controller.dart
````dart
  1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
  2: // for details. All rights reserved. Use of this source code is governed by a
  3: // BSD-style license that can be found in the LICENSE file.
  4: 
  5: import 'dart:async';
  6: import 'dart:collection';
  7: import 'dart:math';
  8: 
  9: import 'package:audioplayers/audioplayers.dart';
 10: import 'package:flutter/foundation.dart';
 11: import 'package:flutter/widgets.dart';
 12: import 'package:logging/logging.dart';
 13: 
 14: import '../app_lifecycle/app_lifecycle.dart';
 15: import '../settings/settings.dart';
 16: import 'songs.dart';
 17: import 'sounds.dart';
 18: 
 19: /// Allows playing music and sound. A facade to `package:audioplayers`.
 20: class AudioController {
 21:   static final _log = Logger('AudioController');
 22: 
 23:   final AudioPlayer _musicPlayer;
 24: 
 25:   /// This is a list of [AudioPlayer] instances which are rotated to play
 26:   /// sound effects.
 27:   final List<AudioPlayer> _sfxPlayers;
 28: 
 29:   int _currentSfxPlayer = 0;
 30: 
 31:   final Queue<Song> _playlist;
 32: 
 33:   final Random _random = Random();
 34: 
 35:   SettingsController? _settings;
 36: 
 37:   ValueNotifier<AppLifecycleState>? _lifecycleNotifier;
 38: 
 39:   /// Creates an instance that plays music and sound.
 40:   ///
 41:   /// Use [polyphony] to configure the number of sound effects (SFX) that can
 42:   /// play at the same time. A [polyphony] of `1` will always only play one
 43:   /// sound (a new sound will stop the previous one). See discussion
 44:   /// of [_sfxPlayers] to learn why this is the case.
 45:   ///
 46:   /// Background music does not count into the [polyphony] limit. Music will
 47:   /// never be overridden by sound effects because that would be silly.
 48:   AudioController({int polyphony = 2})
 49:       : assert(polyphony >= 1),
 50:         _musicPlayer = AudioPlayer(playerId: 'musicPlayer'),
 51:         _sfxPlayers = Iterable.generate(
 52:                 polyphony, (i) => AudioPlayer(playerId: 'sfxPlayer#$i'))
 53:             .toList(growable: false),
 54:         _playlist = Queue.of(List<Song>.of(songs)..shuffle()) {
 55:     _musicPlayer.onPlayerComplete.listen(_handleSongFinished);
 56:     unawaited(_preloadSfx());
 57:   }
 58: 
 59:   /// Makes sure the audio controller is listening to changes
 60:   /// of both the app lifecycle (e.g. suspended app) and to changes
 61:   /// of settings (e.g. muted sound).
 62:   void attachDependencies(AppLifecycleStateNotifier lifecycleNotifier,
 63:       SettingsController settingsController) {
 64:     _attachLifecycleNotifier(lifecycleNotifier);
 65:     _attachSettings(settingsController);
 66:   }
 67: 
 68:   void dispose() {
 69:     _lifecycleNotifier?.removeListener(_handleAppLifecycle);
 70:     _stopAllSound();
 71:     _musicPlayer.dispose();
 72:     for (final player in _sfxPlayers) {
 73:       player.dispose();
 74:     }
 75:   }
 76: 
 77:   /// Plays a single sound effect, defined by [type].
 78:   ///
 79:   /// The controller will ignore this call when the attached settings'
 80:   /// [SettingsController.audioOn] is `true` or if its
 81:   /// [SettingsController.soundsOn] is `false`.
 82:   void playSfx(SfxType type) {
 83:     final audioOn = _settings?.audioOn.value ?? false;
 84:     if (!audioOn) {
 85:       _log.fine(() => 'Ignoring playing sound ($type) because audio is muted.');
 86:       return;
 87:     }
 88:     final soundsOn = _settings?.soundsOn.value ?? false;
 89:     if (!soundsOn) {
 90:       _log.fine(() =>
 91:           'Ignoring playing sound ($type) because sounds are turned off.');
 92:       return;
 93:     }
 94: 
 95:     _log.fine(() => 'Playing sound: $type');
 96:     final options = soundTypeToFilename(type);
 97:     final filename = options[_random.nextInt(options.length)];
 98:     _log.fine(() => '- Chosen filename: $filename');
 99: 
100:     final currentPlayer = _sfxPlayers[_currentSfxPlayer];
101:     currentPlayer.play(AssetSource('sfx/$filename'),
102:         volume: soundTypeToVolume(type));
103:     _currentSfxPlayer = (_currentSfxPlayer + 1) % _sfxPlayers.length;
104:   }
105: 
106:   /// Enables the [AudioController] to listen to [AppLifecycleState] events,
107:   /// and therefore do things like stopping playback when the game
108:   /// goes into the background.
109:   void _attachLifecycleNotifier(AppLifecycleStateNotifier lifecycleNotifier) {
110:     _lifecycleNotifier?.removeListener(_handleAppLifecycle);
111: 
112:     lifecycleNotifier.addListener(_handleAppLifecycle);
113:     _lifecycleNotifier = lifecycleNotifier;
114:   }
115: 
116:   /// Enables the [AudioController] to track changes to settings.
117:   /// Namely, when any of [SettingsController.audioOn],
118:   /// [SettingsController.musicOn] or [SettingsController.soundsOn] changes,
119:   /// the audio controller will act accordingly.
120:   void _attachSettings(SettingsController settingsController) {
121:     if (_settings == settingsController) {
122:       // Already attached to this instance. Nothing to do.
123:       return;
124:     }
125: 
126:     // Remove handlers from the old settings controller if present
127:     final oldSettings = _settings;
128:     if (oldSettings != null) {
129:       oldSettings.audioOn.removeListener(_audioOnHandler);
130:       oldSettings.musicOn.removeListener(_musicOnHandler);
131:       oldSettings.soundsOn.removeListener(_soundsOnHandler);
132:     }
133: 
134:     _settings = settingsController;
135: 
136:     // Add handlers to the new settings controller
137:     settingsController.audioOn.addListener(_audioOnHandler);
138:     settingsController.musicOn.addListener(_musicOnHandler);
139:     settingsController.soundsOn.addListener(_soundsOnHandler);
140: 
141:     if (settingsController.audioOn.value && settingsController.musicOn.value) {
142:       if (kIsWeb) {
143:         _log.info('On the web, music can only start after user interaction.');
144:       } else {
145:         _playCurrentSongInPlaylist();
146:       }
147:     }
148:   }
149: 
150:   void _audioOnHandler() {
151:     _log.fine('audioOn changed to ${_settings!.audioOn.value}');
152:     if (_settings!.audioOn.value) {
153:       // All sound just got un-muted. Audio is on.
154:       if (_settings!.musicOn.value) {
155:         _startOrResumeMusic();
156:       }
157:     } else {
158:       // All sound just got muted. Audio is off.
159:       _stopAllSound();
160:     }
161:   }
162: 
163:   void _handleAppLifecycle() {
164:     switch (_lifecycleNotifier!.value) {
165:       case AppLifecycleState.paused:
166:       case AppLifecycleState.detached:
167:       case AppLifecycleState.hidden:
168:         _stopAllSound();
169:       case AppLifecycleState.resumed:
170:         if (_settings!.audioOn.value && _settings!.musicOn.value) {
171:           _startOrResumeMusic();
172:         }
173:       case AppLifecycleState.inactive:
174:         // No need to react to this state change.
175:         break;
176:     }
177:   }
178: 
179:   void _handleSongFinished(void _) {
180:     _log.info('Last song finished playing.');
181:     // Move the song that just finished playing to the end of the playlist.
182:     _playlist.addLast(_playlist.removeFirst());
183:     // Play the song at the beginning of the playlist.
184:     _playCurrentSongInPlaylist();
185:   }
186: 
187:   void _musicOnHandler() {
188:     if (_settings!.musicOn.value) {
189:       // Music got turned on.
190:       if (_settings!.audioOn.value) {
191:         _startOrResumeMusic();
192:       }
193:     } else {
194:       // Music got turned off.
195:       _musicPlayer.pause();
196:     }
197:   }
198: 
199:   Future<void> _playCurrentSongInPlaylist() async {
200:     _log.info(() => 'Playing ${_playlist.first} now.');
201:     try {
202:       await _musicPlayer.play(AssetSource('music/${_playlist.first.filename}'));
203:     } catch (e) {
204:       _log.severe('Could not play song ${_playlist.first}', e);
205:     }
206:   }
207: 
208:   /// Preloads all sound effects.
209:   Future<void> _preloadSfx() async {
210:     _log.info('Preloading sound effects');
211:     // This assumes there is only a limited number of sound effects in the game.
212:     // If there are hundreds of long sound effect files, it's better
213:     // to be more selective when preloading.
214:     await AudioCache.instance.loadAll(SfxType.values
215:         .expand(soundTypeToFilename)
216:         .map((path) => 'sfx/$path')
217:         .toList());
218:   }
219: 
220:   void _soundsOnHandler() {
221:     for (final player in _sfxPlayers) {
222:       if (player.state == PlayerState.playing) {
223:         player.stop();
224:       }
225:     }
226:   }
227: 
228:   void _startOrResumeMusic() async {
229:     if (_musicPlayer.source == null) {
230:       _log.info('No music source set. '
231:           'Start playing the current song in playlist.');
232:       await _playCurrentSongInPlaylist();
233:       return;
234:     }
235: 
236:     _log.info('Resuming paused music.');
237:     try {
238:       _musicPlayer.resume();
239:     } catch (e) {
240:       // Sometimes, resuming fails with an "Unexpected" error.
241:       _log.severe('Error resuming music', e);
242:       // Try starting the song from scratch.
243:       _playCurrentSongInPlaylist();
244:     }
245:   }
246: 
247:   void _stopAllSound() {
248:     _log.info('Stopping all sound');
249:     _musicPlayer.pause();
250:     for (final player in _sfxPlayers) {
251:       player.stop();
252:     }
253:   }
254: }
````

## File: templates/card/lib/audio/songs.dart
````dart
 1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: const Set<Song> songs = {
 6:   // Filenames with whitespace break package:audioplayers on iOS
 7:   // (as of February 2022), so we use no whitespace.
 8:   Song('Mr_Smith-Azul.mp3', 'Azul', artist: 'Mr Smith'),
 9:   Song('Mr_Smith-Sonorus.mp3', 'Sonorus', artist: 'Mr Smith'),
10:   Song('Mr_Smith-Sunday_Solitude.mp3', 'SundaySolitude', artist: 'Mr Smith'),
11: };
12: 
13: class Song {
14:   final String filename;
15: 
16:   final String name;
17: 
18:   final String? artist;
19: 
20:   const Song(this.filename, this.name, {this.artist});
21: 
22:   @override
23:   String toString() => 'Song<$filename>';
24: }
````

## File: templates/card/lib/audio/sounds.dart
````dart
 1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: List<String> soundTypeToFilename(SfxType type) => switch (type) {
 6:       SfxType.huhsh => const [
 7:           'hash1.mp3',
 8:           'hash2.mp3',
 9:           'hash3.mp3',
10:         ],
11:       SfxType.wssh => const [
12:           'wssh1.mp3',
13:           'wssh2.mp3',
14:           'dsht1.mp3',
15:           'ws1.mp3',
16:           'spsh1.mp3',
17:           'hh1.mp3',
18:           'hh2.mp3',
19:           'kss1.mp3',
20:         ],
21:       SfxType.buttonTap => const [
22:           'k1.mp3',
23:           'k2.mp3',
24:           'p1.mp3',
25:           'p2.mp3',
26:         ],
27:       SfxType.congrats => const [
28:           'yay1.mp3',
29:           'wehee1.mp3',
30:           'oo1.mp3',
31:         ],
32:       SfxType.erase => const [
33:           'fwfwfwfwfw1.mp3',
34:           'fwfwfwfw1.mp3',
35:         ],
36:       SfxType.swishSwish => const [
37:           'swishswish1.mp3',
38:         ]
39:     };
40: 
41: /// Allows control over loudness of different SFX types.
42: double soundTypeToVolume(SfxType type) {
43:   switch (type) {
44:     case SfxType.huhsh:
45:       return 0.4;
46:     case SfxType.wssh:
47:       return 0.2;
48:     case SfxType.buttonTap:
49:     case SfxType.congrats:
50:     case SfxType.erase:
51:     case SfxType.swishSwish:
52:       return 1.0;
53:   }
54: }
55: 
56: enum SfxType {
57:   huhsh,
58:   wssh,
59:   buttonTap,
60:   congrats,
61:   erase,
62:   swishSwish,
63: }
````

## File: templates/card/lib/game_internals/board_state.dart
````dart
 1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: import 'package:flutter/foundation.dart';
 6: 
 7: import 'player.dart';
 8: import 'playing_area.dart';
 9: 
10: class BoardState {
11:   final VoidCallback onWin;
12: 
13:   final PlayingArea areaOne = PlayingArea();
14: 
15:   final PlayingArea areaTwo = PlayingArea();
16: 
17:   final Player player = Player();
18: 
19:   BoardState({required this.onWin}) {
20:     player.addListener(_handlePlayerChange);
21:   }
22: 
23:   List<PlayingArea> get areas => [areaOne, areaTwo];
24: 
25:   void dispose() {
26:     player.removeListener(_handlePlayerChange);
27:     areaOne.dispose();
28:     areaTwo.dispose();
29:   }
30: 
31:   void _handlePlayerChange() {
32:     if (player.hand.isEmpty) {
33:       onWin();
34:     }
35:   }
36: }
````

## File: templates/card/lib/game_internals/card_suit.dart
````dart
 1: enum CardSuit {
 2:   clubs(1),
 3:   spades(2),
 4:   hearts(3),
 5:   diamonds(4);
 6: 
 7:   final int internalRepresentation;
 8: 
 9:   const CardSuit(this.internalRepresentation);
10: 
11:   String get asCharacter => switch (this) {
12:         CardSuit.spades => '♠',
13:         CardSuit.hearts => '♥',
14:         CardSuit.diamonds => '♦',
15:         CardSuit.clubs => '♣'
16:       };
17: 
18:   CardSuitColor get color => switch (this) {
19:         CardSuit.spades || CardSuit.clubs => CardSuitColor.black,
20:         CardSuit.hearts || CardSuit.diamonds => CardSuitColor.red
21:       };
22: 
23:   @override
24:   String toString() => asCharacter;
25: }
26: 
27: enum CardSuitColor {
28:   black,
29:   red,
30: }
````

## File: templates/card/lib/game_internals/player.dart
````dart
 1: import 'package:flutter/foundation.dart';
 2: 
 3: import 'playing_card.dart';
 4: 
 5: class Player extends ChangeNotifier {
 6:   static const maxCards = 7;
 7: 
 8:   final List<PlayingCard> hand =
 9:       List.generate(maxCards, (index) => PlayingCard.random());
10: 
11:   void removeCard(PlayingCard card) {
12:     hand.remove(card);
13:     notifyListeners();
14:   }
15: }
````

## File: templates/card/lib/game_internals/playing_area.dart
````dart
 1: import 'dart:async';
 2: 
 3: import 'package:async/async.dart';
 4: 
 5: import 'playing_card.dart';
 6: 
 7: class PlayingArea {
 8:   /// The maximum number of cards in this playing area.
 9:   static const int maxCards = 6;
10: 
11:   /// The current cards in this area.
12:   final List<PlayingCard> cards = [];
13: 
14:   final StreamController<void> _playerChanges =
15:       StreamController<void>.broadcast();
16: 
17:   final StreamController<void> _remoteChanges =
18:       StreamController<void>.broadcast();
19: 
20:   PlayingArea();
21: 
22:   /// A [Stream] that fires an event every time any change to this area is made.
23:   Stream<void> get allChanges =>
24:       StreamGroup.mergeBroadcast([remoteChanges, playerChanges]);
25: 
26:   /// A [Stream] that fires an event every time a change is made _locally_,
27:   /// by the player.
28:   Stream<void> get playerChanges => _playerChanges.stream;
29: 
30:   /// A [Stream] that fires an event every time a change is made _remotely_,
31:   /// by another player.
32:   Stream<void> get remoteChanges => _remoteChanges.stream;
33: 
34:   /// Accepts the [card] into the area.
35:   void acceptCard(PlayingCard card) {
36:     cards.add(card);
37:     _maybeTrim();
38:     _playerChanges.add(null);
39:   }
40: 
41:   void dispose() {
42:     _remoteChanges.close();
43:     _playerChanges.close();
44:   }
45: 
46:   /// Removes the first card in the area, if any.
47:   void removeFirstCard() {
48:     if (cards.isEmpty) return;
49:     cards.removeAt(0);
50:     _playerChanges.add(null);
51:   }
52: 
53:   /// Replaces the cards in the area with [cards].
54:   ///
55:   /// This method is meant to be called when the cards are updated from
56:   /// a server.
57:   void replaceWith(List<PlayingCard> cards) {
58:     this.cards.clear();
59:     this.cards.addAll(cards);
60:     _maybeTrim();
61:     _remoteChanges.add(null);
62:   }
63: 
64:   void _maybeTrim() {
65:     if (cards.length > maxCards) {
66:       cards.removeRange(0, cards.length - maxCards);
67:     }
68:   }
69: }
````

## File: templates/card/lib/game_internals/playing_card.dart
````dart
 1: import 'dart:math';
 2: 
 3: import 'package:flutter/foundation.dart';
 4: 
 5: import 'card_suit.dart';
 6: 
 7: @immutable
 8: class PlayingCard {
 9:   static final _random = Random();
10: 
11:   final CardSuit suit;
12: 
13:   final int value;
14: 
15:   const PlayingCard(this.suit, this.value);
16: 
17:   factory PlayingCard.fromJson(Map<String, dynamic> json) {
18:     return PlayingCard(
19:       CardSuit.values
20:           .singleWhere((e) => e.internalRepresentation == json['suit']),
21:       json['value'] as int,
22:     );
23:   }
24: 
25:   factory PlayingCard.random([Random? random]) {
26:     random ??= _random;
27:     return PlayingCard(
28:       CardSuit.values[random.nextInt(CardSuit.values.length)],
29:       2 + random.nextInt(9),
30:     );
31:   }
32: 
33:   @override
34:   int get hashCode => Object.hash(suit, value);
35: 
36:   @override
37:   bool operator ==(Object other) {
38:     return other is PlayingCard && other.suit == suit && other.value == value;
39:   }
40: 
41:   Map<String, dynamic> toJson() => {
42:         'suit': suit.internalRepresentation,
43:         'value': value,
44:       };
45: 
46:   @override
47:   String toString() {
48:     return '$suit$value';
49:   }
50: }
````

## File: templates/card/lib/game_internals/score.dart
````dart
 1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: /// Encapsulates a score and the arithmetic to compute it.
 6: class Score {
 7:   final int score;
 8: 
 9:   final Duration duration;
10: 
11:   final int level;
12: 
13:   factory Score(int level, int difficulty, Duration duration) {
14:     // The higher the difficulty, the higher the score.
15:     var score = difficulty;
16:     // The lower the time to beat the level, the higher the score.
17:     score *= 10000 ~/ (duration.inSeconds.abs() + 1);
18:     return Score._(score, duration, level);
19:   }
20: 
21:   const Score._(this.score, this.duration, this.level);
22: 
23:   String get formattedTime {
24:     final buf = StringBuffer();
25:     if (duration.inHours > 0) {
26:       buf.write('${duration.inHours}');
27:       buf.write(':');
28:     }
29:     final minutes = duration.inMinutes % Duration.minutesPerHour;
30:     if (minutes > 9) {
31:       buf.write('$minutes');
32:     } else {
33:       buf.write('0');
34:       buf.write('$minutes');
35:     }
36:     buf.write(':');
37:     buf.write((duration.inSeconds % Duration.secondsPerMinute)
38:         .toString()
39:         .padLeft(2, '0'));
40:     return buf.toString();
41:   }
42: 
43:   @override
44:   String toString() => 'Score<$score,$formattedTime,$level>';
45: }
````

## File: templates/card/lib/main_menu/main_menu_screen.dart
````dart
 1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: import 'package:flutter/material.dart';
 6: import 'package:go_router/go_router.dart';
 7: import 'package:provider/provider.dart';
 8: 
 9: import '../audio/audio_controller.dart';
10: import '../audio/sounds.dart';
11: import '../settings/settings.dart';
12: import '../style/my_button.dart';
13: import '../style/palette.dart';
14: import '../style/responsive_screen.dart';
15: 
16: class MainMenuScreen extends StatelessWidget {
17:   const MainMenuScreen({super.key});
18: 
19:   @override
20:   Widget build(BuildContext context) {
21:     final palette = context.watch<Palette>();
22:     final settingsController = context.watch<SettingsController>();
23:     final audioController = context.watch<AudioController>();
24: 
25:     return Scaffold(
26:       backgroundColor: palette.backgroundMain,
27:       body: ResponsiveScreen(
28:         squarishMainArea: Center(
29:           child: Transform.rotate(
30:             angle: -0.2,
31:             child: const Text(
32:               'Prepare for War!',
33:               textAlign: TextAlign.center,
34:               style: TextStyle(
35:                 fontFamily: 'Permanent Marker',
36:                 fontSize: 65,
37:                 height: 1,
38:               ),
39:             ),
40:           ),
41:         ),
42:         rectangularMenuArea: Column(
43:           mainAxisAlignment: MainAxisAlignment.end,
44:           children: [
45:             MyButton(
46:               onPressed: () {
47:                 audioController.playSfx(SfxType.buttonTap);
48:                 GoRouter.of(context).go('/tabbedwaves');
49:               },
50:               child: const Text('Wave Slider'),
51:             ),
52:             _gap,
53:             MyButton(
54:               onPressed: () {
55:                 audioController.playSfx(SfxType.buttonTap);
56:                 GoRouter.of(context).go('/battlefield');
57:               },
58:               child: const Text('Battle Field'),
59:             ),
60:             _gap,
61:             MyButton(
62:               onPressed: () {
63:                 audioController.playSfx(SfxType.buttonTap);
64:                 GoRouter.of(context).go('/play');
65:               },
66:               child: const Text('Play'),
67:             ),
68:             _gap,
69:             MyButton(
70:               onPressed: () => GoRouter.of(context).push('/settings'),
71:               child: const Text('Settings'),
72:             ),
73:             _gap,
74:             Padding(
75:               padding: const EdgeInsets.only(top: 32),
76:               child: ValueListenableBuilder<bool>(
77:                 valueListenable: settingsController.audioOn,
78:                 builder: (context, audioOn, child) {
79:                   return IconButton(
80:                     onPressed: () => settingsController.toggleAudioOn(),
81:                     icon: Icon(audioOn ? Icons.volume_up : Icons.volume_off),
82:                   );
83:                 },
84:               ),
85:             ),
86:             _gap,
87:             const Text('Music by Mr Smith'),
88:             _gap,
89:           ],
90:         ),
91:       ),
92:     );
93:   }
94: 
95:   static const _gap = SizedBox(height: 10);
96: }
````

## File: templates/card/lib/play_session/battlefield.dart
````dart
 1: import 'package:flutter/material.dart';
 2: 
 3: class BattlefieldScreen extends StatefulWidget {
 4:   const BattlefieldScreen({super.key});
 5: 
 6:   @override
 7:   State<BattlefieldScreen> createState() => _BattlefieldScreenState();
 8: }
 9: 
10: class _BattlefieldScreenState extends State<BattlefieldScreen> {
11:   bool _isSelected = false; // Track selection
12:   bool _isPanZoomEnabled = true; // Track pan and zoom state
13: 
14:   @override
15:   Widget build(BuildContext context) {
16:     double screenWidth = MediaQuery.of(context).size.width;
17:     double screenHeight = MediaQuery.of(context).size.height;
18: 
19:     double battlefieldAspectRatio = 6 / 4;
20:     double battlefieldWidth = screenWidth;
21:     double battlefieldHeight = screenWidth / battlefieldAspectRatio;
22: 
23:     if (battlefieldHeight > screenHeight) {
24:       battlefieldHeight = screenHeight;
25:       battlefieldWidth = screenHeight * battlefieldAspectRatio;
26:     }
27: 
28:     double minScale = screenWidth / battlefieldWidth;
29: 
30:     return Scaffold(
31:       appBar: AppBar(title: const Text("Battlefield")),
32:       body: InteractiveViewer(
33:         minScale: minScale,
34:         maxScale: 3.0,
35:         panAxis: PanAxis.horizontal,
36:         panEnabled: _isPanZoomEnabled, // Toggle pan
37:         scaleEnabled: _isPanZoomEnabled, // Toggle zoom
38:         child: Center(
39:           child: AspectRatio(
40:             aspectRatio: battlefieldAspectRatio,
41:             child: Stack(
42:               children: [
43:                 // Battlefield Image
44:                 Positioned.fill(
45:                   child: Image.asset(
46:                     'assets/images/battlefield.jpg',
47:                     fit: BoxFit.cover,
48:                   ),
49:                 ),
50: 
51:                 // Overlaying Selectable Rectangle
52:                 Positioned(
53:                   left: battlefieldWidth * 0.2,
54:                   top: battlefieldHeight * 0.2,
55:                   child: GestureDetector(
56:                     onTap: () {
57:                       setState(() {
58:                         _isSelected = !_isSelected;
59:                         _isPanZoomEnabled =
60:                             !_isSelected; // Disable pan/zoom when selected
61:                       });
62:                     },
63:                     child: Container(
64:                       width: battlefieldWidth * (8.5 / 72),
65:                       height: battlefieldHeight * (2.5 / 48),
66:                       color: _isSelected
67:                           ? Colors.red.withOpacity(0.8) // Darker when selected
68:                           : Colors.red.withOpacity(0.5),
69:                     ),
70:                   ),
71:                 ),
72:               ],
73:             ),
74:           ),
75:         ),
76:       ),
77:     );
78:   }
79: }
````

## File: templates/card/lib/play_session/board_widget.dart
````dart
 1: // Copyright 2023, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: import 'package:flutter/material.dart';
 6: import 'package:provider/provider.dart';
 7: 
 8: import '../game_internals/board_state.dart';
 9: import 'player_hand_widget.dart';
10: import 'playing_area_widget.dart';
11: 
12: /// This widget defines the game UI itself, without things like the settings
13: /// button or the back button.
14: class BoardWidget extends StatefulWidget {
15:   const BoardWidget({super.key});
16: 
17:   @override
18:   State<BoardWidget> createState() => _BoardWidgetState();
19: }
20: 
21: class _BoardWidgetState extends State<BoardWidget> {
22:   @override
23:   Widget build(BuildContext context) {
24:     final boardState = context.watch<BoardState>();
25: 
26:     return Column(
27:       mainAxisAlignment: MainAxisAlignment.center,
28:       crossAxisAlignment: CrossAxisAlignment.stretch,
29:       children: [
30:         Padding(
31:           padding: const EdgeInsets.all(10),
32:           child: Row(
33:             children: [
34:               Expanded(child: PlayingAreaWidget(boardState.areaOne)),
35:               const SizedBox(width: 20),
36:               Expanded(child: PlayingAreaWidget(boardState.areaTwo)),
37:             ],
38:           ),
39:         ),
40:         const PlayerHandWidget(),
41:       ],
42:     );
43:   }
44: }
````

## File: templates/card/lib/play_session/d6_Dice_Roller.dart
````dart
 1: // import 'dart:math';
 2: // import 'package:flutter/material.dart';
 3: // import 'target_selector.dart';
 4: 
 5: // class DiceRoller extends StatefulWidget {
 6: //   final void Function(int result, int numDice, double expectedSuccesses)
 7: //       onResult;
 8: //   final bool hideResults;
 9: //   final int target; // Now we receive target as a prop from parent
10: 
11: //   const DiceRoller({
12: //     super.key,
13: //     required this.onResult,
14: //     required this.target, // Required prop
15: //     this.hideResults = false,
16: //   });
17: 
18: //   @override
19: //   State<DiceRoller> createState() => _DiceRollerState();
20: // }
21: 
22: // class _DiceRollerState extends State<DiceRoller> {
23: //   final Random _random = Random();
24: //   int _result = 0;
25: //   int numDice = 1;
26: //   // Target is now a prop from parent, not maintained here
27: 
28: //   int rollDice(int numDice, int target) {
29: //     int count = 0;
30: //     for (int i = 0; i < numDice; i++) {
31: //       int roll = _random.nextInt(6) + 1;
32: //       if (roll <= target) count++;
33: //     }
34: //     return count;
35: //   }
36: 
37: //   double calculateExpectedSuccesses(int numDice, int target) {
38: //     return numDice * (target / 6);
39: //   }
40: 
41: //   void _onPressed() {
42: //     // Use the target passed as a prop
43: //     setState(() {
44: //       _result = rollDice(numDice, widget.target);
45: //     });
46: //     double expectedSuccesses =
47: //         calculateExpectedSuccesses(numDice, widget.target);
48: //     widget.onResult(_result, numDice, expectedSuccesses);
49: //   }
50: 
51: //   @override
52: //   Widget build(BuildContext context) {
53: //     return Row(
54: //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
55: //       crossAxisAlignment: CrossAxisAlignment.center,
56: //       children: [
57: //         // Roll Dice button on the left
58: //         ElevatedButton(
59: //           onPressed: _onPressed,
60: //           style: ElevatedButton.styleFrom(
61: //             backgroundColor: Colors.deepPurple,
62: //             padding: EdgeInsets.symmetric(
63: //                 horizontal: 48, vertical: 24), // 50% larger
64: //             textStyle: TextStyle(fontSize: 20),
65: //           ),
66: //           child: Text('Roll Dice',
67: //               style:
68: //                   TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
69: //         ),
70: 
71: //         // Only the Dice number selector, no Target selector
72: //         Row(
73: //           crossAxisAlignment: CrossAxisAlignment.center,
74: //           children: [
75: //             Text('Dice:', style: TextStyle(fontSize: 20)),
76: //             SizedBox(width: 20),
77: //             TargetSelector(
78: //               selectionLimit: 30,
79: //               initialValue: numDice,
80: //               textSize: 20,
81: //               onChanged: (value) => setState(() {
82: //                 numDice = value;
83: //               }),
84: //             ),
85: //           ],
86: //         ),
87: //       ],
88: //     );
89: //   }
90: // }
````

## File: templates/card/lib/play_session/play_session_screen.dart
````dart
  1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
  2: // for details. All rights reserved. Use of this source code is governed by a
  3: // BSD-style license that can be found in the LICENSE file.
  4: 
  5: import 'dart:async';
  6: 
  7: import 'package:flutter/material.dart';
  8: import 'package:go_router/go_router.dart';
  9: import 'package:logging/logging.dart' hide Level;
 10: import 'package:provider/provider.dart';
 11: 
 12: import '../audio/audio_controller.dart';
 13: import '../audio/sounds.dart';
 14: import '../game_internals/board_state.dart';
 15: import '../game_internals/score.dart';
 16: import '../style/confetti.dart';
 17: import '../style/my_button.dart';
 18: import '../style/palette.dart';
 19: import 'board_widget.dart';
 20: 
 21: /// This widget defines the entirety of the screen that the player sees when
 22: /// they are playing a level.
 23: ///
 24: /// It is a stateful widget because it manages some state of its own,
 25: /// such as whether the game is in a "celebration" state.
 26: class PlaySessionScreen extends StatefulWidget {
 27:   const PlaySessionScreen({super.key});
 28: 
 29:   @override
 30:   State<PlaySessionScreen> createState() => _PlaySessionScreenState();
 31: }
 32: 
 33: class _PlaySessionScreenState extends State<PlaySessionScreen> {
 34:   static final _log = Logger('PlaySessionScreen');
 35: 
 36:   static const _celebrationDuration = Duration(milliseconds: 2000);
 37: 
 38:   static const _preCelebrationDuration = Duration(milliseconds: 500);
 39: 
 40:   bool _duringCelebration = false;
 41: 
 42:   late DateTime _startOfPlay;
 43: 
 44:   late final BoardState _boardState;
 45: 
 46:   @override
 47:   Widget build(BuildContext context) {
 48:     final palette = context.watch<Palette>();
 49: 
 50:     return MultiProvider(
 51:       providers: [
 52:         Provider.value(value: _boardState),
 53:       ],
 54:       child: IgnorePointer(
 55:         // Ignore all input during the celebration animation.
 56:         ignoring: _duringCelebration,
 57:         child: Scaffold(
 58:           backgroundColor: palette.backgroundPlaySession,
 59:           // The stack is how you layer widgets on top of each other.
 60:           // Here, it is used to overlay the winning confetti animation on top
 61:           // of the game.
 62:           body: Stack(
 63:             children: [
 64:               // This is the main layout of the play session screen,
 65:               // with a settings button at top, the actual play area
 66:               // in the middle, and a back button at the bottom.
 67:               Column(
 68:                 mainAxisAlignment: MainAxisAlignment.center,
 69:                 children: [
 70:                   Align(
 71:                     alignment: Alignment.centerRight,
 72:                     child: InkResponse(
 73:                       onTap: () => GoRouter.of(context).push('/settings'),
 74:                       child: Image.asset(
 75:                         'assets/images/settings.png',
 76:                         semanticLabel: 'Settings',
 77:                       ),
 78:                     ),
 79:                   ),
 80:                   const Spacer(),
 81:                   // The actual UI of the game.
 82:                   const BoardWidget(),
 83:                   const Text('Drag cards to the two areas above.'),
 84:                   const Spacer(),
 85:                   Padding(
 86:                     padding: const EdgeInsets.all(8.0),
 87:                     child: MyButton(
 88:                       onPressed: () => GoRouter.of(context).go('/'),
 89:                       child: const Text('Back'),
 90:                     ),
 91:                   ),
 92:                 ],
 93:               ),
 94:               SizedBox.expand(
 95:                 child: Visibility(
 96:                   visible: _duringCelebration,
 97:                   child: IgnorePointer(
 98:                     child: Confetti(
 99:                       isStopped: !_duringCelebration,
100:                     ),
101:                   ),
102:                 ),
103:               ),
104:             ],
105:           ),
106:         ),
107:       ),
108:     );
109:   }
110: 
111:   @override
112:   void dispose() {
113:     _boardState.dispose();
114:     super.dispose();
115:   }
116: 
117:   @override
118:   void initState() {
119:     super.initState();
120:     _startOfPlay = DateTime.now();
121:     _boardState = BoardState(onWin: _playerWon);
122:   }
123: 
124:   Future<void> _playerWon() async {
125:     _log.info('Player won');
126: 
127:     // TODO: replace with some meaningful score for the card game
128:     final score = Score(1, 1, DateTime.now().difference(_startOfPlay));
129: 
130:     // final playerProgress = context.read<PlayerProgress>();
131:     // playerProgress.setLevelReached(widget.level.number);
132: 
133:     // Let the player see the game just after winning for a bit.
134:     await Future<void>.delayed(_preCelebrationDuration);
135:     if (!mounted) return;
136: 
137:     setState(() {
138:       _duringCelebration = true;
139:     });
140: 
141:     final audioController = context.read<AudioController>();
142:     audioController.playSfx(SfxType.congrats);
143: 
144:     /// Give the player some time to see the celebration animation.
145:     await Future<void>.delayed(_celebrationDuration);
146:     if (!mounted) return;
147: 
148:     GoRouter.of(context).go('/play/won', extra: {'score': score});
149:   }
150: }
````

## File: templates/card/lib/play_session/player_hand_widget.dart
````dart
 1: import 'package:flutter/material.dart';
 2: import 'package:provider/provider.dart';
 3: 
 4: import '../game_internals/board_state.dart';
 5: import 'playing_card_widget.dart';
 6: 
 7: class PlayerHandWidget extends StatelessWidget {
 8:   const PlayerHandWidget({super.key});
 9: 
10:   @override
11:   Widget build(BuildContext context) {
12:     final boardState = context.watch<BoardState>();
13: 
14:     return Padding(
15:       padding: const EdgeInsets.all(10),
16:       child: ConstrainedBox(
17:         constraints: const BoxConstraints(minHeight: PlayingCardWidget.height),
18:         child: ListenableBuilder(
19:           // Make sure we rebuild every time there's an update
20:           // to the player's hand.
21:           listenable: boardState.player,
22:           builder: (context, child) {
23:             return Wrap(
24:               alignment: WrapAlignment.center,
25:               spacing: 10,
26:               runSpacing: 10,
27:               children: [
28:                 ...boardState.player.hand.map((card) =>
29:                     PlayingCardWidget(card, player: boardState.player)),
30:               ],
31:             );
32:           },
33:         ),
34:       ),
35:     );
36:   }
37: }
````

## File: templates/card/lib/play_session/playing_area_widget.dart
````dart
  1: import 'dart:math';
  2: 
  3: import 'package:flutter/material.dart';
  4: import 'package:provider/provider.dart';
  5: 
  6: import '../audio/audio_controller.dart';
  7: import '../audio/sounds.dart';
  8: import '../game_internals/playing_area.dart';
  9: import '../game_internals/playing_card.dart';
 10: import '../style/palette.dart';
 11: import 'playing_card_widget.dart';
 12: 
 13: class PlayingAreaWidget extends StatefulWidget {
 14:   final PlayingArea area;
 15: 
 16:   const PlayingAreaWidget(this.area, {super.key});
 17: 
 18:   @override
 19:   State<PlayingAreaWidget> createState() => _PlayingAreaWidgetState();
 20: }
 21: 
 22: class _PlayingAreaWidgetState extends State<PlayingAreaWidget> {
 23:   bool isHighlighted = false;
 24: 
 25:   @override
 26:   Widget build(BuildContext context) {
 27:     final palette = context.watch<Palette>();
 28: 
 29:     return LimitedBox(
 30:       maxHeight: 200,
 31:       child: AspectRatio(
 32:         aspectRatio: 1 / 1,
 33:         child: DragTarget<PlayingCardDragData>(
 34:           builder: (context, candidateData, rejectedData) => Material(
 35:             color: isHighlighted ? palette.accept : palette.trueWhite,
 36:             shape: const CircleBorder(),
 37:             clipBehavior: Clip.hardEdge,
 38:             child: InkWell(
 39:               splashColor: palette.redPen,
 40:               onTap: _onAreaTap,
 41:               child: StreamBuilder(
 42:                 // Rebuild the card stack whenever the area changes
 43:                 // (either by a player action, or remotely).
 44:                 stream: widget.area.allChanges,
 45:                 builder: (context, child) => _CardStack(widget.area.cards),
 46:               ),
 47:             ),
 48:           ),
 49:           onWillAcceptWithDetails: _onDragWillAccept,
 50:           onLeave: _onDragLeave,
 51:           onAcceptWithDetails: _onDragAccept,
 52:         ),
 53:       ),
 54:     );
 55:   }
 56: 
 57:   void _onAreaTap() {
 58:     widget.area.removeFirstCard();
 59: 
 60:     final audioController = context.read<AudioController>();
 61:     audioController.playSfx(SfxType.huhsh);
 62:   }
 63: 
 64:   void _onDragAccept(DragTargetDetails<PlayingCardDragData> details) {
 65:     widget.area.acceptCard(details.data.card);
 66:     details.data.holder.removeCard(details.data.card);
 67:     setState(() => isHighlighted = false);
 68:   }
 69: 
 70:   void _onDragLeave(PlayingCardDragData? data) {
 71:     setState(() => isHighlighted = false);
 72:   }
 73: 
 74:   bool _onDragWillAccept(DragTargetDetails<PlayingCardDragData> details) {
 75:     setState(() => isHighlighted = true);
 76:     return true;
 77:   }
 78: }
 79: 
 80: class _CardStack extends StatelessWidget {
 81:   static const int _maxCards = 6;
 82: 
 83:   static const _leftOffset = 10.0;
 84: 
 85:   static const _topOffset = 5.0;
 86: 
 87:   static const double _maxWidth =
 88:       _maxCards * _leftOffset + PlayingCardWidget.width;
 89: 
 90:   static const _maxHeight = _maxCards * _topOffset + PlayingCardWidget.height;
 91: 
 92:   final List<PlayingCard> cards;
 93: 
 94:   const _CardStack(this.cards);
 95: 
 96:   @override
 97:   Widget build(BuildContext context) {
 98:     return Center(
 99:       child: SizedBox(
100:         width: _maxWidth,
101:         height: _maxHeight,
102:         child: Stack(
103:           children: [
104:             for (var i = max(0, cards.length - _maxCards);
105:                 i < cards.length;
106:                 i++)
107:               Positioned(
108:                 top: i * _topOffset,
109:                 left: i * _leftOffset,
110:                 child: PlayingCardWidget(cards[i]),
111:               ),
112:           ],
113:         ),
114:       ),
115:     );
116:   }
117: }
````

## File: templates/card/lib/play_session/playing_card_widget.dart
````dart
 1: import 'package:flutter/material.dart';
 2: import 'package:provider/provider.dart';
 3: 
 4: import '../audio/audio_controller.dart';
 5: import '../audio/sounds.dart';
 6: import '../game_internals/card_suit.dart';
 7: import '../game_internals/player.dart';
 8: import '../game_internals/playing_card.dart';
 9: import '../style/palette.dart';
10: 
11: class PlayingCardWidget extends StatelessWidget {
12:   // A standard playing card is 57.1mm x 88.9mm.
13:   static const double width = 57.1;
14: 
15:   static const double height = 88.9;
16: 
17:   final PlayingCard card;
18: 
19:   final Player? player;
20: 
21:   const PlayingCardWidget(this.card, {this.player, super.key});
22: 
23:   @override
24:   Widget build(BuildContext context) {
25:     final palette = context.watch<Palette>();
26:     final textColor =
27:         card.suit.color == CardSuitColor.red ? palette.redPen : palette.ink;
28: 
29:     final cardWidget = DefaultTextStyle(
30:       style: Theme.of(context).textTheme.bodyMedium!.apply(color: textColor),
31:       child: Container(
32:         width: width,
33:         height: height,
34:         decoration: BoxDecoration(
35:           color: palette.trueWhite,
36:           border: Border.all(color: palette.ink),
37:           borderRadius: BorderRadius.circular(5),
38:         ),
39:         child: Center(
40:           child: Text('${card.suit.asCharacter}\n${card.value}',
41:               textAlign: TextAlign.center),
42:         ),
43:       ),
44:     );
45: 
46:     /// Cards that aren't in a player's hand are not draggable.
47:     if (player == null) return cardWidget;
48: 
49:     return Draggable(
50:       feedback: Transform.rotate(
51:         angle: 0.1,
52:         child: cardWidget,
53:       ),
54:       data: PlayingCardDragData(card, player!),
55:       childWhenDragging: Opacity(
56:         opacity: 0.5,
57:         child: cardWidget,
58:       ),
59:       onDragStarted: () {
60:         final audioController = context.read<AudioController>();
61:         audioController.playSfx(SfxType.huhsh);
62:       },
63:       onDragEnd: (details) {
64:         final audioController = context.read<AudioController>();
65:         audioController.playSfx(SfxType.wssh);
66:       },
67:       child: cardWidget,
68:     );
69:   }
70: }
71: 
72: @immutable
73: class PlayingCardDragData {
74:   final PlayingCard card;
75: 
76:   final Player holder;
77: 
78:   const PlayingCardDragData(this.card, this.holder);
79: }
````

## File: templates/card/lib/play_session/simple_battlefield.dart
````dart
 1: import 'package:flutter/material.dart';
 2: 
 3: class SimpleBattlefieldScreen extends StatefulWidget {
 4:   const SimpleBattlefieldScreen({super.key});
 5:   @override
 6:   State<SimpleBattlefieldScreen> createState() =>
 7:       _SimpleBattlefieldScreenState();
 8: }
 9: 
10: class _SimpleBattlefieldScreenState extends State<SimpleBattlefieldScreen> {
11:   @override
12:   Widget build(BuildContext context) => Scaffold(
13:         appBar: AppBar(title: Text("Battlefield")),
14:         body: InteractiveViewer(
15:           child: Image.asset('assets/images/battlefield.jpg'),
16:         ),
17:       );
18: }
````

## File: templates/card/lib/play_session/target_selector.dart
````dart
 1: import 'package:flutter/material.dart';
 2: 
 3: class TargetSelector extends StatelessWidget {
 4:   final int selectionLimit;
 5:   final int initialValue;
 6:   final ValueChanged<int> onChanged;
 7:   final double textSize;
 8: 
 9:   const TargetSelector({
10:     super.key,
11:     required this.selectionLimit,
12:     required this.initialValue,
13:     required this.onChanged,
14:     this.textSize = 16, // Default text size
15:   });
16: 
17:   @override
18:   Widget build(BuildContext context) {
19:     return DropdownButton<int>(
20:       value: initialValue,
21:       icon: const Icon(Icons.arrow_downward),
22:       elevation: 16,
23:       style: TextStyle(
24:         color: Colors.deepPurple,
25:         fontSize: textSize, // Use the provided text size
26:       ),
27:       underline: Container(height: 2, color: Colors.deepPurpleAccent),
28:       onChanged: (int? newValue) {
29:         if (newValue != null) {
30:           onChanged(newValue);
31:         }
32:       },
33:       items: List.generate(selectionLimit, (index) => index + 1)
34:           .map<DropdownMenuItem<int>>((int value) {
35:         return DropdownMenuItem<int>(
36:           value: value,
37:           child: Text(value.toString()),
38:         );
39:       }).toList(),
40:     );
41:   }
42: }
````

## File: templates/card/lib/play_session/wave_painter.dart
````dart
  1: import 'dart:ui';
  2: import 'package:flutter/material.dart';
  3: 
  4: class WavePainter extends CustomPainter {
  5:   final double sliderPosition;
  6:   final double dragPercentage;
  7:   final double expectedSuccessPercentage;
  8:   final int numDice;
  9:   final double expectedSuccesses;
 10: 
 11:   // Buffer and drawing area parameters
 12:   final double horizontalBuffer;
 13:   final double verticalBuffer;
 14:   final double drawingWidth;
 15:   final double drawingHeight;
 16: 
 17:   final Color badColor = Color(0xFFFF4136); // Red
 18:   final Color neutralColor = Color(0xFFFFDC00); // Yellow
 19:   final Color goodColor = Color(0xFF2ECC40); // Green
 20: 
 21:   final Paint fillPainter;
 22:   final Paint expectedLinePainter;
 23:   late Paint wavePainter;
 24: 
 25:   double _previousSliderPosition = 0;
 26: 
 27:   WavePainter({
 28:     required this.sliderPosition,
 29:     required this.dragPercentage,
 30:     required this.expectedSuccessPercentage,
 31:     this.numDice = 1,
 32:     this.expectedSuccesses = 0,
 33:     required this.horizontalBuffer,
 34:     required this.verticalBuffer,
 35:     required this.drawingWidth,
 36:     required this.drawingHeight,
 37:   })  : fillPainter = Paint()
 38:           ..color = Colors.black
 39:           ..style = PaintingStyle.fill,
 40:         expectedLinePainter = Paint()
 41:           ..color = Colors.black
 42:           ..strokeWidth = 3.0 {
 43:     wavePainter = Paint()
 44:       ..color = _calculateWaveColor(dragPercentage, expectedSuccessPercentage)
 45:       ..style = PaintingStyle.stroke
 46:       ..strokeWidth = 2.5;
 47:   }
 48: 
 49:   /// Computes the color of the wave based on the drag percentage.
 50:   Color _calculateWaveColor(double dragPercentage, double expectedPercentage) {
 51:     const double biasFactor = 0.4; // 70% of the transition range
 52: 
 53:     if (dragPercentage < expectedPercentage) {
 54:       // Interpolate Red to Yellow with 70% bias
 55:       double t = dragPercentage / (1 - expectedPercentage * biasFactor);
 56:       t = t.clamp(0.0, 1.0); // Ensure stays in range
 57:       return Color.lerp(badColor, neutralColor, t) ?? neutralColor;
 58:     } else {
 59:       // Interpolate Yellow to Green with 70% bias
 60:       double t = (dragPercentage - expectedPercentage) /
 61:           ((1 - expectedPercentage) * biasFactor);
 62:       t = t.clamp(0.0, 1.0); // Ensure stays in range
 63:       return Color.lerp(neutralColor, goodColor, t) ?? goodColor;
 64:     }
 65:   }
 66: 
 67:   @override
 68:   void paint(Canvas canvas, Size size) {
 69:     // Calculate the drawing area - use almost all available space
 70:     final drawingArea = Rect.fromLTWH(
 71:         horizontalBuffer, // Left buffer
 72:         verticalBuffer * 0.8, // Reduced top buffer
 73:         drawingWidth, // Width between buffers
 74:         drawingHeight - (verticalBuffer) // Extend down almost to bottom
 75:         );
 76: 
 77:     // Paint elements in correct order for layering
 78:     _paintWaveLine(canvas, size, drawingArea);
 79:     _paintAnchors(canvas, size, drawingArea);
 80:     _paintExpectedSuccessDot(canvas, size, drawingArea);
 81:     _paintExpectedSuccessText(canvas, size, drawingArea);
 82:     _paintDiceCountAnnotation(canvas, size, drawingArea);
 83:   }
 84: 
 85:   void _paintExpectedSuccessDot(Canvas canvas, Size size, Rect drawingArea) {
 86:     double xPosition =
 87:         drawingArea.left + (expectedSuccessPercentage * drawingArea.width);
 88: 
 89:     // Only draw if within the drawing area
 90:     if (xPosition >= drawingArea.left && xPosition <= drawingArea.right) {
 91:       // Create a dot on the wave line - slightly smaller than anchor points
 92:       final dotPaint = Paint()
 93:         ..color = Colors.black
 94:         ..style = PaintingStyle.fill;
 95: 
 96:       canvas.drawCircle(
 97:           Offset(xPosition, drawingArea.bottom),
 98:           4.0, // Slightly smaller than anchor points (5.0)
 99:           dotPaint);
100:     }
101:   }
102: 
103:   void _paintExpectedSuccessText(Canvas canvas, Size size, Rect drawingArea) {
104:     final textPainter = TextPainter(
105:       textAlign: TextAlign.left,
106:       textDirection: TextDirection.ltr,
107:     );
108: 
109:     double xPosition =
110:         drawingArea.left + (expectedSuccessPercentage * drawingArea.width);
111: 
112:     // Only draw if within the drawing area
113:     if (xPosition >= drawingArea.left && xPosition <= drawingArea.right) {
114:       textPainter.text = TextSpan(
115:         text: expectedSuccesses.toStringAsFixed(1),
116:         style: TextStyle(
117:           color: Colors.black,
118:           fontSize: 14,
119:           fontWeight: FontWeight.bold,
120:         ),
121:       );
122:       textPainter.layout(maxWidth: 100);
123: 
124:       // Center the text below the expected dot
125:       double centeredXOffset = xPosition - (textPainter.width / 2);
126: 
127:       // Ensure text stays within bounds
128:       centeredXOffset = centeredXOffset.clamp(
129:           drawingArea.left, drawingArea.right - textPainter.width);
130: 
131:       // Position text below the wave line
132:       double textY = drawingArea.bottom + 10;
133:       textPainter.paint(canvas, Offset(centeredXOffset, textY));
134:     }
135:   }
136: 
137:   void _paintDiceCountAnnotation(Canvas canvas, Size size, Rect drawingArea) {
138:     final textPainter = TextPainter(
139:       textAlign: TextAlign.left,
140:       textDirection: TextDirection.ltr,
141:     );
142: 
143:     // Annotate number of dice below the right anchor point
144:     textPainter.text = TextSpan(
145:       text: '$numDice',
146:       style: TextStyle(
147:         color: Colors.black,
148:         fontSize: 14,
149:         fontWeight: FontWeight.bold,
150:       ),
151:     );
152:     textPainter.layout();
153: 
154:     // Center the text below the right anchor point
155:     double centeredXOffset = drawingArea.right - (textPainter.width / 2);
156: 
157:     // Position text below the wave line
158:     double textY = drawingArea.bottom + 10;
159:     textPainter.paint(canvas, Offset(centeredXOffset, textY));
160:   }
161: 
162:   void _paintAnchors(Canvas canvas, Size size, Rect drawingArea) {
163:     // Position anchors exactly at the ends of the drawing area
164:     double waveCenterY = drawingArea.bottom;
165:     canvas.drawCircle(Offset(drawingArea.left, waveCenterY), 5.0, fillPainter);
166:     canvas.drawCircle(Offset(drawingArea.right, waveCenterY), 5.0, fillPainter);
167:   }
168: 
169:   void _paintWaveLine(Canvas canvas, Size size, Rect drawingArea) {
170:     WaveCurveDefinitions waveCurve =
171:         _calculateWaveLineDefinitions(size, drawingArea);
172:     double waveY = drawingArea.bottom;
173: 
174:     Path path = Path();
175:     path.moveTo(drawingArea.left, waveY);
176:     path.lineTo(waveCurve.startofBezier, waveY);
177:     path.cubicTo(
178:         waveCurve.leftControlPoint1,
179:         waveY,
180:         waveCurve.leftControlPoint2,
181:         waveCurve.controlHeight,
182:         waveCurve.centerPoint,
183:         waveCurve.controlHeight);
184:     path.cubicTo(waveCurve.rightControlPoint1, waveCurve.controlHeight,
185:         waveCurve.rightControlPoint2, waveY, waveCurve.endOfBezier, waveY);
186:     path.lineTo(drawingArea.right, waveY);
187: 
188:     canvas.drawPath(path, wavePainter);
189:   }
190: 
191:   WaveCurveDefinitions _calculateWaveLineDefinitions(
192:       Size size, Rect drawingArea) {
193:     // Further increase the wave height by adjusting these factors
194:     double minWaveHeight = drawingArea.height * 0.1; // Further reduced minimum
195:     double maxWaveHeight =
196:         drawingArea.height * 0.95; // Increased maximum even more
197: 
198:     // Calculate the control height for the wave peak
199:     double controlHeight = drawingArea.top +
200:         (drawingArea.height - minWaveHeight) -
201:         (maxWaveHeight * dragPercentage);
202: 
203:     // Calculate bend and bezier width - standard values
204:     double bendWidth = 20 + 20 * dragPercentage;
205:     double bezierWidth = 20 + 20 * dragPercentage;
206: 
207:     // Ensure the slider position is correctly mapped to the drawing area
208:     double adjustedPosition = sliderPosition;
209: 
210:     // Center point cannot exceed the drawing area
211:     double centerPoint = adjustedPosition;
212:     centerPoint = centerPoint.clamp(drawingArea.left, drawingArea.right);
213: 
214:     // Calculate bezier curve points
215:     double startOfBend = centerPoint - bendWidth / 2;
216:     double startOfBezier = startOfBend - bezierWidth;
217:     double endOfBend = centerPoint + bendWidth / 2;
218:     double endOfBezier = endOfBend + bezierWidth;
219: 
220:     // Constrain points to the drawing area
221:     startOfBend = startOfBend.clamp(drawingArea.left, drawingArea.right);
222:     startOfBezier = startOfBezier.clamp(drawingArea.left, drawingArea.right);
223:     endOfBend = endOfBend.clamp(drawingArea.left, drawingArea.right);
224:     endOfBezier = endOfBezier.clamp(drawingArea.left, drawingArea.right);
225: 
226:     // Control points
227:     double leftControlPoint1 = startOfBend;
228:     double leftControlPoint2 = startOfBend;
229:     double rightControlPoint1 = endOfBend;
230:     double rightControlPoint2 = endOfBend;
231: 
232:     // Calculate bending based on position change
233:     double bendability = 25.0;
234:     double maxSlideDifference = 15.0;
235: 
236:     double slideDifference = (sliderPosition - _previousSliderPosition).abs();
237:     slideDifference = slideDifference.clamp(0.0, maxSlideDifference);
238: 
239:     bool moveLeft = sliderPosition < _previousSliderPosition;
240: 
241:     double bend =
242:         lerpDouble(0.0, bendability, slideDifference / maxSlideDifference) ??
243:             0.0;
244:     bend = moveLeft ? -bend : bend;
245: 
246:     // Apply bend to control points
247:     leftControlPoint1 = leftControlPoint1 + bend;
248:     leftControlPoint2 = leftControlPoint2 - bend;
249:     rightControlPoint1 = rightControlPoint1 - bend;
250:     rightControlPoint2 = rightControlPoint2 + bend;
251:     centerPoint = centerPoint - bend;
252: 
253:     // Constrain bent points to drawing area
254:     leftControlPoint1 =
255:         leftControlPoint1.clamp(drawingArea.left, drawingArea.right);
256:     leftControlPoint2 =
257:         leftControlPoint2.clamp(drawingArea.left, drawingArea.right);
258:     rightControlPoint1 =
259:         rightControlPoint1.clamp(drawingArea.left, drawingArea.right);
260:     rightControlPoint2 =
261:         rightControlPoint2.clamp(drawingArea.left, drawingArea.right);
262:     centerPoint = centerPoint.clamp(drawingArea.left, drawingArea.right);
263: 
264:     return WaveCurveDefinitions(
265:       startofBezier: startOfBezier,
266:       endOfBezier: endOfBezier,
267:       leftControlPoint1: leftControlPoint1,
268:       leftControlPoint2: leftControlPoint2,
269:       rightControlPoint1: rightControlPoint1,
270:       rightControlPoint2: rightControlPoint2,
271:       controlHeight: controlHeight,
272:       centerPoint: centerPoint,
273:     );
274:   }
275: 
276:   @override
277:   bool shouldRepaint(covariant WavePainter oldDelegate) {
278:     _previousSliderPosition = oldDelegate.sliderPosition;
279:     return oldDelegate.sliderPosition != sliderPosition ||
280:         oldDelegate.dragPercentage != dragPercentage ||
281:         oldDelegate.expectedSuccessPercentage != expectedSuccessPercentage;
282:   }
283: }
284: 
285: class WaveCurveDefinitions {
286:   double startofBezier;
287:   double endOfBezier;
288:   double leftControlPoint1;
289:   double leftControlPoint2;
290:   double rightControlPoint1;
291:   double rightControlPoint2;
292:   double controlHeight;
293:   double centerPoint;
294: 
295:   WaveCurveDefinitions({
296:     required this.startofBezier,
297:     required this.endOfBezier,
298:     required this.leftControlPoint1,
299:     required this.leftControlPoint2,
300:     required this.rightControlPoint1,
301:     required this.rightControlPoint2,
302:     required this.controlHeight,
303:     required this.centerPoint,
304:   });
305: }
````

## File: templates/card/lib/play_session/wave_screen.dart
````dart
  1: import 'package:flutter/material.dart';
  2: import 'dart:math';
  3: import 'dart:async';
  4: import 'wave_slider.dart';
  5: import 'target_selector.dart';
  6: 
  7: // State container for each tab's independent state
  8: class WaveScreenState {
  9:   final Random _random = Random();
 10: 
 11:   // First wave slider state (Hits)
 12:   double dragPercentage = 0.0;
 13:   double expectedSuccessPercentage = 0.0;
 14:   int numDice = 1;
 15:   int target = 6;
 16:   double expectedSuccesses = 0.0;
 17:   int firstSliderPosition = 0;
 18:   int firstResult = 0;
 19:   bool firstAnimationStarted = false;
 20: 
 21:   // Second wave slider state (Defence)
 22:   double secondDragPercentage = 0.0;
 23:   double secondExpectedSuccessPercentage = 0.0;
 24:   int secondNumDice = 0;
 25:   double secondExpectedSuccesses = 0.0;
 26:   int secondTarget = 4;
 27:   int secondResult = 0;
 28:   int secondSliderPosition = 0;
 29:   bool secondAnimationStarted = false;
 30: 
 31:   // Third wave slider state (Resolve)
 32:   double thirdDragPercentage = 0.0;
 33:   double thirdExpectedSuccessPercentage = 0.0;
 34:   int thirdNumDice = 0;
 35:   double thirdExpectedSuccesses = 0.0;
 36:   int thirdTarget = 4;
 37:   int thirdResult = 0;
 38:   int thirdSliderPosition = 0;
 39:   bool thirdAnimationStarted = false;
 40: 
 41:   // Wounds counter
 42:   int totalWounds = 0;
 43:   double expectedWounds = 0.0;
 44: 
 45:   // Calculate and update expected values based on current settings
 46:   void updateExpectedValues() {
 47:     // First roll (Clash) expected successes
 48:     expectedSuccesses = calculateExpectedSuccesses(numDice.toDouble(), target);
 49:     expectedSuccessPercentage = numDice > 0 ? expectedSuccesses / numDice : 0;
 50: 
 51:     // Expected second dice (based on expected first successes)
 52:     double expectedSecondNumDice = expectedSuccesses;
 53: 
 54:     // Second roll (Defence) expected successes
 55:     secondExpectedSuccesses =
 56:         calculateExpectedSuccesses(expectedSecondNumDice, secondTarget);
 57:     secondExpectedSuccessPercentage = expectedSecondNumDice > 0
 58:         ? secondExpectedSuccesses / expectedSecondNumDice
 59:         : 0;
 60: 
 61:     // Expected third dice (based on expected second fails)
 62:     double expectedThirdNumDice =
 63:         expectedSecondNumDice - secondExpectedSuccesses;
 64: 
 65:     // Third roll (Resolve) expected successes
 66:     thirdExpectedSuccesses =
 67:         calculateExpectedSuccesses(expectedThirdNumDice, thirdTarget);
 68:     thirdExpectedSuccessPercentage = expectedThirdNumDice > 0
 69:         ? thirdExpectedSuccesses / expectedThirdNumDice
 70:         : 0;
 71: 
 72:     // Update expected wounds
 73:     double expectedDefenceFails =
 74:         expectedSecondNumDice - secondExpectedSuccesses;
 75:     double expectedResolveFails = expectedThirdNumDice - thirdExpectedSuccesses;
 76:     expectedWounds = expectedDefenceFails + expectedResolveFails;
 77:   }
 78: 
 79:   // Function to roll dice
 80:   int rollDice(int numDice, int target) {
 81:     if (numDice <= 0) return 0;
 82: 
 83:     int count = 0;
 84:     for (int i = 0; i < numDice; i++) {
 85:       int roll = _random.nextInt(6) + 1;
 86:       if (roll <= target) count++;
 87:     }
 88:     return count;
 89:   }
 90: 
 91:   // Function to calculate expected successes
 92:   double calculateExpectedSuccesses(double numDice, int target) {
 93:     return numDice * (target / 6);
 94:   }
 95: 
 96:   // Initialize with default values
 97:   WaveScreenState() {
 98:     updateExpectedValues();
 99:   }
100: }
101: 
102: // Main container widget
103: class TabsContainerScreen extends StatefulWidget {
104:   const TabsContainerScreen({Key? key}) : super(key: key);
105: 
106:   @override
107:   State<TabsContainerScreen> createState() => _TabsContainerScreenState();
108: }
109: 
110: class _TabsContainerScreenState extends State<TabsContainerScreen>
111:     with TickerProviderStateMixin {
112:   // Tab controller
113:   late TabController _tabController;
114: 
115:   // Checkbox states
116:   bool _impactsChecked = false;
117:   bool _clashChecked = true;
118: 
119:   // Independent state for each tab - the key is persistent for the lifetime of this widget
120:   final Map<String, WaveScreenState> _tabStates = {
121:     'Impacts': WaveScreenState(),
122:     'Clash': WaveScreenState(),
123:   };
124: 
125:   // List of active tabs
126:   List<String> _activeTabs = ['Clash'];
127: 
128:   @override
129:   void initState() {
130:     super.initState();
131:     _tabController = TabController(length: _activeTabs.length, vsync: this);
132:   }
133: 
134:   @override
135:   void dispose() {
136:     _tabController.dispose();
137:     super.dispose();
138:   }
139: 
140:   // Update tabs based on checkbox selections while preserving state
141:   void _updateTabs() {
142:     setState(() {
143:       _activeTabs = [];
144: 
145:       if (_impactsChecked) {
146:         _activeTabs.add('Impacts');
147:       }
148: 
149:       if (_clashChecked) {
150:         _activeTabs.add('Clash');
151:       }
152: 
153:       // If no checkboxes are selected, ensure at least one tab exists
154:       if (_activeTabs.isEmpty) {
155:         _activeTabs = ['None Selected'];
156:       }
157: 
158:       // Create a new tab controller with the updated length
159:       _tabController = TabController(length: _activeTabs.length, vsync: this);
160: 
161:       // Set to the first tab when tabs change
162:       _tabController.index = 0;
163:     });
164:   }
165: 
166:   @override
167:   Widget build(BuildContext context) {
168:     return Scaffold(
169:       body: Column(
170:         children: [
171:           // Top section (25% of screen) with checkboxes
172:           Container(
173:             height: MediaQuery.of(context).size.height * 0.25,
174:             padding: EdgeInsets.all(16),
175:             decoration: BoxDecoration(
176:               color: Colors.grey.shade100,
177:               border: Border(
178:                 bottom: BorderSide(
179:                   color: Colors.grey.shade300,
180:                   width: 1,
181:                 ),
182:               ),
183:             ),
184:             child: Column(
185:               crossAxisAlignment: CrossAxisAlignment.start,
186:               mainAxisAlignment: MainAxisAlignment.center,
187:               children: [
188:                 Text(
189:                   'Select Types of Rolls:',
190:                   style: TextStyle(
191:                     fontSize: 24,
192:                     fontWeight: FontWeight.bold,
193:                   ),
194:                 ),
195:                 SizedBox(height: 16),
196:                 Row(
197:                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
198:                   children: [
199:                     // Impacts checkbox
200:                     Row(
201:                       children: [
202:                         Checkbox(
203:                           value: _impactsChecked,
204:                           onChanged: (bool? value) {
205:                             setState(() {
206:                               _impactsChecked = value ?? false;
207:                               _updateTabs();
208:                             });
209:                           },
210:                           activeColor: Colors.deepPurple,
211:                         ),
212:                         Text(
213:                           'Impacts',
214:                           style: TextStyle(
215:                             fontSize: 20,
216:                             fontWeight: FontWeight.bold,
217:                           ),
218:                         ),
219:                       ],
220:                     ),
221: 
222:                     // Clash checkbox
223:                     Row(
224:                       children: [
225:                         Checkbox(
226:                           value: _clashChecked,
227:                           onChanged: (bool? value) {
228:                             setState(() {
229:                               _clashChecked = value ?? false;
230:                               _updateTabs();
231:                             });
232:                           },
233:                           activeColor: Colors.deepPurple,
234:                         ),
235:                         Text(
236:                           'Clash',
237:                           style: TextStyle(
238:                             fontSize: 20,
239:                             fontWeight: FontWeight.bold,
240:                           ),
241:                         ),
242:                       ],
243:                     ),
244:                   ],
245:                 ),
246:               ],
247:             ),
248:           ),
249: 
250:           // Tab bar (remaining 75% of screen)
251:           Expanded(
252:             child: Column(
253:               children: [
254:                 // Tab bar
255:                 TabBar(
256:                   controller: _tabController,
257:                   tabs:
258:                       _activeTabs.map((tabName) => Tab(text: tabName)).toList(),
259:                   labelColor: Colors.deepPurple,
260:                   unselectedLabelColor: Colors.grey,
261:                   labelStyle:
262:                       TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
263:                   indicatorColor: Colors.deepPurple,
264:                   indicatorWeight: 3,
265:                 ),
266: 
267:                 // Tab content
268:                 Expanded(
269:                   child: TabBarView(
270:                     controller: _tabController,
271:                     children: _activeTabs.map((tabName) {
272:                       if (tabName == 'None Selected') {
273:                         return Center(
274:                           child: Text(
275:                             'Please select at least one type of roll',
276:                             style: TextStyle(fontSize: 18),
277:                           ),
278:                         );
279:                       } else {
280:                         // Use a keyed widget with externalized state
281:                         return WaveScreen(
282:                           key: ValueKey(tabName),
283:                           state: _tabStates[tabName]!,
284:                         );
285:                       }
286:                     }).toList(),
287:                   ),
288:                 ),
289:               ],
290:             ),
291:           ),
292:         ],
293:       ),
294:     );
295:   }
296: }
297: 
298: // Modified WaveScreen to take an external state
299: class WaveScreen extends StatefulWidget {
300:   final WaveScreenState state;
301: 
302:   const WaveScreen({Key? key, required this.state}) : super(key: key);
303: 
304:   @override
305:   State<WaveScreen> createState() => _WaveScreenState();
306: }
307: 
308: class _WaveScreenState extends State<WaveScreen> with TickerProviderStateMixin {
309:   // Animation controllers
310:   late AnimationController _controller;
311:   late AnimationController _secondController;
312:   late AnimationController _thirdController;
313: 
314:   // Shorthand to access the state
315:   WaveScreenState get state => widget.state;
316: 
317:   @override
318:   void initState() {
319:     super.initState();
320: 
321:     // Setup first animation controller with completion listener
322:     _controller = AnimationController(
323:       vsync: this,
324:       duration: Duration(milliseconds: 1500),
325:     )..addStatusListener((status) {
326:         if (status == AnimationStatus.completed) {
327:           print("First animation completed"); // Debug
328:           setState(() {
329:             if (state.secondNumDice > 0) {
330:               state.secondAnimationStarted = true;
331:               // Start second animation with delay
332:               Future.delayed(Duration(milliseconds: 300), () {
333:                 _startSecondAnimation();
334:               });
335:             }
336:           });
337:         }
338:       });
339: 
340:     // Setup second animation controller with completion listener
341:     _secondController = AnimationController(
342:       vsync: this,
343:       duration: Duration(milliseconds: 1500),
344:     )..addStatusListener((status) {
345:         if (status == AnimationStatus.completed) {
346:           print("Second animation completed"); // Debug
347:           setState(() {
348:             if (state.thirdNumDice > 0) {
349:               state.thirdAnimationStarted = true;
350:               // Start third animation with delay
351:               Future.delayed(Duration(milliseconds: 300), () {
352:                 _startThirdAnimation();
353:               });
354:             }
355:           });
356:         }
357:       });
358: 
359:     // Setup third animation controller
360:     _thirdController = AnimationController(
361:       vsync: this,
362:       duration: Duration(milliseconds: 1500),
363:     )..addStatusListener((status) {
364:         if (status == AnimationStatus.completed) {
365:           print("Third animation completed"); // Debug
366:         }
367:       });
368:   }
369: 
370:   // Start the second animation
371:   void _startSecondAnimation() {
372:     print("Starting second animation"); // Debug
373:     if (state.secondNumDice > 0 && state.secondAnimationStarted) {
374:       double secondSuccessPercentage = state.secondResult / state.secondNumDice;
375:       _animateWave(
376:           secondSuccessPercentage, _secondController, _updateSecondWave);
377:     }
378:   }
379: 
380:   // Start the third animation
381:   void _startThirdAnimation() {
382:     print("Starting third animation"); // Debug
383:     if (state.thirdNumDice > 0 && state.thirdAnimationStarted) {
384:       double thirdSuccessPercentage = state.thirdResult / state.thirdNumDice;
385:       _animateWave(thirdSuccessPercentage, _thirdController, _updateThirdWave);
386:     }
387:   }
388: 
389:   // Common animation function
390:   void _animateWave(double successRate, AnimationController controller,
391:       Function(double) updateState) {
392:     controller.reset();
393: 
394:     final up1 = Tween<double>(begin: 0, end: 1).animate(
395:       CurvedAnimation(
396:           parent: controller,
397:           curve: Interval(0.0, 0.33, curve: Curves.easeInOut)),
398:     );
399:     final down = Tween<double>(begin: 1, end: 0).animate(
400:       CurvedAnimation(
401:           parent: controller,
402:           curve: Interval(0.33, 0.66, curve: Curves.easeInOut)),
403:     );
404:     final up2 = Tween<double>(begin: 0, end: successRate).animate(
405:       CurvedAnimation(
406:           parent: controller,
407:           curve: Interval(0.66, 1.0, curve: Curves.easeInOut)),
408:     );
409: 
410:     controller.addListener(() {
411:       setState(() {
412:         if (controller.value <= 0.33) {
413:           updateState(up1.value);
414:         } else if (controller.value <= 0.66) {
415:           updateState(down.value);
416:         } else {
417:           updateState(up2.value);
418:         }
419:       });
420:     });
421: 
422:     controller.forward();
423:   }
424: 
425:   // Update functions for each wave
426:   void _updateFirstWave(double value) {
427:     setState(() {
428:       state.dragPercentage = value;
429:       state.firstSliderPosition =
430:           (state.numDice * state.dragPercentage).round();
431:     });
432:   }
433: 
434:   void _updateSecondWave(double value) {
435:     setState(() {
436:       state.secondDragPercentage = value;
437:       state.secondSliderPosition =
438:           (state.secondNumDice * state.secondDragPercentage).round();
439:     });
440:   }
441: 
442:   void _updateThirdWave(double value) {
443:     setState(() {
444:       state.thirdDragPercentage = value;
445:       state.thirdSliderPosition =
446:           (state.thirdNumDice * state.thirdDragPercentage).round();
447:       _updateWoundsCounter();
448:     });
449:   }
450: 
451:   // Update the wounds counters (both actual and expected)
452:   void _updateWoundsCounter() {
453:     // Calculate actual wounds
454:     int defenceFails = state.secondNumDice - state.secondSliderPosition;
455:     int resolveFails = state.thirdNumDice - state.thirdSliderPosition;
456: 
457:     setState(() {
458:       state.totalWounds = defenceFails + resolveFails;
459:     });
460:   }
461: 
462:   // Roll dice action
463:   void _rollDice() {
464:     print(
465:         "Roll dice pressed. NumDice: ${state.numDice}, Target: ${state.target}"); // Debug
466:     int result = state.rollDice(state.numDice, state.target);
467:     double expectedSuccesses = state.calculateExpectedSuccesses(
468:         state.numDice.toDouble(), state.target);
469: 
470:     // Call the original update function with rolled results
471:     _updateResults(result, state.numDice, expectedSuccesses);
472:   }
473: 
474:   // Triggered when Roll Dice button is pressed
475:   void _updateResults(int result, int numDice, double expectedSuccesses) {
476:     print("Roll dice pressed. Result: $result, NumDice: $numDice"); // Debug
477: 
478:     // Ensure all controllers are reset
479:     _controller.reset();
480:     _secondController.reset();
481:     _thirdController.reset();
482: 
483:     // Store current expected wounds value to preserve it
484:     double currentExpectedWounds = state.expectedWounds;
485: 
486:     setState(() {
487:       // Reset animation flags
488:       state.firstAnimationStarted = true; // First animation starts immediately
489:       state.secondAnimationStarted = false;
490:       state.thirdAnimationStarted = false;
491: 
492:       // Store first roll results
493:       state.numDice = numDice;
494:       state.expectedSuccesses = expectedSuccesses;
495:       state.firstResult = result;
496:       state.expectedSuccessPercentage =
497:           numDice > 0 ? expectedSuccesses / numDice : 0;
498: 
499:       // Set the second dice number to the result of the first roll (hits)
500:       state.secondNumDice = result;
501: 
502:       // Calculate expected successes for second roll based on ACTUAL first result
503:       state.secondExpectedSuccesses = state.calculateExpectedSuccesses(
504:           state.secondNumDice.toDouble(), state.secondTarget);
505:       state.secondExpectedSuccessPercentage = state.secondNumDice > 0
506:           ? state.secondExpectedSuccesses / state.secondNumDice
507:           : 0;
508: 
509:       // Perform second dice roll (Defence)
510:       state.secondResult =
511:           state.rollDice(state.secondNumDice, state.secondTarget);
512: 
513:       // Set the third dice number to the fails from the second roll
514:       state.thirdNumDice = state.secondNumDice - state.secondResult;
515: 
516:       // Calculate expected successes for third roll based on ACTUAL second result fails
517:       state.thirdExpectedSuccesses = state.calculateExpectedSuccesses(
518:           state.thirdNumDice.toDouble(), state.thirdTarget);
519:       state.thirdExpectedSuccessPercentage = state.thirdNumDice > 0
520:           ? state.thirdExpectedSuccesses / state.thirdNumDice
521:           : 0;
522: 
523:       // Perform third dice roll (Resolve)
524:       state.thirdResult = state.rollDice(state.thirdNumDice, state.thirdTarget);
525: 
526:       // Reset the drag percentages
527:       state.dragPercentage = 0.0;
528:       state.secondDragPercentage = 0.0;
529:       state.thirdDragPercentage = 0.0;
530: 
531:       // Reset positions
532:       state.firstSliderPosition = 0;
533:       state.secondSliderPosition = 0;
534:       state.thirdSliderPosition = 0;
535: 
536:       // Keep the expected wounds value the same as before the roll
537:       state.expectedWounds = currentExpectedWounds;
538: 
539:       // Initialize actual wounds to 0 instead of expected wounds
540:       state.totalWounds = 0;
541:     });
542: 
543:     // Start first animation
544:     double successPercentage = numDice > 0 ? result / numDice : 0;
545:     _animateWave(successPercentage, _controller, _updateFirstWave);
546:   }
547: 
548:   // Target selectors change handlers
549:   void _onFirstTargetChanged(int value) {
550:     setState(() {
551:       state.target = value;
552:       state.updateExpectedValues();
553:     });
554:   }
555: 
556:   void _onSecondTargetChanged(int value) {
557:     setState(() {
558:       state.secondTarget = value;
559:       state.updateExpectedValues();
560:     });
561:   }
562: 
563:   void _onThirdTargetChanged(int value) {
564:     setState(() {
565:       state.thirdTarget = value;
566:       state.updateExpectedValues();
567:     });
568:   }
569: 
570:   @override
571:   void dispose() {
572:     _controller.dispose();
573:     _secondController.dispose();
574:     _thirdController.dispose();
575:     super.dispose();
576:   }
577: 
578:   @override
579:   Widget build(BuildContext context) {
580:     return Container(
581:       padding: EdgeInsets.all(24.0),
582:       child: Center(
583:         child: Column(
584:           mainAxisAlignment: MainAxisAlignment.center,
585:           children: <Widget>[
586:             // Dice roller UI
587:             Row(
588:               mainAxisAlignment: MainAxisAlignment.spaceBetween,
589:               crossAxisAlignment: CrossAxisAlignment.center,
590:               children: [
591:                 // Roll Dice button on the left
592:                 ElevatedButton(
593:                   onPressed: _rollDice,
594:                   style: ElevatedButton.styleFrom(
595:                     backgroundColor: Colors.deepPurple,
596:                     padding: EdgeInsets.symmetric(
597:                       horizontal: 48,
598:                       vertical: 24,
599:                     ),
600:                     textStyle: TextStyle(fontSize: 20),
601:                   ),
602:                   child: Text(
603:                     'Roll Dice',
604:                     style: TextStyle(
605:                       color: Colors.black,
606:                       fontWeight: FontWeight.bold,
607:                     ),
608:                   ),
609:                 ),
610: 
611:                 // Dice number selector
612:                 Row(
613:                   crossAxisAlignment: CrossAxisAlignment.center,
614:                   children: [
615:                     Text('Dice:', style: TextStyle(fontSize: 20)),
616:                     SizedBox(width: 20),
617:                     TargetSelector(
618:                       selectionLimit: 30,
619:                       initialValue: state.numDice,
620:                       textSize: 20,
621:                       onChanged: (value) => setState(() {
622:                         state.numDice = value;
623:                         state.updateExpectedValues();
624:                       }),
625:                     ),
626:                   ],
627:                 ),
628:               ],
629:             ),
630: 
631:             SizedBox(height: 10.0),
632: 
633:             // First wave slider section (Hits) with aligned title and target dropdown
634:             Row(
635:               mainAxisAlignment: MainAxisAlignment.spaceBetween,
636:               crossAxisAlignment: CrossAxisAlignment.center,
637:               children: [
638:                 // Hits title on the left
639:                 Text(
640:                   'Clash',
641:                   style:
642:                       TextStyle(fontSize: 35, fontFamily: 'Permanent Marker'),
643:                 ),
644: 
645:                 // Hits target selector on the right, aligned with title
646:                 Row(
647:                   crossAxisAlignment: CrossAxisAlignment.center,
648:                   children: [
649:                     SizedBox(width: 20),
650:                     TargetSelector(
651:                       selectionLimit: 6,
652:                       initialValue: state.target,
653:                       textSize: 20,
654:                       onChanged: _onFirstTargetChanged,
655:                     ),
656:                   ],
657:                 ),
658:               ],
659:             ),
660:             SizedBox(height: 5.0),
661:             WaveSlider(
662:               dragPercentage: state.dragPercentage,
663:               expectedSuccessPercentage: state.expectedSuccessPercentage,
664:               numDice: state.numDice,
665:               expectedSuccesses: state.expectedSuccesses,
666:               onChanged: (double value) {},
667:             ),
668: 
669:             SizedBox(height: 5.0),
670: 
671:             // Second wave slider section (Defence) with aligned title and target selector
672:             Row(
673:               mainAxisAlignment: MainAxisAlignment.spaceBetween,
674:               crossAxisAlignment: CrossAxisAlignment.center,
675:               children: [
676:                 // Defence title on the left
677:                 Text(
678:                   'Defence',
679:                   style:
680:                       TextStyle(fontSize: 35, fontFamily: 'Permanent Marker'),
681:                 ),
682: 
683:                 // Defence target selector on the right, aligned with title
684:                 Row(
685:                   crossAxisAlignment: CrossAxisAlignment.center,
686:                   children: [
687:                     SizedBox(width: 20),
688:                     TargetSelector(
689:                       selectionLimit: 6,
690:                       initialValue: state.secondTarget,
691:                       textSize: 20,
692:                       onChanged: _onSecondTargetChanged,
693:                     ),
694:                   ],
695:                 ),
696:               ],
697:             ),
698:             SizedBox(height: 5.0),
699:             WaveSlider(
700:               dragPercentage: state.secondDragPercentage,
701:               expectedSuccessPercentage: state.secondExpectedSuccessPercentage,
702:               numDice: state.secondNumDice,
703:               expectedSuccesses: state.secondExpectedSuccesses,
704:               onChanged: (double value) {},
705:             ),
706: 
707:             SizedBox(height: 5.0),
708: 
709:             // Third wave slider section (Resolve) with aligned title and target selector
710:             Row(
711:               mainAxisAlignment: MainAxisAlignment.spaceBetween,
712:               crossAxisAlignment: CrossAxisAlignment.center,
713:               children: [
714:                 // Resolve title on the left
715:                 Text(
716:                   'Resolve',
717:                   style:
718:                       TextStyle(fontSize: 35, fontFamily: 'Permanent Marker'),
719:                 ),
720: 
721:                 // Resolve target selector on the right, aligned with title
722:                 Row(
723:                   crossAxisAlignment: CrossAxisAlignment.center,
724:                   children: [
725:                     SizedBox(width: 20),
726:                     TargetSelector(
727:                       selectionLimit: 6,
728:                       initialValue: state.thirdTarget,
729:                       textSize: 20,
730:                       onChanged: _onThirdTargetChanged,
731:                     ),
732:                   ],
733:                 ),
734:               ],
735:             ),
736:             SizedBox(height: 5.0),
737:             WaveSlider(
738:               dragPercentage: state.thirdDragPercentage,
739:               expectedSuccessPercentage: state.thirdExpectedSuccessPercentage,
740:               numDice: state.thirdNumDice,
741:               expectedSuccesses: state.thirdExpectedSuccesses,
742:               onChanged: (double value) {},
743:             ),
744: 
745:             SizedBox(height: 15.0),
746: 
747:             // Wounds counter
748:             Container(
749:               padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
750:               width: 270,
751:               decoration: BoxDecoration(
752:                 color: Colors.red.withOpacity(0.2),
753:                 borderRadius: BorderRadius.circular(12),
754:                 border: Border.all(color: Colors.red, width: 1.5),
755:               ),
756:               child: Column(
757:                 mainAxisSize: MainAxisSize.min,
758:                 children: [
759:                   // Title
760:                   Text(
761:                     'Wounds',
762:                     style: TextStyle(
763:                       fontSize: 22,
764:                       fontWeight: FontWeight.bold,
765:                     ),
766:                   ),
767:                   SizedBox(height: 2),
768:                   // Values row
769:                   Row(
770:                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
771:                     children: [
772:                       // Expected wounds on the left
773:                       Row(
774:                         children: [
775:                           Text(
776:                             '${state.expectedWounds.toStringAsFixed(1)}',
777:                             style: TextStyle(
778:                               fontSize: 22,
779:                               fontWeight: FontWeight.bold,
780:                               color: Colors.deepPurple,
781:                             ),
782:                           ),
783:                           Text(
784:                             ' xW',
785:                             style: TextStyle(
786:                               fontSize: 16,
787:                               fontWeight: FontWeight.bold,
788:                             ),
789:                           ),
790:                         ],
791:                       ),
792: 
793:                       // Actual wounds on the right
794:                       Row(
795:                         children: [
796:                           Text(
797:                             '${state.totalWounds}',
798:                             style: TextStyle(
799:                               fontSize: 22,
800:                               fontWeight: FontWeight.bold,
801:                               color: Colors.red,
802:                             ),
803:                           ),
804:                           Text(
805:                             ' W',
806:                             style: TextStyle(
807:                               fontSize: 16,
808:                               fontWeight: FontWeight.bold,
809:                             ),
810:                           ),
811:                         ],
812:                       ),
813:                     ],
814:                   ),
815:                 ],
816:               ),
817:             ),
818:           ],
819:         ),
820:       ),
821:     );
822:   }
823: }
````

## File: templates/card/lib/play_session/wave_slider.dart
````dart
  1: import 'package:flutter/material.dart';
  2: import 'wave_painter.dart';
  3: 
  4: class WaveSlider extends StatefulWidget {
  5:   final double width;
  6:   final double height;
  7:   final Color color;
  8:   final ValueChanged<double> onChanged;
  9:   final double dragPercentage;
 10:   final double expectedSuccessPercentage;
 11:   final int numDice;
 12:   final double expectedSuccesses;
 13: 
 14:   const WaveSlider({
 15:     this.width = 400.0, // Increased from 350.0 to use more horizontal space
 16:     this.height = 70.0, // Increased from 60.0 to give more vertical space
 17:     this.color = Colors.black,
 18:     required this.onChanged,
 19:     this.dragPercentage = 0.0,
 20:     this.expectedSuccessPercentage = 0.0,
 21:     this.numDice = 1,
 22:     this.expectedSuccesses = 0,
 23:   }) : assert(height >= 50 && height <= 600);
 24: 
 25:   @override
 26:   State<WaveSlider> createState() => _WaveSliderState();
 27: }
 28: 
 29: class _WaveSliderState extends State<WaveSlider> {
 30:   double _dragPosition = 0;
 31:   double _dragPercentage = 0;
 32: 
 33:   @override
 34:   void didUpdateWidget(covariant WaveSlider oldWidget) {
 35:     super.didUpdateWidget(oldWidget);
 36:     if (widget.dragPercentage != oldWidget.dragPercentage) {
 37:       setState(() {
 38:         _dragPercentage = widget.dragPercentage;
 39:         _dragPosition = _dragPercentage * widget.width;
 40:       });
 41:     }
 42:   }
 43: 
 44:   void _updateDragPosition(Offset val) {
 45:     double newDragPosition = val.dx.clamp(0, widget.width);
 46:     setState(() {
 47:       _dragPosition = newDragPosition;
 48:       _dragPercentage = _dragPosition / widget.width;
 49:     });
 50:     widget.onChanged(_dragPercentage);
 51:   }
 52: 
 53:   @override
 54:   Widget build(BuildContext context) {
 55:     // Create a buffer around the slider for visual elements
 56:     final horizontalBuffer = 20.0;
 57:     final verticalBuffer = 10.0; // Further reduced to maximize space
 58: 
 59:     // Calculate the actual drawing area dimensions
 60:     final drawingWidth = widget.width - (horizontalBuffer * 2);
 61:     final drawingHeight = widget.height;
 62: 
 63:     // Calculate the adjusted drag position within the drawing area
 64:     final adjustedDragPosition =
 65:         (drawingWidth * _dragPercentage) + horizontalBuffer;
 66: 
 67:     return Container(
 68:       width: widget.width,
 69:       height: widget.height + 25, // Extra space for text below
 70:       // Add a light border for debugging
 71:       decoration: BoxDecoration(
 72:         border: Border.all(color: Colors.grey.withOpacity(0.1)),
 73:         borderRadius: BorderRadius.circular(4),
 74:       ),
 75:       child: Stack(
 76:         alignment: Alignment.center,
 77:         children: [
 78:           // Drawing container with buffer space
 79:           Positioned(
 80:             left: 0,
 81:             top: 0,
 82:             right: 0,
 83:             bottom: 0,
 84:             child: CustomPaint(
 85:               painter: WavePainter(
 86:                 sliderPosition: adjustedDragPosition,
 87:                 dragPercentage: _dragPercentage,
 88:                 expectedSuccessPercentage: widget.expectedSuccessPercentage,
 89:                 numDice: widget.numDice,
 90:                 expectedSuccesses: widget.expectedSuccesses,
 91:                 horizontalBuffer: horizontalBuffer,
 92:                 verticalBuffer: verticalBuffer,
 93:                 drawingWidth: drawingWidth,
 94:                 drawingHeight: drawingHeight,
 95:               ),
 96:               // This forces CustomPainter to use the full size
 97:               size: Size(widget.width, widget.height + 25),
 98:             ),
 99:           ),
100: 
101:           // Value indicator - positioned just above the wave line
102:           Positioned(
103:             left: adjustedDragPosition - 15, // Center it on the wave
104:             top: widget.height - 35, // Position above the wave line
105:             child: Container(
106:               padding: EdgeInsets.symmetric(
107:                   horizontal: 8, vertical: 2), // Reduced vertical padding
108:               decoration: BoxDecoration(
109:                 color: Colors.white.withOpacity(0.5),
110:                 borderRadius:
111:                     BorderRadius.circular(8), // Slightly smaller radius
112:               ),
113:               child: Text(
114:                 '${(widget.numDice * _dragPercentage).round()}',
115:                 style: TextStyle(
116:                   fontSize: 24,
117:                   fontWeight: FontWeight.bold,
118:                 ),
119:               ),
120:             ),
121:           ),
122:         ],
123:       ),
124:     );
125:   }
126: }
````

## File: templates/card/lib/player_progress/persistence/local_storage_player_progress_persistence.dart
````dart
 1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: import 'package:shared_preferences/shared_preferences.dart';
 6: 
 7: import 'player_progress_persistence.dart';
 8: 
 9: /// An implementation of [PlayerProgressPersistence] that uses
10: /// `package:shared_preferences`.
11: class LocalStoragePlayerProgressPersistence extends PlayerProgressPersistence {
12:   final Future<SharedPreferences> instanceFuture =
13:       SharedPreferences.getInstance();
14: 
15:   @override
16:   Future<int> getHighestLevelReached() async {
17:     final prefs = await instanceFuture;
18:     return prefs.getInt('highestLevelReached') ?? 0;
19:   }
20: 
21:   @override
22:   Future<void> saveHighestLevelReached(int level) async {
23:     final prefs = await instanceFuture;
24:     await prefs.setInt('highestLevelReached', level);
25:   }
26: }
````

## File: templates/card/lib/player_progress/persistence/memory_player_progress_persistence.dart
````dart
 1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: import 'player_progress_persistence.dart';
 6: 
 7: /// An in-memory implementation of [PlayerProgressPersistence].
 8: /// Useful for testing.
 9: class MemoryOnlyPlayerProgressPersistence implements PlayerProgressPersistence {
10:   int level = 0;
11: 
12:   @override
13:   Future<int> getHighestLevelReached() async {
14:     await Future<void>.delayed(const Duration(milliseconds: 500));
15:     return level;
16:   }
17: 
18:   @override
19:   Future<void> saveHighestLevelReached(int level) async {
20:     await Future<void>.delayed(const Duration(milliseconds: 500));
21:     this.level = level;
22:   }
23: }
````

## File: templates/card/lib/player_progress/persistence/player_progress_persistence.dart
````dart
 1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: /// An interface of persistence stores for the player's progress.
 6: ///
 7: /// Implementations can range from simple in-memory storage through
 8: /// local preferences to cloud saves.
 9: abstract class PlayerProgressPersistence {
10:   Future<int> getHighestLevelReached();
11: 
12:   Future<void> saveHighestLevelReached(int level);
13: }
````

## File: templates/card/lib/player_progress/player_progress.dart
````dart
 1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: import 'dart:async';
 6: 
 7: import 'package:flutter/foundation.dart';
 8: 
 9: import 'persistence/local_storage_player_progress_persistence.dart';
10: import 'persistence/player_progress_persistence.dart';
11: 
12: /// Encapsulates the player's progress.
13: class PlayerProgress extends ChangeNotifier {
14:   static const maxHighestScoresPerPlayer = 10;
15: 
16:   /// By default, settings are persisted using
17:   /// [LocalStoragePlayerProgressPersistence] (i.e. NSUserDefaults on iOS,
18:   /// SharedPreferences on Android or local storage on the web).
19:   final PlayerProgressPersistence _store;
20: 
21:   int _highestLevelReached = 0;
22: 
23:   /// Creates an instance of [PlayerProgress] backed by an injected
24:   /// persistence [store].
25:   PlayerProgress({PlayerProgressPersistence? store})
26:       : _store = store ?? LocalStoragePlayerProgressPersistence() {
27:     _getLatestFromStore();
28:   }
29: 
30:   /// The highest level that the player has reached so far.
31:   int get highestLevelReached => _highestLevelReached;
32: 
33:   /// Resets the player's progress so it's like if they just started
34:   /// playing the game for the first time.
35:   void reset() {
36:     _highestLevelReached = 0;
37:     notifyListeners();
38:     _store.saveHighestLevelReached(_highestLevelReached);
39:   }
40: 
41:   /// Registers [level] as reached.
42:   ///
43:   /// If this is higher than [highestLevelReached], it will update that
44:   /// value and save it to the injected persistence store.
45:   void setLevelReached(int level) {
46:     if (level > _highestLevelReached) {
47:       _highestLevelReached = level;
48:       notifyListeners();
49: 
50:       unawaited(_store.saveHighestLevelReached(level));
51:     }
52:   }
53: 
54:   /// Fetches the latest data from the backing persistence store.
55:   Future<void> _getLatestFromStore() async {
56:     final level = await _store.getHighestLevelReached();
57:     if (level > _highestLevelReached) {
58:       _highestLevelReached = level;
59:       notifyListeners();
60:     } else if (level < _highestLevelReached) {
61:       await _store.saveHighestLevelReached(_highestLevelReached);
62:     }
63:   }
64: }
````

## File: templates/card/lib/settings/persistence/local_storage_settings_persistence.dart
````dart
 1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: import 'package:shared_preferences/shared_preferences.dart';
 6: 
 7: import 'settings_persistence.dart';
 8: 
 9: /// An implementation of [SettingsPersistence] that uses
10: /// `package:shared_preferences`.
11: class LocalStorageSettingsPersistence extends SettingsPersistence {
12:   final Future<SharedPreferences> instanceFuture =
13:       SharedPreferences.getInstance();
14: 
15:   @override
16:   Future<bool> getAudioOn({required bool defaultValue}) async {
17:     final prefs = await instanceFuture;
18:     return prefs.getBool('audioOn') ?? defaultValue;
19:   }
20: 
21:   @override
22:   Future<bool> getMusicOn({required bool defaultValue}) async {
23:     final prefs = await instanceFuture;
24:     return prefs.getBool('musicOn') ?? defaultValue;
25:   }
26: 
27:   @override
28:   Future<String> getPlayerName() async {
29:     final prefs = await instanceFuture;
30:     return prefs.getString('playerName') ?? 'Player';
31:   }
32: 
33:   @override
34:   Future<bool> getSoundsOn({required bool defaultValue}) async {
35:     final prefs = await instanceFuture;
36:     return prefs.getBool('soundsOn') ?? defaultValue;
37:   }
38: 
39:   @override
40:   Future<void> saveAudioOn(bool value) async {
41:     final prefs = await instanceFuture;
42:     await prefs.setBool('audioOn', value);
43:   }
44: 
45:   @override
46:   Future<void> saveMusicOn(bool value) async {
47:     final prefs = await instanceFuture;
48:     await prefs.setBool('musicOn', value);
49:   }
50: 
51:   @override
52:   Future<void> savePlayerName(String value) async {
53:     final prefs = await instanceFuture;
54:     await prefs.setString('playerName', value);
55:   }
56: 
57:   @override
58:   Future<void> saveSoundsOn(bool value) async {
59:     final prefs = await instanceFuture;
60:     await prefs.setBool('soundsOn', value);
61:   }
62: }
````

## File: templates/card/lib/settings/persistence/memory_settings_persistence.dart
````dart
 1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: import 'settings_persistence.dart';
 6: 
 7: /// An in-memory implementation of [SettingsPersistence].
 8: /// Useful for testing.
 9: class MemoryOnlySettingsPersistence implements SettingsPersistence {
10:   bool musicOn = true;
11: 
12:   bool soundsOn = true;
13: 
14:   bool audioOn = true;
15: 
16:   String playerName = 'Player';
17: 
18:   @override
19:   Future<bool> getAudioOn({required bool defaultValue}) async => audioOn;
20: 
21:   @override
22:   Future<bool> getMusicOn({required bool defaultValue}) async => musicOn;
23: 
24:   @override
25:   Future<String> getPlayerName() async => playerName;
26: 
27:   @override
28:   Future<bool> getSoundsOn({required bool defaultValue}) async => soundsOn;
29: 
30:   @override
31:   Future<void> saveAudioOn(bool value) async => audioOn = value;
32: 
33:   @override
34:   Future<void> saveMusicOn(bool value) async => musicOn = value;
35: 
36:   @override
37:   Future<void> savePlayerName(String value) async => playerName = value;
38: 
39:   @override
40:   Future<void> saveSoundsOn(bool value) async => soundsOn = value;
41: }
````

## File: templates/card/lib/settings/persistence/settings_persistence.dart
````dart
 1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: /// An interface of persistence stores for settings.
 6: ///
 7: /// Implementations can range from simple in-memory storage through
 8: /// local preferences to cloud-based solutions.
 9: abstract class SettingsPersistence {
10:   Future<bool> getAudioOn({required bool defaultValue});
11: 
12:   Future<bool> getMusicOn({required bool defaultValue});
13: 
14:   Future<String> getPlayerName();
15: 
16:   Future<bool> getSoundsOn({required bool defaultValue});
17: 
18:   Future<void> saveAudioOn(bool value);
19: 
20:   Future<void> saveMusicOn(bool value);
21: 
22:   Future<void> savePlayerName(String value);
23: 
24:   Future<void> saveSoundsOn(bool value);
25: }
````

## File: templates/card/lib/settings/custom_name_dialog.dart
````dart
 1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: import 'package:flutter/material.dart';
 6: import 'package:flutter/services.dart';
 7: import 'package:provider/provider.dart';
 8: 
 9: import 'settings.dart';
10: 
11: void showCustomNameDialog(BuildContext context) {
12:   showGeneralDialog(
13:       context: context,
14:       pageBuilder: (context, animation, secondaryAnimation) =>
15:           CustomNameDialog(animation: animation));
16: }
17: 
18: class CustomNameDialog extends StatefulWidget {
19:   final Animation<double> animation;
20: 
21:   const CustomNameDialog({required this.animation, super.key});
22: 
23:   @override
24:   State<CustomNameDialog> createState() => _CustomNameDialogState();
25: }
26: 
27: class _CustomNameDialogState extends State<CustomNameDialog> {
28:   final TextEditingController _controller = TextEditingController();
29: 
30:   @override
31:   Widget build(BuildContext context) {
32:     return ScaleTransition(
33:       scale: CurvedAnimation(
34:         parent: widget.animation,
35:         curve: Curves.easeOutCubic,
36:       ),
37:       child: SimpleDialog(
38:         title: const Text('Change name'),
39:         children: [
40:           TextField(
41:             controller: _controller,
42:             autofocus: true,
43:             maxLength: 12,
44:             maxLengthEnforcement: MaxLengthEnforcement.enforced,
45:             textAlign: TextAlign.center,
46:             textCapitalization: TextCapitalization.words,
47:             textInputAction: TextInputAction.done,
48:             onChanged: (value) {
49:               context.read<SettingsController>().setPlayerName(value);
50:             },
51:             onSubmitted: (value) {
52:               // Player tapped 'Submit'/'Done' on their keyboard.
53:               Navigator.pop(context);
54:             },
55:           ),
56:           TextButton(
57:             onPressed: () => Navigator.pop(context),
58:             child: const Text('Close'),
59:           ),
60:         ],
61:       ),
62:     );
63:   }
64: 
65:   @override
66:   void dispose() {
67:     _controller.dispose();
68:     super.dispose();
69:   }
70: 
71:   @override
72:   void initState() {
73:     super.initState();
74:     _controller.text = context.read<SettingsController>().playerName.value;
75:   }
76: }
````

## File: templates/card/lib/settings/settings_screen.dart
````dart
  1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
  2: // for details. All rights reserved. Use of this source code is governed by a
  3: // BSD-style license that can be found in the LICENSE file.
  4: 
  5: import 'package:flutter/material.dart';
  6: import 'package:go_router/go_router.dart';
  7: import 'package:provider/provider.dart';
  8: 
  9: import '../player_progress/player_progress.dart';
 10: import '../style/my_button.dart';
 11: import '../style/palette.dart';
 12: import '../style/responsive_screen.dart';
 13: import 'custom_name_dialog.dart';
 14: import 'settings.dart';
 15: 
 16: class SettingsScreen extends StatelessWidget {
 17:   const SettingsScreen({super.key});
 18: 
 19:   static const _gap = SizedBox(height: 60);
 20: 
 21:   @override
 22:   Widget build(BuildContext context) {
 23:     final settings = context.watch<SettingsController>();
 24:     final palette = context.watch<Palette>();
 25: 
 26:     return Scaffold(
 27:       backgroundColor: palette.backgroundSettings,
 28:       body: ResponsiveScreen(
 29:         squarishMainArea: ListView(
 30:           children: [
 31:             _gap,
 32:             const Text(
 33:               'Settings',
 34:               textAlign: TextAlign.center,
 35:               style: TextStyle(
 36:                 fontFamily: 'Permanent Marker',
 37:                 fontSize: 55,
 38:                 height: 1,
 39:               ),
 40:             ),
 41:             _gap,
 42:             const _NameChangeLine(
 43:               'Name',
 44:             ),
 45:             ValueListenableBuilder<bool>(
 46:               valueListenable: settings.soundsOn,
 47:               builder: (context, soundsOn, child) => _SettingsLine(
 48:                 'Sound FX',
 49:                 Icon(soundsOn ? Icons.graphic_eq : Icons.volume_off),
 50:                 onSelected: () => settings.toggleSoundsOn(),
 51:               ),
 52:             ),
 53:             ValueListenableBuilder<bool>(
 54:               valueListenable: settings.musicOn,
 55:               builder: (context, musicOn, child) => _SettingsLine(
 56:                 'Music',
 57:                 Icon(musicOn ? Icons.music_note : Icons.music_off),
 58:                 onSelected: () => settings.toggleMusicOn(),
 59:               ),
 60:             ),
 61:             _SettingsLine(
 62:               'Reset progress',
 63:               const Icon(Icons.delete),
 64:               onSelected: () {
 65:                 context.read<PlayerProgress>().reset();
 66: 
 67:                 final messenger = ScaffoldMessenger.of(context);
 68:                 messenger.showSnackBar(
 69:                   const SnackBar(
 70:                       content: Text('Player progress has been reset.')),
 71:                 );
 72:               },
 73:             ),
 74:             _gap,
 75:           ],
 76:         ),
 77:         rectangularMenuArea: MyButton(
 78:           onPressed: () {
 79:             GoRouter.of(context).pop();
 80:           },
 81:           child: const Text('Back'),
 82:         ),
 83:       ),
 84:     );
 85:   }
 86: }
 87: 
 88: class _NameChangeLine extends StatelessWidget {
 89:   final String title;
 90: 
 91:   const _NameChangeLine(this.title);
 92: 
 93:   @override
 94:   Widget build(BuildContext context) {
 95:     final settings = context.watch<SettingsController>();
 96: 
 97:     return InkResponse(
 98:       highlightShape: BoxShape.rectangle,
 99:       onTap: () => showCustomNameDialog(context),
100:       child: Padding(
101:         padding: const EdgeInsets.symmetric(horizontal: 8),
102:         child: Row(
103:           mainAxisAlignment: MainAxisAlignment.center,
104:           children: [
105:             Text(title,
106:                 style: const TextStyle(
107:                   fontFamily: 'Permanent Marker',
108:                   fontSize: 30,
109:                 )),
110:             const Spacer(),
111:             ValueListenableBuilder(
112:               valueListenable: settings.playerName,
113:               builder: (context, name, child) => Text(
114:                 '‘$name’',
115:                 style: const TextStyle(
116:                   fontFamily: 'Permanent Marker',
117:                   fontSize: 30,
118:                 ),
119:               ),
120:             ),
121:           ],
122:         ),
123:       ),
124:     );
125:   }
126: }
127: 
128: class _SettingsLine extends StatelessWidget {
129:   final String title;
130: 
131:   final Widget icon;
132: 
133:   final VoidCallback? onSelected;
134: 
135:   const _SettingsLine(this.title, this.icon, {this.onSelected});
136: 
137:   @override
138:   Widget build(BuildContext context) {
139:     return InkResponse(
140:       highlightShape: BoxShape.rectangle,
141:       onTap: onSelected,
142:       child: Padding(
143:         padding: const EdgeInsets.symmetric(horizontal: 8),
144:         child: Row(
145:           mainAxisAlignment: MainAxisAlignment.start,
146:           children: [
147:             Expanded(
148:               child: Text(
149:                 title,
150:                 maxLines: 1,
151:                 overflow: TextOverflow.ellipsis,
152:                 style: const TextStyle(
153:                   fontFamily: 'Permanent Marker',
154:                   fontSize: 30,
155:                 ),
156:               ),
157:             ),
158:             icon,
159:           ],
160:         ),
161:       ),
162:     );
163:   }
164: }
````

## File: templates/card/lib/settings/settings.dart
````dart
 1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: import 'package:flutter/foundation.dart';
 6: import 'package:logging/logging.dart';
 7: 
 8: import 'persistence/local_storage_settings_persistence.dart';
 9: import 'persistence/settings_persistence.dart';
10: 
11: /// An class that holds settings like [playerName] or [musicOn],
12: /// and saves them to an injected persistence store.
13: class SettingsController {
14:   static final _log = Logger('SettingsController');
15: 
16:   /// The persistence store that is used to save settings.
17:   final SettingsPersistence _store;
18: 
19:   /// Whether or not the audio is on at all. This overrides both music
20:   /// and sounds (sfx).
21:   ///
22:   /// This is an important feature especially on mobile, where players
23:   /// expect to be able to quickly mute all the audio. Having this as
24:   /// a separate flag (as opposed to some kind of {off, sound, everything}
25:   /// enum) means that the player will not lose their [soundsOn] and
26:   /// [musicOn] preferences when they temporarily mute the game.
27:   ValueNotifier<bool> audioOn = ValueNotifier(true);
28: 
29:   /// The player's name. Used for things like high score lists.
30:   ValueNotifier<String> playerName = ValueNotifier('Player');
31: 
32:   /// Whether or not the sound effects (sfx) are on.
33:   ValueNotifier<bool> soundsOn = ValueNotifier(true);
34: 
35:   /// Whether or not the music is on.
36:   ValueNotifier<bool> musicOn = ValueNotifier(true);
37: 
38:   /// Creates a new instance of [SettingsController] backed by [store].
39:   ///
40:   /// By default, settings are persisted using [LocalStorageSettingsPersistence]
41:   /// (i.e. NSUserDefaults on iOS, SharedPreferences on Android or
42:   /// local storage on the web).
43:   SettingsController({SettingsPersistence? store})
44:       : _store = store ?? LocalStorageSettingsPersistence() {
45:     _loadStateFromPersistence();
46:   }
47: 
48:   void setPlayerName(String name) {
49:     playerName.value = name;
50:     _store.savePlayerName(playerName.value);
51:   }
52: 
53:   void toggleAudioOn() {
54:     audioOn.value = !audioOn.value;
55:     _store.saveAudioOn(audioOn.value);
56:   }
57: 
58:   void toggleMusicOn() {
59:     musicOn.value = !musicOn.value;
60:     _store.saveMusicOn(musicOn.value);
61:   }
62: 
63:   void toggleSoundsOn() {
64:     soundsOn.value = !soundsOn.value;
65:     _store.saveSoundsOn(soundsOn.value);
66:   }
67: 
68:   /// Asynchronously loads values from the injected persistence store.
69:   Future<void> _loadStateFromPersistence() async {
70:     final loadedValues = await Future.wait([
71:       _store.getAudioOn(defaultValue: true).then((value) {
72:         if (kIsWeb) {
73:           // On the web, sound can only start after user interaction, so
74:           // we start muted there on every game start.
75:           return audioOn.value = false;
76:         }
77:         // On other platforms, we can use the persisted value.
78:         return audioOn.value = value;
79:       }),
80:       _store
81:           .getSoundsOn(defaultValue: true)
82:           .then((value) => soundsOn.value = value),
83:       _store
84:           .getMusicOn(defaultValue: true)
85:           .then((value) => musicOn.value = value),
86:       _store.getPlayerName().then((value) => playerName.value = value),
87:     ]);
88: 
89:     _log.fine(() => 'Loaded settings: $loadedValues');
90:   }
91: }
````

## File: templates/card/lib/style/confetti.dart
````dart
  1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
  2: // for details. All rights reserved. Use of this source code is governed by a
  3: // BSD-style license that can be found in the LICENSE file.
  4: 
  5: import 'dart:collection';
  6: import 'dart:math';
  7: 
  8: import 'package:flutter/widgets.dart';
  9: 
 10: /// Shows a confetti (celebratory) animation: paper snippings falling down.
 11: ///
 12: /// The widget fills the available space (like [SizedBox.expand] would).
 13: ///
 14: /// When [isStopped] is `true`, the animation will not run. This is useful
 15: /// when the widget is not visible yet, for example. Provide [colors]
 16: /// to make the animation look good in context.
 17: ///
 18: /// This is a partial port of this CodePen by Hemn Chawroka:
 19: /// https://codepen.io/iprodev/pen/azpWBr
 20: class Confetti extends StatefulWidget {
 21:   static const _defaultColors = [
 22:     Color(0xffd10841),
 23:     Color(0xff1d75fb),
 24:     Color(0xff0050bc),
 25:     Color(0xffa2dcc7),
 26:   ];
 27: 
 28:   final bool isStopped;
 29: 
 30:   final List<Color> colors;
 31: 
 32:   const Confetti({
 33:     this.colors = _defaultColors,
 34:     this.isStopped = false,
 35:     super.key,
 36:   });
 37: 
 38:   @override
 39:   State<Confetti> createState() => _ConfettiState();
 40: }
 41: 
 42: class ConfettiPainter extends CustomPainter {
 43:   final defaultPaint = Paint();
 44: 
 45:   final int snippingsCount = 200;
 46: 
 47:   late final List<_PaperSnipping> _snippings;
 48: 
 49:   Size? _size;
 50: 
 51:   DateTime _lastTime = DateTime.now();
 52: 
 53:   final UnmodifiableListView<Color> colors;
 54: 
 55:   ConfettiPainter(
 56:       {required Listenable animation, required Iterable<Color> colors})
 57:       : colors = UnmodifiableListView(colors),
 58:         super(repaint: animation);
 59: 
 60:   @override
 61:   void paint(Canvas canvas, Size size) {
 62:     if (_size == null) {
 63:       // First time we have a size.
 64:       _snippings = List.generate(
 65:           snippingsCount,
 66:           (i) => _PaperSnipping(
 67:                 frontColor: colors[i % colors.length],
 68:                 bounds: size,
 69:               ));
 70:     }
 71: 
 72:     final didResize = _size != null && _size != size;
 73:     final now = DateTime.now();
 74:     final dt = now.difference(_lastTime);
 75:     for (final snipping in _snippings) {
 76:       if (didResize) {
 77:         snipping.updateBounds(size);
 78:       }
 79:       snipping.update(dt.inMilliseconds / 1000);
 80:       snipping.draw(canvas);
 81:     }
 82: 
 83:     _size = size;
 84:     _lastTime = now;
 85:   }
 86: 
 87:   @override
 88:   bool shouldRepaint(covariant CustomPainter oldDelegate) {
 89:     return true;
 90:   }
 91: }
 92: 
 93: class _ConfettiState extends State<Confetti>
 94:     with SingleTickerProviderStateMixin {
 95:   late AnimationController _controller;
 96: 
 97:   @override
 98:   Widget build(BuildContext context) {
 99:     return CustomPaint(
100:       painter: ConfettiPainter(
101:         colors: widget.colors,
102:         animation: _controller,
103:       ),
104:       willChange: true,
105:       child: const SizedBox.expand(),
106:     );
107:   }
108: 
109:   @override
110:   void didUpdateWidget(covariant Confetti oldWidget) {
111:     super.didUpdateWidget(oldWidget);
112:     if (oldWidget.isStopped && !widget.isStopped) {
113:       _controller.repeat();
114:     } else if (!oldWidget.isStopped && widget.isStopped) {
115:       _controller.stop(canceled: false);
116:     }
117:   }
118: 
119:   @override
120:   void dispose() {
121:     _controller.dispose();
122:     super.dispose();
123:   }
124: 
125:   @override
126:   void initState() {
127:     super.initState();
128:     _controller = AnimationController(
129:       // We don't really care about the duration, since we're going to
130:       // use the controller on loop anyway.
131:       duration: const Duration(seconds: 1),
132:       vsync: this,
133:     );
134: 
135:     if (!widget.isStopped) {
136:       _controller.repeat();
137:     }
138:   }
139: }
140: 
141: class _PaperSnipping {
142:   static final Random _random = Random();
143: 
144:   static const degToRad = pi / 180;
145: 
146:   static const backSideBlend = Color(0x70EEEEEE);
147: 
148:   Size _bounds;
149: 
150:   late final _Vector position = _Vector(
151:     _random.nextDouble() * _bounds.width,
152:     _random.nextDouble() * _bounds.height,
153:   );
154: 
155:   final double rotationSpeed = 800 + _random.nextDouble() * 600;
156: 
157:   final double angle = _random.nextDouble() * 360 * degToRad;
158: 
159:   double rotation = _random.nextDouble() * 360 * degToRad;
160: 
161:   double cosA = 1.0;
162: 
163:   final double size = 7.0;
164: 
165:   final double oscillationSpeed = 0.5 + _random.nextDouble() * 1.5;
166: 
167:   final double xSpeed = 40;
168: 
169:   final double ySpeed = 50 + _random.nextDouble() * 60;
170: 
171:   late List<_Vector> corners = List.generate(4, (i) {
172:     final angle = this.angle + degToRad * (45 + i * 90);
173:     return _Vector(cos(angle), sin(angle));
174:   });
175: 
176:   double time = _random.nextDouble();
177: 
178:   final Color frontColor;
179: 
180:   late final Color backColor = Color.alphaBlend(backSideBlend, frontColor);
181: 
182:   final paint = Paint()..style = PaintingStyle.fill;
183: 
184:   _PaperSnipping({
185:     required this.frontColor,
186:     required Size bounds,
187:   }) : _bounds = bounds;
188: 
189:   void draw(Canvas canvas) {
190:     if (cosA > 0) {
191:       paint.color = frontColor;
192:     } else {
193:       paint.color = backColor;
194:     }
195: 
196:     final path = Path()
197:       ..addPolygon(
198:         List.generate(
199:             4,
200:             (index) => Offset(
201:                   position.x + corners[index].x * size,
202:                   position.y + corners[index].y * size * cosA,
203:                 )),
204:         true,
205:       );
206:     canvas.drawPath(path, paint);
207:   }
208: 
209:   void update(double dt) {
210:     time += dt;
211:     rotation += rotationSpeed * dt;
212:     cosA = cos(degToRad * rotation);
213:     position.x += cos(time * oscillationSpeed) * xSpeed * dt;
214:     position.y += ySpeed * dt;
215:     if (position.y > _bounds.height) {
216:       // Move the snipping back to the top.
217:       position.x = _random.nextDouble() * _bounds.width;
218:       position.y = 0;
219:     }
220:   }
221: 
222:   void updateBounds(Size newBounds) {
223:     if (!newBounds.contains(Offset(position.x, position.y))) {
224:       position.x = _random.nextDouble() * newBounds.width;
225:       position.y = _random.nextDouble() * newBounds.height;
226:     }
227:     _bounds = newBounds;
228:   }
229: }
230: 
231: class _Vector {
232:   double x, y;
233:   _Vector(this.x, this.y);
234: }
````

## File: templates/card/lib/style/my_button.dart
````dart
 1: // Copyright 2023, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: import 'dart:math';
 6: 
 7: import 'package:flutter/material.dart';
 8: 
 9: class MyButton extends StatefulWidget {
10:   final Widget child;
11: 
12:   final VoidCallback? onPressed;
13: 
14:   const MyButton({super.key, required this.child, this.onPressed});
15: 
16:   @override
17:   State<MyButton> createState() => _MyButtonState();
18: }
19: 
20: class _MyButtonState extends State<MyButton>
21:     with SingleTickerProviderStateMixin {
22:   late final AnimationController _controller = AnimationController(
23:     duration: const Duration(milliseconds: 300),
24:     vsync: this,
25:   );
26: 
27:   @override
28:   void dispose() {
29:     _controller.dispose();
30:     super.dispose();
31:   }
32: 
33:   @override
34:   Widget build(BuildContext context) {
35:     return MouseRegion(
36:       onEnter: (event) {
37:         _controller.repeat();
38:       },
39:       onExit: (event) {
40:         _controller.stop(canceled: false);
41:       },
42:       child: RotationTransition(
43:         turns: _controller.drive(const _MySineTween(0.005)),
44:         child: FilledButton(
45:           onPressed: widget.onPressed,
46:           child: widget.child,
47:         ),
48:       ),
49:     );
50:   }
51: }
52: 
53: class _MySineTween extends Animatable<double> {
54:   final double maxExtent;
55: 
56:   const _MySineTween(this.maxExtent);
57: 
58:   @override
59:   double transform(double t) {
60:     return sin(t * 2 * pi) * maxExtent;
61:   }
62: }
````

## File: templates/card/lib/style/my_transition.dart
````dart
 1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: import 'package:flutter/material.dart';
 6: import 'package:go_router/go_router.dart';
 7: 
 8: CustomTransitionPage<T> buildMyTransition<T>({
 9:   required Widget child,
10:   required Color color,
11:   String? name,
12:   Object? arguments,
13:   String? restorationId,
14:   LocalKey? key,
15: }) {
16:   return CustomTransitionPage<T>(
17:     child: child,
18:     transitionsBuilder: (context, animation, secondaryAnimation, child) {
19:       return _MyReveal(
20:         animation: animation,
21:         color: color,
22:         child: child,
23:       );
24:     },
25:     key: key,
26:     name: name,
27:     arguments: arguments,
28:     restorationId: restorationId,
29:     transitionDuration: const Duration(milliseconds: 700),
30:   );
31: }
32: 
33: class _MyReveal extends StatelessWidget {
34:   final Widget child;
35: 
36:   final Animation<double> animation;
37: 
38:   final Color color;
39: 
40:   final _slideTween = Tween(begin: const Offset(0, -1), end: Offset.zero);
41: 
42:   final _fadeTween = TweenSequence([
43:     TweenSequenceItem(tween: ConstantTween(0.0), weight: 1),
44:     TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0), weight: 1),
45:   ]);
46: 
47:   _MyReveal({
48:     required this.child,
49:     required this.animation,
50:     required this.color,
51:   });
52: 
53:   @override
54:   Widget build(BuildContext context) {
55:     return Stack(
56:       fit: StackFit.expand,
57:       children: [
58:         SlideTransition(
59:           position: _slideTween.animate(
60:             CurvedAnimation(
61:               parent: animation,
62:               curve: Curves.easeOutCubic,
63:               reverseCurve: Curves.easeOutCubic,
64:             ),
65:           ),
66:           child: Container(
67:             color: color,
68:           ),
69:         ),
70:         FadeTransition(
71:           opacity: _fadeTween.animate(animation),
72:           child: child,
73:         ),
74:       ],
75:     );
76:   }
77: }
````

## File: templates/card/lib/style/palette.dart
````dart
 1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: import 'package:flutter/material.dart';
 6: 
 7: /// A palette of colors to be used in the game.
 8: ///
 9: /// The reason we're not going with something like Material Design's
10: /// `Theme` is simply that this is simpler to work with and yet gives
11: /// us everything we need for a game.
12: ///
13: /// Games generally have more radical color palettes than apps. For example,
14: /// every level of a game can have radically different colors.
15: /// At the same time, games rarely support dark mode.
16: ///
17: /// Colors taken from this fun palette:
18: /// https://lospec.com/palette-list/crayola84
19: ///
20: /// Colors here are implemented as getters so that hot reloading works.
21: /// In practice, we could just as easily implement the colors
22: /// as `static const`. But this way the palette is more malleable:
23: /// we could allow players to customize colors, for example,
24: /// or even get the colors from the network.
25: class Palette {
26:   Color get pen => const Color(0xff1d75fb);
27:   Color get darkPen => const Color(0xFF0050bc);
28:   Color get redPen => const Color(0xFFd10841);
29:   Color get inkFullOpacity => const Color(0xff352b42);
30:   Color get ink => const Color(0xee352b42);
31:   Color get accept => const Color(0xff15a44d);
32:   Color get backgroundMain => const Color(0xff538ea6);
33:   Color get backgroundLevelSelection => const Color(0xffa2dcc7);
34:   Color get backgroundPlaySession => const Color(0xffffebb5);
35:   Color get background4 => const Color(0xffffffd1);
36:   Color get backgroundSettings => const Color(0xffbfc8e3);
37:   Color get trueWhite => const Color(0xffffffff);
38: }
````

## File: templates/card/lib/style/responsive_screen.dart
````dart
  1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
  2: // for details. All rights reserved. Use of this source code is governed by a
  3: // BSD-style license that can be found in the LICENSE file.
  4: 
  5: import 'package:flutter/material.dart';
  6: 
  7: /// A widget that makes it easy to create a screen with a square-ish
  8: /// main area, a smaller menu area, and a small area for a message on top.
  9: /// It works in both orientations on mobile- and tablet-sized screens.
 10: class ResponsiveScreen extends StatelessWidget {
 11:   /// This is the "hero" of the screen. It's more or less square, and will
 12:   /// be placed in the visual "center" of the screen.
 13:   final Widget squarishMainArea;
 14: 
 15:   /// The second-largest area after [squarishMainArea]. It can be narrow
 16:   /// or wide.
 17:   final Widget rectangularMenuArea;
 18: 
 19:   /// An area reserved for some static text close to the top of the screen.
 20:   final Widget topMessageArea;
 21: 
 22:   const ResponsiveScreen({
 23:     required this.squarishMainArea,
 24:     required this.rectangularMenuArea,
 25:     this.topMessageArea = const SizedBox.shrink(),
 26:     super.key,
 27:   });
 28: 
 29:   @override
 30:   Widget build(BuildContext context) {
 31:     return LayoutBuilder(
 32:       builder: (context, constraints) {
 33:         // This widget wants to fill the whole screen.
 34:         final size = constraints.biggest;
 35:         final padding = EdgeInsets.all(size.shortestSide / 30);
 36: 
 37:         if (size.height >= size.width) {
 38:           // "Portrait" / "mobile" mode.
 39:           return Column(
 40:             crossAxisAlignment: CrossAxisAlignment.stretch,
 41:             children: [
 42:               SafeArea(
 43:                 bottom: false,
 44:                 child: Padding(
 45:                   padding: padding,
 46:                   child: topMessageArea,
 47:                 ),
 48:               ),
 49:               Expanded(
 50:                 child: SafeArea(
 51:                   top: false,
 52:                   bottom: false,
 53:                   minimum: padding,
 54:                   child: squarishMainArea,
 55:                 ),
 56:               ),
 57:               SafeArea(
 58:                 top: false,
 59:                 maintainBottomViewPadding: true,
 60:                 child: Padding(
 61:                   padding: padding,
 62:                   child: Center(
 63:                     child: rectangularMenuArea,
 64:                   ),
 65:                 ),
 66:               ),
 67:             ],
 68:           );
 69:         } else {
 70:           // "Landscape" / "tablet" mode.
 71:           final isLarge = size.width > 900;
 72: 
 73:           return Row(
 74:             crossAxisAlignment: CrossAxisAlignment.stretch,
 75:             children: [
 76:               Expanded(
 77:                 flex: isLarge ? 7 : 5,
 78:                 child: SafeArea(
 79:                   right: false,
 80:                   maintainBottomViewPadding: true,
 81:                   minimum: padding,
 82:                   child: squarishMainArea,
 83:                 ),
 84:               ),
 85:               Expanded(
 86:                 flex: 3,
 87:                 child: Column(
 88:                   children: [
 89:                     SafeArea(
 90:                       bottom: false,
 91:                       left: false,
 92:                       maintainBottomViewPadding: true,
 93:                       child: Padding(
 94:                         padding: padding,
 95:                         child: topMessageArea,
 96:                       ),
 97:                     ),
 98:                     Expanded(
 99:                       child: SafeArea(
100:                         top: false,
101:                         left: false,
102:                         maintainBottomViewPadding: true,
103:                         child: Align(
104:                           alignment: Alignment.bottomCenter,
105:                           child: Padding(
106:                             padding: padding,
107:                             child: rectangularMenuArea,
108:                           ),
109:                         ),
110:                       ),
111:                     )
112:                   ],
113:                 ),
114:               ),
115:             ],
116:           );
117:         }
118:       },
119:     );
120:   }
121: }
````

## File: templates/card/lib/win_game/win_game_screen.dart
````dart
 1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: import 'package:flutter/material.dart';
 6: import 'package:go_router/go_router.dart';
 7: import 'package:provider/provider.dart';
 8: 
 9: import '../game_internals/score.dart';
10: import '../style/my_button.dart';
11: import '../style/palette.dart';
12: import '../style/responsive_screen.dart';
13: 
14: class WinGameScreen extends StatelessWidget {
15:   final Score score;
16: 
17:   const WinGameScreen({
18:     super.key,
19:     required this.score,
20:   });
21: 
22:   @override
23:   Widget build(BuildContext context) {
24:     final palette = context.watch<Palette>();
25: 
26:     const gap = SizedBox(height: 10);
27: 
28:     return Scaffold(
29:       backgroundColor: palette.backgroundPlaySession,
30:       body: ResponsiveScreen(
31:         squarishMainArea: Column(
32:           mainAxisAlignment: MainAxisAlignment.center,
33:           children: <Widget>[
34:             gap,
35:             const Center(
36:               child: Text(
37:                 'You won!',
38:                 style: TextStyle(fontFamily: 'Permanent Marker', fontSize: 50),
39:               ),
40:             ),
41:             gap,
42:             Center(
43:               child: Text(
44:                 'Score: ${score.score}\n'
45:                 'Time: ${score.formattedTime}',
46:                 style: const TextStyle(
47:                     fontFamily: 'Permanent Marker', fontSize: 20),
48:               ),
49:             ),
50:           ],
51:         ),
52:         rectangularMenuArea: MyButton(
53:           onPressed: () {
54:             GoRouter.of(context).go('/');
55:           },
56:           child: const Text('Continue'),
57:         ),
58:       ),
59:     );
60:   }
61: }
````

## File: templates/card/lib/main.dart
````dart
  1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
  2: // for details. All rights reserved. Use of this source code is governed by a
  3: // BSD-style license that can be found in the LICENSE file.
  4: 
  5: import 'dart:developer' as dev;
  6: 
  7: import 'package:flutter/foundation.dart';
  8: import 'package:flutter/material.dart';
  9: import 'package:flutter/services.dart';
 10: import 'package:logging/logging.dart';
 11: import 'package:provider/provider.dart';
 12: 
 13: import 'app_lifecycle/app_lifecycle.dart';
 14: import 'audio/audio_controller.dart';
 15: import 'player_progress/player_progress.dart';
 16: import 'router.dart';
 17: import 'settings/settings.dart';
 18: import 'style/palette.dart';
 19: 
 20: void main() async {
 21:   // Basic logging setup.
 22:   Logger.root.level = kDebugMode ? Level.FINE : Level.INFO;
 23:   Logger.root.onRecord.listen((record) {
 24:     dev.log(
 25:       record.message,
 26:       time: record.time,
 27:       level: record.level.value,
 28:       name: record.loggerName,
 29:     );
 30:   });
 31: 
 32:   WidgetsFlutterBinding.ensureInitialized();
 33:   // Put game into full screen mode on mobile devices.
 34:   await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
 35:   // Lock the game to portrait mode on mobile devices.
 36:   await SystemChrome.setPreferredOrientations([
 37:     DeviceOrientation.portraitUp,
 38:     DeviceOrientation.portraitDown,
 39:   ]);
 40: 
 41:   runApp(const MyApp());
 42: }
 43: 
 44: class MyApp extends StatelessWidget {
 45:   const MyApp({super.key});
 46: 
 47:   @override
 48:   Widget build(BuildContext context) {
 49:     return AppLifecycleObserver(
 50:       child: MultiProvider(
 51:         // This is where you add objects that you want to have available
 52:         // throughout your game.
 53:         //
 54:         // Every widget in the game can access these objects by calling
 55:         // `context.watch()` or `context.read()`.
 56:         // See `lib/main_menu/main_menu_screen.dart` for example usage.
 57:         providers: [
 58:           Provider(create: (context) => SettingsController()),
 59:           Provider(create: (context) => Palette()),
 60:           ChangeNotifierProvider(create: (context) => PlayerProgress()),
 61:           // Set up audio.
 62:           ProxyProvider2<AppLifecycleStateNotifier, SettingsController,
 63:               AudioController>(
 64:             create: (context) => AudioController(),
 65:             update: (context, lifecycleNotifier, settings, audio) {
 66:               audio!.attachDependencies(lifecycleNotifier, settings);
 67:               return audio;
 68:             },
 69:             dispose: (context, audio) => audio.dispose(),
 70:             // Ensures that music starts immediately.
 71:             lazy: false,
 72:           ),
 73:         ],
 74:         child: Builder(builder: (context) {
 75:           final palette = context.watch<Palette>();
 76: 
 77:           return MaterialApp.router(
 78:             title: 'My Flutter Game',
 79:             theme: ThemeData.from(
 80:               colorScheme: ColorScheme.fromSeed(
 81:                 seedColor: palette.darkPen,
 82:                 surface: palette.backgroundMain,
 83:               ),
 84:               textTheme: TextTheme(
 85:                 bodyMedium: TextStyle(color: palette.ink),
 86:               ),
 87:               useMaterial3: true,
 88:             ).copyWith(
 89:               // Make buttons more fun.
 90:               filledButtonTheme: FilledButtonThemeData(
 91:                 style: FilledButton.styleFrom(
 92:                   textStyle: const TextStyle(
 93:                     fontWeight: FontWeight.bold,
 94:                     fontSize: 20,
 95:                   ),
 96:                 ),
 97:               ),
 98:             ),
 99:             routerConfig: router,
100:           );
101:         }),
102:       ),
103:     );
104:   }
105: }
````

## File: templates/card/lib/router.dart
````dart
 1: // Copyright 2023, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: import 'package:card/play_session/battlefield.dart';
 6: import 'package:card/play_session/simple_battlefield.dart';
 7: import 'package:card/play_session/wave_screen.dart';
 8: import 'package:flutter/foundation.dart';
 9: import 'package:go_router/go_router.dart';
10: import 'package:provider/provider.dart';
11: 
12: import 'game_internals/score.dart';
13: import 'main_menu/main_menu_screen.dart';
14: import 'play_session/play_session_screen.dart';
15: import 'settings/settings_screen.dart';
16: import 'style/my_transition.dart';
17: import 'style/palette.dart';
18: import 'win_game/win_game_screen.dart';
19: 
20: /// The router describes the game's navigational hierarchy, from the main
21: /// screen through settings screens all the way to each individual level.
22: final router = GoRouter(
23:   routes: [
24:     GoRoute(
25:       path: '/',
26:       builder: (context, state) => const MainMenuScreen(key: Key('main menu')),
27:       routes: [
28:         GoRoute(
29:           path: 'tabbedwaves',
30:           builder: (context, state) =>
31:               const TabsContainerScreen(key: Key('waveslider')),
32:         ),
33:         GoRoute(
34:           path: 'simplebattlefield',
35:           builder: (context, state) =>
36:               const SimpleBattlefieldScreen(key: Key('simplebattlefield')),
37:         ),
38:         GoRoute(
39:           path: 'battlefield',
40:           builder: (context, state) =>
41:               const BattlefieldScreen(key: Key('battlefield')),
42:         ),
43:         GoRoute(
44:           path: 'play',
45:           pageBuilder: (context, state) => buildMyTransition<void>(
46:             key: const ValueKey('play'),
47:             color: context.watch<Palette>().backgroundPlaySession,
48:             child: const PlaySessionScreen(
49:               key: Key('level selection'),
50:             ),
51:           ),
52:           routes: [
53:             GoRoute(
54:               path: 'won',
55:               redirect: (context, state) {
56:                 if (state.extra == null) {
57:                   // Trying to navigate to a win screen without any data.
58:                   // Possibly by using the browser's back button.
59:                   return '/';
60:                 }
61: 
62:                 // Otherwise, do not redirect.
63:                 return null;
64:               },
65:               pageBuilder: (context, state) {
66:                 final map = state.extra! as Map<String, dynamic>;
67:                 final score = map['score'] as Score;
68: 
69:                 return buildMyTransition<void>(
70:                   key: const ValueKey('won'),
71:                   color: context.watch<Palette>().backgroundPlaySession,
72:                   child: WinGameScreen(
73:                     score: score,
74:                     key: const Key('win game'),
75:                   ),
76:                 );
77:               },
78:             )
79:           ],
80:         ),
81:         GoRoute(
82:           path: 'settings',
83:           builder: (context, state) =>
84:               const SettingsScreen(key: Key('settings')),
85:         ),
86:       ],
87:     ),
88:   ],
89: );
````

## File: templates/card/test/smoke_test.dart
````dart
 1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: import 'package:card/main.dart';
 6: import 'package:card/play_session/playing_card_widget.dart';
 7: import 'package:flutter_test/flutter_test.dart';
 8: 
 9: void main() {
10:   testWidgets('smoke test', (tester) async {
11:     // Build our game and trigger a frame.
12:     await tester.pumpWidget(MyApp());
13: 
14:     // Verify that the 'Play' button is shown.
15:     expect(find.text('Play'), findsOneWidget);
16: 
17:     // Verify that the 'Settings' button is shown.
18:     expect(find.text('Settings'), findsOneWidget);
19: 
20:     // Go to 'Settings'.
21:     await tester.tap(find.text('Settings'));
22:     await tester.pumpAndSettle();
23:     expect(find.text('Music'), findsOneWidget);
24: 
25:     // Go back to main menu.
26:     await tester.tap(find.text('Back'));
27:     await tester.pumpAndSettle();
28: 
29:     // Tap 'Play'.
30:     await tester.tap(find.text('Play'));
31:     await tester.pumpAndSettle();
32:     expect(find.byType(PlayingCardWidget), findsWidgets);
33: 
34:     // Tap 'Back'.
35:     await tester.tap(find.text('Back'));
36:     await tester.pumpAndSettle();
37: 
38:     // Verify we're back on the homepage.
39:     expect(find.text('Play'), findsOneWidget);
40:   });
41: }
````

## File: templates/card/analysis_options.yaml
````yaml
 1: include: package:flutter_lints/flutter.yaml
 2: 
 3: analyzer:
 4:   language:
 5:     strict-casts: true
 6: 
 7: linter:
 8:   rules:
 9:     # Remove or force lint rules by adding lines like the following.
10:     # The lints below are disabled in order to make things smoother in early
11:     # development. Consider enabling them once development is further along.
12:     prefer_const_constructors: false  # Annoying in early development
13:     directives_ordering: true
````

## File: templates/card/pubspec.yaml
````yaml
 1: name: card
 2: description: A game built in Flutter.
 3: 
 4: # Prevent accidental publishing to pub.dev.
 5: publish_to: 'none'
 6: 
 7: version: 0.0.1+1
 8: 
 9: environment:
10:   sdk: ^3.5.0
11: 
12: dependencies:
13:   flutter:
14:     sdk: flutter
15: 
16:   async: ^2.11.0
17:   audioplayers: ^6.0.0
18:   go_router: ^14.0.0
19:   logging: ^1.2.0
20:   provider: ^6.1.2
21:   shared_preferences: ^2.2.3
22: 
23: dev_dependencies:
24:   flutter_lints: ^5.0.0
25:   flutter_test:
26:     sdk: flutter
27:   flutter_launcher_icons: ^0.13.1
28:   test: ^1.24.3
29: 
30: flutter:
31:   uses-material-design: true
32: 
33:   assets:
34:     - assets/images/
35:     - assets/music/
36:     - assets/sfx/
37: 
38:   fonts:
39:     - family: Permanent Marker
40:       fonts:
41:         - asset: assets/fonts/Permanent_Marker/PermanentMarker-Regular.ttf
42: 
43: flutter_launcher_icons:
44:   android: true
45:   ios: true
46:   image_path: "assets/icons/icon.png"
47:   adaptive_icon_background: "#FFFFFF"
48:   adaptive_icon_foreground: "assets/icons/icon-adaptive-foreground.png"
````

## File: templates/card/README.md
````markdown
  1: A starter Flutter project with a minimal shell of a board game
  2: including the following features:
  3: 
  4: - main menu screen
  5: - basic navigation
  6: - game-y theming
  7: - settings
  8: - sound
  9: - drag and drop
 10: - minimal game state management
 11: 
 12: You can jump directly into building your game in `lib/play_session/`.
 13: 
 14: When you're ready for things like ads, in-app purchases, achievements,
 15: analytics, crash reporting, and so on, 
 16: there are resources ready for you
 17: at [flutter.dev/games](https://flutter.dev/games).
 18: 
 19: 
 20: ## How to get this sample
 21: 
 22: You can clone this whole repository and find this sample in your local copy.
 23: 
 24: For convenience, though, we also provide a command line tool that downloads
 25: just the project you want.
 26: 
 27: On the command line, while having the
 28: [Flutter SDK installed](https://docs.flutter.dev/get-started/install),
 29: run the following command:
 30: 
 31: ```shell
 32: dart pub global activate sample_downloader
 33: ```
 34: 
 35: Then, from any directory, run the newly installed tool
 36: and follow its instructions.
 37: 
 38: ```shell
 39: sample_downloader
 40: ```
 41: 
 42: 
 43: # Development
 44: 
 45: To run the app in debug mode:
 46: 
 47:     flutter run
 48: 
 49: It is often convenient to develop your game as a desktop app.
 50: For example, you can run `flutter run -d macOS`, and get the same UI
 51: in a desktop window on a Mac. That way, you don't need to use a
 52: simulator/emulator or attach a mobile device.
 53: 
 54: 
 55: ## Code organization
 56: 
 57: Code is organized in a loose and shallow feature-first fashion.
 58: In `lib/`, you'll therefore find directories such as `audio`,
 59: `main_menu` or `settings`. Nothing fancy, but usable.
 60: 
 61: ```text
 62: lib
 63: ├── app_lifecycle
 64: ├── audio
 65: ├── game_internals
 66: ├── main_menu
 67: ├── play_session
 68: ├── player_progress
 69: ├── settings
 70: ├── style
 71: ├── win_game
 72: │
 73: ├── main.dart
 74: └── router.dart
 75: ```
 76: 
 77: The state management approach is intentionally low-level. That way, it's easy to
 78: take this project and run with it, without having to learn new paradigms, or having
 79: to remember to run `flutter pub run build_runner watch`. You are,
 80: of course, encouraged to use whatever paradigm, helper package or code generation
 81: scheme that you prefer.
 82: 
 83: 
 84: ## Building for production
 85: 
 86: To build the app for iOS (and open Xcode when finished):
 87: 
 88: ```shell
 89: flutter build ipa && open build/ios/archive/Runner.xcarchive
 90: ```
 91: 
 92: To build the app for Android (and open the folder with the bundle when finished):
 93: 
 94: ```shell
 95: flutter build appbundle && open build/app/outputs/bundle/release
 96: ```
 97: 
 98: While the template is primarily meant for mobile games, you can also publish
 99: for the web. This might be useful for web-based demos, for example,
100: or for rapid play-testing. The following command requires installing
101: [`peanut`](https://pub.dev/packages/peanut/install).
102: 
103: ```bash
104: flutter pub global run peanut \
105: --web-renderer canvaskit \
106: --extra-args "--base-href=/name_of_your_github_repo/" \
107: && git push origin --set-upstream gh-pages
108: ```
109: 
110: The last line of the command above automatically pushes
111: your newly built web game to GitHub pages, assuming that you have
112: that set up.
113: 
114: Lastly, it is of course possible to build your game for desktop platforms:
115: Windows, Linux and macOS. 
116: Follow the [standard instructions](https://docs.flutter.dev/platform-integration/desktop).
117: 
118: 
119: # Integrations
120: 
121: Focus on making your core gameplay fun first. Don't worry about
122: integrations like ads, in-app purchases, analytics, and so on.
123: It's easy to add them later, and you can find recipes and codelabs
124: for them at [flutter.dev/games](https://flutter.dev/games).
125: 
126: Change the package name of your game
127: before you start any of the deeper integrations.
128: [StackOverflow has instructions](https://stackoverflow.com/a/51550358/1416886)
129: for this, and the [`rename`](https://pub.dev/packages/rename) tool
130: (on pub.dev) automates the process.
131: 
132: 
133: ## Audio
134: 
135: Audio is enabled by default and ready to go. You can modify code
136: in `lib/audio/` to your liking.
137: 
138: You can find some music
139: tracks in `assets/music` — these are Creative Commons Attribution (CC-BY)
140: licensed, and are included in this repository with permission. If you decide
141: to keep these tracks in your game, please don't forget to give credit
142: to the musician, [Mr Smith][].
143: 
144: [Mr Smith]: https://freemusicarchive.org/music/mr-smith
145: 
146: The repository also includes a few sound effect samples in `assets/sfx`.
147: These are public domain (CC0) and you will almost surely want to replace
148: them because they're just recordings of a developer doing silly sounds
149: with their mouth.
150: 
151: ## Logging
152: 
153: The template uses the [`logging`](https://pub.dev/packages/logging) package
154: to log messages to the console. This makes it very easy to log messages
155: from anywhere with something like the following:
156: 
157: ```dart
158: import 'package:logging/logging.dart';
159: 
160: final _log = Logger('Foo');
161: 
162: void foo() {
163:   _log.info('Hello, world!');
164: }
165: ```
166: 
167: This will show up in the console as:
168: 
169: ```text
170: [Foo] Hello, world!
171: ```
172: 
173: When using Flutter DevTools, all the metadata of the log message is preserved, 
174: so you can filter by logger name, log level, and so on.
175: 
176: Later, when you're closer to production, you can gather these log messages
177: (see `lib/main.dart`) and send them to a service like Firebase Crashlytics
178: when appropriate.
179: See [`firebase_crashlytics`](https://pub.dev/packages/firebase_crashlytics)
180: for more information.
181: 
182: 
183: ## Settings
184: 
185: The settings page is enabled by default, and accessible both
186: from the main menu and through the "gear" button in the play session screen.
187: 
188: Settings are saved to local storage using the 
189: [`shared_preferences`](https://pub.dev/packages/shared_preferences)
190: package.
191: To change what preferences are saved and how, edit files in
192: `lib/src/settings/persistence`.
193: 
194: 
195: # Icon
196: 
197: To update the launcher icon, first change the files
198: `assets/icon-adaptive-foreground.png` and `assets/icon.png`.
199: Then, run the following:
200: 
201: ```bash
202: flutter pub run flutter_launcher_icons:main
203: ```
204: 
205: You can [configure](https://github.com/fluttercommunity/flutter_launcher_icons#book-guide)
206: the look of the icon in the `flutter_icons:` section of `pubspec.yaml`.
207: 
208: 
209: # Troubleshooting
210: 
211: ## CocoaPods
212: 
213: When upgrading to higher versions of Flutter or plugins, you might encounter an error when
214: building the iOS or macOS app. A good first thing to try is to delete the `ios/Podfile.lock`
215: file (or `macos/Podfile.lock`, respectively), then trying to build again. (You can achieve
216: a more thorough cleanup by running `flutter clean` instead.)
217: 
218: If this doesn't help, here are some more methods:
219: 
220: - See if everything is still okay with your Flutter and CocoaPods installation
221:   by running `flutter doctor`. Revisit the macOS 
222:   [Flutter installation guide](https://docs.flutter.dev/get-started/install/macos)
223:   if needed.
224: - Update CocoaPods specs directory:
225: 
226:   ```sh
227:   cd ios
228:   pod repo update
229:   cd ..
230:   ```
231: 
232:   (Substitute `ios` for `macos` when appropriate.)
233: - Open the project in Xcode, 
234:   [increase the build target](https://stackoverflow.com/a/38602597/1416886),
235:   then select _Product_ > _Clean Build Folder_.
236: 
237: ## Warnings in console
238: 
239: When running the game for the first time, you might see warnings like the following:
240: 
241: > Note: Some input files use or override a deprecated API.
242: 
243: or
244: 
245: > warning: 'viewState' was deprecated in macOS 11.0: Use -initWithState: instead
246: 
247: These warning come from the various plugins that are used by the template. They are not harmful 
248: and can be ignored. The warnings are meant for the plugin authors, not for you, the game developer.
````

## File: templates/endless_runner/assets/images/README.md
````markdown
1: All art in the images directory is made by Erick Zanardo (https://cherrybit.studio/) and are
2: released under CC0 (Public Domain).
````

## File: templates/endless_runner/assets/sfx/README.md
````markdown
1: Sounds in this folder are made by Lukas Klingsbo and are CC0 (Public Domain).
````

## File: templates/endless_runner/ios/Runner/Assets.xcassets/LaunchImage.imageset/README.md
````markdown
1: # Launch Screen Assets
2: 
3: You can customize the launch screen with your own desired assets by replacing the image files in this directory.
4: 
5: You can also do it by opening your Flutter project's Xcode project with `open ios/Runner.xcworkspace`, selecting `Runner/Assets.xcassets` in the Project Navigator and dropping in the desired images.
````

## File: templates/endless_runner/lib/app_lifecycle/app_lifecycle.dart
````dart
 1: import 'package:flutter/widgets.dart';
 2: import 'package:provider/provider.dart';
 3: 
 4: typedef AppLifecycleStateNotifier = ValueNotifier<AppLifecycleState>;
 5: 
 6: class AppLifecycleObserver extends StatefulWidget {
 7:   final Widget child;
 8: 
 9:   const AppLifecycleObserver({required this.child, super.key});
10: 
11:   @override
12:   State<AppLifecycleObserver> createState() => _AppLifecycleObserverState();
13: }
14: 
15: class _AppLifecycleObserverState extends State<AppLifecycleObserver> {
16:   late final AppLifecycleListener _appLifecycleListener;
17: 
18:   final ValueNotifier<AppLifecycleState> lifecycleListenable =
19:       ValueNotifier(AppLifecycleState.inactive);
20: 
21:   @override
22:   Widget build(BuildContext context) {
23:     // Using InheritedProvider because we don't want to use Consumer
24:     // or context.watch or anything like that to listen to this. We want
25:     // to manually add listeners. We're interested in the _events_ of lifecycle
26:     // state changes, and not so much in the state itself. (For example,
27:     // we want to stop sound when the app goes into the background, and
28:     // restart sound again when the app goes back into focus. We're not
29:     // rebuilding any widgets.)
30:     //
31:     // Provider, by default, throws when one
32:     // is trying to provide a Listenable (such as ValueNotifier) without using
33:     // something like ValueListenableProvider. InheritedProvider is more
34:     // low-level and doesn't have this problem.
35:     return InheritedProvider<AppLifecycleStateNotifier>.value(
36:       value: lifecycleListenable,
37:       child: widget.child,
38:     );
39:   }
40: 
41:   @override
42:   void dispose() {
43:     _appLifecycleListener.dispose();
44:     super.dispose();
45:   }
46: 
47:   @override
48:   void initState() {
49:     super.initState();
50:     _appLifecycleListener = AppLifecycleListener(
51:       onStateChange: (s) => lifecycleListenable.value = s,
52:     );
53:   }
54: }
````

## File: templates/endless_runner/lib/audio/audio_controller.dart
````dart
  1: import 'dart:async';
  2: import 'dart:collection';
  3: import 'dart:math';
  4: 
  5: import 'package:audioplayers/audioplayers.dart';
  6: import 'package:flutter/foundation.dart';
  7: import 'package:flutter/widgets.dart';
  8: import 'package:logging/logging.dart';
  9: 
 10: import '../app_lifecycle/app_lifecycle.dart';
 11: import '../settings/settings.dart';
 12: import 'songs.dart';
 13: import 'sounds.dart';
 14: 
 15: /// Allows playing music and sound. A facade to `package:audioplayers`.
 16: class AudioController {
 17:   static final _log = Logger('AudioController');
 18: 
 19:   final AudioPlayer _musicPlayer;
 20: 
 21:   /// This is a list of [AudioPlayer] instances which are rotated to play
 22:   /// sound effects.
 23:   final List<AudioPlayer> _sfxPlayers;
 24: 
 25:   int _currentSfxPlayer = 0;
 26: 
 27:   final Queue<Song> _playlist;
 28: 
 29:   final Random _random = Random();
 30: 
 31:   SettingsController? _settings;
 32: 
 33:   ValueNotifier<AppLifecycleState>? _lifecycleNotifier;
 34: 
 35:   /// Creates an instance that plays music and sound.
 36:   ///
 37:   /// Use [polyphony] to configure the number of sound effects (SFX) that can
 38:   /// play at the same time. A [polyphony] of `1` will always only play one
 39:   /// sound (a new sound will stop the previous one). See discussion
 40:   /// of [_sfxPlayers] to learn why this is the case.
 41:   ///
 42:   /// Background music does not count into the [polyphony] limit. Music will
 43:   /// never be overridden by sound effects because that would be silly.
 44:   AudioController({int polyphony = 2})
 45:       : assert(polyphony >= 1),
 46:         _musicPlayer = AudioPlayer(playerId: 'musicPlayer'),
 47:         _sfxPlayers = Iterable.generate(
 48:                 polyphony, (i) => AudioPlayer(playerId: 'sfxPlayer#$i'))
 49:             .toList(growable: false),
 50:         _playlist = Queue.of(List<Song>.of(songs)..shuffle()) {
 51:     _musicPlayer.onPlayerComplete.listen(_handleSongFinished);
 52:     unawaited(_preloadSfx());
 53:   }
 54: 
 55:   /// Makes sure the audio controller is listening to changes
 56:   /// of both the app lifecycle (e.g. suspended app) and to changes
 57:   /// of settings (e.g. muted sound).
 58:   void attachDependencies(AppLifecycleStateNotifier lifecycleNotifier,
 59:       SettingsController settingsController) {
 60:     _attachLifecycleNotifier(lifecycleNotifier);
 61:     _attachSettings(settingsController);
 62:   }
 63: 
 64:   void dispose() {
 65:     _lifecycleNotifier?.removeListener(_handleAppLifecycle);
 66:     _stopAllSound();
 67:     _musicPlayer.dispose();
 68:     for (final player in _sfxPlayers) {
 69:       player.dispose();
 70:     }
 71:   }
 72: 
 73:   /// Plays a single sound effect, defined by [type].
 74:   ///
 75:   /// The controller will ignore this call when the attached settings'
 76:   /// [SettingsController.audioOn] is `true` or if its
 77:   /// [SettingsController.soundsOn] is `false`.
 78:   void playSfx(SfxType type) {
 79:     final audioOn = _settings?.audioOn.value ?? false;
 80:     if (!audioOn) {
 81:       _log.fine(() => 'Ignoring playing sound ($type) because audio is muted.');
 82:       return;
 83:     }
 84:     final soundsOn = _settings?.soundsOn.value ?? false;
 85:     if (!soundsOn) {
 86:       _log.fine(() =>
 87:           'Ignoring playing sound ($type) because sounds are turned off.');
 88:       return;
 89:     }
 90: 
 91:     _log.fine(() => 'Playing sound: $type');
 92:     final options = soundTypeToFilename(type);
 93:     final filename = options[_random.nextInt(options.length)];
 94:     _log.fine(() => '- Chosen filename: $filename');
 95: 
 96:     final currentPlayer = _sfxPlayers[_currentSfxPlayer];
 97:     currentPlayer.play(AssetSource('sfx/$filename'),
 98:         volume: soundTypeToVolume(type));
 99:     _currentSfxPlayer = (_currentSfxPlayer + 1) % _sfxPlayers.length;
100:   }
101: 
102:   /// Enables the [AudioController] to listen to [AppLifecycleState] events,
103:   /// and therefore do things like stopping playback when the game
104:   /// goes into the background.
105:   void _attachLifecycleNotifier(AppLifecycleStateNotifier lifecycleNotifier) {
106:     _lifecycleNotifier?.removeListener(_handleAppLifecycle);
107: 
108:     lifecycleNotifier.addListener(_handleAppLifecycle);
109:     _lifecycleNotifier = lifecycleNotifier;
110:   }
111: 
112:   /// Enables the [AudioController] to track changes to settings.
113:   /// Namely, when any of [SettingsController.audioOn],
114:   /// [SettingsController.musicOn] or [SettingsController.soundsOn] changes,
115:   /// the audio controller will act accordingly.
116:   void _attachSettings(SettingsController settingsController) {
117:     if (_settings == settingsController) {
118:       // Already attached to this instance. Nothing to do.
119:       return;
120:     }
121: 
122:     // Remove handlers from the old settings controller if present
123:     final oldSettings = _settings;
124:     if (oldSettings != null) {
125:       oldSettings.audioOn.removeListener(_audioOnHandler);
126:       oldSettings.musicOn.removeListener(_musicOnHandler);
127:       oldSettings.soundsOn.removeListener(_soundsOnHandler);
128:     }
129: 
130:     _settings = settingsController;
131: 
132:     // Add handlers to the new settings controller
133:     settingsController.audioOn.addListener(_audioOnHandler);
134:     settingsController.musicOn.addListener(_musicOnHandler);
135:     settingsController.soundsOn.addListener(_soundsOnHandler);
136: 
137:     if (settingsController.audioOn.value && settingsController.musicOn.value) {
138:       if (kIsWeb) {
139:         _log.info('On the web, music can only start after user interaction.');
140:       } else {
141:         _playCurrentSongInPlaylist();
142:       }
143:     }
144:   }
145: 
146:   void _audioOnHandler() {
147:     _log.fine('audioOn changed to ${_settings!.audioOn.value}');
148:     if (_settings!.audioOn.value) {
149:       // All sound just got un-muted. Audio is on.
150:       if (_settings!.musicOn.value) {
151:         _startOrResumeMusic();
152:       }
153:     } else {
154:       // All sound just got muted. Audio is off.
155:       _stopAllSound();
156:     }
157:   }
158: 
159:   void _handleAppLifecycle() {
160:     switch (_lifecycleNotifier!.value) {
161:       case AppLifecycleState.paused:
162:       case AppLifecycleState.detached:
163:       case AppLifecycleState.hidden:
164:         _stopAllSound();
165:       case AppLifecycleState.resumed:
166:         if (_settings!.audioOn.value && _settings!.musicOn.value) {
167:           _startOrResumeMusic();
168:         }
169:       case AppLifecycleState.inactive:
170:         // No need to react to this state change.
171:         break;
172:     }
173:   }
174: 
175:   void _handleSongFinished(void _) {
176:     _log.info('Last song finished playing.');
177:     // Move the song that just finished playing to the end of the playlist.
178:     _playlist.addLast(_playlist.removeFirst());
179:     // Play the song at the beginning of the playlist.
180:     _playCurrentSongInPlaylist();
181:   }
182: 
183:   void _musicOnHandler() {
184:     if (_settings!.musicOn.value) {
185:       // Music got turned on.
186:       if (_settings!.audioOn.value) {
187:         _startOrResumeMusic();
188:       }
189:     } else {
190:       // Music got turned off.
191:       _musicPlayer.pause();
192:     }
193:   }
194: 
195:   Future<void> _playCurrentSongInPlaylist() async {
196:     _log.info(() => 'Playing ${_playlist.first} now.');
197:     try {
198:       await _musicPlayer.play(AssetSource('music/${_playlist.first.filename}'));
199:     } catch (e) {
200:       _log.severe('Could not play song ${_playlist.first}', e);
201:     }
202:   }
203: 
204:   /// Preloads all sound effects.
205:   Future<void> _preloadSfx() async {
206:     _log.info('Preloading sound effects');
207:     // This assumes there is only a limited number of sound effects in the game.
208:     // If there are hundreds of long sound effect files, it's better
209:     // to be more selective when preloading.
210:     await AudioCache.instance.loadAll(SfxType.values
211:         .expand(soundTypeToFilename)
212:         .map((path) => 'sfx/$path')
213:         .toList());
214:   }
215: 
216:   void _soundsOnHandler() {
217:     for (final player in _sfxPlayers) {
218:       if (player.state == PlayerState.playing) {
219:         player.stop();
220:       }
221:     }
222:   }
223: 
224:   void _startOrResumeMusic() async {
225:     if (_musicPlayer.source == null) {
226:       _log.info('No music source set. '
227:           'Start playing the current song in playlist.');
228:       await _playCurrentSongInPlaylist();
229:       return;
230:     }
231: 
232:     _log.info('Resuming paused music.');
233:     try {
234:       _musicPlayer.resume();
235:     } catch (e) {
236:       // Sometimes, resuming fails with an "Unexpected" error.
237:       _log.severe('Error resuming music', e);
238:       // Try starting the song from scratch.
239:       _playCurrentSongInPlaylist();
240:     }
241:   }
242: 
243:   void _stopAllSound() {
244:     _log.info('Stopping all sound');
245:     _musicPlayer.pause();
246:     for (final player in _sfxPlayers) {
247:       player.stop();
248:     }
249:   }
250: }
````

## File: templates/endless_runner/lib/audio/songs.dart
````dart
 1: const List<Song> songs = [
 2:   Song('bit_forrest.mp3', 'Bit Forrest', artist: 'bertz'),
 3:   Song('free_run.mp3', 'Free Run', artist: 'TAD'),
 4:   Song('tropical_fantasy.mp3', 'Tropical Fantasy', artist: 'Spring Spring'),
 5: ];
 6: 
 7: class Song {
 8:   final String filename;
 9: 
10:   final String name;
11: 
12:   final String? artist;
13: 
14:   const Song(this.filename, this.name, {this.artist});
15: 
16:   @override
17:   String toString() => 'Song<$filename>';
18: }
````

## File: templates/endless_runner/lib/audio/sounds.dart
````dart
 1: List<String> soundTypeToFilename(SfxType type) => switch (type) {
 2:       SfxType.jump => const [
 3:           'jump1.mp3',
 4:         ],
 5:       SfxType.doubleJump => const [
 6:           'double_jump1.mp3',
 7:         ],
 8:       SfxType.hit => const [
 9:           'hit1.mp3',
10:           'hit2.mp3',
11:         ],
12:       SfxType.damage => const [
13:           'damage1.mp3',
14:           'damage2.mp3',
15:         ],
16:       SfxType.score => const [
17:           'score1.mp3',
18:           'score2.mp3',
19:         ],
20:       SfxType.buttonTap => const [
21:           'click1.mp3',
22:           'click2.mp3',
23:           'click3.mp3',
24:           'click4.mp3',
25:         ]
26:     };
27: 
28: /// Allows control over loudness of different SFX types.
29: double soundTypeToVolume(SfxType type) {
30:   switch (type) {
31:     case SfxType.score:
32:     case SfxType.jump:
33:     case SfxType.doubleJump:
34:     case SfxType.damage:
35:     case SfxType.hit:
36:       return 0.4;
37:     case SfxType.buttonTap:
38:       return 1.0;
39:   }
40: }
41: 
42: enum SfxType {
43:   score,
44:   jump,
45:   doubleJump,
46:   hit,
47:   damage,
48:   buttonTap,
49: }
````

## File: templates/endless_runner/lib/flame_game/components/background.dart
````dart
 1: import 'dart:math';
 2: import 'dart:ui';
 3: 
 4: import 'package:flame/components.dart';
 5: import 'package:flame/parallax.dart';
 6: 
 7: /// The [Background] is a component that is composed of multiple scrolling
 8: /// images which form a parallax, a way to simulate movement and depth in the
 9: /// background.
10: class Background extends ParallaxComponent {
11:   Background({required this.speed});
12: 
13:   final double speed;
14: 
15:   @override
16:   Future<void> onLoad() async {
17:     final layers = [
18:       ParallaxImageData('scenery/background.png'),
19:       ParallaxImageData('scenery/clouds.png'),
20:       ParallaxImageData('scenery/cliffs.png'),
21:       ParallaxImageData('scenery/trees.png'),
22:       ParallaxImageData('scenery/ground.png'),
23:     ];
24: 
25:     // The base velocity sets the speed of the layer the farthest to the back.
26:     // Since the speed in our game is defined as the speed of the layer in the
27:     // front, where the player is, we have to calculate what speed the layer in
28:     // the back should have and then the parallax will take care of setting the
29:     // speeds for the rest of the layers.
30:     final baseVelocity = Vector2(speed / pow(2, layers.length), 0);
31: 
32:     // The multiplier delta is used by the parallax to multiply the speed of
33:     // each layer compared to the last, starting from the back. Since we only
34:     // want our layers to move in the X-axis, we multiply by something larger
35:     // than 1.0 here so that the speed of each layer is higher the closer to the
36:     // screen it is.
37:     final velocityMultiplierDelta = Vector2(2.0, 0.0);
38: 
39:     parallax = await game.loadParallax(
40:       layers,
41:       baseVelocity: baseVelocity,
42:       velocityMultiplierDelta: velocityMultiplierDelta,
43:       filterQuality: FilterQuality.none,
44:     );
45:   }
46: }
````

## File: templates/endless_runner/lib/flame_game/components/obstacle.dart
````dart
 1: import 'dart:math';
 2: 
 3: import 'package:flame/collisions.dart';
 4: import 'package:flame/components.dart';
 5: import 'package:flame/extensions.dart';
 6: 
 7: import '../endless_world.dart';
 8: 
 9: /// The [Obstacle] component can represent three different types of obstacles
10: /// that the player can run into.
11: class Obstacle extends SpriteComponent with HasWorldReference<EndlessWorld> {
12:   Obstacle.small({super.position})
13:       : _srcSize = Vector2.all(16),
14:         _srcPosition = Vector2.all(32),
15:         super(
16:           size: Vector2.all(150),
17:           anchor: Anchor.bottomLeft,
18:         );
19: 
20:   Obstacle.tall({super.position})
21:       : _srcSize = Vector2(32, 48),
22:         _srcPosition = Vector2.zero(),
23:         super(
24:           size: Vector2(200, 250),
25:           anchor: Anchor.bottomLeft,
26:         );
27: 
28:   Obstacle.wide({super.position})
29:       : _srcSize = Vector2(32, 16),
30:         _srcPosition = Vector2(48, 32),
31:         super(
32:           size: Vector2(200, 100),
33:           anchor: Anchor.bottomLeft,
34:         );
35: 
36:   /// Generates a random obstacle of type [ObstacleType].
37:   factory Obstacle.random({
38:     Vector2? position,
39:     Random? random,
40:     bool canSpawnTall = true,
41:   }) {
42:     final values = canSpawnTall
43:         ? const [ObstacleType.small, ObstacleType.tall, ObstacleType.wide]
44:         : const [ObstacleType.small, ObstacleType.wide];
45:     final obstacleType = values.random(random);
46:     return switch (obstacleType) {
47:       ObstacleType.small => Obstacle.small(position: position),
48:       ObstacleType.tall => Obstacle.tall(position: position),
49:       ObstacleType.wide => Obstacle.wide(position: position),
50:     };
51:   }
52: 
53:   final Vector2 _srcSize;
54:   final Vector2 _srcPosition;
55: 
56:   @override
57:   Future<void> onLoad() async {
58:     // Since all the obstacles reside in the same image, srcSize and srcPosition
59:     // are used to determine what part of the image that should be used.
60:     sprite = await Sprite.load(
61:       'enemies/obstacles.png',
62:       srcSize: _srcSize,
63:       srcPosition: _srcPosition,
64:     );
65:     // When adding a RectangleHitbox without any arguments it automatically
66:     // fills up the size of the component.
67:     add(RectangleHitbox());
68:   }
69: 
70:   @override
71:   void update(double dt) {
72:     // We need to move the component to the left together with the speed that we
73:     // have set for the world.
74:     // `dt` here stands for delta time and it is the time, in seconds, since the
75:     // last update ran. We need to multiply the speed by `dt` to make sure that
76:     // the speed of the obstacles are the same no matter the refresh rate/speed
77:     // of your device.
78:     position.x -= world.speed * dt;
79: 
80:     // When the component is no longer visible on the screen anymore, we
81:     // remove it.
82:     // The position is defined from the upper left corner of the component (the
83:     // anchor) and the center of the world is in (0, 0), so when the components
84:     // position plus its size in X-axis is outside of minus half the world size
85:     // we know that it is no longer visible and it can be removed.
86:     if (position.x + size.x < -world.size.x / 2) {
87:       removeFromParent();
88:     }
89:   }
90: }
91: 
92: enum ObstacleType {
93:   small,
94:   tall,
95:   wide,
96: }
````

## File: templates/endless_runner/lib/flame_game/components/player.dart
````dart
  1: import 'package:flame/collisions.dart';
  2: import 'package:flame/components.dart';
  3: import 'package:flutter/animation.dart';
  4: 
  5: import '../../audio/sounds.dart';
  6: import '../effects/hurt_effect.dart';
  7: import '../effects/jump_effect.dart';
  8: import '../endless_runner.dart';
  9: import '../endless_world.dart';
 10: import 'obstacle.dart';
 11: import 'point.dart';
 12: 
 13: /// The [Player] is the component that the physical player of the game is
 14: /// controlling.
 15: class Player extends SpriteAnimationGroupComponent<PlayerState>
 16:     with
 17:         CollisionCallbacks,
 18:         HasWorldReference<EndlessWorld>,
 19:         HasGameReference<EndlessRunner> {
 20:   Player({
 21:     required this.addScore,
 22:     required this.resetScore,
 23:     super.position,
 24:   }) : super(size: Vector2.all(150), anchor: Anchor.center, priority: 1);
 25: 
 26:   final void Function({int amount}) addScore;
 27:   final VoidCallback resetScore;
 28: 
 29:   // The current velocity that the player has that comes from being affected by
 30:   // the gravity. Defined in virtual pixels/s².
 31:   double _gravityVelocity = 0;
 32: 
 33:   // The maximum length that the player can jump. Defined in virtual pixels.
 34:   final double _jumpLength = 600;
 35: 
 36:   // Whether the player is currently in the air, this can be used to restrict
 37:   // movement for example.
 38:   bool get inAir => (position.y + size.y / 2) < world.groundLevel;
 39: 
 40:   // Used to store the last position of the player, so that we later can
 41:   // determine which direction that the player is moving.
 42:   final Vector2 _lastPosition = Vector2.zero();
 43: 
 44:   // When the player has velocity pointing downwards it is counted as falling,
 45:   // this is used to set the correct animation for the player.
 46:   bool get isFalling => _lastPosition.y < position.y;
 47: 
 48:   @override
 49:   Future<void> onLoad() async {
 50:     // This defines the different animation states that the player can be in.
 51:     animations = {
 52:       PlayerState.running: await game.loadSpriteAnimation(
 53:         'dash/dash_running.png',
 54:         SpriteAnimationData.sequenced(
 55:           amount: 4,
 56:           textureSize: Vector2.all(16),
 57:           stepTime: 0.15,
 58:         ),
 59:       ),
 60:       PlayerState.jumping: SpriteAnimation.spriteList(
 61:         [await game.loadSprite('dash/dash_jumping.png')],
 62:         stepTime: double.infinity,
 63:       ),
 64:       PlayerState.falling: SpriteAnimation.spriteList(
 65:         [await game.loadSprite('dash/dash_falling.png')],
 66:         stepTime: double.infinity,
 67:       ),
 68:     };
 69:     // The starting state will be that the player is running.
 70:     current = PlayerState.running;
 71:     _lastPosition.setFrom(position);
 72: 
 73:     // When adding a CircleHitbox without any arguments it automatically
 74:     // fills up the size of the component as much as it can without overflowing
 75:     // it.
 76:     add(CircleHitbox());
 77:   }
 78: 
 79:   @override
 80:   void update(double dt) {
 81:     super.update(dt);
 82:     // When we are in the air the gravity should affect our position and pull
 83:     // us closer to the ground.
 84:     if (inAir) {
 85:       _gravityVelocity += world.gravity * dt;
 86:       position.y += _gravityVelocity;
 87:       if (isFalling) {
 88:         current = PlayerState.falling;
 89:       }
 90:     }
 91: 
 92:     final belowGround = position.y + size.y / 2 > world.groundLevel;
 93:     // If the player's new position would overshoot the ground level after
 94:     // updating its position we need to move the player up to the ground level
 95:     // again.
 96:     if (belowGround) {
 97:       position.y = world.groundLevel - size.y / 2;
 98:       _gravityVelocity = 0;
 99:       current = PlayerState.running;
100:     }
101: 
102:     _lastPosition.setFrom(position);
103:   }
104: 
105:   @override
106:   void onCollisionStart(
107:     Set<Vector2> intersectionPoints,
108:     PositionComponent other,
109:   ) {
110:     super.onCollisionStart(intersectionPoints, other);
111:     // When the player collides with an obstacle it should lose all its points.
112:     if (other is Obstacle) {
113:       game.audioController.playSfx(SfxType.damage);
114:       resetScore();
115:       add(HurtEffect());
116:     } else if (other is Point) {
117:       // When the player collides with a point it should gain a point and remove
118:       // the `Point` from the game.
119:       game.audioController.playSfx(SfxType.score);
120:       other.removeFromParent();
121:       addScore();
122:     }
123:   }
124: 
125:   /// [towards] should be a normalized vector that points in the direction that
126:   /// the player should jump.
127:   void jump(Vector2 towards) {
128:     current = PlayerState.jumping;
129:     // Since `towards` is normalized we need to scale (multiply) that vector by
130:     // the length that we want the jump to have.
131:     final jumpEffect = JumpEffect(towards..scaleTo(_jumpLength));
132: 
133:     // We only allow jumps when the player isn't already in the air.
134:     if (!inAir) {
135:       game.audioController.playSfx(SfxType.jump);
136:       add(jumpEffect);
137:     }
138:   }
139: }
140: 
141: enum PlayerState {
142:   running,
143:   jumping,
144:   falling,
145: }
````

## File: templates/endless_runner/lib/flame_game/components/point.dart
````dart
 1: import 'package:flame/collisions.dart';
 2: import 'package:flame/components.dart';
 3: 
 4: import '../endless_world.dart';
 5: 
 6: /// The [Point] components are the components that the [Player] should collect
 7: /// to finish a level. The points are represented by Flame's mascot; Ember.
 8: class Point extends SpriteAnimationComponent
 9:     with HasGameReference, HasWorldReference<EndlessWorld> {
10:   Point() : super(size: spriteSize, anchor: Anchor.center);
11: 
12:   static final Vector2 spriteSize = Vector2.all(100);
13:   final speed = 200;
14: 
15:   @override
16:   Future<void> onLoad() async {
17:     animation = await game.loadSpriteAnimation(
18:       'ember.png',
19:       SpriteAnimationData.sequenced(
20:         amount: 4,
21:         textureSize: Vector2.all(16),
22:         stepTime: 0.15,
23:       ),
24:     );
25:     // Since the original Ember sprite is looking to the right we have to flip
26:     // it, so that it is facing the player instead.
27:     flipHorizontallyAroundCenter();
28: 
29:     // When adding a CircleHitbox without any arguments it automatically
30:     // fills up the size of the component as much as it can without overflowing
31:     // it.
32:     add(CircleHitbox());
33:   }
34: 
35:   @override
36:   void update(double dt) {
37:     super.update(dt);
38:     // We need to move the component to the left together with the speed that we
39:     // have set for the world plus the speed set for the point, so that it
40:     // is visually moving to the left in the world.
41:     // `dt` here stands for delta time and it is the time, in seconds, since the
42:     // last update ran. We need to multiply the speed by `dt` to make sure that
43:     // the speed of the obstacles are the same no matter the refresh rate/speed
44:     // of your device.
45:     position.x -= (world.speed + speed) * dt;
46: 
47:     // When the component is no longer visible on the screen anymore, we
48:     // remove it.
49:     // The position is defined from the upper left corner of the component (the
50:     // anchor) and the center of the world is in (0, 0), so when the components
51:     // position plus its size in X-axis is outside of minus half the world size
52:     // we know that it is no longer visible and it can be removed.
53:     if (position.x + size.x / 2 < -world.size.x / 2) {
54:       removeFromParent();
55:     }
56:   }
57: }
````

## File: templates/endless_runner/lib/flame_game/effects/hurt_effect.dart
````dart
 1: import 'dart:math';
 2: 
 3: import 'package:flame/components.dart';
 4: import 'package:flame/effects.dart';
 5: import 'package:flutter/material.dart';
 6: 
 7: import '../components/player.dart';
 8: 
 9: /// The [HurtEffect] is an effect that is composed of multiple different effects
10: /// that are added to the [Player] when it is hurt.
11: /// It spins the player, shoots it up in the air and makes it blink in white.
12: class HurtEffect extends Component with ParentIsA<Player> {
13:   @override
14:   void onMount() {
15:     super.onMount();
16:     const effectTime = 0.5;
17:     parent.addAll(
18:       [
19:         RotateEffect.by(
20:           pi * 2,
21:           EffectController(
22:             duration: effectTime,
23:             curve: Curves.easeInOut,
24:           ),
25:         ),
26:         MoveByEffect(
27:           Vector2(0, -400),
28:           EffectController(
29:             duration: effectTime,
30:             curve: Curves.easeInOut,
31:           ),
32:           onComplete: removeFromParent,
33:         ),
34:         ColorEffect(
35:           Colors.white,
36:           EffectController(
37:             duration: effectTime / 8,
38:             alternate: true,
39:             repeatCount: 2,
40:           ),
41:           opacityTo: 0.9,
42:         ),
43:       ],
44:     );
45:   }
46: }
````

## File: templates/endless_runner/lib/flame_game/effects/jump_effect.dart
````dart
 1: import 'package:flame/components.dart';
 2: import 'package:flame/effects.dart';
 3: import 'package:flutter/animation.dart';
 4: 
 5: /// The [JumpEffect] is simply a [MoveByEffect] which has the properties of the
 6: /// effect pre-defined.
 7: class JumpEffect extends MoveByEffect {
 8:   JumpEffect(Vector2 offset)
 9:       : super(offset, EffectController(duration: 0.3, curve: Curves.ease));
10: }
````

## File: templates/endless_runner/lib/flame_game/endless_runner.dart
````dart
 1: import 'package:flame/components.dart';
 2: import 'package:flame/game.dart';
 3: import 'package:flutter/material.dart';
 4: 
 5: import '../audio/audio_controller.dart';
 6: import '../level_selection/levels.dart';
 7: import '../player_progress/player_progress.dart';
 8: import 'components/background.dart';
 9: import 'endless_world.dart';
10: 
11: /// This is the base of the game which is added to the [GameWidget].
12: ///
13: /// This class defines a few different properties for the game:
14: ///  - That it should run collision detection, this is done through the
15: ///  [HasCollisionDetection] mixin.
16: ///  - That it should have a [FixedResolutionViewport] with a size of 1600x720,
17: ///  this means that even if you resize the window, the game itself will keep
18: ///  the defined virtual resolution.
19: ///  - That the default world that the camera is looking at should be the
20: ///  [EndlessWorld].
21: ///
22: /// Note that both of the last are passed in to the super constructor, they
23: /// could also be set inside of `onLoad` for example.
24: class EndlessRunner extends FlameGame<EndlessWorld> with HasCollisionDetection {
25:   EndlessRunner({
26:     required this.level,
27:     required PlayerProgress playerProgress,
28:     required this.audioController,
29:   }) : super(
30:           world: EndlessWorld(level: level, playerProgress: playerProgress),
31:           camera: CameraComponent.withFixedResolution(width: 1600, height: 720),
32:         );
33: 
34:   /// What the properties of the level that is played has.
35:   final GameLevel level;
36: 
37:   /// A helper for playing sound effects and background audio.
38:   final AudioController audioController;
39: 
40:   /// In the [onLoad] method you load different type of assets and set things
41:   /// that only needs to be set once when the level starts up.
42:   @override
43:   Future<void> onLoad() async {
44:     // The backdrop is a static layer behind the world that the camera is
45:     // looking at, so here we add our parallax background.
46:     camera.backdrop.add(Background(speed: world.speed));
47: 
48:     // With the `TextPaint` we define what properties the text that we are going
49:     // to render will have, like font family, size and color in this instance.
50:     final textRenderer = TextPaint(
51:       style: const TextStyle(
52:         fontSize: 30,
53:         color: Colors.white,
54:         fontFamily: 'Press Start 2P',
55:       ),
56:     );
57: 
58:     final scoreText = 'Embers: 0 / ${level.winScore}';
59: 
60:     // The component that is responsible for rendering the text that contains
61:     // the current score.
62:     final scoreComponent = TextComponent(
63:       text: scoreText,
64:       position: Vector2.all(30),
65:       textRenderer: textRenderer,
66:     );
67: 
68:     // The scoreComponent is added to the viewport, which means that even if the
69:     // camera's viewfinder move around and looks at different positions in the
70:     // world, the score is always static to the viewport.
71:     camera.viewport.add(scoreComponent);
72: 
73:     // Here we add a listener to the notifier that is updated when the player
74:     // gets a new point, in the callback we update the text of the
75:     // `scoreComponent`.
76:     world.scoreNotifier.addListener(() {
77:       scoreComponent.text =
78:           scoreText.replaceFirst('0', '${world.scoreNotifier.value}');
79:     });
80:   }
81: }
````

## File: templates/endless_runner/lib/flame_game/endless_world.dart
````dart
  1: import 'dart:math';
  2: 
  3: import 'package:flame/components.dart';
  4: import 'package:flame/events.dart';
  5: import 'package:flame/experimental.dart';
  6: import 'package:flame/game.dart';
  7: import 'package:flutter/material.dart';
  8: 
  9: import '../level_selection/levels.dart';
 10: import '../player_progress/player_progress.dart';
 11: import 'components/obstacle.dart';
 12: import 'components/player.dart';
 13: import 'components/point.dart';
 14: import 'game_screen.dart';
 15: 
 16: /// The world is where you place all the components that should live inside of
 17: /// the game, like the player, enemies, obstacles and points for example.
 18: /// The world can be much bigger than what the camera is currently looking at,
 19: /// but in this game all components that go outside of the size of the viewport
 20: /// are removed, since the player can't interact with those anymore.
 21: ///
 22: /// The [EndlessWorld] has two mixins added to it:
 23: ///  - The [TapCallbacks] that makes it possible to react to taps (or mouse
 24: ///  clicks) on the world.
 25: ///  - The [HasGameReference] that gives the world access to a variable called
 26: ///  `game`, which is a reference to the game class that the world is attached
 27: ///  to.
 28: class EndlessWorld extends World with TapCallbacks, HasGameReference {
 29:   EndlessWorld({
 30:     required this.level,
 31:     required this.playerProgress,
 32:     Random? random,
 33:   }) : _random = random ?? Random();
 34: 
 35:   /// The properties of the current level.
 36:   final GameLevel level;
 37: 
 38:   /// Used to see what the current progress of the player is and to update the
 39:   /// progress if a level is finished.
 40:   final PlayerProgress playerProgress;
 41: 
 42:   /// The speed is used for determining how fast the background should pass by
 43:   /// and how fast the enemies and obstacles should move.
 44:   late double speed = _calculateSpeed(level.number);
 45: 
 46:   /// In the [scoreNotifier] we keep track of what the current score is, and if
 47:   /// other parts of the code is interested in when the score is updated they
 48:   /// can listen to it and act on the updated value.
 49:   final scoreNotifier = ValueNotifier(0);
 50:   late final Player player;
 51:   late final DateTime timeStarted;
 52:   Vector2 get size => (parent as FlameGame).size;
 53:   int levelCompletedIn = 0;
 54: 
 55:   /// The random number generator that is used to spawn periodic components.
 56:   final Random _random;
 57: 
 58:   /// The gravity is defined in virtual pixels per second squared.
 59:   /// These pixels are in relation to how big the [FixedResolutionViewport] is.
 60:   final double gravity = 30;
 61: 
 62:   /// Where the ground is located in the world and things should stop falling.
 63:   late final double groundLevel = (size.y / 2) - (size.y / 5);
 64: 
 65:   @override
 66:   Future<void> onLoad() async {
 67:     // Used to keep track of when the level started, so that we later can
 68:     // calculate how long time it took to finish the level.
 69:     timeStarted = DateTime.now();
 70: 
 71:     // The player is the component that we control when we tap the screen, the
 72:     // Dash in this case.
 73:     player = Player(
 74:       position: Vector2(-size.x / 3, groundLevel - 900),
 75:       addScore: addScore,
 76:       resetScore: resetScore,
 77:     );
 78:     add(player);
 79: 
 80:     add(
 81:       SpawnComponent(
 82:         factory: (_) => Obstacle.random(
 83:           random: _random,
 84:           canSpawnTall: level.canSpawnTall,
 85:         ),
 86:         period: 5,
 87:         area: Rectangle.fromPoints(
 88:           Vector2(size.x / 2, groundLevel),
 89:           Vector2(size.x / 2, groundLevel),
 90:         ),
 91:         random: _random,
 92:       ),
 93:     );
 94: 
 95:     add(
 96:       SpawnComponent.periodRange(
 97:         factory: (_) => Point(),
 98:         minPeriod: 3.0,
 99:         maxPeriod: 5.0 + level.number,
100:         area: Rectangle.fromPoints(
101:           Vector2(size.x / 2, -size.y / 2 + Point.spriteSize.y),
102:           Vector2(size.x / 2, groundLevel),
103:         ),
104:         random: _random,
105:       ),
106:     );
107: 
108:     // When the player takes a new point we check if the score is enough to
109:     // pass the level and if it is we calculate what time the level was passed
110:     // in, update the player's progress and open up a dialog that shows that
111:     // the player passed the level.
112:     scoreNotifier.addListener(() {
113:       if (scoreNotifier.value >= level.winScore) {
114:         final levelTime = (DateTime.now().millisecondsSinceEpoch -
115:                 timeStarted.millisecondsSinceEpoch) /
116:             1000;
117: 
118:         levelCompletedIn = levelTime.round();
119: 
120:         playerProgress.setLevelFinished(level.number, levelCompletedIn);
121:         game.pauseEngine();
122:         game.overlays.add(GameScreen.winDialogKey);
123:       }
124:     });
125:   }
126: 
127:   @override
128:   void onMount() {
129:     super.onMount();
130:     // When the world is mounted in the game we add a back button widget as an
131:     // overlay so that the player can go back to the previous screen.
132:     game.overlays.add(GameScreen.backButtonKey);
133:   }
134: 
135:   @override
136:   void onRemove() {
137:     game.overlays.remove(GameScreen.backButtonKey);
138:   }
139: 
140:   /// Gives the player points, with a default value +1 points.
141:   void addScore({int amount = 1}) {
142:     scoreNotifier.value += amount;
143:   }
144: 
145:   /// Sets the player's score to 0 again.
146:   void resetScore() {
147:     scoreNotifier.value = 0;
148:   }
149: 
150:   /// [onTapDown] is called when the player taps the screen and then calculates
151:   /// if and how the player should jump.
152:   @override
153:   void onTapDown(TapDownEvent event) {
154:     // Which direction the player should jump.
155:     final towards = (event.localPosition - player.position)..normalize();
156:     // If the tap is underneath the player no jump is triggered, but if it is
157:     // above the player it triggers a jump, even though the player might be in
158:     // the air. This makes it possible to later implement double jumping inside
159:     // of the `player` class if one would want to.
160:     if (towards.y.isNegative) {
161:       player.jump(towards);
162:     }
163:   }
164: 
165:   /// A helper function to define how fast a certain level should be.
166:   static double _calculateSpeed(int level) => 200 + (level * 200);
167: }
````

## File: templates/endless_runner/lib/flame_game/game_screen.dart
````dart
 1: import 'package:flame/game.dart';
 2: import 'package:flutter/material.dart';
 3: import 'package:go_router/go_router.dart';
 4: import 'package:nes_ui/nes_ui.dart';
 5: import 'package:provider/provider.dart';
 6: 
 7: import '../audio/audio_controller.dart';
 8: import '../level_selection/levels.dart';
 9: import '../player_progress/player_progress.dart';
10: import 'endless_runner.dart';
11: import 'game_win_dialog.dart';
12: 
13: /// This widget defines the properties of the game screen.
14: ///
15: /// It mostly sets up the overlays (widgets shown on top of the Flame game) and
16: /// the gets the [AudioController] from the context and passes it in to the
17: /// [EndlessRunner] class so that it can play audio.
18: class GameScreen extends StatelessWidget {
19:   const GameScreen({required this.level, super.key});
20: 
21:   final GameLevel level;
22: 
23:   static const String winDialogKey = 'win_dialog';
24:   static const String backButtonKey = 'back_buttton';
25: 
26:   @override
27:   Widget build(BuildContext context) {
28:     final audioController = context.read<AudioController>();
29:     return Scaffold(
30:       body: GameWidget<EndlessRunner>(
31:         key: const Key('play session'),
32:         game: EndlessRunner(
33:           level: level,
34:           playerProgress: context.read<PlayerProgress>(),
35:           audioController: audioController,
36:         ),
37:         overlayBuilderMap: {
38:           backButtonKey: (BuildContext context, EndlessRunner game) {
39:             return Positioned(
40:               top: 20,
41:               right: 10,
42:               child: NesButton(
43:                 type: NesButtonType.normal,
44:                 onPressed: GoRouter.of(context).pop,
45:                 child: NesIcon(iconData: NesIcons.leftArrowIndicator),
46:               ),
47:             );
48:           },
49:           winDialogKey: (BuildContext context, EndlessRunner game) {
50:             return GameWinDialog(
51:               level: level,
52:               levelCompletedIn: game.world.levelCompletedIn,
53:             );
54:           },
55:         },
56:       ),
57:     );
58:   }
59: }
````

## File: templates/endless_runner/lib/flame_game/game_win_dialog.dart
````dart
 1: import 'package:flutter/material.dart';
 2: import 'package:go_router/go_router.dart';
 3: import 'package:nes_ui/nes_ui.dart';
 4: import 'package:provider/provider.dart';
 5: 
 6: import '../level_selection/levels.dart';
 7: import '../style/palette.dart';
 8: 
 9: /// This dialog is shown when a level is completed.
10: ///
11: /// It shows what time the level was completed in and if there are more levels
12: /// it lets the user go to the next level, or otherwise back to the level
13: /// selection screen.
14: class GameWinDialog extends StatelessWidget {
15:   const GameWinDialog({
16:     super.key,
17:     required this.level,
18:     required this.levelCompletedIn,
19:   });
20: 
21:   /// The properties of the level that was just finished.
22:   final GameLevel level;
23: 
24:   /// How many seconds that the level was completed in.
25:   final int levelCompletedIn;
26: 
27:   @override
28:   Widget build(BuildContext context) {
29:     final palette = context.read<Palette>();
30:     return Center(
31:       child: NesContainer(
32:         width: 420,
33:         height: 300,
34:         backgroundColor: palette.backgroundPlaySession.color,
35:         child: Column(
36:           mainAxisAlignment: MainAxisAlignment.center,
37:           children: [
38:             Text(
39:               'Well done!',
40:               style: Theme.of(context).textTheme.headlineMedium,
41:               textAlign: TextAlign.center,
42:             ),
43:             const SizedBox(height: 16),
44:             Text(
45:               'You completed level ${level.number} in $levelCompletedIn seconds.',
46:               textAlign: TextAlign.center,
47:             ),
48:             const SizedBox(height: 16),
49:             if (level.number < gameLevels.length) ...[
50:               NesButton(
51:                 onPressed: () {
52:                   context.go('/play/session/${level.number + 1}');
53:                 },
54:                 type: NesButtonType.primary,
55:                 child: const Text('Next level'),
56:               ),
57:               const SizedBox(height: 16),
58:             ],
59:             NesButton(
60:               onPressed: () {
61:                 context.go('/play');
62:               },
63:               type: NesButtonType.normal,
64:               child: const Text('Level selection'),
65:             ),
66:           ],
67:         ),
68:       ),
69:     );
70:   }
71: }
````

## File: templates/endless_runner/lib/level_selection/instructions_dialog.dart
````dart
  1: import 'package:flame/components.dart';
  2: import 'package:flame/widgets.dart';
  3: import 'package:flutter/cupertino.dart';
  4: import 'package:google_fonts/google_fonts.dart';
  5: import 'package:nes_ui/nes_ui.dart';
  6: 
  7: class InstructionsDialog extends StatefulWidget {
  8:   const InstructionsDialog({super.key});
  9: 
 10:   @override
 11:   State<InstructionsDialog> createState() => _InstructionsDialogState();
 12: }
 13: 
 14: class _InstructionsDialogState extends State<InstructionsDialog> {
 15:   final _pageController = PageController();
 16:   late int _currentPage = _pageController.initialPage;
 17: 
 18:   @override
 19:   Widget build(BuildContext context) {
 20:     return Column(
 21:       children: [
 22:         Text(
 23:           'Instructions',
 24:           style: TextStyle(
 25:             fontFamily: GoogleFonts.pressStart2p().fontFamily,
 26:             fontSize: 25,
 27:           ),
 28:         ),
 29:         const SizedBox(height: 30),
 30:         Row(
 31:           children: [
 32:             SizedBox(
 33:               width: 30,
 34:               child: _currentPage != 0
 35:                   ? NesIconButton(
 36:                       icon: NesIcons.leftArrowIndicator,
 37:                       onPress: () {
 38:                         _pageController.previousPage(
 39:                           duration: const Duration(milliseconds: 200),
 40:                           curve: Curves.easeInOut,
 41:                         );
 42:                       },
 43:                     )
 44:                   : null,
 45:             ),
 46:             SizedBox(
 47:               width: 350,
 48:               height: 100,
 49:               child: PageView(
 50:                 controller: _pageController,
 51:                 onPageChanged: (int newPage) {
 52:                   setState(() {
 53:                     _currentPage = newPage;
 54:                   });
 55:                 },
 56:                 children: [
 57:                   Row(
 58:                     mainAxisAlignment: MainAxisAlignment.center,
 59:                     children: [
 60:                       Flexible(
 61:                         flex: 3,
 62:                         child: SizedBox(
 63:                           width: 100,
 64:                           height: 100,
 65:                           child: SpriteAnimationWidget.asset(
 66:                             path: 'dash/dash_spritesheet.png',
 67:                             data: SpriteAnimationData.sequenced(
 68:                               amount: 3,
 69:                               stepTime: 0.15,
 70:                               textureSize: Vector2.all(16),
 71:                             ),
 72:                           ),
 73:                         ),
 74:                       ),
 75:                       const SizedBox(width: 20),
 76:                       const Flexible(
 77:                         flex: 7,
 78:                         child: Text(
 79:                           'Tap/click on the screen to jump in that direction, tap again to double jump.',
 80:                         ),
 81:                       ),
 82:                     ],
 83:                   ),
 84:                   Row(
 85:                     mainAxisAlignment: MainAxisAlignment.center,
 86:                     children: [
 87:                       const Flexible(
 88:                         flex: 7,
 89:                         child: Text(
 90:                           'You have to save as many Embers as possible to clear the level.',
 91:                         ),
 92:                       ),
 93:                       const SizedBox(width: 20),
 94:                       Flexible(
 95:                         flex: 3,
 96:                         child: SizedBox(
 97:                           width: 60,
 98:                           height: 60,
 99:                           child: SpriteAnimationWidget.asset(
100:                             path: 'ember.png',
101:                             data: SpriteAnimationData.sequenced(
102:                               amount: 4,
103:                               stepTime: 0.15,
104:                               textureSize: Vector2.all(16),
105:                             ),
106:                           ),
107:                         ),
108:                       ),
109:                     ],
110:                   ),
111:                   Row(
112:                     mainAxisAlignment: MainAxisAlignment.center,
113:                     children: [
114:                       Flexible(
115:                         flex: 4,
116:                         child: SizedBox(
117:                           width: 200,
118:                           height: 100,
119:                           child:
120:                               SpriteWidget.asset(path: 'enemies/obstacles.png'),
121:                         ),
122:                       ),
123:                       const SizedBox(width: 20),
124:                       const Flexible(
125:                         flex: 6,
126:                         child: Text(
127:                           'Watch out for these, they will make you drop your Embers.',
128:                         ),
129:                       )
130:                     ],
131:                   ),
132:                 ],
133:               ),
134:             ),
135:             SizedBox(
136:               width: 30,
137:               child: _currentPage != 2
138:                   ? NesIconButton(
139:                       icon: NesIcons.rightArrowIndicator,
140:                       onPress: () {
141:                         _pageController.nextPage(
142:                           duration: const Duration(milliseconds: 200),
143:                           curve: Curves.easeInOut,
144:                         );
145:                       },
146:                     )
147:                   : null,
148:             ),
149:           ],
150:         ),
151:       ],
152:     );
153:   }
154: 
155:   @override
156:   void dispose() {
157:     super.dispose();
158:     _pageController.dispose();
159:   }
160: }
````

## File: templates/endless_runner/lib/level_selection/level_selection_screen.dart
````dart
  1: import 'package:flutter/material.dart';
  2: import 'package:go_router/go_router.dart';
  3: import 'package:nes_ui/nes_ui.dart';
  4: import 'package:provider/provider.dart';
  5: 
  6: import '../audio/audio_controller.dart';
  7: import '../audio/sounds.dart';
  8: import '../player_progress/player_progress.dart';
  9: import '../style/palette.dart';
 10: import '../style/wobbly_button.dart';
 11: import 'instructions_dialog.dart';
 12: import 'levels.dart';
 13: 
 14: class LevelSelectionScreen extends StatelessWidget {
 15:   const LevelSelectionScreen({super.key});
 16: 
 17:   @override
 18:   Widget build(BuildContext context) {
 19:     final palette = context.watch<Palette>();
 20:     final playerProgress = context.watch<PlayerProgress>();
 21:     final levelTextStyle =
 22:         Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.4);
 23: 
 24:     return Scaffold(
 25:       backgroundColor: palette.backgroundLevelSelection.color,
 26:       body: Column(
 27:         children: [
 28:           Padding(
 29:             padding: const EdgeInsets.all(16),
 30:             child: Center(
 31:               child: Row(
 32:                 mainAxisAlignment: MainAxisAlignment.center,
 33:                 children: [
 34:                   Text(
 35:                     'Select level',
 36:                     style: Theme.of(context).textTheme.headlineSmall,
 37:                   ),
 38:                   const SizedBox(width: 16),
 39:                   NesButton(
 40:                     type: NesButtonType.normal,
 41:                     child: NesIcon(iconData: NesIcons.questionMark),
 42:                     onPressed: () {
 43:                       NesDialog.show<void>(
 44:                         context: context,
 45:                         builder: (_) => const InstructionsDialog(),
 46:                       );
 47:                     },
 48:                   )
 49:                 ],
 50:               ),
 51:             ),
 52:           ),
 53:           const SizedBox(height: 50),
 54:           Expanded(
 55:             child: SizedBox(
 56:               width: 450,
 57:               child: ListView(
 58:                 children: [
 59:                   for (final level in gameLevels)
 60:                     ListTile(
 61:                       enabled: playerProgress.levels.length >= level.number - 1,
 62:                       onTap: () {
 63:                         final audioController = context.read<AudioController>();
 64:                         audioController.playSfx(SfxType.buttonTap);
 65: 
 66:                         GoRouter.of(context)
 67:                             .go('/play/session/${level.number}');
 68:                       },
 69:                       leading: Text(
 70:                         level.number.toString(),
 71:                         style: levelTextStyle,
 72:                       ),
 73:                       title: Row(
 74:                         children: [
 75:                           Text(
 76:                             'Level #${level.number}',
 77:                             style: levelTextStyle,
 78:                           ),
 79:                           if (playerProgress.levels.length <
 80:                               level.number - 1) ...[
 81:                             const SizedBox(width: 10),
 82:                             const Icon(Icons.lock, size: 20),
 83:                           ] else if (playerProgress.levels.length >=
 84:                               level.number) ...[
 85:                             const SizedBox(width: 50),
 86:                             Text(
 87:                               '${playerProgress.levels[level.number - 1]}s',
 88:                               style: levelTextStyle,
 89:                             ),
 90:                           ],
 91:                         ],
 92:                       ),
 93:                     )
 94:                 ],
 95:               ),
 96:             ),
 97:           ),
 98:           const SizedBox(height: 30),
 99:           WobblyButton(
100:             onPressed: () {
101:               GoRouter.of(context).go('/');
102:             },
103:             child: const Text('Back'),
104:           ),
105:           const SizedBox(height: 30),
106:         ],
107:       ),
108:     );
109:   }
110: }
````

## File: templates/endless_runner/lib/level_selection/levels.dart
````dart
 1: const gameLevels = <GameLevel>[
 2:   (
 3:     number: 1,
 4:     winScore: 3,
 5:     canSpawnTall: false,
 6:   ),
 7:   (
 8:     number: 2,
 9:     winScore: 5,
10:     canSpawnTall: true,
11:   ),
12: ];
13: 
14: typedef GameLevel = ({
15:   int number,
16:   int winScore,
17:   bool canSpawnTall,
18: });
````

## File: templates/endless_runner/lib/main_menu/main_menu_screen.dart
````dart
 1: import 'package:flutter/material.dart';
 2: import 'package:go_router/go_router.dart';
 3: import 'package:provider/provider.dart';
 4: 
 5: import '../audio/audio_controller.dart';
 6: import '../audio/sounds.dart';
 7: import '../settings/settings.dart';
 8: import '../style/palette.dart';
 9: import '../style/responsive_screen.dart';
10: import '../style/wobbly_button.dart';
11: 
12: class MainMenuScreen extends StatelessWidget {
13:   const MainMenuScreen({super.key});
14: 
15:   @override
16:   Widget build(BuildContext context) {
17:     final palette = context.watch<Palette>();
18:     final settingsController = context.watch<SettingsController>();
19:     final audioController = context.watch<AudioController>();
20: 
21:     return Scaffold(
22:       backgroundColor: palette.backgroundMain.color,
23:       body: ResponsiveScreen(
24:         squarishMainArea: Center(
25:           child: Column(
26:             mainAxisAlignment: MainAxisAlignment.center,
27:             children: [
28:               Image.asset(
29:                 'assets/images/banner.png',
30:                 filterQuality: FilterQuality.none,
31:               ),
32:               _gap,
33:               Transform.rotate(
34:                 angle: -0.1,
35:                 child: ConstrainedBox(
36:                   constraints: const BoxConstraints(maxWidth: 500),
37:                   child: const Text(
38:                     'A Flutter game template.',
39:                     textAlign: TextAlign.center,
40:                     style: TextStyle(
41:                       fontFamily: 'Press Start 2P',
42:                       fontSize: 32,
43:                       height: 1,
44:                     ),
45:                   ),
46:                 ),
47:               ),
48:             ],
49:           ),
50:         ),
51:         rectangularMenuArea: Column(
52:           mainAxisAlignment: MainAxisAlignment.center,
53:           children: [
54:             WobblyButton(
55:               onPressed: () {
56:                 audioController.playSfx(SfxType.buttonTap);
57:                 GoRouter.of(context).go('/play');
58:               },
59:               child: const Text('Play'),
60:             ),
61:             _gap,
62:             WobblyButton(
63:               onPressed: () => GoRouter.of(context).push('/settings'),
64:               child: const Text('Settings'),
65:             ),
66:             _gap,
67:             Padding(
68:               padding: const EdgeInsets.only(top: 32),
69:               child: ValueListenableBuilder<bool>(
70:                 valueListenable: settingsController.audioOn,
71:                 builder: (context, audioOn, child) {
72:                   return IconButton(
73:                     onPressed: () => settingsController.toggleAudioOn(),
74:                     icon: Icon(audioOn ? Icons.volume_up : Icons.volume_off),
75:                   );
76:                 },
77:               ),
78:             ),
79:             _gap,
80:             const Text('Built with Flame'),
81:           ],
82:         ),
83:       ),
84:     );
85:   }
86: 
87:   static const _gap = SizedBox(height: 10);
88: }
````

## File: templates/endless_runner/lib/player_progress/persistence/local_storage_player_progress_persistence.dart
````dart
 1: import 'package:shared_preferences/shared_preferences.dart';
 2: 
 3: import 'player_progress_persistence.dart';
 4: 
 5: /// An implementation of [PlayerProgressPersistence] that uses
 6: /// `package:shared_preferences`.
 7: class LocalStoragePlayerProgressPersistence extends PlayerProgressPersistence {
 8:   final Future<SharedPreferences> instanceFuture =
 9:       SharedPreferences.getInstance();
10: 
11:   @override
12:   Future<List<int>> getFinishedLevels() async {
13:     final prefs = await instanceFuture;
14:     final serialized = prefs.getStringList('levelsFinished') ?? [];
15: 
16:     return serialized.map(int.parse).toList();
17:   }
18: 
19:   @override
20:   Future<void> saveLevelFinished(int level, int time) async {
21:     final prefs = await instanceFuture;
22:     final serialized = prefs.getStringList('levelsFinished') ?? [];
23:     if (level <= serialized.length) {
24:       final currentTime = int.parse(serialized[level - 1]);
25:       if (time < currentTime) {
26:         serialized[level - 1] = time.toString();
27:       }
28:     } else {
29:       serialized.add(time.toString());
30:     }
31:     await prefs.setStringList('levelsFinished', serialized);
32:   }
33: 
34:   @override
35:   Future<void> reset() async {
36:     final prefs = await instanceFuture;
37:     await prefs.remove('levelsFinished');
38:   }
39: }
````

## File: templates/endless_runner/lib/player_progress/persistence/memory_player_progress_persistence.dart
````dart
 1: import 'dart:core';
 2: 
 3: import 'player_progress_persistence.dart';
 4: 
 5: /// An in-memory implementation of [PlayerProgressPersistence].
 6: /// Useful for testing.
 7: class MemoryOnlyPlayerProgressPersistence implements PlayerProgressPersistence {
 8:   final levels = <int>[];
 9: 
10:   @override
11:   Future<List<int>> getFinishedLevels() async {
12:     await Future<void>.delayed(const Duration(milliseconds: 500));
13:     return levels;
14:   }
15: 
16:   @override
17:   Future<void> saveLevelFinished(int level, int time) async {
18:     await Future<void>.delayed(const Duration(milliseconds: 500));
19:     if (level < levels.length - 1 && levels[level - 1] > time) {
20:       levels[level - 1] = time;
21:     }
22:   }
23: 
24:   @override
25:   Future<void> reset() async {
26:     levels.clear();
27:   }
28: }
````

## File: templates/endless_runner/lib/player_progress/persistence/player_progress_persistence.dart
````dart
 1: /// An interface of persistence stores for the player's progress.
 2: ///
 3: /// Implementations can range from simple in-memory storage through
 4: /// local preferences to cloud saves.
 5: abstract class PlayerProgressPersistence {
 6:   Future<List<int>> getFinishedLevels();
 7: 
 8:   Future<void> saveLevelFinished(int level, int time);
 9: 
10:   Future<void> reset();
11: }
````

## File: templates/endless_runner/lib/player_progress/player_progress.dart
````dart
 1: import 'dart:async';
 2: 
 3: import 'package:flutter/foundation.dart';
 4: 
 5: import 'persistence/local_storage_player_progress_persistence.dart';
 6: import 'persistence/player_progress_persistence.dart';
 7: 
 8: /// Encapsulates the player's progress.
 9: class PlayerProgress extends ChangeNotifier {
10:   PlayerProgress({PlayerProgressPersistence? store})
11:       : _store = store ?? LocalStoragePlayerProgressPersistence() {
12:     unawaited(getLatestFromStore());
13:   }
14: 
15:   /// TODO: If needed, replace this with some other mechanism for saving
16:   ///       the player's progress. Currently, this uses the local storage
17:   ///       (i.e. NSUserDefaults on iOS, SharedPreferences on Android
18:   ///       or local storage on the web).
19:   final PlayerProgressPersistence _store;
20: 
21:   List<int> _levelsFinished = [];
22: 
23:   /// The times for the levels that the player has finished so far.
24:   List<int> get levels => _levelsFinished;
25: 
26:   /// Fetches the latest data from the backing persistence store.
27:   Future<void> getLatestFromStore() async {
28:     final levelsFinished = await _store.getFinishedLevels();
29:     if (!listEquals(_levelsFinished, levelsFinished)) {
30:       _levelsFinished = levelsFinished;
31:       notifyListeners();
32:     }
33:   }
34: 
35:   /// Resets the player's progress so it's like if they just started
36:   /// playing the game for the first time.
37:   void reset() {
38:     _store.reset();
39:     _levelsFinished.clear();
40:     notifyListeners();
41:   }
42: 
43:   /// Registers [level] as reached.
44:   ///
45:   /// If this is higher than [highestLevelReached], it will update that
46:   /// value and save it to the injected persistence store.
47:   void setLevelFinished(int level, int time) {
48:     if (level < _levelsFinished.length - 1) {
49:       final currentTime = _levelsFinished[level - 1];
50:       if (time < currentTime) {
51:         _levelsFinished[level - 1] = time;
52:         notifyListeners();
53:         unawaited(_store.saveLevelFinished(level, time));
54:       }
55:     } else {
56:       _levelsFinished.add(time);
57:       notifyListeners();
58:       unawaited(_store.saveLevelFinished(level, time));
59:     }
60:   }
61: }
````

## File: templates/endless_runner/lib/settings/persistence/local_storage_settings_persistence.dart
````dart
 1: import 'package:shared_preferences/shared_preferences.dart';
 2: 
 3: import 'settings_persistence.dart';
 4: 
 5: /// An implementation of [SettingsPersistence] that uses
 6: /// `package:shared_preferences`.
 7: class LocalStorageSettingsPersistence extends SettingsPersistence {
 8:   final Future<SharedPreferences> instanceFuture =
 9:       SharedPreferences.getInstance();
10: 
11:   @override
12:   Future<bool> getAudioOn({required bool defaultValue}) async {
13:     final prefs = await instanceFuture;
14:     return prefs.getBool('audioOn') ?? defaultValue;
15:   }
16: 
17:   @override
18:   Future<bool> getMusicOn({required bool defaultValue}) async {
19:     final prefs = await instanceFuture;
20:     return prefs.getBool('musicOn') ?? defaultValue;
21:   }
22: 
23:   @override
24:   Future<String> getPlayerName() async {
25:     final prefs = await instanceFuture;
26:     return prefs.getString('playerName') ?? 'Player';
27:   }
28: 
29:   @override
30:   Future<bool> getSoundsOn({required bool defaultValue}) async {
31:     final prefs = await instanceFuture;
32:     return prefs.getBool('soundsOn') ?? defaultValue;
33:   }
34: 
35:   @override
36:   Future<void> saveAudioOn(bool value) async {
37:     final prefs = await instanceFuture;
38:     await prefs.setBool('audioOn', value);
39:   }
40: 
41:   @override
42:   Future<void> saveMusicOn(bool value) async {
43:     final prefs = await instanceFuture;
44:     await prefs.setBool('musicOn', value);
45:   }
46: 
47:   @override
48:   Future<void> savePlayerName(String value) async {
49:     final prefs = await instanceFuture;
50:     await prefs.setString('playerName', value);
51:   }
52: 
53:   @override
54:   Future<void> saveSoundsOn(bool value) async {
55:     final prefs = await instanceFuture;
56:     await prefs.setBool('soundsOn', value);
57:   }
58: }
````

## File: templates/endless_runner/lib/settings/persistence/memory_settings_persistence.dart
````dart
 1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: import 'settings_persistence.dart';
 6: 
 7: /// An in-memory implementation of [SettingsPersistence].
 8: /// Useful for testing.
 9: class MemoryOnlySettingsPersistence implements SettingsPersistence {
10:   bool musicOn = true;
11: 
12:   bool soundsOn = true;
13: 
14:   bool audioOn = true;
15: 
16:   String playerName = 'Player';
17: 
18:   @override
19:   Future<bool> getAudioOn({required bool defaultValue}) async => audioOn;
20: 
21:   @override
22:   Future<bool> getMusicOn({required bool defaultValue}) async => musicOn;
23: 
24:   @override
25:   Future<String> getPlayerName() async => playerName;
26: 
27:   @override
28:   Future<bool> getSoundsOn({required bool defaultValue}) async => soundsOn;
29: 
30:   @override
31:   Future<void> saveAudioOn(bool value) async => audioOn = value;
32: 
33:   @override
34:   Future<void> saveMusicOn(bool value) async => musicOn = value;
35: 
36:   @override
37:   Future<void> savePlayerName(String value) async => playerName = value;
38: 
39:   @override
40:   Future<void> saveSoundsOn(bool value) async => soundsOn = value;
41: }
````

## File: templates/endless_runner/lib/settings/persistence/settings_persistence.dart
````dart
 1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: /// An interface of persistence stores for settings.
 6: ///
 7: /// Implementations can range from simple in-memory storage through
 8: /// local preferences to cloud-based solutions.
 9: abstract class SettingsPersistence {
10:   Future<bool> getAudioOn({required bool defaultValue});
11: 
12:   Future<bool> getMusicOn({required bool defaultValue});
13: 
14:   Future<String> getPlayerName();
15: 
16:   Future<bool> getSoundsOn({required bool defaultValue});
17: 
18:   Future<void> saveAudioOn(bool value);
19: 
20:   Future<void> saveMusicOn(bool value);
21: 
22:   Future<void> savePlayerName(String value);
23: 
24:   Future<void> saveSoundsOn(bool value);
25: }
````

## File: templates/endless_runner/lib/settings/custom_name_dialog.dart
````dart
 1: import 'package:flutter/material.dart';
 2: import 'package:flutter/services.dart';
 3: import 'package:provider/provider.dart';
 4: import 'settings.dart';
 5: 
 6: void showCustomNameDialog(BuildContext context) {
 7:   showGeneralDialog(
 8:       context: context,
 9:       pageBuilder: (context, animation, secondaryAnimation) =>
10:           CustomNameDialog(animation: animation));
11: }
12: 
13: class CustomNameDialog extends StatefulWidget {
14:   final Animation<double> animation;
15: 
16:   const CustomNameDialog({required this.animation, super.key});
17: 
18:   @override
19:   State<CustomNameDialog> createState() => _CustomNameDialogState();
20: }
21: 
22: class _CustomNameDialogState extends State<CustomNameDialog> {
23:   final TextEditingController _controller = TextEditingController();
24: 
25:   @override
26:   Widget build(BuildContext context) {
27:     return ScaleTransition(
28:       scale: CurvedAnimation(
29:         parent: widget.animation,
30:         curve: Curves.easeOutCubic,
31:       ),
32:       child: SimpleDialog(
33:         title: Center(
34:           child: Text(
35:             'Change name',
36:             style: Theme.of(context).textTheme.headlineMedium,
37:           ),
38:         ),
39:         children: [
40:           TextField(
41:             controller: _controller,
42:             autofocus: true,
43:             maxLength: 12,
44:             maxLengthEnforcement: MaxLengthEnforcement.enforced,
45:             style: Theme.of(context).textTheme.bodyMedium,
46:             textAlign: TextAlign.center,
47:             textCapitalization: TextCapitalization.words,
48:             textInputAction: TextInputAction.done,
49:             onChanged: (value) {
50:               context.read<SettingsController>().setPlayerName(value);
51:             },
52:             onSubmitted: (value) {
53:               // Player tapped 'Submit'/'Done' on their keyboard.
54:               Navigator.pop(context);
55:             },
56:           ),
57:           TextButton(
58:             onPressed: () => Navigator.pop(context),
59:             child: Text(
60:               'Close',
61:               style: Theme.of(context).textTheme.bodyMedium,
62:             ),
63:           ),
64:         ],
65:       ),
66:     );
67:   }
68: 
69:   @override
70:   void didChangeDependencies() {
71:     _controller.text = context.read<SettingsController>().playerName.value;
72:     super.didChangeDependencies();
73:   }
74: 
75:   @override
76:   void dispose() {
77:     _controller.dispose();
78:     super.dispose();
79:   }
80: }
````

## File: templates/endless_runner/lib/settings/settings_screen.dart
````dart
  1: import 'package:flutter/material.dart';
  2: import 'package:go_router/go_router.dart';
  3: import 'package:provider/provider.dart';
  4: 
  5: import '../player_progress/player_progress.dart';
  6: import '../style/palette.dart';
  7: import '../style/wobbly_button.dart';
  8: import 'custom_name_dialog.dart';
  9: import 'settings.dart';
 10: 
 11: class SettingsScreen extends StatelessWidget {
 12:   const SettingsScreen({super.key});
 13: 
 14:   static const _gap = SizedBox(height: 60);
 15: 
 16:   @override
 17:   Widget build(BuildContext context) {
 18:     final settings = context.watch<SettingsController>();
 19:     final palette = context.watch<Palette>();
 20: 
 21:     return Scaffold(
 22:       backgroundColor: palette.backgroundSettings.color,
 23:       body: Center(
 24:         child: Column(
 25:           children: [
 26:             Expanded(
 27:               child: ConstrainedBox(
 28:                 constraints: const BoxConstraints(
 29:                   maxWidth: 600,
 30:                 ),
 31:                 child: ListView(
 32:                   children: [
 33:                     _gap,
 34:                     const Text(
 35:                       'Settings',
 36:                       textAlign: TextAlign.center,
 37:                       style: TextStyle(
 38:                         fontFamily: 'Press Start 2P',
 39:                         fontSize: 30,
 40:                         height: 1,
 41:                       ),
 42:                     ),
 43:                     _gap,
 44:                     const _NameChangeLine(
 45:                       'Name',
 46:                     ),
 47:                     ValueListenableBuilder<bool>(
 48:                       valueListenable: settings.soundsOn,
 49:                       builder: (context, soundsOn, child) => _SettingsLine(
 50:                         'Sound FX',
 51:                         Icon(soundsOn ? Icons.graphic_eq : Icons.volume_off),
 52:                         onSelected: () => settings.toggleSoundsOn(),
 53:                       ),
 54:                     ),
 55:                     ValueListenableBuilder<bool>(
 56:                       valueListenable: settings.musicOn,
 57:                       builder: (context, musicOn, child) => _SettingsLine(
 58:                         'Music',
 59:                         Icon(musicOn ? Icons.music_note : Icons.music_off),
 60:                         onSelected: () => settings.toggleMusicOn(),
 61:                       ),
 62:                     ),
 63:                     _SettingsLine(
 64:                       'Reset progress',
 65:                       const Icon(Icons.delete),
 66:                       onSelected: () {
 67:                         context.read<PlayerProgress>().reset();
 68: 
 69:                         final messenger = ScaffoldMessenger.of(context);
 70:                         messenger.showSnackBar(
 71:                           const SnackBar(
 72:                               content: Text('Player progress has been reset.')),
 73:                         );
 74:                       },
 75:                     ),
 76:                   ],
 77:                 ),
 78:               ),
 79:             ),
 80:             _gap,
 81:             WobblyButton(
 82:               onPressed: () {
 83:                 GoRouter.of(context).pop();
 84:               },
 85:               child: const Text('Back'),
 86:             ),
 87:             _gap,
 88:           ],
 89:         ),
 90:       ),
 91:     );
 92:   }
 93: }
 94: 
 95: class _NameChangeLine extends StatelessWidget {
 96:   final String title;
 97: 
 98:   const _NameChangeLine(this.title);
 99: 
100:   @override
101:   Widget build(BuildContext context) {
102:     final settings = context.watch<SettingsController>();
103: 
104:     return InkResponse(
105:       highlightShape: BoxShape.rectangle,
106:       onTap: () => showCustomNameDialog(context),
107:       child: Padding(
108:         padding: const EdgeInsets.symmetric(horizontal: 8),
109:         child: Row(
110:           mainAxisAlignment: MainAxisAlignment.center,
111:           children: [
112:             Text(title,
113:                 style: const TextStyle(
114:                   fontFamily: 'Press Start 2P',
115:                   fontSize: 20,
116:                 )),
117:             const Spacer(),
118:             ValueListenableBuilder(
119:               valueListenable: settings.playerName,
120:               builder: (context, name, child) => Text(
121:                 '‘$name’',
122:                 style: const TextStyle(
123:                   fontFamily: 'Press Start 2P',
124:                   fontSize: 20,
125:                 ),
126:               ),
127:             ),
128:           ],
129:         ),
130:       ),
131:     );
132:   }
133: }
134: 
135: class _SettingsLine extends StatelessWidget {
136:   final String title;
137: 
138:   final Widget icon;
139: 
140:   final VoidCallback? onSelected;
141: 
142:   const _SettingsLine(this.title, this.icon, {this.onSelected});
143: 
144:   @override
145:   Widget build(BuildContext context) {
146:     return InkResponse(
147:       highlightShape: BoxShape.rectangle,
148:       onTap: onSelected,
149:       child: Padding(
150:         padding: const EdgeInsets.symmetric(horizontal: 8),
151:         child: Row(
152:           mainAxisAlignment: MainAxisAlignment.start,
153:           children: [
154:             Expanded(
155:               child: Text(
156:                 title,
157:                 maxLines: 1,
158:                 overflow: TextOverflow.ellipsis,
159:                 style: const TextStyle(
160:                   fontFamily: 'Press Start 2P',
161:                   fontSize: 20,
162:                 ),
163:               ),
164:             ),
165:             icon,
166:           ],
167:         ),
168:       ),
169:     );
170:   }
171: }
````

## File: templates/endless_runner/lib/settings/settings.dart
````dart
 1: // Copyright 2022, the Flutter project authors. Please see the AUTHORS file
 2: // for details. All rights reserved. Use of this source code is governed by a
 3: // BSD-style license that can be found in the LICENSE file.
 4: 
 5: import 'package:flutter/foundation.dart';
 6: import 'package:logging/logging.dart';
 7: 
 8: import 'persistence/local_storage_settings_persistence.dart';
 9: import 'persistence/settings_persistence.dart';
10: 
11: /// An class that holds settings like [playerName] or [musicOn],
12: /// and saves them to an injected persistence store.
13: class SettingsController {
14:   static final _log = Logger('SettingsController');
15: 
16:   /// The persistence store that is used to save settings.
17:   final SettingsPersistence _store;
18: 
19:   /// Whether or not the audio is on at all. This overrides both music
20:   /// and sounds (sfx).
21:   ///
22:   /// This is an important feature especially on mobile, where players
23:   /// expect to be able to quickly mute all the audio. Having this as
24:   /// a separate flag (as opposed to some kind of {off, sound, everything}
25:   /// enum) means that the player will not lose their [soundsOn] and
26:   /// [musicOn] preferences when they temporarily mute the game.
27:   ValueNotifier<bool> audioOn = ValueNotifier(true);
28: 
29:   /// The player's name. Used for things like high score lists.
30:   ValueNotifier<String> playerName = ValueNotifier('Player');
31: 
32:   /// Whether or not the sound effects (sfx) are on.
33:   ValueNotifier<bool> soundsOn = ValueNotifier(true);
34: 
35:   /// Whether or not the music is on.
36:   ValueNotifier<bool> musicOn = ValueNotifier(true);
37: 
38:   /// Creates a new instance of [SettingsController] backed by [store].
39:   ///
40:   /// By default, settings are persisted using [LocalStorageSettingsPersistence]
41:   /// (i.e. NSUserDefaults on iOS, SharedPreferences on Android or
42:   /// local storage on the web).
43:   SettingsController({SettingsPersistence? store})
44:       : _store = store ?? LocalStorageSettingsPersistence() {
45:     _loadStateFromPersistence();
46:   }
47: 
48:   void setPlayerName(String name) {
49:     playerName.value = name;
50:     _store.savePlayerName(playerName.value);
51:   }
52: 
53:   void toggleAudioOn() {
54:     audioOn.value = !audioOn.value;
55:     _store.saveAudioOn(audioOn.value);
56:   }
57: 
58:   void toggleMusicOn() {
59:     musicOn.value = !musicOn.value;
60:     _store.saveMusicOn(musicOn.value);
61:   }
62: 
63:   void toggleSoundsOn() {
64:     soundsOn.value = !soundsOn.value;
65:     _store.saveSoundsOn(soundsOn.value);
66:   }
67: 
68:   /// Asynchronously loads values from the injected persistence store.
69:   Future<void> _loadStateFromPersistence() async {
70:     final loadedValues = await Future.wait([
71:       _store.getAudioOn(defaultValue: true).then((value) {
72:         if (kIsWeb) {
73:           // On the web, sound can only start after user interaction, so
74:           // we start muted there on every game start.
75:           return audioOn.value = false;
76:         }
77:         // On other platforms, we can use the persisted value.
78:         return audioOn.value = value;
79:       }),
80:       _store
81:           .getSoundsOn(defaultValue: true)
82:           .then((value) => soundsOn.value = value),
83:       _store
84:           .getMusicOn(defaultValue: true)
85:           .then((value) => musicOn.value = value),
86:       _store.getPlayerName().then((value) => playerName.value = value),
87:     ]);
88: 
89:     _log.fine(() => 'Loaded settings: $loadedValues');
90:   }
91: }
````

## File: templates/endless_runner/lib/style/page_transition.dart
````dart
 1: import 'package:flutter/material.dart';
 2: import 'package:go_router/go_router.dart';
 3: 
 4: CustomTransitionPage<T> buildPageTransition<T>({
 5:   required Widget child,
 6:   required Color color,
 7:   String? name,
 8:   Object? arguments,
 9:   String? restorationId,
10:   LocalKey? key,
11: }) {
12:   return CustomTransitionPage<T>(
13:     child: child,
14:     transitionsBuilder: (context, animation, secondaryAnimation, child) {
15:       return _PageReveal(
16:         animation: animation,
17:         color: color,
18:         child: child,
19:       );
20:     },
21:     key: key,
22:     name: name,
23:     arguments: arguments,
24:     restorationId: restorationId,
25:     transitionDuration: const Duration(milliseconds: 700),
26:   );
27: }
28: 
29: class _PageReveal extends StatelessWidget {
30:   final Widget child;
31: 
32:   final Animation<double> animation;
33: 
34:   final Color color;
35: 
36:   final _slideTween = Tween(begin: const Offset(0, -1), end: Offset.zero);
37: 
38:   final _fadeTween = TweenSequence([
39:     TweenSequenceItem(tween: ConstantTween(0.0), weight: 1),
40:     TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0), weight: 1),
41:   ]);
42: 
43:   _PageReveal({
44:     required this.child,
45:     required this.animation,
46:     required this.color,
47:   });
48: 
49:   @override
50:   Widget build(BuildContext context) {
51:     return Stack(
52:       fit: StackFit.expand,
53:       children: [
54:         SlideTransition(
55:           position: _slideTween.animate(
56:             CurvedAnimation(
57:               parent: animation,
58:               curve: Curves.easeOutCubic,
59:               reverseCurve: Curves.easeOutCubic,
60:             ),
61:           ),
62:           child: Container(
63:             color: color,
64:           ),
65:         ),
66:         FadeTransition(
67:           opacity: _fadeTween.animate(animation),
68:           child: child,
69:         ),
70:       ],
71:     );
72:   }
73: }
````

## File: templates/endless_runner/lib/style/palette.dart
````dart
 1: import 'package:flame/palette.dart';
 2: 
 3: /// A palette of colors to be used in the game.
 4: ///
 5: /// The reason we're not going with something like Material Design's
 6: /// `Theme` is simply that this is simpler to work with and yet gives
 7: /// us everything we need for a game.
 8: ///
 9: /// Games generally have more radical color palettes than apps. For example,
10: /// every level of a game can have radically different colors.
11: /// At the same time, games rarely support dark mode.
12: ///
13: /// Colors here are implemented as getters so that hot reloading works.
14: /// In practice, we could just as easily implement the colors
15: /// as `static const`. But this way the palette is more malleable:
16: /// we could allow players to customize colors, for example,
17: /// or even get the colors from the network.
18: class Palette {
19:   PaletteEntry get seed => const PaletteEntry(Color(0xFF0050bc));
20:   PaletteEntry get text => const PaletteEntry(Color(0xee352b42));
21:   PaletteEntry get backgroundMain => const PaletteEntry(Color(0xffa2fff3));
22:   PaletteEntry get backgroundLevelSelection =>
23:       const PaletteEntry(Color(0xffffcd75));
24:   PaletteEntry get backgroundPlaySession =>
25:       const PaletteEntry(Color(0xffa2fff3));
26:   PaletteEntry get backgroundSettings => const PaletteEntry(Color(0xffbfc8e3));
27: }
````

## File: templates/endless_runner/lib/style/responsive_screen.dart
````dart
  1: import 'package:flutter/material.dart';
  2: 
  3: /// A widget that makes it easy to create a screen with a square-ish
  4: /// main area, a smaller menu area, and a small area for a message on top.
  5: /// It works in both orientations on mobile- and tablet-sized screens.
  6: class ResponsiveScreen extends StatelessWidget {
  7:   /// This is the "hero" of the screen. It's more or less square, and will
  8:   /// be placed in the visual "center" of the screen.
  9:   final Widget squarishMainArea;
 10: 
 11:   /// The second-largest area after [squarishMainArea]. It can be narrow
 12:   /// or wide.
 13:   final Widget rectangularMenuArea;
 14: 
 15:   /// An area reserved for some static text close to the top of the screen.
 16:   final Widget topMessageArea;
 17: 
 18:   const ResponsiveScreen({
 19:     required this.squarishMainArea,
 20:     required this.rectangularMenuArea,
 21:     this.topMessageArea = const SizedBox.shrink(),
 22:     super.key,
 23:   });
 24: 
 25:   @override
 26:   Widget build(BuildContext context) {
 27:     return LayoutBuilder(
 28:       builder: (context, constraints) {
 29:         // This widget wants to fill the whole screen.
 30:         final size = constraints.biggest;
 31:         final padding = EdgeInsets.all(size.shortestSide / 30);
 32: 
 33:         if (size.height >= size.width) {
 34:           // "Portrait" / "mobile" mode.
 35:           return Column(
 36:             crossAxisAlignment: CrossAxisAlignment.stretch,
 37:             children: [
 38:               SafeArea(
 39:                 bottom: false,
 40:                 child: Padding(
 41:                   padding: padding,
 42:                   child: topMessageArea,
 43:                 ),
 44:               ),
 45:               Expanded(
 46:                 child: SafeArea(
 47:                   top: false,
 48:                   bottom: false,
 49:                   minimum: padding,
 50:                   child: squarishMainArea,
 51:                 ),
 52:               ),
 53:               SafeArea(
 54:                 top: false,
 55:                 maintainBottomViewPadding: true,
 56:                 child: Padding(
 57:                   padding: padding,
 58:                   child: Center(
 59:                     child: rectangularMenuArea,
 60:                   ),
 61:                 ),
 62:               ),
 63:             ],
 64:           );
 65:         } else {
 66:           return Row(
 67:             crossAxisAlignment: CrossAxisAlignment.stretch,
 68:             children: [
 69:               Expanded(
 70:                 flex: 4,
 71:                 child: SafeArea(
 72:                   right: false,
 73:                   maintainBottomViewPadding: true,
 74:                   minimum: padding,
 75:                   child: squarishMainArea,
 76:                 ),
 77:               ),
 78:               Expanded(
 79:                 flex: 3,
 80:                 child: Column(
 81:                   children: [
 82:                     SafeArea(
 83:                       bottom: false,
 84:                       left: false,
 85:                       maintainBottomViewPadding: true,
 86:                       child: Padding(
 87:                         padding: padding,
 88:                         child: topMessageArea,
 89:                       ),
 90:                     ),
 91:                     Expanded(
 92:                       child: SafeArea(
 93:                         top: false,
 94:                         left: false,
 95:                         maintainBottomViewPadding: true,
 96:                         child: Align(
 97:                           alignment: Alignment.bottomCenter,
 98:                           child: Padding(
 99:                             padding: padding,
100:                             child: rectangularMenuArea,
101:                           ),
102:                         ),
103:                       ),
104:                     )
105:                   ],
106:                 ),
107:               ),
108:             ],
109:           );
110:         }
111:       },
112:     );
113:   }
114: }
````

## File: templates/endless_runner/lib/style/wobbly_button.dart
````dart
 1: import 'dart:math';
 2: 
 3: import 'package:flutter/material.dart';
 4: import 'package:nes_ui/nes_ui.dart';
 5: 
 6: class WobblyButton extends StatefulWidget {
 7:   final Widget child;
 8: 
 9:   final VoidCallback? onPressed;
10: 
11:   const WobblyButton({super.key, required this.child, this.onPressed});
12: 
13:   @override
14:   State<WobblyButton> createState() => _WobblyButtonState();
15: }
16: 
17: class _WobblyButtonState extends State<WobblyButton>
18:     with SingleTickerProviderStateMixin {
19:   late final AnimationController _controller = AnimationController(
20:     duration: const Duration(milliseconds: 300),
21:     vsync: this,
22:   );
23: 
24:   @override
25:   void dispose() {
26:     _controller.dispose();
27:     super.dispose();
28:   }
29: 
30:   @override
31:   Widget build(BuildContext context) {
32:     return MouseRegion(
33:       onEnter: (event) {
34:         _controller.repeat();
35:       },
36:       onExit: (event) {
37:         _controller.stop(canceled: false);
38:       },
39:       child: RotationTransition(
40:         turns: _controller.drive(const _MySineTween(0.005)),
41:         child: NesButton(
42:           type: NesButtonType.primary,
43:           onPressed: widget.onPressed,
44:           child: DefaultTextStyle(
45:             style: Theme.of(context).textTheme.bodyMedium ?? const TextStyle(),
46:             child: widget.child,
47:           ),
48:         ),
49:       ),
50:     );
51:   }
52: }
53: 
54: class _MySineTween extends Animatable<double> {
55:   final double maxExtent;
56: 
57:   const _MySineTween(this.maxExtent);
58: 
59:   @override
60:   double transform(double t) {
61:     return sin(t * 2 * pi) * maxExtent;
62:   }
63: }
````

## File: templates/endless_runner/lib/main.dart
````dart
 1: import 'package:flame/flame.dart';
 2: import 'package:flutter/material.dart';
 3: import 'package:google_fonts/google_fonts.dart';
 4: import 'package:nes_ui/nes_ui.dart';
 5: import 'package:provider/provider.dart';
 6: 
 7: import 'app_lifecycle/app_lifecycle.dart';
 8: import 'audio/audio_controller.dart';
 9: import 'player_progress/player_progress.dart';
10: import 'router.dart';
11: import 'settings/settings.dart';
12: import 'style/palette.dart';
13: 
14: void main() async {
15:   WidgetsFlutterBinding.ensureInitialized();
16:   await Flame.device.setLandscape();
17:   await Flame.device.fullScreen();
18:   runApp(const MyGame());
19: }
20: 
21: class MyGame extends StatelessWidget {
22:   const MyGame({super.key});
23: 
24:   @override
25:   Widget build(BuildContext context) {
26:     return AppLifecycleObserver(
27:       child: MultiProvider(
28:         providers: [
29:           Provider(create: (context) => Palette()),
30:           ChangeNotifierProvider(create: (context) => PlayerProgress()),
31:           Provider(create: (context) => SettingsController()),
32:           // Set up audio.
33:           ProxyProvider2<SettingsController, AppLifecycleStateNotifier,
34:               AudioController>(
35:             // Ensures that music starts immediately.
36:             lazy: false,
37:             create: (context) => AudioController(),
38:             update: (context, settings, lifecycleNotifier, audio) {
39:               audio!.attachDependencies(lifecycleNotifier, settings);
40:               return audio;
41:             },
42:             dispose: (context, audio) => audio.dispose(),
43:           ),
44:         ],
45:         child: Builder(builder: (context) {
46:           final palette = context.watch<Palette>();
47: 
48:           return MaterialApp.router(
49:             title: 'Endless Runner',
50:             theme: flutterNesTheme().copyWith(
51:               colorScheme: ColorScheme.fromSeed(
52:                 seedColor: palette.seed.color,
53:                 surface: palette.backgroundMain.color,
54:               ),
55:               textTheme: GoogleFonts.pressStart2pTextTheme().apply(
56:                 bodyColor: palette.text.color,
57:                 displayColor: palette.text.color,
58:               ),
59:             ),
60:             routerConfig: router,
61:           );
62:         }),
63:       ),
64:     );
65:   }
66: }
````

## File: templates/endless_runner/lib/router.dart
````dart
 1: import 'package:flutter/foundation.dart';
 2: import 'package:go_router/go_router.dart';
 3: import 'package:provider/provider.dart';
 4: 
 5: import 'flame_game/game_screen.dart';
 6: import 'level_selection/level_selection_screen.dart';
 7: import 'level_selection/levels.dart';
 8: import 'main_menu/main_menu_screen.dart';
 9: import 'settings/settings_screen.dart';
10: import 'style/page_transition.dart';
11: import 'style/palette.dart';
12: 
13: /// The router describes the game's navigational hierarchy, from the main
14: /// screen through settings screens all the way to each individual level.
15: final router = GoRouter(
16:   routes: [
17:     GoRoute(
18:       path: '/',
19:       builder: (context, state) => const MainMenuScreen(key: Key('main menu')),
20:       routes: [
21:         GoRoute(
22:           path: 'play',
23:           pageBuilder: (context, state) => buildPageTransition<void>(
24:             key: const ValueKey('play'),
25:             color: context.watch<Palette>().backgroundLevelSelection.color,
26:             child: const LevelSelectionScreen(
27:               key: Key('level selection'),
28:             ),
29:           ),
30:           routes: [
31:             GoRoute(
32:               path: 'session/:level',
33:               pageBuilder: (context, state) {
34:                 final levelNumber = int.parse(state.pathParameters['level']!);
35:                 final level = gameLevels[levelNumber - 1];
36:                 return buildPageTransition<void>(
37:                   key: const ValueKey('level'),
38:                   color: context.watch<Palette>().backgroundPlaySession.color,
39:                   child: GameScreen(level: level),
40:                 );
41:               },
42:             ),
43:           ],
44:         ),
45:         GoRoute(
46:           path: 'settings',
47:           builder: (context, state) => const SettingsScreen(
48:             key: Key('settings'),
49:           ),
50:         ),
51:       ],
52:     ),
53:   ],
54: );
````

## File: templates/endless_runner/test/smoke_test.dart
````dart
 1: import 'package:endless_runner/app_lifecycle/app_lifecycle.dart';
 2: import 'package:endless_runner/audio/audio_controller.dart';
 3: import 'package:endless_runner/audio/sounds.dart';
 4: import 'package:endless_runner/flame_game/endless_runner.dart';
 5: import 'package:endless_runner/flame_game/game_screen.dart';
 6: import 'package:endless_runner/main.dart';
 7: import 'package:endless_runner/player_progress/persistence/memory_player_progress_persistence.dart';
 8: import 'package:endless_runner/player_progress/player_progress.dart';
 9: import 'package:endless_runner/settings/settings.dart';
10: import 'package:flame_test/flame_test.dart';
11: import 'package:flutter/widgets.dart';
12: import 'package:flutter_test/flutter_test.dart';
13: 
14: void main() {
15:   testWidgets('smoke test menus', (tester) async {
16:     // Build our game and trigger a frame.
17:     await tester.pumpWidget(const MyGame());
18: 
19:     // Verify that the 'Play' button is shown.
20:     expect(find.text('Play'), findsOneWidget);
21: 
22:     // Verify that the 'Settings' button is shown.
23:     expect(find.text('Settings'), findsOneWidget);
24: 
25:     // Go to 'Settings'.
26:     await tester.tap(find.text('Settings'));
27:     await tester.pumpAndSettle();
28:     expect(find.text('Music'), findsOneWidget);
29: 
30:     // Go back to main menu.
31:     await tester.tap(find.text('Back'));
32:     await tester.pumpAndSettle();
33: 
34:     // Tap 'Play'.
35:     await tester.tap(find.text('Play'));
36:     await tester.pumpAndSettle();
37:     expect(find.text('Select level'), findsOneWidget);
38: 
39:     // Tap level 1.
40:     await tester.tap(find.text('Level #1'));
41:     await tester.pump();
42:   });
43: 
44:   testWithGame(
45:     'smoke test flame game',
46:     () {
47:       return EndlessRunner(
48:         level: (
49:           number: 1,
50:           winScore: 3,
51:           canSpawnTall: false,
52:         ),
53:         playerProgress: PlayerProgress(
54:           store: MemoryOnlyPlayerProgressPersistence(),
55:         ),
56:         audioController: _MockAudioController(),
57:       );
58:     },
59:     (game) async {
60:       game.overlays.addEntry(
61:         GameScreen.backButtonKey,
62:         (context, game) => Container(),
63:       );
64:       game.overlays.addEntry(
65:         GameScreen.winDialogKey,
66:         (context, game) => Container(),
67:       );
68:       await game.onLoad();
69:       game.update(0);
70:       expect(game.children.length, 3);
71:       expect(game.world.children.length, 2);
72:       expect(game.camera.viewport.children.length, 2);
73:       expect(game.world.player.isLoading, isTrue);
74:     },
75:   );
76: }
77: 
78: class _MockAudioController implements AudioController {
79:   @override
80:   void attachDependencies(AppLifecycleStateNotifier lifecycleNotifier,
81:       SettingsController settingsController) {}
82: 
83:   @override
84:   void dispose() {}
85: 
86:   @override
87:   void playSfx(SfxType type) {}
88: }
````

## File: templates/endless_runner/analysis_options.yaml
````yaml
1: include: package:flutter_lints/flutter.yaml
2: 
3: analyzer:
4:   language:
5:     strict-casts: true
````

## File: templates/endless_runner/pubspec.yaml
````yaml
 1: name: endless_runner
 2: description: A Flame game template built with Flutter.
 3: 
 4: # Prevent accidental publishing to pub.dev.
 5: publish_to: 'none'
 6: 
 7: version: 0.1.0
 8: 
 9: environment:
10:   sdk: ^3.5.0
11: 
12: dependencies:
13:   flame: ^1.18.0
14:   flutter:
15:     sdk: flutter
16: 
17:   audioplayers: ^6.0.0
18:   flame_audio: ^2.10.2
19:   go_router: ^14.2.0
20:   provider: ^6.1.2
21:   shared_preferences: ^2.2.3
22:   nes_ui: ^0.20.0
23:   google_fonts: ^6.2.0
24:   logging: ^1.2.0
25: 
26: dev_dependencies:
27:   flame_test: ^1.16.2
28:   flutter_lints: ^5.0.0
29:   flutter_test:
30:     sdk: flutter
31:   flutter_launcher_icons: ^0.13.1
32:   test: ^1.25.0
33: 
34: flutter:
35:   uses-material-design: true
36: 
37:   assets:
38:     - assets/images/
39:     - assets/images/dash/
40:     - assets/images/enemies/
41:     - assets/images/scenery/
42:     - assets/music/
43:     - assets/sfx/
44: 
45:   fonts:
46:     - family: Press Start 2P
47:       fonts:
48:         - asset: assets/fonts/Press_Start_2P/PressStart2P-Regular.ttf
49: 
50: flutter_launcher_icons:
51:   android: true
52:   ios: true
53:   image_path: "assets/icons/icon.png"
````

## File: templates/endless_runner/README.md
````markdown
  1: # Endless Runner Template
  2: 
  3: This is a starter Flutter and Flame project with an endless runner game built
  4: in Flutter & Flame, it includes the following features:
  5: 
  6: Flutter features:
  7: - A `FlameGame` base
  8: - Main menu screen
  9: - Basic navigation
 10: - Game-y theming
 11: - Settings
 12: - Sound
 13: 
 14: Flame features:
 15: - Player steering
 16: - Collision detection
 17: - Parallax
 18: - Effects
 19: - Spawns
 20: 
 21: You can jump directly into building your game in `lib/flame_game/`.
 22: 
 23: When you're ready for things like ads, in-app purchases, achievements,
 24: analytics, crash reporting, and so on, there are resources ready for you
 25: at [flutter.dev/games](https://flutter.dev/games).
 26: 
 27: 
 28: ## How to get this sample
 29: 
 30: You can clone this whole repository and find this sample in your local copy.
 31: 
 32: For convenience, though, we also provide a command line tool that downloads
 33: just the project you want.
 34: 
 35: On the command line, while having the
 36: [Flutter SDK installed](https://docs.flutter.dev/get-started/install),
 37: run the following command:
 38: 
 39: ```shell
 40: dart pub global activate sample_downloader
 41: ```
 42: 
 43: Then, from any directory, run the newly installed tool
 44: and follow its instructions.
 45: 
 46: ```shell
 47: sample_downloader
 48: ```
 49: 
 50: 
 51: # Getting started
 52: 
 53: Clone this project and run the following command in its root directory:
 54: 
 55: ```terminal
 56: flutter create . --project-name endless_runner
 57: ```
 58: 
 59: This will create the necessary platform files, such as `ios/`, `android/`,
 60: `web/`, `macos/`, `linux/` or `windows/`, depending on your installation of Flutter.
 61: 
 62: After this, the game compiles and works out of the box. It comes with things
 63: like a main menu, a router, a settings screen, and audio.
 64: When building a new game, this is likely everything you first need.
 65: 
 66: When you're ready to enable more advanced integrations, like ads
 67: and in-app payments, read the _Integrations_ section below.
 68: 
 69: 
 70: # Development
 71: 
 72: Usually you will open the template in your favorite IDE, like Android Studio
 73: or Visual Studio Code, and from there you will be able to run the game in debug
 74: mode directly. Usually by pressing a green play button.
 75: 
 76: To run the game in debug mode directly from the terminal you can do:
 77: 
 78:     flutter run
 79: 
 80: This assumes you have an Android emulator, iOS Simulator, or an attached
 81: physical device.
 82: 
 83: It is often convenient to develop your game as a desktop app.
 84: For example, you can run `flutter run -d macOS`, and get the same UI
 85: in a desktop window on a Mac. That way, you don't need to use a
 86: simulator/emulator or attach a mobile device. This template supports
 87: desktop development by disabling integrations like AdMob for desktop.
 88: 
 89: 
 90: ## Code organization
 91: 
 92: Code is organized in a loose and shallow feature-first fashion.
 93: In `lib/`, you'll therefore find directories such as `audio`, `main_menu`
 94: or `settings`. Nothing fancy, but usable.
 95: 
 96: ```
 97: lib
 98: ├── app_lifecycle
 99: ├── audio
100: ├── flame_game
101: ├── level_selection
102: ├── main_menu
103: ├── player_progress
104: ├── settings
105: ├── style
106: └── main.dart
107: └── router.dart
108: ```
109: 
110: The state management approach is intentionally low-level. That way, it's easy to
111: take this project and run with it, without having to learn new paradigms, or having
112: to remember to run `flutter pub run build_runner watch`. You are,
113: of course, encouraged to use whatever paradigm, helper package or code generation
114: scheme that you prefer.
115: 
116: 
117: ## Building for production
118: 
119: To build the app for iOS (and open Xcode when finished):
120: 
121: ```shell
122: flutter build ipa && open build/ios/archive/Runner.xcarchive
123: ```
124: 
125: To build the app for Android (and open the folder with the bundle when finished):
126: 
127: ```shell
128: flutter build appbundle && open build/app/outputs/bundle/release
129: ```
130: 
131: While the template is primarily meant for mobile games, you can also publish
132: for the web. This might be useful for web-based demos, for example,
133: or for rapid play-testing. The following command requires installing
134: [`peanut`](https://pub.dev/packages/peanut/install).
135: 
136: ```bash
137: flutter pub global run peanut \
138: --web-renderer canvaskit \
139: --extra-args "--base-href=/name_of_your_github_repo/" \
140: && git push origin --set-upstream gh-pages
141: ```
142: 
143: The last line of the command above automatically pushes
144: your newly built web game to GitHub pages, assuming that you have
145: that set up.
146: 
147: Lastly, it is of course possible to build your game for desktop platforms:
148: Windows, Linux and macOS.
149: Follow the [standard instructions](https://docs.flutter.dev/platform-integration/desktop).
150: 
151: 
152: # Integrations
153: 
154: Focus on making your core gameplay fun first. Don't worry about
155: integrations like ads, in-app purchases, analytics, and so on.
156: It's easy to add them later, and you can find recipes and codelabs
157: for them at [flutter.dev/games](https://flutter.dev/games).
158: 
159: Change the package name of your game
160: before you start any of the deeper integrations.
161: [StackOverflow has instructions](https://stackoverflow.com/a/51550358/1416886)
162: for this, and the [`rename`](https://pub.dev/packages/rename) tool
163: (on pub.dev) automates the process.
164: 
165: 
166: ## Audio
167: 
168: Audio is enabled by default and ready to go. You can modify code
169: in `lib/audio/` to your liking.
170: 
171: You can find some music
172: tracks in `assets/music` — these are Creative Commons Attribution (CC-BY)
173: licensed, and are included in this repository with permission. If you decide
174: to keep these tracks in your game, please don't forget to give credit
175: to the musician, [Mr Smith][].
176: 
177: [Mr Smith]: https://freemusicarchive.org/music/mr-smith
178: 
179: The repository also includes a few sound effect samples in `assets/sfx`.
180: These are public domain (CC0) and you will almost surely want to replace
181: them because they're just recordings of a developer doing silly sounds
182: with their mouth.
183: 
184: 
185: ## Logging
186: 
187: The template uses the [`logging`](https://pub.dev/packages/logging) package
188: to log messages to the console. This makes it very easy to log messages
189: from anywhere with something like the following:
190: 
191: ```dart
192: import 'package:logging/logging.dart';
193: 
194: final _log = Logger('Foo');
195: 
196: void foo() {
197:   _log.info('Hello, world!');
198: }
199: ```
200: 
201: This will show up in the console as:
202: 
203: ```text
204: [Foo] Hello, world!
205: ```
206: 
207: When using Flutter DevTools, all the metadata of the log message is preserved,
208: so you can filter by logger name, log level, and so on.
209: 
210: Later, when you're closer to production, you can gather these log messages
211: (see `lib/main.dart`) and send them to a service like Firebase Crashlytics
212: when appropriate.
213: See [`firebase_crashlytics`](https://pub.dev/packages/firebase_crashlytics)
214: for more information.
215: 
216: 
217: ## Settings
218: 
219: The settings page is enabled by default, and accessible both
220: from the main menu and through the "gear" button in the play session screen.
221: 
222: Settings are saved to local storage using the
223: [`shared_preferences`](https://pub.dev/packages/shared_preferences)
224: package.
225: To change what preferences are saved and how, edit files in
226: `lib/settings/persistence`.
227: 
228: 
229: # Icon
230: 
231: To update the launcher icon, first change the files
232: `assets/icon-adaptive-foreground.png` and `assets/icon.png`.
233: Then, run the following:
234: 
235: ```bash
236: flutter pub run flutter_launcher_icons:main
237: ```
238: 
239: You can [configure](https://github.com/fluttercommunity/flutter_launcher_icons#book-guide)
240: the look of the icon in the `flutter_icons:` section of `pubspec.yaml`.
241: 
242: 
243: # Troubleshooting
244: 
245: ## CocoaPods
246: 
247: When upgrading to higher versions of Flutter or plugins, you might encounter an error when
248: building the iOS or macOS app. A good first thing to try is to delete the `ios/Podfile.lock`
249: file (or `macos/Podfile.lock`, respectively), then trying to build again. (You can achieve
250: a more thorough cleanup by running `flutter clean` instead.)
251: 
252: If this doesn't help, here are some more methods:
253: 
254: - See if everything is still okay with your Flutter and CocoaPods installation
255:   by running `flutter doctor`. Revisit the macOS
256:   [Flutter installation guide](https://docs.flutter.dev/get-started/install/macos)
257:   if needed.
258: - Update CocoaPods specs directory:
259: 
260:   ```sh
261:   cd ios
262:   pod repo update
263:   cd ..
264:   ```
265: 
266:   (Substitute `ios` for `macos` when appropriate.)
267: - Open the project in Xcode,
268:   [increase the build target](https://stackoverflow.com/a/38602597/1416886),
269:   then select _Product_ > _Clean Build Folder_.
270: 
271: ## Warnings in console
272: 
273: When running the game for the first time, you might see warnings like the following:
274: 
275: > Note: Some input files use or override a deprecated API.
276: 
277: or
278: 
279: > warning: 'viewState' was deprecated in macOS 11.0: Use -initWithState: instead
280: 
281: These warning come from the various plugins that are used by the template. They are not harmful
282: and can be ignored. The warnings are meant for the plugin authors, not for you, the game developer.
````

## File: CONTRIBUTING.md
````markdown
  1: # Contributing
  2: 
  3: _See also: [Flutter's code of conduct](https://github.com/flutter/flutter/blob/master/CODE_OF_CONDUCT.md)_
  4: 
  5: Want to contribute to the Flutter games sample ecosystem? Great! First, read this
  6: page (including the small print at the end).
  7: 
  8: ## Is this the right place for your contribution?
  9: 
 10: This repo is used by members of the Flutter team and a few partners as a place
 11: to store example games and game templates. It's not meant to be the one and only
 12: source of truth for Flutter game samples or the only place people go to learn
 13: about the best ways to build games with Flutter. What that means in practice 
 14: is that if you've written a great example game, it doesn't need to be maintained
 15: here in order to get noticed, be of help to new Flutter devs, and have an impact
 16: on the community.
 17: 
 18: You can maintain your sample app in your own repo (or with another source
 19: control provider) and still be as important a part of the Flutter-verse as
 20: anything you see here. You can let us know on the
 21: [FlutterDev Google Group](https://groups.google.com/forum/#!forum/flutter-dev)
 22: when you've published something and post about it with the
 23: `#FlutterDev` hashtag.
 24: 
 25: ## So what should be contributed here, then?
 26: 
 27: Fixes and necessary improvements to the existing samples, mostly.
 28: 
 29: ## Before you contribute
 30: 
 31: ### File an issue first!
 32: 
 33: If you see a bug or have an idea for a feature that you feel would improve one
 34: of the samples already in the repo, **please
 35: [file an issue](https://github.com/flutter/games/issues/new) before you begin
 36: coding or send a PR**. This will help prevent duplicate work by letting us know
 37: what you're up to. It will help avoid a situation in which you spend a lot of
 38: time coding something that's not quite right for the repo or its goals.
 39: 
 40: ### Sign the license agreement.
 41: 
 42: Before we can use your code, you must sign the
 43: [Google Individual Contributor License Agreement](https://cla.developers.google.com/about/google-individual)
 44: (CLA), which you can do online. The CLA is necessary mainly because you own the
 45: copyright to your changes, even after your contribution becomes part of our
 46: codebase, so we need your permission to use and distribute your code. We also
 47: need to be sure of various other things—for instance that you'll tell us if you
 48: know that your code infringes on other people's patents. You don't have to sign
 49: the CLA until after you've submitted your code for review and a member has
 50: approved it, but you must do it before we can put your code into our codebase.
 51: 
 52: Before you start working on a larger contribution, you should get in touch with
 53: us first through the issue tracker with your idea so that we can help out and
 54: possibly guide you. Coordinating up front makes it much easier to avoid
 55: frustration later on.
 56: 
 57: ## A few ground rules
 58: 
 59: This is a monorepo containing a bunch of projects. While different codebases have
 60: different needs, there are a few basic conventions that every project here is
 61: expected to follow. All of them are based on our experience over the last
 62: couple years keeping similar repos tidy and running smooth.
 63: 
 64: Each app should:
 65: 
 66: * Be designed to build against the current
 67:   [stable](https://github.com/flutter/flutter/blob/master/docs/releases/Flutter-build-release-channels.md)
 68:   release of the Flutter SDK.
 69: * Include the top level
 70:   [`analysis_options.yaml`](analysis_options.yaml)
 71:   file used throughout the repo. This file include a base set of analyzer
 72:   conventions and lints.
 73: * Have no analyzer errors or warnings.
 74: * Be formatted with `dart format`.
 75: * Include at least one working test in its `test` folder.
 76: * Be wired into the list of projects in the CI scripts for [stable](tool/flutter_ci_script_stable.sh), 
 77:   [beta](tool/flutter_ci_script_beta.sh), and [master](tool/flutter_ci_script_master.sh), 
 78:   which runs the analyzer, the formatter, and `flutter test`.
 79: * Add the new project directory to the [dependabot](.github/dependabot.yaml) configuration
 80:   to keep dependencies updated in an on-going basis.
 81: * Avoid adding an onerous amount of blobs (typically images or other assets) to
 82:   the repo.
 83: 
 84: In addition, sample code is, at the end of the day, still code. It should be
 85: written with at least as much care as the Flutter code you'd find in the SDK
 86: itself. For that reason, most of the
 87: [Flutter style guide](https://github.com/flutter/flutter/blob/master/docs/contributing/Style-guide-for-Flutter-repo.md)
 88: also applies to code in this repo.
 89: 
 90: ## Code reviews
 91: 
 92: All submissions, including submissions by project members, require review.
 93: 
 94: This repo is part of the [Flutter](https://github.com/flutter) GitHub account,
 95: which means that a lot of folks have the ability to push and merge code. The
 96: primary maintainers, though, are:
 97: 
 98: * [@filiph](https://github.com/filiph)
 99: * [@domesticmouse](https://github.com/domesticmouse)
100: 
101: You are free to add one of these folks as a reviewer
102: to any PR sent to this repo. We're happy to comment, answer (or ask) questions,
103: and provide feedback.
104: 
105: If you're part of a team that's already landed a sample in the repo, 
106: and you're updating or fixing that sample, you are *not* expected to
107: wait on one of the above folks before merging the code. Have it reviewed by
108: someone you trust on your own team, and then merge it.
109: 
110: However, if you're adding a new sample, updating a sample you've never worked on
111: before, or changing something that's a meta-concern like the CI setup, web
112: hosting, project setup, etc., please include one of the primary maintainers as a
113: reviewer.
114: 
115: ## File headers
116: 
117: All files in the project must start with the following header.
118: 
119: ```
120: // Copyright 2023 The Flutter team. All rights reserved.
121: // Use of this source code is governed by a BSD-style license that can be
122: // found in the LICENSE file.
123: ```
124: 
125: ## The small print
126: 
127: Contributions made by corporations are covered by a different agreement than the
128: one above, the
129: [Software Grant and Corporate Contributor License Agreement](https://developers.google.com/open-source/cla/corporate).
````

## File: README.md
````markdown
  1: # games
  2: 
  3: [![Build Status](https://github.com/flutter/games/actions/workflows/main.yml/badge.svg)](https://github.com/flutter/games/actions/workflows/main.yml)
  4: 
  5: Home to the official code for the Flutter Casual Games Toolkit 
  6: and other Flutter gaming templates.
  7: 
  8: Visit [flutter.dev/games](https://flutter.dev/games) for more information.
  9: 
 10: If you're new to Flutter, you first need to install the 
 11: [Flutter SDK](https://flutter.dev/).
 12: 
 13: <a href="https://idx.google.com/new?template=https%3A%2F%2Fgithub.com%2Fflutter%2Fgames">
 14:   <picture>
 15:     <source
 16:       media="(prefers-color-scheme: dark)"
 17:       srcset="https://cdn.idx.dev/btn/try_light_32.svg">
 18:     <source
 19:       media="(prefers-color-scheme: light)"
 20:       srcset="https://cdn.idx.dev/btn/try_dark_32.svg">
 21:     <img
 22:       height="32"
 23:       alt="Try in IDX"
 24:       src="https://cdn.idx.dev/btn/try_purple_32.svg">
 25:   </picture>
 26: </a>
 27: 
 28: ## Organization
 29: 
 30: The projects in this repository are divided into two broad categories:
 31: 
 32: 1. **Templates.** A small number of starting points for your game project.
 33:    Templates are intended to give you a simple project structure
 34:    on top of which you can build your game.
 35:    They differ to accommodate different game types, 
 36:    from the simplest casual games through drag&drop board games
 37:    to 2D platformers.
 38: 
 39: 2. **Samples.** Intended to show functionality beyond the basics,
 40:    such as multiplayer or ads integration.
 41: 
 42: 
 43: ```text
 44: .
 45: ├── templates
 46: │   ├── basic
 47: │   ├── card
 48: │   └── endless_runner
 49: └── samples
 50:     ├── ads
 51:     ├── multiplayer
 52:     └── ...
 53: ```
 54: 
 55: 
 56: ## How to use
 57: 
 58: The easiest way to get any of the samples and templates from this repository
 59: is to install the 
 60: [`sample_downloader` tool](https://pub.dev/packages/sample_downloader)
 61: and use it.
 62: 
 63: On the command line, while having the 
 64: [Flutter SDK installed](https://docs.flutter.dev/get-started/install),
 65: run the following command:
 66: 
 67: ```shell
 68: dart pub global activate sample_downloader
 69: ```
 70: 
 71: Then, from any directory, run the newly installed tool
 72: and follow its instructions.
 73: 
 74: ```shell
 75: sample_downloader
 76: ```
 77: 
 78: ### The manual way
 79: 
 80: If, for any reason, you prefer not to use the `sample_downloader` tool,
 81: follow these steps.
 82: 
 83: 1. Clone this repository.
 84: 
 85:    To minimize download size, you can use a 
 86:    [partial clone](https://github.blog/2020-12-21-get-up-to-speed-with-partial-clone-and-shallow-clone/):
 87: 
 88:    ```shell
 89:    git clone --filter=blob:none https://github.com/flutter/games.git
 90:    ```
 91: 
 92:    (Alternatively, you can 
 93:    [download the ZIP file](https://github.com/flutter/games/archive/refs/heads/main.zip)
 94:    and uncompress it on your workstation.)
 95: 
 96: 2. `cd` into the project you are interested in. For example:
 97: 
 98:    ```shell
 99:    cd templates/card
100:    ```
101: 
102:    (Alternatively, you can copy the contents of a project to somewhere else,
103:    and change to that directory.)
104: 
105: 3. (Optional) Rename the project with the 
106:    [`rename` tool](https://pub.dev/packages/rename).
107: 
108: 4. Open the project in your favorite editor and enjoy.
109: 
110: 
111: ## Interested in contributing?
112: 
113: See the [contributor's guide](CONTRIBUTING.md)!
114: 
115: 
116: ## Questions or issues?
117: 
118: If you have a general question about one of these samples or how to adapt its
119: techniques for one of your own apps, try one of these resources:
120: 
121: * [The FlutterDev Discord](https://discord.gg/rflutterdev)
122: * [The Flame Discord](https://discord.com/invite/pxrBmy4)
123: * [StackOverflow](https://stackoverflow.com/questions/tagged/flutter)
124: 
125: If you run into a bug in one of the samples, please file an issue in the
126: [`flutter/flutter` issue tracker](https://github.com/flutter/flutter/issues).
````
