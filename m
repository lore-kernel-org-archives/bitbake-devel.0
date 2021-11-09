Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73CC9C433EF
	for <webhook@archiver.kernel.org>; Tue,  9 Nov 2021 08:20:01 +0000 (UTC)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com
 [209.85.222.50])
 by mx.groups.io with SMTP id smtpd.web12.9361.1636445999826916943
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 09 Nov 2021 00:20:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=BbtJZY4X;
 spf=pass (domain: gmail.com, ip: 209.85.222.50,
 mailfrom: alex.kanavin@gmail.com)
Received: by mail-ua1-f50.google.com with SMTP id i6so36904802uae.6
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 09 Nov 2021 00:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xPcqiANlFb3SZ8EDL9T3DN4S8zWprT282SyXYXKa5BE=;
        b=BbtJZY4Xspku3N+t8if5Mym/vwnFAxvmGJF2GbPy211wv+Iq1UUEzPxM3kqvsOqF7r
         7UvdRQXinLQLx2Bo0WoHpOwuqFfWQmTG3HgiaGyWOVBd5PuJLS9Y6J64DObfxZFBeOwl
         l6zXJOpnpy08LJqXtVNNAMRC/nQA8rQxPFoRK9WkKdwXmt8jh7kBy/Xulk22rGy9coSM
         GwibHVKey1dEfwoPZ7gZHTnee9GineRgGz4LlurIJTXHc0ID351IqNYDglFwHm8/T4Ue
         a6N6uDAsjvd+oOFq1XRz1hWGmXomQQ1NfTfSRszQEr+1ApugamH8VYB/8BLgdOAmmJKE
         sD8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xPcqiANlFb3SZ8EDL9T3DN4S8zWprT282SyXYXKa5BE=;
        b=m/6wg9FPwgvXRiWC6G6TLe+LLqzxgO95bLv+/GYjAkAhespxTLGR8+AtMBP4UTTESL
         mAURa0Evj8Syv+5jTBRKroOikrUj5uwK0ju2qjfvUi6nl3Sk189HR6NTs9rCx9dPS1ac
         tETi1Oz3czkaY3q6J5qLU3qRXY7n2NFcglp0QarixmH6qgJwBEv9jvQOKUb9TktUvTw6
         RJHXPHcwK34Lz4QJyDDhzbiQiejYZugV/QpX21B5EAzC00KCn5q4qHEzhokV+4Hbi0iG
         2PwU3AHNTBydUUeFbxBLNdzkua6uY+ngIy30CVanPwxlKZ21sMEm5+hpDcggOSnbbvyc
         YrXw==
X-Gm-Message-State: AOAM530O3JPz2EVVbDJxRZitBvHAzBJ0ARkT7JGFKMUvIZtIujAdmW5X
	W9zQWtRwgUCD1yaoeGM8njAnbA3BoPQ4ikGejfA=
X-Google-Smtp-Source: 
 ABdhPJy+XRTIgfbN3uqgPUciTVYGpBoTtaGMQSTjnM716hVqq5svR7zcWb4ZzoH6FFbi7vZTE89qJVE0QBXpRt1TTFY=
X-Received: by 2002:a67:ca8f:: with SMTP id a15mr61187539vsl.18.1636445998914;
 Tue, 09 Nov 2021 00:19:58 -0800 (PST)
MIME-Version: 1.0
References: 
 <CAMaS9hNh8iztUquiPddua-6Lu0nLzU832YwHG+rw284zqUzEZQ@mail.gmail.com>
 <CAMaS9hPB=273mfQ4eZp32tsy3DrsqX3x0sKmxSaZ2CbsvaYYxA@mail.gmail.com>
 <d5683f0ad0dd0185309d5d8feea6c7e7141fa343.camel@linuxfoundation.org>
 <CAMaS9hNpp9QsUqkpXvNj_F5R4aQoe+qHg+_mtxnZRL0PoAYaGw@mail.gmail.com>
 <589e9863e78ed9f8234a3756b37ffb979daa770c.camel@linuxfoundation.org>
 <CANNYZj8_zPhh_XCZrxaPvXd_Oz5kzbzHNLvT6qzvtztquKA0ew@mail.gmail.com>
 <CAMaS9hO8yU+T3tKb-dQj-DFx-vqGsUTLc7Jkta1sAM+eDr45BA@mail.gmail.com>
In-Reply-To: 
 <CAMaS9hO8yU+T3tKb-dQj-DFx-vqGsUTLc7Jkta1sAM+eDr45BA@mail.gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 9 Nov 2021 09:19:47 +0100
Message-ID: 
 <CANNYZj9G7YaHpQgCzVZaCjTTAmNXgEiGnkf-GyrXzbxckqp4oA@mail.gmail.com>
Subject: Re: [bitbake-devel] bitbake style/workflow
To: Marius Kriegerowski <marius.kriegerowski@gmail.com>
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="000000000000759e9705d056c691"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 09 Nov 2021 08:20:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12955

--000000000000759e9705d056c691
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I think you misunderstood me too. It's about the github UI which does its
best to hide the commit messages, and doesn't allow to comment on their
content. Yes you can contort yourself and still do it, but the tools do not
help.

Alex

On Tue, 9 Nov 2021 at 09:05, Marius Kriegerowski <
marius.kriegerowski@gmail.com> wrote:

> Good morning,
>
> I don=E2=80=99t think this is correct. You can change the git history and=
 commit
> messages of every MR to whatever you like with `git commit =E2=80=94amend=
`, `git
> rebase -I` and `git push -f`. So, you can very well ask contributors to
> cleanup their history before merging.
>
> Best
> Marius
>
> Am Di., 9. Nov. 2021 um 07:47 Uhr schrieb Alexander Kanavin <
> alex.kanavin@gmail.com>:
>
>> There's another problem with github/gitlab which I find significant.
>> These tools do not allow reviewing commit messages, and don't even make =
it
>> easy to see them. So the developers using those tools, both submitters a=
nd
>> maintainers, are effectively being conditioned by the tools to see good
>> commit messages as superfluous and unnecessary. And so you more often th=
an
>> not end up with poorly written commit history in github projects, or, if
>> you're a reviewer, have to repeatedly explain to the submitter how to
>> explain and structure their changes properly.
>>
>> I'd rather not have a change, than have a change that no one, even the
>> original author, can understand or remember the reasons for one year dow=
n
>> the line.
>>
>> Alex
>>
>>
>> On Tue, 9 Nov 2021 at 00:30, Richard Purdie <
>> richard.purdie@linuxfoundation.org> wrote:
>>
>>> On Mon, 2021-11-08 at 23:44 +0100, Marius Kriegerowski wrote:
>>> >
>>> >
>>> > > On 8. Nov 2021, at 22:47, Richard Purdie
>>> > > <richard.purdie@linuxfoundation.org> wrote:
>>> > >
>>> > > On Mon, 2021-11-08 at 18:37 +0100, Marius Kriegerowski wrote:
>>> > > > Is there a plan to switch to some more modern ways to collaborate
>>> on
>>> > > > bitbake,
>>> > > > you know, like, gitlab/github/gitea with issues, PRs and so forth=
?
>>> I mean=E2=80=A6
>>> > > > it=E2=80=99s
>>> > > > late 2021 and sending MRs/Issues via email feels reaaaally
>>> outdated, slow,
>>> > > > intransparent, ineffective (how to you do reviews, code
>>> comparisons during
>>> > > > reviews, insert suggestions, etc.) and indirect (where is the CI
>>> pipeline
>>> > > > that I
>>> > > > trigger when pushing something somewhere?).
>>> > >
>>> > > There are pros and cons to switching to something else. Keep in min=
d
>>> that
>>> > > whilst the github workflow works well for a single maintainer of a
>>> project,
>>> > > it does not work well for diverse review.
>>> >
>>> > I strongly disagree with that. Reviews can equally well be done in a =
MR
>>> > thread. That=E2=80=99s what they are there for. You can discuss thing=
s there
>>> with as
>>> > many people as you want and can e.g. define a minimum number of
>>> approvals
>>> > before a MR can be merged.
>>>
>>> You misunderstand my point. We have a several thousand people on the
>>> mailing
>>> lists and they filter things to what interests them. *I* have no people
>>> I want
>>> to discuss a given change with, it is a question of whether the people
>>> who have
>>> an interest in a given change would see it.
>>>
>>> A minimum number of approvals is utterly meaningless for how we work, I
>>> need the
>>> interested people to see it and that varies massively depending on what
>>> is being
>>> changed. It is this aspect of mailing list change distribution and
>>> discussion we
>>> benefit from.
>>>
>>> >  It also naturally groups discussions. You can address experts for
>>> specific
>>> > domains which means less noise for the experts. I really don=E2=80=99=
t see why
>>> mailing
>>> > list reviews should work any better here.
>>>
>>> We all have established mechanisms to "see" the things which interest u=
s
>>> as
>>> maintainers?
>>>
>>> Please don't misunderstand me, I do see the attraction of github from
>>> your
>>> perspective. It would just destroy the ecosystem we already have. You a=
re
>>> basically saying that our current ecosystem is worthless but I would
>>> point out
>>> it has resulted in a project which you did say you appreciate so it
>>> can't be all
>>> bad.
>>>
>>> >  If google can coordinate 2.1k repos with 1.1k contributors over
>>> GitHub, why
>>> > should that not work for openembedded??
>>>
>>> It isn't about raw numbers, it is about numbers of reviewers for a give=
n
>>> change.
>>> We have hundreds of people doing that using the mailing lists.
>>>
>>> > > The Bitbake case is a little bit different but in general we'd
>>> follow what
>>> > > OE/Yocto Project are doing.
>>> > >
>>> > > We have discussed changing and it is listed as one topic on:
>>> > > https://wiki.yoctoproject.org/wiki/Future_Directions
>>> > > (Code Submission process)
>>> > >
>>> > > I'd note that it is a huge change to our current developers and mos=
t
>>> of us
>>> > > are very used to the mailing lists so if we did change, it would
>>> allow
>>> > > potential new collaborators at the risk of losing people with key
>>> > > knowledge/experience.
>>> > =E2=80=A6 which reads to me like: =E2=80=9CIt has always been that wa=
y so we will not
>>> change
>>> > that" doesn=E2=80=99t it? Always a very poor argument.
>>>
>>> No, what I said is "upsetting our existing developers is something whic=
h
>>> we may
>>> want to potentially avoid".
>>>
>>> There are some options out there which have offered mailing list
>>> integration for
>>> example and we have tried to explore those. Something which drops the
>>> lists
>>> entirely could in the current view of the TSC result in loss of too man=
y
>>> of our
>>> existing maintainers.
>>>
>>> >
>>> > > We do have CI which is shared with Yocto Project and
>>> > > OpenEmbedded. You can see it here:
>>> > >
>>> > > https://autobuilder.yoctoproject.org/typhoon/#/console
>>> > >
>>> > > and it has it's own manual which was recently added to our
>>> documentations
>>> > > set:
>>> > >
>>> > > http://docs.yoctoproject.org/test-manual/index.html
>>> > =E2=80=A6 stressing my point: Why does the location of the CI need
>>> documentation? All
>>> > of the aforementioned platforms smoothly integrate with multiple CI
>>> solutions,
>>> > drastically reducing the time required for reviews if the pipeline
>>> provides
>>> > automated feedback to the contributor. It would probably cost me abou=
t
>>> one
>>> > afternoon to setup a decent CI pipeline at least for all python codes
>>> pushing
>>> > the need to review from manual labor to automated tools. If open
>>> embedded
>>> > migrates to a proper git platform I happily volunteer on that end!!
>>>
>>> We're not talking about simple python code. We're talking about testing
>>> a build
>>> environment which cross compiles multiple operating systems for multipl=
e
>>> architectures, C libraries, GUI stacks, init systems and so on. Testing
>>> the
>>> python code is one small part of that. I've spent several years trying =
to
>>> improve and get our CI to where it is today.
>>>
>>> Yes, the python code is tested as part of this as we don't really want
>>> to have
>>> multiple test platforms and the real world usage is some of the best
>>> testing
>>> changes can have.
>>>
>>> > > There is work still needed on that but it is a start. One challenge
>>> of
>>> > > bitbake/OE is that the builds take an age and the test matrix is
>>> huge so the
>>> > > CI
>>> > > process isn't quite as simple as some other simpler projects.
>>> > At least for python I bet that most bugs can be caught simply by
>>> firing up
>>> > `black`, `flake8`, `pylint` (and a hand full of other tools) just to
>>> check the
>>> > modified files.
>>>
>>> Well, I would bet that most of our bugs are not caused by issues like
>>> that. I do
>>> attend the weekly bug triage meetings and have fixed my share of them.
>>> You could
>>> have a look at the issues filed in bugzilla over the past few weeks if
>>> you'd
>>> like to see the kinds of issues that get filed and are open.
>>>
>>> >  Regarding meta-layers and recipes out there we are currently pushing
>>> forward
>>> > with a linter for bitbake recipes (thanks @priv-kweihmann for this
>>> awesome and
>>> > overdue tool!!!).
>>>
>>> Whilst improving recipes in that way does help, it isn't the main sourc=
e
>>> of our
>>> major issues.
>>>
>>> > >
>>> > > As a shortcut through things, the "bitbake-selftest" command within
>>> bitbake
>>> > > may
>>> > > be one thing you're looking for which does simple tests on bitbake.
>>> It isn't
>>> > > complete coverage and we welcome more being added, it is a start an=
d
>>> some
>>> > > areas
>>> > > of the code are covered better than others.
>>> > I=E2=80=99d love to overhaul the tests e.g. porting them to `pytest` =
which
>>> offers a
>>> > much simpler yet much more powerful API/plugin-ecosystem. But won=E2=
=80=99t do
>>> via
>>> > email :)
>>>
>>> The tests are written in python's own unittest.
>>>
>>> > > Issues are filed in the project bugzilla and are actively worked on=
:
>>> > >
>>> > > https://bugzilla.yoctoproject.org/
>>> > Didn=E2=80=99t know that. But why keeping issues separate from MRs? A=
utomatic
>>> issue
>>> > closing through referencing in MRs is a pretty nice feature=E2=80=A6
>>>
>>> If I had to list the pain points we have, this is not high on the list.
>>>
>>> > > > * side-note on bitbake style/linting: It=E2=80=99s violating PEP8=
 in a
>>> couple of
>>> > > > ways and TBH PEP8 is the bare minimum I would accept these days f=
or
>>> > > > collaboration on projects the dimension of bitbake. So an
>>> additional
>>> > > > question: Would you be up for a PEP8 compatibility overhaul of th=
e
>>> source
>>> > > > code? I=E2=80=99d volunteer if I don=E2=80=99t have to send a pat=
ch via email ;)
>>> > >
>>> > > We're interested in patches to improve the coding style as long as
>>> they
>>> > > don't
>>> > > break things like readability or performance. Which rules in PEP8 i=
n
>>> > > particular
>>> > > are you referring to?
>>> >
>>> > To name a few violations:
>>> >
>>> >  * hanging indents
>>> >  * inconsistent indentation
>>> >  * 2 separating lines missing in between classes/top level methods
>>>
>>> FWIW I find it really hard to get worked up about whitespace issues. I
>>> appreciate these aren't always great to look at and I appreciate the
>>> familiarity
>>> argument and standardising the look but these aren't issues I would
>>> prioritise.
>>>
>>> In particular changing them globally in mass patches tends to break pat=
ch
>>> backporting and taking fixes back to older code which we do benefit fro=
m
>>> being
>>> able to do so there is a cost to doing it. We are trying to make new
>>> code more
>>> consistent and with older code, we do try and fix the worst issues.
>>>
>>> >  * unused imported modules
>>> >  * missing white-spaces after comma
>>> >  * unreachable codes
>>>
>>> These ones we do take patches for and try to fix when/where we see it.
>>> For
>>> example,
>>> http://git.yoctoproject.org/cgit.cgi/poky/commit/?id=3D47e5c456a20432b5=
11
>>> d830df9cbd4113a4352b2c
>>> <http://git.yoctoproject.org/cgit.cgi/poky/commit/?id=3D47e5c456a20432b=
511d830df9cbd4113a4352b2c> contained
>>> a couple of white-space after comma fixing
>>> while I was in that area.
>>>
>>> > These are just a couple of examples that struck my PEP8 used eye from
>>> looking
>>> > at two, three modules.
>>> >
>>> > It=E2=80=99s just like with any code smell: they don=E2=80=99t necess=
arily break
>>> things. But
>>> > they make maintenance, code-reviews and quality control harder than
>>> necessary.
>>> > Code that does not at least follow PEP8 (and I actually strongly
>>> recommend to
>>> > go the extra mile with `black`) just looks odd and is unnecessary har=
d
>>> to
>>> > read. I=E2=80=99m surprised I have to argue for standards.
>>>
>>> I wasn't saying it was a bad thing, I asked which issues you noticed in
>>> particular since I'm trying to ensure we do at least try and react to
>>> feedback.
>>> Some whitespace issues we aren't likely to tackle, some like the others
>>> you
>>> mentioned above we should fix.
>>> >
>>> > Besides that, some minor cleanup just to warm
>>> > up: https://github.com/openembedded/bitbake/pull/33,
>>> https://github.com/openem
>>> > bedded/bitbake/pull/32/files
>>>
>>> Those two do look like reasonable changes FWIW.
>>>
>>> > (it was after these two that I found the comment in one of those old
>>> commits
>>> > which made me open https://github.com/openembedded/bitbake/pull/34).
>>> At least
>>> > there should be an automated reply to each MR that is posted if
>>> someone makes
>>> > the effort to fix code and open a MRs that this is actually in vein -
>>> That=E2=80=99s
>>> > the mood that took me here :)
>>>
>>> There is a certain irony in that given you patched the section called
>>> "Contributing" in the README in 32!
>>>
>>> > >
>>> > > Help appreciated but email patches is how we accept them at the
>>> moment.
>>> >
>>> > Not from me then :(
>>>
>>> Sorry to hear that, your changes in 32/33 do look reasonable.
>>>
>>> Cheers,
>>>
>>> Richard
>>>
>>>
>>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>>> Links: You receive all messages sent to this group.
>>> View/Reply Online (#12951):
>>> https://lists.openembedded.org/g/bitbake-devel/message/12951
>>> Mute This Topic: https://lists.openembedded.org/mt/86911583/1686489
>>> Group Owner: bitbake-devel+owner@lists.openembedded.org
>>> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
>>> alex.kanavin@gmail.com]
>>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>>>
>>>

--000000000000759e9705d056c691
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>I think you misunderstood me too. It&#39;s about the =
github UI which does its best to hide the commit messages, and doesn&#39;t =
allow to comment on their content. Yes you can contort yourself and still d=
o it, but the tools do not help.</div><div><br></div><div>Alex<br></div></d=
iv><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On =
Tue, 9 Nov 2021 at 09:05, Marius Kriegerowski &lt;<a href=3D"mailto:marius.=
kriegerowski@gmail.com">marius.kriegerowski@gmail.com</a>&gt; wrote:<br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div =
style=3D"color:rgb(0,0,0);font-family:Helvetica;font-size:12px;font-style:n=
ormal;font-variant-caps:normal;font-weight:normal;letter-spacing:normal;tex=
t-align:start;text-indent:0px;text-transform:none;white-space:normal;word-s=
pacing:0px;text-decoration:none">Good morning,</div><div style=3D"color:rgb=
(0,0,0);font-family:Helvetica;font-size:12px;font-style:normal;font-variant=
-caps:normal;font-weight:normal;letter-spacing:normal;text-align:start;text=
-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;text-de=
coration:none"><br></div><div style=3D"color:rgb(0,0,0);font-family:Helveti=
ca;font-size:12px;font-style:normal;font-variant-caps:normal;font-weight:no=
rmal;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:=
none;white-space:normal;word-spacing:0px;text-decoration:none">I don=E2=80=
=99t think this is correct. You can change the git history and commit messa=
ges of every MR to whatever you like with `git commit =E2=80=94amend`, `git=
 rebase -I` and `git push -f`. So, you can very well ask contributors to cl=
eanup their history before merging.</div><div style=3D"color:rgb(0,0,0);fon=
t-family:Helvetica;font-size:12px;font-style:normal;font-variant-caps:norma=
l;font-weight:normal;letter-spacing:normal;text-align:start;text-indent:0px=
;text-transform:none;white-space:normal;word-spacing:0px;text-decoration:no=
ne"><br></div><div style=3D"color:rgb(0,0,0);font-family:Helvetica;font-siz=
e:12px;font-style:normal;font-variant-caps:normal;font-weight:normal;letter=
-spacing:normal;text-align:start;text-indent:0px;text-transform:none;white-=
space:normal;word-spacing:0px;text-decoration:none">Best</div><div style=3D=
"color:rgb(0,0,0);font-family:Helvetica;font-size:12px;font-style:normal;fo=
nt-variant-caps:normal;font-weight:normal;letter-spacing:normal;text-align:=
start;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0=
px;text-decoration:none">Marius</div></div><br><div class=3D"gmail_quote"><=
div dir=3D"ltr" class=3D"gmail_attr">Am Di., 9. Nov. 2021 um 07:47=C2=A0Uhr=
 schrieb Alexander Kanavin &lt;<a href=3D"mailto:alex.kanavin@gmail.com" ta=
rget=3D"_blank">alex.kanavin@gmail.com</a>&gt;:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div>There&#39;s another =
problem with github/gitlab which I find significant. These tools do not all=
ow reviewing commit messages, and don&#39;t even make it easy to see them. =
So the developers using those tools, both submitters and maintainers, are e=
ffectively being conditioned by the tools to see good commit messages as su=
perfluous and unnecessary. And so you more often than not end up with poorl=
y written commit history in github projects, or, if you&#39;re a reviewer, =
have to repeatedly explain to the submitter how to explain and structure th=
eir changes properly.</div><div><br></div><div>I&#39;d rather not have a ch=
ange, than have a change that no one, even the original author, can underst=
and or remember the reasons for one year down the line.</div><div><br></div=
><div>Alex<br></div><br></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Tue, 9 Nov 2021 at 00:30, Richard Purdie &lt;<a =
href=3D"mailto:richard.purdie@linuxfoundation.org" target=3D"_blank">richar=
d.purdie@linuxfoundation.org</a>&gt; wrote:<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">On Mon, 2021-11-08 at 23:44 +0100, Marius Krieg=
erowski wrote:<br>
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
</blockquote></div>
</blockquote></div>

--000000000000759e9705d056c691--

