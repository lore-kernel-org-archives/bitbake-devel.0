Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SXCtC-0005KU-Uh
	for bitbake-devel@lists.openembedded.org;
	Wed, 23 May 2012 16:50:15 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 23 May 2012 07:40:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="147446592"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by orsmga002.jf.intel.com with ESMTP; 23 May 2012 07:40:00 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 23 May 2012 23:18:44 +0800
Message-Id: <cover.1337786155.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
Subject: [PATCH 0/1] Hob: Adjust the progress bar not to show 100% when things are not finished
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
X-List-Received-Date: Wed, 23 May 2012 14:50:15 -0000

On build appliance, because the packages are prebuilt, Hob spends much time getting the package
list, it is very strange that things are not finsihed but the progress bar shows 100% and wait
there. This patch is to fix that and ensure the bar to show 100% if and only if all things are done.

The following changes since commit 39a9267dee0a0ee4d87ed51d4a0272549c462b02:

  Hob: add '--select a machine--' and '--select a base image--' to GUI (2012-05-22 14:56:17 +0100)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib shane/newproxy
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=shane/newproxy

Shane Wang (1):
  Hob: Adjust the progress bar and set 100% only when all is done.

 bitbake/lib/bb/ui/crumbs/builder.py         |   12 ++++++++++--
 bitbake/lib/bb/ui/crumbs/hobeventhandler.py |    8 ++++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

-- 
1.7.6



