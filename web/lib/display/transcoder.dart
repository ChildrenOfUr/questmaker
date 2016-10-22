part of coUquestmaker;

class Transcoder {
	static FieldSetElement transcoderDisplay = querySelector('#transcoder');

	static final JsonEncoder ENCODER = new JsonEncoder.withIndent('\t');

	TextAreaElement displayText;
	ButtonElement decodeBtn;
	ButtonElement encodeBtn;

	Transcoder() {
		transcoderDisplay
			..children.clear()
			..append(new LegendElement()..text = 'Transcode JSON');

		displayText = new TextAreaElement();

		decodeBtn = new ButtonElement()
			..text = '\u25BC Decode'
			..onClick.listen((_) => decode());

		encodeBtn = new ButtonElement()
			..text = '\u25B2 Encode'
			..onClick.listen((_) => encode());

		transcoderDisplay
			..append(displayText)
			..append(decodeBtn)
			..append(encodeBtn);
	}

	void decode([Map<String, dynamic> presetQuest]) {
		Map<String, dynamic> quest;

		if (presetQuest != null) {
			quest = presetQuest;
		} else {
			try {
				quest = JSON.decode(displayText.value);
			} catch (e,st) {
				window.alert('Could not decode JSON!\n\n$e\n$st');
			}
		}

		try {
			workingQuest = new Quest.fromMap(quest);
		} catch (e, st) {
			window.alert('Could not inflate quest!\n\n$e\n$st');
		}

		try {
			Element newQuestDisplay = workingQuest.toElement();
			questDisplay.replaceWith(newQuestDisplay);
			questDisplay = newQuestDisplay;
		} catch (e, st) {
			window.alert('Could not display quest!\n\n$e\n$st');
		}
	}

	void encode() {
		try {
			workingQuest = new Quest.fromElement(questDisplay);
		} catch (e, st) {
			window.alert('Could not input quest!\n\n$e\n$st');
		}

		Map<String, dynamic> questMap;

		try {
			questMap = workingQuest.toMap();
		} catch (e, st) {
			window.alert('Could not deflate quest!\n\n$e\n$st');
		}

		try {
			displayText.value = ENCODER.convert(questMap);
		} catch (e, st) {
			window.alert('Could not encode JSON!\n\n$e\n$st');
		}
	}
}