Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1QkJcs-0000xQ-AP
	for bitbake-devel@lists.openembedded.org;
	Fri, 22 Jul 2011 19:35:02 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 22 Jul 2011 10:30:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,248,1309762800"; d="scan'208";a="30862694"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.255.17.206])
	by orsmga001.jf.intel.com with ESMTP; 22 Jul 2011 10:30:42 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 22 Jul 2011 18:30:30 +0100
Message-Id: <c6ca2f62423dde8d721bc68b53541ca0909fe797.1311355686.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1311355686.git.paul.eggleton@linux.intel.com>
References: <cover.1311355686.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1311355686.git.paul.eggleton@linux.intel.com>
References: <cover.1311355686.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/6] bitbake: add note to -b option indicating no dependency handling
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
X-List-Received-Date: Fri, 22 Jul 2011 17:35:02 -0000

The -b option doesn't handle dependencies so note this in the help.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/bin/bitbake |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/bitbake/bin/bitbake b/bitbake/bin/bitbake
index 206d97b..f198fd1 100755
--- a/bitbake/bin/bitbake
+++ b/bitbake/bin/bitbake
@@ -102,7 +102,7 @@ It expects that BBFILES is defined, which is a space separated list of files to
 be executed.  BBFILES does support wildcards.
 Default BBFILES are the .bb files in the current directory.""")
 
-    parser.add_option("-b", "--buildfile", help = "execute the task against this .bb file, rather than a package from BBFILES.",
+    parser.add_option("-b", "--buildfile", help = "execute the task against this .bb file, rather than a package from BBFILES. Does not handle any dependencies.",
                action = "store", dest = "buildfile", default = None)
 
     parser.add_option("-k", "--continue", help = "continue as much as possible after an error. While the target that failed, and those that depend on it, cannot be remade, the other dependencies of these targets can be processed all the same.",
-- 
1.7.4.1



