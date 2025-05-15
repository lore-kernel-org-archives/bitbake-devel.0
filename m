Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45AF7C3ABC9
	for <webhook@archiver.kernel.org>; Thu, 15 May 2025 03:28:36 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web11.4944.1747279707006473110
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 14 May 2025 20:28:27 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=7230864b24=qi.chen@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54F2o2Pv005413
	for <bitbake-devel@lists.openembedded.org>; Wed, 14 May 2025 20:28:26 -0700
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 46mbcba3ma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Wed, 14 May 2025 20:28:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b3e27DD5PoS8UaIySqLvpM9Xyn6BjBa89R+RRyugZZBuhmINCaJl395BszviBSPYeOciAIofxKptMgmvcWrIiNxQj2vmjuMGh03rOTVjj4apeXPlHSXeDxLHL79ui4xE3Wfm2wqdBaJeIrp/w0goTS+Bt6rQ5n0S/oV+qQVKoRMkbVr41j//6ZcmuvYU8WwcBVDJzHEPZUmawajMdv7MiuyGksWElYcwOC5rCO2kpwP2P40LrC8bD3g3NufQ0t5G4AgAHbkSu+WnngOlhfDCK7c/NEOd6QDn4IKjTKKsTAtIEZE20A0v3bgiG5ob9dHJXSrl6ExTuWV07r67SMn/CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YtkAAJwJ5haxtAuq9DEDu2ffehzHuWHMTyPgVqNaZ1k=;
 b=QqFCNfiQy+1LTLL24uwjgCnYdkt/NCon65zorzF3+3rkZEY9asfFMScZjbFQeNdv8ZtsXIe+gbqzu8j7mw4tL55+IthmPMNNLerIi60VSmdKZNbvIKd2Mv+5a3Yvla9vnCNZILj+mSbtO3Z9dpGbj36k9obEjdzNemiEqeEbtNy8r9OACj/YZ0f094vfrnP5zZvPytH0lzaQNAGJFhvP0qeKZJqYhveDVy+lXm1uuUtX4yKqfqpEVvuOTTAq+5YB49GK5zcLacfD+yKvRgDeCf0Gi4uj1uv66611Ku/uHNwfao7dOXS8wy4RU69kfCEVU4rZcxwNJymPEvHrdgwy+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by CH0PR11MB8167.namprd11.prod.outlook.com (2603:10b6:610:192::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Thu, 15 May
 2025 03:28:19 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::a7e3:721d:9cec:6093]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::a7e3:721d:9cec:6093%5]) with mapi id 15.20.8722.027; Thu, 15 May 2025
 03:28:19 +0000
From: Qi.Chen@windriver.com
To: bitbake-devel@lists.openembedded.org, liezhi.yang@windriver.com
Cc: qi.chen@windriver.com
Subject: [bitbake-devel][PATCH V2] lib/bb/tests/fetch: add a test case to ensure git shallow fetch works for tag containing slash
Date: Thu, 15 May 2025 11:28:04 +0800
Message-Id: <20250515032804.2189694-1-Qi.Chen@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0007.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::19)
 To CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|CH0PR11MB8167:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dbbc7bd-4cc7-4a24-c0c3-08dd936089a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?azv8wHqUb7iuvFK1+V8AdDWSxsp3maB+SvOkzWVvnjezjk4LvXJVMyoxztZ8?=
 =?us-ascii?Q?FH6UsAvQYF5SE5xhBXfVktJd0G7UXpBBu7THZv1xRau/1mZfMvV2K9PqtDg6?=
 =?us-ascii?Q?/uZ14csX1eBSSMB9GfnPe3MxDj5tugsYOjbEelkL7D0bI9HUfmPsuARFZuDd?=
 =?us-ascii?Q?y+kxs8z61meeYznrreWPFQ3rZjB4XYGPXNnqfHaYuPIicl66XjN7wPtOo//x?=
 =?us-ascii?Q?ECVsApR1fDK3lQgLeTN7ffaf7c4Sy2xQ90bw492vysblgyBd+B2b0vGkvUWZ?=
 =?us-ascii?Q?pXmwtH3tyC6ApCSgSYtO7B3HHIZs2hkO1+0uWR3YfIuf2YDJSsdzjRi1TuFR?=
 =?us-ascii?Q?PRfSMnR3rjz8A7j7pD2FZVn6TfHtFHDEpvoqVP4MVmqlhpdkGcqD4EFChyzL?=
 =?us-ascii?Q?QRhbv0cByFRWhhzBGoDoVXSRVuzcYMKyfTS5HsiwoVGTPf8Rd0mBUPL19AgX?=
 =?us-ascii?Q?GdZv5tdjNI/rAgOhl671eAQ46z/hbsXEkHOp0D625n1HSmrkgrD7m4Qh9kWK?=
 =?us-ascii?Q?d2wQ2K4ZoDuEbThLf5F3t1A4nhmgUYfWyR34sgxCe9Boo2ThV8wyCbmQfpBr?=
 =?us-ascii?Q?uBKvf6yNYnDn5qFyqVgsHXi0XNTNs8h6fd6x190rBMxKl15HcgvSuaCKiSuJ?=
 =?us-ascii?Q?FEWFi6MsLSxdgD77rhB9T3xznjELM18YEHKwBLyYGRrnBiXdH4FIVjSeZph3?=
 =?us-ascii?Q?j/8dOnbsYMHWY4XIhsoqM6Sh3HQlDRVMjGLujpJrSLpSIbZYuIdn5+ngLnm5?=
 =?us-ascii?Q?tGszh87/dZe2U+Wp126HNG2zcwpbOu9pq2EiS15MxmYRBswKKAuAplIixEN2?=
 =?us-ascii?Q?W78hwGrz+mWZ+QfAn+2PgyaT03yYM2kMuOGz44LQ67d4zCwprE2Llla3nQ9b?=
 =?us-ascii?Q?PdkDyymFfZ6qCdccadbDRcCZxnl4PKdBweKBxUjeE1FsWAWQIh9mmHUfK6pw?=
 =?us-ascii?Q?KwyfXmRD0OzR2ievgvr/ZG7BlvEIQZsxyawTJopLWegZfIxn7nMlKeMK6WN2?=
 =?us-ascii?Q?Q2NmZTJ6i+Jh7LjV0GfXfI/xKCs+hzEixrWODGz72pN4KB9ewtytZ6O3vA5f?=
 =?us-ascii?Q?FwS+0b6k0/BnUVARoIe1RbjLvV2tg0i1KSppF0ZLJIb00i+zvoiz10i+JfB7?=
 =?us-ascii?Q?gpWNINUuV4DKJcMgYU5Y3Hxnb4J8MZysoIBwe13mNPUibkRGIjCmsZk9kiyW?=
 =?us-ascii?Q?DXGyDmt05OW9kY1K4XbSSpS9fDRLa72hd6aCtmrCVhnAIeLg3fPUkckJgbsh?=
 =?us-ascii?Q?0dfrihHFaFQiez+oVTYWX2qRaXKqcEvzwuBUanUPZAf7KP2MYiEoCiI04sIX?=
 =?us-ascii?Q?PI3VvjNvx0rnjBivnRG5P9YhXMJeBjxuEA/AMmmAn+YXL07OME1kUr9L3G7d?=
 =?us-ascii?Q?bLjR4izgShvygUgWzUZwEEZqj83r9Fo1CpyZjkHcezZx1x4gGzeiwNrfq52C?=
 =?us-ascii?Q?FjLfDt6UjAk=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?RQzmSn3PkTWtITF/lSyhCdMX+VwWJgAtzz1CA5MKdI/CggGscXfEEy5vQqii?=
 =?us-ascii?Q?z9FjtSjnPKJwQ7i9RSI6LD85Bo1/EBLF4OlhT0OixCAE6JWod8fS1G2ecpNX?=
 =?us-ascii?Q?2LnFMTdv+9sox9/bCfU0ygnrncQzRP3ienmdPq0wZ03BT3gccB2qpS0ASYtJ?=
 =?us-ascii?Q?YIRBQbNZ0b42z0t8VAThhzayMGy3YcKP4cm2OlKJ8sZ6bZrD1GZRMH8p5bYO?=
 =?us-ascii?Q?alHDe4N7iXzxUPh901FKMhZPqAnGADmqHteMJW2i4BIDdAuh53uX1M+N+HUV?=
 =?us-ascii?Q?usBH91KDBZ3AY4a5NNzgQS/SH2QXLE+WWcAvGTy0RwAQWiBm3q9JOi4S8cM7?=
 =?us-ascii?Q?qy7T0lsF4S03AipDZ7YNo5eLCrXAETPNz5NM2Pxu2sjh3UyuvbQ1IVSp9983?=
 =?us-ascii?Q?0fY4spMEOy++EFyUsch7NhCPMfG17pM1iX6OOvKLVeIOQ8yvbZsZ9LkQkZsQ?=
 =?us-ascii?Q?VycmxdtQPV+3yz0nqNvFkGoLKofwfSvFI5L2rCvjk7ZMRHkRuE7dUF9W9vlE?=
 =?us-ascii?Q?wpBLwnxwQmd4/j1Hf0qgStXYJjT8TtW72gPxmLUugXBGIGbHf4BaucsgImea?=
 =?us-ascii?Q?7ZJ+0j3T1EoVM8OJx8ceSHhT0Q9R4xReFrIEkoGq7LcyMdIQ0IYfSqmqKJQp?=
 =?us-ascii?Q?QhrKdHmHMWrDFeFgYTcVuJWUnJXhaS22GuuuJ2lUvC61Bx3yGsIFhlXHS11I?=
 =?us-ascii?Q?qaXrQxQtEs7BWWFzgeOZovwVjTZruzcev0anwh3WXQ//HV8J/Q8QGLmML7TV?=
 =?us-ascii?Q?j6M7DBZXnfJDHAFIZGGnSF/JHQnx5KM2rf7tEI/548ZxpJiMOrYloO3FsRB6?=
 =?us-ascii?Q?OcLGK+PiMs939xz/KpTa+KJAERnltFb0o/pcFOEf8GcK1Xbc12hMtTn8hwZ1?=
 =?us-ascii?Q?LXchvj1RybqxwbKu9NXP5150sUQB1D9fdssHN8UAq7P/kmexTlo36mxl3K/7?=
 =?us-ascii?Q?WmpNIk0g2huEYAR180mundUrMg45pHNJ4jOtQminkB7hVHVp+RaXVg4KEUTb?=
 =?us-ascii?Q?PECSFd5ZxJmIGYn1abtI8OS15iFk/0PiAxtzW/vdgXNi3zNEAxwlv8j4PG4Q?=
 =?us-ascii?Q?Fr01Wbz/2RbcDkDBemgT39bD8wc6ep/xmWxEE4Aqq8EslLO5tV9Xi1Sr6LwO?=
 =?us-ascii?Q?Enz2JyBbRA3Y0e6W2SAQx+gjBxngBTODhy4WP59Y+bf9JobzNH3BcJ0OpL0a?=
 =?us-ascii?Q?RKdQ9aA/VA/bdSPy2QBPK7j06MxffH7Tk1nD8GMAO/n9ulv2Y1z80XbjmCZ2?=
 =?us-ascii?Q?5gsq34ThY17PY/4+9wQM0pyLI2S9VshoRpnhVV2iyJKQUi8XF7nxKnbN4Qjx?=
 =?us-ascii?Q?jdALstCasnPl3o4HfviHOeW9oinpedl9TDJqe/Fth6xjOecsm2s7UFsPZecs?=
 =?us-ascii?Q?oG02bL62UjXQaVdsuj75m18f8+lThlO2faC9zHdtX5B3KZ0cRnBPvAptiMJb?=
 =?us-ascii?Q?IszYnQloEppOKpOGnEvwcQeV9fZyEcKQvNRdtsBnUpaUP43T35pdTQ+sJkkR?=
 =?us-ascii?Q?jKQAXgTS/2OQE2aA5XWyKR4AoCOlSvYDyCPw6QBC+eMHE4FJd9Ml+iTlZiS3?=
 =?us-ascii?Q?gvcbc0hzYUHY0ZUB+ZIpn6jdPDcdIKMlzl2KPrNT?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dbbc7bd-4cc7-4a24-c0c3-08dd936089a6
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 03:28:19.4015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7/jOSAk6BnbHSN/za9WXjhRRzlLV4WIyTZ3MnU7BpzmQYM/FNU35A10n3hmY2lyfp6K4DPViQuUlIOJvzMFWvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8167
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDAzMiBTYWx0ZWRfXwPxsI9uRyZu3 QD6eqNIckT3WM4kHkvzz9ok5E+bXONWtVQ25chI3gfiYmX4uaLpmKhzNFGmNDYka8YKa0fQjxba I/g2Rw1CKeEZCwvL1VD5VXAAQVpDJO8oINLG+hhhiTYzUe5WgziVODC7oE4Oqp8AAEwb/xi8v68
 IOcS2BvdOnlY7kFxQXNolNkTXxm8nKmrnOb2P5rmvsbnwxzxZfP78v0uS8fpgHMGFf3IuGCTpt+ CRdqmOfIrAa4qgECiN3dBDXLT4ASapn1AVEuwLlDrjJm6PbpJ3mu2m/7BPxgou9SXDSlvCIppRD Z9Qzyh7CtMPi2fZ78vkQn31KM+XUpc+GocJpkbzz3litYDHZsKxkI9pIaIJHPueUVy/JLizrAQN
 iG8w731+/rH5de4tY0VQmq1ctOX+e5blj4eiDvxZV9wfZ+WChxLtp+ddpC0mU8xxRQ760e6J
X-Proofpoint-GUID: FTY7FOGaQ0NzMQInEPWrUGDA0eDCfL8E
X-Proofpoint-ORIG-GUID: FTY7FOGaQ0NzMQInEPWrUGDA0eDCfL8E
X-Authority-Analysis: v=2.4 cv=LpWSymdc c=1 sm=1 tr=0 ts=68255f5a cx=c_pps a=GDxOUaUasxmcDRSC7gC2IA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=-t1SeCW5khpx_yZP:21 a=xqWC_Br6kY4A:10
 a=dt9VzEwgFbYA:10 a=iGHA9ds3AAAA:8 a=t7CeM3EgAAAA:8 a=xNf9USuDAAAA:8 a=k8yycMeBRlpGSuLlwAQA:9 a=nM-MV4yxpKKO9kiQg6Ot:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_01,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 clxscore=1015 malwarescore=0 mlxscore=0 bulkscore=0
 spamscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=963 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.21.0-2505070000 definitions=main-2505150032
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 15 May 2025 03:28:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17612

From: Chen Qi <Qi.Chen@windriver.com>

Add a test case to ensure git shallow fetch succeeds for SRC_URI
with tag containing slash.

For example, we want to succeed for SRC_URI like below:
SRC_URI = "git://salsa.debian.org/debian/debianutils.git;protocol=https;branch=master;tag=debian/${PV}"

See the following link for more information:
https://bugzilla.yoctoproject.org/show_bug.cgi?id=15862

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


