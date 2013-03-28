Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <andrei.adrianx.dinu@intel.com>) id 1UL8N9-0004iI-GZ
	for bitbake-devel@lists.openembedded.org;
	Thu, 28 Mar 2013 09:39:47 +0100
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 28 Mar 2013 01:22:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.84,924,1355126400"; d="scan'208";a="313050577"
Received: from adinu-vostro-460.rb.intel.com ([10.237.105.146])
	by fmsmga002.fm.intel.com with ESMTP; 28 Mar 2013 01:22:30 -0700
From: Andrei Dinu <andrei.adrianx.dinu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 28 Mar 2013 10:23:16 +0200
Message-Id: <1364459002-4165-1-git-send-email-andrei.adrianx.dinu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH 0/6] Add file information to package information window
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
X-List-Received-Date: Thu, 28 Mar 2013 08:39:47 -0000

Listing the files that are brought into an image
from each package.

[HOB #3925]

Andrei Dinu (6):
  cache_extra.py : added package information
  cooker.py : added variables related to cache_extra
  packageinfo.bbclass : extended functionality
  propertydialog.py : added 'Package files' functionality
  hoblistmodel.py : passing the package information to hob
  packageselectionpage.py : added information to hob

 bitbake/lib/bb/cache_extra.py                    |    3 +
 bitbake/lib/bb/cooker.py                         |    2 +
 bitbake/lib/bb/ui/crumbs/hig/propertydialog.py   |   94 +++++++++++++++++++++-
 bitbake/lib/bb/ui/crumbs/hoblistmodel.py         |    6 +-
 bitbake/lib/bb/ui/crumbs/packageselectionpage.py |    3 +-
 meta/classes/packageinfo.bbclass                 |   21 +++++
 6 files changed, 124 insertions(+), 5 deletions(-)

-- 
1.7.9.5



