Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1555.1794945114798771692
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 17 Nov 2026 11:51:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=nEtX//Am;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 06FB1C4CBCE
	for <bitbake-devel@lists.openembedded.org>; Tue, 17 Nov 2026 19:51:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 79AE85FDAD;
	Tue, 17 Nov 2026 19:51:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3660911BC00A4;
	Tue, 17 Nov 2026 20:51:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794945108; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=lzLp8vKSYt/KQoh1s8WRYg1hyKMgkh9kcI5awVETSZw=;
	b=nEtX//AmW248wFN6ppXnvfDpMEHe2xcr8SSamdfdvpM/CwZD870H22WpVd9+ZPpThl9MPi
	mkoh+kMmSE7eYl96oF6mqsTghqd3LsdjNTsCmhkuwG/8XxBYCTqJQhfbyTPVSLDFAGCnoz
	xTpe4Sed8Y4yhdeEOM9cc5w7CAHESsGYl+8iRdx+VhGCdq1LrhWPMfkoy8KOZJ4XShIBiH
	lhr7VA7YOdBO0w4/j0e/QqkXRUuDJrENi0K/GOmLdXd7EASRpVXiDfYVRx75aJ9Om/wGVl
	tpjLP5G5tb+Na9QUrTi/7LCUnD2X4lchf8kiSKILtVD1mQVh+16KTKPZTB/fwQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Nov 2026 20:51:45 +0100
Message-Id: <DMXQXPZQ4YNR.3169M33L22EZ4@bootlin.com>
Subject: Re: [bitbake-devel] [PATCH] utils: Make set_context() replace the
 global context
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: <maxime.roussinbelanger@gmail.com>,
 <bitbake-devel@lists.openembedded.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20261117152318.2560775-1-maxime.roussinbelanger@gmail.com>
In-Reply-To: <20261117152318.2560775-1-maxime.roussinbelanger@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Tue, 17 Nov 2026 19:52:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20451

On Tue Nov 17, 2026 at 4:23 PM CET, Maxime Roussin-B=C3=A9langer via bitbak=
e-devel wrote:
> set_context() assigns to a local name, so the global context is never
> replaced and keeps everything added to it. This has been the case since
> commit 6c3281a14012 ("cooker/cookerdata/utils: Improve context
> management") replaced a direct assignment to bb.utils._context with it,
> which broke the two resets that rely on it:
>
> - Parser.parse() resets the context before each recipe, so a parser
>   process accumulates the Python functions of every recipe it parsed
>   before. A recipe calling a function from a class it does not inherit
>   parses or fails depending on which process it lands in.
> - CookerDataBuilder.__init__() resets the context when the
>   configuration is parsed again, so a long-lived server keeps the
>   functions and modules of the previous configuration.
>
> AI-Generated: Uses Claude Code (Claude Opus 5.5)
> Signed-off-by: Maxime Roussin-Belanger <maxime.roussinbelanger@gmail.com>
> ---

Hi Maxime,

Thanks for your patch. Yet it looks like one of the added test is
failing here:

FAIL: test_set_context_drops_methods (bb.tests.utils.ContextTests.test_set_=
context_drops_methods)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/srv/pokybuild/yocto-worker/oe-selftest-fedora/build/layers/bitbake=
/lib/bb/tests/utils.py", line 752, in test_set_context_drops_methods
    self.assertNotIn("testfunc", bb.utils.get_context())
    ~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
AssertionError: 'testfunc' unexpectedly found in {...}

https://autobuilder.yoctoproject.org/valkyrie/#/builders/48/builds/5093
https://autobuilder.yoctoproject.org/valkyrie/#/builders/35/builds/5285

Can you have a look at the issue?

Thanks,
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

