part of coUquestmaker;

class Requirement implements QuestData {
	String id;
	String text;
	String iconUrl;
	String type;
	int numRequired;
	String eventType;

	Requirement.parse(Map<String, dynamic> requirement) {
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
}