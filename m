Return-Path: <tobias.hagelborn@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ABF0C48297
	for <webhook@archiver.kernel.org>; Fri,  9 Feb 2024 09:14:55 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.40])
 by mx.groups.io with SMTP id smtpd.web10.7801.1707470093533857225
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 09 Feb 2024 01:14:54 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@axis.com header.s=selector1 header.b=RAReRM+C;
 spf=pass (domain: axis.com, ip: 40.107.247.40, mailfrom: tobias.hagelborn@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iCtypMgNlzlrR+J2YYRopZHHfAQRkdaVJ7GBwQ2v0fFQ5YyViLjUm2MW7lvSB7Yd0L/ru6SDah5JNC1wYU2jnCB1Isq8NGjsudF+yt4l8CnsL2vc2pIBcwyfj7OHC4OuZ0clXsjCV0TBgkag6t1++zM0/jFnhIjXzaU9ikcLAJ0awQTW9AaWvpdEbC/kLG9Voj2zMIM+9dRbWAAyhqF/0q1LaPDIJLTAXI/gae+RAhUK23022dKdYtfJ74UlQdRUmJlIUVFyhezCEOS2fSF2I+KiO8T0olUAUMrYBgmrDOQ1I8Sm3c6b9dBqB0Zo31e+WDjPtP2ZHBun1d2zPI0bUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lxx/tGn8xa41mZ2hMAPrXxtQHhNMIpKWoleJo8KyyIE=;
 b=IE0cgL+LFg/yKs69kxeqs3ACkg9JmLKkNER8prTmzehtern684+YQ/weIQI1vuiXGzBmgk+YrQNKOfY3zVhc+pA6VtRnC0oUxPwF8VTkb5YViZqOLU5LXPYF8B3yE6Iz+l02Wa6VTJCaDr6XFwhDi8x6HwB0wZ7HQZ/mbd+L6HYlivbskYpA4ngiPX6hZVmsoQJpgwCFqVpIEkZnIXQDPGA7Qe4k5d1mEiF63pFRijBPocNE73Cul0IAxLMgy7LW6YGIRCOglqFkGBIkoOgZ9JOU7IZQRXK6k0lzamklUlM8spif/USbDIuDR7Hn9XafZnJ0fVnECx7DAgythUbIbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 195.60.68.100) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=axis.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=axis.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lxx/tGn8xa41mZ2hMAPrXxtQHhNMIpKWoleJo8KyyIE=;
 b=RAReRM+CarYpz4PGvn5ziTUogRrrPWRuvG3Y5UQDWalwTVKMVFRA1j26S3Psv8G/QWlA8AzSIJpNX9TmFoeQPfw39/HlOQgC9QA00aFWXo3jMRl/ZsD//hqz0F0kWNvrzlsXkHvDCNIWIRRw8L/psqB5+TFh/2Jw14OSWGvGpMM=
Received: from DB8P191CA0007.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:130::17)
 by AM7PR02MB6292.eurprd02.prod.outlook.com (2603:10a6:20b:1c0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.26; Fri, 9 Feb
 2024 09:14:50 +0000
Received: from DU2PEPF0001E9C5.eurprd03.prod.outlook.com
 (2603:10a6:10:130:cafe::31) by DB8P191CA0007.outlook.office365.com
 (2603:10a6:10:130::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Fri, 9 Feb 2024 09:14:50 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=axis.com;
Received-SPF: Fail (protection.outlook.com: domain of axis.com does not
 designate 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com;
Received: from mail.axis.com (195.60.68.100) by
 DU2PEPF0001E9C5.mail.protection.outlook.com (10.167.8.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Fri, 9 Feb 2024 09:14:50 +0000
Received: from se-mail01w.axis.com (10.20.40.7) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 9 Feb
 2024 10:14:49 +0100
Received: from se-intmail01x.se.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 9 Feb 2024 10:14:49 +0100
Received: from pc37511-1950.se.axis.com (pc37511-1950.se.axis.com [10.94.62.3])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 912D213420
	for <bitbake-devel@lists.openembedded.org>; Fri,  9 Feb 2024 10:14:49 +0100 (CET)
Received: by pc37511-1950.se.axis.com (Postfix, from userid 11324)
	id 8B3E0B257EA; Fri,  9 Feb 2024 10:14:49 +0100 (CET)
From: Tobias Hagelborn <tobiasha@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH v2] hashserv: Postgres adaptations for ignoring duplicate inserts
Date: Fri, 9 Feb 2024 10:14:43 +0100
Message-ID: <20240209091443.2737892-1-tobiasha@axis.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF0001E9C5:EE_|AM7PR02MB6292:EE_
X-MS-Office365-Filtering-Correlation-Id: 90713217-9f8c-4aa0-d73e-08dc294f91a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	HRGY/lsTy+sFWFEDb2lNa0uklfbL0sHP4ocx2KvWHpOT1AWKYoIaEdgp2A5EqwL79eRMW1tHUj9nuA8GJAlNyjsGmwRxeOR9uHZlcMrLJP7Siz+WWqqqCC0ViQcpMyLLNkWv2hXMGjxjXv8RVRMRi8vymhuiuwselVRsp7/m++hnSVBnrOhG7/KQogXeCpMH4xkUnP4feYhRFOcq5Ln9SGjVSDO3iIxUMukCKKhuy4CttRvCKpM8KehpHz/nnpnH/l39HsA3wf4L2hk+aPEVyewO28GSGxxUdkkg18cAliQ3k1RzED6ehqjk4scyHRkHGCETBIZn+atpeGtG0gMlFA9mExr8BStPH4gINc8RBrdJRxrAv6Lj1iQZCPk5SjJCUzrF+0z0bpWarutNETicnlNuvwhXy437NbXQMYbAcjk+/mZPl4ra5SEf6UzIl6HKKLXer8/nG1+r+jU4Knw9kKvbBvIS6HCUCxnjFH7ch21nP5QJfFXV5tbVQIRRth+StzKNkLXC/4HLEH4wOThUsMgdxvdlB0o/Nm7ozKmxd4SE9wJuV5IoiHEndsxnl6GSpjooLz8oUcSyw65bytDHeo0Q3G791loz+ohjQtkNZZg=
X-Forefront-Antispam-Report: 
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39850400004)(376002)(396003)(136003)(346002)(230922051799003)(451199024)(82310400011)(186009)(64100799003)(1800799012)(46966006)(40470700004)(36840700001)(2906002)(70206006)(70586007)(8676002)(8936002)(6916009)(5660300002)(36756003)(41300700001)(426003)(336012)(6266002)(1076003)(2616005)(26005)(82740400003)(81166007)(356005)(83380400001)(42186006)(478600001)(6666004)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 09:14:50.1535
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90713217-9f8c-4aa0-d73e-08dc294f91a0
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DU2PEPF0001E9C5.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR02MB6292
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 09 Feb 2024 09:14:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15848

Hash Equivalence server performs unconditional insert also of duplicate
hash entries. This causes excessive error log entries in Postgres.
Rather ignore the duplicate inserts.

The alternate behavior should be isolated to the postgres
engine type.

Signed-off-by: Tobias Hagelborn <tobiasha@axis.com>
---

Updated return codes based on rows updated according to review comments.

 lib/hashserv/sqlalchemy.py | 41 ++++++++++++++++++++++++++++----------
 1 file changed, 31 insertions(+), 10 deletions(-)

diff --git a/lib/hashserv/sqlalchemy.py b/lib/hashserv/sqlalchemy.py
index cee04bff..b17a1762 100644
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
@@ -287,16 +288,28 @@ class Database(object):
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
-                await self.db.execute(statement)
-            return True
+                result =3D await self.db.execute(statement)
+                return result.rowcount !=3D 0
         except IntegrityError:
             self.logger.debug(
                 "%s, %s, %s already in unihash database", method, taskhash=
, unihash
@@ -311,12 +324,20 @@ class Database(object):
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
-                await self.db.execute(statement)
-            return True
+                result =3D await self.db.execute(statement)
+                return result.rowcount !=3D 0
         except IntegrityError:
             self.logger.debug(
                 "%s, %s already in outhash database", data["method"], data=
["outhash"]
--=20
2.30.2


