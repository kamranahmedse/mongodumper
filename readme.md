# mongodumper
> Docker image to back up MongoDB database and upload to S3

## Usage

To run the image locally, first build it

```bash
docker build -t mongodumper .
```

Then run it with the following environment variables:

```bash
docker run -e MONGO_URI="mongo://localhost:27017/some-db" \
    -e S3BUCKET_PATH="bucket_name/path" \
    -e AWS_ACCESS_KEY_ID="XXX" \
    -e AWS_SECRET_ACCESS_KEY="XXX" \
    -e AWS_DEFAULT_REGION="ap-south-1"  \
    mongodumper
```

## Publishing

To publish the image to ECR, use the following commands

```bash
ECR_REPO="repo-name" ECR_REGION="region" ./ecr-publish.sh
```

You can optionally pass the tag as the first argument to the script, otherwise it will use the latest tag

```bash
ECR_REPO="repo-name" ECR_REGION="region" ./ecr-publish.sh 1.0.0
```

`.ecr-publish.sh` uses the `aws` cli to publish the image to ECR. Make sure you have the `aws` cli installed and
configured with the correct credentials. You can also use the `AWS_PROFILE` environment variable to specify the profile
to use.

## License

MIT © [Kamran Ahmed](https://twitter.com/kamrify)