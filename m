Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dvhart@linux.intel.com>) id 1U2g40-0000mp-B3
	for bitbake-devel@lists.openembedded.org;
	Tue, 05 Feb 2013 11:47:50 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 05 Feb 2013 02:29:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.84,602,1355126400"; d="scan'208";a="257891622"
Received: from fear.jf.intel.com (HELO rage.local) ([10.7.201.160])
	by orsmga001.jf.intel.com with ESMTP; 05 Feb 2013 02:30:08 -0800
From: Darren Hart <dvhart@linux.intel.com>
To: Poky <poky@yoctoproject.org>, openembedded-core@lists.openembedded.org,
	Richard Purdie <richard.purdie@linuxfoundation.org>
Date: Tue,  5 Feb 2013 02:31:39 -0800
Message-Id: <ae9006152f5551b3eb019c8d639625d5f32e1366.1360059615.git.dvhart@linux.intel.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1360059615.git.dvhart@linux.intel.com>
References: <cover.1360059615.git.dvhart@linux.intel.com>
In-Reply-To: <cover.1360059615.git.dvhart@linux.intel.com>
References: <cover.1360059615.git.dvhart@linux.intel.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: [PATCH 3/8] bitbake: fetch2: Remove broken git variables from the environment
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
X-List-Received-Date: Tue, 05 Feb 2013 10:47:52 -0000

The following variables perform no function outside of bitbake:

    GIT_CONFIG
    GIT_PROXY_HOST
    GIT_PROXY_PORT
    GIT_PROXY_IGNORE

GIT_CONFIG only affects the git-config command which is not relevant to
the fetcher. This was previously used with the OE GIT_CORE_CONFIG
variable which would provide a basic git config to use instead of the
user's config. This usage was deprecated by git for over a year now:

http://git.661346.n2.nabble.com/Overriding-gitconfig-using-GIT-CONFIG-td6680977.html

GIT_PROXY_HOST and GIT_PROXY_PORT are not used by git.

GIT_PROXY_IGNORE was an OE construct used to create the custom git
config and had no meaning outside of the OE environment. It is not used
by git.

Remove these variables from the fetcher environment.

Users wishing to configure git to work with a proxy should define the
GIT_PROXY_COMMAND environment variable to use an external script.
NO_PROXY can be used within this script to skip the proxy for certain
hosts.

Signed-off-by: Darren Hart <dvhart@linux.intel.com>
Cc: bitbake-devel@lists.openembedded.org
---
 bitbake/lib/bb/fetch2/__init__.py |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index 7466a38..21f576e 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -458,16 +458,16 @@ def runfetchcmd(cmd, d, quiet = False, cleanup = []):
     # rather than host provided
     # Also include some other variables.
     # FIXME: Should really include all export varaiables?
-    exportvars = ['PATH', 'GIT_PROXY_COMMAND', 'GIT_PROXY_HOST',
-                  'GIT_PROXY_PORT', 'GIT_CONFIG',
+    exportvars = ['HOME', 'PATH',
                   'HTTP_PROXY', 'http_proxy',
                   'HTTPS_PROXY', 'https_proxy',
                   'FTP_PROXY', 'ftp_proxy',
                   'FTPS_PROXY', 'ftps_proxy',
                   'NO_PROXY', 'no_proxy',
                   'ALL_PROXY', 'all_proxy',
-                  'SSH_AUTH_SOCK', 'SSH_AGENT_PID', 'HOME',
-                  'GIT_PROXY_IGNORE', 'SOCKS5_USER', 'SOCKS5_PASSWD']
+                  'GIT_PROXY_COMMAND',
+                  'SSH_AUTH_SOCK', 'SSH_AGENT_PID',
+                  'SOCKS5_USER', 'SOCKS5_PASSWD']
 
     for var in exportvars:
         val = d.getVar(var, True)
-- 
1.7.5.4



