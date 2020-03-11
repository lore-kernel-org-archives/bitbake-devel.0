Return-Path: <jpewhacker@gmail.com>
Received: from mail-il1-f196.google.com (mail-il1-f196.google.com
	[209.85.166.196])
	by mail.openembedded.org (Postfix) with ESMTP id 2967661BE5
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 11 Mar 2020 23:28:53 +0000 (UTC)
Received: by mail-il1-f196.google.com with SMTP id k29so3778091ilg.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 11 Mar 2020 16:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=/CdgLDvzbeX53pWv2FsPR2gj2eJY16uI1tCnR+wJ1Os=;
	b=VBd1Qpzwz0+cUbwqDZa39/796KkgfMCBpIJVrqqHi2KmPjbWbjSR/VzdJWk0t2xSdZ
	SznxZXadB7UjPT6fyFyqQHJVfsXmBdYmrik4itcJGmANJYozGtNJgjRpqtxRH5WpxnZA
	SQ2yNBMgidnOS5c/+QMPo545Zcc1Y6iWXMihuVWSNSxKFBcDwdN6ZA96jgXj1+gtBXHT
	UvAfAXQAs3Ik1I+GJJCXPmA1isHfdCo4jsVj9EitQWMY327W6IgcE/jYBupGPk5HehY6
	s+oDQarKNog5S5B1uV/MIV2MtmuuGTe146hepY6u5/rLqONIlAqht7rn2PW7vaFwG9v5
	MevQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=/CdgLDvzbeX53pWv2FsPR2gj2eJY16uI1tCnR+wJ1Os=;
	b=MGyyZH+LyWhwgq43rHTXMS8laLN9ADDV7pHpljHBoTXaAwHUeXgool2bOPqrLOwKbi
	D+fF901mAdwMXwEIy5eIA9S8OjBFo7M8xqGAZz73vVy5RIIg9044pAA2Pb1j7pxxj3Zp
	we5Tu8XTiSxezCDt2+Eg5GZpJ4xsDl/4CbiPg0Jbme2wAF6pMHdmXt1CAicjabe+MTw3
	TzovjMSC148zXWFTgngX7iyShrx/B8KJbmvgecEUhHFZghwCL9TmW2pHRSaPXr6Vxial
	hEgC7oLADw8t/GgnKixTreeG2H7QqXIN7oCFhvIbMusCWWwU/G1deZ3RPdbKv6tHNqUb
	JduQ==
X-Gm-Message-State: ANhLgQ04sZGpFb+zE0QQjbOYRoF1t28mCPG+SIikjbVhZYvd9SbLAerT
	Q1r7VsYGpXKWnirH1X0C5Pfu2+eHrEU=
X-Google-Smtp-Source: ADFU+vtSndVCMb76bUHR/LkGiOGACIzl0jnid/5J6j//JuUVPb1f1H2ezAorsJ1zJ3xOXROqz2bzsQ==
X-Received: by 2002:a92:3a1d:: with SMTP id h29mr5865368ila.112.1583969333709; 
	Wed, 11 Mar 2020 16:28:53 -0700 (PDT)
Received: from OLA-8C37N23.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id w3sm3297603ior.55.2020.03.11.16.28.52
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Wed, 11 Mar 2020 16:28:52 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 11 Mar 2020 18:28:45 -0500
Message-Id: <20200311232847.2874-3-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200311232847.2874-1-JPEWhacker@gmail.com>
References: <20200311232847.2874-1-JPEWhacker@gmail.com>
Subject: [PATCH 2/4] bitbake: msg: Add helper to merge logging configs
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

Adds a function that can be used by UI front ends to merge logging
configuration fragments.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/msg.py | 89 +++++++++++++++++++++++--------------------
 1 file changed, 48 insertions(+), 41 deletions(-)

diff --git a/bitbake/lib/bb/msg.py b/bitbake/lib/bb/msg.py
index ee3c38b5a4..c22d0d3e15 100644
--- a/bitbake/lib/bb/msg.py
+++ b/bitbake/lib/bb/msg.py
@@ -193,6 +193,53 @@ def has_console_handler(logger):
                 return True
     return False
 
+def mergeLoggingConfig(logconfig, userconfig):
+    logconfig = copy.deepcopy(logconfig)
+    userconfig = copy.deepcopy(userconfig)
+
+    # Merge config with the default config
+    if userconfig.get('version') != logconfig['version']:
+        raise BaseException("Bad user configuration version. Expected %r, got %r" % (logconfig['version'], userconfig.get('version')))
+
+    # Set some defaults to make merging easier
+    userconfig.setdefault("loggers", {})
+
+    # If a handler, formatter, or filter is defined in the user
+    # config, it will replace an existing one in the default config
+    for k in ("handlers", "formatters", "filters"):
+        logconfig.setdefault(k, {}).update(userconfig.get(k, {}))
+
+    seen_loggers = set()
+    for name, l in logconfig["loggers"].items():
+        # If the merge option is set, merge the handlers and
+        # filters. Otherwise, if it is False, this logger won't get
+        # add to the set of seen loggers and will replace the
+        # existing one
+        if l.get('bitbake_merge', True):
+            ulogger = userconfig["loggers"].setdefault(name, {})
+            ulogger.setdefault("handlers", [])
+            ulogger.setdefault("filters", [])
+
+            # Merge lists
+            l.setdefault("handlers", []).extend(ulogger["handlers"])
+            l.setdefault("filters", []).extend(ulogger["filters"])
+
+            # Replace other properties if present
+            if "level" in ulogger:
+                l["level"] = ulogger["level"]
+
+            if "propagate" in ulogger:
+                l["propagate"] = ulogger["propagate"]
+
+            seen_loggers.add(name)
+
+    # Add all loggers present in the user config, but not any that
+    # have already been processed
+    for name in set(userconfig["loggers"].keys()) - seen_loggers:
+        logconfig["loggers"][name] = userconfig["loggers"][name]
+
+    return logconfig
+
 def setLoggingConfig(defaultconfig, userconfigfile=None):
     logconfig = copy.deepcopy(defaultconfig)
 
@@ -208,47 +255,7 @@ def setLoggingConfig(defaultconfig, userconfigfile=None):
                 raise BaseException("Unrecognized file format: %s" % userconfigfile)
 
             if userconfig.get('bitbake_merge', True):
-                # Merge config with the default config
-                if userconfig.get('version') != logconfig['version']:
-                    raise BaseException("Bad user configuration version. Expected %r, got %r" % (logconfig['version'], userconfig.get('version')))
-
-                # Set some defaults to make merging easier
-                userconfig.setdefault("loggers", {})
-
-                # If a handler, formatter, or filter is defined in the user
-                # config, it will replace an existing one in the default config
-                for k in ("handlers", "formatters", "filters"):
-                    logconfig.setdefault(k, {}).update(userconfig.get(k, {}))
-
-                seen_loggers = set()
-                for name, l in logconfig["loggers"].items():
-                    # If the merge option is set, merge the handlers and
-                    # filters. Otherwise, if it is False, this logger won't get
-                    # add to the set of seen loggers and will replace the
-                    # existing one
-                    if l.get('bitbake_merge', True):
-                        ulogger = userconfig["loggers"].setdefault(name, {})
-                        ulogger.setdefault("handlers", [])
-                        ulogger.setdefault("filters", [])
-
-                        # Merge lists
-                        l.setdefault("handlers", []).extend(ulogger["handlers"])
-                        l.setdefault("filters", []).extend(ulogger["filters"])
-
-                        # Replace other properties if present
-                        if "level" in ulogger:
-                            l["level"] = ulogger["level"]
-
-                        if "propagate" in ulogger:
-                            l["propagate"] = ulogger["propagate"]
-
-                        seen_loggers.add(name)
-
-                # Add all loggers present in the user config, but not any that
-                # have already been processed
-                for name in set(userconfig["loggers"].keys()) - seen_loggers:
-                    logconfig["loggers"][name] = userconfig["loggers"][name]
-
+                logconfig = mergeLoggingConfig(logconfig, userconfig)
             else:
                 # Replace the entire default config
                 logconfig = userconfig
-- 
2.17.1


