# Adaptive Composition Architecture (ACA)

> **Share behavior. Compose differences. Isolate capabilities.**
> Compartilhe comportamento. Componha diferenças. Isole capacidades.

## 1. Objetivo

A **Adaptive Composition Architecture (ACA)** é uma convenção arquitetural para aplicações Flutter multiplataforma baseada em:

* Feature-First;
* Clean Architecture;
* Flutter Modular;
* Cubit/BLoC;
* Adaptive Layout;
* composição em vez de alternância condicional;
* isolamento de capacidades específicas de plataforma.

A arquitetura parte de três princípios:

> **Tamanho disponível determina composição visual.**

> **Capacidade da plataforma determina implementação técnica.**

> **Regras de negócio não devem conhecer nenhum dos dois.**

Web, Android e iOS **não são layouts**.

Da mesma forma, `compact`, `medium` e `expanded` **não são plataformas**.

Esses conceitos devem permanecer independentes.

---

# 2. Regra central

Evitar construir widgets com múltiplas interfaces escondidas através de flags:

```dart
return Card(
  padding: isWeb
      ? const EdgeInsets.all(32)
      : const EdgeInsets.all(16),
  child: isWeb
      ? Row(children: [...])
      : Column(children: [...]),
);
```

À medida que a aplicação cresce, isso tende a evoluir para:

```dart
if (isWeb) {
  ...
} else if (isTablet) {
  ...
} else if (Platform.isIOS) {
  ...
}
```

ACA prefere extrair os elementos compartilhados e criar composições explicitamente válidas:

```text
Shared Widgets
      │
      ▼
┌─────────────┐
│ Composition │
├─────────────┤
│ Compact     │
│ Medium      │
│ Expanded    │
└─────────────┘
```

A decisão ocorre uma vez no nível apropriado da Presentation.

---

# 3. Estrutura geral

```text
lib/
│
├── main.dart
│
├── app/
│   ├── app_module.dart
│   └── app_widget.dart
│
├── core/
│   ├── adaptive/
│   ├── design_system/
│   ├── network/
│   └── ...
│
└── modules/
    ├── auth/
    ├── home/
    ├── energy/
    ├── checkout/
    └── profile/
```

A aplicação é organizada prioritariamente por **feature**.

Cada feature é responsável por seu domínio, dados e apresentação.

---

# 4. Estrutura padrão de uma feature

```text
modules/
└── portfolio/
    │
    ├── portfolio_module.dart
    │
    ├── data/
    │   ├── datasources/
    │   ├── models/
    │   └── repositories/
    │
    ├── domain/
    │   ├── entities/
    │   ├── repositories/
    │   └── usecases/
    │
    └── presentation/
        ├── portfolio_presentation.dart
        │
        ├── controllers/
        │
        ├── compact/
        │
        ├── medium/
        │
        ├── expanded/
        │
        └── widgets/
```

Diretórios não são obrigatórios.

Se uma feature possui apenas `compact` e `expanded`, não criar `medium` vazio.

Se não existem datasources, não criar `datasources/` por formalidade.

> A estrutura cresce conforme a complexidade real.

---

# 5. Fluxo arquitetural

A estrutura conceitual é:

```text
               DOMAIN
                  │
                  │
                STATE
                  │
                  ▼
          PRESENTATION
                  │
          Adaptive Decision
           ┌──────┼──────┐
           │      │      │
        Compact Medium Expanded
           │      │      │
           └──────┼──────┘
                  │
            Shared Widgets
```

Em uma dimensão diferente existem capacidades:

```text
Domain Contract
      │
      ▼
Implementation
 ┌────┼─────┐
 │    │     │
Web Android iOS
```

As duas dimensões não devem ser confundidas.

---

# 6. Domain

`domain/` representa regras e conceitos da feature.

```text
domain/
├── entities/
├── repositories/
└── usecases/
```

O Domain não deve depender de:

* Flutter;
* Widgets;
* Layout;
* tamanho de tela;
* Web;
* Android;
* iOS;
* SQLite;
* IndexedDB;
* APIs específicas.

Exemplo:

```dart
class Project {
  final String id;
  final String name;

  const Project({
    required this.id,
    required this.name,
  });
}
```

Contrato:

```dart
abstract interface class ProjectRepository {
  Future<List<Project>> getProjects();
}
```

Use case:

```dart
class GetProjects {
  final ProjectRepository repository;

  GetProjects(this.repository);

  Future<List<Project>> call() {
    return repository.getProjects();
  }
}
```

O Domain sabe que projetos precisam ser obtidos.

Ele não sabe **como**.

---

# 7. Data

`data/` implementa os contratos definidos pelo Domain.

```text
data/
├── datasources/
├── models/
└── repositories/
```

Exemplo:

```dart
class ProjectRepositoryImpl implements ProjectRepository {
  final ProjectDatasource datasource;

  ProjectRepositoryImpl(this.datasource);

  @override
  Future<List<Project>> getProjects() {
    return datasource.getProjects();
  }
}
```

A implementação concreta pode mudar sem alterar Domain ou Presentation.

---

# 8. Presentation

`presentation/` é responsável pela interface e interação da feature.

```text
presentation/
├── home_presentation.dart
├── controllers/
├── compact/
├── medium/
├── expanded/
└── widgets/
```

O arquivo principal é o **boundary adaptativo** da feature.

Exemplo:

```dart
class HomePresentation extends StatelessWidget {
  const HomePresentation({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        if (width < AppBreakpoints.medium) {
          return const HomeCompact();
        }

        if (width < AppBreakpoints.expanded) {
          return const HomeMedium();
        }

        return const HomeExpanded();
      },
    );
  }
}
```

Os breakpoints devem ser centralizados:

```dart
abstract final class AppBreakpoints {
  static const double medium = 600;
  static const double expanded = 1024;
}
```

Os valores são definidos pelo projeto/design system e não devem ser espalhados arbitrariamente pelos widgets.

---

# 9. Compact, Medium e Expanded

Esses nomes representam **espaço disponível**, não dispositivos.

```text
compact/
medium/
expanded/
```

Portanto:

```text
iPhone              → provavelmente Compact
Android Phone       → provavelmente Compact
Web 390px           → Compact

Tablet              → Medium ou Expanded
Web 800px           → Medium

Desktop Web         → Expanded
Tablet Landscape    → possivelmente Expanded
Desktop App         → Expanded
```

Nunca assumir:

```text
Web = Expanded
Android = Compact
iOS = Compact
```

O layout deve responder às constraints disponíveis.

---

# 10. Composição sobre alternância

Considere três elementos compartilhados:

```dart
const EnergyValue();
const EnergyChart();
const EnergyStatus();
```

No Compact:

```dart
class EnergyCompact extends StatelessWidget {
  const EnergyCompact({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        EnergyValue(),
        EnergyChart(),
        EnergyStatus(),
      ],
    );
  }
}
```

No Expanded:

```dart
class EnergyExpanded extends StatelessWidget {
  const EnergyExpanded({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(child: EnergyValue()),
        Expanded(child: EnergyChart()),
        Expanded(child: EnergyStatus()),
      ],
    );
  }
}
```

Os componentes continuam compartilhados:

```text
presentation/
├── compact/
│   └── energy_compact.dart
├── expanded/
│   └── energy_expanded.dart
└── widgets/
    ├── energy_value.dart
    ├── energy_chart.dart
    └── energy_status.dart
```

Evitar:

```dart
class EnergyCard extends StatelessWidget {
  final bool isWeb;
  final bool isTablet;
  final bool compact;

  // várias interfaces escondidas aqui
}
```

---

# 11. Quando NÃO criar outra Presentation

ACA não determina que qualquer diferença visual gere outro arquivo.

Uma diferença trivial:

```dart
padding: compact ? 16 : 24,
```

pode ser perfeitamente aceitável.

Da mesma forma:

```dart
final columns = width > 1000 ? 3 : 2;
```

pode ser adequado para um Grid naturalmente responsivo.

A separação deve ocorrer quando existe **divergência estrutural significativa**.

Exemplo:

```text
Compact

[A]
[B]
[C]


Expanded

[A] [B]
    [C]
```

Aqui existem composições diferentes.

Criar duas presentations torna a intenção explícita.

---

# 12. Princípio da menor divergência

Separar somente aquilo que realmente diverge.

Se muda:

### Uma propriedade

Manter o mesmo widget.

### A organização dos elementos

Criar composição Compact/Medium/Expanded.

### Um componente

Criar implementações diferentes somente daquele componente.

### Uma tela inteira

Criar presentations completas diferentes.

### Uma capacidade técnica

Criar implementações específicas de plataforma atrás de um contrato compartilhado.

---

# 13. Plataforma é uma dimensão diferente

Separação por plataforma deve ocorrer somente quando houver uma **divergência funcional ou técnica real**.

Exemplos:

* SQLite não disponível/suportado da mesma forma no Web;
* filesystem diferente;
* câmera;
* biometria;
* notificações;
* Apple Sign In;
* APIs nativas;
* armazenamento seguro;
* APIs exclusivas do navegador;
* integração específica Android/iOS.

Não criar:

```text
android_presentation/
ios_presentation/
web_presentation/
```

apenas porque os tamanhos das telas diferem.

Plataforma não determina layout.

---

# 14. Exemplo de divergência funcional

Imagine persistência local.

O Domain define:

```dart
abstract interface class LocalStorage {
  Future<void> save(String key, String value);

  Future<String?> read(String key);
}
```

A aplicação pode possuir:

```text
core/
└── storage/
    ├── local_storage.dart
    ├── native/
    │   └── sqlite_local_storage.dart
    └── web/
        └── web_local_storage.dart
```

Native:

```dart
class SqliteLocalStorage implements LocalStorage {
  @override
  Future<void> save(String key, String value) async {
    // SQLite implementation
  }

  @override
  Future<String?> read(String key) async {
    // SQLite implementation
  }
}
```

Web:

```dart
class WebLocalStorage implements LocalStorage {
  @override
  Future<void> save(String key, String value) async {
    // Web-compatible implementation
  }

  @override
  Future<String?> read(String key) async {
    // Web-compatible implementation
  }
}
```

O restante da aplicação conhece apenas:

```dart
LocalStorage
```

Nunca:

```dart
SqliteLocalStorage
WebLocalStorage
```

---

# 15. Flutter Modular resolve a implementação

O módulo pode selecionar a implementação adequada.

Conceitualmente:

```dart
class StorageModule extends Module {
  @override
  void binds(Injector i) {
    i.add<LocalStorage>(
      () => createPlatformStorage(),
    );
  }
}
```

A decisão fica próxima da composição/infraestrutura.

O Domain continua indiferente.

```text
Feature
   │
   ▼
LocalStorage
   ▲
   │
 DI/Module
 ┌─┴─────────────┐
 │               │
SQLite       Web Storage
Native           Web
```

---

# 16. Capabilities são preferíveis a perguntas sobre plataforma

Quando possível, a aplicação deve perguntar:

> “Essa capacidade está disponível?”

em vez de:

> “Estou executando no iOS?”

Exemplo:

```dart
abstract interface class AuthCapabilities {
  bool get supportsAppleSignIn;
  bool get supportsGoogleSignIn;
}
```

A Presentation pode então decidir:

```dart
if (capabilities.supportsAppleSignIn) {
  return const AppleSignInButton();
}

return const GoogleSignInButton();
```

Isso é preferível a espalhar:

```dart
Platform.isIOS
Platform.isAndroid
kIsWeb
```

pela árvore de widgets.

As verificações concretas de plataforma devem ficar isoladas em boundaries apropriados.

---

# 17. Divergência visual e funcional podem coexistir

Considere Login.

Compact:

```text
┌──────────────────┐
│ Logo             │
│ Email            │
│ Senha            │
│ Social Login     │
└──────────────────┘
```

Expanded:

```text
┌────────────────────────────────┐
│ Branding      │ Email          │
│               │ Senha          │
│               │ Social Login   │
└────────────────────────────────┘
```

Isso é divergência de **composição**:

```text
presentation/
├── compact/
│   └── login_compact.dart
└── expanded/
    └── login_expanded.dart
```

Agora suponha que o botão disponível dependa de capability.

Isso é outra responsabilidade:

```text
presentation/
└── widgets/
    └── social_login_button.dart
```

O widget pode consumir uma política:

```dart
class SocialLoginButton extends StatelessWidget {
  final AuthCapabilities capabilities;

  const SocialLoginButton({
    required this.capabilities,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (capabilities.supportsAppleSignIn) {
      return const AppleSignInButton();
    }

    return const GoogleSignInButton();
  }
}
```

Assim:

```text
Layout                Capability

Compact ───────┐
               ├── SocialLoginButton ── Apple
Expanded ──────┘                    └── Google
```

São decisões independentes.

---

# 18. Estado é compartilhado

Layouts diferentes não justificam estados diferentes.

Evitar:

```text
HomeCompactCubit
HomeMediumCubit
HomeExpandedCubit
```

Preferir:

```text
                 HomeCubit
                    │
                 HomeState
                    │
          HomePresentation
             ┌──────┼──────┐
             │      │      │
         Compact  Medium Expanded
```

Exemplo:

```dart
class HomeState {
  final User user;
  final bool hasMeter;
  final bool hasPlant;
  final List<Reward> rewards;

  const HomeState({
    required this.user,
    required this.hasMeter,
    required this.hasPlant,
    required this.rewards,
  });
}
```

As presentations recebem o mesmo estado e apenas o representam de maneiras diferentes.

---

# 19. Presentation específica deve ser simples

Preferencialmente, layouts específicos recebem dados e callbacks.

Exemplo:

```dart
class HomeCompact extends StatelessWidget {
  final HomeState state;
  final VoidCallback onPlantTap;

  const HomeCompact({
    required this.state,
    required this.onPlantTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // composição
  }
}
```

A Presentation principal pode integrar estado e layout:

```dart
class HomePresentation extends StatelessWidget {
  const HomePresentation({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (_, state) {
        return LayoutBuilder(
          builder: (_, constraints) {
            if (constraints.maxWidth < AppBreakpoints.medium) {
              return HomeCompact(
                state: state,
                onPlantTap: () {},
              );
            }

            return HomeExpanded(
              state: state,
              onPlantTap: () {},
            );
          },
        );
      },
    );
  }
}
```

Isso mantém `HomeCompact` e `HomeExpanded` focados em composição.

---

# 20. Flutter Modular

Cada feature pode possuir seu próprio módulo:

```text
home/
├── home_module.dart
├── data/
├── domain/
└── presentation/
```

Exemplo:

```dart
class HomeModule extends Module {
  @override
  void binds(Injector i) {
    i.add<HomeRepository>(HomeRepositoryImpl.new);
    i.add(GetHomeData.new);
    i.add(HomeCubit.new);
  }

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (_) => const HomePresentation(),
    );
  }
}
```

O `AppModule` compõe as features:

```dart
class AppModule extends Module {
  @override
  void routes(RouteManager r) {
    r.module('/auth', module: AuthModule());
    r.module('/home', module: HomeModule());
    r.module('/energy', module: EnergyModule());
    r.module('/profile', module: ProfileModule());
  }
}
```

---

# 21. Core

`core/` contém recursos genuinamente globais.

Exemplo:

```text
core/
├── adaptive/
│   ├── app_breakpoints.dart
│   └── layout_size.dart
│
├── design_system/
│   ├── buttons/
│   ├── cards/
│   ├── inputs/
│   └── typography/
│
├── network/
├── storage/
└── theme/
```

Não transformar `core` em depósito.

Evitar:

```text
core/
├── utils/
├── helpers/
├── managers/
├── miscellaneous/
└── common/
```

Código nasce dentro da feature.

Somente deve subir para `core` quando existir reutilização global concreta.

---

# 22. LayoutSize

A classificação de espaço pode ser centralizada:

```dart
enum LayoutSize {
  compact,
  medium,
  expanded,
}
```

Resolver:

```dart
LayoutSize resolveLayoutSize(double width) {
  if (width < AppBreakpoints.medium) {
    return LayoutSize.compact;
  }

  if (width < AppBreakpoints.expanded) {
    return LayoutSize.medium;
  }

  return LayoutSize.expanded;
}
```

Então uma Presentation pode utilizar:

```dart
final layout = resolveLayoutSize(
  constraints.maxWidth,
);

return switch (layout) {
  LayoutSize.compact => const HomeCompact(),
  LayoutSize.medium => const HomeMedium(),
  LayoutSize.expanded => const HomeExpanded(),
};
```

Isso evita replicar regras de breakpoint pela aplicação.

---

# 23. Não criar layouts inexistentes

Nem toda feature precisa das três representações.

Exemplo:

```text
checkout/
└── presentation/
    ├── checkout_presentation.dart
    ├── compact/
    ├── expanded/
    └── widgets/
```

Se Medium funciona exatamente como Compact:

```dart
return switch (layout) {
  LayoutSize.compact ||
  LayoutSize.medium => const CheckoutCompact(),

  LayoutSize.expanded => const CheckoutExpanded(),
};
```

Não criar:

```text
CheckoutMedium
```

somente para satisfazer a arquitetura.

---

# 24. Design System versus Feature Widgets

Componentes globais:

```text
core/design_system/
├── buttons/
├── inputs/
├── cards/
└── typography/
```

Exemplo:

```text
EcoButton
EcoTextField
EcoCard
EcoDialog
```

Componentes de domínio:

```text
modules/energy/presentation/widgets/
├── energy_chart.dart
├── consumption_card.dart
└── generation_indicator.dart
```

Um componente não deve ir para `core` apenas porque aparece duas vezes dentro da mesma feature.

---

# 25. Testabilidade

ACA transforma variações implícitas em composições explicitamente testáveis.

Em vez de testar:

```dart
Widget(
  isWeb: true,
  isTablet: false,
  isIOS: false,
  compact: false,
);
```

testar diretamente:

```text
HomeCompact
HomeMedium
HomeExpanded
```

Exemplo:

```dart
testWidgets(
  'HomeCompact renders cards vertically',
  (tester) async {
    await tester.pumpWidget(
      const HomeCompact(...),
    );

    // assertions
  },
);
```

E separadamente:

```dart
testWidgets(
  'HomeExpanded renders dashboard grid',
  (tester) async {
    await tester.pumpWidget(
      const HomeExpanded(...),
    );

    // assertions
  },
);
```

Capabilities também podem ser simuladas:

```dart
final capabilities = FakeAuthCapabilities(
  supportsAppleSignIn: true,
);
```

Sem depender da plataforma real do teste.

---

# 26. Localização de bugs

A estrutura deve reduzir o espaço de busca durante manutenção.

Bug:

> “Dashboard quebrado somente em telas grandes.”

Primeiro destino:

```text
home/
└── presentation/
    └── expanded/
```

Bug:

> “Persistência funciona no Android, mas não no navegador.”

Primeiro destino:

```text
storage/
└── web/
```

Bug:

> “Cálculo de economia está incorreto em todas as plataformas.”

Primeiro destino:

```text
energy/
└── domain/
```

A árvore do projeto deve ajudar a indicar **qual responsabilidade provavelmente falhou**.

---

# 27. Anti-patterns

## Platform branching espalhado

Evitar:

```dart
if (kIsWeb) ...
if (Platform.isAndroid) ...
if (Platform.isIOS) ...
```

em dezenas de widgets.

---

## Device naming

Evitar:

```text
phone/
tablet/
desktop/
```

quando a diferença é apenas espaço disponível.

Preferir:

```text
compact/
medium/
expanded/
```

---

## Duplicação de lógica

Evitar:

```text
CompactHomeCubit
ExpandedHomeCubit
```

quando ambos representam o mesmo comportamento.

---

## Widget universal

Evitar:

```dart
UniversalCard(
  isWeb: true,
  isMobile: false,
  isTablet: false,
  horizontal: true,
  compact: false,
  showSidebar: true,
);
```

Esse padrão frequentemente representa várias composições escondidas dentro de uma única classe.

---

## Abstração prematura

Não criar:

```text
BaseAdaptiveAbstractWidgetFactory
```

quando um `LayoutBuilder` e duas compositions resolvem o problema.

---

# 28. Árvore de decisão

Antes de implementar uma diferença, perguntar:

```text
O comportamento de negócio mudou?
        │
       SIM
        │
        └── Domain / Use Case
       
       NÃO
        │
        ▼
A diferença depende do espaço disponível?
        │
       SIM
        │
        └── Compact / Medium / Expanded
       
       NÃO
        │
        ▼
A diferença depende de capacidade da plataforma?
        │
       SIM
        │
        └── Contract + Platform Implementation
       
       NÃO
        │
        ▼
É apenas uma pequena diferença visual?
        │
       SIM
        │
        └── Mesmo Widget
```

Essa decisão deve ocorrer antes de criar novos diretórios ou classes.

---

# 29. Exemplo final

Uma aplicação completa pode evoluir para:

```text
lib/
├── main.dart
│
├── app/
│   ├── app_module.dart
│   └── app_widget.dart
│
├── core/
│   ├── adaptive/
│   │   ├── app_breakpoints.dart
│   │   └── layout_size.dart
│   │
│   ├── design_system/
│   ├── network/
│   │
│   └── storage/
│       ├── local_storage.dart
│       ├── native/
│       │   └── sqlite_local_storage.dart
│       └── web/
│           └── web_local_storage.dart
│
└── modules/
    ├── auth/
    │   ├── auth_module.dart
    │   ├── data/
    │   ├── domain/
    │   └── presentation/
    │       ├── auth_presentation.dart
    │       ├── controllers/
    │       ├── compact/
    │       ├── expanded/
    │       └── widgets/
    │
    ├── home/
    │   ├── home_module.dart
    │   ├── data/
    │   ├── domain/
    │   └── presentation/
    │       ├── home_presentation.dart
    │       ├── controllers/
    │       ├── compact/
    │       ├── medium/
    │       ├── expanded/
    │       └── widgets/
    │
    └── energy/
        ├── energy_module.dart
        ├── data/
        ├── domain/
        └── presentation/
            ├── energy_presentation.dart
            ├── controllers/
            ├── compact/
            ├── expanded/
            └── widgets/
```

---

# 30. Regras para agentes de IA

Ao gerar ou modificar código neste projeto:

1. Identifique primeiro a feature responsável.

2. Preserve a organização Feature-First.

3. Não coloque regra de negócio em Widgets.

4. Não diferencie layout com base em Web, Android ou iOS.

5. Use espaço disponível para selecionar Compact, Medium ou Expanded.

6. Não crie todas as variantes se a feature não precisar delas.

7. Extraia elementos compartilhados antes de duplicar apresentações.

8. Prefira composição sobre flags condicionais.

9. Separe no menor nível onde a divergência ocorre.

10. Não duplique Cubits/BLoCs por layout.

11. Não duplique Domain por plataforma.

12. Quando existir divergência técnica de plataforma, defina primeiro um contrato compartilhado.

13. Mantenha implementações Web/Android/iOS atrás desse contrato.

14. Prefira consultar capabilities a consultar diretamente o nome da plataforma.

15. Centralize breakpoints.

16. Não espalhe `kIsWeb`, `Platform.isIOS` ou `Platform.isAndroid` pela UI.

17. Não mover código para `core` sem reutilização global concreta.

18. Não criar abstrações preventivamente.

19. Respeite a estrutura existente antes de adicionar novas camadas.

20. A estrutura deve tornar evidente onde procurar um bug.

---

# 31. Princípios da ACA

## I — Share Behavior

> Se o comportamento é o mesmo, compartilhe Domain, estado e regras.

## II — Compose Differences

> Se a organização visual diverge significativamente, componha apresentações distintas a partir de componentes compartilhados.

## III — Size Before Platform

> Layout deve responder ao espaço disponível, não ao nome da plataforma.

## IV — Isolate Capabilities

> Diferenças técnicas de plataforma devem existir atrás de contratos ou capabilities.

## V — Minimum Divergence

> Separe somente o menor elemento responsável pela diferença.

## VI — Explicit Valid Compositions

> Prefira poucas composições explicitamente válidas a um único Widget capaz de assumir dezenas de combinações através de flags.

## VII — Local First

> Código começa na feature e somente se torna global quando houver justificativa real.

## VIII — Architecture Must Aid Debugging

> A estrutura do projeto deve reduzir o espaço de busca de um defeito.

---

# 32. Definição resumida

**Adaptive Composition Architecture (ACA)** é uma arquitetura/convenção para Flutter multiplataforma na qual:

* features são módulos independentes;
* Domain e estado são compartilhados;
* layouts são selecionados pelo espaço disponível;
* diferenças estruturais são implementadas através de composição;
* diferenças técnicas de plataforma são isoladas atrás de contratos;
* widgets compartilhados permanecem independentes da composição;
* e condicionais de plataforma/layout são mantidas fora dos componentes sempre que possível.

Em forma reduzida:

```text
Feature
  │
  ├── Data
  │
  ├── Domain
  │
  └── Presentation
         │
         ├── Controller
         │
         ├── Adaptive Composition
         │      ├── Compact
         │      ├── Medium
         │      └── Expanded
         │
         └── Shared Widgets

Platform divergence
         │
         └── Contract
               ├── Native implementation
               └── Web implementation
```

A regra de ouro é:

> **Compartilhe comportamento. Componha diferenças. Isole capacidades.**
