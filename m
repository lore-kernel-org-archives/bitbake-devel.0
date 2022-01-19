Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD01C433F5
	for <webhook@archiver.kernel.org>; Wed, 19 Jan 2022 18:00:19 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web12.30.1642615217807813109
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 19 Jan 2022 10:00:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=To/0qLVl;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.47,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f47.google.com with SMTP id n8so6724511wmk.3
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 19 Jan 2022 10:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t48/TeFhy9qSg93uVErhXpbSE6Q6vCr3Fn/0MFITBS0=;
        b=To/0qLVlkXpnlCtV0HkYANs1sl1QP260Lf28/dn5nEL57DhggRf0/s5B5HA3wlVM1S
         o+zPP77GRpKQDTnYvfIuLboYoodoAWVMKByqGuNHQ60sEf146zQAfZhksOOCWrD5bqqL
         BxFy8Jpa8OyEVPkENHMTvnitqugPEKK8bzd48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t48/TeFhy9qSg93uVErhXpbSE6Q6vCr3Fn/0MFITBS0=;
        b=V4FfR/yMH+xER2DKVKZc61ksmdEti9zuHjSFk0WISoFnY/SjzWMyRnpAK6Wqpn1B+V
         r+tyyaeHJDkjTMpl+Vf0liiIWpQWHJ+AM0WY2Dr2SMuYkpZVEqjFD01WVQgapPDFR9XV
         WQVkVn6oF8qxIgy8wQf6H5L0z/Pfcpx8DtyN+fennaVLrANlANi7dXU7mKIusnHt1oqV
         /FBA+Szu6RW1STFvqpRieuCeCQGV5ox6Of9+LE5uAY0c+mfmyp31//qn18D5KMk383pI
         asg10eWS0SjSH01Y8nVQzuWqC+mlO6KCZpi9+lHnVI/NfAGIwnRyUGNBeyl/YveicY1N
         1hyg==
X-Gm-Message-State: AOAM530hNCFh24/arD6iJps+EI62mbDNkJSB/x6ebzaQ5cXxeem0SSyl
	JLJbqTbSfJ3c/Yi/QljuClYUVLI/FF4OiQ==
X-Google-Smtp-Source: 
 ABdhPJyXoKzuQbsDMGGrwlktYmCbw8sQsWwursb14PSMG6RY0/zuHERoXFpF693rZF271RHh5buYpw==
X-Received: by 2002:adf:f410:: with SMTP id
 g16mr29843411wro.114.1642615215868;
        Wed, 19 Jan 2022 10:00:15 -0800 (PST)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:4e1a:65bf:4ced:cc2d])
        by smtp.gmail.com with ESMTPSA id
 m12sm618126wrp.55.2022.01.19.10.00.15
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 10:00:15 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] fetch2: Add crate fetcher
Date: Wed, 19 Jan 2022 18:00:15 +0000
Message-Id: <20220119180015.1931903-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 19 Jan 2022 18:00:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13247

This imports the crate fetcher from OE-Core to resolve various module issues
and adds some very very basic tests of that new fetcher.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/__init__.py |   2 +
 lib/bb/fetch2/crate.py    | 137 ++++++++++++++++++++++++++++++++++++++
 lib/bb/tests/fetch.py     |  35 ++++++++++
 3 files changed, 174 insertions(+)
 create mode 100644 lib/bb/fetch2/crate.py

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 0b39ea6aaa..d37174185a 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1942,6 +1942,7 @@ from . import clearcase
 from . import npm
 from . import npmsw
 from . import az
+from . import crate
 
 methods.append(local.Local())
 methods.append(wget.Wget())
@@ -1962,3 +1963,4 @@ methods.append(clearcase.ClearCase())
 methods.append(npm.Npm())
 methods.append(npmsw.NpmShrinkWrap())
 methods.append(az.Az())
+methods.append(crate.Crate())
diff --git a/lib/bb/fetch2/crate.py b/lib/bb/fetch2/crate.py
new file mode 100644
index 0000000000..f7e2354afb
--- /dev/null
+++ b/lib/bb/fetch2/crate.py
@@ -0,0 +1,137 @@
+# ex:ts=4:sw=4:sts=4:et
+# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
+"""
+BitBake 'Fetch' implementation for crates.io
+"""
+
+# Copyright (C) 2016 Doug Goldstein
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Based on functions from the base bb module, Copyright 2003 Holger Schurig
+
+import hashlib
+import json
+import os
+import shutil
+import subprocess
+import bb
+from   bb.fetch2 import logger, subprocess_setup, UnpackError
+from   bb.fetch2.wget import Wget
+
+
+class Crate(Wget):
+
+    """Class to fetch crates via wget"""
+
+    def _cargo_bitbake_path(self, rootdir):
+        return os.path.join(rootdir, "cargo_home", "bitbake")
+
+    def supports(self, ud, d):
+        """
+        Check to see if a given url is for this fetcher
+        """
+        return ud.type in ['crate']
+
+    def recommends_checksum(self, urldata):
+        return False
+
+    def urldata_init(self, ud, d):
+        """
+        Sets up to download the respective crate from crates.io
+        """
+
+        if ud.type == 'crate':
+            self._crate_urldata_init(ud, d)
+
+        super(Crate, self).urldata_init(ud, d)
+
+    def _crate_urldata_init(self, ud, d):
+        """
+        Sets up the download for a crate
+        """
+
+        # URL syntax is: crate://NAME/VERSION
+        # break the URL apart by /
+        parts = ud.url.split('/')
+        if len(parts) < 5:
+            raise bb.fetch2.ParameterError("Invalid URL: Must be crate://HOST/NAME/VERSION", ud.url)
+
+        # last field is version
+        version = parts[len(parts) - 1]
+        # second to last field is name
+        name = parts[len(parts) - 2]
+        # host (this is to allow custom crate registries to be specified
+        host = '/'.join(parts[2:len(parts) - 2])
+
+        # if using upstream just fix it up nicely
+        if host == 'crates.io':
+            host = 'crates.io/api/v1/crates'
+
+        ud.url = "https://%s/%s/%s/download" % (host, name, version)
+        ud.parm['downloadfilename'] = "%s-%s.crate" % (name, version)
+        ud.parm['name'] = name
+
+        logger.debug(2, "Fetching %s to %s" % (ud.url, ud.parm['downloadfilename']))
+
+    def unpack(self, ud, rootdir, d):
+        """
+        Uses the crate to build the necessary paths for cargo to utilize it
+        """
+        if ud.type == 'crate':
+            return self._crate_unpack(ud, rootdir, d)
+        else:
+            super(Crate, self).unpack(ud, rootdir, d)
+
+    def _crate_unpack(self, ud, rootdir, d):
+        """
+        Unpacks a crate
+        """
+        thefile = ud.localpath
+
+        # possible metadata we need to write out
+        metadata = {}
+
+        # change to the rootdir to unpack but save the old working dir
+        save_cwd = os.getcwd()
+        os.chdir(rootdir)
+
+        pn = d.getVar('BPN')
+        if pn == ud.parm.get('name'):
+            cmd = "tar -xz --no-same-owner -f %s" % thefile
+        else:
+            cargo_bitbake = self._cargo_bitbake_path(rootdir)
+
+            cmd = "tar -xz --no-same-owner -f %s -C %s" % (thefile, cargo_bitbake)
+
+            # ensure we've got these paths made
+            bb.utils.mkdirhier(cargo_bitbake)
+
+            # generate metadata necessary
+            with open(thefile, 'rb') as f:
+                # get the SHA256 of the original tarball
+                tarhash = hashlib.sha256(f.read()).hexdigest()
+
+            metadata['files'] = {}
+            metadata['package'] = tarhash
+
+        path = d.getVar('PATH')
+        if path:
+            cmd = "PATH=\"%s\" %s" % (path, cmd)
+        bb.note("Unpacking %s to %s/" % (thefile, os.getcwd()))
+
+        ret = subprocess.call(cmd, preexec_fn=subprocess_setup, shell=True)
+
+        os.chdir(save_cwd)
+
+        if ret != 0:
+            raise UnpackError("Unpack command %s failed with return value %s" % (cmd, ret), ud.url)
+
+        # if we have metadata to write out..
+        if len(metadata) > 0:
+            cratepath = os.path.splitext(os.path.basename(thefile))[0]
+            bbpath = self._cargo_bitbake_path(rootdir)
+            mdfile = '.cargo-checksum.json'
+            mdpath = os.path.join(bbpath, cratepath, mdfile)
+            with open(mdpath, "w") as f:
+                json.dump(metadata, f)
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 2a046d0ded..ec7d83c959 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -2260,6 +2260,41 @@ class GitURLWithSpacesTest(FetcherTest):
             self.assertEqual(ud.clonedir, os.path.join(self.dldir, "git2", ref['gitsrcname']))
             self.assertEqual(ud.fullmirror, os.path.join(self.dldir, "git2_" + ref['gitsrcname'] + '.tar.gz'))
 
+class CrateTest(FetcherTest):
+    def test_crate_url(self):
+
+        uri = "crate://crates.io/glob/0.2.11"
+        self.d.setVar('SRC_URI', uri)
+
+        uris = self.d.getVar('SRC_URI').split()
+        d = self.d
+
+        fetcher = bb.fetch2.Fetch(uris, self.d)
+        fetcher.download()
+        fetcher.unpack(self.tempdir)
+        self.assertEqual(sorted(os.listdir(self.tempdir)), ['cargo_home', 'download' , 'unpacked'])
+        self.assertEqual(sorted(os.listdir(self.tempdir + "/download")), ['glob-0.2.11.crate', 'glob-0.2.11.crate.done'])
+        self.assertTrue(os.path.exists(self.tempdir + "/cargo_home/bitbake/glob-0.2.11/.cargo-checksum.json"))
+        self.assertTrue(os.path.exists(self.tempdir + "/cargo_home/bitbake/glob-0.2.11/src/lib.rs"))
+
+    def test_crate_url_multi(self):
+
+        uri = "crate://crates.io/glob/0.2.11 crate://crates.io/time/0.1.35"
+        self.d.setVar('SRC_URI', uri)
+
+        uris = self.d.getVar('SRC_URI').split()
+        d = self.d
+
+        fetcher = bb.fetch2.Fetch(uris, self.d)
+        fetcher.download()
+        fetcher.unpack(self.tempdir)
+        self.assertEqual(sorted(os.listdir(self.tempdir)), ['cargo_home', 'download' , 'unpacked'])
+        self.assertEqual(sorted(os.listdir(self.tempdir + "/download")), ['glob-0.2.11.crate', 'glob-0.2.11.crate.done', 'time-0.1.35.crate', 'time-0.1.35.crate.done'])
+        self.assertTrue(os.path.exists(self.tempdir + "/cargo_home/bitbake/glob-0.2.11/.cargo-checksum.json"))
+        self.assertTrue(os.path.exists(self.tempdir + "/cargo_home/bitbake/glob-0.2.11/src/lib.rs"))
+        self.assertTrue(os.path.exists(self.tempdir + "/cargo_home/bitbake/time-0.1.35/.cargo-checksum.json"))
+        self.assertTrue(os.path.exists(self.tempdir + "/cargo_home/bitbake/time-0.1.35/src/lib.rs"))
+
 class NPMTest(FetcherTest):
     def skipIfNoNpm():
         import shutil
-- 
2.32.0


