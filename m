Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f177.google.com (mail-wi0-f177.google.com
	[209.85.212.177])
	by mail.openembedded.org (Postfix) with ESMTP id BC65D6F89F
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  1 Apr 2014 11:24:55 +0000 (UTC)
Received: by mail-wi0-f177.google.com with SMTP id cc10so4914675wib.4
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 01 Apr 2014 04:24:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=4OBkeO58Ohl/1ilrKF7//LZcyC7hWXOww3xtP/dzc4E=;
	b=CBYzbApAOrnTM1j2X4AWgyz/rm1Sv0y/bcQFFUD3l+6tEI566MoN0U9Zf0qvmx24hO
	Nx+gyk9Gq84DmvPyWe4t6XwtKzwZt9lELxfD+0AQzvzR2Rcgy1qQB7WHoRYGWD4/HNTE
	J509prkIlfzK/5yE8INWmoBqAHurOInaMUlx14c6LGf4IwcZ/ImDDeeyHBHzBAVn4W9t
	4zEIVd2o3Ga1I/bgcshhuTuW1gHxxdwRt4FuTpgwUN88XiDkGsaRuYUCAII4jwXwWHUF
	+9Zm+ltZMDGaTLtqXu3x8QanbDdiVQJO9TJJxRPb5A1Ebj2EgXo9OrF7Wihk44yxhJaR
	F7Gw==
X-Gm-Message-State: ALoCoQntJ8XvWvFzexh7/ySNfRVsg6ewyJnndPUDMdmqyOjSkNYJ6m5sv1eb0kLMsmZSgHgXxx7u
X-Received: by 10.180.11.239 with SMTP id t15mr19242887wib.51.1396351495813;
	Tue, 01 Apr 2014 04:24:55 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id gr2sm6802099wjc.12.2014.04.01.04.24.54
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 01 Apr 2014 04:24:54 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 972AA560445; Tue,  1 Apr 2014 12:24:50 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  1 Apr 2014 12:24:49 +0100
Message-Id: <1396351489-13076-1-git-send-email-alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 1/1] bitbake: cooker: mark setFeatures command as read-only
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
X-List-Received-Date: Tue, 01 Apr 2014 11:24:56 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch makes sure that the setFeatures command is marked
as read-only and that it can only run if the cooker is in
the initial state.

Additionally, remove logging from the XMLRPC module in favor
of sending the exception to the client for easy processing.

	[YOCTO #6089]

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/bb/command.py       | 4 ++++
 bitbake/lib/bb/cooker.py        | 3 +++
 bitbake/lib/bb/server/xmlrpc.py | 2 +-
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/command.py b/bitbake/lib/bb/command.py
index 3788207..84fcdf9 100644
--- a/bitbake/lib/bb/command.py
+++ b/bitbake/lib/bb/command.py
@@ -264,6 +264,10 @@ class CommandsSync:
         features = params[0]
         command.cooker.setFeatures(features)
 
+    # although we change the internal state of the cooker, this is transparent since
+    # we always take and leave the cooker in state.initial
+    setFeatures.readonly = True
+
 class CommandsAsync:
     """
     A class of asynchronous commands
diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index e6916a6..f41f594 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -159,6 +159,9 @@ class BBCooker:
         self.state = state.forceshutdown
 
     def setFeatures(self, features):
+        # we only accept a new feature set if we're in state initial, so we can reset without problems
+        if self.state != state.initial:
+            raise Exception("Illegal state for feature set change")
         original_featureset = list(self.featureset)
         for feature in features:
             self.featureset.setFeature(feature)
diff --git a/bitbake/lib/bb/server/xmlrpc.py b/bitbake/lib/bb/server/xmlrpc.py
index bf867b5..5dcaa6c 100644
--- a/bitbake/lib/bb/server/xmlrpc.py
+++ b/bitbake/lib/bb/server/xmlrpc.py
@@ -292,7 +292,7 @@ class BitBakeXMLRPCServerConnection(BitBakeBaseServerConnection):
 
         _, error = self.connection.runCommand(["setFeatures", self.featureset])
         if error:
-            logger.error("Unable to set the cooker to the correct featureset: %s" % error)
+            # no need to log it here, the error shall be sent to the client
             raise BaseException(error)
 
         return self
-- 
1.9.1


