Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA29CD484C
	for <webhook@archiver.kernel.org>; Wed, 13 May 2026 05:24:53 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.905.1778649891739278369
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 12 May 2026 22:24:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=Vkd4476u;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=959349fd7a=qi.chen@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64D1cW2u011026
	for <bitbake-devel@lists.openembedded.org>; Tue, 12 May 2026 22:24:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=RiYpszMLZUccCFfBv2TasOUCkouSI/Yrpn+KSLPaKs8=; b=
	Vkd4476u4nvwVBHB6WU8o2khbj0nHZ+vwE4if4GAgYf01DigekRMz9996cI8tx4r
	DEcoXll+0Z/pmb9PrSZ3ex1Qwm8mlrQBajpMCJxqRK3LTiP1JE1D4hplRnQsL3DA
	J6gDhW77NNkmyYVj7QRXvi7L3JOKLqi/Z1o06lrBCRCD54k+xKhdPCgdlp6saeC0
	7o7ty3NP9mF5lihruW+Y1VFDEyIR7BMNAcsQkjmJ2WEF79LT/QbHVc+KbNFlyKOO
	xbWU5WVkbJ62twwh2vEdKoU837rfTigubsXmArw5i54dWWsBwbjArUEJ/X90/6Z1
	C0Ge2cfE9ooBEX1DasbqWg==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013071.outbound.protection.outlook.com [40.107.201.71])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4e4ftb873y-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 22:24:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FkiqXq+nd3lo5YHQLsB6D3FblCkR5xwTOj2pGIoU+Q4KriXu2BvM7RHYQ+YTZGXZjD98an1a3KwtxsVdBCjzLKqCB6YNx9xIfiye6XuoFQT6U+Ib/hp5F8xkrijxB5E8/sKSagS0MHPyBEctPwaGap0NtED2GCyOHvVrdRyJE3Uu7o18DrFYvBJvf1uvOvcAAnHpvzPb+npJXPLgGaU3TU/44ZxLFqCi4KCcVCbWvs16ixm9RRdXl8T+FA/51lUZhO+1MqDXUN8r9rd3aSz8bxswTCPxPsuohS7V7zMZ3UtoNwTCiFtit9gE1Wc/Fi+JRABQ2yUaJU6pdSoQo74t0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RiYpszMLZUccCFfBv2TasOUCkouSI/Yrpn+KSLPaKs8=;
 b=hYHsqxKrZxeap/3chJJopKfL0/Ry/9CqvmobzhKURxKQOxW4IqdXwwOPUwToBk2O6eJYDjnekYUtHgMWi0uquLVkl2nZXa7gsOodxHKN1tPUCdY3URmo1Mnljmr0eGQKSkUuVUklCQ1t3U/+UfU9Kd7vTdCpsicnGD+k55EoQxkpB3ZQwBoUnQhqYfvOxkbPeh4Hy2qrWyi0/FNXe8Mwl9KBMT0BfNZQUfVpKu9YM2ou7qtpQZY4QnaP/r1y7BhP/dp0ZX5VSo6FO2pkiWwLTTZLbT0GL2gF1O4PuCeG/OpoZcJbN5i+8Vwd3GRSatQp4QV0cTvPtHlQgLA4dxaTlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by DS7PR11MB8855.namprd11.prod.outlook.com (2603:10b6:8:257::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 05:24:48 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%3]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 05:24:48 +0000
From: Qi.Chen@windriver.com
To: bitbake-devel@lists.openembedded.org
Cc: alex.kanavin@gmail.com, randy.macleod@windriver.com
Subject: [bitbake-devel][PATCH V4 5/5] bb/tests/fetch.py: add case for filter_regex parameter in latest_versionstring
Date: Wed, 13 May 2026 13:24:24 +0800
Message-Id: <20260513052424.2271877-5-Qi.Chen@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260513052424.2271877-1-Qi.Chen@windriver.com>
References: <20260513052424.2271877-1-Qi.Chen@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0179.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::35) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|DS7PR11MB8855:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e910b8a-704c-4b73-223a-08deb0aff35b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|56012099003|22082099003|3023799003|18002099003|38350700014|11063799003;
X-Microsoft-Antispam-Message-Info: 
	C3AQvUZEefCijJmc3KPyh8oJA4vwHbQAcw2seHI4w8M5C6GSxbeCldpblVhlH0f5e/8E4sOzqaVzD3I4H4W75e/1ixtr1+oMStIzG3D6ZVedSxCqh/M0YCqYYbDhZfD9duVXaAFrCKHqnLV/WWrhzodFuiBK+V9uJa+Iiquwxu3uqoH1veyvWxdZGyrq3ClItkiC8h2zgdqxBNLpCTu9lik2GCg5MVuPdcFqcK0ksEh/6cQmZobtf9RGYuqv3uQ29IBIOdD9gX9GAjaCz5OglrGCJf0qCMBxUGPTGgP50uaHqC2k7LVdtt07UEimNjNSn+gBxSJF3PGjGxIheVIgZQLdCqqIEdS4s2FBL8UBL1RpMUYWQSKzf/A+2vHsP8FPRttY0grQhCrbUdR0L3wx1SQlzPsHqbnq94jwGnqytRbJupyAH5Gy+k3891Qh0yqHN2NxXtKZFj/TrMzWfDpPVJr8q/abSaOU0mzCz5A3zoMTu2FgzfsRrhwHGTOlmjIHw0nfTyLD0MjJIOCSajVBvqcxYRNyH8wEqkyKMU+Y2fhbHPvqiV/tKzpxgD7zh3doewHGDqdtZC8f/7tRhc4beVaIOaOjsP4nyrvkpMxaNUI1Ifqe4uMcBaZ7AdJQzb2p88DA/Kx+xTosPQmJrdf/zPxfs+y51rvGZtFt3SMqKPydZhggywa24SD4DMGwMiuREiSOs2g4685KmJ+aEKqCQg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(56012099003)(22082099003)(3023799003)(18002099003)(38350700014)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?74r0D3WlJQoBQotjd/jj+1EssPkV53lxmYkb1BDetMr4n5ziX6LZKIonN0wg?=
 =?us-ascii?Q?P5kg5PHZ4FXWYbsDv6frycF84418aYYQUJl7yT9OydEWDcZmOkeGgZKjHa+v?=
 =?us-ascii?Q?ZnDwnEPqpFog2sW+HaFvmQ7ij6jdkI9CZB2EBkHW7CkyX+1kNmTRkW+WH5X4?=
 =?us-ascii?Q?utRduYEXdSY06r6GM45Sl7pvdZXw/BVU5/I6jzRyqQsUg6LcvnqsrvPKlem8?=
 =?us-ascii?Q?dhnfhPrUzcDgvqxK1/J9DsnRgSnj7WrPkg9DMeKMQCNmBXkHyW/8FdfR8veZ?=
 =?us-ascii?Q?yF8tY7sahOcSF3bhnc04Oz46bCVR2+APsuA5mRqJsOHvf1sVq0P3NdqVrZ9k?=
 =?us-ascii?Q?imNd6lVOf9pLAWd7TMerYfKVgjab1syobqHIBFo7j5gVNDC7kuxyvll6r4xs?=
 =?us-ascii?Q?GJIdhm59KLYGANTMQ2AzcGxIurSnaZIaDm/6zQgP/z/StDpdO7GA3zODidk5?=
 =?us-ascii?Q?QS126b82LN58oBjeolNOB8dsg22OaQBB2w1dI+zmr6DRyUIMAwZToOwO7eAK?=
 =?us-ascii?Q?zmuGrEX5xVhUj3ZB77YEA7UQbsnv2X2MNqCEGepYysEoq/3Zp1IUwxEjMNG+?=
 =?us-ascii?Q?5dnHJMntO3PExMlZxVS09YCKbmI6V8PBRdlrWkvLs4s8TpBUVQQTTE3ChY5o?=
 =?us-ascii?Q?aI5XZW5159iuDynMMr9dwNMCj8+O+h63iP4bctv3uzURVlNnzBaGbHUGuFR5?=
 =?us-ascii?Q?oh2XXGG3d7qPk18K2ptsbpWFDXrwoFG4ctM9OP2GgPs/JIHQGOG369EBM+sr?=
 =?us-ascii?Q?DdKlvr1jNoff8DpJnSoIHG+enbnK7TpDwGZMt6MnMI/CS+s5PeibW4ch7PzC?=
 =?us-ascii?Q?8N+pe/7O63AZdw4mhQ+aKCunCbXZ2s2IFvFhbF2hniwtcA0vPwdHRZK7hDmi?=
 =?us-ascii?Q?k1PdboF5HKau19EsGMad2Fr2EC7tKSVuLj0xTDj9Nw3gYcVumP59VRYrRdbA?=
 =?us-ascii?Q?xX/4tDv0Ymlim9YNUMYPIPrmVCersY0lUhACf9/MSV2TDDz7Uac1CqGcozi4?=
 =?us-ascii?Q?6UWjlzosbkN23I+5zJzegOl7pQFgy2Wp748T3cUmcrIUQGGc4PxEwF/Xl9nB?=
 =?us-ascii?Q?bEcy5fX9fqxdqCGpTuiPJAsP86u9CBObmNb4aiB+aH4smLYv7+I4O68DrGst?=
 =?us-ascii?Q?mHLzBkM61mjPF807jmbF30cXOxprI+ryZgWeaCDI4M1kMuSv8SfbndAO2Lf3?=
 =?us-ascii?Q?neUw2oRCWQzaHvCVY9ogJ2FqHMavsNDaOTQTQHDWRKsD6mDnRMwwuon826Fe?=
 =?us-ascii?Q?LFOQvY1Aqg0KVHJIx0iNReli4BUj26l6/k28JnUa3zjMtqf1qO/2APoBKZn8?=
 =?us-ascii?Q?aSe+wGElvxfzX5wNc//akKCJRCzoj2GZZFDRKV2K7iFH+a7nfLwbbSDDcSIp?=
 =?us-ascii?Q?FfC4wGs8dtEzy5nbqFDLaTz3oIOj+rOPyoKuS00xEQWPQWLu7zBqqiRxmj8P?=
 =?us-ascii?Q?PoAbhM129iMIZ6MAqLLBbx/ozUqmoxH6fiGRiv0oYsyEOuBI3wHMjX5uUsby?=
 =?us-ascii?Q?qZkNVPyJ3y3ejMfOj4EBY9x9cv8LZ24nfYOQveEJYivK4SXZdzSAcgi9LZcK?=
 =?us-ascii?Q?i7CEeEgM05FSd9SqmSIE+4UhL1k5hB2Eomxrz9aQdetHlhRPAkP23lCkWCGF?=
 =?us-ascii?Q?q4zFjpXhFFAFIo1a5edfd7s7z5KhzLVh5Kyt7in/HtC2rdUyChaCq9oxS9Rd?=
 =?us-ascii?Q?U1JngbkfTnt0HiLtTNUpYdzlrxpDfkGVFpwD8HaZElhj7NL0ugsYxTDW/+mM?=
 =?us-ascii?Q?lPSI89c9gw=3D=3D?=
X-Exchange-RoutingPolicyChecked: 
	J4liT31yoEhq+1C7Skvklaj61xSzE+uM7ASHqveJOl1PcVRaBUptGxvrqMmKskEQrYFSJi5OEkXn5NpzyfPclYOfilkQwK8tXYMsaRxKK2QiTaq5A+jxlHD8BXZq2FD1Guy3LuQlorqt/gYK9CT0mpsRk/pbwRxc2so3alP6zIWcmyhyerxY2V8gh3sBxF6s12pg2b0uc/7XVB7ygQRY5vLVzyZgtyMSU2AgpSz2wA3gvaLHabKliYVj8zB6J1EgQnbVM4t90CDmbedcOWKrg9yMY+aYl4THTcAD51eJzRPDfWYrfk4whaZoGhYQk/pNFpTAGEUTaqnnRvSOo5sVjg==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e910b8a-704c-4b73-223a-08deb0aff35b
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 05:24:48.4780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d2Ym3lGSbN29ULnWZ6RVixsMP41+/w1uxLspyRkDwjkXKJtf+pgoofl28f0BfcWbifyK8zdtBDcsOX8X2NRriQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB8855
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDA1MSBTYWx0ZWRfX8j7kYFBc6Fn3
 oaw4BkHNOhiEg7qACpfqjFoZY5tqK/NFUlCr3E+H7ih2hVbCuBNKWY2fEK42plMhz7NfiSLZv2F
 9bAH+1fSbOuItMeAYoThtOBi36ITFDZFavFNV1My5f6At4sOn0hUARB1674O+MMKnfRuPkkQ4b9
 Tbn3wOeefyFgTx17KGF3AUT/WssUPNeVrBp4FNOZjkR8UHbehhufe8SeIDzTdcueqhjFeePs4bN
 y0QH6C2zD4tfDhH4twb/Z+m18g/9ovPP8Adlx0WtwrFICT43DvkpOKyIydZdkGxInfwj2sV/i+k
 nF/qE3sBTH4C7LPIjfPFtJ7YNaZLk9CInLacMEiuJSgZQo8PefmrtmMlWvkkzXhme+bhX11VvFN
 u6Ooevq2Ngt9P9AvHommOQFNVJO+BR75rqM+lgNui5yasuVMf6dcPv46aSEKzZBmcPH+2eOtPvX
 HF7omQpDSB1jqZeZuEQ==
X-Proofpoint-GUID: JlNlK5W8rEorx56EqIzQDngIyJpQ38P7
X-Authority-Analysis: v=2.4 cv=du/rzVg4 c=1 sm=1 tr=0 ts=6a040b23 cx=c_pps
 a=eHfeAi0ej4loD7KcX6Y+qw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22 a=3tcz3bTJAAAA:8
 a=iGHA9ds3AAAA:8 a=t7CeM3EgAAAA:8 a=NEAV23lmAAAA:8 a=yBcSI8iXaKTbtWxE768A:9
 a=4EbjBm0RLgFgoQzmu6QD:22 a=nM-MV4yxpKKO9kiQg6Ot:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: JOuj3gV0uOrN_4trjsU-8c9XbpcMXUoZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 phishscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130051
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 13 May 2026 05:24:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19505

From: Chen Qi <Qi.Chen@windriver.com>

Add bitbake selftest case for fitler_regex parameter in
latest_versionstring to ensure no regression.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 lib/bb/tests/fetch.py | 78 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 77 insertions(+), 1 deletion(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 86dd92992..702664578 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1512,7 +1512,24 @@ class FetchLatestVersionTest(FetcherTest):
         # basic example; version pattern "A.B.C+cargo-D.E.F"
         ("cargo-c", "crate://crates.io/cargo-c/0.9.18+cargo-0.69")
             : "0.9.29"
-   }
+    }
+
+    test_git_stable_uris = {
+        ("dtc", "git://git.yoctoproject.org/bbfetchtests-dtc.git;branch=master;protocol=https", "65cc4d2748a2c2e6f27f1cf39e07a5dbabd80ebf", "", r"^1\.4\.\d+$")
+            : ("1.4.0", "1.5.0"),
+        ("systemd", "git://github.com/systemd/systemd.git;protocol=https;branch=stable/v259-stable", "b3d8fc43e9cb531d958c17ef2cd93b374bc14e8a", "", r"^259\.\d+$")
+            : ("259.5", "260")
+    }
+
+    test_wget_stable_uris = {
+        ("openssh", "https://ftp.openbsd.org/pub/OpenBSD/OpenSSH/portable/openssh-10.2p1.tar.gz", "10.2p1", "", "", r"^10\.2p\d+$")
+            : ("10.2p1", "10.3")
+    }
+
+    test_crate_stable_uris = {
+        ("cargo-c", "crate://crates.io/cargo-c/0.9.18+cargo-0.69", r"^0\.9\.\d+")
+            : ("0.9.29", "0.10.0")
+    }
 
     @skipIfNoNetwork()
     def test_git_latest_versionstring(self):
@@ -1569,6 +1586,65 @@ class FetchLatestVersionTest(FetcherTest):
                 r = bb.utils.vercmp_string(v, verstring)
                 self.assertTrue(r == -1 or r == 0, msg="Package %s, version: %s <= %s" % (k[0], v, verstring))
 
+    @skipIfNoNetwork()
+    def test_git_latest_versionstring_stable(self):
+        for k, v in self.test_git_stable_uris.items():
+            with self.subTest(pn=k[0]):
+                self.d.setVar("PN", k[0])
+                self.d.setVar("SRCREV", k[2])
+                self.d.setVar("UPSTREAM_CHECK_GITTAGREGEX", k[3])
+                filter_regex = k[4]
+                ud = bb.fetch2.FetchData(k[1], self.d)
+                pupver= ud.method.latest_versionstring(ud, self.d, filter_regex=filter_regex)
+                verstring = pupver[0]
+                self.assertTrue(verstring, msg="Could not find upstream version for %s" % k[0])
+                v_less_or_equal = v[0]
+                v_larger = v[1]
+                r = bb.utils.vercmp_string(v_less_or_equal, verstring)
+                self.assertTrue(r == -1 or r == 0, msg="Package %s, version: %s < %s" % (k[0], v_less_or_equal, verstring))
+                r = bb.utils.vercmp_string(verstring, v_larger)
+                self.assertTrue(r == -1, msg="Package %s, version: %s <= %s" % (k[0], v_larger, verstring))
+
+    @skipIfNoNetwork()
+    def test_wget_latest_versionstring_stable(self):
+        for k, v in self.test_wget_stable_uris.items():
+            with self.subTest(pn=k[0]):
+                self.d.setVar("PN", k[0])
+                url = k[1]
+                self.d.setVar("PV", k[2])
+                if k[3]:
+                    self.d.setVar("UPSTREAM_CHECK_URI", k[3])
+                if k[4]:
+                    self.d.setVar("UPSTREAM_CHECK_REGEX", k[4])
+                filter_regex = k[5]
+                ud = bb.fetch2.FetchData(url, self.d)
+                pupver= ud.method.latest_versionstring(ud, self.d, filter_regex=filter_regex)
+                verstring = pupver[0]
+                self.assertTrue(verstring, msg="Could not find upstream version for %s" % k[0])
+                v_less_or_equal = v[0]
+                v_larger = v[1]
+                r = bb.utils.vercmp_string(v_less_or_equal, verstring)
+                self.assertTrue(r == -1 or r == 0, msg="Package %s, version: %s < %s" % (k[0], v_less_or_equal, verstring))
+                r = bb.utils.vercmp_string(verstring, v_larger)
+                self.assertTrue(r == -1, msg="Package %s, version: %s <= %s" % (k[0], v_larger, verstring))
+
+    @skipIfNoNetwork()
+    def test_crate_latest_versionstring_stable(self):
+        for k, v in self.test_crate_stable_uris.items():
+            with self.subTest(pn=k[0]):
+                self.d.setVar("PN", k[0])
+                ud = bb.fetch2.FetchData(k[1], self.d)
+                filter_regex = k[2]
+                pupver = ud.method.latest_versionstring(ud, self.d, filter_regex=filter_regex)
+                verstring = pupver[0]
+                self.assertTrue(verstring, msg="Could not find upstream version for %s" % k[0])
+                v_less_or_equal = v[0]
+                v_larger = v[1]
+                r = bb.utils.vercmp_string(v_less_or_equal, verstring)
+                self.assertTrue(r == -1 or r == 0, msg="Package %s, version: %s < %s" % (k[0], v_less_or_equal, verstring))
+                r = bb.utils.vercmp_string(verstring, v_larger)
+                self.assertTrue(r == -1, msg="Package %s, version: %s <= %s" % (k[0], v_larger, verstring))
+
 class FetchCheckStatusTest(FetcherTest):
     test_wget_uris = ["https://downloads.yoctoproject.org/releases/sato/sato-engine-0.1.tar.gz",
                       "https://downloads.yoctoproject.org/releases/sato/sato-engine-0.2.tar.gz",
-- 
2.34.1


