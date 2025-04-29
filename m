Return-Path: <philip.lorenz@bmw.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 847CEC3ABA9
	for <webhook@archiver.kernel.org>; Tue, 29 Apr 2025 08:18:05 +0000 (UTC)
Received: from esa8.hc324-48.eu.iphmx.com (esa8.hc324-48.eu.iphmx.com [207.54.65.242])
 by mx.groups.io with SMTP id smtpd.web11.13072.1745914679924280858
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 29 Apr 2025 01:18:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bmw.de header.s=mailing1 header.b=aLfGFPs2;
 spf=pass (domain: bmw.de, ip: 207.54.65.242, mailfrom: prvs=207d80f5d=philip.lorenz@bmw.de)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=bmw.de; i=@bmw.de; q=dns/txt; s=mailing1;
  t=1745914681; x=1777450681;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TUD2uGxRiXTHBDBRgSiw+CpX3u4k4VXkgNfcoU769mM=;
  b=aLfGFPs2AkcPrsl/NeB7E+W8V2MeEvlNLF1SIoh/0FoaZGWiOFvMBiKt
   v/qN0mbSe+WPQ3t5euOUAA1DmbPPljJdG1sfFIOjtsgUI/1DZ74O1gqRc
   DRggWpIyLXWs1Rum7yxXyMOpSyfpRdi3Wiuy/vioiHZbRO26evVpvVsyZ
   Y=;
X-CSE-ConnectionGUID: vzAxsUweRQuOBajErrDHOQ==
X-CSE-MsgGUID: 0V10TYpwSzOhG/Yk5g91SQ==
Received: from 160.46.252.34.spf.bmwgroup.com (HELO esagw1.muc) ([160.46.252.34]) by
 esa8.hc324-48.eu.iphmx.com with ESMTP/TLS; 29 Apr 2025 10:17:58 +0200
Received: from esabb3.muc ([160.50.100.30])  by esagw1.muc with ESMTP/TLS;
 29 Apr 2025 10:17:58 +0200
Received: from smucmp19d.bmwgroup.net (HELO smucmp19d.europe.bmw.corp)
 ([10.30.13.170]) by esabb3.muc with ESMTP/TLS; 29 Apr 2025 10:17:58 +0200
Received: from localhost.localdomain (10.30.85.212) by smucmp19d.europe.bmw.corp
 (2a03:1e80:a15:58f::205d) with Microsoft SMTP Server (version=TLS;
 Tue, 29 Apr 2025 10:17:58 +0200
X-CSE-ConnectionGUID: olDvVinmT/mL8wrDqj6IGw==
X-CSE-MsgGUID: L8z8r7kZS+SSslFYIoweJw==
X-CSE-ConnectionGUID: sBSa3eQeSyefcAqo+1ncig==
X-CSE-MsgGUID: ksl7j2RfQtWd1F1V6FHgaQ==
From: Philip Lorenz <philip.lorenz@bmw.de>
To: <bitbake-devel@lists.openembedded.org>
CC: Philip Lorenz <philip.lorenz@bmw.de>, <mathieu.dubois-briand@bootlin.com>,
	<richard.purdie@linuxfoundation.org>
Subject: [PATCH v4 7/8] fetch2: Fix LFS object checkout in submodules
Date: Tue, 29 Apr 2025 10:11:23 +0200
Message-ID: <20250429081124.3695505-8-philip.lorenz@bmw.de>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429081124.3695505-1-philip.lorenz@bmw.de>
References: <20250429081124.3695505-1-philip.lorenz@bmw.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: smucmp09b.europe.bmw.corp (2a03:1e80:a15:58f::203f) To
 smucmp19d.europe.bmw.corp (2a03:1e80:a15:58f::205d)
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 29 Apr 2025 08:18:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17583

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

