Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49AAFCD3424
	for <webhook@archiver.kernel.org>; Fri,  1 May 2026 09:30:06 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10896.1777627803530102916
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 01 May 2026 02:30:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=X8brXa0W;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4896c22fcbaso12314625e9.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 01 May 2026 02:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1777627802; x=1778232602; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IPKcRng6cW2OnHDaYQ4I1VJ4YNznE5gXGE2YMPhwRpg=;
        b=X8brXa0W3IC+O5lytUGNkM8PRVStQJHS1xA5em0/beZNmtqJPngwLAUf2sjFfIcp/o
         p2kIH16LNKtNFXVwA1QfiS9MCAu8s+1lvtdePZyzzMAb0MYEEo77sOk2sub4ZhAZwRCy
         lKTfK76izY+PT1jldmMNlmCu+ZvlhzSJ29wfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777627802; x=1778232602;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IPKcRng6cW2OnHDaYQ4I1VJ4YNznE5gXGE2YMPhwRpg=;
        b=qz8QgmHEPDwyN7xK/Y/GEvPT2XQUO0XdjrWswSsSyoEJwAgQ4M5pMyf4vpPL5d1qpQ
         8DPI7bBfgxfiadqt9YoPSCoXIyF8x8mKShY9ymuY0IrvyE4Klxm2PddNu0IVNC2TpGLf
         cVmJ91QCVZ6XU21n8EnKloE5egRv9JMy/ei3qn1UgbeN7oH2O7L/ZQxPlnzqy9ggztdN
         8ZiE3WPub0w18emIMVvgutF72TQJdr5zoafeDfyZOcnxp26xfqt/Qyobtgw8loyzOklV
         jD3dELUCMSPAndX9ZWM21mACydri/4lGtBDqofJr5V9gGr6E8zPIhprhHgr/DeBumDar
         RIKQ==
X-Forwarded-Encrypted: i=1; AFNElJ9xy8Vrq0o/7Aksx2AD7gI5LZDKp+IA+pJAcA1KSMeDYlxcbs9rEQphIC4chnbHiu0RDSHEUS3zlXGj4CpE@lists.openembedded.org
X-Gm-Message-State: AOJu0YzQgiP6OyhzhJHr3TlZnNRApuCJuYTFL0U+gs3Gv46qwvLrIjto
	p+cvlkbc/2k/GzgoViFjnU6/amSPDH8HgKLRYRY6bh0OHb2N2lHwhwxBEVIdk/4pOGU=
X-Gm-Gg: AeBDieuCygIFRj8JiQxRgqN8Jbh8iwU2qq7l7ePIYi0OdSmMwXfH2Bh+uhSVrdDtc0v
	fhKzzUTuzY+DlaPqiO4BmjUK2eXQ+ReMWmYpDt2eFm7VuUgRaheypfrpaawzqcmaSaPbl+mPhnu
	I01LQS3LNicR7vD5KV/8mIzlkITmPhi/p9A8KxjMhgVETR8VXzs8QD4E2NVEyozzntkkWqBi+st
	5eYc40lFlwKSIlgDO4GAocRD6adVdjZDKybrgdFbop3w0KD9gZrvvYa0ExmY+SHEkUdWgkTSb5h
	+eJQ7bB/nVTwQdaRi9JDXXcSVxzz5jN3gvu7KBN/DIFavAeJJRjcO2v1dmR0sy+DH5LpZG2ED5p
	2N2McTyoux0D1RycmAsP5Pn5fmmlpAxAksh6RXW+FVvXELe1Uv9rVqtG39Fo5XFB2KLepveX0dZ
	8bk+aBHyvKcUh6C5Rewmo2V4biRz64mcOqvkegE7q5g9WzypN7oOislf51z/tXVGj1S0UvgxzI4
	ApL745LnJX7Wp1ms5Gn3g==
X-Received: by 2002:a05:600c:8288:b0:489:a4:e578 with SMTP id 5b1f17b1804b1-48a8eb8a3camr33081835e9.14.1777627801660;
        Fri, 01 May 2026 02:30:01 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:87e5:38df:dc:249c? ([2001:8b0:aba:5f3c:87e5:38df:dc:249c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8ebc4201sm71527465e9.15.2026.05.01.02.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 02:30:00 -0700 (PDT)
Message-ID: <b49490a4a2e1cbbbdd8eb84d3c5bb2af57418488.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 1/1] bitbake: add
 BB_GIT_SHALLOW_SKIP_FAST to disable fast shallow mode
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: marciohenriques84@gmail.com, bitbake-devel@lists.openembedded.org
Cc: Marcio Henriques <marcio.henriques@ctw.bmwgroup.com>
Date: Fri, 01 May 2026 10:29:59 +0100
In-Reply-To: <20260430123847.25046-2-marcio.henriques@ctw.bmwgroup.com>
References: <20260430123847.25046-1-marcio.henriques@ctw.bmwgroup.com>
	 <20260430123847.25046-2-marcio.henriques@ctw.bmwgroup.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 01 May 2026 09:30:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19430

On Thu, 2026-04-30 at 13:38 +0100, Marcio Henriques via lists.openembedded.=
org wrote:
> In some CI environments, shallow tarballs are preferred as fallback artif=
acts,
> not as the primary source path.
>=20
> Today, enabling shallow mode also enables an initial fast shallow path th=
at may
> avoid creating/using the regular local clone flow in DL_DIR. This can red=
uce
> the effectiveness of incremental fetches and lead to larger re-downloads.
>=20
> Add BB_GIT_SHALLOW_SKIP_FAST as an opt-in switch. When set to 1, the fetc=
her
> skips the fast shallow path from initialization and proceeds with the reg=
ular
> clone/update flow, while still allowing shallow behavior and tarball fall=
back.
>=20
> Default behavior is preserved when the variable is unset.
>=20
> Signed-off-by: Marcio Henriques <marcio.henriques@ctw.bmwgroup.com>
> ---
> =C2=A0.../bitbake-user-manual-ref-variables.rst=C2=A0=C2=A0=C2=A0=C2=A0 |=
 19 +++++++++++++++++++
> =C2=A0lib/bb/fetch2/git.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 +++-
> =C2=A02 files changed, 22 insertions(+), 1 deletion(-)

I'm wondering why you wouldn't just turn off shallow clones in this
scenario?

I'm also conscious of not wanting to add too many options to the
fetcher, it makes the code more of a labyrinth and harder to
test/maintain. Would it make sense to use BB_GENERATE_MIRROR_TARBALLS
here to change behaviour?

That option is usually set for people wanting to build source
mirrors...


Cheers,

Richard

