# ============================================================================
# XAF Blazor Base Image Build Script
#
# Requirements:
#   - Docker Desktop (with Buildx support enabled)
#   - Docker Hub account (for pushing images)
#
# This script builds and pushes a multi-platform Docker image (amd64 & arm64)
# using Docker Buildx. It will create a builder instance if needed.
#
# What is a builder?
#   Docker Buildx is an extended build tool that supports multi-platform builds.
#   A builder instance is an isolated environment for building images, allowing
#   you to build for different architectures and use advanced features.
#
# Usage:
#   Run this script from PowerShell: ./build.ps1
# ============================================================================
# Check if Docker Buildx is available
if (-not (docker buildx version 2>$null)) {
    Write-Error "Docker Buildx is not installed or not available in PATH."
    exit 1
}

# Check if the builder instance 'mybuilder' already exists
if (-not (docker buildx ls | Select-String -Pattern "mybuilder")) {
    # Create a new builder instance named 'mybuilder' and set it as default
    docker buildx create --use --name mybuilder
}

# Build and push the image for both amd64 and arm64 platforms
docker buildx build --platform linux/amd64,linux/arm64 -t aelmen/xafblazoraspnet9 --push .
