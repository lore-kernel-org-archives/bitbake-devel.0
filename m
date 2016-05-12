Return-Path: <patrick.ohly@intel.com>
Received: from mail-io0-f182.google.com (mail-io0-f182.google.com
	[209.85.223.182])
	by mail.openembedded.org (Postfix) with ESMTP id E2CF960088
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 May 2016 13:59:07 +0000 (UTC)
Received: by mail-io0-f182.google.com with SMTP id i75so90406638ioa.3
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 May 2016 06:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id;
	bh=3E/tMx7flg7dj/qI4TNduyW3Fy9unK+FuCtgS81Jr0Y=;
	b=mJXLgbxNfE2MswcXWvjtFKcYlh6OxHC5im/P50voz7qbFZlWQ0ZmZY2O82W63lsFWw
	n02iouuQ7YAc3aIYIjOV9iNo+vQodCWdJBd29eSzqpORCHlI9dWorOs+zeSJyT+T+wh0
	8R86GU9nj1kNa+6MGHWb719puBw+ykRwJm89bq4YV4qggVZigTPDYdP1UWOBWsthwG3K
	nv8e2Cfx6dhC3FN31D1IDeOLnz4OiIQDRLu1h0AflqE5sMhfIREq4HAM8CRE4dQZYIfg
	0xaMQR1X8GK+ztKErZ3x2kMRqiwY8pcP3RUnAZN1ir0OVJatjSp/bwRvJxg7Av+533+I
	CUQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=3E/tMx7flg7dj/qI4TNduyW3Fy9unK+FuCtgS81Jr0Y=;
	b=FSdVB3qdRCoLGM1s1/jFX/lQc+395fPHqeZvf/aH97rfn4QIpLRmjRs9jTOEkVKZW+
	2XIDxCEpwQXGUQJfCPi8WmBuUbqnHEPEhmeCM+D7cJEbbM9jFSQcawRziJn2WA73qCKp
	RmN8MeAs1aj0+RBx8CWMT4ruKay1QLZK72yFk4FxKxQIXrFB/vHaJXRTLJGctM7tre44
	O2vEAjUJmDmr913uM2gwbA79Lcz9M4ANnEZ5auHMqswVUGojSins9MdosuQWTrGos21e
	DCz5nopnDr14MX50DX75S6TxVHYKOn/XgJLD4dNuUXVSUpgX2Ov7yDFlPXwb7pkNhrSW
	Ikbg==
X-Gm-Message-State: AOPr4FUjAUeU2r2ffrjXlICIHzg6HMrxqhJ1mR3gW8R0z8LdxM+VjbxH23y1BY8y6ux/ZZv+
X-Received: by 10.36.47.74 with SMTP id j71mr7066491itj.48.1463061547565;
	Thu, 12 May 2016 06:59:07 -0700 (PDT)
Received: from pohly-desktop.fritz.box (p5DE8DCA9.dip0.t-ipconnect.de.
	[93.232.220.169])
	by smtp.gmail.com with ESMTPSA id 198sm3349892itk.5.2016.05.12.06.59.06
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Thu, 12 May 2016 06:59:06 -0700 (PDT)
From: Patrick Ohly <patrick.ohly@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 12 May 2016 15:58:59 +0200
Message-Id: <1463061539-13363-1-git-send-email-patrick.ohly@intel.com>
X-Mailer: git-send-email 2.1.4
X-Mailman-Approved-At: Thu, 12 May 2016 14:12:16 +0000
Subject: [PATCH] runqueue.py: always emit bb.event.DepTreeGenerated
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
X-List-Received-Date: Thu, 12 May 2016 13:59:09 -0000

The data included in the event is useful for implementing a pre-build
check that warns about unexpected components, for example because of
an incorrect configuration or changed dependencies.

Such a check can be done in a .bbclass that gets inherited
globally. But in contrast to a UI, such a class cannot request that
the event shall be emitted, and thus the event has to be emitted
whether there is a consumer or not.

This was done conditionally earlier out of concerns about the
performance impact. But now events are handled more efficiently, so
that concern no longer seems valid: in some simple testing (admittedly
on a fast build workstation), the two lines (generating the data and
emitting the event with it) only took about 0.05 seconds (measured
with timeit). That was for a build with roughly 500 recipes (from
pn-buildlist aka depgraph['pn']), triggered via the command line. That
was even with a consumer of the data active and doing some work, so it
should be even faster when there is no consumer.

Signed-off-by: Patrick Ohly <patrick.ohly@intel.com>
---
 lib/bb/runqueue.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 8b3fe5a..2d4893d 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1122,10 +1122,10 @@ class RunQueue:
             else:
                 self.state = runQueueSceneInit
 
-                # we are ready to run, see if any UI client needs the dependency info
-                if bb.cooker.CookerFeatures.SEND_DEPENDS_TREE in self.cooker.featureset:
-                    depgraph = self.cooker.buildDependTree(self, self.rqdata.taskData)
-                    bb.event.fire(bb.event.DepTreeGenerated(depgraph), self.cooker.data)
+                # we are ready to run,  emit dependency info to any UI or class which
+                # needs it
+                depgraph = self.cooker.buildDependTree(self, self.rqdata.taskData)
+                bb.event.fire(bb.event.DepTreeGenerated(depgraph), self.cooker.data)
 
         if self.state is runQueueSceneInit:
             dump = self.cooker.configuration.dump_signatures
-- 
2.1.4


