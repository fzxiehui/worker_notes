ORM
==========

自动迁移模式
--------------------

.. note::

    快速部署 :ref:`MySql Docker<mysql>`

    更多参考 https://gorm.io/zh_CN/docs/index.html

.. code:: go

    package main

    import (
      "fmt"
      "github.com/jinzhu/gorm"
      _ "github.com/go-sql-driver/mysql"
      // _ "github.com/jinzhu/gorm/dialects/sqlite"
    )

    type Pet struct {
      Name string
      Age int
    }

    type User struct {
      gorm.Model
      Name string
      Age int
    }

    func main() {
      
      fmt.Println("Hello, playground")
      db, err := gorm.Open("mysql", "test:test@tcp(192.168.42.10:3306)/test?charset=utf8&parseTime=True&loc=Local")

      if err!=nil {
        fmt.Println(err)
        panic(err)
      }

      // 自动迁移模式
      db.AutoMigrate(&Pet{})
      db.AutoMigrate(&User{})

      defer db.Close()

    }


增删改查
---------------

.. code:: go

    package main

    import (
      "fmt"
      "github.com/jinzhu/gorm"
      _ "github.com/go-sql-driver/mysql"
      // _ "github.com/jinzhu/gorm/dialects/sqlite"
    )

    type Pet struct {
      Name string
      Age int
    }

    type User struct {
      gorm.Model
      Name string
      Age int
    }

    func main() {
      
      fmt.Println("Hello, playground")
      db, err := gorm.Open("mysql", 
            "test:test@tcp(192.168.42.10:3306)/test?charset=utf8&parseTime=True&loc=Local")

      if err!=nil {
        fmt.Println(err)
        panic(err)
      }

      // 自动迁移模式
      db.AutoMigrate(&Pet{})
      db.AutoMigrate(&User{})

      // 添加用户
      db.Create(&User{Name: "张三", Age: 18})
      db.Create(&User{Name: "李四", Age: 25})
      db.Create(&User{Name: "王五", Age: 40})
      db.Create(&User{Name: "王八", Age: 7})
      db.Create(&User{Name: "王四", Age: 9})
      
      // 查询
      var user User
      // 查询 表里第一条数量
      db.First(&user)
      fmt.Println(user)

      // 查询 所有
      var users []User
      db.Find(&users)
      fmt.Println(users)
      
      // 查询 age <= 18 
      db.Where("age <= ?", 18).Find(&users)
      fmt.Println(users)

      // 更新 age <= 18 的 age = 20
      db.Model(&User{}).Where("age <= ?", 18).Update("age", 10)

      // 删除 age <= 18 的
      db.Where("age <= ?", 18).Delete(&User{})

      // 物理删除
      db.Unscoped().Where("age <= ?", 18).Delete(&User{})

      // 删除全部
      db.Delete(&User{})

      defer db.Close()

    }
