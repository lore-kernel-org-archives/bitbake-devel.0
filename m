Subject: Git operations during parse
To: bitbake-devel@lists.openembedded.org
From: david.weidenkopf@arthrex.com
X-Originating-Location: Santa Barbara, California, US (184.189.228.123)
X-Originating-Platform: Windows Chrome 93
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Mon, 13 Sep 2021 11:23:25 -0700
Message-ID: <ZIhY.1631557405234165608.d5Ap@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="pdm4e2Lr4o27x6vdQGA6"

--pdm4e2Lr4o27x6vdQGA6
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

It appears that during bitbake parse phase, git operations are performed. I=
s this true? It seems that network operations are performed before the depe=
ndency tree is computed. As a result, a build may fail in the parse phase d=
ue to a failure to reach a git repo that ultimately is not needed because t=
he package it is in does not end up in the dependency tree. Is that correct=
?

--pdm4e2Lr4o27x6vdQGA6
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

It appears that during bitbake parse phase, git operations are performed. I=
s this true? It seems that network operations are performed before the depe=
ndency tree is computed. As a result, a build may fail in the parse phase d=
ue to a failure to reach a git repo that ultimately is not needed because t=
he package it is in does not end up in the dependency tree. Is that correct=
?

--pdm4e2Lr4o27x6vdQGA6--
