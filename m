Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A01C83F17
	for <webhook@archiver.kernel.org>; Fri, 18 Jul 2025 11:56:02 +0000 (UTC)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
 by mx.groups.io with SMTP id smtpd.web10.19034.1752839753585669795
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 18 Jul 2025 04:55:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=Pa9vzWtf;
 spf=pass (domain: bootlin.com, ip: 217.70.183.199, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1FB1C439C0;
	Fri, 18 Jul 2025 11:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1752839752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3FPHWSf8ymw2bSb5vcHBsCXCdpgRa+7m+P+C48+mSV4=;
	b=Pa9vzWtftH97iER+TeOSeVe3oA2obfANI+xTBFO6/yiPuz5P3uaTZiX2M7wmNBwRUOcjDn
	oBmFrxUZm9/JGBdQ5NiOFf50w4ILg+i7Zz/z/CTDjrs/UWqzPddiVQZBD/iECpmiUsEQHx
	golcKimielhcuKAtcDO5Wui49m1FwVHIr0NtDjbSCaPbL7rkmcqwSqMwzeRgptNhvYwWxT
	mxtDWR+3pJcPbQ/r5zM0k4/Bt69ldRFQv+I6TIKBUxyd4tMiX37WrfzsT4oztnweaoRA1b
	lgE55t2gPIfI3YNTE9sIpsDlMTJnwwb6QRovLn5G8pnTahbOYYrARAOt7lLlUg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 18 Jul 2025 13:55:40 +0200
Message-Id: <DBF5TWDAUI52.2LTN0ZIJXJ2G6@bootlin.com>
Subject: Re: [bitbake-devel] [PATCH] fetch2/wget: Keep query parameters in
 URL during checkstatus
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: <pamathieu@poum.ca>, <bitbake-devel@lists.openembedded.org>
X-Mailer: aerc 0.19.0-0-gadd9e15e475d
References: <20250717210247.181580-1-pamathieu@poum.ca>
In-Reply-To: <20250717210247.181580-1-pamathieu@poum.ca>
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeifeeflecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucenucfjughrpegggfgtfffkuffhvffofhgjsehtqhertdertdejnecuhfhrohhmpedfofgrthhhihgvuhcuffhusghoihhsqdeurhhirghnugdfuceomhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhephfeijefhleeuheelteffvedugeekgeeiudevveevkefglefgheeuudetteeigeegnecuffhomhgrihhnpehophgvnhgvmhgsvgguuggvugdrohhrghdpshhouhhrtggvfigrrhgvrdhorhhgpdihohgtthhophhrohhjvggtthdrohhrghdpsghoohhtlhhinhdrtghomhenucfkphepvdgrtdegmegtvggttdemuddthegrmeehrggrfhemhedvleemfegriegrmeduvdduheemfhgufhegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtdegmegtvggttdemuddthegrmeehrggrfhemhedvleemfegriegrmeduvdduheemfhgufhegpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvpdhrtghpthhtohepphgrmhgrthhhihgvuhesphhouhhmrdgtrgdpr
 hgtphhtthhopegsihhtsggrkhgvqdguvghvvghlsehlihhsthhsrdhophgvnhgvmhgsvgguuggvugdrohhrgh
X-GND-Sasl: mathieu.dubois-briand@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 18 Jul 2025 11:56:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17793

On Thu Jul 17, 2025 at 11:02 PM CEST, Philippe-Alexandre Mathieu via lists.=
openembedded.org wrote:
> When recreating the uri in wget's checkstatus method, we only use the
> scheme, netloc and path. This completely strips the query parameters
> from the final URI and potentially breaks the checking functionality
> from certain fetchers.
>
> This is the case for the Azure storage fetcher, as it requires a SAS
> token that is formatted as a series of query parameters. The error
> manifests itself when using a private storage account as a PREMIRROR or
> SSTATE_MIRROR (since regular SRC_URI won't run the checkstatus).
>
> This problem is present in scarthgap, but wasn't in kirkstone.
>
> Signed-off-by: Philippe-Alexandre Mathieu <pamathieu@poum.ca>
> ---

Hi Philippe-Alexandre,

Thanks for your patch,

It looks like this is breaking bitbake selftests:

FAIL: test_wget_checkstatus (bb.tests.fetch.FetchCheckStatusTest.test_wget_=
checkstatus) (url=3D'ftp://sourceware.org/pub/libffi/libffi-1.20.tar.gz')
...
AssertionError: False is not true : URI ftp://sourceware.org/pub/libffi/lib=
ffi-1.20.tar.gz, can't check status
...
FAIL: test_wget_checkstatus_connection_cache (bb.tests.fetch.FetchCheckStat=
usTest.test_wget_checkstatus_connection_cache) (url=3D'ftp://sourceware.org=
/pub/libffi/libffi-1.20.tar.gz')

https://autobuilder.yoctoproject.org/valkyrie/#/builders/35/builds/1984
https://autobuilder.yoctoproject.org/valkyrie/#/builders/48/builds/1920
https://autobuilder.yoctoproject.org/valkyrie/#/builders/23/builds/2139

Can you have a look at these failures please?

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


