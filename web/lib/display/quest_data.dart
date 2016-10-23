part of coUquestmaker;

/// Quest components than can be encoded and decoded
abstract class QuestData {
	/// Use default values
	QuestData();

	/// Decode the component
	QuestData.fromMap(Map<String, dynamic> questData);

	/// Encode the component
	Map<String, dynamic> toMap();
}

/// Quest components than can be converted to DOM objects
abstract class QuestDisplay {
	/// Decode the component
	QuestDisplay.fromElement(Element element);

	/// Encode the component
	Element toElement();
}

/// Textbox input
class ShortText implements QuestDisplay {
	/// Value of the input
	String string;

	/// Create a new input with optional initial value [string]
	ShortText([this.string = '']);

	/// Read an existing input
	ShortText.fromElement(Element element) {
		string = (element as TextInputElement).value.trim();
	}

	/// Return the input as a DOM object
	Element toElement() => new TextInputElement()
		..classes = ['shorttext']
		..value = string;
}

/// Textarea input
class LongText implements QuestDisplay {
	/// Value of the input
	String string;

	/// Create a new input with optional initial value [string]
	LongText([this.string = '']);

	/// Read an existing input
	LongText.fromElement(Element element) {
		string = (element as TextAreaElement).value.trim();
	}

	/// Return the input as a DOM object
	Element toElement() => new TextAreaElement()
		..classes = ['longtext']
		..value = string;
}