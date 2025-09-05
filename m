Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85CCACAC583
	for <webhook@archiver.kernel.org>; Fri,  5 Sep 2025 06:21:24 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.75])
 by mx.groups.io with SMTP id smtpd.web11.14988.1757053273963266587
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 04 Sep 2025 23:21:22 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=ND2aqua5;
 spf=pass (domain: weidmueller.com, ip: 40.107.159.75, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QbB4McGAHm7ZjlKWn+ETomIucKv7V0c6Sy0G9E/qHUcjnojYVNLfSsFq3nTdyPYG8gKve8zgmYOye+1pbY6fKkKxAj4g4rCnoti7tWQUKddCx/nRyZ3nBl5oIV2uiGUFzKfSaHDPbSmc+4f8fLf2WpUqy1P3PYyB9mp34eKUDiDcIbxnTACsPrZKaom7eWoBK4l5e8TqR8SC8nd24z7gV7EpK0iDWZwOF3FiSGEpbKdFsoU7MFb10/9huoik96ni4nCxoC/XTbj5kGMdrID5ZnZ6ErK1a6D/1NlGsrTNo7edc55C8EmXOQxXesn7Ta5asPNNbk//XM/neruUfX+l9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JQdp+YGgCowzGkp093QgL5rYpiwzFykoLf3cxs4jELA=;
 b=yuWHLM9pwQ4q+wFOa9rOZjHsGxS4HKnucFQiOQoMPPOF4bFmqsb0StLp/1j6fp3wyIm8lHAc2ZbQyO8tH4xqw88Q2WMrJhcbA7B04VcqR2tgJz067Cae7/TLlF8bfiXHgxQLyeCYUjKfWgiz3D5fLSl4FzecbbqbTRPbSwBdQp4Wf56lMZIf2Ju7xcTrH440ElmezirLn1DW0hrfLXh+guidHjqGEfJVlplwTlc7iw2FQL+4BRptDzrLCHXSGpZXhPXIk9fXpf5wH7qgt9n4/YmsS2SmTRpWX+4ACzuNrb+cPQD+uFRvODxUhrXPWgBLb4LBPwmJtjvkwVm1Bh2RGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQdp+YGgCowzGkp093QgL5rYpiwzFykoLf3cxs4jELA=;
 b=ND2aqua5wY/yji6Q6agyXlok5fgOnzxwr6EJ13rRf9oIpBg+JdEJMgCS0vaIJq2DPOV7pp8q3sa+3OKfpNV77eCbHHT6korevNASOkf+JRyVaX4/Es0HU6gPvLXL8RqRaJJ+PCyEyuWUhkWtbtjZ58Nz7LBhaF1Tt10EVrHU8WK75YTrtaKWNDFmCGHamDVMU+oOJzSf4EOxoGkZBaEHuDzQ89uozRKI6ZyCTZXOUMGUGcJ8IN1MrIAx28bIHtd+ZHfIjTQ7v4WI5eLsVpaMuysfy9qF59RGZZiTIu+ydKgdGjAVBylHecpc4rb/bR5Y56URHOpq39spvsVPDCCyZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from DU0PR08MB8422.eurprd08.prod.outlook.com (2603:10a6:10:406::6)
 by DU0PR08MB9632.eurprd08.prod.outlook.com (2603:10a6:10:447::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Fri, 5 Sep
 2025 06:21:15 +0000
Received: from DU0PR08MB8422.eurprd08.prod.outlook.com
 ([fe80::4ac7:a794:5e4b:fc25]) by DU0PR08MB8422.eurprd08.prod.outlook.com
 ([fe80::4ac7:a794:5e4b:fc25%4]) with mapi id 15.20.9094.017; Fri, 5 Sep 2025
 06:21:14 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH v2 12/15] fetch2: gitsm: remove redundant check
Date: Fri,  5 Sep 2025 08:20:55 +0200
Message-ID: <20250905062058.2563806-13-stefan.herbrechtsmeier-oss@weidmueller.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1a775ca5-dc18-4777-fa6a-08ddec446a7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?tDpkGhbhAgkUfoKLovoLgyVT8dC9MWkAKsGlSSAaM6gM5OsG7oR9SVa2K5QP?=
 =?us-ascii?Q?+hN+26Ywoc606yeKo069IoWhAQ+tataHqD0gGnjIpFEMbi8kISSkSTEJtZN6?=
 =?us-ascii?Q?hI14ya6mHtUxCP+9meDRrDcwJxUAXmQ0AT//HkEhO/4RBh8IGGM4gLb62MOM?=
 =?us-ascii?Q?cClsTwSDb42eOxr8G5FNW12lVXCT3gxr9s7MbRwh4A6SBFcf6oxkvcJXbRlR?=
 =?us-ascii?Q?lw9RDCHAPvwoMeLZuecSpJqOaIcG8899N0TltSNZ/oA4QweNiRqXEaAXFZWg?=
 =?us-ascii?Q?19Sm8KOztYnliXTWEtGNahGM4hjxXH5F/iCZlLlfSePIsV3NaQQkix0rV7g1?=
 =?us-ascii?Q?so+VVVhBhU28jJ/QH5bjYumaNoxzqKcjBLZitGResKQfInv2cwiVyy/XT54m?=
 =?us-ascii?Q?pJXHb12MRPelvfcXq0kc7lHKHDMqBsEGzAOPlfrBssv3JmpSBWKGZp4B+2BE?=
 =?us-ascii?Q?ByaRM4tnvCbyO9XF2faMXzvTSR8683ZfUnDbUFoGmW20V3sH1kQN4LgC3x27?=
 =?us-ascii?Q?n7QDE+T2iA/0u43e+aaTvH6Xq/t49iPsJDjkzM9bA5+n66iDFDSHi3/4yo+n?=
 =?us-ascii?Q?0IyVqpjl/7RoVAa7gJrIGlp3EvkaArLpe19rYMu/eVWjZwG56FLtJdrVZ01O?=
 =?us-ascii?Q?Vg0dXM4jQnCsaqAvC7patTRe7Ro6XywTaizcpcfK5S5rtxEEgBw6TcXGoSzO?=
 =?us-ascii?Q?QsSz9ncHri2HchH8kjOSJcGE8YglyeaRrNQH//bqhVquI3wSQTB8DioPlVP6?=
 =?us-ascii?Q?vYD9oQsyESambXkuBgexPxsZhjZ7sdSha4lESBB/YnA09qhIl5ZpbRHWAaKw?=
 =?us-ascii?Q?xVn0zxNzhamp8Ar9HVEkV/fwf6eq+rUgq4/ARFUmS8tU9r3NbKqin9UnSrZ5?=
 =?us-ascii?Q?7zYzMC/sUdwJCAosDsE7mi/kszc0+1jUDqWYlHW8uuJd+T4ytjKijZ/ImvaG?=
 =?us-ascii?Q?Ko6Jo2nATOwc9bKFjpoOZHJ6XoaqjHbpUsJ1y4gn3unaQ/oOFvd56iIun700?=
 =?us-ascii?Q?5YC1a1ACMT8r5a81KkoRXIBmaTTwjq8a9O+i9MqPTHco/ydDQxw381bnUW9T?=
 =?us-ascii?Q?hlYh++to7v1TelreU8ArPTFo8JU0dMjK1Dkho0nzx7XX+A/ETi0p9tNxuSqN?=
 =?us-ascii?Q?pl/9Ed8z5bVqRHU9PY4jErsVfKCUyyKZafWrutgngRMaxMly/wevqJgIKHT2?=
 =?us-ascii?Q?KABVGtCc6ca9IT4hDKrAbZNKkvpWFSjkGjrW2YSwLqVP4n+CIGI/F7kUCGOx?=
 =?us-ascii?Q?xpDyiui0L6H0OViT0PjFANnjThjH3Xs00q2ZaO+kOIEtQzYCWbB6G+2Qmsyu?=
 =?us-ascii?Q?slZ8XDX7k5BUFNrUPun2jB9vUWFr5qhWos3ghQL+0Ts3Q90pFFCR9tBKOgZZ?=
 =?us-ascii?Q?xVrB4Mmm+RhduStnS1TM3Z3S+v5FjYBe7UcNArrHSRW7RlLSCTmgLIthLbpo?=
 =?us-ascii?Q?VrJSgdCsSqBOc+UPfiFNk8QGlfly3qHT+/wEXVaOruRGCJI0ykLhZg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB8422.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?cYN+tUeM++ZZ3JCxbQhFpZ9TrUkK8to15cdEwZPI+h2OQDZw+2rgLgorZITV?=
 =?us-ascii?Q?Wa0e1AP7wCP+AIOM3EOrJshazp+SizzrZetMECnl4B8aSTLlbzsTofKIPQmC?=
 =?us-ascii?Q?t7GJNqbb7usflp0rWJ1vl9OTSpV4++6Z7b04U0YKqGu2zHpkyrvu00OlnK/G?=
 =?us-ascii?Q?3CxpeYDZLVD1Ors8zhDiWRBrIbZ1mIeTzpnIEEmfsaWTBUzZJFBSnUCulQy3?=
 =?us-ascii?Q?aDLIKvy8NA6gVhSYeIo/tSWEZTjE4CMnhP/u//erlkVJXiozWavMuXqhts1J?=
 =?us-ascii?Q?J1wvnI26cUzWlS0/JwlU/oIqJAVJ8GubRNa3trr8CdhvtSyjo7rm2ZVo/wj7?=
 =?us-ascii?Q?ibjrnxXB/woCLjXeD70SRsNlG6Vj2SRNcvxeu3NiatKc+fSSzPzzP/1X5RrR?=
 =?us-ascii?Q?EGYn8qZqPFLSJPgh2kVX1TRo0cIEJZq8O3LN7y9bgqQ0loy7J58mr8SLtHnX?=
 =?us-ascii?Q?jnxHpDXkmcr+9Ou91GsezghBs1uQ5JY3mkJ4aZFtEdsAQNtk+EQXDshWXZyt?=
 =?us-ascii?Q?mmaytJKKeP6qvwnIOx/t1H2qU14rmjhnkDGJJH/NOJzs5AItiyWmdhSEWTnd?=
 =?us-ascii?Q?L6OsqYpcos7lJJ07DIwo91As+chpFGJyPf5845LLppYd/HF8kk48QMvb9qpB?=
 =?us-ascii?Q?D/6mqH/lTVIu/jBolXNKRiJQllzxVrfVV7U/evO095v33ACs2bDiXZTqyA5c?=
 =?us-ascii?Q?tehem5N0I4ia+ui1SqPZKw6mGD+tiNJPur2u74CBEShGul6SvoelP8YUkl+t?=
 =?us-ascii?Q?XPh6OB0FaA7tNB1z+N9RC2jhHEUQMpjYX0tuqx0VdHGczaWaEaRP/5GeM75S?=
 =?us-ascii?Q?dhrALR3tz95Oez7euPBIEQStUIlRmEAh8hfHvZEYNKuTlYDmrS8hRpKpvCUP?=
 =?us-ascii?Q?hE3jXD9cK8UcEj3Cpom43luzony9ftHlV2bI73pVXrHRguJyzX9VhODQDPUI?=
 =?us-ascii?Q?BWUumLx6mYpU7jh4KItAFf8Ww1PGMFeFIo1SGyDKMAc5WIETy4IEwt3glW0H?=
 =?us-ascii?Q?5S9x+3Q/gAaHefnyGdWy1d+e21j1uxrSYkRc6zEy4zUeHSWJgQXVTGfWpCZN?=
 =?us-ascii?Q?2A9Ydi948X+EexC3NO/Y+PJUNCyaeayg9Uo3CTr04KMFe0LwrIayRL78UztC?=
 =?us-ascii?Q?ODwRKI5Tp74aJg2eMPPp86mTki9WF0hScGHXzgaw17wwI8gpW7RLA1Tf/Brd?=
 =?us-ascii?Q?0t9W8PoXjvBSkhxVzgKUg4lLcT0U2XZVd5aqvfPN6BXhhkWse6ENuJ1YFEQj?=
 =?us-ascii?Q?XlXVOLLK3VLldVCYOEe6DA/a8rpyax8mYWbBqDDFDmoiBKLQDGqnPrr67qSW?=
 =?us-ascii?Q?hVnLueGNO4fsySlOs4uNs+hKC0nzPROim8xiSodG3hvaco+Tt1s0zFYFLsIM?=
 =?us-ascii?Q?+Am319dRR6L8WVKB6/a3HJegyowIUnJhWlQMwJkWHRKev8HZ4FJraK5sNMAW?=
 =?us-ascii?Q?utxubosSZl0jOt7sNCu/4GK5C7cQdeI4YNLnnuBDTtLsVliL1DTEgkxLnhd1?=
 =?us-ascii?Q?fuw9BTPrjibgodPmvtPZy5vc+qjbdjb27Ex2WKVn+nrS9B+PnvC4l2Fg7q6e?=
 =?us-ascii?Q?6mI2cBi9VuBf5l8hcmL5TmggzIJHIpyDfRNgbty2DCdGIvwnY8JVKKecKXbp?=
 =?us-ascii?Q?qw=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a775ca5-dc18-4777-fa6a-08ddec446a7d
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB8422.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 06:21:14.7067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NzHBUO9KYrAf71+SorAOYe95J7vJ4qLyC1z8FvU5ybn5iR3CaiyyKyx5TlUyMrtq8VYM/tWXfFSmeGeCRoAeFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9632
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 05 Sep 2025 06:21:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17969

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

(no changes since v1)

 lib/bb/fetch2/gitsm.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index 37f82cd37..9afdc8370 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -174,7 +174,7 @@ class GitSM(Git):
                 logger.error('gitsm: submodule update check failed: %s %s'=
 % (type(e).__name__, str(e)))
                 need_update_result =3D True
=20
-        self.call_process_submodules(ud, d, not os.path.exists(ud.clonedir=
), need_update_submodule)
+        self.call_process_submodules(ud, d, True, need_update_submodule)
=20
         if need_update_list:
             logger.debug('gitsm: Submodules requiring update: %s' % (' '.j=
oin(need_update_list)))
--=20
2.39.5


