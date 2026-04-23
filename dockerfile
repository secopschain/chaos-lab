# 1. Use an official Python slim image as a base
FROM python:3.12-slim

# 2. Set environment variables for Python and Poetry
ENV POETRY_VERSION=1.8.2 \
    POETRY_NO_INTERACTION=1 \
    POETRY_VIRTUALENVS_CREATE=false \
    PYTHONUNBUFFERED=1

# 3. Set the working directory inside the container
WORKDIR /app

# 4. Install system dependencies (Keeping curl for health checks/tests)
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    && curl -sSL https://install.python-poetry.org | python3 - \
    && rm -rf /var/lib/apt/lists/*

# 5. Add Poetry to the system PATH
ENV PATH="/root/.local/bin:$PATH"

# 6. Copy dependency management files
COPY pyproject.toml poetry.lock* ./

# 7. Install project dependencies
RUN poetry install --no-root --only main

# 8. Copy the rest of the application code
COPY . .

# 9. Expose the port and define the entry point command
EXPOSE 5000
CMD ["python", "app.py"]
