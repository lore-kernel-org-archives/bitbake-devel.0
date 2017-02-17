Return-Path: <markus.lehtonen@linux.intel.com>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	by mail.openembedded.org (Postfix) with ESMTP id 69D80772E3
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 17 Feb 2017 09:39:21 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by fmsmga105.fm.intel.com with ESMTP; 17 Feb 2017 01:39:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.35,171,1484035200"; d="scan'208";a="47687499"
Received: from bpaczek-mobl.ger.corp.intel.com (HELO
	mqz-osx-suse64.fi.intel.com) ([10.252.29.32])
	by orsmga002.jf.intel.com with ESMTP; 17 Feb 2017 01:39:21 -0800
From: Markus Lehtonen <markus.lehtonen@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 17 Feb 2017 11:39:18 +0200
Message-Id: <1487324358-2675-2-git-send-email-markus.lehtonen@linux.intel.com>
X-Mailer: git-send-email 2.6.6
In-Reply-To: <1487324358-2675-1-git-send-email-markus.lehtonen@linux.intel.com>
References: <1487324358-2675-1-git-send-email-markus.lehtonen@linux.intel.com>
Subject: [PATCH] fetch2/svn: change 'rsh' parameter to 'ssh'
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
X-List-Received-Date: Fri, 17 Feb 2017 09:39:22 -0000

The functionality around the 'rsh' parameter seemed to be broken. The
'rsh' parameter was only used when 'protocol' was set to 'svn+ssh' which
is confusing. The 'rsh' parameter was used for setting the value of
'svn_RSH' environment variable, which however, is not supported by svn
(not at least according to SVN documentation).

This patch removes the 'rsh' parameter and replaces it with 'ssh'. This
new (optional) parameter is used when svn+ssh protocol is used and it
can be used to specify the ssh program used by svn. This is achieved by
setting the SVN_SSH environment variable which is mentioned in SVN
documentation.

Signed-off-by: Markus Lehtonen <markus.lehtonen@linux.intel.com>
---
 lib/bb/fetch2/svn.py | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/bb/fetch2/svn.py b/lib/bb/fetch2/svn.py
index d6feeb2..7111895 100644
--- a/lib/bb/fetch2/svn.py
+++ b/lib/bb/fetch2/svn.py
@@ -79,9 +79,9 @@ class Svn(FetchMethod):
 
         proto = ud.parm.get('protocol', 'svn')
 
-        svn_rsh = None
-        if proto == "svn+ssh" and "rsh" in ud.parm:
-            svn_rsh = ud.parm["rsh"]
+        svn_ssh = None
+        if proto == "svn+ssh" and "ssh" in ud.parm:
+            svn_ssh = ud.parm["ssh"]
 
         svnroot = ud.host + ud.path
 
@@ -113,8 +113,8 @@ class Svn(FetchMethod):
             else:
                 raise FetchError("Invalid svn command %s" % command, ud.url)
 
-        if svn_rsh:
-            svncmd = "svn_RSH=\"%s\" %s" % (svn_rsh, svncmd)
+        if svn_ssh:
+            svncmd = "SVN_SSH=\"%s\" %s" % (svn_ssh, svncmd)
 
         return svncmd
 
-- 
2.6.6


