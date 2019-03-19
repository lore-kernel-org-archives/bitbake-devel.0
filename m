Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
	[209.85.221.43])
	by mail.openembedded.org (Postfix) with ESMTP id AB9C56B96C
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Mar 2019 15:30:06 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id o1so2316518wrs.13
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Mar 2019 08:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=zYJ9QgHIdqnlXZ4X/8ew66skOAIqFO0Aur2GfYInR8c=;
	b=OvD3mFmRuX0ECOnd0SXN9luTeDaBZHMKqY0LEztzdD0e3wJd+8yQ2j8WUz9tJDtFt4
	7h/Sl8A8IkG98XLssWhHABKRO2t6NO+fxE12qcypbAwgzfOR2hZ/V6gO5ykOcgfMku4n
	YWc6uFC8/RiAB7UHp/HnobrmnH1RUvV3sploI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=zYJ9QgHIdqnlXZ4X/8ew66skOAIqFO0Aur2GfYInR8c=;
	b=lf0ths63nehD7EdzLRGWaadVJ0INe+xOtnVWxAvRWOJ2se/udyoU+80STw9aAh4TiT
	7YAx64+3dukBha7+8haoTVyOCKy/+LSuAXLigqj09vnPfRI6tHJYj2y+RrcT8aD7CPLX
	BRKUOzzGJWKTvackPMmB/P9khlfIPpjHDFSRJBAELobXQp4+fEi1aFUVUxz3Be/7Uuo+
	ntgIuJXcglabJ+uMo7yJezoZgKEWvIckPC5dpDzYslIFpeH9a9X1027afCCpO12HCzft
	iDoCkoHHWgScnJYnPvEH6pUFtutW1Qdxbj4pK8vO5WzjnYN3lZJ0oSQeA37AC9s2BRwg
	cYvQ==
X-Gm-Message-State: APjAAAVuXuRANtJPJRUPBs7BnrrzDsFU2ppzT7WfGpsvud/vmvramp0E
	TbwqiyxJodTfoSS0VbOw882YgaFy7B7lBw==
X-Google-Smtp-Source: APXvYqyXkvsHCFJLPd66I4fkLJarPqPFo2w0Gl0K3327uEqT4tLSeBydn5Dihq+jbEsqh6SGlJ0MKw==
X-Received: by 2002:adf:e90b:: with SMTP id f11mr17840531wrm.36.1553009407180; 
	Tue, 19 Mar 2019 08:30:07 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	g8sm14446149wrw.22.2019.03.19.08.30.05
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 19 Mar 2019 08:30:06 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 19 Mar 2019 15:30:00 +0000
Message-Id: <20190319153002.17984-3-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190319153002.17984-1-richard.purdie@linuxfoundation.org>
References: <20190319153002.17984-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 3/5] fetch2/wget: Clean up whitespace/comments
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
X-List-Received-Date: Tue, 19 Mar 2019 15:30:07 -0000
Content-Transfer-Encoding: 8bit

Clean up the whitespace and comments style, keep pylint happy.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/wget.py | 32 +++++++++++++-------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index 24ffd22186..f86047a93e 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -184,7 +184,7 @@ class Wget(FetchMethod):
                 # request.
 
                 # Don't close connection when connection_cache is enabled,
-                if fetch.connection_cache is None: 
+                if fetch.connection_cache is None:
                     headers["Connection"] = "close"
                 else:
                     headers["Connection"] = "Keep-Alive" # Works for HTTP/1.0
@@ -270,17 +270,16 @@ class Wget(FetchMethod):
                 fp.read()
                 fp.close()
 
-                newheaders = dict((k,v) for k,v in list(req.headers.items())
+                newheaders = dict((k, v) for k, v in list(req.headers.items())
                                   if k.lower() not in ("content-length", "content-type"))
                 return self.parent.open(urllib.request.Request(req.get_full_url(),
                                                         headers=newheaders,
                                                         origin_req_host=req.origin_req_host,
                                                         unverifiable=True))
 
-            """
-            Some servers (e.g. GitHub archives, hosted on Amazon S3) return 403
-            Forbidden when they actually mean 405 Method Not Allowed.
-            """
+
+            # Some servers (e.g. GitHub archives, hosted on Amazon S3) return 403
+            # Forbidden when they actually mean 405 Method Not Allowed.
             http_error_403 = http_error_405
 
 
@@ -299,7 +298,7 @@ class Wget(FetchMethod):
         if exported_proxies:
             handlers.append(urllib.request.ProxyHandler())
         handlers.append(CacheHTTPHandler())
-        # XXX: Since Python 2.7.9 ssl cert validation is enabled by default
+        # Since Python 2.7.9 ssl cert validation is enabled by default
         # see PEP-0476, this causes verification errors on some https servers
         # so disable by default.
         import ssl
@@ -318,7 +317,7 @@ class Wget(FetchMethod):
                 '''Adds Basic auth to http request, pass in login:password as string'''
                 import base64
                 encodeuser = base64.b64encode(login_str.encode('utf-8')).decode("utf-8")
-                authheader =  "Basic %s" % encodeuser
+                authheader = "Basic %s" % encodeuser
                 r.add_header("Authorization", authheader)
 
             if ud.user and ud.pswd:
@@ -330,7 +329,7 @@ class Wget(FetchMethod):
                 login, unused, password = n.authenticators(urllib.parse.urlparse(uri).hostname)
                 add_basic_auth("%s:%s" % (login, password), r)
             except (TypeError, ImportError, IOError, netrc.NetrcParseError):
-                 pass
+                pass
 
             with opener.open(r) as response:
                 pass
@@ -395,18 +394,14 @@ class Wget(FetchMethod):
         (oldpn, oldpv, oldsuffix) = old
         (newpn, newpv, newsuffix) = new
 
-        """
-        Check for a new suffix type that we have never heard of before
-        """
-        if (newsuffix):
+        # Check for a new suffix type that we have never heard of before
+        if newsuffix:
             m = self.suffix_regex_comp.search(newsuffix)
             if not m:
                 bb.warn("%s has a possible unknown suffix: %s" % (newpn, newsuffix))
                 return False
 
-        """
-        Not our package so ignore it
-        """
+        # Not our package so ignore it
         if oldpn != newpn:
             return False
 
@@ -472,10 +467,9 @@ class Wget(FetchMethod):
 
         return ""
 
-    def _check_latest_version_by_dir(self, dirver, package, package_regex,
-            current_version, ud, d):
+    def _check_latest_version_by_dir(self, dirver, package, package_regex, current_version, ud, d):
         """
-            Scan every directory in order to get upstream version.
+        Scan every directory in order to get upstream version.
         """
         version_dir = ['', '', '']
         version = ['', '', '']
-- 
2.20.1


