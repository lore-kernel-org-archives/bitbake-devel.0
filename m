Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B77CF649D
	for <webhook@archiver.kernel.org>; Thu, 20 Nov 2025 00:22:32 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.21780.1763598144825623320
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 19 Nov 2025 16:22:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Pvrl+8W2;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.51, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47755a7652eso2027265e9.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 19 Nov 2025 16:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1763598143; x=1764202943; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IisqoaaHwpYBnvnTjUzRc1W5oiB56nvMVjFunnp0vwY=;
        b=Pvrl+8W2cIXJZn1bokXEzz4ab9B9NlzJ9AA9M7Lpi6JUAZfbomY+AGXOKsgJTauBcI
         rZglWlxJbV/abSqR0ofBBfEjPklW7G4Zk9ZrKVSvrShWCV+gKsBCOk3ldaiKfIpd4J//
         DzyUe24UEG2KWs3KHMHuuyPcoKPwnK9XIRVDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763598143; x=1764202943;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IisqoaaHwpYBnvnTjUzRc1W5oiB56nvMVjFunnp0vwY=;
        b=bzBW8BGlqurmDetCejB2ZAsSswTbNRWmUUEFfp8eLuIe31oaOvZ26m7UoibIsP3Vr0
         ldSlAbyI8R80SKQvOnWHvBhhILQuy15S7srXCjfRhtK4Y9Y7xHRwF5O4X1Q0GFxYfnmW
         NL+xwgYpqO9PU7A+vS8+A/wwo7EeBH+WipwnUjli/fRxkiaXFOTV6IU9wRhv7SjvWZIW
         5JiRHjgTiQCTL9M3IO8zQu0cpl0NpNl+XkUKfwdp++kbuYqhF+yEb0VLmQQPw4SBV14p
         VkZp8waxcq6HrEiuyvwfbIlkYh/w3lk39vKzNMC2YQ94kuIYqsqIZTIFeru6NBNWoeqW
         8xvw==
X-Forwarded-Encrypted: i=1; AJvYcCUl6uegHPzxdlDUGpeNP+ukeVVo9mKmkKBZiZuPqTDOcC68GmngyUHHyh/OXWZRJtwMwlDxaqolBwaQncfT@lists.openembedded.org
X-Gm-Message-State: AOJu0YxLqkA58RvQ4SnwX3XzxhulqNSdMw1SpF9PfWlKfJvOuBGRADRp
	oDmDqAY5NQI2flFVlCShXMlouaLgh9jjfsGcr9ewdtv59z1grUFJ1L8e5LFn4yvXj04=
X-Gm-Gg: ASbGncvvPeSHeDAQOlQi17wyHXs38EQg4wf9buDErb5ezWuE1nMM1x+BukjqKl68z1p
	H7UP0rkV1kCFM1Fez1xwxn4rlYY7dzcO1T6f2eHILgGqfvi6KGVBdugg2/8Wta/D/k1W9/kOkLt
	TkXr53Kq4EAHSNp6onqPFc2VLPoc4E7s6G5DI4RyMOFd4BbAKusGaszfqN5wSyQr/hNJRzDdznl
	zI4w8w55aQlFXg/J1XEYtlG17tmbNOp7Kxq6uyqQSq9Qwa2I5dkwsDMs+LZDNs0y7Paufr3Hqly
	fDqrPDQf77phqJlSIHPDhieNrsK+ykCgHEkN6fDZ6hdSMW5p8WeIjwjDxQ45ZSAnrn37dybp/N1
	A31wJdmWcJALhOyV3HFYxMZ3gmXKNn9g0ZcExFuS59cSYyLZwNJ5ZVDBbdzqmE4VGpiVY1zNZKZ
	JQvjxHiqG27Uj+dFJBeyqLrDuxCQ2ND4DoeKznKuTuRNaRIYE7YB0PQE/FQ6EGf9PAxrZfo9u7
X-Google-Smtp-Source: AGHT+IEvePQ+vdh1da1X5oR9i9sBfl1TPCZHl918S+uqWlRhxL5wdHMgdYDDq7kw6W3TONLioyrrQQ==
X-Received: by 2002:a05:600c:6008:b0:477:6d96:b3e5 with SMTP id 5b1f17b1804b1-477b9083613mr5999275e9.7.1763598142890;
        Wed, 19 Nov 2025 16:22:22 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:bcb9:ef4:6cdc:29d7? ([2001:8b0:aba:5f3c:bcb9:ef4:6cdc:29d7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fd9061sm1968397f8f.41.2025.11.19.16.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 16:22:21 -0800 (PST)
Message-ID: <ccf1083effb1ace096439c3acee7b867c88cad0b.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel][PATCH V3 1/2] bitbake: add SKIP_FRAGMENTS
 CookerFeature
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Qi.Chen@windriver.com, bitbake-devel@lists.openembedded.org
Cc: alex.kanavin@gmail.com
Date: Thu, 20 Nov 2025 00:22:20 +0000
In-Reply-To: <20251119090045.107642-1-Qi.Chen@windriver.com>
References: <20251119090045.107642-1-Qi.Chen@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 20 Nov 2025 00:22:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18464

On Wed, 2025-11-19 at 17:00 +0800, Qi.Chen@windriver.com wrote:
> From: Chen Qi <Qi.Chen@windriver.com>
>=20
> This patch add a new CookerFeature, SKIP_FRAGMENTS, which when enabled
> will skip fragments parsing.
>=20
> This feature is mainly used by bitbake-config-build. It's a tool to
> manage fragements. So we want to skip fragment parsing to avoid
> unnecessary errors.
>=20
> Fixes [YOCTO #16060]
>=20
> Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
> ---
> =C2=A0bin/bitbake-layers=C2=A0=C2=A0 | 7 ++++++-
> =C2=A0lib/bb/cooker.py=C2=A0=C2=A0=C2=A0=C2=A0 | 8 +++++++-
> =C2=A0lib/bb/cookerdata.py | 4 ++++
> =C2=A0lib/bb/parse/ast.py=C2=A0 | 3 +++
> =C2=A04 files changed, 20 insertions(+), 2 deletions(-)

The patch does look like the right thing to do and I like it a lot,
thanks for putting it together.

Unfortunately, testing on the autobuilder is showing an issue where
fragments are disappearing. It is when memory resident bitbake is in
use, i.e. BB_SERVER_TIMEOUT=3D60

For example:

https://autobuilder.yoctoproject.org/valkyrie/#/builders/2/builds/2760

where MACHINE seems to be unset in some builds.

If the timeout happens, the server does properly reset and the builds
work so it is timing sensitive.

I've not managed to get to the bottom of it yet so I wanted to at least
share the issue before I sleep!

Cheers,

Richard

