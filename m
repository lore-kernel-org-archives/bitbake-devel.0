Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	by mail.openembedded.org (Postfix) with ESMTP id 327A677CFA
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  6 Apr 2017 21:53:00 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga104.jf.intel.com with ESMTP; 06 Apr 2017 14:53:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.37,161,1488873600"; d="scan'208";a="1116565874"
Received: from anatara2-mobl2.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com.fritz.box) ([10.255.141.179])
	by orsmga001.jf.intel.com with ESMTP; 06 Apr 2017 14:52:59 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  7 Apr 2017 09:52:06 +1200
Message-Id: <916b4b9af0e3ffd88312745ebfadce51a8dfee04.1491514854.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1491514854.git.paul.eggleton@linux.intel.com>
References: <cover.1491514854.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 06/11] lib/bb/siggen: don't show unchanged runtaskdeps list
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
X-List-Received-Date: Thu, 06 Apr 2017 21:53:00 -0000

If the runtaskdeps list hasn't actually changed (but the signatures of
some of the tasks did) then it doesn't make sense to print out the old
and new lists as they are both the same and may be very long, e.g. for
do_rootfs in OE.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/siggen.py | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index f497fb9..c6b14c2 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -506,10 +506,14 @@ def compare_sigfiles(a, b, recursecb = None):
                 changed.append("%s with hash %s\n changed to\n%s with hash %s" % (a, a_data['runtaskhashes'][a], b, b_data['runtaskhashes'][b]))
 
     if changed:
-        output.append("runtaskdeps changed from %s to %s" % (clean_basepaths_list(a_data['runtaskdeps']), clean_basepaths_list(b_data['runtaskdeps'])))
+        clean_a = clean_basepaths_list(a_data['runtaskdeps'])
+        clean_b = clean_basepaths_list(b_data['runtaskdeps'])
+        if clean_a != clean_b:
+            output.append("runtaskdeps changed from %s to %s" % (clean_a, clean_b))
+        else:
+            output.append("runtaskdeps changed:")
         output.append("\n".join(changed))
 
-
     if 'runtaskhashes' in a_data and 'runtaskhashes' in b_data:
         a = a_data['runtaskhashes']
         b = b_data['runtaskhashes']
-- 
2.9.3


