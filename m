Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
 by mx.groups.io with SMTP id smtpd.web10.1495.1619193846790868436
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 23 Apr 2021 09:04:07 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bootlin.com, ip: 217.70.183.194, mailfrom: michael.opdenacker@bootlin.com)
X-Originating-IP: 92.150.42.106
Received: from [10.0.0.12] (lfbn-mar-1-834-106.w92-150.abo.wanadoo.fr [92.150.42.106])
	(Authenticated sender: michael.opdenacker@bootlin.com)
	by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id C27004000B;
	Fri, 23 Apr 2021 16:04:04 +0000 (UTC)
Subject: Re: [docs] [PATCH 2/2] doc: bitbake-user-manual: code insertion simplification over two lines
To: docs@lists.yoctoproject.org,
 BitBake developer list <bitbake-devel@lists.openembedded.org>
References: <20210423155859.338408-1-michael.opdenacker@bootlin.com>
 <167887F42F1ED7F7.27757@lists.yoctoproject.org>
From: "Michael Opdenacker" <michael.opdenacker@bootlin.com>
Organization: Bootlin
Message-ID: <abf966ee-0ec9-dad0-b0b6-92321345a5bd@bootlin.com>
Date: Fri, 23 Apr 2021 18:04:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <167887F42F1ED7F7.27757@lists.yoctoproject.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US


On 4/23/21 5:58 PM, Michael Opdenacker wrote:
> This simplifies paragraphs ending with a colon and followed
> by code insertion.
>
> Automatically substituted through the command:
> sed -i -z "s/:\n\s*::/::/g" file.rst
>
> This generates identical HTML output.
>
> Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>


Oops, just realized after sending that I forgot to copy
bitbake-devel@lists.openembedded.org.

I'm resending to both lists...

Apologies for the noise.

Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

