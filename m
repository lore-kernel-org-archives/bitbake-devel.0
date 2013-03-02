Received: from mail-da0-f46.google.com ([209.85.210.46])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <martin.jansa@gmail.com>) id 1UBpx7-00012O-Tj
	for bitbake-devel@lists.openembedded.org;
	Sat, 02 Mar 2013 18:10:50 +0100
Received: by mail-da0-f46.google.com with SMTP id z8so1861715dad.5
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 02 Mar 2013 08:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=x-received:from:to:cc:subject:date:message-id:x-mailer;
	bh=O1UaCg/78m2DUXrhmusKgk2U7LWtpedH7d7n/6ARqzs=;
	b=bociIAqmD3pAoICzi6bxUAGWWqrSvyg89eNDrbVezlOU4AExq35Pk3zuN3ns8lVrbZ
	cByxTN09E9oCzelbQ47Qbj3WfK7x35bZSgmLlG4EIGJQ5/KX90MSxVfqDiVnd7IX9dnJ
	x0vh7bH04j2DJjef+XcQ7l8WK+Kb4xJ+G0rPxqmQD/2hQIkbIQC4lDXOeHJYQhCPXGXg
	K8w9OxnMX8FUVhy8CaEGh3tVUgXqPGpyqHwzyHga7i/Wl5AG8bdE6HrA1ypHwuXRQ4/W
	kuGKtQAtCJnGCmSknKQPm+3yDdabQqeqWA+QwiHSVvwRDD3PJyQQb3F4+7YZtRuqp/la
	N3Eg==
X-Received: by 10.66.7.196 with SMTP id l4mr23774755paa.81.1362243244176;
	Sat, 02 Mar 2013 08:54:04 -0800 (PST)
Received: from localhost (ip-62-24-80-7.net.upcbroadband.cz. [62.24.80.7])
	by mx.google.com with ESMTPS id kl4sm16031993pbc.31.2013.03.02.08.54.01
	(version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Sat, 02 Mar 2013 08:54:03 -0800 (PST)
From: Martin Jansa <martin.jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat,  2 Mar 2013 17:50:05 +0100
Message-Id: <1362243005-12124-1-git-send-email-Martin.Jansa@gmail.com>
X-Mailer: git-send-email 1.8.1.4
Subject: [PATCH] siggen: add quotes around variable values to see whitespace
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
X-List-Received-Date: Sat, 02 Mar 2013 17:10:54 -0000

* without this change it's hard to see what's changed:
  bitbake-diffsigs sstate-cache/*/sstate-depmodwrapper-cross-cortexa8-vfp-neon-oe-linux-gnueabi-1.0-r0-cortexa8-vfp-neon-*_populate-sysroot.tgz.siginfo
  basehash changed from 62f28c13172d38af917716d6d4b15ac5 to 9cf38842bcc79e0a4356856a64141548
  Variable TUNE_CCARGS value changed from  -march=armv7-a    -mthumb -mthumb-interwork -mfloat-abi=softfp -mfpu=neon -mtune=cortex-a8  to  -march=armv7-a    -mthumb -mthumb-interwork -mfloat-abi=softfp -mfpu=neon -mtune=cortex-a8
  Hash for dependent task depmodwrapper-cross_1.0.bb.do_install changed from 4494cb6c117309a9b4c541ad86c0aac5 to 1e3bcf2d14e5bd30a38350b41bb98db3

* with this change, we can see extra trailing space in first version:
  basehash changed from 62f28c13172d38af917716d6d4b15ac5 to 9cf38842bcc79e0a4356856a64141548
  Variable TUNE_CCARGS value changed from ' -march=armv7-a    -mthumb -mthumb-interwork -mfloat-abi=softfp -mfpu=neon -mtune=cortex-a8 ' to ' -march=armv7-a    -mthumb -mthumb-interwork -mfloat-abi=softfp -mfpu=neon -mtune=cortex-a8'
  Hash for dependent task depmodwrapper-cross_1.0.bb.do_install changed from 4494cb6c117309a9b4c541ad86c0aac5 to 1e3bcf2d14e5bd30a38350b41bb98db3

Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
---
 lib/bb/siggen.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index 50e4558..8861337 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -331,12 +331,12 @@ def compare_sigfiles(a, b, recursecb = None):
         return changed, added, removed
 
     if 'basewhitelist' in a_data and a_data['basewhitelist'] != b_data['basewhitelist']:
-        output.append("basewhitelist changed from %s to %s" % (a_data['basewhitelist'], b_data['basewhitelist']))
+        output.append("basewhitelist changed from '%s' to '%s'" % (a_data['basewhitelist'], b_data['basewhitelist']))
         if a_data['basewhitelist'] and b_data['basewhitelist']:
             output.append("changed items: %s" % a_data['basewhitelist'].symmetric_difference(b_data['basewhitelist']))
 
     if 'taskwhitelist' in a_data and a_data['taskwhitelist'] != b_data['taskwhitelist']:
-        output.append("taskwhitelist changed from %s to %s" % (a_data['taskwhitelist'], b_data['taskwhitelist']))
+        output.append("taskwhitelist changed from '%s' to '%s'" % (a_data['taskwhitelist'], b_data['taskwhitelist']))
         if a_data['taskwhitelist'] and b_data['taskwhitelist']:
             output.append("changed items: %s" % a_data['taskwhitelist'].symmetric_difference(b_data['taskwhitelist']))
 
@@ -349,7 +349,7 @@ def compare_sigfiles(a, b, recursecb = None):
     changed, added, removed = dict_diff(a_data['gendeps'], b_data['gendeps'], a_data['basewhitelist'] & b_data['basewhitelist'])
     if changed:
         for dep in changed:
-            output.append("List of dependencies for variable %s changed from %s to %s" % (dep, a_data['gendeps'][dep], b_data['gendeps'][dep]))
+            output.append("List of dependencies for variable %s changed from '%s' to '%s'" % (dep, a_data['gendeps'][dep], b_data['gendeps'][dep]))
             if a_data['gendeps'][dep] and b_data['gendeps'][dep]:
                 output.append("changed items: %s" % a_data['gendeps'][dep].symmetric_difference(b_data['gendeps'][dep]))
     if added:
@@ -363,7 +363,7 @@ def compare_sigfiles(a, b, recursecb = None):
     changed, added, removed = dict_diff(a_data['varvals'], b_data['varvals'])
     if changed:
         for dep in changed:
-            output.append("Variable %s value changed from %s to %s" % (dep, a_data['varvals'][dep], b_data['varvals'][dep]))
+            output.append("Variable %s value changed from '%s' to '%s'" % (dep, a_data['varvals'][dep], b_data['varvals'][dep]))
 
     changed, added, removed = dict_diff(a_data['file_checksum_values'], b_data['file_checksum_values'])
     if changed:
-- 
1.8.1.4



