Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 411CB6E645
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  9 Jul 2015 05:57:33 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.15.1/8.15.1) with ESMTPS id t695vUlh021397
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Wed, 8 Jul 2015 22:57:30 -0700 (PDT)
Received: from [128.224.162.200] (128.224.162.200) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.40) with Microsoft SMTP Server id 14.3.224.2;
	Wed, 8 Jul 2015 22:57:30 -0700
Message-ID: <559E0D48.8030302@windriver.com>
Date: Thu, 9 Jul 2015 13:57:28 +0800
From: Robert Yang <liezhi.yang@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux i686;
	rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To: Richard Purdie <richard.purdie@linuxfoundation.org>
References: <cover.1436232786.git.liezhi.yang@windriver.com>	
	<fc82e0723a4877cdcd92e97cd2cf19f4a5d0ff70.1436232786.git.liezhi.yang@windriver.com>	
	<1436282262.27597.183.camel@linuxfoundation.org>	
	<10060998.dTQVzXkhxA@peggleto-mobl.ger.corp.intel.com>	
	<559C7CD3.5080100@windriver.com>
	<1436344085.27597.207.camel@linuxfoundation.org>
In-Reply-To: <1436344085.27597.207.camel@linuxfoundation.org>
Cc: Paul Eggleton <paul.eggleton@linux.intel.com>,
	bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/1] git.py: create a branch when checkout
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
X-List-Received-Date: Thu, 09 Jul 2015 05:57:33 -0000
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit


Thanks, I will send a V2.

// Robert

On 07/08/2015 04:28 PM, Richard Purdie wrote:
> On Wed, 2015-07-08 at 09:28 +0800, Robert Yang wrote:
>>
>> On 07/08/2015 12:56 AM, Paul Eggleton wrote:
>>> On Tuesday 07 July 2015 16:17:42 Richard Purdie wrote:
>>>> On Mon, 2015-07-06 at 18:33 -0700, Robert Yang wrote:
>>>>> Create a branch named oebuild_SRCREV when checkout the source, this
>>>>> makes debug easier than "(no branch)" when look into the source.
>>>>>
>>>>> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
>>>>> ---
>>>>>
>>>>>    bitbake/lib/bb/fetch2/git.py |    3 ++-
>>>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
>>>>> index 2e53882..12087dd 100644
>>>>> --- a/bitbake/lib/bb/fetch2/git.py
>>>>> +++ b/bitbake/lib/bb/fetch2/git.py
>>>>>
>>>>> @@ -280,7 +280,8 @@ class Git(FetchMethod):
>>>>>                    runfetchcmd("%s read-tree %s%s" % (ud.basecmd,
>>>>>                    ud.revisions[ud.names[0]], readpathspec), d)
>>>>>                    runfetchcmd("%s checkout-index -q -f -a" % ud.basecmd,
>>>>>                    d)
>>>>>
>>>>>                else:
>>>>> -                runfetchcmd("%s checkout %s" % (ud.basecmd,
>>>>> ud.revisions[ud.names[0]]), d) +                runfetchcmd("%s checkout
>>>>> %s -b oebuild_%s" % (ud.basecmd, \ +
>>>>> ud.revisions[ud.names[0]], ud.revisions[ud.names[0]]), d)>
>>>>>            return True
>>>>
>>>> Would it not make more sense to set the branch to the upstream branch
>>>> name here?
>>>
>>> I'd go one step further, use the upstream branch name and also set it to track
>>> the remote branch as well.
>>
>> Hi Paul and RP,
>>
>> I'm afraid that the ud.revisions[ud.names[0]] which is SRCREV may
>> not point to an upstream branch or tag, please ?
>
> ud.revisions might not, but ud.branches should. I think you want
> something like:
>
> branchcmd = ""
> if not ud.nobranch:
>      branchcmd = "-b %s" % ud.branches[ud.names[0]]
> runfetchcmd("%s checkout %s %s" % (ud.basecmd, ud.revisions[ud.names[0]], branchcmd), d)
>
> However as Paul notes, setting it to track the upstream remote branch
> would also be ideal.
>
> Cheers,
>
> Richard
>
>
>

