Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C660CD6E7E
	for <webhook@archiver.kernel.org>; Fri,  5 Jun 2026 22:09:23 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5922.1780697362274888623
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Jun 2026 15:09:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=dgbLy2ch;
 spf=pass (domain: smile.fr, ip: 209.85.128.53, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-490c0c92cffso14310715e9.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 05 Jun 2026 15:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1780697361; x=1781302161; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l5Atl+1fMK/3RBPC/KwxUpyRt6FtwndRlz+yj2srlgc=;
        b=dgbLy2chQGWf3HWA6EXDEPUvmb8iItMA0qKce1a6Mw8k79NgOO816nzUF9b/k671/B
         UD6YEFqJa4CX3GnaRGUQi0maPDc9aPVS7n9PcR9W8sNrNP/B7Cm9+TAexsdyWVfgsU4/
         l+iKfYBV/iGNg4/jaOR65fhcVGZ1L5caFwE+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780697361; x=1781302161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l5Atl+1fMK/3RBPC/KwxUpyRt6FtwndRlz+yj2srlgc=;
        b=cEv38HE+5z5BKRaVNPolu/knFz7Yhxet6PLbrlw1J3EGA8Aot82m1p+WJP7v9vStFd
         BLkwf+oUZdMQPuNOzM3iF2STmTztX925S66+ltCYGBDHZ0W3mNy2UaZ/9VwcfV/GWuqS
         0m6PLs+knWIYHcoxSNFhGuza1grD2jb/+vHG8VmEb6DM+fJydPG0lyCwpy8QaO5HHXB3
         RCe4te3KcR33U0u/l3fHQPJqzm7voUEfVISU8YoYAbp+cW+fT+ZY5yJjInL9WikrwxNJ
         JSnLN6hdqVMwUyArTxbTGMebEwO08lQyQHRpgC/FybQQlvjcoy6+JZ9KP6NkLb7NWCZh
         160w==
X-Gm-Message-State: AOJu0Yy+zSDh8v721uOOZ6ECh/+85AhWjg3zwA84Qj2mW0Bav4SM0mIX
	T64BynOoOxznoAlMklz0dp2OLoY15TCwUBUQiXWn/STLA5VsMF8swLnNXtZGPDM+Aur1mUI2RYt
	L5xR2
X-Gm-Gg: Acq92OF0xWpMiTPaBRYpgmr2MjUbTMmoG2+Bp02OuNxI5o0h0rkXh5eqzGiyAc3z9gc
	UKCPt3SVIcCenRy1GnqYRjNs73E7ZN16fp1f0+Pgz7ntVFLLZhU1QquDc0OPH55uCdzj1cB4vKs
	KMVTGvOphqwWoLugLGiSIfekmnkdig6lPHcKwEobVK7zNTSciKlJ/NxPZRSP/2WImVE++vFukcI
	88Fugr/9DmdzULjh8MFYplLHnRZ2GTEBOg2MAo4G+3/kiDjzps4qL+5qnQOpNNZyArfbMq6C8eX
	zk+t6h6OmXmT5BsPouzylrcJzvsvtj9qbNDO033yH/PWjvYoaI5d0QvxNTrywW7vbtszQA0cvYR
	lhfzwdIyTAZfyBPvQRlISKgXKddDRLcoryPxR2HwcAWUVSJXBLQtkiy6NROkmrSrFzxuilF//nT
	xyvBYe13vdK39K87uOTKJn7Qr1Uh0caUZPcz/Wi8qJIuE+6HHaDuo8vVuDu13UrPk+bjT2GKMpK
	KXGd1hz+xKa6ipSKnFrgp7DzB8BttT4gls1Cspx3oZYWF98Jw==
X-Received: by 2002:a05:600c:81c9:b0:490:bd66:db49 with SMTP id 5b1f17b1804b1-490c25a1e20mr78308435e9.12.1780697360656;
        Fri, 05 Jun 2026 15:09:20 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00b3e1ccc1be2b2798.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:b3e1:ccc1:be2b:2798])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3fd502sm182367015e9.11.2026.06.05.15.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 15:09:20 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [bitbake][wrynose][2.18][PATCH 1/4] fetch2: validate deb/ipk data member names
Date: Sat,  6 Jun 2026 00:08:55 +0200
Message-ID: <cd17c28364c71b5ea50ae6d51f6036cc9ccdca4a.1780696925.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1780696925.git.yoann.congal@smile.fr>
References: <cover.1780696925.git.yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 05 Jun 2026 22:09:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19617

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
index 52d5556d3..fc641655e 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -23,6 +23,7 @@ import collections
 import subprocess
 import pickle
 import errno
+import shlex
 import bb.utils
 import bb.checksum
 import bb.process
@@ -1589,16 +1590,19 @@ class FetchMethod(object):
             elif file.endswith('.deb') or file.endswith('.ipk'):
                 output = subprocess.check_output(['ar', '-t', file], preexec_fn=subprocess_setup)
                 datafile = None
+                valid_datafiles = ('data.tar', 'data.tar.gz', 'data.tar.xz',
+                                   'data.tar.zst', 'data.tar.bz2', 'data.tar.lzma')
                 if output:
                     for line in output.decode().splitlines():
-                        if line.startswith('data.tar.') or line == 'data.tar':
+                        if line in valid_datafiles:
                             datafile = line
                             break
                     else:
-                        raise UnpackError("Unable to unpack deb/ipk package - does not contain data.tar* file", urldata.url)
+                        raise UnpackError("Unable to unpack deb/ipk package - does not contain supported data.tar* file", urldata.url)
                 else:
                     raise UnpackError("Unable to unpack deb/ipk package - could not list contents", urldata.url)
-                cmd = 'ar x %s %s && %s -p -f %s && rm %s' % (file, datafile, tar_cmd, datafile, datafile)
+                quoted_datafile = shlex.quote(datafile)
+                cmd = 'ar x %s %s && %s -p -f %s && rm %s' % (shlex.quote(file), quoted_datafile, tar_cmd, quoted_datafile, quoted_datafile)
 
         # If 'subdir' param exists, create a dir and use it as destination for unpack cmd
         if 'subdir' in urldata.parm:
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 077f741e1..869a82a99 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -16,6 +16,7 @@ import tempfile
 import collections
 import os
 import signal
+import subprocess
 import tarfile
 from bb.fetch2 import URI
 import bb
@@ -740,6 +741,34 @@ class FetcherLocalTest(FetcherTest):
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
@@ -813,6 +842,30 @@ class FetcherLocalTest(FetcherTest):
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

