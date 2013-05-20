Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 12E9E608C4
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 May 2013 22:00:22 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r4KM3oHb025944 for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 May 2013 23:03:50 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Th645L8MBSRG for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 May 2013 23:03:50 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r4KM3lGf025939
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT) for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 May 2013 23:03:48 +0100
Message-ID: <1369087210.11013.0.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Mon, 20 May 2013 23:00:10 +0100
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] bin/bitbake: Improve exception handling
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 20 May 2013 22:00:23 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit


Due to the internal event processing, this excepting handler usually raises an
Empty error, masking the underlying failure. Ensure the original exception is
raised.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/bin/bitbake b/bitbake/bin/bitbake
index 519ecd9..7087d2d 100755
--- a/bitbake/bin/bitbake
+++ b/bitbake/bin/bitbake
@@ -242,7 +242,8 @@ def main():
 
         server.addcooker(cooker)
         server.saveConnectionDetails()
-    except:
+    except Exception as e:
+        exc_info = sys.exc_info()
         while True:
             try:
                 import queue
@@ -254,7 +255,7 @@ def main():
                 break
             if isinstance(event, logging.LogRecord):
                 logger.handle(event)
-        raise
+        raise exc_info[1], None, exc_info[2]
     server.detach()
 
     # Should no longer need to ever reference cooker




