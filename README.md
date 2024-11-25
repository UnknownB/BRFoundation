# BRFoundation

- 此 SDK 的目的是為 Foundation 框架添加補充功能

## Extension (擴展)

- 擴展的 function 會放在 `br` 命名域，降低命名衝突
- 使用自動完成時，能清晰的區分自訂與系統

``` swift
let array = [1,2,1]
let newArray = array.br.replacingAll(where: { $0 == 1 }, with: 2)
print(newArray) // [2,2,2]
```

- 開心的話也能使用自己喜歡的命名域

``` swift
// 把這段程式碼加入專案中，name 換成喜歡的就行
public extension BRWrapperProtocol {
    var name: BRWrapper<Self> { BRWrapper(self) }
    static var name: BRWrapper<Self>.Type { BRWrapper<Self>.self }
}
```
