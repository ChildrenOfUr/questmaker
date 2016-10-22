part of coUquestmaker;

class Quest implements QuestData {
	String id;
	String title = '';
	String description = '';
	List<Requirement> requirements = [];
	List<String> prerequisites = [];
	Rewards rewards = new Rewards();
	Conversation convoStart = new Conversation();
	Conversation convoEnd = new Conversation();

	Quest() {
		id = 'NewQuest${RAND.nextInt(999999)}';
	}

	Quest.fromMap(Map<String, dynamic> quest) {
		id = quest['id'];
		title = quest['title'];
		description = quest['description'];

		requirements = [];
		for (Map<String, dynamic> requirement in quest['requirements']) {
			requirements.add(new Requirement.fromMap(requirement));
		}

		prerequisites = quest['prerequisites'] ?? [];
		rewards = new Rewards.fromMap(quest['rewards']);
		convoStart = new Conversation.fromMap(quest['conversation_start']);
		convoEnd = new Conversation.fromMap(quest['conversation_end']);
	}

	Map<String, dynamic> toMap() {
		Map<String, dynamic> encoded = {
			'id': id,
			'title': title,
			'description': description,
			'requirements': [],
			'prerequisites': prerequisites,
			'rewards': rewards.toMap(),
			'conversation_start': convoStart.toMap(),
			'conversation_end': convoEnd.toMap()
		};

		for (Requirement requirement in requirements) {
			encoded['requirements'].add(requirement.toMap());
		}

		return encoded;
	}

	Quest.fromElement(Element element) {
		id = (element.querySelector('[name="id"]') as TextInputElement).value.trim();
		title = (element.querySelector('[name="title"]') as TextInputElement).value.trim();
		description = (element.querySelector('[name="description"]') as TextAreaElement).value.trim();

		element.querySelectorAll('.requirement').forEach((Element requirement) {
			requirements.add(new Requirement.fromElement(requirement));
		});

		element.querySelectorAll('.prerequisites input').forEach((Element prereq) {
			prerequisites.add(new ShortText.fromElement(prereq).string);
		});

		rewards = new Rewards.fromElement(element.querySelector('.rewards'));
		convoStart = new Conversation.fromElement(element.querySelector('.convo-start'));
		convoEnd = new Conversation.fromElement(element.querySelector('.convo-end'));
	}

	Element toElement() {
		List<ShortText> prereqEditors = [];
		for (String prereq in prerequisites) {
			prereqEditors.add(new ShortText(prereq));
		}
		EditList<ShortText> editPrereqs = new EditList(items: prereqEditors, template: new ShortText(), inflate: (Element element) {
			return new ShortText.fromElement(element);
		});

		EditList<Requirement> editRequirements = new EditList(items: requirements, template: new Requirement(), inflate: (Element element) {
			return new Requirement.fromElement(element);
		});

		return new FieldSetElement()
			..id = 'questform'
			..append(new LegendElement()
				..text = 'Editing Quest')

			..append(new TextInputElement()
				..placeholder = 'ID'
				..name = 'id'
				..value = id)

			..append(new TextInputElement()
				..placeholder = 'Title'
				..name = 'title'
				..value = title)

			..append(new TextAreaElement()
				..placeholder = 'Description'
				..name = 'description'
				..value = description)

			..append(new FieldSetElement()
				..append(new LegendElement()
					..text = 'Requirements')
				..append(editRequirements.list
					..classes = ['requirements']))

			..append(new FieldSetElement()
				..append(new LegendElement()
					..text = 'Prerequisites')
				..append(editPrereqs.list
					..classes = ['prerequisites']))

			..append(rewards.toElement())

			..append(convoStart.toElement('Offer')
				..classes.add('convo-start'))
			..append(convoEnd.toElement('Complete')
				..classes.add('convo-end'));
	}
}