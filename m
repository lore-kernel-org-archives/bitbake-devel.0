Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2158CC3ABC9
	for <webhook@archiver.kernel.org>; Thu, 15 May 2025 03:28:56 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web10.5005.1747279729615221271
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 14 May 2025 20:28:49 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=7230864b24=qi.chen@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54F31Krp003438
	for <bitbake-devel@lists.openembedded.org>; Thu, 15 May 2025 03:28:49 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2048.outbound.protection.outlook.com [104.47.56.48])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 46mbcjt271-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Thu, 15 May 2025 03:28:48 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g00FZlmKqkSBIX543AqAf39efcM7LeJiaIFgIw6FHH+ZLv9cKBDRx0+RE4dUVI9sQMoGPaQbicfYFGDxDwM5kRX09AXJxtP5iPidxPTxdUaRxvXYwu1tGK8qPnDcOYDV/9n/Idq0QLJ6XEo+I1oTOjvM3MN1l4l7Sbv1u2b/bFs5E6n1wRGpKGjt010GgK8gk03NIGB1OF/dFRPqekH+yOywi3E6K8VVPxkSIQHjiiLtVjZQMZvh45Ax7IWmcdC82yOh5gvub1CSItkyKKl3ml82i1KyFwZKya+2WEtOggOt4hnbjGXgvu+OJbjBt/P/sGqCBAftDLA39uVaoAeXdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YtkAAJwJ5haxtAuq9DEDu2ffehzHuWHMTyPgVqNaZ1k=;
 b=yN3/0TQX3KYMnG3iUB6iyUzwrEbDIT4cSI1LS2FZyo5965VrPYRlh2pmgTVKVBhYjfL82tnB8fUfVpnM2g37iV/7EKyOKZ/Nso3Xl4hzE3ltnHItgC97aXG5EZIU6KD8BqE12O/73xFAnpTH0mZ6YM7p0FrbYUPO2f4g9IzcY3pyJiUe6K8PRVSHWGVE2pjnyWR+W4fCSgmmJkCwlG8bixk6zp97KNfsn8qAs73lUdDNGtnP16lPtmczCLN8/eXeADsiZeyoxXi/nlHPY44RxVfD7Za4dE2t4n3ppsC7Bndxs3A4u5CtHsq1fAfFoYn7UtWOHmOOC9VMjt9SzPa8TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by CH0PR11MB8167.namprd11.prod.outlook.com (2603:10b6:610:192::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Thu, 15 May
 2025 03:28:47 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::a7e3:721d:9cec:6093]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::a7e3:721d:9cec:6093%5]) with mapi id 15.20.8722.027; Thu, 15 May 2025
 03:28:47 +0000
From: Qi.Chen@windriver.com
To: bitbake-devel@lists.openembedded.org, liezhi.yang@windriver.com
Cc: qi.chen@windriver.com
Subject: [bitbake-devel][PATCH V2 2/2] lib/bb/tests/fetch: add a test case to ensure git shallow fetch works for tag containing slash
Date: Thu, 15 May 2025 11:28:33 +0800
Message-Id: <20250515032833.2189725-2-Qi.Chen@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250515032833.2189725-1-Qi.Chen@windriver.com>
References: <20250515032833.2189725-1-Qi.Chen@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0019.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::13) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|CH0PR11MB8167:EE_
X-MS-Office365-Filtering-Correlation-Id: bf39a065-15b7-4707-f566-08dd93609a71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?a0XyDkcNVFRSD9UHBmenaRv85RpAisCa34gppEyPVUHJKye35AtWJ18pYp2o?=
 =?us-ascii?Q?T0UDdZGYlwxe7c4lQQ8nFj6QGJnSNynsRISPn0a7XPc/717JmnTNQgPIrv4I?=
 =?us-ascii?Q?4a6VQVNZqpvvjivGsKgKsty4SLGPi8LEpS17etl2tGKT773Q4HyirYjREp0c?=
 =?us-ascii?Q?rb3UeQryp8fbGLZWPuEuk/eiQ6fpuv9oRf7T1ITFsC4TuCA3rsGtS3R3sKB9?=
 =?us-ascii?Q?8tUznyIjLG09mgvrXnKseViDmKJgMN0NZcn21/NtStNh/Ed7OKrjF9wgMvvZ?=
 =?us-ascii?Q?pzQVjUq/XoYSBDUgrA0wiCTrU/If4/z/6quMZDXx2m7/pocRhJtuWdB0EVG5?=
 =?us-ascii?Q?vBjzLrcUTIzO/pm/Brds6k7xijkw9imtitYpP/d66jWVNhDZltUqeRQxBvbi?=
 =?us-ascii?Q?hQ+MiA8bQwQQ2f41cjyd6uEBqFSHXqQjENTiBG6KMv6w7gNWtlGyQ7qh4SKb?=
 =?us-ascii?Q?XXPQC7Bn+0Xxlz4/GzZtxWePaIVKPjygwCI+PufeoXEyrLpwCUbxZq5qiicV?=
 =?us-ascii?Q?N07zjAKEowBFZZfEmm0VVdekW+Y2UXYw7Xcgyczex5SZvPhlFMVWvANVc12Y?=
 =?us-ascii?Q?OPz4vbrgIAPbDJMZJzyNPan05Mi979FJnPzC2RfR7yqOdCz9VVV1q4xaApYb?=
 =?us-ascii?Q?rU74M7gOrA8RCdXiElYJgLqNslbRgH4IcLGsf4+xcfXtYmU5PcFxBIsgYBb5?=
 =?us-ascii?Q?+2ccyuHIx5OtGd81TT4yIB1/Keyii1fgi6HbbKvkWmoNcA+RQZWre92K1Gre?=
 =?us-ascii?Q?suUASiy6MI7nCKPGOlO0YtCLtTzQph3IzRS6YpsdZyME+LaaGtxy5MWT+Oxs?=
 =?us-ascii?Q?oaSlMe10UEV81dzOw+UkyONyoqsqe0SzdpaQ3sb7QKR/BJc3K5s9sC8HI52X?=
 =?us-ascii?Q?CIfp1qKD6upst34tCHBjFZHzB2wNWIr5O4u4VTL9MUnyx2WfKjF3DU4aRCRL?=
 =?us-ascii?Q?oduURh9jRv+6ivfkSIPUYO/J5kTzW9G7ZFBGOzYLxDE6JNfwSWdsrxiOC01Z?=
 =?us-ascii?Q?KiFUnv0p2Momgo+NMQf2YoRttpUcAsqrvnF1RXdYfLgSq5YB1luSrC0sWbzk?=
 =?us-ascii?Q?Rt1Dq4/pi5gdcWgwFxL93ex/qDGKvptJauw0pbecye/QvLBbqyWp9l3zEkFx?=
 =?us-ascii?Q?ow8/hdggDApHP7lZdYrIk3RC87Oh0EiaH+80sEkFRp5ya7V3wuCUhtbR/+Hu?=
 =?us-ascii?Q?GXUUq5qJ1uMcMe/JCJ8H1DFUStFTpeQ+JD0i3aRuU9WwMjXcisrggQXiqEyk?=
 =?us-ascii?Q?34U4VXPW2G/Z+3dNhRvWnng6G30v67E1YSpd4PesAaKGGoI7OevhrrL4IkfJ?=
 =?us-ascii?Q?iKQyafbLorpVHkqKFmSjUlJ4mkjAVQ0Eo82U4lKR9ictrvfEdknCxV0wJcWP?=
 =?us-ascii?Q?m8Pp4B9DyNS1K1HpvL3Iu+Vj+uWP5+M+RGKF12EQcBQmuiSTbbIdldgXA9B9?=
 =?us-ascii?Q?SMAkVqA54i0=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?82zftpGhzOLJ3jnmowNj+LQRxq4jLGJaWM89KCcnApMqqEwYRzcGfoVTBN3k?=
 =?us-ascii?Q?xGVgvNMcHsLBQozD0Tiq75fWFWBwjkf5Jka56BhXznpixgrvsQjjYk7S49Sd?=
 =?us-ascii?Q?ZO7ine6pHbCP493wr1ovZ8iiK6qVr0ZEE8hulHoC5bJ8/5JVtDhBK3RLq1dv?=
 =?us-ascii?Q?sZYq0reGlL4glH5oPDBN5MkMWAGJen4zPn5bfVO6SRBqKNPiD6w/urDJgGXH?=
 =?us-ascii?Q?772NWO36bjHy3SAG+ajnpAusoEnFEzsMZLyfrLaUhLLFxneY7CyniL2JNXai?=
 =?us-ascii?Q?B2tqYJoy9ta/XkS9VRH0zaSIc7PYql9BzK1q8IQBFjU9Np3KAunbFH9fG1B9?=
 =?us-ascii?Q?FZ0qVneiV6HypSFfBpeGDfvP4ns/UlWIOAdaPMT3I9DKq6J/O1cCPD5WXII7?=
 =?us-ascii?Q?nAnIBuZENa9VUc9JRXcVyeBInMjWjG27UxNNgC9nbuWCwIEWPlA1afKvO8jL?=
 =?us-ascii?Q?0XTeGaFeNk0SpN/cvrhUn6+wq9YfQ9BWBpTfrENWyJeXQWhcE4Bh5+NDikhY?=
 =?us-ascii?Q?D0mJK59bhuKZ6sAyuu0AMh5d1R7q6u+giGxjlqLIRzel/dsFE1P/yVlJYdca?=
 =?us-ascii?Q?sALSt/ONWhs9jEj1Htmg/Hu/CxJhPF8zsCY2YE46NsHxxbsv3XjiZe43tqe1?=
 =?us-ascii?Q?WTupcd0dXwbXfUtonz1z/ZMcMaeKUqU8+CszEBbRdDOlmBdDf1Hb+lcc1K+W?=
 =?us-ascii?Q?foK24gEjhF71jHyXLuwtaDiwPyYv4O8hbQJ3o55UpDV9Qi+7whV323gHfeq2?=
 =?us-ascii?Q?jZqNJYKZTfeZQqrbNRX+OGdufFktYc9MGyMll/XcM0O58JAWS9y9oN1tNNK5?=
 =?us-ascii?Q?lmptNmJSIy+OlQEEbnTEWNX6XZbsDNJsSrvOGUR8YJNhsWU7jgtatacI9eH0?=
 =?us-ascii?Q?8xP1FrWYjVbIFQ2vt0vJYG9plQQxYC8RdfBm5L3qg+L8Uxyk00RQGou4Iz1P?=
 =?us-ascii?Q?Q6IvzB7VumfOvJSbVmaEWDoQ3WbcHbeCj8AVTq91KoYSGpuuvOqCyxzAdWZ0?=
 =?us-ascii?Q?6OhS+CTq1LcWnUbeY/iW6y+oXq3OHM2Hgm9qziGZpgh9YEB0d85J2XsW8Rgv?=
 =?us-ascii?Q?pFe/dd8Y30z1z2/8NuIhmMUlnIjMfRzW4c5xOJhS24X9tSbnUUQc1DRa7GIP?=
 =?us-ascii?Q?DaGfp5sBnbKHFQfMJrnaHfmQ0eKu1GzdEFa+d/qEy614bi5YsEk3/GHRPfAd?=
 =?us-ascii?Q?qEvkRDO9k8sZK1WD7x4CXarG2uSovnBGxSHKKJ42PGp1K3MWjuHMSEmX6Rsk?=
 =?us-ascii?Q?RjsOJz8UW/0ih5moYuqfVRl70jO1EELJQgpt4A3ZGFgspsurBbF78gZ9VT1k?=
 =?us-ascii?Q?Pn+CyqWtnnrYigG+HQJJkB/BDMbGxfWWXjkPeQmP+YAGoZP/x98LwmAOwpxg?=
 =?us-ascii?Q?bYXwoYV5/0uYj+wxoDBg4OPTGWVrpRPlshqdwBEwgVDvWX8MPEtasfMZqfNY?=
 =?us-ascii?Q?Br/JAx3U3atde7opCCfcj9E2TordsJGUuXg1P04mwXy/9k1qcqwpxYXETHIr?=
 =?us-ascii?Q?uZjX942byOTiJVLwymBKVauckrKKzjBNsN3SpVvMtmXXFE3X1TnACFpgrNTZ?=
 =?us-ascii?Q?L2RbwC/zdvT/qx0I+JuBKF6/h7JXCgosYgv+Fr2f?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf39a065-15b7-4707-f566-08dd93609a71
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 03:28:47.5774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Esz6a3yV7va2v91BxlN3pQw7MUnCyBlZkSfwMhALxuCmoQpdXTp1pVEJZC2rOY2AssUr7ba2UDA5W/sp3wpCjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8167
X-Proofpoint-GUID: plVFXXUpCDf9CpvRXkUz2kIoO1kpWu1l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDAzMiBTYWx0ZWRfX0Ug3UVvm04Ei 8WCKja5Wr7OwaMcj4DyxfQR2jFubDiWMKcFnO/guSxFmCfdwx00bccoNOoXxFbsPOz7YaP+pGO/ X/GpITpeqXeKGH+1SWK6u0wGueLVZN8jFsxO8YSZH3dPS8ewaa6vSFjhjIeGIE6IHNHh4imnqyw
 qBg++Q03G/B9Ee/6viRA45CoiSx69NGkCKmp7LZwb4pQviIp50ww2cyAafUnBSARjWNr2Rwemp6 5/9Z6Ib98KTXxCkd2rD4x4NFPk0zuUx1G7y8UZUClev+SZfMVWw155fkIw2kPpFig4LXmJPcKp9 FUOVv6QhLlMLUcWrjm44cmQ6Qd/kfRnkFgcnaUCaV1XUi78VFu7dPjn4Q43Sr8f1AtseqwjmIho
 hqtZx5eskynA4IXU8GHfoxmx9SyZ4cegoHO/OeJu26beSndLVBRxkeRjiBBg4te5QU5+Mpf5
X-Authority-Analysis: v=2.4 cv=dYuA3WXe c=1 sm=1 tr=0 ts=68255f70 cx=c_pps a=PZJ0/dUMjH0jBWORzn298Q==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=-t1SeCW5khpx_yZP:21 a=xqWC_Br6kY4A:10
 a=dt9VzEwgFbYA:10 a=iGHA9ds3AAAA:8 a=t7CeM3EgAAAA:8 a=xNf9USuDAAAA:8 a=k8yycMeBRlpGSuLlwAQA:9 a=nM-MV4yxpKKO9kiQg6Ot:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: plVFXXUpCDf9CpvRXkUz2kIoO1kpWu1l
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_01,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=988 adultscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 clxscore=1015 mlxscore=0 spamscore=0 phishscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2505070000
 definitions=main-2505150032
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 15 May 2025 03:28:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17614

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


