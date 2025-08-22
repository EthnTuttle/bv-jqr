# Bitcoin Veterans JQR Tracker

A Nostr-enabled Flutter application for tracking Bitcoin Veterans Job Qualification Requirements (BV-JQR) - a military-style qualification system for Bitcoin and Freedom Technology education.

## Mission

To educate and qualify the warrior class in Bitcoin and Freedom Technology, promoting individual sovereignty, decentralized systems, and resistance to tyrannical control through comprehensive knowledge and practical application.

**Core Principles:**
- No Shitcoins
- No Violence  
- Decentralization over Centralization
- Self-Sovereignty over Dependence

## Features

### 🎯 JQR Tracking System
- **400+ Qualification Items** organized in military PQS format
- **4-Level Progression**: Fundamentals → Systems → Practical → Advanced
- **Real-time Progress Tracking** with visual completion indicators
- **Offline-capable** for field operations and austere environments

### 🔐 Nostr-Based Authentication & Attestation
- **Nostr Identity Integration** (npub-based profiles)
- **NIP-05 Authority Verification** (bitcoinveterans.org SME validation)
- **Cryptographically Signed Attestations** stored as Nostr events
- **Decentralized SME Network** with qualification matrix
- **Board Approval System** for Master-level qualification

### 📚 Comprehensive Study System
- **Embedded Study Materials** from Nakamoto Institute, LearnMeABitcoin
- **Interactive Tutorials** and self-assessments
- **Offline Content Caching** for field use
- **Reference Library** with Bitcoin and Freedom Tech resources

### 🌐 Community & Collaboration
- **Study Groups** organized by JQR section
- **SME Office Hours** and mentorship matching
- **Local Chapter Integration** for in-person training
- **Peer Discussion Forums** by topic area

### 📊 Analytics & Metrics
- **Individual Progress Dashboards**
- **Authority-wide Completion Statistics**
- **SME Activity Tracking**
- **Time-to-Completion Analytics**

## JQR Structure

### Section 100: Fundamentals
Basic Bitcoin and Freedom Tech knowledge requiring rote memorization:
- Bitcoin Basics (supply cap, halving, proof-of-work)
- Cryptographic Fundamentals (SHA-256, public/private keys)
- Austrian Economics Principles (sound money, time preference)
- Historical Context (monetary history, cypherpunk movement)

### Section 200: Systems and Technology
Understanding Bitcoin and Freedom Tech infrastructure:
- Bitcoin Network Operations (P2P networking, transaction propagation)
- Node Operations (full nodes, IBD, consensus rules)
- Self-Custody Systems (hot/cold storage, multisig, hardware wallets)
- DePIN Networks (Meshtastic, Bitaxe, satellite communications)
- Privacy and Security (coinjoins, Tor, OPSEC)

### Section 300: Practical Applications
Hands-on demonstrations and real-world skills:
- Node Deployment and Maintenance
- Self-Custody Implementation
- DePIN Network Participation
- Privacy and Operational Security
- Education and Advocacy
- Emergency Preparedness

### Section 400: Advanced Applications
Leadership and specialized skills:
- Technical Leadership (system design, security audits)
- Community Building (chapter establishment, conferences)
- Strategic Planning (organizational adoption, threat assessment)

## Qualification Levels

- **Basic Qualified**: Sections 100-200 complete (Fundamentals + Systems)
- **Journeyman**: Sections 100-300 complete (+ Practical Applications)  
- **Advanced**: Sections 100-400 complete (+ Leadership)
- **Master**: All sections + board approval from 5 Bitcoin Veterans

## Attestation System

### Signature Requirements
- Each JQR item requires signature from qualified SME
- SMEs must have valid bitcoinveterans.org NIP-05 verification
- Signatures are Nostr events with standardized format

### Event Structure
```json
{
  "kind": 31001,
  "content": "BV-JQR Attestation\nItem: 101.1 - State Bitcoin mission statement\nCandidate: npub1candidate...\nSME: npub1sme...\nDate: 2024-01-15T10:30:00Z\nNotes: Optional comments",
  "tags": [
    ["d", "bv-jqr-101.1-npub1candidate"],
    ["p", "npub1candidate"],
    ["jqr_item", "101.1"],
    ["jqr_section", "100"],
    ["authority", "bitcoinveterans.org"]
  ]
}
```

### Field Operations Support
- **Offline Attestation Creation** for remote training
- **Local Event Persistence** with cryptographic integrity
- **Batch Publishing** when network becomes available
- **Complete Audit Trail** maintained locally

## Technical Architecture

### Stack
- **Flutter**: Cross-platform mobile application
- **Purplestack**: Nostr-enabled development framework
- **Riverpod**: State management and dependency injection
- **Purplebase**: Local-first Nostr SDK with relay pool
- **Models Package**: Domain models for Nostr events

### Data Flow
1. **Authentication**: User authenticates with Nostr keypair
2. **Authority Selection**: Choose JQR authority (NIP-05 domain)
3. **Progress Tracking**: Local storage of completion status
4. **Attestation**: SMEs sign completions via Nostr events
5. **Synchronization**: Real-time updates across network
6. **Verification**: Cryptographic validation of all signatures

### Offline Capability
- Complete JQR content cached locally
- Attestation events stored with full cryptographic proof
- Field operation support with deferred network sync
- Local verification without internet dependency

## Development

### Prerequisites
- Flutter SDK with FVM
- Android SDK for mobile development
- Nostr relay access for testing

### Setup
```bash
# Install dependencies
fvm flutter pub get

# Run rename script (first time only)
dart tools/scripts/rename_app.dart --name "BV-JQR Tracker" --app-id "org.bitcoinveterans.jqr"

# Launch development server
fvm flutter run
```

### Key Dependencies
- `models`: Nostr domain models and event handling
- `purplebase`: Local-first Nostr SDK
- `amber_signer`: NIP-55 Android signer integration
- `flutter_hooks`: Widget lifecycle management
- `cached_network_image`: Offline-capable image loading

## Contributing

This project serves Bitcoin Veterans' mission to educate the warrior class on freedom technology. Contributions should align with the "no shitcoins, no violence" principles and focus on practical Bitcoin education.

## License

MIT

---

*Powered by [Purplestack](https://purplestack.io)*