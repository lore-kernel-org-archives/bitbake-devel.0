Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
 by mx.groups.io with SMTP id smtpd.web12.134855.1598021833724548684
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 21 Aug 2020 07:57:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=BRahjyBh;
 spf=pass (domain: gmail.com, ip: 209.85.222.179, mailfrom: jeff.dagenais@gmail.com)
Received: by mail-qk1-f179.google.com with SMTP id n129so1595968qkd.6
        for <bitbake-devel@lists.openembedded.org>; Fri, 21 Aug 2020 07:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=JKnNgs3mNOtvuYAx+wYG2uxgeXG8UbpNVQ2HI4ivJiI=;
        b=BRahjyBhAmOWClnJBPYdEke0OkOsThfE4Au7lxL0/Jz58x5R+CRMO8UTVxGXYfOWoh
         tdkM+HRUG98GR6cA24chdeLIPmdYInjlu8VRIlXpD4zH2mDFqOZDn+NQ9ouNukutj27a
         Ft4FpwIJdxlzOw68ucsreqnbXNrGTNF0Z1vKIR9e4Fppeny0FPnFWh25wHHHh0j1Yvo9
         jBA3nwJZBYP3FOfZaVXFy4PMfr1KH78Y8iD232TcpyaG/Twxrb05jV+TmX1yyngU7lyL
         cgRxWWts9mi/rZPC1XuuvwetuEMEDJqYmbq5qp1IkGWrp4XfLggFNy3XIr75+QLIRikc
         c59w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=JKnNgs3mNOtvuYAx+wYG2uxgeXG8UbpNVQ2HI4ivJiI=;
        b=FD+Z9FXZaduXAodE/SCPUk2o/092cSKnKL1Ehf57P/JsTpv/KRYB8yqjKyhhVckQ1s
         6O0yw8h8wI3eUoGFLUTHftFlf90bdRgmbLFlCcQcDuETjYGk5V4f3g0iY4IYCehXtOFG
         K81QVvvApsgr+AUc9ZcfSKadAj5EJ0/8AeRMg7Ffoxc5bqdLoXqGkfZ99Jm4X6eyWnpp
         OedwQAquRyBEjaqQpAgKVn/+hCN/ckBPiuJoEuNDiz6Rx+IJxJBuk1HF/0CeHOqzVUHW
         kO9004aiDYNETwcONQBnPNHNk5MHy+VI83knDcEQ9gfwnbOhLVFnFjJAeFYB+2HaxdZW
         Ed6w==
X-Gm-Message-State: AOAM530y8hi3ktvdcxLWHa/N0Cu9czsKjgW2kwHRzuZGFtLQUgp6DatJ
	sKxgZlNLy7DQsFhqq1O+4lI=
X-Google-Smtp-Source: ABdhPJy82HmjMWXV1RkajjH+C1NAibXnXv1soxZ/q3s2zxR0Icjh0jinfaAYoYqpnHGQT8RK1FhXhg==
X-Received: by 2002:a37:61d4:: with SMTP id v203mr3342668qkb.390.1598021832966;
        Fri, 21 Aug 2020 07:57:12 -0700 (PDT)
Return-Path: <jeff.dagenais@gmail.com>
Received: from [10.0.0.29] ([135.0.225.35])
        by smtp.gmail.com with ESMTPSA id t12sm1883607qkt.56.2020.08.21.07.57.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Aug 2020 07:57:12 -0700 (PDT)
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [bitbake-devel] [RFC] siggen: clean_basepath leaks full recipe file path
From: "Jean-Francois Dagenais" <jeff.dagenais@gmail.com>
In-Reply-To: <162D503D94CCE370.19371@lists.openembedded.org>
Date: Fri, 21 Aug 2020 10:57:11 -0400
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>,
 bitbake-devel@lists.openembedded.org,
 =?utf-8?Q?Maxime_Roussin-B=C3=A9langer?= <maxime.roussinbelanger@gmail.com>,
 guillaume.champagne@sonatest.com
Message-Id: <5F06939E-E3FD-4860-9510-D0887A24111D@gmail.com>
References: <20200820215000.30818-1-jeff.dagenais@gmail.com>
 <1819f13202abc9339dbdd0215d714fda8a9b070b.camel@linuxfoundation.org>
 <162D503D94CCE370.19371@lists.openembedded.org>
To: =?utf-8?Q?Jean-Fran=C3=A7ois_Dagenais?= <jeff.dagenais@gmail.com>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable



> On Aug 21, 2020, at 10:54, Jean-Francois Dagenais via =
lists.openembedded.org <jeff.dagenais=3Dgmail.com@lists.openembedded.org> =
wrote:
>=20
> It looks good, just using a slightly different method than the patch I =
sent:
> =
https://lists.openembedded.org/g/bitbake-devel/topic/patch_siggen/76318034=

>=20
> Can you share why you remade it?
>=20

Never mind this part, just saw you replied about this while I was =
writing! ;)=
