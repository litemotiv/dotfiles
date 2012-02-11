# This is a basic VCL configuration file for varnish.  See the vcl(7)
# man page for details on VCL syntax and semantics.
# 
# Default backend definition.  Set this to point to your content
# server.
# 
backend default {
    .host = "127.0.0.1";
    .port = "80";
}

# called after request received
sub vcl_recv {
    # purge request
    if(req.request == "PURGE") {
        purge_url(req.url);
        error 200 "Purged";
    }

    # grace period serves stale (but cacheable) objects while retrieving from backend
    set req.grace = 30s;
    
    # remove cookies from static files
    if (req.url ~ "\.(jpg|gif|png|ico|css|zip|gz|pdf|txt|js|flv|swf|html)$") {
        unset req.http.Cookie;
	return(lookup);
    }

    # never cache the admin pages, or the server-status page
    if (req.request == "GET" && (req.url ~ "(wp-admin|server-status)")) {
        return(pipe);
    }

    # exclude domains
    if (req.http.host ~ "revelopment.nl") {
        return (pass);
    }

    # remove all cookies except wordpress
    if (req.http.Cookie) {
        if (req.http.Cookie ~ "wordpress_logged") {
            return(pass);
        } else {
            unset req.http.Cookie;
        }
    }

    # don't cache ajax requests
    if(req.http.X-Requested-With == "XMLHttpRequest" || req.url ~ "(wp-comments-post.php|wp-login.php)") {
        return (pass);
    }
}

# called after succesful fetch from backend
sub vcl_fetch {
    # grace period serves stale (but cacheable) objects while retrieving from backend
    set beresp.grace = 30s;

    if (req.http.Cookie) {
        set beresp.ttl = 10s;
    } else {
        # set default cache time
        set beresp.ttl = 900s;
    }

    # Strip cookies for static files and set a long cache expiry time.
    if (req.url ~ "\.(jpg|gif|png|ico|css|zip|gz|pdf|txt|js|flv|swf|html)$") {
            unset beresp.http.set-cookie;
            set beresp.ttl = 24h;
    }

    # object was not cacheable
    if (!beresp.cacheable) {
        set beresp.http.X-Cacheable = "NO: Not Cacheable";
    
    # don't cache content for logged in users
    } elsif (req.http.Cookie ~ "(wordpress_)") {
        set beresp.http.X-Cacheable = "NO: Got Session";
        return(pass);
    
    # extending lifetime of object artificially
    } elsif (beresp.ttl < 1s) {
        set beresp.ttl   = 900s;
        set beresp.grace = 900s;
        set beresp.http.X-Cacheable = "YES: FORCED";

    # object was cacheable
    } else {
        set beresp.http.X-Cacheable = "YES";
    }
    
    return(deliver);
}

sub vcl_deliver {
    if (obj.hits > 0) {
        set resp.http.X-Cache = "HIT";
    } else {
        set resp.http.X-Cache = "MISS";
    }
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
