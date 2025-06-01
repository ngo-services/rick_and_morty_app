# Rick & Morty App

A showcase Flutter application for listing Rick and Morty characters, with favorites, offline support, pagination, and **three state management approaches**—**Provider**, **MobX**, and **GetX**—all in one codebase.

## Features

- 🚀 Fetches character data from the [Rick and Morty API](https://rickandmortyapi.com/documentation/)
- 🗂️ Supports three state management solutions in a single app: **Provider**, **MobX**, and **GetX**
- ⭐ Add/remove characters to favorites with beautiful animated transitions
- 🔄 Pagination/infinite scroll for character list
- 📱 Modern UI with dark & light theme toggle 
- 🗃️ Offline cache for characters and favorites (using Hive)
- 🧠 Shows snackbar notifications when favorites are added or removed, indicating which state management is used
- 🏆 Favorites can be sorted by name or status
- 🧩 Modular, clean, and scalable architecture

## Project Structure

```plaintext
lib/
├── app_root.dart                  
├── main.dart                      
├── state_switch_screen.dart      
├── main_scaffold.dart             
├── state_manager_dropdown.dart    
├── shared/
│   └── state_manager_type.dart    
├── models/
│   └── character.dart            
├── providers/
│   ├── character_provider.dart
│   ├── all_characters_provider.dart
│   └── favorites_provider.dart
├── mobx/
│   ├── character_store.dart
│   ├── all_characters_mobx.dart
│   └── favorites_mobx.dart
├── getx/
│   ├── character_controller.dart
│   ├── all_characters_getx.dart
│   └── favorites_getx.dart
├── widgets/
│   └── character_card.dart       
├── utils/
│   └── snackbar_helper.dart       
│   └── theme.dart               
