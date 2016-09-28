# SuperLogger

a beefed up Ruby logger

## Installation

```sh
gem install super_logger_rb
```

## Usage

```rb
require 'super_logger'
logger = SuperLogger.new($stdout, prefix: 'main')
logger.info 'hello world'
```
