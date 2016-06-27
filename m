Return-Path: <jason.wessel@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id B4846606D0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 27 Jun 2016 14:37:12 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id u5REbCGh027638
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=OK);
	Mon, 27 Jun 2016 07:37:12 -0700
Received: from [192.168.10.15] (172.25.59.217) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.40) with Microsoft SMTP Server id 14.3.248.2;
	Mon, 27 Jun 2016 07:37:10 -0700
To: Richard Purdie <richard.purdie@linuxfoundation.org>, Robert Yang
	<liezhi.yang@windriver.com>, <bitbake-devel@lists.openembedded.org>, Mark
	Hatle <mark.hatle@windriver.com>
References: <cover.1466754896.git.liezhi.yang@windriver.com>
	<ba8db9342c0793e7ee796140da0c9c638ae7e6ff.1466754896.git.liezhi.yang@windriver.com>
	<1466774122.3319.235.camel@linuxfoundation.org>
	<57712E31.6000100@windriver.com>
	<1467035511.8590.55.camel@linuxfoundation.org>
From: Jason Wessel <jason.wessel@windriver.com>
Message-ID: <57713A16.1060708@windriver.com>
Date: Mon, 27 Jun 2016 09:37:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
	Thunderbird/38.8.0
MIME-Version: 1.0
In-Reply-To: <1467035511.8590.55.camel@linuxfoundation.org>
Subject: Re: [PATCH 1/1] fetch2: remove "." in the end
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
X-List-Received-Date: Mon, 27 Jun 2016 14:37:13 -0000
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 06/27/2016 08:51 AM, Richard Purdie wrote:
> On Mon, 2016-06-27 at 08:46 -0500, Jason Wessel wrote:
>> On 06/24/2016 08:15 AM, Richard Purdie wrote:
>>> On Fri, 2016-06-24 at 00:55 -0700, Robert Yang wrote:
>>>> From: Jason Wessel <jason.wessel@windriver.com>
>>>>
>>>> The filename can't be "foo." for MS Windows filesystem, it will
>>>> renamed
>>>> to "foo" automatically, so we can't upload sources like "foo." to
>>>> the
>>>> Windows server, remove "." in the end will fix the problem.
>>> This patch on its own is probably ok. What I worry about is that if
>>> I
>>> merge this, I'll then get all the follow ups which for example
>>> force
>>> lower or upper case everywhere, remove ":" characters from all
>>> filenames (including sstate?), remove various other characters and
>>> so
>>> on.
>>>
>>> We don't run on windows filesystems and we're not likely ever to be
>>> able to.
>>>
>>> So what are we aiming for here?
>>
>> It is compatibility with browsing and copying the bitbake/oe
>> directory structures + the download cache.  We certainly don't expect
>> to be building directly on Windows with a native bitbake. Today
>> however, you can directly use git on Windows and building with the
>> cross API's from a generated SDK.
> You haven't really answered my question though. If we fix this, how
> many other issues are we going to run into? Are we for example going to
> need to change the sstate filename field separator? Are there other
> filename issues we'll run into. Typically, someone sends a simple patch
> like this, then a couple more and then we suddenly find we've committed
> to rewriting half the system to "support windows filesystems".


This is a problem that was found in steady state maintenance from 5 years worth of using Windows as a cross application building environment from a derived platform build from a Linux environment.   There is no foreseeable plan to change what is there.   This is a "bug fix" to a problem which has existed for some time now. Unfortunately Robert blindly sent a patch on my behalf from an internal pastebin and it did not include how the problem was found or any of the original suggested solution discussion.   In that case the patch should have come from him and not me.

That being said I'll bring up some of the points of how the problem was discovered.

1) A git URI ended in a slash in a single recipe.

     My personal contention is that this is just wrong.
        A) Git didn't always have support for the "/" at the end
        B) In some cases this can not be used a push reference

     Evidence in the community shows that since 2014:
        A) git internally drops the slash and the right thing
        B) git hub started allowing https push with the trailing slash

2) Originally I proposed just adding a warning or error to bitbake for
      a trailing "/" and then fixing the single problematic recipe
      out of the 2900 we parse.

3) The OE download cache uses a direct translation of the URI
     A) Because there is community support for the trailing / on URI
          perhaps fixing the cache is a better approach
     B) The fetcher cache creates a bare clone of a git which
          in turn does not need the trailing slash
     C) I created and tested a simple patch with the fetcher

4) Robert sent this patch from one of my pastebin possibilities instead of
     having an open discussion on the topic first.


>
> I'm going to refuse to do this piecemeal. I'd like a thought out
> proposal about exactly which files we need to support on windows and
> how much of bitbake we're expecting to be able to use (or which class
> code/tools) before we start adding patches.

I do not believe there is any proposal to write.  In general what we have for Windows today has worked fine.  It has been working for the last 5 years.   We regression test any changes to the master branch against the same Windows SDK policy we have been using and are not making any changes to that policy or adding additional functionality.

Do you believe we are standing on some kind of slippery slope?

Prior to hitting this problem with the single recipe we did not even have a test for a directory ending in a dot.  Case folding on the other hand has been tested and the limitations and work arounds are documented and already implemented.  I see no need to change anything else.  If you look at this another way, a couple line fix to a routine where a corner case was found after 5 years of use really isn't too bad.

Cheers,
Jason.

