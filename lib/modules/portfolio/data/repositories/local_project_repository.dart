import '../../domain/entities/project.dart';
import '../../domain/repositories/project_repository.dart';

class LocalProjectRepository implements ProjectRepository {
  @override
  List<Project> getProjects() => const [
    Project(
      name: 'Volt Net',
      category: 'Flutter',
      description: 'A rede pode falhar. A experiência não precisa.',
      tags: ['Dart', 'Flutter', 'SQLite'],
      repository: 'volt_net',
      highlight: 'HTTP ENGINE',
      details:
          'Orquestração HTTP para Flutter com cache híbrido em RAM e SQLite, parsing de JSON em isolates e sincronização de operações offline. Inclui interceptors, debounce e política stale-while-revalidate.',
    ),
    Project(
      name: 'LARA AI',
      category: 'Flutter',
      description: 'Inteligência artificial com personalidade.',
      tags: ['Flutter', 'Gemini', 'BLoC'],
      repository: 'LARA_Ai_Chatbot',
      highlight: 'MOBILE + AI',
      details:
          'Prova de conceito mobile com Google Gemini, streaming e personalidades adaptáveis. Clean Architecture, BLoC/Cubit e Flutter Modular, persistência SQLite e pipeline de qualidade com GitHub Actions e Fastlane.',
    ),
    Project(
      name: 'MangaBR Hub',
      category: 'Web',
      description: 'Uma nova página para a experiência de leitura.',
      tags: ['React', 'TypeScript', 'Firebase'],
      repository: 'mangabrhub',
      highlight: 'WEB EXPERIENCE',
      details:
          'Plataforma de leitura em português integrada à API MangaDex. Busca por filtros, leitura paginada ou em cascata, biblioteca pessoal e comentários. Arquitetura desacoplada, proxy serverless, Vitest e deploy na Vercel.',
    ),
    Project(
      name: 'PartyU',
      category: 'Backend',
      description: 'Serviços independentes. Experiências conectadas.',
      tags: ['Kotlin', 'Spring Boot', 'PostgreSQL'],
      repository: 'partyu_back',
      highlight: 'MICROSSERVIÇOS',
      details:
          'Backend de eventos com serviços de usuários, catálogo e eventos. Spring Cloud Gateway e Eureka para roteamento e descoberta, PostgreSQL para persistência e Redis para cache e tokens temporários.',
    ),
  ];
}
