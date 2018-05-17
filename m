Return-Path: <matt.hoosier@gmail.com>
Received: from mail-yw0-f174.google.com (mail-yw0-f174.google.com
	[209.85.161.174])
	by mail.openembedded.org (Postfix) with ESMTP id D280274966
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 17 May 2018 19:17:44 +0000 (UTC)
Received: by mail-yw0-f174.google.com with SMTP id p144-v6so1667916ywg.7
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 17 May 2018 12:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=yxLAR7/YR5/UY7JKhVMxZTCFuAVwmDvbOkmt5IdI0a0=;
	b=vS5O0cTjx5UM/gveu9OgqZy8xPOi09/xkOHxNYZFjgGbQmK/A15WfuUdhe1gCIyWun
	Km99E48MiP1LAEq57tl12iFTcrP4aa7GRxcLjhX0ge/heNsWu9to0B1vMqIzCARB8wlh
	1cPg3HhlrmQyy9V9MjyCfh/6Y/XUoQO2vTzW3r1EqmL7iaUjiHzFHxTfyXTsOs3WP0j4
	DDfT2dIAe76fZnQx9RyQpXMElMjPG/HP49TGm+jy8aUFfFQbhimY6Zfh1spx/mVWBq4i
	NXMPfeHblA6tYlYySDGIDkDEPPSZTLR0kboLycZoJWu/QuAMFtwVGtSfr8P7VCfTjCfG
	ebGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=yxLAR7/YR5/UY7JKhVMxZTCFuAVwmDvbOkmt5IdI0a0=;
	b=HRKttsTglfw1aa/xBU67vZbzow4F0SmBw8vQ/fMXHYAr7eDYt/A8NaXD4a05iboXnS
	WNQaZqovTmPfNPRo2+MgRQZPWIfoBNoeCItMIiIVXdxBeEUd1g7mBdvjC0ey8wJ9xGMQ
	t0IJhsP3TS/PtAlKYYFFReieZhKBayNKSYXq4FvaM0f22rCcRmQHAsTxhClPyxQ7yEsO
	aSOlNYN4XSgb6OvtF9RZsnC/AMQd6H9GgLNuYxHZRpnctdrTT1t8xc0+FayRsbwtV5wy
	z6uo6URz7FxpzCXdKtQ8BFnPOgMb9imb5tUpaxLGiK9LMr2Lk9hpOcVy33ot/pN8yLuA
	vjXQ==
X-Gm-Message-State: ALKqPwcHnbmuc3L4alyoAi7Fbqh7AUGz8kEWULcEhEdqzHP1tjHpJUXR
	/3jFZSdwdaeQd1eAAF1+C3rJ+WmGNaxyIaMhJxY=
X-Google-Smtp-Source: AB8JxZr0sDCo+ZxHUhFRjSWrU5Rnv/ZLcAmL/HgVXxH3vDjt4iVyb7jQRXIxN6pGSvk1/k4vtYWv+9EbkrosV1b/d/w=
X-Received: by 2002:a0d:e987:: with SMTP id
	s129-v6mr3296281ywe.510.1526584665335; 
	Thu, 17 May 2018 12:17:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:748c:0:0:0:0:0 with HTTP; Thu, 17 May 2018 12:17:04
	-0700 (PDT)
In-Reply-To: <CAJTo0LaM+0Jc2Ebq8zDT+6i21bcE0_xgdT83zORzQRYhkEj1qg@mail.gmail.com>
References: <20180514185036.104469-1-matt.hoosier@gmail.com>
	<CAJTo0LYD==cmd8Z5au=j5jV4sGZqGyogtoVVZ--Nh0eoe2KaAQ@mail.gmail.com>
	<CAJgxT3_DVwJ_yYrJ9PE8Sa9pUv2rvyYoX8ciJZSpsMpjrncE9Q@mail.gmail.com>
	<CAJTo0LaM+0Jc2Ebq8zDT+6i21bcE0_xgdT83zORzQRYhkEj1qg@mail.gmail.com>
From: Matt Hoosier <matt.hoosier@gmail.com>
Date: Thu, 17 May 2018 14:17:04 -0500
Message-ID: <CAJgxT3-2UJg0yRq6ygkkqhZoF-6oJ=HMKAhkCasWHe6eKsfwAQ@mail.gmail.com>
To: "Burton, Ross" <ross.burton@intel.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH v4] fetch/gitsm: avoid live submodule fetching during unpack()
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
X-List-Received-Date: Thu, 17 May 2018 19:17:45 -0000
Content-Type: multipart/alternative; boundary="000000000000b26f54056c6bb02d"

--000000000000b26f54056c6bb02d
Content-Type: text/plain; charset="UTF-8"

Right; I got enough context from your copied/pasted failure report to
duplicate it. I'm just wondering if there are other test batteries besides
bitbake-selftest and oe-selftest that are gates to clear?

-Matt

On Thu, May 17, 2018 at 11:28 AM, Burton, Ross <ross.burton@intel.com>
wrote:

> Hi Matt,
>
> If you run oe-selftest -r devtool then it will run the tests which are
> failing.
>
> Ross
>
> On 14 May 2018 at 22:59, Matt Hoosier <matt.hoosier@gmail.com> wrote:
> > On Mon, May 14, 2018, 15:06 Burton, Ross <ross.burton@intel.com> wrote:
> >>
> >> Sorry, but:
> >>
> >> 2018-05-14 18:57:44,968 - oe-selftest - INFO - FAIL:
> >> test_devtool_add_fetch_git (devtool.DevtoolTests)
> >> 2018-05-14 18:57:44,968 - oe-selftest - INFO -
> >> ----------------------------------------------------------------------
> >> 2018-05-14 18:57:44,968 - oe-selftest - INFO - Traceback (most recent
> >> call last):
> >>   File
> >> "/home/pokybuild/yocto-autobuilder/yocto-worker/
> nightly-oe-selftest/build/meta/lib/oeqa/core/decorator/__init__.py",
> >> line 32, in wrapped_f
> >>     return func(*args, **kwargs)
> >>   File
> >> "/home/pokybuild/yocto-autobuilder/yocto-worker/
> nightly-oe-selftest/build/meta/lib/oeqa/selftest/cases/devtool.py",
> >> line 403, in test_devtool_add_fetch_git
> >>     result = runCmd('devtool add %s %s -f "%s" -V 1.5' % (testrecipe,
> >> srcdir, url_rev))
> >>   File
> >> "/home/pokybuild/yocto-autobuilder/yocto-worker/
> nightly-oe-selftest/build/meta/lib/oeqa/utils/commands.py",
> >> line 191, in runCmd
> >>     raise AssertionError("Command '%s' returned non-zero exit status
> >> %d:\n%s" % (command, result.status, exc_output))
> >> AssertionError: Command 'devtool add mraa /tmp/devtoolqa0aghorcw/mraa
> >> -f
> >> "gitsm://git.yoctoproject.org/mraa;rev=ae127b19a50aa54255e4330ccfdd9a
> 5d058e581d"
> >> -V 1.5' returned non-zero exit status 1:
> >> ...
> >>
> >> ERROR: Fetcher failure: Fetch command export PSEUDO_DISABLED=1; export
> >>
> >> PATH="/home/pokybuild/yocto-autobuilder/yocto-worker/
> nightly-oe-selftest/build/build/tmp/sysroots-uninative/
> x86_64-linux/usr/bin:/home/pokybuild/yocto-autobuilder/
> yocto-worker/nightly-oe-selftest/build/scripts:/home/
> pokybuild/yocto-autobuilder/yocto-worker/nightly-oe-
> selftest/build/build/tmp/work/recipetool-utucnynk/work/
> recipe-sysroot-native/usr/bin/x86_64-poky-linux:/home/
> pokybuild/yocto-autobuilder/yocto-worker/nightly-oe-
> selftest/build/build/tmp/work/recipetool-utucnynk/work/
> recipe-sysroot/usr/bin/crossscripts:/home/pokybuild/
> yocto-autobuilder/yocto-worker/nightly-oe-selftest/build/build/tmp/work/
> recipetool-utucnynk/work/recipe-sysroot-native/usr/
> sbin:/home/pokybuild/yocto-autobuilder/yocto-worker/
> nightly-oe-selftest/build/build/tmp/work/recipetool-
> utucnynk/work/recipe-sysroot-native/usr/bin:/home/
> pokybuild/yocto-autobuilder/yocto-worker/nightly-oe-
> selftest/build/build/tmp/work/recipetool-utucnynk/work/
> recipe-sysroot-native/sbin:/home/pokybuild/yocto-autobuilder/yocto-worker/
> nightly-oe-selftest/build/build/tmp/work/recipetool-
> utucnynk/work/recipe-sysroot-native/bin:/home/pokybuild/
> yocto-autobuilder/yocto-worker/nightly-oe-selftest/
> build/bitbake/bin:/home/pokybuild/yocto-autobuilder/
> yocto-worker/nightly-oe-selftest/build/build/tmp/hosttools";
> >> export HOME="/home/pokybuild"; git -c core.fsyncobjectfiles=0
> >> submodule update --init --recursive  --no-fetch failed with exit code
> >> 1, output:
> >> Submodule 'doxygen2jsdoc'
> >> (https://github.com/arfoll/doxygen2jsdoc.git) registered for path
> >> 'doxygen2jsdoc'
> >> fatal: reference is not a tree: 9cc90b7976252b2d14b7956230c587
> 0097e1f008
> >> Unable to checkout '9cc90b7976252b2d14b7956230c5870097e1f008' in
> >> submodule path 'doxygen2jsdoc'
> >>
> >> Ross
> >>
> >> On 14 May 2018 at 19:50, Matt Hoosier <matt.hoosier@gmail.com> wrote:
> >> > Although the submodules' histories have been fetched during the
> >> > do_fetch() phase, the mechanics used to clone the workdir copy
> >> > of the repo haven't been transferring the actual .git/modules
> >> > directory from the repo fetched into downloads/ during the
> >> > fetch task.
> >> >
> >> > Fix that, and for good measure also explicitly tell Git to avoid
> >> > hitting the network during do_unpack() of the submodules.
> >> >
> >> > [YOCTO #12739]
> >> >
> >> > Signed-off-by: Matt Hoosier <matt.hoosier@gmail.com>
> >> > ---
> >> >  lib/bb/fetch2/gitsm.py | 28 +++++++++++++++++++++++++++-
> >> >  1 file changed, 27 insertions(+), 1 deletion(-)
> >> >
> >> > diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
> >> > index 0aff1008..c5019e98 100644
> >> > --- a/lib/bb/fetch2/gitsm.py
> >> > +++ b/lib/bb/fetch2/gitsm.py
> >> > @@ -132,4 +132,30 @@ class GitSM(Git):
> >> >
> >> >          if self.uses_submodules(ud, d, ud.destdir):
> >> >              runfetchcmd(ud.basecmd + " checkout " +
> >> > ud.revisions[ud.names[0]], d, workdir=ud.destdir)
> >> > -            runfetchcmd(ud.basecmd + " submodule update --init
> >> > --recursive", d, workdir=ud.destdir)
> >> > +
> >> > +            updateflags = ""
> >> > +
> >> > +            # Copy over the submodules' fetched histories too.
> >> > +            if ud.bareclone:
> >> > +                repo_conf = ud.destdir
> >> > +            else:
> >> > +                repo_conf = os.path.join(ud.destdir, '.git')
> >> > +
> >> > +            if os.path.exists(ud.clonedir):
> >> > +                # This is not a copy unpacked from a shallow mirror
> >> > clone. So
> >> > +                # the manual intervention to populate the
> .git/modules
> >> > done
> >> > +                # in clone_shallow_local() won't have been done yet.
> >> > +                runfetchcmd("cp -fpPRH %s %s" %
> >> > (os.path.join(ud.clonedir, 'modules'), repo_conf), d)
> >> > +                updateflags += " --no-fetch"
> >> > +            elif os.path.exists(os.path.join(repo_conf, 'modules')):
> >> > +                # Unpacked from a shallow mirror clone. Manual
> >> > population of
> >> > +                # .git/modules is already done.
> >> > +                updateflags += " --no-fetch"
> >> > +            else:
> >> > +                # This isn't fatal; git-submodule will just fetch it
> >> > +                # during do_unpack().
> >> > +                bb.error("submodule history not retrieved during
> >> > do_fetch()")
> >> > +
> >> > +            # Careful not to hit the network during unpacking; all
> >> > history should already
> >> > +            # be fetched.
> >> > +            runfetchcmd(ud.basecmd + " submodule update --init
> >> > --recursive %s" % updateflags, d, workdir=ud.destdir)
> >> > --
> >> > 2.13.6
> >> >
> >> > --
> >> > _______________________________________________
> >> > bitbake-devel mailing list
> >> > bitbake-devel@lists.openembedded.org
> >> > http://lists.openembedded.org/mailman/listinfo/bitbake-devel
> >
> >
> > Okay, I'll have a look at that. Are there any other test suites I should
> > know about?
> >>
> >>
> >
>

--000000000000b26f54056c6bb02d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Right; I got enough context from your copied/pasted failur=
e report to duplicate it. I&#39;m just wondering if there are other test ba=
tteries besides bitbake-selftest and oe-selftest that are gates to clear?<d=
iv><br></div><div>-Matt<br><div class=3D"gmail_extra"><br><div class=3D"gma=
il_quote">On Thu, May 17, 2018 at 11:28 AM, Burton, Ross <span dir=3D"ltr">=
&lt;<a href=3D"mailto:ross.burton@intel.com" target=3D"_blank">ross.burton@=
intel.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi Matt,=
<br>
<br>
If you run oe-selftest -r devtool then it will run the tests which are fail=
ing.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
Ross<br>
</font></span><div class=3D"HOEnZb"><div class=3D"h5"><br>
On 14 May 2018 at 22:59, Matt Hoosier &lt;<a href=3D"mailto:matt.hoosier@gm=
ail.com">matt.hoosier@gmail.com</a>&gt; wrote:<br>
&gt; On Mon, May 14, 2018, 15:06 Burton, Ross &lt;<a href=3D"mailto:ross.bu=
rton@intel.com">ross.burton@intel.com</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; Sorry, but:<br>
&gt;&gt;<br>
&gt;&gt; 2018-05-14 18:57:44,968 - oe-selftest - INFO - FAIL:<br>
&gt;&gt; test_devtool_add_fetch_git (devtool.DevtoolTests)<br>
&gt;&gt; 2018-05-14 18:57:44,968 - oe-selftest - INFO -<br>
&gt;&gt; ------------------------------<wbr>------------------------------<=
wbr>----------<br>
&gt;&gt; 2018-05-14 18:57:44,968 - oe-selftest - INFO - Traceback (most rec=
ent<br>
&gt;&gt; call last):<br>
&gt;&gt;=C2=A0 =C2=A0File<br>
&gt;&gt; &quot;/home/pokybuild/yocto-<wbr>autobuilder/yocto-worker/<wbr>nig=
htly-oe-selftest/build/<wbr>meta/lib/oeqa/core/decorator/_<wbr>_init__.py&q=
uot;,<br>
&gt;&gt; line 32, in wrapped_f<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0return func(*args, **kwargs)<br>
&gt;&gt;=C2=A0 =C2=A0File<br>
&gt;&gt; &quot;/home/pokybuild/yocto-<wbr>autobuilder/yocto-worker/<wbr>nig=
htly-oe-selftest/build/<wbr>meta/lib/oeqa/selftest/cases/<wbr>devtool.py&qu=
ot;,<br>
&gt;&gt; line 403, in test_devtool_add_fetch_git<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0result =3D runCmd(&#39;devtool add %s %s -f &qu=
ot;%s&quot; -V 1.5&#39; % (testrecipe,<br>
&gt;&gt; srcdir, url_rev))<br>
&gt;&gt;=C2=A0 =C2=A0File<br>
&gt;&gt; &quot;/home/pokybuild/yocto-<wbr>autobuilder/yocto-worker/<wbr>nig=
htly-oe-selftest/build/<wbr>meta/lib/oeqa/utils/commands.<wbr>py&quot;,<br>
&gt;&gt; line 191, in runCmd<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0raise AssertionError(&quot;Command &#39;%s&#39;=
 returned non-zero exit status<br>
&gt;&gt; %d:\n%s&quot; % (command, result.status, exc_output))<br>
&gt;&gt; AssertionError: Command &#39;devtool add mraa /tmp/devtoolqa0aghor=
cw/mraa<br>
&gt;&gt; -f<br>
&gt;&gt; &quot;gitsm://<a href=3D"http://git.yoctoproject.org/mraa;rev=3Dae=
127b19a50aa54255e4330ccfdd9a5d058e581d" rel=3D"noreferrer" target=3D"_blank=
">git.yoctoproject.org/<wbr>mraa;rev=3D<wbr>ae127b19a50aa54255e4330ccfdd9a<=
wbr>5d058e581d</a>&quot;<br>
&gt;&gt; -V 1.5&#39; returned non-zero exit status 1:<br>
&gt;&gt; ...<br>
&gt;&gt;<br>
&gt;&gt; ERROR: Fetcher failure: Fetch command export PSEUDO_DISABLED=3D1; =
export<br>
&gt;&gt;<br>
&gt;&gt; PATH=3D&quot;/home/pokybuild/yocto-<wbr>autobuilder/yocto-worker/<=
wbr>nightly-oe-selftest/build/<wbr>build/tmp/sysroots-uninative/<wbr>x86_64=
-linux/usr/bin:/home/<wbr>pokybuild/yocto-autobuilder/<wbr>yocto-worker/nig=
htly-oe-<wbr>selftest/build/scripts:/home/<wbr>pokybuild/yocto-autobuilder/=
<wbr>yocto-worker/nightly-oe-<wbr>selftest/build/build/tmp/work/<wbr>recipe=
tool-utucnynk/work/<wbr>recipe-sysroot-native/usr/bin/<wbr>x86_64-poky-linu=
x:/home/<wbr>pokybuild/yocto-autobuilder/<wbr>yocto-worker/nightly-oe-<wbr>=
selftest/build/build/tmp/work/<wbr>recipetool-utucnynk/work/<wbr>recipe-sys=
root/usr/bin/<wbr>crossscripts:/home/pokybuild/<wbr>yocto-autobuilder/yocto=
-<wbr>worker/nightly-oe-selftest/<wbr>build/build/tmp/work/<wbr>recipetool-=
utucnynk/work/<wbr>recipe-sysroot-native/usr/<wbr>sbin:/home/pokybuild/yoct=
o-<wbr>autobuilder/yocto-worker/<wbr>nightly-oe-selftest/build/<wbr>build/t=
mp/work/recipetool-<wbr>utucnynk/work/recipe-sysroot-<wbr>native/usr/bin:/h=
ome/<wbr>pokybuild/yocto-autobuilder/<wbr>yocto-worker/nightly-oe-<wbr>self=
test/build/build/tmp/work/<wbr>recipetool-utucnynk/work/<wbr>recipe-sysroot=
-native/sbin:/<wbr>home/pokybuild/yocto-<wbr>autobuilder/yocto-worker/<wbr>=
nightly-oe-selftest/build/<wbr>build/tmp/work/recipetool-<wbr>utucnynk/work=
/recipe-sysroot-<wbr>native/bin:/home/pokybuild/<wbr>yocto-autobuilder/yoct=
o-<wbr>worker/nightly-oe-selftest/<wbr>build/bitbake/bin:/home/<wbr>pokybui=
ld/yocto-autobuilder/<wbr>yocto-worker/nightly-oe-<wbr>selftest/build/build=
/tmp/<wbr>hosttools&quot;;<br>
&gt;&gt; export HOME=3D&quot;/home/pokybuild&quot;; git -c core.fsyncobject=
files=3D0<br>
&gt;&gt; submodule update --init --recursive=C2=A0 --no-fetch failed with e=
xit code<br>
&gt;&gt; 1, output:<br>
&gt;&gt; Submodule &#39;doxygen2jsdoc&#39;<br>
&gt;&gt; (<a href=3D"https://github.com/arfoll/doxygen2jsdoc.git" rel=3D"no=
referrer" target=3D"_blank">https://github.com/arfoll/<wbr>doxygen2jsdoc.gi=
t</a>) registered for path<br>
&gt;&gt; &#39;doxygen2jsdoc&#39;<br>
&gt;&gt; fatal: reference is not a tree: 9cc90b7976252b2d14b7956230c587<wbr=
>0097e1f008<br>
&gt;&gt; Unable to checkout &#39;<wbr>9cc90b7976252b2d14b7956230c587<wbr>00=
97e1f008&#39; in<br>
&gt;&gt; submodule path &#39;doxygen2jsdoc&#39;<br>
&gt;&gt;<br>
&gt;&gt; Ross<br>
&gt;&gt;<br>
&gt;&gt; On 14 May 2018 at 19:50, Matt Hoosier &lt;<a href=3D"mailto:matt.h=
oosier@gmail.com">matt.hoosier@gmail.com</a>&gt; wrote:<br>
&gt;&gt; &gt; Although the submodules&#39; histories have been fetched duri=
ng the<br>
&gt;&gt; &gt; do_fetch() phase, the mechanics used to clone the workdir cop=
y<br>
&gt;&gt; &gt; of the repo haven&#39;t been transferring the actual .git/mod=
ules<br>
&gt;&gt; &gt; directory from the repo fetched into downloads/ during the<br=
>
&gt;&gt; &gt; fetch task.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Fix that, and for good measure also explicitly tell Git to av=
oid<br>
&gt;&gt; &gt; hitting the network during do_unpack() of the submodules.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; [YOCTO #12739]<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Signed-off-by: Matt Hoosier &lt;<a href=3D"mailto:matt.hoosie=
r@gmail.com">matt.hoosier@gmail.com</a>&gt;<br>
&gt;&gt; &gt; ---<br>
&gt;&gt; &gt;=C2=A0 lib/bb/fetch2/gitsm.py | 28 +++++++++++++++++++++++++++=
-<br>
&gt;&gt; &gt;=C2=A0 1 file changed, 27 insertions(+), 1 deletion(-)<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py<=
br>
&gt;&gt; &gt; index 0aff1008..c5019e98 100644<br>
&gt;&gt; &gt; --- a/lib/bb/fetch2/gitsm.py<br>
&gt;&gt; &gt; +++ b/lib/bb/fetch2/gitsm.py<br>
&gt;&gt; &gt; @@ -132,4 +132,30 @@ class GitSM(Git):<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.uses_submodules(ud,=
 d, ud.destdir):<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 runfetchcmd(u=
d.basecmd + &quot; checkout &quot; +<br>
&gt;&gt; &gt; ud.revisions[ud.names[0]], d, workdir=3Dud.destdir)<br>
&gt;&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 runfetchcmd(ud.bas=
ecmd + &quot; submodule update --init<br>
&gt;&gt; &gt; --recursive&quot;, d, workdir=3Dud.destdir)<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 updateflags =3D &q=
uot;&quot;<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Copy over the su=
bmodules&#39; fetched histories too.<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ud.bareclone:<b=
r>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 repo=
_conf =3D ud.destdir<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 repo=
_conf =3D os.path.join(ud.destdir, &#39;.git&#39;)<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if os.path.exists(=
ud.clonedir):<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Th=
is is not a copy unpacked from a shallow mirror<br>
&gt;&gt; &gt; clone. So<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # th=
e manual intervention to populate the .git/modules<br>
&gt;&gt; &gt; done<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # in=
 clone_shallow_local() won&#39;t have been done yet.<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 runf=
etchcmd(&quot;cp -fpPRH %s %s&quot; %<br>
&gt;&gt; &gt; (os.path.join(ud.clonedir, &#39;modules&#39;), repo_conf), d)=
<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 upda=
teflags +=3D &quot; --no-fetch&quot;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 elif os.path.exist=
s(os.path.join(<wbr>repo_conf, &#39;modules&#39;)):<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Un=
packed from a shallow mirror clone. Manual<br>
&gt;&gt; &gt; population of<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # .g=
it/modules is already done.<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 upda=
teflags +=3D &quot; --no-fetch&quot;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Th=
is isn&#39;t fatal; git-submodule will just fetch it<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # du=
ring do_unpack().<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.e=
rror(&quot;submodule history not retrieved during<br>
&gt;&gt; &gt; do_fetch()&quot;)<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Careful not to h=
it the network during unpacking; all<br>
&gt;&gt; &gt; history should already<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # be fetched.<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 runfetchcmd(ud.bas=
ecmd + &quot; submodule update --init<br>
&gt;&gt; &gt; --recursive %s&quot; % updateflags, d, workdir=3Dud.destdir)<=
br>
&gt;&gt; &gt; --<br>
&gt;&gt; &gt; 2.13.6<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; --<br>
&gt;&gt; &gt; ______________________________<wbr>_________________<br>
&gt;&gt; &gt; bitbake-devel mailing list<br>
&gt;&gt; &gt; <a href=3D"mailto:bitbake-devel@lists.openembedded.org">bitba=
ke-devel@lists.<wbr>openembedded.org</a><br>
&gt;&gt; &gt; <a href=3D"http://lists.openembedded.org/mailman/listinfo/bit=
bake-devel" rel=3D"noreferrer" target=3D"_blank">http://lists.openembedded.=
org/<wbr>mailman/listinfo/bitbake-devel</a><br>
&gt;<br>
&gt;<br>
&gt; Okay, I&#39;ll have a look at that. Are there any other test suites I =
should<br>
&gt; know about?<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;<br>
</div></div></blockquote></div><br></div></div></div>

--000000000000b26f54056c6bb02d--
