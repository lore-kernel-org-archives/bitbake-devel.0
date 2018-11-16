Return-Path: <pn@denx.de>
X-Greylist: delayed 523 seconds by postgrey-1.34 at layers.openembedded.org;
	Fri, 16 Nov 2018 17:58:00 UTC
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by mail.openembedded.org (Postfix) with ESMTP id 5DAEF6C465
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Nov 2018 17:58:00 +0000 (UTC)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 42xQht0KmXz1r0gk;
	Fri, 16 Nov 2018 18:49:17 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
	by mail.m-online.net (Postfix) with ESMTP id 42xQhs1mrPz1rJpd;
	Fri, 16 Nov 2018 18:49:17 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new,
	port 10024)
	with ESMTP id tO69Wjn0GEd0; Fri, 16 Nov 2018 18:49:16 +0100 (CET)
X-Auth-Info: HTVhQGpwHbYzXZ93/2P42LhTuQSi9+Bd1gxpeink2EI=
Received: from [192.168.178.26] (62.91.16.92.dsl.ffm.de.dialin.bisping.net
	[62.91.16.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Fri, 16 Nov 2018 18:49:16 +0100 (CET)
To: peter.kjellerstedt@axis.com, bitbake-devel@lists.openembedded.org
References: <05b7fac8-2663-4032-ebc3-30f08ef46a3e@denx.de>
	<20180718141401.2690758-1-pn@denx.de>
	<790d60a0-ed89-453b-fc91-2c5ac888f99c@denx.de>
From: Parthiban Nallathambi <pn@denx.de>
Organization: DENX Software Engineering GmbH
Message-ID: <5ae879f9-64af-7b60-cf9e-b01cd89713ab@denx.de>
Date: Fri, 16 Nov 2018 18:49:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <790d60a0-ed89-453b-fc91-2c5ac888f99c@denx.de>
Cc: wd@denx.de, sbabic@denx.de
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
X-List-Received-Date: Fri, 16 Nov 2018 17:58:00 -0000
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit

Ping on this patch!

On 9/21/18 2:14 PM, Parthiban Nallathambi wrote:
> Ping on this patch!
> 
> On 07/18/2018 04:14 PM, Parthiban Nallathambi wrote:
>> shrinkwrap resolved relative URL can start with http. For example,
>> "resolved: http-proxy/-/http-proxy-${PV}.tgz" is still relative URL
>> to npm registry, but starts with http.
>>
>> Current if statement compares the startswith 'resolved' to 'http',
>> which makes impossible to use npm download. Condtional comparison
>> now strictly checks for "http://" and "https://"
>>
>> Changelog since v1:
>> - Use the proper conditional statement to avoid always success
>>
>> Signed-off-by: Parthiban Nallathambi <pn@denx.de>
>> ---
>>   bitbake/lib/bb/fetch2/npm.py | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/bitbake/lib/bb/fetch2/npm.py b/bitbake/lib/bb/fetch2/npm.py
>> index 408dfc3d03..65bf5a3644 100644
>> --- a/bitbake/lib/bb/fetch2/npm.py
>> +++ b/bitbake/lib/bb/fetch2/npm.py
>> @@ -226,7 +226,7 @@ class Npm(FetchMethod):
>>                           self._getshrinkeddependencies(obj, data['dependencies'][obj], data['dependencies'][obj]['version'], d, ud, lockdown, manifest, False)
>>                           return
>>           outputurl = "invalid"
>> -        if ('resolved' not in data) or (not data['resolved'].startswith('http')):
>> +        if ('resolved' not in data) or (not data['resolved'].startswith('http://') and not data['resolved'].startswith('https://')):
>>               # will be the case for ${PN}
>>               fetchcmd = "npm view %s@%s dist.tarball --registry %s" % (pkg, version, ud.registry)
>>               logger.debug(2, "Found this matching URL: %s" % str(fetchcmd))
>>
> 

-- 
Thanks,
Parthiban N

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-22 Fax: (+49)-8142-66989-80 Email: pn@denx.de

