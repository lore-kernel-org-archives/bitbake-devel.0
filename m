Return-Path: <bartosz@woronicz.com>
Received: from mail-lf0-f68.google.com (mail-lf0-f68.google.com
	[209.85.215.68])
	by mail.openembedded.org (Postfix) with ESMTP id 8694970179
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 13 Jun 2016 12:16:18 +0000 (UTC)
Received: by mail-lf0-f68.google.com with SMTP id l184so1261032lfl.1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 13 Jun 2016 05:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=woronicz.com; s=greetings;
	h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=kRvFoWwSGjIaggMVLLhpWThZ+JlLmqjO1Y8pbG9UZnA=;
	b=a8nJN+jNqQXVhpDVsZP9Oa2xJcd+aatRPXwx5uArE2Vc8WxbCoBIFqVliZi/KM8E38
	/YB0ocff3IH0MAfbTLDccKmWral4euC6xQqAXcGP3+iaOecJ2X6CMChzu+wBhPdKDkH7
	zA5WxGeGr8dD4bHVJnOOFZQDlMfdX+FUgqPOU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mastier.pl; s=mastier;
	h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=kRvFoWwSGjIaggMVLLhpWThZ+JlLmqjO1Y8pbG9UZnA=;
	b=Qg6dH6DiAt66nrmNrMtHJUpN6t3ejj4cul/lGwGz9cABYy3UPnJSEtP/4p2jznsJqp
	G6YsI+YIuIeGSEjMAUYPIxtFmM2QZfo2aCR+Gt30Jlz6L89NrYjgvhswluJnQywBuAEe
	C7jzH57jMZ+SyyZCK0STnJaSiOOal7446A5Ic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
	:in-reply-to:references;
	bh=kRvFoWwSGjIaggMVLLhpWThZ+JlLmqjO1Y8pbG9UZnA=;
	b=IK2PSmlAm8q49dQ9UWTZolLx1DPwR8ylKJLBOKH2r5PIE2tiGSNGtIgefODbrcMhJ8
	aO59Yem6xNXZ1d28OpZX8EU8qBMYvYy2jhVkLzqrSzRdTKLSOOjEMXyGvrhnn1qBFVDG
	Nlb3QPyvsvZNeMGkL4DBsoCVjnXqYr1cz9Bynwwl4Sy5KfddSqY/qhPWiCIR0L2rdojg
	yJ9u/DRTFJ3XQhPhO5UdQZlMOy4GMyXWtIVIcjqdlzFymjuxYpIKaNeba59L6vSFXyBx
	ud2dYcAR8hJVe+glIRtv0H51n0vZMHozqJiDYngn+ao5LneaCkLilFWyW6ZgqipB4pfo
	h16Q==
X-Gm-Message-State: ALyK8tLcQQSPDSk2Pqgf2iMb8yONzo9X2PN0qi9uWgRduxq81x8tQiL9gWZTVjeYp9dowA==
X-Received: by 10.46.0.159 with SMTP id e31mr3585766lji.54.1465820178611;
	Mon, 13 Jun 2016 05:16:18 -0700 (PDT)
Received: from localhost.localdomain (user-94-254-241-90.play-internet.pl.
	[94.254.241.90]) by smtp.gmail.com with ESMTPSA id
	f20sm1247607lji.46.2016.06.13.05.16.17
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 13 Jun 2016 05:16:17 -0700 (PDT)
Sender: Bartosz Woronicz <bartosz@woronicz.com>
From: Bartosz 'mastier' Woronicz <mastier@mastier.pl>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 13 Jun 2016 14:16:08 +0200
Message-Id: <1465820168-1657-2-git-send-email-mastier@mastier.pl>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1465820168-1657-1-git-send-email-mastier@mastier.pl>
References: <1465820168-1657-1-git-send-email-mastier@mastier.pl>
Subject: [PATCH 2/2] depexp: fix the progressbar
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
X-List-Received-Date: Mon, 13 Jun 2016 12:16:21 -0000

Signed-off-by: Bartosz 'mastier' Woronicz <mastier@mastier.pl>
---
 bitbake/lib/bb/ui/depexp.py | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/ui/depexp.py b/bitbake/lib/bb/ui/depexp.py
index 6a6bfd5..2903e43 100644
--- a/bitbake/lib/bb/ui/depexp.py
+++ b/bitbake/lib/bb/ui/depexp.py
@@ -264,7 +264,6 @@ def main(server, eventHandler, params):
                 continue
 
             if isinstance(event, bb.event.CacheLoadCompleted):
-                bardialog.hide()
                 continue
 
             if isinstance(event, bb.event.ParseStarted):
@@ -274,7 +273,6 @@ def main(server, eventHandler, params):
                 gtk.gdk.threads_enter()
                 pbar.update(0)
                 bardialog.set_title("Processing recipes")
-
                 gtk.gdk.threads_leave()
 
             if isinstance(event, bb.event.ParseProgress):
@@ -286,13 +284,31 @@ def main(server, eventHandler, params):
                 continue
 
             if isinstance(event, bb.event.ParseCompleted):
-                bardialog.hide()
+                continue
+
+            if isinstance(event, bb.event.TreeDataPreparationStarted):
+                gtk.gdk.threads_enter()
+                pbar.update(0)
+                bardialog.set_title("Processing tree data")
+                gtk.gdk.threads_leave()
+                continue
+
+            if isinstance(event, bb.event.TreeDataPreparationProgress):
+                x = event.current
+                gtk.gdk.threads_enter()
+                pbar.update(x * 1.0 / event.total)
+                pbar.set_title('')
+                gtk.gdk.threads_leave()
+                continue
+
+            if isinstance(event, bb.event.TreeDataPreparationCompleted):
                 continue
 
             if isinstance(event, bb.event.DepTreeGenerated):
                 gtk.gdk.threads_enter()
                 dep.parse(event._depgraph)
                 gtk.gdk.threads_leave()
+                bardialog.hide()
 
             if isinstance(event, bb.command.CommandCompleted):
                 continue
-- 
2.7.4


