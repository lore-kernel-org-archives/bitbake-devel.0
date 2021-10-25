Return-Path: <anuj.mittal@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04BB7C433F5
	for <webhook@archiver.kernel.org>; Mon, 25 Oct 2021 14:16:04 +0000 (UTC)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by mx.groups.io with SMTP id smtpd.web10.32590.1635171363549075253
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 25 Oct 2021 07:16:03 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: intel.com, ip: 192.55.52.136, mailfrom: anuj.mittal@intel.com)
X-IronPort-AV: E=McAfee;i="6200,9189,10147"; a="209759015"
X-IronPort-AV: E=Sophos;i="5.87,180,1631602800";
   d="scan'208";a="209759015"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Oct 2021 07:16:02 -0700
X-IronPort-AV: E=Sophos;i="5.87,180,1631602800";
   d="scan'208";a="634754735"
Received: from syong7-mobl1.gar.corp.intel.com (HELO
 anmitta2-mobl1.gar.corp.intel.com) ([10.249.78.45])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Oct 2021 07:16:00 -0700
From: Anuj Mittal <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.50][PATCH 0/9] Review request
Date: Mon, 25 Oct 2021 22:15:47 +0800
Message-Id: <cover.1635171215.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 25 Oct 2021 14:16:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12817

Please review these changes for 1.50/hardknott.

Thanks,

Anuj

The following changes since commit bcd4285116ea4990f10d53698e0a81ae1e7ce24c:

  test/fetch: Update urls to match upstream branch name changes (2021-10-19 22:27:00 +0100)

are available in the Git repository at:

  git://push.openembedded.org/bitbake-contrib stable/1.50-next

Caner Altinbasak (1):
  npmsw: Avoid race condition with multiple npm fetchers

Richard Purdie (7):
  fetch2/git: Avoid races over mirror tarball creation
  fetch2/git: Use os.rename instead of mv
  tests/runqueue: Ensure hashserv exits before deleting files
  bitbake-worker: Allow shutdown/database flush of pseudo server at task
    exit
  bitbake-worker: Handle pseudo shutdown in Ctrl+C case
  build: Make exception printing clearer
  build: Ensure python stdout/stderr is logged correctly

Ross Burton (1):
  fetch2: clarify the command-no-found error message

 bin/bitbake-worker        | 12 +++++++++++-
 lib/bb/build.py           |  6 +++++-
 lib/bb/fetch2/__init__.py |  2 +-
 lib/bb/fetch2/git.py      | 21 +++++++++++++++++++--
 lib/bb/fetch2/npmsw.py    |  4 ++++
 lib/bb/tests/runqueue.py  |  2 +-
 6 files changed, 41 insertions(+), 6 deletions(-)

-- 
2.31.1


