# Inline input plugin for Embulk

Inline input plugin for Embulk.

## Overview

* **Plugin type**: input
* **Resume supported**: no
* **Cleanup supported**: no
* **Guess supported**: no

## Configuration

- **schema**: embulk schema (array, required)
  - **name**: column name (string, required)
  - **type**: column type (string, required)
- **data**: input data (array, required)

## Example

```yaml
in:
  type: inline
  schema:
    - { name: long_column, type: long }
    - { name: string_column, type: string }
    - { name: double_column, type: double }
    - { name: boolean_column, type: boolean }
    - { name: json_column, type: json }
    - { name: timestamp_column, type: timestamp }
  data:
    - { long_column: 1, string_column: test, json_column: { id: 1, name: toyama }, double_column: 0.1, boolean_column: true, timestamp_column: '2016-06-14 15:19:05' }
    - { long_column: 2, string_column: test, json_column: { id: 2, name: toyama }, double_column: 0.1, boolean_column: true, timestamp_column: '2016-06-14 15:19:05' }
    - { long_column: 3, string_column: test, json_column: { id: 3, name: toyama }, double_column: 0.1, boolean_column: true, timestamp_column: '2016-06-14 15:19:05' }
    - {}
    - { long_column: 4 }

out:
  type: stdout
```

### Output
```
2016-06-14 15:40:47.724 +0900: Embulk v0.8.9
2016-06-14 15:40:49.046 +0900 [INFO] (0001:preview): Loaded plugin embulk/input/inline from a load path
+------------------+----------------------+----------------------+------------------------+--------------------------+----------------------------+
| long_column:long | string_column:string | double_column:double | boolean_column:boolean |         json_column:json | timestamp_column:timestamp |
+------------------+----------------------+----------------------+------------------------+--------------------------+----------------------------+
|                1 |                 test |                  0.1 |                   true | {"id":1,"name":"toyama"} |    2016-06-14 06:19:05 UTC |
|                2 |                 test |                  0.1 |                   true | {"id":2,"name":"toyama"} |    2016-06-14 06:19:05 UTC |
|                3 |                 test |                  0.1 |                   true | {"id":3,"name":"toyama"} |    2016-06-14 06:19:05 UTC |
|                  |                      |                      |                        |                          |                            |
|                4 |                      |                      |                        |                          |                            |
+------------------+----------------------+----------------------+------------------------+--------------------------+----------------------------+
```

## Build

```
$ rake
```
