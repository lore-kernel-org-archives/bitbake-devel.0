Return-Path: <anibal.limon@linaro.org>
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com
	[209.85.167.182])
	by mail.openembedded.org (Postfix) with ESMTP id 432817D2AE
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Nov 2019 14:47:25 +0000 (UTC)
Received: by mail-oi1-f182.google.com with SMTP id e9so8798642oif.8
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Nov 2019 06:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=CmjHgm49Abq3CmO3eDxruSCzh6uIaPi+Lzzsq8oxKbg=;
	b=qrEiyZNECwwtCi48WdL996udyk2cl/dv5o2dItFeAP7N44pLfjy2uR+KGwCTnNFirj
	3dqOXXuZL06b8hF/YxhuOQqh4YjHPrIgCYwYk9vV9SUxE40kXHWYU9kRVUHFOa/JuEEm
	U8CbtybDeAWZqBDR63rymQ2pb+DMAMm0JQ3VwmMpEXWiImZuvF9hWWyy/9UBUzIuC5H2
	QhbpydKALG/BAkKleUduqlDTM++rFLN0hiPLOOwJd9F+TWPMY0D5cYlGyth2dYiyNqul
	kZEm/n6GV3b0cka7dNObInIRT1mKE0+pcc05m1ZGZEliWfV5cI7k3a3lypUxzDlESRcr
	dPlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=CmjHgm49Abq3CmO3eDxruSCzh6uIaPi+Lzzsq8oxKbg=;
	b=Uprvxovq6hkeTKpZqPLNBziLvjWDC02SfPjcNkHS/ojNygCR7F9O+Y0t48mpzNHOSt
	+hVMsvwbE6318GVz951q1DCW4XKE1Ow396Glqb8+CtoXoFXnN9xYxy3bLbBYbsCjTc9C
	8gYR14ybRyN1u8r7jyj22qRsfX4z7Ms+e/L8ynGAbmOJSYeDzlTX64eS6SPJmjEwnYow
	R/qSmlHy0MhlfLUfeI/7J6miflKbyo4R1YwmIIklsmvkrUDqeeIRsG9N7WjNbCpY50Ey
	SjVw0qN4ZlrIVt0uMtF9o7MhGaB4d60QdmVYhQfwR+itw3Q/KCGnJGtodCa3eemAQs9x
	6G2A==
X-Gm-Message-State: APjAAAXY6Mx1A0Feaax3un+3gNPIkBhJDdbl+cFA8UYW6L4u9Mw9d1uj
	iDngOngb5wwlopPUEKB+ue3RV2vs4IQ=
X-Google-Smtp-Source: APXvYqzpZwQW1mu47yTTfQUxUPSS0cw1uoyp2kVykh/BcfjTsaHKwV/Ojyf+BuwXm9RJt0Hp/ZttLQ==
X-Received: by 2002:a05:6808:8e9:: with SMTP id
	d9mr7803527oic.29.1573829246589; 
	Fri, 15 Nov 2019 06:47:26 -0800 (PST)
Received: from blackbox.rga.ip ([2806:109f:4:a26c:908a:c7ff:fe6a:e9f5])
	by smtp.gmail.com with ESMTPSA id t2sm2930271otm.75.2019.11.15.06.47.25
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Fri, 15 Nov 2019 06:47:26 -0800 (PST)
From: =?UTF-8?q?An=C3=ADbal=20Lim=C3=B3n?= <anibal.limon@linaro.org>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 15 Nov 2019 08:47:23 -0600
Message-Id: <20191115144723.7452-1-anibal.limon@linaro.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Subject: [PATCHv2] lib/bb: Add BB_SIGNATURE_LOCAL_DIRS_EXCLUDE to speed-up taskhash on directories
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
X-List-Received-Date: Fri, 15 Nov 2019 14:47:26 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The new BB_SIGNATURE_LOCAL_DIRS_EXCLUDE allows you to specify a list
of directories to exclude when making taskhash, our specific case
is using SRC_URI that points local VCS directory.

Use bb.fetch.module to set default to: "CVS .bzr .git .hg .osc .p4 .repo .svn"

Signed-off-by: Aníbal Limón <anibal.limon@linaro.org>
---
 lib/bb/checksum.py        | 5 +++--
 lib/bb/fetch2/__init__.py | 4 ++--
 lib/bb/siggen.py          | 5 +++--
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/lib/bb/checksum.py b/lib/bb/checksum.py
index 5bc8a8fc..677020f4 100644
--- a/lib/bb/checksum.py
+++ b/lib/bb/checksum.py
@@ -74,7 +74,7 @@ class FileChecksumCache(MultiProcessCache):
             else:
                 dest[0][h] = source[0][h]
 
-    def get_checksums(self, filelist, pn):
+    def get_checksums(self, filelist, pn, localdirsexclude):
         """Get checksums for a list of files"""
 
         def checksum_file(f):
@@ -90,7 +90,8 @@ class FileChecksumCache(MultiProcessCache):
             if pth == "/":
                 bb.fatal("Refusing to checksum /")
             dirchecksums = []
-            for root, dirs, files in os.walk(pth):
+            for root, dirs, files in os.walk(pth, topdown=True):
+                [dirs.remove(d) for d in list(dirs) if d in localdirsexclude]
                 for name in files:
                     fullpth = os.path.join(root, name)
                     checksum = checksum_file(fullpth)
diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 07de6c26..731c1608 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1197,14 +1197,14 @@ def get_checksum_file_list(d):
 
     return " ".join(filelist)
 
-def get_file_checksums(filelist, pn):
+def get_file_checksums(filelist, pn, localdirsexclude):
     """Get a list of the checksums for a list of local files
 
     Returns the checksums for a list of local files, caching the results as
     it proceeds
 
     """
-    return _checksum_cache.get_checksums(filelist, pn)
+    return _checksum_cache.get_checksums(filelist, pn, localdirsexclude)
 
 
 class FetchData(object):
diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index a4bb1ff7..2445a340 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -123,6 +123,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
 
         self.unihash_cache = bb.cache.SimpleCache("1")
         self.unitaskhashes = self.unihash_cache.init_cache(data, "bb_unihashes.dat", {})
+        self.localdirsexclude = (data.getVar("BB_SIGNATURE_LOCAL_DIRS_EXCLUDE") or "CVS .bzr .git .hg .osc .p4 .repo .svn").split()
 
     def init_rundepcheck(self, data):
         self.taskwhitelist = data.getVar("BB_HASHTASK_WHITELIST") or None
@@ -221,9 +222,9 @@ class SignatureGeneratorBasic(SignatureGenerator):
 
         if task in dataCache.file_checksums[fn]:
             if self.checksum_cache:
-                checksums = self.checksum_cache.get_checksums(dataCache.file_checksums[fn][task], recipename)
+                checksums = self.checksum_cache.get_checksums(dataCache.file_checksums[fn][task], recipename, self.localdirsexclude)
             else:
-                checksums = bb.fetch2.get_file_checksums(dataCache.file_checksums[fn][task], recipename)
+                checksums = bb.fetch2.get_file_checksums(dataCache.file_checksums[fn][task], recipename, self.localdirsexclude)
             for (f,cs) in checksums:
                 self.file_checksum_values[tid].append((f,cs))
                 if cs:
-- 
2.24.0


