part of coUquestmaker;

class Conversation implements QuestData, QuestDisplay {
	String id = '';
	List<Screen> screens = [];

	Conversation();

	Conversation.fromMap(Map<String, dynamic> conversation) {
		id = conversation['id'];

		screens = [];
		for (Map<String, dynamic> screen in conversation['screens']) {
			screens.add(new Screen.fromMap(screen));
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

	Conversation.fromElement(Element element) {
		id = (element.querySelector('[name="id"]') as TextInputElement).value;

		element.querySelectorAll('.screen').forEach((Element element) {
			screens.add(new Screen.fromElement(element));
		});
	}

	Element toElement([String title]) => new FieldSetElement()
		..append(new LegendElement()
			..text = 'Conversation' + (title != null ? ': $title' : ''))
		..append(new TextInputElement()
			..name = 'id'
			..placeholder = 'ID'
			..value = id)
		..append(new EditList(screens,
			(Element element) => new Screen.fromElement(element),
			() => new Screen()).list..classes.add('screens'));
}