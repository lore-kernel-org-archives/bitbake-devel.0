Return-Path: <ross.burton@intel.com>
Received: from mail-wm0-f52.google.com (mail-wm0-f52.google.com [74.125.82.52])
	by mail.openembedded.org (Postfix) with ESMTP id C894177029
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 26 Jan 2016 20:31:42 +0000 (UTC)
Received: by mail-wm0-f52.google.com with SMTP id l65so120139755wmf.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 26 Jan 2016 12:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:subject:date:message-id;
	bh=ULPeKXEpO9RHvBdS8G+JKUhip9LNbZZ54FjD8SH9I4E=;
	b=HuPV/VN1+XDl/mOWTCsyZaBl/JZ3h0W+3LgMlLZteGmpKLkNPfKA1JFubhryYi2Mis
	4hZwen42KSE0Zgji8R5NLYg/IECAliNuwIh7nkuev6M4HXT9dgFubD/ili7ynDgqUJzT
	XaE2dM2NztOYfL2asI4xwWheEAi4apn3d/0zgu21JGTwequZLv0U0LSiEMWE53w5Fxq5
	XmyEfkYVLrPT2YDXxgHSuSw58wfQxN0r7x8byEJUB/MpLGfW5drNhmnupuv1Vzyq0bZ1
	r3bXdLkkEJTSjGDdPK2nrOHce53ex1jCZ4LEhvJRaYCTOCxLWj5j8T5t/jMNWXpuRUU3
	NWoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:subject:date:message-id;
	bh=ULPeKXEpO9RHvBdS8G+JKUhip9LNbZZ54FjD8SH9I4E=;
	b=kI8miGFCtyNos5x1otXa6uLgZHFaRJWQLoLoiimZx2/8Mh6cIprMmRyo4+kYPd96+k
	SIrReySk6tTZt4/FwV4w/OJN9GEHehYdDWtyAUVr1fu5Jjw+iLghA/ppTHMkoM3MScBM
	AwtXHsZ26xKSClUEffj9umaxlM43AqyzVDVh1tauaYa06aa7kmeHXu54EwRa5DMA5P6A
	aZ07lf3+0rg2KgAeDji7TwD9s5An//aKcIRJnuNgHUBu0uSOb67YevwB/CC8mbGBk5Q7
	tKTq/rJrychquOAoyTULraQGo8yDE7QPPRgLqLHx9CVWZg5NaeUpWJqO5iSmO+mg1qOs
	w3CA==
X-Gm-Message-State: AG10YOQjJp4AiGCLOdjce+YVN+rsSDDlV7nTTPjC1G7RS8cUajxrwa+7lG2zDDIag6aK2TQd
X-Received: by 10.194.82.163 with SMTP id j3mr12315500wjy.70.1453840302850;
	Tue, 26 Jan 2016 12:31:42 -0800 (PST)
Received: from flashheart.burtonini.com (35.106.2.81.in-addr.arpa.
	[81.2.106.35])
	by smtp.gmail.com with ESMTPSA id o7sm2965479wjf.45.2016.01.26.12.31.41
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 26 Jan 2016 12:31:41 -0800 (PST)
From: Ross Burton <ross.burton@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 26 Jan 2016 20:31:37 +0000
Message-Id: <1453840297-1287-1-git-send-email-ross.burton@intel.com>
X-Mailer: git-send-email 2.6.4
Subject: [PATCH][V3] fetch2/wget: fallback to GET if HEAD is rejected in checkstatus()
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
X-List-Received-Date: Tue, 26 Jan 2016 20:31:43 -0000

The core change here is to fall back to GET requests if HEAD is rejected in the
checkstatus() method, as you can't do a HEAD on Amazon S3 (used by Github
archives).  This meant removing the monkey patch that the default method was GET
and adding a fixed redirect handler that doesn't reset to GET.

Also, change the way the opener is constructed from an if/elif cluster to a
conditionally constructed list.

Signed-off-by: Ross Burton <ross.burton@intel.com>
---
 bitbake/lib/bb/fetch2/wget.py | 72 +++++++++++++++++++++++++++++--------------
 bitbake/lib/bb/tests/fetch.py |  2 ++
 2 files changed, 51 insertions(+), 23 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/wget.py b/bitbake/lib/bb/fetch2/wget.py
index c8c6d5c..5a31730 100644
--- a/bitbake/lib/bb/fetch2/wget.py
+++ b/bitbake/lib/bb/fetch2/wget.py
@@ -235,38 +235,64 @@ class Wget(FetchMethod):
 
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
 
diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.py
index b175a43..81b22d0 100644
--- a/bitbake/lib/bb/tests/fetch.py
+++ b/bitbake/lib/bb/tests/fetch.py
@@ -738,6 +738,8 @@ class FetchCheckStatusTest(FetcherTest):
                       "ftp://ftp.gnu.org/gnu/autoconf/autoconf-2.60.tar.gz",
                       "ftp://ftp.gnu.org/gnu/chess/gnuchess-5.08.tar.gz",
                       "ftp://ftp.gnu.org/gnu/gmp/gmp-4.0.tar.gz",
+                      # GitHub releases are hosted on Amazon S3, which doesn't support HEAD
+                      "https://github.com/kergoth/tslib/releases/download/1.1/tslib-1.1.tar.xz"
                       ]
 
     if os.environ.get("BB_SKIP_NETTESTS") == "yes":
-- 
2.6.4


