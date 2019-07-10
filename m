Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id D87587EEBB
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jul 2019 08:47:36 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com ([147.11.189.41])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id x6A8laQn010112
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Wed, 10 Jul 2019 01:47:37 -0700 (PDT)
Received: from localhost.corp.ad.wrs.com (128.224.162.182) by
	ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server id
	14.3.439.0; Wed, 10 Jul 2019 01:47:36 -0700
To: Alan Kozlay <alan.kozlay@ves-solutions.com>,
	<bitbake-devel@lists.openembedded.org>, Richard Purdie
	<richard.purdie@linuxfoundation.org>
References: <CAJE9sG=4MPryg2+h5a-jmhhpqPW=o6E26rte-JSPc31UioNbwQ@mail.gmail.com>
	<d12b286a3b55653e61d8d8e7672d87b374ae37d6.camel@linuxfoundation.org>
	<CAJE9sGmynaeD3uL-UBJnJt74rhv-sjSYjtQ=mNByQ69pVwaerg@mail.gmail.com>
From: Robert Yang <liezhi.yang@windriver.com>
Message-ID: <eea2f89b-ed8d-40ed-9c9a-d70f4d1457f3@windriver.com>
Date: Wed, 10 Jul 2019 16:48:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAJE9sGmynaeD3uL-UBJnJt74rhv-sjSYjtQ=mNByQ69pVwaerg@mail.gmail.com>
Subject: Re: Should multiconfig save build time?
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
X-List-Received-Date: Wed, 10 Jul 2019 08:47:37 -0000
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit



On 7/9/19 2:27 AM, Alan Kozlay wrote:
> All,
> 
> In regards to our original June 28th post:
> 
> We're looking for things we can do to improve the multiconfig build time.
> 
> Even on our build servers it still takes a long time.
> For instance, our build servers each have 64 core, 128G RAM with 4 NVMe SSD HDs 
> in a striped raid (/all configured with bells and whistles to make it super fast/).
> A full fresh build on one of those servers still takes 6 hours.
> 
> I need to also clarify that we do indeed define different DISTRO_FEATURES 
> between multiconfigs, so multiconfig is necessary.
> 
> (1) We're attempting to use the ccache (via ccache.bbclass), but it's causing 
> some build errors that we're investigating.

Which branch are you using, please? What's the detailed errors?

> (2) Can we at least set the root native work directory to be the same for all 
> multiconfigs?
> 
>   * Would each multiconfig honor the previously built native tools?
>   * Or, would it just rebuild them, anyway?
>   * Is this safe or tested or supported?
> 
> (3) We're considering a network shared sstate-cache.  But it's not entirely 
> clear if a multiconfig build is benefited by the sstate-cache directory.
> 
>   * Under what circumstances does a multiconfig leverage sstate-cache when
>     building for another multiconfig?

Only when the checksums are the same.

>   * What if the recipe would be affected by a change in DISTRO_FEATURES between >     multiconfigs?

You can use:
$ bitbake -Sprintdiff <recipe> (or world)

Before and after DISTRO_FEATURES changed to see the differences.

>   * Are native packages included in the sstate-cache or just target packages?

I prefer including all of them in the sstate-cache, e.g., allarch recipes
may also re-use the sstate-cache.


Build time is a problem, I had tried to adjust the build options to make it
faster, but didn't improve a lot. Make bitbake support distributed build
might be a good choice, not distribute C/C++ files, but distribute
the whole recipes or task queues to other hosts to build them. bitbake
doesn't support this atm. Perhaps we may make it work in the future,
add RP in the loop to see his comments.

// Robert

> 
> We welcome all thoughts and ideas.
> 
> -Alan
> 
> On Sun, Jun 30, 2019 at 5:38 PM Richard Purdie 
> <richard.purdie@linuxfoundation.org <mailto:richard.purdie@linuxfoundation.org>> 
> wrote:
> 
>     On Fri, 2019-06-28 at 13:31 -0400, Alan Kozlay wrote:
>      > We have need to generate 6 slighly different images, with different
>      > dedicated applications and use cases, but they're all destined for
>      > the same hardware.
>      > We have multiconfig set to build these 6 variants.  Clearly, they'll
>      > all share a majority of underlying packages.
>      > While the bitbake initialization takes a long time (with
>      > multiconfig), we were under the impression that it could save time
>      > during the actual build process because it could have the potential
>      > to reuse packages already built from mc A for mc B if the inputs to
>      > the recipes are unchanged (if same xxx_FEATURES, same arch, etc.).
>      >
>      > This was a guess on our part since we initially didn't assign
>      > different tmp directories for each conf.  So, the <WORKDIR> didn't
>      > change between mc builds.  That actually was causing some issues
>      > until we realized that separate tmp dirs was recommended for them.
>      > Since they all now have separate tmp dirs, they clearly are not going
>      > to share work dirs, so, now we're questioning our original assumption
>      > about any build-time speed benefit.
>      >
>      > So, is mc expected to be any faster than, say, 6 separate invocations
>      > of non-mc bitbake whilst switching out the local.conf between them?
> 
>     Ultimately, yes, it would be expected to be faster.
> 
>     With the code as it stands today, no, it won't be. Its a known open
>     issue:
> 
>     https://bugzilla.yoctoproject.org/show_bug.cgi?id=10682
> 
>     What would be faster is to build one of the configs initially which
>     will populate the sstate cache, then build the other 5 together in one
>     multiconfig.
> 
>     We obviously want to get that issue fixed ultimately but its not an
>     easy thing to do due to the way our codebase works.
> 
>     Cheers,
> 
>     Richard
> 
> 
> 
> -- 
> Alan Kozlay
> VES Solutions, LLC
> Alan Kozlay <alan.kozlay@ves.solutions>
> DESK 443-595-7734
> CELL 443-752-0323
> 

