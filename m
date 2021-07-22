Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
 by mx.groups.io with SMTP id smtpd.web12.5334.1626944139186350035
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 22 Jul 2021 01:55:39 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bootlin.com, ip: 217.70.183.193, mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id C532F240018;
	Thu, 22 Jul 2021 08:55:36 +0000 (UTC)
Cc: YP docs mailing list <docs@lists.yoctoproject.org>
To: BitBake developer list <bitbake-devel@lists.openembedded.org>
From: "Michael Opdenacker" <michael.opdenacker@bootlin.com>
Subject: DEFAULT_PREFERENCE no longer used?
Organization: Bootlin
Message-ID: <53a7dab9-2c9c-ce0b-b363-543c33959e62@bootlin.com>
Date: Thu, 22 Jul 2021 10:55:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US

Greetings,

Looking at the code, it seems that the DEFAULT_PREFERENCE variable is no
longer in use. Unless I missed something, the variable is still read,
but not taken into account any more, and there are just two recipes that
set it.

The BitBake documentation still refers to it though.

May I propose documentation and code patches to remove it for good?

Cheers
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

