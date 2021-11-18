Return-Path: <anuj.mittal@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E5AC433EF
	for <webhook@archiver.kernel.org>; Thu, 18 Nov 2021 23:53:10 +0000 (UTC)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by mx.groups.io with SMTP id smtpd.web11.1378.1637279585786118011
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 18 Nov 2021 15:53:06 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: intel.com, ip: 134.134.136.126, mailfrom: anuj.mittal@intel.com)
X-IronPort-AV: E=McAfee;i="6200,9189,10172"; a="221197006"
X-IronPort-AV: E=Sophos;i="5.87,246,1631602800";
   d="scan'208";a="221197006"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2021 15:53:05 -0800
X-IronPort-AV: E=Sophos;i="5.87,246,1631602800";
   d="scan'208";a="536913471"
Received: from tchong5-mobl.gar.corp.intel.com (HELO anmitta2-mobl3.intel.com)
 ([10.215.238.53])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2021 15:53:04 -0800
From: Anuj Mittal <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.50][PATCH 0/8] Pull request (cover letter only)
Date: Fri, 19 Nov 2021 07:53:00 +0800
Message-Id: <cover.1637279538.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 18 Nov 2021 23:53:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13075

Please merge these changes.

Thanks,

Anuj

The following changes since commit bf59c0080763e8d03f75fe130ae9708e572391f3:

  fetch/wget: Add timeout for checkstatus calls (30s) (2021-11-11 10:59:06 +0000)

are available in the Git repository at:

  git://push.openembedded.org/bitbake-contrib stable/1.50-next

Jon Mason (1):
  bitbake:toaster:test: Update SSTATE URL

Jose Quaresma (1):
  cooker: check if upstream hash equivalence server is available

Richard Purdie (6):
  fetch2/perforce: Fix typo
  tests/fetch: Update github urls
  fetch: Handle mirror user/password replacements correctly
  tests/fetch: Update pcre.org address after github changes
  runqueue: Fix runall option task deletion ordering issue
  runqueue: Fix runall option handling

 lib/bb/cooker.py                      | 12 +++++++++-
 lib/bb/fetch2/__init__.py             |  4 ++++
 lib/bb/fetch2/perforce.py             |  2 +-
 lib/bb/runqueue.py                    | 34 +++++++++++++--------------
 lib/bb/tests/fetch.py                 | 32 ++++++++++++++-----------
 lib/toaster/tests/builds/buildtest.py |  2 +-
 6 files changed, 51 insertions(+), 35 deletions(-)

-- 
2.33.1


