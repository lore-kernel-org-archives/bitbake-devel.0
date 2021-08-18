Received: from smtpout.cvg.de (smtpout.cvg.de [87.128.211.67])
 by mx.groups.io with SMTP id smtpd.web09.57693.1629306996240706492
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 18 Aug 2021 10:16:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sigma-chemnitz.de header.s=v2012061000 header.b=K8vAJiP5;
 spf=pass (domain: sigma-chemnitz.de, ip: 87.128.211.67, mailfrom: enrico.scholz@sigma-chemnitz.de)
Received: from mail-mta-3.intern.sigma-chemnitz.de (mail-mta-3.intern.sigma-chemnitz.de [192.168.12.71])
	by mail-out-2.intern.sigma-chemnitz.de (8.16.1/8.16.1) with ESMTPS id 17IHGWpk532130
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
	for <bitbake-devel@lists.openembedded.org>; Wed, 18 Aug 2021 19:16:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sigma-chemnitz.de;
	s=v2012061000; t=1629306993;
	bh=lJhpVvJQI+4NMHQVTexFXfKDMWbiZ33QwR/sPnJyHrs=; l=4078;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K8vAJiP58OQDoNWwX/vNj4yL1yFTz6ksGoyHA39VknLxQPFCYoxTqts6jnYm7Ofa8
	 3JAWaz41hUFGKovgLE1gBGVRXrAyPIZDBNgR1AjC76FAe3hD6ovBX5vmlYzTW/NUvD
	 Uls2xrkwjdaBY12JOnkSXuemqH/8hFAbcqZ8rQ3E=
Received: from reddoxx.intern.sigma-chemnitz.de ([192.168.16.32])
	by mail-mta-3.intern.sigma-chemnitz.de (8.16.1/8.16.1) with ESMTP id 17IHGPZ31278466
	for <bitbake-devel@lists.openembedded.org> from enrico.scholz@sigma-chemnitz.de; Wed, 18 Aug 2021 19:16:25 +0200
Received: from mail-msa-3.intern.sigma-chemnitz.de ( [192.168.12.73]) by reddoxx.intern.sigma-chemnitz.de
	(Reddoxx engine) with SMTP id 3AD0F4A797E; Wed, 18 Aug 2021 19:16:24 +0200
Received: from ensc-virt.intern.sigma-chemnitz.de (ensc-virt.intern.sigma-chemnitz.de [192.168.3.24])
	by mail-msa-3.intern.sigma-chemnitz.de (8.15.2/8.15.2) with ESMTPS id 17IHGNBG569081
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 18 Aug 2021 19:16:24 +0200
Received: from ensc by ensc-virt.intern.sigma-chemnitz.de with local (Exim 4.94.2)
	(envelope-from <ensc@sigma-chemnitz.de>)
	id 1mGPAt-001hdP-HL; Wed, 18 Aug 2021 19:16:23 +0200
From: "Enrico Scholz" <enrico.scholz@sigma-chemnitz.de>
To: bitbake-devel@lists.openembedded.org
Cc: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
Subject: [PATCH, v2] fetch2/wget: fix 'no_proxy' handling
Date: Wed, 18 Aug 2021 19:16:22 +0200
Message-Id: <20210818171622.406009-1-enrico.scholz@sigma-chemnitz.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210818171000.233428-1-enrico.scholz@sigma-chemnitz.de>
References: <20210818171000.233428-1-enrico.scholz@sigma-chemnitz.de>
MIME-Version: 1.0
Sender: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
Content-Transfer-Encoding: 8bit

The urllib.request.ProxyHandler constructor only reads the $http_proxy
+ $https_proxy environment variables.

$no_proxy is evaluated later when the url is opened.

It is therefore not sufficient to just construct the proxy handler in
the

|        with bb.utils.environment(**newenv):

context, but the 'opener.open(r)' call must also be made there.

Signed-off-by: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
---
 lib/bb/fetch2/wget.py | 87 ++++++++++++++++++++++---------------------
 1 file changed, 44 insertions(+), 43 deletions(-)

diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index 29fcfbb3d14d..9a49e64a0054 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -330,50 +330,51 @@ class Wget(FetchMethod):
                         urllib.request.HTTPSHandler(context=context)]
             opener = urllib.request.build_opener(*handlers)
 
-        try:
-            uri = ud.url.split(";")[0]
-            r = urllib.request.Request(uri)
-            r.get_method = lambda: "HEAD"
-            # Some servers (FusionForge, as used on Alioth) require that the
-            # optional Accept header is set.
-            r.add_header("Accept", "*/*")
-            r.add_header("User-Agent", self.user_agent)
-            def add_basic_auth(login_str, request):
-                '''Adds Basic auth to http request, pass in login:password as string'''
-                import base64
-                encodeuser = base64.b64encode(login_str.encode('utf-8')).decode("utf-8")
-                authheader = "Basic %s" % encodeuser
-                r.add_header("Authorization", authheader)
-
-            if ud.user and ud.pswd:
-                add_basic_auth(ud.user + ':' + ud.pswd, r)
-
             try:
-                import netrc
-                n = netrc.netrc()
-                login, unused, password = n.authenticators(urllib.parse.urlparse(uri).hostname)
-                add_basic_auth("%s:%s" % (login, password), r)
-            except (TypeError, ImportError, IOError, netrc.NetrcParseError):
-                pass
-
-            with opener.open(r) as response:
-                pass
-        except urllib.error.URLError as e:
-            if try_again:
-                logger.debug2("checkstatus: trying again")
-                return self.checkstatus(fetch, ud, d, False)
-            else:
-                # debug for now to avoid spamming the logs in e.g. remote sstate searches
-                logger.debug2("checkstatus() urlopen failed: %s" % e)
-                return False
-        except ConnectionResetError as e:
-            if try_again:
-                logger.debug2("checkstatus: trying again")
-                return self.checkstatus(fetch, ud, d, False)
-            else:
-                # debug for now to avoid spamming the logs in e.g. remote sstate searches
-                logger.debug2("checkstatus() urlopen failed: %s" % e)
-                return False
+                uri = ud.url.split(";")[0]
+                r = urllib.request.Request(uri)
+                r.get_method = lambda: "HEAD"
+                # Some servers (FusionForge, as used on Alioth) require that the
+                # optional Accept header is set.
+                r.add_header("Accept", "*/*")
+                r.add_header("User-Agent", self.user_agent)
+                def add_basic_auth(login_str, request):
+                    '''Adds Basic auth to http request, pass in login:password as string'''
+                    import base64
+                    encodeuser = base64.b64encode(login_str.encode('utf-8')).decode("utf-8")
+                    authheader = "Basic %s" % encodeuser
+                    r.add_header("Authorization", authheader)
+
+                if ud.user and ud.pswd:
+                    add_basic_auth(ud.user + ':' + ud.pswd, r)
+
+                try:
+                    import netrc
+                    n = netrc.netrc()
+                    login, unused, password = n.authenticators(urllib.parse.urlparse(uri).hostname)
+                    add_basic_auth("%s:%s" % (login, password), r)
+                except (TypeError, ImportError, IOError, netrc.NetrcParseError):
+                    pass
+
+                with opener.open(r) as response:
+                    pass
+            except urllib.error.URLError as e:
+                if try_again:
+                    logger.debug2("checkstatus: trying again")
+                    return self.checkstatus(fetch, ud, d, False)
+                else:
+                    # debug for now to avoid spamming the logs in e.g. remote sstate searches
+                    logger.debug2("checkstatus() urlopen failed: %s" % e)
+                    return False
+            except ConnectionResetError as e:
+                if try_again:
+                    logger.debug2("checkstatus: trying again")
+                    return self.checkstatus(fetch, ud, d, False)
+                else:
+                    # debug for now to avoid spamming the logs in e.g. remote sstate searches
+                    logger.debug2("checkstatus() urlopen failed: %s" % e)
+                    return False
+
         return True
 
     def _parse_path(self, regex, s):
-- 
2.31.1

