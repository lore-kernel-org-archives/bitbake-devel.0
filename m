Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B416E77192
	for <webhook@archiver.kernel.org>; Fri, 20 Dec 2024 11:26:41 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.118])
 by mx.groups.io with SMTP id smtpd.web11.149744.1734693993154756588
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 20 Dec 2024 03:26:33 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=bXZJQXfT;
 spf=pass (domain: weidmueller.com, ip: 40.107.20.118, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k7gT83QPELUNx/jFHit73ks08XqB09WO8xqAeKN94oVp5a0BVVgidWkp76UOOTbml0u2NeyzUduuUbAplmokmdf8XAxxWh8GjsaAShVcNkCB6gTAa/IQCCHX424kK1SXIOMSJuVVr9Lpno1C9++Ck5n9gHjm/MicYLA7y1Kv7CcObk6INrjTbxaCsRWv8Kd9tQ55fdmBREPPVLfkBVH/+vlkYt8Ho34XvrNDfqjds5qU1cJUIvw535jMtpxGrrM7s2bBHgc3eFlTncOmwEXQe8HkVhtF0FUYehVdhDVn0Ar4O9wWUENIzIeTATTUdVBzsQOwVpqQu/X5RNUknSJzPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tECYzinVbDQxMsSSm81qc/TD7t7q7X2mvyztaVAu010=;
 b=Om8y1Md/q+l3Z152K5wULO47awSn6wAVAPSF5jTh+hSFalx+/yM9e3lMK4+ih3LbKlPVda8dTn6ZQ9o87AfGmJpiN6vmHM1/rpUPN90/y8q8QZOfmThjuaw0TKwmZf+I1oRdHa9FQsbdGIsU6+F70XR82T6MXf+JkgPpdg9hiKNPtRWj5wMPCBs4ovBZh6qFNnN6LOWXep08Aw9jRl/VqEAUETrr7pIfoGUe5oqRihMShQwJp6OpoZ7Nyaf7J5afm9YYbTHuqMucGKfDcphdQNemOnieCVRwTxN7jHJA0uFvHvZ2QVY+kKrHNGF/+j7TAsZKH2tpSklKWU9JQ68kFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tECYzinVbDQxMsSSm81qc/TD7t7q7X2mvyztaVAu010=;
 b=bXZJQXfTaJRPq3dzbOJxrfha5xezB62n6dTZYqEeW6iaTyC3L+sMOPmXER9S/eq47uGeWBbiIbhhQDXB9swAMYlV7NGcaD8IGbqVVmvNnY/3zXssEZK+bhZgwlkK/KF+2dqHH/bDyeJT4WsZ5ghSRLHgvhMztIljGCnKk1XLQPcqRgpFwCnWdMhuP1OD74T9Bu+MjfNXEXy5pu+An+R2t/I3qmGI0PuypATIdkkXrNL9irU2MvMC+xZ9F9WKvlEb47bWwgZmsoHCU3Z7B0AJcgZ/eQr6gYrpWGNij023Z8ir2niIdU8Mj3uEdXQPS05/DI7fT+/DrPZuwy75Ld1S8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com (2603:10a6:102:1d8::23)
 by DU0PR08MB8256.eurprd08.prod.outlook.com (2603:10a6:10:410::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.14; Fri, 20 Dec
 2024 11:26:25 +0000
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4]) by PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4%3]) with mapi id 15.20.8272.013; Fri, 20 Dec 2024
 11:26:25 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [RFC PATCH 03/21] tests: fetch: replace [url] with urls for npm
Date: Fri, 20 Dec 2024 12:25:54 +0100
Message-ID: <20241220112613.22647-4-stefan.herbrechtsmeier-oss@weidmueller.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2ad32487-4c16-456a-8537-08dd20e92373
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|52116014|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?s3sQEqh8SEv4A8HRNdW5RBsHt5EZ0RgPRPiXkuuzYXoIncyvy2SjJwz7/2TB?=
 =?us-ascii?Q?q1x+i/UoYiQUQrvEBRJkX6OQi8hOugftrhnBMA5HYdVYFjWqDlwV4qLbq8+9?=
 =?us-ascii?Q?8y6JnTSf5rGuE6jMrw/iEfSedoEYLVRXeFTJGokNs8eTDU194ZOecUjxePSw?=
 =?us-ascii?Q?tJSzWAqfe33WyzGVrMlvBxWXoocWdXM3DoxlZT/mJ1d3WLgkgIKqBHQ5tjBh?=
 =?us-ascii?Q?mYXeXWUcFPcXgiQn4n6iqPIP0IHMnmh0FNL39HRhDeAxKbrua8nMwkqWHTrH?=
 =?us-ascii?Q?A3XarorvH6Sk2wcEZiORfznJrYfhXzdjTArDEkW96+f+ndAN4zNMyG3yvoCH?=
 =?us-ascii?Q?QJo14O7+HsIi9xIb59SbIPWLiMS005BzSCQ3FVTdgfv4pS7uFiZipEUUsGPt?=
 =?us-ascii?Q?pJ/sjrJMzZyvsec+j2JysV3o+p9PvVKBnC/71xyjt/y9W1z+b76cxshUClkb?=
 =?us-ascii?Q?GFpsIGvVbH2y8FpHgPTfnOOP58tAm+e/LsvlK1u4AugygZxnRqVHSsMWKq/Q?=
 =?us-ascii?Q?nsnX4Un7f6MugjQN0gu937tqvxatNmZpTb0k2Eq6y3FtXMU7lDxo/uZSPnK3?=
 =?us-ascii?Q?lQqEvWkzbVeteGHvY1hLLdfbkeKOkc8rDYfqS9NMwiJ42FlsKswZZdZEtcyB?=
 =?us-ascii?Q?4pjzbzaXulvLYSNJK6ReMoW26Ul06haCwdQjiKdN8UCjH42tv5Opki8D1hru?=
 =?us-ascii?Q?bwe8BIV6/gHcfE5ktM7u+NeukOYuZrZW2QzRVa1d9LeapunVR0Wk3vdrrqXW?=
 =?us-ascii?Q?RnPpWVb7NGs2MPqaFq2pWKIuHCqm8Bp3SR7ENKCGCm90UJZAlc0aiLdRcwsw?=
 =?us-ascii?Q?N9OUBPDQELGhNmZ2ijNSp9mqoexKYFoYF/Nf6kXdbbRTkD0mCl5s7EKLJfE5?=
 =?us-ascii?Q?LcMpXdE6/wHi6wN+2iaWz3rQOOtD7JhEjT7n5RI26dPiI0dsHMHkFsCJ/RbF?=
 =?us-ascii?Q?YaZTNUuqaVreE6iCiK16UhW/MKLcSn1bv677+VC3oxlyyXQ1UMsEwRD6ulJF?=
 =?us-ascii?Q?uMTLUEZwzStHU+29AgW30+C1AOYSnbrCi8RT0sDkyCMEqCaZB4sWG9puZpK7?=
 =?us-ascii?Q?nQ/xqgFD5cQBXgTis4mtZERs7TjlyDCILHO22ilJE7pt/JQRMeE9+JluoYkn?=
 =?us-ascii?Q?JJfSX/CLaWjcdYvcUeXJrx1gp5C+JqVzQtUewC+Y7P2Ew1JwYjQPNcVv/YBk?=
 =?us-ascii?Q?qNxfzqi/cblKLmHVdFmJvIdQx8FcZzVVnupzGGg4Rl3bPbeevmx77Z7tedq5?=
 =?us-ascii?Q?BOgJEBfzHOv+owrd/p4rBFYfa8zJD9d6g/B7IY9bt/4HfYak48d3iMrh4eEK?=
 =?us-ascii?Q?2bu7h6ashdCUc/Q9hWfpbjnv5Yuhna1CZV/VFRwkIhsFGfL8YuOZZb/kC5hZ?=
 =?us-ascii?Q?YS4HMECORkZeR0IfYSi+HbSHRYRxPfkbSC7I2gI3hhHREsMhm73G6Bo2sxrJ?=
 =?us-ascii?Q?cWkw3UPAReD9ZNiAz+Pse512nnmRCtr9?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6969.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?E1sUap5oPuFP+LfqJy71/NVxeAdP0pHHLLPFpqwbHQUOgL3J4aKHZoHEfgqD?=
 =?us-ascii?Q?SkylJb8daf62azJzqmqJ07WqmWui6isahjetFmzfV1L0ezx0wuNwEhaNg053?=
 =?us-ascii?Q?fi9Fx7eUYMYRn2SMlCKu9oxKa2lTEXfnYLMYOL0zEjnRv3hirBsUlMgHE5Jl?=
 =?us-ascii?Q?GEOi/vbxPIqEe+eGmsDyzflEGUVRIOHRjiMFY9GH8cHVllop24urrpu35eag?=
 =?us-ascii?Q?cTmHEr/Mlj9VVQXfCSf2xE0v5YHZ2lY1Elqj0oNYS04mjZU6x77h7MXVojea?=
 =?us-ascii?Q?XPT3Iy3Cg/cYmWNKZ/oCqozk60xDBcRM2jlkYOoZq9VSEuwlpI/5bPuxtMTH?=
 =?us-ascii?Q?DebaN8YiHUFFLW/Rgmamg4IDSqkhPGL7RafcI/GricTaxt98jk/nKn2Ym5pc?=
 =?us-ascii?Q?mTW2+oNXOX7uJTp6aVbjmVN1gByw3qlVMIQJp8ycGXHS3v63dJbeG9qn7OKA?=
 =?us-ascii?Q?InuwU4GPtmB8y7TLa+L+rGogRgjNFflqoFcPWPBB6d31Lwc2gsKQN2UoKeK5?=
 =?us-ascii?Q?LQxGSf3mQuZJlQ0863g9SvlwalbB84vJbPESGrmFEfF1+51FRGxlDIiyqWH1?=
 =?us-ascii?Q?3SCspNSDI1pXkfb2LulXgcjj0BjayZsiJutqWinJnmpgucVOLqSoVA7SUePv?=
 =?us-ascii?Q?v8YmO+VpDq+HtFBnuT7phslKzZF6iIgoq7hMyfPS3OLGsEOMKsJcmlnzT7Zh?=
 =?us-ascii?Q?I6RGgGyInQxbArxTXE1ocyLdqoOuSsD7mxV/NPUCaAxkU13fLEgTwCmlPGLy?=
 =?us-ascii?Q?bA8MOexa6ld/LjXp4k70fWs5Hu6anT/Drn3eNf025M9ZB5/V3OFimg0/XGY9?=
 =?us-ascii?Q?bVQYLaaEcbeCQTaAvWr6VpLR3xtcXPRU8agVMHW1Zy8NkhfGr9pcf8ny3WFD?=
 =?us-ascii?Q?BCy4EyeZ4H1NQjWwZOlGpO3hBMgsvuTjipi2sr2YUCCNJtJm6BdkboJYeB5d?=
 =?us-ascii?Q?8MMi0Jc/u39M8xulIbun4k7YjgMGbMXeEaLC/1bioGFAoDenz21WrSy98I7w?=
 =?us-ascii?Q?QAivN3lxzQKpgw1y6rFyuREj+/5yArm3XoHHX0uV3CWsFZL2bzfxNKGTblQd?=
 =?us-ascii?Q?qxi3suhqaOZWRmyXqXODg4RMjYqJq8plGmiQpLkLTotOmy7LiXbdhDhOH8Ku?=
 =?us-ascii?Q?jSLkisSfGB4p661Gkd+srU7rMOOrODng/EdmM1uSJe1tdUI9438SxNTu8bNZ?=
 =?us-ascii?Q?d3JBxnrE9xtO/zZHP4xvxcs+kxYL4Hsx5/SwriUtkEHj4pNSknTLgou0rO4s?=
 =?us-ascii?Q?EtrKoM7f6AQZslKJhrFnp4gicfkxp+dE1I91Rgk7Sv6LajnP2LFDQPxF3t7+?=
 =?us-ascii?Q?5nZ1JpVjKm8h21SKiV6Wk56DSTU22uRcfd7yZMXstiwFoUAXyeM5NJi51qq7?=
 =?us-ascii?Q?Nv2IZ3L484g3fuxL12zk4+HDKcWbiOIIO8srh9pDDKxjAdtQrv3c8Gxkr2h3?=
 =?us-ascii?Q?r3bAligp+wZOOO+iQzoT/Imb2nCmvN1VL7Mj5CVRHBi1H+dbs0Pso3SjcPPw?=
 =?us-ascii?Q?KnM6N9WzvqT6C0e/vifXjF1qGtKOx/i72biKvvvxwhYB7py/l1+CxyF+DNHo?=
 =?us-ascii?Q?Du+P8gvwI8wWydFhC9t1BqeXfUMl5TlP3RauQuIArJ7MupDLuVaIJV2mliil?=
 =?us-ascii?Q?TA=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ad32487-4c16-456a-8537-08dd20e92373
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6969.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 11:26:25.1848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jID07k0939LSwM/W3bgsLddUAnh7IHzb1ntanmjaJaAntZGzWtp4+LvzaDANR2TwAkhizCroEijV/iIM9P7C1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8256
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 20 Dec 2024 11:26:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16923

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Replace [url] with urls to simplify future modifications.

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

 lib/bb/tests/fetch.py | 66 +++++++++++++++++++++----------------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index b89348236..c5ec84dc5 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -2627,8 +2627,8 @@ class NPMTest(FetcherTest):
     @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npm(self):
-        url =3D 'npm://registry.npmjs.org;package=3D@savoirfairelinux/node=
-server-example;version=3D1.0.0'
-        fetcher =3D bb.fetch.Fetch([url], self.d)
+        urls =3D ['npm://registry.npmjs.org;package=3D@savoirfairelinux/no=
de-server-example;version=3D1.0.0']
+        fetcher =3D bb.fetch.Fetch(urls, self.d)
         ud =3D fetcher.ud[fetcher.urls[0]]
         fetcher.download()
         self.assertTrue(os.path.exists(ud.localpath))
@@ -2641,9 +2641,9 @@ class NPMTest(FetcherTest):
     @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npm_bad_checksum(self):
-        url =3D 'npm://registry.npmjs.org;package=3D@savoirfairelinux/node=
-server-example;version=3D1.0.0'
+        urls =3D ['npm://registry.npmjs.org;package=3D@savoirfairelinux/no=
de-server-example;version=3D1.0.0']
         # Fetch once to get a tarball
-        fetcher =3D bb.fetch.Fetch([url], self.d)
+        fetcher =3D bb.fetch.Fetch(urls, self.d)
         ud =3D fetcher.ud[fetcher.urls[0]]
         fetcher.download()
         self.assertTrue(os.path.exists(ud.localpath))
@@ -2660,9 +2660,9 @@ class NPMTest(FetcherTest):
     @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npm_premirrors(self):
-        url =3D 'npm://registry.npmjs.org;package=3D@savoirfairelinux/node=
-server-example;version=3D1.0.0'
+        urls =3D ['npm://registry.npmjs.org;package=3D@savoirfairelinux/no=
de-server-example;version=3D1.0.0']
         # Fetch once to get a tarball
-        fetcher =3D bb.fetch.Fetch([url], self.d)
+        fetcher =3D bb.fetch.Fetch(urls, self.d)
         ud =3D fetcher.ud[fetcher.urls[0]]
         fetcher.download()
         self.assertTrue(os.path.exists(ud.localpath))
@@ -2682,7 +2682,7 @@ class NPMTest(FetcherTest):
         # while the fetcher object exists, which it does when we rename th=
e
         # download directory to "mirror" above. Thus we need a new fetcher=
 to go
         # with the now empty download directory.
-        fetcher =3D bb.fetch.Fetch([url], self.d)
+        fetcher =3D bb.fetch.Fetch(urls, self.d)
         ud =3D fetcher.ud[fetcher.urls[0]]
         fetcher.download()
         self.assertTrue(os.path.exists(ud.localpath))
@@ -2690,9 +2690,9 @@ class NPMTest(FetcherTest):
     @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npm_premirrors_with_specified_filename(self):
-        url =3D 'npm://registry.npmjs.org;package=3D@savoirfairelinux/node=
-server-example;version=3D1.0.0'
+        urls =3D ['npm://registry.npmjs.org;package=3D@savoirfairelinux/no=
de-server-example;version=3D1.0.0']
         # Fetch once to get a tarball
-        fetcher =3D bb.fetch.Fetch([url], self.d)
+        fetcher =3D bb.fetch.Fetch(urls, self.d)
         ud =3D fetcher.ud[fetcher.urls[0]]
         fetcher.download()
         self.assertTrue(os.path.exists(ud.localpath))
@@ -2712,8 +2712,8 @@ class NPMTest(FetcherTest):
     @skipIfNoNetwork()
     def test_npm_mirrors(self):
         # Fetch once to get a tarball
-        url =3D 'npm://registry.npmjs.org;package=3D@savoirfairelinux/node=
-server-example;version=3D1.0.0'
-        fetcher =3D bb.fetch.Fetch([url], self.d)
+        urls =3D ['npm://registry.npmjs.org;package=3D@savoirfairelinux/no=
de-server-example;version=3D1.0.0']
+        fetcher =3D bb.fetch.Fetch(urls, self.d)
         ud =3D fetcher.ud[fetcher.urls[0]]
         fetcher.download()
         self.assertTrue(os.path.exists(ud.localpath))
@@ -2737,8 +2737,8 @@ class NPMTest(FetcherTest):
     @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npm_destsuffix_downloadfilename(self):
-        url =3D 'npm://registry.npmjs.org;package=3D@savoirfairelinux/node=
-server-example;version=3D1.0.0;destsuffix=3Dfoo/bar;downloadfilename=3Dfoo=
-bar.tgz'
-        fetcher =3D bb.fetch.Fetch([url], self.d)
+        urls =3D ['npm://registry.npmjs.org;package=3D@savoirfairelinux/no=
de-server-example;version=3D1.0.0;destsuffix=3Dfoo/bar;downloadfilename=3Df=
oo-bar.tgz']
+        fetcher =3D bb.fetch.Fetch(urls, self.d)
         fetcher.download()
         self.assertTrue(os.path.exists(os.path.join(self.dldir, 'npm2', 'f=
oo-bar.tgz')))
         fetcher.unpack(self.unpackdir)
@@ -2746,18 +2746,18 @@ class NPMTest(FetcherTest):
         self.assertTrue(os.path.exists(os.path.join(unpackdir, 'package.js=
on')))
=20
     def test_npm_no_network_no_tarball(self):
-        url =3D 'npm://registry.npmjs.org;package=3D@savoirfairelinux/node=
-server-example;version=3D1.0.0'
+        urls =3D ['npm://registry.npmjs.org;package=3D@savoirfairelinux/no=
de-server-example;version=3D1.0.0']
         self.d.setVar('BB_NO_NETWORK', '1')
-        fetcher =3D bb.fetch.Fetch([url], self.d)
+        fetcher =3D bb.fetch.Fetch(urls, self.d)
         with self.assertRaises(bb.fetch2.NetworkAccess):
             fetcher.download()
=20
     @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npm_no_network_with_tarball(self):
-        url =3D 'npm://registry.npmjs.org;package=3D@savoirfairelinux/node=
-server-example;version=3D1.0.0'
+        urls =3D ['npm://registry.npmjs.org;package=3D@savoirfairelinux/no=
de-server-example;version=3D1.0.0']
         # Fetch once to get a tarball
-        fetcher =3D bb.fetch.Fetch([url], self.d)
+        fetcher =3D bb.fetch.Fetch(urls, self.d)
         fetcher.download()
         # Disable network access
         self.d.setVar('BB_NO_NETWORK', '1')
@@ -2770,8 +2770,8 @@ class NPMTest(FetcherTest):
     @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npm_registry_alternate(self):
-        url =3D 'npm://skimdb.npmjs.com;package=3D@savoirfairelinux/node-s=
erver-example;version=3D1.0.0'
-        fetcher =3D bb.fetch.Fetch([url], self.d)
+        urls =3D ['npm://skimdb.npmjs.com;package=3D@savoirfairelinux/node=
-server-example;version=3D1.0.0']
+        fetcher =3D bb.fetch.Fetch(urls, self.d)
         fetcher.download()
         fetcher.unpack(self.unpackdir)
         unpackdir =3D os.path.join(self.unpackdir, 'npm')
@@ -2780,8 +2780,8 @@ class NPMTest(FetcherTest):
     @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npm_version_latest(self):
-        url =3D 'npm://registry.npmjs.org;package=3D@savoirfairelinux/node=
-server-example;version=3Dlatest'
-        fetcher =3D bb.fetch.Fetch([url], self.d)
+        url =3D ['npm://registry.npmjs.org;package=3D@savoirfairelinux/nod=
e-server-example;version=3Dlatest']
+        fetcher =3D bb.fetch.Fetch(urls, self.d)
         fetcher.download()
         fetcher.unpack(self.unpackdir)
         unpackdir =3D os.path.join(self.unpackdir, 'npm')
@@ -2790,46 +2790,46 @@ class NPMTest(FetcherTest):
     @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npm_registry_invalid(self):
-        url =3D 'npm://registry.invalid.org;package=3D@savoirfairelinux/no=
de-server-example;version=3D1.0.0'
-        fetcher =3D bb.fetch.Fetch([url], self.d)
+        urls =3D ['npm://registry.invalid.org;package=3D@savoirfairelinux/=
node-server-example;version=3D1.0.0']
+        fetcher =3D bb.fetch.Fetch(urls, self.d)
         with self.assertRaises(bb.fetch2.FetchError):
             fetcher.download()
=20
     @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npm_package_invalid(self):
-        url =3D 'npm://registry.npmjs.org;package=3D@savoirfairelinux/inva=
lid;version=3D1.0.0'
-        fetcher =3D bb.fetch.Fetch([url], self.d)
+        urls =3D ['npm://registry.npmjs.org;package=3D@savoirfairelinux/in=
valid;version=3D1.0.0']
+        fetcher =3D bb.fetch.Fetch(urls, self.d)
         with self.assertRaises(bb.fetch2.FetchError):
             fetcher.download()
=20
     @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npm_version_invalid(self):
-        url =3D 'npm://registry.npmjs.org;package=3D@savoirfairelinux/node=
-server-example;version=3Dinvalid'
+        urls =3D ['npm://registry.npmjs.org;package=3D@savoirfairelinux/no=
de-server-example;version=3Dinvalid']
         with self.assertRaises(bb.fetch2.ParameterError):
-            fetcher =3D bb.fetch.Fetch([url], self.d)
+            fetcher =3D bb.fetch.Fetch(urls, self.d)
=20
     @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npm_registry_none(self):
-        url =3D 'npm://;package=3D@savoirfairelinux/node-server-example;ve=
rsion=3D1.0.0'
+        urls =3D ['npm://;package=3D@savoirfairelinux/node-server-example;=
version=3D1.0.0']
         with self.assertRaises(bb.fetch2.MalformedUrl):
-            fetcher =3D bb.fetch.Fetch([url], self.d)
+            fetcher =3D bb.fetch.Fetch(urls, self.d)
=20
     @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npm_package_none(self):
-        url =3D 'npm://registry.npmjs.org;version=3D1.0.0'
+        urls =3D ['npm://registry.npmjs.org;version=3D1.0.0']
         with self.assertRaises(bb.fetch2.MissingParameterError):
-            fetcher =3D bb.fetch.Fetch([url], self.d)
+            fetcher =3D bb.fetch.Fetch(urls, self.d)
=20
     @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npm_version_none(self):
-        url =3D 'npm://registry.npmjs.org;package=3D@savoirfairelinux/node=
-server-example'
+        urls =3D ['npm://registry.npmjs.org;package=3D@savoirfairelinux/no=
de-server-example']
         with self.assertRaises(bb.fetch2.MissingParameterError):
-            fetcher =3D bb.fetch.Fetch([url], self.d)
+            fetcher =3D bb.fetch.Fetch(urls, self.d)
=20
     def create_shrinkwrap_file(self, data):
         import json
--=20
2.39.5


