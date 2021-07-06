Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by mx.groups.io with SMTP id smtpd.web08.3457.1625560227989589104
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 06 Jul 2021 01:30:29 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: intel.com, ip: 134.134.136.24, mailfrom: anuj.mittal@intel.com)
X-IronPort-AV: E=McAfee;i="6200,9189,10036"; a="209032000"
X-IronPort-AV: E=Sophos;i="5.83,328,1616482800"; 
   d="scan'208";a="209032000"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2021 01:30:27 -0700
X-IronPort-AV: E=Sophos;i="5.83,328,1616482800"; 
   d="scan'208";a="559876403"
Received: from sho7-mobl2.gar.corp.intel.com (HELO anmitta2-mobl1.gar.corp.intel.com) ([10.255.151.151])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2021 01:30:25 -0700
From: "Anuj Mittal" <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.50][PATCH 0/2] review request
Date: Tue,  6 Jul 2021 16:30:19 +0800
Message-Id: <cover.1625560113.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Please review these changes for 1.50/hardknott.

Thanks,

Anuj

The following changes since commit 0c83e98b0b4129e43e05129074fff60b22a9f2eb:

  server/process: Handle error in heartbeat funciton in OOM case (2021-05-20 21:40:00 +0100)

are available in the Git repository at:

  git://push.openembedded.org/bitbake-contrib stable/1.50-next

Harald Brinkmann (1):
  fetch/svn: Fix parsing revision of SVN repos with redirects

Scott Weaver (1):
  fetch2: add check for empty SRC_URI hash string

 lib/bb/fetch2/__init__.py | 5 ++++-
 lib/bb/fetch2/svn.py      | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

-- 
2.31.1

