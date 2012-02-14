backend default {
    .host = "127.0.0.1";
    .port = "80";
}

sub vcl_recv {
    if (req.request == "PURGE") {
        purge_url(req.url);
        error 200 "Purged";
    }

    if (req.request != "GET" && req.request != "HEAD") {
        return(pass);
    }
    
    if (req.url ~ "(wp-admin|server-status|wp-comments-post.php|wp-login.php)") {
        return(pipe);
    }

    if (req.http.host ~ "revelopment.nl") {
        return(pass);
    }

    if (req.http.X-Requested-With == "XMLHttpRequest") {
        return(pass);
    }

    if (req.http.Cookie ~ "wordpress_logged") {
        return(pass);
    } 

    if (req.http.Accept-Encoding) {
	if (req.url ~ "\.(jpg|png|gif)$") {
	    remove req.http.Accept-Encoding;
	} elsif (req.http.Accept-Encoding ~ "gzip") {
	    set req.http.Accept-Encoding = "gzip";
	} elsif (req.http.Accept-Encoding ~ "deflate") {
	    set req.http.Accept-Encoding = "deflate";
	} else {
	    remove req.http.Accept-Encoding;
	}
    }
    
    set req.grace = 30s;

    unset req.http.Cookie;

    return(lookup);
}

sub vcl_fetch {
    set beresp.grace = 30s;
    set beresp.ttl = 900s;

    if (req.url ~ "\.(jpg|gif|png|ico|css|zip|gz|pdf|txt|js|flv|swf|html)$") {
        set beresp.ttl = 24h;
	unset beresp.http.Set-Cookie;
    }

    return(deliver);
}

sub vcl_deliver {
    set resp.http.X-Cache-Hits = obj.hits;
}

# Below is a commented-out copy of the default VCL logic.  If you
# redefine any of these subroutines, the built-in logic will be
# appended to your code.
# 
# sub vcl_recv {
#     if (req.http.x-forwarded-for) {
# 	set req.http.X-Forwarded-For =
# 	    req.http.X-Forwarded-For ", " client.ip;
#     } else {
# 	set req.http.X-Forwarded-For = client.ip;
#     }
#     if (req.request != "GET" &&
#       req.request != "HEAD" &&
#       req.request != "PUT" &&
#       req.request != "POST" &&
#       req.request != "TRACE" &&
#       req.request != "OPTIONS" &&
#       req.request != "DELETE") {
#         /* Non-RFC2616 or CONNECT which is weird. */
#         return (pipe);
#     }
#     if (req.request != "GET" && req.request != "HEAD") {
#         /* We only deal with GET and HEAD by default */
#         return (pass);
#     }
#     if (req.http.Authorization || req.http.Cookie) {
#         /* Not cacheable by default */
#         return (pass);
#     }
#     return (lookup);
# }
# 
# sub vcl_pipe {
#     # Note that only the first request to the backend will have
#     # X-Forwarded-For set.  If you use X-Forwarded-For and want to
#     # have it set for all requests, make sure to have:
#     # set req.http.connection = "close";
#     # here.  It is not set by default as it might break some broken web
#     # applications, like IIS with NTLM authentication.
#     return (pipe);
# }
# 
# sub vcl_pass {
#     return (pass);
# }
# 
# sub vcl_hash {
#     set req.hash += req.url;
#     if (req.http.host) {
#         set req.hash += req.http.host;
#     } else {
#         set req.hash += server.ip;
#     }
#     return (hash);
# }
# 
# sub vcl_hit {
#     if (!obj.cacheable) {
#         return (pass);
#     }
#     return (deliver);
# }
# 
# sub vcl_miss {
#     return (fetch);
# }
# 
# sub vcl_fetch {
#     if (!beresp.cacheable) {
#         return (pass);
#     }
#     if (beresp.http.Set-Cookie) {
#         return (pass);
#     }
#     return (deliver);
# }
# 
# sub vcl_deliver {
#     return (deliver);
# }
# 
# sub vcl_error {
#     set obj.http.Content-Type = "text/html; charset=utf-8";
#     synthetic {"
# <?xml version="1.0" encoding="utf-8"?>
# <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
#  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
# <html>
#   <head>
#     <title>"} obj.status " " obj.response {"</title>
#   </head>
#   <body>
#     <h1>Error "} obj.status " " obj.response {"</h1>
#     <p>"} obj.response {"</p>
#     <h3>Guru Meditation:</h3>
#     <p>XID: "} req.xid {"</p>
#     <hr>
#     <p>Varnish cache server</p>
#   </body>
# </html>
# "};
#     return (deliver);
# }
