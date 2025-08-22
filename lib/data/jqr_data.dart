import '../models/jqr_item.dart';

class JQRData {
  static final Map<String, JQRSection> sections = {
    '100': const JQRSection(
      id: '100',
      title: 'Fundamentals',
      description: 'Basic Bitcoin and Freedom Tech knowledge requiring rote memorization',
      level: QualificationLevel.basic,
      items: [
        // 101 - Bitcoin Basics
        JQRItem(
          id: '101.1',
          section: '100', 
          title: 'State the Bitcoin mission statement and Satoshi\'s vision',
          description: 'Recite from memory Bitcoin\'s core mission of peer-to-peer electronic cash and Satoshi\'s original vision for decentralized money.',
          studyMaterials: ['Bitcoin Whitepaper', 'Satoshi\'s Forum Posts'],
          type: RequirementType.memorization,
          level: QualificationLevel.basic,
        ),
        JQRItem(
          id: '101.2',
          section: '100',
          title: 'Recite the 21 million supply cap and halving schedule',
          description: 'State the exact Bitcoin supply cap and halving intervals with dates.',
          studyMaterials: ['Bitcoin Protocol Documentation', 'Halving History'],
          type: RequirementType.memorization,
          level: QualificationLevel.basic,
        ),
        JQRItem(
          id: '101.3',
          section: '100',
          title: 'Explain proof-of-work vs proof-of-stake',
          description: 'Articulate the fundamental differences between consensus mechanisms and their security implications.',
          studyMaterials: ['Consensus Mechanisms Overview', 'PoW vs PoS Analysis'],
          type: RequirementType.memorization,
          level: QualificationLevel.basic,
        ),
        JQRItem(
          id: '101.4',
          section: '100',
          title: 'Define hash rate, difficulty adjustment, and block time',
          description: 'Explain these core Bitcoin network metrics and their relationships.',
          studyMaterials: ['Bitcoin Network Statistics', 'Mining Difficulty Guide'],
          type: RequirementType.memorization,
          level: QualificationLevel.basic,
        ),
        JQRItem(
          id: '101.5',
          section: '100',
          title: 'Memorize key Bitcoin vocabulary',
          description: 'Define UTXO, mempool, mining, blocks, transactions, and other core terms.',
          studyMaterials: ['Bitcoin Glossary', 'Technical Terminology Guide'],
          type: RequirementType.memorization,
          level: QualificationLevel.basic,
        ),

        // 102 - Cryptographic Fundamentals
        JQRItem(
          id: '102.1',
          section: '100',
          title: 'Explain SHA-256 and its role in Bitcoin',
          description: 'Describe the SHA-256 hash function and its critical role in Bitcoin\'s security.',
          studyMaterials: ['Cryptographic Hash Functions', 'SHA-256 in Bitcoin'],
          type: RequirementType.memorization,
          level: QualificationLevel.basic,
        ),
        JQRItem(
          id: '102.2',
          section: '100',
          title: 'Describe public/private key cryptography',
          description: 'Explain asymmetric cryptography fundamentals used in Bitcoin.',
          studyMaterials: ['Public Key Cryptography', 'Bitcoin Key Management'],
          type: RequirementType.memorization,
          level: QualificationLevel.basic,
        ),
        JQRItem(
          id: '102.3',
          section: '100',
          title: 'Define digital signatures and their importance',
          description: 'Explain how digital signatures provide authentication and non-repudiation.',
          studyMaterials: ['Digital Signatures Overview', 'Bitcoin Transaction Signatures'],
          type: RequirementType.memorization,
          level: QualificationLevel.basic,
        ),
        JQRItem(
          id: '102.4',
          section: '100',
          title: 'Explain Merkle trees and their function',
          description: 'Describe how Merkle trees enable efficient and secure verification.',
          studyMaterials: ['Merkle Tree Structure', 'Bitcoin Block Construction'],
          type: RequirementType.memorization,
          level: QualificationLevel.basic,
        ),
        JQRItem(
          id: '102.5',
          section: '100',
          title: 'Describe elliptic curve cryptography basics',
          description: 'Explain secp256k1 curve and its advantages for Bitcoin.',
          studyMaterials: ['Elliptic Curve Cryptography', 'secp256k1 Specification'],
          type: RequirementType.memorization,
          level: QualificationLevel.basic,
        ),

        // 103 - Austrian Economics Principles  
        JQRItem(
          id: '103.1',
          section: '100',
          title: 'State Mises\' regression theorem',
          description: 'Explain how money emerges from barter and Bitcoin\'s path to monetary status.',
          studyMaterials: ['Human Action', 'Regression Theorem Analysis'],
          type: RequirementType.memorization,
          level: QualificationLevel.basic,
        ),
        JQRItem(
          id: '103.2',
          section: '100',
          title: 'Explain Gresham\'s law and its Bitcoin implications',
          description: 'Describe how bad money drives out good money and Bitcoin\'s role.',
          studyMaterials: ['Gresham\'s Law', 'Bitcoin Monetary Theory'],
          type: RequirementType.memorization,
          level: QualificationLevel.basic,
        ),
        JQRItem(
          id: '103.3',
          section: '100',
          title: 'Define sound money characteristics',
          description: 'List and explain the properties that make money sound (scarce, durable, etc.).',
          studyMaterials: ['Sound Money Principles', 'Austrian School Economics'],
          type: RequirementType.memorization,
          level: QualificationLevel.basic,
        ),
        JQRItem(
          id: '103.4',
          section: '100',
          title: 'Recite the Cantillon effect',
          description: 'Explain how new money creation benefits those closest to the money printer.',
          studyMaterials: ['Cantillon Effect Analysis', 'Fiat Money Critique'],
          type: RequirementType.memorization,
          level: QualificationLevel.basic,
        ),
        JQRItem(
          id: '103.5',
          section: '100',
          title: 'Explain time preference and delayed gratification',
          description: 'Describe how sound money encourages saving and long-term thinking.',
          studyMaterials: ['Time Preference Theory', 'Bitcoin Time Preference'],
          type: RequirementType.memorization,
          level: QualificationLevel.basic,
        ),

        // 104 - Historical Context
        JQRItem(
          id: '104.1',
          section: '100',
          title: 'Memorize key dates in monetary history',
          description: 'Recite 1971 Nixon Shock, 1933 Gold Confiscation, and other critical dates.',
          studyMaterials: ['Monetary History Timeline', 'Gold Standard History'],
          type: RequirementType.memorization,
          level: QualificationLevel.basic,
        ),
        JQRItem(
          id: '104.2',
          section: '100',
          title: 'State the cypherpunk manifesto principles',
          description: 'Recite core cypherpunk values of privacy, cryptography, and freedom.',
          studyMaterials: ['Cypherpunk Manifesto', 'Cryptography and Liberty'],
          type: RequirementType.memorization,
          level: QualificationLevel.basic,
        ),
        JQRItem(
          id: '104.3',
          section: '100',
          title: 'Recite key quotes from Satoshi\'s whitepaper',
          description: 'Memorize significant passages from the Bitcoin whitepaper.',
          studyMaterials: ['Bitcoin Whitepaper', 'Satoshi\'s Key Insights'],
          type: RequirementType.memorization,
          level: QualificationLevel.basic,
        ),
        JQRItem(
          id: '104.4',
          section: '100',
          title: 'Explain previous digital currency attempts',
          description: 'Describe e-gold, DigiCash, and other precursors to Bitcoin.',
          studyMaterials: ['Digital Currency History', 'Pre-Bitcoin Attempts'],
          type: RequirementType.memorization,
          level: QualificationLevel.basic,
        ),
        JQRItem(
          id: '104.5',
          section: '100',
          title: 'State the genesis block message and its significance',
          description: 'Recite the newspaper headline and explain its meaning.',
          studyMaterials: ['Genesis Block Analysis', 'Bitcoin Launch Context'],
          type: RequirementType.memorization,
          level: QualificationLevel.basic,
        ),
      ],
    ),

    '200': const JQRSection(
      id: '200',
      title: 'Systems and Technology',
      description: 'Understanding Bitcoin and Freedom Tech infrastructure',
      level: QualificationLevel.journeyman,
      items: [
        // 201 - Bitcoin Network Operations
        JQRItem(
          id: '201.1',
          section: '200',
          title: 'Demonstrate understanding of peer-to-peer networking',
          description: 'Explain how Bitcoin nodes discover and communicate with each other.',
          studyMaterials: ['P2P Networking', 'Bitcoin Network Protocol'],
          type: RequirementType.demonstration,
          level: QualificationLevel.journeyman,
          prerequisites: ['101.1', '101.4'],
        ),
        JQRItem(
          id: '201.2',
          section: '200',
          title: 'Explain transaction propagation and validation',
          description: 'Describe how transactions spread through the network and are validated.',
          studyMaterials: ['Transaction Lifecycle', 'Network Propagation'],
          type: RequirementType.demonstration,
          level: QualificationLevel.journeyman,
          prerequisites: ['101.5', '102.3'],
        ),

        // 202 - Node Operations
        JQRItem(
          id: '202.1',
          section: '200',
          title: 'Compare full node vs SPV implementations',
          description: 'Explain the security and functionality differences between node types.',
          studyMaterials: ['Node Types Comparison', 'SPV Security Model'],
          type: RequirementType.demonstration,
          level: QualificationLevel.journeyman,
          prerequisites: ['201.1'],
        ),

        // 203 - Self-Custody Systems
        JQRItem(
          id: '203.1',
          section: '200',
          title: 'Compare hot vs cold storage solutions',
          description: 'Explain security tradeoffs between different storage methods.',
          studyMaterials: ['Storage Security Models', 'Hot vs Cold Storage'],
          type: RequirementType.demonstration,
          level: QualificationLevel.journeyman,
          prerequisites: ['102.2'],
        ),

        // 204 - DePIN
        JQRItem(
          id: '204.1',
          section: '200',
          title: 'Explain mesh networking fundamentals (Meshtastic)',
          description: 'Describe decentralized communication networks and their applications.',
          studyMaterials: ['Mesh Networking Principles', 'Meshtastic Documentation'],
          type: RequirementType.demonstration,
          level: QualificationLevel.journeyman,
        ),

        // 205 - Privacy and Security
        JQRItem(
          id: '205.1',
          section: '200',
          title: 'Explain coinjoins and mixing services',
          description: 'Describe privacy techniques and their implementation in Bitcoin.',
          studyMaterials: ['Bitcoin Privacy', 'Coinjoin Technical Guide'],
          type: RequirementType.demonstration,
          level: QualificationLevel.journeyman,
          prerequisites: ['102.1', '102.3'],
        ),
      ],
    ),

    '300': const JQRSection(
      id: '300', 
      title: 'Practical Applications',
      description: 'Hands-on demonstrations and real-world skills',
      level: QualificationLevel.advanced,
      items: [
        // 301 - Node Deployment
        JQRItem(
          id: '301.1',
          section: '300',
          title: 'Deploy and configure a Bitcoin full node',
          description: 'Set up Bitcoin Core or equivalent with proper configuration.',
          studyMaterials: ['Bitcoin Core Setup Guide', 'Node Configuration'],
          type: RequirementType.practical,
          level: QualificationLevel.advanced,
          prerequisites: ['202.1'],
        ),

        // 302 - Self-Custody Implementation
        JQRItem(
          id: '302.1',
          section: '300',
          title: 'Generate secure seed phrases using dice/coin flips',
          description: 'Create entropy manually and generate BIP39 seed phrases.',
          studyMaterials: ['Entropy Generation', 'BIP39 Implementation'],
          type: RequirementType.practical,
          level: QualificationLevel.advanced,
          prerequisites: ['203.1'],
        ),

        // 303 - DePIN Network Participation
        JQRItem(
          id: '303.1',
          section: '300',
          title: 'Deploy and configure Meshtastic node',
          description: 'Set up mesh networking device with proper configuration.',
          studyMaterials: ['Meshtastic Setup Guide', 'Mesh Network Configuration'],
          type: RequirementType.practical,
          level: QualificationLevel.advanced,
          prerequisites: ['204.1'],
        ),
      ],
    ),

    '400': const JQRSection(
      id: '400',
      title: 'Advanced Applications', 
      description: 'Leadership and specialized skills',
      level: QualificationLevel.master,
      items: [
        // 401 - Technical Leadership
        JQRItem(
          id: '401.1',
          section: '400',
          title: 'Design and implement Bitcoin business solution',
          description: 'Create comprehensive technical architecture for Bitcoin integration.',
          studyMaterials: ['Bitcoin Business Integration', 'Technical Architecture'],
          type: RequirementType.leadership,
          level: QualificationLevel.master,
          prerequisites: ['301.1', '302.1'],
        ),

        // 402 - Community Building
        JQRItem(
          id: '402.1',
          section: '400',
          title: 'Establish local Bitcoin Veterans chapter',
          description: 'Create and lead local educational and networking group.',
          studyMaterials: ['Community Building Guide', 'Chapter Leadership'],
          type: RequirementType.leadership,
          level: QualificationLevel.master,
        ),
      ],
    ),
  };

  static List<JQRSection> get allSections => sections.values.toList()
    ..sort((a, b) => a.id.compareTo(b.id));

  static List<JQRItem> get allItems => 
    allSections.expand((section) => section.items).toList();

  static JQRItem? getItem(String id) {
    for (final section in allSections) {
      for (final item in section.items) {
        if (item.id == id) return item;
      }
    }
    return null;
  }

  static List<JQRItem> getItemsForLevel(QualificationLevel level) {
    return allItems.where((item) => item.level == level).toList();
  }

  static List<JQRItem> getPrerequisites(String itemId) {
    final item = getItem(itemId);
    if (item == null) return [];
    
    return item.prerequisites
      .map((prereqId) => getItem(prereqId))
      .where((item) => item != null)
      .cast<JQRItem>()
      .toList();
  }
}