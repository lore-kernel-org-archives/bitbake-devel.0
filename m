Return-Path: <liezhi.yang@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F92C433F5
	for <webhook@archiver.kernel.org>; Thu, 20 Jan 2022 07:27:16 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com
 [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web08.8796.1642663634846620669
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 19 Jan 2022 23:27:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=pps06212021 header.b=GbbLuMvz;
 spf=permerror,
 err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}:
 invalid domain name (domain: windriver.com, ip: 205.220.166.238,
 mailfrom: prvs=8019647b9b=liezhi.yang@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id
 20K7FlwW027476
	for <bitbake-devel@lists.openembedded.org>; Wed, 19 Jan 2022 23:27:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=PPS06212021;
 bh=09khABKCMT18uipFBp0zyaByToJTP+FGbDHJGnrZHbg=;
 b=GbbLuMvz9nxnXZdg/B1ZGRCxWJVJXa2035C5aaaUEUMsaZsK8FRdU7+ujWx3nPpmgYOK
 tiuAKY2Lp7yV7Zgrxs3jXehbFIb4+lK8j4afzWv3i+N8XcyYMwISBW8jQX3tqoxuYAjB
 5a2aQtOx4pYPVzMTLBHLOJ94MB50SPUwUuL3p0hQmOl9qd/ErHidwhpF3OJ2974Ovnty
 Ej33YafM1ncggdRrLTbBUyje6Vc7mcu0qd+yMQa1XQcYwm510kJY5im/maa+0m13oFyG
 FHKASsmSGLIvbdZwVPW/5qqIRJnLHkRU3fsZgDCGCKLml98Fx5kdvrrgJUw2JIuBmRwN hg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3dppj80eba-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Wed, 19 Jan 2022 23:27:12 -0800
Received: from m0250810.ppops.net (m0250810.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 20K7RBWx019392
	for <bitbake-devel@lists.openembedded.org>; Wed, 19 Jan 2022 23:27:12 -0800
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3dppj80eb6-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jan 2022 23:27:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E2JJ8YpTj102S1G0c6n8Gc7OnSylT3qedWgiNzcHamSFsdADKoLnAuGzWVYMM/kIB6TgV/q+YH7Hk8gvTk6wsVNV1Z/tiJ9T2soloqTQwgVR/oXLgdHnnLy78W2i8D4JwF/G7lzH9tJfSSmvuCYE5/W04r7Xd+vgmZjJ0eUckvxAI5hQOcWd7CEOX4SYzTk2PcYUqf7/DYt2+HSUg4DgiSZLCmgiz9znJ7i2KU2ARU2cS2u9cKG+j8OQz0LiHtRvjmI+1S0rvcSYGhdcquREcyJ8v9Rj/Tu6FHg1P2c3DFtoznI6W0ECbvnOyIs+C29fiolDlsMeF6Rd/v+iRaQwHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=09khABKCMT18uipFBp0zyaByToJTP+FGbDHJGnrZHbg=;
 b=lLNXP580Vnswevu1HcozSvBAFurMrb6WkZPHRqIcjKAYP0aycGwQ/n3SHj5gTIsFtxf0/tPBJyZu+Ym4hpa9/ZH+CIDTSvdIXRBSA1QXA5PL4sMgd143/WAfSmdxKd89Hj5+mYtiTqj9rTLDB9oQ0Zm8+30mhn1xHedSmN6gqKiQWrQMLTNyJW4C32J1RAXlpbUOLeCGS0RoyDolVfIuaYxqn6Kn2geIffonj5L+m6rMNA1nJVtrxqQ8ZmAuJHyIAg1+slO2zNbMFHHsLmHQnU32SAHJWCt1jRcE2wS4AhTMqU8EeD0mYFwh4sQAM9MB84WE72i08u0YdsX8NeT0uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BYAPR11MB2789.namprd11.prod.outlook.com (2603:10b6:a02:cc::11)
 by DM5PR11MB1308.namprd11.prod.outlook.com (2603:10b6:3:e::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4888.11; Thu, 20 Jan 2022 07:27:09 +0000
Received: from BYAPR11MB2789.namprd11.prod.outlook.com
 ([fe80::5cb5:e426:2e48:17ed]) by BYAPR11MB2789.namprd11.prod.outlook.com
 ([fe80::5cb5:e426:2e48:17ed%5]) with mapi id 15.20.4909.010; Thu, 20 Jan 2022
 07:27:09 +0000
From: Robert Yang <liezhi.yang@windriver.com>
To: bitbake-devel@lists.openembedded.org
Cc: quaresma.jose@gmail.com
Subject: [PATCH 1/1] bitbake-worker: Check BB_TASK_NETWORK before disable
 network for task
Date: Wed, 19 Jan 2022 23:27:02 -0800
Message-Id: 
 <75af98ed9992aad08e6fadc64d1985a165529828.1642663574.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1642663574.git.liezhi.yang@windriver.com>
References: <cover.1642663574.git.liezhi.yang@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0147.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::32) To BYAPR11MB2789.namprd11.prod.outlook.com
 (2603:10b6:a02:cc::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 571401f9-9085-4a7d-c4bc-08d9dbe6447f
X-MS-TrafficTypeDiagnostic: DM5PR11MB1308:EE_
X-Microsoft-Antispam-PRVS: 
	<DM5PR11MB130881720FB1F01F3CBA338EFF5A9@DM5PR11MB1308.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:317;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	1O1h1mq5G6oZCbrztofTjTCDmtoe3n553Mq+pwqbRNod1w7No/xAKh9cLtsnNJ1Lqo4+DQ7BkVZwRtsCQ/H1ZpqfW+ehCGmoYNy4nJkVK27NHEqLqXHan8a5T34bzVRoBa5FP8CuIbv+r+dfF7SkSzOT+4EfVD5W36dYVLE/BpH2hJ4zYROELh5wcAXyDhaVFbofrj2Qd39Dt3+s55ZUbbPaPt3DGEprsvOXXnlD1HDmzeeIPJM9RhC17k15avjHUyw//G+e06X8DxZabjQQ73nQiAZTfBkhWNonfnspEyfCfeqOUkXTJwcaBTOcejCK5DD/2g5yepfQEP9DN4/k3AN2uR2kQjG5GUvMWlpDDbQq4k2qvcP76GNf4HF/iXMSIbet73GkpI8b8m6ixhkPE8ZhCr5CgdD+LVzs5phYKUfiOnLWWvDVnwDN4485uSm2q+9wbjd6mEofhKfJtb5mEvd/jm6FQK+0ue1vpipBqinM4k9NhdyypRRJnc9N5lRJzKsevZ1/P860lAmzlVgNsT3hATbdzurD9SDCL749AmqMs+T+/3BZ5DWNfd4zv9H4od2fLQelaBPnwqX0F7dlJebkXczwDOQy3deF8uouPHB9PJPYlw5ZkNnAQp0UiTl87CCzftwcfNiQJkyqGwA/PKKjXMQ373ZzLWGrt3y4CXCbw/WUilFhXC2zfHoMoHU2uKMxpcyLeXHZTryZO+sA7Q==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2789.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(4744005)(316002)(2906002)(66946007)(508600001)(4326008)(86362001)(66476007)(6486002)(83380400001)(6916009)(6512007)(52116002)(66556008)(6506007)(26005)(8676002)(8936002)(6666004)(2616005)(36756003)(186003)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?5ENHTXBABCgseqDHHAeJ6CkRUHP4u0DEQFW+zDMxBGYFHt0lmuDQA8C3mf+R?=
 =?us-ascii?Q?Ml5yEOEcDLQD6hmYb3SZkpuHQv+/y0Za3SEHYkWx5SJEkdvo3Kkg2dEabpNl?=
 =?us-ascii?Q?5DlXXaQDoaU2V0nbpubx9Mnlh/iQLjqJnj20igXgEKw4QRmFEB1EKNEg+M+z?=
 =?us-ascii?Q?jHtf/9Qk/tch+ThvA74Age1tlew4Pj3nJaXSlYoKiPLnty38VxUbsri/8LSP?=
 =?us-ascii?Q?eqd4OOa0zPrU2c/ZRI3CULCkYAmrpz880dRTQ3lB2/HY0I4QGS9v6pmFVsbm?=
 =?us-ascii?Q?wFH+KlJl5oNDbxWWZnZKxcKqriilWLymLK+wFsSfpADQor24a11RIm/2Ca2T?=
 =?us-ascii?Q?WPGF6X4Bn7BgvEvDNm9A/5XPR+rqUsipZiVCO1wF0oHZpNAbVIM4tmARYqpR?=
 =?us-ascii?Q?k05SGEduejJ18dwBqG+pPve/qqEl7EWIlzs7SZfw6SqIIRoMzG1U6ADCsD+C?=
 =?us-ascii?Q?7bzOVC8U9mlnAkA+z/moZTwiZCW9qghIL8PCMA+vsvhAUa9zYH0mRGzmPzY6?=
 =?us-ascii?Q?MQTHeaqwR1mGuk9wOyUIugHOC6/R8Df3o8Pkghu49mNPscODHXZrc/UrWevU?=
 =?us-ascii?Q?vM/Z+8iS8LOQu2Zs3eeM4QHrgo8LMvLBG0jhkoJ8Z2pGBxfKrwtIOb8OYHlu?=
 =?us-ascii?Q?Mct0XtBG5979+FUQQF8VSoW8+43wm3bMHnAxTEXfjAIFpJlnb0ayrbTWbNKB?=
 =?us-ascii?Q?RTW3//kr7ziM18wJINbYechCJ51piBk9vBQmZ1b/VqoRCxTl7ZnddCI+mKJs?=
 =?us-ascii?Q?cK5ylzreZQB7ykH3uj5lIWyhJ3zJsGBy+XOOLlLgoYnjJf+y0FtIB1DWsc0V?=
 =?us-ascii?Q?67pqb+P2dJcp1xgnmQN9ZJAS0SvRAe+tj5E0T6LGHIITZsnxjz0F5eYxrSur?=
 =?us-ascii?Q?ebleBrYXOZB65ZJdplb0bXljfes6ZOV5pddUbkdsLdn8Rv5IO1lzfQftJGM8?=
 =?us-ascii?Q?wF+xiUHUT01G0SeeXFu+nlSllPGhEdoMmFbWMVa1brKKD5qgRJ0qnKEwMmAa?=
 =?us-ascii?Q?IESWCw1oWVRLXuehjsm3nJiA1CU8xfJFGUULRfbDD7M34zc9F9HVhCcjd9UN?=
 =?us-ascii?Q?ewxC5Zl1b+CgnGZ7YNqwAJo0XF3y4XqZVlnAcSbTzQCZhN+uFRpN6xpR4Q4i?=
 =?us-ascii?Q?OWTso2KePJXu3EFVuttXDafUdZWVD8xQYk0gJS/MWHQxrYc2LKFwVIlhTxkM?=
 =?us-ascii?Q?Gn3RA5E9WHHRl2RjV4SuuLqNQWXCincet5BbCe3mqpV2KNDlr93Koab27l/J?=
 =?us-ascii?Q?woVAADPH+YdubL6+OSZadraVgZPZ0vbBl7xXWT7OMXrYhxN2yea3HtNYM4WY?=
 =?us-ascii?Q?M+jmE6HhHQi0midexAiT0WwF8Ld+Sh2dTQ1pUNp17mjEqpZZoi99UmnUsrD7?=
 =?us-ascii?Q?wGLd+JrSUgh4xD+EH8KUAer+nN/L2qUzVpEiBZ8d02eg7T7D2ZGUZfbrpkt9?=
 =?us-ascii?Q?mIRoupv7Co4vX1K688X3YGv4K7laB4kvK21aOx4vwO8RpErs/w/E0GueK8sD?=
 =?us-ascii?Q?ojE657/XV+aN+oPGML2OT0wjqbEuI3bITkrai3ahXki0loZIqCgH5zuwaZxl?=
 =?us-ascii?Q?Zqw2VFDK8FSyukfgXY0lpWeOcFgCZKzcMfI4uPLcG8x9JtjRjkfojJXRxnUI?=
 =?us-ascii?Q?WK7H4VXT59kzMIraS+XtWSC3xALJkmF6EfJa5dlN1a0x1dA+aeApUW1E0XdO?=
 =?us-ascii?Q?dLgIjh2WH5a7hpynQzcZWO34Qdk=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 571401f9-9085-4a7d-c4bc-08d9dbe6447f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2789.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2022 07:27:08.8914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 LPIuoES7y3srcn2YJiPPs5FLrG/cBvl4mzVSlztaeiKt5sJ3vaKW29tR+Pxpq4hhr4RxA1OF1wxSK7Gatp1uB9biXVanHFh6kDON5yCtoCY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1308
X-Proofpoint-ORIG-GUID: gimCYt9kxUuIobv2hmPI998kjctpYxUh
X-Proofpoint-GUID: Mzmz1k_Me8CbkCR9TdQ-_p8P65dV3OAa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-20_02,2022-01-19_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=908 spamscore=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 bulkscore=0 adultscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201200037
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 20 Jan 2022 07:27:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13252

The NIS user can't work when task's network is disabled, so check
BB_TASK_NETWORK before disable it, the conf files can set BB_TASK_NETWORK.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/bin/bitbake-worker | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/bitbake/bin/bitbake-worker b/bitbake/bin/bitbake-worker
index 3aaf3c2444b..3d7a781d35c 100755
--- a/bitbake/bin/bitbake-worker
+++ b/bitbake/bin/bitbake-worker
@@ -261,7 +261,8 @@ def fork_off_task(cfg, data, databuilder, workerdata, fn, task, taskname, taskha
 
                 bb.utils.set_process_name("%s:%s" % (the_data.getVar("PN"), taskname.replace("do_", "")))
 
-                if not the_data.getVarFlag(taskname, 'network', False):
+                bb_task_network = bb.utils.to_boolean(the_data.getVar('BB_TASK_NETWORK'), False)
+                if not (bb_task_network or the_data.getVarFlag(taskname, 'network', False)):
                     logger.debug("Attempting to disable network")
                     bb.utils.disable_network(uid, gid)
 
-- 
2.31.1


