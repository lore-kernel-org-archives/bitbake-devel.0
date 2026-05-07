Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C4B7CD3427
	for <webhook@archiver.kernel.org>; Thu,  7 May 2026 06:19:23 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6077.1778134754502529806
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 06 May 2026 23:19:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=iAXnudti;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=9587885fd3=qi.chen@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6475KpgI3817756
	for <bitbake-devel@lists.openembedded.org>; Wed, 6 May 2026 23:19:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=r44IPJCB3w0cNbc3A6UowOAOk7GCrQKZu5/4ohDoj+I=; b=
	iAXnudtilKlGXvm7kHe2Jwq4mGP8nddO2oKADtl1IJrf9FVK/n+ZZ2zITL1/EI7d
	nQurqioPHFhpZojivmjnG5J2zNzVwS94YImPxQ4sjrrzmUdYaERRIzMwbFDFhwx7
	YSiuNo2AKWWkbSN9X+HMcfhojuY2VBFrQEDThF743PVa9Z26tR8k/MmSjN3rz7ba
	zoyXD6dZzoctdCHzudBGyOg4/lY9q7YDGFSaWlKSIZaJPubhHJA1pGVFHUNU0zme
	u714C5mHlAA5gpans/g5ANHuhuAjLlvwiZMbVEUPpRWAMdOVmhbO5nnSzlV6fjpk
	JLW5w/TcsbV1gCNmAqwOFQ==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011063.outbound.protection.outlook.com [52.101.62.63])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4dwgsddssy-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 06 May 2026 23:19:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aN9FhGGbCLjRQXtheA5637nFauX6jGM6n16OEAmt0vFvi80/2LZYF8dAb2AvvXXVR8iBVPxX/LBz9aBRygw5ZFcZ2J5Fg9UN4pBWY3xhgfeaM81iT2XcInvakrMiPEhZeAHnHnA16eBDoTsIyFDQZz1SOuqBcvTDfbFOBNs3DZBIgZmpNtvAys0U4PH208A81oTyuSnMkG4p/k/8QCiV8GUHupq/EntzRI0XOhC45p6T2fTQ1y2z3p5ptl9sB2FfxcSv5/uD11oQ9/PotaaH927xO63zEAsHlEdSZwDL8GosF6ka0yg0/vlaLd80ZJVNRjE+rTMxgb3xLS5HYyGwLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r44IPJCB3w0cNbc3A6UowOAOk7GCrQKZu5/4ohDoj+I=;
 b=fMtUBGl02ES+BHCWsNkLUUYNSjdot5bKMk3E9EX79OJSBP3/vzGSrwIQ+yuI5dDelF+7JXR10L3SiGd9deJW7EuNIzpHu7wvl6+6pfC1sbbUj6c2LzRH1Cv8Tyqwfws+3fkIDtGU4CKSdxxCkCbK4DCwMjeyJ2vWbuFsA4nZK16JVBqElsYuWk8i6yTCUCRyas/41MDyq8AwexqbKxUUCHQe4oYDTWmFNFwaOeGZAQ2N+XKPxIgz6BmpDPclRaVYPBYfcioJtsMXMiD+FTK5iAtRWn/bj8rqreVWy7XKtpHN/vXxjjegCAocZty4QkW44rFlzwSrD5QxGwddOz1hwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by PH3PPF383C22AA3.namprd11.prod.outlook.com (2603:10b6:518:1::d17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 06:19:11 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%3]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 06:19:11 +0000
From: Qi.Chen@windriver.com
To: bitbake-devel@lists.openembedded.org
Cc: alex.kanavin@gmail.com, randy.macleod@windriver.com
Subject: [bitbake-devel][PATCH V2 4/5] fetch2/__init__.py: add filter_regex to default latest_versionstring
Date: Thu,  7 May 2026 14:18:44 +0800
Message-Id: <20260507061845.1460893-4-Qi.Chen@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260507061845.1460893-1-Qi.Chen@windriver.com>
References: <20260507061845.1460893-1-Qi.Chen@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0217.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:18::22) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|PH3PPF383C22AA3:EE_
X-MS-Office365-Filtering-Correlation-Id: fd39eb7f-20b9-4c43-89f4-08deac008ddb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014|3023799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 
	pmlDmc/uBW5CyN6x0xipVtKLOGENYBBp88p6YsMXm0kOd+4NubrWiKsU8ycLHjDVULMIGtCtVBmYGmLf/HYADQEg/G5LxRXhkgUN7/EQLeqSgqiO7VxjsXOWKErDCLM1fLRVnhFxaBys8Cv+1Bmdzs+eMm9hEv3wcwvUZwmb1dqRmHOGPvePGzeSX+L7fK23qPjeZK5tOGBjAqMCI+HlSVP48jRcUfanM77ER06wUQDE8kSec8a0Fj4qJCiASGcYU/aqk/AgOx4C4J1AFdX1Maa5ip57mYcC6mpFwH+Hp/LhPvB2Yw9d/mRIJzDJz8t1rMTCmlrAIEFiHi2LMZX//xn5ue7UcDV7o6wuI0/gQgzdLyLRX91ljbDCqsOS74hUIM1rRYVGQy+FyFOpWZ40ESocOraag+QL7W+4rDSi7AZqBfhEtQ32hkqDFzGYlz4AFLt8VAD/LLYTcNyzDWEZVj67YrwrXQ/VsdBP9kBhHBtHbpUkVjXHiw9ld6tC69cv2kjpjSurQGJ2B0qIgH2lq7K8a6+BvmYdDujTuFJYfnNTsiJAlNZOv8AGIRYcBdUhvo8WLbkQSM6STySdIB+73r4vVWbDGDAaSR6lHOLDykl0rEfqiZkAN3HtzTVaVvRCkSrxh4QrWYhnBubDM9GT4JuVqDuAtHNA4PAkVHTNM6P6h6HRFhSZt38CfAXt0nluVgPpi1yYrCHxHj7fUjabVwptfF5qgs1Mu2szVXMWSvOyv694guwnid5OtHw6BnjA
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014)(3023799003)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?lmliIkMWe0y+hF7iglRKAalStv2gDiwOxnm4+Oa0D5Ds+fv8CGqZUc/VtIf1?=
 =?us-ascii?Q?a4cEQL3rRTIJT8cxA83gt4r/fburtIZC5ozSfQwznA7Szx0EUzF3hcOe6NZD?=
 =?us-ascii?Q?R9gkQMi0X5FUv2VYQ7mF0qPCeUHcvZZbu71PZBfcvnv+gxyrUk91SlFpdOMc?=
 =?us-ascii?Q?1y9tfVWZcdqffvCoT5d6PYc0gBcnba/PDqJW7NV7TITYRg8j6zTKR9M/+d3L?=
 =?us-ascii?Q?H9ZZMv8Nb1gdWqwaPi+cJVpfsaRj39LseGdNtbR/St3ojz3/2azaPfBtA28O?=
 =?us-ascii?Q?Djw4vaieBiQXqeUe7ZbpoFBqwHY2twcMJt1QMzXBYpBFIbq8NVHWTcXAljEI?=
 =?us-ascii?Q?RC4AtEAuLfBgp7FUHa8OU+EV3bNwmgky6SZBSTA0EIFcwkSIYJZip+iJAjKQ?=
 =?us-ascii?Q?S0Vy/WDq4nNFDxy67av3bYldjmX2o09HFGlzniY32A5VaIsrPsMljPNmjuAr?=
 =?us-ascii?Q?hUQV+WhWjERj/dVM10WaO+uLXEsvmWSZyCU2jj7YB+Q8a8g6l/LI15/mliWT?=
 =?us-ascii?Q?Xb/nO0wqkd/f4Rfnt7e/CmQcrfxi7VS695dUNWCkhfDlbl/7Tq0ucqe3SH4y?=
 =?us-ascii?Q?TxNw1fn0PrqUlfYuV4Q7q3OS5s1zs/yabKzcUFqKaSEZA5zMd4mugr0vxIJV?=
 =?us-ascii?Q?MMn/fyzPTozlzJK3Mn9qy1mhsuRy/+B/gSG9JcWxdd7zOZHuZ1UnSPuONzf+?=
 =?us-ascii?Q?buYqMFYHUewqdsIHSbeRCLNywjV4ScOO4izi9fnAUYefO4kcAfgmnqkHODNB?=
 =?us-ascii?Q?W8UDBnBH5Ni8Bt+T0xX8qekuhF84QXdg8E+XZ3yzJcTQtcUyq3NDJcV0kL06?=
 =?us-ascii?Q?ZG4NhCmFsmfCvT1IUyLhjcGBvasUt8B3uCaYL/oMA0M0Uo7t34O8haAV32Yw?=
 =?us-ascii?Q?o+d8LhHwQzrIF7kzngjTggbARrrW1cKTPJc40IqCjFZvE7jFRYiSgx4853U1?=
 =?us-ascii?Q?dWrB3+sO4WJzsdBRKtNikhZScjQDEorwVmRHoXecYfX3FXyaQKyG43CcyVRD?=
 =?us-ascii?Q?i+sRgqLAx4XD6/tUyFYQoI/sQq5Aws5uJb9/5c4IcoZ13CAXIA0ZipEhZto5?=
 =?us-ascii?Q?Ps8FuIAfZPYNt2WM+cPAg0+S0yulZosysneOCJL38Ei5v7bJUrh9GOjMzSWg?=
 =?us-ascii?Q?gSfLNudbNT8QME61CKz1NjbL2o118Xojbo55xVbCAQMbymZXLuRMNgcMLVo2?=
 =?us-ascii?Q?gCzIM7vYwKYHJjXKzc6Aecg4HEwEhgJFY7AA/oSCEgA28aq1a0EUMNC4Lyem?=
 =?us-ascii?Q?khJyMNssZeSnewJ2T3cWp5o1etW/dwYv0H3vBG75svY9vtJnBnEXMpj2LBk0?=
 =?us-ascii?Q?g4RGFqNqCV0owJ/raGD75epQo7BS9TP8JN+t0wkAEN/281euk3xX4+djKs7y?=
 =?us-ascii?Q?ge2J/aQjgbABzMoeZSFUM4Ljuf1UM6rNi87bj3ws4LQTrLLTltSppF8NqBOB?=
 =?us-ascii?Q?x81oryL2xh9US15N0dj/LusgPQ9n//icWBxsKjEvHMGQZ+Fsocg3tDhyahaw?=
 =?us-ascii?Q?Ie4AwW7YI0R2EEpJpEjWe2lVh1pyTw5xFzPcW0KgZFMs6PnY17TbbWRwC8/u?=
 =?us-ascii?Q?cOxYrVpTxeQb2UnxS9sUX6GRZqxAjDfWURuJhR8rz2X1jxoYLNKT50/q1nDY?=
 =?us-ascii?Q?0NFksDfUmMdEcGfcupE36OwJedGwuglFIAOExBiU6XVD6uuUsJQ/9LfGlMpG?=
 =?us-ascii?Q?BcqS4GuWaGkFSqd+TNY/5v3EAyGbikiAmv2JBKJ8MrNGMk6WRNesN7dR+uTh?=
 =?us-ascii?Q?Hf6X88Xb1w=3D=3D?=
X-Exchange-RoutingPolicyChecked: 
	twgz6SXR0wh+K4q8pPXpCtvPDqIkwljxUyS5Ee+AUD2/C4J15cCwoqKP/GGkg4pCWlCCiBvwo7ImZZWxxzFQf8grJ74/0JVQ3g4O0AWu7A1QkMDFSDbp7uVI1TPX9MrOCtyuCQe55ADas9E4JeMiDATR8EvCFANjM3Hk5tOCaAnXNhaK78BQIXOWIyuzkqyY7tLsQZwih4yvqoQFaXDo3VM5DMbmzdKfj2+ITa+xd4/3WI0NGCRE9FvDK+2MxRSLTfPtuTAdgh7iaWCRDkJe4KgkkRe0daFOCFmte1CYKG1icySYn+7WhOBDcu0RfEn5Tj9Wo+pLWCTOIr4uuqlJPg==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd39eb7f-20b9-4c43-89f4-08deac008ddb
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 06:19:11.7667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Od78yseMuDjW4HdlF/7GmY2vYJWacYJ0VTQTXOUQAHRBlStic0kQRjDsPMFfGdG5l8O+zVxCUUHpxxEk6kC4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF383C22AA3
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: qi8ygznoqQ2LKszEKmoEJUHVTJ-GJOLp
X-Authority-Analysis: v=2.4 cv=JeGMa0KV c=1 sm=1 tr=0 ts=69fc2ee1 cx=c_pps
 a=1HqfSBmQQ8HGCHze6/9uFg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22 a=t7CeM3EgAAAA:8
 a=OUNPEJzuPeSuI0R0wQsA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: n_CHC6EPHSpmqhHchvfyia2_gKFYBsbE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDA1OCBTYWx0ZWRfXyUXTJXQQR7fQ
 NUK0Wbz/6asDD/uMTSr9gYhT6TpscQFKzcPSE/0wtYyoJY5IhaZmmm6m34yRcJWl48lTws5uSVh
 +R3duJexu7zeDuuyirbp7JUUDe+x998PVqg/Q8cwNqNkYOb099vf29+zlNwQVdAoV8pEfpkp04B
 ubp6qBXcSsDFSp7jZ5aHSgve4pRG+VNuJHAYP9UfxGFbLMz4146vv3u9zqQHYo+YAuTvX9Zpzky
 XLcJpuE0lGQGbWPq5efSuKyPJ7z7cJj7NSSKssPUMI2XLKTY8Oa+Snb6qKjuMqci7cIsSsuOHom
 fi3Igo1Is0HpM9KEVc28DYTYUtTjyFd6QGdqfpv72yvV1y8nCOxO9Yjl4sYOUTCtGI9D2lqqgeQ
 cIOdnBYUsQ1/eqfiARMsjhqoTR84YvXnVAs7mhvHLGCeXM1yPuha54hl2AFHqaFL4dWFXe0a+kU
 QEftgb79G6PP0Mr5Ttw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 bulkscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070058
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 07 May 2026 06:19:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19454

From: Chen Qi <Qi.Chen@windriver.com>

Add filter_regex parameter to the default latest_versionstring
function so that fetchers that do not implement this function can also
take the filter_regex parameter.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 lib/bb/fetch2/__init__.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 52d5556d3..7d1bc11d7 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1724,7 +1724,7 @@ class FetchMethod(object):
     def generate_revision_key(self, ud, d, name):
         return self._revision_key(ud, d, name)
 
-    def latest_versionstring(self, ud, d):
+    def latest_versionstring(self, ud, d, filter_regex=None):
         """
         Compute the latest release name like "x.y.x" in "x.y.x+gitHASH"
         by searching through the tags output of ls-remote, comparing
-- 
2.34.1


