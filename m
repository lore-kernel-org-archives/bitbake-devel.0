Return-Path: <public@smn.dk>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D210C77B61
	for <webhook@archiver.kernel.org>; Sun, 16 Apr 2023 20:07:18 +0000 (UTC)
Subject: [PATCH] npmsw fetcher: Avoid instantiating Fetch class if url list is empty
To: bitbake-devel@lists.openembedded.org
From: public@smn.dk
X-Originating-Location: Birkerød, Capital Region, DK (130.228.29.38)
X-Originating-Platform: Windows Chrome 112
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Sun, 16 Apr 2023 13:07:15 -0700
Message-ID: <czCu.1681675635331210887.i1y4@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="KJTpFSHZcTDGtEytAGJT"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 16 Apr 2023 20:07:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14706

--KJTpFSHZcTDGtEytAGJT
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Recipes containing both git and npmsw sources in the SRC_URI
fail during fetch from the shrinkwrap. It seems that when the fetcher is
fetching from the shrinkwrap, the SRCREV variable has been deleted but it
still ends up fetching from the git source resulting in an error because
SRCREV is undefined. The root cause of this is that the Fetch class default=
s
to urls from the SRC_URI when the urls parameter contains an empty list. Th=
is
patch will ensure that Fetch is not instantiated if the urls list is empty.

Signed-off-by: Svend Meyland Nicolaisen <public@smn.dk>
---
lib/bb/fetch2/npmsw.py | 4 +++-
1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/npmsw.py b/lib/bb/fetch2/npmsw.py
index 36fcbfba..cc81100b 100644
--- a/lib/bb/fetch2/npmsw.py
+++ b/lib/bb/fetch2/npmsw.py
@@ -205,7 +205,9 @@ class NpmShrinkWrap(FetchMethod):
# This fetcher resolves multiple URIs from a shrinkwrap file and then
# forwards it to a proxy fetcher. The management of the donestamp file,
# the lockfile and the checksums are forwarded to the proxy fetcher.
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ud.proxy =3D Fetch([dep["url"] for dep in ud.d=
eps if dep["url"]], data)
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 shrinkwrap_urls =3D [dep["url"] for dep in ud.=
deps if dep["url"]]
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if shrinkwrap_urls:
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ud.proxy =3D Fetch(shrinkwrap_ur=
ls, data)
ud.needdonestamp =3D False

@staticmethod
--
2.39.2.windows.1

--KJTpFSHZcTDGtEytAGJT
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div><br />Recipes containing both git and npmsw sources in the SRC_URI</di=
v>
<div>&nbsp;fail during fetch from the shrinkwrap. It seems that when the fe=
tcher is</div>
<div>&nbsp;fetching from the shrinkwrap, the SRCREV variable has been delet=
ed but it</div>
<div>&nbsp;still ends up fetching from the git source resulting in an error=
 because</div>
<div>&nbsp;SRCREV is undefined. The root cause of this is that the Fetch cl=
ass defaults</div>
<div>&nbsp;to urls from the SRC_URI when the urls parameter contains an emp=
ty list. This</div>
<div>&nbsp;patch will ensure that Fetch is not instantiated if the urls lis=
t is empty.</div>
<div>&nbsp;</div>
<div>Signed-off-by: Svend Meyland Nicolaisen &lt;public@smn.dk&gt;</div>
<div>---</div>
<div>&nbsp;lib/bb/fetch2/npmsw.py | 4 +++-</div>
<div>&nbsp;1 file changed, 3 insertions(+), 1 deletion(-)</div>
<div>&nbsp;</div>
<div>diff --git a/lib/bb/fetch2/npmsw.py b/lib/bb/fetch2/npmsw.py</div>
<div>index 36fcbfba..cc81100b 100644</div>
<div>--- a/lib/bb/fetch2/npmsw.py</div>
<div>+++ b/lib/bb/fetch2/npmsw.py</div>
<div>@@ -205,7 +205,9 @@ class NpmShrinkWrap(FetchMethod):</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;# This fetcher resolves multiple URI=
s from a shrinkwrap file and then</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;# forwards it to a proxy fetcher. Th=
e management of the donestamp file,</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;# the lockfile and the checksums are=
 forwarded to the proxy fetcher.</div>
<div>-&nbsp; &nbsp; &nbsp; &nbsp; ud.proxy =3D Fetch([dep["url"] for dep in=
 ud.deps if dep["url"]], data)</div>
<div>+&nbsp; &nbsp; &nbsp; &nbsp; shrinkwrap_urls =3D [dep["url"] for dep i=
n ud.deps if dep["url"]]</div>
<div>+&nbsp; &nbsp; &nbsp; &nbsp; if shrinkwrap_urls:</div>
<div>+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ud.proxy =3D Fetch(shrinkwr=
ap_urls, data)</div>
<div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ud.needdonestamp =3D False</div>
<div>&nbsp;</div>
<div>&nbsp; &nbsp; &nbsp;@staticmethod</div>
<div>--&nbsp;</div>
<div>2.39.2.windows.1</div>
<div>&nbsp;</div>

--KJTpFSHZcTDGtEytAGJT--

