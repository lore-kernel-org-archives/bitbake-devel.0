Return-Path: <ross.burton@intel.com>
Received: from mail-it0-f66.google.com (mail-it0-f66.google.com
	[209.85.214.66])
	by mail.openembedded.org (Postfix) with ESMTP id D3810749B3
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 17 May 2018 16:29:13 +0000 (UTC)
Received: by mail-it0-f66.google.com with SMTP id n202-v6so9598960ita.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 17 May 2018 09:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=qH4tTs2RJhsmMpYN4W/kFhNjCV9QfNm+06AAUWMI2Cw=;
	b=0jqbw63tmlycnSJzk18l54W9xsT9lhU5UytnjHO+OCRwRarPlbYpy3TsMJtKq+3/LX
	wS+DyY4gfY6pHJmsl0jKhM1gSPD0FS7HpZ93gt+hZ8i7TNomxdb06oiuMeFZU3Yz5yCx
	F0Xuoi5n9uya79UOV1bKqMVKJG1zewZ7uYosfVyQj7vWpLG8NYdOxdsOvyudiT7q63fJ
	WFTUs1JQBLvwz194WwnGE+Ba6D3Gf4hTaSR0H+X+QvuUJjA2oSKYb+88rSR+rhINhzr5
	AyUeq+Ws9T0X2jTHKdbDr9YiT/shR2fxhFscGWWCZd7HVey19KlZoAc3vLo60kHymu5w
	lS4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=qH4tTs2RJhsmMpYN4W/kFhNjCV9QfNm+06AAUWMI2Cw=;
	b=iYSoN02Yd2x6i1a1PKzgM0yvku1OQTYqAOPxBhjf5BdVL0PwmNCh+2AtreymZdhwRy
	b9EW57BDfKTynCOycMg5aVqb14yVpPmi9jxmCWtu5CBsKpGGKSX6maREzHdhJyzeR/wX
	3td0WfU6WJe6XibCV2hJoEfOJxCbFoJ0ZwQzadgK1jwCecpgsFRuD8ry3ws3f5wGSFbw
	tGm1tAjXIrLHI4e3WLPqDZ3MrbalJxJCZJAnycBvxemRCzAJVFdCf07gGDn/TORS0gkW
	VXaUDqWKxic3hdT2DiCmmkMg/OmLj49Y0nIAy8EXvIb7Elnr3qBJTr8Mgd2g4hjf7K9c
	DG5A==
X-Gm-Message-State: ALKqPwfMhLUtx1BfdZA87yyA/asB3rf2xnjxRK3mCu5I/rK1Hr43xoZV
	TMkNoJmStUReJcWMhNPnPzGOOVAwImoKAeUzhYMnYw==
X-Google-Smtp-Source: AB8JxZpEJiZjpu1LuZC0i1zzJsDpcJYEMHLi8ErKLCz5yZrLZvhVJO06Dr2NCe+eCrbBJgaWyjjGDKiXUirfJRZ5s5g=
X-Received: by 2002:a24:d2c4:: with SMTP id
	z187-v6mr3430154itf.60.1526574554561; 
	Thu, 17 May 2018 09:29:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.239.11 with HTTP; Thu, 17 May 2018 09:28:54 -0700 (PDT)
In-Reply-To: <CAJgxT3_DVwJ_yYrJ9PE8Sa9pUv2rvyYoX8ciJZSpsMpjrncE9Q@mail.gmail.com>
References: <20180514185036.104469-1-matt.hoosier@gmail.com>
	<CAJTo0LYD==cmd8Z5au=j5jV4sGZqGyogtoVVZ--Nh0eoe2KaAQ@mail.gmail.com>
	<CAJgxT3_DVwJ_yYrJ9PE8Sa9pUv2rvyYoX8ciJZSpsMpjrncE9Q@mail.gmail.com>
From: "Burton, Ross" <ross.burton@intel.com>
Date: Thu, 17 May 2018 17:28:54 +0100
Message-ID: <CAJTo0LaM+0Jc2Ebq8zDT+6i21bcE0_xgdT83zORzQRYhkEj1qg@mail.gmail.com>
To: Matt Hoosier <matt.hoosier@gmail.com>
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
X-List-Received-Date: Thu, 17 May 2018 16:29:13 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matt,

If you run oe-selftest -r devtool then it will run the tests which are fail=
ing.

Ross

On 14 May 2018 at 22:59, Matt Hoosier <matt.hoosier@gmail.com> wrote:
> On Mon, May 14, 2018, 15:06 Burton, Ross <ross.burton@intel.com> wrote:
>>
>> Sorry, but:
>>
>> 2018-05-14 18:57:44,968 - oe-selftest - INFO - FAIL:
>> test_devtool_add_fetch_git (devtool.DevtoolTests)
>> 2018-05-14 18:57:44,968 - oe-selftest - INFO -
>> ----------------------------------------------------------------------
>> 2018-05-14 18:57:44,968 - oe-selftest - INFO - Traceback (most recent
>> call last):
>>   File
>> "/home/pokybuild/yocto-autobuilder/yocto-worker/nightly-oe-selftest/buil=
d/meta/lib/oeqa/core/decorator/__init__.py",
>> line 32, in wrapped_f
>>     return func(*args, **kwargs)
>>   File
>> "/home/pokybuild/yocto-autobuilder/yocto-worker/nightly-oe-selftest/buil=
d/meta/lib/oeqa/selftest/cases/devtool.py",
>> line 403, in test_devtool_add_fetch_git
>>     result =3D runCmd('devtool add %s %s -f "%s" -V 1.5' % (testrecipe,
>> srcdir, url_rev))
>>   File
>> "/home/pokybuild/yocto-autobuilder/yocto-worker/nightly-oe-selftest/buil=
d/meta/lib/oeqa/utils/commands.py",
>> line 191, in runCmd
>>     raise AssertionError("Command '%s' returned non-zero exit status
>> %d:\n%s" % (command, result.status, exc_output))
>> AssertionError: Command 'devtool add mraa /tmp/devtoolqa0aghorcw/mraa
>> -f
>> "gitsm://git.yoctoproject.org/mraa;rev=3Dae127b19a50aa54255e4330ccfdd9a5=
d058e581d"
>> -V 1.5' returned non-zero exit status 1:
>> ...
>>
>> ERROR: Fetcher failure: Fetch command export PSEUDO_DISABLED=3D1; export
>>
>> PATH=3D"/home/pokybuild/yocto-autobuilder/yocto-worker/nightly-oe-selfte=
st/build/build/tmp/sysroots-uninative/x86_64-linux/usr/bin:/home/pokybuild/=
yocto-autobuilder/yocto-worker/nightly-oe-selftest/build/scripts:/home/poky=
build/yocto-autobuilder/yocto-worker/nightly-oe-selftest/build/build/tmp/wo=
rk/recipetool-utucnynk/work/recipe-sysroot-native/usr/bin/x86_64-poky-linux=
:/home/pokybuild/yocto-autobuilder/yocto-worker/nightly-oe-selftest/build/b=
uild/tmp/work/recipetool-utucnynk/work/recipe-sysroot/usr/bin/crossscripts:=
/home/pokybuild/yocto-autobuilder/yocto-worker/nightly-oe-selftest/build/bu=
ild/tmp/work/recipetool-utucnynk/work/recipe-sysroot-native/usr/sbin:/home/=
pokybuild/yocto-autobuilder/yocto-worker/nightly-oe-selftest/build/build/tm=
p/work/recipetool-utucnynk/work/recipe-sysroot-native/usr/bin:/home/pokybui=
ld/yocto-autobuilder/yocto-worker/nightly-oe-selftest/build/build/tmp/work/=
recipetool-utucnynk/work/recipe-sysroot-native/sbin:/home/pokybuild/yocto-a=
utobuilder/yocto-worker/nightly-oe-selftest/build/build/tmp/work/recipetool=
-utucnynk/work/recipe-sysroot-native/bin:/home/pokybuild/yocto-autobuilder/=
yocto-worker/nightly-oe-selftest/build/bitbake/bin:/home/pokybuild/yocto-au=
tobuilder/yocto-worker/nightly-oe-selftest/build/build/tmp/hosttools";
>> export HOME=3D"/home/pokybuild"; git -c core.fsyncobjectfiles=3D0
>> submodule update --init --recursive  --no-fetch failed with exit code
>> 1, output:
>> Submodule 'doxygen2jsdoc'
>> (https://github.com/arfoll/doxygen2jsdoc.git) registered for path
>> 'doxygen2jsdoc'
>> fatal: reference is not a tree: 9cc90b7976252b2d14b7956230c5870097e1f008
>> Unable to checkout '9cc90b7976252b2d14b7956230c5870097e1f008' in
>> submodule path 'doxygen2jsdoc'
>>
>> Ross
>>
>> On 14 May 2018 at 19:50, Matt Hoosier <matt.hoosier@gmail.com> wrote:
>> > Although the submodules' histories have been fetched during the
>> > do_fetch() phase, the mechanics used to clone the workdir copy
>> > of the repo haven't been transferring the actual .git/modules
>> > directory from the repo fetched into downloads/ during the
>> > fetch task.
>> >
>> > Fix that, and for good measure also explicitly tell Git to avoid
>> > hitting the network during do_unpack() of the submodules.
>> >
>> > [YOCTO #12739]
>> >
>> > Signed-off-by: Matt Hoosier <matt.hoosier@gmail.com>
>> > ---
>> >  lib/bb/fetch2/gitsm.py | 28 +++++++++++++++++++++++++++-
>> >  1 file changed, 27 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
>> > index 0aff1008..c5019e98 100644
>> > --- a/lib/bb/fetch2/gitsm.py
>> > +++ b/lib/bb/fetch2/gitsm.py
>> > @@ -132,4 +132,30 @@ class GitSM(Git):
>> >
>> >          if self.uses_submodules(ud, d, ud.destdir):
>> >              runfetchcmd(ud.basecmd + " checkout " +
>> > ud.revisions[ud.names[0]], d, workdir=3Dud.destdir)
>> > -            runfetchcmd(ud.basecmd + " submodule update --init
>> > --recursive", d, workdir=3Dud.destdir)
>> > +
>> > +            updateflags =3D ""
>> > +
>> > +            # Copy over the submodules' fetched histories too.
>> > +            if ud.bareclone:
>> > +                repo_conf =3D ud.destdir
>> > +            else:
>> > +                repo_conf =3D os.path.join(ud.destdir, '.git')
>> > +
>> > +            if os.path.exists(ud.clonedir):
>> > +                # This is not a copy unpacked from a shallow mirror
>> > clone. So
>> > +                # the manual intervention to populate the .git/module=
s
>> > done
>> > +                # in clone_shallow_local() won't have been done yet.
>> > +                runfetchcmd("cp -fpPRH %s %s" %
>> > (os.path.join(ud.clonedir, 'modules'), repo_conf), d)
>> > +                updateflags +=3D " --no-fetch"
>> > +            elif os.path.exists(os.path.join(repo_conf, 'modules')):
>> > +                # Unpacked from a shallow mirror clone. Manual
>> > population of
>> > +                # .git/modules is already done.
>> > +                updateflags +=3D " --no-fetch"
>> > +            else:
>> > +                # This isn't fatal; git-submodule will just fetch it
>> > +                # during do_unpack().
>> > +                bb.error("submodule history not retrieved during
>> > do_fetch()")
>> > +
>> > +            # Careful not to hit the network during unpacking; all
>> > history should already
>> > +            # be fetched.
>> > +            runfetchcmd(ud.basecmd + " submodule update --init
>> > --recursive %s" % updateflags, d, workdir=3Dud.destdir)
>> > --
>> > 2.13.6
>> >
>> > --
>> > _______________________________________________
>> > bitbake-devel mailing list
>> > bitbake-devel@lists.openembedded.org
>> > http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>
>
> Okay, I'll have a look at that. Are there any other test suites I should
> know about?
>>
>>
>

