#!/usr/bin/env bash

set -e
set -o pipefail

# Use $1 as tag or default to latest
TAG=${1:-latest}

# if ECR_REPO or ECR_REGION are not set, exit
if [[ -z "${ECR_REPO}" || -z "${ECR_REGION}" ]]; then
  echo "ECR_REPO and ECR_REGION must be set"
  exit 1
fi

ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)

# Build and tag the image
docker build -t "${ECR_REPO}:${TAG}" --platform linux/amd64 .
docker tag "${ECR_REPO}:${TAG}" "${ACCOUNT_ID}.dkr.ecr.${ECR_REGION}.amazonaws.com/${ECR_REPO}:${TAG}"

# Login to ECR
aws ecr get-login-password --region "${ECR_REGION}" | docker login --username AWS --password-stdin "${ACCOUNT_ID}.dkr.ecr.${ECR_REGION}.amazonaws.com"

# Create the repository if it doesn't exist
aws ecr create-repository --repository-name "${ECR_REPO}" || true

docker push "${ACCOUNT_ID}.dkr.ecr.${ECR_REGION}.amazonaws.com/${ECR_REPO}:${TAG}"

echo "Image pushed to ECR:"
echo "${ACCOUNT_ID}.dkr.ecr.${ECR_REGION}.amazonaws.com/${ECR_REPO}:${TAG}"
