Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B08B2EDB7ED
	for <webhook@archiver.kernel.org>; Tue,  7 Apr 2026 10:25:13 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.78220.1775557508956884124
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 07 Apr 2026 03:25:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=ZA6b472G;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 096C24E4293A
	for <bitbake-devel@lists.openembedded.org>; Tue,  7 Apr 2026 10:25:07 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CD8BC603C7;
	Tue,  7 Apr 2026 10:25:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8DE1D1045017D;
	Tue,  7 Apr 2026 12:25:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1775557506; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=OoZXHp690ry0jM0/8VQ1taVoVrSf5fgnVuUNqigoLL0=;
	b=ZA6b472GF6mrHAw47DQ0awAqyHiwPxC036GN0Yn7aSgfQzGR8OI4oF0/bMM2vadR7V9Q6Z
	4Fc1n+PH0cIfh2L/sjjdiKTLDhoY32xGeWcBylNL3gJvmozTtyCnB5T3dh8yMHteLK4hCJ
	ci3tPOC0+O5vO2taJIHQBMey5kSBPkUm4XiiXLOWLn5cmUeZsi8CuU8PwWqFGUs+UNtwIC
	RsAPhJfb3K2pINwBIjLSp3isdO8f7FT4Zxkk4kcaAkhhXeT68S1CHPYftTnePV/t0ZpPls
	KXdLJ5/D3IBJqi9FEWGHolclCua/jX9vxUq8cKvApwPWZYXW+WOF3xu9RiO6gQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 07 Apr 2026 12:25:00 +0200
Message-Id: <DHMULR3D49P4.10EX6OE4BC2CZ@bootlin.com>
Subject: Re: [bitbake-devel] [PATCH 0/8] bitbake-setup JSON Schema: Fix
 linting errors
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: <rob.woolley@windriver.com>, <bitbake-devel@lists.openembedded.org>
X-Mailer: aerc 0.19.0-0-gadd9e15e475d
References: <20260406172110.2050236-1-rob.woolley@windriver.com>
In-Reply-To: <20260406172110.2050236-1-rob.woolley@windriver.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 07 Apr 2026 10:25:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19337

On Mon Apr 6, 2026 at 7:21 PM CEST, Rob Woolley via lists.openembedded.org =
wrote:
> This series fixes some linting errors in the JSON Schema.  Problems
> were found using the https://github.com/sourcemeta/jsonschema tool.
>
> Here are the steps used to install and use the tool to lint the schemas:
>
>   python3 -m venv venv
>   source venv/bin/activate
>   pip install sourcemeta-jsonschema
>   jsonschema lint bitbake-setup.schema.json
>   jsonschema lint layers.schema.json
>
> This allowed me to use jsonschema to validate the BitBake Configuration F=
ile:
>   jsonschema validate path/to/bitbake-setup.schema.json oe-nodistro-maste=
r.conf.json
>
> There are 2 outstanding types of linting errors related to the use of hyp=
hen
> in the property names and the enum currently having only one value:
>
>   Set `properties` to identifier names that can be easily mapped to progr=
amming
>   languages (matching [A-Za-z_][A-Za-z0-9_]*) (simple_properties_identifi=
ers).
>
>   An `enum` of a single value can be expressed as `const` (enum_to_const)
>
> The former would require a larger discussion and potentially increasing t=
he
> version number. Updating the enum to include a new version would also res=
olve
> the latter error.
>
> I do not believe that the changes in this series merit increasing the ver=
sion
> of the schema.
>
> Resolving these outstanding errors is not necessary for validating the
> Bitbake Configuration files.

Hi Rob,

Thanks for you series.

It looks like some selftests are now failing:

2026-04-07 08:44:43,890 - oe-selftest - INFO - bblayers.BitbakeLayers.test_=
bitbakelayers_setup (subunit.RemotedTestCase)
2026-04-07 08:44:43,891 - oe-selftest - INFO -  ... FAIL
...
/srv/pokybuild/yocto-worker/oe-selftest-debian/build/build-st-1874443/tmp/w=
ork/x86_64-linux/python3-jsonschema-native/4.26.0/recipe-sysroot-native/usr=
/bin/jsonschema:5: DeprecationWarning: The jsonschema CLI is deprecated and=
 will be removed in a future version. Please use check-jsonschema instead, =
which can be installed from https://pypi.org/project/check-jsonschema/
  from jsonschema.cli import main
{'version': '1.0', 'sources': {'bitbake': {'git-remote': {'remotes': {'orig=
in': {'uri': 'https://git.openembedded.org/bitbake'}}, 'branch': 'master', =
'rev': 'master'}, 'path': 'bitbake'}}}: {'version': '1.0', 'sources': {'bit=
bake': {'git-remote': {'remotes': {'origin': {'uri': 'https://git.openembed=
ded.org/bitbake'}}, 'branch': 'master', 'rev': 'master'}, 'path': 'bitbake'=
}}} is not of type 'array'
...
2026-04-07 08:45:39,329 - oe-selftest - INFO - bblayers.BitbakeLayers.test_=
bitbakelayers_updatelayer (subunit.RemotedTestCase)
2026-04-07 08:45:39,331 - oe-selftest - INFO -  ... FAIL
...
2026-04-07 08:45:39,594 - oe-selftest - INFO - bblayers.BitbakeLayers.test_=
validate_bitbake_setup_default_registry (subunit.RemotedTestCase)
2026-04-07 08:45:39,594 - oe-selftest - INFO -  ... FAIL
...

2026-04-07 08:45:39,819 - oe-selftest - INFO - bblayers.BitbakeLayers.test_=
validate_examplelayersjson (subunit.RemotedTestCase)
2026-04-07 08:45:39,820 - oe-selftest - INFO -  ... FAIL

https://autobuilder.yoctoproject.org/valkyrie/#/builders/35/builds/3617
https://autobuilder.yoctoproject.org/valkyrie/#/builders/48/builds/3499

Can you have a look at the issue?

Thanks,
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


