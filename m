Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm0-f66.google.com (mail-wm0-f66.google.com [74.125.82.66])
	by mail.openembedded.org (Postfix) with ESMTP id 0723179764
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  7 Sep 2018 13:13:38 +0000 (UTC)
Received: by mail-wm0-f66.google.com with SMTP id c14-v6so14707011wmb.4
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 07 Sep 2018 06:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id;
	bh=PUA9UCWzsT1BSlYQqh99pncd5Wc7I0zRpPW5JeYBxEg=;
	b=T8Wqq5cKB84CTZ1LgBfeeJEtyyF4gVrSsn1E7BuL1O80gDm1yYcVVr19HZBrVDSFCC
	USfr5/NjRzc5sw8xoW0fdGWybHHTOROuzP5tDbF/GrrU3wZW682v9OThwskXJF9tTzBS
	LS2Yeh8ddjn7nn+PjmmqIJCH6Lg5HtFVT6q9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id;
	bh=PUA9UCWzsT1BSlYQqh99pncd5Wc7I0zRpPW5JeYBxEg=;
	b=QnwGXQecELwFrRm1SFNQDcOtbKI1rWUbEJqkt5P6Vh9TjokaAoobYurIiP9TYrsZIP
	ZaGx8PZAQpgE1do9osgtcSgGtwjyrarGaExjXOluSg7Lw9mROxUymDjDx/RTiqXHibU0
	HFR4M6UtCpZdnMpvcKJuey+JTaVrcWexKW2l8m0CVUWmVkOAuiXqHVqskrec2DtuBAlu
	LGTRlVx+p2DVI/oLXgnfUbI5yTbrQ2IQte+xgZQf0uXBW4vJUeqKj04XIORH40jVHi1k
	zW7dR81ihTFGkyUwfbeKsfa5fumvV6HzoXdAX/A1IJpmIj/bCUUt54g+AmC7r+e6hvgi
	/oOA==
X-Gm-Message-State: APzg51C/x3XGS84VyT8CxUw38HBW6hdFJTUWEmNWMWJFnqvyL8DNBKTS
	I18YZiy/nIDCuljKHkgxJNZsWwSiGOY=
X-Google-Smtp-Source: ANB0VdYSiUZD6qMa9KM7thThAT1wVqal/CZ63T1dqyBAfmNxIwP+QpE9ydHTox2bDOtHTUE+tIKfuA==
X-Received: by 2002:a1c:dc41:: with SMTP id
	t62-v6mr5521197wmg.137.1536326019360; 
	Fri, 07 Sep 2018 06:13:39 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	n15-v6sm4793813wrm.27.2018.09.07.06.13.38
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 07 Sep 2018 06:13:38 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  7 Sep 2018 14:13:36 +0100
Message-Id: <20180907131337.19487-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
Subject: [PATCH 1/2] msg: Add explicit verbnote log level
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
X-List-Received-Date: Fri, 07 Sep 2018 13:13:39 -0000

It has become apparant we need a log level which reaches the console but
isn't a warning/error. Add "verbnote" as a way of doing this, behaves as
a note but with a higher priority.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/__init__.py | 16 ++++++++++++++++
 lib/bb/msg.py      |  3 +++
 2 files changed, 19 insertions(+)

diff --git a/lib/bb/__init__.py b/lib/bb/__init__.py
index 4e9f6e3535..170c592acf 100644
--- a/lib/bb/__init__.py
+++ b/lib/bb/__init__.py
@@ -63,6 +63,10 @@ class BBLogger(Logger):
     def verbose(self, msg, *args, **kwargs):
         return self.log(logging.INFO - 1, msg, *args, **kwargs)
 
+    def verbnote(self, msg, *args, **kwargs):
+        return self.log(logging.INFO + 2, msg, *args, **kwargs)
+
+
 logging.raiseExceptions = False
 logging.setLoggerClass(BBLogger)
 
@@ -93,6 +97,18 @@ def debug(lvl, *args):
 def note(*args):
     mainlogger.info(''.join(args))
 
+#
+# A higher prioity note which will show on the console but isn't a warning
+#
+# Something is happening the user should be aware of but they probably did
+# something to make it happen
+#
+def verbnote(*args):
+    mainlogger.verbnote(''.join(args))
+
+#
+# Warnings - things the user likely needs to pay attention to and fix
+#
 def warn(*args):
     mainlogger.warning(''.join(args))
 
diff --git a/lib/bb/msg.py b/lib/bb/msg.py
index f1723be797..96f077ec49 100644
--- a/lib/bb/msg.py
+++ b/lib/bb/msg.py
@@ -40,6 +40,7 @@ class BBLogFormatter(logging.Formatter):
     VERBOSE = logging.INFO - 1
     NOTE = logging.INFO
     PLAIN = logging.INFO + 1
+    VERBNOTE = logging.INFO + 2
     ERROR = logging.ERROR
     WARNING = logging.WARNING
     CRITICAL = logging.CRITICAL
@@ -51,6 +52,7 @@ class BBLogFormatter(logging.Formatter):
         VERBOSE: 'NOTE',
         NOTE    : 'NOTE',
         PLAIN  : '',
+        VERBNOTE: 'NOTE',
         WARNING : 'WARNING',
         ERROR   : 'ERROR',
         CRITICAL: 'ERROR',
@@ -66,6 +68,7 @@ class BBLogFormatter(logging.Formatter):
         VERBOSE : BASECOLOR,
         NOTE    : BASECOLOR,
         PLAIN   : BASECOLOR,
+        VERBNOTE: BASECOLOR,
         WARNING : YELLOW,
         ERROR   : RED,
         CRITICAL: RED,
-- 
2.17.1


