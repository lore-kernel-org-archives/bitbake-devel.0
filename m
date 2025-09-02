Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8492CA0FFE
	for <webhook@archiver.kernel.org>; Tue,  2 Sep 2025 06:45:45 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.112])
 by mx.groups.io with SMTP id smtpd.web10.71238.1756795540688708917
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 01 Sep 2025 23:45:41 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=i231pnzr;
 spf=pass (domain: weidmueller.com, ip: 40.107.162.112, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qvYTXVYs+CMvH8rkwkRDpT25eOtfb+7nbITBhBZpHC989ZvQvPCB7A6A8Kjww/oal2iW2bbO231rugst49Dqu7b4lvGzgQaJiaK4XBTMjDjfCfWQJyVpqmdWT1Mbi+csv79fkYP21RTtIypgegMvdPo2XHDUexpW4LlMzQTMqeB5kiThxnv2B82CEtmz0kTwCInAmMyTgoOAK43AYfCWX2gYeUKg4WwxuDfE+VI9HDWJP0a3JU/IvozobCfdBfa6LxX+Y30YhKgqEp/VJreTIs5ZdHkDGQcYGnQE4QXyJ/3vjwDOmY80MgWi7YpW9pNJVgCTzWWGZxERd0ITKRkD3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tuKFFXgWczR/sOnmcWfRRkgSh2R9rnq8ah8oKzB8YV4=;
 b=BJ9Lt1TgwPEx8uHL6k6dB7RBQ36ZZtp4tBsxeJYH/FA43Jf+C+C2XpezUS+A6doEUI1jwZWFZHwjHaQPM0J93H2pNQieWUFfkQMRp0mjMlqd8n5pJeFtj9r9YJ+xB12ecdd++utehFAMsxZ0lhlN1UuiodYN2lJ2F/+61Dro1su0yoTs0wqAPiWHdVpUd2oJoFT38nu66ONtuRGPTryM6XNWl0q+6obfo6zYMXJb+UiCCoaIlzMwdnxQWkJu4vaehVBDImQWPzHIkC4IdtpIRRpohxr+QlNp++5FLPN35n8A2jkirmvypmh8saPEf/PsrwMQcj/C50CNEbiTtZY9bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tuKFFXgWczR/sOnmcWfRRkgSh2R9rnq8ah8oKzB8YV4=;
 b=i231pnzrUTu8utdgrsnqk48lhjA2DawFwf9oDpw7aqbeB30t3q7YSK/gcrW+/TK0szmiHsqR2wZEPhQU5mHme3OLYBappJPOeshqfe7GObbBzbsvd2hZ06kL6/FEYg2WAhBJkZpDRS3WnhK1e2phoSLCKShLnmJvTsD3NJLQLrCreEjJiGyvybjpFsK0UKMLrb6qCpLkktxAShGofStAUYRRLhURejh5VcRtKXo9rp5HI1usjfw5RZE4697l8duDdRZ4g/XOREtGWj5w7ByYoYwYmdc/T06l7cjXVV2nxhheuya19EhE0kxCsX1/gN81+PtVCc+lj3XPiIi2Fur27g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com (2603:10a6:150:8a::17)
 by DBAPR08MB5591.eurprd08.prod.outlook.com (2603:10a6:10:1ae::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 06:45:37 +0000
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013]) by GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013%4]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 06:45:37 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH 02/15] fetch2: support URL rev paramter for named URLs together with default
Date: Tue,  2 Sep 2025 08:45:01 +0200
Message-ID: <20250902064515.30879-3-stefan.herbrechtsmeier-oss@weidmueller.com>
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
X-MS-Office365-Filtering-Correlation-Id: 29184588-65d7-4398-3816-08dde9ec5239
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?oeewwvLzz4i3VvQY3wF3Nhw3dxOnX42vHNGJj2miCiU3BumuW841fyO69i5+?=
 =?us-ascii?Q?SbHAIeQcyq4exiL1XIG7AdOjK+ATSRqZHpaiXt+mYvbMLmaF6r22t3n4dPo8?=
 =?us-ascii?Q?vQXh7rE2vKcS3YWlEdp5MD4B7sDYFvVzpruBXLDgztYv5CHSHw+KUK7waMMe?=
 =?us-ascii?Q?rguzzuvJ055mCB/0hkB/LcFkZwYw7bdfpbtJjNEvbNiz54AUp2JZYGqiXtxM?=
 =?us-ascii?Q?20v6GRaxKEtfcQlH4ai3Qq4cAj22HirK74vRuVqRrMH+EtFg55WLAQhi+WzR?=
 =?us-ascii?Q?Y91+YlRM8SD1gyw8tO6ROB3HdjaHu2StwS6CA4G62qYUrgs8K9JfD4HDdiKj?=
 =?us-ascii?Q?RjjC+VMvicG0MFlK4QLhW4MzpgXurzq6fZbAXmlr0IvTwsNDbn8Vkb/AgoIr?=
 =?us-ascii?Q?y4T+Zq0FNujqyM0drwzQjVCNnBy37fBc1GOZzFuKG6sfLfOfeujniX2bsgHZ?=
 =?us-ascii?Q?nd9/UDYkQCaLhMesAeIb/XsXg4ef25tNRDp8kOd6Od9yiIYvYkkfMjzu3MvD?=
 =?us-ascii?Q?n5gra5oRu65MiXoyPUNBQRKgdHFse0WQavXWYGto7gpy8qtqFdLTN0c0o8F0?=
 =?us-ascii?Q?tipKwgqnSuM77y8G7jrUuKu9RsjRfemd6bGdgFEtDDAdsXGHKH6oCjH6XoeE?=
 =?us-ascii?Q?+1SMiItl2jlf+R4M6/VPrTgflCbQ//O26XXKqJ0+VMkLlQvgtMk/jUJrU+7O?=
 =?us-ascii?Q?aPSJ4Mhe2U9uarDtEwn3Me9IlLd0WX+hks9orogM3Si66XWBVocZshrEKVNr?=
 =?us-ascii?Q?0SYnCUbjn2yaripNDUBVFd48Z7TcV6oCXd7IebE+OZBXaH+E6KUDnUJxjb8M?=
 =?us-ascii?Q?EVGg6j05RLUylEbSoqqK41+Bly2Em3qISY+xa8x9algtzryWBv/rKsIa1VJI?=
 =?us-ascii?Q?9z8hPEpjXN9l1xAGaBBTKkBBaRdzT0KofXVaGqFvqcG+2ml+5bcScEm0cfRO?=
 =?us-ascii?Q?lKs8du4xaBgkLIuD4h82VhSqCNw9Ry7DtbTcfrPnyaXXSJVbY8RI8/5Uwo41?=
 =?us-ascii?Q?1t501a4it0UnAO0uvKQ35bK8JbiFbFYW4OI3FCAYAq5U9cQQMoXPICBjwsgJ?=
 =?us-ascii?Q?noCqD1laJUk3BGoqxrdb0LpLGi33uheNpxBaixPp3ItlUlhn5Rp9D7OOgr8C?=
 =?us-ascii?Q?q8mAHZGsMm/Hq1qmcjXmaWx8myQMf4bnWUvW27cn+EVMjGfLfJ6J1l90LD7V?=
 =?us-ascii?Q?bODubXqDihx6Ivppi1+CKTR9Dp6EdhxNYsMr2WE+Xi3jP9IkazGpQ/+6wyLt?=
 =?us-ascii?Q?hfv5cQcCMWlyQ3YRjMUB93RIpEx0Mrt8rrZs2eksDUFmMciYoiqqHksdJv0G?=
 =?us-ascii?Q?WC3ZRqIyp3TkQfJw0vUm2s5yjWciq61U2t1Sbk5k9JeiOl+0S4wyR1GYYmTc?=
 =?us-ascii?Q?SBE6EnUtFy4iw07wIrJXliHgQNv5PRMY9U9R9LTNwKjMcjqx+zs/dTw4emb5?=
 =?us-ascii?Q?2mvJ8A3CtY56rL0vBUKOS63ykmb1m9se3x26lwK8vK4U8uQyb72UDQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?C/bpR4ZldaPQE9mrTysijBSJQj1cW1LKNYv/xgT+ZlY2Y0LPIXVUwkCm0w4s?=
 =?us-ascii?Q?NGI28cvOif87jLLSKcHk8UzrlukMM6N/L0xaQg9UMZMnIPf9k8SaedeQ7dhO?=
 =?us-ascii?Q?DE18c9Eje3gLd/B2qrWTW49hxNdDjFYT1/egg2RFcATRMWih5gn2kZMlAp/Y?=
 =?us-ascii?Q?GOlGfBXZa9n29Rfccp2D0TfH1DPhDA6GNFfO9L4zWNcmaJXl1n3D20pc/O8U?=
 =?us-ascii?Q?3rQn3rrMlWPbu04HLMKMiRKI2xZucNpeg12dN9/fOHyZvnZwSiAEitYsvTPz?=
 =?us-ascii?Q?dx1txh3nDCj1DxMwuUsy/qxzOIhxbWtV5tMZawmv3umhcFZJDneHi+iACjFy?=
 =?us-ascii?Q?BidEM2nDIAofs6mFlHxdNNaqfduL5P8EDhcbEjbegcOUYy6N/bh+pFqi7E5X?=
 =?us-ascii?Q?EMN3oJsua2XlfPvgKQHxXAOcCRHO7nbGZeCkTyhskRUJXBrBfYCuBHDYmh8d?=
 =?us-ascii?Q?9dxvNKrqrKF02AlTuR9KzaaXkLKvq22o7RpAh3i/w5f+IFiJ6YhtxWqdMdWR?=
 =?us-ascii?Q?sjuznnCCYkY7rtD7blJb3xmqJhhqLsKJoNFiiDhB+ABUTGI1QniPLNfgePE+?=
 =?us-ascii?Q?Cd0t7R4hKGBECreUGTEAqwkezEAwWVBc5bgLla7xPbZprsmwaN3Acj6bThFE?=
 =?us-ascii?Q?iPj/NLzXOf3zcWMlI7/ZOaOG/8XI6QozjBHJcCrHw/ZMEpJAdl7Oajj+dNYC?=
 =?us-ascii?Q?8uc9wRC3IZJzv+/MnmL+ICdOcZ7fANEEKBFK47FtyLG7NEVep3SWbZS7uPf2?=
 =?us-ascii?Q?1zcSHYklZGyb5eExr/UuRXqL5NgcHfUhDlAvzIDR5qkJnv/wYnw3iH0BDQKA?=
 =?us-ascii?Q?jEkg+5TcALx1lDs7O64imm84ZK1zXO8w5593U3JacwsMcU7waXnLecB44GpO?=
 =?us-ascii?Q?bCuxIQUmsjfmTweYc+3/3e+X7FAhfJDiVo2NamAJoPlAmPEmB7ddnZxQn/hq?=
 =?us-ascii?Q?S+l3w32l6q/NLVoCIrXBtuK4nFtMF1/ZMFUsvv13rHv3fbNAP7a1tZe22eJZ?=
 =?us-ascii?Q?0x9Z6xP32VUym94AHUKw6wry2uoPUS7rckU1bO6jy8wtw9nmjvDflQTZwP/e?=
 =?us-ascii?Q?3bejGJL1h3RsoGKCmeenSZtOW6YK1lyb1AoHto0FK9wqVfqthtOUh6E23GXV?=
 =?us-ascii?Q?YAV6RtdtDZ/4NpdWxKSjKL2FlUcR4jHxUEOZVdlsBe2bzJKNi+ldZfxOjdDF?=
 =?us-ascii?Q?lzbOgM5xm9B17Ri54oK+9yIjM2ME8fYCut8WOaX24DpPSH1buZV4FxKSZpC0?=
 =?us-ascii?Q?qWxD3KfH4dODlliHokKUH/PFe/ge4lGUhQgk5mIRNdP+tQAfwZ3wP/qTkDW/?=
 =?us-ascii?Q?osrrVIfG1cvR/XQ6xWTjWJ43YnV6ItRkrA7lAIjd+bq054gtjYy/MbECQrtE?=
 =?us-ascii?Q?q1pYa8utFFQjRQAqL7ltJX3oy0vDeSYJJ7FsCgqgYiCA+ENnP9QxIp6hzAVI?=
 =?us-ascii?Q?/eqjpqWQO6B9mcMEQM9lWz3k5O4YQ1NzE6DIfogQj0cQUbBADFVx7dLvgty7?=
 =?us-ascii?Q?HemT4cO6kiH2J2b8GUlpI2S4TjR5ZwSwVtxcmP17BDZKyF0sMY20tEoxA4JX?=
 =?us-ascii?Q?lN6IKmts8bzJoKdJhsduUptu3OSMtStDwLy5wT49l21fQeu4SJNrqbuGfMWe?=
 =?us-ascii?Q?MQ=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29184588-65d7-4398-3816-08dde9ec5239
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB8426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 06:45:35.9611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aP0FFS2GFPVSRNH4/Ic9mrSBhcfYBEmNVVRbtjfoCm41wy/Pymk/Xi7ODLCifOfTm3QzAjJDw7b9QKqRoLygJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5591
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 02 Sep 2025 06:45:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17920

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Support the rev parameter for named SRC_URIs together with SRCREV or
SRCREV:pn-<PN>. Only raise conflicting revisions fetch error for rev
parameter and SRCREV_<NAME> or SRCREV_<NAME>:pn-<PN>

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

 lib/bb/fetch2/__init__.py | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 0ad987c59..de301543a 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1226,9 +1226,10 @@ def srcrev_internal_helper(ud, d, name):
         attempts.append("SRCREV_%s:pn-%s" % (name, pn))
     if name !=3D '':
         attempts.append("SRCREV_%s" % name)
-    if pn:
-        attempts.append("SRCREV:pn-%s" % pn)
-    attempts.append("SRCREV")
+    if name =3D=3D 'default' or 'rev' not in ud.parm:
+        if pn:
+            attempts.append("SRCREV:pn-%s" % pn)
+        attempts.append("SRCREV")
=20
     for a in attempts:
         srcrev =3D d.getVar(a)
--=20
2.39.5


