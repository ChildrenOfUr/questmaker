part of coUquestmaker;

/// Dynamic sortable lists of [QuestDisplay] items
class EditList<T extends QuestDisplay> {
	/// DOM list
	OListElement list;

	/// [QuestDisplay] object list
	List<T> items;

	/// [QuestDisplay.fromElement] constructor
	Function inflate;

	/// [QuestDisplay] default constructor
	Function template;

	/**
	 * - [items] must be a list of objects that extend [QuestDisplay]
	 * - [inflate] must be the [fromElement] constructor of the object
	 * - [template] is optional (but the list will not be able to add new items without it),
	 *   and should return a unique object when called
	 */
	EditList(this.items, this.inflate(Element element), [this.template()]) {
		list = new OListElement()
			..classes = ['editlist'];

		update();
	}

	/// Update the DOM based on the current objects in [items]
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

	/// Store changes from the DOM back into [items]
	void readValues() {
		items.clear();

		list.querySelectorAll('.editlist-item').forEach((Element element) {
			items.add(inflate(element));
		});
	}

	/// Create a DOM list item from a [QuestDisplay] object
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

	/// Add a [QuestDisplay] object to the list
	void addItem([T item]) {
		readValues();

		items.add(item ?? template());

		update();
	}

	/// Remove an item from the list (by index)
	void removeItem(int i) {
		readValues();

		items.removeAt(i);

		update();
	}

	/// Switch two items in the list (by indices)
	void swapItems(int i1, int i2) {
		readValues();

		T item1 = items[i1];
		T item2 = items[i2];

		items[i1] = item2;
		items[i2] = item1;

		update();
	}
}