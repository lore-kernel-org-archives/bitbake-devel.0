Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1Qlw4n-0004Bm-9W
	for bitbake-devel@lists.openembedded.org;
	Wed, 27 Jul 2011 06:50:33 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 26 Jul 2011 21:46:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,273,1309762800"; d="scan'208";a="30529114"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.14.163])
	by orsmga002.jf.intel.com with ESMTP; 26 Jul 2011 21:46:18 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 26 Jul 2011 21:46:08 -0700
Message-Id: <cover.1311741742.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
Subject: [RFC PATCH 0/3] Tracking parsed configuration files
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
X-List-Received-Date: Wed, 27 Jul 2011 04:50:33 -0000

All,

This series attempts to address Yocto bug 1246: "Configuration changes could
be saved to a file the cooker isn't using".

It's an ugly series and the issue will only present itself if users run the
UI trough alternative ways. My main issue is that we can't easily track all
loaded conf files at parseConfigurationFiles time so it feels a little
brittle.

Thoughts? Comments?

Regards,
Joshua

Please review the following changes for suitability for inclusion. If you have
any objections or suggestions for improvement, please respond to the patches. If
you agree with the changes, please provide your Acked-by.

The following changes since commit 2650be190afc05f9472aca8b11af99205a342838:

  ui/crumbs/tasklistmodel: fix loading a saved recipe (2011-07-26 09:42:28 -0700)

are available in the git repository at:
  git://github.com/incandescant/bitbake configfiles
  https://github.com/incandescant/bitbake/tree/configfiles

Joshua Lock (3):
  cooker: track conf files parsed outside of the usual bitbake.conf
    inclusion
  cooker|event: notify if pre/post file in ConfigFilePathFound event
  ui/crumbs/[hobeventhandler|configurator]: don't use unparsed files

 lib/bb/cooker.py                    |   10 +++++++++-
 lib/bb/event.py                     |    3 ++-
 lib/bb/ui/crumbs/configurator.py    |    8 ++++----
 lib/bb/ui/crumbs/hobeventhandler.py |    6 ++++--
 4 files changed, 19 insertions(+), 8 deletions(-)

-- 
1.7.6



