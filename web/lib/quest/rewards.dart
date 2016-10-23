part of coUquestmaker;

/// Set of metabolics that are awarded to the player upon [Quest] completion
class Rewards implements QuestData, QuestDisplay {
	/// Energy awarded
	int energy = 0;

	/// Mood awarded
	int mood = 0;

	/// iMG awarded
	int img = 0;

	/// Currants awarded
	int currants = 0;

	Rewards();

	Rewards.fromMap(Map<String, dynamic> rewards) {
		energy = rewards['energy'];
		mood = rewards['mood'];
		img = rewards['img'];
		currants = rewards['currants'];
	}

	Map<String, dynamic> toMap() => {
		'energy': energy,
		'mood': mood,
		'img': img,
		'currants': currants
	};

	Rewards.fromElement(Element element) {
		energy = (element.querySelector('[name="energy"]') as NumberInputElement).valueAsNumber;
		mood = (element.querySelector('[name="mood"]') as NumberInputElement).valueAsNumber;
		img = (element.querySelector('[name="img"]') as NumberInputElement).valueAsNumber;
		currants = (element.querySelector('[name="currants"]') as NumberInputElement).valueAsNumber;
	}

	Element toElement() => new FieldSetElement()
		..classes = ['rewards']
		..append(new LegendElement()
			..text = 'Rewards')

		..append(new LabelElement()
			..text = 'Energy'
			..append(new NumberInputElement()
				..name = 'energy'
				..min = '0'
				..value = energy.toString()))

		..append(new LabelElement()
			..text = 'Mood'
			..append(new NumberInputElement()
				..name = 'mood'
				..min = '0'
				..value = mood.toString()))

		..append(new LabelElement()
			..text = 'iMG'
			..append(new NumberInputElement()
				..name = 'img'
				..min = '0'
				..value = img.toString()))

		..append(new LabelElement()
			..text = 'Currants'
			..append(new NumberInputElement()
				..name = 'currants'
				..min = '0'
				..value = currants.toString()));
}