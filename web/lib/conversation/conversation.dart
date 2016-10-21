part of coUquestmaker;

class Conversation implements QuestData {
	String id = '';
	List<Screen> screens = [];

	Conversation();

	Conversation.parse(Map<String, dynamic> conversation) {
		id = conversation['id'];

		screens = [];
		for (Map<String, dynamic> screen in conversation['screens']) {
			screens.add(new Screen.parse(screen));
		}
	}

	Map<String, dynamic> toMap() {
		Map<String, dynamic> encoded = {
			'id': id,
			'screens': []
		};

		for (Screen screen in screens) {
			encoded['screens'].add(screen.toMap());
		}

		return encoded;
	}
}