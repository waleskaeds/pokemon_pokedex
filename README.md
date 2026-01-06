
# Pokémon Pokédex

## 1. Visão Geral do Projeto

O Pokémon Pokédex é um aplicativo mobile desenvolvido em Flutter que consome dados de uma API pública de Pokémon para exibir uma lista interativa com informações detalhadas sobre cada Pokémon. 

O projeto foi estruturado com foco em boas práticas, arquitetura limpa e testabilidade.

### Funcionalidades Principais

- 📋 Listagem de Pokémons em grid
- 🔍 Visualização de detalhes do Pokémon
- 🧬 Exibição de evoluções
- ⚠️ Tratamento de estados de loading e erro
- 🚀 Splash Screen personalizada
- 🧪 Testes unitários e de widget

---

## 2. Stack Técnica
- Flutter: 3.35.5
- Dart: 3.9.2

### Dependências principais:

- `dio: ^5.9.0`
- `flutter_bloc: ^9.1.1`
- `mocktail: ^1.0.4`
- `bloc_test: ^10.0.0`
- `flutter_native_splash: ^2.4.7`

---

## 3. Arquitetura
O projeto segue os princípios da Clean Architecture, com separação clara de responsabilidades

```
lib/
├── data/ # Datasources e models 
├── domain/ # Entidades e repositórios
├── presentation/ # UI, Cubit e States
```

### Fluxo de Dados:
- A UI dispara uma ação no Cubit;
- O Cubit chama um Use Case / Repositório;
- O repositório busca dados no Datasource remoto (API);
- Os dados retornam como Entidades;
- O Cubit emite novos States, atualizando a UI.

### Gerenciamento de Estado
O gerenciamento de estado é feito com flutter_bloc (Cubit), escolhido pelos seguintes motivos:
- Clareza na separação de estados
- Facilidade de testes
- Previsibilidade do fluxo de dados
- Ampla adoção na comunidade Flutter
- Familiaridade com o gerenciador
O BLoC tradicional adicionaria complexidade desnecessária ao projeto, enquanto o Cubit atende perfeitamente às necessidades da aplicação.

---

## 4. Instruções de Setup
### Pré-requisitos
- Flutter SDK >= 3.35.x
- Dart SDK >= 3.9.x
- Android Studio / VS Code / XCode
- Emulador Android, simulador iOS ou dispositivo físico

### Instalação
- Clone o repositório
> `git clone <https://github.com/waleskaeds/pokemon_pokedex.git>`
- Acesse a pasta do arquivo
> `cd pokemon_pokedex`
- Instale as dependências
> `flutter pub get`
- (Opcional) Gere splash e ícones:
> `flutter pub run flutter_native_splash:create`
> `flutter pub run flutter_launcher_icons`
- Execute o comando para execução
> `flutter run`

---

## 5. Comandos Úteis

### Executar aplicação
> `flutter run`

### Executar testes
> `flutter test`

### Gerar coverage
> `flutter test --coverage`

### Análise de código
> `flutter analyze`

---

## 6. Justificativa de Pacotes

### dio
**Por que:** Biblioteca HTTP robusta, com suporte a interceptors, tratamento de erros, timeout e boa performance na comunicação com APIs REST.  
**Alternativas:** `http` (mais simples, porém menos flexível).  
**Vantagem:** Solução mais completa, escalável e adequada para projetos estruturados.

### flutter_bloc (Cubit)
**Por que:** Gerenciamento de estado com separação clara de responsabilidades e excelente testabilidade. O uso do Cubit reduz a complexidade em comparação ao BLoC tradicional.  
**Alternativas:** Provider, Riverpod, BLoC.  
**Vantagem:** Previsibilidade do fluxo de dados, padrão consolidado e familiaridade com o gerenciador.

### mocktail
**Por que:** Facilita a criação de mocks e stubs em testes unitários, permitindo isolar dependências como Cubits, Repositórios e Datasources.  
**Alternativas:** Mockito.  
**Vantagem:** API mais simples, sem necessidade de geração de código, tornando os testes mais rápidos e fáceis de manter.

### bloc_test
**Por que:** Biblioteca específica para testar Cubits e BLoCs, permitindo validar a sequência de estados emitidos de forma clara e objetiva.  
**Alternativas:** Testes manuais com `flutter_test`.  
**Vantagem:** Testes mais legíveis, confiáveis e alinhados às boas práticas do flutter_bloc.

### flutter_native_splash
**Por que:** Permite a criação de splash screen nativa de forma automática, sem necessidade de código adicional.  
**Alternativas:** Implementação manual da splash screen.  
**Vantagem:** Simplicidade, padronização e redução de erros na configuração inicial do app.

---

## 7. Estratégia de Testes

### Como executar os testes
Utilize o comando `flutter test`

### Abordagem de testes utilizada
Testes de Cubit: validação de estados emitidos
Testes de Widget: verificação da UI conforme estados

### Coverage 
Utilize o comando `flutter test --coverage`
O relatório será gerado e disponibilizado na pasta coverage do projeto

---

## 8. Informações Adicionais
- Utiliza sprites HTTPS da PokeAPI em vez das imagens retornadas no JSON, pois estas utilizam URLs HTTP, o que causa problemas de carregamento e segurança na aplicação.
- Algumas informações não são retornadas pela API exatamente conforme especificado no protótipo do Figma; nesses casos, os dados exibidos foram adaptados com base nas informações disponíveis na API, mantendo consistência visual e funcional.