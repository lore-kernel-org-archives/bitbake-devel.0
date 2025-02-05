Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CCDAC0219C
	for <webhook@archiver.kernel.org>; Wed,  5 Feb 2025 07:16:06 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.65.84])
 by mx.groups.io with SMTP id smtpd.web10.6666.1738739758879250353
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 04 Feb 2025 23:16:00 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=prRd5xh9;
 spf=pass (domain: weidmueller.com, ip: 52.101.65.84, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yrXi4iQis5pz6X63t61dIdU77RLQvPCOqce7OeHjEOWwqjZTGsSzSLr3AYCcnop0CfseFJACZz5gFdZPMOTpcuxSFinBFmD9Qrc4GE/VrSWZXn1DWO3R1UgCUQ9Ozd6Ezh8XfaYqpSSMjP51anucotECRRfqaZF9fKYnaoCwK58AcyNKUrI8mzicR9BRPLRvntAo0Hg3I5Oy5bURbkDzy5Mmn8OjB2ozKTcsdo5pmm/ANef+FlA5aFtgx6DarDfWdP7WogGrjInI6fCtAOKYY5hALu/l+MgBFnTU1+j/1ZAlZD8esE7dVypI4QaWGGotDAkKe4HgmS7Sj4VqWYWB9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xeRYyJtWoEB3vM4TX813nIEG4bnGpvfwP7a7MyHSQcs=;
 b=BfMSRsjlYTz22QmjXR/LOHD4xaRrVszQiDg7XA4QpD8HyekdTCx0mhqddTHc4UJmpLOCyAeicRzJeb6b703yBITMAk6WVRDHYKXzj9rwyKjRUpLUmW9CvWmNYIauS2l97Utxafj2tADZKSJWor+FqswbMnn/uvwEcbxw60gmI7KCAWpAxip2m1sZSxWkrqQ6GFRve3hrujU6IHtJg0TADZQ+R2K8o1ZqmP2y9PmfWgqU77jHnt3V9a+/41bRXaJSAawLUYg8R9WFoBKd/j0jq6sApkBpSMnunKKqxaGaysF+0kEXn/b9AGG/XLtv2pOlFz/vNIlVitddE5mqnx8I3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xeRYyJtWoEB3vM4TX813nIEG4bnGpvfwP7a7MyHSQcs=;
 b=prRd5xh9U765g/EvEs9As/IBwiiyZ2J9zJuz+8xCwnc4eG3b6j8mV85A8TBsPxQ8QhmY/fx744VE5psFImST5A+7GeTi6sWQ6gSdQNiRArJib7nw5fXf1ke32awgTz1BBRuDkuBkWcXxUmyy3qYPjtkxsah/Zz90nWQj/o1/cnAEIqsFhhnMLylOGH9AWvkaGI/ZAAYGtuPGfa62UISrIztcAjqQyuEHeJRBXvCP9TAenF304ymDpCm5FFjoMlqIfqYBAA6oCb+WxNsHZxLKHGXwhIdLtK9ZKNduqc+D7ZnGtjSLGPsI/yUCjUyU4c1B7dCU1v0PSzQcdtlTNJvcWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com (2603:10a6:150:8a::17)
 by GV1PR08MB8743.eurprd08.prod.outlook.com (2603:10a6:150:87::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Wed, 5 Feb
 2025 07:15:56 +0000
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013]) by GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013%7]) with mapi id 15.20.8422.011; Wed, 5 Feb 2025
 07:15:56 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [RFC PATCH 14/15] tests: fetch: add npm mirrors replaceuris in MirrorUriTest
Date: Wed,  5 Feb 2025 08:15:37 +0100
Message-ID: <20250205071538.2681-14-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250205071538.2681-1-stefan.herbrechtsmeier-oss@weidmueller.com>
References: <20250205071538.2681-1-stefan.herbrechtsmeier-oss@weidmueller.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0178.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::6) To GV1PR08MB8426.eurprd08.prod.outlook.com
 (2603:10a6:150:8a::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR08MB8426:EE_|GV1PR08MB8743:EE_
X-MS-Office365-Filtering-Correlation-Id: 2595850e-c559-4d17-15dc-08dd45b4ee9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|13003099007|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?mVCTiXYKV3v8gQZE6EMAcSeC/VUTaSMSWZ9A4xT4ROfmrGjTQQ3Zy24CX+EP?=
 =?us-ascii?Q?VinIvDHCtLoEwQrY30/xYM+N+jANcjkbgmkXTIZleyNy2ipO0Ki0bcPcbryc?=
 =?us-ascii?Q?VTVrArzrwrMyYRtj3+mAya3FEPLYw2g6b+FuxMDZQMYM/rseJymvOzoKdJ+s?=
 =?us-ascii?Q?JDQhJ8eYJ2kEvNqHtooRCVFuR1HMC6p64+qXRYYbaNTd6jnUIygf+lGTyCSt?=
 =?us-ascii?Q?rrfbfruThxqO3/UFuJSJqiDXFPDkf32eH/gpr0RRG+9KcrJPFzYc+j/Sx0BD?=
 =?us-ascii?Q?hMxgyFn4JB/naFuKFWTRBoXvD87YpN6spsO6o1kczWyzKR6RykRCVNZ7ZTmo?=
 =?us-ascii?Q?mHHi/ql+RqJOAmQzTBkPuEoDcV2TTjBvvxlbbfleLBh6d5gmvBKGWSYBPmks?=
 =?us-ascii?Q?KdKXzx5Ia0UIoERtvpJRqMPvH8SJ04fPNP2kkTwHfjfZEKqL+m7pdK5Sq+LH?=
 =?us-ascii?Q?B7OqSQyv84REprVffZsqc3FYfqr/8J1I52aJRn/j7e+pqVhYpfSvsqjDYU0T?=
 =?us-ascii?Q?/vhA7y8f98bzPdHUCPsHE1Ri06kGVZh+tyBiPmgu0ERhFiKqxBTKORB92do2?=
 =?us-ascii?Q?WwleqaTjmikyiCigg6kQuXCniu4W044Y/RuXG2aMHI4+rarh8pULSYY3i/ek?=
 =?us-ascii?Q?gfbWt8nqbqOVfzMbuY9KNywz6XiJ4OsLqNN0xUelm9CXJ1UmvdLb75OpNe08?=
 =?us-ascii?Q?y2yifTJJKFXjikEciYr285m9cgHAKP4Nieoa4E4z3ktKJeBTTF2FU1ym4mXM?=
 =?us-ascii?Q?FGj9lT0O62AaKfpAGo9cpwxoZptOsTHLjNDqDWln8ZieLXEgY11XF6+d73/S?=
 =?us-ascii?Q?0tBb5/kgqWLDLkqhuqQOsHzdnvaaDq0cxTV4qqnfqCNES4pvS+Xuy6O4NFbC?=
 =?us-ascii?Q?Si7fpPwcaSpYQjgcd2JtYQE1eyXExjUCaDHlAlleNWdzTaEsUArddc2NKxDU?=
 =?us-ascii?Q?ao/ypyjKre/ldT6f4f3A3vjz+kgZcFe1OptUPRJBrdGVQEJ1LMuvekuqO8I9?=
 =?us-ascii?Q?r6XWv5zly++Kh2j5s+QzNHhpJzEKSf/mgJfUT52kaW89rNvwW2cY0le9NRHp?=
 =?us-ascii?Q?PTuB8anbg7M2Y+E1Ila1bjXVKPV/suW/noWTz9Z2CNOdK7BU8LAAs5dMy8ky?=
 =?us-ascii?Q?xYpnltaYF+D0BeSYw1lRGxwldtE0HMymMLa88o0UpV7y1O+F3yydi8K1DkSn?=
 =?us-ascii?Q?DVxxFLGi9Wiv4/w4B1arAct2xKyINxtuU98J3or23lXf245JaMkyoJETmYxO?=
 =?us-ascii?Q?lDBbohNxKfPIR+vIeWdDiLci4SCMNmLc2OA/Xikji4CuDb5NXt3S+vACPYeM?=
 =?us-ascii?Q?ANsDrn2o8w5wvxwNv0W0dK8TqQoOaoW8H7XFp3AD1FThOkk445nzu0FkQawT?=
 =?us-ascii?Q?WWAh9xuCDmuq0vBRbAE9Y/Iyn+y0?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(13003099007)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ReqH4Bpno1Uaoqh7iVUMQiBYMCA6hzyzkA/jMTBq6QfaynqF1F7P+TvIYHPT?=
 =?us-ascii?Q?88f/ss41/5jSC+OEuVDuFnnyH7JdF8DWRGCQqAzeopUlf+j6kOugU8T8ECMd?=
 =?us-ascii?Q?450AfZlBU2npJbRS17Rnr3MT9kNN7hHUpsZ5eN09VccNXmmkKODFtgLjnksn?=
 =?us-ascii?Q?+a27fewKlhnkRDHpZQWLKE//XM8wA0cfmcA49JNLWGWMjDvx8Mz3/Ox5YHsa?=
 =?us-ascii?Q?Wwg51yI1UQLuvC6f3+NZZuLhPc+ujqi0meSyPTZr8qqj0YvEgCpYXa2a/THe?=
 =?us-ascii?Q?/Fn++fym+r5fUWE+jnTyhYffnJnI+7VdkiLPVBmI1I7Nik2vuSLLUjh6Q6F8?=
 =?us-ascii?Q?Oq68ygBU9LfvUWmAP4Uyy/KqmOTCoNa7meXwd6m+QibFjUs8w4Ba9TXAh19n?=
 =?us-ascii?Q?J1RPx1bKng7IxOtJBWeH5RcAej+It4f+3gxSwCf7wBV6stdT32FcPovFL1JF?=
 =?us-ascii?Q?DMh/ZfrdzEHtbPDVFxCepOPvwBDnjUCp9vN4ozxmBg7QomABGh1bOYfg5bpu?=
 =?us-ascii?Q?d1h/45gOl7C2iufRavAooiBfC9J0c0jS1NkxepehDVpdQqtC7UI6NLlf8rmE?=
 =?us-ascii?Q?vtzGLFML09vZYMQoSu1b18qOB2JY96cnl0TMk73vZHzCCrXs7PGCpgn1wF3m?=
 =?us-ascii?Q?F+vn4gpSsJeBCQmYL0w7+ORMg/L31bYByA2cT8IRJGfd1PTafjj0OW7b5qhI?=
 =?us-ascii?Q?egsUgtr+FUuddBRjubDkeRHVM7rIyVcOfI1E8OgJnfYl7o66/jJufmJUj7+u?=
 =?us-ascii?Q?OneupkGHpxkh5NSeuX7K/7QAm517DPMIh5nZeBz5FaaF8PC32c14935NDRZ8?=
 =?us-ascii?Q?Gp5moj1LIEgQGHmobBDs/hIdxCPJv2IKM2egTWT8TgR3+DWMSLl2nxlE9TiB?=
 =?us-ascii?Q?HZEK9e1MvwRkfBBgVactV/n48J3peA10KoTmjTbWjQuN07/9pnoIJs4m8OXw?=
 =?us-ascii?Q?U0o3Pu6b9kcSeM6GmhebOejNoDWMmf+swGDoi/bnceM1Ayc4k5RRVKNNpEkG?=
 =?us-ascii?Q?oBYVtDnpxGLL0CYkeUBEAS1yguMDkbhS6QdRynLdm4CdpJ6mcM0cmgqyQV9D?=
 =?us-ascii?Q?j8Lx/evSo5zxF2jQApge88Sar7NaQtJZANSwp22R2ZORjZ6LmZU5TujBgjtl?=
 =?us-ascii?Q?/BPtKsTTV016WaWSD1A/SznlN+yb+FgpYwcftgrNDWoaTYkx4J+5uSu8kNqC?=
 =?us-ascii?Q?3pcpJFuBZRyRRebRUKyHVQT+IDeU3miuO8BKVulHZzbKw3HY1IpqmgIzdKHZ?=
 =?us-ascii?Q?s+A3aSx7WcCKcFhW9bz283F+N7po8qyep5n/KqZK4Yi8U+ZaCQYqUVTXk9S2?=
 =?us-ascii?Q?qj4c+M4DmBWOTSblDvLcvm+RS1L4ncR5lLeIj4eQ8HMBF/wbRMi8hRgJwQ7e?=
 =?us-ascii?Q?cK6y3rIKuKenCiYcxQUt8aA6uswdDphKClE0PCgcnYj3/KWiVkhlOzdJy7eW?=
 =?us-ascii?Q?AjP3lYtxOyLWhTo1omIam/jwrHr4aKbwCRsFpxdxv/EFRdjxo7tBZXQxS7Mb?=
 =?us-ascii?Q?3f5l2rM9JwXiAyX4iiwgmb8KQ7wWrmwlLfjFIIb+trJ//HZtMnIhJzzAt2Zy?=
 =?us-ascii?Q?CaZ2dzsDG43zuTVbtMzEbNtzK0yu65U5m1+jyIEWf+lls/q2U4lL5qKMgBa0?=
 =?us-ascii?Q?hw=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2595850e-c559-4d17-15dc-08dd45b4ee9f
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB8426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 07:15:55.7683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kiEAiU4RGrQRNxWGIRHo/pcMBE5/VBw7XAiqf2Y1/6vqrFvGtTpwSJ/3QBC0AMI2kTvbgg1vcrV/cN+LVSSh/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8743
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 05 Feb 2025 07:16:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17143

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Add replaceuris in MirrorUriTest for a npm upstream and download mirror.

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

 lib/bb/tests/fetch.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 37de4d3e8..5d247f6a9 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -544,6 +544,12 @@ class MirrorUriTest(FetcherTest):
         # local mirror for https with subfolder in downloadfilename
         ("https://somewhere.org/example-1.0.0.tgz;downloadfilename=3Dsubdi=
r/some-example-1.0.0.tgz", "https://.*/.*", "file:///mirror/sub")
             : "file:///mirror/sub/subdir/some-example-1.0.0.tgz;downloadfi=
lename=3Dsubdir/some-example-1.0.0.tgz",
+        # NPM Upstream Mirror
+        ("https://registry.npmjs.org/@node-rs/bcrypt/-/bcrypt-1.10.4.tgz;d=
ownloadfilename=3Dnpm2/@node-rs-bcrypt-1.10.4.tgz", "https://registry.npmjs=
.org/", "https://example.com/npm/")
+            : "https://example.com/npm/%40node-rs/bcrypt/-/bcrypt-1.10.4.t=
gz;downloadfilename=3Dnpm2/@node-rs-bcrypt-1.10.4.tgz",
+        # NPM Download Mirror
+        ("https://registry.npmjs.org/@node-rs/bcrypt/-/bcrypt-1.10.4.tgz;d=
ownloadfilename=3Dnpm2/@node-rs-bcrypt-1.10.4.tgz", "https://registry.npmjs=
.org/.*", "file:///downloads/DOWNLOADFILENAME")
+            : "file:///downloads/npm2/%40node-rs-bcrypt-1.10.4.tgz;downloa=
dfilename=3Dnpm2/@node-rs-bcrypt-1.10.4.tgz",
     }
=20
     mirrorvar =3D "http://.*/.* file:///somepath/downloads/ " \
--=20
2.39.5


