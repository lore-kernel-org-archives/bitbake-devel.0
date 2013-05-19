Received: from dan.rpsys.net ([93.97.175.187])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1Ue0xf-0007zA-BP for bitbake-devel@lists.openembedded.org;
	Sun, 19 May 2013 12:35:33 +0200
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r4JAKQ5e032395; Sun, 19 May 2013 11:20:26 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Bal-a-cMAOIm; Sun, 19 May 2013 11:20:26 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r4JAKNmr032390
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT); Sun, 19 May 2013 11:20:24 +0100
Message-ID: <1368958614.32727.91.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Sun, 19 May 2013 13:16:54 +0300
X-Mailer: Evolution 3.6.2-0ubuntu0.1 
Mime-Version: 1.0
Subject: [PATCH] data: Ensure dependencies of subfunctions are accounted for
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
X-List-Received-Date: Sun, 19 May 2013 10:35:47 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Currently we account of the top level function's vardeps but not
those of any subfunction. This would imply we'd have to manually
write the dependencies of all parent functions which would be crazy.

This patch adds the dependencies to fix the issue.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/data.py b/bitbake/lib/bb/data.py
index abf210a..87c4808 100644
--- a/bitbake/lib/bb/data.py
+++ b/bitbake/lib/bb/data.py
@@ -274,6 +274,7 @@ def emit_func(func, o=sys.__stdout__, d = init()):
             if d.getVarFlag(dep, "func"):
                emit_var(dep, o, d, False) and o.write('\n')
                newdeps |=  bb.codeparser.ShellParser(dep, logger).parse_shell(d.getVar(dep, True))
+               newdeps |= set((d.getVarFlag(dep, "vardeps", True) or "").split())
         newdeps -= seen
 
 def update_data(d):




