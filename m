Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 8AF3F6EC83
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 26 Mar 2014 16:57:56 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s2QGvpnV029097 for <bitbake-devel@lists.openembedded.org>;
	Wed, 26 Mar 2014 16:57:52 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id i1zxdwvRXMXL for <bitbake-devel@lists.openembedded.org>;
	Wed, 26 Mar 2014 16:57:51 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s2QGvmvg029091
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 26 Mar 2014 16:57:49 GMT
Message-ID: <1395853061.24890.108.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 26 Mar 2014 16:57:41 +0000
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] knotty: Split error output onto stderr
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
X-List-Received-Date: Wed, 26 Mar 2014 16:57:57 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

When using bitbake -e in scripts, it would be helpful if the error
output appeared on stderr, not stdout. This change enables that building
upon the new bb.msg filters.

[YOCTO #5274]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
index 31c2dbb..05c3134 100644
--- a/bitbake/lib/bb/ui/knotty.py
+++ b/bitbake/lib/bb/ui/knotty.py
@@ -256,11 +256,15 @@ def main(server, eventHandler, params, tf = TerminalFilter):
     helper = uihelper.BBUIHelper()
 
     console = logging.StreamHandler(sys.stdout)
+    errconsole = logging.StreamHandler(sys.stderr)
     format_str = "%(levelname)s: %(message)s"
     format = bb.msg.BBLogFormatter(format_str)
-    bb.msg.addDefaultlogFilter(console)
+    bb.msg.addDefaultlogFilter(console, bb.msg.BBLogFilterStdOut)
+    bb.msg.addDefaultlogFilter(errconsole, bb.msg.BBLogFilterStdErr)
     console.setFormatter(format)
+    errconsole.setFormatter(format)
     logger.addHandler(console)
+    logger.addHandler(errconsole)
 
     if params.options.remote_server and params.options.kill_server:
         server.terminateServer()



