# Neo4j CLE Report Ingestion Scripts

This directory contains scripts for ingesting Collective Learning Experience (CLE) reports into the Neo4j knowledge graph for GraphRAG retrieval.

## Prerequisites

### 1. Neo4j Aura Database

You need an active Neo4j Aura instance. If you don't have one:

1. Go to [Neo4j Aura](https://neo4j.com/cloud/aura/)
2. Create a free instance (or use existing)
3. Save your credentials:
   - **URI**: `neo4j+s://xxxxxxxx.databases.neo4j.io`
   - **Username**: `neo4j`
   - **Password**: `[your-password]`

### 2. Configure MCP Server

Update your MCP server configuration with Neo4j credentials:

**For `neo4j-alanse` MCP server** (in your MCP settings):
```json
{
  "neo4j-alanse": {
    "uri": "neo4j+s://xxxxxxxx.databases.neo4j.io",
    "username": "neo4j",
    "password": "your-password-here"
  }
}
```

**For `docker-mcp-gateway` MCP server**:
```json
{
  "docker-mcp-gateway": {
    "neo4j": {
      "uri": "neo4j+s://xxxxxxxx.databases.neo4j.io",
      "username": "neo4j",
      "password": "your-password-here"
    }
  }
}
```

## Ingestion Methods

### Method 1: Neo4j Browser (Recommended)

1. Open Neo4j Browser at your Aura instance URL
2. Copy the entire contents of `ingest-cle-report.cypher`
3. Paste into the Neo4j Browser query editor
4. Execute the script
5. Verify results with the verification queries at the end of the script

### Method 2: cypher-shell CLI

```bash
# Install cypher-shell if not already installed
brew install cypher-shell  # macOS
# Or download from https://neo4j.com/download-center/

# Execute the ingestion script
cypher-shell -a neo4j+s://xxxxxxxx.databases.neo4j.io \
  -u neo4j \
  -p your-password-here \
  < scripts/neo4j/ingest-cle-report.cypher
```

### Method 3: MCP Tools (Future)

Once MCP Neo4j authentication is configured, you can ingest directly via Claude Code:

```typescript
// This will work once authentication is fixed
await mcp.neo4j.execute_query({
  query: await fs.readFile('scripts/neo4j/ingest-cle-report.cypher', 'utf-8')
});
```

## What Gets Ingested

The script creates a complete knowledge graph for **CLE-001** (Linear AI Workflows):

### Node Types Created

- **1 CLEReport**: Main report metadata
- **2 Person nodes**: Participants (Mathieu, Claude)
- **4 Learning nodes**: Core validated learnings (L001-L004)
- **6 Evidence nodes**: Research studies, case studies, product announcements
- **5 Concept nodes**: Key concepts (Design-Engineering Integration, Agentic AI, etc.)
- **4 Tool nodes**: Linear, GitHub Copilot, Figma, Cursor
- **3 Principle nodes**: Integration Over Separation, First Principles, Form Follows Function
- **2 InvalidatedBelief nodes**: Beliefs corrected during learning
- **3 PivotPoint nodes**: Moments when understanding shifted

### Relationship Types Created

- `PARTICIPATED_IN`: Person → CLEReport
- `PRODUCED`: CLEReport → Learning
- `SUPPORTED_BY`: Learning → Evidence (with strength and relevance)
- `DEFINES`: Learning → Concept
- `INVALIDATES`: Learning → Concept/InvalidatedBelief
- `LEVERAGES`: Learning → Concept
- `ENABLES`: Concept → Concept
- `EXEMPLIFIES`: Concept → Principle
- `SUPPORTS`: Learning → Principle
- `APPLIES_TO`: Learning → Tool
- `INTEGRATES_WITH`: Tool → Tool (with integration details)
- `IMPLEMENTS`: Tool → Concept
- `SYNTHESIZED`: CLEReport → Principle
- `APPLIES`: Learning → Principle
- `CONTRADICTS`: Principle → Principle (with resolution context)
- `INVALIDATED`: CLEReport → InvalidatedBelief
- `EXPERIENCED`: CLEReport → PivotPoint
- `LED_TO`: PivotPoint → Learning
- `CORRECTED`: PivotPoint → PivotPoint
- `REINFORCED`: PivotPoint → PivotPoint

## Verification Queries

After ingestion, run these queries in Neo4j Browser to verify:

### 1. Count Nodes by Type
```cypher
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
```

**Expected output**:
```
NodeType           Count
Evidence           6
Concept            5
Learning           4
Tool               4
Principle          3
PivotPoint         3
InvalidatedBelief  2
Person             2
CLEReport          1
```

### 2. Verify CLE Report Connections
```cypher
MATCH (cle:CLEReport {id: "cle-20251107-001"})-[r]->(connected)
RETURN type(r) AS RelationshipType, labels(connected)[0] AS ConnectedNodeType, count(*) AS Count
ORDER BY Count DESC;
```

### 3. Check Evidence Support for Learnings
```cypher
MATCH (l:Learning)-[:SUPPORTED_BY]->(e:Evidence)
RETURN l.id AS Learning, 
       l.statement AS Statement, 
       count(e) AS EvidenceCount, 
       avg(e.reliability) AS AvgReliability
ORDER BY EvidenceCount DESC;
```

### 4. Visualize Full Graph
```cypher
MATCH (cle:CLEReport {id: "cle-20251107-001"})-[r*1..2]-(connected)
RETURN cle, r, connected
LIMIT 100;
```

## Troubleshooting

### Authentication Errors

**Error**: `The client is unauthorized due to authentication failure`

**Solutions**:
1. Verify Neo4j Aura instance is running
2. Check credentials in MCP server configuration
3. Ensure firewall/network allows connection to Aura
4. Use Neo4j Browser method as fallback

### Constraint Violations

**Error**: `Node already exists with this ID`

**Solution**: Clear existing data first:
```cypher
MATCH (n) WHERE n.id STARTS WITH "cle-20251107-001" OR 
                n.id STARTS WITH "L00" OR 
                n.id STARTS WITH "E00" OR 
                n.id STARTS WITH "concept-" OR 
                n.id STARTS WITH "tool-" OR 
                n.id STARTS WITH "principle-" OR 
                n.id STARTS WITH "person-" OR 
                n.id STARTS WITH "IB00" OR 
                n.id STARTS WITH "PP00"
DETACH DELETE n;
```

### Missing Relationships

**Error**: Some relationships not created

**Solution**: Ensure you execute the ENTIRE script in one session. Neo4j Browser may split on `;` - use the "Run all" option or paste the entire file.

## Next Steps

After successful ingestion:

1. **Generate Vector Embeddings**: Use Voyage AI to create embeddings for semantic search
2. **Test GraphRAG Queries**: Combine graph traversal with vector similarity
3. **Create Extraction Pipeline**: Automate ingestion for future CLE reports
4. **Build RAG Interface**: Query interface that combines Neo4j + vector search

## Schema Evolution

The ontology is defined in the CLE report template:

- **See**: `docs/reports/2025/11/20251107T024204Z_cle-template-scaffold.md`
- **Section**: "3. Ontology Definition"

As new node types or relationships are needed, update both:
1. The template scaffold
2. This ingestion script
3. The schema documentation

## Related Files

- **CLE Report**: `docs/reports/2025/11/20251107T024204Z_cle-001-linear-ai-workflows-meta-learning.md`
- **Template**: `docs/reports/2025/11/20251107T024204Z_cle-template-scaffold.md`
- **This Script**: `scripts/neo4j/ingest-cle-report.cypher`

---

**Last Updated**: 2025-11-07  
**Version**: 1.0  
**Author**: Claude (Sonnet 4.5) + Mathieu Wauters
