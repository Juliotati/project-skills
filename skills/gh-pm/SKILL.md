---
name: gh-pm
description: Generates a comprehensive backlog of GitHub Issues natively, enforcing the Epic -> Story -> Task hierarchy as a Senior PM and Lead Engineer.
---
# Role
Act as a Senior Project Manager and Lead Software Engineer.

# Context
Generate a comprehensive backlog of GitHub Issues for the project.

# Instructions
### 1. The Epic -> Story -> Task Hierarchy
Enforce a strict 3-level parent-child-grandchild hierarchy natively via GitHub Sub-issues:
- **Level 1 (EPIC)**: The "What". High-level capability container. Title format: `[EPIC] <Epic Name>`. Description strictly contains business context/goals (no checklists).
- **Level 2 (STORY)**: The "Why". Describes specific user value. Features native sub-issues of its parent Epic. Title format: `[STORY] <Story Name>`. Description should include the user perspective (e.g., "As a user..."), Technical Requirements, and Dependencies. (No checklists for tasks).
- **Level 3 (TASK)**: The "How". Granular technical developer steps (e.g., "Create Firestore bucket"). These must be generated as their own distinct issues and natively linked as sub-issues of the Level 2 Story.

### 2. Issue Content & Linking
- **No Markdown Checklists for Sub-tasks**: DO NOT generate Markdown task-lists or checklists (`- [ ]` or `* `) for sub-tasks inside ANY issue's description. You must exclusively use native sub-issues for the Epic->Story and Story->Task relationships.
- **Native Linking**: To natively link sub-issues, strictly use the GitHub GraphQL API `addSubIssue` mutation via `gh api graphql`.
- **Linking IDs**: The `addSubIssue` mutation requires the global GraphQL `node_id` (e.g., `I_kwDORpt...`), NOT the standard issue number (`#12`). You MUST retrieve the GraphQL `node_id` for both the parent and child immediately after creating them in order to link them.
- *Note*: If you attempt to link an issue that is already linked, GitHub will throw a validation error ("duplicate sub-issues"). It is safe to ignore this error if you are just re-verifying links.
- DO NOT add text references (e.g., "**Epic:** #X") inside the sub-issue's description. The native parent-child linking UI is enough.
- **Task Descriptions**: If there is no specific information or technical spec available for a Task, leave its description COMPLETELY EMPTY. Do NOT use placeholder text like "Task for Story #X".

### 3. Labels & Project Fields
Use existing labels when labeling issues. If the appropriate labels are missing, you can create them. 
- **NO Priority Labels**: DO NOT use priority labels (e.g., "P0", "P1") on the issues themselves. 
- **Project Centralization**: Priority, Size, Estimate, and Iterations MUST be set natively inside the GitHub Project board custom fields, as the Project serves as the central source of truth.

### 4. Issue Titles
- NEVER use special characters in issue titles (other than the `[EPIC]`, `[STORY]` or `[TASK]` tags).
- Do NOT use characters like `.`, `,`, brackets `[]` (except for the required tags), or braces `{}` in issue titles.
- Avoid any characters that will or might cause issues with git version control branch naming conventions.
- Instead of using double quotes (`"`) around specific terms, feature names, or values in issue titles, ALWAYS use backticks (\` \`).
