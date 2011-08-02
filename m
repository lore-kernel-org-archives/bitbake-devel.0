Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QoK80-0002Ie-M9
	for bitbake-devel@lists.openembedded.org;
	Tue, 02 Aug 2011 20:55:44 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 02 Aug 2011 11:51:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,307,1309762800"; d="scan'208";a="37170043"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.13.215])
	by fmsmga001.fm.intel.com with ESMTP; 02 Aug 2011 11:51:22 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  2 Aug 2011 11:51:14 -0700
Message-Id: <cover.1312310554.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
Subject: [PATCH 0/2] Store a list of parsed configuration files
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
X-List-Received-Date: Tue, 02 Aug 2011 18:55:45 -0000

This series addresses Yocto #1246 "Configuration changes could be saved to a
file the cooker isn't using" by having the parser store a list of
configuration files it has parsed in the data object and then switching the
cooker to verify against this list that the found file was parsed before
emitting the ConfigFilePathFound event.

The following changes since commit 1009ca570a750a00b0e60afcc30ead070c7b310a:

  hob: remove temporary directory on program shutdown (2011-07-30 12:21:18 -0700)

are available in the git repository at:
  git://github.com/incandescant/bitbake configfiles
  https://github.com/incandescant/bitbake/tree/configfiles

Joshua Lock (2):
  bb/parse: track parsed configuration files in __BB_PARSED_CONF
  bb/cooker: only emit ConfigFilePathFound for files which were parsed

 lib/bb/cooker.py                     |   18 +++++++++++++++++-
 lib/bb/parse/__init__.py             |   12 +++++++++++-
 lib/bb/parse/parse_py/ConfHandler.py |    2 ++
 3 files changed, 30 insertions(+), 2 deletions(-)

-- 
1.7.6



