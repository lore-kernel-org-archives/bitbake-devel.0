Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by mx.groups.io with SMTP id smtpd.web11.2273.1619407679873857581
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 25 Apr 2021 20:28:02 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: intel.com, ip: 192.55.52.115, mailfrom: anuj.mittal@intel.com)
IronPort-SDR: kEaV8breu8NQeUhE1iy2l1ifHxnj5w7fIilTHl2OzLAxW6AZChBnj2wJ8OF01xlGo0Y0TvpZC6
 tL8Lnb1U7sZA==
X-IronPort-AV: E=McAfee;i="6200,9189,9965"; a="195828051"
X-IronPort-AV: E=Sophos;i="5.82,251,1613462400"; 
   d="scan'208";a="195828051"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2021 20:27:58 -0700
IronPort-SDR: yN2oKuMrp/HHB87HxiLnd9ym09d7/sWzYdfWTciOiffPh7nB0ah15WsSYJIw25YyJ9hMzeIvCK
 3JeG5WXt1NwA==
X-IronPort-AV: E=Sophos;i="5.82,251,1613462400"; 
   d="scan'208";a="464923216"
Received: from wsan-mobl1.ccr.corp.intel.com (HELO anmitta2-mobl1.gar.corp.intel.com) ([10.213.45.138])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2021 20:27:57 -0700
From: "Anuj Mittal" <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.50][PATCH 0/5] review request
Date: Mon, 26 Apr 2021 11:27:47 +0800
Message-Id: <cover.1619407547.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Please review these changes for hardknott/1.50.

Thanks,

Anuj

The following changes since commit b32e6c8d4ea2f83fe77021207e9db883fec82d97:

  bitbake-user-manual: add REQUIRED_VERSION and adjust PREFERRED_VERSION entry (2021-04-15 15:01:47 +0100)

are available in the Git repository at:

  git://push.openembedded.org/bitbake-contrib stable/1.50-next

Mikko Rapeli (2):
  bitbake: tests/fetch: fix test execution without .gitconfig
  bitbake: tests/fetch: remove write protected files too

Niels Avonds (1):
  fetch/gitsm: Fix crash when using git LFS and submodules

Richard Purdie (1):
  runqueue: Fix deferred task issues

Ross Burton (1):
  bitbake-server: ensure server timeout is a float

 bin/bitbake-server       |  2 +-
 lib/bb/fetch2/git.py     |  2 +-
 lib/bb/runqueue.py       |  4 ++++
 lib/bb/server/process.py |  2 +-
 lib/bb/tests/fetch.py    | 20 ++++++++++++++++++--
 5 files changed, 25 insertions(+), 5 deletions(-)

-- 
2.30.2

