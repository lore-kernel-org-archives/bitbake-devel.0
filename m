Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E54ECAC589
	for <webhook@archiver.kernel.org>; Fri,  5 Sep 2025 06:21:24 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.75])
 by mx.groups.io with SMTP id smtpd.web11.14988.1757053273963266587
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 04 Sep 2025 23:21:19 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=YRh2XYbx;
 spf=pass (domain: weidmueller.com, ip: 40.107.159.75, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g0ScFYrUafE7LHShhBrIidU1knBOyU+XljcBuPI1kyviy7sUfmKfFPxmH79cXaw0G+4yHppxn7/pZbtbIAXv8pqppXVH7RgPnkI1YFgmZ9STnp7gV4YJe6M1YwdwBq8RB+7UZewvm++JH7HeLXCvFFT0El52vhG8bKRsnAZy4YTIiVTXlej12+fZ63Q8JLATa0UeR2Nm80BpRzRlHZWy46xMKVb16EYlPpZ9QOxvC4GlbcmQeV2lrBUKgiTyjGrXX1mtNIaFndnDVxafYR1JLPMvkQ7mDdaerPp5naWR1rIrHuIoYukfEXYon1R7L9ICTFVIe+Ka1+Q6k+fui9Ja+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O1Bjd0MagqhDxEvw7qhM8TPa1qTyUlhoQl5M5E0Wj/I=;
 b=yo0tBBeP/vABUcGHpE8PlaJYm8+hqPoCMYeo/r3HglOaIbX7ubfPcqd/HtdeUL3zXVYL9u+8zOl+yAkxN1dbGbcJw7aIdek4rxhNSZ0K3MeexGdpo8Ct6A2pnrus+Xv1oQuicrea2goUVuKMFIRF/mdGQ8zkaZnIARU2W2MTAQ8NKE7ITInKHpjPQ86kfN71NgEUL0skIF1o+9NHsgaCSxj5nT4tQkp28kr0aT8wftbYWeS4BPBwzhLWq9WmpatHzM6mkUvv+0Fbzf2EyHDgiYBwQ8I015aW440uMA4Bs/mF3UlX1tKnpwiW4lWOWO1wzfxlbBkQg9J2FVgQ5Y21sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O1Bjd0MagqhDxEvw7qhM8TPa1qTyUlhoQl5M5E0Wj/I=;
 b=YRh2XYbxd5/eGVo4vd3vJ+mt1gEmJ6gWdgqTgm7x6ZmJLgyXMqaR9f1rYEvbHrU6hLS9Q8dioWnEfFww1Y5Tl1UBvh1Q+tat1I9SPgAIradi1yELlhrsmAwgCwiRXha7XG6gFTI2gWDcQhtY1h/2ETRJZCf3mrlD0mrom4wFSz6EzDw16oWy1ykzRMYAaQyy1x/N1HFjN3rl0uoS2k5f1EaY02mmVlXc8zMluwHsArMdjlPgNPM9Z02bz6SHqAVCAn4gB9aRfisPvRu2gs6vvUS+IZ3r+etab+41IL02gEebDHzJoH9B+um4DX1KnSYlBTKz/zsikrikt83SEQ0TxA==
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
Subject: [PATCH v2 07/15] fetch2: gitsm: use rev URL parameter instead of SRCREV variable
Date: Fri,  5 Sep 2025 08:20:50 +0200
Message-ID: <20250905062058.2563806-8-stefan.herbrechtsmeier-oss@weidmueller.com>
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
X-MS-Office365-Filtering-Correlation-Id: ebb53fee-e05e-4957-961e-08ddec446948
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?cEYHW5qDiTJtfHuP/w2YDvNTY/MzhbbhBI3WrZ8iw+5UUjfGTr59rm6SLeO7?=
 =?us-ascii?Q?/ZsQ7XpenJNBQgv0aI9r0q8mnQg+4z9iL4gv3dxf1KTGyzBblHw8y958DsYe?=
 =?us-ascii?Q?doFTnXBtM4W4VS2hlCmIIjA9brCg76RHu+Aju2UeterIrPSphdedKUZrJv4N?=
 =?us-ascii?Q?40cE2f4KHeJ14C5vCGzcYsgy8IMpcXp5fmA82HksVi31OxkxFxF3V61y5X1L?=
 =?us-ascii?Q?Fj288HVRUmtazRTH+SBCXV6c07B1rcujwTOZsd5apRDjzNsCZ3vZ7zYI8V8S?=
 =?us-ascii?Q?MD4V8fa62nM30xr+VSSbPmVKuHWNvgiNJ2PPX5hiFL3xXkMNN6OpnhTb+0cR?=
 =?us-ascii?Q?BOCAxQ9KuM0HjeQU2rOrf9h4GEFYmZHPGDpfsBYdvwJgePylgfAlSLN16Pc+?=
 =?us-ascii?Q?SGxnVdxUGS7vKuT7/hjOtaqT4vk1e3NMUd69Yck4YNrhOnyLR8s9KbKLVn/7?=
 =?us-ascii?Q?LLsI0ywzOo5O/zVxvBHtc7JAlqXpTsScRHImSMqnaEl8/OzI64pbzMBVeqVp?=
 =?us-ascii?Q?26N/ka/rmfpDs/4KqvvOjOnmAz9N4EoQ3o3hRRqS8fWEVpeUQSaWzel3lgDM?=
 =?us-ascii?Q?34+npIq5yq0PLxD5WQYWf64LLtKowKEe6YYzP2A/IXMzp5ipDVHgJXDvxIRZ?=
 =?us-ascii?Q?Wkbm68p5sdkTVl9fPFB8vaVu+NBvWFpgJ7cV2bIoaCmrGQCSbYa2fl6KqJdy?=
 =?us-ascii?Q?LDp9IyIaLhggs9gGUxHN5ldxccguLQahrIN4SEN8bPWnFo7YaM1QxgAxowiA?=
 =?us-ascii?Q?JEFntSYL7dzHJZN0wFA3y8+nmGt9Pu6K9MLT2lcjHZbbImIMLcwTjgatMC8P?=
 =?us-ascii?Q?T4exPO269B3GSl3pJ1+sL+c+YHreye6Ph+X4uiRy/SmqyyeQawJsIoPxRC67?=
 =?us-ascii?Q?CiTjBF9HIqtPQN1W2A/v+avTSOAFF9HdqZsglWgp+rH8cqMLaqyH399mgoTI?=
 =?us-ascii?Q?+3wr57voeZboybu+vTw1Z8GNnGyl61LF+Do0GsZzZ3a3Epjea2Nvo0Q0t6ly?=
 =?us-ascii?Q?hqLmEnC5Vy9rEAmCt3LskIdqXZeBJhSWzeCQg3ss7rOk/KvXTK/p/Vly/y3q?=
 =?us-ascii?Q?GuAwGEah7RKe78HYbVG6sJVJLy7qqU2+XHfVIAseb0sw707bFusKVBFu/Y90?=
 =?us-ascii?Q?u3YbTjDkZTy7s4trjQ5byHpc1y2lX541J56pSUuVi+t9/ylQvmSyoyYB1nAv?=
 =?us-ascii?Q?NuzHXb2ltvIuyHT7gqe5TlwD3w9zyvMyhlIHPsuucpkxGpCPnlo06lW6IvEd?=
 =?us-ascii?Q?nHW1mpJOH2IkVkHbpwdc30fY+lFWc6zxHMQc46X9ht6n9Y0+/t4uwO6xLVlU?=
 =?us-ascii?Q?cH5FtI2dg5IuCBAa7grDyDMdqG5K/FIgUWSk/WNnN67YL2jakrqe6MgbqCLa?=
 =?us-ascii?Q?mi4v+WPQE3e2PgEilGgAmrKYOOJk3U79ZC+GXeABhZw947K/sclH69W8jyGm?=
 =?us-ascii?Q?8nJ158eSXT7tKvt/5XoOqCK90kboP1KRfPathkDm48symG9R8RAYnQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB8422.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?YeA8ShyNZbibU6XfY5dQjoZsO5snQJ5o1Mv1Rff5QKivGlyUnhE94tHrlfQK?=
 =?us-ascii?Q?br+J7tKrh4gYSwXerUG2EXh5607o+shfQlebRVvFwIo5cDiITXtLRfEJ3w5S?=
 =?us-ascii?Q?YUNY6Aoax++wnb6SQJ0TDxKP8bwVmqYjx9pHnR0Jv0JuSNlMHVAkY7xJ0wmM?=
 =?us-ascii?Q?tpwtHZI/QAde76ZusjKTrucw6jlvsYL1QFCKUWHxpqaUfHWdU3E3oQbxH1cs?=
 =?us-ascii?Q?/yrPnw1oKj22Fn9CS+UO7syIm+4VBNaYziH30h/8Ksf7XE/EMh7jso4uU04E?=
 =?us-ascii?Q?yWEf54vFsbxLlHzcYSHCwI0/dzaco4wLpCqmwSaPTylD9iYKbI8IR8v8NcM2?=
 =?us-ascii?Q?WMq+eb6H3k/6HUximfCrSOtGrdj858/FB0yNbJVySnnX/o6sfaxutdn+ksCT?=
 =?us-ascii?Q?fQ/3qslAxTpmeINBCx3R14RU8WgG0h7r0jUvNckQU+/9y7eE2McB3ghI5Frd?=
 =?us-ascii?Q?QihgHV05zFYTeTqnFkbnUZkkpDGr86LgAuxNCnoMFe3+V8ShyIY2S9OqD82D?=
 =?us-ascii?Q?oO802/MfCH/PltIJXJJbqLMyh4KVQeIpOLC6yGNpn4TGGme3DL1xCcSj2NZl?=
 =?us-ascii?Q?B/QsOFodT70Q3FZAtpYjg2gxiq5e5A+IXIaSI/yCsjI+TZGEJx1bUPC5J14S?=
 =?us-ascii?Q?m6MRzsiN7W4jvXOaUFLW/jSS1VEf7Xbg90N/2RPoVyUuWXAj+7m+Y53YkxYb?=
 =?us-ascii?Q?yXbQuwNakj+gULiPLRxYgoCL1Mrdfzc7ZpPbn4NiAmebjq+igt2Mla+KJVNb?=
 =?us-ascii?Q?aaliIlgPV91t4UxMz4TDntMJDA1DHLo22QZ1NSMzO4RlvCY0n/4bj6OsP3r1?=
 =?us-ascii?Q?DZ8p8OclDzUUqT5h28765VkQolzVuQfoJu+0+69GirnARRY4Rb+AQtYEbe5a?=
 =?us-ascii?Q?uwx/qOTJFvzYam1Dtrj24bGLIsQpc3gsWYSPcdnMZ0jjngPuV9euffHVr7T6?=
 =?us-ascii?Q?e5uYYYkzNWqB6mtsT6Belcg8s5cdF+tmW9UUmMflgafeKT4HEr+693/sBT7d?=
 =?us-ascii?Q?hvcOkSq7D5gtmmjGxgmUxf/21eqkLqNWd8+hPGBCC10u9Id2IwbzeEkSAM0S?=
 =?us-ascii?Q?1DFzCP384gDTpu4kyrarIh/L/O+/I/HrSxk5OMIkXKqwl+PhkPvqTH8vmtO1?=
 =?us-ascii?Q?U7/aHitWI+kCkvAmX5Ecd4+EqYr00CNjFiyxv8q9qgQxWeBET43fnNk3uo8p?=
 =?us-ascii?Q?+io+yYE9p45oAKUyigxGrRA8cV5prTTQSyTM4UIlZOz+H2aJ6342bWlqtevZ?=
 =?us-ascii?Q?iHnq4F8+G8MkuZxCxVnj0CzSzUMGijvl201RekMaE07MMoGKNLUKrpgBjY0B?=
 =?us-ascii?Q?gtA8eDn1bCZcLE6+8UgWydhqUp2BnGlTCsWdmpNITAgJgjTYISOKDL6QX33/?=
 =?us-ascii?Q?jw8Qc0JSeFDG0TMFnrnvkddurIRdF7qot1KOqBtaig2neD1j+kGB83g6Ffjz?=
 =?us-ascii?Q?dDhX3DrUuxByuagR3FaL0PLerS7ddZUHfswA3zECmBehQ9lXGFY/vq+ybK+n?=
 =?us-ascii?Q?SPcWY/SufbtrD2pkV7q4zCVVQ5iJzht7bUfGKmPbuXXkp6GeFbktv+FScKuh?=
 =?us-ascii?Q?3fyYzv1Mr9hWkFMlq7+j4UyXJx4g0XzewDo5xJe6K8k1693259kydH61mS2d?=
 =?us-ascii?Q?UQ=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebb53fee-e05e-4957-961e-08ddec446948
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB8422.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 06:21:12.6427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GiKh5TvDS/foIrQAj1S9wCzUqEqkjcYplL3B1zDNnRMgERJMv+MG9BHWEolXKtP+l3aDO0VBbWYd7VcO95MM9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9632
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 05 Sep 2025 06:21:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17963

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

(no changes since v1)

 lib/bb/fetch2/gitsm.py | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index bda9864ee..497661bd6 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -123,6 +123,7 @@ class GitSM(Git):
             url +=3D ";subpath=3D%s" % module
             url +=3D ";nobranch=3D1"
             url +=3D ";lfs=3D%s" % ("1" if self._need_lfs(ud) else "0")
+            url +=3D ";rev=3D%s" % subrevision[module]
             # Note that adding "user=3D" here to give credentials to the
             # submodule is not supported. Since using SRC_URI to give git:=
//
             # URL a password is not supported, one have to use one of the
@@ -130,13 +131,7 @@ class GitSM(Git):
             # the user (See comment in git.py).
             # So, we will not take patches adding "user=3D" support here.
=20
-            ld =3D d.createCopy()
-            # Not necessary to set SRC_URI, since we're passing the URI to
-            # Fetch.
-            #ld.setVar('SRC_URI', url)
-            ld.setVar('SRCREV_%s' % module, subrevision[module])
-
-            function(ud, url, module, paths[module], workdir, ld)
+            function(ud, url, module, paths[module], workdir, d)
=20
         return submodules !=3D []
=20
--=20
2.39.5


