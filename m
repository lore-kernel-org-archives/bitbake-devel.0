Return-Path: <philip.lorenz@bmw.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB5AC369DE
	for <webhook@archiver.kernel.org>; Fri, 25 Apr 2025 10:18:38 +0000 (UTC)
Received: from esa6.hc324-48.eu.iphmx.com (esa6.hc324-48.eu.iphmx.com [207.54.71.69])
 by mx.groups.io with SMTP id smtpd.web10.3559.1745576309445575421
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 25 Apr 2025 03:18:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bmw.de header.s=mailing1 header.b=fbJoeVrH;
 spf=pass (domain: bmw.de, ip: 207.54.71.69, mailfrom: prvs=2034cd71c=philip.lorenz@bmw.de)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=bmw.de; i=@bmw.de; q=dns/txt; s=mailing1;
  t=1745576310; x=1777112310;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gMPX99xyL43Odbi73Yo+T1ud6ZaZt8+rPjxwVqDxGE0=;
  b=fbJoeVrHWC/dDmVFt6dD8GpyqgXlvZWwPP+98f3TXAqBmf3gxzKDEyyq
   OFALgmMVbWhwPIiOAAYcdHErgFJRr4JDStEjVEqVLzwiyy/AVSeVgGOTo
   d/n9E8n43aHky7d6wvDufKqk89f/AzB0LhDq5VWDLI6SX7fnu6StVSy1O
   o=;
X-CSE-ConnectionGUID: mCnDBbWVSDeAF3d5As26gg==
X-CSE-MsgGUID: d+NmzBZySouMPi0wWb8C4Q==
Received: from 160.46.252.38.spf.bmwgroup.com (HELO esagw2.muc) ([160.46.252.38]) by
 esa6.hc324-48.eu.iphmx.com with ESMTP/TLS; 25 Apr 2025 12:18:27 +0200
Received: from esabb2.muc ([160.50.100.34])  by esagw2.muc with ESMTP/TLS;
 25 Apr 2025 12:18:27 +0200
Received: from smucmp19d.bmwgroup.net (HELO smucmp19d.europe.bmw.corp)
 ([10.30.13.170]) by esabb2.muc with ESMTP/TLS; 25 Apr 2025 12:18:28 +0200
Received: from localhost.localdomain (10.30.85.206) by smucmp19d.europe.bmw.corp
 (2a03:1e80:a15:58f::205d) with Microsoft SMTP Server (version=TLS;
 Fri, 25 Apr 2025 12:18:27 +0200
X-CSE-ConnectionGUID: L+rScy1aRQyJ6TpNHl+tvQ==
X-CSE-MsgGUID: Ldk7+bO2Q+eFIzBA7oC4ug==
X-CSE-ConnectionGUID: 92zosFNPRwmpE9TRFKO/mw==
X-CSE-MsgGUID: vNWxXrm2SxS+heRoDfgOyA==
From: Philip Lorenz <philip.lorenz@bmw.de>
To: <bitbake-devel@lists.openembedded.org>
CC: Philip Lorenz <philip.lorenz@bmw.de>, <mathieu.dubois-briand@bootlin.com>
Subject: [PATCH v2 4/8] fetch2: Simplify git LFS detection
Date: Fri, 25 Apr 2025 12:11:51 +0200
Message-ID: <20250425101155.2905972-5-philip.lorenz@bmw.de>
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
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17562

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

