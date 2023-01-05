Gin 方法
=============

code
----------

.. code:: go

    package main

    import (
        "github.com/gin-gonic/gin"
    )

    func main() {
        r := gin.Default() // 创建默认路由 logger和recovery中间件
        r.GET("/ping:id", func(c *gin.Context) {
            id := c.Param("id")
            user := c.DefaultQuery("user", "guest")
            pwd := c.Query("pwd")
            c.JSON(200, gin.H{
                "id": id,
                "user": user,
                "pwd": pwd,
            })
        })
        r.POST("/ping", func(c *gin.Context) {
            user := c.DefaultPostForm("user", "guest")
            pwd := c.PostForm("pwd")
            c.JSON(200, gin.H{
                "user": user,
                "pwd": pwd,
            })
        })

        r.DELETE("/ping:id", func(c *gin.Context) {
            id := c.Param("id")
            c.JSON(200, gin.H{
                "id": id,
            })
        })

        r.PUT("/ping", func(c *gin.Context) {
            user := c.DefaultPostForm("user", "guest")
            pwd := c.PostForm("pwd")
            c.JSON(200, gin.H{
                "user": user,
                "pwd": pwd,
            })
        })
        r.Run(":8080") // listen and serve on
    }
