---
name: Guided Input
description: This skill should be used when Claude needs to ask the user a question, gather user preferences, clarify requirements, make decisions, or get confirmations. It provides guidance on using the AskUserQuestion tool with well-crafted prefilled options to reduce cognitive load and help users who may feel overwhelmed or unsure how to articulate their thoughts.
version: 1.0.0
---

# Guided Input Skill

## Purpose

Transform open-ended questions into structured, guided interactions using the AskUserQuestion tool. Provide users with thoughtfully crafted prefilled options that anticipate their needs while always preserving the ability to provide custom responses.

## When to Use This Skill

Apply this guidance whenever:
- Clarifying requirements or understanding the user's goals
- Offering choices between different approaches or implementations
- Seeking confirmation before proceeding with actions
- Gathering preferences or configuration details
- Making decisions that affect the outcome of a task

## Core Principles

### 1. Always Use AskUserQuestion for Questions

Convert any question that requires user input into an AskUserQuestion tool call. Avoid asking questions in plain text that expect the user to type their answer from scratch.

**Instead of:**
```
What authentication method would you prefer?
```

**Use:**
```
AskUserQuestion with options:
- "JWT tokens" - Stateless, scalable, good for APIs
- "Session-based" - Server-side state, simpler setup
- "OAuth 2.0" - Third-party auth, social logins
```

### 2. Provide 3-4 Thoughtful Options

Each question should include 3-4 prefilled options that:
- Cover the most common or likely answers
- Are distinct and non-overlapping
- Include brief descriptions explaining implications
- Anticipate what the user might want but struggle to articulate

### 3. Craft Helpful Descriptions

Each option's description should:
- Explain what the option means in practical terms
- Highlight trade-offs or implications
- Help users understand why they might choose it
- Use plain language, avoiding jargon when possible

### 4. Use Appropriate Headers

The `header` field should be:
- Very short (max 12 characters)
- A noun or noun phrase describing the choice category
- Examples: "Auth method", "Framework", "Approach", "Priority"

### 5. Consider Multi-Select When Appropriate

Set `multiSelect: true` when:
- Options are not mutually exclusive
- The user might want to combine several options
- The question is about features or capabilities to include

## Question Types and Patterns

### Clarification Questions

When understanding requirements is needed:

```javascript
{
  question: "What is the primary goal of this feature?",
  header: "Goal",
  options: [
    { label: "Performance", description: "Optimize for speed and efficiency" },
    { label: "Maintainability", description: "Easy to understand and modify" },
    { label: "User experience", description: "Smooth, intuitive interactions" },
    { label: "Security", description: "Protect data and prevent vulnerabilities" }
  ],
  multiSelect: false
}
```

### Decision Questions

When choosing between approaches:

```javascript
{
  question: "Which testing strategy should we use?",
  header: "Testing",
  options: [
    { label: "Unit tests only", description: "Fast, isolated, test individual functions" },
    { label: "Integration tests", description: "Test how components work together" },
    { label: "End-to-end tests", description: "Test full user workflows" },
    { label: "Comprehensive", description: "All of the above for maximum coverage" }
  ],
  multiSelect: false
}
```

### Confirmation Questions

When seeking approval to proceed:

```javascript
{
  question: "Ready to apply these changes?",
  header: "Confirm",
  options: [
    { label: "Yes, proceed", description: "Apply all changes as described" },
    { label: "Show diff first", description: "Review the exact changes before applying" },
    { label: "Make adjustments", description: "Modify the plan before proceeding" }
  ],
  multiSelect: false
}
```

### Preference Questions

When gathering configuration or style preferences:

```javascript
{
  question: "What coding style conventions should we follow?",
  header: "Style",
  options: [
    { label: "Project existing", description: "Match the current codebase conventions" },
    { label: "Standard linter", description: "Use ESLint/Prettier defaults" },
    { label: "Minimal", description: "Focus on functionality, less formatting" }
  ],
  multiSelect: false
}
```

## Crafting Good Options

### Be Specific, Not Generic

**Poor options:**
- "Option 1"
- "Standard approach"
- "Other"

**Good options:**
- "React with TypeScript"
- "Server-side rendering"
- "Static site generation"

### Anticipate User Needs

Consider what users commonly want but may not know how to ask for:
- If asking about error handling, include "Fail gracefully with user-friendly messages"
- If asking about data storage, include "Local-first with cloud sync"
- If asking about performance, include "Lazy loading for faster initial load"

### Include Practical Context

Each description should help the user understand the real-world impact:

```javascript
{
  label: "PostgreSQL",
  description: "Robust, supports complex queries, good for relational data"
}
// Better than just "PostgreSQL - A relational database"
```

## Multiple Questions

When multiple questions are needed, group related questions together (up to 4 per AskUserQuestion call). This prevents overwhelming users while gathering necessary information efficiently.

```javascript
{
  questions: [
    {
      question: "What type of application is this?",
      header: "App type",
      options: [...],
      multiSelect: false
    },
    {
      question: "What's the target audience?",
      header: "Audience",
      options: [...],
      multiSelect: false
    }
  ]
}
```

## Handling Custom Responses

Remember that users can always select "Other" and provide custom text input. Design options to cover the most likely cases, but don't try to anticipate every possibility. The "Other" option is always available automatically.

## Summary

1. **Always** use AskUserQuestion when asking questions
2. Provide **3-4 options** with helpful descriptions
3. Use **short headers** (max 12 chars)
4. Write **practical descriptions** explaining implications
5. Consider **multiSelect** for non-exclusive options
6. **Group related questions** (max 4 per call)
7. Trust the automatic "Other" option for edge cases
