Return-Path: <Martin.Jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67637C678D4
	for <webhook@archiver.kernel.org>; Mon,  6 Mar 2023 16:04:35 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.web11.37748.1678118671035392239
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 06 Mar 2023 08:04:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=A2MFxvXu;
 spf=pass (domain: gmail.com, ip: 209.85.221.53, mailfrom: martin.jansa@gmail.com)
Received: by mail-wr1-f53.google.com with SMTP id e13so9334584wro.10
        for <bitbake-devel@lists.openembedded.org>; Mon, 06 Mar 2023 08:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678118669;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2W7TjtfZZOZX3zoCTvxGmFggmjJCvr3PlC5dpNzHsks=;
        b=A2MFxvXuDO5Zor1xsYiR5SRGxK0juejyaegmSmGAhSavVS5U9tsDoJldmKkW6QAhiC
         WqQNlF9/xYBtuaF36pWyGfNonPa+Ofw+ex+kO8O33zlDdWoDEH1IJ1+bOoppP1tZY1gV
         M7PbUK61H3LJmWxtaw32jYnCD78qzbzgXLXntLVSQzxBp1suacSRC3ykvqT6CtPqIXTG
         ssfgR3GsRJbW++9jqJZMcJd0goVkcxwQvRFBL+Dli7MDqaHG9n7fOVsD48/4FIqel4Qj
         pmqETTWQ7JopA7t9z12sqfUwAPeQZJBmBMYa4ZeINF7uIoA9xdmVSTrK6xdHKsE1OLZr
         4rsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678118669;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2W7TjtfZZOZX3zoCTvxGmFggmjJCvr3PlC5dpNzHsks=;
        b=BSYT7CG33qovCDW5vv+T1LRBwFwJzU7uwsloq/bwijr8eCCHcU7tbm4oDezOsr9dZX
         jd6lF9svQMTNnoEZqSHCxaPxMU4cBmCttn3bu/w0kLOMG2B/zfnQn1D7kx1o4JoYQSfI
         mMnP3q4kXdjNmnPgc9IAzVCZI5ryETfSiAOKZfyXeJKBhQIn36srnRKT/oex5GJmQ9rF
         EWDK/+ZIqa+gjJc4O7F5e+Qf39Q90GlM9jSIT0Q69NBkRHtcMTRDYW/gY0AbVKa3RQo8
         5ubJP5Ds9l22vEhr3Z156rHZ+Za9FACcC8Trvdi9lgdzyJPUFe8yIGW6W1md1DrhI/hq
         gFBA==
X-Gm-Message-State: AO0yUKWh3Ab4paqYFpxLLHBXrVNFaBSDUY5IbKecZ8wmmEweWg8X/wJs
	aHZWSb6Y3MAiELOKs0mUUHTeJH1gJjADk67Cowg=
X-Google-Smtp-Source: AK7set/5fhclHELZ1+81PN7gBLQ1uJVWzKGIIEskN+xtazSKPtVywzgaOSon9w2rfkT3T4vuExtASyShT2RHAl/jDlU=
X-Received: by 2002:a5d:638d:0:b0:2c7:150c:a0f4 with SMTP id
 p13-20020a5d638d000000b002c7150ca0f4mr2050406wru.3.1678118669051; Mon, 06 Mar
 2023 08:04:29 -0800 (PST)
MIME-Version: 1.0
References: <1748E9A04D5EFD06.26202@lists.openembedded.org> <1748EB9FF7582344.26202@lists.openembedded.org>
In-Reply-To: <1748EB9FF7582344.26202@lists.openembedded.org>
From: Martin Jansa <martin.jansa@gmail.com>
Date: Mon, 6 Mar 2023 17:04:17 +0100
Message-ID: <CA+chaQczj6nxc_KaxfaKUE4tecsjDDxneuYzwL-=Z6mBAapvcQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [RFC][PATCH] providers.sh: versionVariableMatch:
 use the name of provided item instead of pn
To: Martin.Jansa@gmail.com
Cc: bitbake-devel@lists.openembedded.org, khem.raj@gmail.com
Content-Type: multipart/alternative; boundary="00000000000028ec8905f63d73b7"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 06 Mar 2023 16:04:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14523

--00000000000028ec8905f63d73b7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

FWIW: the suggested solution for meta-clang works with master/mickledore,
but doesn't work for langdale and kirkstone as those were using LLVMVERSION
for other things as well:

meta/classes-recipe/meson.bbclass:llvm-config =3D 'llvm-config${LLVMVERSION=
}'
meta/conf/distro/include/tcmode-default.inc:LLVMVERSION ?=3D "14.0.6"
meta/conf/distro/include/tcmode-default.inc:PREFERRED_VERSION_llvm =3D
"${LLVMVERSION}"
meta/conf/distro/include/tcmode-default.inc:PREFERRED_VERSION_llvm-native =
=3D
"${LLVMVERSION}"
meta/conf/distro/include/tcmode-default.inc:PREFERRED_VERSION_nativesdk-llv=
m
=3D "${LLVMVERSION}"
meta/recipes-graphics/mesa/mesa.inc:MESA_LLVM_RELEASE ?=3D "${LLVMVERSION}"

So e.g. with kirkstone when meta-clang provides llvm-config14.0.6 mesa will
still search for llvm-config13.0.1 as in meson.bbclass and fails with:

WARNING: Ignoring LLVM CMake dependency because dynamic was requested
llvm-config binary for 1 specified from cross file, native file, or env var
as ['llvm-config13.0.1']
llvm-config found: NO need ['>=3D 3.9.0']

MESA_LLVM_RELEASE can be easily set in meta-clang with CLANGLLVMVERSION,
but we would need separate variable for llvm-config used by meson.bbclass
and at that point it might be easier to just drop P_V_*llvm* to avoid
confusing warning about unavailable version.

On Fri, Mar 3, 2023 at 2:25=E2=80=AFPM Martin Jansa via lists.openembedded.=
org
<Martin.Jansa=3Dgmail.com@lists.openembedded.org> wrote:

> Please do not merge, there are couple of typos in commit message and I'm
> starting to prefer to change this in meta-clang instead as in:
>
> https://github.com/shr-project/meta-clang/commit/61e8b5635db25e55757157b5=
5ad63a66e4286d96
>
> On Fri, Mar 3, 2023 at 1:49=E2=80=AFPM Martin Jansa via lists.openembedde=
d.org
> <Martin.Jansa=3Dgmail.com@lists.openembedded.org> wrote:
>
>> * when checking for PREFERRED_VERSION and REQUIRED_VERSION use
>>   the name of the preferred item, not the pn of the provider
>>
>> * sending as RFC, because there might be some other uses of
>>   this function where the old behavior was better
>>
>> * the case where this seems to work incorrectly is meta-clang clang reci=
pe
>>   which correctly says:
>>
>>   conf/layer.conf:LLVMVERSION =3D "15.0.7"
>>   conf/layer.conf:PREFERRED_PROVIDER_llvm-native =3D "clang-native"
>>   recipes-devtools/clang/clang_git.bb:PROVIDES:append:class-native =3D "
>> llvm-native"
>>
>>   LLVMVERSION is used by oe-core as:
>>   meta/conf/distro/include/tcmode-default.inc:LLVMVERSION ?=3D "15.%"
>>   meta/conf/distro/include/tcmode-default.inc:PREFERRED_VERSION_llvm =3D
>> "${LLVMVERSION}"
>>
>> meta/conf/distro/include/tcmode-default.inc:PREFERRED_VERSION_llvm-nativ=
e =3D
>> "${LLVMVERSION}"
>>
>> meta/conf/distro/include/tcmode-default.inc:PREFERRED_VERSION_nativesdk-=
llvm
>> =3D "${LLVMVERSION}"
>>
>>   and now this code will cause a warning about 15.0.7 version not being
>> available
>>   even when in the end it will use clang-native as a provider with this
>> version:
>>
>>   $ bitbake-getvar -r llvm-native PV 2>&1 | tee
>> log.bitbake-getvar.llvm-native-4
>>   WARNING: preferred version 15.0.7 of llvm-native not available (for
>> item llvm-native)
>>   WARNING: versions of llvm-native available: 15.0.6
>>   #
>>   # $PV [4 operations]
>>   #   set oe-core/meta/conf/bitbake.conf:239
>>   #     "${@bb.parse.vars_from_file(d.getVar('FILE', False),d)[1] or
>> '1.0'}"
>>   #   set oe-core/meta/conf/documentation.conf:340
>>   #     [doc] "The version of the recipe. The version is normally
>> extracted from the recipe filename."
>>   #   set oe-core/meta/classes-global/sstate.bbclass:51
>>   #     [vardepvalue] "${PV}"
>>   #   set meta-clang/recipes-devtools/clang/clang.inc:13
>>   #     "${MAJOR_VER}.${MINOR_VER}.${PATCH_VER}"
>>   # pre-expansion value:
>>   #   "${MAJOR_VER}.${MINOR_VER}.${PATCH_VER}"
>>   PV=3D"15.0.7"
>>
>>   the problem is that both llvm-native from oe-core and clang-native are
>>   found as possible providers for item llvm-native, but then we call
>>   findPreferredProvider for pkg_pn clang-native, we'll check for
>>   PREFERRED_VERSION_clang_native not PREFERRED_VERSION_llvm-native
>>
>>   then when running findPreferredProvider for pkg_pn llvm-native
>>   we find the PREFERRED_VERSION_llvm-native and if it doesn't
>>   match with PV we issue the warning, be aware that this issue
>>   is reproducible only when they don't happen to match, e.g. with
>>   master before:
>>
>> https://git.openembedded.org/openembedded-core/commit/?id=3D7438f9a9efaf=
0826f1be13acbc51f0a1134cf175
>>   in dunfell it's triggered as well, with different versions:
>>
>
> this was with kirkstone not dunfell
>
>
>>
>>   WARNING: preferred version 14.0.3 of llvm-native not available (for
>> item llvm-native)
>>   WARNING: versions of llvm-native available: 13.0.1
>>
>> * if we agree that this is something worth changing, then the
>>   search for available versions should be similarly changed
>>   as well, because now in dunfell it shows only 13.0.1
>>   while clang-native-14.0.3 is also available provider for
>>   it (and actually gets used in the end).
>>
>> * this might make some sense for llvm-native and clang-native
>>   but I can imagine counter example when you have 2 very different
>>   providers for something and you want to control their versions
>>   independently from which provider is preferred e.g. by MACHINE.conf
>>
>
> The counter example could be something like
>
> # Prefer latest-greatest from fancy layer instead of boring 22.3.5 from
> oe-core
> PREFERRED_VERSION_virtual/libgles3 ?=3D "23.0.0"
>
> and some MACHINEs using
> PREFERRED_PROVIDER_virtual/libgles3 ?=3D "mesa"
> while others (breaking multi-machine builds if they happen to use the sam=
e
> TUNE_PKGARCH):
> PREFERRED_PROVIDER_virtual/libgles3 ?=3D "some-ugly-blobs-from-vendor"
>
> With some-ugly-blobs-from-vendor recipe having PV =3D "0.0.1" because tha=
t's
> what vendors do.
>
> The current behavior where you can independently set
> PREFERRED_VERSION_mesa and PREFERRED_VERSION_some-ugly-blobs-from-vendor
>
> and leave PREFERRED_PROVIDER to choose between them is cleaner than
> setting PREFERRED_VERSION_virtual/libgles3 conditionally based on which
> provider is preferred.
>
>
>> * this change didn't cause any new warnings in my builds, but other
>>   layers might be more creative with P_V/P_P
>>
>> * alternative solution might be to use different variable name
>>   in meta-clang/conf/layer.conf to avoid changing llvm-native P_V
>>   and depend on P_P to always select clang recipes to provide llvm
>>   which might be less controversial than this P_V behavoir change
>>
>>   I have a local commit which changes LLVMVERSION to CLANGLLVMVERSION
>>   in these 3 meta-clang places:
>>   conf/layer.conf:LLVMVERSION =3D "14.0.3"
>>   dynamic-layers/openembedded-layer/recipes-devtools/bcc/bcc_0.24.0.bb:
>>   -DLLVM_PACKAGE_VERSION=3D${LLVMVERSION} \
>>   dynamic-layers/openembedded-layer/recipes-devtools/bpftrace/
>> bpftrace_0.14.1.bb:    pvsplit =3D d.getVar('LLVMVERSION').split('.')
>>
>
>  Pushed to my meta-clang fork:
>
> https://github.com/shr-project/meta-clang/commit/61e8b5635db25e55757157b5=
5ad63a66e4286d96
> will send PR to Khem if we agree that this is indeed better solution (at
> least until LLVMVERSION gets used for other things than P_V in oe-core an=
d
> we'll need to be able to easily change it from other layers).
>
> Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
>> ---
>>  lib/bb/providers.py | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/lib/bb/providers.py b/lib/bb/providers.py
>> index e11a4637d..1aa0d1282 100644
>> --- a/lib/bb/providers.py
>> +++ b/lib/bb/providers.py
>> @@ -124,8 +124,8 @@ def findPreferredProvider(pn, cfgData, dataCache,
>> pkg_pn =3D None, item =3D None):
>>      preferred_ver =3D None
>>      required =3D False
>>
>> -    required_v =3D versionVariableMatch(cfgData, "REQUIRED", pn)
>> -    preferred_v =3D versionVariableMatch(cfgData, "PREFERRED", pn)
>> +    required_v =3D versionVariableMatch(cfgData, "REQUIRED", item)
>> +    preferred_v =3D versionVariableMatch(cfgData, "PREFERRED", item)
>>
>>      itemstr =3D ""
>>      if item:
>> --
>> 2.39.2
>>
>>
>>
>>
>>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#14522):
> https://lists.openembedded.org/g/bitbake-devel/message/14522
> Mute This Topic: https://lists.openembedded.org/mt/97360853/3617156
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> Martin.Jansa@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--00000000000028ec8905f63d73b7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">FWIW: the suggested solution for meta-clang works with mas=
ter/mickledore, but doesn&#39;t work for langdale and kirkstone as those we=
re using LLVMVERSION for other things as well:<div><br></div><div>meta/clas=
ses-recipe/meson.bbclass:llvm-config =3D &#39;llvm-config${LLVMVERSION}&#39=
;<br>meta/conf/distro/include/tcmode-default.inc:LLVMVERSION ?=3D &quot;14.=
0.6&quot;<br>meta/conf/distro/include/tcmode-default.inc:PREFERRED_VERSION_=
llvm =3D &quot;${LLVMVERSION}&quot;<br>meta/conf/distro/include/tcmode-defa=
ult.inc:PREFERRED_VERSION_llvm-native =3D &quot;${LLVMVERSION}&quot;<br>met=
a/conf/distro/include/tcmode-default.inc:PREFERRED_VERSION_nativesdk-llvm =
=3D &quot;${LLVMVERSION}&quot;<br>meta/recipes-graphics/mesa/mesa.inc:MESA_=
LLVM_RELEASE ?=3D &quot;${LLVMVERSION}&quot;<br></div><div><br></div><div>S=
o e.g. with kirkstone when meta-clang provides=C2=A0llvm-config14.0.6 mesa =
will still search for llvm-config13.0.1 as in meson.bbclass and fails with:=
</div><div><br></div><div>WARNING: Ignoring LLVM CMake dependency because d=
ynamic was requested</div><div>llvm-config binary for 1 specified from cros=
s file, native file, or env var as [&#39;llvm-config13.0.1&#39;]<br>llvm-co=
nfig found: NO need [&#39;&gt;=3D 3.9.0&#39;]<br></div><div><br></div><div>=
MESA_LLVM_RELEASE can be easily set in meta-clang with CLANGLLVMVERSION, bu=
t we would need separate variable for llvm-config used by meson.bbclass and=
 at that point it might be easier to just drop P_V_*llvm* to avoid confusin=
g warning about unavailable version.<br></div></div><br><div class=3D"gmail=
_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Mar 3, 2023 at 2:25=
=E2=80=AFPM Martin Jansa via <a href=3D"http://lists.openembedded.org">list=
s.openembedded.org</a> &lt;Martin.Jansa=3D<a href=3D"mailto:gmail.com@lists=
.openembedded.org">gmail.com@lists.openembedded.org</a>&gt; wrote:<br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div>Pl=
ease do not merge, there are couple of typos in commit message and I&#39;m =
starting to prefer to change this in meta-clang instead as in:</div><div><a=
 href=3D"https://github.com/shr-project/meta-clang/commit/61e8b5635db25e557=
57157b55ad63a66e4286d96" target=3D"_blank">https://github.com/shr-project/m=
eta-clang/commit/61e8b5635db25e55757157b55ad63a66e4286d96</a><br></div><br>=
<div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Ma=
r 3, 2023 at 1:49=E2=80=AFPM Martin Jansa via <a href=3D"http://lists.opene=
mbedded.org" target=3D"_blank">lists.openembedded.org</a> &lt;Martin.Jansa=
=3D<a href=3D"mailto:gmail.com@lists.openembedded.org" target=3D"_blank">gm=
ail.com@lists.openembedded.org</a>&gt; wrote:<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">* when checking for PREFERRED_VERSION and REQ=
UIRED_VERSION use<br>
=C2=A0 the name of the preferred item, not the pn of the provider<br>
<br>
* sending as RFC, because there might be some other uses of<br>
=C2=A0 this function where the old behavior was better<br>
<br>
* the case where this seems to work incorrectly is meta-clang clang recipe<=
br>
=C2=A0 which correctly says:<br>
<br>
=C2=A0 conf/layer.conf:LLVMVERSION =3D &quot;15.0.7&quot;<br>
=C2=A0 conf/layer.conf:PREFERRED_PROVIDER_llvm-native =3D &quot;clang-nativ=
e&quot;<br>
=C2=A0 recipes-devtools/clang/clang_git.bb:PROVIDES:append:class-native =3D=
 &quot; llvm-native&quot;<br>
<br>
=C2=A0 LLVMVERSION is used by oe-core as:<br>
=C2=A0 meta/conf/distro/include/tcmode-default.inc:LLVMVERSION ?=3D &quot;1=
5.%&quot;<br>
=C2=A0 meta/conf/distro/include/tcmode-default.inc:PREFERRED_VERSION_llvm =
=3D &quot;${LLVMVERSION}&quot;<br>
=C2=A0 meta/conf/distro/include/tcmode-default.inc:PREFERRED_VERSION_llvm-n=
ative =3D &quot;${LLVMVERSION}&quot;<br>
=C2=A0 meta/conf/distro/include/tcmode-default.inc:PREFERRED_VERSION_native=
sdk-llvm =3D &quot;${LLVMVERSION}&quot;<br>
<br>
=C2=A0 and now this code will cause a warning about 15.0.7 version not bein=
g available<br>
=C2=A0 even when in the end it will use clang-native as a provider with thi=
s version:<br>
<br>
=C2=A0 $ bitbake-getvar -r llvm-native PV 2&gt;&amp;1 | tee log.bitbake-get=
var.llvm-native-4<br>
=C2=A0 WARNING: preferred version 15.0.7 of llvm-native not available (for =
item llvm-native)<br>
=C2=A0 WARNING: versions of llvm-native available: 15.0.6<br>
=C2=A0 #<br>
=C2=A0 # $PV [4 operations]<br>
=C2=A0 #=C2=A0 =C2=A0set oe-core/meta/conf/bitbake.conf:239<br>
=C2=A0 #=C2=A0 =C2=A0 =C2=A0&quot;${@bb.parse.vars_from_file(d.getVar(&#39;=
FILE&#39;, False),d)[1] or &#39;1.0&#39;}&quot;<br>
=C2=A0 #=C2=A0 =C2=A0set oe-core/meta/conf/documentation.conf:340<br>
=C2=A0 #=C2=A0 =C2=A0 =C2=A0[doc] &quot;The version of the recipe. The vers=
ion is normally extracted from the recipe filename.&quot;<br>
=C2=A0 #=C2=A0 =C2=A0set oe-core/meta/classes-global/sstate.bbclass:51<br>
=C2=A0 #=C2=A0 =C2=A0 =C2=A0[vardepvalue] &quot;${PV}&quot;<br>
=C2=A0 #=C2=A0 =C2=A0set meta-clang/recipes-devtools/clang/clang.inc:13<br>
=C2=A0 #=C2=A0 =C2=A0 =C2=A0&quot;${MAJOR_VER}.${MINOR_VER}.${PATCH_VER}&qu=
ot;<br>
=C2=A0 # pre-expansion value:<br>
=C2=A0 #=C2=A0 =C2=A0&quot;${MAJOR_VER}.${MINOR_VER}.${PATCH_VER}&quot;<br>
=C2=A0 PV=3D&quot;15.0.7&quot;<br>
<br>
=C2=A0 the problem is that both llvm-native from oe-core and clang-native a=
re<br>
=C2=A0 found as possible providers for item llvm-native, but then we call<b=
r>
=C2=A0 findPreferredProvider for pkg_pn clang-native, we&#39;ll check for<b=
r>
=C2=A0 PREFERRED_VERSION_clang_native not PREFERRED_VERSION_llvm-native<br>
<br>
=C2=A0 then when running findPreferredProvider for pkg_pn llvm-native<br>
=C2=A0 we find the PREFERRED_VERSION_llvm-native and if it doesn&#39;t<br>
=C2=A0 match with PV we issue the warning, be aware that this issue<br>
=C2=A0 is reproducible only when they don&#39;t happen to match, e.g. with<=
br>
=C2=A0 master before:<br>
=C2=A0 <a href=3D"https://git.openembedded.org/openembedded-core/commit/?id=
=3D7438f9a9efaf0826f1be13acbc51f0a1134cf175" rel=3D"noreferrer" target=3D"_=
blank">https://git.openembedded.org/openembedded-core/commit/?id=3D7438f9a9=
efaf0826f1be13acbc51f0a1134cf175</a><br>
=C2=A0 in dunfell it&#39;s triggered as well, with different versions:<br><=
/blockquote><div><br></div><div>this was with kirkstone not dunfell</div><d=
iv>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
=C2=A0 WARNING: preferred version 14.0.3 of llvm-native not available (for =
item llvm-native)<br>
=C2=A0 WARNING: versions of llvm-native available: 13.0.1<br>
<br>
* if we agree that this is something worth changing, then the<br>
=C2=A0 search for available versions should be similarly changed<br>
=C2=A0 as well, because now in dunfell it shows only 13.0.1<br>
=C2=A0 while clang-native-14.0.3 is also available provider for<br>
=C2=A0 it (and actually gets used in the end).<br>
<br>
* this might make some sense for llvm-native and clang-native<br>
=C2=A0 but I can imagine counter example when you have 2 very different<br>
=C2=A0 providers for something and you want to control their versions<br>
=C2=A0 independently from which provider is preferred e.g. by MACHINE.conf<=
br></blockquote><div><br></div><div>The counter example could be something =
like</div><div><br></div><div># Prefer latest-greatest from fancy layer ins=
tead of boring=C2=A022.3.5 from oe-core</div><div>PREFERRED_VERSION_virtual=
/libgles3 ?=3D &quot;23.0.0&quot;</div><div><br></div><div>and some MACHINE=
s using</div><div>PREFERRED_PROVIDER_virtual/libgles3 ?=3D &quot;mesa&quot;=
<br></div><div>while others (breaking multi-machine builds if they happen t=
o use the same TUNE_PKGARCH):</div><div>PREFERRED_PROVIDER_virtual/libgles3=
 ?=3D &quot;some-ugly-blobs-from-vendor&quot;<br></div><div><br></div><div>=
With some-ugly-blobs-from-vendor recipe having PV =3D &quot;0.0.1&quot; bec=
ause that&#39;s what vendors do.</div><div><br></div><div>The current behav=
ior where you can independently set</div><div>PREFERRED_VERSION_mesa and PR=
EFERRED_VERSION_some-ugly-blobs-from-vendor<br></div><div><br></div><div>an=
d leave PREFERRED_PROVIDER to choose between them is cleaner than setting P=
REFERRED_VERSION_virtual/libgles3 conditionally based on which provider is =
preferred.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">
* this change didn&#39;t cause any new warnings in my builds, but other<br>
=C2=A0 layers might be more creative with P_V/P_P<br>
<br>
* alternative solution might be to use different variable name<br>
=C2=A0 in meta-clang/conf/layer.conf to avoid changing llvm-native P_V<br>
=C2=A0 and depend on P_P to always select clang recipes to provide llvm<br>
=C2=A0 which might be less controversial than this P_V behavoir change<br>
<br>
=C2=A0 I have a local commit which changes LLVMVERSION to CLANGLLVMVERSION<=
br>
=C2=A0 in these 3 meta-clang places:<br>
=C2=A0 conf/layer.conf:LLVMVERSION =3D &quot;14.0.3&quot;<br>
=C2=A0 dynamic-layers/openembedded-layer/recipes-devtools/bcc/<a href=3D"ht=
tp://bcc_0.24.0.bb" rel=3D"noreferrer" target=3D"_blank">bcc_0.24.0.bb</a>:=
=C2=A0 =C2=A0 -DLLVM_PACKAGE_VERSION=3D${LLVMVERSION} \<br>
=C2=A0 dynamic-layers/openembedded-layer/recipes-devtools/bpftrace/<a href=
=3D"http://bpftrace_0.14.1.bb" rel=3D"noreferrer" target=3D"_blank">bpftrac=
e_0.14.1.bb</a>:=C2=A0 =C2=A0 pvsplit =3D d.getVar(&#39;LLVMVERSION&#39;).s=
plit(&#39;.&#39;)<br></blockquote><div><br></div><div>=C2=A0Pushed to my me=
ta-clang fork:</div><div><a href=3D"https://github.com/shr-project/meta-cla=
ng/commit/61e8b5635db25e55757157b55ad63a66e4286d96" target=3D"_blank">https=
://github.com/shr-project/meta-clang/commit/61e8b5635db25e55757157b55ad63a6=
6e4286d96</a><br></div><div>will send PR to Khem if we agree that this is i=
ndeed better solution (at least until LLVMVERSION gets used for other thing=
s than P_V in oe-core and we&#39;ll need to be able to easily change it fro=
m other layers).</div><div><br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">
Signed-off-by: Martin Jansa &lt;<a href=3D"mailto:Martin.Jansa@gmail.com" t=
arget=3D"_blank">Martin.Jansa@gmail.com</a>&gt;<br>
---<br>
=C2=A0lib/bb/providers.py | 4 ++--<br>
=C2=A01 file changed, 2 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/lib/bb/providers.py b/lib/bb/providers.py<br>
index e11a4637d..1aa0d1282 100644<br>
--- a/lib/bb/providers.py<br>
+++ b/lib/bb/providers.py<br>
@@ -124,8 +124,8 @@ def findPreferredProvider(pn, cfgData, dataCache, pkg_p=
n =3D None, item =3D None):<br>
=C2=A0 =C2=A0 =C2=A0preferred_ver =3D None<br>
=C2=A0 =C2=A0 =C2=A0required =3D False<br>
<br>
-=C2=A0 =C2=A0 required_v =3D versionVariableMatch(cfgData, &quot;REQUIRED&=
quot;, pn)<br>
-=C2=A0 =C2=A0 preferred_v =3D versionVariableMatch(cfgData, &quot;PREFERRE=
D&quot;, pn)<br>
+=C2=A0 =C2=A0 required_v =3D versionVariableMatch(cfgData, &quot;REQUIRED&=
quot;, item)<br>
+=C2=A0 =C2=A0 preferred_v =3D versionVariableMatch(cfgData, &quot;PREFERRE=
D&quot;, item)<br>
<br>
=C2=A0 =C2=A0 =C2=A0itemstr =3D &quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0if item:<br>
-- <br>
2.39.2<br>
<br>
<br>
<br>
<br>
</blockquote></div></div>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#14522): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/14522" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/14522</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/97360853/3617=
156" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/mt=
/97360853/3617156</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:Martin.Jansa@gmail.com" target=3D"=
_blank">Martin.Jansa@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div>

--00000000000028ec8905f63d73b7--

