Return-Path: <armccurdy@gmail.com>
Received: from mail-wm0-f43.google.com (mail-wm0-f43.google.com [74.125.82.43])
	by mail.openembedded.org (Postfix) with ESMTP id 76A8360620
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 11 Apr 2016 22:42:38 +0000 (UTC)
Received: by mail-wm0-f43.google.com with SMTP id v188so104679903wme.1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 11 Apr 2016 15:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-transfer-encoding;
	bh=4+IClZKH570djIunfx9nzv4nPBm28DTu00wUoKSnvWA=;
	b=EufB0ekpW8b4Tyht+BTyTFTgr8nduThP8mo1ROKW+rvfzKQUFFqAlly3OxY+sd7F0a
	cuNyTT/O0f6x8bEC3IoZKNVpwPI+a6tpZatjUNf4HSFpxYqZkTqFs0OS8sv8E/nibLS5
	vTc1FkfmZLRYpDZS2H3XyA+YEuiY1vfKLGc05Fimz/6aiiM2M+cg2f6gZOfallFXAny2
	VhANsx4jwHk2ohYkoEsC3cFBjTeoPIMH9MYraYkSr7SsjwLtWdgdpFGZGtyXMhUgQWDi
	1hnxZNwJRgqbzyYfdUvh8PYfhZl9n4XHLsrHaNyW7R3rs+BfCwwDtraoWcj3L7+3rx9D
	HQXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:date
	:message-id:subject:from:to:cc:content-transfer-encoding;
	bh=4+IClZKH570djIunfx9nzv4nPBm28DTu00wUoKSnvWA=;
	b=GC5JCRjt5pXkYKX05Qh7YmRDz6Go0Qr/N0eKHzDXjkTw/ugPyMr7399tI7v7sAU5AW
	YA/HQz0isWavKEg6vNS0AYMXhS50l58Xv5BgmiJQvBPq84PqoK+MQW2o8YEwv2Njls1L
	F/HY2pzKhOoSmULCQArqr4FzERBBmGQKk3Bh49GDx7chHgFzVbgS+OGDBxRizP065H6K
	/JFPYsCEecYKbb/35uF9hmbzZMse0NpuNU1M6+169oTnsoJMYc5fyn4SaS3yIC1hD543
	LUV8FtpXkaT076LdVEAIvua77j/VcKYBMkYrQ4d023bmytZSAJciZsoxBFAlTlC8jl0S
	DSCw==
X-Gm-Message-State: AOPr4FVuYylV2yfkVLzldmL/FE/MOVJTB1EnKzllz0RsYFOZe1q9M8qbJC3dYhLM57prTaZVMJYnUyfg9jP6vA==
MIME-Version: 1.0
X-Received: by 10.28.182.195 with SMTP id g186mr414983wmf.72.1460414559138;
	Mon, 11 Apr 2016 15:42:39 -0700 (PDT)
Received: by 10.194.201.104 with HTTP; Mon, 11 Apr 2016 15:42:39 -0700 (PDT)
In-Reply-To: <1460282961.9308.13.camel@linuxfoundation.org>
References: <1460282961.9308.13.camel@linuxfoundation.org>
Date: Mon, 11 Apr 2016 15:42:39 -0700
Message-ID: <CAJ86T=WM8KvcegV5mhHq7T=LcnVhf3AGimW_heFWT8o_Qzw7Gg@mail.gmail.com>
From: Andre McCurdy <armccurdy@gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] runqueue: Improve 'mulitiple .bb files are due to be built' message
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
X-List-Received-Date: Mon, 11 Apr 2016 22:42:40 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 10, 2016 at 3:09 AM, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
> When multiple recipes which both provide something are being built, bitba=
ke
> informs us that most likely one of them provides something the other does=
n't,
> which is usually correct, but unfortunately it's rather painful to figure=
 out
> exactly what that is.
>
> This patch dumps two sets of information, one is the provides information=
 for
> each recipe, filtered so only common components are removed. The other is=
 a list
> of dependees on the recipe, since sometimes this can easily identify why =
something
> is being built.
>
> Its not straightforward for bitbake to obtain the information but since t=
he
> warning/error code path isn't the normal one, we can afford to go through=
 some
> less than optimal processing to aid debugging.
>
> Also provide the same information even if we're showing a warning since i=
ts still
> useful.
>
> [YOCTO #8032]

Seems to cause problems for me:

$ bitbake harfbuzz
Traceback (most recent call last):
  File "/home/andre/rdk/rdk-master/openembedded-core/bitbake/bin/bitbake",
line 36, in <module>
    from bb.main import bitbake_main, BitBakeConfigParameters, BBMainExcept=
ion
  File "/home/andre/rdk/rdk-master/openembedded-core/bitbake/lib/bb/main.py=
",
line 34, in <module>
    from bb import cooker
  File "/home/andre/rdk/rdk-master/openembedded-core/bitbake/lib/bb/cooker.=
py",
line 38, in <module>
    from bb import utils, data, parse, event, cache, providers,
taskdata, runqueue, build
  File "/home/andre/rdk/rdk-master/openembedded-core/bitbake/lib/bb/runqueu=
e.py",
line 773
    for task, fnid in enumerate(self.runq_fnid)
                                              ^
SyntaxError: invalid syntax

> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
>
> diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
> index 2990de7..ac3cdae 100644
> --- a/bitbake/lib/bb/runqueue.py
> +++ b/bitbake/lib/bb/runqueue.py
> @@ -261,6 +261,13 @@ class RunQueueData:
>          taskname =3D self.runq_task[task] + task_name_suffix
>          return "%s, %s" % (fn, taskname)
>
> +    def get_short_user_idstring(self, task, task_name_suffix =3D ""):
> +        fn =3D self.taskData.fn_index[self.runq_fnid[task]]
> +        pn =3D self.dataCache.pkg_fn[fn]
> +        taskname =3D self.runq_task[task] + task_name_suffix
> +        return "%s:%s" % (pn, taskname)
> +
> +
>      def get_task_id(self, fnid, taskname):
>          for listid in xrange(len(self.runq_fnid)):
>              if self.runq_fnid[listid] =3D=3D fnid and self.runq_task[lis=
tid] =3D=3D taskname:
> @@ -753,11 +760,72 @@ class RunQueueData:
>                          seen_pn.append(pn)
>                      else:
>                          bb.fatal("Multiple versions of %s are due to be =
built (%s). Only one version of a given PN should be built in any given bui=
ld. You likely need to set PREFERRED_VERSION_%s to select the correct versi=
on or don't depend on multiple versions." % (pn, " ".join(prov_list[prov]),=
 pn))
> -                msg =3D "Multiple .bb files are due to be built which ea=
ch provide %s (%s)." % (prov, " ".join(prov_list[prov]))
> +                msg =3D "Multiple .bb files are due to be built which ea=
ch provide %s:\n  %s" % (prov, "\n  ".join(prov_list[prov]))
> +                #
> +                # Construct a list of things which uniquely depend on ea=
ch provider
> +                # since this may help the user figure out which dependen=
cy is triggering this warning
> +                #
> +                msg +=3D "\nA list of tasks depending on these providers=
 is shown and may help explain where the dependency comes from."
> +                deplist =3D {}
> +                commondeps =3D None
> +                for provfn in prov_list[prov]:
> +                    deps =3D set()
> +                    for task in xrange(len(self.runq_fnid)):
> +                        fn =3D taskData.fn_index[self.runq_fnid[task]]
> +                        if fn !=3D provfn:
> +                            continue
> +                        for dep in self.runq_revdeps[task]:
> +                            fn =3D taskData.fn_index[self.runq_fnid[dep]=
]
> +                            if fn =3D=3D provfn:
> +                                continue
> +                            deps.add(self.get_short_user_idstring(dep))
> +                    if not commondeps:
> +                        commondeps =3D set(deps)
> +                    else:
> +                        commondeps &=3D deps
> +                    deplist[provfn] =3D deps
> +                for provfn in deplist:
> +                    msg +=3D "\n%s has unique dependees:\n  %s" % (provf=
n, "\n  ".join(deplist[provfn] - commondeps))
> +                #
> +                # Construct a list of provides and runtime providers for=
 each recipe
> +                # (rprovides has to cover RPROVIDES, PACKAGES, PACKAGES_=
DYNAMIC)
> +                #
> +                msg +=3D "\nIt could be that one recipe provides somethi=
ng the other doesn't and should. The following provider and runtime provide=
r differences may be helpful."
> +                provlist =3D {}
> +                rprovlist =3D {}
> +                commonprovs =3D None
> +                commonrprovs =3D None
> +                for provfn in prov_list[prov]:
> +                    provides =3D set(self.dataCache.fn_provides[provfn])
> +                    rprovides =3D set()
> +                    for rprovide in self.dataCache.rproviders:
> +                        if provfn in self.dataCache.rproviders[rprovide]=
:
> +                            rprovides.add(rprovide)
> +                    for package in self.dataCache.packages:
> +                        if provfn in self.dataCache.packages[package]:
> +                            rprovides.add(package)
> +                    for package in self.dataCache.packages_dynamic:
> +                        if provfn in self.dataCache.packages_dynamic[pac=
kage]:
> +                            rprovides.add(package)
> +                    if not commonprovs:
> +                        commonprovs =3D set(provides)
> +                    else:
> +                        commonprovs &=3D provides
> +                    provlist[provfn] =3D provides
> +                    if not commonrprovs:
> +                        commonrprovs =3D set(rprovides)
> +                    else:
> +                        commonrprovs &=3D rprovides
> +                    rprovlist[provfn] =3D rprovides
> +                #msg +=3D "\nCommon provides:\n  %s" % ("\n  ".join(comm=
onprovs))
> +                #msg +=3D "\nCommon rprovides:\n  %s" % ("\n  ".join(com=
monrprovs))
> +                for provfn in prov_list[prov]:
> +                    msg +=3D "\n%s has unique provides:\n  %s" % (provfn=
, "\n  ".join(provlist[provfn] - commonprovs))
> +                    msg +=3D "\n%s has unique rprovides:\n  %s" % (provf=
n, "\n  ".join(rprovlist[provfn] - commonrprovs))
> +
>                  if self.warn_multi_bb:
>                      logger.warn(msg)
>                  else:
> -                    msg +=3D "\n This usually means one provides somethi=
ng the other doesn't and should."
>                      logger.error(msg)
>
>          # Create a whitelist usable by the stamp checks
>
>
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel

