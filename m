Return-Path: <marius.kriegerowski@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D66C433EF
	for <webhook@archiver.kernel.org>; Tue,  9 Nov 2021 09:28:57 +0000 (UTC)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com
 [209.85.208.43])
 by mx.groups.io with SMTP id smtpd.web12.9936.1636450136718007432
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 09 Nov 2021 01:28:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=e+EGrOxK;
 spf=pass (domain: gmail.com, ip: 209.85.208.43,
 mailfrom: marius.kriegerowski@gmail.com)
Received: by mail-ed1-f43.google.com with SMTP id f8so74210720edy.4
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 09 Nov 2021 01:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EDsrWdeqJOG9FcTo80X0/ulqBBbvpRoDTICiARANUYw=;
        b=e+EGrOxKfoJD2aQ2wOfL3ywMZdcNDgLYIj6Qa5tGM+HWB2v3I9Z+/khsAY19+uznPS
         4THNV8UIYr3mf4uSAG+jOnHLMdT+Ufo75OtNoEW9tX/bEQxzLTHttqoy/7igBdg9jvZ8
         hG9Vf9bK6XA6PRWDsHfn+7qEQj/fxpe9jcEMA7rflxiNYopMa+qgEYeIzGB0CGek77lF
         ATg51NnCCaXlNc4N8rg0AcSVb7sdUm+dOydDXPFymi4z43/fjSOPN9W5rUJlaOXay0YF
         ns25xOGAiXqd+fIN/VdpnBe8UMDn6yFyEGaKyl4yUA4t8RCKmkmaw/XVNhVB43XPMh4V
         ZYCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EDsrWdeqJOG9FcTo80X0/ulqBBbvpRoDTICiARANUYw=;
        b=Ck0PcZu5GjGO6JLvPfiVJjhnstfURAK7a9mnitkjVjI003Cxm84HrmXtpeejLduLu8
         05jzkFvlUOzlCHaynbn/P9uA8zIlTfDcUWeHXXkSPfKtqzy6eT7LLinCQromAmMU23Qk
         o798aPh1pwVXoiJ3/a3DQDcy4sAYF1slYRSpnFt20weJKyM7ZAdZDyFe3fex1IHp91Lv
         /uzbk+HqAg+IV4J5EjRzjPql3sPyFYqYhVwRmnBKUtagurGw5IFa2mJjVZiXkZSM4G6I
         0xdgQ9CA2Ij4hHXs2xb8Lq1LaMjujY2R5CkykeP5Uk0mprU2NmmktE2uUBXb9Eb4DpPD
         gLUA==
X-Gm-Message-State: AOAM531Qc8JhYDLPbKQN8b3pxqJlbC1Z9Cfrs7EZD3TV8BZye649ddPn
	0G2XT054fvWpqLzO1FOpo3Szf5lmAGXQIV/3BpY=
X-Google-Smtp-Source: 
 ABdhPJw3qXY0JihJyNyZuwuHpHU3BaeOme/dKctZUq0FYFJPwaszMBQUbjZKgsTSnfwvaN+dUIM9HEXmd/P2DDFyxtc=
X-Received: by 2002:a05:6402:d0a:: with SMTP id
 eb10mr8164804edb.186.1636450134776;
 Tue, 09 Nov 2021 01:28:54 -0800 (PST)
MIME-Version: 1.0
References: 
 <CAMaS9hNh8iztUquiPddua-6Lu0nLzU832YwHG+rw284zqUzEZQ@mail.gmail.com>
 <CAMaS9hPB=273mfQ4eZp32tsy3DrsqX3x0sKmxSaZ2CbsvaYYxA@mail.gmail.com>
 <d5683f0ad0dd0185309d5d8feea6c7e7141fa343.camel@linuxfoundation.org>
 <CAMaS9hNpp9QsUqkpXvNj_F5R4aQoe+qHg+_mtxnZRL0PoAYaGw@mail.gmail.com>
 <589e9863e78ed9f8234a3756b37ffb979daa770c.camel@linuxfoundation.org>
 <CANNYZj8_zPhh_XCZrxaPvXd_Oz5kzbzHNLvT6qzvtztquKA0ew@mail.gmail.com>
 <CAMaS9hO8yU+T3tKb-dQj-DFx-vqGsUTLc7Jkta1sAM+eDr45BA@mail.gmail.com>
 <CANNYZj9G7YaHpQgCzVZaCjTTAmNXgEiGnkf-GyrXzbxckqp4oA@mail.gmail.com>
 <CAMaS9hNwT5iK8X3NKAq6cJq1qk4mHS99a36kTogc6_=fDHALFA@mail.gmail.com>
 <YYo2KsoUeMTZ6y5C@korppu> <16B5D5AA827DA237.27841@lists.openembedded.org>
In-Reply-To: <16B5D5AA827DA237.27841@lists.openembedded.org>
From: Marius Kriegerowski <marius.kriegerowski@gmail.com>
Date: Tue, 9 Nov 2021 10:28:43 +0100
Message-ID: 
 <CAMaS9hOSw5LrxJ60cFnvpk+vOL19jyNRZrpbEf=x4t+cJStWYA@mail.gmail.com>
Subject: Re: [bitbake-devel] bitbake style/workflow
To: Marius Kriegerowski <marius.kriegerowski@gmail.com>
Cc: Mikko.Rapeli@bmw.de, Alexander Kanavin <alex.kanavin@gmail.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="000000000000f9df2305d057bc6a"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 09 Nov 2021 09:28:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12960

--000000000000f9df2305d057bc6a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

So, I'd like to come to a conclusing with this time consuming thread:

I shared my view which I'm sure many early contributors share. There is a
lot of resentment in this developer community against changing the workflow
(which dates back more than a decade) - which I understand. I still think
that the inconvenience when commenting on a commit message (that was the
only drawback I found legit) does not outweigh the benefits of discussing
MRs on one of the platforms mentioned. We disagree on that.

I'm keen on adding contributions not only to `meta-openembedded` (which
uses github - thanks for that) but also to `bitbake`. So, I'll surrender
and send a patch via email. Maybe. One day.

Have a good day
Marius

Am Di., 9. Nov. 2021 um 10:09 Uhr schrieb Marius Kriegerowski via
lists.openembedded.org <marius.kriegerowski=3Dgmail.com@lists.openembedded.=
org
>:

>
>
> On 9. Nov 2021, at 09:44, Alexander Kanavin <alex.kanavin@gmail.com>
> wrote:
>
> On Tue, 9 Nov 2021 at 09:32, Marius Kriegerowski <
> marius.kriegerowski@gmail.com> wrote:
>
>> I see.
>>
>> On 9. Nov 2021, at 09:19, Alexander Kanavin <alex.kanavin@gmail.com>
>> wrote:
>>
>> I think you misunderstood me too. It's about the github UI which does it=
s
>> best to hide the commit messages, and doesn't allow to comment on their
>> content. Yes you can contort yourself and still do it, but the tools do =
not
>> help.
>>
>>
>> I never felt that the commit messages are really that hidden. I mean=E2=
=80=A6 you
>> find them under `commits`... I find that pretty transparent. You can
>> comment on the commit message content in the thread of the MR, just as y=
ou
>> would in an email thread, can't you?
>>
>
> No. You need to separately go to the commits tab, open each commit
> individually to see both the message and the associated code, then if
> there's something you do not like, you need to copy paste the offending b=
it
> and open a MR thread with it. That's not helpful, and it's clear that kin=
d
> of thing is not important to the tool providers or users. But it is very
> important to me as one of the oe-core maintainers.
>
>
>
>
>
>
>> Also, the older and closed threads can be very helpful when searching fo=
r
>> answers why something has been changed in which way. I know that I saw t=
he
>> email threads on patches as well but found them super hard to read (no
>> syntax highlighting, all black and white, =E2=80=A6). Well, probably I c=
ould get
>> used to reading them over time. But then =E2=80=94 why should I if there=
 are things
>> like collapsable threads, syntax highlight, color,=E2=80=A6?
>>
>
> You can find a better email client perhaps?
>
>
> Not sure I was clear about what I meant: I was speaking about the closed
> threads (https://lists.openembedded.org/g/openembedded-core). Is it
> somehow sortable by open MRs/closed MRs/pure text/issues?
>
> So, which email client would I have to install to get a better user
> experience? What about the other features that make me use the email clie=
nt
> because of which I which Iike to use that client? Do you expect me to dum=
p
> them those features and my workflow routines in favour of just
> openembedded?! Should I have two email clients then? And then hard-copy t=
he
> old mail threads to my HD from how many years?
>
> BTW: I just went for the first time to the online thread:
> https://lists.openembedded.org/g/bitbake-devel/topic/86911583
> I would probably stop reading that monstrous thread after few seconds.
>
> So, to move forward: Maybe you can improve the online threads so that it=
=E2=80=99s
> easier to navigate and read those pure retro-black-and-white threads.
>
> Marius
>
>
>
> PS I=E2=80=99d like to emphasise again:
> I know I sound harsh. I=E2=80=99m not blaming here and of course I=E2=80=
=99m also not
> belittling the workflow neither the proficiency of the contributors. I=E2=
=80=99m
> totally aware that most regular contributors here are extremely highly
> skilled and work on an incredibly impactful set of software. I=E2=80=99m =
just
> providing a very detailed feedback of what I as a really really really
> really hard wanting-to-become future contributor see what really keeps me
> from joining.
>
>
>
> Alex
>
>
>>
>> Best
>> Marius
>>
>>
>> Alex
>>
>> On Tue, 9 Nov 2021 at 09:05, Marius Kriegerowski <
>> marius.kriegerowski@gmail.com> wrote:
>>
>>> Good morning,
>>>
>>> I don=E2=80=99t think this is correct. You can change the git history a=
nd commit
>>> messages of every MR to whatever you like with `git commit =E2=80=94ame=
nd`, `git
>>> rebase -I` and `git push -f`. So, you can very well ask contributors to
>>> cleanup their history before merging.
>>>
>>> Best
>>> Marius
>>>
>>> Am Di., 9. Nov. 2021 um 07:47 Uhr schrieb Alexander Kanavin <
>>> alex.kanavin@gmail.com>:
>>>
>>>> There's another problem with github/gitlab which I find significant.
>>>> These tools do not allow reviewing commit messages, and don't even mak=
e it
>>>> easy to see them. So the developers using those tools, both submitters=
 and
>>>> maintainers, are effectively being conditioned by the tools to see goo=
d
>>>> commit messages as superfluous and unnecessary. And so you more often =
than
>>>> not end up with poorly written commit history in github projects, or, =
if
>>>> you're a reviewer, have to repeatedly explain to the submitter how to
>>>> explain and structure their changes properly.
>>>>
>>>> I'd rather not have a change, than have a change that no one, even the
>>>> original author, can understand or remember the reasons for one year d=
own
>>>> the line.
>>>>
>>>> Alex
>>>>
>>>>
>>>> On Tue, 9 Nov 2021 at 00:30, Richard Purdie <
>>>> richard.purdie@linuxfoundation.org> wrote:
>>>>
>>>>> On Mon, 2021-11-08 at 23:44 +0100, Marius Kriegerowski wrote:
>>>>> >
>>>>> >
>>>>> > > On 8. Nov 2021, at 22:47, Richard Purdie
>>>>> > > <richard.purdie@linuxfoundation.org> wrote:
>>>>> > >
>>>>> > > On Mon, 2021-11-08 at 18:37 +0100, Marius Kriegerowski wrote:
>>>>> > > > Is there a plan to switch to some more modern ways to
>>>>> collaborate on
>>>>> > > > bitbake,
>>>>> > > > you know, like, gitlab/github/gitea with issues, PRs and so
>>>>> forth? I mean=E2=80=A6
>>>>> > > > it=E2=80=99s
>>>>> > > > late 2021 and sending MRs/Issues via email feels reaaaally
>>>>> outdated, slow,
>>>>> > > > intransparent, ineffective (how to you do reviews, code
>>>>> comparisons during
>>>>> > > > reviews, insert suggestions, etc.) and indirect (where is the C=
I
>>>>> pipeline
>>>>> > > > that I
>>>>> > > > trigger when pushing something somewhere?).
>>>>> > >
>>>>> > > There are pros and cons to switching to something else. Keep in
>>>>> mind that
>>>>> > > whilst the github workflow works well for a single maintainer of =
a
>>>>> project,
>>>>> > > it does not work well for diverse review.
>>>>> >
>>>>> > I strongly disagree with that. Reviews can equally well be done in =
a
>>>>> MR
>>>>> > thread. That=E2=80=99s what they are there for. You can discuss thi=
ngs there
>>>>> with as
>>>>> > many people as you want and can e.g. define a minimum number of
>>>>> approvals
>>>>> > before a MR can be merged.
>>>>>
>>>>> You misunderstand my point. We have a several thousand people on the
>>>>> mailing
>>>>> lists and they filter things to what interests them. *I* have no
>>>>> people I want
>>>>> to discuss a given change with, it is a question of whether the peopl=
e
>>>>> who have
>>>>> an interest in a given change would see it.
>>>>>
>>>>> A minimum number of approvals is utterly meaningless for how we work,
>>>>> I need the
>>>>> interested people to see it and that varies massively depending on
>>>>> what is being
>>>>> changed. It is this aspect of mailing list change distribution and
>>>>> discussion we
>>>>> benefit from.
>>>>>
>>>>> >  It also naturally groups discussions. You can address experts for
>>>>> specific
>>>>> > domains which means less noise for the experts. I really don=E2=80=
=99t see
>>>>> why mailing
>>>>> > list reviews should work any better here.
>>>>>
>>>>> We all have established mechanisms to "see" the things which interest
>>>>> us as
>>>>> maintainers?
>>>>>
>>>>> Please don't misunderstand me, I do see the attraction of github from
>>>>> your
>>>>> perspective. It would just destroy the ecosystem we already have. You
>>>>> are
>>>>> basically saying that our current ecosystem is worthless but I would
>>>>> point out
>>>>> it has resulted in a project which you did say you appreciate so it
>>>>> can't be all
>>>>> bad.
>>>>>
>>>>> >  If google can coordinate 2.1k repos with 1.1k contributors over
>>>>> GitHub, why
>>>>> > should that not work for openembedded??
>>>>>
>>>>> It isn't about raw numbers, it is about numbers of reviewers for a
>>>>> given change.
>>>>> We have hundreds of people doing that using the mailing lists.
>>>>>
>>>>> > > The Bitbake case is a little bit different but in general we'd
>>>>> follow what
>>>>> > > OE/Yocto Project are doing.
>>>>> > >
>>>>> > > We have discussed changing and it is listed as one topic on:
>>>>> > > https://wiki.yoctoproject.org/wiki/Future_Directions
>>>>> > > (Code Submission process)
>>>>> > >
>>>>> > > I'd note that it is a huge change to our current developers and
>>>>> most of us
>>>>> > > are very used to the mailing lists so if we did change, it would
>>>>> allow
>>>>> > > potential new collaborators at the risk of losing people with key
>>>>> > > knowledge/experience.
>>>>> > =E2=80=A6 which reads to me like: =E2=80=9CIt has always been that =
way so we will
>>>>> not change
>>>>> > that" doesn=E2=80=99t it? Always a very poor argument.
>>>>>
>>>>> No, what I said is "upsetting our existing developers is something
>>>>> which we may
>>>>> want to potentially avoid".
>>>>>
>>>>> There are some options out there which have offered mailing list
>>>>> integration for
>>>>> example and we have tried to explore those. Something which drops the
>>>>> lists
>>>>> entirely could in the current view of the TSC result in loss of too
>>>>> many of our
>>>>> existing maintainers.
>>>>>
>>>>> >
>>>>> > > We do have CI which is shared with Yocto Project and
>>>>> > > OpenEmbedded. You can see it here:
>>>>> > >
>>>>> > > https://autobuilder.yoctoproject.org/typhoon/#/console
>>>>> > >
>>>>> > > and it has it's own manual which was recently added to our
>>>>> documentations
>>>>> > > set:
>>>>> > >
>>>>> > > http://docs.yoctoproject.org/test-manual/index.html
>>>>> > =E2=80=A6 stressing my point: Why does the location of the CI need
>>>>> documentation? All
>>>>> > of the aforementioned platforms smoothly integrate with multiple CI
>>>>> solutions,
>>>>> > drastically reducing the time required for reviews if the pipeline
>>>>> provides
>>>>> > automated feedback to the contributor. It would probably cost me
>>>>> about one
>>>>> > afternoon to setup a decent CI pipeline at least for all python
>>>>> codes pushing
>>>>> > the need to review from manual labor to automated tools. If open
>>>>> embedded
>>>>> > migrates to a proper git platform I happily volunteer on that end!!
>>>>>
>>>>> We're not talking about simple python code. We're talking about
>>>>> testing a build
>>>>> environment which cross compiles multiple operating systems for
>>>>> multiple
>>>>> architectures, C libraries, GUI stacks, init systems and so on.
>>>>> Testing the
>>>>> python code is one small part of that. I've spent several years tryin=
g
>>>>> to
>>>>> improve and get our CI to where it is today.
>>>>>
>>>>> Yes, the python code is tested as part of this as we don't really wan=
t
>>>>> to have
>>>>> multiple test platforms and the real world usage is some of the best
>>>>> testing
>>>>> changes can have.
>>>>>
>>>>> > > There is work still needed on that but it is a start. One
>>>>> challenge of
>>>>> > > bitbake/OE is that the builds take an age and the test matrix is
>>>>> huge so the
>>>>> > > CI
>>>>> > > process isn't quite as simple as some other simpler projects.
>>>>> > At least for python I bet that most bugs can be caught simply by
>>>>> firing up
>>>>> > `black`, `flake8`, `pylint` (and a hand full of other tools) just t=
o
>>>>> check the
>>>>> > modified files.
>>>>>
>>>>> Well, I would bet that most of our bugs are not caused by issues like
>>>>> that. I do
>>>>> attend the weekly bug triage meetings and have fixed my share of them=
.
>>>>> You could
>>>>> have a look at the issues filed in bugzilla over the past few weeks i=
f
>>>>> you'd
>>>>> like to see the kinds of issues that get filed and are open.
>>>>>
>>>>> >  Regarding meta-layers and recipes out there we are currently
>>>>> pushing forward
>>>>> > with a linter for bitbake recipes (thanks @priv-kweihmann for this
>>>>> awesome and
>>>>> > overdue tool!!!).
>>>>>
>>>>> Whilst improving recipes in that way does help, it isn't the main
>>>>> source of our
>>>>> major issues.
>>>>>
>>>>> > >
>>>>> > > As a shortcut through things, the "bitbake-selftest" command
>>>>> within bitbake
>>>>> > > may
>>>>> > > be one thing you're looking for which does simple tests on
>>>>> bitbake. It isn't
>>>>> > > complete coverage and we welcome more being added, it is a start
>>>>> and some
>>>>> > > areas
>>>>> > > of the code are covered better than others.
>>>>> > I=E2=80=99d love to overhaul the tests e.g. porting them to `pytest=
` which
>>>>> offers a
>>>>> > much simpler yet much more powerful API/plugin-ecosystem. But won=
=E2=80=99t
>>>>> do via
>>>>> > email :)
>>>>>
>>>>> The tests are written in python's own unittest.
>>>>>
>>>>> > > Issues are filed in the project bugzilla and are actively worked
>>>>> on:
>>>>> > >
>>>>> > > https://bugzilla.yoctoproject.org/
>>>>> > Didn=E2=80=99t know that. But why keeping issues separate from MRs?
>>>>> Automatic issue
>>>>> > closing through referencing in MRs is a pretty nice feature=E2=80=
=A6
>>>>>
>>>>> If I had to list the pain points we have, this is not high on the lis=
t.
>>>>>
>>>>> > > > * side-note on bitbake style/linting: It=E2=80=99s violating PE=
P8 in a
>>>>> couple of
>>>>> > > > ways and TBH PEP8 is the bare minimum I would accept these days
>>>>> for
>>>>> > > > collaboration on projects the dimension of bitbake. So an
>>>>> additional
>>>>> > > > question: Would you be up for a PEP8 compatibility overhaul of
>>>>> the source
>>>>> > > > code? I=E2=80=99d volunteer if I don=E2=80=99t have to send a p=
atch via email ;)
>>>>> > >
>>>>> > > We're interested in patches to improve the coding style as long a=
s
>>>>> they
>>>>> > > don't
>>>>> > > break things like readability or performance. Which rules in PEP8
>>>>> in
>>>>> > > particular
>>>>> > > are you referring to?
>>>>> >
>>>>> > To name a few violations:
>>>>> >
>>>>> >  * hanging indents
>>>>> >  * inconsistent indentation
>>>>> >  * 2 separating lines missing in between classes/top level methods
>>>>>
>>>>> FWIW I find it really hard to get worked up about whitespace issues. =
I
>>>>> appreciate these aren't always great to look at and I appreciate the
>>>>> familiarity
>>>>> argument and standardising the look but these aren't issues I would
>>>>> prioritise.
>>>>>
>>>>> In particular changing them globally in mass patches tends to break
>>>>> patch
>>>>> backporting and taking fixes back to older code which we do benefit
>>>>> from being
>>>>> able to do so there is a cost to doing it. We are trying to make new
>>>>> code more
>>>>> consistent and with older code, we do try and fix the worst issues.
>>>>>
>>>>> >  * unused imported modules
>>>>> >  * missing white-spaces after comma
>>>>> >  * unreachable codes
>>>>>
>>>>> These ones we do take patches for and try to fix when/where we see it=
.
>>>>> For
>>>>> example,
>>>>> http://git.yoctoproject.org/cgit.cgi/poky/commit/?id=3D47e5c456a20432=
b511
>>>>> d830df9cbd4113a4352b2c contained a couple of white-space after comma
>>>>> fixing
>>>>> while I was in that area.
>>>>>
>>>>> > These are just a couple of examples that struck my PEP8 used eye
>>>>> from looking
>>>>> > at two, three modules.
>>>>> >
>>>>> > It=E2=80=99s just like with any code smell: they don=E2=80=99t nece=
ssarily break
>>>>> things. But
>>>>> > they make maintenance, code-reviews and quality control harder than
>>>>> necessary.
>>>>> > Code that does not at least follow PEP8 (and I actually strongly
>>>>> recommend to
>>>>> > go the extra mile with `black`) just looks odd and is unnecessary
>>>>> hard to
>>>>> > read. I=E2=80=99m surprised I have to argue for standards.
>>>>>
>>>>> I wasn't saying it was a bad thing, I asked which issues you noticed =
in
>>>>> particular since I'm trying to ensure we do at least try and react to
>>>>> feedback.
>>>>> Some whitespace issues we aren't likely to tackle, some like the
>>>>> others you
>>>>> mentioned above we should fix.
>>>>> >
>>>>> > Besides that, some minor cleanup just to warm
>>>>> > up: https://github.com/openembedded/bitbake/pull/33,
>>>>> https://github.com/openem
>>>>> > bedded/bitbake/pull/32/files
>>>>>
>>>>> Those two do look like reasonable changes FWIW.
>>>>>
>>>>> > (it was after these two that I found the comment in one of those ol=
d
>>>>> commits
>>>>> > which made me open https://github.com/openembedded/bitbake/pull/34)=
.
>>>>> At least
>>>>> > there should be an automated reply to each MR that is posted if
>>>>> someone makes
>>>>> > the effort to fix code and open a MRs that this is actually in vein
>>>>> - That=E2=80=99s
>>>>> > the mood that took me here :)
>>>>>
>>>>> There is a certain irony in that given you patched the section called
>>>>> "Contributing" in the README in 32!
>>>>>
>>>>> > >
>>>>> > > Help appreciated but email patches is how we accept them at the
>>>>> moment.
>>>>> >
>>>>> > Not from me then :(
>>>>>
>>>>> Sorry to hear that, your changes in 32/33 do look reasonable.
>>>>>
>>>>> Cheers,
>>>>>
>>>>> Richard
>>>>>
>>>>>
>>>>>
>>>>>
>>>>>
>
>
> Am Di., 9. Nov. 2021 um 09:49 Uhr schrieb <Mikko.Rapeli@bmw.de>:
>
>> Hi,
>>
>> I'm a heavy user of yocto and bitbake, CI systems and automation, even
>> Gerrit
>> and GitHub, yet I also perfer they way email allows for a completely
>> distributed
>> review and possibility to follow and join the discussions when ever a
>> subject
>> or a change triggers me to respond or hits a nerve. Gerrit, github,
>> gitlab etc
>> they just don't scale this well. I understand that for drive-by
>> contributions working
>> with email can be tricky if you are not used it, but same goes for
>> github, gerrit,
>> gitlab etc.
>>
>> This community is also very welcoming, well behaving and helping first
>> time
>> contributors. I do see the problem that some first time contributions ma=
y
>> be
>> see the hurdle of "git send-email" as too hard, especially if corporate
>> email systems
>> mangle emails. Maybe some tooling could be setup to allow for pull
>> request type
>> contributions to popup on mailing list if sending emails just doesn't
>> work, but I
>> don't see the benefits of moving fully to gerrit/github/gitlabl style
>> development.
>>
>> ps. maybe I'm also part of the old generation which still actually reads
>> all emails.
>> I don't see any of the chat/collaboration tools really replacing email i=
n
>> global
>> R&D development world even if chat tools/Slack/MS Teams etc are being
>> proposed
>> as replacements (they simply don't scale so well in the end).
>>
>> Cheers,
>>
>> -Mikko
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#12959):
> https://lists.openembedded.org/g/bitbake-devel/message/12959
> Mute This Topic: https://lists.openembedded.org/mt/86911583/6547911
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> marius.kriegerowski@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--000000000000f9df2305d057bc6a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>So, I&#39;d like to come to a conclusing with this ti=
me consuming thread:</div><div><br></div><div>I shared my view which I&#39;=
m sure many early contributors share. There is a lot of resentment in this =
developer community against changing the workflow (which dates back more th=
an a decade) - which I understand. I still think that the inconvenience whe=
n commenting on a commit message (that was the only drawback I found legit)=
 does not outweigh the benefits of discussing MRs on one of the platforms m=
entioned. We disagree on that.<br></div><div><br></div><div>I&#39;m keen on=
 adding contributions not only to `meta-openembedded` (which uses github - =
thanks for that) but also to `bitbake`. So, I&#39;ll surrender and send a p=
atch via email. Maybe. One day.<br></div><div><br></div><div>Have a good da=
y<br></div><div>Marius<br></div></div><br><div class=3D"gmail_quote"><div d=
ir=3D"ltr" class=3D"gmail_attr">Am Di., 9. Nov. 2021 um 10:09=C2=A0Uhr schr=
ieb Marius Kriegerowski via <a href=3D"http://lists.openembedded.org">lists=
.openembedded.org</a> &lt;marius.kriegerowski=3D<a href=3D"mailto:gmail.com=
@lists.openembedded.org">gmail.com@lists.openembedded.org</a>&gt;:<br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div st=
yle=3D"color:rgb(0,0,0);font-family:Helvetica;font-size:12px;font-style:nor=
mal;font-variant-caps:normal;font-weight:normal;letter-spacing:normal;text-=
align:start;text-indent:0px;text-transform:none;white-space:normal;word-spa=
cing:0px;text-decoration:none"><br><br><blockquote type=3D"cite"><div>On 9.=
 Nov 2021, at 09:44, Alexander Kanavin &lt;<a href=3D"mailto:alex.kanavin@g=
mail.com" target=3D"_blank">alex.kanavin@gmail.com</a>&gt; wrote:</div><br>=
<div><div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"=
gmail_attr">On Tue, 9 Nov 2021 at 09:32, Marius Kriegerowski &lt;<a href=3D=
"mailto:marius.kriegerowski@gmail.com" target=3D"_blank">marius.kriegerowsk=
i@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex"><div dir=3D"ltr"><span style=3D"font-family:Helvetica;font-size:=
12px;font-style:normal;font-variant-caps:normal;font-weight:normal;letter-s=
pacing:normal;text-align:start;text-indent:0px;text-transform:none;white-sp=
ace:normal;word-spacing:0px;text-decoration:none;display:inline;float:none"=
>I see.</span><br style=3D"font-family:Helvetica;font-size:12px;font-style:=
normal;font-variant-caps:normal;font-weight:normal;letter-spacing:normal;te=
xt-align:start;text-indent:0px;text-transform:none;white-space:normal;word-=
spacing:0px;text-decoration:none"><div style=3D"font-family:Helvetica;font-=
size:12px;font-style:normal;font-variant-caps:normal;font-weight:normal;let=
ter-spacing:normal;text-align:start;text-indent:0px;text-transform:none;whi=
te-space:normal;word-spacing:0px;text-decoration:none"><br><blockquote type=
=3D"cite"><div>On 9. Nov 2021, at 09:19, Alexander Kanavin &lt;<a href=3D"m=
ailto:alex.kanavin@gmail.com" target=3D"_blank">alex.kanavin@gmail.com</a>&=
gt; wrote:</div><br><div><div dir=3D"ltr"><div>I think you misunderstood me=
 too. It&#39;s about the github UI which does its best to hide the commit m=
essages, and doesn&#39;t allow to comment on their content. Yes you can con=
tort yourself and still do it, but the tools do not help.</div></div></div>=
</blockquote><div><br></div><div>I never felt that the commit messages are =
really that hidden. I mean=E2=80=A6 you find them under `commits`... I find=
 that pretty transparent. You can comment on the commit message content in =
the thread of the MR, just as you would in an email thread, can&#39;t you?<=
/div></div></div></blockquote><div><br></div><div>No. You need to separatel=
y go to the commits tab, open each commit individually to see both the mess=
age and the associated code, then if there&#39;s something you do not like,=
 you need to copy paste the offending bit and open a MR thread with it. Tha=
t&#39;s not helpful, and it&#39;s clear that kind of thing is not important=
 to the tool providers or users. But it is very important to me as one of t=
he oe-core maintainers.<br></div></div></div></div></blockquote><div><br></=
div><div><br></div><br><blockquote type=3D"cite"><div><div dir=3D"ltr"><div=
 class=3D"gmail_quote"><div>=C2=A0</div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex"><div dir=3D"ltr"><div style=3D"font-family:Helvetica;font-si=
ze:12px;font-style:normal;font-variant-caps:normal;font-weight:normal;lette=
r-spacing:normal;text-align:start;text-indent:0px;text-transform:none;white=
-space:normal;word-spacing:0px;text-decoration:none"><div>Also, the older a=
nd closed threads can be very helpful when searching for answers why someth=
ing has been changed in which way. I know that I saw the email threads on p=
atches as well but found them super hard to read (no syntax highlighting, a=
ll black and white, =E2=80=A6). Well, probably I could get used to reading =
them over time. But then =E2=80=94 why should I if there are things like co=
llapsable threads, syntax highlight, color,=E2=80=A6?</div></div></div></bl=
ockquote><div><br></div><div>You can find a better email client perhaps?<br=
></div></div></div></div></blockquote><br>Not sure I was clear about what I=
 meant: I was speaking about the closed threads (<a href=3D"https://lists.o=
penembedded.org/g/openembedded-core" target=3D"_blank">https://lists.openem=
bedded.org/g/openembedded-core</a>). Is it somehow sortable by open MRs/clo=
sed MRs/pure text/issues?</div><div style=3D"color:rgb(0,0,0);font-family:H=
elvetica;font-size:12px;font-style:normal;font-variant-caps:normal;font-wei=
ght:normal;letter-spacing:normal;text-align:start;text-indent:0px;text-tran=
sform:none;white-space:normal;word-spacing:0px;text-decoration:none"><br></=
div><div style=3D"color:rgb(0,0,0);font-family:Helvetica;font-size:12px;fon=
t-style:normal;font-variant-caps:normal;font-weight:normal;letter-spacing:n=
ormal;text-align:start;text-indent:0px;text-transform:none;white-space:norm=
al;word-spacing:0px;text-decoration:none">So, which email client would I ha=
ve to install to get a better user experience? What about the other feature=
s that make me use the email client because of which I which Iike to use th=
at client? Do you expect me to dump them those features and my workflow rou=
tines in favour of just openembedded?! Should I have two email clients then=
? And then hard-copy the old mail threads to my HD from how many years?</di=
v><div style=3D"color:rgb(0,0,0);font-family:Helvetica;font-size:12px;font-=
style:normal;font-variant-caps:normal;font-weight:normal;letter-spacing:nor=
mal;text-align:start;text-indent:0px;text-transform:none;white-space:normal=
;word-spacing:0px;text-decoration:none"><br></div><div style=3D"color:rgb(0=
,0,0);font-family:Helvetica;font-size:12px;font-style:normal;font-variant-c=
aps:normal;font-weight:normal;letter-spacing:normal;text-align:start;text-i=
ndent:0px;text-transform:none;white-space:normal;word-spacing:0px;text-deco=
ration:none"><div>BTW: I just went for the first time to the online thread:=
=C2=A0<a href=3D"https://lists.openembedded.org/g/bitbake-devel/topic/86911=
583" target=3D"_blank">https://lists.openembedded.org/g/bitbake-devel/topic=
/86911583</a></div><div>I would probably stop reading that monstrous thread=
 after few seconds.</div></div><div style=3D"color:rgb(0,0,0);font-family:H=
elvetica;font-size:12px;font-style:normal;font-variant-caps:normal;font-wei=
ght:normal;letter-spacing:normal;text-align:start;text-indent:0px;text-tran=
sform:none;white-space:normal;word-spacing:0px;text-decoration:none"><br></=
div><div style=3D"color:rgb(0,0,0);font-family:Helvetica;font-size:12px;fon=
t-style:normal;font-variant-caps:normal;font-weight:normal;letter-spacing:n=
ormal;text-align:start;text-indent:0px;text-transform:none;white-space:norm=
al;word-spacing:0px;text-decoration:none">So, to move forward: Maybe you ca=
n improve the online threads so that it=E2=80=99s easier to navigate and re=
ad those pure retro-black-and-white threads.</div><div style=3D"color:rgb(0=
,0,0);font-family:Helvetica;font-size:12px;font-style:normal;font-variant-c=
aps:normal;font-weight:normal;letter-spacing:normal;text-align:start;text-i=
ndent:0px;text-transform:none;white-space:normal;word-spacing:0px;text-deco=
ration:none"><br></div><div style=3D"color:rgb(0,0,0);font-family:Helvetica=
;font-size:12px;font-style:normal;font-variant-caps:normal;font-weight:norm=
al;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:no=
ne;white-space:normal;word-spacing:0px;text-decoration:none">Marius</div><d=
iv style=3D"color:rgb(0,0,0);font-family:Helvetica;font-size:12px;font-styl=
e:normal;font-variant-caps:normal;font-weight:normal;letter-spacing:normal;=
text-align:start;text-indent:0px;text-transform:none;white-space:normal;wor=
d-spacing:0px;text-decoration:none"><br></div><div style=3D"color:rgb(0,0,0=
);font-family:Helvetica;font-size:12px;font-style:normal;font-variant-caps:=
normal;font-weight:normal;letter-spacing:normal;text-align:start;text-inden=
t:0px;text-transform:none;white-space:normal;word-spacing:0px;text-decorati=
on:none"><br></div><div style=3D"color:rgb(0,0,0);font-family:Helvetica;fon=
t-size:12px;font-style:normal;font-variant-caps:normal;font-weight:normal;l=
etter-spacing:normal;text-align:start;text-indent:0px;text-transform:none;w=
hite-space:normal;word-spacing:0px;text-decoration:none"><br></div><div sty=
le=3D"color:rgb(0,0,0);font-family:Helvetica;font-size:12px;font-style:norm=
al;font-variant-caps:normal;font-weight:normal;letter-spacing:normal;text-a=
lign:start;text-indent:0px;text-transform:none;white-space:normal;word-spac=
ing:0px;text-decoration:none"><div>PS I=E2=80=99d like to emphasise again:<=
/div><div>I know I sound harsh. I=E2=80=99m not blaming here and of course =
I=E2=80=99m also not belittling the workflow neither the proficiency of the=
 contributors. I=E2=80=99m totally aware that most regular contributors her=
e are extremely highly skilled and work on an incredibly impactful set of s=
oftware. I=E2=80=99m just providing a very detailed feedback of what I as a=
 really really really really hard wanting-to-become future contributor see =
what really keeps me from joining.</div></div><div style=3D"color:rgb(0,0,0=
);font-family:Helvetica;font-size:12px;font-style:normal;font-variant-caps:=
normal;font-weight:normal;letter-spacing:normal;text-align:start;text-inden=
t:0px;text-transform:none;white-space:normal;word-spacing:0px;text-decorati=
on:none"><br></div><div style=3D"color:rgb(0,0,0);font-family:Helvetica;fon=
t-size:12px;font-style:normal;font-variant-caps:normal;font-weight:normal;l=
etter-spacing:normal;text-align:start;text-indent:0px;text-transform:none;w=
hite-space:normal;word-spacing:0px;text-decoration:none"><br></div><div sty=
le=3D"color:rgb(0,0,0);font-family:Helvetica;font-size:12px;font-style:norm=
al;font-variant-caps:normal;font-weight:normal;letter-spacing:normal;text-a=
lign:start;text-indent:0px;text-transform:none;white-space:normal;word-spac=
ing:0px;text-decoration:none"><blockquote type=3D"cite"><div><div dir=3D"lt=
r"><div class=3D"gmail_quote"><div><br></div><div>Alex<br></div><div>=C2=A0=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><d=
iv style=3D"font-family:Helvetica;font-size:12px;font-style:normal;font-var=
iant-caps:normal;font-weight:normal;letter-spacing:normal;text-align:start;=
text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;tex=
t-decoration:none"><div><br></div><div>Best</div><div>Marius</div><div><br>=
</div><br><blockquote type=3D"cite"><div><div dir=3D"ltr"><div>Alex<br></di=
v></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr=
">On Tue, 9 Nov 2021 at 09:05, Marius Kriegerowski &lt;<a href=3D"mailto:ma=
rius.kriegerowski@gmail.com" target=3D"_blank">marius.kriegerowski@gmail.co=
m</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
><div dir=3D"ltr"><div style=3D"font-family:Helvetica;font-size:12px;font-s=
tyle:normal;font-variant-caps:normal;font-weight:normal;letter-spacing:norm=
al;text-align:start;text-indent:0px;text-transform:none;white-space:normal;=
word-spacing:0px;text-decoration:none">Good morning,</div><div style=3D"fon=
t-family:Helvetica;font-size:12px;font-style:normal;font-variant-caps:norma=
l;font-weight:normal;letter-spacing:normal;text-align:start;text-indent:0px=
;text-transform:none;white-space:normal;word-spacing:0px;text-decoration:no=
ne"><br></div><div style=3D"font-family:Helvetica;font-size:12px;font-style=
:normal;font-variant-caps:normal;font-weight:normal;letter-spacing:normal;t=
ext-align:start;text-indent:0px;text-transform:none;white-space:normal;word=
-spacing:0px;text-decoration:none">I don=E2=80=99t think this is correct. Y=
ou can change the git history and commit messages of every MR to whatever y=
ou like with `git commit =E2=80=94amend`, `git rebase -I` and `git push -f`=
. So, you can very well ask contributors to cleanup their history before me=
rging.</div><div style=3D"font-family:Helvetica;font-size:12px;font-style:n=
ormal;font-variant-caps:normal;font-weight:normal;letter-spacing:normal;tex=
t-align:start;text-indent:0px;text-transform:none;white-space:normal;word-s=
pacing:0px;text-decoration:none"><br></div><div style=3D"font-family:Helvet=
ica;font-size:12px;font-style:normal;font-variant-caps:normal;font-weight:n=
ormal;letter-spacing:normal;text-align:start;text-indent:0px;text-transform=
:none;white-space:normal;word-spacing:0px;text-decoration:none">Best</div><=
div style=3D"font-family:Helvetica;font-size:12px;font-style:normal;font-va=
riant-caps:normal;font-weight:normal;letter-spacing:normal;text-align:start=
;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;te=
xt-decoration:none">Marius</div></div><br><div class=3D"gmail_quote"><div d=
ir=3D"ltr" class=3D"gmail_attr">Am Di., 9. Nov. 2021 um 07:47=C2=A0Uhr schr=
ieb Alexander Kanavin &lt;<a href=3D"mailto:alex.kanavin@gmail.com" target=
=3D"_blank">alex.kanavin@gmail.com</a>&gt;:<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex"><div dir=3D"ltr"><div>There&#39;s another probl=
em with github/gitlab which I find significant. These tools do not allow re=
viewing commit messages, and don&#39;t even make it easy to see them. So th=
e developers using those tools, both submitters and maintainers, are effect=
ively being conditioned by the tools to see good commit messages as superfl=
uous and unnecessary. And so you more often than not end up with poorly wri=
tten commit history in github projects, or, if you&#39;re a reviewer, have =
to repeatedly explain to the submitter how to explain and structure their c=
hanges properly.</div><div><br></div><div>I&#39;d rather not have a change,=
 than have a change that no one, even the original author, can understand o=
r remember the reasons for one year down the line.</div><div><br></div><div=
>Alex<br></div><br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" cl=
ass=3D"gmail_attr">On Tue, 9 Nov 2021 at 00:30, Richard Purdie &lt;<a href=
=3D"mailto:richard.purdie@linuxfoundation.org" target=3D"_blank">richard.pu=
rdie@linuxfoundation.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">On Mon, 2021-11-08 at 23:44 +0100, Marius Kriegerow=
ski wrote:<br>&gt;<span>=C2=A0</span><br>&gt;<span>=C2=A0</span><br>&gt; &g=
t; On 8. Nov 2021, at 22:47, Richard Purdie<br>&gt; &gt; &lt;<a href=3D"mai=
lto:richard.purdie@linuxfoundation.org" target=3D"_blank">richard.purdie@li=
nuxfoundation.org</a>&gt; wrote:<br>&gt; &gt;<span>=C2=A0</span><br>&gt; &g=
t; On Mon, 2021-11-08 at 18:37 +0100, Marius Kriegerowski wrote:<br>&gt; &g=
t; &gt; Is there a plan to switch to some more modern ways to collaborate o=
n<br>&gt; &gt; &gt; bitbake,<br>&gt; &gt; &gt; you know, like, gitlab/githu=
b/gitea with issues, PRs and so forth? I mean=E2=80=A6<br>&gt; &gt; &gt; it=
=E2=80=99s<br>&gt; &gt; &gt; late 2021 and sending MRs/Issues via email fee=
ls reaaaally outdated, slow,<br>&gt; &gt; &gt; intransparent, ineffective (=
how to you do reviews, code comparisons during<br>&gt; &gt; &gt; reviews, i=
nsert suggestions, etc.) and indirect (where is the CI pipeline<br>&gt; &gt=
; &gt; that I<br>&gt; &gt; &gt; trigger when pushing something somewhere?).=
<br>&gt; &gt;<span>=C2=A0</span><br>&gt; &gt; There are pros and cons to sw=
itching to something else. Keep in mind that<br>&gt; &gt; whilst the github=
 workflow works well for a single maintainer of a project,<br>&gt; &gt; it =
does not work well for diverse review.<br>&gt;<br>&gt; I strongly disagree =
with that. Reviews can equally well be done in a MR<br>&gt; thread. That=E2=
=80=99s what they are there for. You can discuss things there with as<br>&g=
t; many people as you want and can e.g. define a minimum number of approval=
s<br>&gt; before a MR can be merged.<br><br>You misunderstand my point. We =
have a several thousand people on the mailing<br>lists and they filter thin=
gs to what interests them. *I* have no people I want<br>to discuss a given =
change with, it is a question of whether the people who have<br>an interest=
 in a given change would see it.<br><br>A minimum number of approvals is ut=
terly meaningless for how we work, I need the<br>interested people to see i=
t and that varies massively depending on what is being<br>changed. It is th=
is aspect of mailing list change distribution and discussion we<br>benefit =
from.<br><br>&gt; =C2=A0It also naturally groups discussions. You can addre=
ss experts for specific<br>&gt; domains which means less noise for the expe=
rts. I really don=E2=80=99t see why mailing<br>&gt; list reviews should wor=
k any better here.<br><br>We all have established mechanisms to &quot;see&q=
uot; the things which interest us as<br>maintainers?<br><br>Please don&#39;=
t misunderstand me, I do see the attraction of github from your<br>perspect=
ive. It would just destroy the ecosystem we already have. You are<br>basica=
lly saying that our current ecosystem is worthless but I would point out<br=
>it has resulted in a project which you did say you appreciate so it can&#3=
9;t be all<br>bad.<br><br>&gt; =C2=A0If google can coordinate 2.1k repos wi=
th 1.1k contributors over GitHub, why<br>&gt; should that not work for open=
embedded??<br><br>It isn&#39;t about raw numbers, it is about numbers of re=
viewers for a given change.<br>We have hundreds of people doing that using =
the mailing lists.<br><br>&gt; &gt; The Bitbake case is a little bit differ=
ent but in general we&#39;d follow what<br>&gt; &gt; OE/Yocto Project are d=
oing.<br>&gt; &gt;<span>=C2=A0</span><br>&gt; &gt; We have discussed changi=
ng and it is listed as one topic on:<br>&gt; &gt;<span>=C2=A0</span><a href=
=3D"https://wiki.yoctoproject.org/wiki/Future_Directions" rel=3D"noreferrer=
" target=3D"_blank">https://wiki.yoctoproject.org/wiki/Future_Directions</a=
><br>&gt; &gt; (Code Submission process)<br>&gt; &gt;<span>=C2=A0</span><br=
>&gt; &gt; I&#39;d note that it is a huge change to our current developers =
and most of us<br>&gt; &gt; are very used to the mailing lists so if we did=
 change, it would allow<br>&gt; &gt; potential new collaborators at the ris=
k of losing people with key<br>&gt; &gt; knowledge/experience.<br>&gt; =E2=
=80=A6 which reads to me like: =E2=80=9CIt has always been that way so we w=
ill not change<br>&gt; that&quot; doesn=E2=80=99t it? Always a very poor ar=
gument.<br><br>No, what I said is &quot;upsetting our existing developers i=
s something which we may<br>want to potentially avoid&quot;.<br><br>There a=
re some options out there which have offered mailing list integration for<b=
r>example and we have tried to explore those. Something which drops the lis=
ts<br>entirely could in the current view of the TSC result in loss of too m=
any of our<br>existing maintainers.<br><br>&gt;<span>=C2=A0</span><br>&gt; =
&gt; We do have CI which is shared with Yocto Project and=C2=A0<br>&gt; &gt=
; OpenEmbedded. You can see it here:<br>&gt; &gt;<span>=C2=A0</span><br>&gt=
; &gt;<span>=C2=A0</span><a href=3D"https://autobuilder.yoctoproject.org/ty=
phoon/#/console" rel=3D"noreferrer" target=3D"_blank">https://autobuilder.y=
octoproject.org/typhoon/#/console</a><br>&gt; &gt;<span>=C2=A0</span><br>&g=
t; &gt; and it has it&#39;s own manual which was recently added to our docu=
mentations<br>&gt; &gt; set:<br>&gt; &gt;<span>=C2=A0</span><br>&gt; &gt;<s=
pan>=C2=A0</span><a href=3D"http://docs.yoctoproject.org/test-manual/index.=
html" rel=3D"noreferrer" target=3D"_blank">http://docs.yoctoproject.org/tes=
t-manual/index.html</a><br>&gt; =E2=80=A6 stressing my point: Why does the =
location of the CI need documentation? All<br>&gt; of the aforementioned pl=
atforms smoothly integrate with multiple CI solutions,<br>&gt; drastically =
reducing the time required for reviews if the pipeline provides<br>&gt; aut=
omated feedback to the contributor. It would probably cost me about one<br>=
&gt; afternoon to setup a decent CI pipeline at least for all python codes =
pushing<br>&gt; the need to review from manual labor to automated tools. If=
 open embedded<br>&gt; migrates to a proper git platform I happily voluntee=
r on that end!!<br><br>We&#39;re not talking about simple python code. We&#=
39;re talking about testing a build<br>environment which cross compiles mul=
tiple operating systems for multiple<br>architectures, C libraries, GUI sta=
cks, init systems and so on. Testing the<br>python code is one small part o=
f that. I&#39;ve spent several years trying to<br>improve and get our CI to=
 where it is today.<br><br>Yes, the python code is tested as part of this a=
s we don&#39;t really want to have<br>multiple test platforms and the real =
world usage is some of the best testing<br>changes can have.<br><br>&gt; &g=
t; There is work still needed on that but it is a start.=C2=A0One challenge=
 of<br>&gt; &gt; bitbake/OE is that the builds take an age and the test mat=
rix is huge so the<br>&gt; &gt; CI<br>&gt; &gt; process isn&#39;t quite as =
simple as some other simpler projects.<br>&gt; At least for python I bet th=
at most bugs can be caught simply by firing up<br>&gt; `black`, `flake8`, `=
pylint` (and a hand full of other tools) just to check the<br>&gt; modified=
 files.<br><br>Well, I would bet that most of our bugs are not caused by is=
sues like that. I do<br>attend the weekly bug triage meetings and have fixe=
d my share of them. You could<br>have a look at the issues filed in bugzill=
a over the past few weeks if you&#39;d<br>like to see the kinds of issues t=
hat get filed and are open.<br><br>&gt; =C2=A0Regarding meta-layers and rec=
ipes out there we are currently pushing forward<br>&gt; with a linter for b=
itbake recipes (thanks @priv-kweihmann for this awesome and<br>&gt; overdue=
 tool!!!).<br><br>Whilst improving recipes in that way does help, it isn&#3=
9;t the main source of our<br>major issues.<br><br>&gt; &gt;<span>=C2=A0</s=
pan><br>&gt; &gt; As a shortcut through things, the &quot;bitbake-selftest&=
quot; command within bitbake<br>&gt; &gt; may<br>&gt; &gt; be one thing you=
&#39;re looking for which does simple tests on bitbake. It isn&#39;t<br>&gt=
; &gt; complete coverage and we welcome more being added, it is a start and=
 some<br>&gt; &gt; areas<br>&gt; &gt; of the code are covered better than o=
thers.<br>&gt; I=E2=80=99d love to overhaul the tests e.g. porting them to =
`pytest` which offers a<br>&gt; much simpler yet much more powerful API/plu=
gin-ecosystem. But won=E2=80=99t do via<br>&gt; email :)<br><br>The tests a=
re written in python&#39;s own unittest.<br><br>&gt; &gt; Issues are filed =
in the project bugzilla and are actively worked on:<br>&gt; &gt;<span>=C2=
=A0</span><br>&gt; &gt;<span>=C2=A0</span><a href=3D"https://bugzilla.yocto=
project.org/" rel=3D"noreferrer" target=3D"_blank">https://bugzilla.yoctopr=
oject.org/</a><br>&gt; Didn=E2=80=99t know that. But why keeping issues sep=
arate from MRs? Automatic issue<br>&gt; closing through referencing in MRs =
is a pretty nice feature=E2=80=A6<br><br>If I had to list the pain points w=
e have, this is not high on the list.<br><br>&gt; &gt; &gt; * side-note on =
bitbake style/linting: It=E2=80=99s violating PEP8 in a couple of<br>&gt; &=
gt; &gt; ways and TBH PEP8 is the bare minimum I would accept these days fo=
r<br>&gt; &gt; &gt; collaboration on projects the dimension of bitbake. So =
an additional<br>&gt; &gt; &gt; question: Would you be up for a PEP8 compat=
ibility overhaul of the source<br>&gt; &gt; &gt; code? I=E2=80=99d voluntee=
r if I don=E2=80=99t have to send a patch via email ;)<br>&gt; &gt;<span>=
=C2=A0</span><br>&gt; &gt; We&#39;re interested in patches to improve the c=
oding style as long as they<br>&gt; &gt; don&#39;t<br>&gt; &gt; break thing=
s like readability or performance.=C2=A0Which rules in PEP8 in<br>&gt; &gt;=
 particular<br>&gt; &gt; are you referring to?<br>&gt;<span>=C2=A0</span><b=
r>&gt; To name a few violations:<br>&gt;<span>=C2=A0</span><br>&gt; =C2=A0*=
 hanging indents<br>&gt; =C2=A0* inconsistent indentation<br>&gt; =C2=A0* 2=
 separating lines missing in between classes/top level methods<br><br>FWIW =
I find it really hard to get worked up about whitespace issues. I<br>apprec=
iate these aren&#39;t always great to look at and I appreciate the familiar=
ity<br>argument and standardising the look but these aren&#39;t issues I wo=
uld prioritise.<br><br>In particular changing them globally in mass patches=
 tends to break patch<br>backporting and taking fixes back to older code wh=
ich we do benefit from being<br>able to do so there is a cost to doing it. =
We are trying to make new code more<br>consistent and with older code, we d=
o try and fix the worst issues.<br><br>&gt; =C2=A0* unused imported modules=
<br>&gt; =C2=A0* missing white-spaces after comma<br>&gt; =C2=A0* unreachab=
le codes<br><br>These ones we do take patches for and try to fix when/where=
 we see it. For<br>example,=C2=A0<a href=3D"http://git.yoctoproject.org/cgi=
t.cgi/poky/commit/?id=3D47e5c456a20432b511d830df9cbd4113a4352b2c" rel=3D"no=
referrer" target=3D"_blank">http://git.yoctoproject.org/cgit.cgi/poky/commi=
t/?id=3D47e5c456a20432b511<br>d830df9cbd4113a4352b2c</a>=C2=A0contained a c=
ouple of white-space after comma fixing<br>while I was in that area.<br><br=
>&gt; These are just a couple of examples that struck my PEP8 used eye from=
 looking<br>&gt; at two, three modules.<br>&gt;<span>=C2=A0</span><br>&gt; =
It=E2=80=99s just like with any code smell: they don=E2=80=99t necessarily =
break things. But<br>&gt; they make maintenance, code-reviews and quality c=
ontrol harder than necessary.<br>&gt; Code that does not at least follow PE=
P8 (and I actually strongly recommend to<br>&gt; go the extra mile with `bl=
ack`) just looks odd and is unnecessary hard to<br>&gt; read. I=E2=80=99m s=
urprised I have to argue for standards.<br><br>I wasn&#39;t saying it was a=
 bad thing, I asked which issues you noticed in<br>particular since I&#39;m=
 trying to ensure we do at least try and react to feedback.<br>Some whitesp=
ace issues we aren&#39;t likely to tackle, some like the others you<br>ment=
ioned above we should fix.<br>&gt;<span>=C2=A0</span><br>&gt; Besides that,=
 some minor cleanup just to warm<br>&gt; up:=C2=A0<a href=3D"https://github=
.com/openembedded/bitbake/pull/33" rel=3D"noreferrer" target=3D"_blank">htt=
ps://github.com/openembedded/bitbake/pull/33</a>,=C2=A0<a href=3D"https://g=
ithub.com/openem" rel=3D"noreferrer" target=3D"_blank">https://github.com/o=
penem</a><br>&gt; bedded/bitbake/pull/32/files=C2=A0<br><br>Those two do lo=
ok like reasonable changes FWIW.<br><br>&gt; (it was after these two that I=
 found the comment in one of those old commits<br>&gt; which made me open=
=C2=A0<a href=3D"https://github.com/openembedded/bitbake/pull/34" rel=3D"no=
referrer" target=3D"_blank">https://github.com/openembedded/bitbake/pull/34=
</a>). At least<br>&gt; there should be an=C2=A0automated reply to each MR =
that is posted if someone makes<br>&gt; the effort to fix code and open a M=
Rs that this is=C2=A0actually in vein - That=E2=80=99s<br>&gt; the=C2=A0moo=
d that took me here :)<br><br>There is a certain irony in that given you pa=
tched the section called<br>&quot;Contributing&quot; in the README in 32!<b=
r><br>&gt; &gt;<span>=C2=A0</span><br>&gt; &gt; Help appreciated but email =
patches is how we accept them at the moment.<br>&gt;<span>=C2=A0</span><br>=
&gt; Not from me then :(<br><br>Sorry to hear that, your changes in 32/33 d=
o look reasonable.<br><br>Cheers,<br><br>Richard<br><br><br><br><br></block=
quote></div></blockquote></div></blockquote></div></div></blockquote></div>=
</div></blockquote></div></div></div></blockquote></div><br><br></div><br><=
div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Am Di., 9. =
Nov. 2021 um 09:49=C2=A0Uhr schrieb &lt;<a href=3D"mailto:Mikko.Rapeli@bmw.=
de" target=3D"_blank">Mikko.Rapeli@bmw.de</a>&gt;:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">Hi,<br>
<br>
I&#39;m a heavy user of yocto and bitbake, CI systems and automation, even =
Gerrit<br>
and GitHub, yet I also perfer they way email allows for a completely distri=
buted<br>
review and possibility to follow and join the discussions when ever a subje=
ct<br>
or a change triggers me to respond or hits a nerve. Gerrit, github, gitlab =
etc<br>
they just don&#39;t scale this well. I understand that for drive-by contrib=
utions working<br>
with email can be tricky if you are not used it, but same goes for github, =
gerrit,<br>
gitlab etc.<br>
<br>
This community is also very welcoming, well behaving and helping first time=
<br>
contributors. I do see the problem that some first time contributions may b=
e<br>
see the hurdle of &quot;git send-email&quot; as too hard, especially if cor=
porate email systems<br>
mangle emails. Maybe some tooling could be setup to allow for pull request =
type<br>
contributions to popup on mailing list if sending emails just doesn&#39;t w=
ork, but I<br>
don&#39;t see the benefits of moving fully to gerrit/github/gitlabl style d=
evelopment.<br>
<br>
ps. maybe I&#39;m also part of the old generation which still actually read=
s all emails.<br>
I don&#39;t see any of the chat/collaboration tools really replacing email =
in global<br>
R&amp;D development world even if chat tools/Slack/MS Teams etc are being p=
roposed<br>
as replacements (they simply don&#39;t scale so well in the end).<br>
<br>
Cheers,<br>
<br>
-Mikko</blockquote></div>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#12959): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/12959" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/12959</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/86911583/6547=
911" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/mt=
/86911583/6547911</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:marius.kriegerowski@gmail.com" tar=
get=3D"_blank">marius.kriegerowski@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div>

--000000000000f9df2305d057bc6a--

