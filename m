Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <ioanax.grigoropol@intel.com>) id 1TGqd3-0007iU-Vl
	for bitbake-devel@lists.openembedded.org;
	Wed, 26 Sep 2012 14:22:14 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 26 Sep 2012 05:08:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,490,1344236400"; d="scan'208";a="213523217"
Received: from ideapad (HELO [10.237.105.40]) ([10.237.105.40])
	by orsmga002.jf.intel.com with ESMTP; 26 Sep 2012 05:08:04 -0700
Message-ID: <5062EF20.4030307@intel.com>
Date: Wed, 26 Sep 2012 15:03:44 +0300
From: Ioana Grigoropol <ioanax.grigoropol@intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:14.0) Gecko/20120714 Thunderbird/14.0
MIME-Version: 1.0
To: Paul Eggleton <paul.eggleton@linux.intel.com>
References: <1348564865-23697-1-git-send-email-ioanax.grigoropol@intel.com>
	<4243638.dprUypd7aI@helios>
In-Reply-To: <4243638.dprUypd7aI@helios>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] hob: Buttons width and height are taken for host
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
X-List-Received-Date: Wed, 26 Sep 2012 12:22:14 -0000
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Paul,

No, it wasn't on purpose. The mark-up was removed on my local repo and 
was accidentally merged together with the other changes on master.
I will resend the patch.

Thanks,
Ioana

On Wed 26 Sep 2012 12:20:02 PM EEST, Paul Eggleton wrote:
> Hi Ioana,
>
> On Tuesday 25 September 2012 12:21:05 Ioana Grigoropol wrote:
>> - removed all set_size_request calls for buttons in order to:
>> 	- force autosizing of buttons with regard to the text length
>> 	- use host theme default height for buttons
>> - modified buttons on image details page to have the same height (default
>> host one) and the width of the button with the largest text - modified Stop
>> button on build details page to have the default height by directly
>> attaching it to the containing table instead of hbox
>>
>> Signed-off-by: Ioana Grigoropol <ioanax.grigoropol@intel.com>
>> ---
>>   bitbake/lib/bb/ui/crumbs/builddetailspage.py       |   12 +--
>>   bitbake/lib/bb/ui/crumbs/hig.py                    |    2 +-
>>   bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py |   15 +--
>>   bitbake/lib/bb/ui/crumbs/imagedetailspage.py       |  101
>> ++++++++++++++++---- bitbake/lib/bb/ui/crumbs/packageselectionpage.py   |
>>   2 +-
>>   bitbake/lib/bb/ui/crumbs/recipeselectionpage.py    |    2 +-
>>   6 files changed, 102 insertions(+), 32 deletions(-)
>>
>> diff --git a/bitbake/lib/bb/ui/crumbs/builddetailspage.py
>> b/bitbake/lib/bb/ui/crumbs/builddetailspage.py index a927c21..5add31d
>> 100755
>> --- a/bitbake/lib/bb/ui/crumbs/builddetailspage.py
>> +++ b/bitbake/lib/bb/ui/crumbs/builddetailspage.py
>> @@ -165,7 +165,7 @@ class BuildDetailsPage (HobPage):
>>           self.builder.handler.build.model.connect_after("row-changed",
>> self.scroll_to_present_row, self.scrolled_view_build.get_vadjustment(),
>> self.build_tv)
>>
>>           self.button_box = gtk.HBox(False, 6)
>> -        self.back_button = HobAltButton('&lt;&lt; Back')
>> +        self.back_button = HobAltButton('<< Back')
>
> I did make this change to avoid a runtime warning due to invalid markup - did
> you change it back on purpose? If so I don't see it mentioned in the commit
> message.
>
> Cheers,
> Paul
>
>




