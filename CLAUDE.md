# CLAUDE.md

This file provide guidance to Claude Code when working with code in this repository.

## Project Structure

All source code lives in `src/`. Keep the root clean - only config files (pyproject.toml, .env, etc.) belong there.

## General Guidelines for Software Development

**Do**:

- Only use Pydantic models or dataclasses for external API data (requests/responses) or database schemas. Don't model internal application state.
- Ideally, follow TDD principals when building. When updating code, ensure tests are up-to-date.
- Handle errors gracefully with appropriate `try/except` blocks. When handling errors, include a useful statement.
- Make sure all file I/O operations use async/await.
- Include typing for functions, methods, and classes.

**Do not**:

- Add emojis unless the user prompts for it.
- Bloat the code with unecessary and duplicate functions.
- Make commits on behalf of the user. Leave this to the user unless otherwise told.
- Write project documentation to documents such as ARCHITECTURE.md - instead, add it to the project documentation.
- Avoid `typing.Any` - be specific unless it truly is any data type.
- Be the "yes" model - it's okay to recognize something doesn't need to be changed/added/removed.

## Project Documentation

When writing any form of documentation (in-line, docstrings, comments, and external using MkDocs):

- Write your tone as developer-facing and avoid over-explaining.
- Explain the *why*, not the *how* unless it's non-obvious.
- Maintain consistent, up to date, and relevant documentation. As the project grows, remember to prune outdated information.

### Comments

Keep all comments short, sweet, and simple. Avoid explaining what the code does, but rather the *why* behind why it was written a certain way if it's non-obvious. Follow PEP-8 styleing and formatting.

### Docstrings

Always include docstrings at the function, method, and module level. The module-level should include:

- A one-liner describing what the module does
- Key classes/functions if not obvious from the name
- Usage example if the module has a non-obvious API.

Avoid:
- Author/Date/Version
- License boilerplate
- Lengthy descriptions of every function (that's what function docstrings are for).

General rule of thumb: if you need more than 3-4 lines, the module might be doing too much.

All function/method should follow Google-style documentation. Follow PEP 257

## Package management: uv

Use uv exclusively for Python package management in this project.

### Package Management Commands

- All Python dependencies **must be installed, synchronized, and locked** using uv
- Never use pip, pip-tools, poetry, or conda directly for dependency management
- Confirm it's necessary before adding a dependency.

## Environment management

- Load the environment frequently during runtime using `python-dotenv`.
- Do not write to the .env file, unless prompted by the user.
- Do not create a .env.example file, ever. If the user needs to add a env variable, prompt the to do so.
