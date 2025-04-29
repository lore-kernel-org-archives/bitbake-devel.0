Return-Path: <philip.lorenz@bmw.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED4CC3ABAC
	for <webhook@archiver.kernel.org>; Tue, 29 Apr 2025 08:18:05 +0000 (UTC)
Received: from esa2.hc324-48.eu.iphmx.com (esa2.hc324-48.eu.iphmx.com [207.54.68.120])
 by mx.groups.io with SMTP id smtpd.web11.13074.1745914681685012812
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 29 Apr 2025 01:18:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bmw.de header.s=mailing1 header.b=KBNqxge3;
 spf=pass (domain: bmw.de, ip: 207.54.68.120, mailfrom: prvs=207d80f5d=philip.lorenz@bmw.de)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=bmw.de; i=@bmw.de; q=dns/txt; s=mailing1;
  t=1745914684; x=1777450684;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yUkA4U4bV0OVe8hatckw3yuaYOZ/U9GLf8dn48Pay9Q=;
  b=KBNqxge3/KzQs1OEt6+AqxDqwfCBCHH7Pcf1szPqqm1thM/nqh7y1guh
   J68ULlfxfBHHN//RhCEg/smlMKZ6L0+eVZaZcePTMIm4oYI3JFsnUbS2y
   jJg9T9jJgC2/YnL9Y69AGa6uMty1scc62P/l8GiYedoCv9bAF952v5LRS
   8=;
X-CSE-ConnectionGUID: pjNjmoYTSpW0jtEL712mxQ==
X-CSE-MsgGUID: XZE6ezYvQVKMIIMztnZRew==
Received: from 160.46.252.35.spf.bmwgroup.com.bmwgroup.com (HELO esagw3.muc)
 ([160.46.252.35]) by esa2.hc324-48.eu.iphmx.com with ESMTP/TLS;
 29 Apr 2025 10:18:00 +0200
Received: from esabb2.muc ([160.50.100.34])  by esagw3.muc with ESMTP/TLS;
 29 Apr 2025 10:17:58 +0200
Received: from smucmp19d.bmwgroup.net (HELO smucmp19d.europe.bmw.corp)
 ([10.30.13.170]) by esabb2.muc with ESMTP/TLS; 29 Apr 2025 10:17:58 +0200
Received: from localhost.localdomain (10.30.85.212) by smucmp19d.europe.bmw.corp
 (2a03:1e80:a15:58f::205d) with Microsoft SMTP Server (version=TLS;
 Tue, 29 Apr 2025 10:17:57 +0200
X-CSE-ConnectionGUID: YpWCJIbrTYOMudO5ITUPvQ==
X-CSE-MsgGUID: d7xThcrtSfGZc10G+cl6zQ==
X-CSE-ConnectionGUID: apNWwBaeT1mJE3YeIhfoFg==
X-CSE-MsgGUID: 8aIGHnV1SP+WWiT8kLbHKg==
From: Philip Lorenz <philip.lorenz@bmw.de>
To: <bitbake-devel@lists.openembedded.org>
CC: Philip Lorenz <philip.lorenz@bmw.de>, <mathieu.dubois-briand@bootlin.com>,
	<richard.purdie@linuxfoundation.org>
Subject: [PATCH v4 4/8] fetch2: Simplify git LFS detection
Date: Tue, 29 Apr 2025 10:11:20 +0200
Message-ID: <20250429081124.3695505-5-philip.lorenz@bmw.de>
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
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17589

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

