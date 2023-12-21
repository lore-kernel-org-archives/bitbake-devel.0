Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1168C35274
	for <webhook@archiver.kernel.org>; Thu, 21 Dec 2023 09:56:18 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web11.48056.1703152572972984556
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 21 Dec 2023 01:56:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=f9gzUL06;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.51, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33674f60184so578790f8f.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 21 Dec 2023 01:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1703152571; x=1703757371; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q307YL+rt+zqixHSE30UCqDa2yVrrmdUvlSjmKUJh7Y=;
        b=f9gzUL0696poyAL7RZ4mXDY+fgBO+CQp/WCsyqpKvTZzs9NWmh8ERofADHwpLG0VWp
         twILLFD/IRWUPxwwkvLtQZBEpOXR3yTZQ4Ip6B2wOJVKj3159Cz0DGcj6UkYodvNgkD4
         NnzwJH7HN3e3LIq5I1hPJFon92mhfZYE0I3f4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703152571; x=1703757371;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q307YL+rt+zqixHSE30UCqDa2yVrrmdUvlSjmKUJh7Y=;
        b=a9A5QQckxe+FjZKqgGDmu5s4Bss5IclcNIqjAUOv8pgVvCRFq/tC7pskhRTBrVHEy1
         PQCD/DiIcZYjBR1mSqq4tERFfzBuNJRisNGPb3PyIpR9o7yMJfgwDit6ugpekn16ZJMU
         T/zz4My+ELhiTN+KQxWOj6C+8PBdFAQ0Fo6/umzIysQrhoiLda2lzYr6Fr0N9vI0F2mG
         5/oaofqG665OoQhKWJBQYNTf02+bT1rNkBKTHf9CMBomq3RoDlbBQQxrG/sighva3rVO
         SaonPGfUZ0hboKKVHWPnsF5rfovudO66JgOF1ODirf4LNnEsnWm5BU2Ahxsz5b7xVeW7
         zbLA==
X-Gm-Message-State: AOJu0Yy+rbkQVlWBbAlvkJNNXr8Z5EHaAo3x0I7rfqcETG04vspNQGwx
	ABzeeB8jRfEmYSStY9fnkTLQ1A==
X-Google-Smtp-Source: AGHT+IH5Qc5jMZM6O+q2oiXGpMiQq/Khqez3omHTiF9z0RP5yiZyPPGeRh35E5NF3StSNbqt7S4ATg==
X-Received: by 2002:a5d:44c2:0:b0:336:7518:a74 with SMTP id z2-20020a5d44c2000000b0033675180a74mr552414wrr.2.1703152571196;
        Thu, 21 Dec 2023 01:56:11 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:916f:409d:c5db:4918? ([2001:8b0:aba:5f3c:916f:409d:c5db:4918])
        by smtp.gmail.com with ESMTPSA id r16-20020adfe690000000b00336757c93c9sm1634906wrm.48.2023.12.21.01.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 01:56:10 -0800 (PST)
Message-ID: <634a0dfe7e95fb8c33f0557b4f6ea3eca19f65e7.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 1/1] bitbake: event: Improve error
 message for eventhandler
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: liezhi.yang@windriver.com, bitbake-devel@lists.openembedded.org
Date: Thu, 21 Dec 2023 09:56:10 +0000
In-Reply-To: <2fd4acbc082469c6c665dc5499ea471d9223b42c.1703133461.git.liezhi.yang@windriver.com>
References: <cover.1703133461.git.liezhi.yang@windriver.com>
	 <2fd4acbc082469c6c665dc5499ea471d9223b42c.1703133461.git.liezhi.yang@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 21 Dec 2023 09:56:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15699

On Wed, 2023-12-20 at 20:40 -0800, Robert Yang via lists.openembedded.org w=
rote:
> From: Robert Yang <liezhi.yang@windriver.com>
>=20
> * Before the erorr message was:
> ERROR: Unable to register event handler 'defaultbase_eventhandler':
>   File "/path/to/poky/meta/classes-global/base.bbclass", line 4
>     # SPDX-License-Identifier: MIT
>            ^^^^^
> SyntaxError: invalid syntax
>=20
> This is hard to debug since the error line number 4 is incorrect, and not=
hing
> is wrong with the code in line 4.
>=20
> * Now the error message is:
> ERROR: Unable to register event handler '/path/to/poky/meta/classes-globa=
l/base.bbclass':
>   File "defaultbase_eventhandler", line 4
>     an error line
>        ^^^^^
> SyntaxError: invalid syntax
>=20
> This is much easier to debug.
>=20
> The filename and code doesn't match since the file usually contains more =
code
> than eventhandler, don't pass filename to compile() can fix the problem.
>=20

Sorry, but I really don't like this change. It is now giving a filename
as an event handler and an event handler name=C2=A0as a file. To some, that
is going to be even more confusing.

What really needs to happen here is that the line number needs to be
fixed with the offset in the file. You'll see the code already does:

ast.increment_lineno(code, lineno-1)

so before printing the traceback, the code probably needs to account
for that offset in the in the exception handling too.

Cheers,

Richard


