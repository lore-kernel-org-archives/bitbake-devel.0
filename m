Return-Path: <david.reyna@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 214D0C4829E
	for <webhook@archiver.kernel.org>; Sun, 18 Feb 2024 10:42:02 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.15666.1708252916385720377
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 18 Feb 2024 02:41:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=hiXMLy0O;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=2778734a41=david.reyna@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41I9QKrB001080
	for <bitbake-devel@lists.openembedded.org>; Sun, 18 Feb 2024 02:41:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PPS06212021; bh=9upd4
	ccGFvor72lmfhM4u/+HUf9ArmOdES6HgiAejbI=; b=hiXMLy0OqXBUozO2D8DTo
	0SPRXdX19BOy2TxADKaqpyIxNJ8c5DhJ9dOK4oDr59Wc/Ieh5Kd9KxRIerxF0W4u
	fMNgwfaaWfmpdfarI8SE3+SSZQ/hWFAJtjCHxGhzISBQqQflc+w/8KUCT8wBehCU
	PEj02UUw/bqa8dlEWkoUiPbK0ugP9kap8Tv+ndPFV5WJklXev0nd1mmXDD6G7KqP
	HA/U1iuiSJDgjv1Dym0TqDDfSQNM5Lm76RS07kxQMM5dFsgYinZv574YNf5UuprA
	AMli/qc5Psy4tjZYq6kptIwo92crpxw+i89ws1e8fXB9ZFM9QPyJ5rKncLc6x0Mz
	A==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3waw6kgjv4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Sun, 18 Feb 2024 02:41:55 -0800 (PST)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 18 Feb 2024 02:41:54 -0800
Received: from ala-lpggp2.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Sun, 18 Feb 2024 02:41:54 -0800
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
CC: David Reyna <David.Reyna@windriver.com>
Subject: [PATCH 0/1] taskexp_ncurses: ncurses version of taskexp.py
Date: Sun, 18 Feb 2024 02:41:52 -0800
Message-ID: <cover.1708252029.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: c4RiKrJ2JaVKGm7z_eR92n8NyV8soyEP
X-Proofpoint-GUID: c4RiKrJ2JaVKGm7z_eR92n8NyV8soyEP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-18_08,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxlogscore=874 malwarescore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 mlxscore=0 bulkscore=0 spamscore=0 clxscore=1011
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402180081
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 18 Feb 2024 10:42:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15912

From: David Reyna <David.Reyna@windriver.com>

This is a re-partition of the previous submission. It adds a non-ncurses 
version of the unit test to support ptest and Autobuilder. 

This will specifically request the bitbake dependecy data and do a quick
sanity test of the results. This is the most vulnerable part of the 
integration over releases.

Normal execution example:
  $ bitbake -g -u taskexp_ncurses.py acl zlib 

GUI self-execution unit test example:
  $ TASK_EXP_UNIT_TEST=1 bitbake -g -u taskexp_ncurses quilt

Non-ncurses unit test example::
  $ TASK_EXP_UNIT_TEST_NOTERM=1 bitbake -g -u taskexp_ncurses quilt
  * UNIT TEST:START
  * UNIT TEST:BITBAKE FETCH
  Loading Cache: (0 of 0)
  Bitbake... : (1 of 2)
  Processing recipes: (0 of 914)
  ***************************************
  
  Generating dependency tree: (0 of 3)
  Generating dependency tree: (1 of 3)
  Generating dependency tree: (2 of 3)
  Generating dependency tree: (3 of 3)
  Pass:bitbake dependency count = 11456
  Pass:Quilt-native depends count = 11
  Pass:Quilt-native rdepends count = 351
  Pass:Quilt depends count = 138
  Pass:Quilt rdepends count = 41
  * UNIT TEST:STOP
  $ echo $?
  0
  $
 
 

The following changes since commit a277d1f7a0dc716b497fd855f20cbd6a7d488f8b:

  gstreamer1.0: upgrade 1.22.9 -> 1.22.10 (2024-02-17 18:19:19 +0000)

are available in the Git repository at:

  ssh://git@push.yoctoproject.org/poky-contrib dreyna/bitbake/taskexp_ncurses_14814

David Reyna (1):
  taskexp_ncurses: ncurses version of taskexp.py

 lib/bb/ui/taskexp_ncurses.py | 1511 ++++++++++++++++++++++++++++++++++
 1 file changed, 1511 insertions(+)
 create mode 100755 bitbake/lib/bb/ui/taskexp_ncurses.py

-- 
2.39.0


