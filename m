Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1Qs2cm-0000SE-Ex
	for bitbake-devel@lists.openembedded.org;
	Sat, 13 Aug 2011 03:03:04 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 12 Aug 2011 17:58:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,365,1309762800"; d="scan'208";a="39013847"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.15.3])
	by fmsmga002.fm.intel.com with ESMTP; 12 Aug 2011 17:58:18 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 12 Aug 2011 17:58:10 -0700
Message-Id: <cover.1313196998.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
Subject: [RFC PATCH 0/1] Don't include cleaned variables in inherited environment
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
X-List-Received-Date: Sat, 13 Aug 2011 01:03:07 -0000

Per James Limbouris' report the pristine, saved environment is erroneously
added to the data store. This patch fixes this bug by passing a list of the
permitted variables to the inheritFromOS method and only inheriting those
which appear in the approved list.

Please review the following changes for suitability for inclusion. If you have
any objections or suggestions for improvement, please respond to the patches. If
you agree with the changes, please provide your Acked-by.

The following changes since commit b3ad7acebfad3063c3364f4492f53b25bf53cf81:

  lib/bb/ui/crumbs/hobprefs: fix erroneous save/reparse (2011-08-12 17:48:13 +0100)

are available in the git repository at:
  git://github.com/incandescant/bitbake env
  https://github.com/incandescant/bitbake/tree/env

Joshua Lock (1):
  Ensure only the filtered environment variables are inherited from the
    OS

 bin/bitbake-layers |    6 +++---
 lib/bb/cooker.py   |    3 ++-
 lib/bb/data.py     |   15 ++++++++-------
 lib/bb/utils.py    |   23 ++++++++++++++++-------
 4 files changed, 29 insertions(+), 18 deletions(-)

-- 
1.7.6



