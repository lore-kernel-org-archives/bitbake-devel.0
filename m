Return-Path: <anders@chargestorm.se>
Received: from stoexhubfe02.domain01.net (STOEXHUBFE02.domain01.net
	[83.145.59.141])
	by mail.openembedded.org (Postfix) with ESMTP id 5F77265DC9
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 14 Apr 2014 07:33:23 +0000 (UTC)
Received: from ad.chargestorm.se (37.250.232.98) by stoexhubfe02.domain01.net
	(10.12.10.7) with Microsoft SMTP Server (TLS) id 8.3.279.1;
	Mon, 14 Apr 2014 09:33:22 +0200
Date: Mon, 14 Apr 2014 09:33:20 +0200
From: Anders Darander <anders@chargestorm.se>
To: Daniel Lazzari <dlazzari@leapfrog.com>, <g@ad.chargestorm.se>
Message-ID: <20140414073318.GA20694@ad.chargestorm.se>
References: <E7A9054A5ACABE48B0E540E46E862B0F0139F49EB2@NAEMMAIL01.na.leapfrog.com>
MIME-Version: 1.0
In-Reply-To: <E7A9054A5ACABE48B0E540E46E862B0F0139F49EB2@NAEMMAIL01.na.leapfrog.com>
X-Accept-Language: sv, en, de
X-GPG-Fingerprint: 5AF0 B2E9 78FE 9D75 D110  6F8F 3E31 84D7 920E 938C
X-GPG-Key-Id: 0x920E938C
X-GPG-Keyserver: hkp://keys.gnupg.net
Organization: ChargeStorm AB
User-Agent: Mutt/1.5.23 (2014-03-12)
X-GFI-SMTP-Submission: 1
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: Can't clone password protected git repo
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 14 Apr 2014 07:33:27 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

Hi,

* Daniel Lazzari <dlazzari@leapfrog.com> [140414 01:19]:
> There's a project we are trying to pull from a private BitBucket repo. I tried
> setting the SRC_URI to something like:
> SRC_URI = "git://user:pass@bitbucket.org/path/project;protocol=https"

> but bitbake hangs waiting for the password. Am I missing something? I'm stuck
> on the ancient bitbake 1.15.2 in case this has been fixed in a later release.

Maybe not the answer you're looking for. When I'm using private repos, I
use ssh keys for authentication, which works without any issues with
bitbake.

If you need a buildserver to access the private repos, I'd guess that
using ssh-agent together with keys with an empty passphrase will be just
as secure as adding the password to the SRC_URI.

Cheers,
Anders

-- 
Anders Darander
ChargeStorm AB / eStorm AB

