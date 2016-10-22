part of coUquestmaker;

abstract class QuestData {
	QuestData.fromMap(Map<String, dynamic> questData);

	Map<String, dynamic> toMap();
}

abstract class QuestDisplay {
	QuestDisplay.fromElement(Element element);

	Element toElement();
}

class ShortText implements QuestDisplay {
	String string;

	ShortText([this.string = '']);

	ShortText.fromElement(Element element) {
		string = (element as TextInputElement).value.trim();
	}

	Element toElement() => new TextInputElement()
		..classes = ['shorttext']
		..value = string;
}

class LongText implements QuestDisplay {
	String string;

	LongText([this.string = '']);

	LongText.fromElement(Element element) {
		string = (element as TextAreaElement).value.trim();
	}

	Element toElement() => new TextAreaElement()
		..classes = ['longtext']
		..value = string;
}