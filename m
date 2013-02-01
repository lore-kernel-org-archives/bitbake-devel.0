Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Liezhi.Yang@windriver.com>) id 1U17LH-0007nF-7J
	for bitbake-devel@lists.openembedded.org;
	Fri, 01 Feb 2013 04:31:17 +0100
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id r113FN09006091
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Thu, 31 Jan 2013 19:15:23 -0800 (PST)
Received: from [128.224.162.186] (128.224.162.186) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.2.318.4;
	Thu, 31 Jan 2013 19:15:22 -0800
Message-ID: <510B3347.1090008@windriver.com>
Date: Fri, 1 Feb 2013 11:15:19 +0800
From: Robert Yang <liezhi.yang@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux i686;
	rv:17.0) Gecko/20130106 Thunderbird/17.0.2
MIME-Version: 1.0
To: Paul Eggleton <paul.eggleton@linux.intel.com>
References: <cover.1359080497.git.liezhi.yang@windriver.com>
	<7274465.7DSL83VslB@helios>
In-Reply-To: <7274465.7DSL83VslB@helios>
Cc: bitbake-devel@lists.openembedded.org, Zhenfeng.Zhao@windriver.com
Subject: Re: [PATCH 0/2] bitbake-layers: print the recipe's depends that crosses a layer boundary
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
X-List-Received-Date: Fri, 01 Feb 2013 03:31:17 -0000
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit


Hi Pual,

Thank you very much, I've filed a defect for tracking this:

https://bugzilla.yoctoproject.org/show_bug.cgi?id=3824

Bug 3824 - bitbake-layers: let show-cross-depends avoid long path

// Robert

On 01/31/2013 10:04 PM, Paul Eggleton wrote:
> Hi Robert,
>
> On Friday 25 January 2013 16:35:08 Robert Yang wrote:
>> The following changes since commit 8d6e55bf2192524bda84138b5356a2791adbbe61:
>>
>>    prserv: add LOCALCOUNT to AUTOINCs migration feature (2013-01-22 16:01:32
>> +0000)
>>
>> are available in the git repository at:
>>    git://git.pokylinux.org/poky-contrib robert/bitbake-layers
>>
>> http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=robert/bitbake-layers
>>
>> Robert Yang (2):
>>    bitbake-layers: fix get_file_layer
>>    bitbake-layers: print the recipe's depends that crosses a layer
>>      boundary
>
> Looks good, thanks for implementing this. I think we might be able to improve
> the output formatting for this subcommand in a similar manner to the other
> subcommands a while ago (i.e. avoiding long paths but with an option to go
> back to the full path format - see show-overlayed and its -f option for an
> example) however this can be done at a later date.
>
> Cheers,
> Paul
>


