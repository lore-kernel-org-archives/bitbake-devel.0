Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D82021088E64
	for <webhook@archiver.kernel.org>; Thu, 19 Mar 2026 02:10:40 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.25])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2356.1773886239804892192
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 18 Mar 2026 19:10:40 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@axis.com header.s=selector1 header.b=EHc7EksB;
 spf=pass (domain: axis.com, ip: 40.107.162.25, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TcqRHDLF/FNOM35qcSzIipBy17kRa4wGb4JnFZD76c/5nNCOqTljahnXgLZOvp6tOC9/MTm0YKmsYSEu+ynSdU8yuiLp4EhztlhK2kzwAm3wNeL4p/nHzncU1l+L/y/kLQIqCfnOZJ4nId62GAV7APhyZAZjDhqBj36+Y/MhDBAS1nnChZpzEKZwLNZD3Kf8O9xZNsc6kdXofysNHbgCepLIGHn4gQW+XUIuc4V29tDcIWXVFBNg/GDgZ7Voc9GtsJNABJVC9vkCDjrqVNcmMWupi5IvtIHfJ9U9FLYy1K5Z5TTpLe1cQ9h1uks4lTFBHybeFjuadhJI5QEsFmG6lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pR3qytAYN7Jqzrwtv9D1kP/M4oECaI67231Ufiph+Ss=;
 b=q0e3w5i4pqcFvqEN6ny4pk9lHS3Gz8m0XUA9OiTMjXpUMxZT5lLgBHVLcsg86o3X90RsljBkgtquMacbZgyxXAyFpKmirsqLOZ9CNAYjvXrHl2vdyEItnq1rP2ihB00ZHEFKZYn47w6JoNqfJDSINWZ6pWDNDVtZ8atEA+vTBF8XYCDOwd4EP6e9swu716VNXLgSIClN+0qFzSfK7RcAnsgc2p6mB9vQ/8vr4vAV9H5LbgivDvmUiznBsZ0gjIZKo1PmQ2d3sbmvYcM3yvvkbGfz9bPtJJXH10huRnEGPo3rK5v6TMe0DJNPN989FMiO35dHxh0RbVYxSlsG/TBKHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=axis.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=axis.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pR3qytAYN7Jqzrwtv9D1kP/M4oECaI67231Ufiph+Ss=;
 b=EHc7EksBg/4D2+WnwzRMRYsY9eALV1FXH8Z8SQxYbBfdMyyNTdImTAOPGoVauOcF89FXE+cycTg7cF7hBTO4DYXpabu9pluYmENubUAZnH0IkA4WzDDWWc5wCAxeS7uXK2byRsNeLlUz7lhRvlmftUcaICrKc/ThqhH7njvzf1E=
Received: from AS4PR09CA0016.eurprd09.prod.outlook.com (2603:10a6:20b:5d4::8)
 by GV1PR02MB8260.eurprd02.prod.outlook.com (2603:10a6:150:63::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 02:10:33 +0000
Received: from AMS0EPF000001AD.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d4:cafe::79) by AS4PR09CA0016.outlook.office365.com
 (2603:10a6:20b:5d4::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Thu,
 19 Mar 2026 02:10:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS0EPF000001AD.mail.protection.outlook.com (10.167.16.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Thu, 19 Mar 2026 02:10:32 +0000
Received: from SE-MAILARCH01W.axis.com (10.20.40.15) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Thu, 19 Mar
 2026 03:10:32 +0100
Received: from se-mail10w.axis.com (10.20.40.10) by SE-MAILARCH01W.axis.com
 (10.20.40.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Thu, 19 Mar
 2026 03:10:31 +0100
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Thu, 19 Mar 2026 03:10:31 +0100
Received: from pc56063-2339.se.axis.com (pc56063-2339.se.axis.com [10.92.3.2])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id CB9A22618
	for <bitbake-devel@lists.openembedded.org>; Thu, 19 Mar 2026 03:10:31 +0100 (CET)
Received: by pc56063-2339.se.axis.com (Postfix, from userid 14323)
	id C4A1112089F; Thu, 19 Mar 2026 03:10:31 +0100 (CET)
From: Peter Kjellerstedt <pkj@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [meta-oe][PATCH] cjose: Remove PV
Date: Thu, 19 Mar 2026 03:10:29 +0100
Message-ID: <20260319021029.1588446-1-pkj@axis.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001AD:EE_|GV1PR02MB8260:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f19b20c-e584-4a67-37be-08de855cb339
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 
	Qq2ASHC3TPWLEfrnkTiqADqdXf2wAbt/NiKeIKrLtuzmazDtH/VIGGBZw+xbKL12RXukr9X7AfbR9oibJG+DaEVfKQZ4xVh/oalhtRWII+5pPmtg4CgD92CNzVINesF0pGEi7T1W4E1ApR49dN6n08HoIfwoEJYcWNS131Py4OCbiki1w5tpy0cZx/9vR2wnwxFN1LmEM2N20A0cmptdUy7mvqcUrwvrMKbiYtSzRIxlMKP3Q89UxYvfEzpas3b1p59HDTeIyO/XCy2UVZ9AlBiSDtPFktZRT1n0YZ32NNtmRhD5RkIZxs7858tgIN+1mBNM+4ywhO4bFYWkX4g2qX74MTumST1OuS7C9+YRJ5DznRuMHTIqaQoFwpO06o8XrdKJ6MxPIUBdx1p8KC/C8CeYQaMwuHTZjsXAiEa3LL9+etdLU5LgFTVEjPNjMllXRXXHdH2NllPsV73RHE1NlMzO4aN0iCFBUK+S0hoUFvVCIgF25SFbFGlXgiXKl9rdjZO5ApG3hemxxwYmTNrGJATSicQ4vVU9rkHam8UPBjq/LRnR7rpkLwfgAo7DqGzg+p+2Ec3FUoEOpiXQbi9KZt2Pd+O8vJ9a/9aKf22wLm74kfl2M9rca1I2RDDE+3wdmfm8U/NCjWySn0+BUFW5d1LUByjpCQ22+4nJhBXmgrEirRgRx87FiZVZ0t444+/6G076sCDyBFTNb1PH6/TSLZUlBoOJ6298Xy5k5HVelRAN5nlTNrfNLqPYbdsNSlr7wcER9v1fHt1h9O8qmIAtIw==
X-Forefront-Antispam-Report: 
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	et1YmxPC4WYMez2b0uQqL2YKWSQC3z7WdEN/7x/S5hXDQ9nSB+sIGHpXy1vfMRAUpCrmF/aTuwlTuW8Cc0JFx3RJ8sf1+5pfozOnFKHxB78AQDXCadHLzsMLDF+ci4N8cWoW64EBdGQumedD47YUS+tNOptUCBfQenH3igWDqWHsyNr5sCqJ9D41MDyNSaJ4s/gCXZyeNS0gz8xR9DeyxEcauWqF1Amb12LehGc+PkKwbd4dOI2U4sNf8Vgu6r3b3C6GHFZC067qycUUtkyvh+j0QDDYg+xRo80K3HU1ICNYI230AL0fP4ZOZsfcZAR6dqxzeOQE2VbKHxyE5FxxuOM7i5d5LMWlvEqYAjsMoQ4WdUhjd30oqDsggT0RZGabwvUmW2GLDDqIeKkwDCN7lRitKMSWyfdXKEi6AZrgTcxP79ypeToWrU+JSOVXiGka
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 02:10:32.3150
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f19b20c-e584-4a67-37be-08de855cb339
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AMS0EPF000001AD.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR02MB8260
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 19 Mar 2026 02:10:40 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19168

There is no need to set PV since the version is in the recipe file name.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---
 meta-oe/recipes-support/cjose/cjose_0.6.2.4.bb | 1 -
 1 file changed, 1 deletion(-)

diff --git a/meta-oe/recipes-support/cjose/cjose_0.6.2.4.bb b/meta-oe/recip=
es-support/cjose/cjose_0.6.2.4.bb
index f6a5d15a9b..eb1db40705 100644
--- a/meta-oe/recipes-support/cjose/cjose_0.6.2.4.bb
+++ b/meta-oe/recipes-support/cjose/cjose_0.6.2.4.bb
@@ -5,7 +5,6 @@ LIC_FILES_CHKSUM =3D "file://LICENSE;md5=3D7249e2f9437adfb8=
c88d870438042f0e"
=20
 SRC_URI =3D "git://github.com/OpenIDC/cjose;protocol=3Dhttps;branch=3Dvers=
ion-0.6.2.x;tag=3Dv${PV}"
=20
-PV =3D "0.6.2.4"
 SRCREV =3D "8d94c3ad3237ab6a83d2e92fa541542b1b92c023"
=20
 DEPENDS =3D "openssl libcheck jansson"

