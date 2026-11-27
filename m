Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.320.1795797890841077916
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 27 Nov 2026 08:44:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=lFSGU7Ih;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=57916e0de0=mark.asselstine@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARFnKsF1490802
	for <bitbake-devel@lists.openembedded.org>; Fri, 27 Nov 2026 08:44:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=mRXxiMZCF
	7q1hK3L6wxIm5tzr+mQ8HWa0nzBGenGLYc=; b=lFSGU7IhvxKS0bvPKUqU5zqVf
	XYYcB9zUC+QQ4y3r6Ib+2l6jLIgPUZo/XL4VO36VfyiZ1s2r+o0BOov9UFMH1/Rf
	7+inkHpYjME7vbKvrRMNLKVqeQf9MQ+PtEktXMnfa1q6TgHASIZabKh/+fATa2Mp
	plDUoc7lxho7s0HG8vppa9FYouG8ZpKxGpG/9l8gC7lvap84X1Pmwf2a8QPcGE4G
	ROhLE4Fv/rdCTT25Kmzny/+ursa04WDjVxgA8gNGx/7I6h3fIPAReL7a+Qu1n+kQ
	1rhZmIDT4LU4ymB/AlH+cUYIO3yI+DbwiLS87eAkueoW9ITwfE3XWFIWWe4iA==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11021078.outbound.protection.outlook.com [52.101.57.78])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4j516x0fye-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 08:44:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qkR1jO3DgoQUEm1GydTnfeXzHOR8HAJINiCj5/dAV2jwCLlXQdeI8uwAedXKE98dT8MbDFX93vn7pHmwNSbaBTHXorEPvf4u32G+xMEXf/vgUjP+zdtLhBE2HpVyBliDqvJCtPTbp1WIE1ogNTW6qNulV44/ZRzA/mzHOedQym9g/NQ03oSbi1c97U1mb0PrXYiBeAzcKgjVD8krSBouiynvBF90f6zlq/qAbqQQfPw76K06boUiWjP8PoY4Ao2MUHMRbW9sefmOTXKw+eKY+XQ4v5N1paYM4+EBAjoQ0jdXng7OLnu2tZaq8/4PzpoPypZoBbFCDTG67HzZCm8GeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mRXxiMZCF7q1hK3L6wxIm5tzr+mQ8HWa0nzBGenGLYc=;
 b=n3lEHmkgg1a2tWq017pluTeED1HeHzcZ9YnaUd0wGkHuVB/dqLEOx6IVqQFuxZvLQe31LHLRiLiOuBIju5wICJKJfrIFaXOPPyYOM9mWpqKjoaU6cxsEGGPlmBmEfefUEMm7XT3NkDbbvV08zpGYdA0YJk/udMfkftAzPl/rgIAIPFDB9AmnxUHiSZG2geKskbRe7j7PYKCEAy/gZTgviMPSohZ7bsqsx0uxlwZw6JJRBIrF9qoVrCKroHoOPjZDJPa9mwHgRUMvUu0bYcRv9D2Tqs9b9OcUfNLpS2o+itrwJIGEFAtjw7sisU9hqU9AFsI5Gx2zp6v7mtBhjb2alQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=windriver.com;
Received: from CH3PR11MB7865.namprd11.prod.outlook.com (2603:10b6:610:128::10)
 by CY8PR11MB7243.namprd11.prod.outlook.com (2603:10b6:930:96::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Fri, 27 Nov
 2026 16:44:46 +0000
Received: from CH3PR11MB7865.namprd11.prod.outlook.com
 ([fe80::fc04:e93b:a64a:199e]) by CH3PR11MB7865.namprd11.prod.outlook.com
 ([fe80::fc04:e93b:a64a:199e%5]) with mapi id 15.21.0662.007; Fri, 27 Nov 2026
 16:44:46 +0000
From: Mark Asselstine <mark.asselstine@windriver.com>
To: bitbake-devel@lists.openembedded.org
Cc: jester@theyoctojester.info
Subject: [PATCH] providers: Select highest matching version for PREFERRED_VERSION
Date: Fri, 27 Nov 2026 11:44:35 -0500
Message-ID: <20261127164435.10701-1-mark.asselstine@windriver.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0091.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::27) To CH3PR11MB7865.namprd11.prod.outlook.com
 (2603:10b6:610:128::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB7865:EE_|CY8PR11MB7243:EE_
X-MS-Office365-Filtering-Correlation-Id: 58586d23-0b13-4d9d-1ba1-08df4ca5be90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|376014|52116014|366016|10070799003|18002099003|11063799006|56012099006|261022105027099003|261021123027099003|261026140227099003|261021121427099003|261028144727099003|261026121527099003|10067099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: Tc3u3e6p3FjO//RzvI9uu1xofH5gjNZNykU/PhqosS/Q3PKY+ctgYPOE2xLX110t0yTmudBUI8FlosAUUHJcgWQC3iu3o6iM0v3K6VIRFgAwdJrl3iucdCkiJrmQ+vd+by1KAS5xYHUQqXSQ2Xc/XgELPjKzTiYgrrBKQ4E7XkgLNA/TTeMGBpq+NPFzAeAKZPn9gPFrtL/Q+TYxfOqwOHxuBBmDsELsUBd3Ovx/KeOHz3LJPd8u7jnCRUHdKsE06G6ZYYDB3Pw2OPZ1Mylap+UmlohJcbg6Iupq+TdQn7FUht4GeyEQIVrzQGZiQh6Rgjt+YIsqCww0QjqeV2Uq8GGGILBRN/zQXhT/Pf8JW54GVbKjtYoRET3lUwAHiT8NxbsI4Ibh0kdzWDC7AovktX6kWHWVm9va5DkFqNfjsYmiSeFZRgzZjUXvDqNOpQiK5eBfN/N1mwIrZLw1TB6eoBONJ5M6d53DaC8/xBx2eBv/aOBMm1bnkhj2VspDPOf3nV502EPMG706zdLLIWm9GMzYS47yUXiwE/rBVfneewAkq4erOy5RGuG/gYjIgo9wtJLKr/y3y6TiZWxvOdcvxh5QVy/QoQF1fWzQ4HLqWive0/9VB6RBa13sCVC8FLnTZ+Zmc0nZ9F4hZTOfowoW9McVeSM6l5qpZSHmF2hgr84=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB7865.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(52116014)(366016)(10070799003)(18002099003)(11063799006)(56012099006)(261022105027099003)(261021123027099003)(261026140227099003)(261021121427099003)(261028144727099003)(261026121527099003)(10067099003)(261102123227099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6ecsj7U1Q3e92QUIHJr8cVhaoDylzGwlCxTE4XJG5aKLwiDbztKonnC6LWBR?=
 =?us-ascii?Q?M+lCaqMr2MYUfh0hmRLdxeqezixlHhQtzXSfkRYQ6J6UfLmhJBKnA9/eiEDs?=
 =?us-ascii?Q?JjsLMNYDdwqmX4ni9YxAkZiHyEClYn0XeMRUXIQhDZuZl1LM7XVfhAHTGbb9?=
 =?us-ascii?Q?onc3301EouCBlV1Vk8E3EwRVw43IpEXKjGBscITSMZhUzxjVussFKfLulvRD?=
 =?us-ascii?Q?VvwI7Ph2glQAPnXMe6HoA4x9YdtsG13rcRK4sjFS4HgOV8vI3Sl52cLxrmq1?=
 =?us-ascii?Q?1kAtCXJLfndLDX+b+f0jk5HAHl3RGNHEO3aGF7q6xaIZkr4jEOqmeW81i/NP?=
 =?us-ascii?Q?g5hxg0UQaYaHzKV2hK/BqENFmH4rhAJVrwdAXzjpp+eemPojlUXB2tUGdiRD?=
 =?us-ascii?Q?yWakxu3OeoNLyNxCBtUfPmAFLbljbZ+lH02c0JQkt5ORBSGfD6EC2Fwi/kfE?=
 =?us-ascii?Q?4TztQ2bS3p4KfF//p65QmAJTtIGsbY1uRndbe7XDsMM/IpkUeakUCoc34QF0?=
 =?us-ascii?Q?SjqDk2rtH+TsCn8bilaUFu3nFu7Zrgf0qzewnSKffT6HtxyKfQBSYCsM9kmn?=
 =?us-ascii?Q?HTeefUUkVyxrWTg5rLrkUw+AdDMA/KwoEQu0ygaKZHmFd0XoQ1IhL+/Hkyoe?=
 =?us-ascii?Q?584axQNLrHAM078d6kLtWf2RhHkXgPemZpSyEAyNpK0CvbTIdCh38T1kq0jp?=
 =?us-ascii?Q?OtVchAror5ACcbNKxtHxCT/cUS9Gt3dhTXoTIVlbRfCBb667vCAB0PZBi1tt?=
 =?us-ascii?Q?ABoMbotzJSIqKclFCHEbt35HKXETcUO1tOphNfvjSkRSWtq8e4FMJ6Yo7pIk?=
 =?us-ascii?Q?er+/nT3UffZSS0yg3yAvJ8LNdY0BAl14+30t6H9uUukhk83pCbVPdrRWBUPH?=
 =?us-ascii?Q?+V+xHdhMytct8/qb4LhPQ+ugkUz2SWIlAoZCnR++KSuQFPQfAXm6FuNkblIQ?=
 =?us-ascii?Q?VzRON8kWtgL9Yz4XQfbNGXfvZWnFDbgMB/NPZ0F8nU8Qgn9st8yEpQGY62GY?=
 =?us-ascii?Q?86qTjDDYWKSZ4PNAAQDe8Dr8FOVCv6ZIESLbsVpgiRuLyfhNNLuTpmv+iU/u?=
 =?us-ascii?Q?dXktwiYxM2JMhgMWSh0yDn+pgr8+JhRQPdKCvUKUG/VU8vtRafdY1nFM5iSC?=
 =?us-ascii?Q?zgeguR4/PH4opESjwTy2eqYlAq7TCvcuXe+qSOp/vhqGSEV1BKdjJL/YTxp4?=
 =?us-ascii?Q?p4iu6O+/BLSiZhgtSqN1sQgI0K9WoK2JnhJ+WHKaSIkbTEW4tAN5hNGKBRTc?=
 =?us-ascii?Q?hiv9/uG9wNFi/FE7pRgXEIKng4h6h12TmmwTeRn+qz3NVlng8ryCmxcKHhBT?=
 =?us-ascii?Q?p8yxDJKMlHSS54+9zAZVb+eqBIPgKsGrB3CIh0VdMUoJdPXPSMMD8YOJdr9O?=
 =?us-ascii?Q?pN5emAWuINssSzdq0C4HjwCrxwdBXwehOQawoZPzv3C0wkcYLYWn+GFzhxYg?=
 =?us-ascii?Q?SqlmTkIWOYHDuXD6wcD6LEPV2TAgBkAZ6o2KVPxSWeIw3nALPiOmvX4qE8ZX?=
 =?us-ascii?Q?ltGd7vZI0XeY4yGqj7dj5OwwQdcMwPJNHUnOjzpYiQizk5AWxz83EHIUxPgG?=
 =?us-ascii?Q?Cw04AGcBYrtsSDZN4rIXu3eDKHFVL1b3D06aGuu/LmW4YDxri17eMepd8rSw?=
 =?us-ascii?Q?v3eFnUF/B9AhJSM0rUiiNO3eLxPfU+LeRLm8/BXFVh2GWWU+qVKmolt8dnbQ?=
 =?us-ascii?Q?v8nY2wSNqGSsId83aWuLBTrtq4QbvSkBQwVsTLdaoMV/dDXt1vMMsL2WKn+D?=
 =?us-ascii?Q?qoIKIxFZOaSEHX5qFNdUtcR7C68on1FMnqtXkbOXH0XxMxAK1FYCjE26RNHM?=
X-MS-Exchange-AntiSpam-MessageData-1: KwaXNPSYF3UbTWIOyjgDx/fz004KuNtwj5g=
X-Exchange-RoutingPolicyChecked: OLf3klcziL5OEQJyOllcEjWKXEwB3PJt25nHLwDP82Ix1X5+OPCrUG/q3fFFKgWzdmGCkbNaasvu17TYKzMa6udaK3/FCCrWrqA73pSMpAHpcBjEnIeIjSdf3Enq/bQ41F1JV9EKm0wcBwJoQq+mqrcY8wgYUVODvpJW3t5cSqAZV/kh7lreihC9elwrUrELOHpoi5JIjBilsOZ4B0gu/v7QNP2IwA8StQRPTmuoJN9nHU8nsErF033dsqOyClMyJIqqjqxBM6EC4cXnvzjYC6Q3BNOc6VZesscPrS1lL3MEizqgs/h9yNqp6getWIFI4zSaaegrfzfltPcxDggt9g==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58586d23-0b13-4d9d-1ba1-08df4ca5be90
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB7865.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 16:44:46.2353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SXQptCLLDKHFQ/knkaIQc/9RzWONDP3WrB80/Uo46suS14Bf5jyhOLHReT+roMIXNmbhvQhQbYWQQiVdMwaXz2oL/z1cbNR5MtAxJGtjr8s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7243
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: ByeW3izGs6xKnL5efjRRKVzewP0w7aUm
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA2NiBTYWx0ZWRfX1JfC6TxKH11S
 mg8RkIxvZZgC2gALku3CvzRx97PvMENGRLBKM4iNqs2CZL5uzNdffhV0fD318S4+NGF3VGu81Vg
 FKoxwArfkzHTKHpyfCy3NnRTuP8GFwfRPoIg/RyfVbSSyEWdlx3o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA2NiBTYWx0ZWRfXyJN7YWrgzgN+
 z3/o51km0i5nrNseF49/7Vu60+cM5FRR86csdLLKpeEjQ1tZ3TatIIIeh8/W/CWAK53Fq70Hh3U
 wL7hJVMw09XyF04/OspClQ8zkF6yatQGE1vRC8PY9hmERWbCXR5E9d8oqhfoHmEYWQueeqpENJD
 sIu1C2IqMj5z8cWN+FEM0+A2SAbIx2yG9JzjL3cugX2XNipR5/6m/r29/taAnIwDMTbbiUU/ZCV
 PW3hZd/6FNuvrM/vGamt513UD+9pf/XshttWYu7L/PaSuMvFIp06UrFD3ZProkR0qWXwbT/01yH
 YnWWDh20l7Cv2dIIqCLSRwyQawzvaU6H5ISf+Zf1mxJ2W9CuIRVlcYcS9w105PuawTsD4p4VZl9
 dIs31V8+GoCMy0GYrE4gs8rQ6gq5MeCPrMRe/R5eIMYnPQK+/mZGEHHnigUZd7oBir2jRorJKVu
 j+uQvF9fbylZBdBwFew==
X-Authority-Analysis: v=2.4 cv=bofZl0ai c=1 sm=1 tr=0 ts=6b09b382 cx=c_pps
 a=sajROsZvL5DJSFuOmYePsA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22 a=KcgObo0KAAAA:8
 a=t7CeM3EgAAAA:8 a=QFAbElRdFsFEZ5-EBbcA:9 a=T2qA78Jrv2jgDEe_9V3b:22
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: Q2HtAl6MtHkJOtIXVLT5woyDMevuqaPb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_03,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270066
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Fri, 27 Nov 2026 16:44:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20478
Content-Type: text/plain; charset="utf-8"

When PREFERRED_VERSION or REQUIRED_VERSION uses a '%' wildcard,
findPreferredProvider() stopped at the first matching file in the
list. Files within a priority set are not sorted by version, so the
result depended on file order. For example, with
PREFERRED_VERSION_blah = "4.%" and the recipes blah_4.0.bb,
blah_4.0.1.bb and blah_4.1.bb, blah_4.0.1.bb was selected instead of
blah_4.1.bb.

Check every matching file in the set and keep the highest one,
compared with utils.vercmp(), as findLatestProvider() does. The
first priority set that contains a match still wins, so layer
priority and DEFAULT_PREFERENCE continue to take precedence over
version. Exact version matches are unaffected.

Fixes [YOCTO #15967]

AI-Generated: Kiro (Claude Opus 5.5)
CC: Josef Holzmayr <jester@theyoctojester.info>
Signed-off-by: Mark Asselstine <mark.asselstine@windriver.com>
---
 lib/bb/providers.py | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/lib/bb/providers.py b/lib/bb/providers.py
index e11a4637d..51f61b6e1 100644
--- a/lib/bb/providers.py
+++ b/lib/bb/providers.py
@@ -160,9 +160,10 @@ def findPreferredProvider(pn, cfgData, dataCache, pkg_pn = None, item = None):
             for f in file_set:
                 pe, pv, pr = dataCache.pkg_pepvpr[f]
                 if preferredVersionMatch(pe, pv, pr, preferred_e, preferred_v, preferred_r):
-                    preferred_file = f
-                    preferred_ver = (pe, pv, pr)
-                    break
+                    # Several files may match (e.g. with a '%' wildcard), keep the highest version
+                    if preferred_file is None or utils.vercmp(preferred_ver, (pe, pv, pr)) < 0:
+                        preferred_file = f
+                        preferred_ver = (pe, pv, pr)
             if preferred_file:
                 break;
         if preferred_r:
-- 
2.43.0

