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
