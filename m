Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by mx.groups.io with SMTP id smtpd.web08.34518.1620052568226475852
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 03 May 2021 07:36:08 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: intel.com, ip: 134.134.136.24, mailfrom: anuj.mittal@intel.com)
IronPort-SDR: KCLl2sGM1ZsO+RyyHrW+MdHdIURb2E9dIE0KX6faMYdvrMCxfJEuKh3/Ax8dHBk69hJJB9CPJj
 tbR5xFKXtFWQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9973"; a="197849355"
X-IronPort-AV: E=Sophos;i="5.82,270,1613462400"; 
   d="scan'208";a="197849355"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2021 07:36:07 -0700
IronPort-SDR: +coy+hSx5RYN3wdrzyeQvpNM+EgHuL61fPYHKDsRPJRXLeti+hLUahUWhfC9Oy7Mlil7hYhKm/
 5XUzuosVcJcw==
X-IronPort-AV: E=Sophos;i="5.82,270,1613462400"; 
   d="scan'208";a="405696774"
Received: from semohdyu-mobl1.gar.corp.intel.com (HELO anmitta2-mobl1.gar.corp.intel.com) ([10.249.72.206])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2021 07:36:06 -0700
From: "Anuj Mittal" <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.48][PATCH 2/3] bitbake-server: ensure server timeout is a float
Date: Mon,  3 May 2021 22:35:53 +0800
Message-Id: <1af4bd89964abfd59e77f8cfb7ed01a3fa017f50.1620052467.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1620052467.git.anuj.mittal@intel.com>
References: <cover.1620052467.git.anuj.mittal@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ross Burton <ross@burtonini.com>

bitbake-server is spawned by process.py and passes the arguments it is
given to ProcessServer.  There's some type confusion here:

bitbake-server is called with a string representation of the timeout,
which may be None.  If the timeout is not set, pass 0 instead of None.

Inside bitbake-server a ProcessServer is created which expects the
timeout to be a float not a string, so always float() the value.

[ YOCTO #14350 ]

Signed-off-by: Ross Burton <ross.burton@arm.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit c93ae1f861208f6d39fd15c84fbcd0e2b54331f5)
Signed-off-by: Anuj Mittal <anuj.mittal@intel.com>
---
 bin/bitbake-server       | 2 +-
 lib/bb/server/process.py | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/bin/bitbake-server b/bin/bitbake-server
index ffbc7894e..65796be74 100755
--- a/bin/bitbake-server
+++ b/bin/bitbake-server
@@ -26,7 +26,7 @@ readypipeinfd = int(sys.argv[3])
 logfile = sys.argv[4]
 lockname = sys.argv[5]
 sockname = sys.argv[6]
-timeout = sys.argv[7]
+timeout = float(sys.argv[7])
 xmlrpcinterface = (sys.argv[8], int(sys.argv[9]))
 if xmlrpcinterface[0] == "None":
     xmlrpcinterface = (None, xmlrpcinterface[1])
diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index b27b4aefe..3e99bcef8 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -509,7 +509,7 @@ class BitBakeServer(object):
         os.set_inheritable(self.bitbake_lock.fileno(), True)
         os.set_inheritable(self.readypipein, True)
         serverscript = os.path.realpath(os.path.dirname(__file__) + "/../../../bin/bitbake-server")
-        os.execl(sys.executable, "bitbake-server", serverscript, "decafbad", str(self.bitbake_lock.fileno()), str(self.readypipein), self.logfile, self.bitbake_lock.name, self.sockname,  str(self.server_timeout), str(self.xmlrpcinterface[0]), str(self.xmlrpcinterface[1]))
+        os.execl(sys.executable, "bitbake-server", serverscript, "decafbad", str(self.bitbake_lock.fileno()), str(self.readypipein), self.logfile, self.bitbake_lock.name, self.sockname,  str(self.server_timeout or 0), str(self.xmlrpcinterface[0]), str(self.xmlrpcinterface[1]))
 
 def execServer(lockfd, readypipeinfd, lockname, sockname, server_timeout, xmlrpcinterface):
 
-- 
2.30.2

