Return-Path: <anuj.mittal@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B06C433EF
	for <webhook@archiver.kernel.org>; Fri,  3 Dec 2021 14:25:54 +0000 (UTC)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by mx.groups.io with SMTP id smtpd.web12.12280.1638541552915223576
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 03 Dec 2021 06:25:53 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: intel.com, ip: 134.134.136.31, mailfrom: anuj.mittal@intel.com)
X-IronPort-AV: E=McAfee;i="6200,9189,10186"; a="297779924"
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800";
   d="scan'208";a="297779924"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Dec 2021 06:25:52 -0800
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800";
   d="scan'208";a="746722969"
Received: from ffoo-mobl1.gar.corp.intel.com (HELO anmitta2-mobl3.intel.com)
 ([10.215.225.43])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Dec 2021 06:25:50 -0800
From: Anuj Mittal <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.50][PATCH 0/1] Review request
Date: Fri,  3 Dec 2021 22:25:45 +0800
Message-Id: <cover.1638541408.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 03 Dec 2021 14:25:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13125

Please review and merge these changes. No problems seen while testing on
autobuilder.

Thanks,

Anuj

The following changes since commit b7c60b97fd225ca23e648e8635a9f30e7e2591a5:

  cooker: Fix task-depends.dot for multiconfig targets (2021-11-24 10:08:02 +0000)

are available in the Git repository at:

  git://push.openembedded.org/bitbake-contrib stable/1.50-next

Richard Purdie (1):
  utils: Handle lockfile filenames that are too long for filesystems

 lib/bb/utils.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

-- 
2.33.1


