# CookBook

## Título do Projeto

CookBook - Aplicativo de Receitas em Vídeo

---

## Objetivo e Descrição da Solução

O CookBook é um aplicativo mobile desenvolvido em Flutter que permite aos usuários:

* **Criação de conta** e autenticação segura via Firebase Authentication.
* **Publicação e visualização de vídeos curtos** de receitas culinárias.
* Organização de conteúdo em um **feed de vídeos** personalizado.
* Acesso a **perfil de usuário** com histórico de publicações.

A solução utiliza a infraestrutura de nuvem do **Firebase** para armazenamento de dados (Firestore), armazenamento de mídia (Firebase Storage) e autenticação, garantindo escalabilidade e segurança.

---

## Tecnologias Utilizadas

* **Flutter & Dart**: Desenvolvimento cross‑platform (iOS e Android).
* **Firebase Authentication**: Gerenciamento de usuários e fluxo de login/cadastro.
* **Cloud Firestore**: Banco de dados NoSQL para armazenar informações de posts e usuários.
* **Firebase Storage**: Upload e hospedagem de arquivos de vídeo.
* **Provider** (ou outro gerenciador de estado): Controle de estado global do aplicativo.
* **Git & GitHub**: Controle de versão e hospedagem do repositório.

---

## Pré-requisitos

Antes de começar, verifique se você possui as seguintes ferramentas instaladas:

* Flutter SDK (>= 2.0.0)
* Android Studio ou Xcode (dependendo da plataforma alvo)
* Firebase CLI
* Git

---

## Como Instalar e Executar o Projeto

1. **Clone o repositório**

   ```bash
   git clone https://github.com/fernandofcs123/app_cookbook.git
   cd app_cookbook
   ```

2. **Instale as dependências**

   ```bash
   flutter pub get
   ```

3. **Configuração do Firebase**

   * Crie um projeto no console do Firebase: [https://console.firebase.google.com/](https://console.firebase.google.com/)
   * Adicione os apps Android e/ou iOS ao projeto.
   * Faça o download dos arquivos `google-services.json` (Android) e/ou `GoogleService-Info.plist` (iOS).
   * Coloque esses arquivos nas pastas correspondentes do projeto:

     * Android: `android/app/`
     * iOS: `ios/Runner/`

4. **Inicialize o Firebase CLI**

   ```bash
   firebase login
   firebase init firestore storage
   ```

5. **Executar no emulador ou dispositivo**

   ```bash
   flutter run
   ```

> **Dica:** Para limpar build anterior e garantir uma instalação limpa:

```bash
flutter clean
flutter pub get
```

---

## Estrutura de Pastas

```
app_cookbook/
├── android/
├── ios/
├── lib/
│   ├── models/       # Modelos de dados
│   ├── providers/    # Gerenciamento de estado
│   ├── screens/      # Telas do aplicativo
│   ├── widgets/      # Componentes reutilizáveis
│   └── main.dart     # Ponto de entrada
└── pubspec.yaml      # Dependências e configurações
```

---

## Contribuição

Contribuições são bem-vindas! Siga os passos abaixo:

1. Faça um fork do projeto.
2. Crie uma branch: `git checkout -b feature/nome-da-feature`
3. Faça commit das suas alterações: `git commit -m 'Adiciona nova feature'`
4. Faça push para a branch: `git push origin feature/nome-da-feature`
5. Abra um Pull Request.

---

## Licença

Este projeto está licenciado sob a **MIT License**. Consulte o arquivo [LICENSE](LICENSE) para mais detalhes.
