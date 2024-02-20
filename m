Return-Path: <tobias.hagelborn@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E3F2C48BC4
	for <webhook@archiver.kernel.org>; Tue, 20 Feb 2024 06:27:22 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.55])
 by mx.groups.io with SMTP id smtpd.web10.7952.1708410432911281841
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 19 Feb 2024 22:27:13 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@axis.com header.s=selector1 header.b=qqXqPCht;
 spf=pass (domain: axis.com, ip: 40.107.21.55, mailfrom: tobias.hagelborn@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oZLvvexx94oe6EIsIpMSGXLp7b7KG36WFf4Bd+DPmuas9gBqwVE8ypvKI4iDSaTSeMrDbTF0sAjEFhUcoi8luKP8JeQyprXYbqG3s9diXZOzWVW0Ci8s+mSP5Sw4ruj+k5ewz+8SBX1qvO82epoeUG4R9QNTttSHsSBcH6GSS/g1VUGLhHrZMzC7Rvz6Ak2sOOCgwjbfxfw/uYcwRpbx3HbAEzXc8SYbkSf6LuWN6l3dHGddr0G6TOt6sPXGMrCsfZXw2Bzkaxm1c3KjY/1QK8cV/nhiUsSHXAP6zHVztvfhpMP4SFZB69KQ7oMbTz3a2B6f5QksAQDoQFQ8iQ+2JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=syWGbnPdBdZPHe5fbVWCtYpK/A/AlystT1XDQJL8Rjs=;
 b=dWeckwbFSIR4WA3ToFnFKX0FjOae9jQovNzEucw5EnfKBBilJWfm1By/vDvLHTMerJJLW2UgNGZJxBnq6gdiQfJYfJvPPRxMdIyRqueIh3PsOzNMtVrdQT1Y0yv52dPGqqj4eD9cZ0F3uYACmp0RTwiyImLED4LXClqpBN21JBYOOTpR9HVUraO/CF8iLj66kGcY7zGeHZdJevY6GGkiutOCE3PAuBXgVQAs3hALF5e/ewfwHa4R5RF3KriP/LWxPu2Se6W/YOpCE26gt9ZNfxtdqfK6UaRQFxA94hrhG3eTKT2KvJmjElhQDT8LzNaDiS1ZZTkZTaClBtWffzVbgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 195.60.68.100) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=axis.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=axis.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=syWGbnPdBdZPHe5fbVWCtYpK/A/AlystT1XDQJL8Rjs=;
 b=qqXqPChtKu2+NyBNJkrFIgtY1HLZWPsC/fuO+UmcYOZccIX+r9C6sDQOBsQ7qjyAY81Jjk/Vk8h3FzrjynLDbKm1R7mxRI4FXUGgXsQ55k3QFguWaamMrrnRwMnVWrgpN4NlzHAYL+xqVifLdRkO7wr9Db8zkW900kocN4U23Zs=
Received: from AM6PR02CA0006.eurprd02.prod.outlook.com (2603:10a6:20b:6e::19)
 by DU2PR02MB10283.eurprd02.prod.outlook.com (2603:10a6:10:492::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Tue, 20 Feb
 2024 06:27:08 +0000
Received: from AM2PEPF0001C70D.eurprd05.prod.outlook.com
 (2603:10a6:20b:6e:cafe::fc) by AM6PR02CA0006.outlook.office365.com
 (2603:10a6:20b:6e::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39 via Frontend
 Transport; Tue, 20 Feb 2024 06:27:08 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=axis.com;
Received-SPF: Fail (protection.outlook.com: domain of axis.com does not
 designate 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com;
Received: from mail.axis.com (195.60.68.100) by
 AM2PEPF0001C70D.mail.protection.outlook.com (10.167.16.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Tue, 20 Feb 2024 06:27:08 +0000
Received: from SE-MAILARCH01W.axis.com (10.20.40.15) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 20 Feb
 2024 07:27:08 +0100
Received: from se-mail01w.axis.com (10.20.40.7) by SE-MAILARCH01W.axis.com
 (10.20.40.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 20 Feb
 2024 07:27:07 +0100
Received: from se-intmail01x.se.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 20 Feb 2024 07:27:07 +0100
Received: from pc37511-1950.se.axis.com (pc37511-1950.se.axis.com [10.94.62.3])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id E80A414A87
	for <bitbake-devel@lists.openembedded.org>; Tue, 20 Feb 2024 07:27:07 +0100 (CET)
Received: by pc37511-1950.se.axis.com (Postfix, from userid 11324)
	id E320FB257EA; Tue, 20 Feb 2024 07:27:07 +0100 (CET)
From: Tobias Hagelborn <tobiasha@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH] Re-enable connection pooling with psycopg 3 driver
Date: Tue, 20 Feb 2024 07:27:05 +0100
Message-ID: <20240220062705.3611869-1-tobiasha@axis.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C70D:EE_|DU2PR02MB10283:EE_
X-MS-Office365-Filtering-Correlation-Id: 2af6f44b-82b4-40cf-f441-08dc31dcf6e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	8xCbIWPBAWGKTZQQ/ScwcHALFtL+M7wDE0T7829LjpEafSUrPy1qdomAON4DBSXgl+ctG5Qpt5EcSLxBT0f29cuB6QcHaHMSXqXlkkmMwY/FeFKNumdkn8gnL5bPDBbAkYThBvredAkFx8Gx+nYMJWK5uIsgxX8mjtv8Xe0RrjmVz/dMS4FLRMZhmWiEBKKhVnjWayCG64Pr0PnIezM/zubV4aBTcIidqYqDgiBPxYW+ubbI58ShyTQ85rtALAQFuLm+uhGbtGdZBXHkVxWg6ot/wLkbaKaGq4GCtpEyWi5FfzX2jra9rPs5hF8BRZBagK0Sl0WPGiTHZFPElB0hsIE2of0dZlPMIyh0Nw64esdQ6Rt1KeKsCBtezFYfhHE2FQ1P0Da6FWW2NIacga5i2ukRGbNYei556w5WiOXuuHAYX5JhznuAoUviBY5gcT3ATqsYP5a+KLZ8lmlzoyTw/uTXpD1UrLEHnX7s9IFlYeo6ttzFkf6vKNX5fkGLI3vZNJTavBPbeGJ4D7AZCDk+yp7M5pw8vpz63x6lK0v9o/4EQPWx7+a4rcfcV/1jow6/wyQK2yMydMum6BpCX0sg7HL1BU5XhKEF0bg4N3XZXPjFQCEkevFcSA490jx58KJkqRa9bpS6jbiQcUdsCickc1lSA+rD++JXnHCEAPlZvK4=
X-Forefront-Antispam-Report: 
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(46966006)(40470700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 06:27:08.4196
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2af6f44b-82b4-40cf-f441-08dc31dcf6e6
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AM2PEPF0001C70D.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR02MB10283
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 20 Feb 2024 06:27:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15944

Re-enable connection pooling in case `postgresql+psygopg` driver
is used. Async connection pooling is supported in psycopg 3 [psycopg]
driver in SQLAlchemy.

Signed-off-by: Tobias Hagelborn <tobiasha@axis.com>
---

Connection pooling was disabled since asyncpg does not support it.
With psycopg3 driver it is possible to re-enable connection pooling again.

I wanted to show that it is possible to get the performance back again
and avoid using other, more complex deployments such as pgbouncer to
achieve connection pooling.

Checking the driver url is possibly a bit hackish.
Having some command line parameter would result in a larger change
and also force the user to know which drivers do support pooling properly.

I tested this setup with some of my stress tests and with a batch of builds
and it seems to hold.

 lib/hashserv/sqlalchemy.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/hashserv/sqlalchemy.py b/lib/hashserv/sqlalchemy.py
index b17a17621..e33527e80 100644
--- a/lib/hashserv/sqlalchemy.py
+++ b/lib/hashserv/sqlalchemy.py
@@ -93,7 +93,11 @@ class DatabaseEngine(object):
=20
     async def create(self):
         self.logger.info("Using database %s", self.url)
-        self.engine =3D create_async_engine(self.url, poolclass=3DNullPool=
)
+        if self.url.drivername =3D=3D 'postgresql+psycopg':
+            # Psygopg 3 (psygopg) driver can handle async connection pooli=
ng
+            self.engine =3D create_async_engine(self.url)
+        else:
+            self.engine =3D create_async_engine(self.url, poolclass=3DNull=
Pool)
=20
         async with self.engine.begin() as conn:
             # Create tables
--=20
2.30.2


