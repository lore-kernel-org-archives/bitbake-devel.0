Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DEECCD4F25
	for <webhook@archiver.kernel.org>; Wed, 13 May 2026 05:24:53 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.904.1778649890087794905
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 12 May 2026 22:24:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=bu0D372m;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=959349fd7a=qi.chen@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64D5F6TI388089
	for <bitbake-devel@lists.openembedded.org>; Wed, 13 May 2026 05:24:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=MfCY/d2kNcpoELJZ5YijNEriGfAryY5nxSoLQcGLd9Q=; b=
	bu0D372myHMzp4vf4tVfW3jhWitRm3GYB8qWvlenZV4VvaspdBZVcw38C8obuxRh
	wLkDNUJ6Ha0bU68KZ49lCdwGRybSnW8aI/TOxENKe3XznnSCKwEvp5/e4fV+jVH8
	XpbEHNNa9+R6UBZ9j21ZsmSNSZPmzqAQf8Toeh0rUVTSyByagGPGGuEkKSQnR3df
	8eQMkYiKDK+mXDb61u/d3MdyDSVYrVN0hjJdGYajozBSad9u8JUagypp19tszN6B
	M9DWYAPz+WWTKnif0UYuieoaSPKhvgzPU7GT9E5KyvDPyxC3KMFwhLcEK9vDXg3q
	oHu+uINsXpqfB3tYxSGFGg==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013013.outbound.protection.outlook.com [40.107.201.13])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4e4ft787p5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 13 May 2026 05:24:48 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sz+T4RsDF3aKTNIFA1nuUwVJoumAv39m7AbVX7GotdbcI+8rKdV4wTUt8yD19D1d5OWva350OjnBS1Tly43aK1VjjYUsaWFiNW+ACWBeySVecGfAr/zVHL7Vd6JBYUr/YDk6GVbyvSfJxYKU7v8ilRSW0wqRlr11RqAZxIojhIJGX51tCmUt742k4GZPBpzZNbt1oHZkZAdoM3lwQ+0E/RMjIOcI5YoJ4yghzsQ8FFjrjOOVAG8t3r6ANJmhv+WLgdx0PgLsF4jZpGUbRvuPbhsIKNUrQtG4xO1m8evxKtZlHEcGH98f4NpM9skEuU3l5xuHPfaMu+2XlomxelMviQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MfCY/d2kNcpoELJZ5YijNEriGfAryY5nxSoLQcGLd9Q=;
 b=BghDodv1zwn4LvzMhp+85LpYsVLdr+QYlMVh/SO2sfCgOME4QExbGgZ/qnS+ra9/WcQ6gU/Es+6zawqreuuCuU226B6Ba4cy/psI9W/zM2UlbdbHnYNTb/QO+NUw0g88cJkhBLwgMKNWI6RSPjXe9QzMwgggEW9HqqxW3LZ8b1Ndl8M8tWTHuDW/MliRnC2WjrqJMKviD36LExoold+R0qeSvTZsHR2oUuJHAWN60aG0EOhdM3jlogq8WwL17jVbayBJFqC0GmbB0ByqVvV/2F6ZH36Vom85Ng6UPHv6SpMnSPinBQNf+OeNDocslHJIvqw64TIPkfNRnuaQ4FuEbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by DS7PR11MB8855.namprd11.prod.outlook.com (2603:10b6:8:257::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 05:24:46 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%3]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 05:24:46 +0000
From: Qi.Chen@windriver.com
To: bitbake-devel@lists.openembedded.org
Cc: alex.kanavin@gmail.com, randy.macleod@windriver.com
Subject: [bitbake-devel][PATCH V4 4/5] fetch2/__init__.py: add filter_regex to default latest_versionstring
Date: Wed, 13 May 2026 13:24:23 +0800
Message-Id: <20260513052424.2271877-4-Qi.Chen@windriver.com>
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
X-MS-Office365-Filtering-Correlation-Id: 065d5c18-1394-4630-3a6f-08deb0aff244
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|56012099003|22082099003|3023799003|18002099003|38350700014|11063799003;
X-Microsoft-Antispam-Message-Info: 
	oFEeHxGx+JDeXJtisQOhWwsiEQLgWxNnxOi12f19eKFI7piOpk69fvbxFuzaK3zp38c8PmCuopRFFft++9J1g3xIEdiNjXwpIXbaBE7vQGr+G68dNQFjU8v717sVPN883Vi1vrJT0VXwGuoryuYemiqaBF5KMi5PbUns5PsSjbA/X0OKY4wK8jXTREQwY42INaf4pl1JARKfn3/w66tU53A9Dd/M1YX6GWH5NP8LiwHoRRryRBVT3KI1MhdQnkcAMQpabfAzIb0qLWYMrlqTfzBylNwePntfpmSpSdC44ef+ywliwMp7t8nx38K6mbBHJdRfaOwPi7n6VX6u4MLb2R2STCwcxn/hmLSqDbgguUcqrsP4spcJz+cWK8yDMM87PSTZtSG8qtOnVMP3qWD/9fGoo74YFYXOvQcQkFsFSi9n3FH9GW8X9HXGEMALyde7cn+hNn3H9ua466FOf4XPMwPmoesvy0zHkSGd8Bbs8e5yhtXz6ESRGD4wCJpRtIpiT7zVNtTDDC+ECuGwxiiISs9VCctg27nhl/Y8rI2+3Jv2TUjlH3wyF/iHAjx5GPIDOQb2XmZMV/wMSucqRY/JaySwl3wGw7eI5fl2lGf2QZh3z9vTr0dSFUNAMCIfVJP/N68Djz74AaNjCfWmstILnp9ZsKAyueFfPTLF2RoVBTir0+Dft4olB4sDxSNZJHuZhezAUUoZWmpmKKsQevT3Lh9HS/ez7Acz57ErcLy3vzcoQxnsjM6wwYn+NPt9nepP
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(56012099003)(22082099003)(3023799003)(18002099003)(38350700014)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ZVsDn2m8aL9PQUx89PZn/GD188lxcfuALaoe8EMf2pGY+i7HQaEM5tUaGf/g?=
 =?us-ascii?Q?FyVR1Y9IrcqMxz7GrC4G25RB6wWn08tPbf0wHUNQy+VigMa5SdsmFbZC0r2v?=
 =?us-ascii?Q?n88eopCxGnM1IkpxMWe84eec3jr8V902anZRNvYvAVA73DShTR2DemijrxBz?=
 =?us-ascii?Q?70jVS1wc/XI8Jv9PvfKcd/W4OTy2jVlfHPLJsURpRDz2GEzQeRNuAjZNO4h6?=
 =?us-ascii?Q?tWuS2iJsPezcL6CDMGfqkktRdhyFQmqqQGHlj7hbZv5pYJatxc59BxyDJIeR?=
 =?us-ascii?Q?FX06haKg/y6kV+wTZ1e/mKhWqb4SsMpVGxc1egr4g8JKGqiWOIqtQClDcoI6?=
 =?us-ascii?Q?mw8EDUyzdFYBhiWfP6etA/WjL1LSTZDmMhBdpnQgJmSFPb1ChBARg6WUkYyw?=
 =?us-ascii?Q?z1qSJTT586517ny96yCmwUYw4inVrXKLRK4tZOGoDvM4/jqt/NuDtUqz0TN2?=
 =?us-ascii?Q?h+8LitN0VxRtwJfaJYt/W+45q/JncpKgUMZECWG4khqTheeUam5oJdSrm4K9?=
 =?us-ascii?Q?I6s8a37UZB+5DE4QGYJbRFNxMPy2BnP4Ort/Gdu3Vwjt8k5DPGt8JXBCP9eq?=
 =?us-ascii?Q?Q7TIfgMm6RnJnV9PICVr1Hov7qO1WOjrbOs+HUjyXaB+b0FfT2IBRSwL5Y7R?=
 =?us-ascii?Q?Z09MvBb40F4uVeBcl77XY5uM2ndJbD94kLFZcjSdAxS1mla+y9gAkowDja6a?=
 =?us-ascii?Q?41wI0UIiomYc3L5SmqzTQdHFaO4WxBD030fBgzmr1tzLdmAmCnbzB9eTjnEb?=
 =?us-ascii?Q?EgOtPodai48b+IVMot3HwI9ndVvXx66Jo9DkPpCn7dQGLjF++zcxbEs1uXOD?=
 =?us-ascii?Q?469uQIHG330SPYm15+3NGHfBteLzzFsRAV+7aRgERfKVUABRbLP45eQGK6pE?=
 =?us-ascii?Q?t85bnAYCBbZw5zI4RhH7q85rtbtLIZqYWbnJfFqtkg7IbWR2OkQ/qCFiqwuJ?=
 =?us-ascii?Q?J1nFyJLD32D0X9epwUyS03hTaLC+q6KhoTmiW/HwJe5Rmzw+vZKenhkySU3b?=
 =?us-ascii?Q?qGjxm5s3sbyhIIjyDggqChJaH8QedafcV/yVcUgKY0W1yGNSLSl9tEzvV1ZS?=
 =?us-ascii?Q?Oix5lTDjZiG6rNIIZp2bXG959Carvkuq0F/eAU2YZrw+di0VpakDJ2S0disN?=
 =?us-ascii?Q?xt0NbNRhJdKQbXoZ7Kcjtut/yFV1wsuYsAt0RfeNC1/hGAoUm0f0ug3s2D31?=
 =?us-ascii?Q?CwdvNBe4aMw4yG3zJyCIFA7o+liNEU6gw4v2tjY9Z0MtccAVxIl9n9z1/r7d?=
 =?us-ascii?Q?7P/5bs8Hs/8PVWG/NWOqGgfIHCa8ZQpyKrNyNjgf0R1Qa9CRjXjFJs6QuOTY?=
 =?us-ascii?Q?E9hbC9a7j/q1LKnMyIhb0oNwq0ZEhg/IpuvvrFj0xJb8PDkXMA0h3+Is6Ldi?=
 =?us-ascii?Q?FCy4HQjqpE6h4/OUBo6REgn20dM2LzpCBg5zmxq9H6eJ0qKeNWfmZDjUy0Gg?=
 =?us-ascii?Q?FAoOCxqEaD3CDhR7tZlNJqs+8nzgcnJjZlO4q8F94mzMva7+uArm/VGT4Koo?=
 =?us-ascii?Q?3L0FSqhvTFT3VcDyltxcwq6E1uiV2d/3ZUKg0c98Ukpq2V6FsRTepDe7ZHHr?=
 =?us-ascii?Q?BM0a3j8HE9bA1qi7rJ61jjsN4tuSLpnGjizsIe8ucB8ugLtpWOWMN6h9d++v?=
 =?us-ascii?Q?hJzXQI7TDcid3FB0C4s7Qi/JHkfN3/RFoy/lROj2jWKArbAWnJ/GnhOzz22/?=
 =?us-ascii?Q?jeyAv3tJW2ROqeobSgFTmTtT3s5YxaUBpo+u8oAJ0U0Sb/uWQH0HWwqzl5rq?=
 =?us-ascii?Q?SMWrjQMbFA=3D=3D?=
X-Exchange-RoutingPolicyChecked: 
	hJaJagaGTduvOT9yPPBMYhdGCrbXkBYhNBXK3hHDdea0Ey1nge6mFgMwhGJwx3tK2wUroMfhHY37dEZpmYAShFHZLvva6dQ4pLAOVzMw5dxX01l4uGQtNEWG48O/HT17K7YmhC0Y5W26aqgtAVtxdXtXK1SpqQdnhsXZFnkYKZLWnPx6dvZ3175b5y/+mMiSeAWW3YzzP1z2RRRkOxgs32PzK8adG/Wc2twzLRa23L9JMS2QNGVl8Jf4sOz2h7onuFjygh7bVPzuE2QtB5W6H2CRXAnzdBvo22HflLxEE1Cc4YbmkJOF5qukDK7qRnV1etC8cStZ7NpwoPjRIC8Msw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 065d5c18-1394-4630-3a6f-08deb0aff244
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 05:24:46.6654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4kTEr1SkM2TupYrEB4m3l9JO7Q8h1njFFtJ17jlUrC9Om7TVYelQe0OBMv2Za/GZBZfo4C1hs5sMfjIXRevrrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB8855
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: sdg8eTwvttLAPXuxmQmcJfUSBk-7ApJQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDA1MSBTYWx0ZWRfX9cfvKNGnEcR7
 HquKrCiKGuxydTZWtj7rNycPpLNiGnCxZElvezxSap4xCHPzV6/Jk01u8wHl8wThGzqzSOeMEm/
 EmIrqznjh/iX+MY7XDEtyQmTY8YUuQikwitIN8DWZHS3hOozWQS4WiTE5uKc/oiiMLdtE5KmmeP
 IwH6pOyje9Fs1gMKHU/hHqDIzE7xYAEJlsfK1JAGmjSJVaoDzuQrdlp8T1JlToqzPQO06JhMLWi
 8eMctQexxx1jk+3QudwF3rG0U+voveu6iUrpSz0lpqwwfVT1lWoZrJDaYJgyiDomu+HNnQSdJiS
 VWOY3NXd2s3NSr1DzzSrhgsjDjdInyItn9HkbX7hso/q3FjYIRDrlVAIstqRWISW+218bP8g0WN
 rXNslGWZ18ukm/PxkD/DhhyFIm+lPPiiwSkKWeABgkHczyzfWtmavy9XfA8siBlEBEznJ2mLPsl
 uHvUKuAqsZ+qJz4ASKQ==
X-Proofpoint-GUID: TVDjHyTbfxrsRJQ0kcgebocL1TEUY2jE
X-Authority-Analysis: v=2.4 cv=G6As1dk5 c=1 sm=1 tr=0 ts=6a040b21 cx=c_pps
 a=WlOtikQjNqa04qC7x4SRFg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22 a=t7CeM3EgAAAA:8
 a=emewfCi5w9IOduBEDPoA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 malwarescore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605130051
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 13 May 2026 05:24:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19504

From: Chen Qi <Qi.Chen@windriver.com>

Add filter_regex parameter to the default latest_versionstring
function so that fetchers that do not implement this function can also
take the filter_regex parameter.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 lib/bb/fetch2/__init__.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index f7d5dfe9a..5c01b9a88 100644
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


