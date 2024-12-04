Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32436E77170
	for <webhook@archiver.kernel.org>; Wed,  4 Dec 2024 17:30:55 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (NAM12-MW2-obe.outbound.protection.outlook.com [40.107.244.42])
 by mx.groups.io with SMTP id smtpd.web11.20530.1733333448152118948
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 04 Dec 2024 09:30:48 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@agilent.com header.s=selector1 header.b=i553JzHg;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.244.42, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MCnDi5Gj5OD5vCfSeAlhTpmQCbLdYFnE4mmioc8fSLMCh1MXVGKQHqy+7nCZy+irj3LBJhHs+QaboTk5U1ZJEIsN7LRHh8yXcAo2xnUL33X7+6yvygamolzN2/GrUOpXBAPj77+ijhdsejICCap/6zv9PrQrrApmi281Sq/z1bR/EKsJkJBRQhH3f0J+poXMPyfQeuXdNyxMLzU2MBVHE1pCYOmLE/efWBea0qrJOBTLKthKlDkv3RO3ZXahcnipXC6qhcSHYUGqPDIw+EUyXaBxbstibU60J1KRAVyq+gPqqZ877tbnug6aQNcDfPDnjea51CCQIZAKQe+FL1WRhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UNm4bO4ykJgfY+nxEWg/INduHEaE+CX1qQW7L7gB320=;
 b=nWKPoyhcG3nASCjnmqACtEewxKXeDry538RDIY+70P3ZzBXegnkz0hOuAwLIf1RlFDqoXjZc83WV5k6Yare+RUMHzrSeEz2TNjmNKFAuTc3L0zvZPmo2uHNWOfisvM1DkiyN/NM4PWww8MfqbU+BRN8WbQel3fWQESSec1eo6EzZ9Wzebiefhz/kQOQ/qgEKEYVVvZCNOg31yaeBEcfRx7JLv4vglSvT8jZgaFAZmKm2jY3+jEtV3kO4o3jkZsNez04rOq3z6PjVcTQB0/n/0n6Ub8mSMcBF9ZHEW8ztD3wQT/NYc4wk9mWTjGO5doxD9PM8bSDhb0kfYOkNs1UpCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.37) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UNm4bO4ykJgfY+nxEWg/INduHEaE+CX1qQW7L7gB320=;
 b=i553JzHg9hyA4CEOMrjtwcv3j1bY2QWww+6G10XiQpP7aAE90Xm/0PJjcs8mpZpazyShoZBJCZ8RJRlyu/HzWrGnXPmG80dZSnLiJONVuoMaCC3kJgswiew1FGb/Y06YGjYLikdqW/b84wdmNwCc7ZUOPRNqM0A3QWXlSf0G7C0N6JCQ06Wa6CEZ13JayLqRA5VWahGyC6b+zf4tO1iR1bqqGoTBh0xImR8mc7rcbwsXUikxW6BD7d74Be5mB2eOxfy9Q7eQTCURtpRrxvgANtybdTB+eFybHHZUwJwqyItwOVbEqxclniJSXe7gpHDdPQOVeHGtOWfHKGqh2cK0Nw==
Received: from CH0PR04CA0069.namprd04.prod.outlook.com (2603:10b6:610:74::14)
 by LV2PR12MB5943.namprd12.prod.outlook.com (2603:10b6:408:170::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Wed, 4 Dec
 2024 17:30:41 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:74:cafe::30) by CH0PR04CA0069.outlook.office365.com
 (2603:10b6:610:74::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.9 via Frontend Transport; Wed, 4
 Dec 2024 17:30:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.37)
 smtp.mailfrom=agilent.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.37 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.37; helo=edgeappmail.agilent.com; pr=C
Received: from edgeappmail.agilent.com (192.25.218.37) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.7 via Frontend Transport; Wed, 4 Dec 2024 17:30:41 +0000
Received: from laplante-B650.lfs.agilent.com (192.25.126.5) by
 edgeappmail.agilent.com (192.25.218.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 4 Dec 2024 10:30:18 -0700
From: <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH 1/2] server/xmlrpcserver: fix some warnings
Date: Wed, 4 Dec 2024 12:30:10 -0500
Message-ID: <20241204173011.1415479-1-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|LV2PR12MB5943:EE_
X-MS-Office365-Filtering-Correlation-Id: dd4cd675-e618-4b6d-e54d-08dd1489603d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?b31rTzzwAUZc6Mrwr6sHEoBajyF4fK3Yieskkma/x45yOOPWdZH+JmEnAevC?=
 =?us-ascii?Q?5n67AwGjmwDMZO/Nsyh6lo8hAxYNxhyjgwsqT+aSVNHSXK+ojAGK7v8Qf2So?=
 =?us-ascii?Q?KY66xZ8hzY88woBQ1ODD5A0gnLAWVZziD9gYkZPEDlEo4vtlMiL2e5UoDrrM?=
 =?us-ascii?Q?AKPXpsfeFw4AecaBpSf7E2VNWdjp+jKMf5myprQ71Nh3XWQVs7QAgEyGTHaC?=
 =?us-ascii?Q?25tt+SSq7fqbFssJutSsv7vDjB5w+P4YtTQsiRTM+z44w1Ew7mueYyl/iabx?=
 =?us-ascii?Q?hqCh1dtQ64UBXZd0X4LXChIbboZ6wtpMax35TJ6SDU6dr5iCs+SH9+6SwmVn?=
 =?us-ascii?Q?LXERXrLiNlYh93RRSiGU5QvELcO+hs/HOBOAK+1wg9eG03GWPv1N3fszPFDi?=
 =?us-ascii?Q?DXSblI+TiObg81j5s2UwmZNrlHC9Gj1D/bQMwK0QtuKJ2tKu5xf+tOg5QoE9?=
 =?us-ascii?Q?ykZ92qQgFgIAUETG93M99mEpODtjbs2qbVh2Vct9T4ThzhyueuMUaEZVLLm8?=
 =?us-ascii?Q?A6cIwcHsIp7Wu9TOGCk3jIZBxepiRL158hyKIDUOtJ+gAe5moqBB76teBrNj?=
 =?us-ascii?Q?ELtSUT2W1pa5sWHOiJMZBoxPNg5k+atGQRcprTpz2OKPi1talvSXp1/hkK2v?=
 =?us-ascii?Q?/3MzL1iEiGmHzypHydAw8W51qUR67W9uAq3lW8c29pQFT3YLr8GxqhGXhhzG?=
 =?us-ascii?Q?DJntKOIgvrXFnl11LcWVxCKOjVOo7IzX/1wGK3lef9iWl1V4LA+GRhyQ9xqs?=
 =?us-ascii?Q?2m2tGIZSf6UVSwbeI9I3OYF4sDdGeTY2pyVqIxoTJ2QMxQ7gE7ReGXa3WUoo?=
 =?us-ascii?Q?f3CwGioiMbGZCB2gzzQlBkTZeqG5p39QGO6Obts+0o1YcviB18no5JpUTjHV?=
 =?us-ascii?Q?71soMlXLJeM65Xrkh4IRq9LPmUUtBeSQdofOvkC7oUfqiPBnq8B/D7Q/nLxL?=
 =?us-ascii?Q?k8ENkLnUs+MO5Whc61wrdbNpyJSCx03q+gSwGTc0FPD7rCFJhoLGSBdk+TgV?=
 =?us-ascii?Q?AY2+nZ7X4/Aj/mKuRxRnwjG2VpwQXA2f7jC3P42p3gEW8d2vyoyAMVvUKjUS?=
 =?us-ascii?Q?uDX6GpSZmLu5FNIaIo36/2aIGPY2FA17uFnkvVTG0b34sQv0th2062wOK44X?=
 =?us-ascii?Q?JWSO5PmhUDRZypWcli6RMpbc9RflCgz+qxZfeoA8s3VL1R1csX9lIwHpH78j?=
 =?us-ascii?Q?DgwpvFa/m31w+gGcl/9/KxJ+sJ5FjNEAhGVChlfMOZOlmDTFqD0fT1q47nb1?=
 =?us-ascii?Q?fjdnu2AYhrUWffnhqx95hnZPGTro6nlV1Uw5zav1iH1ufYZWXRADuHFMQTGS?=
 =?us-ascii?Q?Dkjy4tPmBeHPxRIMTCPuMzJhGw5EfGU4W0q/aapidvPDbMyehh3SuaeHRR45?=
 =?us-ascii?Q?gRDCM8g7UHC7QdudjMufR109nh20yr8fz9aIraGsef79ur8L5E+mrdmS3N+U?=
 =?us-ascii?Q?ThHmjdoHkiTPwM4c24Mw34z79uwC8UQn?=
X-Forefront-Antispam-Report: 
	CIP:192.25.218.37;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:wpcosapexchedg1.windmz.agilent.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 17:30:41.2972
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd4cd675-e618-4b6d-e54d-08dd1489603d
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.37];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5943
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 04 Dec 2024 17:30:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16866

From: Chris Laplante <chris.laplante@agilent.com>

+ Unnecessary parens
+ Missing imports
+ Instance attribute defined outside of __init__

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/server/xmlrpcserver.py | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/lib/bb/server/xmlrpcserver.py b/lib/bb/server/xmlrpcserver.py
index 04b0b17db..fd4245a51 100644
--- a/lib/bb/server/xmlrpcserver.py
+++ b/lib/bb/server/xmlrpcserver.py
@@ -14,6 +14,8 @@ from xmlrpc.server import SimpleXMLRPCServer, SimpleXMLRP=
CRequestHandler
 import bb.server.xmlrpcclient
=20
 import bb
+import bb.cooker
+import bb.event
=20
 # This request handler checks if the request has a "Bitbake-token" header
 # field (this comes from the client side) and compares it with its interna=
l
@@ -54,7 +56,7 @@ class BitBakeXMLRPCServer(SimpleXMLRPCServer):
=20
     def __init__(self, interface, cooker, parent):
         # Use auto port configuration
-        if (interface[1] =3D=3D -1):
+        if interface[1] =3D=3D -1:
             interface =3D (interface[0], 0)
         SimpleXMLRPCServer.__init__(self, interface,
                                     requestHandler=3DBitBakeXMLRPCRequestH=
andler,
@@ -87,11 +89,12 @@ class BitBakeXMLRPCServer(SimpleXMLRPCServer):
     def handle_requests(self):
         self._handle_request_noblock()
=20
-class BitBakeXMLRPCServerCommands():
+class BitBakeXMLRPCServerCommands:
=20
     def __init__(self, server):
         self.server =3D server
         self.has_client =3D False
+        self.event_handle =3D None
=20
     def registerEventHandler(self, host, port):
         """
--=20
2.43.0


