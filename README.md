# Mobile Adventures

This repository used to be called `BinaryAdventures`, which then changed to `SecurityAdventures`, and now `MobileAdventures`.
This is my all-in-one monorepo for all things mobile, including forward development, ARM-related stuff, and security testing.

## ios
The `ios` directory will have all iOS-related items, both development and reverse engineering.
Some things will be tracked git repos, but probably not submodules/fully tracked.

## frida

The `frida` directory will be my main workplace for 64-bit ARM-related hooking items.
My vision is to make it into some sort of "manual" where there will be tid-bits 
of my thoughts and experiments, each of which being broken down into pieces.
The current setup for testing is:
1. Raspberry Pi 4 - Raspberry Pi OS 64-bit
2. ~~Motorola G5s Plus Android 8.1~~ Pixel 3a
3. iPhone 8 iOS 16.2 (palera1n)
4. MacBook Pro 2022 M1 16"

## Protocol Analysis
The `protocol_analysis` directory will include any work that has to do with analyzing 
different protocols. This includes binary protocols like Google's Protocol Buffers & LevelDB,
as well as special network protocols.

## Links

Useful links I find as I learn more..

- [Cross-compiling from x86 to ARMv8](https://jensd.be/1126/linux/cross-compiling-for-arm-or-aarch64-on-debian-or-ubuntu)
