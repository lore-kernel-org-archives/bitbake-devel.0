Return-Path: <peter.kjellerstedt@axis.com>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
	by mail.openembedded.org (Postfix) with ESMTP id B7646771A8
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Jan 2016 17:23:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bes.se.axis.com (Postfix) with ESMTP id CA2B72E3A3;
	Wed, 27 Jan 2016 18:23:44 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bes.se.axis.com
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id Q40LSXIUVGIe; Wed, 27 Jan 2016 18:23:41 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by bes.se.axis.com (Postfix) with ESMTP id DE8DC2E3A1;
	Wed, 27 Jan 2016 18:23:41 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id C7B69158D;
	Wed, 27 Jan 2016 18:23:41 +0100 (CET)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
	by boulder.se.axis.com (Postfix) with ESMTP id BC77A158A;
	Wed, 27 Jan 2016 18:23:41 +0100 (CET)
Received: from saur-2.se.axis.com (saur-2.se.axis.com [10.92.3.2])
	by thoth.se.axis.com (Postfix) with ESMTP id BA2613414B;
	Wed, 27 Jan 2016 18:23:41 +0100 (CET)
Received: from saur-2.se.axis.com (localhost [127.0.0.1])
	by saur-2.se.axis.com (8.14.5/8.14.5) with ESMTP id u0RHNfHJ001797;
	Wed, 27 Jan 2016 18:23:41 +0100
Received: (from pkj@localhost)
	by saur-2.se.axis.com (8.14.5/8.14.5/Submit) id u0RHNfvb001796;
	Wed, 27 Jan 2016 18:23:41 +0100
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: bitbake-devel@lists.openembedded.org, poky@yoctoproject.org
Date: Wed, 27 Jan 2016 18:23:27 +0100
Message-Id: <cd64a8090761683d02e185206d2491034ec2f475.1453915249.git.pkj@axis.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <cover.1453915249.git.pkj@axis.com>
References: <cover.1453915249.git.pkj@axis.com>
In-Reply-To: <cover.1453915249.git.pkj@axis.com>
References: <cover.1453915249.git.pkj@axis.com>
Subject: [PATCH 1/5] cooker: Allow BBMASK to contain multiple regular expressions
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
X-List-Received-Date: Wed, 27 Jan 2016 17:23:45 -0000

Before, BBMASK was only permitted to contain one regular expression.
This made it hard to add to the BBMASK in multiple places as one was
supposed to separate the different regular expressions with a "|"
rather than with whitespace as is customary in BitBake variables.

Now one can specify any number of regular expressions in BBMASK. This
makes it possible to, e.g., mask out recipes in another layer from the
layer.conf file.

This also properly ignores any regular expressions that do not compile
(before an invalid regular expression would cause a ParseError in the
first bbappend file found stating that it was not a BitBake file...)

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---
 bitbake/lib/bb/cooker.py | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 9c58d95..a02d143 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -1759,11 +1759,24 @@ class CookerCollectFiles(object):
         bbmask = config.getVar('BBMASK', True)
 
         if bbmask:
+            # First validate the individual regular expressions and ignore any
+            # that do not compile
+            bbmasks = []
+            for mask in bbmask.split():
+                try:
+                    re.compile(mask)
+                    bbmasks.append(mask)
+                except sre_constants.error:
+                    collectlog.critical("BBMASK contains an invalid regular expression, ignoring: %s" % mask)
+
+            # Then validate the combined regular expressions. This should never
+            # fail, but better safe than sorry...
+            bbmask = "|".join(bbmasks)
             try:
                 bbmask_compiled = re.compile(bbmask)
             except sre_constants.error:
-                collectlog.critical("BBMASK is not a valid regular expression, ignoring.")
-                return list(newfiles), 0
+                collectlog.critical("BBMASK is not a valid regular expression, ignoring: %s" % bbmask)
+                bbmask = None
 
         bbfiles = []
         bbappend = []
-- 
2.1.0


