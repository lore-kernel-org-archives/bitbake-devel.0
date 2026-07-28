Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A595C54F51
	for <webhook@archiver.kernel.org>; Tue, 28 Jul 2026 21:15:53 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1458.1785273346708138056
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 28 Jul 2026 14:15:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=B+hoUxJ0;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4758bd3731bso240171f8f.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 28 Jul 2026 14:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1785273345; x=1785878145; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+oGzrQlqzA+K8J0DwM/TN4ET4vtshgcLnv83zPP89WM=;
        b=B+hoUxJ0H8Y4kkctmeSj5ybUP8G7UYOgJ3387ueP1/l6vS4hdnTfTgaYmGn/uAB1hw
         PV7/V7evcISdVMiYVvJn4QHz4OXAciTMU4S++krpoHXuiL0TBjSGVhSTklK3+gMbkLOx
         HR9+4/g8Pw+/vnK5Kx41eFHUD/qW/GJ2mLxwM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785273345; x=1785878145;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+oGzrQlqzA+K8J0DwM/TN4ET4vtshgcLnv83zPP89WM=;
        b=jtjaNwOVemq96bl69X3ePg+EQM/CGmaa/PG6VFNhlEGe191TQu5OPY49F1tpQBkhWD
         AG72Y4BOVgmzCwoF+qvDCY7crDUc5EDS1YFHrwg2nE63mR/+Va1Kf/RGBPlG6v8d7aXv
         G4VlVKbINCGxu1isr308P1ABaRUF+UnFl5e2J02sfmb34nZc1gZq3Ajd7He+BiU9obye
         f3LHkZdCPT70Ap5cnnrw+I6As+5/QyJVY05FbVs6EpuUUhBocwnJmRRXqkAdcsqZpmcD
         Fd2NWhNvzdzd884wZKiyqX3md3pGz0jseeDpIJv7XJH9aRddeh7NLebTuKr1hIfl31iB
         m3BQ==
X-Forwarded-Encrypted: i=1; AHgh+RqFEydzlpKIg40ikKY9pqZWyp9L3a7gn/tCinosVCKtdKLI4ORjCCvNFRGchNHXS1/aRrWieSqNUj7FJGwd@lists.openembedded.org
X-Gm-Message-State: AOJu0YyoYhUUNZbwe/nk0G32h8tCXQqpgyl1AHConIeV+452aWZ+OmzE
	BdxDu++YkO1nWl0YKfkhX012lTuOA34jHlMAx5PHN8Qp0cLIvsCTVwaXCVqg3J3+Ygs=
X-Gm-Gg: AR+sD10HylxcaHbxzRaEY8Dd6MXl+U0VqELQ0Ol5pFoycFHtkj5JQIbhPBcBZktIATY
	hRb5Tc/yriU3mvtXznnI88OpMJrQYHpb8ZtQhuV4PSyFJwmo9Ok4Nfbw2BV9VyJKqpM10nAcPbH
	cR9PuLGOEtEnx63CSGy+P4GmjDTVBxStUa52b7GS/smhik6GvTU2gHZz7Z7QLYWIkEbHXMR9GW9
	SWeSbtVe9Q5+Ju4byNrp3H3c7ZnqsGd2njIk3rB3/maV38q+iYKFFSPdE8sVJfc4NFtwg1W3Fgv
	+sSQBgAonKHVR2w0o5xkDiliVh/7SdkSX11cCLyb0oIXAwgiqRm3cKuTA6xkfXCgkiyIRU2zVrn
	Mql5o9277CJQsU9FviTRJ7NYpw1J6hf6Lol1b6bkqX0qCk7pUroQBiDRTfUUueKGlFT6JilPseq
	YvM3I3Rvu0PqkfM1Du4r4WDxx10wE2wkw/gP0fBbvetFml/hEfyPYeHaH+uceQWVti22w=
X-Received: by 2002:a05:6000:2c0c:b0:47f:70b2:7321 with SMTP id ffacd0b85a97d-47fb1ee5316mr4741928f8f.27.1785273344700;
        Tue, 28 Jul 2026 14:15:44 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:c7f3:6f47:b56a:784a? ([2001:8b0:aba:5f3c:c7f3:6f47:b56a:784a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fb6b0f2ddsm2060575f8f.20.2026.07.28.14.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 14:15:44 -0700 (PDT)
Message-ID: <8b324e07c0501a6e613fe197aa6e462422360d93.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH v2] bitbake-worker: Evaluate
 exported_vars() before emptying the environment
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: amery@apptly.co, bitbake-devel@lists.openembedded.org
Date: Tue, 28 Jul 2026 22:15:43 +0100
In-Reply-To: <20260727172856.2304118-1-amery@apptly.co>
References: <20260727172856.2304118-1-amery@apptly.co>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 28 Jul 2026 21:15:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19867

On Mon, 2026-07-27 at 17:28 +0000, Alejandro Mery via lists.openembedded.or=
g wrote:
> exported_vars() returns a lazy generator. It was bound before
> empty_environment() cleared the process environment and only iterated
> afterwards, so any datastore expansion deferred until iteration ran
> against the wiped environment rather than the one bitbake started with.
>=20
> The corruption is not uniform. The loop writes each variable into
> os.environ as it goes, so only the first value expands against a fully
> empty environment and the rest see it partially rebuilt, in
> exported_keys() order.
>=20
> Recipes whose exported variables expand a command during that loop hit
> this. A gitver-style PV such as "${@get_git_pv(d, ...)}" runs git while
> PATH is empty, so the git wrapper on PATH is bypassed and the real git
> runs directly. Under pseudo this fakes uid 0 against a repository owned
> by the real user, and git aborts with "detected dubious ownership",
> failing do_package intermittently (only on reparse, when the value is
> re-expanded rather than served from cache).
>=20
> Materialise the generator into a list before emptying the environment so
> every expansion happens while that environment is still intact. Add
> tests for the expansion timing this relies on: values materialised
> before empty_environment() survive it, a generator consumed after it
> does not.
>=20
> - v2: comment the ordering at the call site, and add the tests.
> - v1: the list() wrap alone.
>=20
> Signed-off-by: Alejandro Mery <amery@apptly.co>
> ---
> =C2=A0bin/bitbake-worker=C2=A0=C2=A0 |=C2=A0 5 ++++-
> =C2=A0lib/bb/tests/data.py | 42 +++++++++++++++++++++++++++++++++++++++++=
+
> =C2=A02 files changed, 46 insertions(+), 1 deletion(-)

Thanks for the changes.

I'm worried that the test case doesn't cover what I'd ideally like it
to, specifically that bitbake-worker's environment can't get corrupted.
The code in bitbake-worker can be changed independently of the test
case and break things, which means the test isn't protecting against
what I most fear happening.

I did a bit more research and thinking about this and I think I might
suggest a new approach. I've noticed that this is the only user of
exported_vars() in the codebase, so perhaps we just stop returning a
generator?

It does appear to be causing a lot more problems than it solves,
particularly if we just turn it into a list anyway!

If we change things that way, it seems much more unlikely we can break
it in future and the need for the comments is removed.

Does that seem reasonable? Sorry about the change in direction but this
patch just doesn't look/feel right now I realise there is only one user
of the function.

Cheers,

Richard

