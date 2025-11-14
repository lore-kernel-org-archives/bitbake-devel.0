Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F7ACE8D52
	for <webhook@archiver.kernel.org>; Fri, 14 Nov 2025 16:20:35 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2188.1763137234974097175
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 14 Nov 2025 08:20:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=AaLkkhFo;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47778b23f64so16401645e9.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 14 Nov 2025 08:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1763137233; x=1763742033; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gq1LoLX+G/hSFo3Xu123qgTSnuqW460z85RA59yPbv8=;
        b=AaLkkhFo7UJ/9xx8tFb11evTfw9jNH5aqiYr5HqQn6cWba1Rq+VJpXGagNfh6AeRE7
         xJ5UwU0v2z1o4iOJLzbzSI5kMTPZ2Bqtpai2sjyO74sqrmSFCw+900nGowEIcA/qNzps
         D/CXa92RwcCD34G4MRaN/kaN2vsfzcAJA8z8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763137233; x=1763742033;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gq1LoLX+G/hSFo3Xu123qgTSnuqW460z85RA59yPbv8=;
        b=MxpzYdOgfJxkZvLxvC2XObvrEDRE5+AtYH5WK01oANG6AjQERiDeUMrfAJBSvkU8Oa
         //Jq01dOyJbvH3dGKvl5NH8Qnu8Ix5gx3nWWcdqcTP9AO1tgD7CsndqU6NeBcjC8w5I0
         cORNFwyuutkpGtcQCq98L15WsgXyTkwyim1kYYG4hLYVbaUCt8mKaM8lVvyoC0AHPKX1
         lqOJ1tP2JgWPjUxCs8swxpg1EyO0kKOeKrE1mlX9LefcQIIsOcOySK0KqEhezMPAnZWJ
         EWgcx2mUL7zi46WGOIxYNR8BafQlJO/OxcJEIkKzdwYt0QTqx5wu+ig/UFwABgfmbr0+
         LrYg==
X-Forwarded-Encrypted: i=1; AJvYcCWujOivdbuxXKP3xFUF/i9p1l22xld5dEbarnkD64HuK+TGmbxQwY6wtPzUbRYybIIKVGxXVKMaTj4GcedG@lists.openembedded.org
X-Gm-Message-State: AOJu0YzTYMU48BBqohKgvIjX8VoyVhfIxoxHSpIxbzQj3Cy0LhEdpiCm
	Ql86+rLgDgPJcQYc5h3Ezq+qg04ZLdROHzy/FjaizfmWf/jxJOqMj+BJy3n13eefQZg=
X-Gm-Gg: ASbGncujnvDhQ7BRrFIM/PVTXsoGS8vIOo4K8d9rLACo/iLk8FSRm5GV8yzMO8c5ycI
	RNgHsbkR1AFDY87YMJnbLl4UHOv0nz+zdbzuDc/UE9of//E5Gi57gGZuQmMK+2GRHg35CzDDPeP
	RSd8zQMk+LjIWCmt7f7lBk8CuoNmuW7WtXgJw3HRTxhSsWvNiQt++RWQf9w3l2GUdRPMSDnfz8X
	7XwUZJUiEb1KoL17/emR2i4lUDdWGEaS6CywTIh2GOeOYtC5bjhQ5JCOIq3gL6R1hKAaPiPRXAF
	Rhb5xnlLMXBELfxciBb5wCPmvocNvRJU4BqwUUh5fD8uzvdSaQZB+TDYOsj/bP4VrXb39l0iIGn
	1WWCoy2+SQbVE64Ev4HgOqgdiP0eFMV3lQrNX+Q/zLR+Xg4PGMLap44YgjKMwhYzgKh/XlPFG20
	cIHMS2PQx4uuuZ5VESoRKgqOel4XBwWBHLPwDXPnI7xkNBTRgKtyXres7GcqQXemrxp/vODyBwh
	bE=
X-Google-Smtp-Source: AGHT+IGXQqoSVSJEorx7br2jUiLBbJf7070GS4oEKhTL90vZ72lIn76i97DkbrlU5N9xqHcssUPmcA==
X-Received: by 2002:a05:600c:4f93:b0:45d:f81d:eae7 with SMTP id 5b1f17b1804b1-4778fea6decmr39731075e9.28.1763137232809;
        Fri, 14 Nov 2025 08:20:32 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:e30a:8116:32e6:5cd2? ([2001:8b0:aba:5f3c:e30a:8116:32e6:5cd2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e982d6sm10997264f8f.21.2025.11.14.08.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 08:20:32 -0800 (PST)
Message-ID: <ac14418a9b48da26440e6ddcaa6fa163733ad9e8.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 0/2] data: Escape back quotes in
 environment
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: mathieu.dubois-briand@bootlin.com, bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Date: Fri, 14 Nov 2025 16:20:31 +0000
In-Reply-To: <20251114-mathieu-back_quote_devshell-v1-0-45e83df2f362@bootlin.com>
References: 
	<20251114-mathieu-back_quote_devshell-v1-0-45e83df2f362@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 14 Nov 2025 16:20:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18403

On Fri, 2025-11-14 at 14:27 +0100, Mathieu Dubois-Briand via lists.openembe=
dded.org wrote:
> Fixing devshell when some environment variables contain a back quote. On
> my side I had this issue using kitty terminal emulator, which sets the
> KITTY_PUBLIC_KEY environment variable [1]:
> KITTY_PUBLIC_KEY=3D1:`TB}~6^vgiFD2v6d}JRgt!X|qx#0~mO?&N=3DA1jfi
>=20
> Trying to use devshell failed silently, but the parse error is visible
> while launching the do_terminal script by hand:
>=20
> tmp/work/qemux86_64-poky-linux/linux-yocto/6.16.11+git/temp/run.do_termin=
al.2972397: line 120: unexpected EOF while looking for matching ``'
> WARNING: tmp/work/qemux86_64-poky-linux/linux-yocto/6.16.11+git/temp/run.=
do_terminal.2972397:119 exit 2 from 'export KITTY_PID=3D"1985830"'
> WARNING: Backtrace (BB generated script):=20
> 	#1: main, tmp/work/qemux86_64-poky-linux/linux-yocto/6.16.11+git/temp/ru=
n.do_terminal.2972397, line 119
>=20
> Escaping back quotes allows to launch the devshell correctly.
>=20
> Also adding a non-regression test. The whole bb.data.emit_var() function
> was not tested, I'm not sure if it was by choice or not, but I added
> some.
>=20
> I tested the most basic code paths of bb.data.emit_var() but I'm not
> fully exhaustive. Notably, the return value remains untested as I was
> not able to figure out what it means and it appears to be unused.

Tests are good thanks. They're not present as the test suite didn't
exist when that code was written!

Cheers,

Richard

