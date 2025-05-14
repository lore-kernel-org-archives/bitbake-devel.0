Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA950C3ABDA
	for <webhook@archiver.kernel.org>; Wed, 14 May 2025 07:49:28 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web11.97013.1747208963250705182
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 14 May 2025 00:49:23 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=72298db702=qi.chen@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54E5lsuC003321
	for <bitbake-devel@lists.openembedded.org>; Wed, 14 May 2025 00:49:22 -0700
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 46mbcb8rux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Wed, 14 May 2025 00:49:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AzkyjtdWTKIRHp8zfC9FN7eQ8as2kjkbvAqSWz9040vxcn8UvcjqdNRuee3ilczSom/SztqdBa9o74anvzLJzZPH1nmZGCky3Wq3fwmiGJaWmS5AUMdolaDAv4L4EGaqkroHALnM/9Oi2bpRu476hcinLcCNdWt54lJ29acSiGU48W35RNIIWDv4wOt7ITvsmz1Jy3euvH644Rs/f0MnH7lXy1fT5JTJauiKPysIo9uR3DIg5a245gPgMl60p3yFCyPqTqtZuFowMRr8ojPf1piooNyng1UVjccr1PaiTgPLuBG8utzCAnwQhdGZb8q33kwMTCwVFH/OSHlBpTwQeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=98F8soBDhyQA0587qqvVKILmpPAqV1PEGCNQVLIbJN4=;
 b=v/Ms8yMW55++oY/NCTnIPkDgBa2sYss2+QTkuXYzO1sOcFOaKyN4R8iDV7gRtclAFKjhPOhXoJDPp7K8l83PFTLkCr6SdmuueQJQLDt6gIawf6T3epudvaTGqk6pCbjJPf5ZIVAoQ0rGG0zcK9j85Tyr8nuVlhztJhnbbBPh3Q+iSMMJanoswCGjdHc8Jc5QeuoLm1cGrdme630kpZkVA1hBVUQn5rCkxlBP2B1ZITU2V9YfyG/CwpQKsHBclaIZVZb1W0gvk1fhK/0IEYf/0fj+77IbU9zHhzrCTW2Cg4S6lfhrwdZXJq2ByhgW5l/TGNli3qboFJhT2uIFwCECxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by BL1PR11MB5238.namprd11.prod.outlook.com (2603:10b6:208:313::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Wed, 14 May
 2025 07:49:19 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::a7e3:721d:9cec:6093]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::a7e3:721d:9cec:6093%5]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 07:49:18 +0000
From: Qi.Chen@windriver.com
To: bitbake-devel@lists.openembedded.org, liezhi.yang@windriver.com
Cc: qi.chen@windriver.com
Subject: [bitbake-devel][PATCH] lib/bb/tests/fetch: add a test case to ensure git shallow fetch works for tag containing slash
Date: Wed, 14 May 2025 15:48:39 +0800
Message-Id: <20250514074839.2171099-1-Qi.Chen@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0030.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::15) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|BL1PR11MB5238:EE_
X-MS-Office365-Filtering-Correlation-Id: 13db131d-01a4-4fc6-faeb-08dd92bbd4f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?RDXA4SdhkJ/ql+CITNFBxr9QiTaW6f9ivzez3Z1eSHpmtg1bH3WxEtZLFLyS?=
 =?us-ascii?Q?oKaE/UYErb8FfUvoN/Zm6Hujrds52AGYSCNWCJmBseWvopuxuoy9oL8pYXao?=
 =?us-ascii?Q?LHFmOsfTcJtIYJAGTUJxjmkIbRXdP1RIotuDNbj/8ag40Xpxir6jh23GGDrF?=
 =?us-ascii?Q?3GkuhEtK99RYjB2eNWSlp2Aq/2BwaDJqxAmGv7FJVj1IcqvHyuBBnMtUWzqh?=
 =?us-ascii?Q?8dZfpfnmQA6j5wicQYq7nlQXrN1pSh4PzvA2n8tBtXzplXAnDCvgucZjZ7SF?=
 =?us-ascii?Q?6+/Y8USemZtLEBZtmzKocCkb1VP3r/LwkpHhtiopJqZ3MlRvr19XxD+i8eeY?=
 =?us-ascii?Q?qr56Oj18KNgTaTTA4t6UvEG5jV1AeXUyUm22oTUdFIWWsj3gBTZ1Uf6RBaY0?=
 =?us-ascii?Q?ZRPGbopCa4hQqzHV6M3USODD+QYEzHEd0MtgMqExecqdjQzsfGiY1i8FN2no?=
 =?us-ascii?Q?XPNvEt3C+R4wWL1qktFdiAROP1Gw3g+D6rmmMh3R97DaeFGHpUti+DnOvVm5?=
 =?us-ascii?Q?lLDhzijJIQXuJ4S96zupVrW/9OI1E1wHHA1svBoVWLaxLR53uunvpx6JXFZ5?=
 =?us-ascii?Q?TkixGpD/kahDyMiaRzENOZD0CirmaHLt5HZAi4EHwd45Kz6WdNLalXVXFdV4?=
 =?us-ascii?Q?wkM/zxuBLD94PQPSjnSD88ntdcyy0A56pP5gq59ZlHCiPosF8P3AW8xc50+C?=
 =?us-ascii?Q?fFZyX691nLNioJELMw82yuzSW2Cz2jTrjFvxB1vuLhW2tWJxKACkpYWlsWEW?=
 =?us-ascii?Q?9cWxzsPh7RbntmTYpJTHQqQe4PNGKK5pT0Nv2WMj3VOmntJ4ajIa9NFw4YAD?=
 =?us-ascii?Q?U8MMIRTknw1AI7U+g6e721attTZnxeesd9uXkQfAkXEYHnIzF3jFQNXS/49p?=
 =?us-ascii?Q?57zYrndukASQn1mkfYDY9M3gBW/9rEkuCwccTicoRsYpoUN3w3R2ZAYxZk3F?=
 =?us-ascii?Q?nK5zkb3+r7OZm08vI6eSmVEM9R77wmgulsmzyZHOHvgLro6fmu3mz3KrFmel?=
 =?us-ascii?Q?k9dbOIgxb+hapaor3JE7jwPIcmlhvnJprswAqzbYshNFoIkQwFKRiPI0A2VY?=
 =?us-ascii?Q?u6Jzh7RkPofLT21VnAZpwgZmNBRjyZJsodRXe7yFLz05sMeVFAPsIYrN+9Hw?=
 =?us-ascii?Q?lEiZdpeUVysetL9OTzBo33jjKSK+iKmF/tV/ct9vy3FfUKqjv6Ut+bR7VgJ0?=
 =?us-ascii?Q?cfw1juHIOFyHM4jXVWxX2TpXqIqD1UN/Qgg9EC6KD8DpBHWVjtqXDLADs0cs?=
 =?us-ascii?Q?64LNJt3wDvfWlHJn/PdyRccGJb7VY6vdWg2XmTa7HCRdDCE5hXcaCeKp6nCc?=
 =?us-ascii?Q?VbUtbI41UZFn7BzEt6DY467GcGCISQql+QfKavbP6aAeZbj5FqrwVyxmspmQ?=
 =?us-ascii?Q?O90jAQxHBcENwpMXUkMKR6I8X3t/7mcxa+ks3CrA40AU7SrgPaLdWy8aeGRt?=
 =?us-ascii?Q?zHb7gBPT8SPv1PAT8Xbf8JZdxACGYQG8iPg/GiG4tN35cNfWfDXvuzebd4xv?=
 =?us-ascii?Q?JwaGi9YwZ8KoHFw=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?wWh3C0McPcRGOewoZNTtsP+2aABq8zQj4WqtrIqivsJGzUbt247SQU1+eaaU?=
 =?us-ascii?Q?idwNr0IGppY7cJpsIYafexT6QAKq1nDfAmMCIHtOXoX1lSMWEgyx6qvmHl5p?=
 =?us-ascii?Q?t/vL7ETLe3HZu7SZptUXkQiu1VLmx6bKGQn8rK44Z68l0zHOST+sOdAP0dPK?=
 =?us-ascii?Q?EuUsd1RHn+zyug2+f1CQcJAr3c2hyhXPk0K0qNeMQoq2gD7AH4OmYh8vPZs9?=
 =?us-ascii?Q?oFlE3mR23R24anQzS7jvb7TyaoMgfavGFtKDj5At82/qDI6ymWoTHqGHkg9y?=
 =?us-ascii?Q?k82jSBsDzl6eyo9y11T7p04QO8ew/5khQlIvesRKme9Z8gadmryyF2v83woe?=
 =?us-ascii?Q?C1+M1Cdu0SehIrOVgEOCVjZsqyoJn329kB5ZViBA4sZKR6Vk6i5WDez1suDp?=
 =?us-ascii?Q?dYpoF0GmryJpcQWsG7TS9NKsvA+AdBcJEDtW8DE62RkBlAMNDaQ81EhzW0Gt?=
 =?us-ascii?Q?DUVfs5vD81D+vfSoaeAiBTxEKECiqbqk2DTlbJ10ovRVd9fEBf5tt4qs4js1?=
 =?us-ascii?Q?BdJW6CGhO2lPWggQDB46Pz1A8MzjfKKpMh5bdd7kihztrAn5lILlvW8p0Pfj?=
 =?us-ascii?Q?5Wcl2IsCTBSosc2Aywwx8TVSmhuWv/WeZB19XkBaySLMpG+oJMG3Yoy0S381?=
 =?us-ascii?Q?clT9y0vx48NbJbYwQQtEfg1i6Vn95Nt4BZI5BviCFystwosrKUOm7j2GU8I2?=
 =?us-ascii?Q?rP+3U/v1cRX3R7iSnhlTrYaNQING0QH+8YopbLrYQxlE7g6rPUeD2/1SijJI?=
 =?us-ascii?Q?RIIXDVJMBr4mO26uHmuovNW5ufLU3bDRMErPWP+Isw+2D8iYs9/BzWfio594?=
 =?us-ascii?Q?SFQVjwgvD12QULUP3fO/Aj7wOUKQ3xnrcr6lWw/rGMggIvN7rAf7oeR74T+q?=
 =?us-ascii?Q?LB0scaYPTesCMpvCR//v8rHHhncd8hnA6o7PXHClA+Iwvxh9EUWWSbQ1ql0i?=
 =?us-ascii?Q?QjPR3ZbDBDrUwpSTMHNd6cM9FeAhSNxrUl/7uTeR+AZtBpkO++5nYThScjcV?=
 =?us-ascii?Q?OaLtpOgwwalyH0DfDYs9DlYkkfq0gt5lWdzAkLjA+i6yn5ygX+lLuZH5ylUT?=
 =?us-ascii?Q?bM/YMYK7g/ChW8f7K++IDYhSAz8kbSAF6OeNbN7RCsSOqquGW2Nv9Az7J9i7?=
 =?us-ascii?Q?g/SOdQQVl+SW0lOrIedPu7PLD6UiZs4llWWsD4WNcCNDCQITRR28uY89MHwm?=
 =?us-ascii?Q?g59iewID7FZyYfCaFfnPAtnH38TajuVLjekbyWrVnC4t6a7V09AVSuskS9oW?=
 =?us-ascii?Q?ldzGsdtm9xyP5vqkUjPWtQUs1BmNRJy54gZfRwtVfH7PbGPNbMaM4f28dAIz?=
 =?us-ascii?Q?WakmPHkqF2kfkPMtsdrpxFTPt5JXMyEEqXjSUyKZCp3K2BgHRDucvgDTohio?=
 =?us-ascii?Q?ltYZfqw+YLjq10F9ioUtj3EksHokWemWRfsv55L4QcFsaObWw5jU0WhxYMFB?=
 =?us-ascii?Q?Tq5Xysmn2/WNK06c7cXlzLV6y2pd97FGQrRPkXDxlwWi2iH1TEcxxV9eZpZV?=
 =?us-ascii?Q?XxeyyizO7FXnyEL7qM1eZvxEqPsGztvEOeyemDWji5XQxn28k2JnlJJHw7SE?=
 =?us-ascii?Q?ZKUuvNMBR4klJGoRXx/CH6lDXK+/ln9Txngh/Yqt?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13db131d-01a4-4fc6-faeb-08dd92bbd4f8
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 07:49:18.8207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f68V7L5mZ6GqBLxIgqqoJx0soi8fo9HWyDM08LIzwPNQnSEusDG5DQRIPR5d9Gypkf7Mqavg+qOf7yxTP6wgTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5238
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDA2NyBTYWx0ZWRfX+osNVpU+pBKO V9yLuM6Z2p8FEFxNIUKfJ9i4FVxrLMC0kUcSy+L157RuhofSTtHjRqrBkZcvQywBG4F0dClEa5h zePW9UNJCqt0Wl6ON8lj3OltP8H/TmX0ytkGOpxfQ5/yLrfDH6XNU16gjMoBZFYHIRNK8nV2S2B
 wXYsA08bSmreWkterD38u3sF2gLFFSCg5hH0duE0SC82Op8F3OAOZ9biggFyGmZy20LyQ6Pjfwq 9XrMDZREz/JAyWRKGY1+ursFpUPz66zDVf/l13Y/2P+xb2ZscqippG+nRsoB5/mNh9mMLSAvMeo OCJCUKJ8FCzJzpjSe/JUX9LngZ3PW9k2U/qtTLer0/qoIcWHwo5KX0Jj6yWSRn1QO0xesMnmxt7
 ZMOoyDCHIB1B6Djr9sovX4ER2YjGMzSu24lSevUW+FNsQhPPu7EWeTSjtZXAdikzD+RttSYa
X-Proofpoint-GUID: 6XG2kJEuSO5AgU0cwkLj8Npe0j9MQ7r5
X-Proofpoint-ORIG-GUID: 6XG2kJEuSO5AgU0cwkLj8Npe0j9MQ7r5
X-Authority-Analysis: v=2.4 cv=LpWSymdc c=1 sm=1 tr=0 ts=68244b02 cx=c_pps a=AVVanhwSUc+LQPSikfBlbg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=-t1SeCW5khpx_yZP:21 a=xqWC_Br6kY4A:10
 a=dt9VzEwgFbYA:10 a=t7CeM3EgAAAA:8 a=xNf9USuDAAAA:8 a=k8yycMeBRlpGSuLlwAQA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_02,2025-05-14_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 clxscore=1015 malwarescore=0 mlxscore=0 bulkscore=0
 spamscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=812 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.21.0-2505070000 definitions=main-2505140067
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 14 May 2025 07:49:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17608

From: Chen Qi <Qi.Chen@windriver.com>

Add a test case to ensure git shallow fetch succeeds for SRC_URI
with tag containing slash.

For example, we want to succeed for SRC_URI like below:
SRC_URI = "git://salsa.debian.org/debian/debianutils.git;protocol=https;branch=master;tag=debian/${PV}"

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 bitbake/lib/bb/tests/fetch.py | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.py
index 0091723601..3f42332588 100644
--- a/bitbake/lib/bb/tests/fetch.py
+++ b/bitbake/lib/bb/tests/fetch.py
@@ -2281,6 +2281,19 @@ class GitShallowTest(FetcherTest):
         self.assertRevCount(1)
         assert os.path.exists(os.path.join(self.gitdir, '.git', 'shallow'))
 
+    def test_shallow_succeeds_with_tag_containing_slash(self):
+        self.add_empty_file('a')
+        self.add_empty_file('b')
+        self.git('tag t1/t2/t3', cwd=self.srcdir)
+        self.assertRevCount(2, cwd=self.srcdir)
+
+        srcrev = self.git('rev-parse HEAD', cwd=self.srcdir).strip()
+        self.d.setVar('SRCREV', srcrev)
+        uri = self.d.getVar('SRC_URI').split()[0]
+        uri = '%s;tag=t1/t2/t3' % uri
+        self.fetch_shallow(uri)
+        self.assertRevCount(1)
+
 class GitLfsTest(FetcherTest):
     def skipIfNoGitLFS():
         if not shutil.which('git-lfs'):
-- 
2.34.1


