Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
 by mx.groups.io with SMTP id smtpd.web08.24918.1627655092681052878
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 30 Jul 2021 07:24:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=p8YEE/QM;
 spf=pass (domain: gmail.com, ip: 209.85.218.48, mailfrom: martin.jansa@gmail.com)
Received: by mail-ej1-f48.google.com with SMTP id gs8so17058001ejc.13
        for <bitbake-devel@lists.openembedded.org>; Fri, 30 Jul 2021 07:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3c7S3exfX1jF76SQ7uD1TQiIIiffTWwaXDWI40nLJq4=;
        b=p8YEE/QMvTwaWKs4ka+Q10F54gq3ifsxe44QwMOls/dlFwH2JnT3kWpZNc/mDfGa+e
         pltYPAYNpIUrpGzhF15j0JMVbtLEWRA4CS1XKsdUujISfIT19tM8u4mnZgjDiLLavTs0
         6fp9rTUIiz1HZ8sY8OpKAZlx2GdnUN3+uAbcnoPlhSy74BGI3yYM8NSPhJ+7qE5r8r31
         f5PlAUIQxlLx7GV/0PEp9nE7oBljcZkGVxFUHAQ3Z+i3tZyHHUHlIMgOiLBCOqzq5ieu
         Ba1d/XmBrJC7Jh28xCqTVppkwG+M6STrsj16MuOuXDRZvucPqys0JgeZBsDJboPPAAXN
         hArg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3c7S3exfX1jF76SQ7uD1TQiIIiffTWwaXDWI40nLJq4=;
        b=hUl5zWc8KakKEneWZXtIG8z7S1iWRKahd8P8Aa6Y5PK3gthT9V3aycwvmP4W8oQuR9
         CikR+VM2ZV/DKQypGZ4lChJEi6j0sOjC+L0x5zrRUDLBvsQkxNvGeCEwe7UoOtWV1c6X
         8DvThTL6PQLCY8NIlphH9qq61SrOTuTTgcYzNkZbwtJF0XcqoayBxxDxxRnrA04zLNeD
         +/Z+LzIfAThp9R72p3kwIPqKlTZ8++v17NxyxCaMUdpiB2KQ0HmPksl37tKPciuwcwkk
         w0RaE5oq8RwJL5PYALw+SpIq4YJQwzvdeUXz54zHCTdApIMAkmnR/qQrsKfw2pNolPfN
         loJw==
X-Gm-Message-State: AOAM533Us5W684sXbxAy3it32lQUW9FAX+rCUwnqdnISJ5BxoJrlRiEF
	uDGxCWbRd8o03kSe/XpfFuRqhpKGzhvfxQeCnw8=
X-Google-Smtp-Source: ABdhPJyX7AZB0UXIJ/oekUDrX/cxoqAkK6ZPJ0BFhmuYw3VLVJmYE/wMfV9FausqQa2Rw85BQqUZ1tjDambb0F4Ad3A=
X-Received: by 2002:a17:906:7a56:: with SMTP id i22mr2793858ejo.94.1627655091137;
 Fri, 30 Jul 2021 07:24:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210730134706.3360651-1-richard.purdie@linuxfoundation.org>
In-Reply-To: <20210730134706.3360651-1-richard.purdie@linuxfoundation.org>
From: "Martin Jansa" <Martin.Jansa@gmail.com>
Date: Fri, 30 Jul 2021 16:24:40 +0200
Message-ID: <CA+chaQfGLE507bYOivb8XSYcNbm3ssHqEFCdgav5W4XYmgiXuA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 1/4] bitbake: Switch to using new override syntax
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="0000000000008633e605c857fb2a"

--0000000000008633e605c857fb2a
Content-Type: text/plain; charset="UTF-8"

On Fri, Jul 30, 2021 at 3:47 PM Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> This change updates the datastore to use the new override syntax using
> colons instead of underscores exclusively. It is expected layers would
> have to be converted to work with bitbake after this change.
>
> Supporting mixed syntax isn't possible, it is only feasible to have
> one internal representation of overrides.
>
> Whilst we can't warn for every possible override that may be set in the
> old format, show errors for _append/_prepend/_remove since those should
> never be present.
>

Thanks!

Already helped me to catch few cases which weren't converted automatically
with the script:

 ERROR: meta-webosose/meta-webos/recipes-webos/com.webos.app.notification/
com.webos.app.notification.bb: Variable
webos_configure_manifest_comment_remover contains an operation using the
old override syntax. Please convert this layer/metadata before attempting
to use with a newer bitbake.
ERROR: meta-webosose/meta-webos/recipes-webos/libpmscore/libpmscore.bb:
Variable do_generate_toolchain_file_append contains an operation using the
old override syntax. Please convert this layer/metadata before attempting
to use with a newer bitbake.
ERROR: meta-webosose/meta-webos/recipes-webos/media-resource-calculator/
media-resource-calculator.bb: Variable do_generate_toolchain_file_append
contains an operation using the old override syntax. Please convert this
layer/metadata before attempting to use with a newer bitbake.
ERROR: meta-webosose/meta-webos/recipes-webos/com.webos.app.videoplayer/
com.webos.app.videoplayer.bb: Variable
webos_configure_manifest_comment_remover contains an operation using the
old override syntax. Please convert this layer/metadata before attempting
to use with a newer bitbake.
ERROR: meta-webosose/meta-webos/recipes-webos/jemalloc/jemalloc.bb:
Variable do_generate_toolchain_file_append contains an operation using the
old override syntax. Please convert this layer/metadata before attempting
to use with a newer bitbake.
ERROR: oe-core/meta/recipes-kernel/linux/linux-yocto_5.4.bb: Variable
do_deploy_links_append contains an operation using the old override syntax.
Please convert this layer/metadata before attempting to use with a newer
bitbake.
ERROR: meta-webosose/meta-webos/recipes-webos/videooutputd/
com.webos.service.videooutput.bb: Variable
do_generate_toolchain_file_append contains an operation using the old
override syntax. Please convert this layer/metadata before attempting to
use with a newer bitbake.
ERROR: Failed to parse recipe:
meta-webosose/meta-webos/recipes-webos/com.webos.app.notification/
com.webos.app.notification.bb
ERROR: meta-webosose/meta-webos/recipes-webos/com.webos.service.tts/
com.webos.service.tts.bb: Variable do_generate_toolchain_file_append
contains an operation using the old override syntax. Please convert this
layer/metadata before attempting to use with a newer bitbake.

The webos_configure_manifest_comment_remover is a false positive, but I
don't mind renaming it to something else (if it can confuse he regexp, then
person could get confused as well).

And the other 2 are real issues:

$ git grep do_generate_toolchain_file_append
meta-webos/classes/webos_cmake.bbclass:do_generate_toolchain_file_append() {
meta-webos/recipes-webos/db8/db8.bb:cmake_do_generate_toolchain_file_append()
{

--0000000000008633e605c857fb2a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Fri, Jul 30, 2021 at 3:47 PM Richard P=
urdie &lt;<a href=3D"mailto:richard.purdie@linuxfoundation.org">richard.pur=
die@linuxfoundation.org</a>&gt; wrote:<br></div><div class=3D"gmail_quote">=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">This change updates the d=
atastore to use the new override syntax using<br>
colons instead of underscores exclusively. It is expected layers would<br>
have to be converted to work with bitbake after this change.<br>
<br>
Supporting mixed syntax isn&#39;t possible, it is only feasible to have<br>
one internal representation of overrides.<br>
<br>
Whilst we can&#39;t warn for every possible override that may be set in the=
<br>
old format, show errors for _append/_prepend/_remove since those should<br>
never be present.<br></blockquote><div><br></div><div>Thanks!</div><div><br=
></div><div>Already helped me to catch few cases which weren&#39;t converte=
d automatically with the script:</div><div><br></div><div>=C2=A0ERROR: meta=
-webosose/meta-webos/recipes-webos/com.webos.app.notification/<a href=3D"ht=
tp://com.webos.app.notification.bb">com.webos.app.notification.bb</a>: Vari=
able webos_configure_manifest_comment_remover contains an operation using t=
he old override syntax. Please convert this layer/metadata before attemptin=
g to use with a newer bitbake.</div>ERROR: meta-webosose/meta-webos/recipes=
-webos/libpmscore/<a href=3D"http://libpmscore.bb">libpmscore.bb</a>: Varia=
ble do_generate_toolchain_file_append contains an operation using the old o=
verride syntax. Please convert this layer/metadata before attempting to use=
 with a newer bitbake.<br>ERROR: meta-webosose/meta-webos/recipes-webos/med=
ia-resource-calculator/<a href=3D"http://media-resource-calculator.bb">medi=
a-resource-calculator.bb</a>: Variable do_generate_toolchain_file_append co=
ntains an operation using the old override syntax. Please convert this laye=
r/metadata before attempting to use with a newer bitbake.<br>ERROR: meta-we=
bosose/meta-webos/recipes-webos/com.webos.app.videoplayer/<a href=3D"http:/=
/com.webos.app.videoplayer.bb">com.webos.app.videoplayer.bb</a>: Variable w=
ebos_configure_manifest_comment_remover contains an operation using the old=
 override syntax. Please convert this layer/metadata before attempting to u=
se with a newer bitbake.<br>ERROR: meta-webosose/meta-webos/recipes-webos/j=
emalloc/<a href=3D"http://jemalloc.bb">jemalloc.bb</a>: Variable do_generat=
e_toolchain_file_append contains an operation using the old override syntax=
. Please convert this layer/metadata before attempting to use with a newer =
bitbake.<br>ERROR: oe-core/meta/recipes-kernel/linux/<a href=3D"http://linu=
x-yocto_5.4.bb">linux-yocto_5.4.bb</a>: Variable do_deploy_links_append con=
tains an operation using the old override syntax. Please convert this layer=
/metadata before attempting to use with a newer bitbake.<br>ERROR: meta-web=
osose/meta-webos/recipes-webos/videooutputd/<a href=3D"http://com.webos.ser=
vice.videooutput.bb">com.webos.service.videooutput.bb</a>: Variable do_gene=
rate_toolchain_file_append contains an operation using the old override syn=
tax. Please convert this layer/metadata before attempting to use with a new=
er bitbake.<br>ERROR: Failed to parse recipe: meta-webosose/meta-webos/reci=
pes-webos/com.webos.app.notification/<a href=3D"http://com.webos.app.notifi=
cation.bb">com.webos.app.notification.bb</a><br>ERROR: meta-webosose/meta-w=
ebos/recipes-webos/com.webos.service.tts/<a href=3D"http://com.webos.servic=
e.tts.bb">com.webos.service.tts.bb</a>: Variable do_generate_toolchain_file=
_append contains an operation using the old override syntax. Please convert=
 this layer/metadata before attempting to use with a newer bitbake.</div><d=
iv class=3D"gmail_quote"><br></div><div class=3D"gmail_quote">The=C2=A0webo=
s_configure_manifest_comment_remover is a false positive, but I don&#39;t m=
ind renaming it to something else (if it can confuse he regexp, then person=
 could get confused as well).</div><div class=3D"gmail_quote"><br></div><di=
v class=3D"gmail_quote">And the other 2 are real issues:</div><div class=3D=
"gmail_quote"><br></div><div class=3D"gmail_quote">$ git grep do_generate_t=
oolchain_file_append<br>meta-webos/classes/webos_cmake.bbclass:do_generate_=
toolchain_file_append() {<br>meta-webos/recipes-webos/db8/db8.bb:cmake_do_g=
enerate_toolchain_file_append() {<br></div></div>

--0000000000008633e605c857fb2a--
