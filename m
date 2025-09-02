Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A55ECA1014
	for <webhook@archiver.kernel.org>; Tue,  2 Sep 2025 06:45:56 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.127])
 by mx.groups.io with SMTP id smtpd.web10.71239.1756795548727092388
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 01 Sep 2025 23:45:49 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=1dYdnmT1;
 spf=pass (domain: weidmueller.com, ip: 52.101.70.127, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OL/jtss/YukhURwGTXn6mPTve7gKVqsGimUCeEb9nDzftWCCyCc74Qodax4xtmk5VzG5qZGYgU4azTiqS9n4CSQVIA4UAsn/z+QFXmJgvOB53ksQxs5qv7SH7ubq8flvIOtTNXyjIlfyj5FwyaXX+WAZ1PRNcME9G8pZQbF0r4hkNzpcu+LnGD7WIsB8fFwBeybwGFyUJbOfr4Fa2dwNgWuQ6RFEQ6R5nZW2lkDSnTHDKUTCgkeSsMIQlPhi1rv9Vvln30Z7pU5p82od2Is0NUP1VTBHBEjH4xprgWps2mRd+NCewKPJ/mHcjigzz2MFmRsYIk6Zioh+l3f1B0VFEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0C0ncIM97PI5xi2pakYWr9/GC83C6tNLzuAS9YBEdKs=;
 b=bQzr2mkfcPgEPTZn8vC+/qFW+GUf957E5KFHeW/jhlXu9TDUdQbdii9vtLEJVpaJSIl+tTAHU5gosbENvvMWp2Bl0r1eq7Gg09+2GxWdVHqDVI1ZMR7u3NYSPq90Njfy6+XRwfmFFdArOi9jrXqM9RlKknzU+GcFZK+WyM2CymWGhioBfEl6/Z7jKSwy2/orF2gmtX3hXPLoogJ2imzYYu68zpUc5ty+CU2ASBfXgWzGJNH6cV4nUrLFTY6ge8v7j/o/ua2VFw5l0nhSulJ4PYjcVVTYFJ4BCT/m+nOQuFnoaY4INCuwuKAv9ga3oubptoIvEHxeIgTHEnPY4MGwdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0C0ncIM97PI5xi2pakYWr9/GC83C6tNLzuAS9YBEdKs=;
 b=1dYdnmT1UnT319ZBHGn8O3phSuCgKSLSIO5ondhH+lwFNRGjsN0muRzw8xwhPWY+/U4r2dtvqO3y96h7RWSz7YMa9/JeZONaLXEKZUtJ7CB0tXnzn62zAsDLOX8CIgCTX7ErFaj95kuQY5NPkStDZRHQzlb8AR3BxojudNEqtlPoXGbnuQoONXuwuuf6f3TDa64EZ0pkloUpiVNLZTlOxCIafN9rtghe4HNTCWvOwt0k79Ms+Tw6qzAXLifLy/bAZySI9BDKJNF/jttdek8s6fq5N+Bc4ZxNsp0EuBtjCbqXhF5YthZ9PsWgGE4P+0WirgvhDR5qHLinvGYArU+l3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com (2603:10a6:150:8a::17)
 by DBAPR08MB5591.eurprd08.prod.outlook.com (2603:10a6:10:1ae::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 06:45:46 +0000
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013]) by GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013%4]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 06:45:45 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH 12/15] fetch2: gitsm: remove redundant check
Date: Tue,  2 Sep 2025 08:45:11 +0200
Message-ID: <20250902064515.30879-13-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250902064515.30879-1-stefan.herbrechtsmeier-oss@weidmueller.com>
References: <20250902064515.30879-1-stefan.herbrechtsmeier-oss@weidmueller.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0263.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::10) To GV1PR08MB8426.eurprd08.prod.outlook.com
 (2603:10a6:150:8a::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR08MB8426:EE_|DBAPR08MB5591:EE_
X-MS-Office365-Filtering-Correlation-Id: a6c65d79-cbf3-437e-a738-08dde9ec55a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?EXsDiFMguONBLl3g5h3i3UlojhnZIV6CR36A+u45BVaz5E5Xv5zxWRaDLm5+?=
 =?us-ascii?Q?/6iUirsCq09w0EI0JwgDUmxMNEU3wblgHAlG09fykpUmtcKW2wUk1pLminWW?=
 =?us-ascii?Q?OK3M/S1go7+CZOr7qTrPZTl/spPZcKQ3sJ/xUCt8Jrk3rNz0esSaoS5UfyNQ?=
 =?us-ascii?Q?29ix2W2nKdTV5mSpUstW1XHC+L3kTgReNM9ZiPdrgIEl9h3fzWOk1bKI35o3?=
 =?us-ascii?Q?ejhOWI5LX5DnBGCVA8paZMbeyHeJIrDR89ZUm8tVH4ik25Haglr4h9xVvYDH?=
 =?us-ascii?Q?kk5bKcdaVjSALhMeK0VrJ01SMg0LpMyV0WT680rb1gew3wNDtbMijG2AVDpa?=
 =?us-ascii?Q?u+PaS7um7Ci4NQ2TMu23J7o/O24Bgps7DFKmXrlz1kaxGPYmDp8E3+EzWWw0?=
 =?us-ascii?Q?VvNLNfrUT+Vqi6Msb6i3IlmWz5K88/dUuRlEPDgbAY8V6AyXb1PiBBrHlHa2?=
 =?us-ascii?Q?uJxw/yOnoLZ68UtTNLGTPra8VXQh6hCZPD0WM/1FH0043v6q4HatJOplLlIa?=
 =?us-ascii?Q?eZ5OBpnOQ2QuJNEzHpMc4/2MT7G45kPr94NOjXJPglUdADsIJ3EsrcYSKply?=
 =?us-ascii?Q?RBIzW9E4qMZLRtu5ASskTTe5qdca6bhot6nTRD1uULGvS3weUvBy50Jy4TqU?=
 =?us-ascii?Q?tz4ghvX1rSrPUjI8ZafAwf6QBQYMc+m5E5IQYJlP+x0KlSl8SNyB+W91UiFo?=
 =?us-ascii?Q?+Bs0HBZ/fX0krh4Ru9vvmwqdAXohUdsyGOfy8BpbsgNpYOSJWRdaa4y5klMY?=
 =?us-ascii?Q?30xPkX+fGAiT/4NdOIo0yjQP11bcblNE34YaEwuRmFz+i7BDQ/t07D47L9Oo?=
 =?us-ascii?Q?YclblCEGJWg1J7XVQxW1BxrxAqS2MPfQnejKARRt22LXuvd5DhDuu3yiylTt?=
 =?us-ascii?Q?OgNCdnGBZ+ZbmWR2tRKW79BF4EiA/ozYv3D7zSiRhNE9PsTHl66WeOwEvp8I?=
 =?us-ascii?Q?6q0CIVHZU+fUgMSOWyzHBl86dY4stKrrM0tbAJqK5QZ+V2ncCk94SZVKVmey?=
 =?us-ascii?Q?OxzdhC1HpMTfipYvrgUpiiYWAI+UZtBg5X0T7vzsyb0m2UcuzsLapr3okgpK?=
 =?us-ascii?Q?22E7hsvuoyMMJI2I29hpjCjRZHtftUa8Mqrnz5JekMUuSy4mAqvHlZ7Pqwez?=
 =?us-ascii?Q?2muWk/lotMcggmFFrbKa7FhgiHESVT2M4yXgZXk7vOT40lYLoHm8X888uZjo?=
 =?us-ascii?Q?mD7ctpdAXCcaNXPodepQW+ZuM0O05Iwomj692owgvU4daFqr3W6qlmYx/gmR?=
 =?us-ascii?Q?RXL9jKE6Ar+rliZry8eAmm0f8m8c28Gd42o8OKUgZFhrFg9/Nuvk0L54YVCU?=
 =?us-ascii?Q?OQsIVpgI+jDKT7Y6FJepT2tYJHfXOL9BFFGJLnicpdfbrzN1cHY2SF0bPz7X?=
 =?us-ascii?Q?EcNeMxIBEHgO68hBDub6vuPXOB7OItsebYtkW8yFppmn8DROJ4tZnmuNJ3Dn?=
 =?us-ascii?Q?/UVB7JS6Yi2ddSyHTPG0gdvDxs72keozyAAVXzRcCRmBCT8kY1QmQA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?LVTOJMa4C0KshM2G51SlJaGwlhvEfHi61NAmzOjSrmkod5WPMHoBjcARHWJv?=
 =?us-ascii?Q?Qg7L26bLHn7km+Sez2xr+x5tYW4TDjyNGnifEZDBN4DyWsHjz4E+x1qmjocL?=
 =?us-ascii?Q?YSKL6tgp72NLzrTLPbCHd/hpTXz0YvdlilW2AI3leZcWuFnJib0qI0qPNaUN?=
 =?us-ascii?Q?QxSrARU5pcLBPM/iZ6UXg3u7c7elbrGb/CMJW0HUWfRzh0PGD/GSV2qqaCYC?=
 =?us-ascii?Q?n83kvUGuZy6/7r61HNOrSgdeNCzIlE4vtF3syfj4XZVjxn1/8Z0ga34rQyjg?=
 =?us-ascii?Q?KiBYo8gZFlk1i3STuvEhXmiw5nFLkhfLIshFXwdzt/+kPFyX4gk0xv9jn6My?=
 =?us-ascii?Q?vE/5l7KYGw8RkF2lZtxxJ4GCm3EGXd7oMgEsuAivRj/k0deG+AjIlyn+xVmd?=
 =?us-ascii?Q?ULtbZE0mtqll6S6/WfNuIJpm0i8AEg2AiicISXSpXj1z/Eog4GSnIcBcM1MJ?=
 =?us-ascii?Q?xODqKv4y3+cN3e9bw+DEr/o1e5sPehm/uYM3IrfZP69WtVQmuW+1TssxPniy?=
 =?us-ascii?Q?NMnao7kHXoGUAxNAn5ZN8MosxIaBga6RoZmbrqzHvAFUMlG6UwoZotoGhenL?=
 =?us-ascii?Q?bCMmDHekzDv/lF8s6RNpx5jY3ogfs9i5G8/wyPQu9hinWpAdBPRS0ST+8vwZ?=
 =?us-ascii?Q?4Ghc7k65ap9Vz2FK0rgK/hs0yl27XETcoCqxXiZK1BNNe1WYZFrVlTR8uMZk?=
 =?us-ascii?Q?DzxezUUjPdayV+ouMgZGCe3WQn2Fl4tXGqqao4B2caVMFsZ3fFZJ840tz800?=
 =?us-ascii?Q?prAMDplpJoUwxfNF2E9K1AcJiH4FohFb/BSKBcKqDoekeBmA0TzJ+FiS292j?=
 =?us-ascii?Q?na/GIxnOPY1BvvT8oCH7CpTKCrnQVjshV+jVDe8j9phDMsEBwITTrPIZRFoN?=
 =?us-ascii?Q?PIgtxU32o8UJnnqdGOcJifbTRmlR/r2kAe/wJtdo1cjg6ty9QypqpGvi5EtB?=
 =?us-ascii?Q?5cwA+BNcrQodCE1YLjSbo+NZLYn9/QD63/hF+Ha+OsduDtvd7Z7HVCETsLqA?=
 =?us-ascii?Q?wfXGtaWYk8NWSpk5MpSdVXZZWpKDNL1zY2EoG1O3/PZodiRgmqAljQ199QpF?=
 =?us-ascii?Q?jOlkweMYvQOOiQjVnQYgIORuhL57NmyYqHLj3SpWvc3QyU6TdJhXAt270bvP?=
 =?us-ascii?Q?uCY8nEcuaxHrwtENjglzCKKeVORCtA8+iBhVwJBgBD4LrT5urr/xUvJRenKq?=
 =?us-ascii?Q?42ghYkoFCYsaNprZbnuXt21P0l33uykbFEMtMC82nQwhPKuGf1cKmvtjT/VG?=
 =?us-ascii?Q?u17CUf8ouZdR0Kf+WycWM6d786sHAYtSPL1b92NuhoMFq8KdBFIEYs0vF1Dj?=
 =?us-ascii?Q?pHTchsuU/9pB/wmn4+HSw1BUuX3+AmL7unFmSP/petC8tEfesDH8t4dCVkLr?=
 =?us-ascii?Q?uxlyrf5Q8mLCaY+AVQUdCx+9WsUHswPPe9lBDMutuI2KX6RC/G83dV3HRlCY?=
 =?us-ascii?Q?aJlH8rv8TJuJOtL5l6FMff7ANzpuHvm9Y8zNI0Hbv3VFcZi1ajXr2ygDRvAT?=
 =?us-ascii?Q?UjlnX8zgZFiZdTl7zHLgH69whoQss0TMfzsPli8IJ5FHuIN6urh0vEvaTnNp?=
 =?us-ascii?Q?edpX69l7TXH2+JBz2BLXX3B+PZ+AKoVLCTsVXcJlX4eKg8lnT/ReapRa3bl4?=
 =?us-ascii?Q?/A=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6c65d79-cbf3-437e-a738-08dde9ec55a6
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB8426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 06:45:41.7337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1mKQvHcibROANS1vMt6LeKDFXHcLKdCOcTI3jNW33Z4pW9Q5ebAYG+evhFUs8oeM7hYODh1NNQtteOvp/DA2ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5591
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 02 Sep 2025 06:45:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17931

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

 lib/bb/fetch2/gitsm.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index 37f82cd37..9afdc8370 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -174,7 +174,7 @@ class GitSM(Git):
                 logger.error('gitsm: submodule update check failed: %s %s'=
 % (type(e).__name__, str(e)))
                 need_update_result =3D True
=20
-        self.call_process_submodules(ud, d, not os.path.exists(ud.clonedir=
), need_update_submodule)
+        self.call_process_submodules(ud, d, True, need_update_submodule)
=20
         if need_update_list:
             logger.debug('gitsm: Submodules requiring update: %s' % (' '.j=
oin(need_update_list)))
--=20
2.39.5


