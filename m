Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 7940A6FFE9
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Jun 2014 16:59:53 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s5IGxmls025681 for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Jun 2014 17:59:49 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id ggf--5wlM8LP for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Jun 2014 17:59:48 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s5IGxiW2025678
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Jun 2014 17:59:46 +0100
Message-ID: <1403110779.2104.80.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 18 Jun 2014 17:59:39 +0100
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] build.py: Ensure shared work siginfo files are written to the correct location
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
X-List-Received-Date: Wed, 18 Jun 2014 16:59:54 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Right now shared work signature data is saved to the non-shared directory
which is confusing to everyone including bitbake. Whilst its messy,
extra the stampbase data instead, which ensures the sig data is written
to the correct location alongside its corresponding stamp file.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/build.py b/bitbake/lib/bb/build.py
index 6b70ce5..d1eaed4 100644
--- a/bitbake/lib/bb/build.py
+++ b/bitbake/lib/bb/build.py
@@ -506,7 +506,7 @@ def exec_task(fn, task, d, profile = False):
             event.fire(failedevent, d)
         return 1
 
-def stamp_internal(taskname, d, file_name):
+def stamp_internal(taskname, d, file_name, baseonly=False):
     """
     Internal stamp helper function
     Makes sure the stamp directory exists
@@ -527,6 +527,9 @@ def stamp_internal(taskname, d, file_name):
         file_name = d.getVar('BB_FILENAME', True)
         extrainfo = d.getVarFlag(taskflagname, 'stamp-extra-info', True) or ""
 
+    if baseonly:
+        return stamp
+
     if not stamp:
         return
 
@@ -591,8 +594,9 @@ def make_stamp(task, d, file_name = None):
     # If we're in task context, write out a signature file for each task
     # as it completes
     if not task.endswith("_setscene") and task != "do_setscene" and not file_name:
+        stampbase = stamp_internal(task, d, None, True)
         file_name = d.getVar('BB_FILENAME', True)
-        bb.parse.siggen.dump_sigtask(file_name, task, d.getVar('STAMP', True), True)
+        bb.parse.siggen.dump_sigtask(file_name, task, stampbase, True)
 
 def del_stamp(task, d, file_name = None):
     """



