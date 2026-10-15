Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE728CC6B3A
	for <webhook@archiver.kernel.org>; Thu, 15 Oct 2026 11:50:08 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.37748.1792065003345810040
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 15 Oct 2026 04:50:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=IOyGlolP;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.51, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a1682bff3cso9037075e9.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 15 Oct 2026 04:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1792065001; x=1792669801; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=y4RE4qn2Tf4xNwGevvOdi1sIXSfmEvtIegvCTHmueDs=;
        b=IOyGlolPGYOUHUldLr764nFpV7V1R1LmtR1blmYQKeL7gtorHcfACsm9wBC4FKCr/f
         TaRKVAXk+XKmThHXZprcvWU1zQkjPAY4ZPo6RMNivB+/Y0g5HQJWR+6MU/TifB1/ziLT
         OOxwBUPlGq56wTNhsgok58RmI0cFFsT+Ko4MA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792065001; x=1792669801;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y4RE4qn2Tf4xNwGevvOdi1sIXSfmEvtIegvCTHmueDs=;
        b=NsJVV/aHnyUD/SwHtWxaqbgUUt8UEdvoqH9oN1dlbdfOkHOJdAbBd4Xxq0IRk44PSo
         oi78SZ/OhTgBsLus4pCGw+yLInpM1cWjUEs/CA7zFipK8G46WLN5W5/20TMBHc8VS5ig
         VvPPk1rQiIIzFX7hkRa6eQ+48C5QpqiVONQrJ1skHL5QajWfx2Z+jRzfLOFxaeD+COiv
         WLJWlAWaqbl0zBVD+TmHQmYoufqKkY6w7JRXnjA8LUdzN2GJ3d9sDVDwDUwm63OI3kw9
         djcIpPQcL/n1a4tKNLpTHemRfikGHvqg6JtmK1wzRBebtZF6HRw+tq5h9lwl+2k6Eyp7
         Vhog==
X-Forwarded-Encrypted: i=1; AKwUvBzazTfB0VDUZdw9IyH32yaS2kI2a1jBQ1z/ZFjOTsPQVs25ALBaYDGGDVMpZgt5snVOD4JzkfuR07rvgd5d@lists.openembedded.org
X-Gm-Message-State: AFq9FYIiW5D2KJnUgaDlsFQUY0HdGt/VA7IpZqqg9pW+Q5UxGxR1foTt
	eIoFc6tZB4hvsdDE8fPWqVpS61qniqc6SO9lpzAQBYqn5cE6cGoQd4UuQffkDfdnF2I=
X-Gm-Gg: AYBFou03d212UKyeGq1hpAQHvLIsbqe5NhttH90mPlk0gcFiTruc5oDu8i3JtZ77JkF
	EDnqQ7mjs3IfRBGjC7g61xtoDTPBmmxTno1W7pInn07ttbN5u9ohi9aHvbgLME6tr6PuJmxERlA
	uHZEL4MCz7ZdVwj6oKDBohJKF9IVEuc/f4z5Ek88db8es9TG3joNhRy4Q4NzIxQxToiBeP+Lndz
	C04ivAkJqmBGTxt80TWJ+YA7ckj13MBWB7Mwx5Coqvul1Pcf6SzNHNtfOuuxPAPtVhGZ6FzzBnJ
	XSZ6ka+BqESYIwUdOF16iJjoVFXxrWzFcjio6x1Yk4eM4jU2m21CcD1MYwqH7VfHQ2JJRSCF7Tn
	Sv/wRdv0hej4fwdJTranhlEu9x/U9zU8fUslveD5b7WO6rIjS+57N1Qa4F6nlpfJSqBHI5nRtGa
	DzHmdDAf7CsagGxlIjJX4Mab9DyvDlLB77GOzehJTs8iwI88j4yq1PEATAu/GLCwYUZReBN0BjB
	YkCQM641NdKx01THWSnQvPrgPcCXqV7YHY1mDA1EB+4MV8W8A==
X-Received: by 2002:a05:600c:3b8b:b0:4a1:811c:8078 with SMTP id 5b1f17b1804b1-4a18e4a7cfcmr469108035e9.26.1792065001323;
        Thu, 15 Oct 2026 04:50:01 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:8627:1727:8a8a:57f5? ([2001:8b0:aba:5f3c:8627:1727:8a8a:57f5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de7268680sm11005302f8f.25.2026.10.15.04.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 04:50:00 -0700 (PDT)
Message-ID: <6563fc5659f06a1a6b1eb72ec05b9109dfe9f64a.camel@linuxfoundation.org>
Subject: Re: [docs] [bitbake-devel] [PATCH 3/4] knotty: convert warnings to
 errors when -W is passed
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Antonin Godard <antonin.godard@bootlin.com>, 
	bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	docs@lists.yoctoproject.org
Date: Thu, 15 Oct 2026 12:49:59 +0100
In-Reply-To: <DM5C7YSFK5Y8.14E684HX5TS18@bootlin.com>
References: <20261013-warn-as-errors-v1-0-ab3658758ceb@bootlin.com>
	 <20261013-warn-as-errors-v1-3-ab3658758ceb@bootlin.com>
	 <5d6d74ea44bf61549823ccde83e4c4ed1e274dc4.camel@linuxfoundation.org>
	 <DM5C7YSFK5Y8.14E684HX5TS18@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 15 Oct 2026 11:50:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20345

On Thu, 2026-10-15 at 12:25 +0200, Antonin Godard wrote:
> On Thu Oct 15, 2026 at 10:58 AM CEST, Richard Purdie via lists.yoctoproje=
ct.org wrote:
> > On Tue, 2026-10-13 at 14:13 +0200, Antonin Godard via lists.openembedde=
d.org wrote:
> > > When -W is passed, modify the handlers to show warnings in red and se=
t
> > > the return value to 1. Add a summary line informing the user that the=
 -W
> > > option was used as it might not be obvious when looking at the bottom
> > > the end of the console log.
> >=20
> > The trouble is this doesn't make warnings behave exactly as errors and
> > I think that is going to confuse people :/.
> >=20
> > Specifically, if an error is encountered in a task, it will error and
> > fail. The warning will show an error but continue anyway. I also
> > suspect the warnings will still show as warnings in the log files and
> > only appear as errors on the console.
>=20
> Good point. So there's two directions this could take (if we want that fe=
ature):
>=20
> - Make this option change the behavior of warnings, and make them _act_ (=
not
> =C2=A0 just look) like errors, so a given task would stop in case of warn=
ing.
>=20
> - Rename the option and make it clearer: warnings are still warnings but =
the
> =C2=A0 return code will be 1 if there are any.
>=20
> =C2=A0 Maybe "-W,--fail-on-warnings: Make bitbake return 1 if any warning=
 is
> =C2=A0 emitted"?
>=20
> I feel like the second option might be best as the first one is changing =
the
> behavior of tasks and I also think this might not be desirable.
>=20
> With the second option it allows having a positive exit code on warnings =
while
> still being able to have a look at all of them (not only the single one t=
hat
> stopped the build as would happen with the first option), just as you wou=
ld with
> a normal bitbake execution.

I think we need to see if there are others wanting this feature or not.
I think with new option additions like this, we need to see a clear
demand from the userbase for it. That feedback may also make it clearer
which behaviour people would want.

Cheers,

Richard

