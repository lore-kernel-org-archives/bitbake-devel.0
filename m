Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
	[209.85.128.50])
	by mail.openembedded.org (Postfix) with ESMTP id 3ACDB6C24B
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 13 Nov 2018 22:59:48 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id p2-v6so12961883wmc.2
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 13 Nov 2018 14:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id;
	bh=gzrRG+YcjmwwF1T/ARJlZzGCvicg+0p8DvhDeqmq5Bk=;
	b=WS2XrlUYi1kZUdZ4z1uJUQCy4B7Goaou3/fnQLns0imUdxlUAzyMxysEH17K1oWvMJ
	BQwxyupMAmtr7yEffu0o2fbTprMikGMFsZpSXySy3O6layfTGSxWMX0ijQ/euGXXOWSz
	rH2CWgSl54ERIwrrOmVdxJEoJi3QQcpOCTJB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id;
	bh=gzrRG+YcjmwwF1T/ARJlZzGCvicg+0p8DvhDeqmq5Bk=;
	b=Clj8GHL/MFPSjy3nTuDS/oqTmIQDxPFDumcy/5wC1nlhisnTP34399OdtcltH6ZjHE
	XStTaa8MwVOK1WgBO5AKQtGMcjio4yMWZkDm4Njrvg5JppAkpFXVMiPrpyS4oDw4kDUF
	cIJKWwVnVSi2YSIuHDPcs7GsJifczQx1sNsRQOZQlgaRhdENl9V0rlXwWnlVUn0JxAIs
	hs/KKRpaJmme8Ain5VQUr7M+D1kFSu1GdxSyvhmMnDcOkPPe1VxC4fj7OIghwIye660U
	hpHJ414EviKcnqP5AK6G++ST/jkLIP8PA4WHodryDR3BBaCaQMLKSiyzktCvCNP71LEx
	g4xw==
X-Gm-Message-State: AGRZ1gK8HJH/vDpezoBMlGCgRssv3H0QifHePrOaA1cW/+PiR9zuord3
	Ug78gVqkmnBNbqA/k7B0Zv2Y9a93jR4=
X-Google-Smtp-Source: AJdET5czREuV9+BQdfdy97ch5JrkUU71H+6b+RCqh38zPNOT+geQa3rzro3Igt9WqNxO18ZFt+8Zbw==
X-Received: by 2002:a1c:e2c2:: with SMTP id
	z185-v6mr4979201wmg.94.1542149988186; 
	Tue, 13 Nov 2018 14:59:48 -0800 (PST)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	r1sm22417109wrx.15.2018.11.13.14.59.47
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 13 Nov 2018 14:59:47 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 13 Nov 2018 22:59:45 +0000
Message-Id: <20181113225946.17829-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
Subject: [PATCH 1/2] utils: Avoid warnings about deprecated imp module
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
X-List-Received-Date: Tue, 13 Nov 2018 22:59:48 -0000

The imp module is deprecated, port the code over to use importlib.

bitbake/lib/bb/utils.py:30: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/utils.py | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 73b6cb423b..1cadbc5bcd 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -27,7 +27,7 @@ import bb
 import bb.msg
 import multiprocessing
 import fcntl
-import imp
+import importlib
 import itertools
 import subprocess
 import glob
@@ -43,7 +43,7 @@ from contextlib import contextmanager
 from ctypes import cdll
 
 logger = logging.getLogger("BitBake.Util")
-python_extensions = [e for e, _, _ in imp.get_suffixes()]
+python_extensions = importlib.machinery.all_suffixes()
 
 
 def clean_context():
@@ -1544,12 +1544,9 @@ def export_proxies(d):
 def load_plugins(logger, plugins, pluginpath):
     def load_plugin(name):
         logger.debug(1, 'Loading plugin %s' % name)
-        fp, pathname, description = imp.find_module(name, [pluginpath])
-        try:
-            return imp.load_module(name, fp, pathname, description)
-        finally:
-            if fp:
-                fp.close()
+        spec = importlib.machinery.PathFinder.find_spec(name, path=[pluginpath] )
+        if spec:
+            return spec.loader.load_module()
 
     logger.debug(1, 'Loading plugins from %s...' % pluginpath)
 
-- 
2.17.1


