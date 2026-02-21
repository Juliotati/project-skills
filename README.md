# Project Skills

A library of Agent Skills designed to work with the MCP server. Each skill follows the Agent Skills open standard, for compatibility with coding agents such as Antigravity, Gemini CLI, Claude Code, Cursor

# Installation & Discovery

Install any skill from this repository using the skills CLI. This command will automatically detect your active coding agents and place the skill in the appropriate directory.

```bash
# List all available skills in this repository
npx skills add juliotati/project-skills --list

# Install a specific skill
npx skills add juliotati/project-skills --skill feature-structure --global
```

# Available Skills

### feature-structure
A modular, feature-first architectural pattern for Flutter applications. This skill enforces a strict separation of concerns by partitioning features into Data, Domain, and Presentation layers, while utilizing Dart’s library and part system to maintain a unified internal namespace.
