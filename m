Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 186D8C0219D
	for <webhook@archiver.kernel.org>; Wed,  5 Feb 2025 07:16:06 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.110])
 by mx.groups.io with SMTP id smtpd.web11.6855.1738739758488645702
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 04 Feb 2025 23:16:01 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=2H2MXV9B;
 spf=pass (domain: weidmueller.com, ip: 40.107.20.110, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WFCafhkIAE1++5QCHcgf0eyolESd/nL0iBGOEI3ddw5uRkI3Otz9wY+GOsXYa07Yx4aKUgRKtbxaLwMcviamPGJ67uYSy0d3SdaGiCaJQs1RyAQKuy835jskTnJu9ZalDoy72P38VUM3aEHw7N6KNlbk6KrJHb6tMhb+e7Sk4LSONYJf/iCtsMEqpeVXBjmdQP3wVS9LTPE6F0o65jhO9KyupvlkwaMgWkwlBlv1sW+SWWytFEI82Ea7t7PCJ5P9m+Ypry35ZGZ0gJQ8ZQaaDd62UafuEx051jJUX5eovbdVMxX+vOHHjiKqhLtJFyaNTlej4HrkB2TIXJOnHLxKyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=912l7Q5D1EcysHSd0POI4SV+7ga8EjJRHn8ktNW/sRU=;
 b=MFaUWCjtU26KQ5o5JgNuCO+MXKAmer4ws5TkS2i7rn8GbLkQySMd/l2wsOyzza5DiTM6icImcJ174fo8pd9/BsaDv0UeCaOxe9c4PeL1pTkg2vuGXIIRLlfSZ2oOQ7YL2QPBCrpF+AIFP5+QXHPnoFPKF47lWQDRP17g6Q7U4YgDkmGHmw2WZDkDFnhy8XH8OluE3wzQUOf0TYuGtjxhZw28pVqQUfjqWcFoybNnvUftJMCdIgf9bighRKsjT0dwiOgWM+yx7DKSe2VuK814ACAVNpyyIIRvnhTUIZ8F9Hkvl5JQGG/UmI79Aqp7zwtARPjtDUCY8s/grjMm+JIJzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=912l7Q5D1EcysHSd0POI4SV+7ga8EjJRHn8ktNW/sRU=;
 b=2H2MXV9BnZN4/alU45vqy26mI+BJLHaIDdybUFc7MDfdSZ13KnRe/VQCXkIUgsbUTC8t3WK5IjW69cwH/UBHww4xC32aJkqudJAagjhvlgGpwpxM8Xq5mzXow5WlUf9wgYfllsymle1UgfJkjdZLiMT1La1hOPmAs3YRcauQoMUAywhcDqqRESOgyuacdq6T/r1RiHnBvAgKppUVt8NC1wNldMLM20lCX8D64mM5YF02vOdrGm6qAqOVji+FY2dGeaJfpbyBb5VxzGBlDEfYOvsTUnG6SgzSpxxg2b5vAfsvcPlLT8g/MEQPUzhg9kM27yuCc0XmIDJlr5UNIQv5bA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com (2603:10a6:150:8a::17)
 by PAXPR08MB7320.eurprd08.prod.outlook.com (2603:10a6:102:223::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Wed, 5 Feb
 2025 07:15:55 +0000
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013]) by GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013%7]) with mapi id 15.20.8422.011; Wed, 5 Feb 2025
 07:15:55 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [RFC PATCH 12/15] tests: fetch: reenable replaceuris in MirrorUriTest
Date: Wed,  5 Feb 2025 08:15:35 +0100
Message-ID: <20250205071538.2681-12-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250205071538.2681-1-stefan.herbrechtsmeier-oss@weidmueller.com>
References: <20250205071538.2681-1-stefan.herbrechtsmeier-oss@weidmueller.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0178.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::6) To GV1PR08MB8426.eurprd08.prod.outlook.com
 (2603:10a6:150:8a::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR08MB8426:EE_|PAXPR08MB7320:EE_
X-MS-Office365-Filtering-Correlation-Id: 89050bbc-4cf0-40d2-8382-08dd45b4ee1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|13003099007|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?g4vcxf91KVl6xpwwCCqfH5xGcUIRZrySyHg3orI9R37loZ5XdI9x1iw7HqV0?=
 =?us-ascii?Q?87zUqDD/EKNFK7NbRseqO3I0NBxGRRRvgsiyZxAF+8mtTwYDZcQd2MESXNtf?=
 =?us-ascii?Q?WMBUb/TvnRlBIdP1ne8k1hwfnadW1YjXg7iHpN1BHVFtrshJ4L8w4Htyvc9N?=
 =?us-ascii?Q?mgtJfYHpJe20ZNy4tWY7+6vn6W8Lep3TI2//Kvez1EbCy0cwiJDALUjp5ZSd?=
 =?us-ascii?Q?LM9n2N4jnvJSMhS1zjmJcyJTH++E1TbXwArppmtAc/B90QB3GRNi1FsddpOC?=
 =?us-ascii?Q?kwnBAp97lyJHwW5MG5y2WBkOno9CumO2xaG7nJTHFIbp4BHyaEhHVy3me921?=
 =?us-ascii?Q?fB5kcVsVH5zoMJbkuGQEKJiFVtgF0rXLjPo85CAw7k/RVU+X2wrMWj/aeuID?=
 =?us-ascii?Q?5/CrSABk/CyRm59TD+ggKIfkmMuiiGDbuNiSkWIstBbZjSWkoOuiPRmLepFF?=
 =?us-ascii?Q?vXSwXM/tJWrNdAPIwq8GXZxYKZ/+qcP0NG2ABo3M7gZyRpum6gNjwBxz9T9q?=
 =?us-ascii?Q?6p/Js5JMFdUV/6Vb2vVBOpZQ964bbdR7nfBea0RFwsokw5kcVvlkPHrZ753s?=
 =?us-ascii?Q?oWPV3II+N33/Ei1Y3Wij6nEyEYBnh2DCRQwcPSa+IPDsDX0XMXyMEOvn+IJe?=
 =?us-ascii?Q?zCcpofIITMNdNp8d9aZvwkdEil4w1ChdrHqm9AV7U6Bylw1Dkps2ERwkepco?=
 =?us-ascii?Q?8PuIPY1vjCNO0hf5zBUs+4gYNZx2wka0iEnaI7fbRsXyk6Nus/N7N59uQUtQ?=
 =?us-ascii?Q?xtkxdlNpk6XTVcyOhHi5WQPmgIhy8eQePpaN0mco4lFbuJzShJ4F/9aik6cN?=
 =?us-ascii?Q?K7v8kYs4kaZ8z5oA8tS9fy928djOQaeDIQB4/IvyCMcVb7oE0iX1pExGN0wn?=
 =?us-ascii?Q?L2GYkvAy1aXpQCZCCNYGrCs7zDHFOqf/C2sqksEzaW0up2O3luimA+Z+2QoB?=
 =?us-ascii?Q?YrnaKdySKH5WZhxt5h43zspAWOEIF/W/d/eJIvO/0DmNEFki4Lb+WDZyK+qo?=
 =?us-ascii?Q?PZSrCuiSegHcDYbjSuR5IAILS7Csn7NMPdE9H4jBYCL0K1gba8wNAMOECTy9?=
 =?us-ascii?Q?FB/FOtnRu9Hm/k+wJPDrsAAck87rFedljAMxSAT5ITCPySI9EDdfCjKNYlvG?=
 =?us-ascii?Q?0Ss4wEomU4YzU5yzcOYJHVsMP5dBfPDfhJCw8Ufy8eszJebaCL62tPKngKLe?=
 =?us-ascii?Q?HtTh1/dWGqe04Dl8GSekIjOQi7RBZ56N74Lt/jOuyALxY+Ttgl+1QF9xzkSo?=
 =?us-ascii?Q?J+yFLNVwOHNtIVojZrXqu1DM0nduRn/+t2bdvbWAWZtPG3kXn2QQP83HVI7X?=
 =?us-ascii?Q?I7as7cfjxl2NbI9TOH9skAQxByziQwDz492Xwck5s3dsL0LmP1r3hj46eVh/?=
 =?us-ascii?Q?eIxzgy2Ng1CtBNn0vt7hQ2dgCKtK?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(13003099007)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ZzmVBB7R82Vt4l7uRvIPnrfA7uD/48KWtM8ezXIjZdi58t3PPRGxKKj7fJmK?=
 =?us-ascii?Q?MrQk3DvOFHy+KRqQFWFMrRppQemmkF9T8HoS2B2UCE0MWy3eluYih/eSPuyU?=
 =?us-ascii?Q?yErvq6FKyAS/JM/flYIss0+2dvk9RZjYI43UjUPWtL3uSgu/O/xM3Wo7FIfm?=
 =?us-ascii?Q?sXg43iSA3iLIh1rPJXqhJq9h/XYCoyejEcQr+j1TD8fAbikJqzIXWEA0Yrg5?=
 =?us-ascii?Q?GXTkyoaU0NPAMtZUJKDNclkWD+r7QftoCsleYGySv6DUXhME8qX9Rb8/eSYI?=
 =?us-ascii?Q?C5yLQOdWhfkDua55Y/PUbKlQ2HROT03hAnY09qSCYhAAo3cmURzekN+qQQoD?=
 =?us-ascii?Q?xuffuPHtkxeWjid1gp7P/WeRRmSIdyUMXeQ+ncd1rrtoax+7B0P+RoodvScK?=
 =?us-ascii?Q?z+zrrstyu/eAqUMLIrslJ1b8LyRUtn+dzSaz+TGaFTRcG609HJQcEZA6eC57?=
 =?us-ascii?Q?ML4XJDohaTm+p0JLZN9+yGuDqyibw6Gc080SiMNHuEJHlZncw2B38ipt5kJn?=
 =?us-ascii?Q?CsJKS2qOoQQ136CWNmiRrCDfm2grrUdMWucBSgLpBxMbXLHWfNDWrG5trfKp?=
 =?us-ascii?Q?Jg136ngQn0jUkTzWcBTkopUQnmGAG9IsbKwuislfPWoeCWs/kn6Vb1vPFF4i?=
 =?us-ascii?Q?RV5dJctA/wHk3HBJ41Ee2C3dBBkMTpcLXtv6MVQs/1yT30QGCy+M9N8+1Ihu?=
 =?us-ascii?Q?qGQIKg65TGo/6FaAGVz0n5CPwJI+c89XNgyO4VCQODbHyRZ620F9RjqHANn+?=
 =?us-ascii?Q?ieoKqlXjbJVQaJziZho2ojcMlkrWYE7NM7XVr4LVhLnqhrS1ptjD0NISugkH?=
 =?us-ascii?Q?B8tlTLIyRtlAhKoAlTqRXHwY0OY1hDE8iVdaySI6Oj2m0HFY3WTtCrhG6ItW?=
 =?us-ascii?Q?GO68R3LJYHnWFaVy8oVVHl5G3mxaTIjAfJ5wDNQkXFUh2q2rnxOezwcoUUBr?=
 =?us-ascii?Q?3QnkQJp04jiwct00Q9+JMYWI8Kvu752oKRTvN7GKVWzlxXram17dBVJ0By9+?=
 =?us-ascii?Q?Bn+ibQDtbj09AKkbIqGCUytJzGV0k4QgeXaAkP6WNr1rrkdqp5Chgo5rBdIr?=
 =?us-ascii?Q?eZrlvmRmwHEbUm6akz9a9KUkK8CkkmkADhiZm4Ne8Y3ku/5fgU1SjZdKVWvW?=
 =?us-ascii?Q?XlDkK2iX/IA8TkGOENo8KQfjaiIKw87FLrwGhKWigNFVPcKww98wM4dPLjfS?=
 =?us-ascii?Q?yN0Qgq06jnTBWy5sEYMnOJK1JJu9Gtscg0ZxBNFZyhOIwN3w6CT7+wi+Exe5?=
 =?us-ascii?Q?kcAJ8oA/PG/6lJ6RwdnWkGku4lASRpxWzsxVZO5IKgFJFDvI4n3gS0eRiDqw?=
 =?us-ascii?Q?gDQ3s8a7crVcIZVCwo45k2IkeRc7js4jkq1XpOrxH6y0mVVP/KPw6vkJDk1V?=
 =?us-ascii?Q?Axthjx28aIslWiMYN8x4lkD525dD2sPIRk4R7v3YnEg7DssfIaJw2cV13sqG?=
 =?us-ascii?Q?Djszyg14Rb5p71HY/1MQzoiuN6WEFhNFO9VXineqE+EhUoCDgLISymJFbgKM?=
 =?us-ascii?Q?c8eZcoM4oMuoMQwcrueF1ZcNpN9wxDApa4fspyQsi5zZc/2Ynbh9ja+GUnUe?=
 =?us-ascii?Q?Tm5hdO5Qoh875/+tHKTFshnWuYoR69xOd7TNEuCbdijQ0Y5600kXyoVbUMQm?=
 =?us-ascii?Q?pQ=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89050bbc-4cf0-40d2-8382-08dd45b4ee1b
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB8426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 07:15:54.8895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vH0TulUW9k/3WZWySqjgGzYhEy4Fd+G8e/KhV5XBXo6Z+qkf4g9WDCR/qZXTVyTV9VJcee2bG1E7+p288+JFsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB7320
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 05 Feb 2025 07:16:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17147

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

A replacement inside a mirror URI should support the rename of the PATH.

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

 lib/bb/tests/fetch.py | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index ec6d1c039..29920bd9c 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -473,6 +473,8 @@ class MirrorUriTest(FetcherTest):
             : "file:///somewhere/1234/sstate-cache/sstate-xyz.tgz",
         ("file://sstate-xyz.tgz", "file://.*", "file:///somewhere/1234/sst=
ate-cache/")
             : "file:///somewhere/1234/sstate-cache/sstate-xyz.tgz",
+        ("file://somedir/sstate-xyz.tgz", "file://.*/.*", "file:///somewhe=
re/1234/sstate-cache")
+            : "file:///somewhere/1234/sstate-cache/somedir/sstate-xyz.tgz"=
,
         ("http://somewhere.org/somedir1/somedir2/somefile_1.2.3.tar.gz", "=
http://.*/.*", "http://somewhere2.org/somedir3")
             : "http://somewhere2.org/somedir3/somefile_1.2.3.tar.gz",
         ("http://somewhere.org/somedir1/somefile_1.2.3.tar.gz", "http://so=
mewhere.org/somedir1/somefile_1.2.3.tar.gz", "http://somewhere2.org/somedir=
3/somefile_1.2.3.tar.gz")
@@ -491,6 +493,8 @@ class MirrorUriTest(FetcherTest):
             : "http://somewhere2.org/somefile_1.2.3.tar.gz",
         ("http://somewhere.org/somedir1/somedir2/somefile_1.2.3.tar.gz", "=
http://.*/.*", "http://somewhere2.org/")
             : "http://somewhere2.org/somefile_1.2.3.tar.gz",
+        ("http://somewhere.org/somedir1/somefile_1.2.3.tar.gz", "http://so=
mewhere.org/somedir1/somefile_1.2.3.tar.gz", "http://somewhere2.org/somedir=
3/somefile_2.3.4.tar.gz")
+            : "http://somewhere2.org/somedir3/somefile_2.3.4.tar.gz",
         ("git://someserver.org/bitbake;tag=3D12345678901234567890123456789=
01234567890;branch=3Dmaster", "git://someserver.org/bitbake;branch=3Dmaster=
", "git://git.openembedded.org/bitbake;protocol=3Dhttp")
             : "git://git.openembedded.org/bitbake;tag=3D123456789012345678=
9012345678901234567890;branch=3Dmaster;protocol=3Dhttp",
         ("git://user1@someserver.org/bitbake;tag=3D12345678901234567890123=
45678901234567890;branch=3Dmaster", "git://someserver.org/bitbake;branch=3D=
master", "git://user2@git.openembedded.org/bitbake;protocol=3Dhttp")
@@ -503,12 +507,6 @@ class MirrorUriTest(FetcherTest):
             : "file:///mirror/example/1.0.0/example;downloadfilename=3Dsom=
e-example-1.0.0.tgz",
         ("https://somewhere.org/example-1.0.0.tgz;downloadfilename=3Dsome-=
example-1.0.0.tgz", "https://.*/.*", "file:///mirror/")
             : "file:///mirror/some-example-1.0.0.tgz;downloadfilename=3Dso=
me-example-1.0.0.tgz",
-
-        #Renaming files doesn't work
-        #("http://somewhere.org/somedir1/somefile_1.2.3.tar.gz", "http://s=
omewhere.org/somedir1/somefile_1.2.3.tar.gz", "http://somewhere2.org/somedi=
r3/somefile_2.3.4.tar.gz")
-        #    : "http://somewhere2.org/somedir3/somefile_2.3.4.tar.gz"
-        #("file://somedir/sstate-xyz.tgz", "file://.*/.*", "file:///somewh=
ere/1234/sstate-cache")
-        #    : "file:///somewhere/1234/sstate-cache/somedir/sstate-xyz.tgz=
",
     }
=20
     mirrorvar =3D "http://.*/.* file:///somepath/downloads/ " \
--=20
2.39.5


