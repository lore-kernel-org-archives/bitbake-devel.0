Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <mark.hatle@windriver.com>) id 1UI2qC-0007Ra-JO
	for bitbake-devel@lists.openembedded.org;
	Tue, 19 Mar 2013 21:09:01 +0100
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id r2JJqAFF020975
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Mar 2013 12:52:10 -0700 (PDT)
Received: from msp-mhatle-lx2.wrs.com (172.25.34.61) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server
	(TLS) id 14.2.342.3; Tue, 19 Mar 2013 12:52:10 -0700
From: Mark Hatle <mark.hatle@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 19 Mar 2013 15:28:51 -0500
Message-ID: <1363724931-31720-1-git-send-email-mark.hatle@windriver.com>
X-Mailer: git-send-email 1.8.1.2.545.g2f19ada
MIME-Version: 1.0
X-Originating-IP: [172.25.34.61]
Subject: [PATCH] data.py: Add a warning when expandKeys overwrites an existing key
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
X-List-Received-Date: Tue, 19 Mar 2013 20:09:02 -0000
Content-Type: text/plain

When two variables are defined as:

${var} = "bar"
foo = "foobar"

The value of 'foo' when ${var} == foo becomes indeterminate.  We
want to warn a user when this situation has been encountered so they
can take corrective actions.

In the above example usually foo == bar, unless multilibs are enabled.
Then ml-foo = "ml-foobar".

Signed-off-by: Mark Hatle <mark.hatle@windriver.com>
---
 lib/bb/data.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/bb/data.py b/lib/bb/data.py
index 7047f48..110666c 100644
--- a/lib/bb/data.py
+++ b/lib/bb/data.py
@@ -158,6 +158,11 @@ def expandKeys(alterdata, readdata = None):
 
     for key in todolist:
         ekey = todolist[key]
+        if ekey in keys(alterdata):
+            val = alterdata.getVar(key, 0)
+            newval = alterdata.getVar(ekey, 0)
+            if val is not None and newval is not None:
+                bb.warn("Variable key %s (%s) replaces original key %s (%s)." % (key, val, ekey, newval))
         alterdata.renameVar(key, ekey)
 
 def inheritFromOS(d, savedenv, permitted):
-- 
1.8.1.2.545.g2f19ada



