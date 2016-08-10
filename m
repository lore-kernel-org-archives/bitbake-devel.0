Return-Path: <jeremy.rosen@smile.fr>
Received: from idris.smile.fr (idris.smile.fr [91.216.209.19])
	by mail.openembedded.org (Postfix) with ESMTP id 37FEE771FC
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Aug 2016 08:28:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by idris.smile.fr (Postfix) with ESMTP id EDE341EE08B8;
	Wed, 10 Aug 2016 10:28:04 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at smile.fr
Received: from idris.smile.fr ([127.0.0.1])
	by localhost (bluemind-mta.prod.vitry.intranet [127.0.0.1])
	(amavisd-new, port 10024)
	with ESMTP id 3KP1bxKqdS3b; Wed, 10 Aug 2016 10:28:04 +0200 (CEST)
Received: from [10.9.18.224] (229.29.205.77.rev.sfr.net [77.205.29.229])
	by idris.smile.fr (Postfix) with ESMTPSA id 991721EE02B8;
	Wed, 10 Aug 2016 10:28:04 +0200 (CEST)
References: <801c8b3c-a6f7-6b96-a527-d61c70a4a574@smile.fr>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>,
	Olof Johansson <olof.johansson@axis.com>
From: =?UTF-8?B?SsOpcsOpbXkgUm9zZW4=?= <jeremy.rosen@smile.fr>
X-Forwarded-Message-Id: <801c8b3c-a6f7-6b96-a527-d61c70a4a574@smile.fr>
Message-ID: <d111711a-d81e-5e94-a684-5162969d4eda@smile.fr>
Date: Wed, 10 Aug 2016 10:28:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
	Firefox/45.0 Icedove/45.2.0
MIME-Version: 1.0
In-Reply-To: <801c8b3c-a6f7-6b96-a527-d61c70a4a574@smile.fr>
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
X-List-Received-Date: Wed, 10 Aug 2016 08:28:05 -0000
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

(this conversation accidentally became private, I'm forwarding it to the 
mailing list...)

On 09/08/2016 17:50, Olof Johansson wrote:
> On 16-08-09 17:16 +0200, Jérémy Rosen wrote:
>> I must admit i'm kinda confused here...
>>
>> what's the point of NO_NETWORK
>>
>> * the "airplane use-case : I'm on a plane with no network access and I want
>> to work on yocto. I built stuff previously and I don't really care about
>> upstream changes. I set NO_NETWORK so bitbake doesn't complain but still
>> build everything : In that case, bitbake needs to use it's locally cached
>> ref positions, and currently doesn't work
>>
>> * the "long term archive" use-case. I have built a local mirror 10years ago
>> and I want to rebuild from scratch. In that case, it makes sense (again) to
>> use the ref from the mirror to find you SHA. Yes, fixed refs would be
>> better, but if the ref have changed, I would argue that using the old
>> position is exactly what you want.
>>
>> * other use-case ? I don't really see...
> There's a variable called BB_ALLOWED_NETWORKS, so if you are
> using BB_NO_NETWORK, we can whitelist one or more hosts or
> networks:
>
>   BB_NO_NETWORK = "1"
>   BB_ALLOWED_NETWORKS = "*.axis.com mirror.example.com"
>
> This introduces a new use case: we can make sure that only some
> network hosts are used during builds. (Like only using your
> internal mirror or your internal Git server.)
Interesting... not a use-case I had thought of
>> Overall, I think that if a SRC_URI points to a ref, NO_NETWORK is set, and
>> we have that ref somewhere in DL_DIR, then using that ref is exactly what we
>> wants, and currently it doesn't work because bitbake insists on using the
>> network even when we tell it explicitely to do so.
>>
>> I understand Tobias's point (that it has side effects) but I don't really
>> understand the idea that any SRC_URI with a ref should always fail with
>> NO_NETWORK...
> So I thought Tobias' patch made sense for the same reason you do,
> but I can live with having to set another variable to opt-in to
> that behavior. Clearly people have mixed opinions about this, but
> having the option to enable the behavior would be enough for us.
It seems that there is an assumption
BB_NO_NETWORK == reproducible build

That assumption is true for my "long term archive" use-case, but
definitely not for my airplane use-case.

  From a user experience point of view, it would make sense to "activate"
(or deactivate) reproducible build explicitely. That could trigger a
number of important QA tests that don't make sense for general consumption

but again, no-network is not reproducible build (they have some common
ideas, but there are cases where you want one but not the other) so the
two concepts should be separated...

> I can see the case for what Richard mentioned, that the upstream
> community layers (or other layers that forbid git tags) can use
> BB_NO_NETWORK to verify that no refs are being used in SRCREV.
> As this is an existing use case, it would probably be a bad idea
> to change it now.
so some sort of BB_NOT_REPRODUCIBLE variable (horrible name, please find
a better one :P )
>
> For your "long term archive" (as well as the airplane) use case,
> I think that you could probably use what Paul mentioned without
> the caveats we are facing; as (if I understood your case
> correctly) you aren't actively doing development on the sources,
> just reproducing builds offline.
yes for "long term" but "airplane" can't make that assumption. it's just
a dev on the move, or without general internet access...
more generally, I understand BB_NO_NETWORK as telling bitbake that no
network is not an error and it should work around it.

>
> We would like to avoid having two version strings (one being
> informational only), as this will probably lead to confusion as
> people are actually updating the recipes:
>
> Q: "why didn't my modification make it into the build?"
> A: "because you only updated PV, not SRCREV"
>
> Q: "why does the package manifest claim that this is the old
>      version even though my changes are in?"
> A: "because you only updated SRCREV, not PV"
>
I don't really understand that last part, I must admit I only use
pvserver, so I don't touch PV ususally.
I completely understand that having a proper, reproducible build
requires that you change all floating revs to fixed revs (including,
arguably, any git tag) but I don't understand why NO_NETWORK should
force fixed rev on the user...

it's mainly a problem of discussing the use-case for no-network... mine
doesn't work if you force no-floating-rev on me.

Nobody discussed the idea of using git-describe as a way around (or a
way to prettyfy) the SRCREV freeze. This way of decribing a commit is
both human readable and guaranteed unique (it contains a shortened SHA)

Hope this helps
Jeremy

> Hope this helps in clarifying a little :)
>


