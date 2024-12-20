Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 483BEE7718B
	for <webhook@archiver.kernel.org>; Fri, 20 Dec 2024 11:26:41 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.118])
 by mx.groups.io with SMTP id smtpd.web11.149744.1734693993154756588
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 20 Dec 2024 03:26:35 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=rvUaJ610;
 spf=pass (domain: weidmueller.com, ip: 40.107.20.118, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HSMd+QmbxzHR1cUPQk7XlTQz9rWS68ASE3ZhJaftQNrsWGEA7LEQoMchQ6fmU/OSL2Z96LUf2xt7gkWx4IQ3tFVhv7dbFpnwBT5JbhqyP/SZq3IhHhLNKdAf8LaqGYwSVXVKInPwM46NvIDirjTadbEVAFdntGk3YYZ/0bcLf9Stu9R8CWGoJ4Bd36+X9i22EM0OOi2IswPA6xuy+SdWR+/lcUF4utrRPzOYH935N5YGFsifiPZQGOcEeSfUPw3y+XCpwJPh6/GPjofGMroouFoFrW8+F2p7qvYSZDW5Ya/kNz25VUo9n7IPP1v0yEC7Ww/Kg8FQIMvJZjfhCmwHww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eTPvKRjIRugd0DfnF+zHlcgXQw+aAS5AGA5VFuhyZQI=;
 b=u1j27tXk80XQR2BBUG7IwWACHzvJsYupHr+MO5wUL9sMGcu+JOymLqM/IoH8IWL4o3Z9Ma/jSE6fyL2pZifOcPX64XC2D7UhFb6da+YdwfQM9krPfdoCOxccA+TyO3VhHFB3PTl69eRJqFVFFvZs+JQA1Yw++6lCPGDttPUuuRBL6dJlebuI461e0MbGwzDbfrrs4XMagIDu79jkbw6HcswrmYUFtsPybPCJQ1c9PVJmrbU34t/Z2OKUQTPJmTEHk6h6O35OL0GXrg5mcb+fXXdVvfd0V3bNuf+jBNTj30//RIDDHH/RSv/PwPrW5xYfRu3N0dlS8E775EFOC3pYeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eTPvKRjIRugd0DfnF+zHlcgXQw+aAS5AGA5VFuhyZQI=;
 b=rvUaJ6102i8PJSx0+iAlPhSm5yF+OViYAW1vnte5KjlMDJ9FgqEVjgIhUeZ5ER6nZPCdr2uKovY+ltPtBFaDDiMNLleDuEEt2C3R+H8XRbNRn3053QSWzojKEnZ7xnBNQ7E5Me/OuKEtqFYBa4dTHxTHeOgL6QnauuSUhsFmOT3eUxRwUcQO/YsBmeJyLvFdppxGii7RjR1+vVd6Ibb1CU7pH4BjKw0NCDk0lfMwnSIRFjae7Q/3jV8ODY8BLh5mdC+xQu/SpJAqHnKoJ7tuUM8HVHpjBmkguxyFDk/v+lWMQM3rVTcBGWPN49ekgBZ33vFLlhvgu6fS3VAx0TMBuw==
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
Subject: [RFC PATCH 01/21] tests: fetch: update npmsw tests to new lockfile format
Date: Fri, 20 Dec 2024 12:25:52 +0100
Message-ID: <20241220112613.22647-2-stefan.herbrechtsmeier-oss@weidmueller.com>
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
X-MS-Office365-Filtering-Correlation-Id: 412751f3-9efc-4887-3d59-08dd20e92312
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|52116014|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?CDv0kHn4W5CgaDnmynLTTBxz9yz1YHMHJHkk8JzFwvue7wv8FM6cSN/YCHpA?=
 =?us-ascii?Q?3sz47YBgxeSypfn512Sm884ogd0uR0m7HPjA87eE5t0tc4kSBNVmqGkkyF0+?=
 =?us-ascii?Q?ydQm3MPIPzX/K1Jvz8aURemceMJDJ7UccIYpzqBlKmjuuRsUh/slcZG9AaBJ?=
 =?us-ascii?Q?1Z0AQYVoFFCBqoZBLH3NhfoQOV5KJjog/CvEDa/CQheGaW9+EHsN0A62JfNZ?=
 =?us-ascii?Q?o84xBUuX9tCxtPzS0LxP4ZbEA6j/7F+OC5UsM+KRA1PnANIoqqfm1WhxjTbN?=
 =?us-ascii?Q?w0uEbw1iw5eG8bVcyZVbFjG/6wWePG9nadvxBON8dnPPd9QbksQOjLvhCsw6?=
 =?us-ascii?Q?mb6jm0I/EVUQi3IciTUamQb5lupckGoCFREVZ7xa9y88QY9NeCGHd134OMtv?=
 =?us-ascii?Q?ItkG0iT9jI91uJz9G8tJEV03fsNDgwLyqH7JGtlRQCy1euMy27+KGdnrSbiR?=
 =?us-ascii?Q?3dX1QyFXnuxGcs10aaKdjTW6wzkmIuPJgriX5WHBae/HtvljYSrm1HZPkIAk?=
 =?us-ascii?Q?o1mZm5swuazHHx6qg1Ww1ahke+sVDpc9wJ5vBzvNRT5JacQxZp+MIeuU6AQB?=
 =?us-ascii?Q?hQ40cHMMwH9u1xuF89mNUIhWAYs7vVMcC/p6OjcB0r3SBE+Da5UCLXszJ33j?=
 =?us-ascii?Q?kAPEMpGDlBof2BqtAhckbi5I5EQ9poZvAgahzt3XyaHr4CDYXGrTPyArUMNj?=
 =?us-ascii?Q?c2gSz+D/CYuSYxOIMFr4Jfullw0NrIM80LQ+SzfUKDL9LNtJbQZOzO5IX1tB?=
 =?us-ascii?Q?dPwq4bM6SkxK6FEh5LvQTgiioZRHt5H2bj8KPiHGB0mQJhdSIIyBnvlnS3MC?=
 =?us-ascii?Q?iRKoJsQroBYf6G1pb0ziIE68UvmXrJx91ClAUexZKYmoissNGL0tkz0DgUjv?=
 =?us-ascii?Q?uRULhcdaUHfSEmolUzVpJBq+bORgfeLYr8wuENbDftn3YNbZNE5v9FjQLz7S?=
 =?us-ascii?Q?xptzlPFm6Di+gUUsXPCAbwrn8e9ZuiCwgk50Dj1Re/Pda2cvY+wCZkmAZM+m?=
 =?us-ascii?Q?k1PDQK9eOGLtEfW8OGxetS+wkPXRwN3PD4Vud22M6ptZtfM6Varz4nqmOLrf?=
 =?us-ascii?Q?mMJRLrgD6+/a1/OSUQouZzodxoO/4g5mY0DDzIRba++pOWk9eSVqt+e84KkM?=
 =?us-ascii?Q?9nelLM9Usc7si8Zb+L+HGZhgKm1LIKxjBf4XCrc8dS5g6Fc7pIGWUFFqQ19X?=
 =?us-ascii?Q?zFFnypNCdFjgSEWG8XiinyEEBdd6JS29Fp+tx4zeX0705QqDvb2PQB/UuIyB?=
 =?us-ascii?Q?xB16FyxW+f/Ap23Qe8zLxh9l3izUGy/RcSyLHWKx+Yav0xBWWsuhAkTEV95n?=
 =?us-ascii?Q?qGK73KsizJrStmkDI9k9JZ9IqNo+jbzs1i+y/dlUoNpCz/nDoygl0nxlTgrK?=
 =?us-ascii?Q?Ui/7aYt1oHOKDSSmHg5Fq+A7JEqYGVzsvTUW9vgr/NoohVBrcg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6969.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?zKXgLSFdqAd4DXgqm2co+jDFq5GFX5L4pH5HpC5GFt48mYAE836vudmGDNh/?=
 =?us-ascii?Q?RqiXYYf5q/XtwLk2JXHNNPL7kHxlEF/bYnXcjef8lwOxIzJUKCfsE2hCuK03?=
 =?us-ascii?Q?isArAu3jgf8dSMXRHpfnqpL3eMw3EAo8SL3zjDSxXdH6lKZuYGbbjjZCNhc1?=
 =?us-ascii?Q?uRtlmslonjNbRK/JhvhUULtGDLkfkvFQNTIHu/vDERAkQkVqQiPqlVUewIwQ?=
 =?us-ascii?Q?sCkygSbFnWplypVyqXxZpKwV1CY6GeEZyoaJusHakNpmAemQ3dPaaOhPTdew?=
 =?us-ascii?Q?Sac2ReOgSKoUt//DPJmTPADVlX9vuTCyXMhd5UXU8A1g/yswSzhYjNAJ3LMZ?=
 =?us-ascii?Q?sWsoMUjezHr/6o6+vpNyAPoW5O4VU7paErwenx9wcecjHwaNpWBW/u7xDIYu?=
 =?us-ascii?Q?xXnWAMiHBfaSXu6KICL6asr5sJ7eXxV/nn5OoSAEiXRJ4hoP7w/f/J0tQ59g?=
 =?us-ascii?Q?n16x9KEEmusgCHCQqjemjSTVHyO5xk1NDovM7VTb73X+TH5B42rontQ69VDu?=
 =?us-ascii?Q?qB0yKo8IrCDtheGyQsunHc1Nv1+/6uuCTNT+0EhphAEPWadK+jIdYRkhL2eH?=
 =?us-ascii?Q?OTweV9+1c06xdVsWLQmCKTPUtw5L1Uxik9huNmmEbgj/AKQi5NUQxtAUe5LN?=
 =?us-ascii?Q?QsmfamzrGcrFF8ODF70DYvlevZZhVealncGw6t1mBQv5XrTtpi8jDav2mfi6?=
 =?us-ascii?Q?cB50zgpeKNs1ZbKDiLlWEfevqrG5YvCsqywreWipNffkkzP4LC+9SlNKXnpx?=
 =?us-ascii?Q?qOnTgyPt6B5/HKO0WzYr0uxkTL/JSutqnEblgOCCQFD1V8+gCKn/cTcWUNce?=
 =?us-ascii?Q?pZ1qH0xdCD1FWvVmSecZ0q1qTCAJS4Bo7v1gozmEKzQltgh+Wba4X4TBGvdA?=
 =?us-ascii?Q?UZlykk7Cwb90UbNfy2y0kbMEG4ZCJv9MFovaD5E2x4mgxCL8eoG69Y2CfaJn?=
 =?us-ascii?Q?PheSzjGC4+W5w4/pu1FVpUHWKaUh2jX0SzM8rxnV1FwFavJy11BavRIfDjJu?=
 =?us-ascii?Q?5M32IXvjIoHv8tqAloKnNko6pPi7SL4G2t+P4PEJvARPuKi8hl/tfoQsCITg?=
 =?us-ascii?Q?UDg82rQHqAhlRdOfTS+9BoucmlBynPVn8hPKh5LST4l6Fl0q4wyFO/ZPGdUh?=
 =?us-ascii?Q?hXoSehySV2lR7TckBs1gvB2PZu3kh3sjBbAhXDGydnXCjGJEerJ6++6v0TLm?=
 =?us-ascii?Q?gkmEHyopCEG5QY4SkKtmU7s/cZ3aGhDRXZ9WpQ1jaPiKbuFiwUnATvGTi2ra?=
 =?us-ascii?Q?2RJUb8Ljh9OI1p4ThjnqpzQlCf4veXI4j9lc+L7sEcxMWkKnOkpOC9A/y2be?=
 =?us-ascii?Q?5ynn7FgUMU8EYrThuk9vlSph96VQz9XdtHQFpR2+sWYOF+1Rl0xl+fubjZFJ?=
 =?us-ascii?Q?65pBxYTYY8pMhNmVRLBhq39+N6lFKLwDcJvtvZpqd3Azzgkj0J/SDQMhxoco?=
 =?us-ascii?Q?ER+tUfMRtp3xZrhgZAVZSh3VP81q0AxfsMm/70NXH0/OBIOHk4q7wUXkCCx6?=
 =?us-ascii?Q?8aCGCcf6BtQB71JEKdmkBE20r5TVuZ2bplTqVB5PrajUcv2cDAXtzGq+0m1u?=
 =?us-ascii?Q?yeRLg3JJAg8g+ibMh/76kRnlPNBg7J5BQAUWr8PVlhjMOHZ6+5ClzW2fZt87?=
 =?us-ascii?Q?VA=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 412751f3-9efc-4887-3d59-08dd20e92312
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6969.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 11:26:24.5661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KUtyVsNzbMkNt8wmTwHYqu6Ymixq+CJIxIyd+5NFbAve/+zxjLzPU0G5Sx5sdk/Y2N9qiPNhK5FLregm4N4Z/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8256
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 20 Dec 2024 11:26:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16930

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


