Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BFAECF3181
	for <webhook@archiver.kernel.org>; Wed, 19 Nov 2025 09:01:15 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2651.1763542872091803080
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 19 Nov 2025 01:01:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=lEOgVX1g;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=3418bbb192=qi.chen@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AJ802SL4105773
	for <bitbake-devel@lists.openembedded.org>; Wed, 19 Nov 2025 09:01:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=Yc/IRZAUqO3Uc+LcGkasWxMVC7sO/dMReBBefzlI/1Q=; b=
	lEOgVX1gwTzyfo5F9iozZSsV/e3GH/6spCJ6QUrrSnmcr/pFlkMZMZPI6k6oIeAN
	Ku35xFY7uDWTp9GPYzf2bpbVKAcCvyclSFdrMhck80zXh9ogLIWJy4LlFT1YBI4C
	LelMg3zRR1VQ2dOHlF0qPVwnQ1Xov4KBpAAPfafuUwCO0dqdlsXBB70tXDa5T4HS
	gBhGx7tFzuAPGGoictytbnDt+S4hy/mx5sNw+Y+Zisq6QK8OYmu0OmUOv04WYfTY
	huwVDqO0eR2TJp+9I1L6dOkhJtX/ORHOhAumHwQDv7qU39c4T+61a5/8krT06HvE
	EZ/xj4pdT3TT25fKq96mSQ==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012050.outbound.protection.outlook.com [52.101.53.50])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4aeeqwmuhg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 19 Nov 2025 09:01:09 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rCde6i+Wkpaxe0zxjl1qGJaml6FOtdW40paJumXPaIq/e6bYrahow1RVGqQGQYSlKrQ52+AOmh6EnQWQfinOKG4quuHBH4eSUr9oaGbDadO23U5B7sMt5qjd4kbReE6r01XO1SxSFm8QPJ53yeUqUGb34PpAtoHtP2WcRDcyPap13NWbzLKv643uswwa4VSORqznqPjvVk+t9V2oqTz1hgG9Bk0Nv+89g2IdqCNSNVMcnhtUpX2Kjd9Zf/dSzsD5PDHVljLW9ORuIioOyeXDhmTRm4hun+10z/F4iUEZ8YWjNfU4RtykzeHrEgHtAAwzx10HSaVR56iTgZ2Mf8RhXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yc/IRZAUqO3Uc+LcGkasWxMVC7sO/dMReBBefzlI/1Q=;
 b=gRKPzSiDu9/Nm4jpmZEab1dkoXbpzi56l6f5N1qxN9R0lV+X9G6SOljQAXAoI++ESeZnwcia31PoemRNVCDO47Wp/sW1hI98czyeU1NR/STc+8oXAxTsMMVzfVz8wjutUiR/ILaGHZUjGwx0PKu8aRVcCjCtvBfArSHwpYTuRPsZtPfgK63FGQkXwdbUK9+UO7Gz1UQtN8Rid1uLRAqvhAAQlOKY9oBXyPmZZm6zv/XF1flFvpZf0RjmdTmC8s1uhFUzdZPNzSkc1V5RLps4+qFiX+cRqYo7KStKaYN3VFNFGYA6lnT1qUdx8s/BI4yJqT/v4Ks33PzCvYX/qW3y/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by DS7PR11MB7740.namprd11.prod.outlook.com (2603:10b6:8:e0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Wed, 19 Nov
 2025 09:01:07 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%4]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 09:01:07 +0000
From: Qi.Chen@windriver.com
To: bitbake-devel@lists.openembedded.org
Cc: alex.kanavin@gmail.com, richard.purdie@linuxfoundation.org,
        qi.chen@windriver.com
Subject: [bitbake-devel][PATCH V3 2/2] lib/bb/parse/ast.py: error out for internal fragment in case of a previous value
Date: Wed, 19 Nov 2025 17:00:45 +0800
Message-Id: <20251119090045.107642-2-Qi.Chen@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251119090045.107642-1-Qi.Chen@windriver.com>
References: <20251119090045.107642-1-Qi.Chen@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0357.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:7c::15) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|DS7PR11MB7740:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a1f0d13-4c61-4c90-3709-08de274a2ca8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|52116014|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?nG9jTiV5Dz7R8BPt/55H0+8mW29sO94ZbDiUEaCaPFa8SiaNFLY09nOzz0gp?=
 =?us-ascii?Q?hRWd91S5CwEZZiwyDX/nbvNsvCNKZMpFLXFuQ+VPYWUvaZQsgfOcTRmLwlJh?=
 =?us-ascii?Q?XpaDgehs4Vef1tN6JpmfzGqdMUw4Knh13Wpeti0meVsPSoe47HeseiOGS/vY?=
 =?us-ascii?Q?fkdRqAPlaxHRsPtAcsBJzGncForQHZytwbJTnW56y3B5yhIDPCE8pbgwb9kt?=
 =?us-ascii?Q?oO/BEXAGQ3JOJGlOM74gT93hEvRBPviUqSidDxLzsZ+jh7l0O6Hx6T/4PRAu?=
 =?us-ascii?Q?XrsHy91KpS7CnWVbL9b4CZg8byGvdGEpDwzbUvsBMcEHbzKvExr3DldOCuJY?=
 =?us-ascii?Q?rk+NNDyEPq+l3qPa32LHUitngO5uTNVyFQWs6iioRBCXthbVomoyBV26TLkG?=
 =?us-ascii?Q?1yoqddEm+J5rnwUoyM2XmfcrjJ/RKf4kAMV5LJ8STXAqbm95Y/AssfH/AOO1?=
 =?us-ascii?Q?ESU3GirAXY5Pgc17klJMYCjLZH9+6aL33M/CKmpqb+PDdEk8FZAA9VWdBNQf?=
 =?us-ascii?Q?dS7N53o/vBnI4awN4Qcfo5U+x9OmLwtRxbVwFGMq0/Q8Y8/OQOrWbp0CkjDt?=
 =?us-ascii?Q?M+IIT85r0Nf7IRQY+rcwDmQUmntOOgscqE+W6quKTS1dg+dgPm9FRDmaRSED?=
 =?us-ascii?Q?eqGey3pfGHPIFjmxSzlSlPkz8WyxDwx/iI97BwD4YJKxwnZFCbVJoGtUPavr?=
 =?us-ascii?Q?GOTjCVSIrqVwaZl6CmCCZEiYFJTs6cfuUB223H2zZ1KLcMIIe8x0sX1SwbLN?=
 =?us-ascii?Q?eKgW0emGz9EVrAiLkT33qZ+PuaTV3ykqJmk+jI/j27dT81u+APWAwnr+llgD?=
 =?us-ascii?Q?yck4Gg+YhynPtgwHUnnN8X8Mypfl7uegj0S3LImv6DBM2fE2xZfwYyfYpJEN?=
 =?us-ascii?Q?KEhbYWBZ55Fw/UTX2OWHXdscyyD4nnlNh+h/7TH3bxefsE4iswSvrc3XByuB?=
 =?us-ascii?Q?jN6syu0oyf4Dy4hLUAiO9mZJXU3tFq1U/TfON7EpHWcJWatMAaLUzH0hB1Cy?=
 =?us-ascii?Q?p75+ZfsHlwKNb6BiYysbgi+n+xz7MF5x8em/YHVXaKgHkaBE2po2mBC/zExp?=
 =?us-ascii?Q?88rg64dwFcGVSMLco7R9mHqZRNciHE31ODHL1EDyQi0H7OgsLj9umvRVl9TL?=
 =?us-ascii?Q?ChzM9z8Ga3MD1kqQ8K1JcghyBhxxeC5ET1odsoNyBVrJYanqhkNVs6kuMl6V?=
 =?us-ascii?Q?rRK2UMpBanCsWDv7KR3WvNrZoSSsMxz47X5un0hI4aUx7KLRs3Kt/sV2lVjE?=
 =?us-ascii?Q?pEVBcL2LPpm81EkzXe8gKZic8uUY1WeKt89+VwctD36k7AUUdWHBWkIzTs7a?=
 =?us-ascii?Q?U5IYXz2wcyuWetLm7qWzYAZayaB9q9tcZyKCBClnNyRHY7kIwtfose0DykLr?=
 =?us-ascii?Q?+29IN6Cf9HmvSvIyjT2qIVd+qYKYauTzKbi5SGkR+OdieHlAG1rqRVpHoTs9?=
 =?us-ascii?Q?/dhICnlqczvvod+P8rkfM/RkEKKp9KEQ671dNRTlAfcnTaGua420rRDf5Jdx?=
 =?us-ascii?Q?8nx51jyOcKS1Q/lqZz0ZslOwvsMlWdEDhOtf?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ZmsueU/fgdDthY9wJW1k+FopTHrtATsITPHowylqof21KnCoLLk3TAo0JnrM?=
 =?us-ascii?Q?DVCnc5Ty6JBYggyCCcr7qwVmqMNZ/EZibzZeMsRR7QQ1tOiK5Eu9oRptGXOT?=
 =?us-ascii?Q?dnny+gQq75eAzRmkC3epNyMkQ5TUWGYaziMXVs/iA+z4hBWXXirtIyFZB//T?=
 =?us-ascii?Q?RneymVOWjXX7x2IaBPVRKdtps9kvMbBMvVCJE0g20dDJSO6gdgf93aMCYnMO?=
 =?us-ascii?Q?xqli4gzKAc849ofYtXNXF5/+nn2Thmz6RRM69RuujpXg7cAgg/LIMUujpG/3?=
 =?us-ascii?Q?wEF7klPZGl38b9vu3qNAN35ucLZUR+nNYpNYMby7DZM+vt14UjN3wOdo1UXe?=
 =?us-ascii?Q?tfFO3cFvffRMdTGyj5cS+yYVQlGGPxKeS569emG4DfD4BWryDf7hTpZgfuQq?=
 =?us-ascii?Q?EIVmd0jhEX0gJHJKtO23GzAjVwyBbg4topT7cYQY3TIY0m84zmPqpwk0nMmA?=
 =?us-ascii?Q?bofXpYIVyxLM5uX2RAI08s+wvxfs6TqqG20m5UYFFqwczI1Fbl4dkZrMYSTV?=
 =?us-ascii?Q?PkHEfmQtSlq8R2RTZBWT/OjO8I+/dodSW3t9xoLn+MgKX+K2rxaqIKwup1YH?=
 =?us-ascii?Q?Ni3gH3cgEEj2FfEcZ1XKE6q/iL61L9cOpAk7yDJL6YGSPVbcP8D9MbmOvhbV?=
 =?us-ascii?Q?7SAFa8iqdO5BhO6rM3Ah9zqCq4N7HxzsAJEL6ah+S10HBgYYH5f91NUn0niB?=
 =?us-ascii?Q?RfLRN0OOFyhQR6L38Se3XCXMWRsk7Xw87NbRTDcSujCTyodIkojqwZRxfwNN?=
 =?us-ascii?Q?1pvOLfmLoIKK/G83BSsOgD3L3vdyvzMUTMBUgOxQoAhcS5nrdCGqZA/5xxLX?=
 =?us-ascii?Q?AsFJ1A6eEL133B/EjXkAA+oMDoG8GXZAh5z+VK33YSt2c5DMxrmRc5hZgceX?=
 =?us-ascii?Q?zgG5+Vd7/lqAC2yvTSJMA31aXts0XsifRviVkZMI0nd96suL2g9chlHPSSkK?=
 =?us-ascii?Q?j2pgUg73zOf7jrSH2eT2N/jvEnaLTQ42XwiN9hm3mgSnTWXMCTIbBCdj/zl/?=
 =?us-ascii?Q?ggy8M9/nWNRszU15dDPI+jfOwJOzkejqcSxSCITKJxcTTOVs7bxKvpl6RfvA?=
 =?us-ascii?Q?V0q9HtgWqBcK6Zg6fFFUlOs0l/Dq3kIY41cgXHhTIiPy+JY0UByMD5stTpGR?=
 =?us-ascii?Q?dUaxJ8tSEDmxm78P9U2U75p94bmgBqMdMATzFIsJYJ+H1D1VZ1UMhRHCnnBZ?=
 =?us-ascii?Q?FLyOrPQXtUJqDH0Tl6t1IqFF9KzWQy/V1ZRWq3FqCze50cJ84IuWUtCXO/Bd?=
 =?us-ascii?Q?SQKgC9TlBAI0QYDcm3dnHuYVmRVPJL/tD188kvufJO5hrrDFBpo53l/HsKVA?=
 =?us-ascii?Q?NRwcf52FEo6hOiZP88IJscU1Hb5MLlsSj4T2qLmvgorx9P1ufyY/cAG7oJPs?=
 =?us-ascii?Q?E1wQZoMOdLB9inGu2HRrakQv3gog+dEdzYLFx3eZ+8Dwu4MS4H5r1utBHY5R?=
 =?us-ascii?Q?A26fad+JBRTy8HkSfYdIRw39qQola1tlZXre7TpGp2iHvEL/4dg5bz/2iTva?=
 =?us-ascii?Q?QKp+wf5BKTEE1PbtnON5vDTUJfO/Fl1huaSsnNDNseU7V9rhfbmfhtez0N7o?=
 =?us-ascii?Q?FgdCQe26+TX7uiW4DtrkM0rTVYoz3wKZ3SdsENPQ?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a1f0d13-4c61-4c90-3709-08de274a2ca8
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 09:01:07.2443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GTQKkdk4T2hRrtU/054gBgLm+r3n7reuPv4y1vHS/5Qyso3nxr7qTqLZmmwem08JkIZPO8X54b0QEoV4izoJ5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7740
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE5MDA3MCBTYWx0ZWRfX3iVB+r/h9u+e
 /BqA/sPzxIGAPHGj6jFDd1+JppYlfbzacTbsSGLT2ADX0zM+zgfdIZ07GeT39tEyJ7b+u63/kfq
 eS0zRqZAezxAnaLtIMp9eLkmsaucCnIW0CB6TMSW8ic24eiEgyR+H2knEOxc1LkAOASvysE6U5R
 K62NkjPS9QWWUue6DtQHBeH0fCZOfn1MxtiwdFs7HCMmOYOdWUFEo7C0nHUSQ9wtxbE5CUDFycN
 iVFgENpxx5rqvJ004F9f6ZNm4iJfAD1TPLkVazOPRvm85gwnQt+H7yVpHkGAjHdI1mBnNCg4zWI
 cMCS4IGtlFbmNbkfa9FWeUvHgnom7ilxub6pu54g93op3b8bD9ULqEaIYH7c7ZcBsZRI6+K9m+x
 8VIdmJ6/DJ4YDSIZPCZuTkL9KzpnHQ==
X-Proofpoint-GUID: M0Qk_HYl2QPjPm9q1Q5Qn92mLYNvda9O
X-Authority-Analysis: v=2.4 cv=OuxCCi/t c=1 sm=1 tr=0 ts=691d8755 cx=c_pps
 a=Jpon84a9jUr9T0N/wBB0/Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=HvlrrJGs30CXpD3u:21 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=t7CeM3EgAAAA:8 a=Iho6WsmrSGtPT8d2sCIA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: 4Y9F1GVbEsG-vghE8buQkjLCPmSqlDKu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_02,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511190070
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 19 Nov 2025 09:01:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18450

From: Chen Qi <Qi.Chen@windriver.com>

When an internal fragment is enabled, and there's already a value
for the corresponding variable, we should error out to avoid any
confusion.

For example, when 'machine/qemux86-64' fragement is enabled, and
we get some "MACHINE = xxx" in local.conf or env, we should error
out and recomment users to use 'bitbake-config-build disable-fragment'.

We should be tolerating '??=' assignments. For example, DISTRO defaults
to "nodistro" in oe-core layer, and when 'distro/poky" fragment is enabled,
there should be no confusion.

Fixes [YOCTO #16060]

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 lib/bb/parse/ast.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
index bf9bd4f55..00e3615e6 100644
--- a/lib/bb/parse/ast.py
+++ b/lib/bb/parse/ast.py
@@ -367,6 +367,12 @@ class AddFragmentsNode(AstNode):
         def check_and_set_builtin_fragment(fragment, data, builtin_fragments):
             prefix, value = fragment.split('/', 1)
             if prefix in builtin_fragments.keys():
+                if data.getVar(builtin_fragments[prefix], noweakdefault=True) != None:
+                    bb.fatal(
+                        ("A builtin fragment '%s' is used while %s has already got an assignment.\n"
+                         "Please either disable the fragment or remove the value assignment.\n"
+                         "To disable the fragment, use 'bitbake-config-build disable-fragment %s'."
+                         ) % (fragment, builtin_fragments[prefix], fragment))
                 fragment_history = data.varhistory.variable(self.fragments_variable)
                 loginfo={}
                 for fh in fragment_history[::-1]:
-- 
2.34.1


