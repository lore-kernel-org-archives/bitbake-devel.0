Return-Path: <Chong.Lu@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 49B84601F5
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  6 Feb 2015 06:52:17 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.9/8.14.5) with ESMTP id t166qH70024224
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Thu, 5 Feb 2015 22:52:18 -0800 (PST)
Received: from [128.224.162.204] (128.224.162.204) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server (TLS) id 14.3.174.1;
	Thu, 5 Feb 2015 22:52:17 -0800
Message-ID: <54D4649E.7080403@windriver.com>
Date: Fri, 6 Feb 2015 14:52:14 +0800
From: Chong Lu <Chong.Lu@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:24.0) Gecko/20100101 Thunderbird/24.0
MIME-Version: 1.0
To: Paul Eggleton <paul.eggleton@linux.intel.com>
References: <cover.1421990461.git.Chong.Lu@windriver.com>
	<1584081.qrVQXzTzW7@peggleto-mobl5.ger.corp.intel.com>
In-Reply-To: <1584081.qrVQXzTzW7@peggleto-mobl5.ger.corp.intel.com>
X-Originating-IP: [128.224.162.204]
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH V3 0/2] bitbake-layers: add a ability to query layer dependencies from layer index
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
X-List-Received-Date: Fri, 06 Feb 2015 06:52:29 -0000
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit


On 02/03/2015 12:05 AM, Paul Eggleton wrote:
> Hi Chong,
>
> On Friday 23 January 2015 13:28:32 Chong Lu wrote:
>> Change since V2:
>> re-split for IPv6 URL parsing
>>
>> The following changes since commit 35c9fa0588ed8e88b541a6c80cc1517324616cea:
>>
>>    maintainers: Update for non-maintained recipes (2015-01-20 21:39:41 +0000)
>>
>> are available in the git repository at:
>>
>>    git://git.pokylinux.org/poky-contrib chonglu/layerindex
>>    http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=chonglu/layerindex
>>
>> Chong Lu (2):
>>    bitbake.conf: Add two variables for layer index
>>    bitbake-layers: add a ability to query layer dependencies from layer index
> Apologies for the delay in getting back to you. This is definitely improving,
> some feedback though:
>
> * I think the new subcommand would make more sense if it were switched around
> so that it was fetching by default (and renamed as appropriate). Perhaps
> "layerindex-fetch" (with -n to avoid fetching and just report what it would
> fetch).
>
> * I think the layer index URL specified in the OE variable should be to the
> root rather than to /api - instead have that suffix added by the code that does
> the API calls. This makes it usable as a URL for the index for presenting to
> the user if needed.
>
> * Can you rename the two variables to BBLAYERS_LAYERINDEX_URL and
> BBLAYERS_FETCH_DIR (sorry I didn't think of this earlier).

I don't understand why does uname? Or, would you give me a example?

>
> * Please mention bitbake-layers in the comment above the settings in
> bitbake.conf so it's clear where these variables are used.

And I don't understand this one """

Please mention bitbake-layers in the comment above the settings in
bitbake.conf so it's clear where these variables are used.

"""
Would you explain in details?

Best Regards
Chong

>
> * By using -q with git you lose the status output which can be very useful
> given how long it can take to fetch some layers e.g. meta-oe, so can you drop
> this?
>
> * Can you add a check to see if the layer has already been fetched before
> fetching it and skip the fetch if it does (but not skip the add)?
>
> * If I run "bitbake-layers show-layer-deps meta-security" I get an error:
> ERROR: Can NOT get meta-security git repo and subdir
> (The code currently expects there to be a subdir, but this is an optional
> field, not all layers have a subdirectory, meta-security is one example.)
>
> * I think you may be able to get away with skipping the initial parse by
> passing config_only=True to init_bbhandler(). If you can, this will save a bit
> of time each time you run the command.
>
> Thanks,
> Paul
>


