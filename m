Received: from bsmtp.bon.at (bsmtp.bon.at [213.33.87.14])
 by mx.groups.io with SMTP id smtpd.web10.4334.1619426597840176020
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 26 Apr 2021 01:43:18 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: streamunlimited.com, ip: 213.33.87.14, mailfrom: quentin.schulz@streamunlimited.com)
Received: from qschulz (vpn.streamunlimited.com [91.114.0.140])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 4FTJM72Dnqz5tlC;
	Mon, 26 Apr 2021 10:43:15 +0200 (CEST)
Date: Mon, 26 Apr 2021 10:43:13 +0200
From: "Quentin Schulz" <quentin.schulz@streamunlimited.com>
To: Michael Opdenacker <michael.opdenacker@bootlin.com>
Cc: bitbake-devel@lists.openembedded.org, docs@lists.yoctoproject.org
Subject: Re: [docs] [PATCH v2] README: update/fix contribution guidelines
Message-ID: <20210426084313.v3ulmf3xk7euu2lm@qschulz>
References: <16788A2044914AF0.27757@lists.openembedded.org>
 <20210423175429.340205-1-michael.opdenacker@bootlin.com>
MIME-Version: 1.0
In-Reply-To: <20210423175429.340205-1-michael.opdenacker@bootlin.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Michael,

On Fri, Apr 23, 2021 at 07:54:29PM +0200, Michael Opdenacker wrote:
> - Ask to CC the docs@lists.yoctoproject.org mailing list
> - doc/README: fix the command to generate the manual
> 

Usually, when you have to make a list in a commit log of things you did,
it's telling you that there should be multiple commits. Here you two
changes are not related.

Anyway, that's just me picking nits, I wouldn't have replied if it wasn't
to give my

Reviewed-by: Quentin Schulz <foss@0leil.net>

Thanks,
Quentin
