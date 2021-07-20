Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
 by mx.groups.io with SMTP id smtpd.web10.6201.1626780259403617126
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 20 Jul 2021 04:24:19 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bootlin.com, ip: 217.70.183.200, mailfrom: alexandre.belloni@bootlin.com)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
	by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 5E6D42000C;
	Tue, 20 Jul 2021 11:24:17 +0000 (UTC)
Date: Tue, 20 Jul 2021 13:24:17 +0200
From: "Alexandre Belloni" <alexandre.belloni@bootlin.com>
To: eduardo.sousa2@pt.bosch.com
Cc: "bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] recipe-sysroot doesn't contain kernel patch
Message-ID: <YPayYZn1bvwrM4Ye@piout.net>
References: <AS8PR10MB490146E348FA167DA01C2471E1E29@AS8PR10MB4901.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
In-Reply-To: <AS8PR10MB490146E348FA167DA01C2471E1E29@AS8PR10MB4901.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi,

On 20/07/2021 11:17:52+0000, Sousa Eduardo (XC-CI2/ESD52) via lists.openembedded.org wrote:
> Hello,
> 
> I’m currently developing a custom yocto layer in AGL and did a kernel patch to contain IFLA_CAN_TERMINATION macro in the linux/can/netlink.h file since the kernel I’m using doesn’t contain it.
> The problem is that in the output of the kernel compilation the patch was applied, but when bitbake compiles systemd it raises an error saying there is no IFLA_CAN_TERMINATION declared. Checked recipe-sysroot and it isn’t patched.
> What can be the source of the problem?
> 

The recipe providing the kernel headers to the libc is
linux-libc-headers, not the kernel recipe.

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
