Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 359A6C5B549
	for <webhook@archiver.kernel.org>; Fri, 30 May 2025 07:50:44 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web11.1645.1748591437484487451
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 30 May 2025 00:50:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Nr1ZsA/H;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43cfe63c592so19738695e9.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 30 May 2025 00:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1748591436; x=1749196236; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=k47bBjho7vMf39u2fmGFqUEnXjj2zj5xvE7GqWWFt9Y=;
        b=Nr1ZsA/HCzaFweYKKzFta/iLSynOiAI51405ZF00/0iyduzeLuWcfWFpE8dZp/ybGk
         sjOMfnmyIPH/r0wdbZhtW3gX2tEt/DXZ1Pq0OT7WxZUcBdMb4VVB97EeynWOFHYN6TrL
         cKdha28QIO9lYa+WECzWNfmFpEEqryvAx3eaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748591436; x=1749196236;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k47bBjho7vMf39u2fmGFqUEnXjj2zj5xvE7GqWWFt9Y=;
        b=fOPXGmJnUi9xu1i7Znpc4HuUIHL2PF/7C9TXe3mJgIE355ztlkvkE7C+HcxDmIlzhJ
         KFGO7tBjpl4OMato333FepAFM2yy6Gk2Vv8DhiEr/UsYxdGZTCImqk2X7nubNnAsqWAZ
         TLwZ16TSCvNWMoeqA9jLbr4CHT6+gRwf07yPV9JXxlpyGKWJN4IlMekL/lqvES9hPQbk
         7fKZd8m8IytFjjINw65HrPHTzg2pi41Gzlm1JkDmqc9VQEkfU8sU9Oh53Nft1UckDHko
         TsOkQiSA/S5ODc6aHpbW9Nv/sCQMC+0hDadJqEgcF0ZEkuUiE4UyMWwRkbv50+IaQzV9
         9fmQ==
X-Gm-Message-State: AOJu0Yx7ZfUPnXymJcnmqqgHj4h8ONzjuRKzPTgDYRW6K0U/ZIned9gi
	yUtA5A41rkrpy+8ThMHsjbtcDYmYHpJj+xb1crGm3YqXP+owlGq1i5lwk4yNyMMYvg0=
X-Gm-Gg: ASbGncvRvMxMxc/naQiMLnWpj7fIL5ImbaCz739P92PtIyYqWxkEwm7nHVyqL3l/NAU
	TJZdcM6Db1cFuaJ91jbeW97s2gSb4dtTyKp81JpAewcmM5PLWpuR156A9e0kMIPQlntLVX5Mjb2
	AqvX11OYaO0DvfBssq7EgPNf3PNwZ+Wk1iEXDTp8qxiLp9Ii8s+dSGjC2EH73DV5tgSmYmWzR/4
	/Z9wTHUYAoMKp2sghgUIj3KoJ0Ntcf2oNS0R9J/avwWh3PW3FLmM6Dsu5iSB6xPc/N3kkvomemJ
	q3LUfL+96lZLYtsyCN/hMHAc2csDlkR6fcDjP57ad+l8Bqy/VXwKLVUKM2BSOaK1ozCfyZ+NtIy
	EV/8KpM7qjXtbG9g+ahlgJDeuftwGqQj4vIsgLhcuVdtbD2xy
X-Google-Smtp-Source: AGHT+IHnSdbvR3vESxOz6ORYdtx9eJ1Xt3YkVEKnSuRrWsmJtklI1IvQTiG1qG0QVgvBZbElKOm1DA==
X-Received: by 2002:a05:6000:26d0:b0:3a1:fcd6:1e6b with SMTP id ffacd0b85a97d-3a4f7ab15cemr1557744f8f.57.1748591435764;
        Fri, 30 May 2025 00:50:35 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:5d72:4093:f55c:1c6? ([2001:8b0:aba:5f3c:5d72:4093:f55c:1c6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d7fa21e4sm10570085e9.11.2025.05.30.00.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 00:50:34 -0700 (PDT)
Message-ID: <f35ed32c0c6842346b30b4afc32e78ca770c06f6.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH v2] [YOCTO #15882] Add question mark to
 mark the start of the AZ_SAS query parameters.
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: robbinvandamme@gmail.com, Gyorgy Sarvari <skandigraun@gmail.com>
Cc: bitbake-devel@lists.openembedded.org, Robbin Van Damme
	 <robbin.vandamme@renson.be>
Date: Fri, 30 May 2025 08:50:34 +0100
In-Reply-To: <CAPon-EbnAEjXL0AWSthzvdrXrazG0P07ov=6GG70pVdmsC+hmA@mail.gmail.com>
References: <20250529141418.1939172-1-robbin.vandamme@renson.be>
	 <9ae97e78-1fdb-45dd-8746-122f6e5a919f@gmail.com>
	 <CAPon-EbnAEjXL0AWSthzvdrXrazG0P07ov=6GG70pVdmsC+hmA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 30 May 2025 07:50:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17659

On Fri, 2025-05-30 at 09:21 +0200, robbin van damme via
lists.openembedded.org wrote:
> Hi,
>=20
> Ok thats fine.
> Lets forget this patch then.
> I submitted other one with update of the docs on how to use the
> AZ_SAS.

What might also help is adding a sanity check to the fetcher to ensure
the variable does start with "?".

If it does not, we could raise an error so the user knows what is
wrong.

Cheers,

Richard

