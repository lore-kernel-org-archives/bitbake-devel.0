Return-Path: <anuj.mittal@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA5CC433EF
	for <webhook@archiver.kernel.org>; Tue, 16 Nov 2021 03:32:45 +0000 (UTC)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by mx.groups.io with SMTP id smtpd.web11.5152.1637033564729327389
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 15 Nov 2021 19:32:44 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: intel.com, ip: 192.55.52.88, mailfrom: anuj.mittal@intel.com)
X-IronPort-AV: E=McAfee;i="6200,9189,10169"; a="257369165"
X-IronPort-AV: E=Sophos;i="5.87,237,1631602800";
   d="scan'208";a="257369165"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Nov 2021 19:32:43 -0800
X-IronPort-AV: E=Sophos;i="5.87,237,1631602800";
   d="scan'208";a="506232224"
Received: from jli90-mobl.gar.corp.intel.com (HELO anmitta2-mobl3.intel.com)
 ([10.214.145.204])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Nov 2021 19:32:41 -0800
From: Anuj Mittal <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.50][PATCH 0/8] Review request
Date: Tue, 16 Nov 2021 11:32:29 +0800
Message-Id: <cover.1637033341.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 16 Nov 2021 03:32:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13048

Please review these changes for 1.50. Tested with oe-core and no issues
seen on autobuilder.

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


