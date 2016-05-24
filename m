Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 666AC7001D
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 May 2016 22:21:09 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 24 May 2016 15:21:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.26,360,1459839600"; d="scan'208";a="961593743"
Received: from ismailm-mobl.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.147.14])
	by orsmga001.jf.intel.com with ESMTP; 24 May 2016 15:21:08 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 25 May 2016 10:20:37 +1200
Message-Id: <15eb39ca7db09de9c433146bc61421c4272e6012.1464128340.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <cover.1464128340.git.paul.eggleton@linux.intel.com>
References: <cover.1464128340.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1464128340.git.paul.eggleton@linux.intel.com>
References: <cover.1464128340.git.paul.eggleton@linux.intel.com>
Subject: [1.30][PATCH 1/1] fetch2: export DBUS_SESSION_BUS_ADDRESS to support authentication agents
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
X-List-Received-Date: Tue, 24 May 2016 22:21:09 -0000

From: Ross Burton <ross.burton@intel.com>

Some users may want to use authenticated SSH connections with credentials stored
in a keyring, such as gnome-keyring.  These typically need a DBus session bus
connection, so pass DBUS_SESSION_BUS_ADDRESS into the fetcher environment.

To avoid the user needing to set it in their local.conf (which wouldn't be
usable) or adding it to the environment-cleansing whitelist (which would
potentially impact builds) allow the variables being passed to the fetchers to
come from the data store (first) or the original environment (second).

From bitbake master rev: 20ad1ea87712d042bd5d89ce1957793f7ff71da0

Signed-off-by: Ross Burton <ross.burton@intel.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/__init__.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 1fa6702..e8fbe89 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -807,13 +807,14 @@ def runfetchcmd(cmd, d, quiet=False, cleanup=None):
                   'GIT_SSL_CAINFO',
                   'GIT_SMART_HTTP',
                   'SSH_AUTH_SOCK', 'SSH_AGENT_PID',
-                  'SOCKS5_USER', 'SOCKS5_PASSWD']
+                  'SOCKS5_USER', 'SOCKS5_PASSWD',
+                  'DBUS_SESSION_BUS_ADDRESS']
 
     if not cleanup:
         cleanup = []
 
     for var in exportvars:
-        val = d.getVar(var, True)
+        val = d.getVar(var, True) or d.getVar("BB_ORIGENV", False).getVar(var, True)
         if val:
             cmd = 'export ' + var + '=\"%s\"; %s' % (val, cmd)
 
-- 
2.5.5


