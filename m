Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 407A9CD343F
	for <webhook@archiver.kernel.org>; Sat,  9 May 2026 05:30:20 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6787.1778304619438566135
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 08 May 2026 22:30:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=UEF8Dpju;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=95895a8adf=qi.chen@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6494wZ3t2309362
	for <bitbake-devel@lists.openembedded.org>; Sat, 9 May 2026 05:30:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=7p3aC92/tHVl7EQzv19w8t43teC5N9+KXOx2M/U9/uA=; b=
	UEF8DpjuhaBfQyzfJnPfApcXX+zrFjPamn/H7xDi77ljIqCAk9U78S9Ygb4jpdwk
	Vn8fGwuDF4Dd8WvWbcTxFKkomsLjrr4VE8LRRxjQZ1wZlSMWlaEaLLDf05gCGz4t
	dAdohnuM/KVWbDbt0tyTtbIuHlte7O1mq8Xqi5MTRzoHGe0QJ6SNragEsIhab54U
	n6t+uf47faNwQcPohYxZUG1Nh+e6tGeXbwq4jwv3dlyWMxJbDR5V1hPVIP3gQ17v
	0zOeZ/cdkNPG1v6v2AEZ1B4/st2hCXgHd/e0hl/IOAvVYnGiho/voWrWd0FXg5QX
	YNNipyek1FVRH3E+WrqZQQ==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012068.outbound.protection.outlook.com [40.107.200.68])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4e1uw6g3xe-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 09 May 2026 05:30:17 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L7F5Kx8u4IdLLUpcRmLZHZiN0+DyFZrd/YFutP8qI3wqEOHH7xjlIKyT7wl69ub/d1rTL7Vpws+foFF3I/wnkl5/f8wK9AKqysyAkuZuI2TpNMiCPFxx3gnMspm52JTms/wh3wUQMlvydhXiS7wymUdzTwKUW0FwPn1fy0+UQq6FNIKEJHTPCxDeFyguOztqTpoA6Ncjn4GQlikWXAWBRtLO4IICZfVzASBCIiNXb0BDxf6aWKbh5xKHCJP122PIDTscdyiPni/FHYSU8GELn4z3VaIu6MhgRBpKPy8tcQSxirp9DXXHMAnMS97Cg/sU8zRjxUDaLpZY+EoxgbanMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7p3aC92/tHVl7EQzv19w8t43teC5N9+KXOx2M/U9/uA=;
 b=inFIFGVysO5n3Q6EjszSg0VKQdNgWbTkor7KkcM92/Cy9iJSWzAvOSjazffPtGpe1BOn0ejTaFitGBp2i8MI2fpSrILgey//1VMp1AyetdHSr5obTvxdF76imzz6gv024NlyzBd8BHhVzXRf15kSUqAoghwvMhHr6YH/IkAlWjZEH4AtqWrthkgVoVMFanvlMHOwvWzCakClHjwiAezHIfmx+3+KdtbwO2XwBdLB+pIRVFgnK/8KC/jFCUtF82UgS5t5OEqSxAKFDqUDtdWaR0W4kO6KSjyFtZEpQ/Co3skJ91XKe88PP0KTRgjVWeHXFBODeX6gArJCbWM+S+ieTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by CH3PR11MB8657.namprd11.prod.outlook.com (2603:10b6:610:1ca::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.20; Sat, 9 May
 2026 05:30:15 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%3]) with mapi id 15.20.9891.019; Sat, 9 May 2026
 05:30:13 +0000
From: Qi.Chen@windriver.com
To: bitbake-devel@lists.openembedded.org
Cc: alex.kanavin@gmail.com, randy.macleod@windriver.com
Subject: [bitbake-devel][PATCH V3 3/5] fetch2/crate.py: add filter_regex parameter to latest_versionstring
Date: Sat,  9 May 2026 13:29:48 +0800
Message-Id: <20260509052950.1565384-3-Qi.Chen@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260509052950.1565384-1-Qi.Chen@windriver.com>
References: <20260509052950.1565384-1-Qi.Chen@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0087.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3::18) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|CH3PR11MB8657:EE_
X-MS-Office365-Filtering-Correlation-Id: 4133125f-25ec-476a-9438-08dead8c0b44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	lyGq2iJbfyE3rRMwjwL9k+5gEJRZDA7HC7DAW3BTAtlVfsIMZjdVw+q9qoh8ukXSgz7qsmzUnqT/zhlahsYrZswcIuakbIUPnQdHB08fr7yBUX9R7ImlMhYVmI7sym9KJ5rL10yuqDv5+BEZE2zbs7CdePjEk720Y8N3QSu1J/XwxN/DnqLBWlgSlKxrrQkyrQGuTlfaj2H12RRT/IHThAjpeVSyOoaDGov788t2GkI7r91luYT94bXD54Z6dbZevyS8EafnPQDM1WOUt4a9d223nTFSK/Kp/peYANpc0kJ0nwGxHZSDAJKkmljVYv4/iDxQuw77k2cJiank0jWuQ4BVs8grByPz2zxbtdszDNdH1YV2CIS5dl+jPpgm7XgOsMk2dCh3LWpgZapat811WCy/bL0pZ8SjpL24rsmYKo2gC0GRsmRdaaKjUx8m7d6smsdH7FlrEj6wBwZmF1rCH7lZhWu4wOIKLoTILNDLDYTLHchQg0PKjrlip9RBcD7sjZ7/pgKkpXYjVDg5z59e0kmV4jTnfJkwqiVsuifMnogEzCSSByYJ7ySbl64x5MDaKv9BszEdDMtKrbDXlgflhBqHlMwN9+LCDaKThxgc5SqwkUREryOdT/ZPWGNnfwPHJb/SpatElBI7yjXYaSFlF6g5qwLl1ycb5gukMBkHaBm2Bn6QjUbd1FAwxhOmMzVQ/HRxY+0Lu0dtigxasdIrWclEtVKKoVQk6YxizB+6L/0xXTjlO2lvoIncZyHMbU5A
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?tL7ZMeBORgCZT4WAU3yw8PDIsuF/WXueTh52+Xb1Qf8FZOtXzl/OEAk1iDi9?=
 =?us-ascii?Q?Aw99HBjGrvK9aLZLGdu2zK8qIW0vjkdTLTgYxL1Sx0gBDIK0q0NvoVd51302?=
 =?us-ascii?Q?QoT/4fp7DDE1WEwWFFRZcbrKqARDv2+tNXQJG/3DunoGbd2v8ZFadvITaY3b?=
 =?us-ascii?Q?qcrP710etU8MiJCB3TtOFZ6oILX31HKcCJqoaVkLwoT0ucXhb2pIOm4UxKJT?=
 =?us-ascii?Q?+S+l6S9LhhiXt1iIwlM5VyuvZjeaxMXy4PoEGUo38kQ5Y47oOjhuwdC3iM8i?=
 =?us-ascii?Q?fErDqUJfa+vfizpQHVnaMkg0oPQilW+TKo7xOJT+tf21KiOVffViNeDbbHvd?=
 =?us-ascii?Q?/x30x+bvnSRffgYK+Kqn1gzbUl6tLFL+xvb8kbg2LEv21tFKbpLKHPFs4szx?=
 =?us-ascii?Q?4220lMPARVglOnRx2j846xEKbT/Yaez9cok0dCS9Fp1B304JybJk+v2idkm1?=
 =?us-ascii?Q?kWaIoLP1TTILnhkGrruhIxCotklqcgdcae+y/4ReV3EYbeBnmEvPSXIENje3?=
 =?us-ascii?Q?cj0W7Y9dvD1eTDRIweLxfGSR1azjwABQrTZPZXW1FJpq6yUtkzLzJ5kWSVof?=
 =?us-ascii?Q?jLVeu6E2okeCREXeWKySgPYMSgShIDmvdsG41q22aRZHk3Tj/uSZO6Xbn5ag?=
 =?us-ascii?Q?LYjgfRdvHjWt26feE9T4XSStI+vbUAlbB2/x003n55ncprtVOhsdxV6Nhskb?=
 =?us-ascii?Q?jTCHsvRs4GlUvdRTekqmWBPhx5d3JV2PEVbgWRvzZMwDwxtzSLu4YxaaJ1ap?=
 =?us-ascii?Q?KdYCCbu34j0zekxBGtSnSpdmaVQfVrIA2/RgqLEfGEfozJLoqyF4ixibhDG7?=
 =?us-ascii?Q?Y/Zi2HL+v/WSZWRMbl4zPkiRhRarq75OqqPtJ9p63FLmSzgQN+fPCX2b91NR?=
 =?us-ascii?Q?A0v0+31Q0l0+sHAR8BmxIX80S/zNx7TEkoLYo6LBcwuqmY30p797n0QQbUXq?=
 =?us-ascii?Q?waNbTMcF5GJ5gPYzLx+GJM3sceVDylxZKZOM/i2TNB/zp8+Cne39FCpdOWzY?=
 =?us-ascii?Q?m7yweo8xKyLqgVpZckI+SpEmJS0Fnjm5S2wl5Qh+R8Z1Z3BQolKMqHgf42ZN?=
 =?us-ascii?Q?8lCm0pZ19iapod8cXk0uBuDjNdpudz9BuenfXk4a1grIsfmlVO9FSwLKPQZ7?=
 =?us-ascii?Q?i44n3NHwtoN61dmgnhwIY+sajhJ1I2l7gLX2D654xyXoUwNg5wuaBcl8UsGe?=
 =?us-ascii?Q?mp1vFck1C2wAMTVNAVpwOh7mod8UNRAU7f0cVSB/YcT5/afXnKD4fV1MGbBK?=
 =?us-ascii?Q?fw/AKd2Al5VY8Bg6BfzNGasvs1CPeyMv2a2llRk3ueQfCwjCjzXMQZaD+LCh?=
 =?us-ascii?Q?gNYh8EXhM4r0BeOfO0QUkNuQV+U7hkyGqhaH/lMKiaN9uR7HbDlC+vxmfUw0?=
 =?us-ascii?Q?8MQ9VQDD+8iHftg1t4bKm1z6EUgumQqdx5rO9IDknbKygX+w1nMjroRU2PA/?=
 =?us-ascii?Q?yfrfU8L2nUBXC88fBGL74vw3rh2MbmD8I4KIFkxlum56C7GU83YMg6wsnvBf?=
 =?us-ascii?Q?Rg4syK4m2ecfs4Ka8onuXFtxvZIMD64D20INEQf63ojk7E5ZIaJxXh6i74NB?=
 =?us-ascii?Q?ZSGQZNa4cyttRe/6HZlqm2Pr0av1+YuceCsrIRxAGxxL5rcdTY5OzQ5+gP6x?=
 =?us-ascii?Q?HtpiONGQcL18Q+KN1lRJfCkeKEH5hElB/zulZbZsDD7kCltdomRc6plYv6Lr?=
 =?us-ascii?Q?gsvDIxWp9h2zH2ARE+sqVov6gfZ3O6Ng8zc5xN0A+Jmg3o2bskRfxoiMS5nW?=
 =?us-ascii?Q?tWAP3pTFng=3D=3D?=
X-Exchange-RoutingPolicyChecked: 
	JYv6tl8wT9vn2RKNsqldB7+R/41lmQkTqDic1XxXrL2bHQg6eq3a+vJdV6Yh+rFPlQGD6IZVmCXTaIrhkWx8axsmdzOWOs5aTozNMJUrogYuTY6URk1oWteIb3mtuHOlIltlFKniijBfzLfM4/Z2mcCSprJF4SrQagmExffQS0OwyPPIBK1057IGNlCrrt7UKYVBX+ZmoA326sJgH+CpX2WRSW/kdziLT8kHP/PHlAqMTMezyx+A3AluYNXRFdeQqpXsFhdoTgJUqdFhCyjX67ba35iQv01MCckuUEQeflrW3MnSUq3GziVA81nIKJfhPBZCsExSg32CYJDfJUXsOw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4133125f-25ec-476a-9438-08dead8c0b44
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2026 05:30:13.1361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q4Ce3tmn1uwQ3YVSXC4VQQ52LZwnMkK+AtQUY6DwG5jFJWfXreqZfZB56IbuG6NA//ZsLrCJye2TA4bpN1+tqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8657
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA5MDA1NCBTYWx0ZWRfX7CIE3zljAYPS
 cF3B608f7Gx56Q1+h8CtUsejdVNa8ClnAlW1wwVDN9RAnslebmJRpwxh39uJd/BXwYbjehBVmHn
 BNUrnZo2J3v//XsQex9oxdEOQeb7mx3PQEKvrhSX353rHQV+JeFhtW5dQUVfvEduUsDAM81Fpmv
 5R8FZ3EqApIXMw9aMfNQUpDOge8CpnzPnt/5zr/PaJKvk9VsstutvFlKaTRv1hJj+G11K1ScCtp
 yqw68ufu6YT1uoZ99VSm0o7gpOrHT7/64dKkQ323NLZinn0q9ZgrqMUPKJBndI99X3cu6IoUrCL
 UFL7rrEJBiZteWN0reiNySNnLxWQsTXuHj6JgWDQibkY7GCwOBGqQMNnoH+rGdFa3oveukk79oh
 zETFW/viWCeDt6/mtav56ie7RcIIL5L3iinKwCncAlxpBBFZiiWWlI7sb01blR1M4M6BgTkvXUW
 nFQP/WOwhuFvNSFQgCg==
X-Authority-Analysis: v=2.4 cv=d6nFDxjE c=1 sm=1 tr=0 ts=69fec66a cx=c_pps
 a=hdF+edV3qND9tYm1xB2jJw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22 a=t7CeM3EgAAAA:8
 a=hIPOLQWK0ZafnOV6iRwA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: jDU5WC2NNiPIa6joJN2MQBM5S6zdSTvv
X-Proofpoint-ORIG-GUID: XRuabJAuC0Oeny0aNRawwsmcHDutTR50
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-09_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 suspectscore=0
 spamscore=0 adultscore=0 clxscore=1015 phishscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605090054
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 09 May 2026 05:30:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19479

From: Chen Qi <Qi.Chen@windriver.com>

We want to be able to do stable version upgrade for recipes. For
example, 1.0.0 -> 1.0.1 instead of 1.0.0 -> 1.1.0.

To to this, we need an extra paramter to latest_versionstring
so that we are able to filter out the versions we need. Using regex
has the advantage of adapting to different version schemes.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 lib/bb/fetch2/crate.py | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/lib/bb/fetch2/crate.py b/lib/bb/fetch2/crate.py
index b89817ab9..6f0e656f7 100644
--- a/lib/bb/fetch2/crate.py
+++ b/lib/bb/fetch2/crate.py
@@ -14,6 +14,7 @@ import hashlib
 import json
 import os
 import subprocess
+import re
 import bb
 from   bb.fetch2 import logger, subprocess_setup, UnpackError
 from   bb.fetch2.wget import Wget
@@ -155,18 +156,22 @@ class Crate(Wget):
             with open(mdpath, "w") as f:
                 json.dump(metadata, f)
 
-    def latest_versionstring(self, ud, d):
+    def latest_versionstring(self, ud, d, filter_regex=None):
         """
         Return the latest version available when versionsurl is the [name]/versions URL.
         """
         from functools import cmp_to_key
         json_data = json.loads(self._fetch_index(ud.versionsurl, ud, d))
         versions = [(0, i["num"], "") for i in json_data["versions"]]
+        if filter_regex:
+            versions = [v for v in versions if re.match(filter_regex, v[1])]
         versions = sorted(versions, key=cmp_to_key(bb.utils.vercmp))
+        if versions:
+            return (versions[-1][1], "")
+        else:
+            return ('', '')
 
-        return (versions[-1][1], "")
-
-    def latest_versionstring_from_index(self, ud, d):
+    def latest_versionstring_from_index(self, ud, d, filter_regex=None):
         """
         Return the latest version available when versionsurl is a Cargo index
         file.
@@ -180,5 +185,11 @@ class Crate(Wget):
             data = json.loads(line)
             versions.append((0, data["vers"], ""))
 
+        if filter_regex:
+            versions = [v for v in versions if re.match(filter_regex, v[1])]
+
         versions = sorted(versions, key=cmp_to_key(bb.utils.vercmp))
-        return (versions[-1][1], "")
+        if versions:
+            return (versions[-1][1], "")
+        else:
+            return ('', '')
-- 
2.34.1


