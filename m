Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D01BACFC509
	for <webhook@archiver.kernel.org>; Fri, 21 Nov 2025 20:45:58 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.40])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.21158.1763757951216776196
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 21 Nov 2025 12:45:51 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@axis.com header.s=selector1 header.b=BKw09OIv;
 spf=pass (domain: axis.com, ip: 52.101.65.40, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HuhADH/QsQTVZYYSGDezs95QqCjmndG4n6ed7Y7YAYHCOiLbf1RQdRUlVGgIaLIxjbeA28wcD32bFkzHUAOwTOW4x2uyNViw7Zkh0bznT3Xbe7ziRabZP+M/iHL+yC0eMILiVvqqRPTeNyqpOj26Cvp2BQJOjw7cb5g+la4pmnJRA1DBp//8ZPulnWDQS6HyphUdVcx7Z+rWvp8TMwSjWjD0Pq11nWjl4teKPdhmpD01GAhJGCnznPVNDk8GC1dgTDpv/XFNsGVefruPw9efUSl9hgs1fpyFmWdckKb33YOl1tROADNblrS2CbYvNff2YvW9NjTVTTK0HeMNEnZ7EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xfNafyjPDqMM4pVabS//KMhP3AdVZVdcdavBX/xEcp0=;
 b=g6V6lTDSzj1eGe/+RWLdcSC1b3dQrc8ICg9HAVlSwO+c/f32yX/8VTlspJqhUYMHan20mYWb7794bHftpUVNwXkqd19Kh91fvdpS0bjSs98Z0Q9fu4RvVxAiPnLarunx7kEsq4nbAovals67APOOExXFSAQ0mc3jwgZGpEGw7slKBg5VpHoP1A+gaqT4TlHqV102nTf2vvwdmMbaJDtihviwHeWEF2WgHcuKr6Bc5xrOpsftTcTmxfAUjWKKuKfzizffJjXCqMsG4F4XixicBDw3w3WKL/+F5NMR2P78cCHZiHNADs5KgZke5tVSVgQp/vy6YMUlEwpZsH92cd/O1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=axis.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=axis.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xfNafyjPDqMM4pVabS//KMhP3AdVZVdcdavBX/xEcp0=;
 b=BKw09OIv7LLAfuhGOG7KHxRFCUQJC4qjOZsthbUFNQgOs8FbYJUY+odxaDGJHuuHp9r378LrfYV2Wnu6zVznVC/RePz06hulqi6Pja28FR3d2j3oZPgkgrOgkMexiYY6d6PoEN6NuJAl2dtnJn22M02/qZBUd65Il+HSvHFqaXE=
Received: from DU7PR01CA0005.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::28) by PA4PR02MB8034.eurprd02.prod.outlook.com
 (2603:10a6:102:2a2::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Fri, 21 Nov
 2025 20:45:45 +0000
Received: from DU2PEPF00028D01.eurprd03.prod.outlook.com
 (2603:10a6:10:50f:cafe::a6) by DU7PR01CA0005.outlook.office365.com
 (2603:10a6:10:50f::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.14 via Frontend Transport; Fri,
 21 Nov 2025 20:45:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU2PEPF00028D01.mail.protection.outlook.com (10.167.242.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Fri, 21 Nov 2025 20:45:45 +0000
Received: from se-mail02w.axis.com (10.20.40.8) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Fri, 21 Nov
 2025 21:45:43 +0100
Received: from se-mail01w.axis.com (10.20.40.7) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Fri, 21 Nov
 2025 21:45:43 +0100
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2507.61 via Frontend
 Transport; Fri, 21 Nov 2025 21:45:43 +0100
Received: from pc56063-2339.se.axis.com (pc56063-2339.se.axis.com [10.92.3.2])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 7C72A5435
	for <bitbake-devel@lists.openembedded.org>; Fri, 21 Nov 2025 21:45:43 +0100 (CET)
Received: by pc56063-2339.se.axis.com (Postfix, from userid 14323)
	id B2822120089; Fri, 21 Nov 2025 21:47:32 +0100 (CET)
From: Peter Kjellerstedt <pkj@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCHv2 2/3] bitbake-layers: Remove the --force option for bitbake-config-build
Date: Fri, 21 Nov 2025 21:47:29 +0100
Message-ID: <20251121204730.4057465-2-pkj@axis.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251121204730.4057465-1-pkj@axis.com>
References: <20251121204730.4057465-1-pkj@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D01:EE_|PA4PR02MB8034:EE_
X-MS-Office365-Filtering-Correlation-Id: 353a2f2e-edd0-4992-bea2-08de293ef1c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?AWULIGYgtACCBzuk/HTyFmoGJD6OLstCrQdOeA4Tgnjz0bcP/yW8Xp7AdEws?=
 =?us-ascii?Q?GzM11qOm2P+mkD4utjF79C+xT94PtvRXvydW7tTZIkeKk++MkL5+6rhsyEX3?=
 =?us-ascii?Q?99u9QF2AYc8MVKXX+JZDgPViOX0CQPIDxJv+StZAkOdj4hUFoFj6AlRkqN3T?=
 =?us-ascii?Q?nrClfX64O+u9M9DvdtyFv0dAauzNQrs9bwC3GTe5kJ8qMJ/vT77Rya2Lkq8i?=
 =?us-ascii?Q?OXaYHy+YQJLxBW0Dk3LDuuXmK2lG1Sf3JbEKaXHaTB/C+vAbE2JcbAJcKRKF?=
 =?us-ascii?Q?Wkx4TnhvFnHKzVW8UsKH9OtcVE39IDPPDflM0LGQomEh0W6Fgo3v9i/2KQ/x?=
 =?us-ascii?Q?JyiB0/pv1fA5st4JFQdHmWgwTI5qTEFRUbwqnIgbDU90HfknS2UGZcdm9bPE?=
 =?us-ascii?Q?oHdIUcnNPmKRHJtaCr0iV8SyYLoOEBm1LwQCKkBFwXgzUzoM387UoXWja6Ce?=
 =?us-ascii?Q?+bt37gcw/gAIFbh8kvJaX1rgsAnn1pThW8xzMMWfwcWwyf0TAuuw82VYFj85?=
 =?us-ascii?Q?DEevcMObsg1PAAhBJU14/sXjw15+9h2BJArGrJuxSnYGNQjlnWmM1wA3efYr?=
 =?us-ascii?Q?R3wO+4eB+c1RJHXGXO3eSklOhZ0OYehiwiV8/g2boZUBHbNCj79hOHQB922c?=
 =?us-ascii?Q?nOqXjVxQJBQRoxgaR94CL+fSi1zz66btYKlMay4GmQWnR8bk4ETWFPAkDurw?=
 =?us-ascii?Q?imxKOa/ZEkZ/HYpwJ9GNKq2g73YWuIoNjRlGidfOqpGthBpRUM/Lt4hUXTvG?=
 =?us-ascii?Q?KG3/D2O5oP+lrJnb/jSr6z2RuzNWucNBJubU9fUfzfbONJ4DRJwaSivlB5Wh?=
 =?us-ascii?Q?JrxEVCGAYBZ5pQBYDAQgkZBRwuZ8MvCWu8hKeVN0IbdOFmm3ZgWnFTjiGySQ?=
 =?us-ascii?Q?QG6FFfYeBJrWcAsUPWUYAlLQOxlaX6h5ay6EgLI+leIaDHzkQbqheKVbyAbW?=
 =?us-ascii?Q?oNmuKU095T9cpl/87DtBwGoIA/iEOV2kOef29u18lQiI1ama2jtvs/E1dHo0?=
 =?us-ascii?Q?QKSwJAIr0e7hmkxy1AkLGpP1aEaeu0q4HFynSrQZR3KnSsiApfrTU1YVF8cz?=
 =?us-ascii?Q?Ia6s3OFRWhS4KQ5x5Zz5sSHMgqdHxO7x+f+SVNYhfD/Y51AtgcanVzuk2Xsg?=
 =?us-ascii?Q?QUyipdU52P3TsuKjZm7DcQPFomuOA15SLfXYsTDYsKnWprVJVZFOn3CP5mmx?=
 =?us-ascii?Q?uOC0UHMeI04wFOZn6YfVZ9HELwiGkzMA0fV4NtaTrtHYQHLzQX3vJ8Q19UU0?=
 =?us-ascii?Q?xybRrRr/IUOH3lws/5XyAQuQ27guPHqpO3bZ4PLSio/aWlKLl0EN4W7e1Wzk?=
 =?us-ascii?Q?qKXuXXT4Gs+VCK7lLm8rCe9VKGhn64wC7vOwJMSwsgTeEfMLRzuu+jgHh7ht?=
 =?us-ascii?Q?wIzv5UnOvK2hY7LrwY5GZvN+cr1bgM8BYdN9PU+NOO8VqtjqdFOlbFKb33oY?=
 =?us-ascii?Q?qbL8Yj8VX2YURwSnDN4M7phS8Xl+pHMFDIFnNig+IVYyfwH/dHRMpl56onGd?=
 =?us-ascii?Q?3qlPINF0/CA4EVmoKZbpku/a8b+K3sqLLcOriBS1XRZi/TFSshPeY6qBtNMo?=
 =?us-ascii?Q?QQwO2WSv+d6Wr6RhPhE=3D?=
X-Forefront-Antispam-Report: 
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 20:45:45.3417
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 353a2f2e-edd0-4992-bea2-08de293ef1c2
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DU2PEPF00028D01.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR02MB8034
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 21 Nov 2025 20:45:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18475

There is currently no use for it, and its help message makes no sense in
the context of bitbake-config-build.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---

PATCHv2: Set the default for --force in a more idiomatic way.

 bin/bitbake-layers | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/bin/bitbake-layers b/bin/bitbake-layers
index 1154eb6d2..c49a5f30e 100755
--- a/bin/bitbake-layers
+++ b/bin/bitbake-layers
@@ -35,9 +35,14 @@ def main():
         add_help=3DFalse)
     parser.add_argument('-d', '--debug', help=3D'Enable debug output', act=
ion=3D'store_true')
     parser.add_argument('-q', '--quiet', help=3D'Print only errors', actio=
n=3D'store_true')
-    parser.add_argument('-F', '--force', help=3D'Forced execution: can be =
specified multiple times. -F will force add without recipe parse verificati=
on and -FF will additionally force the run withput layer parsing.', action=
=3D'count', default=3D0)
+    if toolname =3D=3D "bitbake-layers":
+        parser.add_argument('-F', '--force', help=3D'Forced execution: can=
 be specified multiple times. -F will force add without recipe parse verifi=
cation and -FF will additionally force the run without layer parsing.', act=
ion=3D'count')
     parser.add_argument('--color', choices=3D['auto', 'always', 'never'], =
default=3D'auto', help=3D'Colorize output (where %(metavar)s is %(choices)s=
)', metavar=3D'COLOR')
=20
+    # Set the default for --force here rather than above so that it is alw=
ays
+    # defined even if the option is not available.
+    parser.set_defaults(force=3D0)
+
     global_args, unparsed_args =3D parser.parse_known_args()
=20
     # Help is added here rather than via add_help=3DTrue, as we don't want=
 it to

