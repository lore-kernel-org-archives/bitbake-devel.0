Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1Qze0V-0008Rq-80
	for bitbake-devel@lists.openembedded.org;
	Sat, 03 Sep 2011 02:22:47 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 02 Sep 2011 17:17:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.68,321,1312182000"; d="scan'208";a="47755001"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.14.9])
	by fmsmga001.fm.intel.com with ESMTP; 02 Sep 2011 17:17:48 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  2 Sep 2011 17:17:35 -0700
Message-Id: <cover.1315008498.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
Subject: [PATCH 0/6] hob changes for Yocto 1.1
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
X-List-Received-Date: Sat, 03 Sep 2011 00:22:47 -0000

This series addresses issues for the looming Yocto 1.1 code freeze. This
means that the series contains a 3 genuine patches followed by 3
hide my shame patches to disable features which either a) weren't implmented
in time or b) weren't deemed to be stable enough for inclusion in the 1.1
release.

Regards,
Joshua

The following changes since commit 639db8c766cada7180f9447f51303f9b30d7e817:

  fetch2/git: Allow to specify the name of the checkout directory (2011-09-02 14:23:43 +0100)

are available in the git repository at:
  git://github.com/incandescant/bitbake hob
  https://github.com/incandescant/bitbake/tree/hob

Joshua Lock (6):
  hob: use both pre and post files for hob configuration
  hob: reflect defaultsetup being default distro
  hob: add a test to ensure hob is run with the required pre and post
    files
  ui/crumbs/hobprefs: disable 'build toolchain with headers'
  ui/crumbs/runningbuild: mask run_buildstats failure
  hob: disable removal of packages

 lib/bb/ui/crumbs/configurator.py    |   94 +++++++++++++++++++++++-----------
 lib/bb/ui/crumbs/hobeventhandler.py |   11 +++--
 lib/bb/ui/crumbs/hobprefs.py        |   34 ++++++------
 lib/bb/ui/crumbs/runningbuild.py    |    6 ++
 lib/bb/ui/hob.py                    |   69 ++++++++++++++++++-------
 5 files changed, 142 insertions(+), 72 deletions(-)

-- 
1.7.6



