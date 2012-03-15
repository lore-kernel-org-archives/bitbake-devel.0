Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1S8Ev2-0001Qa-HB
	for bitbake-devel@lists.openembedded.org;
	Thu, 15 Mar 2012 18:56:56 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 15 Mar 2012 10:48:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="118024335"
Received: from unknown (HELO [10.255.15.198]) ([10.255.15.198])
	by orsmga001.jf.intel.com with ESMTP; 15 Mar 2012 10:47:07 -0700
Message-ID: <4F622B1B.9050505@linux.intel.com>
Date: Thu, 15 Mar 2012 10:47:07 -0700
From: Joshua Lock <josh@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
MIME-Version: 1.0
To: "Xu, Dongxiao" <dongxiao.xu@intel.com>
References: <cover.1331716896.git.dongxiao.xu@intel.com>
	<c30b412003be68dd9c060e2d227f85232e4492ff.1331716896.git.dongxiao.xu@intel.com>
	<4F60F38B.40506@linux.intel.com>
	<1331791328.1855.21.camel@dongxiao-osel>
In-Reply-To: <1331791328.1855.21.camel@dongxiao-osel>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 04/11] Hob: Fix the image installation dependency
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
X-List-Received-Date: Thu, 15 Mar 2012 17:56:56 -0000
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 14/03/12 23:02, Xu, Dongxiao wrote:
> On Wed, 2012-03-14 at 12:37 -0700, Joshua Lock wrote:
>>
>> On 14/03/12 02:26, Dongxiao Xu wrote:
>>> Get the image installation content from rdepends and rrecommends
>>> variables.
>>>
>>> Signed-off-by: Dongxiao Xu<dongxiao.xu@intel.com>
>>> ---
>>>    lib/bb/ui/crumbs/hoblistmodel.py |    6 ++----
>>>    1 files changed, 2 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/lib/bb/ui/crumbs/hoblistmodel.py b/lib/bb/ui/crumbs/hoblistmodel.py
>>> index 0b7c0cb..0378828 100644
>>> --- a/lib/bb/ui/crumbs/hoblistmodel.py
>>> +++ b/lib/bb/ui/crumbs/hoblistmodel.py
>>> @@ -546,9 +546,7 @@ class RecipeListModel(gtk.ListStore):
>>>                group = event_model["pn"][item]["section"]
>>>                install = []
>>>
>>> -            depends = event_model["depends"].get(item, [])
>>> -            rdepends = event_model["rdepends-pn"].get(item, [])
>>> -            depends = depends + rdepends
>>> +            depends = event_model["depends"].get(item, []) + event_model["rdepends-pn"].get(item, [])
>>>
>>>                if ('task-' in name):
>>>                    if ('lib32-' in name or 'lib64-' in name):
>>> @@ -557,7 +555,7 @@ class RecipeListModel(gtk.ListStore):
>>>                        atype = 'task'
>>>                elif ('-image-' in name):
>>>                    atype = 'image'
>>> -                install = rdepends
>>> +                install = event_model["rdepends-pkg"].get(item, []) + event_model["rrecs-pkg"].get(item, [])
>>
>> rrecs should be recommendations, not requirements - are we making the
>> conscious decision to include all recommended packages when building
>> with Hob?
>
> Per my understanding, RRECOMMENDS means that if the recommended package
> do exists, then install it. Else if it doesn't, system will not report
> error as missing dependency. (Correct me if it is wrong)

I thought that the behaviour was dependant on which package backend you 
use (RPM, etc.) but the Yocto documentation agrees with your assertion 
so this  behaviour seems reasonable.

Cheers,
Joshua
-- 
Joshua '贾詡' Lock
         Yocto Project "Johannes factotum"
         Intel Open Source Technology Centre


