Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E1ECCE8D6F
	for <webhook@archiver.kernel.org>; Fri, 14 Nov 2025 18:30:16 +0000 (UTC)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5249.1763145016040845647
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 14 Nov 2025 10:30:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Fpjg5age;
 spf=pass (domain: gmail.com, ip: 209.85.128.182, mailfrom: jpewhacker@gmail.com)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-78933de9ab5so6708867b3.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 14 Nov 2025 10:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763145015; x=1763749815; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oI/JdbF42U/4zPEVNhn5RYDw0uJp0DBcA7Syw3qjT1I=;
        b=Fpjg5ageO2ULlzgA8B0FDjtIiffLWf7cTsExmTJU2XjZxyh8i/NmfqRd5Scg9QwEYg
         UmHwKOgONQ1Ckk1E8NMDFKWGfSuwY2kdya2aEQHh1x+8gH1d/SSpD/PgSJFkV/IpjHv0
         V+3AI7B3jFbvDoSxPBK4cim3BAJ0Xk3hK+6AkDgfNoM6/dMRU4oBu+9dJ+TwC3qWQLbU
         Ic4+1siYl/zvDBMjeIu8RpqDaVLR087VkgKHO1Yuvh4Ez6DGbuYGzdQxhei4x8CeubDH
         /9PhORDL5o1KZplSGTcdsl95bXYaHmEjrSIZzYw2SKZYkTRFj7iKPlm4uyDTflc3rOJR
         K76A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763145015; x=1763749815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oI/JdbF42U/4zPEVNhn5RYDw0uJp0DBcA7Syw3qjT1I=;
        b=OmUQHNub6mwpt26r5D7xG2Ay5t47KDdBJ5pdBqfTQyEQR590ugcsGQC1Q3lL4ROHeh
         341j79IPP7/sjG8WQYARTUjdrATTfjiav+vRPuzuIulqbMrH/JG8mvtzdijQ6E7m2rSF
         1G/BH1WcNR7UFD34aDuSVuA7kzY/2MIk5K/2j4qaMzULjz0iLHYKZY4WEB6Dv4z0Eof/
         XURm+CYAtgI6PVdORBk7gun2mNPdarrInouEbrzbdCiAWtDaB/zQ/cVUnJAumvepYpzM
         zFt2pqCySmf+kY6yYzZPbVRw8IK7zqajTvSEtdk+JgVQiDLXrpBgjL8nSxVrkFF/JCrw
         TnuA==
X-Forwarded-Encrypted: i=1; AJvYcCUoUh7mChfI1ZCWI5SKutykJOWuIwLum4KVQ+iejXYWYXVsj7ZGVMZ7aR+H0bytdIBwOZpZAJ+OisKhEeC5@lists.openembedded.org
X-Gm-Message-State: AOJu0YwtMDrW9HctClc1Be2H0F7UDdIezHVbbYKOIIqgW68cVDKl/M7O
	Rm+5q0k01yaCy3zaScKT+8wtFNS5APxsoSORBmH3Se3miBVXgHx192htp0iKgnkZnQ6OWN7oadX
	RRfB7gsnuAwMTGUkXJp3DUhBTLv9RJtA=
X-Gm-Gg: ASbGncsSJF/U+pGF3XUz4VFY3kaSJnLIfJDL77JJHEdRH5sn6DnvhVgsHI2KMpoKAZZ
	DckmvE0eCjG71gMLAAnyhgL8MDfYdJ9A7hVrAqyyRYqUxJDTcSlb5DmQeGEZOkzsOsWC5tldQHp
	WxXfrOpUh9APUnbn9XNJkaUj45awrFz4DifPKYdVxSi6PEh1cqRH53lkk9ZiakMMzUtkSJxgIQ7
	k2tCEPaaOyMFG7TheaEXcDBoV/G7ctm6TDOWjWNaaCbcphn67YcPdYjjAq6MI+5aAl3m3Pi77wW
	shOqLUc1Nw==
X-Google-Smtp-Source: AGHT+IF6zeG41wSXSjmmLMw3MQDzHqEnHhHxaMqA2YzyrVjXtUTshe4leo8VBr9jJSfy9/HeAYNs5zWiUfo/ACKc4SM=
X-Received: by 2002:a05:690c:6c0c:b0:786:9be4:749c with SMTP id
 00721157ae682-78929e8ee59mr40433267b3.31.1763145015019; Fri, 14 Nov 2025
 10:30:15 -0800 (PST)
MIME-Version: 1.0
References: <20251114-bitbake-setup-abort-v1-0-d2f9967df3b1@bootlin.com>
 <20251114-bitbake-setup-abort-v1-1-d2f9967df3b1@bootlin.com> <CANNYZj8wihnjM0YQwLGz-s9N2jvYwuGsUO0et9=V_sJj15as3Q@mail.gmail.com>
In-Reply-To: <CANNYZj8wihnjM0YQwLGz-s9N2jvYwuGsUO0et9=V_sJj15as3Q@mail.gmail.com>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Fri, 14 Nov 2025 11:30:03 -0700
X-Gm-Features: AWmQ_bkRk2C1yaaQpG0HzJxvEaGMvxF3gsPtYdItYAihnGLoeabdwPOHGomaj5Y
Message-ID: <CAJdd5GYUSajdDwnC3DBOWCRjj0giE+10OAGR6e8afftRSxV8HA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 1/3] bitbake-setup: fix top_dir creation
 in create_siteconf
To: alex.kanavin@gmail.com
Cc: antonin.godard@bootlin.com, bitbake-devel@lists.openembedded.org, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 14 Nov 2025 18:30:16 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18411

On Fri, Nov 14, 2025 at 11:21=E2=80=AFAM Alexander Kanavin via
lists.openembedded.org <alex.kanavin=3Dgmail.com@lists.openembedded.org>
wrote:
>
> On Fri, 14 Nov 2025 at 12:07, Antonin Godard via
> lists.openembedded.org
> <antonin.godard=3Dbootlin.com@lists.openembedded.org> wrote:
> > -        os.makedirs(os.path.dirname(top_dir), exist_ok=3DTrue)
> > +        os.makedirs(top_dir, exist_ok=3DTrue)
>
> Wait. What and where creates the top directory then, if writing the
> site.conf still succeeds without this change?

I think the directory was being created by accident in init_bb_cache()

>
> Alex
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#18408): https://lists.openembedded.org/g/bitbake-deve=
l/message/18408
> Mute This Topic: https://lists.openembedded.org/mt/116290012/3616693
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [JPEWha=
cker@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>

