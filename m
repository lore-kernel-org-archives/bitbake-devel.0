Return-Path: <ddalex@intel.com>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by mail.openembedded.org (Postfix) with ESMTP id 4659E61DDD
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Sep 2013 12:15:43 +0000 (UTC)
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 18 Sep 2013 05:15:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,929,1371106800"; d="scan'208";a="296360704"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by AZSMGA002.ch.intel.com with ESMTP; 18 Sep 2013 05:15:39 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id 9AC5B5606E0; Wed, 18 Sep 2013 13:15:40 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org,
	richard.purdie@linuxfoundation.org
Date: Wed, 18 Sep 2013 13:15:37 +0100
Message-Id: <cover.1379505533.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 0/7] Adding Bitbake support for WebHob
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
X-List-Received-Date: Wed, 18 Sep 2013 12:15:45 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>


This is a set of patches that prepare Bitbake to support WebHob.

Among the significant changes:

* The extra_caches mechanism is replaced with a CookerFeature mechanism
that allows the UI clients to specify what features they need at connection time.
This allows the server to start, for example, with a minimum set of caches,
and load any additional caches on demand when the clients connect.

* Another CookerFeature is added that will make the server send the 
dependency tree to the clients, on request, when the server is ready to 
start processing the runqueue.

* There is a new server command that returns the contents of the data store.

* The data read from the the recipecache depends on what extra caches
have been loaded, and it's discovered at runtime instead of hardcoding.


The following changes since commit eaf06bc2840cc39026033de0779858b1bf82f06f:

  bitbake: cooker: return a copy checkPackages (2013-09-18 08:41:55 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib adamian/bitbake-core-changes-1809-2
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=adamian/bitbake-core-changes-1809-2

Alexandru DAMIAN (7):
  bitbake: cooker,xmlrpc,servers: implement CookerFeatures
  bitbake: cooker,runqueue: send the task dependency tree
  bitbake: build, runqueue: adds info to the *runQueue* events
  bitbake: cooker: get extra information from recipe cache
  bitbake: cooker, command: add a command to return global data
  bitbake: event: adding generic event for metadata usage
  bitbake: runqueue: add task hash to Queue events

 bitbake/bin/bitbake                      |  25 ++------
 bitbake/lib/bb/build.py                  |   2 +
 bitbake/lib/bb/cache_extra.py            |   6 ++
 bitbake/lib/bb/command.py                |   9 +++
 bitbake/lib/bb/cooker.py                 | 102 ++++++++++++++++++++++++-------
 bitbake/lib/bb/cookerdata.py             |   1 -
 bitbake/lib/bb/event.py                  |  10 +++
 bitbake/lib/bb/runqueue.py               |  20 ++++++
 bitbake/lib/bb/server/__init__.py        |   2 +-
 bitbake/lib/bb/server/process.py         |  23 +++++--
 bitbake/lib/bb/server/xmlrpc.py          |  29 ++++++---
 bitbake/lib/bb/ui/crumbs/hoblistmodel.py |   2 +-
 bitbake/lib/bb/ui/hob.py                 |   2 +-
 bitbake/lib/bb/ui/knotty.py              |   4 ++
 bitbake/lib/bb/ui/uievent.py             |   7 ++-
 15 files changed, 183 insertions(+), 61 deletions(-)

-- 
1.8.1.2


