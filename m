Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id C7E276B880
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 14 Jan 2014 01:44:45 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.5) with ESMTP id s0E1ijKn007643
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Mon, 13 Jan 2014 17:44:45 -0800 (PST)
Received: from [128.224.162.226] (128.224.162.226) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.40) with Microsoft SMTP Server id 14.2.347.0;
	Mon, 13 Jan 2014 17:44:45 -0800
Message-ID: <52D4968B.4030402@windriver.com>
Date: Tue, 14 Jan 2014 09:44:43 +0800
From: Robert Yang <liezhi.yang@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux i686;
	rv:24.0) Gecko/20100101 Thunderbird/24.0
MIME-Version: 1.0
To: Gary Thomas <gary@mlbassoc.com>, <bitbake-devel@lists.openembedded.org>
References: <cover.1389601138.git.liezhi.yang@windriver.com>	<69aa90ef3b947f39f49563b84a10c226d7df61d8.1389601138.git.liezhi.yang@windriver.com>
	<52D3CAC4.5090807@mlbassoc.com>
In-Reply-To: <52D3CAC4.5090807@mlbassoc.com>
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
X-List-Received-Date: Tue, 14 Jan 2014 01:44:46 -0000
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit



On 01/13/2014 07:15 PM, Gary Thomas wrote:
> On 2014-01-13 01:19, Robert Yang wrote:
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
>>
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
>>
>
> Are you sure this is correct for the 's in exportlist' case?
>

Yes, I think so, the exportlist contains constant:

['BB_TASKHASH', 'HOME', 'LOGNAME', 'PATH', 'PWD', 'SHELL', 'TERM', 'USER']

So we don't have to worry about it.

> Perhaps the change should look like this (which is also easier to read):
> @@ -175,6 +175,8 @@ def inheritFromOS(d, savedenv, permitted):
>       for s in savedenv.keys():
>           if s in permitted:
>               try:
> +                if preferred_version_re.match(s):
> +                    s = s.replace('__', '-')
>                   d.setVar(s, getVar(s, savedenv, True), op = 'from env')

We must need the s_new (or s_to) here, because:

  d.setVar(s_to, getVar(s_from, savedenv, True), xxx)

the s_to and s_from are different.

// Robert

>                   if s in exportlist:
>                       d.setVarFlag(s, "export", True, op = 'auto env export')
>

