Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1SXFOj-0002hk-Et
	for bitbake-devel@lists.openembedded.org;
	Wed, 23 May 2012 19:30:57 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 23 May 2012 10:20:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="156227171"
Received: from unknown (HELO [10.255.12.49]) ([10.255.12.49])
	by fmsmga001.fm.intel.com with ESMTP; 23 May 2012 10:20:46 -0700
Message-ID: <4FBD1C6E.9030800@linux.intel.com>
Date: Wed, 23 May 2012 10:20:46 -0700
From: Joshua Lock <josh@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:12.0) Gecko/20120430 Thunderbird/12.0.1
MIME-Version: 1.0
To: "Wang, Shane" <shane.wang@intel.com>
References: <cover.1334359238.git.josh@linux.intel.com>
	<3AB6CE7F274E534CAFD089D127A8A1FC23BAD871@SHSMSX102.ccr.corp.intel.com>
In-Reply-To: <3AB6CE7F274E534CAFD089D127A8A1FC23BAD871@SHSMSX102.ccr.corp.intel.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
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
X-List-Received-Date: Wed, 23 May 2012 17:30:57 -0000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Shane,

On 22/05/12 18:35, Wang, Shane wrote:
> Josh, I just found I can't run Hob on my Ubuntu 10.04 after I checked out the latest master.
>
> Since Ubuntu 10.04 is a long-term-support version, can we do something to make Hob compatible with that?

The plan is to provide an external-python-tarball with a full Gtk+ & 
PyGtk nativesdk stack built by OE-Core/Poky and installed into a 
standalone sysroot on the users host.

Whilst I have a branch based on some work by Richard to achieve this it 
hasn't been submitted to upstream as I haven't figured out a clean way 
to handle things on the SDK host which would usually require a 
postinstall in the target rootfs.

Aside: I really can't see a clean way around requiring postinst type 
functionality for the SDK targets, particularly in the pagno case here. 
I'm currently ruminating on supercharging the toolchain scripts to 
handle this.

> What kind of failure did you meet on Ubuntu 10.04?

IIRC the set_action_widget() API I referred to in the original email 
isn't available in the version of Gtk+ and PyGtk that was shipped with 
Ubuntu 10.04.

This is required to add the search entry to the gtk.Notebook.

Cheers,
Joshua

>
> --
> Shane
>
> Joshua Lock wrote on 2012-04-14:
>
>> *** This series prevents users of distros with old Gtk+ releases using Hob ***
>>
>> This is a follow-on from my RFC of yesterday with a similar title. Sadly I
>> hadn't realised that one of the API calls I am using is not available in the
>> version of gtk+ shipped with CentOS 6 (gtk.Notebook.set_action_widget).
>>
>> This change will prevent CentOS 6 users from being able to use Hob.
>>
>> I spent some time in Gtk+ internals trying to figure out if we can
>> emulate the behaviour on older versions but the GtkNotebook widget
>> internals were enhanced significantly to support the set_action_widget
>> API.
>>
>> I've submitted the change as an RFC regardless, it's ready to merge if we're
>> willing to make the sacrifice.
>>
>> The primary motivation for making this change, and making it so late in
>> the cycle, is maintainability. The diffstat says it all - we're
>> replacing an ~400LOC custom widget with a ~100LOC set of 3 widgets which
>> subclass standard toolkit widgets.
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
>>
>> Cheers,
>> Joshua
>>
>> The following changes since commit
>> 434fdb3913cc78e2e9cdeede4c4fa7f1c8ef8892:
>>
>>    Hob: Added required packages for toolchain. (2012-04-13 12:00:12 +0100)
>> are available in the git repository at:
>>    git://github.com/incandescant/bitbake gtk2.20
>>    https://github.com/incandescant/bitbake/tree/gtk2.20
>> Joshua Lock (4):
>>    lib/bb/ui/crumbs/: replace custom HobNotebook
>>    lib/bb/ui/crumbs/hobwidget: use light text in HobIndicator
>>    lib/bb/ui/crumbs/imageconfiguration: fix combo boxes drop-down width
>>    hob: update required pygtk to 2.22.0 and gtk+ to 2.20.0
>>   lib/bb/ui/crumbs/builddetailspage.py       |    6 +-
>>   lib/bb/ui/crumbs/hobwidget.py              |  499
>>   +++++++--------------------- lib/bb/ui/crumbs/imageconfigurationpage.py
>>   |    2 - lib/bb/ui/crumbs/packageselectionpage.py   |    3 +-
>>   lib/bb/ui/crumbs/recipeselectionpage.py    |    5 +- lib/bb/ui/hob.py
>>                           |    2 +- 6 files changed, 120 insertions(+),
>>   397 deletions(-)
>

-- 
Joshua Lock
         Yocto Project
         Intel Open Source Technology Centre


