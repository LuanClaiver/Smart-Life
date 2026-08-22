# Smart Life v0.3.2

Smart Life integra rotina, gamificação, organização e o módulo Smart Finance.

## Estrutura
- `Arquivos principais`: código usado pelo GitHub Actions/APK.
- `.github`: workflows de compilação do APK.
- `Arquivos GitHub (Ignore)`: itens locais/técnicos que não devem ser enviados ao repositório.

## Smart Finance integrado
A aba **Finanças** trabalha com visão mensal, receitas, despesas, cartões, faturas, empréstimos, recorrências editáveis e planejamento/orçamento. Os dados de contas bancárias permanecem apenas internamente para compatibilidade com o banco e backups do Smart Finance, sem uma aba própria no Smart Life. O app aceita um arquivo portátil `.smartlife-finance.json` para levar os dados entre computador e Android.

**Privacidade:** dados financeiros pessoais não ficam dentro de `Arquivos principais`. Importe o arquivo financeiro no APK depois de instalar.

## APK
Execute manualmente o workflow **Build Android APK** no GitHub Actions.


## Envio para o GitHub
Na raiz de `Arquivos GitHub`, execute `Enviar para GitHub.bat`. O script inicializa o Git quando necessário, solicita a URL do repositório se ainda não houver `origin`, cria o commit e envia para a branch `main`.

## Login local
A v0.3.2 corrige o envio por BAT ao GitHub, cria um plano inicial de missões personalizado com base nas respostas do primeiro acesso, corrige o texto da página Minha Jornada e melhora a iconografia dos atributos.
