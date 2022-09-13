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
		2. 만약에 개발자가 해당 View를 커스텀하기위한다면 이를 사용해야한다
		3. 코드 
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
		```Swift
		mapView.mapType = .basic // NMFMapView는 보여주는 type을 지정하여 지도를 표현해줄 수 있다, NMFNaverMapView에는 없음
		mapView.mapType = .hybrid
		mapView.mapType = .navi
		mapView.mapType = .none
		mapView.mapType = .satellite
		mapView.mapType = .terrain
		```
				
	2. NMFNaverMapView
		1. NMFNaverMapView는 NMFMapView와 동일하지만 해당 지도를 다룰 수 있는 몇가지 기능이 추가되어진다
		2. 허나 해당 View는 기존에 해당 객체에 제공되어지는 인터페이스만을 사용하기에 커스텀할 수 없다는 단점이 존재한다

# ReactorKitTutorial
## 라이브러리
* ReactorKit

	-> ReactorKit은 기본적으로 Action을 보내면 이를 mutate에서 Mutation으로 변경하고 이 Mutataion을 다시 reduce를 만나 State으로 변경되어 View에 뿌려주는 방식이다
	1. ViewInput -> Action 
	```Swift
	func bind(reactor: FruitReactor) {
        // Input
        appleButton.rx.tap.map { FruitReactor.Action.apple }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        bananaButton.rx.tap.map { FruitReactor.Action.banana }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        grapeButton.rx.tap.map { FruitReactor.Action.grapes }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        // Output
        reactor.state.map{ $0.fruitName }
            .distinctUntilChanged()
            .map{ $0 }
            .subscribe(onNext: { val in
                self.selectedLabel.text = val
            })
            .disposed(by: disposeBag)
        
        reactor.state.map{ $0.isLoading }
            .distinctUntilChanged()
            .map{ $0 }
            .subscribe(onNext: { val in
                if val == true {
                    self.selectedLabel.text = "로딩중입니다"
                }
            })
            .disposed(by: disposeBag)
    }
	```
	2. mutate -> Mutation 
	3. reduce -> State
	```Swift
	func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .changeLabelApple:
            state.fruitName = "사과"
        case .changeLabelBanana:
            state.fruitName = "바나나"
        case .changeLabelGrapes:
            state.fruitName = "포도"
        case .setLoading(let val):
            state.isLoading = val
        }
        
        return state
    	}
        ```
	* 여기서 reduce함수는 각각의 Action에 따라 반환된 Mutation들을 새로운 State로 반환해주는 함수인데 이때 이 함수의 인자로 이전 상태값인 state와 해당 mutation을 인자로 받아온다
	
## Unit Test 맛보기
```Swift 
override func setUpWithError() throws {
    	try super.setUpWithError()
        sut = BullsEyeGame()
    }

    override func tearDownWithError() throws {
	sut = nil
	try super.tearDownWithError()
    }
    
    func testExample() throws {
        
    }

    func testPerformanceExample() throws {
        measure {
            
        }
    }
```
* Unit Test를 추가하면 기본적으로 setUpWithError, tearDownWithError, testExample, testPerformanceExample가 생성 
	1. setUpWithError() -> 테스트 메소드가 실행되기 전 모든 상태를 reset합니다 (초기화 코드)
	2. tearDownWithError() -> 테스트 동작이 끝난 후 모든 상태를 clean up합니다 (해체 코드)
	3. testExample() -> 테스트해볼 수 있는 기본적으로 제공해주는 함수, 내가 원하는 test함수를 생성하여 사용해도 됨
	4. testPerformanceExample() -> 테스트 성능을 확인해볼 수 있는 
	
```Swift
var sut: BullsEyeGame!
```
* 나는 테스트를 원하는 객체를 정의할 것이고 이 sut를 이용하여 BullysEyeGame객체가 가지고있는 코드를 이용해 테스트코드를 작성해보자

```Swift
func testScoreIsComputedWhenGuessIsHigherThanTarget() {
      // given
    let guess = sut.targetValue - 5
    
    // when
    sut.check(guess: guess)
    
    // then
    XCTAssertEqual(sut.scoreRound, 95, "Score computed from guess is wrong")
  }
```
* 테스트를 하기위한 함수의 이름은 test를 시작으로 정의한다 
* XCTAssertEqual를 이용하여 추측한 점수가 95인지 아닌지를 판별하여 테스트코드가 성공인지 실패인지를 

### 비동기 테스트해보기 
```Swift 
func testApiCallCompletes() throws {
  // given
  let urlString = "http://www.randomnumberapi.com/test"
  let url = URL(string: urlString)!
  let promise = expectation(description: "Completion handler invoked")
  var statusCode: Int?
  var responseError: Error?

  // when
  let dataTask = sut.dataTask(with: url) { _, response, error in
    statusCode = (response as? HTTPURLResponse)?.statusCode
    responseError = error
    promise.fulfill()
  }
  dataTask.resume()
  wait(for: [promise], timeout: 5)

  // then
  XCTAssertNil(responseError)
  XCTAssertEqual(statusCode, 200)
}
```
* expectation(description:)는 일어날 것으로 예상되는 것을 설명
* wait(for:, timeout:) 모든 기대치가 충족되거나 간격이 끝날때까지 테스트를 계속 실행, 예상될것으로 충족될것을 timeout에 정의된 시간까지 대기하는것 
* promise.fulfill() 이 코드가 앞서 예상했던 expectation을 충족됨을 플래그하는 코드
* 만약에 XCTAssertNil와 XCTAssertEqual이 존재하지않는다면 비동기인 코드에서 URL의 옳고그름과 상관없이 wait로 인해 timeout시간만큼 기다려야하는 단점이 존재 
* 위 코드를 사용함으로써 URL이 옳지않을시 XCTAssertEqual(statusCode, 200)에서 걸리기때문에 필요치않은 시간을 기다릴 필요없다

```Swift
let networkMonitor = NetworkMonitor.shared
try XCTSkipUnless(networkMonitor.isReachable,
                      "Network connectivity needed for this test.") 
```
* XCTSkipUnless(_:_:)는 네트워크에 연결할 수 없는 경우 테스트를 건너뜁니다, 애초에 네트워크가 연결되있지않으면 알아서 실패되겠지만 연결이 안되었는데 테스트를 하는 자체를 막을 수 있음

## FloatingPanel 
* Connect 개발을 하던 와중에 터치한 오버레이에 따라 다른 bottomView를 띄어줘야했고 이를 위해 FloatingPanel이라는 라이브러리를 사용하였다
# 기본 사용법
```Swift
private lazy var floatingPanelVC = FloatingPanelController()
private func showFloatingPanel(contentViewController: UIViewController, _ floatingPanelVC: FloatingPanelController) {
        guard let contentViewController = contentViewController as? MapFloatingPanelViewController else { return }
        let layout = MapFloatingPanelLayout(floatingType: contentViewController.floatingType)
        floatingPanelVC.layout = layout
        floatingPanelVC.delegate = self
        floatingPanelVC.addPanel(toParent: self)
        floatingPanelVC.set(contentViewController: contentViewController)
        floatingPanelVC.show()
    }
```
* FloatingPanelController 객체를 만들어 내가 보여주길 원하는 화면을 contentViewController에 집어넣어 보여주는 형식이다 

```Swift
func floatingPanelDidChangeState(_ fpc: FloatingPanelController) {
        if fpc.state == .hidden {
            floatingPanelVC.removePanelFromParent(animated: true)
        }
    }

class MapFloatingPanelLayout: FloatingPanelLayout {
    
    init(floatingType: FloatingType) { // FloatingType에 따라 다른 initialState를 갖게 함
        switch floatingType {
            case .who, .study:
                initialState = .half
            case .searchResult:
                initialState = .tip
        }
    }
    
    var position: FloatingPanelPosition {
        return .bottom
    }
    
    let initialState: FloatingPanelState
    
    var anchors: [FloatingPanelState : FloatingPanelLayoutAnchoring] {
        return [
                    .full: FloatingPanelLayoutAnchor(fractionalInset: 1, edge: .bottom, referenceGuide: .safeArea),
                    .half: FloatingPanelLayoutAnchor(fractionalInset: 0.48, edge: .bottom, referenceGuide: .safeArea),
                    .tip: FloatingPanelLayoutAnchor(fractionalInset: 0.3, edge: .bottom, referenceGuide: .safeArea), // tabbar에 가려져서 이에 맞춘 크기가 20이 적당하다생각
                    .hidden: FloatingPanelLayoutAnchor(absoluteInset: 20, edge: .bottom, referenceGuide: .safeArea)
                ]
    }
}
```
* FloatingPanel에 대한 delegate함수를 이용해 .hidden 상태값이 될 경우 사라지게 하였다 
* FloatingPanel을 이용하여 layout을 지정하여 좀 더 유연하게 코드도 가능한데 
  위 코드처럼 FloatingType에 따라서 다른 초기상태값을 집어넣어 보여주게 하였다 

* FloatingPanel의 상태값은 anchors를 이용하여 fractionalInset 혹은 absoluteInset을 이용하여 원하는 크기를 조절해줄 수 있다

###UITableViewDiffableDataSource 
##기본사용법
```Swift
var dataSource: UITableViewDiffableDataSource<Section, Feed>!
var snapShot: NSDiffableDataSourceSnapshot<Section, Feed>!
	dataSource = UITableViewDiffableDataSource<Section, Feed>(tableView: tableView, cellProvider: { (tableView: UITableView, indexPath: IndexPath, identifier: Feed) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: RootTableViewCell.identifier, for: indexPath) as? RootTableViewCell ?? RootTableViewCell()
            print("identifier = \(identifier)")
            cell.configureUI(with: self.feedArray[indexPath.row].content)
            return cell
        })
        
        snapShot = NSDiffableDataSourceSnapshot<Section, Feed>()
        snapShot.appendSections([.feed])
        snapShot.appendItems(feedArray, toSection: .feed)
        
        self.dataSource.apply(snapShot)
```
* 일반적인 방법으로 UITableView나 UICollectionView를 구성할때는 delegate와 dataSource를 이용하여 구성하였다 

## reloadData vs performBatchUpdates, beginUpdates, endUpdates, DiffableDataSource
* 이때 UITableView나 UICollectionView를 구성하는 부분을 건들때 delete나 insert 등등에 해당하는 메소드를 사용하게 되는데 
  이를 위해 beginUpdates, endUpdates, performBatch와 같음을 이용하며 구성해줘야하는 복잡함이 있다 
* 위와 같은 단점을 보완한 부분이 바로 DiffableDataSource이다, apply메소드 하나만으로 위 과정을 이행가능하다 
* 또한 DiffableDataSource를 이용해 UITableView나 UICollectionView를 구성하는 장점은 애니메이션 효과이다, reloadData를 사용하기엔 딱딱한 느낌이 있어 사용자 경험이 적다는 단점이 있다 
* 사실 애니메이션 효과만 본다면 performBatchUpdates나 beginUpdates, endUpdaes를 사용해줄 수 있다, 하지만 DiffableDataSource는 apply메소드만 사용해주면 간단히 구성이 가능하고 IndexPath로 접근하여 의도치않은 오류를 범할 위험이 없고 dataSource의 itemIdentifier를 이용하여 좀 더 안전하게 접근가능하다는 장점이 있다 

###RxDelegateProxyPR
##RxDelegateProxy
* Connect 앱 개발을 하게되면서 RxCocoa를 이용하여 UI에서 받아온 데이터들을 ViewModel에 넘겨주는 작업을 해오다 UI의 delegate로 받아온 데이터들에 대해서도 Rx를 이용해야하는 상황이 생겼는데 RxCocoa에서 제공해주지않은 부분들은 해당 delegate메소드안에서 Observable.just를 이용해야만 하는 줄 알았다 
* 그러다 RxDelegateProxy를 이용하면 좀더 편리하게 코드상 이쁘게 작업할 수 있다는 점을 알게 되었다 
```Swift
extension Reactive where Base: UITextField {
    var delegate: DelegateProxy<UITextField, UITextFieldDelegate> {
        return RxTextFieldDelegateProxy.proxy(for: self.base)
    }
    
    var shouldChangeCharactersIn: Observable<Bool> {
        return delegate.methodInvoked(#selector(UITextFieldDelegate.textField(_:shouldChangeCharactersIn:replacementString:))).map { parameters in
            return parameters[1] as? Bool ?? false
        }
    }
}

class RxTextFieldDelegateProxy: DelegateProxy<UITextField, UITextFieldDelegate>, DelegateProxyType, UITextFieldDelegate {
    static func registerKnownImplementations() {
        self.register { textField -> RxTextFieldDelegateProxy in
            return RxTextFieldDelegateProxy(parentObject: textField, delegateProxy: self)
        }
    }
    
    static func currentDelegate(for object: UITextField) -> UITextFieldDelegate? {
        return object.delegate
    }
    
    static func setCurrentDelegate(_ delegate: UITextFieldDelegate?, to object: UITextField) {
        object.delegate = delegate
    }
}

textField.rx.shouldChangeCharactersIn.asObservable().subscribe(onNext: { isChange in
            print("dsfsadf = \(isChange)")
        }).disposed(by: disposeBag)
```
* DelegateProxyType 프로토콜에 대한 메소드를 위처럼 정의해준 이후 extension을 이용해 원하는 Observable을 반환해주면 된다 
* 이후 기존에 RxCocoa를 사용했던 것처럼 rx로 접근하여 사용해주면 된다

##adjustContentInset
* UIScrollView에는 기본적으로 contentInset를 조절할 수 있다, 이는 해당 스크롤뷰의 padding를 조절하는것과 비슷한 효과를 보인다. 
* 허나 UIScrollView를 사용하다보면은 해당 앵커를 부모 뷰의 top, left, right, bottom에 걸었는데도 불구하고 safeArea에 맞춰 콘텐츠가 보이는점을 확인했을 것이다 
* 그 이유는 해당 UIScrollView의 adjustContentInset이라는 것이 앞서 말한 contentInset + systemInset의 결과값이기 때문인데 우리가 contentInset을 따로 건들어주지않아도 systemInset이 해당 Inset을 조절해준 것이다 
* 그리고 이 systemInset을 건들어줄 수 있는 것이 adjustContentInsetBehavior이다, adjustContentInset은 Read-only 프로퍼티이다

#StackView&ContainerView
## ContainerView 
* 우리는 기본적으로 하나의 콘텐츠를 담기위한 contentsViewController를 사용한다, 이외에 UINavigationController, UITabbarContoroller처럼 앞서 말한 contentsViewController를 담아 화면에 보여주기위한 containerViewController가 존재한다 

### addSubView vs addChild
* 보통 하나의 뷰 컨트롤러에는 단 하나의 루트뷰만을 가지고 이를 담당하게 된다, 그렇기에 addSubView는 해당 루트뷰에 서브뷰를 두어 관리하기위한 함수인것이다 

* 우리는 하나의 뷰 컨트롤러에서 다른 뷰 컨트롤러의 뷰를 관리하고싶을 수도 있을 것이다, 이때 아마 떠오르는 키워드가 containerViewController일 것이다 

* 즉 하나의 containerViewController의 역할을 하기위한 것을 하나두고 이 컨테이너 뷰 컨트롤러에 contentsViewController를 추가해주는 것이다, 그리고 이때 필요한 함수가 바로 addChild이다

```Swift
    self.addChild(childViewController)
    self.view.addSubview(childViewController.view)
    childViewController.view.frame = CGRect(x: 180, y: 180, width: 200, height: 200)
```
* 위 코드에서처럼 addChild를 이용해 childViewController를 containerViewController역할을 하고자하는 뷰 컨트롤러에 추가해주고 

* 이 childViewController의 루트뷰를 addSubView로 추가해주는것이다