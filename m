Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1Qk1wo-00034c-5o
	for bitbake-devel@lists.openembedded.org;
	Fri, 22 Jul 2011 00:42:26 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 21 Jul 2011 15:38:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,244,1309762800"; d="scan'208";a="30545298"
Received: from vorpal.jf.intel.com ([10.7.199.57])
	by orsmga001.jf.intel.com with ESMTP; 21 Jul 2011 15:38:10 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 21 Jul 2011 15:42:36 -0700
Message-Id: <cover.1311287980.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
Subject: [RFC PATCH 0/1] Save the initial environment v2
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
X-List-Received-Date: Thu, 21 Jul 2011 22:42:26 -0000

Here's a second attempt at a patch to store the initial environment before
BitBake cleans it out. We take a copy in the bitbake entry point and pass it
to the cooker for saving.

I've give the parameter to the init method a default, None, value mostly so
that the bitbake-layers script doesn't have to be updated to pass None.

Please review the following changes for suitability for inclusion. If you have
any objections or suggestions for improvement, please respond to the patches. If
you agree with the changes, please provide your Acked-by.

The following changes since commit df55199209ef042e5b1ca04c4df75c7d639b51eb:

  Remove unused target tree data for Hob (2011-07-21 22:36:28 +0100)

are available in the git repository at:
  git://github.com/incandescant/bitbake initialenv
  https://github.com/incandescant/bitbake/tree/initialenv

Joshua Lock (1):
  bitbake|cooker: save a copy of the environment when BitBake is
    started

 bin/bitbake      |    5 ++++-
 lib/bb/cooker.py |    7 ++++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

-- 
1.7.6



