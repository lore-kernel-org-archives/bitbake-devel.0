Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5CF6CD8CA8
	for <webhook@archiver.kernel.org>; Sat, 13 Jun 2026 14:26:43 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.91952.1781360794224883971
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 13 Jun 2026 07:26:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=PU3S6QBx;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.51, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490b3637b90so14085375e9.3
        for <bitbake-devel@lists.openembedded.org>; Sat, 13 Jun 2026 07:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1781360792; x=1781965592; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ev/ASkGlB1ioRQh4T5pl2x6YWaXqH040w2Bt/UOTqOA=;
        b=PU3S6QBxfuqVtxMaS9yWpFEPt7MS9/13cCTeOpX0QV7WTBam1ORdLpsybBjjFpnCD6
         Mns7wY6Xia+IB854VgJDrcV8+JYJQWbya9nA4wCqvVLAFqfEihH6lmkVYj77rt+dZj+u
         EJecxJqBSU7q7LZn7wJmmCM8ITyn13u9m3azk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781360792; x=1781965592;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ev/ASkGlB1ioRQh4T5pl2x6YWaXqH040w2Bt/UOTqOA=;
        b=gZ/ABd33fBSiGBKf0A7qa9HqSpb+6mHUiJCYBW2nj/jydqOSeFOzh7VLDbqw6l4moi
         kXwoAm4y9MML3/D6FOAc8oPPwDOuhwVXDAEF8MJom41hMMP3pihK7ZLe1S+fIF6MwcWL
         cUwFR5XNW0H6iXQC14bM8m1XS932R8a1xF/locl9fn+ByQGz72doOmMfV8+EjCeZuQ37
         ukdzQVHb8cuHLfzh+BYG/8NSZjkgHiwjlxeClal5MzusMpixwtXGlK8s9NW65v+k1BeA
         y4URv5LQE/TvFuMxPywXJ9NCnO1BoEuTx+etxTNt6wFjzl/dI1/0IwQ7OB9971HSuWPx
         ubCA==
X-Gm-Message-State: AOJu0YwEyuvWHDxW8LwkRyup71473b1D8i73Z38tFEr+5UqulnLNPuS5
	Hyo864zIeikaZHvgwaGwM+Xo4yWuyrRmhQGgiLqn6GvhPK9TgUcI8Co5t/bTALlFT+c=
X-Gm-Gg: Acq92OHAMspsLDt7Mmm6McOBpB/WlsslVulZ2O9Aw0RLM/phn0RRQtoirOCl1/cibEr
	nFF4Q2bi9Yg1SPpchf77+yEkWLK/RFpTUUheZs4DMoZzJCxJ8xu4kaG4zPcKOVAgRvSkGgvGoko
	B8vnCyeJY1myPfNa8ic5LqYLNNEo+xpfgV46ntyjth09ruWbbqJpI8CVdW8v3mAuykChbq4xswW
	6ce2c2KP1BBSyJWqH1rmkV5EhAVEQVBd85DvLLCEcgkF1XXWDu2poaE168VP4S5opXPvVtO3n8e
	pTu3EYD/Q278grSbfydwwGFh+XEQdJyx7qGWp6cD8HyKCdLoOQpOzmPYl8kuy8bWshwmeu1KiYP
	k0H1yD27XFSLsNYW+IxcNz8iQ8iVWIes6E0SFLaN5jsfEQmRM4b1y5UtyXVX2ir2bVPmeRrAN5w
	1S/CaQpW+Wowlx8Jo/BJ3jqeI68oyXao4QtW6V+F78QE8QiAVh2M+emz3CzKONgjz+lHE7MAAuY
	ZIwXzz2pYKZcTpV
X-Received: by 2002:a05:600c:1d04:b0:490:b58a:e6ff with SMTP id 5b1f17b1804b1-4922011dfe2mr38582025e9.22.1781360792395;
        Sat, 13 Jun 2026 07:26:32 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:4437:5798:e78b:2888? ([2001:8b0:aba:5f3c:4437:5798:e78b:2888])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49220304180sm79348345e9.4.2026.06.13.07.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 07:26:30 -0700 (PDT)
Message-ID: <4c36de09175dced8cd0ede2b52208671b30695a0.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH [RFC] 1/2] utils: Add
 landlock_restrict_network function
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: alex.kanavin@gmail.com, david.nystrom@est.tech
Cc: bitbake-devel@lists.openembedded.org
Date: Sat, 13 Jun 2026 15:26:29 +0100
In-Reply-To: <CANNYZj_gX=vNggcmyS0CtPoE+dYc0AjOf4=Z0QwcU46-Ccx4EA@mail.gmail.com>
References: <20260612-landlock-v1-0-77891f63ed7f@est.tech>
	 <20260612-landlock-v1-1-77891f63ed7f@est.tech>
	 <CANNYZj_gX=vNggcmyS0CtPoE+dYc0AjOf4=Z0QwcU46-Ccx4EA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 13 Jun 2026 14:26:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19682

On Sat, 2026-06-13 at 13:52 +0200, Alexander Kanavin via
lists.openembedded.org wrote:
> On Fri, 12 Jun 2026 at 14:01, David Nystr=C3=B6m via
> lists.openembedded.org
> <david.nystrom=3Dest.tech@lists.openembedded.org> wrote:
> > +def landlock_restrict_network():
> > +=C2=A0=C2=A0=C2=A0 """Block TCP bind/connect using Landlock LSM (ABI v=
4+, kernel
> > 6.7+).
> > +=C2=A0=C2=A0=C2=A0 Gracefully skipped on older kernels. Stacks with
> > disable_network()."""
> > +
> > +=C2=A0=C2=A0=C2=A0 NR_CREATE =3D 444=C2=A0 # landlock_create_ruleset
> > +=C2=A0=C2=A0=C2=A0 NR_SELF=C2=A0=C2=A0 =3D 446=C2=A0 # landlock_restri=
ct_self
> > +=C2=A0=C2=A0=C2=A0 NET_TCP=C2=A0=C2=A0 =3D 0x3=C2=A0 # BIND_TCP | CONN=
ECT_TCP
> > +
> > +=C2=A0=C2=A0=C2=A0 libc =3D ctypes.CDLL('libc.so.6')
> > +
> > +=C2=A0=C2=A0=C2=A0 abi =3D libc.syscall(NR_CREATE, 0, 0, 1)
> > +=C2=A0=C2=A0=C2=A0 if abi < 4:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return False
> > +
> > +=C2=A0=C2=A0=C2=A0 attr =3D struct.pack("QQ", 0, NET_TCP)
> > +=C2=A0=C2=A0=C2=A0 buf =3D ctypes.create_string_buffer(attr)
> > +=C2=A0=C2=A0=C2=A0 fd =3D libc.syscall(NR_CREATE, buf, len(attr), 0)
> > +=C2=A0=C2=A0=C2=A0 if fd < 0:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return False
> > +
> > +=C2=A0=C2=A0=C2=A0 libc.prctl(38, 1, 0, 0, 0)=C2=A0 # PR_SET_NO_NEW_PR=
IVS
> > +=C2=A0=C2=A0=C2=A0 r =3D libc.syscall(NR_SELF, fd, 0)
> > +=C2=A0=C2=A0=C2=A0 os.close(fd)
> > +=C2=A0=C2=A0=C2=A0 return r =3D=3D 0
>=20
> Far too many magic numbers. I would really want to do this with an
> API.
>=20
> This also needs some kind of test, e.g. that the function indeed has
> the desired effect.

Unfortunately, to use tech like this, we do end up needing to do
something like that and utils.py already has quite a bit of it. The
plus side is that the kernel is really good about maintaining these
APIs so the numbers are unlikely to change.

I wouldn't take something like this unless there was a really good case
for using it. Network isolation in more builds probably is a strong
enough use case...

Cheers,

Richard

