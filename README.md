# Keyless Door System

A versatile keyless door system for FiveM servers with ownership and key management.

## Features

- Buy and own doors
- Purchase and use keys for door access
- Interactive door system with visual prompts

## Requirements

- FiveM server
- ESX Framework
- MySQL database

## Installation

1. Download the script files.
2. Place them in your FiveM server's resources folder.
3. Add `start rival_keyless_system` to your server.cfg file.
4. Import the database.sql file into your MySQL database.

## Usage

### Commands

- `/buykey` - Purchase a key for door access.

### Permissions

- `rival_keyless_system.buykey` - Allows players to purchase keys.

## Configuration

The script can be configured in the `config.lua` file. You can add, remove, or modify doors in the `DoorList` table. The `KeyItem` and `KeyPrice` variables can be adjusted to change the key item and its price.

---

## Generated with EnderDevelopment

This plugin was generated in minutes with [EnderDevelopment](https://enderdevelopment.com) — the AI platform that turns your ideas into working Minecraft plugins, Discord bots and FiveM scripts.

**Want your own?** [Generate this project on EnderDevelopment](https://dash.enderdevelopment.com?utm_source=github&utm_medium=readme&utm_campaign=keyless-door-system&utm_content=bottom) — describe it in one sentence and get the full source code.