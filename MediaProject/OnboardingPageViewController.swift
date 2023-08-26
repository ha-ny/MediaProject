//
//  OnboardingPageViewController.swift
//  MediaProject
//
//  Created by 김하은 on 2023/08/27.
//

import UIKit

class OnboardingPageViewController: UIPageViewController {
    
    let list: [UIViewController] = [
        IntroViewController(description: "첫번째 인트로"),
        IntroViewController(description: "두번째 인트로"),
        IntroViewController(description: "세번째 인트로"),
    ]
    
    let startButton = {
        let view = UIButton()
        view.setTitle("시작하기", for: .normal)
        view.backgroundColor = .darkGray
        view.layer.cornerRadius = 8
        return view
    }()

    // UIPageViewController -> override init( 자동으로 transitionStyle....이 뜬다
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        delegate = self
        dataSource = self
        
        view.addSubview(startButton)
        startButton.isHidden = true
        
        startButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(80)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        startButton.addTarget(self, action: #selector(startButtonClicked), for: .touchUpInside)
        setViewControllers([list[0]], direction: .forward, animated: true)
    }
    
    @objc func startButtonClicked() {

        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        let vc = MediaListViewController()
        
        UserDefaults.standard.set(true, forKey: "isIntro")
        
        sceneDelegate?.window?.rootViewController = vc
        sceneDelegate?.window?.makeKeyAndVisible()
    }
}

extension OnboardingPageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource{
    
    //이전 페이지 미리 로드 -> 스와이프 동작 시 매끄러운 전환
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {

        //현재 페이지 인덱스 찾기
        guard let index = list.firstIndex(of: viewController) else { return nil}
        
        //이전 페이지 반환
        let page = index - 1
        return page > -1 ? list[page] : nil
    }
    
    //이후 페이지 미리 로드 -> 스와이프 동작 시 매끄러운 전환
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        //현재 페이지 인덱스 찾기
        guard let index = list.firstIndex(of: viewController) else { return nil}
        
        let page = index + 1
        //다음 페이지 반환
        return page < list.count ? list[page] : nil
    }
    
    //pageViewController 하단에 ... 넣어줌 presentationCount, presentationIndex
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return list.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let first = viewControllers?.first, let index = list.firstIndex(of: first) else { return 0 }
        return index
    }
    
    
    //페이지 이동할때마다 호출
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {

        if completed{
            if let last = viewControllers?.first{
                if list.firstIndex(of:last) == list.count - 1{
                    startButton.isHidden = false
                }else{
                    startButton.isHidden = true
                }
            }
        }
    }
}
