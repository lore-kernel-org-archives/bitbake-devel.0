Return-Path: <nick83ola@gmail.com>
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
	[209.85.221.68])
	by mail.openembedded.org (Postfix) with ESMTP id 9ABF27FD18
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 Dec 2019 15:06:54 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id z3so6341237wru.3
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 Dec 2019 07:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=JYR4oewYOakq4gp3S3Rl7DiQwshx300I5qbBBz9cSws=;
	b=LxB3nnk6NvkgPyKpUoBVKx+3dljPWj8Q8c4RcmOSuHIm7LhdyEJ18XhDu3kbuDVWkP
	0ZoFHa/oblwjL/EiDqwkdsozhb8oG78avjBvubEWOV+jmEwj9zIbo7aqCjiF0awUxV08
	q9+YEInyZ/XjaEuAlnaUYyUhITscnEpT97HbokZ4zaCodstwl01AL0oLn8Pl95EumVtc
	mw+/TzGzbJHv0bitoT58fj84qzPuvwdQu4k8FfCBkJFD+GmEr0QIgQO94Go7wLy/H3wV
	yvATzt5EYZfMOCPTWdCxP3SueonMiuhr7k7yE6/Kjar5O2cuItOCFx3HZ265FICuHAv6
	PHmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=JYR4oewYOakq4gp3S3Rl7DiQwshx300I5qbBBz9cSws=;
	b=ecSz0ZroDJ6kjDi3t8LecoD5v32PF7iRMA17vD6kAOwQiDTM2hs6ndjS4FnXLSipNb
	CZiRy61GJcyZwBAXAp5mgfza7CUxC6ASVvN0E6w9bApw/cw2grY35l54+aQXpW2gbrlY
	OY9+pctpysjwKHYcJJDQ6QMjJakHatqu/h3rHieYhtFWOQjfLZ+ZUKNeMkJ65U3q3Nz1
	lCtkpPqsT9WzOn1cbe0CkAGT+Dwryou1xNX1VmlsRvqxQQE/z6MqrMAfszMUyrfI5UoP
	WT+h4El8l0ML6xwoiEL0lMDkS+IXTYpjHtJMV2OVlznrNAIkAzxFMRMaSWlKzH8mcS1u
	0gAQ==
X-Gm-Message-State: APjAAAVs7uH2D3nbDpQpts3WwA2yKL0aNtUA5NeYs5fsB4Fcdv3ZAhYN
	vRd9f2cIV/OJviDpk+ZyVxYpzsOFnkA=
X-Google-Smtp-Source: APXvYqy1ncpFTULum0etOjft/OnEcjzOuTyca+LW/oMTv8ZFqroyPzykzpQMlamLwcboZdf72SuB1g==
X-Received: by 2002:a5d:4651:: with SMTP id j17mr10400874wrs.237.1576768015174;
	Thu, 19 Dec 2019 07:06:55 -0800 (PST)
Received: from nick-bbestie.garage.tyco.com ([77.107.218.170])
	by smtp.gmail.com with ESMTPSA id
	s128sm6542189wme.39.2019.12.19.07.06.54
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Thu, 19 Dec 2019 07:06:54 -0800 (PST)
From: Nicola Lunghi <nick83ola@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 19 Dec 2019 15:06:38 +0000
Message-Id: <20191219150638.31858-1-nick83ola@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Subject: [PATCH 1/2] bitbake: fetch2/wget: checkstatus: cleanup URLError exception
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
X-List-Received-Date: Thu, 19 Dec 2019 15:06:56 -0000
Content-Transfer-Encoding: 8bit

The exception for urllib.error.URLError can only happen on the

  with opener.open(r) as response:

line.
Limit the try except span to this line and move the retry logic of
commit 312f1a5e741 outside of the try/except catch

see also commit:
  312f1a5e741: bitbake: fetchption: attempt checkstatus again if it fails

Signed-off-by: Nicola Lunghi <nick83ola@gmail.com>
---
 bitbake/lib/bb/fetch2/wget.py | 60 +++++++++++++++++------------------
 1 file changed, 29 insertions(+), 31 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/wget.py b/bitbake/lib/bb/fetch2/wget.py
index 90aa9b190a..180fe9aacd 100644
--- a/bitbake/lib/bb/fetch2/wget.py
+++ b/bitbake/lib/bb/fetch2/wget.py
@@ -375,42 +375,40 @@ class Wget(FetchMethod):
             handlers.append(urllib.request.HTTPSHandler(context=ssl._create_unverified_context()))
         opener = urllib.request.build_opener(*handlers)
 
-        try:
-            uri = ud.url.split(";")[0]
-            r = urllib.request.Request(uri)
-            r.get_method = lambda: "HEAD"
-            # Some servers (FusionForge, as used on Alioth) require that the
-            # optional Accept header is set.
-            r.add_header("Accept", "*/*")
-            def add_basic_auth(login_str, request):
-                '''Adds Basic auth to http request, pass in login:password as string'''
-                import base64
-                encodeuser = base64.b64encode(login_str.encode('utf-8')).decode("utf-8")
-                authheader = "Basic %s" % encodeuser
-                r.add_header("Authorization", authheader)
-
-            if ud.user and ud.pswd:
-                add_basic_auth(ud.user + ':' + ud.pswd, r)
+        uri = ud.url.split(";")[0]
+        r = urllib.request.Request(uri)
+        r.get_method = lambda: "HEAD"
+        # Some servers (FusionForge, as used on Alioth) require that the
+        # optional Accept header is set.
+        r.add_header("Accept", "*/*")
+        def add_basic_auth(login_str, request):
+            '''Adds Basic auth to http request, pass in login:password as string'''
+            import base64
+            encodeuser = base64.b64encode(login_str.encode('utf-8')).decode("utf-8")
+            authheader = "Basic %s" % encodeuser
+            r.add_header("Authorization", authheader)
+
+        if ud.user and ud.pswd:
+            add_basic_auth(ud.user + ':' + ud.pswd, r)
 
-            try:
-                import netrc
-                n = netrc.netrc()
-                login, unused, password = n.authenticators(urllib.parse.urlparse(uri).hostname)
-                add_basic_auth("%s:%s" % (login, password), r)
-            except (TypeError, ImportError, IOError, netrc.NetrcParseError):
-                pass
+        try:
+            import netrc
+            n = netrc.netrc()
+            login, unused, password = n.authenticators(urllib.parse.urlparse(uri).hostname)
+            add_basic_auth("%s:%s" % (login, password), r)
+        except (TypeError, ImportError, IOError, netrc.NetrcParseError):
+            pass
 
+        try:
             with opener.open(r) as response:
                 pass
+            return True
         except urllib.error.URLError as e:
-            if try_again:
-                logger.debug(2, "checkstatus: trying again")
-                return self.checkstatus(fetch, ud, d, False)
-            else:
-                # debug for now to avoid spamming the logs in e.g. remote sstate searches
-                logger.debug(2, "checkstatus() urlopen failed: %s" % e)
-                return False
-        return True
+            logger.debug(2, "checkstatus() urlopen failed: %s" % e)
+        if try_again:
+            logger.debug(2, "checkstatus: trying again")
+            return self.checkstatus(fetch, ud, d, False)
+        return False
 
     def _parse_path(self, regex, s):
         """
-- 
2.20.1


