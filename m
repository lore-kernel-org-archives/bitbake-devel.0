Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E73E7D279
	for <webhook@archiver.kernel.org>; Tue, 26 Sep 2023 10:15:01 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.15690.1695723297476077864
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 26 Sep 2023 03:14:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=Pfqx0tnb;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=7633c6df23=qi.chen@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38Q9eHaA008475
	for <bitbake-devel@lists.openembedded.org>; Tue, 26 Sep 2023 03:14:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=PPS06212021; bh=8st1HqeieWytPN18fW
	OR9mnYT9o3vhiaqzt1UduAeeQ=; b=Pfqx0tnbQXGe9WVOt1pfyNfZJgJ9FRHEPL
	2LGEB0G/3/dZVMHcyobv7eX0DKE67dfR7V1ThvbwB/ZHAcMnsbSuzV//gjCfsZxN
	5uoiVeNckDSqMrsHMtiwn/y7Jxj5Q+S/saiCvyObb335qYYRBJD53s40t6ahKf+D
	pplaW5+HhWJCP8u9Uucm2VFXd66O1b5ETnLRRNDaAFONnVBO+8avNKQK9FZVCNO7
	U27AIL7G9k7EJDeXqx6wlLXpy9ZlvHUCOQppsepB80Ncd/T7n1euTfGdsBgJwz78
	7YzaNRzRiqoQoTj716MF5bHtvHgF1x6WI28x4rkUr981QQYZ4w0w==
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3t9ua0jf2r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 26 Sep 2023 03:14:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HbjJ1056+cGRblwqziCDnQJqQPTMlbSSO0jFqBJw8I335rfq50RkpN5h+SecZDb0sxWXUB0Op+i96mBw/PpJNFIpEMmULOKT4Ah2wGXYN1aBq5wQivnNBeXrHoI8VN9NLUIEeQRCyUOlItXL+Dvl1W96HrKIStZeRMLNTzn6OO8Pw282wIKk4oykUgSWN+1pY0khEFsUiXx9u07d5CNjwPEPeqbElMhrHpJ1srTFIHA0958x5uc8xtjhKGmGjW3szxgWIE3WYg6IuF+/qqYpkHkSpeqM6gSOUDN4T925oHeqQ6I/CvUcr1fTXshiBUBzU9UEuEaM2moW4zi+fZcuZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8st1HqeieWytPN18fWOR9mnYT9o3vhiaqzt1UduAeeQ=;
 b=Qch/70tBm3gj93x67JINMO1zq5nFxROXPo4gd7bFzLUo04Du/ujdPvrUVemKb/xQCCUeXCtO3DT1Z9UXV0YuoJ9KSS8ZWjYUCS0WUlwEYD3hUrcB/60R7gIN4Iz2HeWb/cOCNb8pbN/OHGkf3H7GtmoLz692j7KrcyQiJp2WQhxLrFVUKOVDbZLK7NpI8hcBKgDJw0eiuamClh9MajkQpn6rvBeUr5QQZ9Bt1BZ3KwMXnRoeH5ZQa9eMMZfw0tRUg/Jisy51P1R/TvDPy84+Okn06ZvE/6CDWWdxuTNFNEettXpeRyMHXyi5cM7BrR6Lw1aS4R4f5dTnM4RvvUzTXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by DM4PR11MB8130.namprd11.prod.outlook.com (2603:10b6:8:181::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 10:14:54 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::da88:58a3:bc6b:2e3d]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::da88:58a3:bc6b:2e3d%6]) with mapi id 15.20.6813.017; Tue, 26 Sep 2023
 10:14:53 +0000
From: Qi.Chen@windriver.com
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake-devel][PATCH 1/2] bitbake-getvar: further supress warnings when quiet option is supplied
Date: Tue, 26 Sep 2023 03:14:39 -0700
Message-Id: <20230926101440.3610057-1-Qi.Chen@windriver.com>
X-Mailer: git-send-email 2.40.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0052.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::27) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|DM4PR11MB8130:EE_
X-MS-Office365-Filtering-Correlation-Id: 81a47234-074f-4b38-895f-08dbbe796d09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Bu60SEZknUTfhQhKCTgF5g0He0UrVcByIMVC37fPcqQSH7BQtlUYvvC+YkAOWacAxteHzbBwAzwbVJzEa1yMSnUFkCzMLyRIWcRvbd2IPYXeXyNWSZ1dhSBorHOjg4SFlaRfafzCYzrbFM/ItjnRzei+7e+pqDHYp1Yrio4Ie43d17hRUT8eiJqhX3kEOu6lDVwAHohX/NC4GzgDPPXktCIL9Qnh5MM4mfK1JNSVTyaXjhpiMRsoRiziyKl+CpaIEtdKewJSXyIp3nkSqoTM76IAUChujcYrJ1Iy/dMbVFFaBGkyw69qxsUl3bWKbCIdxHgc6Pj6gMjTSaZ71hOsS+xDBXqPeCMLte23zhKZfpdJbvj5FryZilHTv6NCZC58cmjImuGGPXIfZKyRMF3ojze6sBlXtlIZK+TK3XZS0Em02rladuAr6n1/2iLIVrw7yxdnMszCJ8b2hw6kmQV0Yy12t6cgiQPKdOF7YawQwHTTFUK3T+jNrVe9hl1znNGp9DscHrHE0ez2DMiqm5xRrl8x2MuqJaLQiPmL0LEjdU8NEOC7h5B4yx3Pd6VckglD1VMLFLD3WzX/tFUCoxbuUKTfIbjw1jFst5Uny+GI0pubP/CUn6IyiRbNuiKb0lYP
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39850400004)(136003)(376002)(396003)(346002)(230922051799003)(186009)(1800799009)(451199024)(83380400001)(86362001)(36756003)(41300700001)(66946007)(66556008)(6916009)(5660300002)(316002)(2616005)(8936002)(8676002)(66476007)(6666004)(9686003)(52116002)(6512007)(6506007)(6486002)(478600001)(38100700002)(38350700002)(1076003)(2906002)(26005)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?WdlUBBQM02HE+gUql3ui67hcm6hoIAS4YSXvQbOXlQLoa0swqOsX0eyE6N3m?=
 =?us-ascii?Q?pUHoTUYDyK7Y5wShzL0YSIapKjZ6P122NHRp3Uzwb6yXbUH9c3yxFbwAI6xB?=
 =?us-ascii?Q?1b3ll1RcrEAJm+hmGXomv+i5lh3N6nT/9yWuJzM/wW6yEKwqj02k5p/7D1r9?=
 =?us-ascii?Q?lCjNPtUFr9ArhckbUFAjUgkRb+ofnWingSrCfL8vSa/DbQN76qeJ4qn+i8JZ?=
 =?us-ascii?Q?n0ghwT1LDxH2fZlb4P/JriDvnCrKwRuTXrvt4MiX+53Fuiy1qxn8cHMz0waX?=
 =?us-ascii?Q?GHmBLjcRRNxBFW2EIU+4/P0qFYmADGwQp1+iKxaT6MEkqJdN+qqxc5rhZL/r?=
 =?us-ascii?Q?pJlSlrR2zA54PsNmLZ4OwxQDH6c824V5LfiBBB4IhXyO16f4HKLyZ2HzvP3j?=
 =?us-ascii?Q?h+CueGw/hHOwWPgbimQtKQINBcUriBhqI8ENyN7EattA4w/7uF9Vaptb4jT5?=
 =?us-ascii?Q?eS4m5P2c3oYQTJmPN8GVs0IHMRRcRS2TEi+tiNUpV8wRcV23jOto8z0txdd8?=
 =?us-ascii?Q?+Vt/DbIxjwInKArIvEBv8f6hmNkjq0UU8u8OskHa6cQkyG4WzanEdGs32+6l?=
 =?us-ascii?Q?vZNVlT8F8wp3bS88ho23pPhuFsalqOsHStmSnf41qIUKChYXDHkdgpS9c2ov?=
 =?us-ascii?Q?28DP7N4JYSsZimJvnEDo7MWWiR623San6L8LgfhLx7jjRvfDmQC44GoMtQAk?=
 =?us-ascii?Q?+C+a+oFvMhKC3W5P/zaq/S9OuOo3z3JYY1q4uY4N+fENdbgeO01g0agp9n4m?=
 =?us-ascii?Q?0mfjDyryeqgCOO/LX02aeoOGv5fkHr1SwiBAD9i7RXaL7uqkje1EiJfe5pCe?=
 =?us-ascii?Q?7JsgEIwKMKiZd1K0W5YIX7VyeIefWcVUkoDvjrud7BJYM/tfpG59p7rDRZnS?=
 =?us-ascii?Q?oeH8r/Ao3xNl+aD4m4VfgnWp4IdcQoKplPxKMEk+l+smeQpndoXGqQYX3ssP?=
 =?us-ascii?Q?fNolXiF7z7iCcxYUGHDef/jPF8pe/6lYQIkn7QcozUeuifoscscM1j+q5V1Z?=
 =?us-ascii?Q?dMHWM3e5Avf8SymStiRI89Hn0iBJ5I2NR5M40Uy0GInPxwCVu0gDcOVRL14q?=
 =?us-ascii?Q?W8qttXYcOeFnjHpm2+cLqiaDuO74XEEqciGx4udl7wtX7sNHou7MyDOsKUzR?=
 =?us-ascii?Q?JcGNBXCUf7zuSlgtafj8RPirXKeUXpwZrL7KtcGPmDhqhLfLt95T0Z4V+GyJ?=
 =?us-ascii?Q?a6bWh8Ufui0n9Nd/j7XKMCU6hzQ4q9d2IvSUjg5pfTs5o7zO+UNjcqCEi+ax?=
 =?us-ascii?Q?qVfXA0a2W+ENOVUUrZ9WPlAHu669C4aNkP2bwGZ7IYltKAHczWiOHNoN42UO?=
 =?us-ascii?Q?u65Oog6W08+R53XOPWRBM0mM0EQBq/HINwNba/uuoP8f3h6wjgvZQWwcSPK6?=
 =?us-ascii?Q?C3xwlVwZ5ih9PmC90sLcRxuVVfrNPRAP/5fczd+5IKfwCTh9+RUCRunPeIKR?=
 =?us-ascii?Q?Y17Pf0QbsaYATCi0fl5WdMarOjoN8XTU5uWlAYui4LpM/S4BVTvO+PfBv6Hx?=
 =?us-ascii?Q?iInJ/YP8T+qiBA0xU1O2sSKElBBpnBgYegFYpuW7zE8pGvx1KvIdGoRkCM+j?=
 =?us-ascii?Q?cQXtW1JcaCTz0zm83pbaESeQAbwmU+HBQ5kXcc083J9fnTMllTH+S66Isxx0?=
 =?us-ascii?Q?4g=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81a47234-074f-4b38-895f-08dbbe796d09
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 10:14:53.4663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EARTRMB7Dcu6sA80AI68cIEy8KUDX6MTLG+9/9GjDoxONoKqVz+3K79DdyOcmDVhKUmlwOjqsaKbOaEw9gTm4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8130
X-Proofpoint-GUID: ZU4lBYHcYwS3GSPg0OpLjgZDBtNGtjlD
X-Proofpoint-ORIG-GUID: ZU4lBYHcYwS3GSPg0OpLjgZDBtNGtjlD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-26_07,2023-09-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 spamscore=0 mlxlogscore=733 impostorscore=0
 adultscore=0 mlxscore=0 clxscore=1011 bulkscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2309180000 definitions=main-2309260089
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 26 Sep 2023 10:15:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15127

From: Chen Qi <Qi.Chen@windriver.com>

When scripts rely on bitbake-getvar's output to get values, e.g.,
oe-find-native-sysroot, we need to ensure no warning message messes
things up.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 bin/bitbake-getvar | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/bin/bitbake-getvar b/bin/bitbake-getvar
index 4a9eb4f31..6be194e42 100755
--- a/bin/bitbake-getvar
+++ b/bin/bitbake-getvar
@@ -37,11 +37,12 @@ if __name__ == "__main__":
         sys.exit(1)
 
     with bb.tinfoil.Tinfoil(tracking=True, setup_logging=not args.quiet) as tinfoil:
+        quiet_level = 3 if args.quiet else 2
         if args.recipe:
-            tinfoil.prepare(quiet=2)
+            tinfoil.prepare(quiet=quiet_level)
             d = tinfoil.parse_recipe(args.recipe)
         else:
-            tinfoil.prepare(quiet=2, config_only=True)
+            tinfoil.prepare(quiet=quiet_level, config_only=True)
             d = tinfoil.config_data
         if args.flag:
             print(str(d.getVarFlag(args.variable, args.flag, expand=(not args.unexpand))))
-- 
2.40.0


