Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id 0B59E60249
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 13 Jun 2016 02:52:52 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by orsmga103.jf.intel.com with ESMTP; 12 Jun 2016 19:52:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.26,464,1459839600"; d="scan'208";a="120682883"
Received: from ctan5-mobl1.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.176.32])
	by fmsmga004.fm.intel.com with ESMTP; 12 Jun 2016 19:52:51 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 13 Jun 2016 14:52:16 +1200
Message-Id: <cover.1465786269.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.5.5
Subject: [PATCH 00/10] Support progress reporting
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
X-List-Received-Date: Mon, 13 Jun 2016 02:52:53 -0000

Add code to support progress reporting within OpenEmbedded, as well as a
couple of related changes to allow reworking the extensible SDK
installation process.


The following changes since commit 6d1379c8818400e5cdc442e6142f08a110fd5b95:

  lib/bb/main.py: Fix use of BBPOSTCONF and BBPRECONF (2016-06-09 18:00:45 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/startup-bb
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/startup-bb

Paul Eggleton (10):
  knotty: provide a symlink to the latest console log
  knotty: import latest python-progressbar
  lib: implement basic task progress support
  lib/bb/progress: add MultiStageProgressReporter
  fetch2: implement progress support
  knotty: add code to support showing progress for sstate object querying
  knotty: show task progress bar
  knotty: add quiet output mode
  runqueue: add ability to enforce that tasks are setscened
  runqueue: report progress for "Preparing RunQueue" step

 lib/bb/build.py                |  34 ++++
 lib/bb/event.py                |  27 +++
 lib/bb/fetch2/__init__.py      |   4 +-
 lib/bb/fetch2/git.py           |  52 +++++-
 lib/bb/fetch2/wget.py          |  26 ++-
 lib/bb/main.py                 |   9 +
 lib/bb/msg.py                  |   5 +-
 lib/bb/progress.py             | 266 ++++++++++++++++++++++++++++
 lib/bb/runqueue.py             | 131 +++++++++++++-
 lib/bb/ui/knotty.py            | 143 ++++++++++++---
 lib/bb/ui/uihelper.py          |   7 +-
 lib/progressbar.py             | 384 ----------------------------------------
 lib/progressbar/LICENSE.txt    |  52 ++++++
 lib/progressbar/__init__.py    |  49 ++++++
 lib/progressbar/compat.py      |  44 +++++
 lib/progressbar/progressbar.py | 315 +++++++++++++++++++++++++++++++++
 lib/progressbar/widgets.py     | 391 +++++++++++++++++++++++++++++++++++++++++
 17 files changed, 1519 insertions(+), 420 deletions(-)
 create mode 100644 lib/bb/progress.py
 delete mode 100644 lib/progressbar.py
 create mode 100644 lib/progressbar/LICENSE.txt
 create mode 100644 lib/progressbar/__init__.py
 create mode 100644 lib/progressbar/compat.py
 create mode 100644 lib/progressbar/progressbar.py
 create mode 100644 lib/progressbar/widgets.py

-- 
2.5.5


