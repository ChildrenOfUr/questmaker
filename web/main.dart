library coUquestmaker;

import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'dart:math';

part 'lib/display/editlist.dart';
part 'lib/display/quest_data.dart';
part 'lib/display/transcoder.dart';
part 'lib/quest/quest.dart';
part 'lib/quest/requirement.dart';
part 'lib/quest/rewards.dart';
part 'lib/quest/conversation/choice.dart';
part 'lib/quest/conversation/conversation.dart';
part 'lib/quest/conversation/screen.dart';

/// Random number generator for preset IDs
final Random RAND = new Random();

/// Quest that is currently displayed
Quest workingQuest;

/// Interactive JSON controls
Transcoder transcoder;

/// Start the editor with a new [Quest], but support loading existing data
Future main() async {
	// Set up encode/decode JSON
	transcoder = new Transcoder();

	// Get requirement info from server
	await Requirement.loadTypes();

	// Create a new empty quest and display it
	workingQuest = new Quest();
	transcoder.decode(workingQuest.toMap());
}