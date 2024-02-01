Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0046EC4828E
	for <webhook@archiver.kernel.org>; Thu,  1 Feb 2024 03:31:18 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.7746.1706758277709518154
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 31 Jan 2024 19:31:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=oxYtEy2u;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=276184b32d=qi.chen@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41125UGP025555
	for <bitbake-devel@lists.openembedded.org>; Wed, 31 Jan 2024 19:31:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	PPS06212021; bh=WWZ8mWvxqW5lNVrsXArQ1Sw5BAHyFB9uMC4xanVyCsg=; b=
	oxYtEy2uEUENdsQB2JZSbhL68VbYZG5FBGH+yzyz6UkE2NxvCOblnOmMQtuX6tBa
	3dihpDijcqG2q0oyAGW191VjyxqO3hYH3wmmkiNKmTYe3lV2Fx1znClTvT5VVn3B
	omtY63PXeMUQ+x99xwA1H8d2QvvTQJEr50e3IespM4Bf3EZll2P5kauttORPHm0q
	OAFe9JhUr5m2Z0AvQArGZu2R4sEcZ1+T11YfvGEc6EVMjRzkvsitMqmmMVht/309
	jJlZ8BkTE3f7yQbq2ctqpKZhNzdKo8wSZnEOPZH2xAyYrfY7/HSARDQl+9n0tfFP
	i9HRe2liDWi7pdF1cWFpyA==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3w0276g1q4-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Wed, 31 Jan 2024 19:31:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h4GLuGTHwk6qLkZQAiMg1sHorM1A2/n2o3gxsWTiU6iPE9Xi8G7w8aeVGs0gcYAiH/qJKIrh0+xgRbug5qhLLFQjFm0CZNIbM7fhUaT4raXpDCW31dVvus5ijtV7jldRabBib2bOYHjdELDUuulENRy+O0tAVev+VVdWpOTatEi0nMM6fSLHz3rSNNHQ/yrVnv6PUDzh7LVHmaMBNyZ7C1lKrLvXOf79wTkZEsixHvZOo3modCNRDBsilnHsMOouL1qOk2dt+2SS9/w8e8Put1Ryo4FeGaTviY+24EVlSmrhx7CpUQpvFZrnjSxqcsHN5ICPHQ5gbb8F5AKHYSf0mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WWZ8mWvxqW5lNVrsXArQ1Sw5BAHyFB9uMC4xanVyCsg=;
 b=oCaj8TtgWmMVJGNUvStfP7VnHNtRfJHGckb8v8TGAvsP3Hbs7vuSvPiysiuwVfQ3W+tD5uhCzjRLos4+y2vKdDfzCrEu8VJ3rbx0UQ75g6E0aj+yK1+uLGzz/c/nu4UQOZp6pQ8a/DvJJDP7odZz7DlFJM7LbItqtmsF8HhtaYTvVnyMtvn3mz5N0IWKZxcl4WTvTqkHBsVN9SQW4p+EXHStmbG5fMsLnRBo9oGfyfshmiHupSwAA0UTa19ObGfVqmncE08kEcBsErwES/yTGMGfb9sjh/oqH5XeHqyzkwQebqbfSU/Ig5oqza9JgYF3Qj1ff/qRGIc6vcoe6/0VMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by PH7PR11MB8598.namprd11.prod.outlook.com (2603:10b6:510:2fd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22; Thu, 1 Feb
 2024 03:31:14 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5d84:2b01:5029:9315]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5d84:2b01:5029:9315%7]) with mapi id 15.20.7249.025; Thu, 1 Feb 2024
 03:31:14 +0000
From: Qi.Chen@windriver.com
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake-devel][PATCH 3/3] fetch2/git.py: add comment in try_premirrors
Date: Wed, 31 Jan 2024 19:31:00 -0800
Message-ID: <20240201033100.3617421-3-Qi.Chen@windriver.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240201033100.3617421-1-Qi.Chen@windriver.com>
References: <20240201033100.3617421-1-Qi.Chen@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0P220CA0013.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::20) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|PH7PR11MB8598:EE_
X-MS-Office365-Filtering-Correlation-Id: 6119cccc-725c-406d-d4cd-08dc22d63dfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	viFTyWvu9xG7ry95iCY3uIDNUZsGqX+5WXN9BhWBZlTR54jFbBAJMFrUU7uypjzIObVqLNuCUkXnAEwWMOJ0LDPh4azIzRdPqdcuFBaa4OpxKzCkCd/DGQNWZL2S+QJ6vZ7tzIwT6MLdBGHFpseBgPY2Cr5Ot7SQkfF25cV3bOP2MCODBcR5ILZf9z6Ppr/bsTW5ZYaxhZcK40O22UFe0tmEr6zVuXCHlDRR7OOVZCX0BadANo/DzGjW/E5QtcFT2a0PpF5EQxg7BH6zIWaACzwB3cqoShC2nX7hunhn9lMr6WU5NhQ3YXRgo78YcB43LRAk1ROJa0s2DiHnplM9td6k8+eJjvf/sT6mqRa9mumvVsWPfDUdUwHZDkBgL5LesI3Gykn3czIECuL2jMWkBxVPfQjfOuaISIS4JIabXyKDbuemO3VebmbEMnaD/04cTuQzvj9yXZSLGvJBgjkGr3shGZwP+OVqY8/NxsYv3belXzUz2jpA7mnXBi6OGLkrOsG/c1i4vwz7sBuWseljdBrQ2iCu8JUueGIC7rTBrCrNNP2LTiNlw0lmnRuigdZNktHlfpNMlVFsO7utnsBSJVbgb4r+lMIxatOPhR/O7OXBqzp3Tyz+dVQHJU54lmly
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39850400004)(396003)(136003)(366004)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(38350700005)(26005)(6486002)(66946007)(478600001)(5660300002)(2906002)(83380400001)(9686003)(6666004)(66476007)(6506007)(8676002)(52116002)(6916009)(8936002)(316002)(2616005)(6512007)(1076003)(66556008)(38100700002)(86362001)(36756003)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?+EODGdVlBGAmTVfpJu/ug1fdfPKJtbfS23fy9SnzpkKPXYHeqXYzoaIHjTjj?=
 =?us-ascii?Q?GnfiV/qwz38jtjR1Rdz7RogEeqcd8aNGkehRCH7ZmJA2KMG+QVu0hgW2jAGQ?=
 =?us-ascii?Q?S+2gKizMJKQygUZK+D+VAE0jX7KURwtuagu+z7YcCnlqt24h6B+oeiiZQU0R?=
 =?us-ascii?Q?7zc9mC4ohLCGkB8IH7ooIxYc7u5IYWrT8xmsYN7xFQT1saRtsJJEM+4Oq7rg?=
 =?us-ascii?Q?YaF4AXDkkxIfI2k343ENYz4ggbWPb5JT/pww1i9QdUl0fPTmAB/4eTOjT03x?=
 =?us-ascii?Q?qtbdkv48IzfsuHsIpX/j1+Pv3rYwOW1M4pAwIVDe1SbW52qefOH4pe+KNP7m?=
 =?us-ascii?Q?63bRY9klIp1/TlXe/zwD8qOmYDWnnXp6pSYHtP1tpx8CXGFjvYzzc2IqTo6y?=
 =?us-ascii?Q?cBMeX06BNxGqEWaOnyUJS93bYbxI1xTI33dVcmuXyKia8CBwXIm8NP4Fv6zy?=
 =?us-ascii?Q?CGl/Oxkh9719gTul0gx3PcLxSdnpzOeHQVdMAdcs8Ezimr0h7qG7kN/pLR3A?=
 =?us-ascii?Q?WVzObjo0ym4Tj33JwQP0L40h6owg6mVH21JOX85Vsdg+QyQmdd5qWEuw5ywW?=
 =?us-ascii?Q?tfHoUyjJPPSojimcjKo2BMKipGsNkwenVU01Cvbm99NRGGBKyviABeMJQlY1?=
 =?us-ascii?Q?YExwYE/DI5P+eJUxQ9OR8L+1tDVxlKF+gbn74ogW4onJ4rOwGKFmxbuuceMJ?=
 =?us-ascii?Q?78o3nrLoJnEE1Wz13sCmYijjZ5rGSjMcGFUUZdIldAETwCmGkkNV6+THvBkn?=
 =?us-ascii?Q?d1VZUu4rsF09A8Ycj8rhVSV069ZWzi7FB56PGkcLaVDAfFwYCDRDy2JSVRZk?=
 =?us-ascii?Q?Has8B6AvA/+AldCNZHag/4zf/I6dOgIwd/SmlHdE6Ik4UUkFfko9VJ9dOx1k?=
 =?us-ascii?Q?THGbsYIADQO7di2SQUiF7moQwVMN9z7A9GQdIcrjjAn4xrXIyjwQxpzJRJGp?=
 =?us-ascii?Q?lEfW/9rNhC8iF5ei9tQ1aDSHaQmG61s8Y7jJZ7jg/kowVt/dDllqf7vTDGnh?=
 =?us-ascii?Q?tdfvgmqJx8gA7+pey1DxwmJ9eUG+vlZJvSw/7XgdNn7NAgeooKmhJxUZVhdS?=
 =?us-ascii?Q?uC3jpF4IleuIsm3N3BDOiGNs+Q6aGI2+yKuSF0C3Rq+Z5ojPrlEaP0W+8jLE?=
 =?us-ascii?Q?dOXfq5fKk1nALYf20nYj/t9L/F5s0pti/ssMXhvuEVLgij2f2ln+jvMD3T3j?=
 =?us-ascii?Q?jmglOU9DY9H6rnR++gobZMNS2LJLSmqjlNXeAcDmAR1DusqzjemF5f1XqAz6?=
 =?us-ascii?Q?GLgnzrQd2yYnknAGOBrn+qQr2fZh+OWk7yYMfw673eMmNdsDc4tv2mwvv7Cs?=
 =?us-ascii?Q?bPa/nGgklweNoGIJ8y/vmKS+G/ioCnTGEqhi054wMnKGm7yiTWHEE4qFWJrz?=
 =?us-ascii?Q?ASt2W0pMVl8utkLwJUngYVBKjgZdtGUWgowCWUZLNbwVhCh/fGvzBmDgMBAp?=
 =?us-ascii?Q?pVnhIezBwkSa87uKziDymrrRkkvMyX0ccJm/C+OoKxylajdZBpL1RlC5BWy0?=
 =?us-ascii?Q?raW50Yq74AzZTrrYuD7w3Aqg808f9vlGurTfQD5lQw0WfkqawhZCNaC/Bmzn?=
 =?us-ascii?Q?tGBYdVx5TCkFR/Ouwora9pljmRlQXNw/yq+svdv6?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6119cccc-725c-406d-d4cd-08dc22d63dfd
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 03:31:13.9729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: itwSQPDIFtIyqTugfal5BeJjdGACrTG1DKICTemgHLvyUjTCQjOic/jgeTxP569isgiTifvyhD5qzkeer7HS2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8598
X-Proofpoint-GUID: Dt7MZb0qM1IW3St4oomVvGo4TBzpIpEQ
X-Proofpoint-ORIG-GUID: Dt7MZb0qM1IW3St4oomVvGo4TBzpIpEQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 mlxlogscore=736 lowpriorityscore=0 bulkscore=0 malwarescore=0 spamscore=0
 phishscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2401190000
 definitions=main-2402010026
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 01 Feb 2024 03:31:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15818

From: Chen Qi <Qi.Chen@windriver.com>

The purpose of ensuring 'incremental fetch' is not easy to see from
the codes. So add comments to explain this.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 bitbake/lib/bb/fetch2/git.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index 322a9366da..fa8c597ea2 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -361,6 +361,11 @@ class Git(FetchMethod):
         # we need to try premirrors first as using upstream is destined to fail.
         if not trusted_network(d, ud.url):
             return True
+        # the following check is to ensure incremental fetch in downloads, this is
+        # because the premirror might be old and does not contain the new rev required,
+        # and this will cause a total removal and new clone. So if we can reach to
+        # network, we prefer upstream over premirror, though the premirror might contain
+        # the new rev.
         if os.path.exists(ud.clonedir):
             return False
         return True
-- 
2.42.0


