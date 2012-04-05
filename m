Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1SFpwH-0007Ez-Dv
	for bitbake-devel@lists.openembedded.org;
	Thu, 05 Apr 2012 18:53:37 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 05 Apr 2012 09:44:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="85739651"
Received: from unknown (HELO [10.255.12.114]) ([10.255.12.114])
	by AZSMGA002.ch.intel.com with ESMTP; 05 Apr 2012 09:44:24 -0700
Message-ID: <4F7DCBE7.5060906@linux.intel.com>
Date: Thu, 05 Apr 2012 09:44:23 -0700
From: Joshua Lock <josh@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:11.0) Gecko/20120329 Thunderbird/11.0.1
MIME-Version: 1.0
To: Paul Eggleton <paul.eggleton@linux.intel.com>
References: <cover.1333155656.git.josh@linux.intel.com>
	<72c1e44f0bc8b40583d16ff8b396faf8cf62fed9.1333155656.git.josh@linux.intel.com>
	<21867085.kuhcoOKVOX@helios>
In-Reply-To: <21867085.kuhcoOKVOX@helios>
Cc: bitbake-devel@lists.openembedded.org, Giulia Piu <giulia@closertag.com>
Subject: Re: [PATCH 1/1] lib/bb/ui/hob: exit cleanly if the required pygtk version isn't available
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
X-List-Received-Date: Thu, 05 Apr 2012 16:53:37 -0000
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05/04/12 09:32, Paul Eggleton wrote:
> On Friday 30 March 2012 18:05:29 Joshua Lock wrote:
>> Hob uses API from pygtk 2.22, therefore check to see whether this
>> version is available and exit cleanly if not.
>
> Apparently Belen and Giulia have been doing their hob testing on an F15
> machine (fully up-to-date) and it was working OK, now it is blocked by this
> check - the version of PyGTK+ on there is 2.17.
>
> Is that intended/desirable?

Not at all, we're definitely using method calls which the API docs tell 
me are only available in pygtk 2.22 or newer... I guess this isn't the case.

It's beginning to look like the API is from Gtk+ 2.22 but that pygtk 
fell out of sync for version numbers, I'll change the check to test the 
Gtk+ version.

FYI the goal is to lower the required API to Gtk+ 2.18.x and pygtk 
2.16.x as are shipped with CentOS 6.

Cheers,
Joshua
-- 
Joshua '贾詡' Lock
         Yocto Project "Johannes factotum"
         Intel Open Source Technology Centre


