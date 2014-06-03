Return-Path: <alexandru.damian@intel.com>
Received: from mail-we0-f170.google.com (mail-we0-f170.google.com
	[74.125.82.170])
	by mail.openembedded.org (Postfix) with ESMTP id DC7956B883
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  3 Jun 2014 15:26:18 +0000 (UTC)
Received: by mail-we0-f170.google.com with SMTP id u57so7141648wes.15
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 03 Jun 2014 08:26:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=auiCjJxYdLlwBbIuIhfAywV6iX4WRMpFCMgwP3gPEfk=;
	b=fB7yPuSrhPN4VnfbOb6tjEh42zQJbu/d/Z/6MTf+RlIGCloSF7YN3kXLHpBXf2gZTo
	z2LrKFw5NW0zP28TilBIBi8jYQGCy0gIS3uWOBNIx5cxNQ4HHZakzh9+ti2j5DHoYbQ7
	BV+BZxPI9tNWsqXPGeSYgOhqDOAXtsT/4r0r1GhN/Lw1T9Av/1IodbYjV4IDnC87eld+
	4JFr0cT5CxwFgXrMVE/VgZcw2/wrXGIB4dhBVxMbuFAz4ohm0P/uDvF3tL+++d+4DrON
	eG6w87Eh3gkEoK03lRTrDRQpFz7c4wdOOrjm9vNqZDAH7ZO8v0qY5QFPtYCTPTlBwwrp
	MXtQ==
X-Gm-Message-State: ALoCoQmZYY1/+5m6az9zLp5By2zZrAWoWmoBVZUO9Qbtr6NWPKDKq2y8HTXNe/V2MiIuBrEDbH6A
X-Received: by 10.181.11.193 with SMTP id ek1mr33982405wid.15.1401809179792;
	Tue, 03 Jun 2014 08:26:19 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id l5sm44736060wja.12.2014.06.03.08.26.17
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 03 Jun 2014 08:26:18 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id D327E561C1A; Tue,  3 Jun 2014 16:26:18 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  3 Jun 2014 16:26:16 +0100
Message-Id: <dd0b6dca4512a5b26db2df3a508bd1feace92fe1.1401808899.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <b6ae17f19c56ec99362290dd701542373720e572.1401808899.git.alexandru.damian@intel.com>
References: <b6ae17f19c56ec99362290dd701542373720e572.1401808899.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1401808899.git.alexandru.damian@intel.com>
References: <cover.1401808899.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 7/9] toaster: update toaster to run in managed mode
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
X-List-Received-Date: Tue, 03 Jun 2014 15:26:22 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

We disable bitbake self start to prevent race condition.

ToasterUI will shutdown the server when the build is done
if running in managed mode.

We fix usage of kill server flag in the bitbake binary.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bin/bitbake            | 34 ++++++++++++++++------------------
 lib/bb/ui/toasterui.py | 16 ++++++++++++----
 2 files changed, 28 insertions(+), 22 deletions(-)

diff --git a/bin/bitbake b/bin/bitbake
index ab881c5..f120bac 100755
--- a/bin/bitbake
+++ b/bin/bitbake
@@ -301,6 +301,9 @@ def main():
     if configParams.observe_only and (not configParams.remote_server or configParams.bind):
         sys.exit("FATAL: '--observe-only' can only be used by UI clients connecting to a server.\n")
 
+    if configParams.kill_server and not configParams.remote_server:
+        sys.exit("FATAL: '--kill-server' can only be used to terminate a remote server")
+
     if "BBDEBUG" in os.environ:
         level = int(os.environ["BBDEBUG"])
         if level > configuration.debug:
@@ -332,29 +335,14 @@ def main():
         server = servermodule.BitBakeXMLRPCClient(configParams.observe_only)
         server.saveConnectionDetails(configParams.remote_server)
 
-    def _getServerConnection(server, featureset):
-        try:
-            server_connection = server.establishConnection(featureset)
-        except Exception as e:
-            bb.fatal("Could not connect to server %s: %s" % (configParams.remote_server, str(e)))
-        return server_connection
 
     if not configParams.server_only:
-        if configParams.status_only:
-            server_connection = _getServerConnection(server, featureset)
-            server_connection.terminate()
-            sys.exit(0)
-
-        # Setup a connection to the server (cooker)
         try:
             server_connection = server.establishConnection(featureset)
-        except:
+        except Exception as e:
             if configParams.kill_server:
-                bb.fatal("Server already offline")
-            configParams.bind = configParams.remote_server
-            start_server(servermodule, configParams, configuration, featureset)
-            bb.event.ui_queue = []
-            server_connection = _getServerConnection(server, featureset)
+                sys.exit(0)
+            bb.fatal("Could not connect to server %s: %s" % (configParams.remote_server, str(e)))
 
         # Restore the environment in case the UI needs it
         for k in cleanedvars:
@@ -362,6 +350,16 @@ def main():
 
         logger.removeHandler(handler)
 
+
+        if configParams.status_only:
+            server_connection.terminate()
+            sys.exit(0)
+
+        if configParams.kill_server:
+            server_connection.connection.terminateServer()
+            bb.event.ui_queue = []
+            sys.exit(0)
+
         try:
             return ui_module.main(server_connection.connection, server_connection.events, configParams)
         finally:
diff --git a/lib/bb/ui/toasterui.py b/lib/bb/ui/toasterui.py
index 9a9fe6f..c1696b2 100644
--- a/lib/bb/ui/toasterui.py
+++ b/lib/bb/ui/toasterui.py
@@ -226,11 +226,19 @@ def main(server, eventHandler, params ):
 
                 buildinfohelper.update_build_information(event, errors, warnings, taskfailures)
 
+
+                brbe = server.runCommand(["getVariable", "TOASTER_BRBE"])[0]
                 # we start a new build info
-                errors = 0
-                warnings = 0
-                taskfailures = []
-                buildinfohelper = BuildInfoHelper(server, build_history_enabled)
+                if brbe is not None:
+                    print "we are under BuildEnvironment management - after the build, we exit"
+                    server.terminateServer()
+                else:
+                    print "prepared for new build"
+                    errors = 0
+                    warnings = 0
+                    taskfailures = []
+                    buildinfohelper = BuildInfoHelper(server, build_history_enabled)
+
                 continue
 
             if isinstance(event, bb.event.MetadataEvent):
-- 
1.9.1


