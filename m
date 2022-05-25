Return-Path: <david.reyna@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 769EFC433F5
	for <webhook@archiver.kernel.org>; Wed, 25 May 2022 06:24:54 +0000 (UTC)
Received: from mail1.wrs.com (mail1.wrs.com [147.11.3.146])
 by mx.groups.io with SMTP id smtpd.web11.3720.1653459889678472997
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 24 May 2022 23:24:49 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=permerror,
 err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid
 domain name (domain: windriver.com, ip: 147.11.3.146,
 mailfrom: david.reyna@windriver.com)
Received: from mail.windriver.com (mail.wrs.com [147.11.1.11])
	by mail1.wrs.com (8.15.2/8.15.2) with ESMTPS id 24P6OhYD021692
	(version=TLSv1.1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>; Tue, 24 May 2022 23:24:44 -0700
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.corp.ad.wrs.com
 [147.11.82.252])
	by mail.windriver.com (8.15.2/8.15.2) with ESMTPS id 24P6Ogir029182
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
 Tue, 24 May 2022 23:24:43 -0700 (PDT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 24 May 2022 23:24:42 -0700
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 24 May 2022 23:24:42 -0700
Received: from ala-lpggp2.wrs.com (147.11.105.123) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2242.12 via Frontend Transport; Tue, 24 May 2022 23:24:42 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
CC: David Reyna <David.Reyna@windriver.com>
Subject: [PATCH 0/1] bitbake: ncurses version of taskexp.py
Date: Tue, 24 May 2022 23:24:38 -0700
Message-ID: <cover.1653448549.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 25 May 2022 06:24:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13711

From: David Reyna <David.Reyna@windriver.com>


Added since demo at YP Summit:
 * Protection against window resizing
 * Line art (with ASCII line art as backup)
 * Additional internal documentation
 * Tested against misspelled recipe errors


The following changes since commit 13d70e57f8693e506aada946ae9b2e0997e4c5f0:

  migration guides: release notes for 3.4.3 and 3.4.4 (2022-05-24 13:58:47 +0100)

are available in the Git repository at:

  git://push.yoctoproject.org/poky-contrib dreyna/bitbake/ncurses_taskexp_14814

David Reyna (1):
  bitbake: ncurses version of taskexp.py

 lib/bb/ui/taskexp_cli.py | 1302 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 1302 insertions(+)
 create mode 100755 bitbake/lib/bb/ui/taskexp_cli.py

-- 
2.35.1


