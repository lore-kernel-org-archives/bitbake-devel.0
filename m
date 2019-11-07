Return-Path: <ross.burton@intel.com>
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
	[209.85.128.44])
	by mail.openembedded.org (Postfix) with ESMTP id 267F17F362
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  7 Nov 2019 23:57:38 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id c22so4442682wmd.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 07 Nov 2019 15:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=quzsb1QzmHVZRkTjXr4XnWs8b07KG+FAEDWsYoh3wqc=;
	b=Iku2P53S/Adp8ugDsAFhcYq8MKf6E5DJSAwnbIype8TH9ssz2mk9feSm2ZMWwBMBgX
	NQi6WwOBW20ocb+kASaI8zsIRvUiaOsw+QXCJ4WSR419dIaU+7mCh1LxJnfLnztkc7Lj
	2Vjk3lNY9RwAmmnBxXPK0u9rIlHTeO4CGGO6iy9WTyFdCZIvwwDrJzKXcjL43HiLUJ8u
	NTfvSVXdF9ltk3yDeaJque9YlwmEtK5Q4/gK44FUwxdvs11+91L0/LmlrUY3b3a/2wUj
	8UAUFwmAN2SLGageXnZQOWkXWnhCTGkmCvdhTrTGe1nI9zYukdsT1OcJ1AR41ho3nTOG
	BuMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=quzsb1QzmHVZRkTjXr4XnWs8b07KG+FAEDWsYoh3wqc=;
	b=cw/QryVNDXdF0nz5pbCyrMs6x/E5bRDUsur+oOtclKsXkN5T6TAcJ3Hz80vIWcpda+
	uXETaG9brxpsaks+IpOBsPFYVthNspY5qM3tBGvqxgPaq1d5J7d/5e9AtqeABi2Jxhm/
	8Rf1iYZuirbsGFyZ8fZoqABP3Q0Fb2j5SzdXKxSoR7/fAAc0ne+pBx1C5Me7vTHZYt/w
	AnJCPYPArktCrnY3uRDmZTnU92LcT83gR9Zcis3jKCUPFq6NSXF37G11U+q5fKUHjpkb
	wgTCrxTCCmyCJYz3uU3pKFgktLAX3GbDG/Bn4Wk9h6viri6uJYe/cxx2FVchgKAynest
	z3mQ==
X-Gm-Message-State: APjAAAWW0IIuPb4Uc9DZEDJJghV0Nde+2GZFqq17/LlepInH2Wm57svd
	CpD58qpgxuYX55aduk4U0/uaG1A/t/8=
X-Google-Smtp-Source: APXvYqy/VDnahoZSxgi0Iu10rE3/AYJN+aU49EjcYln6CSsfBsTSayoe0Oq2aVO7u7bgU7VUMBYWfA==
X-Received: by 2002:a1c:f317:: with SMTP id q23mr5249161wmq.97.1573171058661; 
	Thu, 07 Nov 2019 15:57:38 -0800 (PST)
Received: from flashheart.burtonini.com (35.106.2.81.in-addr.arpa.
	[81.2.106.35]) by smtp.gmail.com with ESMTPSA id
	n17sm3626275wrp.40.2019.11.07.15.57.37
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Thu, 07 Nov 2019 15:57:38 -0800 (PST)
From: Ross Burton <ross.burton@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  7 Nov 2019 23:57:33 +0000
Message-Id: <20191107235733.25853-2-ross.burton@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191107235733.25853-1-ross.burton@intel.com>
References: <20191107235733.25853-1-ross.burton@intel.com>
MIME-Version: 1.0
Subject: [PATCH 2/2] utils: also use mmap for SHA256 and SHA1, for performance
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
X-List-Received-Date: Thu, 07 Nov 2019 23:57:38 -0000
Content-Transfer-Encoding: 8bit

md5_file() uses a mmap() window to improve performance when hashing files, so
refactor the code and do the same for SHA1 and SHA256.

Signed-off-by: Ross Burton <ross.burton@intel.com>
---
 bitbake/lib/bb/utils.py | 34 ++++++++++++++--------------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/bitbake/lib/bb/utils.py b/bitbake/lib/bb/utils.py
index d035949b3d6..8d40bcdf836 100644
--- a/bitbake/lib/bb/utils.py
+++ b/bitbake/lib/bb/utils.py
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
2.20.1


