Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F4DECCA476
	for <webhook@archiver.kernel.org>; Fri, 10 Oct 2025 08:31:25 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web11.4406.1760085083125764607
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 10 Oct 2025 01:31:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=dB4i6loj;
 spf=pass (domain: smile.fr, ip: 209.85.128.45, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-46e29d65728so10575275e9.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 10 Oct 2025 01:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1760085081; x=1760689881; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7iOkDTVfSsCfgTlqeDzh1NE9YTKy+TQlr4ptN/09JeU=;
        b=dB4i6loj5X6+mMQPoxwGLQ+NqV3QrghhdkYvG6l3t7LkDZYe7axCArgygIz0EOxJK0
         phu5/lo7w6qhdQ393vSJaj6TDWMWlZj/GDb9nGxppfrW7KANgWjjTBX30MQ2N9vzzdOP
         km+T8bq+TULC5XCcwx9cOzd940EPDIJm42c1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760085081; x=1760689881;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7iOkDTVfSsCfgTlqeDzh1NE9YTKy+TQlr4ptN/09JeU=;
        b=lJyOoP/q4TDbj6GSxU/ugVpSBilJxcSM83ibNsjTBoUavyshz+xrKefAcliALKZSdL
         IsHAsy2M5pfFxAqTEckE6Ui5B5ZN76zqw2/zTvXW+cb89J4XDa6QlRMQ6J7l+rGkWneg
         ijGCT1yHLLPuOwn2Jzfe+1nsr7PzrmNRlXt/ot1Ddld03PMWsVM23gcWwqkWDg1GVRiN
         rvPASoUDbiWdiJoqOI7ldvOaENERlC4L3ba6/IZ9dUm+zSYWdCpGJSUYiCIycwycDHhz
         uP0ar1yVSZiIuxp+UBn4DS8rdxdb7J4vDXx24nAuiM60HqLl02YXwfU/n1Mpm6BoJ06z
         8gBA==
X-Gm-Message-State: AOJu0YxX8pXgDuv9yg1WkqOvfYw7zB3DJqXAFU5groYSggnFE+tY/avP
	xPnaIeQYzvRsgxYWwxZDNSBQp3CsY/lVa+Gsg9b++6UjjwxKXjh5LGXLgjwiOOJgsrdmIXh3/W2
	Kycow2reay5LmJStOelTKqYfGsNEq/6D43M7HB6fnsA==
X-Gm-Gg: ASbGncvHwFdAw9+1jWvC0gSQv6aZW7qYq5E0h5LCSNhdFt21zg/6gnR115i5sJUauNY
	VMjNrFztTjieqWi4r3TVVsr1+HcFiDlw/Nal+QoJ9jk5m1judLcf9YbrrXl04wcjnKP95Tmi3Vj
	mbR+enqP85u4wIyZ8f3K+T6NBAacHCMxIqRCp915ePbeyqNGAUiAce+lWtlgssEzcJWmzSkvT59
	FLo6tNfdMbMfeD3HVibAfMl1KniSCTKyb5/vRabZaxf4DeJ8qxPD7PFJYQkjAPjn4FPbxE=
X-Google-Smtp-Source: AGHT+IEXAQ5aH6FkAy/TmnTzNs1H27uHR7T53374i+iY6aDAMbvAM7blyV3jOUeVjL8wMGssKcGOnl9V5+W04dkPA4Q=
X-Received: by 2002:a05:600c:8b42:b0:45d:f81d:eae7 with SMTP id
 5b1f17b1804b1-46fa9afbd71mr66647165e9.28.1760085081390; Fri, 10 Oct 2025
 01:31:21 -0700 (PDT)
MIME-Version: 1.0
References: <20251010080619.2688482-1-yoann.congal@smile.fr> <CANNYZj8CNarGn6vv6CyVepDnYwPmyL4HM2nb30WNug+TDj+D7A@mail.gmail.com>
In-Reply-To: <CANNYZj8CNarGn6vv6CyVepDnYwPmyL4HM2nb30WNug+TDj+D7A@mail.gmail.com>
From: Yoann Congal <yoann.congal@smile.fr>
Date: Fri, 10 Oct 2025 10:30:54 +0200
X-Gm-Features: AS18NWDyeyOTGMz2e6bSXe-e0-614Xne2PwQ7lRHScfw2AiZoNGTMVd8oPtiVWg
Message-ID: <CAMSfU+4CBvPNyRA9dz+E3myXQR7z26Pg0nmRb4Tnbd4-F5zJxw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH v2] ast: Warn on multiple builtin config
 fragments for the same variable
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="0000000000000d138e0640c9bef0"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 10 Oct 2025 08:31:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18167

--0000000000000d138e0640c9bef0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le ven. 10 oct. 2025 =C3=A0 10:13, Alexander Kanavin <alex.kanavin@gmail.co=
m> a
=C3=A9crit :

> > Added warning looks like:
> > WARNING: Multiple builtin fragments are enabled for OE_FRAGMENTS via
> variable machine: machine/qemux86-64 machine/test machine/qemux86-64. Thi=
s
> likely points to a mis-configuration in the metadata, as only one of them
> should be set. The build will use the last value.
>
> ...
>
> > +                    % (
> > +                        self.fragments_variable,
> > +                        builtin_fragment_key,
> > +                        " ".join(builtin_fragments_list),
>
> You need to put these into correct order.
>

d'oh! V3 sent :
https://lists.openembedded.org/g/bitbake-devel/topic/patch_v3_ast_warn_on/1=
15686012


>
> Alex
>


--=20
Yoann Congal
Smile ECS

--0000000000000d138e0640c9bef0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">Le=C2=A0ven. 10=
 oct. 2025 =C3=A0=C2=A010:13, Alexander Kanavin &lt;<a href=3D"mailto:alex.=
kanavin@gmail.com">alex.kanavin@gmail.com</a>&gt; a =C3=A9crit=C2=A0:<br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">&gt; Added warning lo=
oks like:<br>
&gt; WARNING: Multiple builtin fragments are enabled for OE_FRAGMENTS via v=
ariable machine: machine/qemux86-64 machine/test machine/qemux86-64. This l=
ikely points to a mis-configuration in the metadata, as only one of them sh=
ould be set. The build will use the last value.<br>
<br>
...<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 % (<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 self.fragments_variable,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 builtin_fragment_key,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 &quot; &quot;.join(builtin_fragments_list),<br>
<br>
You need to put these into correct order.<br></blockquote><div><br></div><d=
iv>d&#39;oh! V3 sent :=C2=A0<a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/topic/patch_v3_ast_warn_on/115686012">https://lists.openembedded=
.org/g/bitbake-devel/topic/patch_v3_ast_warn_on/115686012</a></div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Alex<br>
</blockquote></div><div><br clear=3D"all"></div><br><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><font face=3D"Raleway, regular">Yoann Congal</font><div><fon=
t face=3D"Raleway, regular">Smile ECS</font></div></div></div></div>

--0000000000000d138e0640c9bef0--

