Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 728A8C54E90
	for <webhook@archiver.kernel.org>; Wed, 21 May 2025 10:22:47 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web10.7819.1747822960870328826
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 21 May 2025 03:22:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=KHV7fFKK;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43cf257158fso49742525e9.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 21 May 2025 03:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1747822959; x=1748427759; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fr0qgxFtgANCgJz6YuSJ5X2seDhaVg65bi9vHc4T0yA=;
        b=KHV7fFKKH8ximDyc1uCttbfOWfj85dvtClTbJis0FpTZOS8Jf71aEg0PIe2FjPIsqw
         3z8F6TekuCvqpTlnNCH1mbduzo0cwEvJH3Dj5JPWPOkNRuw3lwtWMEXqv8xEEFRfmPyh
         H/DgqXvpn5CMwU0cEpVgOuqr+M+4IrIFjZ9To=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747822959; x=1748427759;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fr0qgxFtgANCgJz6YuSJ5X2seDhaVg65bi9vHc4T0yA=;
        b=J7N5UX/74s60ohiUUuCsP4AYs++12i6sQfuK1v9VALD4a7Ki3YvAjXlicuOzqCGhSx
         ZSLE29inBCzs23y80S+GuBuF6Ji48HU8G7ZAVc9e7NHcc1Y17X1grpfKWWJtKtaq97T7
         RD/fFoQVt6L7WGHx9Sh6CfXeI4JbXvwYhmczYDwVoLVMGSgWPyyK6M5kn5IFZabfJdHN
         9TUCbSidGYcrj159WurcS4BA1DOFqP+5PaHj+09qTWNQABlMAzEwR51usa3i23zsZcQp
         7RbqN24/yKzh8/T5JvFuO0729OWJSFCeyoYBVBGMf/u1tApidgBbJVdrzN7s5L14T9ap
         /dIg==
X-Forwarded-Encrypted: i=1; AJvYcCUm44qQwdUQ1HNphIQH0NQA4zwRpqZHSeRT8Lwiq63NCuXkp+IpVp0bxwt8UpMXJqsut7yczRfIPFNyZSHI@lists.openembedded.org
X-Gm-Message-State: AOJu0YyGKyOW5Z8PxXC3jOdwHgWHJhU7orj5p4pE3LgxepTGrbB8G6h0
	CYqvdEC2Dr25kDvHMm1uFYHLU/g7VqxJE/4b49taApvW9iur0nxFLFQT7LoGRUJMxfo=
X-Gm-Gg: ASbGncvLXOhrFhElPg+KxrCa6K0dZmAK4DIZXQQS1ur3W0NflV5/X6N1heWYPCOYBId
	mLVajg/o+j+OsUW156XZ7E5FGHx2o6qgBchNUMiyhuUjCthFZjC2VZ35j8U7Ev2VB0nuUYZE6js
	FRH1s2+3C7c8lcttfLkJpcpozWwiPm5Mip6t1/m86J9LOc9F0oaC7ZLHDDxus7DNeW68tnY/6nc
	NCeti7RqYY70+y+HJSAKDT8XUSMyg0R6m0Sf9WS7UY/SNmF5tnZL3MS8c5E8ePHQf/velxY7Bxi
	G1JzdZ5UiZ7WiF9xWqgqK7dwzEXMkXN9BqtWeXYxZjljeu4poXjP8Vbb42MvPPAnb9e3WBYlnRl
	LFNUOPI512PGLs/6Xavkc/Bx1eY7oGeVhc6j+VN47
X-Google-Smtp-Source: AGHT+IH5fRtbxG5qDmROjyHBC+8DxQMjfIdy5IWHw3YMo13usNlX0NmGheRU8PuIsSjQO1FmvPo4Tg==
X-Received: by 2002:a05:600c:c059:10b0:43c:f6c6:578c with SMTP id 5b1f17b1804b1-442ff571262mr123818355e9.15.1747822958568;
        Wed, 21 May 2025 03:22:38 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:b5da:39cf:fb42:2a73? ([2001:8b0:aba:5f3c:b5da:39cf:fb42:2a73])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f78aef8asm65916035e9.29.2025.05.21.03.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 03:22:37 -0700 (PDT)
Message-ID: <e8c25ab66dd3f0c393c727b6eacc1301f51e23df.camel@linuxfoundation.org>
Subject: Re: [PATCH 1/1] fetch2: Ensure a valid symlink in `PREMIRRORS` case
 when using shallow cloning
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Stefan Koch <stefan-koch@siemens.com>, 
	bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org, liezhi.yang@windriver.com, 
	niqingliang2003@gmail.com, alex.kanavin@gmail.com,
 quentin.schulz@cherry.de, 	simon.sudler@siemens.com, jan.kiszka@siemens.com
Date: Wed, 21 May 2025 11:22:36 +0100
In-Reply-To: <20250521091153.2445853-2-stefan-koch@siemens.com>
References: <20250521091153.2445853-1-stefan-koch@siemens.com>
	 <20250521091153.2445853-2-stefan-koch@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 21 May 2025 10:22:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17625

On Wed, 2025-05-21 at 11:11 +0200, Stefan Koch wrote:
> - Since `ud.path` contains in that case the `PREMIRRORS` prefix path,
> =C2=A0 this change ensures that a correct symlink is set up.
>=20
> Signed-off-by: Stefan Koch <stefan-koch@siemens.com>
> ---
> =C2=A0lib/bb/fetch2/__init__.py | 5 +++++
> =C2=A01 file changed, 5 insertions(+)
>=20
> diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> index 2de4f4f8c..7459adb00 100644
> --- a/lib/bb/fetch2/__init__.py
> +++ b/lib/bb/fetch2/__init__.py
> @@ -1117,7 +1117,12 @@ def try_mirror_url(fetch, origud, ud, ld,
> check =3D False):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 origud.method.build_mirror=
_data(origud, ld)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
return origud.localpath
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Otherwise the result i=
s a local file:// and we symlink to
> it
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # This could also be a link t=
o a shallow archive
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ensure_symlink(ud.localp=
ath, origud.localpath)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # When using shallow mode, ad=
d a symlink to the original
> fullshallow
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # path to ensure a valid syml=
ink even in the `PREMIRRORS`
> case
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ud.shallow and not os.path=
.exists(origud.fullshallow):
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ensur=
e_symlink(ud.localpath, origud.fullshallow)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 update_stamp(origud, ld)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ud.localpath

FWIW this looks/sounds like the right fix to me. Is there a test case
we should add?

Cheers,

Richard

