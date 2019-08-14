Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
	[209.85.128.65])
	by mail.openembedded.org (Postfix) with ESMTP id 3B9567E963
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Aug 2019 13:53:21 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id 207so4682633wma.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Aug 2019 06:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=fTeY0EpOr+U8oorI/ha5kWYQJskXbD8dHq86sY9/+w0=;
	b=DM+0boDKKML/bzFUTep4BDBPj+sBAuBTb6kOVSSY9zzf3dA7raAwQxqJT7tHpnUnII
	sWWmsnQSt09oxj8cCjniE7Fi96Z5I7RoLZKNs31YKah1BfdniVGao5DPU2L35lVo49TW
	swDh8c0Bz+k6mIp5g4h110WhEIirjHrUHn99Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=fTeY0EpOr+U8oorI/ha5kWYQJskXbD8dHq86sY9/+w0=;
	b=Hl+1pk6/1OD6VM74qvwgOCCrkhBjkCD+XKPV09i43I0KyPG+jm88GNL7jNVhSIL0uT
	J70/WiLANCOosqDzNY2MSHEYTcJaHl3xOlj0n5afoXfYcbQvvfspgAtGKd/4Ktfht003
	9X9+OsgMH7+urG5wNuONhPJJQsx4AaCYVcFWqqIJi5I6xHwGZh90j/C79jEG+66OPpn1
	BSQ2K/npvavCLjwENIwQ8Y3pBYR2X9XGQ7tfNp0e6/FTEMOnWHoWGjLlzDEnBldyRELh
	YmTbym8zZNccx69IG+a6ZlFAhPup7JvbkH7VlVj5f1ATk/yfWKYLsktKgC+nzSsUYBE4
	DKEw==
X-Gm-Message-State: APjAAAXCWWzBC5NcieN4RIiXcg6Q01l80ugicPjhyz41F+lz1OoNDtLn
	YeuejxncOJOZLpFoIOIePNJKj9qBwe4qxg==
X-Google-Smtp-Source: APXvYqwUcD4IrCvyZtwOLy4XejBqzZF2RZx1AlXAAmdefqcdJkNrIj3hVvV961Gulu+VOj5HhJ3HMA==
X-Received: by 2002:a1c:9d53:: with SMTP id g80mr8728418wme.103.1565790801478; 
	Wed, 14 Aug 2019 06:53:21 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	e6sm1859275wrr.14.2019.08.14.06.53.20
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Wed, 14 Aug 2019 06:53:20 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 14 Aug 2019 14:53:11 +0100
Message-Id: <20190814135317.28887-4-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190814135317.28887-1-richard.purdie@linuxfoundation.org>
References: <20190814135317.28887-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 04/10] cooker: Improve hash server startup code to avoid exit tracebacks
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
X-List-Received-Date: Wed, 14 Aug 2019 13:53:21 -0000
Content-Transfer-Encoding: 8bit

At exit the hashserv code was causing tracebacks as join() wasn't
being called from the thread that started the process. Ensure that
the hashserver is started from the pre_serve hook which is the
final thread the cooker runs in. This avoids the traceback at the
expense of some horrific poking into data stores which will ultimately
need improving through a proper API.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py         | 29 +++++++++++++++++------------
 lib/hashserv/__init__.py |  1 +
 2 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index ec1b35d724..0607fcc708 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -371,22 +371,10 @@ class BBCooker:
 
         self.data.setVar('BB_CMDLINE', self.ui_cmdline)
 
-        if self.data.getVar("BB_HASHSERVE") == "localhost:0":
-            if not self.hashserv:
-                dbfile = (self.data.getVar("PERSISTENT_DIR") or self.data.getVar("CACHE")) + "/hashserv.db"
-                self.hashserv = hashserv.create_server(('localhost', 0), dbfile, '')
-                self.hashservport = "localhost:" + str(self.hashserv.server_port)
-                self.hashserv.process = multiprocessing.Process(target=self.hashserv.serve_forever)
-                self.hashserv.process.daemon = True
-                self.hashserv.process.start()
-            self.data.setVar("BB_HASHSERVE", self.hashservport)
-
         #
         # Copy of the data store which has been expanded.
         # Used for firing events and accessing variables where expansion needs to be accounted for
         #
-        bb.parse.init_parser(self.data)
-
         if CookerFeatures.BASEDATASTORE_TRACKING in self.featureset:
             self.disableDataTracking()
 
@@ -404,6 +392,22 @@ class BBCooker:
         except prserv.serv.PRServiceConfigError as e:
             bb.fatal("Unable to start PR Server, exitting")
 
+        if self.data.getVar("BB_HASHSERVE") == "localhost:0":
+            if not self.hashserv:
+                dbfile = (self.data.getVar("PERSISTENT_DIR") or self.data.getVar("CACHE")) + "/hashserv.db"
+                self.hashserv = hashserv.create_server(('localhost', 0), dbfile, '')
+                self.hashservport = "localhost:" + str(self.hashserv.server_port)
+                self.hashserv.process = multiprocessing.Process(target=self.hashserv.serve_forever)
+                self.hashserv.process.daemon = True
+                self.hashserv.process.start()
+            self.data.setVar("BB_HASHSERVE", self.hashservport)
+            self.databuilder.origdata.setVar("BB_HASHSERVE", self.hashservport)
+            self.databuilder.data.setVar("BB_HASHSERVE", self.hashservport)
+            for mc in self.databuilder.mcdata:
+                self.databuilder.mcdata[mc].setVar("BB_HASHSERVE", self.hashservport)
+
+        bb.parse.init_parser(self.data)
+
     def enableDataTracking(self):
         self.configuration.tracking = True
         if hasattr(self, "data"):
@@ -1677,6 +1681,7 @@ class BBCooker:
 
     def reset(self):
         self.initConfigurationData()
+        self.handlePRServ()
 
     def clientComplete(self):
         """Called when the client is done using the server"""
diff --git a/lib/hashserv/__init__.py b/lib/hashserv/__init__.py
index 1d5e08ee5a..55966e748a 100644
--- a/lib/hashserv/__init__.py
+++ b/lib/hashserv/__init__.py
@@ -151,6 +151,7 @@ class ThreadedHTTPServer(HTTPServer):
 
         signal.signal(signal.SIGTERM, self.sigterm_exception)
         super().serve_forever()
+        os._exit(0)
 
     def sigterm_exception(self, signum, stackframe):
         self.server_close()
-- 
2.20.1


