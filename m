Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QwJgJ-0007t8-PG
	for bitbake-devel@lists.openembedded.org;
	Wed, 24 Aug 2011 22:04:11 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 24 Aug 2011 12:59:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="41532547"
Received: from vorpal.jf.intel.com ([10.7.199.155])
	by orsmga002.jf.intel.com with ESMTP; 24 Aug 2011 12:59:24 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 24 Aug 2011 13:04:22 -0700
Message-Id: <cover.1314216131.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
Subject: [PATCH 0/1] Add checkstatus command to the git fetcher
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
X-List-Received-Date: Wed, 24 Aug 2011 20:04:12 -0000

I'd like to use the fetcher's checkstatus method in the network sanity check
of OpenEmbedded Core, to that end I've implemented the checkstatus method
for the git fetcher using the ls-remote sub-command of git.

The following changes since commit 692c2fcead5c82249359ad54d2c7941d087a2eb3:

  usermanual: The git fetcher defaults to the git protocol (or file) (2011-08-23 09:59:50 -0700)

are available in the git repository at:
  git://github.com/incandescant/bitbake fetch
  https://github.com/incandescant/bitbake/tree/fetch

Joshua Lock (1):
  bb/fetch2/git: add checkstatus command

 lib/bb/fetch2/git.py |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

-- 
1.7.6



