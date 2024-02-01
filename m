Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB3A6C47258
	for <webhook@archiver.kernel.org>; Thu,  1 Feb 2024 03:31:18 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.7745.1706758277155275150
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 31 Jan 2024 19:31:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=jaldy2sH;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=276184b32d=qi.chen@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41125UGO025555
	for <bitbake-devel@lists.openembedded.org>; Wed, 31 Jan 2024 19:31:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=PPS06212021; bh=tthfk7lUuSy/In55rl
	uhxDNDi+Xkn6RtuH+gc04oxAc=; b=jaldy2sHwQhSA813PEIubw3BSEpbzZ69SL
	d8Y2c9jWZexd2u0Jgz71FJ8aNXfRossLMQLVA+vAAFMtIAPaTo0WKdXcXCZggJEi
	ezXOo6dES8MbsDVnBeiIab/xZeT/uQ25ESbhGsxPZkeMwjFEqd0pP67TZGSGOqVy
	mgg7+d8DxsYZ3olkkNDBXY0um/vBrlpMLS8XlybtnIMyMTpTPHwMdN20oqnCuVAj
	T8LAN+Rh0NDZJZzKs+wDG1NnzeFheBKxRr4697ZryQUHs1b/RUzLgUZ38CrooNK5
	wzRkhgkCHR6LFvRHtrBRgJOKpB7Bf/4grYjoIaOkhTUs4Hx++4aQ==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3w0276g1q4-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Wed, 31 Jan 2024 19:31:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VsKiCYikddBnmLd4SKONhKg5QG+ZX0+rHLUskYEqFRoeJPm2klUrUhtM6PoIkbuj3+b4eJR3vskqXZMFjalIh+w9iHtB16ibNMiGfdSZTwUpCPw7I+lHJ4rP9bGcT9z6S9wzd9rZj/zptqKMVi5AjqJQvyRSdldOvqEcqK2wMkBOlmbqdkbRewYFEjXQ9dqgD7bdPh1QBesbr4qGTyMMrR31se+6kF9waRNpGtFt94d2L60TcvGYZqBS2sB8wwoLmyNjBd+/sfjA6U+nvqttJnXPsnh9cnqzi9rYwn8jSLNRkj7d4hypB28cRlaHwctBrdENTT2D6PJwv2AzfGoY+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tthfk7lUuSy/In55rluhxDNDi+Xkn6RtuH+gc04oxAc=;
 b=BoGXxsWrLwMc4HRZZc6/k45f2bzXnXM5/64izbKbK8KdC1Dt34f+xVEOHs8joCAvXz9QeXjsRsTvzMzht8HMuxSV3Hi+0yRpwOYU2HHJGgMnRd6GmyV6Xj6rO1Ns6Suq+U/rjinHb+Jjh97asXN6wH+HDADyNe6mmytMu8siDFIVeVmAoFiOt8v++ckUoDRNLWGjaNuRX08LoiIQ+cjAyA0qzG+zhPN3uurhoCgWS4RvqFDJpaaUTJLR3Z+eNfdz7H5dxulQ+48UE95E5YhXkhTZDy51pXnDP3qJuRz/674G9z1A+LjplYFiaL1Vwb1ptl8AgQdtTu7d5Q5a68TC4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by PH7PR11MB8598.namprd11.prod.outlook.com (2603:10b6:510:2fd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22; Thu, 1 Feb
 2024 03:31:13 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5d84:2b01:5029:9315]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5d84:2b01:5029:9315%7]) with mapi id 15.20.7249.025; Thu, 1 Feb 2024
 03:31:13 +0000
From: Qi.Chen@windriver.com
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake-devel][PATCH 1/3] fetch2/git.py: fix a corner case in try_premirror
Date: Wed, 31 Jan 2024 19:30:58 -0800
Message-ID: <20240201033100.3617421-1-Qi.Chen@windriver.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0P220CA0013.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::20) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|PH7PR11MB8598:EE_
X-MS-Office365-Filtering-Correlation-Id: 45575933-3e7e-4ec9-b583-08dc22d63da6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	CvdwHDgoKrVD0YLNUaZzHZiHzZUsbEdVCRodKxQc4/uylp/UPGb5EckyKoPu4h6orKbeyqxVMF6kGTgtR+q1w5NGNZEKGipcRg6HrRdFuN0/++PNDH5/nj62LzXhAvFxICWYQ3+UZxOspNLlGymUUuRx+FSodCsfYS8bFuu9z/m0R28xKBZGm1+bMWUIGkgzIdHQvRmhZ1DDtrOWnHKq7QERsDN/GVe54sf1jsZq+TNhvnXgb2w8jLFC6sgAb+i2Pv0hi5PD1cl3eAr3gmonUSrxrfeJp7KeidvQBJ+mJn1M4jP0k8+T+MmsCW4vYX1xpnpqHLwvJYyGR7/JgbdIhAsO8i94TXe65aSsewa8YUnoY1/TG1aa12QJ8iXtCKz06fkAWo99LRR/Q/MuaRG6y85aFer0r/I7IPnIdY0iOZbr6dlkdMR4MddyZ1Nbrr4UHBJ3qJIgOazwNXn6jIS7GDWxmus+iz9WFqx1LYJwJG5HthVpu9LcXzBcaEpvCEMk2BY/pjq8Ar+wo5UFSusXNSkLd3U8/Oh9Uk0EHuD2HW5u0IUqD7RUPKxAn1VAwwzVYLfGYATelHrej+l9Fg3iXpAhy6JlHHA+9pTkBmpwWKOozDYCrLeZdPFwtWWDVyvg
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39850400004)(396003)(136003)(366004)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(38350700005)(26005)(6486002)(66946007)(478600001)(5660300002)(2906002)(83380400001)(9686003)(6666004)(66476007)(6506007)(8676002)(52116002)(6916009)(8936002)(316002)(2616005)(6512007)(1076003)(66556008)(38100700002)(86362001)(36756003)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?RrvUZ8Nh7lcixs4jntXlPxMyz2n1qYv4HfkbjyS9JhAEmxn5IJXhpURCbSEC?=
 =?us-ascii?Q?h/Uj1AFf1j8Ko9SkbApq7/T9DL6RrSFFd3YujhV5MGgnG9Rk39qeTSjt5nT8?=
 =?us-ascii?Q?2rYELAprUoJi7oH9WvwzDF+soWk41FRFtPlt5iVsqT86j6Kb0ClIBw6jQdC4?=
 =?us-ascii?Q?o2hzKqt6hNbI1aNDx92/DnHroXhbWr46CBneegurheLESfAXgl2SvBI5UUz+?=
 =?us-ascii?Q?N5vffpWSa9e1aOemoeZuioDsAPVc8EVSc+oQ/d8tWdTNz913sKZc4qzAK5Ga?=
 =?us-ascii?Q?+/T751IUnV6oKQCe+F6VMjbf94QRgR0vus5lgPsbZGdyOHxFo5uY1BmkykhW?=
 =?us-ascii?Q?GM3ekDl9plRP9FSgIde9fYqUq1z7BN5o3eNT+cvT6WgiYHxsJ+g5HIWxD53c?=
 =?us-ascii?Q?XVZYzO2rl8p/KV0fAWNyAu2cas0qtrWjyxVeqqW0sGYWWHltPFe1U6qSnN2+?=
 =?us-ascii?Q?0voN7b/Sf+LXFLvuG2AzjDe8BFjFY9i0DCHJD49UM76ktsu08khFYOE7aMQH?=
 =?us-ascii?Q?p233Y/O+LUIvVN2eyRQw3jn26DmBuxzxBvSddmdCrXBZ+RTikKIB0XT6+AVY?=
 =?us-ascii?Q?0AuYcaIR7GcOAWzOTJBtk55Uta2TObwk/oLT8DmrZGKGyxqjWcgQAqNvBIXA?=
 =?us-ascii?Q?RKVhfY2KTjHMb+CmBZCRKF7fb9QGBaks+qUR8DcGjhblfA3eKpu7ReiPD/Tq?=
 =?us-ascii?Q?6eCinwH39mngGvsXlGydPLI/M+CsnpP8VBL/jUBXPstxIl34q1yvbiALQ7DI?=
 =?us-ascii?Q?ayjpJVuYrWDLstcFDq8jZdQ2pURegoj3EwwfcvevO7wy/jJ74JkPs06XkMxK?=
 =?us-ascii?Q?HK9dAMzLJ1aRtSVMrqHEKvVMLMNN+uSOkRwYEr9CcqiCMdWfHZV0XBY9pgpo?=
 =?us-ascii?Q?U1b9y7HsNBuctT7tShx9zIuTsPZ1ZCgsRKTyGMx7wMckouqEMtmY23p3/t0U?=
 =?us-ascii?Q?hBsd2HpSFIbJ+JvY0L6C+PvEfD5ulI8pYKfLQWnOarSeibOZMShyhmb47S4t?=
 =?us-ascii?Q?OFncuFg92Jr9o7Vfr7yI72CtB1xm6AeY9Jgiz3p7abNb+ApV4+/HpGSGaony?=
 =?us-ascii?Q?ks0K+MNfiGQcgsV9VCcp4ovcZhDAH0v2743gHbreAMou83Nk/EPheH3BfJbh?=
 =?us-ascii?Q?35dXCWr2BqslGIwuW3M83B9Eo8OyO8dn10HOmue57NvNPH0QJtURY8GReArr?=
 =?us-ascii?Q?C1efiNsoH5riF/wfYU2tAy1oTVIiMC//LuHscX16gRn1QhJldxqPIOMLEda6?=
 =?us-ascii?Q?ANEjwTTsqfegBm/B9YdUe+O4gyfNvueThRTWrJdAw0Fab7rnBjHzhNIw+A4Q?=
 =?us-ascii?Q?DB8eTppMP0WxDYIw62rkqIG+e61nZs+p6lfuifRW5mHMh//FLGT8bgMZhCsI?=
 =?us-ascii?Q?QunK3nl5GA/sryB87YI1N/3F/HRD54yKpZCLnb7XMEHhSG7UBbtF0I22oqeS?=
 =?us-ascii?Q?0dt1dR6U+RCjJfGPY+smRZyfudZnsmNAj9mNzLSv2YPqa7gYhUuGcnhwcoho?=
 =?us-ascii?Q?bEDAdAVval/aC3fFwxMVmIvSaFGStd7+87d1PobY7bZvxHXxeBpJoAGEDtgH?=
 =?us-ascii?Q?TZCzxcpt+vriuwCWOSVYxCtde+7N1pqQhuuRErQJ?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45575933-3e7e-4ec9-b583-08dc22d63da6
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 03:31:13.3395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 93yxo0SZm5TzFDeWeAWfAUKSNr9UKoPUE5gKHjPJ6ywp1bPv6Twir8fk1DRJTfcrGInpm7q8c7hgVh5kdl4OkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8598
X-Proofpoint-GUID: TheyGmzc5P0EV41boyBhH1mgdZixHnoE
X-Proofpoint-ORIG-GUID: TheyGmzc5P0EV41boyBhH1mgdZixHnoE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 lowpriorityscore=0 bulkscore=0 malwarescore=0 spamscore=0
 phishscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2401190000
 definitions=main-2402010026
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 01 Feb 2024 03:31:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15817

From: Chen Qi <Qi.Chen@windriver.com>

For gitsm recipes, it's possible that some URL is used more than once.
e.g.,
A -> B:rev1 (B is a submodule of A)
A -> C (C is a submodule of A)
C -> B:rev2 (B is a submodule of C)
A anc C are both using B as submodules, but on different revs.
Now if we have:
B:rev1 -> D
B:rev2 -> E
Then, the mirror will not be fully used.
Say we have all repo mirrors for A, B, C, D, E, then in theory it's not
necessary to reach out to any network for downloading. But it's not the
case. After downloading B(rev1) and its submodule D from mirrors, the fetch
process continues to download C, thus B(rev2) and E. Now it finds that B
needs an update because its submodule E needs an update. Of course this is
true because E is not downloaded yet. Now the problem comes to whether to
use mirror or not. The git.py defines try_premirror to return 'False' when
the ud.clonedir exists. As B has been cloned, the ud.clonedir exists and
try_mirror returns False, resulting in not using mirror and going to upstream
directly.

We can see that the mirrors are not fully used. This is usually not problem,
as the cost is only some network download. But in case the following two
settings are there, we get errors.
BB_NO_NETWORK = "0"
BB_ALLOWED_NETWORKS = "*.some.allowed.domain"
In such case, the gitsm recipe A will fail to fetch. Note that all contents
that A needs are in mirrors and now it's failing to fetch. This is unexpected.

Note that the different revs of the same repo in gitsm recipe is not the only
way to reveal this problem. For example, there might be a recipe call B that
uses B:rev3. Check the protobuf and grpc recipes as an example.

For now, we can use the following steps to reproduce this issue. To be clear,
the grpc recipe in meta-oe is now 1.60.0.
1. Add in local.conf:
   DL_DIR = "${TOPDIR}/downloads-premirror"
   bitbake grpc -c fetch
2. Comment out the DL_DIR setting in local.conf and add the following lines:
   PREMIRRORS:append = " \
     git://.*/.* git://${TOPDIR}/downloads-premirror/git2/MIRRORNAME;protocol=file \n \
     gitsm://.*/.* gitsm://${TOPDIR}/downloads-premirror/git2/MIRRORNAME;protocol=file \n \
   "
3. Set BB_NO_NETWORK = "1" and then 'bitbake grpc -c fetch'.
   This command succeeds and this shows that the premirror holds everything we need.
4. Add the following lines and then 'bitbake grpc -c fetch'.
   BB_NO_NETWORK = "0"
   BB_ALLOWED_NETWORKS = "*.some.domain"

After step 4, the error message is as below:
ERROR: grpc-1.60.0-r0 do_fetch: The URL: 'gitsm://github.com/protocolbuffers/protobuf.git;protocol=https;name=third_party/protobuf;subpath=third_party/protobuf;nobranch=1;lfs=True;bareclone=1;nobranch=1' is not trusted and cannot be used

This patch fixes this problem by handling this corner case, that is, if the URL is
not trusted from the settings of BB_NO_NETWORK and BB_ALLOWED_NETWORKS, then we should
try premirrors because trying to reach upstream is destined to fail.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 bitbake/lib/bb/fetch2/git.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index 0deeb5cee1..322a9366da 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -87,6 +87,7 @@ from contextlib import contextmanager
 from   bb.fetch2 import FetchMethod
 from   bb.fetch2 import runfetchcmd
 from   bb.fetch2 import logger
+from   bb.fetch2 import trusted_network
 
 
 sha1_re = re.compile(r'^[0-9a-f]{40}$')
@@ -355,6 +356,11 @@ class Git(FetchMethod):
         # is not possible
         if bb.utils.to_boolean(d.getVar("BB_FETCH_PREMIRRORONLY")):
             return True
+        # If the url is not in trusted network, that is, BB_NO_NETWORK is set to 0
+        # and BB_ALLOWED_NETWORKS does not contain the host that ud.url uses, then
+        # we need to try premirrors first as using upstream is destined to fail.
+        if not trusted_network(d, ud.url):
+            return True
         if os.path.exists(ud.clonedir):
             return False
         return True
-- 
2.42.0


