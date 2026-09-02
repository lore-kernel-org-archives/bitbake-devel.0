Return-Path: <daniel.turull@ericsson.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D04C624D5
	for <webhook@archiver.kernel.org>; Wed,  2 Sep 2026 09:58:03 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.66])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8926.1788343079279353783
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 02 Sep 2026 02:57:59 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@ericsson.com header.s=selector2 header.b=Pqt71T8T;
 spf=pass (domain: ericsson.com, ip: 52.101.65.66, mailfrom: edaturu@ericsson.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a5/jvgvtTNbG2dXFSaCOpRukkaE7Et9U6ITKjNgymfBbtCWRixbVNLS/581f9tsitl4qHuHGRikKJCSQu1OdPuivW6+TmZxX62/JaRjqeHnLRM0skoTGtHUYLbwkFcMAQl6Td9flReVlW1sL4NHtL8Bq6SeLZo/PtOSJ2hXq0WkDPSWl56JUGyG3GLA9CIUTiuwGsyYR5b0VIoDqU779SYTPvK6BxdFYCnuwCdhH/JNW6h3VdYUC1BqlV/Ew5rlVatSzfZNBKfBBwhc6m2pVmfxmR22pP+ZdckGjnNbd21Srm0aU5lyPCuggnH8SE/bW8KHZ011IiBGUSviTwyYdLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kfdEczagMAQUTklWK0q3rq0ETwTWpdm8gDAtMivJt6k=;
 b=oa3NGBuG6YK+C8VvE1ORRiJWRym1v2fxxbv7W9QGsOxpi7HMm42dW4ugB/2VV7eB8ZGbhXQdKISxapPPTV7zigACEgJ6ei/U21XcFc/p06NA+kM9XuB8ywewhnlbIOm4ORPeLHfRsKW5opcJtGFTmt6NjIWIwZvVSsRpAuZHUO+09bplPB/RXthWSQ5Pw4gtFmDdNJadoerp5BCqDIo5/iXk5OvRBEA0tydZpwyzicr1WlRHVMm1QI710vxFsTVYBHicjLo3S5nADu7u4vFrx01DYe7ayw6p0mqXg78BAIt37H15DvoUvkptCFw0oF63yG0UXr3JpxbTpH2COWuMNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=bootlin.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kfdEczagMAQUTklWK0q3rq0ETwTWpdm8gDAtMivJt6k=;
 b=Pqt71T8TgTKeILtWB/mANMB1RCvZ6a5FFEfl735jAde6QHKA3l6guDloMvDHioiCA3kPe8g1cMbk2V7qtIKe14ceyXMMEEPIqSDgzGZRV6BafWU/+G6zyyxx6QOr+zZg+VDWmmR1o/LQv9JmyV3gp1bVGrz3bPj1I9vDbgYJdx3IxTPYa5k5gNTaaOje21yX/+YpfEUXjaFi7abXBW0qJfG/6sF2nd5OquG0PpDW6Nb/wOt0Z0xgCxIxxVAfXfkYKoyndmA+FwtGmThBkWACPQotcNKCSlVv/6Jldy1axpXk59hmbNlAodPsejgM1mBJbbP2v6GIlEPVB6uIlzfJpA==
Received: from AS9PR0301CA0025.eurprd03.prod.outlook.com
 (2603:10a6:20b:468::22) by DU0PR07MB9291.eurprd07.prod.outlook.com
 (2603:10a6:10:44d::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Wed, 2 Sep 2026
 09:57:54 +0000
Received: from DU6PEPF0000952A.eurprd02.prod.outlook.com
 (2603:10a6:20b:468:cafe::78) by AS9PR0301CA0025.outlook.office365.com
 (2603:10a6:20b:468::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Wed, 2
 Sep 2026 09:57:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 DU6PEPF0000952A.mail.protection.outlook.com (10.167.8.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 09:57:53 +0000
Received: from seroius18815.sero.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 2 Sep 2026 11:57:53 +0200
Received: from seroius08462.sero.gic.ericsson.se (seroius08462.sero.gic.ericsson.se [10.63.237.245])
	by seroius18815.sero.gic.ericsson.se (Postfix) with ESMTP id 372684020B42;
	Wed,  2 Sep 2026 11:57:52 +0200 (CEST)
Received: by seroius08462.sero.gic.ericsson.se (Postfix, from userid 160155)
	id 0A332700CF25; Wed,  2 Sep 2026 11:57:52 +0200 (CEST)
From: <daniel.turull@ericsson.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chen Qi <Qi.Chen@windriver.com>, Mathieu Dubois-Briand
	<mathieu.dubois-briand@bootlin.com>, Richard Purdie
	<richard.purdie@linuxfoundation.org>, Daniel Turull
	<daniel.turull@ericsson.com>
Subject: [2.18][PATCH 1/5] fetch2/git.py: add filter_regex parameter to latest_versionstring
Date: Wed, 2 Sep 2026 11:57:34 +0200
Message-ID: <20260902095738.2840120-2-daniel.turull@ericsson.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260902095738.2840120-1-daniel.turull@ericsson.com>
References: <20260902095738.2840120-1-daniel.turull@ericsson.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000952A:EE_|DU0PR07MB9291:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f60d658-cd43-4156-8297-08df08d8a80f
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|18002099003|22082099003|3023799007|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: 
	oJLOAB4q0odevjgdxG0UHbGe1MS6VDu5F+Fugu0DrKjRc6khrfc7++nv7Vyn1yQnfJPKkcM3Flx4NeOUJGGNlALayzUVYXQiM8FZGjbpk5xAalVwQUIKHcrpz4904C2P47REfesFIiTFtuLep4SwB+qMjMJdAlCL9Uyoqs5ybmeez8bcJ0ujT7WMyej5Gx2QMRCNXz71H+YkKKCD9m/Mkv1V495hoWyKoOXtA2Ymc97gRaNlrZ4Zi0Fyfn+YxLLJIhK8MPAOIBzZFokoFdHJ5lyK3ceyUhVo8AGrZ3ZETaUYrK9pn4JtV/mulA2AJhr8fMDaLtGAq6n0c9VFVEIDo3gv/2p8lCrzjYcMBGboW439tEVZ6AYoPYwVctzL+1PNUAsHZi0FUdXXWjsMofln2xdDUpL7upn+HYXOJpJko4VD2nHjOdCJJh71nu6bz+KHecSr1vNb1PcNbJcQT8Py6c9yvkbPlK4v2EAo8A1qxHO7E9T7F9nS58nTgyWRJCsL0ODAduky8rNvjObjZD+4YJ1iMALAgDcU6GtoA0KniMmIquUci4m5cJb9F5ZUZppu9TGWWUYuEgpqCaiu+eVP0xXUV7Zh9C/ItD/aHobrfknGU+OjIWiPNNumPlGXipHE44LZslBnKtTJhn5blit9FguiCMuEGWh1kfMsWgDc8lO7dsUs3umuQBKnY1BKn1lkm6eRPUfoCTDQ+63dSb4r9g==
X-Forefront-Antispam-Report: 
	CIP:192.176.1.74;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:oa.msg.ericsson.com;PTR:office365.se.ericsson.net;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(18002099003)(22082099003)(3023799007)(56012099006)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	INfRjrZVJLLrK22CN22Gt8Lm+EtUk/eMVbhmdfaIDadmE0SXIloeqh+MrcjGuDW6d+D6vEDckq/47cGKFPtHJ76xOYzEQ6PaBv6Yb53ro22D4KCMrFrve+KZEHGKeyCvMcBUpNzT2yyUIVOL5VngQBV/C6yef9Ov9enoLb47K+B04XFLW4RZ/nMUdJAyvQfWhR0z4rfr+fMUbboUZn9KbTEi1a4ft6IVlg//acVup4WJPachgRmmP07VW+qnHi5aK99koE/xEtIeG49sgOVLdu5tw0EVNfz7r3QpveTjQzUEw9JUJy0dQNBe325Yw5p2ogvYlWsJU6CAhhlbWvH7owM7h8f1dML1AIYWh1DYnZ1cwcOjP20GlJ9L1w6qOf22+PFAOpeodRR7rytPYwvCHwhsCBtGw7UwxFkAGa6kNrmTQbwaW4nZRLI77C+24xQW
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 09:57:53.4665
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f60d658-cd43-4156-8297-08df08d8a80f
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f;Ip=[192.176.1.74];Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DU6PEPF0000952A.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB9291
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 02 Sep 2026 09:58:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20149

From: Chen Qi <Qi.Chen@windriver.com>

We want to be able to do stable version upgrade for recipes. For
example, 1.0.0 -> 1.0.1 instead of 1.0.0 -> 1.1.0.

To to this, we need an extra paramter to latest_versionstring
so that we are able to filter out the versions we need. Using regex
has the advantage of adapting to different version schemes.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 51842f8bc83203ff19e202361d2bb66e0c9f6381)
Signed-off-by: Daniel Turull <daniel.turull@ericsson.com>
---
 lib/bb/fetch2/git.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 5134ec04c..0649429e5 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -975,7 +975,7 @@ class Git(FetchMethod):
         raise bb.fetch2.FetchError("Unable to resolve '%s' in upstream git=
 repository in git ls-remote output for %s" % \
             (ud.unresolvedrev, ud.host+ud.path))
=20
-    def latest_versionstring(self, ud, d):
+    def latest_versionstring(self, ud, d, filter_regex=3DNone):
         """
         Compute the latest release name like "x.y.x" in "x.y.x+gitHASH"
         by searching through the tags output of ls-remote, comparing
@@ -1015,6 +1015,10 @@ class Git(FetchMethod):
=20
             pver =3D m.group('pver').replace("_", ".")
=20
+            if filter_regex:
+                if not re.match(filter_regex, pver):
+                    continue
+
             if verstring and bb.utils.vercmp(("0", pver, ""), ("0", verstr=
ing, "")) < 0:
                 continue
=20

