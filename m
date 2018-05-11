Return-Path: <matt.hoosier@gmail.com>
Received: from mail-yb0-f179.google.com (mail-yb0-f179.google.com
	[209.85.213.179])
	by mail.openembedded.org (Postfix) with ESMTP id E75A076042
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 11 May 2018 13:56:06 +0000 (UTC)
Received: by mail-yb0-f179.google.com with SMTP id v12-v6so1845456ybl.10
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 11 May 2018 06:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=2ZY//aYdoiNfIzox/5dBZt/DypqjzZ1NbbxFnTrf+dU=;
	b=DPOb4ZKksy79o4FwNdutQJOqRCBxlsyXxY8Ea1grvh+DKwPIFX1xCAooPFIhYqXr+6
	zroFy2z9vAII6AFfSP+zafHUlH/ynEZlbd6WH92CW9xFMjsdSZimjkKGRt93SNbHX1ax
	9KAW5jeN17uogxHShLRhLw60PlWZtzMFjMFXsBh3pcpKteOLJiXxgudAgmFUFt7f4kC8
	CR4On3PCY/6uTZ2HVn7Tk0Gk0te3nnqS4HARezV7r3EZxbE02/LrjLmurOzV2e3f9Ldz
	R7DmiDsA7JPN2dp5YJvQJ8gAFxPXrf4H/TsBS6peyN587snrK/RvR1cxIC1pwvj3ghyo
	zX+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=2ZY//aYdoiNfIzox/5dBZt/DypqjzZ1NbbxFnTrf+dU=;
	b=HNrWOXhYZdCdNMWqbKJjFhnDnuXWtufodR/yAZq56gYH+C1ry9ZsCPajZ+jMTKq5yU
	zPNIhpJ7mtdaMV8ssWcdkAqcXEsyf+pO31DHl12yRP1LfpqesFBzEbONhd+ibyvdMEda
	om90hf9aTp4288oxBf3k6UgUYuZ7LVCtikTC/11S6Z0QFgI6GNhUW9leFLYwqFqRS40N
	i2hJhUqMuKL8fgSLWElSv6IfCl5yUNn61ymi81B/7cyrdfEyvKkbWlZuf0HN7591y6jL
	JI7eUKRNvEag8M0EiRF9Ms+OcGAqctIRTDfpXEjRiCaJWouPwV6OWdKOivW175sY+I/t
	QUtw==
X-Gm-Message-State: ALKqPweO9qg2pRb2Nwpt7+Y+3/+D8T8m+jR8OP8Pn+d51n3CDad9ckcj
	CJkvgdBOQqQ8gHjkST5nf1kedh0eO8M6qtRi1fw=
X-Google-Smtp-Source: AB8JxZpswOPRHuoN8klA62DU7Tm62jAj1yI26Avfk87Nh67cH+9PsTmsPnBmCpcCmZokepQhdKClkHE2V2b0Jp9BIuE=
X-Received: by 2002:a25:b311:: with SMTP id
	l17-v6mr577879ybj.150.1526046967048; 
	Fri, 11 May 2018 06:56:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:748c:0:0:0:0:0 with HTTP; Fri, 11 May 2018 06:55:26
	-0700 (PDT)
In-Reply-To: <CAJTo0LYFNknuqk_xyecvEgDFweFr5vXFwu3N5bNkLZDdcq=4Nw@mail.gmail.com>
References: <20180510023357.96409-1-matt.hoosier@gmail.com>
	<CAJTo0LYFNknuqk_xyecvEgDFweFr5vXFwu3N5bNkLZDdcq=4Nw@mail.gmail.com>
From: Matt Hoosier <matt.hoosier@gmail.com>
Date: Fri, 11 May 2018 08:55:26 -0500
Message-ID: <CAJgxT3_hANc8t8_tavu=WvxtmU10jgBmsX4G+i+2jSNC+ze8Ug@mail.gmail.com>
To: "Burton, Ross" <ross.burton@intel.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
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
X-List-Received-Date: Fri, 11 May 2018 13:56:07 -0000
Content-Type: multipart/alternative; boundary="00000000000061affe056bee7f5a"

--00000000000061affe056bee7f5a
Content-Type: text/plain; charset="UTF-8"

On Fri, May 11, 2018 at 7:28 AM, Burton, Ross <ross.burton@intel.com> wrote:

> This breaks bitbake-selftest:
>
> $ bitbake-selftest  bb.tests.fetch.GitShallowTest
> ........................E
>
> ERROR: test_shallow_submodules (bb.tests.fetch.GitShallowTest)
> ----------------------------------------------------------------------
> Traceback (most recent call last):
>   File "/home/ross/Yocto/poky/bitbake/lib/bb/tests/fetch.py", line
> 1353, in test_shallow_submodules
>     fetcher, ud = self.fetch_shallow(uri)
>   File "/home/ross/Yocto/poky/bitbake/lib/bb/tests/fetch.py", line
> 1198, in fetch_shallow
>     fetcher, ud = self.fetch_and_unpack(uri)
>   File "/home/ross/Yocto/poky/bitbake/lib/bb/tests/fetch.py", line
> 1179, in fetch_and_unpack
>     fetcher.unpack(self.d.getVar('WORKDIR'))
>   File "/home/ross/Yocto/poky/bitbake/lib/bb/fetch2/__init__.py", line
> 1762, in unpack
>     ud.method.unpack(ud, root, self.d)
>   File "/home/ross/Yocto/poky/bitbake/lib/bb/fetch2/gitsm.py", line
> 141, in unpack
>     runfetchcmd("cp -pr %s %s" % (os.path.join(ud.clonedir,
> 'modules'), repo_conf), d)
>   File "/home/ross/Yocto/poky/bitbake/lib/bb/fetch2/__init__.py", line
> 885, in runfetchcmd
>     raise FetchError(error_message)
> bb.fetch2.FetchError: Fetcher failure: Fetch command export
> PSEUDO_DISABLED=1; cp -pr
> /tmp/tmpxi2ydemw/download/git2/tmp.tmpxi2ydemw.gitsource/modules
> /tmp/tmpxi2ydemw/git/.git failed with exit code 1, output:
> cp: cannot stat
> '/tmp/tmpxi2ydemw/download/git2/tmp.tmpxi2ydemw.gitsource/modules': No
> such file or directory
>
> Ross
>

Thanks; I'd not considered shallow mirrored clones; rev2 fixes this.


>
> On 10 May 2018 at 03:33, Matt Hoosier <matt.hoosier@gmail.com> wrote:
> > Although the submodules' histories have been fetched during the
> > do_fetch() phase, the mechanics used to clone the workdir copy
> > of the repo haven't been transferring the actual .git/modules
> > directory from the repo fetched into downloads/ during the
> > fetch task.
> >
> > Fix that, and for good measure also explicitly tell Git to avoid
> > hitting the network during do_unpack() of the submodules.
> >
> > [YOCTO #12739]
> >
> > Signed-off-by: Matt Hoosier <matt.hoosier@gmail.com>
> > ---
> >  lib/bb/fetch2/gitsm.py | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> >
> > diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
> > index 0aff1008..1f3fc443 100644
> > --- a/lib/bb/fetch2/gitsm.py
> > +++ b/lib/bb/fetch2/gitsm.py
> > @@ -132,4 +132,14 @@ class GitSM(Git):
> >
> >          if self.uses_submodules(ud, d, ud.destdir):
> >              runfetchcmd(ud.basecmd + " checkout " +
> ud.revisions[ud.names[0]], d, workdir=ud.destdir)
> > -            runfetchcmd(ud.basecmd + " submodule update --init
> --recursive", d, workdir=ud.destdir)
> > +
> > +            # Copy over the submodules' fetched histories too.
> > +            if ud.bareclone:
> > +                repo_conf = ud.destdir
> > +            else:
> > +                repo_conf = os.path.join(ud.destdir, '.git')
> > +            runfetchcmd("cp -pr %s %s" % (os.path.join(ud.clonedir,
> 'modules'), repo_conf), d)
> > +
> > +            # Careful not to hit the network during unpacking; all
> history should already
> > +            # be fetched.
> > +            runfetchcmd(ud.basecmd + " submodule update --init
> --recursive --no-fetch", d, workdir=ud.destdir)
> > --
> > 2.13.6
> >
> > --
> > _______________________________________________
> > bitbake-devel mailing list
> > bitbake-devel@lists.openembedded.org
> > http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>

--00000000000061affe056bee7f5a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On F=
ri, May 11, 2018 at 7:28 AM, Burton, Ross <span dir=3D"ltr">&lt;<a href=3D"=
mailto:ross.burton@intel.com" target=3D"_blank">ross.burton@intel.com</a>&g=
t;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0=
 .8ex;border-left:1px #ccc solid;padding-left:1ex">This breaks bitbake-self=
test:<br>
<br>
$ bitbake-selftest=C2=A0 bb.tests.fetch.GitShallowTest<br>
........................E<br>
<br>
ERROR: test_shallow_submodules (bb.tests.fetch.<wbr>GitShallowTest)<br>
------------------------------<wbr>------------------------------<wbr>-----=
-----<br>
Traceback (most recent call last):<br>
=C2=A0 File &quot;/home/ross/Yocto/poky/<wbr>bitbake/lib/bb/tests/fetch.py&=
quot;<wbr>, line<br>
1353, in test_shallow_submodules<br>
=C2=A0 =C2=A0 fetcher, ud =3D self.fetch_shallow(uri)<br>
=C2=A0 File &quot;/home/ross/Yocto/poky/<wbr>bitbake/lib/bb/tests/fetch.py&=
quot;<wbr>, line<br>
1198, in fetch_shallow<br>
=C2=A0 =C2=A0 fetcher, ud =3D self.fetch_and_unpack(uri)<br>
=C2=A0 File &quot;/home/ross/Yocto/poky/<wbr>bitbake/lib/bb/tests/fetch.py&=
quot;<wbr>, line<br>
1179, in fetch_and_unpack<br>
=C2=A0 =C2=A0 fetcher.unpack(self.d.getVar(&#39;<wbr>WORKDIR&#39;))<br>
=C2=A0 File &quot;/home/ross/Yocto/poky/<wbr>bitbake/lib/bb/fetch2/__init__=
<wbr>.py&quot;, line<br>
1762, in unpack<br>
=C2=A0 =C2=A0 ud.method.unpack(ud, root, self.d)<br>
=C2=A0 File &quot;/home/ross/Yocto/poky/<wbr>bitbake/lib/bb/fetch2/gitsm.<w=
br>py&quot;, line<br>
141, in unpack<br>
<span class=3D"">=C2=A0 =C2=A0 runfetchcmd(&quot;cp -pr %s %s&quot; % (os.p=
ath.join(ud.clonedir,<br>
&#39;modules&#39;), repo_conf), d)<br>
</span>=C2=A0 File &quot;/home/ross/Yocto/poky/<wbr>bitbake/lib/bb/fetch2/_=
_init__<wbr>.py&quot;, line<br>
885, in runfetchcmd<br>
=C2=A0 =C2=A0 raise FetchError(error_message)<br>
bb.fetch2.FetchError: Fetcher failure: Fetch command export<br>
PSEUDO_DISABLED=3D1; cp -pr<br>
/tmp/tmpxi2ydemw/download/<wbr>git2/tmp.tmpxi2ydemw.<wbr>gitsource/modules<=
br>
/tmp/tmpxi2ydemw/git/.git failed with exit code 1, output:<br>
cp: cannot stat<br>
&#39;/tmp/tmpxi2ydemw/download/<wbr>git2/tmp.tmpxi2ydemw.<wbr>gitsource/mod=
ules&#39;: No<br>
such file or directory<br>
<br>
Ross<br></blockquote><div><br></div><div>Thanks; I&#39;d not considered sha=
llow mirrored clones; rev2 fixes this.</div><div>=C2=A0</div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;p=
adding-left:1ex">
<div class=3D"HOEnZb"><div class=3D"h5"><br>
On 10 May 2018 at 03:33, Matt Hoosier &lt;<a href=3D"mailto:matt.hoosier@gm=
ail.com">matt.hoosier@gmail.com</a>&gt; wrote:<br>
&gt; Although the submodules&#39; histories have been fetched during the<br=
>
&gt; do_fetch() phase, the mechanics used to clone the workdir copy<br>
&gt; of the repo haven&#39;t been transferring the actual .git/modules<br>
&gt; directory from the repo fetched into downloads/ during the<br>
&gt; fetch task.<br>
&gt;<br>
&gt; Fix that, and for good measure also explicitly tell Git to avoid<br>
&gt; hitting the network during do_unpack() of the submodules.<br>
&gt;<br>
&gt; [YOCTO #12739]<br>
&gt;<br>
&gt; Signed-off-by: Matt Hoosier &lt;<a href=3D"mailto:matt.hoosier@gmail.c=
om">matt.hoosier@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 lib/bb/fetch2/gitsm.py | 12 +++++++++++-<br>
&gt;=C2=A0 1 file changed, 11 insertions(+), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py<br>
&gt; index 0aff1008..1f3fc443 100644<br>
&gt; --- a/lib/bb/fetch2/gitsm.py<br>
&gt; +++ b/lib/bb/fetch2/gitsm.py<br>
&gt; @@ -132,4 +132,14 @@ class GitSM(Git):<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.uses_submodules(ud, d, ud.de=
stdir):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 runfetchcmd(ud.basecmd=
 + &quot; checkout &quot; + ud.revisions[ud.names[0]], d, workdir=3Dud.dest=
dir)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 runfetchcmd(ud.basecmd + &q=
uot; submodule update --init --recursive&quot;, d, workdir=3Dud.destdir)<br=
>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Copy over the submodules&=
#39; fetched histories too.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ud.bareclone:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 repo_conf =3D=
 ud.destdir<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 repo_conf =3D=
 os.path.join(ud.destdir, &#39;.git&#39;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 runfetchcmd(&quot;cp -pr %s=
 %s&quot; % (os.path.join(ud.clonedir, &#39;modules&#39;), repo_conf), d)<b=
r>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Careful not to hit the ne=
twork during unpacking; all history should already<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # be fetched.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 runfetchcmd(ud.basecmd + &q=
uot; submodule update --init --recursive --no-fetch&quot;, d, workdir=3Dud.=
destdir)<br>
&gt; --<br>
&gt; 2.13.6<br>
&gt;<br>
</div></div><span class=3D"HOEnZb"><font color=3D"#888888">&gt; --<br>
&gt; ______________________________<wbr>_________________<br>
&gt; bitbake-devel mailing list<br>
&gt; <a href=3D"mailto:bitbake-devel@lists.openembedded.org">bitbake-devel@=
lists.<wbr>openembedded.org</a><br>
&gt; <a href=3D"http://lists.openembedded.org/mailman/listinfo/bitbake-deve=
l" rel=3D"noreferrer" target=3D"_blank">http://lists.openembedded.org/<wbr>=
mailman/listinfo/bitbake-devel</a><br>
</font></span></blockquote></div><br></div></div>

--00000000000061affe056bee7f5a--
