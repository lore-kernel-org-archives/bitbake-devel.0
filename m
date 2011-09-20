Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1R61uo-0000rF-5s
	for bitbake-devel@lists.openembedded.org;
	Tue, 20 Sep 2011 17:07:18 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 20 Sep 2011 08:01:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.68,411,1312182000"; d="scan'208";a="18826186"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.14.183])
	by AZSMGA002.ch.intel.com with ESMTP; 20 Sep 2011 08:01:58 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 20 Sep 2011 08:01:48 -0700
Message-Id: <cover.1316530819.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6.2
Subject: [PATCH 0/3] Various hob fixes
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
X-List-Received-Date: Tue, 20 Sep 2011 15:07:18 -0000

This series contains 3 bug fixes.

The first has been submitted previously but hasn't been applied or commented
on so I've rolled it into this pull request.

Patch one and two contain bug fixes for reported issues, patch three is a
minor change but a noticable one should one stumble accross it.

Please review and consider for master and the Yocto 1.1 release.

Regards,
Joshua

The following changes since commit 3e7f8afeacf7c8c8de3e87778a3907e33d4a06b3:

  fetch2/git: fix subpath destination directory (2011-09-19 12:33:38 +0100)

are available in the git repository at:
  git://github.com/incandescant/bitbake hob
  https://github.com/incandescant/bitbake/tree/hob

Joshua Lock (3):
  ui/crumbs/hobprefs: re-enable reloading of data after prefs changes
  hob: fix build again when building packages only
  hob: enable package only builds even if an image has been built

 lib/bb/ui/crumbs/hobeventhandler.py |   13 +++++--------
 lib/bb/ui/crumbs/hobprefs.py        |    2 +-
 lib/bb/ui/hob.py                    |   12 ++++++++----
 3 files changed, 14 insertions(+), 13 deletions(-)

-- 
1.7.6.2



