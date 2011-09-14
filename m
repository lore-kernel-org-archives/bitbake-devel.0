Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1R3z4Q-00061P-PD
	for bitbake-devel@lists.openembedded.org;
	Thu, 15 Sep 2011 01:40:46 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 14 Sep 2011 16:35:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="48529301"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.14.158])
	by orsmga002.jf.intel.com with ESMTP; 14 Sep 2011 16:35:34 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 14 Sep 2011 16:35:27 -0700
Message-Id: <cover.1316043111.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
Subject: [PATCH 0/1] Re-enable custom preference dialog responder
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
X-List-Received-Date: Wed, 14 Sep 2011 23:40:47 -0000

When disabling code in an earlier commit[1] I'd accidentally disabled the custom
response callback that forced a re-parse after changing certain preferences.

The following patch re-enables this code.

Regards,
Joshua

1. http://git.openembedded.org/cgit.cgi/bitbake/commit/?id=3157967d08266b8d1ac563ba609ac3027b60d040

The following changes since commit f4be83aae77a713e2b5a2d094651639b6e641031:

  hob: correctly set the selected image when loading a recipe (2011-09-13 08:30:49 -0700)

are available in the git repository at:
  git://github.com/incandescant/bitbake hob
  https://github.com/incandescant/bitbake/tree/hob

Joshua Lock (1):
  ui/crumbs/hobprefs: re-enable reloading of data after prefs changes

 lib/bb/ui/crumbs/hobprefs.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

-- 
1.7.6



