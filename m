Return-Path: <matt.hoosier@gmail.com>
Received: from mail-yw0-f181.google.com (mail-yw0-f181.google.com
	[209.85.161.181])
	by mail.openembedded.org (Postfix) with ESMTP id 23FE374C26
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 25 May 2018 13:48:07 +0000 (UTC)
Received: by mail-yw0-f181.google.com with SMTP id m8-v6so1733317ywd.2
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 25 May 2018 06:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=QF2fxl3zMimrJsxi1GePv4PhBkSyU7qaEgxSmaDqklE=;
	b=kz9H/BnCuN96Osu17jPgVSowR+n5HcmU4JYwUNajk5IDdMGoLRhOG4+Ku+41ovMz42
	mSGYUs7OXnVRVxjoMR+8zuc4EhvEfeSn2f3MtWxUBLuFXCS5iuc6ehgPMAgFaKgaDizJ
	kuvMDRSdNSP6GsSwBcujNGupYJ+5GiJKgOqdg25zwMfVZBv22Fzi8SJCpRKsr1ghH02S
	TFuqAcTk2Azi+W080lLQyycbbaKOeVruwu7QqiV79jp7QalLYUa87Uo7krGC/y4g5AqB
	TyFXvrvOmcLiJJj2hNDf+A59BwO/GFkhpHKhoxsOKtJEK12O0GzAwLzznz7q1PUv/UCk
	ghqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=QF2fxl3zMimrJsxi1GePv4PhBkSyU7qaEgxSmaDqklE=;
	b=pbu7eBtkLYvwN6hQDKaibMWKzh5InfkGaLALr+xIRz2NMOz20j8wmKPdJJ9k6ygL4t
	ImL+mwMd0SQkKFnYWKUk/OKdmUvCXKe4Es15woVMaOaMipM19AZ0Iv+5UohFRAFJE7T/
	QD2QtRLCwwlcZKe+e/82rATP6+FJvu57jaJb69BztxtMsVJYJd3VrWXhhwQg0eMxFJyE
	yB6jdnaLUMOyaTT0A0NHzpM5zyX1J/ywoHhWeacPTwHZaiupA9n1bXmnpoCEPuSpXpgw
	z78TD8saauYmbj/5t1OUM82V31A9v0KtIFp//jdesahi64fThdX5beg8Vrx2QnX5lSdx
	2Jag==
X-Gm-Message-State: ALKqPwdFDoCHDNS4EgPODLtcKrUx4hdDowGxIdBAikmnRDKAZNdQBojl
	U3j5IQB8Xr5Li9s6kaYAZKyXeddB+khS9LxcOYM/xISB
X-Google-Smtp-Source: AB8JxZp3O80sBiRUMI7P5gASZ2T/IXUREnmq/QIOTWn5ewSsE1bs/g6sYzbka7vwMHbh8ZVGz/KHGVxkzQIc7KhUxCo=
X-Received: by 2002:a81:688a:: with SMTP id
	d132-v6mr1348199ywc.386.1527256087902; 
	Fri, 25 May 2018 06:48:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5b:7c8:0:0:0:0:0 with HTTP;
	Fri, 25 May 2018 06:47:27 -0700 (PDT)
In-Reply-To: <CAJgxT3-2UJg0yRq6ygkkqhZoF-6oJ=HMKAhkCasWHe6eKsfwAQ@mail.gmail.com>
References: <20180514185036.104469-1-matt.hoosier@gmail.com>
	<CAJTo0LYD==cmd8Z5au=j5jV4sGZqGyogtoVVZ--Nh0eoe2KaAQ@mail.gmail.com>
	<CAJgxT3_DVwJ_yYrJ9PE8Sa9pUv2rvyYoX8ciJZSpsMpjrncE9Q@mail.gmail.com>
	<CAJTo0LaM+0Jc2Ebq8zDT+6i21bcE0_xgdT83zORzQRYhkEj1qg@mail.gmail.com>
	<CAJgxT3-2UJg0yRq6ygkkqhZoF-6oJ=HMKAhkCasWHe6eKsfwAQ@mail.gmail.com>
From: Matt Hoosier <matt.hoosier@gmail.com>
Date: Fri, 25 May 2018 08:47:27 -0500
Message-ID: <CAJgxT3-bPwLOb8AE3dDSu0JDzWL2EsXNKKmAZsx1SqR-tbdm+w@mail.gmail.com>
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
X-List-Received-Date: Fri, 25 May 2018 13:48:07 -0000
Content-Type: multipart/alternative; boundary="00000000000099bf97056d080465"

--00000000000099bf97056d080465
Content-Type: text/plain; charset="UTF-8"

These test cases failures are fixed up in the v5 submission:
http://lists.openembedded.org/pipermail/bitbake-devel/2018-May/009350.html.

On Thu, May 17, 2018 at 2:17 PM, Matt Hoosier <matt.hoosier@gmail.com>
wrote:

> Right; I got enough context from your copied/pasted failure report to
> duplicate it. I'm just wondering if there are other test batteries besides
> bitbake-selftest and oe-selftest that are gates to clear?
>
> -Matt
>
>
> On Thu, May 17, 2018 at 11:28 AM, Burton, Ross <ross.burton@intel.com>
> wrote:
>
>> Hi Matt,
>>
>> If you run oe-selftest -r devtool then it will run the tests which are
>> failing.
>>
>> Ross
>>
>> On 14 May 2018 at 22:59, Matt Hoosier <matt.hoosier@gmail.com> wrote:
>> > On Mon, May 14, 2018, 15:06 Burton, Ross <ross.burton@intel.com> wrote:
>> >>
>> >> Sorry, but:
>> >>
>> >> 2018-05-14 18:57:44,968 - oe-selftest - INFO - FAIL:
>> >> test_devtool_add_fetch_git (devtool.DevtoolTests)
>> >> 2018-05-14 18:57:44,968 - oe-selftest - INFO -
>> >> ----------------------------------------------------------------------
>> >> 2018-05-14 18:57:44,968 - oe-selftest - INFO - Traceback (most recent
>> >> call last):
>> >>   File
>> >> "/home/pokybuild/yocto-autobuilder/yocto-worker/nightly-oe-
>> selftest/build/meta/lib/oeqa/core/decorator/__init__.py",
>> >> line 32, in wrapped_f
>> >>     return func(*args, **kwargs)
>> >>   File
>> >> "/home/pokybuild/yocto-autobuilder/yocto-worker/nightly-oe-
>> selftest/build/meta/lib/oeqa/selftest/cases/devtool.py",
>> >> line 403, in test_devtool_add_fetch_git
>> >>     result = runCmd('devtool add %s %s -f "%s" -V 1.5' % (testrecipe,
>> >> srcdir, url_rev))
>> >>   File
>> >> "/home/pokybuild/yocto-autobuilder/yocto-worker/nightly-oe-
>> selftest/build/meta/lib/oeqa/utils/commands.py",
>> >> line 191, in runCmd
>> >>     raise AssertionError("Command '%s' returned non-zero exit status
>> >> %d:\n%s" % (command, result.status, exc_output))
>> >> AssertionError: Command 'devtool add mraa /tmp/devtoolqa0aghorcw/mraa
>> >> -f
>> >> "gitsm://git.yoctoproject.org/mraa;rev=ae127b19a50aa54255e43
>> 30ccfdd9a5d058e581d"
>> >> -V 1.5' returned non-zero exit status 1:
>> >> ...
>> >>
>> >> ERROR: Fetcher failure: Fetch command export PSEUDO_DISABLED=1; export
>> >>
>> >> PATH="/home/pokybuild/yocto-autobuilder/yocto-worker/nightly
>> -oe-selftest/build/build/tmp/sysroots-uninative/x86_64-
>> linux/usr/bin:/home/pokybuild/yocto-autobuilder/yocto-
>> worker/nightly-oe-selftest/build/scripts:/home/pokybuild/
>> yocto-autobuilder/yocto-worker/nightly-oe-selftest/
>> build/build/tmp/work/recipetool-utucnynk/work/recipe-
>> sysroot-native/usr/bin/x86_64-poky-linux:/home/pokybuild/
>> yocto-autobuilder/yocto-worker/nightly-oe-selftest/
>> build/build/tmp/work/recipetool-utucnynk/work/recipe-
>> sysroot/usr/bin/crossscripts:/home/pokybuild/yocto-
>> autobuilder/yocto-worker/nightly-oe-selftest/build/
>> build/tmp/work/recipetool-utucnynk/work/recipe-sysroot-
>> native/usr/sbin:/home/pokybuild/yocto-autobuilder/
>> yocto-worker/nightly-oe-selftest/build/build/tmp/work/
>> recipetool-utucnynk/work/recipe-sysroot-native/usr/bin:
>> /home/pokybuild/yocto-autobuilder/yocto-worker/nightly-oe-selftest/build/
>> build/tmp/work/recipetool-utucnynk/work/recipe-sysroot-
>> native/sbin:/home/pokybuild/yocto-autobuilder/yocto-
>> worker/nightly-oe-selftest/build/build/tmp/work/recipetool-utucnynk/work/
>> recipe-sysroot-native/bin:/home/pokybuild/yocto-autobuilder/yocto-worker/
>> nightly-oe-selftest/build/bitbake/bin:/home/pokybuild/
>> yocto-autobuilder/yocto-worker/nightly-oe-selftest/
>> build/build/tmp/hosttools";
>> >> export HOME="/home/pokybuild"; git -c core.fsyncobjectfiles=0
>> >> submodule update --init --recursive  --no-fetch failed with exit code
>> >> 1, output:
>> >> Submodule 'doxygen2jsdoc'
>> >> (https://github.com/arfoll/doxygen2jsdoc.git) registered for path
>> >> 'doxygen2jsdoc'
>> >> fatal: reference is not a tree: 9cc90b7976252b2d14b7956230c587
>> 0097e1f008
>> >> Unable to checkout '9cc90b7976252b2d14b7956230c5870097e1f008' in
>> >> submodule path 'doxygen2jsdoc'
>> >>
>> >> Ross
>> >>
>> >> On 14 May 2018 at 19:50, Matt Hoosier <matt.hoosier@gmail.com> wrote:
>> >> > Although the submodules' histories have been fetched during the
>> >> > do_fetch() phase, the mechanics used to clone the workdir copy
>> >> > of the repo haven't been transferring the actual .git/modules
>> >> > directory from the repo fetched into downloads/ during the
>> >> > fetch task.
>> >> >
>> >> > Fix that, and for good measure also explicitly tell Git to avoid
>> >> > hitting the network during do_unpack() of the submodules.
>> >> >
>> >> > [YOCTO #12739]
>> >> >
>> >> > Signed-off-by: Matt Hoosier <matt.hoosier@gmail.com>
>> >> > ---
>> >> >  lib/bb/fetch2/gitsm.py | 28 +++++++++++++++++++++++++++-
>> >> >  1 file changed, 27 insertions(+), 1 deletion(-)
>> >> >
>> >> > diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
>> >> > index 0aff1008..c5019e98 100644
>> >> > --- a/lib/bb/fetch2/gitsm.py
>> >> > +++ b/lib/bb/fetch2/gitsm.py
>> >> > @@ -132,4 +132,30 @@ class GitSM(Git):
>> >> >
>> >> >          if self.uses_submodules(ud, d, ud.destdir):
>> >> >              runfetchcmd(ud.basecmd + " checkout " +
>> >> > ud.revisions[ud.names[0]], d, workdir=ud.destdir)
>> >> > -            runfetchcmd(ud.basecmd + " submodule update --init
>> >> > --recursive", d, workdir=ud.destdir)
>> >> > +
>> >> > +            updateflags = ""
>> >> > +
>> >> > +            # Copy over the submodules' fetched histories too.
>> >> > +            if ud.bareclone:
>> >> > +                repo_conf = ud.destdir
>> >> > +            else:
>> >> > +                repo_conf = os.path.join(ud.destdir, '.git')
>> >> > +
>> >> > +            if os.path.exists(ud.clonedir):
>> >> > +                # This is not a copy unpacked from a shallow mirror
>> >> > clone. So
>> >> > +                # the manual intervention to populate the
>> .git/modules
>> >> > done
>> >> > +                # in clone_shallow_local() won't have been done yet.
>> >> > +                runfetchcmd("cp -fpPRH %s %s" %
>> >> > (os.path.join(ud.clonedir, 'modules'), repo_conf), d)
>> >> > +                updateflags += " --no-fetch"
>> >> > +            elif os.path.exists(os.path.join(repo_conf,
>> 'modules')):
>> >> > +                # Unpacked from a shallow mirror clone. Manual
>> >> > population of
>> >> > +                # .git/modules is already done.
>> >> > +                updateflags += " --no-fetch"
>> >> > +            else:
>> >> > +                # This isn't fatal; git-submodule will just fetch it
>> >> > +                # during do_unpack().
>> >> > +                bb.error("submodule history not retrieved during
>> >> > do_fetch()")
>> >> > +
>> >> > +            # Careful not to hit the network during unpacking; all
>> >> > history should already
>> >> > +            # be fetched.
>> >> > +            runfetchcmd(ud.basecmd + " submodule update --init
>> >> > --recursive %s" % updateflags, d, workdir=ud.destdir)
>> >> > --
>> >> > 2.13.6
>> >> >
>> >> > --
>> >> > _______________________________________________
>> >> > bitbake-devel mailing list
>> >> > bitbake-devel@lists.openembedded.org
>> >> > http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>> >
>> >
>> > Okay, I'll have a look at that. Are there any other test suites I should
>> > know about?
>> >>
>> >>
>> >
>>
>
>

--00000000000099bf97056d080465
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">These test cases failures are fixed up in the v5 submissio=
n:=C2=A0<a href=3D"http://lists.openembedded.org/pipermail/bitbake-devel/20=
18-May/009350.html">http://lists.openembedded.org/pipermail/bitbake-devel/2=
018-May/009350.html</a>.</div><div class=3D"gmail_extra"><br><div class=3D"=
gmail_quote">On Thu, May 17, 2018 at 2:17 PM, Matt Hoosier <span dir=3D"ltr=
">&lt;<a href=3D"mailto:matt.hoosier@gmail.com" target=3D"_blank">matt.hoos=
ier@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div =
dir=3D"ltr">Right; I got enough context from your copied/pasted failure rep=
ort to duplicate it. I&#39;m just wondering if there are other test batteri=
es besides bitbake-selftest and oe-selftest that are gates to clear?<span c=
lass=3D"HOEnZb"><font color=3D"#888888"><div><br></div></font></span><div><=
span class=3D"HOEnZb"><font color=3D"#888888">-Matt</font></span><div><div =
class=3D"h5"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Thu, May 17, 2018 at 11:28 AM, Burton, Ross <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:ross.burton@intel.com" target=3D"_blank">ross.burton@intel.com<=
/a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:=
0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi Matt,<br>
<br>
If you run oe-selftest -r devtool then it will run the tests which are fail=
ing.<br>
<span class=3D"m_2919359520399924599HOEnZb"><font color=3D"#888888"><br>
Ross<br>
</font></span><div class=3D"m_2919359520399924599HOEnZb"><div class=3D"m_29=
19359520399924599h5"><br>
On 14 May 2018 at 22:59, Matt Hoosier &lt;<a href=3D"mailto:matt.hoosier@gm=
ail.com" target=3D"_blank">matt.hoosier@gmail.com</a>&gt; wrote:<br>
&gt; On Mon, May 14, 2018, 15:06 Burton, Ross &lt;<a href=3D"mailto:ross.bu=
rton@intel.com" target=3D"_blank">ross.burton@intel.com</a>&gt; wrote:<br>
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
&gt;&gt; &quot;/home/pokybuild/yocto-autobui<wbr>lder/yocto-worker/nightly-=
oe-<wbr>selftest/build/meta/lib/oeqa/<wbr>core/decorator/__init__.py&quot;,=
<br>
&gt;&gt; line 32, in wrapped_f<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0return func(*args, **kwargs)<br>
&gt;&gt;=C2=A0 =C2=A0File<br>
&gt;&gt; &quot;/home/pokybuild/yocto-autobui<wbr>lder/yocto-worker/nightly-=
oe-<wbr>selftest/build/meta/lib/oeqa/<wbr>selftest/cases/devtool.py&quot;,<=
br>
&gt;&gt; line 403, in test_devtool_add_fetch_git<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0result =3D runCmd(&#39;devtool add %s %s -f &qu=
ot;%s&quot; -V 1.5&#39; % (testrecipe,<br>
&gt;&gt; srcdir, url_rev))<br>
&gt;&gt;=C2=A0 =C2=A0File<br>
&gt;&gt; &quot;/home/pokybuild/yocto-autobui<wbr>lder/yocto-worker/nightly-=
oe-<wbr>selftest/build/meta/lib/oeqa/<wbr>utils/commands.py&quot;,<br>
&gt;&gt; line 191, in runCmd<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0raise AssertionError(&quot;Command &#39;%s&#39;=
 returned non-zero exit status<br>
&gt;&gt; %d:\n%s&quot; % (command, result.status, exc_output))<br>
&gt;&gt; AssertionError: Command &#39;devtool add mraa /tmp/devtoolqa0aghor=
cw/mraa<br>
&gt;&gt; -f<br>
&gt;&gt; &quot;gitsm://<a href=3D"http://git.yoctoproject.org/mraa;rev=3Dae=
127b19a50aa54255e4330ccfdd9a5d058e581d" rel=3D"noreferrer" target=3D"_blank=
">git.yoctoproject.org/<wbr>mraa;rev=3Dae127b19a50aa54255e43<wbr>30ccfdd9a5=
d058e581d</a>&quot;<br>
&gt;&gt; -V 1.5&#39; returned non-zero exit status 1:<br>
&gt;&gt; ...<br>
&gt;&gt;<br>
&gt;&gt; ERROR: Fetcher failure: Fetch command export PSEUDO_DISABLED=3D1; =
export<br>
&gt;&gt;<br>
&gt;&gt; PATH=3D&quot;/home/pokybuild/yocto-au<wbr>tobuilder/yocto-worker/n=
ightly<wbr>-oe-selftest/build/build/tmp/<wbr>sysroots-uninative/x86_64-<wbr=
>linux/usr/bin:/home/pokybuild/<wbr>yocto-autobuilder/yocto-<wbr>worker/nig=
htly-oe-selftest/<wbr>build/scripts:/home/pokybuild/<wbr>yocto-autobuilder/=
yocto-<wbr>worker/nightly-oe-selftest/<wbr>build/build/tmp/work/recipetoo<w=
br>l-utucnynk/work/recipe-<wbr>sysroot-native/usr/bin/x86_64-<wbr>poky-linu=
x:/home/pokybuild/<wbr>yocto-autobuilder/yocto-<wbr>worker/nightly-oe-selft=
est/<wbr>build/build/tmp/work/recipetoo<wbr>l-utucnynk/work/recipe-<wbr>sys=
root/usr/bin/crossscripts:/<wbr>home/pokybuild/yocto-<wbr>autobuilder/yocto=
-worker/<wbr>nightly-oe-selftest/build/<wbr>build/tmp/work/recipetool-<wbr>=
utucnynk/work/recipe-sysroot-<wbr>native/usr/sbin:/home/<wbr>pokybuild/yoct=
o-autobuilder/<wbr>yocto-worker/nightly-oe-<wbr>selftest/build/build/tmp/wo=
rk/<wbr>recipetool-utucnynk/work/<wbr>recipe-sysroot-native/usr/bin:<wbr>/h=
ome/pokybuild/yocto-<wbr>autobuilder/yocto-worker/<wbr>nightly-oe-selftest/=
build/<wbr>build/tmp/work/recipetool-<wbr>utucnynk/work/recipe-sysroot-<wbr=
>native/sbin:/home/pokybuild/<wbr>yocto-autobuilder/yocto-<wbr>worker/night=
ly-oe-selftest/<wbr>build/build/tmp/work/<wbr>recipetool-utucnynk/work/<wbr=
>recipe-sysroot-native/bin:/<wbr>home/pokybuild/yocto-<wbr>autobuilder/yoct=
o-worker/<wbr>nightly-oe-selftest/build/<wbr>bitbake/bin:/home/pokybuild/<w=
br>yocto-autobuilder/yocto-<wbr>worker/nightly-oe-selftest/<wbr>build/build=
/tmp/hosttools&quot;;<br>
&gt;&gt; export HOME=3D&quot;/home/pokybuild&quot;; git -c core.fsyncobject=
files=3D0<br>
&gt;&gt; submodule update --init --recursive=C2=A0 --no-fetch failed with e=
xit code<br>
&gt;&gt; 1, output:<br>
&gt;&gt; Submodule &#39;doxygen2jsdoc&#39;<br>
&gt;&gt; (<a href=3D"https://github.com/arfoll/doxygen2jsdoc.git" rel=3D"no=
referrer" target=3D"_blank">https://github.com/arfoll/dox<wbr>ygen2jsdoc.gi=
t</a>) registered for path<br>
&gt;&gt; &#39;doxygen2jsdoc&#39;<br>
&gt;&gt; fatal: reference is not a tree: 9cc90b7976252b2d14b7956230c587<wbr=
>0097e1f008<br>
&gt;&gt; Unable to checkout &#39;9cc90b7976252b2d14b7956230c58<wbr>70097e1f=
008&#39; in<br>
&gt;&gt; submodule path &#39;doxygen2jsdoc&#39;<br>
&gt;&gt;<br>
&gt;&gt; Ross<br>
&gt;&gt;<br>
&gt;&gt; On 14 May 2018 at 19:50, Matt Hoosier &lt;<a href=3D"mailto:matt.h=
oosier@gmail.com" target=3D"_blank">matt.hoosier@gmail.com</a>&gt; wrote:<b=
r>
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
r@gmail.com" target=3D"_blank">matt.hoosier@gmail.com</a>&gt;<br>
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
s(os.path.join(re<wbr>po_conf, &#39;modules&#39;)):<br>
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
&gt;&gt; &gt; <a href=3D"mailto:bitbake-devel@lists.openembedded.org" targe=
t=3D"_blank">bitbake-devel@lists.openembedd<wbr>ed.org</a><br>
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
</div></div></blockquote></div><br></div></div></div></div></div>
</blockquote></div><br></div>

--00000000000099bf97056d080465--
