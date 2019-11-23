Return-Path: <akuster808@gmail.com>
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com
	[209.85.216.67])
	by mail.openembedded.org (Postfix) with ESMTP id 123B87F7CD
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 23 Nov 2019 16:25:06 +0000 (UTC)
Received: by mail-pj1-f67.google.com with SMTP id a16so4505401pjs.13
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 23 Nov 2019 08:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=qNW2oMhoh1ooC1l3VW9xrspqw2ifN79ISbOmet8Nnc0=;
	b=NrAH0wJXjN54jE+UwPpR3DleYdD3wypAm6jzYY1Yo7N00Sl1vzgCJx1Abrbd0tJ/tF
	TsBm94dllD6e4ljDrjdLl/A2UXQFi0+FmyVPix8Gkk3Ut/HefP36cQKDLyW1t2RrhlOe
	Sccbz05OvFy/WK71XUjX0aGV5YUBTE4opFfOkf3c1MfPvTwoQrjCF+6qgEDk0MnOFKfX
	Z6pbf5Z+tHqR7vHD47CkghqTSUMyYxoIcgGVna36UnBsRewLumhbycWj8dWJWE9T+QHl
	ohcKxc9IQ2dgiVmUNVHCgLBisEA2LRsSp6Y94wCMZzBk0hzmkcmP9Lre3KJGgvx3tHjM
	tXMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=qNW2oMhoh1ooC1l3VW9xrspqw2ifN79ISbOmet8Nnc0=;
	b=N6cJ2ST4B2JmHpSUE5EvqVp13AYdgQp4EK+K8le0J37yHRWQDlJnTRjXCMWmRtKOI+
	aR4aU0SUzQhXiUoqiNIYMfg9gYqfStDyRwiOgZc04T6ybZtvwrrU0uucow3isWLosAod
	1FFZZUPQhL7kHzU5Dn3V5NPCYa8/BqPe2zXQHUAbt2LH2FrXMSMUrO7qvWIElM7PG+Ts
	K246sVvx2C9LtLLdMtVtjvRKwA15r7nqrUn8TdBNfEgfGV419iI/4WiUmndjWYiiP/ye
	t1ltPI4kNMpJqEnPtuvL1f4B8j2Jlz+uAaIXKYLX0YqccMRyCFmMAmVNdlmdGb+MupSQ
	wCAQ==
X-Gm-Message-State: APjAAAXSUEJsgQ03wu2TJZEroFD4XzKgiM9u/zqwR0ZNqiE8wMyj1OPH
	6whl1Bkn6yRoyVRQDqPEMFEgXDR4
X-Google-Smtp-Source: APXvYqwaAgxEZW17o8/61k5zkrAJO7H8kVLIUN97XHGS3TpL7weW5quiP1k7efudUZoVSz24daalow==
X-Received: by 2002:a17:90a:9705:: with SMTP id
	x5mr25960223pjo.37.1574526307915; 
	Sat, 23 Nov 2019 08:25:07 -0800 (PST)
Received: from akuster-ThinkPad-T460s.hsd1.ca.comcast.net
	([2601:202:4180:a5c0:d5a1:4623:137e:d439])
	by smtp.gmail.com with ESMTPSA id h9sm2735572pjh.8.2019.11.23.08.25.07
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sat, 23 Nov 2019 08:25:07 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 23 Nov 2019 08:24:57 -0800
Message-Id: <1574526299-21018-7-git-send-email-akuster808@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574526299-21018-1-git-send-email-akuster808@gmail.com>
References: <1574526299-21018-1-git-send-email-akuster808@gmail.com>
Subject: [1.44][PATCH 7/9] utils: also use mmap for SHA256 and SHA1, for performance
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
X-List-Received-Date: Sat, 23 Nov 2019 16:25:07 -0000

From: Ross Burton <ross.burton@intel.com>

md5_file() uses a mmap() window to improve performance when hashing files, so
refactor the code and do the same for SHA1 and SHA256.

Signed-off-by: Ross Burton <ross.burton@intel.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 lib/bb/utils.py | 34 ++++++++++++++--------------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index d035949..8d40bcd 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -520,22 +520,26 @@ def unlockfile(lf):
     fcntl.flock(lf.fileno(), fcntl.LOCK_UN)
     lf.close()
 
-def md5_file(filename):
-    """
-    Return the hex string representation of the MD5 checksum of filename.
-    """
-    import hashlib, mmap
+def _hasher(method, filename):
+    import mmap
 
     with open(filename, "rb") as f:
-        m = hashlib.md5()
         try:
             with mmap.mmap(f.fileno(), 0, access=mmap.ACCESS_READ) as mm:
                 for chunk in iter(lambda: mm.read(8192), b''):
-                    m.update(chunk)
+                    method.update(chunk)
         except ValueError:
             # You can't mmap() an empty file so silence this exception
             pass
-    return m.hexdigest()
+    return method.hexdigest()
+
+
+def md5_file(filename):
+    """
+    Return the hex string representation of the MD5 checksum of filename.
+    """
+    import hashlib
+    return _hasher(hashlib.md5(), filename)
 
 def sha256_file(filename):
     """
@@ -543,24 +547,14 @@ def sha256_file(filename):
     filename.
     """
     import hashlib
-
-    s = hashlib.sha256()
-    with open(filename, "rb") as f:
-        for line in f:
-            s.update(line)
-    return s.hexdigest()
+    return _hasher(hashlib.sha256(), filename)
 
 def sha1_file(filename):
     """
     Return the hex string representation of the SHA1 checksum of the filename
     """
     import hashlib
-
-    s = hashlib.sha1()
-    with open(filename, "rb") as f:
-        for line in f:
-            s.update(line)
-    return s.hexdigest()
+    return _hasher(hashlib.sha1(), filename)
 
 def preserved_envvars_exported():
     """Variables which are taken from the environment and placed in and exported
-- 
2.7.4


