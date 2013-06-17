Return-Path: <ddalex@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id A6DCA60912
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 17 Jun 2013 11:11:56 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga101.jf.intel.com with ESMTP; 17 Jun 2013 04:11:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,880,1363158000"; d="scan'208";a="351009226"
Received: from adamian-desktop.isw.intel.com (HELO
	adamian-desktop.rb.intel.com) ([10.237.224.34])
	by fmsmga001.fm.intel.com with ESMTP; 17 Jun 2013 04:12:31 -0700
Received: by adamian-desktop.rb.intel.com (Postfix, from userid 1000)
	id 9116356022C; Mon, 17 Jun 2013 12:11:56 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org,
	richard.purdie@linuxfoundation.org
Date: Mon, 17 Jun 2013 12:11:50 +0100
Message-Id: <1371467513-3746-1-git-send-email-alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 0/3] Bitbake XMLRPC resident server addons
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 17 Jun 2013 11:11:57 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Hi,

I am adding three patches to finish up a set that will allow Bitbake 
server to remain resident while accessible through a XMLRPC connection.

First patch allows a knotty observer client to connect to a Bitbake 
server and receive progress events as to display updates from server
activity. 

Second patch allows knotty to terminate a remote server, as currently
the only option to get a clean shutdown.

Third patch sets a shortcut to specify the address of a remote server
through an environment variable instead of command line parameters,
for ease of use and brevity.

Cheers,
Alex

Alexandru DAMIAN (3):
  knotty, xmlrpc: add observer-only mode
  knotty, bitbake: add option to terminate a remote server
  bitbake: read BBSERVER environement for remote server

 bin/bitbake             | 20 +++++++++++++++++++-
 lib/bb/command.py       |  7 ++++++-
 lib/bb/server/xmlrpc.py | 26 ++++++++++++++++++--------
 lib/bb/ui/knotty.py     | 33 +++++++++++++++++++++------------
 lib/bb/ui/uievent.py    |  1 +
 5 files changed, 65 insertions(+), 22 deletions(-)

-- 
1.8.1.2


