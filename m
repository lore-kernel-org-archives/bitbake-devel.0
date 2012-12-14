Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1TjYJR-0007Nc-PC for bitbake-devel@lists.openembedded.org;
	Fri, 14 Dec 2012 17:40:38 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id qBEGQ14E013387
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Dec 2012 16:26:01 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 13096-01 for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Dec 2012 16:25:57 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id qBEGPqIv013380
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Dec 2012 16:25:53 GMT
Message-ID: <1355502352.32519.28.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 14 Dec 2012 16:25:52 +0000
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] data: Ensure emit_func honours vardeps flag
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
X-List-Received-Date: Fri, 14 Dec 2012 16:40:38 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Currently, calling a shell function using exec_func may result in
dependent functions being missing, if the shell parser can't detect
the dependency, even if it was specified with the vardeps flag.

This patch ensures the function looks at the flag and considers it
when deciding which other functions need to be output.

[YOCTO #3561]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/data.py b/bitbake/lib/bb/data.py
index dc5a425..478a482 100644
--- a/bitbake/lib/bb/data.py
+++ b/bitbake/lib/bb/data.py
@@ -260,6 +260,7 @@ def emit_func(func, o=sys.__stdout__, d = init()):
 
     emit_var(func, o, d, False) and o.write('\n')
     newdeps = bb.codeparser.ShellParser(func, logger).parse_shell(d.getVar(func, True))
+    newdeps |= set((d.getVarFlag(func, "vardeps", True) or "").split())
     seen = set()
     while newdeps:
         deps = newdeps




