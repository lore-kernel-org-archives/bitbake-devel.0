Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E84EC0032E
	for <webhook@archiver.kernel.org>; Fri, 20 Oct 2023 18:45:31 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (NAM12-DM6-obe.outbound.protection.outlook.com [40.107.243.78])
 by mx.groups.io with SMTP id smtpd.web11.62628.1697827525124676942
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 20 Oct 2023 11:45:25 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@agilent.com header.s=selector1 header.b=FKzY1Leo;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.243.78, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SHChX0tlwCx4C3e+AVVs191C5YuU5fu8Qzijw2x/3TxFvL8JHZUZjNLgkYoACOKXPph+6t9T1aQI6v/EByEx3qEbCVHBe4LzZOALlKfF8EGHl/3EtVm2Obe8GXzeQqyhqysMz0a+0FY07lzHX3fS7WflZxigdFyqSENN261IZMFzmCMQYn/vKuGNN9Ayq3YRZYmGe+AGY/59g2OnZDd2pmunShlDdywuE04wreSsg5qy6M1lDVMvyiLaK/DMgOM8/GLddmKx+cF1npqP1I0OhD5FURL7xidXRB/rwB4itIeSzsNgehaGSUT5oL3EfY53uXdE+kJk/uOZKVQDx3W89g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JFzurAI8q+Ha/G8Knb1luCv/X62gMPO6DYgu0EAVS3s=;
 b=H53ogEX/RGjcvLYM0+6ojeCQomgWnN2h0iiEckkpUU+9xld7gL27X55fGWa7nY8DwIdZYkrnwtoTluzU7Ve4qz9ScaVMBgJRKUaa2uTmC9jB3jB3PA4AaF1r4ZNHlpp43KYgKYOhvCrM9qxUx100SXm03HISjlrODKmU9oqAWXXcO4hiqeauSpXd6FlyTH0gSoQd9pOfz1pMROa8jxymH2Napl48zS7R7Z1HkGfsW0RTbtWr4XyzLr5X0qTHaZu4r8SSS7xQlh72oTgOMkD7c3fKTpY5B+ATTuRkWQucBa4g6LyqqWtZ1V34M2EpflldVfFz7BEBh3SibDPgzi9ZWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.41) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JFzurAI8q+Ha/G8Knb1luCv/X62gMPO6DYgu0EAVS3s=;
 b=FKzY1Leomu/RPBP5WPljCc4uTPat01Aen24aGwyNknGeSDstGGidoQ3ufJe2w36vGM6C/G0jPgVR9jdjpECF0YeK0sBW+/+LB9Y+9xOpXszG+m3q9+dldIRI2w7sM2+ylOXTQZukMxi/0QBHEOtuOq1w/RXvFpU5Xu4DCP9zObpkln9l0Puj0ZYkBo/t8tCfYDMw6pHGFkv3yc8noh7uw1eQq/zU8ERG5DqI5IIQHG5zcnD+JgVr+fm+hXkgzFZwSem1b7NANoyymN1BzYER19g5Uls+VX6MEM9DXvo2XjOnezk23LrEzqOPykvcPeFtdpVD5oC1ZYS94LVRcXqNbQ==
Received: from BN8PR04CA0033.namprd04.prod.outlook.com (2603:10b6:408:70::46)
 by CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Fri, 20 Oct
 2023 18:45:22 +0000
Received: from BN8NAM12FT108.eop-nam12.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::18) by BN8PR04CA0033.outlook.office365.com
 (2603:10b6:408:70::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26 via Frontend
 Transport; Fri, 20 Oct 2023 18:45:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.41)
 smtp.mailfrom=agilent.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.41 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.41; helo=edgeappmail.agilent.com; pr=C
Received: from edgeappmail.agilent.com (192.25.218.41) by
 BN8NAM12FT108.mail.protection.outlook.com (10.13.182.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.8 via Frontend Transport; Fri, 20 Oct 2023 18:45:22 +0000
Received: from chris-virtual-machine.localdomain (192.25.126.4) by
 edgeappmail.agilent.com (192.25.218.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 20 Oct 2023 12:45:13 -0600
From: <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH 1/3] codeparser: add missing 'import os'
Date: Fri, 20 Oct 2023 14:44:57 -0400
Message-ID: <20231020184459.1420806-1-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM12FT108:EE_|CYYPR12MB8750:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e2c5e54-abfb-41fd-f849-08dbd19cb74d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	EzItB2K5L06qbTdQZv96tEP1dna2ZehZLtp9+NiwH8TsdrPVHQNr2jlHvt1q+Uz8kRJ9P0mwy32SqXPz8VSTQquAt2RepkSxM7e5HVL39MH/hMYjvWHvtj2AKenRjauPhWnwCcU4BoSVas5X1OmYkKWQOsCynuld0jdM7N7BdjaSH/fYN7Dt8veY3ovDRtit1EYKsxtVOBoXPeIcve0oVWhyb1jdn75tOi169+/CtBkEQla7xjiKmijO7/5gldmOiSMeIzIyBFFTfSIwgQrk7BPaPNwHT96CwLORNXVIhLJ+R06YCBZ8yhsUbZ6TBGQAVYgv2yRdLOqgR3DDMeSnAL9WQwgK89TOkMB8iTlKVeRDPLj5g4CYvGs4IG6iiZUVZELs51efNGYHBo9QLn5VZMV+PnR0Eh1AmTMBIZh3t+1/7AtHwoSrrHzIViFHaWsSZ5QzDol+w3cPqOrNiCuWzjSkXQp683rG2u4fDImzclx167SlSOuM+iFbrwWscGZu2dprOt6cJ3GldUv4w02yxHKHQXO8PszImUsgb4E9jYnXpEMWeNTjdnUggHz4A2pGxommq+ceBNmtv2UvZ/h7y+BUXw6SZz7xzPlY5FKsZ000+5eEvhjqCGIBfzqT5LuOFVkchP7RPfbzgSw7fWNG7Va+h4qIuxBahm08vT6MrWf0Tr982nK5hOmSgLpg1u3fBMsbpj/HO8Fn0qr/sE/JgPQPioxq/FCEzQCB31x0pC/MR2B1t+cGTonAVPeP6MpU
X-Forefront-Antispam-Report: 
	CIP:192.25.218.41;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:exch.smtp.agilent.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(39860400002)(376002)(136003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(82310400011)(46966006)(36840700001)(40470700004)(4744005)(2906002)(2876002)(8676002)(8936002)(4326008)(41300700001)(5660300002)(6666004)(6916009)(316002)(70206006)(40460700003)(478600001)(36860700001)(26005)(107886003)(40480700001)(36756003)(47076005)(82740400003)(86362001)(1076003)(7636003)(426003)(956004)(356005)(336012)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 18:45:22.1157
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e2c5e54-abfb-41fd-f849-08dbd19cb74d
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.41];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN8NAM12FT108.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8750
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 20 Oct 2023 18:45:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15269

From: Chris Laplante <chris.laplante@agilent.com>

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/codeparser.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bb/codeparser.py b/lib/bb/codeparser.py
index cb068844bb..cd39409434 100644
--- a/lib/bb/codeparser.py
+++ b/lib/bb/codeparser.py
@@ -62,6 +62,7 @@ def check_indent(codestr):
 modulecode_deps =3D {}
=20
 def add_module_functions(fn, functions, namespace):
+    import os
     fstat =3D os.stat(fn)
     fixedhash =3D fn + ":" + str(fstat.st_size) +  ":" + str(fstat.st_mtim=
e)
     for f in functions:
--=20
2.34.1


