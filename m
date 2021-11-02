Return-Path: <anuj.mittal@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E69C4332F
	for <webhook@archiver.kernel.org>; Tue,  2 Nov 2021 09:02:54 +0000 (UTC)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by mx.groups.io with SMTP id smtpd.web10.6743.1635843773682662604
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 02 Nov 2021 02:02:53 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: intel.com, ip: 134.134.136.126, mailfrom: anuj.mittal@intel.com)
X-IronPort-AV: E=McAfee;i="6200,9189,10155"; a="218125266"
X-IronPort-AV: E=Sophos;i="5.87,202,1631602800";
   d="scan'208";a="218125266"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2021 02:02:52 -0700
X-IronPort-AV: E=Sophos;i="5.87,202,1631602800";
   d="scan'208";a="496847321"
Received: from kehoh-mobl.gar.corp.intel.com (HELO
 anmitta2-mobl1.gar.corp.intel.com) ([10.215.233.28])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2021 02:02:50 -0700
From: Anuj Mittal <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.52][PATCH 0/3] Review request
Date: Tue,  2 Nov 2021 17:02:42 +0800
Message-Id: <cover.1635843660.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 02 Nov 2021 09:02:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12852

Please review and consider merging these for 1.52/honister. Tested with
oe-core and no issues seen on autobuilder.

Thanks,

Anuj

The following changes since commit 692fa35f4c23722f3179502cb965960cc230e709:

  bitbake-worker: Add debug when unpickle fails (2021-10-26 23:27:11 +0100)

are available in the Git repository at:

  git://push.openembedded.org/bitbake-contrib stable/1.52-next

Chen Qi (3):
  tests/fetch.py: fix premirror test cases
  tests/fetch.py: add test case to ensure downloadfilename is used for
    premirror
  fetch2: fix downloadfilename issue with premirror

 lib/bb/fetch2/__init__.py | 10 +++++++---
 lib/bb/tests/fetch.py     | 16 ++++++++++++----
 2 files changed, 19 insertions(+), 7 deletions(-)

-- 
2.31.1


