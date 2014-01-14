Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id BC5F36B50C
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 14 Jan 2014 02:39:02 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.5) with ESMTP id s0E2cxr4009777
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Mon, 13 Jan 2014 18:38:59 -0800 (PST)
Received: from [128.224.162.226] (128.224.162.226) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.40) with Microsoft SMTP Server id 14.2.347.0;
	Mon, 13 Jan 2014 18:38:58 -0800
Message-ID: <52D4A33F.2030501@windriver.com>
Date: Tue, 14 Jan 2014 10:38:55 +0800
From: Robert Yang <liezhi.yang@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux i686;
	rv:24.0) Gecko/20100101 Thunderbird/24.0
MIME-Version: 1.0
To: Richard Purdie <richard.purdie@linuxfoundation.org>
References: <cover.1389601138.git.liezhi.yang@windriver.com>	
	<69aa90ef3b947f39f49563b84a10c226d7df61d8.1389601138.git.liezhi.yang@windriver.com>
	<1389654461.14987.32.camel@ted>
In-Reply-To: <1389654461.14987.32.camel@ted>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/1] bitbake: data.py: convert "__" to "-" for PREFERRED_VERSION
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
X-List-Received-Date: Tue, 14 Jan 2014 02:39:03 -0000
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit


I've update the PULL, changes:

1) Not only for the PREFERRED_VERSION, but for all env vars.
2) Also take care of the exportlist, though we don't have to care
    about it currently, but maybe in the future.

git://git.pokylinux.org/poky-contrib rbt/pv

// Robert

On 01/14/2014 07:07 AM, Richard Purdie wrote:
> On Mon, 2014-01-13 at 03:19 -0500, Robert Yang wrote:
>> We can set the PREFERRED_VERSION from the command line:
>>
>> $ export BB_PRESERVE_ENV=1
>> $ PREFERRED_VERSION_recipe="pv" bitbake recipe
>>
>> But it doesn't work if the recipe name contain the "-" since we can't
>> use "-" in shell's variable name,  use '__' instead of '-' in the env
>> will make it work.
>>
>> We also need update the doc, I will mark the bug as "doc changes
>> required".
>>
>> [YOCTO #4965]
>>
>> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
>> ---
>>   bitbake/lib/bb/data.py |   11 ++++++++++-
>>   1 file changed, 10 insertions(+), 1 deletion(-)
>
> Should we do this just for PREFERRED_VERSION or all environment
> variables? I can't think of a case we'd use __ currently but I can think
> of other variable names where this mapping would help...
>
> Any strong opinions?
>
> Cheers,
>
> Richard
>
>> diff --git a/bitbake/lib/bb/data.py b/bitbake/lib/bb/data.py
>> index 5840803..666cdcb 100644
>> --- a/bitbake/lib/bb/data.py
>> +++ b/bitbake/lib/bb/data.py
>> @@ -171,11 +171,20 @@ def expandKeys(alterdata, readdata = None):
>>
>>   def inheritFromOS(d, savedenv, permitted):
>>       """Inherit variables from the initial environment."""
>> +    # We can set the PREFERRED_VERSION_recipe from the shell env, but we
>> +    # can't use "-" in shell's variable name, so we use '__' instead of
>> +    # '-' in the env, and translate it back here.
>> +    preferred_version_re = re.compile('PREFERRED_VERSION_.*__')
>> +
>>       exportlist = bb.utils.preserved_envvars_exported()
>>       for s in savedenv.keys():
>>           if s in permitted:
>>               try:
>> -                d.setVar(s, getVar(s, savedenv, True), op = 'from env')
>> +                if preferred_version_re.match(s):
>> +                    s_new = s.replace('__', '-')
>> +                    d.setVar(s_new, getVar(s, savedenv, True), op = 'from env')
>> +                else:
>> +                    d.setVar(s, getVar(s, savedenv, True), op = 'from env')
>>                   if s in exportlist:
>>                       d.setVarFlag(s, "export", True, op = 'auto env export')
>>               except TypeError:
>
>
>
>

