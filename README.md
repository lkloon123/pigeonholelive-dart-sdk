Pigeonhole Dark SDK
============================
[![Latest Stable Version](https://img.shields.io/pub/v/pigeonholelive_sdk.svg)](https://pub.dev/packages/pigeonholelive_sdk)
[![build](https://github.com/lkloon123/pigeonholelive-dart-sdk/actions/workflows/test.yml/badge.svg)](https://github.com/lkloon123/pigeonholelive-dart-sdk/actions)
[![codecov](https://img.shields.io/codecov/c/github/lkloon123/pigeonholelive-dart-sdk.svg)](https://codecov.io/gh/lkloon123/pigeonholelive-dart-sdk)
[![MIT license](https://img.shields.io/badge/license-MIT-brightgreen.svg)](http://opensource.org/licenses/MIT)

 * [Installation](#installation)
 * [Usage](#usage)
 * [Documentation](#documentation)
 * [License](#license)
 
## Installation

1. add `pigeonholelive_sdk` to your `pubspec.yaml`

```yaml
dependencies:
  pigeonholelive_sdk: ^1.0.0
```

2. run `pub get`

## Usage

Create auth using OAuth access token or Workspace token, refer to [Authentication](https://docs.pigeonholelive.com/#section/AUTHENTICATION) for more info

```dart
import 'package:pigeonholelive_sdk/pigeonholelive_sdk.dart';

var pigeonholeLive = PigeonholeLive(
  auth: WorkspaceToken(token: 'xxx')
);

var pigeonholeLive = PigeonholeLive(
  auth: OAuthAccessToken(token: 'xxx')
);
```

#### Responses

For your convenient, the module will return response with related models

```dart
import 'package:pigeonholelive_sdk/pigeonholelive_sdk.dart';

var pigeonholes = await pigeonholeLive.pigeonhole.list();

print(pigeonholes.data?.first.passcode); // ABC123
```

#### Pagination

`PaginationResult` class will return `Function() nextPage`

```dart
import 'package:pigeonholelive_sdk/pigeonholelive_sdk.dart';

var pigeonholes = await pigeonholeLive.pigeonhole.list();

try {
  var nextPagePigeonholes = await pigeonholes.nextPage();
} on NoNextPageException catch (error) {
  // this exeception will be thrown if there's no next page
}
```

#### Available Modules

```dart
pigeonholeLive.attendee
pigeonholeLive.customBranding
pigeonholeLive.pigeonhole
pigeonholeLive.registrant
pigeonholeLive.session
pigeonholeLive.speaker
pigeonholeLive.subscription
pigeonholeLive.workspace
```

## Documentation

Kindly visit [Pigeonholelive Docs](https://docs.pigeonholelive.com) for more usage

## License

This library is released under the [MIT License](LICENSE)
