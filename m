Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f175.google.com (mail-wi0-f175.google.com
	[209.85.212.175])
	by mail.openembedded.org (Postfix) with ESMTP id 2D73F6E614
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 16 Feb 2015 17:53:45 +0000 (UTC)
Received: by mail-wi0-f175.google.com with SMTP id r20so27709976wiv.2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 16 Feb 2015 09:53:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=Tn+clrtcGqcydFK1V1c5AAxtQ7A3tkWrM0rG+M0Fcdc=;
	b=U3pL0ynOh87P21Eol3poldxcfxm59rjFBZADXsaaeArVI/jdO87jgg+Pm80SHC3a45
	tpppYn0ctWhSSSwKsx2Atun0QTHyyVkS/p3zFYlZvXa7y3yiI0ZSsKgwxgewe6y09AnX
	TDzSzCOq4X/bgKLtW0y2s1cIjoPZaBnGt/fcCx+6ILTPMm7g01FsyPhgpCzys8+9SEMP
	j0by0+BnpE8x4W3r4GyGs2LdLXMhS+MvDGxDnHjvvnhszPpoaTP9+9BjZgGk6s6/A5jr
	+25GTDmD/j4T7kdUwB7DCt4sBXnQcrYvHO2dw9Shb7yyhuuztQIW5fWpDIKJrfYtk26v
	ho4Q==
X-Gm-Message-State: ALoCoQl83UEwloqvBAqzqgsnQLEj5FPeoJlG93ioEJnoc6yuN6opoA6aZV11coRCdH+4IvTkiNeI
X-Received: by 10.194.143.109 with SMTP id sd13mr53880561wjb.70.1424109227053; 
	Mon, 16 Feb 2015 09:53:47 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id k6sm16665682wia.6.2015.02.16.09.53.45
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 16 Feb 2015 09:53:46 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id C8022560689; Mon, 16 Feb 2015 17:53:29 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 16 Feb 2015 17:53:18 +0000
Message-Id: <7f47b67bccff55673a827dbcccc767af4459c933.1424108976.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <2060be8d31baa0cd302aa8dc0b6d179df853ee99.1424108976.git.alexandru.damian@intel.com>
References: <2060be8d31baa0cd302aa8dc0b6d179df853ee99.1424108976.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1424108976.git.alexandru.damian@intel.com>
References: <cover.1424108976.git.alexandru.damian@intel.com>
Subject: [PATCH 02/10] toaster: properly detect failed server start
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
X-List-Received-Date: Mon, 16 Feb 2015 17:53:46 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch brings in reading the server log if the server
fails to start. This is the first step in displaying the errors
in a manner that is actionable by the user.

[YOCTO #7285]

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/bldcontrol/localhostbecontroller.py         |  5 ++++-
 lib/toaster/bldcontrol/management/commands/runbuilds.py | 12 +++++++++---
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/lib/toaster/bldcontrol/localhostbecontroller.py b/lib/toaster/bldcontrol/localhostbecontroller.py
index 005c464..4814b84 100644
--- a/lib/toaster/bldcontrol/localhostbecontroller.py
+++ b/lib/toaster/bldcontrol/localhostbecontroller.py
@@ -108,7 +108,7 @@ class LocalhostBEController(BuildEnvironmentController):
         logger.debug("localhostbecontroller: running the listener at %s" % own_bitbake)
 
 
-        cmd = "bash -c \"source %s/oe-init-build-env %s && bitbake --read conf/toaster-pre.conf --postread conf/toaster.conf --server-only -t xmlrpc -B 0.0.0.0:0 && DATABASE_URL=%s BBSERVER=0.0.0.0:-1 daemon -d -i -D %s -o toaster_ui.log -- %s --observe-only -u toasterui &\"" % (self.pokydirname, self.be.builddir,
+        cmd = "bash -c \"source %s/oe-init-build-env %s && bitbake --read conf/toaster-pre.conf --postread conf/toaster.conf --server-only -t xmlrpc -B 0.0.0.0:0 >toaster_server.log && DATABASE_URL=%s BBSERVER=0.0.0.0:-1 daemon -d -i -D %s -o toaster_ui.log -- %s --observe-only -u toasterui &\"" % (self.pokydirname, self.be.builddir,
                 self.dburl, self.be.builddir, own_bitbake)
         port = "-1"
         cmdoutput = self._shellcmd(cmd)
@@ -290,6 +290,9 @@ class LocalhostBEController(BuildEnvironmentController):
         self.islayerset = True
         return True
 
+    def readServerLogFile(self):
+        return open(os.path.join(self.be.builddir, "toaster_server.log"), "r").read()
+
     def release(self):
         assert self.be.sourcedir and os.path.exists(self.be.builddir)
         import shutil
diff --git a/lib/toaster/bldcontrol/management/commands/runbuilds.py b/lib/toaster/bldcontrol/management/commands/runbuilds.py
index c4ab87b..3de582c 100644
--- a/lib/toaster/bldcontrol/management/commands/runbuilds.py
+++ b/lib/toaster/bldcontrol/management/commands/runbuilds.py
@@ -78,10 +78,16 @@ class Command(NoArgsCommand):
         except Exception as e:
             logger.error("runbuilds: Error executing shell command %s" % e)
             traceback.print_exc(e)
+            if "[Errno 111] Connection refused" in str(e):
+                # Connection refused, read toaster_server.out
+                errmsg = bec.readServerLogFile()
+            else:
+                errmsg = str(e)
+
             BRError.objects.create(req = br,
-                errtype = str(type(e)),
-                errmsg = str(e),
-                traceback = traceback.format_exc(e))
+                    errtype = str(type(e)),
+                    errmsg = errmsg,
+                    traceback = traceback.format_exc(e))
             br.state = BuildRequest.REQ_FAILED
             br.save()
             bec.be.lock = BuildEnvironment.LOCK_FREE
-- 
1.9.1


