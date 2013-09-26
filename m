Return-Path: <ddalex@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 807A260EB6
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 26 Sep 2013 12:14:03 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 26 Sep 2013 05:14:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,985,1371106800"; d="scan'208";a="407470254"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by fmsmga002.fm.intel.com with ESMTP; 26 Sep 2013 05:14:04 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id 32BF6560681; Thu, 26 Sep 2013 13:14:04 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 26 Sep 2013 13:14:02 +0100
Message-Id: <1380197642-15951-1-git-send-email-alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 2/3] bitbake: webhob: adding frameworks for the Simple UI
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 26 Sep 2013 12:14:04 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>


Due to the SMTP limitation to line length, and using the minified version
of jQuery, I cannot submit the content of this patch by email.

Please take this patch from:

http://git.yoctoproject.org/cgit/cgit.cgi/poky-contrib/commit/?h=webhob-poky/webhob-master-1_5-web-2609&id=8a838bd239e9f515a35844a0bd2b70ede2ef4f72


This commit adds the 3rd party frameworks used for the web UI.

jQuery is licensed under MIT.

Bootstrap is licensed under APACHE-2.0

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 .../lib/webhob/bldviewer/static/css/bootstrap.css  | 4797 ++++++++++++++++++++
 .../lib/webhob/bldviewer/static/js/bootstrap.js    | 1982 ++++++++
 .../lib/webhob/bldviewer/static/js/jquery-2.0.3.js |    6 +
 3 files changed, 6785 insertions(+)
 create mode 100644 bitbake/lib/webhob/bldviewer/static/css/bootstrap.css
 create mode 100644 bitbake/lib/webhob/bldviewer/static/js/bootstrap.js
 create mode 100644 bitbake/lib/webhob/bldviewer/static/js/jquery-2.0.3.js

-- 
1.8.1.2


