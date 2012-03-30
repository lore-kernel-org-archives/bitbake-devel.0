Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SDXbZ-0007ah-3W
	for bitbake-devel@lists.openembedded.org;
	Fri, 30 Mar 2012 10:54:45 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 30 Mar 2012 01:45:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="147793056"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by fmsmga002.fm.intel.com with ESMTP; 30 Mar 2012 01:45:38 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 30 Mar 2012 17:12:37 +0800
Message-Id: <cover.1333098599.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
Subject: [PATCH 0/2] Hob: bug fixes
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
X-List-Received-Date: Fri, 30 Mar 2012 08:54:45 -0000

Fixes include:
 - a fix on build detail screen
 - a fix for finish_now() in runqueue.py

The following changes since commit bcd4d14425cadc5bd6296f59f14733e8c39c49dd:

  libc-packgae.bbclass: Add i686 support in locale_arch_options (2012-03-29 22:57:30 +0100)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib shane/hob
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=shane/hob

Liming An (1):
  Hob: In building log page, fixed the issue about 'endpath' not clear
    when next to start build

Shane Wang (1):
  runqueue: wait and deal with those <defunct> sub-processes as soon as
    they are os.killed() when "Force stop"

 bitbake/lib/bb/runqueue.py                   |    1 +
 bitbake/lib/bb/ui/crumbs/builddetailspage.py |    4 +++-
 2 files changed, 4 insertions(+), 1 deletions(-)

-- 
1.7.6



