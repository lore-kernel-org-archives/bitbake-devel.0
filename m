Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C11C02183
	for <webhook@archiver.kernel.org>; Fri, 17 Jan 2025 05:37:56 +0000 (UTC)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
 by mx.groups.io with SMTP id smtpd.web10.4974.1737092272913396909
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 16 Jan 2025 21:37:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=cUyrXszU;
 spf=pass (domain: gmail.com, ip: 209.85.219.45, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6d896be3992so13701746d6.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 16 Jan 2025 21:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737092272; x=1737697072; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kVF1dqFL73O/d4uEWV3D9WdxLj5U1E/y4iaxN/D89gw=;
        b=cUyrXszUo2UT/XbIlau/uwvHU8FOQ5Mz1h92ELpFFCkTzCgbCYQ+GeJm8b2h8U2pBq
         GyNu0EjqYT1naL+5lVjVYT+WV/t11NUVbVkSTjz/NF0CI9xLw83oHWSla65U2WgiHCM6
         g7YRV5vxL2rxnwVky66opei5aiSjoKqfPj1qV0e6D5Dpe/Bax53NfD8hk0XsECGJQCtH
         X43ivYzAmEi8xKmyeVjwmULuXCKKgp+zg33dr0S0pl86FEJt/EDfUfPe2RJCsE7/CJHP
         OZRSJimMnpTCG+aSKbXYTX1WzMgNwzEMWhve/gqKLqB/unApO5XkFrclm2V2aEZypvE6
         Xs1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737092272; x=1737697072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kVF1dqFL73O/d4uEWV3D9WdxLj5U1E/y4iaxN/D89gw=;
        b=sRL9JuqEMagUF42IPXH661VZjHbsqBwJeu4dgRVwPS78oLf0gudUNmo+44Xh5hgQh1
         q5jhc0/HnSovLbKuigIwS9fXHiK/dhvmGBRDrCPwWfRjl26CV3GGYBWOxX7fPZBYkAKy
         FRPAX9QTvSv5TtW4IHO8nZrJVYD13aSjNZk0cDo+YZyAHve4UdcJUoyR7+0DQZCtUzpP
         T0t48BlbL/k/A5zyLOCIKQQV7x7kQMsF1REz9//pondCQq1bI5jklfuhBn7heop2yKDg
         TJxp8lYckzRpayughXXWNAAT/il9y9f1Z8uHKyGCwY0jB9jjLeOC2L1VrN8XTvgxFRBf
         sehA==
X-Forwarded-Encrypted: i=1; AJvYcCVB8FaAHIacZg0xjQSUkIrh09C4/Qk/2yciEPqP7IGOsl35FUsyhPZMF3rnbY0no60Ef8pjVLKpdweSX2vB@lists.openembedded.org
X-Gm-Message-State: AOJu0YyvwzmMkLan9eQ6BQqEZ5K9ERAW5wMuzKGN1F0dX4CFMr1yuva/
	7gUs7j5zSbAnIGxfC98oDvdyeAAmwG9WV7uf6z6DZry5XoYsizeSU+iGwqhKLr/bCtBuzHFJ1Ai
	8vnq7qt1RylFTf1I1XmUCOLy7CA0=
X-Gm-Gg: ASbGncvpzPKYCRAWYV2ROEfw1AqHxtOAJUMEL7X+BRGJ324eNcxD4uaTJe3oxTKDDfG
	hbjtOztiQ7DBax1A2wt84DMnYzyhNrszHiyii
X-Google-Smtp-Source: AGHT+IF51DiVdOYeJ2aO1XxhbyGSdsB7My8fJyVtiUYHv7SZrzx+Nk48yl+uh4n6+YB8AmSF6lMQXoapTpMPlrjKlQ4=
X-Received: by 2002:ad4:5c63:0:b0:6d8:8fdd:9791 with SMTP id
 6a1803df08f44-6e1b21a2665mr28484996d6.25.1737092271078; Thu, 16 Jan 2025
 21:37:51 -0800 (PST)
MIME-Version: 1.0
References: <20241220112613.22647-1-stefan.herbrechtsmeier-oss@weidmueller.com>
 <aeac8b24d43c57b7b426983ae50ec65680dafc24.camel@linuxfoundation.org>
 <CANNYZj9q6+D6AppzUbuV_cdMszt_KA3kfsamOtcRFxoWWFjV+A@mail.gmail.com>
 <513bf8f4-fb14-42dd-89fb-275e4b468924@weidmueller.com> <CANNYZj_z49bpc7fnvKO737La2YHy7zCPsgzwhS-G+=OQfi6uUQ@mail.gmail.com>
 <c164bf03-b00c-421e-a41c-441fe911eac5@weidmueller.com> <CANNYZj_-+uq0HmLYWAU1kEBPdkiCfyjkAu8cdSjxt6PsCB=-9A@mail.gmail.com>
 <7121dc06-215a-4481-be8e-7094a45e43ad@weidmueller.com> <CANNYZj_Ddh0zWbE79G5TAwQrU805WrrzDbjJTopT7EgLALBgQg@mail.gmail.com>
 <4f1f10ac-4a71-4b2b-9ea7-63e1da5d3e94@weidmueller.com> <CADkTA4MtLO90FW6YfeHDh7Lyo7=DRvxm6xf8Q0LkhC+u0U15iQ@mail.gmail.com>
 <1d86a392-db47-4fac-81fe-5262477bcd70@weidmueller.com> <CADkTA4PeRvBoR-F3pM-XOjWKEjsgLX+entDPv1uL+uTiFxjc=w@mail.gmail.com>
In-Reply-To: <CADkTA4PeRvBoR-F3pM-XOjWKEjsgLX+entDPv1uL+uTiFxjc=w@mail.gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 17 Jan 2025 06:37:40 +0100
X-Gm-Features: AbW1kvZfzLoua9BzlSj-ULH1byQLlQUXloRgCTlkcA4qD6zNu1A5lh7NXmPYJaQ
Message-ID: <CANNYZj_C=6oDyL-uLhqtwJceMmjiDobwB7g2OK-TN2-tXngCfQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [RFC PATCH 00/21] Concept for tightly coupled
 package manager (Node.js, Go, Rust)
To: Bruce Ashfield <bruce.ashfield@gmail.com>
Cc: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>, 
	richard.purdie@linuxfoundation.org, bitbake-devel@lists.openembedded.org, 
	Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 17 Jan 2025 05:37:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17021

On Fri, 17 Jan 2025 at 05:20, Bruce Ashfield <bruce.ashfield@gmail.com> wro=
te:

> *sigh*. I'm quite aware of what can and cannot be done. That's not what I=
 meant. I'm obviously not talking about something in WORKDIR. I'm just sayi=
ng that if something is written to disk, then depending on how things are i=
mplemented it can be viewed, debugged and manipulated. If it is always gene=
rated, held internally to the classes and used, I have no options to do tha=
t sort of debug. Similarly, anything that is generated, it would be ideal i=
f there was a way to re-use a previously generated artifact and not generat=
e it on the fly .. that's the element that opens the door to version contro=
l and tracking.
>
> We'll agree to disagree on what is or isn't efficient or complicated. Luc=
kily, this is all opt-in, so I'll never really have to use it. I'm just sha=
ring what it would take to get me to consider it based on what I've learned=
/suffered in my time maintaining quite a few go recipes.

I beg to differ, as someone who maintains a few rust/cargo recipes.

I haven't once found this ability to track SRC_URIs in recipes useful.
It's always been auto-generated noise and I'd be very willing to
consider an implementation that keeps it neatly hidden, if this
implementation is fully oe-core based.

So Stefan, don't let this discourage you.

Alex

