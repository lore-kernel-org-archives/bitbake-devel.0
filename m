Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9FCEC4167B
	for <webhook@archiver.kernel.org>; Wed,  6 Dec 2023 20:48:10 +0000 (UTC)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (EUR01-HE1-obe.outbound.protection.outlook.com [40.107.13.48])
 by mx.groups.io with SMTP id smtpd.web10.44829.1701895681468601288
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 06 Dec 2023 12:48:02 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@axis.com header.s=selector1 header.b=TgBV1Mpb;
 spf=pass (domain: axis.com, ip: 40.107.13.48, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EEO3vHgFUpec/chCrcydQb7wu/F1HtXEIxSZyp56wimm4CLzJZ7WfsYnuF9Z36fEe045SWD/Ud6Eu4x3nl+Towamt93ZSnjcvRcJaZ0K5YUyg+aZao9yRDv8tqYv9OXQo8p8pqI0szDE6Fsu2iqNdn/ngqitQ9r6nGsa8HPJAqVtjRlrl41A6eQpCcpWRGGNn8zbXU5+TzA7lsHoLbRS0osNkrqx43wh9mGRbwSCWzrATsK/hc9ZKItHQv1WhnOBT95/LNvHGPvlVsjgJM/Z+knhvYc8bhkxRKpdMJF2tAYZZ7S4eG1s2RVxPmLHvPNpo62400eYjvzWqaaXabLFDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rLpPQAHykdKXv53USPWJ9RE4uWqAc47FIB9VLZtDloI=;
 b=OfsE+plk9lw0vVHA8vECJEdA4Soq4FmH2M3dqTbcnMZavZgmd01Xm2M6SZf+PX0XQL/xdSjhlEVrsO+ltLiFRTQFDlafENZhVLDhUnHYoB8vozHZ6DcGkomT9obYOW3bn/+cf9R7J/9KhN0HqfOPcQseAsgIvgz6aRIHMoj4fohsR/JOouOeK25zg1/t+satsv621a2ApKWoC0QoSb4splahSCpXdx5/YFK3AVNiq47owCc8hJVY0yy3eXlgQG0CwNDuKAXQZcTLDpAJ/w6Gb5Jyz6vdhBDHWlEt8mIwMTSwn2rZP6zZXDyrZJaYgs5pNL6MNE9S30IZmpABgPz2+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 195.60.68.100) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=axis.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=axis.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rLpPQAHykdKXv53USPWJ9RE4uWqAc47FIB9VLZtDloI=;
 b=TgBV1Mpb3zy4JjQXG7Q5tDZhzoPeMwjQjL8v3BWsRmZgtU95nymyipvWu+9CSgJmC5MwRjm9MZcHOO78EhAXaDPlxMtjncLLZiwqD9y9H1o3BTJqjSNOUs3i7NrUFLRpeH/i8iJtUfv8Rtzp7nj91zTHC8uqFmRtTVXSZTBYdNE=
Received: from DU2PR04CA0227.eurprd04.prod.outlook.com (2603:10a6:10:2b1::22)
 by AS8PR02MB8779.eurprd02.prod.outlook.com (2603:10a6:20b:53d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 20:47:57 +0000
Received: from DB1PEPF00039230.eurprd03.prod.outlook.com
 (2603:10a6:10:2b1:cafe::d8) by DU2PR04CA0227.outlook.office365.com
 (2603:10a6:10:2b1::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Wed, 6 Dec 2023 20:47:57 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=axis.com;
Received-SPF: Fail (protection.outlook.com: domain of axis.com does not
 designate 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com;
Received: from mail.axis.com (195.60.68.100) by
 DB1PEPF00039230.mail.protection.outlook.com (10.167.8.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.23 via Frontend Transport; Wed, 6 Dec 2023 20:47:57 +0000
Received: from se-mail01w.axis.com (10.20.40.7) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 6 Dec
 2023 21:47:56 +0100
Received: from se-intmail01x.se.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 6 Dec 2023 21:47:56 +0100
Received: from saur (saur.se.axis.com [10.92.3.10])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id AD6FBF64E
	for <bitbake-devel@lists.openembedded.org>; Wed,  6 Dec 2023 21:47:56 +0100 (CET)
Received: from saur.se.axis.com (localhost [127.0.0.1])
	by saur (8.17.1/8.15.2) with ESMTPS id 3B6Klu5M4034791
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Wed, 6 Dec 2023 21:47:56 +0100
Received: (from pkj@localhost)
	by saur.se.axis.com (8.17.1/8.17.1/Submit) id 3B6KlufU4034790
	for bitbake-devel@lists.openembedded.org; Wed, 6 Dec 2023 21:47:56 +0100
From: Peter Kjellerstedt <pkj@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [nanbield][PATCH] command: Make parseRecipeFile() handle virtual recipes correctly
Date: Wed, 6 Dec 2023 21:47:48 +0100
Message-ID: <20231206204748.4034775-1-pkj@axis.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF00039230:EE_|AS8PR02MB8779:EE_
X-MS-Office365-Filtering-Correlation-Id: b97c03d8-dfab-43fa-fd81-08dbf69ca0a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	VZEv/nLYvNVAHDHjuII4nH2IUVJvw1GZbeXLBTmCpRrEx21fhsfzfyj0ld/JptJ5X6sEegLAzg7m/nS7189OYkPKZVJFOv7Pf0hMx8AMxd2ivv9eJUG1xen/C3BeaLE6WEW+DvLuubgs1Q0Qem9dhZtRvwo1EsQTfQrC481JK9K+VH5OeCzZYJbe9gYlexWUzb6jIuXoqVfxnnc0YM7tQpxkIBSqlzMds55CMk9oozQt7/7RSWQ63DgS4JTJRS70198sE9Uw9AFNA1Z5NRitW7d4+7yTcO89Dy3qRAMiSXqtMgaN95sO4R5DyltWYt5Ughw/TQFZN6fEKiVvESrB23sTHmeT58+hzOMFJfXeFAE1L2ivqSGgtVZRd9y3P6zX9DrZpGU6Qu3IT0n7Sn8GQFFTe1dxfMpdz462Bxf8VW4ReAtFhkigYmbfWsnW27av2nukfVIFqGCIALX5jYCC3MNxM6cCgPH0oaT/LjrU+0sKtaQiy2a9Zxhr58OyRoz46h2BGrHl0wVVawIq55dmeYrTxw35MnDZbddVfdL1xVpxiefUt2uUjivg22gdYxMGaH5UOhO0ZNP75nfgvk1ken/k1uXCKHHLbnH+do9W+7WKM2yvVELFeZ5RhlTut7qIiMvozCt3JWu54XgbwEGSQtLv5MToJ5j/RD9GYhYcNeLoNRIqt1tu4fHuqgY5ZytoAmmwoDjMTGIB+UgU4NP9e6fYFeOyew2N15cxodR7Lr4WcZmO549bPqRhndzGUQkL1QuwpyIVJvhokxoIJZmm0w==
X-Forefront-Antispam-Report: 
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(346002)(396003)(39860400002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(82310400011)(46966006)(40470700004)(36840700001)(26005)(81166007)(82740400003)(47076005)(36756003)(426003)(336012)(41300700001)(40480700001)(83380400001)(36860700001)(1076003)(2616005)(356005)(6666004)(2906002)(40460700003)(5660300002)(316002)(42186006)(70206006)(6916009)(70586007)(478600001)(8936002)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 20:47:57.2865
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b97c03d8-dfab-43fa-fd81-08dbf69ca0a3
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB1PEPF00039230.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB8779
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 06 Dec 2023 20:48:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15621

From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>

Running `devtool search gcc` would result in errors like this for
virtual recipes:

  ERROR: When reparsing
  .../meta/recipes-devtools/gcc/libgcc-initial_13.2.bb:do_populate_sysroot,
  the basehash value changed from
  b1cd809ed98cef9db0fb1b17d34c4083e739c336f9d5619b89715b0294d81af5 to
  44c2f92781dc4a20e98b7bb4724e204e64b101905fa75e71241a574b725997dc. The
  metadata is not deterministic and this needs to be fixed.
  ERROR: The following commands may help:
  ERROR: $ bitbake libgcc-initial -cdo_populate_sysroot -Snone
  ERROR: Then:
  ERROR: $ bitbake libgcc-initial -cdo_populate_sysroot -Sprintdiff

The reason was the newly introduced :layer-<layername> override, which
is used, e.g., in meta/classes-global/insane.bbclass to add the
patch-status QA test only for the meta layer:

  ERROR_QA:append:layer-core =3D " patch-status"

When tinfoil parsed the recipes using the parseRecipeFile() function, it
failed to properly identify the layername for virtual recipes, which
resulted in the error above.

The correct thing to do is to make parseRecipeFile() call
bb.cache.virtualfn2realfn() to convert the virtual filename into a real
filename and virtual class.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bitbake/lib/bb/command.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/bitbake/lib/bb/command.py b/bitbake/lib/bb/command.py
index f2ee587161..79b6c0738f 100644
--- a/bitbake/lib/bb/command.py
+++ b/bitbake/lib/bb/command.py
@@ -550,8 +550,8 @@ class CommandsSync:
         and return a datastore object representing the environment
         for the recipe.
         """
-        fn =3D params[0]
-        mc =3D bb.runqueue.mc_from_tid(fn)
+        virtualfn =3D params[0]
+        (fn, cls, mc) =3D bb.cache.virtualfn2realfn(virtualfn)
         appends =3D params[1]
         appendlist =3D params[2]
         if len(params) > 3:
@@ -574,10 +574,10 @@ class CommandsSync:
         if config_data:
             # We have to use a different function here if we're passing in=
 a datastore
             # NOTE: we took a copy above, so we don't do it here again
-            envdata =3D command.cooker.databuilder._parse_recipe(config_da=
ta, fn, appendfiles, mc, layername)['']
+            envdata =3D command.cooker.databuilder._parse_recipe(config_da=
ta, fn, appendfiles, mc, layername)[cls]
         else:
             # Use the standard path
-            envdata =3D command.cooker.databuilder.parseRecipe(fn, appendf=
iles, layername)
+            envdata =3D command.cooker.databuilder.parseRecipe(virtualfn, =
appendfiles, layername)
         idx =3D command.remotedatastores.store(envdata)
         return DataStoreConnectionHandle(idx)
     parseRecipeFile.readonly =3D True

