Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 4EE3262137
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 May 2016 09:57:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u4C9vdLO031431 for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 May 2016 10:57:39 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 42PpsV9loWtH for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 May 2016 10:57:39 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u4C9vbjt031419
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 May 2016 10:57:38 +0100
Message-ID: <1463047057.9746.8.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 12 May 2016 10:57:37 +0100
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: [PATCH] main: Ensure exceptions are correctly displayed
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
X-List-Received-Date: Thu, 12 May 2016 09:57:39 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

If the cooker fails to start, ensure a correct exception is displayed to the
user. After handling any queued events simply re-raise the original exception
else the output can be unclear.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/lib/bb/main.py b/lib/bb/main.py
index a287905..b296ef8 100755
--- a/lib/bb/main.py
+++ b/lib/bb/main.py
@@ -336,7 +336,6 @@ def start_server(servermodule, configParams, configuration, features):
         server.addcooker(cooker)
         server.saveConnectionDetails()
     except Exception as e:
-        exc_info = sys.exc_info()
         while hasattr(server, "event_queue"):
             import queue
             try:
@@ -345,7 +344,7 @@ def start_server(servermodule, configParams, configuration, features):
                 break
             if isinstance(event, logging.LogRecord):
                 logger.handle(event)
-        raise exc_info[1], None, exc_info[2]
+        raise
     server.detach()
     cooker.lock.close()
     return server


