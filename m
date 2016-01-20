Return-Path: <ross.burton@intel.com>
Received: from mail-wm0-f42.google.com (mail-wm0-f42.google.com [74.125.82.42])
	by mail.openembedded.org (Postfix) with ESMTP id 0C62C73190
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Jan 2016 17:22:26 +0000 (UTC)
Received: by mail-wm0-f42.google.com with SMTP id b14so40776847wmb.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Jan 2016 09:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:subject:date:message-id;
	bh=GXhIDg/YcY8AjgKesXvnSymIBnemDumFha47PrfgqGk=;
	b=vlNtnXJhuCrbPFQEuwQOV2b+Nb3yWd/66zd9F8KextV2zhSCV/cIOqJdPFK3v2xXCc
	geih6zCqOt0w9iUvk5lKqf8OhvFqLgzi18Z/xt8PltzIuw/fQLqoc2T9nCEExSUdEN1c
	yrryG8rlV+zI0Y6R7g2nQT4dZzXJ7edNx/ej3gkQpwDkaOksOcrBRE1ouLpyf9j2Cwz+
	GKgDg6F4T7A84ufGmKfkMf6V93tdh5FVwPBa0y24Fq9b9O361ORSitqnvVtEC1ED7uHk
	YsXqW1eCspQhXRoSw/9Q9Mb1p+gtfHJPwLKANc8CzaksPiTcuxmtfu1e+Oa0ljMmCXLy
	HADQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:subject:date:message-id;
	bh=GXhIDg/YcY8AjgKesXvnSymIBnemDumFha47PrfgqGk=;
	b=PLpym30JqRIbYOtUN+9tFUfcgbqR5MjBAMxj2QPhbF0Vc2ii2q3CYVSsv36ys03IIp
	+QteDHoOGu4yPvM6rMRzHx4jbhlXRa6DQCPo4GA83J1tatsJs1K1MtwG+KKrbo2Jq3fX
	/A+XsYjnGI1+5d0iJITHFFWVqIgM2U84NXmKcwspksh7nzI4WtkBda/MvlbVDHX52tw4
	pJ5c2+ofvMVUfND3j7jY79a2K/F4mZfvr4uTYMm1/Aue8jkV4xhAebDDKGIxsT74bDHQ
	mv6UJYMMM/M4JhKUQ0wI4/W4oHiVgi03K7WN3myO9t2M2OOfic+iFTSepr+u47pO0sxo
	cBrA==
X-Gm-Message-State: AG10YORXRIzYYtW0/B9RTN4K+kZcKf1q3T3V6heGiQXnCOIvy4T7qVU5ElM1RrobCivQs9WG
X-Received: by 10.28.217.74 with SMTP id q71mr5235616wmg.68.1453310546365;
	Wed, 20 Jan 2016 09:22:26 -0800 (PST)
Received: from flashheart.burtonini.com (35.106.2.81.in-addr.arpa.
	[81.2.106.35]) by smtp.gmail.com with ESMTPSA id
	g187sm26065748wmf.8.2016.01.20.09.22.25
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 20 Jan 2016 09:22:25 -0800 (PST)
From: Ross Burton <ross.burton@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 20 Jan 2016 17:22:20 +0000
Message-Id: <1453310540-30615-1-git-send-email-ross.burton@intel.com>
X-Mailer: git-send-email 2.6.4
Subject: [PATCH][V2] fetch2/wget: fallback to GET if HEAD is rejected in checkstatus()
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
X-List-Received-Date: Wed, 20 Jan 2016 17:22:27 -0000

The core change here is to fall back to GET requests if HEAD is rejected in the
checkstatus() method, as you can't do a HEAD on Amazon S3 (used by Github
archives).  This meant removing the monkey patch that the default method was GET
and adding a fixed redirect handler that doesn't reset to GET.

Also, change the way the opener is constructed from an if/elif cluster to a
conditionally constructed list.

Signed-off-by: Ross Burton <ross.burton@intel.com>
---
 bitbake/lib/bb/fetch2/wget.py | 71 +++++++++++++++++++++++++++++--------------
 1 file changed, 48 insertions(+), 23 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/wget.py b/bitbake/lib/bb/fetch2/wget.py
index c8c6d5c..1f884b3 100644
--- a/bitbake/lib/bb/fetch2/wget.py
+++ b/bitbake/lib/bb/fetch2/wget.py
@@ -235,38 +235,63 @@ class Wget(FetchMethod):
 
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
+            bb.warn("checkstatus() urlopen failed: %s" % e)
             return False
         return True
 
-- 
2.6.4


