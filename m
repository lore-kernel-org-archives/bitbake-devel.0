Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f65.google.com (mail-pa0-f65.google.com
	[209.85.220.65])
	by mail.openembedded.org (Postfix) with ESMTP id 79341731C4
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  3 Mar 2016 06:41:31 +0000 (UTC)
Received: by mail-pa0-f65.google.com with SMTP id gc2so140921pab.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 02 Mar 2016 22:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=bp2NP0F6243qu3M8r65JRXHpz1+oPMHeOF1IF9CEopc=;
	b=JnMtIglSEWq3wJ8Fq7F/B2s46VDyA+ktMeC0I+3WiHeWWYD+9LDdnfcx7Wd+bITjgW
	SUMQkxuQlGwa1LMSFDXegXgw1ZZ4S/HfOgv6V6MkrJXfYc8Rs0hbedRQtfHYpNvjki1l
	7IkI65/woKOYM/4Nqg4b56mQeFssviJryZ8HgFEXE6jlKvvZoPAumSrFDpzty3CUfCXm
	CLbF3564Nn+b2JwT38aYN+aV+qw5lgz6OvSvY6ChTMgVGwC3FCFoEr/FCtcGowjOefNC
	LnjaSvAqdXUCCpxbiLbmQhd9rIhMRCg/ZUlzWfhMGn5cIsQ5WSj2BYsP/fD8Gt1lw0hy
	1WRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=bp2NP0F6243qu3M8r65JRXHpz1+oPMHeOF1IF9CEopc=;
	b=AYZ012R6ewPDKp1id7RQpZt63ZnPysmTnMwpjllK55kZ5wPE/tO8687xHYnw1cRFv7
	Wnj6hr7fNu0HFkfKlkH5XGKO75znIeaCv1+rCeScKSu9NJJ0UHrK57LrEWvE8EY3Mfy0
	j+mOPK0+9IymVfkkIjr9bYgILAT/cGyUTO7q4wurjz+k13UYr1a00Yy4vsoVVWaUBs5A
	MUqXiWguiMNh4ODt2Y6n6ZMfk/Q9gLnZ33gcV3Wb8hXF1pa2n9Ur6L6jchlF/uZQlWXB
	cPvkPtGBxYzW8EdVn3ZdWWOS/k+a5r+6fG2zr88PFynfKF+qSp30DAvyEjviW3Ltx6tt
	9FAA==
X-Gm-Message-State: AD7BkJLqudHkqc0Hb9OEVN+9FCOwB8sx0SahUk+TEjukTEUyVaOAI+S/y86kasVBfmtzdw==
X-Received: by 10.66.220.7 with SMTP id ps7mr1461714pac.58.1456987292125;
	Wed, 02 Mar 2016 22:41:32 -0800 (PST)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	r62sm57476673pfr.26.2016.03.02.22.41.31
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 02 Mar 2016 22:41:31 -0800 (PST)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  2 Mar 2016 22:47:39 -0800
Message-Id: <67e5362143633c50a23abc33c5402455fa19975f.1456987460.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <05400d100e891245541e10b1d5db9a783004b20e.1456987460.git.avery.brian@gmail.com>
References: <05400d100e891245541e10b1d5db9a783004b20e.1456987460.git.avery.brian@gmail.com>
In-Reply-To: <cover.1456987460.git.avery.brian@gmail.com>
References: <cover.1456987460.git.avery.brian@gmail.com>
Subject: [PATCH 2/7] toasterui: update list of events
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
X-List-Received-Date: Thu, 03 Mar 2016 06:41:32 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Removed events not used in the code from the list.
Added events that are used in the code.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/bb/ui/toasterui.py | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/lib/bb/ui/toasterui.py b/lib/bb/ui/toasterui.py
index 377526e..4bb33f1 100644
--- a/lib/bb/ui/toasterui.py
+++ b/lib/bb/ui/toasterui.py
@@ -102,10 +102,13 @@ _evt_list = [
     "bb.command.CommandExit",
     "bb.command.CommandFailed",
     "bb.cooker.CookerExit",
-    "bb.event.BuildBase",
+    "bb.event.BuildCompleted",
+    "bb.event.BuildStarted",
     "bb.event.CacheLoadCompleted",
     "bb.event.CacheLoadProgress",
     "bb.event.CacheLoadStarted",
+    "bb.event.ConfigParsed",
+    "bb.event.DepTreeGenerated",
     "bb.event.LogExecTTY",
     "bb.event.MetadataEvent",
     "bb.event.MultipleProviders",
@@ -113,9 +116,16 @@ _evt_list = [
     "bb.event.ParseCompleted",
     "bb.event.ParseProgress",
     "bb.event.ParseStarted",
-    "bb.runqueue.runQueueExitWait",
+    "bb.event.RecipeParsed",
+    "bb.event.SanityCheck",
+    "bb.event.SanityCheckPassed",
+    "bb.event.TreeDataPreparationCompleted",
+    "bb.event.TreeDataPreparationStarted",
+    "bb.runqueue.runQueueTaskCompleted",
     "bb.runqueue.runQueueTaskFailed",
+    "bb.runqueue.runQueueTaskSkipped",
     "bb.runqueue.runQueueTaskStarted",
+    "bb.runqueue.sceneQueueTaskCompleted",
     "bb.runqueue.sceneQueueTaskFailed",
     "bb.runqueue.sceneQueueTaskStarted",
     "logging.LogRecord"]
@@ -395,19 +405,6 @@ def main(server, eventHandler, params):
                 main.shutdown = 1
                 continue
 
-            # ignore
-            if isinstance(event, (bb.event.BuildBase,
-                                  bb.event.StampUpdate,
-                                  bb.event.RecipePreFinalise,
-                                  bb.runqueue.runQueueEvent,
-                                  bb.runqueue.runQueueExitWait,
-                                  bb.event.OperationProgress,
-                                  bb.command.CommandFailed,
-                                  bb.command.CommandExit,
-                                  bb.command.CommandCompleted,
-                                  bb.event.ReachableStamps)):
-                continue
-
             if isinstance(event, bb.event.DepTreeGenerated):
                 buildinfohelper.store_dependency_information(event)
                 continue
-- 
1.9.1


