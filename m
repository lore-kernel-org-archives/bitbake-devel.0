Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 609C6CD4F21
	for <webhook@archiver.kernel.org>; Wed, 13 May 2026 05:24:53 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.903.1778649887854719076
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 12 May 2026 22:24:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=HOhnnjMR;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=959349fd7a=qi.chen@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64D4nlbC299847
	for <bitbake-devel@lists.openembedded.org>; Tue, 12 May 2026 22:24:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=I9m4m/vW7RlB59hDxSNOXHoOtkJ7Yv38NgNQAfoBrZA=; b=
	HOhnnjMRvr8+FhJhALUXrHl9wKrCkUZwn9YCn5khj5c0dsxGBDi0sQgl7TL7nNCT
	YHBj7BJ5i794cmAf6sbIfaSB/hyBb/EJRmEsIe6kbv0wE3xcNB2IovqlWhQjdwh3
	nUahaCxEo5Ln2yayTOKouvpHVnUgPQRiHIDGEDceaeYgqPGqOlLVSHtDRVi1JOd3
	a/JfY7xMOTeHSRtnXacsEsn2pZ/5ZwPZjxJZLYWO6e+SZaz05z6ZukS+ey7VquY1
	2EpCtQldgA8DfSxSKV3WtnR467fh4Y8jLmrFM5RVW7Yxd+NE2xHN6uJ+XUmtkZZB
	rTVs5iJI+eQkMpMg+vdkJg==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013012.outbound.protection.outlook.com [40.93.201.12])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4e4g7g8625-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 22:24:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xx+qMJ5DIEb2MK3BrGJkIEiLFiHhyJtZlre/rwJPhYDbniBTi/nXJYP3uzqbKklhk2PbGNnD01DeW6d1hJMw8SHStWd8glNbj5s0CXDUliNAhW7V9/XM5uz4xcHle/QHdjVq7K6yE6RU8c3ft9bg4iNo54zkWZXQ5m1nXiDeTChVa0NICHBMSoAIrsxrOB77fdg2jV6cZcLwcUX4aACg9KaqXzOw0X+uOeBFKP+cdRouySm2iQtNpTbHFWm2tUCCFgDh+boRU4q2/i2Ju8pyltnjlORKs4ofpJS82ObMweZY4LO9C+X0Nb+WsRiFR1XYS3KzdMvRiX/OGD3AR8xxzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I9m4m/vW7RlB59hDxSNOXHoOtkJ7Yv38NgNQAfoBrZA=;
 b=E0h3L+ok9R423f1Nmz6c5JJpvi7eK9zsR5ku3giHL1PCIfjB9Blrkqr43ToE2MEsPOCzpN7zqvlpQZxVDSCrIhvV5HeVMmFPFBCnLdfFJ/9ZPovjNMIeVmwTNr/01CxMD1zzSlw1rjlMp4Aezv/4E+pEpooTxU/A3yYJcE2WF/s7ywxLNywFSCcasuwvrxmA+okUlH33/DRf348rwPsAb61cKiTU4TVlqs1hT3s9KyodwWccUk695tHGon4U/mQZbh0QppKHY6l/beiMxoI5VH0CwRhRv+hr1tCBw9/NGBJnZHFZZE80rI214JrkMaazw/JXJFBsz++GjGhrA+/WrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by DS7PR11MB8855.namprd11.prod.outlook.com (2603:10b6:8:257::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 05:24:45 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%3]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 05:24:44 +0000
From: Qi.Chen@windriver.com
To: bitbake-devel@lists.openembedded.org
Cc: alex.kanavin@gmail.com, randy.macleod@windriver.com
Subject: [bitbake-devel][PATCH V4 3/5] fetch2/crate.py: add filter_regex parameter to latest_versionstring
Date: Wed, 13 May 2026 13:24:22 +0800
Message-Id: <20260513052424.2271877-3-Qi.Chen@windriver.com>
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
X-MS-Office365-Filtering-Correlation-Id: ec504881-0932-40af-4224-08deb0aff13e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|56012099003|22082099003|18002099003|38350700014|11063799003;
X-Microsoft-Antispam-Message-Info: 
	p7h58Zph/EbXt2XaIKq+SExpFzTvTH27bKzWnRYEx5EoXNyCPJrodr/2eAmVuzCk5Te+3l2eTrT54d+fra58aOEiMJkodIzdO2k1LuUA5GJFpeF5s/BcuIFWzgzXJPFgamSDGpwhyuQURH+0PNu77i4Y5ci4wAdjavoVYJQuM++LTU9mUQxBO9B7ik1gWffrPFUM0eZugvwBPnDYzSLhygNbcrOfUgH4xuzkbVVDQOf4UH/aauS8jI1OjwzQ8AbUhF3rLkdhn/bjKZbgM6jy+0dwoGURk0dWJ9zcG2rOUqlZjHcGWAw1bjLqT4nnSGUusjw1Lh9WKJ0vGtKtxp85UFSRIPHdJ55ZL/G9rHB3dMmWST8fI0BppN3Nl6wEy/TxDCLix9hmC6Etic0TFyadBhibeRs+6bSc6IyP+rOpqSSayirarbXokagC15batFcVLjPrgGgGj1u0xs3bZJ4fwiG0ioQtIEQJHac2l4em06WIglXVnpS5z+mMVwFANPkU/EBrX2uI0xq+y41zUz/bJnnyqXnryXGet6udb3d7QU8AuPrCWn40rzSF8IVhfFbofnducB4DP1jeV2YV+9b+lJaMrpWmzR1prP4Qkdz9hIMsjV9IC+7yJmg01/4PWoYP7KqzY52krJcfkBcEJBObaKOn9B89KgUIRcj445tI0JF1wSNni8gSC81xo+FZvt8Q
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(56012099003)(22082099003)(18002099003)(38350700014)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?e7GB1w9+twOfczhJfnO9KnidYGGslwuXgtb8FThwwbCAWRpsct5s+4aR6hOf?=
 =?us-ascii?Q?IKGdXfeWPCEGcsFNP1OdD1oYIuw6kHSSBnrEXHxhQFbyZ2B5LAaji92+mbst?=
 =?us-ascii?Q?wyUnMagvu7NKQoghgecdNHvYI8GBokeFk4woy+MT/zGaug4wJGUAXgGeK4Hq?=
 =?us-ascii?Q?IaOEkrg3l42PwFfL/dxrrAT+IkKwblsLdU4htnTMFQdMUYKniZHK9jORWA7e?=
 =?us-ascii?Q?/rRRyiWAKd+z3hX+u1YeWQPl60xjsbDw5Wg1CKuWQBT/6H15omaYodakMyI8?=
 =?us-ascii?Q?FhK5V5DzDGNj+ysk33Hq/V2Ps8YEr9+XkyBJ75MMcn2+4S6PaGDAX9gmkzDx?=
 =?us-ascii?Q?lNol9iGYHXaraBrmuw3d9KIrkHW5knrZtFrug5EC6R4fHaJMVJeD7eF9RrDf?=
 =?us-ascii?Q?cyQLJmMWpNFkW1nP8lADX+2Tv63yD8EPkRMc98kylH3dXrUo6sDy939P6101?=
 =?us-ascii?Q?RGujXWZ+/7a7glvnqlYaGsz1bngtdXrhyzyvnJ8DhkC0Mvwt2UhX2EHoFeHP?=
 =?us-ascii?Q?bTOZVRfpjsVdJMCqg+T62pvHSRMDAQYW9+X2m6bu71ocMVhAeCxLHKK9i8aa?=
 =?us-ascii?Q?qIehgCxRmOqib+wDK21ndTKNu47IhT8liyCR+8ne/4U+wWAft/MOphV/BbeS?=
 =?us-ascii?Q?QgMYzfz2gbeRkJPGNQikFoEFnZnF6g0aomDjkpP+kg1oVOo7UfWbHG5n5hy0?=
 =?us-ascii?Q?Ms58phrpmpXNtdRppuEIpMGwZynfb/e8sn+JulCJ6dsXUnbPjeArQtV5Uuhb?=
 =?us-ascii?Q?OsZjElLILyoth6NVumX4hhJGc67phffcoGpzUnKLNLGeaIu7YDrsRvnnigba?=
 =?us-ascii?Q?VrS8q7LeLQODC7V+0THZsPAG8Ze9SbGx6gmjieL56OsOlpNbGznrlsWXVjKX?=
 =?us-ascii?Q?ZFt7jBfAd+6Tb+hwgmV9o76dLVhSp9OFsoi0hPYiGpVq8hYmn+1ERh3BiS5k?=
 =?us-ascii?Q?2E2ulQ4//dyaRImyVq7Kg5cwoUh+gS18u18cbGZeqqvlETASNnz+/DR6pEpG?=
 =?us-ascii?Q?Qk+rvZtXu/7ZMReHREG/rZD2OnzyYLIdylakl1K4qCfdg1WaPHSjbIIRSUVW?=
 =?us-ascii?Q?fJ0N+wrwrs69r1/p/8jvJMe6F6RxaCcYaQFKy+jMNN8nALUhZe27BHl9mdUM?=
 =?us-ascii?Q?0SmKFZhs0gaImAXMPPzDYZPI8rHGq7lu4FIy8b2rYQHx+XE1CWXPfSlojJAU?=
 =?us-ascii?Q?kMDJZk5Aw821P+opzHCfI8ONqb0ovI+7pgZ4BsMoq/ReFzJPYCzAFQDyd+BK?=
 =?us-ascii?Q?1ht+Za5NeWne/URsvLEYXZAVB1uMfaghfod+XDoGob+q9a3qnDMfouGRvCN0?=
 =?us-ascii?Q?4hH7umMeWeuUWFo08Z9OJA4krQ7+7ikTbOeKDS4bteGIlf/f04mtCnTIrl5U?=
 =?us-ascii?Q?QFCfxWaFqNY2YlC6B7YE1xM7Qi7+k9STieANDbSq8pKtDtmfC5CcNnq8UI9c?=
 =?us-ascii?Q?/NUNOIsUw7sjvFepLSsOGVxJASSVz9RCgt93c8mpZBazCN9cTrErOBOCxyQh?=
 =?us-ascii?Q?5YR7oFOWRsHIEq/KKDjLDcr79wtptF0vZvvyFLMpJsA3rX58+4xumvPuIBcu?=
 =?us-ascii?Q?/KuW41FEhOJHQ67/fetyeeD3r5ZVXkwpamyIBZDzzqN/dK185vGi2+qOL6fV?=
 =?us-ascii?Q?sEuKlPN2KuH4nFM4EyweHKTrV5kXoVFrFGYucglpyMpIv49IC2rwlFzwrg8e?=
 =?us-ascii?Q?tC+iKeJkR/8/2LQFrra8Ap2OZPNtBuLpvtkJcp0qkYMKtEdPw7TFL9O2NjI4?=
 =?us-ascii?Q?2/TS0kCzVQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: 
	e322VAnbE8iwubBZAehlWBX6U1Zf1AT0JMBFzrxiLDn2VQNiMSasi204QtMBnmveSCyYqGTjTBcwGwVCch5yuPSoISxsMl5xzTevFAVeVA2kRewccBQX7nNVuymiyVe50p/WZSBPGuY8Bz8Jo+tsx5FA3BsKL1XFiUmRbojNfadsQbOI4EOyepXT7Lb2cO195HAQLfPbG1AUGU0emFexhYTlDJmQU0G/+5ZE5vX6vIfQp98clc0t3hBHQk7C2iVsscQzpZCIS2s+biNfwLUm2zJST/8hu6paGYrnpuFdDA/kBpBb+lV48IF4osV8u6OTleRWE0hkXouk/9H2ScFmmA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec504881-0932-40af-4224-08deb0aff13e
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 05:24:44.8412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fvY51052cmkFqsdlre9iC0ANyQE5WE6H0WZ6M/A2zNF+hJA0Coe5fnj8iAeLP+zVlLxLBI1H3h45qdg0wRIYCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB8855
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDA1MSBTYWx0ZWRfX5FV7SK2YgQdG
 7TahceDI8wlpYx6XJFdD3mfCoI8FWkAjiIb1aEDfSZE0lp9b8oALbAW+BquQE2FwHAHQ0uk894J
 h42LzA7dWJuuzudTgLdMQiBxnWAk5PjZsXLpM4QfgTUukallfegytAal3lJyH4xhXcyBkaUcMIe
 iqiPUTfWqv+Yvg17Rwz/3LpT8Sv8wjRn+vyeOwf6aVZmUVPtpc+HjZj47y4qX5R/gYkCp+wt2Oi
 YLR1K9kNpAal86OVNjKh+52cU31Xzp1lSc1TNouM3ozwR13FSyVetXULxBDLb46XwN9koiv7IrZ
 SEeM4v1IlznwLHY8sbR4Mn0FAX5ZY+rPkWa/a5uy0gQ6UucZqgTkvfUpzZpjNE1Qrtk2qJTrHak
 EI03Sxxi1QuEWM4Y0voOE6YE5kOV7YZgH7Be5ZngaWx0W/aAtdHtVeZzpaq/dvr/6lE0k8Z7Bpt
 bxVPbz2w9EU9d1zawiQ==
X-Proofpoint-ORIG-GUID: xquF-Y3-GiMwrdbQYOrxeXQciWgKlaCg
X-Proofpoint-GUID: lJBnmszRg2yEUE91715HjXToK25YAj4H
X-Authority-Analysis: v=2.4 cv=Q7jiJY2a c=1 sm=1 tr=0 ts=6a040b1f cx=c_pps
 a=4PCWzz9QFLYZoRw/GV/NtA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22 a=OcE5tU-iAAAA:8
 a=ei4SEBeUAAAA:8 a=t7CeM3EgAAAA:8 a=hIPOLQWK0ZafnOV6iRwA:9
 a=qwkNQZnGtIHGNKTLT1RO:22 a=8zIOOLb7Ym0NljyPXbuS:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130051
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 13 May 2026 05:24:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19503

From: Chen Qi <Qi.Chen@windriver.com>

We want to be able to do stable version upgrade for recipes. For
example, 1.0.0 -> 1.0.1 instead of 1.0.0 -> 1.1.0.

To to this, we need an extra paramter to latest_versionstring
so that we are able to filter out the versions we need. Using regex
has the advantage of adapting to different version schemes.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 lib/bb/fetch2/crate.py | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/lib/bb/fetch2/crate.py b/lib/bb/fetch2/crate.py
index bb12f4e9b..8f928ea6b 100644
--- a/lib/bb/fetch2/crate.py
+++ b/lib/bb/fetch2/crate.py
@@ -14,6 +14,7 @@ import hashlib
 import json
 import os
 import subprocess
+import re
 from functools import cmp_to_key
 import bb
 from   bb.fetch2 import logger, subprocess_setup, UnpackError
@@ -155,26 +156,27 @@ class Crate(Wget):
             with open(mdpath, "w") as f:
                 json.dump(metadata, f)
 
-    def latest_versionstring(self, ud, d):
+    def latest_versionstring(self, ud, d, filter_regex=None):
         """
         Return the latest upstream version, dispatching to the appropriate
         parser based on the versionsurl format.
         """
         if ud.versionsurl.startswith('https://index.crates.io/'):
-            return self._latest_versionstring_from_index(ud, d)
-        return self._latest_versionstring_from_api(ud, d)
+            return self._latest_versionstring_from_index(ud, d, filter_regex)
+        return self._latest_versionstring_from_api(ud, d, filter_regex)
 
-    def _latest_versionstring_from_api(self, ud, d):
+    def _latest_versionstring_from_api(self, ud, d, filter_regex=None):
         """
         Parse the latest version from a [name]/versions JSON API response.
         """
         json_data = json.loads(self._fetch_index(ud.versionsurl, ud, d))
         versions = [(0, i["num"], "") for i in json_data["versions"]]
+        if filter_regex:
+            versions = [v for v in versions if re.match(filter_regex, v[1])]
         versions = sorted(versions, key=cmp_to_key(bb.utils.vercmp))
-
         return (versions[-1][1], "") if versions else ("", "")
 
-    def _latest_versionstring_from_index(self, ud, d):
+    def _latest_versionstring_from_index(self, ud, d, filter_regex=None):
         """
         Parse the latest version from a Cargo sparse index file (NDJSON).
         https://doc.rust-lang.org/cargo/reference/registry-index.html#index-files
@@ -186,5 +188,8 @@ class Crate(Wget):
             if not data.get("yanked", False):
                 versions.append((0, data["vers"], ""))
 
+        if filter_regex:
+            versions = [v for v in versions if re.match(filter_regex, v[1])]
+
         versions = sorted(versions, key=cmp_to_key(bb.utils.vercmp))
         return (versions[-1][1], "") if versions else ("", "")
-- 
2.34.1


