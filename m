Return-Path: <jdebski@enigma.com.pl>
Received: from mail.enigma.com.pl (mail.enigma.com.pl [91.198.145.120])
	by mail.openembedded.org (Postfix) with ESMTP id 424687451D
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 17 Apr 2018 10:00:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by mail.enigma.com.pl (Postfix) with ESMTP id B662A17163C98C
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 17 Apr 2018 12:00:23 +0200 (CEST)
Received: from mail.enigma.com.pl ([127.0.0.1])
	by localhost (mail.enigma.com.pl [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id NJ9FY3UNMBrA; Tue, 17 Apr 2018 12:00:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mail.enigma.com.pl (Postfix) with ESMTP id 58B3F17162556A;
	Tue, 17 Apr 2018 12:00:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mail.enigma.com.pl
Received: from mail.enigma.com.pl ([127.0.0.1])
	by localhost (mail.enigma.com.pl [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id okHAX3kDsEV5; Tue, 17 Apr 2018 12:00:22 +0200 (CEST)
Received: from jdebski-black.enigma.com.pl (unknown [10.14.1.110])
	by mail.enigma.com.pl (Postfix) with ESMTPSA id 334E81716FF2EF;
	Tue, 17 Apr 2018 12:00:22 +0200 (CEST)
From: =?UTF-8?q?Jakub=20D=C4=99bski?= <jdebski@enigma.com.pl>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 17 Apr 2018 12:00:17 +0200
Message-Id: <1523959217-4706-1-git-send-email-jdebski@enigma.com.pl>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Cc: =?UTF-8?q?Jakub=20D=C4=99bski?= <jdebski@enigma.com.pl>
Subject: [PATCH] fetch2/__init__.py: Fixed handling of uris with empty path (fixed version)
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
X-List-Received-Date: Tue, 17 Apr 2018 10:00:23 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

For mirrors or premirrors defined like: "http://.*/.* http://somewhere.or=
g"
fetching ends with errors because function fetch2/__init__.py:encodeurl()
creates url like "http://somewhere.orgsomefile.tar.gz".

It happens because function fetch2/__init__.py:decodeurl()
for url "http://somewhere.org" returns
['http', 'somewhere.org', '', '', '', {}]
and then in function fetch2/__init__.py:uri_replace()
variable result_decode will be
['http', 'somewhere.org', 'somefile.tar.gz', '', '', {}]
(because of line: result_decoded[loc] =3D os.path.join(result_decoded[loc=
], basename))
for which encodeurl returns "http://somewhere.orgsomefile.tar.gz".

In addition for mirror "http://.*/.* http://somewhere.org/"
everything works fine.

Signed-off-by: Jakub D=C4=99bski <jdebski@enigma.com.pl>
---
 lib/bb/fetch2/__init__.py | 2 +-
 lib/bb/tests/fetch.py     | 6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 72d6092..c8e2f82 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -383,7 +383,7 @@ def decodeurl(url):
         path =3D location
     else:
         host =3D location
-        path =3D ""
+        path =3D "/"
     if user:
         m =3D re.compile('(?P<user>[^:]+)(:?(?P<pswd>.*))').match(user)
         if m:
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 74859f9..1821ee8 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -402,6 +402,10 @@ class MirrorUriTest(FetcherTest):
             : "git://somewhere.org/somedir/mtd-utils.git;tag=3D123456789=
0123456789012345678901234567890;protocol=3Dhttp",=20
         ("git://git.invalid.infradead.org/foo/mtd-utils.git;tag=3D123456=
7890123456789012345678901234567890", "git://.*/.*", "git://somewhere.org/=
somedir/MIRRORNAME;protocol=3Dhttp")=20
             : "git://somewhere.org/somedir/git.invalid.infradead.org.foo=
.mtd-utils.git;tag=3D1234567890123456789012345678901234567890;protocol=3D=
http",=20
+        ("http://somewhere.org/somedir1/somedir2/somefile_1.2.3.tar.gz",=
 "http://.*/.*", "http://somewhere2.org")
+            : "http://somewhere2.org/somefile_1.2.3.tar.gz",
+        ("http://somewhere.org/somedir1/somedir2/somefile_1.2.3.tar.gz",=
 "http://.*/.*", "http://somewhere2.org/")
+            : "http://somewhere2.org/somefile_1.2.3.tar.gz",
=20
         #Renaming files doesn't work
         #("http://somewhere.org/somedir1/somefile_1.2.3.tar.gz", "http:/=
/somewhere.org/somedir1/somefile_1.2.3.tar.gz", "http://somewhere2.org/so=
medir3/somefile_2.3.4.tar.gz") : "http://somewhere2.org/somedir3/somefile=
_2.3.4.tar.gz"
@@ -832,7 +836,7 @@ class URLHandle(unittest.TestCase):
     # decodeurl and we need to handle them
     decodedata =3D datatable.copy()
     decodedata.update({
-       "http://somesite.net;someparam=3D1": ('http', 'somesite.net', '',=
 '', '', {'someparam': '1'}),
+       "http://somesite.net;someparam=3D1": ('http', 'somesite.net', '/'=
, '', '', {'someparam': '1'}),
     })
=20
     def test_decodeurl(self):
--=20
2.7.4


