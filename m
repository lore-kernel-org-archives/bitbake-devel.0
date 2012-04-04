Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1SFELM-0007WZ-S1
	for bitbake-devel@lists.openembedded.org;
	Wed, 04 Apr 2012 02:45:01 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 03 Apr 2012 17:35:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="137319124"
Received: from unknown (HELO shamshir.amr.corp.intel.com) ([10.255.12.117])
	by fmsmga001.fm.intel.com with ESMTP; 03 Apr 2012 17:35:42 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  3 Apr 2012 17:35:40 -0700
Message-Id: <cover.1333499343.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.7.6
Subject: [PATCH 0/1] Warn users if they don't have the required modules for Hob v2
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
X-List-Received-Date: Wed, 04 Apr 2012 00:45:01 -0000

A second version of this change, to notify the user as to the missing requirements
rather than issuing a backtrace if they don't have the right versions, or required
modules, to run hob.

Cheers,
Joshua

The following changes since commit 035e146ff92236a3eda71ad71e8389737f91753b:

  Hob: In building log page, fixed the issue about 'endpath' not clear when next to start build (2012-03-30 17:19:35 +0100)

are available in the git repository at:
  git://github.com/incandescant/bitbake josh/hob
  https://github.com/incandescant/bitbake/tree/josh/hob

Joshua Lock (1):
  lib/bb/ui/hob: exit cleanly if the required pygtk version isn't
    available

 lib/bb/ui/hob.py |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

-- 
1.7.7.6



