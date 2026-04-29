Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5006BFF8864
	for <webhook@archiver.kernel.org>; Wed, 29 Apr 2026 03:25:12 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3867.1777433102299967823
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 28 Apr 2026 20:25:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=Xoc1U2fO;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=95795ebc5b=qi.chen@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63T20QAH1252158
	for <bitbake-devel@lists.openembedded.org>; Wed, 29 Apr 2026 03:25:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=zy8uDSYgFl8ehFu9JqHaKqVaEiM6ItCsmHZ4FaXmVDw=; b=
	Xoc1U2fOCbsFn8uG4NuWP4CoaKDnbbZoF528FknHVLBmL0wfUD+8YSG0TwcChfPC
	p1PidIASIquwXeo33K40PZ6Y1wTiqrDMDxN9RWzgj0cNA55T/Jc6UEiKn+NRgHts
	K0+nzqIp2u2adJMALHa+5zVdh63Xr7tH+yws3djU5K1UkUm146pssY8+8wX/5j0Y
	f+Xz+n0wQEVNFufQPejLAv32SmCMekdklqcyPSSY8XS1oZgk7gn/u43oq9cEQScH
	oR/Cr6oh59c9YknEhARaETnA830vSFR1NcHBKEXhKh/i9jnrnoQ2SBPvn6o0xCBc
	77SbCWjIj+5B0TRqLbbuAA==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011066.outbound.protection.outlook.com [40.107.208.66])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4drmk6vcth-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 29 Apr 2026 03:25:00 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C9C3yUN0ZSDBnC7IJdoPVpA9BhLGoQrNLLB6ODMCtZjbPvpGxQSb9XQ3+BhBKgVNac8nl02Ck8PuStnNXjJZrSLM2Trm2eSbnlynzifVPv/3p4Vo09hTs9ntDhJdBANL0obFgZLdZVAQQMaFc+tb0dkfp8E3pCV2tOz/NRnAPaKrXSkBgPRy1c3qxkK/qy6JlD8XpVsHViJfzl5MDXxyjK+h4VxK3AVoUbeM80cAvzQ13NVkwIU5sLI7c0InIK0h1jhol2kUZXjW6JrDvM9CDc5UaoU+5JAJsnXI0X99i7Z4P+PZk0taN+hJml3H0R78S0ACGPS+y9StoblaHcoQEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zy8uDSYgFl8ehFu9JqHaKqVaEiM6ItCsmHZ4FaXmVDw=;
 b=aY7EwmLT8PsCv3B30a7KgB/Hgi+XJ2Dw5eLGMxT2RLrUUy0hqvH7uLMwWjdmg9GBkRMic4cytcxkRM1c44A1hersc86kfEduA6ZWC0P6VUGSaHhF0qq39Kiy2ZLUW0KdI7e4VGX5L6MBoQAR5mTLBY6rKzKg/oLWYrY/YwbdbhWi5zLBVzL31qd+WC8Qys8Xpe+QolMRx/AffAsnGPKl9RvhmHOzf8XGtutP3DUacmlaZkhPRbo24RDNKTXUWfITF0akuLpN6YzMsBNGoaAJstHEb+exen6zHGs7OdKOx8276M6QUiKuCyWhs0kP07+ynewb6ZcGUOy9UBRwR7qMag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by BL1PR11MB5954.namprd11.prod.outlook.com (2603:10b6:208:385::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Wed, 29 Apr
 2026 03:24:58 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%3]) with mapi id 15.20.9870.020; Wed, 29 Apr 2026
 03:24:58 +0000
From: Qi.Chen@windriver.com
To: bitbake-devel@lists.openembedded.org
Cc: alex.kanavin@gmail.com, richard.purdie@linuxfoundation.org,
        Randy.MacLeod@windriver.com
Subject: [bitbake-devel][RFC][PATCH 3/3] lib/bb/fetch2/crate.py: add optional major_version parameter to latest_versionstring
Date: Wed, 29 Apr 2026 11:24:36 +0800
Message-Id: <20260429032436.1075831-3-Qi.Chen@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260429032436.1075831-1-Qi.Chen@windriver.com>
References: <20260429032436.1075831-1-Qi.Chen@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0019.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::12) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|BL1PR11MB5954:EE_
X-MS-Office365-Filtering-Correlation-Id: 172242cc-0d91-4f1a-6737-08dea59ee405
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|38350700014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	lOFH1bbTZJzQ/0sPN2k2367Kq/CGo3lSusowNk//FHYRo3oacoGRldW0+Vx69uak5915jwWogXxvXsz0IYWx9vJAMKGr8s9f2VnQwD9cFz9SHGhIVYJJHHwd9lI5KKfOtpX7911jlvsCHwfTmT9h42XJfxjqbbNNgxvQs1OUeLaz41xtAcsOxO6XTyA88lRYLiFnhO2hRkPwpq7I2rZxZhE8HInGKQbHsjks+TgxYkUPkQ89nSUk1SybxVIh5YhieRQHELThsCYxosyAJfwJOE7Bu/N6NHghizQ0KpLawQ+RthcYQUmiSVSP3w/0ZVrMuRFYudYWkGIQfeCfhJfW/14DTUFqhEnQRuXKjzmoV3cmz8qjDs3HM7XtgycWHD8k129CYb5yB1qe7fOjwh9h0rKGS/OPbFhPvb4g9gembmmu/8bK+BIM5/eNd2qM8Du2TOBJRJwzVEy78Umi3WiTdbAWg/VUS+3mupULtK3bRR48sFxZYCCWe3Y+TKY2V94joAusUOy11f7vfpTuxBE68JGRWE4gPoNDVF0I+TFkCJv+g/sAhmcV7Am78Kh3wYGrPk72led4N88ydQqStFCu4CSUlva1YOVbQDM/rewZ+N06MJGFrA5sdKRsP3RvsnO6+QVLaIIvbc9/0SCHikBV2ZqN+6SZWADGP9fTocqnRfCCLBFUw2eolw6kk2cDboxn/aQTvJyIrvr563W0Q3SkO0h3c56bRpMIAfedv9itU32aYzW1RYy9gffSFRaB//nSVKofE9JgYH54tgHQeuiCqzs+YQN1x958aVql8OszXtI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ymGtAc+9tsp2lYbv1ST/lmAhYhxxY5PAhmab/i0XOu3Jn09EoKyb8pOzRWDK?=
 =?us-ascii?Q?i8011ML/XN5qsLYgMX93baagFI6W4yre3ji9K1l+eGBPNx3jju569MXIm/ft?=
 =?us-ascii?Q?RQ6EuZS/eqPChlyvHZESJhZ1k3xt1Ve2oqzI6wZuRJ/G+ve5cE3PiglTG4yB?=
 =?us-ascii?Q?lFl6pqCIGhuAEgu8IfiRUaOdOfMRMDosVmf8rsdHOSsyAv9qF1RHE9Z3wOe5?=
 =?us-ascii?Q?Ly+CX4UzuB5mgXW/9witwMAFZ/yhScadqAs2Tonf3WGlHcRFlNf65UO+PepN?=
 =?us-ascii?Q?1YfGxV3QN6QLO0oCdUy3zFlZ94BdOL9xtgLPJ/73jR/V2d/YDqi/7pkgxfZs?=
 =?us-ascii?Q?9NGxBfjjuh/3CkMpECITDJeWA3sdYRYsc/gOPwD72a5njAD+VozqWELAuDpF?=
 =?us-ascii?Q?F/lI1VWytueLKE6jS/43ubLcL4MbkB9yyrGFBmyUfYPi0Gn+tALEd9MJ5IT0?=
 =?us-ascii?Q?DPTiKfAAtmhDsu4O+2SRAUBILpHZQYRz83MECBdv0uD92mJQQIIjDgDa+SKl?=
 =?us-ascii?Q?MUA3CczztWkAhGu8FArnaCizt+DOEnqma5RKlux8ILSSFfepDFFwuOTPepgT?=
 =?us-ascii?Q?V4JouCepfJ5+b9JijA76oUufCWtXT945u1FO0tIj92wBtM/dAPUQoHnXGfqk?=
 =?us-ascii?Q?CfB3JPedSPwubsNeQcd/S2l7rsAitfmayQNBB3T2nizbXEc79bXwNKe23JGp?=
 =?us-ascii?Q?ALc/BgmVHybGFUXTc+LEOJy+GZGaQbBmnIUPCafw2ExlBKmcLTXOgPhlsFzW?=
 =?us-ascii?Q?Oampvcwv+Q0cB29t6ZCSR2WPrQXsVq3tQfi+Ax16v/XfexT0UHYdwoqQEkFh?=
 =?us-ascii?Q?Y/RVuA1awv7z3TVyRlQUueXKCX0hcsc0PjEQQOwxnLpZ2d46VqyYR2o0vv1I?=
 =?us-ascii?Q?McnneAfXSjf2QQHg93OtIx840nKANzJlK5zWYgtzhiu9NiD1bvjxa662QlJv?=
 =?us-ascii?Q?r5sl94Bha7kNhSDAaHi54CqLx5+UHAbQ+B6tLKCvc1z7BdAqwrceEUiWEkXD?=
 =?us-ascii?Q?E9uMr4wyCLQxHcTIs7siUPNTrNQ5Hn0xJKloQNCkYHdouI1r4kvWv2KHHzB6?=
 =?us-ascii?Q?NwYdJKWoGogwhWtsWi9A/nRZCCqcofLbaMgEBLI/+IsIpyTNGo/jsNxFTw/b?=
 =?us-ascii?Q?HX8cNkpHp8WItoLt9UXLKmVn39LsskZBX8wgpJXxjive4ipH3OEWgCODUXbS?=
 =?us-ascii?Q?Pg8N+a2GBeXRzTK1hNM6QDMDQzk+sHgVqw4PPokQJgREimyiBodwDqfXqiD1?=
 =?us-ascii?Q?0geBwN8wkyW8r4Mcw3pF4rSCCCslXV5bFW657/MN2hUK/OcgBhalJrd2f+gs?=
 =?us-ascii?Q?ArMVTjkIdG0dy6Buw9IVVUZOXoEGKcX15RnDYrl9RTZrGXDhMczeAb79cDS7?=
 =?us-ascii?Q?YlgtJ0hdT9GE6nQPR9oDsnwqSanumO/2y0lBfnAtTRE893+IpJ0H3193unx/?=
 =?us-ascii?Q?wqp73KF8h9nH/BzytM3sO9ECYCK0o4Y6Q2yw15g092v9ztaAxBZx40f2B/IE?=
 =?us-ascii?Q?viNNy8rRMKOtFLLGLeD3cmuwRghECLeV1Oqn8EzVGUT8s50beI9NyygCnuMU?=
 =?us-ascii?Q?/KWaNPOYG4AnvJxUp/lhEN/PdBiXlj0kcLvjsuNsBC8SDlW+mQ0uqnkBO9h0?=
 =?us-ascii?Q?tYDWXve9W/aAJ4IsDdPxXko3QJ8bdYBYZFRvupUYx1vGXX4nWydCXWzdV6jo?=
 =?us-ascii?Q?wGKqS+uj61vdgL5zI7fv7N/gHRZDF/+yDBN+/5GVH1YZup4yZaMeK5VtKwZm?=
 =?us-ascii?Q?hHY+2Pfpew=3D=3D?=
X-Exchange-RoutingPolicyChecked: 
	m1gDlADp+cm6Sq5vdaAglj8B/G4Q5F09vazzPsZvogfCHkU/SVMvKWWLxrVMq15yUH3ZrSLLAqKiXMTVoOTswMkGpicTNaocMtWqyqDqlT40Hlg8noEOZJ00geag8khRtY4Nunp4DG6SL7jAngiIwasVcF0Pn8fP3fUwok5I8ymCty/PItlKvz5RK2W/pKbWSWfWp1CHIOVHGSIDb6yit7VVXuoH0Ky7UNq8sRDbFqeRBomMkLxgXZaLzegP8EH0q9mFNIaEtcT4oYRRKRgrWGPq9F2hemNn8KfridNVlpcm3aYDv1CZzpYFbYqm6Hhg3Mfp8yXvS9EAcNjKiU0CWA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 172242cc-0d91-4f1a-6737-08dea59ee405
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 03:24:58.4892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JXU1g2DbVuBhlTnrK0HeQBumzh/i4qCdUUSzaBKWQEJkVHJmkNsJTWOnRVmnNvEYKI+OJL7oXTboB+Jm8Lgo4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5954
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: L2hmYOd2RllwB5OyVCMubZnhZYQ8lWqf
X-Proofpoint-GUID: Wl3jLYM5_4Z42pMIccW8CqDawcdJ_gaW
X-Authority-Analysis: v=2.4 cv=RN6D2Yi+ c=1 sm=1 tr=0 ts=69f17a0d cx=c_pps
 a=+lVouGy4Ef+S63FV+3Relw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22 a=t7CeM3EgAAAA:8
 a=b4nhW9Vc8iuCVDfx7nsA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDAyOSBTYWx0ZWRfX5sXkDQmNUr7a
 VEcUW8xuVupzLKsGv5xD0xQ+i+auVWJBmtU8FiEynJU9iIcVzpXtcqcjJfv7Vk4DVW4EHuTh2G4
 u8a4uGZO5ssdmE+V5pwk4ac3o/XtgC33irHOY23WuognaJRnWvm5s0FX9cgKapA8AiOs0z9FTeh
 8RcnCFHSoYxmqwVy6q1XdbFkARh0rfya/cP8Lsm0k7Ipme/HE//lq7nJf6TI4c9NFwdM0sq55eJ
 MDTtku2j/3PQGhh60EWdiJKVkv6WGI11U3zN8kLRuusFrYwTsRZcojDtXT789wCrI9WEwB9SnrB
 KV633frmj7kAoems+XJSucFz+HDCN3MHkNomF+h6lHumcIxCqCFHwqH36tEtZAzdPFgb5WnZREi
 sHMXpDWLwTrdQ85Ax+S35VatZUNeABG2RYPaFmgIfTcH/H+DUbWKmuoJEcwyXoS9m7C3WGVfw2J
 ttciTLYK+LkK8y/k9vg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290029
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 29 Apr 2026 03:25:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19410

From: Chen Qi <Qi.Chen@windriver.com>

We need to handle the situation of LTS upgrades. This means for version
such as 1.0.0, we need to find the upgradable version of 1.0.1 instead of
something like 1.1.0.

Add optional major_version parameter to crate fetcher to support such
case.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 lib/bb/fetch2/crate.py | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/crate.py b/lib/bb/fetch2/crate.py
index 2d3078899..4ac71946d 100644
--- a/lib/bb/fetch2/crate.py
+++ b/lib/bb/fetch2/crate.py
@@ -144,10 +144,16 @@ class Crate(Wget):
             with open(mdpath, "w") as f:
                 json.dump(metadata, f)
 
-    def latest_versionstring(self, ud, d):
+    def latest_versionstring(self, ud, d, major_version=None):
         from functools import cmp_to_key
         json_data = json.loads(self._fetch_index(ud.versionsurl, ud, d))
         versions = [(0, i["num"], "") for i in json_data["versions"]]
+        if major_version:
+            filtered_versions = []
+            for v in versions:
+                if v[1].startswith(major_version+'.'):
+                    filtered_versions.append(v)
+            versions = filtered_versions
         versions = sorted(versions, key=cmp_to_key(bb.utils.vercmp))
 
         return (versions[-1][1], "")
-- 
2.34.1


