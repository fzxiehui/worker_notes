Go JWT
=====================

.. code:: go

    package main

    import (
      "fmt"
      "github.com/dgrijalva/jwt-go"
      "time"
    )

    type CustomClaims struct {

      Username string `json:"username"`
      Password string `json:"password"`
      jwt.StandardClaims
    }

    func main() {
      // rs256

      c := CustomClaims{
        Username : "test",
        Password : "test",
        StandardClaims: jwt.StandardClaims{
          NotBefore: time.Now().Unix(),
          ExpiresAt: time.Now().Add(time.Hour * 24).Unix(),
          Issuer:    "test",
        },
      }

      t := jwt.NewWithClaims(jwt.SigningMethodHS256, c)
      fmt.Println(t)
      // &{ 0xc000012120 map[alg:HS256 typ:JWT] {test test { 1663396790  0 test 1663310390 }}  false}

      // 加密
      token, err := t.SignedString([]byte("test"))
      if err != nil {
        fmt.Println(err)
      }
      fmt.Println(token)

      // 解密
      tokenClaims, err := jwt.ParseWithClaims(token, &CustomClaims{}, func(token *jwt.Token) (interface{}, error) {
        return []byte("test"), nil
      })
      if err != nil {
        fmt.Println(err)
      }
      fmt.Println(tokenClaims.Claims.(*CustomClaims))
      fmt.Println(tokenClaims.Claims.(*CustomClaims).Username)

    }
