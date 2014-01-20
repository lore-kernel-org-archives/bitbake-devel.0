Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id F18FB6CC49
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Jan 2014 15:21:11 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s0KFL66i009523 for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Jan 2014 15:21:07 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id OI7vg41jiCcb for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Jan 2014 15:21:07 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s0KFKrRp009496
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Jan 2014 15:20:55 GMT
Message-ID: <1390231247.874.35.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Mon, 20 Jan 2014 15:20:47 +0000
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] fetch2: Improve invalid SRCREV error message
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
X-List-Received-Date: Mon, 20 Jan 2014 15:21:12 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

The current message can be ambiguous, improve it (and also rename a
variable to clean up the rest of the function).

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index b4717c4..7e13b2f 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -897,17 +897,12 @@ def srcrev_internal_helper(ud, d, name):
             raise FetchError("Conflicting revisions (%s from SRCREV and %s from the url) found, please spcify one valid value" % (srcrev, parmrev))
         return parmrev
 
-    rev = srcrev
-    if rev == "INVALID" or not rev:
-        var = "SRCREV_pn-%s" % pn
-        if name != '':
-            var = "SRCREV_%s_pn-%s" % (name, pn)
-        raise FetchError("Please set %s to a valid value" % var, ud.url)
-    if rev == "AUTOINC":
-        rev = ud.method.latest_revision(ud, d, name)
-
-    return rev
+    if srcrev == "INVALID" or not srcrev:
+        raise FetchError("Please set a valid SRCREV for url %s (possible key names are %s, or use a ;rev=X URL parameter)" % (str(attempts), ud.url), ud.url)
+    if srcrev == "AUTOINC":
+        srcrev = ud.method.latest_revision(ud, d, name)
 
+    return srcrev
 
 def get_checksum_file_list(d):
     """ Get a list of files checksum in SRC_URI



