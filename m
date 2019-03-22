Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id E69D76C111
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 22 Mar 2019 03:46:44 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id x2M3kiGC022056
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Thu, 21 Mar 2019 20:46:45 -0700 (PDT)
Received: from [128.224.163.177] (128.224.163.177) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.40) with Microsoft SMTP Server id 14.3.439.0;
	Thu, 21 Mar 2019 20:46:44 -0700
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	<bitbake-devel@lists.openembedded.org>
References: <cover.1552555629.git.liezhi.yang@windriver.com>
	<b3ade2ccda56d3abbe44c5ede950093995f8b536.1552555629.git.liezhi.yang@windriver.com>
	<72417715c42b0b3841681387fc85c68f120aa1a2.camel@linuxfoundation.org>
From: Robert Yang <liezhi.yang@windriver.com>
Message-ID: <e24f2038-93ba-9911-39aa-a2d29bb145ba@windriver.com>
Date: Fri, 22 Mar 2019 11:51:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <72417715c42b0b3841681387fc85c68f120aa1a2.camel@linuxfoundation.org>
Subject: Re: [PATCH 2/5] fetch2: Add get_mirrorname()
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
X-List-Received-Date: Fri, 22 Mar 2019 03:46:45 -0000
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit



On 3/22/19 7:42 AM, Richard Purdie wrote:
> On Thu, 2019-03-14 at 17:28 +0800, Robert Yang wrote:
>> It can be used by both __init__.py and git.py.
>>
>> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
>> ---
>>   bitbake/lib/bb/fetch2/__init__.py | 5 ++++-
>>   bitbake/lib/bb/fetch2/git.py      | 2 +-
>>   2 files changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
>> index f112067..5062bb2 100644
>> --- a/bitbake/lib/bb/fetch2/__init__.py
>> +++ b/bitbake/lib/bb/fetch2/__init__.py
>> @@ -889,6 +889,9 @@ def runfetchcmd(cmd, d, quiet=False, cleanup=None, log=None, workdir=None):
>>   
>>       return output
>>   
>> +def get_mirrorname(ud):
>> +    return ud.host.replace(':','.') + ud.path.replace('/', '.').replace('*', '.')
>> +
>>   def check_network_access(d, info, url):
>>       """
>>       log remote network access, and error if BB_NO_NETWORK is set or the given
>> @@ -910,7 +913,7 @@ def build_mirroruris(origud, mirrors, ld):
>>       replacements["HOST"] = origud.host
>>       replacements["PATH"] = origud.path
>>       replacements["BASENAME"] = origud.path.split("/")[-1]
>> -    replacements["MIRRORNAME"] = origud.host.replace(':','.') + origud.path.replace('/', '.').replace('*', '.')
>> +    replacements["MIRRORNAME"] = get_mirrorname(origud)
>>   
>>       def adduri(ud, uris, uds, mirrors, tarballs):
>>           for line in mirrors:
>> diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
>> index cf8bee7..45d7303 100644
>> --- a/bitbake/lib/bb/fetch2/git.py
>> +++ b/bitbake/lib/bb/fetch2/git.py
>> @@ -248,7 +248,7 @@ class Git(FetchMethod):
>>                       ud.unresolvedrev[name] = ud.revisions[name]
>>                   ud.revisions[name] = self.latest_revision(ud, d, name)
>>   
>> -        gitsrcname = '%s%s' % (ud.host.replace(':', '.'), ud.path.replace('/', '.').replace('*', '.'))
>> +        gitsrcname = bb.fetch2.get_mirrorname(ud)
>>           if gitsrcname.startswith('.'):
>>               gitsrcname = gitsrcname[1:]
>>   
> 
> I think your patch is highlighting a deeper problem here. The mirror
> name is something which the given fetcher module should be decoding and
> this shouldn't handled in __init__.py unless its some kind of default.
> 
> We probably need to look more deeply about why git fetcher knowledge is
> being used in the general case and fix that instead...

Make sense, I will work on it.

// Robert

> 
> Cheers,
> 
> Richard
> 
> 

