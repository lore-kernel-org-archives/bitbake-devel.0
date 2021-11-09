Return-Path: <marius.kriegerowski@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF8D5C433EF
	for <webhook@archiver.kernel.org>; Tue,  9 Nov 2021 08:32:30 +0000 (UTC)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com
 [209.85.208.41])
 by mx.groups.io with SMTP id smtpd.web10.9399.1636446749492214352
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 09 Nov 2021 00:32:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=mRbyIYAa;
 spf=pass (domain: gmail.com, ip: 209.85.208.41,
 mailfrom: marius.kriegerowski@gmail.com)
Received: by mail-ed1-f41.google.com with SMTP id o8so73417663edc.3
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 09 Nov 2021 00:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4JURclh08hC4FA2xFhBr7JqG66IxnFN0sdHwxoag9wA=;
        b=mRbyIYAaD9bXi6kgAYBnxdZEIjbkoXQjdqn5aHGhCYPG/4AFywKGx1TP2Vi7RkaDkk
         uJ7bZtrx4rHbLAh1CRSYJnwaXkayTFKksVausT1yO+qYbD2vmTSyqZUR6RJ9wqddmyVC
         WBn+oaNtsujnpn3SrWJnhfD3COm8nI649kEqnuBwaN5+jr9xcA+FNuHqWbdJfNLYsHne
         CC6KjNKvxa91X4mS531Zx/cyKUA/SIa6Y5Xbtsdk6ykn3Cxk8xVwKmR50Pd3Tgh2gOqx
         RdTiFURDIPmAR0eertoRqVJ+oYD55deZ3rLJPTd9fKfFUR6fyAFBf/aOpV8b6c3CddYH
         /k5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4JURclh08hC4FA2xFhBr7JqG66IxnFN0sdHwxoag9wA=;
        b=3E8Y9AdyUU8ZMqwx3eBxrBe3XT5ivn/ee5AwiMy4fyTV8AbfflkmMBzS5M4+i07Te1
         1SMAPlNjkAWQgQrcB7Jm4/iGWAaJjMen4wLEaZFtguXDNDqeVPZaCvH2Z5a2L1m7pbFv
         lnHAdztkwZmsc/7DB2TgV6mBX4ji/cQhC5WZukJmyc0URRjWJZ3t+oL5t6tK3yJoOlYE
         YBVTFrFTWJmMT5PeumHSBqitp/idDqjp3D8E2xagtcGxJwxvwObIzrqDKJ01wB71Sr6J
         rIAcsrAZdVDmX4evzOWbSrvi3Rfg/3KceCqK2arm4zncgK2ypzHlPp3RzduW2lk3OFKb
         geTA==
X-Gm-Message-State: AOAM533v06ozyfygs/05mi6blGvGq4Hn1sK5zrX6rODj2bGBrXjjJOO2
	TkBfa1Uu7KXvx6GgM++CgDLoCOLOo/gEm9di+zA=
X-Google-Smtp-Source: 
 ABdhPJydwv+5fGoAWb9nvwXQjndSPWWuYcoPJYf2oC/R2poiS0WlJyt2beBGYFokU1+7D15d7/fdHbowqSKfffxzxrQ=
X-Received: by 2002:a05:6402:5194:: with SMTP id
 q20mr7727516edd.345.1636446747810;
 Tue, 09 Nov 2021 00:32:27 -0800 (PST)
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
In-Reply-To: 
 <CANNYZj9G7YaHpQgCzVZaCjTTAmNXgEiGnkf-GyrXzbxckqp4oA@mail.gmail.com>
From: Marius Kriegerowski <marius.kriegerowski@gmail.com>
Date: Tue, 9 Nov 2021 09:32:16 +0100
Message-ID: 
 <CAMaS9hNwT5iK8X3NKAq6cJq1qk4mHS99a36kTogc6_=fDHALFA@mail.gmail.com>
Subject: Re: [bitbake-devel] bitbake style/workflow
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="00000000000018e06e05d056f365"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 09 Nov 2021 08:32:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12956

--00000000000018e06e05d056f365
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I see.

On 9. Nov 2021, at 09:19, Alexander Kanavin <alex.kanavin@gmail.com> wrote:

I think you misunderstood me too. It's about the github UI which does its
best to hide the commit messages, and doesn't allow to comment on their
content. Yes you can contort yourself and still do it, but the tools do not
help.


I never felt that the commit messages are really that hidden. I mean=E2=80=
=A6 you
find them under `commits`... I find that pretty transparent. You can
comment on the commit message content in the thread of the MR, just as you
would in an email thread, can't you?

Also, the older and closed threads can be very helpful when searching for
answers why something has been changed in which way. I know that I saw the
email threads on patches as well but found them super hard to read (no
syntax highlighting, all black and white, =E2=80=A6). Well, probably I coul=
d get
used to reading them over time. But then =E2=80=94 why should I if there ar=
e things
like collapsable threads, syntax highlight, color,=E2=80=A6?

Best
Marius


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
>>> d830df9cbd4113a4352b2c contained a couple of white-space after comma
>>> fixing
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


Am Di., 9. Nov. 2021 um 09:19 Uhr schrieb Alexander Kanavin <
alex.kanavin@gmail.com>:

> I think you misunderstood me too. It's about the github UI which does its
> best to hide the commit messages, and doesn't allow to comment on their
> content. Yes you can contort yourself and still do it, but the tools do n=
ot
> help.
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
>>>> d830df9cbd4113a4352b2c
>>>> <http://git.yoctoproject.org/cgit.cgi/poky/commit/?id=3D47e5c456a20432=
b511d830df9cbd4113a4352b2c> contained
>>>> a couple of white-space after comma fixing
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

--00000000000018e06e05d056f365
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><span style=3D"color:rgb(0,0,0);font-family:Helvetica;font=
-size:12px;font-style:normal;font-variant-caps:normal;font-weight:normal;le=
tter-spacing:normal;text-align:start;text-indent:0px;text-transform:none;wh=
ite-space:normal;word-spacing:0px;text-decoration:none;display:inline;float=
:none">I see.</span><br class=3D"gmail-" style=3D"color:rgb(0,0,0);font-fam=
ily:Helvetica;font-size:12px;font-style:normal;font-variant-caps:normal;fon=
t-weight:normal;letter-spacing:normal;text-align:start;text-indent:0px;text=
-transform:none;white-space:normal;word-spacing:0px;text-decoration:none"><=
div style=3D"color:rgb(0,0,0);font-family:Helvetica;font-size:12px;font-sty=
le:normal;font-variant-caps:normal;font-weight:normal;letter-spacing:normal=
;text-align:start;text-indent:0px;text-transform:none;white-space:normal;wo=
rd-spacing:0px;text-decoration:none"><br class=3D"gmail-"><blockquote type=
=3D"cite" class=3D"gmail-"><div class=3D"gmail-">On 9. Nov 2021, at 09:19, =
Alexander Kanavin &lt;<a href=3D"mailto:alex.kanavin@gmail.com" class=3D"gm=
ail-">alex.kanavin@gmail.com</a>&gt; wrote:</div><br class=3D"gmail-Apple-i=
nterchange-newline"><div class=3D"gmail-"><div dir=3D"ltr" class=3D"gmail-"=
><div class=3D"gmail-">I think you misunderstood me too. It&#39;s about the=
 github UI which does its best to hide the commit messages, and doesn&#39;t=
 allow to comment on their content. Yes you can contort yourself and still =
do it, but the tools do not help.</div></div></div></blockquote><div><br cl=
ass=3D"gmail-"></div><div>I never felt that the commit messages are really =
that hidden. I mean=E2=80=A6 you find them under `commits`... I find that p=
retty transparent. You can comment on the commit message content in the thr=
ead of the MR, just as you would in an email thread, can&#39;t you?</div><d=
iv><br class=3D"gmail-"></div><div>Also, the older and closed threads can b=
e very helpful when searching for answers why something has been changed in=
 which way. I know that I saw the email threads on patches as well but foun=
d them super hard to read (no syntax highlighting, all black and white, =E2=
=80=A6). Well, probably I could get used to reading them over time. But the=
n =E2=80=94 why should I if there are things like collapsable threads, synt=
ax highlight, color,=E2=80=A6?</div><div><br class=3D"gmail-"></div><div>Be=
st</div><div>Marius</div><div><br class=3D"gmail-"></div><br class=3D"gmail=
-"><blockquote type=3D"cite" class=3D"gmail-"><div class=3D"gmail-"><div di=
r=3D"ltr" class=3D"gmail-"><div class=3D"gmail-">Alex<br class=3D"gmail-"><=
/div></div><br class=3D"gmail-"><div class=3D"gmail_quote"><div dir=3D"ltr"=
 class=3D"gmail_attr">On Tue, 9 Nov 2021 at 09:05, Marius Kriegerowski &lt;=
<a href=3D"mailto:marius.kriegerowski@gmail.com" class=3D"gmail-">marius.kr=
iegerowski@gmail.com</a>&gt; wrote:<br class=3D"gmail-"></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr" class=3D"gmail-"><div=
 class=3D"gmail-" style=3D"font-family:Helvetica;font-size:12px;font-style:=
normal;font-variant-caps:normal;font-weight:normal;letter-spacing:normal;te=
xt-align:start;text-indent:0px;text-transform:none;white-space:normal;word-=
spacing:0px;text-decoration:none">Good morning,</div><div class=3D"gmail-" =
style=3D"font-family:Helvetica;font-size:12px;font-style:normal;font-varian=
t-caps:normal;font-weight:normal;letter-spacing:normal;text-align:start;tex=
t-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;text-d=
ecoration:none"><br class=3D"gmail-"></div><div class=3D"gmail-" style=3D"f=
ont-family:Helvetica;font-size:12px;font-style:normal;font-variant-caps:nor=
mal;font-weight:normal;letter-spacing:normal;text-align:start;text-indent:0=
px;text-transform:none;white-space:normal;word-spacing:0px;text-decoration:=
none">I don=E2=80=99t think this is correct. You can change the git history=
 and commit messages of every MR to whatever you like with `git commit =E2=
=80=94amend`, `git rebase -I` and `git push -f`. So, you can very well ask =
contributors to cleanup their history before merging.</div><div class=3D"gm=
ail-" style=3D"font-family:Helvetica;font-size:12px;font-style:normal;font-=
variant-caps:normal;font-weight:normal;letter-spacing:normal;text-align:sta=
rt;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;=
text-decoration:none"><br class=3D"gmail-"></div><div class=3D"gmail-" styl=
e=3D"font-family:Helvetica;font-size:12px;font-style:normal;font-variant-ca=
ps:normal;font-weight:normal;letter-spacing:normal;text-align:start;text-in=
dent:0px;text-transform:none;white-space:normal;word-spacing:0px;text-decor=
ation:none">Best</div><div class=3D"gmail-" style=3D"font-family:Helvetica;=
font-size:12px;font-style:normal;font-variant-caps:normal;font-weight:norma=
l;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:non=
e;white-space:normal;word-spacing:0px;text-decoration:none">Marius</div></d=
iv><br class=3D"gmail-"><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">Am Di., 9. Nov. 2021 um 07:47=C2=A0Uhr schrieb Alexander Ka=
navin &lt;<a href=3D"mailto:alex.kanavin@gmail.com" target=3D"_blank" class=
=3D"gmail-">alex.kanavin@gmail.com</a>&gt;:<br class=3D"gmail-"></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr" class=3D"gmai=
l-"><div class=3D"gmail-">There&#39;s another problem with github/gitlab wh=
ich I find significant. These tools do not allow reviewing commit messages,=
 and don&#39;t even make it easy to see them. So the developers using those=
 tools, both submitters and maintainers, are effectively being conditioned =
by the tools to see good commit messages as superfluous and unnecessary. An=
d so you more often than not end up with poorly written commit history in g=
ithub projects, or, if you&#39;re a reviewer, have to repeatedly explain to=
 the submitter how to explain and structure their changes properly.</div><d=
iv class=3D"gmail-"><br class=3D"gmail-"></div><div class=3D"gmail-">I&#39;=
d rather not have a change, than have a change that no one, even the origin=
al author, can understand or remember the reasons for one year down the lin=
e.</div><div class=3D"gmail-"><br class=3D"gmail-"></div><div class=3D"gmai=
l-">Alex<br class=3D"gmail-"></div><br class=3D"gmail-"></div><br class=3D"=
gmail-"><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On=
 Tue, 9 Nov 2021 at 00:30, Richard Purdie &lt;<a href=3D"mailto:richard.pur=
die@linuxfoundation.org" target=3D"_blank" class=3D"gmail-">richard.purdie@=
linuxfoundation.org</a>&gt; wrote:<br class=3D"gmail-"></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">On Mon, 2021-11-08 at 23:44 +0100, Mari=
us Kriegerowski wrote:<br class=3D"gmail-">&gt;<span class=3D"gmail-Apple-c=
onverted-space">=C2=A0</span><br class=3D"gmail-">&gt;<span class=3D"gmail-=
Apple-converted-space">=C2=A0</span><br class=3D"gmail-">&gt; &gt; On 8. No=
v 2021, at 22:47, Richard Purdie<br class=3D"gmail-">&gt; &gt; &lt;<a href=
=3D"mailto:richard.purdie@linuxfoundation.org" target=3D"_blank" class=3D"g=
mail-">richard.purdie@linuxfoundation.org</a>&gt; wrote:<br class=3D"gmail-=
">&gt; &gt;<span class=3D"gmail-Apple-converted-space">=C2=A0</span><br cla=
ss=3D"gmail-">&gt; &gt; On Mon, 2021-11-08 at 18:37 +0100, Marius Kriegerow=
ski wrote:<br class=3D"gmail-">&gt; &gt; &gt; Is there a plan to switch to =
some more modern ways to collaborate on<br class=3D"gmail-">&gt; &gt; &gt; =
bitbake,<br class=3D"gmail-">&gt; &gt; &gt; you know, like, gitlab/github/g=
itea with issues, PRs and so forth? I mean=E2=80=A6<br class=3D"gmail-">&gt=
; &gt; &gt; it=E2=80=99s<br class=3D"gmail-">&gt; &gt; &gt; late 2021 and s=
ending MRs/Issues via email feels reaaaally outdated, slow,<br class=3D"gma=
il-">&gt; &gt; &gt; intransparent, ineffective (how to you do reviews, code=
 comparisons during<br class=3D"gmail-">&gt; &gt; &gt; reviews, insert sugg=
estions, etc.) and indirect (where is the CI pipeline<br class=3D"gmail-">&=
gt; &gt; &gt; that I<br class=3D"gmail-">&gt; &gt; &gt; trigger when pushin=
g something somewhere?).<br class=3D"gmail-">&gt; &gt;<span class=3D"gmail-=
Apple-converted-space">=C2=A0</span><br class=3D"gmail-">&gt; &gt; There ar=
e pros and cons to switching to something else. Keep in mind that<br class=
=3D"gmail-">&gt; &gt; whilst the github workflow works well for a single ma=
intainer of a project,<br class=3D"gmail-">&gt; &gt; it does not work well =
for diverse review.<br class=3D"gmail-">&gt;<br class=3D"gmail-">&gt; I str=
ongly disagree with that. Reviews can equally well be done in a MR<br class=
=3D"gmail-">&gt; thread. That=E2=80=99s what they are there for. You can di=
scuss things there with as<br class=3D"gmail-">&gt; many people as you want=
 and can e.g. define a minimum number of approvals<br class=3D"gmail-">&gt;=
 before a MR can be merged.<br class=3D"gmail-"><br class=3D"gmail-">You mi=
sunderstand my point. We have a several thousand people on the mailing<br c=
lass=3D"gmail-">lists and they filter things to what interests them. *I* ha=
ve no people I want<br class=3D"gmail-">to discuss a given change with, it =
is a question of whether the people who have<br class=3D"gmail-">an interes=
t in a given change would see it.<br class=3D"gmail-"><br class=3D"gmail-">=
A minimum number of approvals is utterly meaningless for how we work, I nee=
d the<br class=3D"gmail-">interested people to see it and that varies massi=
vely depending on what is being<br class=3D"gmail-">changed. It is this asp=
ect of mailing list change distribution and discussion we<br class=3D"gmail=
-">benefit from.<br class=3D"gmail-"><br class=3D"gmail-">&gt; =C2=A0It als=
o naturally groups discussions. You can address experts for specific<br cla=
ss=3D"gmail-">&gt; domains which means less noise for the experts. I really=
 don=E2=80=99t see why mailing<br class=3D"gmail-">&gt; list reviews should=
 work any better here.<br class=3D"gmail-"><br class=3D"gmail-">We all have=
 established mechanisms to &quot;see&quot; the things which interest us as<=
br class=3D"gmail-">maintainers?<br class=3D"gmail-"><br class=3D"gmail-">P=
lease don&#39;t misunderstand me, I do see the attraction of github from yo=
ur<br class=3D"gmail-">perspective. It would just destroy the ecosystem we =
already have. You are<br class=3D"gmail-">basically saying that our current=
 ecosystem is worthless but I would point out<br class=3D"gmail-">it has re=
sulted in a project which you did say you appreciate so it can&#39;t be all=
<br class=3D"gmail-">bad.<br class=3D"gmail-"><br class=3D"gmail-">&gt; =C2=
=A0If google can coordinate 2.1k repos with 1.1k contributors over GitHub, =
why<br class=3D"gmail-">&gt; should that not work for openembedded??<br cla=
ss=3D"gmail-"><br class=3D"gmail-">It isn&#39;t about raw numbers, it is ab=
out numbers of reviewers for a given change.<br class=3D"gmail-">We have hu=
ndreds of people doing that using the mailing lists.<br class=3D"gmail-"><b=
r class=3D"gmail-">&gt; &gt; The Bitbake case is a little bit different but=
 in general we&#39;d follow what<br class=3D"gmail-">&gt; &gt; OE/Yocto Pro=
ject are doing.<br class=3D"gmail-">&gt; &gt;<span class=3D"gmail-Apple-con=
verted-space">=C2=A0</span><br class=3D"gmail-">&gt; &gt; We have discussed=
 changing and it is listed as one topic on:<br class=3D"gmail-">&gt; &gt;<s=
pan class=3D"gmail-Apple-converted-space">=C2=A0</span><a href=3D"https://w=
iki.yoctoproject.org/wiki/Future_Directions" rel=3D"noreferrer" target=3D"_=
blank" class=3D"gmail-">https://wiki.yoctoproject.org/wiki/Future_Direction=
s</a><br class=3D"gmail-">&gt; &gt; (Code Submission process)<br class=3D"g=
mail-">&gt; &gt;<span class=3D"gmail-Apple-converted-space">=C2=A0</span><b=
r class=3D"gmail-">&gt; &gt; I&#39;d note that it is a huge change to our c=
urrent developers and most of us<br class=3D"gmail-">&gt; &gt; are very use=
d to the mailing lists so if we did change, it would allow<br class=3D"gmai=
l-">&gt; &gt; potential new collaborators at the risk of losing people with=
 key<br class=3D"gmail-">&gt; &gt; knowledge/experience.<br class=3D"gmail-=
">&gt; =E2=80=A6 which reads to me like: =E2=80=9CIt has always been that w=
ay so we will not change<br class=3D"gmail-">&gt; that&quot; doesn=E2=80=99=
t it? Always a very poor argument.<br class=3D"gmail-"><br class=3D"gmail-"=
>No, what I said is &quot;upsetting our existing developers is something wh=
ich we may<br class=3D"gmail-">want to potentially avoid&quot;.<br class=3D=
"gmail-"><br class=3D"gmail-">There are some options out there which have o=
ffered mailing list integration for<br class=3D"gmail-">example and we have=
 tried to explore those. Something which drops the lists<br class=3D"gmail-=
">entirely could in the current view of the TSC result in loss of too many =
of our<br class=3D"gmail-">existing maintainers.<br class=3D"gmail-"><br cl=
ass=3D"gmail-">&gt;<span class=3D"gmail-Apple-converted-space">=C2=A0</span=
><br class=3D"gmail-">&gt; &gt; We do have CI which is shared with Yocto Pr=
oject and=C2=A0<br class=3D"gmail-">&gt; &gt; OpenEmbedded. You can see it =
here:<br class=3D"gmail-">&gt; &gt;<span class=3D"gmail-Apple-converted-spa=
ce">=C2=A0</span><br class=3D"gmail-">&gt; &gt;<span class=3D"gmail-Apple-c=
onverted-space">=C2=A0</span><a href=3D"https://autobuilder.yoctoproject.or=
g/typhoon/#/console" rel=3D"noreferrer" target=3D"_blank" class=3D"gmail-">=
https://autobuilder.yoctoproject.org/typhoon/#/console</a><br class=3D"gmai=
l-">&gt; &gt;<span class=3D"gmail-Apple-converted-space">=C2=A0</span><br c=
lass=3D"gmail-">&gt; &gt; and it has it&#39;s own manual which was recently=
 added to our documentations<br class=3D"gmail-">&gt; &gt; set:<br class=3D=
"gmail-">&gt; &gt;<span class=3D"gmail-Apple-converted-space">=C2=A0</span>=
<br class=3D"gmail-">&gt; &gt;<span class=3D"gmail-Apple-converted-space">=
=C2=A0</span><a href=3D"http://docs.yoctoproject.org/test-manual/index.html=
" rel=3D"noreferrer" target=3D"_blank" class=3D"gmail-">http://docs.yoctopr=
oject.org/test-manual/index.html</a><br class=3D"gmail-">&gt; =E2=80=A6 str=
essing my point: Why does the location of the CI need documentation? All<br=
 class=3D"gmail-">&gt; of the aforementioned platforms smoothly integrate w=
ith multiple CI solutions,<br class=3D"gmail-">&gt; drastically reducing th=
e time required for reviews if the pipeline provides<br class=3D"gmail-">&g=
t; automated feedback to the contributor. It would probably cost me about o=
ne<br class=3D"gmail-">&gt; afternoon to setup a decent CI pipeline at leas=
t for all python codes pushing<br class=3D"gmail-">&gt; the need to review =
from manual labor to automated tools. If open embedded<br class=3D"gmail-">=
&gt; migrates to a proper git platform I happily volunteer on that end!!<br=
 class=3D"gmail-"><br class=3D"gmail-">We&#39;re not talking about simple p=
ython code. We&#39;re talking about testing a build<br class=3D"gmail-">env=
ironment which cross compiles multiple operating systems for multiple<br cl=
ass=3D"gmail-">architectures, C libraries, GUI stacks, init systems and so =
on. Testing the<br class=3D"gmail-">python code is one small part of that. =
I&#39;ve spent several years trying to<br class=3D"gmail-">improve and get =
our CI to where it is today.<br class=3D"gmail-"><br class=3D"gmail-">Yes, =
the python code is tested as part of this as we don&#39;t really want to ha=
ve<br class=3D"gmail-">multiple test platforms and the real world usage is =
some of the best testing<br class=3D"gmail-">changes can have.<br class=3D"=
gmail-"><br class=3D"gmail-">&gt; &gt; There is work still needed on that b=
ut it is a start.=C2=A0One challenge of<br class=3D"gmail-">&gt; &gt; bitba=
ke/OE is that the builds take an age and the test matrix is huge so the<br =
class=3D"gmail-">&gt; &gt; CI<br class=3D"gmail-">&gt; &gt; process isn&#39=
;t quite as simple as some other simpler projects.<br class=3D"gmail-">&gt;=
 At least for python I bet that most bugs can be caught simply by firing up=
<br class=3D"gmail-">&gt; `black`, `flake8`, `pylint` (and a hand full of o=
ther tools) just to check the<br class=3D"gmail-">&gt; modified files.<br c=
lass=3D"gmail-"><br class=3D"gmail-">Well, I would bet that most of our bug=
s are not caused by issues like that. I do<br class=3D"gmail-">attend the w=
eekly bug triage meetings and have fixed my share of them. You could<br cla=
ss=3D"gmail-">have a look at the issues filed in bugzilla over the past few=
 weeks if you&#39;d<br class=3D"gmail-">like to see the kinds of issues tha=
t get filed and are open.<br class=3D"gmail-"><br class=3D"gmail-">&gt; =C2=
=A0Regarding meta-layers and recipes out there we are currently pushing for=
ward<br class=3D"gmail-">&gt; with a linter for bitbake recipes (thanks @pr=
iv-kweihmann for this awesome and<br class=3D"gmail-">&gt; overdue tool!!!)=
.<br class=3D"gmail-"><br class=3D"gmail-">Whilst improving recipes in that=
 way does help, it isn&#39;t the main source of our<br class=3D"gmail-">maj=
or issues.<br class=3D"gmail-"><br class=3D"gmail-">&gt; &gt;<span class=3D=
"gmail-Apple-converted-space">=C2=A0</span><br class=3D"gmail-">&gt; &gt; A=
s a shortcut through things, the &quot;bitbake-selftest&quot; command withi=
n bitbake<br class=3D"gmail-">&gt; &gt; may<br class=3D"gmail-">&gt; &gt; b=
e one thing you&#39;re looking for which does simple tests on bitbake. It i=
sn&#39;t<br class=3D"gmail-">&gt; &gt; complete coverage and we welcome mor=
e being added, it is a start and some<br class=3D"gmail-">&gt; &gt; areas<b=
r class=3D"gmail-">&gt; &gt; of the code are covered better than others.<br=
 class=3D"gmail-">&gt; I=E2=80=99d love to overhaul the tests e.g. porting =
them to `pytest` which offers a<br class=3D"gmail-">&gt; much simpler yet m=
uch more powerful API/plugin-ecosystem. But won=E2=80=99t do via<br class=
=3D"gmail-">&gt; email :)<br class=3D"gmail-"><br class=3D"gmail-">The test=
s are written in python&#39;s own unittest.<br class=3D"gmail-"><br class=
=3D"gmail-">&gt; &gt; Issues are filed in the project bugzilla and are acti=
vely worked on:<br class=3D"gmail-">&gt; &gt;<span class=3D"gmail-Apple-con=
verted-space">=C2=A0</span><br class=3D"gmail-">&gt; &gt;<span class=3D"gma=
il-Apple-converted-space">=C2=A0</span><a href=3D"https://bugzilla.yoctopro=
ject.org/" rel=3D"noreferrer" target=3D"_blank" class=3D"gmail-">https://bu=
gzilla.yoctoproject.org/</a><br class=3D"gmail-">&gt; Didn=E2=80=99t know t=
hat. But why keeping issues separate from MRs? Automatic issue<br class=3D"=
gmail-">&gt; closing through referencing in MRs is a pretty nice feature=E2=
=80=A6<br class=3D"gmail-"><br class=3D"gmail-">If I had to list the pain p=
oints we have, this is not high on the list.<br class=3D"gmail-"><br class=
=3D"gmail-">&gt; &gt; &gt; * side-note on bitbake style/linting: It=E2=80=
=99s violating PEP8 in a couple of<br class=3D"gmail-">&gt; &gt; &gt; ways =
and TBH PEP8 is the bare minimum I would accept these days for<br class=3D"=
gmail-">&gt; &gt; &gt; collaboration on projects the dimension of bitbake. =
So an additional<br class=3D"gmail-">&gt; &gt; &gt; question: Would you be =
up for a PEP8 compatibility overhaul of the source<br class=3D"gmail-">&gt;=
 &gt; &gt; code? I=E2=80=99d volunteer if I don=E2=80=99t have to send a pa=
tch via email ;)<br class=3D"gmail-">&gt; &gt;<span class=3D"gmail-Apple-co=
nverted-space">=C2=A0</span><br class=3D"gmail-">&gt; &gt; We&#39;re intere=
sted in patches to improve the coding style as long as they<br class=3D"gma=
il-">&gt; &gt; don&#39;t<br class=3D"gmail-">&gt; &gt; break things like re=
adability or performance.=C2=A0Which rules in PEP8 in<br class=3D"gmail-">&=
gt; &gt; particular<br class=3D"gmail-">&gt; &gt; are you referring to?<br =
class=3D"gmail-">&gt;<span class=3D"gmail-Apple-converted-space">=C2=A0</sp=
an><br class=3D"gmail-">&gt; To name a few violations:<br class=3D"gmail-">=
&gt;<span class=3D"gmail-Apple-converted-space">=C2=A0</span><br class=3D"g=
mail-">&gt; =C2=A0* hanging indents<br class=3D"gmail-">&gt; =C2=A0* incons=
istent indentation<br class=3D"gmail-">&gt; =C2=A0* 2 separating lines miss=
ing in between classes/top level methods<br class=3D"gmail-"><br class=3D"g=
mail-">FWIW I find it really hard to get worked up about whitespace issues.=
 I<br class=3D"gmail-">appreciate these aren&#39;t always great to look at =
and I appreciate the familiarity<br class=3D"gmail-">argument and standardi=
sing the look but these aren&#39;t issues I would prioritise.<br class=3D"g=
mail-"><br class=3D"gmail-">In particular changing them globally in mass pa=
tches tends to break patch<br class=3D"gmail-">backporting and taking fixes=
 back to older code which we do benefit from being<br class=3D"gmail-">able=
 to do so there is a cost to doing it. We are trying to make new code more<=
br class=3D"gmail-">consistent and with older code, we do try and fix the w=
orst issues.<br class=3D"gmail-"><br class=3D"gmail-">&gt; =C2=A0* unused i=
mported modules<br class=3D"gmail-">&gt; =C2=A0* missing white-spaces after=
 comma<br class=3D"gmail-">&gt; =C2=A0* unreachable codes<br class=3D"gmail=
-"><br class=3D"gmail-">These ones we do take patches for and try to fix wh=
en/where we see it. For<br class=3D"gmail-">example,=C2=A0<a href=3D"http:/=
/git.yoctoproject.org/cgit.cgi/poky/commit/?id=3D47e5c456a20432b511d830df9c=
bd4113a4352b2c" rel=3D"noreferrer" target=3D"_blank" class=3D"gmail-">http:=
//git.yoctoproject.org/cgit.cgi/poky/commit/?id=3D47e5c456a20432b511<br cla=
ss=3D"gmail-">d830df9cbd4113a4352b2c</a>=C2=A0contained a couple of white-s=
pace after comma fixing<br class=3D"gmail-">while I was in that area.<br cl=
ass=3D"gmail-"><br class=3D"gmail-">&gt; These are just a couple of example=
s that struck my PEP8 used eye from looking<br class=3D"gmail-">&gt; at two=
, three modules.<br class=3D"gmail-">&gt;<span class=3D"gmail-Apple-convert=
ed-space">=C2=A0</span><br class=3D"gmail-">&gt; It=E2=80=99s just like wit=
h any code smell: they don=E2=80=99t necessarily break things. But<br class=
=3D"gmail-">&gt; they make maintenance, code-reviews and quality control ha=
rder than necessary.<br class=3D"gmail-">&gt; Code that does not at least f=
ollow PEP8 (and I actually strongly recommend to<br class=3D"gmail-">&gt; g=
o the extra mile with `black`) just looks odd and is unnecessary hard to<br=
 class=3D"gmail-">&gt; read. I=E2=80=99m surprised I have to argue for stan=
dards.<br class=3D"gmail-"><br class=3D"gmail-">I wasn&#39;t saying it was =
a bad thing, I asked which issues you noticed in<br class=3D"gmail-">partic=
ular since I&#39;m trying to ensure we do at least try and react to feedbac=
k.<br class=3D"gmail-">Some whitespace issues we aren&#39;t likely to tackl=
e, some like the others you<br class=3D"gmail-">mentioned above we should f=
ix.<br class=3D"gmail-">&gt;<span class=3D"gmail-Apple-converted-space">=C2=
=A0</span><br class=3D"gmail-">&gt; Besides that, some minor cleanup just t=
o warm<br class=3D"gmail-">&gt; up:=C2=A0<a href=3D"https://github.com/open=
embedded/bitbake/pull/33" rel=3D"noreferrer" target=3D"_blank" class=3D"gma=
il-">https://github.com/openembedded/bitbake/pull/33</a>,=C2=A0<a href=3D"h=
ttps://github.com/openem" rel=3D"noreferrer" target=3D"_blank" class=3D"gma=
il-">https://github.com/openem</a><br class=3D"gmail-">&gt; bedded/bitbake/=
pull/32/files=C2=A0<br class=3D"gmail-"><br class=3D"gmail-">Those two do l=
ook like reasonable changes FWIW.<br class=3D"gmail-"><br class=3D"gmail-">=
&gt; (it was after these two that I found the comment in one of those old c=
ommits<br class=3D"gmail-">&gt; which made me open=C2=A0<a href=3D"https://=
github.com/openembedded/bitbake/pull/34" rel=3D"noreferrer" target=3D"_blan=
k" class=3D"gmail-">https://github.com/openembedded/bitbake/pull/34</a>). A=
t least<br class=3D"gmail-">&gt; there should be an=C2=A0automated reply to=
 each MR that is posted if someone makes<br class=3D"gmail-">&gt; the effor=
t to fix code and open a MRs that this is=C2=A0actually in vein - That=E2=
=80=99s<br class=3D"gmail-">&gt; the=C2=A0mood that took me here :)<br clas=
s=3D"gmail-"><br class=3D"gmail-">There is a certain irony in that given yo=
u patched the section called<br class=3D"gmail-">&quot;Contributing&quot; i=
n the README in 32!<br class=3D"gmail-"><br class=3D"gmail-">&gt; &gt;<span=
 class=3D"gmail-Apple-converted-space">=C2=A0</span><br class=3D"gmail-">&g=
t; &gt; Help appreciated but email patches is how we accept them at the mom=
ent.<br class=3D"gmail-">&gt;<span class=3D"gmail-Apple-converted-space">=
=C2=A0</span><br class=3D"gmail-">&gt; Not from me then :(<br class=3D"gmai=
l-"><br class=3D"gmail-">Sorry to hear that, your changes in 32/33 do look =
reasonable.<br class=3D"gmail-"><br class=3D"gmail-">Cheers,<br class=3D"gm=
ail-"><br class=3D"gmail-">Richard<br class=3D"gmail-"><br class=3D"gmail-"=
><br class=3D"gmail-">-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br clas=
s=3D"gmail-">Links: You receive all messages sent to this group.<br class=
=3D"gmail-">View/Reply Online (#12951):<span class=3D"gmail-Apple-converted=
-space">=C2=A0</span><a href=3D"https://lists.openembedded.org/g/bitbake-de=
vel/message/12951" rel=3D"noreferrer" target=3D"_blank" class=3D"gmail-">ht=
tps://lists.openembedded.org/g/bitbake-devel/message/12951</a><br class=3D"=
gmail-">Mute This Topic:<span class=3D"gmail-Apple-converted-space">=C2=A0<=
/span><a href=3D"https://lists.openembedded.org/mt/86911583/1686489" rel=3D=
"noreferrer" target=3D"_blank" class=3D"gmail-">https://lists.openembedded.=
org/mt/86911583/1686489</a><br class=3D"gmail-">Group Owner:<span class=3D"=
gmail-Apple-converted-space">=C2=A0</span><a href=3D"mailto:bitbake-devel%2=
Bowner@lists.openembedded.org" target=3D"_blank" class=3D"gmail-">bitbake-d=
evel+owner@lists.openembedded.org</a><br class=3D"gmail-">Unsubscribe:<span=
 class=3D"gmail-Apple-converted-space">=C2=A0</span><a href=3D"https://list=
s.openembedded.org/g/bitbake-devel/unsub" rel=3D"noreferrer" target=3D"_bla=
nk" class=3D"gmail-">https://lists.openembedded.org/g/bitbake-devel/unsub</=
a><span class=3D"gmail-Apple-converted-space">=C2=A0</span>[<a href=3D"mail=
to:alex.kanavin@gmail.com" target=3D"_blank" class=3D"gmail-">alex.kanavin@=
gmail.com</a>]<br class=3D"gmail-">-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-<br class=3D"gmail-"><br class=3D"gmail-"></blockquote></div></blockqu=
ote></div></blockquote></div></div></blockquote></div><br class=3D"gmail-Ap=
ple-interchange-newline"><br></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">Am Di., 9. Nov. 2021 um 09:19=C2=A0Uhr schrie=
b Alexander Kanavin &lt;<a href=3D"mailto:alex.kanavin@gmail.com">alex.kana=
vin@gmail.com</a>&gt;:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex"><div dir=3D"ltr"><div>I think you misunderstood me too. It&#39;s abo=
ut the github UI which does its best to hide the commit messages, and doesn=
&#39;t allow to comment on their content. Yes you can contort yourself and =
still do it, but the tools do not help.</div><div><br></div><div>Alex<br></=
div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_at=
tr">On Tue, 9 Nov 2021 at 09:05, Marius Kriegerowski &lt;<a href=3D"mailto:=
marius.kriegerowski@gmail.com" target=3D"_blank">marius.kriegerowski@gmail.=
com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x"><div dir=3D"ltr"><div style=3D"color:rgb(0,0,0);font-family:Helvetica;fo=
nt-size:12px;font-style:normal;font-variant-caps:normal;font-weight:normal;=
letter-spacing:normal;text-align:start;text-indent:0px;text-transform:none;=
white-space:normal;word-spacing:0px;text-decoration:none">Good morning,</di=
v><div style=3D"color:rgb(0,0,0);font-family:Helvetica;font-size:12px;font-=
style:normal;font-variant-caps:normal;font-weight:normal;letter-spacing:nor=
mal;text-align:start;text-indent:0px;text-transform:none;white-space:normal=
;word-spacing:0px;text-decoration:none"><br></div><div style=3D"color:rgb(0=
,0,0);font-family:Helvetica;font-size:12px;font-style:normal;font-variant-c=
aps:normal;font-weight:normal;letter-spacing:normal;text-align:start;text-i=
ndent:0px;text-transform:none;white-space:normal;word-spacing:0px;text-deco=
ration:none">I don=E2=80=99t think this is correct. You can change the git =
history and commit messages of every MR to whatever you like with `git comm=
it =E2=80=94amend`, `git rebase -I` and `git push -f`. So, you can very wel=
l ask contributors to cleanup their history before merging.</div><div style=
=3D"color:rgb(0,0,0);font-family:Helvetica;font-size:12px;font-style:normal=
;font-variant-caps:normal;font-weight:normal;letter-spacing:normal;text-ali=
gn:start;text-indent:0px;text-transform:none;white-space:normal;word-spacin=
g:0px;text-decoration:none"><br></div><div style=3D"color:rgb(0,0,0);font-f=
amily:Helvetica;font-size:12px;font-style:normal;font-variant-caps:normal;f=
ont-weight:normal;letter-spacing:normal;text-align:start;text-indent:0px;te=
xt-transform:none;white-space:normal;word-spacing:0px;text-decoration:none"=
>Best</div><div style=3D"color:rgb(0,0,0);font-family:Helvetica;font-size:1=
2px;font-style:normal;font-variant-caps:normal;font-weight:normal;letter-sp=
acing:normal;text-align:start;text-indent:0px;text-transform:none;white-spa=
ce:normal;word-spacing:0px;text-decoration:none">Marius</div></div><br><div=
 class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Am Di., 9. Nov=
. 2021 um 07:47=C2=A0Uhr schrieb Alexander Kanavin &lt;<a href=3D"mailto:al=
ex.kanavin@gmail.com" target=3D"_blank">alex.kanavin@gmail.com</a>&gt;:<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><d=
iv>There&#39;s another problem with github/gitlab which I find significant.=
 These tools do not allow reviewing commit messages, and don&#39;t even mak=
e it easy to see them. So the developers using those tools, both submitters=
 and maintainers, are effectively being conditioned by the tools to see goo=
d commit messages as superfluous and unnecessary. And so you more often tha=
n not end up with poorly written commit history in github projects, or, if =
you&#39;re a reviewer, have to repeatedly explain to the submitter how to e=
xplain and structure their changes properly.</div><div><br></div><div>I&#39=
;d rather not have a change, than have a change that no one, even the origi=
nal author, can understand or remember the reasons for one year down the li=
ne.</div><div><br></div><div>Alex<br></div><br></div><br><div class=3D"gmai=
l_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, 9 Nov 2021 at 00:30,=
 Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfoundation.org" t=
arget=3D"_blank">richard.purdie@linuxfoundation.org</a>&gt; wrote:<br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">On Mon, 2021-11-08 at 23=
:44 +0100, Marius Kriegerowski wrote:<br>
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
</blockquote></div>

--00000000000018e06e05d056f365--

