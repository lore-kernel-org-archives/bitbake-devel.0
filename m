Return-Path: <chuckwolber@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A143C02182
	for <webhook@archiver.kernel.org>; Thu, 23 Jan 2025 05:12:48 +0000 (UTC)
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
 by mx.groups.io with SMTP id smtpd.web10.4758.1737609160488189087
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 22 Jan 2025 21:12:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=N24mLT1g;
 spf=pass (domain: gmail.com, ip: 209.85.166.180, mailfrom: chuckwolber@gmail.com)
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3ce76b8d5bcso4603315ab.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 22 Jan 2025 21:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737609160; x=1738213960; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9LEoAJa1z1mLZD3Ga/bzZzVrkKvAolA2GK3SA5V/y/w=;
        b=N24mLT1gsO6dwkAx9rwDFEtMkrAQOMFVJyAjUsHWra4DY0Y7nYc+iHVlgui6/1/rYw
         B/mpIepGxJ8E5tECPspXoeUeUWU7oxMI0BGoN3jPV0MxIdl6TLmLM0Ymrz/WQX4DQduk
         CKbDr0+bEUmFliLPN4sPkJz9IPfAGO1DLNLu2ZZDXMrQKmsPPf47CVuZjSuLHQbtrJsO
         3/LrpaJQMz67JuFhO/S1btTP2PzlQbOv7ht176pcAVwhTSKWkZeaQ+ks+UmowlES1qk2
         2HeHk/3eZDxXzc5HcvmHq7gaX/wdIcMw2fqWs4OdEEPBiCZ4kB/WzWxw+kLPdJVqke3K
         2Nhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737609160; x=1738213960;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9LEoAJa1z1mLZD3Ga/bzZzVrkKvAolA2GK3SA5V/y/w=;
        b=b4PA0CWnPXFVc7PEHSxcbUt3J8o9KEo2QJzbzgdCj+j3O0M74o6IH/tYAFzwMHRjZ7
         UPJW9Juhy9S5jSeB9ensXKkFUqlE815T1INMpGeUO0HuE9aDGzdwGS99mUudALvyiori
         loauQPKOKOCS3QkNkw0rYLK5aGSSJu3zaNL2H+q568eSzEJnBh+m+rlDmub4+ulkvVtB
         EeZU1ju77YzTNwaVwjxd2F8L+Cc/Q6okoGTKBTc16Xt1jBrpI2U0kyouzUlu9s8w6fE1
         14WWpUMg6MjE8joTYRbj0U9vOC4US+XSa6XdyRjp2q1GEAZRaAHCQlD/bNURQFIOKLOq
         DfEA==
X-Gm-Message-State: AOJu0Yw3/nmiFEv6sf0dM9/JO5mnRdNEpIKgYF+nNmBB35bwfoVHfkeN
	jWgCtO0J1H5jvN5siXyGmSVEh5EikHr+ylbKKzG8Qtlt7/wjML1EZgFyhZnFgIfV/5jQcsLiqC7
	1v6x/VojQTPQVkxPYtIcNl7qRxMA=
X-Gm-Gg: ASbGncuK/wTbOwXxBKdEVAKQVKCA0HYEemSN6JKuUHn6eZTyT5E7NHs9ulzdIOCV7Ug
	S0PRB3x75kQW6Vq38p4EHAc9GRF5soD9VUUcMsgP4ax5uLb7pWgsD0hu5wQPTQR6n8KYMDe5dvd
	KsqFQyktdqx5pY4uZkTw8=
X-Google-Smtp-Source: AGHT+IEce9SQlDohPHQ0om7jGTPE3VXDjqxfOvrl+6RvbgcqCc3Yv45HYQRHH8LW+gV5W4APGrcbQpuTkQP5HmfCRFE=
X-Received: by 2002:a05:6e02:4604:b0:3cf:af3b:b4b2 with SMTP id
 e9e14a558f8ab-3cfaf3bb7afmr69294725ab.3.1737609159658; Wed, 22 Jan 2025
 21:12:39 -0800 (PST)
MIME-Version: 1.0
References: <181B8041053EB73B.1562@lists.openembedded.org> <CANNYZj_7L03Tp9c=Ps1KAmvWW4=5_9LEVOCyh88FfUbs8GxfKA@mail.gmail.com>
In-Reply-To: <CANNYZj_7L03Tp9c=Ps1KAmvWW4=5_9LEVOCyh88FfUbs8GxfKA@mail.gmail.com>
From: Chuck Wolber <chuckwolber@gmail.com>
Date: Wed, 22 Jan 2025 21:12:22 -0800
X-Gm-Features: AWEUYZnwhBqh4UQAZ6F7pVR88n4JXdfbsOiPTIylsTmpDT6kK4andnC41BBfEXU
Message-ID: <CAB=6tBQvfC-+fZGPeqO7tDsNQj88OFgOrXe5YXC=EWqs+x0jEg@mail.gmail.com>
Subject: Re: [bitbake-devel] [RFC PATCH 1/2] bitbake-setup: add the proof of
 concept implementation
To: alex.kanavin@gmail.com
Cc: bitbake-devel@lists.openembedded.org, 
	Richard Purdie <richard.purdie@linuxfoundation.org>
Content-Type: multipart/alternative; boundary="000000000000b85785062c58a863"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 23 Jan 2025 05:12:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17065

--000000000000b85785062c58a863
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 22, 2025 at 1:43=E2=80=AFAM Alexander Kanavin via lists.openemb=
edded.org
<alex.kanavin=3Dgmail.com@lists.openembedded.org> wrote:

> On Fri, 17 Jan 2025 at 15:11, Alexander Kanavin via
> lists.openembedded.org <alex.kanavin=3Dgmail.com@lists.openembedded.org>
> wrote:
> > Default parameter values are in /home/alex/.bitbake-setup/config -
> adjust as needed.
> >
> > Fetching configuration repository git://
> github.com/kanavin/bitbake-setup-configurations.git;protocol=3Dhttps;bran=
ch=3Dmain;rev=3Dmain
> into /home/alex/.bitbake-setup/configurations
>
> After some consideration I've concluded that placing the bitbake-setup
> tool configuration and caches into hardcoded ~/.bitbake-setup/ is not
> the best idea. Rather, the tool should write and read everything using
> a 'top level' directory, which can be set via command line switch,
> environment variable, or a default of ~/bitbake-builds/, in that
> priority order.
>

Agreed on the command line switch. But what about making ~/.config/bitbake
the default
and falling back to $XDG_CONFIG_HOME/bitbake as a secondary default? That
would be
closer to what is considered "standard" behavior and probably make it
easier to manage in
the long run.

..Ch:W..

--=20
*"Perfection must be reached by degrees; she requires the slow hand of
time." - Voltaire*

--000000000000b85785062c58a863
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Wed, Jan 22, 2025 at 1:43=E2=80=AFAM A=
lexander Kanavin via <a href=3D"http://lists.openembedded.org">lists.openem=
bedded.org</a> &lt;alex.kanavin=3D<a href=3D"mailto:gmail.com@lists.openemb=
edded.org">gmail.com@lists.openembedded.org</a>&gt; wrote:</div><div class=
=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">On Fri, 17 Jan 2025 at 15:11, Alexander Kanavin via<br>
<a href=3D"http://lists.openembedded.org" rel=3D"noreferrer" target=3D"_bla=
nk">lists.openembedded.org</a> &lt;alex.kanavin=3D<a href=3D"mailto:gmail.c=
om@lists.openembedded.org" target=3D"_blank">gmail.com@lists.openembedded.o=
rg</a>&gt;<br>
wrote:<br>
&gt; Default parameter values are in /home/alex/.bitbake-setup/config - adj=
ust as needed.<br>
&gt;<br>
&gt; Fetching configuration repository git://<a href=3D"http://github.com/k=
anavin/bitbake-setup-configurations.git;protocol=3Dhttps;branch=3Dmain;rev=
=3Dmain" rel=3D"noreferrer" target=3D"_blank">github.com/kanavin/bitbake-se=
tup-configurations.git;protocol=3Dhttps;branch=3Dmain;rev=3Dmain</a> into /=
home/alex/.bitbake-setup/configurations<br>
<br>
After some consideration I&#39;ve concluded that placing the bitbake-setup<=
br>
tool configuration and caches into hardcoded ~/.bitbake-setup/ is not<br>
the best idea. Rather, the tool should write and read everything using<br>
a &#39;top level&#39; directory, which can be set via command line switch,<=
br>
environment variable, or a default of ~/bitbake-builds/, in that<br>
priority order.<br></blockquote><br>Agreed on the command line switch. But =
what about making ~/.config/bitbake the default</div><div class=3D"gmail_qu=
ote gmail_quote_container">and falling back to $XDG_CONFIG_HOME/bitbake as =
a secondary default? That would be</div><div class=3D"gmail_quote gmail_quo=
te_container">closer to what is considered &quot;standard&quot; behavior an=
d probably make it easier to manage in</div><div class=3D"gmail_quote gmail=
_quote_container">the long run.<br><div>=C2=A0<br></div><div>..Ch:W..<br></=
div><div><br></div></div><span class=3D"gmail_signature_prefix">-- </span><=
br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div><b><spa=
n style=3D"font-family:monospace">&quot;Perfection must be reached by degre=
es; she requires the slow hand of time.&quot; - Voltaire</span></b></div></=
div></div></div>

--000000000000b85785062c58a863--

