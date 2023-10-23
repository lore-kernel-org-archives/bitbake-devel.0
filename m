Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA5AC004C0
	for <webhook@archiver.kernel.org>; Mon, 23 Oct 2023 16:46:43 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (NAM11-BN8-obe.outbound.protection.outlook.com [40.107.236.40])
 by mx.groups.io with SMTP id smtpd.web11.126226.1698079596810496921
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 23 Oct 2023 09:46:37 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@agilent.com header.s=selector1 header.b=qlV516Aq;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.236.40, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gMewdd7Dpgrgr/3FCKooUATJaXjZC6dxerZjAwq78Fn0jgJTymIoCwhL4ZD2Zl4Yt3Blcl4NUM67qdqqs1rDLHoWTGUa+ntezhQpLVgZ5uPl0cR0Ll5kaXCwpIKgct1FlhUpeSy7oqevZ2L/ms2yzzHZdb0SLVSyZLO60MjWvOqoDBFxmnxAsWVjqQWrZgn1qkCEBRq9WHffVoOsKDzv3MjpM1dTXoxTh1po9culUHj/iq2si3ktn74Ekc4avY/x56RBnAQgZonATXTkFzVwH/HSK4JnhNgnKS5narcBlZjGrOXgnLpEc+Y0Sm7LBtJ4aAsuX1s8PjgqHDwA+VOumA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YZeiB2NZXWvA9Gg/E0O0NVN7vEgBi3GXmcr+E4WdRow=;
 b=VWyFpx0KeCbCpmXmA6qh3ZNxniRDmdU7UrNDGNBGlesPXJY6pKyQ65Yy/ITY3elzHHPKtkrU/Be8wSpUFXIhIdb3PGFFksVyDWjpleKcYkkdXnbX8ZBZjWq7oii0UPR0onZbQzIO0yh8brs+CEokKIrwtdAuePPu19KW0mecJXEjKoQTLi1jqAONvjr93CwJXJ0uMOvJg1tqvZeEllEXufDqCjv5aJrLQofWPFYodgOfTj2Ijh3lr92BAH6NNx740cTEAjLy7aW88blEZHBT65dr01p+VhvCo3lJxmmHPC7/GkpKY5GlWyrJOUzwqniPNKKlCPX2pJ29Oa6hpOm7JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.41) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YZeiB2NZXWvA9Gg/E0O0NVN7vEgBi3GXmcr+E4WdRow=;
 b=qlV516Aq5XSSf1PQal3MfmmZExUAD7m5KTyTonZ1g0yJq2+DJyPKEWElo0RaoUW7CVZ19Huo9qRwU1KY3ruYJus/x4paSA3Dfg5jqeSa/g2J/gZL2D+tfAXKBPMmAEL/csWGdnIUmxqIULlmcQT+1p6d9G127Igz1cfVgdp3w6si/AB+O9zPtLg8gYUjzIOXhkju64H0onP7BVrz8cUg1NR70ZYq2kxVvLS126+FTZ18MOfiybBPtxlYbyf73x5CRKfdwDDm5ReCCUIP768X8z3Wc0Fawn1lzCcjkSSVWpCCHuQYBkqC5A0rliNHBVctrpMe3BEWFZhyAUTf+3TP1A==
Received: from BN8PR04CA0016.namprd04.prod.outlook.com (2603:10b6:408:70::29)
 by PH7PR12MB7212.namprd12.prod.outlook.com (2603:10b6:510:207::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Mon, 23 Oct
 2023 16:46:34 +0000
Received: from BN8NAM12FT022.eop-nam12.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::f8) by BN8PR04CA0016.outlook.office365.com
 (2603:10b6:408:70::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33 via Frontend
 Transport; Mon, 23 Oct 2023 16:46:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.41)
 smtp.mailfrom=agilent.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.41 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.41; helo=edgeappmail.agilent.com; pr=C
Received: from edgeappmail.agilent.com (192.25.218.41) by
 BN8NAM12FT022.mail.protection.outlook.com (10.13.183.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.18 via Frontend Transport; Mon, 23 Oct 2023 16:46:33 +0000
Received: from chris-virtual-machine.localdomain (192.25.126.5) by
 edgeappmail.agilent.com (192.25.218.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 23 Oct 2023 10:46:24 -0600
From: <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH v2 2/2] codegen: cleanup deprecated AST usages
Date: Mon, 23 Oct 2023 12:46:13 -0400
Message-ID: <20231023164613.1441846-2-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023164613.1441846-1-chris.laplante@agilent.com>
References: <20231023164613.1441846-1-chris.laplante@agilent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM12FT022:EE_|PH7PR12MB7212:EE_
X-MS-Office365-Filtering-Correlation-Id: 771a8ed3-089f-44e0-893d-08dbd3e79d89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	LioDDTPVCCwlRVV2GIZGemOWTdCPHxpIbgaUSHBtLj6PkFHydYOd1K1hG2aEdDPDe3stkDdkPBIEFWs+bLR12OuIXkwnFqigBoC9TMk/fK0MJd7VCTFhxY5O53fPiagGSBQuusbxXLF3MdD4U0whwh/h5n8l2f4OlXp1qk4RdDQy7NDPV1fHbx22kSx98V/jCq3QPmErLFG2X+6+K3K8Dvqit3siwDFIxjwKIj9pRb6gxkPJfsNk5RsWwwEufzpfKw8tkE9PD0MmFv6oZKTLhVqtVxbNcBfUBW9ujbgdw12tPYtBQE+S2y01Y0WdmTN0bHdHQ14TCdImFhrSKq5yNB+U74P5akXyU06ZPmKAwQzVPviqcK7wB/OrwA/X1o9l0LVbCkAUTHfBaKF25yBAJwc8lm1eUaukLKvuO1mFPDz2kfDpKuoRqxAaJW4Xebe9clidJP9bqhKe3vWX3miF6wINUsO6/rzlg6rleMnURF3N93geq2iChcNgEZmaN5GMHl3sdvZCLe0xeOKQ2bY5ny7fKEmR481eEskJDGIAnS+rCm5w3LFc/oBwIxWyLaxG49KeRc5QdWVl1vrjqQhNqpoTjxkdUctf1pHCnnvMhIYAc9X3iNsyOAsMTl+4wuvqrTzWb+rTgmpjIwzUlmrRfIQtRZ5HR9FDeMq8sElmkBPEuwBZ7AmquvJ9S0n+48cnLU1hHaPkhOwTh8c+bFDMiXE5HAy0Hw/S4Pq8dvRMeCa3u3/kt8ciwOJ5w8k8Mpbl
X-Forefront-Antispam-Report: 
	CIP:192.25.218.41;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:exch.smtp.agilent.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(39860400002)(396003)(346002)(230922051799003)(82310400011)(1800799009)(186009)(451199024)(64100799003)(40470700004)(36840700001)(46966006)(26005)(2906002)(4744005)(2876002)(41300700001)(40460700003)(86362001)(5660300002)(36756003)(36860700001)(8676002)(8936002)(4326008)(956004)(70206006)(107886003)(6666004)(478600001)(7636003)(1076003)(316002)(82740400003)(356005)(6916009)(2616005)(83380400001)(40480700001)(426003)(336012)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 16:46:33.5593
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 771a8ed3-089f-44e0-893d-08dbd3e79d89
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.41];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN8NAM12FT022.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7212
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 23 Oct 2023 16:46:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15276

From: Chris Laplante <chris.laplante@agilent.com>

This code is just completely dead as of Python 3.8, like the comment
says.

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


