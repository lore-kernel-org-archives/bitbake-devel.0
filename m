Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 2CDCF60670
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 25 Jan 2015 21:50:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t0PLoZlf008872 for <bitbake-devel@lists.openembedded.org>;
	Sun, 25 Jan 2015 21:50:35 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 9bzzvKqJZAyK for <bitbake-devel@lists.openembedded.org>;
	Sun, 25 Jan 2015 21:50:35 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t0PLoM60008869
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 25 Jan 2015 21:50:34 GMT
Message-ID: <1422222622.19798.37.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Sun, 25 Jan 2015 21:50:22 +0000
X-Mailer: Evolution 3.12.7-0ubuntu1 
Mime-Version: 1.0
Subject: Broken COW? Any python gurus who fancy an odd problem to debug?
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
X-List-Received-Date: Sun, 25 Jan 2015 21:50:43 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Whilst playing with the datastore I noticed something very odd, a
supposedly empty datastore had shadows of "things" in it. The selftests
are a great way to show this. To demo, apply the patch below, then run:

BB_SKIP_NETTESTS=yes bitbake-selftest

and you will see the output:

here 0 <COWDict Level: 1 Current Keys: 11> libinstall__mutable__ __module__ UTMPDIR__mutable__ foo__mutable__ __count__ BASE_NAME__mutable__ LOGDIR__mutable__ NAME__mutable__ MAILFILE__mutable__ of_foo__mutable__ MAILDIR__mutable__ something__mutable__ __hasmutable__ __doc__

The odd part is this is an empty data store so where did libinstall,
UTMPDIR, BASE_NAME, LOGDIR and so on come from? The answer is other data
stores :(.

in data.py, if you change init() to be:

- return _dict_type()
+ return _dict_type(special = COWDictBase.copy(), seen = COWDictBase.copy())

then it "works". Why? I've no idea but I'd love to understand it.

Cheers,

Richard

diff --git a/bitbake/lib/bb/COW.py b/bitbake/lib/bb/COW.py
index 6917ec3..29ecbc2 100644
--- a/bitbake/lib/bb/COW.py
+++ b/bitbake/lib/bb/COW.py
@@ -50,7 +50,11 @@ class COWDictMeta(COWMeta):
 
     def __str__(cls):
         # FIXME: I have magic numbers!
-        return "<COWDict Level: %i Current Keys: %i>" % (cls.__count__, len(cls.__dict__) - 3)
+        r = ""
+        for k in cls.__dict__:
+            r = r + " " + str(k)
+
+        return "<COWDict Level: %i Current Keys: %i>" % (cls.__count__, len(cls.__dict__) - 3) + r
     __repr__ = __str__
 
     def cow(cls):
diff --git a/bitbake/lib/bb/tests/data.py b/bitbake/lib/bb/tests/data.py
index 81e4091..1c8c1f9 100644
--- a/bitbake/lib/bb/tests/data.py
+++ b/bitbake/lib/bb/tests/data.py
@@ -294,6 +294,11 @@ class TestOverrides(unittest.TestCase):
         bb.data.update_data(self.d)
         self.assertEqual(self.d.getVar("TEST", True), "testvalue3")
 
+class TestCOW(unittest.TestCase):
+    def test_cow(self):
+        self.d = bb.data.init()
+        self.d.setVar("OVERRIDES", "foo:bar:local")
+        print("here 0 %s" % str(self.d._seen_overrides))
 
 class TestFlags(unittest.TestCase):
     def setUp(self):



