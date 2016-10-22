library coUquestmaker;

import 'dart:convert';
import 'dart:html';
import 'dart:math';

part 'lib/quest_data.dart';

part 'lib/conversation/choice.dart';
part 'lib/conversation/conversation.dart';
part 'lib/conversation/screen.dart';

part 'lib/display/editlist.dart';
part 'lib/display/transcoder.dart';

part 'lib/quest/quest.dart';
part 'lib/quest/requirement.dart';
part 'lib/quest/rewards.dart';

final Random RAND = new Random();

FieldSetElement questDisplay = querySelector('#questform');
Transcoder transcoder;
Quest workingQuest = new Quest();

void main() {
	transcoder = new Transcoder();
	transcoder.decode(workingQuest.toMap());
}