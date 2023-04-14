Return-Path: <public@smn.dk>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 140A9C77B72
	for <webhook@archiver.kernel.org>; Fri, 14 Apr 2023 11:42:01 +0000 (UTC)
Subject: Problems having both git and npmsw sources in recipe #bitbake
To: bitbake-devel@lists.openembedded.org
From: public@smn.dk
X-Originating-Location: Birkerød, Capital Region, DK (130.228.29.38)
X-Originating-Platform: Windows Chrome 112
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Fri, 14 Apr 2023 04:41:57 -0700
Message-ID: <ppBZ.1681472517878402202.SeyY@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="LkXpKnXccfZIhGxIAAHz"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 14 Apr 2023 11:42:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14699

--LkXpKnXccfZIhGxIAAHz
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi

I have posted the following topic under the group Openembedded-issues. I am=
 a little unsure if that is the right place, as there seems to be little or=
 no activity in that group?

Openembedded-issues@lists.openembedded.org | Problems having both git and n=
pmsw sources in recipe ( https://lists.openembedded.org/g/Openembedded-issu=
es/topic/problems_having_both_git_and/98260091?p=3D,,,20,0,0,0::recentpostd=
ate/sticky,,,20,2,0,98260091,previd%3D1681471653367016231,nextid%3D13285434=
07000000000&previd=3D1681471653367016231&nextid=3D1328543407000000000 )

Hi

I am experiencing problems with a recipe where I have both a git and a npms=
w source in the SRC_URI. It seems that when the fetcher is fetching from th=
e shrinkwrap, the SRCREV variable has been deleted but it still ends up fet=
ching from the git source resulting in an error because SRCREV is undefined=
.

The problem occurs because the Fetch class defaults to the value of SRC_URI=
 if the urls parameter contains an empty list. The following change to the =
npmsw.py file seems to solve the problem:

diff --git a/bitbake/lib/bb/fetch2/npmsw.py b/bitbake/lib/bb/fetch2/npmsw.p=
y
index=C2=A0a8c4d3528f..4d700a537a=C2=A0100644
---=C2=A0a/bitbake/lib/bb/fetch2/npmsw.py
+++=C2=A0b/bitbake/lib/bb/fetch2/npmsw.py
@@=C2=A0-193,7=C2=A0+193,9=C2=A0@@=C2=A0class=C2=A0NpmShrinkWrap(FetchMetho=
d):
# This fetcher resolves multiple URIs from a shrinkwrap file and then
# forwards it to a proxy fetcher. The management of the donestamp file,
# the lockfile and the checksums are forwarded to the proxy fetcher.
- =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ud.proxy =3D Fetch([dep["url"] =
for dep in ud.deps if dep["url"]], data)
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0shrinkwrap_urls=C2=A0=3D=
=C2=A0[dep["url"]=C2=A0for=C2=A0dep=C2=A0in=C2=A0ud.deps=C2=A0if=C2=A0dep["=
url"]]
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if=C2=A0shrinkwrap_urls:
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ud=
.proxy=C2=A0=3D=C2=A0Fetch(shrinkwrap_urls,=C2=A0data)
ud.needdonestamp=C2=A0=3D=C2=A0False

Are=C2=A0this=C2=A0change=C2=A0OK=C2=A0or=C2=A0can=C2=A0it=C2=A0result=C2=
=A0in=C2=A0other=C2=A0issues?

Also more generally why does the Fetch class default to the value of SRC_UR=
I variable if the urls parameter contains an empty list? Isn't this a stran=
ge implementation? It also seems to result in issues if the shrinkwrap file=
 contains no dependencies.

Please note that I am fairly new to bitbake and completely new to the sourc=
e code. :)

Kind=C2=A0regards,
Svend=C2=A0Meyland=C2=A0Nicolaisen

--LkXpKnXccfZIhGxIAAHz
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi<br /><br />I have posted the following topic under the group Openembedde=
d-issues. I am a little unsure if that is the right place, as there seems t=
o be little or no activity in that group?&nbsp;<br /><br /><a href=3D"https=
://lists.openembedded.org/g/Openembedded-issues/topic/problems_having_both_=
git_and/98260091?p=3D,,,20,0,0,0::recentpostdate/sticky,,,20,2,0,98260091,p=
revid%3D1681471653367016231,nextid%3D1328543407000000000&amp;previd=3D16814=
71653367016231&amp;nextid=3D1328543407000000000">Openembedded-issues@lists.=
openembedded.org | Problems having both git and npmsw sources in recipe</a>=
<br /><br /><span style=3D"color: #2c363a; font-family: monospace;">Hi</spa=
n><br /><br /><span style=3D"color: #2c363a; font-family: monospace;">I am =
experiencing problems with a recipe where I have both a git and a npmsw sou=
rce in the SRC_URI. It seems that when the fetcher is fetching from the shr=
inkwrap, the SRCREV variable has been deleted but it still ends up fetching=
 from the git source resulting in an error because SRCREV is undefined.</sp=
an><br /><br /><span style=3D"color: #2c363a; font-family: monospace;">The =
problem occurs because the Fetch class defaults to the value of SRC_URI if =
the urls parameter contains an empty list. The following change to the npms=
w.py file seems to solve the problem:</span><br /><br /><span style=3D"colo=
r: #2c363a; font-family: monospace;">diff --git a/bitbake/lib/bb/fetch2/npm=
sw.py b/bitbake/lib/bb/fetch2/npmsw.py</span><br /><span style=3D"color: #2=
c363a; font-family: monospace;">index&nbsp;a8c4d3528f..4d700a537a&nbsp;1006=
44</span><br /><span style=3D"color: #2c363a; font-family: monospace;">---&=
nbsp;a/bitbake/lib/bb/fetch2/npmsw.py</span><br /><span style=3D"color: #2c=
363a; font-family: monospace;">+++&nbsp;b/bitbake/lib/bb/fetch2/npmsw.py</s=
pan><br /><span style=3D"color: #2c363a; font-family: monospace;">@@&nbsp;-=
193,7&nbsp;+193,9&nbsp;@@&nbsp;class&nbsp;NpmShrinkWrap(FetchMethod):</span=
><br /><span style=3D"color: #2c363a; font-family: monospace;">&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;# This fetcher resolves multiple =
URIs from a shrinkwrap file and then</span><br /><span style=3D"color: #2c3=
63a; font-family: monospace;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;# forwards it to a proxy fetcher. The management of the donestamp =
file,</span><br /><span style=3D"color: #2c363a; font-family: monospace;">&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;# the lockfile and the=
 checksums are forwarded to the proxy fetcher.</span><br /><span style=3D"c=
olor: #2c363a; font-family: monospace;">- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;ud.proxy =3D Fetch([dep["url"] for dep in ud.deps if dep["url"]], =
data)</span><br /><span style=3D"color: #2c363a; font-family: monospace;">+=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;shrinkwrap_urls&nbsp;=3D&nb=
sp;[dep["url"]&nbsp;for&nbsp;dep&nbsp;in&nbsp;ud.deps&nbsp;if&nbsp;dep["url=
"]]</span><br /><span style=3D"color: #2c363a; font-family: monospace;">+&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if&nbsp;shrinkwrap_urls:</spa=
n><br /><span style=3D"color: #2c363a; font-family: monospace;">+&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ud.proxy&nbsp=
;=3D&nbsp;Fetch(shrinkwrap_urls,&nbsp;data)</span><br /><span style=3D"colo=
r: #2c363a; font-family: monospace;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;ud.needdonestamp&nbsp;=3D&nbsp;False</span><br /><br /><spa=
n style=3D"color: #2c363a; font-family: monospace;">Are&nbsp;this&nbsp;chan=
ge&nbsp;OK&nbsp;or&nbsp;can&nbsp;it&nbsp;result&nbsp;in&nbsp;other&nbsp;iss=
ues?</span><br /><br /><span style=3D"color: #2c363a; font-family: monospac=
e;">Also more generally why does the Fetch class default to the value of SR=
C_URI variable if the urls parameter contains an empty list? Isn't this a s=
trange implementation? It also seems to result in issues if the shrinkwrap =
file contains no dependencies.</span><br /><br /><span style=3D"color: #2c3=
63a; font-family: monospace;">Please note that I am fairly new to bitbake a=
nd completely new to the source code. :)</span><br /><br /><span style=3D"c=
olor: #2c363a; font-family: monospace;">Kind&nbsp;regards,</span><br /><spa=
n style=3D"color: #2c363a; font-family: monospace;">Svend&nbsp;Meyland&nbsp=
;Nicolaisen</span>

--LkXpKnXccfZIhGxIAAHz--

