Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B8DFC61DCD
	for <webhook@archiver.kernel.org>; Fri, 28 Aug 2026 05:52:02 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.347.1787896313684704601
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 27 Aug 2026 22:51:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=c0sJRHdk;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 707511A1896
	for <bitbake-devel@lists.openembedded.org>; Fri, 28 Aug 2026 05:51:51 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3855B60537;
	Fri, 28 Aug 2026 05:51:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F3CB211C78082;
	Fri, 28 Aug 2026 07:51:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787896306; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=T0gJpv3nCvy3SetQRhSBrKpCGY2lHri38KcYe71F0Ek=;
	b=c0sJRHdksyY+hbMW+aP0O5epfTk6j9L3l6rdd9q/cGrSfdHVnw1aOFtdKT5ERUl4SUh1iS
	OnEWXE8oraa/7FTGURa95C2HLFX+rFZU8mhgvb/JhN6d0QRlfBgsKBrkm6eF7B8Uae3f0j
	+w/PiOnKMP1LkXHXf4nv0mdPidhC+QxHRNaLkZLW4gUXBnHhvkIXaP2eb9V6qfeUIj7N4z
	lw1DM4DbsUOUrrYeylfBaE+cyJNO/4iduv6oeaEIrGGsJrWXKu1jDbWs12S2i8U1Cgxx6u
	357pEuHVVaYfu40BHtM4Wv6AxLq0qaam5+KNPy638d8cllqymOyh0OT6VPoXTg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 28 Aug 2026 07:51:43 +0200
Message-Id: <DL0CCF115T08.227YUHOXXHLP3@bootlin.com>
Subject: Re: [docs] [PATCH 1/4] lib: rename fetch2 as fetch; invert compat
 shim to make bb.fetch2 = bb.fetch
Cc: <docs@lists.yoctoproject.org>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: <chris.laplante@agilent.com>, <bitbake-devel@lists.openembedded.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260827142958.547182-1-chris.laplante@agilent.com>
In-Reply-To: <20260827142958.547182-1-chris.laplante@agilent.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 28 Aug 2026 05:52:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20099

On Thu Aug 27, 2026 at 4:29 PM CEST, Chris Laplante via lists.yoctoproject.=
org wrote:
> From: Chris Laplante <chris.laplante@agilent.com>
>
> bb.fetch2 replaced bb.fetch back in 2012, and the compatibility shim of
> bb.fetch =3D bb.fetch2 has been in place ever since. There's no longer a
> good reason to keep the '2' suffix, so lets drop it.
>
> We also invert the bb.fetch =3D bb.fetch2 compatibility shim to now make
> bb.fetch2 =3D bb.fetch. We do this by creating a new lib/bb/fetch2.py,
> which lets us get rid of the ugly-ish shim in lib/bb/__init__.py.
> Finally, we add a deprecation warning for good measure.
>
> Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
> ---

Hi Chris,

I suspect some renaming is missing on the oecore side. We have this
error on all builds:

Running '. ./init-build-env; bitbake world -k' with output to /srv/pokybuil=
d/yocto-worker/qemux86-world-alt/build/build/command-1-build-targets.log in=
 /srv/pokybuild/yocto-worker/qemux86-world-alt/build/build
ERROR: Execution of event handler 'check_sanity_eventhandler' failed
Traceback (most recent call last):
  File "/srv/pokybuild/yocto-worker/qemux86-world-alt/build/layers/openembe=
dded-core/meta/classes-global/sanity.bbclass", line 169, in check_sanity_ev=
enthandler
    oe.sanity.check_sanity(sanity_data)
    ~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^
  File "/srv/pokybuild/yocto-worker/qemux86-world-alt/build/layers/openembe=
dded-core/meta/lib/oe/sanity.py", line 1007, in check_sanity
    check_sanity_everybuild(status, sanity_data)
    ~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^
  File "/srv/pokybuild/yocto-worker/qemux86-world-alt/build/layers/openembe=
dded-core/meta/lib/oe/sanity.py", line 890, in check_sanity_everybuild
    decoded =3D bb.fetch2.decodeurl(pattern)
              ^^^^^^^^^
AttributeError: module 'bb' has no attribute 'fetch2'. Did you mean: 'fetch=
'?

https://autobuilder.yoctoproject.org/valkyrie/#/builders/17/builds/4359

Can you have a look at the issue?

Thanks,
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


