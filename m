Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id BC52A6F939
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 25 Mar 2014 22:27:15 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s2PMRANr021811 for <bitbake-devel@lists.openembedded.org>;
	Tue, 25 Mar 2014 22:27:10 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 4zXlgKyAhuWg for <bitbake-devel@lists.openembedded.org>;
	Tue, 25 Mar 2014 22:27:10 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s2PMR7He021805
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 25 Mar 2014 22:27:08 GMT
Message-ID: <1395786420.24890.65.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Tue, 25 Mar 2014 22:27:00 +0000
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] data_smart: Fix caching issue for double remove references
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
X-List-Received-Date: Tue, 25 Mar 2014 22:27:18 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

FOO = "foo bar"
FOO_remove = "bar"
FOO_FOO = "${FOO} ${FOO}"

would show FOO_FOO = "foo foo bar" rather than the expected "foo foo".

This is actually a cache bug, this patch ensures the right value is
put into the cache. The preceeding patch adds a test case to ensure
we don't regress in future.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/data_smart.py b/bitbake/lib/bb/data_smart.py
index 742c7fb..e4bdb2f 100644
--- a/bitbake/lib/bb/data_smart.py
+++ b/bitbake/lib/bb/data_smart.py
@@ -614,6 +614,10 @@ class DataSmart(MutableMapping):
             filtered = filter(lambda v: v not in local_var["_removeactive"],
                               value.split(" "))
             value = " ".join(filtered)
+            if expand:
+                 # We need to ensure the expand cache has the correct value
+                 # flag == "_content" here
+                self.expand_cache[var].value = value
         return value
 
     def delVarFlag(self, var, flag, **loginfo):



