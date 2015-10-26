vcl 4.0;

backend default {
    .host = "127.0.0.1";
    .port = "8080";
}

#acl block {
#	"162.144.112.80";
#	"197.251.172.101"; # DTS
#	"46.235.46.8"; # KNSB
#	"83.83.91.242"; # KNSB
#}

sub vcl_recv {
    #block
    #if (client.ip ~ block) {
	#	return (synth(403, ""));
	#}

    if (req.http.user-agent ~ "Java" || 
		req.url ~ "xmlrpc" || 
		req.url ~ "/(uploads|files|blogs.dir)/.*\.php") 
	{
		return (synth(403, ""));
	}

	if (req.method == "PURGE") {
		return(purge);
	}

    # strip out analytics
    #if (req.url ~ "utm_") {
    #    set req.url = regsub(req.url, "\?.*$", "");
    #}
    
    # redirect is temp voor weeronline
    if (req.url ~ "redirect" || 
		req.http.X-Requested-With == "XMLHttpRequest") 
	{
        return(pass);
    }

	# remove static cookies
    if (req.url ~ "\.(jpg|gif|png|ico|ttf|mp3|mp4|otf|woff|pdf)") {
        unset req.http.Cookie;
		return(hash);
	}
    
	# exclude wordpress sessions
    if (req.http.Cookie ~ "wordpress_logged" || req.url ~ "wp-admin" || req.url ~ "wp-login") {
        return(pass);
    } 
	
	# hacky? allow css and js to be fresh for logged in users (below)
    #if (req.url ~ "\.(css|js)") {
        unset req.http.Cookie;
	#}
}

sub vcl_backend_response {
	set beresp.do_stream = false;

	# grace time to keep stale objects in cache
	set beresp.grace = 30s;

	# varnish ttl
	set beresp.ttl = 900s;

	# cache expiration / ttl = varnish / cache-control = browser
	if (bereq.url ~ "\.(jpg|jpeg|gif|png|ico|ttf|otf|woff|eot|htc)") {
		unset beresp.http.Set-Cookie;
		set beresp.ttl = 2h;
		set beresp.http.Cache-Control = "public, max-age=31536000";
	} 
	
	if (bereq.url ~ "\.(css|js)") {
		set beresp.http.Cache-Control = "public, max-age=900";
	}

    return(deliver);
}

sub vcl_deliver {
    # add hit-rate header to response
    set resp.http.X-Cache-Hits = obj.hits;
}

