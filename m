Return-Path: <mark-pk.tsai@mediatek.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1BD9ED7B99
	for <webhook@archiver.kernel.org>; Wed, 15 Apr 2026 02:58:54 +0000 (UTC)
Received: from mailgw01.mediatek.com (mailgw01.mediatek.com [60.244.123.138])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10663.1776221928782068972
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 14 Apr 2026 19:58:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@mediatek.com header.s=dk header.b=PT48S7BH;
 spf=pass (domain: mediatek.com, ip: 60.244.123.138, mailfrom: mark-pk.tsai@mediatek.com)
X-UUID: 02525252387711f1ae70033691e9ac7d-20260415
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=jsiOPZycbL1tx4TuOXxmdvsZfHDuMWi08TANlY59iqQ=;
	b=PT48S7BHML3UHLxXWMtiNFroJSI7T7Aq99VOVyz88nHxIXBrP++E3JvrbkNz4eiUXCmHv/s2lq/H8pLR3i5is2GfuWzHilRcaiN7xZrgshwFC8/U6Wmh9ii3zgDKGdl0VPSAY7QnOinu1vnDgWs9AAEINvR/GdvT+Y4bBFa1FHk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:253107fc-a9f4-4b79-a46c-21ca8f40af45,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:e7bac3a,CLOUDID:012b6f8f-6df4-4a3d-a7a4-fbdc42d669ce,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|865|888|898,TC:-5,Content:0|
	15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 02525252387711f1ae70033691e9ac7d-20260415
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <mark-pk.tsai@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1129383241; Wed, 15 Apr 2026 10:58:41 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 15 Apr 2026 10:58:40 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 15 Apr 2026 10:58:40 +0800
From: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
To: <bitbake-devel@lists.openembedded.org>
CC: <yj.chiang@mediatek.com>, <mark-pk.tsai@mediatek.com>
Subject: [PATCH] fetch2/git: fix HEAD and branch ref when subpath is used
Date: Wed, 15 Apr 2026 10:58:25 +0800
Message-ID: <20260415025829.2342719-1-mark-pk.tsai@mediatek.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 15 Apr 2026 02:58:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19363

From: Mark-Pk Tsai <mark-pk.tsai@mediatek.com>

When subpath is set the checkout code uses read-tree + checkout-index,
but never updates HEAD. It stays on whatever branch the clone defaulted
to instead of pointing to the requested revision.

Fix by pointing HEAD at the correct revision after checkout-index, and
creating the branch ref when branch= is specified.

Signed-off-by: Mark-Pk Tsai <mark-pk.tsai@mediatek.com>
---
 lib/bb/fetch2/git.py | 6 ++++++
 1 file changed, 6 insertions(+)

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


