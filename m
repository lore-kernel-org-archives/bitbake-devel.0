Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A0D1C61D88
	for <webhook@archiver.kernel.org>; Tue, 21 Nov 2023 01:35:46 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.41])
 by mx.groups.io with SMTP id smtpd.web10.25128.1700530536793938414
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 20 Nov 2023 17:35:37 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@axis.com header.s=selector1 header.b=mV3wrhjP;
 spf=pass (domain: axis.com, ip: 40.107.22.41, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XJL6urwTx5RKMCJuTmpUkbzmjS8jg00EVbOpFdSQXvLsHEkUm2Mpme0JGcZCnvoTWupBitIu75pf1pK03MoPD1uNregqMwaolLr5WpLNDTuErpbyca+NHLvA4PzqDh5iW1VPRVx4nGLxAH0J0ZqdunL2Q97yKLOyWzA7MLPNY2GYggWPJsuMJzCpDZNhdy4Flmo5RmVFhJylzwtoLTsMYHv3x1r1XWHBQF/Sv32b3ZvYBWZE1m5Alo570MNOfuMG5wqyGtXvZZz9ELjdJs3F9rN9T6gDxy5W6Vl39Jlkq2+TG3KKPvEAXOMfY8rKx2Y5/9mzFGj8LJPupeXVUxZ3Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IfbNgVQGDm48WzDN/BasYWnjDXxk8EO3WVeqnZeivi8=;
 b=FbchKLcBl81ZmnUd2A0T6lqS5cWm6PELvw+L7iEGLDl6FIHLF1ttO1JYdRHZ+nudvtsX1r0ADiiZ+x/yAAtft/MMlxe4UHUrMKYSZmihGk9s2YCiYg7/2Cuf2I4jvpjkckpdgC7WFa9+C8rN0gK4Kvdr/mYhwERh5AxBp1JceqKJjIxkK80mycF6dwcHT4MoKx7gHWDntPkSrUUMBoMDcJVi85sJ632fJ2hDvAQa8tw6QkmsL25xfYBnL1UHnH8jNDOE6UqMSzE7ZMhAzbOQI3Vyu3hFvIc+dgsg6TytRfnNdsVwDIFZyk/Malj84t4DSunFeoxMAgEE4Srdw+bGQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 195.60.68.100) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=axis.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=axis.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IfbNgVQGDm48WzDN/BasYWnjDXxk8EO3WVeqnZeivi8=;
 b=mV3wrhjPMwMIDtt7FKA6JZPQo34aXxiUqApQl5OdqkEpbEWeigKZlM04tG0J0UKBfwSW5Nm/0qqzSYLmxXZ8a8zSNhAUi0hHANzT36iplrygrUQVE0DiLCnxs4Gq3yXs/g1PUMoJxlRndNuxFRUJkgFKF09BuksyYMvfqC2dYc8=
Received: from AM6P194CA0055.EURP194.PROD.OUTLOOK.COM (2603:10a6:209:84::32)
 by DB9PR02MB9875.eurprd02.prod.outlook.com (2603:10a6:10:461::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Tue, 21 Nov
 2023 01:35:33 +0000
Received: from AMS0EPF000001B6.eurprd05.prod.outlook.com
 (2603:10a6:209:84:cafe::d2) by AM6P194CA0055.outlook.office365.com
 (2603:10a6:209:84::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26 via Frontend
 Transport; Tue, 21 Nov 2023 01:35:33 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=axis.com;
Received-SPF: Fail (protection.outlook.com: domain of axis.com does not
 designate 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com;
Received: from mail.axis.com (195.60.68.100) by
 AMS0EPF000001B6.mail.protection.outlook.com (10.167.16.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Tue, 21 Nov 2023 01:35:32 +0000
Received: from se-mail01w.axis.com (10.20.40.7) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 21 Nov
 2023 02:35:32 +0100
Received: from se-intmail01x.se.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 21 Nov 2023 02:35:32 +0100
Received: from saur (saur.se.axis.com [10.92.3.10])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 2623EE18B
	for <bitbake-devel@lists.openembedded.org>; Tue, 21 Nov 2023 02:35:32 +0100 (CET)
Received: from saur.se.axis.com (localhost [127.0.0.1])
	by saur (8.17.1/8.15.2) with ESMTPS id 3AL1ZWQn1059864
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 21 Nov 2023 02:35:32 +0100
Received: (from pkj@localhost)
	by saur.se.axis.com (8.17.1/8.17.1/Submit) id 3AL1ZVjK1059863
	for bitbake-devel@lists.openembedded.org; Tue, 21 Nov 2023 02:35:31 +0100
From: Peter Kjellerstedt <pkj@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH] command: Make parseRecipeFile() handle virtual recipes correctly
Date: Tue, 21 Nov 2023 02:35:29 +0100
Message-ID: <20231121013529.1059847-1-pkj@axis.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001B6:EE_|DB9PR02MB9875:EE_
X-MS-Office365-Filtering-Correlation-Id: fbcf66cb-a76a-46a7-bab3-08dbea322700
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	J13DSw70qPXikc2QwfMoQd8NxDocfDSfpJz6b7blmDnqqgsVFbDKvUcyV+pjATRgz3ZmWjWftMc33reLCwbaDL1TBj0pMxWu2VJdy52YK1Mi1GpMymr+6m7IDVpAc96gel6FtAXapcAwwSgPphmzETgk5RWQfJGWWnrdkIZYwe2O+VHQj9xEaQDqy0jzSdTYdDHK1RxE4BPVrn1VTqSM/c+Z90dxbYQeSwwTK5feEjg1C5EFPa7vAtnycWk2Sku4Yo2gwAeJ38mpBCtjBISjvj3k1nl5CIWtdUMpeFelAknMcbIkwQ4k0pAfoq02ZP2hx0rE+RA8IxzTQ4pDd+KOfrFf9nmYq+kjW5bpLJkKx4qPW+Giqwx+WsRC0ffoY9WWo8zLwkncbZQoaxkepXM3Hr5Nh7ATp5KHM3BMYj4jDG5RFKqNZDPlV6PG6c4nfo/dR0wnEwNBmuK9uJVhNTPxU6SSzWlAiwLcq4YYsKHdoqXbhRhIPY529mq/PXAxQ3XQsHXVJFGk0fkK6wd7w+9qMSytEUGppmYFL9WTwnBx+c5kJptGfRg6VqsYi2twj130RyC45rMH+Y6M8njzoYYKHBRywVyQvm7Fyq4PqOM5vEBtlrd9EV7fjh/WHa+e21cWG+KXp/tWoigC7YP+DqBTsKPgwdpIvGDJ04JYlutVLmpYSk3M4RIpNqYVc9sDQnX7YJci3SbCW6Qs4RIpq1OPOSDywoNYS6HIoglkb9GLpxL2EBKnreqTDOufRAvz2MBaBp1zqpflCm8hEKss9eQIVA==
X-Forefront-Antispam-Report: 
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(376002)(39860400002)(346002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(82310400011)(40470700004)(36840700001)(46966006)(36860700001)(40480700001)(478600001)(316002)(8676002)(6916009)(82740400003)(8936002)(336012)(2616005)(70586007)(70206006)(426003)(42186006)(81166007)(356005)(83380400001)(47076005)(1076003)(2906002)(5660300002)(40460700003)(26005)(41300700001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 01:35:32.6212
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbcf66cb-a76a-46a7-bab3-08dbea322700
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AMS0EPF000001B6.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB9875
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 21 Nov 2023 01:35:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15542

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

