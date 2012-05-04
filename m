Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SQJGA-0008W0-Nh for bitbake-devel@lists.openembedded.org;
	Fri, 04 May 2012 16:13:26 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q44E3dkn014872
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 4 May 2012 15:03:39 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 14350-04 for <bitbake-devel@lists.openembedded.org>;
	Fri,  4 May 2012 15:03:35 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q44E3TbH014866
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 4 May 2012 15:03:31 +0100
Message-ID: <1336140213.23777.4.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 04 May 2012 15:03:33 +0100
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: bitbake/utils: Convert vercmp_string() to use vercmp internally
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
X-List-Received-Date: Fri, 04 May 2012 14:13:26 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Having two different version comparision algorithms in bitbake has never seemed
like a sensible idea. Worryingly, they also return different results to each other.

The vercmp_string API is relatively unused with no users in OE-Core or BitBake
itself for example. This patch converts it to use vercmp internalls, bringing
consitency to the comparisions which is easy now we have other recently added
functions. Yes, this changes behaviour but in this case I'd prefer we were
consistent than having two different comparisions.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/utils.py b/bitbake/lib/bb/utils.py
index 1d98bca..7a73419 100644
--- a/bitbake/lib/bb/utils.py
+++ b/bitbake/lib/bb/utils.py
@@ -108,130 +108,10 @@ def vercmp(ta, tb):
         r = vercmp_part(ra, rb)
     return r
 
-_package_weights_ = {"pre":-2, "p":0, "alpha":-4, "beta":-3, "rc":-1}    # dicts are unordered
-_package_ends_ = ["pre", "p", "alpha", "beta", "rc", "cvs", "bk", "HEAD" ]            # so we need ordered list
-
-def relparse(myver):
-    """Parses the last elements of a version number into a triplet, that can
-    later be compared.
-    """
-
-    number = 0
-    p1 = 0
-    p2 = 0
-    mynewver = myver.split('_')
-    if len(mynewver) == 2:
-        # an _package_weights_
-        number = float(mynewver[0])
-        match = 0
-        for x in _package_ends_:
-            elen = len(x)
-            if mynewver[1][:elen] == x:
-                match = 1
-                p1 = _package_weights_[x]
-                try:
-                    p2 = float(mynewver[1][elen:])
-                except:
-                    p2 = 0
-                break
-        if not match:
-            # normal number or number with letter at end
-            divider = len(myver)-1
-            if myver[divider:] not in "1234567890":
-                # letter at end
-                p1 = ord(myver[divider:])
-                number = float(myver[0:divider])
-            else:
-                number = float(myver)
-    else:
-        # normal number or number with letter at end
-        divider = len(myver)-1
-        if myver[divider:] not in "1234567890":
-            #letter at end
-            p1 = ord(myver[divider:])
-            number = float(myver[0:divider])
-        else:
-            number = float(myver)
-    return [number, p1, p2]
-
-__vercmp_cache__ = {}
-
-def vercmp_string(val1, val2):
-    """This takes two version strings and returns an integer to tell you whether
-    the versions are the same, val1>val2 or val2>val1.
-    """
-
-    # quick short-circuit
-    if val1 == val2:
-        return 0
-    valkey = val1 + " " + val2
-
-    # cache lookup
-    try:
-        return __vercmp_cache__[valkey]
-        try:
-            return - __vercmp_cache__[val2 + " " + val1]
-        except KeyError:
-            pass
-    except KeyError:
-        pass
-
-    # consider 1_p2 vc 1.1
-    # after expansion will become (1_p2,0) vc (1,1)
-    # then 1_p2 is compared with 1 before 0 is compared with 1
-    # to solve the bug we need to convert it to (1,0_p2)
-    # by splitting _prepart part and adding it back _after_expansion
-
-    val1_prepart = val2_prepart = ''
-    if val1.count('_'):
-        val1, val1_prepart = val1.split('_', 1)
-    if val2.count('_'):
-        val2, val2_prepart = val2.split('_', 1)
-
-    # replace '-' by '.'
-    # FIXME: Is it needed? can val1/2 contain '-'?
-
-    val1 = val1.split("-")
-    if len(val1) == 2:
-        val1[0] = val1[0] + "." + val1[1]
-    val2 = val2.split("-")
-    if len(val2) == 2:
-        val2[0] = val2[0] + "." + val2[1]
-
-    val1 = val1[0].split('.')
-    val2 = val2[0].split('.')
-
-    # add back decimal point so that .03 does not become "3" !
-    for x in xrange(1, len(val1)):
-        if val1[x][0] == '0' :
-            val1[x] = '.' + val1[x]
-    for x in xrange(1, len(val2)):
-        if val2[x][0] == '0' :
-            val2[x] = '.' + val2[x]
-
-    # extend varion numbers
-    if len(val2) < len(val1):
-        val2.extend(["0"]*(len(val1)-len(val2)))
-    elif len(val1) < len(val2):
-        val1.extend(["0"]*(len(val2)-len(val1)))
-
-    # add back _prepart tails
-    if val1_prepart:
-        val1[-1] += '_' + val1_prepart
-    if val2_prepart:
-        val2[-1] += '_' + val2_prepart
-    # The above code will extend version numbers out so they
-    # have the same number of digits.
-    for x in xrange(0, len(val1)):
-        cmp1 = relparse(val1[x])
-        cmp2 = relparse(val2[x])
-        for y in xrange(0, 3):
-            myret = cmp1[y] - cmp2[y]
-            if myret != 0:
-                __vercmp_cache__[valkey] = myret
-                return myret
-    __vercmp_cache__[valkey] = 0
-    return 0
+def vercmp_string(a, b):
+    ta = split_version(a)
+    tb = split_version(b)
+    return vercmp(ta, tb)
 
 def explode_deps(s):
     """




