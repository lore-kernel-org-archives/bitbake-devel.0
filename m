Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1TTtGl-00065t-IQ for bitbake-devel@lists.openembedded.org;
	Thu, 01 Nov 2012 12:49:07 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id qA1BZT9E007686;
	Thu, 1 Nov 2012 11:35:29 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 15524-05; Thu,  1 Nov 2012 11:35:25 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id qA1BZKvG007678
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 1 Nov 2012 11:35:21 GMT
Message-ID: <1351769719.6502.16.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Bue Petersen <bue@praqma.net>
Date: Thu, 01 Nov 2012 11:35:19 +0000
In-Reply-To: <CAJB+B4Xwq+O6pPr34ufVQ0Jnpis1gfxbVAyWWF+5eLin8CQ_-Q@mail.gmail.com>
References: <CAJB+B4Xwq+O6pPr34ufVQ0Jnpis1gfxbVAyWWF+5eLin8CQ_-Q@mail.gmail.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: SDK install path and versioning
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 01 Nov 2012 11:49:07 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2012-10-30 at 08:50 +0100, Bue Petersen wrote:
> We are using bitbake + openembedded to build a custom linux platform
> with an image and a SDK for Qt development.
> I have some questions on how to achive some goals regarding automated
> testing. Really hope you can help.

Firstly, you'd probably get more help with questions like these on the
openembedded-core mailing list as these are questions about the
metadata, not the bitbake tool itself.

> 1) how can we "stamp" a version number in the image? I found
> IMAGE_BASENAME for changing the filename, but I would like also to
> leave some kind of version number that can be checked on the running
> system. What is best practice there?

Have a look at adding some kind of rootfs postinstall function e.g.:

ROOTFS_POSTPROCESS_COMMAND += "rootfs_update_timestamp ; "

(see image.bbclass and core-image.bbclass for examples of those)

> 2) Regarding the SDK I would like to install it on a custom path. The
> normal setup is system-wide on /usr/local/ as I can see. I need to be
> able to install several at different locations. Maybee even just in
> the workspace where we develop the Qt-application so I always know
> exactly which is used for the test. I found the SDKPATH and
> SDKNATIVEPATH to change this, but do we really need to set the exact
> path at build time?

This was a newly added feature in the recent danny release branch. The
SDK is now wrapped in a script which asks you for the location to
extract to so the binaries support relocation now. You need to use danny
or master to have this functionality available.

Cheers,

Richard



