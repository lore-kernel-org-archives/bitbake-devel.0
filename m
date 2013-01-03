Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <jessica.zhang@intel.com>) id 1TquLs-0000B4-SW
	for bitbake-devel@lists.openembedded.org;
	Fri, 04 Jan 2013 00:37:33 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 03 Jan 2013 15:21:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.84,405,1355126400"; d="scan'208";a="241824961"
Received: from jzhang-desktop.jf.intel.com (HELO localhost) ([10.7.201.69])
	by orsmga001.jf.intel.com with ESMTP; 03 Jan 2013 15:20:57 -0800
From: Jessica Zhang <jessica.zhang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  3 Jan 2013 15:32:04 -0800
Message-Id: <cover.1357255745.git.jessica.zhang@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH 0/1] Fix GTK+ and PyGtk version check error message to be more clear [Yocto #3637]
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
X-List-Received-Date: Thu, 03 Jan 2013 23:37:33 -0000

The following changes since commit 247b6a3754c2c50318e2a73d79981ba0e9cb560b:

  gstreamer, gst-plugins*: fix localdata (2012-11-28 15:25:33 +0000)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib jzhang/3637
  http://git.yoctoproject.org/cgit.cgi//log/?h=jzhang/3637

Jessica Zhang (1):
  Fix GTK+ and PyGtk version check error message to be more clear [Yocto #3637]

 bitbake/lib/bb/ui/hob.py |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
1.7.9.5



