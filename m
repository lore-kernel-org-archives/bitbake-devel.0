Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6421.1795212989596688293
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 20 Nov 2026 14:16:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=cDlBRmyc;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.50, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4bb85e07aadso15784635e9.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 20 Nov 2026 14:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1795212988; x=1795817788; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OvYNC7Cq1p85tkI+j0JJUg7FsrlaaCx45sr778TKsUg=;
        b=cDlBRmycQv3+VpqcfBan4Te4kkScjyduVRlfxQzeACs0DFKf6NhvxWtRKLWxIKNC2r
         t/80elvGCXFqjUdfh0nglB/mY1bJJRiVfQ92JXoemGdsZNgOBUVtZrPJBhdKpf/wBUa+
         k2iFPgKoCfJcvgHbi/QmSN5nBKo9AGnHlZQQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795212988; x=1795817788;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OvYNC7Cq1p85tkI+j0JJUg7FsrlaaCx45sr778TKsUg=;
        b=h/7hGddQMWHbO5QwwJj3yqjfl2NIn6nzW9i9cCugOskab3OibcJzdbuyaSuviN0l/X
         8uC1d2DPdU92trKassln2gTTOz7znKvIfE1u4gfu53QWfXY45/OqrfUjWEOETYH2F1xe
         NZPMi7RMypeb+235yqumFYKBPddJ5Xgyg8KHQZK9+E+6pCGSBn1w8j891bpu33YNMrvx
         S3JPfDAattrkJdDG95m3KdqEIZXCxBihV9gRH1Ld9qzCJ/wtuI/xI1yEtcXQMKe/T2+B
         Q2fyaolDvTglvt8QBXc/fMyEJsgvpWE8rSZ1x6NmVOQa3x6VgoS1Ohaj9ICwL2ReTZcY
         biKg==
X-Forwarded-Encrypted: i=1; AL+hErGTuxwLoWfzNN84GdUi8h4GtSITJ0SH+kc+t0XMdtuDcehkJVbk9fnEDaOrim3oOAP5866UmZYnem8Uce1J@lists.openembedded.org
X-Gm-Message-State: APuU4Z/YozDimDojXm+pKh3VhBWwEIIh/A2LC9S2GV/2PSlazAoBhCPR
	56BzkUf4zgs4hNYxSVuOco4QKe/+eAPkuQh3G0bI0d8jf3ItjsjKXvPFg4EQpjrH1vs=
X-Gm-Gg: AYBFou0ZuF2ytib/3NZu9Vb7P30HeE2DH3IqrWWRaDvltlm/WbFMp7BlCliEyB5sYqD
	/NX6lBarwguqfUdBiL8jiqE/lsGPDNPdMwe87X3uthLo2kvMxP+5zlCqIs1YjnoMIbicSWBZXGS
	sxWWqZ650ztUZ2tY1pGrTjx7SsAQnclr8v+tyGOxZtrwM398c/hkuxf4oyDqSX6bRkIKA85oUKG
	h/2ZLB0sIm8o/Keb6dgbvNE13fDF01PS4s0F93GTN83zzByKHqlB0W6iduUjlDyf9ll5TqYZSGo
	wQCqQbw+ImhlaY7ti57kCzKU/UH9VhatCqAiWTxR9F76F9mpfAuxak1rCugPMJBxIIRot/ebNiN
	yqHBp54UwPpVYvRGUL0C0lMoSMBN9SoeTPDyWzvZqs1h4C85fT1YE7yC8TM8+SBD/N0+nZIlah1
	LM+npiVhZ897aTbkiW8U0z3si+Tzz6GiphLQILyAwkEhTum8WCOUiVEBXiudarOuDt3ceWpHlCR
	l1dIMCATmlp3yvYeDEdKDO2xr0bgj6b9D0yPe24qI6ezVKmkFkcBwLTArdKQ9vve6+313tzWf+0
	c2qP/QqpOILERhZCkvtC9NspcKKzjfjTS811z2h+6GuDaRkUeGE6rYzdfnGVDr7GtfJCHtNGfRY
	z8bhF82ooxXoTDnEYuA==
X-Received: by 2002:a05:600c:1d09:b0:4bb:6b59:aac3 with SMTP id 5b1f17b1804b1-4bb88816050mr104978345e9.29.1795212987648;
        Fri, 20 Nov 2026 14:16:27 -0800 (PST)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:ade0:e24c:97d2:ceef? ([2001:8b0:aba:5f3c:ade0:e24c:97d2:ceef])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853a9687sm166131195e9.10.2026.11.20.14.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 14:16:26 -0800 (PST)
Message-ID: <c5c653afd21314dc7d58248102fd23633fec54b6.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] gitsm fetcher fails when `PREMIRRORS_ONLY` is
 set
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: tiago.mlb.vasconcelos@gmail.com, bitbake-devel@lists.openembedded.org
Date: Fri, 20 Nov 2026 22:16:24 +0000
In-Reply-To: <9Kec.1795097583791318314.gZXu@lists.openembedded.org>
References: <9Kec.1795097583791318314.gZXu@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10build1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Fri, 20 Nov 2026 22:16:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20469

On Thu, 2026-11-19 at 06:13 -0800, tiago.mlb.vasconcelos via bitbake-devel =
wrote:
> I have encountered a gitsm submodule fetch failure that appears to be
> related to the following change:
> https://lists.openembedded.org/g/bitbake-devel/message/17506
> This change prevents Git fetcher to silently contact upstream
> despite BB_FETCH_PREMIRRORONLY being enabled.
> However, for gitsm, this datastore is also passed to the nested
> submodule
> Fetch. The submodule therefore inherits BB_NO_NETWORK =3D "1", blocking
> its
> HTTP PREMIRROR download, even though the parent repository was
> downloaded from
> the same PREMIRROR:


The best advice I can give is to write a new test case for bitbake-
selftest (in lib/bb/tests/fetch.py) which shows the issue you're
seeing.

Once we have that, we can likely more easily understand it and try and
come up with a solution.

Cheers,

Richard
