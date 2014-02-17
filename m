Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id AC99E6E872
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 17 Feb 2014 14:07:48 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 17 Feb 2014 06:07:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.95,860,1384329600"; d="scan'208";a="456876157"
Received: from nithyasr-mobl.ger.corp.intel.com (HELO
	peggleto-mobl5.ger.corp.intel.com) ([10.252.123.246])
	by orsmga001.jf.intel.com with ESMTP; 17 Feb 2014 06:07:48 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 17 Feb 2014 14:07:39 +0000
Message-Id: <cover.1392645935.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.8.5.3
Subject: [PATCH 0/2] Misc fixes
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 17 Feb 2014 14:07:49 -0000

The following changes since commit f975ca2cf728561bd6317ed8f76303598546113a:

  runqueue: Fix silly variable overlap (2014-02-15 14:01:55 +0000)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/bb-sigfixes
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/sigfixes

Paul Eggleton (2):
  parse: make vars_from_file return None for non-recipes
  build: fix handling of task override for tasks with underscores in
    their names

 lib/bb/build.py          | 2 +-
 lib/bb/parse/__init__.py | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
1.8.5.3


