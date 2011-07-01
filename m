Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QcWtP-0007r2-27
	for bitbake-devel@lists.openembedded.org;
	Fri, 01 Jul 2011 08:07:55 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 30 Jun 2011 23:03:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.65,456,1304319600"; d="scan'208";a="21321687"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.13.228])
	by azsmga001.ch.intel.com with ESMTP; 30 Jun 2011 23:03:04 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 30 Jun 2011 23:02:46 -0700
Message-Id: <cover.1309499227.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.5.4
Subject: [PATCH 00/10] Hob - BitBake GUI
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
X-List-Received-Date: Fri, 01 Jul 2011 06:07:55 -0000

All,

This series are the current state of the image creator project I have been
working on for the past few months.
It's by no means perfect but I'd love to get some review and preferably move
development into master, rather than a less public branch.

The first 7 patches are changes to BitBake to be used by the GUI whilst the
final patch is a squashed patch of my image creator development tree[1].

Of course, before sending this pull request I ran some final tests and
encountered a significant problem with the implementation approach.
Images are built by first using the buildTargets command to build all of the
target dependencies then creating a recipe file and using the buildFile
command to handle the build.
The problem is that if you have a clean build directory, perfectly reasonable
with such a tool, the buildFile command does not handle the native
dependencies added by the image class.

The alternative I have is to save the image files somewhere within BBPATH,
and perhaps suggest the user create a "workspace" layer, and build them with
buildTargets. I didn't do this because I'd rather not pollute the users file
system without good cause. It may be the only tenable approach though.

Any suggestions here?

Regards,
Joshua

1. https://github.com/incandescant/bitbake/commits/hob-full

The following changes since commit 5d41720d1550c04aac76275614ca15110c1c7f52:

  Update version to 1.13.2 (2011-06-28 15:27:14 +0100)

are available in the git repository at:
  git://github.com/incandescant/bitbake hob
  https://github.com/incandescant/bitbake/tree/hob

Joshua Lock (8):
  command|cooker: allow generating targets tree for specified pkgs
  cooker: add generic method to locate configuration files
  command|cooker|event: add findConfigFilePath command
  cooker|command|event: add new command findFilesMatchingInDir
  bitbake: add -R option for loading configuration files after
    bitbake.conf
  cooker: switch to new universe target rather than world
  cooker: remove code duplication in non trivial functions
  hob: re-designed interaction and implementation

Lianhao Lu (1):
  ui/hob: Fixed the "build again" hang.

Liping Ke (1):
  bitbake: Make bitbake server type configurable.

 bin/bitbake                         |   30 +-
 lib/bb/command.py                   |   34 ++-
 lib/bb/cooker.py                    |  113 +++--
 lib/bb/event.py                     |   18 +
 lib/bb/ui/crumbs/configurator.py    |  278 +++++++++++
 lib/bb/ui/crumbs/hig.py             |   61 +++
 lib/bb/ui/crumbs/hobeventhandler.py |  218 +++++++--
 lib/bb/ui/crumbs/hobprefs.py        |  293 +++++++++++
 lib/bb/ui/crumbs/layereditor.py     |  136 +++++
 lib/bb/ui/crumbs/runningbuild.py    |   12 +-
 lib/bb/ui/crumbs/tasklistmodel.py   |  306 +++++++++---
 lib/bb/ui/hob.py                    |  925 +++++++++++++++++++++++------------
 12 files changed, 1939 insertions(+), 485 deletions(-)
 create mode 100644 lib/bb/ui/crumbs/configurator.py
 create mode 100644 lib/bb/ui/crumbs/hig.py
 create mode 100644 lib/bb/ui/crumbs/hobprefs.py
 create mode 100644 lib/bb/ui/crumbs/layereditor.py

-- 
1.7.5.4



