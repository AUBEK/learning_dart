library bootstrap;

import 'package:web_ui/watcher.dart' as watcher;
import 'package:logging/logging.dart';
import 'bank_terminal_s5_mdv.dart' as userMain;

main() {
  watcher.useObservers = false;
  Logger.root.onRecord.listen((record) {
    print('${record.level.name.toLowerCase()}: ${record.message}');
  });
  userMain.main();
  userMain.init_autogenerated();
}
