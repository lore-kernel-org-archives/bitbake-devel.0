Return-Path: <anders.joergensen@advent.energy>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD7FC636CC
	for <webhook@archiver.kernel.org>; Tue,  7 Feb 2023 12:15:41 +0000 (UTC)
Subject: [PATCH v3] fetch2: Add path control to BB_ALLOWED_NETWORKS #bitbake
To: bitbake-devel@lists.openembedded.org
From: =?UTF-8?B?QW5kZXJzIErDuHJnZW5zZW4=?= <anders.joergensen@advent.energy>
X-Originating-Location: Copenhagen, Capital Region, DK (89.221.170.34)
X-Originating-Platform: Linux Chrome 109
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Tue, 07 Feb 2023 04:15:37 -0800
Message-ID: <2D8Y.1675772137721512677.cmXP@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="J8OENj15sVbx53aQikAi"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 07 Feb 2023 12:15:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14378

--J8OENj15sVbx53aQikAi
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

From 2ec3567b1a7a765b7047140fd35dc885872cc376 Mon Sep 17 00:00:00 2001
From: =3D?UTF-8?q?Anders=3D20J=3DC3=3DB8rgensen?=3D <anders.joergensen@adve=
nt.energy>
Date: Wed, 1 Feb 2023 13:08:11 +0100
Subject: [PATCH] fetch2: Add path control to BB_ALLOWED_NETWORKS

Make it able to add path control to the allowed network, so e.g. it is only=
 possible to access own repositories at a given host

Eg.
BB_ALLOWED_NETWORKS=3D"bitbucket.org/your_company"
The fetcher will be able to download from bitbucket.org/your_company but no=
t from bitbucket.org/other_company

Signed-off-by: Anders Joergensen <anders.joergensen@advent.energy>
---
.../bitbake-user-manual-ref-variables.rst=C2=A0 =C2=A0 =C2=A0|=C2=A0 4 ++++
lib/bb/fetch2/__init__.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0| 23 +++++++++++++++----
lib/bb/tests/fetch.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 12 ++++++++++
3 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst =
b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index 09d09a8d..7d370668 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -79,6 +79,10 @@ overview of their function and contents.
For example, ``*.foo.bar`` is supported, while ``*aa.foo.bar``
is not.

+=C2=A0 =C2=A0 =C2=A0 -=C2=A0 Limited path control is also possible like. :=
:
+
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BB_ALLOWED_NETWORKS =3D "github.=
com/your_project bitbucket.org/your_company"
+
-=C2=A0 Mirrors not in the host list are skipped and logged in debug.

-=C2=A0 Attempts to access networks not in the host list cause a failure.
diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 5a7a6024..d90d9cc9 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1165,12 +1165,27 @@ def trusted_network(d, url):

network =3D network.split(':')[0]
network =3D network.lower()
+=C2=A0 =C2=A0 path =3D path.lower()
+
+=C2=A0 =C2=A0 for host_path in trusted_hosts.split(" "):
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 host_path =3D host_path.lower()
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 is_trusted =3D False
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 split_data =3D host_path.split("/", 1)
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 host =3D split_data[0]
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 trusted_path =3D None
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if len(split_data) =3D=3D 2:
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 trusted_path =3D "/" + split_dat=
a[1]

-=C2=A0 =C2=A0 for host in trusted_hosts.split(" "):
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 host =3D host.lower()
if host.startswith("*.") and ("." + network).endswith(host[1:]):
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return True
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if host =3D=3D network:
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 is_trusted =3D True
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 elif host =3D=3D network:
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 is_trusted =3D True
+
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if trusted_path and is_trusted:
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if not path.startswith(trusted_p=
ath):
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 is_trusted =3D Fal=
se
+
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if is_trusted:
return True

return False
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index f3890321..3fbe7a01 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1323,6 +1323,18 @@ class TrustedNetworksTest(FetcherTest):
self.d.setVar("BB_ALLOWED_NETWORKS", "server1.org server2.org server3.org")
self.assertFalse(bb.fetch.trusted_network(self.d, url))

+=C2=A0 =C2=A0 def test_trusted_network_path(self):
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Ensure trusted_network returns true when the=
 host and path IS in the list.
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 url =3D "git://Someserver.org/RightPath/foo;re=
v=3D1;branch=3Dmaster"
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.d.setVar("BB_ALLOWED_NETWORKS", "server1.=
org *.someserver.org/rightpath server2.org")
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertTrue(bb.fetch.trusted_network(self.=
d, url))
+
+=C2=A0 =C2=A0 def test_untrusted_network_path(self):
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Ensure trusted_network returns False when th=
e host is in list but the path is wrong.
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 url =3D "git://Someserver.org/WrongPath/foo;re=
v=3D1;branch=3Dmaster"
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.d.setVar("BB_ALLOWED_NETWORKS", "server1.=
org *.someserver.org/rightpath server2.org")
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertFalse(bb.fetch.trusted_network(self=
.d, url))
+
class URLHandle(unittest.TestCase):

datatable =3D {
--
2.34.1

--J8OENj15sVbx53aQikAi
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>From 2ec3567b1a7a765b7047140fd35dc885872cc376 Mon Sep 17 00:00:00 2001=
</div>
<div>From: =3D?UTF-8?q?Anders=3D20J=3DC3=3DB8rgensen?=3D &lt;anders.joergen=
sen@advent.energy&gt;</div>
<div>Date: Wed, 1 Feb 2023 13:08:11 +0100</div>
<div>Subject: [PATCH] fetch2: Add path control to BB_ALLOWED_NETWORKS</div>
<div>&nbsp;</div>
<div>Make it able to add path control to the allowed network, so e.g. it is=
 only possible to access own repositories at a given host</div>
<div>&nbsp;</div>
<div>Eg.</div>
<div>BB_ALLOWED_NETWORKS=3D"bitbucket.org/your_company"</div>
<div>The fetcher will be able to download from bitbucket.org/your_company b=
ut not from bitbucket.org/other_company</div>
<div>&nbsp;</div>
<div>Signed-off-by: Anders Joergensen &lt;anders.joergensen@advent.energy&g=
t;</div>
<div>---</div>
<div>&nbsp;.../bitbake-user-manual-ref-variables.rst&nbsp; &nbsp; &nbsp;|&n=
bsp; 4 ++++</div>
<div>&nbsp;lib/bb/fetch2/__init__.py&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;| 23 +++++++++++++++----</div>
<div>&nbsp;lib/bb/tests/fetch.py&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;| 12 ++++++++++</div>
<div>&nbsp;3 files changed, 35 insertions(+), 4 deletions(-)</div>
<div>&nbsp;</div>
<div>diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables=
.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst</div>
<div>index 09d09a8d..7d370668 100644</div>
<div>--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst</d=
iv>
<div>+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst</d=
iv>
<div>@@ -79,6 +79,10 @@ overview of their function and contents.</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;For example, ``*.foo.b=
ar`` is supported, while ``*aa.foo.bar``</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;is not.</div>
<div>&nbsp;</div>
<div>+&nbsp; &nbsp; &nbsp; -&nbsp; Limited path control is also possible li=
ke. ::</div>
<div>+</div>
<div>+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; BB_ALLOWED_NETWORKS =3D "gi=
thub.com/your_project bitbucket.org/your_company"</div>
<div>+</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp;-&nbsp; Mirrors not in the host list are sk=
ipped and logged in debug.</div>
<div>&nbsp;</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp;-&nbsp; Attempts to access networks not in =
the host list cause a failure.</div>
<div>diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py</di=
v>
<div>index 5a7a6024..d90d9cc9 100644</div>
<div>--- a/lib/bb/fetch2/__init__.py</div>
<div>+++ b/lib/bb/fetch2/__init__.py</div>
<div>@@ -1165,12 +1165,27 @@ def trusted_network(d, url):</div>
<div>&nbsp;</div>
<div>&nbsp; &nbsp; &nbsp;network =3D network.split(':')[0]</div>
<div>&nbsp; &nbsp; &nbsp;network =3D network.lower()</div>
<div>+&nbsp; &nbsp; path =3D path.lower()</div>
<div>+</div>
<div>+&nbsp; &nbsp; for host_path in trusted_hosts.split(" "):</div>
<div>+&nbsp; &nbsp; &nbsp; &nbsp; host_path =3D host_path.lower()</div>
<div>+&nbsp; &nbsp; &nbsp; &nbsp; is_trusted =3D False</div>
<div>+&nbsp; &nbsp; &nbsp; &nbsp; split_data =3D host_path.split("/", 1)</d=
iv>
<div>+&nbsp; &nbsp; &nbsp; &nbsp; host =3D split_data[0]</div>
<div>+&nbsp; &nbsp; &nbsp; &nbsp; trusted_path =3D None</div>
<div>+&nbsp; &nbsp; &nbsp; &nbsp; if len(split_data) =3D=3D 2:</div>
<div>+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; trusted_path =3D "/" + spli=
t_data[1]</div>
<div>&nbsp;</div>
<div>-&nbsp; &nbsp; for host in trusted_hosts.split(" "):</div>
<div>-&nbsp; &nbsp; &nbsp; &nbsp; host =3D host.lower()</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if host.startswith("*.") and ("." + =
network).endswith(host[1:]):</div>
<div>-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return True</div>
<div>-&nbsp; &nbsp; &nbsp; &nbsp; if host =3D=3D network:</div>
<div>+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; is_trusted =3D True</div>
<div>+&nbsp; &nbsp; &nbsp; &nbsp; elif host =3D=3D network:</div>
<div>+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; is_trusted =3D True</div>
<div>+</div>
<div>+&nbsp; &nbsp; &nbsp; &nbsp; if trusted_path and is_trusted:</div>
<div>+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if not path.startswith(trus=
ted_path):</div>
<div>+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; is_trusted =
=3D False</div>
<div>+</div>
<div>+&nbsp; &nbsp; &nbsp; &nbsp; if is_trusted:</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return True</div>
<div>&nbsp;</div>
<div>&nbsp; &nbsp; &nbsp;return False</div>
<div>diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py</div>
<div>index f3890321..3fbe7a01 100644</div>
<div>--- a/lib/bb/tests/fetch.py</div>
<div>+++ b/lib/bb/tests/fetch.py</div>
<div>@@ -1323,6 +1323,18 @@ class TrustedNetworksTest(FetcherTest):</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;self.d.setVar("BB_ALLOWED_NETWORKS",=
 "server1.org server2.org server3.org")</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;self.assertFalse(bb.fetch.trusted_ne=
twork(self.d, url))</div>
<div>&nbsp;</div>
<div>+&nbsp; &nbsp; def test_trusted_network_path(self):</div>
<div>+&nbsp; &nbsp; &nbsp; &nbsp; # Ensure trusted_network returns true whe=
n the host and path IS in the list.</div>
<div>+&nbsp; &nbsp; &nbsp; &nbsp; url =3D "git://Someserver.org/RightPath/f=
oo;rev=3D1;branch=3Dmaster"</div>
<div>+&nbsp; &nbsp; &nbsp; &nbsp; self.d.setVar("BB_ALLOWED_NETWORKS", "ser=
ver1.org *.someserver.org/rightpath server2.org")</div>
<div>+&nbsp; &nbsp; &nbsp; &nbsp; self.assertTrue(bb.fetch.trusted_network(=
self.d, url))</div>
<div>+</div>
<div>+&nbsp; &nbsp; def test_untrusted_network_path(self):</div>
<div>+&nbsp; &nbsp; &nbsp; &nbsp; # Ensure trusted_network returns False wh=
en the host is in list but the path is wrong.</div>
<div>+&nbsp; &nbsp; &nbsp; &nbsp; url =3D "git://Someserver.org/WrongPath/f=
oo;rev=3D1;branch=3Dmaster"</div>
<div>+&nbsp; &nbsp; &nbsp; &nbsp; self.d.setVar("BB_ALLOWED_NETWORKS", "ser=
ver1.org *.someserver.org/rightpath server2.org")</div>
<div>+&nbsp; &nbsp; &nbsp; &nbsp; self.assertFalse(bb.fetch.trusted_network=
(self.d, url))</div>
<div>+</div>
<div>&nbsp;class URLHandle(unittest.TestCase):</div>
<div>&nbsp;</div>
<div>&nbsp; &nbsp; &nbsp;datatable =3D {</div>
<div>--&nbsp;</div>
<div>2.34.1</div>
<div>&nbsp;</div>

--J8OENj15sVbx53aQikAi--

