Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39237CD4851
	for <webhook@archiver.kernel.org>; Fri, 15 May 2026 11:12:32 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.32597.1778843550760592881
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 15 May 2026 04:12:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=CbsfKXlq;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id DFA42C2B9C3
	for <bitbake-devel@lists.openembedded.org>; Fri, 15 May 2026 11:13:19 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 66331606FD;
	Fri, 15 May 2026 11:12:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CF6DB11AF8528;
	Fri, 15 May 2026 13:12:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778843547; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=15rzfNVGJMbZ34I+LPuWzZ6VdQEEW0oy85ad/SVUikY=;
	b=CbsfKXlqqwfd/oFvTV7ZegF09LFJmFYuSAti4OyL/8z7qRYtsTV53uDJStCXaqZy2g1nQh
	lgAW6C05gA/GpBWmTZQZvGbpug9mAmiNQO9OsMYi38LtnJ0Yqpq2JlVYxnOgs4d4rUi70e
	IV/tLK5oAsXKxqBGu0HG/4mbN212+BFGYIURj+07cj5qjQ1uEe9br94MnCPWIrMm+sAiqZ
	n0X/70rVTTGJfY0VTwNMnC8rV5u6hWnk+5BpeDhPyziDU82ioQoQACgvWEaVtHpo/DJHVY
	voaOmn5o96YkQnKi+GTtrmMOLIWV7purYJtRaE4njUy4sW1qyLIMzpWPdwKVrw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 15 May 2026 13:12:26 +0200
Message-Id: <DIJ7EROQQXAI.3RDRH6003P8C3@bootlin.com>
Subject: Re: [bitbake-devel] [PATCH v2] fetch2/crate: support configurable
 registry and index URLs
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: <ms98.cho@gmail.com>, <bitbake-devel@lists.openembedded.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260514051143.67992-1-ms98.cho@gmail.com>
 <20260514200526.98596-1-ms98.cho@gmail.com>
In-Reply-To: <20260514200526.98596-1-ms98.cho@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 15 May 2026 11:12:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19528

On Thu May 14, 2026 at 10:05 PM CEST, minsung.cho via lists.openembedded.or=
g wrote:
> The crate fetcher previously hardcoded the crates.io download URL and
> only supported a fixed /crate/versions API shape for custom registries.
> This prevented recipes from using private registries or mirrors with
> different download paths or Cargo sparse indexes.
>
> Add BB_CRATE_REGISTRY_URL[host] and BB_CRATE_INDEX_URL[host] templates
> with {crate}, {version}, and {index_path} placeholders. Keep the
> existing crates.io defaults, allow custom API-style version endpoints,
> and mark sparse indexes explicitly so latest-version checks parse Cargo
> index NDJSON instead of JSON API responses.
>
> Add non-network tests for default crates.io URLs, custom registry
> templates, sparse index paths, trailing slash handling, and both
> latest-version parser paths. Also make the fetch test cleanup chmod
> invocation portable by placing -R before the mode.
>
> [YOCTO #16276]
>
> Signed-off-by: minsung.cho <ms98.cho@gmail.com>
> ---

Hi,

Thanks for your patch.

I note it does conflict with some other patches currently in testing,
and once these conflicts solved, I get some bitbake-selftest errors:

ERROR: test_crate_fetches_from_local_sparse_registry (bb.tests.fetch.CrateT=
est.test_crate_fetches_from_local_sparse_registry)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/srv/pokybuild/yocto-worker/oe-selftest-debian/build/layers/bitbake=
/lib/bb/tests/fetch.py", line 2829, in test_crate_fetches_from_local_sparse=
_registry
    self.assertEqual(ud.method.latest_versionstring(ud, self.d),
                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/srv/pokybuild/yocto-worker/oe-selftest-debian/build/layers/bitbake=
/lib/bb/fetch2/crate.py", line 197, in latest_versionstring
    return self._latest_versionstring_from_api(ud, d)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/srv/pokybuild/yocto-worker/oe-selftest-debian/build/layers/bitbake=
/lib/bb/fetch2/crate.py", line 204, in _latest_versionstring_from_api
    versions =3D [(0, i["num"], "") for i in json_data["versions"]]
                                           ~~~~~~~~~^^^^^^^^^^^^
KeyError: 'versions'

https://autobuilder.yoctoproject.org/valkyrie/#/builders/35/builds/3864
https://autobuilder.yoctoproject.org/valkyrie/#/builders/48/builds/3727
https://autobuilder.yoctoproject.org/valkyrie/#/builders/23/builds/3960

Maybe the easiest solution is to wait a few days until said patches are
either merged or rejected, then send a refreshed version.

If you want to have a look at the current situation, here is the branch
that was used for above builds:
https://git.yoctoproject.org/poky-ci-archive/log/?h=3Dbitbake/autobuilder.y=
octoproject.org/valkyrie/a-full-3832

Thanks,
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


