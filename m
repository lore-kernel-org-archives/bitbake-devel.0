Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 1D4CF7649D
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 31 Jul 2015 10:34:00 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 31 Jul 2015 03:34:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,583,1432623600"; d="scan'208";a="759119561"
Received: from unknown (HELO peggleto-mobl.ger.corp.intel.com)
	([10.252.23.101])
	by fmsmga001.fm.intel.com with ESMTP; 31 Jul 2015 03:33:54 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: Roman Savchenko <gmstima@gmail.com>
Date: Fri, 31 Jul 2015 11:33:52 +0100
Message-ID: <3477046.8BCL6Z6sXn@peggleto-mobl.ger.corp.intel.com>
Organization: Intel Corporation
User-Agent: KMail/4.14.9 (Linux/4.0.8-200.fc21.x86_64; KDE/4.14.9; x86_64; ; )
In-Reply-To: <CAGpdKUJDc37GZa3v8t8BYpdp2hpcdaB_rHPt6kiQ0J5BqmMrmw@mail.gmail.com>
References: <CAGpdKUJDc37GZa3v8t8BYpdp2hpcdaB_rHPt6kiQ0J5BqmMrmw@mail.gmail.com>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: Get package inheritance
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
X-List-Received-Date: Fri, 31 Jul 2015 10:34:01 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Roman,

On Wednesday 29 July 2015 18:34:15 Roman Savchenko wrote:
> how can I get package inheritance?
> 
> Example what I want:
> 
> my_package.bb
> inherit A // can't be changed
> inherit B
> Inherit C
> 
> C.bbclass
> 
> python do_some_stuff() {
>     bases = d.getVar("INHERIT")
>     if "A" in bases:
>          do_some_stuff_for_a()
>     else if "B":
>          //
>     else if "A" and "B"
> }
> 
> addtask do_some_stuff

I think you want bb.data.inherits_class('classname', d) - returns True if the 
specified classname is inherited by the recipe.

Cheers,
Paul


-- 

Paul Eggleton
Intel Open Source Technology Centre

