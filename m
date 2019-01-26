Return-Path: <liu.ming50@gmail.com>
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
	[209.85.221.68])
	by mail.openembedded.org (Postfix) with ESMTP id 4C9AD7C3E8
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 26 Jan 2019 11:28:17 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id t27so12859698wra.6
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 26 Jan 2019 03:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=BOJJe3kdCjXil8U4wCY2lmOzwc7/wnd62AO+2GXdcIs=;
	b=IaQn/pHVsqopNu+wbmfrMYmyLA5rTxcemagGmhzIIQnNLxPdv8zruZY6dWbXRNj9mb
	T1UUQedSxkbJnJ70V0BKlziTgA7ikd/BEhwOCTuJ2lFArocZwQfWVst/Okgda6Or4p2R
	sZLqn4IdhdYgMTyfu7iAKUx56H7M8hBJC7YGFu7+P19taEgDqlCtlKwrOvUWGrH6beKb
	y8ELhem+tmCIlYZmXtRw9KuGymWPZ51FHRCHNQKJx7keFpHrIFtrdHVCqUQqdust8Qn8
	4qg9kCoqIrVPM1Q0dOmwoXjJ7yfZ65d5pcaw4TDc2r1ltKEjlOZtkznjYeO1QPTZoIWt
	L7UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=BOJJe3kdCjXil8U4wCY2lmOzwc7/wnd62AO+2GXdcIs=;
	b=DhBtzAr1HpIgtDWG5cjPcq4qzkvZ8sm8iyyCg+3cJPdSpQtjDtJzSG3EDjReYrAIVY
	6+I3SWwNaHFeBQ/1LznhVUn61+vksAfC+7YqGRrYHYQ/wH3enDRQbv/kXN/NZNqBKAuP
	u7yjntUOvWjMLEyENT35LjUsr4PLbkc2hJKDfM6WJP6rvtEb1EOrC21jNxT2rJ1oh211
	M9nJC+9uEuY8L55gorX+uhl9qmauKEi7Sc2RBUQKbgbmuMGSrXe/GClJ9HDcah8kCGLP
	Px1fSAgrMPOR38mzla/VGIh7/VD6OVe54GDZNO5z/cZBBVoIpLZ2iHxItJgNv6zBBJ/0
	4o3Q==
X-Gm-Message-State: AJcUukeG0yMovRJVD2ZixrKut3ZTVH08Kcgf72rlYUfPRzcdXLnCh9aM
	pu0b03Ie56HSvxwwLL1Nz2Gh9agHOKSSN1jXb4k=
X-Google-Smtp-Source: ALg8bN6qPgN+ILVGOQ4lJlFFh3orM9A9YatBDQ98mneTEOHp50+bmW/vWuy90yWcpyAI5pG7Mat8OiYzb55cKvCGP2w=
X-Received: by 2002:a5d:60cc:: with SMTP id x12mr14278926wrt.193.1548502097501;
	Sat, 26 Jan 2019 03:28:17 -0800 (PST)
MIME-Version: 1.0
References: <1548427287-11934-1-git-send-email-liu.ming50@gmail.com>
	<238483ee79cc017f2b6603d562c26cb18036a037.camel@linuxfoundation.org>
	<7d80c538faadfdc9d2259bc37956835b@agner.ch>
	<fc0c4b8d-13a9-ad32-a017-27feb97fb8bd@windriver.com>
	<832b2810-7e11-fa18-b50e-b40b07c6e265@windriver.com>
	<3ea9bbe919c928366d71417e1cb8b73f@agner.ch>
In-Reply-To: <3ea9bbe919c928366d71417e1cb8b73f@agner.ch>
From: Ming Liu <liu.ming50@gmail.com>
Date: Sat, 26 Jan 2019 12:28:05 +0100
Message-ID: <CALatG=6zius8RgurcBk8+_RfYj0iH7UDM63XsevkvRUSH3OZsg@mail.gmail.com>
To: Stefan Agner <stefan@agner.ch>
Cc: patrickvacek@gmail.com, Stefan Agner <stefan.agner@toradex.com>,
	Luka Pivk <luka.pivk@toradex.com>, bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH V2] fetch2/gitsm: fix config file concurrent update race
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Sat, 26 Jan 2019 11:28:17 -0000
Content-Type: multipart/alternative; boundary="00000000000074a0d205805abdb4"

--00000000000074a0d205805abdb4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Mark:

Thanks for the explanation, my understanding was wrong, sorry the noise.

//Ming Liu

Stefan Agner <stefan@agner.ch> =E6=96=BC 2019=E5=B9=B41=E6=9C=8826=E6=97=A5=
 =E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=8811:15=E5=AF=AB=E9=81=93=EF=BC=9A

> [adding Patrick, he is often working on the recipe]
>
> On 26.01.2019 00:19, Mark Hatle wrote:
> > On 1/25/19 1:53 PM, Mark Hatle wrote:
> >> Is the repository you are using public?  If so, give me the URL and
> commit ID
> >> for the main repository and I'll get it added to the test suite.
> >
> > I reread this and went back into the prior info from you.  It appears t=
he
> > repository you are talking about is:
> >
> > gitsm://github.com/advancedtelematic/aktualizr;branch=3Dmaster
>
> Yes that is the repository.
>
> >
> > SRCREV =3D d00d1a04cc2366d1a5f143b84b9f507f8bd32c44
>
> And the hash I was using.
>
> >
> >
> > I manually checked this out doing the following:
> >
> > git clone git://github.com/advancedtelematic/aktualizr
> > git checkout d00d1a04cc2366d1a5f143b84b9f507f8bd32c44
> > git submodule init
> > git submodule update --recursive
> >
> >
> > I then ran the same thing using the gitsm fetcher.  Using:
> >
> >
> > gitsm://
> github.com/advancedtelematic/aktualizr;branch=3Dmaster;protocol=3Dgit;rev=
=3Dd00d1a04cc2366d1a5f143b84b9f507f8bd32c44
> >
> > Comparing the resulting system, they are nearly identical.  All of the
> checked
> > out sources are -exactly- the same.
> >
> > There are some minor differences in the .git directory, but none of the=
m
> affect
> > what is actually checked out.
> >
> > Output of:
> >
> >    diff -urN 'gitsm version' aktualizr -x .git
> >
> > is identical
> >
> > comparing the git directory is slightly different, but all within the
> > expectations.
> >
> > So I do not see anything that the gitsm fetcher is doing incorrectly
> > at this point.
> >
> > You should run the same type of comparison and see if you are getting
> the same
> > results.
> >
> >
> > BTW I went back to bitbake commit c1fcc46e2498, and repeated the
> experiment.
> >
> > This shows that a significant part of was checked out incorrectly.
> >
> > For instance, the submodule partial/extern/isotp-c:
> >
> > In the current version is checked out on
> > 4c5904bff3ed83ec471c8586b5faed62898d0224.  (Which matches the manual
> > git behavior.)
> >
> > While the gitsm fetcher in the older system checkedout commit
> > 614fe48fe55aeea98b49804b7e31ef2d304f62de.  Which is incorrect.
> >
>
> Yeah this would explain the behavior I am seeing.
>
> >
> > So it seems to be that something in the recipe was expecting semi-broke=
n
> > behavior.. and its actually a recipe problem.
>
> Agreed, in this case we need to fix the recipe.
>
> Thanks for looking into it and sorry for the noise!
>
> --
> Stefan
>
> >
> > --Mark
> >
> >> (For testing what I've been doing is checking out with raw git and the=
n
> with the
> >> gitsm fetcher.. comparing the difference and then adding those specifi=
c
> things
> >> as regressions checks.)
> >>
> >> If it's not public, then you'll likely need to do that yourself.
> Compare the
> >> results and try to figure out what the difference is.  Once you have
> that, it
> >> may be more obvious what the problems.  (Comparison should include the
> .git
> >> contents as well..)
> >>
> >> --Mark
> >>
> >> On 1/25/19 1:24 PM, Stefan Agner wrote:
> >>> On 25.01.2019 16:08, Richard Purdie wrote:
> >>>> On Fri, 2019-01-25 at 15:41 +0100, liu.ming50@gmail.com wrote:
> >>>>> From: Ming Liu <liu.ming50@gmail.com>
> >>>>>
> >>>>> A following issue was observed with gitsm:
> >>>>>> git -c core.fsyncobjectfiles=3D0 config submodule... failed with e=
xit
> code 255, output:
> >>>>>> error: could not lock config file config: File exists
> >>>>>
> >>>>> Since all git submodules share a config file and Git creates a lock
> >>>>> file (.git/config.lock) to synchronize access to it, but Git only
> tries
> >>>>> exactly once and returns a error if it's already locked. This leads
> to
> >>>>> a race condition if there are many 'git config submodule' run in
> >>>>> different processes.
> >>>>>
> >>>>> It could be fixed by introducing a bitbake file lock to protect
> config
> >>>>> file from concurrent update from submodules.
> >>>>>
> >>>>> Reported-by: Stefan Agner <stefan.agner@toradex.com>
> >>>>> Signed-off-by: Ming Liu <liu.ming50@gmail.com>
> >>>>> ---
> >>>>>  lib/bb/fetch2/gitsm.py | 16 ++++++++++++----
> >>>>>  1 file changed, 12 insertions(+), 4 deletions(-)
> >>>>>
> >>>>> diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
> >>>>> index f45546b..9465acb 100644
> >>>>> --- a/lib/bb/fetch2/gitsm.py
> >>>>> +++ b/lib/bb/fetch2/gitsm.py
> >>>>> @@ -183,11 +183,19 @@ class GitSM(Git):
> >>>>>
> >>>>>              local_path =3D newfetch.localpath(url)
> >>>>>
> >>>>> -            # Correct the submodule references to the local
> download version...
> >>>>> -            runfetchcmd("%(basecmd)s config
> submodule.%(module)s.url %(url)s" % {'basecmd': ud.basecmd, 'module':
> module, 'url' : local_path}, d, workdir=3Dud.destdir)
> >>>>> +            # Protects the config file from concurrent updates by
> submodules
> >>>>> +            # e.g. 'git config submodule' run in different
> processes may lead
> >>>>> +            # to a race condition.
> >>>>> +            lf =3D bb.utils.lockfile(os.path.join(ud.destdir,
> "gitsm-config.lock"))
> >>>>>
> >>>>> -            if ud.shallow:
> >>>>> -                runfetchcmd("%(basecmd)s config
> submodule.%(module)s.shallow true" % {'basecmd': ud.basecmd, 'module':
> module}, d, workdir=3Dud.destdir)
> >>>>> +            try:
> >>>>> +                # Correct the submodule references to the local
> download version...
> >>>>> +                runfetchcmd("%(basecmd)s config
> submodule.%(module)s.url %(url)s" % {'basecmd': ud.basecmd, 'module':
> module, 'url' : local_path}, d, workdir=3Dud.destdir)
> >>>>> +
> >>>>> +                if ud.shallow:
> >>>>> +                    runfetchcmd("%(basecmd)s config
> submodule.%(module)s.shallow true" % {'basecmd': ud.basecmd, 'module':
> module}, d, workdir=3Dud.destdir)
> >>>>> +            finally:
> >>>>> +                bb.utils.unlockfile(lf)
> >>>>>
> >>>>>              # Ensure the submodule repository is NOT set to bare,
> since we're checking it out...
> >>>>>              try:
> >>>>
> >>>> I still don't see why this is necessary after Mark's recent changes.
> >>>> These files are in ud.destdir which in OE terms is WORKDIR. Only one
> >>>> fetch happens against WORKDIR at a time? Therefore how is this racin=
g?
> >>>
> >>> The git config race we only observed before the recent changes by Mar=
k.
> >>>
> >>> If those changes have the potential to fix this issue, we should test
> >>> those first and hold on with this patch.
> >>>
> >>>>
> >>>> Have you seen this problem against the current master code?
> >>>
> >>> Master as of yesterday (or Wednesday) was not able to fetch the proje=
ct
> >>> (aktualizr).
> >>>
> >>> Even with the latest 2 fixes I am not able to build the (very same)
> >>> recipe anymore, it ends up in an error during do_configure, presumabl=
y
> >>> due to missing submodules:
> >>>
> >>>
> >>> | -- Configuring done
> >>> | CMake Error at partial/CMakeLists.txt:116 (add_library):
> >>> |   Cannot find source file:
> >>> |
> >>>
> >>> |     extern/isotp-c/deps/bitfield-c/src/bitfield/8byte.c
> >>>
> >>> |
> >>>
> >>> |   Tried extensions .c .C .c++ .cc .cpp .cxx .cu .m .M .mm .h .hh .h=
++
> >>> .hm
> >>> |   .hpp .hxx .in .txx
> >>> |
> >>> |
> >>> | CMake Error at partial/CMakeLists.txt:116 (add_library):
> >>> |   No SOURCES given to target: isotp
> >>> |
> >>>
> >>> Using c1fcc46e2498 ("bitbake: Fix Deprecated warnings from regexs")
> >>> works fine.
> >>>
> >>> --
> >>> Stefan
> >>>
> >>>
> >>
>

--00000000000074a0d205805abdb4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi, Mark:<div><br></div><div>Thanks for the explanation, m=
y understanding was wrong, sorry the noise.</div><div><br></div><div>//Ming=
 Liu</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gm=
ail_attr">Stefan Agner &lt;<a href=3D"mailto:stefan@agner.ch">stefan@agner.=
ch</a>&gt; =E6=96=BC 2019=E5=B9=B41=E6=9C=8826=E6=97=A5 =E9=80=B1=E5=85=AD =
=E4=B8=8A=E5=8D=8811:15=E5=AF=AB=E9=81=93=EF=BC=9A<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">[adding Patrick, he is often working on =
the recipe]<br>
<br>
On 26.01.2019 00:19, Mark Hatle wrote:<br>
&gt; On 1/25/19 1:53 PM, Mark Hatle wrote:<br>
&gt;&gt; Is the repository you are using public?=C2=A0 If so, give me the U=
RL and commit ID<br>
&gt;&gt; for the main repository and I&#39;ll get it added to the test suit=
e.<br>
&gt; <br>
&gt; I reread this and went back into the prior info from you.=C2=A0 It app=
ears the<br>
&gt; repository you are talking about is:<br>
&gt; <br>
&gt; gitsm://<a href=3D"http://github.com/advancedtelematic/aktualizr;branc=
h=3Dmaster" rel=3D"noreferrer" target=3D"_blank">github.com/advancedtelemat=
ic/aktualizr;branch=3Dmaster</a><br>
<br>
Yes that is the repository.<br>
<br>
&gt; <br>
&gt; SRCREV =3D d00d1a04cc2366d1a5f143b84b9f507f8bd32c44<br>
<br>
And the hash I was using.<br>
<br>
&gt; <br>
&gt; <br>
&gt; I manually checked this out doing the following:<br>
&gt; <br>
&gt; git clone git://<a href=3D"http://github.com/advancedtelematic/aktuali=
zr" rel=3D"noreferrer" target=3D"_blank">github.com/advancedtelematic/aktua=
lizr</a><br>
&gt; git checkout d00d1a04cc2366d1a5f143b84b9f507f8bd32c44<br>
&gt; git submodule init<br>
&gt; git submodule update --recursive<br>
&gt; <br>
&gt; <br>
&gt; I then ran the same thing using the gitsm fetcher.=C2=A0 Using:<br>
&gt; <br>
&gt; <br>
&gt; gitsm://<a href=3D"http://github.com/advancedtelematic/aktualizr;branc=
h=3Dmaster;protocol=3Dgit;rev=3Dd00d1a04cc2366d1a5f143b84b9f507f8bd32c44" r=
el=3D"noreferrer" target=3D"_blank">github.com/advancedtelematic/aktualizr;=
branch=3Dmaster;protocol=3Dgit;rev=3Dd00d1a04cc2366d1a5f143b84b9f507f8bd32c=
44</a><br>
&gt; <br>
&gt; Comparing the resulting system, they are nearly identical.=C2=A0 All o=
f the checked<br>
&gt; out sources are -exactly- the same.<br>
&gt; <br>
&gt; There are some minor differences in the .git directory, but none of th=
em affect<br>
&gt; what is actually checked out.<br>
&gt; <br>
&gt; Output of:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 diff -urN &#39;gitsm version&#39; aktualizr -x .git<br>
&gt; <br>
&gt; is identical<br>
&gt; <br>
&gt; comparing the git directory is slightly different, but all within the<=
br>
&gt; expectations.<br>
&gt; <br>
&gt; So I do not see anything that the gitsm fetcher is doing incorrectly<b=
r>
&gt; at this point.<br>
&gt; <br>
&gt; You should run the same type of comparison and see if you are getting =
the same<br>
&gt; results.<br>
&gt; <br>
&gt; <br>
&gt; BTW I went back to bitbake commit c1fcc46e2498, and repeated the exper=
iment.<br>
&gt; <br>
&gt; This shows that a significant part of was checked out incorrectly.<br>
&gt; <br>
&gt; For instance, the submodule partial/extern/isotp-c:<br>
&gt; <br>
&gt; In the current version is checked out on<br>
&gt; 4c5904bff3ed83ec471c8586b5faed62898d0224.=C2=A0 (Which matches the man=
ual<br>
&gt; git behavior.)<br>
&gt; <br>
&gt; While the gitsm fetcher in the older system checkedout commit<br>
&gt; 614fe48fe55aeea98b49804b7e31ef2d304f62de.=C2=A0 Which is incorrect.<br=
>
&gt; <br>
<br>
Yeah this would explain the behavior I am seeing.<br>
<br>
&gt; <br>
&gt; So it seems to be that something in the recipe was expecting semi-brok=
en<br>
&gt; behavior.. and its actually a recipe problem.<br>
<br>
Agreed, in this case we need to fix the recipe.<br>
<br>
Thanks for looking into it and sorry for the noise!<br>
<br>
--<br>
Stefan<br>
<br>
&gt; <br>
&gt; --Mark<br>
&gt; <br>
&gt;&gt; (For testing what I&#39;ve been doing is checking out with raw git=
 and then with the<br>
&gt;&gt; gitsm fetcher.. comparing the difference and then adding those spe=
cific things<br>
&gt;&gt; as regressions checks.)<br>
&gt;&gt;<br>
&gt;&gt; If it&#39;s not public, then you&#39;ll likely need to do that you=
rself.=C2=A0 Compare the<br>
&gt;&gt; results and try to figure out what the difference is.=C2=A0 Once y=
ou have that, it<br>
&gt;&gt; may be more obvious what the problems.=C2=A0 (Comparison should in=
clude the .git<br>
&gt;&gt; contents as well..)<br>
&gt;&gt;<br>
&gt;&gt; --Mark<br>
&gt;&gt;<br>
&gt;&gt; On 1/25/19 1:24 PM, Stefan Agner wrote:<br>
&gt;&gt;&gt; On 25.01.2019 16:08, Richard Purdie wrote:<br>
&gt;&gt;&gt;&gt; On Fri, 2019-01-25 at 15:41 +0100, <a href=3D"mailto:liu.m=
ing50@gmail.com" target=3D"_blank">liu.ming50@gmail.com</a> wrote:<br>
&gt;&gt;&gt;&gt;&gt; From: Ming Liu &lt;<a href=3D"mailto:liu.ming50@gmail.=
com" target=3D"_blank">liu.ming50@gmail.com</a>&gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; A following issue was observed with gitsm:<br>
&gt;&gt;&gt;&gt;&gt;&gt; git -c core.fsyncobjectfiles=3D0 config submodule.=
.. failed with exit code 255, output:<br>
&gt;&gt;&gt;&gt;&gt;&gt; error: could not lock config file config: File exi=
sts<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Since all git submodules share a config file and Git c=
reates a lock<br>
&gt;&gt;&gt;&gt;&gt; file (.git/config.lock) to synchronize access to it, b=
ut Git only tries<br>
&gt;&gt;&gt;&gt;&gt; exactly once and returns a error if it&#39;s already l=
ocked. This leads to<br>
&gt;&gt;&gt;&gt;&gt; a race condition if there are many &#39;git config sub=
module&#39; run in<br>
&gt;&gt;&gt;&gt;&gt; different processes.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; It could be fixed by introducing a bitbake file lock t=
o protect config<br>
&gt;&gt;&gt;&gt;&gt; file from concurrent update from submodules.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Reported-by: Stefan Agner &lt;<a href=3D"mailto:stefan=
.agner@toradex.com" target=3D"_blank">stefan.agner@toradex.com</a>&gt;<br>
&gt;&gt;&gt;&gt;&gt; Signed-off-by: Ming Liu &lt;<a href=3D"mailto:liu.ming=
50@gmail.com" target=3D"_blank">liu.ming50@gmail.com</a>&gt;<br>
&gt;&gt;&gt;&gt;&gt; ---<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 lib/bb/fetch2/gitsm.py | 16 ++++++++++++----<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 1 file changed, 12 insertions(+), 4 deletions(-)=
<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gi=
tsm.py<br>
&gt;&gt;&gt;&gt;&gt; index f45546b..9465acb 100644<br>
&gt;&gt;&gt;&gt;&gt; --- a/lib/bb/fetch2/gitsm.py<br>
&gt;&gt;&gt;&gt;&gt; +++ b/lib/bb/fetch2/gitsm.py<br>
&gt;&gt;&gt;&gt;&gt; @@ -183,11 +183,19 @@ class GitSM(Git):<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 local_=
path =3D newfetch.localpath(url)<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Correct t=
he submodule references to the local download version...<br>
&gt;&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 runfetchcmd=
(&quot;%(basecmd)s config submodule.%(module)s.url %(url)s&quot; % {&#39;ba=
secmd&#39;: ud.basecmd, &#39;module&#39;: module, &#39;url&#39; : local_pat=
h}, d, workdir=3Dud.destdir)<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Protects =
the config file from concurrent updates by submodules<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # e.g. &#39=
;git config submodule&#39; run in different processes may lead<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # to a race=
 condition.<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 lf =3D bb.u=
tils.lockfile(os.path.join(ud.destdir, &quot;gitsm-config.lock&quot;))<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ud.shall=
ow:<br>
&gt;&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 runfetchcmd(&quot;%(basecmd)s config submodule.%(module)s.shallow true&=
quot; % {&#39;basecmd&#39;: ud.basecmd, &#39;module&#39;: module}, d, workd=
ir=3Dud.destdir)<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 try:<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 # Correct the submodule references to the local download version...<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 runfetchcmd(&quot;%(basecmd)s config submodule.%(module)s.url %(url)s&q=
uot; % {&#39;basecmd&#39;: ud.basecmd, &#39;module&#39;: module, &#39;url&#=
39; : local_path}, d, workdir=3Dud.destdir)<br>
&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 if ud.shallow:<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 runfetchcmd(&quot;%(basecmd)s config submodule.%(module)s=
.shallow true&quot; % {&#39;basecmd&#39;: ud.basecmd, &#39;module&#39;: mod=
ule}, d, workdir=3Dud.destdir)<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 finally:<br=
>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 bb.utils.unlockfile(lf)<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Ensu=
re the submodule repository is NOT set to bare, since we&#39;re checking it=
 out...<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 try:<b=
r>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; I still don&#39;t see why this is necessary after Mark&#39=
;s recent changes.<br>
&gt;&gt;&gt;&gt; These files are in ud.destdir which in OE terms is WORKDIR=
. Only one<br>
&gt;&gt;&gt;&gt; fetch happens against WORKDIR at a time? Therefore how is =
this racing?<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; The git config race we only observed before the recent changes=
 by Mark.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; If those changes have the potential to fix this issue, we shou=
ld test<br>
&gt;&gt;&gt; those first and hold on with this patch.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Have you seen this problem against the current master code=
?<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Master as of yesterday (or Wednesday) was not able to fetch th=
e project<br>
&gt;&gt;&gt; (aktualizr).<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Even with the latest 2 fixes I am not able to build the (very =
same)<br>
&gt;&gt;&gt; recipe anymore, it ends up in an error during do_configure, pr=
esumably<br>
&gt;&gt;&gt; due to missing submodules:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; | -- Configuring done<br>
&gt;&gt;&gt; | CMake Error at partial/CMakeLists.txt:116 (add_library):<br>
&gt;&gt;&gt; |=C2=A0 =C2=A0Cannot find source file:<br>
&gt;&gt;&gt; |<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; |=C2=A0 =C2=A0 =C2=A0extern/isotp-c/deps/bitfield-c/src/bitfie=
ld/8byte.c<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; |<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; |=C2=A0 =C2=A0Tried extensions .c .C .c++ .cc .cpp .cxx .cu .m=
 .M .mm .h .hh .h++<br>
&gt;&gt;&gt; .hm<br>
&gt;&gt;&gt; |=C2=A0 =C2=A0.hpp .hxx .in .txx<br>
&gt;&gt;&gt; |<br>
&gt;&gt;&gt; |<br>
&gt;&gt;&gt; | CMake Error at partial/CMakeLists.txt:116 (add_library):<br>
&gt;&gt;&gt; |=C2=A0 =C2=A0No SOURCES given to target: isotp<br>
&gt;&gt;&gt; |<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Using c1fcc46e2498 (&quot;bitbake: Fix Deprecated warnings fro=
m regexs&quot;)<br>
&gt;&gt;&gt; works fine.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; --<br>
&gt;&gt;&gt; Stefan<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;<br>
</blockquote></div>

--00000000000074a0d205805abdb4--
