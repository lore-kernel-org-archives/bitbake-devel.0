Return-Path: <peter.kjellerstedt@axis.com>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
	by mail.openembedded.org (Postfix) with ESMTP id 400B172F1F
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 21 Feb 2017 15:19:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bastet.se.axis.com (Postfix) with ESMTP id 178DE1834A
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 21 Feb 2017 16:19:04 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id UItFeQ61X1ah for <bitbake-devel@lists.openembedded.org>;
	Tue, 21 Feb 2017 16:19:03 +0100 (CET)
Received: from boulder03.se.axis.com (boulder03.se.axis.com [10.0.8.17])
	by bastet.se.axis.com (Postfix) with ESMTPS id D9B38182A2
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 21 Feb 2017 16:19:02 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA6641E072
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 21 Feb 2017 16:19:02 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9F6E91E070
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 21 Feb 2017 16:19:02 +0100 (CET)
Received: from seth.se.axis.com (unknown [10.0.2.172])
	by boulder03.se.axis.com (Postfix) with ESMTP
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 21 Feb 2017 16:19:02 +0100 (CET)
Received: from saur-2.se.axis.com (saur-2.se.axis.com [10.92.3.2])
	by seth.se.axis.com (Postfix) with ESMTP id 94520E35
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 21 Feb 2017 16:19:02 +0100 (CET)
Received: from saur-2.se.axis.com (localhost [127.0.0.1])
	by saur-2.se.axis.com (8.14.5/8.14.5) with ESMTP id v1LFJ22D023521
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 21 Feb 2017 16:19:02 +0100
Received: (from pkj@localhost)
	by saur-2.se.axis.com (8.14.5/8.14.5/Submit) id v1LFJ2aL023520
	for bitbake-devel@lists.openembedded.org;
	Tue, 21 Feb 2017 16:19:02 +0100
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 21 Feb 2017 16:18:59 +0100
Message-Id: <5d593990b9eb18202a613ca5facc3f73064eaf4f.1487690243.git.pkj@axis.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <cover.1487690243.git.pkj@axis.com>
References: <cover.1487690243.git.pkj@axis.com>
X-TM-AS-GCONF: 00
Subject: [PATCH 1/2] lib/bb/utils: Add filter()
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
X-List-Received-Date: Tue, 21 Feb 2017 15:19:03 -0000

The bb.utils.filter() function can be used to filter a variable
containing whitespace separated words based on another set of words.
It has been modeled after the bb.utils.contains_any() function.

A typical example of how it can be used is to simplify constructs for
PACKAGECONFIG that depend on DISTRO_FEATURES:

-PACKAGECONFIG ?= "\
-    ${@bb.utils.contains('DISTRO_FEATURES', 'acl', 'acl', '', d)} \
-    ${@bb.utils.contains('DISTRO_FEATURES', 'selinux', 'selinux', '', d)} \
-"
+PACKAGECONFIG ?= "${@bb.utils.filter('DISTRO_FEATURES', 'acl selinux', d)}"

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---
 bitbake/lib/bb/utils.py | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/bitbake/lib/bb/utils.py b/bitbake/lib/bb/utils.py
index 2845126..d6bcfa3 100644
--- a/bitbake/lib/bb/utils.py
+++ b/bitbake/lib/bb/utils.py
@@ -979,6 +979,30 @@ def contains_any(variable, checkvalues, truevalue, falsevalue, d):
         return truevalue
     return falsevalue
 
+def filter(variable, checkvalues, d):
+    """Return all words in the variable that are present in the checkvalues.
+
+    Arguments:
+
+    variable -- the variable name. This will be fetched and expanded (using
+    d.getVar(variable)) and then split into a set().
+
+    checkvalues -- if this is a string it is split on whitespace into a set(),
+    otherwise coerced directly into a set().
+
+    d -- the data store.
+    """
+
+    val = d.getVar(variable)
+    if not val:
+        return ''
+    val = set(val.split())
+    if isinstance(checkvalues, str):
+        checkvalues = set(checkvalues.split())
+    else:
+        checkvalues = set(checkvalues)
+    return ' '.join(sorted(checkvalues & val))
+
 def cpu_count():
     return multiprocessing.cpu_count()
 
-- 
2.9.0


