Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F8DC5CFDB
	for <webhook@archiver.kernel.org>; Wed, 12 Aug 2026 19:44:50 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com (BL2PR02CU003.outbound.protection.outlook.com [52.101.52.62])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3652.1786563890088564474
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 12 Aug 2026 12:44:50 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@agilent.com header.s=selector1 header.b=V7wMqtq0;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 52.101.52.62, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X41/cyajwxBqvjl1+V2RvaohR6zn7gDu8jtVjqf3z9WKr9dhKDIDYaA0Ln+ElPTGxwUx1T+NMemAKUlROVoFe/7pYGqUdWzQb3UrD6/8ZRPMH7ZQurq2vlFa7cLmoAnwe8szuPiLzDH0HIWUH6qVOfm/vBaj7Oi4GKs70Dlqp6fjncXb+Bu7PxegZ2xNOVpwD1lqsb9vRZX73wREKS6WPsFac+j/nstXkolGIximJ4m53Xl402s3ssT4xItov3BndMukqUeARYSMsO//1hEZkoUj150/iLFZNJhJvQHtEzOeCn7AiWclWWiglL4+vYEWr/+hr6tToIdwqscb5qE1sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fyQhXN/mAlG1UdvY5hn8eTDSmVY+GjkmBMHhagFnhqE=;
 b=ysUi8ce52qvybVLXkRkfIGQ7orc2477rLcc9uAxs1jRE0eiNgQJrS8aZwPu8UEZ7K3ME/pmB506Vfs9TtSc+2XlU4cF1Be3gYUJUTJVD1Z6jEmH8p6C+sSOCZlYz8FujRO60gmufXtYdSeGL7LgnZ3P5IIx9Ywe3Gs4OHZTmRzXr4Inhy089y8DO6mSrc67APYiTgQIUOoq/oIgwC5pQxhfe2for9PvXgwDFt/jHO1n5ztXTcFnQy3XL4qntNVPmuxI2FF8Ej4wxbe/n/TZokc5BNxAVXH78cPqb/fknED6mgrZFtfid6e53ev/Hw0svjLyRrLLbNxarjj4N2VZ23A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.36) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fyQhXN/mAlG1UdvY5hn8eTDSmVY+GjkmBMHhagFnhqE=;
 b=V7wMqtq0bvtELKe2V1PpFpvGt+f02Y0XV8Tbgjz+6xlfHDpXi9LV1kDqXKtjOjmRgNzFAvBoAc7qOYfmTj2lzolwiPlL2bwKPLyFP3B8Oi2+CxkUYUQfV2JLVsh90DWb/zJzVjbMNgpJeIw+gFxtdP7+gz0c1TOew86QkaBj4v75VA0hL1QpU+HTyKIguy/1t6V5iVrlf35l+61gef2JCPHxzsV9dHNJVrV0+xD8gJUolxJLQKJx3eS0TBc8wp4ke0PtZHoUx3VakBD+MOOx948C/l3oBa5GCSkAzhUEYwOSutyCJo94py7Y1abzncZTLDdWUpCczUXSaAKKfC+zVg==
Received: from DS7P220CA0043.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:224::8) by
 CY8PR12MB7564.namprd12.prod.outlook.com (2603:10b6:930:97::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.12; Wed, 12 Aug 2026 19:44:44 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:8:224:cafe::38) by DS7P220CA0043.outlook.office365.com
 (2603:10b6:8:224::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.13 via Frontend Transport; Wed,
 12 Aug 2026 19:44:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.36)
 smtp.mailfrom=agilent.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.36; helo=wpcosapexchedg5.windmz.agilent.com; pr=C
Received: from wpcosapexchedg5.windmz.agilent.com (192.25.218.36) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Wed, 12 Aug 2026 19:44:42 +0000
Received: from laplante-B650.lfs.agilent.com (192.25.126.4) by
 edgeappmail.agilent.com (192.25.218.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Wed, 12 Aug 2026 13:44:34 -0600
From: <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH 1/2] pyproject.toml: add setuptools to requires; fix project structure
Date: Wed, 12 Aug 2026 15:44:32 -0400
Message-ID: <20260812194433.40594-1-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|CY8PR12MB7564:EE_
X-MS-Office365-Filtering-Correlation-Id: ecb70536-7e6a-411c-e6e3-08def8aa2767
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|36860700016|82310400026|1800799024|23010399003|6133799003|10067099003|56012099006|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: 
	ZWbsWyqTramubZUejurhCsm1oCklaO7tWVzpPBbeoPo1OQ8R346SGTOZVlF6XKCg83cf2MVhkeA1GgvcSb4ebljvyZ6WYqF8q7scrR/HV4ztg8EaX15yI5dec4PWuvjbo9LjpNSIq7hfi0wibQTXihLqUeqgCRSXEZWfmo3dLSY6YRXbLrPIDkWP891gnH9q1IxIg3ku1kLgNINLJ3GMrUOkL6/taIo1HlVJ4GHPOhY38TCMjuEXkY1uSAmwExstx6pEqENKXKyYhkGXQHzppWWVWs/Az2BMQO0qDBjGL9gujmlGTR+zZmMRXRy0oMdI26+O7GEeQLRd3ROjknJ+kCLUD6mjLuGbXDeIBOfVeFcjKgY76ZcWn6DqigUJv+fawH097GPyZuWFD+MgtSXG3uL/HFXtoOrhh8UjZuao1z7triSeC//ElbQzyp10YiWi6DMVDUcz0aKWgouLRFOI/Lep4oHegSOZlvna6u/XA8HmE5mgCQM/c30Twm59U2c3XsBCtM3PSh+cm0t1yAApb8pP+nmjNlOmpiECi0rJDAzJ8ir584/UMa4gPJhlWBYwTNe7nuhPXyyCOx3jCmaAmDJTQQEOlxXNh5r4efGQvztXztSUNvslhUzEp1bwzvsVckgA70ogmdJ77a9Kn3CIlHZusObhVhrLPWASVWJvitVaYeXkWuGKqMJMb653dpJiN5kRrStjwwoS0jaVpn4fKg==
X-Forefront-Antispam-Report: 
	CIP:192.25.218.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:wpcosapexchedg5.windmz.agilent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(23010399003)(6133799003)(10067099003)(56012099006)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	cjsNf0MmmVwtMURF1HtcL1nT4BBwi6V3Yh4JBJ4u1pv/gCH9ho5ew27TUL49ylZ2wkLd+0/CsJmZvRn/0dlzWL+bdaTAsiMumGtacrnfSqyi5rJ+gUxhFjYHyzIGFPAPvFoeo7U9N/Ox4YJwLEqiwOYg+pObteXgthSRO9UAs4xzL1jCHbztGOO1cNVa3VxTU9fKBg9+phbg4SpP5Tnfmwy0gAtrFTwQQHl0UMPFAjLcIUxYDol/fpGhYn1oKbZzM2N/GzZHWyTjKpC6ofgR3pFU/n4R9rwaH4iplaVnmt3V/Fo1DnZjELt8Q+fF9ls/dtk5dIoMLZ9+jiePw6dMCtMmboaEl1ItjNRJBTerrenM6kjNfZm9gkkLNbe+IHF8ouiC5txWuc/Bieofv8w7KgIZpPVy9xXIniCJD+vP5IVoly2x1O/Ta/vi2tzmwuqq
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 19:44:42.2070
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecb70536-7e6a-411c-e6e3-08def8aa2767
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.36];Helo=[wpcosapexchedg5.windmz.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7564
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 12 Aug 2026 19:44:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19919

From: Chris Laplante <chris.laplante@agilent.com>

setuptools is listed as the build backend but wasn't in 'requires'.

We also need to tell setuptools to look for our modules in 'lib' since othe=
rwise
it chokes on our non-standard layout with:

[stderr]
      error: Multiple top-level packages discovered in a flat-layout: ['lib=
', 'conf', 'vendor', 'contrib', 'classes'].

With these changes, 'uv sync' works and IDEs such as PyCharm can
properly analyze the project.

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 pyproject.toml | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/pyproject.toml b/pyproject.toml
index 93508d92e..886753f14 100644
--- a/pyproject.toml
+++ b/pyproject.toml
@@ -1,10 +1,17 @@
 [build-system]
-requires =3D []
+requires =3D ["setuptools>=3D64"]
 build-backend =3D "setuptools.build_meta"
=20
 [project]
 name =3D "bitbake"
 version =3D "2.19.0"
+requires-python =3D ">=3D 3.9"
+
+[tool.setuptools]
+package-dir =3D {"" =3D "lib"}
+
+[tool.setuptools.packages.find]
+where =3D ["lib"]
=20
 [tool.vendoring]
 destination =3D "lib/bb/_vendor"
--=20
2.43.0


