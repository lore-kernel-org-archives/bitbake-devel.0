Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1S8d4R-0005RT-8h
	for bitbake-devel@lists.openembedded.org;
	Fri, 16 Mar 2012 20:44:15 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 16 Mar 2012 12:34:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="121767875"
Received: from unknown (HELO [10.255.15.241]) ([10.255.15.241])
	by orsmga002.jf.intel.com with ESMTP; 16 Mar 2012 12:34:20 -0700
Message-ID: <4F6395BC.9090005@linux.intel.com>
Date: Fri, 16 Mar 2012 12:34:20 -0700
From: Joshua Lock <josh@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
MIME-Version: 1.0
To: "Wang, Shane" <shane.wang@intel.com>
References: <cover.1330734444.git.josh@linux.intel.com>
	<4F5169EA.1070504@linux.intel.com>
	<3AB6CE7F274E534CAFD089D127A8A1FC23AECFB6@SHSMSX102.ccr.corp.intel.com>
In-Reply-To: <3AB6CE7F274E534CAFD089D127A8A1FC23AECFB6@SHSMSX102.ccr.corp.intel.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 0/6] Hob GUI add persistent tooltips and use custom info icon consistently
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 16 Mar 2012 19:44:15 -0000
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 15/03/12 23:41, Wang, Shane wrote:
>
> Joshua Lock wrote on 2012-03-03:
>
>> Whoops. Forgot to hit save in my editor before sending... The message
>> should be:
>>
>> The following series addresses some issues I've raised with the Hob
>> implementation. Firstly it introduces two new widgets, a generic
>> PersistentTooltip widget which is an implementation of a tooltip like
>> widget that persists until the user explicitly dismisses it, this
>> matches the Hob interaction design more closely. The second widget is a
>> button-like widget using the info icon from the visual design which,
>> when clicked, will display a persistent tooltip.
>>
>> The series then replaces all known instances of a gtk.Image containing
>> the stock info item plus a standard tooltip with the new HobInfoButton.
>>
>> The final patch, to ensure consistency, special cases the stock info
>> icon in the CrumbsMesssageDialog so that any dialogues which show an
>> info icon will display the custom icon per the visual design.
>>
>> I've attached a few screenshots showing the PersistentTooltip and
>> HobInfoButton's in use.
>>
>> Cheers,
>> Joshua
>
> Josh, I am using Ubuntu system, the color of your tooltips is gray and the background of a window is black.
> I found it is difficult for me to see the words.
> I am wondering whether that is what you want, and whether we can make them white.

Hi Shane,

This isn't intended - I discovered this bug via proxy recently: 
https://bugzilla.yoctoproject.org/show_bug.cgi?id=2128

I'm working to make the tooltips more readable when using Ubuntu with Unity.

Cheers,
Joshua
-- 
Joshua '贾詡' Lock
         Yocto Project "Johannes factotum"
         Intel Open Source Technology Centre


