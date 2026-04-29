Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE4CFF8873
	for <webhook@archiver.kernel.org>; Wed, 29 Apr 2026 03:25:02 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3865.1777433100484685126
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 28 Apr 2026 20:25:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=Tx5lHyvY;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=95795ebc5b=qi.chen@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63T2sX031343308
	for <bitbake-devel@lists.openembedded.org>; Wed, 29 Apr 2026 03:24:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=/8fkk2BPK
	F/9UnWvHcVgpGilpukkRENDM1mmNhgT27s=; b=Tx5lHyvY24V4cWoDHC5Ugb2oU
	t4KzbRIFbJM0ibjltmcOaKJBBqyxt8HxUEwy4H/rYQVTXsvFDl4GgUJ2d1BH02pU
	VDKyNo7UOBr3YsrGpDT3yr/k95KkwtiDa2PQOo4ivwctIzB0eFiUbxLyMlfU1F5D
	9A/nU3/VP4WwkD3FRTpWDDj31Eb8arPuw81z0cEbfOQZz1vIJ1WVE7yCYLaFkzo1
	f8iD6Ugb6p7tXOUv2aYeO84J47/eqDlbqTyyKPemNon243WXSgG9lpRS7o0ge5ww
	HKjRxzF1ZlxBMfiB1HO+d4gzIgjd/7ZZUtzbgavZbb9Bd/HWSRZy3Uw+oejdA==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011028.outbound.protection.outlook.com [40.107.208.28])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4drmk6vctc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 29 Apr 2026 03:24:58 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b9mnGfV1UMguEBTYMPTs9aOX5ryi1F3vgviClcDGYBTt+FmbgcYRK9S6RAS4SuHYBkjMG4Vzde5DUPXHXgQI010+0V+xvN/KXFOgWmA2PUT7NPfwwMjFEx8HF5qbno+yIqvUR9fGW5kdacN7zNbPZzkCGy17msNaac0BHiMe5reR0LMRAXEiAwc6kPLTb/G39AXny+SH8i/4iD0lQeW5mRKc4Rb2I6UZSPMb9cxiBlZf8QpTOBlORqTWVIhA1+PIJthwKG65AnaF6741ekiq//eHZmB5nBDw4XPwE/I48AvrxaoOEtEhHY8AwqJrQV1OJ7mWtOH29j4/FZjFQB1LOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/8fkk2BPKF/9UnWvHcVgpGilpukkRENDM1mmNhgT27s=;
 b=PCX9NXPzjGTtJ71uXt0brswz/VytuCMJOPBaZ3UsgucnqhYa9c8k+ypA5oZkGcA2rAsPHtyv+K4x8ozn4OAUqgXUq2y3kTpIT3CssjvXwymkYKi2tkEjiauomJ5HLxnCoryRDWTy9Vpv58BhNlyF/R7H6BqKH2DVMspiL6YyeDfOw4cYvCj7ZMRdelQtQMVtPnkToJqZFOu7h+wL1SKJGQTmQLQRpTRCPjDNpReMevqU7OutNCcnn08VdjgdKJGYBPoqGSvXnCpolUS1EeYpQzOpEjnk8YZ8JS1Edxn/lNTGEHiEqHtWHqL/dXSiQt8UtVQjZGcsDO9O9Zv8GNffag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by BL1PR11MB5954.namprd11.prod.outlook.com (2603:10b6:208:385::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Wed, 29 Apr
 2026 03:24:54 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%3]) with mapi id 15.20.9870.020; Wed, 29 Apr 2026
 03:24:54 +0000
From: Qi.Chen@windriver.com
To: bitbake-devel@lists.openembedded.org
Cc: alex.kanavin@gmail.com, richard.purdie@linuxfoundation.org,
        Randy.MacLeod@windriver.com
Subject: [bitbake-devel][RFC][PATCH 1/3] lib/bb/fetch2/git.py: add optional major_version parameter to latest_versionstring
Date: Wed, 29 Apr 2026 11:24:34 +0800
Message-Id: <20260429032436.1075831-1-Qi.Chen@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0019.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::12) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|BL1PR11MB5954:EE_
X-MS-Office365-Filtering-Correlation-Id: 546dab3c-8e06-488c-278d-08dea59ee187
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|38350700014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 
	oF2JyF6kT9PZyOof34FBIP8n7N2QhKo4uVz+/FAcO7KVDgshNhqq63PKkofENRngq1GVgmLl9kzdCgUzUmxFYisuuGwgQKQIHDuwH2pJi/5pMfXfYF0Cz+WDDT5MAClxb+zVSv6ssZlZLaca8PrxwU5ZheykUEuLatuztgs2sATgqQAEukdkyOBZxkXoFuZCrx3yqJgkQE6Yqkt4LYW0VCO6ri6/fOgCxvYodLd5Kf9iyuwktu3ZUBouuHJvaa8MaFJFv+FsG0jTrDPGVXd0SauZ7zVVrrDpPY3Ojcpsl5JVX8PNBr21IDGWisaZkZ97VDdFYsaEy6YHmz9jnMBvOWwDPh9mfLmufDtLe/Eg/hV4P45WHtPDHmHatte8n6sBbQ+ylQpJIrrMo/MJNOTivjHPYN+6mfHRJSx+Vk0+Az0jU+miEAj7FEzS0bdwWDY/RpdiPyxjMjeNXcdxt+s2lMq8YVo2y0dnKrsyecee+Z9SIPPDVA8E8aYNIhbkw5f3jPmGqv5AQXjPfObsOOh8YYXHl98+nhflK6ct3I3vEGXb/cp+RQyXYub7Pb9e13nSjT1VzAeNB87fBRfhAyDoJf4JlGOffYmUydrrbYLfRDrg3kvE7JSzUEAD+unsyeuhoqnM//rNiE8nc6TFpqmewcD+y5JhePVTnRGyR3pxRf7X+WtX4lbmfirABCvmAaTRRgma45x/cv/A6YIQBzibRcdVZ0KHwYFoSrJ0Z3FLMISmvW3q1Mw2TTAiU7csggKb6GJZY8yvomORfLIfSh8RvSq2npzBbRQMygkEmJsLp2Y=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?iSdt7abt6BZq/dHbFUA/ntYu+zG3LyobJV0xpAIG8/w1s8JpMWVxK/5+BsT+?=
 =?us-ascii?Q?c7c2+IRD4/NVL7hhiyPwI5fxfgiSNGEATCXgeWoqq7Obiy8ZFckqLtaogtXl?=
 =?us-ascii?Q?Cld/C/KdoNXb9h1e1owpfSA0CXq2kuR07upEdLiPraVGMreLnKK7b/VeGuL0?=
 =?us-ascii?Q?2jJcsQiKvFrLYNYJzYDYkrRkw7+cCtNUi8nbSJIAvg4zZCMnq8iOMhtOyrDg?=
 =?us-ascii?Q?uwAtz+G/sLzUwnH64sSjwKtpJ4JpGBkrBJzF+1hRqg6IXTnprno2QRMQnJ4x?=
 =?us-ascii?Q?PyflabXxCptZ3ofNmtGUUkUfXJNzR0DrfjEwdU0C30AHwM//Fr+AEXvrgY+m?=
 =?us-ascii?Q?kBtTjQpJaldHyHG9D6Dqr27/ht2ak28dTQMyrtcI1kpn2qjVYpJueZFBg5US?=
 =?us-ascii?Q?PG8DRE+5KZFjrU48TaoAoxJpc5yjH0YKUsE4GztzdYj/lhuONjdrTrCVMwsz?=
 =?us-ascii?Q?ge0hFItJUvLU8fCQf6STMUAVM4LIjuDY5oitZNa91jDfTLopPAY841u5MfQv?=
 =?us-ascii?Q?9V81opv14osYavgMzGQ0OxlTySFg6K+FNUudLhrDkiN+OFqUZ+ajaeYjXNhH?=
 =?us-ascii?Q?jltHLYHY9bycTj9jKdbce9jIJXugl2HMJS9kiF7fnD2EJ29SmQZ6m49XvP7H?=
 =?us-ascii?Q?HWCPCBQ+o2nV3j4oJaplJjO1OeM8MlcIkMh3eWSDzFlNnIrpLy2N8JWeCq+i?=
 =?us-ascii?Q?XSo8ozxYFzCgluH/6whLedNVY6+d9pUrCpDo45h4pGouktIqGegZHUQsc2YH?=
 =?us-ascii?Q?hBLE/3tAdRAICVjPnxGIKStcWcnZojIN1sJGEeRmgMUfFB+Aqfe1lVZYEC3G?=
 =?us-ascii?Q?3ANFqgDTPtD+VtNy4Tn95ElcACrgmMrqbsTrEpNYRSdJJMTNFgPdh5lea2J+?=
 =?us-ascii?Q?K7L//jBu+KNWg4cKwqdzT2JO4wm2mo4hyzgzUq5zSRe5AzEl1f+gSvVTPtwE?=
 =?us-ascii?Q?x1CzL4rkQMVeJDCBHWGEMy0RbSFxbE/rQVFVCzXTuQYkSHBp1cOq3ULZchHr?=
 =?us-ascii?Q?VG81qo7FotzHlCalkPlFbtjnMWu7vSW0ZphVPg9lXYJHPpgbZVjoofXVH33b?=
 =?us-ascii?Q?utyuB6UjMGhLzmcFRIxv/Q1l01jSYm0q962VF6Zyd3kQYNuckuGsmUuQwwpm?=
 =?us-ascii?Q?FMIP8IJM+RK3IXFbWHA8rq/fRpNgSvaQxVNDUebBXPwHfa1va6sjNsmlGFtn?=
 =?us-ascii?Q?MfZ4d9jJMtLxvz42wsBAf0qxnV4cNpUh6RSdVRzK29hUnIAn+OI5vuvr3oJV?=
 =?us-ascii?Q?7jE6jydbp9njPqmQ+0j3GiBlHwp2KNTfaJK4j0f4371esMl44M++ikVfLM/w?=
 =?us-ascii?Q?wKCXxDGkWbdWJkhHdA9KROIbU8STHSuE75FGSY7eOjaV5d8sHHt6HdOx9TFC?=
 =?us-ascii?Q?XaHEQXG5EFD4nx6JIHcGzUvTOWlcaXpl5maUA+GkJDWbge/7hJK6mUjHgZZf?=
 =?us-ascii?Q?rV/8jTizpNbRSYFmFLFg70URh96YpfaEUAhJGaRKiK7JtqtaLShXm30MhTSC?=
 =?us-ascii?Q?XOkGDNnkyOXwAS71K0qik5ekV9MCJ6Sk8Utgx2AgRbVK1GWlaXqVeaedaihx?=
 =?us-ascii?Q?C28/YE5k/4CtIQBgvqdHNQ7Q9kOoCYQ0DCcfJmHDGhilcSsucGFG0MU0ERIw?=
 =?us-ascii?Q?mz/VrHpBweJ+zMhZxH7NLnQSNVQT1dg+aoEgPrZTUelNWm8fXWSc3Ktolv+V?=
 =?us-ascii?Q?XIcEsIr90S633p9rEIe70Hi7RbmQgSPwqW/00ZD07bsxmYTxLhnIFZjZTTDz?=
 =?us-ascii?Q?/L8Dmh/EPQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: 
	F1wBDgo5zaJVEtZhlvFAaPRytY0diC/zTL22yoWak5qTm86+GYazdtc7FepB6no9vauCDrwTmnJjb3bx6tSiJAFsvwO4FXGeRjZY/V2U1hIgKSvFyDK+p5EmJFd52hinN/FJUgJe9pZtbHRXFf288D98kq3E2QFV/0FndqZqfnI1KGMzZQcppfdxEBa0HG8EeNR4ZVZIfJLY6PXWldQ941usK38pJkzkOveoabBcHDnzstkK8AveBu1u0faZGNyoSfMM198f6GWMfUhAKYcJOCPOpr0zJ2c7ACS549zBAYlwcdKFuJ9XB4GTnRkqWMGxMQv0L8Jiknnu5u/EjWTD+w==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 546dab3c-8e06-488c-278d-08dea59ee187
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 03:24:54.3209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eU854JVzPVnZtGiuw6aJaHOzHnezcY6sU9quGGmOodSBOUOM3AWztia05quh2IHPJnU8IsSGxBDSTUAj5pHumw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5954
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: f-jqYV74Gdx7DklkQHTFjcpKcP35NR7o
X-Proofpoint-GUID: 9EIqtqQ6mRCQ_MoZc6u64u06PL6Rga_S
X-Authority-Analysis: v=2.4 cv=RN6D2Yi+ c=1 sm=1 tr=0 ts=69f17a0b cx=c_pps
 a=r8gZD2gelFFA3OdVKTiE/Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22 a=t7CeM3EgAAAA:8
 a=b4nhW9Vc8iuCVDfx7nsA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDAyOSBTYWx0ZWRfX2XN/v+v4xkfE
 DNOCF1EWZeubgzsIbu8P7bdp/YATVeZd3dYAnerO4VLHGwzhF6zeIeg43gB76OCGtsDzH4WHFIS
 B3V476k+429tCo0Sz2RW90A5NjR0CwOWap4B3kK5sXfmTJkABFfWHGdpTklhK809T++d5DYAL5i
 +oP94pnVxrfuZ+gnfCmV7vYswOEuVUjK9RZpXRpI3bxXdn++g3yJqRa58/9jbQJSSWMZsf2UK/p
 593zQi4qEpuGfo/JDrl+sp4inrLelGGCiyuOOGtcdLhEh4MLwTaZ1ZW9c+KsvCkT76+N1VQKoyK
 lmMwfevNvv++YbAlhoPr6NS4KMeW+/A1TV0es/uRcOuVO36AqDpsLAI1dfs0YLoXM9XyGViTElL
 CSEBa5nSwVVo1OeKbhBKikaT2Hw23uZvApwagL9cJW4UPl2mVlqGCJf97C26AltBMJ2EJYk6brT
 Twn20qPM0Wo2VLdh7SA==
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
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19408

From: Chen Qi <Qi.Chen@windriver.com>

We need to handle the situation of LTS upgrades. This means for version
such as 1.0.0, we need to find the upgradable version of 1.0.1 instead of
something like 1.1.0.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 lib/bb/fetch2/git.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 10eb63b20..3109a7256 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -976,7 +976,7 @@ class Git(FetchMethod):
         raise bb.fetch2.FetchError("Unable to resolve '%s' in upstream git repository in git ls-remote output for %s" % \
             (ud.unresolvedrev, ud.host+ud.path))
 
-    def latest_versionstring(self, ud, d):
+    def latest_versionstring(self, ud, d, major_version=None):
         """
         Compute the latest release name like "x.y.x" in "x.y.x+gitHASH"
         by searching through the tags output of ls-remote, comparing
@@ -1016,6 +1016,10 @@ class Git(FetchMethod):
 
             pver = m.group('pver').replace("_", ".")
 
+            if major_version:
+                if not pver.startswith(major_version+'.'):
+                    continue
+
             if verstring and bb.utils.vercmp(("0", pver, ""), ("0", verstring, "")) < 0:
                 continue
 
-- 
2.34.1


