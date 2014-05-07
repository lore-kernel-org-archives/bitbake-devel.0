Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id BA01861489
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  7 May 2014 09:20:34 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s479KTPk021050 for <bitbake-devel@lists.openembedded.org>;
	Wed, 7 May 2014 10:20:29 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Mp6alH6Q-LzM for <bitbake-devel@lists.openembedded.org>;
	Wed,  7 May 2014 10:20:29 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s479KNsd021044
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 7 May 2014 10:20:25 +0100
Message-ID: <1399454417.31891.6.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 07 May 2014 10:20:17 +0100
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] data_smart: Ensure all possible overrides are cache including those with '_' in the name
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
X-List-Received-Date: Wed, 07 May 2014 09:20:35 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Unfortunately we've been neglecting to pay the correct tributes to the
cookie monster and hence the datastore is malfunctioning.

Currently tributes are only paid on the last part of a variable after
the last "_" character. We need to split by *all* "_" characters since
an override may contain the character.

This fixes the code so the correct number of tributes are made. Paradoxically
parsing appears to be faster after this change.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/data_smart.py b/bitbake/lib/bb/data_smart.py
index 9da86ce..27806f9 100644
--- a/bitbake/lib/bb/data_smart.py
+++ b/bitbake/lib/bb/data_smart.py
@@ -539,10 +539,15 @@ class DataSmart(MutableMapping):
     def _setvar_update_overrides(self, var):
         # aka pay the cookie monster
         override = var[var.rfind('_')+1:]
-        if len(override) > 0:
+        shortvar = var[:var.rfind('_')]
+        while override:
             if override not in self._seen_overrides:
                 self._seen_overrides[override] = set()
             self._seen_overrides[override].add( var )
+            override = None
+            if "_" in shortvar:
+                override = var[shortvar.rfind('_')+1:]
+                shortvar = var[:shortvar.rfind('_')]
 
     def getVar(self, var, expand=False, noweakdefault=False):
         return self.getVarFlag(var, "_content", expand, noweakdefault)



