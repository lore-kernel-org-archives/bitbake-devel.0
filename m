Return-Path: <mark.hatle@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id C8E8071984
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  3 Aug 2017 18:17:01 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id v73IH1qR007805
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Thu, 3 Aug 2017 11:17:02 -0700 (PDT)
Received: from soho-mhatle-m.local (172.25.36.227) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.361.1;
	Thu, 3 Aug 2017 11:17:01 -0700
To: Paul Eggleton <paul.eggleton@linux.intel.com>
References: <1501256242-37784-1-git-send-email-mark.hatle@windriver.com>
	<1501256242-37784-2-git-send-email-mark.hatle@windriver.com>
	<187725705.SbhF8WDyxe@peggleto-mobl.ger.corp.intel.com>
From: Mark Hatle <mark.hatle@windriver.com>
Organization: Wind River Systems
Message-ID: <f9eadae3-992c-b580-3a55-dda15657cea8@windriver.com>
Date: Thu, 3 Aug 2017 13:17:00 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
	Gecko/20100101 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <187725705.SbhF8WDyxe@peggleto-mobl.ger.corp.intel.com>
Cc: bitbake-devel@lists.openembedded.org, toaster@yoctoproject.org
Subject: Re: [PATCH 1/5] lib/layers: Initial layer and layer index implementeation
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
X-List-Received-Date: Thu, 03 Aug 2017 18:17:01 -0000
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit

On 8/3/17 1:05 PM, Paul Eggleton wrote:
> On Friday, 28 July 2017 5:37:18 PM CEST Mark Hatle wrote:
>> This module provides two components, layerindex, which is used to talk a
>> layerindex, such as layers.openembedded.org.
>>
>> The other module is the 'manager'.  This module will handle downloading,
>> re-writing the bblayers to match the downloads and other related layer
>> management tasks.
> 
> It's great to have a solid internal API for interacting with the layer index 
> to replace the less than optimal earlier implementation in bitbake-layers - 
> thanks for sorting this out. The only comments I'd make:
> 
> 1) Can you rename the fetch2 plugin to something like bbfetch or bitbakefetch 
> or something like that. I'd rather we didn't proliferate the fetch2 name any 
> further - IIRC Richard has talked about renaming the module back to fetch at 
> some point.

Yes, I can easily do that.  The name used is the name of the fetch plugin, so it
is partially use visible.

> 2) cooker.py has a "## TODO NOT IMPLEMENTED" comment that if still valid needs 
> to be expanded upon - what's actually missing? There's also a moderate size 
> block of commented-out code just below that, since this is new can we drop 
> that if it's genuinely not needed?

The block immediately below it is what needs to be implemented.  This is the
loading of recipe data from the cooker store (or even having to parse recipes).
As part of the toaster work, I expect to implement it.  I left it there
specifically as a guide to the implementer on what is likely needed -- even
though I know the commented out parts do not work as-is.

(Currently no recipe specific behavior is loaded from the currently running system.)

> 3) Can we have a default type for layerindex URLs of "restapi" so we don't 
> need to specify this everywhere in the common case? This would also mean we 
> wouldn't have to change DEFAULT_LAYERINDEX_SERVER in the toaster code.

Yes, I can make it the default unless a type is defined.  The toaster code will
be changing to match up with the bblayers code.  I'd rather not specify the same
thing in multiple places.   But I won't be making that change until the toaster
work is in progress.

> 4) The "layers" naming of the module under lib is a little confusing given 
> that we already have a bblayers module under lib/, and one might incorrectly 
> assume that this was used for all layer handling. I don't actually yet have a 
> naming scheme / structure I like better though :(

Ya, I couldn't think of one.  Initially I had called it layerindex, but the
manager (which current does downloading) confused it.. so I changed it.

> 5) "OR" to split the branches is a very awkward. Can we use , (comma) instead?

The implementation was designed to match the current format of the restapi URL
format.  But as long as it can be represented in a URI, anything should be fine.

> 6) I'm not massively thrilled at duplicating the layer index data structures 
> in bitbake. It does make things easier on the bitbake side, and the 
> alternative of making use of the original django models in bitbake isn't 
> practical, but it's just a bit unfortunate in terms of future maintenance. 
> Having said that we made the same choice in Toaster, and the layer index 
> models don't change that often. (I guess I'm just highlighting this so we know 
> what we're getting into.)

Yes..  The internal 'data' side of things rarely changes -- but by having the
class we can handle any changes that do happen in the future more easily -- and
as you noted it does simplify some of the django like features.

--Mark

> Cheers,
> Paul
> 


