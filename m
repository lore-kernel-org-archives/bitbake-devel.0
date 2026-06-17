Return-Path: <rob.woolleywr@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E90CD98F6
	for <webhook@archiver.kernel.org>; Wed, 17 Jun 2026 19:14:40 +0000 (UTC)
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2907.1781723671051370370
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 17 Jun 2026 12:14:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=m0zfvcmu;
 spf=pass (domain: gmail.com, ip: 74.125.224.42, mailfrom: rob.woolleywr@gmail.com)
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-660390acd71so1391668d50.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 17 Jun 2026 12:14:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781723670; cv=none;
        d=google.com; s=arc-20240605;
        b=IHGuEMuluj+xBZdr6GOp83ZS60iBviFNpUQBiYzz2A/D0YcRuI5EDoodvp5zH0pr7Y
         Yov2xeP96VNVt1G5oDQOlhOl0gxTa3Oo+W+5KRjKiEDe5EfPEaePDczKl6BfwmMJQ0ci
         0zWVgMgh93H893v346G31O04R2LmI4+qpY2JpRKgxWtZnezVCV2E0vVagWx5JYVsiY+3
         8wZE82vJl8hZJSLzQi3pQ3TAImyXB5BXPqkJQdwAR48zAmSkAC0ELExUBW5/5hPf2rxe
         SPhA4U9I5uWbSBok7LEEuOJK+MemF3oYCTElBazEKoCp/mgoFfCjOvbjjeS5emMtFCon
         COXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=0O1QLZv2xxbAuzPylaVfHnNjWEnkut93NeBUkoZ1oz4=;
        fh=2BaMlckdRBZn8mz+QEoiT/Cil/N4O8kIotYyQ4fi5Fg=;
        b=ZU5U+VOSzaLB3nUw8xHN9rX+E2DR42+ru7GgI1UUTz0eTmLH1oCe5kTHtOGCJKuoM7
         G5PjatCQyk81QoINLxzA1AQKDYJX2W+YscC/JPtx6pqPVp4xDhH+McALAw2oYqbEPMfu
         AjlCenFXt9y7HRoYmyefnPlHsCdSY+Qp0MAm8cCAa1IUdJWc5fWOiwoQ3En7x6hA1ITi
         DJwEQwMskRgIu8498FDZp/cR6tj65TvCM4rmolrswrOupbGCXVV7lk7pwSc7ShhqtBO1
         GmI5yJaXKeqb+XHg1a3wRCwOnEh/ItPDA+IVMP+J5cenBKclfjQyzLowQGszkoHgYSED
         s3IA==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781723670; x=1782328470; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0O1QLZv2xxbAuzPylaVfHnNjWEnkut93NeBUkoZ1oz4=;
        b=m0zfvcmuxY3Ot3IIouXjvFSQZldrjseVczPlvT10GT6ZmshrQbkV1OgB1ZwIT2a0KU
         xPd6ZTBSTuB3HzuKehyM23RMfiQn/EsmTf9Cy5IwtVdmcLswE/tw78+4ZGoRIL32jKeW
         ZpAx9yb4Pco9bnOwcPknVmBHvgXF3mqs6kpiwlSw72bsxnb/Q2nVcyy7orgMiHTr3Mwe
         VKhyKtd5FxfPqikz6UXSIMqUOVqI0PYntF1iPfca5vPHwdLcnb98cNXn3/dxdwj4yKDu
         wIjhxU4w7U/vZOsi8O8iUV71ICzyC1aNMf3yzkBGdWzdBMfMi+qil640Dvn07K645ov8
         /9Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781723670; x=1782328470;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0O1QLZv2xxbAuzPylaVfHnNjWEnkut93NeBUkoZ1oz4=;
        b=ggPQlquuKTLLsfbSe8x/sX9rkRXIuZnMnJGkIdeFLwDu3EM0wKxIO26lwlF0XdNeWO
         jGEEd6pI/sboFM6RXHO/HnKwvXLB1z4MeLB8vx0w6w4PXoUyumZ7763x6JQ27wWAWnlj
         DHGvuu08TktQlFKJuNEYD8HKAVqxUvRKooNwfJ4JDQNpJ6S+urifHPBFJyrCFtoPV2Yq
         ca2D2oxe1uUSlT0SKw6mpIZJxhFRrjJcCqEu4mHsQHbUOSwV2ZBiduqFOTRdhSVAYtDN
         CDRVT0Sk6mCUpnnQqCSHOJBjBUJTUY+n2tDNSIavtrT6Cr7UjmnCs+J8B1PSuzLW5vrY
         u/oQ==
X-Gm-Message-State: AOJu0YxX7fEOXGx2ElNk4M5dBSFv7dvafjqzB5Y1INMrit+I7J9EOoNV
	aOhYsNaHxmg5iDGr7s6qPkkt/mjNrAnTAwyXowtJkAX9SGYSD4Lv41RUvHZHQC2RrXlPdqFD+UO
	OuqSS9VFC6YKBvURjrI9tg4yYWyo3iHsorIAP
X-Gm-Gg: AfdE7cldDmynM0cPudKmBpd+HVwLxptfxX/A8fzYWz3gp6d73+9yeNVBuRgWNaQswo/
	rFZR9SnP/CelDKe2ebq0TCNgYDJFPU0LDSATr4hov4o3OCjwoufRLsiornYjkwtBuzezc4OTQUs
	gRTjquOrJb9hO9HLzxIMQW4T2Owwwd56d2poS/ul6fuabB2f90w3AZie6V8pow4jI9N2VCuVmKB
	EHpF/AU/uUn4Ph/wrwdGHm/MFaEViNMA8TocYNbjC/MTjynXQA6+1yD2aCbXgkZ0tPzukMrTlMv
	3HUTKG4BoISqeLYkjtP20BwH8MOo
X-Received: by 2002:a05:690e:1686:b0:662:c78e:3943 with SMTP id
 956f58d0204a3-662e3e2b50bmr795415d50.38.1781723669923; Wed, 17 Jun 2026
 12:14:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260331145319.3125456-1-rob.woolley@windriver.com>
 <20260331145319.3125456-6-rob.woolley@windriver.com> <5A75C01A-3B75-4531-AEEE-63A308978CF7@arm.com>
In-Reply-To: <5A75C01A-3B75-4531-AEEE-63A308978CF7@arm.com>
From: Rob Woolley <rob.woolleywr@gmail.com>
Date: Wed, 17 Jun 2026 15:14:18 -0400
X-Gm-Features: AVVi8Cc7wNxOwfvQD75wJ5fT_d3q0b-mKDmm73WbY5xGdQqYaohhZvSYYnmHu_g
Message-ID: <CAGAhMBzX7unc5kcm4wixTJaQNeUF5cESxc2FWu2YC3Z+NUftaw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 5/6] lib: Vendorize bundled third-party
 libraries under bb._vendor
To: ross.burton@arm.com
Cc: "bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="0000000000006f09f7065477de32"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 17 Jun 2026 19:14:40 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19730

--0000000000006f09f7065477de32
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ross,

I followed your advice and added support for vendoring:
https://github.com/robwoolley/bitbake/commits/vendoring/  Is this what you
had in mind?

I reviewed the patches for the vendored modules:

*beautifulsoup4*

   - most patches seemed to be for Python 3 support
   - I brought forward 2 patches into vendor/patches:
      - lib/bs4: Avoid soupsieve warning
      - lib: Remove double imports

*ply*

   - patches were all removed
   - some had been merged upgrade
   - patches related to FIPS issues in the signature function were no
   longer necessary due to refactoring upstream
   - ply is no longer maintained

*simplediff*

   - No changes were made, the version remains the same

*progressbar*

   - all 6 patches were refreshed


One drawback is that I had to add pyproject.toml for "vendoring sync ." to
work.  I wonder if this could cause confusion for people that expect it to
be a full Python project configuration file and try to use "python3 -m
build".

We may want to consider adding a complete pyproject.toml at the top-level.

Here are my testing instructions for anyone who wishes to follow along:
```
git clone -b vendoring https://github.com/robwoolley/bitbake
bitbake-vendoring
cd bitbake-vendoring
bin/bitbake-setup init poky-master
# Accept the options
# Source the build env:    .
/ala-lpggp31/rwoolley/bitbake-vendoring/bitbake-builds/poky-master/build/in=
it-build-env
cd ../layers/bitbake
git remote add robwoolley https://github.com/robwoolley/bitbake
git remote update robwoolley
git checkout vendoring
cd $BUILDDIR
bitbake core-image-minimal
```

Regards,
Rob

On Thu, Apr 30, 2026 at 6:10=E2=80=AFAM Ross Burton via lists.openembedded.=
org
<ross.burton=3Darm.com@lists.openembedded.org> wrote:

> On 31 Mar 2026, at 15:53, Rob Woolley via lists.openembedded.org
> <rob.woolley=3Dwindriver.com@lists.openembedded.org> wrote:
> >
> > Move ply, progressbar, simplediff, and bs4 from lib/ into
> > lib/bb/_vendor/ to avoid conflicts with system-installed versions
> > and to support proper packaging. These libraries contain local
> > modifications from their upstream versions.
>
> I=E2=80=99d like to see the vendoring done with a tool that lets us updat=
e the
> bundled libraries easily in the future, to be honest.
>
> When I wrote picobuild (now redundant as pypa/build can bootstrap itself)
> I used the same tool that pip uses to vendor its dependencies:
> https://github.com/pradyunsg/vendoring.  So
> https://gitlab.com/rossburton/picobuild is a minimal example of using
> vendoring: a few lines of configuration in pyproject.toml and a separate
> requirements file.
>
> Obviously if we sync from upstream we=E2=80=99ll drop our local changes, =
so the
> question then is why do we have forks?  Note that vendoring can apply
> patches when it updates, so if there=E2=80=99s a simple but not-upstreama=
ble change
> we can carry the patch in-tree.
>
> Ross
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#19419):
> https://lists.openembedded.org/g/bitbake-devel/message/19419
> Mute This Topic: https://lists.openembedded.org/mt/118597577/556952
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> rob.woolleywr@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--0000000000006f09f7065477de32
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Ross,<div><br></div><div>I followed your advice and add=
ed support for vendoring:=C2=A0<a href=3D"https://github.com/robwoolley/bit=
bake/commits/vendoring/">https://github.com/robwoolley/bitbake/commits/vend=
oring/</a>=C2=A0 Is this what you had in mind?</div><div><br></div><div>I r=
eviewed=C2=A0the patches for the vendored modules:</div><div><br></div><div=
><span style=3D"background-color:transparent"><b>beautifulsoup4</b></span><=
/div><div><ul><li>most patches seemed to be for Python 3 support</li><li>I =
brought forward 2 patches into vendor/patches:</li><ul><li>lib/bs4:=C2=A0Av=
oid soupsieve warning</li><li>lib: Remove double imports</li></ul></ul></di=
v><div><b>ply</b></div><div><ul><li>patches were all removed</li><li>some h=
ad been merged upgrade</li><li>patches related to FIPS issues in the signat=
ure function were no longer necessary due to refactoring upstream</li><li>p=
ly is no longer maintained</li></ul><div><b>simplediff</b></div></div><div>=
<ul><li>No changes were made, the version remains the same</li></ul><div><b=
>progressbar</b></div><div><ul><li>all 6 patches were refreshed</li></ul></=
div><div><br>One drawback is that I had to add pyproject.toml for &quot;ven=
doring sync .&quot; to work.=C2=A0 I wonder if this could cause=C2=A0confus=
ion for people that expect it to be a full Python project configuration fil=
e and try to use &quot;python3 -m build&quot;.<br><br>We may want to consid=
er adding a complete pyproject.toml at the top-level.<br><br>Here are my te=
sting instructions for anyone who wishes to follow along:</div><div>```</di=
v><div>git clone -b vendoring <a href=3D"https://github.com/robwoolley/bitb=
ake">https://github.com/robwoolley/bitbake</a> bitbake-vendoring<br>cd bitb=
ake-vendoring<br>bin/bitbake-setup init poky-master<br># Accept the options=
<br># Source the build env:=C2=A0 =C2=A0 . /ala-lpggp31/rwoolley/bitbake-ve=
ndoring/bitbake-builds/poky-master/build/init-build-env<br>cd ../layers/bit=
bake<br>git remote add robwoolley <a href=3D"https://github.com/robwoolley/=
bitbake">https://github.com/robwoolley/bitbake</a><br>git remote update rob=
woolley<br>git checkout vendoring<br>cd $BUILDDIR<br>bitbake core-image-min=
imal<br>```</div><div><br>Regards,</div></div><div>Rob</div></div><br><div =
class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail=
_attr">On Thu, Apr 30, 2026 at 6:10=E2=80=AFAM Ross Burton via <a href=3D"h=
ttp://lists.openembedded.org">lists.openembedded.org</a> &lt;ross.burton=3D=
<a href=3D"mailto:arm.com@lists.openembedded.org">arm.com@lists.openembedde=
d.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">On 31 Mar 2026, at 15:53, Rob Woolley via <a href=3D"http://lists.open=
embedded.org" rel=3D"noreferrer" target=3D"_blank">lists.openembedded.org</=
a> &lt;rob.woolley=3D<a href=3D"mailto:windriver.com@lists.openembedded.org=
" target=3D"_blank">windriver.com@lists.openembedded.org</a>&gt; wrote:<br>
&gt; <br>
&gt; Move ply, progressbar, simplediff, and bs4 from lib/ into<br>
&gt; lib/bb/_vendor/ to avoid conflicts with system-installed versions<br>
&gt; and to support proper packaging. These libraries contain local<br>
&gt; modifications from their upstream versions.<br>
<br>
I=E2=80=99d like to see the vendoring done with a tool that lets us update =
the bundled libraries easily in the future, to be honest.<br>
<br>
When I wrote picobuild (now redundant as pypa/build can bootstrap itself) I=
 used the same tool that pip uses to vendor its dependencies: <a href=3D"ht=
tps://github.com/pradyunsg/vendoring" rel=3D"noreferrer" target=3D"_blank">=
https://github.com/pradyunsg/vendoring</a>.=C2=A0 So <a href=3D"https://git=
lab.com/rossburton/picobuild" rel=3D"noreferrer" target=3D"_blank">https://=
gitlab.com/rossburton/picobuild</a> is a minimal example of using vendoring=
: a few lines of configuration in pyproject.toml and a separate requirement=
s file.<br>
<br>
Obviously if we sync from upstream we=E2=80=99ll drop our local changes, so=
 the question then is why do we have forks?=C2=A0 Note that vendoring can a=
pply patches when it updates, so if there=E2=80=99s a simple but not-upstre=
amable change we can carry the patch in-tree.<br>
<br>
Ross<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#19419): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/19419" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/19419</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/118597577/556=
952" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/mt=
/118597577/556952</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:rob.woolleywr@gmail.com" target=3D=
"_blank">rob.woolleywr@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div>

--0000000000006f09f7065477de32--

