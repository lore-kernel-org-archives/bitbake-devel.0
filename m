Return-Path: <anibal.limon@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 0E4FE6071F
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 Jan 2017 16:20:07 +0000 (UTC)
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
	by fmsmga103.fm.intel.com with ESMTP; 09 Jan 2017 08:20:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.33,340,1477983600"; d="scan'208";a="51188399"
Received: from alimonb-mobl1.zpn.intel.com ([10.219.5.143])
	by fmsmga005.fm.intel.com with ESMTP; 09 Jan 2017 08:20:03 -0800
From: =?UTF-8?q?An=C3=ADbal=20Lim=C3=B3n?= <anibal.limon@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  9 Jan 2017 10:22:51 -0600
Message-Id: <1483978971-15880-2-git-send-email-anibal.limon@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1483978971-15880-1-git-send-email-anibal.limon@linux.intel.com>
References: <1483978971-15880-1-git-send-email-anibal.limon@linux.intel.com>
MIME-Version: 1.0
Subject: [PATCH 2/2] lib/bb/main.py: Shutdown cooker when server isn't foreground
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
X-List-Received-Date: Mon, 09 Jan 2017 16:20:07 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The cooker is added to the BBServer and then detached creating
a copy of the cooker in the process, if the server isn't in
foreground it cause fd leaks on inotify this can be see using
many instances of tinfoil.

Example:

from bb.tinfoil import Tinfoil
while True:
    with Tinfoil() as tinfoil:
        input("Pre\n")
        tinfoil.prepare(config_only=True)
        input("Post\n")

[YOCTO #10873]

Signed-off-by: Aníbal Limón <anibal.limon@linux.intel.com>
---
 lib/bb/main.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bb/main.py b/lib/bb/main.py
index 443f5ec..3ff43cf 100755
--- a/lib/bb/main.py
+++ b/lib/bb/main.py
@@ -367,6 +367,7 @@ def start_server(servermodule, configParams, configuration, features):
         raise
     if not configParams.foreground:
         server.detach()
+        cooker.shutdown()
     cooker.lock.close()
     return server
 
-- 
2.1.4


