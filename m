Return-Path: <anuj.mittal@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D5C5C433EF
	for <webhook@archiver.kernel.org>; Mon, 22 Nov 2021 02:24:57 +0000 (UTC)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by mx.groups.io with SMTP id smtpd.web10.1441.1637547896753547701
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 21 Nov 2021 18:24:56 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: intel.com, ip: 192.55.52.43, mailfrom: anuj.mittal@intel.com)
X-IronPort-AV: E=McAfee;i="6200,9189,10175"; a="320933681"
X-IronPort-AV: E=Sophos;i="5.87,253,1631602800";
   d="scan'208";a="320933681"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2021 18:24:55 -0800
X-IronPort-AV: E=Sophos;i="5.87,253,1631602800";
   d="scan'208";a="588848652"
Received: from kkleong1-mobl1.gar.corp.intel.com (HELO
 anmitta2-mobl3.intel.com) ([10.215.239.135])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2021 18:24:54 -0800
From: Anuj Mittal <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.50][PATCH 0/8] Review request
Date: Mon, 22 Nov 2021 10:24:41 +0800
Message-Id: <cover.1637547674.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 22 Nov 2021 02:24:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13084

Please review and merge these changes for 1.50. No issues seen while
testing on autobuilder.

Thanks,

Anuj

The following changes since commit 15dadb69b4c5d29b80770e55d1e9afbe47084aa4:

  runqueue: Fix runall option handling (2021-11-16 11:28:01 +0800)

are available in the Git repository at:

  git://push.openembedded.org/bitbake-contrib stable/1.50-next

Alexander Kanavin (3):
  bitbake: correct the collections vs collections.abc deprecation
  bitbake: correct deprecation warning in process.py
  bitbake: adjust parser error check for python 3.10 compatibility

Justin Bronder (1):
  hashserv: let asyncio discover the running loop

Richard Purdie (4):
  cooker: Handle parse threads disappearing to avoid hangs
  cooker: Remove debug code, oops :(
  cooker: Handle parsing results queue race
  cooker: Fix task-depends.dot for multiconfig targets

 lib/bb/cache.py          |  3 ++-
 lib/bb/cooker.py         | 18 ++++++++++++++++--
 lib/bb/data_smart.py     |  4 ++--
 lib/bb/persist_data.py   |  5 +++--
 lib/bb/server/process.py |  2 +-
 lib/hashserv/server.py   |  4 ++--
 6 files changed, 26 insertions(+), 10 deletions(-)

-- 
2.33.1


