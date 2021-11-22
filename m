Return-Path: <anuj.mittal@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F3BDC433EF
	for <webhook@archiver.kernel.org>; Mon, 22 Nov 2021 08:37:10 +0000 (UTC)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by mx.groups.io with SMTP id smtpd.web10.3958.1637570228047923889
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 22 Nov 2021 00:37:08 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: intel.com, ip: 134.134.136.100, mailfrom: anuj.mittal@intel.com)
X-IronPort-AV: E=McAfee;i="6200,9189,10175"; a="298159435"
X-IronPort-AV: E=Sophos;i="5.87,254,1631602800";
   d="scan'208";a="298159435"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Nov 2021 00:37:00 -0800
X-IronPort-AV: E=Sophos;i="5.87,254,1631602800";
   d="scan'208";a="552191266"
Received: from amohdwah-mobl1.gar.corp.intel.com (HELO
 anmitta2-mobl3.intel.com) ([10.215.239.176])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Nov 2021 00:36:58 -0800
From: Anuj Mittal <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.52][PATCH 0/2] Review request
Date: Mon, 22 Nov 2021 16:36:46 +0800
Message-Id: <cover.1637570097.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 22 Nov 2021 08:37:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13093

Please review these changes for 1.52. No problems seen while testing.

Thanks,

Anuj

The following changes since commit c1938abf51b57938a21948bb414ad0467e4368d9:

  cooker: Fix task-depends.dot for multiconfig targets (2021-11-16 13:13:20 +0800)

are available in the Git repository at:

  git://push.openembedded.org/bitbake-contrib stable/1.52-next

Richard Purdie (2):
  utils: Handle lockfile filenames that are too long for filesystems
  fetch2: Fix url remap issue and add testcase

 lib/bb/fetch2/__init__.py | 2 +-
 lib/bb/tests/fetch.py     | 1 +
 lib/bb/utils.py           | 6 +++++-
 3 files changed, 7 insertions(+), 2 deletions(-)

-- 
2.33.1


