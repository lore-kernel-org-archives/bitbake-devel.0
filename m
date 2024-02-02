Return-Path: <yang.xu@mediatek.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F0DC48291
	for <webhook@archiver.kernel.org>; Fri,  2 Feb 2024 09:36:27 +0000 (UTC)
Received: from mailgw02.mediatek.com (mailgw02.mediatek.com [210.61.82.184])
 by mx.groups.io with SMTP id smtpd.web11.19286.1706866577317826971
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 02 Feb 2024 01:36:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@mediatek.com header.s=dk header.b=BlCI2Qng;
 spf=pass (domain: mediatek.com, ip: 210.61.82.184, mailfrom: yang.xu@mediatek.com)
X-UUID: 7dd729a8c1ae11eea2298b7352fd921d-20240202
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=e4iXGtwL4b/FFvM/g1a9hK+lw8NA1awPH/mmmkX2BGI=;
	b=BlCI2QngsJ2FjJUdDoeWxj6sLR1FfeAGWbVn0PaHHIqtP8XcCgPns9TqabOqt8vj+os/V3fSM2VoUUcbqE9YcF+BklcRyw7L20eS4K874pA2XqY2lVkZUd4dscYJLALeIzTmtgOCMOkTNT4Zdqog+PgzkcMOGUfIbIkaBfzNu9o=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.36,REQID:8b81555c-6b0d-4669-b63c-6547401f38c1,IP:0,U
	RL:0,TC:0,Content:0,EDM:-30,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-30
X-CID-META: VersionHash:6e16cf4,CLOUDID:05910c80-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:2,IP:nil,UR
	L:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:
	1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-UUID: 7dd729a8c1ae11eea2298b7352fd921d-20240202
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <yang.xu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2065263333; Fri, 02 Feb 2024 17:36:07 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 2 Feb 2024 17:36:05 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 2 Feb 2024 17:36:05 +0800
From: <yang.xu@mediatek.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Yang Xu <yang.xu@mediatek.com>
Subject: [PATCH] bitbake-worker: Fix silent hang issue caused by unexpected stdout content
Date: Fri, 2 Feb 2024 09:36:02 +0000
Message-ID: <20240202093602.25618-1-yang.xu@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--7.946700-8.000000
X-TMASE-MatchedRID: SEFIDpPhLbQGQODpkAFmITIOtriLpvtU0i/hFXziUdNk2J2ef3Nd3wn9
	ofQNoBQFKaSE5xgmF3FKhBUJyxjhBgGEq6uX29KS/IBH0OAL+Ec38FNTll9lEuO53bHtM9W3DhJ
	4PH1YPxDi8zVgXoAltsIJ+4gwXrEtwrbXMGDYqV+I9t8DSRevIbAb24foLGMiYrZhdtzNUwnRTu
	X9ZTG1v7hAJAc5xIqKVlxr1FJij9s=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--7.946700-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 5D6055DB9393690E06FFAB5B39CCBCC3D8DFB55AB966D12CD346968E976B71802000:8
X-MTK: N
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 02 Feb 2024 09:36:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15821

From: Yang Xu <yang.xu@mediatek.com>

This patch addresses an issue in bitbake-worker where stdout,
reserved for status reporting, is improperly accessed by child processes.

The problem occurs during the execution of parseRecipe,
which calls anonymous functions. If these functions use print-like operations,
they can inadvertently output data to stdout. This unexpected data can cause
the runqueue to hang silently, if the stdout buffer is flushed
before exec_task is executed.

To prevent this, the patch redirects stdout to /dev/null and ensures it is
flushed prior to the execution of exec_task.

Signed-off-by: Yang Xu <yang.xu@mediatek.com>
---
 bin/bitbake-worker | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/bin/bitbake-worker b/bin/bitbake-worker
index eba9c562..0ba18572 100755
--- a/bin/bitbake-worker
+++ b/bin/bitbake-worker
@@ -237,9 +237,11 @@ def fork_off_task(cfg, data, databuilder, workerdata, extraconfigdata, runtask):
             # Let SIGHUP exit as SIGTERM
             signal.signal(signal.SIGHUP, sigterm_handler)
 
-            # No stdin
-            newsi = os.open(os.devnull, os.O_RDWR)
-            os.dup2(newsi, sys.stdin.fileno())
+            # No stdin & stdout
+            # stdout is used as a status report channel and must not be used by child processes.
+            dumbio = os.open(os.devnull, os.O_RDWR)
+            os.dup2(dumbio, sys.stdin.fileno())
+            os.dup2(dumbio, sys.stdout.fileno())
 
             if umask:
                 os.umask(umask)
@@ -305,6 +307,10 @@ def fork_off_task(cfg, data, databuilder, workerdata, extraconfigdata, runtask):
                 if not quieterrors:
                     logger.critical(traceback.format_exc())
                 os._exit(1)
+
+            sys.stdout.flush()
+            sys.stderr.flush()
+
             try:
                 if dry_run:
                     return 0
-- 
2.25.1


