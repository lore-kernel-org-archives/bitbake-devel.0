Return-Path: <pontus.jaensson@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79467C433F5
	for <webhook@archiver.kernel.org>; Thu, 16 Dec 2021 13:37:33 +0000 (UTC)
Subject: Re: [RFC] Implementation of a submodule fetcher
To: bitbake-devel@lists.openembedded.org
From: "Pontus Jaensson" <pontus.jaensson@axis.com>
X-Originating-Location: =?utf-8?b?THVuZCwgU2vDpW5lIENvdW50eSwgU0UgKDE5NS42?=
 =?utf-8?b?MC42OC4xNDgp?=
X-Originating-Platform: Linux Chrome 96
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Thu, 16 Dec 2021 05:37:33 -0800
References: <20211215144241.yvzsdgdwbnrr3yax@fedora>
In-Reply-To: <20211215144241.yvzsdgdwbnrr3yax@fedora>
Message-ID: <8627.1639661853122616902@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="ddlv58dU1nLO7L5rjL9o"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 16 Dec 2021 13:37:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13182

--ddlv58dU1nLO7L5rjL9o
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Quentin,

Thank you for your feedback and thanks for noticing that I missed the Signe=
d-off. The answer to your question about why I just not simply extend the a=
lready existing gitsm fetcher instead of writing my own is that all though =
they are both using submodule I don't think they are related and should hav=
e a shared functionality. gitsm:// is allowing a package to have submodules=
, my version submodules:// is allowing a layer to have submodules. I am awa=
re that the naming is not perfect for the intended purpose, it's a quite bi=
g difference. I personally can see a reason for using the submodule:// fetc=
her but I don't understand why the gitsm:// fetcher is not just an option t=
o the git:// fetcher.

If I have understood the current implementation of gitsm it fetches informa=
tion about the submodules from the main git repository. My implementation u=
ses the local .gitmodules file for initializing and updating the submodules=
. For this reason we won't have to rely on the SRCREV-tag in recipes and it=
 can be removed completely. Also as previously mentioned by Fredrik, the pu=
rpose of this patch is to introduce reproducible builds where the informati=
on is stored in git and not in the bb-files. This will significantly improv=
e the traceability since when you are developing a package that should be i=
ntegrated to the bitbake system you will no longer need to commit both to t=
he package- and the layer repository. To solve this problem, we have develo=
ped a service that once a package is updated, the bb-file in the layer repo=
sitory is automatically rewritten so match the new version of the package. =
But by using the layer repository as a super project it is possible to use =
gerrits superproject subscription that makes the layer repository to be upd=
ated each time the submodule (the package) is updated. This gives us reprod=
ucible builds, only one commit to introduce a change and no in-house develo=
ped services.

Hope this clarified my intentions
Best Regards
/ Pontus

--ddlv58dU1nLO7L5rjL9o
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>Hi Quentin,</div>
<div>&nbsp;</div>
<div>Thank you for your feedback and thanks for noticing that I missed the =
Signed-off. The answer to your question about why I just not simply extend =
the already existing gitsm fetcher instead of writing my own is that all th=
ough they are both using submodule I don't think they are related and shoul=
d have a shared functionality. gitsm:// is allowing a package to have submo=
dules, my version submodules:// is allowing a layer to have submodules. I a=
m aware that the naming is not perfect for the intended purpose, it's a qui=
te big difference. I personally can see a reason for using the submodule://=
 fetcher but I don't understand why the gitsm:// fetcher is not just an opt=
ion to the git:// fetcher.</div>
<div>&nbsp;</div>
<div>If I have understood the current implementation of gitsm it fetches in=
formation about the submodules from the main git repository. My implementat=
ion uses the local .gitmodules file for initializing and updating the submo=
dules. For this reason we won't have to rely on the SRCREV-tag in recipes a=
nd it can be removed completely. Also as previously mentioned by Fredrik, t=
he purpose of this patch is to introduce reproducible builds where the info=
rmation is stored in git and not in the bb-files. This will significantly i=
mprove the traceability since when you are developing a package that should=
 be integrated to the bitbake system you will no longer need to commit both=
 to the package- and the layer repository. To solve this problem, we have d=
eveloped a service that once a package is updated, the bb-file in the layer=
 repository is automatically rewritten so match the new version of the pack=
age. But by using the layer repository as a super project it is possible to=
 use gerrits superproject subscription that makes the layer repository to b=
e updated each time the submodule (the package) is updated. This gives us r=
eproducible builds, only one commit to introduce a change and no in-house d=
eveloped services.</div>
<div>&nbsp;</div>
<div>Hope this clarified my intentions</div>
<div>Best Regards</div>
<div>/ Pontus</div>

--ddlv58dU1nLO7L5rjL9o--

