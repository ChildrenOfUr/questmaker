part of coUquestmaker;

class Screen implements QuestData {
	List<String> paragraphs;
	List<Choice> choices;

	Screen.parse(Map<String, dynamic> screen) {
		paragraphs = screen['paragraphs'];

		choices = [];
		for (Map<String, dynamic> choice in screen['choices']) {
			choices.add(new Choice.parse(choice));
		}
	}

	Map<String, dynamic> toMap() {
		Map<String, dynamic> encoded = {
			'paragraph': paragraphs,
			'choices': []
		};

		for (Choice choice in choices) {
			encoded['choices'].add(choice.toMap());
		}

		return encoded;
	}
}