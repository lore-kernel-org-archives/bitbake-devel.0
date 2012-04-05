Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1SFraF-0001mp-1o
	for bitbake-devel@lists.openembedded.org;
	Thu, 05 Apr 2012 20:39:01 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 05 Apr 2012 11:29:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="129138834"
Received: from unknown (HELO shamshir.amr.corp.intel.com) ([10.255.12.114])
	by orsmga002.jf.intel.com with ESMTP; 05 Apr 2012 11:29:40 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  5 Apr 2012 11:29:35 -0700
Message-Id: <cover.1333650445.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.7.6
Subject: [PATCH 0/3] Changes to ensure Hob can be run on CentOS 6
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
X-List-Received-Date: Thu, 05 Apr 2012 18:39:02 -0000

The following series contains changes to ensure Hob can be used on CentOS 6,
that is Gtk+ 2.18.9 and PyGtk 2.16.0.

To achieve this I've replaced calls to convenience API which was only introduced
with Gtk+ 2.22 and lowered the versions of Gtk+ and PyGtk we test for in the
Hob GUI.

Tested on CentOS 6.2

Cheers,
Joshua

The following changes since commit d49db15badb77855cef855ee73430fcbc16b6916:

  Hob: a minor fix on pmake (2012-04-05 18:47:37 +0100)

are available in the git repository at:
  git://github.com/incandescant/bitbake josh/hob-centos6
  https://github.com/incandescant/bitbake/tree/josh/hob-centos6

Joshua Lock (3):
  lib/bb/ui/crumbs/persistenttooltip: replace 2.22 API
  lib/bb/ui/crumbs/hobwidget: replace new API
  hob: update required versions of (py)gtk et al

 lib/bb/ui/crumbs/hobwidget.py         |    2 +-
 lib/bb/ui/crumbs/persistenttooltip.py |    2 +-
 lib/bb/ui/hob.py                      |   11 +++++++----
 3 files changed, 9 insertions(+), 6 deletions(-)

-- 
1.7.7.6



