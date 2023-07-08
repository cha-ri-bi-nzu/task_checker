# README
<br>

## テーブル定義
  <br>
  
  ### Userテーブル
  | id |       name       |       email       |     password     |
  |:--:|:-----------------|:------------------|:-----------------|
  |  1 | Yamamoto Takashi | ######@mail.com   | hogehogehoge     |
  |  2 | Kawachi Keiko    | $$$$$$@mail.com   | fugafuga         |
  |  3 | Akita Komachi    | &&&@mail.com      | mojamojamojamoja |
  |  4 | Nakama Yuya      | %%%%%%%%@mail.com | mmmmmmmm         |

  <br>
  
  ### Taskテーブル
  | id |      name     |    content   | status | priority |   time_limit   | user_id | label_id  |
  |:--:|:---------------|:-------------|:-------|:---------|:---------------|:-------:|:---------:|
  |  1 | テーブル定義    | hogehogehoge | 未着手 |   最優先  | 2023/7/20/15:00 |    2   |      4    |
  |  2 | 要件定義       | hogehogehoge |  完了  |    優先   | 2023/7/17/15:00 |    2   |      6    |
  |  3 | controller作成 | hogehogehoge |  着手  |   最優先  | 2023/7/20/15:00 |    1   |      3    |
  |  4 | model定義      | hogehogehoge | 未着手 |    後で   | 2023/7/20/15:00 |    2   |      8    |

  <br>
  
  ### Labelテーブル
  | id |    name    | task_id |
  |:--:|:-----------|:-------:|
  |  1 | view       |    6    |
  |  2 | table      |    1    |
  |  3 | controller |    3    |
  |  1 | view       |    7    |
  <br>
  
  ### Labelingテーブル
  | id | task_id | label_id  |
  |:--:|:-------:|:---------:|
  |  1 |     6   |      1    |
  |  2 |     1   |      2    |
  |  3 |     3   |      3    |
  |  4 |     7   |      1    |


以下のコマンドを使って、step2ブランチの変更内容をHerokuのmasterブランチに反映する

````
$ git push heroku step2:master
````