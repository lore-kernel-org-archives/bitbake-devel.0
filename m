Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6321.1792499537417818927
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 20 Oct 2026 05:32:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=ILb3wm98;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48e10a70540so1368623f8f.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 20 Oct 2026 05:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1792499535; x=1793104335; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=9B0KrwUSvD6pInG1QyfeUYzFsUbTgkb7BnnsNsItNPA=;
        b=ILb3wm980g0OwZmm/86n3yA25NH69xRW1AAixshJNvfka4bMJh9Li7ib6RPAJo6gEb
         nznwWt0h25Jo2I8qXAomte2waA0JDnwZqLo8Hh4KM0LmP4mdODUPjlCPXbRTVho91Mx9
         06t4U05jZG+8k+LbITq7UHqBRBMFJCr+GlUjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792499535; x=1793104335;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9B0KrwUSvD6pInG1QyfeUYzFsUbTgkb7BnnsNsItNPA=;
        b=heeqpLxhbP0/9jtWPI+19CVvKXucLUglG2Xz0Gus/BO4iba4QclSv7Dk3GtEC7Tjer
         5jemhQ+c8SxEI7I5SiNWmhua1Z4trqVzStoCTdCW9fF6ko7zZuemgKDOUiiSHBkHeQR9
         e717l9KYw4ODE0GyJUKK8wpvS3rNjS5JiSzBiEgVrHmVm/CFB8J7qhbp4vbCHPHVCsBA
         4O9I1SuPjgKUjwNfcCp7MQtV/APx4BJU8Ovwckh1BQ9SdUXKzqBS3RNdY3c1eEeh0OoU
         rh64DadrSbDgSwVA3lXsYxTmW2j4KXTvfh4WBqCNepLsnJQoDBOKbVrp3/7yohgz/syg
         XU4g==
X-Forwarded-Encrypted: i=1; AKwUvByn+cCwUTm/KXLq/wP0RUkQg5zBJOQjZIFqmHE/NQTB8VxhkQe5CQ8pwfpee6bUTyBkAEEVsG8IVGvK8eSE@lists.openembedded.org
X-Gm-Message-State: AFq9FYIr4gBckrGJGteBL/zHIYQb4ucgonWyiWcurmpvz7iZfQeOa8oN
	ofKirDZqKLec59Sh7LwcNsq/aLbRgpigt6nmv8a0DjjylDqLMOEIQtuki2PbBNPlfWM=
X-Gm-Gg: AYBFou3QSASqv5kIWh09QfIQhhgnE33iSGxKqex8HNTwini7QqpjBrZMjLHApHYZ1Ii
	f51DtjIhcYNNekId/bJ+H54o08CTgOl2xBFaqnL4LaEgOl+LgASql/Pb3be6hTMy8/msiO3quMD
	hIM/YricGWO5tUBnBCbyEOuxbeRpZscbUjDto1XuyHa/KMfydw85UGLDF0BXPo50Ew2dwwU+KnW
	m6tmmtw2yMVsRNJUyK5OXo682bJ+vxN+9N4OVTGZlkr0eJq0IzHlpi5ACCtJ+zEl1T0oaQK99lI
	OpUIhHJFoM/Go8wIg8eRSjgaMbWm4wg2q/0JexP6nUroH8F1wTa3soFe31iogJrQ+ZEVnME/1L2
	wlQ7iUTFrNyvDj19hKo7cfiLoOwA7ULj1VbHfEAdDqzGb7drbyy2f6gGbWmURlOrtEPXu8h48Nu
	OTHFBFdGCtQBU9qzbEbd/6tG24K4sGTODNhhKOrNO0+ncVycEC67ErampLesvRF25S7fr5CGv/G
	YgxrptIFJR8GGUmJ2tJqwRWnbzXto7s07TLpFyg6s4uW/9/xSNrW5WJDPrrK3pyzWmPRkNYkg==
X-Received: by 2002:a05:6000:184c:b0:48d:f470:6b31 with SMTP id ffacd0b85a97d-48e07fa499bmr21043331f8f.38.1792499534907;
        Tue, 20 Oct 2026 05:32:14 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:afe4:94a7:60b4:8f6e? ([2001:8b0:aba:5f3c:afe4:94a7:60b4:8f6e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d6dbbb0sm6021473f8f.5.2026.10.20.05.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 05:32:13 -0700 (PDT)
Message-ID: <15d454e123cc90b3d307ed8199740748b00dc83e.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] parse: only search each BBPATH
 directory once in include_all
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: ticotimo@gmail.com, bitbake-devel@lists.openembedded.org
Cc: Tim Orling <tim.orling@konsulko.com>
Date: Tue, 20 Oct 2026 13:32:12 +0100
In-Reply-To: <20261019020422.14365-1-tim.orling@konsulko.com>
References: <20261019020422.14365-1-tim.orling@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10build1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Tue, 20 Oct 2026 12:32:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20363

On Sun, 2026-10-18 at 19:04 -0700, Tim Orling via lists.openembedded.org wr=
ote:
> If a directory appears in BBPATH more than once, include_all includes
> the file from it again, applying it twice and warning "Duplicate
> inclusion". The layer index hits this because the core layer is in its
> initial BBPATH and appended again by layer.conf. Skip directories
> already searched, and add a test for it.
>=20
> This fixes one source of the warnings in [YOCTO #16451]; the duplicate
> inclusion of defaultsetup.conf reported there has a separate cause.

Tim and I talked briefly on the review call.

The patch is probably ok however the real issue is the path duplication
in BBPATH and the "real" fix is probably to detect and error on that
happening in the first place.

Cheers,

Richard
