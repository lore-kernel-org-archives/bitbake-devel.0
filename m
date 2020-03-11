Return-Path: <jpewhacker@gmail.com>
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com
	[209.85.166.171])
	by mail.openembedded.org (Postfix) with ESMTP id 74D2D61BE5
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 11 Mar 2020 23:28:54 +0000 (UTC)
Received: by mail-il1-f171.google.com with SMTP id e8so3715566ilc.13
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 11 Mar 2020 16:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=Ywv3v+cKCvoSttSUXynqtrKDqYU11boKFpZJEYBElW0=;
	b=eLY9C5pAuHO4E6XiLrbXjLIncC8wCccM/iWmjzOfrR+QXw+pDMhJzlz3UBF/nfRgnF
	Fu7Q+8H91HRrY0EBjk5LUJeUxOarFuB9up7IbDtz5U3CQNL7mYQ5LObr44yZTHtYwk9R
	jnC9dQwQX9EaaoR3nuH7ONEX/oj56h0hUBXOPHq28Aw+7a57dtdQPq4AJn0/0lstxuMn
	Jzgshxe6qpQdPlkb5hoiKyywSKUxCSalbOLHZzs7gnvIheqW7Lz0LhngjjRgXjTTCGTt
	5NX6Re1s3UOklOl2VgsGfEiOjvYbbIDsmX0+8sXHy0e3vhkDihxW8gr0YCgWT640Lwc8
	DuwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=Ywv3v+cKCvoSttSUXynqtrKDqYU11boKFpZJEYBElW0=;
	b=CbG0wP5Kkazq4calPTmhdhScVXcvVO1pxXXrzobPH5P3WvqFefVwtNu+eTs6kTWDt4
	4nMbKEBcbEVGFqkBHVhQtdC1acx1PbahhjPZ+3jzwCDA0drzNFqmiGT63Nw2MvCj6SiL
	m+WA6QY4DZGma+sJZSt31vukcuW19Wb/YrKOFkfjYBewNcd3AnqtPYXyjW4TaKHTCq3Q
	dDBHFXKtRY+VnTNUFpt8g++s0k+fdEBftFZxeCXiXuFqsEztlp9IGN/2vWqx6LH+GSY7
	+a084NKWpVAEp1YFV8EzwHsKdkOOWQ3b/bT6eUIHYVs76nN5r6SzO01YavYHfDCUZ8oO
	YKrA==
X-Gm-Message-State: ANhLgQ0mDARCMNhTfdHtEEXV7UzkDcrS5v6qdo/tUVigYbCVq1X0vvVO
	zTARW2EcgEpPGXTWz1kefppcRHG7nCw=
X-Google-Smtp-Source: ADFU+vuLZU7eLygpEi6zuswWbvHkXEjpZAmlBVeY37NQBf3d9aYNj7FWxcovYZpsa4nbReflWZqykA==
X-Received: by 2002:a92:b6d0:: with SMTP id m77mr5078679ill.247.1583969335011; 
	Wed, 11 Mar 2020 16:28:55 -0700 (PDT)
Received: from OLA-8C37N23.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id w3sm3297603ior.55.2020.03.11.16.28.53
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Wed, 11 Mar 2020 16:28:54 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 11 Mar 2020 18:28:46 -0500
Message-Id: <20200311232847.2874-4-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200311232847.2874-1-JPEWhacker@gmail.com>
References: <20200311232847.2874-1-JPEWhacker@gmail.com>
Subject: [PATCH 3/4] bitbake: knotty: Update hash equivalence logging
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
X-List-Received-Date: Wed, 11 Mar 2020 23:28:54 -0000

Updates hash equivalence logging so that the interesting VERBOSE
messages are always logged to the consolelog file so that issues in
individual user builds can be diagnosed. The autobuilder logging config
then updates this so that they also are shown on stdout, since the
consolelog file is not capture there.

In order to facilitate this, 2 new logging handlers were added,
"BitBake.verbconsole" and "BitBake.verbconsolelog". Neither of these
handlers are attached to anything by default, but they will log any
messages that wouldn't otherwise be logged by the normal console or
consolelog handlers. Users can attach whatever loggers the desire to
this handler to get them to appear on the console or in the consolelog,
as demonstrated by the autobuilderlog.json file.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/contrib/autobuilderlog.json | 18 +-------
 bitbake/lib/bb/ui/knotty.py         | 68 +++++++++++++++++++++++++----
 2 files changed, 62 insertions(+), 24 deletions(-)

diff --git a/bitbake/contrib/autobuilderlog.json b/bitbake/contrib/autobuilderlog.json
index 103a1141f6..193a675a1f 100644
--- a/bitbake/contrib/autobuilderlog.json
+++ b/bitbake/contrib/autobuilderlog.json
@@ -1,27 +1,13 @@
 {
     "version": 1,
-    "handlers": {
-        "autobuilderlog": {
-            "class": "logging.FileHandler",
-            "formatter": "logfileFormatter",
-            "level": "DEBUG",
-            "filename": "autobuilder.log",
-            "mode": "w"
-        }
-    },
-    "formatters": {
-            "logfileFormatter": {
-                "format": "%(name)s: %(levelname)s: %(message)s"
-            }
-    },
     "loggers": {
         "BitBake.SigGen.HashEquiv": {
             "level": "VERBOSE",
-            "handlers": ["autobuilderlog"]
+            "handlers": ["BitBake.verbconsole"]
         },
         "BitBake.RunQueue.HashEquiv": {
             "level": "VERBOSE",
-            "handlers": ["autobuilderlog"]
+            "handlers": ["BitBake.verbconsole"]
         }
     }
 }
diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
index 2dfce90a4f..b4df5f6e88 100644
--- a/bitbake/lib/bb/ui/knotty.py
+++ b/bitbake/lib/bb/ui/knotty.py
@@ -419,6 +419,18 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                 "stream": "ext://sys.stderr",
                 "filters": ["BitBake.stderrFilter"],
             },
+            # This handler can be used if specific loggers should print on
+            # the console at a lower severity than the default. It will
+            # display any messages sent to it that are lower than then
+            # BitBake.console logging level (so as to prevent duplication of
+            # messages). Nothing is attached to this handler by default
+            "BitBake.verbconsole": {
+                "class": "logging.StreamHandler",
+                "formatter": "BitBake.consoleFormatter",
+                "level": 1,
+                "stream": "ext://sys.stdout",
+                "filters": ["BitBake.verbconsoleFilter"],
+            },
         },
         "formatters": {
             # This format instance will get color output enabled by the
@@ -442,7 +454,11 @@ def main(server, eventHandler, params, tf = TerminalFilter):
             "BitBake.stderrFilter": {
                 "()": "bb.msg.LogFilterGEQLevel",
                 "level": "ERROR"
-            }
+            },
+            "BitBake.verbconsoleFilter": {
+                "()": "bb.msg.LogFilterLTLevel",
+                "level": console_loglevel
+            },
         },
         "loggers": {
             "BitBake": {
@@ -455,13 +471,49 @@ def main(server, eventHandler, params, tf = TerminalFilter):
 
     # Enable the console log file if enabled
     if consolelogfile and not params.options.show_environment and not params.options.show_versions:
-        logconfig["handlers"]["BitBake.consolelog"] ={
-            "class": "logging.FileHandler",
-            "formatter": "BitBake.logfileFormatter",
-            "level": "INFO",
-            "filename": consolelogfile,
-        }
-        logconfig["loggers"]["BitBake"]["handlers"].append("BitBake.consolelog")
+        logconfig = bb.msg.mergeLoggingConfig(logconfig, {
+                "version": 1,
+                "handlers" : {
+                    "BitBake.consolelog": {
+                        "class": "logging.FileHandler",
+                        "formatter": "BitBake.logfileFormatter",
+                        "level": loglevel,
+                        "filename": consolelogfile,
+                    },
+                    # Just like verbconsole, anything sent here will go to the
+                    # log file, unless it would go to BitBake.consolelog
+                    "BitBake.verbconsolelog" : {
+                        "class": "logging.FileHandler",
+                        "formatter": "BitBake.logfileFormatter",
+                        "level": 1,
+                        "filename": consolelogfile,
+                        "filters": ["BitBake.verbconsolelogFilter"],
+                    },
+                },
+                "filters": {
+                    "BitBake.verbconsolelogFilter": {
+                        "()": "bb.msg.LogFilterLTLevel",
+                        "level": loglevel,
+                    },
+                },
+                "loggers": {
+                    "BitBake": {
+                        "handlers": ["BitBake.consolelog"],
+                    },
+
+                    # Other interesting things that we want to keep an eye on
+                    # in the log files in case someone has an issue, but not
+                    # necessarily show to the user on the console
+                    "BitBake.SigGen.HashEquiv": {
+                        "level": "VERBOSE",
+                        "handlers": ["BitBake.verbconsolelog"],
+                    },
+                    "BitBake.RunQueue.HashEquiv": {
+                        "level": "VERBOSE",
+                        "handlers": ["BitBake.verbconsolelog"],
+                    }
+                }
+            })
 
         bb.utils.mkdirhier(os.path.dirname(consolelogfile))
         loglink = os.path.join(os.path.dirname(consolelogfile), 'console-latest.log')
-- 
2.17.1


