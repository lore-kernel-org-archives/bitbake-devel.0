Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8992FFF8864
	for <webhook@archiver.kernel.org>; Wed, 29 Apr 2026 03:25:02 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3983.1777433100807217294
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 28 Apr 2026 20:25:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=fD867iVz;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=95795ebc5b=qi.chen@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63T2lxR81332311
	for <bitbake-devel@lists.openembedded.org>; Wed, 29 Apr 2026 03:24:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=f6AIW+pkTWJ7LtoBaolk8sr+Angc4tU9tRt/EcasLk4=; b=
	fD867iVzj/3qu/jkpsA6qPkMB5C3l1O6Zp87r7cCStlzllm3XC9Ga3/diqQ5Bi2Z
	e2mXG9wUphWxtFomRka9Jw302zOnnCQ7gjJIS3vYYbEZtUtXgrHhhvbhK+NYP3Yz
	ymiAmkBwwSQF1lO+cgJNFlAYzfB1HtPJfJHf0RubHxxjm6UyLarXN1QpxJajVGBW
	xYQXTOzlcqzomNwZlzyRkIlqyLQyUDIu4y+cDM38NlmnC0IBJNBtWNzTe5yqFrYv
	GoaU1LFPLdiU7S0rIifup0iLWeFbRYQXT5AF1eXsOJ/PLELNfgJ/c90Q8oTmBlV2
	T7g4TkaP5ElJ/HSG0RN7Sg==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011028.outbound.protection.outlook.com [40.107.208.28])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4drmk6vctc-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 29 Apr 2026 03:24:59 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LcylneIESgYk4b8OrQOtpqgI8g2WYapOqM9fP8FWqGNmaT94uvoGS6cZPoH+vG0I06xuVgiM9jgMZapWkWGaIGYGnkkg7KIP9VbuqbMytFyz4PRd8nmbeJi1vGsDgXQnzPN8hR58qZ6MZeSQ2VN8LjgGDnih/bfFalh2xQAAa4bxC6gXbjXued4VLDj8kl+7sjBXQ4SiUqKWm/OYr/9QYXi697gjASiaeq/XqYvNvj3O5jHRL1Q/NKyW7NkU1PLKDn9YuObEz1PKsHZv++TCiBzVKUoWYZXRYrgMDedPCvQO72/dv7m/5Emjw0cVqz5DD4gOrqNb3HREh9niWYo1sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f6AIW+pkTWJ7LtoBaolk8sr+Angc4tU9tRt/EcasLk4=;
 b=bth+7SniRzvDJu0Ul09xYh8ojhPI7yK8G+894n1NmkOQhysqOlhGLYZjoNDVtJdg4dIcCmm65+Z5Hr3N45a4sgddKsU2wXU2y7Vn+CaepRaSQ+E44w2dz67s9xdVewXQuFIqEQmSXUlEaWF+1NUdQKWHBCRwviWYCxdovDX3iZY00foyytjhRRpydvu2gZUh5iyb0Ju3CRRyRXZSCHw1DVPsnwkpot5oXsZGoq+52EcKmJLEt+mb7z+Hs0TNeVFs/pTfn1OJFqOII1E+RJuK3VHCeVn22h6JHzOAgNzEnPABE6WlAC5m187uta5k9uTW1x8WAOlEU/0kCjCED3b4TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by BL1PR11MB5954.namprd11.prod.outlook.com (2603:10b6:208:385::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Wed, 29 Apr
 2026 03:24:56 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%3]) with mapi id 15.20.9870.020; Wed, 29 Apr 2026
 03:24:56 +0000
From: Qi.Chen@windriver.com
To: bitbake-devel@lists.openembedded.org
Cc: alex.kanavin@gmail.com, richard.purdie@linuxfoundation.org,
        Randy.MacLeod@windriver.com
Subject: [bitbake-devel][RFC][PATCH 2/3] lib/bb/fetch2/wget.py: add optional major_version parameter to latest_versionstring
Date: Wed, 29 Apr 2026 11:24:35 +0800
Message-Id: <20260429032436.1075831-2-Qi.Chen@windriver.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3edcd294-6645-427a-7ab3-08dea59ee2d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|38350700014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	4tglDZnYJuvSEO0uRzw2dE2vrGoJY9MHBffZgY1i8KmKiuKAJF0lt9Yomcvdo5NR2/PbnmF2l2hJZKq7kRvJxQVKg7D6RzdJFQsdJB1w+CQW3IhA2RxJIro3tvRY3HGzCFWpfP5++6KI5nR1Q1fPYlyta7evsbjGccP/ACl8wy2nH+9YIsrTFLZz6ZBG/Pl/uGUIE05rre422Fpwc9oni9kYoGQo3IPqk/liJ28Dq1fdUsD6asK6kGOB1MhYy7dmiNHdN9gwCz8KbeFVKnzRwpFH0yGoev0dkiA3WJunQ2mEjuXMGWwcz4fyAc909mmeOzr4/0+LC+YHxF2kt0vU1hG6HHp0YQe9azRkKKQgehqVe02ufZX1Rt3PIYXzh0Wk3PKIW4wY7Q/uaNDsrPt9INNXD7O+Rv0EVp3RHOP30STVMFgwmSKMup5xwqbt2NMTJGMJQlPxYQi/g8urdxYYxG4xx70fY4zvSTtP0DOT7NumcB0AD3gudjos0bDg52uNCt8vdeAyfgwwX11eb6BF4eA9BngIT9ZJJOHUUVY3919RkXcqav2EreabYNDlCyMmSAIMX05naF8simAlP1uIVoNxPXdvdQ1NJDb7ZeRLJLC8bOkswJX5NlRRcPihYJLr9jQ094zLhWNhFkcIjDoIyKYb8ThiRNqGcZuhjmfsVwxgyhtSu+cBXIAtqiCJsQosJFtHxlzzK3haXIU5SUfJoFkwOyMbbWnDpwPUNWm/zrdAviwvJlEJ7/Lq/rb3ewkCPNvOZuJuvt8cVLSI1Eo5gEP2gSBYmLZkz3Gz9LYsRJU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?RBXyEvYgB7LFroEhJhAP6+C80Crcdzb2eM5DXi0YhqoZzj3mQwxGic9isfe5?=
 =?us-ascii?Q?id4Q9lDJyS34SjFjweFC27quGilSk25zkBoA5pVn+ND/W7FnRQiAcYS0t78R?=
 =?us-ascii?Q?QIiAFkiJVZc0DyjZOLGoQj1nUEI/ba7sN7OgNko50uhcjcWMwiT+pzin9NdX?=
 =?us-ascii?Q?Ghtn6DingJQLGuRKZkxjCUif6wleXq65P6jc7eld8+Fhf4FNbgkGlLTaZv+4?=
 =?us-ascii?Q?6tmHZJngAn5t45UqwegON390Kw1gY39HDtuW8zLpGM5Nn+j/+OE+IMppOIDC?=
 =?us-ascii?Q?gnYOztrlNea5ZwPUn9DF/XXFaJP5WCzhOVhvyIfK2P+1GrExJHn9f6byYt+K?=
 =?us-ascii?Q?SyueyPSLs3dPBGmcCVxwUlfvRo1gbMs71ubTi1WGhlLYPyO7b892PctXINbk?=
 =?us-ascii?Q?wGz1N+SIP29oMkccSr2pLTBaLNBy0G2G7V+Ti8e9JU5e3lXWgxzCvbJf8nLT?=
 =?us-ascii?Q?FJ8IDDW5D36Lz5mijvtSp9ewCLm646TWaPn1J9/r7bng47t4deB6vj3HM728?=
 =?us-ascii?Q?xmFHYJVuEyZ3rZ5VLkRfDO6ksvVuIacwpqnd0ykou4jB6N3gTNEElZpPgTmF?=
 =?us-ascii?Q?Aru16ilVfxXsiXl+piXCdRz0cIW4CC3/7oTi6ujkbFgiIzH2aUvo6/Fb36z+?=
 =?us-ascii?Q?qUGpG+Hh1JDH3QJ9piLqVxrKQg3gxdBFeqXI2G/dKSvgLZKZk2AzXrkstkJx?=
 =?us-ascii?Q?WWZw8fWcTv3zgkb1ljnyjyHWGATAUdCFSkd+f2Gi0pD8qAOXA+rMqodqUvRW?=
 =?us-ascii?Q?K2pNIcwm7cn9ZjrU1SyhaDeGfhdEz7jji3Jc+PdcYMrGZr4NToa5UosSsTkK?=
 =?us-ascii?Q?5RBYFxmQSWED2fFY9bTtN+Mm0LN16PpfKkhqrLXUCdwTV3tASZ/fFIhh6JFV?=
 =?us-ascii?Q?vRpWzW5PQNcht4HZUCC7FQ3m41rU9IH1PZDz4X3cIcnDwZMBimf/nOe7iqG+?=
 =?us-ascii?Q?Rv84i66k/vp3xJzzT46Jq9KrFB1BrBWJIKJdriPiEIgcjIEiwpDLRAT+WiDe?=
 =?us-ascii?Q?eFTgMVQxxs+meIz/e26FCIs/AQsNAY+gbEe31bk8KaHfB1XwUReB9Gg9ibT1?=
 =?us-ascii?Q?JQRBO7Sa+8pTmcXAAu2f21Hn5SAaJeZlQ+umX/+araovfSHTbJ54S0/NXcd7?=
 =?us-ascii?Q?9IBkufBpooo1Zd1sM1kmN8c1Q4Voj6uT7uDQ39PcqX6vH8KeeOdBA3IZlOrE?=
 =?us-ascii?Q?rFfk6RjIczMEJuaDEXZl8RexntE0sTjnZm48sdAivuHnJgcaHkXhhqG/lZ/G?=
 =?us-ascii?Q?6JZf4rXDiLaA1GOilCqVeFpD5YvjVdCK1D9zYHk/N0xpeqe7mMGE5gZRA4mc?=
 =?us-ascii?Q?FCT9r0SaOsZViuqVNn2yoHFZTh0Y0gRznHne543eI6+NHwKNPpx+sGfkLqNF?=
 =?us-ascii?Q?eJRcIdvHY8B420oiinFvAZXCsgn+BCMQpfSz/IxjAWNUGN43B/yacRBszRwg?=
 =?us-ascii?Q?EIJWlL4DHGs0TTLl00g8DNuTX9LMWL/LffnldqcPl98MMCRlpgTlZOxV8i/t?=
 =?us-ascii?Q?+7F3on5GM2ORxL9kFgPdXtgSn0V+gQRgLS82TtLapsSzw1aI4XRQ0DUBmqJV?=
 =?us-ascii?Q?uWqUAnPkmoi1/kS0AnqPWV75Vd6lrw+huF6VSN3mrYOvPZweRNHNCfWuE1tF?=
 =?us-ascii?Q?Ln2x73r4d4q0IweV3/6nqgSghDzkdD5RwEBgo2MkqlVHj3g4lrpspQvGlbHE?=
 =?us-ascii?Q?8X1A54TWWYW+exhy63rit9qv61rHdr2opPQKQuQi/wtufVEWd9ETgUzMHx+B?=
 =?us-ascii?Q?SZNqnvuBGA=3D=3D?=
X-Exchange-RoutingPolicyChecked: 
	Ehr0+6XInfWi+JYaeR0zjIR7wf5ylZsfUKSIgO0YZ/nP3rxE0iVGzf+hYiYwDTuPQXP8vB0r3Lld4tHpnHcHaYacWx1OPtvlk9c68x0ww39JEcmSwZVTPZ4PszDYPCGnSfSk7H5je+eWMMRI+tyLQQsJDQo0UQ3ZkPWFw6emRW+xx+NHHCtJFRD8y2VAvN28n0MSpGsKpwvj9V5rH01HXNjbvwIJnALi1uQNVXE7wMp2b75ObkzdOkPKQoEYM4Mog8PSdI3GPNdOHjFi2GAb98qJ/VuhSkqK/7K1z/0PvSgV0PgtFMOwZ1D88WlqGTS1E6YULHWkRbocCwQhcTsoQQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3edcd294-6645-427a-7ab3-08dea59ee2d8
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 03:24:56.3964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NhyIBpGKPhaEEFSqhIiw5o95IvaIv+PVsx6hgf5NC0F5ICTFyKjHEsWA+RxsBJnHLGLSyQWezC1F+NwT7E8xRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5954
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: pBq7rjncRZTy-R0lZpm_iAIfGRhJNJQW
X-Proofpoint-GUID: dFrUFNWswIj4woF7oyudqofWjqvSsmTt
X-Authority-Analysis: v=2.4 cv=RN6D2Yi+ c=1 sm=1 tr=0 ts=69f17a0b cx=c_pps
 a=r8gZD2gelFFA3OdVKTiE/Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22 a=t7CeM3EgAAAA:8
 a=zn5JUfJC_tOmDknYn7cA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDAyOSBTYWx0ZWRfX8D1Lf3NjzH2f
 My0GN8a0ySrxhHpw+RVwihCcRHCMkyuAVitIYNMoWlz9UkV+6hzT1i8wJGThNZxiQex7YIyw+7R
 pGPhRHMY9A5mctKBzsKGe8P1XKvk6u3PtShfbZcH6Fyis8oJO/dF9IWsTIaAbdZ5LKXKziMEZj1
 AX7xSfJ5UMxEyJU/+L+ODTPyJB+VJCdoehf4u3sbAP1L+5nLjHGJZavDr1FILPTosDXBGB2DggG
 CcJr+l5D+sMKvZCnYXLrykFu+FZMw1LCwsG+G4hbP6c2FE/Pev3iwrKhEX4o14GnnXZL3XFKUw7
 CnhBUqtejvtQzwJi48LMhKqeYw8xTIhci//3Ez89CtkodmZO0KTfRECD38m+8H+hFubftDwL3SO
 qC24nia0nuXg64TcoQKhamznnav1t6JxXlQuyHp7Q3JYu0jVSbx0ARuZbjpxa9Uunj5gcQWswMm
 2Od0UNAin1cNjVLWg1g==
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
 <bitbake-devel@lists.openembedded.org>; Wed, 29 Apr 2026 03:25:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19409

From: Chen Qi <Qi.Chen@windriver.com>

We need to handle the situation of LTS upgrades. This means for version
such as 1.0.0, we need to find the upgradable version of 1.0.1 instead of
something like 1.1.0.

Add optional major_version parameter to wget fetcher to support such
case.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 lib/bb/fetch2/wget.py | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index 6ac4306c0..86d0a604a 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -492,7 +492,7 @@ class Wget(FetchMethod):
 
         return fetchresult
 
-    def _check_latest_version(self, url, package, package_regex, current_version, ud, d):
+    def _check_latest_version(self, url, package, package_regex, current_version, ud, d, major_version=None):
         """
         Return the latest version of a package inside a given directory path
         If error or no version, return ""
@@ -515,6 +515,9 @@ class Wget(FetchMethod):
                 newver = self._parse_path(package_regex, str(line))
 
             if newver:
+                if major_version:
+                    if not re.sub('_', '.', newver[1]).startswith(major_version+'.'):
+                        continue
                 bb.debug(3, "Upstream version found: %s" % newver[1])
                 if valid == 0:
                     version = newver
@@ -532,7 +535,7 @@ class Wget(FetchMethod):
 
         return ""
 
-    def _check_latest_version_by_dir(self, dirver, package, package_regex, current_version, ud, d):
+    def _check_latest_version_by_dir(self, dirver, package, package_regex, current_version, ud, d, major_version=None):
         """
         Scan every directory in order to get upstream version.
         """
@@ -576,7 +579,7 @@ class Wget(FetchMethod):
                         ud.user, ud.pswd, {}])
 
                     pupver = self._check_latest_version(uri,
-                            package, package_regex, current_version, ud, d)
+                            package, package_regex, current_version, ud, d, major_version=major_version)
                     if pupver:
                         version[1] = pupver
 
@@ -637,7 +640,7 @@ class Wget(FetchMethod):
 
         return package_custom_regex_comp
 
-    def latest_versionstring(self, ud, d):
+    def latest_versionstring(self, ud, d, major_version=None):
         """
         Manipulate the URL and try to obtain the latest package version
 
@@ -678,11 +681,11 @@ class Wget(FetchMethod):
                 dirver_pn_regex = re.compile(r"%s\d?" % (re.escape(pn)))
                 if not dirver_pn_regex.search(dirver):
                     return (self._check_latest_version_by_dir(dirver,
-                        package, package_regex, current_version, ud, d), '')
+                        package, package_regex, current_version, ud, d, major_version=major_version), '')
 
             uri = bb.fetch.encodeurl([ud.type, ud.host, path, ud.user, ud.pswd, {}])
         else:
             uri = regex_uri
 
         return (self._check_latest_version(uri, package, package_regex,
-                current_version, ud, d), '')
+                current_version, ud, d, major_version=major_version), '')
-- 
2.34.1


