Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4067C5DF7D
	for <webhook@archiver.kernel.org>; Tue, 18 Aug 2026 17:36:25 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com (CH1PR05CU001.outbound.protection.outlook.com [52.101.193.57])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14428.1787074582092662817
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 18 Aug 2026 10:36:22 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@agilent.com header.s=selector1 header.b=GPizdZGP;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 52.101.193.57, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yf6bS9JDpw03dYs3ELwFk94cUNptDWEpPU2++Ry6YN6fWXg5C8oR1FjT3GGFTI0C8TcstmKZ0xxtf+c5T1jgNWASU7stEkplBk/nRGsluNAwqNUDFmr5BHvVhHmj8R0bMbA2oSUSuh4sVvzFZEtZ3R4M/d7ZYdiXKGSnt6BULIIzLMzJyGYUnBXRYVS2TKBLWzKJP2tLfXj4p1ldvkOjk7bR6X4bZIYQByklXKIl0iQYpXpUeop9b3KtsD7QltKHgDDitTZsLzaFCMfNnV0xDh2oz2kYQLi+TuSktU+Oc5hLnu/ySq7Ez17sa+7YvgbiaIPJvy9U1N44EzjbmcrNrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l/kHLOJTpcMEEDR+C1YUXkwdzrtTvJfGvyme+8z4FzE=;
 b=RTk76EiUnWbI52+JB6CQh6/RN8PtUbjBynD63ztzB7/MHIgkc6OzAvMGL21t7yvah/xK80jDMZSVlgPYJdkXIs3P2529dPZViU5/e9nwCvaLAF0a/P+yol/IbcC5QCY23ZG2iJoqmcSwSAqtL4ilRVsXWJvcr5e2lr5+kQ0NhyVOxJQJrMOoygO8aQ2ngz835kD5+BUMmTXVWv72v3poGuM9+whPinaWilwgLIOz1UhFFCrmQPgHizk5qXXUlScyXhHEszSxLyXN3aZBFPYU1HjNwR1z0CKRk0wlWO2JIpAMOJOOrbUZD86qfL3xW1aglPFowaAiWgfTLBhW2Homdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.39) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/kHLOJTpcMEEDR+C1YUXkwdzrtTvJfGvyme+8z4FzE=;
 b=GPizdZGP/G45nCyEm0pFCJhF3/tZVbvvPnIed6k0FP6eCcBLBelBUNzc74P8jFda9HrHzKQpb1TuHdtVxVfgsJg5DTBpiRaTozxdt2Ck9ym3W91Ozr0JrbLnXZdmwvWz/g0C9fxD1W+4/RRAVfwuk4bOs/tQIeTEFSj79k8hB16qFRBxDth4cipKMQq4KD/hlUvBKc6xrlCPFs8D03CMxLNzWuKMiekfzpRKAD/KgPdEytccKtXLirI4oEhf2Lh8Km8ZQFel3m8TOO982Mk4/ht2uZQ9g+Kn7FFRzj4VZIuLm6mh6rRlWHVuLcgaUua9DpItNt64N8pvbCLVwFRnYQ==
Received: from BN9P221CA0028.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::10)
 by DS7PR12MB8369.namprd12.prod.outlook.com (2603:10b6:8:eb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 17:36:18 +0000
Received: from BN1PEPF00004681.namprd03.prod.outlook.com
 (2603:10b6:408:10a:cafe::ab) by BN9P221CA0028.outlook.office365.com
 (2603:10b6:408:10a::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Tue,
 18 Aug 2026 17:36:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.39)
 smtp.mailfrom=agilent.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.39; helo=wpcosapexchedg6.windmz.agilent.com; pr=C
Received: from wpcosapexchedg6.windmz.agilent.com (192.25.218.39) by
 BN1PEPF00004681.mail.protection.outlook.com (10.167.243.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Tue, 18 Aug 2026 17:36:17 +0000
Received: from laplante-B650.lfs.agilent.com (192.25.126.4) by
 edgeappmail.agilent.com (192.25.218.39) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Tue, 18 Aug 2026 11:36:10 -0600
From: <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: <rob.woolleywr@gmail.com>, Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH 1/2] pyproject.toml: remove broken [build-system] section
Date: Tue, 18 Aug 2026 13:34:06 -0400
Message-ID: <20260818173407.2657441-1-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004681:EE_|DS7PR12MB8369:EE_
X-MS-Office365-Filtering-Correlation-Id: 08861cea-a8c5-41ac-5ebb-08defd4f357a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|56012099006|10067099003|6133799003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: 
	XKnCSuTdd75OlmiNC8LU2YpBSYv+j6yPr3PooMc7mGuYlXQRw4it3t1zIC5urcApj/WHCJlUezl+lLozOepOzWCh2WI7kgF9HdUmAP7EnJ1dC6gINIC7AdzGs/Uy4ISAH8WLIbkRwhtmbUJ8WoJuEUr3hsmg3JVQGeq6v05bE7IrCd+zE7LdFK4Bc/bRbe4ZkhnYcYP7dzEkiNu/SRQ6JkJQ2ajxAHIzdBLXIqT9EZD/WZcUNA5Z+1TTGquJhkVFyrhWWkLUcxcpQ/H+ECvgfree1fY9QBDUjn7C6DCe4gsBVntpQYvMimwpZScKKZ6zHCBicCW3fnt0HNnk+6ZsOB2BpuzcXSJcKHL1te/eRb3/nvz3NkTl26UNqihwA+gz5oEVr3H3fDLUeOvbpcVT+sGwOyw+tXqDeW2Hbdn9N4uXHFa4Fh7EaDV5NskkQJ7RIMSxr4tGV8K0KULeko+aPfPbicmZNDLnbwQCRKynA2UpNANkxWu+VQb0qN/39fJyKeN6JjjEZuCdhl4qzPCuvRKHEEv85ZPMrTKQCr6iuKT/+jc5xr6HvO6MDMXX4x0vk/Z4+XbJO4Vicl9T4wsMqpl5kJ15VV7oT3edMqUPHrrbqiSiXAZ45g6oecxn2qOqzNMMg+BbaCTTMZbTB0sB54oUuZZqfLDeg69V1m8Mear5vi7mlsyHAgg3vcpe+w0WonbnJXYtLb4D2wJJidGfRQ==
X-Forefront-Antispam-Report: 
	CIP:192.25.218.39;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:wpcosapexchedg6.windmz.agilent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(56012099006)(10067099003)(6133799003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	Ir+ZEr7j/m8NfqpDGLV0A1SCdP/aGvEsywl6O3ZJdoi4tyUJQ8TrLi6EKc1jG5X4Fwzj8a4898LWalogEAxQ6GZTSyRWmgFkfswhp9+8E5x1uCAJoYS95AEkRa/zAM2HQwXjs4PISFLpxvP3ECEpdWnKAUCGRjOnLy+OJm0EVo7mL1BNLGCjvX9OT2n87dfcQyGxifunrswnZYpJcKh86WweXhY1C2+XVUZRy+D1BQvCQIj20XICFAh9rfRkgEK/K1x1nRP0WkzJIk27PGkVx5qJT1XBW5+P7wysAvcOj7SHlp8E0/ek0Y83gneEjDfYngbEW5/bH+ZDeuCpUwFmKSI6iibyd9bM4btrEaFQSqc1pCnetTMf/NjdaXjegFX7/T4NJWwxSaQAvnoH8LdXDTq9c9/l40wJcGTfsrXOkcTkTJhC1AfQP0QxeUFGuPCd
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 17:36:17.3232
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08861cea-a8c5-41ac-5ebb-08defd4f357a
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.39];Helo=[wpcosapexchedg6.windmz.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN1PEPF00004681.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8369
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 18 Aug 2026 17:36:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19980

From: Chris Laplante <chris.laplante@agilent.com>

The [build-system] section specifies setuptools as the backend but
doesn't add setuptools to the 'requires'. Since we are not currently
interested in packaging bitbake, just remove the entire section. This at
least lets IDEs like PyCharm create a uv environment correctly, e.g. for co=
de
analysis.

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 pyproject.toml | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/pyproject.toml b/pyproject.toml
index 93508d92e..4725e860b 100644
--- a/pyproject.toml
+++ b/pyproject.toml
@@ -1,7 +1,3 @@
-[build-system]
-requires =3D []
-build-backend =3D "setuptools.build_meta"
-
 [project]
 name =3D "bitbake"
 version =3D "2.19.0"
--=20
2.43.0


