Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1R3Voa-0001jT-1I
	for bitbake-devel@lists.openembedded.org;
	Tue, 13 Sep 2011 18:26:28 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 13 Sep 2011 09:21:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.68,375,1312182000"; d="scan'208";a="50818013"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.14.59])
	by fmsmga001.fm.intel.com with ESMTP; 13 Sep 2011 09:21:15 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 13 Sep 2011 09:21:05 -0700
Message-Id: <cover.1315927921.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
Subject: [PATCH 0/4] Various UI fixes related to #1468
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
X-List-Received-Date: Tue, 13 Sep 2011 16:26:28 -0000

Yocto #1468 reports several issues when using the recently fixed build again
functionality of hob. This series includes fixes for each of the issues
reported in that bug.

Regards,
Joshua

The following changes since commit 459addf13721a6847406f215650fa1882fb83ea9:

  runqueue.py: Ensure fakeroot variables are reflected in the datastore (2011-09-09 19:07:45 +0100)

are available in the git repository at:
  git://github.com/incandescant/bitbake uifixes
  https://github.com/incandescant/bitbake/tree/uifixes

Joshua Lock (4):
  ui/crumbs/hobeventhandler: fix test for BBFILES
  ui/crumbs/hobeventhandler: don't check BBPATH and BBFILES each build
  hob: correctly handle an exception
  hob: correctly set the selected image when loading a recipe

 lib/bb/ui/crumbs/hobeventhandler.py |   42 +++++++++++++++++-----------------
 lib/bb/ui/hob.py                    |    7 +++++-
 2 files changed, 27 insertions(+), 22 deletions(-)

-- 
1.7.6



