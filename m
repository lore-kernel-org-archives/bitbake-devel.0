Return-Path: <david.reyna@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C30C433EF
	for <webhook@archiver.kernel.org>; Mon, 21 Mar 2022 05:02:25 +0000 (UTC)
Received: from mail1.wrs.com (mail1.wrs.com [147.11.3.146])
 by mx.groups.io with SMTP id smtpd.web10.26766.1647838944292747966
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 20 Mar 2022 22:02:24 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=permerror,
 err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid
 domain name (domain: windriver.com, ip: 147.11.3.146,
 mailfrom: david.reyna@windriver.com)
Received: from mail.windriver.com (mail.wrs.com [147.11.1.11])
	by mail1.wrs.com (8.15.2/8.15.2) with ESMTPS id 22L52M0A006433
	(version=TLSv1.1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>; Sun, 20 Mar 2022 22:02:23 -0700
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.corp.ad.wrs.com
 [147.11.82.252])
	by mail.windriver.com (8.15.2/8.15.2) with ESMTPS id 22L52MeG009966
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
 Sun, 20 Mar 2022 22:02:22 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Sun, 20 Mar 2022 22:02:20 -0700
Received: from ala-lpggp2.wrs.com (147.11.105.123) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2242.12 via Frontend Transport; Sun, 20 Mar 2022 22:02:20 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
CC: David Reyna <David.Reyna@windriver.com>
Subject: [PATCH 0/2] toaster:cummulative_03202022
Date: Sun, 20 Mar 2022 22:02:14 -0700
Message-ID: <cover.1647836508.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 21 Mar 2022 05:02:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13487

From: David Reyna <David.Reyna@windriver.com>

Patches:
* Bug 14085 Toaster UI should know when bitbake crashed
  Dynamically discover if bitbake crashed and left a traceback
  Informs user for example when using Hardknott or Honister without 'xmlrpcclient' patch
* Bug 14765 - toaster: race condition for end-of-build
  Solves builds visually stuck at 100%


The following changes since commit e5ab3817aa98846c0a1c6d23feb47ff9404b0b90:

  classes/setuptools_build_meta: rename to python_setuptools_build_meta (2022-03-20 00:02:22 +0000)

are available in the Git repository at:

  git://push.yoctoproject.org/poky-contrib dreyna/submit/dreyna/toaster/toaster_cummulative_03202022

David Reyna (2):
  toaster: detect when bitbake crashed
  toaster: race condition for end-of-build

 lib/bb/ui/buildinfohelper.py                  |  6 ++
 .../management/commands/runbuilds.py          | 83 ++++++++++++++++++-
 2 files changed, 87 insertions(+), 2 deletions(-)

-- 
2.17.1


