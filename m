Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1RTagf-0002NV-6b for bitbake-devel@lists.openembedded.org;
	Thu, 24 Nov 2011 15:54:05 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id pAOElXv2025660
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 24 Nov 2011 14:47:33 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 25126-05-2 for <bitbake-devel@lists.openembedded.org>;
	Thu, 24 Nov 2011 14:47:29 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id pAOElCNe025595
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 24 Nov 2011 14:47:13 GMT
Message-ID: <1322146038.24143.26.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 24 Nov 2011 14:47:18 +0000
X-Mailer: Evolution 3.2.1- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] knotty: Add support for logging the console to logfile
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 24 Nov 2011 14:54:05 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

The BB_CONSOLELOG variable is used to specify the console log file
to use. This means people can look up things that happened during a
build by may have scrolled off the screen.
    
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index 7c645ad..38acb47 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -69,6 +69,7 @@ def main(server, eventHandler):
     # Get values of variables which control our output
     includelogs = server.runCommand(["getVariable", "BBINCLUDELOGS"])
     loglines = server.runCommand(["getVariable", "BBINCLUDELOGS_LINES"])
+    consolelogfile = server.runCommand(["getVariable", "BB_CONSOLELOG"])
 
     helper = uihelper.BBUIHelper()
 
@@ -77,6 +78,11 @@ def main(server, eventHandler):
     bb.msg.addDefaultlogFilter(console)
     console.setFormatter(format)
     logger.addHandler(console)
+    if consolelogfile:
+        consolelog = logging.FileHandler(consolelogfile)
+        bb.msg.addDefaultlogFilter(consolelog)
+        consolelog.setFormatter(format)
+        logger.addHandler(consolelog)
 
     try:
         cmdline = server.runCommand(["getCmdLineAction"])



