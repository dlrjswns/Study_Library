# Project 1
## 라이브러리 
* SnapKit
	1. Offset vs inset
	2. makeConstraints 
		-> 이를 통해서 기본적인 SnapKit을 이용하여 해당 뷰에 대한 오토레이아웃을 걸어줄 수 있다 
	3. updateConstraints
		-> 이는 기존에 걸어둔 오토레이아웃에서 변경하고자 할때 사용한다 
		-> 주의해야할점으로는 다른 뷰에 대한 오토레이아웃을 변경하는것은 불가하고 상수를 가지고 변경한 부분에 대해서 
		   그 값을 변경해주는데 사용한다 
	4. remakeConstraints
		-> updateConstraints에서 할 수 없었던 상대 뷰에 대한 오토레이아웃 변경을 가능케한다 
		-> 주의해야할점은 원하는 부분에 대한 오토레이아웃만을 변경하는 updateConstraints와는 달리 다시 오토레이웃을 하기에 이에 대해 조심하자!
* RxSwift
* Alamofire