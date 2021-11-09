Return-Path: <marius.kriegerowski@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 775D2C433F5
	for <webhook@archiver.kernel.org>; Tue,  9 Nov 2021 11:56:26 +0000 (UTC)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com
 [209.85.208.45])
 by mx.groups.io with SMTP id smtpd.web08.11050.1636458984325556991
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 09 Nov 2021 03:56:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=pAseQfHb;
 spf=pass (domain: gmail.com, ip: 209.85.208.45,
 mailfrom: marius.kriegerowski@gmail.com)
Received: by mail-ed1-f45.google.com with SMTP id z21so30367628edb.5
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 09 Nov 2021 03:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sfIyjGboU1XQXZRAAo2k+Cn4gtsdW+nz5O6ibduLAfI=;
        b=pAseQfHbdm0ZcfN/qWzwBUY+Nzvo++2+LCfRUMEClBlg6h1EwoAJqsROOT7TOBqhRf
         WHfAJzD9ddgiWShrhvUXbPQ4cCaE3LtCTfmi++1eikPbhYQNG6f/AT6U16O0Y0hfuy6R
         Lhu8R0E0V9pLyB9/O2ABPaMU8ifaN87p63grzW/ZKhoVouRT9aDws+SDVhjOMBvil7QH
         2f0yTgbYfg5rqkoSCiowv5rHIste45x+Xtd3lFnBw/y0RiKYKG7Ssmr4+O0S7NYA0y6w
         kczNV3Eoh1qT8yJ+p9NFEaGxYsK4zrRMhD7xtfwZz7mBOEJGnLlwnDu0NKBZVQM67n/y
         /bjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sfIyjGboU1XQXZRAAo2k+Cn4gtsdW+nz5O6ibduLAfI=;
        b=qq0f7cPaieYOgkTw4pSYT/tQDbviJrs5V+07ojPLpQVai0zP+QafB1x0u2jZhFcqP3
         rhYAldaJIE22pI6z17iIFpQ4ml7GJf2WpcYxn4pZ+JSmTvXiGiZYZfNiw9/ZetTH8dQY
         N2LV4W4xZMV8302u7IFRYFb1SbZcDuPX66PBau4HmM42OEocWGP463EYN09v5jiARnLW
         XEVSHrmCH7IxFMKCeb4G2ohIurZJAHLPnIGUV0GC/VbYdhE1H3gaWjuB14mbyVq0VG/g
         8i8qAtR+Pt70pifHq5+f1vFD0vrVtrfoTKZG2996qqK++Y6ddXd1x5mJzPFKwmTEgi7J
         7Qcw==
X-Gm-Message-State: AOAM533r/9YmUhoTwakJNzQXud6WPfTStrvzePW/F5MHbYo8kjFjpkXr
	pJL8NJTJh12UZGrS3U/+CcSPEdDRd6QQwNdFVbg=
X-Google-Smtp-Source: 
 ABdhPJzNHqf3n6C45l3PInTCmfIa+RwACw0unxq2ardncO0iyqz1od5fcDvLA9VfCAyIQOLYHZ3eM9OvxCkU4KdXj9U=
X-Received: by 2002:a05:6402:2552:: with SMTP id
 l18mr9268233edb.90.1636458982371;
 Tue, 09 Nov 2021 03:56:22 -0800 (PST)
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
 <16B5D6BAD1F7C3E6.27841@lists.openembedded.org>
In-Reply-To: <16B5D6BAD1F7C3E6.27841@lists.openembedded.org>
From: Marius Kriegerowski <marius.kriegerowski@gmail.com>
Date: Tue, 9 Nov 2021 12:56:11 +0100
Message-ID: 
 <CAMaS9hNRUsmWdXNaJV9E8rKCw6g2OzdZd4U8s6k+0c7VYo8P9g@mail.gmail.com>
Subject: Re: [bitbake-devel] bitbake style/workflow
To: Marius Kriegerowski <marius.kriegerowski@gmail.com>
Cc: Mikko.Rapeli@bmw.de, Alexander Kanavin <alex.kanavin@gmail.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: multipart/mixed; boundary="00000000000055ac6f05d059cca4"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 09 Nov 2021 11:56:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12962

--00000000000055ac6f05d059cca4
Content-Type: multipart/alternative; boundary="00000000000055ac6e05d059cca2"

--00000000000055ac6e05d059cca2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Okay, one thing I have to add after killing some time with this: I quickly
scrutinized the git history of `bitbake` and `meta-openembedded`.

Attached are two figures that show the first time contributor count of both
projects over the last ~ten years. While `bitbake` shows a linear growth of
first-time contributors, `meta-openembedded` is exponential. I didn't
analyze the first derivative but to me it looks like there is a kink
following that timestamp indicated by the vertical bar. That line
represents a subtle, yet important change in intonation in the merge
requests. Before that there was always a comment "Please read README and
send patches to openembedded-devel@lists.openembedded.org for review." or
alike. After that the intonation changed to messages "Patches should be
sent to openembedded-devel as described in README." and if I interprete the
following MRs correctly the maintainers (mostly @kraj) were kind enough to
apply the MRs as patches. I'm sure there is a readon not to hit the merge
button but instead doing that manually which I don't understand. But most
important point to mention:

The development of the community around meta-openembedded is what a
community driven project should look like - the evolution of `bitbake` not
so much...

Have a look, reproduce, ask and draw your own conclusions.

Marius

Am Di., 9. Nov. 2021 um 10:28 Uhr schrieb Marius Kriegerowski via
lists.openembedded.org <marius.kriegerowski=3Dgmail.com@lists.openembedded.=
org
>:

> So, I'd like to come to a conclusing with this time consuming thread:
>
> I shared my view which I'm sure many early contributors share. There is a
> lot of resentment in this developer community against changing the workfl=
ow
> (which dates back more than a decade) - which I understand. I still think
> that the inconvenience when commenting on a commit message (that was the
> only drawback I found legit) does not outweigh the benefits of discussing
> MRs on one of the platforms mentioned. We disagree on that.
>
> I'm keen on adding contributions not only to `meta-openembedded` (which
> uses github - thanks for that) but also to `bitbake`. So, I'll surrender
> and send a patch via email. Maybe. One day.
>
> Have a good day
> Marius
>
> Am Di., 9. Nov. 2021 um 10:09 Uhr schrieb Marius Kriegerowski via
> lists.openembedded.org <marius.kriegerowski=3D
> gmail.com@lists.openembedded.org>:
>
>>
>>
>> On 9. Nov 2021, at 09:44, Alexander Kanavin <alex.kanavin@gmail.com>
>> wrote:
>>
>> On Tue, 9 Nov 2021 at 09:32, Marius Kriegerowski <
>> marius.kriegerowski@gmail.com> wrote:
>>
>>> I see.
>>>
>>> On 9. Nov 2021, at 09:19, Alexander Kanavin <alex.kanavin@gmail.com>
>>> wrote:
>>>
>>> I think you misunderstood me too. It's about the github UI which does
>>> its best to hide the commit messages, and doesn't allow to comment on t=
heir
>>> content. Yes you can contort yourself and still do it, but the tools do=
 not
>>> help.
>>>
>>>
>>> I never felt that the commit messages are really that hidden. I mean=E2=
=80=A6
>>> you find them under `commits`... I find that pretty transparent. You ca=
n
>>> comment on the commit message content in the thread of the MR, just as =
you
>>> would in an email thread, can't you?
>>>
>>
>> No. You need to separately go to the commits tab, open each commit
>> individually to see both the message and the associated code, then if
>> there's something you do not like, you need to copy paste the offending =
bit
>> and open a MR thread with it. That's not helpful, and it's clear that ki=
nd
>> of thing is not important to the tool providers or users. But it is very
>> important to me as one of the oe-core maintainers.
>>
>>
>>
>>
>>
>>
>>> Also, the older and closed threads can be very helpful when searching
>>> for answers why something has been changed in which way. I know that I =
saw
>>> the email threads on patches as well but found them super hard to read =
(no
>>> syntax highlighting, all black and white, =E2=80=A6). Well, probably I =
could get
>>> used to reading them over time. But then =E2=80=94 why should I if ther=
e are things
>>> like collapsable threads, syntax highlight, color,=E2=80=A6?
>>>
>>
>> You can find a better email client perhaps?
>>
>>
>> Not sure I was clear about what I meant: I was speaking about the closed
>> threads (https://lists.openembedded.org/g/openembedded-core). Is it
>> somehow sortable by open MRs/closed MRs/pure text/issues?
>>
>> So, which email client would I have to install to get a better user
>> experience? What about the other features that make me use the email cli=
ent
>> because of which I which Iike to use that client? Do you expect me to du=
mp
>> them those features and my workflow routines in favour of just
>> openembedded?! Should I have two email clients then? And then hard-copy =
the
>> old mail threads to my HD from how many years?
>>
>> BTW: I just went for the first time to the online thread:
>> https://lists.openembedded.org/g/bitbake-devel/topic/86911583
>> I would probably stop reading that monstrous thread after few seconds.
>>
>> So, to move forward: Maybe you can improve the online threads so that
>> it=E2=80=99s easier to navigate and read those pure retro-black-and-whit=
e threads.
>>
>> Marius
>>
>>
>>
>> PS I=E2=80=99d like to emphasise again:
>> I know I sound harsh. I=E2=80=99m not blaming here and of course I=E2=80=
=99m also not
>> belittling the workflow neither the proficiency of the contributors. I=
=E2=80=99m
>> totally aware that most regular contributors here are extremely highly
>> skilled and work on an incredibly impactful set of software. I=E2=80=99m=
 just
>> providing a very detailed feedback of what I as a really really really
>> really hard wanting-to-become future contributor see what really keeps m=
e
>> from joining.
>>
>>
>>
>> Alex
>>
>>
>>>
>>> Best
>>> Marius
>>>
>>>
>>> Alex
>>>
>>> On Tue, 9 Nov 2021 at 09:05, Marius Kriegerowski <
>>> marius.kriegerowski@gmail.com> wrote:
>>>
>>>> Good morning,
>>>>
>>>> I don=E2=80=99t think this is correct. You can change the git history =
and
>>>> commit messages of every MR to whatever you like with `git commit =E2=
=80=94amend`,
>>>> `git rebase -I` and `git push -f`. So, you can very well ask contribut=
ors
>>>> to cleanup their history before merging.
>>>>
>>>> Best
>>>> Marius
>>>>
>>>> Am Di., 9. Nov. 2021 um 07:47 Uhr schrieb Alexander Kanavin <
>>>> alex.kanavin@gmail.com>:
>>>>
>>>>> There's another problem with github/gitlab which I find significant.
>>>>> These tools do not allow reviewing commit messages, and don't even ma=
ke it
>>>>> easy to see them. So the developers using those tools, both submitter=
s and
>>>>> maintainers, are effectively being conditioned by the tools to see go=
od
>>>>> commit messages as superfluous and unnecessary. And so you more often=
 than
>>>>> not end up with poorly written commit history in github projects, or,=
 if
>>>>> you're a reviewer, have to repeatedly explain to the submitter how to
>>>>> explain and structure their changes properly.
>>>>>
>>>>> I'd rather not have a change, than have a change that no one, even th=
e
>>>>> original author, can understand or remember the reasons for one year =
down
>>>>> the line.
>>>>>
>>>>> Alex
>>>>>
>>>>>
>>>>> On Tue, 9 Nov 2021 at 00:30, Richard Purdie <
>>>>> richard.purdie@linuxfoundation.org> wrote:
>>>>>
>>>>>> On Mon, 2021-11-08 at 23:44 +0100, Marius Kriegerowski wrote:
>>>>>> >
>>>>>> >
>>>>>> > > On 8. Nov 2021, at 22:47, Richard Purdie
>>>>>> > > <richard.purdie@linuxfoundation.org> wrote:
>>>>>> > >
>>>>>> > > On Mon, 2021-11-08 at 18:37 +0100, Marius Kriegerowski wrote:
>>>>>> > > > Is there a plan to switch to some more modern ways to
>>>>>> collaborate on
>>>>>> > > > bitbake,
>>>>>> > > > you know, like, gitlab/github/gitea with issues, PRs and so
>>>>>> forth? I mean=E2=80=A6
>>>>>> > > > it=E2=80=99s
>>>>>> > > > late 2021 and sending MRs/Issues via email feels reaaaally
>>>>>> outdated, slow,
>>>>>> > > > intransparent, ineffective (how to you do reviews, code
>>>>>> comparisons during
>>>>>> > > > reviews, insert suggestions, etc.) and indirect (where is the
>>>>>> CI pipeline
>>>>>> > > > that I
>>>>>> > > > trigger when pushing something somewhere?).
>>>>>> > >
>>>>>> > > There are pros and cons to switching to something else. Keep in
>>>>>> mind that
>>>>>> > > whilst the github workflow works well for a single maintainer of
>>>>>> a project,
>>>>>> > > it does not work well for diverse review.
>>>>>> >
>>>>>> > I strongly disagree with that. Reviews can equally well be done in
>>>>>> a MR
>>>>>> > thread. That=E2=80=99s what they are there for. You can discuss th=
ings
>>>>>> there with as
>>>>>> > many people as you want and can e.g. define a minimum number of
>>>>>> approvals
>>>>>> > before a MR can be merged.
>>>>>>
>>>>>> You misunderstand my point. We have a several thousand people on the
>>>>>> mailing
>>>>>> lists and they filter things to what interests them. *I* have no
>>>>>> people I want
>>>>>> to discuss a given change with, it is a question of whether the
>>>>>> people who have
>>>>>> an interest in a given change would see it.
>>>>>>
>>>>>> A minimum number of approvals is utterly meaningless for how we work=
,
>>>>>> I need the
>>>>>> interested people to see it and that varies massively depending on
>>>>>> what is being
>>>>>> changed. It is this aspect of mailing list change distribution and
>>>>>> discussion we
>>>>>> benefit from.
>>>>>>
>>>>>> >  It also naturally groups discussions. You can address experts for
>>>>>> specific
>>>>>> > domains which means less noise for the experts. I really don=E2=80=
=99t see
>>>>>> why mailing
>>>>>> > list reviews should work any better here.
>>>>>>
>>>>>> We all have established mechanisms to "see" the things which interes=
t
>>>>>> us as
>>>>>> maintainers?
>>>>>>
>>>>>> Please don't misunderstand me, I do see the attraction of github fro=
m
>>>>>> your
>>>>>> perspective. It would just destroy the ecosystem we already have. Yo=
u
>>>>>> are
>>>>>> basically saying that our current ecosystem is worthless but I would
>>>>>> point out
>>>>>> it has resulted in a project which you did say you appreciate so it
>>>>>> can't be all
>>>>>> bad.
>>>>>>
>>>>>> >  If google can coordinate 2.1k repos with 1.1k contributors over
>>>>>> GitHub, why
>>>>>> > should that not work for openembedded??
>>>>>>
>>>>>> It isn't about raw numbers, it is about numbers of reviewers for a
>>>>>> given change.
>>>>>> We have hundreds of people doing that using the mailing lists.
>>>>>>
>>>>>> > > The Bitbake case is a little bit different but in general we'd
>>>>>> follow what
>>>>>> > > OE/Yocto Project are doing.
>>>>>> > >
>>>>>> > > We have discussed changing and it is listed as one topic on:
>>>>>> > > https://wiki.yoctoproject.org/wiki/Future_Directions
>>>>>> > > (Code Submission process)
>>>>>> > >
>>>>>> > > I'd note that it is a huge change to our current developers and
>>>>>> most of us
>>>>>> > > are very used to the mailing lists so if we did change, it would
>>>>>> allow
>>>>>> > > potential new collaborators at the risk of losing people with ke=
y
>>>>>> > > knowledge/experience.
>>>>>> > =E2=80=A6 which reads to me like: =E2=80=9CIt has always been that=
 way so we will
>>>>>> not change
>>>>>> > that" doesn=E2=80=99t it? Always a very poor argument.
>>>>>>
>>>>>> No, what I said is "upsetting our existing developers is something
>>>>>> which we may
>>>>>> want to potentially avoid".
>>>>>>
>>>>>> There are some options out there which have offered mailing list
>>>>>> integration for
>>>>>> example and we have tried to explore those. Something which drops th=
e
>>>>>> lists
>>>>>> entirely could in the current view of the TSC result in loss of too
>>>>>> many of our
>>>>>> existing maintainers.
>>>>>>
>>>>>> >
>>>>>> > > We do have CI which is shared with Yocto Project and
>>>>>> > > OpenEmbedded. You can see it here:
>>>>>> > >
>>>>>> > > https://autobuilder.yoctoproject.org/typhoon/#/console
>>>>>> > >
>>>>>> > > and it has it's own manual which was recently added to our
>>>>>> documentations
>>>>>> > > set:
>>>>>> > >
>>>>>> > > http://docs.yoctoproject.org/test-manual/index.html
>>>>>> > =E2=80=A6 stressing my point: Why does the location of the CI need
>>>>>> documentation? All
>>>>>> > of the aforementioned platforms smoothly integrate with multiple C=
I
>>>>>> solutions,
>>>>>> > drastically reducing the time required for reviews if the pipeline
>>>>>> provides
>>>>>> > automated feedback to the contributor. It would probably cost me
>>>>>> about one
>>>>>> > afternoon to setup a decent CI pipeline at least for all python
>>>>>> codes pushing
>>>>>> > the need to review from manual labor to automated tools. If open
>>>>>> embedded
>>>>>> > migrates to a proper git platform I happily volunteer on that end!=
!
>>>>>>
>>>>>> We're not talking about simple python code. We're talking about
>>>>>> testing a build
>>>>>> environment which cross compiles multiple operating systems for
>>>>>> multiple
>>>>>> architectures, C libraries, GUI stacks, init systems and so on.
>>>>>> Testing the
>>>>>> python code is one small part of that. I've spent several years
>>>>>> trying to
>>>>>> improve and get our CI to where it is today.
>>>>>>
>>>>>> Yes, the python code is tested as part of this as we don't really
>>>>>> want to have
>>>>>> multiple test platforms and the real world usage is some of the best
>>>>>> testing
>>>>>> changes can have.
>>>>>>
>>>>>> > > There is work still needed on that but it is a start. One
>>>>>> challenge of
>>>>>> > > bitbake/OE is that the builds take an age and the test matrix is
>>>>>> huge so the
>>>>>> > > CI
>>>>>> > > process isn't quite as simple as some other simpler projects.
>>>>>> > At least for python I bet that most bugs can be caught simply by
>>>>>> firing up
>>>>>> > `black`, `flake8`, `pylint` (and a hand full of other tools) just
>>>>>> to check the
>>>>>> > modified files.
>>>>>>
>>>>>> Well, I would bet that most of our bugs are not caused by issues lik=
e
>>>>>> that. I do
>>>>>> attend the weekly bug triage meetings and have fixed my share of
>>>>>> them. You could
>>>>>> have a look at the issues filed in bugzilla over the past few weeks
>>>>>> if you'd
>>>>>> like to see the kinds of issues that get filed and are open.
>>>>>>
>>>>>> >  Regarding meta-layers and recipes out there we are currently
>>>>>> pushing forward
>>>>>> > with a linter for bitbake recipes (thanks @priv-kweihmann for this
>>>>>> awesome and
>>>>>> > overdue tool!!!).
>>>>>>
>>>>>> Whilst improving recipes in that way does help, it isn't the main
>>>>>> source of our
>>>>>> major issues.
>>>>>>
>>>>>> > >
>>>>>> > > As a shortcut through things, the "bitbake-selftest" command
>>>>>> within bitbake
>>>>>> > > may
>>>>>> > > be one thing you're looking for which does simple tests on
>>>>>> bitbake. It isn't
>>>>>> > > complete coverage and we welcome more being added, it is a start
>>>>>> and some
>>>>>> > > areas
>>>>>> > > of the code are covered better than others.
>>>>>> > I=E2=80=99d love to overhaul the tests e.g. porting them to `pytes=
t` which
>>>>>> offers a
>>>>>> > much simpler yet much more powerful API/plugin-ecosystem. But won=
=E2=80=99t
>>>>>> do via
>>>>>> > email :)
>>>>>>
>>>>>> The tests are written in python's own unittest.
>>>>>>
>>>>>> > > Issues are filed in the project bugzilla and are actively worked
>>>>>> on:
>>>>>> > >
>>>>>> > > https://bugzilla.yoctoproject.org/
>>>>>> > Didn=E2=80=99t know that. But why keeping issues separate from MRs=
?
>>>>>> Automatic issue
>>>>>> > closing through referencing in MRs is a pretty nice feature=E2=80=
=A6
>>>>>>
>>>>>> If I had to list the pain points we have, this is not high on the
>>>>>> list.
>>>>>>
>>>>>> > > > * side-note on bitbake style/linting: It=E2=80=99s violating P=
EP8 in a
>>>>>> couple of
>>>>>> > > > ways and TBH PEP8 is the bare minimum I would accept these day=
s
>>>>>> for
>>>>>> > > > collaboration on projects the dimension of bitbake. So an
>>>>>> additional
>>>>>> > > > question: Would you be up for a PEP8 compatibility overhaul of
>>>>>> the source
>>>>>> > > > code? I=E2=80=99d volunteer if I don=E2=80=99t have to send a =
patch via email ;)
>>>>>> > >
>>>>>> > > We're interested in patches to improve the coding style as long
>>>>>> as they
>>>>>> > > don't
>>>>>> > > break things like readability or performance. Which rules in PEP=
8
>>>>>> in
>>>>>> > > particular
>>>>>> > > are you referring to?
>>>>>> >
>>>>>> > To name a few violations:
>>>>>> >
>>>>>> >  * hanging indents
>>>>>> >  * inconsistent indentation
>>>>>> >  * 2 separating lines missing in between classes/top level methods
>>>>>>
>>>>>> FWIW I find it really hard to get worked up about whitespace issues.=
 I
>>>>>> appreciate these aren't always great to look at and I appreciate the
>>>>>> familiarity
>>>>>> argument and standardising the look but these aren't issues I would
>>>>>> prioritise.
>>>>>>
>>>>>> In particular changing them globally in mass patches tends to break
>>>>>> patch
>>>>>> backporting and taking fixes back to older code which we do benefit
>>>>>> from being
>>>>>> able to do so there is a cost to doing it. We are trying to make new
>>>>>> code more
>>>>>> consistent and with older code, we do try and fix the worst issues.
>>>>>>
>>>>>> >  * unused imported modules
>>>>>> >  * missing white-spaces after comma
>>>>>> >  * unreachable codes
>>>>>>
>>>>>> These ones we do take patches for and try to fix when/where we see
>>>>>> it. For
>>>>>> example,
>>>>>> http://git.yoctoproject.org/cgit.cgi/poky/commit/?id=3D47e5c456a2043=
2b511
>>>>>> d830df9cbd4113a4352b2c contained a couple of white-space after comma
>>>>>> fixing
>>>>>> while I was in that area.
>>>>>>
>>>>>> > These are just a couple of examples that struck my PEP8 used eye
>>>>>> from looking
>>>>>> > at two, three modules.
>>>>>> >
>>>>>> > It=E2=80=99s just like with any code smell: they don=E2=80=99t nec=
essarily break
>>>>>> things. But
>>>>>> > they make maintenance, code-reviews and quality control harder tha=
n
>>>>>> necessary.
>>>>>> > Code that does not at least follow PEP8 (and I actually strongly
>>>>>> recommend to
>>>>>> > go the extra mile with `black`) just looks odd and is unnecessary
>>>>>> hard to
>>>>>> > read. I=E2=80=99m surprised I have to argue for standards.
>>>>>>
>>>>>> I wasn't saying it was a bad thing, I asked which issues you noticed
>>>>>> in
>>>>>> particular since I'm trying to ensure we do at least try and react t=
o
>>>>>> feedback.
>>>>>> Some whitespace issues we aren't likely to tackle, some like the
>>>>>> others you
>>>>>> mentioned above we should fix.
>>>>>> >
>>>>>> > Besides that, some minor cleanup just to warm
>>>>>> > up: https://github.com/openembedded/bitbake/pull/33,
>>>>>> https://github.com/openem
>>>>>> > bedded/bitbake/pull/32/files
>>>>>>
>>>>>> Those two do look like reasonable changes FWIW.
>>>>>>
>>>>>> > (it was after these two that I found the comment in one of those
>>>>>> old commits
>>>>>> > which made me open https://github.com/openembedded/bitbake/pull/34=
).
>>>>>> At least
>>>>>> > there should be an automated reply to each MR that is posted if
>>>>>> someone makes
>>>>>> > the effort to fix code and open a MRs that this is actually in vei=
n
>>>>>> - That=E2=80=99s
>>>>>> > the mood that took me here :)
>>>>>>
>>>>>> There is a certain irony in that given you patched the section calle=
d
>>>>>> "Contributing" in the README in 32!
>>>>>>
>>>>>> > >
>>>>>> > > Help appreciated but email patches is how we accept them at the
>>>>>> moment.
>>>>>> >
>>>>>> > Not from me then :(
>>>>>>
>>>>>> Sorry to hear that, your changes in 32/33 do look reasonable.
>>>>>>
>>>>>> Cheers,
>>>>>>
>>>>>> Richard
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>
>>
>> Am Di., 9. Nov. 2021 um 09:49 Uhr schrieb <Mikko.Rapeli@bmw.de>:
>>
>>> Hi,
>>>
>>> I'm a heavy user of yocto and bitbake, CI systems and automation, even
>>> Gerrit
>>> and GitHub, yet I also perfer they way email allows for a completely
>>> distributed
>>> review and possibility to follow and join the discussions when ever a
>>> subject
>>> or a change triggers me to respond or hits a nerve. Gerrit, github,
>>> gitlab etc
>>> they just don't scale this well. I understand that for drive-by
>>> contributions working
>>> with email can be tricky if you are not used it, but same goes for
>>> github, gerrit,
>>> gitlab etc.
>>>
>>> This community is also very welcoming, well behaving and helping first
>>> time
>>> contributors. I do see the problem that some first time contributions
>>> may be
>>> see the hurdle of "git send-email" as too hard, especially if corporate
>>> email systems
>>> mangle emails. Maybe some tooling could be setup to allow for pull
>>> request type
>>> contributions to popup on mailing list if sending emails just doesn't
>>> work, but I
>>> don't see the benefits of moving fully to gerrit/github/gitlabl style
>>> development.
>>>
>>> ps. maybe I'm also part of the old generation which still actually read=
s
>>> all emails.
>>> I don't see any of the chat/collaboration tools really replacing email
>>> in global
>>> R&D development world even if chat tools/Slack/MS Teams etc are being
>>> proposed
>>> as replacements (they simply don't scale so well in the end).
>>>
>>> Cheers,
>>>
>>> -Mikko
>>
>>
>>
>>
>>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#12960):
> https://lists.openembedded.org/g/bitbake-devel/message/12960
> Mute This Topic: https://lists.openembedded.org/mt/86911583/6547911
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> marius.kriegerowski@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--00000000000055ac6e05d059cca2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Okay, one thing I have to add after killing some time=
 with this: I quickly scrutinized the git history of `bitbake` and `meta-op=
enembedded`.</div><div><br></div><div>Attached are two figures that show th=
e first time contributor count of both projects over the last ~ten years. W=
hile `bitbake` shows a linear growth of first-time contributors, `meta-open=
embedded` is exponential. I didn&#39;t analyze the first derivative but to =
me it looks like there is a kink following that timestamp indicated by the =
vertical bar. That line represents a subtle, yet important change in intona=
tion in the merge requests. Before that there was always a comment &quot;Pl=
ease read README and send patches to <a href=3D"mailto:openembedded-devel@l=
ists.openembedded.org">openembedded-devel@lists.openembedded.org</a> for re=
view.&quot; or alike. After that the intonation changed to messages &quot;P=
atches should be sent to openembedded-devel as described in README.&quot; a=
nd if I interprete the following MRs correctly the maintainers (mostly @kra=
j) were kind enough to apply the MRs as patches. I&#39;m sure there is a re=
adon not to hit the merge button but instead doing that manually which I do=
n&#39;t understand. But most important point to mention:</div><div><br></di=
v><div>The development of the community around meta-openembedded is what a =
community driven project should look like - the evolution of `bitbake` not =
so much...</div><div><br></div><div>Have a look, reproduce, ask and draw yo=
ur own conclusions.</div><div><br></div><div>Marius<br></div></div><br><div=
 class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Am Di., 9. Nov=
. 2021 um 10:28=C2=A0Uhr schrieb Marius Kriegerowski via <a href=3D"http://=
lists.openembedded.org">lists.openembedded.org</a> &lt;marius.kriegerowski=
=3D<a href=3D"mailto:gmail.com@lists.openembedded.org">gmail.com@lists.open=
embedded.org</a>&gt;:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex"><div dir=3D"ltr"><div>So, I&#39;d like to come to a conclusing with t=
his time consuming thread:</div><div><br></div><div>I shared my view which =
I&#39;m sure many early contributors share. There is a lot of resentment in=
 this developer community against changing the workflow (which dates back m=
ore than a decade) - which I understand. I still think that the inconvenien=
ce when commenting on a commit message (that was the only drawback I found =
legit) does not outweigh the benefits of discussing MRs on one of the platf=
orms mentioned. We disagree on that.<br></div><div><br></div><div>I&#39;m k=
een on adding contributions not only to `meta-openembedded` (which uses git=
hub - thanks for that) but also to `bitbake`. So, I&#39;ll surrender and se=
nd a patch via email. Maybe. One day.<br></div><div><br></div><div>Have a g=
ood day<br></div><div>Marius<br></div></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">Am Di., 9. Nov. 2021 um 10:09=C2=A0Uh=
r schrieb Marius Kriegerowski via <a href=3D"http://lists.openembedded.org"=
 target=3D"_blank">lists.openembedded.org</a> &lt;marius.kriegerowski=3D<a =
href=3D"mailto:gmail.com@lists.openembedded.org" target=3D"_blank">gmail.co=
m@lists.openembedded.org</a>&gt;:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex"><div dir=3D"ltr"><div style=3D"color:rgb(0,0,0);font-fami=
ly:Helvetica;font-size:12px;font-style:normal;font-variant-caps:normal;font=
-weight:normal;letter-spacing:normal;text-align:start;text-indent:0px;text-=
transform:none;white-space:normal;word-spacing:0px;text-decoration:none"><b=
r><br><blockquote type=3D"cite"><div>On 9. Nov 2021, at 09:44, Alexander Ka=
navin &lt;<a href=3D"mailto:alex.kanavin@gmail.com" target=3D"_blank">alex.=
kanavin@gmail.com</a>&gt; wrote:</div><br><div><div dir=3D"ltr"><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, 9 Nov 2021 a=
t 09:32, Marius Kriegerowski &lt;<a href=3D"mailto:marius.kriegerowski@gmai=
l.com" target=3D"_blank">marius.kriegerowski@gmail.com</a>&gt; wrote:<br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><spa=
n style=3D"font-family:Helvetica;font-size:12px;font-style:normal;font-vari=
ant-caps:normal;font-weight:normal;letter-spacing:normal;text-align:start;t=
ext-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;text=
-decoration:none;display:inline;float:none">I see.</span><br style=3D"font-=
family:Helvetica;font-size:12px;font-style:normal;font-variant-caps:normal;=
font-weight:normal;letter-spacing:normal;text-align:start;text-indent:0px;t=
ext-transform:none;white-space:normal;word-spacing:0px;text-decoration:none=
"><div style=3D"font-family:Helvetica;font-size:12px;font-style:normal;font=
-variant-caps:normal;font-weight:normal;letter-spacing:normal;text-align:st=
art;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px=
;text-decoration:none"><br><blockquote type=3D"cite"><div>On 9. Nov 2021, a=
t 09:19, Alexander Kanavin &lt;<a href=3D"mailto:alex.kanavin@gmail.com" ta=
rget=3D"_blank">alex.kanavin@gmail.com</a>&gt; wrote:</div><br><div><div di=
r=3D"ltr"><div>I think you misunderstood me too. It&#39;s about the github =
UI which does its best to hide the commit messages, and doesn&#39;t allow t=
o comment on their content. Yes you can contort yourself and still do it, b=
ut the tools do not help.</div></div></div></blockquote><div><br></div><div=
>I never felt that the commit messages are really that hidden. I mean=E2=80=
=A6 you find them under `commits`... I find that pretty transparent. You ca=
n comment on the commit message content in the thread of the MR, just as yo=
u would in an email thread, can&#39;t you?</div></div></div></blockquote><d=
iv><br></div><div>No. You need to separately go to the commits tab, open ea=
ch commit individually to see both the message and the associated code, the=
n if there&#39;s something you do not like, you need to copy paste the offe=
nding bit and open a MR thread with it. That&#39;s not helpful, and it&#39;=
s clear that kind of thing is not important to the tool providers or users.=
 But it is very important to me as one of the oe-core maintainers.<br></div=
></div></div></div></blockquote><div><br></div><div><br></div><br><blockquo=
te type=3D"cite"><div><div dir=3D"ltr"><div class=3D"gmail_quote"><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"=
><div style=3D"font-family:Helvetica;font-size:12px;font-style:normal;font-=
variant-caps:normal;font-weight:normal;letter-spacing:normal;text-align:sta=
rt;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;=
text-decoration:none"><div>Also, the older and closed threads can be very h=
elpful when searching for answers why something has been changed in which w=
ay. I know that I saw the email threads on patches as well but found them s=
uper hard to read (no syntax highlighting, all black and white, =E2=80=A6).=
 Well, probably I could get used to reading them over time. But then =E2=80=
=94 why should I if there are things like collapsable threads, syntax highl=
ight, color,=E2=80=A6?</div></div></div></blockquote><div><br></div><div>Yo=
u can find a better email client perhaps?<br></div></div></div></div></bloc=
kquote><br>Not sure I was clear about what I meant: I was speaking about th=
e closed threads (<a href=3D"https://lists.openembedded.org/g/openembedded-=
core" target=3D"_blank">https://lists.openembedded.org/g/openembedded-core<=
/a>). Is it somehow sortable by open MRs/closed MRs/pure text/issues?</div>=
<div style=3D"color:rgb(0,0,0);font-family:Helvetica;font-size:12px;font-st=
yle:normal;font-variant-caps:normal;font-weight:normal;letter-spacing:norma=
l;text-align:start;text-indent:0px;text-transform:none;white-space:normal;w=
ord-spacing:0px;text-decoration:none"><br></div><div style=3D"color:rgb(0,0=
,0);font-family:Helvetica;font-size:12px;font-style:normal;font-variant-cap=
s:normal;font-weight:normal;letter-spacing:normal;text-align:start;text-ind=
ent:0px;text-transform:none;white-space:normal;word-spacing:0px;text-decora=
tion:none">So, which email client would I have to install to get a better u=
ser experience? What about the other features that make me use the email cl=
ient because of which I which Iike to use that client? Do you expect me to =
dump them those features and my workflow routines in favour of just openemb=
edded?! Should I have two email clients then? And then hard-copy the old ma=
il threads to my HD from how many years?</div><div style=3D"color:rgb(0,0,0=
);font-family:Helvetica;font-size:12px;font-style:normal;font-variant-caps:=
normal;font-weight:normal;letter-spacing:normal;text-align:start;text-inden=
t:0px;text-transform:none;white-space:normal;word-spacing:0px;text-decorati=
on:none"><br></div><div style=3D"color:rgb(0,0,0);font-family:Helvetica;fon=
t-size:12px;font-style:normal;font-variant-caps:normal;font-weight:normal;l=
etter-spacing:normal;text-align:start;text-indent:0px;text-transform:none;w=
hite-space:normal;word-spacing:0px;text-decoration:none"><div>BTW: I just w=
ent for the first time to the online thread:=C2=A0<a href=3D"https://lists.=
openembedded.org/g/bitbake-devel/topic/86911583" target=3D"_blank">https://=
lists.openembedded.org/g/bitbake-devel/topic/86911583</a></div><div>I would=
 probably stop reading that monstrous thread after few seconds.</div></div>=
<div style=3D"color:rgb(0,0,0);font-family:Helvetica;font-size:12px;font-st=
yle:normal;font-variant-caps:normal;font-weight:normal;letter-spacing:norma=
l;text-align:start;text-indent:0px;text-transform:none;white-space:normal;w=
ord-spacing:0px;text-decoration:none"><br></div><div style=3D"color:rgb(0,0=
,0);font-family:Helvetica;font-size:12px;font-style:normal;font-variant-cap=
s:normal;font-weight:normal;letter-spacing:normal;text-align:start;text-ind=
ent:0px;text-transform:none;white-space:normal;word-spacing:0px;text-decora=
tion:none">So, to move forward: Maybe you can improve the online threads so=
 that it=E2=80=99s easier to navigate and read those pure retro-black-and-w=
hite threads.</div><div style=3D"color:rgb(0,0,0);font-family:Helvetica;fon=
t-size:12px;font-style:normal;font-variant-caps:normal;font-weight:normal;l=
etter-spacing:normal;text-align:start;text-indent:0px;text-transform:none;w=
hite-space:normal;word-spacing:0px;text-decoration:none"><br></div><div sty=
le=3D"color:rgb(0,0,0);font-family:Helvetica;font-size:12px;font-style:norm=
al;font-variant-caps:normal;font-weight:normal;letter-spacing:normal;text-a=
lign:start;text-indent:0px;text-transform:none;white-space:normal;word-spac=
ing:0px;text-decoration:none">Marius</div><div style=3D"color:rgb(0,0,0);fo=
nt-family:Helvetica;font-size:12px;font-style:normal;font-variant-caps:norm=
al;font-weight:normal;letter-spacing:normal;text-align:start;text-indent:0p=
x;text-transform:none;white-space:normal;word-spacing:0px;text-decoration:n=
one"><br></div><div style=3D"color:rgb(0,0,0);font-family:Helvetica;font-si=
ze:12px;font-style:normal;font-variant-caps:normal;font-weight:normal;lette=
r-spacing:normal;text-align:start;text-indent:0px;text-transform:none;white=
-space:normal;word-spacing:0px;text-decoration:none"><br></div><div style=
=3D"color:rgb(0,0,0);font-family:Helvetica;font-size:12px;font-style:normal=
;font-variant-caps:normal;font-weight:normal;letter-spacing:normal;text-ali=
gn:start;text-indent:0px;text-transform:none;white-space:normal;word-spacin=
g:0px;text-decoration:none"><br></div><div style=3D"color:rgb(0,0,0);font-f=
amily:Helvetica;font-size:12px;font-style:normal;font-variant-caps:normal;f=
ont-weight:normal;letter-spacing:normal;text-align:start;text-indent:0px;te=
xt-transform:none;white-space:normal;word-spacing:0px;text-decoration:none"=
><div>PS I=E2=80=99d like to emphasise again:</div><div>I know I sound hars=
h. I=E2=80=99m not blaming here and of course I=E2=80=99m also not belittli=
ng the workflow neither the proficiency of the contributors. I=E2=80=99m to=
tally aware that most regular contributors here are extremely highly skille=
d and work on an incredibly impactful set of software. I=E2=80=99m just pro=
viding a very detailed feedback of what I as a really really really really =
hard wanting-to-become future contributor see what really keeps me from joi=
ning.</div></div><div style=3D"color:rgb(0,0,0);font-family:Helvetica;font-=
size:12px;font-style:normal;font-variant-caps:normal;font-weight:normal;let=
ter-spacing:normal;text-align:start;text-indent:0px;text-transform:none;whi=
te-space:normal;word-spacing:0px;text-decoration:none"><br></div><div style=
=3D"color:rgb(0,0,0);font-family:Helvetica;font-size:12px;font-style:normal=
;font-variant-caps:normal;font-weight:normal;letter-spacing:normal;text-ali=
gn:start;text-indent:0px;text-transform:none;white-space:normal;word-spacin=
g:0px;text-decoration:none"><br></div><div style=3D"color:rgb(0,0,0);font-f=
amily:Helvetica;font-size:12px;font-style:normal;font-variant-caps:normal;f=
ont-weight:normal;letter-spacing:normal;text-align:start;text-indent:0px;te=
xt-transform:none;white-space:normal;word-spacing:0px;text-decoration:none"=
><blockquote type=3D"cite"><div><div dir=3D"ltr"><div class=3D"gmail_quote"=
><div><br></div><div>Alex<br></div><div>=C2=A0</div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex"><div dir=3D"ltr"><div style=3D"font-family:Helve=
tica;font-size:12px;font-style:normal;font-variant-caps:normal;font-weight:=
normal;letter-spacing:normal;text-align:start;text-indent:0px;text-transfor=
m:none;white-space:normal;word-spacing:0px;text-decoration:none"><div><br><=
/div><div>Best</div><div>Marius</div><div><br></div><br><blockquote type=3D=
"cite"><div><div dir=3D"ltr"><div>Alex<br></div></div><br><div class=3D"gma=
il_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, 9 Nov 2021 at 09:05=
, Marius Kriegerowski &lt;<a href=3D"mailto:marius.kriegerowski@gmail.com" =
target=3D"_blank">marius.kriegerowski@gmail.com</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div style=
=3D"font-family:Helvetica;font-size:12px;font-style:normal;font-variant-cap=
s:normal;font-weight:normal;letter-spacing:normal;text-align:start;text-ind=
ent:0px;text-transform:none;white-space:normal;word-spacing:0px;text-decora=
tion:none">Good morning,</div><div style=3D"font-family:Helvetica;font-size=
:12px;font-style:normal;font-variant-caps:normal;font-weight:normal;letter-=
spacing:normal;text-align:start;text-indent:0px;text-transform:none;white-s=
pace:normal;word-spacing:0px;text-decoration:none"><br></div><div style=3D"=
font-family:Helvetica;font-size:12px;font-style:normal;font-variant-caps:no=
rmal;font-weight:normal;letter-spacing:normal;text-align:start;text-indent:=
0px;text-transform:none;white-space:normal;word-spacing:0px;text-decoration=
:none">I don=E2=80=99t think this is correct. You can change the git histor=
y and commit messages of every MR to whatever you like with `git commit =E2=
=80=94amend`, `git rebase -I` and `git push -f`. So, you can very well ask =
contributors to cleanup their history before merging.</div><div style=3D"fo=
nt-family:Helvetica;font-size:12px;font-style:normal;font-variant-caps:norm=
al;font-weight:normal;letter-spacing:normal;text-align:start;text-indent:0p=
x;text-transform:none;white-space:normal;word-spacing:0px;text-decoration:n=
one"><br></div><div style=3D"font-family:Helvetica;font-size:12px;font-styl=
e:normal;font-variant-caps:normal;font-weight:normal;letter-spacing:normal;=
text-align:start;text-indent:0px;text-transform:none;white-space:normal;wor=
d-spacing:0px;text-decoration:none">Best</div><div style=3D"font-family:Hel=
vetica;font-size:12px;font-style:normal;font-variant-caps:normal;font-weigh=
t:normal;letter-spacing:normal;text-align:start;text-indent:0px;text-transf=
orm:none;white-space:normal;word-spacing:0px;text-decoration:none">Marius</=
div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_at=
tr">Am Di., 9. Nov. 2021 um 07:47=C2=A0Uhr schrieb Alexander Kanavin &lt;<a=
 href=3D"mailto:alex.kanavin@gmail.com" target=3D"_blank">alex.kanavin@gmai=
l.com</a>&gt;:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><=
div dir=3D"ltr"><div>There&#39;s another problem with github/gitlab which I=
 find significant. These tools do not allow reviewing commit messages, and =
don&#39;t even make it easy to see them. So the developers using those tool=
s, both submitters and maintainers, are effectively being conditioned by th=
e tools to see good commit messages as superfluous and unnecessary. And so =
you more often than not end up with poorly written commit history in github=
 projects, or, if you&#39;re a reviewer, have to repeatedly explain to the =
submitter how to explain and structure their changes properly.</div><div><b=
r></div><div>I&#39;d rather not have a change, than have a change that no o=
ne, even the original author, can understand or remember the reasons for on=
e year down the line.</div><div><br></div><div>Alex<br></div><br></div><br>=
<div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, 9 =
Nov 2021 at 00:30, Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linu=
xfoundation.org" target=3D"_blank">richard.purdie@linuxfoundation.org</a>&g=
t; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Mon=
, 2021-11-08 at 23:44 +0100, Marius Kriegerowski wrote:<br>&gt;<span>=C2=A0=
</span><br>&gt;<span>=C2=A0</span><br>&gt; &gt; On 8. Nov 2021, at 22:47, R=
ichard Purdie<br>&gt; &gt; &lt;<a href=3D"mailto:richard.purdie@linuxfounda=
tion.org" target=3D"_blank">richard.purdie@linuxfoundation.org</a>&gt; wrot=
e:<br>&gt; &gt;<span>=C2=A0</span><br>&gt; &gt; On Mon, 2021-11-08 at 18:37=
 +0100, Marius Kriegerowski wrote:<br>&gt; &gt; &gt; Is there a plan to swi=
tch to some more modern ways to collaborate on<br>&gt; &gt; &gt; bitbake,<b=
r>&gt; &gt; &gt; you know, like, gitlab/github/gitea with issues, PRs and s=
o forth? I mean=E2=80=A6<br>&gt; &gt; &gt; it=E2=80=99s<br>&gt; &gt; &gt; l=
ate 2021 and sending MRs/Issues via email feels reaaaally outdated, slow,<b=
r>&gt; &gt; &gt; intransparent, ineffective (how to you do reviews, code co=
mparisons during<br>&gt; &gt; &gt; reviews, insert suggestions, etc.) and i=
ndirect (where is the CI pipeline<br>&gt; &gt; &gt; that I<br>&gt; &gt; &gt=
; trigger when pushing something somewhere?).<br>&gt; &gt;<span>=C2=A0</spa=
n><br>&gt; &gt; There are pros and cons to switching to something else. Kee=
p in mind that<br>&gt; &gt; whilst the github workflow works well for a sin=
gle maintainer of a project,<br>&gt; &gt; it does not work well for diverse=
 review.<br>&gt;<br>&gt; I strongly disagree with that. Reviews can equally=
 well be done in a MR<br>&gt; thread. That=E2=80=99s what they are there fo=
r. You can discuss things there with as<br>&gt; many people as you want and=
 can e.g. define a minimum number of approvals<br>&gt; before a MR can be m=
erged.<br><br>You misunderstand my point. We have a several thousand people=
 on the mailing<br>lists and they filter things to what interests them. *I*=
 have no people I want<br>to discuss a given change with, it is a question =
of whether the people who have<br>an interest in a given change would see i=
t.<br><br>A minimum number of approvals is utterly meaningless for how we w=
ork, I need the<br>interested people to see it and that varies massively de=
pending on what is being<br>changed. It is this aspect of mailing list chan=
ge distribution and discussion we<br>benefit from.<br><br>&gt; =C2=A0It als=
o naturally groups discussions. You can address experts for specific<br>&gt=
; domains which means less noise for the experts. I really don=E2=80=99t se=
e why mailing<br>&gt; list reviews should work any better here.<br><br>We a=
ll have established mechanisms to &quot;see&quot; the things which interest=
 us as<br>maintainers?<br><br>Please don&#39;t misunderstand me, I do see t=
he attraction of github from your<br>perspective. It would just destroy the=
 ecosystem we already have. You are<br>basically saying that our current ec=
osystem is worthless but I would point out<br>it has resulted in a project =
which you did say you appreciate so it can&#39;t be all<br>bad.<br><br>&gt;=
 =C2=A0If google can coordinate 2.1k repos with 1.1k contributors over GitH=
ub, why<br>&gt; should that not work for openembedded??<br><br>It isn&#39;t=
 about raw numbers, it is about numbers of reviewers for a given change.<br=
>We have hundreds of people doing that using the mailing lists.<br><br>&gt;=
 &gt; The Bitbake case is a little bit different but in general we&#39;d fo=
llow what<br>&gt; &gt; OE/Yocto Project are doing.<br>&gt; &gt;<span>=C2=A0=
</span><br>&gt; &gt; We have discussed changing and it is listed as one top=
ic on:<br>&gt; &gt;<span>=C2=A0</span><a href=3D"https://wiki.yoctoproject.=
org/wiki/Future_Directions" rel=3D"noreferrer" target=3D"_blank">https://wi=
ki.yoctoproject.org/wiki/Future_Directions</a><br>&gt; &gt; (Code Submissio=
n process)<br>&gt; &gt;<span>=C2=A0</span><br>&gt; &gt; I&#39;d note that i=
t is a huge change to our current developers and most of us<br>&gt; &gt; ar=
e very used to the mailing lists so if we did change, it would allow<br>&gt=
; &gt; potential new collaborators at the risk of losing people with key<br=
>&gt; &gt; knowledge/experience.<br>&gt; =E2=80=A6 which reads to me like: =
=E2=80=9CIt has always been that way so we will not change<br>&gt; that&quo=
t; doesn=E2=80=99t it? Always a very poor argument.<br><br>No, what I said =
is &quot;upsetting our existing developers is something which we may<br>wan=
t to potentially avoid&quot;.<br><br>There are some options out there which=
 have offered mailing list integration for<br>example and we have tried to =
explore those. Something which drops the lists<br>entirely could in the cur=
rent view of the TSC result in loss of too many of our<br>existing maintain=
ers.<br><br>&gt;<span>=C2=A0</span><br>&gt; &gt; We do have CI which is sha=
red with Yocto Project and=C2=A0<br>&gt; &gt; OpenEmbedded. You can see it =
here:<br>&gt; &gt;<span>=C2=A0</span><br>&gt; &gt;<span>=C2=A0</span><a hre=
f=3D"https://autobuilder.yoctoproject.org/typhoon/#/console" rel=3D"norefer=
rer" target=3D"_blank">https://autobuilder.yoctoproject.org/typhoon/#/conso=
le</a><br>&gt; &gt;<span>=C2=A0</span><br>&gt; &gt; and it has it&#39;s own=
 manual which was recently added to our documentations<br>&gt; &gt; set:<br=
>&gt; &gt;<span>=C2=A0</span><br>&gt; &gt;<span>=C2=A0</span><a href=3D"htt=
p://docs.yoctoproject.org/test-manual/index.html" rel=3D"noreferrer" target=
=3D"_blank">http://docs.yoctoproject.org/test-manual/index.html</a><br>&gt;=
 =E2=80=A6 stressing my point: Why does the location of the CI need documen=
tation? All<br>&gt; of the aforementioned platforms smoothly integrate with=
 multiple CI solutions,<br>&gt; drastically reducing the time required for =
reviews if the pipeline provides<br>&gt; automated feedback to the contribu=
tor. It would probably cost me about one<br>&gt; afternoon to setup a decen=
t CI pipeline at least for all python codes pushing<br>&gt; the need to rev=
iew from manual labor to automated tools. If open embedded<br>&gt; migrates=
 to a proper git platform I happily volunteer on that end!!<br><br>We&#39;r=
e not talking about simple python code. We&#39;re talking about testing a b=
uild<br>environment which cross compiles multiple operating systems for mul=
tiple<br>architectures, C libraries, GUI stacks, init systems and so on. Te=
sting the<br>python code is one small part of that. I&#39;ve spent several =
years trying to<br>improve and get our CI to where it is today.<br><br>Yes,=
 the python code is tested as part of this as we don&#39;t really want to h=
ave<br>multiple test platforms and the real world usage is some of the best=
 testing<br>changes can have.<br><br>&gt; &gt; There is work still needed o=
n that but it is a start.=C2=A0One challenge of<br>&gt; &gt; bitbake/OE is =
that the builds take an age and the test matrix is huge so the<br>&gt; &gt;=
 CI<br>&gt; &gt; process isn&#39;t quite as simple as some other simpler pr=
ojects.<br>&gt; At least for python I bet that most bugs can be caught simp=
ly by firing up<br>&gt; `black`, `flake8`, `pylint` (and a hand full of oth=
er tools) just to check the<br>&gt; modified files.<br><br>Well, I would be=
t that most of our bugs are not caused by issues like that. I do<br>attend =
the weekly bug triage meetings and have fixed my share of them. You could<b=
r>have a look at the issues filed in bugzilla over the past few weeks if yo=
u&#39;d<br>like to see the kinds of issues that get filed and are open.<br>=
<br>&gt; =C2=A0Regarding meta-layers and recipes out there we are currently=
 pushing forward<br>&gt; with a linter for bitbake recipes (thanks @priv-kw=
eihmann for this awesome and<br>&gt; overdue tool!!!).<br><br>Whilst improv=
ing recipes in that way does help, it isn&#39;t the main source of our<br>m=
ajor issues.<br><br>&gt; &gt;<span>=C2=A0</span><br>&gt; &gt; As a shortcut=
 through things, the &quot;bitbake-selftest&quot; command within bitbake<br=
>&gt; &gt; may<br>&gt; &gt; be one thing you&#39;re looking for which does =
simple tests on bitbake. It isn&#39;t<br>&gt; &gt; complete coverage and we=
 welcome more being added, it is a start and some<br>&gt; &gt; areas<br>&gt=
; &gt; of the code are covered better than others.<br>&gt; I=E2=80=99d love=
 to overhaul the tests e.g. porting them to `pytest` which offers a<br>&gt;=
 much simpler yet much more powerful API/plugin-ecosystem. But won=E2=80=99=
t do via<br>&gt; email :)<br><br>The tests are written in python&#39;s own =
unittest.<br><br>&gt; &gt; Issues are filed in the project bugzilla and are=
 actively worked on:<br>&gt; &gt;<span>=C2=A0</span><br>&gt; &gt;<span>=C2=
=A0</span><a href=3D"https://bugzilla.yoctoproject.org/" rel=3D"noreferrer"=
 target=3D"_blank">https://bugzilla.yoctoproject.org/</a><br>&gt; Didn=E2=
=80=99t know that. But why keeping issues separate from MRs? Automatic issu=
e<br>&gt; closing through referencing in MRs is a pretty nice feature=E2=80=
=A6<br><br>If I had to list the pain points we have, this is not high on th=
e list.<br><br>&gt; &gt; &gt; * side-note on bitbake style/linting: It=E2=
=80=99s violating PEP8 in a couple of<br>&gt; &gt; &gt; ways and TBH PEP8 i=
s the bare minimum I would accept these days for<br>&gt; &gt; &gt; collabor=
ation on projects the dimension of bitbake. So an additional<br>&gt; &gt; &=
gt; question: Would you be up for a PEP8 compatibility overhaul of the sour=
ce<br>&gt; &gt; &gt; code? I=E2=80=99d volunteer if I don=E2=80=99t have to=
 send a patch via email ;)<br>&gt; &gt;<span>=C2=A0</span><br>&gt; &gt; We&=
#39;re interested in patches to improve the coding style as long as they<br=
>&gt; &gt; don&#39;t<br>&gt; &gt; break things like readability or performa=
nce.=C2=A0Which rules in PEP8 in<br>&gt; &gt; particular<br>&gt; &gt; are y=
ou referring to?<br>&gt;<span>=C2=A0</span><br>&gt; To name a few violation=
s:<br>&gt;<span>=C2=A0</span><br>&gt; =C2=A0* hanging indents<br>&gt; =C2=
=A0* inconsistent indentation<br>&gt; =C2=A0* 2 separating lines missing in=
 between classes/top level methods<br><br>FWIW I find it really hard to get=
 worked up about whitespace issues. I<br>appreciate these aren&#39;t always=
 great to look at and I appreciate the familiarity<br>argument and standard=
ising the look but these aren&#39;t issues I would prioritise.<br><br>In pa=
rticular changing them globally in mass patches tends to break patch<br>bac=
kporting and taking fixes back to older code which we do benefit from being=
<br>able to do so there is a cost to doing it. We are trying to make new co=
de more<br>consistent and with older code, we do try and fix the worst issu=
es.<br><br>&gt; =C2=A0* unused imported modules<br>&gt; =C2=A0* missing whi=
te-spaces after comma<br>&gt; =C2=A0* unreachable codes<br><br>These ones w=
e do take patches for and try to fix when/where we see it. For<br>example,=
=C2=A0<a href=3D"http://git.yoctoproject.org/cgit.cgi/poky/commit/?id=3D47e=
5c456a20432b511d830df9cbd4113a4352b2c" rel=3D"noreferrer" target=3D"_blank"=
>http://git.yoctoproject.org/cgit.cgi/poky/commit/?id=3D47e5c456a20432b511<=
br>d830df9cbd4113a4352b2c</a>=C2=A0contained a couple of white-space after =
comma fixing<br>while I was in that area.<br><br>&gt; These are just a coup=
le of examples that struck my PEP8 used eye from looking<br>&gt; at two, th=
ree modules.<br>&gt;<span>=C2=A0</span><br>&gt; It=E2=80=99s just like with=
 any code smell: they don=E2=80=99t necessarily break things. But<br>&gt; t=
hey make maintenance, code-reviews and quality control harder than necessar=
y.<br>&gt; Code that does not at least follow PEP8 (and I actually strongly=
 recommend to<br>&gt; go the extra mile with `black`) just looks odd and is=
 unnecessary hard to<br>&gt; read. I=E2=80=99m surprised I have to argue fo=
r standards.<br><br>I wasn&#39;t saying it was a bad thing, I asked which i=
ssues you noticed in<br>particular since I&#39;m trying to ensure we do at =
least try and react to feedback.<br>Some whitespace issues we aren&#39;t li=
kely to tackle, some like the others you<br>mentioned above we should fix.<=
br>&gt;<span>=C2=A0</span><br>&gt; Besides that, some minor cleanup just to=
 warm<br>&gt; up:=C2=A0<a href=3D"https://github.com/openembedded/bitbake/p=
ull/33" rel=3D"noreferrer" target=3D"_blank">https://github.com/openembedde=
d/bitbake/pull/33</a>,=C2=A0<a href=3D"https://github.com/openem" rel=3D"no=
referrer" target=3D"_blank">https://github.com/openem</a><br>&gt; bedded/bi=
tbake/pull/32/files=C2=A0<br><br>Those two do look like reasonable changes =
FWIW.<br><br>&gt; (it was after these two that I found the comment in one o=
f those old commits<br>&gt; which made me open=C2=A0<a href=3D"https://gith=
ub.com/openembedded/bitbake/pull/34" rel=3D"noreferrer" target=3D"_blank">h=
ttps://github.com/openembedded/bitbake/pull/34</a>). At least<br>&gt; there=
 should be an=C2=A0automated reply to each MR that is posted if someone mak=
es<br>&gt; the effort to fix code and open a MRs that this is=C2=A0actually=
 in vein - That=E2=80=99s<br>&gt; the=C2=A0mood that took me here :)<br><br=
>There is a certain irony in that given you patched the section called<br>&=
quot;Contributing&quot; in the README in 32!<br><br>&gt; &gt;<span>=C2=A0</=
span><br>&gt; &gt; Help appreciated but email patches is how we accept them=
 at the moment.<br>&gt;<span>=C2=A0</span><br>&gt; Not from me then :(<br><=
br>Sorry to hear that, your changes in 32/33 do look reasonable.<br><br>Che=
ers,<br><br>Richard<br><br><br><br><br></blockquote></div></blockquote></di=
v></blockquote></div></div></blockquote></div></div></blockquote></div></di=
v></div></blockquote></div><br><br></div><br><div class=3D"gmail_quote"><di=
v dir=3D"ltr" class=3D"gmail_attr">Am Di., 9. Nov. 2021 um 09:49=C2=A0Uhr s=
chrieb &lt;<a href=3D"mailto:Mikko.Rapeli@bmw.de" target=3D"_blank">Mikko.R=
apeli@bmw.de</a>&gt;:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">Hi,<br>
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
<br>
<br>
</blockquote></div>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#12960): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/12960" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/12960</a><br>
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

--00000000000055ac6e05d059cca2--

--00000000000055ac6f05d059cca4
Content-Type: image/png; name="fist-time-contributors-bitbake.png"
Content-Disposition: attachment;
	filename="fist-time-contributors-bitbake.png"
Content-Transfer-Encoding: base64
Content-ID: <f_kvs1f2232>
X-Attachment-Id: f_kvs1f2232

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
--00000000000055ac6f05d059cca4
Content-Type: image/png;
	name="first-time-contributors-meta-openembedded.png"
Content-Disposition: attachment;
	filename="first-time-contributors-meta-openembedded.png"
Content-Transfer-Encoding: base64
Content-ID: <f_kvs1f2221>
X-Attachment-Id: f_kvs1f2221

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
AhgAAEAC/w9b42V1P5Ah4wAAAABJRU5ErkJggg==
--00000000000055ac6f05d059cca4
Content-Type: text/x-python-script; charset="US-ASCII";
	name="first_contributors_evaluation.py"
Content-Disposition: attachment; filename="first_contributors_evaluation.py"
Content-Transfer-Encoding: base64
Content-ID: <f_kvs1f21y0>
X-Attachment-Id: f_kvs1f21y0

aW1wb3J0IGRhdGV0aW1lCmltcG9ydCBsb2dnaW5nCmltcG9ydCBzeXMKCmltcG9ydCBtYXRwbG90
bGliLnB5cGxvdCBhcyBwbHQKaW1wb3J0IG51bXB5CmZyb20gZ2l0IGltcG9ydCBSZXBvCgoKIiIi
SW52ZXN0aWdhdGUgdGhlIGRldmVsb3BtZW50IG9mIGZpcnN0IGNvbnRyaWJ1dG9ycyBvZiByZXBv
c2l0b3JpZXMKClNpZ25pZmljYW50IHRpbWVzdGFtcHMgYW5kIHRpbWUgbGltaXRzIGFyZSBoYXJk
IGNvZGVkIHdoaWNoIHNob3VsZCBiZSBhZGp1c3RlZC4KCkRlcGVuZHMgb24gaHR0cHM6Ly9naXRw
eXRob24ucmVhZHRoZWRvY3MuaW8vZW4vc3RhYmxlLwoiIiIKCgppZiBfX25hbWVfXyA9PSAiX19t
YWluX18iOgoKICAgIHBhdGggPSBzeXMuYXJndlstMV0KCiAgICBsb2dnaW5nLmJhc2ljQ29uZmln
KGxldmVsPWxvZ2dpbmcuSU5GTykKICAgIHJlcG8gPSBSZXBvKHBhdGgpCgogICAgYXV0aG9ycyA9
IHNldCgpCiAgICB0aW1lc3RhbXBzID0gW10KICAgIHRtaW5fc3RyID0gIjIwMTItMDEtMDEgMDA6
MDA6MDAiCiAgICB0bWluID0gZGF0ZXRpbWUuZGF0ZXRpbWUuZnJvbWlzb2Zvcm1hdCh0bWluX3N0
cikudGltZXN0YW1wKCkKICAgIHRfc2hvdWxkYmUgPSBkYXRldGltZS5kYXRldGltZS5mcm9taXNv
Zm9ybWF0KCIyMDE4LTAyLTAyIDAwOjAwOjAwIikudGltZXN0YW1wKCkKCiAgICBmb3IgY29tbWl0
IGluIHJlcG8uaXRlcl9jb21taXRzKCJtYXN0ZXIiKToKCiAgICAgICAgYXV0aG9yID0gY29tbWl0
LmF1dGhvcgogICAgICAgIHRpbWVzdGFtcCA9IGNvbW1pdC5jb21taXR0ZWRfZGF0ZXRpbWUudGlt
ZXN0YW1wKCkKCiAgICAgICAgaWYgYXV0aG9yIGluIGF1dGhvcnMgb3IgdGltZXN0YW1wIDw9IHRt
aW46CiAgICAgICAgICAgIGNvbnRpbnVlCiAgICAgICAgZWxzZToKICAgICAgICAgICAgYXV0aG9y
cy5hZGQoYXV0aG9yKQoKICAgICAgICB0aW1lc3RhbXBzLmFwcGVuZChjb21taXQuY29tbWl0dGVk
X2RhdGV0aW1lLnRpbWVzdGFtcCgpKQoKICAgIHRpbWVzdGFtcHMucmV2ZXJzZSgpCiAgICBkYXRh
ID0gbnVtcHkuYXJyYXkoW3RpbWVzdGFtcHMsIHJhbmdlKGxlbih0aW1lc3RhbXBzKSldKQoKICAg
IGF4ID0gcGx0LnN1YnBsb3QoMTExKQogICAgYXguc2V0X3RpdGxlKGYie3BhdGguc3BsaXQoJy8n
KVstMV19XG5GaXJzdCB0aW1lIGNvbnRyaWJ1dG9ycyBzaW5jZSB7dG1pbl9zdHJ9IikKICAgIGF4
LnNldF94bGFiZWwoInRpbWVzdGFtcCIpCiAgICBheC5zZXRfeWxhYmVsKCJmaXJzdCB0aW1lIGNv
bnRyaWJ1dG9yIGNvdW50IikKICAgIGF4LnBsb3QoKmRhdGEpCiAgICBheC5heHZsaW5lKHRfc2hv
dWxkYmUsIGNvbG9yPSJncmV5IikKICAgIGF4LnRleHQodF9zaG91bGRiZSwgMTAsICIgbGlmdGlu
ZyBlbWFpbCBwYXRjaFxuIHJlc3RyaWN0aW9uIGludG9uYXRpb24iKQogICAgYXguc3BpbmVzWyJy
aWdodCJdLnNldF92aXNpYmxlKEZhbHNlKQogICAgYXguc3BpbmVzWyJ0b3AiXS5zZXRfdmlzaWJs
ZShGYWxzZSkKCiAgICBwbHQuc2hvdygpCg==
--00000000000055ac6f05d059cca4--

