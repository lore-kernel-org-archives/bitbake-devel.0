Return-Path: <christian.lindeberg@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 111BFECE582
	for <webhook@archiver.kernel.org>; Tue, 10 Sep 2024 09:32:44 +0000 (UTC)
Subject: Re: [PATCH v2 2/2] fetch2: Add gomodgit fetcher
To: bitbake-devel@lists.openembedded.org
From: "Christian Lindeberg" <christian.lindeberg@axis.com>
X-Originating-Location: =?UTF-8?B?THVuZCwgU2vDpW5lIENvdW50eSwgU0U=?= (195.60.68.152)
X-Originating-Platform: Linux Chrome 127
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Tue, 10 Sep 2024 02:32:41 -0700
References: <79ff6187-aa9e-4dc7-bd79-4f37e1603bb9@gmail.com>
In-Reply-To: <79ff6187-aa9e-4dc7-bd79-4f37e1603bb9@gmail.com>
Message-ID: <30802.1725960761219204467@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="rO4ECAXhNhMb1R6qzgLS"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 10 Sep 2024 09:32:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16549

--rO4ECAXhNhMb1R6qzgLS
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 7, 2024 at 09:27 AM, Vyacheslav Yurkov wrote:

>=20
> A few questions on the patchset.
>=20
> - What if the module doesn't use any proxy? (E.g. hosted in a private
> repository)
>=20

The gomodgit fetcher is for git repositories that needs to use the direct m=
ode.
(Cf. https://go.dev/ref/mod#private-module-proxy-direct) ( https://go.dev/r=
ef/mod#private-module-proxy-direct=3D )

>=20
> - The current recipetool approach ( https://git.openembedded.org/openembe=
dded-core/tree/scripts/lib/recipetool/create_go.py
> ) uses vendoring approach and all dependencies go into the SRC_URI. Thus
> it's required to populate the required license information for the
> manifest generation. Would that be possible with this fetcher as well?
>=20

Yes, there would be no change when creating or updating the ${BPN}-licenses=
.inc
file compared to the vendoring approach. And then the gomod:// and gomodgit=
://
URLs would go into ${BPN}-modules.inc.

>=20
>=20
> Slava
>=20
>=20

Thanks,
Christian

--rO4ECAXhNhMb1R6qzgLS
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>On Sat, Sep 7, 2024 at 09:27 AM, Vyacheslav Yurkov wrote:</div>
<div>
<blockquote>
<div class=3D"moz-cite-prefix">A few questions on the patchset.<br /><br />=
- What if the module doesn't use any proxy? (E.g. hosted in a private repos=
itory)</div>
</blockquote>
The gomodgit fetcher is for git repositories that needs to use the direct m=
ode.</div>
<div>(Cf. <a href=3D"https://go.dev/ref/mod#private-module-proxy-direct=3D"=
 target=3D"_blank" rel=3D"noopener">https://go.dev/ref/mod#private-module-p=
roxy-direct)</a></div>
<div><br />
<blockquote>
<div class=3D"moz-cite-prefix">- The current recipetool approach ( <a class=
=3D"moz-txt-link-freetext" href=3D"https://git.openembedded.org/openembedde=
d-core/tree/scripts/lib/recipetool/create_go.py">https://git.openembedded.o=
rg/openembedded-core/tree/scripts/lib/recipetool/create_go.py</a> ) uses ve=
ndoring approach and all dependencies go into the SRC_URI. Thus it's requir=
ed to populate the required license information for the manifest generation=
. Would that be possible with this fetcher as well?</div>
</blockquote>
Yes, there would be no change when creating or updating the ${BPN}-licenses=
.inc</div>
<div>file compared to the vendoring approach. And then the gomod:// and gom=
odgit://</div>
<div>URLs would go into ${BPN}-modules.inc.</div>
<div><br />
<blockquote>
<div class=3D"moz-cite-prefix"><br />Slava</div>
<div class=3D"moz-cite-prefix">&nbsp;</div>
</blockquote>
Thanks,</div>
<div>Christian</div>

--rO4ECAXhNhMb1R6qzgLS--

