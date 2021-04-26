Received: from mga14.intel.com (mga14.intel.com [])
 by mx.groups.io with SMTP id smtpd.web11.2273.1619407679873857581
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 25 Apr 2021 20:28:05 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=fail (domain: intel.com, ip: <nil>, mailfrom: anuj.mittal@intel.com)
IronPort-SDR: hiqYjeeUnbsiWGw6BLc0+2yg5RFrBc3LqIy7W5ymyr1e6lrijhSnQN4SmmMBdgjOBSdl5t/wJn
 AvLWen6sLskw==
X-IronPort-AV: E=McAfee;i="6200,9189,9965"; a="195828062"
X-IronPort-AV: E=Sophos;i="5.82,251,1613462400"; 
   d="scan'208";a="195828062"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2021 20:28:04 -0700
IronPort-SDR: zElOVpdrqeOqQR6W+Ml2qahs1G6ZJNkmsaldyDd+x+R7Zc+swJt3YDkwEmIV6vcx4fOFmPS2AJ
 /W2heUsdmtaw==
X-IronPort-AV: E=Sophos;i="5.82,251,1613462400"; 
   d="scan'208";a="464923241"
Received: from wsan-mobl1.ccr.corp.intel.com (HELO anmitta2-mobl1.gar.corp.intel.com) ([10.213.45.138])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2021 20:28:03 -0700
From: "Anuj Mittal" <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.50][PATCH 4/5] bitbake-server: ensure server timeout is a float
Date: Mon, 26 Apr 2021 11:27:51 +0800
Message-Id: <a439513399a9da04b45b265ed24bb4be95360c97.1619407547.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1619407547.git.anuj.mittal@intel.com>
References: <cover.1619407547.git.anuj.mittal@intel.com>
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

