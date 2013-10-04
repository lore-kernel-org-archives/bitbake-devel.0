Return-Path: <valentin.popa@intel.com>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by mail.openembedded.org (Postfix) with ESMTP id 45FC260FA4
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  4 Oct 2013 16:28:36 +0000 (UTC)
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 04 Oct 2013 09:28:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,1034,1371106800"; d="scan'208";a="303233322"
Received: from vpopa-desktop.rb.intel.com (HELO [10.237.105.58])
	([10.237.105.58])
	by AZSMGA002.ch.intel.com with ESMTP; 04 Oct 2013 09:28:21 -0700
Message-ID: <524EED06.4030701@intel.com>
Date: Fri, 04 Oct 2013 19:29:58 +0300
From: Valentin Popa <valentin.popa@intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:24.0) Gecko/20100101 Thunderbird/24.0
MIME-Version: 1.0
To: Richard Purdie <richard.purdie@linuxfoundation.org>, 
	"cristiana.voicu" <cristiana.voicu@intel.com>
References: <1380291041-11238-1-git-send-email-valentin.popa@intel.com>	
	<52492975.20408@intel.com> <524D70DD.7050709@intel.com>
	<1380893834.18603.608.camel@ted>
In-Reply-To: <1380893834.18603.608.camel@ted>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] HOB: MACHINE should be saved in conf files using ?=
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
X-List-Received-Date: Fri, 04 Oct 2013 16:28:37 -0000
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/04/2013 04:37 PM, Richard Purdie wrote:
> On Thu, 2013-10-03 at 16:27 +0300, cristiana.voicu wrote:
>> I know I replied with an ack for this patch, but working on a similar
>> bug I realized that replacing the comment "total += "\n#added by
>> bitbake" with total += "\n#added by hob" in bitbake code is not ok. I
>> think it will be better to give as argument the comment string, in order
>> to keep this method reusable in  other ui.
> To make things simpler can someone send a follow up patch to make this a
> parameter please?
>
> Cheers,
>
> Richard
>
In case of multiple UI's in case some of them assigns(or earlyassigns) a 
var then another one wants to do the same thing, which lines do we 
cancel/comment in local.conf ? Do we let configurations from different 
UIs to coexist in local.conf?
(with the respect of the code from cooker.py:
#check if the variable was saved before in the same way
#if true it replace the place where the variable was
declared
#else it comments it

                     if contents[begin_line-1]== "#added by hob\n":
                         contents[begin_line] = "%s %s \"%s\"\n" % (var, 
op, val)
                         replaced = True
                     else:
                         for ii in range(begin_line, end_line):
                             contents[ii] = "#" + contents[ii]
)

