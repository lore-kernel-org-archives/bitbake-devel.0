Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E4DECDB474
	for <webhook@archiver.kernel.org>; Mon, 16 Oct 2023 18:34:22 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (NAM04-DM6-obe.outbound.protection.outlook.com [40.107.102.69])
 by mx.groups.io with SMTP id smtpd.web10.135311.1697481255563425348
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 16 Oct 2023 11:34:15 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@agilent.com header.s=selector1 header.b=um+Q3L4M;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.102.69, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BxjiqRPodHjPbsutANcIhWe+esOQzW9dIoOxYXrhLdiaEFeM3JJDDqbhX7I76mb6yHQLWOzjKa2kdUrkVlYdfQ1RrxauO24BfCUWYjorXXFj2x4ZLNroXJby9dVbyTCb8U1eom5fI5KrupBQfhl7f4ZrsUMUxqRM8ge+H7gUBjsGc7yCyN4QUyqeltLK0W/Rig6IXAaSSFER0lkcY+bwN7ngbq4KjZNkRFXuzZcmfFydPTQMrF3/0Iq1NUvN6atRCkhzw4V3RrQiU2AEku8RXvxYFR/HrI82oSC3XkC3uzjozs4U05reU4SguwXx/jnCPkLgLNcxzZTF4VFlq0rSQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kG8XwHYZBgm8ezA9EQ/dbKmnLX+ST7YFcsBEc00DD3s=;
 b=gohqXyoZ+h4sL9BB4qa+lWPhHQAqLjqhdNY1llYQHuOEqjYomID56cGwcxaiITPsmAtmahg0V3L8mXELUGI8YBvnxhRVbjZ4sRUVdtSuyoeHpebwuGhKgke1xMl012opi74jpRFIOO1IyevSdpxHS/DKkmrHJWL6Gj3erTXeF6r+DXFV637iiF99A4p33YiHISR1WeoDeJmBVmktl0IPApwjcB814Yc9rGIgHEU1URiMokbH8LBva0V77m0Dv5gN7LiADfdc83lT/rA50wXD7juFcFJiFfiqJO0iyqxyjexXV/uyLVS4Xd8Q35j+qF2E0lhutAHZO/vheHJ0y3Zhtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.41) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kG8XwHYZBgm8ezA9EQ/dbKmnLX+ST7YFcsBEc00DD3s=;
 b=um+Q3L4Mz8OnhtlR50i0XhJueFwixEIILhs19Tig8dYviPepfcs0MIJCzMCHEDJzV5rIIxk0DTClWze6/c8s+Vb/TkqPvHryYlDRHT0eXFwZLjGfEcegNgC18rI0MA7Cl6G3qx+x5lik43JE72ALc8hEWLthWAP1999s7m15U3Fh1FuV1nRP6qrYvjkPhYPzWQaS+cfohhLgkY6cCG1Fa0SRo0Ep3VRlBR0p1emSNy9rMunLNYDWp8kwXoMDj98kGC4lTDNle81NpLbAe2ywDMRVg+eLNX1nW4kVbviEaodtxlsMJxZ17X8V7WWAmmyp4Mr5wqbMeK7PyETmSnu8Fg==
Received: from MW4P221CA0021.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::26)
 by BL1PR12MB5125.namprd12.prod.outlook.com (2603:10b6:208:309::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Mon, 16 Oct
 2023 18:34:13 +0000
Received: from MW2NAM12FT004.eop-nam12.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::ae) by MW4P221CA0021.outlook.office365.com
 (2603:10b6:303:8b::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35 via Frontend
 Transport; Mon, 16 Oct 2023 18:34:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.41)
 smtp.mailfrom=agilent.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.41 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.41; helo=edgeappmail.agilent.com; pr=C
Received: from edgeappmail.agilent.com (192.25.218.41) by
 MW2NAM12FT004.mail.protection.outlook.com (10.13.180.71) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.19 via Frontend Transport; Mon, 16 Oct 2023 18:34:12 +0000
Received: from chris-virtual-machine.localdomain (192.25.126.5) by
 edgeappmail.agilent.com (192.25.218.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 16 Oct 2023 12:35:10 -0600
From: <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH] codeparser: replace deprecated ast.Str and 's'
Date: Mon, 16 Oct 2023 14:33:46 -0400
Message-ID: <20231016183346.4343-1-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2NAM12FT004:EE_|BL1PR12MB5125:EE_
X-MS-Office365-Filtering-Correlation-Id: 88471f8c-c052-47ea-9ff4-08dbce767e91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	pT4PDxlBJQiQLyeUxWVL2qK7Z63A8m/nedjfDXS3bUtPGPr4WLmGrHZ5dx7I7+s1kpKzh/dv2wClsrtTA5Z9varYMho4fgnf1hiXVz3Rad3dwBBlVdMTcU807ti671G57Jpp0B4p76vv2xYtaDNLiVCXzaTjuHRGC/AFfLTUMvqB+tGMs2tAg5DzU53OHJ1GTty5qwk0py96OUShQr3s9k5FOHoPrP1o2H/8uj/202PhUqVArSbqLfQEsQlJOJwVGIkslkTqG/zT5z4q1v62lhYCKG96D0ZH+8vGv4MqVEK0Yqr88mVw+dcusppEi79/pytIyOe9F83b0lOsbdhK12SVazpqjDtx3rHNyWqFQc/xVgdVxuRRulhVgxs+8JIVQsdPc9V8Of8cKk88lJhFM/8BVOlFIy/51EEDY855jALHl8yZZn4OH4YnwHVbqsZbdc7bohbFk3HtZ/btLeA63PcIyu1Q/BZFq/+ZuBqGcZJ+6WKd1CPDx3QH4g5rC6hgMfuoWxmVZyBDGQXPXHB27xJ8sb2ZTM7TcqqzlOe8bSW9W7LFaswuKV7uDTRDGvTqjCNbC1hwYf2ivRw5LKdpTmtBFVMpGg90TXUaBZH7HGOg+fx/1w9fo9o+syr4AY28052lMRLtM05XSLcsuCMcg6OqXRPQ4Xsu1RxiNf0WwF+GK14blr8VD2IXaviZPEBJK5PmfIbE+/G1gqWnSdau9zDAyXWf5m4vrqFLcKnCwFp+5OQ8qkK1+oCpycDWalDD
X-Forefront-Antispam-Report: 
	CIP:192.25.218.41;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:exch.smtp.agilent.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(396003)(39860400002)(346002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(82310400011)(40470700004)(46966006)(36840700001)(40480700001)(40460700003)(478600001)(70206006)(6666004)(6916009)(356005)(47076005)(83380400001)(36860700001)(82740400003)(336012)(316002)(86362001)(26005)(107886003)(956004)(1076003)(426003)(2616005)(36756003)(41300700001)(5660300002)(7636003)(8936002)(8676002)(4326008)(2906002)(2876002)(4744005);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 18:34:12.6899
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88471f8c-c052-47ea-9ff4-08dbce767e91
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.41];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MW2NAM12FT004.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5125
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 16 Oct 2023 18:34:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15247

From: Chris Laplante <chris.laplante@agilent.com>

These have been deprecated since 3.8

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/codeparser.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/codeparser.py b/lib/bb/codeparser.py
index eabeda591a..cb068844bb 100644
--- a/lib/bb/codeparser.py
+++ b/lib/bb/codeparser.py
@@ -255,8 +255,8 @@ class PythonParser():
     def visit_Call(self, node):
         name =3D self.called_node_name(node.func)
         if name and (name.endswith(self.getvars) or name.endswith(self.get=
varflags) or name in self.containsfuncs or name in self.containsanyfuncs):
-            if isinstance(node.args[0], ast.Str):
-                varname =3D node.args[0].s
+            if isinstance(node.args[0], ast.Constant) and isinstance(node.=
args[0].value, str):
+                varname =3D node.args[0].value
                 if name in self.containsfuncs and isinstance(node.args[1],=
 ast.Str):
                     if varname not in self.contains:
                         self.contains[varname] =3D set()
--=20
2.34.1


