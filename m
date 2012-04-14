Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1SJ923-000188-Hm
	for bitbake-devel@lists.openembedded.org;
	Sat, 14 Apr 2012 21:53:15 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 14 Apr 2012 12:43:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="132537666"
Received: from unknown (HELO [10.255.12.41]) ([10.255.12.41])
	by orsmga002.jf.intel.com with ESMTP; 14 Apr 2012 12:43:51 -0700
Message-ID: <4F89D377.7010505@linux.intel.com>
Date: Sat, 14 Apr 2012 12:43:51 -0700
From: Joshua Lock <josh@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:11.0) Gecko/20120329 Thunderbird/11.0.1
MIME-Version: 1.0
To: Richard Purdie <richard.purdie@linuxfoundation.org>
References: <cover.1334359238.git.josh@linux.intel.com>
	<1334398981.7309.98.camel@ted>
In-Reply-To: <1334398981.7309.98.camel@ted>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/4] Replace HobNotebook with gtk.Notebook, comments invited
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
X-List-Received-Date: Sat, 14 Apr 2012 19:53:15 -0000
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/04/12 03:23, Richard Purdie wrote:
> On Fri, 2012-04-13 at 16:24 -0700, Joshua Lock wrote:
>> *** This series prevents users of distros with old Gtk+ releases using Hob ***
>>
>> This is a follow-on from my RFC of yesterday with a similar title. Sadly I
>> hadn't realised that one of the API calls I am using is not available in the
>> version of gtk+ shipped with CentOS 6 (gtk.Notebook.set_action_widget).
>>
>> This change will prevent CentOS 6 users from being able to use Hob.
>>
>> I spent some time in Gtk+ internals trying to figure out if we can emulate the
>> behaviour on older versions but the GtkNotebook widget internals were enhanced
>> significantly to support the set_action_widget API.
>>
>> I've submitted the change as an RFC regardless, it's ready to merge if we're
>> willing to make the sacrifice.
>>
>> The primary motivation for making this change, and making it so late in the
>> cycle, is maintainability. The diffstat says it all - we're replacing an ~400LOC
>> custom widget with a ~100LOC set of 3 widgets which subclass standard toolkit
>> widgets.
>>
>> An added benefit is that standard toolkit widgets generally integrate better
>> into the users OS thanks to inheriting their standard theme.
>>
>> Tested on:
>> Fedora 16 (x86_64) - PASS
>> CentOS 6.2 (x86_64) - FAIL: Gtk+ version too old
>> Ubuntu 10.04 (x86_64) - Fail: pygtk version too old
>> Ubuntu 12.04 Beta (x86_64) - PASS
>>
>> Per the final patch in the series the changes here require gtk+-2.20 or newer
>> and pygtk 2.22 or newer.
>
> Since we don't have a good external-python tarball solution in place
> yet, I'm going to have to hold off these patches until after the current
> release.

This makes perfect sense and I agree with the decision.

Thanks,
Joshua
-- 
Joshua Lock
         Yocto Project
         Intel Open Source Technology Centre


