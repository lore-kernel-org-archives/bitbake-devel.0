Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QoQ9x-0006Dn-H6
	for bitbake-devel@lists.openembedded.org;
	Wed, 03 Aug 2011 03:22:09 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 02 Aug 2011 18:17:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,307,1309762800"; d="scan'208";a="33627957"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.13.215])
	by orsmga002.jf.intel.com with ESMTP; 02 Aug 2011 18:17:46 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  2 Aug 2011 18:17:33 -0700
Message-Id: <cover.1312334047.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
Subject: [PATCH 0/6] hob bug fixes
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
X-List-Received-Date: Wed, 03 Aug 2011 01:22:09 -0000

This includes fixes for some usability quirks in hob. The shared runningbuild
component has had its behaviour modified and most of this series deals with
adding machinery to optionally enable the old behaviour and then doing so for
the hob.

The following changes since commit 1009ca570a750a00b0e60afcc30ead070c7b310a:

  hob: remove temporary directory on program shutdown (2011-07-30 12:21:18 -0700)

are available in the git repository at:
  git://github.com/incandescant/bitbake hob
  https://github.com/incandescant/bitbake/tree/hob

Joshua Lock (6):
  bb/ui/hob: save changes to bblayers.conf when using Add Layer menu
    item
  bb/ui/crumbs/runningbuild: optionally create list entries
    sequentially
  bb/ui/hob: show build messages are displayed in the order they're
    received
  ui/crumbs/runningbuild: add optional readonly mode, default off
  bb/ui/hob: disable editing in the build messages tree view
  bb/ui/crumbs/runningbuild: emit signal when command fails with exit
    signal

 lib/bb/ui/crumbs/runningbuild.py |   48 +++++++++++++++++++++++--------------
 lib/bb/ui/hob.py                 |    5 ++-
 2 files changed, 33 insertions(+), 20 deletions(-)

-- 
1.7.6



