Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF7AC3ABC3
	for <webhook@archiver.kernel.org>; Thu, 15 May 2025 03:28:56 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web11.4949.1747279729288377632
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 14 May 2025 20:28:49 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=7230864b24=qi.chen@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54F31Kro003438
	for <bitbake-devel@lists.openembedded.org>; Thu, 15 May 2025 03:28:48 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2048.outbound.protection.outlook.com [104.47.56.48])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 46mbcjt271-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Thu, 15 May 2025 03:28:48 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v0H8KUVCRWAUeLPWoSv1ZEkzruDTgWPNm5CYcHHGAm2SZQaaGZmT09lGleuV1CmMM9pAApbZuNeBJYACeCxmLRmzvznj15zjOvKVHULsMAECNVNE0kof6jPF2ImIfrpSUZMgah9pKNQc5Um9eavxToIMIi9OiiPunpcxfz3dnfFt1NSl+lvVBMwPhVForAsBoMMu8D4ihSxtFaeWym4dCKyq6p5bg1Ndx6EcnRHsaxWkaLxUvbaek3NT8L+QTompYniImxyZ8VFmYCpaDuxkuOAgZt6fyoOZxfwL2/exU1d4FHrarCiW3oKAP6gwyTGcfqeazKW+nwzOiEGp8QJJJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jpTww/9MZZkKzlYgDN8OzXJoz+J7kV0nWBNWUMzhJiA=;
 b=HUmPmpFWew2g8CDiZGcFM7GcDhFyR9zVbh+dfmdPy0+gVI2R9hlqCGBonUjfvWPQB2upFn+eGbe17//QwEucP2Yn5H1awsBAv3OE8elbOj5Db0zn8yFIKm7Yt0irll8yPh4iEvkSrlSN6f4eahkdhSJyAOlJqD7xV2mUZWnT+H2VDbppwEPT1R2ejx7JPqyFS496RQBV4wRU00YrwlXJ5+xyFVP/vnDBfEQfxzds/z27gQzsPwQYgL8tbFx+ZNPzW5Iy/zbeq/0l7q4tgEH7T2nNdcuwuq9eiNYmUNQc2F0iLqtpTItDvyGOuzVCCcaqbs1NuwnPqD9ihGvIxNK44w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by CH0PR11MB8167.namprd11.prod.outlook.com (2603:10b6:610:192::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Thu, 15 May
 2025 03:28:46 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::a7e3:721d:9cec:6093]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::a7e3:721d:9cec:6093%5]) with mapi id 15.20.8722.027; Thu, 15 May 2025
 03:28:46 +0000
From: Qi.Chen@windriver.com
To: bitbake-devel@lists.openembedded.org, liezhi.yang@windriver.com
Cc: qi.chen@windriver.com
Subject: [bitbake-devel][PATCH V2 1/2] fetch2/git: fix shallow clone for tag containing slash
Date: Thu, 15 May 2025 11:28:32 +0800
Message-Id: <20250515032833.2189725-1-Qi.Chen@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0019.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::13) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|CH0PR11MB8167:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c8f737f-802f-49ba-d0cb-08dd936099a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?6y7/lhS/uBGxJnHJp0I1U079zHmHa48ZVJqUga2Ewq1iZnDxqBQuDXm1Guqh?=
 =?us-ascii?Q?5PF1Qa5QtaFkCYEdT6AxNrode6deILT5vzqeVGEzQCe1KZJ5v1rLCcjTf05s?=
 =?us-ascii?Q?fPrOzU6VCrkMklI2jWTIFksKFST838TcaLrTF6ms2LOxh4wCPohDbPDvMMaJ?=
 =?us-ascii?Q?ZJ5yIg4opaJvp0AuDuluEQSsP3RMsTTT2UI+UW0WzRnohVEsGALlC0U6j/p0?=
 =?us-ascii?Q?OZNLg6OJYKNZA0X6zvWrJ2OzjYlhyIvcIVmrfhjqUyp0EL62PlnIFV5NN4mN?=
 =?us-ascii?Q?qaimqjS0CAxWTPQzdk93maGRQycpwHfZ7JORkD0dpBXreXCv1yKhSGav2idA?=
 =?us-ascii?Q?OumznXSz9ZszyhSJjcxQr4G2imnNiR+way89XQKlygELe+JRsJg7L/NJ2XoP?=
 =?us-ascii?Q?djQ/f5dIWf3YJCUenfY5fE8KHw4vvZlafF2aiaePu3wftesSuH3RXzYWeW5G?=
 =?us-ascii?Q?ldQkw0LthP1IKvx2Nr1/fP4rBc29r1gUSyrFX4LNun6RIUHaQ23Pr6Nrbq93?=
 =?us-ascii?Q?zRgUhSeYshXRs6SzmefvXmbZYoS/aKQIfbm3QmRRkpsyWX+ynuGOwulDOavQ?=
 =?us-ascii?Q?iRlOaKieVGxhqaWD0MvC8JnvvGc4Il2Y+UB/KzzSiNF0MguoBgukyMt58HBw?=
 =?us-ascii?Q?hT5KhWWW0LzY+2g+xd2J5/xHjlfJjDL6G/Tfy/xFVxVjmJXkM6o9weat/mMS?=
 =?us-ascii?Q?9CeNn86hMjn97rShuJq2NmYLX4jtkeg5nbq6Lxb8TmT41xRmHV3jjBUwwUyI?=
 =?us-ascii?Q?UMDe5KmIjqLXWTtsfRtvCf7C0GUJ3Y18nBVkABlvFZNSF/EaFEJyVvUfAMSM?=
 =?us-ascii?Q?IXe6VyID6Uf6Ro1Ny6XmRu/CHFJqHI3J6Tixq+dkMIKcJ2EyFUrCEHQQvDlp?=
 =?us-ascii?Q?u17deF0cHREFLhOCB9as+sGgYNctEVrCL5xF/o8Mbd47SDI0kML6f5etpXyS?=
 =?us-ascii?Q?WF/ZfXe+eS6ApVGjKIC1S1q5by1CctPbOZOdyU5s/k/l5GSNNetZNZkPlu4B?=
 =?us-ascii?Q?gHUrP4LSJK32Rivrb1GnWta2ZEEoBICPDvYEExS8ZK7pqREVeYyMDeMikSIy?=
 =?us-ascii?Q?IqZ3UPN1MPekOlCqZYBzh5gBmJa0IEwYpG21f+sKvVLPEv4BhxzE3AALcISj?=
 =?us-ascii?Q?aGKYr2r5Huepg4z7xWxSMzIyFjqLDK62xZ/pFIrmOiUSLIXyrnG0W79zI2mX?=
 =?us-ascii?Q?jdrJK+ZodqpVICVWidJSp6CB3RN7cABGvNK2eV1GqNSLO30heWSoPGAJ0hUw?=
 =?us-ascii?Q?B1CXLhRoJVWrYxpFP7nvH7rL6HeuWaDgywetCCz1JdPAUmXiDvVzSBCjyA6D?=
 =?us-ascii?Q?Cw1YqdxkcyodHTzu1CevjujLigsis+HFndj3GsCoGwzAulLllYtFVgIt3163?=
 =?us-ascii?Q?hbxtZrUOiAxUY4GO8iT4pMBl1GnPfWBxMtqjgFcJPRdfeub3Gw4oJp26/Fs0?=
 =?us-ascii?Q?LGLvvZmTd9xJNUSMA/EXG6AAM1iozZ2Z/BythQheqJHYmkn+VnI9mSBg9NVj?=
 =?us-ascii?Q?M+GYI33xsYHgvOQ=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?gH/3FZpmwAXHwajmentzOIVB152IzacOIikkIhNdjHYaQPQQn22ejiFaz+R6?=
 =?us-ascii?Q?dfLJAK06VWAmkZBee4m7CGllPEzytIOZfeSPNxRlTR9lTNbbX2r9m2QWZjSq?=
 =?us-ascii?Q?7ksriYHeGlVP9pMPlP7c8hGRF3LwbAEfA6Yb+UrRV4KQcMDiaUL7o+EDoTEE?=
 =?us-ascii?Q?Va/gEi/nez14+5ES+63/fSnUjw/yUywGo1IK4vLBDIEnRm+ilkiWC0WUld6/?=
 =?us-ascii?Q?kLlj4pdP8Ycwk3Oyd5jBzRWSDUM+npIn9DmPZOTh2oqmk3nvpoiHEElAeHqj?=
 =?us-ascii?Q?o8XNqX98rJ7fwt9OtF0QMP76otc/M0nKVzqcZEmaYwPSN8in4rEu9Y/d+mhE?=
 =?us-ascii?Q?lZRmjHfxs80D4lzTt3KvTbTKSJssU89aDHRptDtn0ZYOtWolZEaA92BunxvI?=
 =?us-ascii?Q?ti0BjKoRkpuMCY8ulc6sZ2OzPfRJNkI+NS/6fGVizV4N9E2JaGF34NnUWq0X?=
 =?us-ascii?Q?43LLgpx2KTrMFgmru7RLRWJbshcJ4U+hFEI+tncJLnBGJiBmgmgEo23r2eB7?=
 =?us-ascii?Q?/14Bo6Pum9ornuZI32oq/7G//3jhoovadp4dztrHHHduB4HPYdU5CYZGBGAs?=
 =?us-ascii?Q?P1a8aM5iwojA95xaGAHH305a8J+V4IGf5Cbu2cSYENLBTfwdaT/VSCOjV6le?=
 =?us-ascii?Q?cG/6H/rlKCzvTOaNDZRnV9f8xKQxRd8BLE6roAYLg8tSUipEJrWwCnwt60Yu?=
 =?us-ascii?Q?2xJhuXFpbktJmm9723T+AOQvbB4L58yCejWo2SVGqFiC8N5VMQ614s9Lk5Bw?=
 =?us-ascii?Q?VTuRud/rP2JktZ/0ChKwDYEpBcRn3ZtibZp2Gi4K7WZvA7XWPAqYP8QPWF8b?=
 =?us-ascii?Q?OzpXfGrGFwR5BoKH8w/hbK9rXS4JiNK79vABv3Wk2EopecRAY9RKA/X9Fcw1?=
 =?us-ascii?Q?Tsi0rXiOACZDYKOgEC7atwolRPsIOCBhp6HE4JQlNJiCBaplBWl/v51DWr1q?=
 =?us-ascii?Q?llxR2+6pUUP0RnXmZwrRkUMjwQGPI02luJLSQBhOY2s2QxJdKet5JYS6XCl4?=
 =?us-ascii?Q?XPjrbjWOo+JjlvDe0oUSxk9wZiDps2Fgs7GsXGoStwLJzyhc5aSrJGQpaEY+?=
 =?us-ascii?Q?KDByBE0etHQvT85xV0chseky2wRD0TwtsZ4byTR+eOjgkMnDrSyCf7g+Z0Zh?=
 =?us-ascii?Q?cZwRfDLAKtz/32Co4ZxUQhBS+d1r3vdvEnJdsas3/vZfMzynKJ61QyTw6rVL?=
 =?us-ascii?Q?cNfVZt1Rew45RatUwewvKkuI/hiwv9Z0P/mnrEEVZIlyxt1Tl11EpfkvtvDi?=
 =?us-ascii?Q?tAIYvfyqC26/bmYa5zlL2vMz3O6xc09ENIT5ZC+nyRqUdFVuMpMC/Y8bJsV2?=
 =?us-ascii?Q?MWKTEaxRY9zSmbF33kTZEsPk5e1v+Jqljw2lAVapVcfn3pY9eEjyxE/0sA6E?=
 =?us-ascii?Q?m0b2bvkk8D3RBuqE528+F6Wts1E48rHmMzLgE3lExcMpLMbaFWHlrQ43XiFg?=
 =?us-ascii?Q?rpYazTllHWah9SRHXD1JsgYtPQBngPZGtPLJB6ooROkrCYajn+L7bgiPqfL1?=
 =?us-ascii?Q?fdpqNUc5DJMPXBUCrSkAKwL9Dhd/epNx246f0L14R9vwoH2ijPpZp31W9DwA?=
 =?us-ascii?Q?RyKEtomFPgC1l/jiSTCbWi/i4ZMJO0Y9MSNmI48q?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c8f737f-802f-49ba-d0cb-08dd936099a1
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 03:28:46.2036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MFauI+q4fQ2GtMZeddYmjmrJobKN1wKBqPurLT4itcD5sEU+F70t9zBKUlORWytc0GMCD74QY478+on0TNru6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8167
X-Proofpoint-GUID: 2ACu4BbbMRX80XEElTIIVXMuwbK2s5lT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDAzMiBTYWx0ZWRfXz9hJdKKsVh9J 9cHF9rzgZBZrjnSS+IV8J0rpWnzEL/RMR3cOawYKC8OnsdwdS3e3CwyeX+pb+YVE4VUNFpUWieG EUmbFXGppUXEpktPFGmXFRAvsY1UBTt9Xlovw5Ams3O6qfhK+H017ooZveI1+cIHll2196qToOD
 OZKV0dWWWdIXrJHo6J9CTSdhzfRLK2i1mH995maf6Hk7BGIqrMgh/SQOdItmNlxTN61Na3vmiUl RMvNgZhbEmJeU1oiYxmA0+1mnBEoXjFAqnIEEfsQEUKCxzUiQFJksUICqffXjAyo/hsjdFXN++D R3GSJM/8tBx10neUIJjz3EK6SM2UxPvQM+IXl1wDm6Zwx/rTnRlThcjH4F0aRBC+T1ibYAhBEXI
 uTb2wm3IaecUzUqV0JAf4fejXUN6yw34cpJ4NvoceMb/8lAbgWTZuNJidtKCI0wxKbiG+CVL
X-Authority-Analysis: v=2.4 cv=dYuA3WXe c=1 sm=1 tr=0 ts=68255f70 cx=c_pps a=PZJ0/dUMjH0jBWORzn298Q==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=t7CeM3EgAAAA:8 a=LgS0r3Rq2bCD6Mld5c4A:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: 2ACu4BbbMRX80XEElTIIVXMuwbK2s5lT
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_01,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=958 adultscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 clxscore=1015 mlxscore=0 spamscore=0 phishscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2505070000
 definitions=main-2505150032
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 15 May 2025 03:28:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17613

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

Fixes: [YOCTO #15862]

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


