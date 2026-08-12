Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4255C5AD5A
	for <webhook@archiver.kernel.org>; Wed, 12 Aug 2026 19:45:00 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com (BL0PR03CU003.outbound.protection.outlook.com [52.101.53.56])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3653.1786563890833930247
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 12 Aug 2026 12:44:51 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@agilent.com header.s=selector1 header.b=QqLWV4Qs;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 52.101.53.56, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cJsSN69nC2umqh+b6ipl2ZYrcNcNCGv9Z3MHmoiE2GvJNXWxxq9fYrHHDAca4H3Q7qWrmqAaJUiEKn+bB3xygfUzR8dyivLpAXwdt950kD/DlpTIRxzeBERlD5+/rm7xc9FQWwTB09zOjR4LEGzMgr4vKjihtrN/2N5+msVqPSXwS3JSKnJ0rP8mK4syfIH+zPY+IsmKDkV9klWsuU2dOHczUEdBoYe+sUHSIzqQEKPSUdiufRK44R6vteqWHHrL9cp+TWTaM8XSJ0oV42lTzzraYEoais6JFgk+400TevgpRjYaPtyNyaZY2eJZxjfcWA2yF9Mf0768UrB4/711ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P6d9XDW1cAS1fGaCS8oD+fnR+c8WvI5mkSE8niaX9Cs=;
 b=eP98nCPaEOrY1atBz9902tWGQvypPHdIHyqr+qorSsihnVe67+uvuOTygnxFpaIeEXXqLA9qVaoWm9DuL/JK+P/JGgwjWg/BkApf/Qd3H0dXtwFLaHWx1L8gIgSHNLRuuaXG1RCSr2WO//ASVkXBFBAooniJbCBNhj8G6Td3t1rLbn3l5EePcuU06RQcj670MDF/qHe3RncrlW8OkkQJ37AWEW6mtVP6tHVy8JvcSXSDophFFQblk5neEsyOSvHIbjJyR97jd3MM8H0ptT35yIrG7aFU2qc51hM8TLxWrzyOgjbzz2eRrJUCcGPnxy7vGIOAiqCLm68eE6yUTK86Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.36) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P6d9XDW1cAS1fGaCS8oD+fnR+c8WvI5mkSE8niaX9Cs=;
 b=QqLWV4Qs1cTSO6uii1A1XBvTg59Hff+Sev8NCO+leBjmIJtR2LxzPWGuMJK8OnRvnKgIfm/qByzES6iYtrsZ5AlWmRa3Zas8kvjU+s43b6n2mQa2HF6SSwfiwykEci39Tn1anw3XLQmI1jlhAC662x4ixCSHVWkCZQr3//8BwuH8qJjV2ZFvPWUqPR/pheDPe7LjQRW64CpweI+MApoSa2PubHHYEMQjDvsImf64d7OUf39t2zaH2Q1j+UcY+oPEZ9LyjXHoyTOxouWUo66xsyzIRkXv6dErhl8zWDItPewC82CkNAhc7ld8QAHXqqSpsqDPf/PAK9zA5GATS8UuNQ==
Received: from DS7P220CA0065.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:224::29) by
 CY8PR12MB8214.namprd12.prod.outlook.com (2603:10b6:930:76::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.13; Wed, 12 Aug 2026 19:44:44 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:8:224:cafe::29) by DS7P220CA0065.outlook.office365.com
 (2603:10b6:8:224::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.13 via Frontend Transport; Wed,
 12 Aug 2026 19:44:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.36)
 smtp.mailfrom=agilent.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.36; helo=wpcosapexchedg5.windmz.agilent.com; pr=C
Received: from wpcosapexchedg5.windmz.agilent.com (192.25.218.36) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Wed, 12 Aug 2026 19:44:44 +0000
Received: from laplante-B650.lfs.agilent.com (192.25.126.4) by
 edgeappmail.agilent.com (192.25.218.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Wed, 12 Aug 2026 13:44:35 -0600
From: <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH 2/2] pyproject.toml: add scripts
Date: Wed, 12 Aug 2026 15:44:33 -0400
Message-ID: <20260812194433.40594-2-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812194433.40594-1-chris.laplante@agilent.com>
References: <20260812194433.40594-1-chris.laplante@agilent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|CY8PR12MB8214:EE_
X-MS-Office365-Filtering-Correlation-Id: ac9fc0cb-107c-492b-189f-08def8aa28c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|36860700016|23010399003|82310400026|1800799024|56012099006|11063799006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	Y4k4TojRwkfxNLwESxrANbSX9d/S5UtG+0w+Oixkf3SLf64cG1oOWHx4RSWyuuV/PUL6mpVpn4Ox/eS0n8nJhweXzABhyQWAhS6zw5pUKzxWVpu0KnadoOy0mYrmRxbp13DL7Tq5Iwt3GZc5GfEPnJNZicrNSzpezdEBVRS0mbdKn+mU9c2xVj6TAHbO2kAQIv0+P1olLGBay8P47UoHNVOFX5W3m3ALzk0Z09ZrjbRJEnkQYVbO3U0GxPXzwB+OiIUoA7H/IFOVhn93LYHWTcceaidKfP4OurMoC6KzS5rj35KJRoEUikV2GUQaZH0rcl2TBkeuHSgM7pCf9iCSTphnt3/m1Lj1o70OVoD8CfQ9gOS8BY23j56FXYfclUVoIwMxDRPfyzKC/fM3nSOi7YKSus2eVXSilH/R58oiIEt9QgfSOYKWplCZ9tWXhTJorIHOLt1juyWTVLzrwezixZHHJ37hmT2x/uTUG7AEeyp8gSUHgGHPop/8JYGypVqZekXZvvIES6Mgh1J4SUBAmf+XcE4MXO6OeRDW7oseMZUWtXWP697RdyQzruJxhTxuHY7P16uLOZtrW/D9YzGyflE1xxXvJDzW6ORXJ9xATrg8JHogwUPYLBPBz6I2V8a1y5sJ7rf5u2XLDvR4DAvYe81jjqkz24X8doy4q7+LIs6UUcrMXltuHdpAE5WzrBt2f1+1ErjzPPei1En0zVoz+Q==
X-Forefront-Antispam-Report: 
	CIP:192.25.218.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:wpcosapexchedg5.windmz.agilent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(23010399003)(82310400026)(1800799024)(56012099006)(11063799006)(10067099003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	D6BjdYsCdeJ5cdtA4PWmNbR8CTbQ6Yu0DaBqBuCPTjFag/JSqFK/J0LtXBG27lkRc8KRGcVZ9AOXn5DRt7Q3nL6u3qI0Ys6SzQI4VMQbAAwQKBXN0L8j6r6B8Ve+GbZkt3JisaVMpgYgdfxuX945ZNfp1NZiYELf00C7vYvS5XNGJhNqqB/oj3cukF6ezDCm+dHxr+vEAWG38XrHvofUpPVZdHblYg4oCwV9AFQTYrVtQZ88cCZ5kMmWFrkfMbb5vj7wD7ePglnLYxB2ZNqpvm001YyEBtbw5PPmch+ed4gPMulMrtVkDXEwxC0CUiMgu8DcfjfpBqHvrWs3ac4aDk3aRxn3p+70VIlMLs8dQhjZKpaQNk1h+9UpHFUFWB/T+OwMtoroh+LNhaEcFiY9Hb1P4MKsm6PbC9RP50qZ+jGbC69WLJn2IochUWcV9UiI
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 19:44:44.4829
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac9fc0cb-107c-492b-189f-08def8aa28c3
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.36];Helo=[wpcosapexchedg5.windmz.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8214
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 12 Aug 2026 19:45:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19920

From: Chris Laplante <chris.laplante@agilent.com>

This change lets you do, e.g. uv run bitbake

which is convienent for development.

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 pyproject.toml | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/pyproject.toml b/pyproject.toml
index 886753f14..d3555bc42 100644
--- a/pyproject.toml
+++ b/pyproject.toml
@@ -9,6 +9,19 @@ requires-python =3D ">=3D 3.9"
=20
 [tool.setuptools]
 package-dir =3D {"" =3D "lib"}
+script-files =3D [
+    "bin/bitbake",
+    "bin/bitbake-config-build",
+    "bin/bitbake-diffsigs",
+    "bin/bitbake-dumpsig",
+    "bin/bitbake-getvar",
+    "bin/bitbake-hashclient",
+    "bin/bitbake-hashserv",
+    "bin/bitbake-layers",
+    "bin/bitbake-prserv",
+    "bin/bitbake-selftest",
+    "bin/bitbake-setup"
+]
=20
 [tool.setuptools.packages.find]
 where =3D ["lib"]
--=20
2.43.0


