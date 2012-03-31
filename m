Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1SDmts-0004o1-DK
	for bitbake-devel@lists.openembedded.org;
	Sat, 31 Mar 2012 03:14:40 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 30 Mar 2012 18:05:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="148061239"
Received: from unknown (HELO shamshir.amr.corp.intel.com) ([10.255.15.226])
	by fmsmga002.fm.intel.com with ESMTP; 30 Mar 2012 18:05:34 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 30 Mar 2012 18:05:28 -0700
Message-Id: <cover.1333155656.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.7.6
Subject: [PATCH 0/1] Error gracefully on systems which don't support Hob
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
X-List-Received-Date: Sat, 31 Mar 2012 01:14:40 -0000

Hob requires pygtk 2.22 or later and systems without that will see a Python 
backtrace. 
This small change tests whether pygtk is installed and tests which version of it
is available and prints an error if pytgtk is missing or too low a version.

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

 lib/bb/ui/hob.py |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

-- 
1.7.7.6



