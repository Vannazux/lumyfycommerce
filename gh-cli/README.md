Uso da imagem Docker com GitHub CLI pré-instalado

Construir a imagem localmente:

```sh
cd gh-cli
docker build -t gh-cli:local .
```

Exemplo de uso (monta o diretório do projeto e o config do gh para persistir credenciais):

```sh
docker run --rm -it \
  -v "$HOME/.config/gh":/root/.config/gh \
  -v "/volume1/docker/lumyfy":/work -w /work \
  gh-cli:local auth login

# Criar repo e push (após autenticar):
docker run --rm -it -v "$HOME/.config/gh":/root/.config/gh -v "/volume1/docker/lumyfy":/work -w /work gh-cli:local \
  repo create lumyfycommerce --public --source=. --remote=origin --push --confirm
```

Observações:
- Monte `/root/.config/gh` para manter o login entre execuções.
- A imagem já contém `git` para operações locais.
