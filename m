Return-Path: <mark-pk.tsai@mediatek.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B7BFA0C46
	for <webhook@archiver.kernel.org>; Wed, 15 Apr 2026 07:55:27 +0000 (UTC)
Received: from mailgw01.mediatek.com (mailgw01.mediatek.com [60.244.123.138])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13619.1776239723610264199
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 15 Apr 2026 00:55:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@mediatek.com header.s=dk header.b=MCxmFYID;
 spf=pass (domain: mediatek.com, ip: 60.244.123.138, mailfrom: mark-pk.tsai@mediatek.com)
X-UUID: 7160f12a38a011f1ae70033691e9ac7d-20260415
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=vcuJDvjLM6e6/8vqCqT4RK/CpNU+a7SvgKvJqRFdCeI=;
	b=MCxmFYID0ir8N98IG0d1jHj2B6F/8hwUoW7xZzpJUsLFy97Da+sb8EjzMHc/JJIU0rdsyIzF5uaJY0JdzTEJ6lOnqVKCqzB65ZqO+bXNCdUti7XgA65rZ0DcXyxN/wcz3AerBZt1IavAF5MifemMalQrzELFJxal43+LXzokzwk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:32322e9e-12e8-4bf8-bb0e-6cd0a83446f2,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:e7bac3a,CLOUDID:c9cdf594-f8ef-4ca8-bea0-143568f9ca1d,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|865|888|898,TC:-5,Content:0|
	15|50,EDM:-3,IP:nil,URL:1,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 7160f12a38a011f1ae70033691e9ac7d-20260415
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <mark-pk.tsai@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1973414550; Wed, 15 Apr 2026 15:55:17 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 15 Apr 2026 15:55:16 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 15 Apr 2026 15:55:16 +0800
From: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
To: <bitbake-devel@lists.openembedded.org>
CC: <yj.chiang@mediatek.com>, <mark-pk.tsai@mediatek.com>
Subject: [PATCH v2] fetch2/git: fix HEAD and branch ref when subpath is used
Date: Wed, 15 Apr 2026 15:55:06 +0800
Message-ID: <20260415075514.2461883-1-mark-pk.tsai@mediatek.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 15 Apr 2026 07:55:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19365

From: Mark-Pk Tsai <mark-pk.tsai@mediatek.com>

When subpath is set the checkout code uses read-tree + checkout-index,
but never updates HEAD. It stays on whatever branch the clone defaulted
to instead of pointing to the requested revision.

Fix by pointing HEAD at the correct revision after checkout-index, and
creating the branch ref when branch= is specified. Also remove the
warning note in the documentation that described this limitation.

Signed-off-by: Mark-Pk Tsai <mark-pk.tsai@mediatek.com>
---
 .../bitbake-user-manual-fetching.rst              | 15 ---------------
 lib/bb/fetch2/git.py                              |  6 ++++++
 2 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
index 1f7583ff3..c2747c401 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
@@ -425,21 +425,6 @@ This fetcher supports the following parameters:
 -  *"subpath":* Limits the checkout to a specific subpath of the tree.
    By default, the whole tree is checked out.
 
-   .. warning::
-
-      When using this option, the value of :term:`SRCREV` may not be reflected
-      in the checked out repository.
-
-      To achieve a partial checkout of the repository with the ``subpath``
-      option, the BitBake Git fetcher makes use of Git "plumbing" commands: `git
-      read-tree <https://git-scm.com/docs/git-read-tree>`__ and `git
-      checkout-index <https://git-scm.com/docs/git-checkout-index>`__. However,
-      these commands only update the **files** within the repository, and do not
-      update the current ``HEAD`` to point to the commit specified by
-      :term:`SRCREV`. Instead, the value of ``HEAD`` will always point to the
-      tip of the branch specified by the ``branch`` parameter, which may or may
-      not correspond to :term:`SRCREV`.
-
 -  *"destsuffix":* The name of the path in which to place the checkout.
    By default, the path is ``git/``.
 
diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 6ed14005b..21f5f28a0 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -787,6 +787,12 @@ class Git(FetchMethod):
                 runfetchcmd("%s read-tree %s%s" % (ud.basecmd, ud.revision, readpathspec), d,
                             workdir=destdir)
                 runfetchcmd("%s checkout-index -q -f -a" % ud.basecmd, d, workdir=destdir)
+                runfetchcmd("%s update-ref --no-deref HEAD %s" % (ud.basecmd, ud.revision),
+                            d, workdir=destdir)
+                if not ud.nobranch:
+                    branchname = ud.branch
+                    runfetchcmd("%s update-ref refs/heads/%s %s" % (ud.basecmd, branchname,
+                                ud.revision), d, workdir=destdir)
             elif not ud.nobranch:
                 branchname =  ud.branch
                 runfetchcmd("%s checkout -B %s %s" % (ud.basecmd, branchname, \
-- 
2.43.0


