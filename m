Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D67FCE7719B
	for <webhook@archiver.kernel.org>; Tue,  7 Jan 2025 09:18:26 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.129])
 by mx.groups.io with SMTP id smtpd.web11.16587.1736241499941436827
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 07 Jan 2025 01:18:20 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=D6bn/0pD;
 spf=pass (domain: weidmueller.com, ip: 40.107.21.129, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MhtZ2nV1N8Sr6VvM5jq2YISHe5uoJHwiijqFsi+PJTr4g/4Q8babC5wAdHZ3JJ961emjDpaasRF/YWvilW6Ca68IMe/C5rm8Bjn7L08Dt40XzwJj6EvIuOu4dPPX96907CibCBoz/vzDaO60/2Mc0vOmzQsfML5SrQ0ilrJBBk69dS7OrcMvKsDsdnTzkcdTkykvq2alutdNXKlkUri9rPHVKXwq47Vr4iICcQflJlEfQneOWJd64aDSDCRP3DPk39x7LTvyASXJZ5LE8raOaIYUhLOLD989BKRLfJ6y4lxkL0WI3FP5HafR8HA/hG3NAy9Rv2TUyS7CiW+qotHkSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eTPvKRjIRugd0DfnF+zHlcgXQw+aAS5AGA5VFuhyZQI=;
 b=sw473ajtTl0geQur+fDGeWkb4yfrC+uXHOvOJwHU8FSzSswNDiy+QRsga3RFKPWhA13wgNHxVzJnzvyI83L4ajtLzlu8upor25Yr30t7z464jskcyCeweFUXrxuT2XX/HKhEK0sDNqSSt9QfWMXRz18Kkt39pjezIZJMjICdicpLstbAwKMllC+8+rvY8wF7yIwGcSHk39p4jO77y6h1qjH4ttAHa8N/TGEs/3Lzh+OuB+CgU8Hd0huhc5ULzmZzvNBQfEN0RkT5m1Ukw8p1Z8JjeBHIpkGeDPqljGPYfM6k8ok/Qog2n+79PvDLnKjAy7v8SlzH2m4E7iPywzLcPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eTPvKRjIRugd0DfnF+zHlcgXQw+aAS5AGA5VFuhyZQI=;
 b=D6bn/0pDy3XQgz7T6wBOP/TP2Fp0DlxXBd5lXxWxH0Et14BXBVsRxm2t+lQ0jFRWLVnt0i1ksJZhjVg/aCRzl2NVrw9U0akTvjAaCC25kBueml1dfT6Lpe7OaQAwBMQvvS4ZxS7v8MCOlmoWJXUz4CH7YsE+RktlQ+sTmqQ1c4Icae8fysd9HsEcTubB8dCwxq3lznGFSmEFXA55wo9VpQBygIdBoyWbnyn1iQmaea5sb1JDhSeqt+6uM2fbOficx3uQgDI+vakI1Y9qXR9JG31GEtq3QMF702HalvHWq4PSL7F4KtlqbLW0AR9UXM1YH5m5tHWcqq4AlbT5/0jmWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com (2603:10a6:102:1d8::23)
 by GV1PR08MB10607.eurprd08.prod.outlook.com (2603:10a6:150:16c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.18; Tue, 7 Jan
 2025 09:18:13 +0000
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4]) by PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4%3]) with mapi id 15.20.8314.015; Tue, 7 Jan 2025
 09:18:13 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH 1/5] tests: fetch: update npmsw tests to new lockfile format
Date: Tue,  7 Jan 2025 10:17:53 +0100
Message-ID: <20250107091757.886-2-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250107091757.886-1-stefan.herbrechtsmeier-oss@weidmueller.com>
References: <20250107091757.886-1-stefan.herbrechtsmeier-oss@weidmueller.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0015.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::7) To PAXPR08MB6969.eurprd08.prod.outlook.com
 (2603:10a6:102:1d8::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6969:EE_|GV1PR08MB10607:EE_
X-MS-Office365-Filtering-Correlation-Id: 96b9c76a-e3a2-4fed-b65d-08dd2efc35ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?0H8czt4HNA9/0FDE99AJ/pYFMdo3AG7mTNJK6fVy5Iqck4sCyHn6So6XjN6L?=
 =?us-ascii?Q?vfUEbfxPehoqyKjDpQ7ckX5AV8AeltIRFbqIhKXI6vbYyCla5dsQxK8INb7M?=
 =?us-ascii?Q?cjxa1zjDgTdIYcC4ev+FjWDq91H1WZxcRa8DqDNWiz919ehvh6+v0czVMYyC?=
 =?us-ascii?Q?Xbv/KBezCxPQVYmuhsw8Nyp2EnocbYXixy7lxX7GdyzjeSshFDgjVGMaqQbW?=
 =?us-ascii?Q?HEirWnY3XxVwvxXhquNOPpmRcVC8B9SRI2O7pBM4TGZLceZtXQbSfsGOd0Th?=
 =?us-ascii?Q?cIMSRmsM0pGFhq+SVPy8JtbK/eXf05S1KcgjA0krlH0pgMIjCUsqVgxANPWC?=
 =?us-ascii?Q?d2sOPMj6/w20O5pVwztGM3zuIVrnOIJw+O48tRRmw0Zf5vZSvwJJm5Jfir+4?=
 =?us-ascii?Q?MVE7TfU/3vQvzdjrIbwI5WdJ2viam8u1JNqgXfjUgJy2LUjX/HK3SGL3y/yQ?=
 =?us-ascii?Q?iom7AtT1kzuSaxPjpbOH0l5N4kruEBgshjiPbcfDNymLHfjG8xgtJHC+rlRm?=
 =?us-ascii?Q?Teaei79+x94krDjaQQ3fmoskUymffOyMmNT/P34dYvy6tS01X6ANOc9Nflv0?=
 =?us-ascii?Q?x3pcSyyXrWa7LlPhBbM8Yi7/aLsTAQ/Kp8kxPtblVf3nxI5RRxjnex1qhrmp?=
 =?us-ascii?Q?dgDUTXV9gP0QhwrDisSCmggJHZ1CplhrxnsxTf5TlsEhhcZZdldk58Ueo63v?=
 =?us-ascii?Q?9GJRbglvoSdDI+Q+j4ckBaa5oYiZU9z91xWpjb4n+pHUq78h/XSIqkufWyVz?=
 =?us-ascii?Q?Isqov6HfO4/jHT+pqJT68GNLUX82kToeyfe8rxmv4dGvB3q5xqWWcO1zQtrl?=
 =?us-ascii?Q?smnw9a/AIaRub9hK9HreAUg/xPaz6AYj7S4XhiKtbGa7WG1CtDXegqFqV75u?=
 =?us-ascii?Q?V9IHxU09nCxFIUTNG9TU6Zy90FslV8uStEXjFJiSRQ5qQeqQa4PFTNzk5w8d?=
 =?us-ascii?Q?uejzk7rO+0cXA9OyHYwFBGULiQ5HOMsmK5k9nJ4yoFSyvGwCqAs1u8fnAMyp?=
 =?us-ascii?Q?+C1nP2X8lAYIU9OpcTZ3K2HKhR3t1yycJGLxjGFG0F57RKJOi3HVWGljZt2B?=
 =?us-ascii?Q?ClX8Xer8mm2egTXb66AyX6AEbLi73do/KSKedEutakWpQ4+gpqTjNpE+jsTK?=
 =?us-ascii?Q?NIXtXDjTeIzRh59jXod3KAhSD2gadIzDOXwx+Cj7xA1/gSN+uoKVY7aZ8ZH4?=
 =?us-ascii?Q?isPwm0Mu8CqK8M1MRvpQInl0IK3bIGOzSfYqM63PxlwECleyuIwINy/BRoZO?=
 =?us-ascii?Q?6j+GfQ74pUp6fmCaMBdBNFhg/I8JerTAV/hbxs6WuIjmjzsNXM/zjrAnTigH?=
 =?us-ascii?Q?8g3aSrRheG/DWU4C9BfgWLP9PNsmu1fsVJb7MQpQL97d/0gPktpkH3WHvnpm?=
 =?us-ascii?Q?sCJHK1sSvVY2b4OLyfnV+KIekfNsF3MkulcRt5NLbau0kcq5PA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6969.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?AL2hn/CKuKNNZ9ilG3tMVibLevDGXvc/wZA9Xyp5pS2//6VNoyTtLAK+zM8e?=
 =?us-ascii?Q?n18SZ3w9f6elGyOtlNg6uAJl00fCNxsF9Vkt3o2KIiuKwr5fwmQ4nS/LwUNm?=
 =?us-ascii?Q?YpCecGetsRoyk7NRXruNrtm2+mTTHeUOfPjj+XDXFGTkWsN0jUBU8Va5RICw?=
 =?us-ascii?Q?2iZj9N/E/FbZWsV9B0rO2/MzRPNPhTxzi921R8Srz8few2I4QHwPGx+vHyqh?=
 =?us-ascii?Q?fLPp9TT3mBb5D4Xy0Q01t4d5Ont1Uwaf9cd4Utj5D6NfahsB7zGW070n815K?=
 =?us-ascii?Q?OWnURQ+yBqoW/xHTDKTwWopxV6fvVLiHO9uih20vCf305JQO42WU25rhWXIe?=
 =?us-ascii?Q?xqIqy/jq2hYkfSlff88w59IMzW1IkA1cxyPQICNnS4H3v5/X079y/DM20xoR?=
 =?us-ascii?Q?wJXR2VVn2czvhhSlSJwCplKs/o8Vj1TCyAFH8ZJOB46BbrfpN4CXhPklsFy3?=
 =?us-ascii?Q?OKnkSWDlBp5Xr2nGV9oBV1k7F76BoZYAh1chFKfvP43mp/FVjAVGW106YtSz?=
 =?us-ascii?Q?KkBXRmDp17PiSbCssi+aY4+qEf2t/zxhNl6hZHNhOy0LjS2KGeTe2kzW+Lt3?=
 =?us-ascii?Q?pyDZ1MD4uPlpBwS6ZfQN0QCGLqN7aTSUrS1tBTXTd0nfUC5T2V/YT47Ax3BQ?=
 =?us-ascii?Q?jl0HbB4Z6XplmLdD66Pyj/F5HBN7d8wqvCKhc6oXAbaxoZaOjHiKiEa6QMQw?=
 =?us-ascii?Q?2TpwsB+GTs4PUJwycLv4TKoImHjrmSxMQJB9W1nuBtUeTKD9Gs7FWE+Aa910?=
 =?us-ascii?Q?FzuJEb54GrKL5S+F7mwoCqHpuyP+cyvTl9xMFxMsarZgU8QmEDojCHnHEl5m?=
 =?us-ascii?Q?Ixen+/bUjG/P2A9XfnaocK9x9JahSe4oiuzCaURTp5+TL6fhl/D/mMurHSd3?=
 =?us-ascii?Q?Ge8Dz/51Fy/S/8q73wgr7+FcI5VOZiwRk9dVK63HxVFVMwEX/DWg3obAIOD2?=
 =?us-ascii?Q?G7ykWPljUezYWnqLm4FfL672H5iYBgYXDxovMo/gPapVResMGLC4TFkw+w3B?=
 =?us-ascii?Q?8AiVnp26UIcCe1KlEkdAfrZxOnL80DeYYnfRl0AWm9lvmJYUo3Uf9SWWcPEq?=
 =?us-ascii?Q?U7jMAwTDt6t64yscAb779bKzA5zaA5QEdjf2smxNOHo4nfo66i/JOLqEdS1C?=
 =?us-ascii?Q?VAoHDJ/yqDzmBMWgMUygEILSHz2iumcWF9pHwNWtE5UGZWtEgskSOucOS35l?=
 =?us-ascii?Q?9V66fm1GlCu0eLJNbsEFbc9a04VeNMt9B1c7rFziRGe2ebE7la+CtMTM140o?=
 =?us-ascii?Q?Ivu8kR5/7Zw4G/xnB0k2hTYngaXaqrT6rXh3wSoPwBVyhdIIis3Ab3CNPDDZ?=
 =?us-ascii?Q?8DnX5jW+lX84XMbuyQvS9yCNh+Jp634NO8gTCAGrCMTaEgmb35ID1a6J3GXb?=
 =?us-ascii?Q?afdOEtv5TsJraD5H+yRZSdoQWR99h7Cw7bg3JRucJQu4odzpNvjEdALi6FLx?=
 =?us-ascii?Q?ySNrW17kTJde+T8SIRQG41qF/OlooJbU9o3u5emSwcnpMx9ITGlA9rsrqk9S?=
 =?us-ascii?Q?QnYLjkKCvzbGybM5C2EXQ0VK+JTcc8wEYw6hyCS4jh0DNnNhFpIcFetzgqe4?=
 =?us-ascii?Q?VDiZaGSkJyQx5n+5naXVxRD/2M4qD6TVc4PmGnd4UqXw9zMcXiCkLVdo0edc?=
 =?us-ascii?Q?CA=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96b9c76a-e3a2-4fed-b65d-08dd2efc35ad
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6969.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 09:18:12.6582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YTqhlgzj0zsGkKrmixJZx/HMc6zeubT4axwbr7GgQvMFS3sRSfzxjxnk2a4vnDdOEiSZzC8Ptb+8CGDpm83VFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB10607
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 07 Jan 2025 09:18:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16973

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Update npmsw test cases to new lockfile format. The old lockfile format
is required by npm 6 / Node.js 14 which is out of maintenance [2].

[1] https://docs.npmjs.com/cli/v6/configuring-npm/package-lock-json
[2] https://nodejs.org/en/about/previous-releases

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

 lib/bb/tests/fetch.py | 135 +++++++++++++++++-------------------------
 1 file changed, 54 insertions(+), 81 deletions(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 6dda0d381..b89348236 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -2843,23 +2843,25 @@ class NPMTest(FetcherTest):
     @skipIfNoNetwork()
     def test_npmsw(self):
         swfile =3D self.create_shrinkwrap_file({
-            'dependencies': {
-                'array-flatten': {
+            'packages': {
+                'node_modules/array-flatten': {
                     'version': '1.1.1',
                     'resolved': 'https://registry.npmjs.org/array-flatten/=
-/array-flatten-1.1.1.tgz',
                     'integrity': 'sha1-ml9pkFGx5wczKPKgCJaLZOopVdI=3D',
                     'dependencies': {
-                        'content-type': {
-                            'version': 'https://registry.npmjs.org/content=
-type/-/content-type-1.0.4.tgz',
-                            'integrity': 'sha512-hIP3EEPs8tB9AT1L+NUqtwOAp=
s4mk2Zob89MWXMHjHWg9milF/j4osnnQLXBCBFBk/tvIG/tUc9mOUJiPBhPXA=3D=3D',
-                            'dependencies': {
-                                'cookie': {
-                                    'version': 'git+https://github.com/jsh=
ttp/cookie.git#aec1177c7da67e3b3273df96cf476824dbc9ae09',
-                                    'from': 'git+https://github.com/jshttp=
/cookie.git'
-                                }
-                            }
-                        }
+                        'content-type': "1.0.4"
                     }
+                },
+                'node_modules/array-flatten/node_modules/content-type': {
+                    'version': '1.0.4',
+                    'resolved': 'https://registry.npmjs.org/content-type/-=
/content-type-1.0.4.tgz',
+                    'integrity': 'sha512-hIP3EEPs8tB9AT1L+NUqtwOAps4mk2Zob=
89MWXMHjHWg9milF/j4osnnQLXBCBFBk/tvIG/tUc9mOUJiPBhPXA=3D=3D',
+                    'dependencies': {
+                        'cookie': 'git+https://github.com/jshttp/cookie.gi=
t#aec1177c7da67e3b3273df96cf476824dbc9ae09'
+                    }
+                },
+                'node_modules/array-flatten/node_modules/content-type/node=
_modules/cookie': {
+                    'resolved': 'git+https://github.com/jshttp/cookie.git#=
aec1177c7da67e3b3273df96cf476824dbc9ae09'
                 }
             }
         })
@@ -2877,10 +2879,9 @@ class NPMTest(FetcherTest):
     @skipIfNoNetwork()
     def test_npmsw_git(self):
         swfile =3D self.create_shrinkwrap_file({
-            'dependencies': {
-                'cookie': {
-                    'version': 'github:jshttp/cookie.git#aec1177c7da67e3b3=
273df96cf476824dbc9ae09',
-                    'from': 'github:jshttp/cookie.git'
+            'packages': {
+                'node_modules/cookie': {
+                    'resolved': 'git+https://github.com/jshttp/cookie.git#=
aec1177c7da67e3b3273df96cf476824dbc9ae09'
                 }
             }
         })
@@ -2888,40 +2889,16 @@ class NPMTest(FetcherTest):
         fetcher.download()
         self.assertTrue(os.path.exists(os.path.join(self.dldir, 'git2', 'g=
ithub.com.jshttp.cookie.git')))
=20
-        swfile =3D self.create_shrinkwrap_file({
-            'dependencies': {
-                'cookie': {
-                    'version': 'jshttp/cookie.git#aec1177c7da67e3b3273df96=
cf476824dbc9ae09',
-                    'from': 'jshttp/cookie.git'
-                }
-            }
-        })
-        fetcher =3D bb.fetch.Fetch(['npmsw://' + swfile], self.d)
-        fetcher.download()
-        self.assertTrue(os.path.exists(os.path.join(self.dldir, 'git2', 'g=
ithub.com.jshttp.cookie.git')))
-
-        swfile =3D self.create_shrinkwrap_file({
-            'dependencies': {
-                'nodejs': {
-                    'version': 'gitlab:gitlab-examples/nodejs.git#892a1f16=
725e56cc3a2cb0d677be42935c8fc262',
-                    'from': 'gitlab:gitlab-examples/nodejs'
-                }
-            }
-        })
-        fetcher =3D bb.fetch.Fetch(['npmsw://' + swfile], self.d)
-        fetcher.download()
-        self.assertTrue(os.path.exists(os.path.join(self.dldir, 'git2', 'g=
itlab.com.gitlab-examples.nodejs.git')))
-
     @skipIfNoNetwork()
     def test_npmsw_dev(self):
         swfile =3D self.create_shrinkwrap_file({
-            'dependencies': {
-                'array-flatten': {
+            'packages': {
+                'node_modules/array-flatten': {
                     'version': '1.1.1',
                     'resolved': 'https://registry.npmjs.org/array-flatten/=
-/array-flatten-1.1.1.tgz',
                     'integrity': 'sha1-ml9pkFGx5wczKPKgCJaLZOopVdI=3D'
                 },
-                'content-type': {
+                'node_modules/content-type': {
                     'version': '1.0.4',
                     'resolved': 'https://registry.npmjs.org/content-type/-=
/content-type-1.0.4.tgz',
                     'integrity': 'sha512-hIP3EEPs8tB9AT1L+NUqtwOAps4mk2Zob=
89MWXMHjHWg9milF/j4osnnQLXBCBFBk/tvIG/tUc9mOUJiPBhPXA=3D=3D',
@@ -2943,8 +2920,8 @@ class NPMTest(FetcherTest):
     @skipIfNoNetwork()
     def test_npmsw_destsuffix(self):
         swfile =3D self.create_shrinkwrap_file({
-            'dependencies': {
-                'array-flatten': {
+            'packages': {
+                'node_modules/array-flatten': {
                     'version': '1.1.1',
                     'resolved': 'https://registry.npmjs.org/array-flatten/=
-/array-flatten-1.1.1.tgz',
                     'integrity': 'sha1-ml9pkFGx5wczKPKgCJaLZOopVdI=3D'
@@ -2958,8 +2935,8 @@ class NPMTest(FetcherTest):
=20
     def test_npmsw_no_network_no_tarball(self):
         swfile =3D self.create_shrinkwrap_file({
-            'dependencies': {
-                'array-flatten': {
+            'packages': {
+                'node_modules/array-flatten': {
                     'version': '1.1.1',
                     'resolved': 'https://registry.npmjs.org/array-flatten/=
-/array-flatten-1.1.1.tgz',
                     'integrity': 'sha1-ml9pkFGx5wczKPKgCJaLZOopVdI=3D'
@@ -2981,8 +2958,8 @@ class NPMTest(FetcherTest):
         self.d.setVar('BB_NO_NETWORK', '1')
         # Fetch again
         swfile =3D self.create_shrinkwrap_file({
-            'dependencies': {
-                'array-flatten': {
+            'packages': {
+                'node_modules/array-flatten': {
                     'version': '1.1.1',
                     'resolved': 'https://registry.npmjs.org/array-flatten/=
-/array-flatten-1.1.1.tgz',
                     'integrity': 'sha1-ml9pkFGx5wczKPKgCJaLZOopVdI=3D'
@@ -2998,8 +2975,8 @@ class NPMTest(FetcherTest):
     def test_npmsw_npm_reusability(self):
         # Fetch once with npmsw
         swfile =3D self.create_shrinkwrap_file({
-            'dependencies': {
-                'array-flatten': {
+            'packages': {
+                'node_modules/array-flatten': {
                     'version': '1.1.1',
                     'resolved': 'https://registry.npmjs.org/array-flatten/=
-/array-flatten-1.1.1.tgz',
                     'integrity': 'sha1-ml9pkFGx5wczKPKgCJaLZOopVdI=3D'
@@ -3020,8 +2997,8 @@ class NPMTest(FetcherTest):
     def test_npmsw_bad_checksum(self):
         # Try to fetch with bad checksum
         swfile =3D self.create_shrinkwrap_file({
-            'dependencies': {
-                'array-flatten': {
+            'packages': {
+                'node_modules/array-flatten': {
                     'version': '1.1.1',
                     'resolved': 'https://registry.npmjs.org/array-flatten/=
-/array-flatten-1.1.1.tgz',
                     'integrity': 'sha1-gfNEp2hqgLTFKT6P3AsBYMgsBqg=3D'
@@ -3033,8 +3010,8 @@ class NPMTest(FetcherTest):
             fetcher.download()
         # Fetch correctly to get a tarball
         swfile =3D self.create_shrinkwrap_file({
-            'dependencies': {
-                'array-flatten': {
+            'packages': {
+                'node_modules/array-flatten': {
                     'version': '1.1.1',
                     'resolved': 'https://registry.npmjs.org/array-flatten/=
-/array-flatten-1.1.1.tgz',
                     'integrity': 'sha1-ml9pkFGx5wczKPKgCJaLZOopVdI=3D'
@@ -3072,8 +3049,8 @@ class NPMTest(FetcherTest):
         # Fetch again
         self.assertFalse(os.path.exists(ud.localpath))
         swfile =3D self.create_shrinkwrap_file({
-            'dependencies': {
-                'array-flatten': {
+            'packages': {
+                'node_modules/array-flatten': {
                     'version': '1.1.1',
                     'resolved': 'https://registry.npmjs.org/array-flatten/=
-/array-flatten-1.1.1.tgz',
                     'integrity': 'sha1-ml9pkFGx5wczKPKgCJaLZOopVdI=3D'
@@ -3100,8 +3077,8 @@ class NPMTest(FetcherTest):
         # Fetch again with invalid url
         self.assertFalse(os.path.exists(ud.localpath))
         swfile =3D self.create_shrinkwrap_file({
-            'dependencies': {
-                'array-flatten': {
+            'packages': {
+                'node_modules/array-flatten': {
                     'version': '1.1.1',
                     'resolved': 'https://invalid',
                     'integrity': 'sha1-ml9pkFGx5wczKPKgCJaLZOopVdI=3D'
@@ -3114,29 +3091,25 @@ class NPMTest(FetcherTest):
=20
     @skipIfNoNetwork()
     def test_npmsw_bundled(self):
-        for packages_key, package_prefix, bundled_key in [
-            ('dependencies', '', 'bundled'),
-            ('packages', 'node_modules/', 'inBundle')
-        ]:
-            swfile =3D self.create_shrinkwrap_file({
-                packages_key: {
-                    package_prefix + 'array-flatten': {
-                        'version': '1.1.1',
-                        'resolved': 'https://registry.npmjs.org/array-flat=
ten/-/array-flatten-1.1.1.tgz',
-                        'integrity': 'sha1-ml9pkFGx5wczKPKgCJaLZOopVdI=3D'
-                    },
-                    package_prefix + 'content-type': {
-                        'version': '1.0.4',
-                        'resolved': 'https://registry.npmjs.org/content-ty=
pe/-/content-type-1.0.4.tgz',
-                        'integrity': 'sha512-hIP3EEPs8tB9AT1L+NUqtwOAps4mk=
2Zob89MWXMHjHWg9milF/j4osnnQLXBCBFBk/tvIG/tUc9mOUJiPBhPXA=3D=3D',
-                        bundled_key: True
-                    }
+        swfile =3D self.create_shrinkwrap_file({
+            'packages': {
+                'node_modules/array-flatten': {
+                    'version': '1.1.1',
+                    'resolved': 'https://registry.npmjs.org/array-flatten/=
-/array-flatten-1.1.1.tgz',
+                    'integrity': 'sha1-ml9pkFGx5wczKPKgCJaLZOopVdI=3D'
+                },
+                'node_modules/content-type': {
+                    'version': '1.0.4',
+                    'resolved': 'https://registry.npmjs.org/content-type/-=
/content-type-1.0.4.tgz',
+                    'integrity': 'sha512-hIP3EEPs8tB9AT1L+NUqtwOAps4mk2Zob=
89MWXMHjHWg9milF/j4osnnQLXBCBFBk/tvIG/tUc9mOUJiPBhPXA=3D=3D',
+                    'inBundle': True
                 }
-            })
-            fetcher =3D bb.fetch.Fetch(['npmsw://' + swfile], self.d)
-            fetcher.download()
-            self.assertTrue(os.path.exists(os.path.join(self.dldir, 'npm2'=
, 'array-flatten-1.1.1.tgz')))
-            self.assertFalse(os.path.exists(os.path.join(self.dldir, 'npm2=
', 'content-type-1.0.4.tgz')))
+            }
+        })
+        fetcher =3D bb.fetch.Fetch(['npmsw://' + swfile], self.d)
+        fetcher.download()
+        self.assertTrue(os.path.exists(os.path.join(self.dldir, 'npm2', 'a=
rray-flatten-1.1.1.tgz')))
+        self.assertFalse(os.path.exists(os.path.join(self.dldir, 'npm2', '=
content-type-1.0.4.tgz')))
=20
 class GitSharedTest(FetcherTest):
     def setUp(self):
--=20
2.39.5


