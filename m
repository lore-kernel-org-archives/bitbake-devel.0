Return-Path: <patrick.ohly@intel.com>
Received: from mail-io0-f172.google.com (mail-io0-f172.google.com
	[209.85.223.172])
	by mail.openembedded.org (Postfix) with ESMTP id 33FD165C8A
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 May 2016 15:00:15 +0000 (UTC)
Received: by mail-io0-f172.google.com with SMTP id i75so92964086ioa.3
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 May 2016 08:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id;
	bh=3E/tMx7flg7dj/qI4TNduyW3Fy9unK+FuCtgS81Jr0Y=;
	b=pOij1Hho/lIuh3+80gfwDrEVJ6GUM5dSd3C37L8+HlZPNbP9eYip2ApX7n3OfXbvwk
	8AJmsgLqFtk6x8C7UgjX0KExUS0DOIq8ePwSC3QjMEtczS5kCKJfJ3RZd7g7VCQ1E+SR
	eFGSimqABeBdoGUfjbqvIx6H7h0eDoN5ATXmAjXFqXf9Ac4fAqLSIXn1g2vRlBvT9bxn
	+YQKWtVPCH6dR6wgfg1MOz3GBMr5RiCJ3bsyKFPMofqgnUh6Q8hOs5dUzahoktYdh7xi
	/C9R3rB36OjgIqM6tZvv49XBtdVgs7HOyXrlBlhkdYrFWQB6/SO4xWPPuRqdCTRmmJRA
	vRFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=3E/tMx7flg7dj/qI4TNduyW3Fy9unK+FuCtgS81Jr0Y=;
	b=mtTyq4msPWYBybTSaDHxOyRMpocrv80LuNJyThTKieCPl5EPndn1YI79juuuTYYCOs
	5tINr5LkfRKtB49b2byCaMTBt7ThWBdwEwxt5aTklMfLQzthnB/eJLk7InrI+91p6mHy
	p38PX3ugf+it7xdbO33srCj7BmVYewTOtLYQADTrZisc400Xa68rLu3g25L779i+JPro
	rA48NLUqy9TF3YHvYiyRgN9baJYu0wt9SqnBnOQuHtpJ7+HrF2kZmape8iYPp3sEJ1eL
	Oa1inJKvVOEIRCGhOcnaqiiokX0CGnLt5dSvt+hGZ1+NPSEQ5PnhiUIvUt1m38Y5HWg3
	4Q/A==
X-Gm-Message-State: AOPr4FWohJe1X+BARdK5ThVwxhYzvQNcRDnAprqf/RejBPrqRZrM17kLj0Co7kkvXz35SVtl
X-Received: by 10.36.95.143 with SMTP id r137mr9040736itb.24.1463065216139;
	Thu, 12 May 2016 08:00:16 -0700 (PDT)
Received: from pohly-desktop.fritz.box (p5DE8DCA9.dip0.t-ipconnect.de.
	[93.232.220.169])
	by smtp.gmail.com with ESMTPSA id d1sm4499713igv.5.2016.05.12.08.00.14
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Thu, 12 May 2016 08:00:15 -0700 (PDT)
From: Patrick Ohly <patrick.ohly@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 12 May 2016 17:00:10 +0200
Message-Id: <1463065210-3823-1-git-send-email-patrick.ohly@intel.com>
X-Mailer: git-send-email 2.1.4
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
X-List-Received-Date: Thu, 12 May 2016 15:00:16 -0000

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


