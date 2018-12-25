Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
	[209.85.128.65])
	by mail.openembedded.org (Postfix) with ESMTP id D13FE6C019
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 25 Dec 2018 11:55:39 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id m1so12820582wml.2
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 25 Dec 2018 03:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=dUhRkJZcx/ZPAlRkP71A4icJd3tOJzu63N6rU+Q81aA=;
	b=b9/0xXPwJELjdjh0qkmIqqsd6te/jmOk2p8+lHF+h0k10XJA9lsnmGLtU1TcwBYVPx
	yXWFydPxHP3O+3iD8xCdJGhWLURxAqbBv5dhuGyHwspkOYYviFt3SDziriI4VvOufva6
	VXmbfFckKRUTKL2C7Q7zCy+UsdozfTl0LB2M0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=dUhRkJZcx/ZPAlRkP71A4icJd3tOJzu63N6rU+Q81aA=;
	b=Y4Cw944Z4kkh10ETyZ5xVqg/54rCidL4hdQ6vP32fiZhNzAhedDPnbTNH51wFT6QCJ
	i3K2Bq3hlAn/3RcyEMwHOEzdKjMZPC2Kr8bfF8Bq6LIAPlpvwO+oHKkZ68Sm+mu7qzJR
	LwLPutpT/TWiu1xsol+Jo6zja3N0IKjT9PxHsk/vl4nvdSdizGEX6AcVKiMeuk/ERN2y
	nFffWjKaBBlLphTJQE8dOHVTvxRAGNdBtcPP5hInnrwxyPjCU18exb4v4yBx+85k/lww
	zJu1CigUx4byIWEWbFuLxuVlENiyaVuotcxvL/UhKmDNfrij70FIdjTzwCWkF5tbu9Xc
	T3gA==
X-Gm-Message-State: AA+aEWYvAOQYf+eWPJjBsbGBNL/u9fqUA0aWfuLgcrl8xsA8H9ATTTgo
	/rbcwWjZQvxniRD21B82aWlT7a43BAE=
X-Google-Smtp-Source: ALg8bN5nMshBXbLdDnxhPIPx8NkRQ72NfXASSBiVm5diAHWEjkqrit1rCjLcvDCsdILhOEhTFn3xWg==
X-Received: by 2002:a1c:9a0d:: with SMTP id c13mr15413683wme.41.1545738940181; 
	Tue, 25 Dec 2018 03:55:40 -0800 (PST)
Received: from hex.config (5751ab90.skybroadband.com. [87.81.171.144])
	by smtp.gmail.com with ESMTPSA id m4sm26068209wmi.3.2018.12.25.03.55.39
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 25 Dec 2018 03:55:39 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 25 Dec 2018 11:55:33 +0000
Message-Id: <20181225115533.10018-4-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181225115533.10018-1-richard.purdie@linuxfoundation.org>
References: <20181225115533.10018-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 4/4] process: Rewrite multiple connection handling
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
X-List-Received-Date: Tue, 25 Dec 2018 11:55:40 -0000
Content-Transfer-Encoding: 8bit

If the bitbake server recieved multiple connections, it currently closes
ones it can't handle (while its dealing with another). This is rather
antisocial behaviour which causes clients to quickly run through their
retries and abort.

Instead, queue any other connections until the current one is closed. This
way the client can decide when it wants to stop waiting for the server. If the
client is gone by the time we handle it, we handle that gracefully.

This also fixes a number of bugs in the connection handling where connections
which did drop early were badly handled causing tracebacks in the logs.

Also, handle queue incomming connections in a loop to ensure that the main
client handling doesn't starve that piece of the system.

This code was stress tested by running 50 connection attempts in parallel at
once, ensuring the code correctly handled them.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/server/process.py | 56 ++++++++++++++++++++++++----------------
 1 file changed, 34 insertions(+), 22 deletions(-)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 1e4b51e35e..28b8eb9b86 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -130,6 +130,7 @@ class ProcessServer(multiprocessing.Process):
         bb.utils.set_process_name("Cooker")
 
         ready = []
+        newconnections = []
 
         self.controllersock = False
         fds = [self.sock]
@@ -138,37 +139,48 @@ class ProcessServer(multiprocessing.Process):
         print("Entering server connection loop")
 
         def disconnect_client(self, fds):
-            if not self.haveui:
-                return
             print("Disconnecting Client")
-            fds.remove(self.controllersock)
-            fds.remove(self.command_channel)
-            bb.event.unregister_UIHhandler(self.event_handle, True)
-            self.command_channel_reply.writer.close()
-            self.event_writer.writer.close()
-            del self.event_writer
-            self.controllersock.close()
-            self.controllersock = False
-            self.haveui = False
-            self.lastui = time.time()
-            self.cooker.clientComplete()
-            if self.timeout is None:
+            if self.controllersock:
+                fds.remove(self.controllersock)
+                self.controllersock.close()
+                self.controllersock = False
+            if self.haveui:
+                fds.remove(self.command_channel)
+                bb.event.unregister_UIHhandler(self.event_handle, True)
+                self.command_channel_reply.writer.close()
+                self.event_writer.writer.close()
+                self.command_channel.close()
+                self.command_channel = False
+                del self.event_writer
+                self.lastui = time.time()
+                self.cooker.clientComplete()
+                self.haveui = False
+            ready = select.select(fds,[],[],0)[0]
+            if newconnections:
+                print("Starting new client")
+                conn = newconnections.pop(-1)
+                fds.append(conn)
+                self.controllersock = conn
+            elif self.timeout is None and not ready:
                 print("No timeout, exiting.")
                 self.quit = True
 
         while not self.quit:
             if self.sock in ready:
-                self.controllersock, address = self.sock.accept()
-                if self.haveui:
-                    print("Dropping connection attempt as we have a UI %s" % (str(ready)))
-                    self.controllersock.close()
-                else:
-                    print("Accepting %s" % (str(ready)))
-                    fds.append(self.controllersock)
+                while select.select([self.sock],[],[],0)[0]:
+                    controllersock, address = self.sock.accept()
+                    if self.controllersock:
+                        print("Queuing %s (%s)" % (str(ready), str(newconnections)))
+                        newconnections.append(controllersock)
+                    else:
+                        print("Accepting %s (%s)" % (str(ready), str(newconnections)))
+                        self.controllersock = controllersock
+                        fds.append(controllersock)
             if self.controllersock in ready:
                 try:
-                    print("Connecting Client")
+                    print("Processing Client")
                     ui_fds = recvfds(self.controllersock, 3)
+                    print("Connecting Client")
 
                     # Where to write events to
                     writer = ConnectionWriter(ui_fds[0])
-- 
2.19.1


