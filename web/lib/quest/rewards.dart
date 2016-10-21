part of coUquestmaker;

class Rewards implements QuestData {
	int energy = 0;
	int mood = 0;
	int img = 0;
	int currants = 0;

	Rewards();

	Rewards.parse(Map<String, dynamic> rewards) {
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
}