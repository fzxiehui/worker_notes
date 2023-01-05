Gin 路由组
===============

路由组
-------

.. code:: go

    package main

    import (
      "fmt"
      "github.com/gin-gonic/gin"
    )

    func main() {
      r := gin.Default()
      v1 := r.Group("/v1")
      v1.GET("/ping", func(c *gin.Context) {
          fmt.Println("ping")
          c.JSON(200, gin.H{
              "message": "pong",
          })
      })
      r.Run(":8080") // listen and serve on
    }


中间件
--------------


.. code:: go

    package main

    import (
      "fmt"
      "github.com/gin-gonic/gin"
    )

    func main() {
      r := gin.Default()
      r.Use(Middleware())
      r.Use(Middleware2())
      r.GET("/ping", func(c *gin.Context) {
          fmt.Println("ping")
          c.JSON(200, gin.H{
              "message": "pong",
          })
      })
      r.Run(":8080") // listen and serve on
    }

    func Middleware() gin.HandlerFunc {
      return func(c *gin.Context) {
        fmt.Println("middleware start")
        c.Next()
        fmt.Println("middleware end")
      }
    }

    func Middleware2() gin.HandlerFunc {
      return func(c *gin.Context) {
        fmt.Println("middleware2 start")
        c.Next()
        fmt.Println("middleware2 end")
      }
    }

路由组结合中间件
-------------------

.. code:: go

    package main

    import (
      "fmt"
      "github.com/gin-gonic/gin"
    )

    func main() {
      r := gin.Default()
      v1 := r.Group("v1")
      v1.Use(Middleware())
      v1.GET("/ping", func(c *gin.Context) {
          fmt.Println("ping")
          c.JSON(200, gin.H{
              "message": "pong",
          })
      })
      r.Run(":8080") // listen and serve on
    }

    func Middleware() gin.HandlerFunc {
      return func(c *gin.Context) {
        fmt.Println("middleware start")
        c.Next()
        fmt.Println("middleware end")
      }
    }
