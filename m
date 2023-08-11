Return-Path: <yang.xu@mediatek.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DED3C001B0
	for <webhook@archiver.kernel.org>; Fri, 11 Aug 2023 02:21:40 +0000 (UTC)
Received: from mailgw01.mediatek.com (mailgw01.mediatek.com [60.244.123.138])
 by mx.groups.io with SMTP id smtpd.web10.35017.1691720498392510177
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 10 Aug 2023 19:21:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@mediatek.com header.s=dk header.b=Gr4gFJsb;
 spf=pass (domain: mediatek.com, ip: 60.244.123.138, mailfrom: yang.xu@mediatek.com)
X-UUID: c727af7437ed11ee9cb5633481061a41-20230811
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=/Ys7a5zCIoIEGjhW+6n+W2Hfb2l1Unc0oVzwAfJYJH8=;
	b=Gr4gFJsbcEtLeTC7vrDbsCPP48iY4+VGm9jglyYyAS65IH9b0RP+H9uyAoD45X47oLS+QdBKpji92kV2yNko3Ju+6QwDB8fkrOeB/lvWT9QZDyCzA1ExXip+SgDvX8IcNJM4LIC4WI9CnX65sSQM/24MbPZdj+74qOfCPobz5mY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:bf8fc7ed-50b0-4a2c-b7aa-a7d457535016,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:95
X-CID-INFO: VERSION:1.1.31,REQID:bf8fc7ed-50b0-4a2c-b7aa-a7d457535016,IP:0,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
	:quarantine,TS:95
X-CID-META: VersionHash:0ad78a4,CLOUDID:b609341f-33fd-4aaa-bb43-d3fd68d9d5ae,B
	ulkID:2308111021303PKLLM6L,BulkQuantity:0,Recheck:0,SF:17|19|48|29|28,TC:n
	il,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
	,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_ULN,TF_CID_SPAM_SNR,
	TF_CID_SPAM_SDM,TF_CID_SPAM_ASC
X-UUID: c727af7437ed11ee9cb5633481061a41-20230811
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <yang.xu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 973245239; Fri, 11 Aug 2023 10:21:28 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 11 Aug 2023 10:21:27 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 11 Aug 2023 10:21:26 +0800
From: <yang.xu@mediatek.com>
To: <bitbake-devel@lists.openembedded.org>
CC: <richard.purdie@linuxfoundation.org>, Yang Xu <yang.xu@mediatek.com>
Subject: [PATCH] server/process: fix sig handle
Date: Fri, 11 Aug 2023 02:20:46 +0000
Message-ID: <20230811022046.7829-1-yang.xu@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 11 Aug 2023 02:21:40 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14934

From: Yang Xu <yang.xu@mediatek.com>

process.signal_received is a list for signum and not iterable,
change a suitable method to handle sig.

Signed-off-by: Yang Xu <yang.xu@mediatek.com>
---
 lib/bb/server/process.py | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 4d4fa6d1..f62faed0 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -860,11 +860,10 @@ class ConnectionWriter(object):
                 process.queue_signals = True
                 self._send(obj)
                 process.queue_signals = False
-                try:
-                    for sig in process.signal_received.pop():
-                        process.handle_sig(sig, None)
-                except IndexError:
-                    pass
+
+                while len(process.signal_received) > 0:
+                    sig = process.signal_received.pop()
+                    process.handle_sig(sig, None)
         else:
             self._send(obj)
 
-- 
2.25.1


