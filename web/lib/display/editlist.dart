part of coUquestmaker;

class EditList<T extends QuestDisplay> {
	OListElement list;
	List<T> items;
	Function inflate;
	Function template;

	EditList(this.items, this.inflate(Element element), [this.template()]) {
		list = new OListElement()
			..classes = ['editlist'];

		update();
	}

	void update() {
		list.children.clear();

		for (int i = 0; i < items.length; i++) {
			T item = items[i];
			list.append(makeListItem(item, i));
		}

		if (template != null) {
			ButtonElement add = new ButtonElement()
				..classes = ['add']
				..text = 'Create New'
				..onClick.listen((_) => addItem());

			list.append(new LIElement()
				..append(add));
		}
	}

	void readValues() {
		items.clear();

		list.querySelectorAll('.editlist-item').forEach((Element element) {
			items.add(inflate(element));
		});
	}

	LIElement makeListItem(T item, int position) {
		LIElement element = new LIElement();

		ButtonElement moveDown = new ButtonElement()
			..classes = ['down']
			..text = '\u25BC'
			..onClick.first.then((_) => swapItems(position, position + 1));

		if (position == items.length - 1) {
			moveDown.disabled = true;
		}

		ButtonElement moveUp = new ButtonElement()
			..classes = ['up']
			..text = '\u25B2'
			..onClick.first.then((_) => swapItems(position, position - 1));

		if (position == 0) {
			moveUp.disabled = true;
		}

		ButtonElement remove = new ButtonElement()
			..classes = ['remove']
			..text = 'X'
			..onClick.first.then((_) => removeItem(position));

		SpanElement value = new SpanElement()
			..append(item.toElement()
				..classes.add('editlist-item'));

		element
			..append(moveDown)
			..append(moveUp)
			..append(remove)
			..append(value);

		return element;
	}

	void addItem([T item]) {
		readValues();

		items.add(item ?? template());

		update();
	}

	void removeItem(int i) {
		readValues();

		items.removeAt(i);

		update();
	}

	void swapItems(int i1, int i2) {
		readValues();

		T item1 = items[i1];
		T item2 = items[i2];

		items[i1] = item2;
		items[i2] = item1;

		update();
	}
}