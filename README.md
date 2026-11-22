# Everything Gemini and Antigravity (EGA)

[![Antigravity Plugin](https://img.shields.io/badge/Antigravity-Plugin-blue.svg)](https://antigravity.google)
[![Version](https://img.shields.io/badge/version-2.3.0-green.svg)](./plugin.json)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](./LICENSE)
[![Skills](https://img.shields.io/badge/skills-425-purple.svg)](./skills)
[![Agents](https://img.shields.io/badge/agents-72-orange.svg)](./agents)
[![MCP Servers](https://img.shields.io/badge/mcp--servers-37-blue.svg)](./mcp_config.json)

> **The complete, production-grade autonomous operator layer for Google Gemini and Antigravity.**
> Bringing 72 specialized subagents, 425 workflow skills, 122 coding rules, 37 pre-wired MCP servers, and native lifecycle safety hooks into a unified, installable plugin.

---

## Quick Install

Install globally into Antigravity with a single command:

```bash
agy plugin install https://github.com/gamiheme/ega
```

*Or install from a local release archive:*

```bash
agy plugin install ./ega.zip
```

Once installed, EGA is **immediately active** across all workspaces and sessions.

---

## Core Ecosystem Components

| Component | Quantity | Description |
| :--- | :---: | :--- |
| **Workflow Skills** | **425** | End-to-end engineering procedures, TDD cycles, security audits, and 98 converted slash commands (`/aside`, `/checkpoint`, `/build-fix`, etc.). |
| **Specialized Subagents** | **72** | Autonomous task delegates: Architect, Planner, TDD Guide, Code Reviewer, Security Reviewer, and language specialists (TypeScript, Python, Go, Rust, Swift, Java, C#, etc.). |
| **Rules & Guardrails** | **122** | Always-on orchestration guidelines and contextual file-glob rules enforcing clean code, immutability, and framework best practices. |
| **MCP Servers** | **37** | Full developer ecosystem: 8 zero-config servers active out-of-the-box, plus 29 pre-wired on-demand services (GitHub, Jira, Supabase, Firecrawl, Exa, etc.). |
| **Lifecycle Hooks** | **9** | Native pre-tool and post-tool lifecycle automation for command safety, config protection, batch formatting, and console.log auditing. |

---

## 1. Specialized Subagents (72 Agents)

EGA comes bundled with dedicated subagents designed for autonomous delegation:

- **Orchestration**: `architect`, `planner`, `tdd-guide`, `code-reviewer`, `security-reviewer`, `build-error-resolver`
- **Frontend & UI**: `react-reviewer`, `vue-reviewer`, `a11y-architect`, `frontend-patterns`
- **Backend & Cloud**: `database-reviewer`, `fastapi-reviewer`, `django-reviewer`, `python-reviewer`, `go-reviewer`, `rust-reviewer`, `java-reviewer`, `csharp-reviewer`
- **Quality & E2E**: `e2e-runner`, `silent-failure-hunter`, `performance-optimizer`, `refactor-cleaner`

All subagents conform to Antigravity's native schema (`subagent: true`, `mainAgent: false`) and map tools directly to Antigravity primitives (`read_file`, `edit_file`, `write_file`, `run_command`, `manage_task`, `search_web`).

---

## 2. Native Lifecycle Hooks

EGA hooks operate via a native bridge adapter executing Antigravity's protojson hook contract:

- **`ega-command-safety` (`PreToolUse`)**: Blocks `--no-verify` flags, unauthorized deletions, and dangerous shell commands.
- **`ega-config-protection` (`PreToolUse`)**: Prevents accidental modification or weakening of linters, formatters, and security configs (`.eslintrc`, `tsconfig.json`).
- **`ega-doc-file-warning` (`PreToolUse`)**: Prevents unorganized documentation sprawl by enforcing standard doc paths.
- **`ega-post-edit-accumulator` (`PostToolUse`)**: Collects modified files across a turn for batch verification.
- **`ega-stop-format-typecheck` (`Stop`)**: Automatically runs batch formatting (Biome/Prettier) and TypeScript compiler verification (`tsc`) before completing the response.
- **`ega-stop-check-console-log` (`Stop`)**: Audits touched code for leftover `console.log` statements.

### Hook Strictness Profiles
You can customize hook behavior using environment variables:

```bash
# Minimal: Core command safety only
export EGA_HOOK_PROFILE=minimal

# Standard (Default): Full safety, warnings, format & typecheck on stop
export EGA_HOOK_PROFILE=standard

# Strict: Adds fact-forcing confirmation gates on sensitive files
export EGA_HOOK_PROFILE=strict

# Master kill-switch
export EGA_HOOKS_ENABLED=false
```

---

## 3. MCP Servers Catalog (37 Servers)

### Active Out-of-the-Box (Zero-Config)
Enabled immediately with no API keys required:
1. `chrome-devtools`: Web automation and browser console/network debugging
2. `sequential-thinking`: Step-by-step hypothesis testing and reasoning decomposition
3. `memory`: Persistent session knowledge graph
4. `token-optimizer`: Context deduplication and compression
5. `magic`: Magic UI component generator
6. `playwright`: Headless browser automation
7. `cloudflare-docs`: Official Cloudflare documentation search
8. `laraplugins`: Laravel package discovery

### Pre-Wired On-Demand Services
Pre-configured with `"disabled": true` to eliminate startup errors until you provide credentials:
- **Developer Tools**: `github`, `jira`, `confluence`, `codescene`, `filesystem`
- **Web & Agents**: `firecrawl`, `exa-web-search`, `browserbase`, `browser-use`, `parallel-search`, `arcmira`
- **Cloud & Databases**: `supabase`, `clickhouse`, `railway`, `vercel`, `cloudflare-workers-builds`, `cloudflare-workers-bindings`, `cloudflare-observability`
- **AI & Memory**: `fal-ai`, `memxus`, `omega-memory`, `deja-vu`, `longhand`, `nexus`, `ito-compute`, `devfleet`, `evalview`, `mnemosyne-os`, `ega-memory-vault`

To activate any pre-wired service:
1. Set the API key in your environment or `.env` file (see [`.env.example`](./.env.example)).
2. Toggle `"disabled": false` in [`mcp_config.json`](./mcp_config.json) or toggle it on the [Customization page](customization://ega).

---

## Verification & Quality Gate

Run the official Antigravity plugin validator:

```bash
agy plugin validate ./
```

Result:
```text
skills 425 · agents 72 · rules 122 · hooks 9 · mcpServers 37 · sidecars 0
✔ Validation passed
```

---

## License & Attribution

EGA is released under the **[MIT License](./LICENSE)**.

- Based on the Everything Claude Code (ECC) architecture by Affaan Mustafa.
- Adapted, expanded, and modernized for Google Gemini and Antigravity by EGA Contributors.
