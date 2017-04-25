# varnish
varnish 配置文件
自测varnish


###########################################


1、安装varnish所需lib，
 rpm --nosignature -i http://repo.varnish-cache.org/redhat/varnish-4.0/el6/x86_64/varnish/varnish-libs-4.0.0-1.el6.x86_64.rpm
2、安装jemalloc，库文件可到此链接处下载：ftp-hk.tmapy.cz/fedora/epel/6/x86_64/jemalloc-3.6.0-1.el6.i686.rpm

rpm --nosignature -i http://ftp-hk.tmapy.cz/fedora/epel/6/x86_64/jemalloc-3.6.0-1.el6.x86_64.rpm


#可以去下载合适自己的varnish版本软件包
http://repo.varnish-cache.org/redhat/varnish-4.0/el6/x86_64/varnish/


3、开始安装，
rpm --nosignature -i http://repo.varnish-cache.org/redhat/varnish-4.0/el6/x86_64/varnish/varnish-4.0.0-1.el6.x86_64.rpm

4、安装完成后，启动varnish：
service varnish start

5、重新加载varnish配置文件
varnish_reload_vcl 命令操作


6、查看varnish的命中率
varnishstat

7、varnish的两种不同的日志格式

1) varnishlog类型
[root@www ~]# varnishlog 
*   << Request  >> 65550     
-   Begin          req 65549 rxreq
-   Timestamp      Start: 1493129944.278962 0.000000 0.000000
-   Timestamp      Req: 1493129944.278962 0.000000 0.000000
-   ReqStart       172.16.2.62 54992
-   ReqMethod      GET
-   ReqURL         /
-   ReqProtocol    HTTP/1.1
-   ReqHeader      Host: www.laiwojia.la
-   ReqHeader      Connection: keep-alive
-   ReqHeader      Cache-Control: max-age=0
-   ReqHeader      Upgrade-Insecure-Requests: 1
-   ReqHeader      User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/52.0.2743.116 Safari/537.36
-   ReqHeader      Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8
-   ReqHeader      Accept-Encoding: gzip, deflate, sdch
-   ReqHeader      Accept-Language: zh-CN,zh;q=0.8
-   ReqHeader      If-None-Match: "58fa04e4-8"
-   ReqHeader      If-Modified-Since: Fri, 21 Apr 2017 13:11:00 GMT
-   ReqHeader      X-Forwarded-For: 172.16.2.62
-   VCL_call       RECV
-   VCL_return     hash
-   ReqUnset       Accept-Encoding: gzip, deflate, sdch
-   ReqHeader      Accept-Encoding: gzip
-   VCL_call       HASH
-   VCL_return     lookup
-   Hit            2147483651
-   VCL_call       HIT
-   VCL_return     deliver
-   Timestamp      Process: 1493129944.279052 0.000090 0.000090
-   RespProtocol   HTTP/1.1
-   RespStatus     200
-   RespResponse   OK
-   RespHeader     Server: nginx/1.10.3
2) varnishncsa 类型
# varnishncsa 
172.16.2.62 - - [25/Apr/2017:22:21:01 +0800] "GET http://www.laiwojia.la/ HTTP/1.1" 200 0 "-" "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/52.0.2743.116 Safari/537.36"
172.16.2.62 - - [25/Apr/2017:22:21:01 +0800] "GET http://www.laiwojia.la/ HTTP/1.1" 200 0 "-" "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/52.0.2743.116 Safari/537.36"
172.16.2.62 - - [25/Apr/2017:22:21:01 +0800] "GET http://www.laiwojia.la/ HTTP/1.1" 200 0 "-" "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/52.0.2743.116 Safari/537.36"
172.16.2.62 - - [25/Apr/2017:22:21:01 +0800] "GET http://www.laiwojia.la/ HTTP/1.1" 200 0 "-" "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/52.0.2743.116 Safari/537.36"



