Return-Path: <liu.ming50@gmail.com>
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
	[209.85.221.65])
	by mail.openembedded.org (Postfix) with ESMTP id 017CA7C062
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 27 Jan 2019 11:47:23 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id t6so14783660wrr.12
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 27 Jan 2019 03:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=19YOXmZC9XWOCgls1cI2wPkbFiwsCNP1zqtziaAKHUg=;
	b=WvaL4uamt+ygk7wJlNN7CAJw6GiMMKIPVfPWJi7eIhNa9KYOrdhUo1DIi0WAvDSvm3
	/4vvdNsXDEKLIqY2GquEyjdoXfdP6jwxBKVfkhj4oO76Gorto5JGCotzEZkTv/OVzXLB
	LZS8G8ipKJXQ07ld88F/BNQYswqi+s0tUc/FcHpzhneRiHHlJJ5KDstTEbuhAh5eeD2J
	JwgnreTTRL6dep+vVF3UGuQRhCZaD2fQQVWf6kiISiQHaJCR2ZVrp361tdTgtryxrSwp
	MNZurtpF8EXGkHPS/zfzwFNxhEZWsifmPbFGbipz90VtVMj87EBqkYMESAHoxlv0XVfy
	3D2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=19YOXmZC9XWOCgls1cI2wPkbFiwsCNP1zqtziaAKHUg=;
	b=YtJRsKtX8ckVY4PukhkTKCgS0H/62LCDFwfvBVRZ0ThLcs3UKYtaJ5kRyrvURss5qV
	SghiWdU+l4WVDR3al2B1dcaa2l01ayCdk8toho44QC/rV8ZteBu0C2NCzzZrTOIbSeIf
	VNL95WTHzRRVmQUMHCQhDp4lXqVxYhaLmsIXxWiB3NGx9zCDEmA5nz6sLEF4uP1cUg/o
	4qzKEV8jZIIbOHVPXUZcjQLwoXLT6tFrudWRjk2YYGIVcjI2dRh1cdjfc0qU38UFHr2a
	QbLlJXk3LPDBXvGfIziM/WkPRsdVANOcluAM87uKPmEKI2x8QCocXCv/gu22W7XVAOYv
	UJQA==
X-Gm-Message-State: AJcUukds1hlXYBDg4aA7dLqFLG1OK3EzqgIXs3PXIOjCdvlDYNr3hqXz
	QbKZQQCJOePpMLhm+ke9KI8+r8bHwUIwhBxcATU=
X-Google-Smtp-Source: ALg8bN78MSedyp0t6k538FSV7gIiMX5OPm5B4kWpdufRz9a2gRqDJG1sp9Es1I9SFQ4rWpNR7ZRN8hM79z95p2Q0T60=
X-Received: by 2002:a5d:60cc:: with SMTP id x12mr17366156wrt.193.1548589644463;
	Sun, 27 Jan 2019 03:47:24 -0800 (PST)
MIME-Version: 1.0
References: <1548427287-11934-1-git-send-email-liu.ming50@gmail.com>
	<238483ee79cc017f2b6603d562c26cb18036a037.camel@linuxfoundation.org>
	<7d80c538faadfdc9d2259bc37956835b@agner.ch>
	<fc0c4b8d-13a9-ad32-a017-27feb97fb8bd@windriver.com>
	<832b2810-7e11-fa18-b50e-b40b07c6e265@windriver.com>
	<3ea9bbe919c928366d71417e1cb8b73f@agner.ch>
	<CAG+wK9nzO3WQfPTbf_8we_2xEm0JfevbrKM-E-Zov6qSz-sgrA@mail.gmail.com>
	<a20f847aaf0c90f4659147bf5f2e2bbe3e74bf40.camel@linuxfoundation.org>
	<4fe3bea47ebbb8977f87a6031d332e43@agner.ch>
	<8a6a4a1f-4de6-22f1-c678-9d67481a2416@windriver.com>
In-Reply-To: <8a6a4a1f-4de6-22f1-c678-9d67481a2416@windriver.com>
From: Ming Liu <liu.ming50@gmail.com>
Date: Sun, 27 Jan 2019 12:47:13 +0100
Message-ID: <CALatG=4kL++WRt=_hnMJVMGrX24L9tmNsVf8SBDBK_H+8mviTw@mail.gmail.com>
To: Mark Hatle <mark.hatle@windriver.com>
Cc: Patrick Vacek <patrickvacek@gmail.com>,
	Stefan Agner <stefan.agner@toradex.com>, Luka Pivk <luka.pivk@toradex.com>,
	bitbake-devel@lists.openembedded.org
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
X-List-Received-Date: Sun, 27 Jan 2019 11:47:24 -0000
Content-Type: multipart/alternative; boundary="000000000000a942e305806f1fcf"

--000000000000a942e305806f1fcf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Mark:

I have done a quick test, seems the problem fixed with this patch, the
steps are as follows:
```
bitbake aktualizr -c cleanall
bitbake aktualizr
```
build succeeded.

the best,
thank you


Mark Hatle <mark.hatle@windriver.com> =E6=96=BC 2019=E5=B9=B41=E6=9C=8827=
=E6=97=A5 =E9=80=B1=E6=97=A5 =E4=B8=8A=E5=8D=882:19=E5=AF=AB=E9=81=93=EF=BC=
=9A

> On 1/26/19 7:50 AM, Stefan Agner wrote:
> > On 26.01.2019 14:35, Richard Purdie wrote:
> >> On Sat, 2019-01-26 at 13:07 +0100, Patrick Vacek wrote:
> >>> On Sat, Jan 26, 2019 at 11:15 AM Stefan Agner <stefan@agner.ch>
> >>> wrote:
> >>>>> So it seems to be that something in the recipe was expecting
> >>>> semi-broken
> >>>>> behavior.. and its actually a recipe problem.
> >>>>
> >>>> Agreed, in this case we need to fix the recipe.
> >>>
> >>> Sorry, I must be missing something. What might be wrong with the
> >>> recipe? Is there more that needs to be specified than a SRCREV and a
> >>> branch? As far as I understand git, it keeps track of the submodules,
> >>> so I don't know what other information there would be to provide. The
> >>> reason this particular case is difficult is because there are
> >>> recursive submodules. When we build aktualizr, we have to be careful
> >>> to specify that. See
> >>> https://github.com/advancedtelematic/aktualizr#building:
> >>>
> >>> git submodule update --init --recursive
> >>
> >> The problem is the checkout from the old version of the fetcher was
> >> broken, it incorrectly checked out that SRCREV. The recipe was written
> >> to build that broken checkout.
> >>
> >> We've fixed the fetcher and Mark is saying that it now checks out the
> >> correct thing (as compared with a git checkout outside of the build
> >> system, independent of the fetcher).
> >>
> >> The recipe assumed the old broken code so now fails to build. The
> >> recipe therefore needs to change to adapt to the now correct source
> >> code.
> >
> > I was not able to reproduce Marks findings.
> >
> > In particular:
> >
> >> For instance, the submodule partial/extern/isotp-c:
> >>
> >> In the current version is checked out on
> >> 4c5904bff3ed83ec471c8586b5faed62898d0224.  (Which matches the manual
> git behavior.)
> >>
> >> While the gitsm fetcher in the older system checkedout commit
> >> 614fe48fe55aeea98b49804b7e31ef2d304f62de.  Which is incorrect.
> >
> > That wasn't the case for me, the old code checked out 4c5904bf just
> > fine.
> >
> > However, I think Ming Liu's recent findings point out the culprit.
> >
> > The submodule isotp-c requires a submodule on its own, and the new code
> > seems not to unpack that.
>
> i see what you are saying, but for some reason the version of git on my
> machine
> (using the steps I mentioned in the original email) for some reason did
> not pull
> down the recursive git submodule, which would explain why my diff didn't
> find
> it.  (It's pretty clear to me that even within git itself, some submodule
> operations have been broken in various versions in the past.. my guess is
> that
> I'm hitting one of those errant behaviors locally.)
>
> If I manually go to the isotp-c directory and run git init ; git submodul=
e
> update it -then- downloads it.  (So apparently the --recursive argument
> isn't in
> some versions.  My system has 1.8.3.1 on it BTW.)
>
> Looking at this quickly, I suspect I know what the problem is:
>
>         if not ud.bareclone and self.process_submodules(ud, ud.destdir,
> unpack_submodules, d):
>
> if ud.bareclone is set, then python will optimize and not even run the
> process_submodules which is what does the unpack.  This is set for
> recursive
> submodule parsing.
>
> I'm getting ready to board a plane in a few hours.  So it'll be a day or =
so
> before I can get back to this.  I think I have a fix, see:
>
>
> http://git.openembedded.org/bitbake-contrib/commit/?h=3Dmgh/gitsm&id=3Dce=
5bb0056e6c510855811a26afb95073daf90f2a
>
> If you see this and can test it... I can formally send it for review if
> it's
> resolved the issues when I get to my destination.
>
> --Mark
>

--000000000000a942e305806f1fcf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi, Mark:<div><br></div><div>I have done =
a quick test, seems the problem fixed with this patch, the steps are as fol=
lows:</div><div>```</div><div>bitbake=C2=A0aktualizr -c cleanall</div><div>=
bitbake=C2=A0aktualizr<br></div><div>```</div><div>build succeeded.</div><d=
iv><br></div><div>the best,</div><div>thank you</div><div><br></div></div><=
/div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">M=
ark Hatle &lt;<a href=3D"mailto:mark.hatle@windriver.com">mark.hatle@windri=
ver.com</a>&gt; =E6=96=BC 2019=E5=B9=B41=E6=9C=8827=E6=97=A5 =E9=80=B1=E6=
=97=A5 =E4=B8=8A=E5=8D=882:19=E5=AF=AB=E9=81=93=EF=BC=9A<br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">On 1/26/19 7:50 AM, Stefan Agner w=
rote:<br>
&gt; On 26.01.2019 14:35, Richard Purdie wrote:<br>
&gt;&gt; On Sat, 2019-01-26 at 13:07 +0100, Patrick Vacek wrote:<br>
&gt;&gt;&gt; On Sat, Jan 26, 2019 at 11:15 AM Stefan Agner &lt;<a href=3D"m=
ailto:stefan@agner.ch" target=3D"_blank">stefan@agner.ch</a>&gt;<br>
&gt;&gt;&gt; wrote:<br>
&gt;&gt;&gt;&gt;&gt; So it seems to be that something in the recipe was exp=
ecting<br>
&gt;&gt;&gt;&gt; semi-broken<br>
&gt;&gt;&gt;&gt;&gt; behavior.. and its actually a recipe problem.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Agreed, in this case we need to fix the recipe.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Sorry, I must be missing something. What might be wrong with t=
he<br>
&gt;&gt;&gt; recipe? Is there more that needs to be specified than a SRCREV=
 and a<br>
&gt;&gt;&gt; branch? As far as I understand git, it keeps track of the subm=
odules,<br>
&gt;&gt;&gt; so I don&#39;t know what other information there would be to p=
rovide. The<br>
&gt;&gt;&gt; reason this particular case is difficult is because there are<=
br>
&gt;&gt;&gt; recursive submodules. When we build aktualizr, we have to be c=
areful<br>
&gt;&gt;&gt; to specify that. See<br>
&gt;&gt;&gt; <a href=3D"https://github.com/advancedtelematic/aktualizr#buil=
ding" rel=3D"noreferrer" target=3D"_blank">https://github.com/advancedtelem=
atic/aktualizr#building</a>:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; git submodule update --init --recursive<br>
&gt;&gt;<br>
&gt;&gt; The problem is the checkout from the old version of the fetcher wa=
s<br>
&gt;&gt; broken, it incorrectly checked out that SRCREV. The recipe was wri=
tten<br>
&gt;&gt; to build that broken checkout.<br>
&gt;&gt;<br>
&gt;&gt; We&#39;ve fixed the fetcher and Mark is saying that it now checks =
out the<br>
&gt;&gt; correct thing (as compared with a git checkout outside of the buil=
d<br>
&gt;&gt; system, independent of the fetcher).<br>
&gt;&gt;<br>
&gt;&gt; The recipe assumed the old broken code so now fails to build. The<=
br>
&gt;&gt; recipe therefore needs to change to adapt to the now correct sourc=
e<br>
&gt;&gt; code.<br>
&gt; <br>
&gt; I was not able to reproduce Marks findings.<br>
&gt; <br>
&gt; In particular:<br>
&gt; <br>
&gt;&gt; For instance, the submodule partial/extern/isotp-c:<br>
&gt;&gt;<br>
&gt;&gt; In the current version is checked out on<br>
&gt;&gt; 4c5904bff3ed83ec471c8586b5faed62898d0224.=C2=A0 (Which matches the=
 manual git behavior.)<br>
&gt;&gt;<br>
&gt;&gt; While the gitsm fetcher in the older system checkedout commit<br>
&gt;&gt; 614fe48fe55aeea98b49804b7e31ef2d304f62de.=C2=A0 Which is incorrect=
.<br>
&gt; <br>
&gt; That wasn&#39;t the case for me, the old code checked out 4c5904bf jus=
t<br>
&gt; fine.<br>
&gt; <br>
&gt; However, I think Ming Liu&#39;s recent findings point out the culprit.=
<br>
&gt; <br>
&gt; The submodule isotp-c requires a submodule on its own, and the new cod=
e<br>
&gt; seems not to unpack that.<br>
<br>
i see what you are saying, but for some reason the version of git on my mac=
hine<br>
(using the steps I mentioned in the original email) for some reason did not=
 pull<br>
down the recursive git submodule, which would explain why my diff didn&#39;=
t find<br>
it.=C2=A0 (It&#39;s pretty clear to me that even within git itself, some su=
bmodule<br>
operations have been broken in various versions in the past.. my guess is t=
hat<br>
I&#39;m hitting one of those errant behaviors locally.)<br>
<br>
If I manually go to the isotp-c directory and run git init ; git submodule<=
br>
update it -then- downloads it.=C2=A0 (So apparently the --recursive argumen=
t isn&#39;t in<br>
some versions.=C2=A0 My system has 1.8.3.1 on it BTW.)<br>
<br>
Looking at this quickly, I suspect I know what the problem is:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if not ud.bareclone and self.process_submodules=
(ud, ud.destdir,<br>
unpack_submodules, d):<br>
<br>
if ud.bareclone is set, then python will optimize and not even run the<br>
process_submodules which is what does the unpack.=C2=A0 This is set for rec=
ursive<br>
submodule parsing.<br>
<br>
I&#39;m getting ready to board a plane in a few hours.=C2=A0 So it&#39;ll b=
e a day or so<br>
before I can get back to this.=C2=A0 I think I have a fix, see:<br>
<br>
<a href=3D"http://git.openembedded.org/bitbake-contrib/commit/?h=3Dmgh/gits=
m&amp;id=3Dce5bb0056e6c510855811a26afb95073daf90f2a" rel=3D"noreferrer" tar=
get=3D"_blank">http://git.openembedded.org/bitbake-contrib/commit/?h=3Dmgh/=
gitsm&amp;id=3Dce5bb0056e6c510855811a26afb95073daf90f2a</a><br>
<br>
If you see this and can test it... I can formally send it for review if it&=
#39;s<br>
resolved the issues when I get to my destination.<br>
<br>
--Mark<br>
</blockquote></div>

--000000000000a942e305806f1fcf--
