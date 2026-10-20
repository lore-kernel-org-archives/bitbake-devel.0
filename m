Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6300.1792499450951646036
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 20 Oct 2026 05:30:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=aaIAjNCl;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a1ec92f655so7392605e9.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 20 Oct 2026 05:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1792499449; x=1793104249; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=9S3KNUYRqBerkzIH7ffJGf4L1q93R/YZDXyG1lOU27w=;
        b=aaIAjNCl5Xl/REi1D1onTE3+0mkchea48mxoWRlSeN3IQ0Zler4lvrO5JR6guq8XJT
         yddLgghvaOU4vT7/YUeox42BDlJXR4/hDgDQNfpT2VAJRteHHZ2HIjcWWSxIhTlXhub+
         FgPgWWPHeD22BkTAcId/YSpPSBMxbYnmOg6jo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792499449; x=1793104249;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9S3KNUYRqBerkzIH7ffJGf4L1q93R/YZDXyG1lOU27w=;
        b=xVEZYbngXHNc50fhyO2gPWx9MZW+udp+OYRu0CicodTZ/5Ft78yHkyuJSTaIiOSSgG
         FVjffAMc0y6mecWE/4CHAZjHGliRtMg0Y6x7XWaEm7+YVpMvD2OqMT+fpIa3gNAic0W+
         9SJCD1h2JzBQpFFyDe+Ae39tDDPpll7EINghVu2drf+Fsdosr3krOSeXcMVqYHI6Rpp6
         8VAeqlg4n6FAB9HdkJquG45gEZu/yqMT2D7hsF2gHKDnsQzXWZ6ULjLgVF37XYBRdsIV
         FMm77qnv4FnFyUpbiDBCkVo9Ae2uLxmLaLtrD83VH4if3uxBFkPKCe5wJq/zvibPuueJ
         Oa9Q==
X-Gm-Message-State: AFq9FYIbKVqEbrdpXVQsjChpBm5yxVH5fqhoL9hTllDFgmpdAVd223pC
	ivfzxY9O+Zahb+cHEtkSMzZ2HE4jqAgbiCqxCdxx/soRkbxO3baBBHUy3sZMCVJHWsc=
X-Gm-Gg: AYBFou2DxWl48wMVoEu4UMHFsV8tRHJaEOJzzgvT0chXO3vo/vnY0MZG1GO+/KhOIET
	/0Ik0EipblvSzuQz9geeVeWTFh2I4vCE0/JNPF7O8i6qkx4Ovsf7xI4zr8pBpayGDSZmmdG5S+v
	dv5rLziQqNYyCDroZtlkybVHxGiwBde/a986YPwUNIzcrcjsKmz5hvlWiDL68k0BkOUz5vcGB86
	mjrSDb3L3u1wyAcH3dWW7a1vc9RByE3IBYz02iBjD/6HWq1MXjZoELB54FegW8g/Bpjtfw9fIX2
	u9P02epKQXDB5CEarspYOkpikVPo8CIyyi6rrjjZWw5LIrY2JODAOHAVjqJzOCdF/0rHQNtF9+P
	elN8uzLr+M/+vaiRUuvrYLCGU2wajtsIRrFUlNTQgnWr7gKYmkOknNay+nyjiwhYMd8DujQ3vVa
	IFeNvU2uzTH+l2uZMkBwxBmpkWBdC8CDnPVCd3FeHfNOo09nlO42pETaleW/VfL5dYibPNwijTQ
	Xw+WakgK2i53qX7orXM73ckLCy+MO+Bnfn8IUOgjPQv6wuPRXWa3kxM98J8/bM=
X-Received: by 2002:a05:600c:1c19:b0:49f:c5aa:9ef4 with SMTP id 5b1f17b1804b1-4a1f4d81b75mr51103765e9.8.1792499448775;
        Tue, 20 Oct 2026 05:30:48 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:afe4:94a7:60b4:8f6e? ([2001:8b0:aba:5f3c:afe4:94a7:60b4:8f6e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2cdc342sm75312005e9.13.2026.10.20.05.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 05:30:48 -0700 (PDT)
Message-ID: <7f00a969c9ef34a77342ca8909def148aceeb652.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] parse: only search each BBPATH
 directory once in include_all
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: ross.burton@arm.com, "ticotimo@gmail.com" <ticotimo@gmail.com>
Cc: "bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>
Date: Tue, 20 Oct 2026 13:30:47 +0100
In-Reply-To: <6C7FAEF1-2BE9-4E2C-B2DF-A037491D00D0@arm.com>
References: <20261019020422.14365-1-tim.orling@konsulko.com>
	 <6C7FAEF1-2BE9-4E2C-B2DF-A037491D00D0@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10build1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Tue, 20 Oct 2026 12:30:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20362

On Mon, 2026-10-19 at 16:12 +0000, Ross Burton via
lists.openembedded.org wrote:
> On 19 Oct 2026, at 03:04, Tim Orling via lists.openembedded.org
> <ticotimo=3Dgmail.com@lists.openembedded.org> wrote:
> >=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for path in
> > dict.fromkeys(data.getVar("BBPATH").split(":")):
>=20
> Feels like using a set() instead of dict.fromkeys() would be neater.

Ordering matters here...

Cheers,

Richard
