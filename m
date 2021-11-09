Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E55DC433F5
	for <webhook@archiver.kernel.org>; Tue,  9 Nov 2021 06:47:50 +0000 (UTC)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com
 [209.85.222.49])
 by mx.groups.io with SMTP id smtpd.web08.8769.1636440469366929657
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 08 Nov 2021 22:47:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=j8p1tPQ7;
 spf=pass (domain: gmail.com, ip: 209.85.222.49,
 mailfrom: alex.kanavin@gmail.com)
Received: by mail-ua1-f49.google.com with SMTP id v3so36465809uam.10
        for <bitbake-devel@lists.openembedded.org>;
 Mon, 08 Nov 2021 22:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9WHRqDJ3BYd0qj+oahsO9nwedN7lmr0ELgd6rZSVfLA=;
        b=j8p1tPQ7SnGeaCxHZb4bEG+POXtSIv9uy5Of/6bWdjBqsSS8GcpjkhTqCbhDkqm0si
         EhoKYjBDxFvtaDVY3f8MIFF9m4mLgmwcNIazKUbda+QrsD/NgBaUk/7bYPdIaTgqlOvL
         v/j9AOKrELn97AIqdbFLIb1NFkE7vu0pOd92e5CUfZYuPk2bjk5zg/LNVT4oh0aHF0bA
         Uzh7brV2y8cMCJLzclgp+qTePQYXhthmQW6eOi4Lg80pXcp5hfiSem/ng02ieFMJsgNn
         YMJYOUAdBBxrRzd6vijMHUo+qghxUo5GToAD6YzKZxSrE3Ocg6Cqarv136KZjwZjnukE
         51Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9WHRqDJ3BYd0qj+oahsO9nwedN7lmr0ELgd6rZSVfLA=;
        b=hfFNIHkM2Hdu0K+gGefXkzdgo2bfdSsvigs0bQH/3bjQ0eQFaFwzHdPmZzbMvId0rv
         8oJiHJumgC3lu1Fc3Je4yhz1RC3A9YOXtE/kyaxYL4J61qA4ZY8aptKp1MK33LjN4van
         M0YqOZvDBD1p9JJWG/OZIbQuIflj5os+vaJ+sY5moBR0VNF5+G/0EGZNaRKfe9oLSIbO
         UKGGziOTcxw/aheWn5sfwJVQ54na2dzop38jrDWdnUP8IN2C/uMhA/ocFQsTCxdJoaxk
         1uRRM6B0qUFdROyz+Gz5OP4GdY/U0UPuQId8SKVsWoVuLEzRSnOQ0sn6+RbSY9+tIQTW
         wRhQ==
X-Gm-Message-State: AOAM530vn1MXJ/9TzdiNwcK4s+bzek8NyieHJzhqRBSPjJv2nUqomaxV
	jltZHcXceV/2bxpUN3ZvdD2JIXn9lz7J7hwpdDk=
X-Google-Smtp-Source: 
 ABdhPJxDKFuSyGze9gyDDc88Poo2seayHgnKTOtqbNplBnEaYPcDrzK81sjzlOym4A5qeqgQYnDsoPdzFYIO7DFrpQY=
X-Received: by 2002:ab0:3d10:: with SMTP id f16mr7317689uax.100.1636440468391;
 Mon, 08 Nov 2021 22:47:48 -0800 (PST)
MIME-Version: 1.0
References: 
 <CAMaS9hNh8iztUquiPddua-6Lu0nLzU832YwHG+rw284zqUzEZQ@mail.gmail.com>
 <CAMaS9hPB=273mfQ4eZp32tsy3DrsqX3x0sKmxSaZ2CbsvaYYxA@mail.gmail.com>
 <d5683f0ad0dd0185309d5d8feea6c7e7141fa343.camel@linuxfoundation.org>
 <CAMaS9hNpp9QsUqkpXvNj_F5R4aQoe+qHg+_mtxnZRL0PoAYaGw@mail.gmail.com>
 <589e9863e78ed9f8234a3756b37ffb979daa770c.camel@linuxfoundation.org>
In-Reply-To: 
 <589e9863e78ed9f8234a3756b37ffb979daa770c.camel@linuxfoundation.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 9 Nov 2021 07:47:37 +0100
Message-ID: 
 <CANNYZj8_zPhh_XCZrxaPvXd_Oz5kzbzHNLvT6qzvtztquKA0ew@mail.gmail.com>
Subject: Re: [bitbake-devel] bitbake style/workflow
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: Marius Kriegerowski <marius.kriegerowski@gmail.com>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="000000000000d0890e05d0557cc3"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 09 Nov 2021 06:47:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12953

--000000000000d0890e05d0557cc3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

There's another problem with github/gitlab which I find significant. These
tools do not allow reviewing commit messages, and don't even make it easy
to see them. So the developers using those tools, both submitters and
maintainers, are effectively being conditioned by the tools to see good
commit messages as superfluous and unnecessary. And so you more often than
not end up with poorly written commit history in github projects, or, if
you're a reviewer, have to repeatedly explain to the submitter how to
explain and structure their changes properly.

I'd rather not have a change, than have a change that no one, even the
original author, can understand or remember the reasons for one year down
the line.

Alex


On Tue, 9 Nov 2021 at 00:30, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> On Mon, 2021-11-08 at 23:44 +0100, Marius Kriegerowski wrote:
> >
> >
> > > On 8. Nov 2021, at 22:47, Richard Purdie
> > > <richard.purdie@linuxfoundation.org> wrote:
> > >
> > > On Mon, 2021-11-08 at 18:37 +0100, Marius Kriegerowski wrote:
> > > > Is there a plan to switch to some more modern ways to collaborate o=
n
> > > > bitbake,
> > > > you know, like, gitlab/github/gitea with issues, PRs and so forth? =
I
> mean=E2=80=A6
> > > > it=E2=80=99s
> > > > late 2021 and sending MRs/Issues via email feels reaaaally outdated=
,
> slow,
> > > > intransparent, ineffective (how to you do reviews, code comparisons
> during
> > > > reviews, insert suggestions, etc.) and indirect (where is the CI
> pipeline
> > > > that I
> > > > trigger when pushing something somewhere?).
> > >
> > > There are pros and cons to switching to something else. Keep in mind
> that
> > > whilst the github workflow works well for a single maintainer of a
> project,
> > > it does not work well for diverse review.
> >
> > I strongly disagree with that. Reviews can equally well be done in a MR
> > thread. That=E2=80=99s what they are there for. You can discuss things =
there
> with as
> > many people as you want and can e.g. define a minimum number of approva=
ls
> > before a MR can be merged.
>
> You misunderstand my point. We have a several thousand people on the
> mailing
> lists and they filter things to what interests them. *I* have no people I
> want
> to discuss a given change with, it is a question of whether the people wh=
o
> have
> an interest in a given change would see it.
>
> A minimum number of approvals is utterly meaningless for how we work, I
> need the
> interested people to see it and that varies massively depending on what i=
s
> being
> changed. It is this aspect of mailing list change distribution and
> discussion we
> benefit from.
>
> >  It also naturally groups discussions. You can address experts for
> specific
> > domains which means less noise for the experts. I really don=E2=80=99t =
see why
> mailing
> > list reviews should work any better here.
>
> We all have established mechanisms to "see" the things which interest us =
as
> maintainers?
>
> Please don't misunderstand me, I do see the attraction of github from you=
r
> perspective. It would just destroy the ecosystem we already have. You are
> basically saying that our current ecosystem is worthless but I would poin=
t
> out
> it has resulted in a project which you did say you appreciate so it can't
> be all
> bad.
>
> >  If google can coordinate 2.1k repos with 1.1k contributors over GitHub=
,
> why
> > should that not work for openembedded??
>
> It isn't about raw numbers, it is about numbers of reviewers for a given
> change.
> We have hundreds of people doing that using the mailing lists.
>
> > > The Bitbake case is a little bit different but in general we'd follow
> what
> > > OE/Yocto Project are doing.
> > >
> > > We have discussed changing and it is listed as one topic on:
> > > https://wiki.yoctoproject.org/wiki/Future_Directions
> > > (Code Submission process)
> > >
> > > I'd note that it is a huge change to our current developers and most
> of us
> > > are very used to the mailing lists so if we did change, it would allo=
w
> > > potential new collaborators at the risk of losing people with key
> > > knowledge/experience.
> > =E2=80=A6 which reads to me like: =E2=80=9CIt has always been that way =
so we will not
> change
> > that" doesn=E2=80=99t it? Always a very poor argument.
>
> No, what I said is "upsetting our existing developers is something which
> we may
> want to potentially avoid".
>
> There are some options out there which have offered mailing list
> integration for
> example and we have tried to explore those. Something which drops the lis=
ts
> entirely could in the current view of the TSC result in loss of too many
> of our
> existing maintainers.
>
> >
> > > We do have CI which is shared with Yocto Project and
> > > OpenEmbedded. You can see it here:
> > >
> > > https://autobuilder.yoctoproject.org/typhoon/#/console
> > >
> > > and it has it's own manual which was recently added to our
> documentations
> > > set:
> > >
> > > http://docs.yoctoproject.org/test-manual/index.html
> > =E2=80=A6 stressing my point: Why does the location of the CI need
> documentation? All
> > of the aforementioned platforms smoothly integrate with multiple CI
> solutions,
> > drastically reducing the time required for reviews if the pipeline
> provides
> > automated feedback to the contributor. It would probably cost me about
> one
> > afternoon to setup a decent CI pipeline at least for all python codes
> pushing
> > the need to review from manual labor to automated tools. If open embedd=
ed
> > migrates to a proper git platform I happily volunteer on that end!!
>
> We're not talking about simple python code. We're talking about testing a
> build
> environment which cross compiles multiple operating systems for multiple
> architectures, C libraries, GUI stacks, init systems and so on. Testing t=
he
> python code is one small part of that. I've spent several years trying to
> improve and get our CI to where it is today.
>
> Yes, the python code is tested as part of this as we don't really want to
> have
> multiple test platforms and the real world usage is some of the best
> testing
> changes can have.
>
> > > There is work still needed on that but it is a start. One challenge o=
f
> > > bitbake/OE is that the builds take an age and the test matrix is huge
> so the
> > > CI
> > > process isn't quite as simple as some other simpler projects.
> > At least for python I bet that most bugs can be caught simply by firing
> up
> > `black`, `flake8`, `pylint` (and a hand full of other tools) just to
> check the
> > modified files.
>
> Well, I would bet that most of our bugs are not caused by issues like
> that. I do
> attend the weekly bug triage meetings and have fixed my share of them. Yo=
u
> could
> have a look at the issues filed in bugzilla over the past few weeks if
> you'd
> like to see the kinds of issues that get filed and are open.
>
> >  Regarding meta-layers and recipes out there we are currently pushing
> forward
> > with a linter for bitbake recipes (thanks @priv-kweihmann for this
> awesome and
> > overdue tool!!!).
>
> Whilst improving recipes in that way does help, it isn't the main source
> of our
> major issues.
>
> > >
> > > As a shortcut through things, the "bitbake-selftest" command within
> bitbake
> > > may
> > > be one thing you're looking for which does simple tests on bitbake. I=
t
> isn't
> > > complete coverage and we welcome more being added, it is a start and
> some
> > > areas
> > > of the code are covered better than others.
> > I=E2=80=99d love to overhaul the tests e.g. porting them to `pytest` wh=
ich
> offers a
> > much simpler yet much more powerful API/plugin-ecosystem. But won=E2=80=
=99t do
> via
> > email :)
>
> The tests are written in python's own unittest.
>
> > > Issues are filed in the project bugzilla and are actively worked on:
> > >
> > > https://bugzilla.yoctoproject.org/
> > Didn=E2=80=99t know that. But why keeping issues separate from MRs? Aut=
omatic
> issue
> > closing through referencing in MRs is a pretty nice feature=E2=80=A6
>
> If I had to list the pain points we have, this is not high on the list.
>
> > > > * side-note on bitbake style/linting: It=E2=80=99s violating PEP8 i=
n a
> couple of
> > > > ways and TBH PEP8 is the bare minimum I would accept these days for
> > > > collaboration on projects the dimension of bitbake. So an additiona=
l
> > > > question: Would you be up for a PEP8 compatibility overhaul of the
> source
> > > > code? I=E2=80=99d volunteer if I don=E2=80=99t have to send a patch=
 via email ;)
> > >
> > > We're interested in patches to improve the coding style as long as th=
ey
> > > don't
> > > break things like readability or performance. Which rules in PEP8 in
> > > particular
> > > are you referring to?
> >
> > To name a few violations:
> >
> >  * hanging indents
> >  * inconsistent indentation
> >  * 2 separating lines missing in between classes/top level methods
>
> FWIW I find it really hard to get worked up about whitespace issues. I
> appreciate these aren't always great to look at and I appreciate the
> familiarity
> argument and standardising the look but these aren't issues I would
> prioritise.
>
> In particular changing them globally in mass patches tends to break patch
> backporting and taking fixes back to older code which we do benefit from
> being
> able to do so there is a cost to doing it. We are trying to make new code
> more
> consistent and with older code, we do try and fix the worst issues.
>
> >  * unused imported modules
> >  * missing white-spaces after comma
> >  * unreachable codes
>
> These ones we do take patches for and try to fix when/where we see it. Fo=
r
> example,
> http://git.yoctoproject.org/cgit.cgi/poky/commit/?id=3D47e5c456a20432b511
> d830df9cbd4113a4352b2c
> <http://git.yoctoproject.org/cgit.cgi/poky/commit/?id=3D47e5c456a20432b51=
1d830df9cbd4113a4352b2c> contained
> a couple of white-space after comma fixing
> while I was in that area.
>
> > These are just a couple of examples that struck my PEP8 used eye from
> looking
> > at two, three modules.
> >
> > It=E2=80=99s just like with any code smell: they don=E2=80=99t necessar=
ily break things.
> But
> > they make maintenance, code-reviews and quality control harder than
> necessary.
> > Code that does not at least follow PEP8 (and I actually strongly
> recommend to
> > go the extra mile with `black`) just looks odd and is unnecessary hard =
to
> > read. I=E2=80=99m surprised I have to argue for standards.
>
> I wasn't saying it was a bad thing, I asked which issues you noticed in
> particular since I'm trying to ensure we do at least try and react to
> feedback.
> Some whitespace issues we aren't likely to tackle, some like the others y=
ou
> mentioned above we should fix.
> >
> > Besides that, some minor cleanup just to warm
> > up: https://github.com/openembedded/bitbake/pull/33,
> https://github.com/openem
> > bedded/bitbake/pull/32/files
>
> Those two do look like reasonable changes FWIW.
>
> > (it was after these two that I found the comment in one of those old
> commits
> > which made me open https://github.com/openembedded/bitbake/pull/34). At
> least
> > there should be an automated reply to each MR that is posted if someone
> makes
> > the effort to fix code and open a MRs that this is actually in vein -
> That=E2=80=99s
> > the mood that took me here :)
>
> There is a certain irony in that given you patched the section called
> "Contributing" in the README in 32!
>
> > >
> > > Help appreciated but email patches is how we accept them at the momen=
t.
> >
> > Not from me then :(
>
> Sorry to hear that, your changes in 32/33 do look reasonable.
>
> Cheers,
>
> Richard
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#12951):
> https://lists.openembedded.org/g/bitbake-devel/message/12951
> Mute This Topic: https://lists.openembedded.org/mt/86911583/1686489
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> alex.kanavin@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--000000000000d0890e05d0557cc3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>There&#39;s another problem with github/gitlab which =
I find significant. These tools do not allow reviewing commit messages, and=
 don&#39;t even make it easy to see them. So the developers using those too=
ls, both submitters and maintainers, are effectively being conditioned by t=
he tools to see good commit messages as superfluous and unnecessary. And so=
 you more often than not end up with poorly written commit history in githu=
b projects, or, if you&#39;re a reviewer, have to repeatedly explain to the=
 submitter how to explain and structure their changes properly.</div><div><=
br></div><div>I&#39;d rather not have a change, than have a change that no =
one, even the original author, can understand or remember the reasons for o=
ne year down the line.</div><div><br></div><div>Alex<br></div><br></div><br=
><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, 9=
 Nov 2021 at 00:30, Richard Purdie &lt;<a href=3D"mailto:richard.purdie@lin=
uxfoundation.org">richard.purdie@linuxfoundation.org</a>&gt; wrote:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">On Mon, 2021-11-08 at 2=
3:44 +0100, Marius Kriegerowski wrote:<br>
&gt; <br>
&gt; <br>
&gt; &gt; On 8. Nov 2021, at 22:47, Richard Purdie<br>
&gt; &gt; &lt;<a href=3D"mailto:richard.purdie@linuxfoundation.org" target=
=3D"_blank">richard.purdie@linuxfoundation.org</a>&gt; wrote:<br>
&gt; &gt; <br>
&gt; &gt; On Mon, 2021-11-08 at 18:37 +0100, Marius Kriegerowski wrote:<br>
&gt; &gt; &gt; Is there a plan to switch to some more modern ways to collab=
orate on<br>
&gt; &gt; &gt; bitbake,<br>
&gt; &gt; &gt; you know, like, gitlab/github/gitea with issues, PRs and so =
forth? I mean=E2=80=A6<br>
&gt; &gt; &gt; it=E2=80=99s<br>
&gt; &gt; &gt; late 2021 and sending MRs/Issues via email feels reaaaally o=
utdated, slow,<br>
&gt; &gt; &gt; intransparent, ineffective (how to you do reviews, code comp=
arisons during<br>
&gt; &gt; &gt; reviews, insert suggestions, etc.) and indirect (where is th=
e CI pipeline<br>
&gt; &gt; &gt; that I<br>
&gt; &gt; &gt; trigger when pushing something somewhere?).<br>
&gt; &gt; <br>
&gt; &gt; There are pros and cons to switching to something else. Keep in m=
ind that<br>
&gt; &gt; whilst the github workflow works well for a single maintainer of =
a project,<br>
&gt; &gt; it does not work well for diverse review.<br>
&gt;<br>
&gt; I strongly disagree with that. Reviews can equally well be done in a M=
R<br>
&gt; thread. That=E2=80=99s what they are there for. You can discuss things=
 there with as<br>
&gt; many people as you want and can e.g. define a minimum number of approv=
als<br>
&gt; before a MR can be merged.<br>
<br>
You misunderstand my point. We have a several thousand people on the mailin=
g<br>
lists and they filter things to what interests them. *I* have no people I w=
ant<br>
to discuss a given change with, it is a question of whether the people who =
have<br>
an interest in a given change would see it.<br>
<br>
A minimum number of approvals is utterly meaningless for how we work, I nee=
d the<br>
interested people to see it and that varies massively depending on what is =
being<br>
changed. It is this aspect of mailing list change distribution and discussi=
on we<br>
benefit from.<br>
<br>
&gt; =C2=A0It also naturally groups discussions. You can address experts fo=
r specific<br>
&gt; domains which means less noise for the experts. I really don=E2=80=99t=
 see why mailing<br>
&gt; list reviews should work any better here.<br>
<br>
We all have established mechanisms to &quot;see&quot; the things which inte=
rest us as<br>
maintainers?<br>
<br>
Please don&#39;t misunderstand me, I do see the attraction of github from y=
our<br>
perspective. It would just destroy the ecosystem we already have. You are<b=
r>
basically saying that our current ecosystem is worthless but I would point =
out<br>
it has resulted in a project which you did say you appreciate so it can&#39=
;t be all<br>
bad.<br>
<br>
&gt; =C2=A0If google can coordinate 2.1k repos with 1.1k contributors over =
GitHub, why<br>
&gt; should that not work for openembedded??<br>
<br>
It isn&#39;t about raw numbers, it is about numbers of reviewers for a give=
n change.<br>
We have hundreds of people doing that using the mailing lists.<br>
<br>
&gt; &gt; The Bitbake case is a little bit different but in general we&#39;=
d follow what<br>
&gt; &gt; OE/Yocto Project are doing.<br>
&gt; &gt; <br>
&gt; &gt; We have discussed changing and it is listed as one topic on:<br>
&gt; &gt; <a href=3D"https://wiki.yoctoproject.org/wiki/Future_Directions" =
rel=3D"noreferrer" target=3D"_blank">https://wiki.yoctoproject.org/wiki/Fut=
ure_Directions</a><br>
&gt; &gt; (Code Submission process)<br>
&gt; &gt; <br>
&gt; &gt; I&#39;d note that it is a huge change to our current developers a=
nd most of us<br>
&gt; &gt; are very used to the mailing lists so if we did change, it would =
allow<br>
&gt; &gt; potential new collaborators at the risk of losing people with key=
<br>
&gt; &gt; knowledge/experience.<br>
&gt; =E2=80=A6 which reads to me like: =E2=80=9CIt has always been that way=
 so we will not change<br>
&gt; that&quot; doesn=E2=80=99t it? Always a very poor argument.<br>
<br>
No, what I said is &quot;upsetting our existing developers is something whi=
ch we may<br>
want to potentially avoid&quot;.<br>
<br>
There are some options out there which have offered mailing list integratio=
n for<br>
example and we have tried to explore those. Something which drops the lists=
<br>
entirely could in the current view of the TSC result in loss of too many of=
 our<br>
existing maintainers.<br>
<br>
&gt; <br>
&gt; &gt; We do have CI which is shared with Yocto Project and=C2=A0<br>
&gt; &gt; OpenEmbedded. You can see it here:<br>
&gt; &gt; <br>
&gt; &gt; <a href=3D"https://autobuilder.yoctoproject.org/typhoon/#/console=
" rel=3D"noreferrer" target=3D"_blank">https://autobuilder.yoctoproject.org=
/typhoon/#/console</a><br>
&gt; &gt; <br>
&gt; &gt; and it has it&#39;s own manual which was recently added to our do=
cumentations<br>
&gt; &gt; set:<br>
&gt; &gt; <br>
&gt; &gt; <a href=3D"http://docs.yoctoproject.org/test-manual/index.html" r=
el=3D"noreferrer" target=3D"_blank">http://docs.yoctoproject.org/test-manua=
l/index.html</a><br>
&gt; =E2=80=A6 stressing my point: Why does the location of the CI need doc=
umentation? All<br>
&gt; of the aforementioned platforms smoothly integrate with multiple CI so=
lutions,<br>
&gt; drastically reducing the time required for reviews if the pipeline pro=
vides<br>
&gt; automated feedback to the contributor. It would probably cost me about=
 one<br>
&gt; afternoon to setup a decent CI pipeline at least for all python codes =
pushing<br>
&gt; the need to review from manual labor to automated tools. If open embed=
ded<br>
&gt; migrates to a proper git platform I happily volunteer on that end!!<br=
>
<br>
We&#39;re not talking about simple python code. We&#39;re talking about tes=
ting a build<br>
environment which cross compiles multiple operating systems for multiple<br=
>
architectures, C libraries, GUI stacks, init systems and so on. Testing the=
<br>
python code is one small part of that. I&#39;ve spent several years trying =
to<br>
improve and get our CI to where it is today.<br>
<br>
Yes, the python code is tested as part of this as we don&#39;t really want =
to have<br>
multiple test platforms and the real world usage is some of the best testin=
g<br>
changes can have.<br>
<br>
&gt; &gt; There is work still needed on that but it is a start.=C2=A0One ch=
allenge of<br>
&gt; &gt; bitbake/OE is that the builds take an age and the test matrix is =
huge so the<br>
&gt; &gt; CI<br>
&gt; &gt; process isn&#39;t quite as simple as some other simpler projects.=
<br>
&gt; At least for python I bet that most bugs can be caught simply by firin=
g up<br>
&gt; `black`, `flake8`, `pylint` (and a hand full of other tools) just to c=
heck the<br>
&gt; modified files.<br>
<br>
Well, I would bet that most of our bugs are not caused by issues like that.=
 I do<br>
attend the weekly bug triage meetings and have fixed my share of them. You =
could<br>
have a look at the issues filed in bugzilla over the past few weeks if you&=
#39;d<br>
like to see the kinds of issues that get filed and are open.<br>
<br>
&gt; =C2=A0Regarding meta-layers and recipes out there we are currently pus=
hing forward<br>
&gt; with a linter for bitbake recipes (thanks @priv-kweihmann for this awe=
some and<br>
&gt; overdue tool!!!).<br>
<br>
Whilst improving recipes in that way does help, it isn&#39;t the main sourc=
e of our<br>
major issues.<br>
<br>
&gt; &gt; <br>
&gt; &gt; As a shortcut through things, the &quot;bitbake-selftest&quot; co=
mmand within bitbake<br>
&gt; &gt; may<br>
&gt; &gt; be one thing you&#39;re looking for which does simple tests on bi=
tbake. It isn&#39;t<br>
&gt; &gt; complete coverage and we welcome more being added, it is a start =
and some<br>
&gt; &gt; areas<br>
&gt; &gt; of the code are covered better than others.<br>
&gt; I=E2=80=99d love to overhaul the tests e.g. porting them to `pytest` w=
hich offers a<br>
&gt; much simpler yet much more powerful API/plugin-ecosystem. But won=E2=
=80=99t do via<br>
&gt; email :)<br>
<br>
The tests are written in python&#39;s own unittest.<br>
<br>
&gt; &gt; Issues are filed in the project bugzilla and are actively worked =
on:<br>
&gt; &gt; <br>
&gt; &gt; <a href=3D"https://bugzilla.yoctoproject.org/" rel=3D"noreferrer"=
 target=3D"_blank">https://bugzilla.yoctoproject.org/</a><br>
&gt; Didn=E2=80=99t know that. But why keeping issues separate from MRs? Au=
tomatic issue<br>
&gt; closing through referencing in MRs is a pretty nice feature=E2=80=A6<b=
r>
<br>
If I had to list the pain points we have, this is not high on the list.<br>
<br>
&gt; &gt; &gt; * side-note on bitbake style/linting: It=E2=80=99s violating=
 PEP8 in a couple of<br>
&gt; &gt; &gt; ways and TBH PEP8 is the bare minimum I would accept these d=
ays for<br>
&gt; &gt; &gt; collaboration on projects the dimension of bitbake. So an ad=
ditional<br>
&gt; &gt; &gt; question: Would you be up for a PEP8 compatibility overhaul =
of the source<br>
&gt; &gt; &gt; code? I=E2=80=99d volunteer if I don=E2=80=99t have to send =
a patch via email ;)<br>
&gt; &gt; <br>
&gt; &gt; We&#39;re interested in patches to improve the coding style as lo=
ng as they<br>
&gt; &gt; don&#39;t<br>
&gt; &gt; break things like readability or performance.=C2=A0Which rules in=
 PEP8 in<br>
&gt; &gt; particular<br>
&gt; &gt; are you referring to?<br>
&gt; <br>
&gt; To name a few violations:<br>
&gt; <br>
&gt; =C2=A0* hanging indents<br>
&gt; =C2=A0* inconsistent indentation<br>
&gt; =C2=A0* 2 separating lines missing in between classes/top level method=
s<br>
<br>
FWIW I find it really hard to get worked up about whitespace issues. I<br>
appreciate these aren&#39;t always great to look at and I appreciate the fa=
miliarity<br>
argument and standardising the look but these aren&#39;t issues I would pri=
oritise.<br>
<br>
In particular changing them globally in mass patches tends to break patch<b=
r>
backporting and taking fixes back to older code which we do benefit from be=
ing<br>
able to do so there is a cost to doing it. We are trying to make new code m=
ore<br>
consistent and with older code, we do try and fix the worst issues.<br>
<br>
&gt; =C2=A0* unused imported modules<br>
&gt; =C2=A0* missing white-spaces after comma<br>
&gt; =C2=A0* unreachable codes<br>
<br>
These ones we do take patches for and try to fix when/where we see it. For<=
br>
example,=C2=A0<a href=3D"http://git.yoctoproject.org/cgit.cgi/poky/commit/?=
id=3D47e5c456a20432b511d830df9cbd4113a4352b2c" rel=3D"noreferrer" target=3D=
"_blank">http://git.yoctoproject.org/cgit.cgi/poky/commit/?id=3D47e5c456a20=
432b511<br>
d830df9cbd4113a4352b2c</a>=C2=A0contained a couple of white-space after com=
ma fixing<br>
while I was in that area.<br>
<br>
&gt; These are just a couple of examples that struck my PEP8 used eye from =
looking<br>
&gt; at two, three modules.<br>
&gt; <br>
&gt; It=E2=80=99s just like with any code smell: they don=E2=80=99t necessa=
rily break things. But<br>
&gt; they make maintenance, code-reviews and quality control harder than ne=
cessary.<br>
&gt; Code that does not at least follow PEP8 (and I actually strongly recom=
mend to<br>
&gt; go the extra mile with `black`) just looks odd and is unnecessary hard=
 to<br>
&gt; read. I=E2=80=99m surprised I have to argue for standards.<br>
<br>
I wasn&#39;t saying it was a bad thing, I asked which issues you noticed in=
<br>
particular since I&#39;m trying to ensure we do at least try and react to f=
eedback.<br>
Some whitespace issues we aren&#39;t likely to tackle, some like the others=
 you<br>
mentioned above we should fix.<br>
&gt; <br>
&gt; Besides that, some minor cleanup just to warm<br>
&gt; up:=C2=A0<a href=3D"https://github.com/openembedded/bitbake/pull/33" r=
el=3D"noreferrer" target=3D"_blank">https://github.com/openembedded/bitbake=
/pull/33</a>,=C2=A0<a href=3D"https://github.com/openem" rel=3D"noreferrer"=
 target=3D"_blank">https://github.com/openem</a><br>
&gt; bedded/bitbake/pull/32/files=C2=A0<br>
<br>
Those two do look like reasonable changes FWIW.<br>
<br>
&gt; (it was after these two that I found the comment in one of those old c=
ommits<br>
&gt; which made me open=C2=A0<a href=3D"https://github.com/openembedded/bit=
bake/pull/34" rel=3D"noreferrer" target=3D"_blank">https://github.com/opene=
mbedded/bitbake/pull/34</a>). At least<br>
&gt; there should be an=C2=A0automated reply to each MR that is posted if s=
omeone makes<br>
&gt; the effort to fix code and open a MRs that this is=C2=A0actually in ve=
in - That=E2=80=99s<br>
&gt; the=C2=A0mood that took me here :)<br>
<br>
There is a certain irony in that given you patched the section called<br>
&quot;Contributing&quot; in the README in 32!<br>
<br>
&gt; &gt; <br>
&gt; &gt; Help appreciated but email patches is how we accept them at the m=
oment.<br>
&gt; <br>
&gt; Not from me then :(<br>
<br>
Sorry to hear that, your changes in 32/33 do look reasonable.<br>
<br>
Cheers,<br>
<br>
Richard<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#12951): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/12951" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/12951</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/86911583/1686=
489" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/mt=
/86911583/1686489</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:alex.kanavin@gmail.com" target=3D"=
_blank">alex.kanavin@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div>

--000000000000d0890e05d0557cc3--

