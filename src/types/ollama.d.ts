declare module "ollama" {
  export interface EmbeddingsRequest {
    model: string;
    prompt: string;
    options?: Record<string, any>;
  }

  export interface EmbeddingsResponse {
    embedding: number[];
  }

  export class Ollama {
    constructor(options?: { host?: string });
    embeddings(request: EmbeddingsRequest): Promise<EmbeddingsResponse>;
  }

  const ollama: Ollama;
  export default ollama;
}
