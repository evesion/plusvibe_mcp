#!/bin/bash

# Complete PlusVibe MCP Server Setup Script
# Run this after cloning your repository

echo "🚀 Setting up PlusVibe MCP Server..."

# Create directory structure
mkdir -p src/{lib,utils}
mkdir -p tests
mkdir -p scripts
mkdir -p monitoring/{prometheus,grafana/{provisioning,dashboards},fluentd}
mkdir -p nginx/{conf.d}
mkdir -p logs
mkdir -p temp

echo "📁 Directory structure created"

# Create package.json
cat > package.json << 'EOF'
{
  "name": "plusvibe-mcp-server",
  "version": "1.2.0",
  "description": "Enhanced MCP Server for PlusVibe.ai API integration with caching, validation, and monitoring",
  "main": "src/index.js",
  "type": "module",
  "scripts": {
    "start": "node src/index.js",
    "dev": "nodemon src/index.js",
    "test": "jest",
    "test:watch": "jest --watch",
    "test:coverage": "jest --coverage",
    "lint": "eslint src/",
    "lint:fix": "eslint src/ --fix",
    "build": "docker build -t plusvibe-mcp .",
    "docker:run": "docker run --env-file .env -p 3000:3000 plusvibe-mcp",
    "docker:compose": "docker-compose up -d",
    "docker:logs": "docker-compose logs -f plusvibe-mcp",
    "docker:stop": "docker-compose down",
    "health": "node scripts/health-check.js",
    "benchmark": "node scripts/benchmark.js",
    "migrate": "node scripts/migrate.js",
    "setup": "node scripts/setup.js"
  },
  "keywords": [
    "mcp",
    "plusvibe",
    "pipl",
    "api",
    "cold-email",
    "automation",
    "sales",
    "outreach"
  ],
  "author": "Frank Alexander <frank@example.com>",
  "license": "MIT",
  "dependencies": {
    "@modelcontextprotocol/sdk": "^0.5.0",
    "axios": "^1.7.0",
    "dotenv": "^16.4.0",
    "winston": "^3.11.0",
    "ioredis": "^5.3.0",
    "joi": "^17.12.0"
  },
  "devDependencies": {
    "nodemon": "^3.1.0",
    "jest": "^29.7.0",
    "eslint": "^8.57.0",
    "eslint-config-airbnb-base": "^15.0.0",
    "eslint-plugin-import": "^2.29.0",
    "supertest": "^6.3.0",
    "@types/jest": "^29.5.0"
  },
  "engines": {
    "node": ">=18.0.0"
  },
  "repository": {
    "type": "git",
    "url": "https://github.com/evesion/plusvibe_mcp.git"
  }
}
EOF

# Create .env.example
cat > .env.example << 'EOF'
# PlusVibe API Configuration
PLUSVIBE_API_KEY=your_api_key_here
PLUSVIBE_WORKSPACE_ID=your_workspace_id_here

# Optional: Override base URL if different
# PLUSVIBE_BASE_URL=https://api.plusvibe.ai

# Redis Configuration (optional)
REDIS_ENABLED=false
REDIS_HOST=localhost
REDIS_PORT=6379
REDIS_PASSWORD=
REDIS_DB=0

# Logging Configuration
LOG_LEVEL=info
LOG_DIR=logs

# Docker configuration
NODE_ENV=production
EOF

# Create .gitignore
cat > .gitignore << 'EOF'
# Dependencies
node_modules/
npm-debug.log*
package-lock.json
yarn.lock

# Environment
.env
.env.local
.env.production

# Logs
logs/
*.log

# Runtime
temp/
.cache/
pid

# Coverage
coverage/
.nyc_output

# IDE
.vscode/
.idea/
*.swp
*.swo

# OS
.DS_Store
Thumbs.db

# Docker
.dockerignore

# Build artifacts
dist/
build/

# Testing
test-results/
EOF

echo "📦 Created package.json, .env.example, and .gitignore"

# Commit and push
git add .
git commit -m "Initial commit: Add project structure and configuration"
git push origin main

echo "✅ Basic setup complete!"
echo ""
echo "Next steps:"
echo "1. Copy the main source files from the artifacts in Claude"
echo "2. Run: npm install"
echo "3. Run: cp .env.example .env && edit .env with your credentials"
echo "4. Run: npm start"
