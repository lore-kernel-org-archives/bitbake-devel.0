Return-Path: <liu.ming50@gmail.com>
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
	[209.85.128.66])
	by mail.openembedded.org (Postfix) with ESMTP id EBE567BF9E
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 25 Jan 2019 11:35:48 +0000 (UTC)
Received: by mail-wm1-f66.google.com with SMTP id y8so6289351wmi.4
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 25 Jan 2019 03:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=L6ILRhzF6rY4xlPlIzSi8irQjdN/miJ1mJ4Jd/6GNso=;
	b=oT95TzZL79oBlxNMS1PjGjLRyDlRJOzi+i/cFAp0Suvi1Os4gBI0JRGOU543lBP7dg
	Di+2Uf4w6tn1NMka0nI7ILPkuZR7s6BH2tWcaR9zCHPiRaGJIm+8i+eRh1XxIe1+loF3
	oGrHykgW/SKhigJbKQrNQEc817Dg1KFGk4YbSPjkSGd4W4gSFyRIV1gd4PBSl69FGNDP
	2u/UqhA+cj3JpRqYvRzA98l0kD2ztxB83vIH/5pRvz8FRlAchdJ51h+6F4QpMzTvCd18
	p6Y2VJD7Vddht17HKdvH59GY7dIWRvFK3s28954L/ie3WiVlGDheUe8MOXfy0m8MxUX1
	1vgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=L6ILRhzF6rY4xlPlIzSi8irQjdN/miJ1mJ4Jd/6GNso=;
	b=C1NM1MX76/8VqDh5yoN7HhsV6/2zhHKvcMn7Xu8Ycrq5/bmPeDmP0hPuDlimnV+fmn
	KiNBrNDrtOxeQo5pZgFzc0n2k/4HXCCt3MrCqAXo7rvz/vCyxEVPC5m7TYkTVHV0onR0
	y74aRPz6bg71uf/knxgctYvDX5X2UiohjTT00gzCPkoFraLfffimhzhTzNf/rIrnYkpY
	+Kk1pPHCe5QmmqMiydrdRCYkv5wCUTOwvJnF8AsZLV7ZzBfq+z38hvqOFyrHiNxCF+Oj
	71OztKxy74tYztRSVX7m/kxoF8BofZZZKYSGkKeQYEAIKozvm4j9ruYLhlXzRipoDL2j
	xvcw==
X-Gm-Message-State: AJcUukdW0T7a8x5XhtJKmRTWjnscR1QINzmdnNXbDkW1cj70b4qXgCwv
	Phk4xPQgrxKt4RoeY3g0VdDJNG3vDfjarR74zRA=
X-Google-Smtp-Source: ALg8bN52rjEejxW6UcOUtfdy0iTXcSJhMNqzVG1+6LaPi20FzHjZL/7W7hvNHr62DV/GyQ82J3wD00tTuKhVFc8yQ4Y=
X-Received: by 2002:a1c:e1d5:: with SMTP id y204mr6526371wmg.65.1548416149393; 
	Fri, 25 Jan 2019 03:35:49 -0800 (PST)
MIME-Version: 1.0
References: <1548413847-32550-1-git-send-email-liu.ming50@gmail.com>
	<18561a9b63079e5dc2d4b4a8b6b12728475b0402.camel@linuxfoundation.org>
In-Reply-To: <18561a9b63079e5dc2d4b4a8b6b12728475b0402.camel@linuxfoundation.org>
From: Ming Liu <liu.ming50@gmail.com>
Date: Fri, 25 Jan 2019 12:35:38 +0100
Message-ID: <CALatG=7YgmkROJpk_6pfZFKGP3=RjoJC_mh3gRsKMF+e=6=aqA@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org,
	Stefan Agner <stefan.agner@toradex.com>, Luka Pivk <luka.pivk@toradex.com>
Subject: Re: [PATCH] fetch2/gitsm: fix config file concurrent update race
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
X-List-Received-Date: Fri, 25 Jan 2019 11:35:49 -0000
Content-Type: multipart/alternative; boundary="0000000000008c9bd9058046ba56"

--0000000000008c9bd9058046ba56
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Stefan:

Could you help confirm this?

Hi, Richard:

May I know how has the issue been fixed?

I updated the tip to:
```
commit 8c8ecec2a722bc2885e2648d41ac8df07bdf660d
    gitsmy.py: Fix unpack of submodules of submodules

    If the submodule is in a subdirectory, it needs to have that structure
    preserved.  This means the unpack path needs to be in the 'dirname' of
the
    final path -- since the unpack directory name is specified in the URI.

    Additional specific test cases were added to ensure this is working
properly
    based on two recent error reports.

    Signed-off-by: Mark Hatle <mark.hatle@windriver.com>
    Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
```
on top of that commit, I could see there are "git config submodule" being
called concurrently in different processes, which does have a race
condition, and will lead to the error observed by Stefan, although it's not
easy to be reproduced.

//Ming Liu



Richard Purdie <richard.purdie@linuxfoundation.org> =E6=96=BC 2019=E5=B9=B4=
1=E6=9C=8825=E6=97=A5 =E9=80=B1=E4=BA=94
=E4=B8=8B=E5=8D=8812:18=E5=AF=AB=E9=81=93=EF=BC=9A

> On Fri, 2019-01-25 at 11:57 +0100, liu.ming50@gmail.com wrote:
> > From: Ming Liu <liu.ming50@gmail.com>
> >
> > A following issue was observed with gitsm:
> > > git -c core.fsyncobjectfiles=3D0 config submodule... failed with exit
> code 255, output:
> > > error: could not lock config file config: File exists
> >
> > Since all git submodules share a config file and Git creates a lock
> > file (.git/config.lock) to synchronize access to it, but Git only tries
> > exactly once and returns a error if it's already locked. This leads to
> > a race condition if there are many 'git config submodule' run in
> > different processes.
> >
> > It could be fixed by introducing a bitbake file lock to protect config
> > file from concurrent update from submodules.
> >
> > Reported-by: Stefan Agner <stefan.agner@toradex.com>
> > Signed-off-by: Ming Liu <liu.ming50@gmail.com>
> > ---
> >  lib/bb/fetch2/gitsm.py | 19 +++++++++++++++----
> >  1 file changed, 15 insertions(+), 4 deletions(-)
>
> This issue should already have been fixed with recent changes to the
> gitsm fetcher. Could you confirm which version of the code you were
> seeing this problem with?
>
> Cheers,
>
> Richard
>
>

--0000000000008c9bd9058046ba56
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr">Hi, Stefan:<div><br></di=
v><div>Could you help confirm this?=C2=A0</div><div><br></div><div>Hi, Rich=
ard:</div><div><br></div><div>May I know how has the issue been fixed?</div=
><div><br></div><div>I updated the tip to:</div><div>```</div><div>commit 8=
c8ecec2a722bc2885e2648d41ac8df07bdf660d<br></div><div><div>=C2=A0 =C2=A0 gi=
tsmy.py: Fix unpack of submodules of submodules</div><div>=C2=A0 =C2=A0=C2=
=A0</div><div>=C2=A0 =C2=A0 If the submodule is in a subdirectory, it needs=
 to have that structure</div><div>=C2=A0 =C2=A0 preserved.=C2=A0 This means=
 the unpack path needs to be in the &#39;dirname&#39; of the</div><div>=C2=
=A0 =C2=A0 final path -- since the unpack directory name is specified in th=
e URI.</div><div>=C2=A0 =C2=A0=C2=A0</div><div>=C2=A0 =C2=A0 Additional spe=
cific test cases were added to ensure this is working properly</div><div>=
=C2=A0 =C2=A0 based on two recent error reports.</div><div>=C2=A0 =C2=A0=C2=
=A0</div><div>=C2=A0 =C2=A0 Signed-off-by: Mark Hatle &lt;<a href=3D"mailto=
:mark.hatle@windriver.com">mark.hatle@windriver.com</a>&gt;</div><div>=C2=
=A0 =C2=A0 Signed-off-by: Richard Purdie &lt;<a href=3D"mailto:richard.purd=
ie@linuxfoundation.org">richard.purdie@linuxfoundation.org</a>&gt;</div></d=
iv><div>```</div><div>on top of that commit, I could see there are &quot;gi=
t config submodule&quot; being called concurrently in different processes, =
which does have a race condition, and will lead to the error observed by St=
efan, although it&#39;s not easy to be reproduced.</div><div><br></div><div=
>//Ming Liu</div><div><br></div><div><br></div></div></div></div><br><div c=
lass=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Richard Purdie &=
lt;<a href=3D"mailto:richard.purdie@linuxfoundation.org">richard.purdie@lin=
uxfoundation.org</a>&gt; =E6=96=BC 2019=E5=B9=B41=E6=9C=8825=E6=97=A5 =E9=
=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=8812:18=E5=AF=AB=E9=81=93=EF=BC=9A<br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">On Fri, 2019-01-25 at 11=
:57 +0100, <a href=3D"mailto:liu.ming50@gmail.com" target=3D"_blank">liu.mi=
ng50@gmail.com</a> wrote:<br>
&gt; From: Ming Liu &lt;<a href=3D"mailto:liu.ming50@gmail.com" target=3D"_=
blank">liu.ming50@gmail.com</a>&gt;<br>
&gt; <br>
&gt; A following issue was observed with gitsm:<br>
&gt; &gt; git -c core.fsyncobjectfiles=3D0 config submodule... failed with =
exit code 255, output:<br>
&gt; &gt; error: could not lock config file config: File exists<br>
&gt; <br>
&gt; Since all git submodules share a config file and Git creates a lock<br=
>
&gt; file (.git/config.lock) to synchronize access to it, but Git only trie=
s<br>
&gt; exactly once and returns a error if it&#39;s already locked. This lead=
s to<br>
&gt; a race condition if there are many &#39;git config submodule&#39; run =
in<br>
&gt; different processes.<br>
&gt; <br>
&gt; It could be fixed by introducing a bitbake file lock to protect config=
<br>
&gt; file from concurrent update from submodules.<br>
&gt; <br>
&gt; Reported-by: Stefan Agner &lt;<a href=3D"mailto:stefan.agner@toradex.c=
om" target=3D"_blank">stefan.agner@toradex.com</a>&gt;<br>
&gt; Signed-off-by: Ming Liu &lt;<a href=3D"mailto:liu.ming50@gmail.com" ta=
rget=3D"_blank">liu.ming50@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 lib/bb/fetch2/gitsm.py | 19 +++++++++++++++----<br>
&gt;=C2=A0 1 file changed, 15 insertions(+), 4 deletions(-)<br>
<br>
This issue should already have been fixed with recent changes to the<br>
gitsm fetcher. Could you confirm which version of the code you were<br>
seeing this problem with?<br>
<br>
Cheers,<br>
<br>
Richard<br>
<br>
</blockquote></div>

--0000000000008c9bd9058046ba56--
