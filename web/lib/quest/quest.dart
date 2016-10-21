part of coUquestmaker;

class Quest implements QuestData {
	String id;
	String title = '';
	String description = '';
	List<Requirement> requirements = [];
	List<String> prerequisites = [];
	Rewards rewards = new Rewards();
	Conversation convoStart = new Conversation();
	Conversation convoEnd = new Conversation();

	Quest() {
		id = 'NewQuest${RAND.nextInt(999999)}';
	}

	Quest.parse(Map<String, dynamic> quest) {
		id = quest['id'];
		title = quest['title'];
		description = quest['description'];

		requirements = [];
		for (Map<String, dynamic> requirement in quest['requirements']) {
			requirements.add(new Requirement.parse(requirement));
		}

		prerequisites = quest['prerequisites'];
		rewards = new Rewards.parse(quest['rewards']);
		convoStart = new Conversation.parse(quest['conversation_start']);
		convoEnd = new Conversation.parse(quest['conversation_end']);
	}

	Map<String, dynamic> toMap() {
		Map<String, dynamic> encoded = {
			'id': id,
			'title': title,
			'description': description,
			'requirements': [],
			'prerequisites': prerequisites,
			'rewards': rewards.toMap(),
			'conversation_start': convoStart.toMap(),
			'conversation_end': convoEnd.toMap()
		};

		for (Requirement requirement in requirements) {
			encoded['requirements'].add(requirement.toMap());
		}

		return encoded;
	}
}