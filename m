Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88AFEC021BC
	for <webhook@archiver.kernel.org>; Tue, 25 Feb 2025 06:49:29 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web10.2805.1740466161040233192
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 24 Feb 2025 22:49:21 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=41510c6688=qi.chen@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51P651Wb019708
	for <bitbake-devel@lists.openembedded.org>; Tue, 25 Feb 2025 06:49:20 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 44y5j8b81e-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 25 Feb 2025 06:49:20 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WzydqIJagdNCH1ty/fCRodzW0EJ5KBE3ScUz+Tc24Lko/6zbWOtAOZbUmwLU+7C7hJmb7t661tTGOtEhbetzg8zeD/oYnMSsdIQTP+9sLWFE58xvi2w0OaGl42WnJW7uP9TeawpgAl5/EWr9DiEhSULlAYb+jeOat80QcIW5/RcPtHV6bosIg6Bgojkns0GJSi0m2zOugkWtNtV33F5O1Rp3w8g/r3httUQxV2uCYYw7amWwFiUzsIgYqM6G3EcWyPmduLQaXvQRiLOM6pu+6WOdkDDt7o2h4bTK4u1JQwiamrJ88gxHogJd1gaI+yf2Dl8Vcu3h4cW40zXVEoPMGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4WVVcsa+S9paJRTkhj4n11SLYLzOhWRhrBDkdiLEJWw=;
 b=wZew1LKGDVBrH4I9/vuKzaSG4/75xSBou73CV0Fkzhv1yPvY3Yyc5ERUZESTfQ0XBYByBJC70NjuEuB5G8/O+wU45OPqErPR/mKgbjqdVGk+W7wmL4yTckQTO3/CVh6XWM25R5uBwGJoclFklWXeAi4zv9c8MFudMSDL0L4Rk2TbS+d5Yl1dnIZpHb+I9+oBHt4fdKOJb/VhTjXA4xACBWq5Uo/sLChybEI4trp3DSAoCSVrXCGmmfaaDRWEe0Y9Qjnocj0FYR4tYy62Lrj5sA3ZkHN13m/UoQvKU7Er/wyTI2rpeudkds5SfXP9c6qYWK+NuIcVZMKbge2soSOZ9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ0PR11MB5613.namprd11.prod.outlook.com (2603:10b6:a03:3ab::12)
 by IA1PR11MB8829.namprd11.prod.outlook.com (2603:10b6:208:59b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Tue, 25 Feb
 2025 06:49:11 +0000
Received: from SJ0PR11MB5613.namprd11.prod.outlook.com
 ([fe80::615c:ca2f:d093:16a9]) by SJ0PR11MB5613.namprd11.prod.outlook.com
 ([fe80::615c:ca2f:d093:16a9%5]) with mapi id 15.20.8489.018; Tue, 25 Feb 2025
 06:49:11 +0000
From: Qi.Chen@windriver.com
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake-devel][PATCH 3/4] data_smart.py: simple clean up
Date: Mon, 24 Feb 2025 22:48:52 -0800
Message-Id: <20250225064853.2406575-3-Qi.Chen@windriver.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250225064853.2406575-1-Qi.Chen@windriver.com>
References: <20250225064853.2406575-1-Qi.Chen@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0113.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::28) To SJ0PR11MB5613.namprd11.prod.outlook.com
 (2603:10b6:a03:3ab::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5613:EE_|IA1PR11MB8829:EE_
X-MS-Office365-Filtering-Correlation-Id: a661ecfe-3229-4ad0-06ff-08dd556880dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?qvlD6o6gIVTqX3nkIQj1hIGU3Na/nO7cP0YP3RnQBfmb0kCU5XISMTOCOmfX?=
 =?us-ascii?Q?D3J7IAdUbT6epkAKiS3dzw/LKTBqfcWPbOKjwZQoL1Asp5HJxaN/t+BcDJO6?=
 =?us-ascii?Q?WPN1jMBQ2qE3j4NUHfqVjBqqQXNdloh+O/UwQSpQtq21n8zqf64KcyEPqXpV?=
 =?us-ascii?Q?z0rtESFxiY1kXLuq721UBaOlNdBdISTwsts5MAexR6VoYZVIQuhH/SzJj6ay?=
 =?us-ascii?Q?QqIHyv1ZrQSPL0dIz1NYM5ukEAlJNcPDac8/k3qxYuSn4Uygu9gsJ+rFz8Yb?=
 =?us-ascii?Q?ObH0zC66OhLOrmy50C4W7fKiG6u5qtKR0BwMpiBtwLVta+rSaedYqD9+MFTh?=
 =?us-ascii?Q?BX4iJrN1W57Y6sQZwLAdyZrWu2XexHoUe/zMsAN2cNPMY3a+r9f11faa/7Aj?=
 =?us-ascii?Q?fNqFVR4UyI1sCbXq26K8fP82K1jG5JH8atmJ/vjdte3IYPM58dtbvTerDCrB?=
 =?us-ascii?Q?RHeEPk+hTioRLbRXfNMxgDpTTw2IMcv8LtDCMsZmSIO0VAxYArc81R6NutmF?=
 =?us-ascii?Q?T3YaddCXrDOlN/wBb70j9gIdvxVkwTRUbdWN+rxXsUowAkpZ0QLaICqPJ9Om?=
 =?us-ascii?Q?/YmmLD+YAVbwjElwRh5nxPN0V5BVIIQAyVOAqkZVQkr1c19FPc2Drv4CD3ER?=
 =?us-ascii?Q?p0BXeDzYvOd2kFfdcG/qTKiD3vtEym7EQTswRFiXIGxOPh8VvSW/cQnSIkdr?=
 =?us-ascii?Q?Ggq5M3r6wneFJex9w7sPpz9G48A8B2f+HJTgj0xrT2FVgs5JW8vU4xL+34do?=
 =?us-ascii?Q?wNyacXIwLd1lf1AS4O28MN/OPhjCP5Rw18uf2Z8+6/SreKvVPNBVEEl6Myq8?=
 =?us-ascii?Q?o06jAjWRVvw7rj/saWJWxMFUeXNPwRbQWwFJ93/tqALiAcAQstz7P7uK1wpS?=
 =?us-ascii?Q?rayOrfklZHhjYrgCp/zfNTjVfmviF6mbYgIdt7iIc2FmPdki49KS4EUIzCUs?=
 =?us-ascii?Q?inEdRII/k652APiMIOcHbL5UOEJ4klMuAXFtZeCk3lvB62qEC79C8E6RKWED?=
 =?us-ascii?Q?Swly2AMCFAyTIbUn4X+4/nqBxzYg0oMoCK41UsAogyQO7AgONjwYU7+HUoXI?=
 =?us-ascii?Q?LCo5XJLGuVLqq1fpgdpSWTCT1fYq7FVlMEzdwTBnlp9n7kl2RrukOwVdTnpR?=
 =?us-ascii?Q?tGbfCHAVGXQJ6WGb8c5KckOR+WaiYBDgWD0bBTcccyXhAp5FFBPdl5l1TkIO?=
 =?us-ascii?Q?8iyELNPtmK3n8+J0zdpolEaAbbKPeA7c0EmIVYTcL5r506+JjGqcoI1mpPeh?=
 =?us-ascii?Q?qt0MJzG84WB+HJLzLOICC0LZq9xSoYsLdxVoll6fJsofN5DnvLE5UHOFrjTT?=
 =?us-ascii?Q?AiIn5WSnZL+7WRbW+s5jnc2fsrr0Kt8ETR6eap6FX1gfDHIaZZ8LvuSAyZTN?=
 =?us-ascii?Q?HgTzoR2rpbdF9T4mi+6/ah8c6p5xiLIuCcIYn5X+IWA3T1odDPanc/IlWWfj?=
 =?us-ascii?Q?85Z8Bk3ifpOVXHlGjtnyH/kqWj5GuToh?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5613.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?PZeE1NLJN0TU3amC09VMxXfxyyV2ub/Am9IPSecqRmpbOycbj3irGpcvhBNj?=
 =?us-ascii?Q?Fx+WzFX5nc+xrgX6wfm7f1oBzt/GwGd1i1Qa8GD+Dy+8iBi7IGRaJl1imN8L?=
 =?us-ascii?Q?IIJjOivf4eRmXd0K6QC0VXxQkXmjpYaZ0cpfo6+6pZ88ASKGfvsRMH+4Rzcr?=
 =?us-ascii?Q?OSIKyNFcYQ3zJg/JThVWnyRT2NQHv9pkdj+rqaSNennMBNznYDDLOyRCJ5Z/?=
 =?us-ascii?Q?IxSDj++byuoIHZF4Lo/7x3JoNHO6ssjnuUBsooNNtu26YiBJgrKvtyTu4ZOw?=
 =?us-ascii?Q?AtwfVS5FdrsXdYqJHHaO8CKQdeeD5og0Pjhz4Zw9P6W6pPZy4u8WmamnYBvh?=
 =?us-ascii?Q?LQnIlGicAVHF/gcr6iZg1tOjGLe1GaRY4vFNq8PqnEvapb+BmPl2msJJjyek?=
 =?us-ascii?Q?6CvCrwLzOY8OSkP/+fN4ldJoRVEKKzu32XbKNRbvEhLgcVilwr9q4RBwVwlK?=
 =?us-ascii?Q?UezaPmRDqI456fI4EH/sUpzxA9I7VoyFWaLaFwn8t/QQOrvk92bHnnccssxk?=
 =?us-ascii?Q?5dDX102m/O74UfmdsviOG4lZt8L1Jj9paAkHclpCAVst+Z8f8Wo/uZSTB761?=
 =?us-ascii?Q?nML1nyaWxzca1NFlzpGSMwkZwv2mqgQv+pRyppqUr5V9nQokP5l5I1rT3ObU?=
 =?us-ascii?Q?3Tkc3fP42reRB7SnLOjOyjoIpW0BWnWnm2bymXV+Nt1cvMJtR0AScYK7PooO?=
 =?us-ascii?Q?7tcPBwTRZYU2aviwDSJSAot3RYSkyeYBrfqRJ9//wlqvFbbU9xJz9XtsV3eg?=
 =?us-ascii?Q?tShhKiW6489lPJrCJ57t3fxwo3wdWGrEOothLsOEumFa9l4ZtYPcXCD8plLG?=
 =?us-ascii?Q?QvFIOEaiKxS4vmcto5UJLdTLUR/b46w8r6FnslSPC+kfcRk7yvdoidMYQEiH?=
 =?us-ascii?Q?AtivhQRTGMWKDiaS22xIoA05FST1mhLoXMjuIllfXTC8JGNXrfKxuLCqrjMI?=
 =?us-ascii?Q?VYL3BbUcl7spGpYmVtmf62693201ZfhdYMxGtiwNgtfzjl+YxminiXij5zmx?=
 =?us-ascii?Q?P9pfnDaxrg0Zh9Dl1CS4zyNTUWCDiY0j131JXyuzJNe/kgeaRKcZSrs3Ov9K?=
 =?us-ascii?Q?lSvdW9aMalMeLYfzEnhZ09XGSwEWdL7Ctc8rS+x4QgfY4gAYMtZCzSLXyQah?=
 =?us-ascii?Q?dB4Nr7lNcp3aj5biDi5sgQAl/yobJo5p80L+AUFFyAaE8FtQdzxhFhjrv8kX?=
 =?us-ascii?Q?KklKnw8iNltq5GwsVoNfzENDHtJvNnYyA7JG60MsyfkiXnthdCTnt3Xil84w?=
 =?us-ascii?Q?TtTgUXJO3z/c+at8cdOKYW+KczhBjxT/E1RBAc6AmzlaR3YgbR0AqvP9udFg?=
 =?us-ascii?Q?XF2NXbcghs5OHefX2DgtoA2TaVvBr+SFNHxGbje3gqODk4aMm3ehh2SBq5Vw?=
 =?us-ascii?Q?N0ixssSHSetn5QelOk2SsnCA8z1rSwHuXpsUVAqHWYqlDQwfJfoVPL0SwDG5?=
 =?us-ascii?Q?g48qeuxf5qPBbsFFyFu2TttX04qFNRRIZHGgxD5KSRydDmIEquh7r2LopnN6?=
 =?us-ascii?Q?TC1JwT2t5ve34FSsvJCTRTQHCI8fRhmuc/bOGyPVp9J4S6c3XVJHL05ZlqES?=
 =?us-ascii?Q?RjeLzOtVoV9uPmTv2hP+Jx/zOqz7hE2XXuS/XgVeOYjuAfmXjQS3rputqbsI?=
 =?us-ascii?Q?rw=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a661ecfe-3229-4ad0-06ff-08dd556880dc
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5613.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 06:49:08.4864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: saAkp6GxUbI34/ls8UMo37h1sDxxEl4F9DXyUWKLxrqCp5T26JcjQujb+6jQMqDZ2Bt02xPWylbZFcLOCHq0Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8829
X-Proofpoint-ORIG-GUID: i-s3ab4rdcmDyxeqoNdouLc-0Kj7_DMI
X-Proofpoint-GUID: i-s3ab4rdcmDyxeqoNdouLc-0Kj7_DMI
X-Authority-Analysis: v=2.4 cv=U+ZoDfru c=1 sm=1 tr=0 ts=67bd67f0 cx=c_pps a=mXs27GP3B2XOU+bPH1EGlQ==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=T2h4t0Lz3GQA:10 a=t7CeM3EgAAAA:8 a=XS0LdqdSyXoDj1xovJEA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_02,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 mlxscore=0
 spamscore=0 impostorscore=0 mlxlogscore=860 clxscore=1015 bulkscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502100000
 definitions=main-2502250043
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 25 Feb 2025 06:49:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17300

From: Chen Qi <Qi.Chen@windriver.com>

When var matches __setvar_regexp__, which has the value as below,
__setvar_regexp__ = re.compile(r'(?P<base>.*?)(?P<keyword>:append|:prepend|:remove)(:(?P<add>[^A-Z]*))?$')
the keyword will not be __doc__ or __module__ and var will always
contain ":".

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 bitbake/lib/bb/data_smart.py | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/bitbake/lib/bb/data_smart.py b/bitbake/lib/bb/data_smart.py
index fa7ddef74a..caef93ff4f 100644
--- a/bitbake/lib/bb/data_smart.py
+++ b/bitbake/lib/bb/data_smart.py
@@ -580,12 +580,9 @@ class DataSmart(MutableMapping):
             else:
                 loginfo['op'] = keyword
             self.varhistory.record(**loginfo)
-            # todo make sure keyword is not __doc__ or __module__
-            # pay the cookie monster
 
             # more cookies for the cookie monster
-            if ':' in var:
-                self._setvar_update_overrides(base, **loginfo)
+            self._setvar_update_overrides(base, **loginfo)
 
             if base in self.overridevars:
                 self._setvar_update_overridevars(var, value)
-- 
2.25.1


