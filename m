Return-Path: <jason.wessel@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id CDCD66E3BB
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Mar 2014 15:25:58 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.5) with ESMTP id s2SFPu73011102
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Fri, 28 Mar 2014 08:25:56 -0700 (PDT)
Received: from [10.0.2.15] (147.11.118.122) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.40) with Microsoft SMTP Server id 14.3.169.1;
	Fri, 28 Mar 2014 08:25:56 -0700
Message-ID: <53359484.7070707@windriver.com>
Date: Fri, 28 Mar 2014 10:25:56 -0500
From: Jason Wessel <jason.wessel@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:24.0) Gecko/20100101 Thunderbird/24.3.0
MIME-Version: 1.0
To: Paul Eggleton <paul.eggleton@linux.intel.com>
References: <1395821145-2242-1-git-send-email-cristiana.voicu@intel.com>
	<CAL7ttbdPWNTANmGEEK9T7OwQ7HY0j1xtMdhJeOdouvEZ__cvwQ@mail.gmail.com>
	<5335718B.3070709@windriver.com>
	<2703747.EGqZ9dGWcs@peggleto-mobl5.ger.corp.intel.com>
In-Reply-To: <2703747.EGqZ9dGWcs@peggleto-mobl5.ger.corp.intel.com>
X-Enigmail-Version: 1.6
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] cooker: bitbake memres server should not always reload the cache
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
X-List-Received-Date: Fri, 28 Mar 2014 15:25:58 -0000
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

On 03/28/2014 09:22 AM, Paul Eggleton wrote:
> On Friday 28 March 2014 07:56:43 Jason Wessel wrote:
>> On 03/28/2014 06:43 AM, Alex Damian wrote:
>>> Please hold merging this change.
>>>
>>> I think we need to discuss a bit on this. My expectation is that the
>>> Bitbake server will reinit its state between builds, re-parsing the
>>> configuration files and reload the cache. I am not sure why we would
>>> consider maintaining the hot cache copy in memory between builds.
>> It is about increasing the interactivity of the system.  There are certainly
>> times you need to soft reset, but perhaps that is what we need to expose. 
>> If I want to run a dev shell and have done a build, this is something I'd
>> like to be instantaneous, or if I am working on the package and want to
>> re-run the compile and package steps, there really is no need to parse.
>>
>> There is a trade off for the individual package work vs the work of
>> rebuilding the entire image.  In the case of the entire image you most
>> certainly want the soft reset behavior.
> To my mind it depends on the likelihood of something having changed and 
> whether that change might affect what you would be doing with the action that 
> follows. For example. if you're trying to fix the execution of a particular 
> task, you would expect to see any change in the recipe / configuration to take 
> effect when re-running the task.

I think there should be a lighter weight way to check then.  I have to believe we could actually check all the time stamps pretty quickly if we have them stored away as a part of the parse for all the files that were touched.  I admit I have not looked a whole lot at what determines when to re-parse / soft reset, but I have to believe we can come up with a light enough way in mem-res mode so as not to pay a reparse toll like we are doing presently.  Perhaps this is what the cache check already does today?

Perhaps you know what all is going on when the bitbake cache is doing its load (which takes ~ 2 seconds or so) for the set of recipes I was interested in.  My goal here is merely to improve the interactivity, assuming it is possible.

Cheers,
Jason.

