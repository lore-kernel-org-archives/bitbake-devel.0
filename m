Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A44FCA5FF0
	for <webhook@archiver.kernel.org>; Mon,  5 Oct 2026 14:36:46 +0000 (UTC)
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.21521.1791211000510826834
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 05 Oct 2026 07:36:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm3 header.b=WFN/faD8;
 dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=k9cMGU49;
 spf=pass (domain: pbarker.dev, ip: 202.12.124.157, mailfrom: paul@pbarker.dev)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B3F927A00AF
	for <bitbake-devel@lists.openembedded.org>; Mon,  5 Oct 2026 10:36:39 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 05 Oct 2026 10:36:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1791210999;
	 x=1791297399; bh=11kDFAIHFGdTYWk8e74FBxv/u1iGwPAdSuVxiToNnB4=; b=
	WFN/faD81ZheA+6XGkmiDctpo11jpH2oj72wXlvJZj73+SZdK6YiKHvgM7O3FcMW
	4P+MXYksz6TlzVJn2q/ztHN2Z7EKSCSY7DzLrAN9Y/K5+KrNtXXhA7cEL/E/IFDU
	kTOqM07sgiRdoO6CfOoEFUQi1OsaMLIGiEqxGfWokPnIQUKBFyelEryIMHzcENw/
	zsWv0M9T0q1jmFKnhLfbxAIljIT2q9CzhEi2QGbq2jo2ReIGKMk554+5iQV9FvwT
	KT5FOM/lOsKh1Q8JlO6o9pGKSA1JRGKRShWZ3ZEdxrFjfclXNreM2qUwFRh//B3b
	7p7neLZxIUThDuRl/sdpbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791210999; x=
	1791297399; bh=11kDFAIHFGdTYWk8e74FBxv/u1iGwPAdSuVxiToNnB4=; b=k
	9cMGU49uBXbbKdZTuSycIMFww/EMNHvXkWPwq2j7kX6XtCyc9ZEz4zoeXysjnbGM
	kQ62DB31Xvi1JeWJB/YFCyY1L2XNF/Q74do24eudy0QYxit4gPHcQ0/ppYP90G/b
	Ty8j/oxTnqlTBVXLPpLjJPXyJNtLYt6NtcNXbC5/46uDgCoOF0/NoyQN6SJww/DG
	cDuHWoaFLVtwE9zXanHcag1cehVvsdYFWYvfis5N52HQckeBCPJGlcMqD/ZDhefp
	98hV8q/3jHRRL5jZZqZV0VAUpeRweiDzfOq5Pb1bApz4AzEJSdJjHVpdljZwTC6W
	ZCwY0b3cUfWECGcFm7+mQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pbarker.dev a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791210999; d=pbarker.dev;
	mf=PHBhdWxAcGJhcmtlci5kZXY+;
	rt=PGJpdGJha2UtZGV2ZWxAbGlzdHMub3BlbmVtYmVkZGVkLm9yZz4=;
	s=fm3:rsa-sha256:NgNFx3125W+c0duy1r4HJ+O01jCpQ4ylNQj/O4fODDG6obi
	UdVwffpNIagIOUyX4aTD6FcKS8YukaFEZB3qtE5u5RZ2tGX3/RNRYt0hAnFo9tRJ
	ZZI3hVk2G7vLuDHALNGRmWhaTvASx6E5o3PcbrUZjlfSuNCy+0geo0mrDpPUIfcQ
	vVbc1mXv3QHyGdPDIi20L8OhNiqJbRdVj7dar2M7rpDdJ7Syroh/8rGpyBf8FMVv
	FAc/Uy0tK7+h/k6zMvpDnkE8NrSEEy4azPS647nPfEhS8IsmES4Lz0al5TX0OQCD
	pLEmHjmmUh+0yoTG6SKT6duWgRL/Qo8Hh2gw8Pg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:Mw3y+Zc9E3sxYEUiHV+e60ZU9EXwx2/OYgIlNa4C1rU=:lkqzpun4LoiSUKUABp1C5C5XxcdyaLlfT6bMfQMFAOA=;
X-ME-Sender: <xms:97XDavaI7SydJR8sU3a2TeigxQLvIFoFIeqyToi1TDTPGPgGY2MtnA>
    <xme:97XDal1MytKb9WD8HvX_qQvT7YlVe2oAthPdjRIpLcD_J20Vvi2HHa1tbDtA-hWI4
    jRda8VbBBUSzBKjgC-TN17UTKcpVs2ogNXVw3bfEZuDWfwRALFKMQ0>
X-ME-Received: <xmr:97XDavUZ-MB5O7f3g2jMTXOu-ZYQ8sOVtaXFP4bSqdTI4FiE7a31irbHjgIuQY34HFTgeWpp7voIgQg_J-vqeRQ66WLegA>
X-ME-Proxy-Cause: dmFkZTEHyLvGlp+a93V4JOygbhGGqmFdP3bPV90DTR/Dfi8HQeizcaBcr/+FZrfa5qSemG
    8dvX3sKsv0LrQ5LBbWDHoCwajnKf9YtZJOodY1lfnXwy54aOOiDNSfA8MHPb9/9pEBlLq9
    Fx43JUkcJ09ZPjYBS/Id/J8Dtbut3biF/hO56baEgRl0iIb/YBPUNUGuCB+csoWt46ATVs
    Or2DO5wT7Pe535k8jyQBZkEI0GlNpkMsNb1Wxpb78O6VBsGCZ4Auh8KB7OKj0Slc3bhrYg
    ZyID+r44gPj0Pmit7MzfNBisrgrLPl/P6ffHDnyFEGYze9OiYowWDukkdjGICwcUK+8ckn
    xbzISCNDTvXXSM6PeSeVM2C1lpnWq/ef1+no65aaX/u7I7Qo/4tLA6Mjfh8zFsVbaetBOB
    I1v4sY049BPqkexsz6XUJ0gWUImKrEo5wdr8MmJEzPmnalRn6304m3qjImFA/ETinuVltE
    TYVwhmAIZy3wasFURlOlBU9H8LXC3j/pc0hna5EF63Rs/eEvkhq/zaQSmAfQRUnQxo8orI
    Hb2xxFsGh/pS/fOsBAQ5D2GW29kigjPq5f806iPRhQFK4s/XS7UYEcFUIikIiC4AwpNcOs
    5VjBfp2DIR3kxPTVzOAmT38+CyVgPWrPHpISSH0x6O9UcFTtpCtyFhHWerVw
X-ME-Proxy: <xmx:97XDavWum12-luASq-M7U9r8LxYa3bgsMKsyN_HXZ0Ev0rAvMKl3Lw>
    <xmx:97XDaucXt-QVyYSmd1LXzlNZNZ3z0u6IAbQ3n8C6s1-rq-lRCOTApg>
    <xmx:97XDaoU49EZ9-MwH78-2HMk-5U1z9OaGi_v2h6LcDpvZ-6ojNVQZsg>
    <xmx:97XDaneYMn-XPatQkZlnbICFNAhRTmHX6ay1zYOGdLRm7p8Hh2QP_Q>
    <xmx:97XDapiEDRvI5mdBjORcafVMolDqHGutCCQ6YdP2YYU9Hf7eIbvaWhxG>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Oct 2026 10:36:38 -0400 (EDT)
Message-ID: <4db70d3630cc76a86d7c388ef142af1a7699853e.camel@pbarker.dev>
Subject: Re: [PATCH v8] fetch/local: verify checksums for file:// urls
From: Paul Barker <paul@pbarker.dev>
To: Savvas Etairidis <setairidis@gmail.com>, 
	bitbake-devel@lists.openembedded.org
Cc: Jhonata Poma-Hansen <jhonata.poma@gmail.com>
Date: Mon, 05 Oct 2026 15:36:30 +0100
In-Reply-To: <20261002205054.72441-1-setairidis@gmail.com>
References: 
	<CAKJXz6ecab40e-HXeYqSNNLcMK=Prrrgytq6qiqus6pCb3vPGQ@mail.gmail.com>
	 <20261002205054.72441-1-setairidis@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 05 Oct 2026 14:36:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20296

On Fri, 2026-10-02 at 22:50 +0200, Savvas Etairidis wrote:
> [YOCTO #9993]
>=20
> A checksum given in a file:// url (e.g. UNINATIVE_CHECKSUM when
> UNINATIVE_URL points at a local file://) was never verified, because
> Local disables the donestamp and so verify_checksum() was never called.
> Enable the donestamp for file:// urls that carry a checksum.
>=20
> Based on a patch by Jhonata Poma-Hansen.
>=20
> AI-Generated: Uses Claude Code (Claude Opus 5.5)
> Signed-off-by: Savvas Etairidis <setairidis@gmail.com>
>=20
> ---
> changes in v8:
> - Dropped the local-checksums stamps and re-used the regular donestamp,
>   enabled only for file:// urls with a checksum. local.py is unchanged
>   again.
> - Tests reduced to a checksum match and a mismatch test.
> - Tested with BB_SKIP_NETTESTS=3Dyes bin/bitbake-selftest bb.tests.fetch
>=20
> changes in v7:
> - We shouldn't assume that anything coming from a file:// URL is
>   "typically small", or that it is on fast local storage (it could be on =
a
>   HDD array accessed over NFS).
> * Rework the code to avoid re-hashing the file on every fetch, and
>   instead only re-hash it when the checksum is actually expected to be ve=
rified.
> - You don't need to mention this if it didn't result in actual change.
> * Wont do in the future.
> - Such as? This is a completely different approach so it's useful to know
>   which bits of feedback were actually relevant and which were made
>   obsolete by the change in approach.
> * Hoped I did better this time.
> - What does "edited with an old mtime" mean?
> * In that test the file attributes are modified to have an old mtime,
>   which is a corner case that was not handled correctly before.
>   This test was removed in v6 because the new approach doesn't have
>   that issue anymore.
> - Why complicate this by using different hash algorithms for the differen=
t
>   tests?
>   The test wants to cover the case where we have a valid md5sum but an
>   invalid sha256sum or a invalid md5sum but a valid sha256sum.
> - Added a test to covern new functionality.
>=20
> changes in v6:
> - Rebased on top of master
> - Fixed issues reported by reviewer
> - Check the file directly in Local.verify_donestamp(), via a new
>   FetchData.verify_checksum_if_expected() helper, instead of enabling
>   the donestamp. Fixes stale checksums for files edited with an old
>   mtime and DL_DIR stamp/lock path collisions
> - Drop the rename_bad_checksum() refactor, no longer needed
> - Document the cost of re-hashing on every fetch
> - Tests: use a correct md5sum and a wrong sha256sum in the mismatch
>   test, add a test for a file edited with an old mtime, and check that
>   nothing is written to DL_DIR
> - Tested with BB_SKIP_NETTESTS=3Dyes bin/bitbake-selftest bb.tests.fetch
>=20
> changes in v5:
> - Rebased on top of master, added changelog entry
>=20
> changes in v4:
> - Rebased on top of master
>=20
> changes in v3:
> - Cherry-picked the patch from Jhonata Poma-Hansen
>=20
> ---
> ---
>  lib/bb/fetch/__init__.py | 16 ++++++++++++++++
>  lib/bb/tests/fetch.py    | 30 ++++++++++++++++++++++++++++++
>  2 files changed, 46 insertions(+)
>=20
> diff --git a/lib/bb/fetch/__init__.py b/lib/bb/fetch/__init__.py
> index eb3483a48..6401ce1b8 100644
> --- a/lib/bb/fetch/__init__.py
> +++ b/lib/bb/fetch/__init__.py
> @@ -1087,6 +1087,10 @@ def rename_bad_checksum(ud, suffix, localpath=3DNo=
ne):
>      if ud.localpath is None:
>          return
> =20
> +    # A file:// url refers to the user's own file, leave it in place
> +    if isinstance(ud.method, local.Local):
> +        return

Adding special cases in the base fetcher code is poor design and
complicates maintenance. Why have you taken this approach instead of
making rename_bad_checksum() a method of the Fetch class and overriding
it as you did in v4 of this patch? I'm looking for an explanation not a
v9 patch.

Best regards,

--=20
Paul Barker


