Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
	[209.85.128.65])
	by mail.openembedded.org (Postfix) with ESMTP id 3D7097E507
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Aug 2019 09:04:19 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id o4so3445544wmh.2
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Aug 2019 02:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=Y1qekGHpJg/f5NGntEiJGoc8s1bgPA2EsdXvR3pALJE=;
	b=TStWVGMTMxRi+Li4pRsbphKXFkFxmQFvIqOqg6AjHN93f/m4p/YNbuukhfbc/lBCfv
	JNSoys+ZapmMbs/dkDaRHCj5Rc4fF8fB8W5vfHBmNGGp2tEzSWkjsa/hgrCA2mnHHcgn
	5m3mYctQ58JgISw13XRambTwq1x/uOjH4daUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=Y1qekGHpJg/f5NGntEiJGoc8s1bgPA2EsdXvR3pALJE=;
	b=a2tlJ+QmRaMJW8Q8VIQCS5cuFgeo+3BqoiVAg27etDVh9qW1JtfnvCO/jH1CKcyOLh
	nGqNDw1klsjzr56rfgEpYC51efELhNpWY2Kc6DYX3krjjLRcHHsQGslFss4vPqQDpoIT
	tuAZHQ2zjDBdoahNZH1ADhAXhukprV5b4di+ZRSLPBUsCuMtr4Le6xeNiJ5aMzvTV3sq
	q8kpNEwmOOCcfStm/UkPLWXV4fN38p4jsCpX51IxBeEDA/38p6oaM8uyME3C/26lEIz4
	ynO6AcSMIizyZcE8uBvSorUXI9A4mha7TvLIEqU9VjC6GvisK6gXwd4Ljep7f8Xm/WCz
	FFHg==
X-Gm-Message-State: APjAAAWxJQBtq94k4GtStWjNFkfQ9GrKQrDQqJAyWCHJKl5+pM7nLlWs
	DVMdUHZOerzwc2sdjK+QyBL2oH8PU3Xqog==
X-Google-Smtp-Source: APXvYqwP/Fit4ZytbCvjDqrL/9IXVb04SmNwK357RFmkWglJrETor2yoVcdqOQe4m+MjvgkMKC2Kmw==
X-Received: by 2002:a1c:740b:: with SMTP id p11mr6340831wmc.6.1565946260261;
	Fri, 16 Aug 2019 02:04:20 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	x6sm3347793wmf.6.2019.08.16.02.04.19
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Fri, 16 Aug 2019 02:04:19 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 16 Aug 2019 10:04:17 +0100
Message-Id: <20190816090418.13807-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Subject: [PATCH 1/2] hashserv: Ensure we don't accumulate sockets in TIME_WAIT state
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
X-List-Received-Date: Fri, 16 Aug 2019 09:04:20 -0000
Content-Transfer-Encoding: 8bit

This can cause a huge backlog of closing sockets on the server and
in our case we don't really want/need the protection TCP is trying to
give us so work around it.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/hashserv/__init__.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/hashserv/__init__.py b/lib/hashserv/__init__.py
index 55966e748a..eb03c32213 100644
--- a/lib/hashserv/__init__.py
+++ b/lib/hashserv/__init__.py
@@ -14,6 +14,8 @@ import socketserver
 import queue
 import threading
 import signal
+import socket
+import struct
 from datetime import datetime
 
 logger = logging.getLogger('hashserv')
@@ -157,6 +159,10 @@ class ThreadedHTTPServer(HTTPServer):
         self.server_close()
         os._exit(0)
 
+    def server_bind(self):
+        HTTPServer.server_bind(self)
+        self.socket.setsockopt(socket.SOL_SOCKET, socket.SO_LINGER, struct.pack('ii', 1, 0))
+
     def process_request_thread(self):
         while not self.quit:
             try:
-- 
2.20.1


