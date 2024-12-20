Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67950E77193
	for <webhook@archiver.kernel.org>; Fri, 20 Dec 2024 11:26:41 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.118])
 by mx.groups.io with SMTP id smtpd.web11.149744.1734693993154756588
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 20 Dec 2024 03:26:36 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=LRjoLvN5;
 spf=pass (domain: weidmueller.com, ip: 40.107.20.118, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RrM1i3C+Lb5DZZaZW+wDGjxNhc8rEgHvvfBzKkQ4EpYTT29ThZGQQU57ByfUasfKBAQm+boX9ROIw7U/9BdRv4sxJArwmiGQp85NZ9qGnQn6YLrBJg0HH2ZG9+sudoRq5aL5Jl6qifLsqK/Wp7fI8wgR/KaTGIxEbtw82/2/jow2Dgqlxq847VV+cXM2s34jElyatfu3Rd9NiHIvuxWx5omlYbY+BGD/LAeEjQ/ql9d7PqeZokyVKWnieSpNvYord5a666JgC5JrT121CJlGCUWyq3OqVKzD8uvcIQdxxEE6IOJWAh+tcGmkolWTHgMxlfxqpXP3VnZXT1RE7uV0ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rtxu4K68iSifp91eIigTtftCNZ8EYP0hKlTQRlFBAAQ=;
 b=w5uWz60RF1aBw43fJuaHaXeO7A/+AQf7IOa96dvDC0y9x0Wo85qUfQiUqlpZOtEP6bFOp/X6FEyZ+I3F3+4hM+j9U5zFU8sdR+eIIvM64SstOXCtkSKIm6uzTflzRjqaSEoh7T5IoI89KLblVMOgS9NlVSToO6K4p0TPqVp9TCHEdJxcAGkV7/shPOmiCzOsgT5UvekfGiyOd1PxSv+XUaFsyfzSsDd0t30xEyQC0wlTY3Mnw9yN5agd+ly6YxESBoFWd6iZWJ6B6r93sjEf1Vy1hNYACSwNrCPRq09Pk6B/dHlJVbmixo8nC8Ey//cIW2yQabSacM32mw5atY0fnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rtxu4K68iSifp91eIigTtftCNZ8EYP0hKlTQRlFBAAQ=;
 b=LRjoLvN59UdSAgkNxZNd6HbwYsn1hjnB+aywgvp9vTEqQ7YPZt1iQ+roCGuKQVbnaB6DsXXKl25VKtDB9dh5JcANmeWgQzyVIB6PRExEz2q61CNQ4cYcTvcPremFhnfyJ9LqcwIyASBMzsavWz9KYJyX61+RJYca8+0SnLSzFsnxt21PHXp3uLj+LpIrh/0dj7oGlhXUb6P8HoQzAnX4X7EKYpNcbjZ2XFHOdQoQPUImUpbOkPYH+nKJd8DzCcbISFHHlKWjxp0SOx1XjvYrVrHl33xa/Br2hsu28wednsGJB7x3zoP2+uS68Ql3qj1EyTGkYoKAg/h4P63TZl5aTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com (2603:10a6:102:1d8::23)
 by DU0PR08MB8256.eurprd08.prod.outlook.com (2603:10a6:10:410::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.14; Fri, 20 Dec
 2024 11:26:29 +0000
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4]) by PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4%3]) with mapi id 15.20.8272.013; Fri, 20 Dec 2024
 11:26:29 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [RFC PATCH 12/21] tests: fetch: move npmsw test cases into npmsw test class
Date: Fri, 20 Dec 2024 12:26:03 +0100
Message-ID: <20241220112613.22647-13-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241220112613.22647-1-stefan.herbrechtsmeier-oss@weidmueller.com>
References: <20241220112613.22647-1-stefan.herbrechtsmeier-oss@weidmueller.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0106.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::7) To PAXPR08MB6969.eurprd08.prod.outlook.com
 (2603:10a6:102:1d8::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6969:EE_|DU0PR08MB8256:EE_
X-MS-Office365-Filtering-Correlation-Id: b2ca5c72-67b4-494b-b5c4-08dd20e9252b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|52116014|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?J69v0c547JXxFA/IEyXTFtHbN/siwYYyw2zPza8+y4YF0Z4FCMeYhvs1kE5u?=
 =?us-ascii?Q?bTLS8ShtalqQZ6LsJA93j0owf0IG67Yuq1HOZQy/W2/u+kDsbJGf/xF4pboj?=
 =?us-ascii?Q?JayD9eUHVxQ9e6Jfaft4Hwubb/yNsUoGDp/ygqNozjzkoXoq3HzKpsHcgEF0?=
 =?us-ascii?Q?BIgoVO+JEfDCiA6hlmDy1hopI5Ml9ZkJMCdtNk0iF4p27PuhbDqUY4TXR49N?=
 =?us-ascii?Q?qnoMMuQ5k6lR0WhiX46KiseaTWvFfobOBR7TL6JinY+na5OZ3ArTTPr0TG0Q?=
 =?us-ascii?Q?vKYNGP23+XKkVuMTjjFrFEHqdxskPe9EC6M1GBb9hSRBGafmrgD4RKT0t3eZ?=
 =?us-ascii?Q?gp/DCpE4cFmELSMuapOAMcGKIg3h1NLme9+JDB2kcueebwAT4bZRWVcui/fZ?=
 =?us-ascii?Q?qCqbq9E0HGXHxF73UuJCFn6TVoO3ATwu1lK1bXcDBnt71HGOmZQ2vx5uU+OT?=
 =?us-ascii?Q?h6mQ4fM7E08tKzg3wpvvbLR86Ut3/Bwf0pseZW/SlXD/mQYcbRtWgYSWspe/?=
 =?us-ascii?Q?vT6OBEmnnIReX+cKPjYwXWdqHnWwUnzV7YSTEWAn0CD+SmF8rU3kFb+Ide6Y?=
 =?us-ascii?Q?09KlaZuhTwny92drCG+1Jydl7WJaAipfALSpBEdtUkWlf4fJmG6ErbXu5c2Y?=
 =?us-ascii?Q?6BDNP/TLcnmieRdXVRw+N3datrC7H650TRvklRAShHPlmF9NKWjrUPusKvEL?=
 =?us-ascii?Q?Zfqrs8tIeqozzcZIs1nquK9USX0woB1eHLF2eFdJ6yogxith6ZbbMpXW3ZEW?=
 =?us-ascii?Q?6/oxLypyIEi93EM6i3a2vC4am2DSufV53N8iZCLWAH34qqjCpf5Dyjc+l4Zj?=
 =?us-ascii?Q?/0LtNTpC/A1Hmfje8PnDX1m6iPuenxlOmtbRY/6iIXhlBhbEOB/M2si993Nw?=
 =?us-ascii?Q?Obm2QcbzyjlX1yHhcf3ZiVgZQkOKAIarcOB31WZVtMqNuG82NobmH/Yz05h+?=
 =?us-ascii?Q?3VfiHTV+AMOp+Uy7EgzVLs/oBj4ZvpNfJaPMo/aq4BKQta74Sc+plThDF1Ia?=
 =?us-ascii?Q?fIChdK9aV89hhnynLsCnXxP88IX5BZL7NPcLCguxRPtqocJMvmz9olK5JX7r?=
 =?us-ascii?Q?i5+5tVMwqDGnZ6alOOUy+Uzc+eLnm/S2KdPpUyiIBAR+C0Ty566pBFlBAH8Y?=
 =?us-ascii?Q?sHS7GVxKL3c7gnguDwqxP5dKvqTATpBzj4tAPoeYEkF5J9imbPJQhIV+Vj13?=
 =?us-ascii?Q?bGFXOiATWNgbnAIIuyGeohqHXopena+lp054hj2myJndrBDkh+GW5NLUqPCy?=
 =?us-ascii?Q?0xgbhweE0/WOjvb23/lrIPVuHf8T+eMPJOyV6AH+Y6abHjzYI5NGYrO+sqIB?=
 =?us-ascii?Q?0l9D4bzUpwnjpAw10v+8oSoi6wgDNp98JTrT/S72Z7fqolnSfUC2pnZ+kkMT?=
 =?us-ascii?Q?+oxkOa99W8CiYbaQMbQzzfpdMX3LWucrIYQdcDEMyZBbEcHas0BwaYuO/yeK?=
 =?us-ascii?Q?ev8hQRcLF9MuGyaEnggjOz+3s7y+9hzR?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6969.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?weU/ggV+xQ4Z/Jc5mrWbp/+dtnPVy+mknutV+p6thiBGoAkx72LAq7HUKOBr?=
 =?us-ascii?Q?wVc4D1Fd710aqDg5QqtRkeDSEFvdZb7J1E0brMkUO+lvUFBEJwdHxHMAByRy?=
 =?us-ascii?Q?FY0GAWcxkzUlUZWYQKFIspZ2LhzXNmhYw5uMM1RCRB2PkHqQnWl3S4HCF9CK?=
 =?us-ascii?Q?GZqwOcMSgHxUfw05Ng5bz+tTIEo2N3qvml30yyLBHfdJLS5QH2/lYAUAOLyX?=
 =?us-ascii?Q?cwTSxnuCfNlIXdcPY0+8I4Dfxxrhp5NhieCubAhw385sf+zixZRJAbxVAVoY?=
 =?us-ascii?Q?4+cVXqbFJ2CL0V8CRI+ORpuIwtcgwxF0UxGqitBGLhtzNO9PO46IunIm2NrO?=
 =?us-ascii?Q?uEC7FBAz3/ciZITLmaF4+kbr/DOQAXFnDUUJdJX8+COvlzJ2nhfq1VLT22De?=
 =?us-ascii?Q?/iqMa5+qAhAy0VEvj0GDEh94eXxHalnQdZa51dRH4CLMw3zyHd+6LkROWbrJ?=
 =?us-ascii?Q?h7iLPBYSxbH9RyoiXbRRHO8YB3wnzsNXsQNEjteBxIV3LBtir8f7jIYGrbwV?=
 =?us-ascii?Q?pxEE7grl2ZHako+OqNGGt1cCh91EEyUU2HtD/ccN8GNpF1S+vtSDucYcdz+k?=
 =?us-ascii?Q?8RJ2FkETRD9qU4WNYApwkJEKE9T6VjjBUH2zHaBAtzrrUiECeqmF1k3NTrLj?=
 =?us-ascii?Q?4cX9Id3NnVhRMK09Bv3+upWKsfcr2uXMatzQwHz520Fz/gHfFCpEANEFm/Bg?=
 =?us-ascii?Q?aFlIt7YhSdjqFo45OPPWAw8XiOEnzvbCmd7rugTPC0hY3+OXj6VP9vA2IqxG?=
 =?us-ascii?Q?ZmoHhJhknwRa6L9gDqygT/QcGJ5bK0BgniDYey4vx8nui+xZ7U3kD4Z7p79K?=
 =?us-ascii?Q?Q/svCwsSk3hRkoLnldlovgGjCcvLnElyIMdzKZgUzRb530gAZu6Fy9t5R96m?=
 =?us-ascii?Q?digWvFNZKD0wWJu8Sf82bL5sVkkR8pmnP5zxLJUE07lVqtqf3msN5qmeq8ik?=
 =?us-ascii?Q?UU1mMdwTlyo8FxqWkPlDgbvKt+3exZmbefx/syWtgZMlmZy+/xwRgXfQgyrF?=
 =?us-ascii?Q?vXwBEF8DwzPx7gAgvqaj11t4Lk6bcVeX7CYE3DLt5RtkOzaHfDH95KgxXTk5?=
 =?us-ascii?Q?VjGuzZoOJeY0TYabbwiBq9eHunxbpeRv19U8WXSyfDJSX3Qs6tjOpaTLAZAR?=
 =?us-ascii?Q?g3v44s5CiGX+4kVHGMit4sSiM8Bw4bjK/O/i3wFoxKCo4jUuT+mmZumOTbaQ?=
 =?us-ascii?Q?a/q8QOqRO84SDPJBuJaVnAMP5oV24k53hZ7VZjxcA+3sfkvJwiHMnEmue+PJ?=
 =?us-ascii?Q?FxaFKG3JrfPf9RUwvQVwj4YZmJCUW59L2MoEpbljpnXBvvAToqHLCjwrHMnU?=
 =?us-ascii?Q?p1qN7IN5O089wmMHRblf4v1dJOpDYRP3Ud2Z0ztjXZP+e32SAjOUkxOX/w/t?=
 =?us-ascii?Q?FfhsEGBrXsgrNYzW8UQBxZR/5rklipWS1jy+BQsccXknmiTJRcKpgqYmafU0?=
 =?us-ascii?Q?FxW2psTTuOUrlCk0E2dDC8I/9ajm0WeerCPDm5lWIHpsE/+E28CVcIXvYpaI?=
 =?us-ascii?Q?q7XrxRtHsuhrG+f3GwAUOrvsHuHai8Nihm0qnjVxuRA4mffVdHkrhTZQAZ11?=
 =?us-ascii?Q?w5rYK/QHgJpZd7LosKY4PnVzUj8Fal6dq5M5u1QclSr+UYD327+WsIeLJdfb?=
 =?us-ascii?Q?ew=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2ca5c72-67b4-494b-b5c4-08dd20e9252b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6969.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 11:26:28.1064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BmMq+UwIPZYsAVrkl4WWGeEbD0xl52vsQnRZsSOs/tPBZZEhtDpxbT0tGNT9NqN6OriCwAduy7QQTw901drltw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8256
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 20 Dec 2024 11:26:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16934

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

 lib/bb/tests/fetch.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 934b96cac..3fd4c82cd 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -2831,6 +2831,13 @@ class NPMTest(FetcherTest):
         with self.assertRaises(bb.fetch2.MissingParameterError):
             fetcher =3D bb.fetch.Fetch(urls, self.d)
=20
+class NPMSWTest(FetcherTest):
+    def skipIfNoNpm():
+        import shutil
+        if not shutil.which("npm"):
+            return unittest.skip("npm not installed")
+        return lambda f: f
+
     def create_shrinkwrap_file(self, data):
         import json
         datadir =3D os.path.join(self.tempdir, "data")
--=20
2.39.5


