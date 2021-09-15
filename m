Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by mx.groups.io with SMTP id smtpd.web11.3973.1631747984007383249
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 15 Sep 2021 16:19:44 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: intel.com, ip: 192.55.52.151, mailfrom: anuj.mittal@intel.com)
X-IronPort-AV: E=McAfee;i="6200,9189,10108"; a="202605347"
X-IronPort-AV: E=Sophos;i="5.85,296,1624345200"; 
   d="scan'208";a="202605347"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2021 16:19:43 -0700
X-IronPort-AV: E=Sophos;i="5.85,296,1624345200"; 
   d="scan'208";a="434303187"
Received: from chgan-mobl.gar.corp.intel.com (HELO anmitta2-mobl1.gar.corp.intel.com) ([10.215.238.104])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2021 16:19:42 -0700
From: "Anuj Mittal" <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.50][PATCH 0/5] Review request
Date: Thu, 16 Sep 2021 07:19:33 +0800
Message-Id: <cover.1631747835.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Please review these changes for 1.50. Tested with oe-core and no issues
seen.

https://autobuilder.yoctoproject.org/typhoon/#/builders/83/builds/2592

Thanks,

Anuj

The following changes since commit c7b506d11df78cfc4610db6578745eaa6220b13a:

  server: Fix early parsing errors preventing zombie bitbake (2021-09-09 09:41:51 +0100)

are available in the Git repository at:

  git://push.openembedded.org/bitbake-contrib stable/1.50-next

Joshua Watt (1):
  cooker: Allow upstream for local hash equivalence server

Richard Purdie (4):
  runqueue: Avoid deadlock avoidance task graph corruption
  runqueue: Fix issues with multiconfig deferred task deadlock messages
  runqueue: Improve multiconfig deferred task issues
  build: Catch and error upon circular task references

 lib/bb/build.py    |  2 ++
 lib/bb/cooker.py   |  7 ++++-
 lib/bb/runqueue.py | 67 +++++++++++++++++++++++++++-------------------
 3 files changed, 48 insertions(+), 28 deletions(-)

-- 
2.31.1

