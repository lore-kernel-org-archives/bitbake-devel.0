Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id DAAA473243
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 22 Sep 2015 14:19:34 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 22 Sep 2015 07:19:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,573,1437462000"; d="scan'208";a="794791662"
Received: from therrane-mobl1.ger.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.252.19.23])
	by fmsmga001.fm.intel.com with ESMTP; 22 Sep 2015 07:19:32 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: Tim Jaacks <tim.jaacks@garz-fricke.com>
Date: Tue, 22 Sep 2015 15:19:26 +0100
Message-ID: <1876374.NeGQHa5IJa@peggleto-mobl.ger.corp.intel.com>
Organization: Intel Corporation
User-Agent: KMail/4.14.9 (Linux/4.1.6-100.fc21.x86_64; KDE/4.14.9; x86_64; ; )
In-Reply-To: <32EA6B79577EEF4C84CB32305D45A059289DF200@SRV24.hamburg.garz-fricke.de>
References: <32EA6B79577EEF4C84CB32305D45A059289DF200@SRV24.hamburg.garz-fricke.de>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
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
X-List-Received-Date: Tue, 22 Sep 2015 14:19:35 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Tim,

On Tuesday 22 September 2015 13:40:49 Tim Jaacks wrote:
> Hello everyone,
> 
> I have a problem with bitbake's "_remove" operator. Perhaps someone can help
> me out.
> 
> Suppose I have three layers:
>  - meta-1
>  - meta-2
>  - meta-3
> 
> In meta-1, there is a recipe "foo.bb", containing a variable:
> FOO = "bar baz"
> 
> In meta-2, there is an append file "foo.bbappend", which changes the
> variable using the "_remove" operator: FOO_remove = "bar"
> 
> The resulting value of the FOO variable is " baz".
> 
> Now I want to re-add "bar" to the FOO variable in meta-3, without changing
> the other layers. How is that possible?
> 
> I tried everything I could think of, including several combinations of
> "_append", "_prepend", machine-specific overrides, "_forcevariable" or
> setting the variable to a hard-coded value. Nothing could bring back "bar".
> It seems as if the "_remove" operator is always executed at the very end of
> the variable calculation, come what may. The layer priority seems to not
> have any impact on this.
> 
> Is this a design fault? Or am I missing something?
> Any hints on this would be helpful, thanks in advance.

I'm afraid you cannot. _remove is intended to be final i.e. "remove this after 
any and all other operations that might have added it". If you're finding a 
_remove in another layer that's doing something you don't want, then the layer 
is imposing policy on you that it probably shouldn't be.

Is this _remove in a public layer? If so which layer and what is it?

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre

