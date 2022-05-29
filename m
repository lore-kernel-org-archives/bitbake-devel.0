Return-Path: <david.reyna@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C5AC433EF
	for <webhook@archiver.kernel.org>; Sun, 29 May 2022 06:15:41 +0000 (UTC)
Received: from mail1.wrs.com (mail1.wrs.com [147.11.3.146])
 by mx.groups.io with SMTP id smtpd.web12.22868.1653804940051769406
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 28 May 2022 23:15:40 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=permerror,
 err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid
 domain name (domain: windriver.com, ip: 147.11.3.146,
 mailfrom: david.reyna@windriver.com)
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.corp.ad.wrs.com
 [147.11.82.252])
	by mail1.wrs.com (8.15.2/8.15.2) with ESMTPS id 24T6Fb3S018530
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>; Sat, 28 May 2022 23:15:38 -0700
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Sat, 28 May 2022 23:15:37 -0700
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sat, 28 May 2022 23:15:37 -0700
Received: from ala-lpggp2.wrs.com (147.11.105.123) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2242.12 via Frontend Transport; Sat, 28 May 2022 23:15:37 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
CC: David Reyna <David.Reyna@windriver.com>
Subject: [PATCH 0/1][V2] bitbake: ncurses version of taskexp.py
Date: Sat, 28 May 2022 23:15:35 -0700
Message-ID: <cover.1653802954.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 29 May 2022 06:15:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13719

From: David Reyna <David.Reyna@windriver.com>

Changes for V2: 
  1. Changed name to "taskexp_tty"
  2. Added a selt-test feature:

   $ TASK_EXP_UNIT_TEST=1 bitbake -g -u taskexp_tty zlib acl
   ...
   $ echo $?
   0
   $ TASK_EXP_UNIT_TEST=1 bitbake -g -u taskexp_tty zlib acl foo
   ERROR: Nothing PROVIDES 'foo'. Close matches:
   ofono
   $ echo $?
   1
   $

- David


The following changes since commit 13d70e57f8693e506aada946ae9b2e0997e4c5f0:

  migration guides: release notes for 3.4.3 and 3.4.4 (2022-05-24 13:58:47 +0100)

are available in the Git repository at:

  git://push.yoctoproject.org/poky-contrib dreyna/bitbake/ncurses_taskexp_14814

David Reyna (1):
  bitbake: ncurses version of taskexp.py

 lib/bb/ui/taskexp_tty.py | 1400 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 1400 insertions(+)
 create mode 100755 bitbake/lib/bb/ui/taskexp_tty.py

-- 
2.35.1


