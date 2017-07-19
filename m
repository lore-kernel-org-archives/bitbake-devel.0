Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id A0C75781F2
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 19 Jul 2017 09:56:41 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	19 Jul 2017 02:56:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.40,380,1496127600"; d="scan'208";a="880410376"
Received: from gsena-mobl.amr.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.252.48.213])
	by FMSMGA003.fm.intel.com with ESMTP; 19 Jul 2017 02:56:42 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 19 Jul 2017 11:55:59 +0200
Message-Id: <cover.1500458081.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.4
Subject: [PATCH 00/12] Tinfoil enhancements / fetch fixes
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
X-List-Received-Date: Wed, 19 Jul 2017 09:56:41 -0000

Some enhancements to tinfoil around improving OE's devtool / recipetool
fetch code, as well as general enhancements to the API.


The following changes since commit 6683338598ce97278f188fbcd780c3e3754e5b9a:

  fetch2: fix indentation (2017-07-18 22:38:30 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/tinfoil-fixes-bb3
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/tinfoil-fixes-bb3

Paul Eggleton (12):
  tinfoil: add internal mode to build_file() function
  tinfoil: add a parse_recipes() function
  tinfoil: set a flag when recipes have been parsed
  lib/bb/event: refactor printing events
  lib/bb/ui/uihelper: indicate to caller of eventHandler() if events handled
  knotty: make it possible to use termfilter without either console
  tinfoil: add functionality for running full builds
  tinfoil: enable access to additional cached items
  tinfoil: add simple API for getting cached recipe information
  tinfoil: add more doc comments
  fetch2: allow hiding checksum warning
  fetch2: fire an event when there are missing checksums

 bin/bitbake-layers        |   2 +-
 lib/bb/command.py         |  43 ++++-
 lib/bb/cooker.py          |  34 ++--
 lib/bb/event.py           |  32 ++++
 lib/bb/fetch2/__init__.py |  16 ++
 lib/bb/runqueue.py        |   6 +
 lib/bb/tinfoil.py         | 389 +++++++++++++++++++++++++++++++++++++++++++++-
 lib/bb/ui/knotty.py       |  43 ++---
 lib/bb/ui/ncurses.py      |   2 +-
 lib/bb/ui/taskexp.py      |  20 +--
 lib/bb/ui/toasterui.py    |  25 +--
 lib/bb/ui/uihelper.py     |   3 +
 12 files changed, 525 insertions(+), 90 deletions(-)

-- 
2.9.4


