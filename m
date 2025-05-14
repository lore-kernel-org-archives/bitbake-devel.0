Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B7ABC3ABCB
	for <webhook@archiver.kernel.org>; Wed, 14 May 2025 05:09:38 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web10.94969.1747199364070930763
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 13 May 2025 22:09:24 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=72298db702=qi.chen@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54E4RgnC021215
	for <bitbake-devel@lists.openembedded.org>; Wed, 14 May 2025 05:09:21 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 46mbcjrjhd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Wed, 14 May 2025 05:09:21 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RsNh4YBpMvi32JOjHwPS6SZKVZZVgm3wjMB/P5WzaM3vPght7zfH1olWu/eGYVCxLpY90Ruak2D9PqO5sC7CmEFPpcSyPjWWuf3A2LX6KXqhyT9kngbHauZBcE4BsI+qmbt1DIlqYGqS4Cl4o3eTkGqhPiwVf5SL4qEPkicqCwmJUpcxhoVhJrdXsQtyIVREuNCMMCdAdcqQPWf05C1XyH8hpPZhir/YrAPMGrZG+j6nsTprc8mCQ9Hixidub2HdPzFIDkkX0Qet8DBuASAQ0mlvU7JRAjbCWrtTH/c8DKFwzF+6/mNuFLJyOSK8cX5mlBval2cly+ger5K6Uq6uIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oYOuql5SGNrtuzvNq65N3VGCPYFqYEY5Vy/YouCJfGI=;
 b=EYf5+xbk9WS/ZekRhxII8K6zJQwSsf2DoCmF/oAmqt4Zv/D2iueHshj/r7wJx+tL+LPzoKt5AFiZQtkCUaW9UaAasJoeOV81HCjM8zZyCQPEwnbEc1LozGgRb/ejHhJtwTbfchC4YbIUDX9CPhTEvLUdqv3DDfd8eIn5DAwDlL8FZAv3EWu0JzBG4FlA9OLna/A6ZLK55Dua2r+XsWl+UcMQR94AlLmjXB6U9yvOfeTCcEbsM39PelufgKxgNcJl4cn3k5ti7xM4uwO2bfwCKs8a/S1h6sNa6a23H5z1qfBTW72+QPJur9EeeNEakd5B7S0jS9xy4xfFPfSubXD5JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by PH7PR11MB6905.namprd11.prod.outlook.com (2603:10b6:510:201::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.26; Wed, 14 May
 2025 05:09:17 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::a7e3:721d:9cec:6093]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::a7e3:721d:9cec:6093%5]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 05:09:16 +0000
From: Qi.Chen@windriver.com
To: bitbake-devel@lists.openembedded.org, liezhi.yang@windriver.com
Cc: qi.chen@windriver.com
Subject: [bitbake-devel][PATCH] fetch2/git: fix shallow clone for tag containing slash
Date: Wed, 14 May 2025 13:09:00 +0800
Message-Id: <20250514050900.2096691-1-Qi.Chen@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0014.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::17) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|PH7PR11MB6905:EE_
X-MS-Office365-Filtering-Correlation-Id: e9b3bbef-c6ac-402e-b2bc-08dd92a5799c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?DrUrHxo6eRJk2RHsT9+JmGYp/vZgrJURxh1IaoTIq4390UaD/Hhwza+ncQtf?=
 =?us-ascii?Q?sCX63dieX+Ab4t8k/I1NS2MbJHObx7Ud9amInfZ404MVnyPNZQimF2COIrds?=
 =?us-ascii?Q?viz6gCVOLsQz1gpEoOmzwL3+15WoeVe07o+VD7SKD08eE0CGCRqeRAjOh7hV?=
 =?us-ascii?Q?UprJWlsh4LNwKUfjF+DRYYYIqv7yoVitUvxroWrlTGXKp9LFmRyLIrfLGm8K?=
 =?us-ascii?Q?2HPJlzCpIDUg1JHzwdnlnFklxy/fd88IQ8EMhuqQbEzCTCEnsnX7ITlyo72X?=
 =?us-ascii?Q?Mh1vMcPkxHtMWtji8MqiRQQIbXUa5rPxNwQzQRxc8yY8scYZY/4vr0qi/xZC?=
 =?us-ascii?Q?G2NRpLl1C7Xno+Kq7f8Df0Og/zq5y5L9u8jpEANhDkrvc7cjmz3WL8aUTL5Q?=
 =?us-ascii?Q?6RW/ooBe5rV/sZgsYTBtz9MPuqSDg2q6ZEOE9u/fYheRADNdCXTbV5DTU1xr?=
 =?us-ascii?Q?jqbA6tuf3B+P6lA/E38t9hZ3BiB0C4/h8aNdCpGqoMX6VzuBMl9gxxgLg4DM?=
 =?us-ascii?Q?1oKnCW4HvaHS2lKIIiUVXR/NihDqzjjtzl8xjlr5qdXxXVVe9/lR/R2liZCz?=
 =?us-ascii?Q?bIaxuGWCgU9pZinvsytYhuNB1OmwuK6yR56IeRkrcEh5rvtAKtj3wIfiRuSB?=
 =?us-ascii?Q?h03r/uLNK9F7GHC5TXdlPW+SRiOoUtQxPT82u2x1C+yncFam1cVrPqxN6F65?=
 =?us-ascii?Q?jMnrOD5dAgfcgBAq8wYVwS7tDhxAjI7NClzgwnsW5wAR11pg/PHu0uTUhvo1?=
 =?us-ascii?Q?k16t7J01Yd0+sDlc+VU9IutEMEOdWCu2Cu0mnfPOn729qvRfOu9DJS8hPugn?=
 =?us-ascii?Q?Xfw/u4OOgJe/KyWCt1IP1OX1hFV39tNZqVcwcrjPhTOUm+UN/pne7e4ZHXep?=
 =?us-ascii?Q?ON572MtG+aCWfTHBGEne2RXKBTbv27DelNg/pAN2C2V9xqXXfJqWVhU3sWLG?=
 =?us-ascii?Q?ghyZ8F9EtPNwTMX8oXYmEWsBFZQwEt6bNVtBU8w1NzMhZ8Ca9wkRoCnCQKmt?=
 =?us-ascii?Q?ON2A2/NRcTbzaw5shJrOj5EHF6WyqmKc/npKUmojsl4KCYDqB4yEoi0jTIe1?=
 =?us-ascii?Q?vynDkUg3dTM2g+LVkVuv6Xw4I64LUtnFfmANShkU4w+j8u2P34s/kWP+2h0m?=
 =?us-ascii?Q?VT7xn1KplFDlEy8z2pL2ahbumb7fxKRp2siO8xdsiUoJUgK7+ZjzL5YYtkAP?=
 =?us-ascii?Q?IoXQOCAuBvtrTegU0QaemTr6EJWkOunjWxOPANTm7E7igUbD3xi5ivRgQNwe?=
 =?us-ascii?Q?qdDl90PFwk94I6stlTg7udUvfECkF3qwaEAHyOK/u/dL9hwBzKKvpGtXZgHI?=
 =?us-ascii?Q?b5wl6t66H1YgNcBN5FXAikZsvVYQwcwqtGEJN19XYIgViXuHrSaLJ9jglNYl?=
 =?us-ascii?Q?c3UVW4pqV3gtLpxsjsc0V71eoUSEBN54hARAOSG0vD9yOaFXqCj801Ls/Nga?=
 =?us-ascii?Q?GCBtW7B+oVdZsGd34EjJAIshhl+uRR5vul91zHIF9ZeUR7tHz2CzD2rRmHu/?=
 =?us-ascii?Q?Cst/mKw+3tFlixc=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?HtuNhlrGKL0TneuFJRtY/fjGlcRTu3E+epRGyDAgAb7UGxv68+hZBDZIV6GW?=
 =?us-ascii?Q?eQGGWI6ZmfrpMdiI4wmBelBZjljqUnlKBWU8uACLOBNoMjTkOH+iU+XEX8Hl?=
 =?us-ascii?Q?7eo06XeEMYi7/8T/xb/v3koFdVPnTAhmaL/nryeB4oaL6LIRGfAEYjFaBKIg?=
 =?us-ascii?Q?GrsNQrla86r00kRlNXyTxch4jE8hY2GMtfuOK6kJayY3bmxaJt8LNwn1HFBM?=
 =?us-ascii?Q?5J5qcPgHDjjL/KJPsX8oQ+hPdB1K6bj4SbHWn+BbZ9g6RgJHzrD0JhdNrp3S?=
 =?us-ascii?Q?qtpgj61dizcGmOwE09rTyTLFDivHAjT3WdnC8c7rczPvlNXRSLq50lzegFDF?=
 =?us-ascii?Q?9IU64Y6tRQCVIvWNNvs/80+iND0rUAPEU4Oo3TiDU+0rxFocQ47N6xuHv4NL?=
 =?us-ascii?Q?hW7g80TQqsTYFYaPSTZ2UTbrDhOtwuVjYvIkzBSwTlrpcKFnY7sSVJqJCpEE?=
 =?us-ascii?Q?oagpltoum697BCswKum+jrv/XaZPbBUqut23I7pW2cxZMMR+INyls69rbbYN?=
 =?us-ascii?Q?nAQV1Xtrfc7/vxrdTx29owqLc+Mpa2GvTEeSoceCF5VReYg89H24TjMVl9hg?=
 =?us-ascii?Q?/CYviK+nVNTbE0/MGLbq+ZFLEcAOTjf2kg/Rmk+FTkqk61Q6vbboCyxRn2p2?=
 =?us-ascii?Q?HH7YKOPlLnpDG9GbZron6FvMjCGDC8KmH72R6lUh63jyfYtiWW7Gz4u7MuJV?=
 =?us-ascii?Q?5VhZ4/WZEFhX30PIqMaNkhzLO9D5ihLesx5rMf2Q0P4Ymg50ValhDONWucsJ?=
 =?us-ascii?Q?Er+6oclwRxMF84wEQsDEux6eNKLB5BwUUvFNM9/baM22qq61Lwb1W03fdU88?=
 =?us-ascii?Q?WSCvwPbT9l+y5RqmULCvQ/7DnmXFLeTKQz9O4vu9Jhb8dShY9pLyzW2rztXY?=
 =?us-ascii?Q?8VoQRRtsC6hLuZEN6wLofLjeRVN/cU2b+xRVTzwRnY9K+vNUCbufL0PO6lSP?=
 =?us-ascii?Q?4qwC3jXs2IR8pjNUvQS/n1sSoOmNehIdjtMdKJ9V/XMpLBLXBcWPAPC2y0tY?=
 =?us-ascii?Q?d/dKM6qGyS/YT/TDJiV8kZ812dHUGHw/NrniZSxTvCdmURLvSKdtGf+Xm9+w?=
 =?us-ascii?Q?obhPNrfu8UQ3CKfQKk8Dswl0Mm1FNzUch1Yoy0ICT7wW4dm1ZPj626gD9XL8?=
 =?us-ascii?Q?dYkIqxz8iYSVrgKN52tHJfraydplyT0vijqaQpJMyxXnmwRYrRIHonCGz0sl?=
 =?us-ascii?Q?KYoaX5/6STz7Q3v/noxK+xLjbu+6E3Qg3PYb26Fq3x29gBqiANaz3B+UUF+p?=
 =?us-ascii?Q?nhIo2MLDpwLFKdCWTCFCOSYNq2qU9plRbjNFBAIGooKiCGzj2C8t+7FWsm7e?=
 =?us-ascii?Q?eADn+V6Q1JxjcxDpc4t74ugjVzxacU0ATH6+apzO7t6ZQcZNK70gyU5DYoWU?=
 =?us-ascii?Q?yJ4YhurZBdUz6YFq0gqsJ11tyMRca7DO3W3K5Ei8MLDfjN7JfUfAVYEXw0KQ?=
 =?us-ascii?Q?SAn6Drovq0lsYblkDYwRyrrzxkN3A3zmzFqfmWFkKYETxHpLwsXtATTQZPAB?=
 =?us-ascii?Q?QL+52ATENprXKI7aucOclIhVxD7f2ySq5/ZiwdvobXnKt2IbIqof6BIFgPcu?=
 =?us-ascii?Q?0IBmyxU3tiqzsLRmFzL8Q+AO+OSeDb16JQxp0Df9?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9b3bbef-c6ac-402e-b2bc-08dd92a5799c
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 05:09:16.7779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mttDk16QkEgoGE0Dg/tlDGhn4FQoQwk4qtzeGEOA+NPGi2rklz6Sh0lDma0xNTn9sxBrsv9jAwdENn0X7PvXQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6905
X-Proofpoint-GUID: y-IYBdKRP0kt155MnXT8FD-Xs70jCgnA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDA0MyBTYWx0ZWRfX78r9OJoGHLDD ZUbm6Ah4AcwZs5dudqXMFY1lHuE43U6J+e7UvwVsjkFlAnpHAPPM61uk1Ygm/5R7Zab1Z2wkH3I U3ZFupSnxVi2qTOPZY4pIp9/Jo8idpVkCXhCeNev3wkGF3RkuHe5b5a3hyJZGQGQIWwxeGhmzVd
 aXD0/KcQdvOH3kmhgIx7i4FDDVcB97jEE45q47XHmuD2TK8ZLfLRgkUAsoNDo7+vsI3UwRQU8b0 eS4rL/vBnQ5+Otra2XSyFRnNmiiKF/auExflCy5tRNp827mTvxuhCSmNDzi+1l1rMVw1/KUsqLC wib+2dBocVe9tzhsTyqrorrPTzEy/1KLX9rA+8p4HJdtJm2OZUA1kF6/gw6zpbPxvV8hOrlP6NV
 h8SzpUqNWwgFM3VcItVP25Xn+GNVdyAfjZ9og3Bt/OIWLaBvfZ20OaT8Q78z5fdYcVCR+Z4W
X-Authority-Analysis: v=2.4 cv=dYuA3WXe c=1 sm=1 tr=0 ts=68242581 cx=c_pps a=nskeBUqQUen4dZUz4TdP1w==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=t7CeM3EgAAAA:8 a=LgS0r3Rq2bCD6Mld5c4A:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: y-IYBdKRP0kt155MnXT8FD-Xs70jCgnA
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_01,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=910 adultscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 clxscore=1015 mlxscore=0 spamscore=0 phishscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2505070000
 definitions=main-2505140043
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 14 May 2025 05:09:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17605

From: Chen Qi <Qi.Chen@windriver.com>

If a tag contains slash, e.g., debian/5.22, then shallow clone
fails because it's using a wrong ref.

To reproduce the issue, add the following lines in local.conf:

  BB_GIT_SHALLOW = "1"
  BB_GENERATE_SHALLOW_TARBALLS = "1"

And then run 'bitbake debianutils -c fetch'.

What the original os.path.basename(ref) wanted to do is to remove
the strings such as refs/heads/. So we do it explitly to fix this
issue.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 bitbake/lib/bb/fetch2/git.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index 11cda2007d..784a45bda2 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -639,7 +639,7 @@ class Git(FetchMethod):
                 extra_refs.append(r)
 
         for ref in extra_refs:
-            ref_fetch = os.path.basename(ref)
+            ref_fetch = ref.replace('refs/heads/', '').replace('refs/remotes/origin/', '').replace('refs/tags/', '')
             runfetchcmd("%s fetch origin --depth 1 %s" % (ud.basecmd, ref_fetch), d, workdir=dest)
             revision = runfetchcmd("%s rev-parse FETCH_HEAD" % ud.basecmd, d, workdir=dest)
             runfetchcmd("%s update-ref %s %s" % (ud.basecmd, ref, revision), d, workdir=dest)
-- 
2.34.1


