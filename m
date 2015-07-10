Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 46E2C65CBD
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 10 Jul 2015 00:00:37 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.15.1/8.15.1) with ESMTPS id t6A00bB9012105
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Thu, 9 Jul 2015 17:00:37 -0700 (PDT)
Received: from [128.224.162.200] (128.224.162.200) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.40) with Microsoft SMTP Server id 14.3.224.2;
	Thu, 9 Jul 2015 17:00:37 -0700
Message-ID: <559F0B23.7030208@windriver.com>
Date: Fri, 10 Jul 2015 08:00:35 +0800
From: Robert Yang <liezhi.yang@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux i686;
	rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To: Paul Eggleton <paul.eggleton@linux.intel.com>
References: <cover.1436426161.git.liezhi.yang@windriver.com>
	<f4363d0889b1e45cdbde18bd6ae94115f783b82f.1436426161.git.liezhi.yang@windriver.com>
	<4577144.KC5lOY8eR9@peggleto-mobl.ger.corp.intel.com>
In-Reply-To: <4577144.KC5lOY8eR9@peggleto-mobl.ger.corp.intel.com>
Cc: bitbake-devel@lists.openembedded.org
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
X-List-Received-Date: Fri, 10 Jul 2015 00:00:38 -0000
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit



On 07/10/2015 12:54 AM, Paul Eggleton wrote:
> On Thursday 09 July 2015 00:18:01 Robert Yang wrote:
>> * Create a branch and named as upstream branch when checkout source
>> * Set the branch to track remote branch.
>>
>> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
>> ---
>>   bitbake/lib/bb/fetch2/git.py |    7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
>> index 2e53882..afa3d0a 100644
>> --- a/bitbake/lib/bb/fetch2/git.py
>> +++ b/bitbake/lib/bb/fetch2/git.py
>> @@ -279,8 +279,15 @@ class Git(FetchMethod):
>>               if subdir != "":
>>                   runfetchcmd("%s read-tree %s%s" % (ud.basecmd,
>> ud.revisions[ud.names[0]], readpathspec), d) runfetchcmd("%s checkout-index
>> -q -f -a" % ud.basecmd, d)
>> +            elif not ud.nobranch:
>> +                branchname =  ud.branches[ud.names[0]]
>> +                runfetchcmd("%s checkout -B %s %s" % (ud.basecmd,
>> branchname, \
>> +                            ud.revisions[ud.names[0]]), d)
>> +                runfetchcmd("%s branch --set-upstream %s origin/%s" %
>> (ud.basecmd, branchname, \
>> +                            branchname), d)
>
> Doesn't git checkout support a --track option so we could do this in one
> command rather than two?

I'm afraid that we can use --track here, the supported commands are:
git checkout -b <branch> --track <remote>/<branch>
or
git checkout -b <branch> <start point>

What we need is something like:
git checkout -b <branch> --track <remote>/<branch> <start point>
but git doesn't support this.

// Robert

>
> Cheers,
> Paul
>

