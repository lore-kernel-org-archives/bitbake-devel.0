Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by mx.groups.io with SMTP id smtpd.web12.34540.1620052567273085602
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 03 May 2021 07:36:08 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: intel.com, ip: 134.134.136.24, mailfrom: anuj.mittal@intel.com)
IronPort-SDR: a0dYggiCGSPm3ozLcum6z9r1zB4/NdpR/+2erd1p5rKe9QZoFU5OkpGHZDWxKuFHs1H8wsToZq
 Lq7cRNRX7tKg==
X-IronPort-AV: E=McAfee;i="6200,9189,9973"; a="197849329"
X-IronPort-AV: E=Sophos;i="5.82,270,1613462400"; 
   d="scan'208";a="197849329"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2021 07:36:04 -0700
IronPort-SDR: caFP0C4mM4HFv5ubWjwdoD00JmbzIhpv/M3Q3e7CtnewNDYIBUdchgZSNqd4MBNqiu2dFfXUEb
 ttKOyOi1fNJg==
X-IronPort-AV: E=Sophos;i="5.82,270,1613462400"; 
   d="scan'208";a="405696735"
Received: from semohdyu-mobl1.gar.corp.intel.com (HELO anmitta2-mobl1.gar.corp.intel.com) ([10.249.72.206])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2021 07:36:03 -0700
From: "Anuj Mittal" <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.48][PATCH 0/3] review request
Date: Mon,  3 May 2021 22:35:51 +0800
Message-Id: <cover.1620052467.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Please review these changes for 1.48/gatesgarth.

Thanks,

Anuj

The following changes since commit 7b7d7b02faedb603d81144a134e80027e4019ab0:

  cooker: Include all packages a recipe provides in SkippedPackage.rprovides (2021-04-27 15:22:14 +0100)

are available in the Git repository at:

  git://push.openembedded.org/bitbake-contrib stable/1.48-next

Niels Avonds (1):
  fetch/gitsm: Fix crash when using git LFS and submodules

Richard Purdie (1):
  runqueue: Fix deferred task issues

Ross Burton (1):
  bitbake-server: ensure server timeout is a float

 bin/bitbake-server       | 2 +-
 lib/bb/fetch2/git.py     | 2 +-
 lib/bb/runqueue.py       | 4 ++++
 lib/bb/server/process.py | 2 +-
 4 files changed, 7 insertions(+), 3 deletions(-)

-- 
2.30.2

