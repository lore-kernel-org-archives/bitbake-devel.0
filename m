Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1TdiG2-0001XQ-S5 for bitbake-devel@lists.openembedded.org;
	Wed, 28 Nov 2012 15:04:59 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id qASDoiD2013618
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 28 Nov 2012 13:50:44 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 11107-08 for <bitbake-devel@lists.openembedded.org>;
	Wed, 28 Nov 2012 13:50:39 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id qASDoXfK013612
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 28 Nov 2012 13:50:34 GMT
Message-ID: <1354110633.32463.6.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 28 Nov 2012 13:50:33 +0000
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] build/siggen.py: Avoid removing too many stamps when cleaning
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
X-List-Received-Date: Wed, 28 Nov 2012 14:04:59 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

The "*" part of the mask is to ensure we clean both any stamp, and any
setscene varient. It turns out we would also trample other tasks,
e.g. do_package_write could trample do_package_write_rpm. do_package also
tramples do_package_write_* but this is less of an issue since the other
tasks depend on it.

Rather than use the wildcard, we can just use a list instead.

[YOCTO #3484]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/build.py b/bitbake/lib/bb/build.py
index 85af42c..8ff7fb2 100644
--- a/bitbake/lib/bb/build.py
+++ b/bitbake/lib/bb/build.py
@@ -491,9 +491,11 @@ def stamp_cleanmask_internal(taskname, d, file_name):
         extrainfo = d.getVarFlag(taskflagname, 'stamp-extra-info', True) or ""
 
     if not stamp:
-        return
+        return []
+
+    cleanmask = bb.parse.siggen.stampcleanmask(stamp, file_name, taskname, extrainfo)
 
-    return bb.parse.siggen.stampcleanmask(stamp, file_name, taskname, extrainfo)
+    return [cleanmask, cleanmask.replace(taskflagname, taskflagname + "_setscene")]
 
 def make_stamp(task, d, file_name = None):
     """
@@ -501,8 +503,8 @@ def make_stamp(task, d, file_name = None):
     (d can be a data dict or dataCache)
     """
     cleanmask = stamp_cleanmask_internal(task, d, file_name)
-    if cleanmask:
-        bb.utils.remove(cleanmask)
+    for mask in cleanmask:
+        bb.utils.remove(mask)
 
     stamp = stamp_internal(task, d, file_name)
     # Remove the file and recreate to force timestamp
diff --git a/bitbake/lib/bb/siggen.py b/bitbake/lib/bb/siggen.py
index ff70d4f..ba14940 100644
--- a/bitbake/lib/bb/siggen.py
+++ b/bitbake/lib/bb/siggen.py
@@ -49,7 +49,7 @@ class SignatureGenerator(object):
         return ("%s.%s.%s" % (stampbase, taskname, extrainfo)).rstrip('.')
 
     def stampcleanmask(self, stampbase, file_name, taskname, extrainfo):
-        return ("%s.%s*.%s" % (stampbase, taskname, extrainfo)).rstrip('.')
+        return ("%s.%s.%s" % (stampbase, taskname, extrainfo)).rstrip('.')
 
     def dump_sigtask(self, fn, task, stampbase, runtime):
         return
@@ -276,7 +276,6 @@ class SignatureGeneratorBasicHash(SignatureGeneratorBasic):
             k = fn + "." + taskname
         if clean:
             h = "*"
-            taskname = taskname + "*"
         elif k in self.taskhash:
             h = self.taskhash[k]
         else:




