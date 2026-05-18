Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA8ACD4F49
	for <webhook@archiver.kernel.org>; Mon, 18 May 2026 14:51:22 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10133.1779115879374175550
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 18 May 2026 07:51:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=nJUiJOTc;
 spf=pass (domain: smile.fr, ip: 209.85.128.48, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so35820705e9.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 18 May 2026 07:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1779115878; x=1779720678; darn=lists.openembedded.org;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FSuw+DAuRyBcKeLTByd7B3n6yEb9EdykXWvLXa5JRkg=;
        b=nJUiJOTc9Is+PxgtBfX6F1EGxwMijIV+G7bCLy4jW0+p4wCEVdVwIuBq3nt9T9G67T
         v5xJA2W9sRlZMlUoVdanQ+fPURHYcykcTerwVbDjbAs9AWgxnfNqFy7h4RpHsljJZtGU
         FPFz2xkv0gP4q1mqq98ZZGSkUW2Hm3yFjnHks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779115878; x=1779720678;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FSuw+DAuRyBcKeLTByd7B3n6yEb9EdykXWvLXa5JRkg=;
        b=SIwyqy60D3eotPnVQnYF6Rkd5OG4R43pbpLg1r9BAwsTS6689N6ymJY3eTEZXEa8s9
         AMmHuspMrzOO3IP4Ltj4h1AUYJcwxt7F3ekNZ8Elfqnpdmm7/a5/kqjYiCpuEaefgFw2
         lagVShpDg4BmTVs6YDa16OgP4JIYpwtoz1VWxg4tKcQFDpgKL31rTW7l5tDuGIoqObno
         xAmc4Le1SvgFRhNkjFKau5n6fUG/3h5DSchAwRCuklpcqWqzquxN8yhAbnK8kXfo6qmX
         z3zcUATAcxxFvFk95CYrYRFvgRJ/vw1ruIkA+5mruoj8zEqCCptL1rsGcWy7p/kHigmN
         9SEA==
X-Forwarded-Encrypted: i=1; AFNElJ9dZ/AM94fkswzLhEzEMa+aMH1S1yjemjjP8KN9dKzVuzIgxsaT/oR1kVOwdOVVOKv+HV435EQbky+Id80C@lists.openembedded.org
X-Gm-Message-State: AOJu0YzxOrF8PpdR7lQh/Z2IvMUcopapPNOtKv1fw0YIlbXmYPINi00a
	/y6HNjQHBb4jeeprqlS1lbao2ifY2RiS57/JQFf3xkQd5jMRC/7V8NJmwsbqHPx+o5Y=
X-Gm-Gg: Acq92OGEh3dL9IzzlTuaR4GIYm4pLXw2v91SE0KoP/wRIXmIRqLZ+FJIRlj//9Y3cOb
	Za31T/xUuRMroMhKTOV4G0HRQEtMXWsE9Xk6ZLlwtpfaAM2De3y18uCo2K6QaZLjTHq/RGuWvLV
	QIPdSnkXf41dpknoAgyFYl5aTH14AVzOr+4YXPRnbD2l+Ynk5mwwHAUqnfBQhtuJA/irdFRmQIX
	X1mtY3hBN2nFj1uxSK0vd566hQPeel4Ri61+7bJvZro72Ry5tTHPWkh5Jz3MANx+wyCSeykHRv3
	6Q2TPU/SWRhekYJZK5FI5OL1CEMvrFxcCMQcg11kaAcuUdI1Wt+z8f6cuvFWF1mrtcCnRAthii2
	2Uw5YpwyYN5nD2PDvaMzQ/j3j9j3GPDCRu9v68KyrjLAc1sH0px9KFnuHzdWSxYwL3AV3PfMF1k
	LtBQVQdjk78ZJb1/LVC+n09YyuNOIQS/wamWth+hG12aYAj7MZhr1Uk7uZjbd8d5oezvghWByHk
	BOuTfuaurQ=
X-Received: by 2002:a05:600c:c0db:b0:48e:8499:4be0 with SMTP id 5b1f17b1804b1-48fe60ee481mr175717985e9.15.1779115877629;
        Mon, 18 May 2026 07:51:17 -0700 (PDT)
Received: from localhost (static-css-ccs-204145.business.bouyguestelecom.com. [176.157.204.145])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48feaf0fb46sm84820175e9.11.2026.05.18.07.51.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 07:51:17 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 18 May 2026 16:51:16 +0200
Message-Id: <DILVXYLZNSFQ.F22AETY6RSWE@smile.fr>
Subject: Re: [bitbake][wrynose][2.18][PATCH 0/3] Pull request (cover letter
 only)
From: "Yoann Congal" <yoann.congal@smile.fr>
To: "Richard Purdie" <richard.purdie@linuxfoundation.org>,
 <bitbake-devel@lists.openembedded.org>
X-Mailer: aerc 0.20.0
References: <cover.1778576715.git.yoann.congal@smile.fr>
 <4d3807d067376d11bd13b5ccd1abf28f77c13ce0.camel@linuxfoundation.org>
In-Reply-To: <4d3807d067376d11bd13b5ccd1abf28f77c13ce0.camel@linuxfoundation.org>
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 18 May 2026 14:51:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19538

On Wed May 13, 2026 at 11:21 AM CEST, Richard Purdie wrote:
> On Tue, 2026-05-12 at 11:07 +0200, Yoann Congal wrote:
>> Those are the patches from the last patch review:
>> https://lore.kernel.org/bitbake-devel/cover.1778197991.git.yoann.congal@=
smile.fr/T/#t
>>=20
>> Passed a-full on autobuilder with 3 AB-INT issues:
>> https://autobuilder.yoctoproject.org/valkyrie/#/builders/29/builds/3795
>> * qemuarm-tc: 15698 =E2=80=93 AB-INT: runqemu.QemuTest.test_qemu_can_shu=
tdown hangs with "Data received serial thread"
>> =C2=A0 Retried in https://autobuilder.yoctoproject.org/valkyrie/#/builde=
rs/42/builds/3689
>> * qemuriscv64-ptest: https://autobuilder.yoctoproject.org/valkyrie/#/bui=
lders/56/builds/1562
>> =C2=A0 This is a ptest failure in procps: 'pgrep_match_against_full_proc=
ess_name'
>> =C2=A0 This particular ptest later passed in https://autobuilder.yoctopr=
oject.org/valkyrie/#/builders/56/builds/1564
>> =C2=A0 (I have yet to properly report this one)
>> * qemuarmv5: 16217 =E2=80=93 AB-INT: boot hang in qemu (amba chip errors=
?)
>> =C2=A0 Retried in https://autobuilder.yoctoproject.org/valkyrie/#/builde=
rs/80/builds/3559
>>=20
>> The following changes since commit a2dd9be788274d9c7280be5b1be5eb5c3990c=
f54:
>>=20
>> =C2=A0 fetch2/crate: use CDN endpoint for version checking if possible (=
2026-04-30 10:08:54 +0100)
>>=20
>> are available in the Git repository at:
>>=20
>> =C2=A0 https://git.openembedded.org/bitbake-contrib=C2=A0stable/2.18-nex=
t
>> =C2=A0 https://git.openembedded.org/bitbake-contrib/log/?h=3Dstable/2.18=
-next
>>=20
>> for you to fetch changes up to 87dcc2935137558ac236676ab7bcbc3cc4883c2c:
>>=20
>> =C2=A0 lib: Replace codegen with ast.unparse() (2026-05-05 17:36:57 +020=
0)
>>=20
>> ----------------------------------------------------------------
>>=20
>> Alexander Kanavin (1):
>> =C2=A0 fetch/wget: in upstream version checks, match versioned directori=
es
>> =C2=A0=C2=A0=C2=A0 exactly
>>=20
>> Paul Barker (1):
>> =C2=A0 doc: Fix description of git shallow mirror tarball creation
>>=20
>> Richard Purdie (1):
>> =C2=A0 lib: Replace codegen with ast.unparse()
>
> This breaks the hashequiv docker file so we may want to hold off on
> this until we have the other fixes in master?
>
> I'm a little torn on backporting it. Yes, it is a nice cleanup but it
> does introduce risk, as that other issue shows. It is all relatively
> minor but...

Let's drop it. I was a little too enthusiastic with my backport
requests. I'll go back to being more conservative.

Regards,

>
> Cheers,
>
> Richard


--=20
Yoann Congal
Smile ECS


