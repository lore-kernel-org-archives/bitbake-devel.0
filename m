Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E34CFEE4D3
	for <webhook@archiver.kernel.org>; Sat, 28 Feb 2026 08:25:08 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.115709.1772267107830373383
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 28 Feb 2026 00:25:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=k9tEXreZ;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=65193f8e15=qi.chen@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61S8P6h02974181
	for <bitbake-devel@lists.openembedded.org>; Sat, 28 Feb 2026 08:25:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS06212021; bh=igbSm7ZvuvbLU/1gitdr
	IDEEhqTMTc1WmUUzrE7GoVQ=; b=k9tEXreZc0+dPlyGIlJmpXZZEVe2O7D3Q/ai
	34DKIH8xrr4DqKL4Mt8abKjOVwyzlb4DX0sExg2WXNlXbwcXfYCOHqryxlaVHPOu
	wySCdEi5+VwWxrQ4IGhF1c6P1qNgaS8DVibvIBVrRDFDnPS3vTjYU6857zRGwVMy
	ftElQi9udUB2owe4IqpvwKFhWRCcjI0FRTXUxV3gH0JaBs98FvSj7najUPss4ami
	XHJcQiNIZAGY+gFMiRX9dfqRhLSxBb6NRIemBhdeQo9PUloHLW0wpWmc9tgpQzQA
	cllfcfXmq6dzdU1cKhmxpalaAUAioa3OOiCc+7Dta3kKRipRjQ==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012055.outbound.protection.outlook.com [52.101.48.55])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4ckqb4g7u2-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Sat, 28 Feb 2026 08:25:06 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RT3FkmOFVgA75D+vGqmWqqP5rJ0c7gY8SoR53AEsbG5OsBgYsZPOBfeK7+OQkzXToRftu/uqS3qRhq9aRw6e6VnvncUbLjIG5n0udg6WqbkK7ExdKDtw/4NfJBQz34tApdJPwFtNRfLFXtMXOR80ONuBOb5n1MiuhzA6FOOBsBnP9c41NYoiCI7kCExkTNIvV9EirTSjTnPYwI3QvooWjxnF77pii2fxl6+qy7NNKl0W7a7tMQ+ZIaf6+ZcNalSt/6vTcDsp6Xj2BRMaaKbrUnc1e1aBg8iyuzkPBD5Z8YzRf28RVpetPXJ8ELVwwyiTauZFygqVJxbdkz3i3pzy5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=igbSm7ZvuvbLU/1gitdrIDEEhqTMTc1WmUUzrE7GoVQ=;
 b=yF+sCamdjn61oLtEIOk8jyOZSTsLt/BHH2iH9ZOV9RuKYgfOAb0pB/yZbpIZlUcNciLIniUy2TaDSw7K56fIzpNFQaAQfZ0Ub/Y2a9s/KRekIdU81bPyDAgM6wb1DQU5LsZRaY+7b09sFyjo7ln1HkP5jv+E9GHuFRuKNBVHDEqLi2p8ifFzmFfZZY4QODfY2CnlB6l2rVUu/22AMMd8TW4GVoLCspJYla8WOLLR9MZmm7QFmF7zNBdz3aXSwxLoyQAxJEH6fvsvpsh4pO1iEcU07BQ53nd0Yxa4VJdwUwEPwQPjFwMGXwzfVzHkgTg4nzUL8iFRa6JSrig36/XlNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by BN9PR11MB5243.namprd11.prod.outlook.com (2603:10b6:408:134::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Sat, 28 Feb
 2026 08:25:02 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%4]) with mapi id 15.20.9654.015; Sat, 28 Feb 2026
 08:25:01 +0000
From: Qi.Chen@windriver.com
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake-devel][PATCH V2 1/2] fetch2/git.py: fix update_mirror_links
Date: Sat, 28 Feb 2026 16:24:38 +0800
Message-Id: <20260228082439.3613864-1-Qi.Chen@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0031.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::7)
 To CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|BN9PR11MB5243:EE_
X-MS-Office365-Filtering-Correlation-Id: 23cbd7b4-8169-4cb1-7875-08de76a2de07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	kLcIwrWkIQWyI3GcCNv59OYk5Wna7XxRdordtFEpHG1POXKmrACugtWJc/7v+2a9aE674qH5mroj8p+is2BAkDRQQWqD25Qmt03THUYQ0sPG2y9GDfsNwcI6onGeQV7vy0oAfbqUVFgB3HnOiNlAP2YEtXg3TyYo2Bx3pGxiRNyOLufcWBo5VqZgw9OEjAaJakAPmAjm49UryHQVBZUD8dADYxazStDpb2UNGd2KdemDzQXX1U1cRyRepT0mS/KJesWbSKAbT4R3Zqo7KdmANz+BUlyCBLXl2Nb2IwZxaHt3Pq2fuh7cAf3PVnyqocHLCsxjMvQwpBDZ56b2RXDt1kLUqA23kv1zd809gsd6lzsvJLLgR04WgJl3sJ7Y+as/Uur03leWwaLc0QFQR9nYxQEKp7jczC7TJhPH0qe3vwj2GSEWG3JWW5GC8sNEC4U9lpJebqz25YgxxirNxcl/LBWmmbXj7MNgvyTNZYMdnhWy1iAVfqxmlPi2d0QfTZLpdQsVUyw7v2JlAosxIqo+4AFLCXoXoosBxrk5C7FcqIwhGnwYR9kXExI+03ZSIndXm0N9FWqRuJZA2K7w+vcI67Au8gjayh6p+TvtV/q+ZT2TwJ0DdYcTRE8bJhqbgLjO0UQ7nKimNeoHyQ2o66oa7g78x3N9ebOGTZf0Eos/2KPO+Kdfe/H6je6WEKLPEY8APqobxEk7lfpIg8E6Yfm58cjQkCTkZqpGjfIsKXbv84ilzpC3EUs30ntEV3JHEa5vZ5j10eKdrEyz8/jtCFAu+teVy14mUCbqIPBdpl5eG8I=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?PoWK17wLfrftdrBj2Bb3xAHAD8yXcoDsZHT6fk73OwWhDmxznq5BGcWbFu1j?=
 =?us-ascii?Q?vnj2Ve6ONdTdGZJ/1dZIxsIOOvTxJ3syNnMgdwzyQRMD6XO7QvkzicHYIRqk?=
 =?us-ascii?Q?+ul7hV++mK0Tqb/2O++7qnN2EY53fsyJFktN1Emxdxn2anxspG6z5fCSR49J?=
 =?us-ascii?Q?w4B/TyFmY4jkN3bvlhXRRRwpvG4ZPGzzO5UphGqr8Qr7KAXxWv1jO9MlFvZK?=
 =?us-ascii?Q?eD5zV1jUzybZnV8QqOA/Jt2Sp+hQD508lH4J4jnnIyEKCudbtkqxyuu9PXRx?=
 =?us-ascii?Q?475BzNTlbmLRqlCSBvUSa9Z8MlCPJo6It0Bv4T7tnVPtGUGGHimps04WvbB+?=
 =?us-ascii?Q?CAqCF0VysxNdxpLSF2qKVG3CVRBDNg1RQfVXHYsPwMi1UnQF/s/Z3SYLhi9U?=
 =?us-ascii?Q?zK1aqhSx253vqkjeLiT9yzzdPKf+qjwO2Dq8FRJ1btlaRT0or+x7SX3f1IO4?=
 =?us-ascii?Q?aUFb9/wdZZyHM012gWtqyiOJSRnOAXJnmbFxqOtzxYE1ycOPBqH1WV/hS+Jd?=
 =?us-ascii?Q?nxk62LZl/NKuGxxFfYXgezH7sVh7XfEuGuSktvn9S/ZQPDMv5epC9LFsrXWw?=
 =?us-ascii?Q?jOyXFBqk3zOZLTN79Dfu8rkRD7t/sfkiaa94ZF69z6SGf+2Wu8TAFc7HazWX?=
 =?us-ascii?Q?M6Ce9LphKoYTSsVZqz6IseArRgxiNc5lrJ642WtvqK7cAoDGvIePiIXRvYhC?=
 =?us-ascii?Q?162LFDPtlFF/8lv/MMrKnG+1jlF0g7hP6eUsfLvpzXDc+WjkJwqjpazCCY9p?=
 =?us-ascii?Q?CL532BJjGK0F2iUD6sCg24Lj1kmjF6Cdqxx9t8LkKbNEqPq0e8bJ6jpmMja1?=
 =?us-ascii?Q?dQUXfow60kVe4qjFIPVSv+ybNs37oyCGS7qtyWpGWrUXV0fL/7jAuRfvC+OU?=
 =?us-ascii?Q?o8eC6CKyjXhlPRVEmQraEYzdse3hcDrNcV9prhB57RFlDQOWdwEEwhJtW3RJ?=
 =?us-ascii?Q?OzDdGviSNmeh478rptjKSYmgPbTbCr/4Ci6rLu7bSppvUg8NZRBWyT9MJnzy?=
 =?us-ascii?Q?cmOj6T9RCP2bFqPBETkliC4ED0L5Ov3Jrm/hS0TXz0wgBAnEwMggh6vdGtg+?=
 =?us-ascii?Q?wSArxY47cLfY0czP268ooovTfjtjn+fhvPZMeQ611Mvit9pDlATdfz9O0uc+?=
 =?us-ascii?Q?ugtUflwAI1+OqdgV5e1FfowZPwnwakRjOCBXctfCLfzNkkn+vyunOFBGtZV5?=
 =?us-ascii?Q?vlLEZ+w17xeE0U+j3iNzPKBrFPliYzMTvsA6Nqo3bYdhYBnCF0zzAHdKDN5D?=
 =?us-ascii?Q?WP77t9nvwEmjLw2GjYC5qAM4+uyMgd9JR04z17svo9IyUNjZP5kzalVOxRxH?=
 =?us-ascii?Q?I3bTfMvUCQzKgXaPeeozZMZK5vGncBDic/9D+S1M2iuyMeN4OhwbsTc3SOnA?=
 =?us-ascii?Q?LUjNg6wOaHhoJ7aAN1n4MHC4tY9PqOK8DtePXVPPCqkO2Dwrnnl5ReVA4TKs?=
 =?us-ascii?Q?OGltCDadOry+Tu3/sRqE9EXpFdsKRmXLIBq1DgMSurcvnH4fk5NzAesTzwKq?=
 =?us-ascii?Q?yJ5xJPVSHO/jll8U1Udky9iiP4t0yXAGwp4h5mq8ujTweNWh7DujUtCTOsdx?=
 =?us-ascii?Q?flz2SDMZvO/rgOB6aW324ozQtYiU0N7MZDGrZKcbQft6jIKITRCnabE8ycfc?=
 =?us-ascii?Q?fM5TcBT+95Z8BG5SgSlvpjvcg+Ie9KLLculwyDSFvR/bvuWJv52OYKqjjqJu?=
 =?us-ascii?Q?IQfbiKjy4DyepCPL0NXcK9ozA+C00djzrMrw8sBOu11jvzz6tyaHmvv3XL8s?=
 =?us-ascii?Q?2TWEAYKZCw=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23cbd7b4-8169-4cb1-7875-08de76a2de07
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2026 08:25:01.7095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +iqjLyk5jGUivlEWoweGv4FvoWhN1+T4c03K8mBpbNfjBkgxUx5woePVHhr5c1TP2P6krVtKXCmYIJj/M/wr9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5243
X-Authority-Analysis: v=2.4 cv=LqWfC3dc c=1 sm=1 tr=0 ts=69a2a662 cx=c_pps
 a=FXm+OvNBiSWvAu5LmLLQ3Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22 a=t7CeM3EgAAAA:8
 a=vcIJP8nnVkELgc4RJB4A:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: Hyt1YBSaov65IrFl7KOOwQMepcnUnNbe
X-Proofpoint-ORIG-GUID: Hyt1YBSaov65IrFl7KOOwQMepcnUnNbe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI4MDA3NiBTYWx0ZWRfX/NoNF3J7whxT
 1qRsNlAP5TVHaPavJiWBn60TmPSGt5cvoi8HdHmneFq2TUTkrOVj4IzUhwuv5GaE5z/Cu/MPf/C
 psSMZ90eMiQ8/H7F7Ogjk1kvnlH6IW5QuXhTS4LUA0F1xKvf9xS/p+Ddzs5ARKGSEyjPTLxXCFR
 aWlyqI4CO03ThC9uKDQ9+tbs2zgqHMuRxNIvTeuD5nEVO5N+Cgc3BofHcX5I7htWakFHzMdR1qa
 hNfGNl4ixlWxyMuc5SXmvxX3kFNrD2P5Ss5EPVmkl2wTJBl4KnN4UIyVFdMXPFohkTISZS7Dxru
 Bbdtbco8TvzZWAaslEBvATiDYlGr9JKTSusGjTdnChseuDRqsO4u9vYe2q1jkfrqptqs3uq//f0
 uTXAahOj3+ntMQoR0b1EEgsxcs3tV1MVnSqOQ29wB1d+rrXlA0xYKqUhdyrrCL0G5248Utc5uAB
 mJOa2jBN2B59BZrOprg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-28_02,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602280076
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 28 Feb 2026 08:25:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19095

From: Chen Qi <Qi.Chen@windriver.com>

We cannot assume ud has the same fetcher with origud. For example,
if we set map git:// to file:// in PREMIRRORS, ud is using local fetcher
and origud is using git fetcher. In such case, the ud does have the
'shallow' attribute. And we'll see the following error:

  Exception: AttributeError: 'FetchData' object has no attribute 'shallow'

Looking at the logic of this function, I think it's the origud's shallow
that should be checked. So the logic becomes: if origud is using shallow
and its full shallow tarball does not exist yet, symlink to ensure it
exists. This should make more sense.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 lib/bb/fetch2/git.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 0fcdb19df..738174cd1 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -356,7 +356,7 @@ class Git(FetchMethod):
         super().update_mirror_links(ud, origud)
         # When using shallow mode, add a symlink to the original fullshallow
         # path to ensure a valid symlink even in the `PREMIRRORS` case
-        if ud.shallow and not os.path.exists(origud.fullshallow):
+        if origud.shallow and not os.path.exists(origud.fullshallow):
             self.ensure_symlink(ud.localpath, origud.fullshallow)
 
     def try_premirror(self, ud, d):
-- 
2.34.1


