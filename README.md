# Anything-LLM All-in-One Helm Chart

# anything-llm

A Helm chart, that allows your easy way to deploy anything-llm. But also allows you to deploy anything-llm with different components like chromadb, nvidia-device-plugin, ollama, and more.

![Version: 1.0.4](https://img.shields.io/badge/Version-1.0.4-informational?style=flat-square)

![AppVersion: 1.1.1](https://img.shields.io/badge/AppVersion-1.1.1-informational?style=flat-square)

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| la-cc | <artem@lajko.dev> | <https://github.com/la-cc> |
| deB4SH |  | <https://github.com/deB4SH> |

## Introduction - Anything-LLM Helm Chart

> Thanks to the work of Mintplex-Labs for creating anything-llm! If you like it, feel free to leave a ⭐️ on the [anything-llm](https://github.com/Mintplex-Labs/anything-llm) or contribute to the project or booth!

This chart allows you to deploy Anything-LLM on a Kubernetes cluster using the Helm package manager.
Anything-LLM is a versatile API that can be used to interact with various language models, embedding models, and vector databases.

To get an idea, here is a visual representation of a simplified architecture:

![Anything-LLM Architecture](/images/anything-llm-m.gif)

> The full list of supported LLMs, Vector DBs and Embedder can be found under [Supported LLMs, Embedder Models, Speech models, and Vector Databases](https://github.com/Mintplex-Labs/anything-llm?tab=readme-ov-file#supported-llms-embedder-models-speech-models-and-vector-databases)

The easiest way to start with anything-llm is to use the default components with OpenAI API like:

![Anything-LLM Architecture](/images/anything-llm-s.gif)

This is how the ui looks like after deploying the easiest way:

![Anything-LLM Architecture](/images/anything-llm-ui.gif)

## Installing the Chart

To install the chart with the release name `anything-llm`:

```console
$ helm repo add anything-llm https://la-cc.github.io/anything-llm-helm-chart
$ helm repo update
$ helm install anything-llm anything-llm/anything-llm
```

Or if you like you can also template the manifest and apply it directly:

> **Note:** Don't template the secret, its not recommended to store the secret in the manifest. Its just for demonstration purposes and to keep the process simple. Please create a secret and reference it in the `values.yaml`.

```console
$ helm template anything-llm anything-llm/anything-llm -f values.yaml | kubectl apply -f -

```

The next section "Requirements" is only required, if you want replace anyrhing-llm components like llm, embedded, vector db with your own components. If you want to use the default components, you can skip the next section.

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://amikos-tech.github.io/chromadb-chart/ | chromadb | 0.1.19 |
| https://la-cc.github.io/nvidia-device-plugin-helm-chart | nvidia-device-plugin | 0.3.3 |
| https://otwld.github.io/ollama-helm/ | ollama | 0.45.0 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| chromadb.chromadb.auth.enabled | bool | `false` |  |
| chromadb.enabled | bool | `false` |  |
| chromadb.service.type | string | `"ClusterIP"` |  |
| config | object | `{"EMBEDDING_MODEL_MAX_CHUNK_LENGTH":"8192","EMBEDDING_MODEL_PREF":"nomic-embed-text:1.5","STORAGE_DIR":"/app/server/storage","TTS_PROVIDER":"native","VECTOR_DB":"lancedb","WHISPER_PROVIDER":"local"}` | Configuration for the application. |
| config.EMBEDDING_MODEL_PREF | string | `"nomic-embed-text:1.5"` | Configuration for the embedding model. |
| config.VECTOR_DB | string | `"lancedb"` | Configuration for the vector db like lanceDB (in storage) or chroma DB (external), etc. |
| fullnameOverride | string | `"anything-llm"` | Override the full name of the chart. |
| image | object | `{"pullPolicy":"IfNotPresent","repository":"ghcr.io/mintplex-labs/anything-llm","tag":"1.1.1"}` | Configuration for the Docker image used by the pod. |
| image.pullPolicy | string | `"IfNotPresent"` | The pull policy for the image. IfNotPresent means the image will only be pulled if it is not already present locally. |
| image.repository | string | `"ghcr.io/mintplex-labs/anything-llm"` | The Docker repository to pull the image from. |
| image.tag | string | `"1.1.1"` | The specific tag of the image to use. |
| ingress | object | `{"annotations":{"cert-manager.io/cluster-issuer":"letsencrypt-dns","cert-manager.io/renew-before":"360h","nginx.ingress.kubernetes.io/rewrite-target":"/"},"enabled":true,"hosts":[{"host":"llm.example.com","paths":[{"path":"/","pathType":"Prefix"}]}],"tls":[{"hosts":["llm.example.com"],"secretName":"anything-llm-tls"}]}` | Ingress configuration. |
| ingress.annotations | object | `{"cert-manager.io/cluster-issuer":"letsencrypt-dns","cert-manager.io/renew-before":"360h","nginx.ingress.kubernetes.io/rewrite-target":"/"}` | Ingress annotations. |
| ingress.enabled | bool | `true` | Enable ingress. |
| ingress.hosts | list | `[{"host":"llm.example.com","paths":[{"path":"/","pathType":"Prefix"}]}]` | Ingress hosts. |
| ingress.tls | list | `[{"hosts":["llm.example.com"],"secretName":"anything-llm-tls"}]` | TLS configuration for ingress. |
| nvidia-device-plugin.enabled | bool | `false` |  |
| nvidia-device-plugin.fullnameOverride | string | `"nvidia-device-plugin"` |  |
| nvidia-device-plugin.resources.limits."nvidia.com/gpu" | int | `1` |  |
| nvidia-device-plugin.tolerations[0].effect | string | `"NoSchedule"` |  |
| nvidia-device-plugin.tolerations[0].key | string | `"nvidia.com/gpu"` |  |
| nvidia-device-plugin.tolerations[0].operator | string | `"Exists"` |  |
| ollama.autoscaling.enabled | bool | `false` |  |
| ollama.autoscaling.maxReplicas | int | `1` |  |
| ollama.enabled | bool | `false` |  |
| ollama.fullnameOverride | string | `"ollama"` |  |
| ollama.image.repository | string | `"ollama/ollama"` |  |
| ollama.image.tag | string | `"0.1.48"` |  |
| ollama.ollama.gpu.enabled | bool | `true` |  |
| ollama.ollama.models[0] | string | `"gemma2"` |  |
| ollama.ollama.number | int | `1` |  |
| ollama.ollama.type | string | `"nvidia"` |  |
| ollama.persistentVolume.accessModes[0] | string | `"ReadWriteOnce"` |  |
| ollama.persistentVolume.enabled | bool | `true` |  |
| ollama.persistentVolume.size | string | `"50Gi"` |  |
| ollama.persistentVolume.storageClass | string | `""` |  |
| ollama.tolerations[0].effect | string | `"NoSchedule"` |  |
| ollama.tolerations[0].key | string | `"ai"` |  |
| ollama.tolerations[0].operator | string | `"Equal"` |  |
| ollama.tolerations[0].value | string | `"true"` |  |
| persistence | object | `{"accessMode":"ReadWriteOnce","enabled":true,"size":"10Gi","volumes":[{"mountPath":"/app/server/storage","name":"server-storage"}]}` | Persistence configuration. |
| persistence.accessMode | string | `"ReadWriteOnce"` | Access mode for the persistent volume. |
| persistence.enabled | bool | `true` | Enable persistence. |
| persistence.size | string | `"10Gi"` | Size of the persistent volume. |
| persistence.volumes | list | `[{"mountPath":"/app/server/storage","name":"server-storage"}]` | List of volumes to create. |
| replicaCount | int | `1` | Number of pod replicas to deploy. |
| secret | object | `{"data":{"AUTH_TOKEN":"replace-me","JWT_SECRET":"replace-me"},"enabled":true,"name":""}` | Secret configuration. |
| secret.data | object | `{"AUTH_TOKEN":"replace-me","JWT_SECRET":"replace-me"}` | Secret data. |
| secret.enabled | bool | `true` | Enable secrets. |
| secret.name | string | `""` | Name of the secret, if not set, a secret is generated. |
| service | object | `{"port":3001,"type":"ClusterIP"}` | Service configuration. |
| service.port | int | `3001` | Service port. |
| service.type | string | `"ClusterIP"` | Service type. |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)

### [General possible Configuration for Anything-LLM](https://github.com/Mintplex-Labs/anything-llm/blob/master/docker/.env.example)

| **Configuration** | **Example Value**               | **Description**                                             |
|-------------------|---------------------------------|-------------------------------------------------------------|
| `SERVER_PORT`     | `3001`                          | Port on which the server will run.                          |
| `STORAGE_DIR`     | `"/app/server/storage"`         | Directory for storing application data.                     |
| `UID`             | `1000`                          | User ID for running the application.                        |
| `GID`             | `1000`                          | Group ID for running the application.                       |
| `SIG_KEY`         | `'passphrase'`                  | Passphrase for signing (requires at least 32 characters).   |
| `SIG_SALT`        | `'salt'`                        | Salt for signing (requires at least 32 characters).         |
| `JWT_SECRET`      | `"my-random-string-for-seeding"`| Secret for JWT authentication (requires at least 12 characters). |

### LLM API Selection

| **Configuration**            | **Example Value**                                     | **Description**                                 |
|------------------------------|-------------------------------------------------------|-------------------------------------------------|
| `LLM_PROVIDER`               | `'openai'`                                            | Provider for the LLM API.                       |
| `OPEN_AI_KEY`                | `sk-xxxx`                                             | API key for OpenAI.                             |
| `OPEN_MODEL_PREF`            | `'gpt-4o'`                                            | Preferred OpenAI model.                         |
| `GEMINI_API_KEY`             | `sk-gemini-xxxx`                                      | API key for Gemini.                             |
| `GEMINI_LLM_MODEL_PREF`      | `'gemini-pro'`                                        | Preferred Gemini model.                         |
| `AZURE_OPENAI_ENDPOINT`      | `https://replace-me.openai.azure.com/`       | Azure OpenAI endpoint.                          |
| `AZURE_OPENAI_KEY`           | `50f..                         `                      | API key for Azure OpenAI.                       |
| `ANTHROPIC_API_KEY`          | `sk-ant-xxxx`                                         | API key for Anthropic.                          |
| `ANTHROPIC_MODEL_PREF`       | `'claude-2'`                                          | Preferred Anthropic model.                      |
| `LMSTUDIO_BASE_PATH`         | `'http://your-server:1234/v1'`                        | Base path for LMStudio API.                     |
| `LMSTUDIO_MODEL_PREF`        | `'Loaded from Chat UI'`                               | Preferred LMStudio model.                       |
| `LMSTUDIO_MODEL_TOKEN_LIMIT` | `4096`                                                | Token limit for LMStudio model.                 |
| `LOCAL_AI_BASE_PATH`         | `'http://host.docker.internal:8080/v1'`               | Base path for Local AI API.                     |
| `LOCAL_AI_MODEL_PREF`        | `'luna-ai-llama2'`                                    | Preferred Local AI model.                       |
| `LOCAL_AI_MODEL_TOKEN_LIMIT` | `4096`                                                | Token limit for Local AI model.                 |
| `LOCAL_AI_API_KEY`           | `"sk-123abc"`                                         | API key for Local AI.                           |
| `OLLAMA_BASE_PATH`           | `'http://host.docker.internal:11434'`                 | Base path for Ollama API.                       |
| `OLLAMA_MODEL_PREF`          | `'llama2'`                                            | Preferred Ollama model.                         |
| `OLLAMA_MODEL_TOKEN_LIMIT`   | `4096`                                                | Token limit for Ollama model.                   |
| `TOGETHER_AI_API_KEY`        | `'my-together-ai-key'`                                | API key for Together AI.                        |
| `TOGETHER_AI_MODEL_PREF`     | `'mistralai/Mixtral-8x7B-Instruct-v0.1'`              | Preferred Together AI model.                    |
| `MISTRAL_API_KEY`            | `'example-mistral-ai-api-key'`                        | API key for Mistral.                            |
| `MISTRAL_MODEL_PREF`         | `'mistral-tiny'`                                      | Preferred Mistral model.                        |
| `PERPLEXITY_API_KEY`         | `'my-perplexity-key'`                                 | API key for Perplexity.                         |
| `PERPLEXITY_MODEL_PREF`      | `'codellama-34b-instruct'`                            | Preferred Perplexity model.                     |
| `OPENROUTER_API_KEY`         | `'my-openrouter-key'`                                 | API key for OpenRouter.                         |
| `OPENROUTER_MODEL_PREF`      | `'openrouter/auto'`                                   | Preferred OpenRouter model.                     |
| `HUGGING_FACE_LLM_ENDPOINT`  | `https://uuid-here.us-east-1.aws.endpoints.huggingface.cloud` | Endpoint for Hugging Face LLM.           |
| `HUGGING_FACE_LLM_API_KEY`   | `hf_xxxxxx`                                           | API key for Hugging Face LLM.                   |
| `HUGGING_FACE_LLM_TOKEN_LIMIT`| `8000`                                               | Token limit for Hugging Face LLM.               |
| `GROQ_API_KEY`               | `gsk_abcxyz`                                          | API key for Groq.                               |
| `GROQ_MODEL_PREF`            | `'llama3-8b-8192'`                                    | Preferred Groq model.                           |
| `KOBOLD_CPP_BASE_PATH`       | `'http://127.0.0.1:5000/v1'`                          | Base path for KoboldCPP API.                    |
| `KOBOLD_CPP_MODEL_PREF`      | `'koboldcpp/codellama-7b-instruct.Q4_K_S'`            | Preferred KoboldCPP model.                      |
| `KOBOLD_CPP_MODEL_TOKEN_LIMIT`| `4096`                                               | Token limit for KoboldCPP model.                |
| `TEXT_GEN_WEB_UI_BASE_PATH`  | `'http://127.0.0.1:5000/v1'`                          | Base path for TextGenWebUI API.                 |
| `TEXT_GEN_WEB_UI_TOKEN_LIMIT`| `4096`                                                | Token limit for TextGenWebUI model.             |
| `TEXT_GEN_WEB_UI_API_KEY`    | `"sk-123abc"`                                         | API key for TextGenWebUI.                       |
| `GENERIC_OPEN_AI_BASE_PATH`  | `'http://proxy.url.openai.com/v1'`                    | Base path for Generic OpenAI API.               |
| `GENERIC_OPEN_AI_MODEL_PREF` | `'gpt-3.5-turbo'`                                     | Preferred Generic OpenAI model.                 |
| `GENERIC_OPEN_AI_MODEL_TOKEN_LIMIT` | `4096`                                          | Token limit for Generic OpenAI model.           |
| `GENERIC_OPEN_AI_API_KEY`    | `"sk-123abc"`                                         | API key for Generic OpenAI.                     |
| `LITE_LLM_MODEL_PREF`        | `'gpt-3.5-turbo'`                                     | Preferred LiteLLM model.                        |
| `LITE_LLM_MODEL_TOKEN_LIMIT` | `4096`                                                | Token limit for LiteLLM model.                  |
| `LITE_LLM_BASE_PATH`         | `'http://127.0.0.1:4000'`                             | Base path for LiteLLM API.                      |
| `LITE_LLM_API_KEY`           | `"sk-123abc"`                                         | API key for LiteLLM.                            |
| `COHERE_API_KEY`             | `""`                                                  | API key for Cohere.                             |
| `COHERE_MODEL_PREF`          | `'command-r'`                                         | Preferred Cohere model.                         |

### Embedding API Selection

| **Configuration**                    | **Example Value**                             | **Description**                                 |
|--------------------------------------|-----------------------------------------------|-------------------------------------------------|
| `EMBEDDING_ENGINE`                   | `'openai'`                                    | Embedding engine to use.                        |
| `EMBEDDING_MODEL_PREF`               | `'text-embedding-ada-002'`                    | Preferred embedding model.                      |
| `EMBEDDING_MODEL_MAX_CHUNK_LENGTH`   | `8192`                                        | Maximum chunk length for embedding model.       |
| `EMBEDDING_BASE_PATH`                | `'http://localhost:8080/v1'`                  | Base path for embedding API.                    |
| `GENERIC_OPEN_AI_EMBEDDING_API_KEY`  | `"sk-123abc"`                                 | API key for Generic OpenAI Embedding.           |

### Vector Database Selection

| **Configuration**    | **Example Value**                         | **Description**                                 |
|----------------------|-------------------------------------------|-------------------------------------------------|
| `VECTOR_DB`          | `'chroma'`                                 | Vector database to use.                         |
| `CHROMA_ENDPOINT`    | `'http://host.docker.internal:8000'`      | Endpoint for Chroma database.                   |
| `CHROMA_API_HEADER`  | `"X-Api-Key"`                             | API header for Chroma database.                 |
| `CHROMA_API_KEY`     | `"sk-123abc"`                             | API key for Chroma database.                    |
| `PINECONE_API_KEY`   | `""`                                      | API key for Pinecone database.                  |
| `PINECONE_INDEX`     | `""`                                      | Index for Pinecone database.                    |
| `WEAVIATE_ENDPOINT`  | `'http://localhost:8080'`                 | Endpoint for Weaviate database.                 |
| `WEAVIATE_API_KEY`   | `""`                                      | API key for Weaviate database.                  |
| `QDRANT_ENDPOINT`    | `'http://localhost:6333'`                 | Endpoint for Qdrant database.                   |
| `QDRANT_API_KEY`     | `""`                                      | API key for Qdrant database.                    |
| `MILVUS_ADDRESS`     | `'http://localhost:19530'`                | Address for Milvus database.                    |
| `MILVUS_USERNAME`    | `""`                                      | Username for Milvus database.                   |
| `MILVUS_PASSWORD`    | `""`                                      | Password for Milvus database.                   |
| `ZILLIZ_ENDPOINT`    | `'https://sample.api.gcp-us-west1.zillizcloud.com'` | Endpoint for Zilliz database.           |
| `ZILLIZ_API_TOKEN`   | `'api-token-here'`                        | API token for Zilliz database.                  |
| `ASTRA_DB_APPLICATION_TOKEN` | `""`                              | Application token for Astra DB.                 |
| `ASTRA_DB_ENDPOINT`  | `""`                                      | Endpoint for Astra DB.                          |

### Audio Model Selection

| **Configuration**            | **Example Value**             | **Description**                                             |
|------------------------------|-------------------------------|-------------------------------------------------------------|
| `WHISPER_PROVIDER`           | `'local'`                     | Provider for Whisper model.                                 |
| `OPEN_AI_KEY`                | `sk-xxxxxxx`                  | API key for OpenAI (for Whisper model).                     |

### TTS/STT Model Selection

| **Configuration**            | **Example Value**             | **Description**                                             |
|------------------------------|-------------------------------|-------------------------------------------------------------|
| `TTS_PROVIDER`               | `'native'`                    | Provider for TTS (Text-to-Speech).                          |
| `TTS_OPEN_AI_KEY`            | `sk-example`                  | API key for OpenAI (for TTS model).                         |
| `TTS_OPEN_AI_VOICE_MODEL`    | `'nova'`                      | Preferred OpenAI TTS voice model.                           |
| `TTS_ELEVEN_LABS_KEY`        | `""`                          | API key for Eleven Labs (for TTS model).                    |
| `TTS_ELEVEN_LABS_VOICE_MODEL`| `'21m00Tcm4TlvDq8ikWAM'`      | Preferred Eleven Labs TTS voice model (e.g., Rachel).       |

### Cloud Deployment Variables

| **Configuration**            | **Example Value**             | **Description**                                             |
|------------------------------|-------------------------------|-------------------------------------------------------------|
| `AUTH_TOKEN`                 | `"hunter2"`                   | Password for your application if remote hosting.            |
| `DISABLE_TELEMETRY`          | `"false"`                     | Disable telemetry if set to true.                           |

### Password Complexity

| **Configuration**            | **Example Value**             | **Description**                                             |
|------------------------------|-------------------------------|-------------------------------------------------------------|
| `PASSWORDMINCHAR`            | `8`                           | Minimum password length.                                    |
| `PASSWORDMAXCHAR`            | `250`                         | Maximum password length.                                    |
| `PASSWORDLOWERCASE`          | `1`                           | Minimum number of lowercase letters in the password.        |
| `PASSWORDUPPERCASE`          | `1`                           | Minimum number of uppercase letters in the password.        |
| `PASSWORDNUMERIC`            | `1`                           | Minimum number of numeric digits in the password.           |
| `PASSWORDSYMBOL`             | `1`                           | Minimum number of symbols in the password.                  |
| `PASSWORDREQUIREMENTS`       | `4`                           | Total number of password requirements to be met.            |

### HTTPS Server Configuration

| **Configuration**            | **Example Value**             | **Description**                                             |
|------------------------------|-------------------------------|-------------------------------------------------------------|
| `ENABLE_HTTPS`               | `"true"`                      | Enable HTTPS server.                                        |
| `HTTPS_CERT_PATH`            | `"sslcert/cert.pem"`          | Path to the SSL certificate.                                |
| `HTTPS_KEY_PATH`             | `"sslcert/key.pem"`           | Path to the SSL key.                                        |

### Agent Service Keys

| **Configuration**            | **Example Value**             | **Description**                                             |
|------------------------------|-------------------------------|-------------------------------------------------------------|
| `AGENT_GSE_KEY`              | `""`                          | API key for Google Search.                                  |
| `AGENT_GSE_CTX`              | `""`                          | Context key for Google Search.                              |
| `AGENT_SERPER_DEV_KEY`       | `""`                          | API key for Serper.dev.                                     |
| `AGENT_BING_SEARCH_API_KEY`  | `""`                          | API key for Bing Search.                                    |
| `AGENT_SERPLY_API_KEY`       | `""`                          | API key for Serply.io.                                      |
| `AGENT_SEARXNG_API_URL`      | `""`                          | API URL for SearXNG.                                        |
