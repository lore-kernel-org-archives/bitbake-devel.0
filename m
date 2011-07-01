Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dvhart@linux.intel.com>) id 1Qcgts-0001Eg-Ji
	for bitbake-devel@lists.openembedded.org;
	Fri, 01 Jul 2011 18:49:04 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 01 Jul 2011 09:44:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.65,459,1304319600"; d="scan'208";a="22825588"
Received: from unknown (HELO [10.255.13.116]) ([10.255.13.116])
	by fmsmga002.fm.intel.com with ESMTP; 01 Jul 2011 09:44:02 -0700
Message-ID: <4E0DF94E.5010301@linux.intel.com>
Date: Fri, 01 Jul 2011 09:43:58 -0700
From: Darren Hart <dvhart@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US;
	rv:1.9.2.17) Gecko/20110424 Lightning/1.0b2 Thunderbird/3.1.10
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] fix typo in bitbake
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
X-List-Received-Date: Fri, 01 Jul 2011 16:49:04 -0000
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Patch from the car over 3g hotspot... quick, before it goes down...
please feel free to cleanup, change the comment, whatever.

Signed-off-by: Darren Hart <dvhart@linux.intel.com>
---
 bitbake/bin/bitbake |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/bitbake/bin/bitbake b/bitbake/bin/bitbake
index 2564e97..c71c2d4 100755
--- a/bitbake/bin/bitbake
+++ b/bitbake/bin/bitbake
@@ -202,7 +202,7 @@ Default BBFILES are the .bb files in the current
directory.""")
     # of the UIs (e.g. for DISPLAY, etc.)
     bb.utils.clean_environment()

-    server = server.BitBakeServer(
+    server = server.BitBakeServer()

     server.initServer()
     idle = server.getServerIdleCB()
-- 
1.7.1
-- 
Darren Hart
Intel Open Source Technology Center
Yocto Project - Linux Kernel


