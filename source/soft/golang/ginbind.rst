Gin 绑定
=============

默认验证
------------------

.. warning::

   支持多种数据形式使用 ``c.ShouldBind(&)`` , 结合前端 ``Content-Type = application/json`` 使用

   单个形式使用 ``c.ShouldBindQuery(&)`` , ``c.ShouldBindHeader(&)`` , ``c.ShouldBindUri(&)`` , ``c.ShouldBindBody(&)``


.. code:: go

    package main

    import (
      "github.com/gin-gonic/gin"
    )

    // gt > 10, lt < 10, gte >= 10, lte <= 10
    type User struct {
      Name string `form:"name" json:"name" binding:"required"`
      Age  int    `form:"age" json:"age" binding:"required,gt=10"`
    }

    func main() {
      r := gin.Default()
      r.POST("/user", func(c *gin.Context) {
        var user User
        if err := c.ShouldBind(&user); err != nil {
          c.JSON(400, gin.H{"error": err.Error()})
          return
        }
        c.JSON(200, gin.H{"user": user})
      })
      r.Run(":8080")
    }


默认验证规则
------------------- 

@TODO 待验证

=========== ===================
验证器      说明
=========== ===================
required    必须输入
len         长度
email       邮箱
url         URL
regex       正则
in          在列表中
max         最大值
min         最小值
gt          大于
gte         大等于
lt          小于
lte         小等于
eq          等于
ne          不等于
oneof       在列表中
=========== ===================


自定义验证
----------------------

.. code:: go

    package main

    import (
      "github.com/gin-gonic/gin"
      "github.com/gin-gonic/gin/binding"
      "github.com/go-playground/validator/v10"
    )

    // gt > 10, lt < 10, gte >= 10, lte <= 10
    type User struct {
      Name string `form:"name" json:"name" binding:"required"`
      Age  int    `form:"age" json:"age" binding:"required,rule"`
    }

    func main() {
      r := gin.Default()
      if v, ok := binding.Validator.Engine().(*validator.Validate); ok {
        v.RegisterValidation("rule", func(fl validator.FieldLevel) bool {
          if fl.Field().Int() >= 100 {
            return true
          }
          return false
        })
      }
      r.POST("/user", func(c *gin.Context) {
        var user User
        if err := c.ShouldBind(&user); err != nil {
          c.JSON(400, gin.H{"error": err.Error()})
          return
        }
        c.JSON(200, gin.H{"user": user})
      })
      r.Run(":8080")
    }
