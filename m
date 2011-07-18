Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QiwN1-0000HH-0G
	for bitbake-devel@lists.openembedded.org;
	Tue, 19 Jul 2011 00:32:59 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 18 Jul 2011 15:28:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,224,1309762800"; d="scan'208";a="29127438"
Received: from vorpal.jf.intel.com ([10.7.199.64])
	by orsmga001.jf.intel.com with ESMTP; 18 Jul 2011 15:28:53 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 18 Jul 2011 15:33:16 -0700
Message-Id: <cover.1311028023.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
Subject: [RFC PATCH 0/1] Save the initial environment
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
X-List-Received-Date: Mon, 18 Jul 2011 22:32:59 -0000

Both Chris' terminal work and my reparse command will benefit from a saved
copy of the initial enviornment. The Python docs indicate that the os.environ
map is captured when the os module is first imported
http://docs.python.org/library/os.html#os.environ) so this patch adds a
variable to the bb namespace (bb.initial_environ) that is an early copy of
the environment.

I put the variable here so that a) it's easily accessible and b) we can take
the copy pretty early on.

Any thoughts on this? Note the RFC prefix. :-)

Thanks,

Joshua

Please review the following changes for suitability for inclusion. If you have
any objections or suggestions for improvement, please respond to the patches. If
you agree with the changes, please provide your Acked-by.

The following changes since commit 5c8eeefc79455f058dda8f04cf4c12dc5418e00f:

  cooker: only return *Found events if something was actually found (2011-07-14 15:12:40 +0100)

are available in the git repository at:
  git://github.com/incandescant/bitbake initialenv
  https://github.com/incandescant/bitbake/tree/initialenv

Joshua Lock (1):
  lib/bb: preserve a copy of the initial environment variables

 lib/bb/__init__.py |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

-- 
1.7.6



