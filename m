Return-Path: <gary@mlbassoc.com>
X-Greylist: delayed 558 seconds by postgrey-1.34 at layers.openembedded.org;
	Fri, 17 Apr 2015 11:27:08 UTC
Received: from mail.chez-thomas.org (mail.mlbassoc.com [65.100.170.105])
	by mail.openembedded.org (Postfix) with ESMTP id 8D35973D46
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 17 Apr 2015 11:27:08 +0000 (UTC)
Received: by mail.chez-thomas.org (Postfix, from userid 1998)
	id 7FAD1F811DE; Fri, 17 Apr 2015 05:17:51 -0600 (MDT)
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on
	hermes.chez-thomas.org
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=10.0 tests=ALL_TRUSTED,BAYES_00,
	DNS_FROM_AHBL_RHSBL autolearn=no version=3.3.2
Received: from [192.168.1.114] (zeus [192.168.1.114])
	by mail.chez-thomas.org (Postfix) with ESMTP id 1F94FF811DD;
	Fri, 17 Apr 2015 05:17:51 -0600 (MDT)
Message-ID: <5530EBFD.4090406@mlbassoc.com>
Date: Fri, 17 Apr 2015 05:18:21 -0600
From: Gary Thomas <gary@mlbassoc.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:31.0) Gecko/20100101 Thunderbird/31.6.0
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
References: <CABcZANnOghZ-ek19v0KH8L2EdC1m2vDOW2Eyv_zOV2zfFaLnWg@mail.gmail.com>	<1429208939-10876-1-git-send-email-ed.bartosh@linux.intel.com>
	<1429267317.6976.196.camel@linuxfoundation.org>
In-Reply-To: <1429267317.6976.196.camel@linuxfoundation.org>
Subject: Re: [PATCH] bitbake: Allow ~ in bblayers
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
X-List-Received-Date: Fri, 17 Apr 2015 11:27:11 -0000
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

On 2015-04-17 04:41, Richard Purdie wrote:
> On Thu, 2015-04-16 at 21:28 +0300, Ed Bartosh wrote:
>> Implemented processing of ~ in bblayer's paths if HOME
>> environment variable is approved.
>>
>> Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
>> ---
>>   bitbake/lib/bb/cookerdata.py | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/bitbake/lib/bb/cookerdata.py b/bitbake/lib/bb/cookerdata.py
>> index 6c11a60..bf08c63 100644
>> --- a/bitbake/lib/bb/cookerdata.py
>> +++ b/bitbake/lib/bb/cookerdata.py
>> @@ -269,8 +269,11 @@ class CookerDataBuilder(object):
>>               layers = (data.getVar('BBLAYERS', True) or "").split()
>>
>>               data = bb.data.createCopy(data)
>> +            approved = bb.utils.approved_variables()
>>               for layer in layers:
>>                   parselog.debug(2, "Adding layer %s", layer)
>> +                if 'HOME' in approved:
>
> can we change this to
>
> if 'HOME' in approved and '~' in layer:
>
> simply so that we can more easily remember what this code is doing in
> the future?

+1

This change also has the side effect of not causing an expansion of
all layers if HOME is in the approved list which would seem a useful
optimization.

>
> Cheers,
>
> Richard
>
>> +                    layer = os.path.expanduser(layer)
>>                   data.setVar('LAYERDIR', layer)
>>                   data = parse_config_file(os.path.join(layer, "conf", "layer.conf"), data)
>>                   data.expandVarref('LAYERDIR')
>> --
>> 2.1.4
>>
>
>

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------

