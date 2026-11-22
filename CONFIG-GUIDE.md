# Everything Gemini and Antigravity (EGA) — Master Configuration Guide

This guide details the high-end architecture, lifecycle automation, permissions system, and 37-server MCP catalog bundled within the global **EGA** plugin.

---

## 1. Architecture Overview

EGA bridges the entire operator layer to Gemini and Antigravity:
- **425 Skills**: 327 specialized domain workflows + 98 converted slash commands.
- **72 Subagents**: Architect, Planner, Code Reviewer, TDD Guide, Security Reviewer, and specialized language/framework specialists.
- **122 Rules**: Always-on and glob-matched contextual coding standards across Angular, TypeScript, Python, React, Rust, Go, Swift, and more.
- **6 Native Lifecycle Hooks**: Config protection, command safety, doc validation, edit batching, format/typechecking, and console.log inspection.
- **37 MCP Servers**: Complete developer ecosystem (Core tools active out-of-the-box, with optional services pre-wired for 1-click activation).

---

## 2. Lifecycle Hooks (`hooks.json`)

Hooks execute via `node ./scripts/hooks/antigravity-hook-bridge.js`, translating Antigravity's protojson hook contract (`PreToolUse`, `PostToolUse`, `Stop`) to execute local validations:

| Hook ID | Event | Target Tools | Purpose | Default State |
| :--- | :--- | :--- | :--- | :--- |
| `ega-command-safety` | `PreToolUse` | `run_command` | Intercepts dangerous operations (`--no-verify`, destructive deletes, git push checks). | **Enabled** |
| `ega-config-protection` | `PreToolUse` | `write_file`, `edit_file` | Blocks accidental corruption of linter, formatter, or security configs. | **Enabled** |
| `ega-doc-file-warning` | `PreToolUse` | `write_file` | Warns against scattering unstructured documentation outside project docs. | **Enabled** |
| `ega-post-edit-accumulator`| `PostToolUse`| `write_file`, `edit_file` | Tracks modified source files across a turn for batch linting. | **Enabled** |
| `ega-stop-format-typecheck`| `Stop` | Session end | Automatically runs Prettier/Biome formatting and TypeScript compiler checks. | **Enabled** |
| `ega-stop-check-console-log`| `Stop` | Session end | Audits modified code for leftover `console.log` statements before completion. | **Enabled** |

### Customizing Hook Behavior
You can adjust hook execution dynamically using environment variables or in `.env`:
- `EGA_HOOKS_ENABLED=false`: Master kill switch for all hooks.
- `EGA_HOOK_PROFILE=minimal|standard|strict`:
  - `minimal`: Command safety only.
  - `standard` (default): Balanced safety, warnings, and formatting.
  - `strict`: Enables extra fact-forcing confirmation gates on sensitive files.
- `EGA_DISABLED_HOOKS=hook1,hook2`: Disables specific hook IDs without altering others.

---

## 3. Permissions & Auto-Accept Strategy

Antigravity controls agent permissions centrally via `~/.gemini/settings.json`.
To give the agent frictionless productivity while retaining safety:
```json
{
  "permissions": {
    "allow": [
      "read_file",
      "list_directory",
      "search_file_content",
      "glob",
      "run_shell_command",
      "web_fetch",
      "edit_file",
      "write_file",
      "run_command",
      "manage_task"
    ]
  }
}
```
*Note: Because EGA's PreToolUse safety hooks inspect every command and file write before execution, having these tools in `allow` lets the agent work autonomously while safety gates block dangerous patterns.*

---

## 4. MCP Servers Catalog (`mcp_config.json`)

The 37 MCP servers are categorized for flexibility and zero startup friction:

### Active Out-of-the-Box (Zero-Config)
These servers require no credentials and are enabled by default:
1. **`chrome-devtools`**: Chrome browser automation and network/console inspection.
2. **`sequential-thinking`**: Step-by-step reasoning and dynamic hypothesis evaluation.
3. **`memory`**: Persistent cross-turn memory graph.
4. **`token-optimizer`**: Context compression and deduplication.
5. **`magic`**: Magic UI component generator.
6. **`playwright`**: Headless browser automation.
7. **`cloudflare-docs`**: Official Cloudflare documentation search.
8. **`laraplugins`**: Laravel package and ecosystem search.

### Pre-Wired On-Demand Services
These servers have `"disabled": true` in `mcp_config.json` to guarantee zero startup errors until you provide credentials:
- **Developer Tools**: `github`, `jira`, `confluence`, `codescene`, `filesystem`
- **Web Agents & Search**: `firecrawl`, `exa-web-search`, `browserbase`, `browser-use`, `parallel-search`, `arcmira`
- **Databases & Cloud**: `supabase`, `clickhouse`, `railway`, `vercel`, `cloudflare-workers-builds`, `cloudflare-workers-bindings`, `cloudflare-observability`
- **AI & Memory**: `fal-ai`, `memxus`, `omega-memory`, `deja-vu`, `longhand`, `nexus`, `ito-compute`, `devfleet`, `evalview`, `mnemosyne-os`, `ega-memory-vault`

To activate any pre-wired server:
1. Provide the corresponding environment variable (see [.env.example](./.env.example)).
2. Toggle `"disabled": false` in [mcp_config.json](./mcp_config.json) or toggle it on the [EGA Customization page](customization://ega).
