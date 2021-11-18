Return-Path: <anuj.mittal@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7308C433F5
	for <webhook@archiver.kernel.org>; Thu, 18 Nov 2021 06:51:47 +0000 (UTC)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by mx.groups.io with SMTP id smtpd.web08.2315.1637218306639184685
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 17 Nov 2021 22:51:46 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: intel.com, ip: 192.55.52.88, mailfrom: anuj.mittal@intel.com)
X-IronPort-AV: E=McAfee;i="6200,9189,10171"; a="257906284"
X-IronPort-AV: E=Sophos;i="5.87,243,1631602800";
   d="scan'208";a="257906284"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2021 22:51:45 -0800
X-IronPort-AV: E=Sophos;i="5.87,243,1631602800";
   d="scan'208";a="605044838"
Received: from mnoorazm-mobl2.gar.corp.intel.com (HELO
 anmitta2-mobl3.intel.com) ([10.213.140.242])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2021 22:51:44 -0800
From: Anuj Mittal <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.52][PATCH 0/4] Pull request
Date: Thu, 18 Nov 2021 14:51:39 +0800
Message-Id: <cover.1637218179.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 18 Nov 2021 06:51:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13066

Please merge these changes.

Thanks,

Anuj

The following changes since commit 693eec8edf8d3b2b01c53be6776213cccd797485:

  runqueue: Fix runall option handling (2021-11-12 14:16:48 +0800)

are available in the Git repository at:

  git://push.openembedded.org/bitbake-contrib stable/1.52-next

Richard Purdie (4):
  cooker: Handle parse threads disappearing to avoid hangs
  cooker: Remove debug code, oops :(
  cooker: Handle parsing results queue race
  cooker: Fix task-depends.dot for multiconfig targets

 lib/bb/cooker.py | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

-- 
2.33.1


