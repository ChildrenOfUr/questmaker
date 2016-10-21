part of coUquestmaker;

class QuestForm {
	static FieldSetElement display = querySelector('#questform');

	TextInputElement idInput;
	TextInputElement titleInput;
	TextAreaElement descriptionInput;

	NumberInputElement rewardEnergyInput;
	NumberInputElement rewardMoodInput;
	NumberInputElement rewardImgInput;
	NumberInputElement rewardCurrantsInput;

	QuestForm([Quest quest]) {
		display
			..children.clear()
			..append(new LegendElement()..text = 'Editing Quest');

		if (quest == null) {
			quest = new Quest();
		}

		idInput = new TextInputElement()
			..placeholder = 'ID'
			..value = quest.id
			..onChange.listen((_) => workingQuest.id = idInput.value);

		titleInput = new TextInputElement()
			..placeholder = 'Title'
			..value = quest.title
			..onChange.listen((_) => workingQuest.title = titleInput.value);

		descriptionInput = new TextAreaElement()
			..placeholder = 'Description'
			..value = quest.description
			..onChange.listen((_) => workingQuest.description = descriptionInput.value);

		rewardEnergyInput = new NumberInputElement()
			..min = '0'
			..value = quest.rewards.energy.toString()
			..onChange.listen((_) => workingQuest.rewards.energy = rewardEnergyInput.valueAsNumber);

		rewardMoodInput = new NumberInputElement()
			..min = '0'
			..value = quest.rewards.mood.toString()
			..onChange.listen((_) => workingQuest.rewards.mood = rewardMoodInput.valueAsNumber);

		rewardImgInput = new NumberInputElement()
			..min = '0'
			..value = quest.rewards.img.toString()
			..onChange.listen((_) => workingQuest.rewards.img = rewardImgInput.valueAsNumber);

		rewardCurrantsInput = new NumberInputElement()
			..min = '0'
			..value = quest.rewards.currants.toString()
			..onChange.listen((_) => workingQuest.rewards.currants = rewardCurrantsInput.valueAsNumber);

		display
			..append(idInput)
			..append(titleInput)
			..append(descriptionInput)
			..append(new FieldSetElement()
				..append(new LegendElement()
					..text = 'Rewards')
				..append(new LabelElement()
					..text = 'Energy'
					..append(rewardEnergyInput))
				..append(new LabelElement()
					..text = 'Mood'
					..append(rewardMoodInput))
				..append(new LabelElement()
					..text = 'iMG'
					..append(rewardImgInput))
				..append(new LabelElement()
					..text = 'Currants'
					..append(rewardCurrantsInput)));
	}
}