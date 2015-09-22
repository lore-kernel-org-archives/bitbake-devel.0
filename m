Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id D342D73243
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 22 Sep 2015 16:12:34 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 22 Sep 2015 09:12:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,573,1437462000"; d="scan'208";a="794882856"
Received: from therrane-mobl1.ger.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.252.19.23])
	by fmsmga001.fm.intel.com with ESMTP; 22 Sep 2015 09:12:22 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: Tim Jaacks <tim.jaacks@garz-fricke.com>
Date: Tue, 22 Sep 2015 17:12:20 +0100
Message-ID: <3187731.pmWd6aiVkT@peggleto-mobl.ger.corp.intel.com>
Organization: Intel Corporation
User-Agent: KMail/4.14.9 (Linux/4.1.6-100.fc21.x86_64; KDE/4.14.9; x86_64; ; )
In-Reply-To: <32EA6B79577EEF4C84CB32305D45A059289DF453@SRV24.hamburg.garz-fricke.de>
References: <32EA6B79577EEF4C84CB32305D45A059289DF453@SRV24.hamburg.garz-fricke.de>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org,
	Otavio Salvador <otavio.salvador@ossystems.com.br>
Subject: Re: Override a "_remove" operator in bbappend file
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
X-List-Received-Date: Tue, 22 Sep 2015 16:12:36 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday 22 September 2015 14:35:39 Tim Jaacks wrote:
>Paul Eggleton wrote:
>>On Tuesday 22 September 2015 13:40:49 Tim Jaacks wrote:
>>> I have a problem with bitbake's "_remove" operator. Perhaps someone can
>>> help me out.
>>> 
>>> Suppose I have three layers:
>>>  - meta-1
>>>  - meta-2
>>>  - meta-3
>>> 
>>> In meta-1, there is a recipe "foo.bb", containing a variable:
>>> FOO = "bar baz"
>>> 
>>> In meta-2, there is an append file "foo.bbappend", which changes the
>>> variable using the "_remove" operator: FOO_remove = "bar"
>>> 
>>> The resulting value of the FOO variable is " baz".
>>> 
>>> Now I want to re-add "bar" to the FOO variable in meta-3, without changing
>>> the other layers. How is that possible?
>>> 
>>> I tried everything I could think of, including several combinations of
>>> "_append", "_prepend", machine-specific overrides, "_forcevariable" or
>>> setting the variable to a hard-coded value. Nothing could bring back
>>> "bar". It seems as if the "_remove" operator is always executed at the
>>> very end of the variable calculation, come what may. The layer priority
>>> seems to not have any impact on this.
>>> 
>>> Is this a design fault? Or am I missing something?
>>> Any hints on this would be helpful, thanks in advance.
>>
>> I'm afraid you cannot. _remove is intended to be final i.e. "remove this
>> after any and all other operations that might have added it". If you're
>> finding a _remove in another layer that's doing something you don't want,
>> then the layer is imposing policy on you that it probably shouldn't be.
>>
>> Is this _remove in a public layer? If so which layer and what is it?
>>
> thanks for your feedback. Yes, the according file is in meta-fsl-arm:
> 
> https://github.com/Freescale/meta-fsl-arm/blob/3336ef362109eef14f9e73cdededb
> 43caefedb2f/recipes-graphics/mesa/mesa_%25.bbappend
> 
> I would like to undo the first two lines.

Adding Otavio (the committer & maintainer of meta-fsl-arm) to CC - Tim perhaps 
you can explain what you're attempting to do here in concrete terms?
 
> So, this is the intended behavior, you say? Shouldn't the order of all
> _appends, _prepends and _removes be tied to the layer priority? That's what
> I would expect, though.

We went back and forth on the way it was implemented, but the conclusion we 
reached was that what most people want is a remove operator that removes the 
value no matter how it comes in. If we start getting into ordering of 
operators then it's harder for the user to understand what's going on, 
particularly as _append, _prepend and _remove are deferred operations (unlike 
+= or =+ which are immediate).

What this does mean is that _remove should be used sparingly and really ought 
to be used only where it's very unlikely that anyone would want to override 
it.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre

