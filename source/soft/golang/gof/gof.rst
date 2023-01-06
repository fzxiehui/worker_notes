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

    type ClothesShop struct {}

    func (cs *ClothesShop) OnShop() {
      fmt.Println("休闲的装扮")
    }

    type ClothesWork struct {}

    func (cw *ClothesWork) OnWork() {
      fmt.Println("工作的装扮")
    }

    func main() {
      //工作的时候
      cw := new(ClothesWork)
      cw.OnWork()

      //shopping的时候
      cs := new(ClothesShop)
      cs.OnShop()
    }


开闭原则
----------------

.. code-block:: golang
  :emphasize-lines: 5-8

  package main

  import "fmt"

  //抽象的银行业务员
  type AbstractBanker interface{
    DoBusi()	//抽象的处理业务接口
  }

  //存款的业务员
  type SaveBanker struct {
    //AbstractBanker
  }

  func (sb *SaveBanker) DoBusi() {
    fmt.Println("进行了存款")
  }

  //转账的业务员
  type TransferBanker struct {
    //AbstractBanker
  }

  func (tb *TransferBanker) DoBusi() {
    fmt.Println("进行了转账")
  }

  //支付的业务员
  type PayBanker struct {
    //AbstractBanker
  }

  func (pb *PayBanker) DoBusi() {
    fmt.Println("进行了支付")
  }


  func main() {
    //进行存款
    sb := &SaveBanker{}
    sb.DoBusi()

    //进行转账
    tb := &TransferBanker{}
    tb.DoBusi()
    
    //进行支付
    pb := &PayBanker{}
    pb.DoBusi()

  }
