Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f54.google.com (mail-wm0-f54.google.com [74.125.82.54])
	by mail.openembedded.org (Postfix) with ESMTP id 8204D770B4
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  6 Apr 2016 16:47:12 +0000 (UTC)
Received: by mail-wm0-f54.google.com with SMTP id u206so53853184wme.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 06 Apr 2016 09:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
	:references; bh=mCsHa+qpTTwZD7x5hcaeRZ4yaODSfhVpgVHSUUBWwH0=;
	b=jcTIzn7JsOfwc/BpzOF57lUipFCTf3bzDYitOGZIiBFKEePZ1VekT9UmHJVM6kllAG
	8RHvsRTUziO3srbZs/W2PGacmvhUDfNabfOlY7p9/saX7JhBBzb+U4XNORjWArx9kziy
	XsIJan/skWlb6ett/1esj0cyESQ0pOz4HTzA/FYxSwoBO7/7Y0Y62hOia6rZ68Yep5fx
	FyulLZxFVMdJKID0msIi5Dv2OTVnkoDgHT4k+/Cj4fEUYW7EzCZwR+qjtA+5WacTJ20f
	SrLhhxtjc6EkbhBx6kYfzEkYPIEArRqrjSgs8+EeYqZ+Tg8+8pcQThuqWDIwV59vw+7t
	tOpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=mCsHa+qpTTwZD7x5hcaeRZ4yaODSfhVpgVHSUUBWwH0=;
	b=dx4R4NfmEfoNCZLYoAIEC6lNTJRPH1dD8w7GPkAZuHVBuiI8WrmnhJV3TwGT9xV6QZ
	+QjsEEYRfm7p43gQ75pXB9GGHAEPb7tcCGYv4sfTrREEEqNvZZ9wF3WBgb3eSyDz0qA2
	jFa0W7BSgtL03JIFitIOL+eOaN2N/mqqOCtIGUJfCbH5GgsfEQdqMa95ohgvLf8yfFfd
	sMtf4MFqAN13YaF+DK8Iaabk22Cd+xgiKN40BYWDemwl2X9y3brEBIO1gGkpMbw7On/b
	3TCY85o8qdXrPWXBG9OU3G5iiwDWnj3am2u/m2Y5cSXdsB+R1T3M/FmkK96QfIjUq4RC
	d/0A==
X-Gm-Message-State: AD7BkJLG6Ia7/lyYY/gI0ghI1jAIoeOOHH0GQ2Jou+L0z4xb8k9f084JGbcktdtVqYQOd3OC
X-Received: by 10.194.112.34 with SMTP id in2mr23211368wjb.160.1459961232785; 
	Wed, 06 Apr 2016 09:47:12 -0700 (PDT)
Received: from draco.icx.intel.com ([83.217.123.106])
	by smtp.gmail.com with ESMTPSA id gt7sm4145345wjc.1.2016.04.06.09.47.12
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 06 Apr 2016 09:47:12 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  6 Apr 2016 17:46:15 +0100
Message-Id: <4f53c6440bf82d1674f63deaec3fbe6016bc445c.1459960764.git.michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <c991037b9fb1fe7bf4ef2d96d16c7187b0f4299c.1459960764.git.michael.g.wood@intel.com>
References: <c991037b9fb1fe7bf4ef2d96d16c7187b0f4299c.1459960764.git.michael.g.wood@intel.com>
In-Reply-To: <cover.1459960764.git.michael.g.wood@intel.com>
References: <cover.1459960764.git.michael.g.wood@intel.com>
Subject: [PATCH 05/38] uievent: improve BBUIEventQueue code
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
X-List-Received-Date: Wed, 06 Apr 2016 16:47:12 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Return value of self.BBServer.registerEventHandler differs between
jethro and master. To be able to build jethro toaster should be
able to communicate with jethro bitbake server i.e. it must work
with both old and new registerEventHandler call.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/bb/ui/uievent.py | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/lib/bb/ui/uievent.py b/lib/bb/ui/uievent.py
index 6b479bf..df093c5 100644
--- a/lib/bb/ui/uievent.py
+++ b/lib/bb/ui/uievent.py
@@ -24,7 +24,7 @@ server and queue them for the UI to process. This process must be used to avoid
 client/server deadlocks.
 """
 
-import socket, threading, pickle
+import socket, threading, pickle, collections
 from SimpleXMLRPCServer import SimpleXMLRPCServer, SimpleXMLRPCRequestHandler
 
 class BBUIEventQueue:
@@ -51,7 +51,13 @@ class BBUIEventQueue:
         # giving up
 
         for count_tries in range(5):
-            self.EventHandle, error = self.BBServer.registerEventHandler(self.host, self.port)
+            ret = self.BBServer.registerEventHandler(self.host, self.port)
+
+            if isinstance(ret, collections.Iterable):
+                self.EventHandle, error = ret
+            else:
+                self.EventHandle = ret
+                error = ""
 
             if self.EventHandle != None:
                 break
-- 
2.1.4


