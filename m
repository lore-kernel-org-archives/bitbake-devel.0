Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E063C61DC4
	for <webhook@archiver.kernel.org>; Thu, 27 Aug 2026 14:31:06 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com (PH0PR06CU001.outbound.protection.outlook.com [40.107.208.5])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.37732.1787841059878662804
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 27 Aug 2026 07:31:00 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@agilent.com header.s=selector1 header.b=hVqMp1b+;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.208.5, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BBpaZutQ0LHyBOF2YtEoKKgf8bUKRpO+7QtL3hOmrszfbe4VPLyA7Wf94wk/zWNKD2ljgaOV/gGlHd27mQLEZD6OG2AJiez5/gFEaqtFyCZMORV8tQimm6zVfs5UfHtWALi8dctmS/D7T4Ea0YysCsX3OHsNFeOm0RO3Yq1RREiy/8X1Q3zbsLJW0ZTcGD7g/FiGyRtaWUDlomTD49KTsYE0cLvSebuIz89X4fFK82uOMpvqHzvuQjek2ObX6e6dxVEz8sgpVFQchAdjLqqEZElmpflyLHXdmiBDYeaNo4j9NB3JkL7ek7IG539wJuYrZH6Xie4dwnhP03EVE9qmHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WL6enQx4yHW69uaoNOsgoLooKCrgKEj3A1s4K2Y/9R0=;
 b=qVSGOziLhml8qc2gcV8MOuNaM0ANoiV0gH2aTA+YK+VKr1qcrsAffSz0RbsjsxjaAiXeeXPaxexqn51Yx1rRNCP5kmBBO/0ESZfdCJlvEEPrwf50P5fI1dugW3Vs43abElUO5O1OPm+t1hK9PC55LhDPhwWKvGql+wHr4j6FvVjcLCj/vlt38eh4Vztk8Ci+Esz1otfKyGas07qM1wnUhG2Q4bd59F5hG2qNGvbE1+goIVMqAUUy6TUngHWAMHLs4HhgJ4UwfpD88AwYvss97xgV2q5E+J7poBUOgRgcXOMYw53XLG8m1LsNIGT/1sBmAe7exEsF1myq8rgGCzL+VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.36) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WL6enQx4yHW69uaoNOsgoLooKCrgKEj3A1s4K2Y/9R0=;
 b=hVqMp1b+dzYgMJCQPOaqF62BBgYC2iuI+7zelN4unueOv8kMesW7V6K06XDmhPWNdNjGn+bYljXYQBZqnguR446AwSBfS/24+IEm0p6tjCBAR8OnLu7yrJ0+bo5snstVe3qS3MWsXsNtzK2pKbOchXnIcZiKIg4pBL4MD1jC/zktsqJlc1bsoR9qoGgK1IPG5uoIAxK7NMHLuRcm8SIJ5SrIFCAsQwGzFOgjugGroje07hXxJEBR6fCXsu6NThS6DjueF7TnCVJuHzZtvEjKJg/x4U86Ibu6Nohyuv/B/GTsGNvtJEfLjkZ+Srs0bx5rVtKc9DyomA10QrePXH/HjQ==
Received: from BN9PR03CA0599.namprd03.prod.outlook.com (2603:10b6:408:10d::34)
 by SJ2PR12MB8009.namprd12.prod.outlook.com (2603:10b6:a03:4c7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 14:30:50 +0000
Received: from BN3PEPF0000B36D.namprd21.prod.outlook.com
 (2603:10b6:408:10d:cafe::81) by BN9PR03CA0599.outlook.office365.com
 (2603:10b6:408:10d::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Thu,
 27 Aug 2026 14:30:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.36)
 smtp.mailfrom=agilent.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.36; helo=wpcosapexchedg5.windmz.agilent.com; pr=C
Received: from wpcosapexchedg5.windmz.agilent.com (192.25.218.36) by
 BN3PEPF0000B36D.mail.protection.outlook.com (10.167.243.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.0 via Frontend Transport; Thu, 27 Aug 2026 14:30:50 +0000
Received: from laplante-B650.lfs.agilent.com (192.25.126.4) by
 edgeappmail.agilent.com (192.25.218.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Thu, 27 Aug 2026 08:30:15 -0600
From: <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: <docs@lists.yoctoproject.org>, Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH 4/4] doc: update manual to reflect bb.fetch2 => bb.fetch migration
Date: Thu, 27 Aug 2026 10:29:58 -0400
Message-ID: <20260827142958.547182-4-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827142958.547182-1-chris.laplante@agilent.com>
References: <20260827142958.547182-1-chris.laplante@agilent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36D:EE_|SJ2PR12MB8009:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e7405bd-b661-458d-3144-08df0447cb15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|82310400026|376014|36860700016|1800799024|10067099003|6133799003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	QUzy1518i+SyFeUv9gx3oz1wuWbpaVGZsXHQgzeCqiUlhCqYoIMRoKabj/0MbLX5Z/jGZqh5NJU6wmef1V9tGtPFMOj7qbGCpb3KiO0BcEbKtULcWCUjrnTcbheSdXJC53hhzM1mVK81ILdNMTtQtVI2poT4SgoDeRpR2UiE4TLnZFGiFgIzNY02T2eND09L3Mms0wpaS/ROgs59M9wjrWo8Gu27vQODwQIm7iKCYn/vFwfuJocQfb7w7RMw+JL7dGgVA6Zt20ESPygtexR4AperdyYk/1EgDRO5ixROIPfWPT4w4XkRbPmstIDNa4o6wQXBz9j61JCb+Kg8RvnfgupPFSqE6dj/92FjXhCAyNb5bypz2UYOYjJRCPk/q3wpch9dlyFyp8kQw7tYC99JZ05WCRYXer80ntblQjHo9ZtNel2d1TG6Yy2umkTh3Kr6GruzDOUw91x0DZ8JxicMo/YkiFeqbVPW5o27vY+Pazko0oAkB9dWNOpyqbvlnewD5Hr2Q3MSIK4n/cRCU6V5lEnYwCk5nn9TiAVN18HZMlK6S5bbdnzX2Um7EPo3frUAc+MZW0ZgcIzBtMhObZj9vJ/kCTiozi0En0WXkIqIUKjSpJQxPWQxlYCHM7JFFMY9KqS+Bu+hzql9+Rmjbk8VsGRShi2Sh2n06yOA/Y1/I/lLbL5GGMPu14gv5BEgMgW0Utfr8GJwjjPS3310v982CA==
X-Forefront-Antispam-Report: 
	CIP:192.25.218.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:wpcosapexchedg5.windmz.agilent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(376014)(36860700016)(1800799024)(10067099003)(6133799003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	df6owNE3o1TuOtyRN47bogPOv30NaWEJW9q8+lI37+W086Wvf4P8QdYjvCz8nxJ0fwYz3Of09II7e77rYN1J+0NbPMZx9ue+k9wzNwf5WvJg5KIAKKDzldNp2zWNZ8tLOw7uA9cb/+HU7NyMGtathmMBgOm4+RXvOIPCUKFfNpQhN37A+AhSErh75BcEt39xdj1K72BxIGvzO6V70KQXwznp0BcCLe80C3ELcXnyTe2DdiGSw9pmRlnCG0sCkjMWyuJCUKz2x6EXswzrAW/jbvWp36JNwHnH9+70HjAwMGdQANobzR0Mp723Q17bF6oG6j3LK5/zxSbnviLsbuGgm9b5Qk/ooGKaYAE+slmXxoq1srO0i4R1Fekv+ImllmbJw5Cls+LiZFbt5TUu7S7MMJ/XRzzn6dzhoaHyhIaYz5vcfSiVtijicd+l+muVsdQS
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 14:30:50.4877
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e7405bd-b661-458d-3144-08df0447cb15
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.36];Helo=[wpcosapexchedg5.windmz.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN3PEPF0000B36D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8009
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 27 Aug 2026 14:31:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20071

From: Chris Laplante <chris.laplante@agilent.com>

AI-Generated: GPT-5.6 Sol

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 .../bitbake-user-manual-fetching.rst                  | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/doc=
/bitbake-user-manual/bitbake-user-manual-fetching.rst
index b96018a4e..d326403fa 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
@@ -11,10 +11,11 @@ with the intricacies of downloading source code and fil=
es from remote
 systems. Fetching source code is one of the cornerstones of building
 software. As such, this module forms an important part of BitBake.
=20
-The current fetch module is called "fetch2" and refers to the fact that
-it is the second major version of the API. The original version is
-obsolete and has been removed from the codebase. Thus, in all cases,
-"fetch" refers to "fetch2" in this manual.
+The fetch module was previously called ``fetch2`` to distinguish the secon=
d
+major version of the API from the original version, which is obsolete and =
has
+been removed from the codebase. The module has since been renamed back to
+``fetch``. Existing code using ``bb.fetch2`` remains supported by a
+compatibility alias, but new code should use ``bb.fetch``.
=20
 The Download (Fetch)
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
@@ -30,7 +31,7 @@ The code to execute the first part of this process, a fet=
ch, looks
 something like the following::
=20
    src_uri =3D (d.getVar('SRC_URI') or "").split()
-   fetcher =3D bb.fetch2.Fetch(src_uri, d)
+   fetcher =3D bb.fetch.Fetch(src_uri, d)
    fetcher.download()
=20
 This code sets up an instance of the fetch class. The instance uses a
--=20
2.43.0


