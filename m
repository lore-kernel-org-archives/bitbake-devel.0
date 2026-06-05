Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C60CCD6E7C
	for <webhook@archiver.kernel.org>; Fri,  5 Jun 2026 22:12:53 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5972.1780697563263236895
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Jun 2026 15:12:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=wlZwCZi0;
 spf=pass (domain: smile.fr, ip: 209.85.221.52, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-45efa80e0afso1844142f8f.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 05 Jun 2026 15:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1780697562; x=1781302362; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ogLWri3rXVVY3NE9hPz9ea7ZKs0uTgP/N5Q/GLUwReg=;
        b=wlZwCZi0l8F2bBRQDc5+yu9l2SPH2uvI/hzvNVtp5U5j2ozTEnwI+AimkBiVF9B0XZ
         S7t/DnkSsLMMPYANmFKAJ9tdv5pLWFZsrObQqmm4KtHHhoMtHsq251iMgBc1WIilLldx
         rby+k0xXJKckNWak7oHkaOVjYn5iACq2BTGts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780697562; x=1781302362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ogLWri3rXVVY3NE9hPz9ea7ZKs0uTgP/N5Q/GLUwReg=;
        b=dPxeIZjIySlYLo1j/YS7brAKOe7SYyFFZ/869hZ2EQSuXxz2AkvJF745WxV737u4tg
         fo9htVYM7bQinhVQdf06YBQ7GuGo9KHt+amFCOFLss5hwTdPyUBEMMbTKzDz9DeDfAwW
         tEehkJ4eftEvi+zCI3l7rF6lElq47LNDbgYmdjcl5wUA3qumdOmmkkKdqiOkHxW77aev
         pmcuKMWHrkEZ6RBiRHFdGmOPIQpcfVZePprBCTO5PT5AOQEjpzOG7NJ7oVuCjaB/K5u9
         Iyesux7SOBqGNOaGf2Q76GBmKd3Lx625rZzPjrFvPtFym6cW7KlakuhwL80H9CaOAhZg
         dInw==
X-Gm-Message-State: AOJu0Yzw/dRah6c4tgDAiAm6jI4obJQmBuHQKmVt493BC55JuDiFe7C6
	u7XSHOaGW1wx4qsEAbg49xwkKQQeVpmlQGK9K1OeNiqIvXJAl3IHHU/yhm6Qc4DFnThki3b2iov
	IzBpm
X-Gm-Gg: Acq92OE6uUscWWBfeSezE0GFHGS29KBz7v109QjFDTIWuBWzGrPOcxAkKnskTjvGfOV
	zp90bMp9qYllcGA3IwXPww/F6A3z8SU74Vx5vSbyvYo+H2dd4k434PVDEiuP0rXSUtAZLNQksFH
	iTHC/o+HgIFTr3OKT53SEP1NisHYrveU0sBFbcVzbOZdpi0v2NqdmXMojAP8tErkDzGSNF9iGPT
	uYz1b172pEY9e5bbBEGoHqjCxWyNPBTruVk+IaoZ/n6lXTjur1YBIspPxEmtmVRBI6uWGjWgtUl
	OGgLfHS+r4V5f19BwE5yrRx2CUebaWMI/40EJTQxgNAbVYj8g1vkkA2pUNmjWslsWZ6wLFLKC9I
	sMhDwoOOcVyjTp0f+xsneUjyceD1//ifNzMhTOBora9i/weeHjzUdiYgj5qJYnskliqehYkxX0H
	jyaoi/nZ+cVqt7T96wwJlfnrE0Y+u8yqz9QL1MXVWuFYjchJ3mi3rAO2pBE8Autak5JLu0TdrEV
	gYUsTnmM9o3c1pC3B27AgX61Mu1fnqZwFVTAiZggtvHvXkRow==
X-Received: by 2002:adf:f911:0:b0:439:c18f:5aaf with SMTP id ffacd0b85a97d-460307625cbmr6553797f8f.34.1780697561609;
        Fri, 05 Jun 2026 15:12:41 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00b3e1ccc1be2b2798.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:b3e1:ccc1:be2b:2798])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcae2sm30770393f8f.6.2026.06.05.15.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 15:12:41 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [bitbake][scarthgap][2.8][PATCH 1/4] fetch2: validate deb/ipk data member names
Date: Sat,  6 Jun 2026 00:12:25 +0200
Message-ID: <a32064d0f10b9f5a163a25f410a4e39dccf9cb93.1780697470.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1780697470.git.yoann.congal@smile.fr>
References: <cover.1780697470.git.yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 05 Jun 2026 22:12:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19622

From: Anders Heimer <anders.heimer@est.tech>

The deb/ipk unpack path selects a data archive member from 'ar -t'
output and then passes that member name to a shell command. Previously,
any member beginning with data.tar. was selected.

Only select known deb/ipk data archive member names when datafile is
created. Quote the package path used in the shell command as it can come
from the local fetch path.

Add local fetcher regression coverage for quoted package filenames,
valid compressed data members, and unsupported or unsafe data member
names.

Signed-off-by: Anders Heimer <anders.heimer@est.tech>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 73ae3a2447ec93df39bc66cf3d8f9b2ea1bfe3bf)
Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 lib/bb/fetch2/__init__.py | 10 +++++---
 lib/bb/tests/fetch.py     | 53 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+), 3 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 224408de0..2f54cb86e 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -23,6 +23,7 @@ import collections
 import subprocess
 import pickle
 import errno
+import shlex
 import bb.persist_data, bb.utils
 import bb.checksum
 import bb.process
@@ -1567,16 +1568,19 @@ class FetchMethod(object):
             elif file.endswith('.deb') or file.endswith('.ipk'):
                 output = subprocess.check_output(['ar', '-t', file], preexec_fn=subprocess_setup)
                 datafile = None
+                valid_datafiles = ('data.tar', 'data.tar.gz', 'data.tar.xz',
+                                   'data.tar.zst', 'data.tar.bz2', 'data.tar.lzma')
                 if output:
                     for line in output.decode().splitlines():
-                        if line.startswith('data.tar.'):
+                        if line in valid_datafiles:
                             datafile = line
                             break
                     else:
-                        raise UnpackError("Unable to unpack deb/ipk package - does not contain data.tar.* file", urldata.url)
+                        raise UnpackError("Unable to unpack deb/ipk package - does not contain supported data.tar* file", urldata.url)
                 else:
                     raise UnpackError("Unable to unpack deb/ipk package - could not list contents", urldata.url)
-                cmd = 'ar x %s %s && %s -p -f %s && rm %s' % (file, datafile, tar_cmd, datafile, datafile)
+                quoted_datafile = shlex.quote(datafile)
+                cmd = 'ar x %s %s && %s -p -f %s && rm %s' % (shlex.quote(file), quoted_datafile, tar_cmd, quoted_datafile, quoted_datafile)
 
         # If 'subdir' param exists, create a dir and use it as destination for unpack cmd
         if 'subdir' in urldata.parm:
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 3775ab0f3..5735cf8f4 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -13,6 +13,7 @@ import tempfile
 import collections
 import os
 import signal
+import subprocess
 import tarfile
 from bb.fetch2 import URI
 from bb.fetch2 import FetchMethod
@@ -731,6 +732,34 @@ class FetcherLocalTest(FetcherTest):
         bb.process.run('tar cjf archive.tar.bz2 -C dir .', cwd=self.localsrcdir)
         self.d.setVar("FILESPATH", self.localsrcdir)
 
+    def make_ar_package(self, package_name, data_member="data.tar"):
+        if not shutil.which("ar"):
+            self.skipTest("ar not installed")
+
+        workdir = tempfile.mkdtemp(dir=self.tempdir)
+        payload = os.path.join(workdir, "payload")
+        with open(payload, "w") as f:
+            f.write("payload\n")
+
+        data_path = os.path.join(workdir, data_member)
+        mode = "w:gz" if data_member.endswith(".gz") else "w"
+        with tarfile.open(data_path, mode) as archive:
+            archive.add(payload, arcname="payload")
+
+        with open(os.path.join(workdir, "debian-binary"), "w") as f:
+            f.write("2.0\n")
+
+        control = os.path.join(workdir, "control")
+        with open(control, "w") as f:
+            f.write("Package: fetch-test\nVersion: 1\nArchitecture: all\n")
+        with tarfile.open(os.path.join(workdir, "control.tar"), "w") as archive:
+            archive.add(control, arcname="control")
+
+        package_path = os.path.join(self.localsrcdir, package_name)
+        subprocess.check_call(["ar", "r", package_path, "debian-binary", "control.tar", data_member],
+                              cwd=workdir, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
+        return package_name
+
     def fetchUnpack(self, uris):
         fetcher = bb.fetch.Fetch(uris, self.d)
         fetcher.download()
@@ -800,6 +829,30 @@ class FetcherLocalTest(FetcherTest):
         tree = self.fetchUnpack(['file://archive.tar.bz2;subdir=bar;striplevel=1'])
         self.assertEqual(tree, ['bar/c', 'bar/d', 'bar/subdir/e'])
 
+    def test_local_deb_quoted_filename(self):
+        package = self.make_ar_package("archive$(id).deb")
+        tree = self.fetchUnpack(['file://%s' % package])
+        self.assertEqual(tree, ['payload'])
+
+    def test_local_ipk_gz_data_member(self):
+        package = self.make_ar_package("archive.ipk", data_member="data.tar.gz")
+        tree = self.fetchUnpack(['file://%s' % package])
+        self.assertEqual(tree, ['payload'])
+
+    def test_local_deb_rejects_unknown_data_member_suffix(self):
+        package = self.make_ar_package("archive.deb", data_member="data.tar.foo")
+        with self.assertRaises(bb.fetch2.UnpackError) as context:
+            self.fetchUnpack(['file://%s' % package])
+
+        self.assertIn("does not contain supported data.tar* file", str(context.exception))
+
+    def test_local_deb_rejects_unsafe_data_member(self):
+        package = self.make_ar_package("archive.deb", data_member="data.tar.xz;id")
+        with self.assertRaises(bb.fetch2.UnpackError) as context:
+            self.fetchUnpack(['file://%s' % package])
+
+        self.assertIn("does not contain supported data.tar* file", str(context.exception))
+
     def dummyGitTest(self, suffix):
         # Create dummy local Git repo
         src_dir = tempfile.mkdtemp(dir=self.tempdir,

