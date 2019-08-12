Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
	[209.85.128.45])
	by mail.openembedded.org (Postfix) with ESMTP id 553497E5F1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 12 Aug 2019 15:14:23 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id v15so12527012wml.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 12 Aug 2019 08:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=fTeY0EpOr+U8oorI/ha5kWYQJskXbD8dHq86sY9/+w0=;
	b=IN6gYeHTa434TSaPLFl5xrenuotnU5UWrzLj9TL1mwh6VWOxYVxAwrCj2gJdF9c2ty
	FqjSqTdwa9c9WMY8U7waV3XJBh5E8UUTO/q6MEjZ47UPXtkMTtiH8OwvQU5MxErFMl0q
	LeKanMxf2mYLjsnrP7R8bK5XTjfI6s8MrZTZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=fTeY0EpOr+U8oorI/ha5kWYQJskXbD8dHq86sY9/+w0=;
	b=KwfnX1BqxjtJaTVBbQEba5SaMprI/f4ah9vqK185iUfTkUFuW++TvmLIIQfOWHYKTI
	Z1Ck/iWLDAuIklQoeAe2Svj0RRnsWat8mRDbL/PqFBVc29JhRHordTVvzqMG9KTdiztq
	JQXGXP1r+Wk7G3nfdfB+TxwXXeZnTYl3hiSBP7QNu1pq6UMSvtDW6wtsyknfEk0x50Sf
	KmqDbNlse60+UWg9KLdxxw2CyoctcCOP92NuF2+uu/Oj80SFKp8oAx2oQZOmsWuaRvqU
	qPZOkuIA3mfi34qfP1JhINk4vxFMw28BopQrDAyOzPD9O1aAPs927T29kxZgPTth1jsx
	RpLg==
X-Gm-Message-State: APjAAAVzq0+KM5F7hvm1MboBRm5iYdvorZVeatHAlgSTJa1iJIbAjSy9
	sacDJI2EMh17WYSkchXwhHH2MBh27qMYFg==
X-Google-Smtp-Source: APXvYqwia9mWEF4d+ihE3nItRzcezY3YFcu14+QXhcf+jbzDa+Bi8vSOHrkU0EZpqM+gs4a16naHKg==
X-Received: by 2002:a7b:c947:: with SMTP id i7mr29276335wml.77.1565622863752; 
	Mon, 12 Aug 2019 08:14:23 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	b2sm12029638wrf.94.2019.08.12.08.14.22
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Mon, 12 Aug 2019 08:14:22 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 12 Aug 2019 16:14:18 +0100
Message-Id: <20190812151418.31307-4-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190812151418.31307-1-richard.purdie@linuxfoundation.org>
References: <20190812151418.31307-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 4/4] cooker: Improve hash server startup code to avoid exit tracebacks
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
X-List-Received-Date: Mon, 12 Aug 2019 15:14:23 -0000
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


