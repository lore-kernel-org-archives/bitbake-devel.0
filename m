Return-Path: <yang.xu@mediatek.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2614CC25B75
	for <webhook@archiver.kernel.org>; Tue, 14 May 2024 10:13:13 +0000 (UTC)
Received: from mailgw02.mediatek.com (mailgw02.mediatek.com [210.61.82.184])
 by mx.groups.io with SMTP id smtpd.web11.11825.1715681590884424555
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 14 May 2024 03:13:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@mediatek.com header.s=dk header.b=Dg9ZJkCz;
 spf=pass (domain: mediatek.com, ip: 210.61.82.184, mailfrom: yang.xu@mediatek.com)
X-UUID: 8daeba0411da11ef8065b7b53f7091ad-20240514
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=IhyQm+h48EDPSrUCV2RtWgGAcP6og2ZOv0J6eFKtKkA=;
	b=Dg9ZJkCzH4E5ekU5IZntwXB+P9TAcZTiXK6mfVZQ1n2M2v7knWJazrey+D2BD/HSdEuBdrWHB+cqWijJM3XN8mr+yvBoQW5gPiPwQnT4d3ZklMJ+NFOqCcGWMo744scXATM2Qb7QLFuzUQP9eJ0iV9e1nrmgguZ7dvtW/qX4t1M=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:72a63dc1-6a6f-4f47-9ecb-ea23e29820f5,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:4b7e5687-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 8daeba0411da11ef8065b7b53f7091ad-20240514
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <yang.xu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 504254367; Tue, 14 May 2024 18:13:04 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 14 May 2024 03:13:03 -0700
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 14 May 2024 18:13:03 +0800
From: <yang.xu@mediatek.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Yang Xu <yang.xu@mediatek.com>
Subject: [PATCH] checksum: fix unstable sort of checksums
Date: Tue, 14 May 2024 10:12:56 +0000
Message-ID: <20240514101257.31020-1-yang.xu@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 14 May 2024 10:13:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16215

From: Yang Xu <yang.xu@mediatek.com>

Using only the checksum as sorting key can lead to unstable results when
same content files exist in different subfolders, affecting the taskhash
calculation due to its sensitivity to the order of files in checksums.

This commit changes the sorting key to use both checksum and file path,
ensuring stable sorting and enhancing sstate cache hit rates.

Signed-off-by: Yang Xu <yang.xu@mediatek.com>
---
 lib/bb/checksum.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/checksum.py b/lib/bb/checksum.py
index 557793d3..5294ddf1 100644
--- a/lib/bb/checksum.py
+++ b/lib/bb/checksum.py
@@ -140,5 +140,5 @@ class FileChecksumCache(MultiProcessCache):
                 if checksum:
                     checksums.append((pth, checksum))
 
-        checksums.sort(key=operator.itemgetter(1))
+        checksums.sort(key=lambda x:(x[1], x[0]))
         return checksums
-- 
2.25.1


