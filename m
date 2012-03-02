Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1S3X09-0004cd-Mg
	for bitbake-devel@lists.openembedded.org;
	Fri, 02 Mar 2012 19:14:45 +0100
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 02 Mar 2012 10:06:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="132462777"
Received: from unknown (HELO [10.255.15.107]) ([10.255.15.107])
	by fmsmga002.fm.intel.com with ESMTP; 02 Mar 2012 10:06:10 -0800
Message-ID: <4F510C11.5050000@linux.intel.com>
Date: Fri, 02 Mar 2012 10:06:09 -0800
From: Joshua Lock <josh@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
MIME-Version: 1.0
To: "Wang, Shane" <shane.wang@intel.com>
References: <439e7e3c5dd2534950c63d9df57963f1a3d35944.1330523904.git.shane.wang@intel.com>
	<0079cc38920b78e36e2371fb34bcffd12883da5f.1330523904.git.shane.wang@intel.com>
	<4F4E985B.1070606@linux.intel.com>
	<3AB6CE7F274E534CAFD089D127A8A1FC23ADFCDD@SHSMSX102.ccr.corp.intel.com>
In-Reply-To: <3AB6CE7F274E534CAFD089D127A8A1FC23ADFCDD@SHSMSX102.ccr.corp.intel.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 06/32] Hob: implement a self-defined notebook visual component for Hob
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
X-List-Received-Date: Fri, 02 Mar 2012 18:14:45 -0000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



On 01/03/12 23:06, Wang, Shane wrote:
> Joshua Lock wrote on 2012-03-01:
>
>>
>>
>> On 29/02/12 06:15, Shane Wang wrote:
>>> In recipe selection page, package selection page, and build details page,
>> etc, there is a notebook component which is not gtk.Notebook in the design
>> video.
>>> We implement the visual component with a drawing area, and use it to
>> replace the old notebook in recipe selection page and package selection
>> page.
>>>
>>> Signed-off-by: Liming An<limingx.l.an@intel.com>
>>> Signed-off-by: Shane Wang<shane.wang@intel.com>
>>
>> Code style comments below.
>>
>> More importantly, have we made sure we can't use the stock notebook
>> before we've implemented our own? The commit log tells me that we aren't
>> using gtk.Notebook but doesn't tell me why?
> 1) General speaking, gtk.Notebook doesn't look like the design Belen worked out.
> 2) And we all agree Belen's design looks better, for example, there is an indicator to show how many recipes or packages are included, and how many issues happened when building? Very straightforward.
> But technically, gtk.Notebook can't implement that. As far as we know, it can't.
>
> 3) Moreover, there is an entry for "search recipes", and "search packages". How to make it horizontal to the tabs is a problem to us.
> Regarding those, we give up gtk.Notebook and use our own.

This all seems reasonable but is the sort of information I'd expect to 
see documented in the code and the commit logs. :-)

>>
>> The implemented notebook is a reasonable start but it needs a lot of
>> polish before I'd want to see it shipped.
>> i.e. the green flashed border around the selected tabs is strange, the
>> drawing looks a little jaggy, especially the orange circle (not a
>> graphics guy so I don't know the right term) and I'm pretty certain the
>> number in the circle isn't centred. Finally (for now) once I get to
>> three digits the numbers don't fit in the circle.
> I agree we also have some to improve our Notebook, say, the border and the circle.
> If there is a jaggy, we can make it a rectangle instead of circle.
> But to be frank, I don't think gtk.Notebook looks better.

That's fine, and I'm not disagreeing - I'm just trying to follow what's 
happening and by reading the logs and code as is I don't see any of the 
rationale.

Cheers,

Joshua
-- 
Joshua Lock
         Yocto Project "Johannes factotum"
         Intel Open Source Technology Centre


