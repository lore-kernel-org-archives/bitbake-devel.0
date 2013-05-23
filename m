Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 5FCE66086B
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 23 May 2013 09:47:58 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r4N9pdHG017339 for <bitbake-devel@lists.openembedded.org>;
	Thu, 23 May 2013 10:51:39 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id TwHN-Cf7jPoN for <bitbake-devel@lists.openembedded.org>;
	Thu, 23 May 2013 10:51:39 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r4N9paY6017325
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT) for <bitbake-devel@lists.openembedded.org>;
	Thu, 23 May 2013 10:51:38 +0100
Message-ID: <1369302465.14887.26.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 23 May 2013 10:47:45 +0100
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] methodpool: Conflicting methodnames should be a fatal error
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 23 May 2013 09:47:59 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

When this error occurs, the build should stop, not continue uninterrupted.

[YOCTO #4460]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/methodpool.py b/bitbake/lib/bb/methodpool.py
index 2fb5d96..8ad23c6 100644
--- a/bitbake/lib/bb/methodpool.py
+++ b/bitbake/lib/bb/methodpool.py
@@ -50,7 +50,7 @@ def insert_method(modulename, code, fn):
         if name in ['None', 'False']:
             continue
         elif name in _parsed_fns and not _parsed_fns[name] == modulename:
-            error("The function %s defined in %s was already declared in %s. BitBake has a global python function namespace so shared functions should be declared in a common include file rather than being duplicated, or if the functions are different, please use different function names." % (name, modulename, _parsed_fns[name]))
+            bb.fatal("The function %s defined in %s was already declared in %s. BitBake has a global python function namespace so shared functions should be declared in a common include file rather than being duplicated, or if the functions are different, please use different function names." % (name, modulename, _parsed_fns[name]))
         else:
             _parsed_fns[name] = modulename
 



