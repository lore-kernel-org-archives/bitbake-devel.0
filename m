Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id AEA04608F7
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 31 May 2013 14:55:52 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 31 May 2013 07:53:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,779,1363158000"; d="scan'208";a="346296188"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.121.185])
	by orsmga002.jf.intel.com with ESMTP; 31 May 2013 07:55:52 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 31 May 2013 15:55:41 +0100
Message-Id: <cover.1370011759.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.8.1.2
Subject: [1.18][PATCH 0/5] Cherry-picks from master for 1.18 (cover letter only)
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 31 May 2013 14:55:52 -0000

The following changes cherry-picked from master (against poky, but apply
cleanly against the bitbake 1.18 branch with -p2) are available in the
git repository at:

  git://git.yoctoproject.org/poky-contrib paule/dylan-next2-bb
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/dylan-next2-bb

Martin Jansa (1):
  bitbake: git: remove symling before updating mirror tarball

Richard Purdie (4):
  bitbake: tests/fetch: Allow to work on python 2.6
  bitbake: test/fetch: Split the network tests from the rest of the
    fetcher tests
  bitbake: test/fetch: Allow the conditional network tests to work under
    python 2.6
  bitbake: fetch2: Fix missing function call

 bitbake/lib/bb/fetch2/__init__.py |  29 +++---
 bitbake/lib/bb/fetch2/git.py      |   4 +
 bitbake/lib/bb/tests/fetch.py     | 183 ++++++++++++++++++--------------------
 3 files changed, 106 insertions(+), 110 deletions(-)

-- 
1.8.1.2


