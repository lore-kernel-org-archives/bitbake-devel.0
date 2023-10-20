Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11050C004C0
	for <webhook@archiver.kernel.org>; Fri, 20 Oct 2023 18:45:31 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (NAM02-DM3-obe.outbound.protection.outlook.com [40.107.95.67])
 by mx.groups.io with SMTP id smtpd.web10.62514.1697827528620692728
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 20 Oct 2023 11:45:28 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@agilent.com header.s=selector1 header.b=MphH93yP;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.95.67, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ucq+Oeri4dxktEU6mGAbkwRpef5S1ua8+zBfDcv+7+SNKeVW5jk4uvC9EW03Q9Nie+uwyr9NbrPx5VhZr/mX8e7+yZXCmEp9ha4A2EFqEpAEvC5+wn+2MJ700VhpDpQ9jOvWpWsJANORhpkaUQJR1btpnXcHERYBP3OX8ds/7KGNNo7ns2NI/ZnCVgQ/sQwO5ZLow+IlzFj8pkNhRSulEmUTK7cwykjBeMy3Y+toXwwYZrHAO3pO/7rdgbNzfg0mDw/oaYlU8lIcSMTCDqxu3SXum1fCGC32Qa44bG8rhRxBtdmKwomMITa3MwpRyPGECbFJRzzGh/qfZoW5GwhDXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dOmiuiBjXQqMBJUVW3NGckn/8Ik26rALO2ZicOssSeQ=;
 b=C+SE0sGJxBDHIuGari4kJyy8nQDe93zdmhDQmGMrMLN90HsvoV+tpVeqv/OX9Pv6VzIoTzVomvyGGdyeQJvfncvktr8qv59vgEHSA1LUadiO2ASAsnrXbCWFWqkBavRHMAtFw2KSNDSJ3aWFiDrI7C300UTlGnafkV8rxntKGgjRt3B8Iq+FcZEIXLhYRAkO97F2JIJ1u1HKoXPoz6+Gif8SZtK05UHotBVuLKiPjzS/OGKzWFoAHSzNMhaT+77Ges4NRcAEkVIiE2Gl1YOnzK/Afvxp6FipM/8a/fRWXs84RUdzvTRUvpuwszo4zwoJq+lHcQhlSsBkaxJva4UZ1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.41) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dOmiuiBjXQqMBJUVW3NGckn/8Ik26rALO2ZicOssSeQ=;
 b=MphH93yPwyjEid3+AI4eHJEnoLnYH5yWGmTSlojoF+axWVauWOfHE7l/seiVvp6qRFZZw7V9zu2pHfXFuXk0NhP6JlmUJH61k500d6X7m/Tcvtlhm7qbLKunYuv/9Bb5M2/lZh8N+ihWUPilVF6s/Yl3nmHPxUp8r/VM7HsAkGb5IDgkU+aXOsvWiCn8qjaJ869WhmEqH2PyU6PzWrKuBu8LvwHBYTU+Ln1TNPjcqwP0sePMxYtYao//golkaoMwnQ0nWL1oMHgIHrvi8vnozkju4qHsWsR3azfOxYk8J5S5SkBXAUgXoMM6Z7mk1xWW3OYfaxrBh9UTQSvqC7GicQ==
Received: from BN9PR03CA0990.namprd03.prod.outlook.com (2603:10b6:408:109::35)
 by DM4PR12MB6447.namprd12.prod.outlook.com (2603:10b6:8:bf::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Fri, 20 Oct
 2023 18:45:24 +0000
Received: from BN8NAM12FT081.eop-nam12.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::80) by BN9PR03CA0990.outlook.office365.com
 (2603:10b6:408:109::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26 via Frontend
 Transport; Fri, 20 Oct 2023 18:45:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.41)
 smtp.mailfrom=agilent.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.41 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.41; helo=edgeappmail.agilent.com; pr=C
Received: from edgeappmail.agilent.com (192.25.218.41) by
 BN8NAM12FT081.mail.protection.outlook.com (10.13.183.170) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.11 via Frontend Transport; Fri, 20 Oct 2023 18:45:23 +0000
Received: from chris-virtual-machine.localdomain (192.25.126.4) by
 edgeappmail.agilent.com (192.25.218.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 20 Oct 2023 12:45:14 -0600
From: <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH 3/3] codegen: cleanup deprecated AST usages
Date: Fri, 20 Oct 2023 14:44:59 -0400
Message-ID: <20231020184459.1420806-3-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020184459.1420806-1-chris.laplante@agilent.com>
References: <20231020184459.1420806-1-chris.laplante@agilent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM12FT081:EE_|DM4PR12MB6447:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c51d1e7-bbca-4195-3a74-08dbd19cb7f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	50T76mYeEVp33OMF5FF4Jof3zxz4l7dUaHSmeGxMTgdHIgb34qY28T1T28nUoZFpRtebmqOZte9o0rAuhbxnm1y/jwbWwqmhIUEoEeQ5Ro/rjeJ1K32HH+oGASZ9doEDveONn9vFpr04lHSWgDJ6v+TWde0tKEIRYLn/abYJnjuX+L6CBsi0VxKgEL/T+pY98HrJQGuuNxo7sd6BYXnwHPDAHagfp7Q0gm+7lO6GlW6wDFdGSRB+O5Ef5ZZUyA7br+XsPcD3p/lZucO4z9VKed4paXdYKyIB6PSV8gzxE6CpO9uolRumP1z6O55+9AYT0Vklyyf9NRXacsw+j0uAbsgwlR6aYwCMetZqe0RrvXs+r6f1HBgyN2FMmDiOORAiO6l5YhGplYo8Dp2+eEcibRWbfg9gfs9oWii6vhJPkZ+mcefXWxg1UYKydtYYjCtkZWpEQ3ybnD0DfBm2HV3aXqC++62UO80G8x0YQG2maB+Qa1gmChJ64M6g3OmUOa3ZQPhT8Zsaau/aTptMw2Otiz1H6j1bMao6rtgw8ucxBweC8hgTdsKxr+CXU2OYhBCeDhGtAZrcRdcBkhCIPnaP6jiKr3ch+4Cg6oCPfKY/Zb4SQlk/PpBbN4RErgK/FHTkQkSCumf7V6O+raEJhL5QqjyzCY2kkMtXJNbEpDTXn/VBz/Zqsj8TTFSeWDc37C3dq/RjurDOwOKT1pNROsyekqt8aR5sDPuQqX5mI6l4ArVwEMUlnXa+t6nlk+APpTvk
X-Forefront-Antispam-Report: 
	CIP:192.25.218.41;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:exch.smtp.agilent.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(346002)(396003)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(82310400011)(46966006)(36840700001)(40470700004)(40460700003)(47076005)(40480700001)(36860700001)(2616005)(6666004)(6916009)(41300700001)(2906002)(2876002)(4744005)(956004)(1076003)(7636003)(107886003)(426003)(336012)(26005)(36756003)(316002)(4326008)(356005)(8936002)(70206006)(5660300002)(86362001)(8676002)(82740400003)(478600001)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 18:45:23.2990
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c51d1e7-bbca-4195-3a74-08dbd19cb7f4
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.41];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN8NAM12FT081.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6447
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 20 Oct 2023 18:45:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15271

From: Chris Laplante <chris.laplante@agilent.com>

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/codegen.py | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/lib/codegen.py b/lib/codegen.py
index 6955a7ada5..018b283177 100644
--- a/lib/codegen.py
+++ b/lib/codegen.py
@@ -392,19 +392,7 @@ class SourceGenerator(NodeVisitor):
     def visit_Name(self, node):
         self.write(node.id)
=20
-    def visit_Str(self, node):
-        self.write(repr(node.s))
-
-    def visit_Bytes(self, node):
-        self.write(repr(node.s))
-
-    def visit_Num(self, node):
-        self.write(repr(node.n))
-
     def visit_Constant(self, node):
-        # Python 3.8 deprecated visit_Num(), visit_Str(), visit_Bytes(),
-        # visit_NameConstant() and visit_Ellipsis(). They can be removed o=
nce we
-        # require 3.8+.
         self.write(repr(node.value))
=20
     def visit_Tuple(self, node):
--=20
2.34.1


