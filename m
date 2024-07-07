Return-Path: <liezhi.yang@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A614DC30653
	for <webhook@archiver.kernel.org>; Sun,  7 Jul 2024 07:20:49 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web10.54004.1720336841616472040
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 07 Jul 2024 00:20:41 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=7918799487=liezhi.yang@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4677BQJx015672;
	Sun, 7 Jul 2024 07:20:39 GMT
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 406u4x0t31-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Sun, 07 Jul 2024 07:20:39 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 7 Jul 2024 00:20:38 -0700
Received: from ala-lpggp7.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.39 via Frontend Transport; Sun, 7 Jul 2024 00:20:38 -0700
From: <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
CC: <andre.draszik@linaro.org>, <kergoth@gmail.com>
Subject: [PATCH v2 0/2] fetch2/git: Use git shallow fetch to implement clone_shallow_local()
Date: Sun, 7 Jul 2024 00:20:36 -0700
Message-ID: <cover.1720336551.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: g2408TIb69EM1nYKSvxofJ5wKEwH1MKW
X-Proofpoint-GUID: g2408TIb69EM1nYKSvxofJ5wKEwH1MKW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-07_04,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 malwarescore=0 bulkscore=0 clxscore=1015 spamscore=0 mlxlogscore=746
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.21.0-2406140001 definitions=main-2407070058
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 07 Jul 2024 07:20:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16394

From: Robert Yang <liezhi.yang@windriver.com>

* V2:
  - Fix bitbake-selftest on ubuntu 20.04 (git version: 2.25.1)

    # Advertise the revision for lower version git such as 2.25.1:
    # error: Server does not allow request for unadvertised object.
    # The ud.clonedir is a local temporary dir, will be removed when
    # fetch is done, so we can do anything on it.
    adv_cmd = 'git branch -f advertise-%s %s' % (revision, revision)
    runfetchcmd(adv_cmd, d, workdir=ud.clonedir) 

* V1:
  bitbake-selftest works well
  bitbake world works well with the shallow tarballs

// Robert

The following changes since commit 0979646a1bd224e3690380ab9fb3e0079bcafcf4:

  abi_version/package: Bump hashequiv version and package class version (2024-07-05 10:23:05 +0100)

are available in the Git repository at:

  https://github.com/robertlinux/yocto rbt/shallow
  https://github.com/robertlinux/yocto/tree/rbt/shallow

Robert Yang (2):
  fetch2/git: Use git shallow fetch to implement clone_shallow_local()
  bitbake: tests/fetch: Update GitShallowTest for clone_shallow_local()

 bitbake/lib/bb/fetch2/git.py  | 78 +++++++++++++++++++++++------------
 bitbake/lib/bb/tests/fetch.py | 13 +++---
 2 files changed, 60 insertions(+), 31 deletions(-)

-- 
2.25.1


