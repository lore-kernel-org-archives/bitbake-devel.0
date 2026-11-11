Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12428.1794412105715750261
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 11 Nov 2026 07:48:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=Ey/iPS0W;
 spf=pass (domain: gmail.com, ip: 209.85.219.48, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-91ec14f4369so33333956d6.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 11 Nov 2026 07:48:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794412104; cv=none;
        d=google.com; s=arc-20260327;
        b=NMMkKprABgViOIKmUI0/kkag+x/xUGBLA1dmdY7Hkabr8ZJDkB/4XXRBKCG1Hn/Tgb
         HynUHSdyTmlKhUC0IzejOF2c6jXHsK9vWkadTTFLmBULfysGSZGEHeXyetcVEZ3TzM0X
         6uJxDmK2XZ/QHsmJLHQ94Ty8bIDdPKsoMgNOsZINdAksAXVG9VIZ7812xGqwHCh4Hk+h
         ry1ABHlJvmOHTJI7n/uiMVXlaIHZt/30GzkiYVx8rpx9APddivZMsx9AB36Lps/PuLUQ
         M766pbm0teAFlIKdeshXjQO+8luB0f0FE6a4xB2we2m/Lt1TC4t6oUCqUNpoK44LXdGW
         W47A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=stdbTFOV/iX5ryJzZ3U2XI6YsLhUtidU9sqwTAadjf0=;
        fh=dnpgaoOQN5yAxsI8UoO0s0jHAqVANWXSt/C16lFMUFU=;
        b=kWixZF2F+AaehoSldj88Ixo1fcZSdIfnBHn4L7jdgiI81sRNwiYy82gae4W5mOGL61
         v/KkIyC96Fur+nrhf6XSivdCJbGIY7ugdIa09wwWFo09R47lE197i/NWgIKdr2e1Dt7m
         BUUThRDfaY9AlCvFAmyKDrzMiMcssTSanovej7+J24xlYm2UoStMXz0jRnbVuvXQfsCZ
         HGiOnfQuhuGRUobYIjFQ1EgxLBQf9YbV1W4bBEh7qxRgJl0wuA2fwpUjRziyDmgp/hhR
         LCXLvhJqSJ7slUhpNPU1cqldK+eHHH+jYVOWt9n4VZlpCrn4sK3/7lpbWE9MoF6WSDKx
         ilUQ==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794412104; x=1795016904; darn=lists.openembedded.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=stdbTFOV/iX5ryJzZ3U2XI6YsLhUtidU9sqwTAadjf0=;
        b=Ey/iPS0Wp+We3zOBPTIhfvI+3uEKcTSVNUrf5AjmugYz1+dt07oIzU29SHQVXCCkAV
         gQaUOZZAFYFvftqB+lssR3Zx2+w6jSCxHHecniio2c7Mv3Fp+CPgc7p/btS18DRhoV4B
         3DukKgJm3jvmrD/pX1A/KR/L9dnh0V9MbtjGTMQ35rrvOh24DCS6niriaYJyRdxSzcay
         co+qfF0/9hlNY/66OBn/+QxjUAXys8pcExFw6au0FjvkeBQh/1UOsxARgxNq6P2Ti2XX
         1NllDgEfETLwd+xIdZGmx1r+yHsl9NKTh7DBSVw0agw3ENXEZ50eISOG3N+DWx3Zc2lE
         pmxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794412104; x=1795016904;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=stdbTFOV/iX5ryJzZ3U2XI6YsLhUtidU9sqwTAadjf0=;
        b=cJ3kAxBk02ZRZZTdwjRO9Ln7wLCHbWtUBWD5tlc9FLWVgHHZOt4PwfFBkZtcKPUND7
         KNqmOym/wKfM//7SDv6jRWB1tAinbwZlLVHnnMsmJ/yNlkEnxQbWHkJkQLQIG2Q4OKXk
         CUMbapaDU308SPdVA16m43rrtHcbnaBDVe4Y1xWPyKxINnDlZnIr0TzQZsAuKnF4Gj99
         FJz7n6Kj7hCtq2lT2ztBwcsyfp74pFVmZInq3HUguRUzOZDLz9qXWA4kwiK/Xw6868/h
         yEEoC7uEIlHWaULBlXOwijSaW1tRE8LKu8fHwpT3G6h721ymDA0XbV9PM2o+bQPV/d8k
         CRCg==
X-Forwarded-Encrypted: i=1; AL+hErEVwNPRtJSyL1BiQQEr/QWpKP0orSkroIX2b798YO2Bkx+/pLSTuWH6f0Vv7giNqBhD33VntIk6ABLE1sq6@lists.openembedded.org
X-Gm-Message-State: APuU4Z+aP3objW0nSX/ovOWlmxAwSx3hQlnDqXDyzAmKWzwXLcAJQQzh
	JY5kwrCMwxIn7Y7ugwmT5/O2LcqjQewshkx2BQnybbCyGFvgAyTwtTAC7KHaLncyYI9rkPSb54P
	g/s39sVjXzwuN8NPowyGMCzzXhXbxYLE=
X-Gm-Gg: AYBFou0l+2jJm+kV4ihNMNECWr/ugEN4NbUHeSuEAlg0fy5FDpmxmWVSEabPpJzxb3J
	hlveBCv6u/EK0Xu9xrfsyn2iW5hoEZz4tdBlqU3T2Itri9sFKQXhO0KhEU7gMFEqs2nrnLaLrrr
	ddVZZJV+Ysik8W8g9CefWe2eC/6DlI66JfKFiykBJluA9aDA7VlNc1Zc6dENLtETx87t3COlNbl
	Ecf4DldKxN7CBJyt1zsyt3NUO1mezq8yhlZ1oMtT5mYJTuBiNvpGH1qqOpKqh1buYieEodEW+8T
	PDaZsSIqb4skdRzpOLkoT7AOsW65bDUs6OS59TUQVrv6WMJlsR4laUw8hgYvyTNiex+NQ0dcqIg
	VooGUuqJFN+lNlakRQntQSUggOEnsjR3TOiMUhNpxXmreIOmzY4YM31N/FBOPwEuhr5E1tAldht
	q95zPKjwUH8o9lSs9r
X-Received: by 2002:a05:6214:1c0f:b0:91c:5f4b:d2d7 with SMTP id
 6a1803df08f44-91f04183928mr47317466d6.47.1794412104477; Wed, 11 Nov 2026
 07:48:24 -0800 (PST)
MIME-Version: 1.0
References: <87910dcc110b0e4cc397d9f57d9b37824c6859f2.camel@linuxfoundation.org>
 <20261110215935.107339-1-stondo@gmail.com>
In-Reply-To: <20261110215935.107339-1-stondo@gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 11 Nov 2026 16:48:11 +0100
X-Gm-Features: AclHuK8AJ03S-VkFdvhA8ut4S0aFrFDxxuxn4EFVw1cfTwe2TyVQREMPxbRl3BA
Message-ID: <CANNYZj_rf==FyKuRF85F=6f33OC89L=mA_NoGjjthYRT+mG78Q@mail.gmail.com>
Subject: Re: [RFC] spdx30: name, version and purl for dependency downloads
To: Stefano Tondo <stondo@gmail.com>
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>, stefano.tondo.ext@siemens.com, 
	openembedded-core@lists.openembedded.org, 
	bitbake-devel@lists.openembedded.org, Joshua Watt <JPEWhacker@gmail.com>, 
	Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>, 
	Peter Marko <peter.marko@siemens.com>, Adrian Freihofer <adrian.freihofer@siemens.com>, 
	Patrick Wicki <patrick.wicki@siemens.com>
Content-Type: multipart/alternative; boundary="0000000000001175a30660022039"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Wed, 11 Nov 2026 15:48:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20418

--0000000000001175a30660022039
Content-Type: text/plain; charset="UTF-8"

On Tue, 10 Nov 2026 at 22:59, Stefano Tondo <stondo@gmail.com> wrote:

> I agree, and I would like to help with npm. My idea is to follow
> cargo-update-recipe-crates and go-mod-update-modules: an update class
> writes one SRC_URI entry with a checksum for each package in the
> shrinkwrap file. Then bitbake checks that the list matches the
> shrinkwrap file, as you said in your reply. Is
> that what you have in mind? If yes, I can prepare patches.
>

More or less yes. Please write tests together with any new code; ideally it
should be possible to use and test npm fetcher without npm executable, same
as cargo fetcher doesn't need cargo executable.

Alex

--0000000000001175a30660022039
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote gmail_quote_container"><div dir=
=3D"ltr" class=3D"gmail_attr">On Tue, 10 Nov 2026 at 22:59, Stefano Tondo &=
lt;<a href=3D"mailto:stondo@gmail.com">stondo@gmail.com</a>&gt; wrote:<br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">I agree, and I would=
 like to help with npm. My idea is to follow<br>
cargo-update-recipe-crates and go-mod-update-modules: an update class<br>
writes one SRC_URI entry with a checksum for each package in the<br>
shrinkwrap file. Then bitbake checks that the list matches the<br>
shrinkwrap file, as you said in your reply. Is<br>
that what you have in mind? If yes, I can prepare patches.<br></blockquote>=
<div><br></div><div>More or less yes. Please write tests together with any =
new code; ideally it should be possible to use and test npm fetcher without=
 npm executable, same as cargo fetcher doesn&#39;t need cargo executable.</=
div><div><br></div><div>Alex</div><br></div></div>

--0000000000001175a30660022039--
