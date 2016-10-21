part of coUquestmaker;

class Transcoder {
	static FieldSetElement display = querySelector('#transcoder');

	static final JsonEncoder ENCODER = new JsonEncoder.withIndent('\t');

	TextAreaElement displayText;
	ButtonElement decodeBtn;
	ButtonElement encodeBtn;

	Transcoder() {
		display
			..children.clear()
			..append(new LegendElement()..text = 'Transcode JSON');

		displayText = new TextAreaElement();

		decodeBtn = new ButtonElement()
			..text = '\u25BC Decode'
			..onClick.listen((_) => decode());

		encodeBtn = new ButtonElement()
			..text = '\u25B2 Encode'
			..onClick.listen((_) => encode());

		display
			..append(displayText)
			..append(decodeBtn)
			..append(encodeBtn);
	}

	void decode() {
		try {
			Map<String, dynamic> quest = JSON.decode(displayText.value);
			workingQuest = new Quest.parse(quest);
			questUi = new QuestForm(workingQuest);
		} catch (e) {
			window.alert('Could not decode JSON!\n\n$e');
		}
	}

	void encode() {
		try {
			displayText.value = ENCODER.convert(workingQuest.toMap());
		} catch (e) {
			window.alert('Could not encode JSON!\n\n$e');
		}
	}
}