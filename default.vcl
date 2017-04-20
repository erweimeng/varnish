#
# This is an example VCL file for Varnish.
#
# It does not do anything by default, delegating control to the
# builtin VCL. The builtin VCL is called when there is no explicit
# return statement.
#
# See the VCL chapters in the Users Guide at https://www.varnish-cache.org/docs/
# and http://varnish-cache.org/trac/wiki/VCLExamples for more examples.

# Marker to tell the VCL compiler that this VCL has been adapted to the
# new 4.0 format.
vcl 4.0;
import directors;
# Default backend definition. Set this to point to your content server.
backend web1 {
    .host = "172.16.2.27";
    .port = "80";
}

sub vcl_recv {    
   if (req.http.host ~ "(www.)?laiwojia.la") {
	set req.backend_hint = web1;
	}
	return(hash);
    if (req.url ~ "(?i)^/(login|admin)") {
	return(pass);
	}
    if (req.url ~ "(?i)\.php$") {
        set req.backend_hint = web1;
    	}
    if (req.url ~ "(?i)\.(jpg|jpeg|png|gif|css|js)$") {
	set req.backend_hint = web1;
	}
	if (req.method !="GET" && req.method != "HEAD" && req.method != "PUT" && req.method != "POST" && req.method != "TRACE" && req.method != "OPTIONS" && req.method != "PATCH" &&  req.method != "DELETE") {
	return (pipe);
	}
	if (req.http.Upgrade ~ "(?i)websocket") {
    	return (pipe);
  	}
	if (req.method != "GET" && req.method != "HEAD") {
    	return (pass);
  	}
	if (req.url ~ "^[^?]*\.(7z|avi|bmp|bz2|css|csv|doc|docx|eot|flac|flv|gif|gz|ico|jpeg|jpg|js|less|mka|mkv|mov|mp3|mp4|mpeg|mpg|odt|otf|ogg|ogm|opus|pdf|png|ppt|pptx|rar|rtf|svg|svgz|swf|tar|tbz|tgz|ttf|txt|txz|wav|webm|webp|woff|woff2|xls|xlsx|xml|xz|zip)(\?.*)?$") {
    	unset req.http.Cookie;
    	return (hash);
  	}
	if (req.http.Authorization || req.http.Cookie) {
	return (pass);
}
}




#对于特定类型的资源，例如公开的图片等，取消其私有标识，并强行设定其可以由varnish缓存的时长
sub vcl_backend_response {
    if (beresp.http.cache-control !~ "s-maxage") {
	if (bereq.url ~ "(?i)\.(jpg|jpeg|png|gif|css|js)$") {
		unset beresp.http.Set-Cookie;
		set beresp.ttl = 3600s;
		}
	}
     if (bereq.http.host == "(www.)?laiwojia.la") {
        if (bereq.url ~ "(?i)/api/product/hotlist"
           ||bereq.url ~ "(?i)/api/dolphin/list"
           ||bereq.url ~ "(?i)/api/product/baseInfo"
           ||bereq.url ~ "(?i)/api/product/desc"
           ||bereq.url ~ "(?i)/api/search/brandRecommendProduct"   
           ||bereq.url ~ "(?i)/cms/view/h5/headlinesList"   
           ||bereq.url ~ "(?i)/cms/view/h5/category"       
           ||bereq.url ~ "(?i)/cms/view/h5/article"       
           ||bereq.url ~ "(?i)/cms/view/h5/\w+\.html"     
           ||bereq.url ~ "(?i)/api/product/distributions")
        {
         set beresp.ttl = 300s;  //缓存时间改为5分钟
        }
        elseif (bereq.url ~ "(?i)/api/search/searchList\?sortType=volume4sale_desc\&companyId=10\&keyword=\*\*\*\*\*\&pageSize=10" )
        {
          set beresp.ttl = 60s;  //设置为1分钟
        }
        elseif (bereq.url ~ "(?i)/cms/view/.*/templateJS\.json" 
              ||bereq.url ~ "(?i)\.html")
        {
          set beresp.ttl = 600s;  //设置为10分钟
        }
        elseif (bereq.url ~ "(?i)/libs/")
        {
           set beresp.ttl = 1800s;
        }

}
}
#sub vcl_deliver {
#    # Happens when we have all the pieces we need, and are about to send the
#    # response to the client.
#    # 
#    # You can do accounting or modifying the final object here.
#}
sub vcl_deliver {
    if (obj.hits > 0) {
       set resp.http.X-Cache = "Hit"+server.ip;
     } else {
       set resp.http.X-Cache = "Miss";
     }
}
