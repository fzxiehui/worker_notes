Gin 文件上传下载
======================


上传
----------


.. warning::

   header 中的 Content-Type 必须是 multipart/form-data


.. code-block:: go


    package main

    import (
      "github.com/gin-gonic/gin"
    )

    func main() {
      r := gin.Default()
      r.POST("/upload", func(c *gin.Context) {
        // 获取上传的文件
        file, _ := c.FormFile("file")

        // 保存指定目录
        c.SaveUploadedFile(file, file.Filename)

        c.JSON(200, gin.H{
          "msg": file,
        })

      })
      r.Run(":8080")
    }
