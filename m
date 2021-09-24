Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by mx.groups.io with SMTP id smtpd.web10.4518.1632464406625742753
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 23 Sep 2021 23:20:06 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: intel.com, ip: 134.134.136.20, mailfrom: anuj.mittal@intel.com)
X-IronPort-AV: E=McAfee;i="6200,9189,10116"; a="211249286"
X-IronPort-AV: E=Sophos;i="5.85,319,1624345200"; 
   d="scan'208";a="211249286"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2021 23:20:05 -0700
X-IronPort-AV: E=Sophos;i="5.85,319,1624345200"; 
   d="scan'208";a="485283434"
Received: from kellylim-mobl.gar.corp.intel.com (HELO anmitta2-mobl1.gar.corp.intel.com) ([10.215.225.112])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2021 23:20:04 -0700
From: "Anuj Mittal" <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.50][PATCH 0/8] Pull Request (cover letter only)
Date: Fri, 24 Sep 2021 14:19:55 +0800
Message-Id: <cover.1632464341.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Please merge these changes.

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

