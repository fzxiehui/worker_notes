Go 安装
=======

.. warning::
  
  以下示例系统环境为 Ubuntu 1604

.. note::

  参考地址:
  ``https://www.digitalocean.com/community/tutorials/how-to-install-go-1-6-on-ubuntu-16-04``

  下载地址:
  ``https://go.dev/dl/``

下载
------

.. code:: shell

   cd ~
   wget https://go.dev/dl/go1.19.1.linux-amd64.tar.gz


安装
----

.. code:: shell

   tar xvf go1.19.1.linux-amd64.tar.gz
   sudo chown -R root:root ./go
   sudo mv go /usr/local

设置环境
--------

.. code:: shell

   sudo vi ~/.profile

   # 文件末尾添加
   export GOPATH=$HOME/work
   export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin

   # 使环境生效
   source ~/.profile

测试安装
--------

 #. 使用 ``mkdir -p work/src/github.com/user/hello`` 创建工作目录,其中
    ``user`` 可以替换为 ``github`` 用户名.

 #. 使用 ``vi ~/work/src/github.com/user/hello/hello.go`` 创建
    ``hello.go`` 文件, 并粘贴以下代码.

    .. code:: go

      package main

      import "fmt"

      func main() {
        fmt.Printf("hello, world\n")
      }

 #. 使用 ``go install`` 编译安装 ``hello``, 使用 ``hello`` 运行, 
    使用 ``which hello`` 查看执行路径.
