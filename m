Return-Path: <anders.heimer@est.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D71CDE009
	for <webhook@archiver.kernel.org>; Thu, 25 Jun 2026 07:08:15 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.24])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5833.1782371286374348394
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 25 Jun 2026 00:08:09 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@est.tech header.s=selector1 header.b=SkYGRdEi;
 spf=pass (domain: est.tech, ip: 52.101.69.24, mailfrom: anders.heimer@est.tech)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E5AhQzarRRKh2oAtUrHAy/peQ1O5acUFIwQoT3QpdJHTmWBCUJpIRMQ6ehjFcnebEU8m1bP/EYXZvbRHTK5oyCs2DhSePiis+SO6XzM0MlOGOw5R//XhsvtQLynx61gVICKaE5/WctiOhzTd/B08lRG11rSDGO2dF6UOEhr541H0bev1qcCUWB9qzrv6Ws24RYdtJlNMtlHzqCD6EWJfHzMAMOI6cdtMF/OoEPojbwEv1jvDVv3a5+k4n7ldCf4TXXkzdR8qNkqjGKjrehyHuxXTJzpcSKie1IHsLrazZ5piIdHzX3NsaDzdNW7eshYfNVUoweONlb+1hunabq8YuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=otSTUM7VM8t7IVla4vqaORn8eYvqSbwdEu1IxNugCfY=;
 b=HzygVZqej6gzlDzsDmgccadI7qED3wtXZTqK7fBvEmTLHBcp+U2ARGP6VN2nSBP4x2KIJqp+1U3SR+iYcHyrxoBMQjHIZgsDDUFPBRBmNSywA1RSknR0gw9//G4T4cELT2eQPCOJHeAMdUKzwkuNg7F4dhqsiHo6xk4DFc8nz+17pm5iJfiQIhSVKJzPSe0c74vX/0CTdFShQpPI4/V/QvtT09EVyFwVUwXboQjR4oJS2iIcIY/KZWyx8M6Jp0pMRAYxdIeSBBBzr93RfoAvb9Dj1+TdNtNG3o9QAb6031ie+/2CRMkZVC6dlC92ohDT4wZno23+U80MTtnTT8RWEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=otSTUM7VM8t7IVla4vqaORn8eYvqSbwdEu1IxNugCfY=;
 b=SkYGRdEifipny9qMJpYyaiOWwcCnQ6K48kiXjsanJ06cMdsbaFungHeypfuwq2k5RWj90mMX6GaUEZbogSc2ZHdYWsUezGHOOzb5gw24SprNuLrItjOFlw2jC4EpVIB4T2sZ8NH+vx5GHwX+N7aFWSm8ICYSrld+RYk6Txi2Q7D3tEvjMbBhBaPiaQCG+9qbUomndwuHaEZaJVldEJ6NB2fzyqdn+wFPFdPA+w6rfgsf7dGQVWwd7QTwZEgTjPCTmcygK1Z3rCOxqW91QdmiCkDuraGf4WONcKvi0qJEX6G4pnPbtGeoPwwTsCX+AYOoBmYqUSLnq+mySlEUe03tRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from DB9P189MB1641.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:2ac::9) by
 BESP189MB3178.EURP189.PROD.OUTLOOK.COM (2603:10a6:b10:f4::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.14; Thu, 25 Jun 2026 07:08:06 +0000
Received: from DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
 ([fe80::90da:b700:f102:5c82]) by DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
 ([fe80::90da:b700:f102:5c82%6]) with mapi id 15.21.0159.015; Thu, 25 Jun 2026
 07:08:06 +0000
From: Anders Heimer <anders.heimer@est.tech>
To: bitbake-devel@lists.openembedded.org
CC: Anders Heimer <anders.heimer@est.tech>
Subject: [PATCH 7/9] fetch2/sftp: fix port and remote command arguments
Date: Thu, 25 Jun 2026 09:07:48 +0200
Message-ID: <20260625070750.2757558-8-anders.heimer@est.tech>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260625070750.2757558-1-anders.heimer@est.tech>
References: <20260625070750.2757558-1-anders.heimer@est.tech>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: LO3P265CA0029.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::7) To DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:2ac::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P189MB1641:EE_|BESP189MB3178:EE_
X-MS-Office365-Filtering-Correlation-Id: 41f86744-d791-49d8-4e96-08ded28881b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	IY/TAsSm5Py91ci5zmGkfJy9FSdl3BHvnVKV+NEdEjZvcI7/nXcVGql4Us746DVlwpe0io3yROJHc7avEsTS9mAbYvWNGrh6dE5QddC7AZVgDw3nJ01VdLyA7bhCYhjHPvJ7YVkCqvQ+rXDffs9K4VEgV75PNMPYozzHaProw0FbGDL1VdKMHHeZGc6oD+gpP7E4VHGAkTnzVJltREbABK+PpRp6uxV5xAOZ4fX8Ph7+e24SdAph2whbQPqVKpkQb3f6cX2WiOEt7HsYrIpIJAflqmVUqIVoxNJP9N/yY5hNGuAT7uYRq+uhwKYPdVhUbrxSccqmSrWTdeFVy5FfewiYKcq/DaHQgX7ibIS2+UMpzRhh93fPvvqrThMfHy+qTeHgApR2M1JrmVre1mZBfNjWETivk12VJDzryyzPychc05AUDkPS/KReAhcOXKaTPb+P4u10ZfhWFQcGOph4fTbshM9L99BlvmDMnREYEItXQbUQvvhpgXy6E/atTxz7Sq0WTvzIuooYLutmkVXpyVkrrP7LqvfSVNrxO2/rFjNcJR94F0E2MWldWWz821irxzrOkciw8ozEQvTx6y9hzrfbuuBdKaY6SAGOJm31gur5x8s0oRiIWfBws5tVG70gMBCdoPcXNFMIccZyc0TAbHhpqmT0KpJn/d2UnFtFbSg=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P189MB1641.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?JtUEDXvINn+asC4D/26+pgNKN7UtzuSKxVW0k7IMoijxnww8G7qOYYK9Zeyq?=
 =?us-ascii?Q?AbTqzR3QCH92/WmlXBwU39iwEZqacYRmduE6zhpTGsJdJi75+iR4emFGvEzF?=
 =?us-ascii?Q?4/k7ku2ATXlD8wKp3kTTJySmyK5jss1x3s1Z0J+BKW4+La0UC8rf8zAhWm8j?=
 =?us-ascii?Q?KCRxWNP181c3V2WReiQxGN4fmqD2eFLWX2tXvmydwDrjRNJmRY8a2XgNp+d+?=
 =?us-ascii?Q?meXX/c71WMn6Sikl7CcMbgbEcajlwbkhhGKnhEhXCAYLCIE+xTGGyfmJM5IY?=
 =?us-ascii?Q?OUHF8/nKf4MtIe4oM9mpjGf9hqaUkwJuTIsm6MEY75Dts0q7dYbTj+fezhME?=
 =?us-ascii?Q?ePSp7EtglVmtWAABJZIxO17IjwLwkkp2VLcgMJBqfK+ikP15JjoKjuzM5nuJ?=
 =?us-ascii?Q?sj9WwV96f5TWmldpZoUKXnnoJCTSBySD0jl4mpHaUk4kzUxuARY/CUQfZpfy?=
 =?us-ascii?Q?1MDuDnu2nBX6laCDsEcbtcTkh9pLdcB+5MIUcnR58s1kcW+Jr7VRMVsUqW1h?=
 =?us-ascii?Q?036HkoSo1YtxmWVMpq6O55nwnhXSt6jJt76c2hPWd6CxP9DGTDgJB3heyWEC?=
 =?us-ascii?Q?IsYfl/2ULgaYzXbucp9bmSncbXHjBHWBCF6uEVdGLVSv06xVqmggWsLQ7Txp?=
 =?us-ascii?Q?q62MhxBg9rjwoE0QakP7Xy+3pt4Zu8Xd+z2zhZ+5oDDvSdgpZ7D40v8a/UTy?=
 =?us-ascii?Q?SrdfYlp3AO41Qi3LsVFb05kqf4TxAp9CNCVSK7nGiBUtPJvoZx2MKYBmlAEJ?=
 =?us-ascii?Q?iAFvAKDd0QGb49QetsNevyFZDf+fqn4IFBJPDQDUUXhws5NTHWZfQKTQSDep?=
 =?us-ascii?Q?GRigwXRiiAHCcPRdYKltEcFHwuEOINAFI+4f6oWF05Y4hZpq2BLcJo2p+hiy?=
 =?us-ascii?Q?TzhRKIlSsx7OB+nQnbxS0QQOVU9nMq3wApF7gC6MeyPTJwWEbR6owLZ4UZob?=
 =?us-ascii?Q?wEl/N3schMHkx7vv3jI0G6cYQksEcbJ8Nswfrf02GjlV78iV/w35n8Xrc7X5?=
 =?us-ascii?Q?yPRMyx2mJc8qbKQkmY6JXtB23C3DUV30A+jsKqifC8ppuSDa/g0U4jHFqdyB?=
 =?us-ascii?Q?MlGKs0YVyXVawRzwESseI5wX0tT/2RQjhWuJm9zsMU4WbvgwW7W8HJpFFsdM?=
 =?us-ascii?Q?o6inS+vIlB0ZGYUWMKZkVjg8Lte29kHj9htmbE9Lx+rCMAp5NjGwR3jW1CmL?=
 =?us-ascii?Q?PfeaEmCN5KE5O6pebu6iqtlFpzZAKmxAl+IuasVxZkFuaqtVJ5KPMLKX0bXI?=
 =?us-ascii?Q?Mw6LO4pQ6l2cmndw4w+T5nOdE370tm77vbNueNf9Zov2mHh2QgrpvlNIH8Tv?=
 =?us-ascii?Q?APm30lqVcL2EIWmOa36gcnrEyflcbSsuGC32ouKIscVgvOKcgAtEvh2fpH7G?=
 =?us-ascii?Q?IfAg7AhIW1Dh+tGEpraqNNJ36zU6jSVFWjvBLvdE/16W3lrsXp4LV7PvEnrp?=
 =?us-ascii?Q?KUrVi/3yFWQTuXnJihrJx08EaTkNe9ArQTe/uCjiaZU6y54h6+bwQByuaNCv?=
 =?us-ascii?Q?ubZFgUcp6f/GYWWIXPgCfTVNjc7XMVnV51/MYOcto5UM3b4k1yc6XC4h+I0l?=
 =?us-ascii?Q?m7Y01UblkMtdOaflHrdI/r5I4mQz3qlylVB8ws5LQjmw+ygXJTfOilin7nSD?=
 =?us-ascii?Q?F8JoHXd8jthix9VMbw/qiT93zToyqAiz3rNmMawFGefG+oy/tUzvEOhgk9Rt?=
 =?us-ascii?Q?ksG16/3/hO1xh/XavQBjIi8LUXAnQtISY/K/rrzGDsMENtgE0/ZC+azxD50S?=
 =?us-ascii?Q?YFLH7Gfg9Q=3D=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 41f86744-d791-49d8-4e96-08ded28881b1
X-MS-Exchange-CrossTenant-AuthSource: DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 07:08:06.7284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cshwbvwao4at7q9Qz0bPPZzHAOUX6yT1Aj4MGkZweVottezGEpa0hC85Hel/jouad5CrLUN+iNInuB0g0hN30w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BESP189MB3178
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 25 Jun 2026 07:08:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19786

Signed-off-by: Anders Heimer <anders.heimer@est.tech>
---
 lib/bb/fetch2/sftp.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/sftp.py b/lib/bb/fetch2/sftp.py
index 959dc6ec2..82c76bb66 100644
--- a/lib/bb/fetch2/sftp.py
+++ b/lib/bb/fetch2/sftp.py
@@ -85,7 +85,7 @@ class SFTP(FetchMethod):
         urlo =3D URI(ud.url)
         basecmd =3D ['sftp', '-oBatchMode=3Dyes']
         if urlo.port:
-            basecmd +=3D ['-P', urlo.port]
+            basecmd +=3D ['-P', str(urlo.port)]
             urlo.port =3D None
=20
         dldir =3D d.getVar('DL_DIR')
@@ -102,7 +102,7 @@ class SFTP(FetchMethod):
         if path[:3] =3D=3D '/~/':
             path =3D path[3:]
=20
-        remote =3D '"%s%s:%s"' % (user, urlo.hostname, path)
+        remote =3D '%s%s:%s' % (user, urlo.hostname, path)
=20
         cmd =3D basecmd + [remote, lpath]
=20

