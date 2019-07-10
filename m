Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
	[209.85.221.51])
	by mail.openembedded.org (Postfix) with ESMTP id 8989E7F02A
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jul 2019 23:54:34 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id p13so4203375wru.10
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jul 2019 16:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=YNcYL5bZB/a9Vi+J4yMAbAtNX9U3dOWXAJ0tSFPsuxc=;
	b=WOzFf04XACwrl4Foo/nVIn0PTqZFfWCtORyBTaZQJzIx+pMN0orSKn4DzVNkn9AlDd
	91d2meeucfiTPh9L6tofxbCznOBTIuJmIRL+isxQ1j/3rbxOOvWiAmlewQmSp9ZNt1QL
	Dx/xBCLFWyRQeWomX2OhycqBhmXlxkwSFOHeQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=YNcYL5bZB/a9Vi+J4yMAbAtNX9U3dOWXAJ0tSFPsuxc=;
	b=sb7jH56/F0Cud70NQ18FJ7h29eKb3+71vocn7MaapGU9gQ8oaMmtRwzE2MddhRuKaU
	/EbolneW5gdlqG50JAVIrL/oWNRGV9MLoCiKaSQ7zYoZFI8dD2gfgQE41w6d9cvTva5t
	1VbxOxbl44aoVLiWfzhtGr/ODJq/4weduwp5vNAmsexu5+L3UOMh7oHV2VpbsmYPEYGp
	yU0dSY7g40nd1Q7KLn3ekIblY1lkqE3ifeCyBXQWyTMvnQ1ZvWhJr6BHiuOakGtplRX9
	wZ4s6tZ13XV2Qe8+kOaqcPMscslsvTmuPHc22Gjj/vw4XEhbW+AhD9aX3UwRIUali75M
	gxiw==
X-Gm-Message-State: APjAAAVfvzIzhI39Eqza47210gj4deVzLp6aYa+dg9rvbRNLmUNmNB3x
	7pACNAXyt6LdWmPfT96UiLEtSvLMWHY=
X-Google-Smtp-Source: APXvYqyY2iAezEGXJSg1eVswBDKkQJxeFQRN7LKYpRUDskDyZ+uWFbcvOFy0BnnutQL+kXKP+8dbhA==
X-Received: by 2002:adf:dd0f:: with SMTP id a15mr207178wrm.265.1562802874958; 
	Wed, 10 Jul 2019 16:54:34 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	r12sm4710783wrt.95.2019.07.10.16.54.34
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Wed, 10 Jul 2019 16:54:34 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 11 Jul 2019 00:54:08 +0100
Message-Id: <20190710235420.23825-14-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190710235420.23825-1-richard.purdie@linuxfoundation.org>
References: <20190710235420.23825-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 14/26] event/runqueue: Drop StampUpdate event, its pointless/unused
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
X-List-Received-Date: Wed, 10 Jul 2019 23:54:34 -0000
Content-Transfer-Encoding: 8bit

Whilst this class has existed for years, it doesn't have any
users and has a questionable interface. Drop it to allow for further
simplification and changes.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/event.py       | 17 -----------------
 lib/bb/runqueue.py    |  9 ---------
 lib/bb/tests/event.py |  8 --------
 lib/bb/ui/knotty.py   |  1 -
 4 files changed, 35 deletions(-)

diff --git a/lib/bb/event.py b/lib/bb/event.py
index 248fc1a6f8..d44621edf4 100644
--- a/lib/bb/event.py
+++ b/lib/bb/event.py
@@ -404,23 +404,6 @@ class RecipeTaskPreProcess(RecipeEvent):
 class RecipeParsed(RecipeEvent):
     """ Recipe Parsing Complete """
 
-class StampUpdate(Event):
-    """Trigger for any adjustment of the stamp files to happen"""
-
-    def __init__(self, targets, stampfns):
-        self._targets = targets
-        self._stampfns = stampfns
-        Event.__init__(self)
-
-    def getStampPrefix(self):
-        return self._stampfns
-
-    def getTargets(self):
-        return self._targets
-
-    stampPrefix = property(getStampPrefix)
-    targets = property(getTargets)
-
 class BuildBase(Event):
     """Base class for bitbake build events"""
 
diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 46146466fc..30b13d54a8 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2528,17 +2528,8 @@ def start_runqueue_tasks(rqexec):
         for task in self.rq.scenequeue_notcovered:
             logger.debug(1, 'Not skipping task %s', task)
 
-        for mc in rqexec.rqdata.dataCaches:
-            target_pairs = []
-            for tid in rqexec.rqdata.target_tids:
-                (tidmc, fn, taskname, _) = split_tid_mcfn(tid)
-                if tidmc == mc:
-                    target_pairs.append((fn, taskname))
-
-            event.fire(bb.event.StampUpdate(target_pairs, rqexec.rqdata.dataCaches[mc].stamp), rqexec.cfgData)
         rqexec.sched.initbuildable()
 
-
 class TaskFailure(Exception):
     """
     Exception raised when a task in a runqueue fails
diff --git a/lib/bb/tests/event.py b/lib/bb/tests/event.py
index b6e40c6ae9..9229b63d47 100644
--- a/lib/bb/tests/event.py
+++ b/lib/bb/tests/event.py
@@ -561,14 +561,6 @@ class EventClassesTest(unittest.TestCase):
         self.assertEqual(event.fn(1), callback(1))
         self.assertEqual(event.pid, EventClassesTest._worker_pid)
 
-    def test_StampUpdate(self):
-        targets = ["foo", "bar"]
-        stampfns = [lambda:"foobar"]
-        event = bb.event.StampUpdate(targets, stampfns)
-        self.assertEqual(event.targets, targets)
-        self.assertEqual(event.stampPrefix, stampfns)
-        self.assertEqual(event.pid, EventClassesTest._worker_pid)
-
     def test_BuildBase(self):
         """ Test base class for bitbake build events """
         name = "foo"
diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index 88f638fb38..1c72aa2947 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -660,7 +660,6 @@ def main(server, eventHandler, params, tf = TerminalFilter):
             # ignore
             if isinstance(event, (bb.event.BuildBase,
                                   bb.event.MetadataEvent,
-                                  bb.event.StampUpdate,
                                   bb.event.ConfigParsed,
                                   bb.event.MultiConfigParsed,
                                   bb.event.RecipeParsed,
-- 
2.20.1


