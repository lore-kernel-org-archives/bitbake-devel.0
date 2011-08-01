Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QnxG5-0001pg-HH
	for bitbake-devel@lists.openembedded.org;
	Mon, 01 Aug 2011 20:30:33 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 01 Aug 2011 11:26:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,301,1309762800"; d="scan'208";a="34344101"
Received: from vorpal.jf.intel.com ([10.7.199.75])
	by orsmga001.jf.intel.com with ESMTP; 01 Aug 2011 11:26:12 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  1 Aug 2011 11:30:42 -0700
Message-Id: <cover.1312216779.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
Subject: [PATCH 0/8] hob - handle errors more gracefully
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
X-List-Received-Date: Mon, 01 Aug 2011 18:30:33 -0000

This series predominantly focuses on better error handling and keeping the
user informed.

The following changes since commit c9dd2592434338bdddb3cc6f42e760c86fa9e6bb:

  hob: fix save/restore of toolchain preferences (2011-07-28 10:58:07 -0700)

are available in the git repository at:
  git://github.com/incandescant/bitbake hob
  https://github.com/incandescant/bitbake/tree/hob

Joshua Lock (8):
  ui/crumbs/hobeventhandler: remove unused code
  hob: unset busy cursor on exit
  ui/crumbs/hobeventhandler: emit a signal when there's a fatal-error
  ui/hob: show error and exit if we receive the fatal-error signal
  ui/crumbs/hobeventhandler: emit a signal when a command fails
  ui/crumbs/configurator: tweak addLayerConf return values
  ui/crumbs/layereditor: if layer adding fails show an explanatory
    dialog
  hob: remove temporary directory on program shutdown

 lib/bb/ui/crumbs/configurator.py    |    7 ++-
 lib/bb/ui/crumbs/hobeventhandler.py |   72 ++++++++++++++++++++++------------
 lib/bb/ui/crumbs/layereditor.py     |   20 +++++++++-
 lib/bb/ui/hob.py                    |   36 +++++++++++++----
 4 files changed, 97 insertions(+), 38 deletions(-)

-- 
1.7.6



