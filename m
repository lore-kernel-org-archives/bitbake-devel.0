Return-Path: <jeremy.rosen@smile.fr>
Received: from idris.smile.fr (idris.smile.fr [91.216.209.19])
	by mail.openembedded.org (Postfix) with ESMTP id 0217F7718C
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  8 Aug 2016 15:58:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by idris.smile.fr (Postfix) with ESMTP id B1A1B1EE0945;
	Mon,  8 Aug 2016 17:58:40 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at smile.fr
Received: from idris.smile.fr ([127.0.0.1])
	by localhost (bluemind-mta.prod.vitry.intranet [127.0.0.1])
	(amavisd-new, port 10024)
	with ESMTP id YDRTguHYXa61; Mon,  8 Aug 2016 17:58:40 +0200 (CEST)
Received: from [10.5.19.62] (unknown [193.56.60.161])
	by idris.smile.fr (Postfix) with ESMTPSA id 76FED1EE04B0;
	Mon,  8 Aug 2016 17:58:40 +0200 (CEST)
To: Khem Raj <raj.khem@gmail.com>
References: <1470645281559.73326@axis.com>
	<1470650127.8166.40.camel@linuxfoundation.org>
	<7a284480-47ae-674c-3073-5680e626f769@smile.fr>
	<C61ACEF2-94CC-4609-91F5-D9139A779926@gmail.com>
From: =?UTF-8?B?SsOpcsOpbXkgUm9zZW4=?= <jeremy.rosen@smile.fr>
Message-ID: <1e5eb678-4e4f-837b-3ee7-f982affde91f@smile.fr>
Date: Mon, 8 Aug 2016 17:58:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
	Firefox/45.0 Icedove/45.2.0
MIME-Version: 1.0
In-Reply-To: <C61ACEF2-94CC-4609-91F5-D9139A779926@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
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
X-List-Received-Date: Mon, 08 Aug 2016 15:58:43 -0000
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit



On 08/08/2016 17:35, Khem Raj wrote:
>> On Aug 8, 2016, at 4:24 AM, Jérémy Rosen <jeremy.rosen@smile.fr> wrote:
>>
>>
>> On 08/08/2016 11:55, Richard Purdie wrote:
>>> On Mon, 2016-08-08 at 08:34 +0000, Tobias Hagelborn wrote:
>>>> Change made to enable building offline also with git tag references
>>>> in SRC_URI.
>>>>
>>>> If BB_NO_NETWORK is set, fallback to search for tags and revisions
>>>> in local DL_DIR / GITDIR in order to avoid network access.
>>> I'm not sure I agree with this since you'd get different build results
>>> depending on whether BB_NO_NETWORK is set or not.
>>>
>>> I think if BB_NO_NETWORK is set, its reasonable to assume that the
>>> configuration should be locked down and that BB_NO_NETWORK should not
>>> have other side effects like this.
>>>
>>> It would also make it very hard to detect unlocked configurations
>>> during testing which currently are quite easily identified.
>> To be honest, this is a real world problem I have on a regular basis...
>>
>> The problem we have is that our customers want to keep an archive for (very) long term support and they test offline mode.
>>
>> This problem means that we have to set all our SRC_URI to git SHA instead of the much more readable and easy to check git tags.
>>
>>
>> you think to assume that a reference is a branch, but the real-life problem is when reference is a tag. Tag don't move so this is
>> a case of locked configuration, but i'm not sure how to handle it.
>>
>> Is there a way to have the best of both world somehow ?
> Don’t use tags instead rely on SHA numbers in SRCREV and use
> BB_GENERATE_MIRROR_TARBALLS like mentioned here
>
> https://wiki.yoctoproject.org/wiki/How_do_I#Q:_How_do_I_create_my_own_source_download_mirror_.3F
>
> tags are floating types in git, you can not use them reliably.
> You may tool in a method to automate updating the
> recipes SRCREVs if you dont want to do it by hand.
>
> That should help hopefully
I know... but the fact that NO_NETWORK can't work if any git uses a tag 
seems... not what I would expect. Especially if the tag is available 
locally. I understand what you say, but I think it breaks the purpose of 
NO_NETWORK

If a git reference is floating, then building twice won't produce the 
same result anyway... this sounds more like a QA problem to me than 
something that bitbake should enforce. But i'm really not a BB 
architect, it's just that this patch would solve one of our problem and 
i'd like to see if there is a way to do that without loosing other 
aspects of bitbake...




