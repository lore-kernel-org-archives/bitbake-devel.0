Return-Path: <liezhi.yang@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C9AC41513
	for <webhook@archiver.kernel.org>; Thu, 20 Jun 2024 12:44:50 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web10.46727.1718887486617254333
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 20 Jun 2024 05:44:46 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=69015a4fb2=liezhi.yang@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45K6KETB014889;
	Thu, 20 Jun 2024 12:44:43 GMT
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3yujb71n6p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 20 Jun 2024 12:44:43 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 20 Jun 2024 05:44:42 -0700
Received: from ala-lpggp7.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.39 via Frontend Transport; Thu, 20 Jun 2024 05:44:42 -0700
From: <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
CC: <andre.draszik@linaro.org>, <kergoth@gmail.com>
Subject: [PATCH 0/2] fetch2/git: Use git shallow fetch to implement clone_shallow_local()
Date: Thu, 20 Jun 2024 05:44:39 -0700
Message-ID: <cover.1718886475.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: _OpJ88xsHL2z1o8nJq4ElZ2JfKLKx3mA
X-Proofpoint-ORIG-GUID: _OpJ88xsHL2z1o8nJq4ElZ2JfKLKx3mA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_07,2024-06-20_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=682 clxscore=1011
 spamscore=0 priorityscore=1501 malwarescore=0 mlxscore=0 suspectscore=0
 impostorscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.21.0-2405170001
 definitions=main-2406200091
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 20 Jun 2024 12:44:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16368

From: Robert Yang <liezhi.yang@windriver.com>

* Test info
  bitbake-selftest works well
  bitbake world works well with the shallow tarballs

// Robert

The following changes since commit 5d88faa0f35f0205c1475893d8589d1e6533dcc0:

  bitbake: siggen: catch FileNotFoundError everywhere and ConnectionError also in get_unihashes (2024-06-18 08:45:22 +0100)

are available in the Git repository at:

  https://github.com/robertlinux/yocto rbt/shallow
  https://github.com/robertlinux/yocto/tree/rbt/shallow

Robert Yang (2):
  fetch2/git: Use git shallow fetch to implement clone_shallow_local()
  bitbake: tests/fetch: Update GitShallowTest for clone_shallow_local()

 bitbake/lib/bb/fetch2/git.py  | 71 ++++++++++++++++++++++-------------
 bitbake/lib/bb/tests/fetch.py | 13 ++++---
 2 files changed, 53 insertions(+), 31 deletions(-)

-- 
2.45.1


