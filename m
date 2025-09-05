Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D0FCCA101F
	for <webhook@archiver.kernel.org>; Fri,  5 Sep 2025 06:21:24 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.84])
 by mx.groups.io with SMTP id smtpd.web10.14988.1757053280733913428
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 04 Sep 2025 23:21:21 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=aG0isQGz;
 spf=pass (domain: weidmueller.com, ip: 52.101.72.84, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m4ROy7WUulZfvQd6kwjGcJ+9qIxARkApILg3/hOIvw8FxXvA1bBcyPCGgxtYQpgKTyj6eYI+wHDOftqjTE+bJT0F4zxAjbJiROsdopooMqfdNjT/AWfqNIguxpzTMY0/6CwxOW2wnNEdHtURwBMaO+WZhdsmox9KpRGnr7P5FvFMgIiKDPPxvJpyooOkwGKVOLnkttPNLzA9h0qkCExZ2ffhbPZkRJF8xT1uTJBSWUJBQAVK+L0z9gMiosKIsMdMcz1r2OJwB1e0fC1Ic1WEVX3KE5keATPm2/ok2DNn5JZB00PYFQ51qH3WYcs7wExbNQH+sS1s5cfSAPBiEIQG1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iD3fh7d6OR6zVRSu9/npCp2oB11IYdLrmDPqQnjPijY=;
 b=PdItO53uNG7T2l3doNjLn1BtihRv7/AfMEkgPaDx9z5w4CdeHOnMNbY09ekj42DyQ9uWDZEv7tTUXifYatPGK90MLFP3PMxBbM7g5MScHkpVNW/5siAuwFJFcKiJHJxQWj4b5Hu34CSes76KqtFnTFoHk7QgbCJvC1/RBLA7WmHHa0ki/j97MftgPoemO1Haud12fRw6dFhDO07rU6QZy6bGkMbpoCNhaSkxOLPT6Lm/pbk4qyHi2wUmCeg+qWKAcE1QHIGSmkzwt2E1p7F/weOQqlDRNoKT20d3Y+t9i79kjHsJXJ/+ST0y5czIZFvrz6nUCjwDLXdzuhU4XzdLog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iD3fh7d6OR6zVRSu9/npCp2oB11IYdLrmDPqQnjPijY=;
 b=aG0isQGzRZBHRG+FjjNhE19CBf/KHySmOzpLWM1jzEiA/pmAOE/LTH4EJVjndYBRgJeOjn00DuSgG5GjVIh6tvGO4WTFOh5kig7CL0kCt7bnQ21q1oIWqlTNvce8q7ErD85uGA0wqqqiLX+GopjHocJgD/x4EEXT+3J2ygmuzcGcVC/Mxg7f3r+IGVhhv04runYzI3jSiQSqn37oSwV05XqZQsuJ61ugJCKIUum3OIqPuUC8n0t4kElnP87J63HedByediafqy/8BxvLR5masbmmBNfIzoRyPE3Y6M8qMCNVzlFCiozmZU3NIZvsdJadvfZpxPkPDRXJnzkJf4Z8jw==
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
Subject: [PATCH v2 06/15] fetch2: gitsm: remove needless SRCREV_FORMAT override
Date: Fri,  5 Sep 2025 08:20:49 +0200
Message-ID: <20250905062058.2563806-7-stefan.herbrechtsmeier-oss@weidmueller.com>
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
X-MS-Office365-Filtering-Correlation-Id: 77dbbf9f-5b70-4e23-9463-08ddec4468ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?QkPeuC+S32hWKE9A5E0fotha8pcsic8RMPVl56FFJCYB0QXiMP7z8qlSZbIs?=
 =?us-ascii?Q?Yqp3La1hdfZEsDQ5yRJWo7SqlEW1P13anHQMVZOghi51y5g9NbTn76Gzny9Q?=
 =?us-ascii?Q?bIi0Z8rS5JvAKMRGDaIJwfmyD7/pQOan5/aJDPRuaouDWZklgFWxSpuelV7J?=
 =?us-ascii?Q?TfyeF0RVG4wqHD5FxlBccm+GN1NVLOkyt05uuQnHJoxT6CCHJJEKWGhw1H2r?=
 =?us-ascii?Q?zlGjfYvxuo8nO5w3fC8AGSgdoqTiGHzWLX3U/IC+avoRezpgTyK6jp4r/E4p?=
 =?us-ascii?Q?9HMr2tRS7Xy6i08Sua34diSt03gEFbyq0S6yxUOCKw4NFCHIB7JFOkA5G3EN?=
 =?us-ascii?Q?W+XZ6WKgYQVdcHjepq8UXaT8FMAJE3LOkX+vegJmM83McUoxI1l/k4KWYgUa?=
 =?us-ascii?Q?+xN9mGB9xJ8GPTe82Bbc0GsSymNi7vn+GL52cndvOdzo7e+UQnTFqWy8kl1N?=
 =?us-ascii?Q?z4mlRa2Gnhecicp4HSYQN/fSPGDknuJaau8KCsniUevg41w+RCgejBcMVeIw?=
 =?us-ascii?Q?2XfYgkIbUViAvVoWdH8+LH544750PXQ+0jsbHLGUSkHBNyJT1DF3WUSmvTO6?=
 =?us-ascii?Q?65e8v1CBlndNQlzkbxTlQD0AQNnvjAm9qFk4S5rsWb+I1ZtC+R7NUXKoFwoj?=
 =?us-ascii?Q?uHFgT4tInRKXqmaGWXRMo9CRZ/J9L3Zxr2JhYrOgJlcckQ+muPozB52ZMDyv?=
 =?us-ascii?Q?Q1e1oXEJo8YIPKpVt1PPyuwjKXJpFonQz0xDc9LFV1uNA8oDZZG42wKMzyiy?=
 =?us-ascii?Q?GQ9PlCaugtYDDAh/6Yq3GN0s4sq0PwodVgT7E/4xYE7i86p9i7JaE3WO1x3F?=
 =?us-ascii?Q?VEH5WWGEl7MdiMQgHU7NK4f21p2KdpLI7xB+7F5vI2OSAzr/JeFT8qHUMYrL?=
 =?us-ascii?Q?vyIH66ODIk74kBiv9Rvfrb6j9L0ooxh+YQ1AF2DgRhKIBURnFZMDxlTsYY1z?=
 =?us-ascii?Q?ssABCOQckudTyTYE8NS6wIbuB/KCxBr1FP9mK1wIiQfKvOcuV7rq0KfikB/B?=
 =?us-ascii?Q?Nqy3XW+dmA9eJvXw+YOy/9bDiLIdQqxP2yH/y1805FhnkHbIQes+hXXRSj7F?=
 =?us-ascii?Q?0DrL/bpzbeI1DeJuAwrUmQ1EwYYR9EPS695RCD7lxps8PHq3i4zBsjdrwiWb?=
 =?us-ascii?Q?H+FsusjlcYd+FgVvsYj1RLbETqSBZ2ENbrqfseNKBuHoeFdgtxT5CLZmcU/Y?=
 =?us-ascii?Q?KaufNJJVTsijBXkMOXJVPYTIcKSsOSMGkxTEBRXj1ourQJHcZARxqiGwtjqW?=
 =?us-ascii?Q?ShKFqAJxr+JsnRApkL4/iTpayjdCiUewS3MMunOhoRN4iASOkXoP/fdB0lBn?=
 =?us-ascii?Q?x+jlbmKqHrJhWEANA4n5hGklVAV7CSpCS0XuriL1PORwUyQbevxoJcCncfxx?=
 =?us-ascii?Q?0blx+qGUHQRHryD4q3dysFH4RGpEf16G74ZoRO2gUjsgabP6va10tXSWfRB7?=
 =?us-ascii?Q?Klbveznf7mFS/9vd3b4PzRXWe5FVP9CwR07CYXVQq8+6m3zKalbqNA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB8422.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?dn1JzoCW2GsyDPzIg5fn9fsUF553RW/c26FlHYg1xX50AIZY/1+l4KBaj5HY?=
 =?us-ascii?Q?8MlyenaRUz5M79BNuO/Vka+dWcKe9X9FzxWDxEFqc79ITTCcL2o2B44ATjQc?=
 =?us-ascii?Q?oQCnqEID6vp6GqvmRGQS3EiciHvrajL+L3W31C4TCUwOP75B0t4TVQuNSG4y?=
 =?us-ascii?Q?AxokP2CbiFEqoKhJmutkazLTxaFIjk5XZzw7O+IlXphwsUQ5N/wIuSpl9JjW?=
 =?us-ascii?Q?OZESU0PcrMbUM2bBwFhVbwThA7k8wKYSq13TT7mLTur51fanLqLpN1NMzvlw?=
 =?us-ascii?Q?fH6KYfuFoiRpsMwn6alm2D2c0ooIL83WtFYSKh0okk+6boL3XNqmktSmNC9B?=
 =?us-ascii?Q?mFGM76lDDJcFCF+1ZqEgw84Agc1CqUd+xhQaQJaUQTOjjfhC3Fz4SuzD2CPb?=
 =?us-ascii?Q?O/W6Fw/8SPo0zpv8UvUuqcRo5em93JYVjZJiOmEs7Mwgq66w7cig2uFsRI09?=
 =?us-ascii?Q?fI8hUr3AlGcrccMrCgp/mMW2sDWM7o86ZsVwopMlFiDv6fqAJdEvfxHiUo1w?=
 =?us-ascii?Q?8nRJUBP1+frV6WMuIAbzSDL4xPP7DXycw5ORizZ7CNKZea/QdQ3N81E4Z21D?=
 =?us-ascii?Q?Y8kyeQN2KUb6pTr5E9+3I99NRRVNnXFg97bJPKDjHqqz7ZfaojghySGeEY82?=
 =?us-ascii?Q?TWo/3zrk76rCzSyEgL1BSlKeKKorxk4DtCgbtadsMiCPcNaojDj5+clkAikG?=
 =?us-ascii?Q?qURAiRdlqNofomWYseXDUYgAQLev0wg7a+GdIqzbiOWV5VqB45LZhBAYaYdo?=
 =?us-ascii?Q?OpGgXAdwC2v/ClzOGeGfmbKYai8WAlx62Cl4hS05muHYoaXrfGYhByeAe4uA?=
 =?us-ascii?Q?SebjWfh0vIreDDHjKKBUjc5MIYTmnswg59wu+upRYFM/ZgkM6wsncaE4iOPk?=
 =?us-ascii?Q?L0iNv6OtZoBwqfXukkd/aw7ks9Sv8is6nHLG4Do6U67MbNA9TCfXxjX/XXF/?=
 =?us-ascii?Q?AwfI7lefKhKIc2j/mNLapjpf0tkcnR/aLazu2C9Y15QozJUsQOUifUsDX4/N?=
 =?us-ascii?Q?CcVOrouGMaR/ujuyx+PprEmQ2h7qhY9bNi5vUqWIhfU/JWRYDEYVA4R3Nubp?=
 =?us-ascii?Q?VGL5BxDAkL5aVguuk73QvKWxRrnue0IPZpC74nN+/NtJ1TLR09IOwhjgO0C7?=
 =?us-ascii?Q?KFKyK5/k/35B++Fngmrw227Fk3aOsWEnEsUQr5y94zSm3RXKVW5tOXCGjflE?=
 =?us-ascii?Q?/4CIU01yhPR5ZV9WQ7KsSyxExN4M3CFDO4gJ/Plf8Vz4qhNqR8/CXFbGbY4R?=
 =?us-ascii?Q?LBdvuSIhy66LTBLW/6Ls3VvOZlX4KjDDATIgmjXYryKYLe3hyOx+vw6xGB0i?=
 =?us-ascii?Q?ShbMwJ3xyNt43Mt2Qtai+HLZWnuvjqUAzqlrqP+VWzVbaGbDQ7nFGcJUqan/?=
 =?us-ascii?Q?n02tlGMZ5dsWg2LbvtMw7Vwz5EzH6Jc/kqlV9oeE0fd1sSoNrHh5IoRmhd3E?=
 =?us-ascii?Q?IMWQjsRX4nZoNsYztO27gIhBgD6b385GCr/27L1F0kKy4bxYp8Nz484HcbVK?=
 =?us-ascii?Q?ghkguso+/IMnsZcqVxSPYj2d3fAoCD0wPcGp7C4CA+GqNRdcsSFG/3E6ihTQ?=
 =?us-ascii?Q?KRaDs62VbjNwQ04C4F3RrllIFus1kyPiLCXNQU0TtzftPzEOaJUTrq/urjbw?=
 =?us-ascii?Q?lw=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77dbbf9f-5b70-4e23-9463-08ddec4468ff
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB8422.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 06:21:12.1985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TWhXqGS5X/r5asifJhUvfrnjAIFnLnFMg7xGyIapqyCWQDqZAqhFoYzoR4WJ6gAr0Cviw7QUwlmuToNqbTUQ5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9632
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 05 Sep 2025 06:21:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17966

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Remove the SRCREV_FORMAT because it is only used together with the
SRC_URI and not implicit URLs.

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

(no changes since v1)

 lib/bb/fetch2/gitsm.py | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index 15b9c3740..bda9864ee 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -136,11 +136,6 @@ class GitSM(Git):
             #ld.setVar('SRC_URI', url)
             ld.setVar('SRCREV_%s' % module, subrevision[module])
=20
-            # Workaround for issues with SRCPV/SRCREV_FORMAT errors
-            # error refer to 'multiple' repositories.  Only the repository
-            # in the original SRC_URI actually matters...
-            ld.setVar('SRCREV_FORMAT', module)
-
             function(ud, url, module, paths[module], workdir, ld)
=20
         return submodules !=3D []
--=20
2.39.5


