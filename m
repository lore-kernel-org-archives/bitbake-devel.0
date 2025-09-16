Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8529CAC59D
	for <webhook@archiver.kernel.org>; Tue, 16 Sep 2025 21:19:47 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.33])
 by mx.groups.io with SMTP id smtpd.web11.7528.1758057584471179722
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 16 Sep 2025 14:19:44 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@axis.com header.s=selector1 header.b=JpDW/cdd;
 spf=pass (domain: axis.com, ip: 52.101.65.33, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xylA8HFZO4jKBlZ8/WxwrEVgYqZcS8PoLEGYY+9oTi6R6Htlic2/CzmM+KC37htkimDswlJX3BNwn5+9MRqIv/PeFH9Csyj1byJxkLGX1Gf2pmIeLew4gF6HYJAo/APzxIIT6PxgVlbEU8h1Ta1lrwyPRdGCjHY6BlEyuUPfeNTx+MoXJ56oJ/jJV+QtT7vAI1jiI5lWndNTxyDmfV3UORP/Zt9Ag+pxP2FBZPDNkkn2RNMu+sIEc7gECh2ZECihFREqxOd8bKla70S5woFfg8bFimt6jEqsk1Dcn7Ht0u7aYn4MTQWV/6JVKkvwSJC+UB5KUy/s+WtSEAsK04hxGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UebvSnGRT0LhWAbTqPt5hGk3DaiazlT/x2kSWBp+mQ8=;
 b=wvIdd11gZfE8ROxJkuWyE8BRHfDMkra8UKWyO6isPo51XbWos2VkoDtVZv7Ze8va9oiGxbdKjD+3VCRYg4xHPrYFesTT6IR5fWUrVxscPXm9SiFRhByGDnrDS9yGfV/UND7yaS3ubHwdrJh/7RW+upBblKkhqaCfNycPc8FVFzWzvw3yVjVHhvf7tsyAvm0dy6RUQvkSalWg6l3otcXVYkAgWKcZ+A9tTSqIJbVQhG1jDt1ugY0K9VRxNFyet4AM+TMTLHhJq8hGJ2qOY213c1zjf09mk4IdgNf/iN6/+iadn6Ixm/mILhEJXLeEvPCPknyFZYW1998Z4zZLWnCSJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=axis.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=axis.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UebvSnGRT0LhWAbTqPt5hGk3DaiazlT/x2kSWBp+mQ8=;
 b=JpDW/cddRbqzp2ZMUEgEvK4500vBlnyU57+oeYmuwNEv9RGepuQBf178qokVzvCdbtPVQ4Bclwfx9l9uHS2kXpXxV9vuXSBtVCcNTiio/zbRwC6ZjHwpy4wMgiU6SLTjNIzBUcMFVQb9FOuJKfiS13y/I8RRH4/R56U3qu3YK8Y=
Received: from AM4PR0302CA0018.eurprd03.prod.outlook.com (2603:10a6:205:2::31)
 by DB9PR02MB6762.eurprd02.prod.outlook.com (2603:10a6:10:1f8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 21:19:38 +0000
Received: from AMS0EPF000001AE.eurprd05.prod.outlook.com
 (2603:10a6:205:2:cafe::73) by AM4PR0302CA0018.outlook.office365.com
 (2603:10a6:205:2::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Tue,
 16 Sep 2025 21:19:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS0EPF000001AE.mail.protection.outlook.com (10.167.16.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 21:19:38 +0000
Received: from se-mail01w.axis.com (10.20.40.7) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58; Tue, 16 Sep
 2025 23:19:38 +0200
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Tue, 16 Sep 2025 23:19:38 +0200
Received: from pc56063-2339.se.axis.com (pc56063-2339.se.axis.com [10.92.3.2])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 12525290D
	for <bitbake-devel@lists.openembedded.org>; Tue, 16 Sep 2025 23:19:38 +0200 (CEST)
Received: by pc56063-2339.se.axis.com (Postfix, from userid 14323)
	id 785791200CB; Tue, 16 Sep 2025 23:19:37 +0200 (CEST)
From: Peter Kjellerstedt <pkj@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCHv2 2/5] tests/parse: Remove unnecessary calls to file.flush()
Date: Tue, 16 Sep 2025 23:19:31 +0200
Message-ID: <20250916211934.253650-2-pkj@axis.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916211934.253650-1-pkj@axis.com>
References: <20250916211934.253650-1-pkj@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001AE:EE_|DB9PR02MB6762:EE_
X-MS-Office365-Filtering-Correlation-Id: 131345a3-b2a8-42a2-0ae0-08ddf566be51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?HAAAudp1GNtFQMgeC3z2rjA3dh2JO+LKgcJ02vfOhLhs1JkCr9BfVzLA9ki+?=
 =?us-ascii?Q?jtje3u5+Q44Z52JC8A4lzUc82hD32Xb8/mMplXGwpYZioCOEBd1jftSjr03D?=
 =?us-ascii?Q?UVxFscn+qdkwHq7pe1NjdDlaViIxwbbxY0QefjGa/ON0K/vmYSrkdnANVKDS?=
 =?us-ascii?Q?i7q5eddoTNABYP5ym6A9ydlFs43yd6YtfY1He/GKZ1GcxE4NrpM6KjEbFCFt?=
 =?us-ascii?Q?ssQq5jCpU49MW247OWpgtrYWTT59BwTNpdS/coiVym3XvKCZLw17Ttsr5j39?=
 =?us-ascii?Q?QaYLl29CoDzwDtrfnTzhmB/QSXAXVK+Qgc/KFyRZE/TZrAsZOuGVH27c+ASG?=
 =?us-ascii?Q?xhx4cSIxx3vXYEcEUV3T0LaJXABW2lImgRUCS35Xpvhy11xnoDdkvOaKwWL6?=
 =?us-ascii?Q?l50Qr4jkry9qEFykaK3z+5YU6dK+PQF085S2COf0E1tbn6J5WFAJf1d35xhG?=
 =?us-ascii?Q?esyitjJoibQf9DTCSNjDyoUG5PZYnjIFJEr5Bca8wm5Hu9bnruIA+igTwqKR?=
 =?us-ascii?Q?c486l2CK+Gryf9CQU6aknVfYSImf1LWfxVn23EBNvYSLS3UFr0oK8Wd9ykSG?=
 =?us-ascii?Q?1OMJ2IziarOgd6b+6Udw9W4QSHkbUgLTmtPbbA8kVAcnO7wFEW6SWnJlNCVf?=
 =?us-ascii?Q?4RNAor0ahstjd2tXciJOLjMbspCAsUpJZKG4VeBfEB0JnHSyoPNg0iJp5auY?=
 =?us-ascii?Q?6o0ve9BPnPYzafIhCIjpjnFwdOKkEqGPUDSkgJZuTmnHF+/nUY3THiogkBk4?=
 =?us-ascii?Q?KflDXNpW0odXn+v7Y8+MZgaHg9Cncvfm5MpVXBtJZ2ZrULd36P0mFDQC6EQO?=
 =?us-ascii?Q?kU9nIhteHCb3eBrwdhrHHg08ITZibwUF0ZdCDwwAuwYrvvzlCNzGcrGZkoGx?=
 =?us-ascii?Q?wgvk+ACpNJKy42FRfdhRMQqmVjCenKNnI1EC/5hOJ/V5w7/C54/Uux8oxOwe?=
 =?us-ascii?Q?kdmIbaaZvGZD+617ZGH1xEgzRNG4dxdBuDxpwPYkHKP3SDgt1bS+VRqsiAiN?=
 =?us-ascii?Q?6ke4LjeXz3z3i69lmIJXHNDgi4WiSrnXS2pMYbXnJbj+A08QNClwP8GsTxHg?=
 =?us-ascii?Q?7AacK8afF5j2uarU0tQtmB89d3hlAOGvTBAkTUiEWx5JC4EK36XvOOmSYshA?=
 =?us-ascii?Q?jKEMZ9VMtTVls4C1szwlU0FUwS9G4n69WpyOIIOSL5/k9dcWaOM+RKz7aVtA?=
 =?us-ascii?Q?k5362twDKbmAFlCKV36W8JaE3UYdp7aKU0SBrWmCTdEELBIaWGAR+TBDy80h?=
 =?us-ascii?Q?KkbLbjXMHDbaFvfCDelCHDjL0G6H2whagjSOiGB2d12AAOscLfTNuvyrqv1H?=
 =?us-ascii?Q?+tnzvIMOzZwEZ/tyY84uOY7HA1NJmiiviBGJdplTjyAoaTuF0tl5/LAKRxwS?=
 =?us-ascii?Q?5z9GNI+w+FA4pweSm3eJj7eyhtuzUo7juQsizh9nJAxPdneJt7dRD6/LqNMw?=
 =?us-ascii?Q?O2085LrL9BgSAYBiMs8C7hec+QBhhFAQ3WqHBAxSD8haePYQsv53Ec45Na57?=
 =?us-ascii?Q?sBsCtUSJFCj1de31cPEhzpwg9uFi4002YVr2?=
X-Forefront-Antispam-Report: 
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 21:19:38.4501
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 131345a3-b2a8-42a2-0ae0-08ddf566be51
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AMS0EPF000001AE.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB6762
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 16 Sep 2025 21:19:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18044

There is no reason to call file.flush() as the last call within a file
context manager since ending the context will close the file and thus
flush it.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---

PATCHv2: No change.

 bitbake/lib/bb/tests/parse.py | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/bitbake/lib/bb/tests/parse.py b/bitbake/lib/bb/tests/parse.py
index b272739f56..431b0c7d3e 100644
--- a/bitbake/lib/bb/tests/parse.py
+++ b/bitbake/lib/bb/tests/parse.py
@@ -349,14 +349,11 @@ EXPORT_FUNCTIONS do_compile do_compilepython
             os.makedirs(tempdir + "/classes")
             with open(tempdir + "/classes/someclass.bbclass", "w") as f:
                 f.write(self.export_function_class)
-                f.flush()
             with open(tempdir + "/classes/secondclass.bbclass", "w") as f:
                 f.write(self.export_function_class2)
-                f.flush()
=20
             with open(recipename, "w") as f:
                 f.write(self.export_function_recipe)
-                f.flush()
             os.chdir(tempdir)
             d =3D bb.parse.handle(recipename, bb.data.createCopy(self.d))[=
'']
             self.assertIn("someclass_do_compile", d.getVar("do_compile"))
@@ -366,7 +363,6 @@ EXPORT_FUNCTIONS do_compile do_compilepython
             recipename2 =3D tempdir + "/recipe2.bb"
             with open(recipename2, "w") as f:
                 f.write(self.export_function_recipe2)
-                f.flush()
=20
             d =3D bb.parse.handle(recipename2, bb.data.createCopy(self.d))=
['']
             self.assertNotIn("someclass_do_compile", d.getVar("do_compile"=
))
@@ -377,10 +373,8 @@ EXPORT_FUNCTIONS do_compile do_compilepython
=20
             with open(recipename, "a+") as f:
                 f.write("\ninherit secondclass\n")
-                f.flush()
             with open(recipename2, "a+") as f:
                 f.write("\ninherit secondclass\n")
-                f.flush()
=20
             d =3D bb.parse.handle(recipename, bb.data.createCopy(self.d))[=
'']
             self.assertIn("secondclass_do_compile", d.getVar("do_compile")=
)
@@ -418,7 +412,6 @@ include \\
                 recipename =3D tempdir + "/recipe_unclosed.bb"
                 with open(recipename, "w") as f:
                     f.write(content)
-                    f.flush()
                 os.chdir(tempdir)
                 with self.assertRaises(bb.parse.ParseError) as error:
                     bb.parse.handle(recipename, bb.data.createCopy(self.d)=
)
@@ -434,7 +427,6 @@ include \\
                 lines =3D self.export_function_unclosed_tab.split("\n")
                 lines[3] =3D "}"
                 in_file.write("\n".join(lines))
-                in_file.flush()
             bb.parse.handle(recipename_closed, bb.data.createCopy(self.d))
=20
     special_character_assignment =3D """

