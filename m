Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E060C54764
	for <webhook@archiver.kernel.org>; Mon, 19 Feb 2024 00:38:26 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.58])
 by mx.groups.io with SMTP id smtpd.web11.31432.1708303105696254969
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 18 Feb 2024 16:38:26 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@axis.com header.s=selector1 header.b=rhLAK1mn;
 spf=pass (domain: axis.com, ip: 40.107.241.58, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GHk5qGE8lYtC3o9o6IaczoXVkzWN0eHC72DXLi3qy5+KcYtGQ6SSDNQFTexlRr2FDtMknoC0rHRpeRoh6ONtOs6RNUVFmVwCHF5X0aYVoX1WDc4HpyLjNKgmdEAMkvDVNRk9tgNhf/8YllQ49vv2BCgJwB/Z+ZYRz4WButCo4W8pRRPHBLuFfhoh7W/h+7W5vB1u6/bUx2p8Ed61jSSw1Foaip07HIflkbft9ziJQa1bQjr1l644w6NQR/T3mUBDM3N5fAdADDaYn+bb44+bpLwhbTeuiJh5yv3UscszQPhdEsyddUHQkDkTI6BVPbg/GirX3IkcQDz4mpR6/eYjRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wbAQanpTV8gbc3fnkQfaRAY9mCC6hjC5UY/pIEmW4Go=;
 b=dqFeBDuiJPldYXdGwoMnlEGCMpbi4Bda84g6DNPHZsq4WdP46dhlBrYVX0QBG4eGoLMc0ijhpclP44rBAWDvtBK7OyY/TyJ2LR7EQKfU2bGOaPlWC40VxTW25tJGvNf5L3grTA45GuMlDXgDDUdoIQXP+E7rx4aIgv04mSAWG1Tgd1LgHjndA8jA6oDaWN/o3xLKpufzjvio1apIIWPj5VCiazXm67ht2zKLA0xOY/NxKfpTHaoFimAceciV2OO8ONKYlrjELDviS9n2oU2hyx3xb5NgsB1jWDN6qfPHpqDgoSpuZnUvPbvhmZduSfPoyKyoqjFOwy+VLAouioGlKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 195.60.68.100) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=axis.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=axis.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wbAQanpTV8gbc3fnkQfaRAY9mCC6hjC5UY/pIEmW4Go=;
 b=rhLAK1mnqcJI9D7SPGu+FprwQc394TV3DrvRdm6Pv5YXFBEAtZEA85nGvm2W076zDey90Kw4JQf37xvuFDj2ygQcer0tBr01aDfNrpESUvSs02iw8rvPmC2qEcbIaD0XHSJSRYD3MZDolulN2fN0m2J00jNoW9CfIoCuj3b3rO4=
Received: from AM0PR02CA0163.eurprd02.prod.outlook.com (2603:10a6:20b:28d::30)
 by PRAPR02MB7905.eurprd02.prod.outlook.com (2603:10a6:102:29f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.32; Mon, 19 Feb
 2024 00:38:22 +0000
Received: from AMS0EPF000001B2.eurprd05.prod.outlook.com
 (2603:10a6:20b:28d:cafe::1f) by AM0PR02CA0163.outlook.office365.com
 (2603:10a6:20b:28d::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38 via Frontend
 Transport; Mon, 19 Feb 2024 00:38:22 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=axis.com;
Received-SPF: Fail (protection.outlook.com: domain of axis.com does not
 designate 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com;
Received: from mail.axis.com (195.60.68.100) by
 AMS0EPF000001B2.mail.protection.outlook.com (10.167.16.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Mon, 19 Feb 2024 00:38:21 +0000
Received: from se-mail01w.axis.com (10.20.40.7) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 19 Feb
 2024 01:38:21 +0100
Received: from se-intmail01x.se.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 19 Feb 2024 01:38:21 +0100
Received: from saur (saur.se.axis.com [10.92.3.10])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 0524814940
	for <bitbake-devel@lists.openembedded.org>; Mon, 19 Feb 2024 01:38:21 +0100 (CET)
Received: from saur.se.axis.com (localhost [127.0.0.1])
	by saur (8.17.1/8.15.2) with ESMTPS id 41J0cKuc3024924
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Mon, 19 Feb 2024 01:38:20 +0100
Received: (from pkj@localhost)
	by saur.se.axis.com (8.17.1/8.17.1/Submit) id 41J0cK5E3024923
	for bitbake-devel@lists.openembedded.org; Mon, 19 Feb 2024 01:38:20 +0100
From: Peter Kjellerstedt <pkj@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH 2/3] fetch2/git: A bit of clean-up of latest_versionstring()
Date: Mon, 19 Feb 2024 01:38:04 +0100
Message-ID: <20240219003805.3024867-2-pkj@axis.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240219003805.3024867-1-pkj@axis.com>
References: <20240219003805.3024867-1-pkj@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001B2:EE_|PRAPR02MB7905:EE_
X-MS-Office365-Filtering-Correlation-Id: 35e34ffe-ba71-4e0f-7ca3-08dc30e312fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	djEIfWBxzM3iEQVsV4p+9RjCWVJhb5HnIi2BHBSzrs+OeeOKwU/FOBXJaMidcowX5nEl8BfdrQODlgKYUvbztVKqKcx6NFtXKqqEHwfWoS8F/e/R4xmARyGuXstmwFJhbmT+bJddrVoYwlL0hBE/UjNaIDpFxWsHTza6fiAAn4iZuIhFDo5HuifofjFSenTOe/+p0wvfAFCrRx0SBHDiddLVcDoIVziomeKyY5SeWlS1mWFoMiVkbTt3TSaka89r6uliGqylxHeATwrubUHthlYYE9sXgnJuYZqR9hd8Qf/IHponPB804gO5ANtFcyNcUEwaYKWcFG/hF8Ltkuk0pZk1frwff+ckxhLqQO4do6/sU9rQSadZkkEFw7L5QE0plK5EmmXhZGCxG9oI0AWnvk/ZxkTwWKcd5Gbqotb3AT19GqGsVN6Qm8o3+dNPjidHOFrHfBySF5sv8N47bcpKzHl28TOAAaMdvhyS8QVPvuuOdHsYryvq/5PuHjNn41wLu07+qeYQRWTofIpAGp9ZHhOyj3EHWK+uFo+YUFWjEVO4NPFOxQ4aVskDMz6zcyKB1emkqxynDlxRFCuO5OBHnbcX+SUXNWL0Gkh6TImzxjUKrI14KDB/LDZEFT4kGsuUWQ/C+ci+NK0HzyhjtwPZH77HtQyCCIt1GjG4LAHbxAk=
X-Forefront-Antispam-Report: 
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(136003)(39850400004)(346002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(82310400011)(36860700004)(46966006)(40470700004)(2906002)(8676002)(5660300002)(8936002)(83380400001)(1076003)(2616005)(26005)(336012)(82740400003)(36756003)(426003)(356005)(81166007)(70586007)(70206006)(42186006)(6916009)(316002)(478600001)(6666004)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 00:38:21.3610
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35e34ffe-ba71-4e0f-7ca3-08dc30e312fd
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AMS0EPF000001B2.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAPR02MB7905
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 19 Feb 2024 00:38:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15933

This is mostly preparations for the next commit.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---
 bitbake/lib/bb/fetch2/git.py | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index 0deeb5cee1..a69371a57e 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -812,37 +812,36 @@ class Git(FetchMethod):
         """
         pupver =3D ('', '')
=20
-        tagregex =3D re.compile(d.getVar('UPSTREAM_CHECK_GITTAGREGEX') or =
r"(?P<pver>([0-9][\.|_]?)+)")
         try:
             output =3D self._lsremote(ud, d, "refs/tags/*")
         except (bb.fetch2.FetchError, bb.fetch2.NetworkAccess) as e:
             bb.note("Could not list remote: %s" % str(e))
             return pupver
=20
+        pver_re =3D re.compile(d.getVar('UPSTREAM_CHECK_GITTAGREGEX') or r=
"(?P<pver>([0-9][\.|_]?)+)")
+        nonrel_re =3D re.compile(r"(alpha|beta|rc|final)+")
+
         verstring =3D ""
-        revision =3D ""
         for line in output.split("\n"):
             if not line:
                 break
=20
-            tag_head =3D line.split("/")[-1]
+            tag =3D line.split("/")[-1]
             # Ignore non-released branches
-            m =3D re.search(r"(alpha|beta|rc|final)+", tag_head)
-            if m:
+            if nonrel_re.search(tag):
                 continue
=20
             # search for version in the line
-            tag =3D tagregex.search(tag_head)
-            if tag is None:
+            m =3D pver_re.search(tag)
+            if not m:
                 continue
=20
-            tag =3D tag.group('pver')
-            tag =3D tag.replace("_", ".")
+            pver =3D m.group('pver').replace("_", ".")
=20
-            if verstring and bb.utils.vercmp(("0", tag, ""), ("0", verstri=
ng, "")) < 0:
+            if verstring and bb.utils.vercmp(("0", pver, ""), ("0", verstr=
ing, "")) < 0:
                 continue
=20
-            verstring =3D tag
+            verstring =3D pver
             revision =3D line.split()[0]
             pupver =3D (verstring, revision)
=20

