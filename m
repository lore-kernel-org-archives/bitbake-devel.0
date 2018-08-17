Return-Path: <kergoth@gmail.com>
Received: from mail-oi0-f53.google.com (mail-oi0-f53.google.com
	[209.85.218.53])
	by mail.openembedded.org (Postfix) with ESMTP id BD4D9745AB;
	Fri, 17 Aug 2018 22:01:16 +0000 (UTC)
Received: by mail-oi0-f53.google.com with SMTP id j205-v6so16510333oib.4;
	Fri, 17 Aug 2018 15:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=9/dV1LbdcKVLIsb9Xq8NkzFd9VwKGxzLwuylmIb0ai4=;
	b=HMpw1PgsPYTjE9t1qiEzuXfifHjG63P4bMr9jCwwfKvmR8dYNps6AuIFUa+ZYM3bhE
	WAz0+3wpMoee/hwhUmtkdR4PNQ5BB4uM2G5o47u06g8Q2QYY5shRoGF23q2VmfkvbU9B
	LlP/IUr/nUej8jfnZAqLBeX+vuSvs0t4riO/fHPCQj1oy4e+DUhMzTkz1484NUAyMvey
	NW/WKhoE+C6cz1LxJvdgCGz8o8O02Tgh4w9xqm0jPGQ+kEqb4T2rFQGFyuppA4aKWZ6/
	gdcSENkdxYNpDjtBJRAF7bV5Y8gXf7oN7KyK2fUM/I8fSxgtNjD2n+d6Z/XUcEW5eZaF
	MFDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=9/dV1LbdcKVLIsb9Xq8NkzFd9VwKGxzLwuylmIb0ai4=;
	b=hWB4Wh1A+8qeEsoWSc3A9Ytr2yyuiR2fv1LjdlalbC089AvBCmoxoUE6oJlq6tlsgu
	G/154qfRHFKJYOaEB9SzfgxenLrqZ813ua8Gv9nMl1/UeiOt8FAXWJ7D/jEwHnG0vJXy
	b5BnMV6DmD11m8ZrK+g3MxdDzdJMbo+l8HGObXKuX0DbbGob0QxE5iQW0ROLl17I9PlF
	HeAt0myWfm4mqWlywJJPiy0cDFdvAUsN9LuWt9paU/wVIBxARweXJzp5UZBRI87vu43V
	u+iZDI1kY6j/9DqkVZsKqc8aiL/OMaKP+NO6YsUUskFXhwkrBpaRmkS6aZ+EeOINpTcq
	713Q==
X-Gm-Message-State: AOUpUlGWtjpTxzsa+1/vrAbffgvsiJbRfQVgXgMOWNqrZQ6ahyKNHGF6
	Lj9saenBzQAzVTcEX5Mt7yiKRWYZeAxzIqhrEAs=
X-Google-Smtp-Source: AA+uWPw6I/aN4qL92VqkD90VNrZxKN8YXysrNL1/3eOa3sBjyhooAPVNyc6Yno4v6PD/iiWBKVSAeKhzghPzuaF3ROI=
X-Received: by 2002:aca:6cc6:: with SMTP id
	h189-v6mr4080285oic.140.1534543277602; 
	Fri, 17 Aug 2018 15:01:17 -0700 (PDT)
MIME-Version: 1.0
References: <CACfi_Z2Zvwiq-iB7ckmmT0LgthOPRxCMC6OCSW3ywbZ2=oSY4A@mail.gmail.com>
In-Reply-To: <CACfi_Z2Zvwiq-iB7ckmmT0LgthOPRxCMC6OCSW3ywbZ2=oSY4A@mail.gmail.com>
From: Christopher Larson <kergoth@gmail.com>
Date: Fri, 17 Aug 2018 15:01:06 -0700
Message-ID: <CABcZANkABH+b1z+c-Ey9PrB7Sbj9NSM4KbA1cNsn0f-WAtLdXA@mail.gmail.com>
To: davis.roman84@gmail.com
Cc: yocto <yocto@yoctoproject.org>, bitbake-devel@lists.openembedded.org,
	Patches and discussions about the oe-core layer
	<openembedded-core@lists.openembedded.org>
Subject: Re: how to store a modification of a bbclass in the poky layer in my own layer.
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
X-List-Received-Date: Fri, 17 Aug 2018 22:01:17 -0000
Content-Type: multipart/alternative; boundary="000000000000f43c220573a8b2da"

--000000000000f43c220573a8b2da
Content-Type: text/plain; charset="UTF-8"

Your layer has to be before poky/meta in BBLAYERS, as that determines
BBPATH, which is how bbclasses and config files are found (much like PATH).

On Fri, Aug 17, 2018 at 12:11 PM Davis Roman <davis.roman84@gmail.com>
wrote:

> Hello!
>
>
> I've made a modification in poky/meta/classes/libc-package.bbclass (
> shown below)
>
> However I don't want this change to be stored here long term and
> instead feel that it should live in my project specific layer,
> meta-hon-grip.
>
> After checking with bitbake-layers, I saw that my layer has a higher
> priority than the poky layer so my layer should be checked first ( or
> so I thought)
>
> I copied the modified version of libc-packages.bbclass into
> meta-hon-grip/classes and I restored the version in the poky layer to
> its original state.
>
> After making this change, I found that the modified version in my
> layer is not being used and instead the version in the poky layer is
> the one in play.
>
> I'm trying to figure out what else to try.
>
> Any suggestions would be greatly appreciated!
>
> Thank you,
>
> Davis
>
> diff --git a/meta/classes/libc-package.bbclass
> b/meta/classes/libc-package.bbclass
> index 467d567..72d447a 100644
> --- a/meta/classes/libc-package.bbclass
> +++ b/meta/classes/libc-package.bbclass
> @@ -287,7 +287,7 @@ python package_do_split_gconvs () {
>                  bb.error("locale_arch_options not found for
> target_arch=" + target_arch)
>                  raise bb.build.FuncFailed("unknown arch:" +
> target_arch + " for locale_arch_options")
>
> -            localedef_opts += " --force --old-style --no-archive
> --prefix=%s \
> +            localedef_opts += " --force --no-archive --prefix=%s \
>                  --inputfile=%s/%s/i18n/locales/%s --charmap=%s %s/%s" \
>                  % (treedir, treedir, datadir, locale, encoding,
> outputpath, name)
>
> @@ -295,7 +295,7 @@ python package_do_split_gconvs () {
>                  (path, i18npath, gconvpath, localedef_opts)
>          else: # earlier slower qemu way
>              qemu = qemu_target_binary(d)
> -            localedef_opts = "--force --old-style --no-archive
> --prefix=%s \
> +            localedef_opts = "--force --no-archive --prefix=%s \
>                  --inputfile=%s/i18n/locales/%s --charmap=%s %s" \
>                  % (treedir, datadir, locale, encoding, name)
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>


-- 
Christopher Larson
kergoth at gmail dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Senior Software Engineer, Mentor Graphics

--000000000000f43c220573a8b2da
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Your layer has to be before poky/meta in BBLAYERS, as that=
 determines BBPATH, which is how bbclasses and config files are found (much=
 like PATH).<br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Fr=
i, Aug 17, 2018 at 12:11 PM Davis Roman &lt;<a href=3D"mailto:davis.roman84=
@gmail.com">davis.roman84@gmail.com</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pa=
dding-left:1ex">Hello!<br>
<br>
<br>
I&#39;ve made a modification in poky/meta/classes/libc-package.bbclass (<br=
>
shown below)<br>
<br>
However I don&#39;t want this change to be stored here long term and<br>
instead feel that it should live in my project specific layer,<br>
meta-hon-grip.<br>
<br>
After checking with bitbake-layers, I saw that my layer has a higher<br>
priority than the poky layer so my layer should be checked first ( or<br>
so I thought)<br>
<br>
I copied the modified version of libc-packages.bbclass into<br>
meta-hon-grip/classes and I restored the version in the poky layer to<br>
its original state.<br>
<br>
After making this change, I found that the modified version in my<br>
layer is not being used and instead the version in the poky layer is<br>
the one in play.<br>
<br>
I&#39;m trying to figure out what else to try.<br>
<br>
Any suggestions would be greatly appreciated!<br>
<br>
Thank you,<br>
<br>
Davis<br>
<br>
diff --git a/meta/classes/libc-package.bbclass<br>
b/meta/classes/libc-package.bbclass<br>
index 467d567..72d447a 100644<br>
--- a/meta/classes/libc-package.bbclass<br>
+++ b/meta/classes/libc-package.bbclass<br>
@@ -287,7 +287,7 @@ python package_do_split_gconvs () {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.error(&quo=
t;locale_arch_options not found for<br>
target_arch=3D&quot; + target_arch)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise bb.buil=
d.FuncFailed(&quot;unknown arch:&quot; +<br>
target_arch + &quot; for locale_arch_options&quot;)<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 localedef_opts +=3D &quot; --for=
ce --old-style --no-archive --prefix=3D%s \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 localedef_opts +=3D &quot; --for=
ce --no-archive --prefix=3D%s \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0--inputfile=
=3D%s/%s/i18n/locales/%s --charmap=3D%s %s/%s&quot; \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0% (treedir, t=
reedir, datadir, locale, encoding,<br>
outputpath, name)<br>
<br>
@@ -295,7 +295,7 @@ python package_do_split_gconvs () {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(path, i18npa=
th, gconvpath, localedef_opts)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else: # earlier slower qemu way<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu =3D qemu_target_binary=
(d)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 localedef_opts =3D &quot;--force=
 --old-style --no-archive --prefix=3D%s \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 localedef_opts =3D &quot;--force=
 --no-archive --prefix=3D%s \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0--inputfile=
=3D%s/i18n/locales/%s --charmap=3D%s %s&quot; \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0% (treedir, d=
atadir, locale, encoding, name)<br>
-- <br>
_______________________________________________<br>
bitbake-devel mailing list<br>
<a href=3D"mailto:bitbake-devel@lists.openembedded.org" target=3D"_blank">b=
itbake-devel@lists.openembedded.org</a><br>
<a href=3D"http://lists.openembedded.org/mailman/listinfo/bitbake-devel" re=
l=3D"noreferrer" target=3D"_blank">http://lists.openembedded.org/mailman/li=
stinfo/bitbake-devel</a><br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><div><d=
iv dir=3D"ltr">Christopher Larson<br>kergoth at gmail dot com<br>Founder - =
BitBake, OpenEmbedded, OpenZaurus<br>Senior Software Engineer, Mentor Graph=
ics</div></div></div></div>

--000000000000f43c220573a8b2da--
