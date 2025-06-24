<> Calculadora de IMC - Flutter <>

Este projeto é um aplicativo mobile de **Calculadora de IMC** com suporte a múltiplos perfis de usuário, histórico de pesos por data e interface moderna.

## Funcionalidades

- **Cadastro de múltiplos perfis:** Cada usuário pode criar seu próprio perfil com nome, altura, sexo, data de nascimento e peso inicial.
- **Seleção de perfil:** Tela inicial lista todos os perfis cadastrados e permite selecionar ou criar um novo.
- **Registro de peso:** Para cada perfil, é possível registrar novos pesos em diferentes datas.
- **Histórico de pesos:** Cada perfil possui seu próprio histórico de pesos, exibido em ordem de registro.
- **Cálculo automático do IMC:** O IMC é calculado e exibido para cada perfil.
- **Exclusão de histórico e perfil:** É possível apagar todo o histórico de pesos ou excluir o perfil (com confirmação).
- **Interface customizada:** Visual moderno com Material Design, cores personalizadas e botões arredondados.

## Estrutura de Pastas

```
lib/
 ├─ controller/        # Lógica dos controladores (Perfil, Peso)
 ├─ database/          # DBHelper simulado (em memória)
 ├─ models/            # Modelos Perfil e Peso
 ├─ screens/           # Telas do app (seleção, cadastro, home, registro de peso)
 └─ main.dart          # Inicialização do app e tema
```

## Como funciona

1. **Ao abrir o app:**  
   Você vê a tela de seleção de perfil. Pode escolher um perfil existente ou criar um novo.

2. **Cadastro de perfil:**  
   Informe nome, altura, sexo, data de nascimento e peso inicial.

3. **Tela do perfil:**  
   Veja os dados do perfil, IMC, histórico de pesos e registre novos pesos.

4. **Histórico:**  
   Todos os pesos registrados para o perfil aparecem listados com data.

5. **Exclusão:**  
   Use os botões no topo da tela do perfil para apagar apenas o histórico de pesos ou o perfil inteiro (com confirmação).

## Observações técnicas

- O banco de dados é simulado em memória (`DBHelper`). Para produção, recomenda-se usar SQLite ou outro banco persistente.
- O app aceita altura e peso com vírgula ou ponto.
- O código está pronto para ser adaptado para banco de dados real.



