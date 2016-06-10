Return-Path: <stephano.cetola@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id B630560557
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 10 Jun 2016 17:55:51 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 10 Jun 2016 10:55:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.26,451,1459839600"; d="scan'208";a="995172340"
Received: from yocto-dev86.jf.intel.com ([10.7.198.60])
	by orsmga002.jf.intel.com with ESMTP; 10 Jun 2016 10:55:53 -0700
From: Stephano Cetola <stephano.cetola@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 10 Jun 2016 10:56:38 -0700
Message-Id: <20160610175638.2020-1-stephano.cetola@linux.intel.com>
X-Mailer: git-send-email 2.8.3
Subject: [PATCH] fetch2: fix unpacking of deb packages
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
X-List-Received-Date: Fri, 10 Jun 2016 17:55:52 -0000

Python 3 changed the return value of check_output to binary rather than
a string. This fix decodes the binary before calling splitlines, which
requires a string.

Signed-off-by: Stephano Cetola <stephano.cetola@linux.intel.com>
---
 lib/bb/fetch2/__init__.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index f612318..a63498a 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1395,7 +1395,7 @@ class FetchMethod(object):
                 output = subprocess.check_output('ar -t %s' % file, preexec_fn=subprocess_setup, shell=True)
                 datafile = None
                 if output:
-                    for line in output.splitlines():
+                    for line in output.decode().splitlines():
                         if line.startswith('data.tar.'):
                             datafile = line
                             break
-- 
2.8.3


