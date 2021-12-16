Return-Path: <pontus.jaensson@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF2FCC433F5
	for <webhook@archiver.kernel.org>; Thu, 16 Dec 2021 13:36:35 +0000 (UTC)
Subject: Re: [RFC] Implementation of a submodule fetcher
To: bitbake-devel@lists.openembedded.org
From: "Pontus Jaensson" <pontus.jaensson@axis.com>
X-Originating-Location: =?utf-8?b?THVuZCwgU2vDpW5lIENvdW50eSwgU0UgKDE5NS42?=
 =?utf-8?b?MC42OC4xNDgp?=
X-Originating-Platform: Linux Chrome 96
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Thu, 16 Dec 2021 05:36:29 -0800
References: 
 <6d3f11fb30f39fd9d0f933e92c71d94a59592bbf.camel@linuxfoundation.org>
In-Reply-To: 
 <6d3f11fb30f39fd9d0f933e92c71d94a59592bbf.camel@linuxfoundation.org>
Message-ID: <15835.1639661789942932561@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="iT1uLcdAs4jXmoDJdKYx"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 16 Dec 2021 13:36:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13181

--iT1uLcdAs4jXmoDJdKYx
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Richard,

Thanks for your comments. Regarding your question whether or not the design=
 goals are followed I have the following motivation:

a) Yes, the fetcher follows the same structure as the other fetchers.
b) Done.
c) You can=E2=80=99t for now. DL_DIR is not needed to be inside a layer. Fr=
edrik has two ideas about how to solve it but we would very much want to he=
ar your opinion about any of them is a viable solution. The idea is that it=
 is possible to solve the problem by a symlink or by copying the content of=
 the submodule to DL_DIR. Do you think either of these suggestions can solv=
e the problem?
d) I don=E2=80=99t completely understand this one but once the do_fetch() i=
s done, there is no more network access.
e) It should be. As long as the layer is a git repository and still has its=
 git-database it=E2=80=99s reproducible.
f) done.
g) done.
h) Not yet implemented. I can look up how it is done in other git:// recipe=
s in the meta/layer and do my best to implement it here as well.
i) Should already be done since no new tools are used.
j) Not implemented??
k) Not implemented yet.
l) It does not use any tools.

Regarding your other question why we do need two different fetchers to work=
 with git
submodules I use the same answer as I did to Quentin. All though they are b=
oth using submodule I don't think they are related and should have a shared=
 functionality. gitsm:// is allowing a package to have submodules, my versi=
on submodules:// is allowing a layer to have submodules. I am aware that th=
e naming is not perfect for the intended purpose and as Fredrik answered yo=
u before I am happy to receive suggestions for a better naming. I personall=
y can see a reason for using the submodule:// fetcher but I don't understan=
d why the gitsm:// fetcher is not just an option to the git:// fetcher.

Hope this answered your questions, please come back if you have more or if =
there is something that I need to explain further.

Best Regards
/ Pontus

--iT1uLcdAs4jXmoDJdKYx
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>Hi Richard,</div>
<div>&nbsp;</div>
<div>Thanks for your comments. Regarding your question whether or not the d=
esign goals are followed I have the following motivation:</div>
<div>&nbsp;</div>
<div>a) Yes, the fetcher follows the same structure as the other fetchers.<=
/div>
<div>b) Done.</div>
<div>c) You can&rsquo;t for now. DL_DIR is not needed to be inside a layer.=
 Fredrik has two ideas about how to solve it but we would very much want to=
 hear your opinion about any of them is a viable solution. The idea is that=
 it is possible to solve the problem by a symlink or by copying the content=
 of the submodule to DL_DIR. Do you think either of these suggestions can s=
olve the problem?</div>
<div>d) I don&rsquo;t completely understand this one but once the do_fetch(=
) is done, there is no more network access.</div>
<div>e) It should be. As long as the layer is a git repository and still ha=
s its git-database it&rsquo;s reproducible.</div>
<div>f) done.</div>
<div>g) done.</div>
<div>h) Not yet implemented. I can look up how it is done in other git:// r=
ecipes in the meta/layer and do my best to implement it here as well.</div>
<div>i) Should already be done since no new tools are used.</div>
<div>j) Not implemented??</div>
<div>k) Not implemented yet.</div>
<div>l) It does not use any tools.</div>
<div>&nbsp;</div>
<div>Regarding your other question why we do need two different fetchers to=
 work with git</div>
<div>submodules I use the same answer as I did to Quentin. All though they =
are both using submodule I don't think they are related and should have a s=
hared functionality. gitsm:// is allowing a package to have submodules, my =
version submodules:// is allowing a layer to have submodules. I am aware th=
at the naming is not perfect for the intended purpose and as Fredrik answer=
ed you before I am happy to receive suggestions for a better naming. I pers=
onally can see a reason for using the submodule:// fetcher but I don't unde=
rstand why the gitsm:// fetcher is not just an option to the git:// fetcher=
.</div>
<div>&nbsp;</div>
<div>Hope this answered your questions, please come back if you have more o=
r if there is something that I need to explain further.</div>
<div>&nbsp;</div>
<div>Best Regards</div>
<div>/ Pontus</div>

--iT1uLcdAs4jXmoDJdKYx--

