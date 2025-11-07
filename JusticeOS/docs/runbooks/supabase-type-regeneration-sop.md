# SOP: Regenerating Supabase TypeScript Types

**Purpose**: Properly fix TypeScript errors caused by database schema changes instead of suppressing them with `@ts-expect-error` comments.

**When to Use**: When you encounter TypeScript errors for tables/columns that exist in the Supabase database but are missing from generated type definitions.

**Time Required**: ~30 seconds
**Difficulty**: Easy
**Tools Required**: Supabase MCP or Supabase CLI

---

## Decision Tree: To Regenerate or Not to Regenerate

```
TypeScript error: Property 'table_name' does not exist
    ↓
Does table exist in Supabase database?
    ├─ NO → Table doesn't exist, error is correct
    │       Action: Create table via migration first
    │
    └─ YES → Types are out of date
        ↓
    Is this error appearing in multiple files?
        ├─ YES → DEFINITELY regenerate types (fixes all at once)
        │
        └─ NO/UNSURE → Still regenerate types (same effort as comment)
            ↓
    **DECISION: Regenerate types using Method A (Supabase MCP) or Method B (Supabase CLI)**
```

---

## ⚠️ ANTI-PATTERN: What NOT to Do

**❌ NEVER do this:**

```typescript
// @ts-expect-error - courthouse_signups table not in generated types yet
const { data } = await supabase.from('courthouse_signups').select('*');
```

**Why this is wrong:**
- Creates technical debt
- Masks real type safety issues
- Doesn't fix root cause
- Needs to be applied multiple times if error repeats
- Makes codebase harder to maintain

**Exception**: Only use `@ts-expect-error` when:
- You're working with a third-party library with incorrect types
- There's a TypeScript compiler bug you're working around
- It's a known issue with a filed bug report

---

## Method A: Regenerate Using Supabase MCP (Recommended)

### Prerequisites
- Supabase MCP server configured in Claude Code
- `NEXT_PUBLIC_SUPABASE_URL` and `NEXT_PUBLIC_SUPABASE_ANON_KEY` in environment

### Steps

1. **Use Supabase MCP to get schema**:
   ```
   Ask Claude Code: "Use Supabase MCP to regenerate the database types"
   ```

2. **Verify the generated file**:
   - Location: `lib/supabase/database.types.ts`
   - Should contain all current tables and their columns

3. **Run type check to confirm**:
   ```bash
   npm run typecheck
   ```

4. **Commit the updated types**:
   ```bash
   git add lib/supabase/database.types.ts
   git commit -m "chore: regenerate Supabase types after schema update"
   ```

### Advantages
- ✅ Works within Claude Code environment
- ✅ No CLI installation required
- ✅ Automatically handles authentication
- ✅ Fastest method when working with AI assistant

---

## Method B: Regenerate Using Supabase CLI

### Prerequisites
- Supabase CLI installed (`npm i -g supabase`)
- Supabase project ID from dashboard or `.env`

### Steps

1. **Find your project ID**:
   ```bash
   # From environment file
   grep NEXT_PUBLIC_SUPABASE_URL .env.local
   # URL format: https://<PROJECT_ID>.supabase.co
   ```

2. **Regenerate types**:
   ```bash
   npx supabase gen types typescript \
     --project-id <PROJECT_ID> \
     > lib/supabase/database.types.ts
   ```

3. **Verify the generated file**:
   ```bash
   head -20 lib/supabase/database.types.ts
   ```

4. **Run type check**:
   ```bash
   npm run typecheck
   ```

5. **Commit**:
   ```bash
   git add lib/supabase/database.types.ts
   git commit -m "chore: regenerate Supabase types after schema update"
   ```

### Troubleshooting

**Error: "Your account does not have the necessary privileges"**
- Solution: Use Method A (Supabase MCP) instead
- Or: Check project ID is correct
- Or: Ensure you're authenticated to Supabase CLI

**Error: "Project not found"**
- Solution: Verify project ID from Supabase dashboard
- URL: https://supabase.com/dashboard/project/<PROJECT_ID>

---

## After Regeneration Checklist

- [ ] `lib/supabase/database.types.ts` file updated
- [ ] New tables/columns appear in types file
- [ ] `npm run typecheck` passes without errors
- [ ] No `@ts-expect-error` comments added as workaround
- [ ] Changes committed to git
- [ ] If errors persist, check RLS policies or table permissions

---

## Common Scenarios

### Scenario 1: Added New Table via Migration

**Situation**: Created `courthouse_signups` table via Supabase migration

**Action**:
```bash
# Run migration first
npx supabase db push

# Then regenerate types
npx supabase gen types typescript --project-id <PROJECT_ID> > lib/supabase/database.types.ts
```

### Scenario 2: Multiple TypeScript Errors for Same Table

**Situation**: Seeing errors like:
```
app/api/auth/verify-phone/route.ts(45,20): error TS2339: Property 'courthouse_signups' does not exist
app/api/payments/create-intent/route.ts(78,20): error TS2339: Property 'courthouse_signups' does not exist
app/api/payments/confirm/route.ts(102,20): error TS2339: Property 'courthouse_signups' does not exist
```

**Wrong approach**: Add `@ts-expect-error` to each file (5 minutes)

**Correct approach**: Regenerate types once (30 seconds)

### Scenario 3: Added New Column to Existing Table

**Situation**: Added `phone_verified_at` column to existing table

**Action**: Same as Method A or B - regenerate entire types file

---

## Automation Opportunities

### Pre-Commit Hook (Future Enhancement)

```bash
# .husky/pre-commit
# Warn if types file is older than migrations
if [[ supabase/migrations/* -nt lib/supabase/database.types.ts ]]; then
  echo "⚠️  Database types may be out of date. Run: npm run db:types"
  exit 1
fi
```

### Package.json Script

```json
{
  "scripts": {
    "db:types": "npx supabase gen types typescript --project-id $PROJECT_ID > lib/supabase/database.types.ts",
    "db:push": "npx supabase db push && npm run db:types"
  }
}
```

---

## Cost-Benefit Analysis

| Approach | Time | Files Modified | Technical Debt | Maintainability |
|----------|------|----------------|----------------|-----------------|
| **Regenerate Types** | 30 seconds | 1 | None | ✅ Excellent |
| **Add @ts-expect-error** | 1 min/instance | Many | High | ❌ Poor |

**Rule of Thumb**: If you're considering adding a second `@ts-expect-error` for the same table, you should have regenerated types instead of adding the first one.

---

## Related Documents

- [Dumbest Thought-Chain Award: TypeScript Types](../retrospectives/2025/11/20251107T024118Z_dumbest-thought-chain-award-typescript-types.md)
- [Supabase Documentation](https://supabase.com/docs/guides/api/generating-types)
- [TypeScript Type Safety](../guides/typescript-strict-mode.md)

---

**Last Updated**: 2025-11-07
**Owner**: Engineering Team
**Review Cycle**: Quarterly
