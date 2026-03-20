---
name: gh-pm
description: Generates a comprehensive backlog of GitHub Issues natively, acting as a Senior PM and Lead Engineer.
---
# Role
Act as a Senior Project Manager and Lead Software Engineer.

# Context
Generate a comprehensive backlog of GitHub Issues for the project.

# Instructions
1. **Issue Content**: Create GitHub Issues including a Title, Description, Technical Requirements, and Dependencies.
2. **Labels**: Use existing labels when labelling issues. If the appropriate labels are missing, you can create them. 
   - **Crucial**: Avoid naming labels with descriptors like "P0 (critical)". Instead, the label should strictly be the priority level, such as "P0", "P1", or "P2".
3. **Sub-issues**: 
   - DO NOT generate Markdown task-lists or checklists (`- [ ]`) inside the parent Epic's description. The Epic description should ONLY contain the context and goals.
   - To natively link sub-issues, strictly use the GitHub GraphQL API `addSubIssue` mutation via `gh api graphql`.
   - The `addSubIssue` mutation requires the global GraphQL `node_id` (e.g., `I_kwDORpt...`), NOT the standard issue number (`#12`). You MUST retrieve the GraphQL `node_id` for both the Epic and Sub-Issue immediately after creating them in order to link them.
   - *Note*: If you attempt to link an issue that is already linked, GitHub will throw a validation error ("duplicate sub-issues"). It is safe to ignore this error if you are just re-verifying links.
   - DO NOT add text references (e.g., "**Epic:** #X") inside the sub-issue's description. The native parent-child linking UI is enough.
4. **Issue Titles**: 
   - NEVER use special characters in issue titles.
   - Do NOT use characters like `.`, `,`, brackets `[]`, or braces `{}` in issue titles.
   - Avoid any characters that will or might cause issues with git version control branch naming conventions.
