//
//  Onbording.swift
//  Sneakers
//
//  Created by Yerkebulan Sharipov on 19.04.2022.
//

import UIKit
import SnapKit


class Onbording : UIPageViewController, UIPageViewControllerDelegate,UIPageViewControllerDataSource {
    
    var pages = [UIViewController]()
    let pageControl = UIPageControl()
    
    let blurEffectView : UIVisualEffectView = {
        let view = UIVisualEffectView()
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        let blueEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        view.effect = blueEffect
        return view
    }()
    
    lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 16
        view.distribution = .equalSpacing
        view.alignment = .center
        return view
    }()
    
    lazy var label1 : UILabel = {
        let label = UILabel()
        label.text = "Fast shipping"
        label.font = .systemFont(ofSize: 28, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    lazy var label2 : UILabel = {
        let label = UILabel()
        label.text = "Get all of your desired sneakers in one place."
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    lazy var button : ButtonFactory = {
        let button = ButtonFactory()
        button.configure(with: BottonViewModel(text: "Next", backgroundColor: Colors.basicColors.black))
        button.addTarget(self, action: #selector(nextButtonIsTapped), for: .touchUpInside )
        return button
    }()
    
    override func viewDidLoad() {
     super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        view.backgroundColor = .white
        initPages()
        setupHierarchy()
        setUI()
    }
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: navigationOrientation, options: options)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initPages(){
        let pagesView = [
        OnbordingImages(named: "1"),
        OnbordingImages(named: "2"),
        OnbordingImages(named: "3")
        ]
        let initialPage = 0
        
        pagesView.forEach { page in
            pages.append(page)
        }
        
        setViewControllers([pages[initialPage]], direction: .forward, animated: true, completion: nil)
        
        self.pageControl.frame = CGRect()
        self.pageControl.currentPageIndicatorTintColor = UIColor.white
        self.pageControl.pageIndicatorTintColor = Colors.basicColors.grayLight
        self.pageControl.numberOfPages = self.pages.count
        self.pageControl.currentPage = initialPage
        pageControl.addTarget(self, action: #selector(pageControlTapped), for: .valueChanged)
    }
    
    private func setupHierarchy(){
        [blurEffectView].forEach{
            view.addSubview($0)
        }
        [label1,label2].forEach {
            stackView.addArrangedSubview($0)
        }
        blurEffectView.contentView.addSubview(pageControl)
        blurEffectView.contentView.addSubview(stackView)
        blurEffectView.contentView.addSubview(button)
        
    }
    
    private func setUI(){
        blurEffectView.snp.makeConstraints{make in
            make.width.equalToSuperview()
            make.height.equalTo(288)
            make.bottom.equalToSuperview()
        }
        pageControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(32)
        }
        stackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(80)
        }
        button.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(358)
            make.height.equalTo(54)
            make.bottom.equalToSuperview().offset(-58)
        }
    }
    
    @objc private func pageControlTapped(_ sender: UIPageControl){
        setViewControllers([pages[sender.currentPage]], direction: .forward, animated: true, completion: nil)
    }
    
    @objc private func nextButtonIsTapped(){
        guard let currentView = viewControllers?.first else {return}
        guard let nextView = dataSource?.pageViewController(self, viewControllerAfter: currentView) else {return}
        
        setViewControllers([nextView], direction: .forward, animated: true, completion: nil)
        
        if let viewController = viewControllers?.first {
            if let viewControllerIndex = pages.firstIndex(of: viewController){
                pageControl.currentPage = viewControllerIndex
            }
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let viewControllerIndex = self.pages.firstIndex(of: viewController){
            if viewControllerIndex == 0 {
                return self.pages.last
            } else {
                return self.pages[viewControllerIndex - 1]
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let viewControllerIndex = self.pages.firstIndex(of: viewController){
            if viewControllerIndex < self.pages.count - 1 {
                return self.pages[viewControllerIndex + 1]
            } else {
                let vc = UINavigationController(rootViewController: Welcome())
                vc.modalPresentationStyle = .fullScreen
                navigationController?.present(vc, animated: true)
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if let viewContollers = pageViewController.viewControllers{
            if let viewControllerIndex = self.pages.firstIndex(of: viewContollers[0]){
                self.pageControl.currentPage = viewControllerIndex
            }
        }
    }
}


