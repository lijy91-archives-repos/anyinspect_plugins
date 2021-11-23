# anyinspect_plugin_network

[![pub version][pub-image]][pub-url]

[pub-image]: https://img.shields.io/pub/v/anyinspect_plugin_network.svg
[pub-url]: https://pub.dev/packages/anyinspect_plugin_network

[![Discord](https://img.shields.io/badge/discord-%237289DA.svg?style=for-the-badge&logo=discord&logoColor=white)](https://discord.gg/RzFrAhmXFY)

---

## Quick Start

Please refer to our [Quick Start](https://anyinspect.dev/docs) guide to set up AnyInspect.

### Installation

```yaml
dependencies:
  anyinspect_plugin_network: ^0.1.0
```

## Usage

```dart
import 'package:anyinspect/anyinspect.dart';
import 'package:anyinspect_plugin_network/anyinspect_plugin_network.dart';
import 'package:flutter/foundation.dart';

Future<void> main(List<String> args) async {
  if (!kReleaseMode) {
    AnyInspect anyInspect = AnyInspect.instance;
    anyInspect.addPlugin(AnyInspectPluginNetwork());
    anyInspect.start();
  }
  
  // ...
}
```
