Return-Path: <anuj.mittal@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A610C433F5
	for <webhook@archiver.kernel.org>; Tue,  9 Nov 2021 14:50:36 +0000 (UTC)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by mx.groups.io with SMTP id smtpd.web12.13084.1636469435357316700
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 09 Nov 2021 06:50:35 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: intel.com, ip: 134.134.136.31, mailfrom: anuj.mittal@intel.com)
X-IronPort-AV: E=McAfee;i="6200,9189,10162"; a="293287526"
X-IronPort-AV: E=Sophos;i="5.87,220,1631602800";
   d="scan'208";a="293287526"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2021 06:50:34 -0800
X-IronPort-AV: E=Sophos;i="5.87,220,1631602800";
   d="scan'208";a="588760028"
Received: from chinboon-mobl1.gar.corp.intel.com (HELO
 anmitta2-mobl1.gar.corp.intel.com) ([10.215.234.207])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2021 06:50:33 -0800
From: Anuj Mittal <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.52][PATCH 0/7] Review request
Date: Tue,  9 Nov 2021 22:50:21 +0800
Message-Id: <cover.1636469164.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 09 Nov 2021 14:50:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12973

Please review these changes for 1.52/honister. No issues seen while
testing on autobuilder.

Thanks,

Anuj

The following changes since commit 1ac73638c1504cf2aa7f13257396aad617f25e8f:

  Revert "parse/ast: Show errors for append/prepend/remove operators combined with +=/.=" (2021-11-05 09:16:41 +0000)

are available in the Git repository at:

  git://push.openembedded.org/bitbake-contrib stable/1.52-next

Jose Quaresma (1):
  cooker: check if upstream hash equivalence server is available

Richard Purdie (6):
  tests/fetch: Update github urls
  fetch: Handle mirror user/password replacements correctly
  tests/fetch: Update pcre.org address after github changes
  cooker: Handle parse threads disappearing to avoid hangs
  runqueue: Fix runall option task deletion ordering issue
  runqueue: Fix runall option handling

 lib/bb/cooker.py          | 23 +++++++++++++++++++++--
 lib/bb/fetch2/__init__.py |  4 ++++
 lib/bb/runqueue.py        | 34 ++++++++++++++++------------------
 lib/bb/tests/fetch.py     | 32 ++++++++++++++++++--------------
 4 files changed, 59 insertions(+), 34 deletions(-)

-- 
2.31.1


