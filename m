Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE73CD4851
	for <webhook@archiver.kernel.org>; Wed, 13 May 2026 05:24:53 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.902.1778649883787965963
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 12 May 2026 22:24:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=hT1ugXih;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=959349fd7a=qi.chen@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64D3xm4B251624
	for <bitbake-devel@lists.openembedded.org>; Tue, 12 May 2026 22:24:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=VIofwERzZ
	MzjzdqzVnByKR0XgdOpHiPMi1urP0wfR0I=; b=hT1ugXihx9rUZLw7Z5x3TyZV3
	J+SDr3XjHgCU6snRuzPDZhPgJCjngvdczSe+uHeE3OuLT0wVakVAytDe8tf1S8rK
	awmGN2ZlK7ieDcB1bH3H+mhOzQQJIRZXbaN6OMTPDp53vN82Rdv5ToPCx+u0xUXi
	lvYLFbwv4pmUX4xbHZO7zsRJYd7oOajoebnIlNCqhvGuH6gI3reMreUv7Dwsswcj
	doBedNlyE/X010j1AYFfHgDVdJ1AWlioHJ2nPkgzBvW8BiyYU68uw7vKqumzA0dZ
	EYQx4LRIT+psPHfPu43JCdQkzkvKx6LKVvYh7vZWzqG2lJ5rF32zyAvX+Il7g==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013027.outbound.protection.outlook.com [40.93.201.27])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4e4ftb873e-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 22:24:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kkxK16lzvZgBKo9C3kLMZ7uRNh1fcYb/sZeyqMou9Lz2VACqlshw0JUBZUDKTbyukmoSyIy9TzXkTWOycnbraCwh0uNZX4V7NEkQTOYBB7SBqsU60zvvzlxn4h+VXsuuNI1z9jSanE8pddKWBY+Ag6S5kE1jrAMFxFZMFo4k8EngMq/6sdv5MFV7MtMxHP6Ikwz2EItC4W9yd1D+BUUhmjrKu6B/LD65NI9/ra86Ub7jFlw2XJHbl8zihbZ98N8DJV6EbS2XXEPLCUzTZM87SF4fahHIzN6hvXT+OTe129Dc4s7G8Ob3Yz3nYpCujjM+9cxDkevpwpWBqndecg14Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VIofwERzZMzjzdqzVnByKR0XgdOpHiPMi1urP0wfR0I=;
 b=CpnhfoOQQ+M4xjGtlWd2MhQpIxZfWz7h8vdCAWzl266bwNlQbfaSP8F0Eva8f9PGjGyLUtmi1zBza+OkVEaXDkqPudlDFlS5SvIXA6Ppgx4V/VieyRA5Mcx4I1+HGtZ6rO36TefkTvWyahojfA6+lC/TNY0fUL8DSec4Pz3oTNA+y/PmPVOfkXMjp0NP2hl5i2z672wYco9vsFbt3hL5RIR5/fRcvSqpvPBM4eglPw67XsbvaBKqHC2So/WcA+uwedeMxgKRN5mpzYo0qtgtS6khxHfG9tFsiTEOTp13vWFCfVutXEQW6fNXa5Wdx8FHXKXDBk+QHbSVDSlYQhFpEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by DS7PR11MB8855.namprd11.prod.outlook.com (2603:10b6:8:257::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 05:24:40 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%3]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 05:24:40 +0000
From: Qi.Chen@windriver.com
To: bitbake-devel@lists.openembedded.org
Cc: alex.kanavin@gmail.com, randy.macleod@windriver.com
Subject: [bitbake-devel][PATCH V4 1/5] fetch2/git.py: add filter_regex parameter to latest_versionstring
Date: Wed, 13 May 2026 13:24:20 +0800
Message-Id: <20260513052424.2271877-1-Qi.Chen@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0179.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::35) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|DS7PR11MB8855:EE_
X-MS-Office365-Filtering-Correlation-Id: 289f9ea8-9066-42bd-a1ea-08deb0afeec1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|56012099003|3023799003|18002099003|38350700014|11063799003;
X-Microsoft-Antispam-Message-Info: 
	ddPh1fjkLgKwBlcWgRuPTdeXlO4gjfEYRuDgCP/VWmrys2K4VY4IJ2d3G2k+YI6xn4y6u1bJyoZZVhVm3w7An5d2KcMOGEY33sN6f+nCPnGcYBgGakKKzJ1dpbSlitzdnN39tHWqH/UUla/K9fCa/aO5zdm25zf2cqXeGvuTKuYhQ7KpVpDdH8pPX2qIse/WVieHaP5j6uEtlT6+zVYM/kcscMhzZQTb1HShc2HR1EPMD7V2OBpuW7syX76zCOUSO+nFjD2VGsk9X/p13Ov08GJtPjyIGut3W3c1sa9pPdbpTYK+ccRTaJzuWB71n1JsmEuxXE/TQATm3ZxUmJi61YGro0IjzoF4FZP6rlp+OvyU8QYqeh6cIx7lXytSWsXeA/PISXtkcpKLsJeZ4+g9No+LkvtKxMgwcbruuujtV3+6FSGfV79rcWWyN7xMI1+F1GkMzD2i37DAlH44KvkP4yR3lCagyKqGxAMbcawRSUFtpSzcw06X217nChm7kfS2Mk4mzs/wy9dlYalgzqKGMTiqHCI3wwV7N2j4EqN37vTZwA0NVb6/H8NffkSfRqG/0dvKxNJgdglSvBNcfGojaABrtzQeRyef53Lx6XyzAUNosJ0QmNW5glNIApR4vL4YkcAW3lcjVmDKzWggHo0Ne3dJqhGa6TFa8fEY+kzUA31nXXBnQQBmnahCr8aZOZ2bUVeXXiZD7htaTJ8orrfKckeiSGtRnO7zF5zqT8FeEz224MRxV3MaBMjGLIKJj/zx
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(56012099003)(3023799003)(18002099003)(38350700014)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?I0vq9vXZV14gzcL0Enz59aCOjt5ShQvLBph7j5bzYCEwja9cqnIUyiKxJx2n?=
 =?us-ascii?Q?7B7WV5NNYajBv4t96JvPIRFOmFYNR4L4d8b04om1cn0VMI2Qbfra6iqAx8L0?=
 =?us-ascii?Q?S+xWEhYNzS13LF+OJ1EURGGsxj1AzEFuGH/laQgKt498eA1OVa8+8d4FYi9K?=
 =?us-ascii?Q?pbj/9HSqKQlyTPw+1M+fn9zVjN1jwufzE5I59wPAGZoGwJ70cjj0YcF+n51r?=
 =?us-ascii?Q?RNwcmknETMtDeGSkxL7RvrGcGew/SwBeoshpqU8dChKqQyhEFYCVPgBrnga/?=
 =?us-ascii?Q?F7mo6J9aO3obU4mls70NvbBKU9enB9UmKtwMfHTN3bX3Qh6ZFhBD6uFMGS1o?=
 =?us-ascii?Q?kClhO982lp0qUmT/1kipbkjFJ7/kmruHwKdeNpco198cVf/7ctqWpJkr5VHb?=
 =?us-ascii?Q?6dGCSopdI22BIfPMTffk944NVijP00tmscEuE/dX8kNrbVeTP7JCVCAA8C6u?=
 =?us-ascii?Q?dtrkjfKXVYmELCxprR8MN0pO7dPreye613dK28EI2hA166Xen9hbnWNET3U/?=
 =?us-ascii?Q?RiZyGFdRAlUAPUMqXaKlaqcbcrnxGBpuZHsf9WyHzqP3a4mCX9VsnTjHbItY?=
 =?us-ascii?Q?PXJn8TKD43Z1m9MzASJFJBCi0G0jFVbwfyC49tVQ2fFjtouxFk1fobzUx332?=
 =?us-ascii?Q?QeMNI4IpsoyD6Xo0q2qcsVuA1ZFT+ljzYE+eBLUaSpU11izP4uFMArdERMtt?=
 =?us-ascii?Q?bi8AZcRNNp34IHqPbrt5OT7WRj8QyejcKcZbDUlrw8PF5Z36tMWcAYRm6j3G?=
 =?us-ascii?Q?6gUOdtu12gQKzNVqQi2CVZDZyfEdaIOmidoPHKx6M89l8txnm+liFkq7zHTR?=
 =?us-ascii?Q?IuAe584ncF1FVmlAAyzE22Om97O/uwaxQXSv3pF3lxiVjNAiBWrF/T91k9JJ?=
 =?us-ascii?Q?JP8YkZ/BDHidtm++9lVDtQSPtcVU09IBEBKEvH4wTEQNGgcX2zImJIlL4WE2?=
 =?us-ascii?Q?AjGgiEbKpALkjmZM2DsAI2sPOloTuunrs3OLEOZU+nu4gR6mklffSaIjfHBN?=
 =?us-ascii?Q?g6WSqnRE49e2OLGUzzaemfGqOBJ5ycpQMftc/LSihzvk+xvzrivyd2CiCY8g?=
 =?us-ascii?Q?Gs7TvyPt8DgZSVNtNQ4OlUL+/TC6IIx4SwGok2zHecXKbmx0AUXD02L2SJW6?=
 =?us-ascii?Q?hsojlrR/KW12uQ6Tel4D3h5QWEtvtJnG0J0t8p2RYKSlBBqDpaMHT3FoLHxB?=
 =?us-ascii?Q?41qmkhvP8izEJlScvaBef8WQ00kicGlbKUs0FueNv01ayYQdm0Vxb3zPPEqF?=
 =?us-ascii?Q?oMzABCUVkD+az878PWmYne18LU+19dVu8zkIZ4l1fhGDvFDZs9GqQIjMtq8w?=
 =?us-ascii?Q?HRb192OouOtRTrMViM7FNiS644kEyYN1j7aAd4XSmBTsHiqNSCbvt1s/VuFy?=
 =?us-ascii?Q?veziVr+H8LfxVA9FeTx9xy1+OHyxaCqxLqpHf5qige9ooz76353bxER82RJq?=
 =?us-ascii?Q?9SNbzyzLSqFplLaPGrjrzCniWmjgWhoUTcRpfBxpnfQahLL3sjO6kKQVc1h4?=
 =?us-ascii?Q?+txVYxZyIbJr25W0EeB5Omwi9+wc0oyN0BYf1TH4wAurptA1Y6aE5TZ4PUQ0?=
 =?us-ascii?Q?kMJCAc5Iwr/M7yeGwtfqu3g9+IXVXc8x/tuTIpntjhHd/C6yTx5h0KEOc7yy?=
 =?us-ascii?Q?0go/A/OaLSMOli5obeBzUAh/8zn9WjKgudSR0KzD+Q9EtXnO18ItiXM+2Mta?=
 =?us-ascii?Q?f87nJ2P7mm/LyMPQhQa7j3sRXSftS/n1vBSDc7pIlwtgrZxwum9Wz2+6UdXB?=
 =?us-ascii?Q?veU9JiwqmQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: 
	Mqqyy6c7qyncdfc1WvooaRDmKRoPHDLo4SZjab7RdxZ4ttSW1XZmv080afuT7zl82W+jBobqeZwIoPl1WuQV9lZ8QQX2UzblqrJiLssBAzGnCbzK7tuc7es9QiR+GoLjFFSwdwbwH/SCM+bqcLouSrhjxYbZRn4CeXTPki3x4tcqIarHuZMGLShaLFSg9z1nzDGApV85zBDSqEE85IWfECeckTUF5DhqDPdP0rS68MYfgX6frIBBgykkfQeDRGEt5rbnkbjnLakGMGivz1v18IOG4HT/9g0pZs7QiY8Hai8aCOgE/28IzLyopN2FYik7/kThGEu33Q4hgYjwX7+Gdw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 289f9ea8-9066-42bd-a1ea-08deb0afeec1
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 05:24:40.7263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h8rTpVyp1TtiG/T4oTmeK3cJMYIbkLKdE187nv/UiV9Ey05o/88p3XRs/sOXkECf0hYzVMrTozwU0slmvIB7Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB8855
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDA1MSBTYWx0ZWRfX5paIFe3KB0ur
 C3r3vYXpFQq/tudRrjsvCqmMy+vjjwe1BYOs9Y9E0MSo5HPe/7hpnWwzjXSh53CdsW0iy+tr749
 fuxsQ8JofGHsNhRZdB2TMO1y5T9iPB/BbLdc2F2g2QB/EUztgPzoHMuJeS3TC07Vt0LF5Ifka2U
 zsZ5HxCPLqBzJcZ+8qQblOjYhgP9CHvbKrifI/8XKLHEcf3QK1YVCQ83DIh3bPwP5x9hYWBWgkO
 hxhjfRbOITKwgBIWeDqiTtM0xSws20W3jqxjN+hGzdLxiyui0xumSgz4Hdke8LltXjXBxchL+BV
 9k1xpPdKfA/RAPnQ/r0wWubYWR5F9WKQ9otsQMr573jz7MBFd8L3dWe9WT5nfbwXHM9Aw0OGyMP
 /vvAC8Xf5IQzMnsqYzc+WbFiseK1V/waUDhaGGLp+a4Qo+9b2eBkG3H+G30YqqLizbP3Uz2Rg92
 +POU0VYhi9f4TmmuM0A==
X-Proofpoint-GUID: M5WG1ZNCCtPnzQ4swjdoSJUapl5OXWAU
X-Authority-Analysis: v=2.4 cv=du/rzVg4 c=1 sm=1 tr=0 ts=6a040b1b cx=c_pps
 a=WwHAhc24fKszT02xmrP0gg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22 a=t7CeM3EgAAAA:8
 a=rVcF9mjB7NWXllDnQBEA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: 7Lsyu52oiQ4luBYPa9_pVltLnG6qfE5H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 phishscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130051
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 13 May 2026 05:24:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19501

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
index 01bebb764..1e132c502 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -972,7 +972,7 @@ class Git(FetchMethod):
         raise bb.fetch2.FetchError("Unable to resolve '%s' in upstream git repository in git ls-remote output for %s" % \
             (ud.unresolvedrev, ud.host+ud.path))
 
-    def latest_versionstring(self, ud, d):
+    def latest_versionstring(self, ud, d, filter_regex=None):
         """
         Compute the latest release name like "x.y.x" in "x.y.x+gitHASH"
         by searching through the tags output of ls-remote, comparing
@@ -1012,6 +1012,10 @@ class Git(FetchMethod):
 
             pver = m.group('pver').replace("_", ".")
 
+            if filter_regex:
+                if not re.match(filter_regex, pver):
+                    continue
+
             if verstring and bb.utils.vercmp(("0", pver, ""), ("0", verstring, "")) < 0:
                 continue
 
-- 
2.34.1


