Received: from mail.hatina.eu (mail.hatina.eu [194.182.66.63])
 by mx.groups.io with SMTP id smtpd.web10.7024.1622033989345429828
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 26 May 2021 05:59:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@hatina.eu header.s=dkim header.b=tdCgL43n;
 spf=pass (domain: hatina.eu, ip: 194.182.66.63, mailfrom: peter@hatina.eu)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 832F58288B
	for <bitbake-devel@lists.openembedded.org>; Wed, 26 May 2021 14:59:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hatina.eu; s=dkim;
	t=1622033984; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding; bh=fakSYCzqp306Jfk8PLkx+/R5dUNGNvhWHYvS7Iae6FQ=;
	b=tdCgL43nr+YAYpGUdfuSrpFh7VZc7+TslTw0vLJgwM22OaGnK1E9fM6Tp6qgl8GGnpD/ME
	6IXrzftuYqsMa/i0TO25sV7PFjw2cUDH7yHziLcnZcqqsf5YNq39fx7HKqNsjpfnS2VwO1
	uyPF4k1xktzzIqI1aruMafgjRaznHQFk7Yu6Fua80WBeOvSnIUt65Fxf4NAbd07R3ODbXc
	D9PFqQuapwdJogkLuQEXmn5oVEUYLyJWHXiLUbwwQwrNo25Gzgnx8Qmxa3H7IrsXvNuUor
	pDtu3rnO4dydYcYBr+uUDLmksnPGqBzr4mwhbA0J7utiutjA30lWYqtFLJ7cog==
From: peter@hatina.eu
To: bitbake-devel@lists.openembedded.org
Subject: devtool does not apply patches from esdk
Date: Wed, 26 May 2021 14:59:43 +0200
Message-ID: <2544941.lGaqSPkdTl@xps13.hatina.eu>
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi all,

I generated and installed Extensible SDK for my core-image-minimal and would 
like to use it for kernel development. Having sourced the environment-setup-* 
script I first ran `devtool modify linux-yocto` to fetch the sources. During 
this step, I got a warning:

WARNING: SRC_URI is conditionally overridden in this recipe, thus several 
devtool-override-* branches have been created, one for each override that 
makes changes to SRC_URI. It is recommended that you make changes to the 
devtool branch first, then checkout and rebase each devtool-override-* branch 
and update any unique patches there (duplicates on those branches will be 
ignored by devtool finish/update-recipe).

Okay, I have `SRC_URI_append_mymachine = ...`.

I compared `devtool-override-*` branch (there's only one) with the target one 
5.10.21 of the kernel; and there are no modifications.

Then I ran `devtool build linux-yocto` which failed to compile the kernel, 
because all of my patches are not applied. Actually, dtb was not generated, 
since I do add a custom device tree sources by patch. I observed the directory 
`workspace/sources/linux-yocto` and found `.kernel-meta/unused.patch.queue` 
which contains all of my patches. A do_unpack_and_patch task actually does 
nothing; the log file for it is rather empty.

Can you provide me with any hint how to apply the patches and compile the 
kernel, please?

-- 
regards,
Peter Hatina


