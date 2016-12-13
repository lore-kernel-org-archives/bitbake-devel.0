Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 5F9EE71B20
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 13 Dec 2016 07:08:20 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by fmsmga103.fm.intel.com with ESMTP; 12 Dec 2016 23:08:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.33,340,1477983600"; d="scan'208";a="201961380"
Received: from mauric9x-mobl.amr.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com.fritz.box) ([10.255.158.7])
	by fmsmga004.fm.intel.com with ESMTP; 12 Dec 2016 23:08:19 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 13 Dec 2016 20:06:59 +1300
Message-Id: <cover.1481611138.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.5.5
Subject: [PATCH 00/15] Tinfoil rework
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
X-List-Received-Date: Tue, 13 Dec 2016 07:08:24 -0000

Tinfoil is an API that allows you to write simple utilities that call into
BitBake code to read variables, parse recipes, etc. (as used by various 
scripts in BitBake & OE, including bitbake-layers, devtool, etc.) This 
patchset reworks tinfoil in order to address several limitations of the
current implementation, first and foremost that it doesn't currently work 
in bitbake's memory resident mode. This rework is also known as "tinfoil2"
although the classes and modules have not changed name. Fixes for a few
other related issues I found along the way are also included. There is an
additional set of patches for OE-Core that make corresponding changes
there - both sets should be applied together in order for things to remain
working.

Note that whilst these patchsets make some significant improvements to how
the system behaves in memory resident mode, there are still a number of
issues that prevent memory resident mode from being reliable. See this
wiki page for a few more details:

  https://wiki.yoctoproject.org/wiki/index.php?title=Tinfoil2

I will be converting some of these into bugzilla entries after this
patchset and the corresponding one for OE-Core get merged.


The following changes since commit b65a8193368ffa1d15af24a6acde8dce6bd4d383:

  toaster: views Remove old code that converts template context to JSON (2016-12-12 20:44:47 +0000)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/tinfoil2-bb
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/tinfoil2-bb

Paul Eggleton (15):
  data_smart: fix resetting of reference on variablehistory
  knotty: make quiet option a level option
  knotty: fix --observe-only option
  server/xmlrpc: send back 503 response with correct encoding
  data_smart: implement remote datastore functionality
  command: provide a means to shut down from the client in memres mode
  tinfoil: rewrite as a wrapper around the UI
  remotedata: enable transporting datastore from the client to the server
  tinfoil: implement server-side recipe parsing
  tinfoil: pass datastore to server when expanding python references
  cooker: allow buildFile warning to be hidden programmatically
  data_smart: support serialisation
  runqueue: enable setVariable command to affect task execution
  siggen: add means of ignoring basehash mismatch
  server/process: don't change UI process signal handler on terminate

 bin/bitbake-worker       |  12 +-
 lib/bb/command.py        | 253 ++++++++++++++++++++++++++-
 lib/bb/cooker.py         |  36 +++-
 lib/bb/cookerdata.py     |   1 +
 lib/bb/data_smart.py     |  54 +++++-
 lib/bb/main.py           |  87 ++++++----
 lib/bb/remotedata.py     | 116 +++++++++++++
 lib/bb/runqueue.py       |   1 +
 lib/bb/server/process.py |   1 -
 lib/bb/server/xmlrpc.py  |   2 +-
 lib/bb/siggen.py         |   3 +-
 lib/bb/tests/data.py     |  68 ++++++++
 lib/bb/tinfoil.py        | 439 +++++++++++++++++++++++++++++++++++++++--------
 lib/bb/ui/knotty.py      |  45 +++--
 lib/bblayers/query.py    |  28 +--
 15 files changed, 982 insertions(+), 164 deletions(-)
 create mode 100644 lib/bb/remotedata.py

-- 
2.5.5


