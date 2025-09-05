Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC3BDCAC58B
	for <webhook@archiver.kernel.org>; Fri,  5 Sep 2025 06:21:24 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.75])
 by mx.groups.io with SMTP id smtpd.web11.14988.1757053273963266587
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 04 Sep 2025 23:21:19 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=iB8z1lqz;
 spf=pass (domain: weidmueller.com, ip: 40.107.159.75, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RZDz83sQnyh6P/8vy4L1YFncg8EXTui78e31TXSCQvM3Fwa3ehU+uJ8XtiA0F+S00sHn2vBsqg0A/kTHOf4IoZzH23hnYtEzaVxpoxYro3qzO5+wKP9LZYwko8JE5/tVsIjVPzY08/eZrpFX5AlsbnGnjVMCX+2loSbbJN3U5Sov9X5RYY0JTyGBPT321z3EX0g3ttZKFVavNXcwYjgY31LMXwrVc3C3oJkBYk4Xipd6pJO9YzUejH7vzjavt337gdXaMPOp91Wfg2BJnh3hR4Wuw5k45pdm4Lh0H8zNiEG6kS8aWHcBPF7YM6ljZ8DZoedakKFqlf5V5boOD5NCgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XYH/jhYeiv4qBR5R4uJ2d1L0GblGN2X0d68YZi8lakU=;
 b=Nj67NJXHlhUFB5FNb4TWiBzBgjVVKw7kabmpQHYlnJ7CeO+sE3iiK795hufxthdBHrX1Kza5wIOvUMoon3xunGU4NxobBCn7YJKc/htf0SOdqzy9xKonG8jBLPR18iIzN3qQmhIY8neIHi8nAKKYGpKoi9nuvFm6ZwbqiAxTMaRgaBaAqMWbrkl+ckn7JoE0EPnHdHV5wYk2l5bH4GrASb8d2nPHsaLviqQW/7w/r1Nb9eSqZscLKjKZo5g812A06Dgx9NLEa0nyQEdcNOR3bZ2JJTZ5u5kX5JFUE7BjCO4WPEsXEfvLV08YDFn8BQHXEi5K67F0w8iTGwTJkl8R2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XYH/jhYeiv4qBR5R4uJ2d1L0GblGN2X0d68YZi8lakU=;
 b=iB8z1lqz1L2fYCNQJpofXEZ9k7pSIzlpl60suYThgTUemJ1ka/OKsr+io6Vi7fxdiHZZmBmUUU37xa21pOG7tdnaQI9/zBKjzGQpZrCR25CGWJPDeyudXTsavUhM/MbMQfRLKSHKU3fa7fIWSl1p0XvCznHGOdYUt3EEETfWMDSXIn9NsLyJIDgEkRhYMEQZwbx3d1wAtZ2s2VPkIbPxwda+hsiX4wbw4XvZrYx0heSBPNbrXQwEPVjHxP9sJ7IoOqLME0WDYGvaQUdpTr3sx3j9GQHbFiBQs9NmQQUrP3TxDBe/xN2XkzrJjKOdrtMH2b9HwNvpWsqwAY9LgcNNNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from DU0PR08MB8422.eurprd08.prod.outlook.com (2603:10a6:10:406::6)
 by DU0PR08MB9632.eurprd08.prod.outlook.com (2603:10a6:10:447::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Fri, 5 Sep
 2025 06:21:13 +0000
Received: from DU0PR08MB8422.eurprd08.prod.outlook.com
 ([fe80::4ac7:a794:5e4b:fc25]) by DU0PR08MB8422.eurprd08.prod.outlook.com
 ([fe80::4ac7:a794:5e4b:fc25%4]) with mapi id 15.20.9094.017; Fri, 5 Sep 2025
 06:21:13 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH v2 08/15] fetch2: gitsm: remove duplicate code
Date: Fri,  5 Sep 2025 08:20:51 +0200
Message-ID: <20250905062058.2563806-9-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250905062058.2563806-1-stefan.herbrechtsmeier-oss@weidmueller.com>
References: <20250905062058.2563806-1-stefan.herbrechtsmeier-oss@weidmueller.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0130.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::17) To DU0PR08MB8422.eurprd08.prod.outlook.com
 (2603:10a6:10:406::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB8422:EE_|DU0PR08MB9632:EE_
X-MS-Office365-Filtering-Correlation-Id: a9b7e85a-c325-43f1-75c5-08ddec44698c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?lOQLiGvc6v/lUwioHR5oMmuZnLugs94tDp9iN6dnVdj5KKvwU54LJj0ASENv?=
 =?us-ascii?Q?KxlWDCBXZpcMnGZwn02/u2ZVUAgJ9YRjxVOJI0KccRczsECwgi/EsKzljb5I?=
 =?us-ascii?Q?B7J78l3VTuacKWjV2zLfzeBXiqGSblVY41nz8Yig39rGPkbFXJPOs2je/KWJ?=
 =?us-ascii?Q?UPgMfMtxRjyhJi/ucMQJBB7hRz9G0/ml3N+9EHnbPMvOTZRGfHvK49I4qxk3?=
 =?us-ascii?Q?TDBJ7CMpJKosUH8FsL3/2Zf4ont483RcRCN8uDjzgrXwggYmZZCI3Y5ONfi2?=
 =?us-ascii?Q?Bvwr2/hQneGF0MhetelZIE3X910C+EQKKq9QCa+bVhnzD4GAa5Ql3ehiiomW?=
 =?us-ascii?Q?h2gchZO/4Gwn1UO33o2vx0M56Oi/WmA1fPOobVFgCNxhhIPehwac4x8hhLYy?=
 =?us-ascii?Q?bSTUxePbpiPJEvczSA5s+mhVU7YtMVLevUB0G8wGwwB5ioIBv3OTCDuHaql9?=
 =?us-ascii?Q?3Uy74kULmDl6nx+cgVg+b6mjJ1PpjGt9oPKJMP3WXb0ic5HT34RN5LG6sEN6?=
 =?us-ascii?Q?BqzOp3dHsQSv9HT3u68TUG4fwudnD7VhHXkzTEBoH2myt/vH/KW7XVtfUuxL?=
 =?us-ascii?Q?6LsZ/ijG8EK2fYaa1jxt2sDIyS7PYcSaewGBXv2xMl/k2vngZZpZiX0DMHDF?=
 =?us-ascii?Q?qVYAaiBa8Pii7/sfI0nfPoHEvc9sUcKt6/1FBUimVXr5Ck5JmGiqYdNqwmLH?=
 =?us-ascii?Q?x97Z46dE6HtgY/p9paq6cRFeaouTYqZQh6W3ALf8C7/+oiJz5+lFFOFRscKv?=
 =?us-ascii?Q?TsgPiRx0lBBSSnfoxS/AjBqS1nyV0J6/vcasSOzqb1ALxXvbQW+AZOGMuo6H?=
 =?us-ascii?Q?5JFnXDS6MTygGInaoUThw3pLXDLUJpWkgE2BlpIuHO7PauoWI+IBp1TwIOG+?=
 =?us-ascii?Q?sZl/dy9ySGLdIkC4KvGROGkvPExtw+VUkpzQDsyCT1uSDY5OFvSTRhhJcloj?=
 =?us-ascii?Q?mTpzC/htpu0iHb+83XJPoYiOVmIYJrk1XiJXIntxApGFfAv94M1R2fVBGlIu?=
 =?us-ascii?Q?dFD2OtAyPEyTl54vLqAeJVjGVXLYfxlTvsua2SHqbgO8AtouI1olvELPGYlG?=
 =?us-ascii?Q?y0lcKKU4Gqgbupq/COG5/fBY2XUlE+QKSYnqQskI40HTfeTxg5/6sYmyHqCZ?=
 =?us-ascii?Q?064cBiwX/iDgxa3rssmulh0g5OIuA9SdHYsAN++31Jo9PTCCdKS82+gvUHUi?=
 =?us-ascii?Q?P76apSZhD8xUlDxMna1UK5zx9mR0eQ9dX0Cjw1Gh3aWZpWm0/v3uFz+Y/4wD?=
 =?us-ascii?Q?eMyPmR25WS/zUECo799VD0nQfpowpLOoAZs8aYyG7NerK+Iqlkv4CHbgihHp?=
 =?us-ascii?Q?Qu7BVR8C9qM5qLEU9/u/+Ri5BdMtM38qsNJHl4Dha3yDpI6OiUzXSz5X8h2q?=
 =?us-ascii?Q?ctncD8RdaB1swoeLdywiNkyNDgmL7D/bGLe4CQAWF4IFvijLo7A2V+iH9W6F?=
 =?us-ascii?Q?tt4UKjNgLkAoBl6HWVVeYkiV2Q/ju0GgMaFreodvt9wBtjJDyGSY2A=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB8422.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?jpxi2hfZcAs2wP0mNeTPmT50BSBoLYk2ivMDIkp1qJiSETIH2i8PyY7/Pm7I?=
 =?us-ascii?Q?4mFdfs166OAP6cx/Qq8e6PGBEDUH5FPOVoxqJA+m80j8a8SPJRiEIQ+Apo1U?=
 =?us-ascii?Q?V1lb1xeWhWbJ9Lt306wUMiVCeuKCAZoFbE1cWllFaqpSl6/yq861b3DU4pwP?=
 =?us-ascii?Q?9y1FqqlOCr2dG/6DUYTtOSZBf4kDa30UpJE6H/ZtauknRzMQRBuGtsFv+SQv?=
 =?us-ascii?Q?NybqRx3QhbKvIps+1LHkZK9yfpf3ondCKNCJofBytyf66RuAsjs6G16tv5pw?=
 =?us-ascii?Q?6sK04W8QBKv5Ysxddptje+37a4iqla5kx5hyIzanqqBFQRYZWj/hlTwLcg6b?=
 =?us-ascii?Q?MfFRUiZ9nCmb5/mrrqYcGpt4Q8H1dqU/VA0v7+9k/3xg4yigU2wamQEfNlrS?=
 =?us-ascii?Q?qVbyUE+Na/QM91m69uWCb1tkQoX4+YAjr4roKde/W8B9R361ggFKizbXx3LI?=
 =?us-ascii?Q?F9z0a2S/8rqsgFeG6ozDK4ypnBFzJEoD6egxFRO/Agsyl923FsT7Qb8PRKl8?=
 =?us-ascii?Q?8tiTzM0kptYx1sOx5gpCjo0LhBAxX8cwyg2Psby7cYf2pvPSUqh7zmgS8KUS?=
 =?us-ascii?Q?buwLehBrUbo6JDLlub2PCZGkBVcBneS48of4rKZsqYc7W81utVFSpID5qr0N?=
 =?us-ascii?Q?OzS6pfN9eR1zhH3z0pmqxaVdgc0K31UOzcQGAWnxhtJoD/Ap9ezY3N7TY99A?=
 =?us-ascii?Q?gn2jHm5rHPygC5pexd4BOndOf91ufC+aSQjrhgAN01+vsvae6myim3GW2Z0c?=
 =?us-ascii?Q?pSeP1hiMScpc0DSo6Ii5cVXloxaHh6e0tenZXog5I2rdUzhQGG0tgtPw9ldm?=
 =?us-ascii?Q?+Tdi7g0jnObAjMONle0MZ8OTMEIhvNiH4dXiWINLzeJTS1SpCQCmK9TmALEL?=
 =?us-ascii?Q?7RgBVkZ199VM8lwKd/KzHSo+FsYW7eUW8KZb44wc2IoecYsoZymR9DKfw15y?=
 =?us-ascii?Q?eMQ6G25XyQBnMCtO1iPQQ2b6cRqr8lx0EoFnNvj2m8S8Pk1dWtVFvNgTAkB8?=
 =?us-ascii?Q?TVejfIi4N6GAocMEuoOhqUiAvVoq2cHeW9v+OFbdhHGyyZQMZ/mxTVRPNfZd?=
 =?us-ascii?Q?lvBAmmT5SPCDa/zQ0iKpDgP/kV+GOs/ITuyZeCImn/5cEP3DE9KL4eM6gWr3?=
 =?us-ascii?Q?6Kw65c2xEVXkhmnGcZD8rxmxKLHbB9DeY6yXLjFgcUIw3ZRkUDMms18D8ACF?=
 =?us-ascii?Q?WzGuhCiqGifs0eKqMkd5/CXnKAmtMa7eaBwMn+GyNkfdhDIZZrQAZfFVpC/V?=
 =?us-ascii?Q?WBWa6YH3rL913Qb8KAvIvpSXNXuuz13/KhwMU53a9A0p1d19lcAu3fWI6y74?=
 =?us-ascii?Q?m6YYDPIQ4t9B2fslmeB6muGkHVuyg7isrwCMuw84GH7hYuYtZil59RIQ6oaQ?=
 =?us-ascii?Q?DhACwJaJfkjHvV/TWKrmE2gPH9rgceoUZLuca/q4VfWqlruK/2CuvU3sEKUR?=
 =?us-ascii?Q?PCkDhZP/Anp5qUHy1V3MIxRg1isck5h8AL8kjw4p3WwMKChU/Hgy+Jk3n9C1?=
 =?us-ascii?Q?DwclDCzgmQiiCScP5+pWlSPk6JOjd4ppJpVSqCRAF8JBC6ZSMO0m1PClbyP6?=
 =?us-ascii?Q?PF2SyDGUZmf/H1SMGFnYUgQVJF84xGR1fO8DOA2yXj8SoCe+U+Mhu3ydmcWk?=
 =?us-ascii?Q?Ug=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9b7e85a-c325-43f1-75c5-08ddec44698c
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB8422.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 06:21:13.0450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pkXmLS5i5FYIIuUMd195U1ckrx8ZIIz6k0siIOGo2nd0G2mj5LiBWMMQ/gtdnJbzY/iO16CVICusvI6bHfw7hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9632
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 05 Sep 2025 06:21:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17964

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Remove the duplicate append of the nobranch parameter from the loops and
move duplicate append of the bareclone parameter from the loops to the
URL creation.

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

(no changes since v1)

 lib/bb/fetch2/gitsm.py | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index 497661bd6..953a1ca39 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -124,6 +124,7 @@ class GitSM(Git):
             url +=3D ";nobranch=3D1"
             url +=3D ";lfs=3D%s" % ("1" if self._need_lfs(ud) else "0")
             url +=3D ";rev=3D%s" % subrevision[module]
+            url +=3D ";bareclone=3D1"
             # Note that adding "user=3D" here to give credentials to the
             # submodule is not supported. Since using SRC_URI to give git:=
//
             # URL a password is not supported, one have to use one of the
@@ -157,8 +158,6 @@ class GitSM(Git):
=20
         need_update_list =3D []
         def need_update_submodule(ud, url, module, modpath, workdir, d):
-            url +=3D ";bareclone=3D1;nobranch=3D1"
-
             try:
                 newfetch =3D Fetch([url], d, cache=3DFalse)
                 new_ud =3D newfetch.ud[url]
@@ -178,8 +177,6 @@ class GitSM(Git):
=20
     def download(self, ud, d):
         def download_submodule(ud, url, module, modpath, workdir, d):
-            url +=3D ";bareclone=3D1;nobranch=3D1"
-
             # Is the following still needed?
             #url +=3D ";nocheckout=3D1"
=20
@@ -197,8 +194,6 @@ class GitSM(Git):
         subdestdir =3D self.destdir(ud, destdir, d)
=20
         def unpack_submodules(ud, url, module, modpath, workdir, d):
-            url +=3D ";bareclone=3D1;nobranch=3D1"
-
             # Figure out where we clone over the bare submodules...
             if ud.bareclone:
                 repo_conf =3D ''
@@ -239,7 +234,6 @@ class GitSM(Git):
             runfetchcmd("%s%s submodule update --recursive --no-fetch" % (=
cmdprefix, ud.basecmd), d, quiet=3DTrue, workdir=3Dsubdestdir)
     def clean(self, ud, d):
         def clean_submodule(ud, url, module, modpath, workdir, d):
-            url +=3D ";bareclone=3D1;nobranch=3D1"
             try:
                 newfetch =3D Fetch([url], d, cache=3DFalse)
                 newfetch.clean()
@@ -256,7 +250,6 @@ class GitSM(Git):
=20
         urldata =3D []
         def add_submodule(ud, url, module, modpath, workdir, d):
-            url +=3D ";bareclone=3D1;nobranch=3D1"
             newfetch =3D Fetch([url], d, cache=3DFalse)
             urldata.extend(newfetch.expanded_urldata())
=20
--=20
2.39.5


