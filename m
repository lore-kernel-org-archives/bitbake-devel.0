Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E872CA1002
	for <webhook@archiver.kernel.org>; Thu,  4 Sep 2025 09:59:39 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.web10.35467.1756979973826458681
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 04 Sep 2025 02:59:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=SYgwad+2;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 36EE04E40C75
	for <bitbake-devel@lists.openembedded.org>; Thu,  4 Sep 2025 09:59:32 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 111A5606BB;
	Thu,  4 Sep 2025 09:59:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 92D651C22DD68;
	Thu,  4 Sep 2025 11:59:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1756979971; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=PdEgWX0AewzMTuYi/Vt2S1J2Yk5JqtAO0Z6ZPh/rYXQ=;
	b=SYgwad+2Na+PsnpHR02n9jNoYQ9YU4hpwee9r4qdyx2+InJMz1QVxlG3PmhFbZQ4ZPy/QC
	pA1NxRrSWl5NBxMeTZzcjrvhbH3w/GJu2UZq4zZMdu7bBe7h8bgCoO0TWjmXpeB2eAN8e8
	zJd1ykM05aJc6cxpeO1KYTSKSbwa+RqQbiNwzIFo8uXfGQT1wo9VbNSH6W7M3neVWCJnkI
	Y/2rG30vd84fG07MMhLKLcpVM+HJi8wURpTju5LptzzyypSKvellOu/sQ1K21snAUkykXe
	6OdzNzxdReWQQ8ukekCuv9QN1z+hrWWXSU1nMAgnEuWK2ObnShw6Ox6DW7Owcw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Sep 2025 11:59:30 +0200
Message-Id: <DCJXF3HI42NB.34PICRHH011PC@bootlin.com>
Subject: Re: [bitbake-devel] [PATCH] doc: improve BitBake README testing
 instructions
Cc: <docs@lists.yoctoproject.org>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: <mohamedaymanworkspace2@gmail.com>,
 <bitbake-devel@lists.openembedded.org>
References: <20250818163337.3440-1-mohamedaymanworkspace2@gmail.com>
In-Reply-To: <20250818163337.3440-1-mohamedaymanworkspace2@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 04 Sep 2025 09:59:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17955

Hi,

On Mon Aug 18, 2025 at 6:33 PM CEST, Mohamed Ayman via lists.openembedded.o=
rg wrote:
> Clarified the testing section by:
> - Adding context on setting PATH before running selftests
> - Documenting how to install pytest using pip
> - Providing an example command for running pytest on lib/bb/tests
>
> These additions make it easier for new contributors to run the
> testsuite and ensure consistent testing practices.
>
> Signed-off-by: Mohamed Ayman <mohamedaymanworkspace2@gmail.com>
> ---
>  bitbake/README | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/bitbake/README b/bitbake/README
> index e9f4c858ee..938eec47ce 100644
> --- a/bitbake/README
> +++ b/bitbake/README
> @@ -54,10 +54,17 @@ The assumption is made that this testsuite is run fro=
m an initialized OpenEmbedd
>  environment (i.e. `source oe-init-build-env` is used). If this is not th=
e case, run the
>  testsuite as follows:
>
> +# ensure local tools are on PATH and run the selftest script

This should probably be aligned to "export PATH=3D$(pwd)/bin:$PATH" below?

    # ensure local tools are on PATH and run the selftest script
    export PATH=3D$(pwd)/bin:$PATH
    bin/bitbake-selftest

>      export PATH=3D$(pwd)/bin:$PATH
>      bin/bitbake-selftest
>
>  The testsuite can alternatively be executed using pytest, e.g. obtained =
from PyPI (in this
>  case, the PATH is configured automatically):
>
> +# install pytest into a virtualenv or pipx (recommended)
> +python -m pip install --user pytest
> +
> +# run tests (example)
> +python -m pytest lib/bb/tests -q

Same comment as the one above.

Otherwise, how does this differ from simply running "pytest"?

I tried this and it gave:

   $ python -m pytest lib/bb/tests -q

   no tests ran in 0.10s

I'm not sure this does anything?

Instead running for example "python -m pytest lib/bb/tests/color.py" works,=
 so
if the intent was to showcase how to run tests separately, I would rather
showcase an example like this.

Antonin

--
Antonin Godard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

