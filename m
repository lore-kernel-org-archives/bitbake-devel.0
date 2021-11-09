Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 404EEC433EF
	for <webhook@archiver.kernel.org>; Tue,  9 Nov 2021 08:44:16 +0000 (UTC)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com
 [209.85.222.47])
 by mx.groups.io with SMTP id smtpd.web09.9539.1636447455069861444
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 09 Nov 2021 00:44:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=pMcwNXLE;
 spf=pass (domain: gmail.com, ip: 209.85.222.47,
 mailfrom: alex.kanavin@gmail.com)
Received: by mail-ua1-f47.google.com with SMTP id ay21so37003861uab.12
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 09 Nov 2021 00:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HWIqkt8wJYS4q5/5VHL0KQWq5fYFPlGQ/CKs/+AQaWI=;
        b=pMcwNXLEqFi3Gmk7PMe4W8+XkM+0ilKvmhqJXsnGYaYmKi3zA1BsuNYw5qa3J8S2io
         URv/iDb262PH2/io376eLRkMKESyMJBZhfLaZj/XCafUqvMJzsQe9q8Fri4YGxbZUbUw
         6HKq4JqHuuOvmcB5EqBs0GSvlSmUp256JZDDBS7sxbTHXUnxx/ulURiEDbrHcP4FcRM1
         nbvIiaNV5HR0X0h1Q7u+Cctj98/QddMfh+MBgF7gb5+ygjnsXnLOIUQ5qZGAAXVEL0Es
         iY3c4vvU1wmfkrgqi80idZG+g6nIz9YjivAIyilwtqzpmKH7xTM6t77UPlcrcSGWpG+5
         JY5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HWIqkt8wJYS4q5/5VHL0KQWq5fYFPlGQ/CKs/+AQaWI=;
        b=ySk2Hs/9whXlsXijsOKavg7dwycau0i4KfwtIvyIHGZ4n8Twax+2VbnrylFnSUEGbr
         pwNvswaX776+YQpecpia9RydAlHrQPAZ1msBnlI76Kpd2BoyKqSfAi2P1LNE86aH8BiE
         grAWonRaIYZYOeZZolv7trNYyxYI1mYNBr13UHV+9+FEaNXxqfFlpNcMsWaoxu3CIEEd
         osXvPWC9fl8Cs+IOV6YE9R7ikVG2gAWSAQVisoAkTsz4/7drX469gNWdoeW2T68dL3At
         uEvdEuH77DzsFdGBhg+pyozRa7vGHiwlmLvMPj/WMJPsHdAIvCh3rPRVIosoFjGWYvLt
         1lRw==
X-Gm-Message-State: AOAM533BM1a06eScfXCmyzwyBo3yKwOjlgZroMMBDQ5sGXhonaAx9jI8
	fttjyGzxp0FmQnfm4cADyPPHxJZiLh2Cf02N/nA=
X-Google-Smtp-Source: 
 ABdhPJx4PFTLIsuiyQ+rXvxRwjGpkZz+L4EYXpwu7wzCmqncEVWKpf4AaoNrhL1Gvve3b0YObi5qQ2WswJUFGjrDf4M=
X-Received: by 2002:a67:c511:: with SMTP id e17mr55885682vsk.40.1636447454050;
 Tue, 09 Nov 2021 00:44:14 -0800 (PST)
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
In-Reply-To: 
 <CAMaS9hNwT5iK8X3NKAq6cJq1qk4mHS99a36kTogc6_=fDHALFA@mail.gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 9 Nov 2021 09:44:02 +0100
Message-ID: 
 <CANNYZj9h5S5bQpx_Xbde8wOBghehf1dCejvyqJgKU5_gSbAafQ@mail.gmail.com>
Subject: Re: [bitbake-devel] bitbake style/workflow
To: Marius Kriegerowski <marius.kriegerowski@gmail.com>
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="000000000000313ab005d0571db9"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 09 Nov 2021 08:44:16 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12957

--000000000000313ab005d0571db9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

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
>>>>> d830df9cbd4113a4352b2c
>>>>> <http://git.yoctoproject.org/cgit.cgi/poky/commit/?id=3D47e5c456a2043=
2b511d830df9cbd4113a4352b2c> contained
>>>>> a couple of white-space after comma fixing
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

--000000000000313ab005d0571db9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail=
_attr">On Tue, 9 Nov 2021 at 09:32, Marius Kriegerowski &lt;<a href=3D"mail=
to:marius.kriegerowski@gmail.com">marius.kriegerowski@gmail.com</a>&gt; wro=
te:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"=
ltr"><span style=3D"color:rgb(0,0,0);font-family:Helvetica;font-size:12px;f=
ont-style:normal;font-variant-caps:normal;font-weight:normal;letter-spacing=
:normal;text-align:start;text-indent:0px;text-transform:none;white-space:no=
rmal;word-spacing:0px;text-decoration:none;display:inline;float:none">I see=
.</span><br style=3D"color:rgb(0,0,0);font-family:Helvetica;font-size:12px;=
font-style:normal;font-variant-caps:normal;font-weight:normal;letter-spacin=
g:normal;text-align:start;text-indent:0px;text-transform:none;white-space:n=
ormal;word-spacing:0px;text-decoration:none"><div style=3D"color:rgb(0,0,0)=
;font-family:Helvetica;font-size:12px;font-style:normal;font-variant-caps:n=
ormal;font-weight:normal;letter-spacing:normal;text-align:start;text-indent=
:0px;text-transform:none;white-space:normal;word-spacing:0px;text-decoratio=
n:none"><br><blockquote type=3D"cite"><div>On 9. Nov 2021, at 09:19, Alexan=
der Kanavin &lt;<a href=3D"mailto:alex.kanavin@gmail.com" target=3D"_blank"=
>alex.kanavin@gmail.com</a>&gt; wrote:</div><br><div><div dir=3D"ltr"><div>=
I think you misunderstood me too. It&#39;s about the github UI which does i=
ts best to hide the commit messages, and doesn&#39;t allow to comment on th=
eir content. Yes you can contort yourself and still do it, but the tools do=
 not help.</div></div></div></blockquote><div><br></div><div>I never felt t=
hat the commit messages are really that hidden. I mean=E2=80=A6 you find th=
em under `commits`... I find that pretty transparent. You can comment on th=
e commit message content in the thread of the MR, just as you would in an e=
mail thread, can&#39;t you?</div></div></div></blockquote><div><br></div><d=
iv>No. You need to separately go to the commits tab, open each commit indiv=
idually to see both the message and the associated code, then if there&#39;=
s something you do not like, you need to copy paste the offending bit and o=
pen a MR thread with it. That&#39;s not helpful, and it&#39;s clear that ki=
nd of thing is not important to the tool providers or users. But it is very=
 important to me as one of the oe-core maintainers.<br></div><div></div><di=
v>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D=
"ltr"><div style=3D"color:rgb(0,0,0);font-family:Helvetica;font-size:12px;f=
ont-style:normal;font-variant-caps:normal;font-weight:normal;letter-spacing=
:normal;text-align:start;text-indent:0px;text-transform:none;white-space:no=
rmal;word-spacing:0px;text-decoration:none"><div>Also, the older and closed=
 threads can be very helpful when searching for answers why something has b=
een changed in which way. I know that I saw the email threads on patches as=
 well but found them super hard to read (no syntax highlighting, all black =
and white, =E2=80=A6). Well, probably I could get used to reading them over=
 time. But then =E2=80=94 why should I if there are things like collapsable=
 threads, syntax highlight, color,=E2=80=A6?</div></div></div></blockquote>=
<div><br></div><div>You can find a better email client perhaps?<br></div><d=
iv><br></div><div>Alex<br></div><div>=C2=A0</div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex"><div dir=3D"ltr"><div style=3D"color:rgb(0,0,0);fon=
t-family:Helvetica;font-size:12px;font-style:normal;font-variant-caps:norma=
l;font-weight:normal;letter-spacing:normal;text-align:start;text-indent:0px=
;text-transform:none;white-space:normal;word-spacing:0px;text-decoration:no=
ne"><div><br></div><div>Best</div><div>Marius</div><div><br></div><br><bloc=
kquote type=3D"cite"><div><div dir=3D"ltr"><div>Alex<br></div></div><br><di=
v class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, 9 Nov=
 2021 at 09:05, Marius Kriegerowski &lt;<a href=3D"mailto:marius.kriegerows=
ki@gmail.com" target=3D"_blank">marius.kriegerowski@gmail.com</a>&gt; wrote=
:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"lt=
r"><div style=3D"font-family:Helvetica;font-size:12px;font-style:normal;fon=
t-variant-caps:normal;font-weight:normal;letter-spacing:normal;text-align:s=
tart;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0p=
x;text-decoration:none">Good morning,</div><div style=3D"font-family:Helvet=
ica;font-size:12px;font-style:normal;font-variant-caps:normal;font-weight:n=
ormal;letter-spacing:normal;text-align:start;text-indent:0px;text-transform=
:none;white-space:normal;word-spacing:0px;text-decoration:none"><br></div><=
div style=3D"font-family:Helvetica;font-size:12px;font-style:normal;font-va=
riant-caps:normal;font-weight:normal;letter-spacing:normal;text-align:start=
;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;te=
xt-decoration:none">I don=E2=80=99t think this is correct. You can change t=
he git history and commit messages of every MR to whatever you like with `g=
it commit =E2=80=94amend`, `git rebase -I` and `git push -f`. So, you can v=
ery well ask contributors to cleanup their history before merging.</div><di=
v style=3D"font-family:Helvetica;font-size:12px;font-style:normal;font-vari=
ant-caps:normal;font-weight:normal;letter-spacing:normal;text-align:start;t=
ext-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;text=
-decoration:none"><br></div><div style=3D"font-family:Helvetica;font-size:1=
2px;font-style:normal;font-variant-caps:normal;font-weight:normal;letter-sp=
acing:normal;text-align:start;text-indent:0px;text-transform:none;white-spa=
ce:normal;word-spacing:0px;text-decoration:none">Best</div><div style=3D"fo=
nt-family:Helvetica;font-size:12px;font-style:normal;font-variant-caps:norm=
al;font-weight:normal;letter-spacing:normal;text-align:start;text-indent:0p=
x;text-transform:none;white-space:normal;word-spacing:0px;text-decoration:n=
one">Marius</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" clas=
s=3D"gmail_attr">Am Di., 9. Nov. 2021 um 07:47=C2=A0Uhr schrieb Alexander K=
anavin &lt;<a href=3D"mailto:alex.kanavin@gmail.com" target=3D"_blank">alex=
.kanavin@gmail.com</a>&gt;:<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex"><div dir=3D"ltr"><div>There&#39;s another problem with github/g=
itlab which I find significant. These tools do not allow reviewing commit m=
essages, and don&#39;t even make it easy to see them. So the developers usi=
ng those tools, both submitters and maintainers, are effectively being cond=
itioned by the tools to see good commit messages as superfluous and unneces=
sary. And so you more often than not end up with poorly written commit hist=
ory in github projects, or, if you&#39;re a reviewer, have to repeatedly ex=
plain to the submitter how to explain and structure their changes properly.=
</div><div><br></div><div>I&#39;d rather not have a change, than have a cha=
nge that no one, even the original author, can understand or remember the r=
easons for one year down the line.</div><div><br></div><div>Alex<br></div><=
br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_att=
r">On Tue, 9 Nov 2021 at 00:30, Richard Purdie &lt;<a href=3D"mailto:richar=
d.purdie@linuxfoundation.org" target=3D"_blank">richard.purdie@linuxfoundat=
ion.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">On Mon, 2021-11-08 at 23:44 +0100, Marius Kriegerowski wrote:<br>&gt=
;<span>=C2=A0</span><br>&gt;<span>=C2=A0</span><br>&gt; &gt; On 8. Nov 2021=
, at 22:47, Richard Purdie<br>&gt; &gt; &lt;<a href=3D"mailto:richard.purdi=
e@linuxfoundation.org" target=3D"_blank">richard.purdie@linuxfoundation.org=
</a>&gt; wrote:<br>&gt; &gt;<span>=C2=A0</span><br>&gt; &gt; On Mon, 2021-1=
1-08 at 18:37 +0100, Marius Kriegerowski wrote:<br>&gt; &gt; &gt; Is there =
a plan to switch to some more modern ways to collaborate on<br>&gt; &gt; &g=
t; bitbake,<br>&gt; &gt; &gt; you know, like, gitlab/github/gitea with issu=
es, PRs and so forth? I mean=E2=80=A6<br>&gt; &gt; &gt; it=E2=80=99s<br>&gt=
; &gt; &gt; late 2021 and sending MRs/Issues via email feels reaaaally outd=
ated, slow,<br>&gt; &gt; &gt; intransparent, ineffective (how to you do rev=
iews, code comparisons during<br>&gt; &gt; &gt; reviews, insert suggestions=
, etc.) and indirect (where is the CI pipeline<br>&gt; &gt; &gt; that I<br>=
&gt; &gt; &gt; trigger when pushing something somewhere?).<br>&gt; &gt;<spa=
n>=C2=A0</span><br>&gt; &gt; There are pros and cons to switching to someth=
ing else. Keep in mind that<br>&gt; &gt; whilst the github workflow works w=
ell for a single maintainer of a project,<br>&gt; &gt; it does not work wel=
l for diverse review.<br>&gt;<br>&gt; I strongly disagree with that. Review=
s can equally well be done in a MR<br>&gt; thread. That=E2=80=99s what they=
 are there for. You can discuss things there with as<br>&gt; many people as=
 you want and can e.g. define a minimum number of approvals<br>&gt; before =
a MR can be merged.<br><br>You misunderstand my point. We have a several th=
ousand people on the mailing<br>lists and they filter things to what intere=
sts them. *I* have no people I want<br>to discuss a given change with, it i=
s a question of whether the people who have<br>an interest in a given chang=
e would see it.<br><br>A minimum number of approvals is utterly meaningless=
 for how we work, I need the<br>interested people to see it and that varies=
 massively depending on what is being<br>changed. It is this aspect of mail=
ing list change distribution and discussion we<br>benefit from.<br><br>&gt;=
 =C2=A0It also naturally groups discussions. You can address experts for sp=
ecific<br>&gt; domains which means less noise for the experts. I really don=
=E2=80=99t see why mailing<br>&gt; list reviews should work any better here=
.<br><br>We all have established mechanisms to &quot;see&quot; the things w=
hich interest us as<br>maintainers?<br><br>Please don&#39;t misunderstand m=
e, I do see the attraction of github from your<br>perspective. It would jus=
t destroy the ecosystem we already have. You are<br>basically saying that o=
ur current ecosystem is worthless but I would point out<br>it has resulted =
in a project which you did say you appreciate so it can&#39;t be all<br>bad=
.<br><br>&gt; =C2=A0If google can coordinate 2.1k repos with 1.1k contribut=
ors over GitHub, why<br>&gt; should that not work for openembedded??<br><br=
>It isn&#39;t about raw numbers, it is about numbers of reviewers for a giv=
en change.<br>We have hundreds of people doing that using the mailing lists=
.<br><br>&gt; &gt; The Bitbake case is a little bit different but in genera=
l we&#39;d follow what<br>&gt; &gt; OE/Yocto Project are doing.<br>&gt; &gt=
;<span>=C2=A0</span><br>&gt; &gt; We have discussed changing and it is list=
ed as one topic on:<br>&gt; &gt;<span>=C2=A0</span><a href=3D"https://wiki.=
yoctoproject.org/wiki/Future_Directions" rel=3D"noreferrer" target=3D"_blan=
k">https://wiki.yoctoproject.org/wiki/Future_Directions</a><br>&gt; &gt; (C=
ode Submission process)<br>&gt; &gt;<span>=C2=A0</span><br>&gt; &gt; I&#39;=
d note that it is a huge change to our current developers and most of us<br=
>&gt; &gt; are very used to the mailing lists so if we did change, it would=
 allow<br>&gt; &gt; potential new collaborators at the risk of losing peopl=
e with key<br>&gt; &gt; knowledge/experience.<br>&gt; =E2=80=A6 which reads=
 to me like: =E2=80=9CIt has always been that way so we will not change<br>=
&gt; that&quot; doesn=E2=80=99t it? Always a very poor argument.<br><br>No,=
 what I said is &quot;upsetting our existing developers is something which =
we may<br>want to potentially avoid&quot;.<br><br>There are some options ou=
t there which have offered mailing list integration for<br>example and we h=
ave tried to explore those. Something which drops the lists<br>entirely cou=
ld in the current view of the TSC result in loss of too many of our<br>exis=
ting maintainers.<br><br>&gt;<span>=C2=A0</span><br>&gt; &gt; We do have CI=
 which is shared with Yocto Project and=C2=A0<br>&gt; &gt; OpenEmbedded. Yo=
u can see it here:<br>&gt; &gt;<span>=C2=A0</span><br>&gt; &gt;<span>=C2=A0=
</span><a href=3D"https://autobuilder.yoctoproject.org/typhoon/#/console" r=
el=3D"noreferrer" target=3D"_blank">https://autobuilder.yoctoproject.org/ty=
phoon/#/console</a><br>&gt; &gt;<span>=C2=A0</span><br>&gt; &gt; and it has=
 it&#39;s own manual which was recently added to our documentations<br>&gt;=
 &gt; set:<br>&gt; &gt;<span>=C2=A0</span><br>&gt; &gt;<span>=C2=A0</span><=
a href=3D"http://docs.yoctoproject.org/test-manual/index.html" rel=3D"noref=
errer" target=3D"_blank">http://docs.yoctoproject.org/test-manual/index.htm=
l</a><br>&gt; =E2=80=A6 stressing my point: Why does the location of the CI=
 need documentation? All<br>&gt; of the aforementioned platforms smoothly i=
ntegrate with multiple CI solutions,<br>&gt; drastically reducing the time =
required for reviews if the pipeline provides<br>&gt; automated feedback to=
 the contributor. It would probably cost me about one<br>&gt; afternoon to =
setup a decent CI pipeline at least for all python codes pushing<br>&gt; th=
e need to review from manual labor to automated tools. If open embedded<br>=
&gt; migrates to a proper git platform I happily volunteer on that end!!<br=
><br>We&#39;re not talking about simple python code. We&#39;re talking abou=
t testing a build<br>environment which cross compiles multiple operating sy=
stems for multiple<br>architectures, C libraries, GUI stacks, init systems =
and so on. Testing the<br>python code is one small part of that. I&#39;ve s=
pent several years trying to<br>improve and get our CI to where it is today=
.<br><br>Yes, the python code is tested as part of this as we don&#39;t rea=
lly want to have<br>multiple test platforms and the real world usage is som=
e of the best testing<br>changes can have.<br><br>&gt; &gt; There is work s=
till needed on that but it is a start.=C2=A0One challenge of<br>&gt; &gt; b=
itbake/OE is that the builds take an age and the test matrix is huge so the=
<br>&gt; &gt; CI<br>&gt; &gt; process isn&#39;t quite as simple as some oth=
er simpler projects.<br>&gt; At least for python I bet that most bugs can b=
e caught simply by firing up<br>&gt; `black`, `flake8`, `pylint` (and a han=
d full of other tools) just to check the<br>&gt; modified files.<br><br>Wel=
l, I would bet that most of our bugs are not caused by issues like that. I =
do<br>attend the weekly bug triage meetings and have fixed my share of them=
. You could<br>have a look at the issues filed in bugzilla over the past fe=
w weeks if you&#39;d<br>like to see the kinds of issues that get filed and =
are open.<br><br>&gt; =C2=A0Regarding meta-layers and recipes out there we =
are currently pushing forward<br>&gt; with a linter for bitbake recipes (th=
anks @priv-kweihmann for this awesome and<br>&gt; overdue tool!!!).<br><br>=
Whilst improving recipes in that way does help, it isn&#39;t the main sourc=
e of our<br>major issues.<br><br>&gt; &gt;<span>=C2=A0</span><br>&gt; &gt; =
As a shortcut through things, the &quot;bitbake-selftest&quot; command with=
in bitbake<br>&gt; &gt; may<br>&gt; &gt; be one thing you&#39;re looking fo=
r which does simple tests on bitbake. It isn&#39;t<br>&gt; &gt; complete co=
verage and we welcome more being added, it is a start and some<br>&gt; &gt;=
 areas<br>&gt; &gt; of the code are covered better than others.<br>&gt; I=
=E2=80=99d love to overhaul the tests e.g. porting them to `pytest` which o=
ffers a<br>&gt; much simpler yet much more powerful API/plugin-ecosystem. B=
ut won=E2=80=99t do via<br>&gt; email :)<br><br>The tests are written in py=
thon&#39;s own unittest.<br><br>&gt; &gt; Issues are filed in the project b=
ugzilla and are actively worked on:<br>&gt; &gt;<span>=C2=A0</span><br>&gt;=
 &gt;<span>=C2=A0</span><a href=3D"https://bugzilla.yoctoproject.org/" rel=
=3D"noreferrer" target=3D"_blank">https://bugzilla.yoctoproject.org/</a><br=
>&gt; Didn=E2=80=99t know that. But why keeping issues separate from MRs? A=
utomatic issue<br>&gt; closing through referencing in MRs is a pretty nice =
feature=E2=80=A6<br><br>If I had to list the pain points we have, this is n=
ot high on the list.<br><br>&gt; &gt; &gt; * side-note on bitbake style/lin=
ting: It=E2=80=99s violating PEP8 in a couple of<br>&gt; &gt; &gt; ways and=
 TBH PEP8 is the bare minimum I would accept these days for<br>&gt; &gt; &g=
t; collaboration on projects the dimension of bitbake. So an additional<br>=
&gt; &gt; &gt; question: Would you be up for a PEP8 compatibility overhaul =
of the source<br>&gt; &gt; &gt; code? I=E2=80=99d volunteer if I don=E2=80=
=99t have to send a patch via email ;)<br>&gt; &gt;<span>=C2=A0</span><br>&=
gt; &gt; We&#39;re interested in patches to improve the coding style as lon=
g as they<br>&gt; &gt; don&#39;t<br>&gt; &gt; break things like readability=
 or performance.=C2=A0Which rules in PEP8 in<br>&gt; &gt; particular<br>&gt=
; &gt; are you referring to?<br>&gt;<span>=C2=A0</span><br>&gt; To name a f=
ew violations:<br>&gt;<span>=C2=A0</span><br>&gt; =C2=A0* hanging indents<b=
r>&gt; =C2=A0* inconsistent indentation<br>&gt; =C2=A0* 2 separating lines =
missing in between classes/top level methods<br><br>FWIW I find it really h=
ard to get worked up about whitespace issues. I<br>appreciate these aren&#3=
9;t always great to look at and I appreciate the familiarity<br>argument an=
d standardising the look but these aren&#39;t issues I would prioritise.<br=
><br>In particular changing them globally in mass patches tends to break pa=
tch<br>backporting and taking fixes back to older code which we do benefit =
from being<br>able to do so there is a cost to doing it. We are trying to m=
ake new code more<br>consistent and with older code, we do try and fix the =
worst issues.<br><br>&gt; =C2=A0* unused imported modules<br>&gt; =C2=A0* m=
issing white-spaces after comma<br>&gt; =C2=A0* unreachable codes<br><br>Th=
ese ones we do take patches for and try to fix when/where we see it. For<br=
>example,=C2=A0<a href=3D"http://git.yoctoproject.org/cgit.cgi/poky/commit/=
?id=3D47e5c456a20432b511d830df9cbd4113a4352b2c" rel=3D"noreferrer" target=
=3D"_blank">http://git.yoctoproject.org/cgit.cgi/poky/commit/?id=3D47e5c456=
a20432b511<br>d830df9cbd4113a4352b2c</a>=C2=A0contained a couple of white-s=
pace after comma fixing<br>while I was in that area.<br><br>&gt; These are =
just a couple of examples that struck my PEP8 used eye from looking<br>&gt;=
 at two, three modules.<br>&gt;<span>=C2=A0</span><br>&gt; It=E2=80=99s jus=
t like with any code smell: they don=E2=80=99t necessarily break things. Bu=
t<br>&gt; they make maintenance, code-reviews and quality control harder th=
an necessary.<br>&gt; Code that does not at least follow PEP8 (and I actual=
ly strongly recommend to<br>&gt; go the extra mile with `black`) just looks=
 odd and is unnecessary hard to<br>&gt; read. I=E2=80=99m surprised I have =
to argue for standards.<br><br>I wasn&#39;t saying it was a bad thing, I as=
ked which issues you noticed in<br>particular since I&#39;m trying to ensur=
e we do at least try and react to feedback.<br>Some whitespace issues we ar=
en&#39;t likely to tackle, some like the others you<br>mentioned above we s=
hould fix.<br>&gt;<span>=C2=A0</span><br>&gt; Besides that, some minor clea=
nup just to warm<br>&gt; up:=C2=A0<a href=3D"https://github.com/openembedde=
d/bitbake/pull/33" rel=3D"noreferrer" target=3D"_blank">https://github.com/=
openembedded/bitbake/pull/33</a>,=C2=A0<a href=3D"https://github.com/openem=
" rel=3D"noreferrer" target=3D"_blank">https://github.com/openem</a><br>&gt=
; bedded/bitbake/pull/32/files=C2=A0<br><br>Those two do look like reasonab=
le changes FWIW.<br><br>&gt; (it was after these two that I found the comme=
nt in one of those old commits<br>&gt; which made me open=C2=A0<a href=3D"h=
ttps://github.com/openembedded/bitbake/pull/34" rel=3D"noreferrer" target=
=3D"_blank">https://github.com/openembedded/bitbake/pull/34</a>). At least<=
br>&gt; there should be an=C2=A0automated reply to each MR that is posted i=
f someone makes<br>&gt; the effort to fix code and open a MRs that this is=
=C2=A0actually in vein - That=E2=80=99s<br>&gt; the=C2=A0mood that took me =
here :)<br><br>There is a certain irony in that given you patched the secti=
on called<br>&quot;Contributing&quot; in the README in 32!<br><br>&gt; &gt;=
<span>=C2=A0</span><br>&gt; &gt; Help appreciated but email patches is how =
we accept them at the moment.<br>&gt;<span>=C2=A0</span><br>&gt; Not from m=
e then :(<br><br>Sorry to hear that, your changes in 32/33 do look reasonab=
le.<br><br>Cheers,<br><br>Richard<br><br><br>-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=
=3D-=3D-=3D-=3D-<br>Links: You receive all messages sent to this group.<br>=
View/Reply Online (#12951):<span>=C2=A0</span><a href=3D"https://lists.open=
embedded.org/g/bitbake-devel/message/12951" rel=3D"noreferrer" target=3D"_b=
lank">https://lists.openembedded.org/g/bitbake-devel/message/12951</a><br>M=
ute This Topic:<span>=C2=A0</span><a href=3D"https://lists.openembedded.org=
/mt/86911583/1686489" rel=3D"noreferrer" target=3D"_blank">https://lists.op=
enembedded.org/mt/86911583/1686489</a><br>Group Owner:<span>=C2=A0</span><a=
 href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org" target=3D"_bl=
ank">bitbake-devel+owner@lists.openembedded.org</a><br>Unsubscribe:<span>=
=C2=A0</span><a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a><span>=C2=A0</span>[<a href=3D"mailto:alex.kanavin@gma=
il.com" target=3D"_blank">alex.kanavin@gmail.com</a>]<br>-=3D-=3D-=3D-=3D-=
=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br><br></blockquote></div></blockquote></div><=
/blockquote></div></div></blockquote></div><br><br></div><br><div class=3D"=
gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Am Di., 9. Nov. 2021 um =
09:19=C2=A0Uhr schrieb Alexander Kanavin &lt;<a href=3D"mailto:alex.kanavin=
@gmail.com" target=3D"_blank">alex.kanavin@gmail.com</a>&gt;:<br></div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div>I think=
 you misunderstood me too. It&#39;s about the github UI which does its best=
 to hide the commit messages, and doesn&#39;t allow to comment on their con=
tent. Yes you can contort yourself and still do it, but the tools do not he=
lp.</div><div><br></div><div>Alex<br></div></div><br><div class=3D"gmail_qu=
ote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, 9 Nov 2021 at 09:05, Mar=
ius Kriegerowski &lt;<a href=3D"mailto:marius.kriegerowski@gmail.com" targe=
t=3D"_blank">marius.kriegerowski@gmail.com</a>&gt; wrote:<br></div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div style=3D"co=
lor:rgb(0,0,0);font-family:Helvetica;font-size:12px;font-style:normal;font-=
variant-caps:normal;font-weight:normal;letter-spacing:normal;text-align:sta=
rt;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;=
text-decoration:none">Good morning,</div><div style=3D"color:rgb(0,0,0);fon=
t-family:Helvetica;font-size:12px;font-style:normal;font-variant-caps:norma=
l;font-weight:normal;letter-spacing:normal;text-align:start;text-indent:0px=
;text-transform:none;white-space:normal;word-spacing:0px;text-decoration:no=
ne"><br></div><div style=3D"color:rgb(0,0,0);font-family:Helvetica;font-siz=
e:12px;font-style:normal;font-variant-caps:normal;font-weight:normal;letter=
-spacing:normal;text-align:start;text-indent:0px;text-transform:none;white-=
space:normal;word-spacing:0px;text-decoration:none">I don=E2=80=99t think t=
his is correct. You can change the git history and commit messages of every=
 MR to whatever you like with `git commit =E2=80=94amend`, `git rebase -I` =
and `git push -f`. So, you can very well ask contributors to cleanup their =
history before merging.</div><div style=3D"color:rgb(0,0,0);font-family:Hel=
vetica;font-size:12px;font-style:normal;font-variant-caps:normal;font-weigh=
t:normal;letter-spacing:normal;text-align:start;text-indent:0px;text-transf=
orm:none;white-space:normal;word-spacing:0px;text-decoration:none"><br></di=
v><div style=3D"color:rgb(0,0,0);font-family:Helvetica;font-size:12px;font-=
style:normal;font-variant-caps:normal;font-weight:normal;letter-spacing:nor=
mal;text-align:start;text-indent:0px;text-transform:none;white-space:normal=
;word-spacing:0px;text-decoration:none">Best</div><div style=3D"color:rgb(0=
,0,0);font-family:Helvetica;font-size:12px;font-style:normal;font-variant-c=
aps:normal;font-weight:normal;letter-spacing:normal;text-align:start;text-i=
ndent:0px;text-transform:none;white-space:normal;word-spacing:0px;text-deco=
ration:none">Marius</div></div><br><div class=3D"gmail_quote"><div dir=3D"l=
tr" class=3D"gmail_attr">Am Di., 9. Nov. 2021 um 07:47=C2=A0Uhr schrieb Ale=
xander Kanavin &lt;<a href=3D"mailto:alex.kanavin@gmail.com" target=3D"_bla=
nk">alex.kanavin@gmail.com</a>&gt;:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex"><div dir=3D"ltr"><div>There&#39;s another problem with =
github/gitlab which I find significant. These tools do not allow reviewing =
commit messages, and don&#39;t even make it easy to see them. So the develo=
pers using those tools, both submitters and maintainers, are effectively be=
ing conditioned by the tools to see good commit messages as superfluous and=
 unnecessary. And so you more often than not end up with poorly written com=
mit history in github projects, or, if you&#39;re a reviewer, have to repea=
tedly explain to the submitter how to explain and structure their changes p=
roperly.</div><div><br></div><div>I&#39;d rather not have a change, than ha=
ve a change that no one, even the original author, can understand or rememb=
er the reasons for one year down the line.</div><div><br></div><div>Alex<br=
></div><br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"g=
mail_attr">On Tue, 9 Nov 2021 at 00:30, Richard Purdie &lt;<a href=3D"mailt=
o:richard.purdie@linuxfoundation.org" target=3D"_blank">richard.purdie@linu=
xfoundation.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">On Mon, 2021-11-08 at 23:44 +0100, Marius Kriegerowski wrote=
:<br>
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
</blockquote></div></div>

--000000000000313ab005d0571db9--

