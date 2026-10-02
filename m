Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 684C0CA5FD9
	for <webhook@archiver.kernel.org>; Fri,  2 Oct 2026 08:50:50 +0000 (UTC)
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6985.1790931048786016090
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 02 Oct 2026 01:50:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm3 header.b=d+/B0jLI;
 dkim=pass header.i=@messagingengine.com header.s=fm1 header.b=w+6O27pm;
 spf=pass (domain: pbarker.dev, ip: 202.12.124.155, mailfrom: paul@pbarker.dev)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F2BD67A0179
	for <bitbake-devel@lists.openembedded.org>; Fri,  2 Oct 2026 04:50:47 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 02 Oct 2026 04:50:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1790931047;
	 x=1791017447; bh=E+K1+i03xhb6pxEwT2PqERUoPeXntX9dI4080drKOmg=; b=
	d+/B0jLIIVLY6ndRGSSIhd+Wsl6BbA+VVlXnu+lbSLy4SAxMtSFwoetDtXy6AFfH
	0/Yf6KXvZUY/Ukd3NrE3H1ZImbjpXnWWNA1i3Uy9OxzukHdTD88p6F7Nuf8CDTuQ
	1KfaYXnO9J3sfHjaKeWFbaamu8/3d+J0H8VRzLvrSsS9adkdov8Ydo27eiErKgm3
	7+Y4eL8CHR7A4h63yE4yBmbAdS4GwBMsvXsCh4RUHZSwhcD3CZRq25JgAStL7Ow1
	69MzlwX8T8sMHGUX3QH8s6K2DaVaYMn3rGunMJfDHfXXIJoCRkg41qDRQ/+lru9m
	nujCR900WFrwgsUPZ8E+UQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790931047; x=
	1791017447; bh=E+K1+i03xhb6pxEwT2PqERUoPeXntX9dI4080drKOmg=; b=w
	+6O27pmfE4DNFyOgvXkmgrfwqTU5RAG/EkWBpLZ1AAh7lFXs/BGE5LHdJBzmG4ec
	3NPn1DC6CagdLIcoDqqKQ4ZEVazvphQJeXq2t8wNza9KZ6MKQQpnePuwogtZP9NR
	haCTH4Ok6qlDQ3s24eAwRIh8IbgKPe5MwfJ6xVKyZYX/MMzhng2xynrqQVrgk+ti
	clmNKIouAk+8TtWSpmnyZ6udItoURRE8bFH7mT6M51p653kdqLvSu94cB04h1q05
	KAQcJSjCbuVBJ++SMGaJdtZ9WOiMTVWop9yDRaDl0omhXxHgk9l0S45gbF4ZlvuH
	qUD2CT7skq000+1V9v2QQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pbarker.dev a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790931047; d=pbarker.dev;
	mf=PHBhdWxAcGJhcmtlci5kZXY+;
	rt=PGJpdGJha2UtZGV2ZWxAbGlzdHMub3BlbmVtYmVkZGVkLm9yZz4=;
	s=fm3:rsa-sha256:bBxThjgacYYQ9VzztF9TO6E5A5TSh5qQplpGumcgGMviwlj
	KfFWkkiJxH3q7Rt3y4Ach5ks7XuhO6aE1pTovFloaMDGOM2wIxOQjK7HWxp1JQB8
	2mdIeqwR0dDecYXAp2U16gqp1uyj2FUbSshgoE4hexHbOn5iUGwyF+xEtu5cN2Ee
	EJ8CEzNCyU2NClCXH2077OEJ93XxgqM/miaYmhL1WP2YJhH/zgsHRA1Dv1nu7sDi
	e2Yg+BzgAMNDH3JjltefyRkq0IRgWfAr+f57YJHLPK8xwN108G4oeTmbHXczKjIj
	XHK2i7MnnOyRDpMinV52YFX2caXFE56ksAUd7jw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:7LAk8lYB4VXUKNNQP/WNa/D3567O3Mq0T/Qdsr9+yzg=:nIfFjV5s1rtpBhBG27P1h3fsWTKcJN6ufEfNZgNoVzQ=;
X-ME-Sender: <xms:Z3C_aqz54CA50qqnYIu-NOYA0ePCGeMwxe2zYA0fIkruI_rqmos0UA>
    <xme:Z3C_atvNfCQ87fi67WOJfiUXPJkmW5XTYznR0hEM0AHITFG9c5YcQDIhIxTHCL9BV
    ovinA3WTEkuh8s54goHSoN9iJMHjgqBME2VLJsgBKPulggGX3igoKnM>
X-ME-Received: <xmr:Z3C_aptweI4dsO3318bo4lgluMVB7yhwjSx7cD7RE7KrO9tZybZowcoFoi9eQlkCA10>
X-ME-Proxy-Cause: dmFkZTECx+KvrBGjG4uANtaP4WHe6wkcawmcXxFjUjpXN1xQm1ZG0IGCnB+91XYZG+vWkI
    9NtVW2tZTd7Gw54vYAM/aD+bL1TVzv4i4sW3Y55NE/QE55B0Q5safB3Wrc+it4rG9Q+jBP
    HAiSBX/cCmbIbZPGKvxRTqPp4Uf+jziwY40KqPD97reSaJFMek3K6vvfWzMTEHodX5SA51
    xMWa0yQzcz1L9yAllXu4TFfTnxF8UPTjLn9GczYOSmqQMsCLLRPs6zPQZdIqyysIocXuyb
    S/mZGolKQWd+k/8zbLDicuKRD4r+Ftm10qp6N/zUXsztYyn74SDQ591mDJnQYjjaL7aRZA
    kXlONSBUam8oNG9RNoe5xpLV+blTyHcBpX98HhDEHaQV/ezS8co8A6Fy9Xph4Vg61+1mBF
    6y6dfhBvRA2aAvYuCWnP6QZ1pBq2rmBSiINb/a41dopD8jML85guPyncY+ZMWra2eg/6h1
    9PYTL0p/MvPs9iMLpmDrCLSVLyxby5NF9j2Ai4znqiTVjhYpOJIAw5z2JEw6f6Hud2KvCU
    MQGkxhT+H9ui1Qen2/qG0FsNXZFwA0XceU5AIpUPvb25Mjjg5qqf41yB4g3WJr/BwfVfMD
    zAwZbtqFF/mVo13gByI2MZAhFs77GT/3NEN3gmN1LmGGCsbpkqVxBH+tqC7g
X-ME-Proxy: <xmx:Z3C_aqO3IQAuq8qRdu2RuBg5DR1dbVPPW-_vBliqG-4MNMSLlVS3mg>
    <xmx:Z3C_av0d_Wf3zI4p5OIEUZdvc4XGEfmjgd2aokMIR0coVtHXHbkiXw>
    <xmx:Z3C_auOThMX3YliKCqcNReS3uPovWFcJ_wlFC5Jy4l0i6EGHiRgIzg>
    <xmx:Z3C_an3zZ9PVv-rQH5aP9kV1FEyiTRnJKZ81JW6kYDIf3oF7SuenvQ>
    <xmx:Z3C_atbl-yuWxAL5QgEw52Sj_WvhYLN5uMsHzzKDgZTIeQges4ZA6PYI>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Oct 2026 04:50:46 -0400 (EDT)
Message-ID: <5ca946b125e9eb46bde8e236c4a04eaa06ff45af.camel@pbarker.dev>
Subject: Re: [PATCH v7] fetch/local: verify checksums for file:// urls
From: Paul Barker <paul@pbarker.dev>
To: Savvas Etairidis <setairidis@gmail.com>, 
	bitbake-devel@lists.openembedded.org
Cc: Jhonata Poma-Hansen <jhonata.poma@gmail.com>
Date: Fri, 02 Oct 2026 09:50:41 +0100
In-Reply-To: <20261001205344.99638-1-setairidis@gmail.com>
References: <abf12d51916cac8780914605168243c54494ca32.camel@pbarker.dev>
	 <20261001205344.99638-1-setairidis@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 02 Oct 2026 08:50:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20289

On Thu, 2026-10-01 at 22:53 +0200, Savvas Etairidis wrote:
> [YOCTO #9993]
>=20
> A checksum given in a file:// url (e.g. UNINATIVE_CHECKSUM when
> UNINATIVE_URL points at a local file://) was never verified, because
> Local disables the donestamp and so verify_checksum() was never called.
> Override verify_donestamp() in Local to check the file against those
> checksums. A mismatch raises ChecksumError before the rename/mirror
> handling, so the user's file is never renamed.
>=20
> Based on a patch by Jhonata Poma-Hansen.
>=20
> AI-Generated: Uses Claude Code (Claude Opus 5.5)
> Signed-off-by: Savvas Etairidis <setairidis@gmail.com>
>=20
> ---
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

This is now inventing a new stamp file mechanism, and the tests are
significantly more complicated than they were in the previous version of
the patch. I'm sorry to say that this is moving further away from a
solution that we can merge, instead of closer to one.

This should look like the other fetchers and use the existing done
stamps mechanism. That may not be able to detect changes in files if the
mtime is moved backwards, but the local filesystem is not a security
boundary so this is probably ok. It's also better to get something in
place and document the limitations in the bugzilla entry rather than
continuing to iterate and add complexity.

There is also no need to test with different hash algorithms here. Two
simple test cases, one for a matching checksum and one for a mismatch,
should be enough, and they should use the same hash algorithm for
consistency. The different hash algorithms should be tested in separate
unit tests that focus on those features. AI tools really get carried
away when adding test cases and some judgement is definitely needed to
keep them under control.

Best regards,

--=20
Paul Barker


