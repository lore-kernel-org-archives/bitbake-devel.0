Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <mihaix.lindner@linux.intel.com>) id 1Spdw1-0005Yc-DV
	for bitbake-devel@lists.openembedded.org;
	Fri, 13 Jul 2012 13:21:21 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 13 Jul 2012 04:09:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="192185942"
Received: from linux.jf.intel.com (HELO linux.intel.com) ([10.23.219.25])
	by fmsmga002.fm.intel.com with ESMTP; 13 Jul 2012 04:08:58 -0700
Received: from [10.237.105.146] (mlindnex-mobl1.ger.corp.intel.com
	[10.237.105.146])
	by linux.intel.com (Postfix) with ESMTP id 979C52C8001
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 13 Jul 2012 04:09:01 -0700 (PDT)
Message-ID: <500001C9.1040705@linux.intel.com>
Date: Fri, 13 Jul 2012 14:08:57 +0300
From: Mihai Lindner <mihaix.lindner@linux.intel.com>
Organization: Intel OTC
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64;
	rv:13.0) Gecko/20120614 Thunderbird/13.0.1
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
References: <098684E1B7B2F54491C5DA349D2EF443098FD828@POCITMSEXMB03.LntUniverse.com>
	<4FFFCBD3.7080809@windriver.com>
In-Reply-To: <4FFFCBD3.7080809@windriver.com>
Subject: Re: bitbake error
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
X-List-Received-Date: Fri, 13 Jul 2012 11:21:21 -0000
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 2012-07-13 10:18, Robert Yang wrote:
> 
> 
> On 07/12/2012 06:53 PM, Girija B wrote:
>> Hello,
>>
>> I have installed bitbake and open embedded environment , when i run the command : bitbake meta-toolchain-qte , am getting the following error :
>> Pseudo is not present but is required, building this first before the main build
>> ERROR: Failure expanding variable SRCPV, expression was ${@bb.fetch2.get_srcrev(d)} which triggered exception FetchError: Fetcher failure: Fetch command export HOME="/home/girija"; export SSH_AUTH_SOCK="/tmp/keyring-vMpejY/ssh"; export GIT_CONFIG="/home/girija/mft/platform/build/tmp-eglibc/sysroots/i686-linux/etc/gitconfig"; export PATH="/home/girija/mft/platform/build/tmp-eglibc/sysroots/i686-linux/usr/bin/armv5te-oe-linux-gnueabi:/home/girija/mft/platform/build/tmp-eglibc/sysroots/tonga2/usr/bin/crossscripts:/home/girija/mft/platform/build/tmp-eglibc/sysroots/i686-linux/usr/sbin:/home/girija/mft/platform/build/tmp-eglibc/sysroots/i686-linux/usr/bin:/home/girija/mft/platform/build/tmp-eglibc/sysroots/i686-linux/sbin:/home/girija/mft/platform/build/tmp-eglibc/sysroots/i686-linux//bin:/home/girija/mft/platform/3rd-party/bitbake/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/home/girija/mft/platform/3rd-party/openembedded-core/scripts"; git ls-r
 !
> em!
>>   ote ssh://git@savage-git:10221/var/lib/git/joule/joule-test-app master could not be run:
> 
> There is a "git ls-rem!", maybe this is a typo?
> 
> // Robert
> 
>> None
>> ERROR: Command execution failed: Exited with 1
>>
>> Summary: There were 2 ERROR messages shown, returning a non-zero exit code.
>>
>>
>>
>> please help me in solving this
>>
>> Thanks,
>> Girija.B
>> Larsen & Toubro Limited
>>
>> www.larsentoubro.com
>>
>> This Email may contain confidential or privileged information for the intended recipient (s). If you are not the intended recipient, please do not use or disseminate the information, notify the sender and delete it from your system.
>>
>> _______________________________________________
>> bitbake-devel mailing list
>> bitbake-devel@lists.openembedded.org
>> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel
>>
>>
> 
> 
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel
> 
> 
I would be more worried about the "ssh://git@*savage-git*:10221" part.
Is that from a custom(ized) recipe?

-- 
Mihai Lindner
Yocto Project




