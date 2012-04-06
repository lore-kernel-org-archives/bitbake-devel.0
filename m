Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <mark.hatle@windriver.com>) id 1SGElg-0005jA-3j
	for bitbake-devel@lists.openembedded.org;
	Fri, 06 Apr 2012 21:24:27 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id q36Gubs1006067
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 6 Apr 2012 09:56:37 -0700 (PDT)
Received: from msp-dhcp16.wrs.com (172.25.34.16) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.1.255.0;
	Fri, 6 Apr 2012 09:56:37 -0700
Message-ID: <4F7F2044.9050604@windriver.com>
Date: Fri, 6 Apr 2012 11:56:36 -0500
From: Mark Hatle <mark.hatle@windriver.com>
Organization: Wind River Systems
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6;
	rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
MIME-Version: 1.0
To: <bitbake-devel@lists.openembedded.org>
References: <857BE142E5399E46B20FD45B9DB8A7BC0FD2D040@SHSMSX102.ccr.corp.intel.com>
	<20120405062857.GK4181@jama.jama.net>
	<857BE142E5399E46B20FD45B9DB8A7BC0FD2D07B@SHSMSX102.ccr.corp.intel.com>
In-Reply-To: <857BE142E5399E46B20FD45B9DB8A7BC0FD2D07B@SHSMSX102.ccr.corp.intel.com>
Subject: Re: bb.utils.vercmp() not consistent with debian rules
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 06 Apr 2012 19:24:31 -0000
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit

On 4/5/12 1:42 AM, Lu, Lianhao wrote:
>
> Martin Jansa wrote on 2012-04-05:
>> On Thu, Apr 05, 2012 at 06:22:00AM +0000, Lu, Lianhao wrote:
>>> Hi guys,
>>>
>>> When I'm looking at the Yocto bug#2233, I find that the function
>>> bb.utils.vercmp() is not consistent with the debian packaging
>>> rules(http://www.debian.org/doc/debian-policy/ch-controlfields.html#s-f-
>>> Version).
>>>
>>> According to debian rules, "r0" is earlier than "r0-dream", but the bb.utils.vercmp() thinks "r0" is later than "r0-dream".
>>
>> And what about something like this:
>>
>> Version: 3.2-r10
>> is older then
>> Version: 3.2-r2-oe0

As an FYI, RPM does:

3.2-r10 > 3.2-r2-oe0

3.2-r2 < 3.2-r2-oe0

--Mark

> I think this is exactly what the debian rules wants, "3.2-r10">"3.2-r2-oe0". And opkg follows that rule.
>
> The problem is that bb.utils.vercmp thinks "3.2-r2">"3.2-r2-oe0" while opkg thinks "3.2-r2"<"3.2-r2-oe0".
>
> -Lianhao
>
>> At least that was what target opkg was doing for me and I had to bump PE
>> http://git.shr-project.org/git/?p=meta-smartphone.git;a=commit;h=cb119753
>> a77208617936085100595e6343ade650
>>
>> Cheers,
>>
>>>
>>> A pervious patch
>>> http://cgit.openembedded.org/bitbake/commit/?id=727ce6ffe33a119cb17f7d91
>>> b173f11a055eea3c seems causing the bb.utils.vercmp to specially handle
>>> the separators of "." and "-".
>>>
>>> Is it desired to behave differently from debian rules?
>>>
>>> Best Regards,
>>> -Lianhao
>>>
>>> _______________________________________________
>>> bitbake-devel mailing list
>>> bitbake-devel@lists.openembedded.org
>>> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel
>>
>
>
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel



