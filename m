Return-Path: <anuj.mittal@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72986C433FE
	for <webhook@archiver.kernel.org>; Wed, 29 Sep 2021 14:57:26 +0000 (UTC)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by mx.groups.io with SMTP id smtpd.web09.9904.1632927444893819455
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 29 Sep 2021 07:57:25 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: intel.com, ip: 192.55.52.93, mailfrom: anuj.mittal@intel.com)
X-IronPort-AV: E=McAfee;i="6200,9189,10122"; a="221752887"
X-IronPort-AV: E=Sophos;i="5.85,332,1624345200";
   d="scan'208";a="221752887"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2021 07:57:23 -0700
X-IronPort-AV: E=Sophos;i="5.85,332,1624345200";
   d="scan'208";a="437663371"
Received: from zkeh-mobl.gar.corp.intel.com (HELO
 anmitta2-mobl1.gar.corp.intel.com) ([10.213.143.173])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2021 07:57:22 -0700
From: Anuj Mittal <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.50][PATCH 0/3] Review request
Date: Wed, 29 Sep 2021 22:57:10 +0800
Message-Id: <cover.1632902709.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 29 Sep 2021 14:57:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12713

Please review these changes for 1.50/hardknott. Tested with oe-core and
no issues seen.

Thanks,

Anuj

The following changes since commit 7d938703d9321cde5a32e4dff005f07e8821b704:

  runqueue/knotty: Improve UI handling of setscene task counting (2021-09-24 15:03:33 +0800)

are available in the Git repository at:

  git://push.openembedded.org/bitbake-contrib stable/1.50-next

Richard Purdie (3):
  process: Don't include logs in error message if piping them
  build: Avoid duplicating logs in verbose mode
  build: Handle SystemExit in python tasks correctly

 lib/bb/build.py   | 6 +++++-
 lib/bb/process.py | 3 +++
 2 files changed, 8 insertions(+), 1 deletion(-)

-- 
2.31.1


