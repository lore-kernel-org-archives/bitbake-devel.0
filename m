Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 69D0665CBC
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 17 Aug 2015 07:52:46 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.15.1/8.15.1) with ESMTPS id t7H7qjGl026460
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Mon, 17 Aug 2015 00:52:45 -0700 (PDT)
Received: from [128.224.162.200] (128.224.162.200) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.40) with Microsoft SMTP Server id 14.3.235.1;
	Mon, 17 Aug 2015 00:52:44 -0700
Message-ID: <55D192CA.7040900@windriver.com>
Date: Mon, 17 Aug 2015 15:52:42 +0800
From: Robert Yang <liezhi.yang@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux i686;
	rv:31.0) Gecko/20100101 Thunderbird/31.8.0
MIME-Version: 1.0
To: Richard Purdie <richard.purdie@linuxfoundation.org>
References: <cover.1439449677.git.liezhi.yang@windriver.com>	
	<629f01246969a76254c26d5e614ebef5c1ed4270.1439449677.git.liezhi.yang@windriver.com>
	<1439797588.1218.37.camel@linuxfoundation.org>
In-Reply-To: <1439797588.1218.37.camel@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/1] fetch2/git.py: fix _latest_revision for local PREMIRROR
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
X-List-Received-Date: Mon, 17 Aug 2015 07:52:50 -0000
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit



On 08/17/2015 03:46 PM, Richard Purdie wrote:
> On Thu, 2015-08-13 at 00:08 -0700, Robert Yang wrote:
>> - Fixed when SRCREV = "${AUTOREV}", and set BB_NO_NETWORK = "1":
>> $ bitbake <recipe> -ccleanall
>> | DEBUG: Executing python function do_cleanall
>> | DEBUG: Python function do_cleanall finished
>> | ERROR: Function failed: Network access disabled through BB_NO_NETWORK ...
>>
>> - Fixed when SRCREV = "${AUTOREV}", set BB_NO_NETWORK = "1"  and use
>>    local PREMIRROR:
>> $ bitbake <recipe> -cfetchall
>> | DEBUG: Python function do_fetch finished
>> | ERROR: Function failed: Network access disabled through BB_NO_NETWORK ...
>>
>> Stop running "git ls-remote" when BB_NO_NETWORK would fix the problem.
>>
>> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
>> ---
>>   bitbake/lib/bb/fetch2/git.py |    7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
>> index 374d846..67ee107 100644
>> --- a/bitbake/lib/bb/fetch2/git.py
>> +++ b/bitbake/lib/bb/fetch2/git.py
>> @@ -350,7 +350,6 @@ class Git(FetchMethod):
>>           """
>>           Compute the HEAD revision for the url
>>           """
>> -        output = self._lsremote(ud, d, "")
>>           # Tags of the form ^{} may not work, need to fallback to other form
>>           if ud.unresolvedrev[name][:5] == "refs/":
>>               head = ud.unresolvedrev[name]
>> @@ -358,6 +357,12 @@ class Git(FetchMethod):
>>           else:
>>               head = "refs/heads/%s" % ud.unresolvedrev[name]
>>               tag = "refs/tags/%s" % ud.unresolvedrev[name]
>> +        # Only ls-remote when url is "file://" or BB_NO_NETWORK != "1",
>> +        # this makes local mirror works.
>> +        if ud.proto.lower() == 'file' or d.getVar("BB_NO_NETWORK", True) != "1":
>> +            output = self._lsremote(ud, d, "")
>> +        else:
>> +            output = "%s %s" % (name, head)
>>           for s in [head, tag + "^{}", tag]:
>>               for l in output.split('\n'):
>>                   if s in l:
>
> The idea is that when BB_NO_NETWORK is set, network accesses show
> errors. This would stop that happening in all cases and lead to silent
> failures which would be bad for user experience.

Thanks, do you have any ideas on how to fix the problem when use local
mirror for SRCREV = "${AUTOREV}" recipes, please ?

// Robert

>
> So no, this isn't an acceptable way to fix this, sorry.
>
> Cheers,
>
> Richard
>
>
>
>
>
>
>
>
>
>

