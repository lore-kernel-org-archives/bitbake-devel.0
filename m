Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BAD0C83000
	for <webhook@archiver.kernel.org>; Mon, 30 Jun 2025 07:42:47 +0000 (UTC)
Received: from relay15.mail.gandi.net (relay15.mail.gandi.net [217.70.178.235])
 by mx.groups.io with SMTP id smtpd.web10.33853.1751269361631732068
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 30 Jun 2025 00:42:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=lNTgVmp4;
 spf=pass (domain: bootlin.com, ip: 217.70.178.235, mailfrom: antonin.godard@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 66EC6442B8;
	Mon, 30 Jun 2025 07:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1751269359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jqE1S1wZM2XZV/FFFmJHLNJvHlwwUK4lFUgg6M3OXlI=;
	b=lNTgVmp4QjjFpeyJ41d1LXTnGIlfzq1Sb/DTysZq60LT6E328kfbr9cFd93aPT7jo0Hdli
	p0myK+WSmfotOqqyWEIBBGTAu8YqUjNak/+euWUrq+nvsvlRCypDzOMmAnxkeXMhtjTxnY
	FaARPpZYI2eLcTzEOYd/Q2rF+RqHqooIu4hhgeafvDceszJxwjeU3DUr9IHkiFNfptlBdy
	7DybKexIG6GICtBDf6QiUhGrFYkbKtKiQTeN4q8Ag/OLGwWuCGHMDgfFyq3vDnWb38euKQ
	zqE5CqF4sLlaJ58UoB27AMCZtAk90jsG04QK0kYGz279NmdXw4c2YGuMX08r+w==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 30 Jun 2025 09:42:39 +0200
Message-Id: <DAZP6D0RAN17.9KSXN8XWORHR@bootlin.com>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: <richard.purdie@linuxfoundation.org>,
 <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH] utils: Refactor filemode variable
 conversion to a function
References: <20250627091604.3275870-1-richard.purdie@linuxfoundation.org>
In-Reply-To: <20250627091604.3275870-1-richard.purdie@linuxfoundation.org>
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduuddufecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucenucfjughrpegggfgtfffkhffvufhfjgesthhqredttddtjeenucfhrhhomhepfdetnhhtohhnihhnucfiohgurghrugdfuceorghnthhonhhinhdrghhouggrrhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeehheeuffelhfeujedvgfejfefhjedtueeuveehgfeivdehleeiheeludefgedttdenucffohhmrghinhepohhpvghnvghmsggvugguvggurdhorhhgpdhuthhilhhsrdhtohdphihotghtohhprhhojhgvtghtrdhorhhgpdgsohhothhlihhnrdgtohhmnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemfegtkedumegvsggrjeemudgskegsmegrhegtleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemfegtkedumegvsggrjeemudgskegsmegrhegtledphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomheprghnthhonhhinhdrghhouggrrhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheprhhitghhrghrugdrphhurhguihgvsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepsghithgsr
 ghkvgdquggvvhgvlheslhhishhtshdrohhpvghnvghmsggvugguvggurdhorhhg
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 30 Jun 2025 07:42:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17724

Hi Richard,

On Fri Jun 27, 2025 at 11:16 AM CEST, Richard Purdie via lists.openembedded=
.org wrote:
> We have other places in the code where we need to take filemode/mask
> information from a bitbake variable and turn it into a real python
> number. Turn this internal code into public API in bb.utils and
> add some tests for it.
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  bin/bitbake-worker    |  7 ++-----
>  lib/bb/tests/utils.py | 11 +++++++++++
>  lib/bb/utils.py       | 10 ++++++++++
>  3 files changed, 23 insertions(+), 5 deletions(-)
>
> diff --git a/bin/bitbake-worker b/bin/bitbake-worker
> index 35fa1ab62be..9f33195176f 100755
> --- a/bin/bitbake-worker
> +++ b/bin/bitbake-worker
> @@ -182,11 +182,8 @@ def fork_off_task(cfg, data, databuilder, workerdata=
, extraconfigdata, runtask):
>      elif workerdata["umask"]:
>          umask =3D workerdata["umask"]
>      if umask:
> -        # umask might come in as a number or text string..
> -        try:
> -             umask =3D int(umask, 8)
> -        except TypeError:
> -             pass
> +        # Convert to a python numeric value as it could be a string
> +        bb.utils.to_filemode(umask)
> =20
>      dry_run =3D cfg.dry_run or runtask['dry_run']
> =20
> diff --git a/lib/bb/tests/utils.py b/lib/bb/tests/utils.py
> index 48e61dfcea0..52b7bf85bf4 100644
> --- a/lib/bb/tests/utils.py
> +++ b/lib/bb/tests/utils.py
> @@ -692,3 +692,14 @@ class EnvironmentTests(unittest.TestCase):
>          self.assertIn("A", os.environ)
>          self.assertEqual(os.environ["A"], "this is A")
>          self.assertNotIn("B", os.environ)
> +
> +class FilemodeTests(unittest.TestCase):
> +    def test_filemode_convert(self):
> +        self.assertEqual(0o775, bb.utils.to_filemode("0o775"))
> +        self.assertEqual(0o775, bb.utils.to_filemode(0o775))
> +        self.assertEqual(0o775, bb.utils.to_filemode("775"))
> +        with self.assertRaises(ValueError):
> +            bb.utils.to_filemode("xyz")
> +        with self.assertRaises(ValueError):
> +            bb.utils.to_filemode("999")
> +
> diff --git a/lib/bb/utils.py b/lib/bb/utils.py
> index a2806fd360d..01f7cf81f46 100644
> --- a/lib/bb/utils.py
> +++ b/lib/bb/utils.py
> @@ -1211,6 +1211,16 @@ def which(path, item, direction =3D 0, history =3D=
 False, executable=3DFalse):
>          return "", hist
>      return ""
> =20
> +def to_filemode(input):
> +    """
> +    Take a bitbake variable contents defining a file mode and return
> +    the proper python representation of the number
> +    """

It could be nice to keep the same format as the other functions in this fil=
e:
explicit the arguments and the return value.

> +    # umask might come in as a number or text string..
> +    if type(input) is int:
> +        return input
> +    return int(input, 8)
> +
>  @contextmanager
>  def umask(new_mask):
>      """

I think this triggered a wall of errors of the autobuilder:
https://autobuilder.yoctoproject.org/valkyrie/#/builders/29/builds/1910

Locally I also reproduced the issue:

ERROR: Task (/data/yoctoproject/ws/repos/openembedded-core/meta/recipes-bsp=
/efivar/efivar_39.bb:do_recipe_qa) failed with exit code '1'

If I drop this commit (and the two others on OE-Core that use to_filemode),
then re-run it becomes successful again. Cleaning the sstate of the recipe
then, and re-introducing your commit only, triggers the error. I don't have=
 any
log to show because I think the issue happens before do_recipe_qa is run.

Antonin

--=20
Antonin Godard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


