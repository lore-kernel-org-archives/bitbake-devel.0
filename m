Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by mx.groups.io with SMTP id smtpd.web08.4943.1632213324527270188
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 21 Sep 2021 01:35:24 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: intel.com, ip: 134.134.136.126, mailfrom: anuj.mittal@intel.com)
X-IronPort-AV: E=McAfee;i="6200,9189,10113"; a="210390165"
X-IronPort-AV: E=Sophos;i="5.85,310,1624345200"; 
   d="scan'208";a="210390165"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2021 01:35:23 -0700
X-IronPort-AV: E=Sophos;i="5.85,310,1624345200"; 
   d="scan'208";a="701611411"
Received: from marsalan-mobl1.gar.corp.intel.com (HELO anmitta2-mobl1.gar.corp.intel.com) ([10.215.238.172])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2021 01:35:22 -0700
From: "Anuj Mittal" <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [hardknott][PATCH 0/8] Review request
Date: Tue, 21 Sep 2021 16:35:08 +0800
Message-Id: <cover.1632212181.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Please review these changes for hardknott/1.50. Tested with oe-core and
no related problems seen.

https://autobuilder.yoctoproject.org/typhoon/#/builders/83/builds/2625

Thanks,

Anuj

The following changes since commit 4d83d9103d9225a2ac42c0f3dfada2f5cf140b68:

  build: Catch and error upon circular task references (2021-09-16 22:17:07 +0100)

are available in the Git repository at:

  git://push.openembedded.org/bitbake-contrib stable/1.50-next

Martin Jansa (1):
  cooker/process: Fix typos in exiting message

Richard Purdie (7):
  cookerdata: Show error for no BBLAYERS in bblayers.conf
  cookerdata: Improve missing core layer error message
  data_smart: Improve error display for handled exceptions
  runqueue: Clean up task stats handling
  bitbake-worker: Improve error handling
  cookerdata: Show a readable error for invalid multiconfig name
  runqueue/knotty: Improve UI handling of setscene task counting

 bin/bitbake-worker       | 10 ++++++----
 lib/bb/cooker.py         |  2 +-
 lib/bb/cookerdata.py     |  7 +++++++
 lib/bb/data_smart.py     |  2 ++
 lib/bb/runqueue.py       | 43 +++++++++++++++++++++++-----------------
 lib/bb/server/process.py |  2 +-
 lib/bb/ui/knotty.py      |  2 +-
 lib/bb/ui/uihelper.py    |  4 ++--
 8 files changed, 45 insertions(+), 27 deletions(-)

-- 
2.31.1

