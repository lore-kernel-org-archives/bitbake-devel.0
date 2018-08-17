Return-Path: <davis.roman84@gmail.com>
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com
	[209.85.208.179])
	by mail.openembedded.org (Postfix) with ESMTP id 2050079321;
	Fri, 17 Aug 2018 23:07:31 +0000 (UTC)
Received: by mail-lj1-f179.google.com with SMTP id f1-v6so7518839ljc.9;
	Fri, 17 Aug 2018 16:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=Xdt4g1zlRxRZUWcw9c37HHo0zN7vtcHW2ycKYPolNRg=;
	b=ApFA3lqoiATWU3m0Vtz9Bd7PmyGTngmeME/E8Z8UrEp8JuFR/J/2n/rH2JOigIqKlp
	AC+Ea3MI2fBSPtopZziTLakyr//lWr7ZnhAY1V46sY2n/wm5KJFu9+wLl2wCBaaZjNyc
	cov9Fi//bfTJE5fT/dHVGsC3qJVFj5MKzMj6j+bHACLo74PBEklc9AXMpCAztXUJW++q
	3m3A3fu2ypzgNCZz5LUbn2K8EnuUVcgSS0vh4mfkojgu/jQ+YtZtGX3M7IBTVWWQ1FcE
	Ozxv+tym6yZM390bSm65MTFsCw8C3d0YWGcwcIrFJ5CoTiYDEWKFTlB2kGQ4Ytb07rTA
	P3uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=Xdt4g1zlRxRZUWcw9c37HHo0zN7vtcHW2ycKYPolNRg=;
	b=FkQcSletN2Lr7JSjpDAx+W9+YgllJDy8mLrBSor1ee8rX3Yr8ZOlNoFrhc75T/QwkG
	Wcmo637Rlgl/XfkJtiMOumysLujUNCo2auBxu3FKV+0t2GLoYI/NkeEQYcbVACEJ92+I
	ufaOK1fS7/7VW0wzg+R0rsp3gKDy1nK1nCF5R9llA0y73aYd5/XzjugMqprPCxQiOahZ
	T6tGacBXXQrmtrQYR9dggJwZ/3pUZqj+YGnC74jSd7su97LgQsrTlPjZqs7DcZVkVkRT
	2UxVw9b0tCWyWOo5lZSXEgaRSQiz2cA0flbrO0XuOUokrrbRmNYWtuUhvFaGnqcqYOup
	Nbng==
X-Gm-Message-State: AOUpUlGwzGr+luq/9ItVr7E/heDFl1bZyLamia3ddYdBb4shQuQTIFRa
	b/ry9Vws//TQ3kp6aLDN8HxwsDtMKhzODOXivSY=
X-Google-Smtp-Source: AA+uWPz0Oj54loojZg15D+sZRKVPspTy2QC99lchpcmIXz00v4j0OBDgbRTwj+QGv456lYtUOlm2G6NplRWQ70smKLg=
X-Received: by 2002:a2e:1609:: with SMTP id
	w9-v6mr15471172ljd.120.1534547252549; 
	Fri, 17 Aug 2018 16:07:32 -0700 (PDT)
MIME-Version: 1.0
References: <CACfi_Z2Zvwiq-iB7ckmmT0LgthOPRxCMC6OCSW3ywbZ2=oSY4A@mail.gmail.com>
	<CABcZANkABH+b1z+c-Ey9PrB7Sbj9NSM4KbA1cNsn0f-WAtLdXA@mail.gmail.com>
	<CACfi_Z1xk+u+=Csd8rWxJ4-xSh7zWpD6jKXGLLvj23u0qr4Umg@mail.gmail.com>
	<CABcZAN=aoUEWYuu6uLmSN2=JVgpAFT3adL2A7PjRLU5o-g34+Q@mail.gmail.com>
In-Reply-To: <CABcZAN=aoUEWYuu6uLmSN2=JVgpAFT3adL2A7PjRLU5o-g34+Q@mail.gmail.com>
From: Davis Roman <davis.roman84@gmail.com>
Date: Fri, 17 Aug 2018 19:07:21 -0400
Message-ID: <CACfi_Z3kSzJUZu2Y7tRA7iY7mRNAHQzmBp4KM2kBeK08HLHsww@mail.gmail.com>
To: Christopher Larson <kergoth@gmail.com>
Cc: Yocto discussion list <yocto@yoctoproject.org>,
	bitbake-devel@lists.openembedded.org,
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
X-List-Received-Date: Fri, 17 Aug 2018 23:07:32 -0000
Content-Type: multipart/alternative; boundary="000000000000e12ef30573a99fbf"

--000000000000e12ef30573a99fbf
Content-Type: text/plain; charset="UTF-8"

Hi Christopher,

I think I get it now.

Thank you so much for your time!

Davis

On Fri, Aug 17, 2018, 6:57 PM Christopher Larson <kergoth@gmail.com> wrote:

> Layer priority as defined by BBFILE_PRIORITY controls recipe selection,
> not bbclass and config file parsing. See the bitbake reference manual for
> more detail.
>
> On Fri, Aug 17, 2018 at 3:54 PM Davis Roman <davis.roman84@gmail.com>
> wrote:
>
>> Hi Christopher,
>>
>> I am very intrigued by your response.
>>
>> Initially I had mentioned that the 'bitbake-layers show-layers'
>> command indicates that my layer, meta-hon-grip, has a priority of 8
>> which is among the highest while the meta layer only has a priority of
>> 5.
>>
>> However, now that you mentioned the bblayers.conf file, I see that the
>> meta-hon-grip layer is defined after the meta layer.
>>
>> Therefore it appears to me that my bblayers.conf contradicts
>> 'bitbake-layers show-layers'
>>
>> Could you please help me make sense of this?
>>
>> Thank you,
>>
>> Davis
>>
>>
>>
>> --------------------------------------------------------------------------------------------
>>
>> POKY_BBLAYERS_CONF_VERSION = "2"
>>
>> BBPATH = "${TOPDIR}"
>> BSPDIR := "${@os.path.abspath(os.path.dirname(d.getVar('FILE', True))
>> + '/../..')}"
>>
>> BBFILES ?= ""
>> BBLAYERS = " \
>>   ${BSPDIR}/sources/poky/meta \
>>   ${BSPDIR}/sources/poky/meta-poky \
>>   \
>>   ${BSPDIR}/sources/meta-openembedded/meta-oe \
>>   ${BSPDIR}/sources/meta-openembedded/meta-multimedia \
>>   \
>>   ${BSPDIR}/sources/meta-fsl-arm \
>>   ${BSPDIR}/sources/meta-fsl-arm-extra \
>>   ${BSPDIR}/sources/meta-fsl-demos \
>> "
>> ##Freescale Yocto Project Release layer
>> BBLAYERS += " ${BSPDIR}/sources/meta-fsl-bsp-release/imx/meta-bsp "
>> BBLAYERS += " ${BSPDIR}/sources/meta-fsl-bsp-release/imx/meta-sdk "
>> BBLAYERS += " ${BSPDIR}/sources/meta-browser "
>> BBLAYERS += " ${BSPDIR}/sources/meta-openembedded/meta-gnome "
>> BBLAYERS += " ${BSPDIR}/sources/meta-openembedded/meta-networking "
>> BBLAYERS += " ${BSPDIR}/sources/meta-openembedded/meta-python "
>> BBLAYERS += " ${BSPDIR}/sources/meta-openembedded/meta-filesystems "
>> BBLAYERS += " ${BSPDIR}/sources/meta-qt5 "
>> BBLAYERS += " ${BSPDIR}/sources/meta-hon-grip "
>> BBLAYERS += " ${BSPDIR}/sources/meta-java "
>> BBLAYERS += " ${BSPDIR}/sources/meta-swupdate "
>> BBLAYERS += " ${BSPDIR}/sources/meta-bc "
>> BBLAYERS += " ${BSPDIR}/sources/meta-updater "
>> BBLAYERS += " ${BSPDIR}/sources/meta-gplv2 "
>>
>> On Fri, Aug 17, 2018 at 6:01 PM, Christopher Larson <kergoth@gmail.com>
>> wrote:
>> > Your layer has to be before poky/meta in BBLAYERS, as that determines
>> > BBPATH, which is how bbclasses and config files are found (much like
>> PATH).
>> >
>> > On Fri, Aug 17, 2018 at 12:11 PM Davis Roman <davis.roman84@gmail.com>
>> > wrote:
>> >>
>> >> Hello!
>> >>
>> >>
>> >> I've made a modification in poky/meta/classes/libc-package.bbclass (
>> >> shown below)
>> >>
>> >> However I don't want this change to be stored here long term and
>> >> instead feel that it should live in my project specific layer,
>> >> meta-hon-grip.
>> >>
>> >> After checking with bitbake-layers, I saw that my layer has a higher
>> >> priority than the poky layer so my layer should be checked first ( or
>> >> so I thought)
>> >>
>> >> I copied the modified version of libc-packages.bbclass into
>> >> meta-hon-grip/classes and I restored the version in the poky layer to
>> >> its original state.
>> >>
>> >> After making this change, I found that the modified version in my
>> >> layer is not being used and instead the version in the poky layer is
>> >> the one in play.
>> >>
>> >> I'm trying to figure out what else to try.
>> >>
>> >> Any suggestions would be greatly appreciated!
>> >>
>> >> Thank you,
>> >>
>> >> Davis
>> >>
>> >> diff --git a/meta/classes/libc-package.bbclass
>> >> b/meta/classes/libc-package.bbclass
>> >> index 467d567..72d447a 100644
>> >> --- a/meta/classes/libc-package.bbclass
>> >> +++ b/meta/classes/libc-package.bbclass
>> >> @@ -287,7 +287,7 @@ python package_do_split_gconvs () {
>> >>                  bb.error("locale_arch_options not found for
>> >> target_arch=" + target_arch)
>> >>                  raise bb.build.FuncFailed("unknown arch:" +
>> >> target_arch + " for locale_arch_options")
>> >>
>> >> -            localedef_opts += " --force --old-style --no-archive
>> >> --prefix=%s \
>> >> +            localedef_opts += " --force --no-archive --prefix=%s \
>> >>                  --inputfile=%s/%s/i18n/locales/%s --charmap=%s %s/%s"
>> \
>> >>                  % (treedir, treedir, datadir, locale, encoding,
>> >> outputpath, name)
>> >>
>> >> @@ -295,7 +295,7 @@ python package_do_split_gconvs () {
>> >>                  (path, i18npath, gconvpath, localedef_opts)
>> >>          else: # earlier slower qemu way
>> >>              qemu = qemu_target_binary(d)
>> >> -            localedef_opts = "--force --old-style --no-archive
>> >> --prefix=%s \
>> >> +            localedef_opts = "--force --no-archive --prefix=%s \
>> >>                  --inputfile=%s/i18n/locales/%s --charmap=%s %s" \
>> >>                  % (treedir, datadir, locale, encoding, name)
>> >> --
>> >> _______________________________________________
>> >> bitbake-devel mailing list
>> >> bitbake-devel@lists.openembedded.org
>> >> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>> >
>> >
>> >
>> > --
>> > Christopher Larson
>> > kergoth at gmail dot com
>> > Founder - BitBake, OpenEmbedded, OpenZaurus
>> > Senior Software Engineer, Mentor Graphics
>>
>
>
> --
> Christopher Larson
> kergoth at gmail dot com
> Founder - BitBake, OpenEmbedded, OpenZaurus
> Senior Software Engineer, Mentor Graphics
>

--000000000000e12ef30573a99fbf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hi Christopher,<div dir=3D"auto"><br></div><div dir=3D"au=
to">I think I get it now.</div><div dir=3D"auto"><br></div><div dir=3D"auto=
">Thank you so much for your time!</div><div dir=3D"auto"><br></div><div di=
r=3D"auto">Davis</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr"=
>On Fri, Aug 17, 2018, 6:57 PM Christopher Larson &lt;<a href=3D"mailto:ker=
goth@gmail.com">kergoth@gmail.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex"><div dir=3D"ltr">Layer priority as defined by BBFILE_PRIORITY=
 controls recipe selection, not bbclass and config file parsing. See the bi=
tbake reference manual for more detail.<br></div><br><div class=3D"gmail_qu=
ote"><div dir=3D"ltr">On Fri, Aug 17, 2018 at 3:54 PM Davis Roman &lt;<a hr=
ef=3D"mailto:davis.roman84@gmail.com" target=3D"_blank" rel=3D"noreferrer">=
davis.roman84@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1=
ex">Hi Christopher,<br>
<br>
I am very intrigued by your response.<br>
<br>
Initially I had mentioned that the &#39;bitbake-layers show-layers&#39;<br>
command indicates that my layer, meta-hon-grip, has a priority of 8<br>
which is among the highest while the meta layer only has a priority of<br>
5.<br>
<br>
However, now that you mentioned the bblayers.conf file, I see that the<br>
meta-hon-grip layer is defined after the meta layer.<br>
<br>
Therefore it appears to me that my bblayers.conf contradicts<br>
&#39;bitbake-layers show-layers&#39;<br>
<br>
Could you please help me make sense of this?<br>
<br>
Thank you,<br>
<br>
Davis<br>
<br>
<br>
---------------------------------------------------------------------------=
-----------------<br>
<br>
POKY_BBLAYERS_CONF_VERSION =3D &quot;2&quot;<br>
<br>
BBPATH =3D &quot;${TOPDIR}&quot;<br>
BSPDIR :=3D &quot;${@os.path.abspath(os.path.dirname(d.getVar(&#39;FILE&#39=
;, True))<br>
+ &#39;/../..&#39;)}&quot;<br>
<br>
BBFILES ?=3D &quot;&quot;<br>
BBLAYERS =3D &quot; \<br>
=C2=A0 ${BSPDIR}/sources/poky/meta \<br>
=C2=A0 ${BSPDIR}/sources/poky/meta-poky \<br>
=C2=A0 \<br>
=C2=A0 ${BSPDIR}/sources/meta-openembedded/meta-oe \<br>
=C2=A0 ${BSPDIR}/sources/meta-openembedded/meta-multimedia \<br>
=C2=A0 \<br>
=C2=A0 ${BSPDIR}/sources/meta-fsl-arm \<br>
=C2=A0 ${BSPDIR}/sources/meta-fsl-arm-extra \<br>
=C2=A0 ${BSPDIR}/sources/meta-fsl-demos \<br>
&quot;<br>
##Freescale Yocto Project Release layer<br>
BBLAYERS +=3D &quot; ${BSPDIR}/sources/meta-fsl-bsp-release/imx/meta-bsp &q=
uot;<br>
BBLAYERS +=3D &quot; ${BSPDIR}/sources/meta-fsl-bsp-release/imx/meta-sdk &q=
uot;<br>
BBLAYERS +=3D &quot; ${BSPDIR}/sources/meta-browser &quot;<br>
BBLAYERS +=3D &quot; ${BSPDIR}/sources/meta-openembedded/meta-gnome &quot;<=
br>
BBLAYERS +=3D &quot; ${BSPDIR}/sources/meta-openembedded/meta-networking &q=
uot;<br>
BBLAYERS +=3D &quot; ${BSPDIR}/sources/meta-openembedded/meta-python &quot;=
<br>
BBLAYERS +=3D &quot; ${BSPDIR}/sources/meta-openembedded/meta-filesystems &=
quot;<br>
BBLAYERS +=3D &quot; ${BSPDIR}/sources/meta-qt5 &quot;<br>
BBLAYERS +=3D &quot; ${BSPDIR}/sources/meta-hon-grip &quot;<br>
BBLAYERS +=3D &quot; ${BSPDIR}/sources/meta-java &quot;<br>
BBLAYERS +=3D &quot; ${BSPDIR}/sources/meta-swupdate &quot;<br>
BBLAYERS +=3D &quot; ${BSPDIR}/sources/meta-bc &quot;<br>
BBLAYERS +=3D &quot; ${BSPDIR}/sources/meta-updater &quot;<br>
BBLAYERS +=3D &quot; ${BSPDIR}/sources/meta-gplv2 &quot;<br>
<br>
On Fri, Aug 17, 2018 at 6:01 PM, Christopher Larson &lt;<a href=3D"mailto:k=
ergoth@gmail.com" target=3D"_blank" rel=3D"noreferrer">kergoth@gmail.com</a=
>&gt; wrote:<br>
&gt; Your layer has to be before poky/meta in BBLAYERS, as that determines<=
br>
&gt; BBPATH, which is how bbclasses and config files are found (much like P=
ATH).<br>
&gt;<br>
&gt; On Fri, Aug 17, 2018 at 12:11 PM Davis Roman &lt;<a href=3D"mailto:dav=
is.roman84@gmail.com" target=3D"_blank" rel=3D"noreferrer">davis.roman84@gm=
ail.com</a>&gt;<br>
&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; Hello!<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; I&#39;ve made a modification in poky/meta/classes/libc-package.bbc=
lass (<br>
&gt;&gt; shown below)<br>
&gt;&gt;<br>
&gt;&gt; However I don&#39;t want this change to be stored here long term a=
nd<br>
&gt;&gt; instead feel that it should live in my project specific layer,<br>
&gt;&gt; meta-hon-grip.<br>
&gt;&gt;<br>
&gt;&gt; After checking with bitbake-layers, I saw that my layer has a high=
er<br>
&gt;&gt; priority than the poky layer so my layer should be checked first (=
 or<br>
&gt;&gt; so I thought)<br>
&gt;&gt;<br>
&gt;&gt; I copied the modified version of libc-packages.bbclass into<br>
&gt;&gt; meta-hon-grip/classes and I restored the version in the poky layer=
 to<br>
&gt;&gt; its original state.<br>
&gt;&gt;<br>
&gt;&gt; After making this change, I found that the modified version in my<=
br>
&gt;&gt; layer is not being used and instead the version in the poky layer =
is<br>
&gt;&gt; the one in play.<br>
&gt;&gt;<br>
&gt;&gt; I&#39;m trying to figure out what else to try.<br>
&gt;&gt;<br>
&gt;&gt; Any suggestions would be greatly appreciated!<br>
&gt;&gt;<br>
&gt;&gt; Thank you,<br>
&gt;&gt;<br>
&gt;&gt; Davis<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/meta/classes/libc-package.bbclass<br>
&gt;&gt; b/meta/classes/libc-package.bbclass<br>
&gt;&gt; index 467d567..72d447a 100644<br>
&gt;&gt; --- a/meta/classes/libc-package.bbclass<br>
&gt;&gt; +++ b/meta/classes/libc-package.bbclass<br>
&gt;&gt; @@ -287,7 +287,7 @@ python package_do_split_gconvs () {<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.e=
rror(&quot;locale_arch_options not found for<br>
&gt;&gt; target_arch=3D&quot; + target_arch)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rais=
e bb.build.FuncFailed(&quot;unknown arch:&quot; +<br>
&gt;&gt; target_arch + &quot; for locale_arch_options&quot;)<br>
&gt;&gt;<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 localedef_opts +=3D &qu=
ot; --force --old-style --no-archive<br>
&gt;&gt; --prefix=3D%s \<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 localedef_opts +=3D &qu=
ot; --force --no-archive --prefix=3D%s \<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 --in=
putfile=3D%s/%s/i18n/locales/%s --charmap=3D%s %s/%s&quot; \<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 % (t=
reedir, treedir, datadir, locale, encoding,<br>
&gt;&gt; outputpath, name)<br>
&gt;&gt;<br>
&gt;&gt; @@ -295,7 +295,7 @@ python package_do_split_gconvs () {<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (pat=
h, i18npath, gconvpath, localedef_opts)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else: # earlier slower qemu way<=
br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu =3D qemu_targ=
et_binary(d)<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 localedef_opts =3D &quo=
t;--force --old-style --no-archive<br>
&gt;&gt; --prefix=3D%s \<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 localedef_opts =3D &quo=
t;--force --no-archive --prefix=3D%s \<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 --in=
putfile=3D%s/i18n/locales/%s --charmap=3D%s %s&quot; \<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 % (t=
reedir, datadir, locale, encoding, name)<br>
&gt;&gt; --<br>
&gt;&gt; _______________________________________________<br>
&gt;&gt; bitbake-devel mailing list<br>
&gt;&gt; <a href=3D"mailto:bitbake-devel@lists.openembedded.org" target=3D"=
_blank" rel=3D"noreferrer">bitbake-devel@lists.openembedded.org</a><br>
&gt;&gt; <a href=3D"http://lists.openembedded.org/mailman/listinfo/bitbake-=
devel" rel=3D"noreferrer noreferrer" target=3D"_blank">http://lists.openemb=
edded.org/mailman/listinfo/bitbake-devel</a><br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; --<br>
&gt; Christopher Larson<br>
&gt; kergoth at gmail dot com<br>
&gt; Founder - BitBake, OpenEmbedded, OpenZaurus<br>
&gt; Senior Software Engineer, Mentor Graphics<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"m=
_-634991155681125989gmail_signature" data-smartmail=3D"gmail_signature"><di=
v dir=3D"ltr"><div><div dir=3D"ltr">Christopher Larson<br>kergoth at gmail =
dot com<br>Founder - BitBake, OpenEmbedded, OpenZaurus<br>Senior Software E=
ngineer, Mentor Graphics</div></div></div></div>
</blockquote></div>

--000000000000e12ef30573a99fbf--
