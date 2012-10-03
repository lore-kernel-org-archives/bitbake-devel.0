Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1TJOG4-0008Uk-Nm
	for bitbake-devel@lists.openembedded.org;
	Wed, 03 Oct 2012 14:41:00 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 03 Oct 2012 05:28:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,527,1344236400"; d="scan'208";a="229983795"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.122.52])
	by fmsmga002.fm.intel.com with ESMTP; 03 Oct 2012 05:27:59 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  3 Oct 2012 13:27:57 +0100
Message-Id: <1349267277-1380-1-git-send-email-paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] fetch2: raise an exception if user specifies protocol=git with http://
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
X-List-Received-Date: Wed, 03 Oct 2012 12:41:00 -0000

It is a common mistake to use http:// and protocol=git when attempting
to fetch from a git repository using the http protocol; if this is
detected then throw an error explaining that you need to use git:// with
protocol=http instead.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/lib/bb/fetch2/wget.py |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/bitbake/lib/bb/fetch2/wget.py b/bitbake/lib/bb/fetch2/wget.py
index 9affa0d..ea99198 100644
--- a/bitbake/lib/bb/fetch2/wget.py
+++ b/bitbake/lib/bb/fetch2/wget.py
@@ -49,6 +49,9 @@ class Wget(FetchMethod):
         return True
 
     def urldata_init(self, ud, d):
+        if 'protocol' in ud.parm:
+            if ud.parm['protocol'] == 'git':
+                raise bb.fetch2.ParameterError("Invalid protocol - if you wish to fetch from a git repository using http, you need to instead use the git:// prefix with protocol=http", ud.url)
 
         if 'downloadfilename' in ud.parm:
             ud.basename = ud.parm['downloadfilename']
-- 
1.7.9.5



