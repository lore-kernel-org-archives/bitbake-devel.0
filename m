Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E813C021A1
	for <webhook@archiver.kernel.org>; Fri,  7 Feb 2025 12:47:32 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.65.129])
 by mx.groups.io with SMTP id smtpd.web11.68552.1738932444338795086
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 07 Feb 2025 04:47:25 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=1sxN//oA;
 spf=pass (domain: weidmueller.com, ip: 52.101.65.129, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uiYTfEUa5wAnzVC6LquLjVV8qKMRU0yY1BtAPuemBBdEUkBnwrvdtW0PF+VEfWC0eoADTrTEbXbRbKk0liBJZbg658KcwBw0xv9KgsomqeLIEC4GZhACWjeT1Tyz5/djHQQ7eywZ0UUoYRxywjgDNl6xwQCvcOBnmfLg9zJ/gzfEi5Skg9jNCRYQCEZKKhPsrrs67oB8P9CWBLswBYeuGLv3yt3RsPHR7Ewh2Cs+2XsMRldohyeHbk6xmKZWrNNQzUri/nwKZqkFm8RwVIrysczMDMsU5vgHHcoC/20Cqr4F7DouCuuFFoar9C8n13vfKZ/Gn4Cx44BXF29Bum9ntQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mFrsIDCTznAVEwj2pHqE7g4ibZPXvKg12zDmzt3unP0=;
 b=Vnd02Ry9zQRJgtiZ6LojbyhwcSEgmtQTf1DUeN0LfcRj/AcPyYSNwtLJ92DncX8r5lP9ZtAvbQuo9yur5JaBswT8oaLs/8yLkVksyxMtUEhZWSQw26yaMI8L5oS/a0NTB3VKQ1lTWvMlRDXOHNVYO/e11hLdkberZkQvLHRI8JcpYg5hwKvolx863gYvTw1pxzX0imDJuLY7Db8ImFkcTcJFtFvqb4wjk8tYUtEzKRwiyFKXRzL4aMaFzicrEEIHvwpzjlnUffIEGs2ErZ1HO/lwn/iWj6iGorN+yrGrJDGPCHGEABdjbRcUHUX3TqjGOQu/oUWpNripMkcD4JPTQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mFrsIDCTznAVEwj2pHqE7g4ibZPXvKg12zDmzt3unP0=;
 b=1sxN//oAnhff8z8x4swFWfxCF2E4sytrYEXfoy2T8sQYTFhPm30SZRVDSdaF01GzpfYrI76YLbbFJz1hoiSSgQiv67l2llaH2GiJ4dbmkT0V1PWEmg0IQFsJbwfw7gRFiY6mcMCD2pS0MLNLo816DpzJKnrGMn21h+sipHsVd1mp601qM12xQxfvDi7ZWkFj+dveTUU+PRKdRRojTJWkiSvrLWlwqtAoFB50GjiK6DXk9coCNQ0LkzdOSiyR+ExAVzFOvjtWogHLP4iapOUnAt+r9rtoG+EZ94mIgYC9dcfIh96T8lbUk81cx+bbNH7Jx2EUURgaFoqzq3JdzV39gA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com (2603:10a6:150:8a::17)
 by AS8PR08MB6390.eurprd08.prod.outlook.com (2603:10a6:20b:31b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Fri, 7 Feb
 2025 12:47:17 +0000
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013]) by GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013%7]) with mapi id 15.20.8422.011; Fri, 7 Feb 2025
 12:47:17 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH 09/13] fetch2: ssh: use common localpath handling
Date: Fri,  7 Feb 2025 13:46:57 +0100
Message-ID: <20250207124701.14787-9-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250207124701.14787-1-stefan.herbrechtsmeier-oss@weidmueller.com>
References: <20250207124701.14787-1-stefan.herbrechtsmeier-oss@weidmueller.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0177.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::13) To GV1PR08MB8426.eurprd08.prod.outlook.com
 (2603:10a6:150:8a::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR08MB8426:EE_|AS8PR08MB6390:EE_
X-MS-Office365-Filtering-Correlation-Id: 93d8bb24-f5f4-43c8-21d0-08dd47758d71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?BvTxo02BmoYARnEhSHSGxNDZ2Pxy1W12KMjJCgMFWIIUnLaslpsb2J0MyJxw?=
 =?us-ascii?Q?pZIk03GUEIvG7j54QPIN+A57gjHcB5ck6Jym4Rt5FVUPalgV8jF8qpLPbkFl?=
 =?us-ascii?Q?yjjs6xh7skjOpcWAPPwGBVzSYv6OAbTNR87x7Lan3hIybcMp0C+b5O31HSEZ?=
 =?us-ascii?Q?gqcW+Ap89Rdgtl4EwCro5vmJXneh9u2PnfvquxzP10DKXuQydE/Pi+JECoMV?=
 =?us-ascii?Q?nJt6Z/0cL6g5YJJ1g4nP310WXKIt7MENKOfRgCqzO1R8LTYhE1Bhvcbh8bfM?=
 =?us-ascii?Q?qMXvuEpaUG4dZ+5zpixFU1CYXXfP3OiB7LspayRTMRPl36YS1WItMtrN3O9y?=
 =?us-ascii?Q?xVhB0dp7Qexk0up6N1Ed453rxclBR4z0ZsDLVbfOnvh31qJAStc73VOFa+WR?=
 =?us-ascii?Q?7MlOxEtjXy8q8b439tkNpKKS9TQRej8JM9qdsxQxkeKaIYwy52MtNufT/mSB?=
 =?us-ascii?Q?5cvDd/6HV9wRA06nV72aOMtvGOeEkf4N+6r3UJb67GvabeIAR/MObeTSDUhk?=
 =?us-ascii?Q?ijqAr5+7z3dJ5Zez/fv7x4SUlDyfEWqk/HbcqOsoXLaHw8CQXSn9dmXb0IuE?=
 =?us-ascii?Q?TBxFMy5bmNPxQHfaRwHrdunGv7OY/7KrvqqoDntK5I6+1tqWbeOhJgGi6YAh?=
 =?us-ascii?Q?7slH24iyNqEOOf46/y7YgjyDDRFN1sxnHCoPp7LgssBizLAUwmzjnveZ/960?=
 =?us-ascii?Q?F4PMPyZ6dYwRiWgphjjBI0ZxDAvmaX/YN3hUrfsAVfo/np7C8uKMhRiuoqJO?=
 =?us-ascii?Q?PywD6FiJuOobJdXGsrrOK0E4iw1NcF6liU6aceH6QSppvpDKpQen+X1zJIeY?=
 =?us-ascii?Q?9XzpsrkxM8ZGfCchifCZ8OnZOc4Q+oPj1TSbKxIYB1i4UEfulYxqYH/CU5H2?=
 =?us-ascii?Q?V5TXfSz0P1Q3Ny8u+wGNxs/QfsWtLCWlVIVGm3KTydYxJx5mAqJEoHcv+8iy?=
 =?us-ascii?Q?PVyyDf67aEKo3lUFTaBBLYscMmhfk9Hf/Lm6lCOrK/8WtoWQefa9F0uL39kG?=
 =?us-ascii?Q?cnH6UjpabuBo872uFVCavpwKIk9vjh9L7j8sGZDep71Hhd+Z9n07yukPNizA?=
 =?us-ascii?Q?/MzIx9Uo8Bir8MBOf5cXt0dnfN/pe/7WvQzk/5MrKnMOYz7n0djLh7VlCpq5?=
 =?us-ascii?Q?uYVljudrVAvjk8LTwSwuEti1VU4vuTqzlHUU7DilPioEeZ7FXzqpXRD8Iyjk?=
 =?us-ascii?Q?hUbZNaMpxk3xGiwA9SEOt4NWbfVpAPpJRooG3c8YUfcb2yKW83YcpctDITPD?=
 =?us-ascii?Q?d9Kk1woa6kfnUevfdRah3gEk0TpjPjIGiLDMeF37LmIVy5NVu671ZCT6yONb?=
 =?us-ascii?Q?EukD27Oxu48aKc+a4lxrQdqaxN07n4t/stMPmfymNNnP6/7oXA2Ou/DurUUX?=
 =?us-ascii?Q?qZpdVlA2r6nBI8zfkG5SxMqySQRlbDGWGj3rMbiicrE5m+4vJPYNvByJEjEw?=
 =?us-ascii?Q?2xsEtLGwWP0Cep5EZHfNBlpDPfEK7wQz?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?E2u0LjOzyWf18kJkcuFkkzvKrYLYzZ6Z2E8Lp0Zryqfj0ImzwlbB80eUMcv1?=
 =?us-ascii?Q?c9E85TLOvS+gCv4UKWkoKNGjjeSEFcAaP+GCRZQG9mPXCb4WDMNz4Hu0AEqx?=
 =?us-ascii?Q?mhbLtStEANNTDvQv/ETlda/FmM/NPuegO+uMSGPUxuXIS4k/axnc4cKSyz1g?=
 =?us-ascii?Q?4jLNPaRnYPmuQ4yP17HtiuVYsU0jbmXkWVrBvmzC0t60K0XHkXNSzOJUQyLL?=
 =?us-ascii?Q?SQKh3wrFP9U48ntvrzwE1DO4gokr3jFXIY2T+RAagNC6Tla9WKuHCknrTDBq?=
 =?us-ascii?Q?y39gxrkKNYRm4SQOjiYDwDBlFJBu0hUrsC3f4DZ89UUpLEL5y11qnjdh2ZEq?=
 =?us-ascii?Q?gu/cDgyTDXGj1ufYSamL8T9khJCgfrtALfMTjtWKRNfelvMKmqs6Ls7bFueX?=
 =?us-ascii?Q?9bRQKqEptQZzxxTfGX6HSWaTJkNpxmuHSqrxCjPexN7H4GPixTxdHWwLasWU?=
 =?us-ascii?Q?6mJWqJpdSLBU0R7nXk76YcOtcmRmZh01opjZZ+UtaQF3W8TYOzmba7pAt7KF?=
 =?us-ascii?Q?OXpVp41NrACEGSQgi9B93VmHD5uCyPtKJ9KYSia4QlUQ6rikG78H54JCY9ja?=
 =?us-ascii?Q?rfYfo4QH/hyiWQLy47G/2j+o9a4dBlWOVOMjhN1drnY7MaufsNNxc26YTdjD?=
 =?us-ascii?Q?vCvQyN7sAViakEdj8fRFIeQqB99vk8r/tRvnIWofgqHSbQWj4SgTOccfLl5O?=
 =?us-ascii?Q?upVVdScB8pCxu2c8XrXhpUXU1G0wkBkYHm8zU4gc9c300a+j4bKYmRzQJIoN?=
 =?us-ascii?Q?ZWgXFc8+ED2PKVRV2sT9wGrrr8ZIWrHH/1kuMBYKUkM9IfK8/cj4N636sg63?=
 =?us-ascii?Q?YXc9ZnA2c6mqnj9r63L6A+N13nS1g/rQvyle+sPoDx4azDnrgOjQMsRfJXmr?=
 =?us-ascii?Q?LKWg8dINvZpKvVMrHhkViW6ABdXEwUqvVCivfOoNBdR4tHi89FidgHtQeBo/?=
 =?us-ascii?Q?4zfYKu3tJH4nzhKeOyc/zaTVkWFfTVm4JzJu34CLkwt1gPxxiQ+cjobIm/ci?=
 =?us-ascii?Q?61JnFPUsMttGmXMBUr5mG7U5WaIe0M68Y4o/w8DiTk5+A9XIz7WylrYCTSbe?=
 =?us-ascii?Q?sAIcS9xx+TviwJVOb9oD7Yxm8OARlXEStUw5hSAm66WDF1UoZmU+1q4L5Irb?=
 =?us-ascii?Q?BMGbKq0U3MRMVgLGdm4nAYtJ+aeTlMFOa6qO69B5YdJS/i+05yAR9vZP9QTb?=
 =?us-ascii?Q?k1MzY4lu4f8dXsOpNYRmPhljnNQZE3c5OIIu8vc6RwtKqBujAur9XcUaSEHD?=
 =?us-ascii?Q?A2pkCa5TZaJCbSRUUrGWiWmjF7DCVANEtV0qQ20lffarG2hJ1OASY5y+xv8O?=
 =?us-ascii?Q?N2tVL+BCvsGJPZdUFKgoHBZC71uaTT00IIctYI0qSsBBlpBzFlalJj3r2LfB?=
 =?us-ascii?Q?Bjm0edSFQ3iNZXMfUM/bgTe4aS/iNjQDTTy7+TG07wzDDm9Iy6aL68cckrl+?=
 =?us-ascii?Q?fHT/76quFgOV5LWbaHBqN3TyAZgwoz3cnI+jKRWuaxfCuqNcdQ9qFpPBDXiq?=
 =?us-ascii?Q?XvThmev7Gy9MySVsRWzQ85JzpFcut07w9sThFx+XmsHYm/B4JNOZPMkAXX7M?=
 =?us-ascii?Q?/3zORZ4uodGc1xxQXyCChguuloMhD0KzB8tB+UNpWpw1muXBpq6qUe1iX8jB?=
 =?us-ascii?Q?8w=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93d8bb24-f5f4-43c8-21d0-08dd47758d71
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB8426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 12:47:16.8398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VdLEtluksHLV/DzyS6hv9HFWTpPaXLPDdbk58JHxE48HMNkjz3Llo1TmiYWA+Z7lssqSkgM9cg1siKNOiagoIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6390
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 07 Feb 2025 12:47:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17177

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

 lib/bb/fetch2/ssh.py | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/ssh.py b/lib/bb/fetch2/ssh.py
index 0cbb2a6f2..2a0f2cb44 100644
--- a/lib/bb/fetch2/ssh.py
+++ b/lib/bb/fetch2/ssh.py
@@ -73,8 +73,7 @@ class SSH(FetchMethod):
         path =3D m.group('path')
         path =3D urllib.parse.unquote(path)
         host =3D m.group('host')
-        urldata.localpath =3D os.path.join(d.getVar('DL_DIR'),
-                os.path.basename(os.path.normpath(path)))
+        urldata.localfile =3D os.path.basename(os.path.normpath(path))
=20
     def download(self, urldata, d):
         dldir =3D d.getVar('DL_DIR')
--=20
2.39.5


