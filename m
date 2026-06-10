Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9981FCD8CB9
	for <webhook@archiver.kernel.org>; Wed, 10 Jun 2026 16:27:11 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.24652.1781108829476362476
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 Jun 2026 09:27:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=GLzngfOQ;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-490b915ded5so61494655e9.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 10 Jun 2026 09:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1781108828; x=1781713628; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1XDuyMQfP7BjsdhmoUxgNh0WBfUM+mppX8UnIHbMiBw=;
        b=GLzngfOQmDwzr+VxEQMY38WvBaRvEp1IuT03I4I+A0JkqFxQXMWcPv00U7A6lgn3vL
         LkF9eakHAdd+bq8H503bjkdrU6knc8FZOoP/lbHKpcRfs6u6cC07u+Wu4gZCW56ecv9i
         BjMbAcETzVwovLObPtUYGN1U8QfHGGroEoLgU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781108828; x=1781713628;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1XDuyMQfP7BjsdhmoUxgNh0WBfUM+mppX8UnIHbMiBw=;
        b=W4m4ShHNIBFRnlnivAETC8q3TDkfgEIUAfUqFyT9fH69PCpX3Hplqm53vdx4tCIQL7
         wWVhdseQD+PZlVsTihZd40jR1d0Sd2HRLfMmY9qvsFe8D/kvTyP6nNn2gmspW6uRp+kH
         eU5cdibv4vlgY/zjkhX4vFFjp90Vw0iuNaTny9XNwA+7DEQd/RuFDDsPRaUMhWP3uCpn
         Yr5zmTaV63ugnNynFRVXB4EsEeFgxnO2471pyjLcJADIjc+e/ZS0/oevht3suQqcAgZt
         vgwOKcOm4I0tsiIxqW1YQbEU2DSXVNqRpr96uDmt+d+H/q9tRcpky4/Lge3It4IiEvhn
         kZsg==
X-Forwarded-Encrypted: i=1; AFNElJ9vapfrtJnueFFufyGGh6MSoYWVC7HMICS9t9FxWiVhYeRcbiesK5rpHXhwZVN4JILWiw8f3kGI9Fzr8vqw@lists.openembedded.org
X-Gm-Message-State: AOJu0YxAekfC/elIUDnL05COPAqvjHtXPkNQFZM0qszAHSxUPr8yDc4B
	Wuavp/BbbtYE+uN2foUt+AFbg82ErcTteDF5e8il6lg6njsBWny9TpT/knmo9uNSf4g=
X-Gm-Gg: Acq92OFtWfT18a+U4T8AcloE6SwMPpzqYQTlw5BgW7enI5YJxRlXXG7zV/lcZvjL1Vm
	BQZkARO5Iku19Sgur+djK5W7GI6UC5IVOWpDsUgxiEc/h5RnZjmRGxveb/1ewohx0rUpU13fwly
	rZ5c93wgWxwDigYDu++XQXCr6+AejQY0Gis2RmMc2vdiFpEzXpxxohvRtpdg+Z/LE8fgZJ1QqTc
	ykAG91G7+GP9nrrRD1YxYRdtvLSWnlMiSTBmnomRAurW/q+0In9y0E8ZosIG3qAppqlVgr2xz/W
	pc3rAPgJsreRHyxGLOG0uZyNkoR/M02yiastM4mF5CMW9muiGRmoTAcpmU/Mt+fEUoU0ika4br4
	EMvpeRkXphtc9PS0HeBgOzv7MYIUX2TB7H3GKDiiRDUASAdX3ikIkNlWN/QjKxgfkeiCUscYFVz
	Us6C+k2eJd9cxvJnmFXfNQnVYo5lSy2VHjZLPL7oIHijPktz81Zt1nx1Y5w6i7Wfs85/BT6IzKw
	69MpqS0MmVl3UinqTKORMmK
X-Received: by 2002:a05:600c:4e04:b0:490:cc1b:15c7 with SMTP id 5b1f17b1804b1-490cc1b1631mr279614945e9.30.1781108827790;
        Wed, 10 Jun 2026 09:27:07 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:e996:5a7:2609:813f? ([2001:8b0:aba:5f3c:e996:5a7:2609:813f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490e285f4d9sm379235e9.12.2026.06.10.09.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 09:27:07 -0700 (PDT)
Message-ID: <411bfc4142ad6d577df4b9350d6a18ca977b7127.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel][PATCH 0/2] fetch/npm: fix security issue and
 re-enable fetcher
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: thomas.perrot@bootlin.com, bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Date: Wed, 10 Jun 2026 17:27:06 +0100
In-Reply-To: <20260610-dev-tprrt-fix-npm-v1-0-9bf501d4ee0e@bootlin.com>
References: <20260610-dev-tprrt-fix-npm-v1-0-9bf501d4ee0e@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 10 Jun 2026 16:27:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19646

On Wed, 2026-06-10 at 17:46 +0200, Thomas Perrot via lists.openembedded.org=
 wrote:
> The npm fetcher was disabled in 355cd226 (Jan 2026) because it retrieved
> checksums from the remote registry rather than from the recipe.=C2=A0 A
> compromised registry controls both the tarball and its advertised hash,
> making checksum verification meaningless.
>=20
> Fix the root cause by separating URL resolution from checksum handling:
> - _resolve_proxy_url now stores only the bare tarball URL in the .resolve=
d
> =C2=A0 file; the registry-supplied dist.integrity / dist.shasum values ar=
e
> =C2=A0 ignored entirely.
> - _setup_proxy builds the proxy URL from that bare tarball URL and inject=
s
> =C2=A0 the checksum from the recipe's own SRC_URI parameters (sha512sum=
=3D,
> =C2=A0 sha256sum=3D, etc.).=C2=A0 When no checksum is provided the proxy =
URL carries
> =C2=A0 none, and BitBake's standard BB_STRICT_CHECKSUM machinery handles =
the
> =C2=A0 missing-checksum case the same way the wget fetcher does.=C2=A0 A =
bb.warn()
> =C2=A0 is emitted so recipe authors get a clear signal instead of a silen=
t
> =C2=A0 unsigned download.
> - version=3Dlatest is now a hard ParameterError instead of a warning; it =
is
> =C2=A0 inherently non-reproducible.
> - Narrow the broad 'except Exception' in _npm_view to json.JSONDecodeErro=
r
> =C2=A0 so that FetchError and ParameterError propagate typed to callers.=
=C2=A0 Also
> =C2=A0 fall back to str(error) when 'summary' is absent in the registry e=
rror
> =C2=A0 dict so the message is never silently None.
> - Clear uri.params before rebuilding the proxy URL to prevent a
> =C2=A0 .resolved file written by the npmsw fetcher (which stores the full=
 URI
> =C2=A0 with checksum params) from contaminating the npm proxy URL with a
> =C2=A0 registry-sourced checksum, bypassing the security invariant that o=
nly
> =C2=A0 recipe-provided checksums are trusted.
> - Remove dead 'if ud.version =3D=3D "latest": return True' branch from
> =C2=A0 need_update(); version=3Dlatest is rejected at urldata_init time.
>=20
> Migration note: recipes using npm:// must now supply a checksum in
> SRC_URI, e.g.:
>=20
> =C2=A0 SRC_URI =3D "npm://registry.npmjs.org;package=3Dlodash;version=3D4=
.17.21;sha512sum=3D<hex>"
>=20
> On the first build without a checksum BitBake will download the tarball,
> compute the hash, and instruct the author to add it.=C2=A0 Any stale .res=
olved
> files under DL_DIR/npm2/ written by the old fetcher (which embedded
> registry-sourced checksums) must be deleted before rebuilding.
>=20
> [YOCTO #16105]
>=20
> Fixes: 355cd226e072 ("fetch2/npm: Disable npm/npmsw fetchers due to secur=
ity issues")
> Signed-off-by: Thomas Perrot <thomas.perrot@bootlin.com>
> ---
> Thomas Perrot (2):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fetch/npmsw: fix security issue and re-ena=
ble fetcher
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tests/fetch: restore and extend npm/npmsw =
test coverage
>=20
> =C2=A0lib/bb/fetch2/npmsw.py | 12 +++++-----
> =C2=A0lib/bb/tests/fetch.py=C2=A0 | 64 ++++++++++++++++++++++++++++++++++=
+---------------
> =C2=A02 files changed, 51 insertions(+), 25 deletions(-)

I suspect there is a patch missing or something here as it doesn't
touch npm.py and half the changes above appear missing...

Cheers,

Richard

