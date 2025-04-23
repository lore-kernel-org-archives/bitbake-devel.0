Return-Path: <philip.lorenz@bmw.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC7AC3ABA0
	for <webhook@archiver.kernel.org>; Wed, 23 Apr 2025 15:25:48 +0000 (UTC)
Received: from esa5.hc324-48.eu.iphmx.com (esa5.hc324-48.eu.iphmx.com [207.54.71.60])
 by mx.groups.io with SMTP id smtpd.web10.11459.1745421943504997724
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 23 Apr 2025 08:25:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bmw.de header.s=mailing1 header.b=gOzOIlX6;
 spf=pass (domain: bmw.de, ip: 207.54.71.60, mailfrom: prvs=201e634cf=philip.lorenz@bmw.de)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=bmw.de; i=@bmw.de; q=dns/txt; s=mailing1;
  t=1745421947; x=1776957947;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m3nviRhXyVWjsnCycTiUBZONX3CZtBH4IHZkqWa7YiU=;
  b=gOzOIlX6QCxQyqPU3FS8XtDNdgcL7SzSmh2/688jGgYlfYuRYIWBrckJ
   vYIcL/AKZiW/zZbLYTmoHFRgyOkHDfiixzsujwb50Zb4UdyXpONH396VE
   7Jh3qrQZZ4XNQy+ItgRY5Lmfz9nqSJ9oUAczat7k+lUJPiswprtZyVD8G
   E=;
X-CSE-ConnectionGUID: tvtxv4NWT1aTGgBiEdteVw==
X-CSE-MsgGUID: GVLRW3y4RN+WIx6Unr1dFQ==
Received: from esagw4.bmwgroup.com (HELO esagw4.muc) ([160.46.252.39]) by
 esa5.hc324-48.eu.iphmx.com with ESMTP/TLS; 23 Apr 2025 17:25:42 +0200
Received: from esabb3.muc ([160.50.100.30])  by esagw4.muc with ESMTP/TLS;
 23 Apr 2025 17:25:42 +0200
Received: from smucmp19d.bmwgroup.net (HELO smucmp19d.europe.bmw.corp)
 ([10.30.13.170]) by esabb3.muc with ESMTP/TLS; 23 Apr 2025 17:25:42 +0200
Received: from localhost.localdomain (10.30.85.210) by smucmp19d.europe.bmw.corp
 (2a03:1e80:a15:58f::205d) with Microsoft SMTP Server (version=TLS;
 Wed, 23 Apr 2025 17:25:41 +0200
X-CSE-ConnectionGUID: JBGNjChdTtGXaOg8qA6D9A==
X-CSE-MsgGUID: x77TOsdZSXuIL8yoFg+HBg==
X-CSE-ConnectionGUID: Vhu6cb+uQjCEXNZBd2VDWQ==
X-CSE-MsgGUID: 0x64iwvpQtWKf9LOvwtFpA==
From: Philip Lorenz <philip.lorenz@bmw.de>
To: <bitbake-devel@lists.openembedded.org>
CC: Philip Lorenz <philip.lorenz@bmw.de>
Subject: [PATCH 7/8] fetch2: Fix LFS object checkout in submodules
Date: Wed, 23 Apr 2025 17:19:00 +0200
Message-ID: <20250423151901.1300944-8-philip.lorenz@bmw.de>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423151901.1300944-1-philip.lorenz@bmw.de>
References: <20250423151901.1300944-1-philip.lorenz@bmw.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: smucmp15a.europe.bmw.corp (2a03:1e80:a15:58f::1:68) To
 smucmp19d.europe.bmw.corp (2a03:1e80:a15:58f::205d)
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 23 Apr 2025 15:25:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17550

Skipping smudging prevents the LFS objects from replacing their
placeholder files when `git submodule update` actually clones the
submodules into the repository (from the local download cache). Drop
`GIT_LFS_SKIP_SMUDGE=1` to fix this.

As long as all LFS objects are available in the download cache (which
they are after the other fixes are applied) the network will not be
accessed anyhow.

Signed-off-by: Philip Lorenz <philip.lorenz@bmw.de>
---
 lib/bb/fetch2/gitsm.py | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index aeeb3cf63..36e760e63 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -245,12 +245,7 @@ class GitSM(Git):
         ret = self.process_submodules(ud, ud.destdir, unpack_submodules, d)
 
         if not ud.bareclone and ret:
-            # All submodules should already be downloaded and configured in the tree.  This simply
-            # sets up the configuration and checks out the files.  The main project config should
-            # remain unmodified, and no download from the internet should occur. As such, lfs smudge
-            # should also be skipped as these files were already smudged in the fetch stage if lfs
-            # was enabled.
-            runfetchcmd("GIT_LFS_SKIP_SMUDGE=1 %s submodule update --recursive --no-fetch" % (ud.basecmd), d, quiet=True, workdir=ud.destdir)
+            runfetchcmd("%s submodule update --recursive --no-fetch" % (ud.basecmd), d, quiet=True, workdir=ud.destdir)
     def clean(self, ud, d):
         def clean_submodule(ud, url, module, modpath, workdir, d):
             url += ";bareclone=1;nobranch=1"

