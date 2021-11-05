Return-Path: <jeanmarie.lemetayer@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03731C433EF
	for <webhook@archiver.kernel.org>; Fri,  5 Nov 2021 11:24:48 +0000 (UTC)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com
 [209.85.167.50])
 by mx.groups.io with SMTP id smtpd.web09.4109.1636111486919208223
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Nov 2021 04:24:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=H+1/W/A8;
 spf=pass (domain: gmail.com, ip: 209.85.167.50,
 mailfrom: jeanmarie.lemetayer@gmail.com)
Received: by mail-lf1-f50.google.com with SMTP id f3so17940992lfu.12
        for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Nov 2021 04:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9K0B0pSNrF6MvrIPDP42S4qyGZUH+bnGlBIsAvlpHE0=;
        b=H+1/W/A8mHVwfqxMKRX2tafO2DBnhP7LMohjYMPklpUVFz+cCTnSgHmAuoZsgoYhyV
         kPIbXxeq2zyrDQ6w3f+L1nqnrwmPsIxBXaUCbOeYb5Xx91iYkbjH6RHfoqZBS4I1Q8Lm
         cDNzeYpIFgTbaadNxGxWQ6C6NXW/apRwi9FRojW0PZoxegBBDohY1E/y9S9391UkeZ5n
         75gJJ25EkRW/rLt43+X1O1ztTI+52mhHS4RUiDdlVEb1eCLei2AJ9vvMtM+oxrMO0h7j
         SZGYIQHBRgPKFVqWYWfOmFMvH4CWbK+FQR/zMvRhrDLqqjwuMgRSPxzOsPxSWNgWM2gU
         WA8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9K0B0pSNrF6MvrIPDP42S4qyGZUH+bnGlBIsAvlpHE0=;
        b=TS/4iiA4SRpqI4uqiejDN8WAY4QJTyyImoQfqTf/D3wsrNpqZaIIC4a9anwg6QvuzQ
         hYfqFTXmJ0lC36ozgE2XjweNMfRzZJhZCDJqQpVcpCnFHMg5eGe0yRJeokq1LzvxyXUI
         dbWw96ENqGhHmhDPT/ReNuJ0oBEvD8oLz20dj5yEQSE6pkka/twceb+sVbdD2zW7BqLj
         ZkR43b9mxIXWV9JRNH5bxgjcIOdnBfVTlnjkhzjN0wVTU2gbcam6xTM9DDoBkq2wn7o4
         YA6YI3SsY8mmpPF1QQx4a+XHzP/DzDejtN9OxvLlSJrEr1c2aGkXUkqEpzNoh/L3j4+p
         F80w==
X-Gm-Message-State: AOAM533wcOwRGj1sPGkIimKwwBYfi+LVg9PKgTV3/gAbGvAAUOcbLbxc
	Bsc61uMurLXOe4jqyP2aANlo7xZVh6el9aYogog=
X-Google-Smtp-Source: 
 ABdhPJxn+NXtGYFdvBtkR2AssTvs+CcM0r7lMc/UIWeh3cJGYv1Kc5scYJeFyqeNT07pcNeuISqmfM1to7GCda2T5Wc=
X-Received: by 2002:ac2:4e44:: with SMTP id f4mr38298437lfr.458.1636111484848;
 Fri, 05 Nov 2021 04:24:44 -0700 (PDT)
MIME-Version: 1.0
References: <1c7d6bb2479af789132b3e94c44a54f1d1b5c304.camel@iris-sensing.com>
 <0b63fba531fc94bbe915dfc9915c0a2f42ad3ce9.camel@linuxfoundation.org>
 <42a0350d-991a-731d-29c2-83cd62da8c7b@weidmueller.com>
In-Reply-To: <42a0350d-991a-731d-29c2-83cd62da8c7b@weidmueller.com>
From: Jean-Marie Lemetayer <jeanmarie.lemetayer@gmail.com>
Date: Fri, 5 Nov 2021 04:24:34 -0700
Message-ID: 
 <CAAdc0hwA12CiWHCXQV=MBHv-h=vopK7of3CUViR58fJ8k2rK1g@mail.gmail.com>
Subject: Re: [bitbake-devel] Improving npm(sw) fetcher & integration within
 Bitbake
To: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>,
	Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>,
	"bitbake-devel@lists.openembedded.org"
 <bitbake-devel@lists.openembedded.org>, "martin@mko.dev" <martin@mko.dev>,
	Daniel Baumgart <Daniel.Baumgart@iris-sensing.com>
Content-Type: multipart/alternative; boundary="000000000000de0c3205d008e31f"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 05 Nov 2021 11:24:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12889

--000000000000de0c3205d008e31f
Content-Type: text/plain; charset="UTF-8"

Hi Jasper and folks,

I am the guy who updated the NPM support in bitbake last time. All your
remarks are correct, shrinkwarp file placement can be updated and the
do_configure step is a real pain. But this is the only way I found which
follows the bitbake requirements.

For the 'access to network' thing, be careful with NPM because there are
some corner cases when NPM tries to access it without permissions (node-gyp
if I remember well). I was doing my test builds with my RJ45 unplugged to
be sure.

The fact that the NPM workflow is totally not the same as the Bitbake one
is the real issue. I think the best solution could be to make some
improvements to NPM directly so it can fit better in an environment like
Bitbake (maybe a new fetch command).

Best regards and good luck,
Jean-Marie


On Fri, Nov 5, 2021 at 2:07 AM Stefan Herbrechtsmeier <
stefan.herbrechtsmeier-oss@weidmueller.com> wrote:

> Hi Jasper and Richard,
>
> Am 05.11.2021 um 00:15 schrieb Richard Purdie via lists.openembedded.org:
> > On Thu, 2021-11-04 at 12:29 +0000, Jasper Orschulko wrote:
> >> Dear Bitbake developers,
> >>
> >> recently we have been looking at the npmsw fetcher and discovered some
> >> challenges regarding the integration into the developer workflow as
> >> well as the build times within Bitbake. We believe that we found a
> >> mechanism which would integrate well into Bitbake's existing project
> >> structure and drastically improve the situation.
> >>
> >>
> >> But first, what are the issues with the current npmsw fetcher?
> >>
> >> 1. Let's have a look at a typical npm-based project. You'd typically
> >> have your package-lock.json (aka shrinkwrap file) stored within the git
> >> repository containing your source code. Developers will rely on this
> >> package-lock file on a daily basis during the development cycle.
> >> Unfortunately, the current npmsw fetcher only supports shrinkwrap files
> >> stored within the meta layer or within an npm registry. This is not
> >> ideal, as changes to the file might be made within the project repo,
> >> which then need to be manually applied to the lock file within the meta
> >> repo. An ideal npmsw fetcher therefore would support using the lock
> >> file directly from the source code repo.
>
> The package-lock.json and npm-shrinkwrap.json are identical. The only
> difference is that the npm-shrinkwrap.json could be published with the
> package.
>
> >> 2. The current implementation of the npm class uses multiple shellouts
> >> per npm module in order to add these to the npm cache. This is done, as
> >> the `npm install` command is not called within the do_fetch, but at the
> >> end of the do_configure step. This drastically increases the time
> >> Bitbake spends in the do_configure step for a npm based recipe. In our
> >> case (we have a relatively small project with approx. 600 npm packages
> >> in total, including recursive packages) this takes ~100 minutes to
> >> complete. What makes things worse, every change to the recipe and/or
> >> lock file will cause a complete rerun of the do_configure job.
>
> This is a problem of the sequential setup of the cache. I have a
> prototype to do this in a special bb task and use multiple parallel
> process task inside the bb task. But I have also a prototype which
> remove the complete cache and speed up the build significant.
>
> >> As a result, the npm fetcher currently is not really usable for
> >> production workloads.
>
> Ack.
>
> >> So how can we address these issues?
> >>
> >> We plan to implement a "sub-fetcher" for npmsw (a concept which might
> >> also be recyclable for similar use-cases). This would take the
> >> form of e.g.:
> >>
> >> SRC_URI = "npmsw+git://git-uri.git;npm-topdir=path_to_npm_project;..."
> >>
> >> The idea is, that the npsw fetcher would then call an arbitrary sub-
> >> fetcher (in this case git, however any fetcher will be supported) and
> >> after the sub-fetcher has extracted the source code into the DL_DIR,
> >> the npm fetcher will create a secondary download folder as a copy of
> >> the sub-fetchers download folder. Within this copy, the npm fetcher
> >> will call `npm ci`, effectively downloading the npm packages by doing a
> >> clean-install on the basis of the package.json and the package-
> >> lock.json files within the npmsw download dir. This results in a much
> >> faster build, as it removes the need for seperate handling of the
> >> individual node packages, as well as streamlining the developers
> >> workflow with the build process within Bitbake.
>
> How should this support the download proxy? The npm ci command need a
> repository or a cache to work.
>
> Furthermore you need a patch step in between the fetch steps to support
> tuning / fixing of the configuration before the second fetch step.
>
> >> As this fetcher would be implemented separately from the current npmsw
> >> fetcher, this will not cause any breaking changes for existing setups.
> >>
> >> Additionally, we plan on writing a separate npmsw.bbclass, which will
> >> parse the package.json for each node module for an automated Bitbake
> >> license manifest generation, which will resolve the current challenge
> >> of having to maintain these manually, as currently described at
> >>
> https://www.yoctoproject.org/docs/latest/mega-manual/mega-manual.html#npm-using-the-registry-modules-method
> >> .
>
> This licenses will be generated by the recipetool and you could provide
> checksums to detect the correct licenses.
>
> The license inside the package.json is only a hint and you need a
> license file to fulfill the license compliance. Because of this I remove
> the package.json from LIC_FILES_CHKSUM because it is useless for the
> license compliance.
>
>
> >> If this is something you see as a worthwhile goal, we will provide a
> >> set of patch files within the coming weeks.
>
> I think you mixed the unusable npm implementation with your special use
> case.
>
> The problem is that the current npm implementation isn't really usable.
> I'm working on this and have already a prototype that could install,
> build and *test* a proprietary angular project and node-red as well as
> koa/examples from github.
>
> If I understand you correct you like to build a npm recipe that could
> change it dependencies without update the recipe except the SRCREV of
> the repositories.
>
> > At a first read it sounds reasonable but I don't know the answers to a
> few
> > questions which make or break things from an OE/bitbake perspective.
> Those
> > questions are:
> >
> > a) Once DL_DIR has been populated by this fetch mechanism, can a
> subsequent
> > build run with just the data from there without accessing the network?
> >
> > b) Is the information encoded into SRC_URI enough to give a
> deterministic build
> > result, i.e. if we run this build at some later date, will we get the
> same
> > result?
> >
> > c) Is fetching only happening during the do_fetch task and not in any
> subsequent
> > step?
> >
> >
> > I'd love for some of the other people who're worked on this code to jump
> in as I
> > don't use it or understand it in detail. I am worried about how we
> maintain this
> > longer term as different people seem to have different use cases which
> sees the
> > code changing in different directions and we're starting to look like we
> may end
> > up with multiple ways of doing things which I really dislike.
>
> This leads to the questions what is the desired way to integrate a
> package / dependency manager. Nowadays any language (even C/C++) has a
> package manager available and more and more build systems (ex. Meson,
> CMake) support automatic download of dependencies. The common
> integration into OE is a script (recipetool) that generate a recipe
> from the foreign configuration. The current npm implementation is
> special because it reuse a foreign configuration and translate it into
> fetch commands on-the-fly. This leads to the problem that common tweaks
> like override a dependency or share configuration between recipes via
> include file isn't possible. We could fix it by removing the foreign
> configuration and do the translation during recipe creation. But this
> means you have to recreate the recipe after every dependency change.
>
> Is it a valid use case for OE to support foreign dependency
> configurations like npm-shrinkwrap.json, go.sum or conan.lock?
>
> Regards
>    Stefan
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#12885):
> https://lists.openembedded.org/g/bitbake-devel/message/12885
> Mute This Topic: https://lists.openembedded.org/mt/86814331/3618298
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> jeanmarie.lemetayer@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>
>

--000000000000de0c3205d008e31f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Jasper and folks,<div><br></div><div><=
div>I am the guy who updated the NPM support in bitbake last time. All your=
 remarks are correct, shrinkwarp=C2=A0file placement can be updated and the=
 do_configure step is a real pain. But this is the only way I found which f=
ollows the bitbake requirements.</div></div><div><br></div><div>For the &#3=
9;access to network&#39; thing, be careful with NPM because there are some =
corner cases when NPM tries to access it without permissions (node-gyp if I=
 remember=C2=A0well). I was doing my test builds with my RJ45 unplugged to =
be sure.</div><div><br></div><div>The fact that the NPM workflow=C2=A0is to=
tally not the same as the Bitbake one is the real issue. I think the best s=
olution could be to make some improvements to NPM directly so it can fit be=
tter in an environment=C2=A0like Bitbake (maybe a new fetch=C2=A0command).<=
/div><div><br></div><div>Best regards and good luck,</div><div>Jean-Marie</=
div><div><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" cl=
ass=3D"gmail_attr">On Fri, Nov 5, 2021 at 2:07 AM Stefan Herbrechtsmeier &l=
t;<a href=3D"mailto:stefan.herbrechtsmeier-oss@weidmueller.com">stefan.herb=
rechtsmeier-oss@weidmueller.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">Hi Jasper and Richard,<br>
<br>
Am 05.11.2021 um 00:15 schrieb Richard Purdie via <a href=3D"http://lists.o=
penembedded.org" rel=3D"noreferrer" target=3D"_blank">lists.openembedded.or=
g</a>:<br>
&gt; On Thu, 2021-11-04 at 12:29 +0000, Jasper Orschulko wrote:<br>
&gt;&gt; Dear Bitbake developers,<br>
&gt;&gt;<br>
&gt;&gt; recently we have been looking at the npmsw fetcher and discovered =
some<br>
&gt;&gt; challenges regarding the integration into the developer workflow a=
s<br>
&gt;&gt; well as the build times within Bitbake. We believe that we found a=
<br>
&gt;&gt; mechanism which would integrate well into Bitbake&#39;s existing p=
roject<br>
&gt;&gt; structure and drastically improve the situation.<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; But first, what are the issues with the current npmsw fetcher?<br>
&gt;&gt;<br>
&gt;&gt; 1. Let&#39;s have a look at a typical npm-based project. You&#39;d=
 typically<br>
&gt;&gt; have your package-lock.json (aka shrinkwrap file) stored within th=
e git<br>
&gt;&gt; repository containing your source code. Developers will rely on th=
is<br>
&gt;&gt; package-lock file on a daily basis during the development cycle.<b=
r>
&gt;&gt; Unfortunately, the current npmsw fetcher only supports shrinkwrap =
files<br>
&gt;&gt; stored within the meta layer or within an npm registry. This is no=
t<br>
&gt;&gt; ideal, as changes to the file might be made within the project rep=
o,<br>
&gt;&gt; which then need to be manually applied to the lock file within the=
 meta<br>
&gt;&gt; repo. An ideal npmsw fetcher therefore would support using the loc=
k<br>
&gt;&gt; file directly from the source code repo.<br>
<br>
The package-lock.json and npm-shrinkwrap.json are identical. The only <br>
difference is that the npm-shrinkwrap.json could be published with the <br>
package.<br>
<br>
&gt;&gt; 2. The current implementation of the npm class uses multiple shell=
outs<br>
&gt;&gt; per npm module in order to add these to the npm cache. This is don=
e, as<br>
&gt;&gt; the `npm install` command is not called within the do_fetch, but a=
t the<br>
&gt;&gt; end of the do_configure step. This drastically increases the time<=
br>
&gt;&gt; Bitbake spends in the do_configure step for a npm based recipe. In=
 our<br>
&gt;&gt; case (we have a relatively small project with approx. 600 npm pack=
ages<br>
&gt;&gt; in total, including recursive packages) this takes ~100 minutes to=
<br>
&gt;&gt; complete. What makes things worse, every change to the recipe and/=
or<br>
&gt;&gt; lock file will cause a complete rerun of the do_configure job.<br>
<br>
This is a problem of the sequential setup of the cache. I have a <br>
prototype to do this in a special bb task and use multiple parallel <br>
process task inside the bb task. But I have also a prototype which <br>
remove the complete cache and speed up the build significant.<br>
<br>
&gt;&gt; As a result, the npm fetcher currently is not really usable for<br=
>
&gt;&gt; production workloads.<br>
<br>
Ack.<br>
<br>
&gt;&gt; So how can we address these issues?<br>
&gt;&gt;<br>
&gt;&gt; We plan to implement a &quot;sub-fetcher&quot; for npmsw (a concep=
t which might<br>
&gt;&gt; also be recyclable for similar use-cases). This would take the<br>
&gt;&gt; form of e.g.:<br>
&gt;&gt;<br>
&gt;&gt; SRC_URI =3D &quot;npmsw+git://git-uri.git;npm-topdir=3Dpath_to_npm=
_project;...&quot;<br>
&gt;&gt;<br>
&gt;&gt; The idea is, that the npsw fetcher would then call an arbitrary su=
b-<br>
&gt;&gt; fetcher (in this case git, however any fetcher will be supported) =
and<br>
&gt;&gt; after the sub-fetcher has extracted the source code into the DL_DI=
R,<br>
&gt;&gt; the npm fetcher will create a secondary download folder as a copy =
of<br>
&gt;&gt; the sub-fetchers download folder. Within this copy, the npm fetche=
r<br>
&gt;&gt; will call `npm ci`, effectively downloading the npm packages by do=
ing a<br>
&gt;&gt; clean-install on the basis of the package.json and the package-<br=
>
&gt;&gt; lock.json files within the npmsw download dir. This results in a m=
uch<br>
&gt;&gt; faster build, as it removes the need for seperate handling of the<=
br>
&gt;&gt; individual node packages, as well as streamlining the developers<b=
r>
&gt;&gt; workflow with the build process within Bitbake.<br>
<br>
How should this support the download proxy? The npm ci command need a <br>
repository or a cache to work.<br>
<br>
Furthermore you need a patch step in between the fetch steps to support <br=
>
tuning / fixing of the configuration before the second fetch step.<br>
<br>
&gt;&gt; As this fetcher would be implemented separately from the current n=
pmsw<br>
&gt;&gt; fetcher, this will not cause any breaking changes for existing set=
ups.<br>
&gt;&gt;<br>
&gt;&gt; Additionally, we plan on writing a separate npmsw.bbclass, which w=
ill<br>
&gt;&gt; parse the package.json for each node module for an automated Bitba=
ke<br>
&gt;&gt; license manifest generation, which will resolve the current challe=
nge<br>
&gt;&gt; of having to maintain these manually, as currently described at<br=
>
&gt;&gt; <a href=3D"https://www.yoctoproject.org/docs/latest/mega-manual/me=
ga-manual.html#npm-using-the-registry-modules-method" rel=3D"noreferrer" ta=
rget=3D"_blank">https://www.yoctoproject.org/docs/latest/mega-manual/mega-m=
anual.html#npm-using-the-registry-modules-method</a><br>
&gt;&gt; .<br>
<br>
This licenses will be generated by the recipetool and you could provide <br=
>
checksums to detect the correct licenses.<br>
<br>
The license inside the package.json is only a hint and you need a <br>
license file to fulfill the license compliance. Because of this I remove <b=
r>
the package.json from LIC_FILES_CHKSUM because it is useless for the <br>
license compliance.<br>
<br>
<br>
&gt;&gt; If this is something you see as a worthwhile goal, we will provide=
 a<br>
&gt;&gt; set of patch files within the coming weeks.<br>
<br>
I think you mixed the unusable npm implementation with your special use <br=
>
case.<br>
<br>
The problem is that the current npm implementation isn&#39;t really usable.=
 <br>
I&#39;m working on this and have already a prototype that could install, <b=
r>
build and *test* a proprietary angular project and node-red as well as <br>
koa/examples from github.<br>
<br>
If I understand you correct you like to build a npm recipe that could <br>
change it dependencies without update the recipe except the SRCREV of <br>
the repositories.<br>
<br>
&gt; At a first read it sounds reasonable but I don&#39;t know the answers =
to a few<br>
&gt; questions which make or break things from an OE/bitbake perspective. T=
hose<br>
&gt; questions are:<br>
&gt; <br>
&gt; a) Once DL_DIR has been populated by this fetch mechanism, can a subse=
quent<br>
&gt; build run with just the data from there without accessing the network?=
<br>
&gt; <br>
&gt; b) Is the information encoded into SRC_URI enough to give a determinis=
tic build<br>
&gt; result, i.e. if we run this build at some later date, will we get the =
same<br>
&gt; result?<br>
&gt; <br>
&gt; c) Is fetching only happening during the do_fetch task and not in any =
subsequent<br>
&gt; step?<br>
&gt; <br>
&gt; <br>
&gt; I&#39;d love for some of the other people who&#39;re worked on this co=
de to jump in as I<br>
&gt; don&#39;t use it or understand it in detail. I am worried about how we=
 maintain this<br>
&gt; longer term as different people seem to have different use cases which=
 sees the<br>
&gt; code changing in different directions and we&#39;re starting to look l=
ike we may end<br>
&gt; up with multiple ways of doing things which I really dislike.<br>
<br>
This leads to the questions what is the desired way to integrate a <br>
package / dependency manager. Nowadays any language (even C/C++) has a <br>
package manager available and more and more build systems (ex. Meson, <br>
CMake) support automatic download of dependencies. The common <br>
integration into OE is a script (recipetool) that generate a recipe <br>
from the foreign configuration. The current npm implementation is <br>
special because it reuse a foreign configuration and translate it into <br>
fetch commands on-the-fly. This leads to the problem that common tweaks <br=
>
like override a dependency or share configuration between recipes via <br>
include file isn&#39;t possible. We could fix it by removing the foreign <b=
r>
configuration and do the translation during recipe creation. But this <br>
means you have to recreate the recipe after every dependency change.<br>
<br>
Is it a valid use case for OE to support foreign dependency <br>
configurations like npm-shrinkwrap.json, go.sum or conan.lock?<br>
<br>
Regards<br>
=C2=A0 =C2=A0Stefan<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#12885): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/12885" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/12885</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/86814331/3618=
298" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/mt=
/86814331/3618298</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:jeanmarie.lemetayer@gmail.com" tar=
get=3D"_blank">jeanmarie.lemetayer@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div></div>

--000000000000de0c3205d008e31f--

