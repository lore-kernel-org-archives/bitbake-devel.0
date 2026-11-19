Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11153.1795081858248231422
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 19 Nov 2026 01:50:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm2 header.b=dtNnO6tR;
 dkim=pass header.i=@messagingengine.com header.s=fm3 header.b=2T7ryNuU;
 spf=pass (domain: pbarker.dev, ip: 103.168.172.149, mailfrom: paul@pbarker.dev)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 38A45EC05A1
	for <bitbake-devel@lists.openembedded.org>; Thu, 19 Nov 2026 04:50:57 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 19 Nov 2026 04:50:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1795081857;
	 x=1795168257; bh=F+MeMEE+YVpchVcwY/CoacoR4lqrl0V/PJoIuocqM/k=; b=
	dtNnO6tR8g7CT7AgJEnjTO4/jXrxaOIwRVzHL72+YQfoAsA6lcFibkGtWs1m4PWU
	SJR5iXlOxrx/ljpnS9PKOgNEE3Q1w+/6hZ8uTqp3tausJ7ldefHj9TodRWWbX57J
	+3rDbvZheHYNCH8m86uSFWlnIT197FXYjtdKRpzbeiAcarRx+4tt/WLkBh759kGt
	wVFrmdkTRrWt6bcKBvAn8T2GGodJv1+lQohLR9hb/k1g54548uGN1FPsjkpr55LK
	4PQ6EzqGL0KBxPBpRMaRS4BPmhRqDOPPsLhX4Jmdin8200ylEr/L5KDk2aepjPld
	uzJX0mmCNZwXP6bIGrseLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795081857; x=
	1795168257; bh=F+MeMEE+YVpchVcwY/CoacoR4lqrl0V/PJoIuocqM/k=; b=2
	T7ryNuUu1a8DuhzLDQYm+R6W9Ib3BdBfwT35ag3MOmE8uPTP0Y87dxPeiorkVn03
	MJ0+KxFKcv2U+oJwfPSOmTw3fUKM+WLIf8584/fFndYwHOASQT4mUXc6vGOPKoxV
	PXDKl7hXLtAtAgm9O4ZpELuG7ATczKPzFh+8cbTCpF5phADmx381G6+On4GSOJD+
	bqw4m3qF5wGXw3vn7gr9ruZk9vpiq03mQ6GEjdmdrpT9fRJ4uSKeHy+ODiOMqrEe
	uQfzYiug4+m/RhcIC1M2CuOVCOd5SCr5NGTwpJwDPgHuYTEZtAo9cXlp2IZxxJ6X
	B11fE5gI/q+KOmA52U0PA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pbarker.dev a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795081857; d=pbarker.dev;
	mf=PHBhdWxAcGJhcmtlci5kZXY+;
	rt=PGJpdGJha2UtZGV2ZWxAbGlzdHMub3BlbmVtYmVkZGVkLm9yZz4=;
	s=fm2:rsa-sha256:PYE4X7YOLQRJQpatFwoSAH4Yc5fVY+vmDks1CUVdl8v+GtF
	LmD5qtCOyIuC9oFYiDngvgXBkZUMtY2CAG9k+YYAKtp2RpoWDtVPYAPLnwL5vbAL
	4hEML5gddcVSFJPkyT9xyzvpaWBj7VDAo8t0DSzjFQiBEkdArwPBRvh2JKOIsDwg
	X2dSETjcRmqrM8F8PPc4HINzmpx8u7sLWfV3aGSWgVIBH7Ci3bEjEdzf4Ed9r1W/
	RFFxPuLm58xqhQxD6vlYSj8k0rU33uj4Duj0p1ddg9oUx8FKEoM5rUwgFlXQqS7p
	5xirc2NGyPqdmVtc6v0rYbgZz84dKcVaJXXlJqQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:SKYJ8RmP7yZ7Xrpv4yS9DnVCdNCzidKKZL1sLfg8+ok=:z2dpEBTVmL7fqsLVeYr3F3tX9Srg/OFxkcXTjoEvfFE=;
X-ME-Sender: <xms:gMb-asIuC2KNb3bfzAIRFsz1VSQclCR_1heKUCqKvMOp8_c21U7Uug>
    <xme:gMb-ajAbyjzx4zAGHIQ8O2JJ9DDuSBEkMpyo8wOQVfMfG93h10JkUBBaqgb2lLrNF
    q_Z6w7OtlWMoJT16xfNko93PmX5GqAfsTXUfpS-QNzIy3a_P52MjVzK>
X-ME-Received: <xmr:gMb-alBGzcl3zII5PRb6LMrk2fqaOczAzms7Cx2kXnF0N-cjFYEhfMTMRBU7Q1XV6rnN2vmzmlRCU7dYXc_rKXPRwpXB>
X-ME-Proxy-Cause: dmFkZTEhFx9nKbi00gao3guR9L3ziZ0ocuHj592sjG60IF4NeeARvy84LVxZyAw0MD9DZc
    pCbAc6C65nvwWqWpSdUYkv+g3iiRd1Qs+0V72Z45Tz3/aEA1q1Reochowtbgf2EGIz2tja
    8g/h0Mtmpe2O8nVN0MSZwRHfAFNM8Ifc2eP6BuLyWNefnzUvy0Lp6eSvY4paVxX0lkjcvK
    9cuh4cIR5G3mCL95Slpf5RtzEGEKeSZxRKjSMS9/R98sYGUhdDbdAaa9AJOZTkQGAhuqH+
    vBaWLYWXkUCtzsmYP3U83/li6NLuxN8uKVyRY0r4PZ0jn472taHO5HJCv4+lol3ckB+CWi
    NWf7c76Q7CdSFqA3KTXYzG7A3ACm9E5WSm2/LizaVR02b4jUYC2vyn336w1qlEDkhCmNqV
    fUZQgolGpVuB9VV47DMeBCw/Uq11H7qCooYXjFi2YDGXvHv1tY3fA0hiHDLc4eLn0kaske
    BHUcxetAmfFjzXhNTTmWHaQtEIlaAqXatxP2xCZsAeVd9SQhzN+Cs/04IcoDUOe66Q3QRc
    vICfRzBcjsEde21MT+9rNjZSmyyOjcdbbEG/5ZzGvpl03P4A1VZUSJ20A/hUgT98Wy4tNY
    gsdsiLglhSBcesdtuIE+KZcsWgPc44CNgjhmQawPVtieYIvsZ1qvh/LtbIwQ
X-ME-Proxy: <xmx:gMb-alD68xB7eL2O3bxs8uWIKMtvmQ9nmmOKIHxhqRXLzZoonftyjg>
    <xmx:gMb-agoxm8EL3N5Sm12MOmIQj42ywIB3TIghsw8MhNqmxNm5k32e-w>
    <xmx:gMb-avk2V8JqalkkjXppS4YUsfdyuJPiCKHKK4iRRT3dwvIQuts-iQ>
    <xmx:gMb-agxmSwy0Ku32UkZgsclFk_rCoj9WaohjZWIvU7dYmoL5RvaeRA>
    <xmx:gcb-arTCKzwzImyyt_GCiABvouK1M3D9rG38RloxXiQxNugl2luEMvNu>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Nov 2026 04:50:56 -0500 (EST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Nov 2026 09:50:54 +0000
Message-Id: <DMZ3ERL47CEB.3KE9TOG6YIZPD@pbarker.dev>
Cc: "Joshua Watt" <JPEWhacker@gmail.com>, "Alexander Kanavin"
 <alex.kanavin@gmail.com>, "Stefan Herbrechtsmeier"
 <stefan.herbrechtsmeier@weidmueller.com>
Subject: Re: [PATCH 0/2] fetch: package identity of crate, gomod and npm
 URLs
From: "Paul Barker" <paul@pbarker.dev>
To: "Stefano Tondo" <stondo@gmail.com>,
 <bitbake-devel@lists.openembedded.org>
X-Mailer: aerc 0.22.0
References: <20261118092831.201831-1-stondo@gmail.com>
In-Reply-To: <20261118092831.201831-1-stondo@gmail.com>
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Thu, 19 Nov 2026 09:51:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20460

On Wed Nov 18, 2026 at 9:28 AM GMT, Stefano Tondo wrote:
> Hi,
>
> This series adds the fetcher API from the RFC "spdx30: name, version
> and purl for dependency downloads" [1]. Richard asked for a fetcher
> API that returns structured data with the purl, so that OE-Core does
> not read fetcher internals.
>
> Patch 1 adds FetchMethod.package_identity(). It returns the name, the
> version and the purl of the downloaded package, or None. It uses only
> the URL and the datastore, so it works before the fetch and without
> network access.
>
> Patch 2 implements it for the crate, gomod, gomodgit and npm fetchers,
> with unit tests.
>
> The RFC also covered the downloads that gitsm and npmsw add by
> themselves. That part is not in this series. Richard and Alexander
> prefer to list those downloads in SRC_URI. I will send that change
> for npm in a separate series.
>
> An OE-Core series that uses the API follows on the OE-Core list.
>
> [1] https://lore.kernel.org/openembedded-core/20261105122145.543282-1-sto=
ndo@gmail.com/

Hi Stefano,

I can't speak for Richard but to me this looks like it's moving in the
right direction.

As the OE-Core changes rely on package_identity() returning a dict with
name, version and purl, I think we should instead make the data
structure more explicit and enforcible.

Perhaps a dataclass in bb.fetch, then package_identity() can return an
instance of this dataclass?

Something like:

    @dataclass
    class PackageIdentity:
        name: str
        version: str
        purl: str

Best regards,

--=20
Paul Barker

