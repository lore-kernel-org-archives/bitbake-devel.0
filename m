Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C53CCF9E3
	for <webhook@archiver.kernel.org>; Tue,  4 Nov 2025 13:29:23 +0000 (UTC)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17530.1762262955354914304
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 04 Nov 2025 05:29:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=AP32pH68;
 spf=pass (domain: smile.fr, ip: 209.85.208.49, mailfrom: yoann.congal@smile.fr)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-640c48b3b90so2992323a12.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 04 Nov 2025 05:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1762262954; x=1762867754; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/cQm7xFQjSC4BpEhHPgw8rUssM2EjmhrGyDVzMg+S14=;
        b=AP32pH68ySIAd8ZqjPpUgT/IKNTKbvm71usL9M4CL377kXqd/QXsiHfiXCHgi6XTVu
         n6LPHAhrxTZiC8jkK7Yp6P5nZ3tZwMd/cN8o+kC7X1V5N156DUv5c/I5FkndqqRPDCgo
         4fsIlD4XdPCcUB8fmBwHM8CDvad7ZjW8YfLLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762262954; x=1762867754;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/cQm7xFQjSC4BpEhHPgw8rUssM2EjmhrGyDVzMg+S14=;
        b=ZRROn51f+V1TwyBMaYZGD3D5Hr7IEIEIucJymuP1QeTPGod+E25MA7qytpSaGCIRHH
         eV86lrFjGisAZGaz0WkFooGemTSxinYcTSNZ+J/EZIZT9LNIep0+JE/XS1B/TDvUem3H
         m2alZRAvTM5wqVOCNSFfBd51YWT8CrWJu7QO7Tv9zryah1+5taAzUACTVNVfBGDTdSnd
         ues7NETQF3bJlrlWG5FNtkW5O53lopn+mvVUwqu6M6CdZgTODv66bMWo/G0q0dczcM1q
         UTsuVbqSBsqn86D2pbXuIpMQ/rjM6q5usx9cowhunUV5DsucohgyxxqNvBvRoAOrDeh0
         wLBg==
X-Gm-Message-State: AOJu0YyCsPAOagYJ9Kmq9IHIhrJM48dZBMMRNlXKU8lHtpAMLwCF60/W
	nchQmFmgU78hL3Tj3bMxbE16pdcLUNfL2ApomohpoCrfdHaE6ZHHgOmo31j0o3Ht27BvAV7DcEB
	26gQwK+IjZu9y7+93OUZMpzA1AKX44ZBbKA8YnJVCxw==
X-Gm-Gg: ASbGncvrWz03KHihYe8381O8kaDFbCVqcOP2edQ8akWOvJHY1Dxqu3ghce6nK6M75y9
	tb6Qb+yWSGbrVr83kPdILQ0GIlS6mdJ7PFIdCDFbY7AcPIrY6je0Q4cJuaz/jFb6KZHngFUg34r
	cvm0kmOHmJNXxNkwOp8ZN9Rqxiz+SFtFtzd4bluDCBM3tcIO6jYvnN0dKenv1pkJqhBy/5DKa5u
	pCrNWWAhCG7YZSh5S6bPgccyYZqGb9Zpvp2ek21X2AwodSyJkDqduY0HoSRUgQ=
X-Google-Smtp-Source: AGHT+IGY0lV8/6UMDW6IgiFkvc6CmNl64V5iglvtzvONRSRfoy98aSdqWhuZRYkgPTMzgKt3emxeetWQj+zHNzkU1ow=
X-Received: by 2002:a05:6402:84e:b0:640:bb28:9a28 with SMTP id
 4fb4d7f45d1cf-640bb289a69mr6725723a12.15.1762262953595; Tue, 04 Nov 2025
 05:29:13 -0800 (PST)
MIME-Version: 1.0
References: <20251103214804.2004903-1-yoann.congal@smile.fr> <DDZVEE4GD73D.1NPPO1ZUVS0CC@bootlin.com>
In-Reply-To: <DDZVEE4GD73D.1NPPO1ZUVS0CC@bootlin.com>
From: Yoann Congal <yoann.congal@smile.fr>
Date: Tue, 4 Nov 2025 14:28:46 +0100
X-Gm-Features: AWmQ_bk-Hxn1tSwVTvPpFRBQ0Yv9r9AJXxT_sDMPBzk5yjfztK9kzj2AaLTqp8c
Message-ID: <CAMSfU+6e=+a5irU6De=2L0++9=-eFqNPEa9B4R0RJWhGhuo=jQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] bitbake-setup: make "path" optional
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="00000000000059a3e80642c4d156"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 04 Nov 2025 13:29:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18252

--00000000000059a3e80642c4d156
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mar. 4 nov. 2025 =C3=A0 12:23, Mathieu Dubois-Briand <
mathieu.dubois-briand@bootlin.com> a =C3=A9crit :

> On Mon Nov 3, 2025 at 10:48 PM CET, Yoann Congal via
> lists.openembedded.org wrote:
> > From: Yoann Congal <yoann.congal@smile.fr>
> >
> > Layer names and path are often redundant. Allow users to omit the path
> > key when it is equal to the layer name by using the layer name as a
> > default value for its path.
> >
> > For example, from poky-master.conf.json:
> >   "bitbake": {
> >     ...
> >     "path": "bitbake"
> >   },
> >   "openembedded-core": {
> >     ...
> >     "path": "openembedded-core"
> >   },
> >   "meta-yocto": {
> >     ...
> >     "path": "meta-yocto"
> >   },
> >   "yocto-docs": {
> >     ...
> >     "path": "yocto-docs"
> >   }
> >
> > Remove redundant "path" keys from default-registry and tests.
> >
> > Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
> > ---
> > Note: Now that all "path" keys are removed (because they were all
> redundant),
> > we need to ensure the "path" code path is tested by adding a test for
> > it.
> > ---
>
> Hi Yoann,
>
> Thanks for your patch.
>
> It looks like this is breaking a selftest:
>
> ERROR: test_setup (bb.tests.setup.BitbakeSetupTest.test_setup)
> ...
> bb.process.ExecutionError: Execution of
> '/srv/pokybuild/yocto-worker/oe-selftest-armhost/build/layers/bitbake/bin=
/bitbake-setup
> --global-settings /tmp/bitbake-fetch-l9mrbqbo/global-config status' faile=
d
> with exit code 1:
> Traceback (most recent call last):
>   File
> "/srv/pokybuild/yocto-worker/oe-selftest-armhost/build/layers/bitbake/bin=
/bitbake-setup",
> line 860, in <module>
>     main()
>   File
> "/srv/pokybuild/yocto-worker/oe-selftest-armhost/build/layers/bitbake/bin=
/bitbake-setup",
> line 854, in main
>     args.func(top_dir, all_settings, args, d)
>   File
> "/srv/pokybuild/yocto-worker/oe-selftest-armhost/build/layers/bitbake/bin=
/bitbake-setup",
> line 541, in build_status
>     if are_layers_changed(current_upstream_config["data"]["sources"],
> layerdir, d):
>
>  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^
>   File
> "/srv/pokybuild/yocto-worker/oe-selftest-armhost/build/layers/bitbake/bin=
/bitbake-setup",
> line 492, in are_layers_changed
>     repodir =3D r_data["path"]
>               ~~~~~~^^^^^^^^
> KeyError: 'path'
>
> https://autobuilder.yoctoproject.org/valkyrie/#/builders/23/builds/2787
> https://autobuilder.yoctoproject.org/valkyrie/#/builders/35/builds/2652
> https://autobuilder.yoctoproject.org/valkyrie/#/builders/23/builds/2787
>
> Can you have a look?
>

Yup, definitely a bug I missed. Will send a v2 with a fix.


>
> Thanks,
> Mathieu
>
> --
> Mathieu Dubois-Briand, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
>
>

--=20
Yoann Congal
Smile ECS

--00000000000059a3e80642c4d156
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Le=C2=A0mar. 4 nov. =
2025 =C3=A0=C2=A012:23, Mathieu Dubois-Briand &lt;<a href=3D"mailto:mathieu=
.dubois-briand@bootlin.com" target=3D"_blank">mathieu.dubois-briand@bootlin=
.com</a>&gt; a =C3=A9crit=C2=A0:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">On Mon Nov 3, 2025 at 10:48 PM CET, Yoann Congal via <a hr=
ef=3D"http://lists.openembedded.org" rel=3D"noreferrer" target=3D"_blank">l=
ists.openembedded.org</a> wrote:<br>
&gt; From: Yoann Congal &lt;<a href=3D"mailto:yoann.congal@smile.fr" target=
=3D"_blank">yoann.congal@smile.fr</a>&gt;<br>
&gt;<br>
&gt; Layer names and path are often redundant. Allow users to omit the path=
<br>
&gt; key when it is equal to the layer name by using the layer name as a<br=
>
&gt; default value for its path.<br>
&gt;<br>
&gt; For example, from poky-master.conf.json:<br>
&gt;=C2=A0 =C2=A0&quot;bitbake&quot;: {<br>
&gt;=C2=A0 =C2=A0 =C2=A0...<br>
&gt;=C2=A0 =C2=A0 =C2=A0&quot;path&quot;: &quot;bitbake&quot;<br>
&gt;=C2=A0 =C2=A0},<br>
&gt;=C2=A0 =C2=A0&quot;openembedded-core&quot;: {<br>
&gt;=C2=A0 =C2=A0 =C2=A0...<br>
&gt;=C2=A0 =C2=A0 =C2=A0&quot;path&quot;: &quot;openembedded-core&quot;<br>
&gt;=C2=A0 =C2=A0},<br>
&gt;=C2=A0 =C2=A0&quot;meta-yocto&quot;: {<br>
&gt;=C2=A0 =C2=A0 =C2=A0...<br>
&gt;=C2=A0 =C2=A0 =C2=A0&quot;path&quot;: &quot;meta-yocto&quot;<br>
&gt;=C2=A0 =C2=A0},<br>
&gt;=C2=A0 =C2=A0&quot;yocto-docs&quot;: {<br>
&gt;=C2=A0 =C2=A0 =C2=A0...<br>
&gt;=C2=A0 =C2=A0 =C2=A0&quot;path&quot;: &quot;yocto-docs&quot;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;<br>
&gt; Remove redundant &quot;path&quot; keys from default-registry and tests=
.<br>
&gt;<br>
&gt; Signed-off-by: Yoann Congal &lt;<a href=3D"mailto:yoann.congal@smile.f=
r" target=3D"_blank">yoann.congal@smile.fr</a>&gt;<br>
&gt; ---<br>
&gt; Note: Now that all &quot;path&quot; keys are removed (because they wer=
e all redundant),<br>
&gt; we need to ensure the &quot;path&quot; code path is tested by adding a=
 test for<br>
&gt; it.<br>
&gt; ---<br>
<br>
Hi Yoann,<br>
<br>
Thanks for your patch.<br>
<br>
It looks like this is breaking a selftest:<br>
<br>
ERROR: test_setup (bb.tests.setup.BitbakeSetupTest.test_setup)<br>
...<br>
bb.process.ExecutionError: Execution of &#39;/srv/pokybuild/yocto-worker/oe=
-selftest-armhost/build/layers/bitbake/bin/bitbake-setup --global-settings =
/tmp/bitbake-fetch-l9mrbqbo/global-config status&#39; failed with exit code=
 1:<br>
Traceback (most recent call last):<br>
=C2=A0 File &quot;/srv/pokybuild/yocto-worker/oe-selftest-armhost/build/lay=
ers/bitbake/bin/bitbake-setup&quot;, line 860, in &lt;module&gt;<br>
=C2=A0 =C2=A0 main()<br>
=C2=A0 File &quot;/srv/pokybuild/yocto-worker/oe-selftest-armhost/build/lay=
ers/bitbake/bin/bitbake-setup&quot;, line 854, in main<br>
=C2=A0 =C2=A0 args.func(top_dir, all_settings, args, d)<br>
=C2=A0 File &quot;/srv/pokybuild/yocto-worker/oe-selftest-armhost/build/lay=
ers/bitbake/bin/bitbake-setup&quot;, line 541, in build_status<br>
=C2=A0 =C2=A0 if are_layers_changed(current_upstream_config[&quot;data&quot=
;][&quot;sources&quot;], layerdir, d):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^^^^^^^^^^^^^^^^^^^^^^<br>
=C2=A0 File &quot;/srv/pokybuild/yocto-worker/oe-selftest-armhost/build/lay=
ers/bitbake/bin/bitbake-setup&quot;, line 492, in are_layers_changed<br>
=C2=A0 =C2=A0 repodir =3D r_data[&quot;path&quot;]<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ~~~~~~^^^^^^^^<br>
KeyError: &#39;path&#39;<br>
<br>
<a href=3D"https://autobuilder.yoctoproject.org/valkyrie/#/builders/23/buil=
ds/2787" rel=3D"noreferrer" target=3D"_blank">https://autobuilder.yoctoproj=
ect.org/valkyrie/#/builders/23/builds/2787</a><br>
<a href=3D"https://autobuilder.yoctoproject.org/valkyrie/#/builders/35/buil=
ds/2652" rel=3D"noreferrer" target=3D"_blank">https://autobuilder.yoctoproj=
ect.org/valkyrie/#/builders/35/builds/2652</a><br>
<a href=3D"https://autobuilder.yoctoproject.org/valkyrie/#/builders/23/buil=
ds/2787" rel=3D"noreferrer" target=3D"_blank">https://autobuilder.yoctoproj=
ect.org/valkyrie/#/builders/23/builds/2787</a><br>
<br>
Can you have a look?<br></blockquote><div><br></div><div>Yup, definitely a =
bug I missed. Will send a v2 with a fix.</div><div>=C2=A0</div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">
<br>
Thanks,<br>
Mathieu<br>
<br>
-- <br>
Mathieu Dubois-Briand, Bootlin<br>
Embedded Linux and Kernel engineering<br>
<a href=3D"https://bootlin.com" rel=3D"noreferrer" target=3D"_blank">https:=
//bootlin.com</a><br>
<br>
</blockquote></div><div><br clear=3D"all"></div><br><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><font face=3D"Raleway, regular">Yoann Congal</font><div><fon=
t face=3D"Raleway, regular">Smile ECS</font></div></div></div></div>
</div>

--00000000000059a3e80642c4d156--

