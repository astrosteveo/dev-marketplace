---
name: Technical Decisions
description: >
  This skill provides knowledge about foundational technical decisions for different
  project types. Use when determining tech stack, architecture patterns, scaling
  approaches, or project structure. Covers games, web apps, APIs, CLIs, scripts,
  and mobile/desktop applications.
version: 1.0.0
---

# Technical Decisions Knowledge

Comprehensive guidance for making foundational technical decisions across different project types.

## Purpose

Help developers make informed technical choices BEFORE coding to prevent mid-implementation chaos.

## Core Principle

**Every project type has critical decisions that must be made upfront.** Forgetting any of these leads to costly retrofitting later.

---

## Project Type: Multiplayer Games

### Critical Decisions

1. **Player Count / Scale**
   - 10-50 players: Simple architecture (P2P possible, basic client-server)
   - 100-500 players: Dedicated server, basic synchronization
   - 1000+ players: Actor pattern, Area of Interest filtering, optimized networking
   - 10000+ players: Distributed servers, load balancing, spatial partitioning

2. **Game Dimensionality**
   - 2D: Simpler rendering, focus on gameplay
   - 3D: More complex, consider LOD, culling, lighting

3. **Game Engine**
   - Unity: C#, large ecosystem, good for 3D
   - Godot: GDScript/C#, open source, good for 2D/3D
   - Unreal: C++/Blueprints, AAA graphics, steep learning
   - Custom/Framework: Full control, more work (Bevy, Phaser, LibGDX)

4. **Multiplayer Architecture** (100+ players)
   - Client-Server: Server authoritative, prevents cheating
   - P2P: No server costs, works for small games
   - Actor Pattern: Concurrent message passing, scales to 1000s
   - Lockstep: Deterministic, good for RTS/strategy

5. **State Synchronization**
   - Full State: Send everything (works for <10 players)
   - Delta/Snapshots: Send changes only (100-500 players)
   - AoI (Area of Interest): Send only nearby (1000+ players)
   - Entity Interpolation: Smooth movement between updates

6. **Network Protocol**
   - WebSocket: Easy, works in browsers, TCP-based
   - UDP: Low latency, unreliable, need to handle packet loss
   - Custom Binary: Most efficient, more complex
   - MessagePack/Protobuf: Structured binary serialization

7. **Tick Rate**
   - 10Hz: Turn-based, slow-paced games
   - 20Hz: Most multiplayer games
   - 60Hz: Fast-paced competitive (expensive bandwidth)

---

## Project Type: Web Applications

### Critical Decisions

1. **Application Type**
   - SPA (Single Page App): Client-side routing, API calls
   - SSR (Server-Side Rendered): SEO-friendly, faster initial load
   - MPA (Multi-Page App): Traditional, simpler deployment

2. **Frontend Framework**
   - React: Large ecosystem, job market, component-based
   - Vue: Easier learning curve, progressive adoption
   - Svelte: Compiled, less boilerplate, smaller bundles
   - Vanilla JS: No framework overhead, more manual work

3. **Backend Framework**
   - Node.js/Express: JavaScript everywhere, large ecosystem
   - Python/FastAPI: Fast development, great for data/ML
   - Go: High performance, compiled, good concurrency
   - Rust/Axum: Maximum performance, memory safe

4. **Database**
   - PostgreSQL: Relational, robust, full-featured
   - MySQL: Relational, simpler than Postgres
   - SQLite: File-based, perfect for simple/embedded apps
   - MongoDB: Document-based, flexible schema
   - Redis: In-memory, caching, sessions

5. **Authentication**
   - JWT: Stateless, works across services
   - Sessions: Server-side, simpler revocation
   - OAuth: Third-party (Google, GitHub)
   - None for MVP: Defer if not critical

6. **API Design**
   - REST: Standard, well-understood, HTTP verbs
   - GraphQL: Client-specified queries, less over-fetching
   - tRPC: Type-safe, TypeScript end-to-end
   - gRPC: High performance, binary, microservices

7. **Deployment**
   - Vercel/Netlify: Serverless, automatic scaling, easy
   - Railway/Render: Full-stack apps, databases included
   - Docker: Containerized, portable, self-hosted
   - VPS: Full control, more ops work

---

## Project Type: API / Backend

### Critical Decisions

1. **Framework**
   - Express (Node): Minimal, flexible, large ecosystem
   - FastAPI (Python): Fast, auto-docs, type hints
   - Actix/Axum (Rust): Maximum performance
   - Gin (Go): Simple, fast, compiled

2. **Database** (same as Web Apps section)

3. **Authentication**
   - API Keys: Simple, good for service-to-service
   - JWT: Stateless, works for user auth
   - OAuth2: Standard for third-party access

4. **API Design** (same as Web Apps section)

5. **Deployment** (same as Web Apps section)

---

## Project Type: CLI Tools

### Critical Decisions

1. **Language**
   - Python: Quick development, pip distribution
   - Rust: Fast binaries, no runtime, cargo distribution
   - Go: Fast, single binary, good for tools
   - Node: Access to npm ecosystem
   - Bash: Simple scripts, no compilation

2. **Argument Parsing**
   - Python: Click, argparse, typer
   - Rust: clap, structopt
   - Go: cobra, pflag
   - Node: commander, yargs

3. **Configuration**
   - .env files: Simple key=value
   - TOML/YAML: Structured configuration
   - JSON: Programmatic configuration
   - No config: All via arguments (simpler)

4. **Distribution**
   - pip (Python): pip install your-tool
   - cargo (Rust): cargo install your-tool
   - npm (Node): npm install -g your-tool
   - Homebrew: Tap and install (Mac/Linux)
   - Binary releases: GitHub releases

---

## Project Type: Scripts

### Critical Decisions

1. **Language**
   - Python: General purpose, data processing
   - Bash: System automation, glue scripts
   - Node: When you need npm packages
   - Ruby: Text processing, DSLs

2. **Dependencies**
   - Minimize: Easier distribution
   - Document: requirements.txt, package.json

3. **Input/Output**
   - Files: Read/write files
   - stdin/stdout: Unix pipeline compatible
   - API calls: Fetch/send data over network

---

## Project Type: Desktop Apps

### Critical Decisions

1. **Framework**
   - Electron: Web tech (HTML/CSS/JS), cross-platform, large size
   - Tauri: Rust + web frontend, smaller size, newer
   - Qt: C++/Python, native look, complex
   - Native: Swift (Mac), C# (Windows), most performant

2. **Target OS**
   - Single OS: Native frameworks
   - Cross-platform: Electron, Tauri, Qt

3. **Backend/Storage**
   - SQLite: Local database
   - Files: JSON, config files
   - Cloud sync: Firebase, custom API

4. **Distribution**
   - Installers: .dmg (Mac), .exe (Windows), .deb/.AppImage (Linux)
   - App stores: Mac App Store, Microsoft Store
   - Portable: Single executable

---

## Project Type: Mobile Apps

### Critical Decisions

1. **Platform**
   - iOS only: Swift, smaller code surface
   - Android only: Kotlin, easier testing (emulators)
   - Both: Cross-platform framework

2. **Framework**
   - React Native: JavaScript, large ecosystem
   - Flutter: Dart, fast, growing
   - Native: Swift/Kotlin, best performance

3. **Backend**
   - Firebase: Quick setup, real-time DB
   - Custom API: Full control
   - Local-only: No backend needed

4. **Distribution**
   - App stores: Standard distribution
   - TestFlight/Internal: Beta testing
   - Direct: Android APK (not iOS)

---

## Common Patterns Across All Types

### Version Control
**Always use git from day one.** Set up `.gitignore` immediately.

### Testing Strategy
- Unit tests: Core logic
- Integration tests: Component interaction
- E2E tests: Full user flows

Decide upfront, don't "add tests later" (you won't).

### Environment Management
- Development: Local, fast iteration
- Staging: Matches production, for testing
- Production: Live users

### Folder Structure
**Decide early.** Common patterns:
- MVC: models, views, controllers
- Feature-based: group by feature, not type
- Clean architecture: layers (domain, application, infrastructure)

---

## Decision-Making Framework

For each decision:

1. **What's the default / recommended option?**
2. **What scale am I targeting?** (Start small, scale later is often valid)
3. **What do I already know?** (Use familiar tech for faster progress)
4. **What's the cost of changing later?** (Database is expensive to change, frontend framework less so)

**When in doubt**: Pick the simple, popular option. Optimize later if needed.

---

## Anti-Patterns to Avoid

❌ **"We'll decide database when we need it"** - Decide upfront or you'll retrofit
❌ **"Let's use the newest framework"** - Stick to proven tech unless you're learning
❌ **"We need to support every platform"** - Start with one, expand later
❌ **"Perfect architecture from day one"** - Over-engineering wastes time
❌ **"We don't need tests for MVP"** - You'll never add them later

---

**Remember**: The goal is to make enough decisions to prevent surprises, not to plan every detail forever.
