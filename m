Return-Path: <kergoth@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D642C00140
	for <webhook@archiver.kernel.org>; Wed, 10 Aug 2022 16:27:55 +0000 (UTC)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com
 [209.85.208.44])
 by mx.groups.io with SMTP id smtpd.web08.443.1660148868334609073
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 Aug 2022 09:27:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=PWGvJ6Rh;
 spf=pass (domain: gmail.com, ip: 209.85.208.44, mailfrom: kergoth@gmail.com)
Received: by mail-ed1-f44.google.com with SMTP id r4so19747322edi.8
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 Aug 2022 09:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=5QwGeRCuP00uq1RPTemsE3dDzKL7sRMBkZ3coNbu+84=;
        b=PWGvJ6RhNEWNaN8CvsbjUa5m4tIvTpIHRtCCnip+1zgK7/YL+5tjX5Q+2RHtn8Pnjr
         EXQHJ9ypcUZQaFqx4S2TGeG9TrpQ9uXvMaE6pTNTzfwouQmlH1WKsx9qtsL4cM62jARf
         k1RsKm47Nn4h5gNtBrh5yYlO42daQw04l4Ld56KaGfGhYrxDRtuWLac32SYTrLXnuLJY
         L34PhQVlJL44x0MVizvzJAKhhup/SleqoS3z+ffBUrTWxsTG08b8hQsmgM9znbvgsW3J
         +Eu7FRoiPE6NsASblrqBvDH6fANu01CNDdqnE/hVzh7JRCv3UCFNT0/PZNUNT+HIEYsT
         0rTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=5QwGeRCuP00uq1RPTemsE3dDzKL7sRMBkZ3coNbu+84=;
        b=DJNPYXGe2A4SeWjSd5HVWa39SWcSJTFJQw2SUqliZy9BTdbrwkWMzdd+3dE21bJTM7
         ELsCE2tAjcAnjq5JDMlKaybXgLbAiOknyiT1e9QD4ffrSW+wKsTpfrHf2z3id/mrZ61N
         pc7uKSINuSyFlFODo/ixJmU/hLrgf8xQetGYYoPVr7a21c8mF+4MKTiL4SYn02mon5dL
         4478BdLD7qxxIB5ISL5aXvw9l/YkQ7cAvYli2zuSQ7UGg7/EqpCXcOJAIUj+eFvldpAg
         RDdIRZKkvtQiocbW/sYTOwzZV0m1OdRvj9q4T2jPyQNxjSyEMUUeLpZOPqk26wUPGVAE
         fMug==
X-Gm-Message-State: ACgBeo0F1LqYcIzKqWq+BypeY7chvpd9IWAGWh6yvyOy3rs8ruOnZaOD
	tNPDXqo5YutwUe6PaGNpc+51w2j86QKz2xDAlDQ=
X-Google-Smtp-Source: 
 AA6agR6Ezqly1zo4e0K+Q1wvOCVdXIoikwd1w32ZIHL2Q2SZI2V+zOC3iLGKfzpfNiu2SNkoWdOVibmM9weCGla0zag=
X-Received: by 2002:a05:6402:f02:b0:440:3693:e68d with SMTP id
 i2-20020a0564020f0200b004403693e68dmr22564715eda.29.1660148866611; Wed, 10
 Aug 2022 09:27:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220810134337.420149-1-richard.purdie@linuxfoundation.org>
 <CAMKF1sq8xAqD-yzEkV67yDPs3yoeQ86ygHKXoLHbp0Go2n=kWQ@mail.gmail.com>
 <e37b5612a36eaebe3ac3aa93f36ebe9bcda3861d.camel@linuxfoundation.org>
In-Reply-To: 
 <e37b5612a36eaebe3ac3aa93f36ebe9bcda3861d.camel@linuxfoundation.org>
From: Christopher Larson <kergoth@gmail.com>
Date: Wed, 10 Aug 2022 09:27:35 -0700
Message-ID: 
 <CABcZANkj2Bq+cnCNmD4sTadK9QXV88u0YeqOriNQTePzSd_UFw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 1/3] BBHandler: Allow earlier exit for
 classes not found
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: Khem Raj <raj.khem@gmail.com>, bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="00000000000077fe7005e5e587eb"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 10 Aug 2022 16:27:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13889

--00000000000077fe7005e5e587eb
Content-Type: text/plain; charset="UTF-8"

Can we not make the inherit command adapt to current inherit context,
global or recipe?

On Wed, Aug 10, 2022 at 9:19 AM Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> On Wed, 2022-08-10 at 08:55 -0700, Khem Raj wrote:
> > I seeing
> >
> > % bitbake binutils
> > WARNING: ['base', 'sanity-meta-odroid-extras', 'clang',
> > 'report-error', 'image-buildinfo', 'package_ipk', 'buildhistory',
> > 'buildstats', 'buildstats-summary', 'debian', 'devshell', 'sstate',
> > 'license', 'remove-libtool', 'sanity']
> > ERROR: ParseError at
> >
> /mnt/b/yoe/master/sources/openembedded-core/meta/classes/buildhistory.bbclass:10:
> > Could not inherit file classes/image-artifact-names.bbclass
>
> I think we need something like:
>
> diff --git a/meta/classes/buildhistory.bbclass
> b/meta/classes/buildhistory.bbclass
> index 4345ffc6939..203310ba975 100644
> --- a/meta/classes/buildhistory.bbclass
> +++ b/meta/classes/buildhistory.bbclass
> @@ -7,7 +7,7 @@
>  # Copyright (C) 2007-2011 Koen Kooi <koen@openembedded.org>
>  #
>
> -inherit image-artifact-names
> +IMAGE_CLASSES += "image-artifact-names"
>
>  BUILDHISTORY_FEATURES ?= "image package sdk"
>  BUILDHISTORY_DIR ?= "${TOPDIR}/buildhistory"
>
> Does that help?
>
> I need to remove that warning too! Although it does help debugging right
> now.
>
> Cheers,
>
> Richard
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#13888):
> https://lists.openembedded.org/g/bitbake-devel/message/13888
> Mute This Topic: https://lists.openembedded.org/mt/92936457/3617123
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> kergoth@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>
>

-- 
Christopher Larson
chris_larson@mentor.com, chris.larson@siemens.com, kergoth@gmail.com
Principal Software Engineer, Embedded Linux Solutions, Siemens Digital
Industries Software

--00000000000077fe7005e5e587eb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Can we not make the inherit command adapt to current inher=
it context, global or recipe?</div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Wed, Aug 10, 2022 at 9:19 AM Richard Purdi=
e &lt;<a href=3D"mailto:richard.purdie@linuxfoundation.org">richard.purdie@=
linuxfoundation.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">On Wed, 2022-08-10 at 08:55 -0700, Khem Raj wrote:<br>
&gt; I seeing<br>
&gt; <br>
&gt; % bitbake binutils<br>
&gt; WARNING: [&#39;base&#39;, &#39;sanity-meta-odroid-extras&#39;, &#39;cl=
ang&#39;,<br>
&gt; &#39;report-error&#39;, &#39;image-buildinfo&#39;, &#39;package_ipk&#3=
9;, &#39;buildhistory&#39;,<br>
&gt; &#39;buildstats&#39;, &#39;buildstats-summary&#39;, &#39;debian&#39;, =
&#39;devshell&#39;, &#39;sstate&#39;,<br>
&gt; &#39;license&#39;, &#39;remove-libtool&#39;, &#39;sanity&#39;]<br>
&gt; ERROR: ParseError at<br>
&gt; /mnt/b/yoe/master/sources/openembedded-core/meta/classes/buildhistory.=
bbclass:10:<br>
&gt; Could not inherit file classes/image-artifact-names.bbclass<br>
<br>
I think we need something like:<br>
<br>
diff --git a/meta/classes/buildhistory.bbclass b/meta/classes/buildhistory.=
bbclass<br>
index 4345ffc6939..203310ba975 100644<br>
--- a/meta/classes/buildhistory.bbclass<br>
+++ b/meta/classes/buildhistory.bbclass<br>
@@ -7,7 +7,7 @@<br>
=C2=A0# Copyright (C) 2007-2011 Koen Kooi &lt;<a href=3D"mailto:koen@openem=
bedded.org" target=3D"_blank">koen@openembedded.org</a>&gt;<br>
=C2=A0#<br>
<br>
-inherit image-artifact-names<br>
+IMAGE_CLASSES +=3D &quot;image-artifact-names&quot;<br>
<br>
=C2=A0BUILDHISTORY_FEATURES ?=3D &quot;image package sdk&quot;<br>
=C2=A0BUILDHISTORY_DIR ?=3D &quot;${TOPDIR}/buildhistory&quot;<br>
<br>
Does that help?<br>
<br>
I need to remove that warning too! Although it does help debugging right no=
w.<br>
<br>
Cheers,<br>
<br>
Richard<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#13888): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/13888" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/13888</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/92936457/3617=
123" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/mt=
/92936457/3617123</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:kergoth@gmail.com" target=3D"_blan=
k">kergoth@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr"><div dir=3D"ltr"><font color=3D=
"#333333">Christopher Larson<br><a>chris_larson@mentor.com</a>,=C2=A0<a>chr=
is.larson@siemens.com</a>,=C2=A0<a>kergoth@gmail.com</a><br>Principal Softw=
are Engineer,=C2=A0Embedded Linux Solutions,=C2=A0Siemens Digital Industrie=
s Software</font><br></div></div></div>

--00000000000077fe7005e5e587eb--

