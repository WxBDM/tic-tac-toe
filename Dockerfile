FROM python:VERSION-slim

WORKDIR /app

# Install uvs
COPY --from=ghcr.io/astral-sh/uv:latest /uv /usr/local/bin/uv

# Copy dependency files
COPY pyproject.toml ./

# Install dependencies
RUN uv sync --no-dev --no-install-project

# Copy application code
COPY src/ ./

# Run the application
CMD ["uv", "run", "main.py"]
