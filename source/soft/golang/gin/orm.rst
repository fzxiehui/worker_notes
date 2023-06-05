ORM
==========

自动迁移模式
--------------------

.. note::

    快速部署 :ref:`MySql Docker<mysql>`

    更多参考 https://gorm.io/zh_CN/docs/index.html

.. code:: go

    // TODO

    // 取出最后创建的10个用户
    var users []User
    // Limit 指定要查询的最大记录数
    db.Order("created_at desc").Limit(10).Find(&users)

    // Offset 指定要跳过的记录数
    db.Offset(10).Find(&users)

    // Offset 需要配合 Limit 使用
    db.Offset(10).Limit(10).Find(&users)
    db.Offset(10).Limit(10).Order("created_at desc").Find(&users)

    // Count 统计记录数
    var count int64
    db.Model(&User{}).Count(&count)

    // Select 指定要查询的字段
    db.Select("name, age").Find(&users)

    // Where 指定查询条件
    db.Where("name = ?", "靓仔").Find(&users)
    // 统计叫靓仔的人数
    db.Model(&User{}).Where("name = ?", "靓仔").Count(&count)

    // 分页
    var users []User
    var page int = 1
    var pageSize int = 10
    db.Offset((page - 1) * pageSize).Limit(pageSize).Find(&users)

    // 分页查找最后创建的10个用户
    var users []User
    var page int = 1
    var pageSize int = 10
    db.Order("created_at desc").Offset((page - 1) * pageSize).Limit(pageSize).Find(&users)


    // 分页查找 name 为 靓仔 的用户
    var users []User
    var page int = 1
    var pageSize int = 10
    db.Where("name = ?", "靓仔").Offset((page - 1) * pageSize).Limit(pageSize).Find(&users)

    // 分页查找 name 为 靓仔 的用户，按照创建时间倒序
    var users []User
    var page int = 1
    var pageSize int = 10
    db.Where("name = ?", "靓仔").Order("created_at desc")
      .Offset((page - 1) * pageSize).Limit(pageSize).Find(&users)

    // 查找 今天 创建的用户
    var users []User
    db.Where("created_at >= ?", time.Now().Format("2006-01-02")).Find(&users)

    // 查找 今天 创建的用户，按照创建时间倒序
    var users []User
    db.Where("created_at >= ?", time.Now().Format("2006-01-02")).Order("created_at desc").Find(&users)

    // 查找 今天 创建的用户，按照创建时间倒序，分页
    var users []User
    var page int = 1
    var pageSize int = 10
    db.Where("created_at >= ?", time.Now().Format("2006-01-02"))
      .Order("created_at desc").Offset((page - 1) * pageSize).Limit(pageSize).Find(&users)


    // 查找 开始时间到结束时间 创建的用户
    var users []User
    var startTime string = "2020-01-01"
    var endTime string = "2020-01-02"
    db.Where("created_at >= ? AND created_at <= ?", startTime, endTime).Find(&users)


    // 查找 开始时间到结束时间 创建的用户, 精确到秒
    var users []User
    var startTime string = "2020-01-01 00:00:00"
    var endTime string = "2020-01-02 00:00:00"
    db.Where("created_at >= ? AND created_at <= ?", startTime, endTime).Find(&users)


    // 分页查找 开始时间到结束时间 创建的用户, 精确到秒
    var users []User
    var page int = 1
    var pageSize int = 10
    var startTime string = "2020-01-01 00:00:00"
    var endTime string = "2020-01-02 00:00:00"
    db.Where("created_at >= ? AND created_at <= ?", startTime, endTime)
      .Order("created_at desc").Offset((page - 1) * pageSize).Limit(pageSize).Find(&users)

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
