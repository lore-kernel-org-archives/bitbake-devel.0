Return-Path: <anibal.limon@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 631EC759D5
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 23 Jun 2015 22:08:03 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by orsmga101.jf.intel.com with ESMTP; 23 Jun 2015 14:56:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.13,668,1427785200"; d="scan'208";a="513184748"
Received: from alimon-thinkpad-w540.zpn.intel.com ([10.219.4.55])
	by FMSMGA003.fm.intel.com with ESMTP; 23 Jun 2015 14:56:57 -0700
From: =?UTF-8?q?An=C3=ADbal=20Lim=C3=B3n?= <anibal.limon@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 23 Jun 2015 16:58:48 -0500
Message-Id: <1435096729-14507-4-git-send-email-anibal.limon@linux.intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1435096729-14507-1-git-send-email-anibal.limon@linux.intel.com>
References: <1435096729-14507-1-git-send-email-anibal.limon@linux.intel.com>
MIME-Version: 1.0
Subject: [PATCHv2 3/4] fetch2/__init__.py: Add connection_cache param in Fetch __init__.
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 23 Jun 2015 22:08:03 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In order to pass connection cache object to checkstatus method.

fetch2/wget.py: Add support of connection cache in checkstatus.

[YOCTO #7796]

Signed-off-by: Aníbal Limón <anibal.limon@linux.intel.com>
---
 lib/bb/fetch2/__init__.py |   3 +-
 lib/bb/fetch2/wget.py     | 140 ++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 138 insertions(+), 5 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 8d0221d..7b4d130 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1505,7 +1505,7 @@ class FetchMethod(object):
         return "%s-%s" % (key, d.getVar("PN", True) or "")
 
 class Fetch(object):
-    def __init__(self, urls, d, cache = True, localonly = False):
+    def __init__(self, urls, d, cache = True, localonly = False, connection_cache = None):
         if localonly and cache:
             raise Exception("bb.fetch2.Fetch.__init__: cannot set cache and localonly at same time")
 
@@ -1514,6 +1514,7 @@ class Fetch(object):
         self.urls = urls
         self.d = d
         self.ud = {}
+        self.connection_cache = connection_cache
 
         fn = d.getVar('FILE', True)
         if cache and fn and fn in urldata_cache:
diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index abacbcf..8cb5f2b 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -101,12 +101,144 @@ class Wget(FetchMethod):
         return True
 
     def checkstatus(self, fetch, ud, d):
+        import urllib2, socket, httplib
+        from urllib import addinfourl
+        from bb.fetch2 import FetchConnectionCache
+
+        class HTTPConnectionCache(httplib.HTTPConnection):
+            if fetch.connection_cache:
+                def connect(self):
+                    """Connect to the host and port specified in __init__."""
+
+                    sock = fetch.connection_cache.get_connection(self.host, self.port)
+                    if sock:
+                        self.sock = sock
+                    else:
+                        self.sock = socket.create_connection((self.host, self.port),
+                                    self.timeout, self.source_address)
+                        fetch.connection_cache.add_connection(self.host, self.port, self.sock)
+
+                    if self._tunnel_host:
+                        self._tunnel()
+
+        class CacheHTTPHandler(urllib2.HTTPHandler):
+            def http_open(self, req):
+                return self.do_open(HTTPConnectionCache, req)
+
+            def do_open(self, http_class, req):
+                """Return an addinfourl object for the request, using http_class.
+
+                http_class must implement the HTTPConnection API from httplib.
+                The addinfourl return value is a file-like object.  It also
+                has methods and attributes including:
+                    - info(): return a mimetools.Message object for the headers
+                    - geturl(): return the original request URL
+                    - code: HTTP status code
+                """
+                host = req.get_host()
+                if not host:
+                    raise urlllib2.URLError('no host given')
+
+                h = http_class(host, timeout=req.timeout) # will parse host:port
+                h.set_debuglevel(self._debuglevel)
+
+                headers = dict(req.unredirected_hdrs)
+                headers.update(dict((k, v) for k, v in req.headers.items()
+                            if k not in headers))
+
+                # We want to make an HTTP/1.1 request, but the addinfourl
+                # class isn't prepared to deal with a persistent connection.
+                # It will try to read all remaining data from the socket,
+                # which will block while the server waits for the next request.
+                # So make sure the connection gets closed after the (only)
+                # request.
+
+                # Don't close connection when connection_cache is enabled,
+                if fetch.connection_cache is None: 
+                    headers["Connection"] = "close"
+                else:
+                    headers["Connection"] = "Keep-Alive" # Works for HTTP/1.0
+
+                headers = dict(
+                    (name.title(), val) for name, val in headers.items())
+
+                if req._tunnel_host:
+                    tunnel_headers = {}
+                    proxy_auth_hdr = "Proxy-Authorization"
+                    if proxy_auth_hdr in headers:
+                        tunnel_headers[proxy_auth_hdr] = headers[proxy_auth_hdr]
+                        # Proxy-Authorization should not be sent to origin
+                        # server.
+                        del headers[proxy_auth_hdr]
+                    h.set_tunnel(req._tunnel_host, headers=tunnel_headers)
+
+                try:
+                    h.request(req.get_method(), req.get_selector(), req.data, headers)
+                except socket.error, err: # XXX what error?
+                    # Don't close connection when cache is enabled.
+                    if fetch.connection_cache is None:
+                        h.close()
+                    raise urllib2.URLError(err)
+                else:
+                    try:
+                        r = h.getresponse(buffering=True)
+                    except TypeError: # buffering kw not supported
+                        r = h.getresponse()
+
+                # Pick apart the HTTPResponse object to get the addinfourl
+                # object initialized properly.
+
+                # Wrap the HTTPResponse object in socket's file object adapter
+                # for Windows.  That adapter calls recv(), so delegate recv()
+                # to read().  This weird wrapping allows the returned object to
+                # have readline() and readlines() methods.
+
+                # XXX It might be better to extract the read buffering code
+                # out of socket._fileobject() and into a base class.
+                r.recv = r.read
+
+                # no data, just have to read
+                r.read()
+                class fp_dummy(object):
+                    def read(self):
+                        return ""
+                    def readline(self):
+                        return ""
+                    def close(self):
+                        pass
+
+                resp = addinfourl(fp_dummy(), r.msg, req.get_full_url())
+                resp.code = r.status
+                resp.msg = r.reason
+
+                # Close connection when server request it.
+                if fetch.connection_cache is not None:
+                    if 'Connection' in r.msg and r.msg['Connection'] == 'close':
+                        fetch.connection_cache.remove_connection(h.host, h.port)
+
+                return resp
+
+        def export_proxies(d):
+            variables = ['http_proxy', 'HTTP_PROXY', 'https_proxy', 'HTTPS_PROXY',
+                            'ftp_proxy', 'FTP_PROXY', 'no_proxy', 'NO_PROXY']
+
+            for v in variables:
+                if not v in os.environ.keys():
+                    os.environ[v] = d.getVar(v, True) or ''
+
+        def head_method(self):
+            return "HEAD"
+
+        export_proxies(d)
+        urllib2.Request.get_method = head_method
+        opener = urllib2.build_opener(urllib2.ProxyHandler, CacheHTTPHandler)
+        urllib2.install_opener(opener)
 
         uri = ud.url.split(";")[0]
-        fetchcmd = self.basecmd + " --spider '%s'" % uri
-
-        self._runwget(ud, d, fetchcmd, True)
-
+        try:
+            f = urllib2.urlopen(uri)
+        except:
+            return False
         return True
 
     def _parse_path(self, regex, s):
-- 
1.9.1


