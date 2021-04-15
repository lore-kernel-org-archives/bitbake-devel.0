Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
 by mx.groups.io with SMTP id smtpd.web11.7980.1618497422096659105
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 15 Apr 2021 07:37:02 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bootlin.com, ip: 217.70.183.194, mailfrom: michael.opdenacker@bootlin.com)
X-Originating-IP: 92.150.42.106
Received: from [10.0.0.10] (lfbn-mar-1-834-106.w92-150.abo.wanadoo.fr [92.150.42.106])
	(Authenticated sender: michael.opdenacker@bootlin.com)
	by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 1740140002;
	Thu, 15 Apr 2021 14:36:59 +0000 (UTC)
Subject: Re: [bitbake-devel] [PATCH 0/2] Doc tweaks for 1.50
To: Paul Eggleton <paul.eggleton@linux.microsoft.com>,
 bitbake-devel@lists.openembedded.org
References: <cover.1618364983.git.paul.eggleton@linux.microsoft.com>
From: "Michael Opdenacker" <michael.opdenacker@bootlin.com>
Organization: Bootlin
Message-ID: <0c1d1d8f-df02-51ec-7c32-13be873c6781@bootlin.com>
Date: Thu, 15 Apr 2021 16:36:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <cover.1618364983.git.paul.eggleton@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US


On 4/14/21 4:00 AM, Paul Eggleton wrote:
> A couple of documentation fixes relating to the BitBake 1.50 release.
>
>
> The following changes since commit e70b925ba98fd4fedf3940d141a4210c953087ca:
>
>   bitbake: Update version to 1.50.0 stable release series (2021-04-09 14:19:54 +0100)
>
> are available in the git repository at:
>
>   git://git.openembedded.org/bitbake-contrib paule/doc-git-pw
>   http://cgit.openembedded.org/bitbake-contrib/log/?h=paule/doc-git-pw
>
> Paul Eggleton (2):
>   bitbake-user-manual: document no support for using passwords in git
>     URLs
>   bitbake-user-manual: add REQUIRED_VERSION and adjust PREFERRED_VERSION
>     entry
>
>  .../bitbake-user-manual-fetching.rst                   |  9 +++++++++
>  .../bitbake-user-manual-ref-variables.rst              | 18 ++++++++++++++++--


For both...

Reviewed-by: Michael Opdenacker <michael.opdenacker@bootlin.com>

Thanks,

Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

