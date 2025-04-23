Return-Path: <philip.lorenz@bmw.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF5E9C369DE
	for <webhook@archiver.kernel.org>; Wed, 23 Apr 2025 15:25:47 +0000 (UTC)
Received: from esa5.hc324-48.eu.iphmx.com (esa5.hc324-48.eu.iphmx.com [207.54.71.60])
 by mx.groups.io with SMTP id smtpd.web10.11459.1745421943504997724
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 23 Apr 2025 08:25:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bmw.de header.s=mailing1 header.b=V0twHwev;
 spf=pass (domain: bmw.de, ip: 207.54.71.60, mailfrom: prvs=201e634cf=philip.lorenz@bmw.de)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=bmw.de; i=@bmw.de; q=dns/txt; s=mailing1;
  t=1745421945; x=1776957945;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gMPX99xyL43Odbi73Yo+T1ud6ZaZt8+rPjxwVqDxGE0=;
  b=V0twHwevz/A7Ah8nGZrgyDzNT+2CZJ8+joqDQiyeCWIOdLm9Ont/efwz
   Li5Jj8mXJ8k4QXGCcl8PIH4JCvtFh2anroPJzYJeNs+/nv9JtU7ce8uFm
   /LWA37RXYgUFDzCF+DJ05x9Lh/gf4cK3cfl17f3tUYVONKC/1X7g0ukT0
   g=;
X-CSE-ConnectionGUID: tvtxv4NWT1aTGgBiEdteVw==
X-CSE-MsgGUID: ufHEbMzSS4+O/9A5MZM5NA==
Received: from esagw4.bmwgroup.com (HELO esagw4.muc) ([160.46.252.39]) by
 esa5.hc324-48.eu.iphmx.com with ESMTP/TLS; 23 Apr 2025 17:25:41 +0200
Received: from esabb3.muc ([160.50.100.30])  by esagw4.muc with ESMTP/TLS;
 23 Apr 2025 17:25:41 +0200
Received: from smucmp19d.bmwgroup.net (HELO smucmp19d.europe.bmw.corp)
 ([10.30.13.170]) by esabb3.muc with ESMTP/TLS; 23 Apr 2025 17:25:41 +0200
Received: from localhost.localdomain (10.30.85.210) by smucmp19d.europe.bmw.corp
 (2a03:1e80:a15:58f::205d) with Microsoft SMTP Server (version=TLS;
 Wed, 23 Apr 2025 17:25:41 +0200
X-CSE-ConnectionGUID: JXngdjTjSoSuycIful+CbQ==
X-CSE-MsgGUID: unloH32pQbCrrqm3qQ8uQg==
X-CSE-ConnectionGUID: m/DkpfbKQsGtylgpakVfMQ==
X-CSE-MsgGUID: 4ynm2M1GTLGzGr7IVkzCpA==
From: Philip Lorenz <philip.lorenz@bmw.de>
To: <bitbake-devel@lists.openembedded.org>
CC: Philip Lorenz <philip.lorenz@bmw.de>
Subject: [PATCH 4/8] fetch2: Simplify git LFS detection
Date: Wed, 23 Apr 2025 17:18:57 +0200
Message-ID: <20250423151901.1300944-5-philip.lorenz@bmw.de>
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
 <bitbake-devel@lists.openembedded.org>; Wed, 23 Apr 2025 15:25:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17547

Its unclear why this function does not operate on the desired source
revision to begin with (which really should be the decider on whether a
particular source revision uses LFS or not). Simplify the decision logic
by always checking the `.gitattributes` file of the target revision.

Signed-off-by: Philip Lorenz <philip.lorenz@bmw.de>
---
 lib/bb/fetch2/git.py | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index b32b18797..a1dd12bf7 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -845,18 +845,8 @@ class Git(FetchMethod):
         """
         Check if the repository has 'lfs' (large file) content
         """
-
-        if ud.nobranch:
-            # If no branch is specified, use the current git commit
-            refname = ud.revision
-        elif wd == ud.clonedir:
-            # The bare clonedir doesn't use the remote names; it has the branch immediately.
-            refname = ud.branch
-        else:
-            refname = "origin/%s" % ud.branch
-
         cmd = "%s grep lfs %s:.gitattributes | wc -l" % (
-            ud.basecmd, refname)
+            ud.basecmd, ud.revision)
 
         try:
             output = runfetchcmd(cmd, d, quiet=True, workdir=wd)

