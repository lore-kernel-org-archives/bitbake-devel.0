Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <sgw@linux.intel.com>) id 1SI9Wb-0004JV-Fa
	for bitbake-devel@lists.openembedded.org;
	Thu, 12 Apr 2012 04:12:41 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga102.ch.intel.com with ESMTP; 11 Apr 2012 19:02:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="88080315"
Received: from unknown (HELO swold-mobl.bigsur.com) ([10.255.12.89])
	by AZSMGA002.ch.intel.com with ESMTP; 11 Apr 2012 19:02:16 -0700
From: Saul Wold <sgw@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 11 Apr 2012 19:02:15 -0700
Message-Id: <1334196135-614-1-git-send-email-sgw@linux.intel.com>
X-Mailer: git-send-email 1.7.7.6
Subject: [PATCH] builder: fix missing \ for if continuation
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
X-List-Received-Date: Thu, 12 Apr 2012 02:12:41 -0000

Signed-off-by: Saul Wold <sgw@linux.intel.com>
---
 lib/bb/ui/crumbs/builder.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/bb/ui/crumbs/builder.py b/lib/bb/ui/crumbs/builder.py
index d8d0987..10b9a77 100755
--- a/lib/bb/ui/crumbs/builder.py
+++ b/lib/bb/ui/crumbs/builder.py
@@ -972,7 +972,7 @@ class Builder(gtk.Window):
             tmp_path = self.parameters.tmpdir
             cmdline = bb.ui.crumbs.utils.which_terminal()
             if os.path.exists(image_path) and os.path.exists(kernel_path) \
-               and os.path.exists(source_env_path) and os.path.exists(tmp_path)
+               and os.path.exists(source_env_path) and os.path.exists(tmp_path) \
                and cmdline:
                 cmdline += "\' bash -c \"export OE_TMPDIR=" + tmp_path + "; "
                 cmdline += "source " + source_env_path + " " + os.getcwd() + "; "
-- 
1.7.7.6



