Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QmV6N-0001Ja-R6
	for bitbake-devel@lists.openembedded.org;
	Thu, 28 Jul 2011 20:14:32 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 28 Jul 2011 11:10:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,283,1309762800"; d="scan'208";a="33431820"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.14.108])
	by fmsmga002.fm.intel.com with ESMTP; 28 Jul 2011 11:10:15 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 28 Jul 2011 11:10:01 -0700
Message-Id: <cover.1311876523.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
Subject: [PATCH 0/2] Hob preference fixes
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
X-List-Received-Date: Thu, 28 Jul 2011 18:14:32 -0000

Fixes some Yocto bugs reported agains the preferences window.

The following changes since commit eea5ff9f34bb9b2e29f5fa43deb80d4aa6ef7ddc:

  bitbake/providers: list PREFERRED_VERSION candidates when unavailable (2011-07-27 16:53:47 +0100)

are available in the git repository at:
  git://github.com/incandescant/bitbake hob
  https://github.com/incandescant/bitbake/tree/hob

Joshua Lock (2):
  hob: more reliable disabling of GPLv3 packages
  hob: fix save/restore of toolchain preferences

 lib/bb/ui/crumbs/configurator.py    |   25 +++++++++++++++++++++--
 lib/bb/ui/crumbs/hobeventhandler.py |   10 +-------
 lib/bb/ui/crumbs/hobprefs.py        |   36 +++++++++++++++++++++++++++++-----
 lib/bb/ui/hob.py                    |   11 +++++++++-
 4 files changed, 64 insertions(+), 18 deletions(-)

-- 
1.7.6



