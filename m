Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dvhart@linux.intel.com>) id 1U2rce-0005N0-Li
	for bitbake-devel@lists.openembedded.org;
	Wed, 06 Feb 2013 00:08:20 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 05 Feb 2013 14:51:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.84,610,1355126400"; d="scan'208";a="281408757"
Received: from fear.jf.intel.com (HELO rage.local) ([10.7.201.160])
	by orsmga002.jf.intel.com with ESMTP; 05 Feb 2013 14:51:13 -0800
From: Darren Hart <dvhart@linux.intel.com>
To: Poky <poky@yoctoproject.org>, openembedded-core@lists.openembedded.org,
	Richard Purdie <richard.purdie@linuxfoundation.org>
Date: Tue,  5 Feb 2013 14:52:44 -0800
Message-Id: <c6c651aff98215bcc29fb72fcddbba50c5aec807.1360104547.git.dvhart@linux.intel.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1360104547.git.dvhart@linux.intel.com>
References: <cover.1360104547.git.dvhart@linux.intel.com>
In-Reply-To: <cover.1360104547.git.dvhart@linux.intel.com>
References: <cover.1360104547.git.dvhart@linux.intel.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/9] bitbake: fetch2: Export upper and lower case environment variables
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
X-List-Received-Date: Tue, 05 Feb 2013 23:08:31 -0000

Applications are inconsistent in their use of upper and lower case proxy
variables. Curl, for example, specifies NO_PROXY (not no_proxy) in the
man page (changed in 2009 [1]). Avoid proxy issues by ensuring both the
upper and lower case versions of each proxy variable is available in the
environment for the fetcher commands.

Add FTPS_PROXY and ftps_proxy to the list as well.

1. http://curl.haxx.se/mail/tracker-2009-04/0012.html

Signed-off-by: Darren Hart <dvhart@linux.intel.com>
Cc: bitbake-devel@lists.openembedded.org
---
 bitbake/lib/bb/fetch2/__init__.py |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index cba45d0..7466a38 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -459,8 +459,13 @@ def runfetchcmd(cmd, d, quiet = False, cleanup = []):
     # Also include some other variables.
     # FIXME: Should really include all export varaiables?
     exportvars = ['PATH', 'GIT_PROXY_COMMAND', 'GIT_PROXY_HOST',
-                  'GIT_PROXY_PORT', 'GIT_CONFIG', 'http_proxy', 'ftp_proxy',
-                  'https_proxy', 'no_proxy', 'ALL_PROXY', 'all_proxy',
+                  'GIT_PROXY_PORT', 'GIT_CONFIG',
+                  'HTTP_PROXY', 'http_proxy',
+                  'HTTPS_PROXY', 'https_proxy',
+                  'FTP_PROXY', 'ftp_proxy',
+                  'FTPS_PROXY', 'ftps_proxy',
+                  'NO_PROXY', 'no_proxy',
+                  'ALL_PROXY', 'all_proxy',
                   'SSH_AUTH_SOCK', 'SSH_AGENT_PID', 'HOME',
                   'GIT_PROXY_IGNORE', 'SOCKS5_USER', 'SOCKS5_PASSWD']
 
-- 
1.7.5.4



