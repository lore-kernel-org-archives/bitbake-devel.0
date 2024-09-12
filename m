Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B642EEE266
	for <webhook@archiver.kernel.org>; Thu, 12 Sep 2024 21:06:35 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.23])
 by mx.groups.io with SMTP id smtpd.web11.59129.1726175187596259202
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 12 Sep 2024 14:06:28 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@axis.com header.s=selector1 header.b=FffDLS4H;
 spf=pass (domain: axis.com, ip: 52.101.70.23, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G57gt6xmiA8uhZRVe4fVcb+KXTbLbY5wl506pwyfCILnN4+hSKhC52THSzOuRn61O0u94PlASL1DrHdqf3Yz5zTZfNrlYPXEcxqGGxj4t4BYNFD1LnLbdT2r0RrtHjdzZk5c+YvxQUCLWHljS8DGOg+3C6pUw0n023vcTlzU3FehfwM2s+6zFLhiRL5l2xcrkbxEHx/9Zbg6XojqCrU+hW/XD1wvLRqGN77tRVcvQ+ZYc0vjg012V6hkaK4Vl531SSzaGzRebLu6EVmB4T426EAXpgJcMjkby/mmY2BC71wOUmK76mpQhZIquJ+zUqQnySsdfZ4rM0YPJWj5NvTOKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DwoTXmhmKWgflHuoCsHDP4CvypJX57sz0nwx87IeX4o=;
 b=fFhfImPTwGcXaMTPhWTcQALDxmMBQ11X6doWz6+qrVnAzHSgXbFGqeTaHrcFP0VNt0ADQF1qJFnzozJ480FEjVLNRjSRsGgd7dOp16rMtVDBNSmSfZKjW1iYwH+0T15IDjYymgQFbLN7k+pS4PqUAc9nuKz/G/ro2R7v4SkyM7Pgj0nwVuwWEoBuwqFElTyrfUNi+YMLGzDa8teyjbooAdHCNRmFwN/Yu3099M54gk4w+RhBLrsSqw2IoSkQYM9UCZkYLvcPHXhm7wbn1dbSJEwY6APclOYklBUY2vj92rBCaMVBZ8lyXSB7Agj/iiFZMxC3+144mutsC+sg1HQ7ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=axis.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=axis.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DwoTXmhmKWgflHuoCsHDP4CvypJX57sz0nwx87IeX4o=;
 b=FffDLS4HJdyy8vcJbF8cZa3w++8/r4aVCBfp+lQTwsg7TeJ5DOzZwlpEnCGh0B2+irIsRMRxFCKp6s4mdJ3W0N7dlshqB+MKNHIEmCSLdoAH0FPH/1X+8v73cPjcXt/n+i+UAmmtu56NgufYX4Y1UDNLhqY440/ayyKGoUBo5gI=
Received: from DB7PR05CA0017.eurprd05.prod.outlook.com (2603:10a6:10:36::30)
 by GV2PR02MB9373.eurprd02.prod.outlook.com (2603:10a6:150:d2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25; Thu, 12 Sep
 2024 21:06:21 +0000
Received: from DU6PEPF0000B61F.eurprd02.prod.outlook.com
 (2603:10a6:10:36:cafe::4) by DB7PR05CA0017.outlook.office365.com
 (2603:10a6:10:36::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25 via Frontend
 Transport; Thu, 12 Sep 2024 21:06:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU6PEPF0000B61F.mail.protection.outlook.com (10.167.8.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 12 Sep 2024 21:06:20 +0000
Received: from SE-MAIL21W.axis.com (10.20.40.16) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Sep
 2024 23:06:19 +0200
Received: from se-mail01w.axis.com (10.20.40.7) by SE-MAIL21W.axis.com
 (10.20.40.16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Sep
 2024 23:06:19 +0200
Received: from se-intmail02x.se.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 12 Sep 2024 23:06:19 +0200
Received: from saur.se.axis.com (saur.se.axis.com [10.92.3.10])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id 757921B1
	for <bitbake-devel@lists.openembedded.org>; Thu, 12 Sep 2024 23:06:19 +0200 (CEST)
Received: from saur.se.axis.com (localhost [127.0.0.1])
	by saur.se.axis.com (8.17.1/8.15.2) with ESMTPS id 48CL6J3n1042616
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Thu, 12 Sep 2024 23:06:19 +0200
Received: (from pkj@localhost)
	by saur.se.axis.com (8.17.1/8.17.1/Submit) id 48CL6Jb41042615
	for bitbake-devel@lists.openembedded.org; Thu, 12 Sep 2024 23:06:19 +0200
From: Peter Kjellerstedt <pkj@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH] fetch2/gomod: Support URIs with only a hostname
Date: Thu, 12 Sep 2024 23:06:14 +0200
Message-ID: <20240912210614.1042592-1-pkj@axis.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B61F:EE_|GV2PR02MB9373:EE_
X-MS-Office365-Filtering-Correlation-Id: 16087a37-96cf-416f-719a-08dcd36ec00f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?cQzQjdjcBK2nj+kKFFyhvV0T45WJRO4GPjlxjhiLKIVFetGrNkU0dRVUs2hw?=
 =?us-ascii?Q?ZKkB6i/Lyv0xo9Xe/pYB3DnHiKujJDT3EByud0/UWlwSE9jA0gpdDkNcca5J?=
 =?us-ascii?Q?44l4yjDeSfEqHUgJs+i4Z6EntFUAuPn3ywrPv+LOcAORmf6kG0E7iDrHjNyc?=
 =?us-ascii?Q?FoCVBU4LdFYJ2fNPXstMtz/tn5bWpM1jbzfAIXVrGoy/WzX+AxwTfO3UDTCg?=
 =?us-ascii?Q?aKXpRbUZHroqMzOLmDslLDWuGPkMoOgxsBmBVLL+3Gw4GRtsGfWH8n2RdUrb?=
 =?us-ascii?Q?PqFrxuFtpYkqnwXIR1wuyMnld+qummPv42l/sOI3m3FTBtQ17Lzk8wmi15+H?=
 =?us-ascii?Q?lbQm/qjBITTsRlq+vrDWD51Nu1UwogSG0dEyKsu1I464eIfUPqewOZHtBEQb?=
 =?us-ascii?Q?zoIXmTWAjjP0TLDTHWESEfxGcycf6nQ0H8l25oWfAOXsYCbyM6KgMH6qPvMg?=
 =?us-ascii?Q?Z6LzcDdczkFY8ECvk+bOqSvzbe3kksRdQLy+i1E2byhtXxBBgCmXvIAq+7Je?=
 =?us-ascii?Q?ZvssK4UkYogaIchqhN1uaxs6oFf2e2x4eJPzN/xRtGU4NVl5S8xjLwBugOKK?=
 =?us-ascii?Q?sabavf8XTUMNLe1OcB3fQf80nqR97tKxugvdwxOq8Q5cWLxYeZ6EQfMK9wtD?=
 =?us-ascii?Q?IEN3oiJ+YMIxfK8X7pmYCUz5od/JlfaDcnHl2ZAFBmZs417SdKrqW0BTp2RM?=
 =?us-ascii?Q?P2sCUODmPvyJeB2OyvrH8+SrJ1B+QKPKflTP818KlsbzXl5U0jjwWdaOPtgq?=
 =?us-ascii?Q?PqAJ6aAIy6psgMWI6x6X6NhomIqGlgHh0/P23dLEgCU+/35iVYSLLJrHajRS?=
 =?us-ascii?Q?IeceKo35dY0SORaufGHVyWICTWkvnDhD2DOoGCHTnf0m1j4qzTQwQfXNy2UK?=
 =?us-ascii?Q?48+k/x5fM5QZ5j0BbLB5SJi2j0mPu9uuqjGlvv0FjCSpcsAauSFwjdzyx1ov?=
 =?us-ascii?Q?d6kqiWJCzX1G4nmYCiC0ShRV2oYbyp0OvGL6yvUSWkyu3WU+SKw0VgOYsFWW?=
 =?us-ascii?Q?tCCLyP4V2bCWrS03044/thE8G+2sMWOmwibucOweLUi+c3FQgu/mygID26m8?=
 =?us-ascii?Q?U75Vl+mInTt7+b8/54EytGFeb2wCrLL4b8gVcORIPGJa/ywHN9lKslYFhqtj?=
 =?us-ascii?Q?x+LAcENgKzpyAj+b0wqPKZecFMvN6OzefghPTj1FCpX6CUDYw1d2NPAieBGo?=
 =?us-ascii?Q?5TzOtt1bEB+jj/+/sfdzV5oTtLBs204VeFtetvH+v8DoxBNFzUHVPtvTiSgS?=
 =?us-ascii?Q?9d9oVRI520tLKtGUupdj4b9/S224+2rcbLiTNncPcMV4i48JsKkMkpJjzsAs?=
 =?us-ascii?Q?HMiCgps/8sWMo9SMpZFez3mFxS1arIfDqA7NavwijYo4HzPkCkYG+O2GpkI/?=
 =?us-ascii?Q?SGc2RGIC6llhPpQxc7SDbXx9gfmpfDkRFmin6W/DihNrjnHHB2wvoSK+tZWc?=
 =?us-ascii?Q?4Dxvqz8rNEtxchIX64HPQY/Ll0grrdv/?=
X-Forefront-Antispam-Report: 
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 21:06:20.1243
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16087a37-96cf-416f-719a-08dcd36ec00f
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DU6PEPF0000B61F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR02MB9373
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 12 Sep 2024 21:06:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16557

When calculating the module name for a gomod URI with only a hostname,
e.g.:

  gomod://go.opencensus.io;version=3Dv0.24.0;sha256sum=3D203a767d7f8e7c1ebe=
5588220ad168d1e15b14ae70a636de7ca9a4a88a7e0d0c

the non-existing path would actually be treated as "/", which resulted
in a trailing slash being added to the module name preventing the unpack
method from correctly locating the go.mod file.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---
 bitbake/lib/bb/fetch2/gomod.py | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/gomod.py b/bitbake/lib/bb/fetch2/gomod.p=
y
index 1b532d03ff..21fbe80f56 100644
--- a/bitbake/lib/bb/fetch2/gomod.py
+++ b/bitbake/lib/bb/fetch2/gomod.py
@@ -103,7 +103,9 @@ class GoMod(Wget):
         if 'version' not in ud.parm:
             raise MissingParameterError('version', ud.url)
=20
-        module =3D ud.host + ud.path
+        module =3D ud.host
+        if ud.path !=3D '/':
+            module +=3D ud.path
         ud.parm['module'] =3D module
=20
         # Set URL and filename for wget download
@@ -174,7 +176,9 @@ class GoModGit(Git):
         if 'version' not in ud.parm:
             raise MissingParameterError('version', ud.url)
=20
-        module =3D ud.host + ud.path
+        module =3D ud.host
+        if ud.path !=3D '/':
+            module +=3D ud.path
         ud.parm['module'] =3D module
=20
         # Set host, path and srcrev for git download

