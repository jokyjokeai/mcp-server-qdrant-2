FROM python:3.11-slim
WORKDIR /app

# Install uv and uvx
RUN pip install --no-cache-dir uv
RUN uv pip install --system --no-cache-dir mcp-server-qdrant

# Create a symbolic link for uvx if needed
RUN ln -sf /usr/local/bin/uv /usr/local/bin/uvx || true

# Expose the default port for SSE transport
EXPOSE 8000

# Set environment variables
ENV QDRANT_URL=":memory:"
ENV QDRANT_API_KEY=""
ENV COLLECTION_NAME="test-collection"
ENV EMBEDDING_MODEL="sentence-transformers/all-MiniLM-L6-v2"
ENV FASTMCP_PORT=8000
ENV FASTMCP_HOST=0.0.0.0
ENV PATH="/root/.local/bin:${PATH}"

# Run the server with uvx
CMD ["uv", "run", "mcp-server-qdrant", "--transport", "sse"]
