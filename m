Return-Path: <anuj.mittal@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2761CC433EF
	for <webhook@archiver.kernel.org>; Tue, 26 Oct 2021 14:27:56 +0000 (UTC)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by mx.groups.io with SMTP id smtpd.web09.12829.1635258475416242829
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 26 Oct 2021 07:27:55 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: intel.com, ip: 134.134.136.31, mailfrom: anuj.mittal@intel.com)
X-IronPort-AV: E=McAfee;i="6200,9189,10149"; a="290757092"
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800";
   d="scan'208";a="290757092"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2021 07:08:00 -0700
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800";
   d="scan'208";a="497352127"
Received: from wandsuan-mobl.gar.corp.intel.com (HELO
 anmitta2-mobl1.gar.corp.intel.com) ([10.215.231.17])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2021 07:07:59 -0700
From: Anuj Mittal <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.52][PATCH 0/2] Review request
Date: Tue, 26 Oct 2021 22:06:45 +0800
Message-Id: <cover.1635256061.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 26 Oct 2021 14:27:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12830

Please review and merge these changes for 1.52.

Thanks,

Anuj

The following changes since commit 20eae05fdd6cb7ace87ad005f72c256e2fddb3d0:

  fetch2/perforce: Fix typo (2021-10-26 13:47:06 +0100)

are available in the Git repository at:

  git://push.openembedded.org/bitbake-contrib stable/1.52-next

Richard Purdie (2):
  tests/runqueue: Ensure hashserv exits before deleting files
  bitbake-worker: Add debug when unpickle fails

 bin/bitbake-worker       | 6 +++++-
 lib/bb/tests/runqueue.py | 2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

-- 
2.31.1


