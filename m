Received: from va3ehsobe010.messaging.microsoft.com ([216.32.180.30]
	helo=VA3EHSOBE010.bigfish.com)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <B29882@freescale.com>) id 1RT8E4-0004YR-Lw
	for bitbake-devel@lists.openembedded.org;
	Wed, 23 Nov 2011 09:30:40 +0100
Received: from mail180-va3-R.bigfish.com (10.7.14.252) by
	VA3EHSOBE010.bigfish.com (10.7.40.12) with Microsoft SMTP Server id
	14.1.225.22; Wed, 23 Nov 2011 08:08:22 +0000
Received: from mail180-va3 (localhost [127.0.0.1])	by
	mail180-va3-R.bigfish.com (Postfix) with ESMTP id 945BA800B6;
	Wed, 23 Nov 2011 08:12:13 +0000 (UTC)
X-SpamScore: 3
X-BigFish: VS3(zzzz1202h1082kzz8275bhz2dh2a8h668h839h)
X-Forefront-Antispam-Report: CIP:70.37.183.190; KIP:(null); UIP:(null); IPV:NLI;
	H:mail.freescale.net; RD:none; EFVD:NLI
Received: from mail180-va3 (localhost.localdomain [127.0.0.1]) by mail180-va3
	(MessageSwitch) id 1322035932306891_26547;
	Wed, 23 Nov 2011 08:12:12 +0000 (UTC)
Received: from VA3EHSMHS016.bigfish.com (unknown [10.7.14.248])	by
	mail180-va3.bigfish.com (Postfix) with ESMTP id 44E6F140078;
	Wed, 23 Nov 2011 08:12:12 +0000 (UTC)
Received: from mail.freescale.net (70.37.183.190) by VA3EHSMHS016.bigfish.com
	(10.7.99.26) with Microsoft SMTP Server (TLS) id 14.1.225.22;
	Wed, 23 Nov 2011 08:08:18 +0000
Received: from az33smr01.freescale.net (10.64.34.199) by
	039-SN1MMR1-001.039d.mgd.msft.net (10.84.1.13) with Microsoft SMTP
	Server id 14.1.339.2; Wed, 23 Nov 2011 02:08:51 -0600
Received: from right.am.freescale.net (right.am.freescale.net [10.82.193.13])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	pAN88ojC004902; Wed, 23 Nov 2011 02:08:51 -0600 (CST)
From: Matthew McClintock <msm@freescale.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 23 Nov 2011 02:08:50 -0600
Message-ID: <1322035730-17641-1-git-send-email-msm@freescale.com>
X-Mailer: git-send-email 1.7.6.1
MIME-Version: 1.0
X-OriginatorOrg: freescale.com
Subject: [PATCH] bitbake: print out symmetric difference when comparing sigs
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
X-List-Received-Date: Wed, 23 Nov 2011 08:30:40 -0000
Content-Type: text/plain

This is useful for really longs lists to pinpoint what has
actually changed

Signed-off-by: Matthew McClintock <msm@freescale.com>
---
 lib/bb/siggen.py |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index 9b73c4c..9231291 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -251,9 +251,11 @@ def compare_sigfiles(a, b):
 
     if 'basewhitelist' in a_data and a_data['basewhitelist'] != b_data['basewhitelist']:
         print "basewhitelist changed from %s to %s" % (a_data['basewhitelist'], b_data['basewhitelist'])
+        print "changed items: %s" % a_data['basewhitelist'].symmetric_difference(b_data['basewhitelist'])
 
     if 'taskwhitelist' in a_data and a_data['taskwhitelist'] != b_data['taskwhitelist']:
         print "taskwhitelist changed from %s to %s" % (a_data['taskwhitelist'], b_data['taskwhitelist'])
+        print "changed items: %s" % a_data['taskwhitelist'].symmetric_difference(b_data['taskwhitelist'])
 
     if a_data['taskdeps'] != b_data['taskdeps']:
         print "Task dependencies changed from:\n%s\nto:\n%s" % (sorted(a_data['taskdeps']), sorted(b_data['taskdeps']))
@@ -265,6 +267,7 @@ def compare_sigfiles(a, b):
     if changed:
         for dep in changed:
             print "List of dependencies for variable %s changed from %s to %s" % (dep, a_data['gendeps'][dep], b_data['gendeps'][dep])
+            print "changed items: %s" % a_data['gendeps'][dep].symmetric_difference(b_data['gendeps'][dep])
     if added:
         for dep in added:
             print "Dependency on variable %s was added" % (dep)
@@ -293,6 +296,7 @@ def compare_sigfiles(a, b):
                 print "Hash for dependent task %s changed from %s to %s" % (dep, a[dep], b[dep])
     elif 'runtaskdeps' in a_data and 'runtaskdeps' in b_data and sorted(a_data['runtaskdeps']) != sorted(b_data['runtaskdeps']):
         print "Tasks this task depends on changed from %s to %s" % (sorted(a_data['runtaskdeps']), sorted(b_data['runtaskdeps']))
+        print "changed items: %s" % a_data['runtaskdeps'].symmetric_difference(b_data['runtaskdeps'])
 
 def dump_sigfile(a):
     p1 = pickle.Unpickler(file(a, "rb"))
-- 
1.7.6.1




