Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1S0ckT-0001sL-MO
	for bitbake-devel@lists.openembedded.org;
	Thu, 23 Feb 2012 18:46:33 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 23 Feb 2012 09:38:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="114093530"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.123.61])
	by orsmga002.jf.intel.com with ESMTP; 23 Feb 2012 09:38:10 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 23 Feb 2012 17:38:06 +0000
Message-Id: <cover.1330018579.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.5.4
Subject: [PATCH 0/2] A couple of fixes to error handling v2
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
X-List-Received-Date: Thu, 23 Feb 2012 17:46:34 -0000

A couple of patches to fix/improve error handling during parsing.

Since v1, remove changes to general exception handling that weren't
necessary and bypassed the ability for the UI to format the exception.

The patches (against poky, but apply cleanly with -p2 against bitbake
master) are available at:
  git://git.yoctoproject.org/poky-contrib paule/bitbake-errors2
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/bitbake-errors2

Paul Eggleton (2):
  bitbake: fix parse errors not being reported
  bitbake: add file and line number to ParseError

 bitbake/lib/bb/cooker.py                     |   12 +++++-------
 bitbake/lib/bb/parse/__init__.py             |   15 +++++++++++++--
 bitbake/lib/bb/parse/ast.py                  |    8 ++++----
 bitbake/lib/bb/parse/parse_py/BBHandler.py   |    6 ++----
 bitbake/lib/bb/parse/parse_py/ConfHandler.py |   11 ++++++-----
 5 files changed, 30 insertions(+), 22 deletions(-)

-- 
1.7.5.4



