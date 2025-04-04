import 'package:dapple/features/expert_talk/data/models/expert_model.dart';

abstract class ExpertLocalDataSource {
  Future<List<ExpertModel>> getExperts();
}

class ExpertLocalDataSourceImpl implements ExpertLocalDataSource {
  @override
  Future<List<ExpertModel>> getExperts() async {
    // Hardcoded list of experts
    final experts = [
      ExpertModel(
        expertId: '1',
        name: 'Dr. Alice Johnson',
        image: 'https://example.com/alice.jpg',
        description: 'Experienced Neurologist with 10 years of practice',
        xp: 1000, // Experience points or years of experience
        rating: 4.9,
      ),
      ExpertModel(
        expertId: '2',
        name: 'Dr. Bob Wilson',
        image: 'https://example.com/bob.jpg',
        description: 'Orthopedic Surgeon specializing in joint replacements',
        xp: 800,
        rating: 4.7,
      ),
      ExpertModel(
        expertId: '3',
        name: 'Dr. Charlie Brown',
        image: 'https://example.com/charlie.jpg',
        description: 'Pediatrician with a focus on child development',
        xp: 600,
        rating: 4.5,
      ),
    ];

    return experts;
  }
}