Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1Qze0X-0008Rq-Kj
	for bitbake-devel@lists.openembedded.org;
	Sat, 03 Sep 2011 02:22:49 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 02 Sep 2011 17:17:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.68,321,1312182000"; d="scan'208";a="47755005"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.14.9])
	by fmsmga001.fm.intel.com with ESMTP; 02 Sep 2011 17:17:49 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  2 Sep 2011 17:17:37 -0700
Message-Id: <a6878002ffc54b11f0fb59df60630010f574408b.1315008498.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1315008498.git.josh@linux.intel.com>
References: <cover.1315008498.git.josh@linux.intel.com>
In-Reply-To: <cover.1315008498.git.josh@linux.intel.com>
References: <cover.1315008498.git.josh@linux.intel.com>
Subject: [PATCH 2/6] hob: reflect defaultsetup being default distro
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
X-List-Received-Date: Sat, 03 Sep 2011 00:22:49 -0000

If no value is set for DISTRO the defaultsetup policy is used, reflect this
in the UI by having defaultsetup selected in the Distribution combo when no
other DISTRO is set.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/hob.py |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/lib/bb/ui/hob.py b/lib/bb/ui/hob.py
index c1302e5..022d1b6 100644
--- a/lib/bb/ui/hob.py
+++ b/lib/bb/ui/hob.py
@@ -992,6 +992,8 @@ def main (server, eventHandler):
     if not sdk_mach:
         sdk_mach = server.runCommand(["getVariable", "SDK_ARCH"])
     distro = server.runCommand(["getVariable", "DISTRO"])
+    if not distro:
+        distro = "defaultsetup"
     bbthread = server.runCommand(["getVariable", "BB_NUMBER_THREADS"])
     if not bbthread:
         bbthread = 1
-- 
1.7.6



