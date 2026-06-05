Return-Path: <anders.heimer@est.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D8BCD6E79
	for <webhook@archiver.kernel.org>; Fri,  5 Jun 2026 04:58:39 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.29])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1519.1780635511989931224
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 04 Jun 2026 21:58:33 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@est.tech header.s=selector1 header.b=vla7C12T;
 spf=pass (domain: est.tech, ip: 52.101.66.29, mailfrom: anders.heimer@est.tech)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E1d1Ye00zafQENalYe6TzJJjlaZDKbpt+wmEZa9BTc5J7xcAUKj3YkwAkyV/WuDc9XuIy6v+eSxKVab0lAE5ZBc5VvZZFZEyW91EllBGs4WWMuxztn+KvFMJqwkjV0v1+aY2+MDmK34jRM1YIvb0wmCeERkYyOXcguGfMZM/RLgofTiMyDlygN+aaW7fW9/bj+5bUQJ6rVpWkhy3qNrudXoJweP0GC2V9r43PSQPe/2kxpcYShU9Qh/NeYtSBHJYDQ2a/lLct+Vrfb8lRdoSTIBXZpHu8Iw526NS8esCc/dt0podpMpoE60bcMLLqbgX6ERPkvQF3NvSYZs+OQ/cyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AcTlonNUyQeLyskhT67sW1FTcHMexp+HnXRHYqJ2liw=;
 b=vsxfr8LvVp88Lq5B8IqpJ1LRvQ7bWdXqJ9qHqCxjDpHHfnIyygmuCKHLCxaRrMFpwDHpOq6MBW/ciEt8fu6xUbtWIcsE69Z9ohHWsNqXOewgoWLIMGnmSpMpUfJBEugyFbuQowEd9kycKOUe7F8kHUsysFLqxX5JmY6hpXWeR+QZuO+2K1wW5KRAwCCVB8cc08RVF7xUziBzAChr/1rm0xMrQRKJvo86moM4RcLJ7T1LVDKYeMSrEpgWq88EqwNumUls0OInV2PkEVgzlqeGMrVF1FqJoX6myogAfMI6rJAYP1psxlGPoBRX/dz/6kiFHjCjDK/QE/a9fAIZqYeyBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AcTlonNUyQeLyskhT67sW1FTcHMexp+HnXRHYqJ2liw=;
 b=vla7C12TaROsk30Rxri4I2Ed5F7BXX5s8tiWOUhl5MNhryTClwoOKpjO5kkLJ7sz1x2VRuWagDl1P03xhUiztM3QtOyscsTeHwAnIl6Vz0jAxRR622y0RLwP+r//P3XumCTEmoBO08IIyewqAL9QU0L7ML7xIhCphVt6y0y14bgfCD6H8RCHluFvgkzLPPE1SG6S+dcgpLBb1rlV2B7vioDJuH7JlEdEwpQzYVgyAKATErG9AvaF/GlFxhEjHL/7uDV0wbp+2LkAVZoNyw12w0QjlxDfnKTpz40zz1xvxWajGV0JQqe1Lvphc2Utm1ke2YPJKnCeubZRhR9azmr2BA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from DB9P189MB1641.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:2ac::9) by
 AM0P189MB0785.EURP189.PROD.OUTLOOK.COM (2603:10a6:208:19f::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.8; Fri, 5 Jun 2026 04:58:29 +0000
Received: from DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
 ([fe80::90da:b700:f102:5c82]) by DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
 ([fe80::90da:b700:f102:5c82%6]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 04:58:29 +0000
From: Anders Heimer <anders.heimer@est.tech>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/2] hashserv/tests: use valid 64-character unihashes
Date: Fri,  5 Jun 2026 06:58:25 +0200
Message-ID: <20260605045826.2052909-2-anders.heimer@est.tech>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260605045826.2052909-1-anders.heimer@est.tech>
References: <20260605045826.2052909-1-anders.heimer@est.tech>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: DU7PR01CA0042.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::26) To DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:2ac::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P189MB1641:EE_|AM0P189MB0785:EE_
X-MS-Office365-Filtering-Correlation-Id: 695ec6ed-c2ad-4247-4e56-08dec2bf157a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|366016|22082099003|18002099003|3023799007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 
	jLN1YP5+1zL5ySFWpgmUJdPfXsfqZB0Npkcj0gjZrCnMmmQ3u64lOCnl4pTpfhQzNb3hAbAnXTa/9Y8mC/j7IgSoTFPKTedfQPv+D/xepr3MMCYJtr/bpNTg0OtGIXu+oFt8otggSBH3vqvsBrT2/QFHoFQHSj4kavsHaQmdFsTwocTOEOJVtoNPIwFHX1wik8TV2X2T2McC6jkYgYF77VLMhPGM5+hkAYYBQey2CHQZo4aYYE2UraZVwBkmr0ac6OcO/fBRgLVVZwUOvESL+0fGNDHe26aE+/JiJCc1pq9rQDywysADrDl1s/VrrHOIaxpE8e2NsUllCjkr4sZ5ruX1qTgFdx1pnAf4HHOJmMkOwFk+yRPTAcNSlytzwZTPylCIu4lvLhJ6zQXpDxe6lUTVN6G4g2DPPU22t6KR9vqNbej74qWoeyV5PLtIe8igvbSwrvNuI+/oyw6M5vByYn3ADSW7ZjTkT+pN/U1CMAKnqn8Obn9qiCrke4RbiCmV//d5F4MMldD1TQjSgjchO26BdbMnKoX/+5liOipNh/8hV3Z7d6k0SdWo68a5fs/k2AEMnsEmeze5xGdqGjqGxmqH9ASFKXi/qmkqYnrBPreVUkCKIEvpUXLnNNWRqlk5N8TrElOYFqFcVIlxb6QTHO5ZzxwnQE27JfgK+zxUKG+dP+CLrxPtbnZkx1ZyzJxD
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P189MB1641.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(3023799007)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?I84tJDX5oe8iYlwgguuDfa6NnXMS9O+DxgqQBfIM8yHrnwDS5FLYs/kx91wf?=
 =?us-ascii?Q?yAYV5GMlCwx1aqGmp7tJliEXLUZ+8C1UpnJ+Txcwp3p6GWKUmouQLC0X423p?=
 =?us-ascii?Q?17Thl2RqM3ykFAgBHozR1zvnecrbjjM1Ph+tyRos255WJcykXu7ouO/7PzlG?=
 =?us-ascii?Q?ibU48GWTzewsH9Az6Xfaypgu1+tRqQNz9J8DyVKBaJJyTd2TaFtNk34GBQQb?=
 =?us-ascii?Q?+ZtZMOY2QueRfzcA/GWLwbLcDoQdAGg+bKPg0gjq6d3ARns0Al8eh9V/XVn3?=
 =?us-ascii?Q?AwkG1RMW6Rghtq80zmvoWCaAzsTLbkMTl05Gj9Cpwuz9eSkdfiWSkCb6W+03?=
 =?us-ascii?Q?trnHU5xkrDDscZJPfIqSEPO2zux77Q0tBS0KziWpfea/fpUHvMYeJHg3PDXD?=
 =?us-ascii?Q?2DRBWvm8aW8W3CzdY6SEgPu08UzTJmvqd/FGzzsRN5Ed1+jngHTx9sdWLpiH?=
 =?us-ascii?Q?2ulNXRnsosd4b+0BrgMU7Z5nmHVq/VPQQp+S5hSBW1cZc9kf72eLhL0DpJbD?=
 =?us-ascii?Q?ABBlJY5qEIp76yue/YqncdtaPZ6j8Pf1AEtsd+xRkM/mxkZXRc4Dp2r+pQOI?=
 =?us-ascii?Q?NrmjWCBC3ZoZBmg3QoAs/5XlwamPAIqzk36yWUnamvCXGm1ZttTTUcOZFqCO?=
 =?us-ascii?Q?UGDpoTclIhtcKUfU4xC7AFqiJblkyw3TGDkAU/sRAxLgVLFI9lH0E8iWW4EH?=
 =?us-ascii?Q?pxsgidIBXBY6xnXrQsJyEKQG5ape5yZA7M+NNC7sAH8T9T3GjLhHIoIXMFZ5?=
 =?us-ascii?Q?YChpL7BWPD9UYNw9XjDcHQIWI2K2n6LOZXZYyyJhAXIGJsiyqqQ1JGquojwe?=
 =?us-ascii?Q?6sg+WrPkx81ZZS6c8stiN/E9+Lt97z2lkGiYualdDUhKnHOenL0JzAPQWHKU?=
 =?us-ascii?Q?9ER6fQqbfiO1zTSGy8Kuqe/wio1le6aLq71bXLgijMEVlphAzd0j0BVRdchh?=
 =?us-ascii?Q?3buOsuZbaWUzmNT+fBDdTaiSX9V+hN6aFiq08pPHujZ4LsjuUA2Y23Bx7z4q?=
 =?us-ascii?Q?69rulvz5Y8jFV1RoonwmTaBSacMhJ/6v9a6WIhHs+LTY5gMgy2ZrglynTktS?=
 =?us-ascii?Q?/4EFtm273tt4sk9goZsDo0QMZZ5KHXm3TypUAKXiUivbLpyB/Kb7eRYrvD8M?=
 =?us-ascii?Q?ahyjPcTb0r1eB0K5FWoIT5mVGqzj1vp9vuNdysF54+YOMBJvGZ0nrT9qZvEK?=
 =?us-ascii?Q?U/HmGRP8EaDYGypJ42DU9YjVZzLhxCvRlle2gUD3H/2S9kUhU7CaRjdR+nYp?=
 =?us-ascii?Q?KVhj5G1zvVHX6w6Y/n6Cf1CxJlGCD1buejP1BqLbbN0sH/EMI132HjG5HlII?=
 =?us-ascii?Q?XuoegPhr21r/EDrM+WLHwi6nE6QG9tBrmetw0sbD+kGyqqonfNiqaui3piPY?=
 =?us-ascii?Q?MBJ7pL+MPYLcJdgCGLZNQmwvjYDZWyu6EmsL0DaZuDFjvofubGprAFqFviW7?=
 =?us-ascii?Q?rRiICUir1JsJMNpMsW3j2cGqzH3/TlSsLYKRMKb+ikCtIKrge1EB0+KaUk+R?=
 =?us-ascii?Q?Ao4LQ4H2ObzqngFrRZo6/8kew241FG3blidtGXCgMrHYx+3vvTSdUkUA7uwc?=
 =?us-ascii?Q?lBVfyjiOXV15SkzukmyIfKvDEBsK2Q+ctsi1Ipj8eZXWaE2chfS7TOJqNjb0?=
 =?us-ascii?Q?vvpuQo98JIzu7gKAMkKKLO6escFAX6MO7d0ClE6amR5+8Dpf0Ud4pNSZXInj?=
 =?us-ascii?Q?aYng1cwLV6Bf/EI/xhIbTukm0SZAFTzi+tSyxsk+llML7ifGgbvJN+tSDOjg?=
 =?us-ascii?Q?tKtCNZwEUA=3D=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 695ec6ed-c2ad-4247-4e56-08dec2bf157a
X-MS-Exchange-CrossTenant-AuthSource: DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 04:58:29.2830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VFzVsYPBfNjqB8pTUZJaLHYl5kOKjsVjPpRXKsUTI2RMFaTFhe2T1j5aF1CU9Lko3d/qybsi2/PZXREeio8Axw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P189MB0785
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 05 Jun 2026 04:58:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19613

Signed-off-by: Anders Heimer <anders.heimer@est.tech>
---
 lib/hashserv/tests.py | 164 ++++++++++++++++++++++++++++--------------
 1 file changed, 110 insertions(+), 54 deletions(-)

diff --git a/lib/hashserv/tests.py b/lib/hashserv/tests.py
index 124d8aa00..83ce0c5ca 100644
--- a/lib/hashserv/tests.py
+++ b/lib/hashserv/tests.py
@@ -28,6 +28,7 @@ from pathlib import Path
 THIS_DIR =3D Path(__file__).parent
 BIN_DIR =3D THIS_DIR.parent.parent / "bin"
=20
+
 def server_prefunc(server, idx):
     logging.basicConfig(level=3Dlogging.DEBUG, filename=3D'bbhashserv-%d.l=
og' % idx, filemode=3D'w',
                         format=3D'%(levelname)s %(filename)s:%(lineno)d %(=
message)s')
@@ -124,7 +125,7 @@ class HashEquivalenceTestSetup(object):
         # Simple test that hashes can be created
         taskhash =3D '35788efcb8dfb0a02659d81cf2bfd695fb30faf9'
         outhash =3D '2765d4a5884be49b28601445c2760c5f21e7e5c0ee2b7e3fce98f=
d7e5970796f'
-        unihash =3D 'f46d3fbb439bd9b921095da657a4de906510d2cd'
+        unihash =3D 'a69ec97f5af2e21e1a1f9cc8896965515d5559425666f734e245a=
3d40cee33d9'
=20
         self.assertClientGetHash(client, taskhash, None)
=20
@@ -178,7 +179,7 @@ class HashEquivalenceCommonTests(object):
         # assigned the same unihash
         taskhash =3D '53b8dce672cb6d0c73170be43f540460bfc347b4'
         outhash =3D '5a9cb1649625f0bf41fc7791b635cd9c2d7118c7f021ba87dcd03=
f72b67ce7a8'
-        unihash =3D 'f37918cc02eb5a520b1aff86faacbc0a38124646'
+        unihash =3D '46edb5140d2613049332d0bf3745d9fafec9c559dac8cc6181373=
9a28007fcdf'
=20
         result =3D self.client.report_unihash(taskhash, self.METHOD, outha=
sh, unihash)
         self.assertEqual(result['unihash'], unihash, 'Server returned bad =
unihash')
@@ -186,7 +187,7 @@ class HashEquivalenceCommonTests(object):
         # Report a different task with the same outhash. The returned unih=
ash
         # should match the first task
         taskhash2 =3D '3bf6f1e89d26205aec90da04854fbdbf73afe6b4'
-        unihash2 =3D 'af36b199320e611fbb16f1f277d3ee1d619ca58b'
+        unihash2 =3D 'bf6e81926066f770e960f9f777cd088c62bea9addb7745f3e77d=
eaa81a645747'
         result =3D self.client.report_unihash(taskhash2, self.METHOD, outh=
ash, unihash2)
         self.assertEqual(result['unihash'], unihash, 'Server returned bad =
unihash')
=20
@@ -196,19 +197,19 @@ class HashEquivalenceCommonTests(object):
         # taskhash
         taskhash =3D '8aa96fcffb5831b3c2c0cb75f0431e3f8b20554a'
         outhash =3D 'afe240a439959ce86f5e322f8c208e1fedefea9e813f2140c81af=
866cc9edf7e'
-        unihash =3D '218e57509998197d570e2c98512d0105985dffc9'
+        unihash =3D '5b521d8a12683086cc08bc2c6d94a7a2dcff17eba53b9911e145d=
51164689380'
         self.client.report_unihash(taskhash, self.METHOD, outhash, unihash=
)
=20
         self.assertClientGetHash(self.client, taskhash, unihash)
=20
         outhash2 =3D '0904a7fe3dc712d9fd8a74a616ddca2a825a8ee97adf0bd3fc86=
082c7639914d'
-        unihash2 =3D 'ae9a7d252735f0dafcdb10e2e02561ca3a47314c'
+        unihash2 =3D 'a37541b54fd22440e292f617eb30ba07455e88fb0b9f0952eca2=
29b6356290e3'
         self.client.report_unihash(taskhash, self.METHOD, outhash2, unihas=
h2)
=20
         self.assertClientGetHash(self.client, taskhash, unihash)
=20
         outhash3 =3D '77623a549b5b1a31e3732dfa8fe61d7ce5d44b3370f253c5360e=
136b852967b4'
-        unihash3 =3D '9217a7d6398518e5dc002ed58f2cbbbc78696603'
+        unihash3 =3D '6842f1f2daccd96ddef15c9154d4e41ac8a2300d781ac9a9db7f=
8afeb8a96808'
         self.client.report_unihash(taskhash, self.METHOD, outhash3, unihas=
h3)
=20
         self.assertClientGetHash(self.client, taskhash, unihash)
@@ -268,7 +269,7 @@ class HashEquivalenceCommonTests(object):
         # Simple test that hashes can be created
         taskhash =3D 'c665584ee6817aa99edfc77a44dd853828279370'
         outhash =3D '3c979c3db45c569f51ab7626a4651074be3a9d11a84b1db076f5b=
14f7d39db44'
-        unihash =3D '90e9bc1d1f094c51824adca7f8ea79a048d68824'
+        unihash =3D '06f89b8f329ba8124ff73c56d09ef921b42624747c421277bddaf=
5e23f136e57'
=20
         self.assertClientGetHash(self.client, taskhash, None)
=20
@@ -361,7 +362,7 @@ class HashEquivalenceCommonTests(object):
         # Basic report
         taskhash =3D '8aa96fcffb5831b3c2c0cb75f0431e3f8b20554a'
         outhash =3D 'afe240a439959ce86f5e322f8c208e1fedefea9e813f2140c81af=
866cc9edf7e'
-        unihash =3D '218e57509998197d570e2c98512d0105985dffc9'
+        unihash =3D '5b521d8a12683086cc08bc2c6d94a7a2dcff17eba53b9911e145d=
51164689380'
         self.client.report_unihash(taskhash, self.METHOD, outhash, unihash=
)
=20
         check_hash(taskhash, unihash, None)
@@ -369,7 +370,7 @@ class HashEquivalenceCommonTests(object):
         # Duplicated taskhash with multiple output hashes and unihashes.
         # All servers should agree with the originally reported hash
         outhash2 =3D '0904a7fe3dc712d9fd8a74a616ddca2a825a8ee97adf0bd3fc86=
082c7639914d'
-        unihash2 =3D 'ae9a7d252735f0dafcdb10e2e02561ca3a47314c'
+        unihash2 =3D 'a37541b54fd22440e292f617eb30ba07455e88fb0b9f0952eca2=
29b6356290e3'
         self.client.report_unihash(taskhash, self.METHOD, outhash2, unihas=
h2)
=20
         check_hash(taskhash, unihash, unihash)
@@ -377,7 +378,7 @@ class HashEquivalenceCommonTests(object):
         # Report an equivalent task. The sideload will originally report
         # no unihash until backfilled
         taskhash3 =3D "044c2ec8aaf480685a00ff6ff49e6162e6ad34e1"
-        unihash3 =3D "def64766090d28f627e816454ed46894bb3aab36"
+        unihash3 =3D "aca636d800aef40e6ddcea4b2262cc4ea0d1180a6783e5b4653a=
20c7dd73458d"
         self.client.report_unihash(taskhash3, self.METHOD, outhash, unihas=
h3)
=20
         check_hash(taskhash3, unihash, None)
@@ -386,7 +387,7 @@ class HashEquivalenceCommonTests(object):
         # propagating to the upstream server
         taskhash4 =3D "e3da00593d6a7fb435c7e2114976c59c5fd6d561"
         outhash4 =3D "1cf8713e645f491eb9c959d20b5cae1c47133a292626dda9b107=
09857cbe688a"
-        unihash4 =3D "3b5d3d83f07f259e9086fcb422c855286e18a57d"
+        unihash4 =3D "7aebef07d66a8c0f92d0c4f65ec8b1fbb850a3693c53827b8774=
b64fa9a8a9fe"
         down_client.report_unihash(taskhash4, self.METHOD, outhash4, uniha=
sh4)
         down_client.backfill_wait()
=20
@@ -398,18 +399,18 @@ class HashEquivalenceCommonTests(object):
         # match which was previously reported to the upstream server
         taskhash5 =3D '35788efcb8dfb0a02659d81cf2bfd695fb30faf9'
         outhash5 =3D '2765d4a5884be49b28601445c2760c5f21e7e5c0ee2b7e3fce98=
fd7e5970796f'
-        unihash5 =3D 'f46d3fbb439bd9b921095da657a4de906510d2cd'
+        unihash5 =3D 'a69ec97f5af2e21e1a1f9cc8896965515d5559425666f734e245=
a3d40cee33d9'
         result =3D self.client.report_unihash(taskhash5, self.METHOD, outh=
ash5, unihash5)
=20
         taskhash6 =3D '35788efcb8dfb0a02659d81cf2bfd695fb30fafa'
-        unihash6 =3D 'f46d3fbb439bd9b921095da657a4de906510d2ce'
+        unihash6 =3D 'eabc7a98e0c12bbeb8394dbdf055eb81aac60e4a14cca5c1f069=
d36efc933b23'
         result =3D down_client.report_unihash(taskhash6, self.METHOD, outh=
ash5, unihash6)
         self.assertEqual(result['unihash'], unihash5, 'Server failed to co=
py unihash from upstream')
=20
         # Tests read through from server with
         taskhash7 =3D '9d81d76242cc7cfaf7bf74b94b9cd2e29324ed74'
         outhash7 =3D '8470d56547eea6236d7c81a644ce74670ca0bbda998e13c629ef=
6bb3f0d60b69'
-        unihash7 =3D '05d2a63c81e32f0a36542ca677e8ad852365c538'
+        unihash7 =3D '7521a98a0c645341bc51559b234ef37a097e8f3a01665e0303a3=
17925ab7b4d5'
         self.client.report_unihash(taskhash7, self.METHOD, outhash7, uniha=
sh7)
=20
         result =3D down_client.get_taskhash(self.METHOD, taskhash7, True)
@@ -420,7 +421,7 @@ class HashEquivalenceCommonTests(object):
=20
         taskhash8 =3D '86978a4c8c71b9b487330b0152aade10c1ee58aa'
         outhash8 =3D 'ca8c128e9d9e4a28ef24d0508aa20b5cf880604eacd8f65c0e36=
6f7e0cc5fbcf'
-        unihash8 =3D 'd8bcf25369d40590ad7d08c84d538982f2023e01'
+        unihash8 =3D '83386d9385b0bf3ba25693127ddcaaadeaa1c4bf8cb0baecfb53=
14b9a20072a1'
         self.client.report_unihash(taskhash8, self.METHOD, outhash8, uniha=
sh8)
=20
         result =3D down_client.get_outhash(self.METHOD, outhash8, taskhash=
8)
@@ -431,7 +432,7 @@ class HashEquivalenceCommonTests(object):
=20
         taskhash9 =3D 'ae6339531895ddf5b67e663e6a374ad8ec71d81c'
         outhash9 =3D 'afc78172c81880ae10a1fec994b5b4ee33d196a001a1b66212a1=
5ebe573e00b5'
-        unihash9 =3D '6662e699d6e3d894b24408ff9a4031ef9b038ee8'
+        unihash9 =3D 'cc74784b2c0ad5b378a6b783c74c518d2c46b8b52fba29cb39a8=
430d742440d7'
         self.client.report_unihash(taskhash9, self.METHOD, outhash9, uniha=
sh9)
=20
         result =3D down_client.get_taskhash(self.METHOD, taskhash9, False)
@@ -454,7 +455,7 @@ class HashEquivalenceCommonTests(object):
         # Report a hash via the read-write server
         taskhash =3D '35788efcb8dfb0a02659d81cf2bfd695fb30faf9'
         outhash =3D '2765d4a5884be49b28601445c2760c5f21e7e5c0ee2b7e3fce98f=
d7e5970796f'
-        unihash =3D 'f46d3fbb439bd9b921095da657a4de906510d2cd'
+        unihash =3D 'a69ec97f5af2e21e1a1f9cc8896965515d5559425666f734e245a=
3d40cee33d9'
=20
         result =3D rw_client.report_unihash(taskhash, self.METHOD, outhash=
, unihash)
         self.assertEqual(result['unihash'], unihash, 'Server returned bad =
unihash')
@@ -465,7 +466,7 @@ class HashEquivalenceCommonTests(object):
         # Ensure that reporting via the read-only server fails
         taskhash2 =3D 'c665584ee6817aa99edfc77a44dd853828279370'
         outhash2 =3D '3c979c3db45c569f51ab7626a4651074be3a9d11a84b1db076f5=
b14f7d39db44'
-        unihash2 =3D '90e9bc1d1f094c51824adca7f8ea79a048d68824'
+        unihash2 =3D '06f89b8f329ba8124ff73c56d09ef921b42624747c421277bdda=
f5e23f136e57'
=20
         result =3D ro_client.report_unihash(taskhash2, self.METHOD, outhas=
h2, unihash2)
         self.assertEqual(result['unihash'], unihash2)
@@ -554,15 +555,43 @@ class HashEquivalenceCommonTests(object):
     def test_get_unihash_batch(self):
         TEST_INPUT =3D (
             # taskhash                                   outhash          =
                                                  unihash
-            ('8aa96fcffb5831b3c2c0cb75f0431e3f8b20554a', 'afe240a439959ce8=
6f5e322f8c208e1fedefea9e813f2140c81af866cc9edf7e','218e57509998197d570e2c98=
512d0105985dffc9'),
+            (
+                '8aa96fcffb5831b3c2c0cb75f0431e3f8b20554a',
+                'afe240a439959ce86f5e322f8c208e1fedefea9e813f2140c81af866c=
c9edf7e',
+                '5b521d8a12683086cc08bc2c6d94a7a2dcff17eba53b9911e145d5116=
4689380',
+            ),
             # Duplicated taskhash with multiple output hashes and unihashe=
s.
-            ('8aa96fcffb5831b3c2c0cb75f0431e3f8b20554a', '0904a7fe3dc712d9=
fd8a74a616ddca2a825a8ee97adf0bd3fc86082c7639914d', 'ae9a7d252735f0dafcdb10e=
2e02561ca3a47314c'),
+            (
+                '8aa96fcffb5831b3c2c0cb75f0431e3f8b20554a',
+                '0904a7fe3dc712d9fd8a74a616ddca2a825a8ee97adf0bd3fc86082c7=
639914d',
+                'a37541b54fd22440e292f617eb30ba07455e88fb0b9f0952eca229b63=
56290e3',
+            ),
             # Equivalent hash
-            ("044c2ec8aaf480685a00ff6ff49e6162e6ad34e1", '0904a7fe3dc712d9=
fd8a74a616ddca2a825a8ee97adf0bd3fc86082c7639914d', "def64766090d28f627e8164=
54ed46894bb3aab36"),
-            ("e3da00593d6a7fb435c7e2114976c59c5fd6d561", "1cf8713e645f491e=
b9c959d20b5cae1c47133a292626dda9b10709857cbe688a", "3b5d3d83f07f259e9086fcb=
422c855286e18a57d"),
-            ('35788efcb8dfb0a02659d81cf2bfd695fb30faf9', '2765d4a5884be49b=
28601445c2760c5f21e7e5c0ee2b7e3fce98fd7e5970796f', 'f46d3fbb439bd9b921095da=
657a4de906510d2cd'),
-            ('35788efcb8dfb0a02659d81cf2bfd695fb30fafa', '2765d4a5884be49b=
28601445c2760c5f21e7e5c0ee2b7e3fce98fd7e5970796f', 'f46d3fbb439bd9b921095da=
657a4de906510d2ce'),
-            ('9d81d76242cc7cfaf7bf74b94b9cd2e29324ed74', '8470d56547eea623=
6d7c81a644ce74670ca0bbda998e13c629ef6bb3f0d60b69', '05d2a63c81e32f0a36542ca=
677e8ad852365c538'),
+            (
+                "044c2ec8aaf480685a00ff6ff49e6162e6ad34e1",
+                '0904a7fe3dc712d9fd8a74a616ddca2a825a8ee97adf0bd3fc86082c7=
639914d',
+                "aca636d800aef40e6ddcea4b2262cc4ea0d1180a6783e5b4653a20c7d=
d73458d",
+            ),
+            (
+                "e3da00593d6a7fb435c7e2114976c59c5fd6d561",
+                "1cf8713e645f491eb9c959d20b5cae1c47133a292626dda9b10709857=
cbe688a",
+                "7aebef07d66a8c0f92d0c4f65ec8b1fbb850a3693c53827b8774b64fa=
9a8a9fe",
+            ),
+            (
+                '35788efcb8dfb0a02659d81cf2bfd695fb30faf9',
+                '2765d4a5884be49b28601445c2760c5f21e7e5c0ee2b7e3fce98fd7e5=
970796f',
+                'a69ec97f5af2e21e1a1f9cc8896965515d5559425666f734e245a3d40=
cee33d9',
+            ),
+            (
+                '35788efcb8dfb0a02659d81cf2bfd695fb30fafa',
+                '2765d4a5884be49b28601445c2760c5f21e7e5c0ee2b7e3fce98fd7e5=
970796f',
+                'eabc7a98e0c12bbeb8394dbdf055eb81aac60e4a14cca5c1f069d36ef=
c933b23',
+            ),
+            (
+                '9d81d76242cc7cfaf7bf74b94b9cd2e29324ed74',
+                '8470d56547eea6236d7c81a644ce74670ca0bbda998e13c629ef6bb3f=
0d60b69',
+                '7521a98a0c645341bc51559b234ef37a097e8f3a01665e0303a317925=
ab7b4d5',
+            ),
         )
         EXTRA_QUERIES =3D (
             "6b6be7a84ab179b4240c4302518dc3f6",
@@ -578,28 +607,56 @@ class HashEquivalenceCommonTests(object):
         )
=20
         self.assertListEqual(result, [
-            "218e57509998197d570e2c98512d0105985dffc9",
-            "218e57509998197d570e2c98512d0105985dffc9",
-            "218e57509998197d570e2c98512d0105985dffc9",
-            "3b5d3d83f07f259e9086fcb422c855286e18a57d",
-            "f46d3fbb439bd9b921095da657a4de906510d2cd",
-            "f46d3fbb439bd9b921095da657a4de906510d2cd",
-            "05d2a63c81e32f0a36542ca677e8ad852365c538",
+            "5b521d8a12683086cc08bc2c6d94a7a2dcff17eba53b9911e145d51164689=
380",
+            "5b521d8a12683086cc08bc2c6d94a7a2dcff17eba53b9911e145d51164689=
380",
+            "5b521d8a12683086cc08bc2c6d94a7a2dcff17eba53b9911e145d51164689=
380",
+            "7aebef07d66a8c0f92d0c4f65ec8b1fbb850a3693c53827b8774b64fa9a8a=
9fe",
+            "a69ec97f5af2e21e1a1f9cc8896965515d5559425666f734e245a3d40cee3=
3d9",
+            "a69ec97f5af2e21e1a1f9cc8896965515d5559425666f734e245a3d40cee3=
3d9",
+            "7521a98a0c645341bc51559b234ef37a097e8f3a01665e0303a317925ab7b=
4d5",
             None,
         ])
=20
     def test_unihash_exists_batch(self):
         TEST_INPUT =3D (
             # taskhash                                   outhash          =
                                                  unihash
-            ('8aa96fcffb5831b3c2c0cb75f0431e3f8b20554a', 'afe240a439959ce8=
6f5e322f8c208e1fedefea9e813f2140c81af866cc9edf7e','218e57509998197d570e2c98=
512d0105985dffc9'),
+            (
+                '8aa96fcffb5831b3c2c0cb75f0431e3f8b20554a',
+                'afe240a439959ce86f5e322f8c208e1fedefea9e813f2140c81af866c=
c9edf7e',
+                '5b521d8a12683086cc08bc2c6d94a7a2dcff17eba53b9911e145d5116=
4689380',
+            ),
             # Duplicated taskhash with multiple output hashes and unihashe=
s.
-            ('8aa96fcffb5831b3c2c0cb75f0431e3f8b20554a', '0904a7fe3dc712d9=
fd8a74a616ddca2a825a8ee97adf0bd3fc86082c7639914d', 'ae9a7d252735f0dafcdb10e=
2e02561ca3a47314c'),
+            (
+                '8aa96fcffb5831b3c2c0cb75f0431e3f8b20554a',
+                '0904a7fe3dc712d9fd8a74a616ddca2a825a8ee97adf0bd3fc86082c7=
639914d',
+                'a37541b54fd22440e292f617eb30ba07455e88fb0b9f0952eca229b63=
56290e3',
+            ),
             # Equivalent hash
-            ("044c2ec8aaf480685a00ff6ff49e6162e6ad34e1", '0904a7fe3dc712d9=
fd8a74a616ddca2a825a8ee97adf0bd3fc86082c7639914d', "def64766090d28f627e8164=
54ed46894bb3aab36"),
-            ("e3da00593d6a7fb435c7e2114976c59c5fd6d561", "1cf8713e645f491e=
b9c959d20b5cae1c47133a292626dda9b10709857cbe688a", "3b5d3d83f07f259e9086fcb=
422c855286e18a57d"),
-            ('35788efcb8dfb0a02659d81cf2bfd695fb30faf9', '2765d4a5884be49b=
28601445c2760c5f21e7e5c0ee2b7e3fce98fd7e5970796f', 'f46d3fbb439bd9b921095da=
657a4de906510d2cd'),
-            ('35788efcb8dfb0a02659d81cf2bfd695fb30fafa', '2765d4a5884be49b=
28601445c2760c5f21e7e5c0ee2b7e3fce98fd7e5970796f', 'f46d3fbb439bd9b921095da=
657a4de906510d2ce'),
-            ('9d81d76242cc7cfaf7bf74b94b9cd2e29324ed74', '8470d56547eea623=
6d7c81a644ce74670ca0bbda998e13c629ef6bb3f0d60b69', '05d2a63c81e32f0a36542ca=
677e8ad852365c538'),
+            (
+                "044c2ec8aaf480685a00ff6ff49e6162e6ad34e1",
+                '0904a7fe3dc712d9fd8a74a616ddca2a825a8ee97adf0bd3fc86082c7=
639914d',
+                "aca636d800aef40e6ddcea4b2262cc4ea0d1180a6783e5b4653a20c7d=
d73458d",
+            ),
+            (
+                "e3da00593d6a7fb435c7e2114976c59c5fd6d561",
+                "1cf8713e645f491eb9c959d20b5cae1c47133a292626dda9b10709857=
cbe688a",
+                "7aebef07d66a8c0f92d0c4f65ec8b1fbb850a3693c53827b8774b64fa=
9a8a9fe",
+            ),
+            (
+                '35788efcb8dfb0a02659d81cf2bfd695fb30faf9',
+                '2765d4a5884be49b28601445c2760c5f21e7e5c0ee2b7e3fce98fd7e5=
970796f',
+                'a69ec97f5af2e21e1a1f9cc8896965515d5559425666f734e245a3d40=
cee33d9',
+            ),
+            (
+                '35788efcb8dfb0a02659d81cf2bfd695fb30fafa',
+                '2765d4a5884be49b28601445c2760c5f21e7e5c0ee2b7e3fce98fd7e5=
970796f',
+                'eabc7a98e0c12bbeb8394dbdf055eb81aac60e4a14cca5c1f069d36ef=
c933b23',
+            ),
+            (
+                '9d81d76242cc7cfaf7bf74b94b9cd2e29324ed74',
+                '8470d56547eea6236d7c81a644ce74670ca0bbda998e13c629ef6bb3f=
0d60b69',
+                '7521a98a0c645341bc51559b234ef37a097e8f3a01665e0303a317925=
ab7b4d5',
+            ),
         )
         EXTRA_QUERIES =3D (
             "6b6be7a84ab179b4240c4302518dc3f6",
@@ -939,14 +996,14 @@ class HashEquivalenceCommonTests(object):
     def test_gc(self):
         taskhash =3D '53b8dce672cb6d0c73170be43f540460bfc347b4'
         outhash =3D '5a9cb1649625f0bf41fc7791b635cd9c2d7118c7f021ba87dcd03=
f72b67ce7a8'
-        unihash =3D 'f37918cc02eb5a520b1aff86faacbc0a38124646'
+        unihash =3D '46edb5140d2613049332d0bf3745d9fafec9c559dac8cc6181373=
9a28007fcdf'
=20
         result =3D self.client.report_unihash(taskhash, self.METHOD, outha=
sh, unihash)
         self.assertEqual(result['unihash'], unihash, 'Server returned bad =
unihash')
=20
         taskhash2 =3D '3bf6f1e89d26205aec90da04854fbdbf73afe6b4'
         outhash2 =3D '77623a549b5b1a31e3732dfa8fe61d7ce5d44b3370f253c5360e=
136b852967b4'
-        unihash2 =3D 'af36b199320e611fbb16f1f277d3ee1d619ca58b'
+        unihash2 =3D 'bf6e81926066f770e960f9f777cd088c62bea9addb7745f3e77d=
eaa81a645747'
=20
         result =3D self.client.report_unihash(taskhash2, self.METHOD, outh=
ash2, unihash2)
         self.assertClientGetHash(self.client, taskhash2, unihash2)
@@ -972,21 +1029,21 @@ class HashEquivalenceCommonTests(object):
     def test_gc_stream(self):
         taskhash =3D '53b8dce672cb6d0c73170be43f540460bfc347b4'
         outhash =3D '5a9cb1649625f0bf41fc7791b635cd9c2d7118c7f021ba87dcd03=
f72b67ce7a8'
-        unihash =3D 'f37918cc02eb5a520b1aff86faacbc0a38124646'
+        unihash =3D '46edb5140d2613049332d0bf3745d9fafec9c559dac8cc6181373=
9a28007fcdf'
=20
         result =3D self.client.report_unihash(taskhash, self.METHOD, outha=
sh, unihash)
         self.assertEqual(result['unihash'], unihash, 'Server returned bad =
unihash')
=20
         taskhash2 =3D '3bf6f1e89d26205aec90da04854fbdbf73afe6b4'
         outhash2 =3D '77623a549b5b1a31e3732dfa8fe61d7ce5d44b3370f253c5360e=
136b852967b4'
-        unihash2 =3D 'af36b199320e611fbb16f1f277d3ee1d619ca58b'
+        unihash2 =3D 'bf6e81926066f770e960f9f777cd088c62bea9addb7745f3e77d=
eaa81a645747'
=20
         result =3D self.client.report_unihash(taskhash2, self.METHOD, outh=
ash2, unihash2)
         self.assertClientGetHash(self.client, taskhash2, unihash2)
=20
         taskhash3 =3D 'a1117c1f5a7c9ab2f5a39cc6fe5e6152169d09c0'
         outhash3 =3D '7289c414905303700a1117c1f5a7c9ab2f5a39cc6fe5e6152169=
d09c04f9a53c'
-        unihash3 =3D '905303700a1117c1f5a7c9ab2f5a39cc6fe5e615'
+        unihash3 =3D 'f5966c8588a69948a89131d3aa63b914c5a63a8cb4820cb1c586=
94135ba77f0b'
=20
         result =3D self.client.report_unihash(taskhash3, self.METHOD, outh=
ash3, unihash3)
         self.assertClientGetHash(self.client, taskhash3, unihash3)
@@ -1014,14 +1071,14 @@ class HashEquivalenceCommonTests(object):
     def test_gc_switch_mark(self):
         taskhash =3D '53b8dce672cb6d0c73170be43f540460bfc347b4'
         outhash =3D '5a9cb1649625f0bf41fc7791b635cd9c2d7118c7f021ba87dcd03=
f72b67ce7a8'
-        unihash =3D 'f37918cc02eb5a520b1aff86faacbc0a38124646'
+        unihash =3D '46edb5140d2613049332d0bf3745d9fafec9c559dac8cc6181373=
9a28007fcdf'
=20
         result =3D self.client.report_unihash(taskhash, self.METHOD, outha=
sh, unihash)
         self.assertEqual(result['unihash'], unihash, 'Server returned bad =
unihash')
=20
         taskhash2 =3D '3bf6f1e89d26205aec90da04854fbdbf73afe6b4'
         outhash2 =3D '77623a549b5b1a31e3732dfa8fe61d7ce5d44b3370f253c5360e=
136b852967b4'
-        unihash2 =3D 'af36b199320e611fbb16f1f277d3ee1d619ca58b'
+        unihash2 =3D 'bf6e81926066f770e960f9f777cd088c62bea9addb7745f3e77d=
eaa81a645747'
=20
         result =3D self.client.report_unihash(taskhash2, self.METHOD, outh=
ash2, unihash2)
         self.assertClientGetHash(self.client, taskhash2, unihash2)
@@ -1059,14 +1116,14 @@ class HashEquivalenceCommonTests(object):
     def test_gc_switch_sweep_mark(self):
         taskhash =3D '53b8dce672cb6d0c73170be43f540460bfc347b4'
         outhash =3D '5a9cb1649625f0bf41fc7791b635cd9c2d7118c7f021ba87dcd03=
f72b67ce7a8'
-        unihash =3D 'f37918cc02eb5a520b1aff86faacbc0a38124646'
+        unihash =3D '46edb5140d2613049332d0bf3745d9fafec9c559dac8cc6181373=
9a28007fcdf'
=20
         result =3D self.client.report_unihash(taskhash, self.METHOD, outha=
sh, unihash)
         self.assertEqual(result['unihash'], unihash, 'Server returned bad =
unihash')
=20
         taskhash2 =3D '3bf6f1e89d26205aec90da04854fbdbf73afe6b4'
         outhash2 =3D '77623a549b5b1a31e3732dfa8fe61d7ce5d44b3370f253c5360e=
136b852967b4'
-        unihash2 =3D 'af36b199320e611fbb16f1f277d3ee1d619ca58b'
+        unihash2 =3D 'bf6e81926066f770e960f9f777cd088c62bea9addb7745f3e77d=
eaa81a645747'
=20
         result =3D self.client.report_unihash(taskhash2, self.METHOD, outh=
ash2, unihash2)
         self.assertClientGetHash(self.client, taskhash2, unihash2)
@@ -1089,7 +1146,7 @@ class HashEquivalenceCommonTests(object):
     def test_gc_new_hashes(self):
         taskhash =3D '53b8dce672cb6d0c73170be43f540460bfc347b4'
         outhash =3D '5a9cb1649625f0bf41fc7791b635cd9c2d7118c7f021ba87dcd03=
f72b67ce7a8'
-        unihash =3D 'f37918cc02eb5a520b1aff86faacbc0a38124646'
+        unihash =3D '46edb5140d2613049332d0bf3745d9fafec9c559dac8cc6181373=
9a28007fcdf'
=20
         result =3D self.client.report_unihash(taskhash, self.METHOD, outha=
sh, unihash)
         self.assertEqual(result['unihash'], unihash, 'Server returned bad =
unihash')
@@ -1106,7 +1163,7 @@ class HashEquivalenceCommonTests(object):
=20
         taskhash2 =3D '3bf6f1e89d26205aec90da04854fbdbf73afe6b4'
         outhash2 =3D '77623a549b5b1a31e3732dfa8fe61d7ce5d44b3370f253c5360e=
136b852967b4'
-        unihash2 =3D 'af36b199320e611fbb16f1f277d3ee1d619ca58b'
+        unihash2 =3D 'bf6e81926066f770e960f9f777cd088c62bea9addb7745f3e77d=
eaa81a645747'
=20
         result =3D self.client.report_unihash(taskhash2, self.METHOD, outh=
ash2, unihash2)
         self.assertClientGetHash(self.client, taskhash2, unihash2)
@@ -1405,14 +1462,14 @@ class TestHashEquivalenceClient(HashEquivalenceTest=
Setup, unittest.TestCase):
     def test_gc(self):
         taskhash =3D '53b8dce672cb6d0c73170be43f540460bfc347b4'
         outhash =3D '5a9cb1649625f0bf41fc7791b635cd9c2d7118c7f021ba87dcd03=
f72b67ce7a8'
-        unihash =3D 'f37918cc02eb5a520b1aff86faacbc0a38124646'
+        unihash =3D '46edb5140d2613049332d0bf3745d9fafec9c559dac8cc6181373=
9a28007fcdf'
=20
         result =3D self.client.report_unihash(taskhash, self.METHOD, outha=
sh, unihash)
         self.assertEqual(result['unihash'], unihash, 'Server returned bad =
unihash')
=20
         taskhash2 =3D '3bf6f1e89d26205aec90da04854fbdbf73afe6b4'
         outhash2 =3D '77623a549b5b1a31e3732dfa8fe61d7ce5d44b3370f253c5360e=
136b852967b4'
-        unihash2 =3D 'af36b199320e611fbb16f1f277d3ee1d619ca58b'
+        unihash2 =3D 'bf6e81926066f770e960f9f777cd088c62bea9addb7745f3e77d=
eaa81a645747'
=20
         result =3D self.client.report_unihash(taskhash2, self.METHOD, outh=
ash2, unihash2)
         self.assertClientGetHash(self.client, taskhash2, unihash2)
@@ -1455,7 +1512,7 @@ class TestHashEquivalenceUnixServerLongPath(HashEquiv=
alenceTestSetup, unittest.T
         # Simple test that hashes can be created
         taskhash =3D '35788efcb8dfb0a02659d81cf2bfd695fb30faf9'
         outhash =3D '2765d4a5884be49b28601445c2760c5f21e7e5c0ee2b7e3fce98f=
d7e5970796f'
-        unihash =3D 'f46d3fbb439bd9b921095da657a4de906510d2cd'
+        unihash =3D 'a69ec97f5af2e21e1a1f9cc8896965515d5559425666f734e245a=
3d40cee33d9'
=20
         self.assertClientGetHash(self.client, taskhash, None)
=20
@@ -1542,4 +1599,3 @@ class TestHashEquivalenceExternalServer(HashEquivalen=
ceTestSetup, HashEquivalenc
=20
     def test_auth_get_all_users(self):
         self.skipTest("Cannot test all users with external server")
-
--=20
2.34.1


