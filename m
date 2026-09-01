Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C0FC624D2
	for <webhook@archiver.kernel.org>; Tue,  1 Sep 2026 12:15:43 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6634.1788264934068352500
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 01 Sep 2026 05:15:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=ZW6o16Qg;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49b9320423cso46596375e9.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 01 Sep 2026 05:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1788264932; x=1788869732; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=/A2bfBO2Tc+98Iewsb2zxc6PmljZuW0Qjub23YnTt2E=;
        b=ZW6o16Qgq+E6MCqPTH69StDS7MoWtXbI5bIhNdEjPs1uJJtkGzmUZucxApRtFTDTIM
         cXSD/r5N3vTJK4wGIB5Mto/1HHKojVLQJ90dpWM7VargFVBhcKsKYkRMDVzut++M1cSv
         vSdbLHbhi6dhsv3aXK7BgOdx+lOiWH5g4Ap1Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788264932; x=1788869732;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/A2bfBO2Tc+98Iewsb2zxc6PmljZuW0Qjub23YnTt2E=;
        b=lQUoXCF/f2iI06esvYk1lpWywChEbkoPbdv4IyJlh0FbKUzGeAGD+dmLd6ongJBlkg
         c95d5nbuKXlA+OY1zC58X391B0YEE0fmRk+EPh2FBcFmhm4mfJs2CLBF1LHOiG/P2mpU
         EGm0mDJJnlsrh1nM/5kwRctpo4ydkWPeHRRKubKSzR32iebicuz00HfIKnYeKur3XVx3
         UgcXucmd3aawdfZBsD5njS8Q6prLw0+TbFC9O196CafVsl6nTa2s7wg4/QDjIZ05HZEl
         e78RXgh+odKAY4quMwvVqUMGicM/SiPCONGeXMklFo5Xy41Ki2iz/P9pd17lmj6nwCyf
         jLSA==
X-Forwarded-Encrypted: i=1; AHgh+RqK67PRjOSFz6dhX+8Z42GUefdOS7WZrADni9wBV9gxOkUK3dMIor8TcCtllXc6TigiT0tqlpowWCmDKEDZ@lists.openembedded.org
X-Gm-Message-State: AFuF++kKnOFPD8vSrtna8N9GvIQdCxudOPUz6QN7q61SZC2XJKhHetXz
	6mtXmTgAKaBPLQssDpIQ0YaHQ6KMVagYagz3FvZ0X09QDXVHBSF8bWZUEbejyXCqnRg=
X-Gm-Gg: AR+sD10YVghU5oHwSByIKy4dPxP7vEJ0tY1mWCF5bxUXoxRR81RmhYH9giSyneEMyrG
	3QQuSIGIPJUK1lM42iO/wHd6UcK/56GU2noVw0oAnfxz2nj3grtbv5QxffDEoSd6eAE3Ot5EJ7l
	V4WHDwmcyzms4IaZSIKyJNB4YMTf38fEeBhyYLp7kSi3RAvXUQy3wDW8PXYxXMZaWssDioGuxhP
	nAM+gJ5Nf48dKYhSxJLHX2jFUJNeVtIXRklpa0Ay/ggbTudYaV3vUyFrTR89+5apzT0hwjyLson
	zx15pK84G8O6RmNWQjcZvARizjlcOM6QXdvUh4PXOLaCti9c/T1IMKUG1MXmgQ+a0gKKTf4z66W
	1myHehlf9YhvVxZxwCjD0TkMQaWBGbYReH2gsWAev6A/+UA4WgIzGAtbCMI8L0yv8T0OjWVWWG3
	+jjxZqlT/QGofV4cfNvKHHdiG1jTwb4Mc03QMdcz8RpD0+9m63SHj2fqwlBD+UtyUwUc+mH/Clu
	hbDwdiZW1Fo/Dkf6lsRTvljOYgaZjs6U3NLVdT36anp9Hr3o0lRog==
X-Received: by 2002:a05:600c:8011:b0:496:bbce:fc with SMTP id 5b1f17b1804b1-49cdc5660bamr154746575e9.12.1788264931881;
        Tue, 01 Sep 2026 05:15:31 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:9e4b:8577:fa6f:4727? ([2001:8b0:aba:5f3c:9e4b:8577:fa6f:4727])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48442d37ce3sm4564737f8f.8.2026.09.01.05.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 05:15:30 -0700 (PDT)
Message-ID: <afffba8970ad228db773766f7f6c894cbb021279.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH RFC] parse/ast: add support for additive
 built-in fragments
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: antonin.godard@bootlin.com, bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Date: Tue, 01 Sep 2026 13:15:30 +0100
In-Reply-To: <20260901-appending-fragments-v1-1-2e359cf751ce@bootlin.com>
References: <20260901-appending-fragments-v1-1-2e359cf751ce@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 01 Sep 2026 12:15:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20137

On Tue, 2026-09-01 at 09:52 +0200, Antonin Godard via lists.openembedded.or=
g wrote:
> Add support for the following syntax specified in a fragment list
> definition:
>=20
> =C2=A0 fragmentname:VARIABLE:add
>=20
> Setting this fragment appends to VARIABLE instead of setting its value.
> This does not break pre-existing fragments which still set a variable's
> value entirely.
>=20
> For example, in OE-Core consider the following definition:
>=20
> =C2=A0 OE_FRAGMENTS_BUILTIN =3D "class:INHERIT:add"
>=20
> Then one could specify the following:
>=20
> =C2=A0 OE_FRAGMENTS =3D "class/buildstats class/rm_work"
>=20
> Which would result in appending " buildstats rm_work" to the INHERIT
> variable.
>=20
> This would also allow bitbake-setup configurations to come with a list
> of pre-enabled classes, for example.
>=20
> Note: The "add" suffix was chosen in the definition to avoid confusion
> with the existing "append" usage in Bitbake.
>=20
> Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
> ---
> Note: The bitbake-config-build OE-Core utility would require adaptations
> as it currently removes any pre-existing built-in fragment with the
> same suffix. I can also send the associated OE-Core patches.
>=20
> Note 2: We could also have these fragments specified as:
>=20
> =C2=A0 OE_FRAGMENTS =3D "class/add/buildstats class/add/retain"
>=20
> To avoid confusing them with original built-in fragments. While I
> agree it disambiguates them from original built-ins, I also think from a
> user point of view, being able to set:
>=20
> =C2=A0 OE_FRAGMENTS =3D "machine/qemuarm distro/poky class/buildstats cla=
ss/retain"
>=20
> feels a bit more natural. Discussion is open :)


It is definitely an interesting one and the syntax isn't too bad.. Are
there uses beyond class inherit though?

machine/distro were added as they are clear variables in common use
which avoided tons of boilerplate in layer definitions. Do we have
similar needs here or are these inherits better captured in config
fragments?

Cheers,

Richard

