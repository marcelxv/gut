# gut

**AI-native development workflow for the terminal.**

> "Trust your gut. Ship with confidence."

gut is a CLI tool created by [Marcel Scog](https://github.com/marcelxv) to help developers build software with AI-assisted development while keeping a clear structure and workflow. It's a culinary metaphor for the AI era: you write recipes (specs), prep ingredients (context), cook (implement), taste (test), and serve (ship).

```
Planned:   gut recipe → gut prep → gut cook → gut taste → gut serve
Reactive:  gut season (quick fix) | gut flame (emergency)
```

**Core insight:** AI should behave differently based on context. Planned work needs depth. Quick fixes need speed. gut orchestrates this automatically.

## Why gut?

The old flow: `code → commit → PR`

It was designed for humans talking to humans. But now AI is in the loop, and we are losing:

- **Intent** — what you really wanted
- **Context** — what the AI needs to know
- **Decisions** — why this path
- **Lineage** — how we got here

gut captures it all. Every feature starts as a recipe. The AI receives the full context. The work has a clear trail from idea to shipped PR.

## Quickstart

```bash
# Install
git clone https://github.com/anthropics/gut-cli
cd gut-cli && ./install.sh

# Set up a project
cd your-project
gut init

# Add project context (the AI reads this)
gut pantry edit

# Start cooking
gut recipe "add user authentication"
gut prep add-user-authentication
gut cook add-user-authentication
# ... do the work with your AI assistant ...
gut season "fix bcrypt import"   # quick fix during cook
gut taste add-user-authentication
gut serve add-user-authentication

# When something breaks
gut flame "login returns 500"     # emergency mode
gut doctor                        # check environment
```

## The flow

### 1. `gut recipe` — Define what you're doing

```bash
gut recipe "add dark mode toggle"      # blank template
gut recipe -a "add dark mode toggle"   # assisted mode (guided prompts)
```

**Assisted mode** guides each field interactively:

```
$ gut recipe -a "add user auth"

🥗 Recipe Assistant: add user auth

What are we building?
> JWT authentication with login/logout endpoints

Why does it matter?
> Users need access to protected resources

Success criteria?
> Users can register with email/password
> Users can log in and receive a JWT token
> Protected routes reject unauthenticated requests
>

✅ Recipe created: add-user-auth
```

Creates a structured spec in `.gut/recipes/add-dark-mode-toggle.md`:

```markdown
# add dark mode toggle

## What
[What are we building?]

## Why
[Why does it matter?]

## Success criteria
- [ ] [How do we know it's done?]

## Constraints
[Technical constraints]

## Out of scope
[What are we NOT doing]
```

### 2. `gut prep` — Plan the approach

```bash
gut prep add-dark-mode-toggle      # template for the AI to fill
gut prep -a add-dark-mode-toggle   # assisted mode (guided prompts)
```

**Standard mode**: bundles your recipe with project context from the pantry. Share it with your AI assistant to generate an implementation plan.

**Assisted mode** guides the implementation plan:

```
$ gut prep -a add-dark-mode-toggle

High-level approach?
> Use CSS variables with Tailwind's dark: modifier

Files to create/modify?
> src/styles/globals.css
> src/components/ThemeToggle.tsx
> src/hooks/useTheme.ts
>

Implementation steps?
> Create useTheme hook with localStorage persistence
> Add ThemeToggle component with sun/moon icons
> Update globals.css with CSS variables
>

✅ Prep file created with your plan!
```

### 3. `gut cook` — Do the work

```bash
gut cook add-dark-mode-toggle                     # creates a new branch
gut cook add-dark-mode-toggle --branch feature/ui # uses an existing branch
gut cook another-feature                          # attaches to current gut branch
```

Creates or attaches to a branch and marks the recipe as cooking. Multiple recipes can be attached to a branch for a combined PR.

### 4. `gut taste` — Verify it works

```bash
gut taste add-dark-mode-toggle
```

Shows the success criteria checklist. Runs tests if it finds them (npm, pytest, make).

### 5. `gut serve` — Ship it

```bash
gut serve add-dark-mode-toggle
```

Commits the changes, pushes, and creates a PR using GitHub CLI. Serves all recipes attached to the current branch.

## Branch management

**Branch = unit of work.** Multiple recipes can be attached to a branch for a combined PR.

```bash
# See current branch and attached recipes
gut branch

# List all gut branches
gut branch list

# Create a new branch
gut branch create feature-name

# Attach a recipe to the current branch
gut attach add-auth

# Detach a recipe from the branch
gut detach add-auth

# Preview what will be shipped together
gut combine
```

### Flow with multiple recipes

```bash
git checkout -b feature/user-system          # or: gut branch create user-system
gut cook add-auth                            # attaches to current branch
gut cook add-2fa                             # attaches here too
gut cook add-password-recovery               # and this one too
gut combine                                  # preview: 3 recipes
gut serve                                    # one PR with all 3!
```

## Reactive mode

Real development isn't only planned features. Things break. Ports change. Configs drift. gut handles this with reactive commands that change how the AI behaves.

### `gut season` — Quick fixes

```bash
gut season "change API port to 3001"
gut season "fix import path for utils"
```

Logs the fix and sets **REACTIVE mode** for the AI:
- Minimal changes
- No refactors around the code
- No feature additions
- Get in, fix, get out

### `gut flame` — Emergency fixes

```bash
gut flame "API returns 500"
```

Sets **EMERGENCY mode**:
- Diagnose first
- Smallest possible fix
- Speed over perfection
- Skip extras
- Log for post-mortem

### `gut doctor` — Environment health check

```bash
gut doctor
```

```
🩺 Kitchen health check

Git:
  ✅ Repository initialized
  ✅ On branch: gut/add-auth

Common ports:
  ○ :3000 available
  ● :5432 in use (postgres)

Environment:
  ✅ DATABASE_URL = postgres://...
  ○ REDIS_URL not set
```

## AI modes

gut automatically provides different instructions to the AI based on context:

| Mode | Trigger | AI behavior |
|------|---------|-------------|
| **Planned** | `gut cook` | Full context, follow the plan, go deep, write tests |
| **Reactive** | `gut season` | Minimal context, surgical fix, no refactors |
| **Emergency** | `gut flame` | Fix NOW, skip extras, speed over perfection |

Mode instructions live in `.gut/modes/` and are included when you run `gut context`.

## Kitchen management

```bash
gut init          # set up .gut/ in your project
gut menu          # list recipes by status
gut status        # what's cooking?
gut resume        # pick up where you left off (AI handoff)
gut resume copy   # copy resume to clipboard for AI
gut pantry        # manage project context
gut pantry edit   # edit context.md
gut pantry add    # add a new context file
gut context       # bundle all context to clipboard (for AI)
gut ingredients   # what context does a recipe need?
gut doctor        # check environment health
gut spoiled       # find abandoned recipes (>7 days)
```

## Resuming work

When you return to a project or switch branches, `gut resume` helps you (and the AI) catch up:

```bash
$ gut resume

🔄 Resume: pick up where you left off

Branch: gut/add-user-auth

Recipes in this branch:
  🍳 add-user-auth: Add user authentication (cooking)
  📝 add-2fa: Add two-factor authentication (prepped)

Files changed (vs main):
  A src/middleware/auth.ts
  A src/routes/auth.ts
  M src/app.ts

Recent commits:
  a1b2c3d feat: add JWT token generation
  d4e5f6g feat: create User model
  h7i8j9k feat: add login endpoint

Quick fixes (seasonings):
  🧂 add-user-auth:
    [2024-01-31 14:20] fix bcrypt import
    [2024-01-31 15:30] change token expiry to 24h
```

Copy for AI handoff:

```bash
gut resume copy    # copies the full resume document to clipboard
gut resume file    # saves to .gut/resume-YYYYMMDD.md
```

The resume document includes:
- Active recipes and their status
- Files modified in this branch
- Recent commit history
- Quick fixes applied
- AI instructions to continue the work

## The pantry

The pantry (`.gut/pantry/`) stores project context that AI assistants need:

```
.gut/pantry/
├── context.md      # Project overview, stack, architecture
└── conventions.md  # Code style, patterns, anti-patterns
```

Add more files as needed: `api.md`, `database.md`, `auth.md`. When you run `gut prep`, all pantry context is bundled with your recipe.

## Directory structure

```
.gut/
├── pantry/     # Project context (the AI reads this)
│   ├── context.md
│   ├── conventions.md
│   └── health.yml      # For gut doctor
├── recipes/    # Your specs
├── prep/       # Implementation plans
├── seasoning/  # Quick fix logs
├── flame/      # Emergency logs
├── modes/      # AI behavior instructions
│   ├── planned.md
│   ├── reactive.md
│   └── emergency.md
└── plated/     # Completed recipes (history)
```

## Recipe statuses

| Status | Icon | Meaning |
|--------|------|---------|
| draft | ○ | Recipe written, not prepped |
| prepped | ◐ | Plan ready, not started |
| cooking | ◑ | Implementation in progress |
| tasting | ◕ | Testing/verification |
| served | ● | Shipped! |
| spoiled | ✗ | Abandoned (>7 days inactive) |

## Installation

### From source

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

Copy `gut` to a location in your PATH:

```bash
cp gut /usr/local/bin/gut
chmod +x /usr/local/bin/gut
```

## Agent integration (JSON output)

gut provides structured JSON output for AI agents to process:

```bash
# Get structured state for any AI agent
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

### Agent commands

```bash
gut questions --json    # list open questions
gut step --json         # list all steps with status
gut answer <recipe> 0 "email/password"  # answer a question by index
gut step done <recipe> 2                # mark a step as done
```

This enables any AI agent (Claude Code, Cursor, Copilot, etc.) to:
1. Parse structured state
2. Present interactive forms
3. Save user decisions back into recipes

## Language support

gut supports English and Portuguese:

```bash
# Set language
export GUT_LANG=pt   # Portuguese
export GUT_LANG=en   # English (default)

# Or per command
GUT_LANG=pt gut help
```

## Requirements

- Bash 4+
- Git (for branch management)
- GitHub CLI `gh` (optional, for PR creation in `gut serve`)

## Works with any AI

gut is AI-agnostic. The prep file is just markdown that any AI can read:

- **Claude Code** — `gut prep feature` and ask Claude to implement
- **ChatGPT** — Copy the prep file into chat
- **Cursor** — Open the prep file and use AI to implement
- **GitHub Copilot** — Reference the prep file in comments
- **Any LLM API** — Include the prep content in your prompt

## Philosophy

1. **Spec first** — Know what you're building before you build
2. **Context is king** — AI is only as good as the context you provide
3. **Clear lineage** — Every line of code traces back to intent
4. **Simple tools** — Pure Bash, no dependencies, works everywhere
5. **AI-agnostic** — Works with any AI assistant, now or later

## License

MIT

## Contributing

Issues and PRs are welcome at [github.com/anthropics/gut-cli](https://github.com/anthropics/gut-cli)

---

## Português (Brasil)

**Fluxo de desenvolvimento nativo de IA para o terminal.**

> "Confie no seu gut. Envie com confiança."

gut é uma ferramenta CLI idealizada por [Marcel Scog](https://github.com/marcelxv) para ajudar desenvolvedores a construir software com desenvolvimento assistido por IA, mantendo uma estrutura e um fluxo de trabalho claros. É uma metáfora culinária para a era da IA: você escreve receitas (especificações), prepara os ingredientes (contexto), cozinha (implementa), prova (testa) e serve (envia).

```
Planejado:  gut recipe → gut prep → gut cook → gut taste → gut serve
Reativo:    gut season (ajuste rápido) | gut flame (emergência)
```

**O insight principal:** a IA deve se comportar de forma diferente de acordo com o contexto. Trabalho planejado exige profundidade. Ajustes rápidos exigem velocidade. O gut orquestra isso automaticamente.

### Por que gut?

O fluxo antigo: `code → commit → PR`

Ele foi desenhado para humanos falando com humanos. Mas agora a IA está no loop, e estamos perdendo:

- **Intenção** — o que você realmente queria
- **Contexto** — o que a IA precisa saber
- **Decisões** — por que esse caminho
- **Linagem** — como chegamos aqui

gut captura tudo isso. Cada funcionalidade começa como uma receita. A IA recebe o contexto completo. O trabalho tem um rastro claro da ideia até o PR enviado.

### Início rápido

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

### O fluxo

#### 1. `gut recipe` — Defina o que você está fazendo

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

#### 2. `gut prep` — Planeje a abordagem

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

#### 3. `gut cook` — Faça o trabalho

```bash
gut cook adicionar-toggle-de-modo-escuro              # cria um novo branch
gut cook adicionar-toggle-de-modo-escuro --branch feature/ui  # usa branch existente
gut cook outra-feature                               # anexa ao branch gut atual
```

Cria ou anexa a um branch e marca a receita como em cook. Várias receitas podem ser anexadas a um branch para um PR combinado.

#### 4. `gut taste` — Verifique se funciona

```bash
gut taste adicionar-toggle-de-modo-escuro
```

Mostra o checklist de critérios de sucesso. Executa testes se encontrar (npm, pytest, make).

#### 5. `gut serve` — Envie

```bash
gut serve adicionar-toggle-de-modo-escuro
```

Faz commit das mudanças, dá push e cria um PR usando o GitHub CLI. Serve todas as receitas ligadas ao branch atual.

### Gerenciamento de branches

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

#### Fluxo com múltiplas receitas

```bash
git checkout -b feature/user-system          # ou: gut branch create user-system
gut cook adicionar-auth                       # anexa ao branch atual
gut cook adicionar-2fa                        # também anexa aqui
gut cook adicionar-recuperacao-senha          # e esta também
gut combine                                   # preview: 3 receitas
gut serve                                     # um PR com as 3!
```

### Modo reativo

Desenvolvimento real não é só feature planejada. Coisas quebram. Portas mudam. Configs ficam inconsistentes. O gut lida com isso com comandos reativos que mudam como a IA se comporta.

#### `gut season` — Ajustes rápidos

```bash
gut season "mudar porta da API para 3001"
gut season "corrigir caminho de import para utils"
```

Registra o ajuste e define o **modo REATIVO** para a IA:
- Mudanças mínimas
- Não refatorar código ao redor
- Não adicionar features
- Entrar, corrigir e sair

#### `gut flame` — Correções emergenciais

```bash
gut flame "API retornando erro 500"
```

Define o **modo EMERGÊNCIA**:
- Diagnosticar primeiro
- Menor correção possível
- Velocidade acima de perfeição
- Pular extras
- Registrar para post-mortem

#### `gut doctor` — Checagem de saúde do ambiente

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

### Modos de IA

gut fornece automaticamente instruções diferentes para a IA com base no contexto:

| Modo | Gatilho | Comportamento da IA |
|------|---------|---------------------|
| **Planejado** | `gut cook` | Contexto completo, seguir o plano, aprofundado, escrever testes |
| **Reativo** | `gut season` | Contexto mínimo, correção cirúrgica, sem refatoração |
| **Emergência** | `gut flame` | Corrigir AGORA, pular extras, velocidade sobre perfeição |

As instruções de modo ficam em `.gut/modes/` e são incluídas quando você executa `gut context`.

### Gestão da cozinha

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

### Retomando o trabalho

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

### O pantry

O pantry (`.gut/pantry/`) guarda o contexto do projeto que assistentes de IA precisam:

```
.gut/pantry/
├── context.md      # Visão geral do projeto, stack, arquitetura
└── conventions.md  # Estilo de código, padrões, anti-padrões
```

Adicione mais arquivos conforme necessário: `api.md`, `database.md`, `auth.md`. Quando você executa `gut prep`, todo o contexto do pantry é empacotado com sua receita.

### Estrutura de diretórios

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

### Status das receitas

| Status | Ícone | Significado |
|--------|-------|-------------|
| draft | ○ | Receita escrita, não preparada |
| prepped | ◐ | Plano pronto, não iniciado |
| cooking | ◑ | Implementação em andamento |
| tasting | ◕ | Testes/verificação |
| served | ● | Enviado! |
| spoiled | ✗ | Abandonada (>7 dias inativa) |

### Instalação

#### A partir do código-fonte

```bash
git clone https://github.com/anthropics/gut-cli
cd gut-cli
./install.sh
```

#### Homebrew

```bash
brew tap anthropics/gut
brew install gut
```

#### Manual

Copie `gut` para algum local no seu PATH:

```bash
cp gut /usr/local/bin/gut
chmod +x /usr/local/bin/gut
```

### Integração com agentes (saída JSON)

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

#### Comandos do agente

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

### Suporte a idiomas

gut suporta inglês e português:

```bash
# Definir idioma
export GUT_LANG=pt   # Português
export GUT_LANG=en   # Inglês (padrão)

# Ou por comando
GUT_LANG=pt gut help
```

### Requisitos

- Bash 4+
- Git (para gerenciamento de branches)
- GitHub CLI `gh` (opcional, para criação de PR no `gut serve`)

### Funciona com qualquer IA

gut é agnóstico de IA. O arquivo de prep é apenas markdown que qualquer IA consegue ler:

- **Claude Code** — `gut prep feature` e peça para o Claude implementar
- **ChatGPT** — Copie o arquivo de prep para o chat
- **Cursor** — Abra o arquivo de prep e use a IA para implementar
- **GitHub Copilot** — Referencie o arquivo de prep em comentários
- **Qualquer LLM API** — Inclua o conteúdo do prep no seu prompt

### Filosofia

1. **Especificação primeiro** — Saiba o que está construindo antes de construir
2. **Contexto é rei** — A IA só é tão boa quanto o contexto que você fornece
3. **Linagem clara** — Cada linha de código rastreia a intenção
4. **Ferramentas simples** — Bash puro, sem dependências, funciona em qualquer lugar
5. **Agnóstico de IA** — Funciona com qualquer assistente de IA, presente ou futuro

### Licença

MIT

### Contribuindo

Issues e PRs são bem-vindos em [github.com/anthropics/gut-cli](https://github.com/anthropics/gut-cli)

---

*Feito para a era do desenvolvimento com IA. Confie no seu gut.*
