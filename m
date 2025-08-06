Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D59C87FCB
	for <webhook@archiver.kernel.org>; Wed,  6 Aug 2025 09:09:41 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.web11.20839.1754471371700678005
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 06 Aug 2025 02:09:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=ciUUlw6S;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.50, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3b783d851e6so5556173f8f.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 06 Aug 2025 02:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1754471370; x=1755076170; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YL+UvJSaUqKKJ/+XIDaCw9mSvMTq7fi3JhsMsXF6YdA=;
        b=ciUUlw6SEhJhHFPfI0HKzcvNwlyU7NC/LZHN57wpvVUnwM4eMv8dsKjfNsB5nkpTt1
         eABpp/qTKFFw46tvjRa/tv21svnJ18LaXnK0gYPYtHhLsM/RMmqbbwoWnkDp/HAppVWd
         iUcxreKof8CCi5F49pVCBonGxMnbqVFyw7gpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754471370; x=1755076170;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YL+UvJSaUqKKJ/+XIDaCw9mSvMTq7fi3JhsMsXF6YdA=;
        b=RMXZi49L0Xv4Ny1ORUIHCZUnG1Y+YgH/KiGJsZNGcdRH/7hRadJWr5T7l4U/k5MkB7
         Qldncb0fBGZpP6tqpBcmkL+v6GJRONVIcM2ktoIcd/Xtn9eIw80oGTAP7NzCirCMth9G
         xYRnnYf7321LfC+6tV+UgkNDGIplPGktEbUEJn8RceEmd2TiG9F4tHzGimH7wbk7Frpp
         N6YcKfxBr4JF6akj8RCnW7/cjx2y8JcXXR7fDa9x90BAKMX7YismG7dlPgnxcCg/Wd4L
         pGZMoUGH4WkyCpxmk9o3v8tvAzcdJXvFAnKaatGDGU0TdRBQcTnT2PWB3jfPmm19rQZu
         VIRw==
X-Forwarded-Encrypted: i=1; AJvYcCWJaUyeFTUWxnZbGe8YNznCBXWUdYkOhgioWh+4Ac3wz0L7jMnACD4BSrIOcnU7pPVuETIBYmzSqHmsC/Ny@lists.openembedded.org
X-Gm-Message-State: AOJu0YxPqA9Y2x31tEBQE0yFPuHr+ym7+qOe7sNkhR3RxbJWWtfSj10b
	+m3OCE5zMRJIZK1PDwXU1jZn/M11/buzwwBSJ6ijEp5rNm4YUxeb4AbvchgnipYkunU=
X-Gm-Gg: ASbGnctN8nJ+JwGqqN3CpM/Npkys2lZS5YMpOzvjLzDCiOkpe45dxcGB+UYh0XoAwfs
	uRFCNAlr9XAWJ0sB2Tx2N/v3BoEDav6eZmOtrVJSUKjRXN5In4TVlZN6RK1HNeUolKGiOhfHDEx
	0xmgzCDHJkOwcpEs+I+eMYvh+lc6+5HJE3ZMtKLeHg6Fy77ZQC9BHNpYjwOu+twg/6yw9sJ4R0a
	fvZ6T6Uw2Z2VsjJu7O5wmYRSDku/+pL17rI728Vdp3G0lO71KBcPgmQn5c+0fnWQMI0ELbtXqU+
	s9xx9xg7nSk8q6WU6bWsQpwOevUggk84JaIcO0tCWImIrI5gTXG06c4tzYBlDPXQh9J+gFYyu15
	A0JB7Oc/vfohfu9Dh6LsXC0O86upPkYmpVLeBYNbpXcUYMbl37Ptcb/Fv6/16UBjo9Hma2DgmqA
	YhXk2B2mj0S68=
X-Google-Smtp-Source: AGHT+IFs7EAk0UPgNeJC4oRiqcZ2iZPR2gKvWKSDScrk+uJsMbkJl3k//435TAG15EZriYfzPv7grQ==
X-Received: by 2002:adf:a2d9:0:b0:3b8:d69b:93b with SMTP id ffacd0b85a97d-3b8f4925ac4mr847499f8f.52.1754471369925;
        Wed, 06 Aug 2025 02:09:29 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:ba4d:97fb:bf3b:8a21? ([2001:8b0:aba:5f3c:ba4d:97fb:bf3b:8a21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e58553f8sm41241535e9.14.2025.08.06.02.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 02:09:29 -0700 (PDT)
Message-ID: <5426d28a6c7673164388d02fa051205dfed99648.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] Hash equivalence server garbage collection and
 *_qa tasks
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: philip.lorenz@bmw.de, bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Date: Wed, 06 Aug 2025 10:09:28 +0100
In-Reply-To: <74e41b81-6c18-46cf-a808-b28e955a5fe2@bmw.de>
References: <74e41b81-6c18-46cf-a808-b28e955a5fe2@bmw.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 06 Aug 2025 09:09:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17839

On Tue, 2025-08-05 at 11:58 +0200, Philip Lorenz via lists.openembedded.org=
 wrote:
> Hi all,
>=20
> we have deployed the clean up strategy proposed on IRC (mark all=20
> unihashes with a corresponding central sstate entry as alive, then=20
> sweep) for a couple of months and are observing that the *_qa tasks=20
> (e.g. do_package_qa) contribute a significant amount of "stale" hash=20
> equivalence entries to our database.
>=20
> Technically this is expected as the tasks always produce the same=20
> outhash (and are thus mapped to the same unihash every time they are=20
> rebuilt) however the database schema currently does not seem to carry
> enough metadata (e.g. a creation timestamp) to identify those unihash
> entries and to mark them for removal.

I had to think about this for a couple of minutes to understand why the
cleanup strategy isn't helping.

The issue is that the output for some tasks is always the same (empty)
so *many* input hashes map to that one output hash. The cleanup
strategy looks for active output hashes and assumes all the inputs are
still useful. This means for cases where the output remains the same
over long periods, hashes can accumulate fairly unbounded.

> Are there any known strategies to address this?

No, this is new territory.

> If not I see some possibilities to deal with this but I'd like to=20
> collect some feedback before proposing an actual change:
>=20
> * Add a created column to the unihashes_v3 table and parametrize marking=
=20
> to omit entries older than a certain timestamp.

I suspect that could end up fairly error prone as it depends on how the
entries are accessed. If something is built infrequently, the data will
be evicted even if for example the sstate is still there.

> * Add a access time column to unihashes_v3. I do realize that this code=
=20
> path is performance critical so this would involve some mechanism to=20
> only update the access time of an entry once per day (similar to what
> relatime does for file systems). The advantage of this would be more=20
> sophisticated clean up strategies which keep all entries that have=20
> actually been used in the past x days.

This is an extremely performance sensitive code path as you say so I'm
a bit nervous about putting in writes here, even infrequently. I'm not
sure what to think on this one. I've copied Joshua.

Cheers,

Richard



