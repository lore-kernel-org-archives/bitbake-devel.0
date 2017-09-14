Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id C0A9F781CD
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 Sep 2017 04:10:40 +0000 (UTC)
Received: from orsmga004.jf.intel.com ([10.7.209.38])
	by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	13 Sep 2017 21:10:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.42,390,1500966000"; d="scan'208";a="128563952"
Received: from babarret-mobl1.amr.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.249.71.243])
	by orsmga004.jf.intel.com with ESMTP; 13 Sep 2017 21:10:38 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 14 Sep 2017 16:09:40 +1200
Message-Id: <cover.1505361992.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.5
Subject: [PATCH 0/2] A couple of fixes for the inotify code
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
X-List-Received-Date: Thu, 14 Sep 2017 04:10:40 -0000

A fix for bbappends created in empty directories not being picked up,
and a related patch for a separate minor issue I noticed at the same
time.


The following changes since commit f0930f3216a8358759d561d244fa280932e8bf05:

  bitbake-user-manual: Edits to "inherit" section. (2017-09-13 17:19:08 +0100)

are available in the git repository at:

  git://git.openembedded.org/bitbake-contrib paule/bb-watch-fixes
  http://cgit.openembedded.org/bitbake-contrib/log/?h=paule/bb-watch-fixes

Paul Eggleton (2):
  cooker: fix watching empty directories
  cooker: ensure monkey-patching in collect_bbfiles() gets undone on error

 lib/bb/cooker.py | 47 +++++++++++++++++++++++++----------------------
 1 file changed, 25 insertions(+), 22 deletions(-)

-- 
2.9.5


