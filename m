Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1Qjek2-0004vM-Fo for bitbake-devel@lists.openembedded.org;
	Wed, 20 Jul 2011 23:55:42 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p6KLpaGk026871
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Jul 2011 22:51:36 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 25304-09 for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Jul 2011 22:51:32 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p6KLpRpK026865
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Jul 2011 22:51:29 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 20 Jul 2011 22:51:23 +0100
Message-ID: <1311198683.2344.69.camel@rex>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] parse/ConfHandler: Fix multiline variable corruption
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
X-List-Received-Date: Wed, 20 Jul 2011 21:55:42 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

When parsing multiline variables in conf files, the last character can
be accidentally removed. s2 contains new data read from the file which
may or may not end with the continuation character. It makes sense to
let the next loop iteration strip this if needed.

We don't often use multiline expressions in .conf files which is why I'd
imagine we haven't noticed this before. Most variables are quoted and
its the closing quotation which often disappears.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

--- a/lib/bb/parse/parse_py/ConfHandler.py	
+++ a/lib/bb/parse/parse_py/ConfHandler.py	
@@ -96,7 +96,7 @@ def handle(fn, data, include):
         s = s.rstrip()
         if s[0] == '#': continue    # skip comments
         while s[-1] == '\\':
-            s2 = f.readline()[:-1].strip()
+            s2 = f.readline().strip()
             lineno = lineno + 1
             s = s[:-1] + s2
         feeder(lineno, s, fn, statements)



