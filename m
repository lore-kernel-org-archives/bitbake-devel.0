Return-Path: <philip.lorenz@bmw.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE87C369D9
	for <webhook@archiver.kernel.org>; Fri, 25 Apr 2025 14:48:20 +0000 (UTC)
Received: from esa12.hc324-48.eu.iphmx.com (esa12.hc324-48.eu.iphmx.com [207.54.72.34])
 by mx.groups.io with SMTP id smtpd.web10.8246.1745592496449683977
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 25 Apr 2025 07:48:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bmw.de header.s=mailing1 header.b=LUOmFYtd;
 spf=pass (domain: bmw.de, ip: 207.54.72.34, mailfrom: prvs=2034cd71c=philip.lorenz@bmw.de)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=bmw.de; i=@bmw.de; q=dns/txt; s=mailing1;
  t=1745592496; x=1777128496;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yUkA4U4bV0OVe8hatckw3yuaYOZ/U9GLf8dn48Pay9Q=;
  b=LUOmFYtdVoQqTJDhHEwXC9yugUhVBB//eHMS+A+7KPTBuD2/qwrkgKvu
   ZDHpFiwbksoUhne1SrsIRz8IHA29nCf0sfba64CeKxib8VJDx/TwivQXI
   U4KyTgWdfEAUsXJzgUoTl3b939KYCr8h7zMPJNqcKo1J0R6JnPYz2/+Ik
   w=;
X-CSE-ConnectionGUID: 5GH7lSQyR/ixbZ6kqRQJAQ==
X-CSE-MsgGUID: EAmoki8tSySPqUYxj3z2/A==
Received: from 160.46.252.35.spf.bmwgroup.com.bmwgroup.com (HELO esagw3.muc)
 ([160.46.252.35]) by esa12.hc324-48.eu.iphmx.com with ESMTP/TLS;
 25 Apr 2025 16:48:13 +0200
Received: from esabb3.muc ([160.50.100.30])  by esagw3.muc with ESMTP/TLS;
 25 Apr 2025 16:48:12 +0200
Received: from smucmp19d.bmwgroup.net (HELO smucmp19d.europe.bmw.corp)
 ([10.30.13.170]) by esabb3.muc with ESMTP/TLS; 25 Apr 2025 16:48:08 +0200
Received: from localhost.localdomain (10.30.85.205) by smucmp19d.europe.bmw.corp
 (2a03:1e80:a15:58f::205d) with Microsoft SMTP Server (version=TLS;
 Fri, 25 Apr 2025 16:48:07 +0200
X-CSE-ConnectionGUID: /Wnf6XbzTf+rzxcMtP5CDw==
X-CSE-MsgGUID: ENXFo60pS7K/qJC6rjpiVg==
X-CSE-ConnectionGUID: NSNwCYsmQUG7/cF5PYXtCA==
X-CSE-MsgGUID: HmfMYsoxRaSXzk2Vvm/oHQ==
From: Philip Lorenz <philip.lorenz@bmw.de>
To: <bitbake-devel@lists.openembedded.org>
CC: Philip Lorenz <philip.lorenz@bmw.de>, <mathieu.dubois-briand@bootlin.com>,
	<richard.purdie@linuxfoundation.org>
Subject: [PATCH v3 4/8] fetch2: Simplify git LFS detection
Date: Fri, 25 Apr 2025 16:41:34 +0200
Message-ID: <20250425144138.4089681-5-philip.lorenz@bmw.de>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425144138.4089681-1-philip.lorenz@bmw.de>
References: <20250425144138.4089681-1-philip.lorenz@bmw.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: smucmp17a.europe.bmw.corp (2a03:1e80:a15:58f::1:3a) To
 smucmp19d.europe.bmw.corp (2a03:1e80:a15:58f::205d)
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 25 Apr 2025 14:48:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17575

Its unclear why this function does not operate on the desired source
revision to begin with (which really should be the decider on whether a
particular source revision uses LFS or not). Simplify the decision logic
by always checking the `.gitattributes` file of the target revision.

Signed-off-by: Philip Lorenz <philip.lorenz@bmw.de>
---
 lib/bb/fetch2/git.py | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 9e5833735..9b2ad455c 100644
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

