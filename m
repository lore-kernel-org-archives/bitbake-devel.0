Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B74F5CA1017
	for <webhook@archiver.kernel.org>; Sun,  7 Sep 2025 18:22:16 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.web11.1271.1757269330825678903
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 07 Sep 2025 11:22:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=C2CsgViL;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 08AF61A0996;
	Sun,  7 Sep 2025 18:22:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C6C3A6061A;
	Sun,  7 Sep 2025 18:22:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A839D102F2491;
	Sun,  7 Sep 2025 20:22:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757269326; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=uKmX96Y6D1hmIAEt265maUNxAsn57YjAScghOHVb/Qs=;
	b=C2CsgViL/90o9OX+W6uxqiS6n7kUS4IdiGiQk5CakcDMYZ4W87Fh8g1VMb9rn9d+XBoupv
	sG0ONgdUc/RpHPqoEg4sSnSuh1/M35AEmksAcVhOCwq+iWEbfMVakBQMZU2gO6cpJYCgN5
	G8+AnB4jvwMV7GZI66AvnNCJ2tff5q0tNFvvgYcHKxzr1pmLcTzYKwplwRkt7Nprrr3Arh
	wClKFoPPVek7qbdwKwL1NZRuoPa6d63I8kxKfwgsM4R8DKfVjRLE+938Jx4ojH/afkbcpT
	qxtYTM1yLZ/Wzw/R7X2tzujrCtWDvZxJThvOzXneVwErNw7rCObCZSztKrKOUg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 07 Sep 2025 20:22:01 +0200
Message-Id: <DCMRZHLSPIC9.3R5OW2CDQ4LNH@bootlin.com>
Cc: "Stefan Herbrechtsmeier" <stefan.herbrechtsmeier@weidmueller.com>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: <stefan.herbrechtsmeier-oss@weidmueller.com>,
 <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [RFC PATCH v2 0/7] fetch2: add support for
 implicit urls
X-Mailer: aerc 0.19.0-0-gadd9e15e475d
References: <20250905064419.2589111-1-stefan.herbrechtsmeier-oss@weidmueller.com>
In-Reply-To: <20250905064419.2589111-1-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 07 Sep 2025 18:22:16 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17984

On Fri Sep 5, 2025 at 8:44 AM CEST, Stefan Herbrechtsmeier via lists.openem=
bedded.org wrote:
> From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
>
> The patch series add support for implicit URLs inside the fetcher. The
> implicit URLs could be defined inside a source like a version control
> system (git submodule) or a lock file (package-lock.json, cargo.lock or
> go.sum). The integration of implicit URLs beside explicit URLs
> simplifies the fetcher classes and avoid bugs because of iterations
> between the Fetch and FetchMethod classes.
>
> The series remove most methods inside the gitsm fetcher and only leaves
> the parsing of the git submodules and the unpack functionality. It
> allows the gitsm fetcher to use the premirror only feature. The current
> implementation leads to problems because the download of the git
> submodules is triggered via the download method which is called deeply
> inside the fetcher code.
>
> Changes in v2:
> - Move test case for gitsm local paths into FetcherLocalTest class
> - Remove implicit urls from localpaths
> - Add commit to test the expanded_urldata function
> - Fix UnboundLocalError of urldata in expand_urldata function
> - Remove implicit URLs from localpaths for backward compatibility
>
> Stefan Herbrechtsmeier (7):
>   tests: fetch: add test case for gitsm implicit local paths
>   tests: fetch: add test cases for expanded_urldata
>   fetch2: rename u to url in Fetch class
>   fetch2: call functions within loops of Fetch class
>   fetch2: add helper to get urldata in Fetch class
>   fetch2: add support for implicit urls
>   fetch2: gitsm: use implicit urls feature
>
>  lib/bb/fetch2/__init__.py | 127 +++++++++++++++++++++++++++-----------
>  lib/bb/fetch2/gitsm.py    |  46 ++------------
>  lib/bb/tests/fetch.py     |  59 ++++++++++++++++++
>  3 files changed, 154 insertions(+), 78 deletions(-)

Thanks,

I took a bit of time to test this new version, no issue on the
autobuilder.

Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


