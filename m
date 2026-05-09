Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F79CD343F
	for <webhook@archiver.kernel.org>; Sat,  9 May 2026 05:30:29 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6789.1778304619871642534
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 08 May 2026 22:30:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=XJbQNJiR;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=95895a8adf=qi.chen@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6494jIVN2286826
	for <bitbake-devel@lists.openembedded.org>; Sat, 9 May 2026 05:30:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=4GYnbJYsN
	u6tMakLuSMeRYquElI8go5B0OurvZ2Qqmw=; b=XJbQNJiRYNAQZ5XKA7sAfB1R7
	e6m+rXe38qiiueI/5J+fbqYyTHEVHGnFkTgpkoLAUXRWKerkkz40wnqvzA1PbnAP
	SxCjD1mVGYjNeQh2usJSho8JRLObeTtguMYfIh5008G29W7EF0dOXXsHig9GehbV
	jvkZYMMgBOhazRJFySyu+nTmGHDhsTPBB9qLhAZBg8CDE8eYvoW/N3zGoQ0Eakbb
	BZagRnNWIUIkQ3yOjeGZ/uVBT6Q2BgSj77utV+ftq95Lf+x3QHdPIwYOxTekC+FW
	o61Fw2ZiQ0+W9FIvtbwErbuE3EoDsrvRat7/awU2FmgHaY8CjmZrGdVDHxABA==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012068.outbound.protection.outlook.com [40.107.200.68])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4e1uw6g3xe-3
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 09 May 2026 05:30:18 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aSKOeUnGpcEK/oqH/Hm1zEjnikqAmbdr/FPRpA6zEiGcKhW2gTd8PesnWfX03nF+9uwJpKAOZU6lbmfi8N8jyynB+8CzWXRfmrLHiQYJxPa3Go/WDtMMIrFOLi6pVef53e8XSAPrarSkD6B/jtkRjlihq/XxQv+9udkgHTeZmUwKKEuzpgVHmOJaQGP/yN4GYnOtV1ImEfzykdOp6iuNFKKXvg5DZ8F3+DeOEvIhaQTWqpmBSap18lNQ5SQjx7CLejzSWoy+aaA8oK4/LqoIOdI0K2GkZFF9+YUregvBL5JQHT2RkLG3dH9QBnhvddy4fyTg8fopWBfCHLbwILI9NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4GYnbJYsNu6tMakLuSMeRYquElI8go5B0OurvZ2Qqmw=;
 b=OSIXUPwEWyvh06u5rDIVnCvdYpCSySN5I9HMcmcT3gh6wykUrF+jIzI5p0L6VGpiOqMIr8HMW7BPtYj/mmmMKrqhc/hS82wGwNTIihQqJnvD8A4KnMzjuHBhxOEbdb0gXEhhyUjZxa92BO/lWZ3OMIs0UMGQ+NwxFqy76ppqcS3neNj+9/zkdVa4Ljd4d+3lmQKbLcVY5Pp3lKBfa6BUVBo2fCbfm/fwYrHD9WtOL99YqSGlL8BZcE0HAkyezVG8kzQMxkv6jZe+1XTuDeCHnlodnf+A+XreffjVDyhpoBDwjhUZVEhSUG+N1c20KIn5ptn+w3WfS9h5+0vdwukaFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by CH3PR11MB8657.namprd11.prod.outlook.com (2603:10b6:610:1ca::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.20; Sat, 9 May
 2026 05:30:10 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%3]) with mapi id 15.20.9891.019; Sat, 9 May 2026
 05:30:08 +0000
From: Qi.Chen@windriver.com
To: bitbake-devel@lists.openembedded.org
Cc: alex.kanavin@gmail.com, randy.macleod@windriver.com
Subject: [bitbake-devel][PATCH V3 1/5] fetch2/git.py: add filter_regex parameter to latest_versionstring
Date: Sat,  9 May 2026 13:29:46 +0800
Message-Id: <20260509052950.1565384-1-Qi.Chen@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0087.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3::18) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|CH3PR11MB8657:EE_
X-MS-Office365-Filtering-Correlation-Id: 62bfb0d2-60e3-46af-2732-08dead8c089c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014|56012099003|18002099003|3023799003;
X-Microsoft-Antispam-Message-Info: 
	579aZkGtqGgmY0XRRmFIKI2wGqIj0/dfoKzy3457/PFweNAirZuxlLRp7zzWaK4IB6PUY2MaFNw+/hF9Yf8xvGD+9KC8O0zJLo0NGpw2ArExdoV7MjuDD6fYAA2dsJ7DvETGF5YuS4qTwS/ycRkikhDagqBFr8MUV18lLPhePFo+hlZeSD58ivLZ2ZFbbJ4dO/SNksVXaiQonOoXwNx7t6NcxbUl2eFEd/R5TDoY/laqxpH+Lved6fdlQ6ceNlLRBmfV5YSnXxwwh6SSNKRpTlWeMURxvqSwwvtv3YavD3/QnLh3aAPQJLtIMjLCxLxfD+II51pVZwgmZfROk+Lc6FnUk9QX6IRemvWNoSH9kJaUoHdggah7M7VqUA8WJhnHCI5A8XENnkgyiETV0m5X2czIsTV2+6PNlbATkSq/0ILjhFNRDkFxb1CWQPcg5IZQGUyeHDqilkNS6ccYF3eASDGW5lruaSlta9OCk1uEFD6sjbbI66Nb+stnvJ/07s76VCBMrUnhwFjNo8LadrZutxinzSUzg4dR3UPq7gPVYvyS0FzDNOm7gGMF7a0cRrVvm7SgneYqEiwBaHL7QkLQuklTazVI9yZjBra25UVeILpF3uh/j3XPfVJ2xPrK5y7BO1cGgCnR5SCFpvLT4MAqGTx1iVNWuR2mz2m+CHiiFEX5fdIRf9BHvbnEVRjbt8Gu1+D2xxVcW3NirMnH2MUlvitVjSNqQrg5zflU7fXXONfngDzKLJoJFGOEgPOu8KoK
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014)(56012099003)(18002099003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?zYXny70xKHxT0bFmDG6YWBktGuc5hHTlj0WNNLo0T/hndL2jRDm08sekdgS6?=
 =?us-ascii?Q?qY9RO8+385vCH7fqjwaQQM3rLUR6aunFSVEDrjLH3ZwRZyvkwvcD/+oEm2KN?=
 =?us-ascii?Q?lqnS088xvpxf3gILWnWX0kHnQimqxTwuHP7p23jFkrd9hjfo/jnQN12+iL0u?=
 =?us-ascii?Q?lZIYmGo7D3o0l7L5M6w6+rbFJpZWr41g9b6XZ6l++Oye8liQOpFSo1w92F+L?=
 =?us-ascii?Q?rN39+/jZqk9FfFxp1R3ghCDtmO2di4IMShMkN3LYQJPl3+C2ILv+ShU82hbf?=
 =?us-ascii?Q?EqXRqMjHaA1eP9zxK1pYetDubMJjvoKnPP2NUFy1Tb759nIvMDLNl4+X/R3K?=
 =?us-ascii?Q?ZbZxb50AQpTzZL56VNJf2D6WHw/MzBcQl6rRUHIR/nTJqVPEZWYEjnkFPLNz?=
 =?us-ascii?Q?mU0W7Q8OKZb2grOTmcp91URnD+1JrVv/MsN1luuKQDLUvaxyDY41eDovcBGI?=
 =?us-ascii?Q?DxsEgzO19+7bmP5XpC1HodQvDBBLFlzUq6AYzSstsn/fGf+HFZoXUP6rq/Dg?=
 =?us-ascii?Q?3527hzb3xmbCxNSkdnkokUh7OEG1zFxbEdHZJIn5hRhLKn3ZF2wnrtYCZIkf?=
 =?us-ascii?Q?kJy0wQ89aq3ds4O+ADh1BCLZacFikmt6BvZIspkvaUp9x9Sdx7WnK4+bwsMK?=
 =?us-ascii?Q?0RXWcw8T0Ra6l6tHvrQrqB57ZX1bwkLDL9tzF0NxcPgSij2ovVUPUrJ3pWLM?=
 =?us-ascii?Q?S890nM4FTqXPJGud69yx5jK3FQUSh/GxxGoG71tXGGDGPfANKERThBnQliyG?=
 =?us-ascii?Q?yjfOFM4FkNcOdkYrsJanglDBB5ZwA6q1lxsyIYh0wyW3rqynE8WIasWCB2mP?=
 =?us-ascii?Q?xPIEQhPH1c4M+fGwwJIBSBouZs34n+MZVJuVzdETViSiZOILhNyHMLHwgMTH?=
 =?us-ascii?Q?jvFeHjQ31L4gnDDLVbEwZhubz5ATRtikXEq+1fYrF5UgBt6X+wtbSL4CY9FM?=
 =?us-ascii?Q?dgmrXqJXLp031dyDXpUh/pmWnkRm0WhsDLGiHVm2FKoVEvRjZ9jAh90/AWhk?=
 =?us-ascii?Q?5uKuz2sMgLbFHkU+wn6iNQeGTVLqg4eAc8DRJHLB0PPUMGzVoWvpcAlqsLtc?=
 =?us-ascii?Q?35lsCRYvR6Mda3qBTbyZC7PBdYtewCFnPUda/y1ONUs24FOJGEVeR730eNT4?=
 =?us-ascii?Q?jxk7Nl+osiT0l1hE+lx+sK7bU6Hm9Ug8YjxTmfQr/4caIu6X7PQ9K+6JhWpJ?=
 =?us-ascii?Q?ecc9NnyqtdeuTE1FK28NPOceEPKvuw+ocPxjz28dKVtD664vR8U0oLIEe3k/?=
 =?us-ascii?Q?4SiTxr+CDZ4JUMW9Sx3oIN+bOifIUXolfY7TkkI8IbZwxoEO9pwCq87jomW5?=
 =?us-ascii?Q?9StVFEVHjgYwDI6zGWLOjiyDbJ4vnfZdviwtGlayLkt9wCtMGwsx2tl6CPgW?=
 =?us-ascii?Q?sXNl8vOa5yPzE2bus2R/zVv64qbsBsuDdmGVDnr5nJeSRDVxxA0n+naPtgP2?=
 =?us-ascii?Q?7Jlx1ZkNaA7oiyVviBRGbMK1cZ/6lomWLY6XuC2wb4G15j19sN140jNP/ut1?=
 =?us-ascii?Q?RXgCoRpfaYGz5bIrGboicvfFYjnjaDuh8Uvr4C1z+XVwlC7KjPxPmIVMTIUj?=
 =?us-ascii?Q?OODquIsp+MhpV/X4kzxhZfMUbanRw2hIrPwA/p9LR03G//pu+QQHkm1M/1F1?=
 =?us-ascii?Q?wI2J+WGgjuzWu/7riK185f6XuKZ89f/dDAJj8GdYu1nRHwTEIEHr390yVj7i?=
 =?us-ascii?Q?yex5/9yY7w2NgxJ0daonHPwbiIockjVKY0pckVVbhNI76nwVh/2lMu66Xlng?=
 =?us-ascii?Q?n+R1D240iQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: 
	LlpzJNUkTQvYsCTfqG92GEim1hsF8tgZ4iB3ZrMrhHuRUflk+1O9sZ6LhREEH21AFX9kdd38/YZrMAakkCpHJX8H5hTZONak5qCzUAJshvZ/OS0TeTTm79BF4sgqOCeFLVrag61Hsi5ozrAooqAqToWzqwXUzZWD6ogZISCG8jjQLUQ8KmuhWmgZqrZ/mjiNQiuxDAgpo1EnvhgjWvXp3NXi5Q38Jw7a91eC5qko6G+63L94WiGRuOgwDmFIxQoteQf1+nMsmAlG3YXrmfkEu6FLBjryKXj7ojSbLcgm1PYBSXO5/iDjxb3GY63E1FUH1Dz5cSj+FMo08PN+hCas4A==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62bfb0d2-60e3-46af-2732-08dead8c089c
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2026 05:30:08.7729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9joVriNaFa/c366dORB4mpYohytLxpA88sMfoyJC2jyFfLOUmXFCSBFM2NuZDnNnnIPkewbJ3XN2zFAsLbo0NA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8657
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA5MDA1NCBTYWx0ZWRfX5tlY0uPWktuG
 NySMTRGmDSmOxU+YURPPGhG0IGn9YIvbqfv5VbqpGoXg8fiMdEYKHykMtyIMpDQJ5OqfDroFf2Q
 yyqS4J0TB47uBXU8HD6i6DsoVNjeVLkWmpOa5GIPxWPUlvxFQX1eoW9o6T+YtUgMrvsCHB40XST
 ckF0q3Mbf2JFw6TI00TqUsDLE+I3R/y6bWkDNArLMKS/ylgkgC5afQWCAWp0VpxXiko++EDgDsU
 6GlP2um8r9N1EkCkCdgwprO8VMOJn1f8BZ7YjuQseLwQOZpDKGIP3iQMuWw/22zrzKXdilE7Jft
 5mCBwKZp6r/tDgzUy81lKDos+5Y+aqJX/Car8E6/lPq5w9eBpgHPkhcj7sJEBQvJEkjvUdP03Rt
 j5Ee6dL0tRovuToM9sIOWb9nx3edGRUSOPouYCAivKJpT+2cfUQH4KuDoKQq7rSomUtWYp1Ptzi
 uNaOEmah0v/rmwLixBg==
X-Authority-Analysis: v=2.4 cv=d6nFDxjE c=1 sm=1 tr=0 ts=69fec66a cx=c_pps
 a=hdF+edV3qND9tYm1xB2jJw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22 a=t7CeM3EgAAAA:8
 a=rVcF9mjB7NWXllDnQBEA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: ylF2_WiDQRFQ1Gc0OnbqdKNlp2C3MYLn
X-Proofpoint-ORIG-GUID: wR4qg7Czalu_xi2b7bWgohReO0Hfu0RN
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
 <bitbake-devel@lists.openembedded.org>; Sat, 09 May 2026 05:30:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19482

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


