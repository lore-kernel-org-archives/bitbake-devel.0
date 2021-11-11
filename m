Return-Path: <liezhi.yang@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C61C433F5
	for <webhook@archiver.kernel.org>; Thu, 11 Nov 2021 07:45:00 +0000 (UTC)
Received: from mail5.wrs.com (mail5.wrs.com [192.103.53.11])
 by mx.groups.io with SMTP id smtpd.web09.7696.1636616700034411795
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 Nov 2021 23:45:00 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: windriver.com, ip: 192.103.53.11, mailfrom: liezhi.yang@windriver.com)
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.corp.ad.wrs.com
 [147.11.82.252])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id 1AB7is6D007187
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>; Wed, 10 Nov 2021 23:44:54 -0800
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 10 Nov 2021 23:44:53 -0800
Received: from ala-lpggp3.wrs.com (147.11.105.124) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2242.12 via Frontend Transport; Wed, 10 Nov 2021 23:44:53 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH 0/1] lib/pyinotify.py: Remove deprecated module asyncore
Date: Wed, 10 Nov 2021 23:44:52 -0800
Message-ID: <cover.1636616603.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 11 Nov 2021 07:45:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12998

The following changes since commit f7485646534e1fbf47a24ea950f6dc2d84a473c1:

  kernel: provide virtual/kernel for all kernels (2021-11-10 19:27:29 +0000)

are available in the Git repository at:

  git://git.yoctoproject.org/poky-contrib rbt/pyinotify
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=rbt/pyinotify

Robert Yang (1):
  lib/pyinotify.py: Remove deprecated module asyncore

 bitbake/lib/pyinotify.py | 30 ------------------------------
 1 file changed, 30 deletions(-)

-- 
2.31.1


