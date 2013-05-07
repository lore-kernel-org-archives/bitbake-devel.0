Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <cristiana.voicu@intel.com>) id 1UZdCP-0000af-7H
	for bitbake-devel@lists.openembedded.org;
	Tue, 07 May 2013 10:24:38 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 07 May 2013 01:06:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,627,1363158000"; d="scan'208";a="330103156"
Received: from cvoicu-vostro-460.rb.intel.com ([10.237.105.151])
	by fmsmga001.fm.intel.com with ESMTP; 07 May 2013 01:06:34 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  7 May 2013 11:07:52 +0300
Message-Id: <1367914076-4863-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH 0/4] hob patches
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
X-List-Received-Date: Tue, 07 May 2013 08:24:42 -0000

*** BLURB HERE ***

Cristiana Voicu (4):
  hob: sort alphabetically results in groups of recipes/packages
  hob: "Brought in by" sorting should take into account the (+#)
    information
  hob: clicking on "cancel" should reset table sorting to default
  hob: assure consistency for image size label

 bitbake/lib/bb/ui/crumbs/builder.py              |    2 +
 bitbake/lib/bb/ui/crumbs/hoblistmodel.py         |   84 ++++++++++++++--------
 bitbake/lib/bb/ui/crumbs/imagedetailspage.py     |    2 +
 bitbake/lib/bb/ui/crumbs/packageselectionpage.py |   29 +++++---
 bitbake/lib/bb/ui/crumbs/recipeselectionpage.py  |   10 +++
 5 files changed, 91 insertions(+), 36 deletions(-)

-- 
1.7.9.5



