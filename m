Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E477CD98E4
	for <webhook@archiver.kernel.org>; Tue, 16 Jun 2026 14:40:09 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.155904.1781620799987618236
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 16 Jun 2026 07:40:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=hMirb3JU;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id B7B8F1A3959;
	Tue, 16 Jun 2026 14:39:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8B041601A9;
	Tue, 16 Jun 2026 14:39:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 39499106C9A69;
	Tue, 16 Jun 2026 16:39:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1781620797; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=c7RWmftRxp0/hWI/iEqFFzm785TZVDKp5XXuYXTrq7Y=;
	b=hMirb3JUhUmGZ3W/tUfU9boRi+mrkO/r49OxqW9Kq4Zo7WAcDUw7PEwzXWj15khzyG3/QS
	jf1mady3hR+SoP+VLfbJlzLNpETy4Fkfmw6q9f4a0VUB79uU3EoXcHygo+KOr2TTcT26LI
	pceTQ8dMoH6YhaNKnAUEzQ44LuFJj2wwEKoEK9FnBfnrjpoLf1EexJ1xlMTP8uSvYjgvw8
	cu01kDZHHJ2/uvIyiCwYW43MCxR2dDsGuL49MWxZGa0i6mk+OC502K0WE+b7KVKegkOc9n
	Ml6+Dx427idfq7l7p8/adjm84jVoMbRRfpFL673CwISsfYCXaIR8x8vmnVx0hA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Jun 2026 16:39:55 +0200
Message-Id: <DJAJV26HEHOV.88JA3ODFVZL8@bootlin.com>
Subject: Re: [bitbake-devel] [PATCH] bitbake: fetch2: make unpack_tracer
 available when fetching mirror URLs
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: <andreas.muetzel@emlix.com>, <bitbake-devel@lists.openembedded.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260616064749.36789-1-andreas.muetzel@emlix.com>
In-Reply-To: <20260616064749.36789-1-andreas.muetzel@emlix.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 16 Jun 2026 14:40:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19710

On Tue Jun 16, 2026 at 8:47 AM CEST, Andreas M=C3=BCtzel via lists.openembe=
dded.org wrote:
> When building the FetchData for fetching from mirrors, pass any
> available unpack_tracer to the newly-created object.
>
> This fixes the following error that occurs in the git fetcher's
> unpack() method when fetching repos that use git-lfs from MIRRORS
> or PREMIRRORs:
>
> AttributeError: 'FetchData' object has no attribute 'unpack_tracer'
>
> [YOCTO #15948]
>
> Signed-off-by: Andreas M=C3=BCtzel <andreas.muetzel@emlix.com>
> ---

Hi Andreas,

It looks like bitbake-selftest is now failing:

ERROR: test_mirror_of_mirror (bb.tests.fetch.MirrorUriTest.test_mirror_of_m=
irror)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/srv/pokybuild/yocto-worker/oe-selftest-debian/build/layers/bitbake=
/lib/bb/tests/fetch.py", line 552, in test_mirror_of_mirror
    uris, uds =3D bb.fetch2.build_mirroruris(fetcher, mirrors, self.d)
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/srv/pokybuild/yocto-worker/oe-selftest-debian/build/layers/bitbake=
/lib/bb/fetch2/__init__.py", line 1076, in build_mirroruris
    adduri(origud, uris, uds, mirrors, origud.mirrortarballs or [None])
  File "/srv/pokybuild/yocto-worker/oe-selftest-debian/build/layers/bitbake=
/lib/bb/fetch2/__init__.py", line 1059, in adduri
    if ud.unpack_tracer:
       ^^^^^^^^^^^^^^^^
AttributeError: 'FetchData' object has no attribute 'unpack_tracer'

https://autobuilder.yoctoproject.org/valkyrie/#/builders/23/builds/4130
https://autobuilder.yoctoproject.org/valkyrie/#/builders/35/builds/4052
https://autobuilder.yoctoproject.org/valkyrie/#/builders/48/builds/3902

Can you have a look at the issue?

Thanks,
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


