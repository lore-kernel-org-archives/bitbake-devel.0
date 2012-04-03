Received: from mail-ob0-f175.google.com ([209.85.214.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1SFDDl-0006QY-Tm
	for bitbake-devel@lists.openembedded.org;
	Wed, 04 Apr 2012 01:33:06 +0200
Received: by obbuo13 with SMTP id uo13so370199obb.6
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 03 Apr 2012 16:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:x-mailer;
	bh=Fs1dZ5FkLmb0e88gyoMQLzJV9TMDss0zqRrexVESjk4=;
	b=ZsCiW9EuiJmVlXGafxFEpJlLU1ES6cVcXY4epKJoEj54ui9TXG3we/h7wtiaF3oLUO
	0NBAIdhhFlUmTxFT5IPCwouJc00Mk2a3Te8aDkCp9qpEasdvNkOQA35XW1i7b1DVRrGq
	N1MYSYlm7cTtDHTzRC8ZJ0YHtTsLrpc2ESONAq0E5bMhKojmOJXP9wNiB9zFeojMGu2d
	ozxQ9qG4b84ssMpNYh0W2Q6gSf28S0XeuY77zYeJ4ok3mGA7o3FArXeKlL+N0zEo5gAh
	r95sTeaO61UI3l7iImYZ+0M0TVlwkg1/erBBnrcSQX3qDGh0N2rU1+8g7EKZY4Ur/GfY
	A5/A==
Received: by 10.60.154.209 with SMTP id vq17mr9229923oeb.28.1333495435546;
	Tue, 03 Apr 2012 16:23:55 -0700 (PDT)
Received: from localhost.localdomain (nat-lmt.mentorg.com. [139.181.28.34])
	by mx.google.com with ESMTPS id s2sm18288303oea.2.2012.04.03.16.23.53
	(version=TLSv1/SSLv3 cipher=OTHER);
	Tue, 03 Apr 2012 16:23:54 -0700 (PDT)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  3 Apr 2012 18:23:49 -0500
Message-Id: <1333495429-17048-1-git-send-email-kergoth@gmail.com>
X-Mailer: git-send-email 1.7.7
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: [PATCH] Remove whitelisted vars from non-task deps
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
X-List-Received-Date: Tue, 03 Apr 2012 23:33:06 -0000

From: Christopher Larson <chris_larson@mentor.com>

Though the value of variables in the BB_BASEHASH_WHITELIST is kept out of the
checksums, dependency on them is not, at least for variables and non-task
functions. In the code, the whitelist is removed from the overall task dep
list, but not the individual variable deps. The result of this is that
functions like sysroot_stage_all and oe_runmake end up with whitelisted
variables like TERM listed in their dependencies, which means that doing
a 'unset TERM' before building will result in all checksums for tasks that
depend on those changing, and shared state reuse not behaving correctly.

This is only really a potential issue for variables from the environment, as
it's the existance/removal of the variable that's an issue, not its value, and
the other whitelisted variables are set in our metadata. This which means in
practical terms the only cases where this is likely to be an issue are in
environments where one of the following are unset: TERM, LOGNAME, HOME, USER,
PWD, SHELL. This may seem like an unlikely circumstance, but is in fact a real
issue for those of us using autobuilders. Jenkins does not set TERM when
executing shell, which means shared state archives produced by your jenkins
server would not be fully reused by an actual user.

Fixed by removing the whitelisted elements from the individual variable deps,
not just the accumulated result.

Signed-off-by: Christopher Larson <chris_larson@mentor.com>
---
 lib/bb/siggen.py |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index 8c79b17..7f5ae93 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -89,6 +89,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
                 bb.error("Task %s from %s seems to be empty?!" % (task, fn))
                 data = ''
 
+            gendeps[task] -= self.basewhitelist
             newdeps = gendeps[task]
             seen = set()
             while newdeps:
@@ -98,12 +99,12 @@ class SignatureGeneratorBasic(SignatureGenerator):
                 for dep in nextdeps:
                     if dep in self.basewhitelist:
                         continue
+                    gendeps[dep] -= self.basewhitelist
                     newdeps |= gendeps[dep]
                 newdeps -= seen
 
-            alldeps = seen - self.basewhitelist
-
-            for dep in sorted(alldeps):
+            alldeps = sorted(seen)
+            for dep in alldeps:
                 data = data + dep
                 if dep in lookupcache:
                     var = lookupcache[dep]
@@ -113,7 +114,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
                 if var:
                     data = data + str(var)
             self.basehash[fn + "." + task] = hashlib.md5(data).hexdigest()
-            taskdeps[task] = sorted(alldeps)
+            taskdeps[task] = alldeps
 
         self.taskdeps[fn] = taskdeps
         self.gendeps[fn] = gendeps
-- 
1.7.7



