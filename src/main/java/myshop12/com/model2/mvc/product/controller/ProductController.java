package myshop12.com.model2.mvc.product.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import myshop12.com.model2.mvc.common.domain.Page;
import myshop12.com.model2.mvc.common.domain.Search;
import myshop12.com.model2.mvc.common.util.CookieUtil;
import myshop12.com.model2.mvc.product.domain.Product;
import myshop12.com.model2.mvc.product.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.File;
import java.net.URL;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.*;
import java.util.concurrent.atomic.AtomicReference;

@Controller
@RequestMapping("/product/*")
public class ProductController {
    ///Field
    private ProductService productService;
    private static final String RESET = "\u001B[0m";
    private static final String RED = "\u001B[91m";
    private static final String ORANGE = "\u001B[38;5;208m";
    private static final String YELLOW = "\u001B[93m";
    private static final String GREEN = "\u001B[92m";
    private static final String BLUE = "\u001B[94m";

    @Autowired
    public void setProductService(@Qualifier("productServiceImpl") ProductService productService) {
        this.productService = productService;
    }

    @Value("${pageUnit}")
    //@Value("#{commonProperties['pageUnit'] ?: 3}")
    int pageUnit;

    @Value("${pageSize}")
    //@Value("#{commonProperties['pageSize'] ?: 2}")
    int pageSize;

    ///Constructor
    public ProductController() {
        System.out.println(YELLOW);
        System.out.println("생성자 :: " + this.getClass());
        System.out.println(RESET);
    }

    ///Method
    @RequestMapping("/addProduct")
    public String addProduct(@RequestParam("fileList") List<MultipartFile> fileList,
                             @ModelAttribute("product") Product product,
                             RedirectAttributes redirectAttributes,
                             Model model) throws Exception {
        System.out.println("/addProduct이 시작됩니다..");

        if (fileList.isEmpty()) {
            redirectAttributes.addFlashAttribute("message", "Please select a file to upload");
            return "redirect:/product/addProductView.jsp";
        }
//        String fileName = getProductFileName(file);
        List<String> fileNameList = new ArrayList<>();

        for(MultipartFile file : fileList){
            fileNameList.add(getProductFileName(file));
        }
        System.out.println("fileNameList :: "+fileNameList);

        String fileNamesStr = String.join(",", fileNameList);
        System.out.println(fileNamesStr);

        //원래 이렇게 a넣으면 안될거 같은데..?
        product.setProTranCode("a");
        product.setFileName(fileNamesStr);
        //Business Logic
        System.out.println("당연히 prodNo 0이다. product :: " + product);
        productService.addProduct(product);
        //Model 과 View 연결 - 이 부분은 @RequestParam + Model 전략을 쓰면 해야됨
        //model.addAttribute("product", product);
        model.addAttribute("fileNameList",fileNameList);


        redirectAttributes.addFlashAttribute("message", "You successfully uploaded '" + fileNamesStr + "' and added product information.");
        System.out.println("/addProduct이 끝났습니다..");
        System.out.println("forward:/product/addProductView.jsp" + "합니다.");
        return "forward:/product/getProduct.jsp";
    }//end of addProduct
    @RequestMapping("/getProduct")
    public String getProduct(HttpServletRequest request,
                             HttpServletResponse response,
                             @ModelAttribute("product") Product product,
                             @RequestParam("menu") String menu,
                             Model model) throws Exception {

        System.out.println("/getProduct이 시작됩니다..");
        //Business Logic
        product = productService.getProduct(product.getProdNo());
        //Model 과 View 연결
        // 메서드내에서 참조변수에 도메인을 재할당해버린 경우에는
        // ModelAttribute가 인식을 하지 못한다.
        List<String> fileNameList = new ArrayList<>();
        if(product.getFileName() != null){
            fileNameList = Arrays.asList(product.getFileName().split(","));//1234,1234,1,
        }
        System.out.println(fileNameList.toString());

        model.addAttribute("fileNameList", fileNameList);
        model.addAttribute("menu", menu);
        model.addAttribute("product", product);

        CookieUtil.addValue(request, response, "history", String.valueOf(product.getProdNo()));

        System.out.println("/getProduct이 끝났습니다..");

        if (menu.equals("manage")) {
            System.out.println("forward:/updateProduct.jsp" + "합니다.");
            return "forward:/product/updateProduct.jsp";
        } else {//search, ok
            return "forward:/product/getProduct.jsp";
        }//end of else
    }//end of getProduct

    //클라-searchBoundFirst,searchBoundEnd,currentPage,search,menu,products,page
    //Integer를 이렇게 등록했을때 String 값이 오면 에러가 난다. 하지만 Converter를 등록해줄 수 있다.
    @RequestMapping("/likeProduct")
    public String likeProduct(@ModelAttribute("search") Search search,
                              @RequestParam(value = "menu",required = false) String menu,
                              @RequestParam(value = "searchBoundFirst", required = false) Integer searchBoundFirst,
                              @RequestParam(value = "searchBoundEnd", required = false) Integer searchBoundEnd,
                              Model model,
                              HttpServletRequest request) throws Exception {

        //search,searchBoundFirst,End는 스스로 안에서 페이지 이동할때의 경우임.


        //@ModelAttribute("products") ArrayList<Product> products

        System.out.println("/likeProduct이 시작됩니다..");
        //바인딩 : 클라-searchBoundFirst, searchBoundEnd > search도메인

        if(searchBoundFirst == null || searchBoundEnd == null) {
            searchBoundFirst = 0;
            searchBoundEnd = 0;
        }
        //바인딩 : 클라-searchBoundFirst, searchBoundEnd > search도메인
        if (!(searchBoundFirst == 0) || !(searchBoundEnd == 0)) {
            search.setSearchBoundFirst(searchBoundFirst);
            search.setSearchBoundEnd(searchBoundEnd);
//                System.out.println("searchBound[0]"+searchBound[0]);
//                System.out.println("searchBound[1]"+searchBound[1]);
        }

        //바인딩 : 클라-currentPage > search도메인 > page도메인
        int currentPage = 1;
        //경로 1,2,3,4로 들어왔을경우
        if (search.getCurrentPage() != 0) {
            currentPage = search.getCurrentPage();
        }

        search.setCurrentPage(currentPage);//current의 default Value를 1로 설정했음.
        search.setPageSize(pageSize);

        //createLike에서 가져옴
        Map<String,Object> createLikeData = (Map<String, Object>)request.getAttribute("createLikeData");

        //menu,currentPage,products
        //true면 구매 가능하도록 만듬
        AtomicReference<String> pass = new AtomicReference<>("true");
        System.out.println("createLikeData");
        System.out.println(createLikeData);

        Optional<List<Product>> optionalProducts = Optional.ofNullable((List<Product>)(createLikeData.get("products")));
        System.out.println("optionalProducts");
        System.out.println(optionalProducts);

        optionalProducts.ifPresentOrElse(products->
                {
                    boolean condition = products.isEmpty()||products.stream().anyMatch(product -> product.getStockQuantity() == 0);
                    pass.set(condition ? "false" : "true");
                }, () -> pass.set("false"));

        model.addAttribute("pass",pass.get());


        int productsSize = optionalProducts.map(List::size).orElse(0);

        Page page = new Page(
                currentPage,
                productsSize,
                pageUnit,
                pageSize);

        System.out.println("ListProductAction ::" + page);
        System.out.println("products :: " + optionalProducts.orElseGet(ArrayList::new));

        //Model 과 View 연결
        model.addAttribute("totalCount", productsSize);
        model.addAttribute("products",optionalProducts.orElseGet(ArrayList::new));
        model.addAttribute("search",search);
        model.addAttribute("resultPage", page);
        model.addAttribute("menu", menu);



        System.out.println("/likeProduct이 끝났습니다..");

        //네비게이션
            return "forward:/product/likeProduct.jsp";

    }//end of likeProduct

    //클라-searchBoundFirst,searchBoundEnd,search,menu,products,page
    @RequestMapping("/listProduct")
    public String listProduct(@ModelAttribute(value = "search") Search search,
                              @RequestParam(value = "searchBoundFirst", required = false) Integer searchBoundFirst,
                              @RequestParam(value = "searchBoundEnd", required = false) Integer searchBoundEnd,
                              @RequestParam(value = "menu", required = false) String menu,
                              //image는 이미지로 볼거냐 이거다. 이미지파일 보내는거 아님.
                              @RequestParam(value = "image", required = false) String image,
                              Model model) throws Exception {
        System.out.println("/listProduct이 시작됩니다..");
        System.out.println("searchBound :: " + searchBoundFirst + " " + searchBoundEnd);
        System.out.println("searchType :: "+ search.getSearchType());
//        if(search.getSearchType() == null) {
//            search.setSearchType("1");
//        }

        if(searchBoundFirst ==null && searchBoundEnd == null) {
        searchBoundFirst = 0;
        searchBoundEnd = 0;
        }
        //바인딩 : 클라-searchBoundFirst, searchBoundEnd > search도메인
        if (!(searchBoundFirst == 0) || !(searchBoundEnd == 0)) {
            search.setSearchBoundFirst(searchBoundFirst);
            search.setSearchBoundEnd(searchBoundEnd);
//                System.out.println("searchBound[0]"+searchBound[0]);
//                System.out.println("searchBound[1]"+searchBound[1]);
        }


        //바인딩 : 클라-currentPage > search도메인 > page도메인
        int currentPage = 1;
        //경로 1,2,3,4로 들어왔을경우
        if (search.getCurrentPage() != 0) {
            currentPage = search.getCurrentPage();
        }

        search.setCurrentPage(currentPage);
        search.setPageSize(pageSize);
        System.out.println("search");
        System.out.println(search);
        Map<String, Object> productMap = productService.getProductList(search);//Like와 다른 부분
        List<Product> list = (List<Product>)productMap.get("list");
        List<List<String>> fileNameListList = new ArrayList<>();

        Optional.ofNullable(image)
                .filter(img -> img.equals("ok"))
                .ifPresent(img -> {
                    Optional.ofNullable(list)//Optional<List<Product>>
                            .ifPresent(lst -> lst.stream()
                                    .flatMap(product -> Optional.ofNullable(product.getFileName())
                                            .map(fileName -> fileName.split(","))
                                            .stream())
                                    .forEach(array -> Optional.ofNullable(fileNameListList)
                                            .ifPresent(fListList -> fListList.add(Arrays.asList(array)))));

                    fileNameListList.forEach(fileNameList -> System.out.println("fileNameList :: " + fileNameList));
                });

        Page page = new Page(
                currentPage,
                (Integer) productMap.get("totalCount"),
                pageUnit,
                pageSize);

        System.out.println("ListProductAction ::" + page);
        System.out.println("list :: " + list);
        System.out.println("search :: " + search);




        //Model 과 View 연결
        //model.addAttribute("products", products);
        //model.addAttribute("search", search);
        model.addAttribute("totalCount", productMap.get("totalCount"));
        model.addAttribute("list", list);
        model.addAttribute("resultPage", page);
        model.addAttribute("menu", menu);

        Optional.ofNullable(image)
                        .filter(img -> img.equals("ok"))
                                .ifPresent(img -> model.addAttribute("fileNameListList",fileNameListList));


        System.out.println("/listProduct이 끝났습니다..");

        //네비게이션
        if (menu != null) {
            System.out.println("forward:/product/listProduct.jsp" + "합니다.");
            if(image == null || !image.equals("no")) {
                return "forward:/product/listProductImage.jsp";
            }
            return "forward:/product/listProduct.jsp";
        } else {
            System.out.println("forward:/product/getProduct.jsp" + "합니다.");
            if(image == null || !image.equals("no")) {
                return "forward:/product/listProductImage.jsp";
            }
            return "forward:/product/getProduct.jsp";
        }//end of else
    }//end of listProduct

    //prodNo,menu,currentPage,
    @RequestMapping("/setLikeProduct")
    public String SetLikeProduct(HttpServletRequest request,
                                 HttpServletResponse response,
                                 @RequestParam("prodNo") int prodNo,
                                 @RequestParam("menu") String menu,
                                 @RequestParam("currentPage") final int currentPage,
                                 @RequestParam(value = "navigation", required = false) String navigation,
                                 @CookieValue(name = "like", required = false) String likeCookie,
                                 Model model) throws Exception {
        System.out.println("/////////////////////////////////////////////////////////////setLikeProduct이 시작됩니다..");


        //Business Logic
        Product product = productService.getProduct(prodNo);

        //쿠키디버깅 ;
        if (likeCookie!=null && likeCookie.startsWith(";")) {
            likeCookie = likeCookie.substring(1);
        }


        System.out.println("setLikeProduct::likeCookie :: "+likeCookie);
        String[] likeCookies = null;

        if (likeCookie != null) {
            likeCookies = likeCookie.split(";");
        } // IF

        System.out.println("setLikeProduct::likeCookies::"+ Arrays.toString(likeCookies));

        boolean result = true;
        if(likeCookies!=null) {
            for (String element : likeCookies) {
                if (element.equals(String.valueOf(product.getProdNo()))) {//같은게 하나라도 있으면 false
                    result = false;
                } // IF
            } // FOR
        }
        if(result) {//같은게 없으면 true
            CookieUtil.addValue(request, response, "like", String.valueOf(product.getProdNo()));
        }

        request.setAttribute("currentPage", currentPage);
        //request.setAttribute("from", "setLikeProduct");
        //request.setAttribute("product",product);

        System.out.println("//////////////////////////////////////////////////////////////setLikeProduct이 끝났습니다..");
        System.out.println("forward:/product/listProduct?menu=search" + "합니다.");
        //어차피 찜리스트는 관리자는 실행할 수 없도록 해놓았음.

        //navigation이 null이면 표로 listProductImg.jsp면 이미지로 해야한다.
        //옵셔널의 filter.map.orElse패턴 사용하면 댐.
        //filter로 널처리. 널 아닌것만 가져옴
        //if else인 동시에 값 할당이니 삼항연산자 사용하면 댐
        //상수.equals(변수)패턴 사용하면 댐

        //"forward:/product/listProduct"+"?currentPage="+currentPage
        return Optional.ofNullable(navigation)
                .filter(nav->nav!=null&&!nav.isEmpty())
                .map(nav->"listProductImage.jsp".equals(nav) ? "forward:/product/listProduct?menu="+menu+"&image=ok" : "forward:/product/listProduct"+"?currentPage="+currentPage)
                .orElseGet(()-> "forward:/product/listProduct?currentPage="+currentPage);



    }//end of SetLikeProduct

    @PostMapping("/updateProduct")
    public String updateProduct(@ModelAttribute("product") Product product,
                                @RequestParam("fileList") List<MultipartFile> fileList,
                                RedirectAttributes redirectAttributes,
                                Model model) throws Exception {
        System.out.println("/updateProduct 이 시작됩니다.");
        System.out.println("fileList::" + fileList);
        if (fileList.isEmpty()) {
            redirectAttributes.addFlashAttribute("message", "Please select a file to upload");
            throw new Exception("파일이 ㅇ벗습니다.");
        }

//        String fileName = getProductFileName(file);
        List<String> fileNameList = new ArrayList<>();
        for(MultipartFile file : fileList) {
            fileNameList.add(getProductFileName(file));

        }

        System.out.println("fileNameList :: "+fileNameList);

        //Business Logic
        product = productService.getProduct(product.getProdNo());

//        product.setFileName(fileName);
        product.setFileName(String.join(",", fileNameList));
        product.setManuDate(product.getManuDate().replaceAll("-", ""));

        System.out.println("업데이트 완료 :: " + productService.updateProduct(product));

        //Model 과 View 연결
        model.addAttribute("product", product);
        model.addAttribute("fileNameList",fileNameList);

        System.out.println("/updateProduct 이 끝났습니다.");
        System.out.println("redirect:/getProduct" + "합니다.");
        redirectAttributes.addFlashAttribute("message", "You successfully uploaded '" + String.join(", ", fileNameList) + "' and added product information.");
        return "redirect:/product/getProduct?prodNo=" + product.getProdNo() + "&menu=ok";
    }//end of updateProduct

    //prodNo,
    @GetMapping("/updateProduct")
    public String updateProductView(@ModelAttribute Product product,
                                    Model model) throws Exception {

        System.out.println("/updateProductView" + "이 시작됩니다..");
        product = productService.getProduct(product.getProdNo());

        // Model 과 View 연결
        model.addAttribute("product", product);

        System.out.println("/updateProductView" + "이 끝났습니다.");
        System.out.println("forward:/product/updateProduct.jsp" + "합니다.");
        return "forward:/product/updateProduct.jsp";
    }

    public String getProductFileName(MultipartFile file) throws Exception{;

        String osName = System.getProperty("os.name").toLowerCase();
        String uploadDir;
        System.out.println("osName :: " + osName);

        ClassLoader classLoader = ProductController.class.getClassLoader();

        // getResource() 메소드를 사용하여 루트 경로를 얻습니다.
        // "" (빈 문자열)은 클래스패스의 루트를 나타냅니다.
        URL rootPath = classLoader.getResource("");

        System.out.println(getClass().getClassLoader().getResource(""));

        // 루트 경로를 출력합니다.
        System.out.println("Classpath root path: " + rootPath);
        // ExampleClass가 로드된 리소스의 URL을 얻습니다.
        URL classLocation = ProductController.class.getResource("ProductController.class");

        // 위치를 출력합니다.
        System.out.println("ProductController is loaded from: " + classLocation);
        //file:/C:/workSpringBoot/workspace/Myshop12/target/classes/myshop12/com/model2/mvc/product/controller/ProductController.class



        // 시스템 클래스패스를 가져옵니다.
//        String classPath = System.getProperty("java.class.path");

        // 클래스패스를 출력합니다.
//        System.out.println("Current classpath: " + classPath);

        // 클래스패스를 콜론(:) 또는 세미콜론(;)을 기준으로 분리하여 개별 경로를 출력할 수 있습니다.
//        String[] paths = classPath.split(System.getProperty("path.separator"));
//        for (String path : paths) {
//            System.out.println(path);
//        }
        String fileName = file.getOriginalFilename();

        if (osName.contains("windows")) {
            uploadDir = "C://workSpringBoot/workspace/Myshop12/src/main/resources/static/images/uploadFiles/";
//
//            이거 하니까 자꾸 리빌드함.
//            String uploadDir2 = classLocation.toString().replace("file:/", "");
//            Path path2 = Paths.get(uploadDir2 + fileName);
//            FileCopyUtils.copy(file.getBytes(), new File(path2.toString()));
        } else {
            // 리눅스 배포 환경에 맞는 경로 설정
            // 예: /var/webapp/WEB-INF/classes/static/images/
            uploadDir = "/usr/local/tomcat/webapps/ROOT/WEB-INF/classes/static/images/uploadFiles/";

        }


        System.out.println("uploadDir :: "+uploadDir);
        System.out.println("fileName :: " + fileName);

        Path path = Paths.get(uploadDir + fileName);


        // 디렉토리가 존재하지 않는 경우 생성
        if (!Files.exists(path.getParent())) {
            Files.createDirectories(path.getParent());
        }

        FileCopyUtils.copy(file.getBytes(), new File(path.toString()));

//      Files.copy(file.getInputStream(), path, StandardCopyOption.REPLACE_EXISTING);

        return fileName;
    }

}
