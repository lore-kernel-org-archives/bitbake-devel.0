Return-Path: <matt.hoosier@gmail.com>
Received: from mail-yb0-f174.google.com (mail-yb0-f174.google.com
	[209.85.213.174])
	by mail.openembedded.org (Postfix) with ESMTP id 6C182786C0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 14 May 2018 21:59:37 +0000 (UTC)
Received: by mail-yb0-f174.google.com with SMTP id g140-v6so22365ybf.6
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 14 May 2018 14:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=BgwU5vZzL2TvTlGd1BSA8AKxVbnGFd0bzJq3nGV5VGI=;
	b=LB4eIUo2b+Hd8VAQRZRxXpeHY65rIz239tN3mBzbALWF4Hu/95LWe9XVJNZthdbUDn
	aD27IzLz0+B22pNaxNZEyS61zg4zXQIxIqRv+3egbvLOchxNdLIeo+dkR6o+47SgWza+
	h3u8VUzGGT+91NYz9L0ay/kdst0hOjl3ZHtskFC6Q6C9SH+O2pbuaL/T1ivTJr4A7yez
	C5e/1fkyw3K9PTppN1Mv9tZyStYqFaRLleyr+oqjLKbmTHARlmXtviv7nTjE35VKUPG3
	4y7kqK9x85UaZtgAKi9XHfVtOC2wv3G48foRNvwg6MxXtADqwL51bk/n4mHXXWNIG18Y
	GHSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=BgwU5vZzL2TvTlGd1BSA8AKxVbnGFd0bzJq3nGV5VGI=;
	b=fwa17YQOGnPkE4YEN+kxTu+FbAWImbfZr9ZqR8JawJNrx74IrK0argn1sgCi9ySY50
	yTHh16rfdNFN/Zjs1tRejO7oCapuVhThmVURfeIySy5JeKM3KicTDmgPagvbvzOBLbHx
	dU/z2iK0Qa6FsJaWIjnBLDiFrDCynMaQbZ1sDAyL352/QFkGKUfU3YsNnidBlJq37ZcL
	AUWLJQ6kNEA4hBfW9exF8jxf9YQtuolCHnB83y4qtGhYXF3EZHohh7ByMvT43Y6aIi/3
	HmaOzxXPuFqrJn0TYWGAakZwwKEmGXAPCE6VP7RVox5/+fDT6EGnpKU1o2yptN8KPyCj
	gSaw==
X-Gm-Message-State: ALKqPwfo5k4VlEBmrf1iUQTiCeKO/BOs2qc0cp0rIEVfiJCYu+NADFGJ
	4cNyFq9fbYl9QN14CsjpQP2clOGotBuWAlcuErg=
X-Google-Smtp-Source: AB8JxZp0YAfgMx+3lfWnV/5qHdJGHFIZEJm0DyGg+EC8waLHZJkZKdgeVQeYlfeTJpUU816CyJKgGznQJs1/xUOc2z4=
X-Received: by 2002:a5b:bc5:: with SMTP id c5-v6mr3265138ybr.429.1526335178584;
	Mon, 14 May 2018 14:59:38 -0700 (PDT)
MIME-Version: 1.0
References: <20180514185036.104469-1-matt.hoosier@gmail.com>
	<CAJTo0LYD==cmd8Z5au=j5jV4sGZqGyogtoVVZ--Nh0eoe2KaAQ@mail.gmail.com>
In-Reply-To: <CAJTo0LYD==cmd8Z5au=j5jV4sGZqGyogtoVVZ--Nh0eoe2KaAQ@mail.gmail.com>
From: Matt Hoosier <matt.hoosier@gmail.com>
Date: Mon, 14 May 2018 16:59:26 -0500
Message-ID: <CAJgxT3_DVwJ_yYrJ9PE8Sa9pUv2rvyYoX8ciJZSpsMpjrncE9Q@mail.gmail.com>
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
X-List-Received-Date: Mon, 14 May 2018 21:59:38 -0000
Content-Type: multipart/alternative; boundary="00000000000020b875056c319a77"

--00000000000020b875056c319a77
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 14, 2018, 15:06 Burton, Ross <ross.burton@intel.com> wrote:

> Sorry, but:
>
> 2018-05-14 18:57:44,968 - oe-selftest - INFO - FAIL:
> test_devtool_add_fetch_git (devtool.DevtoolTests)
> 2018-05-14 18:57:44,968 - oe-selftest - INFO -
> ----------------------------------------------------------------------
> 2018-05-14 18:57:44,968 - oe-selftest - INFO - Traceback (most recent
> call last):
>   File
> "/home/pokybuild/yocto-autobuilder/yocto-worker/nightly-oe-selftest/build=
/meta/lib/oeqa/core/decorator/__init__.py",
> line 32, in wrapped_f
>     return func(*args, **kwargs)
>   File
> "/home/pokybuild/yocto-autobuilder/yocto-worker/nightly-oe-selftest/build=
/meta/lib/oeqa/selftest/cases/devtool.py",
> line 403, in test_devtool_add_fetch_git
>     result =3D runCmd('devtool add %s %s -f "%s" -V 1.5' % (testrecipe,
> srcdir, url_rev))
>   File
> "/home/pokybuild/yocto-autobuilder/yocto-worker/nightly-oe-selftest/build=
/meta/lib/oeqa/utils/commands.py",
> line 191, in runCmd
>     raise AssertionError("Command '%s' returned non-zero exit status
> %d:\n%s" % (command, result.status, exc_output))
> AssertionError: Command 'devtool add mraa /tmp/devtoolqa0aghorcw/mraa
> -f "gitsm://
> git.yoctoproject.org/mraa;rev=3Dae127b19a50aa54255e4330ccfdd9a5d058e581d"
> -V 1.5' returned non-zero exit status 1:
> ...
>
> ERROR: Fetcher failure: Fetch command export PSEUDO_DISABLED=3D1; export
>
> PATH=3D"/home/pokybuild/yocto-autobuilder/yocto-worker/nightly-oe-selftes=
t/build/build/tmp/sysroots-uninative/x86_64-linux/usr/bin:/home/pokybuild/y=
octo-autobuilder/yocto-worker/nightly-oe-selftest/build/scripts:/home/pokyb=
uild/yocto-autobuilder/yocto-worker/nightly-oe-selftest/build/build/tmp/wor=
k/recipetool-utucnynk/work/recipe-sysroot-native/usr/bin/x86_64-poky-linux:=
/home/pokybuild/yocto-autobuilder/yocto-worker/nightly-oe-selftest/build/bu=
ild/tmp/work/recipetool-utucnynk/work/recipe-sysroot/usr/bin/crossscripts:/=
home/pokybuild/yocto-autobuilder/yocto-worker/nightly-oe-selftest/build/bui=
ld/tmp/work/recipetool-utucnynk/work/recipe-sysroot-native/usr/sbin:/home/p=
okybuild/yocto-autobuilder/yocto-worker/nightly-oe-selftest/build/build/tmp=
/work/recipetool-utucnynk/work/recipe-sysroot-native/usr/bin:/home/pokybuil=
d/yocto-autobuilder/yocto-worker/nightly-oe-selftest/build/build/tmp/work/r=
ecipetool-utucnynk/work/recipe-sysroot-native/sbin:/home/pokybuild/yocto-au=
tobuilder/yocto-worker/nightly-oe-selftest/build/build/tmp/work/recipetool-=
utucnynk/work/recipe-sysroot-native/bin:/home/pokybuild/yocto-autobuilder/y=
octo-worker/nightly-oe-selftest/build/bitbake/bin:/home/pokybuild/yocto-aut=
obuilder/yocto-worker/nightly-oe-selftest/build/build/tmp/hosttools";
> export HOME=3D"/home/pokybuild"; git -c core.fsyncobjectfiles=3D0
> submodule update --init --recursive  --no-fetch failed with exit code
> 1, output:
> Submodule 'doxygen2jsdoc'
> (https://github.com/arfoll/doxygen2jsdoc.git) registered for path
> 'doxygen2jsdoc'
> fatal: reference is not a tree: 9cc90b7976252b2d14b7956230c5870097e1f008
> Unable to checkout '9cc90b7976252b2d14b7956230c5870097e1f008' in
> submodule path 'doxygen2jsdoc'
>
> Ross
>
> On 14 May 2018 at 19:50, Matt Hoosier <matt.hoosier@gmail.com> wrote:
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
> >  lib/bb/fetch2/gitsm.py | 28 +++++++++++++++++++++++++++-
> >  1 file changed, 27 insertions(+), 1 deletion(-)
> >
> > diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
> > index 0aff1008..c5019e98 100644
> > --- a/lib/bb/fetch2/gitsm.py
> > +++ b/lib/bb/fetch2/gitsm.py
> > @@ -132,4 +132,30 @@ class GitSM(Git):
> >
> >          if self.uses_submodules(ud, d, ud.destdir):
> >              runfetchcmd(ud.basecmd + " checkout " +
> ud.revisions[ud.names[0]], d, workdir=3Dud.destdir)
> > -            runfetchcmd(ud.basecmd + " submodule update --init
> --recursive", d, workdir=3Dud.destdir)
> > +
> > +            updateflags =3D ""
> > +
> > +            # Copy over the submodules' fetched histories too.
> > +            if ud.bareclone:
> > +                repo_conf =3D ud.destdir
> > +            else:
> > +                repo_conf =3D os.path.join(ud.destdir, '.git')
> > +
> > +            if os.path.exists(ud.clonedir):
> > +                # This is not a copy unpacked from a shallow mirror
> clone. So
> > +                # the manual intervention to populate the .git/modules
> done
> > +                # in clone_shallow_local() won't have been done yet.
> > +                runfetchcmd("cp -fpPRH %s %s" %
> (os.path.join(ud.clonedir, 'modules'), repo_conf), d)
> > +                updateflags +=3D " --no-fetch"
> > +            elif os.path.exists(os.path.join(repo_conf, 'modules')):
> > +                # Unpacked from a shallow mirror clone. Manual
> population of
> > +                # .git/modules is already done.
> > +                updateflags +=3D " --no-fetch"
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
> --recursive %s" % updateflags, d, workdir=3Dud.destdir)
> > --
> > 2.13.6
> >
> > --
> > _______________________________________________
> > bitbake-devel mailing list
> > bitbake-devel@lists.openembedded.org
> > http://lists.openembedded.org/mailman/listinfo/bitbake-devel


Okay, I'll have a look at that. Are there any other test suites I should
know about?

>
>

--00000000000020b875056c319a77
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><div class=3D"gmail_quote"><div dir=3D"ltr">On Mon, =
May 14, 2018, 15:06 Burton, Ross &lt;<a href=3D"mailto:ross.burton@intel.co=
m" target=3D"_blank" rel=3D"noreferrer">ross.burton@intel.com</a>&gt; wrote=
:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bor=
der-left:1px #ccc solid;padding-left:1ex">Sorry, but:<br>
<br>
2018-05-14 18:57:44,968 - oe-selftest - INFO - FAIL:<br>
test_devtool_add_fetch_git (devtool.DevtoolTests)<br>
2018-05-14 18:57:44,968 - oe-selftest - INFO -<br>
----------------------------------------------------------------------<br>
2018-05-14 18:57:44,968 - oe-selftest - INFO - Traceback (most recent<br>
call last):<br>
=C2=A0 File &quot;/home/pokybuild/yocto-autobuilder/yocto-worker/nightly-oe=
-selftest/build/meta/lib/oeqa/core/decorator/__init__.py&quot;,<br>
line 32, in wrapped_f<br>
=C2=A0 =C2=A0 return func(*args, **kwargs)<br>
=C2=A0 File &quot;/home/pokybuild/yocto-autobuilder/yocto-worker/nightly-oe=
-selftest/build/meta/lib/oeqa/selftest/cases/devtool.py&quot;,<br>
line 403, in test_devtool_add_fetch_git<br>
=C2=A0 =C2=A0 result =3D runCmd(&#39;devtool add %s %s -f &quot;%s&quot; -V=
 1.5&#39; % (testrecipe,<br>
srcdir, url_rev))<br>
=C2=A0 File &quot;/home/pokybuild/yocto-autobuilder/yocto-worker/nightly-oe=
-selftest/build/meta/lib/oeqa/utils/commands.py&quot;,<br>
line 191, in runCmd<br>
=C2=A0 =C2=A0 raise AssertionError(&quot;Command &#39;%s&#39; returned non-=
zero exit status<br>
%d:\n%s&quot; % (command, result.status, exc_output))<br>
AssertionError: Command &#39;devtool add mraa /tmp/devtoolqa0aghorcw/mraa<b=
r>
-f &quot;gitsm://<a href=3D"http://git.yoctoproject.org/mraa;rev=3Dae127b19=
a50aa54255e4330ccfdd9a5d058e581d" rel=3D"noreferrer noreferrer noreferrer" =
target=3D"_blank">git.yoctoproject.org/mraa;rev=3Dae127b19a50aa54255e4330cc=
fdd9a5d058e581d</a>&quot;<br>
-V 1.5&#39; returned non-zero exit status 1:<br>
...<br>
<br>
ERROR: Fetcher failure: Fetch command export PSEUDO_DISABLED=3D1; export<br=
>
PATH=3D&quot;/home/pokybuild/yocto-autobuilder/yocto-worker/nightly-oe-self=
test/build/build/tmp/sysroots-uninative/x86_64-linux/usr/bin:/home/pokybuil=
d/yocto-autobuilder/yocto-worker/nightly-oe-selftest/build/scripts:/home/po=
kybuild/yocto-autobuilder/yocto-worker/nightly-oe-selftest/build/build/tmp/=
work/recipetool-utucnynk/work/recipe-sysroot-native/usr/bin/x86_64-poky-lin=
ux:/home/pokybuild/yocto-autobuilder/yocto-worker/nightly-oe-selftest/build=
/build/tmp/work/recipetool-utucnynk/work/recipe-sysroot/usr/bin/crossscript=
s:/home/pokybuild/yocto-autobuilder/yocto-worker/nightly-oe-selftest/build/=
build/tmp/work/recipetool-utucnynk/work/recipe-sysroot-native/usr/sbin:/hom=
e/pokybuild/yocto-autobuilder/yocto-worker/nightly-oe-selftest/build/build/=
tmp/work/recipetool-utucnynk/work/recipe-sysroot-native/usr/bin:/home/pokyb=
uild/yocto-autobuilder/yocto-worker/nightly-oe-selftest/build/build/tmp/wor=
k/recipetool-utucnynk/work/recipe-sysroot-native/sbin:/home/pokybuild/yocto=
-autobuilder/yocto-worker/nightly-oe-selftest/build/build/tmp/work/recipeto=
ol-utucnynk/work/recipe-sysroot-native/bin:/home/pokybuild/yocto-autobuilde=
r/yocto-worker/nightly-oe-selftest/build/bitbake/bin:/home/pokybuild/yocto-=
autobuilder/yocto-worker/nightly-oe-selftest/build/build/tmp/hosttools&quot=
;;<br>
export HOME=3D&quot;/home/pokybuild&quot;; git -c core.fsyncobjectfiles=3D0=
<br>
submodule update --init --recursive=C2=A0 --no-fetch failed with exit code<=
br>
1, output:<br>
Submodule &#39;doxygen2jsdoc&#39;<br>
(<a href=3D"https://github.com/arfoll/doxygen2jsdoc.git" rel=3D"noreferrer =
noreferrer noreferrer" target=3D"_blank">https://github.com/arfoll/doxygen2=
jsdoc.git</a>) registered for path<br>
&#39;doxygen2jsdoc&#39;<br>
fatal: reference is not a tree: 9cc90b7976252b2d14b7956230c5870097e1f008<br=
>
Unable to checkout &#39;9cc90b7976252b2d14b7956230c5870097e1f008&#39; in<br=
>
submodule path &#39;doxygen2jsdoc&#39;<br>
<br>
Ross<br>
<br>
On 14 May 2018 at 19:50, Matt Hoosier &lt;<a href=3D"mailto:matt.hoosier@gm=
ail.com" rel=3D"noreferrer noreferrer" target=3D"_blank">matt.hoosier@gmail=
.com</a>&gt; wrote:<br>
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
om" rel=3D"noreferrer noreferrer" target=3D"_blank">matt.hoosier@gmail.com<=
/a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 lib/bb/fetch2/gitsm.py | 28 +++++++++++++++++++++++++++-<br>
&gt;=C2=A0 1 file changed, 27 insertions(+), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py<br>
&gt; index 0aff1008..c5019e98 100644<br>
&gt; --- a/lib/bb/fetch2/gitsm.py<br>
&gt; +++ b/lib/bb/fetch2/gitsm.py<br>
&gt; @@ -132,4 +132,30 @@ class GitSM(Git):<br>
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
quot;cp -fpPRH %s %s&quot; % (os.path.join(ud.clonedir, &#39;modules&#39;),=
 repo_conf), d)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 updateflags +=
=3D &quot; --no-fetch&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 elif os.path.exists(os.path=
.join(repo_conf, &#39;modules&#39;)):<br>
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
&gt;<br>
&gt; --<br>
&gt; _______________________________________________<br>
&gt; bitbake-devel mailing list<br>
&gt; <a href=3D"mailto:bitbake-devel@lists.openembedded.org" rel=3D"norefer=
rer noreferrer" target=3D"_blank">bitbake-devel@lists.openembedded.org</a><=
br>
&gt; <a href=3D"http://lists.openembedded.org/mailman/listinfo/bitbake-deve=
l" rel=3D"noreferrer noreferrer noreferrer" target=3D"_blank">http://lists.=
openembedded.org/mailman/listinfo/bitbake-devel</a></blockquote></div></div=
><div dir=3D"auto"><br></div><div dir=3D"auto"><span style=3D"font-family:s=
ans-serif">Okay, I&#39;ll have a look at that. Are there any other test sui=
tes I should know about?</span><br></div><div dir=3D"auto"><div class=3D"gm=
ail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bor=
der-left:1px #ccc solid;padding-left:1ex"><br>
</blockquote></div></div></div>

--00000000000020b875056c319a77--
