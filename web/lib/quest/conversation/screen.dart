part of coUquestmaker;

class Screen implements QuestData, QuestDisplay {
	List<String> paragraphs = [];
	List<Choice> choices = [];

	Screen();

	Screen.fromMap(Map<String, dynamic> screen) {
		paragraphs = screen['paragraphs'];

		choices = [];
		for (Map<String, dynamic> choice in screen['choices']) {
			choices.add(new Choice.fromMap(choice));
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

	Screen.fromElement(Element element) {
		element.querySelectorAll('.paragraphs .longtext').forEach((Element element) {
			LongText text = new LongText.fromElement(element);
			paragraphs.add(text.string);
		});

		element.querySelectorAll('.choices .choice').forEach((Element element) {
			choices.add(new Choice.fromElement(element));
		});
	}

	Element toElement() {
		List<LongText> paragraphEditors = [];
		for (String string in paragraphs) {
			paragraphEditors.add(new LongText(string));
		}

		EditList paragraphEditList = new EditList(paragraphEditors,
			(Element element) => new LongText.fromElement(element),
			() => new LongText());

		EditList choicesEditList = new EditList(choices,
			(Element element) => new Choice.fromElement(element),
			() => new Choice());

		return new FieldSetElement()
			..classes = ['screen']
			..append(new LegendElement()
				..text = 'Screen')

			..append(new FieldSetElement()
				..append(new LegendElement()
					..text = 'Paragraphs')
				..append(paragraphEditList.list
					..classes.add('paragraphs')))

			..append(new FieldSetElement()
				..append(new LegendElement()
					..text = 'Choices')
				..append(choicesEditList.list
					..classes.add('choices')));
	}
}