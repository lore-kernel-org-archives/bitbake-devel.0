Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1Rlke9-0006Wv-Ba
	for bitbake-devel@lists.openembedded.org;
	Fri, 13 Jan 2012 18:10:33 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 13 Jan 2012 09:01:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="98177323"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.122.110])
	by orsmga002.jf.intel.com with ESMTP; 13 Jan 2012 09:01:54 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 13 Jan 2012 17:01:44 +0000
Message-Id: <cover.1326473488.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.5.4
Subject: [PATCH 0/8] Error message improvements
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 13 Jan 2012 17:10:33 -0000

A number of fixes to improve the readability of error messages,
primarily for fetch errors, but will improve error output in other
situations as well.

(This supersedes the set of patches I sent a couple of days ago.)

The changes (against Poky, but apply cleanly with -p2 against bitbake
master) are available in the git repository at: 
  git://git.yoctoproject.org/poky-contrib paule/errorhandling
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/errorhandling

Paul Eggleton (8):
  bitbake/knotty: don't count errors as warnings in summary
  bitbake/fetch2: improve error formatting for fetcher errors
  bitbake/runqueue: avoid "failed" in task summary if nothing did
  bitbake/fetch2: correctly decode exit signal/status
  bitbake/knotty: avoid printing full task log when error already
    printed
  bitbake/fetch2: reduce output for fetch failures
  bitbake/cooker: avoid printing stack trace for -b match error
  bitbake/knotty: print task failure summary

 bitbake/lib/bb/build.py           |   20 ++++++++++++++++----
 bitbake/lib/bb/cooker.py          |   21 +++++++++++----------
 bitbake/lib/bb/fetch2/__init__.py |   29 ++++++++++++++++++++---------
 bitbake/lib/bb/runqueue.py        |    6 +++++-
 bitbake/lib/bb/ui/knotty.py       |   28 ++++++++++++++++++++++++----
 5 files changed, 76 insertions(+), 28 deletions(-)

-- 
1.7.5.4



