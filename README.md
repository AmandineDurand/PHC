# Personal Health Coach (PHC)

## Introduction

Everyone talks about GenAI those days, so I created the project to gain some GenAI skills. The idea is to create a simple application which uses LLM to analyze Apple health data then make recommendations.

### Data

Apple Health app collects health and fitness data from your iPhone, iPad, the built-in sensors on your Apple Watch, compatible third-party devices and apps that use HealthKit. The repository includes sample [workout data](./data/workouts_data.csv) and [record data](./data/records_data.csv) that you can play with.

If you are interested to use your own data, here is the instruction: the data is stored in the devices (iphone, ipad), so you need to export the data first (Open Health app, tap on the top right user icon, select Export Health Data), then download the exported data to your computer. Once you have the data, copy `export.xml` to `data` folder, then use the notebook [process_data.ipynb](./data/process_data.ipynb) to sanitize it and export to csv files. If you are interested to do some discovery against the data, use [analyze_data.ipynb](./data/analyze_data.ipynb) to explore it.

### Backend Framework

LangChain is an open source framework for developing applications powered by language models. It provides:

- Components - abstractions for working with language models, along with a collection of implementations for each abstraction.

- Off-the-shelf chains - a structured assembly of components for accomplishing specific higher-level tasks.

### Frontend Framework

Streamlit is an open source framework that can turn data scripts into shareable web apps in minutes. It is all in pure Python, so no front‑end experience required.

## Installation

It is recommended to use `python 3.10+` with virtual environment.

```
cd PHC
python -m venv .venv
source .venv/bin/activate
pip install -r src/requirements.txt
```

## Usage

Make a copy of `.sample_env` file, and name it `.env`, then add your OpenAI API key in `OPENAI_API_KEY`. If you don't have one, you need to register with [OpenAI](https://platform.openai.com/).

Run the command `.venv/bin/streamlit run src/Home.py` to start the application, then you should be able to see something like below:

```
(.venv) ➜  PHC git:(main) .venv/bin/streamlit run src/Home.py

  You can now view your Streamlit app in your browser.

  Local URL: http://localhost:8501
```

## Docker

### Build the image

From the `PHC` folder, build the Docker image with:

```bash
docker build -t phc:v1 .
```

### Run the container

Start the container with:

```bash
docker run -p 8501:8501 --env-file .env phc:v1
```

The application will be available at:

```bash
http://localhost:8501
```

### Environment variables

The project uses the variables defined in `.sample_env`.

Required variable:

- `OPENAI_API_KEY`

Optional variable:

- `SERPAPI_API_KEY`

### Exposed ports

- Container port: `8501`
- Local port: `8501`

### Useful commands

List running containers:

```bash
docker ps
```

View container logs:

```bash
docker logs <container_id>
```

Stop a container:

```bash
docker stop <container_id>
```

Remove a stopped container:

```bash
docker rm <container_id>
```

Remove an image:

```bash
docker rmi phc:1.0
```

## CI/CD with GitHub Actions

This project uses GitHub Actions to automatically build and publish the Docker image.

### Workflow

The CI pipeline is triggered on:

- push to `main`
- pull requests targeting `main`

The workflow file is located at:

```text
.github/workflows/docker-build.yml
```

### Pipeline steps

The workflow performs the following actions:

1. Checkout the repository
2. Configure Docker Buildx
3. Authenticate to Docker Hub
4. Build the Docker image and push it to Docker Hub (except for pull requests)
5. Use GitHub Actions cache to speed up builds

### Docker Hub image

The Docker image is automatically published to Docker Hub:

```bash
docker pull amandinedurand/phc-v1:latest
```

A SHA-based tag is also generated for each commit:

```bash
docker pull amandinedurand/phc-v1:<commit-sha>
```

### GitHub Secrets

The workflow requires the following GitHub repository secrets:

| Secret | Description |
|---|---|
| `DOCKER_HUB_USERNAME` | Docker Hub username |
| `DOCKER_HUB` | Docker Hub access token |

Secrets are configured in:

```text
GitHub Repository → Settings → Secrets and variables → Actions
```

### Run the Docker image locally

```bash
docker pull amandinedurand/phc-v1:latest

docker run -p 8501:8501 --env-file .env amandinedurand/phc-v1:latest
```

The application will then be available at:

```text
http://localhost:8501
```

## Demo

![demo](./data/demo.gif)
