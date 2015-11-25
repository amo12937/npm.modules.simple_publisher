# SimplePublisher

Observer パターンのシンプルな実装

## インストール

```
npm install --save-dev amo.modules.simple_publisher
```

## 使い方

```coffeescript
SimplePublisher = require "amo.modules.simple_publisher"

publisher = SimplePublisher.create()

observer = (a, b, c) ->
  console.log a, b, c

unregister = publisher.register "someEvent", observer

publisher.publish "someEvent", 1, 2, 3    # 1, 2, 3 と表示される

unregister()

publisher.publish "someEvent", 4, 5, 6   # 何も表示されない
```



