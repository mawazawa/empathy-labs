# CLE Report Template Scaffold v1.0

> **Purpose**: Standardized template for Collective Learning Experience reports optimized for Neo4j GraphRAG, vector embeddings, and collective intelligence extraction.

---

## YAML Frontmatter (Machine-Readable Metadata)

```yaml
---
# Document Metadata
type: "cle-report"  # Collective Learning Experience Report
version: "1.0"
created: "YYYY-MM-DDTHH:MM:SSZ"
modified: "YYYY-MM-DDTHH:MM:SSZ"
status: "draft | reviewed | published | archived"

# Identification
id: "cle-YYYYMMDD-NNN"  # Unique identifier
title: "Brief descriptive title"
slug: "kebab-case-url-slug"

# Classification
domain: "engineering | design | product | business | research"
subdomain: "specific area within domain"
tags: ["keyword1", "keyword2", "keyword3"]  # Free-form tags
categories: ["category1", "category2"]  # Controlled vocabulary

# Context
project: "project-name"
phase: "discovery | design | implementation | validation | iteration"
sprint: "sprint-number or cycle-name"
team: "team-name"

# Participants (Neo4j Person nodes)
participants:
  - id: "person-id-1"
    name: "Full Name"
    role: "founder | engineer | designer | product"
    email: "email@domain.com"
  - id: "person-id-2"
    name: "AI Agent Name"
    role: "ai-assistant | autonomous-agent"
    model: "claude-sonnet-4.5 | gpt-4 | etc"

# Learning Metrics
learning_type: "discovery | validation | correction | synthesis | innovation"
confidence: 0.0-1.0  # Confidence in learnings (0-100%)
impact: "low | medium | high | critical"
replication_readiness: "low | medium | high"  # Can others reproduce this learning?
novelty: "incremental | significant | breakthrough"

# References
related_documents: ["doc-id-1", "doc-id-2"]
external_sources: 
  - url: "https://..."
    title: "Source title"
    relevance: "high | medium | low"

# Vector Embedding Optimization
primary_embedding_text: |
  Key paragraph or summary that best represents this learning.
  Optimized for semantic search and retrieval.
  
embedding_keywords: ["keyword1", "keyword2"]  # For hybrid search
---
```

---

## 1. Executive Summary

**Purpose**: One-paragraph distillation for rapid comprehension and vector search optimization.

```markdown
<!-- 2-4 sentences covering: What was learned, why it matters, what changed -->
[Clear, concise summary that someone could understand in 30 seconds]
```

**TL;DR Learning**:
- **Initial Belief**: [What we thought before]
- **Discovery**: [What we actually learned]
- **Impact**: [What changed as a result]

---

## 2. Ontology Definition (Knowledge Graph Schema)

**Purpose**: Define entity types and relationships for Neo4j extraction.

### 2.1 Node Types

```yaml
# Define all entity types that will be extracted
nodes:
  - type: "Concept"
    properties: ["name", "definition", "domain", "confidence"]
    examples: ["Linear", "Design-Engineering Integration", "Agentic AI"]
    
  - type: "Practice"
    properties: ["name", "description", "effectiveness", "context"]
    examples: ["Move Fast Break Things", "Form Follows Function"]
    
  - type: "Tool"
    properties: ["name", "category", "purpose", "integration_points"]
    examples: ["Linear", "GitHub Copilot", "Figma"]
    
  - type: "Principle"
    properties: ["name", "statement", "domain", "source"]
    examples: ["Form Follows Function", "Delete Before Optimize", "Integration Over Separation"]
    
  - type: "Evidence"
    properties: ["type", "source", "claim", "strength", "date"]
    examples: ["Research Study", "Case Study", "Benchmark Data"]
    
  - type: "Person"
    properties: ["name", "role", "organization", "expertise"]
    examples: ["Elon Musk", "Karri Saarinen", "Mathieu Wauters"]
    
  - type: "Organization"
    properties: ["name", "industry", "size", "notable_for"]
    examples: ["Apple", "Linear", "SpaceX", "Meta"]
```

### 2.2 Relationship Types

```yaml
# Define all relationship types between nodes
relationships:
  - type: "CONTRADICTS"
    from: ["Concept", "Practice", "Principle"]
    to: ["Concept", "Practice", "Principle"]
    properties: ["context", "resolution", "confidence"]
    
  - type: "SUPPORTS"
    from: ["Evidence", "Practice", "Principle"]
    to: ["Concept", "Practice", "Principle"]
    properties: ["strength", "conditions"]
    
  - type: "REQUIRES"
    from: ["Practice", "Tool"]
    to: ["Tool", "Concept", "Principle"]
    properties: ["type", "optional"]
    
  - type: "USED_BY"
    from: ["Tool", "Practice"]
    to: ["Organization", "Person"]
    properties: ["start_date", "effectiveness"]
    
  - type: "EVOLVED_FROM"
    from: ["Concept", "Practice"]
    to: ["Concept", "Practice"]
    properties: ["year", "catalyst"]
    
  - type: "INTEGRATES_WITH"
    from: ["Tool"]
    to: ["Tool"]
    properties: ["integration_type", "maturity"]
    
  - type: "INVALIDATED"
    from: ["Evidence", "Learning"]
    to: ["Concept", "Practice", "Belief"]
    properties: ["reason", "replacement"]
```

---

## 3. Initial Context

**Purpose**: Capture the starting state before the learning occurred.

### 3.1 Triggering Question/Problem

```markdown
[What question, problem, or request initiated this learning experience?]
```

### 3.2 Initial Hypotheses

**Before learning, what did we believe?**

| Hypothesis | Confidence | Basis |
|------------|-----------|-------|
| [Belief/assumption] | High/Med/Low | [Why we believed it] |
| [Belief/assumption] | High/Med/Low | [Why we believed it] |

### 3.3 Existing Mental Models

```markdown
<!-- Capture relevant frameworks, principles, or patterns we were operating under -->
- **Model/Framework 1**: [Description]
- **Model/Framework 2**: [Description]
```

---

## 4. Learning Journey (Chronological)

**Purpose**: Document the exploration path for future reference and pattern recognition.

### 4.1 Research Phase

**Methods Used**:
- [ ] Web search
- [ ] MCP tool research (Linear/Notion/etc)
- [ ] Code review
- [ ] Expert consultation
- [ ] Literature review
- [ ] First principles analysis

**Key Sources Consulted**:

| Source | Type | Key Finding | Reliability |
|--------|------|-------------|-------------|
| [Title/URL] | Research/Article/Doc | [Summary] | High/Med/Low |

### 4.2 Pivot Points

**Document critical moments where understanding shifted**:

```yaml
pivot_points:
  - timestamp: "YYYY-MM-DDTHH:MM:SSZ"
    trigger: "What caused the shift"
    old_belief: "What we thought before"
    new_understanding: "What we realized"
    evidence: "What convinced us"
    confidence_change: "+30%" # How much certainty changed
```

### 4.3 Contradictions Encountered

**Track conflicting information and how it was resolved**:

| Conflict | Source A | Source B | Resolution | Method |
|----------|----------|----------|------------|---------|
| [Topic] | [Claim A] | [Claim B] | [How resolved] | [Research/Test/Expert] |

---

## 5. Core Learnings (Structured Extraction)

**Purpose**: Primary knowledge capture optimized for knowledge graph extraction.

### 5.1 Validated Learnings

**Format**: Each learning as an extractable entity with metadata.

```markdown
#### Learning 001: [Descriptive Title]

**Statement**: [Clear, declarative sentence of what was learned]

**Context**: [Under what conditions is this true?]

**Evidence Strength**: ⭐⭐⭐⭐⭐ (1-5 stars)

**Evidence**:
- [Source 1]: [Specific finding]
- [Source 2]: [Specific finding]
- [Source 3]: [Specific finding]

**Contradicts**: [What previous belief/practice does this invalidate?]

**Replaces/Refines**: [What does this supersede or improve upon?]

**Confidence**: 85% (Low/Medium/High with %)

**Replication**: Can others verify this? [Yes/No/Partial] - [How?]

**Graph Relationships**:
```yaml
- (Learning)-[:INVALIDATES]->(OldBelief: "Linear adds bureaucratic overhead")
- (Learning)-[:SUPPORTED_BY]->(Evidence: "78% dev AI adoption, 91% fewer errors")
- (Learning)-[:REQUIRES]->(Context: "Agentic AI workflows")
```


**Impact**: [What changes because of this learning?]

**Actionable**: [What concrete action does this enable?]

---

#### Learning 002: [Next Learning]
<!-- Repeat structure -->

---
```

### 5.2 Invalidated Beliefs

**Document what was proven wrong**:

```markdown
#### Invalidation 001: [What We Got Wrong]

**Old Belief**: "[What we incorrectly believed]"

**Why We Believed It**: [Rationale that seemed sound]

**Invalidating Evidence**: 
- [Counter-evidence 1]
- [Counter-evidence 2]

**Corrected Understanding**: "[New accurate belief]"

**Root Cause of Error**: [Why the mistake was made]
- Incomplete information
- False analogy
- Overgeneralization
- Outdated source
- Logical fallacy: [type]

**Lesson**: [What this teaches about avoiding similar errors]
```

### 5.3 Synthesis/Integration

**How do learnings connect?**

```markdown
#### Emergent Pattern: [Pattern Name]

**Individual Learnings**:
1. [Learning A]
2. [Learning B]
3. [Learning C]

**Combined Insight**: [What emerges when you view these together?]

**Higher-Order Principle**: [Abstract principle this illustrates]


**Graph Representation**:
```cypher
// Neo4j pattern
(Pattern)-[:SYNTHESIZES]->(:Learning {id: "L001"})
(Pattern)-[:SYNTHESIZES]->(:Learning {id: "L002"})
(Pattern)-[:SYNTHESIZES]->(:Learning {id: "L003"})
(Pattern)-[:PRODUCES]->(:Principle {name: "Higher-order principle"})
```
```

---

## 6. Updated Mental Models

**Purpose**: Document how frameworks/heuristics changed.

### 6.1 Before → After Comparison

| Aspect | Before (Old Model) | After (New Model) | Change Type |
|--------|-------------------|-------------------|-------------|
| [Framework element] | [How we thought about it] | [How we think now] | Refinement/Replacement/Addition |

### 6.2 Decision Framework Updates

```markdown
**When faced with [decision type]**:

**Old approach**: [Previous decision-making process]

**New approach**: [Updated decision-making process]

**Key considerations added**:
- [New factor 1]
- [New factor 2]

**Questions to ask**:
1. [Question stemming from learning]
2. [Question stemming from learning]
```

---

## 7. Practical Applications

**Purpose**: Make learning actionable and measurable.

### 7.1 Immediate Actions

```yaml
actions:
  - id: "A001"
    description: "Specific action to take"
    owner: "person-id"
    deadline: "YYYY-MM-DD"
    success_criteria: "How to measure completion"
    dependencies: ["A002", "tool-setup"]
    
  - id: "A002"
    description: "Another action"
    owner: "person-id"
    deadline: "YYYY-MM-DD"
    success_criteria: "How to measure"
```

### 7.2 Process Changes

```markdown
**Process**: [Name of process being updated]

**Changes**:
- **Add**: [What to add to the process]
- **Remove**: [What to remove from the process]
- **Modify**: [What to change in the process]

**Rationale**: [Why this change based on learnings]

**Rollout Plan**: [How to implement]
```

### 7.3 Tool/Technology Decisions

```markdown
**Decision**: [Adopt/Deprecate/Evaluate] [Tool/Technology]

**Based on Learning**: [Reference to learning ID]

**Rationale**: [Why this decision]

**Migration Path** (if applicable): [How to transition]

**Success Metrics**: [How to measure if this was right decision]
```

---

## 8. Knowledge Graph Export (Neo4j Cypher)

**Purpose**: Ready-to-execute Cypher queries for Neo4j ingestion.

```cypher
// Main CLE Report Node
CREATE (cle:CLEReport {
  id: "cle-YYYYMMDD-NNN",
  title: "Report Title",
  created: datetime("YYYY-MM-DDTHH:MM:SSZ"),
  domain: "engineering",
  impact: "high",
  confidence: 0.85
})

// Learnings
CREATE (l1:Learning {
  id: "L001",
  statement: "Clear declarative learning statement",
  confidence: 0.90,
  evidence_strength: 5,
  actionable: true
})

CREATE (l2:Learning {
  id: "L002",
  statement: "Another learning",
  confidence: 0.75,
  evidence_strength: 4
})

// Invalidated Beliefs
CREATE (old1:Belief {
  id: "OLD001",
  statement: "What we incorrectly believed",
  status: "invalidated",
  invalidated_date: datetime()
})

// Evidence Nodes
CREATE (e1:Evidence {
  id: "E001",
  type: "research_study",
  source: "Source name or URL",
  claim: "What this evidence shows",
  strength: "high",
  date: date("2025-01-15")
})

// Concepts/Tools/Practices
CREATE (c1:Concept {
  id: "C001",
  name: "Concept Name",
  definition: "Clear definition",
  domain: "engineering"
})

CREATE (t1:Tool {
  id: "T001",
  name: "Tool Name",
  category: "project-management",
  maturity: "production"
})

// Relationships
CREATE (cle)-[:PRODUCED]->(l1)
CREATE (cle)-[:PRODUCED]->(l2)
CREATE (l1)-[:INVALIDATES]->(old1)
CREATE (l1)-[:SUPPORTED_BY]->(e1)
CREATE (l1)-[:RELATES_TO]->(c1)
CREATE (l2)-[:REQUIRES]->(t1)
CREATE (e1)-[:SUPPORTS]->(l1)

// Participants
CREATE (p1:Person {
  id: "person-mathieu",
  name: "Mathieu Wauters",
  role: "founder"
})

CREATE (p2:Person {
  id: "ai-claude",
  name: "Claude",
  role: "ai-assistant",
  model: "claude-sonnet-4.5"
})

CREATE (cle)-[:PARTICIPATED_BY]->(p1)
CREATE (cle)-[:PARTICIPATED_BY]->(p2)

RETURN cle, l1, l2, old1, e1, c1, t1, p1, p2
```

---

## 9. Vector Embedding Optimization

**Purpose**: Optimize for semantic search and RAG retrieval.

### 9.1 Primary Embedding Content

```markdown
<!-- This section is specifically designed for embedding generation -->
<!-- Keep focused, clear, and comprehensive -->

**Context**: [1-2 sentences on the situation]

**Key Learnings Summary**:
1. [Learning 1 in clear language]
2. [Learning 2 in clear language]
3. [Learning 3 in clear language]

**Core Insight**: [The central takeaway in one powerful sentence]

**Practical Impact**: [What changed and why it matters]

**Keywords for retrieval**: keyword1, keyword2, keyword3, domain-term1, domain-term2
```

### 9.2 Semantic Chunks (For RAG)

```markdown
<!-- Break content into semantically complete chunks -->
<!-- Each chunk should stand alone and be retrievable -->

#### Chunk 1: [Topic]
[Self-contained explanation with context]

#### Chunk 2: [Topic]
[Self-contained explanation with context]
```

---

## 10. Meta-Learning (Learning About Learning)

**Purpose**: Capture insights about the learning process itself.

### 10.1 Process Quality

**What worked well**:
- [Effective research method]
- [Helpful tool/approach]

**What slowed us down**:
- [Obstacle or inefficiency]
- [Missing information]

**What to improve next time**:
- [Process improvement]
- [Tool/resource to have ready]

### 10.2 Cognitive Biases Detected

```markdown
**Bias**: [Name of bias]
**How it manifested**: [Description]
**How we corrected**: [Method used]
**Prevention**: [How to avoid in future]
```

### 10.3 Research Quality Assessment

| Criterion | Rating (1-5) | Notes |
|-----------|--------------|-------|
| Source diversity | ⭐⭐⭐⭐⭐ | Mix of academic, industry, primary sources |
| Evidence strength | ⭐⭐⭐⭐☆ | Most claims backed by data |
| Methodological rigor | ⭐⭐⭐☆☆ | Some reliance on anecdotal |
| Replicability | ⭐⭐⭐⭐⭐ | Clear steps for verification |
| Novelty | ⭐⭐⭐⭐☆ | New synthesis of known facts |

---

## 11. Future Exploration

**Purpose**: Identify what still needs investigation.

### 11.1 Open Questions

```yaml
open_questions:
  - id: "Q001"
    question: "Specific unanswered question"
    importance: "high | medium | low"
    complexity: "simple | moderate | complex"
    estimated_effort: "hours | days | weeks"
    dependencies: ["resource-needed", "access-required"]
```

### 11.2 Hypotheses to Test

```markdown
**Hypothesis**: [Testable claim]

**Test method**: [How to validate/invalidate]

**Success criteria**: [What would prove it]

**Failure criteria**: [What would disprove it]

**Estimated effort**: [Time/resources needed]
```

### 11.3 Related Areas to Explore

- [Connected topic 1] - [Why relevant]
- [Connected topic 2] - [Why relevant]

---

## 12. References & Attribution

**Purpose**: Full sourcing for verification and graph linking.

### 12.1 Primary Sources

```yaml
sources:
  - id: "S001"
    type: "research_paper | article | documentation | book"
    title: "Full title"
    author: "Author name"
    organization: "Org if applicable"
    url: "https://..."
    accessed_date: "YYYY-MM-DD"
    key_findings: "What we extracted"
    reliability: "high | medium | low"
    citation: "Formal citation if applicable"
```

### 12.2 Tools Used

```markdown
- **Linear MCP**: Issue search, documentation research
- **WebSearch**: General research queries  
- **Desktop Commander**: File operations, process management
- **GitHub MCP**: Code repository research
```

### 12.3 MCP Server Capabilities Audit

```yaml
# Document which MCP servers are available and functional
mcp_audit:
  - server: "exa"
    status: "error"
    error: "400 - API configuration issue"
    tools: ["web_search_exa", "get_code_context_exa"]
    
  - server: "linear"
    status: "operational"
    tools: ["search_documentation", "list_issues", "create_issue"]
    
  - server: "desktop-commander"
    status: "operational"
    tools: ["read_file", "write_file", "start_search"]
```

---

## 13. Change Log

**Purpose**: Track evolution of this CLE report over time.

```yaml
changelog:
  - version: "1.0"
    date: "YYYY-MM-DD"
    author: "person-id"
    changes: "Initial creation"
    
  - version: "1.1"
    date: "YYYY-MM-DD"
    author: "person-id"
    changes: "Added evidence E002, updated confidence on L001"
```

---

## Appendix A: JSON-LD Export (Schema.org)

**Purpose**: Structured data for web/API consumption.

```json
{
  "@context": "https://schema.org",
  "@type": "LearningResource",
  "name": "CLE Report Title",
  "description": "Brief description",
  "dateCreated": "YYYY-MM-DD",
  "dateModified": "YYYY-MM-DD",
  "author": {
    "@type": "Person",
    "name": "Author Name"
  },
  "about": [
    {"@type": "Thing", "name": "Topic 1"},
    {"@type": "Thing", "name": "Topic 2"}
  ],
  "educationalLevel": "Advanced",
  "learningResourceType": "Research Report",
  "keywords": "keyword1, keyword2, keyword3"
}
```

---

## Appendix B: Extraction Commands

**Purpose**: Commands to extract this data into Neo4j.

```bash
# Extract entities and relationships
python scripts/extract_cle_to_neo4j.py \
  --input docs/reports/YYYY/MM/FILENAME.md \
  --neo4j-uri bolt://localhost:7687 \
  --embedding-model voyage-2

# Generate vector embeddings
python scripts/generate_embeddings.py \
  --input docs/reports/YYYY/MM/FILENAME.md \
  --model voyage-2 \
  --output embeddings/cle-YYYYMMDD-NNN.json

# Validate schema compliance
python scripts/validate_cle.py \
  --input docs/reports/YYYY/MM/FILENAME.md \
  --schema schemas/cle-v1.0.json
```

---

## Template Usage Guidelines

### When to Create a CLE Report

Create a CLE report when:
- ✅ Significant learning occurred that others could benefit from
- ✅ Initial understanding was challenged or refined
- ✅ Multiple sources were synthesized into new insights
- ✅ False beliefs were identified and corrected
- ✅ Process improvements were discovered
- ✅ Tool/technology decisions were made based on evidence

### When NOT to Create a CLE Report

Skip CLE reports for:
- ❌ Routine bug fixes with no learning component
- ❌ Simple information lookups
- ❌ Incremental updates to existing docs
- ❌ Standard task completion without insights

### Quality Checklist

Before publishing:
- [ ] YAML frontmatter is complete and valid
- [ ] All learnings have evidence citations
- [ ] Confidence levels are honest (not inflated)
- [ ] Contradictions are acknowledged and addressed
- [ ] Graph ontology is clearly defined
- [ ] Cypher queries are tested and functional
- [ ] Vector embedding content is optimized
- [ ] Open questions are documented
- [ ] Sources are properly attributed
- [ ] Action items have owners and deadlines

---

**Version**: 1.0  
**Created**: 2025-11-07  
**Author**: Claude (AI Assistant) + Mathieu Wauters  
**Purpose**: Maximize collective intelligence through structured learning capture  
**License**: MIT (adapt freely for your organization)

---

*This template is designed to work with:*
- Neo4j Aura (graph database)
- Voyage AI (vector embeddings)
- LLM-based entity extraction
- GraphRAG retrieval systems
- Organizational knowledge bases
