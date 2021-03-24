Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by mx.groups.io with SMTP id smtpd.web11.55.1616596422209368700
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 24 Mar 2021 07:33:42 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: intel.com, ip: 192.55.52.115, mailfrom: anuj.mittal@intel.com)
IronPort-SDR: Apg3/1b2w5PrTw7noYnqSNtpxDN/fkbMzxoCU89GCDvay7kqf98S9vP/HUlRjPvUToLM266Ktt
 7X/Px7y0B65w==
X-IronPort-AV: E=McAfee;i="6000,8403,9933"; a="190132803"
X-IronPort-AV: E=Sophos;i="5.81,274,1610438400"; 
   d="scan'208";a="190132803"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 07:33:41 -0700
IronPort-SDR: H1TpQo3Ty8uBTXRpSOK48yDGZ5MWogYXFeaQ1r7NNTm9GNfRGYQHmVEblMUBBQiV7ii7KWkoN/
 TX3A+qos+T+A==
X-IronPort-AV: E=Sophos;i="5.81,274,1610438400"; 
   d="scan'208";a="514213815"
Received: from alianabi-mobl1.gar.corp.intel.com (HELO anmitta2-mobl1.gar.corp.intel.com) ([10.215.167.51])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 07:33:39 -0700
From: "Anuj Mittal" <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.48][PATCH 0/3] Patch review request
Date: Wed, 24 Mar 2021 22:33:04 +0800
Message-Id: <cover.1616596112.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Please review these next set of changes for 1.48. Clean a-full on
autobuilder.

Thanks,

Anuj

The following changes since commit 7a6517243dbfecfd78f82f6709fbeaab2fb03e2c:

  __init__.py: Fix bitbake debug log handling (2021-03-09 00:03:19 +0000)

are available in the Git repository at:

  git://push.openembedded.org/bitbake-contrib stable/1.48-next

Jan Brzezanski (1):
  Force parser shutdown after catching an exception

Richard Purdie (2):
  runqueue: Fix task execution corruption issue
  runqueue: Add setscene task overlap sanity check

 lib/bb/cooker.py   | 10 +++++-----
 lib/bb/runqueue.py |  7 +++++++
 2 files changed, 12 insertions(+), 5 deletions(-)

-- 
2.30.2

