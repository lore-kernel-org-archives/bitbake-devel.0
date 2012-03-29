Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1SD3On-0007bb-36
	for bitbake-devel@lists.openembedded.org;
	Thu, 29 Mar 2012 02:39:33 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 28 Mar 2012 17:30:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="126325958"
Received: from unknown (HELO shamshir.amr.corp.intel.com) ([10.255.12.73])
	by orsmga002.jf.intel.com with ESMTP; 28 Mar 2012 17:30:29 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 28 Mar 2012 17:30:21 -0700
Message-Id: <cover.1332980606.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.7.6
Subject: [PATCH 0/6] Hob tweaks & fixes
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
X-List-Received-Date: Thu, 29 Mar 2012 00:39:33 -0000

Here are some more minor fixes for Hob, please review and consider for inclusion.

Regards,
Joshua

The following changes since commit f9cf2671c0ecad153db11bca1aebe151213bfb42:

  bb.build: use relative log links, not absolute (2012-03-28 22:28:00 +0100)

are available in the git repository at:
  git://github.com/incandescant/bitbake josh/hob
  https://github.com/incandescant/bitbake/tree/josh/hob

Joshua Lock (6):
  lib/bb/ui/crumbs/hobwidget: add padding to HobImageButton
  lib/bb/ui/crumbs/imageconfigurationpage: add extra space between
    widgets
  lib/bb/ui/crumbs/hobwidget: change text sizes in HobImageButton
  lib/bb/ui/crumbs/builder: allow user to cancel Layer selection
    dialogue
  lib/bb/ui/crumbs: hob progress bar should not be red when user stops
    build
  lib/bb/ui/crumbs/hig: fix layers_changed test

 lib/bb/ui/crumbs/builddetailspage.py       |    2 +-
 lib/bb/ui/crumbs/builder.py                |   25 +++++++++++++++++--------
 lib/bb/ui/crumbs/hig.py                    |    7 +++++--
 lib/bb/ui/crumbs/hobwidget.py              |    6 +++---
 lib/bb/ui/crumbs/imageconfigurationpage.py |    4 ++--
 lib/bb/ui/crumbs/progressbar.py            |    8 +++++---
 6 files changed, 33 insertions(+), 19 deletions(-)

-- 
1.7.7.6



