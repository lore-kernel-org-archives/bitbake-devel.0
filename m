Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 004E0731AC
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 23 Jun 2016 10:59:46 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by orsmga101.jf.intel.com with ESMTP; 23 Jun 2016 03:59:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.26,516,1459839600"; d="scan'208";a="723878742"
Received: from clim19-mobl.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.149.148])
	by FMSMGA003.fm.intel.com with ESMTP; 23 Jun 2016 03:59:43 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 23 Jun 2016 22:59:02 +1200
Message-Id: <cover.1466679280.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.5.5
Subject: [PATCH v2 00/10] Support progress reporting
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
X-List-Received-Date: Thu, 23 Jun 2016 10:59:47 -0000

Add code to support progress reporting within OpenEmbedded, as well as a
couple of related changes to allow reworking the extensible SDK
installation process. (See the corresponding OE-Core series for further
details).

Changes since v1:
* Rebase on top of recent runqueue changes
* Fix debug=True in MultiStageProgressReporter printing weightings if
  finish() was called a second time (as it is in the runqueue).
* Fix a couple of bugs with the BB_SETSCENE_ENFORCE code
* Add comments in the runqueue code explaining how to update the weightings


The following changes since commit 31977e7bb98f676197c6cee66f6ab4c12d4dcbde:

  cooker: clean up EvertWriter (2016-06-20 17:23:53 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/startup-bb
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/startup-bb

Paul Eggleton (10):
  knotty: provide a symlink to the latest console log
  knotty: import latest python-progressbar
  lib: implement basic task progress support
  lib/bb/progress: add MultiStageProgressReporter
  fetch2: implement progress support
  knotty: add code to support showing progress for sstate object
    querying
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
 lib/bb/progress.py             | 270 ++++++++++++++++++++++++++++
 lib/bb/runqueue.py             | 151 +++++++++++++++-
 lib/bb/ui/knotty.py            | 143 ++++++++++++---
 lib/bb/ui/uihelper.py          |   7 +-
 lib/progressbar.py             | 384 ----------------------------------------
 lib/progressbar/LICENSE.txt    |  52 ++++++
 lib/progressbar/__init__.py    |  49 ++++++
 lib/progressbar/compat.py      |  44 +++++
 lib/progressbar/progressbar.py | 315 +++++++++++++++++++++++++++++++++
 lib/progressbar/widgets.py     | 391 +++++++++++++++++++++++++++++++++++++++++
 17 files changed, 1542 insertions(+), 421 deletions(-)
 create mode 100644 lib/bb/progress.py
 delete mode 100644 lib/progressbar.py
 create mode 100644 lib/progressbar/LICENSE.txt
 create mode 100644 lib/progressbar/__init__.py
 create mode 100644 lib/progressbar/compat.py
 create mode 100644 lib/progressbar/progressbar.py
 create mode 100644 lib/progressbar/widgets.py

-- 
2.5.5


