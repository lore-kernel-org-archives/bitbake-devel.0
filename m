Return-Path: <david.reyna@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF3EC83F12
	for <webhook@archiver.kernel.org>; Mon, 28 Aug 2023 09:22:18 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web10.9693.1693214534653250083
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 28 Aug 2023 02:22:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=OY8znYjw;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=7604d1df4d=david.reyna@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37S7Y4Ep005020
	for <bitbake-devel@lists.openembedded.org>; Mon, 28 Aug 2023 09:22:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PPS06212021; bh=pjDFI
	TKXkipWpaXPTLjCrdDH0QaxgDiLEWRZmfzyyCU=; b=OY8znYjwjZBsGcz/rXVp/
	fmo0zGvmhJXk6b+XRPcBLHICwnUdGvn+Q2Wz0/HG5whWY4vS1U2oQa4Ez0VhUCZv
	rGG2qrm+f7Zei905idRzocgLo0oZ0IckOmjeCfG8j99bRACbLVIoaFx6IK5iEEa0
	89msbbUlquU/+7EAKvQb2LqPa1LBLl6Pe5vC2G7/SdlLRSAuafmkwfHmTyRuBj6N
	tG2NhGfp5TKwfXkPKsHSd5Mc4KO0N4vEvQSfxqdhavZcD85/Jb5X3kXYF/GLhfYz
	7Bc0XSwdAy1PAhW21yfSd8JMFQ4A46jJJk28CDjTtuidBFlxo84WP19F2gLZdtys
	w==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3sq8c61gkc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Mon, 28 Aug 2023 09:22:13 +0000 (GMT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 28 Aug 2023 02:22:12 -0700
Received: from dreyna-honig-T5600.corp.ad.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.27 via Frontend Transport; Mon, 28 Aug 2023 02:22:12 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Kieran McNulty <Kieran.McNulty@windriver.com>,
        David Reyna
	<David.Reyna@windriver.com>
Subject: [PATCH 0/3] toaster_cummulative_08282023
Date: Mon, 28 Aug 2023 01:45:17 -0700
Message-ID: <cover.1693212183.git.david.reyna@windriver.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: JtWFCBJIHPEhg1pPQWOPj17Q3apgkLnr
X-Proofpoint-GUID: JtWFCBJIHPEhg1pPQWOPj17Q3apgkLnr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-28_06,2023-08-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 phishscore=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 suspectscore=0 clxscore=1011
 mlxlogscore=769 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2308280085
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 28 Aug 2023 09:22:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14985

toaster_cummulative_08282023

The following changes since commit c8e9590a376c0b63e38167dc522fac4cfbecb5d4:

  bitbake: Fix disk space monitoring on cephfs (2023-08-25 07:55:34 +0100)

are available in the Git repository at:

  ssh://git@push.yoctoproject.org/poky-contrib dreyna/submit/dreyna/toaster/toaster_cummulative_08282023

David Reyna (3):
  toaster: Update to Django 4.2
  toaster: import only used layers
  toaster: accommodate missing 'Image Name' value in buildinfohelper

 lib/bb/ui/buildinfohelper.py                  | 13 ++++++++-
 lib/toaster/bldcollector/urls.py              |  2 +-
 lib/toaster/bldcontrol/models.py              |  4 +--
 lib/toaster/orm/models.py                     | 28 +++++++++----------
 lib/toaster/toastergui/urls.py                |  2 +-
 lib/toaster/toastergui/views.py               |  6 ++--
 lib/toaster/toastergui/widgets.py             |  5 ++--
 .../management/commands/buildimport.py        |  2 +-
 .../management/commands/checksocket.py        |  4 +--
 lib/toaster/toastermain/urls.py               |  2 +-
 toaster-requirements.txt                      |  2 +-
 11 files changed, 41 insertions(+), 29 deletions(-)

-- 
2.20.1


