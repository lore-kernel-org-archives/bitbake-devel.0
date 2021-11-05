Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF57C433F5
	for <webhook@archiver.kernel.org>; Fri,  5 Nov 2021 17:43:10 +0000 (UTC)
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com
 [209.85.221.177])
 by mx.groups.io with SMTP id smtpd.web10.9036.1636134189426291203
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Nov 2021 10:43:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=E0tr2f5G;
 spf=pass (domain: gmail.com, ip: 209.85.221.177,
 mailfrom: alex.kanavin@gmail.com)
Received: by mail-vk1-f177.google.com with SMTP id h133so4971650vke.10
        for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Nov 2021 10:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r4p5N333jsHsUtScQxhC97StV7EruoO8CzHH1PA8n7o=;
        b=E0tr2f5GqE1R+c3rAuwPPYvCQuNfVWazXp9YHaz7bGNwvVsvZ0y8j6cImbE3xpw8z4
         aKbZ4lQuikubSngbKrePcYwAO9PruefuTFtLxG0KZCKj6B22C7gNMJFBzkmSiInNH+Fx
         qEVd1YgITvF9tICCdPD7AU950emgPunyFNZXHMMrbSn4eTcZqBM9TbdZ8p9qdJGVomXC
         LViZxxyi62awbUIsqdGZppT/f+bJwePeKK9pHLu/SZogwKBptsEJGE/as2mNFcrdYxRv
         0bVtoY3O/rRGl2S4pKo0GA0d1hyQv6Tp71ZEH9nCbJrEB7JD0iN1nJPhynJHRC/5AqiH
         /GRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r4p5N333jsHsUtScQxhC97StV7EruoO8CzHH1PA8n7o=;
        b=5WlwqEsym1gVxOwJPDI4dvLiwIyHoSwx7apEQOciYMyNQ/PKtAx2oJC2BgLfYlCdGE
         +9jJ/AePG3lPEiLdimp9DLTsMXn62M4cUrlVZwVQWq6gz26IuXVnJAcCq19U6TDZ60ip
         5qmONymuHIQq4K3ZU5TkjNCR9EYjVQvrKZUdgCteJnQ9MRrHjbsTnXZHmDfWBkqAvyqf
         PeB7Z2AxgMPsL/+qB43cjY//HfaxF515ckH3wjM/1oHwHk1HxK2eOin48HJix2bwFyD2
         Dh2blY9qnLRXtnOy8KgooDS3qC8/VlT766bFn2oBA7Q919JDLXh4ciUKV2OgPUoYqHJI
         7ZtQ==
X-Gm-Message-State: AOAM5314uuKZx41jwystJXpfNFWU1wlMviRX1pee1JyUPT/JBBy3eA1J
	5YYqDZnw6viKdb7vt2w7cdLkV/Dhysdqx1XuCIU=
X-Google-Smtp-Source: 
 ABdhPJxakVwfalTBcvS9gHG80QFB4s5tG5XA+JUcb+AAe2uPNJYt1NvgONzC10IsAjjyTd7Y3exJhStE5T5scq7g3Jo=
X-Received: by 2002:a05:6122:a18:: with SMTP id
 24mr59680616vkn.6.1636134188369;
 Fri, 05 Nov 2021 10:43:08 -0700 (PDT)
MIME-Version: 1.0
References: <1c7d6bb2479af789132b3e94c44a54f1d1b5c304.camel@iris-sensing.com>
 <0b63fba531fc94bbe915dfc9915c0a2f42ad3ce9.camel@linuxfoundation.org>
 <42a0350d-991a-731d-29c2-83cd62da8c7b@weidmueller.com>
 <CAAdc0hwA12CiWHCXQV=MBHv-h=vopK7of3CUViR58fJ8k2rK1g@mail.gmail.com>
 <3556fec928b8b3f86c1a08b3cb4e2a2fb708cc9c.camel@iris-sensing.com>
In-Reply-To: <3556fec928b8b3f86c1a08b3cb4e2a2fb708cc9c.camel@iris-sensing.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 5 Nov 2021 18:42:57 +0100
Message-ID: 
 <CANNYZj9HgB29QnXcqt9ymJiJka6QRu3kERZ3gfEgqV5ZfOACOQ@mail.gmail.com>
Subject: Re: [bitbake-devel] Improving npm(sw) fetcher & integration within
 Bitbake
To: Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>
Cc: "stefan.herbrechtsmeier-oss@weidmueller.com"
 <stefan.herbrechtsmeier-oss@weidmueller.com>,
	"jeanmarie.lemetayer@gmail.com" <jeanmarie.lemetayer@gmail.com>,
	"richard.purdie@linuxfoundation.org" <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org"
 <bitbake-devel@lists.openembedded.org>, "martin@mko.dev" <martin@mko.dev>,
	Daniel Baumgart <Daniel.Baumgart@iris-sensing.com>
Content-Type: multipart/alternative; boundary="0000000000001a49c305d00e2d68"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 05 Nov 2021 17:43:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12915

--0000000000001a49c305d00e2d68
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For what it's worth (food for thought wise) I've written an essay a while
ago on the subject:

https://www.yoctoproject.org/pipermail/yocto/2017-March/035028.html
https://www.yoctoproject.org/pipermail/yocto/2017-March/035029.html

Alex

On Fri, 5 Nov 2021 at 17:02, Jasper Orschulko <
Jasper.Orschulko@iris-sensing.com> wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA256
>
> Thanks @all for your input.
>
> It seems like there is a lot to be considered. When it comes to under-
> the-hood development, the yocto project is fairly new to Martin and
> myself. The term "bitbake requirements" has been used more than once in
> this conversation, yet I am currently not aware of any formal
> requirements. You wouldn't happen to have some documentation on this by
> any chance? A common understanding of this and the actual usecases for
> npm would be great, before we go into further details on how a possible
> solution might look like.
>
> - --
> With best regards
>
> Jasper Orschulko
> DevOps Engineer
>
> Tel. +49 30 58 58 14 265
> Fax +49 30 58 58 14 999
> Jasper.Orschulko@iris-sensing.com
>
> =E2=80=A2 =E2=80=A2 =E2=80=A2 =E2=80=A2 =E2=80=A2 =E2=80=A2 =E2=80=A2 =E2=
=80=A2 =E2=80=A2 =E2=80=A2 =E2=80=A2 =E2=80=A2 =E2=80=A2 =E2=80=A2 =E2=80=
=A2 =E2=80=A2 =E2=80=A2 =E2=80=A2 =E2=80=A2 =E2=80=A2 =E2=80=A2 =E2=80=A2 =
=E2=80=A2 =E2=80=A2 =E2=80=A2 =E2=80=A2
>
> iris-GmbH
> infrared & intelligent sensors
> Schnellerstra=C3=9Fe 1-5 | 12439 Berlin
>
> https://iris-sensing.com/
>
>
>
>
>
> On Fri, 2021-11-05 at 04:24 -0700, Jean-Marie Lemetayer wrote:
> > Hi Jasper and folks,
> >
> > I am the guy who updated the NPM support in bitbake last time. All
> > your remarks are correct, shrinkwarp file placement can be updated
> > and the do_configure step is a real pain. But this is the only way I
> > found which follows the bitbake requirements.
> >
> > For the 'access to network' thing, be careful with NPM because there
> > are some corner cases when NPM tries to access it without permissions
> > (node-gyp if I remember well). I was doing my test builds with my
> > RJ45 unplugged to be sure.
> >
> > The fact that the NPM workflow is totally not the same as the Bitbake
> > one is the real issue. I think the best solution could be to make
> > some improvements to NPM directly so it can fit better in an
> > environment like Bitbake (maybe a new fetch command).
> >
> > Best regards and good luck,
> > Jean-Marie
> >
> >
> > On Fri, Nov 5, 2021 at 2:07 AM Stefan Herbrechtsmeier
> > <stefan.herbrechtsmeier-oss@weidmueller.com> wrote:
> > > Hi Jasper and Richard,
> > >
> > > Am 05.11.2021 um 00:15 schrieb Richard Purdie via
> > > lists.openembedded.org:
> > > > On Thu, 2021-11-04 at 12:29 +0000, Jasper Orschulko wrote:
> > > > > Dear Bitbake developers,
> > > > >
> > > > > recently we have been looking at the npmsw fetcher and
> > > > > discovered
> > > some
> > > > > challenges regarding the integration into the developer
> > > > > workflow
> > > as
> > > > > well as the build times within Bitbake. We believe that we
> > > > > found a
> > > > > mechanism which would integrate well into Bitbake's existing
> > > project
> > > > > structure and drastically improve the situation.
> > > > >
> > > > >
> > > > > But first, what are the issues with the current npmsw fetcher?
> > > > >
> > > > > 1. Let's have a look at a typical npm-based project. You'd
> > > typically
> > > > > have your package-lock.json (aka shrinkwrap file) stored within
> > > the git
> > > > > repository containing your source code. Developers will rely on
> > > this
> > > > > package-lock file on a daily basis during the development
> > > > > cycle.
> > > > > Unfortunately, the current npmsw fetcher only supports
> > > > > shrinkwrap
> > > files
> > > > > stored within the meta layer or within an npm registry. This is
> > > not
> > > > > ideal, as changes to the file might be made within the project
> > > repo,
> > > > > which then need to be manually applied to the lock file within
> > > > > the
> > > meta
> > > > > repo. An ideal npmsw fetcher therefore would support using the
> > > lock
> > > > > file directly from the source code repo.
> > >
> > > The package-lock.json and npm-shrinkwrap.json are identical. The
> > > only
> > > difference is that the npm-shrinkwrap.json could be published with
> > > the
> > > package.
> > >
> > > > > 2. The current implementation of the npm class uses multiple
> > > shellouts
> > > > > per npm module in order to add these to the npm cache. This is
> > > done, as
> > > > > the `npm install` command is not called within the do_fetch,
> > > > > but
> > > at the
> > > > > end of the do_configure step. This drastically increases the
> > > > > time
> > > > > Bitbake spends in the do_configure step for a npm based recipe.
> > > > > In
> > > our
> > > > > case (we have a relatively small project with approx. 600 npm
> > > packages
> > > > > in total, including recursive packages) this takes ~100 minutes
> > > > > to
> > > > > complete. What makes things worse, every change to the recipe
> > > and/or
> > > > > lock file will cause a complete rerun of the do_configure job.
> > >
> > > This is a problem of the sequential setup of the cache. I have a
> > > process task inside the bb task. But I have also a prototype which
> > > remove the complete cache and speed up the build significant.
> > >
> > > > > As a result, the npm fetcher currently is not really usable for
> > > > > production workloads.
> > >
> > > Ack.
> > >
> > > > > So how can we address these issues?
> > > > >
> > > > > We plan to implement a "sub-fetcher" for npmsw (a concept which
> > > might
> > > > > also be recyclable for similar use-cases). This would take the
> > > > > form of e.g.:
> > > > >
> > > > > SRC_URI =3D "npmsw+git://git-uri.git;npm-
> > > topdir=3Dpath_to_npm_project;..."
> > > > >
> > > > > The idea is, that the npsw fetcher would then call an arbitrary
> > > sub-
> > > > > fetcher (in this case git, however any fetcher will be
> > > > > supported)
> > > and
> > > > > after the sub-fetcher has extracted the source code into the
> > > DL_DIR,
> > > > > the npm fetcher will create a secondary download folder as a
> > > > > copy
> > > of
> > > > > the sub-fetchers download folder. Within this copy, the npm
> > > fetcher
> > > > > will call `npm ci`, effectively downloading the npm packages by
> > > doing a
> > > > > clean-install on the basis of the package.json and the package-
> > > > > lock.json files within the npmsw download dir. This results in
> > > > > a
> > > much
> > > > > faster build, as it removes the need for seperate handling of
> > > > > the
> > > > > individual node packages, as well as streamlining the
> > > > > developers
> > > > > workflow with the build process within Bitbake.
> > >
> > > How should this support the download proxy? The npm ci command need
> > > a
> > > repository or a cache to work.
> > >
> > > Furthermore you need a patch step in between the fetch steps to
> > > support
> > > tuning / fixing of the configuration before the second fetch step.
> > >
> > > > > As this fetcher would be implemented separately from the
> > > > > current
> > > npmsw
> > > > > fetcher, this will not cause any breaking changes for existing
> > > setups.
> > > > >
> > > > > Additionally, we plan on writing a separate npmsw.bbclass,
> > > > > which
> > > will
> > > > > parse the package.json for each node module for an automated
> > > Bitbake
> > > > > license manifest generation, which will resolve the current
> > > challenge
> > > > > of having to maintain these manually, as currently described at
> > > > >
> > >
> https://www.yoctoproject.org/docs/latest/mega-manual/mega-manual.html#npm=
-using-the-registry-modules-method
> > > > > .
> > >
> > > This licenses will be generated by the recipetool and you could
> > > provide
> > > checksums to detect the correct licenses.
> > >
> > > The license inside the package.json is only a hint and you need a
> > > license file to fulfill the license compliance. Because of this I
> > > remove
> > > the package.json from LIC_FILES_CHKSUM because it is useless for
> > > the
> > > license compliance.
> > >
> > >
> > > > > If this is something you see as a worthwhile goal, we will
> > > > > provide
> > > a
> > > > > set of patch files within the coming weeks.
> > >
> > > I think you mixed the unusable npm implementation with your special
> > > use
> > > case.
> > >
> > > The problem is that the current npm implementation isn't really
> > > usable.
> > > I'm working on this and have already a prototype that could
> > > install,
> > > build and *test* a proprietary angular project and node-red as well
> > > as
> > > koa/examples from github.
> > >
> > > If I understand you correct you like to build a npm recipe that
> > > could
> > > change it dependencies without update the recipe except the SRCREV
> > > of
> > > the repositories.
> > >
> > > > At a first read it sounds reasonable but I don't know the answers
> > > to a few
> > > > questions which make or break things from an OE/bitbake
> > > perspective. Those
> > > > questions are:
> > > >
> > > > a) Once DL_DIR has been populated by this fetch mechanism, can a
> > > subsequent
> > > > build run with just the data from there without accessing the
> > > network?
> > > >
> > > > b) Is the information encoded into SRC_URI enough to give a
> > > deterministic build
> > > > result, i.e. if we run this build at some later date, will we get
> > > the same
> > > > result?
> > > >
> > > > c) Is fetching only happening during the do_fetch task and not in
> > > any subsequent
> > > > step?
> > > >
> > > >
> > > > I'd love for some of the other people who're worked on this code
> > > > to
> > > jump in as I
> > > > don't use it or understand it in detail. I am worried about how
> > > > we
> > > maintain this
> > > > longer term as different people seem to have different use cases
> > > which sees the
> > > > code changing in different directions and we're starting to look
> > > like we may end
> > > > up with multiple ways of doing things which I really dislike.
> > >
> > > This leads to the questions what is the desired way to integrate a
> > > package / dependency manager. Nowadays any language (even C/C++)
> > > has
> > > a
> > > package manager available and more and more build systems (ex.
> > > Meson,
> > > CMake) support automatic download of dependencies. The common
> > > from the foreign configuration. The current npm implementation is
> > > special because it reuse a foreign configuration and translate it
> > > into
> > > fetch commands on-the-fly. This leads to the problem that common
> > > tweaks
> > > like override a dependency or share configuration between recipes
> > > via
> > > include file isn't possible. We could fix it by removing the
> > > foreign
> > > configuration and do the translation during recipe creation. But
> > > this
> > > means you have to recreate the recipe after every dependency
> > > change.
> > >
> > > Is it a valid use case for OE to support foreign dependency
> > > configurations like npm-shrinkwrap.json, go.sum or conan.lock?
> > >
> > > Regards
> > >    Stefan
> > >
> > >
> > >
> -----BEGIN PGP SIGNATURE-----
>
> iQEzBAEBCAAdFiEE4WyPMIC5Ap4+Ooo1Ygqew07VMNUFAmGFVaUACgkQYgqew07V
> MNX4NQf+PwyOaBwFeWY/IKWhUfTswHKOkMDubyJnvTM0eRuNiJ+a6GNZo0ZXe/8v
> 7ozIwTIJShu/roimQff9K44HNjyvZJVC3hMeBUY9VS75RUliAJa48Vo71P57CtXD
> ysuTg9hDaPicDA228pljFTHGk+SgLVUkAtgAw0J4URwJyfqoquzRXckt3s7A5/Nm
> K3/SZg7FOS4D8bjWLwZvlSX4NVWswb478ct00JL0hdJv6I/Hnr+KBpKXG6OE0+Dj
> x2lple1BxDmLcOoUsbvXroojGQNqIi4iYcxbkkvQqFmL/zb9r3MKv5h2VipbNLIC
> E3Hdk2iFsXSOnf2Eo1RB3Hy4EwYoSQ=3D=3D
> =3DrOen
> -----END PGP SIGNATURE-----
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#12911):
> https://lists.openembedded.org/g/bitbake-devel/message/12911
> Mute This Topic: https://lists.openembedded.org/mt/86814331/1686489
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> alex.kanavin@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--0000000000001a49c305d00e2d68
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>For what it&#39;s worth (food for thought wise) I&#39=
;ve written an essay a while ago on the subject:</div><div><br></div><div><=
a href=3D"https://www.yoctoproject.org/pipermail/yocto/2017-March/035028.ht=
ml">https://www.yoctoproject.org/pipermail/yocto/2017-March/035028.html</a>=
</div><div><a href=3D"https://www.yoctoproject.org/pipermail/yocto/2017-Mar=
ch/035029.html">https://www.yoctoproject.org/pipermail/yocto/2017-March/035=
029.html</a></div><div><br></div><div>Alex<br></div></div><br><div class=3D=
"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, 5 Nov 2021 at 1=
7:02, Jasper Orschulko &lt;<a href=3D"mailto:Jasper.Orschulko@iris-sensing.=
com">Jasper.Orschulko@iris-sensing.com</a>&gt; wrote:<br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">-----BEGIN PGP SIGNED MESSAGE-----<br=
>
Hash: SHA256<br>
<br>
Thanks @all for your input.<br>
<br>
It seems like there is a lot to be considered. When it comes to under-<br>
the-hood development, the yocto project is fairly new to Martin and<br>
myself. The term &quot;bitbake requirements&quot; has been used more than o=
nce in<br>
this conversation, yet I am currently not aware of any formal<br>
requirements. You wouldn&#39;t happen to have some documentation on this by=
<br>
any chance? A common understanding of this and the actual usecases for<br>
npm would be great, before we go into further details on how a possible<br>
solution might look like.<br>
<br>
- -- <br>
With best regards<br>
<br>
Jasper Orschulko<br>
DevOps Engineer<br>
<br>
Tel. +49 30 58 58 14 265<br>
Fax +49 30 58 58 14 999<br>
<a href=3D"mailto:Jasper.Orschulko@iris-sensing.com" target=3D"_blank">Jasp=
er.Orschulko@iris-sensing.com</a><br>
<br>
=E2=80=A2 =E2=80=A2 =E2=80=A2 =E2=80=A2 =E2=80=A2 =E2=80=A2 =E2=80=A2 =E2=
=80=A2 =E2=80=A2 =E2=80=A2 =E2=80=A2 =E2=80=A2 =E2=80=A2 =E2=80=A2 =E2=80=
=A2 =E2=80=A2 =E2=80=A2 =E2=80=A2 =E2=80=A2 =E2=80=A2 =E2=80=A2 =E2=80=A2 =
=E2=80=A2 =E2=80=A2 =E2=80=A2 =E2=80=A2<br>
<br>
iris-GmbH<br>
infrared &amp; intelligent sensors<br>
Schnellerstra=C3=9Fe 1-5 | 12439 Berlin<br>
<br>
<a href=3D"https://iris-sensing.com/" rel=3D"noreferrer" target=3D"_blank">=
https://iris-sensing.com/</a><br>
<br>
<br>
<br>
<br>
<br>
On Fri, 2021-11-05 at 04:24 -0700, Jean-Marie Lemetayer wrote:<br>
&gt; Hi Jasper and folks,<br>
&gt; <br>
&gt; I am the guy who updated the NPM support in bitbake last time. All<br>
&gt; your remarks are correct, shrinkwarp=C2=A0file placement can be update=
d<br>
&gt; and the do_configure step is a real pain. But this is the only way I<b=
r>
&gt; found which follows the bitbake requirements.<br>
&gt; <br>
&gt; For the &#39;access to network&#39; thing, be careful with NPM because=
 there<br>
&gt; are some corner cases when NPM tries to access it without permissions<=
br>
&gt; (node-gyp if I remember=C2=A0well). I was doing my test builds with my=
<br>
&gt; RJ45 unplugged to be sure.<br>
&gt; <br>
&gt; The fact that the NPM workflow=C2=A0is totally not the same as the Bit=
bake<br>
&gt; one is the real issue. I think the best solution could be to make<br>
&gt; some improvements to NPM directly so it can fit better in an<br>
&gt; environment=C2=A0like Bitbake (maybe a new fetch=C2=A0command).<br>
&gt; <br>
&gt; Best regards and good luck,<br>
&gt; Jean-Marie<br>
&gt; <br>
&gt; <br>
&gt; On Fri, Nov 5, 2021 at 2:07 AM Stefan Herbrechtsmeier<br>
&gt; &lt;<a href=3D"mailto:stefan.herbrechtsmeier-oss@weidmueller.com" targ=
et=3D"_blank">stefan.herbrechtsmeier-oss@weidmueller.com</a>&gt; wrote:<br>
&gt; &gt; Hi Jasper and Richard,<br>
&gt; &gt; <br>
&gt; &gt; Am 05.11.2021 um 00:15 schrieb Richard Purdie via<br>
&gt; &gt; <a href=3D"http://lists.openembedded.org" rel=3D"noreferrer" targ=
et=3D"_blank">lists.openembedded.org</a>:<br>
&gt; &gt; &gt; On Thu, 2021-11-04 at 12:29 +0000, Jasper Orschulko wrote:<b=
r>
&gt; &gt; &gt; &gt; Dear Bitbake developers,<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; recently we have been looking at the npmsw fetcher and<=
br>
&gt; &gt; &gt; &gt; discovered<br>
&gt; &gt; some<br>
&gt; &gt; &gt; &gt; challenges regarding the integration into the developer=
<br>
&gt; &gt; &gt; &gt; workflow<br>
&gt; &gt; as<br>
&gt; &gt; &gt; &gt; well as the build times within Bitbake. We believe that=
 we<br>
&gt; &gt; &gt; &gt; found a<br>
&gt; &gt; &gt; &gt; mechanism which would integrate well into Bitbake&#39;s=
 existing<br>
&gt; &gt; project<br>
&gt; &gt; &gt; &gt; structure and drastically improve the situation.<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; But first, what are the issues with the current npmsw f=
etcher?<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; 1. Let&#39;s have a look at a typical npm-based project=
. You&#39;d<br>
&gt; &gt; typically<br>
&gt; &gt; &gt; &gt; have your package-lock.json (aka shrinkwrap file) store=
d within<br>
&gt; &gt; the git<br>
&gt; &gt; &gt; &gt; repository containing your source code. Developers will=
 rely on<br>
&gt; &gt; this<br>
&gt; &gt; &gt; &gt; package-lock file on a daily basis during the developme=
nt<br>
&gt; &gt; &gt; &gt; cycle.<br>
&gt; &gt; &gt; &gt; Unfortunately, the current npmsw fetcher only supports<=
br>
&gt; &gt; &gt; &gt; shrinkwrap<br>
&gt; &gt; files<br>
&gt; &gt; &gt; &gt; stored within the meta layer or within an npm registry.=
 This is<br>
&gt; &gt; not<br>
&gt; &gt; &gt; &gt; ideal, as changes to the file might be made within the =
project<br>
&gt; &gt; repo,<br>
&gt; &gt; &gt; &gt; which then need to be manually applied to the lock file=
 within<br>
&gt; &gt; &gt; &gt; the<br>
&gt; &gt; meta<br>
&gt; &gt; &gt; &gt; repo. An ideal npmsw fetcher therefore would support us=
ing the<br>
&gt; &gt; lock<br>
&gt; &gt; &gt; &gt; file directly from the source code repo.<br>
&gt; &gt; <br>
&gt; &gt; The package-lock.json and npm-shrinkwrap.json are identical. The<=
br>
&gt; &gt; only<br>
&gt; &gt; difference is that the npm-shrinkwrap.json could be published wit=
h<br>
&gt; &gt; the <br>
&gt; &gt; package.<br>
&gt; &gt; <br>
&gt; &gt; &gt; &gt; 2. The current implementation of the npm class uses mul=
tiple<br>
&gt; &gt; shellouts<br>
&gt; &gt; &gt; &gt; per npm module in order to add these to the npm cache. =
This is<br>
&gt; &gt; done, as<br>
&gt; &gt; &gt; &gt; the `npm install` command is not called within the do_f=
etch,<br>
&gt; &gt; &gt; &gt; but<br>
&gt; &gt; at the<br>
&gt; &gt; &gt; &gt; end of the do_configure step. This drastically increase=
s the<br>
&gt; &gt; &gt; &gt; time<br>
&gt; &gt; &gt; &gt; Bitbake spends in the do_configure step for a npm based=
 recipe.<br>
&gt; &gt; &gt; &gt; In<br>
&gt; &gt; our<br>
&gt; &gt; &gt; &gt; case (we have a relatively small project with approx. 6=
00 npm<br>
&gt; &gt; packages<br>
&gt; &gt; &gt; &gt; in total, including recursive packages) this takes ~100=
 minutes<br>
&gt; &gt; &gt; &gt; to<br>
&gt; &gt; &gt; &gt; complete. What makes things worse, every change to the =
recipe<br>
&gt; &gt; and/or<br>
&gt; &gt; &gt; &gt; lock file will cause a complete rerun of the do_configu=
re job.<br>
&gt; &gt; <br>
&gt; &gt; This is a problem of the sequential setup of the cache. I have a =
<br>
&gt; &gt; process task inside the bb task. But I have also a prototype whic=
h <br>
&gt; &gt; remove the complete cache and speed up the build significant.<br>
&gt; &gt; <br>
&gt; &gt; &gt; &gt; As a result, the npm fetcher currently is not really us=
able for<br>
&gt; &gt; &gt; &gt; production workloads.<br>
&gt; &gt; <br>
&gt; &gt; Ack.<br>
&gt; &gt; <br>
&gt; &gt; &gt; &gt; So how can we address these issues?<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; We plan to implement a &quot;sub-fetcher&quot; for npms=
w (a concept which<br>
&gt; &gt; might<br>
&gt; &gt; &gt; &gt; also be recyclable for similar use-cases). This would t=
ake the<br>
&gt; &gt; &gt; &gt; form of e.g.:<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; SRC_URI =3D &quot;npmsw+git://git-uri.git;npm-<br>
&gt; &gt; topdir=3Dpath_to_npm_project;...&quot;<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; The idea is, that the npsw fetcher would then call an a=
rbitrary<br>
&gt; &gt; sub-<br>
&gt; &gt; &gt; &gt; fetcher (in this case git, however any fetcher will be<=
br>
&gt; &gt; &gt; &gt; supported)<br>
&gt; &gt; and<br>
&gt; &gt; &gt; &gt; after the sub-fetcher has extracted the source code int=
o the<br>
&gt; &gt; DL_DIR,<br>
&gt; &gt; &gt; &gt; the npm fetcher will create a secondary download folder=
 as a<br>
&gt; &gt; &gt; &gt; copy<br>
&gt; &gt; of<br>
&gt; &gt; &gt; &gt; the sub-fetchers download folder. Within this copy, the=
 npm<br>
&gt; &gt; fetcher<br>
&gt; &gt; &gt; &gt; will call `npm ci`, effectively downloading the npm pac=
kages by<br>
&gt; &gt; doing a<br>
&gt; &gt; &gt; &gt; clean-install on the basis of the package.json and the =
package-<br>
&gt; &gt; &gt; &gt; lock.json files within the npmsw download dir. This res=
ults in<br>
&gt; &gt; &gt; &gt; a<br>
&gt; &gt; much<br>
&gt; &gt; &gt; &gt; faster build, as it removes the need for seperate handl=
ing of<br>
&gt; &gt; &gt; &gt; the<br>
&gt; &gt; &gt; &gt; individual node packages, as well as streamlining the<b=
r>
&gt; &gt; &gt; &gt; developers<br>
&gt; &gt; &gt; &gt; workflow with the build process within Bitbake.<br>
&gt; &gt; <br>
&gt; &gt; How should this support the download proxy? The npm ci command ne=
ed<br>
&gt; &gt; a<br>
&gt; &gt; repository or a cache to work.<br>
&gt; &gt; <br>
&gt; &gt; Furthermore you need a patch step in between the fetch steps to<b=
r>
&gt; &gt; support <br>
&gt; &gt; tuning / fixing of the configuration before the second fetch step=
.<br>
&gt; &gt; <br>
&gt; &gt; &gt; &gt; As this fetcher would be implemented separately from th=
e<br>
&gt; &gt; &gt; &gt; current<br>
&gt; &gt; npmsw<br>
&gt; &gt; &gt; &gt; fetcher, this will not cause any breaking changes for e=
xisting<br>
&gt; &gt; setups.<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; Additionally, we plan on writing a separate npmsw.bbcla=
ss,<br>
&gt; &gt; &gt; &gt; which<br>
&gt; &gt; will<br>
&gt; &gt; &gt; &gt; parse the package.json for each node module for an auto=
mated<br>
&gt; &gt; Bitbake<br>
&gt; &gt; &gt; &gt; license manifest generation, which will resolve the cur=
rent<br>
&gt; &gt; challenge<br>
&gt; &gt; &gt; &gt; of having to maintain these manually, as currently desc=
ribed at<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; <a href=3D"https://www.yoctoproject.org/docs/latest/mega-manual/m=
ega-manual.html#npm-using-the-registry-modules-method" rel=3D"noreferrer" t=
arget=3D"_blank">https://www.yoctoproject.org/docs/latest/mega-manual/mega-=
manual.html#npm-using-the-registry-modules-method</a><br>
&gt; &gt; &gt; &gt; .<br>
&gt; &gt; <br>
&gt; &gt; This licenses will be generated by the recipetool and you could<b=
r>
&gt; &gt; provide <br>
&gt; &gt; checksums to detect the correct licenses.<br>
&gt; &gt; <br>
&gt; &gt; The license inside the package.json is only a hint and you need a=
 <br>
&gt; &gt; license file to fulfill the license compliance. Because of this I=
<br>
&gt; &gt; remove <br>
&gt; &gt; the package.json from LIC_FILES_CHKSUM because it is useless for<=
br>
&gt; &gt; the <br>
&gt; &gt; license compliance.<br>
&gt; &gt; <br>
&gt; &gt; <br>
&gt; &gt; &gt; &gt; If this is something you see as a worthwhile goal, we w=
ill<br>
&gt; &gt; &gt; &gt; provide<br>
&gt; &gt; a<br>
&gt; &gt; &gt; &gt; set of patch files within the coming weeks.<br>
&gt; &gt; <br>
&gt; &gt; I think you mixed the unusable npm implementation with your speci=
al<br>
&gt; &gt; use <br>
&gt; &gt; case.<br>
&gt; &gt; <br>
&gt; &gt; The problem is that the current npm implementation isn&#39;t real=
ly<br>
&gt; &gt; usable. <br>
&gt; &gt; I&#39;m working on this and have already a prototype that could<b=
r>
&gt; &gt; install, <br>
&gt; &gt; build and *test* a proprietary angular project and node-red as we=
ll<br>
&gt; &gt; as <br>
&gt; &gt; koa/examples from github.<br>
&gt; &gt; <br>
&gt; &gt; If I understand you correct you like to build a npm recipe that<b=
r>
&gt; &gt; could<br>
&gt; &gt; change it dependencies without update the recipe except the SRCRE=
V<br>
&gt; &gt; of<br>
&gt; &gt; the repositories.<br>
&gt; &gt; <br>
&gt; &gt; &gt; At a first read it sounds reasonable but I don&#39;t know th=
e answers<br>
&gt; &gt; to a few<br>
&gt; &gt; &gt; questions which make or break things from an OE/bitbake<br>
&gt; &gt; perspective. Those<br>
&gt; &gt; &gt; questions are:<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; a) Once DL_DIR has been populated by this fetch mechanism, c=
an a<br>
&gt; &gt; subsequent<br>
&gt; &gt; &gt; build run with just the data from there without accessing th=
e<br>
&gt; &gt; network?<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; b) Is the information encoded into SRC_URI enough to give a<=
br>
&gt; &gt; deterministic build<br>
&gt; &gt; &gt; result, i.e. if we run this build at some later date, will w=
e get<br>
&gt; &gt; the same<br>
&gt; &gt; &gt; result?<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; c) Is fetching only happening during the do_fetch task and n=
ot in<br>
&gt; &gt; any subsequent<br>
&gt; &gt; &gt; step?<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; I&#39;d love for some of the other people who&#39;re worked =
on this code<br>
&gt; &gt; &gt; to<br>
&gt; &gt; jump in as I<br>
&gt; &gt; &gt; don&#39;t use it or understand it in detail. I am worried ab=
out how<br>
&gt; &gt; &gt; we<br>
&gt; &gt; maintain this<br>
&gt; &gt; &gt; longer term as different people seem to have different use c=
ases<br>
&gt; &gt; which sees the<br>
&gt; &gt; &gt; code changing in different directions and we&#39;re starting=
 to look<br>
&gt; &gt; like we may end<br>
&gt; &gt; &gt; up with multiple ways of doing things which I really dislike=
.<br>
&gt; &gt; <br>
&gt; &gt; This leads to the questions what is the desired way to integrate =
a <br>
&gt; &gt; package / dependency manager. Nowadays any language (even C/C++)<=
br>
&gt; &gt; has<br>
&gt; &gt; a <br>
&gt; &gt; package manager available and more and more build systems (ex.<br=
>
&gt; &gt; Meson,<br>
&gt; &gt; CMake) support automatic download of dependencies. The common <br=
>
&gt; &gt; from the foreign configuration. The current npm implementation is=
 <br>
&gt; &gt; special because it reuse a foreign configuration and translate it=
<br>
&gt; &gt; into <br>
&gt; &gt; fetch commands on-the-fly. This leads to the problem that common<=
br>
&gt; &gt; tweaks <br>
&gt; &gt; like override a dependency or share configuration between recipes=
<br>
&gt; &gt; via<br>
&gt; &gt; include file isn&#39;t possible. We could fix it by removing the<=
br>
&gt; &gt; foreign <br>
&gt; &gt; configuration and do the translation during recipe creation. But<=
br>
&gt; &gt; this<br>
&gt; &gt; means you have to recreate the recipe after every dependency<br>
&gt; &gt; change.<br>
&gt; &gt; <br>
&gt; &gt; Is it a valid use case for OE to support foreign dependency <br>
&gt; &gt; configurations like npm-shrinkwrap.json, go.sum or conan.lock?<br=
>
&gt; &gt; <br>
&gt; &gt; Regards<br>
&gt; &gt; =C2=A0 =C2=A0Stefan<br>
&gt; &gt; <br>
&gt; &gt; <br>
&gt; &gt; <br>
-----BEGIN PGP SIGNATURE-----<br>
<br>
iQEzBAEBCAAdFiEE4WyPMIC5Ap4+Ooo1Ygqew07VMNUFAmGFVaUACgkQYgqew07V<br>
MNX4NQf+PwyOaBwFeWY/IKWhUfTswHKOkMDubyJnvTM0eRuNiJ+a6GNZo0ZXe/8v<br>
7ozIwTIJShu/roimQff9K44HNjyvZJVC3hMeBUY9VS75RUliAJa48Vo71P57CtXD<br>
ysuTg9hDaPicDA228pljFTHGk+SgLVUkAtgAw0J4URwJyfqoquzRXckt3s7A5/Nm<br>
K3/SZg7FOS4D8bjWLwZvlSX4NVWswb478ct00JL0hdJv6I/Hnr+KBpKXG6OE0+Dj<br>
x2lple1BxDmLcOoUsbvXroojGQNqIi4iYcxbkkvQqFmL/zb9r3MKv5h2VipbNLIC<br>
E3Hdk2iFsXSOnf2Eo1RB3Hy4EwYoSQ=3D=3D<br>
=3DrOen<br>
-----END PGP SIGNATURE-----<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#12911): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/12911" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/12911</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/86814331/1686=
489" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/mt=
/86814331/1686489</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:alex.kanavin@gmail.com" target=3D"=
_blank">alex.kanavin@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div>

--0000000000001a49c305d00e2d68--

