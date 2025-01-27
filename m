Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 000C2C02188
	for <webhook@archiver.kernel.org>; Mon, 27 Jan 2025 14:43:40 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.102])
 by mx.groups.io with SMTP id smtpd.web10.53090.1737989013915826317
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 27 Jan 2025 06:43:35 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=UrKzzh5R;
 spf=pass (domain: weidmueller.com, ip: 40.107.20.102, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C8ITSXlCAMmpXsBjYJmPomoFDP9M2oSbRgX4ufWw4XaPvO1j9FtRZ/FK9jKVgClkKLlq6RSA/CDHgJTofTVBNhIG6eCYsAfOBAV51fQ2WMVQabNBbW9oRumzToaGG5D024QtR0EP9FChVNiB88c7DUwXxPptYwtZeIzLCr9Xtko/sVsWr7eEi7TyLV9LbHDEL5+XkJwODlwFuIzsXJUTjaCai+VQ80UTC068bSdi7AezlJldqLIYIkl/mZc0KeLeZ1QYAeMHme7wwjton7gq/nHUXaPH3LkwR0DhxhBzaq6tH2d9Y7S2LWoEzKlYwEzKce91EA5pM7wMpOXTyg2Qrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lcdWMA5xib2arOUaJ4ooNdfl6KNkEGylN5S7ax751kg=;
 b=pRxNuhbDyilxA45ALhBbLsKRDhXivmxeE+6wzHJaEH4ermbFMo4KBldqGq70qT9QZDEdCVus+k/sV3CwKCNGD07eZFCa8YlS2VeQ5yN28zYz7mz3rW+ULMtBtLPdXn0F50xyNMT83jmnye07o7lSyLUIhO/q4m49ntPhhrGst68c7fygM7QSGWvGUaTtX8Dd50yzInc7syJtR8k4dc6faJLCV9dTrawpLmTTqAzxLT9LPcW59qL4pvfaXnYC2L6rUe5fijRgJuf8er4ewJh0fYwhb+ngjcDSWI4stMHMg0uNsZTIQBU2jbf7xXewi8Zmuo+mGDPM5yxu/4ZnBnk1zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lcdWMA5xib2arOUaJ4ooNdfl6KNkEGylN5S7ax751kg=;
 b=UrKzzh5RVxgTpzCOKy5VU9MlpixHiG2UKPldrfLY9LV0BKb+J68jRpJkSDw+hkNMeauZ1EzIOAkdRWwE/LUaodBevFZEZuQ9AtRTpdwWJeFmay3uZMJTdANsFiNqHWIlNd+n1swVYGeuuoxiAuI+f6YqIJZSMy8rAd22iqDEJna75XOzjWcEi7MKV2ibEKOCZgeo22BdS3QGyFNW8SQTNcGf+6MPzM3kuYEVT2uIfddDcy2w6sse7v75t61i+4zZf6UQxSH1hXpLakMKOUt+QqHmC0EKRnDZZg2kZtysTCDA47ViXVRt/GLWdt2XSvOqad5pTDn/vxO7TLbHE5Q0jQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com (2603:10a6:150:8a::17)
 by GV2PR08MB8100.eurprd08.prod.outlook.com (2603:10a6:150:7a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.19; Mon, 27 Jan
 2025 14:43:28 +0000
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013]) by GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013%7]) with mapi id 15.20.8377.021; Mon, 27 Jan 2025
 14:43:28 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH] fetch2: use downloadfilename to fetch from mirrors
Date: Mon, 27 Jan 2025 15:43:14 +0100
Message-ID: <20250127144314.27990-1-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.39.5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0221.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::17) To GV1PR08MB8426.eurprd08.prod.outlook.com
 (2603:10a6:150:8a::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR08MB8426:EE_|GV2PR08MB8100:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ca74183-901d-423b-0ae5-08dd3ee0f613
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|13003099007|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?f6Ay9DbdrajyjIDSKYi9UNvU46PmKPtY/dBVunJen4OoA4QdCY5qMcvgWhJD?=
 =?us-ascii?Q?dpzgdhpbJDsVXK5FbrOdleFke61EUtolfPqkWH5V6/x9hs8DFqiEYm1QZsLy?=
 =?us-ascii?Q?ZQ0XMRQlWi+mKUbdJw4alda3vESW9sheilAvDsObyVCVMgqM8Vb7o78PsjJz?=
 =?us-ascii?Q?fRgNqFek3B2ehHhBQI6eOPnJjJCnIm7SywJrLyCxeaiOAcKjJCiO1wDDJd0v?=
 =?us-ascii?Q?fkh5dMVELxvatk8C7otBVbWldwxWJdvsIFM6mZHPrfcM4qXx+z4lHMVcgYUR?=
 =?us-ascii?Q?awsawSoitaiQfVtubANaCIdTk24gbusTS9b3OHQ2G2u15mfk+3879gnUqnYk?=
 =?us-ascii?Q?d5A5oh5oLsoADew1ZAXFZNaeDyU9cONGG2sUynIwHiPxePEcd8D5N3kyd6Lk?=
 =?us-ascii?Q?YLhIdBuTEar4fkoXp7DAhxMCVQwX6dI82KI0v3s8bFLJPlOy6KKWyYbMsb9F?=
 =?us-ascii?Q?ViYFDBAkxMVd6C2UKv9IJ8QFZ5+GcCgBLYFbceFeshrnJb/Gjo5LXw//1U4t?=
 =?us-ascii?Q?XyvKHIfZ2jkOKJM0N3aAavPtW7Ya0LLPFEfKv5ddx0GMJlNlcL5QyG9hNtLc?=
 =?us-ascii?Q?xmwHLXRlXf/bfgAeghxubj2HG4+r9v6i4QKOhhMZEOeqai2kYchKLHXMhHO1?=
 =?us-ascii?Q?BM7pwNQFYK5ZBRgW648gxR77j3Zr9D0DERiL9HkLVRUNWJjEDqI6MjU0LuiX?=
 =?us-ascii?Q?cgEnC4Xn5ADRPJMVKihpwrG2RsO+ZdWSM+9V9b8H9dC+vtjNgyIeqvosnWD0?=
 =?us-ascii?Q?kvDFWOKsXZKNWAChSRThwDkyBu+EMzp+bcH4GmiQJ2C3kwCK/NX1c9/OBT2G?=
 =?us-ascii?Q?uEv0P3wV0EtbfHEwed5oL3TDxSCTcZpsh0akpMAnBMGM7icqzNnW2leYvrbr?=
 =?us-ascii?Q?1FFpBrHsJn7BwUpwRZnK16XzS340z6eApzTKYbMNl49DAoowoF0K0KvmEquQ?=
 =?us-ascii?Q?xHmI8GccNnBbj4rDjGZHCRkJhN7Pd0R6euY9CYB1336Io3R2/pmGRWhYhFWW?=
 =?us-ascii?Q?cS0omViyHME1eMdT5JRbo/S+/la4jp+3usi35+btplEtL+zqP9hnjWuId+7N?=
 =?us-ascii?Q?KP+8CPR1qvLQwF60fkfUjIPDUEpAsng0pOwBaDFGQAXGqMMTu451JPra5Y1L?=
 =?us-ascii?Q?IC3mKSBxn0owcgc1RelECY64BrA4+4sys0qVNVXBunUy7kZzzaZ3x2qty2Yr?=
 =?us-ascii?Q?f3wFGsiiaW+NxbNSsIIOxbhRKLuwCnL0M+2dLhU2LRkyR38e2MJdiVCxmUKg?=
 =?us-ascii?Q?9WieDg0v9DDBtx2dKuNm0xT+EtFu2oGjzXb0yEV6NzdJEXFf67+EzI4+swg6?=
 =?us-ascii?Q?9SQ87lPcksXiNU/tuGr8MIDeO0D3m4UwWte6l067QY/zjZGBqD2GgXDIstV1?=
 =?us-ascii?Q?GdExZ/85lU6nkannwgJqgy6sDXoi?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(13003099007)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?zj7FFWvC+/vXDqj95US11nVFA38bu6lk04P0gHM4za4uPmNcbsO8GWMHOcj3?=
 =?us-ascii?Q?6IMBk7XPHGDiQEK5kweEmGmXcnaMOmD5go1eRem+UzUAjhYjyOlgoXMhHmuo?=
 =?us-ascii?Q?1FR12FbPz+ExSmbDoHk5qv0GYm00/0GblnTBVOy9uDVK0gqH/UA23g4mfAjv?=
 =?us-ascii?Q?36JVYZlgiKo0jNnv3lJm8i5reDsLpo2A2GRD7tRfeCp5uQwZy7xrmUYQmwh+?=
 =?us-ascii?Q?C5S4cDctsfJOkH8KbUOyqrKxNGG6jkOUxdyMV7gGDhrGJ1JWrHUb9P1WjIA1?=
 =?us-ascii?Q?If7HQs8gk0TizqC4TWplErnAaUZBNoox1F7MFP84u4JB7HkUHryAmku9nYEB?=
 =?us-ascii?Q?YZZdrWkHWK6RcqYwQfvoBWCLbTeDKEOezhghiXGCCIO5xiOy+aGyWfM5tq4+?=
 =?us-ascii?Q?uXJ+Eg37vuYNgeb5EyuWn2D7vk1rKtc/QF/yN1Wrn2aDg0TQ9AU0XcrJEnPF?=
 =?us-ascii?Q?FwlBvIV+5HDSD9gx5FtNeNBKZVTaDp96seYOYp6XIcm2rdPcBIHZBWefiXf5?=
 =?us-ascii?Q?765R6X/E4LDDx3BT3ebxgqfBqzZLmgXSzDCvJHKqBI5/HHITQ+acz2pORgFK?=
 =?us-ascii?Q?5+Uk9st+GtssDKIsyGng7Qq9xXxXCNxglfywqX5KBiIUyH/OTyr4KyZwdNHA?=
 =?us-ascii?Q?pvJKqQBNMGrYLjf2EQlSu9rQOuNphkpqAg6lhADpbuqz0TnC7mmW3/U5T1Pp?=
 =?us-ascii?Q?aP/p2qvi4ms4DX5Nj6pA125bjTETRPsk0S4BYnocVssavPmpnJ/jTnM/ox7W?=
 =?us-ascii?Q?d+uDtDBuV2zTeRNVhhymS/KIUS1V8TVnM9FYBtg9pNorQlEsU2Y9oDHnPP6p?=
 =?us-ascii?Q?EQHmR3P2a8vZfvhlMQ3kKuT3ve5KP+LyuVNg7pgW+4paiSGa/TQIeWRsuhgW?=
 =?us-ascii?Q?yUr8k80N4/GXONdhG63yzosZEIpN0i7JWVeky8mK11mvlRkRfloTHet1RgdH?=
 =?us-ascii?Q?VSdvr6vnyMj8iIht73TCwNliROrvNCTUEyWPvlm7UTJMP/+vJVsqigTPugib?=
 =?us-ascii?Q?UYZR4qXw8JlR/3U74giutbnXyAAvAbeS7Y806B+KL0RFo4FOhDP12+ZhSe05?=
 =?us-ascii?Q?Oz8NxjH1CnlRy8qJDe4wb9GCLP3puIPLUK8azzGegTs+8kn+0bXMHJbcTchV?=
 =?us-ascii?Q?n3grCSDM2DpH7JfjIdFhTC7NdZ+nMuBCOAyCwY0oQ11+3tdRRmQ0dGzP/LFg?=
 =?us-ascii?Q?gsPlAw7Y2MQqFGq7uksw2UCZJhXD3O7FxVQ1Oy+K2xZQSmq+HFYF7bPtpiOO?=
 =?us-ascii?Q?ZguJ/wM51mcRalm86XHX08pcA9R/ErWK40QKIrCb1PaXdGYiN0YWNC3fMuv5?=
 =?us-ascii?Q?kCR78PUmD+Ww5WesPJMMbPtCnXg0BBerdvTONwR6qg6kkd4g9TOojf/Zj2mm?=
 =?us-ascii?Q?kb0GSvlAA6qn7C19zzVsPw1bCKJuknIMrZUdBKlLoI/yfdu+u/Ye2Hkhwl1/?=
 =?us-ascii?Q?xey4TRIG2V1wGq+Kr5+2tORuE3izkerIWnVOhi+ZshAsZ5ieAXSw3iuGMN51?=
 =?us-ascii?Q?3p0841z8hRu38y4KF8Swv//ZdyAmFEA3bJTLoLIko4cs6RKRaFhsdPiOfuca?=
 =?us-ascii?Q?9UCkxUeYrrxt29yjoYGz2d1dl8THamWotdZED8SPVgFfv3oDajJ2SnVfyMAp?=
 =?us-ascii?Q?Aw=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ca74183-901d-423b-0ae5-08dd3ee0f613
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB8426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2025 14:43:28.0124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +BPra+/dIe/iCANpAEWWr1zrHw1tmTuQJU9elDzO/oXfyod1HAhlp08sCJ4/TYdHfzJWvLu49xsdGNFZUnw3mQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8100
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 27 Jan 2025 14:43:40 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17101

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Use the downloadfilename to fetch from download mirrors. This allows
fetchers to store downloaded files inside a subfolder.

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---
Alternative we should forbid folder inside the downloadfilename and we
should add a check to the fetcher to ensure plain filenames.


 lib/bb/fetch2/__init__.py | 4 +++-
 lib/bb/tests/fetch.py     | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index f79e278b1..c0b39ea5c 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -472,7 +472,9 @@ def uri_replace(ud, uri_find, uri_replace, replacements=
, d, mirrortarball=3DNone):
                     uri_decoded[5] =3D {}
                     uri_find_decoded[5] =3D {}
                 elif ud.localpath and ud.method.supports_checksum(ud):
-                    basename =3D os.path.basename(ud.localpath)
+                    basename =3D uri_decoded[5].get("downloadfilename")
+                    if not basename:
+                        basename =3D os.path.basename(ud.localpath)
                 if basename:
                     uri_basename =3D os.path.basename(uri_decoded[loc])
                     # Prefix with a slash as a sentinel in case
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 6dda0d381..50f047b4c 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -502,6 +502,8 @@ class MirrorUriTest(FetcherTest):
             : "file:///mirror/example/1.0.0/some-example-1.0.0.tgz;downloa=
dfilename=3Dsome-example-1.0.0.tgz",
         ("https://somewhere.org/example-1.0.0.tgz;downloadfilename=3Dsome-=
example-1.0.0.tgz", "https://.*/.*", "file:///mirror/some-example-1.0.0.tgz=
")
             : "file:///mirror/some-example-1.0.0.tgz;downloadfilename=3Dso=
me-example-1.0.0.tgz",
+        ("https://somewhere.org/scope/example/1.0.0/example-1.0.0.tgz;down=
loadfilename=3Dsubdir/scope-example-1.0.0.tgz", "https://.*/.*", "http://so=
mewhere2.org/somedir3")
+            : "http://somewhere2.org/somedir3/subdir/scope-example-1.0.0.t=
gz;downloadfilename=3Dsubdir/scope-example-1.0.0.tgz",
=20
         #Renaming files doesn't work
         #("http://somewhere.org/somedir1/somefile_1.2.3.tar.gz", "http://s=
omewhere.org/somedir1/somefile_1.2.3.tar.gz", "http://somewhere2.org/somedi=
r3/somefile_2.3.4.tar.gz") : "http://somewhere2.org/somedir3/somefile_2.3.4=
.tar.gz"
--=20
2.39.5


