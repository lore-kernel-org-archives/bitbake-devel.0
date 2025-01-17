Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F0E1C02185
	for <webhook@archiver.kernel.org>; Fri, 17 Jan 2025 11:01:48 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
 by mx.groups.io with SMTP id smtpd.web11.8193.1737111703365671398
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 17 Jan 2025 03:01:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=K9PlFMwC;
 spf=pass (domain: bootlin.com, ip: 217.70.183.194, mailfrom: antonin.godard@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 32A7440005;
	Fri, 17 Jan 2025 11:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1737111701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hb2H0+jeaXDgoTq7GjIxD48rgc3NQdK6MmX7BcnikZU=;
	b=K9PlFMwCm78JhzeorDN+RTh992d04QXQZ6s2C8p7uUDN26xCt/XMbfDgPb9aD0ORqvZ1h6
	jsXyuD3b4kxHDOcuPNkIRpDSw19NKGaG5GpZCQibAsUZw76QGwI4KlLdReW9qMIqb68inD
	8VI4hyw0+fTs0iA5kYEY3e5H3hV4pD1kT23tK/U+2KoJ2rQnyez3HldkO2jyxONsNLVzZB
	hWfiZZyAn+VjAHuUco02G3+NMc+JTOmpYv+OEwy3M31w4Ji2rT3xRGjf/E6/1ws2zUEr6X
	IqO0+hyZEas4qPxBVqrIrFtPlnDC76MMfsP4g539KhJmViqIGE6CSDYY4V1KGg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Jan 2025 12:01:40 +0100
Message-Id: <D74APENZ2FY4.2W3AXB39KKQ1D@bootlin.com>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: "Quentin Schulz" <foss@0leil.net>,
 <bitbake-devel@lists.openembedded.org>, <docs@lists.yoctoproject.org>
Subject: Re: [bitbake-devel] [PATCH v2] add basic support for b4
 contribution workflow
Cc: "Quentin Schulz" <quentin.schulz@cherry.de>
X-Mailer: aerc 0.18.2-100-gc2048ef30452-dirty
References: <20250117-b4-support-v2-1-7178f61d49e4@cherry.de>
In-Reply-To: <20250117-b4-support-v2-1-7178f61d49e4@cherry.de>
X-GND-Sasl: antonin.godard@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 17 Jan 2025 11:01:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17024

On Fri Jan 17, 2025 at 11:44 AM CET, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> b4[1] is a very nice tool for mail-based contribution. A config[2] file
> exists to set up a few defaults. We can use it to set the Cc recipients
> to always add, in our case the mailing list.
>
> This also adds a wrapper script that is called by b4 to figure out which
> addresses to put as Cc recipients. Considering that patches to the doc/
> directory also need to be sent to the yocto-docs mailing list, this
> wrapper handles that. A limitation of the script (lsdiff actually) is
> that it doesn't know how to handle empty files, but those should be
> of rather rare occurrences.
>
> While the wrapper script should be enough by itself to add the bitbake
> mailing list to the Cc recipients, one still needs to manually run b4
> prep --auto-to-cc for that to happen. Therefore, let's add an explicit
> send-series-cc so that at least that mailing list is always there.
>
> Because we currently do not have anything to check for patch validity,
> remove requirement for b4 prep --check to be run before sending a patch
> series, via disable-needs-checking in prep-pre-flight-checks.
>
> [1] https://pypi.org/project/b4/
> [2] https://b4.docs.kernel.org/en/latest/config.html
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
> This adds a basic config file for b4 to avoid to have to add the mailing
> list by hand.
> For documentation patches, the additional mailing list will be added
> when running b4 prep --check, as is required for each new series managed
> by b4.
>
> Note that b4 supports patchwork, c.f.
> https://b4.docs.kernel.org/en/latest/config.html#patchwork-integration-se=
ttings
> though I have no clue what it does with it as I am no maintainer, but
> maybe something worth having a look at if some maintainer of this repo
> wants to use b4 to merge stuff?

I'll add my configuration here, maybe someone or myself can add some doc fo=
r it
later, here or elsewhere.

configuration I use:

[b4]
  pw-url =3D https://patchwork.yoctoproject.org/
  pw-key =3D <redacted>
  pw-project =3D docs
  pw-review-state =3D under-review
  pw-accept-state =3D accepted
  pw-discard-state =3D rejected

For `pw-project`, it comes from the project name on patchwork, e.g.:

  https://patchwork.yoctoproject.org/project/docs/list
                                             ^^^^

The pw-key can be obtained from the user's personal settings.

Then `b4 {am,shazam}` will automatically set the state to under-review.

`b4 ty -d` will reject the patch. Sometimes I use `b4 ty --pw-set-state
superseded -d ...` when I know another version of the patch/series was sent=
.

Finally `b4 ty -a` will also set the accepted state along the generation of
thank-you file.

And overall it's much easier than clicking buttons on patchwork :)

> ---
> Changes in v2:
> - add b4-wrapper for auto-detecting patches that are to be sent to the
>   docs mailing list as well,
> - disable forced b4 prep --check for each b4-managed series,
> - Link to v1: https://lore.kernel.org/r/20240524-b4-support-v1-1-0c4334c3=
6cc7@cherry.de
> ---
>  .b4-config    |  4 ++++
>  b4-wrapper.py | 38 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 42 insertions(+)
>
> diff --git a/.b4-config b/.b4-config
> new file mode 100644
> index 0000000000000000000000000000000000000000..0b699f204c414099f2118ffdb=
c9f7b24454e4a4e
> --- /dev/null
> +++ b/.b4-config
> @@ -0,0 +1,4 @@
> +[b4]
> +  send-series-cc =3D bitbake-devel@lists.openembedded.org
> +  send-auto-cc-cmd =3D ./b4-wrapper.py send-auto-cc-cmd
> +  prep-pre-flight-checks =3D disable-needs-checking
> diff --git a/b4-wrapper.py b/b4-wrapper.py
> new file mode 100755
> index 0000000000000000000000000000000000000000..ddc2597bc0374fa5124a83be9=
4eeab52df6f38d3
> --- /dev/null
> +++ b/b4-wrapper.py
> @@ -0,0 +1,38 @@
> +#!/usr/bin/env python3
> +#
> +# This script is to be called by b4:
> +# - through b4.send-auto-cc-cmd with "send-auto-cc-cmd" as first argumen=
t,
> +#
> +# When send-auto-cc-cmd is passed:
> +#
> +#  This returns the list of Cc recipients for a patch.
> +#
> +# This script takes as stdin a patch.
> +
> +import subprocess
> +import sys
> +
> +cmd =3D sys.argv[1]
> +if cmd !=3D "send-auto-cc-cmd":
> +    sys.exit(-1)
> +
> +patch =3D sys.stdin.read()
> +
> +if subprocess.call(["which", "lsdiff"], stdout=3Dsubprocess.DEVNULL) !=
=3D 0:
> +    print("lsdiff missing from host, please install patchutils")
> +    sys.exit(-1)
> +
> +print("bitbake-devel@lists.openembedded.org")
> +
> +files =3D subprocess.check_output(["lsdiff", "--strip-match=3D1", "--str=
ip=3D1", "--include=3Ddoc/*"],
> +                                input=3Dpatch, text=3DTrue)
> +if len(files):
> +    print("docs@lists.yoctoproject.org")
> +else:
> +# Handle patches made with --no-prefix
> +    files =3D subprocess.check_output(["lsdiff", "--include=3Ddoc/*"],
> +                                    input=3Dpatch, text=3DTrue)
> +    if len(files):
> +        print("docs@lists.yoctoproject.org")
> +
> +sys.exit(0)
>
> ---
> base-commit: 0329a7e3ac694737f2d2c1861f65492551360663
> change-id: 20240524-b4-support-e9855fc54d40
>
> Best regards,

Thanks for the script Quentin!

I was thinking, for eocore we could even extend the list of cc from
meta/conf/distro/include/maintainers.inc.

Antonin

--=20
Antonin Godard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

