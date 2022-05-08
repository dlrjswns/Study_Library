# Project 1
## 라이브러리 
* SnapKit
	1. Offset vs inset
	2. makeConstraints 
		1. 이를 통해서 기본적인 SnapKit을 이용하여 해당 뷰에 대한 오토레이아웃을 걸어줄 수 있다 
	3. updateConstraints
		1. 이는 기존에 걸어둔 오토레이아웃에서 변경하고자 할때 사용한다 
		2. 주의해야할점으로는 다른 뷰에 대한 오토레이아웃을 변경하는것은 불가하고 상수를 가지고 변경한 부분에 대해서 
		   그 값을 변경해주는데 사용한다 
	4. remakeConstraints
		1. updateConstraints에서 할 수 없었던 상대 뷰에 대한 오토레이아웃 변경을 가능케한다 
		2. 주의해야할점은 원하는 부분에 대한 오토레이아웃만을 변경하는 updateConstraints와는 달리 다시 오토레이웃을 하기에 이에 대해 조심하자!
* RxSwift
* Alamofire

# BeerShop
## 라이브러리 
* RxSwift 
	1. withUnretained
		1. 코드 
		```Swift
		viewModel.beerModelOutput.withUnretained(self).emit(onNext: { owner, beers in
            		owner.configureUI(with: beers)
        	}).disposed(by: disposeBag)
		```
		2. 코드 설명 
			1. 기존에 MVVM패턴에서 ViewModel을 통해 데이터를 View에 바인딩시킬때 우린 해당 인스턴스의 멤버변수를 사용하고자할때 [weak self]를 자주 사용한다 
			2. 이때 코드가 다소 난잡해보일 수 있는데 RxSwift에서는 좀 더 간결한 문장을 위해 withUnretained라는것을 제공하여 깔끔하게 보여줄 수 있다
	2. distinctUntilChanged
		1. 코드 
		```Swift
		searchBar.rx.text.orEmpty
          	.debounce(.seconds(1), scheduler: ConcurrentDispatchQueueScheduler.init(qos: .default))
               	.distinctUntilChanged()
		.bind(to: viewModel.searchIdInput)
           	.disposed(by: disposeBag)
		```
		2. 코드 설명 
			1. 앞서 SearchBar를 통해 받아온 텍스트를 이용해 해당 데이터를 받아오는 코드인데 이때 동일한 텍스트일때도 데이터를 받아오는 불필요함음을 없애고자 distinctUntilChanged를 사용한다 
			2. debounce 또한 SearchBar에 입력한 모든 데이터들에 대한 데이터를 받아오는것은 불필요하기에 사용한 방법이다 
			3. debounce vs throttle 
				1. debounce는 이벤트가 빈번히 발생할때 처음 또는 마지막으로 발생한 이벤트만을 호출하는 방법 
				2. throttle은 이벤트가 실행중일때 발생한 다른 이벤트들은 무시하는 방법
			
	3. filter 
		1. 코드
		```Swift
		let searchBeerWithId = searchIdChanged
                .filter{ $0.count != 0 }
                .do(onNext: { _ in
               	    loadingCheck.onNext(true)
                })
                .flatMapLatest(usecase.fetchOneBeer(id:))
                .do(onNext: { _ in
                    loadingCheck.onNext(false)
                })
		```
		2. 코드 설명 
			1. 초기에 SearchBar를 클릭하고 아무런 텍스트를 작성하지않아도 데이터를 받아오는 코드가 발생하는 불상사를 막기위하여 filter를 통해서 빈 문자열일 경우에는 데이터를 가져오지않게 하였다
	4. guard case 
		1. 코드 
		```Swift
		let searchResult = searchBeerWithId.map { result -> [Beer]? in
            		guard case .success(let beers) = result else {
                	return nil
            	}
            	emptyCheck.onNext(false)
            	return beers
        	}
		```
		2. 코드 설명 
			1. 보통 Repository를 이용하여 Entity를 받아올때 성공 혹은 실패에 대한 여부를 알기위하여 Result를 이용하여 값을 받아오는데 switch문을 통해 일일이 나눠줄 수 있다 
			2. 하지만 guard case문을 이용하여 좀더 유연하게 값을 처리할 수 있기에 사용해보았다



# NMPR
## 라이브러리
* Naver Maps
	1. NMFMapView
		1. NMFMapView는 단순히 네이버에서 제공하는 지도만은 보기위한 객체
		2. 코드 
		```Swift
		let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: 37.5666102, lng: 126.9783881)) // 첫 지도 위치초기화
		cameraUpdate.reason = 3
		cameraUpdate.animation = .fly
		cameraUpdate.animationDuration = 2
		mapView.moveCamera(cameraUpdate, completion: { (isCancelled) in // 지정해준 좌표로 카메라 이동, 성공 & 실패 여부 확인
		    if isCancelled {
			print("카메라 이동 취소")
		    } else {
			print("카메라 이동 성공")
		    }
		})
		```
		```Swift
		let marker = NMFMarker(position: NMGLatLng(lat: 37.5670135, lng: 126.9783740)) // NMFMarker에 대한 좌표를 초기화
		marker.touchHandler = { (overlay) in // NMFMarker를 클릭했을때의 액션 코드
		    print("마커 클릭됨")
		    return true
		}
		marker.mapView = mapView; // 지정해준 NMFMarker를 NJFMapView에 찍어주는 코드
		```
		
	2. NMFNaverMapView
		1. NMFNaverMapView는 NMFMapView와 동일하지만 해당 지도를 다룰 수 있는 몇가지 기능이 추가되어진다
