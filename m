Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 750E3C19F32
	for <webhook@archiver.kernel.org>; Sun,  2 Mar 2025 08:21:36 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web11.27112.1740903677502388469
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 02 Mar 2025 00:21:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=CLnwcNqc;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43bbd711eedso992975e9.3
        for <bitbake-devel@lists.openembedded.org>; Sun, 02 Mar 2025 00:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1740903676; x=1741508476; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xbt4/nJQQPrq6muTlf652pOhp0PQtKyYLjC1LLo6j7U=;
        b=CLnwcNqcqD1Uu0mACCg7HZ8pXWCGVdFu02Cv5tyJRDtJ47uNRqzY18m0okfJeRCtmr
         nMeQR+MjF7Q+8nPNCmfmtJxxAUXwd9fuDzqVcdI51CwXa9lruB4W0fOizAKsskfeZrL/
         hok0eozBSGAjyI6kIuFI/bq4xpPBS4Dv3Mk1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740903676; x=1741508476;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xbt4/nJQQPrq6muTlf652pOhp0PQtKyYLjC1LLo6j7U=;
        b=Jb5umJYqBCVm853/QXjWYh3izS9ojSrxeFsWXRLbXfbDj7q7qf85N8kLDczFjuDK72
         K08zmEdVwDPs788zV4sI1JxU5YIpFdvDwIz8fow9mne6g9Lc6nLav1DPv2ylSYqliZKz
         NLdMObeZH5HGPYW0zAzSdy2AttvfESylLulpgdqg49TvhvWVDsZ41mT9Ix8u9x5fAaFN
         JaRAbvLNQojg+6U8j2Rsxq+tpLaf9E4ucTZw40p8kdgZU0rOi88bUgle1hzLuqTEKwwX
         K1gOT+XbQ1RQBpy6KVQ8veJAPBhMEFPEESWsFbdrb2geP0groVJsTbf5xhvYt8PJSZnf
         EPcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgrb/JFfgB7nWt7/AiDb0L8PfIk8fozJREo5ExD72S+gBuWwL0X7JdjHQZu2zylxGXpf9+FWJpeIiVNyR3@lists.openembedded.org
X-Gm-Message-State: AOJu0Yw5kerNGmDNfu15LjcLtveIHJf2Ay4AMEATUusjZyiE0yEU8BYT
	8zByCWA02y3JLxSc86sqlVfnEhPM5FTp8O08UzfiiPTVRGS+4fft4vhJ/XPqgZE=
X-Gm-Gg: ASbGncvqKTmsyxEfVrcF5y8ZEQgLtVSGJFkUknAYhOVyE5rnZ9c0eidqj3GgY1wXsA1
	ng5U6fw5OdvLGoY5wbZwicCfy0BsvoYPpYUPTeFNIV7+H1qW3fNdTtqzL0qHFVElUa77fnCG8Dj
	7XxO6PXvj+3W96ike2tRWQluWfA3ML2BqA9PAxJ59VeO1jRZP+faMApHCjPx7suKKlEymMIGeOU
	XH5YQsJyjoEdrTl4PiB2CseBWkM+TRSmgvEOaFyIiWQSrYvdgH8Fs6jYRWBDs0tEXdqmMFICwYf
	YGb+SIzLOQyKXAY7naz4+/HBZmu42fbdk3KJM66F22D1NM2iFcphItDYhlhrDOB5Cgibcjj/q61
	+GlFJ+Fmh20f0nc7eWiIZpleE4j498wQ=
X-Google-Smtp-Source: AGHT+IG7mmb1lQJiEStMsWmKXPsMlt3uuyw8bF43bOgiCk50wtP/KGRMn4uAH6Ztj56wOcZGgz7n1g==
X-Received: by 2002:a05:600c:45d4:b0:439:6118:c188 with SMTP id 5b1f17b1804b1-43ba6727cc1mr72553595e9.19.1740903675758;
        Sun, 02 Mar 2025 00:21:15 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:e0f8:a3b1:7fc:a90a? ([2001:8b0:aba:5f3c:e0f8:a3b1:7fc:a90a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ab2c4051bsm131168275e9.0.2025.03.02.00.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 00:21:14 -0800 (PST)
Message-ID: <1c96848ad5c824eb3188d0baa65a6e32f1e629db.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 1/2] fetch2: Revert decodeurl() to not
 use the URI class
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: peter.kjellerstedt@axis.com, bitbake-devel@lists.openembedded.org
Date: Sun, 02 Mar 2025 08:21:12 +0000
In-Reply-To: <20250228231501.3905069-1-pkj@axis.com>
References: <20250228231501.3905069-1-pkj@axis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 02 Mar 2025 08:21:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17366

On Sat, 2025-03-01 at 00:15 +0100, Peter Kjellerstedt via lists.openembedde=
d.org wrote:
> This reverts the recent change of decodeurl() to use the URI class to
> parse the URL instead of doing it itself. While reusing code is
> generally a good idea, using urllib.parse.urlparse() (which the URI
> class does) to parse the regular expression "URLs" that are used in
> PREMIRRORS and MIRRORS does not work. A regular expression URL
> containing https?://... would be silently ignored, while a URL using a
> negative lookahead such as git://(?!internal\.git\.server).*/.* would
> result in a cryptic error:
>=20
> =C2=A0 Exception: re.error: missing ), unterminated subpattern at positio=
n 0
>=20
> The problem is that urllib.parse.urlparse() treats the ? as the start of
> URL parameters and thus stops parsing whatever part of the URL it was
> parsing.
>=20
> Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
> ---
> =C2=A0bitbake/lib/bb/fetch2/__init__.py | 46 ++++++++++++++++++++++++++++=
+--
> =C2=A01 file changed, 43 insertions(+), 3 deletions(-)

I'm forever coming under pressure to take a patch like the one this
reverts, it is the first thing most people new to the fetcher dislike.
I can understand why.

I wonder if we should restore the function but only use it for parsing
mirror urls, and comment it accordingly?

Cheers,

Richard

