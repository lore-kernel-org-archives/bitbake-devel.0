Return-Path: <ross.burton@intel.com>
Received: from mail-it0-f67.google.com (mail-it0-f67.google.com
	[209.85.214.67])
	by mail.openembedded.org (Postfix) with ESMTP id 69FA5785E7
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 14 May 2018 20:06:38 +0000 (UTC)
Received: by mail-it0-f67.google.com with SMTP id 144-v6so13433388iti.5
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 14 May 2018 13:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=cVpcNiQc7eVo2Vf6wKS+kvpEaEafR1CWIh9OTg7kv0E=;
	b=Z2Ib8FNSybmtaKb9gzMp/VhkzRy8k1wD0xldi9PasXvzgZ7W1jrZKs4i+xCq1PdUPC
	8stzL84udxxaNDZEhfb2N7WKI1swZvooH6wnFc1mRINu5ior+R6SzkHSkDLllTDMW8hm
	NlEcIy4NMozYmYwaIWoztg9gnhqjyUCYadZWSnmczqhBeXLAGVShQF+AEIHNoog1wZpw
	ugP21GtWNw8wZ7UYgnfNaLQa0/NF97CYFa7OX6MFf5Dktqs1xeMCCyQGamsymOwX05ao
	U0ljbYRwKEwYOJ9CDtGSnt+dVnNJoMPIwGgwKcsHSNawqVbd7PDffMxj7SOm/zUWI0eq
	bY0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=cVpcNiQc7eVo2Vf6wKS+kvpEaEafR1CWIh9OTg7kv0E=;
	b=PSKJEl3A+lQ1uudrGlEEjEXQTyBoT1zmqlx5CfKbHOrw5mNyNACcIDaOBTuh6JDzlk
	SEbqoXatIysPNEDjMZsHqJoYVtkw1mNHhWfn1oTu815Kn1PCM+zuZh4sccDoZBmqHRCj
	B8ntDhDhLKRQdP5ivyYmBkObfVk0kyWEL4chdo6PKuE7bps08LyvVlvU9H8JClvyAEII
	9scS6dmxFHAg2aDhKofrx+Q9bTglF2dEswCtB35kpPEFR0SGYY0uuTYAni5lTa52yC5b
	5QXOINhzR/Vc3fXiVNIPNbWsAZHGQv1xud2gYhkH6L/lqOdpJukQc0SDX+z0NPgVpbVc
	AVRQ==
X-Gm-Message-State: ALKqPwdzmHM7LYr/+RoO+s4eXUEXkyPo9bohNuuiHIzxQikWX1BaEssk
	dUwoWa69gjGMtfZynj5nS+uaNzE0xBP84Y8scW+vMDXU
X-Google-Smtp-Source: AB8JxZrWKCD5NKbQk/FLw4PnJSPLmXEkMWfTi23jeq4XNc936owmi6pP70eyl/QGoodB3LR2dHgQadAFl2Z1R1MgOGg=
X-Received: by 2002:a24:d2c4:: with SMTP id
	z187-v6mr11209581itf.60.1526328399864; 
	Mon, 14 May 2018 13:06:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.239.11 with HTTP; Mon, 14 May 2018 13:06:19 -0700 (PDT)
In-Reply-To: <20180514185036.104469-1-matt.hoosier@gmail.com>
References: <20180514185036.104469-1-matt.hoosier@gmail.com>
From: "Burton, Ross" <ross.burton@intel.com>
Date: Mon, 14 May 2018 21:06:19 +0100
Message-ID: <CAJTo0LYD==cmd8Z5au=j5jV4sGZqGyogtoVVZ--Nh0eoe2KaAQ@mail.gmail.com>
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
X-List-Received-Date: Mon, 14 May 2018 20:06:39 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry, but:

2018-05-14 18:57:44,968 - oe-selftest - INFO - FAIL:
test_devtool_add_fetch_git (devtool.DevtoolTests)
2018-05-14 18:57:44,968 - oe-selftest - INFO -
----------------------------------------------------------------------
2018-05-14 18:57:44,968 - oe-selftest - INFO - Traceback (most recent
call last):
  File "/home/pokybuild/yocto-autobuilder/yocto-worker/nightly-oe-selftest/=
build/meta/lib/oeqa/core/decorator/__init__.py",
line 32, in wrapped_f
    return func(*args, **kwargs)
  File "/home/pokybuild/yocto-autobuilder/yocto-worker/nightly-oe-selftest/=
build/meta/lib/oeqa/selftest/cases/devtool.py",
line 403, in test_devtool_add_fetch_git
    result =3D runCmd('devtool add %s %s -f "%s" -V 1.5' % (testrecipe,
srcdir, url_rev))
  File "/home/pokybuild/yocto-autobuilder/yocto-worker/nightly-oe-selftest/=
build/meta/lib/oeqa/utils/commands.py",
line 191, in runCmd
    raise AssertionError("Command '%s' returned non-zero exit status
%d:\n%s" % (command, result.status, exc_output))
AssertionError: Command 'devtool add mraa /tmp/devtoolqa0aghorcw/mraa
-f "gitsm://git.yoctoproject.org/mraa;rev=3Dae127b19a50aa54255e4330ccfdd9a5=
d058e581d"
-V 1.5' returned non-zero exit status 1:
...

ERROR: Fetcher failure: Fetch command export PSEUDO_DISABLED=3D1; export
PATH=3D"/home/pokybuild/yocto-autobuilder/yocto-worker/nightly-oe-selftest/=
build/build/tmp/sysroots-uninative/x86_64-linux/usr/bin:/home/pokybuild/yoc=
to-autobuilder/yocto-worker/nightly-oe-selftest/build/scripts:/home/pokybui=
ld/yocto-autobuilder/yocto-worker/nightly-oe-selftest/build/build/tmp/work/=
recipetool-utucnynk/work/recipe-sysroot-native/usr/bin/x86_64-poky-linux:/h=
ome/pokybuild/yocto-autobuilder/yocto-worker/nightly-oe-selftest/build/buil=
d/tmp/work/recipetool-utucnynk/work/recipe-sysroot/usr/bin/crossscripts:/ho=
me/pokybuild/yocto-autobuilder/yocto-worker/nightly-oe-selftest/build/build=
/tmp/work/recipetool-utucnynk/work/recipe-sysroot-native/usr/sbin:/home/pok=
ybuild/yocto-autobuilder/yocto-worker/nightly-oe-selftest/build/build/tmp/w=
ork/recipetool-utucnynk/work/recipe-sysroot-native/usr/bin:/home/pokybuild/=
yocto-autobuilder/yocto-worker/nightly-oe-selftest/build/build/tmp/work/rec=
ipetool-utucnynk/work/recipe-sysroot-native/sbin:/home/pokybuild/yocto-auto=
builder/yocto-worker/nightly-oe-selftest/build/build/tmp/work/recipetool-ut=
ucnynk/work/recipe-sysroot-native/bin:/home/pokybuild/yocto-autobuilder/yoc=
to-worker/nightly-oe-selftest/build/bitbake/bin:/home/pokybuild/yocto-autob=
uilder/yocto-worker/nightly-oe-selftest/build/build/tmp/hosttools";
export HOME=3D"/home/pokybuild"; git -c core.fsyncobjectfiles=3D0
submodule update --init --recursive  --no-fetch failed with exit code
1, output:
Submodule 'doxygen2jsdoc'
(https://github.com/arfoll/doxygen2jsdoc.git) registered for path
'doxygen2jsdoc'
fatal: reference is not a tree: 9cc90b7976252b2d14b7956230c5870097e1f008
Unable to checkout '9cc90b7976252b2d14b7956230c5870097e1f008' in
submodule path 'doxygen2jsdoc'

Ross

On 14 May 2018 at 19:50, Matt Hoosier <matt.hoosier@gmail.com> wrote:
> Although the submodules' histories have been fetched during the
> do_fetch() phase, the mechanics used to clone the workdir copy
> of the repo haven't been transferring the actual .git/modules
> directory from the repo fetched into downloads/ during the
> fetch task.
>
> Fix that, and for good measure also explicitly tell Git to avoid
> hitting the network during do_unpack() of the submodules.
>
> [YOCTO #12739]
>
> Signed-off-by: Matt Hoosier <matt.hoosier@gmail.com>
> ---
>  lib/bb/fetch2/gitsm.py | 28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
>
> diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
> index 0aff1008..c5019e98 100644
> --- a/lib/bb/fetch2/gitsm.py
> +++ b/lib/bb/fetch2/gitsm.py
> @@ -132,4 +132,30 @@ class GitSM(Git):
>
>          if self.uses_submodules(ud, d, ud.destdir):
>              runfetchcmd(ud.basecmd + " checkout " + ud.revisions[ud.name=
s[0]], d, workdir=3Dud.destdir)
> -            runfetchcmd(ud.basecmd + " submodule update --init --recursi=
ve", d, workdir=3Dud.destdir)
> +
> +            updateflags =3D ""
> +
> +            # Copy over the submodules' fetched histories too.
> +            if ud.bareclone:
> +                repo_conf =3D ud.destdir
> +            else:
> +                repo_conf =3D os.path.join(ud.destdir, '.git')
> +
> +            if os.path.exists(ud.clonedir):
> +                # This is not a copy unpacked from a shallow mirror clon=
e. So
> +                # the manual intervention to populate the .git/modules d=
one
> +                # in clone_shallow_local() won't have been done yet.
> +                runfetchcmd("cp -fpPRH %s %s" % (os.path.join(ud.clonedi=
r, 'modules'), repo_conf), d)
> +                updateflags +=3D " --no-fetch"
> +            elif os.path.exists(os.path.join(repo_conf, 'modules')):
> +                # Unpacked from a shallow mirror clone. Manual populatio=
n of
> +                # .git/modules is already done.
> +                updateflags +=3D " --no-fetch"
> +            else:
> +                # This isn't fatal; git-submodule will just fetch it
> +                # during do_unpack().
> +                bb.error("submodule history not retrieved during do_fetc=
h()")
> +
> +            # Careful not to hit the network during unpacking; all histo=
ry should already
> +            # be fetched.
> +            runfetchcmd(ud.basecmd + " submodule update --init --recursi=
ve %s" % updateflags, d, workdir=3Dud.destdir)
> --
> 2.13.6
>
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel

