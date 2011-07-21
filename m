Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1Qjy4V-00053P-Rw
	for bitbake-devel@lists.openembedded.org;
	Thu, 21 Jul 2011 20:34:08 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 21 Jul 2011 11:29:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,242,1309762800"; d="scan'208";a="28648891"
Received: from vorpal.jf.intel.com ([10.7.199.57])
	by orsmga002.jf.intel.com with ESMTP; 21 Jul 2011 11:29:55 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 21 Jul 2011 11:34:22 -0700
Message-Id: <03baee9e0a7fc15fc6c226c07c0f50df136ac5b0.1311273097.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1311273097.git.josh@linux.intel.com>
References: <cover.1311273097.git.josh@linux.intel.com>
In-Reply-To: <cover.1311273097.git.josh@linux.intel.com>
References: <cover.1311273097.git.josh@linux.intel.com>
Subject: [PATCH 5/6] ui/hob: don't crash if PARALLEL_MAKE doesn't include a space
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
X-List-Received-Date: Thu, 21 Jul 2011 18:34:08 -0000

Use string.strip() as a much safer method of turning the -j value into an int

Fixes [YOCTO #1244]

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/hob.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/bb/ui/hob.py b/lib/bb/ui/hob.py
index aed7eac..2df344f 100644
--- a/lib/bb/ui/hob.py
+++ b/lib/bb/ui/hob.py
@@ -883,7 +883,7 @@ def main (server, eventHandler):
         # The PARALLEL_MAKE variable will be of the format: "-j 3" and we only
         # want a number for the spinner, so strip everything from the variable
         # up to and including the space
-        pmake = int(pmake[pmake.find(" ")+1:])
+        pmake = int(pmake.lstrip("-j "))
 
     image_types = server.runCommand(["getVariable", "IMAGE_TYPES"])
 
-- 
1.7.6



