Return-Path: <nick83ola@gmail.com>
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
	[209.85.128.65])
	by mail.openembedded.org (Postfix) with ESMTP id 599D57F9A7
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  6 Jan 2020 10:31:01 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id m24so14444443wmc.3
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 06 Jan 2020 02:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=eLSZ9TFBa5+9WzyFxrPAlH8MdpCC4HZSettpfvmo5Xg=;
	b=tXk5cxCufKU/cgP1MXY6OOmwY2VPm/ERBHHPyE0x/EmsYleeR/ua0+LtuUP0I0k+B0
	5gWl+p3UbueyWzn8kSXZBm+GLIv8xehXJiyNU6XjFZzgomiyLzfC7MDhtinydBiCYs55
	B7s1j1KO1qAGiwU82uwuWO9FtEBGkiqi/a395asSKfGMOEMdKdDJwC3F48xLMXKIy3Uk
	A0hQvKMA5YJi4pQkhuUIi2W+SRcFLG60bfByXZKb+xPkhn+QJwDYqsOkYGkQQOxoU07s
	qGCTz6LjWn85f3KK/9k54aYoHS5hS7gnZp28Zvv3deka1AqiUxAuw34qaCFf7LE1GhUY
	baFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=eLSZ9TFBa5+9WzyFxrPAlH8MdpCC4HZSettpfvmo5Xg=;
	b=t4IneBadiwXQ87ScOlUKwgma6zOXKppt/o54T2kmc24HlgG+TiZ1qyRA0bKhWjLvol
	SPXg33YW2oAj+pmrZPc5+SiHWFSeYjxDlDEt7hR8aRkTaz9XAsjbCnUhTjWYxAOWu0Vd
	gugpUSaUlrkYn8+PJvmmqRKsEa4TWxP3Zevzs9hno93PFMdApTQWMqtgoIOHoG0z51Nz
	+amtn8iTEpdwqsoWEVs2T/E2BAvkTmvabqjWnAUu+fus1I4jS3fN/YMI0al/KUI/alHB
	P6TiwvvNJE4h4JUqgsF6dPo0uaEFJsYe4EUyV6Og+s3P4hQR3DsoJ2/suhwRqQssEfsT
	iMOQ==
X-Gm-Message-State: APjAAAVbeRYu5TbBjSJFIq3e4auYLBNgsquvQBnuMvFXC5gE0UdcwqpF
	s60juLcE+5Hle1I8EBGltKlJWnX2lvc=
X-Google-Smtp-Source: APXvYqx47zrdihD06kV20U/r4OaCxIJu801uVF7tAIgc+0co8VeOHr73SZ6WOw/lvh/5tZxmKx2iZw==
X-Received: by 2002:a1c:3803:: with SMTP id f3mr34827323wma.134.1578306661580; 
	Mon, 06 Jan 2020 02:31:01 -0800 (PST)
Received: from nick-bbestie.garage.tyco.com ([77.107.218.170])
	by smtp.gmail.com with ESMTPSA id
	g25sm23670600wmh.3.2020.01.06.02.31.00
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Mon, 06 Jan 2020 02:31:00 -0800 (PST)
From: Nicola Lunghi <nick83ola@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  6 Jan 2020 10:30:39 +0000
Message-Id: <20200106103039.34321-1-nick83ola@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Subject: [OE-core][PATCH v2 REPOST 1/2] bitbake: fetch2/wget: checkstatus: cleanup URLError exception
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
X-List-Received-Date: Mon, 06 Jan 2020 10:31:01 -0000
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
index 725586d2b5..5aef55a9c6 100644
--- a/bitbake/lib/bb/fetch2/wget.py
+++ b/bitbake/lib/bb/fetch2/wget.py
@@ -295,42 +295,40 @@ class Wget(FetchMethod):
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
 
-            try:
-                import netrc
-                n = netrc.netrc()
-                login, unused, password = n.authenticators(urllib.parse.urlparse(uri).hostname)
-                add_basic_auth("%s:%s" % (login, password), r)
-            except (TypeError, ImportError, IOError, netrc.NetrcParseError):
-                pass
+        if ud.user and ud.pswd:
+            add_basic_auth(ud.user + ':' + ud.pswd, r)
 
+        try:
+            import netrc
+            n = netrc.netrc()
+            login, unused, password = n.authenticators(urllib.parse.urlparse(uri).hostname)
+            add_basic_auth("%s:%s" % (login, password), r)
+        except (TypeError, ImportError, IOError, netrc.NetrcParseError):
+            pass
+
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


