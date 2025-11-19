Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D537CF3182
	for <webhook@archiver.kernel.org>; Wed, 19 Nov 2025 09:01:15 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2668.1763542869700034682
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 19 Nov 2025 01:01:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=WVMUzorW;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=3418bbb192=qi.chen@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AJ7rvH11456063
	for <bitbake-devel@lists.openembedded.org>; Wed, 19 Nov 2025 01:01:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=PYCRQ+pPi
	6QR5qTiLwzRqqI1eA3XpK6mrOCIKSa1pXs=; b=WVMUzorWylq9dcXJJUrOWVlgg
	Qm/LjlTCJoCWV7Mit6REu40d8fISvZoe/iCU6a7NlSyEVhJLxrjiA8AcNAtTm16u
	/ZdI2RsmW4x+mNIWXK2sPGUv82Xl0knkeXWgZelt95gwX2C7MCThjJMnR7ayhsRV
	v/x6HSAo8Vai7v2fLvFN4jAWT+wjHZuvWAtFmnzD+1BbBo/AdwtuvSccqSI5bGaj
	rVsL4H4cFR0RqiEuqgWlZggaIHEWqB6UItGvbG7knHxKKYOJn2Nxp+K3uXAnebcY
	aCUzBhaGQvSMzXgTqUzm8mdB99lPqrBdLvY92GUd3hYSf9SPEPq4OTiDakuVQ==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012060.outbound.protection.outlook.com [40.107.200.60])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4aeswjcjyw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 19 Nov 2025 01:01:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OsycTYgeONF1S626FbGcpAdR0iQaqiUCJJM2tVdBhNj0a+Be71ChIFCjAP6p6a9wutxL7mul/5AnUsAU2r3stw2JhQq70gmq5Ognt4UkX3TrsY5VgjC71uWDK99bgVfN4Yl1vKcUT2rCquYNQE8XmEH0n0rK9jAbwZaBbXysvAiDRye+lZvw1RimOeche55aXBevbFcoFERGw4cEr+PjFaWMhG4WThZx+S001GMkmyTISy1LWSQ0gfSYb2YJnRP81bflMGxS4ZFEF2fdmQdTVdUQNXFVpaxKqU74r0UbfKNQoZ8XSSO4QEG8xA/mlMVM+S6ngVgerhln8JLGFGuzyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PYCRQ+pPi6QR5qTiLwzRqqI1eA3XpK6mrOCIKSa1pXs=;
 b=JCvGbQsMjWOMdb75AhBgq23eEFS6YfZDrQglsoVmTCyS1VLKKjnw0ZFH1Nb4iq/990fHJWa2cv+mBYZUIMuF6kB95ZbB8XhxcdqcogyL7LObSiq+SSsHCe3U8kxMjZPYK+gEyFWy1eG4ME53zbYc7Ti+wwany0PJM68BgDw+Hy4Z8BvcPyL1/Yc/FXzip0BDKeQdb8WpXUB8A0rn6GIaA9IIDtDunVIeK0i0EelCyOUlo1q8Qt967vD5F/ahNPk/ov/Rk34SozOwd+nO3KI0sY/Tds/lTYsRrWxeGg5MT0vWEEb78m/iQo/zk+qEEQ/MATtYqDB3Pt5MtTqTd7WF+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by DS7PR11MB7740.namprd11.prod.outlook.com (2603:10b6:8:e0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Wed, 19 Nov
 2025 09:01:05 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%4]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 09:01:04 +0000
From: Qi.Chen@windriver.com
To: bitbake-devel@lists.openembedded.org
Cc: alex.kanavin@gmail.com, richard.purdie@linuxfoundation.org,
        qi.chen@windriver.com
Subject: [bitbake-devel][PATCH V3 1/2] bitbake: add SKIP_FRAGMENTS CookerFeature
Date: Wed, 19 Nov 2025 17:00:44 +0800
Message-Id: <20251119090045.107642-1-Qi.Chen@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0357.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:7c::15) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|DS7PR11MB7740:EE_
X-MS-Office365-Filtering-Correlation-Id: 8279306e-09e7-46fc-4ee4-08de274a2ba7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|52116014|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?5YtU8IXBPnb+JkX707vKEyPEd1n8NPKsbfe0erX52LdnGJ82jVXcRThmL32t?=
 =?us-ascii?Q?GP2JwETfGHD9f6zOsmRLQnL2mBrxWQyi9xugBX9cVzO/pmS4WNn0mp/HLj9s?=
 =?us-ascii?Q?0wpdWqLe2djQZ321bF8R/wmvRBOaz4IV/fNXnxDsuDTrZ2DYQewRlYTPORs0?=
 =?us-ascii?Q?5suqqFK2XuV6AeTazqXYVLDFdi8ovQUUFg66QefLotk0kkK3x8bCBu0mUymx?=
 =?us-ascii?Q?0FOfdmmCKGiRGPQBYHejBHUEvYO0XYfpEg9GgsMQbKZtam4/r6YVhe37Flxy?=
 =?us-ascii?Q?1kZa+bw5E017kcG5Nu5T22aFSodCvLdpLt8F7L/OLRaz543zu1sC/Xf3LBL8?=
 =?us-ascii?Q?EcjRcUiBqzyaU6hvH9al8dLn6477oSjy++Gj2Qvfq0IqCE44syRJe++VAe/7?=
 =?us-ascii?Q?TDocAD2/hpU+W0/QcVjBezX2xUOFNeKfE+BbLJw1MZj0MtJcfdu4v9rv3XC8?=
 =?us-ascii?Q?T/KrAJIY0UuR3pI4rjQDOWYThq2sutBJfSvb6UF0KyyvulSIEql3HIg2Mhrz?=
 =?us-ascii?Q?JC5VO2xuQcpcZgCtqK/VIYj6M5PGskZmJD+u1d/wpLT7NkyfJgnRTjDTkz66?=
 =?us-ascii?Q?2Y7iS2gke6wMuntbRl2Oh8oR9h/1jtKK4FuePoBemUoVuT/3uRPqxu54X+as?=
 =?us-ascii?Q?vxjtW7RDpkT1ZmBKysoG6tNiciJ0bOL+wNpiuvy11TihR5rQQ2YwF0XY4NCi?=
 =?us-ascii?Q?ybua8ja+kNM3SqYAJvwKuDwq1fJytcjNBwXMY7UGt4/tDOxtrHlIkf15bnpT?=
 =?us-ascii?Q?OR5B8BpQ2xg4nlN48iCCC5LhL03HC+7Djn7TTgtxgxMRkH8eRUT+Ci+BiCms?=
 =?us-ascii?Q?lpYYknGZVwOcTl3zfZ9CaHr0y5akR0rM9SxokSStweTdZE7lYUYXB5WWYkhf?=
 =?us-ascii?Q?7H2NU4HbQbfBTJgO7HAqbMpemaYlKUhlRmKclSAHQtsFB/cA8OIs7hgI+RLO?=
 =?us-ascii?Q?FUIkXmZEFuGur49FsD0jPBWnSC95wXU0vA8UUm6GgdBTIP6JbgKuaES6rmKO?=
 =?us-ascii?Q?ep+cH6nupqTDW34fXYej1zTt2XtLOJQCWXx+/zb6LywWsfJcWbKHW3I5eTeU?=
 =?us-ascii?Q?6fDPXSfIcZj4WhUg80dd75kXqmtxmOjhPfLeIpZiV7rDcgZ4rfcObMkPC6z8?=
 =?us-ascii?Q?Rg87NzHkmc0wlrqeSqFGblBI+bjE5ZLTAUKf3/cETBlBifsDty3oLN+yk2HU?=
 =?us-ascii?Q?t7BP5oGowliO+Rq8ZVW+sLlj5tCZeLqEHGpOwOs6q3yc/rgl3Sq8zxxReNhi?=
 =?us-ascii?Q?nzj0UuVCROGPI2aazm800AiVG8VUxXLigvvXCWjxmNoGO+ReE9gE4bCmRpXv?=
 =?us-ascii?Q?I6dZ/yIT1LgKOgIQz3bxAZ92fwglieu+HEwhCrHDwQHxXGyX7vBImi4WJTbp?=
 =?us-ascii?Q?Ir8U8yHQGwQA9ROWX07otB0GAcPyQbX+N5WnpZHIVPc/1btnwUln1vBTrC6r?=
 =?us-ascii?Q?dWNAKH/CpUNLJWHjgQc4ILW+ccf01+KFQiG1P4q92vCA63NEpTVqY2MmGZRF?=
 =?us-ascii?Q?z6wwzj5FL8GI7+u18GMyjU+AE9PmSl4bZggd?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?gU2gOdhjO7Vhe0a3tFm4hB/rOUFV4fXuXEyjgpHtT4h9qDYldEIR9TbAlC8U?=
 =?us-ascii?Q?8q5uEECVC7Mh4sEDGpOdDBd9Cg8GNOYyu3hJJHYfQM+69x4MyQk0fQY2JD7q?=
 =?us-ascii?Q?BxRwwkR9R40TWLsLCioKOCIwetG604k9zr2VJD5PIBIaO/sl/dhzccDEoee4?=
 =?us-ascii?Q?phxj/3W2k2YrUeKlRS2JEfQl4IZ7qYOuiLieWhkQFxAkPEeZzQfnfYw0bcxT?=
 =?us-ascii?Q?8w8P/YT2Zcvd04CMadhTIOToLSK9KRN1nivXvitefr84Opzxq62O5Xk6spa5?=
 =?us-ascii?Q?bdbfPVs5wEn9QD56oh9PjYrPhpr2T7Apw6LiHzloDQw5kC37RpE4D3oStm/Y?=
 =?us-ascii?Q?bKneMVSBEbJ2/oR14iv4zyVzA1W4IBtpK8qxMiKI/U/tZ6KPm3QLyWu5YMhu?=
 =?us-ascii?Q?fECN3kc/jZTClEDuC3l9tfTQg9nphKsk02wIevTs+Hmp7ejVI7ppEWwgfgK1?=
 =?us-ascii?Q?HTGL6oFxa5UVa3wkjjRAieozkV31WFooWKMXRLcBw+nzqiSw+rLHfLVLafyk?=
 =?us-ascii?Q?5Me64qxUXaBKEGp7IbG1cBPInz0Y4ySda2NamiiDX9RrhMUsEAS9eF98JSMn?=
 =?us-ascii?Q?8bW7JTaAKLkWUmu8H6xTSr1DcbHY0IbUundO8lPURQdOV19POQbJAamcTGJP?=
 =?us-ascii?Q?fL+HyyFq0RmbmwNd97a8+8juy6ffH60+prkHkaRu9yj2/Iqz1rNmNLjV/wkd?=
 =?us-ascii?Q?0e9he+iuEgWqObGF8wtyjcm5FcGMZQ2C62qHsbdLHcRbAGM/mdIP9wHLHt2I?=
 =?us-ascii?Q?lUre/m8DKsU4EgP68/icIe+iUa/qXMWtEydGZhUUSI41xVEJ8CzbTeEB5i4I?=
 =?us-ascii?Q?GQvUvS1hyldJc8bXjZ5Fm/f8hk3PZvoyPQ975KeGvljA0ROcUledeRmXnH80?=
 =?us-ascii?Q?Ae7LeQWKEOJcW7C1O9nMDQF700YfLy2qDfqr0QjTkfwr3aUsp4jzeoG8aOrt?=
 =?us-ascii?Q?Q3765So6x5E9vRrnfXjFDXOIC2vbjWiib50YY7WaHCjAR4xBRlWP6Axd2nkI?=
 =?us-ascii?Q?6moIyIcXh9DFJkgfRSZ4fnQj1QjETMkNJqOciRtAC+murZYORn95zSSvkOov?=
 =?us-ascii?Q?hDol8fS3qyYJbqQMz/FEqG9p+q10UxdvrcTJ4gfFfpSnIRLPpsy7vYgZUEFN?=
 =?us-ascii?Q?lj6ukRdUWII1ag9CKCgTOZCYtXtXctcuE9j3hvedPUFBNThCAQJkAvt92PMG?=
 =?us-ascii?Q?448CtT3bLSkTZlj1rSnJpAHmVYiPfnOrPaJ+zWDMndLoW7sU77tWRJazYo9b?=
 =?us-ascii?Q?G3c5BK4hXsfVroZlmy4SAzbV1FH2gnzLyAbf3zJXGWzEJaEkEBpb5wAN2svt?=
 =?us-ascii?Q?BKJoaIB2JPQ0VdWZ3JqAf6iJLI1R3cjVryYPAVBJeApeB0NNlJNOrXRyFAwf?=
 =?us-ascii?Q?vSW8pgUfS7neG2MFZ8lcZ85cYdRSwrAgv9fv2VAEC+6281HbQnb5di7QS37L?=
 =?us-ascii?Q?0yoSS5sd7/GXmkYJ65ULpNibyjdl0A1oI2518TcQ1gsMF1Rsa3Cdhvf94rfX?=
 =?us-ascii?Q?fs9CfNnFeUOrsGzZTm3qGx6PEWiE1zKIvzBxaN5ODfkEfPuGCp7JsB6Vn4/t?=
 =?us-ascii?Q?eEYvu9KgcNiWv8nbNPJShDScHrHkbfePF2J2YVVd?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8279306e-09e7-46fc-4ee4-08de274a2ba7
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 09:01:04.9067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IhdLvXPD8YOdQL6O3Yd+iAMbX0cOgZvr+nGCEq2l6d5819enRyZIOki+2v5/XOLTQl/SOjqnee+8JFk2FUWZvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7740
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=BqiQAIX5 c=1 sm=1 tr=0 ts=691d8754 cx=c_pps
 a=P3LZRqt57NYhn536gl30yA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=t7CeM3EgAAAA:8 a=DII4xfcm4MOyQyFNyJMA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: NeeSyOpSIeX_AbsTCAGrO24sH5mNiLUh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE5MDA3MCBTYWx0ZWRfX4Ue93BJM6Y1U
 FiVTBX+WDE/0JlcdTV1Fq4ITO6qZORhiEWkxBAv5Xr04o0pQYCBHlamil6Wsf5/capUXeavSSmW
 RKdoCVqT79khQwY1ZIQTtR5SLGnlMVkGhfEe2KI6MCPHZhB/Aiut4bGtQYqGOk7JKpHSvZGiIOM
 DeqM4d/x0/Yqn1DQcQkL+cFygfzW1DfZvDa8wfsg/NYopCBsk3cKJjHDNoxpHD13V7kDQo7L3Wg
 NL47IMhvINMMhg2+baMxL7m4LcfN4wqwhmZvdW7KQtKCspvsVGKYE8kRn3a+rxpjdBeln+UA0Me
 yVG7Txr531TzPh2qBuwlWuEcRGe7yyM7qliR3yrybt2SIgTjf7qOaOGKAR5X+AubAlXlmStJGlL
 ozVh9sL/Pev49CaY7bdy4cRB7sScLw==
X-Proofpoint-ORIG-GUID: j_dqSnEQcAaKSFlWA-R1WmCYYWtHtdmH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_02,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511190070
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 19 Nov 2025 09:01:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18449

From: Chen Qi <Qi.Chen@windriver.com>

This patch add a new CookerFeature, SKIP_FRAGMENTS, which when enabled
will skip fragments parsing.

This feature is mainly used by bitbake-config-build. It's a tool to
manage fragements. So we want to skip fragment parsing to avoid
unnecessary errors.

Fixes [YOCTO #16060]

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 bin/bitbake-layers   | 7 ++++++-
 lib/bb/cooker.py     | 8 +++++++-
 lib/bb/cookerdata.py | 4 ++++
 lib/bb/parse/ast.py  | 3 +++
 4 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/bin/bitbake-layers b/bin/bitbake-layers
index 341ecbcd9..7d929567a 100755
--- a/bin/bitbake-layers
+++ b/bin/bitbake-layers
@@ -23,6 +23,7 @@ topdir = os.path.dirname(bindir)
 sys.path[0:0] = [os.path.join(topdir, 'lib')]
 
 import bb.tinfoil
+import bb.cooker
 import bb.msg
 
 logger = bb.msg.logger_create(toolname, sys.stdout)
@@ -64,7 +65,11 @@ def main():
         if global_args.force > 1:
             bbpaths = []
         else:
-            tinfoil.prepare(True)
+            if toolname == "bitbake-config-build":
+                extra_features = [bb.cooker.CookerFeatures.SKIP_FRAGMENTS]
+            else:
+                extra_features = None
+            tinfoil.prepare(True, extra_features=extra_features)
             bbpaths = tinfoil.config_data.getVar('BBPATH').split(':')
 
         for path in ([topdir] + bbpaths):
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 03f262ac1..32669ed96 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -79,7 +79,7 @@ class SkippedPackage:
 
 
 class CookerFeatures(object):
-    _feature_list = [HOB_EXTRA_CACHES, BASEDATASTORE_TRACKING, SEND_SANITYEVENTS, RECIPE_SIGGEN_INFO] = list(range(4))
+    _feature_list = [HOB_EXTRA_CACHES, BASEDATASTORE_TRACKING, SEND_SANITYEVENTS, RECIPE_SIGGEN_INFO, SKIP_FRAGMENTS] = list(range(5))
 
     def __init__(self):
         self._features=set()
@@ -278,6 +278,9 @@ class BBCooker:
                 logger.critical("Unable to import extra RecipeInfo '%s' from '%s': %s" % (cache_name, module_name, exc))
                 raise bb.BBHandledException()
 
+        if CookerFeatures.SKIP_FRAGMENTS in self.featureset:
+            self.skipFragments()
+
         self.databuilder = bb.cookerdata.CookerDataBuilder(self.configuration, False)
         self.databuilder.parseBaseConfiguration()
         self.data = self.databuilder.data
@@ -355,6 +358,9 @@ You can also remove the BB_HASHSERVE_UPSTREAM setting, but this may result in si
         if hasattr(self, "data"):
             self.data.disableTracking()
 
+    def skipFragments(self):
+        self.configuration.skip_fragments = True
+
     def revalidateCaches(self):
         bb.parse.clear_cache()
 
diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index 65c153a5b..b6dca7af7 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -137,6 +137,7 @@ class CookerConfiguration(object):
         self.build_verbose_stdout = False
         self.dry_run = False
         self.tracking = False
+        self.skip_fragments = False
         self.writeeventlog = False
         self.limited_deps = False
         self.runall = []
@@ -226,12 +227,15 @@ class CookerDataBuilder(object):
         self.prefiles = cookercfg.prefile
         self.postfiles = cookercfg.postfile
         self.tracking = cookercfg.tracking
+        self.skip_fragments = cookercfg.skip_fragments
 
         bb.utils.set_context(bb.utils.clean_context())
         bb.event.set_class_handlers(bb.event.clean_class_handlers())
         self.basedata = bb.data.init()
         if self.tracking:
             self.basedata.enableTracking()
+        if self.skip_fragments:
+            self.basedata.setVar("_BB_SKIP_FRAGMENTS", "1")
 
         # Keep a datastore of the initial environment variables and their
         # values from when BitBake was launched to enable child processes
diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
index e6ff1ff76..bf9bd4f55 100644
--- a/lib/bb/parse/ast.py
+++ b/lib/bb/parse/ast.py
@@ -351,6 +351,9 @@ class AddFragmentsNode(AstNode):
         self.builtin_fragments_variable = builtin_fragments_variable
 
     def eval(self, data):
+        if data.getVar('_BB_SKIP_FRAGMENTS') == '1':
+            return
+
         # No need to use mark_dependency since we would only match a fragment
         # from a specific layer and there can only be a single layer with a
         # given namespace.
-- 
2.34.1


