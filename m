Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dexuan.cui@intel.com>) id 1QUwzI-0003dG-Jz
	for bitbake-devel@lists.openembedded.org;
	Fri, 10 Jun 2011 10:22:40 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 10 Jun 2011 01:18:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.65,345,1304319600"; d="scan'208";a="16680992"
Received: from dcui-desktop.sh.intel.com (HELO localhost) ([10.239.13.51])
	by fmsmga001.fm.intel.com with ESMTP; 10 Jun 2011 01:18:14 -0700
From: Dexuan Cui <dexuan.cui@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 10 Jun 2011 16:18:10 +0800
Message-Id: <6439f6f95ef1157063276692bcf2adfebb7597eb.1307693771.git.dexuan.cui@intel.com>
X-Mailer: git-send-email 1.7.2
In-Reply-To: <cover.1307693771.git.dexuan.cui@intel.com>
References: <cover.1307693771.git.dexuan.cui@intel.com>
In-Reply-To: <cover.1307693771.git.dexuan.cui@intel.com>
References: <cover.1307693771.git.dexuan.cui@intel.com>
Subject: [PATCH 1/1] bitbake-layers: stop the warning "not been run using the bitbake wrapper..."
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
X-List-Received-Date: Fri, 10 Jun 2011 08:22:40 -0000

Signed-off-by: Dexuan Cui <dexuan.cui@intel.com>
---
 bitbake/bin/bitbake-layers |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/bitbake/bin/bitbake-layers b/bitbake/bin/bitbake-layers
index 6b5ad5a..aa6d031 100755
--- a/bitbake/bin/bitbake-layers
+++ b/bitbake/bin/bitbake-layers
@@ -29,6 +29,10 @@ def main(args):
     logging.basicConfig(format='%(levelname)s: %(message)s')
     bb.utils.clean_environment()
 
+    # set PSEUDO_BUILD after clean_environment() , or else, the setting will
+    # be filtered out.
+    os.environ["PSEUDO_BUILD"] = "0"
+
     cmds = Commands()
     if args:
         cmds.onecmd(' '.join(args))
-- 
1.7.2



