Return-Path: <daniel.turull@ericsson.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 354FDC624D0
	for <webhook@archiver.kernel.org>; Wed,  2 Sep 2026 09:58:13 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.59])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9219.1788343082724285186
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 02 Sep 2026 02:58:03 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@ericsson.com header.s=selector2 header.b=jGtK1s6m;
 spf=pass (domain: ericsson.com, ip: 52.101.70.59, mailfrom: edaturu@ericsson.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cW2ay8509l0t04cAXEnEQ4CVHnNeC3Pz9F4pPQz9fNKCsIt2d5+BZGA2lRpo75xfzjFNYgbGmM4ixjKOfTXxxl+tza3BZKMAYntpJScQlDvn5kAHRhUIRSnucdJsGs0NDSwDjmE6wZzCZ/nwYd8K3+M4RK/l6x9z3osV55VKFmYN59BNvChtbcwQCuHlJrvIdtWbBD4MikXxdT1VCLFmxc73Rnjvq0/5wY/YME+RfXsepzoA427+moDBGTTwHomlDZYSYCbjRVtZ8a2nntb29TDKEzE+3MD1bMzWUPTetzw3zT/cu/GJqH7erDLBLuK9HenSP66kV5qnDRW6mgR5Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fYJcPgaDa5AMtEOtwzMmzQ1RJep+GDOFqFUrc5eyY0I=;
 b=G7IiYgegGducxZeSAheJRWpxoxCfQnEwatZjsB7QOJ7rqvN3CW+4xisVmXwodf0edQoLMkfAzpBmHw7Jk6rKZuNI/W4Eqmas9T31ntGWITVjZf5gn5Tld33YLRF/GTy1IMKs3rwAtdIhvD4A5HnAqGIBGes9St3t54iQDTgZAlY6Hhj9wA/2MIzdfoPqFB3enMi9N2d+vvy04rsGLIvc2yVKShN+dpy0jM2hPj1Qf+5KPy+mOTZTftuIWhpUgw/JNDEI2k6mcZ0w1I1kjnIBU+Aubit29yvm7uYcgKX6QhDR9kE3XZV+KlsOkC2IrfVLOq6w0cc9HaRS2x6+GlzltA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=bootlin.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fYJcPgaDa5AMtEOtwzMmzQ1RJep+GDOFqFUrc5eyY0I=;
 b=jGtK1s6myys1zxHzpzj7ZDajuKyQjV3rkHjCE+fye0C3OqXLBZRkn+HO4RsWr3NQSkw/QCinKrTDb2zm14RFU7FlwhDAg5YF8UhwJq3nzA4CgZNZshJQ/NE+cmIbWa/P27Y9TVfupGBHx9ihO6nwRchSm25f2u+u3aPMLRtOkikWADMgYJqkVy1KlJMwgAQxTmk32E3Oww4u/NTwc5MMzMpS+vxSpyJOGE44THHvnAMzlZozaN+RTzGZcxaPVG239GGiP+MvmTNrZc9L27DdT0s7ltCda0giWcPn56RskKE6yYN1TMdYxTr6MeFQkQKTbX+t631Wx/fNW2EmLiyyog==
Received: from AS9PR04CA0152.eurprd04.prod.outlook.com (2603:10a6:20b:48a::26)
 by VI0PR07MB11492.eurprd07.prod.outlook.com (2603:10a6:800:31e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 09:57:57 +0000
Received: from CPH1EPF00000524.eurprd05.prod.outlook.com
 (2603:10a6:20b:48a:cafe::4d) by AS9PR04CA0152.outlook.office365.com
 (2603:10a6:20b:48a::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 09:57:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 CPH1EPF00000524.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 09:57:56 +0000
Received: from seroius18814.sero.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 2 Sep 2026 11:57:55 +0200
Received: from seroius08462.sero.gic.ericsson.se (seroius08462.sero.gic.ericsson.se [10.63.237.245])
	by seroius18814.sero.gic.ericsson.se (Postfix) with ESMTP id 7AC4B4020B41;
	Wed,  2 Sep 2026 11:57:54 +0200 (CEST)
Received: by seroius08462.sero.gic.ericsson.se (Postfix, from userid 160155)
	id 57148700CF25; Wed,  2 Sep 2026 11:57:54 +0200 (CEST)
From: <daniel.turull@ericsson.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chen Qi <Qi.Chen@windriver.com>, Mathieu Dubois-Briand
	<mathieu.dubois-briand@bootlin.com>, Richard Purdie
	<richard.purdie@linuxfoundation.org>, Daniel Turull
	<daniel.turull@ericsson.com>
Subject: [2.18][PATCH 4/5] fetch2/__init__.py: add filter_regex to default latest_versionstring
Date: Wed, 2 Sep 2026 11:57:37 +0200
Message-ID: <20260902095738.2840120-5-daniel.turull@ericsson.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260902095738.2840120-1-daniel.turull@ericsson.com>
References: <20260902095738.2840120-1-daniel.turull@ericsson.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CPH1EPF00000524:EE_|VI0PR07MB11492:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a4e4539-07c2-440d-6d10-08df08d8aa18
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|36860700016|82310400026|1800799024|23010399003|10067099003|3023799007|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 
	UJYceCW6rHdcX00iTpxbdSYGCOFNgKochBRtbGNaoqx8KbccCQtl8KHbvM9teeFDlN2LDVpSXIzY9hYmjLp2hSQXTVCNGF3afG9EizRJM6GNLftygFWXaSTTP+8eqA+LsibhonAnzgbAHvpmi7fnS84a3SWvCFxs8l3EeC35/clR2hOuLdrK5eO7Uj66D1vRPQs8tbI2So5G86Z9A982FcM/0e8jfQsk5+V5Ra+chyLBkJz0Yqb9KtvtAvS2k9PaeESlXWO3h8PpRyWzQ40ONMvHc69BWMsHs8eSsSESqDhFOGCDE82KLr9n6hhzbsO7FUeMTo7iEdZq2n5KvFS60GXfGkHsCmsD48cXyESJElH8gH/R5/s7uWcKKgObzHYc8Jxe7SJZ+kt/A7pZRTgf4rW2t5xZKQju6l4mfmHsFZWBjQNOFl+1dlAc0ChBYtqEuP5AR92M23pM08etjaQSEgU+9BaCl2HSYO0kGtfT8Fx5v7ZkvnLfzSsq/JeOsCfopLAAxT/k8bVrTe4X/AFxYXSSS2F7NgNhkvp89ltCUouWQdNoRk9MTonq9uAe2hOfjJicoGtW5sL/Fr50pkx5HnnF3Jx4gDLHWJpcb0/dyCayd1iBB7Z/hI+Y1JXOOmwsJdnqyfhfim5VhKNsFV0RXGvhaNqr/DN2J3nsQZL5LJ92cuPTYvb6wW0IO9hvXjgRx1aG+dcHmyE69oDx3gBB7Q==
X-Forefront-Antispam-Report: 
	CIP:192.176.1.74;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:oa.msg.ericsson.com;PTR:office365.se.ericsson.net;CAT:NONE;SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(23010399003)(10067099003)(3023799007)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	w2ZgxH56Xk1EABMabnwCsFNCQ9qIamH1xnBY2XGRbczJbAmROODfZU7Z4d9dwR+sVRMrjJTYD3eIzlknb+LY91BXqD3zLRKCuxdBnCpeIqQpqQtTm0GZaLC9r59+9dVYu9+z7CiXxsK0wF/E5Z977rJ5OPnmrS7O80BbX4LurXEXCRMl23ra9l7VPPPUEHuEVh10IxN2H0IzDVyhrpxlkor9gD3CSoZ0JOoBbKmHMAf+4Fo+cz2MdOfdO+VMenDvJKbByUU0rYa0ZkDucvlalwnFDVe4Pbob69QI6Jow5pwwc+/lxXkyMD8fEnm08WawQuKQSmqbxgVzm/IBfzANdUBNzApKbtnY5Icm55xeoZw9/Kg8CIRu5m2DRXHhdVwHnyZWBgoX/nEz4pzJCfsTSyPpl6O7gHo2vON3q9X4g90ubFTps6PnhD0iIPfxUfPe
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 09:57:56.9120
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a4e4539-07c2-440d-6d10-08df08d8aa18
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f;Ip=[192.176.1.74];Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	CPH1EPF00000524.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR07MB11492
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 02 Sep 2026 09:58:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20151

From: Chen Qi <Qi.Chen@windriver.com>

Add filter_regex parameter to the default latest_versionstring
function so that fetchers that do not implement this function can also
take the filter_regex parameter.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 52f4d0ffd4a51b8c279eb5df157c90fe7d471a55)
Signed-off-by: Daniel Turull <daniel.turull@ericsson.com>
---
 lib/bb/fetch2/__init__.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index e0494b3cb..6f5f5e792 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1734,7 +1734,7 @@ class FetchMethod(object):
     def generate_revision_key(self, ud, d, name):
         return self._revision_key(ud, d, name)
=20
-    def latest_versionstring(self, ud, d):
+    def latest_versionstring(self, ud, d, filter_regex=3DNone):
         """
         Compute the latest release name like "x.y.x" in "x.y.x+gitHASH"
         by searching through the tags output of ls-remote, comparing

