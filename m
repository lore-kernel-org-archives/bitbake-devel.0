Return-Path: <liezhi.yang@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E3BC433FE
	for <webhook@archiver.kernel.org>; Thu, 20 Jan 2022 07:27:16 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com
 [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web09.8943.1642663634760688611
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 19 Jan 2022 23:27:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=pps06212021 header.b=qCyvboqX;
 spf=permerror,
 err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}:
 invalid domain name (domain: windriver.com, ip: 205.220.166.238,
 mailfrom: prvs=8019647b9b=liezhi.yang@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id
 20K6qW7T004376
	for <bitbake-devel@lists.openembedded.org>; Wed, 19 Jan 2022 23:27:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
 h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=PPS06212021;
 bh=YIlVa8n3Yt2dIl8xW5v2keuL7DpsBUldCUZzP0eMX2U=;
 b=qCyvboqXlnUO/IWwe6fAdjzofGTP5CL2Q0oIlqfiRURjyzlnPMb8NRMvAFGIB3zvbB5v
 Bo1lQg0XutKNUNzLrAyuJc3fafwwGSJ1NbfK0y31bYxEy8pweHQ9Z/idsjKihyrZtY+H
 +OK192hbAYnc1NJXxEyxSTfUDkHH9eX/6m+rqdo4R/CfnLC022fz+d7yh1wRPmE4J72f
 Mvc/wTuL77I5ZlvgFRAQl0LvCFHdh4cSdVTKjg5DRcsh0k3pqx1lWzMAZnZCCHFoppTg
 iqzniEDM8V1cxgeaUl+lM3c8GYpgUGGwno8LIetRZCeTwClN0ZxDIeAnB7w40AF1P1Cl MQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3dppj80eb8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Wed, 19 Jan 2022 23:27:12 -0800
Received: from m0250810.ppops.net (m0250810.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 20K7RBWv019392
	for <bitbake-devel@lists.openembedded.org>; Wed, 19 Jan 2022 23:27:11 -0800
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3dppj80eb6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jan 2022 23:27:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X7D3hQk9Jd08H7YD8xVlFUwJJa1VnkaLJJmDJFCgBalKz4CQfZB2x9+W2tgQ5yErrw69MQiACwN0ni9Bd9bR8knG6xzJZKjw/5KXyoe9Lgeh9/MsOFx7HEO2lyIa6Mk5ODjjfv+EjH4WrlIxDgLheftOUlDH/aBzaQWtElsZG/Bpjt8gR6Vv7QmvZRN0+ZHgrpca/djHw6L+o5B02IttPREoeIRxTLAg5T6dU6M58xB8Ol0hmtIP91GEEeE92L3UFxr7ONB5ZpgLZT6N74B3RBJ2L2xR9FtZXioaaqliDNrGWmEJvCwdK+1lR9jyrAKSRw4xMcmIlodVEU4AUl0Odg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YIlVa8n3Yt2dIl8xW5v2keuL7DpsBUldCUZzP0eMX2U=;
 b=jqZpjSWOKWqjl9jhXiitaWrKSv8ao1akikLAXloIoXISfLACUcz/bf4zP4tXtOrtod847rfPSwStExmagGMSuN56aEeeMnkJL0+TFMbB55EfiIv9H9RMTVz6x4jYQXR2Ylcic7fJkc7FqcMMp9igXyyNZlYdwQJZm4/2wojwZAdpBCRHbO7BrflQC2aCb8bWUMhXDb/kcYTAy9u+UPz7D3cslsL1UXhzS+K4gFbtU65yOwbqjJUQhOUILuMZgKnK8AvAxQHj5cPLTcWU6abT3UnfT9xmWog+SUMAP4usP9/WWmhryc5iYBsVyDem0ye7MV7a+nhxjOA6Jufzi0xJOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BYAPR11MB2789.namprd11.prod.outlook.com (2603:10b6:a02:cc::11)
 by DM5PR11MB1308.namprd11.prod.outlook.com (2603:10b6:3:e::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4888.11; Thu, 20 Jan 2022 07:27:08 +0000
Received: from BYAPR11MB2789.namprd11.prod.outlook.com
 ([fe80::5cb5:e426:2e48:17ed]) by BYAPR11MB2789.namprd11.prod.outlook.com
 ([fe80::5cb5:e426:2e48:17ed%5]) with mapi id 15.20.4909.010; Thu, 20 Jan 2022
 07:27:08 +0000
From: Robert Yang <liezhi.yang@windriver.com>
To: bitbake-devel@lists.openembedded.org
Cc: quaresma.jose@gmail.com
Subject: [PATCH 0/1] bitbake-worker: Check BB_TASK_NETWORK before disable
 network for task
Date: Wed, 19 Jan 2022 23:27:01 -0800
Message-Id: <cover.1642663574.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0147.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::32) To BYAPR11MB2789.namprd11.prod.outlook.com
 (2603:10b6:a02:cc::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0df583ef-bad0-4747-db28-08d9dbe64454
X-MS-TrafficTypeDiagnostic: DM5PR11MB1308:EE_
X-Microsoft-Antispam-PRVS: 
	<DM5PR11MB1308E17130F0747F153D02DBFF5A9@DM5PR11MB1308.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:260;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	E+IhmCXZ0G1WKiy9QVDs9BmWbw+TJO09rOfrKnYAqneOoJYIZwB8kyZJl2Qv9RABuOVj7hdN/nZ72rHpG6nR4yLAiahhurKQqaZV7j7ZVMNr4JW7dYeJhiAGQ74K61ogYfNFAPzj0oq5fAHax0vH6NyyyKkt1zwLi0ka+T/u5xPI+CnSJ4bCDEBHZIX8Hz4+NrbTieDPE5mRnzrAmEY1cFbH8+Tj7rH4mpkx6gAcYnGovWsNmnrr/qZa8pfgp1RM21G214o4bxDYUa3wFrMjHT8Ij+sJTYCe9R58LnL8578hSR1Ca20GNoQGMqbT1zXuFX/GL3VUbNGZEMZlpVJjnlRHBf0JbxPZaP/VJ/Gc1hC+6zvobqcd5KS61sK/3umGC7odyxe3ChWu1VBKrdO5XED2DBPEWl1GgysO0dtcX+CJuCXmUYyHo3Tj0I4fYkJKppB6Naz+2+WuVj+zaXYpUMD8mmV96RzAXWtD5hDqKVUvKtyTWSQM1HqJY6Am98AMcjYQo9bTeXSnqE1xJ0WNCPYIa4NRqnSPMp/hvJzPerOSMOK3CIZVu1Z9T1e8zJ8dZB62g0stY14zXHPkKFLGJVZTXZu5ngYArO/NfG+CsU815Q5aCQxzL41fm301CNIhor52d0I6nyQu1kZzBhBqDFv0SFHjV8dcAMcODMrLNVG+0X13rMQbnsLgDGI6Rs/dhuwi/yHnbHsggJxGbunRkLLpBxxnPk6KHSCt1jfKuz6r1quIHNqCgpLl2sTjQcp3jV3jEaQBjx9lxYCle70YXrQCU8nuOiLNrfturUIOSGY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2789.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(4744005)(316002)(2906002)(66946007)(508600001)(4326008)(86362001)(66476007)(966005)(6486002)(83380400001)(6916009)(6512007)(52116002)(66556008)(6506007)(26005)(8676002)(8936002)(6666004)(2616005)(36756003)(186003)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?2z2yJ7S52w/d4X6BQqeClPsp9cVEISdBZUVqFKT7C5ykxQuHEjD1/qa9DvxC?=
 =?us-ascii?Q?LMYbNgOMxp2Je7XS+AKUMSUHvDjCHY0Jp6Iq2dce80iTAPrzFOe6vo9vRF0f?=
 =?us-ascii?Q?ogyDPw7HHrSHzEYOOaDHrEHsYJQST8keC1YCeE5mHi+mWZqRqJEVwBunsSZK?=
 =?us-ascii?Q?+jHVTB0yIZXWYbvYjNtn/EiPbNpW8fWbhxVfEixUIRWBTmrLtZO0ntTXkjTp?=
 =?us-ascii?Q?iORSYJrZ7Mdev0Hg55Oaj7fh8LKw+ZColUg48hqYiipDhLgP4PNLSbFUOVuP?=
 =?us-ascii?Q?LmOc0ICjr5OfuaEqb4+8k4VC3X823QUp7IBaywjiYUVDmbUMdtq4eTyXO0Pb?=
 =?us-ascii?Q?9qucoKiahcYC4+CwIlwd6XI5q/Nn0XfMzt6LTq2P0szT9HNjasQfgPgKBw34?=
 =?us-ascii?Q?pFnmiiBg/Hr1OtgDlsokV0QcjBqWra9xVxcU/V2EO72up2NfqEwNmfvDj2Xu?=
 =?us-ascii?Q?P6nHl5N+355/qt5sKXNXcv0mNykmkHCBkF6hiStzmIbygcXDzGYo9i5qw8ND?=
 =?us-ascii?Q?0iWlcicRBZzMFG15fI447b7MPhKnlffxhBOP4e1jA8XCeT5zr1H5v92rShG4?=
 =?us-ascii?Q?PS10l+bx8lHQvRrsCazVxlX926ugpL9EVBsQHO2ugsx2SXph23F3Xaj5f5ss?=
 =?us-ascii?Q?lHH4GSzBzt0p5WKWsRj5IXyKsr18o4W3+OoVesByohq/cO6TiL71qu2US+VN?=
 =?us-ascii?Q?mk+fQDRWK4Wi8XfWJhYjFZ/tTgsB/SKpmQrddczliihFvvq99fgkUeAYGsrP?=
 =?us-ascii?Q?QRO/235L8Dz6eGRg+yjJxyLiApd60qc1ZyTB+elIuNCz5vHLyqlwbbSHe8+y?=
 =?us-ascii?Q?BsHqDSUVeVnqIUOFMSjPQ9LFyEVkTMvtkF1SmTvAwiPJIp8JpZyq7RJWCpMS?=
 =?us-ascii?Q?cC9rcVtZFnzHA8i8EJh6rE6gi/7LptmM3xf4RZ6+mpOibDC4dQPWYEzeZttP?=
 =?us-ascii?Q?8PvKcPux2b4cPuUHkcPyyjQc3VQGj+aNq8AZ709px5Og8ELuYF9ikREZJ53D?=
 =?us-ascii?Q?b2CslMhqnXvBmhUTWrKrQBXnQkVLkIBc1GdO/djbgVyR3zdOutu/9itmvJb3?=
 =?us-ascii?Q?aCORP/cFVzqKxCv/MEhTWg1gF+IL0ykHom9RPtw69dR4H17Pu3SlPkmhbY9V?=
 =?us-ascii?Q?cpTiM9P4tlwnpddxGgoaIvAcvlul3zKcUuwJL9gdoYnqcW3fU/2JsB5wuDbf?=
 =?us-ascii?Q?nl9sLbJTNKUIBDwbAeIUKcqpfzPlQY6kmueMEmPkx0nhWAQN53UfWn2H/4qX?=
 =?us-ascii?Q?YNKD0q5K7srhrw9DBNhCMoNAfdUM/hqWWWkHgTRY/cK+/3N8BEbrU+3GnUm0?=
 =?us-ascii?Q?KKdzZDbH2MLeuaXVXQqjPU4GCXqVO+j0Jpwd3HDp/cOm3B47PBDQEOH9J1/b?=
 =?us-ascii?Q?6nBwYsyv0hEIos9NyHJH/i+6hlLV9ImDw3yB+faUQ4K2yneEiobjbe0xIHHM?=
 =?us-ascii?Q?9HL3WYt3gELde+kMnk/aLE4dpY5k0uhoRx02R1GUCDq9hqSgbxWT/7rYO82n?=
 =?us-ascii?Q?iITM5Adc4vXCck/fAj9B3KRPWaMF1zw1sWJ62Z43VnMai4o9jTqYrUL8MVcH?=
 =?us-ascii?Q?fWZNQubMOzeYgjiheEKs/7TiUbtXlIky33IJoEYCapFVrlXJDkZnGJ5mDDTv?=
 =?us-ascii?Q?p0HTlZs55yyWba+VtNGejVAkPhR73EgXlq+Q0ckFK60dJ3ONvXkM72UrMdsx?=
 =?us-ascii?Q?un7jyMgwAbGJpXIWH5XUbyWRC3k=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 0df583ef-bad0-4747-db28-08d9dbe64454
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2789.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2022 07:27:08.6258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 vheQl9IlkIJ/fmjja4pohjVSo7iQ7aUUEOArYQLVsr1UrWeUTfWvZNhyQ8f3UArfo+WsRUjYEnVMVvwGTueyJxZQvogEes2C2f7DQLTIPN8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1308
X-Proofpoint-ORIG-GUID: vkLQqHsPSacNY-5D-7JOGoNp-itaiEYL
X-Proofpoint-GUID: 1STb97jS6NI-S3zA8cHwdNkScXZlzYQR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-20_02,2022-01-19_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=659 spamscore=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 bulkscore=0 adultscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201200037
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 20 Jan 2022 07:27:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13253

The following changes since commit 4f24d5daa63feba1849f9c6295597b97c3a42035:

  build-appliance-image: Update to master head revision (2022-01-19 23:04:08 +0000)

are available in the Git repository at:

  git://github.com/robertlinux/yocto rbt/network
  https://github.com/robertlinux/yocto/tree/rbt/network

Robert Yang (1):
  bitbake-worker: Check BB_TASK_NETWORK before disable network for task

 bitbake/bin/bitbake-worker | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.31.1


