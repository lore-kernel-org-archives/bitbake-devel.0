Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 699CF60118
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  2 Feb 2016 13:59:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u12DxvEp003864
	for <bitbake-devel@lists.openembedded.org>; Tue, 2 Feb 2016 13:59:57 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id bHPHvojyeU98 for <bitbake-devel@lists.openembedded.org>;
	Tue,  2 Feb 2016 13:59:57 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u12DxqJY003861
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 2 Feb 2016 13:59:53 GMT
Message-ID: <1454421592.27087.68.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Tue, 02 Feb 2016 13:59:52 +0000
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: [PATCH] cooker: Don't expand python functions in variable dumps
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
X-List-Received-Date: Tue, 02 Feb 2016 13:59:57 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

We don't want to expand python functions since they aren't expanded
at execution time (e.g. anonymous python). They can also have side 
effects.

This function is primarily used by toaster for variable dumps for later
display. The lack of expansion of python functions won't matter in this case
and actively helps some variable handling (e.g. SRCPV).

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index edd682b..fa5e631 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -1429,14 +1429,21 @@ class BBCooker:
         dump = {}
         for k in self.data.keys():
             try:
-                v = self.data.getVar(k, True)
+                expand = True
+                flags = self.data.getVarFlags(k)
+                if flags and "func" in flags and "python" in flags:
+                    expand = False
+                v = self.data.getVar(k, expand)
                 if not k.startswith("__") and not isinstance(v, bb.data_smart.DataSmart):
                     dump[k] = {
     'v' : v ,
     'history' : self.data.varhistory.variable(k),
                     }
                     for d in flaglist:
-                        dump[k][d] = self.data.getVarFlag(k, d)
+                        if flags and d in flags:
+                            dump[k][d] = flags[d]
+                        else:
+                            dump[k][d] = None
             except Exception as e:
                 print(e)
         return dump



