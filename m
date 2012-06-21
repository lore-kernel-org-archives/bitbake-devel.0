Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1ShlM3-0004g1-9e
	for bitbake-devel@lists.openembedded.org;
	Thu, 21 Jun 2012 19:39:39 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 21 Jun 2012 10:28:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="114744320"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.120.141])
	by AZSMGA002.ch.intel.com with ESMTP; 21 Jun 2012 10:28:52 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 21 Jun 2012 18:28:47 +0100
Message-Id: <1340299727-8480-2-git-send-email-paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1340299727-8480-1-git-send-email-paul.eggleton@linux.intel.com>
References: <1340299727-8480-1-git-send-email-paul.eggleton@linux.intel.com>
Subject: [PATCH 2/2] lib/bb/siggen.py: log when tainting the signature of a task
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
X-List-Received-Date: Thu, 21 Jun 2012 17:39:39 -0000

Log a note when applying a taint to a task signature (e.g. when using
the -f or -C command line options) so that the user knows this has been
done.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/siggen.py |    1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index 0fb2642..edd98fc 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -268,6 +268,7 @@ class SignatureGeneratorBasicHash(SignatureGeneratorBasic):
         return ("%s.%s.%s.%s" % (stampbase, taskname, h, extrainfo)).rstrip('.')
 
     def invalidate_task(self, task, d, fn):
+        bb.note("Tainting hash to force rebuild of task %s, %s" % (fn, task))
         bb.build.write_taint(task, d, fn)
 
 def dump_this_task(outfile, d):
-- 
1.7.9.5



