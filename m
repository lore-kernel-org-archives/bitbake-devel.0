Return-Path: <anders.joergensen@advent.energy>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83967C636D7
	for <webhook@archiver.kernel.org>; Wed,  1 Feb 2023 13:59:32 +0000 (UTC)
Subject: [PATCH] Add path control to BB_ALLOWED_NETWORKS
To: bitbake-devel@lists.openembedded.org
From: =?UTF-8?B?QW5kZXJzIErDuHJnZW5zZW4=?= <anders.joergensen@advent.energy>
X-Originating-Location: Copenhagen, Capital Region, DK (89.221.170.34)
X-Originating-Platform: Linux Chrome 109
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Wed, 01 Feb 2023 05:59:26 -0800
Message-ID: <xWAM.1675259966225954323.ROLQ@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="We82o80aDbstj4Y5lmLt"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 01 Feb 2023 13:59:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14363

--We82o80aDbstj4Y5lmLt
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

From: =3D?UTF-8?q?Anders=3D20J=3DC3=3DB8rgensen?=3D <anders.joergensen@adve=
nt.energy>
Date: Wed, 1 Feb 2023 13:08:11 +0100
Subject: [PATCH] Add path control to BB_ALLOWED_NETWORKS

Make it able to add path control to the allowed network, so e.g. it is only=
 possible to access own repositories at a given host

Eg.
BB_ALLOWED_NETWORKS=3D"bitbucket.org/your_company"
The fetcher will be able to download from bitbucket.org/your_company but no=
t from bitbucket.org/other_company
---
.../bitbake-user-manual-ref-variables.rst=C2=A0 =C2=A0 =C2=A0|=C2=A0 3 +++
bitbake/lib/bb/fetch2/__init__.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| 23 +++++++++++++++----
bitbake/lib/bb/tests/fetch.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0| 12 ++++++++++
3 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-ref-variab=
les.rst b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-ref-variables=
.rst
index af4ff9805c..7942cd2d3a 100644
--- a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -84,6 +84,9 @@ overview of their function and contents.

-=C2=A0 Attempts to access networks not in the host list cause a failure.

+=C2=A0 =C2=A0 =C2=A0 -=C2=A0 Limit path control is also possible like. ::
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BB_ALLOWED_NETWORKS =3D "github.=
com/your_project bitbucket.org/your_company"
+
Using :term:`BB_ALLOWED_NETWORKS` in conjunction with
:term:`PREMIRRORS` is very useful. Adding the
host you want to use to :term:`PREMIRRORS` results in the source code
diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__in=
it__.py
index ac557176d7..69ad898464 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -1158,12 +1158,27 @@ def trusted_network(d, url):

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
diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.py
index 1152e89c0d..c641c1221e 100644
--- a/bitbake/lib/bb/tests/fetch.py
+++ b/bitbake/lib/bb/tests/fetch.py
@@ -1288,6 +1288,18 @@ class TrustedNetworksTest(FetcherTest):
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

--We82o80aDbstj4Y5lmLt
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>From: =3D?UTF-8?q?Anders=3D20J=3DC3=3DB8rgensen?=3D &lt;anders.joergen=
sen@advent.energy&gt;</div>
<div>Date: Wed, 1 Feb 2023 13:08:11 +0100</div>
<div>Subject: [PATCH] Add path control to BB_ALLOWED_NETWORKS</div>
<div>&nbsp;</div>
<div>Make it able to add path control to the allowed network, so e.g. it is=
 only possible to access own repositories at a given host</div>
<div>&nbsp;</div>
<div>Eg.</div>
<div>BB_ALLOWED_NETWORKS=3D"bitbucket.org/your_company"</div>
<div>The fetcher will be able to download from bitbucket.org/your_company b=
ut not from bitbucket.org/other_company</div>
<div>---</div>
<div>&nbsp;.../bitbake-user-manual-ref-variables.rst&nbsp; &nbsp; &nbsp;|&n=
bsp; 3 +++</div>
<div>&nbsp;bitbake/lib/bb/fetch2/__init__.py&nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp;| 23 +++++++++++++++----</div>
<div>&nbsp;bitbake/lib/bb/tests/fetch.py&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp;| 12 ++++++++++</div>
<div>&nbsp;3 files changed, 34 insertions(+), 4 deletions(-)</div>
<div>&nbsp;</div>
<div>diff --git a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-ref-v=
ariables.rst b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-ref-vari=
ables.rst</div>
<div>index af4ff9805c..7942cd2d3a 100644</div>
<div>--- a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-ref-variable=
s.rst</div>
<div>+++ b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-ref-variable=
s.rst</div>
<div>@@ -84,6 +84,9 @@ overview of their function and contents.</div>
<div>&nbsp;</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp;-&nbsp; Attempts to access networks not in =
the host list cause a failure.</div>
<div>&nbsp;</div>
<div>+&nbsp; &nbsp; &nbsp; -&nbsp; Limit path control is also possible like=
. ::</div>
<div>+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; BB_ALLOWED_NETWORKS =3D "gi=
thub.com/your_project bitbucket.org/your_company"</div>
<div>+</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp;Using :term:`BB_ALLOWED_NETWORKS` in conjun=
ction with</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp;:term:`PREMIRRORS` is very useful. Adding t=
he</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp;host you want to use to :term:`PREMIRRORS` =
results in the source code</div>
<div>diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2=
/__init__.py</div>
<div>index ac557176d7..69ad898464 100644</div>
<div>--- a/bitbake/lib/bb/fetch2/__init__.py</div>
<div>+++ b/bitbake/lib/bb/fetch2/__init__.py</div>
<div>@@ -1158,12 +1158,27 @@ def trusted_network(d, url):</div>
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
<div>diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetc=
h.py</div>
<div>index 1152e89c0d..c641c1221e 100644</div>
<div>--- a/bitbake/lib/bb/tests/fetch.py</div>
<div>+++ b/bitbake/lib/bb/tests/fetch.py</div>
<div>@@ -1288,6 +1288,18 @@ class TrustedNetworksTest(FetcherTest):</div>
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

--We82o80aDbstj4Y5lmLt--

