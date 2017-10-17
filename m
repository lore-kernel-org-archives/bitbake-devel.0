Return-Path: <alexander.kanavin@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 4581778299
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 17 Oct 2017 12:45:45 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	17 Oct 2017 05:45:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.43,390,1503385200"; d="scan'208";a="910717247"
Received: from kanavin-desktop.fi.intel.com (HELO [10.237.68.161])
	([10.237.68.161])
	by FMSMGA003.fm.intel.com with ESMTP; 17 Oct 2017 05:45:45 -0700
To: David Vincent <freesilicon@gmail.com>
References: <20171017112748.10968-1-freesilicon@gmail.com>
	<612b6e16-2db3-4e33-45fa-e03cb6d26dc1@linux.intel.com>
	<5556941.pslUcQMuWo@crde-port-20.cahors.local>
From: Alexander Kanavin <alexander.kanavin@linux.intel.com>
Message-ID: <4f48eaa9-24ef-0633-2c2f-30d5bb2ac649@linux.intel.com>
Date: Tue, 17 Oct 2017 15:41:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <5556941.pslUcQMuWo@crde-port-20.cahors.local>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] fetch/git: fix per-branch unpacking
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
X-List-Received-Date: Tue, 17 Oct 2017 12:45:46 -0000
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit

On 10/17/2017 02:59 PM, David Vincent wrote:

> I don't clearly see the example I need to provide since this behavior is
> already documented in the fetcher and this patch is simply a bugfix :
> 
> - branch
>     The git branch to retrieve from. The default is "master"
> 
>     This option also supports multiple branch fetching, with branches
>     separated by commas.  In multiple branches case, the name option
>     must have the same number of names to match the branches, which is
>     used to specify the SRC_REV for the branch
>     e.g:
>     SRC_URI="git://some.host/somepath;branch=branchX,branchY;name=nameX,nameY"
>     SRCREV_nameX = "xxxxxxxxxxxxxxxxxxxx"
>     SRCREV_nameY = “YYYYYYYYYYYYYYYYYYYY”
> 
> Maybe I can provide some background behind this fix and you tell me if I must
> complete my commit message.
> When working on a linux-yocto kernel, I tried to merge a feature branch in my
> machine branch using the merge functionality, therefore I needed to checkout
> two branches in a specific revision. Problem is that my machine branch was
> correctly checked out with the SRCREV provided in the recipe but the feature
> branch was not, it was checked out to the tip of the remote branch. When
> investigating a little further, I did find that bitbake only checks out the
> first branch and does not handle other branches (why it did work in the first
> place seems like some bbclass magic to me). The point is that with this patch,
> all my branches are correctly checked out and my kernel got the good revision.

Thanks - actually Yocto documentation does not mention anything about 
multiple branches; you need to read the source code for the fetcher. So 
technically, it's not officially supported. And how do you pick a 
specific branch to be built?

Anyway, the kind of information you provided above can definitely go 
into the commit message. And can you file a bug to fix this in the docs 
please?

Alex

