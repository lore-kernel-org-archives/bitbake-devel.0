Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 0ACC171A00
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 16 Nov 2016 11:20:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	uAGBKCDE013870 for <bitbake-devel@lists.openembedded.org>;
	Wed, 16 Nov 2016 11:20:12 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id vn1iPvWbePKE for <bitbake-devel@lists.openembedded.org>;
	Wed, 16 Nov 2016 11:20:11 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	uAGBK6X5013867
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 16 Nov 2016 11:20:07 GMT
Message-ID: <1479295206.28508.7.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 16 Nov 2016 11:20:06 +0000
X-Mailer: Evolution 3.18.5.2-0ubuntu3 
Mime-Version: 1.0
Subject: [PATCH] data: Drop deprecated old style bitbake API
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
X-List-Received-Date: Wed, 16 Nov 2016 11:20:11 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit


The old style bb.data.getVar/setVar API has long since been deprecated in
favour of d.getVar/setVar and friends.

Now we're about to change the default expansion parameter, drop the old APIs
to simplify the transition and ensure everyone is using the new style functions.
Conversion is trivial if there are remaining stragglers.

I've left bb.data.expand() for now since its more widely used but would make a good
follow up patch series.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/data.py b/bitbake/lib/bb/data.py
index 5872aee..24e758a 100644
--- a/bitbake/lib/bb/data.py
+++ b/bitbake/lib/bb/data.py
@@ -78,59 +78,6 @@ def initVar(var, d):
     """Non-destructive var init for data structure"""
     d.initVar(var)
 
-
-def setVar(var, value, d):
-    """Set a variable to a given value"""
-    d.setVar(var, value)
-
-
-def getVar(var, d, exp = False):
-    """Gets the value of a variable"""
-    return d.getVar(var, exp)
-
-
-def renameVar(key, newkey, d):
-    """Renames a variable from key to newkey"""
-    d.renameVar(key, newkey)
-
-def delVar(var, d):
-    """Removes a variable from the data set"""
-    d.delVar(var)
-
-def appendVar(var, value, d):
-    """Append additional value to a variable"""
-    d.appendVar(var, value)
-
-def setVarFlag(var, flag, flagvalue, d):
-    """Set a flag for a given variable to a given value"""
-    d.setVarFlag(var, flag, flagvalue)
-
-def getVarFlag(var, flag, d):
-    """Gets given flag from given var"""
-    return d.getVarFlag(var, flag, False)
-
-def delVarFlag(var, flag, d):
-    """Removes a given flag from the variable's flags"""
-    d.delVarFlag(var, flag)
-
-def setVarFlags(var, flags, d):
-    """Set the flags for a given variable
-
-    Note:
-        setVarFlags will not clear previous
-        flags. Think of this method as
-        addVarFlags
-    """
-    d.setVarFlags(var, flags)
-
-def getVarFlags(var, d):
-    """Gets a variable's flags"""
-    return d.getVarFlags(var)
-
-def delVarFlags(var, d):
-    """Removes a variable's flags"""
-    d.delVarFlags(var)
-
 def keys(d):
     """Return a list of keys in d"""
     return d.keys()



