Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA4C3C021A4
	for <webhook@archiver.kernel.org>; Tue, 11 Feb 2025 15:01:03 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.66.76])
 by mx.groups.io with SMTP id smtpd.web11.1132.1739286057297610302
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 11 Feb 2025 07:00:59 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=NtI/zJGa;
 spf=pass (domain: weidmueller.com, ip: 52.101.66.76, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KNMgLTioYg6OVvAAElZdHTrr9F2gKmEoMHyGXqJUDkKp3873IbsgkV4Mqbu21sSWzZ30+Nvy/JnAHxX/oXoDdFyGp2ze151uIyKSbMf6zS2u7kAAE036e9to8qlgdVji1GIpDYMIRSBwg54COSip2nx8LSxiBx9chKd0L8e6ftLlOZk7xrRU7Xpl+b4Z+w8146CA1HNxKnRqnEccN66uV2DwKcBMY3xmbPb82QwrjT2oonMd4Bu82BzXtpMppr4yiulsmf7z6U9xPOBHuwsEUg7eqeQdjGPvO7NiKOMolUZqZWCYwTF2KI7lTnreGJIxV47cSu+OlL7E7NqojShR0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nbczGzWQsxYGsGX+N8m7uSo/i8hv9Xe692goWoKs5Pw=;
 b=wdGocmxT0ZpK4dNlP0oOkM+zkDf7oshx5rZvK1sCW35iJE8q7a8cV3o+A5XPNtQmZdrmt9uy3sLxGXASfKFsiuVjE+KwwF0hyL5S7kVPKD8MMypds6p9Rj69m1cKXTqw3dJhImos247Fzv5tCfB5gRY70XGgMeGNSGF1w9DlK4Zjkgl9Shqry1HJx4inoWTw3VTJ735lEV47C5lQVyrmR4KP20lgZ4ZWNYTxZjHdH07mBuKyenH66uGDcWw5nhSN1yAZQz62vh5RMo6RwZ+eG49NEETpc/3HHfYv0jel0X9MzMZTfpKspp2pfo6vlCWnojFM60kJuJcK670RyuH+Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nbczGzWQsxYGsGX+N8m7uSo/i8hv9Xe692goWoKs5Pw=;
 b=NtI/zJGa/8jq27eLkCEr0WkA5f3tTFvuPP+uM/SGBc1M3+v31VNFXBhsY7/B7nqnUyTU7YoKGSGFzRADzf0LOxLZpI5P02p5PAB9SK+pLPHQQwNn10kKtCoZ4W0lzUmWi8d24H170qhtouBS6ot0j56qHqxMl41yWjtB9qTCGyeoUyktkFIDohLm3zA68FEgvd7VPJ6yOYpj0Uvy7S4yUrKW+u+0SdUMWoIy362K8f0+D79aM8g8OQ6yT0n6q8HkKONte1ibirKGb61llraJgHVzq5OFAR28wvn7aeQcLjjpXvoqR2nguhfGKy9NDzehLkJnrJ1el6HCM1qSXi5w5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com (2603:10a6:150:8a::17)
 by DU0PR08MB9396.eurprd08.prod.outlook.com (2603:10a6:10:423::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.20; Tue, 11 Feb
 2025 15:00:54 +0000
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013]) by GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013%7]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 15:00:53 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: openembedded-core@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
	bitbake-devel@lists.openembedded.org
Subject: [RFC PATCH 10/30] conf: bitbake: add SRC_URI_FILES variable
Date: Tue, 11 Feb 2025 16:00:14 +0100
Message-ID: <20250211150034.18696-11-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250211150034.18696-1-stefan.herbrechtsmeier-oss@weidmueller.com>
References: <20250211150034.18696-1-stefan.herbrechtsmeier-oss@weidmueller.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0103.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::16) To GV1PR08MB8426.eurprd08.prod.outlook.com
 (2603:10a6:150:8a::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR08MB8426:EE_|DU0PR08MB9396:EE_
X-MS-Office365-Filtering-Correlation-Id: b3313aa3-e5bd-4594-e2f7-08dd4aacdfde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?YolDHgqhcGc6CW9qwjUTiU9j9fHPOy6EjLOAq9xiXuZfoLOvRrRQAPPMhp0G?=
 =?us-ascii?Q?kwTtZDfThOsjvZXkLPtHtRE8ni2HLJnv3/amFXh/fHiCbP1F9IURJYpn5D6p?=
 =?us-ascii?Q?wiV1uJU6tGJgayGT11aaUs7PPLbbhYg7o/q+3cfU0sECZpW2/Nta1YGMEdnH?=
 =?us-ascii?Q?nu4gSzNakCmOYrjK1siaXmb2E3Ic+FIBXsHI9VcMFH3qz3Z5HUSbPiuiN98w?=
 =?us-ascii?Q?Tv3u/fORobhlo9MVw3JQWPGN0zzrGV2ENL0+JVT6IqKRVt2hUX4OHJcxJtwM?=
 =?us-ascii?Q?AtGSBBpnUr3AAUdqObzyKtJrOJYWU3dEPmG9jB8Tprf+ot1mF5ug4QzlrZlY?=
 =?us-ascii?Q?6SoVApMicqFJ7XHYqKrmVfPS9gCPWBRWNPyjzlQu5q/I+J/b0Bf6z+QcR4H/?=
 =?us-ascii?Q?l6hCuIwCdmXJ2Mn0fOH8t+R70clhTjb8A8IAbFOfD5L0hKmvBQkZPssDHSgq?=
 =?us-ascii?Q?Mx9KUfLjDlZjo2ySe0zCptoOH1pZUwYDYqEF/hOA15Q9TunFk31FQVDJNT7Z?=
 =?us-ascii?Q?5tyNZ+OmO0gnALomZ4NQwW+cpdZCeCvF9u2mvT/p0esleYfZr3TqZBSgUtKs?=
 =?us-ascii?Q?TDSL1wORalKhRvZMV/SHHYbCndY6Cusd7hfLPMEPFgAXtVdQesCKTPK1vXLs?=
 =?us-ascii?Q?og1nKmbA7aaaJGEVcNS2ctoEOuZ7200hX6WaPXFe0e3SKfrkjWOgEux7c1cT?=
 =?us-ascii?Q?MTkz9WZV7X9U+JZTApJMfATs0zlXa9OvJvL/xA/Z2JcP2knd9/vj9lQINKwm?=
 =?us-ascii?Q?4oZBOuKY8oasix/6acu3obbeAY0EHBuTrhLCxep6yOTGfpMD11rzwItwBWVM?=
 =?us-ascii?Q?uIAy+3aygIECmOSuCyFQYgBg6FyO3DMi19OvulnwmQAkYR42BFRygclo9CYp?=
 =?us-ascii?Q?mBtYyApmBgAzjipdq+P+AQoA20gYuZew/HwvTcMT4yy9kQSHfxX12Mh2jsip?=
 =?us-ascii?Q?Aa7HAmyhOwE/hzqLc2CZcLhDnluKn/t0vkHB/xA4z6HlXyH4ggfovSNa5FMX?=
 =?us-ascii?Q?3cdeDmXT/nQrQOf0Sa9f0HUJ4S4PvBANtOZcp5YoYmTIBbXvtBMYPZQV5S9D?=
 =?us-ascii?Q?5JmzTbyxp2T+o8pfOp0Rb+inkHhovEipkPjt4Jb/BizQe1cvg/TnsSWocek5?=
 =?us-ascii?Q?vyxjzXxRPeb0R4DmIuwHNc3aF+hPXfPRkzdlNLSObYMe29L+WWO3oOCDdJFN?=
 =?us-ascii?Q?E6wYMXpqqCU02X+d1sivVIxp2Kck43eL2/jWVNXuvbxgBuQuw6bvMb8sVqkF?=
 =?us-ascii?Q?LXLjUlSTi2MA+/vayXl2QISNo49o5pb7lGGAx6Uu12vlp21cHJ94e4Ck9K8s?=
 =?us-ascii?Q?IG0GQrVLplYTXStDYzYjudBki4Qwv2EX+0vKG2pt3pxUBG/CBuhJEKPrljsF?=
 =?us-ascii?Q?fW3FDsCMGC6koSkgjPAm/RAU/qGc0DiB41C9k8UPtl3JTVvC56krDEiFEmVr?=
 =?us-ascii?Q?z3Hq8sCy/xE=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?6ACiS9OlCYQYmdMtNSA+2AwDf2sFSEiNzt4FdPfNn8AeAkRwMlyYdWC+6B8q?=
 =?us-ascii?Q?ptwRXVbe6qd/dBWqLBnZVSwDgBPgMupmIojxc8dCArlQjPubsm+ar4HmU4Y7?=
 =?us-ascii?Q?r6v/FRaTvPukNvt5MCwjph9IPvRRhRULGBOOFEs5AL5Q9KKHyMy/4/YLPAU/?=
 =?us-ascii?Q?02EMcyA2cIMzAKUhpLZkvWctIKuQjg7xczT6ZPr2LjrAolPi2WEkh4GPBfFA?=
 =?us-ascii?Q?PUsvpQJLJz80TplDlo24iBiuTglKTNfk3OUiTuZWqW2/1mCggeiGiWOeB4PZ?=
 =?us-ascii?Q?xHTAsIG9Rdc/WL8ngMeSVNBzFQjgqvdp1D7d7BZbe73fha9qx/LywrMfoF40?=
 =?us-ascii?Q?2y7rPVcucfplHq3dsFMR1+y7MZgpyN+AbCfBsjcTvygYQayBRwwM0bvQgAVT?=
 =?us-ascii?Q?ANlZWkCJt9nh/gfNUY8s5v5Eu86Xkg9aCCG6cSahqAzU7ko5aEHB+snLbunV?=
 =?us-ascii?Q?dkPMSyjy5gfKcuTS38n6TBZl2vhT6EU+MAmdru7RaxscB88bSHVQaYB4yeja?=
 =?us-ascii?Q?wWIW8Uo9uBEwGyNB93CZL5zCuvrjY4USFcWoZebAJI67VI4mCel7ROtq32jq?=
 =?us-ascii?Q?DLKK76JC/Sbpsst1GrPOmLKZcw/r+OOMbAN+aKubzWR22Ozd8+oRNjTBReyd?=
 =?us-ascii?Q?+eOYggzOkdTybDnMHLTkBFuhlh5oZTnwkk1FBB2M4FOnWs8j4RuyRPPElxEe?=
 =?us-ascii?Q?8RWClIzYu7t6pMUO4Cpqk9btZroTT3pnv+5Zxcz0gP/Sj2yzevCDtyt88SIf?=
 =?us-ascii?Q?jYGg3If1L5nEZfg0eZJsx/RayzDjQoQCG5PArllOmB/INwIwwHtaMlvHzXe6?=
 =?us-ascii?Q?T5zVQogHOj60v5GdJVsozOg5Pst1RcoxSAAYnkkWasvdQKRnfLjOXRRczYEy?=
 =?us-ascii?Q?2fmJPrEw4jtHLeyabfk007EU7b0pvyx/FHpJmMesp57s0teIY+HbGamn1zLZ?=
 =?us-ascii?Q?1bMm9xPAePtM4leJCkqCmXZV0xZhnWiSF9z0d8TsghVh3AcWkZSk9dC6jFPj?=
 =?us-ascii?Q?Xh8fiw9mM+I0VlJ30CdDhPanEeG92yEXt+DTpJqu5hRjL0t1H4rcRFMMivbX?=
 =?us-ascii?Q?GnRH/5ntJWt6fa/lX/vYX+zWdySmQnyqut3A638X0XAl3nWXWuTnALnDs6so?=
 =?us-ascii?Q?UTJ/KsHePu3l7+/M+mWzIc6MNHKYGqLqfAr/32MIF/+sjRoqPNKZSIlTgB/5?=
 =?us-ascii?Q?bWTn2WHSRyA0Y8hmVyGkEKl1gomtV1XMKbWfKY38HjjYlgyGNgCu42rn/rft?=
 =?us-ascii?Q?amez7bUCcP5VBAJbuVFcSzs6zAXoHWLUZ+3IJG+Hd5KyPrpdfN1V5/9PzQ2R?=
 =?us-ascii?Q?4AS3Nbs41hlw4vWHjcnWEzE+W8kGsyDHCowNrPacK6AyXZGK/x6h3Z74IwuZ?=
 =?us-ascii?Q?GdzlrKK9AN0r2+R8MX0s4y7LNx573txR41kfnoNkpDJUc6gW8trn7bktROx4?=
 =?us-ascii?Q?/8dHq/ClfXIDpzKucP469eHu9KyooR0CdtY8QqjDp3l2mdRSdAfrsFrk0OT6?=
 =?us-ascii?Q?Cj7HryqtHlUW/+YxR8CBhY9YauE/YUAvCQ//ADkq3EsH0GeNPlUqPRixvqYq?=
 =?us-ascii?Q?p1dM7+hiopuA9I9/P4y6L9AcpvRY/+3trciT084L7Dn4XPY7UJsWgawqC18/?=
 =?us-ascii?Q?5g=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3313aa3-e5bd-4594-e2f7-08dd4aacdfde
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB8426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 15:00:50.9259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iAyJonFI1ThCpukYRJhC8MFT0ZJwsLiTB2Y036J/rDraW/DWfztpplT6V0JwNJFYERVb/uDe7tqhFwEtbb31OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9396
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 11 Feb 2025 15:01:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17193

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Add the variable SRC_URI_FILES to collect files whichs contains
additional SRC_URI lines.

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

 meta/conf/bitbake.conf | 1 +
 1 file changed, 1 insertion(+)

diff --git a/meta/conf/bitbake.conf b/meta/conf/bitbake.conf
index 8b607088c6..ed67500ba7 100644
--- a/meta/conf/bitbake.conf
+++ b/meta/conf/bitbake.conf
@@ -745,6 +745,7 @@ AUTOREV =3D "${@bb.fetch2.get_autorev(d)}"
 SRCPV =3D ""
=20
 SRC_URI =3D ""
+SRC_URI_FILES =3D ""
=20
 # Use pseudo as the fakeroot implementation
 PSEUDO_LOCALSTATEDIR ?=3D "${WORKDIR}/pseudo/"
--=20
2.39.5


