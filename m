Return-Path: <marius.kriegerowski@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F67C433EF
	for <webhook@archiver.kernel.org>; Tue,  9 Nov 2021 09:09:28 +0000 (UTC)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com
 [209.85.208.46])
 by mx.groups.io with SMTP id smtpd.web12.9792.1636448967073531905
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 09 Nov 2021 01:09:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=nssOjMSh;
 spf=pass (domain: gmail.com, ip: 209.85.208.46,
 mailfrom: marius.kriegerowski@gmail.com)
Received: by mail-ed1-f46.google.com with SMTP id j21so73676735edt.11
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 09 Nov 2021 01:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Td4/G69O6aNDS5p030HeSowg27Wt8TyR/iy5+ELcbyw=;
        b=nssOjMShDjcnA4xEd5nT9hx0yjq/opApE4IE7BdMGj95m1YAAPQ5Fn6/F9LRYzHZOS
         VEDxhJtuikpftebz61gW5sOZ1ouX3HijhdkfvD/Y+2uQBjxXnxDE1Xo05qF9j4jW8VGO
         hIQiWAfHMyHOONAkdr0bfBs2jWjhv6jzQelTICnqbpzkit5t845vhpzZiWt0WcsM0uJ2
         e79LT0TfecF/HmzD/u73zPoOWjSDwWk1U65Rn1P/6v8i0aHsH/Xyjb548dKG4St4Pk3C
         +ZKneJvZpv3orcEcUxgqRutJTu/m8t2YrjoZeUdym1ZG41SWUU4TDrMJsJfdshla/po9
         NCXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Td4/G69O6aNDS5p030HeSowg27Wt8TyR/iy5+ELcbyw=;
        b=w8OUreNdRywip/y8tuj9/5Q0dJh3QtGH54+ewfyvJeBoEagdRUL51TJBnVJjKVcpNg
         Li98TJrxSeO3g86HG1g03XMopfUznfef+GR2st+xUM7ytgaSet0zWVmDjEMhr2owbIUg
         2KlakwicWg9OpXs9nj8VFxCstRpNPY73yuYEqGugKjl9Cffo+Y8oJEakDmEg7pOFFOjQ
         sATMK8mFHMkzs3CPAxU9mOR7FmAb868q2XrPOCGPn5K8bKci1I1vEvgZCy99G4F3yLc7
         jApCEumQ//xvEJ78SAvy68WW0obGTEU/Qr6qDgaagxBz/qC7Yr6MMswNWPPMXGwSiIc8
         iZ4Q==
X-Gm-Message-State: AOAM530oCVBvdyBImqsSPWltx3sxmxAVXAxFOBgBmyQq8UFUP2gSk7lw
	twO0cmlx3G8uWgseSZST64YWLkxLJTeyt2Tovz0=
X-Google-Smtp-Source: 
 ABdhPJy/KEAmYBhzyNzqc6bW0zsNBtIhUylpbai3QF3FB2nhSnUd7lB1S5q6C4plNVHTxvDXSasCYXEjsWgaWFb7ORk=
X-Received: by 2002:a05:6402:d0a:: with SMTP id
 eb10mr8005138edb.186.1636448965179;
 Tue, 09 Nov 2021 01:09:25 -0800 (PST)
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
 <YYo2KsoUeMTZ6y5C@korppu>
In-Reply-To: <YYo2KsoUeMTZ6y5C@korppu>
From: Marius Kriegerowski <marius.kriegerowski@gmail.com>
Date: Tue, 9 Nov 2021 10:09:14 +0100
Message-ID: 
 <CAMaS9hPNe+eTohTUReRDMVa9ZuGgZTDCaK60GLKBy-NRvsxnpA@mail.gmail.com>
Subject: Re: [bitbake-devel] bitbake style/workflow
To: Mikko.Rapeli@bmw.de
Cc: Alexander Kanavin <alex.kanavin@gmail.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="000000000000433df405d057778f"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 09 Nov 2021 09:09:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12959

--000000000000433df405d057778f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 9. Nov 2021, at 09:44, Alexander Kanavin <alex.kanavin@gmail.com> wrote:

On Tue, 9 Nov 2021 at 09:32, Marius Kriegerowski <
marius.kriegerowski@gmail.com> wrote:

> I see.
>
> On 9. Nov 2021, at 09:19, Alexander Kanavin <alex.kanavin@gmail.com>
> wrote:
>
> I think you misunderstood me too. It's about the github UI which does its
> best to hide the commit messages, and doesn't allow to comment on their
> content. Yes you can contort yourself and still do it, but the tools do n=
ot
> help.
>
>
> I never felt that the commit messages are really that hidden. I mean=E2=
=80=A6 you
> find them under `commits`... I find that pretty transparent. You can
> comment on the commit message content in the thread of the MR, just as yo=
u
> would in an email thread, can't you?
>

No. You need to separately go to the commits tab, open each commit
individually to see both the message and the associated code, then if
there's something you do not like, you need to copy paste the offending bit
and open a MR thread with it. That's not helpful, and it's clear that kind
of thing is not important to the tool providers or users. But it is very
important to me as one of the oe-core maintainers.






> Also, the older and closed threads can be very helpful when searching for
> answers why something has been changed in which way. I know that I saw th=
e
> email threads on patches as well but found them super hard to read (no
> syntax highlighting, all black and white, =E2=80=A6). Well, probably I co=
uld get
> used to reading them over time. But then =E2=80=94 why should I if there =
are things
> like collapsable threads, syntax highlight, color,=E2=80=A6?
>

You can find a better email client perhaps?


Not sure I was clear about what I meant: I was speaking about the closed
threads (https://lists.openembedded.org/g/openembedded-core). Is it somehow
sortable by open MRs/closed MRs/pure text/issues?

So, which email client would I have to install to get a better user
experience? What about the other features that make me use the email client
because of which I which Iike to use that client? Do you expect me to dump
them those features and my workflow routines in favour of just
openembedded?! Should I have two email clients then? And then hard-copy the
old mail threads to my HD from how many years?

BTW: I just went for the first time to the online thread:
https://lists.openembedded.org/g/bitbake-devel/topic/86911583
I would probably stop reading that monstrous thread after few seconds.

So, to move forward: Maybe you can improve the online threads so that it=E2=
=80=99s
easier to navigate and read those pure retro-black-and-white threads.

Marius



PS I=E2=80=99d like to emphasise again:
I know I sound harsh. I=E2=80=99m not blaming here and of course I=E2=80=99=
m also not
belittling the workflow neither the proficiency of the contributors. I=E2=
=80=99m
totally aware that most regular contributors here are extremely highly
skilled and work on an incredibly impactful set of software. I=E2=80=99m ju=
st
providing a very detailed feedback of what I as a really really really
really hard wanting-to-become future contributor see what really keeps me
from joining.



Alex


>
> Best
> Marius
>
>
> Alex
>
> On Tue, 9 Nov 2021 at 09:05, Marius Kriegerowski <
> marius.kriegerowski@gmail.com> wrote:
>
>> Good morning,
>>
>> I don=E2=80=99t think this is correct. You can change the git history an=
d commit
>> messages of every MR to whatever you like with `git commit =E2=80=94amen=
d`, `git
>> rebase -I` and `git push -f`. So, you can very well ask contributors to
>> cleanup their history before merging.
>>
>> Best
>> Marius
>>
>> Am Di., 9. Nov. 2021 um 07:47 Uhr schrieb Alexander Kanavin <
>> alex.kanavin@gmail.com>:
>>
>>> There's another problem with github/gitlab which I find significant.
>>> These tools do not allow reviewing commit messages, and don't even make=
 it
>>> easy to see them. So the developers using those tools, both submitters =
and
>>> maintainers, are effectively being conditioned by the tools to see good
>>> commit messages as superfluous and unnecessary. And so you more often t=
han
>>> not end up with poorly written commit history in github projects, or, i=
f
>>> you're a reviewer, have to repeatedly explain to the submitter how to
>>> explain and structure their changes properly.
>>>
>>> I'd rather not have a change, than have a change that no one, even the
>>> original author, can understand or remember the reasons for one year do=
wn
>>> the line.
>>>
>>> Alex
>>>
>>>
>>> On Tue, 9 Nov 2021 at 00:30, Richard Purdie <
>>> richard.purdie@linuxfoundation.org> wrote:
>>>
>>>> On Mon, 2021-11-08 at 23:44 +0100, Marius Kriegerowski wrote:
>>>> >
>>>> >
>>>> > > On 8. Nov 2021, at 22:47, Richard Purdie
>>>> > > <richard.purdie@linuxfoundation.org> wrote:
>>>> > >
>>>> > > On Mon, 2021-11-08 at 18:37 +0100, Marius Kriegerowski wrote:
>>>> > > > Is there a plan to switch to some more modern ways to collaborat=
e
>>>> on
>>>> > > > bitbake,
>>>> > > > you know, like, gitlab/github/gitea with issues, PRs and so
>>>> forth? I mean=E2=80=A6
>>>> > > > it=E2=80=99s
>>>> > > > late 2021 and sending MRs/Issues via email feels reaaaally
>>>> outdated, slow,
>>>> > > > intransparent, ineffective (how to you do reviews, code
>>>> comparisons during
>>>> > > > reviews, insert suggestions, etc.) and indirect (where is the CI
>>>> pipeline
>>>> > > > that I
>>>> > > > trigger when pushing something somewhere?).
>>>> > >
>>>> > > There are pros and cons to switching to something else. Keep in
>>>> mind that
>>>> > > whilst the github workflow works well for a single maintainer of a
>>>> project,
>>>> > > it does not work well for diverse review.
>>>> >
>>>> > I strongly disagree with that. Reviews can equally well be done in a
>>>> MR
>>>> > thread. That=E2=80=99s what they are there for. You can discuss thin=
gs there
>>>> with as
>>>> > many people as you want and can e.g. define a minimum number of
>>>> approvals
>>>> > before a MR can be merged.
>>>>
>>>> You misunderstand my point. We have a several thousand people on the
>>>> mailing
>>>> lists and they filter things to what interests them. *I* have no peopl=
e
>>>> I want
>>>> to discuss a given change with, it is a question of whether the people
>>>> who have
>>>> an interest in a given change would see it.
>>>>
>>>> A minimum number of approvals is utterly meaningless for how we work, =
I
>>>> need the
>>>> interested people to see it and that varies massively depending on wha=
t
>>>> is being
>>>> changed. It is this aspect of mailing list change distribution and
>>>> discussion we
>>>> benefit from.
>>>>
>>>> >  It also naturally groups discussions. You can address experts for
>>>> specific
>>>> > domains which means less noise for the experts. I really don=E2=80=
=99t see
>>>> why mailing
>>>> > list reviews should work any better here.
>>>>
>>>> We all have established mechanisms to "see" the things which interest
>>>> us as
>>>> maintainers?
>>>>
>>>> Please don't misunderstand me, I do see the attraction of github from
>>>> your
>>>> perspective. It would just destroy the ecosystem we already have. You
>>>> are
>>>> basically saying that our current ecosystem is worthless but I would
>>>> point out
>>>> it has resulted in a project which you did say you appreciate so it
>>>> can't be all
>>>> bad.
>>>>
>>>> >  If google can coordinate 2.1k repos with 1.1k contributors over
>>>> GitHub, why
>>>> > should that not work for openembedded??
>>>>
>>>> It isn't about raw numbers, it is about numbers of reviewers for a
>>>> given change.
>>>> We have hundreds of people doing that using the mailing lists.
>>>>
>>>> > > The Bitbake case is a little bit different but in general we'd
>>>> follow what
>>>> > > OE/Yocto Project are doing.
>>>> > >
>>>> > > We have discussed changing and it is listed as one topic on:
>>>> > > https://wiki.yoctoproject.org/wiki/Future_Directions
>>>> > > (Code Submission process)
>>>> > >
>>>> > > I'd note that it is a huge change to our current developers and
>>>> most of us
>>>> > > are very used to the mailing lists so if we did change, it would
>>>> allow
>>>> > > potential new collaborators at the risk of losing people with key
>>>> > > knowledge/experience.
>>>> > =E2=80=A6 which reads to me like: =E2=80=9CIt has always been that w=
ay so we will not
>>>> change
>>>> > that" doesn=E2=80=99t it? Always a very poor argument.
>>>>
>>>> No, what I said is "upsetting our existing developers is something
>>>> which we may
>>>> want to potentially avoid".
>>>>
>>>> There are some options out there which have offered mailing list
>>>> integration for
>>>> example and we have tried to explore those. Something which drops the
>>>> lists
>>>> entirely could in the current view of the TSC result in loss of too
>>>> many of our
>>>> existing maintainers.
>>>>
>>>> >
>>>> > > We do have CI which is shared with Yocto Project and
>>>> > > OpenEmbedded. You can see it here:
>>>> > >
>>>> > > https://autobuilder.yoctoproject.org/typhoon/#/console
>>>> > >
>>>> > > and it has it's own manual which was recently added to our
>>>> documentations
>>>> > > set:
>>>> > >
>>>> > > http://docs.yoctoproject.org/test-manual/index.html
>>>> > =E2=80=A6 stressing my point: Why does the location of the CI need
>>>> documentation? All
>>>> > of the aforementioned platforms smoothly integrate with multiple CI
>>>> solutions,
>>>> > drastically reducing the time required for reviews if the pipeline
>>>> provides
>>>> > automated feedback to the contributor. It would probably cost me
>>>> about one
>>>> > afternoon to setup a decent CI pipeline at least for all python code=
s
>>>> pushing
>>>> > the need to review from manual labor to automated tools. If open
>>>> embedded
>>>> > migrates to a proper git platform I happily volunteer on that end!!
>>>>
>>>> We're not talking about simple python code. We're talking about testin=
g
>>>> a build
>>>> environment which cross compiles multiple operating systems for multip=
le
>>>> architectures, C libraries, GUI stacks, init systems and so on. Testin=
g
>>>> the
>>>> python code is one small part of that. I've spent several years trying
>>>> to
>>>> improve and get our CI to where it is today.
>>>>
>>>> Yes, the python code is tested as part of this as we don't really want
>>>> to have
>>>> multiple test platforms and the real world usage is some of the best
>>>> testing
>>>> changes can have.
>>>>
>>>> > > There is work still needed on that but it is a start. One challeng=
e
>>>> of
>>>> > > bitbake/OE is that the builds take an age and the test matrix is
>>>> huge so the
>>>> > > CI
>>>> > > process isn't quite as simple as some other simpler projects.
>>>> > At least for python I bet that most bugs can be caught simply by
>>>> firing up
>>>> > `black`, `flake8`, `pylint` (and a hand full of other tools) just to
>>>> check the
>>>> > modified files.
>>>>
>>>> Well, I would bet that most of our bugs are not caused by issues like
>>>> that. I do
>>>> attend the weekly bug triage meetings and have fixed my share of them.
>>>> You could
>>>> have a look at the issues filed in bugzilla over the past few weeks if
>>>> you'd
>>>> like to see the kinds of issues that get filed and are open.
>>>>
>>>> >  Regarding meta-layers and recipes out there we are currently pushin=
g
>>>> forward
>>>> > with a linter for bitbake recipes (thanks @priv-kweihmann for this
>>>> awesome and
>>>> > overdue tool!!!).
>>>>
>>>> Whilst improving recipes in that way does help, it isn't the main
>>>> source of our
>>>> major issues.
>>>>
>>>> > >
>>>> > > As a shortcut through things, the "bitbake-selftest" command withi=
n
>>>> bitbake
>>>> > > may
>>>> > > be one thing you're looking for which does simple tests on bitbake=
.
>>>> It isn't
>>>> > > complete coverage and we welcome more being added, it is a start
>>>> and some
>>>> > > areas
>>>> > > of the code are covered better than others.
>>>> > I=E2=80=99d love to overhaul the tests e.g. porting them to `pytest`=
 which
>>>> offers a
>>>> > much simpler yet much more powerful API/plugin-ecosystem. But won=E2=
=80=99t
>>>> do via
>>>> > email :)
>>>>
>>>> The tests are written in python's own unittest.
>>>>
>>>> > > Issues are filed in the project bugzilla and are actively worked o=
n:
>>>> > >
>>>> > > https://bugzilla.yoctoproject.org/
>>>> > Didn=E2=80=99t know that. But why keeping issues separate from MRs? =
Automatic
>>>> issue
>>>> > closing through referencing in MRs is a pretty nice feature=E2=80=A6
>>>>
>>>> If I had to list the pain points we have, this is not high on the list=
.
>>>>
>>>> > > > * side-note on bitbake style/linting: It=E2=80=99s violating PEP=
8 in a
>>>> couple of
>>>> > > > ways and TBH PEP8 is the bare minimum I would accept these days
>>>> for
>>>> > > > collaboration on projects the dimension of bitbake. So an
>>>> additional
>>>> > > > question: Would you be up for a PEP8 compatibility overhaul of
>>>> the source
>>>> > > > code? I=E2=80=99d volunteer if I don=E2=80=99t have to send a pa=
tch via email ;)
>>>> > >
>>>> > > We're interested in patches to improve the coding style as long as
>>>> they
>>>> > > don't
>>>> > > break things like readability or performance. Which rules in PEP8 =
in
>>>> > > particular
>>>> > > are you referring to?
>>>> >
>>>> > To name a few violations:
>>>> >
>>>> >  * hanging indents
>>>> >  * inconsistent indentation
>>>> >  * 2 separating lines missing in between classes/top level methods
>>>>
>>>> FWIW I find it really hard to get worked up about whitespace issues. I
>>>> appreciate these aren't always great to look at and I appreciate the
>>>> familiarity
>>>> argument and standardising the look but these aren't issues I would
>>>> prioritise.
>>>>
>>>> In particular changing them globally in mass patches tends to break
>>>> patch
>>>> backporting and taking fixes back to older code which we do benefit
>>>> from being
>>>> able to do so there is a cost to doing it. We are trying to make new
>>>> code more
>>>> consistent and with older code, we do try and fix the worst issues.
>>>>
>>>> >  * unused imported modules
>>>> >  * missing white-spaces after comma
>>>> >  * unreachable codes
>>>>
>>>> These ones we do take patches for and try to fix when/where we see it.
>>>> For
>>>> example,
>>>> http://git.yoctoproject.org/cgit.cgi/poky/commit/?id=3D47e5c456a20432b=
511
>>>> d830df9cbd4113a4352b2c contained a couple of white-space after comma
>>>> fixing
>>>> while I was in that area.
>>>>
>>>> > These are just a couple of examples that struck my PEP8 used eye fro=
m
>>>> looking
>>>> > at two, three modules.
>>>> >
>>>> > It=E2=80=99s just like with any code smell: they don=E2=80=99t neces=
sarily break
>>>> things. But
>>>> > they make maintenance, code-reviews and quality control harder than
>>>> necessary.
>>>> > Code that does not at least follow PEP8 (and I actually strongly
>>>> recommend to
>>>> > go the extra mile with `black`) just looks odd and is unnecessary
>>>> hard to
>>>> > read. I=E2=80=99m surprised I have to argue for standards.
>>>>
>>>> I wasn't saying it was a bad thing, I asked which issues you noticed i=
n
>>>> particular since I'm trying to ensure we do at least try and react to
>>>> feedback.
>>>> Some whitespace issues we aren't likely to tackle, some like the other=
s
>>>> you
>>>> mentioned above we should fix.
>>>> >
>>>> > Besides that, some minor cleanup just to warm
>>>> > up: https://github.com/openembedded/bitbake/pull/33,
>>>> https://github.com/openem
>>>> > bedded/bitbake/pull/32/files
>>>>
>>>> Those two do look like reasonable changes FWIW.
>>>>
>>>> > (it was after these two that I found the comment in one of those old
>>>> commits
>>>> > which made me open https://github.com/openembedded/bitbake/pull/34).
>>>> At least
>>>> > there should be an automated reply to each MR that is posted if
>>>> someone makes
>>>> > the effort to fix code and open a MRs that this is actually in vein =
-
>>>> That=E2=80=99s
>>>> > the mood that took me here :)
>>>>
>>>> There is a certain irony in that given you patched the section called
>>>> "Contributing" in the README in 32!
>>>>
>>>> > >
>>>> > > Help appreciated but email patches is how we accept them at the
>>>> moment.
>>>> >
>>>> > Not from me then :(
>>>>
>>>> Sorry to hear that, your changes in 32/33 do look reasonable.
>>>>
>>>> Cheers,
>>>>
>>>> Richard
>>>>
>>>>
>>>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>>>> Links: You receive all messages sent to this group.
>>>> View/Reply Online (#12951):
>>>> https://lists.openembedded.org/g/bitbake-devel/message/12951
>>>> Mute This Topic: https://lists.openembedded.org/mt/86911583/1686489
>>>> Group Owner: bitbake-devel+owner@lists.openembedded.org
>>>> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
>>>> alex.kanavin@gmail.com]
>>>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>>>>
>>>>
>
>
> Am Di., 9. Nov. 2021 um 09:19 Uhr schrieb Alexander Kanavin <
> alex.kanavin@gmail.com>:
>
>> I think you misunderstood me too. It's about the github UI which does it=
s
>> best to hide the commit messages, and doesn't allow to comment on their
>> content. Yes you can contort yourself and still do it, but the tools do =
not
>> help.
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
>>>>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>>>>> Links: You receive all messages sent to this group.
>>>>> View/Reply Online (#12951):
>>>>> https://lists.openembedded.org/g/bitbake-devel/message/12951
>>>>> Mute This Topic: https://lists.openembedded.org/mt/86911583/1686489
>>>>> Group Owner: bitbake-devel+owner@lists.openembedded.org
>>>>> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
>>>>> alex.kanavin@gmail.com]
>>>>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>>>>>
>>>>>


Am Di., 9. Nov. 2021 um 09:49 Uhr schrieb <Mikko.Rapeli@bmw.de>:

> Hi,
>
> I'm a heavy user of yocto and bitbake, CI systems and automation, even
> Gerrit
> and GitHub, yet I also perfer they way email allows for a completely
> distributed
> review and possibility to follow and join the discussions when ever a
> subject
> or a change triggers me to respond or hits a nerve. Gerrit, github, gitla=
b
> etc
> they just don't scale this well. I understand that for drive-by
> contributions working
> with email can be tricky if you are not used it, but same goes for github=
,
> gerrit,
> gitlab etc.
>
> This community is also very welcoming, well behaving and helping first ti=
me
> contributors. I do see the problem that some first time contributions may
> be
> see the hurdle of "git send-email" as too hard, especially if corporate
> email systems
> mangle emails. Maybe some tooling could be setup to allow for pull reques=
t
> type
> contributions to popup on mailing list if sending emails just doesn't
> work, but I
> don't see the benefits of moving fully to gerrit/github/gitlabl style
> development.
>
> ps. maybe I'm also part of the old generation which still actually reads
> all emails.
> I don't see any of the chat/collaboration tools really replacing email in
> global
> R&D development world even if chat tools/Slack/MS Teams etc are being
> proposed
> as replacements (they simply don't scale so well in the end).
>
> Cheers,
>
> -Mikko

--000000000000433df405d057778f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div style=3D"color:rgb(0,0,0);font-family:Helvetica;font-=
size:12px;font-style:normal;font-variant-caps:normal;font-weight:normal;let=
ter-spacing:normal;text-align:start;text-indent:0px;text-transform:none;whi=
te-space:normal;word-spacing:0px;text-decoration:none"><br class=3D"gmail-A=
pple-interchange-newline"><br class=3D"gmail-"><blockquote type=3D"cite" cl=
ass=3D"gmail-"><div class=3D"gmail-">On 9. Nov 2021, at 09:44, Alexander Ka=
navin &lt;<a href=3D"mailto:alex.kanavin@gmail.com" class=3D"gmail-">alex.k=
anavin@gmail.com</a>&gt; wrote:</div><br class=3D"gmail-Apple-interchange-n=
ewline"><div class=3D"gmail-"><div dir=3D"ltr" class=3D"gmail-"><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, 9 Nov 2021 a=
t 09:32, Marius Kriegerowski &lt;<a href=3D"mailto:marius.kriegerowski@gmai=
l.com" class=3D"gmail-">marius.kriegerowski@gmail.com</a>&gt; wrote:<br cla=
ss=3D"gmail-"></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div =
dir=3D"ltr" class=3D"gmail-"><span class=3D"gmail-" style=3D"font-family:He=
lvetica;font-size:12px;font-style:normal;font-variant-caps:normal;font-weig=
ht:normal;letter-spacing:normal;text-align:start;text-indent:0px;text-trans=
form:none;white-space:normal;word-spacing:0px;text-decoration:none;display:=
inline;float:none">I see.</span><br class=3D"gmail-" style=3D"font-family:H=
elvetica;font-size:12px;font-style:normal;font-variant-caps:normal;font-wei=
ght:normal;letter-spacing:normal;text-align:start;text-indent:0px;text-tran=
sform:none;white-space:normal;word-spacing:0px;text-decoration:none"><div c=
lass=3D"gmail-" style=3D"font-family:Helvetica;font-size:12px;font-style:no=
rmal;font-variant-caps:normal;font-weight:normal;letter-spacing:normal;text=
-align:start;text-indent:0px;text-transform:none;white-space:normal;word-sp=
acing:0px;text-decoration:none"><br class=3D"gmail-"><blockquote type=3D"ci=
te" class=3D"gmail-"><div class=3D"gmail-">On 9. Nov 2021, at 09:19, Alexan=
der Kanavin &lt;<a href=3D"mailto:alex.kanavin@gmail.com" target=3D"_blank"=
 class=3D"gmail-">alex.kanavin@gmail.com</a>&gt; wrote:</div><br class=3D"g=
mail-"><div class=3D"gmail-"><div dir=3D"ltr" class=3D"gmail-"><div class=
=3D"gmail-">I think you misunderstood me too. It&#39;s about the github UI =
which does its best to hide the commit messages, and doesn&#39;t allow to c=
omment on their content. Yes you can contort yourself and still do it, but =
the tools do not help.</div></div></div></blockquote><div class=3D"gmail-">=
<br class=3D"gmail-"></div><div class=3D"gmail-">I never felt that the comm=
it messages are really that hidden. I mean=E2=80=A6 you find them under `co=
mmits`... I find that pretty transparent. You can comment on the commit mes=
sage content in the thread of the MR, just as you would in an email thread,=
 can&#39;t you?</div></div></div></blockquote><div class=3D"gmail-"><br cla=
ss=3D"gmail-"></div><div class=3D"gmail-">No. You need to separately go to =
the commits tab, open each commit individually to see both the message and =
the associated code, then if there&#39;s something you do not like, you nee=
d to copy paste the offending bit and open a MR thread with it. That&#39;s =
not helpful, and it&#39;s clear that kind of thing is not important to the =
tool providers or users. But it is very important to me as one of the oe-co=
re maintainers.<br class=3D"gmail-"></div></div></div></div></blockquote><d=
iv><br class=3D"gmail-"></div><div><br class=3D"gmail-"></div><br class=3D"=
gmail-"><blockquote type=3D"cite" class=3D"gmail-"><div class=3D"gmail-"><d=
iv dir=3D"ltr" class=3D"gmail-"><div class=3D"gmail_quote"><div class=3D"gm=
ail-">=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div di=
r=3D"ltr" class=3D"gmail-"><div class=3D"gmail-" style=3D"font-family:Helve=
tica;font-size:12px;font-style:normal;font-variant-caps:normal;font-weight:=
normal;letter-spacing:normal;text-align:start;text-indent:0px;text-transfor=
m:none;white-space:normal;word-spacing:0px;text-decoration:none"><div class=
=3D"gmail-">Also, the older and closed threads can be very helpful when sea=
rching for answers why something has been changed in which way. I know that=
 I saw the email threads on patches as well but found them super hard to re=
ad (no syntax highlighting, all black and white, =E2=80=A6). Well, probably=
 I could get used to reading them over time. But then =E2=80=94 why should =
I if there are things like collapsable threads, syntax highlight, color,=E2=
=80=A6?</div></div></div></blockquote><div class=3D"gmail-"><br class=3D"gm=
ail-"></div><div class=3D"gmail-">You can find a better email client perhap=
s?<br class=3D"gmail-"></div></div></div></div></blockquote><br class=3D"gm=
ail-">Not sure I was clear about what I meant: I was speaking about the clo=
sed threads (<a href=3D"https://lists.openembedded.org/g/openembedded-core"=
 class=3D"gmail-">https://lists.openembedded.org/g/openembedded-core</a>). =
Is it somehow sortable by open MRs/closed MRs/pure text/issues?</div><div s=
tyle=3D"color:rgb(0,0,0);font-family:Helvetica;font-size:12px;font-style:no=
rmal;font-variant-caps:normal;font-weight:normal;letter-spacing:normal;text=
-align:start;text-indent:0px;text-transform:none;white-space:normal;word-sp=
acing:0px;text-decoration:none"><br class=3D"gmail-"></div><div style=3D"co=
lor:rgb(0,0,0);font-family:Helvetica;font-size:12px;font-style:normal;font-=
variant-caps:normal;font-weight:normal;letter-spacing:normal;text-align:sta=
rt;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;=
text-decoration:none">So, which email client would I have to install to get=
 a better user experience? What about the other features that make me use t=
he email client because of which I which Iike to use that client? Do you ex=
pect me to dump them those features and my workflow routines in favour of j=
ust openembedded?! Should I have two email clients then? And then hard-copy=
 the old mail threads to my HD from how many years?</div><div style=3D"colo=
r:rgb(0,0,0);font-family:Helvetica;font-size:12px;font-style:normal;font-va=
riant-caps:normal;font-weight:normal;letter-spacing:normal;text-align:start=
;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;te=
xt-decoration:none"><br class=3D"gmail-"></div><div style=3D"color:rgb(0,0,=
0);font-family:Helvetica;font-size:12px;font-style:normal;font-variant-caps=
:normal;font-weight:normal;letter-spacing:normal;text-align:start;text-inde=
nt:0px;text-transform:none;white-space:normal;word-spacing:0px;text-decorat=
ion:none"><div>BTW: I just went for the first time to the online thread:=C2=
=A0<a href=3D"https://lists.openembedded.org/g/bitbake-devel/topic/86911583=
" class=3D"gmail-">https://lists.openembedded.org/g/bitbake-devel/topic/869=
11583</a></div><div>I would probably stop reading that monstrous thread aft=
er few seconds.</div></div><div style=3D"color:rgb(0,0,0);font-family:Helve=
tica;font-size:12px;font-style:normal;font-variant-caps:normal;font-weight:=
normal;letter-spacing:normal;text-align:start;text-indent:0px;text-transfor=
m:none;white-space:normal;word-spacing:0px;text-decoration:none"><br class=
=3D"gmail-"></div><div style=3D"color:rgb(0,0,0);font-family:Helvetica;font=
-size:12px;font-style:normal;font-variant-caps:normal;font-weight:normal;le=
tter-spacing:normal;text-align:start;text-indent:0px;text-transform:none;wh=
ite-space:normal;word-spacing:0px;text-decoration:none">So, to move forward=
: Maybe you can improve the online threads so that it=E2=80=99s easier to n=
avigate and read those pure retro-black-and-white threads.</div><div style=
=3D"color:rgb(0,0,0);font-family:Helvetica;font-size:12px;font-style:normal=
;font-variant-caps:normal;font-weight:normal;letter-spacing:normal;text-ali=
gn:start;text-indent:0px;text-transform:none;white-space:normal;word-spacin=
g:0px;text-decoration:none"><br class=3D"gmail-"></div><div style=3D"color:=
rgb(0,0,0);font-family:Helvetica;font-size:12px;font-style:normal;font-vari=
ant-caps:normal;font-weight:normal;letter-spacing:normal;text-align:start;t=
ext-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;text=
-decoration:none">Marius</div><div style=3D"color:rgb(0,0,0);font-family:He=
lvetica;font-size:12px;font-style:normal;font-variant-caps:normal;font-weig=
ht:normal;letter-spacing:normal;text-align:start;text-indent:0px;text-trans=
form:none;white-space:normal;word-spacing:0px;text-decoration:none"><br cla=
ss=3D"gmail-"></div><div style=3D"color:rgb(0,0,0);font-family:Helvetica;fo=
nt-size:12px;font-style:normal;font-variant-caps:normal;font-weight:normal;=
letter-spacing:normal;text-align:start;text-indent:0px;text-transform:none;=
white-space:normal;word-spacing:0px;text-decoration:none"><br class=3D"gmai=
l-"></div><div style=3D"color:rgb(0,0,0);font-family:Helvetica;font-size:12=
px;font-style:normal;font-variant-caps:normal;font-weight:normal;letter-spa=
cing:normal;text-align:start;text-indent:0px;text-transform:none;white-spac=
e:normal;word-spacing:0px;text-decoration:none"><br class=3D"gmail-"></div>=
<div style=3D"color:rgb(0,0,0);font-family:Helvetica;font-size:12px;font-st=
yle:normal;font-variant-caps:normal;font-weight:normal;letter-spacing:norma=
l;text-align:start;text-indent:0px;text-transform:none;white-space:normal;w=
ord-spacing:0px;text-decoration:none"><div>PS I=E2=80=99d like to emphasise=
 again:</div><div>I know I sound harsh. I=E2=80=99m not blaming here and of=
 course I=E2=80=99m also not belittling the workflow neither the proficienc=
y of the contributors. I=E2=80=99m totally aware that most regular contribu=
tors here are extremely highly skilled and work on an incredibly impactful =
set of software. I=E2=80=99m just providing a very detailed feedback of wha=
t I as a really really really really hard wanting-to-become future contribu=
tor see what really keeps me from joining.</div></div><div style=3D"color:r=
gb(0,0,0);font-family:Helvetica;font-size:12px;font-style:normal;font-varia=
nt-caps:normal;font-weight:normal;letter-spacing:normal;text-align:start;te=
xt-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;text-=
decoration:none"><br class=3D"gmail-"></div><div style=3D"color:rgb(0,0,0);=
font-family:Helvetica;font-size:12px;font-style:normal;font-variant-caps:no=
rmal;font-weight:normal;letter-spacing:normal;text-align:start;text-indent:=
0px;text-transform:none;white-space:normal;word-spacing:0px;text-decoration=
:none"><br class=3D"gmail-"></div><div style=3D"color:rgb(0,0,0);font-famil=
y:Helvetica;font-size:12px;font-style:normal;font-variant-caps:normal;font-=
weight:normal;letter-spacing:normal;text-align:start;text-indent:0px;text-t=
ransform:none;white-space:normal;word-spacing:0px;text-decoration:none"><bl=
ockquote type=3D"cite" class=3D"gmail-"><div class=3D"gmail-"><div dir=3D"l=
tr" class=3D"gmail-"><div class=3D"gmail_quote"><div class=3D"gmail-"><br c=
lass=3D"gmail-"></div><div class=3D"gmail-">Alex<br class=3D"gmail-"></div>=
<div class=3D"gmail-">=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex"><div dir=3D"ltr" class=3D"gmail-"><div class=3D"gmail-" style=3D=
"font-family:Helvetica;font-size:12px;font-style:normal;font-variant-caps:n=
ormal;font-weight:normal;letter-spacing:normal;text-align:start;text-indent=
:0px;text-transform:none;white-space:normal;word-spacing:0px;text-decoratio=
n:none"><div class=3D"gmail-"><br class=3D"gmail-"></div><div class=3D"gmai=
l-">Best</div><div class=3D"gmail-">Marius</div><div class=3D"gmail-"><br c=
lass=3D"gmail-"></div><br class=3D"gmail-"><blockquote type=3D"cite" class=
=3D"gmail-"><div class=3D"gmail-"><div dir=3D"ltr" class=3D"gmail-"><div cl=
ass=3D"gmail-">Alex<br class=3D"gmail-"></div></div><br class=3D"gmail-"><d=
iv class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, 9 No=
v 2021 at 09:05, Marius Kriegerowski &lt;<a href=3D"mailto:marius.kriegerow=
ski@gmail.com" target=3D"_blank" class=3D"gmail-">marius.kriegerowski@gmail=
.com</a>&gt; wrote:<br class=3D"gmail-"></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex"><div dir=3D"ltr" class=3D"gmail-"><div class=3D"gmail-=
" style=3D"font-family:Helvetica;font-size:12px;font-style:normal;font-vari=
ant-caps:normal;font-weight:normal;letter-spacing:normal;text-align:start;t=
ext-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;text=
-decoration:none">Good morning,</div><div class=3D"gmail-" style=3D"font-fa=
mily:Helvetica;font-size:12px;font-style:normal;font-variant-caps:normal;fo=
nt-weight:normal;letter-spacing:normal;text-align:start;text-indent:0px;tex=
t-transform:none;white-space:normal;word-spacing:0px;text-decoration:none">=
<br class=3D"gmail-"></div><div class=3D"gmail-" style=3D"font-family:Helve=
tica;font-size:12px;font-style:normal;font-variant-caps:normal;font-weight:=
normal;letter-spacing:normal;text-align:start;text-indent:0px;text-transfor=
m:none;white-space:normal;word-spacing:0px;text-decoration:none">I don=E2=
=80=99t think this is correct. You can change the git history and commit me=
ssages of every MR to whatever you like with `git commit =E2=80=94amend`, `=
git rebase -I` and `git push -f`. So, you can very well ask contributors to=
 cleanup their history before merging.</div><div class=3D"gmail-" style=3D"=
font-family:Helvetica;font-size:12px;font-style:normal;font-variant-caps:no=
rmal;font-weight:normal;letter-spacing:normal;text-align:start;text-indent:=
0px;text-transform:none;white-space:normal;word-spacing:0px;text-decoration=
:none"><br class=3D"gmail-"></div><div class=3D"gmail-" style=3D"font-famil=
y:Helvetica;font-size:12px;font-style:normal;font-variant-caps:normal;font-=
weight:normal;letter-spacing:normal;text-align:start;text-indent:0px;text-t=
ransform:none;white-space:normal;word-spacing:0px;text-decoration:none">Bes=
t</div><div class=3D"gmail-" style=3D"font-family:Helvetica;font-size:12px;=
font-style:normal;font-variant-caps:normal;font-weight:normal;letter-spacin=
g:normal;text-align:start;text-indent:0px;text-transform:none;white-space:n=
ormal;word-spacing:0px;text-decoration:none">Marius</div></div><br class=3D=
"gmail-"><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">A=
m Di., 9. Nov. 2021 um 07:47=C2=A0Uhr schrieb Alexander Kanavin &lt;<a href=
=3D"mailto:alex.kanavin@gmail.com" target=3D"_blank" class=3D"gmail-">alex.=
kanavin@gmail.com</a>&gt;:<br class=3D"gmail-"></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex"><div dir=3D"ltr" class=3D"gmail-"><div class=3D=
"gmail-">There&#39;s another problem with github/gitlab which I find signif=
icant. These tools do not allow reviewing commit messages, and don&#39;t ev=
en make it easy to see them. So the developers using those tools, both subm=
itters and maintainers, are effectively being conditioned by the tools to s=
ee good commit messages as superfluous and unnecessary. And so you more oft=
en than not end up with poorly written commit history in github projects, o=
r, if you&#39;re a reviewer, have to repeatedly explain to the submitter ho=
w to explain and structure their changes properly.</div><div class=3D"gmail=
-"><br class=3D"gmail-"></div><div class=3D"gmail-">I&#39;d rather not have=
 a change, than have a change that no one, even the original author, can un=
derstand or remember the reasons for one year down the line.</div><div clas=
s=3D"gmail-"><br class=3D"gmail-"></div><div class=3D"gmail-">Alex<br class=
=3D"gmail-"></div><br class=3D"gmail-"></div><br class=3D"gmail-"><div clas=
s=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, 9 Nov 2021 =
at 00:30, Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfoundati=
on.org" target=3D"_blank" class=3D"gmail-">richard.purdie@linuxfoundation.o=
rg</a>&gt; wrote:<br class=3D"gmail-"></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">On Mon, 2021-11-08 at 23:44 +0100, Marius Kriegerowski w=
rote:<br class=3D"gmail-">&gt;<span class=3D"gmail-">=C2=A0</span><br class=
=3D"gmail-">&gt;<span class=3D"gmail-">=C2=A0</span><br class=3D"gmail-">&g=
t; &gt; On 8. Nov 2021, at 22:47, Richard Purdie<br class=3D"gmail-">&gt; &=
gt; &lt;<a href=3D"mailto:richard.purdie@linuxfoundation.org" target=3D"_bl=
ank" class=3D"gmail-">richard.purdie@linuxfoundation.org</a>&gt; wrote:<br =
class=3D"gmail-">&gt; &gt;<span class=3D"gmail-">=C2=A0</span><br class=3D"=
gmail-">&gt; &gt; On Mon, 2021-11-08 at 18:37 +0100, Marius Kriegerowski wr=
ote:<br class=3D"gmail-">&gt; &gt; &gt; Is there a plan to switch to some m=
ore modern ways to collaborate on<br class=3D"gmail-">&gt; &gt; &gt; bitbak=
e,<br class=3D"gmail-">&gt; &gt; &gt; you know, like, gitlab/github/gitea w=
ith issues, PRs and so forth? I mean=E2=80=A6<br class=3D"gmail-">&gt; &gt;=
 &gt; it=E2=80=99s<br class=3D"gmail-">&gt; &gt; &gt; late 2021 and sending=
 MRs/Issues via email feels reaaaally outdated, slow,<br class=3D"gmail-">&=
gt; &gt; &gt; intransparent, ineffective (how to you do reviews, code compa=
risons during<br class=3D"gmail-">&gt; &gt; &gt; reviews, insert suggestion=
s, etc.) and indirect (where is the CI pipeline<br class=3D"gmail-">&gt; &g=
t; &gt; that I<br class=3D"gmail-">&gt; &gt; &gt; trigger when pushing some=
thing somewhere?).<br class=3D"gmail-">&gt; &gt;<span class=3D"gmail-">=C2=
=A0</span><br class=3D"gmail-">&gt; &gt; There are pros and cons to switchi=
ng to something else. Keep in mind that<br class=3D"gmail-">&gt; &gt; whils=
t the github workflow works well for a single maintainer of a project,<br c=
lass=3D"gmail-">&gt; &gt; it does not work well for diverse review.<br clas=
s=3D"gmail-">&gt;<br class=3D"gmail-">&gt; I strongly disagree with that. R=
eviews can equally well be done in a MR<br class=3D"gmail-">&gt; thread. Th=
at=E2=80=99s what they are there for. You can discuss things there with as<=
br class=3D"gmail-">&gt; many people as you want and can e.g. define a mini=
mum number of approvals<br class=3D"gmail-">&gt; before a MR can be merged.=
<br class=3D"gmail-"><br class=3D"gmail-">You misunderstand my point. We ha=
ve a several thousand people on the mailing<br class=3D"gmail-">lists and t=
hey filter things to what interests them. *I* have no people I want<br clas=
s=3D"gmail-">to discuss a given change with, it is a question of whether th=
e people who have<br class=3D"gmail-">an interest in a given change would s=
ee it.<br class=3D"gmail-"><br class=3D"gmail-">A minimum number of approva=
ls is utterly meaningless for how we work, I need the<br class=3D"gmail-">i=
nterested people to see it and that varies massively depending on what is b=
eing<br class=3D"gmail-">changed. It is this aspect of mailing list change =
distribution and discussion we<br class=3D"gmail-">benefit from.<br class=
=3D"gmail-"><br class=3D"gmail-">&gt; =C2=A0It also naturally groups discus=
sions. You can address experts for specific<br class=3D"gmail-">&gt; domain=
s which means less noise for the experts. I really don=E2=80=99t see why ma=
iling<br class=3D"gmail-">&gt; list reviews should work any better here.<br=
 class=3D"gmail-"><br class=3D"gmail-">We all have established mechanisms t=
o &quot;see&quot; the things which interest us as<br class=3D"gmail-">maint=
ainers?<br class=3D"gmail-"><br class=3D"gmail-">Please don&#39;t misunders=
tand me, I do see the attraction of github from your<br class=3D"gmail-">pe=
rspective. It would just destroy the ecosystem we already have. You are<br =
class=3D"gmail-">basically saying that our current ecosystem is worthless b=
ut I would point out<br class=3D"gmail-">it has resulted in a project which=
 you did say you appreciate so it can&#39;t be all<br class=3D"gmail-">bad.=
<br class=3D"gmail-"><br class=3D"gmail-">&gt; =C2=A0If google can coordina=
te 2.1k repos with 1.1k contributors over GitHub, why<br class=3D"gmail-">&=
gt; should that not work for openembedded??<br class=3D"gmail-"><br class=
=3D"gmail-">It isn&#39;t about raw numbers, it is about numbers of reviewer=
s for a given change.<br class=3D"gmail-">We have hundreds of people doing =
that using the mailing lists.<br class=3D"gmail-"><br class=3D"gmail-">&gt;=
 &gt; The Bitbake case is a little bit different but in general we&#39;d fo=
llow what<br class=3D"gmail-">&gt; &gt; OE/Yocto Project are doing.<br clas=
s=3D"gmail-">&gt; &gt;<span class=3D"gmail-">=C2=A0</span><br class=3D"gmai=
l-">&gt; &gt; We have discussed changing and it is listed as one topic on:<=
br class=3D"gmail-">&gt; &gt;<span class=3D"gmail-">=C2=A0</span><a href=3D=
"https://wiki.yoctoproject.org/wiki/Future_Directions" rel=3D"noreferrer" t=
arget=3D"_blank" class=3D"gmail-">https://wiki.yoctoproject.org/wiki/Future=
_Directions</a><br class=3D"gmail-">&gt; &gt; (Code Submission process)<br =
class=3D"gmail-">&gt; &gt;<span class=3D"gmail-">=C2=A0</span><br class=3D"=
gmail-">&gt; &gt; I&#39;d note that it is a huge change to our current deve=
lopers and most of us<br class=3D"gmail-">&gt; &gt; are very used to the ma=
iling lists so if we did change, it would allow<br class=3D"gmail-">&gt; &g=
t; potential new collaborators at the risk of losing people with key<br cla=
ss=3D"gmail-">&gt; &gt; knowledge/experience.<br class=3D"gmail-">&gt; =E2=
=80=A6 which reads to me like: =E2=80=9CIt has always been that way so we w=
ill not change<br class=3D"gmail-">&gt; that&quot; doesn=E2=80=99t it? Alwa=
ys a very poor argument.<br class=3D"gmail-"><br class=3D"gmail-">No, what =
I said is &quot;upsetting our existing developers is something which we may=
<br class=3D"gmail-">want to potentially avoid&quot;.<br class=3D"gmail-"><=
br class=3D"gmail-">There are some options out there which have offered mai=
ling list integration for<br class=3D"gmail-">example and we have tried to =
explore those. Something which drops the lists<br class=3D"gmail-">entirely=
 could in the current view of the TSC result in loss of too many of our<br =
class=3D"gmail-">existing maintainers.<br class=3D"gmail-"><br class=3D"gma=
il-">&gt;<span class=3D"gmail-">=C2=A0</span><br class=3D"gmail-">&gt; &gt;=
 We do have CI which is shared with Yocto Project and=C2=A0<br class=3D"gma=
il-">&gt; &gt; OpenEmbedded. You can see it here:<br class=3D"gmail-">&gt; =
&gt;<span class=3D"gmail-">=C2=A0</span><br class=3D"gmail-">&gt; &gt;<span=
 class=3D"gmail-">=C2=A0</span><a href=3D"https://autobuilder.yoctoproject.=
org/typhoon/#/console" rel=3D"noreferrer" target=3D"_blank" class=3D"gmail-=
">https://autobuilder.yoctoproject.org/typhoon/#/console</a><br class=3D"gm=
ail-">&gt; &gt;<span class=3D"gmail-">=C2=A0</span><br class=3D"gmail-">&gt=
; &gt; and it has it&#39;s own manual which was recently added to our docum=
entations<br class=3D"gmail-">&gt; &gt; set:<br class=3D"gmail-">&gt; &gt;<=
span class=3D"gmail-">=C2=A0</span><br class=3D"gmail-">&gt; &gt;<span clas=
s=3D"gmail-">=C2=A0</span><a href=3D"http://docs.yoctoproject.org/test-manu=
al/index.html" rel=3D"noreferrer" target=3D"_blank" class=3D"gmail-">http:/=
/docs.yoctoproject.org/test-manual/index.html</a><br class=3D"gmail-">&gt; =
=E2=80=A6 stressing my point: Why does the location of the CI need document=
ation? All<br class=3D"gmail-">&gt; of the aforementioned platforms smoothl=
y integrate with multiple CI solutions,<br class=3D"gmail-">&gt; drasticall=
y reducing the time required for reviews if the pipeline provides<br class=
=3D"gmail-">&gt; automated feedback to the contributor. It would probably c=
ost me about one<br class=3D"gmail-">&gt; afternoon to setup a decent CI pi=
peline at least for all python codes pushing<br class=3D"gmail-">&gt; the n=
eed to review from manual labor to automated tools. If open embedded<br cla=
ss=3D"gmail-">&gt; migrates to a proper git platform I happily volunteer on=
 that end!!<br class=3D"gmail-"><br class=3D"gmail-">We&#39;re not talking =
about simple python code. We&#39;re talking about testing a build<br class=
=3D"gmail-">environment which cross compiles multiple operating systems for=
 multiple<br class=3D"gmail-">architectures, C libraries, GUI stacks, init =
systems and so on. Testing the<br class=3D"gmail-">python code is one small=
 part of that. I&#39;ve spent several years trying to<br class=3D"gmail-">i=
mprove and get our CI to where it is today.<br class=3D"gmail-"><br class=
=3D"gmail-">Yes, the python code is tested as part of this as we don&#39;t =
really want to have<br class=3D"gmail-">multiple test platforms and the rea=
l world usage is some of the best testing<br class=3D"gmail-">changes can h=
ave.<br class=3D"gmail-"><br class=3D"gmail-">&gt; &gt; There is work still=
 needed on that but it is a start.=C2=A0One challenge of<br class=3D"gmail-=
">&gt; &gt; bitbake/OE is that the builds take an age and the test matrix i=
s huge so the<br class=3D"gmail-">&gt; &gt; CI<br class=3D"gmail-">&gt; &gt=
; process isn&#39;t quite as simple as some other simpler projects.<br clas=
s=3D"gmail-">&gt; At least for python I bet that most bugs can be caught si=
mply by firing up<br class=3D"gmail-">&gt; `black`, `flake8`, `pylint` (and=
 a hand full of other tools) just to check the<br class=3D"gmail-">&gt; mod=
ified files.<br class=3D"gmail-"><br class=3D"gmail-">Well, I would bet tha=
t most of our bugs are not caused by issues like that. I do<br class=3D"gma=
il-">attend the weekly bug triage meetings and have fixed my share of them.=
 You could<br class=3D"gmail-">have a look at the issues filed in bugzilla =
over the past few weeks if you&#39;d<br class=3D"gmail-">like to see the ki=
nds of issues that get filed and are open.<br class=3D"gmail-"><br class=3D=
"gmail-">&gt; =C2=A0Regarding meta-layers and recipes out there we are curr=
ently pushing forward<br class=3D"gmail-">&gt; with a linter for bitbake re=
cipes (thanks @priv-kweihmann for this awesome and<br class=3D"gmail-">&gt;=
 overdue tool!!!).<br class=3D"gmail-"><br class=3D"gmail-">Whilst improvin=
g recipes in that way does help, it isn&#39;t the main source of our<br cla=
ss=3D"gmail-">major issues.<br class=3D"gmail-"><br class=3D"gmail-">&gt; &=
gt;<span class=3D"gmail-">=C2=A0</span><br class=3D"gmail-">&gt; &gt; As a =
shortcut through things, the &quot;bitbake-selftest&quot; command within bi=
tbake<br class=3D"gmail-">&gt; &gt; may<br class=3D"gmail-">&gt; &gt; be on=
e thing you&#39;re looking for which does simple tests on bitbake. It isn&#=
39;t<br class=3D"gmail-">&gt; &gt; complete coverage and we welcome more be=
ing added, it is a start and some<br class=3D"gmail-">&gt; &gt; areas<br cl=
ass=3D"gmail-">&gt; &gt; of the code are covered better than others.<br cla=
ss=3D"gmail-">&gt; I=E2=80=99d love to overhaul the tests e.g. porting them=
 to `pytest` which offers a<br class=3D"gmail-">&gt; much simpler yet much =
more powerful API/plugin-ecosystem. But won=E2=80=99t do via<br class=3D"gm=
ail-">&gt; email :)<br class=3D"gmail-"><br class=3D"gmail-">The tests are =
written in python&#39;s own unittest.<br class=3D"gmail-"><br class=3D"gmai=
l-">&gt; &gt; Issues are filed in the project bugzilla and are actively wor=
ked on:<br class=3D"gmail-">&gt; &gt;<span class=3D"gmail-">=C2=A0</span><b=
r class=3D"gmail-">&gt; &gt;<span class=3D"gmail-">=C2=A0</span><a href=3D"=
https://bugzilla.yoctoproject.org/" rel=3D"noreferrer" target=3D"_blank" cl=
ass=3D"gmail-">https://bugzilla.yoctoproject.org/</a><br class=3D"gmail-">&=
gt; Didn=E2=80=99t know that. But why keeping issues separate from MRs? Aut=
omatic issue<br class=3D"gmail-">&gt; closing through referencing in MRs is=
 a pretty nice feature=E2=80=A6<br class=3D"gmail-"><br class=3D"gmail-">If=
 I had to list the pain points we have, this is not high on the list.<br cl=
ass=3D"gmail-"><br class=3D"gmail-">&gt; &gt; &gt; * side-note on bitbake s=
tyle/linting: It=E2=80=99s violating PEP8 in a couple of<br class=3D"gmail-=
">&gt; &gt; &gt; ways and TBH PEP8 is the bare minimum I would accept these=
 days for<br class=3D"gmail-">&gt; &gt; &gt; collaboration on projects the =
dimension of bitbake. So an additional<br class=3D"gmail-">&gt; &gt; &gt; q=
uestion: Would you be up for a PEP8 compatibility overhaul of the source<br=
 class=3D"gmail-">&gt; &gt; &gt; code? I=E2=80=99d volunteer if I don=E2=80=
=99t have to send a patch via email ;)<br class=3D"gmail-">&gt; &gt;<span c=
lass=3D"gmail-">=C2=A0</span><br class=3D"gmail-">&gt; &gt; We&#39;re inter=
ested in patches to improve the coding style as long as they<br class=3D"gm=
ail-">&gt; &gt; don&#39;t<br class=3D"gmail-">&gt; &gt; break things like r=
eadability or performance.=C2=A0Which rules in PEP8 in<br class=3D"gmail-">=
&gt; &gt; particular<br class=3D"gmail-">&gt; &gt; are you referring to?<br=
 class=3D"gmail-">&gt;<span class=3D"gmail-">=C2=A0</span><br class=3D"gmai=
l-">&gt; To name a few violations:<br class=3D"gmail-">&gt;<span class=3D"g=
mail-">=C2=A0</span><br class=3D"gmail-">&gt; =C2=A0* hanging indents<br cl=
ass=3D"gmail-">&gt; =C2=A0* inconsistent indentation<br class=3D"gmail-">&g=
t; =C2=A0* 2 separating lines missing in between classes/top level methods<=
br class=3D"gmail-"><br class=3D"gmail-">FWIW I find it really hard to get =
worked up about whitespace issues. I<br class=3D"gmail-">appreciate these a=
ren&#39;t always great to look at and I appreciate the familiarity<br class=
=3D"gmail-">argument and standardising the look but these aren&#39;t issues=
 I would prioritise.<br class=3D"gmail-"><br class=3D"gmail-">In particular=
 changing them globally in mass patches tends to break patch<br class=3D"gm=
ail-">backporting and taking fixes back to older code which we do benefit f=
rom being<br class=3D"gmail-">able to do so there is a cost to doing it. We=
 are trying to make new code more<br class=3D"gmail-">consistent and with o=
lder code, we do try and fix the worst issues.<br class=3D"gmail-"><br clas=
s=3D"gmail-">&gt; =C2=A0* unused imported modules<br class=3D"gmail-">&gt; =
=C2=A0* missing white-spaces after comma<br class=3D"gmail-">&gt; =C2=A0* u=
nreachable codes<br class=3D"gmail-"><br class=3D"gmail-">These ones we do =
take patches for and try to fix when/where we see it. For<br class=3D"gmail=
-">example,=C2=A0<a href=3D"http://git.yoctoproject.org/cgit.cgi/poky/commi=
t/?id=3D47e5c456a20432b511d830df9cbd4113a4352b2c" rel=3D"noreferrer" target=
=3D"_blank" class=3D"gmail-">http://git.yoctoproject.org/cgit.cgi/poky/comm=
it/?id=3D47e5c456a20432b511<br class=3D"gmail-">d830df9cbd4113a4352b2c</a>=
=C2=A0contained a couple of white-space after comma fixing<br class=3D"gmai=
l-">while I was in that area.<br class=3D"gmail-"><br class=3D"gmail-">&gt;=
 These are just a couple of examples that struck my PEP8 used eye from look=
ing<br class=3D"gmail-">&gt; at two, three modules.<br class=3D"gmail-">&gt=
;<span class=3D"gmail-">=C2=A0</span><br class=3D"gmail-">&gt; It=E2=80=99s=
 just like with any code smell: they don=E2=80=99t necessarily break things=
. But<br class=3D"gmail-">&gt; they make maintenance, code-reviews and qual=
ity control harder than necessary.<br class=3D"gmail-">&gt; Code that does =
not at least follow PEP8 (and I actually strongly recommend to<br class=3D"=
gmail-">&gt; go the extra mile with `black`) just looks odd and is unnecess=
ary hard to<br class=3D"gmail-">&gt; read. I=E2=80=99m surprised I have to =
argue for standards.<br class=3D"gmail-"><br class=3D"gmail-">I wasn&#39;t =
saying it was a bad thing, I asked which issues you noticed in<br class=3D"=
gmail-">particular since I&#39;m trying to ensure we do at least try and re=
act to feedback.<br class=3D"gmail-">Some whitespace issues we aren&#39;t l=
ikely to tackle, some like the others you<br class=3D"gmail-">mentioned abo=
ve we should fix.<br class=3D"gmail-">&gt;<span class=3D"gmail-">=C2=A0</sp=
an><br class=3D"gmail-">&gt; Besides that, some minor cleanup just to warm<=
br class=3D"gmail-">&gt; up:=C2=A0<a href=3D"https://github.com/openembedde=
d/bitbake/pull/33" rel=3D"noreferrer" target=3D"_blank" class=3D"gmail-">ht=
tps://github.com/openembedded/bitbake/pull/33</a>,=C2=A0<a href=3D"https://=
github.com/openem" rel=3D"noreferrer" target=3D"_blank" class=3D"gmail-">ht=
tps://github.com/openem</a><br class=3D"gmail-">&gt; bedded/bitbake/pull/32=
/files=C2=A0<br class=3D"gmail-"><br class=3D"gmail-">Those two do look lik=
e reasonable changes FWIW.<br class=3D"gmail-"><br class=3D"gmail-">&gt; (i=
t was after these two that I found the comment in one of those old commits<=
br class=3D"gmail-">&gt; which made me open=C2=A0<a href=3D"https://github.=
com/openembedded/bitbake/pull/34" rel=3D"noreferrer" target=3D"_blank" clas=
s=3D"gmail-">https://github.com/openembedded/bitbake/pull/34</a>). At least=
<br class=3D"gmail-">&gt; there should be an=C2=A0automated reply to each M=
R that is posted if someone makes<br class=3D"gmail-">&gt; the effort to fi=
x code and open a MRs that this is=C2=A0actually in vein - That=E2=80=99s<b=
r class=3D"gmail-">&gt; the=C2=A0mood that took me here :)<br class=3D"gmai=
l-"><br class=3D"gmail-">There is a certain irony in that given you patched=
 the section called<br class=3D"gmail-">&quot;Contributing&quot; in the REA=
DME in 32!<br class=3D"gmail-"><br class=3D"gmail-">&gt; &gt;<span class=3D=
"gmail-">=C2=A0</span><br class=3D"gmail-">&gt; &gt; Help appreciated but e=
mail patches is how we accept them at the moment.<br class=3D"gmail-">&gt;<=
span class=3D"gmail-">=C2=A0</span><br class=3D"gmail-">&gt; Not from me th=
en :(<br class=3D"gmail-"><br class=3D"gmail-">Sorry to hear that, your cha=
nges in 32/33 do look reasonable.<br class=3D"gmail-"><br class=3D"gmail-">=
Cheers,<br class=3D"gmail-"><br class=3D"gmail-">Richard<br class=3D"gmail-=
"><br class=3D"gmail-"><br class=3D"gmail-">-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=
=3D-=3D-=3D-=3D-<br class=3D"gmail-">Links: You receive all messages sent t=
o this group.<br class=3D"gmail-">View/Reply Online (#12951):<span class=3D=
"gmail-">=C2=A0</span><a href=3D"https://lists.openembedded.org/g/bitbake-d=
evel/message/12951" rel=3D"noreferrer" target=3D"_blank" class=3D"gmail-">h=
ttps://lists.openembedded.org/g/bitbake-devel/message/12951</a><br class=3D=
"gmail-">Mute This Topic:<span class=3D"gmail-">=C2=A0</span><a href=3D"htt=
ps://lists.openembedded.org/mt/86911583/1686489" rel=3D"noreferrer" target=
=3D"_blank" class=3D"gmail-">https://lists.openembedded.org/mt/86911583/168=
6489</a><br class=3D"gmail-">Group Owner:<span class=3D"gmail-">=C2=A0</spa=
n><a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org" target=3D=
"_blank" class=3D"gmail-">bitbake-devel+owner@lists.openembedded.org</a><br=
 class=3D"gmail-">Unsubscribe:<span class=3D"gmail-">=C2=A0</span><a href=
=3D"https://lists.openembedded.org/g/bitbake-devel/unsub" rel=3D"noreferrer=
" target=3D"_blank" class=3D"gmail-">https://lists.openembedded.org/g/bitba=
ke-devel/unsub</a><span class=3D"gmail-">=C2=A0</span>[<a href=3D"mailto:al=
ex.kanavin@gmail.com" target=3D"_blank" class=3D"gmail-">alex.kanavin@gmail=
.com</a>]<br class=3D"gmail-">-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=
<br class=3D"gmail-"><br class=3D"gmail-"></blockquote></div></blockquote><=
/div></blockquote></div></div></blockquote></div><br class=3D"gmail-"><br c=
lass=3D"gmail-"></div><br class=3D"gmail-"><div class=3D"gmail_quote"><div =
dir=3D"ltr" class=3D"gmail_attr">Am Di., 9. Nov. 2021 um 09:19=C2=A0Uhr sch=
rieb Alexander Kanavin &lt;<a href=3D"mailto:alex.kanavin@gmail.com" target=
=3D"_blank" class=3D"gmail-">alex.kanavin@gmail.com</a>&gt;:<br class=3D"gm=
ail-"></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"l=
tr" class=3D"gmail-"><div class=3D"gmail-">I think you misunderstood me too=
. It&#39;s about the github UI which does its best to hide the commit messa=
ges, and doesn&#39;t allow to comment on their content. Yes you can contort=
 yourself and still do it, but the tools do not help.</div><div class=3D"gm=
ail-"><br class=3D"gmail-"></div><div class=3D"gmail-">Alex<br class=3D"gma=
il-"></div></div><br class=3D"gmail-"><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Tue, 9 Nov 2021 at 09:05, Marius Kriegerow=
ski &lt;<a href=3D"mailto:marius.kriegerowski@gmail.com" target=3D"_blank" =
class=3D"gmail-">marius.kriegerowski@gmail.com</a>&gt; wrote:<br class=3D"g=
mail-"></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"=
ltr" class=3D"gmail-"><div class=3D"gmail-" style=3D"font-family:Helvetica;=
font-size:12px;font-style:normal;font-variant-caps:normal;font-weight:norma=
l;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:non=
e;white-space:normal;word-spacing:0px;text-decoration:none">Good morning,</=
div><div class=3D"gmail-" style=3D"font-family:Helvetica;font-size:12px;fon=
t-style:normal;font-variant-caps:normal;font-weight:normal;letter-spacing:n=
ormal;text-align:start;text-indent:0px;text-transform:none;white-space:norm=
al;word-spacing:0px;text-decoration:none"><br class=3D"gmail-"></div><div c=
lass=3D"gmail-" style=3D"font-family:Helvetica;font-size:12px;font-style:no=
rmal;font-variant-caps:normal;font-weight:normal;letter-spacing:normal;text=
-align:start;text-indent:0px;text-transform:none;white-space:normal;word-sp=
acing:0px;text-decoration:none">I don=E2=80=99t think this is correct. You =
can change the git history and commit messages of every MR to whatever you =
like with `git commit =E2=80=94amend`, `git rebase -I` and `git push -f`. S=
o, you can very well ask contributors to cleanup their history before mergi=
ng.</div><div class=3D"gmail-" style=3D"font-family:Helvetica;font-size:12p=
x;font-style:normal;font-variant-caps:normal;font-weight:normal;letter-spac=
ing:normal;text-align:start;text-indent:0px;text-transform:none;white-space=
:normal;word-spacing:0px;text-decoration:none"><br class=3D"gmail-"></div><=
div class=3D"gmail-" style=3D"font-family:Helvetica;font-size:12px;font-sty=
le:normal;font-variant-caps:normal;font-weight:normal;letter-spacing:normal=
;text-align:start;text-indent:0px;text-transform:none;white-space:normal;wo=
rd-spacing:0px;text-decoration:none">Best</div><div class=3D"gmail-" style=
=3D"font-family:Helvetica;font-size:12px;font-style:normal;font-variant-cap=
s:normal;font-weight:normal;letter-spacing:normal;text-align:start;text-ind=
ent:0px;text-transform:none;white-space:normal;word-spacing:0px;text-decora=
tion:none">Marius</div></div><br class=3D"gmail-"><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">Am Di., 9. Nov. 2021 um 07:47=C2=A0=
Uhr schrieb Alexander Kanavin &lt;<a href=3D"mailto:alex.kanavin@gmail.com"=
 target=3D"_blank" class=3D"gmail-">alex.kanavin@gmail.com</a>&gt;:<br clas=
s=3D"gmail-"></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div d=
ir=3D"ltr" class=3D"gmail-"><div class=3D"gmail-">There&#39;s another probl=
em with github/gitlab which I find significant. These tools do not allow re=
viewing commit messages, and don&#39;t even make it easy to see them. So th=
e developers using those tools, both submitters and maintainers, are effect=
ively being conditioned by the tools to see good commit messages as superfl=
uous and unnecessary. And so you more often than not end up with poorly wri=
tten commit history in github projects, or, if you&#39;re a reviewer, have =
to repeatedly explain to the submitter how to explain and structure their c=
hanges properly.</div><div class=3D"gmail-"><br class=3D"gmail-"></div><div=
 class=3D"gmail-">I&#39;d rather not have a change, than have a change that=
 no one, even the original author, can understand or remember the reasons f=
or one year down the line.</div><div class=3D"gmail-"><br class=3D"gmail-">=
</div><div class=3D"gmail-">Alex<br class=3D"gmail-"></div><br class=3D"gma=
il-"></div><br class=3D"gmail-"><div class=3D"gmail_quote"><div dir=3D"ltr"=
 class=3D"gmail_attr">On Tue, 9 Nov 2021 at 00:30, Richard Purdie &lt;<a hr=
ef=3D"mailto:richard.purdie@linuxfoundation.org" target=3D"_blank" class=3D=
"gmail-">richard.purdie@linuxfoundation.org</a>&gt; wrote:<br class=3D"gmai=
l-"></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Mon, 2021-11=
-08 at 23:44 +0100, Marius Kriegerowski wrote:<br class=3D"gmail-">&gt;<spa=
n class=3D"gmail-Apple-converted-space">=C2=A0</span><br class=3D"gmail-">&=
gt;<span class=3D"gmail-Apple-converted-space">=C2=A0</span><br class=3D"gm=
ail-">&gt; &gt; On 8. Nov 2021, at 22:47, Richard Purdie<br class=3D"gmail-=
">&gt; &gt; &lt;<a href=3D"mailto:richard.purdie@linuxfoundation.org" targe=
t=3D"_blank" class=3D"gmail-">richard.purdie@linuxfoundation.org</a>&gt; wr=
ote:<br class=3D"gmail-">&gt; &gt;<span class=3D"gmail-Apple-converted-spac=
e">=C2=A0</span><br class=3D"gmail-">&gt; &gt; On Mon, 2021-11-08 at 18:37 =
+0100, Marius Kriegerowski wrote:<br class=3D"gmail-">&gt; &gt; &gt; Is the=
re a plan to switch to some more modern ways to collaborate on<br class=3D"=
gmail-">&gt; &gt; &gt; bitbake,<br class=3D"gmail-">&gt; &gt; &gt; you know=
, like, gitlab/github/gitea with issues, PRs and so forth? I mean=E2=80=A6<=
br class=3D"gmail-">&gt; &gt; &gt; it=E2=80=99s<br class=3D"gmail-">&gt; &g=
t; &gt; late 2021 and sending MRs/Issues via email feels reaaaally outdated=
, slow,<br class=3D"gmail-">&gt; &gt; &gt; intransparent, ineffective (how =
to you do reviews, code comparisons during<br class=3D"gmail-">&gt; &gt; &g=
t; reviews, insert suggestions, etc.) and indirect (where is the CI pipelin=
e<br class=3D"gmail-">&gt; &gt; &gt; that I<br class=3D"gmail-">&gt; &gt; &=
gt; trigger when pushing something somewhere?).<br class=3D"gmail-">&gt; &g=
t;<span class=3D"gmail-Apple-converted-space">=C2=A0</span><br class=3D"gma=
il-">&gt; &gt; There are pros and cons to switching to something else. Keep=
 in mind that<br class=3D"gmail-">&gt; &gt; whilst the github workflow work=
s well for a single maintainer of a project,<br class=3D"gmail-">&gt; &gt; =
it does not work well for diverse review.<br class=3D"gmail-">&gt;<br class=
=3D"gmail-">&gt; I strongly disagree with that. Reviews can equally well be=
 done in a MR<br class=3D"gmail-">&gt; thread. That=E2=80=99s what they are=
 there for. You can discuss things there with as<br class=3D"gmail-">&gt; m=
any people as you want and can e.g. define a minimum number of approvals<br=
 class=3D"gmail-">&gt; before a MR can be merged.<br class=3D"gmail-"><br c=
lass=3D"gmail-">You misunderstand my point. We have a several thousand peop=
le on the mailing<br class=3D"gmail-">lists and they filter things to what =
interests them. *I* have no people I want<br class=3D"gmail-">to discuss a =
given change with, it is a question of whether the people who have<br class=
=3D"gmail-">an interest in a given change would see it.<br class=3D"gmail-"=
><br class=3D"gmail-">A minimum number of approvals is utterly meaningless =
for how we work, I need the<br class=3D"gmail-">interested people to see it=
 and that varies massively depending on what is being<br class=3D"gmail-">c=
hanged. It is this aspect of mailing list change distribution and discussio=
n we<br class=3D"gmail-">benefit from.<br class=3D"gmail-"><br class=3D"gma=
il-">&gt; =C2=A0It also naturally groups discussions. You can address exper=
ts for specific<br class=3D"gmail-">&gt; domains which means less noise for=
 the experts. I really don=E2=80=99t see why mailing<br class=3D"gmail-">&g=
t; list reviews should work any better here.<br class=3D"gmail-"><br class=
=3D"gmail-">We all have established mechanisms to &quot;see&quot; the thing=
s which interest us as<br class=3D"gmail-">maintainers?<br class=3D"gmail-"=
><br class=3D"gmail-">Please don&#39;t misunderstand me, I do see the attra=
ction of github from your<br class=3D"gmail-">perspective. It would just de=
stroy the ecosystem we already have. You are<br class=3D"gmail-">basically =
saying that our current ecosystem is worthless but I would point out<br cla=
ss=3D"gmail-">it has resulted in a project which you did say you appreciate=
 so it can&#39;t be all<br class=3D"gmail-">bad.<br class=3D"gmail-"><br cl=
ass=3D"gmail-">&gt; =C2=A0If google can coordinate 2.1k repos with 1.1k con=
tributors over GitHub, why<br class=3D"gmail-">&gt; should that not work fo=
r openembedded??<br class=3D"gmail-"><br class=3D"gmail-">It isn&#39;t abou=
t raw numbers, it is about numbers of reviewers for a given change.<br clas=
s=3D"gmail-">We have hundreds of people doing that using the mailing lists.=
<br class=3D"gmail-"><br class=3D"gmail-">&gt; &gt; The Bitbake case is a l=
ittle bit different but in general we&#39;d follow what<br class=3D"gmail-"=
>&gt; &gt; OE/Yocto Project are doing.<br class=3D"gmail-">&gt; &gt;<span c=
lass=3D"gmail-Apple-converted-space">=C2=A0</span><br class=3D"gmail-">&gt;=
 &gt; We have discussed changing and it is listed as one topic on:<br class=
=3D"gmail-">&gt; &gt;<span class=3D"gmail-Apple-converted-space">=C2=A0</sp=
an><a href=3D"https://wiki.yoctoproject.org/wiki/Future_Directions" rel=3D"=
noreferrer" target=3D"_blank" class=3D"gmail-">https://wiki.yoctoproject.or=
g/wiki/Future_Directions</a><br class=3D"gmail-">&gt; &gt; (Code Submission=
 process)<br class=3D"gmail-">&gt; &gt;<span class=3D"gmail-Apple-converted=
-space">=C2=A0</span><br class=3D"gmail-">&gt; &gt; I&#39;d note that it is=
 a huge change to our current developers and most of us<br class=3D"gmail-"=
>&gt; &gt; are very used to the mailing lists so if we did change, it would=
 allow<br class=3D"gmail-">&gt; &gt; potential new collaborators at the ris=
k of losing people with key<br class=3D"gmail-">&gt; &gt; knowledge/experie=
nce.<br class=3D"gmail-">&gt; =E2=80=A6 which reads to me like: =E2=80=9CIt=
 has always been that way so we will not change<br class=3D"gmail-">&gt; th=
at&quot; doesn=E2=80=99t it? Always a very poor argument.<br class=3D"gmail=
-"><br class=3D"gmail-">No, what I said is &quot;upsetting our existing dev=
elopers is something which we may<br class=3D"gmail-">want to potentially a=
void&quot;.<br class=3D"gmail-"><br class=3D"gmail-">There are some options=
 out there which have offered mailing list integration for<br class=3D"gmai=
l-">example and we have tried to explore those. Something which drops the l=
ists<br class=3D"gmail-">entirely could in the current view of the TSC resu=
lt in loss of too many of our<br class=3D"gmail-">existing maintainers.<br =
class=3D"gmail-"><br class=3D"gmail-">&gt;<span class=3D"gmail-Apple-conver=
ted-space">=C2=A0</span><br class=3D"gmail-">&gt; &gt; We do have CI which =
is shared with Yocto Project and=C2=A0<br class=3D"gmail-">&gt; &gt; OpenEm=
bedded. You can see it here:<br class=3D"gmail-">&gt; &gt;<span class=3D"gm=
ail-Apple-converted-space">=C2=A0</span><br class=3D"gmail-">&gt; &gt;<span=
 class=3D"gmail-Apple-converted-space">=C2=A0</span><a href=3D"https://auto=
builder.yoctoproject.org/typhoon/#/console" rel=3D"noreferrer" target=3D"_b=
lank" class=3D"gmail-">https://autobuilder.yoctoproject.org/typhoon/#/conso=
le</a><br class=3D"gmail-">&gt; &gt;<span class=3D"gmail-Apple-converted-sp=
ace">=C2=A0</span><br class=3D"gmail-">&gt; &gt; and it has it&#39;s own ma=
nual which was recently added to our documentations<br class=3D"gmail-">&gt=
; &gt; set:<br class=3D"gmail-">&gt; &gt;<span class=3D"gmail-Apple-convert=
ed-space">=C2=A0</span><br class=3D"gmail-">&gt; &gt;<span class=3D"gmail-A=
pple-converted-space">=C2=A0</span><a href=3D"http://docs.yoctoproject.org/=
test-manual/index.html" rel=3D"noreferrer" target=3D"_blank" class=3D"gmail=
-">http://docs.yoctoproject.org/test-manual/index.html</a><br class=3D"gmai=
l-">&gt; =E2=80=A6 stressing my point: Why does the location of the CI need=
 documentation? All<br class=3D"gmail-">&gt; of the aforementioned platform=
s smoothly integrate with multiple CI solutions,<br class=3D"gmail-">&gt; d=
rastically reducing the time required for reviews if the pipeline provides<=
br class=3D"gmail-">&gt; automated feedback to the contributor. It would pr=
obably cost me about one<br class=3D"gmail-">&gt; afternoon to setup a dece=
nt CI pipeline at least for all python codes pushing<br class=3D"gmail-">&g=
t; the need to review from manual labor to automated tools. If open embedde=
d<br class=3D"gmail-">&gt; migrates to a proper git platform I happily volu=
nteer on that end!!<br class=3D"gmail-"><br class=3D"gmail-">We&#39;re not =
talking about simple python code. We&#39;re talking about testing a build<b=
r class=3D"gmail-">environment which cross compiles multiple operating syst=
ems for multiple<br class=3D"gmail-">architectures, C libraries, GUI stacks=
, init systems and so on. Testing the<br class=3D"gmail-">python code is on=
e small part of that. I&#39;ve spent several years trying to<br class=3D"gm=
ail-">improve and get our CI to where it is today.<br class=3D"gmail-"><br =
class=3D"gmail-">Yes, the python code is tested as part of this as we don&#=
39;t really want to have<br class=3D"gmail-">multiple test platforms and th=
e real world usage is some of the best testing<br class=3D"gmail-">changes =
can have.<br class=3D"gmail-"><br class=3D"gmail-">&gt; &gt; There is work =
still needed on that but it is a start.=C2=A0One challenge of<br class=3D"g=
mail-">&gt; &gt; bitbake/OE is that the builds take an age and the test mat=
rix is huge so the<br class=3D"gmail-">&gt; &gt; CI<br class=3D"gmail-">&gt=
; &gt; process isn&#39;t quite as simple as some other simpler projects.<br=
 class=3D"gmail-">&gt; At least for python I bet that most bugs can be caug=
ht simply by firing up<br class=3D"gmail-">&gt; `black`, `flake8`, `pylint`=
 (and a hand full of other tools) just to check the<br class=3D"gmail-">&gt=
; modified files.<br class=3D"gmail-"><br class=3D"gmail-">Well, I would be=
t that most of our bugs are not caused by issues like that. I do<br class=
=3D"gmail-">attend the weekly bug triage meetings and have fixed my share o=
f them. You could<br class=3D"gmail-">have a look at the issues filed in bu=
gzilla over the past few weeks if you&#39;d<br class=3D"gmail-">like to see=
 the kinds of issues that get filed and are open.<br class=3D"gmail-"><br c=
lass=3D"gmail-">&gt; =C2=A0Regarding meta-layers and recipes out there we a=
re currently pushing forward<br class=3D"gmail-">&gt; with a linter for bit=
bake recipes (thanks @priv-kweihmann for this awesome and<br class=3D"gmail=
-">&gt; overdue tool!!!).<br class=3D"gmail-"><br class=3D"gmail-">Whilst i=
mproving recipes in that way does help, it isn&#39;t the main source of our=
<br class=3D"gmail-">major issues.<br class=3D"gmail-"><br class=3D"gmail-"=
>&gt; &gt;<span class=3D"gmail-Apple-converted-space">=C2=A0</span><br clas=
s=3D"gmail-">&gt; &gt; As a shortcut through things, the &quot;bitbake-self=
test&quot; command within bitbake<br class=3D"gmail-">&gt; &gt; may<br clas=
s=3D"gmail-">&gt; &gt; be one thing you&#39;re looking for which does simpl=
e tests on bitbake. It isn&#39;t<br class=3D"gmail-">&gt; &gt; complete cov=
erage and we welcome more being added, it is a start and some<br class=3D"g=
mail-">&gt; &gt; areas<br class=3D"gmail-">&gt; &gt; of the code are covere=
d better than others.<br class=3D"gmail-">&gt; I=E2=80=99d love to overhaul=
 the tests e.g. porting them to `pytest` which offers a<br class=3D"gmail-"=
>&gt; much simpler yet much more powerful API/plugin-ecosystem. But won=E2=
=80=99t do via<br class=3D"gmail-">&gt; email :)<br class=3D"gmail-"><br cl=
ass=3D"gmail-">The tests are written in python&#39;s own unittest.<br class=
=3D"gmail-"><br class=3D"gmail-">&gt; &gt; Issues are filed in the project =
bugzilla and are actively worked on:<br class=3D"gmail-">&gt; &gt;<span cla=
ss=3D"gmail-Apple-converted-space">=C2=A0</span><br class=3D"gmail-">&gt; &=
gt;<span class=3D"gmail-Apple-converted-space">=C2=A0</span><a href=3D"http=
s://bugzilla.yoctoproject.org/" rel=3D"noreferrer" target=3D"_blank" class=
=3D"gmail-">https://bugzilla.yoctoproject.org/</a><br class=3D"gmail-">&gt;=
 Didn=E2=80=99t know that. But why keeping issues separate from MRs? Automa=
tic issue<br class=3D"gmail-">&gt; closing through referencing in MRs is a =
pretty nice feature=E2=80=A6<br class=3D"gmail-"><br class=3D"gmail-">If I =
had to list the pain points we have, this is not high on the list.<br class=
=3D"gmail-"><br class=3D"gmail-">&gt; &gt; &gt; * side-note on bitbake styl=
e/linting: It=E2=80=99s violating PEP8 in a couple of<br class=3D"gmail-">&=
gt; &gt; &gt; ways and TBH PEP8 is the bare minimum I would accept these da=
ys for<br class=3D"gmail-">&gt; &gt; &gt; collaboration on projects the dim=
ension of bitbake. So an additional<br class=3D"gmail-">&gt; &gt; &gt; ques=
tion: Would you be up for a PEP8 compatibility overhaul of the source<br cl=
ass=3D"gmail-">&gt; &gt; &gt; code? I=E2=80=99d volunteer if I don=E2=80=99=
t have to send a patch via email ;)<br class=3D"gmail-">&gt; &gt;<span clas=
s=3D"gmail-Apple-converted-space">=C2=A0</span><br class=3D"gmail-">&gt; &g=
t; We&#39;re interested in patches to improve the coding style as long as t=
hey<br class=3D"gmail-">&gt; &gt; don&#39;t<br class=3D"gmail-">&gt; &gt; b=
reak things like readability or performance.=C2=A0Which rules in PEP8 in<br=
 class=3D"gmail-">&gt; &gt; particular<br class=3D"gmail-">&gt; &gt; are yo=
u referring to?<br class=3D"gmail-">&gt;<span class=3D"gmail-Apple-converte=
d-space">=C2=A0</span><br class=3D"gmail-">&gt; To name a few violations:<b=
r class=3D"gmail-">&gt;<span class=3D"gmail-Apple-converted-space">=C2=A0</=
span><br class=3D"gmail-">&gt; =C2=A0* hanging indents<br class=3D"gmail-">=
&gt; =C2=A0* inconsistent indentation<br class=3D"gmail-">&gt; =C2=A0* 2 se=
parating lines missing in between classes/top level methods<br class=3D"gma=
il-"><br class=3D"gmail-">FWIW I find it really hard to get worked up about=
 whitespace issues. I<br class=3D"gmail-">appreciate these aren&#39;t alway=
s great to look at and I appreciate the familiarity<br class=3D"gmail-">arg=
ument and standardising the look but these aren&#39;t issues I would priori=
tise.<br class=3D"gmail-"><br class=3D"gmail-">In particular changing them =
globally in mass patches tends to break patch<br class=3D"gmail-">backporti=
ng and taking fixes back to older code which we do benefit from being<br cl=
ass=3D"gmail-">able to do so there is a cost to doing it. We are trying to =
make new code more<br class=3D"gmail-">consistent and with older code, we d=
o try and fix the worst issues.<br class=3D"gmail-"><br class=3D"gmail-">&g=
t; =C2=A0* unused imported modules<br class=3D"gmail-">&gt; =C2=A0* missing=
 white-spaces after comma<br class=3D"gmail-">&gt; =C2=A0* unreachable code=
s<br class=3D"gmail-"><br class=3D"gmail-">These ones we do take patches fo=
r and try to fix when/where we see it. For<br class=3D"gmail-">example,=C2=
=A0<a href=3D"http://git.yoctoproject.org/cgit.cgi/poky/commit/?id=3D47e5c4=
56a20432b511d830df9cbd4113a4352b2c" rel=3D"noreferrer" target=3D"_blank" cl=
ass=3D"gmail-">http://git.yoctoproject.org/cgit.cgi/poky/commit/?id=3D47e5c=
456a20432b511<br class=3D"gmail-">d830df9cbd4113a4352b2c</a>=C2=A0contained=
 a couple of white-space after comma fixing<br class=3D"gmail-">while I was=
 in that area.<br class=3D"gmail-"><br class=3D"gmail-">&gt; These are just=
 a couple of examples that struck my PEP8 used eye from looking<br class=3D=
"gmail-">&gt; at two, three modules.<br class=3D"gmail-">&gt;<span class=3D=
"gmail-Apple-converted-space">=C2=A0</span><br class=3D"gmail-">&gt; It=E2=
=80=99s just like with any code smell: they don=E2=80=99t necessarily break=
 things. But<br class=3D"gmail-">&gt; they make maintenance, code-reviews a=
nd quality control harder than necessary.<br class=3D"gmail-">&gt; Code tha=
t does not at least follow PEP8 (and I actually strongly recommend to<br cl=
ass=3D"gmail-">&gt; go the extra mile with `black`) just looks odd and is u=
nnecessary hard to<br class=3D"gmail-">&gt; read. I=E2=80=99m surprised I h=
ave to argue for standards.<br class=3D"gmail-"><br class=3D"gmail-">I wasn=
&#39;t saying it was a bad thing, I asked which issues you noticed in<br cl=
ass=3D"gmail-">particular since I&#39;m trying to ensure we do at least try=
 and react to feedback.<br class=3D"gmail-">Some whitespace issues we aren&=
#39;t likely to tackle, some like the others you<br class=3D"gmail-">mentio=
ned above we should fix.<br class=3D"gmail-">&gt;<span class=3D"gmail-Apple=
-converted-space">=C2=A0</span><br class=3D"gmail-">&gt; Besides that, some=
 minor cleanup just to warm<br class=3D"gmail-">&gt; up:=C2=A0<a href=3D"ht=
tps://github.com/openembedded/bitbake/pull/33" rel=3D"noreferrer" target=3D=
"_blank" class=3D"gmail-">https://github.com/openembedded/bitbake/pull/33</=
a>,=C2=A0<a href=3D"https://github.com/openem" rel=3D"noreferrer" target=3D=
"_blank" class=3D"gmail-">https://github.com/openem</a><br class=3D"gmail-"=
>&gt; bedded/bitbake/pull/32/files=C2=A0<br class=3D"gmail-"><br class=3D"g=
mail-">Those two do look like reasonable changes FWIW.<br class=3D"gmail-">=
<br class=3D"gmail-">&gt; (it was after these two that I found the comment =
in one of those old commits<br class=3D"gmail-">&gt; which made me open=C2=
=A0<a href=3D"https://github.com/openembedded/bitbake/pull/34" rel=3D"noref=
errer" target=3D"_blank" class=3D"gmail-">https://github.com/openembedded/b=
itbake/pull/34</a>). At least<br class=3D"gmail-">&gt; there should be an=
=C2=A0automated reply to each MR that is posted if someone makes<br class=
=3D"gmail-">&gt; the effort to fix code and open a MRs that this is=C2=A0ac=
tually in vein - That=E2=80=99s<br class=3D"gmail-">&gt; the=C2=A0mood that=
 took me here :)<br class=3D"gmail-"><br class=3D"gmail-">There is a certai=
n irony in that given you patched the section called<br class=3D"gmail-">&q=
uot;Contributing&quot; in the README in 32!<br class=3D"gmail-"><br class=
=3D"gmail-">&gt; &gt;<span class=3D"gmail-Apple-converted-space">=C2=A0</sp=
an><br class=3D"gmail-">&gt; &gt; Help appreciated but email patches is how=
 we accept them at the moment.<br class=3D"gmail-">&gt;<span class=3D"gmail=
-Apple-converted-space">=C2=A0</span><br class=3D"gmail-">&gt; Not from me =
then :(<br class=3D"gmail-"><br class=3D"gmail-">Sorry to hear that, your c=
hanges in 32/33 do look reasonable.<br class=3D"gmail-"><br class=3D"gmail-=
">Cheers,<br class=3D"gmail-"><br class=3D"gmail-">Richard<br class=3D"gmai=
l-"><br class=3D"gmail-"><br class=3D"gmail-">-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=
=3D-=3D-=3D-=3D-<br class=3D"gmail-">Links: You receive all messages sent t=
o this group.<br class=3D"gmail-">View/Reply Online (#12951):<span class=3D=
"gmail-Apple-converted-space">=C2=A0</span><a href=3D"https://lists.openemb=
edded.org/g/bitbake-devel/message/12951" rel=3D"noreferrer" target=3D"_blan=
k" class=3D"gmail-">https://lists.openembedded.org/g/bitbake-devel/message/=
12951</a><br class=3D"gmail-">Mute This Topic:<span class=3D"gmail-Apple-co=
nverted-space">=C2=A0</span><a href=3D"https://lists.openembedded.org/mt/86=
911583/1686489" rel=3D"noreferrer" target=3D"_blank" class=3D"gmail-">https=
://lists.openembedded.org/mt/86911583/1686489</a><br class=3D"gmail-">Group=
 Owner:<span class=3D"gmail-Apple-converted-space">=C2=A0</span><a href=3D"=
mailto:bitbake-devel%2Bowner@lists.openembedded.org" target=3D"_blank" clas=
s=3D"gmail-">bitbake-devel+owner@lists.openembedded.org</a><br class=3D"gma=
il-">Unsubscribe:<span class=3D"gmail-Apple-converted-space">=C2=A0</span><=
a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsub" rel=3D"nore=
ferrer" target=3D"_blank" class=3D"gmail-">https://lists.openembedded.org/g=
/bitbake-devel/unsub</a><span class=3D"gmail-Apple-converted-space">=C2=A0<=
/span>[<a href=3D"mailto:alex.kanavin@gmail.com" target=3D"_blank" class=3D=
"gmail-">alex.kanavin@gmail.com</a>]<br class=3D"gmail-">-=3D-=3D-=3D-=3D-=
=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br class=3D"gmail-"><br class=3D"gmail-"></blo=
ckquote></div></blockquote></div></blockquote></div></blockquote></div></bl=
ockquote></div></div></div></blockquote></div><br class=3D"gmail-Apple-inte=
rchange-newline"><br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Am Di., 9. Nov. 2021 um 09:49=C2=A0Uhr schrieb &lt;<a =
href=3D"mailto:Mikko.Rapeli@bmw.de">Mikko.Rapeli@bmw.de</a>&gt;:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">Hi,<br>
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

--000000000000433df405d057778f--

