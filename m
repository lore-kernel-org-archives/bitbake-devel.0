Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id AB3D6606E8
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 17 Aug 2015 11:12:34 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 17 Aug 2015 04:12:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,694,1432623600"; d="scan'208";a="785564764"
Received: from jwanrooi-mobl.ger.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.252.11.216])
	by orsmga002.jf.intel.com with ESMTP; 17 Aug 2015 04:12:34 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 17 Aug 2015 12:12:15 +0100
Message-Id: <cover.1439809654.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.1.0
Subject: [PATCH 00/13] Fixes and refactoring
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
X-List-Received-Date: Mon, 17 Aug 2015 11:12:37 -0000

Here are a bunch of bugfixes and refactoring patches that I was going to
send as part of reworking tinfoil. Unfortunately that reworking isn't
complete and I don't have time to finish it right now; here is what I do
have that can stand on its own. Most of it relates to memory resident
mode or tidying up code that calls into cooker.


The following changes since commit 04e896d7fb170271fb09dae5c2a42acb4b68f513:

  toastergui: Added IDs to elements used in testing (2015-08-17 08:47:51 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/tinfoil2-pre
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/tinfoil2-pre

Paul Eggleton (11):
  Fix default function parameter assignment to a list
  command: intercept SystemExit to avoid trashing the server
  cooker: further limit inotify watches
  cooker: ensure prefile/postfile can work in memory resident mode
  Fix -m handling if cannot connect to server
  lib/bb/main: consolidate UI/server extension listing and loading
  cooker: drop appliedappendlist
  cooker: drop appendlist
  bitbake-layers: refactor show-appends to stop using cooker bbappends list
  bitbake-layers: use "with open" consistently
  lib/bb/parse: properly handle OSError when updating mtime cache

Richard Purdie (2):
  command: ensure sync commands that read configuration see updates
  bitbake-layers: Convert flatten to use collections.bbappends

 bin/bitbake-layers                  | 125 ++++++++++++++++++------------------
 lib/bb/command.py                   |  15 ++++-
 lib/bb/cooker.py                    |  90 ++++++++++++++++----------
 lib/bb/cookerdata.py                |   3 +-
 lib/bb/event.py                     |   4 +-
 lib/bb/fetch2/__init__.py           |  23 ++++---
 lib/bb/main.py                      |  80 ++++++++++++++---------
 lib/bb/msg.py                       |   7 +-
 lib/bb/parse/__init__.py            |   7 +-
 lib/bb/process.py                   |   5 +-
 lib/bb/server/process.py            |   4 +-
 lib/bb/server/xmlrpc.py             |   7 +-
 lib/bb/taskdata.py                  |   8 ++-
 lib/bb/ui/crumbs/hobeventhandler.py |  12 +++-
 lib/toaster/toastergui/views.py     |   4 +-
 15 files changed, 236 insertions(+), 158 deletions(-)

-- 
2.1.0


