Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 6887A6116C
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  4 Jul 2014 08:23:06 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.5) with ESMTP id s648N4FV010322
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Fri, 4 Jul 2014 01:23:05 -0700 (PDT)
Received: from [128.224.162.181] (128.224.162.181) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.40) with Microsoft SMTP Server id 14.3.169.1;
	Fri, 4 Jul 2014 01:23:03 -0700
Message-ID: <53B66466.1070204@windriver.com>
Date: Fri, 4 Jul 2014 16:23:02 +0800
From: Robert Yang <liezhi.yang@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux i686;
	rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To: Richard Purdie <richard.purdie@linuxfoundation.org>
References: <cover.1404452300.git.liezhi.yang@windriver.com>	
	<c16e5647966901f79b9520ba0565220ebcd0fa3d.1404452300.git.liezhi.yang@windriver.com>
	<1404459386.6362.94.camel@ted>
In-Reply-To: <1404459386.6362.94.camel@ted>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/2] bitbake: update help message for dump-signatures
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
X-List-Received-Date: Fri, 04 Jul 2014 08:23:11 -0000
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit



On 07/04/2014 03:36 PM, Richard Purdie wrote:
> On Thu, 2014-07-03 at 22:39 -0700, Robert Yang wrote:
>> The bitbake -S had been updated which always reuires an argument, so
>> update the help info:
>> - Add the two args in the help message: none and printdiff
>>
>> - Use type="choice" so that we can get more friendly error messages,
>>    for example:
>>    bitbake: error: option -S: invalid choice: 'printdiffX' (choose from 'none', 'printdiff')
>>
>> - dump-signatures=DUMP_SIGNATURES -> dump-signatures=SIGNATURE_HANDLER
>>
>> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
>> ---
>>   bitbake/bin/bitbake |    4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/bitbake/bin/bitbake b/bitbake/bin/bitbake
>> index b3acbe1..5c25a9d 100755
>> --- a/bitbake/bin/bitbake
>> +++ b/bitbake/bin/bitbake
>> @@ -139,8 +139,8 @@ class BitBakeConfigParameters(cookerdata.ConfigParameters):
>>           parser.add_option("-n", "--dry-run", help = "Don't execute, just go through the motions.",
>>                      action = "store_true", dest = "dry_run", default = False)
>>
>> -        parser.add_option("-S", "--dump-signatures", help = "Dump out the signature construction information, with no task execution. Parameters are passed to the signature handling code, use 'none' if no specific handler is required.",
>> -                   action = "append", dest = "dump_signatures", default = [])
>> +        parser.add_option("-S", "--dump-signatures", help = "Dump out the signature construction information, with no task execution. The SIGNATURE_HANDLER can be none or printdiff, while none means only dump the signature, printdiff means compare the dumped signature with the cached one.",
>> +                   action = "append", dest = "dump_signatures", default = [], type="choice", choices=("none", "printdiff"), metavar="SIGNATURE_HANDLER")
>
> The problem here is the different options are (or will be) metadata
> defined and bitbake can't know which options may or may not be valid :(

Thanks, how about remove the type="choice" and update the help info to:

-S SIGNATURE_HANDLER, --dump-signatures=SIGNATURE_HANDLER
Dump out the signature construction information, with no task execution.
The SIGNATURE_HANDLER can be none, printdiff or other metadata defined
handlers, while none means only dump the signature, printdiff means compare
the dumped signature with the cached one.

Or drop the patch and update the user manual ?

I updated it was because when I used the bitbake -S, I didn't know there
is a very useful handler printdiff.

// Robert

>
> Cheers,
>
> Richard
>
>
>

