Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A26ACEACEF
	for <webhook@archiver.kernel.org>; Mon, 17 Nov 2025 12:08:53 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7715.1763381327888082991
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 17 Nov 2025 04:08:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=lH/x7IQV;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 7AB95C12654
	for <bitbake-devel@lists.openembedded.org>; Mon, 17 Nov 2025 12:08:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 864DF606B9;
	Mon, 17 Nov 2025 12:08:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E06E11037183E;
	Mon, 17 Nov 2025 13:08:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763381325; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=0L0OpgI6K8rb3IwgVlgTgOyS/pBZLzW5R9MDPHn9yow=;
	b=lH/x7IQVr4ypZozTH7g5eUNJIVeGlwFqjmkE6/LzBMIrEXTRuVQtxzCTDbTYmgexMMSlrl
	KbdP9nF0+5s3gWQatpv5iwOlPEwFIb0KOauyRo9e8e8vaqm5zdPklMTolsR08VXAbolqYl
	u3iRZCmeyekw8oTsya1rVKfdTU6R53OnaRY3OhGRFuteJnVSdzCO0CJQoEGJesHFDDir4N
	56/4F/HgB4DTqNRo1H+ts0ewKgEY2fhUvOO8FAdDxj+v65PuV33oIQEECwmXKETGYL7LU5
	2/63uj7o1LR6gTX+Wg3Ud9Nkp6PQm1bheNkhzrwXMUa9Zd0GOxDnVf4WEyBSmA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 17 Nov 2025 13:08:43 +0100
Message-Id: <DEAYICIFFDWO.3R8QEGO7FSMBV@bootlin.com>
Subject: Re: [docs] [PATCH 2/2] bitbake-selftest: setup: add test for
 --update-bb-conf=no
Cc: "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>,
 <docs@lists.yoctoproject.org>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: <antonin.godard@bootlin.com>, <bitbake-devel@lists.openembedded.org>
X-Mailer: aerc 0.19.0-0-gadd9e15e475d
References: <20251114-bitbake-setup-conf-updates-v1-0-990583d8251b@bootlin.com> <20251114-bitbake-setup-conf-updates-v1-2-990583d8251b@bootlin.com>
In-Reply-To: <20251114-bitbake-setup-conf-updates-v1-2-990583d8251b@bootlin.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 17 Nov 2025 12:08:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18424

On Fri Nov 14, 2025 at 5:44 PM CET, Antonin Godard via lists.yoctoproject.o=
rg wrote:
> We want to check that with --update-bb-conf set to 'no' our BitBake
> configuration remains unchanged. For this create a list of checksums of
> the files in conf/ and compare before/after bitbake-setup update
> --update-bb-conf=3Dno.
>
> Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
> ---
>  lib/bb/tests/setup.py | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>
> diff --git a/lib/bb/tests/setup.py b/lib/bb/tests/setup.py
> index 58049c8c7a..b4258f0492 100644
> --- a/lib/bb/tests/setup.py
> +++ b/lib/bb/tests/setup.py
> @@ -6,6 +6,8 @@
> =20
>  from bb.tests.fetch import FetcherTest
>  import json
> +import hashlib
> +import glob
> =20
>  class BitbakeSetupTest(FetcherTest):
>      def setUp(self):
> @@ -360,3 +362,36 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
>                  self.assertIn("Existing bitbake configuration directory =
renamed to {}/build/conf-backup.".format(setuppath), out[0])
>                  self.assertIn('-{}+{}'.format(prev_test_file_content, te=
st_file_content), out[0])
>              self.check_setupdir_files(setuppath, test_file_content)
> +
> +        # do the same as the previous test, but now without updating the=
 bitbake configuration (--update-bb-conf=3Dno)
> +        # and check that files have not been modified
> +
> +        def _conf_chksum(confdir: str) -> list:
> +            sums =3D []
> +            for f in glob.glob(f'{confdir}/*'):
> +                if not os.path.islink(f):
> +                    with open(f, 'rb') as fd:
> +                        sum =3D os.path.basename(f) + '_' + hashlib.file=
_digest(fd, "sha256").hexdigest()

Hi Antonin,

hashlib.file_digest was added in python 3.11, so this is failing on some
supported distros:

Traceback (most recent call last):
  File "/srv/pokybuild/yocto-worker/oe-selftest-debian/build/layers/bitbake=
/lib/bb/tests/setup.py", line 393, in test_setup
    sums_before =3D _conf_chksum(f"{setuppath}/build/conf")
  File "/srv/pokybuild/yocto-worker/oe-selftest-debian/build/layers/bitbake=
/lib/bb/tests/setup.py", line 373, in _conf_chksum
    sum =3D os.path.basename(f) + '_' + hashlib.file_digest(fd, "sha256").h=
exdigest()
AttributeError: module 'hashlib' has no attribute 'file_digest'

https://autobuilder.yoctoproject.org/valkyrie/#/builders/35/builds/2707

Can you find some alternative?

Thanks,
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


