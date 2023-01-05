GOF设计原则 
==============

设计原则
----------------

#. 单一职责原则：一个类对外只提供一种功能
#. 开闭原则：增加功能时去增加代码而不是修改代码
#. 依赖倒转原则：模块与模块依赖抽象而不是具体实现
#. 合成复用原则：通过组合来实现父类方法
#. 迪米特法则：依赖第三方来实现解耦


单一职责原则
----------------

.. code:: golang
     
    package main

    import "fmt"

    type ClothesShop struct{}

    func (c *ClothesShop) onShop() {
      fmt.Println("onShop")
    }

    type ClothesWork struct{}

    func (c *ClothesWork) onWork() {
      fmt.Println("onWork")
    }

    func main() {
      fmt.Println("shop")
      shop := &ClothesShop{}
      shop.onShop()

      fmt.Println("work")
      work := &ClothesWork{}
      work.onWork()
    }

