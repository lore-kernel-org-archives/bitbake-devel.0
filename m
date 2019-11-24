Return-Path: <akuster808@gmail.com>
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com
	[209.85.210.196])
	by mail.openembedded.org (Postfix) with ESMTP id 475D87F67E
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 24 Nov 2019 23:43:32 +0000 (UTC)
Received: by mail-pf1-f196.google.com with SMTP id 3so6315464pfb.10
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 24 Nov 2019 15:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=qNW2oMhoh1ooC1l3VW9xrspqw2ifN79ISbOmet8Nnc0=;
	b=OzOdmEXpGLk8xJyeUUwya8P7HzDMSvXxMDlRhbGYIYZHNUzW7bGxvomdPbLOcC7eSq
	Is8NNyYQGnGdDAe3gSECP/RR3CY6oZygRKQB043FBoGeFhokx+oO0PBfzUJqZdoSDLHq
	sI3htk3bQNaubhnJ2xOhK5OQf+ISQvj3TbxQRKhNHXxCyalShhVetNeygxoeK6T0b0lR
	oL3uKeP19QgS8z357b2/zdp8EWANf6DXsitVPHlp8+opi1kumtMx6lpM83l+tEj1i7qc
	lk3yIJdDf5ht2SIOmvNKDZtU0WpKkb1Fpl/picsB/jc5GQOrFmwlG19bLTJUjMjVq+Rv
	br9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=qNW2oMhoh1ooC1l3VW9xrspqw2ifN79ISbOmet8Nnc0=;
	b=Yd17DdJ6Kdqff846gc0p4oRR+WV0pGgQiQZ5w7Tc+Z059iDHvUoovmkk4IKElgP3lE
	mO1syO3jEN6EAQ4/4ntFlkA+0VeCXzYhcVTidfoBqetJHdhirrCnF2LrqIjx+g7PWc4i
	oPShnWekokyQy5P+APeleC67kQDU80B5klxiyIjqkF2XuOcE5MINt/LMBvkN/WBjAWCb
	ub4KTRzQiHsdZBMQUgFEYDYG8QuYS/8TJfhN7KqawhXK++igcVABVvAKfhe5qKZB5zAd
	QwG3R88BEXUMpUQpZ4z3fS0TxaGXYL3XSS4GH2abrao0c3MoHyKI0lJ401edKCywVSX7
	SY8g==
X-Gm-Message-State: APjAAAUqyQxv6EXjllxgYtDcPJlej4IF+J2bZOTUFZz/LIgv+FmfYm8A
	Wdt65qysgeYgS/dy6x1gicJPsf4e
X-Google-Smtp-Source: APXvYqyRMS1fS830gJEnr2m9DUkjfejsBlJjs3J1m3sRm20BBVU1WA4Ddlqhoeer1Ll0RKwP+dNvdw==
X-Received: by 2002:aa7:8256:: with SMTP id e22mr31087029pfn.247.1574639013462;
	Sun, 24 Nov 2019 15:43:33 -0800 (PST)
Received: from akuster-ThinkPad-T460s.hsd1.ca.comcast.net
	([2601:202:4180:a5c0:69ac:e4d2:e89f:98da])
	by smtp.gmail.com with ESMTPSA id
	125sm5729367pfu.136.2019.11.24.15.43.32
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sun, 24 Nov 2019 15:43:32 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sun, 24 Nov 2019 15:43:20 -0800
Message-Id: <94ede642dce8cdbf09f566e3f7e9e260d33fda27.1574638886.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1574638886.git.akuster808@gmail.com>
References: <cover.1574638886.git.akuster808@gmail.com>
Subject: [PATCH 7/9] utils: also use mmap for SHA256 and SHA1, for performance
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
X-List-Received-Date: Sun, 24 Nov 2019 23:43:33 -0000

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


