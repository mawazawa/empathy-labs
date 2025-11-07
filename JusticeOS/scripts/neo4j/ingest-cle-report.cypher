// ============================================================================
// CLE Report Neo4j Ingestion Script
// ============================================================================
// Description: Ingests CLE-001 (Linear AI Workflows) into Neo4j knowledge graph
// Usage: cypher-shell -u neo4j -p <password> < scripts/neo4j/ingest-cle-report.cypher
// Or: Execute via Neo4j Browser or Neo4j Desktop
// ============================================================================

// ----------------------------------------------------------------------------
// 1. Create Schema Constraints
// ----------------------------------------------------------------------------

CREATE CONSTRAINT cle_report_id IF NOT EXISTS 
FOR (c:CLEReport) REQUIRE c.id IS UNIQUE;

CREATE CONSTRAINT learning_id IF NOT EXISTS 
FOR (l:Learning) REQUIRE l.id IS UNIQUE;

CREATE CONSTRAINT evidence_id IF NOT EXISTS 
FOR (e:Evidence) REQUIRE e.id IS UNIQUE;

CREATE CONSTRAINT concept_id IF NOT EXISTS 
FOR (c:Concept) REQUIRE c.id IS UNIQUE;

CREATE CONSTRAINT tool_id IF NOT EXISTS 
FOR (t:Tool) REQUIRE t.id IS UNIQUE;

CREATE CONSTRAINT principle_id IF NOT EXISTS 
FOR (p:Principle) REQUIRE p.id IS UNIQUE;

CREATE CONSTRAINT person_id IF NOT EXISTS 
FOR (p:Person) REQUIRE p.id IS UNIQUE;

CREATE CONSTRAINT invalidated_belief_id IF NOT EXISTS 
FOR (ib:InvalidatedBelief) REQUIRE ib.id IS UNIQUE;

CREATE CONSTRAINT pivot_point_id IF NOT EXISTS 
FOR (pp:PivotPoint) REQUIRE pp.id IS UNIQUE;

// ----------------------------------------------------------------------------
// 2. Create Main CLE Report Node
// ----------------------------------------------------------------------------

CREATE (cle:CLEReport {
  id: "cle-20251107-001",
  title: "From Contrarian Critique to Synthesis: Linear Workflows, AI Agents, Design-Engineering Integration",
  created: datetime("2025-11-07T02:42:04Z"),
  modified: datetime("2025-11-07T02:42:04Z"),
  domain: "engineering",
  subdomain: "workflow-optimization",
  impact: "high",
  confidence: 0.92,
  learning_type: "correction",
  novelty: "significant",
  replication_readiness: "high",
  tags: ["linear", "ai-agents", "design-engineering-integration", "meta-learning", "knowledge-synthesis", "first-principles", "agentic-ai"],
  categories: ["double-loop-learning", "process-design", "tool-evaluation"],
  primary_embedding_text: "A meta-learning experience where initial first-principles critique of Linear workflows was challenged and corrected through research evidence. Core learning: separation of design and engineering is the disease, not process tools. Apple's 50-year Human Interface Guidelines demonstrate form-follows-function reduces friction. Linear becomes API between human intent and AI execution. Integration beats separation.",
  embedding_keywords: ["linear-workflows", "design-engineering-integration", "agentic-ai", "form-follows-function", "first-principles", "meta-learning", "integration-over-separation"]
});

// ----------------------------------------------------------------------------
// 3. Create Participant Nodes
// ----------------------------------------------------------------------------

CREATE (mathieu:Person {
  id: "person-mathieu",
  name: "Mathieu Wauters",
  role: "founder",
  email: "mathieu@justiceos.ai",
  organization: "JusticeOS"
});

CREATE (claude:Person {
  id: "ai-claude-sonnet-4.5",
  name: "Claude",
  role: "ai-assistant",
  model: "claude-sonnet-4-5-20250929",
  provider: "Anthropic"
});

// Link participants to CLE report
MATCH (cle:CLEReport {id: "cle-20251107-001"}),
      (mathieu:Person {id: "person-mathieu"}),
      (claude:Person {id: "ai-claude-sonnet-4.5"})
CREATE (mathieu)-[:PARTICIPATED_IN {role: "founder", contribution: "critical correction on design-engineering separation"}]->(cle)
CREATE (claude)-[:PARTICIPATED_IN {role: "ai-assistant", contribution: "research synthesis and CLE report generation"}]->(cle);

// ----------------------------------------------------------------------------
// 4. Create Learning Nodes (L001-L004)
// ----------------------------------------------------------------------------

CREATE (l1:Learning {
  id: "L001",
  statement: "Separation of design and engineering is the root disease",
  confidence: 0.95,
  evidence_strength: 5,
  actionable: true,
  domain: "product-development",
  impact: "high",
  replication_readiness: "high",
  key_insight: "Sequential design→engineering handoffs increase dev time 30%, reduce quality. Apple's 50-year success: integration from inception.",
  counter_evidence: "Some organizations report success with specialized teams",
  conditions: "Requires culture of cross-functional collaboration and shared ownership"
});

CREATE (l2:Learning {
  id: "L002",
  statement: "Form follows function: Aesthetics and usability are equivalent",
  confidence: 0.90,
  evidence_strength: 5,
  actionable: true,
  domain: "design-principles",
  impact: "high",
  replication_readiness: "high",
  key_insight: "Beautiful design = reduced friction. Minimalism emerges from function optimization. Apple HIG: 50 years of evidence.",
  counter_evidence: "None found - principle validated across domains",
  conditions: "Design must solve real user problems, not pursue aesthetics independently"
});

CREATE (l3:Learning {
  id: "L003",
  statement: "Linear transforms from overhead to API in agentic AI era",
  confidence: 0.88,
  evidence_strength: 4,
  actionable: true,
  domain: "ai-workflow-automation",
  impact: "medium",
  replication_readiness: "high",
  key_insight: "Linear + GitHub Copilot (Oct 2024): Delegate issues to AI agents. 60% faster task creation. AI reads context, writes code, opens PRs.",
  counter_evidence: "Requires adoption of AI coding assistants (78% have access, 23% use weekly)",
  conditions: "Team must integrate GitHub Copilot/Cursor and adopt delegation mindset"
});

CREATE (l4:Learning {
  id: "L004",
  statement: "Delete features, preserve integration infrastructure",
  confidence: 0.85,
  evidence_strength: 4,
  actionable: true,
  domain: "first-principles-engineering",
  impact: "medium",
  replication_readiness: "medium",
  key_insight: "Musk's principle applies to product features (delete unnecessary), NOT organizational systems (preserve integration).",
  counter_evidence: "Over-deletion of coordination tools can fragment teams",
  conditions: "Distinguish between user-facing features and team integration infrastructure"
});

// Link learnings to CLE report
MATCH (cle:CLEReport {id: "cle-20251107-001"}),
      (l1:Learning {id: "L001"}), (l2:Learning {id: "L002"}),
      (l3:Learning {id: "L003"}), (l4:Learning {id: "L004"})
CREATE (cle)-[:PRODUCED]->(l1)
CREATE (cle)-[:PRODUCED]->(l2)
CREATE (cle)-[:PRODUCED]->(l3)
CREATE (cle)-[:PRODUCED]->(l4);

// ----------------------------------------------------------------------------
// 5. Create Evidence Nodes
// ----------------------------------------------------------------------------

CREATE (e1:Evidence {
  id: "E001",
  type: "research_study",
  source: "PLOS One",
  claim: "Design engineers as mediators accelerate innovation (4,665 firms, 1980-2015)",
  strength: "high",
  reliability: 0.95,
  sample_size: 4665,
  date: date("2025-01-15"),
  url: "https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0306626",
  methodology: "Empirical panel data analysis with mediation modeling"
});

CREATE (e2:Evidence {
  id: "E002",
  type: "industry_report",
  source: "Forbes Technology Council",
  claim: "Misalignment between design and development increases dev time by 30%",
  strength: "medium",
  reliability: 0.75,
  date: date("2024-06-12"),
  methodology: "Industry survey and expert panel"
});

CREATE (e3:Evidence {
  id: "E003",
  type: "case_study",
  source: "Apple Human Interface Guidelines",
  claim: "50 years of integrated design-engineering practices (1977-2025)",
  strength: "high",
  reliability: 0.90,
  date: date("2025-01-01"),
  url: "https://developer.apple.com/design/human-interface-guidelines/",
  methodology: "Longitudinal case study and documented design principles"
});

CREATE (e4:Evidence {
  id: "E004",
  type: "product_announcement",
  source: "Linear Blog",
  claim: "GitHub Copilot integration announced October 2024",
  strength: "high",
  reliability: 1.0,
  date: date("2024-10-01"),
  url: "https://linear.app/changelog",
  methodology: "Official product announcement"
});

CREATE (e5:Evidence {
  id: "E005",
  type: "research_study",
  source: "GitHub Next Research",
  claim: "AI agents reduce errors by 91%, 6-8x faster implementation",
  strength: "high",
  reliability: 0.85,
  date: date("2024-09-01"),
  url: "https://githubnext.com/projects/",
  methodology: "Controlled experiments with developer cohorts"
});

CREATE (e6:Evidence {
  id: "E006",
  type: "industry_survey",
  source: "Stack Overflow Developer Survey 2024",
  claim: "78% developers have AI tool access, 23% use weekly",
  strength: "medium",
  reliability: 0.80,
  date: date("2024-06-01"),
  methodology: "Global developer survey (90,000+ respondents)"
});

// Link evidence to learnings
MATCH (l1:Learning {id: "L001"}), (l2:Learning {id: "L002"}), (l3:Learning {id: "L003"}),
      (e1:Evidence {id: "E001"}), (e2:Evidence {id: "E002"}), (e3:Evidence {id: "E003"}),
      (e4:Evidence {id: "E004"}), (e5:Evidence {id: "E005"}), (e6:Evidence {id: "E006"})
CREATE (l1)-[:SUPPORTED_BY {strength: "high", relevance: 0.95}]->(e1)
CREATE (l1)-[:SUPPORTED_BY {strength: "medium", relevance: 0.75}]->(e2)
CREATE (l1)-[:SUPPORTED_BY {strength: "high", relevance: 0.90}]->(e3)
CREATE (l2)-[:SUPPORTED_BY {strength: "high", relevance: 0.95}]->(e3)
CREATE (l3)-[:SUPPORTED_BY {strength: "high", relevance: 1.0}]->(e4)
CREATE (l3)-[:SUPPORTED_BY {strength: "high", relevance: 0.85}]->(e5)
CREATE (l3)-[:SUPPORTED_BY {strength: "medium", relevance: 0.70}]->(e6);

// ----------------------------------------------------------------------------
// 6. Create Concept Nodes
// ----------------------------------------------------------------------------

CREATE (c1:Concept {
  id: "concept-design-engineering-integration",
  name: "Design-Engineering Integration",
  definition: "Co-location of design and engineering functions from project inception, eliminating sequential handoffs",
  domain: "product-development",
  confidence: 0.95,
  aliases: ["integrated teams", "co-located teams", "design-engineering pairing"]
});

CREATE (c2:Concept {
  id: "concept-form-follows-function",
  name: "Form Follows Function",
  definition: "Design principle where aesthetic beauty emerges from functional optimization and friction reduction",
  domain: "design-principles",
  confidence: 0.90,
  origin: "Louis Sullivan (1896), validated by Apple HIG (1977-2025)",
  aliases: ["functional aesthetics", "minimalism", "friction reduction"]
});

CREATE (c3:Concept {
  id: "concept-agentic-ai",
  name: "Agentic AI",
  definition: "Autonomous AI systems that can be delegated tasks and execute multi-step workflows independently",
  domain: "ai-automation",
  confidence: 0.88,
  examples: ["GitHub Copilot", "Cursor", "Replit Agent"],
  characteristics: ["autonomous decision-making", "multi-step execution", "context awareness"]
});

CREATE (c4:Concept {
  id: "concept-sequential-workflow-disease",
  name: "Sequential Workflow Disease",
  definition: "Organizational anti-pattern where design completes before engineering begins, causing 30% time overhead",
  domain: "anti-pattern",
  confidence: 0.95,
  symptoms: ["handoff delays", "misalignment", "rework cycles", "context loss"],
  root_cause: "Separation of design and engineering functions"
});

CREATE (c5:Concept {
  id: "concept-integration-over-separation",
  name: "Integration Over Separation",
  definition: "Universal principle: integrated systems outperform separated systems (design-engineering, product-ops, research-implementation)",
  domain: "systems-thinking",
  confidence: 0.92,
  emergence: "Synthesized from CLE-001 research",
  applications: ["product development", "organizational design", "knowledge management"]
});

// Link concepts to learnings
MATCH (l1:Learning {id: "L001"}), (l2:Learning {id: "L002"}), (l3:Learning {id: "L003"}),
      (c1:Concept {id: "concept-design-engineering-integration"}),
      (c2:Concept {id: "concept-form-follows-function"}),
      (c3:Concept {id: "concept-agentic-ai"}),
      (c4:Concept {id: "concept-sequential-workflow-disease"}),
      (c5:Concept {id: "concept-integration-over-separation"})
CREATE (l1)-[:DEFINES]->(c1)
CREATE (l1)-[:INVALIDATES]->(c4)
CREATE (l2)-[:DEFINES]->(c2)
CREATE (l3)-[:LEVERAGES]->(c3)
CREATE (c3)-[:ENABLES]->(c1)
CREATE (c1)-[:EXEMPLIFIES]->(c5)
CREATE (l1)-[:SUPPORTS]->(c5)
CREATE (c5)-[:CONTRADICTS {
  context: "Design-engineering integration",
  resolution: "Integration enables better separation of concerns at code level"
}]->(c4);

// ----------------------------------------------------------------------------
// 7. Create Tool Nodes
// ----------------------------------------------------------------------------

CREATE (t1:Tool {
  id: "tool-linear",
  name: "Linear",
  category: "project-management",
  purpose: "Issue tracking and project coordination",
  vendor: "Linear",
  integration_points: ["GitHub Copilot", "Cursor", "Figma", "Slack", "GitHub"],
  paradigm_shift: "From human coordination overhead to AI command center",
  adoption: "High (top engineering teams)",
  release_date: date("2020-01-01")
});

CREATE (t2:Tool {
  id: "tool-github-copilot",
  name: "GitHub Copilot",
  category: "ai-agent",
  purpose: "Autonomous code generation and PR creation",
  vendor: "GitHub/Microsoft",
  integration_points: ["Linear", "GitHub", "VS Code", "JetBrains IDEs"],
  adoption: "78% developers have access, 23% use weekly",
  release_date: date("2021-06-01")
});

CREATE (t3:Tool {
  id: "tool-figma",
  name: "Figma",
  category: "design",
  purpose: "Collaborative interface design",
  vendor: "Figma/Adobe",
  integration_points: ["Linear", "GitHub", "Slack", "Jira"],
  adoption: "High (industry standard for web/mobile design)",
  release_date: date("2016-09-01")
});

CREATE (t4:Tool {
  id: "tool-cursor",
  name: "Cursor",
  category: "ai-agent",
  purpose: "AI-first code editor with agentic capabilities",
  vendor: "Cursor",
  integration_points: ["Linear", "GitHub", "VS Code extensions"],
  adoption: "Growing (especially for AI-native development)",
  release_date: date("2023-01-01")
});

// Link tools to learnings and concepts
MATCH (l3:Learning {id: "L003"}), 
      (c3:Concept {id: "concept-agentic-ai"}),
      (t1:Tool {id: "tool-linear"}), (t2:Tool {id: "tool-github-copilot"}),
      (t3:Tool {id: "tool-figma"}), (t4:Tool {id: "tool-cursor"})
CREATE (l3)-[:APPLIES_TO]->(t1)
CREATE (t1)-[:INTEGRATES_WITH {
  announced: date("2024-10-01"),
  capability: "Delegate issues to AI agent for autonomous code generation"
}]->(t2)
CREATE (t1)-[:INTEGRATES_WITH {capability: "Link design attachments to issues"}]->(t3)
CREATE (t1)-[:INTEGRATES_WITH {capability: "AI-assisted task creation and code generation"}]->(t4)
CREATE (t2)-[:IMPLEMENTS]->(c3)
CREATE (t4)-[:IMPLEMENTS]->(c3);

// ----------------------------------------------------------------------------
// 8. Create Principle Nodes
// ----------------------------------------------------------------------------

CREATE (p1:Principle {
  id: "principle-integration-over-separation",
  name: "Integration Over Separation",
  statement: "Integrated teams consistently outperform separated teams across all domains (design-engineering, product-ops, research-implementation)",
  domain: "organizational-design",
  confidence: 0.92,
  evidence_count: 3,
  emerged_from: "cle-20251107-001",
  applications: ["product development", "team structure", "tool selection", "workflow design"],
  anti_patterns: ["sequential handoffs", "siloed teams", "design-as-deliverable"]
});

CREATE (p2:Principle {
  id: "principle-first-principles-thinking",
  name: "First Principles Thinking",
  statement: "Question requirements before solving, delete unnecessary features, simplify before automating",
  domain: "engineering-methodology",
  confidence: 0.85,
  source: "Elon Musk 5-Step Design Process",
  steps: ["Question every requirement", "Delete unnecessary parts", "Simplify or optimize", "Accelerate cycle time", "Automate"],
  limitation: "Applies to product features, not organizational integration infrastructure"
});

CREATE (p3:Principle {
  id: "principle-form-follows-function",
  name: "Form Follows Function",
  statement: "Aesthetic beauty emerges from functional optimization and friction reduction",
  domain: "design",
  confidence: 0.90,
  origin: "Louis Sullivan (1896)",
  validated_by: "Apple Human Interface Guidelines (1977-2025)",
  corollary: "Beautiful design IS reduced friction, not separate concern"
});

// Link principles to learnings and CLE
MATCH (cle:CLEReport {id: "cle-20251107-001"}),
      (l1:Learning {id: "L001"}), (l2:Learning {id: "L002"}), (l4:Learning {id: "L004"}),
      (p1:Principle {id: "principle-integration-over-separation"}),
      (p2:Principle {id: "principle-first-principles-thinking"}),
      (p3:Principle {id: "principle-form-follows-function"})
CREATE (cle)-[:SYNTHESIZED]->(p1)
CREATE (l1)-[:SUPPORTS]->(p1)
CREATE (l2)-[:SUPPORTS]->(p3)
CREATE (l4)-[:APPLIES]->(p2)
CREATE (p1)-[:CONTRADICTS {
  context: "Application scope",
  resolution: "Delete features, preserve integration infrastructure",
  synthesis: "First-principles deletion applies to product, integration applies to organization"
}]->(p2);

// ----------------------------------------------------------------------------
// 9. Create Invalidated Belief Nodes
// ----------------------------------------------------------------------------

CREATE (ib1:InvalidatedBelief {
  id: "IB001",
  statement: "Project management tools add bureaucratic overhead that slows teams",
  invalidated_by: "L003",
  invalidated_at: datetime("2025-11-07T01:45:00Z"),
  root_cause: "Confusion between separation (the disease) and tools (neutral infrastructure)",
  confidence: 0.90,
  previous_belief_strength: 0.70,
  evidence_against: "Linear + AI agents = 60% faster task creation, 91% fewer errors"
});

CREATE (ib2:InvalidatedBelief {
  id: "IB002",
  statement: "Design is a deliverable separate from engineering implementation",
  invalidated_by: "L001",
  invalidated_at: datetime("2025-11-07T01:15:00Z"),
  root_cause: "Sequential workflow disease - treating design as upstream phase",
  confidence: 0.95,
  previous_belief_strength: 0.60,
  evidence_against: "Apple 50 years: design+engineering from inception. 30% time increase from separation."
});

// Link invalidated beliefs
MATCH (cle:CLEReport {id: "cle-20251107-001"}),
      (l1:Learning {id: "L001"}), (l3:Learning {id: "L003"}),
      (ib1:InvalidatedBelief {id: "IB001"}), (ib2:InvalidatedBelief {id: "IB002"})
CREATE (cle)-[:INVALIDATED]->(ib1)
CREATE (cle)-[:INVALIDATED]->(ib2)
CREATE (l3)-[:INVALIDATES]->(ib1)
CREATE (l1)-[:INVALIDATES]->(ib2);

// ----------------------------------------------------------------------------
// 10. Create Pivot Point Nodes
// ----------------------------------------------------------------------------

CREATE (pp1:PivotPoint {
  id: "PP001",
  moment: "User correction on design-engineering separation",
  timestamp: datetime("2025-11-07T01:15:00Z"),
  trigger: "User feedback challenging contrarian analysis",
  trigger_quote: "Design and engineering should always be as close to each other as possible; it results in better products. This is why Apple is so successful.",
  shift: "From 'delete Linear workflows' to 'separation is the disease, not tools'",
  confidence_before: 0.70,
  confidence_after: 0.92,
  cognitive_shift: "Confused symptom (bureaucracy) with disease (separation)",
  impact: "high"
});

CREATE (pp2:PivotPoint {
  id: "PP002",
  moment: "Discovery of Linear + GitHub Copilot integration",
  timestamp: datetime("2025-11-07T01:45:00Z"),
  trigger: "Research on agentic AI workflows (October 2024 announcement)",
  shift: "From 'Linear is overhead' to 'Linear is AI command center'",
  confidence_before: 0.30,
  confidence_after: 0.88,
  cognitive_shift: "Paradigm shift: AI agents transform tool purpose from human coordination to AI delegation",
  impact: "medium"
});

CREATE (pp3:PivotPoint {
  id: "PP003",
  moment: "Apple HIG 50-year evidence synthesis",
  timestamp: datetime("2025-11-07T01:30:00Z"),
  trigger: "Research on form-follows-function with longitudinal evidence",
  shift: "From 'aesthetics vs usability' to 'aesthetics = usability'",
  confidence_before: 0.60,
  confidence_after: 0.90,
  cognitive_shift: "Beautiful design IS reduced friction - not separate concerns",
  impact: "high"
});

// Link pivot points
MATCH (cle:CLEReport {id: "cle-20251107-001"}),
      (l1:Learning {id: "L001"}), (l2:Learning {id: "L002"}), (l3:Learning {id: "L003"}),
      (pp1:PivotPoint {id: "PP001"}), (pp2:PivotPoint {id: "PP002"}), (pp3:PivotPoint {id: "PP003"})
CREATE (cle)-[:EXPERIENCED]->(pp1)
CREATE (cle)-[:EXPERIENCED]->(pp2)
CREATE (cle)-[:EXPERIENCED]->(pp3)
CREATE (pp1)-[:LED_TO]->(l1)
CREATE (pp2)-[:LED_TO]->(l3)
CREATE (pp3)-[:LED_TO]->(l2)
CREATE (pp1)-[:CORRECTED]->(pp2)
CREATE (pp3)-[:REINFORCED]->(pp1);

// ============================================================================
// Verification Queries
// ============================================================================

// Count all nodes created
MATCH (n) WHERE n.id STARTS WITH "cle-20251107-001" OR 
                n.id STARTS WITH "L00" OR 
                n.id STARTS WITH "E00" OR 
                n.id STARTS WITH "concept-" OR 
                n.id STARTS WITH "tool-" OR 
                n.id STARTS WITH "principle-" OR 
                n.id STARTS WITH "person-" OR 
                n.id STARTS WITH "IB00" OR 
                n.id STARTS WITH "PP00"
RETURN labels(n)[0] AS NodeType, count(*) AS Count
ORDER BY Count DESC;

// Verify CLE report connections
MATCH (cle:CLEReport {id: "cle-20251107-001"})-[r]->(connected)
RETURN type(r) AS RelationshipType, labels(connected)[0] AS ConnectedNodeType, count(*) AS Count
ORDER BY Count DESC;

// Verify learning evidence support
MATCH (l:Learning)-[:SUPPORTED_BY]->(e:Evidence)
RETURN l.id AS Learning, l.statement AS Statement, count(e) AS EvidenceCount, avg(e.reliability) AS AvgReliability
ORDER BY EvidenceCount DESC;

// ============================================================================
// END OF SCRIPT
// ============================================================================
