Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1686CD6E7E
	for <webhook@archiver.kernel.org>; Fri,  5 Jun 2026 22:12:53 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5825.1780697563817122511
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Jun 2026 15:12:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=HZng+vq5;
 spf=pass (domain: smile.fr, ip: 209.85.221.41, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-45ef5146b56so2239507f8f.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 05 Jun 2026 15:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1780697562; x=1781302362; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nhp2j1BIrSHdsXUSHMQrtT+g+CYFJwcA3jCS85ptr00=;
        b=HZng+vq5KFy88jIrkm8WEHkQrCRJEe8532vkn4tLBoGCz+VX6g6p8NoiKw8QZz5Qt0
         Z5yuiYyWJlfFpXGll8bfbeU21fLat5+RY+F8i1U+xlrnm2hzSkXMrzrRQGV/bP4aDepY
         TwoK6b0aKbXtZTh1VQUBQgjBbK1124SSknUPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780697562; x=1781302362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nhp2j1BIrSHdsXUSHMQrtT+g+CYFJwcA3jCS85ptr00=;
        b=sr2YW4DyFYAvbsCIPqq7KZNWGFNXmyN8WU4p6JvpgIx0AKGevf7xGNIVbKm072RQL2
         om1BYVIkREi9TsEvIvMdjBfWhrwqpPAL3lbcKc4gN4C4qeFtliLDWUtgXBvpbTgJWbaU
         48z0RRU7DyfqJa5ZfeTGIz8rOIASjzOHHjZfYOocUMRxXZbHrU5RMKld7XVmsTJCNuUu
         MdxjmOhRdniNYxQR0BNRoYyxC1B+uikGrV3D+s5htlCGGIXVLHRYVnxsqc5OdXhMTq5P
         2hA0zVVrXovrwO6SFFajTJxM3OXcpjUpH4E/Tv/iE3o54ne5jZ36x0nPPZ6j9R86fRyN
         lq1A==
X-Gm-Message-State: AOJu0YzqUKPGq+mpaENPa9DuZeBkFP5fzAXEYOd8eGqJalAdvcQus6eN
	rnCY3pF/J8slrTVXEWUYcpofzI50IM02XKtawVQ8nU8PVNlKPFB/bl5R37dJjKmQuHXMn1KOOO0
	tN0BN
X-Gm-Gg: Acq92OEmU+VM0nTsf7Eu9yeHXuAchO4HQ/dzkObzM278pSZiBLp118+yF4d4gS0N18H
	qIIKnK5OsvDZxX5LlVvFLTh3dvaS1mVx0YUEAGZXGZmosQswaxOEdm50SMdt1zAtKAlgD/AV1f2
	Dsz6iw3c6xF2Q5BJDFapfn7i/F3IC1LsuhjcF52fqJ/QYIzXWYffJsTURRmMOO/izijU1OWWyp7
	6QuTMcvKzhQ6k9wuQ+4kD2+Utg2wKVyAa1nYRfRwYXaO78TuoZi8/D+LiCnLjNS/4teisVhqPK4
	6ihFfe70KmBCBZsRaEnjJ/2kDBZPKjpPcEniIGdkw+WnyLyVsSxpIudMxPO1cPnqNod/QOXBog1
	KlraRUVG38Ac/HvnE9isffBSKJ5ax4ya+R/VQKrTf2unjanURHb7ebZ5Hwg0RWoOLl2xdiyJsIy
	Uw2MSppNomPdyTV7geU6kYJiVMPncbyQzZg0p/bGEJAE/lVxbzNXnzwpNaE7A5+2ChZ0FpXbRe+
	E2rWED93SN1lLQc8Xy1swdkHCL9iZazCAH2WDE=
X-Received: by 2002:a05:6000:2993:20b0:44f:b82f:2d18 with SMTP id ffacd0b85a97d-46032b82234mr5585325f8f.11.1780697562213;
        Fri, 05 Jun 2026 15:12:42 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00b3e1ccc1be2b2798.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:b3e1:ccc1:be2b:2798])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcae2sm30770393f8f.6.2026.06.05.15.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 15:12:41 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [bitbake][scarthgap][2.8][PATCH 2/4] fetch2: validate striplevel parameter
Date: Sat,  6 Jun 2026 00:12:26 +0200
Message-ID: <3a8937cc4b6513f9ed54fee0b0347589a892c8d7.1780697470.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1780697470.git.yoann.congal@smile.fr>
References: <cover.1780697470.git.yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 05 Jun 2026 22:12:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19623

From: Anders Heimer <anders.heimer@est.tech>

The striplevel URL parameter is appended to tar_cmd, which is later run
through the shell. Validate it as a decimal count before using it in the
tar arguments.

Signed-off-by: Anders Heimer <anders.heimer@est.tech>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 934fe718bfe29c7ec921e6b598d81ec2ebe8f7c7)
[YC: Removed the striplevel="1\n" subtest case. The URL-decoding regex
in decodeurl uses `.*` without `re.DOTALL`, causing literal newlines in
parameters to be silently truncated during parsing.]
Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 lib/bb/fetch2/__init__.py |  5 ++++-
 lib/bb/tests/fetch.py     | 11 +++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 2f54cb86e..7f6cf8ba9 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1520,7 +1520,10 @@ class FetchMethod(object):
         if unpack:
             tar_cmd = 'tar --extract --no-same-owner'
             if 'striplevel' in urldata.parm:
-                tar_cmd += ' --strip-components=%s' %  urldata.parm['striplevel']
+                striplevel = urldata.parm['striplevel']
+                if not striplevel.isdigit():
+                    raise UnpackError("Invalid striplevel parameter: %s" % striplevel, urldata.url)
+                tar_cmd += ' --strip-components=%s' % striplevel
             if file.endswith('.tar'):
                 cmd = '%s -f %s' % (tar_cmd, file)
             elif file.endswith('.tgz') or file.endswith('.tar.gz') or file.endswith('.tar.Z'):
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 5735cf8f4..37e4eb9f4 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -7,6 +7,7 @@
 #
 
 import contextlib
+import shutil
 import unittest
 import hashlib
 import tempfile
@@ -853,6 +854,16 @@ class FetcherLocalTest(FetcherTest):
 
         self.assertIn("does not contain supported data.tar* file", str(context.exception))
 
+    def assertInvalidStriplevel(self, value):
+        with self.assertRaises(bb.fetch2.UnpackError) as context:
+            self.fetchUnpack(['file://archive.tar;subdir=bar;striplevel=%s' % value])
+        self.assertIn("Invalid striplevel parameter", str(context.exception))
+
+    def test_local_striplevel_rejects_invalid_values(self):
+        for value in ("abc", "", "-1", "1 2"):
+            with self.subTest(striplevel=repr(value)):
+                self.assertInvalidStriplevel(value)
+
     def dummyGitTest(self, suffix):
         # Create dummy local Git repo
         src_dir = tempfile.mkdtemp(dir=self.tempdir,

