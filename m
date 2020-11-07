Received: from NAM10-DM6-obe.outbound.protection.outlook.com (NAM10-DM6-obe.outbound.protection.outlook.com [40.107.93.56])
 by mx.groups.io with SMTP id smtpd.web11.6733.1604715677786578802
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 06 Nov 2020 18:21:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=01vcr3Qr;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.93.56, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EL3/+EbmqHhpULqbAzbjB2f9qwNGIiT/XQ7adyJJ/MTRu24sGWdVl7fWSu8kWpi7nldfn+Im8LNALY5O/4YcCkwUaGNgd4xTxxTlFQB9QSup4maD1Lyd8f2aDPmsroK1dDgPhaURIk4+GwXOUy4DSOUKp6NN8fcERUuzWAuyBIl13vfiBzUIC9OEwO4td/N5/BS8lgRwSmL7JT9caYK0bRiMKrdfC1ZvgD5u3Wo/RBH4b5uHAXEcBapObgPu5Bpm4UCD0LV0WkIFg2+55o1f4MzAVllCXAVA/qTcuBk072VCaiBIScST0UH3Bd35Bjdfarp95Qw7f+9XFhuJd2FxUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4UtS7yLUcamG6q9/TFWq1RMv447na1Y0V79xO/Nn8iA=;
 b=DoFOwRs5OFU7bC7Wju+PNpN9CyJCLwgkMxpffYMSkQqK8wAX6ApGvoR2qlaAQW7YH928WnTSlXoBP8SvfpRqq9OaKsnXJWBcRfVbV2y41tyc9q4wwp+H0xgPqN9EPoxScZr7r2zq7SODYjOFe4qkgdCa5/uBpXICrszC0RolE1qPITyIzATdIG32jr34ZQ1aUy6Wqw9gNDixc4Ns/Jf6VZCmLnRlIy3P7XwkjhYSHSJwY9dYPnmkWR2ae4RKts7D6ihZA0zURsQrlbo6SlpmHf+XvWZWtDsryLcJ5GGc7cYkQeT2U9AvAoGoxQLr/ULaFNo+M81Be97zpOcidtPc3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.41) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4UtS7yLUcamG6q9/TFWq1RMv447na1Y0V79xO/Nn8iA=;
 b=01vcr3Qrnv3rt0IBdEj9u/MJ4prPKFuhqwNuCKPyocyXHn5DXcMfCY6fvov4kxzOxQmbZJqojIASRPfkoVtPwm2PnT8GqOpXh2EKKfYPeZNfiNfvc3nQPibEumgkBfFT5mTp//DF/WBHD8UxzdE2j/vefEomuw8FktRvyJmtlz9WN9ymNIXBYdAit6MACpF8p1bMsE9THV3HnBMnw6p1zuLLY8jhkU5JfyeYKa05ssb4bxjF6/eqC1StQULYelJaO1E6jdEnbWPyt7JbPL1aOEE9u+QiCRtLTL9gYMPoABNfXrbvY9OOkr91oXLRB2+4RIbdEDNtjYOnS9rTK9NKrg==
Received: from DM6PR18CA0015.namprd18.prod.outlook.com (2603:10b6:5:15b::28)
 by MN2PR12MB3039.namprd12.prod.outlook.com (2603:10b6:208:c9::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Sat, 7 Nov
 2020 02:21:16 +0000
Received: from DM6NAM12FT019.eop-nam12.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::1) by DM6PR18CA0015.outlook.office365.com
 (2603:10b6:5:15b::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend
 Transport; Sat, 7 Nov 2020 02:21:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.41)
 smtp.mailfrom=agilent.com; lists.openembedded.org; dkim=none (message not
 signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
 header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.41 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.41; helo=edgeappmail.agilent.com;
Received: from edgeappmail.agilent.com (192.25.218.41) by
 DM6NAM12FT019.mail.protection.outlook.com (10.13.178.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.7 via Frontend Transport; Sat, 7 Nov 2020 02:21:15 +0000
Received: from laplante-lm-19.localdomain (10.46.38.234) by
 edgeappmail.agilent.com (192.25.218.41) with Microsoft SMTP Server id
 15.1.2044.4; Fri, 6 Nov 2020 19:21:12 -0700
From: "Chris Laplante" <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH v2 3/5] main: rename list_extension_modules => load_extension_modules to clarify its function
Date: Fri, 6 Nov 2020 21:21:04 -0500
Message-ID: <20201107022106.84056-4-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201107022106.84056-1-chris.laplante@agilent.com>
References: <20201107022106.84056-1-chris.laplante@agilent.com>
MIME-Version: 1.0
Return-Path: chris.laplante@agilent.com
Received-SPF: SoftFail (wpcosapexchedg2.windmz.agilent.com: domain of
 transitioning chris.laplante@agilent.com discourages use of 10.46.38.234 as
 permitted sender)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44cda18f-b534-409d-02de-08d882c3ce20
X-MS-TrafficTypeDiagnostic: MN2PR12MB3039:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<MN2PR12MB30396D323E0738AE73219CB78BEC0@MN2PR12MB3039.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	hzWO3eHSVpNJwrAVLKn2cYg54WM2q5EEn5dDv2Y3sgS5ZO68HX+UkePjmkZXIP0zE2Qli/qhO4Yo8q5lJjwzUbjN0rEisyHAOWsj+nnZfo8hlYZS3c/34x6xMFsx0fkXf9uaEDYoD5/rF+V0ILiX/bWHBrfdGjWcoXcUyMVnAmcK8D5Rm2x+KeonJ6ylE3oDTilmSEofro6U/g62Gk5R5AqSbUsZhIBGJ5I+ZtVNhLyUrZd1bNR0MB0xnK3LzTT7Bl2LYpKKOhVeaTa9tFADgk5M5Ska0wWmP9hiLhw8fqK2Y604In35QERJSO+ctYYbj3iznHCUQ0GEwSbRO5eAmAEUG/lojIRVV9kLxJaApJo/UxdUoQVxP+R2mnogfIpkVxP56QC5WJTy6TsHs6hl+4txU2oYjHDc0HI4HoxfcPk=
X-Forefront-Antispam-Report: 
	CIP:192.25.218.41;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:cos.smtp.agilent.com;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(346002)(39860400002)(29502001)(46966005)(6666004)(44832011)(82310400003)(356005)(5660300002)(1076003)(478600001)(82740400003)(26005)(36906005)(316002)(86362001)(426003)(4326008)(186003)(8936002)(7636003)(36756003)(6916009)(2906002)(70206006)(47076004)(336012)(8676002)(2616005)(107886003)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2020 02:21:15.9993
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44cda18f-b534-409d-02de-08d882c3ce20
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.41];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DM6NAM12FT019.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3039
Content-Type: text/plain

Also clearly document in docstring that it is the modules themselves
that are returned.

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/main.py | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/lib/bb/main.py b/lib/bb/main.py
index c53da851..2fb81a23 100755
--- a/lib/bb/main.py
+++ b/lib/bb/main.py
@@ -40,9 +40,9 @@ class BBMainFatal(bb.BBHandledException):
     pass
 
 
-def list_extension_modules(pkg, checkattr):
+def load_extension_modules(pkg, checkattr):
     """
-    Lists extension modules in a specific Python package
+    Loads extension modules in a specific Python namespace package.
     (e.g. UIs, servers). NOTE: Calling this function will import all of the
     submodules of the specified module in order to check for the specified
     attribute; this can have unusual side-effects. As a result, this should
@@ -51,6 +51,7 @@ def list_extension_modules(pkg, checkattr):
         pkg: previously imported Python package to list
         checkattr: attribute to look for in module to determine if it's valid
             as the type of extension you are looking for
+    Returns: list of modules (imported via importlib)
     """
     import pkgutil
     import importlib
@@ -101,7 +102,7 @@ class LazyUiChoices:
 
     def _lazy_load_modules(self):
         if not self._modules:
-            self._modules = {module.__name__.split(".")[-1]: module for module in list_extension_modules(bb.ui, "main")}
+            self._modules = {module.__name__.split(".")[-1]: module for module in load_extension_modules(bb.ui, "main")}
 
     def __iter__(self):
         self._lazy_load_modules()
-- 
2.17.1

