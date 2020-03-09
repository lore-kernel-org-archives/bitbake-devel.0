Return-Path: <jpewhacker@gmail.com>
Received: from mail-il1-f196.google.com (mail-il1-f196.google.com
	[209.85.166.196])
	by mail.openembedded.org (Postfix) with ESMTP id 35E3F61B3C
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 Mar 2020 16:33:57 +0000 (UTC)
Received: by mail-il1-f196.google.com with SMTP id e8so9216365ilc.13
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 09 Mar 2020 09:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=mLjSh/smDIFnqbOuzvYns8y//K4ZdwqRVU7Fzta5i70=;
	b=gZUQ9zB4bXqcvoz88sf4iCIPadzd463AVIxvItpxk9l+gPXEz7t8jOLUmwIY6C3gfW
	A3uHXd1cCDOdzOzTX91ZnftcqRo2ud60xf3yIMdFjNIelfV1bjgp+E7ZmrvA2+/9lYU1
	/Ncga+0uVKVoJ4dy6aYgARKXB5r2ncPO/sb1Vs8Miwy4Mp7FOIP8gKKI1sjgUvJCaubd
	OtpLukUPj6VpGOMX8c/lxMGFnXuKifaA4sqmWoNPCUPy4DBaLEh9nE+vZeFo5yOTmw+s
	Nm5U2w+gvEG07OK+4Z4ls1NykqrzILN2Ao2CdtDtcAY5bhTLBto7Y473gpBERi8F4Syd
	D44g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=mLjSh/smDIFnqbOuzvYns8y//K4ZdwqRVU7Fzta5i70=;
	b=l08CWJiY8f/w1/Eb62p2iJU/QcDT4VOlS1mBtXSUV+aCqwof70OFIPru09lI/FVIPA
	jLwYdvokY9F/yKY7NkW0fE0Gw/UVOHW4yMkfKPII40Tlx6xiCrV5wXKXaO/Ve3IpQXcE
	G6kSKaKqrTWCeiX1J83OY9qFBDVznU5MDLXrKLimjl2YZUKJBAj/+XBoi5yz/+hXSDtj
	jNvxBpvhiII/Uu3WxtUTNptNF8t2IexDJf0xJGEPE9OF+1sOclhrUuTLYdiNR8T/dSas
	Vows2B89dR7TmQMfKA2hR5MOPNJpIoiQzaPVJCYufc2Nls0aFNhtNn7f6w2XbUN2sWBy
	GcTQ==
X-Gm-Message-State: ANhLgQ1lHJ3frZpm1m8Jj0lh7nWvaCuw4C6w/nwGpRcOMBATYDNSLYg0
	mctsVKYb04EObWGT86MO9UIhfyCSC0g=
X-Google-Smtp-Source: ADFU+vvMusHFzpH3Wwd0e4y/fVuaL0JCCSOUrSQ9ksz8m3QnBuXwj5Z40jtttOWKpnTwA0M5qxP5jQ==
X-Received: by 2002:a92:3591:: with SMTP id c17mr19982ilf.270.1583771637929;
	Mon, 09 Mar 2020 09:33:57 -0700 (PDT)
Received: from OLA-8C37N23.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id
	q1sm15049593ile.71.2020.03.09.09.33.57
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Mon, 09 Mar 2020 09:33:57 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  9 Mar 2020 11:33:39 -0500
Message-Id: <20200309163353.15362-2-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200309163353.15362-1-JPEWhacker@gmail.com>
References: <20200309163353.15362-1-JPEWhacker@gmail.com>
Cc: docs@lists.yoctoproject.org
Subject: [PATCH 01/15] bitbake: lib/bb/msg.py: Convert default domains to a dictionary
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
X-List-Received-Date: Mon, 09 Mar 2020 16:33:57 -0000

Converts the default domain variable to a dictionary where the keys are
the logging domains and the values are the logging level (instead of the
debug count). This makes it easier to deal with the logging domains and
the awkward conversion from a list to a dictionary only needs to be done
once when logging is initialized. Finally, other code has been written
that already assumes this variable is a dictionary, see:

f04cd93109 ("bitbake: lib/bb: Optimise out debug messages from cooker")

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/__init__.py |  5 +++--
 bitbake/lib/bb/msg.py      | 17 +++++++----------
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/bitbake/lib/bb/__init__.py b/bitbake/lib/bb/__init__.py
index 88641e280b..acd4af13a8 100644
--- a/bitbake/lib/bb/__init__.py
+++ b/bitbake/lib/bb/__init__.py
@@ -43,12 +43,13 @@ class BBLogger(Logger):
         Logger.__init__(self, name)
 
     def bbdebug(self, level, msg, *args, **kwargs):
+        loglevel = logging.DEBUG - level + 1
         if not bb.event.worker_pid:
-            if self.name in bb.msg.loggerDefaultDomains and level > (bb.msg.loggerDefaultDomains[self.name]):
+            if self.name in bb.msg.loggerDefaultDomains and loglevel > (bb.msg.loggerDefaultDomains[self.name]):
                 return
             if level > (bb.msg.loggerDefaultDebugLevel):
                 return
-        return self.log(logging.DEBUG - level + 1, msg, *args, **kwargs)
+        return self.log(loglevel, msg, *args, **kwargs)
 
     def plain(self, msg, *args, **kwargs):
         return self.log(logging.INFO + 1, msg, *args, **kwargs)
diff --git a/bitbake/lib/bb/msg.py b/bitbake/lib/bb/msg.py
index 33c0e2fa19..d1b0e929d4 100644
--- a/bitbake/lib/bb/msg.py
+++ b/bitbake/lib/bb/msg.py
@@ -138,7 +138,7 @@ class BBLogFilterStdOut(BBLogFilter):
 loggerDefaultDebugLevel = 0
 loggerDefaultVerbose = False
 loggerVerboseLogs = False
-loggerDefaultDomains = []
+loggerDefaultDomains = {}
 
 def init_msgconfig(verbose, debug, debug_domains=None):
     """
@@ -148,15 +148,16 @@ def init_msgconfig(verbose, debug, debug_domains=None):
     bb.msg.loggerDefaultVerbose = verbose
     if verbose:
         bb.msg.loggerVerboseLogs = True
+
+    bb.msg.loggerDefaultDomains = {}
     if debug_domains:
-        bb.msg.loggerDefaultDomains = debug_domains
-    else:
-        bb.msg.loggerDefaultDomains = []
+        for (domainarg, iterator) in groupby(debug_domains):
+            dlevel = len(tuple(iterator))
+            bb.msg.loggerDefaultDomains["BitBake.%s" % domainarg] = logging.DEBUG - dlevel + 1
 
 def constructLogOptions():
     debug = loggerDefaultDebugLevel
     verbose = loggerDefaultVerbose
-    domains = loggerDefaultDomains
 
     if debug:
         level = BBLogFormatter.DEBUG - debug + 1
@@ -165,11 +166,7 @@ def constructLogOptions():
     else:
         level = BBLogFormatter.NOTE
 
-    debug_domains = {}
-    for (domainarg, iterator) in groupby(domains):
-        dlevel = len(tuple(iterator))
-        debug_domains["BitBake.%s" % domainarg] = logging.DEBUG - dlevel + 1
-    return level, debug_domains
+    return level, loggerDefaultDomains
 
 def addDefaultlogFilter(handler, cls = BBLogFilter, forcelevel=None):
     level, debug_domains = constructLogOptions()
-- 
2.17.1


