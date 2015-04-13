Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id E1BDA6E2C3
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 13 Apr 2015 08:16:57 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by fmsmga103.fm.intel.com with ESMTP; 13 Apr 2015 01:16:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.11,568,1422950400"; d="scan'208";a="555068946"
Received: from abonnier-mobl2.ger.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.252.24.248])
	by orsmga003.jf.intel.com with ESMTP; 13 Apr 2015 01:16:59 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: Roman Savchenko <gmstima@gmail.com>
Date: Mon, 13 Apr 2015 09:16:56 +0100
Message-ID: <1465369.sjMkl7KIUq@peggleto-mobl.ger.corp.intel.com>
Organization: Intel Corporation
User-Agent: KMail/4.14.4 (Linux/3.18.9-200.fc21.x86_64; KDE/4.14.6; x86_64; ; )
In-Reply-To: <CAGpdKU+Jjgtukyfm7E4rO+azk+wxY+TL22zP24DPh-nsTcjvdA@mail.gmail.com>
References: <CAGpdKU+Jjgtukyfm7E4rO+azk+wxY+TL22zP24DPh-nsTcjvdA@mail.gmail.com>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: pkg_postinst_${PN}_append
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
X-List-Received-Date: Mon, 13 Apr 2015 08:16:58 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Roman,

On Friday 10 April 2015 11:55:12 Roman Savchenko wrote:
> Why doesn't pkg_postinst_${PN}_append call if I add `python` to him:
> 
> pkg_postinst_${PN}_append {
>  //called
> }
> 
> python pkg_postinst_${PN}_append {
>  //not called
> }
> 
> Could any one please help me?

Well, there wouldn't be any point to adding "python" - these functions aren't 
called by the build system, they are called by the package manager and as far 
as I know only shell is supported there.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre

