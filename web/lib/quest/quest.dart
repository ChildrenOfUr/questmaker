part of coUquestmaker;

/// Represents the top of the entire Quest component tree.
/// The server can read the JSON that results from encoding this.
class Quest implements QuestData {
	/// Unique quest ID
	String id;

	/// Visible quest title/name (should be unique, but not required)
	String title = '';

	/// Visible long description of the quest
	String description = '';

	/// Everything that the player must do to complete the quest
	List<Requirement> requirements = [];

	/// List of quest [id]s that must be completed before offer
	List<String> prerequisites = [];

	/// Set of metabolics awarded to the player after completion
	Rewards rewards = new Rewards();

	/// [Conversation] from the magic rock when the quest is offered
	Conversation convoStart = new Conversation();

	/// [Conversation] from the magic rock when the quest is completed
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

		element.querySelectorAll('.prerequisites .shorttext').forEach((Element prereq) {
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
		EditList<ShortText> editPrereqs = new EditList(prereqEditors,
			(Element element) => new ShortText.fromElement(element),
			() => new ShortText());

		EditList<Requirement> editRequirements = new EditList(requirements,
			(Element element) => new Requirement.fromElement(element),
			() => new Requirement());

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
				..classes = ['prerequisites']
				..append(new LegendElement()
					..text = 'Prerequisites')
				..append(editPrereqs.list))

			..append(new FieldSetElement()
				..classes = ['requirements']
				..append(new LegendElement()
					..text = 'Requirements')
				..append(editRequirements.list))

			..append(rewards.toElement())

			..append(convoStart.toElement('Offer')
				..classes.add('convo')
				..classes.add('convo-start'))
			..append(convoEnd.toElement('Complete')
				..classes.add('convo')
				..classes.add('convo-end'));
	}
}