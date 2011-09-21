Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1R6BSf-0000IM-5r
	for bitbake-devel@lists.openembedded.org;
	Wed, 21 Sep 2011 03:18:53 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 20 Sep 2011 18:13:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.68,414,1312182000"; d="scan'208";a="53811750"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.14.183])
	by fmsmga001.fm.intel.com with ESMTP; 20 Sep 2011 18:13:33 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 20 Sep 2011 18:13:25 -0700
Message-Id: <cover.1316567365.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6.2
Subject: [PATCH 0/2] Hob fixes
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
X-List-Received-Date: Wed, 21 Sep 2011 01:18:53 -0000

The first patch is another case of my submitting patches with a dumb typo in,
apologies folks, it re-enables the right-click menu for the log messages of
failed tasks.

The second patch fixes the consistency and the URI of the 'Browse folder of
built images" label.

Richard, please consider these for Yocto 1.1 as well as master.

Regards,
Joshua

The following changes since commit 705156e2812afb288632f01416fcbbf9add26bee:

  hob: enable package only builds even if an image has been built (2011-09-19 15:28:09 -0700)

are available in the git repository at:
  git://github.com/incandescant/bitbake hob
  https://github.com/incandescant/bitbake/tree/hob

Joshua Lock (2):
  ui/crumbs/runningbuild: fix log messages right-click menu
  hob: fix opening of image output dir on image build completion

 lib/bb/ui/crumbs/hobeventhandler.py |    5 ++++-
 lib/bb/ui/crumbs/runningbuild.py    |    8 ++++----
 2 files changed, 8 insertions(+), 5 deletions(-)

-- 
1.7.6.2



