Return-Path: <stefan-koch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29DE2C54E65
	for <webhook@archiver.kernel.org>; Wed, 21 May 2025 09:12:17 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.42])
 by mx.groups.io with SMTP id smtpd.web11.6918.1747818728967801793
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 21 May 2025 02:12:10 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=g8FuSfM5;
 spf=pass (domain: siemens.com, ip: 40.107.104.42, mailfrom: stefan-koch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L+mERiW9WPHVORMEnRYShzJTiOx9HgGh6ZFyeSHD2MrLyhsH2izvhRVsMs8/yZzljVpr/ukwLoM4Ur7aeAUjQcTGfu2DQQEqP45dUdT4h40eR0J81/dFQTFCHs3aiSuVqiMBWx/D7mxYWhJLrNdCIbyPgj3NW9X6G/vudc4+EiYBHshDoc2EoIZ8PjkLNTMDge7NMoeoQ6IBTXbMSdReOVf64uamKamoqUgfLXUVUSLE2eA5gl3a0kkddW8N9IK70g/T9mpcg6kakgK7GAJL7K0q4qgVu4ry8QnMhNEsyREGXf6b4lnq90TLuOPOk9NVuPV+9f97FeC1Nm19y3vkRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0N/+TH2zEKVrwg+ixxGCRRkrYo4v97ZlnzMU927ocpY=;
 b=AZ8eIwvANzQQ9kZNEFyxluSkhT5DkCKmbuz5/twGIKl/7BrGeFC7XWijx//1BDoLYby59UnC5bF9oC7m9WxR45WhLVWOkdTo6uXK6Rv2obBHs983FIVRgyhotpGZGn41SPCW8LjATl4lpKIajd2+5R4ZXYERRAxXKXHJf5te2cLHogHfAX6LP0PFgJ6zFtlEm9JoAmij7JrrQZaPMMsRFJJnTSakuUKPmiZPNWNRRnU4pCgVVSdqbEPCEJADHHoF6cpnQg9s4bIViMDPrnui7ISPEUKp1R9+a1tBkRLJ86OHrR25XHogyZ3OPP8OoPIasW6WaSOxiIcgpznIN/aqeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0N/+TH2zEKVrwg+ixxGCRRkrYo4v97ZlnzMU927ocpY=;
 b=g8FuSfM5oVWeQBORp3ZRU8KnF/s+DhZpf8zQJO37KeOZbxJlgZLUOS7/7MY7iyqntpcA+LknI+gdp4wmkhcTx9nIwKvRPZd6Rpgf0s2lC7Z1Tgc9CjQ6HXB9QDFjHfHQyBvNSqBMKuC8qusGOGIt7ywuGQkoqYWveMHtZAzptPgkU4ok6JeHY/bqAljn7Adnna5z9HK3b0ss1rBDdljAsaQybvgZHlh471T4BKAzTMKZvKKcy6NuSXDHuv/QBZQQH7L3a76mqvZUQypErstOqzLzCZEV27SU7VznMZ0sf40tYXFBzyjjHlyVvgxz4tWbrAtgMdueT6YDEFdOiDxHlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:41e::11)
 by GVXPR10MB8615.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1e8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Wed, 21 May
 2025 09:12:05 +0000
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec]) by AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::71d7:e998:3abf:a1ec%4]) with mapi id 15.20.8769.019; Wed, 21 May 2025
 09:12:04 +0000
From: Stefan Koch <stefan-koch@siemens.com>
To: bitbake-devel@lists.openembedded.org
CC: docs@lists.yoctoproject.org,
	stefan-koch@siemens.com,
	richard.purdie@linuxfoundation.org,
	liezhi.yang@windriver.com,
	niqingliang2003@gmail.com,
	alex.kanavin@gmail.com,
	quentin.schulz@cherry.de,
	simon.sudler@siemens.com,
	jan.kiszka@siemens.com
Subject: [PATCH 1/1] fetch2: Ensure a valid symlink in `PREMIRRORS` case when using shallow cloning
Date: Wed, 21 May 2025 11:11:53 +0200
Message-ID: <20250521091153.2445853-2-stefan-koch@siemens.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250521091153.2445853-1-stefan-koch@siemens.com>
References: <20250521091153.2445853-1-stefan-koch@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0276.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::6) To AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:41e::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4959:EE_|GVXPR10MB8615:EE_
X-MS-Office365-Filtering-Correlation-Id: edbfddfd-2fe6-42e4-9820-08dd98478dde
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?az/PoxIlbvzgCN811IY1ujHJdVBjzc3xG01mLbLlYZoKs6dE+/qKI6CeTc1U?=
 =?us-ascii?Q?h0Ac2uF4YCC+LJEOlmfvHK4fbZGDT4l9lHHv5ZugQaHs2G0114LsSO1si4ze?=
 =?us-ascii?Q?BL3x4MNxVThaeIM+y9M2svpgopez9rLyRuzHR7yiKwPvuWaot7RxU/G5oN7J?=
 =?us-ascii?Q?AWc4DDdSFVJw92D1TbntvLB/OUl+RzLvffWgIbEWOd63VfTMb6GF5Don3s7x?=
 =?us-ascii?Q?4mC8x9LZ98F6jnX70aI4axzl9q3RMsyW/ACN/nHt6g964/XUh2djfAY6X7Se?=
 =?us-ascii?Q?wyGfcwC+Bgczwfo0oqINNO3TV5Tg9ShN5q/z7FcFqZjcwnAIW19cESxf4Uwq?=
 =?us-ascii?Q?MX6yTrriHLhIXuurWTMX41br5v2WukoDuu7DMzZ8YhFqVaRSEtNgWY0B0WYt?=
 =?us-ascii?Q?nCyLmNcVSR60gpU/mbRukd7DInd5S04A9YoH/tykrosD7YxFo+1tVFO678eI?=
 =?us-ascii?Q?ocmMcoH95rnlPWVT1PBV6wptP64kG+DCf7Q5OGStrF9oPBPpRdOEqx2VOOPJ?=
 =?us-ascii?Q?tX6NZJHvfWnh27ic/9Q9FoRGpMl8C/3Rb8vIMGruN3S3YbXmzhIausl1BIvI?=
 =?us-ascii?Q?Sz8yBKCwOf+01/TEdbW5MqbsxeaPwMF7+MOGilnOl/pOvy01o1HzXIk+kfmv?=
 =?us-ascii?Q?+/ob9S7vT5sY7H/lt0cs4/c+ZpXDAUnlJMvaKLGuL79bJsB3Fz058+Vgb3Ve?=
 =?us-ascii?Q?4s812BwVRPdZPnQKTB7t6MPvhEYl6P2gZH+tS9MFFt01R/LepqwRKbii3S++?=
 =?us-ascii?Q?qDrLf2dR/0q6uZIKzJ1ter8mIgDgPWJN3kRX87yVHIlSEASKbtlxAA1/8Pz3?=
 =?us-ascii?Q?/HQecwKghK1C0au96X6jWh0Q3S934Fbm6DqxtLzMl3ziiWnYHqfhpl4Vasfm?=
 =?us-ascii?Q?A2L1+cYfDKo22ny7+JSW61qkOdn9rTF9pWnTxjrH4POpy4fmXMEmLgAzK15E?=
 =?us-ascii?Q?uvpzCGlbFOVUz81UTVmJHX+2gST4z7pU/jLeeBr1S4Dyk7pdEuieb09fXX+k?=
 =?us-ascii?Q?StQreAMEHsMIU6CPdouOWFUo8uDBupC0vMlnIbnzjtFcM7/LW7LwvDxHgxix?=
 =?us-ascii?Q?Xacksq3J1TmYsZJH+y64bctlH9ZibUfwSUJu5ZX2yUs4VEGMvfYA8R2KB7iN?=
 =?us-ascii?Q?iJTcBFIIr8a5ud3Zr5ZC4NRwsbyjKv6G2kBufUB38rGGx4VG7LQFEOJ0c1V8?=
 =?us-ascii?Q?3TaYKOB4whIT+ohXwwePU+1hkByQrxFsYbsMOrX5wREuAGNjjnThs7tmaK0P?=
 =?us-ascii?Q?wHhfdXpZmt/7MH1dacxYJwPRmiwS3XvoIoVSxaz2xGmyn0HvveStjcFNQLkm?=
 =?us-ascii?Q?g+FHTd5KTgrUbtEpcytLrlFyAuajmeBgS8EJ1CQT8R2dr2j45in7N3zaI+Qk?=
 =?us-ascii?Q?VlCMi7mgdsQFUOsKBJp5FcmslzDLoLKoUGluo6Mmg3aPReLuu7Sg2HGJIDS9?=
 =?us-ascii?Q?3I+GBAL2pHs=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Fj1pzw7cheGP4DjF6wGb0b1YuVj7Acr5GX8os6of0IqipUWZths4ufiV8ixT?=
 =?us-ascii?Q?OZQ0TCjaxTfa8YErJH+zyl3HlwiHlOX9oOvdygKT3jH2KN6DMehW0j+DPYzC?=
 =?us-ascii?Q?LZRM0TF17tCwAwdAaGlpCtZGPBf9XA6QKyGIRVbdo9/yYV53relxdy5re58v?=
 =?us-ascii?Q?eTU7mTAJ2veO/ahPh0+DGUFjeZOZg+tABb97GKesXoczLUAsev8wbVjzPPJ1?=
 =?us-ascii?Q?4GCZKGgkroxL4jeQgyJBCfvq2+x/xZu1tdbPP+MF3nUryGPwH38qrC4zAqsz?=
 =?us-ascii?Q?EQoFAseLCDGPsVzyS36eGYisM7oB0xwj9vVggulOdV9UAQBmtMv8TSYJ0028?=
 =?us-ascii?Q?bKI5SZjZMqphKmBgZRyR6dHQsSJ/SW4UF6AzPRto8qTTa1aLIHg/EpdtSW2T?=
 =?us-ascii?Q?+bvXvD19nVfPiQhyZfy5zXx3taunwetCoaoyM1qBnchSVPNBg6bhR9cbZmch?=
 =?us-ascii?Q?yuFP12CCWhCDpUDtkng0l2CraI9+gXzdqSlllsq54Q0HaUMd4bOHlAP1sfMz?=
 =?us-ascii?Q?pXQcAgdEsoQIryMGLWqppM+I4OE5b4an6hKdd/ABiA6qSZBmB96b8viekYfk?=
 =?us-ascii?Q?yZQGilMZSy33fpQ26LOGTuz+2HTN/5njKddv7rt5B0wWh4Yayykj1EIgw0KN?=
 =?us-ascii?Q?wfFyfJoK8JmFHGUSAqtHNJpsi0sureNn52II56gK90u1lLyzoPZQcN18Tuok?=
 =?us-ascii?Q?UFckYwNA++L1iU0hrj5rXbtveaVJW00QtSoB9/q4gqJ0nHw0FqxLTjl8P/r1?=
 =?us-ascii?Q?LE7KsqkGM7jzULpVp6zTKi/tb5af6AEJyK/uV7vagcLqfNtBnJn/SusKFILp?=
 =?us-ascii?Q?ADQZwRt0M1idchVd740G0/hL3jQFOKw/CdQd51j56S48UuKFa5o9RkqEy6Ku?=
 =?us-ascii?Q?AIkkOrNsOfM2Pyjh18lmJGoQMEYY1Hl1Nq175C1UWl6phdL0Vn2rJKjQEzPG?=
 =?us-ascii?Q?kMkxoA+ZoE6yAzX0cfD7M2XfhHKEuDGFhOQexE78NshIpieRdgz6WkuK/U08?=
 =?us-ascii?Q?7QP4vrE9Wx9WOkPa2Y+gMlj2c1C6I6caUW327lbk+V9dMt0LOkyftKu6gEp9?=
 =?us-ascii?Q?Jrjq62Q609pUYSaDyMKxWe0P55gWaU6ltNe4t5fYZp5iKCBHdpYXQK2VTbX5?=
 =?us-ascii?Q?GBmcXuAuV1xj8je/fl0b0onvYxAjtr2vpoaAyDiRjwMKpPeOEY44wohoxoJb?=
 =?us-ascii?Q?peCEq5d5VunIhQjOj5CaOGRmN9jyW6loO0XsIDbfitv1JWCLScbcvIik/rrY?=
 =?us-ascii?Q?kxc4sY/QRqZFSmC+zPQKq7zH188gLnVcd6QIdWQbphhGXgzsaVxVDulQTCwm?=
 =?us-ascii?Q?kLdfTGNL8ZoQ7LA40xlMKcCLCzik3s6f+5ER2M6+ciTZLVO4QMDiwGtHtUlg?=
 =?us-ascii?Q?dQrk+Gp+GpFWduhCbud/K2qAxXBVEsY+3To65TuysFwm0cClS1JacAgrYswT?=
 =?us-ascii?Q?GrScspzQ2DAbofmHw5rUksNUM5kpJK8IUVTJ2r7KaR4jFSmZT6sGi8dBvi9x?=
 =?us-ascii?Q?ug+MyToDlIyneJfPeV1qFAo8CjFY8kmLyP4IChU1tYTsp+eQ3un4fsBVBSjj?=
 =?us-ascii?Q?AT5YYCMVD2xVQpXIZ3s/8jyLPMx66FPJeQpWOTgTUlSp5cHCBvOn3KxzI4TU?=
 =?us-ascii?Q?Ew=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edbfddfd-2fe6-42e4-9820-08dd98478dde
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 09:12:04.7932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pi15pYe/+ucHIEU38lXvpOGbJFObC3FduTaAvJFMyJAVlT7T7JK7mFkwYkqdjl0tkjoUamjaGHuA3rE3didQqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8615
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 21 May 2025 09:12:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17624

- Since `ud.path` contains in that case the `PREMIRRORS` prefix path,
  this change ensures that a correct symlink is set up.

Signed-off-by: Stefan Koch <stefan-koch@siemens.com>
---
 lib/bb/fetch2/__init__.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 2de4f4f8c..7459adb00 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1117,7 +1117,12 @@ def try_mirror_url(fetch, origud, ud, ld, check =3D =
False):
                     origud.method.build_mirror_data(origud, ld)
             return origud.localpath
         # Otherwise the result is a local file:// and we symlink to it
+        # This could also be a link to a shallow archive
         ensure_symlink(ud.localpath, origud.localpath)
+        # When using shallow mode, add a symlink to the original fullshall=
ow
+        # path to ensure a valid symlink even in the `PREMIRRORS` case
+        if ud.shallow and not os.path.exists(origud.fullshallow):
+            ensure_symlink(ud.localpath, origud.fullshallow)
         update_stamp(origud, ld)
         return ud.localpath
=20
--=20
2.39.5


