Received: from smtpout.cvg.de (smtpout.cvg.de [87.128.211.67])
 by mx.groups.io with SMTP id smtpd.web11.57404.1629306623167777868
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 18 Aug 2021 10:10:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sigma-chemnitz.de header.s=v2012061000 header.b=QnLWvp7m;
 spf=pass (domain: sigma-chemnitz.de, ip: 87.128.211.67, mailfrom: enrico.scholz@sigma-chemnitz.de)
Received: from mail-mta-3.intern.sigma-chemnitz.de (mail-mta-3.intern.sigma-chemnitz.de [192.168.12.71])
	by mail-out-3.intern.sigma-chemnitz.de (8.16.1/8.16.1) with ESMTPS id 17IHAJgV492807
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
	for <bitbake-devel@lists.openembedded.org>; Wed, 18 Aug 2021 19:10:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sigma-chemnitz.de;
	s=v2012061000; t=1629306619;
	bh=uKYwWgxRvakiQZJQ1Q0zEO1aro/fu5fTR+9s3eEEK2A=; l=4061;
	h=From:To:Cc:Subject:Date;
	b=QnLWvp7mpmgtlQVYXZb/faYkM7cWQizfV9YAz0hnc0owyJcA/y/QUD/XhxdZAQuKC
	 FIJzkJ+Jv46IIFaQ8qmZFaUuStmsgAMFsZAYJE9hAJiWHmug78RDHPDn0HcK3jE3Be
	 D8AUUErSMEB7ngTRvNVG/n7Z7c0RYLqaWF+bNeIY=
Received: from reddoxx.intern.sigma-chemnitz.de ([192.168.16.32])
	by mail-mta-3.intern.sigma-chemnitz.de (8.16.1/8.16.1) with ESMTP id 17IHACc21278404
	for <bitbake-devel@lists.openembedded.org> from enrico.scholz@sigma-chemnitz.de; Wed, 18 Aug 2021 19:10:12 +0200
Received: from mail-msa-2.intern.sigma-chemnitz.de ( [192.168.12.72]) by reddoxx.intern.sigma-chemnitz.de
	(Reddoxx engine) with SMTP id 46D5CAD09B3; Wed, 18 Aug 2021 19:10:10 +0200
Received: from ensc-virt.intern.sigma-chemnitz.de (ensc-virt.intern.sigma-chemnitz.de [192.168.3.24])
	by mail-msa-2.intern.sigma-chemnitz.de (8.16.1/8.16.1) with ESMTPS id 17IHAA1F592556
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 18 Aug 2021 19:10:10 +0200
Received: from ensc by ensc-virt.intern.sigma-chemnitz.de with local (Exim 4.94.2)
	(envelope-from <ensc@sigma-chemnitz.de>)
	id 1mGP4r-000zJY-Va; Wed, 18 Aug 2021 19:10:10 +0200
From: "Enrico Scholz" <enrico.scholz@sigma-chemnitz.de>
To: bitbake-devel@lists.openembedded.org
Cc: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
Subject: [PATCH] fetch2/wget: fix 'no_proxy' handling
Date: Wed, 18 Aug 2021 19:10:00 +0200
Message-Id: <20210818171000.233428-1-enrico.scholz@sigma-chemnitz.de>
X-Mailer: git-send-email 2.31.1
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
 lib/bb/fetch2/wget.py | 85 ++++++++++++++++++++++---------------------
 1 file changed, 43 insertions(+), 42 deletions(-)

diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index 29fcfbb3d14d..659e54a80b14 100644
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
                 return False
+
         return True
 
     def _parse_path(self, regex, s):
-- 
2.31.1

