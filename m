Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <lianhao.lu@intel.com>) id 1Rme0Z-0007f8-PC
	for bitbake-devel@lists.openembedded.org;
	Mon, 16 Jan 2012 05:17:23 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 15 Jan 2012 20:09:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="96176011"
Received: from llu-piketon.sh.intel.com (HELO localhost) ([10.239.36.146])
	by azsmga001.ch.intel.com with ESMTP; 15 Jan 2012 20:09:46 -0800
From: Lianhao Lu <lianhao.lu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 16 Jan 2012 12:07:41 +0800
Message-Id: <cover.1326686612.git.lianhao.lu@intel.com>
X-Mailer: git-send-email 1.7.0.4
Subject: [PATCH 0/1] persist_data: reconnect when DB is locked
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
X-List-Received-Date: Mon, 16 Jan 2012 04:17:24 -0000

Fixed yocto bug #1761.

The timeout value set in sqlite3 connection only applies to the very first 
time when accessing a locked DB file.

By reconnect to the DB in 'database is locked' exception, we can leverage 
the timeout value in each retry. 

The following changes since commit 684c6ef2d08ad503ce68ac3cc273f1b6a8a56ac7:
  Paul Eggleton (1):
        bitbake/knotty: print task failure summary

are available in the git repository at:

  git://git.pokylinux.org/poky-contrib llu/bug1761
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=llu/bug1761

Lianhao Lu (1):
  bitbake/persist_data: Reconnect when DB is locked

 bitbake/lib/bb/persist_data.py |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)



