Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1S29xK-0007wq-1m
	for bitbake-devel@lists.openembedded.org;
	Tue, 28 Feb 2012 00:26:10 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 27 Feb 2012 15:16:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="112412533"
Received: from unknown (HELO [10.7.198.148]) ([10.7.198.148])
	by orsmga001.jf.intel.com with ESMTP; 27 Feb 2012 15:15:37 -0800
Message-ID: <4F4C0E99.3000706@linux.intel.com>
Date: Mon, 27 Feb 2012 15:15:37 -0800
From: Joshua Lock <josh@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
MIME-Version: 1.0
To: "Wang, Shane" <shane.wang@intel.com>
References: <cover.1330004101.git.dongxiao.xu@intel.com>
	<4F46F915.5010705@linux.intel.com>
	<3AB6CE7F274E534CAFD089D127A8A1FC23ACFDFE@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: <3AB6CE7F274E534CAFD089D127A8A1FC23ACFDFE@SHSMSX101.ccr.corp.intel.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 0/1][PULL] Hob2: A new implementation for Human Oriented Builder
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
X-List-Received-Date: Mon, 27 Feb 2012 23:26:10 -0000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



On 27/02/12 04:26, Wang, Shane wrote:
> Joshua Lock wrote on 2012-02-24:
>
>>
>>
>> On 23/02/12 05:48, Dongxiao Xu wrote:
>>> Hi Richard,
>>>
>>> This pull request is a new implementation for Human Oriented Builder,
>> please help to review and pull.
>>
>> Please, let's not call it the Human Oriented Builder. It was always just
>> Hob, not HOB - are we changing that now?
>>
>>> Changes from previous pull requests:
>>>    - Re-implemented a lot of code according to Belen's new GUI design.
>>
>> This is really hard to review as a several thousand line patch... It's
>> difficult to know where what seems like an odd decision in the code was
>> made for a sane reason without any git history or code comments to
>> follow the logic of the development.
>>
>> The fact that the patch was rejected by the mailing list is a good
>> indication that we need to separate into smaller logical commits.
>>
>> I could review coding style, but that is probably pretty useless at this
>> point and so  offer somewhat superficial comments below regarding UI
>> implementation with Gtk+.
> Sorry for that, it convinces me that a design document is useful.
> The problem is because the UI was changed a lot in a short time, even though we compared with our previous version in Jan.
> So, next time we will pay more attention to submit incremental patches.

Great.
<snip>

>> It's also worth noting that the visual style 'leaks' in the Settings
>> dialogue and I see standard Gtk light-bulb info icons rather than the
>> steely i displayed on the main page.
> In the settings dialog, we didn't make any specific icon for tool tip.
> On Ubuntu, it is a "i". On Fedora 16, it becomes a light-bulb. I am thinking how to make it?

That's because Ubuntu and Fedora use different stock themes. I think it 
makes sense to use the i graphic from the visual design wherever you're 
currently using gtk.STOCK_INFO.

>> Further, there are still hard-coded colour values. Are these issues on
>> the "to fix later" list?
> Do you mean the green progress bar and others? For the progress bar, Jessica has a comment that she doesn't want see orange bar which is the default on Ubuntu but want to see a green one which is consistent with the running color in the build details.
> For some buttons like "Just bake", we try to make it look the same as Belen's video.
> Are you suggesting to set them default?

I am, but I guess the design team needs to have the final say here. I 
think Belen agreed with me in principle that we should use the colours 
from the users theme to start and iterate from there. On my Fedora 
machine green progress bars and orange buttons look rather out of place 
in a software ecosystem which has a fairly consistent look and feel 
between applications. However I care less about the colours than I do 
about the button order, per my submitted patches.

> If not the above, the hard-coded color values should be fixed, we hope to include all color values in hobcolor.py
>
>
>>
>> I'm not suggesting these hold up merging - just asking the question. I
>> can play HIG zealot and write a patch once this is merged? I think it's
>> important we present a professional GUI which matches the visuals of the
>> host OS.
>>
>> The buttons that act like tabs for changing between notebook pages (i.e.
>> on the 'Package Selection' view) took me a long time to figure out as
>> they look like they are depressed (mid-click) buttons for the inactive
>> tabs and ready to click buttons for the active tabs - confusing visual.
> I have the patches to fix it, and am cleaning them up for submission.

Excellent!

>>
>> There's at least one instance of commented out code (a signal handler
>> connection in builder.py) - we can probably drop those, right?
> Do you mean to drop the handler instance in builder.py?
> If so, how could the builder call the handler's functions?

There's a commented out line which would connect to a signal handler 
where it not commented out at line 201 of builder.py:
http://git.yoctoproject.org/cgit/cgit.cgi/poky/tree/bitbake/lib/bb/ui/crumbs/builder.py#n201

We can probably delete that, right?

>>
>> Setting the size and position of windows on each launch (as in
>> builder.py) is generally considered to be hostile to users - it should
>> be sufficient to start with a sane default size and then as the UI
>> allows the user to resize it we should remember the size for the next
>> launch.
> OK. But sometimes we should consider the screen dimension. For instance the builder, the main window, I bet on a smaller screen (say, 800X600) the visual components will look ugly. How can I address the problem? For the position of the window, I agree.

I don't think that telling people their resolution is too low is 
especially helpful here. They can probably see that the GUI doesn't fit.

I don't know anyone that runs their system with a lower than supported 
resolution, so telling them about something they can't fix doesn't help 
them. It just adds insult to injury, so to speak.

Cheers,
Joshua
-- 
Joshua Lock
         Yocto Project "Johannes factotum"
         Intel Open Source Technology Centre


