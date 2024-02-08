Return-Path: <tobias.hagelborn@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D964C48260
	for <webhook@archiver.kernel.org>; Thu,  8 Feb 2024 13:43:47 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.56])
 by mx.groups.io with SMTP id smtpd.web10.17850.1707399821488421894
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 08 Feb 2024 05:43:42 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@axis.com header.s=selector1 header.b=TBsLDhBu;
 spf=pass (domain: axis.com, ip: 40.107.104.56, mailfrom: tobias.hagelborn@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F6mv+fn9/VewGCu+Td1v59MVsmajpOYEfP8Wqgx8hDCYUljT6hlI+18TA6fxTUh8dE6R/1BvVx4+PGgmREhaMXEVegOD23DmN6YK6wqWfUq3BNHvU2Bl1FXRrN5HSt9E0+iCaiC7u6YWtQOiPcEFdyAh2wjqAqrteP3IK9iVxT832Cq+5j5Wxivk1ZIwugbIihkBV09T+GMDfbjDli2o0VUtTMWEdaDLw0kHIiIJEMdHUDJh5ald55JTjmZiRtY0aQJDtb3QMPIgNglsWYlRyEc2LORs3IgOSJyPwyxbAdhAXM2d7ZyVtjhDtyFKFK5n6VBLOcUJ/xsqklioVr+aZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=92TrrUEiBCOFYyoluRdafiDxt0z17Z9Ak80B1/Dp8vQ=;
 b=NozE8isngXfKoz+bA6NUeAssXZGIxAryYHvzY3Gy0cnD2QEFW4LWzdyl+4PSJEbSB/GY17yOttdTlk/M8eiPHCCdykkdAwgMQIuE+cknvI4aWDUqKVJDVzj42OxQAIN2y0O5A2Z1Xg1I/a56rfhoPYPcJKOeeZF1WZniS3xLfAnJTv9KsSrYx9l6oLaIatMtN/rM1n1QNZLOyb3YbJXbtzs1xaDizereAXCGlypCtIymQAd7AzMtvltSZzHMsZRqSkm3U8aFxbWi0ABqXu4iKp8U7Z1E9/OslawQ09nIH+DTCuWyQOqduocRaeew3awIGPocIJPd3CIk/dhtKTfZBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 195.60.68.100) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=axis.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=axis.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=92TrrUEiBCOFYyoluRdafiDxt0z17Z9Ak80B1/Dp8vQ=;
 b=TBsLDhBuNT4Rz0lkyyItQKaHTDA/YOYIRbPxTotXf3FPIYYBSJ7v8Q29cKdTCfo7VO1dsCBnS8Be2tjNKVz0OikWmYIYmykAiOBYNErgPtxKsT7Vf91B965CbwXCde2nFtIm3FIAPMTTqGIg3wTHkqmHl+2WYeNwYJnvtaWRjH0=
Received: from AM0PR10CA0096.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::49)
 by GVXPR02MB8352.eurprd02.prod.outlook.com (2603:10a6:150:6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Thu, 8 Feb
 2024 13:43:37 +0000
Received: from AM1PEPF000252DB.eurprd07.prod.outlook.com
 (2603:10a6:208:15:cafe::d4) by AM0PR10CA0096.outlook.office365.com
 (2603:10a6:208:15::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.39 via Frontend
 Transport; Thu, 8 Feb 2024 13:43:37 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=axis.com;
Received-SPF: Fail (protection.outlook.com: domain of axis.com does not
 designate 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com;
Received: from mail.axis.com (195.60.68.100) by
 AM1PEPF000252DB.mail.protection.outlook.com (10.167.16.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Thu, 8 Feb 2024 13:43:37 +0000
Received: from SE-MAILARCH01W.axis.com (10.20.40.15) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 8 Feb
 2024 14:43:37 +0100
Received: from se-mail01w.axis.com (10.20.40.7) by SE-MAILARCH01W.axis.com
 (10.20.40.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 8 Feb
 2024 14:43:36 +0100
Received: from se-intmail01x.se.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 8 Feb 2024 14:43:36 +0100
Received: from pc37511-1950.se.axis.com (pc37511-1950.se.axis.com [10.94.62.3])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id DDDCA13DE2
	for <bitbake-devel@lists.openembedded.org>; Thu,  8 Feb 2024 14:43:36 +0100 (CET)
Received: by pc37511-1950.se.axis.com (Postfix, from userid 11324)
	id DAFFAB257EA; Thu,  8 Feb 2024 14:43:36 +0100 (CET)
From: Tobias Hagelborn <tobias.hagelborn@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH] hashserv: Postgres adaptations for ignoring duplicate inserts
Date: Thu, 8 Feb 2024 14:43:22 +0100
Message-ID: <20240208134322.3936320-1-tobias.hagelborn@axis.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM1PEPF000252DB:EE_|GVXPR02MB8352:EE_
X-MS-Office365-Filtering-Correlation-Id: 15f61b38-2a89-4cac-1e74-08dc28abf3ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	mwjTpBaJcYbg1AgOfCYSv/mFnlVZV03Pc8exM8w8ybxLJAYN+mQV3tP5OyfcY145U2wxg4UF9ivAIlaRCsLx+UnrhGgvbhgbCyzXwr52Dk0iNr55RTmJWhD53/j1xOBbd9Bsfk/Lof1XFCGtnsFem1wczmijnjZaLuT6AHjymuEAUMi/04VpC6IFtv7mbTn2zLUxLPl4lgDnn9gWQT8iaeg6rOhgptsALzXWW1lBWKSATbyd7WQ2ZdJSg6B0uDD2wb7aVGw6dp9h9m+wIurkaP4XRIT+OFuHKN/PkeRwfyevy3H3oXukXcoxwnhswS2vqwfkAUhDDjxG0sLVJioLMItOhdbJIcjqhkbWZdC2fMQ+5v983meRnysB9ew2jbDyhHtiaQ/vU8+cWhAFhhRgS1ZRjS4HeMvq2VRRo57He6RBM53HfNG2ru/kxpTkTGPHsN0HYfSy7NgiENodcbkGSLZJR8Fav970VgBAbMzo/lmMB873C5sapsBJ7LjlclJIVQq2OJQh0G4O7ovatflZLwbIxuDllzGCMUnUbqUwRKwZp7b+r0xcVrYmyW0VaaHVuDAiZgLL7v1sbVQOp5cMLL6QX4PeRhgJYYar9y6W+PQ=
X-Forefront-Antispam-Report: 
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(39860400002)(396003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(82310400011)(46966006)(36840700001)(40470700004)(41300700001)(1076003)(2616005)(26005)(6266002)(426003)(86362001)(478600001)(5660300002)(2906002)(44832011)(42186006)(6916009)(316002)(70206006)(70586007)(8936002)(8676002)(336012)(36756003)(6666004)(83380400001)(356005)(81166007)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 13:43:37.5999
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15f61b38-2a89-4cac-1e74-08dc28abf3ec
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AM1PEPF000252DB.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR02MB8352
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 08 Feb 2024 13:43:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15842

From: Tobias Hagelborn <tobiasha@axis.com>

Hash Equivalence server performs unconditional insert also of duplicate
hash entries. This causes excessive error log entries in Postgres.
Rather ignore the duplicate inserts.

The alternate behavior should be isolated to the postgres
engine type.

Signed-off-by: Tobias Hagelborn <tobias.hagelborn@axis.com>
---
=20
I have only had the opportunity to validate against Postgres DB.

 lib/hashserv/sqlalchemy.py | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/lib/hashserv/sqlalchemy.py b/lib/hashserv/sqlalchemy.py
index cee04bff..af9da80d 100644
--- a/lib/hashserv/sqlalchemy.py
+++ b/lib/hashserv/sqlalchemy.py
@@ -32,6 +32,7 @@ from sqlalchemy import (
 import sqlalchemy.engine
 from sqlalchemy.orm import declarative_base
 from sqlalchemy.exc import IntegrityError
+from sqlalchemy.dialects.postgresql import insert as postgres_insert
=20
 Base =3D declarative_base()
=20
@@ -287,11 +288,23 @@ class Database(object):
             return result.rowcount
=20
     async def insert_unihash(self, method, taskhash, unihash):
-        statement =3D insert(UnihashesV2).values(
-            method=3Dmethod,
-            taskhash=3Dtaskhash,
-            unihash=3Dunihash,
-        )
+        # Postgres specific ignore on insert duplicate
+        if self.engine.name =3D=3D 'postgresql':
+            statement =3D postgres_insert(UnihashesV2).values(
+                method=3Dmethod,
+                taskhash=3Dtaskhash,
+                unihash=3Dunihash,
+            )
+            statement =3D statement.on_conflict_do_nothing(
+                index_elements=3D("method", "taskhash")
+            )
+        else:
+            statement =3D insert(UnihashesV2).values(
+                method=3Dmethod,
+                taskhash=3Dtaskhash,
+                unihash=3Dunihash,
+            )
+
         self.logger.debug("%s", statement)
         try:
             async with self.db.begin():
@@ -311,7 +324,15 @@ class Database(object):
         if "created" in data and not isinstance(data["created"], datetime)=
:
             data["created"] =3D datetime.fromisoformat(data["created"])
=20
-        statement =3D insert(OuthashesV2).values(**data)
+        # Postgres specific ignore on insert duplicate
+        if self.engine.name =3D=3D 'postgresql':
+            statement =3D postgres_insert(OuthashesV2).values(**data)
+            statement =3D statement.on_conflict_do_nothing(
+                index_elements=3D("method", "taskhash", "outhash")
+            )
+        else:
+            statement =3D insert(OuthashesV2).values(**data)
+
         self.logger.debug("%s", statement)
         try:
             async with self.db.begin():
--=20
2.30.2


