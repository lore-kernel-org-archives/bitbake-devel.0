Return-Path: <marius.kriegerowski@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10785C433EF
	for <webhook@archiver.kernel.org>; Mon,  8 Nov 2021 22:44:29 +0000 (UTC)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com
 [209.85.208.45])
 by mx.groups.io with SMTP id smtpd.web11.4086.1636411467926947248
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 08 Nov 2021 14:44:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=ga83k79f;
 spf=pass (domain: gmail.com, ip: 209.85.208.45,
 mailfrom: marius.kriegerowski@gmail.com)
Received: by mail-ed1-f45.google.com with SMTP id f4so68459244edx.12
        for <bitbake-devel@lists.openembedded.org>;
 Mon, 08 Nov 2021 14:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D30LnvdgdVQVFxIA+vilDz3k7kIbt4vzSyzkPAm2dCE=;
        b=ga83k79fvCTUizdEN0DnTqD89BsZchEfk+KpO8jeNRF40YlCORSNtULl9+hwVyHGzt
         OetyrsDQf4yfAXnj/Cx6yfIYpuuixN90o6Le40r0LEiI38OcaCLA28Kxh2wN5LqEsWGP
         NeYr46vqthzuxQEPmBZ/I+e9oC97GDt0E/4GLb7QIzPYvY40F1G3d64LVWsboRdDEeOz
         uKG7OFe3W0HY8YljTp+kMG/Y5+86p96/Spj1A2iRh9yhhpRCjkYOA5RoCZ/uTqunyD9j
         WYdLFZfHEauCMCvyY2ABJ9Kh4CfmSSrwE3nw48BuH1i2olBhe2CZjmR/3jto7Upw37cp
         TmoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D30LnvdgdVQVFxIA+vilDz3k7kIbt4vzSyzkPAm2dCE=;
        b=Sw7HGkJXY/vYrP/VbXy97vJIp/vZJCUlbAoIkuD2sXl0EXr7GYc1AcrU/dplneW7ie
         +cE2UtfAFvSSmZzK5gbmWFAURpTjDgYM5ZaIMVrNeNFhLupIFbzB/orCtlBScyTWg1a0
         JxIaaYwXVFSYpbFmMh1n6Nsl7z20cR7Gr+NILQG6TlkJgccuRiIVAImeZQCEbcvTOpHS
         wbTzcmUKfFRobnflySVFhUXoT6ZJsSDM3nVAoCSA1NRDPVdOtDD6sJZlM0iP1AJpoHmt
         fSlPCYjDb0D1WmiFSah/41cWQWgnhzMQQi5QJVZzx6wyoSwC1jo2sNpCTQw8YxetgbkX
         lPVQ==
X-Gm-Message-State: AOAM5327aO2kpVglckK/+PyHDg+cURgq5WHZ4sZTWkiKP4IPRZLdNV6P
	iRxYCTWHPhCW5XsdIkpGTE9KoCuEEUoaH8b0RWk=
X-Google-Smtp-Source: 
 ABdhPJzeLqFK/nPXYgdh9dJg7JJRpix3Blb8VqEcPEWzmXm7W/Wdf3j1L6DjTwPSj8rwKUuqeA/3J+hmRspGcF7s8Z4=
X-Received: by 2002:a17:906:ce2a:: with SMTP id
 sd10mr3506408ejb.154.1636411465992;
 Mon, 08 Nov 2021 14:44:25 -0800 (PST)
MIME-Version: 1.0
References: 
 <CAMaS9hNh8iztUquiPddua-6Lu0nLzU832YwHG+rw284zqUzEZQ@mail.gmail.com>
 <CAMaS9hPB=273mfQ4eZp32tsy3DrsqX3x0sKmxSaZ2CbsvaYYxA@mail.gmail.com>
 <d5683f0ad0dd0185309d5d8feea6c7e7141fa343.camel@linuxfoundation.org>
In-Reply-To: 
 <d5683f0ad0dd0185309d5d8feea6c7e7141fa343.camel@linuxfoundation.org>
From: Marius Kriegerowski <marius.kriegerowski@gmail.com>
Date: Mon, 8 Nov 2021 23:44:15 +0100
Message-ID: 
 <CAMaS9hNpp9QsUqkpXvNj_F5R4aQoe+qHg+_mtxnZRL0PoAYaGw@mail.gmail.com>
Subject: Re: [bitbake-devel] bitbake style/workflow
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000230d6f05d04ebc79"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 08 Nov 2021 22:44:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12950

--000000000000230d6f05d04ebc79
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 8. Nov 2021, at 22:47, Richard Purdie <richard.purdie@linuxfoundation.or=
g>
wrote:

On Mon, 2021-11-08 at 18:37 +0100, Marius Kriegerowski wrote:

Is there a plan to switch to some more modern ways to collaborate on
bitbake,
you know, like, gitlab/github/gitea with issues, PRs and so forth? I mean=
=E2=80=A6
it=E2=80=99s
late 2021 and sending MRs/Issues via email feels reaaaally outdated, slow,
intransparent, ineffective (how to you do reviews, code comparisons during
reviews, insert suggestions, etc.) and indirect (where is the CI pipeline
that I
trigger when pushing something somewhere?).


There are pros and cons to switching to something else. Keep in mind that
whilst
the github workflow works well for a single maintainer of a project, it
does not
work well for diverse review.

I strongly disagree with that. Reviews can equally well be done in a MR
thread. That=E2=80=99s what they are there for. You can discuss things ther=
e with
as many people as you want and can e.g. define a minimum number of
approvals before a MR can be merged. It also naturally groups discussions.
You can address experts for specific domains which means less noise for the
experts. I really don=E2=80=99t see why mailing list reviews should work an=
y better
here. If google can coordinate 2.1k repos with 1.1k contributors over
GitHub, why should that not work for openembedded??

For wider Openembedded/ Yocto Project, we really
benefit from mailing list code review since we have a wide set of reviewers
and
no single person makes a direct decision on whether code is right or not.

See e.g. option to specify the minimum number of approvals.


The Bitbake case is a little bit different but in general we'd follow what
OE/Yocto Project are doing.

We have discussed changing and it is listed as one topic on:
https://wiki.yoctoproject.org/wiki/Future_Directions
(Code Submission process)

I'd note that it is a huge change to our current developers and most of us
are
very used to the mailing lists so if we did change, it would allow
potential new
collaborators at the risk of losing people with key knowledge/experience.

=E2=80=A6 which reads to me like: =E2=80=9CIt has always been that way so w=
e will not
change that" doesn=E2=80=99t it? Always a very poor argument.

You
can do collaboration, code review and development with our current
processes, it
just isn't the github workflow.

Correct. Neither is it gitlab, gitea, gogs, bitbucket, =E2=80=A6, you name =
the
platform that most developers are used to work with these days. These are
tools to enhance collaboration.


We do have CI which is shared with Yocto Project and
OpenEmbedded. You can see it here:

https://autobuilder.yoctoproject.org/typhoon/#/console

and it has it's own manual which was recently added to our documentations
set:

http://docs.yoctoproject.org/test-manual/index.html

=E2=80=A6 stressing my point: Why does the location of the CI need document=
ation?
All of the aforementioned platforms smoothly integrate with multiple CI
solutions, drastically reducing the time required for reviews if the
pipeline provides automated feedback to the contributor. It would probably
cost me about one afternoon to setup a decent CI pipeline at least for all
python codes pushing the need to review from manual labor to automated
tools. If open embedded migrates to a proper git platform I happily
volunteer on that end!!


There is work still needed on that but it is a start. One challenge of
bitbake/OE is that the builds take an age and the test matrix is huge so
the CI
process isn't quite as simple as some other simpler projects.

At least for python I bet that most bugs can be caught simply by firing up
`black`, `flake8`, `pylint` (and a hand full of other tools) just to check
the modified files. Regarding meta-layers and recipes out there we are
currently pushing forward with a linter for bitbake recipes (thanks
@priv-kweihmann for this awesome and overdue tool!!!).


As a shortcut through things, the "bitbake-selftest" command within bitbake
may
be one thing you're looking for which does simple tests on bitbake. It isn'=
t
complete coverage and we welcome more being added, it is a start and some
areas
of the code are covered better than others.

I=E2=80=99d love to overhaul the tests e.g. porting them to `pytest` which =
offers a
much simpler yet much more powerful API/plugin-ecosystem. But won=E2=80=99t=
 do via
email :)


Issues are filed in the project bugzilla and are actively worked on:

https://bugzilla.yoctoproject.org/

Didn=E2=80=99t know that. But why keeping issues separate from MRs? Automat=
ic issue
closing through referencing in MRs is a pretty nice feature=E2=80=A6 Also t=
he 90s
style is not appealing enough for me to create an account there. (I=E2=80=
=99m
sensing again that I=E2=80=99m not the only one).


I threw a search engine at =E2=80=98yocto bitbake CI=E2=80=99 (and similar)=
 but didn=E2=80=99t find
it. I=E2=80=99m 110 % sure that there is a CI pipeline but it would make
contributions, reviews, etc. so much more efficient if I as the
(hypothetical)
contributor would see the outcome of just a linter*. Maybe it=E2=80=99s som=
ewhere
documented where the CI is hosted but then: No other project I contribute t=
o
needs documentation about these things. They are just there and obvious.

Don=E2=80=99t get me wrong: bitbake is awesome. I=E2=80=99d just love to co=
ntribute but the
burden for collaboration here is not really up to date. So, is there a
strategy to improve the on-boarding and workflow?


We've ideas but like the kernel, we do get things from the patch based
workflow
which we'd lose in a single person focused maintainer system like github so
I
doubt we'll change to that.

None of the platforms mentioned is a single person focused maintainer
system.


* side-note on bitbake style/linting: It=E2=80=99s violating PEP8 in a coup=
le of
ways
and TBH PEP8 is the bare minimum I would accept these days for collaboratio=
n
on projects the dimension of bitbake. So an additional question: Would you
be
up for a PEP8 compatibility overhaul of the source code? I=E2=80=99d volunt=
eer if I
don=E2=80=99t have to send a patch via email ;)


We're interested in patches to improve the coding style as long as they
don't
break things like readability or performance. Which rules in PEP8 in
particular
are you referring to?


To name a few violations:

 * hanging indents
 * inconsistent indentation
 * 2 separating lines missing in between classes/top level methods
 * unused imported modules
 * missing white-spaces after comma
 * unreachable codes

These are just a couple of examples that struck my PEP8 used eye from
looking at two, three modules.

It=E2=80=99s just like with any code smell: they don=E2=80=99t necessarily =
break things.
But they make maintenance, code-reviews and quality control harder than
necessary. Code that does not at least follow PEP8 (and I actually strongly
recommend to go the extra mile with `black`) just looks odd and is
unnecessary hard to read. I=E2=80=99m surprised I have to argue for standar=
ds.

Besides that, some minor cleanup just to warm up:
https://github.com/openembedded/bitbake/pull/33,
https://github.com/openembedded/bitbake/pull/32/files (it was after these
two that I found the comment in one of those old commits which made me open
https://github.com/openembedded/bitbake/pull/34). At least there should be
an automated reply to each MR that is posted if someone makes the effort to
fix code and open a MRs that this is actually in vein - That=E2=80=99s the =
mood
that took me here :)


Help appreciated but email patches is how we accept them at the moment.


Not from me then :(


Cheers,

Richard

Bottom line: I know I sounded harsh. Sorry about that! I love bitbake and
use it A LOT! I=E2=80=99d just love even more to get my hands dirty improvi=
ng a
bunch of things. But only if the tools in place promise an efficient
collaboration reducing overhead as much as possible.

And I=E2=80=99m 100 % there are more developers out there that did not even=
 drop a
message here but instead decided to not even start contribution at all. So,
my suggestion is to think about what are the most significant burdens that
hinder from contributing. My best bet is the email patches :)

Best regards

Marius



Am Mo., 8. Nov. 2021 um 22:47 Uhr schrieb Richard Purdie <
richard.purdie@linuxfoundation.org>:

> On Mon, 2021-11-08 at 18:37 +0100, Marius Kriegerowski wrote:
> > Is there a plan to switch to some more modern ways to collaborate on
> bitbake,
> > you know, like, gitlab/github/gitea with issues, PRs and so forth? I
> mean=E2=80=A6 it=E2=80=99s
> > late 2021 and sending MRs/Issues via email feels reaaaally outdated,
> slow,
> > intransparent, ineffective (how to you do reviews, code comparisons
> during
> > reviews, insert suggestions, etc.) and indirect (where is the CI
> pipeline that I
> > trigger when pushing something somewhere?).
>
> There are pros and cons to switching to something else. Keep in mind that
> whilst
> the github workflow works well for a single maintainer of a project, it
> does not
> work well for diverse review. For wider Openembedded/ Yocto Project, we
> really
> benefit from mailing list code review since we have a wide set of
> reviewers and
> no single person makes a direct decision on whether code is right or not.
>
> The Bitbake case is a little bit different but in general we'd follow wha=
t
> OE/Yocto Project are doing.
>
> We have discussed changing and it is listed as one topic on:
> https://wiki.yoctoproject.org/wiki/Future_Directions
> (Code Submission process)
>
> I'd note that it is a huge change to our current developers and most of u=
s
> are
> very used to the mailing lists so if we did change, it would allow
> potential new
> collaborators at the risk of losing people with key knowledge/experience.
> You
> can do collaboration, code review and development with our current
> processes, it
> just isn't the github workflow.
>
> We do have CI which is shared with Yocto Project and
> OpenEmbedded. You can see it here:
>
> https://autobuilder.yoctoproject.org/typhoon/#/console
>
> and it has it's own manual which was recently added to our documentations
> set:
>
> http://docs.yoctoproject.org/test-manual/index.html
>
> There is work still needed on that but it is a start. One challenge of
> bitbake/OE is that the builds take an age and the test matrix is huge so
> the CI
> process isn't quite as simple as some other simpler projects.
>
> As a shortcut through things, the "bitbake-selftest" command within
> bitbake may
> be one thing you're looking for which does simple tests on bitbake. It
> isn't
> complete coverage and we welcome more being added, it is a start and some
> areas
> of the code are covered better than others.
>
> Issues are filed in the project bugzilla and are actively worked on:
>
> https://bugzilla.yoctoproject.org/
>
> > I threw a search engine at =E2=80=98yocto bitbake CI=E2=80=99 (and simi=
lar) but didn=E2=80=99t
> find
> > it. I=E2=80=99m 110 % sure that there is a CI pipeline but it would mak=
e
> > contributions, reviews, etc. so much more efficient if I as the
> (hypothetical)
> > contributor would see the outcome of just a linter*. Maybe it=E2=80=99s=
 somewhere
> > documented where the CI is hosted but then: No other project I
> contribute to
> > needs documentation about these things. They are just there and obvious=
.
> >
> > Don=E2=80=99t get me wrong: bitbake is awesome. I=E2=80=99d just love t=
o contribute but
> the
> > burden for collaboration here is not really up to date. So, is there a
> > strategy to improve the on-boarding and workflow?
>
> We've ideas but like the kernel, we do get things from the patch based
> workflow
> which we'd lose in a single person focused maintainer system like github
> so I
> doubt we'll change to that.
>
> > * side-note on bitbake style/linting: It=E2=80=99s violating PEP8 in a =
couple of
> ways
> > and TBH PEP8 is the bare minimum I would accept these days for
> collaboration
> > on projects the dimension of bitbake. So an additional question: Would
> you be
> > up for a PEP8 compatibility overhaul of the source code? I=E2=80=99d vo=
lunteer
> if I
> > don=E2=80=99t have to send a patch via email ;)
>
> We're interested in patches to improve the coding style as long as they
> don't
> break things like readability or performance. Which rules in PEP8 in
> particular
> are you referring to?
>
> Help appreciated but email patches is how we accept them at the moment.
>
> Cheers,
>
> Richard
>
>

--000000000000230d6f05d04ebc79
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div style=3D"font-family:Helvetica;font-=
size:12px;font-style:normal;font-variant-caps:normal;font-weight:normal;let=
ter-spacing:normal;text-align:start;text-indent:0px;text-transform:none;whi=
te-space:normal;word-spacing:0px;text-decoration:none"><span style=3D"color=
:rgb(0,0,0)"><br class=3D"gmail-Apple-interchange-newline"><br class=3D"gma=
il-"></span><blockquote type=3D"cite" class=3D"gmail-"><div class=3D"gmail-=
"><span style=3D"color:rgb(0,0,0)">On 8. Nov 2021, at 22:47, Richard Purdie=
 &lt;<a href=3D"mailto:richard.purdie@linuxfoundation.org" class=3D"gmail-"=
>richard.purdie@linuxfoundation.org</a>&gt; wrote:</span></div><span style=
=3D"color:rgb(0,0,0)"><br class=3D"gmail-Apple-interchange-newline"></span>=
<div class=3D"gmail-"><div class=3D"gmail-"><span style=3D"color:rgb(0,0,0)=
">On Mon, 2021-11-08 at 18:37 +0100, Marius Kriegerowski wrote:<br class=3D=
"gmail-"></span><blockquote type=3D"cite" class=3D"gmail-"><span style=3D"c=
olor:rgb(0,0,0)">Is there a plan to switch to some more modern ways to coll=
aborate on bitbake,<br class=3D"gmail-">you know, like, gitlab/github/gitea=
 with issues, PRs and so forth? I mean=E2=80=A6 it=E2=80=99s<br class=3D"gm=
ail-">late 2021 and sending MRs/Issues via email feels reaaaally outdated, =
slow,<br class=3D"gmail-">intransparent, ineffective (how to you do reviews=
, code comparisons during<br class=3D"gmail-">reviews, insert suggestions, =
etc.) and indirect (where is the CI pipeline that I<br class=3D"gmail-">tri=
gger when pushing something somewhere?).<br class=3D"gmail-"></span></block=
quote><span style=3D"color:rgb(0,0,0)"><br class=3D"gmail-">There are pros =
and cons to switching to something else. Keep in mind that whilst<br class=
=3D"gmail-">the github workflow works well for a single maintainer of a pro=
ject, it does not<br class=3D"gmail-">work well for diverse review.</span><=
/div></div></blockquote><span style=3D"color:rgb(0,0,0)">I
 strongly disagree with that. Reviews can equally well be done in a MR=20
thread. That=E2=80=99s what they are there for. You can discuss things ther=
e=20
with as many people as you want and can e.g. define a minimum number of=20
approvals before a MR can be merged. It also naturally groups=20
discussions. You can address experts for specific domains which means=20
less noise for the experts. I really don=E2=80=99t see why mailing list rev=
iews=20
should work any better here. If google can coordinate 2.1k repos with=20
1.1k contributors over GitHub, why should that not work for=20
openembedded??<br class=3D"gmail-"></span><blockquote type=3D"cite" class=
=3D"gmail-"><div class=3D"gmail-"><div class=3D"gmail-"><span style=3D"colo=
r:rgb(0,0,0)">For wider Openembedded/ Yocto Project, we really<br class=3D"=
gmail-">benefit from mailing list code review since we have a wide set of r=
eviewers and<br class=3D"gmail-">no single person makes a direct decision o=
n whether code is right or not.<br class=3D"gmail-"></span></div></div></bl=
ockquote><span style=3D"color:rgb(0,0,0)">See e.g. option to specify the mi=
nimum number of approvals.<br class=3D"gmail-"></span><blockquote type=3D"c=
ite" class=3D"gmail-"><div class=3D"gmail-"><div class=3D"gmail-"><span sty=
le=3D"color:rgb(0,0,0)"><br class=3D"gmail-">The Bitbake case is a little b=
it different but in general we&#39;d follow what<br class=3D"gmail-">OE/Yoc=
to Project are doing.<br class=3D"gmail-"><br class=3D"gmail-">We have disc=
ussed changing and it is listed as one topic on:<br class=3D"gmail-"><a hre=
f=3D"https://wiki.yoctoproject.org/wiki/Future_Directions" class=3D"gmail-"=
>https://wiki.yoctoproject.org/wiki/Future_Directions</a><br class=3D"gmail=
-">(Code Submission process)<br class=3D"gmail-"><br class=3D"gmail-">I&#39=
;d note that it is a huge change to our current developers and most of us a=
re<br class=3D"gmail-">very used to the mailing lists so if we did change, =
it would allow potential new<br class=3D"gmail-">collaborators at the risk =
of losing people with key knowledge/experience.</span></div></div></blockqu=
ote><span style=3D"color:rgb(0,0,0)">=E2=80=A6 which reads to me like: =E2=
=80=9CIt has always been that way so we will not change that&quot; doesn=E2=
=80=99t it? Always a very poor argument.<br class=3D"gmail-"></span><blockq=
uote type=3D"cite" class=3D"gmail-"><div class=3D"gmail-"><div class=3D"gma=
il-"><span style=3D"color:rgb(0,0,0)">You<br class=3D"gmail-">can do collab=
oration, code review and development with our current processes, it<br clas=
s=3D"gmail-">just isn&#39;t the github workflow.<br class=3D"gmail-"></span=
></div></div></blockquote><span style=3D"color:rgb(0,0,0)">Correct.
 Neither is it gitlab, gitea, gogs, bitbucket, =E2=80=A6, you name the plat=
form=20
that most developers are used to work with these days. These are tools=20
to enhance collaboration.<br class=3D"gmail-"></span><blockquote type=3D"ci=
te" class=3D"gmail-"><div class=3D"gmail-"><div class=3D"gmail-"><span styl=
e=3D"color:rgb(0,0,0)"><br class=3D"gmail-">We do have CI which is shared w=
ith Yocto Project and=C2=A0<br class=3D"gmail-">OpenEmbedded. You can see i=
t here:<br class=3D"gmail-"><br class=3D"gmail-"><a href=3D"https://autobui=
lder.yoctoproject.org/typhoon/#/console" class=3D"gmail-">https://autobuild=
er.yoctoproject.org/typhoon/#/console</a><br class=3D"gmail-"><br class=3D"=
gmail-">and it has it&#39;s own manual which was recently added to our docu=
mentations set:<br class=3D"gmail-"><br class=3D"gmail-"><a href=3D"http://=
docs.yoctoproject.org/test-manual/index.html">http://docs.yoctoproject.org/=
test-manual/index.html</a><br class=3D"gmail-"></span></div></div></blockqu=
ote><span style=3D"color:rgb(0,0,0)">=E2=80=A6
 stressing my point: Why does the location of the CI need documentation?
 All of the aforementioned platforms smoothly integrate with multiple CI
 solutions, drastically reducing the time required for reviews if the=20
pipeline provides automated feedback to the contributor. It would=20
probably cost me about one afternoon to setup a decent CI pipeline at=20
least for all python codes pushing the need to review from manual labor=20
to automated tools. If open embedded migrates to a proper git platform I
 happily volunteer on that end!!<br class=3D"gmail-"></span><blockquote typ=
e=3D"cite" class=3D"gmail-"><div class=3D"gmail-"><div class=3D"gmail-"><sp=
an style=3D"color:rgb(0,0,0)"><br class=3D"gmail-">There is work still need=
ed on that but it is a start.=C2=A0One challenge of<br class=3D"gmail-">bit=
bake/OE is that the builds take an age and the test matrix is huge so the C=
I<br class=3D"gmail-">process isn&#39;t quite as simple as some other simpl=
er projects.<br class=3D"gmail-"></span></div></div></blockquote><span styl=
e=3D"color:rgb(0,0,0)">At
 least for python I bet that most bugs can be caught simply by firing up
 `black`, `flake8`, `pylint` (and a hand full of other tools) just to=20
check the modified files. Regarding meta-layers and recipes out there we
 are currently pushing forward with a linter for bitbake recipes (thanks
 @priv-kweihmann for this awesome and overdue tool!!!).<br class=3D"gmail-"=
></span><blockquote type=3D"cite" class=3D"gmail-"><div class=3D"gmail-"><d=
iv class=3D"gmail-"><span style=3D"color:rgb(0,0,0)"><br class=3D"gmail-">A=
s a shortcut through things, the &quot;bitbake-selftest&quot; command withi=
n bitbake may<br class=3D"gmail-">be one thing you&#39;re looking for which=
 does simple tests on bitbake. It isn&#39;t<br class=3D"gmail-">complete co=
verage and we welcome more being added, it is a start and some areas<br cla=
ss=3D"gmail-">of the code are covered better than others.<br class=3D"gmail=
-"></span></div></div></blockquote><span style=3D"color:rgb(0,0,0)">I=E2=80=
=99d
 love to overhaul the tests e.g. porting them to `pytest` which offers a
 much simpler yet much more powerful API/plugin-ecosystem. But won=E2=80=99=
t do=20
via email :)<br class=3D"gmail-"></span><blockquote type=3D"cite" class=3D"=
gmail-"><div class=3D"gmail-"><div class=3D"gmail-"><span style=3D"color:rg=
b(0,0,0)"><br class=3D"gmail-">Issues are filed in the project bugzilla and=
 are actively worked on:<br class=3D"gmail-"><br class=3D"gmail-"><a href=
=3D"https://bugzilla.yoctoproject.org/" class=3D"gmail-">https://bugzilla.y=
octoproject.org/</a><br class=3D"gmail-"></span></div></div></blockquote><s=
pan style=3D"color:rgb(0,0,0)">Didn=E2=80=99t
 know that. But why keeping issues separate from MRs? Automatic issue=20
closing through referencing in MRs is a pretty nice feature=E2=80=A6 Also t=
he=20
90s style is not appealing enough for me to create an account there.=20
(I=E2=80=99m sensing again that I=E2=80=99m not the only one).<br class=3D"=
gmail-"></span><blockquote type=3D"cite" class=3D"gmail-"><div class=3D"gma=
il-"><div class=3D"gmail-"><span style=3D"color:rgb(0,0,0)"><br class=3D"gm=
ail-"></span><blockquote type=3D"cite" class=3D"gmail-"><span style=3D"colo=
r:rgb(0,0,0)">I threw a search engine at =E2=80=98yocto bitbake CI=E2=80=99=
 (and similar) but didn=E2=80=99t find<br class=3D"gmail-">it. I=E2=80=99m =
110 % sure that there is a CI pipeline but it would make<br class=3D"gmail-=
">contributions, reviews, etc. so much more efficient if I as the (hypothet=
ical)<br class=3D"gmail-">contributor would see the outcome of just a linte=
r*. Maybe it=E2=80=99s somewhere<br class=3D"gmail-">documented where the C=
I is hosted but then: No other project I contribute to<br class=3D"gmail-">=
needs documentation about these things. They are just there and obvious.<br=
 class=3D"gmail-"><br class=3D"gmail-">Don=E2=80=99t get me wrong: bitbake =
is awesome. I=E2=80=99d just love to contribute but the<br class=3D"gmail-"=
>burden for collaboration here is not really up to date. So, is there a<br =
class=3D"gmail-">strategy to improve the on-boarding and workflow?<br class=
=3D"gmail-"></span></blockquote><span style=3D"color:rgb(0,0,0)"><br class=
=3D"gmail-">We&#39;ve ideas but like the kernel, we do get things from the =
patch based workflow<br class=3D"gmail-">which we&#39;d lose in a single pe=
rson focused maintainer system like github so I<br class=3D"gmail-">doubt w=
e&#39;ll change to that.<br class=3D"gmail-"></span></div></div></blockquot=
e><span style=3D"color:rgb(0,0,0)">None of the platforms mentioned is a sin=
gle person focused maintainer system.<br class=3D"gmail-"></span><blockquot=
e type=3D"cite" class=3D"gmail-"><div class=3D"gmail-"><div class=3D"gmail-=
"><span style=3D"color:rgb(0,0,0)"><br class=3D"gmail-"></span><blockquote =
type=3D"cite" class=3D"gmail-"><span style=3D"color:rgb(0,0,0)">* side-note=
 on bitbake style/linting: It=E2=80=99s violating PEP8 in a couple of ways<=
br class=3D"gmail-">and TBH PEP8 is the bare minimum I would accept these d=
ays for collaboration<br class=3D"gmail-">on projects the dimension of bitb=
ake. So an additional question: Would you be<br class=3D"gmail-">up for a P=
EP8 compatibility overhaul of the source code? I=E2=80=99d volunteer if I<b=
r class=3D"gmail-">don=E2=80=99t have to send a patch via email ;)<br class=
=3D"gmail-"></span></blockquote><span style=3D"color:rgb(0,0,0)"><br class=
=3D"gmail-">We&#39;re interested in patches to improve the coding style as =
long as they don&#39;t<br class=3D"gmail-">break things like readability or=
 performance.=C2=A0Which rules in PEP8 in particular<br class=3D"gmail-">ar=
e you referring to?<br class=3D"gmail-"></span></div></div></blockquote><sp=
an style=3D"color:rgb(0,0,0)"><br class=3D"gmail-">To name a few violations=
:</span></div><div style=3D"font-family:Helvetica;font-size:12px;font-style=
:normal;font-variant-caps:normal;font-weight:normal;letter-spacing:normal;t=
ext-align:start;text-indent:0px;text-transform:none;white-space:normal;word=
-spacing:0px;text-decoration:none"><span style=3D"color:rgb(0,0,0)"><br cla=
ss=3D"gmail-"></span></div><div style=3D"font-family:Helvetica;font-size:12=
px;font-style:normal;font-variant-caps:normal;font-weight:normal;letter-spa=
cing:normal;text-align:start;text-indent:0px;text-transform:none;white-spac=
e:normal;word-spacing:0px;text-decoration:none"><span style=3D"color:rgb(0,=
0,0)">=C2=A0* hanging indents</span></div><div style=3D"font-family:Helveti=
ca;font-size:12px;font-style:normal;font-variant-caps:normal;font-weight:no=
rmal;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:=
none;white-space:normal;word-spacing:0px;text-decoration:none"><span style=
=3D"color:rgb(0,0,0)">=C2=A0* inconsistent indentation</span></div><div sty=
le=3D"font-family:Helvetica;font-size:12px;font-style:normal;font-variant-c=
aps:normal;font-weight:normal;letter-spacing:normal;text-align:start;text-i=
ndent:0px;text-transform:none;white-space:normal;word-spacing:0px;text-deco=
ration:none"><span style=3D"color:rgb(0,0,0)">=C2=A0* 2 separating lines mi=
ssing in between classes/top level methods</span></div><div style=3D"font-f=
amily:Helvetica;font-size:12px;font-style:normal;font-variant-caps:normal;f=
ont-weight:normal;letter-spacing:normal;text-align:start;text-indent:0px;te=
xt-transform:none;white-space:normal;word-spacing:0px;text-decoration:none"=
><span style=3D"color:rgb(0,0,0)">=C2=A0* unused imported modules</span></d=
iv><div style=3D"font-family:Helvetica;font-size:12px;font-style:normal;fon=
t-variant-caps:normal;font-weight:normal;letter-spacing:normal;text-align:s=
tart;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0p=
x;text-decoration:none"><span style=3D"color:rgb(0,0,0)">=C2=A0* missing wh=
ite-spaces after comma</span></div><div style=3D"font-family:Helvetica;font=
-size:12px;font-style:normal;font-variant-caps:normal;font-weight:normal;le=
tter-spacing:normal;text-align:start;text-indent:0px;text-transform:none;wh=
ite-space:normal;word-spacing:0px;text-decoration:none"><span style=3D"colo=
r:rgb(0,0,0)">=C2=A0* unreachable codes</span></div><div style=3D"font-fami=
ly:Helvetica;font-size:12px;font-style:normal;font-variant-caps:normal;font=
-weight:normal;letter-spacing:normal;text-align:start;text-indent:0px;text-=
transform:none;white-space:normal;word-spacing:0px;text-decoration:none"><s=
pan style=3D"color:rgb(0,0,0)"><br class=3D"gmail-"></span></div><div style=
=3D"font-family:Helvetica;font-size:12px;font-style:normal;font-variant-cap=
s:normal;font-weight:normal;letter-spacing:normal;text-align:start;text-ind=
ent:0px;text-transform:none;white-space:normal;word-spacing:0px;text-decora=
tion:none"><span style=3D"color:rgb(0,0,0)">These are just a couple of exam=
ples that struck my PEP8 used eye from looking at two, three modules.</span=
></div><div style=3D"font-family:Helvetica;font-size:12px;font-style:normal=
;font-variant-caps:normal;font-weight:normal;letter-spacing:normal;text-ali=
gn:start;text-indent:0px;text-transform:none;white-space:normal;word-spacin=
g:0px;text-decoration:none"><span style=3D"color:rgb(0,0,0)"><br class=3D"g=
mail-"></span></div><div style=3D"font-family:Helvetica;font-size:12px;font=
-style:normal;font-variant-caps:normal;font-weight:normal;letter-spacing:no=
rmal;text-align:start;text-indent:0px;text-transform:none;white-space:norma=
l;word-spacing:0px;text-decoration:none"><span style=3D"color:rgb(0,0,0)">I=
t=E2=80=99s
 just like with any code smell: they don=E2=80=99t necessarily break things=
. But
 they make maintenance, code-reviews and quality control harder than=20
necessary. Code that does not at least follow PEP8 (and I actually=20
strongly recommend to go the extra mile with `black`) just looks odd and
 is unnecessary hard to read. I=E2=80=99m surprised I have to argue for=20
standards.</span></div><div style=3D"font-family:Helvetica;font-size:12px;f=
ont-style:normal;font-variant-caps:normal;font-weight:normal;letter-spacing=
:normal;text-align:start;text-indent:0px;text-transform:none;white-space:no=
rmal;word-spacing:0px;text-decoration:none"><span style=3D"color:rgb(0,0,0)=
"><br class=3D"gmail-"></span></div><div style=3D"font-family:Helvetica;fon=
t-size:12px;font-style:normal;font-variant-caps:normal;font-weight:normal;l=
etter-spacing:normal;text-align:start;text-indent:0px;text-transform:none;w=
hite-space:normal;word-spacing:0px;text-decoration:none"><span style=3D"col=
or:rgb(0,0,0)"><span class=3D"gmail-" style=3D"caret-color: rgb(0, 0, 0);">=
Besides that, some minor cleanup just to warm up:=C2=A0</span><a href=3D"ht=
tps://github.com/openembedded/bitbake/pull/33" class=3D"gmail-">https://git=
hub.com/openembedded/bitbake/pull/33</a><span class=3D"gmail-" style=3D"car=
et-color: rgb(0, 0, 0);">,=C2=A0</span><a href=3D"https://github.com/openem=
bedded/bitbake/pull/32/files" class=3D"gmail-">https://github.com/openembed=
ded/bitbake/pull/32/files</a><span class=3D"gmail-" style=3D"caret-color: r=
gb(0, 0, 0);">=C2=A0(it was after these two that I found the comment in one=
 of those old commits which made me open=C2=A0</span><a href=3D"https://git=
hub.com/openembedded/bitbake/pull/34" class=3D"gmail-">https://github.com/o=
penembedded/bitbake/pull/34</a><font class=3D"gmail-">).
 At least there should be an=C2=A0automated reply to each MR that is posted=
=20
if someone makes the effort to fix code and open a MRs that this=20
is=C2=A0actually in vein - That=E2=80=99s the=C2=A0mood that took me here :=
)</font></span></div><div style=3D"font-family:Helvetica;font-size:12px;fon=
t-style:normal;font-variant-caps:normal;font-weight:normal;letter-spacing:n=
ormal;text-align:start;text-indent:0px;text-transform:none;white-space:norm=
al;word-spacing:0px;text-decoration:none"><span style=3D"color:rgb(0,0,0)">=
<br class=3D"gmail-"></span></div><div style=3D"font-family:Helvetica;font-=
size:12px;font-style:normal;font-variant-caps:normal;font-weight:normal;let=
ter-spacing:normal;text-align:start;text-indent:0px;text-transform:none;whi=
te-space:normal;word-spacing:0px;text-decoration:none"><blockquote type=3D"=
cite" class=3D"gmail-"><div class=3D"gmail-"><div class=3D"gmail-"><span st=
yle=3D"color:rgb(0,0,0)"><br class=3D"gmail-">Help appreciated but email pa=
tches is how we accept them at the moment.<br class=3D"gmail-"></span></div=
></div></blockquote><span style=3D"color:rgb(0,0,0)"><br class=3D"gmail-">N=
ot from me then :(</span></div><div style=3D"font-family:Helvetica;font-siz=
e:12px;font-style:normal;font-variant-caps:normal;font-weight:normal;letter=
-spacing:normal;text-align:start;text-indent:0px;text-transform:none;white-=
space:normal;word-spacing:0px;text-decoration:none"><span style=3D"color:rg=
b(0,0,0)"><br class=3D"gmail-"></span><blockquote type=3D"cite" class=3D"gm=
ail-"><div class=3D"gmail-"><div class=3D"gmail-"><span style=3D"color:rgb(=
0,0,0)"><br class=3D"gmail-">Cheers,<br class=3D"gmail-"><br class=3D"gmail=
-">Richard<br class=3D"gmail-"><br class=3D"gmail-"></span></div></div></bl=
ockquote><span style=3D"color:rgb(0,0,0)">Bottom
 line: I know I sounded harsh. Sorry about that! I love bitbake and use=20
it A LOT! I=E2=80=99d just love even more to get my hands dirty improving a=
=20
bunch of things. But only if the tools in place promise an efficient=20
collaboration reducing overhead as much as possible.</span></div><div style=
=3D"font-family:Helvetica;font-size:12px;font-style:normal;font-variant-cap=
s:normal;font-weight:normal;letter-spacing:normal;text-align:start;text-ind=
ent:0px;text-transform:none;white-space:normal;word-spacing:0px;text-decora=
tion:none"><span style=3D"color:rgb(0,0,0)"><br class=3D"gmail-"></span></d=
iv><div style=3D"font-family:Helvetica;font-size:12px;font-style:normal;fon=
t-variant-caps:normal;font-weight:normal;letter-spacing:normal;text-align:s=
tart;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0p=
x;text-decoration:none"><span style=3D"color:rgb(0,0,0)">And
 I=E2=80=99m 100 % there are more developers out there that did not even dr=
op a=20
message here but instead decided to not even start contribution at all.=20
So, my suggestion is to think about what are the most significant=20
burdens that hinder from contributing. My best bet is the email patches=20
:)</span></div><div style=3D"font-family:Helvetica;font-size:12px;font-styl=
e:normal;font-variant-caps:normal;font-weight:normal;letter-spacing:normal;=
text-align:start;text-indent:0px;text-transform:none;white-space:normal;wor=
d-spacing:0px;text-decoration:none"><span style=3D"color:rgb(0,0,0)"><br cl=
ass=3D"gmail-"></span></div><div style=3D"font-family:Helvetica;font-size:1=
2px;font-style:normal;font-variant-caps:normal;font-weight:normal;letter-sp=
acing:normal;text-align:start;text-indent:0px;text-transform:none;white-spa=
ce:normal;word-spacing:0px;text-decoration:none"><span style=3D"color:rgb(0=
,0,0)">Best regards</span></div><div style=3D"font-family:Helvetica;font-si=
ze:12px;font-style:normal;font-variant-caps:normal;font-weight:normal;lette=
r-spacing:normal;text-align:start;text-indent:0px;text-transform:none;white=
-space:normal;word-spacing:0px;text-decoration:none"><span style=3D"color:r=
gb(0,0,0)"><br class=3D"gmail-"></span></div><div style=3D"font-family:Helv=
etica;font-size:12px;font-style:normal;font-variant-caps:normal;font-weight=
:normal;letter-spacing:normal;text-align:start;text-indent:0px;text-transfo=
rm:none;white-space:normal;word-spacing:0px;text-decoration:none"><span sty=
le=3D"color:rgb(0,0,0)">Marius</span></div><span style=3D"color:rgb(0,0,0)"=
><br class=3D"gmail-Apple-interchange-newline"><br></span></div><span style=
=3D"color:rgb(0,0,0)"><br></span><div class=3D"gmail_quote"><div dir=3D"ltr=
" class=3D"gmail_attr"><span style=3D"color:rgb(0,0,0)">Am Mo., 8. Nov. 202=
1 um 22:47=C2=A0Uhr schrieb Richard Purdie &lt;<a href=3D"mailto:richard.pu=
rdie@linuxfoundation.org">richard.purdie@linuxfoundation.org</a>&gt;:<br></=
span></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><span style=3D=
"color:rgb(0,0,0)">On Mon, 2021-11-08 at 18:37 +0100, Marius Kriegerowski w=
rote:<br>
&gt; Is there a plan to switch to some more modern ways to collaborate on b=
itbake,<br>
&gt; you know, like, gitlab/github/gitea with issues, PRs and so forth? I m=
ean=E2=80=A6 it=E2=80=99s<br>
&gt; late 2021 and sending MRs/Issues via email feels reaaaally outdated, s=
low,<br>
&gt; intransparent, ineffective (how to you do reviews, code comparisons du=
ring<br>
&gt; reviews, insert suggestions, etc.) and indirect (where is the CI pipel=
ine that I<br>
&gt; trigger when pushing something somewhere?).<br></span>
<span style=3D"color:rgb(0,0,0)"><br>
There are pros and cons to switching to something else. Keep in mind that w=
hilst<br>
the github workflow works well for a single maintainer of a project, it doe=
s not<br>
work well for diverse review. For wider Openembedded/ Yocto Project, we rea=
lly<br>
benefit from mailing list code review since we have a wide set of reviewers=
 and<br>
no single person makes a direct decision on whether code is right or not.<b=
r></span>
<span style=3D"color:rgb(0,0,0)"><br>
The Bitbake case is a little bit different but in general we&#39;d follow w=
hat<br>
OE/Yocto Project are doing.<br></span>
<span style=3D"color:rgb(0,0,0)"><br>
We have discussed changing and it is listed as one topic on:<br></span>
<span style=3D"color:rgb(0,0,0)"><a href=3D"https://wiki.yoctoproject.org/w=
iki/Future_Directions" rel=3D"noreferrer" target=3D"_blank">https://wiki.yo=
ctoproject.org/wiki/Future_Directions</a><br>
(Code Submission process)<br></span>
<span style=3D"color:rgb(0,0,0)"><br>
I&#39;d note that it is a huge change to our current developers and most of=
 us are<br>
very used to the mailing lists so if we did change, it would allow potentia=
l new<br>
collaborators at the risk of losing people with key knowledge/experience. Y=
ou<br>
can do collaboration, code review and development with our current processe=
s, it<br>
just isn&#39;t the github workflow.<br></span>
<span style=3D"color:rgb(0,0,0)"><br>
We do have CI which is shared with Yocto Project and=C2=A0<br>
OpenEmbedded. You can see it here:<br></span>
<span style=3D"color:rgb(0,0,0)"><br></span>
<span style=3D"color:rgb(0,0,0)"><a href=3D"https://autobuilder.yoctoprojec=
t.org/typhoon/#/console" rel=3D"noreferrer" target=3D"_blank">https://autob=
uilder.yoctoproject.org/typhoon/#/console</a><br></span>
<span style=3D"color:rgb(0,0,0)"><br>
and it has it&#39;s own manual which was recently added to our documentatio=
ns set:<br></span>
<span style=3D"color:rgb(0,0,0)"><br></span>
<span style=3D"color:rgb(0,0,0)"><a href=3D"http://docs.yoctoproject.org/te=
st-manual/index.html" rel=3D"noreferrer" target=3D"_blank">http://docs.yoct=
oproject.org/test-manual/index.html</a><br></span>
<span style=3D"color:rgb(0,0,0)"><br>
There is work still needed on that but it is a start.=C2=A0One challenge of=
<br>
bitbake/OE is that the builds take an age and the test matrix is huge so th=
e CI<br>
process isn&#39;t quite as simple as some other simpler projects.<br></span=
>
<span style=3D"color:rgb(0,0,0)"><br>
As a shortcut through things, the &quot;bitbake-selftest&quot; command with=
in bitbake may<br>
be one thing you&#39;re looking for which does simple tests on bitbake. It =
isn&#39;t<br>
complete coverage and we welcome more being added, it is a start and some a=
reas<br>
of the code are covered better than others.<br></span>
<span style=3D"color:rgb(0,0,0)"><br>
Issues are filed in the project bugzilla and are actively worked on:<br></s=
pan>
<span style=3D"color:rgb(0,0,0)"><br></span>
<span style=3D"color:rgb(0,0,0)"><a href=3D"https://bugzilla.yoctoproject.o=
rg/" rel=3D"noreferrer" target=3D"_blank">https://bugzilla.yoctoproject.org=
/</a><br></span>
<span style=3D"color:rgb(0,0,0)"><br>
&gt; I threw a search engine at =E2=80=98yocto bitbake CI=E2=80=99 (and sim=
ilar) but didn=E2=80=99t find<br>
&gt; it. I=E2=80=99m 110 % sure that there is a CI pipeline but it would ma=
ke<br>
&gt; contributions, reviews, etc. so much more efficient if I as the (hypot=
hetical)<br>
&gt; contributor would see the outcome of just a linter*. Maybe it=E2=80=99=
s somewhere<br>
&gt; documented where the CI is hosted but then: No other project I contrib=
ute to<br>
&gt; needs documentation about these things. They are just there and obviou=
s.<br>
&gt; <br>
&gt; Don=E2=80=99t get me wrong: bitbake is awesome. I=E2=80=99d just love =
to contribute but the<br>
&gt; burden for collaboration here is not really up to date. So, is there a=
<br>
&gt; strategy to improve the on-boarding and workflow?<br></span>
<span style=3D"color:rgb(0,0,0)"><br>
We&#39;ve ideas but like the kernel, we do get things from the patch based =
workflow<br>
which we&#39;d lose in a single person focused maintainer system like githu=
b so I<br>
doubt we&#39;ll change to that.<br></span>
<span style=3D"color:rgb(0,0,0)"><br>
&gt; * side-note on bitbake style/linting: It=E2=80=99s violating PEP8 in a=
 couple of ways<br>
&gt; and TBH PEP8 is the bare minimum I would accept these days for collabo=
ration<br>
&gt; on projects the dimension of bitbake. So an additional question: Would=
 you be<br>
&gt; up for a PEP8 compatibility overhaul of the source code? I=E2=80=99d v=
olunteer if I<br>
&gt; don=E2=80=99t have to send a patch via email ;)<br></span>
<span style=3D"color:rgb(0,0,0)"><br>
We&#39;re interested in patches to improve the coding style as long as they=
 don&#39;t<br>
break things like readability or performance.=C2=A0Which rules in PEP8 in p=
articular<br>
are you referring to?<br></span>
<span style=3D"color:rgb(0,0,0)"><br>
Help appreciated but email patches is how we accept them at the moment.<br>=
</span>
<span style=3D"color:rgb(0,0,0)"><br>
Cheers,<br></span>
<span style=3D"color:rgb(0,0,0)"><br>
Richard<br></span>
<span style=3D"color:rgb(0,0,0)"><br></span>
</blockquote></div></div>

--000000000000230d6f05d04ebc79--

