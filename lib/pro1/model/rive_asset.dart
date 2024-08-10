import 'package:rive/rive.dart';

class RiveAssets {
  final String artboard, stateMachineName, title, scr;
  SMIBool? input;

  RiveAssets(this.scr,
      {required this.artboard,
      required this.stateMachineName,
      required this.title});
}

List<RiveAssets> bottomNavs = [
  RiveAssets('assets/riveassets/icons.riv',
      artboard: 'CHAT', stateMachineName: 'CHAT_Interactivity', title: 'Chat'),
  RiveAssets('assets/riveassets/icons.riv',
      artboard: 'SEARCH',
      stateMachineName: 'SEARCH_Interactivity',
      title: 'Search'),
  RiveAssets('assets/riveassets/icons.riv',
      artboard: 'TIMER',
      stateMachineName: 'TIMER_Interactivity',
      title: 'Timer'),
  RiveAssets('assets/riveassets/icons.riv',
      artboard: 'BELL',
      stateMachineName: 'BELL_Interactivity',
      title: 'Notifications'),
  RiveAssets('assets/riveassets/icons.riv',
      artboard: 'USER',
      stateMachineName: 'USER_Interactivity',
      title: 'Profile'),
];

List<RiveAssets> slideMenus = [
  RiveAssets('assets/riveassets/icons.riv',
      artboard: 'HOME', stateMachineName: 'HOME_interactivity', title: 'Home'),
  RiveAssets('assets/riveassets/icons.riv',
      artboard: 'SEARCH',
      stateMachineName: 'SEARCH_Interactivity',
      title: 'Search'),
  RiveAssets('assets/riveassets/icons.riv',
      artboard: 'LIKE/STAR',
      stateMachineName: 'STAR_Interactivity',
      title: 'Favorites'),
  RiveAssets('assets/riveassets/icons.riv',
      artboard: 'CHAT', stateMachineName: 'CHAT_Interactivity', title: 'Help'),
];

List<RiveAssets> sideMenu2 = [
  RiveAssets('assets/riveassets/icons.riv',
      artboard: 'TIMER',
      stateMachineName: 'TIMER_Interactivity',
      title: 'History'),
  RiveAssets('assets/riveassets/icons.riv',
      artboard: 'BELL',
      stateMachineName: 'BELL_Interactivity',
      title: 'Notifications'),
      
];
