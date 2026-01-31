# gut

**Fluxo de desenvolvimento nativo de IA para o terminal.**

> "Confie no seu gut. Envie com confiança."


gut é uma ferramenta CLI idealizada por [Marcel Scog](https://github.com/marcelxv) para ajudar desenvolvedores a construir software com desenvolvimento assistido por IA, mantendo uma estrutura e um fluxo de trabalho claros. É uma metáfora culinária para a era da IA: você escreve receitas (especificações), prepara os ingredientes (contexto), cozinha (implementa), prova (testa) e serve (envia).


```
Planejado:  gut recipe → gut prep → gut cook → gut taste → gut serve
Reativo:    gut season (ajuste rápido) | gut flame (emergência)
```

**O insight principal:** a IA deve se comportar de forma diferente de acordo com o contexto. Trabalho planejado exige profundidade. Ajustes rápidos exigem velocidade. O gut orquestra isso automaticamente.

## Por que gut?

O fluxo antigo: `code → commit → PR`

Ele foi desenhado para humanos falando com humanos. Mas agora a IA está no loop, e estamos perdendo:

- **Intenção** — o que você realmente queria
- **Contexto** — o que a IA precisa saber
- **Decisões** — por que esse caminho
- **Linagem** — como chegamos aqui

gut captura tudo isso. Cada funcionalidade começa como uma receita. A IA recebe o contexto completo. O trabalho tem um rastro claro da ideia até o PR enviado.

## Início rápido

```bash
# Instalar
git clone https://github.com/anthropics/gut-cli
cd gut-cli && ./install.sh

# Configurar um projeto
cd seu-projeto
gut init

# Adicionar contexto do projeto (a IA lê isto)
gut pantry edit

# Começar a cozinhar
gut recipe "adicionar autenticação de usuário"
gut prep adicionar-autenticacao-de-usuario
gut cook adicionar-autenticacao-de-usuario
# ... faça o trabalho com sua IA assistente ...
gut season "corrigir import do bcrypt"   # ajuste rápido no meio do cook
gut taste adicionar-autenticacao-de-usuario
gut serve adicionar-autenticacao-de-usuario

# Quando algo quebra
gut flame "login com erro 500"           # modo de emergência
gut doctor                               # checar ambiente
```

## O fluxo

### 1. `gut recipe` — Defina o que você está fazendo

```bash
gut recipe "adicionar toggle de modo escuro"      # template em branco
gut recipe -a "adicionar toggle de modo escuro"   # modo assistido (prompts guiados)
```

**Modo assistido** guia cada campo de forma interativa:

```
$ gut recipe -a "adicionar auth de usuário"

🥗 Assistente de Receita: adicionar auth de usuário

O que estamos construindo?
> Autenticação JWT com endpoints de login/logout

Por que isso importa?
> Usuários precisam acessar recursos protegidos

Critérios de sucesso?
> Usuários conseguem registrar com email/senha
> Usuários conseguem fazer login e receber token JWT
> Rotas protegidas rejeitam requisições não autenticadas
>

✅ Receita criada: adicionar-auth-de-usuario
```

Cria uma especificação estruturada em `.gut/recipes/adicionar-toggle-de-modo-escuro.md`:

```markdown
# adicionar toggle de modo escuro

## O quê
[O que estamos construindo?]

## Por quê
[Por que isso importa?]

## Critérios de sucesso
- [ ] [Como sabemos que terminou?]

## Restrições
[Restrições técnicas]

## Fora de escopo
[O que NÃO estamos fazendo]
```

### 2. `gut prep` — Planeje a abordagem

```bash
gut prep adicionar-toggle-de-modo-escuro      # template para a IA preencher
gut prep -a adicionar-toggle-de-modo-escuro   # modo assistido (prompts guiados)
```

**Modo padrão**: empacota sua receita com o contexto do projeto no pantry. Compartilhe isso com sua IA assistente para gerar um plano de implementação.

**Modo assistido** guia o plano de implementação:

```
$ gut prep -a adicionar-toggle-de-modo-escuro

Abordagem de alto nível?
> Usar variáveis CSS com o modificador dark: do Tailwind

Arquivos para criar/modificar?
> src/styles/globals.css
> src/components/ThemeToggle.tsx
> src/hooks/useTheme.ts
>

Passos de implementação?
> Criar hook useTheme com persistência em localStorage
> Adicionar componente ThemeToggle com ícones sol/lua
> Atualizar globals.css com variáveis CSS
>

✅ Arquivo de prep criado com seu plano!
```

### 3. `gut cook` — Faça o trabalho

```bash
gut cook adicionar-toggle-de-modo-escuro              # cria um novo branch
gut cook adicionar-toggle-de-modo-escuro --branch feature/ui  # usa branch existente
gut cook outra-feature                               # anexa ao branch gut atual
```

Cria ou anexa a um branch e marca a receita como em cook. Várias receitas podem ser anexadas a um branch para um PR combinado.

### 4. `gut taste` — Verifique se funciona

```bash
gut taste adicionar-toggle-de-modo-escuro
```

Mostra o checklist de critérios de sucesso. Executa testes se encontrar (npm, pytest, make).

### 5. `gut serve` — Envie

```bash
gut serve adicionar-toggle-de-modo-escuro
```

Faz commit das mudanças, dá push e cria um PR usando o GitHub CLI. Serve todas as receitas ligadas ao branch atual.

## Gerenciamento de branches

**Branch = Unidade de trabalho.** Várias receitas podem ser anexadas a um branch para um PR combinado.

```bash
# Ver branch atual e receitas ligadas
gut branch

# Listar todos os branches do gut
gut branch list

# Criar um novo branch
gut branch create feature-name

# Vincular receita ao branch atual
gut attach adicionar-auth

# Desvincular receita do branch
gut detach adicionar-auth

# Prever o que será enviado junto
gut combine
```

### Fluxo com múltiplas receitas

```bash
git checkout -b feature/user-system          # ou: gut branch create user-system
gut cook adicionar-auth                       # anexa ao branch atual
gut cook adicionar-2fa                        # também anexa aqui
gut cook adicionar-recuperacao-senha          # e esta também
gut combine                                   # preview: 3 receitas
gut serve                                     # um PR com as 3!
```

## Modo reativo

Desenvolvimento real não é só feature planejada. Coisas quebram. Portas mudam. Configs ficam inconsistentes. O gut lida com isso com comandos reativos que mudam como a IA se comporta.

### `gut season` — Ajustes rápidos

```bash
gut season "mudar porta da API para 3001"
gut season "corrigir caminho de import para utils"
```

Registra o ajuste e define o **modo REATIVO** para a IA:
- Mudanças mínimas
- Não refatorar código ao redor
- Não adicionar features
- Entrar, corrigir e sair

### `gut flame` — Correções emergenciais

```bash
gut flame "API retornando erro 500"
```

Define o **modo EMERGÊNCIA**:
- Diagnosticar primeiro
- Menor correção possível
- Velocidade acima de perfeição
- Pular extras
- Registrar para post-mortem

### `gut doctor` — Checagem de saúde do ambiente

```bash
gut doctor
```

```
🩺 Checagem de saúde da cozinha

Git:
  ✅ Repositório inicializado
  ✅ No branch: gut/add-auth

Portas comuns:
  ○ :3000 disponível
  ● :5432 em uso (postgres)

Ambiente:
  ✅ DATABASE_URL = postgres://...
  ○ REDIS_URL não definido
```

## Modos de IA

gut fornece automaticamente instruções diferentes para a IA com base no contexto:

| Modo | Gatilho | Comportamento da IA |
|------|---------|---------------------|
| **Planejado** | `gut cook` | Contexto completo, seguir o plano, aprofundado, escrever testes |
| **Reativo** | `gut season` | Contexto mínimo, correção cirúrgica, sem refatoração |
| **Emergência** | `gut flame` | Corrigir AGORA, pular extras, velocidade sobre perfeição |

As instruções de modo ficam em `.gut/modes/` e são incluídas quando você executa `gut context`.

## Gestão da cozinha

```bash
gut init          # Configurar .gut/ no seu projeto
gut menu          # Listar receitas por status
gut status        # O que está cozinhando?
gut resume        # Retomar de onde parou (handoff para IA)
gut resume copy   # Copiar resume para a área de transferência para IA
gut pantry        # Gerenciar contexto do projeto
gut pantry edit   # Editar context.md
gut pantry add    # Adicionar um novo arquivo de contexto
gut context       # Juntar todo o contexto para a área de transferência (para IA)
gut ingredients   # Que contexto uma receita precisa?
gut doctor        # Checar saúde do ambiente
gut spoiled       # Encontrar receitas abandonadas (>7 dias)
```

## Retomando o trabalho

Quando você volta para um projeto ou troca de branch, `gut resume` ajuda você (e a IA) a se atualizar:

```bash
$ gut resume

🔄 Resume: retomar de onde parou

Branch: gut/add-user-auth

Receitas neste branch:
  🍳 add-user-auth: Adicionar autenticação de usuário (cozinhando)
  📝 add-2fa: Adicionar autenticação em duas etapas (preparada)

Arquivos alterados (vs main):
  A src/middleware/auth.ts
  A src/routes/auth.ts
  M src/app.ts

Commits recentes:
  a1b2c3d feat: add JWT token generation
  d4e5f6g feat: create User model
  h7i8j9k feat: add login endpoint

Ajustes rápidos (seasonings):
  🧂 add-user-auth:
    [2024-01-31 14:20] fix bcrypt import
    [2024-01-31 15:30] change token expiry to 24h
```

Copiar para handoff da IA:

```bash
gut resume copy    # copia o documento completo de resume para a área de transferência
gut resume file    # salva em .gut/resume-YYYYMMDD.md
```

O documento de resume inclui:
- Receitas ativas e seus status
- Arquivos modificados neste branch
- Histórico recente de commits
- Ajustes rápidos aplicados
- Instruções de IA para continuar o trabalho

## O pantry

O pantry (`.gut/pantry/`) guarda o contexto do projeto que assistentes de IA precisam:

```
.gut/pantry/
├── context.md      # Visão geral do projeto, stack, arquitetura
└── conventions.md  # Estilo de código, padrões, anti-padrões
```

Adicione mais arquivos conforme necessário: `api.md`, `database.md`, `auth.md`. Quando você executa `gut prep`, todo o contexto do pantry é empacotado com sua receita.

## Estrutura de diretórios

```
.gut/
├── pantry/     # Contexto do projeto (a IA lê isto)
│   ├── context.md
│   ├── conventions.md
│   └── health.yml      # Para o gut doctor
├── recipes/    # Suas especificações
├── prep/       # Planos de implementação
├── seasoning/  # Logs de ajustes rápidos
├── flame/      # Logs de emergências
├── modes/      # Instruções de comportamento da IA
│   ├── planned.md
│   ├── reactive.md
│   └── emergency.md
└── plated/     # Receitas concluídas (histórico)
```

## Status das receitas

| Status | Ícone | Significado |
|--------|-------|-------------|
| draft | ○ | Receita escrita, não preparada |
| prepped | ◐ | Plano pronto, não iniciado |
| cooking | ◑ | Implementação em andamento |
| tasting | ◕ | Testes/verificação |
| served | ● | Enviado! |
| spoiled | ✗ | Abandonada (>7 dias inativa) |

## Instalação

### A partir do código-fonte

```bash
git clone https://github.com/anthropics/gut-cli
cd gut-cli
./install.sh
```

### Homebrew

```bash
brew tap anthropics/gut
brew install gut
```

### Manual

Copie `gut` para algum local no seu PATH:

```bash
cp gut /usr/local/bin/gut
chmod +x /usr/local/bin/gut
```

## Integração com agentes (saída JSON)

gut fornece saída JSON estruturada para agentes de IA processarem:

```bash
# Obter estado estruturado para qualquer agente de IA
gut resume --json
```

```json
{
  "branch": "gut/add-auth",
  "recipes": [
    {
      "slug": "add-user-authentication",
      "status": "cooking",
      "title": "Add user authentication",
      "progress": "2/7",
      "open_questions": ["Which auth method?"],
      "steps": [
        {"done": true, "text": "Create User model"},
        {"done": false, "text": "Add login endpoint"}
      ]
    }
  ],
  "files_changed": ["src/auth.ts"],
  "commits": [{"hash": "a1b2c3d", "message": "feat: add User model"}]
}
```

### Comandos do agente

```bash
gut questions --json    # listar perguntas abertas
gut step --json         # listar todos os passos com status
gut answer <recipe> 0 "email/password"  # responder pergunta por índice
gut step done <recipe> 2                # marcar passo como concluído
```

Isso permite que qualquer agente de IA (Claude Code, Cursor, Copilot, etc.):
1. Parseie o estado estruturado
2. Apresente formulários interativos
3. Salve decisões do usuário de volta nas receitas

## Suporte a idiomas

gut suporta inglês e português:

```bash
# Definir idioma
export GUT_LANG=pt   # Português
export GUT_LANG=en   # Inglês (padrão)

# Ou por comando
GUT_LANG=pt gut help
```

## Requisitos

- Bash 4+
- Git (para gerenciamento de branches)
- GitHub CLI `gh` (opcional, para criação de PR no `gut serve`)

## Funciona com qualquer IA

gut é agnóstico de IA. O arquivo de prep é apenas markdown que qualquer IA consegue ler:

- **Claude Code** — `gut prep feature` e peça para o Claude implementar
- **ChatGPT** — Copie o arquivo de prep para o chat
- **Cursor** — Abra o arquivo de prep e use a IA para implementar
- **GitHub Copilot** — Referencie o arquivo de prep em comentários
- **Qualquer LLM API** — Inclua o conteúdo do prep no seu prompt

## Filosofia

1. **Especificação primeiro** — Saiba o que está construindo antes de construir
2. **Contexto é rei** — A IA só é tão boa quanto o contexto que você fornece
3. **Linagem clara** — Cada linha de código rastreia a intenção
4. **Ferramentas simples** — Bash puro, sem dependências, funciona em qualquer lugar
5. **Agnóstico de IA** — Funciona com qualquer assistente de IA, presente ou futuro

## Licença

MIT

## Contribuindo

Issues e PRs são bem-vindos em [github.com/anthropics/gut-cli](https://github.com/anthropics/gut-cli)

---

*Feito para a era do desenvolvimento com IA. Confie no seu gut.*
