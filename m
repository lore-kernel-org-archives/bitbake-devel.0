Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QkUIW-0005rW-QB
	for bitbake-devel@lists.openembedded.org;
	Sat, 23 Jul 2011 06:58:44 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 22 Jul 2011 21:54:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,251,1309762800"; d="scan'208";a="31029033"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.14.127])
	by orsmga001.jf.intel.com with ESMTP; 22 Jul 2011 21:54:34 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 22 Jul 2011 21:54:19 -0700
Message-Id: <cover.1311396520.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
Subject: [PATCH 0/8] Hob GUI tweaks and bugfixes
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
X-List-Received-Date: Sat, 23 Jul 2011 04:58:45 -0000

This series contains largely cosmetic and purely GUI related changes to
address some bugs filed against Hob and a few other GUI tweaks.

The following changes since commit abc67ed6921c98ed581f101ec1acc589fd9ce7e9:

  bitbake/utils: Add contains helper function from lib.oe.utils (2011-07-22 12:11:01 +0100)

are available in the git repository at:
  git://github.com/incandescant/bitbake hob
  https://github.com/incandescant/bitbake/tree/hob

Joshua Lock (8):
  hob: refer to tasks as Package Collections
  ui/crumbs/tasklistmodel: don't show native and cross recipes
  ui/hob: clear the search entry when resetting
  ui/hob: if the user clicks Stop a second time only offer 'Force Stop'
  hob: only add new layer's to the UI
  ui/crumbs/hobprefs: set higher arbitrary limit on threads &
    parallelism
  ui/crumbs/hobprefs: tweak the package format tooltip
  hob: rework image output type setting

 lib/bb/ui/crumbs/configurator.py    |   10 ++++--
 lib/bb/ui/crumbs/hobeventhandler.py |   21 +++++++++++-
 lib/bb/ui/crumbs/hobprefs.py        |   60 ++++++++++++++++++++++-------------
 lib/bb/ui/crumbs/layereditor.py     |    5 ++-
 lib/bb/ui/crumbs/tasklistmodel.py   |    3 ++
 lib/bb/ui/hob.py                    |   58 +++++++++++++++++++++------------
 6 files changed, 107 insertions(+), 50 deletions(-)

-- 
1.7.6



