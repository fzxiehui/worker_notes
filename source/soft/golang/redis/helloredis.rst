Hello Redis
===============

.. note::

    快速部署 :ref:`Redis Docker<redis>`

    docs: `Go Redis <https://redis.uptrace.dev/>`_

    gh: https://github.com/go-redis/redis

    可视化工具:

    - `RESP.app <https://resp.app/>`_
    - `Redis Desktop Manager github <https://github.com/RedisInsight/RedisDesktopManager/>`_
    

创建项目
-------------

.. code:: bash

  $ mkdir hello-redis
  $ cd hello-redis
  $ go mod init hello-redis

安装依赖
-------------

.. code:: bash

  $ go get github.com/go-redis/redis/v9


hello redis code
-------------------

.. code-block:: go
  :emphasize-lines: 7, 10-11, 15-20, 22-23, 28-29, 35-37

  package main

  import (
    "context"
    "fmt"

    "github.com/go-redis/redis/v9"
  )

  // 创建 上下文
  var ctx = context.Background()

  func ExampleClient() {

    // 创建 redis 客户端
    rdb := redis.NewClient(&redis.Options{
      Addr:     "192.168.42.10:6379",
      Password: "",
      DB:       0,
    })

    // 设置 key
    err := rdb.Set(ctx, "key", "value", 0).Err()
    if err != nil {
      panic(err)
    }

    // 获取 key
    val, err := rdb.Get(ctx, "key").Result()
    if err != nil {
      panic(err)
    }
    fmt.Println("key", val)

    // 获取一个不存在的 key2
    val2, err := rdb.Get(ctx, "key2").Result()
    if err == redis.Nil {
      // key2 不存在
      fmt.Println("key2 does not exist")
    } else if err != nil {
      panic(err)
    } else {
      fmt.Println("key2", val2)
    }

  }

  func main() {

    ExampleClient()
    fmt.Println("hello go")

  }


