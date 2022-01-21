Return-Path: <liezhi.yang@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2974C433EF
	for <webhook@archiver.kernel.org>; Fri, 21 Jan 2022 06:53:08 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com
 [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web09.8698.1642747986771862234
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 20 Jan 2022 22:53:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=pps06212021 header.b=GRQr5nT1;
 spf=permerror,
 err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}:
 invalid domain name (domain: windriver.com, ip: 205.220.178.238,
 mailfrom: prvs=8020d4495e=liezhi.yang@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id
 20L6WJk9030616
	for <bitbake-devel@lists.openembedded.org>; Fri, 21 Jan 2022 06:53:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
 h=from : to :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=PPS06212021;
 bh=DQEg/ElLvuDsX21wij+tBryOFjAqO27q51fEnHBUzB0=;
 b=GRQr5nT10Kpvy4v7NlAP7N3f4wN0Vw+nbRJnzu0TInO0rGk6LUaFg7oHLsFrzUM/CHOa
 v27uIlYP6j29hTiDtQ6AvLyQTjCqlr2Q1/bNuhyCF0H9w6ZO5uAZDBRuQxY1CF2fvyfL
 VpYC7+ZH6qlaXmq0qa5qT3tc3VD2nwQrFg8TUFsceZauet+Todsta4KwLG4qifO8XiZw
 P4pDDWYBst9TzlS9XMYcSebgsuHHR82LthynTt7kIb7c0WTYgF1Hn3QX0781XUioXblH
 IdBGCFmI78rTkO0e++hpkpvm3Jbt3rHkI2Ma4GsKVImCd1ZSC1h7I0RrR69Y1zjs8LR/ cA==
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3dqhx0r5uv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Fri, 21 Jan 2022 06:53:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dzsmIyghO7M6+7lUBPyGXehYtHoVHFg4a54t/RdReDGEz2Kd/F3LDBrle1oNyAZQoFnFPU23GuqmKQkURrIOMmF0xnGiomoB7Qm6tjJvA8Un0KROaQ3JHLW4tUaUDmRWvhShFd4abTd/biDiygnpZU9HU7othnwNzPfzosfUminN8rXnzQyPpGAu8SNEQSS8DhckAGNEZUNZMm46uqqfqMYIf6X3Mhlg/4TPpGYs/91wgmKYy9h3Ki/wSbjxDFBFWrNfqhMjWGQJCPpJkxkEKrgnemvCG1AGHMxcU3+seQGPol/KF9lzTuKGkOANLxxRpTNmA3adrHcwhp81GYkGaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DQEg/ElLvuDsX21wij+tBryOFjAqO27q51fEnHBUzB0=;
 b=Y9g364yJmzD5E8uXgWpqNGWJkGTOnuftBH9sxI13QbcAYDQqQyEHj2zfXL0/2sms/sLLXShfoSJ4Ck4R5L1bhwpeIu6qmnUH1/Lr3Ixyu1WD/I/m5RRO9qkAMbD2bc9v1lD+XciKJ5a1WRUEQYO0U2vwcOnJFTB73K7KdUFWpMnT4+psMZp8Y1sUOlayrLAuPSAg7M3rfTNaddBdyJHF70aGHH2ezhBs1Cv5CGH3uhXzFfetAMiXMgXDjWEm3BiywR6GtXWcIyQ7ZJ/8NIWuio/JOWubeCDGl522HScGhn88hhFTzRa3FdMTfraSzvoUsWzDh7VfswL3EY5LRO6QQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BYAPR11MB2789.namprd11.prod.outlook.com (2603:10b6:a02:cc::11)
 by MW3PR11MB4715.namprd11.prod.outlook.com (2603:10b6:303:57::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Fri, 21 Jan
 2022 06:53:03 +0000
Received: from BYAPR11MB2789.namprd11.prod.outlook.com
 ([fe80::5cb5:e426:2e48:17ed]) by BYAPR11MB2789.namprd11.prod.outlook.com
 ([fe80::5cb5:e426:2e48:17ed%5]) with mapi id 15.20.4909.012; Fri, 21 Jan 2022
 06:53:02 +0000
From: Robert Yang <liezhi.yang@windriver.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH v2 0/1] bitbake: bitbake-worker: Preserve network non-local
 uid
Date: Thu, 20 Jan 2022 22:52:54 -0800
Message-Id: <cover.1642747927.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.33.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR04CA0020.namprd04.prod.outlook.com
 (2603:10b6:a03:40::33) To BYAPR11MB2789.namprd11.prod.outlook.com
 (2603:10b6:a02:cc::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b49b21ab-26bd-4b13-9276-08d9dcaaab06
X-MS-TrafficTypeDiagnostic: MW3PR11MB4715:EE_
X-Microsoft-Antispam-PRVS: 
	<MW3PR11MB47151860E9E3405282EA8243FF5B9@MW3PR11MB4715.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:255;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	aK+phynxsBvVopwsFad2wFpGLUoCG0ucZPf0l8Hrbq+f/QkMtU7nHKlC1dmeHss0hAcszx64WCVmR1bEDMAex8ZJRos7H47qTv3keiL3gWFuhJvt0Ao6e0Y/N72s5hQ1X7qLrPw6z9V7inFRHZJ9+SqI2L82GgumQ6fsBkrmIxSlQTXLek+oS5CL05UPrtENYVI1XNc76RqNu1zv8255FbUk3OpkiNk2Vt4VZ0vVreB5JdlY9t56jDvbncqi8kySDK2fxxVy0Q5QWbYfwQ4gjz2TL6+3HkCo120JTKeqmLe4H7HW/S99HzUGCajTtsFqCl83lwJjsyS3dZA+fPT1X/KbhyJsAQXnRihbISrZS+Zc33xLNFu880BIRgY6izXIzzoSxpiY0eU1CnU3QrIZCOO72j8DiaMjWFqUakcRMpGNVEXQ4CCCXpB5X/H/iinYVhIiWREIjteyQhYksRfGMaPXmztYw36DsQTeMs625vSUDVuO/c0QmLU4UFk1r3hxDiWuFHEfmiZgEhh+b4dEylTs4BkU/U07h4inv9c8zGvzEEsr4y/ToJeA6IJ1uMP3n39fFt3wLtDfPyX9tTAtJZX5mmY/0+sLsrvDz3kcVUp8Ux3RAf8zO91XF2e0cI9LUhx7abbDSOeXAnOOWkxAgXNlFnZi1q4xBhVnKRhmWsIKxBKJ20Rmfe0IMfWr8vQax0qxBcvsmMJkR+dG9WIB8yxW8PPU+IwzTAbYRYmkK49Egekd+a2lW9CPxsgdFLwKbH6ui8MgEf94Z70Tp1WjoQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2789.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(6506007)(6916009)(966005)(508600001)(38100700002)(26005)(38350700002)(52116002)(186003)(2906002)(6512007)(8936002)(8676002)(66556008)(66476007)(4744005)(316002)(6666004)(6486002)(36756003)(83380400001)(86362001)(66946007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?6sUUxSQ2gWAbQPJnrrx3+sn5pR7exdXoAwTDYhxhvytzxpgd6R4C65qerdAt?=
 =?us-ascii?Q?hRWz85jsPYjALkn1FtPouCUCUlWD/DPNjQCRPk67PZYX8ZbX4CGN68Um0kaw?=
 =?us-ascii?Q?9SdgMIhKsY6mDm4L3l/AL0hlmdsk3zlDcmUW/QII1en6IPIihNBXILhnNIYp?=
 =?us-ascii?Q?ZjX+6tpmGxcXEPU2Z816H8MJIVxuS8sx9qckLfEmQaOQc2ns+8wHfKMY1XhK?=
 =?us-ascii?Q?82r/W4cP8QM200A24Cv5nkKoreRhUx+avdVdn8ZE7w1EMZTIpevk46jnoFzF?=
 =?us-ascii?Q?KddUfaIQihCwA6rMVdFxdUBo4ccvjjL2Boq3KiwV7R37iE7GHuJCQxrM+qNi?=
 =?us-ascii?Q?zosiXZbQaM2kOwW5hOHNx0QQ0pg7iY2A669msre44ZnIASdNRfsBaWFrEmVC?=
 =?us-ascii?Q?5xRo7xZ9X8YelWYeEAQxzi6kElpZ5cxxwOR0cHP8xEltShGuFpLpqo5iu2qq?=
 =?us-ascii?Q?tJL56MA5zBlXf/C5BAsBvtVtaATezTIQ9A8Dh7ib0Ar4gLfGmWjSstWPH0/N?=
 =?us-ascii?Q?c+YDrukgq5TceL4nVi5eYOp4rorZRu6J3/wv0zTFy+FZJegAxRoju+8BQufr?=
 =?us-ascii?Q?PfT3Nuv3fxdDiTNVUyPukIYd72S+m5PtJlYenVEI4pcgHjCSFo+vP03BxEHX?=
 =?us-ascii?Q?cLViqp+ODrdaMG4ebAmuaQEgWoOdBseg90YoAXJvU0WJ4RVqYW7tkMHCcQrS?=
 =?us-ascii?Q?Yu2NtBL1xANYgTmf1VA91UCd0Q8eWRhWLpO1KvZytu9zLy3vFeuZtBSCM1kF?=
 =?us-ascii?Q?phKdJC1eUO7Fhyq3rk1a+pjFLrtSQLxuecj2trHJqCE4TDNHzsh9AUowkYr+?=
 =?us-ascii?Q?hixSajgJ2MHl0QD1QLAorKWLo9od8Q8muyAn464XXL6QEY+qUWPMydOKhTNi?=
 =?us-ascii?Q?AQ6y3jD6meCyskqIa/d+aB571jFKJZbKDoe6LNLubq1VLDsnbPgExf9rWW6s?=
 =?us-ascii?Q?w15lktFe6mFMtDlmm/uJ+6R5pLDsGNmTLY22Zx7y8Rk6QiwbLcb+p4Vyxqwt?=
 =?us-ascii?Q?4TBZR38apqBsxQm9MCrthx3GbFyEoxmeBGTgHHXTEBiri/hBkTIbJBkdDM6w?=
 =?us-ascii?Q?pKYwR1JWvCfBnBvQlTMtAvL0tJTlNoCas26x99T7DwpWwx60aWSQWY64pKZ8?=
 =?us-ascii?Q?9bPOZzBy5zh7eF5F08KFKhHyPaSsaX7FOMAqKRs6xGaJVWOKp29L2PjhjSrb?=
 =?us-ascii?Q?C6lDX6SWwqzY9IB6PMcFz7tnR14EgwBBvmnP8XZdsJB9h/l2w8+Ot9rikq1/?=
 =?us-ascii?Q?EaOiMcuyjzdsTrC7yYpTxZwdPsxgVqpcwx6mZq5hE1J0rV+TuJVcg4iHfQgY?=
 =?us-ascii?Q?6nByhPHdw3fjQQYCpIPBe3UbVGXJXtG1YHTnnNNQrhEGJhn4bbDoqG6vDrbA?=
 =?us-ascii?Q?DDgdFcudI6FMFeCZ4PYjE920g0JbfWHeer2q3x4iR6+riy52L9UoicKDBDV/?=
 =?us-ascii?Q?2mBbzYbhN3mL0LziIyG7L1x6kp0kv0pg/d6omqsVO+MyEWqCvLankIU/5j5b?=
 =?us-ascii?Q?3PUvRpzwfiGf1qxmtSZVNlE5Tvvbn6tcXNyIuZRgx475KgqZVBFqW3AK6JRy?=
 =?us-ascii?Q?48OeVe4KU7utGr6IcY6aedeMH+aZ3jRNVnUZwRcTX1IWUbLDEo/p5oxhxiiX?=
 =?us-ascii?Q?XWNMifQOWlJVUonO1Pgain5V8M6JKu5fVtX5+U7msroWZA9c6aipL3H4f6MD?=
 =?us-ascii?Q?9/kvsjY9QEiYwkbWXX7GDSAEkes=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 b49b21ab-26bd-4b13-9276-08d9dcaaab06
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2789.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2022 06:53:02.4802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 VTIgh28LWCi3eAWyG43CfeCiNtw4o1d9DA0/5BzPzPKHRs/hym6d0OKEFWvuPGLaj96Ewdh49Oojs69SfN218//2fVFBwUjSHhI3hmiTqa0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4715
X-Proofpoint-GUID: lQH8p04SSliGTDmpkAqsaRpRwNdiHu9G
X-Proofpoint-ORIG-GUID: lQH8p04SSliGTDmpkAqsaRpRwNdiHu9G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-21_02,2022-01-20_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 suspectscore=0 clxscore=1015
 phishscore=0 priorityscore=1501 mlxlogscore=653 mlxscore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201210046
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 21 Jan 2022 06:53:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13267

The following changes since commit 4f24d5daa63feba1849f9c6295597b97c3a42035:

  build-appliance-image: Update to master head revision (2022-01-19 23:04:08 +0000)

are available in the Git repository at:

  git://github.com/robertlinux/yocto rbt/bb_network
  https://github.com/robertlinux/yocto/tree/rbt/bb_network

Robert Yang (1):
  bitbake: bitbake-worker: Preserve network non-local uid

 bitbake/bin/bitbake-worker |  7 +++++--
 bitbake/lib/bb/utils.py    | 16 ++++++++++++++++
 2 files changed, 21 insertions(+), 2 deletions(-)

-- 
2.33.0


