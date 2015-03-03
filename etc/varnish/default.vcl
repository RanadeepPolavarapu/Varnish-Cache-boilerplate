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

# Default backend definition. Set this to point to your content server.
backend default {
    .host = "0.0.0.0";
    .port = "80";
}

sub vcl_recv {
    # Happens before we check if we have this in cache already.
    #
    # Typically you clean up the request here, removing cookies you don't need,
    # rewriting the request, etc.
    set    req.http.X-Forwarded-For = client.ip;

}

sub vcl_backend_response {
    # Happens after we have read the response headers from the backend.
    #
    # Here you clean the response headers, removing silly Set-Cookie headers
    # and other mistakes your backend does.
}

sub vcl_deliver {
    # Happens when we have all the pieces we need, and are about to send the
    # response to the client.
    #
    # You can do accounting or modifying the final object here.
    if (obj.hits > 0) {
        set resp.http.X-Cache = "HIT";
        set resp.http.X-Varnish-Cache = "(HIT) " + obj.hits;
    } else {
        set resp.http.X-Cache = "MISS";
        set resp.http.X-Varnish-Cache = "(MISS)";
    }

    set resp.http.X-Client-IP = client.ip;

    set resp.http.X-Varnish-Response-Proto = resp.proto;
    set resp.http.X-Varnish-Response-Reason = resp.reason;
    set resp.http.X-Varnish-Response-Status = resp.status;

    set resp.http.X-Varnish-Object-Uncacheable = obj.uncacheable;
}
