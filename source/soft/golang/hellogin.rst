Hello Gin 
===============

创建项目
-------------

.. code:: bash

    $ mkdir hello-gin
    $ cd hello-gin
    $ go mod init hello-gin


安装gin
-------------

.. code:: bash

    $ go get -u github.com/gin-gonic/gin


创建main.go
-------------
.. code:: go

    package main

    import (
        "github.com/gin-gonic/gin"
    )

    func main() {
        r := gin.Default() // 创建默认路由 logger和recovery中间件
        r.GET("/ping", func(c *gin.Context) {
            c.JSON(200, gin.H{
                "message": "Hello Gin",
            })
        })
        r.Run() // listen and serve on
    }


运行
-------------

.. code:: bash

    $ go run main.go
