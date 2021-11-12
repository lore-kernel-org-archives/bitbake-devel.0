Return-Path: <anuj.mittal@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE4F9C433EF
	for <webhook@archiver.kernel.org>; Fri, 12 Nov 2021 06:15:55 +0000 (UTC)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by mx.groups.io with SMTP id smtpd.web09.12054.1636697754442019011
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 11 Nov 2021 22:15:54 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: intel.com, ip: 134.134.136.126, mailfrom: anuj.mittal@intel.com)
X-IronPort-AV: E=McAfee;i="6200,9189,10165"; a="219973528"
X-IronPort-AV: E=Sophos;i="5.87,228,1631602800";
   d="scan'208";a="219973528"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2021 22:15:53 -0800
X-IronPort-AV: E=Sophos;i="5.87,228,1631602800";
   d="scan'208";a="733528774"
Received: from wanmohds-mobl1.gar.corp.intel.com (HELO
 anmitta2-mobl1.gar.corp.intel.com) ([10.213.139.200])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2021 22:15:51 -0800
From: Anuj Mittal <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.52][PATCH 0/6] Pull request
Date: Fri, 12 Nov 2021 14:15:46 +0800
Message-Id: <cover.1636697642.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 12 Nov 2021 06:15:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13029

Please merge these changes.

Thanks,

Anuj

The following changes since commit 1ac73638c1504cf2aa7f13257396aad617f25e8f:

  Revert "parse/ast: Show errors for append/prepend/remove operators combined with +=/.=" (2021-11-05 09:16:41 +0000)

are available in the Git repository at:

  git://push.openembedded.org/bitbake-contrib stable/1.52-next

Jose Quaresma (1):
  cooker: check if upstream hash equivalence server is available

Richard Purdie (5):
  tests/fetch: Update github urls
  fetch: Handle mirror user/password replacements correctly
  tests/fetch: Update pcre.org address after github changes
  runqueue: Fix runall option task deletion ordering issue
  runqueue: Fix runall option handling

 lib/bb/cooker.py          | 12 +++++++++++-
 lib/bb/fetch2/__init__.py |  4 ++++
 lib/bb/runqueue.py        | 34 ++++++++++++++++------------------
 lib/bb/tests/fetch.py     | 32 ++++++++++++++++++--------------
 4 files changed, 49 insertions(+), 33 deletions(-)

-- 
2.31.1


