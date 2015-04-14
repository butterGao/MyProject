<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<meta name="Copyright" content="酷站代码 http://www.5icool.org/" />
<title>带标题简单实用的网站首页js多图幻灯轮播代码_酷站代码 www.5icool.org</title>
    <link href="../css/slideshow.css" rel="stylesheet" />
    <script src="../js/slideshow.js" type="text/javascript"></script>
</head>
<body>
    <!-- 代码 开始 -->
    <div class="comiis_wrapad" id="slideContainer">
        <div id="frameHlicAe" class="frame cl">
            <div class="temp"></div>
            <div class="block">
                <div class="cl">
                    <ul class="slideshow" id="slidesImgs">
                        <li><a href="http://www.5icool.org/" target="_blank">
                            <img src="images/1.jpg" width="400px" height="230" alt="" /></a><span class="title">第1张图的描述信息</span></li>
                        <li><a href="http://www.5icool.org/" target="_blank">
                            <img src="images/2.jpg" width="400px" height="230" alt="" /></a><span class="title">第2张图酷站代码网</span></li>
                        <li><a href="http://www.5icool.org/" target="_blank">
                            <img src="images/3.jpg" width="400px" height="230" alt="" /></a><span class="title">第3张图的描述信息</span></li>
                        <li><a href="http://www.5icool.org/" target="_blank">
                            <img src="..images/4.jpg" width="400px" height="230" alt="" /></a><span class="title">第4张图的描述信息</span></li>
                        <li><a href="http://www.5icool.org/" target="_blank">
                            <img src="../images/hkmap.jpg" width="400px" height="230" alt="" /></a><span class="title">第5张图的描述信息</span></li>
                    </ul>
                </div>
                <div class="slidebar" id="slideBar">
                    <ul>
                        <li class="on">1</li>
                        <li>2</li>
                        <li>3</li>
                        <li>4</li>
                        <li>5</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        SlideShow(3000);
    </script>

</body>
</html>