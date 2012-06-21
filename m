Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1Shili-0002lx-Au
	for bitbake-devel@lists.openembedded.org;
	Thu, 21 Jun 2012 16:53:58 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 21 Jun 2012 07:43:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="159185635"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.120.141])
	by azsmga001.ch.intel.com with ESMTP; 21 Jun 2012 07:43:10 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 21 Jun 2012 15:43:02 +0100
Message-Id: <1340289782-5874-1-git-send-email-paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] lib/bb/utils.py: remove unnecessary preserved variables
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
X-List-Received-Date: Thu, 21 Jun 2012 14:53:58 -0000

_ and LANG no longer need to be preserved from the external environment.
The value of _ changes between non-pseudo-wrapped and pseudo-wrapped
invocations (e.g. between "bitbake -p" and "bitbake target") and this
will currently trigger a full reparse in the absence of a whitelist
entry in BB_HASHCONFIG_WHITELIST, which is not ideal.

LANG used to be preserved in order to ensure the C locale was being
used for tools invoked by bitbake, however we now set LC_ALL in
bitbake.conf to take care of this.

Second part of the fix for [YOCTO #2600].

Acked-by: Jason Wessel <jason.wessel@windriver.com>
Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/utils.py |    2 --
 1 file changed, 2 deletions(-)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index fc389a3..c1e5a61 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -422,8 +422,6 @@ def preserved_envvars():
         'BB_PRESERVE_ENV',
         'BB_ENV_WHITELIST',
         'BB_ENV_EXTRAWHITE',
-        'LANG',
-        '_',
     ]
     return v + preserved_envvars_exported() + preserved_envvars_exported_interactive()
 
-- 
1.7.9.5



