Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <ddalex@intel.com>) id 1UXAQO-0004D7-Dd
	for bitbake-devel@lists.openembedded.org;
	Tue, 30 Apr 2013 15:17:22 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 30 Apr 2013 05:57:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,580,1363158000"; d="scan'208";a="330101103"
Received: from adamian-desktop.rb.intel.com ([10.237.224.34])
	by fmsmga002.fm.intel.com with ESMTP; 30 Apr 2013 05:57:54 -0700
Received: by adamian-desktop.rb.intel.com (Postfix, from userid 1000)
	id D4D5956012C; Tue, 30 Apr 2013 13:57:56 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org, richard.purdie@linuxfoundation.org,
	paul.eggleton@linux.intel.com, andrei.adrianx.dinu@intel.com,
	bogdan.a.marinescu@intel.com
Date: Tue, 30 Apr 2013 13:57:53 +0100
Message-Id: <1367326675-18037-1-git-send-email-alexandru.damian@intel.com>
X-Mailer: git-send-email 1.7.10.4
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 0/2] refactoring bb.server code
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
X-List-Received-Date: Tue, 30 Apr 2013 13:17:37 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patchset refactors the bitbake server code as to use proper class
inheritance, minimize code copy-pasta and maximize cod reuse.
By creating a unified interface to server code I expect easier future 
development and minimizing the number of code changes for bug fixes.  

Alexandru DAMIAN (2):
  bitbake server: create common server infrastructure
  bitbake servers: use common server infrastructure

 bitbake/lib/bb/server/__init__.py |   95 +++++++++++++++++++++++++++++++++++++
 bitbake/lib/bb/server/none.py     |   38 +++++----------
 bitbake/lib/bb/server/process.py  |   54 ++++++++-------------
 bitbake/lib/bb/server/xmlrpc.py   |   40 +++++-----------
 4 files changed, 139 insertions(+), 88 deletions(-)

-- 
1.7.10.4



