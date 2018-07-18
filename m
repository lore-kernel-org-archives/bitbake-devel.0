Return-Path: <pn@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by mail.openembedded.org (Postfix) with ESMTP id 1E4A078741
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Jul 2018 14:03:37 +0000 (UTC)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 41VzQL1Qv1z1r5jJ;
	Wed, 18 Jul 2018 16:03:37 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
	by mail.m-online.net (Postfix) with ESMTP id 41VzQK5qwCz1vB6k;
	Wed, 18 Jul 2018 16:03:37 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new,
	port 10024)
	with ESMTP id YNhO2qIHu6Ex; Wed, 18 Jul 2018 16:03:37 +0200 (CEST)
X-Auth-Info: 1lG3z57g20WW549yO0bPmYdTgamgwHus03evbwXQfIU=
Received: from antares.denx.de (unknown [62.91.23.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Wed, 18 Jul 2018 16:03:36 +0200 (CEST)
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
References: <20180718090339.3914-1-pn@denx.de>
	<eb5d94efdf114065ba04e8aa536256b3@XBOX02.axis.com>
From: Parthiban Nallathambi <pn@denx.de>
Message-ID: <05b7fac8-2663-4032-ebc3-30f08ef46a3e@denx.de>
Date: Wed, 18 Jul 2018 16:03:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <eb5d94efdf114065ba04e8aa536256b3@XBOX02.axis.com>
Subject: Re: [PATCH] bitbake: fetch2/npm.py: Allow shrinkwrap resolved relative URL which startswith 'http' (e.g http-proxy)
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
X-List-Received-Date: Wed, 18 Jul 2018 14:03:38 -0000
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

Hello Peter,

On 07/18/2018 04:01 PM, Peter Kjellerstedt wrote:
>> -----Original Message-----
>> From: bitbake-devel-bounces@lists.openembedded.org [mailto:bitbake-
>> devel-bounces@lists.openembedded.org] On Behalf Of Parthiban
>> Nallathambi
>> Sent: den 18 juli 2018 11:04
>> To: bitbake-devel@lists.openembedded.org
>> Subject: [bitbake-devel] [PATCH] bitbake: fetch2/npm.py: Allow
>> shrinkwrap resolved relative URL which startswith 'http' (e.g http-
>> proxy)
>>
>> shrinkwrap resolved relative URL can start with http. For example,
>> "resolved: http-proxy/-/http-proxy-${PV}.tgz" is still relative URL
>> to npm registry, but starts with http.
>>
>> Current if statement compares the startswith 'resolved' to 'http',
>> which makes impossible to use npm download. Condtional comparison
>> now strictly checks for "http://" and "https://"
>>
>> Signed-off-by: Parthiban Nallathambi <pn@denx.de>
>> ---
>>   bitbake/lib/bb/fetch2/npm.py | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/bitbake/lib/bb/fetch2/npm.py b/bitbake/lib/bb/fetch2/npm.py
>> index ba7fa43a82..5e7fc2f769 100644
>> --- a/bitbake/lib/bb/fetch2/npm.py
>> +++ b/bitbake/lib/bb/fetch2/npm.py
>> @@ -234,7 +234,7 @@ class Npm(FetchMethod):
>>                           self._getshrinkeddependencies(obj, data['dependencies'][obj], data['dependencies'][obj]['version'], d, ud, lockdown, manifest, False)
>>                           return
>>           outputurl = "invalid"
>> -        if ('resolved' not in data) or (not data['resolved'].startswith('http')):
>> +        if ('resolved' not in data) or (not data['resolved'].startswith('http://')) or (not data['resolved'].startswith('https://')):
> 
> That is wrong (the above will always evaluate to true as long as
> 'resolved' exists in data since both expressions testing the prefix
> obviously cannot be false at the same time). The correct expression
> should be:
> 
>          if ('resolved' not in data) or (not data['resolved'].startswith('http://') and not data['resolved'].startswith('https://')):

Thanks for pointing. I missed it. I will update and send the v2.

> 
>>               # will be the case for ${PN}
>>               fetchcmd = "npm view %s@%s dist.tarball --registry %s" % (pkg, version, ud.registry)
>>               logger.debug(2, "Found this matching URL: %s" % str(fetchcmd))
>> --
>> 2.14.4
> 
> //Peter
> 

-- 
Thanks,
Parthiban Nallathambi

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de

