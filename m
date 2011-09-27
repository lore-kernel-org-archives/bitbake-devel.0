Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1R8hLR-00016Y-2B
	for bitbake-devel@lists.openembedded.org;
	Wed, 28 Sep 2011 01:45:49 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 27 Sep 2011 16:40:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.68,452,1312182000"; d="scan'208";a="56365090"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.15.9])
	by azsmga001.ch.intel.com with ESMTP; 27 Sep 2011 16:40:21 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 27 Sep 2011 16:40:15 -0700
Message-Id: <9438c177af2f564a9cdd8c8a2bfe1c37f88bdc3f.1317166668.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6.2
In-Reply-To: <cover.1317166668.git.josh@linux.intel.com>
References: <cover.1317166668.git.josh@linux.intel.com>
In-Reply-To: <cover.1317166668.git.josh@linux.intel.com>
References: <cover.1317166668.git.josh@linux.intel.com>
Subject: [RFC PATCH 1/1] texinfo: fix build on Ubuntu Oneiric
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
X-List-Received-Date: Tue, 27 Sep 2011 23:45:49 -0000

Calling the missing script with the help2man program argument fails for some
output targets on Ubuntu Oneiric.

Reading the help of missing I see that the help2man program value just touches
the output file - therefore this patch touches the three problematic files
in do_install_prepend.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 meta/recipes-extended/texinfo/texinfo_4.13a.bb |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/meta/recipes-extended/texinfo/texinfo_4.13a.bb b/meta/recipes-extended/texinfo/texinfo_4.13a.bb
index 9f1c04a..8864d7c 100644
--- a/meta/recipes-extended/texinfo/texinfo_4.13a.bb
+++ b/meta/recipes-extended/texinfo/texinfo_4.13a.bb
@@ -33,6 +33,9 @@ do_compile_prepend() {
 	if [ -d tools ];then
 		oe_runmake -C tools/gnulib/lib
 	fi
+	touch ${S}/doc/texi2pdf.1
+	touch ${S}/doc/info.1
+	touch ${S}/doc/install-info.1
 }
 
 do_install_append() {
-- 
1.7.6.2



