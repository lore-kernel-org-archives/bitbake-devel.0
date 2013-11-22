Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id AB0ED6B7F3
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 22 Nov 2013 16:17:54 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	rAMGHmrd024338 for <bitbake-devel@lists.openembedded.org>;
	Fri, 22 Nov 2013 16:17:48 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 6Prgz5Wdhuu0 for <bitbake-devel@lists.openembedded.org>;
	Fri, 22 Nov 2013 16:17:48 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	rAMGHhJb024332
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT) for <bitbake-devel@lists.openembedded.org>;
	Fri, 22 Nov 2013 16:17:44 GMT
Message-ID: <1385137059.16887.179.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 22 Nov 2013 16:17:39 +0000
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] data: Fix output inconsistencies for emit_var
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
X-List-Received-Date: Fri, 22 Nov 2013 16:17:56 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

VAL = ""     (not shown)
VAL = " "    (shown as "")
VAL = " x"   (shown as "x")

would all show up rather differently to what would be expected in the
bitbake -e output. This fixes things so they appear consistently.

The output for running some shell functions may also change slightly
but shouldn't change in a way that is likely to cause problems.

[YOCTO #5507]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/data.py b/bitbake/lib/bb/data.py
index 349fcfe..bdd1e79 100644
--- a/bitbake/lib/bb/data.py
+++ b/bitbake/lib/bb/data.py
@@ -214,7 +214,7 @@ def emit_var(var, o=sys.__stdout__, d = init(), all=False):
         o.write('unset %s\n' % varExpanded)
         return 0
 
-    if not val:
+    if val is None:
         return 0
 
     val = str(val)
@@ -229,7 +229,7 @@ def emit_var(var, o=sys.__stdout__, d = init(), all=False):
 
     # if we're going to output this within doublequotes,
     # to a shell, we need to escape the quotes in the var
-    alter = re.sub('"', '\\"', val.strip())
+    alter = re.sub('"', '\\"', val)
     alter = re.sub('\n', ' \\\n', alter)
     o.write('%s="%s"\n' % (varExpanded, alter))
     return 0



