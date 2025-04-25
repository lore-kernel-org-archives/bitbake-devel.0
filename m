Return-Path: <philip.lorenz@bmw.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABBAC369DF
	for <webhook@archiver.kernel.org>; Fri, 25 Apr 2025 10:18:38 +0000 (UTC)
Received: from esa14.hc324-48.eu.iphmx.com (esa14.hc324-48.eu.iphmx.com [207.54.69.24])
 by mx.groups.io with SMTP id smtpd.web11.3610.1745576309708521832
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 25 Apr 2025 03:18:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bmw.de header.s=mailing1 header.b=cUHbquJT;
 spf=pass (domain: bmw.de, ip: 207.54.69.24, mailfrom: prvs=2034cd71c=philip.lorenz@bmw.de)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=bmw.de; i=@bmw.de; q=dns/txt; s=mailing1;
  t=1745576311; x=1777112311;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TUD2uGxRiXTHBDBRgSiw+CpX3u4k4VXkgNfcoU769mM=;
  b=cUHbquJTzUDH25ULJ5eZ/40mxafToreZ8mFNM3MsrpfZXIIs+tpJ/2kY
   9w+3RoP/vwpmHlTfboT0pAkhYet8ljp7uGxzMSuQx/LYXUwpd5VONMlia
   FunW/RuL6c1JZZN1FMDA79u7tmMvGZP0q8oIC2irLWbgyrh5iWxZrpxQP
   k=;
X-CSE-ConnectionGUID: kwm46IIMQC2+6BZkovkpdw==
X-CSE-MsgGUID: tEJeZk/rRVueuuOrWjpvZg==
Received: from esagw1.bmwgroup.com (HELO esagw1.muc) ([160.46.252.34]) by
 esa14.hc324-48.eu.iphmx.com with ESMTP/TLS; 25 Apr 2025 12:18:28 +0200
Received: from esabb4.muc ([160.50.100.33])  by esagw1.muc with ESMTP/TLS;
 25 Apr 2025 12:18:28 +0200
Received: from smucmp19d.bmwgroup.net (HELO smucmp19d.europe.bmw.corp)
 ([10.30.13.170]) by esabb4.muc with ESMTP/TLS; 25 Apr 2025 12:18:28 +0200
Received: from localhost.localdomain (10.30.85.206) by smucmp19d.europe.bmw.corp
 (2a03:1e80:a15:58f::205d) with Microsoft SMTP Server (version=TLS;
 Fri, 25 Apr 2025 12:18:27 +0200
X-CSE-ConnectionGUID: 8kgPkKxmQr2O+WKM5JMHiQ==
X-CSE-MsgGUID: VtKKfYy1Qbe4JfRPz1mxgg==
X-CSE-ConnectionGUID: eAkg6umWRqW17ZLwG8NI8w==
X-CSE-MsgGUID: 0HWhSbc4Tt+Vs8cnRfS2TQ==
From: Philip Lorenz <philip.lorenz@bmw.de>
To: <bitbake-devel@lists.openembedded.org>
CC: Philip Lorenz <philip.lorenz@bmw.de>, <mathieu.dubois-briand@bootlin.com>
Subject: [PATCH v2 7/8] fetch2: Fix LFS object checkout in submodules
Date: Fri, 25 Apr 2025 12:11:54 +0200
Message-ID: <20250425101155.2905972-8-philip.lorenz@bmw.de>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425101155.2905972-1-philip.lorenz@bmw.de>
References: <20250425101155.2905972-1-philip.lorenz@bmw.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SMUCMP09F.europe.bmw.corp (2a03:1e80:a15:58f::1:2d) To
 smucmp19d.europe.bmw.corp (2a03:1e80:a15:58f::205d)
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 25 Apr 2025 10:18:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17563

Skipping smudging prevents the LFS objects from replacing their
placeholder files when `git submodule update` actually checks out the
target revision in the submodule. Smudging cannot happen earlier as the
clone stored in `.git/modules` is bare.

This should be fine as long as all LFS objects are available in the
download cache (which they are after the other fixes are applied).

Signed-off-by: Philip Lorenz <philip.lorenz@bmw.de>
---
V1 -> V2: Continue to set GIT_LFS_SKIP_SMUDGE=1 when LFS is explicitly
disabled
---
 lib/bb/fetch2/gitsm.py | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index c8bc54e6a..5869e1b99 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -245,12 +245,11 @@ class GitSM(Git):
         ret = self.process_submodules(ud, ud.destdir, unpack_submodules, d)
 
         if not ud.bareclone and ret:
-            # All submodules should already be downloaded and configured in the tree.  This simply
-            # sets up the configuration and checks out the files.  The main project config should
-            # remain unmodified, and no download from the internet should occur. As such, lfs smudge
-            # should also be skipped as these files were already smudged in the fetch stage if lfs
-            # was enabled.
-            runfetchcmd("GIT_LFS_SKIP_SMUDGE=1 %s submodule update --recursive --no-fetch" % (ud.basecmd), d, quiet=True, workdir=ud.destdir)
+            cmdprefix = ""
+            # Avoid LFS smudging (replacing the LFS pointers with the actual content) when LFS shouldn't be used but git-lfs is installed.
+            if not self._need_lfs(ud):
+                cmdprefix = "GIT_LFS_SKIP_SMUDGE=1 "
+            runfetchcmd("%s%s submodule update --recursive --no-fetch" % (cmdprefix, ud.basecmd), d, quiet=True, workdir=ud.destdir)
     def clean(self, ud, d):
         def clean_submodule(ud, url, module, modpath, workdir, d):
             url += ";bareclone=1;nobranch=1"

