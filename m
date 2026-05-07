Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 397CACD3445
	for <webhook@archiver.kernel.org>; Thu,  7 May 2026 06:19:13 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5949.1778134749448616166
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 06 May 2026 23:19:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=VOpiK9Yf;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=9587885fd3=qi.chen@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6475xv6u3336311
	for <bitbake-devel@lists.openembedded.org>; Wed, 6 May 2026 23:19:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=4GYnbJYsN
	u6tMakLuSMeRYquElI8go5B0OurvZ2Qqmw=; b=VOpiK9YfMs/GqLlXjry0rNoLD
	hua22iOX+d/aVrn42xvhX3bu98vfImNZKNfnO7x84iX2FtwNvZTOW+zW7y14ad+J
	Og+nPxxwpQc0bmMk2wVoJC1vmziHam8YLZBJiQ/o0fQJ0nV63r9Vb06uO6j6rlZM
	x6h3x+VerVqvi2+9BbtkT5aCyjpAa/useudf+TqcCFzdoVHhrWlf1tweb3rx9vDZ
	k9TRCSsfHArJTb8ORyRW/T35uHa+F2s1bhkSQurTfmLegLy2au7R1sIQwkhgfQdC
	q5h6hoVGDKRixWnygTvoqR9zdbNccTwYQYP6eGBsPDElnXQDk1pxK00EwF9dw==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011070.outbound.protection.outlook.com [52.101.62.70])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4dwchywwm9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 06 May 2026 23:19:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LUcn7AbIcJxGB45SHesCmaesMYb4J956jDFvtJnQVIqgRBzJkRFNAmVG9MhSifKkNXlhs2a0pVAnXXNyxuq9cx53KRLW5ngnBQzzLHeDqG7bHTlktjOtxGtTjDlDq5Z2z6bqijRPkflLFfkWIU5fnByX0J//18b6P9pL9GdsjW3XcQJN5AOFpd8IAEqYBC+PCSQ+2Dg6jxtmf1X+8TKeGLxGaoPgjwcUp01YEuYNdI5gaaNlR+TO87KZzkv0r298itxMD58AcpNzZQQa8dM8SiUR+12v+RYoeeyupBoTTaUvE7p/TSaN8qxCy4D4gH55vZIZ13WCqaHiRk7//kJ73Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4GYnbJYsNu6tMakLuSMeRYquElI8go5B0OurvZ2Qqmw=;
 b=kbd0XduOKvfGwkbggq495aJtBnJK0yBj4MDrh9XMbIAr08LuJIGs2PGQxgpV/5bUAnzhYxsNd+5kVwmdF+Brne2yRX3Gqy/xseYsrmXzjmT6at3YziaLe03yX2UvZz5UAeblOkd1OTFDc3xsRODRUE9RIgRPp5NbzdCQ8OjoPoE59nx59pzIwh4iThBat05Kcok0i9+BC9iNwflWwbgihBxUvxObrPT7ur6KHdj2hNr/6z5NPoVyD3bvtMOpsKJzjPljphEThfgBHpAB5GqfOeSK1eAulsuCFrdkIhEA9JnBUGE0Ldu1lkoHM+X8ijarcVbuXu1+HfUcVlotP7Xe/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by PH3PPF383C22AA3.namprd11.prod.outlook.com (2603:10b6:518:1::d17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 06:19:05 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%3]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 06:19:04 +0000
From: Qi.Chen@windriver.com
To: bitbake-devel@lists.openembedded.org
Cc: alex.kanavin@gmail.com, randy.macleod@windriver.com
Subject: [bitbake-devel][PATCH V2 1/5] fetch2/git.py: add filter_regex parameter to latest_versionstring
Date: Thu,  7 May 2026 14:18:41 +0800
Message-Id: <20260507061845.1460893-1-Qi.Chen@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0217.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:18::22) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|PH3PPF383C22AA3:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e145803-0381-4e75-2d88-08deac0089b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014|3023799003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 
	JLuG9kjP4MywB5VFR4ccrZ66B/WRNm6q19KwYai+8ocyzQDp0QRbajrVWqexSA3+pDbZBsPwF7/eNb73BkmPWXSrp7mleAUsjAtnLs95Vt8O4a3suGBrvJtfiiH2YUKHIo32+oxWviT02TuU9TkuRaJVr3ygEZ7wDvl6wYZFnsKAq6HGNPVJjP3h3GUrpbUJY7BrSImUI4PNt/XpHCeiTt9njC8KYM5KBoyUyoRFRbCL9iu02DWuXRYG/sxv7DT6Mz9lQK++S/axn7slC/jYH8SMqcFuX0337pqR7ozsAOnRAXMJhG35Yq3dWzWklX4657zYB1HSOj6+zVFuXqRfg2/+jPoSa2dsjTbH9zuAkcPvKMkFpBS3rjbM1bPSimBYnnm00twa5Ebc7McU8oZZVLP88GDkQCdmyb9cBZO3c9RPdmiYvgOyOVA/atPLq54PTcgISlqLK0I8V/irOHRPOErFa5YnNerlFOCjsodMDdPqJ6T5i0HW+ehle37sWuXt2U3UJ9+M1Q1I99qpK0+eXO76aU+xbu7jIOamhi0Z2kAzfrUbN4krODaRERchYt6Sn+/ItqxjIWn0iMHuUJMbNjc/u4+lAQiYWB2vm0mo0zhnOYt4rpJ+zhHXYGDUYqCE+dFc2mZb2v21PPbnxqpsZpGhCHCEwTCIlZWE7zrUSRHaaZbeGARMjXOuT70FG+PjvLAJzGAE8bGP0aPKVG5QbWeHmrX3cm0x9qkdjELwqSyJCnNsrYAt+7v2/cwkLr07
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014)(3023799003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?RiehaXNERpC83WkTqm+NdFlB9EL2pzr5zxbWiQqUESIURgtQZFXct7jjz3Ji?=
 =?us-ascii?Q?1KecH2FhgE2yhfkekcl4GNGiV8vWdsh/eoAvRj9OE/O7s6ykMvpNIRPocH9/?=
 =?us-ascii?Q?hJopeBCaMr62v8OjzBncTpBxT+70NBOhHQqX6l5TIB+iDCK5CHsWBy+1rHmB?=
 =?us-ascii?Q?h1fn8fAWah8Zgf37HcqylkQM7hKh4oYMQMUcpp2hboX6VUxNgrh735qeISSk?=
 =?us-ascii?Q?uR280YXK+aMK7FN9mICphDaubdLC3JtDRLiyUoV4xmoVwiChxE4xcuy32xy2?=
 =?us-ascii?Q?kOTcslFRPYzPBxpQvfUCCRlBZdz4rng6b78AixuwRmVTvOIrFOfnx2NLnqct?=
 =?us-ascii?Q?c4clYqDehWBL5w+icPxlCmm71l7yLdJy+qJyP401+ItbHrdMeeir9bPib8qm?=
 =?us-ascii?Q?mCpOvA5CdtOd+fxDXwPC7609/2jduRYYUwMqChZpaaq9XGEVMmKP9Cmm0V2v?=
 =?us-ascii?Q?/IlqJt4wMDjsZkVMQ9CTAm6lkVAR7ltCwqXU0IY8gUdTxxgKmJnivotTjcXR?=
 =?us-ascii?Q?5gihHy/N7uOlMiP5rJSkuXcI6O5BQKJAa2X7+yOzC5e3DQ8UZSXVMM68oMLC?=
 =?us-ascii?Q?ztBishVPu1gSt53MKm0aeQigKDSsk13WkuLdeQB1mqmEzcpQ+GawKavOdfmw?=
 =?us-ascii?Q?hyqTh4T5UYX8jneMvssIH7cmJZLRtAUPbtyME3Ct4v76+emWJxQreissg7xj?=
 =?us-ascii?Q?sES5tihJ5/YFTqk+LyYMC77GIXyISQxo4KC+NgmASYNkIh15/RyeXJhaBXu7?=
 =?us-ascii?Q?UBV7TTiGwMaXbsUQILfPyqrdwmBs3/8nOi6PzkpgA4z0INp2l21a04i7Xy/C?=
 =?us-ascii?Q?5SQaMp3V2BeKare38HR5EprLrgqWNDaKvEf7TllwWed9JEe9d3TlqgKe86Ab?=
 =?us-ascii?Q?mL8hrmxHZ+5sQ0cA926RvJCUxV6wexnZaDz9Yi5uK79059mSKi13TgRHkwJu?=
 =?us-ascii?Q?5K2B2HTN6o7FicJhkXIAIcHXoGvmxYc/5jfxFFNjLaufnBMrvh3vv7Ct0rWc?=
 =?us-ascii?Q?jGffbW/Qs18+fLZwkHzfDJrB1F7slWUOBdzqwf5D9/wjcBQ+IGmcrns0UQi9?=
 =?us-ascii?Q?JlXMOOQdoHeyuOD52cLqEp472r4YS4t4OB1dAVG6YQnck2r028Lf1R0coNWi?=
 =?us-ascii?Q?NmHGKHV7rI1pBzVhErf9oDKFWG/sraRb53wqDE8SqQWa6WQReaXyTfCd+tbC?=
 =?us-ascii?Q?/Dt2Pws5pfDfocyvMJn6Cu36CCHck5ugUmCeB0oANxz+Df6wNr5YWLjc885O?=
 =?us-ascii?Q?0RBRwb+7pWtmZpXBnX+b9EBUFEszLx4nTWdiXa+U2vA04YLTpcAAitflIR3h?=
 =?us-ascii?Q?IbKEIJRS7TeHLNjoIYR/bwH4Lq7bCr4LUw0u6cu5ADpiAklhj1JoAMed4H+K?=
 =?us-ascii?Q?nbtRlZKa9fXJftsPfeFbDY5n7H+nZqKnTkKVnD0UlrWDCw1ESXjpWoLVKpOY?=
 =?us-ascii?Q?QlPpFAl2IaZbP4ukg3U/6dtfjA72n7D+BphrHSfD8KrDgkD+mesBIJ7M+yJw?=
 =?us-ascii?Q?n9oVsxd9fVaHjaS9fr290q6TEvctu6WE6ZuqpL6zDnjJPTFQ0tuOaqgwAdkS?=
 =?us-ascii?Q?XBG2naBABcQZuLfyE8kflVCca4cOv+9TiqwsessunH6giPCjrHAcLkRLXZJH?=
 =?us-ascii?Q?tgQ9RQHrICKv+WEtMZU7fBdzOspLKh1Xo20IYBk1zGe/hAOGaas0GcolXgft?=
 =?us-ascii?Q?7sgs7NOhVgeLUR4qAB340BDBmOQxZinMlbx3p2UHCgJCAePiWRlOU6PrAdaQ?=
 =?us-ascii?Q?qUMyEr4+Pg=3D=3D?=
X-Exchange-RoutingPolicyChecked: 
	nZhN18cU36XtKqZA9XZrHvDhxSWJArymeEzGDCJ4pm4u6UhPGBWX3T7HGBwmV+rw3khMoM9uIjKrJR51t1eVkoy3YxH7l5g7gnSLwYWJzlhhLWm7D4pUaVyNcmZCDZ3Jl4jx3UiLygJZUQd360q5iTtJTX647oCxIb8ExwnJY8FQiPnUDxykQSpMNKCclopbq8PzKcx/bMsSj1PImDXeWuO6tv72daUMA4DuTREGDeGzyWmzSXmlufMQm0aiblWcurWsL5LtP8/dAPbKcE0AKPpGk0VgT6QYP53OE9NrIT+dBzdVs3LI6XFHBp/LOOquRjw5iXIl4SicLxltutxi3g==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e145803-0381-4e75-2d88-08deac0089b1
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 06:19:04.5922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zZ1dT1CFwgCRaNqqRPTxz+mJx+pjUocGNVKRgVGWjvnvw7sdPrfGbJekTRScA48mbbLJhiBN5ozmVf05IIlT6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF383C22AA3
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDA1OCBTYWx0ZWRfX3MSbPzRrDhst
 9OPSLkjbFN5quNrKHYwhxMUMt+u4yh47ijyGja3qXS3cF3215CdPciKYVqLh0KYDz/vmUydTxNc
 J8ABWQtFtauIgAu3EVbLLMab5GLzdRRG3IKSpE8RFvcCCoJ2Jej3/YP3ZagOW6n0GKMnsv2/SkS
 KYvYO0QmYTH1zkQ//4mahcTRKGCHB1HzsR4YTW8s1dSGHhMYnh3ByXdFJa1D9i4Tr6lijQQmwbV
 JJPeVujDNU+Ekf8wDYcxPHPjuUUoTucRxG5+7sSl0y2Kzw/98vXnBwj0PlKpu+Pp/C6NQ4mVRkb
 e5LR5lPXJIosbb5MISGhY4900qXKw0QddhLNuaTEP6VeCZlV42cV8SPfG17q+y0ep2CtspeY/ap
 JFJMsksFdUiOp9LVBaXRUHL6yZQly1EdQ1MzYWM60Ix0iJEgv9uuYhTMboP/0EsamnzfeaRVNCD
 d4LPU5AO2LR8w5KNikA==
X-Proofpoint-ORIG-GUID: rP7KKzXE51rHkSx0rjjIn0AffTgMoAMT
X-Authority-Analysis: v=2.4 cv=LsSiDHdc c=1 sm=1 tr=0 ts=69fc2edc cx=c_pps
 a=CrKnoqqb99nOpAJSR4mnrQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22 a=t7CeM3EgAAAA:8
 a=rVcF9mjB7NWXllDnQBEA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: 48gl_PzEasQY0TwwRXDFYNYiXjXDqCvj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0 suspectscore=0
 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070058
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 07 May 2026 06:19:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19451

From: Chen Qi <Qi.Chen@windriver.com>

We want to be able to do stable version upgrade for recipes. For
example, 1.0.0 -> 1.0.1 instead of 1.0.0 -> 1.1.0.

To to this, we need an extra paramter to latest_versionstring
so that we are able to filter out the versions we need. Using regex
has the advantage of adapting to different version schemes.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 lib/bb/fetch2/git.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 10eb63b20..a3a26a46c 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -976,7 +976,7 @@ class Git(FetchMethod):
         raise bb.fetch2.FetchError("Unable to resolve '%s' in upstream git repository in git ls-remote output for %s" % \
             (ud.unresolvedrev, ud.host+ud.path))
 
-    def latest_versionstring(self, ud, d):
+    def latest_versionstring(self, ud, d, filter_regex=None):
         """
         Compute the latest release name like "x.y.x" in "x.y.x+gitHASH"
         by searching through the tags output of ls-remote, comparing
@@ -1016,6 +1016,10 @@ class Git(FetchMethod):
 
             pver = m.group('pver').replace("_", ".")
 
+            if filter_regex:
+                if not re.match(filter_regex, pver):
+                    continue
+
             if verstring and bb.utils.vercmp(("0", pver, ""), ("0", verstring, "")) < 0:
                 continue
 
-- 
2.34.1


