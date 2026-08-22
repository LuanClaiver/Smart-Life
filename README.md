<p align="center">
  <img src="docs/images/smart-life-icon.png" alt="Ícone do Smart Life" width="150">
</p>

<h1 align="center">Smart Life v0.3.8</h1>

<p align="center">
  <strong>Sua rotina transformada em uma jornada de evolução.</strong><br>
  Hábitos, missões, projetos, organização, IA e finanças em um só aplicativo.
</p>

<p align="center">
  🟢 Local e privado &nbsp;•&nbsp; 🎮 Gamificado &nbsp;•&nbsp; 📱 Android e computador &nbsp;•&nbsp; 🤖 Gemini opcional
</p>

---

## ✨ O que é o Smart Life

O **Smart Life** é um organizador pessoal gamificado. Cada hábito e missão concluída gera XP, desenvolve atributos e faz o personagem evoluir de acordo com o nível real do usuário.

### Principais recursos

- **Hábitos e Planner:** rotinas recorrentes, histórico, sequência, XP e atributos.
- **Missões:** abas Abertas e Concluídas, histórico e missões personalizadas.
- **Evolução RPG:** personagem, nível, rank, títulos e status.
- **Projetos & Metas:** projetos comuns, metas numéricas e financeiras.
- **Organização:** páginas para planos, ideias e anotações.
- **Smart Finance integrado:** receitas, despesas, cartões, faturas, empréstimos e recorrências.
- **Central IA:** missões, planejamento de metas, organização semanal e revisão semanal com Gemini.
- **Backup protegido:** exportação e importação sem incluir a chave da API.

## ⚔️ Evolução visual do personagem

O personagem exibido na aba **Evolução** muda automaticamente conforme o nível.

<table>
  <tr>
    <td align="center"><strong>Níveis 1–10</strong><br>Caçador Fraco</td>
    <td align="center"><strong>Níveis 11–20</strong><br>Despertando</td>
    <td align="center"><strong>Níveis 21–39</strong><br>Caçador de Elite</td>
    <td align="center"><strong>Nível 40+</strong><br>Monarca das Sombras</td>
  </tr>
  <tr>
    <td><img src="docs/images/level-01-10.jpg" alt="Personagem de corpo inteiro dos níveis 1 a 10" width="210"></td>
    <td><img src="docs/images/level-11-20.jpg" alt="Personagem de corpo inteiro dos níveis 11 a 20" width="210"></td>
    <td><img src="docs/images/level-21-39.jpg" alt="Personagem dos níveis 21 a 39" width="210"></td>
    <td><img src="docs/images/level-40-plus.jpg" alt="Personagem do nível 40 em diante" width="210"></td>
  </tr>
</table>

## 🗂️ Estrutura do repositório

- `Arquivos principais`: código usado pelo GitHub Actions e pelo APK.
- `.github/workflows`: compilação automática do Android.
- `docs/images`: imagens exibidas neste README.
- `Arquivos GitHub (Ignore)`: históricos e dados locais que não devem ser enviados.
- `Enviar para GitHub.bat`: inicializa, atualiza e envia o repositório.

## 💻 Usar no computador

No pacote completo, abra a pasta `Arquivos Computador` e execute `Iniciar Aplicação.bat`.

Os dados ficam salvos localmente no navegador do dispositivo. Para trocar de computador ou instalar uma versão nova, use o backup do próprio Smart Life.

## 🚀 Enviar para o GitHub

1. Extraia o ZIP completo.
2. Execute `Enviar para GitHub.bat` na pasta principal do pacote.
3. Na primeira execução, informe nome, e-mail e a URL do repositório.
4. Aguarde a mensagem **ENVIO CONCLUÍDO COM SUCESSO**.

O mesmo arquivo também está disponível dentro de `Arquivos GitHub`.

## 📱 Gerar o APK

Após enviar os arquivos:

1. Abra a aba **Actions** do repositório.
2. Escolha **Build Android APK**.
3. Clique em **Run workflow**.
4. Baixe o artefato `Smart-Life-v0.3.8-debug` quando a compilação terminar.

## 🔒 Privacidade

- Login, perfil e progresso permanecem locais.
- Dados financeiros pessoais não fazem parte de `Arquivos principais`.
- A chave Gemini não é incluída no backup.
- A IA só recebe os grupos de dados autorizados nas Configurações.
- Sugestões da IA precisam de confirmação antes de alterar o aplicativo.

## 🆕 Novidades v0.3.8

- Os quatro estágios da Evolução agora usam imagens de corpo inteiro.
- Níveis 1–10 usam `evolution-stage-01.jpg`.
- Níveis 11–20 usam `evolution-stage-02.jpg`.
- Níveis 21–39 usam `evolution-stage-03.jpg`.
- Nível 40+ usa `evolution-stage-04.jpg`.
- Galeria do README sincronizada com as imagens realmente usadas no aplicativo.

## Histórico v0.3.7

- Imagem do personagem restaurada na aba Evolução.
- Personagem selecionado automaticamente pela faixa de nível.
- Caminhos absolutos compatíveis com abertura local pelo BAT e fallback visual para computador e APK.
- Marcação dos hábitos redesenhada e centralizada.
- `Enviar para GitHub.bat` também disponível na pasta principal do pacote.
- README renovado com identidade visual e galeria de evolução.

## Histórico v0.3.6

- Missões separadas nas abas **Abertas** e **Concluídas**.
- Missão concluída permanece nas conclusões recentes por 24 horas e depois vai para o histórico.
- Central IA com geração de missões, planejamento de metas, organização semanal e revisão semanal.
- Permissões individuais para perfil, missões, hábitos, projetos e finanças.
- Teste de conexão do Gemini e chave protegida nos backups.

---

<p align="center">
  <strong>Smart Life</strong><br>
  Evolua um pouco todos os dias.
</p>
