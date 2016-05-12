Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 5C07D62137
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 May 2016 09:56:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u4C9u6om031254 for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 May 2016 10:56:30 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id cWvdjh4STHkY for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 May 2016 10:56:30 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u4C9uPKp031294
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 May 2016 10:56:26 +0100
Message-ID: <1463046985.9746.6.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 12 May 2016 10:56:25 +0100
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: [PATCH] event/msg: Pass formatted exceptions
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
X-List-Received-Date: Thu, 12 May 2016 09:56:32 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

python3 can't cope with the previous approach we were using to pass
exceptions through the RPC. Avoid this by creating a formatted exception
on the sender side.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/lib/bb/event.py b/lib/bb/event.py
index 3955f9d..6fb3712 100644
--- a/lib/bb/event.py
+++ b/lib/bb/event.py
@@ -607,8 +607,9 @@ class LogHandler(logging.Handler):
             if hasattr(tb, 'tb_next'):
                 tb = list(bb.exceptions.extract_traceback(tb, context=3))
             # Need to turn the value into something the logging system can pickle
-            value = str(value)
             record.bb_exc_info = (etype, value, tb)
+            record.bb_exc_formatted = bb.exceptions.format_exception(etype, value, tb, limit=5)
+            value = str(value)
             record.exc_info = None
         fire(record, None)
 
diff --git a/lib/bb/msg.py b/lib/bb/msg.py
index e3ced27..8c3ab47 100644
--- a/lib/bb/msg.py
+++ b/lib/bb/msg.py
@@ -90,8 +90,9 @@ class BBLogFormatter(logging.Formatter):
             if self.color_enabled:
                 record = self.colorize(record)
             msg = logging.Formatter.format(self, record)
-
-        if hasattr(record, 'bb_exc_info'):
+        if hasattr(record, 'bb_exc_formatted'):
+            msg += '\n' + ''.join(record.bb_exc_formatted)
+        elif hasattr(record, 'bb_exc_info'):
             etype, value, tb = record.bb_exc_info
             formatted = bb.exceptions.format_exception(etype, value, tb, limit=5)
             msg += '\n' + ''.join(formatted)


