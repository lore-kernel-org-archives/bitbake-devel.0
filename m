Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1Qo1oU-0004Up-GC
	for bitbake-devel@lists.openembedded.org;
	Tue, 02 Aug 2011 01:22:22 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 01 Aug 2011 16:18:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,303,1309762800"; d="scan'208";a="34428702"
Received: from vorpal.jf.intel.com ([10.7.199.75])
	by orsmga001.jf.intel.com with ESMTP; 01 Aug 2011 16:18:00 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  1 Aug 2011 16:22:37 -0700
Message-Id: <cover.1312240827.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
Subject: [RFC PATCH 0/1] Tracking parsed configuration files v2
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
X-List-Received-Date: Mon, 01 Aug 2011 23:22:22 -0000

Since v1 I've switched to hooking into the parser itself and storeing a list
of parsed configuration files as the parsing happens.

Hopefully a little less ugly and certainly a lot less hacky than the last
attempt.

Please review the following changes for suitability for inclusion. If you have
any objections or suggestions for improvement, please respond to the patches. If
you agree with the changes, please provide your Acked-by.

The following changes since commit c9dd2592434338bdddb3cc6f42e760c86fa9e6bb:

  hob: fix save/restore of toolchain preferences (2011-07-28 10:58:07 -0700)

are available in the git repository at:
  git://github.com/incandescant/bitbake configfiles
  https://github.com/incandescant/bitbake/tree/configfiles

Joshua Lock (1):
  cooker: store a list of parsed configuration files

 lib/bb/cooker.py                     |    3 +++
 lib/bb/parse/parse_py/ConfHandler.py |    3 +++
 2 files changed, 6 insertions(+), 0 deletions(-)

-- 
1.7.6



