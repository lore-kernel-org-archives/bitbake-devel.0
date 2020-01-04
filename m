Return-Path: <akuster808@gmail.com>
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
	[209.85.215.176])
	by mail.openembedded.org (Postfix) with ESMTP id 4C0EA7F894
	for <bitbake-devel@lists.openembedded.org>;
	Sat,  4 Jan 2020 02:23:30 +0000 (UTC)
Received: by mail-pg1-f176.google.com with SMTP id q127so24195852pga.4
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 03 Jan 2020 18:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=2PQFLTpft4I4RHmYaiSVuS4s4wdizbv7+pRw3yKbcHg=;
	b=tjY5yJLNCewuSNbpFl+RQdZLiq8H49Xy5vZyuAOp3S96Ga0btq8CliLgWHCoJsM8fm
	GZnQObybGlywDUbhQVYgLQxkII5iCPIfyCN4+0/Yk35IigN9LRPAACGUwR3E30+DfUvZ
	KZJdhf49bi+86+Xnne6KsOZvx5PSKRYfUS6aJU4I0WcM4SbG+QmBDb/FZruXIOpgVK3r
	7GjDB/BzPJxadJ/7dvJ2V28/Hgw6S0wMiypBAVvYbMNfU2Kj9cmNG8JBKbig7sprz4HB
	Bb9oNHPHVz1bsUfl1VB9tQ9TLnV7P7CNNJLw0p7hkCvDaT9fkBmpZkq/9ns4x0f1uIoi
	JXBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=2PQFLTpft4I4RHmYaiSVuS4s4wdizbv7+pRw3yKbcHg=;
	b=MADR6nmzHFtg1vpwJoxPyHhMjRY4AxxTEfD/yxiMAGI4Ag8f/cv5FiNbvFSC/ikWbK
	UZop2z6j/IRVmyNySYEYeCY/wsRN962U43+3RRJuVh7nhedZNaFFSLYUVwfjIdB27Bgk
	bWohOys7aZqquLkf1i5HsThJsO01/sgY1mbfYhV8PZPqRAKjVNjQLaUuAQDdPjIB5RiZ
	GCtLDSpgj9Mvf9sZmzEx6XhJ+6xL1V0g+r9vG2H6NiSOmY+tY3LJuH3cQDBtKbG6oUpc
	EOIYyqnKhXVSVo+0DesLXOSmqLDU2FgHO+1HaWArGRcJJhMvwq4v2DsTBfa7buIHuBB3
	lLuQ==
X-Gm-Message-State: APjAAAXWuWKSagFUYDHbfkwsmIQZJKpo3IfHlnRuy1SPpKhdaD0ORUea
	4aePpyv3N4PAH01icPojPkW6agRoszY=
X-Google-Smtp-Source: APXvYqyZ/yZBl3Y01SnZJJnhVsIQjKLU0iI3+RyNP/14e09WtwLTJQh5rBFLXGDrlfD+pUZeyZ5bRw==
X-Received: by 2002:a63:5f45:: with SMTP id t66mr96561516pgb.198.1578104611369;
	Fri, 03 Jan 2020 18:23:31 -0800 (PST)
Received: from akuster-ThinkPad-T460s.mvista.com
	([2601:202:4180:a5c0:e812:6764:3882:fa62])
	by smtp.gmail.com with ESMTPSA id
	s11sm58830590pfd.157.2020.01.03.18.23.30
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Fri, 03 Jan 2020 18:23:31 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  3 Jan 2020 18:23:04 -0800
Message-Id: <4c7d689341f471efdf8ab7c2a7c6a19d2d370f5c.1578104305.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1578104305.git.akuster808@gmail.com>
References: <cover.1578104305.git.akuster808@gmail.com>
MIME-Version: 1.0
Subject: [PATCH 19/25] lib/bb: Add BB_SIGNATURE_LOCAL_DIRS_EXCLUDE to speed-up taskhash on directories
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
X-List-Received-Date: Sat, 04 Jan 2020 02:23:30 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Aníbal Limón <anibal.limon@linaro.org>

The new BB_SIGNATURE_LOCAL_DIRS_EXCLUDE allows you to specify a list
of directories to exclude when making taskhash, our specific case
is using SRC_URI that points local VCS directory.

Use bb.fetch.module to set default to: "CVS .bzr .git .hg .osc .p4 .repo .svn"

Signed-off-by: Aníbal Limón <anibal.limon@linaro.org>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 923aff060d8aba8456979c35b16d300ba7c13ff9)
Signed-off-by: Armin Kuster <akuster808@gmail.com>
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
index e484e5e3..f982bf22 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -126,6 +126,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
 
         self.unihash_cache = bb.cache.SimpleCache("1")
         self.unitaskhashes = self.unihash_cache.init_cache(data, "bb_unihashes.dat", {})
+        self.localdirsexclude = (data.getVar("BB_SIGNATURE_LOCAL_DIRS_EXCLUDE") or "CVS .bzr .git .hg .osc .p4 .repo .svn").split()
 
     def init_rundepcheck(self, data):
         self.taskwhitelist = data.getVar("BB_HASHTASK_WHITELIST") or None
@@ -222,9 +223,9 @@ class SignatureGeneratorBasic(SignatureGenerator):
 
         if task in dataCache.file_checksums[fn]:
             if self.checksum_cache:
-                checksums = self.checksum_cache.get_checksums(dataCache.file_checksums[fn][task], recipename)
+                checksums = self.checksum_cache.get_checksums(dataCache.file_checksums[fn][task], recipename, self.localdirsexclude)
             else:
-                checksums = bb.fetch2.get_file_checksums(dataCache.file_checksums[fn][task], recipename)
+                checksums = bb.fetch2.get_file_checksums(dataCache.file_checksums[fn][task], recipename, self.localdirsexclude)
             for (f,cs) in checksums:
                 self.file_checksum_values[tid].append((f,cs))
 
-- 
2.17.1


