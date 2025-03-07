# RAG Documentation MCP Server on Docker

An MCP server implementation that provides tools for retrieving and processing documentation through vector search, enabling AI assistants to augment their responses with relevant documentation context.

## Table of Contents

- [Features](#features)
- [Quick Start](#quick-start)
- [Configuration](#configuration)
  - [Environment Variables](#environment-variables)
  - [Docker Compose Setup](#docker-compose-setup)
  - [MCP Server Configuration](#mcp-server-configuration)
- [Web Interface](#web-interface)
- [Acknowledgments](#acknowledgments)

## Features

### Tools

1. **search_documentation**

   - Search through the documentation using vector search
   - Returns relevant chunks of documentation with source information

2. **list_sources**

   - List all available documentation sources
   - Provides metadata about each source

3. **extract_urls**

   - Extract URLs from text and check if they're already in the documentation
   - Useful for preventing duplicate documentation

4. **remove_documentation**

   - Remove documentation from a specific source
   - Cleans up outdated or irrelevant documentation

5. **list_queue**

   - List all items in the processing queue
   - Shows status of pending documentation processing

6. **run_queue**

   - Process all items in the queue
   - Automatically adds new documentation to the vector store

7. **clear_queue**

   - Clear all items from the processing queue
   - Useful for resetting the system

8. **add_documentation**
   - Add new documentation to the processing queue
   - Supports various formats and sources

## Quick Start

The RAG Documentation tool is designed for:

- Enhancing AI responses with relevant documentation
- Building documentation-aware AI assistants
- Creating context-aware tooling for developers
- Implementing semantic documentation search
- Augmenting existing knowledge bases

## Configuration

### Environment Variables

The system uses environment variables for configuration. Create a `.env` file based on the provided `.env.example` file:

```
QDRANT_STORAGE=~/.qdrant/storage
OLLAMA_MODELS=~/.ollama
```

### Docker Compose Setup

The project includes a `docker-compose.yml` file for easy containerized deployment. To start the services:

```bash
docker-compose up -d
```

To stop the services:

```bash
docker-compose down
```

After starting the services, you need to pull the embedding model:

```bash
docker exec ollama ollama pull nomic-embed-text
```

### MCP Server Configuration

Add this to your `cline_mcp_settings.json`:

```json
{
  "mcpServers": {
    "rag-docs": {
      "command": "docker",
      "args": [
        "run",
        "--rm",
        "-i",
        "-p",
        "3030:3030",
        "-e",
        "QDRANT_URL=http://qdrant:6333",
        "-e",
        "OLLAMA_HOST=http://ollama:11434",
        "--network",
        "ragdocs_network",
        "ragdocs"
      ],
      "disabled": false,
      "alwaysAllow": []
    }
  }
}
```

## Web Interface

The system includes a web interface that can be accessed when the MCP server is running through RooCode, Cline, Claude or any mcp server client:

1. Open your browser and navigate to: `http://localhost:3030`
2. The interface provides:
   - Real-time queue monitoring
   - Documentation source management
   - Search interface for testing queries
   - System status and health checks

## Acknowledgments

This project is a fork of [qpd-v/mcp-ragdocs](https://github.com/qpd-v/mcp-ragdocs), originally developed by qpd-v. The original project provided the foundation for this implementation.

Special thanks to the original creator, qpd-v, for their innovative work on the initial version of this MCP server. This fork has been enhanced with additional features and improvements by Rahul Retnan.
