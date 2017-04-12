Return-Path: <Zhixiong.Chi@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id D7A8977BC1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 12 Apr 2017 03:27:37 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id v3C3RYkP006408
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=OK);
	Tue, 11 Apr 2017 20:27:35 -0700
Received: from [128.224.162.239] (128.224.162.239) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.294.0;
	Tue, 11 Apr 2017 20:27:34 -0700
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	<bitbake-devel@lists.openembedded.org>
References: <1491816164-18274-1-git-send-email-zhixiong.chi@windriver.com>
	<1491922037.12091.20.camel@linuxfoundation.org>
From: Zhixiong Chi <zhixiong.chi@windriver.com>
Message-ID: <58ED9EA4.8020806@windriver.com>
Date: Wed, 12 Apr 2017 11:27:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
	Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <1491922037.12091.20.camel@linuxfoundation.org>
Subject: Re: bitbake-layers: add signal hander to avoid exception
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
X-List-Received-Date: Wed, 12 Apr 2017 03:27:38 -0000
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit



On 2017年04月11日 22:47, Richard Purdie wrote:
> On Mon, 2017-04-10 at 17:22 +0800, Zhixiong Chi wrote:
>> Fixed:
>> bitbake-layers show-recipes | less
>> press "q" to exit
>>
>> There will be a Broken pipe error output as follows:
>> "BrokenPipeError: [Errno 32] Broken pipe"
>>
>> Signed-off-by: Zhixiong Chi <zhixiong.chi@windriver.com>
>> ---
>>   bin/bitbake-layers | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/bin/bitbake-layers b/bin/bitbake-layers
>> index 390ad05..d58022d 100755
>> --- a/bin/bitbake-layers
>> +++ b/bin/bitbake-layers
>> @@ -20,6 +20,7 @@
>>   # with this program; if not, write to the Free Software Foundation,
>> Inc.,
>>   # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
>>   
>> +from signal import signal, SIGPIPE, SIG_DFL
> Stylistically, we tend to do:
>
> import signal
>
> signal.signal(signal.SIGPIPE, signal.SIG_DFL)

Thanks for your suggestion, I will send v2 patch later.

>
> so I've a small preference for that. I discussed this with Paul and we
> think other bitbake tools may also have this issue. We wondered if it
> was possible to do something more centrally in bitbake, and/or fix the
> other tools at the same time.
>
> Any thoughts on that?
I agree with this, unfortunately out testing team haven't met this issue 
in other bitbake tools yet.

Thanks.
>
> Cheers,
>
> Richard
>
>>   import logging
>>   import os
>>   import sys
>> @@ -35,6 +36,7 @@ import bb.msg
>>   logger = bb.msg.logger_create('bitbake-layers', sys.stdout)
>>   
>>   def main():
>> +    signal(SIGPIPE, SIG_DFL)
>>       parser = argparse.ArgumentParser(
>>           description="BitBake layers utility",
>>           epilog="Use %(prog)s <subcommand> --help to get help on a
>> specific command",
>> -- 
>> 1.9.1
>>

-- 
---------------------
Thanks,
Zhixiong Chi
Tel: +86-10-8477-7036


