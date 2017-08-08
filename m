Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 0B85C6E630
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  8 Aug 2017 14:33:50 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id v78EXpSs001557
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Tue, 8 Aug 2017 07:33:51 -0700 (PDT)
Received: from [128.224.162.246] (128.224.162.246) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.40) with Microsoft SMTP Server id 14.3.361.1;
	Tue, 8 Aug 2017 07:33:50 -0700
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	<bitbake-devel@lists.openembedded.org>
References: <cover.1502183410.git.liezhi.yang@windriver.com>
	<c75315a4930a447c156f55e1ce80f4354e1507e6.1502183410.git.liezhi.yang@windriver.com>
	<1502194474.18633.245.camel@linuxfoundation.org>
From: Robert Yang <liezhi.yang@windriver.com>
Message-ID: <f783857d-a0da-c4bb-92bc-ef6a908c38fe@windriver.com>
Date: Tue, 8 Aug 2017 22:33:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
	Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <1502194474.18633.245.camel@linuxfoundation.org>
Subject: Re: [WIP][RFC PATCH 2/5] bitbake: main: add log handler when status-only
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
X-List-Received-Date: Tue, 08 Aug 2017 14:33:51 -0000
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit



On 08/08/2017 08:14 PM, Richard Purdie wrote:
> On Tue, 2017-08-08 at 02:12 -0700, Robert Yang wrote:
>> The ui is not a must for logger, and use logger when status-only is
>> very good
>> for debugging.
>>
>> e.g.:
>> $ bitbake --status
>> NOTE: bitbake server is not running.
>>
>> $ bitbake --server-only -B localhost:-1
>> $ bitbake --status
>> NOTE: Reconnecting to bitbake server...
>>
>> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
>> ---
>>  bitbake/lib/bb/main.py | 4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/bitbake/lib/bb/main.py b/bitbake/lib/bb/main.py
>> index 62f9e1eacf1..fb082e7e0f3 100755
>> --- a/bitbake/lib/bb/main.py
>> +++ b/bitbake/lib/bb/main.py
>> @@ -397,9 +397,7 @@ def bitbake_main(configParams, configuration):
>>  def setup_bitbake(configParams, configuration, extrafeatures=None,
>> setup_logging=True):
>>      # Ensure logging messages get sent to the UI as events
>>      handler = bb.event.LogHandler()
>> -    if setup_logging and not configParams.status_only:
>> -        # In status only mode there are no logs and no UI
>> -        logger.addHandler(handler)
>> +    logger.addHandler(handler)
>>
>>      # Clear away any spurious environment variables while we stoke
>> up the cooker
>>      cleanedvars = bb.utils.clean_environment()
>
> The patch doesn't seem to apply, there is no setup_logging parameter on
> master?

Sorry, it does on master branch, but not no master-next. I will rebase it
to master-next.

// Robert



>
> Cheers,
>
> Richard
>

