Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E05C433EF
	for <webhook@archiver.kernel.org>; Thu, 25 Nov 2021 13:00:25 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.64])
 by mx.groups.io with SMTP id smtpd.web09.11568.1637845224322893921
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 25 Nov 2021 05:00:25 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify"
 header.i=@weidmueller.onmicrosoft.com
 header.s=selector1-weidmueller-onmicrosoft-com header.b=GBhptpAe;
 spf=pass (domain: weidmueller.com, ip: 40.107.6.64,
 mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hpkT4GqIjzj/fAL7c9xCvh7MoW0SYYt6RGFY/V1QbXbLOBbFXeJxqFCS36n9S5sEl8CET454Ot46J/1xjVou7Zgj7aKVQjOzgF64LuzXtskZwwpvPbT7cB2ZA9QLU3gKLv22/NduCGlvxK557yYYjPxIIEsW9enDyUXdU/GGPXpC306iA3eQigrLAeQ52IACghoqcV9xP9T/4rbIAZ2+3MK2hlqN37T/x30p5xry6d99+Z+vQiyeqJAPD6WiMv3rUPHSKEYS92U/86g9oyopqPn9xMiLu3+plhsEQhpHNOF0KGuZkz427qol+zdmX3br8J/NJoI+uXvGVTVtB1hEfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HaoQUHb+XkUdmljcy+QQ6oMKNGzvaXhfM5iR1hcZ/MI=;
 b=DST58K6y0mtpOB/YYqk1IPLJhbhVEa9/R5HV/iqnDzLVtzYu5SsrlbASypVvUkbYWlL/Eoui5/zPREi/EWGQHSNWtumZRGlL0rmSFLytjJL5Rq7P5L2ajx9+o2IuQAl5zjSO09L/mwoYegb91HJBG+Qmz+ggvkJdAEjrwYsynTTI0xHIPXB6tHvdJbzUiCBJf0Fybmpgg2OEjK3l0+T1i9aWVBi0mukkZcM9r9rDavBp/40o+D/H28kIrMs0q+3HDnr0BkUDhJtSfh/JATG49dPiikZa5iJS+vWqCWvO/5+RqRx4Tb0cuLXiOPzMXbP3avT7KW6WpgS7FLYg9Nu8+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HaoQUHb+XkUdmljcy+QQ6oMKNGzvaXhfM5iR1hcZ/MI=;
 b=GBhptpAe6ENTQTfbMNB6FrxL54FO8FlYWJj+cwrZ3Tzx6jXXmII4/qvkds6IP0zDBjv/6VVs6tHgch5NrdzKzEA2MMdVUcDKPJ5BFmbasGilONBkeYwtd0pzp1U1XrqEkrxuroyo3Vu7jvaMfr+J/q5inA231F/FD2D2MYX2Xbk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com (2603:10a6:102:1d8::23)
 by PAXPR08MB7020.eurprd08.prod.outlook.com (2603:10a6:102:203::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Thu, 25 Nov
 2021 13:00:16 +0000
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::f:41c4:eb10:5010]) by PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::f:41c4:eb10:5010%7]) with mapi id 15.20.4713.026; Thu, 25 Nov 2021
 13:00:16 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org,
	Alexander Kanavin <alex.kanavin@gmail.com>,
	Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>,
	Martin Koppehel <martin@mko.dev>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH 3/4] bitbake-user-manual: Add striplevel unpack parameter
Date: Thu, 25 Nov 2021 13:59:53 +0100
Message-ID: 
 <20211125125954.15890-3-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: 
 <20211125125954.15890-1-stefan.herbrechtsmeier-oss@weidmueller.com>
References: 
 <20211125125954.15890-1-stefan.herbrechtsmeier-oss@weidmueller.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AS8PR04CA0172.eurprd04.prod.outlook.com
 (2603:10a6:20b:331::27) To PAXPR08MB6969.eurprd08.prod.outlook.com
 (2603:10a6:102:1d8::23)
MIME-Version: 1.0
Received: from DE10512.weidmueller.com (94.134.181.29) by
 AS8PR04CA0172.eurprd04.prod.outlook.com (2603:10a6:20b:331::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend
 Transport; Thu, 25 Nov 2021 13:00:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca1787c5-cf6b-4f02-29ba-08d9b013864c
X-MS-TrafficTypeDiagnostic: PAXPR08MB7020:
X-Microsoft-Antispam-PRVS: 
	<PAXPR08MB70203F1413575F1A5A0A3D93D7629@PAXPR08MB7020.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	aZJxe7IXi/lAbWuW+Q8eR2nXW6ZvD/y4id8sN9gMxFgt1enlH4Qfjh7NMUMi3hq4UMNNAKwxFGeR9Go7EqxlBqO0ZxwUnn5tryLXO57eqBVrxlqVBqUOY4PhXcGWz/UsXnXCQ1pQpyjtnVLlQpGa+xP7iwPE548WPM0RHePvk6MIFMQ9zGgLOXWEYdWN9o9aiQmeOYB3zzeFgTyxlPln7l/8M693MHGCr00Ds+QqcuwVVtrTLwv2BCKAiuVN14rBPmqErXQ3IA+RUMW9nNvdq7kf8IaL5deC9d99MPbFhvLrmf/GiFLJTpDtf3MNWviZGetWfSkyUc6h8SWhCDCuJqlQ0+czX3pyMitjkXlEPSPhybR367B8H6RLMMfqSKNAr2E+FTk/M2PqLLjUF63xbWL85zFIv9Y0tjngsu9LHpu55uKRmdCNLocCVBHpy30hukJRUFRVeTleaAj3VnqAZtuzMlaWKZTFFGFWj+aTCR62lGvSQAXzZJUgS5DunDNMVU27KZGqB2vb8Jm7Cv2TOzpS+vt97Enrn9LYriGEc3sji+gFZgYAkxZk0lCCpjYFWSOvX4QoHqI8lIA90UIEBJImYzu4X8Nvp727wc0Oo/8QCHQKXEULSQ+2aeX3tyZKf3I1NTbDAohbHlv6JZ7al6YCCkhPm1KUw9vWo6d2EMNZMItZvRB673loJ9qLCcAc0zItVTZXx8JocBMXrGXgcA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6969.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(38350700002)(66556008)(2906002)(1076003)(8936002)(38100700002)(107886003)(66946007)(110136005)(7696005)(5660300002)(4326008)(36756003)(6666004)(8676002)(52116002)(26005)(508600001)(2616005)(316002)(186003)(86362001)(956004)(4744005)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?oS1Bmrwdh2BT25uq8QblKvVXrKLCzKJTsJc2yYvbEdUPkqPE7uKNo+R0i9NE?=
 =?us-ascii?Q?3gbflNDOzXM1wUPNls0dAu2Z0yg6ICpxloKcH6PMKuvXTWbCGf9b+xzcc3YL?=
 =?us-ascii?Q?4INPc3jwi1Gn5dkY7uKij8jihJxqq00g038HZtHtPt3xg6xGKKDjmYAIlvC3?=
 =?us-ascii?Q?7/id0j6gMrlVKLIwON9vqaCrd+uImvFwZmdDYYiMJygCX1D0ac+4CeB5cYem?=
 =?us-ascii?Q?EewaDYCisk1rbcxmWdRUBpHIi1PyfVajeIYDjVw3WR2DZv75KnGGEJeBBBZI?=
 =?us-ascii?Q?BjG+8dAWrL8aEfLXTc84T5NV1kaN4zyzp43DbDHh6MXFaSURHA7letsejG5/?=
 =?us-ascii?Q?gMhmTz/DYfcdMAnEcuFJKyqtRb7KIakNvoc7Vcf7r03pamRtoBUy2t5EXcbo?=
 =?us-ascii?Q?eD1c5SUxpMloJLbYehOhhXdSs5zQRlEHWWlykHBIhgzOoyXklRUxQTN7Qwcv?=
 =?us-ascii?Q?ojCGIRV+4dhTZScrGEbJMXkYsos/R1cC+2Om2LJoNu23qqiMT8lAPcgcF6hd?=
 =?us-ascii?Q?WMbyi0V3P3o3WwQ8Hy7XWzn/j9b7mwBou7wJFx4CZPuwJVPM0X1WUrgCFviS?=
 =?us-ascii?Q?mKRHnytVkP2Fqv/xGu+jDDeVJo2Cbvb91XtqZdPMmxvQ1ysGRpjRAzbgzCh2?=
 =?us-ascii?Q?VbkVtasCCYjIoOd8btzPSeCvinLNQZvqQqYVcVHDm0rTBGN/AvxZ+pfA3zTD?=
 =?us-ascii?Q?heZE4stQY35L+KsC9ISjyZxQtE7lgHaeetXH9walBHoRpyjSeQ42g5rfIEFM?=
 =?us-ascii?Q?bCA2cbL/Jc76sZZi6bImjz7MsFyg6jVVSP/lOoYKCIVt1HSuCOGfQPEP2fjq?=
 =?us-ascii?Q?NgeNKv8ZuhW8MJqiPc0IgtaKTGBOqnDrH6pO0ZFu0CMQX5SMgUL9byPfOtT4?=
 =?us-ascii?Q?o+2cDSEO4Sh+UCjZl9fMrHBz0RXLmbrBjucAJa+z7jfb61IWNkcsoeuSixl3?=
 =?us-ascii?Q?BFkHAIvxSi3w3SnF/CS3Cg7RdZTqbpHvkH++wdMoHhXnxOpL6XZu0oMfZDsD?=
 =?us-ascii?Q?jwc2o7EWuIjiIc9MOGaWb78FRo3aRbURnGC92CovKCvpTXPYRknJSvriZ27l?=
 =?us-ascii?Q?rEyTqrP2csjJkORfL0cdIvB9B5LzOn6xgY1WtPAFuMrbdzicWj+fwk+HO92D?=
 =?us-ascii?Q?LaoT292ES3EykwJzmOHxrSNfJo+HO4RC6nl5RLR/CBMhoLEtGFyX61HkM9ll?=
 =?us-ascii?Q?olO3MWGdiwUVQyB0ID9D5+aMQI2x84m+wccbL6zbazluUnnqGxUGA+q78GU2?=
 =?us-ascii?Q?VOmWpVGVr8y+rcRROtUVmM4OGc8lxNu+cjfDHD/ptyeJgLAgQuA19f2r65QJ?=
 =?us-ascii?Q?TYNJzeLUAEQWN6Xv4ckmKfLi9GQTXJfKspl4VMo4Q98fWUVQiIiioXyIdFMi?=
 =?us-ascii?Q?Pk3wynLWH1ly/PVLyMbpYzT22CqTeoew3vv61ku30v1LKFdvFLipLCoU5h89?=
 =?us-ascii?Q?aOZNBCIVHYsrNLbsBzj/aIJWDyGJ7IWFP9k2HyANkVnOmn8XQrv5OayzY8si?=
 =?us-ascii?Q?ZnHzOhUsiJtykW5mLi5FT9zJ5LLsYynTHVSsa7HHjnu58/06bSsQo5xJPhDb?=
 =?us-ascii?Q?iLawQpTPlmf8sLvTPzofVSqBRbA8m6om4w13u4iFmpgAREld0YOooZPAB0Q8?=
 =?us-ascii?Q?jRWgujpJfjd5jXKSUTaE2uQ=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 ca1787c5-cf6b-4f02-29ba-08d9b013864c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6969.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2021 13:00:15.9515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 DqGLSnETB/7TAeEswamev0EAy/E3u1BY0YiHT6iM672NDitNeX7nG3ATibS8foIbdMIClmH708puSSxyy3OhbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB7020
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 25 Nov 2021 13:00:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13110

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

 doc/bitbake-user-manual/bitbake-user-manual-fetching.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/doc=
/bitbake-user-manual/bitbake-user-manual-fetching.rst
index c882dfa7..51ab233a 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
@@ -167,6 +167,9 @@ govern the behavior of the unpack stage:
 -  *dos:* Applies to ``.zip`` and ``.jar`` files and specifies whether
    to use DOS line ending conversion on text files.
=20
+-  *striplevel:* Strip specified number of leading components (levels)
+   from file names on extraction
+
 -  *subdir:* Unpacks the specific URL to the specified subdirectory
    within the root directory.
=20
--=20
2.20.1


