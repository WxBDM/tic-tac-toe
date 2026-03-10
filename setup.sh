#!/bin/bash

# Project name (defaults to directory name)
default_name=$(basename "$PWD")
read -p "Project name [$default_name]: " project_name
project_name=${project_name:-$default_name}

sed -i.bak "s/name = \"python-project-setup-sample\"/name = \"$project_name\"/" pyproject.toml && rm -f pyproject.toml.bak

# Create .env
[ ! -f ".env" ] && touch .env

# Install dependencies
uv sync

# Python version
read -p "Python version (3.8-3.14) [3.14]: " py_version
py_version=${py_version:-3.14}

# Dockerfile setup
read -p "Include Dockerfile? (y/N): " include_dockerfile
if [[ "$include_dockerfile" =~ ^[Yy]$ ]]; then
    sed -i.bak "s/python:VERSION-slim/python:${py_version}-slim/" Dockerfile && rm -f Dockerfile.bak
    cat > .dockerignore << 'EOF'
.git
.gitignore
.env
.venv
__pycache__
*.pyc
.pytest_cache
.mypy_cache
.ruff_cache
docs
*.md
EOF
else
    rm -f Dockerfile
fi

# Pre-commit hooks
read -p "Install pre-commit hooks? (y/N): " setup_precommit
if [[ "$setup_precommit" =~ ^[Yy]$ ]]; then
    uv run pre-commit install
else
    rm -f .pre-commit-config.yaml
fi

# Clean up template files
rm -rf images
rm -- "$0"

# Create stub README
cat > README.md << EOF
# $project_name

## Getting Started

\`\`\`bash
uv run main.py
\`\`\`

---

This repository was created using [python-project-template-for-claude](https://github.com/WxBDM/python-project-template-for-claude), as part of the [Python Snacks Newsletter](https://www.pythonsnacks.com)
EOF

# Commit and push
git add .
git commit -m "Initial commit"
git push

echo ""
echo "Setup complete!"
echo ""
echo "Summary:"
echo "  Project name: $project_name"
echo "  Python version: $py_version"
[[ "$include_dockerfile" =~ ^[Yy]$ ]] && echo "  Dockerfile: included" || echo "  Dockerfile: removed"
[[ "$setup_precommit" =~ ^[Yy]$ ]] && echo "  Pre-commit hooks: installed" || echo "  Pre-commit hooks: skipped"
echo ""
echo "Commands:"
echo "  uv run main.py          Run your application"
echo "  uv add <package>        Add a dependency"
echo "  uv run pytest           Run tests"
[[ "$setup_precommit" =~ ^[Yy]$ ]] && echo "" && echo "Pre-commit hooks will run automatically on each commit."
echo ""
