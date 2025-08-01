# Persistent Map Markers

A collection of Arma 3 mods that automatically save and restore map markers across mission restarts and campaigns. This repository contains four different versions optimized for different gameplay scenarios and mod combinations.

## Overview

The Persistent Map Markers system preserves your custom map markers between game sessions, ensuring that important tactical information, waypoints, and reference points are never lost. Each version is tailored for specific mod environments and use cases.

## Available Versions

| Version | Description | Best For |
|---------|-------------|----------|
| **Vanilla** | Basic functionality with no dependencies | Standard Arma 3 gameplay |
| **ACE** | Enhanced with ACE interaction menus and notifications | ACE-based missions and campaigns |
| **Antistasi** | Integrated with Antistasi's persistent save system | Antistasi campaign players |
| **Antistasi-ACE** | Combined Antistasi integration with ACE features | Antistasi campaigns using ACE |

---

## Vanilla Version

### Features
- Automatic marker saving on mission end
- Manual save with **Ctrl+Shift+S** hotkey
- Automatic marker loading on mission start
- Profile-based storage (persistent across Arma 3 sessions)

### Requirements
- Arma 3
- No additional mods required

### Usage
1. Install the vanilla version
2. Create map markers during gameplay
3. Markers are automatically saved when the mission ends
4. Use **Ctrl+Shift+S** for manual saves
5. Markers automatically load when starting new missions

### System Notifications
- **Mod Loading**: "Persistent Markers: Mod loaded and ready" confirms the mod has initialized
- **Marker Restoration**: Shows specific message when markers are restored, e.g., "Persistent Markers: Restored 5 saved markers"
- **No Markers**: "Persistent Markers: No markers to restore" when no saved data exists

### Installation
Copy the `@PersistentMarkersVanilla` folder to your Arma 3 directory and add `-mod=@PersistentMarkersVanilla` to your launch parameters.

---

## ACE Version

### Features
- All vanilla functionality
- **ACE Self-Interaction Menu** for marker management
- **Rich ACE notifications** with detailed feedback
- **ACE Settings integration** for configuration
- Enhanced user experience with visual feedback

### Requirements
- Arma 3
- ACE3 (ace_main, ace_interact_menu, ace_map)

### Usage

#### ACE Interaction Menu
Access marker management through ACE Self-Interaction menu:

1. **Hold Windows Key** (default ACE self-interaction key)
2. Navigate to **"Marker Management"**
3. Choose from available actions:
   - **Save Current Markers** - Manual save with count feedback
   - **Load Saved Markers** - Load markers with status report
   - **Clear All Markers** - Remove all markers from map

#### ACE Settings
Configure the mod through ACE Settings:
- **Enable Auto Save** - Toggle automatic saving on mission end
- Access via ACE Settings menu in-game or mission parameters

#### Visual Feedback
All operations display ACE notifications showing:
- Number of markers saved/loaded
- Success/failure status
- Detailed operation results

### Installation
Copy the `@PersistentMarkersACE` folder to your Arma 3 directory and add `-mod=@PersistentMarkersACE;@ace` to your launch parameters.

---

## Antistasi Version

### Features
- All vanilla functionality
- **Automatic integration** with Antistasi's persistent save system
- **Smart marker filtering** to exclude Antistasi system markers
- **Dual storage system** (profile + Antistasi save data)
- **Non-destructive loading** that preserves Antistasi operational markers

### Requirements
- Arma 3
- Antistasi campaign mod

### Usage

#### Automatic Integration
- Markers are automatically saved whenever Antistasi performs a persistent save
- No manual intervention required - works seamlessly with Antistasi's save system
- Manual save still available with **Ctrl+Shift+S**

#### Smart Filtering
The system automatically excludes Antistasi operational markers:
- `garrison_*` - Base garrison markers
- `attack_*` - Attack operation markers  
- `defend_*` - Defense operation markers
- `spawn_*` - Spawn point markers
- `roadblock_*` - Roadblock markers
- `factory_*`, `resource_*`, `outpost_*` - Infrastructure markers

#### Loading Behavior
- Preserves all Antistasi system markers when loading saved markers
- Only clears user-created markers before loading
- Handles marker name conflicts automatically

### Installation
Copy the `@PersistentMarkersAntistasi` folder to your Arma 3 directory and add `-mod=@PersistentMarkersAntistasi` to your launch parameters when playing Antistasi.

---

## Antistasi-ACE Version (Recommended for ACE + Antistasi)

### Features
- **Complete integration** of both Antistasi and ACE functionality
- **Advanced ACE interaction menu** with Antistasi-specific options
- **Detailed ACE notifications** with Antistasi status information
- **Configurable ACE settings** for Antistasi integration
- **Smart conflict resolution** and enhanced user feedback

### Requirements
- Arma 3
- ACE3 (ace_main, ace_interact_menu, ace_map)
- Antistasi campaign mod

### Usage

#### Enhanced ACE Interaction Menu
Access through ACE Self-Interaction → **"Marker Management (Antistasi)"**:

1. **Save Current Markers** - Manual save with filtering feedback
2. **Load Saved Markers** - Load with preservation details
3. **Clear User Markers** - Smart clearing that preserves Antistasi markers
4. **Force Sync with Antistasi** - Manual integration with Antistasi save system

#### ACE Settings
Configure Antistasi-specific options:
- **Enable Auto Save with Antistasi** - Toggle automatic saving with Antistasi saves
- **Filter Antistasi System Markers** - Control whether to exclude system markers

#### Enhanced Notifications
ACE notifications provide detailed information:
- Number of markers saved/loaded
- How many Antistasi system markers were preserved
- Conflict resolution details
- Integration status with Antistasi save system

#### Automatic Features
- **Real-time monitoring** of Antistasi save operations
- **Automatic marker saving** when Antistasi saves campaign data
- **Intelligent loading** that respects Antistasi's operational markers
- **Fallback support** - works as standard ACE version if Antistasi not detected

### Installation
Copy the `@PersistentMarkersAntistasiAce` folder to your Arma 3 directory and add `-mod=@PersistentMarkersAntistasiAce;@ace` to your launch parameters when playing Antistasi with ACE.

---

## Technical Details

### Storage Locations
- **Vanilla/ACE**: `profileNamespace` variable `PersistentMarkers_SavedMarkers`
- **Antistasi**: `profileNamespace` variable `PersistentMarkers_Antistasi_SavedMarkers`
- **Antistasi-ACE**: `profileNamespace` variable `PersistentMarkers_Antistasi_ACE_SavedMarkers`

### Marker Data Structure
Each saved marker contains:
- Marker name and position
- Type, text, and color
- Size, direction, and shape
- Brush style and alpha transparency

### Compatibility
- **No conflicts** between versions - each uses separate storage keys
- **Safe to switch** between versions for different campaigns
- **Backwards compatible** - newer versions can load older saves

## Troubleshooting

### Common Issues

**Markers not saving:**
- Check that you have write permissions to your Arma 3 profile directory
- Ensure the mod is properly loaded (check RPT logs)

**Antistasi integration not working:**
- Verify Antistasi is properly loaded before the markers mod
- Check for `teamPlayer` and `serverSaveInProgress` variables in debug console

**ACE menu not appearing:**
- Ensure ACE is loaded and functioning
- Check ACE keybinds are properly configured
- Verify you're using the correct ACE self-interaction key

### Log Messages
All versions provide detailed logging. Check your Arma 3 RPT file for messages prefixed with:
- `Persistent Markers:` (Vanilla)
- `Persistent Markers ACE:` (ACE)
- `Persistent Markers Antistasi:` (Antistasi)
- `Persistent Markers Antistasi-ACE:` (Antistasi-ACE)

## Version History

- **v1.0** - Initial release with all four variants
- Full feature parity across all versions
- Comprehensive integration testing completed

## Support

For issues, suggestions, or contributions, please check the project repository or contact the mod author.

---

*Choose the version that best matches your gameplay setup for optimal marker persistence and user experience.*
