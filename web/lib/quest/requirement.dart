part of coUquestmaker;

class Requirement implements QuestData, QuestDisplay {
	static Future<bool> loadTypes() async {
		final String SERVER_URL = 'http://robertmcdermot.com:8181/quests/requirementTypes';
		try {
			String json = await HttpRequest.getString(SERVER_URL);
			Map<String, List<String>> map = JSON.decode(json);

			DataListElement reqTypeList = new DataListElement()
				..id = 'reqtypes';
			(map['types'] as List<String>).forEach((String type) {
				reqTypeList.append(new OptionElement(value: type, data: type));
			});
			document.body.append(reqTypeList);

			DataListElement eventTypeList = new DataListElement()
				..id = 'eventtypes';
			(map['events'] as List<String>).forEach((String event) {
				eventTypeList.append(new OptionElement(value: event, data: event));
			});
			document.body.append(eventTypeList);

			return true;
		} catch (e, st) {
			window.alert('Could not load requirement types from server ($SERVER_URL). Is it up?\n\n$e\n$st');
			return false;
		}
	}

	String id = '';
	String text = '';
	String iconUrl = '';
	String type = '';
	int numRequired = 0;
	String eventType = '';

	Requirement() {
		id = workingQuest.id + '_R${RAND.nextInt(999)}';
	}

	Requirement.fromMap(Map<String, dynamic> requirement) {
		id = requirement['id'];
		text = requirement['text'];
		iconUrl = requirement['iconUrl'];
		type = requirement['type'];
		numRequired = requirement['numRequired'];
		eventType = requirement['eventType'];
	}

	Map<String, dynamic> toMap() => {
		'id': id,
		'text': text,
		'iconUrl': iconUrl,
		'type': type,
		'numRequired': numRequired,
		'eventType': eventType
	};

	Requirement.fromElement(Element element) {
		id = (element.querySelector('[name="id"]') as TextInputElement).value.trim();
		text = (element.querySelector('[name="text"]') as TextInputElement).value.trim();
		iconUrl = (element.querySelector('[name="iconUrl"]') as UrlInputElement).value.trim();
		type = (element.querySelector('[name="type"]') as InputElement).value.trim();
		numRequired = (element.querySelector('[name="numRequired"]') as NumberInputElement).valueAsNumber;
		eventType = (element.querySelector('[name="eventType"]') as TextInputElement).value.trim();
	}

	Element toElement() {
		return new FieldSetElement()
			..classes = ['requirement']
			..append(new LegendElement()
				..text = 'Requirement')

			..append(new TextInputElement()
				..name = 'id'
				..placeholder = 'ID'
				..value = id)

			..append(new TextInputElement()
				..name = 'text'
				..placeholder = 'Text'
				..value = text)

			..append(new UrlInputElement()
				..name = 'iconUrl'
				..placeholder = 'Icon URL'
				..value = iconUrl)

			..append(new TextInputElement()
				..name = 'type'
				..attributes['list'] = 'reqtypes'
				..placeholder = 'Type'
				..value = type)

			..append(new LabelElement()
				..appendText('Number required')
				..append(new NumberInputElement()
					..name = 'numRequired'
					..min = '0'
					..value = numRequired.toString()))

			..append(new TextInputElement()
				..name = 'eventType'
				..attributes['list'] = 'eventtypes'
				..placeholder = 'Event Type'
				..value = eventType);
	}
}