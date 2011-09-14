Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1R3yDv-00054t-EV
	for bitbake-devel@lists.openembedded.org;
	Thu, 15 Sep 2011 00:46:31 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 14 Sep 2011 15:41:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.68,383,1312182000"; d="scan'208";a="48915610"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.14.158])
	by azsmga001.ch.intel.com with ESMTP; 14 Sep 2011 15:41:04 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 14 Sep 2011 15:40:57 -0700
Message-Id: <cover.1316039862.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
Subject: [PATCH 0/1] Quieten wet fetchers checkstatus method
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
X-List-Received-Date: Wed, 14 Sep 2011 22:46:31 -0000

This patch ensures that the checkstatus() method of the wget fetcher calls runfetchcmd() in
quiet mode which prevents wget's noisy stdout being printed to the users console.

Regards,
Joshua

The following changes since commit f4be83aae77a713e2b5a2d094651639b6e641031:

  hob: correctly set the selected image when loading a recipe (2011-09-13 08:30:49 -0700)

are available in the git repository at:
  git://github.com/incandescant/bitbake sanity
  https://github.com/incandescant/bitbake/tree/sanity

Joshua Lock (1):
  fetch2/wget: make checkstatus() quieter

 lib/bb/fetch2/wget.py |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

-- 
1.7.6



