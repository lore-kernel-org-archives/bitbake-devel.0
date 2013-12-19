Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 2393D60E97
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 Dec 2013 09:37:53 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	rBJ9bmOM005993 for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 Dec 2013 09:37:49 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Ica_it5XDL-Q for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 Dec 2013 09:37:48 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	rBJ9bhZg005988
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 Dec 2013 09:37:45 GMT
Message-ID: <1387445859.6402.61.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 19 Dec 2013 09:37:39 +0000
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] siggen: When printing signatures recursively, limit the output
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
X-List-Received-Date: Thu, 19 Dec 2013 09:37:54 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Currently the code prints all differences. If the task dependencies have changed hash,
we recurse into those and print those differences as well. This leads to a lot
of output. The reality is if the parents changed signature, we might as well just
say that and recurse with no other output since we're much more interested in how
the parents changed in nearly all cases. The changes in the parent are probably
the same ones we'd have printed at each level anyway.

By doing this we focus the output more carefully on the thing the user wants/needs
to see.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/siggen.py b/bitbake/lib/bb/siggen.py
index 52e698c4..370f6ad 100644
--- a/bitbake/lib/bb/siggen.py
+++ b/bitbake/lib/bb/siggen.py
@@ -430,9 +430,11 @@ def compare_sigfiles(a, b, recursecb = None):
             for dep in changed:
                 output.append("Hash for dependent task %s changed from %s to %s" % (clean_basepath(dep), a[dep], b[dep]))
                 if callable(recursecb):
+                    # If a dependent hash changed, might as well print the line above and then defer to the changes in 
+                    # that hash since in all likelyhood, they're the same changes this task also saw.
                     recout = recursecb(dep, a[dep], b[dep])
                     if recout:
-                        output.extend(recout)
+                        output = [output[-1]] + recout
 
     a_taint = a_data.get('taint', None)
     b_taint = b_data.get('taint', None)



