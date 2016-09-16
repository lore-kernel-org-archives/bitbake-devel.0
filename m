Return-Path: <akuster808@gmail.com>
Received: from mail-pa0-f67.google.com (mail-pa0-f67.google.com
	[209.85.220.67])
	by mail.openembedded.org (Postfix) with ESMTP id C6943731F9
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Sep 2016 23:36:52 +0000 (UTC)
Received: by mail-pa0-f67.google.com with SMTP id my20so995302pab.3
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Sep 2016 16:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=fYzNnOc4dvGXWWuq1iL3w3jhrLtiO2/wCxIE54bspZ0=;
	b=BnFEeJJr7idFTVcYV34u+b9/r+wezFecbuAWKCUnevkpGFXVqVMGOfZ5bmSeaG0urD
	5OXEH57/tKc68l7FRtX6Jz4vtB196cGMATJybFTwMUYum9aVh/rbjLKeaaY1CnLK66Su
	0+a4z0vvRB5KJQ8kxP2sziEyUYJPqBIgwfNQfaA7oTXK3twCXJROsGZXtV8szuW4AoXr
	Jajqw/WF+a5BBLqq03KFnPrwoA+YolEDWvquov7h4pal1ZzhRo5yxvxd9p+xJUbYlD7s
	5AqYIzDcO29HsTgtChYxddomG1odBdZXHexwK5BjRTEZ7Nw7PyiK6Yadm8uDVh+Gorf8
	gywQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=fYzNnOc4dvGXWWuq1iL3w3jhrLtiO2/wCxIE54bspZ0=;
	b=fU0x5pW2YOpy+Qp2EuNoMZ6+Ua1nn4PD512Dtmu4tRu2dklrsJ82q4j4PvLNiybt+K
	s+AYsjtgwKv/GBD+HKZHzSgYbCT9QvgmMtBFba/57Ks+3jwLeurZENm63xjYPyZNJalN
	QQ3fR93A229nowePBLMDzIYCcWcxLObW/kaNQk1K6/KPiDLti9GwwRGasTpw5lwa+2n8
	3O53SE6/lXXTNrqZ3PhciDCs+2JDD9yBB663OdNA4JlrrmUe9CbyPEZJQ7Xu4frZr4Id
	I3fL9xp73QuE3DF5N56YTClMjKZng+vFuaRyh1xXUdw+aZX4FTjH7I5F/q2xxvgW2hA2
	uGXA==
X-Gm-Message-State: AE9vXwNcqjLebkFt5nApNGtVbVulCN0xqgNG5ZSiS3pPJ+t/So//8uClvcT9gdK7Cpe/MQ==
X-Received: by 10.66.217.170 with SMTP id oz10mr27015242pac.61.1474069013460; 
	Fri, 16 Sep 2016 16:36:53 -0700 (PDT)
Received: from akuster-ThinkPad-X240.mvista.com
	([2601:202:4001:9ea0:142f:f172:55ee:c116])
	by smtp.gmail.com with ESMTPSA id q9sm8988434pfi.35.2016.09.16.16.36.51
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 16 Sep 2016 16:36:52 -0700 (PDT)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org,
	akuster808@gmail.com
Date: Fri, 16 Sep 2016 16:36:44 -0700
Message-Id: <1474069004-10786-4-git-send-email-akuster808@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1474069004-10786-1-git-send-email-akuster808@gmail.com>
References: <1474069004-10786-1-git-send-email-akuster808@gmail.com>
Subject: [PATCH 3/3] fetch2/wget: fallback to GET if HEAD is rejected in checkstatus()
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
X-List-Received-Date: Fri, 16 Sep 2016 23:36:52 -0000

From: Ross Burton <ross.burton@intel.com>

The core change here is to fall back to GET requests if HEAD is rejected in the
checkstatus() method, as you can't do a HEAD on Amazon S3 (used by Github
archives).  This meant removing the monkey patch that the default method was GET
and adding a fixed redirect handler that doesn't reset to GET.

Also, change the way the opener is constructed from an if/elif cluster to a
conditionally constructed list.

Signed-off-by: Ross Burton <ross.burton@intel.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 6ec70d5d2e330b41b932b0a655b838a5f37df01e)
Signed-off-by: Armin Kuster <akuster@mvista.com>
---
 lib/bb/fetch2/wget.py | 72 +++++++++++++++++++++++++++++++++++----------------
 lib/bb/tests/fetch.py |  2 ++
 2 files changed, 51 insertions(+), 23 deletions(-)

diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index bd2a897..0ff5b2b 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -234,38 +234,64 @@ class Wget(FetchMethod):
 
             return exported
 
-        def head_method(self):
-            return "HEAD"
-
+        class HTTPMethodFallback(urllib2.BaseHandler):
+            """
+            Fallback to GET if HEAD is not allowed (405 HTTP error)
+            """
+            def http_error_405(self, req, fp, code, msg, headers):
+                fp.read()
+                fp.close()
+
+                newheaders = dict((k,v) for k,v in req.headers.items()
+                                  if k.lower() not in ("content-length", "content-type"))
+                return self.parent.open(urllib2.Request(req.get_full_url(),
+                                                        headers=newheaders,
+                                                        origin_req_host=req.get_origin_req_host(),
+                                                        unverifiable=True))
+
+            """
+            Some servers (e.g. GitHub archives, hosted on Amazon S3) return 403
+            Forbidden when they actually mean 405 Method Not Allowed.
+            """
+            http_error_403 = http_error_405
+
+            """
+            Some servers (e.g. FusionForge) returns 406 Not Acceptable when they
+            actually mean 405 Method Not Allowed.
+            """
+            http_error_406 = http_error_405
+
+        class FixedHTTPRedirectHandler(urllib2.HTTPRedirectHandler):
+            """
+            urllib2.HTTPRedirectHandler resets the method to GET on redirect,
+            when we want to follow redirects using the original method.
+            """
+            def redirect_request(self, req, fp, code, msg, headers, newurl):
+                newreq = urllib2.HTTPRedirectHandler.redirect_request(self, req, fp, code, msg, headers, newurl)
+                newreq.get_method = lambda: req.get_method()
+                return newreq
         exported_proxies = export_proxies(d)
 
+        handlers = [FixedHTTPRedirectHandler, HTTPMethodFallback]
+        if export_proxies:
+            handlers.append(urllib2.ProxyHandler())
+        handlers.append(CacheHTTPHandler())
         # XXX: Since Python 2.7.9 ssl cert validation is enabled by default
         # see PEP-0476, this causes verification errors on some https servers
         # so disable by default.
         import ssl
-        ssl_context = None
         if hasattr(ssl, '_create_unverified_context'):
-            ssl_context = ssl._create_unverified_context()
-
-        if exported_proxies == True and ssl_context is not None:
-            opener = urllib2.build_opener(urllib2.ProxyHandler, CacheHTTPHandler,
-                    urllib2.HTTPSHandler(context=ssl_context))
-        elif exported_proxies == False and ssl_context is not None:
-            opener = urllib2.build_opener(CacheHTTPHandler,
-                    urllib2.HTTPSHandler(context=ssl_context))
-        elif exported_proxies == True and ssl_context is None:
-            opener = urllib2.build_opener(urllib2.ProxyHandler, CacheHTTPHandler)
-        else:
-            opener = urllib2.build_opener(CacheHTTPHandler)
-
-        urllib2.Request.get_method = head_method
-        urllib2.install_opener(opener)
-
-        uri = ud.url.split(";")[0]
+            handlers.append(urllib2.HTTPSHandler(context=ssl._create_unverified_context()))
+        opener = urllib2.build_opener(*handlers)
 
         try:
-            urllib2.urlopen(uri)
-        except:
+            uri = ud.url.split(";")[0]
+            r = urllib2.Request(uri)
+            r.get_method = lambda: "HEAD"
+            opener.open(r)
+        except urllib2.URLError as e:
+            # debug for now to avoid spamming the logs in e.g. remote sstate searches
+            logger.debug(2, "checkstatus() urlopen failed: %s" % e)
             return False
         return True
 
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 7a08be0..3b74de0 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -737,6 +737,8 @@ class FetchCheckStatusTest(FetcherTest):
                       "ftp://ftp.gnu.org/gnu/autoconf/autoconf-2.60.tar.gz",
                       "ftp://ftp.gnu.org/gnu/chess/gnuchess-5.08.tar.gz",
                       "ftp://ftp.gnu.org/gnu/gmp/gmp-4.0.tar.gz",
+                      # GitHub releases are hosted on Amazon S3, which doesn't support HEAD
+                      "https://github.com/kergoth/tslib/releases/download/1.1/tslib-1.1.tar.xz"
                       ]
 
     if os.environ.get("BB_SKIP_NETTESTS") == "yes":
-- 
2.7.4


