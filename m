Return-Path: <ross.burton@intel.com>
Received: from mail-wm0-f51.google.com (mail-wm0-f51.google.com [74.125.82.51])
	by mail.openembedded.org (Postfix) with ESMTP id 53E4B6072C
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Jan 2016 13:14:25 +0000 (UTC)
Received: by mail-wm0-f51.google.com with SMTP id 123so132241792wmz.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Jan 2016 05:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id;
	bh=thm8l+xtofNQ5s6Hd5XZ9r13XbVFVfcRT6oh8k1jzWY=;
	b=qCKNt1f4k9cyNvhKtAjokSLEK3TrAA2eSDbTVTaJTy/TcdaKZooQlXlXHqxBVG0lhi
	f3HXjMxmVjQdO0kFAhTytIbqjxAgtrk5JD0i5Xz8bkiCxIfV+iT8a4JICUc4aXzzrXAI
	4ix4u3q5pL2TX++4FoySFGNPKcJVV87xXzJJq4K+Z9C0AJ0MVB07CaIxWeZEewq6c6kq
	Y7+3eYcS/wXoxpGWmEDSMzR74YEa1HmFjWCCixsPJgqgPzkRf43pw9Yl31v7WBfudo0s
	sq3WBZn8R21HY8ORjb0IqqDLZT0J6iRTXTqbaORgAQ93idwsz/ZFEshckHkvpfrG32YG
	Fc0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=thm8l+xtofNQ5s6Hd5XZ9r13XbVFVfcRT6oh8k1jzWY=;
	b=ZqAoAbr0vkvGLw3VYZTbtuzXKPXD67qFtqEr6QHNXivmYX4NnT++K2yAzjkuA61gei
	bj+IoMOCRfPrARmP9NOK0UYWzPGiarVO9YYN5lqsEz6DNgcKXFGxcivBxSCBSzsMfAxt
	1bOQqe6CPrb7LGgpIdeOCnj4qdm5KJ9p/vv/Mb4tzkquZrtiyVne7FHuh/kfopUTTwru
	3hbFpJII5qGr0n3W8mZu6r3UWHeuKFUEWDKo4259TDAg2ojwP0sNeBQBpNOBB6JJjXUm
	OJYIAD2nFVZ7HP/QxuZyqheG+YysG7aph4UhVfrZXa1BljKl1ydExZADUaPziY3pisiJ
	kVOQ==
X-Gm-Message-State: ALoCoQkAZJkQh69YCSpkPh1nBy75jhT+L+KABVrQgdZ+Jrp3+0cgO12WE1cXiL/hP+wjRhvOaa+pQOA8TsZ/3G2N8B29T+THqg==
X-Received: by 10.194.22.132 with SMTP id d4mr36276990wjf.174.1453295666395;
	Wed, 20 Jan 2016 05:14:26 -0800 (PST)
Received: from flashheart.burtonini.com (35.106.2.81.in-addr.arpa.
	[81.2.106.35]) by smtp.gmail.com with ESMTPSA id
	cb2sm1142671wjc.16.2016.01.20.05.14.25
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 20 Jan 2016 05:14:25 -0800 (PST)
From: Ross Burton <ross.burton@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 20 Jan 2016 13:14:22 +0000
Message-Id: <1453295662-13333-1-git-send-email-ross.burton@intel.com>
X-Mailer: git-send-email 2.6.4
Subject: [PATCH] fetch2/wget: fallback to GET if HEAD is rejected in checkstatus()
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
X-List-Received-Date: Wed, 20 Jan 2016 13:14:28 -0000

The core change here is to fall back to GET requests if HEAD is rejected in the
checkstatus() method, as you can't do a HEAD on Amazon S3 (used by Github
archives).  This meant removing the monkey patch that the default method was GET
and adding a fixed redirect handler that doesn't reset to GET.

Also, change the way the opener is constructed from an if/elif cluster to a
conditionally constructed list.

Signed-off-by: Ross Burton <ross.burton@intel.com>
---
 bitbake/lib/bb/fetch2/wget.py | 65 ++++++++++++++++++++++++++++---------------
 1 file changed, 42 insertions(+), 23 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/wget.py b/bitbake/lib/bb/fetch2/wget.py
index c8c6d5c..dafa068 100644
--- a/bitbake/lib/bb/fetch2/wget.py
+++ b/bitbake/lib/bb/fetch2/wget.py
@@ -235,38 +235,57 @@ class Wget(FetchMethod):
 
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


