Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD50CD3447
	for <webhook@archiver.kernel.org>; Sat,  9 May 2026 05:30:19 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6788.1778304619438913563
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 08 May 2026 22:30:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=suQqM+Jr;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=95895a8adf=qi.chen@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6494jIVM2286826
	for <bitbake-devel@lists.openembedded.org>; Sat, 9 May 2026 05:30:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=3Msu7VGPBNSik7DqiP9QgBDdmBdMMdDKggXjzbsBbIs=; b=
	suQqM+JrL5tR9HxRrmkrVvcg+NHcfoFiMNpBtnp5rIOlNn2a6LQhShzdox+P8FCb
	uYe9XtRvMTY83ptQW+H9WugOMQflBU01pSFen15fR0PEz4MCiCQQYE+yo5z9W8lK
	o2dKpzp1EIvsQmGPUWhAW2S/BH4WIJlgRaY7SnF2xqsvRSMUEBwANaFeSiNc7VZj
	2JxR3jEYudetTcfksuvZKlhCAx9x04h/wrTh/e4v1YB2iy4cnACwoXfpLHzIQWi+
	XeejP2CKFG9n2kykssNQkpcDpFYXrhJeNw0wLfpYlcNein7bjLJ7NoATSoLqC3D5
	cOprA1UaIg/fwlcZi6v6+w==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012068.outbound.protection.outlook.com [40.107.200.68])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4e1uw6g3xe-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 09 May 2026 05:30:18 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FRqe9ZhuSlMSCCFQrP9sGw9ZakyA27+ACWelk2POMn+VpX/WOF1dxxpU3rrch2O5nIR6QKMKNmIvJ+rsEtgvtxxJL4u0xk+D2cPaf9JNvgwcAP8O4cceuxX8Sim3sly6RoEwc04c2SFgCLdvqzNG2JfGE5PXheuBgFBiHam+TNkvqlph823GEFAjlzX7Y1BwDNYopX0q/4P3RbFLTxqokQ0AVo+AJcursEdi9oCymfushSQdiGV8OmWvYQCSdYZciwMxUt6SRxSFwPrYmF3HTr3TwJVUKZlNM3GnQdbKX5zoBgNrJiG9oXFkvUTWAB4ue/E33cKZDulN2YwicrhGWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Msu7VGPBNSik7DqiP9QgBDdmBdMMdDKggXjzbsBbIs=;
 b=CB32mgchLwbmgYVMQ0BAvCIrvW6tEIxVg1xojfDGYv5wnF//Qep/0BFxd+MLuK6sy5THEBBjGQ5DegHlVKch6p2g5hKMqcR9gMlGfBDOV+f4dDsr5cAwPLkW/aEoHDJiPWO9IfKiN2Ae7JLrbszKyuGqwEi80kfV2HPmI+XOMlNiRE+E6/vEF/YA8Yb4JUKbvqQiraiZ7Kp0JoAxz7jKInwB/5VOIgrUvYYv94jSgrcbyXmx2mHJstvJ5J+ZYARlHN9FoQlv4ehFIlTGae7UZk4dV4Olwky+/KcNwcjtAGCkvkchXPts7DFcGhidn6r74ptXVCHYIg3wi6omVKjDwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by CH3PR11MB8657.namprd11.prod.outlook.com (2603:10b6:610:1ca::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.20; Sat, 9 May
 2026 05:30:11 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%3]) with mapi id 15.20.9891.019; Sat, 9 May 2026
 05:30:11 +0000
From: Qi.Chen@windriver.com
To: bitbake-devel@lists.openembedded.org
Cc: alex.kanavin@gmail.com, randy.macleod@windriver.com
Subject: [bitbake-devel][PATCH V3 2/5] fetch2/wget.py: add filter_regex parameter to latest_versionstring
Date: Sat,  9 May 2026 13:29:47 +0800
Message-Id: <20260509052950.1565384-2-Qi.Chen@windriver.com>
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
X-MS-Office365-Filtering-Correlation-Id: 48881d46-fbed-4392-d35d-08dead8c09d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	UPvnP8qmBty6hxcA20vupAQjwRgSk53JW5padKdz8z1SWNJRbO8a1k2E7A6yY0V1c9XbfHf485XaepyIjGE7D6Ik5hTz+TSrsU3jFY+nVkWd0Mcn2bTDZjYbvZpzIMAonNCLeJcnKGwX+vrzwJ+7+426hBrdxDTBZqgJ7b1yFUc3dF2UzYnXmXhHhTAG/4JVGal/+dMVv7jOLKqu4vwmEV6AOwBDwtQsHpR5fhaZ1ztJhaommjarBo3ZFTuE7SeTXjbS2d7XzBdONxlXjYnDZmHkZUaHDF9Z9DiNszS3lBFql3l3uIVTpnxnAVgj10nsRHN7MxXDhTQhwKJ+t/AP7+Yds8r/W5Q1Q8Lk/y1BgHaRzgMN3TWZWQv42BxcLQQ9ZR9NhESqSE/v2+cH51wVtr6IPhDeG2QtupX8rJLHMAp7YlGIXnHolJ4ETuufzMb3BVOxA8oLrUH/sG1ggjrTofo1kXmRzi1oSxXC+5dB39XYiGE++XQNMqNL828R2KRiFevl4w3Nte+ntQZ+WGV2oK/ThXyzAyjL0AiBKCymA8vA+OF/G52mqQNG3KYwNaCaJid417ifOVz6UMaf+kpMLiqotYFXnESiSXHKh6awFIRfGIYUAe5VSVEseQBoGlMlZQ4TWzQXqr7sj1p87Nap9VVZWZWyiXNyvJ3fNS9wxMuqywZ6r14Bsu5kzHIsz0obEyn4p7uNOba08rOEINyPOS3+JrOKnXYjbZejPPY+XlkxlfK29wF6wrCcliu6+Xm8
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?t514guAR1waX/uldXduWsLsWjfyXTrFFkxlDCYpB70aDG8sks+msxJa7BCHs?=
 =?us-ascii?Q?CrYUVTCHlpR8cKfZQxIOuqv0qs4TMdD7oHyVaIFVoBwJxgAusrpYCAWLXpmi?=
 =?us-ascii?Q?9F76oWCViKberYyQ29v9BmsimRw9iQkOTqdPqbUU51MCBVTKEamAyPEvmg/A?=
 =?us-ascii?Q?KLpCevpiDgJThOGUOOEFCiuNgbwuoXkI1ClG8b+wcMZPCccLaztMUZmmLLe7?=
 =?us-ascii?Q?AgkR9jxNnxeQc6mOh6W2hwy0llPbcKU9sLRPhf22sMfnFXaJNCpP0qn2aePO?=
 =?us-ascii?Q?9S01hDSq7DIJVMG1Tcap7nWspDOb73ZTkIPXrt/PAQ737tNSK5hF+HQrnpyo?=
 =?us-ascii?Q?OfIEoUNd+ZSphlukSV2thBAfOdyZVGMWaZwZikvpg5XpY5bP3jctruKkb4Sk?=
 =?us-ascii?Q?z4Elcc8335SRLvtmmUb3rWhNMGONk296BCqgd3C2M+Sa6Mo8FPUI39l2O75v?=
 =?us-ascii?Q?34c5SoD3UuFvQuC0Q2uZD0xiuMuQCJSYf4B7j8d1c+UMwrsVIrYorw2OPeAi?=
 =?us-ascii?Q?kyM6Gu7mKxDGZ5T1KRRm06GnowR8DqCWjJO1KBkQSl/bT2eMSXFY+AVLFdeG?=
 =?us-ascii?Q?iwPuG1ksqtDYyRTkKfQgpXPMak68vJvv80/BbmdzhEo9/Pip1oej1SvlnaHi?=
 =?us-ascii?Q?IWaiSS9WAEHC1rFouuoHX+/5D5t9RU60GUDGocPPIWmxx6fNpcO8Y9nIXUtN?=
 =?us-ascii?Q?be1rgUKpURiyhOuVDuOmewX806Ifc28CT2bbKpup6tqls6UujityQAztzj7M?=
 =?us-ascii?Q?9O0xbN48P6Ai8U5+4uQPdfeVA+gcXCnTnLs2huf6p1rdt+YMvTsMpwMJu7NM?=
 =?us-ascii?Q?eJXcMmMhaQEt4MTYMyMDnar0HfSdOHn2b0csfDq5E71bNg+nW+y04zQwpWzd?=
 =?us-ascii?Q?WwiDLmJUlmRUurVxcs5+RGKXnXvu4xBCODoWLljafKi4fLOALDy2nnUdisKz?=
 =?us-ascii?Q?dUHIrmUDpDxKYKZovM6Wima/UH7M6KjlMkrxBRD5OQizkcQp3Dte99dShQHh?=
 =?us-ascii?Q?7Iuf3MU/XDz8RguEOAe/2IspKlg7AjX8KonhhhrU6ysgzasyE0NAZ0qu/UNH?=
 =?us-ascii?Q?+GwpmSQ9HolTbWop5PvWUfjskEo4DTT59OMb2LnQP7uS8AVbCVtYzvtKGt7o?=
 =?us-ascii?Q?gaElYTCC3M1tQG/uaK5tcvzcugJb1I63wPftzzYE4KHm4VHxnuLiZpQgTipv?=
 =?us-ascii?Q?HZsSB7pvnorBkmLt/5sriNfnSD7Dor4mIiyZI5surQ8fKScarFs/olQQsg4D?=
 =?us-ascii?Q?97P0QliQW9xz1qoF9f4+PuXXNrUZ+2hFF6FGsMfNQifF4BDaccOdRtqQ6jpN?=
 =?us-ascii?Q?r5O8IL+Ph2u3d24KP90CAA/Gd6BL6uRXlTUjqxZ6il2VpAqpLVB02Ke2YWTx?=
 =?us-ascii?Q?FyjJi5KgybQ8iPYbEXYoCjBgCGpH8ifq4m41HU/2rFmGVly5kpT6R+S4iCmQ?=
 =?us-ascii?Q?7MSA1xDgeNVuCaJpNFnGSVIh8mcgjvv4PG9VktDGAVD5QPqfjsSBq5CBxoHI?=
 =?us-ascii?Q?B/LjgNuAir0KqRiQcAw8rd/4FFlRsUXuvJaBYVQivEzIuRVXexAsXEBn2EXQ?=
 =?us-ascii?Q?Iusounxs7hSghBwysVGiTA0D8pXx2OQSYm+eE4UBFdlJeSTLxjTuwcTvEfVn?=
 =?us-ascii?Q?BqnhzqAIrs9B7xzoje8vXIfhz+2K11rAU7w2Szp2jZSm/MOrxabs0q50HARW?=
 =?us-ascii?Q?ZZdAEoHcVUDc9+7BvTPy2ARxpUetFARIGvofyDOLoEISVT6fJ+YG4URAnGI2?=
 =?us-ascii?Q?1PoWxMH38Q=3D=3D?=
X-Exchange-RoutingPolicyChecked: 
	iuFfSPOyPmtWOkqreNQO8smH9jCEByyhqgilHl4GFVLm3lv7jDWsqr65cDvDJ3att+820z53aLkGGTiiNMCvqznA2kT5q4GdNowB/pEEapMpvCCgpdTOwtZm4t264kHRFT7KnqCFKASr6HwjW/wD8qleDBeer+JzGz8lNnwrtEYJDMIcd8Fhjf+dM7WM18EgZdVt/0k9jIZ3bRvi59wuapXUGxKGKQ9UefiYP7QsIuilFP3Gb6ffCOW0/WEloGs8zufDfwmvnzDK54J1LAuZsnjhbhSGD7oyuNJwRRFS2LdSEknIa7N6SxML7vzSr7I1dEi0QFdBbS3fY41sISqa5g==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48881d46-fbed-4392-d35d-08dead8c09d3
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2026 05:30:10.9892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: msqkTJTyQD7EiYqj0+WgxlgE5PWug6id5HCEIbmQc42YW3t/DRt54+BtnhK+RSKIn2MIKLAPSNjlTzbl8UZ56w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8657
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA5MDA1NCBTYWx0ZWRfX2OW0kjjA+OzQ
 nCXaLiZ/fW7BAaTv9uMVJ32oPlbYIVXDr/+HYSxmUQoBbpq8bUgoWKBZnOD9MNdZ/bYog1Xlon9
 1zT40xiHr4x7td1mb6KmXsjXQTTiWhDWYDL5aEbNBxAl0eROJyyyt2c7i8JgHCUd/Q5skWHH2hx
 CiAD/+4KNFo1aHDT4T8HdKoAWCJNNkX0QceVzM9q/zKaltdVmXTOs+q+RX0rsE8dpMP4sYSMg9k
 gJctBF00gH3iAKCV9Eu7y3SmYx0R73IeOFGX4d892yMTmbSy1PiLxLwlKgw1gi2yns2xb770A2z
 Tz33z2pqqBG/muVR21IFE8KNnvHLW0BfqdT8AWHKTy3rLH/oHFojj3dhajlQsl4Y1DGpRFJuQDz
 xacEMtX9QEUE2QR7UNjouHhoLkY/oI4vY3FLCivVKwO9YupHGE8zMkgq3iaKubxmOOdhVUfqGlg
 FOvcIiY3TzaOX8N4pJA==
X-Authority-Analysis: v=2.4 cv=d6nFDxjE c=1 sm=1 tr=0 ts=69fec66a cx=c_pps
 a=hdF+edV3qND9tYm1xB2jJw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22 a=t7CeM3EgAAAA:8
 a=zn5JUfJC_tOmDknYn7cA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: u-d-KXjInsLyygdKH_REEo7HAN0hOrRn
X-Proofpoint-ORIG-GUID: vhi1GW1ZzLdYUcdwARo3iMbTIBp5A3mP
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
 <bitbake-devel@lists.openembedded.org>; Sat, 09 May 2026 05:30:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19480

From: Chen Qi <Qi.Chen@windriver.com>

We want to be able to do stable version upgrade for recipes. For
example, 1.0.0 -> 1.0.1 instead of 1.0.0 -> 1.1.0.

To to this, we need an extra paramter to latest_versionstring
so that we are able to filter out the versions we need. Using regex
has the advantage of adapting to different version schemes.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 lib/bb/fetch2/wget.py | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index 6ac4306c0..6e186e1ca 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -492,7 +492,7 @@ class Wget(FetchMethod):
 
         return fetchresult
 
-    def _check_latest_version(self, url, package, package_regex, current_version, ud, d):
+    def _check_latest_version(self, url, package, package_regex, current_version, ud, d, filter_regex=None):
         """
         Return the latest version of a package inside a given directory path
         If error or no version, return ""
@@ -515,6 +515,11 @@ class Wget(FetchMethod):
                 newver = self._parse_path(package_regex, str(line))
 
             if newver:
+                if filter_regex:
+                    # filter_regex is derived from PV, and uses . as separator
+                    # while upstream may be using _ as separator
+                    if not re.match(filter_regex, re.sub('_', '.', newver[1])):
+                        continue
                 bb.debug(3, "Upstream version found: %s" % newver[1])
                 if valid == 0:
                     version = newver
@@ -532,7 +537,7 @@ class Wget(FetchMethod):
 
         return ""
 
-    def _check_latest_version_by_dir(self, dirver, package, package_regex, current_version, ud, d):
+    def _check_latest_version_by_dir(self, dirver, package, package_regex, current_version, ud, d, filter_regex=None):
         """
         Scan every directory in order to get upstream version.
         """
@@ -576,7 +581,7 @@ class Wget(FetchMethod):
                         ud.user, ud.pswd, {}])
 
                     pupver = self._check_latest_version(uri,
-                            package, package_regex, current_version, ud, d)
+                            package, package_regex, current_version, ud, d, filter_regex)
                     if pupver:
                         version[1] = pupver
 
@@ -637,7 +642,7 @@ class Wget(FetchMethod):
 
         return package_custom_regex_comp
 
-    def latest_versionstring(self, ud, d):
+    def latest_versionstring(self, ud, d, filter_regex=None):
         """
         Manipulate the URL and try to obtain the latest package version
 
@@ -678,11 +683,11 @@ class Wget(FetchMethod):
                 dirver_pn_regex = re.compile(r"%s\d?" % (re.escape(pn)))
                 if not dirver_pn_regex.search(dirver):
                     return (self._check_latest_version_by_dir(dirver,
-                        package, package_regex, current_version, ud, d), '')
+                        package, package_regex, current_version, ud, d, filter_regex), '')
 
             uri = bb.fetch.encodeurl([ud.type, ud.host, path, ud.user, ud.pswd, {}])
         else:
             uri = regex_uri
 
         return (self._check_latest_version(uri, package, package_regex,
-                current_version, ud, d), '')
+                current_version, ud, d, filter_regex), '')
-- 
2.34.1


