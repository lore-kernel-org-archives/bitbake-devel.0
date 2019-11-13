Return-Path: <anibal.limon@linaro.org>
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com
	[209.85.217.54])
	by mail.openembedded.org (Postfix) with ESMTP id 47C4E7F7C3
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 13 Nov 2019 19:44:13 +0000 (UTC)
Received: by mail-vs1-f54.google.com with SMTP id k15so2193079vsp.2
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 13 Nov 2019 11:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=RZlgrKYDGLCs/wX8/ur2QYxMzS/zXxLoe01GshKhwCw=;
	b=aKG7py9nqZgKHSbBlYqRxzUobPfGC8LTjKXtYs/eXK2ZpokUSeY/sjrpC5jTmXRWZr
	bntUe0EJPo0tvHvyXrDcbzB7TrRajVfTRYDHT6cK+4sKdCdQjGAbGuJ0V9kejMMnMVdd
	WfKYTxl3i3TFEyRwAxLnKOep/Zqae7ZcXFug9ZbpEGfCyPzCs6BZyPiJxqY4vFFiKAgO
	fizAJSYfW2h2ld60c4X6pKHTVHSiDKW2y5nIY6t23PdQVKXcrpV+WFU+xEV1nKgDbdYb
	RvidgMIIA4Hc38Ok3Vb9P3dpf8np3mb2umfulId5lBAE0zk7ePVelncsaB+SfKzZDPVq
	s9/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=RZlgrKYDGLCs/wX8/ur2QYxMzS/zXxLoe01GshKhwCw=;
	b=Evs5fufrLvGKEiExEA1FBuz6FsRmIucQrggtIRLKPRdLH7DaNwYCjMDad/OxA9xzHf
	gjtICHvvdIKsMmqvyDCmCD3Xkxur2CHPWClsxfECQAYdWFYQNMstcsyQoln29th2N1uK
	8nhhyHDGmcvH3UWJefSDqlzYABLTQ09BMMfRvxVV8+xWbbyUpya3jzzdJJY96WXAV1wy
	u2dEEWKYlaoky1E+QtsQ4++2k6QyydKZ6q0g3hrndzgkGDzN3liZkRmi8e5cIWrsMDbJ
	+KIY/BVY4cBgs7DsCYUGReevvwk/6bHmsLcnle0leG5QEX/U4BKyckAC8fn5WIkS9sZz
	4Tng==
X-Gm-Message-State: APjAAAUh/M7EVRG1PPv7gdMAOh10OtPH4oaa3roxEkOxgfZ384A8PvVQ
	QgIQ+O70xxnhZkjPidMo2pX8sRvP1xZmHNFsW14Cng==
X-Google-Smtp-Source: APXvYqzlw8l3EuCsFSQpxtk89o5LMN0NFNB6h0McLxnpT81qOAJF7ZYeJ69RBjsbS2roxZSaU6wdIdrfobaf3bQZo1I=
X-Received: by 2002:a67:f549:: with SMTP id z9mr3144701vsn.230.1573674254033; 
	Wed, 13 Nov 2019 11:44:14 -0800 (PST)
MIME-Version: 1.0
References: <20191008184512.20130-1-anibal.limon@linaro.org>
	<CAP71WjybOqGNu8Js9pnPEHsuYHRe5LVPgCdei7FsvqQG_L5U1A@mail.gmail.com>
In-Reply-To: <CAP71WjybOqGNu8Js9pnPEHsuYHRe5LVPgCdei7FsvqQG_L5U1A@mail.gmail.com>
From: Anibal Limon <anibal.limon@linaro.org>
Date: Wed, 13 Nov 2019 13:44:03 -0600
Message-ID: <CA+_AqiuEJYtiBuSRkDnEtHzE=W4UwyO7tFbRqnEZXoHuK+zj3Q@mail.gmail.com>
To: Nicolas Dechesne <nicolas.dechesne@linaro.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [RFC][WIP][PATCHv1] lib/bb/checksum.py: Speed-up checksum gen when directory is git
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
X-List-Received-Date: Wed, 13 Nov 2019 19:44:13 -0000
Content-Type: multipart/alternative; boundary="000000000000e77ba305973f96f6"

--000000000000e77ba305973f96f6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 5 Nov 2019 at 22:50, Nicolas Dechesne <nicolas.dechesne@linaro.org>
wrote:

> hi,
>
> On Tue, Oct 8, 2019 at 8:42 PM An=C3=ADbal Lim=C3=B3n <anibal.limon@linar=
o.org>
> wrote:
> >
> > In some cases people/organizations are using a SRC_URI with
> > file:///PATH_TO_DIR that contains a git repository for different
> > reasons, it is useful when want to do an internal build without
> > clone sources from outside.
> >
> > This could consume a lot of CPU time because the current taskhash
> > generation mechanism didn't identify that the folder is a VCS
> > (git, svn, cvs) and makes the cksum for every file including the
> > .git repository in this case.
> >
> > There are different ways to improve the situation,
> >
> > * Add protocol=3Dgitscm in file:// SRC_URI but the taskhash is
> >   calculated before the fetcher identifies the protocol, will require
> >   some changes in bitbake codebase.
> > * This patch: When directory is a git repository (contains .git)
> >   use HEAD rev + git diff to calculate checksum instead of do it
> >   in every file, that is hackish because make some assumptions about
> >   .git directory contents.
> > * Variant of this patch: Make a list of VCS directories (.git, .svn,
> >   .cvs) and take out for cksum calculations, same as before making
> >   assumptions about the . folders content.
>
> I've discussed with Khem and Richard today (@ELCE) about this patch.
> We kind of agreed that the current approach is not really good since
> the local fetcher isn't supposed to 'deal' with scm commands. however
> we agreed that the last variant proposed above might be a much better
> approach. The idea would be to exclude VCS directories from the
> checksum computation. It could potentially be extended in a slightly
> more generic way, like using a variable to specify a list of
> directories to exclude, which could be unset by default, and set in oe
> core as
> BB_LOCAL_DIRS_EXCLUDE =3D ".git .cvs .svn"
>
> Anibal: do you think you can give it a try?
>

It sounds good, this new variable will be only used for cksum exclude?, if
yes may be to change
for more specific variable  BB_LOCAL_DIRS_TASKHASH_EXCLUDE.

Regards,
Anibal


>
>
> >
> > Signed-off-by: An=C3=ADbal Lim=C3=B3n <anibal.limon@linaro.org>
> > ---
> >  lib/bb/checksum.py | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/lib/bb/checksum.py b/lib/bb/checksum.py
> > index 5bc8a8fc..ee125cb5 100644
> > --- a/lib/bb/checksum.py
> > +++ b/lib/bb/checksum.py
> > @@ -86,6 +86,19 @@ class FileChecksumCache(MultiProcessCache):
> >              return checksum
> >
> >          def checksum_dir(pth):
> > +            git_dir =3D os.path.join(pth, '.git')
> > +            if os.path.exists(git_dir):
> > +                import subprocess, hashlib
> > +                m =3D hashlib.md5()
> > +                head =3D subprocess.check_output("cd %s && git rev-par=
se
> HEAD" % pth, shell=3DTrue)
> > +                diff =3D subprocess.check_output("cd %s && git diff" %
> pth, shell=3DTrue)
> > +                m.update(head)
> > +                if diff:
> > +                    m.update(diff)
> > +
> > +                return [(pth, m.hexdigest())]
> > +
> > +
> >              # Handle directories recursively
> >              if pth =3D=3D "/":
> >                  bb.fatal("Refusing to checksum /")
> > --
> > 2.23.0
> >
>

--000000000000e77ba305973f96f6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, 5 Nov 2019 at 22:50, Nicolas =
Dechesne &lt;<a href=3D"mailto:nicolas.dechesne@linaro.org">nicolas.dechesn=
e@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">hi,<br>
<br>
On Tue, Oct 8, 2019 at 8:42 PM An=C3=ADbal Lim=C3=B3n &lt;<a href=3D"mailto=
:anibal.limon@linaro.org" target=3D"_blank">anibal.limon@linaro.org</a>&gt;=
 wrote:<br>
&gt;<br>
&gt; In some cases people/organizations are using a SRC_URI with<br>
&gt; file:///PATH_TO_DIR that contains a git repository for different<br>
&gt; reasons, it is useful when want to do an internal build without<br>
&gt; clone sources from outside.<br>
&gt;<br>
&gt; This could consume a lot of CPU time because the current taskhash<br>
&gt; generation mechanism didn&#39;t identify that the folder is a VCS<br>
&gt; (git, svn, cvs) and makes the cksum for every file including the<br>
&gt; .git repository in this case.<br>
&gt;<br>
&gt; There are different ways to improve the situation,<br>
&gt;<br>
&gt; * Add protocol=3Dgitscm in file:// SRC_URI but the taskhash is<br>
&gt;=C2=A0 =C2=A0calculated before the fetcher identifies the protocol, wil=
l require<br>
&gt;=C2=A0 =C2=A0some changes in bitbake codebase.<br>
&gt; * This patch: When directory is a git repository (contains .git)<br>
&gt;=C2=A0 =C2=A0use HEAD rev + git diff to calculate checksum instead of d=
o it<br>
&gt;=C2=A0 =C2=A0in every file, that is hackish because make some assumptio=
ns about<br>
&gt;=C2=A0 =C2=A0.git directory contents.<br>
&gt; * Variant of this patch: Make a list of VCS directories (.git, .svn,<b=
r>
&gt;=C2=A0 =C2=A0.cvs) and take out for cksum calculations, same as before =
making<br>
&gt;=C2=A0 =C2=A0assumptions about the . folders content.<br>
<br>
I&#39;ve discussed with Khem and Richard today (@ELCE) about this patch.<br=
>
We kind of agreed that the current approach is not really good since<br>
the local fetcher isn&#39;t supposed to &#39;deal&#39; with scm commands. h=
owever<br>
we agreed that the last variant proposed above might be a much better<br>
approach. The idea would be to exclude VCS directories from the<br>
checksum computation. It could potentially be extended in a slightly<br>
more generic way, like using a variable to specify a list of<br>
directories to exclude, which could be unset by default, and set in oe<br>
core as<br>
BB_LOCAL_DIRS_EXCLUDE =3D &quot;.git .cvs .svn&quot;<br>
<br>
Anibal: do you think you can give it a try?<br></blockquote><div><br></div>=
<div>It sounds good, this new variable will be only used for cksum exclude?=
, if yes may be to change</div><div>for more specific variable=C2=A0=C2=A0B=
B_LOCAL_DIRS_TASKHASH_EXCLUDE.</div><div><br></div><div>Regards,</div><div>=
Anibal</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">
<br>
<br>
&gt;<br>
&gt; Signed-off-by: An=C3=ADbal Lim=C3=B3n &lt;<a href=3D"mailto:anibal.lim=
on@linaro.org" target=3D"_blank">anibal.limon@linaro.org</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 lib/bb/checksum.py | 13 +++++++++++++<br>
&gt;=C2=A0 1 file changed, 13 insertions(+)<br>
&gt;<br>
&gt; diff --git a/lib/bb/checksum.py b/lib/bb/checksum.py<br>
&gt; index 5bc8a8fc..ee125cb5 100644<br>
&gt; --- a/lib/bb/checksum.py<br>
&gt; +++ b/lib/bb/checksum.py<br>
&gt; @@ -86,6 +86,19 @@ class FileChecksumCache(MultiProcessCache):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return checksum<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 def checksum_dir(pth):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git_dir =3D os.path.join(pt=
h, &#39;.git&#39;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if os.path.exists(git_dir):=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 import subpro=
cess, hashlib<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 m =3D hashlib=
.md5()<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 head =3D subp=
rocess.check_output(&quot;cd %s &amp;&amp; git rev-parse HEAD&quot; % pth, =
shell=3DTrue)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diff =3D subp=
rocess.check_output(&quot;cd %s &amp;&amp; git diff&quot; % pth, shell=3DTr=
ue)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 m.update(head=
)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if diff:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 m.update(diff)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return [(pth,=
 m.hexdigest())]<br>
&gt; +<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Handle directories r=
ecursively<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if pth =3D=3D &quot;/&=
quot;:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.fatal=
(&quot;Refusing to checksum /&quot;)<br>
&gt; --<br>
&gt; 2.23.0<br>
&gt;<br>
</blockquote></div></div>

--000000000000e77ba305973f96f6--
