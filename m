Return-Path: <tobias.hagelborn@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F7BC54798
	for <webhook@archiver.kernel.org>; Fri, 23 Feb 2024 13:27:47 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.65])
 by mx.groups.io with SMTP id smtpd.web10.10464.1708694860446646575
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 23 Feb 2024 05:27:41 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@axis.com header.s=selector1 header.b=l9uD5De9;
 spf=pass (domain: axis.com, ip: 40.107.249.65, mailfrom: tobias.hagelborn@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ae8VdhGMICElRzPv7hBY0c0LLAvSHaQ+y3RxVhgowlLFWhUyMMJohvfOuefFOapHv+Tz28QtKTawA+lXENWZ17QOZcY02E630iXACmA2CQim3SyxpEqcKEhNo41cZWikYJVCRMo8+5y2jFRzAHyQDksDFalaKoJbcyx6E49G0DFtCi/T76cp4UYoHvv6c75HBafqTvbvqj9SpQ6jqSk+sOx1EFQkPqWePqzSuj+Gm9oehmgm858vYChsYdVmH1tvUD9paLpoeAU9aTbvIuxjALXwo8iMuH1ECyxpVNNY8djsqYaJIXady2+JU7IyH0L+3h8ict9+ueURqjYe+iExDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ytSS+RtXMl92aF+GCFfKBxmSEGmaS+uOwfunwzogDbc=;
 b=QnTQ6PCE0y/00m4i/XjbiJxyGNs0Ki7EKa+jyP5hkaAh0kyw8VDHrCzRV3C/d1qjqLA4okoICEcmlUX3ti4s7/xjaBYSe5pbM/mvbcTIZl4JQJvcQE8rpEpCfLOUf55WmoBks23+4TdgodQJz8XnVG9tLIrxF4+Hcqf0/MX+2lAlcndkuuE7u085x7zmGqzxaIwctzeQuHYw50/ODd/GIaXhb+beNjy8QB/juK2hk9fG5D8BvavqbvpWTiBn6FcL5hnf6RaGEJJ8CrrO9jlDyrR3FcCHlUtn4n7t+OG9uHH7az5eKSisKQ2iKzaCRvCYsLoEDIstBELxNZ8hxeZOCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 195.60.68.100) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=axis.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=axis.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ytSS+RtXMl92aF+GCFfKBxmSEGmaS+uOwfunwzogDbc=;
 b=l9uD5De9Qfj1WieiVzhOI3BlnWM5KuKxbYS4qrQN41IbnKjlsb82aLsuYzTKrQbU8I5tWdsn4fBhlRwz9/YSe2boYM1x4K8YzXo/0TF4uAqhuwk6Yyk5YWk6iruYSodPXDWJYaFVTYmV1eVAU8Sr5H0LSwxsbHH+rcoRo6H0Yk0=
Received: from DB8PR03CA0014.eurprd03.prod.outlook.com (2603:10a6:10:be::27)
 by DBAPR02MB6341.eurprd02.prod.outlook.com (2603:10a6:10:19e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.37; Fri, 23 Feb
 2024 13:27:36 +0000
Received: from DB1PEPF000509F8.eurprd02.prod.outlook.com
 (2603:10a6:10:be:cafe::ce) by DB8PR03CA0014.outlook.office365.com
 (2603:10a6:10:be::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.44 via Frontend
 Transport; Fri, 23 Feb 2024 13:27:35 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=axis.com;
Received-SPF: Fail (protection.outlook.com: domain of axis.com does not
 designate 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com;
Received: from mail.axis.com (195.60.68.100) by
 DB1PEPF000509F8.mail.protection.outlook.com (10.167.242.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Fri, 23 Feb 2024 13:27:34 +0000
Received: from SE-MAIL21W.axis.com (10.20.40.16) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 23 Feb
 2024 14:27:33 +0100
Received: from se-mail01w.axis.com (10.20.40.7) by SE-MAIL21W.axis.com
 (10.20.40.16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 23 Feb
 2024 14:27:33 +0100
Received: from se-intmail01x.se.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 23 Feb 2024 14:27:33 +0100
Received: from pc37511-1950.se.axis.com (pc37511-1950.se.axis.com [10.94.62.3])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 550A214E60
	for <bitbake-devel@lists.openembedded.org>; Fri, 23 Feb 2024 14:27:33 +0100 (CET)
Received: by pc37511-1950.se.axis.com (Postfix, from userid 11324)
	id 500C4B257EA; Fri, 23 Feb 2024 14:27:33 +0100 (CET)
From: Tobias Hagelborn <tobiasha@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH v2] hashserv: Re-enable connection pooling with psycopg 3 driver
Date: Fri, 23 Feb 2024 14:27:31 +0100
Message-ID: <20240223132731.2164299-1-tobiasha@axis.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F8:EE_|DBAPR02MB6341:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b33ebfa-9307-477c-6ade-08dc347331cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	DMhvYD9Olam+MRg3ZZTK3ajQn4lGNxgmaM0DRNIo/8LHIGsN3A5g1Fk6BVWDe5yeBh3e0H/2+U0Or6Y9K3PkArzYdIRWc0If8C8YgYzCaJidU+PLR2CXtG63RLKClUL4v8df3Qk8Wh1zjSrY+B+TlxL6KKsgfbZulukW4ZllYLpoo0/JhGj84huNz6ayeM8Oj/7HBQf+pNr7oQg3E8DHfxugUZD6B3/DpcN/lxquDuHBKoNM7iKcGBzbVS3h7Y8WvUNqZUAL0liTf+lz7YIYTrcWjcvz/fPFtHAQ95G3C0lyMJyvT0RLNfN/uGaWPhpf7UPTKfWF5f1KT6D/ONYAxWm4mGd+ev37ueTT6VKmWJySi2IVCl9Oj2W92LGrD2ZZ5HNjURqQTrsIAtmMuBXFo7uarYA7LXmUhQljL46GzMBEPy3vAuqmSKIE5uEI1U6oJfhWoY8nj594Rv+kdomGRliX7lgSZPLlRjUocjhz1FZ/wj96Ctg88tKW2SXs9oDS37b0FoRU8R3q6r+QC2iaRqICK7bMxKfHePTHIa3s0B3YzFByJNiRc/UAeNRc5aNq13EkH9opZzdZTbihvSa+2/Q+mN6oEtvE3w/c8F8DsV0qG4Pz6lwWq1KvLDUASdJfOArFC4Tnn4ziEaf4egrkzfgew8mrDVkRa90+mqqoq3I=
X-Forefront-Antispam-Report: 
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(40470700004)(46966006);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 13:27:34.0284
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b33ebfa-9307-477c-6ade-08dc347331cb
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB1PEPF000509F8.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR02MB6341
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 23 Feb 2024 13:27:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15955

Re-enable connection pooling in case `postgresql+psygopg` driver
is used. Async connection pooling is supported in psycopg 3 [psycopg]
driver in SQLAlchemy. Allow the connection pool to grow to
arbitrary size.

Signed-off-by: Tobias Hagelborn <tobiasha@axis.com>
---

Added unlimited pool size.
Validated with local stress tests and real builds.

 lib/hashserv/sqlalchemy.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/hashserv/sqlalchemy.py b/lib/hashserv/sqlalchemy.py
index fc3ae3d33..f7b0226a7 100644
--- a/lib/hashserv/sqlalchemy.py
+++ b/lib/hashserv/sqlalchemy.py
@@ -129,7 +129,11 @@ class DatabaseEngine(object):
             return inspect(conn).has_table(name)
=20
         self.logger.info("Using database %s", self.url)
-        self.engine =3D create_async_engine(self.url, poolclass=3DNullPool=
)
+        if self.url.drivername =3D=3D 'postgresql+psycopg':
+            # Psygopg 3 (psygopg) driver can handle async connection pooli=
ng
+            self.engine =3D create_async_engine(self.url, max_overflow=3D-=
1)
+        else:
+            self.engine =3D create_async_engine(self.url, poolclass=3DNull=
Pool)
=20
         async with self.engine.begin() as conn:
             # Create tables
--=20
2.30.2


