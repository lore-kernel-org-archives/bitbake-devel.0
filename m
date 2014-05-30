Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 5C1AE6FA94
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 30 May 2014 14:54:45 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s4UEseHP012174 for <bitbake-devel@lists.openembedded.org>;
	Fri, 30 May 2014 15:54:40 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id B7RZslItFtti for <bitbake-devel@lists.openembedded.org>;
	Fri, 30 May 2014 15:54:40 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s4UEsbtA012165
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 30 May 2014 15:54:38 +0100
Message-ID: <1401461669.31309.50.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 30 May 2014 15:54:29 +0100
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] event.py: Allow passthrough of BBHandledException events
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
X-List-Received-Date: Fri, 30 May 2014 14:54:45 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

We need BBHandledException events to be passed through to the higher
layers, they don't need addition of any traceback since they've already
been reported to the user.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/event.py b/bitbake/lib/bb/event.py
index 04d775c..05ff543 100644
--- a/bitbake/lib/bb/event.py
+++ b/bitbake/lib/bb/event.py
@@ -72,7 +72,7 @@ def execute_handler(name, handler, event, d):
     event.data = d
     try:
         ret = handler(event)
-    except bb.parse.SkipPackage:
+    except (bb.parse.SkipPackage, bb.BBHandledException):
         raise
     except Exception:
         etype, value, tb = sys.exc_info()



