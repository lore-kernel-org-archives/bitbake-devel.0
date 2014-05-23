Return-Path: <sgw@linux.intel.com>
Received: from mga09.intel.com (unknown [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 1F81865FDC
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 23 May 2014 16:40:25 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 23 May 2014 09:35:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.98,894,1392192000"; d="scan'208";a="516718775"
Received: from unknown (HELO swold-linux.bigsur.com) ([10.255.12.174])
	by orsmga001.jf.intel.com with ESMTP; 23 May 2014 09:40:17 -0700
From: Saul Wold <sgw@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 23 May 2014 09:40:16 -0700
Message-Id: <cover.1400862889.git.sgw@linux.intel.com>
X-Mailer: git-send-email 1.8.3.1
Subject: [Daisy - Initial Pull 0/9] Please Review
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
X-List-Received-Date: Fri, 23 May 2014 16:40:28 -0000

Richard,

This is a set of fixes that I backported from 1.7 for Daisy.

Sau!

The following changes since commit fe083b674b20b254877a6d8249b11c9a7373866e:

  bitbake-user-manual-hello.xml: Edits to the "Hello World" Appendix. (2014-04-21 22:51:42 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib sgw/bitbake-1.22
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=sgw/bitbake-1.22

Jacob Kroon (1):
  bitbake: bitbake-diffsigs: Fix runtime error when no arguments are
    given

Nick Lewis (1):
  bitbake: Fix refetch of local files when they are read only

Richard Purdie (5):
  bitbake: runqueue: Fix handling of zero priority task
  bitbake: runqueue: Fix task weighting algorithm
  bitbake: fetch2/git: Stop git from triggering fsync() calls
  bitbake: fetch2/perforce: Ensure command has a default
  bitbake: data_smart: Fix an unusual variable reference bug

Volker Vogelhuber (2):
  bitbake: HG Fetch with username and password in url
  bitbake: fix cloning of mercurial repository with username and
    password specified in url

 bin/bitbake-diffsigs      | 4 ++--
 lib/bb/data_smart.py      | 2 +-
 lib/bb/fetch2/__init__.py | 4 ++--
 lib/bb/fetch2/git.py      | 4 ++--
 lib/bb/fetch2/hg.py       | 7 +++++--
 lib/bb/fetch2/perforce.py | 8 ++++----
 lib/bb/runqueue.py        | 6 +++---
 lib/bb/tests/data.py      | 5 +++++
 8 files changed, 24 insertions(+), 16 deletions(-)

-- 
1.8.3.1


