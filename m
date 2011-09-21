Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1R6AYV-0007Ti-RD
	for bitbake-devel@lists.openembedded.org;
	Wed, 21 Sep 2011 02:20:52 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 20 Sep 2011 17:15:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.68,413,1312182000"; d="scan'208";a="19001150"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.14.183])
	by AZSMGA002.ch.intel.com with ESMTP; 20 Sep 2011 17:15:32 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 20 Sep 2011 17:15:25 -0700
Message-Id: <cover.1316564030.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6.2
Subject: [PATCH 0/1] Fix dumb hob typo
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
X-List-Received-Date: Wed, 21 Sep 2011 00:20:52 -0000

Another case of my submitting patches with a dumb typo in, apologies folks.

The following patch re-enables the right-click menu for the log messages of
failed tasks.

Richard, please consider this for Yocto 1.1 also.

Regards,
Joshua

The following changes since commit 705156e2812afb288632f01416fcbbf9add26bee:

  hob: enable package only builds even if an image has been built (2011-09-19 15:28:09 -0700)

are available in the git repository at:
  git://github.com/incandescant/bitbake hob
  https://github.com/incandescant/bitbake/tree/hob

Joshua Lock (1):
  ui/crumbs/runningbuild: fix log messages right-click menu

 lib/bb/ui/crumbs/runningbuild.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

-- 
1.7.6.2



