Return-Path: <matt.hoosier@gmail.com>
Received: from mail-yb0-f194.google.com (mail-yb0-f194.google.com
	[209.85.213.194])
	by mail.openembedded.org (Postfix) with ESMTP id 9E55C7875A
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 14 May 2018 18:52:30 +0000 (UTC)
Received: by mail-yb0-f194.google.com with SMTP id w14-v6so4487720ybm.5
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 14 May 2018 11:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=E0eIuCPvz/h7odGn8I3j2VDR7wYcB5Q7cD8oGxu0LWw=;
	b=RUI5ISKrEoc1tdmNOtEYlfH0F0Gjq3r3TYjDqpTShN+Bssu2nnmNe9rL4lftIuD1w9
	gkdKUwHhvQWlEdlOZv4bGSwar4/UbNPUAFWJlp9p5hYBAz1Li3kt0u9t3J6aYVCcKi1j
	JRUZtRZJenOQFcQ5HJsmVAhOFgPYKLHe0bQ5AfFNuw3mfQdKnXaKDo7+PZo+VHgCwF6H
	B4VipXQlEVtKAlD6Vx/7DyploYS226xd0dCJs0hR4OaJpp/osxwBYbXDt7ho1QsLKCAU
	g6ScY7YGRAZNpPUnDz9k2QPInuOspO1zY0jcx6dFDkAdvjjsqLbhfcS8vARnPobA6q1y
	5W0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=E0eIuCPvz/h7odGn8I3j2VDR7wYcB5Q7cD8oGxu0LWw=;
	b=f1A1TH4fSoTZ2JRz2Ao1mPjNrIkIX/H0l8PGE6ppEWyGcRE7l3XbzASQG3ANaWHVGC
	XFOlQMsnAwckbn7m9dwxmwZ3/ClzIK85ATvu3pLKQ+RzIecPCyBWA7B9Ul2iEdGB0o+C
	QODT04wBNl2lxjjrBNbs1gQKPjztwPDph6hgg2nYYLURdzl5XjGJ/qW1wS8ilYLq6A/l
	j7nsPy9i1QoJ1zyTuekE8seJNT9hZabcbCyc135vzYDFfTAvSg0103RILyMR4ky2iVoj
	LkNzctJ3u2w92twQ8Kq+niFHiMxV4E2/ERafJbEvdvZH8eKr6TDw5WKP1a0GQ9Sc3o9S
	Z21A==
X-Gm-Message-State: ALKqPweWW5DjVtsvJq4D9QWsVMnfzURk7Ff7PHmBf9Uiv4FQApXgVnIz
	g9MRK07UBOGOFXpbFzbCZjQPm+w4rhoyRqmJtYkMbA==
X-Google-Smtp-Source: AB8JxZp1U7YBCewZSaKoX9hB8wZTl9pSuqRdE1W+QS00EodNGDQwUstDajTdSt27+77Ghtn+8pi2RzoBRG/074tBHw8=
X-Received: by 2002:a25:b3cc:: with SMTP id
	x12-v6mr7350347ybf.181.1526323951368; 
	Mon, 14 May 2018 11:52:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:748c:0:0:0:0:0 with HTTP; Mon, 14 May 2018 11:51:51
	-0700 (PDT)
In-Reply-To: <0ed6e7841d4949a98e6978944adf8c8e@XBOX02.axis.com>
References: <20180511192636.6231-1-matt.hoosier@gmail.com>
	<0ed6e7841d4949a98e6978944adf8c8e@XBOX02.axis.com>
From: Matt Hoosier <matt.hoosier@gmail.com>
Date: Mon, 14 May 2018 13:51:51 -0500
Message-ID: <CAJgxT3_M+GiBThXAOQF0TVLb_2m7UvtgDJWVvJpoJ6QTAkH8wQ@mail.gmail.com>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] fetch/gitsm: avoid live submodule fetching during unpack()
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
X-List-Received-Date: Mon, 14 May 2018 18:52:30 -0000
Content-Type: multipart/alternative; boundary="000000000000ef01ed056c2efcf4"

--000000000000ef01ed056c2efcf4
Content-Type: text/plain; charset="UTF-8"

On Mon, May 14, 2018 at 8:18 AM, Peter Kjellerstedt <
peter.kjellerstedt@axis.com> wrote:

> > -----Original Message-----
> > From: bitbake-devel-bounces@lists.openembedded.org [mailto:bitbake-
> > devel-bounces@lists.openembedded.org] On Behalf Of Matt Hoosier
> > Sent: den 11 maj 2018 21:27
> > To: bitbake-devel@lists.openembedded.org
> > Subject: [bitbake-devel] [PATCH] fetch/gitsm: avoid live submodule
> > fetching during unpack()
> >
> > Although the submodules' histories have been fetched during the
> > do_fetch() phase, the mechanics used to clone the workdir copy
> > of the repo haven't been transferring the actual .git/modules
> > directory from the repo fetched into downloads/ during the
> > fetch task.
> >
> > Fix that, and for good measure also explicitly tell Git to avoid
> > hitting the network during do_unpack() of the submodules.
> >
> > Rev3 changes:
> >
> > - Really fix the shallow-clone issue claimed to be addressed in rev2.
> >
> > Rev2 changes:
> >
> > - Fixed a failure when unpacking a shallow cloned mirror repository.
>
> The Rev2 and Rev3 changes information should go below the --- below
> as it should not be part of the commit message as it relates to the
> patch submission process rather than the actual change. If any of it
> is relevant for the commit message, then the commit message should
> be changed as well.
>

Thanks; done. Resubmitted (as v4) to the list.


>
> > [YOCTO #12739]
> >
> > Signed-off-by: Matt Hoosier <matt.hoosier@gmail.com>
> > ---
> >  lib/bb/fetch2/gitsm.py | 28 +++++++++++++++++++++++++++-
> >  1 file changed, 27 insertions(+), 1 deletion(-)
> >
> > diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
> > index 0aff1008..3969f2f5 100644
> > --- a/lib/bb/fetch2/gitsm.py
> > +++ b/lib/bb/fetch2/gitsm.py
> > @@ -132,4 +132,30 @@ class GitSM(Git):
> >
> >          if self.uses_submodules(ud, d, ud.destdir):
> >              runfetchcmd(ud.basecmd + " checkout " +
> ud.revisions[ud.names[0]], d, workdir=ud.destdir)
> > -            runfetchcmd(ud.basecmd + " submodule update --init
> --recursive", d, workdir=ud.destdir)
> > +
> > +            updateflags = ""
> > +
> > +            # Copy over the submodules' fetched histories too.
> > +            if ud.bareclone:
> > +                repo_conf = ud.destdir
> > +            else:
> > +                repo_conf = os.path.join(ud.destdir, '.git')
> > +
> > +            if os.path.exists(ud.clonedir):
> > +                # This is not a copy unpacked from a shallow mirror
> clone. So
> > +                # the manual intervention to populate the .git/modules
> done
> > +                # in clone_shallow_local() won't have been done yet.
> > +                runfetchcmd("cp -pr %s %s" % (os.path.join(ud.clonedir,
> 'modules'), repo_conf), d)
> > +                updateflags += " --no-fetch"
> > +            elif os.path.exists(os.path.join(repo_conf, 'modules')):
> > +                # Unpacked from a shallow mirror clone. Manual
> population of
> > +                # .git/modules is already done.
> > +                updateflags += " --no-fetch"
> > +            else:
> > +                # This isn't fatal; git-submodule will just fetch it
> > +                # during do_unpack().
> > +                bb.error("submodule history not retrieved during
> do_fetch()")
> > +
> > +            # Careful not to hit the network during unpacking; all
> history should already
> > +            # be fetched.
> > +            runfetchcmd(ud.basecmd + " submodule update --init
> --recursive %s" % updateflags, d, workdir=ud.destdir)
> > --
> > 2.13.6
>
> //Peter
>
>

--000000000000ef01ed056c2efcf4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">On Mon, May 14, 2018 at 8:18 AM, Peter Kjellerstedt <span =
dir=3D"ltr">&lt;<a href=3D"mailto:peter.kjellerstedt@axis.com" target=3D"_b=
lank">peter.kjellerstedt@axis.com</a>&gt;</span> wrote:<br><div class=3D"gm=
ail_extra"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span =
class=3D"">&gt; -----Original Message-----<br>
&gt; From: <a href=3D"mailto:bitbake-devel-bounces@lists.openembedded.org">=
bitbake-devel-bounces@lists.<wbr>openembedded.org</a> [mailto:<a href=3D"ma=
ilto:bitbake-">bitbake-</a><br>
&gt; <a href=3D"mailto:devel-bounces@lists.openembedded.org">devel-bounces@=
lists.<wbr>openembedded.org</a>] On Behalf Of Matt Hoosier<br>
&gt; Sent: den 11 maj 2018 21:27<br>
&gt; To: <a href=3D"mailto:bitbake-devel@lists.openembedded.org">bitbake-de=
vel@lists.<wbr>openembedded.org</a><br>
&gt; Subject: [bitbake-devel] [PATCH] fetch/gitsm: avoid live submodule<br>
&gt; fetching during unpack()<br>
&gt; <br>
&gt; Although the submodules&#39; histories have been fetched during the<br=
>
&gt; do_fetch() phase, the mechanics used to clone the workdir copy<br>
&gt; of the repo haven&#39;t been transferring the actual .git/modules<br>
&gt; directory from the repo fetched into downloads/ during the<br>
&gt; fetch task.<br>
&gt; <br>
&gt; Fix that, and for good measure also explicitly tell Git to avoid<br>
&gt; hitting the network during do_unpack() of the submodules.<br>
&gt; <br>
&gt; Rev3 changes:<br>
&gt; <br>
&gt; - Really fix the shallow-clone issue claimed to be addressed in rev2.<=
br>
&gt; <br>
&gt; Rev2 changes:<br>
&gt; <br>
&gt; - Fixed a failure when unpacking a shallow cloned mirror repository.<b=
r>
<br>
</span>The Rev2 and Rev3 changes information should go below the --- below =
<br>
as it should not be part of the commit message as it relates to the <br>
patch submission process rather than the actual change. If any of it <br>
is relevant for the commit message, then the commit message should <br>
be changed as well.<br></blockquote><div><br></div><div>Thanks; done. Resub=
mitted (as v4) to the list.<br></div><div>=C2=A0</div><blockquote class=3D"=
gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-=
left:1ex">
<div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt; [YOCTO #12739]<br>
&gt; <br>
&gt; Signed-off-by: Matt Hoosier &lt;<a href=3D"mailto:matt.hoosier@gmail.c=
om">matt.hoosier@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 lib/bb/fetch2/gitsm.py | 28 +++++++++++++++++++++++++++-<br>
&gt;=C2=A0 1 file changed, 27 insertions(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py<br>
&gt; index 0aff1008..3969f2f5 100644<br>
&gt; --- a/lib/bb/fetch2/gitsm.py<br>
&gt; +++ b/lib/bb/fetch2/gitsm.py<br>
&gt; @@ -132,4 +132,30 @@ class GitSM(Git):<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.uses_submodules(ud, d, ud.de=
stdir):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 runfetchcmd(ud.basecmd=
 + &quot; checkout &quot; + ud.revisions[ud.names[0]], d, workdir=3Dud.dest=
dir)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 runfetchcmd(ud.basecmd + &q=
uot; submodule update --init --recursive&quot;, d, workdir=3Dud.destdir)<br=
>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 updateflags =3D &quot;&quot=
;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Copy over the submodules&=
#39; fetched histories too.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ud.bareclone:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 repo_conf =3D=
 ud.destdir<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 repo_conf =3D=
 os.path.join(ud.destdir, &#39;.git&#39;)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if os.path.exists(ud.cloned=
ir):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # This is not=
 a copy unpacked from a shallow mirror clone. So<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # the manual =
intervention to populate the .git/modules done<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # in clone_sh=
allow_local() won&#39;t have been done yet.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 runfetchcmd(&=
quot;cp -pr %s %s&quot; % (os.path.join(ud.clonedir, &#39;modules&#39;), re=
po_conf), d)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 updateflags +=
=3D &quot; --no-fetch&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 elif os.path.exists(os.path=
.join(<wbr>repo_conf, &#39;modules&#39;)):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Unpacked fr=
om a shallow mirror clone. Manual population of<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # .git/module=
s is already done.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 updateflags +=
=3D &quot; --no-fetch&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # This isn&#3=
9;t fatal; git-submodule will just fetch it<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # during do_u=
npack().<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.error(&quo=
t;submodule history not retrieved during do_fetch()&quot;)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Careful not to hit the ne=
twork during unpacking; all history should already<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # be fetched.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 runfetchcmd(ud.basecmd + &q=
uot; submodule update --init --recursive %s&quot; % updateflags, d, workdir=
=3Dud.destdir)<br>
&gt; --<br>
&gt; 2.13.6<br>
<br>
</div></div><span class=3D"HOEnZb"><font color=3D"#888888">//Peter<br>
<br>
</font></span></blockquote></div><br></div></div>

--000000000000ef01ed056c2efcf4--
