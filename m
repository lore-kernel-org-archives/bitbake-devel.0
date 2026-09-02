Return-Path: <daniel.turull@ericsson.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26271C624D5
	for <webhook@archiver.kernel.org>; Wed,  2 Sep 2026 09:58:13 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.28])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8929.1788343085234899052
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 02 Sep 2026 02:58:05 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@ericsson.com header.s=selector2 header.b=Cw1/m8m+;
 spf=pass (domain: ericsson.com, ip: 52.101.83.28, mailfrom: edaturu@ericsson.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bcfscEazaDbPf5YH601WQA8R9gh4xybWGOl/3DadPJ9BO4goOqjGEt52BKwLHJTg/11BbkrCqZgRI1BUUgIS84IWg737W4Tb3Q0HcQWQQES5iS4lIjzUuZcab9fPfXWNK0Di6I9mqI6FB5Far7texfuwiSl27Yi+xEEssJWa2TPwZ0Kj65Gs4GgUkYMbgRkyfQmkEZEMrBKbU3/R7+cFa+zIyLyDI3EKgrHsNR1+l57Abjd67XRWO1W195G3+4wjgIxV5m40TPGsmjqj/tOzdw8zuC/u2hugADg/0tGBxl5L3dOamtnMeW3THtflqjNmjJVaLNTvnowZvE3mOQ9Nsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p7tM2/scC5T9E32JjBLsqKvjqaSDGUKCdB+iVLe6jRc=;
 b=s5/BB+oDqll6chIvjuocys6ooxfaLCIo5pEDBJ1KgCj9Wb7FjSAXq4a8cNrqnKU57W6vE8UDSo/wKn90AHD/dALz9uTQn/p2E9AFPM2VYWNoAToC2ixcwXgHIRlHBxyNR/EC5LUrwcH1unPiG6YltvoSYHXSae/Gd+QJMCWDiSOghvmjVYG4OVAgKAowMkwPrire2Gu9lLuBmYwbUXknqDorUbZmjvz859d8H0PVHE3UVXkuwj3HMVa/KfyAatGUwIj5XL828ACLi4yfQMyteU1qX7ih3xsS0kuLxYXp1FZlrRiIZGubcCc6K49qnc+9F6MoyS7kWSNPbjj1EdhtFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=bootlin.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p7tM2/scC5T9E32JjBLsqKvjqaSDGUKCdB+iVLe6jRc=;
 b=Cw1/m8m+7eEUbrscu2BgPXlF3mz7oCye01ZL+j6l/8JAC0IqzlWCzYHbYVX9seX/bgjKBdrZqEecGvQp5lKOmrfSB1JZy6oQ+BmsdUaJgzI9JH7TOqTr3vx2rONEoAG7aPtLqwOBOQMTLGxWwnTg8SQVZqu9YV5KxuGO00BjhOwEDdVOl3hHQQZHU2bnkkURk9en4EZ7Vx8GFsiUDnzJHuekvt9J2Q+HMcOujtT/OQ7GvfdmlBiUaFvgAl1A6oGzmvmIbdRT+YWW2hBOnTURkR6Psn02gifZaxUtpKOkKozeGitVMIh9tOcCMGQth1Js1tMKu5UwJCWmUjbRCaEJGg==
Received: from AS9PR06CA0409.eurprd06.prod.outlook.com (2603:10a6:20b:461::18)
 by DU0PR07MB9267.eurprd07.prod.outlook.com (2603:10a6:10:44d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 09:57:55 +0000
Received: from CPH1EPF00000526.eurprd05.prod.outlook.com
 (2603:10a6:20b:461:cafe::9f) by AS9PR06CA0409.outlook.office365.com
 (2603:10a6:20b:461::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 09:57:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 CPH1EPF00000526.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 09:57:55 +0000
Received: from seroius18813.sero.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 2 Sep 2026 11:57:54 +0200
Received: from seroius08462.sero.gic.ericsson.se (seroius08462.sero.gic.ericsson.se [10.63.237.245])
	by seroius18813.sero.gic.ericsson.se (Postfix) with ESMTP id AD36095802;
	Wed,  2 Sep 2026 11:57:53 +0200 (CEST)
Received: by seroius08462.sero.gic.ericsson.se (Postfix, from userid 160155)
	id 86D57700CF25; Wed,  2 Sep 2026 11:57:53 +0200 (CEST)
From: <daniel.turull@ericsson.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chen Qi <Qi.Chen@windriver.com>, Mathieu Dubois-Briand
	<mathieu.dubois-briand@bootlin.com>, Richard Purdie
	<richard.purdie@linuxfoundation.org>, Daniel Turull
	<daniel.turull@ericsson.com>
Subject: [2.18][PATCH 3/5] fetch2/crate.py: add filter_regex parameter to latest_versionstring
Date: Wed, 2 Sep 2026 11:57:36 +0200
Message-ID: <20260902095738.2840120-4-daniel.turull@ericsson.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260902095738.2840120-1-daniel.turull@ericsson.com>
References: <20260902095738.2840120-1-daniel.turull@ericsson.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CPH1EPF00000526:EE_|DU0PR07MB9267:EE_
X-MS-Office365-Filtering-Correlation-Id: e0d92492-9f73-418d-ff1e-08df08d8a8fb
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|1800799024|376014|10067099003|6133799003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 
	qfkh0tw6g6s229NnxKkIfcQ9gIVADXE6DSW01bxfUwSEuV6MKVohq0giapdo781csj7iU+94f4xay1YhitsKZzSKcIzsDTCR46aUSgTX/IWUJ5hlIcKZsUnt/xG3JdlgLKG1GKs5sT0n+ZwI2Ml+6IfguDllfA52CDkSeX27hRFPD1c5bvQftDkvsQY39S4QlMCzTfqbw5rkejGyYU9MNP5CIYrTUcSlQPDEsnCnpkmFmqUDtn227JKG8jBpCLTxP7oHAbclrZH4m9xcf+m76+h4ZcrR3iFwnHKc8gfKOkJaIPfn3bSxXpbQxNQXWIEqwkjxeIRMbGGbyJnm4sFKchUKYb4Lzp7Z7yNy46nl8CPWO0msLFo3p8ZPgSKkcjBEPbs/1B+SoqtGZfNpoWfv7hysj3Gww4bXn5TiisZ0hcdVzgv8zWWwessT+adHEpFYzRnqORkzaQkHqVGGYjQlPLqPZxETfDTdIg+aPIAYB8sHUFpby46WEgCbwXAcsFY1o159iCNb5kK2cYQL0YxYjzz56deFbcss2lGqKEm/mvBZ8LAvjWcHhFG/Jlkq0v6wULZ0mm1p7wM4nqp8y8Z3T6QYoFn+XTLIhm1RKNZFLTkv2hVGypOGTtHMH5rOeBRqSXpsCjjx+SrE0mai7GHRDj/j4a65IHkNhyHPtKPceQAUNaXXcOM1fvfDgiYpyaKYa9sVfWdHOrVf63ehtuvdvQ==
X-Forefront-Antispam-Report: 
	CIP:192.176.1.74;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:oa.msg.ericsson.com;PTR:office365.se.ericsson.net;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(1800799024)(376014)(10067099003)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	QpOAnCF5O/TMdi+8rjNiOEfwmFNdNWKMYvNoz9c1o7XWEAkilbrwUCX77/ngz1clngpN1hjlcUf2cIOiR/ni8/NST698mDCROl4/NYRO7iWJZaN3ISjppDiKGaIITx+bXzgKQo7hz7cdBtWv/Bry/VtfYmi0cOiHuAD+yGk/a9znIXtI/nXkHMvYmqQk7+xlFLkZEnBkW/jp4z+W5mSHVv8wPgWuwNFYfapMSoXD9/StoGkWcgk7kWDz7rHKCui8go+6/80UbucN41hskyUBkNYDZwpaS/80dwFYHXQ5LZ+HRntNDAwO6AeJbPZxeaAgoblCnGT2jfuyGiCW1yN2kBLcxQbFrjQJ4lxWhueyCj8fEiAnybQ9jdjD7NHuFEmyAhpyixdTjlfslsL/m3woHrm9ae0MRdLQMNcJZb0Qhne4RBGFCskgLJjN6C9Zak1O
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 09:57:55.0510
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0d92492-9f73-418d-ff1e-08df08d8a8fb
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f;Ip=[192.176.1.74];Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	CPH1EPF00000526.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB9267
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 02 Sep 2026 09:58:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20154

From: Chen Qi <Qi.Chen@windriver.com>

We want to be able to do stable version upgrade for recipes. For
example, 1.0.0 -> 1.0.1 instead of 1.0.0 -> 1.1.0.

To to this, we need an extra paramter to latest_versionstring
so that we are able to filter out the versions we need. Using regex
has the advantage of adapting to different version schemes.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 592477f225868e227110477f52691e031903430a)
Signed-off-by: Daniel Turull <daniel.turull@ericsson.com>
---
 lib/bb/fetch2/crate.py | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/crate.py b/lib/bb/fetch2/crate.py
index eb1fd5719..6133d3756 100644
--- a/lib/bb/fetch2/crate.py
+++ b/lib/bb/fetch2/crate.py
@@ -13,6 +13,7 @@ BitBake 'Fetch' implementation for crates.io
 import hashlib
 import json
 import os
+import re
 import subprocess
 import bb
 from   bb.fetch2 import logger, subprocess_setup, UnpackError
@@ -155,18 +156,20 @@ class Crate(Wget):
             with open(mdpath, "w") as f:
                 json.dump(metadata, f)
=20
-    def latest_versionstring(self, ud, d):
+    def latest_versionstring(self, ud, d, filter_regex=3DNone):
         """
         Return the latest version available when versionsurl is the [name]=
/versions URL.
         """
         from functools import cmp_to_key
         json_data =3D json.loads(self._fetch_index(ud.versionsurl, ud, d))
         versions =3D [(0, i["num"], "") for i in json_data["versions"]]
+        if filter_regex:
+            versions =3D [v for v in versions if re.match(filter_regex, v[=
1])]
         versions =3D sorted(versions, key=3Dcmp_to_key(bb.utils.vercmp))
=20
         return (versions[-1][1], "") if versions else ("", "")
=20
-    def latest_versionstring_from_index(self, ud, d):
+    def latest_versionstring_from_index(self, ud, d, filter_regex=3DNone):
         """
         Return the latest version available when versionsurl is a Cargo in=
dex
         file.
@@ -181,5 +184,8 @@ class Crate(Wget):
             if not data.get("yanked", False):
                 versions.append((0, data["vers"], ""))
=20
+        if filter_regex:
+            versions =3D [v for v in versions if re.match(filter_regex, v[=
1])]
+
         versions =3D sorted(versions, key=3Dcmp_to_key(bb.utils.vercmp))
         return (versions[-1][1], "") if versions else ("", "")

