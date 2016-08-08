Return-Path: <jeremy.rosen@smile.fr>
X-Greylist: delayed 482 seconds by postgrey-1.34 at layers.openembedded.org;
	Mon, 08 Aug 2016 11:32:26 UTC
Received: from idris.smile.fr (idris.smile.fr [91.216.209.19])
	by mail.openembedded.org (Postfix) with ESMTP id D54CB77123
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  8 Aug 2016 11:32:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by idris.smile.fr (Postfix) with ESMTP id 5C91F1EE0A8C
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  8 Aug 2016 13:24:24 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at smile.fr
Received: from idris.smile.fr ([127.0.0.1])
	by localhost (bluemind-mta.prod.vitry.intranet [127.0.0.1])
	(amavisd-new, port 10024)
	with ESMTP id aPVJNTkx-2QD for <bitbake-devel@lists.openembedded.org>; 
	Mon,  8 Aug 2016 13:24:24 +0200 (CEST)
Received: from [10.5.19.62] (bob75-2-81-56-46-209.fbx.proxad.net
	[81.56.46.209])
	by idris.smile.fr (Postfix) with ESMTPSA id 387501EE0A8A
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  8 Aug 2016 13:24:24 +0200 (CEST)
To: bitbake-devel@lists.openembedded.org
References: <1470645281559.73326@axis.com>
	<1470650127.8166.40.camel@linuxfoundation.org>
From: =?UTF-8?B?SsOpcsOpbXkgUm9zZW4=?= <jeremy.rosen@smile.fr>
Message-ID: <7a284480-47ae-674c-3073-5680e626f769@smile.fr>
Date: Mon, 8 Aug 2016 13:24:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
	Firefox/45.0 Icedove/45.2.0
MIME-Version: 1.0
In-Reply-To: <1470650127.8166.40.camel@linuxfoundation.org>
Subject: Re: [PATCH] BB_NO_NETWORK: Fallback to local source for git lsremote
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
X-List-Received-Date: Mon, 08 Aug 2016 11:32:29 -0000
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit


On 08/08/2016 11:55, Richard Purdie wrote:
> On Mon, 2016-08-08 at 08:34 +0000, Tobias Hagelborn wrote:
>> Change made to enable building offline also with git tag references
>> in SRC_URI.
>>
>> If BB_NO_NETWORK is set, fallback to search for tags and revisions
>> in local DL_DIR / GITDIR in order to avoid network access.
> I'm not sure I agree with this since you'd get different build results
> depending on whether BB_NO_NETWORK is set or not.
>
> I think if BB_NO_NETWORK is set, its reasonable to assume that the
> configuration should be locked down and that BB_NO_NETWORK should not
> have other side effects like this.
>
> It would also make it very hard to detect unlocked configurations
> during testing which currently are quite easily identified.

To be honest, this is a real world problem I have on a regular basis...

The problem we have is that our customers want to keep an archive for 
(very) long term support and they test offline mode.

This problem means that we have to set all our SRC_URI to git SHA 
instead of the much more readable and easy to check git tags.


you think to assume that a reference is a branch, but the real-life 
problem is when reference is a tag. Tag don't move so this is
a case of locked configuration, but i'm not sure how to handle it.

Is there a way to have the best of both world somehow ?

Regards
Jérémy Rosen

> Cheers,
>
> Richard


