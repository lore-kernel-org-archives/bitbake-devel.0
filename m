Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1SIpzl-0000YB-Oo
	for bitbake-devel@lists.openembedded.org;
	Sat, 14 Apr 2012 01:33:37 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 13 Apr 2012 16:24:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="130756356"
Received: from unknown (HELO shamshir.amr.corp.intel.com) ([10.255.12.191])
	by azsmga001.ch.intel.com with ESMTP; 13 Apr 2012 16:24:12 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 13 Apr 2012 16:24:06 -0700
Message-Id: <cover.1334359238.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.7.6
Subject: [PATCH 0/4] Replace HobNotebook with gtk.Notebook, comments invited
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
X-List-Received-Date: Fri, 13 Apr 2012 23:33:38 -0000

*** This series prevents users of distros with old Gtk+ releases using Hob ***

This is a follow-on from my RFC of yesterday with a similar title. Sadly I 
hadn't realised that one of the API calls I am using is not available in the
version of gtk+ shipped with CentOS 6 (gtk.Notebook.set_action_widget).

This change will prevent CentOS 6 users from being able to use Hob.

I spent some time in Gtk+ internals trying to figure out if we can emulate the
behaviour on older versions but the GtkNotebook widget internals were enhanced
significantly to support the set_action_widget API.

I've submitted the change as an RFC regardless, it's ready to merge if we're
willing to make the sacrifice.

The primary motivation for making this change, and making it so late in the
cycle, is maintainability. The diffstat says it all - we're replacing an ~400LOC
custom widget with a ~100LOC set of 3 widgets which subclass standard toolkit
widgets.

An added benefit is that standard toolkit widgets generally integrate better
into the users OS thanks to inheriting their standard theme.

Tested on: 
Fedora 16 (x86_64) - PASS
CentOS 6.2 (x86_64) - FAIL: Gtk+ version too old
Ubuntu 10.04 (x86_64) - Fail: pygtk version too old
Ubuntu 12.04 Beta (x86_64) - PASS

Per the final patch in the series the changes here require gtk+-2.20 or newer
and pygtk 2.22 or newer.

Cheers,
Joshua

The following changes since commit 434fdb3913cc78e2e9cdeede4c4fa7f1c8ef8892:

  Hob: Added required packages for toolchain. (2012-04-13 12:00:12 +0100)

are available in the git repository at:
  git://github.com/incandescant/bitbake gtk2.20
  https://github.com/incandescant/bitbake/tree/gtk2.20

Joshua Lock (4):
  lib/bb/ui/crumbs/: replace custom HobNotebook
  lib/bb/ui/crumbs/hobwidget: use light text in HobIndicator
  lib/bb/ui/crumbs/imageconfiguration: fix combo boxes drop-down width
  hob: update required pygtk to 2.22.0 and gtk+ to 2.20.0

 lib/bb/ui/crumbs/builddetailspage.py       |    6 +-
 lib/bb/ui/crumbs/hobwidget.py              |  499 +++++++---------------------
 lib/bb/ui/crumbs/imageconfigurationpage.py |    2 -
 lib/bb/ui/crumbs/packageselectionpage.py   |    3 +-
 lib/bb/ui/crumbs/recipeselectionpage.py    |    5 +-
 lib/bb/ui/hob.py                           |    2 +-
 6 files changed, 120 insertions(+), 397 deletions(-)

-- 
1.7.7.6



