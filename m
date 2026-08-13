Return-Path: <paolo.wattebled@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A1FCC5B572
	for <webhook@archiver.kernel.org>; Thu, 13 Aug 2026 15:31:35 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.21842.1786635091945954379
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 13 Aug 2026 08:31:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=WKvnDmcH;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: paolo.wattebled@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 9215A3D8172F;
	Thu, 13 Aug 2026 11:31:30 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id FDSYZpHC-wpC; Thu, 13 Aug 2026 11:31:29 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 3A56B3D8174F;
	Thu, 13 Aug 2026 11:31:29 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 3A56B3D8174F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1786635089; bh=3Lv1wVVUZRxEzLcsytBkpyk96s6v/ZA6desp0uKMpH8=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=WKvnDmcH7em+yrO238ovXToGYBV7J8RYH2Hef+HxD6xgse2EKGLsrYe+28aIp75vC
	 PWuHmTW7mFnnol5DCGZroezxpSbjOfmsLk/SvIPsR8nJ3Zgm+KdbVbQhWBe5Q0RhKX
	 XjtH3kn6kx/T5tHs/Hmsdv+M/NE3nnGqXH6qwhfp8wsKpyhr3LrJYzKvABpvmyQSwE
	 V8KpluWVH+rCT3Gc7ZIq6IrokzF80dD8MN0z0zavHhMXqI4hxN4ppLQAVyKujhkbs4
	 PfM2aAbr/jx0WHsxqFfm5yxGoq8mAqLissTRoO8awMhSDpmUxjtT8G3iXj+Q1PdfiV
	 nrOxu2GYL7T0Q==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id AFZHJpibmHJh; Thu, 13 Aug 2026 11:31:29 -0400 (EDT)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [192.168.48.237])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 194843D8172F;
	Thu, 13 Aug 2026 11:31:29 -0400 (EDT)
Date: Thu, 13 Aug 2026 11:31:29 -0400 (EDT)
From: Paolo Wattebled <paolo.wattebled@savoirfairelinux.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Message-ID: <252742809.992447.1786635089054.JavaMail.zimbra@savoirfairelinux.com>
In-Reply-To: <2434d54e4295573c9632a1fbcd0cef7ae6a0d413.camel@linuxfoundation.org>
References: <20260812150448.2343308-1-paolo.wattebled@savoirfairelinux.com> <2434d54e4295573c9632a1fbcd0cef7ae6a0d413.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] toaster: Add recipe variables view
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 10.1.15_GA_0126 (ZimbraWebClient - FF153 (Linux)/10.1.15_GA_0126)
Thread-Topic: toaster: Add recipe variables view
Thread-Index: KPU8xviF3gvOZou39fthfNfYEdfqAQ==
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 13 Aug 2026 15:31:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19930

Hi Richard,

Thanks for raising this. I ran a quick comparison with and without the chan=
ge.
Toaster startup and recipe parsing were effectively unchanged (2m46.554s vs
2m46.835s). A cached imx-image-core build took 4m23.648s versus 4m07.387s,
about 16 seconds slower. After vacuuming, both SQLite databases rounded to =
74
MiB, including 598 per-recipe variable snapshots. I understand that some of
this data is stored twice. However, I only store variables changed by recip=
es
or bbappends, and I compress them before saving them. In my test, this did =
not
noticeably increase the database size.

Our intended use of Toaster is as the backend for an MCP server for AI agen=
ts.
Rather than having agents repeatedly parse and search recipe files or invok=
e
bitbake-getvar, the server would expose resolved, build-specific metadata
through a stable API. The MCP layer is still under development, but per-rec=
ipe
variable values are one of its planned endpoints. We chose Toaster because =
it
already models builds, recipes, packages and variables; extending it avoids
creating a separate metadata store. It will run headlessly in this use case=
,
with the MCP server translating between Toaster=E2=80=99s API and the agent=
.

Regards,
Paolo Wattebled


----- Original Message -----
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: "Paolo Wattebled" <paolo.wattebled@savoirfairelinux.com>, bitbake-devel=
@lists.openembedded.org
Sent: Wednesday, August 12, 2026 4:34:24 PM
Subject: Re: [bitbake-devel] [PATCH] toaster: Add recipe variables view

On Wed, 2026-08-12 at 11:04 -0400, Paolo Wattebled via lists.openembedded.o=
rg wrote:
> Toaster records global build variables but does not expose the final
> values associated with individual recipes.
>=20
> Collect variables defined or modified by recipes and their bbappends,
> resolve active overrides and expansions, and store one compressed JSON
> snapshot in the database for each build and recipe. Keep the variable
> count separately to avoid decompressing snapshots in recipe-list
> queries.
>=20
> Expose the values through a searchable and paginated Variables tab and
> show their counts in the built-recipes table and recipe package view.
> Preserve compatibility with older dependency payloads and invalidate
> stale BitBake caches after extending the cached recipe information.
>=20
> Tests cover variable collection, cache transport, database persistence,
> backward compatibility, searching, pagination, escaping, and counts.
>=20
> AI-Generated: Uses GitHub Copilot and OpenCode with GPT-5.6 Sol
> Signed-off-by: Paolo Wattebled <paolo.wattebled@savoirfairelinux.com>
> ---
> =C2=A0bin/bitbake-selftest=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0lib/bb/cache.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +-
> =C2=A0lib/bb/cache_extra.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 66 +++++++-
> =C2=A0lib/bb/cooker.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 6 +-
> =C2=A0lib/bb/tests/cache_extra.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 141=
 ++++++++++++++++
> =C2=A0lib/bb/ui/buildinfohelper.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 21 =
++-
> =C2=A0.../orm/migrations/0022_recipevariable.py=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 27 +++
> =C2=A0lib/toaster/orm/models.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 10 ++
> =C2=A0lib/toaster/tests/db/test_db.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 101 ++++++++++++
> =C2=A0lib/toaster/tests/views/test_views.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 155 +++++++++++++++++-
> =C2=A0lib/toaster/toastergui/buildtables.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 11 +-
> =C2=A0.../templates/detail_pagination_bottom.html=C2=A0=C2=A0 |=C2=A0=C2=
=A0 4 +-
> =C2=A0.../templates/detail_search_header.html=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 2 +-
> =C2=A0lib/toaster/toastergui/templates/recipe.html=C2=A0 |=C2=A0 32 ++++
> =C2=A0.../toastergui/templates/recipe_packages.html |=C2=A0=C2=A0 7 +
> =C2=A0lib/toaster/toastergui/views.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 68 +++++++-
> =C2=A016 files changed, 642 insertions(+), 12 deletions(-)
> =C2=A0create mode 100644 lib/bb/tests/cache_extra.py
> =C2=A0create mode 100644 lib/toaster/orm/migrations/0022_recipevariable.p=
y

At this point you're basically dumping out the entire datastore for
every possible recipe. Due to the size of the data, I suspect it is
just as expensive to reparse as it is to read the stored compressed
data and it isn't really a cache any more. The presence of that data
will slow the rest of the system down.

Have you looked into the performance (in speed, memory and disk space)
implications of this?

Also, do you know people actively using toaster?

Cheers,

Richard

