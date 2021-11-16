Return-Path: <anuj.mittal@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C2AEC433F5
	for <webhook@archiver.kernel.org>; Tue, 16 Nov 2021 16:27:47 +0000 (UTC)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by mx.groups.io with SMTP id smtpd.web08.319.1637080066468883180
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 16 Nov 2021 08:27:46 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: intel.com, ip: 134.134.136.20, mailfrom: anuj.mittal@intel.com)
X-IronPort-AV: E=McAfee;i="6200,9189,10169"; a="220936565"
X-IronPort-AV: E=Sophos;i="5.87,239,1631602800";
   d="scan'208";a="220936565"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2021 08:27:06 -0800
X-IronPort-AV: E=Sophos;i="5.87,239,1631602800";
   d="scan'208";a="506500469"
Received: from mmohdso1-mobl.gar.corp.intel.com (HELO
 anmitta2-mobl3.intel.com) ([10.215.237.91])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2021 08:27:05 -0800
From: Anuj Mittal <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.52][PATCH 0/4] Review request
Date: Wed, 17 Nov 2021 00:26:56 +0800
Message-Id: <cover.1637079892.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 16 Nov 2021 16:27:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13060

Please review these changes for 1.52. No problems seen while testing on
autobuilder.

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


