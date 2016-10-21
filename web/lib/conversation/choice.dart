part of coUquestmaker;

class Choice implements QuestData {
	String text;
	int gotoScreen;
	bool isQuestAccept;

	Choice.parse(Map<String, dynamic> choice) {
		text = choice['text'];
		gotoScreen = choice['gotoScreen'];
		isQuestAccept = choice['isQuestAccept'] ?? false;
	}

	Map<String, dynamic> toMap() => {
		'text': text,
		'gotoScreen': gotoScreen,
		'isQuestAccept': isQuestAccept
	};
}