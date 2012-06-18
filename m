Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <mark.hatle@windriver.com>) id 1SgjQm-0001Ym-6O
	for bitbake-devel@lists.openembedded.org;
	Mon, 18 Jun 2012 23:24:16 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id q5ILDWQf010654
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 18 Jun 2012 14:13:32 -0700 (PDT)
Received: from msp-dhcp56.wrs.com (172.25.34.56) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.1.255.0;
	Mon, 18 Jun 2012 14:13:32 -0700
Message-ID: <4FDF99FB.2030503@windriver.com>
Date: Mon, 18 Jun 2012 16:13:31 -0500
From: Mark Hatle <mark.hatle@windriver.com>
Organization: Wind River Systems
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6;
	rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To: <bitbake-devel@lists.openembedded.org>
References: <alpine.DEB.2.02.1206181608120.22003@oneiric>
	<CAMKF1sqTiss0-CgVj5U=uvkUcuhs0o+fA+n-GbOCi8VunA+qGw@mail.gmail.com>
In-Reply-To: <CAMKF1sqTiss0-CgVj5U=uvkUcuhs0o+fA+n-GbOCi8VunA+qGw@mail.gmail.com>
Subject: Re: is there a bitbake command to *just* fetch all necessary packages?
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
X-List-Received-Date: Mon, 18 Jun 2012 21:24:16 -0000
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 6/18/12 4:08 PM, Khem Raj wrote:
> On Mon, Jun 18, 2012 at 1:10 PM, Robert P. J. Day<rpjday@crashcourse.ca>  wrote:
>>
>>   perhaps i'm just misreading the docs, but is there a bitbake
>> incantation that does *nothing* more than fetch the packages needed
>> for a target image?
>>
>>   if i use "bitbake -c fetchall", the result is not just to fetch the
>> source, but to unload and patch it as well.
>
> hmmm I thought it did just what it says 'fetch all' but as you say it
> seems to do more hmm I am not sure if its intended behavior

In order for fetchall to work, there are a few dependencies that have to be 
executed as well..

But bitbake -c fetchall <target>, will fetch everything needed for the <target> 
recipe.  It will extract and build only the items necessary for fetch to work 
properly.

--Mark


>   i don't want that, i want
>> whatever the magic is to just *fetch* and leave it at that.  or is
>> that simply not possible?
>>
>> rday
>>
>> --
>>
>> ========================================================================
>> Robert P. J. Day                                 Ottawa, Ontario, CANADA
>>                         http://crashcourse.ca
>>
>> Twitter:                                       http://twitter.com/rpjday
>> LinkedIn:                               http://ca.linkedin.com/in/rpjday
>> ========================================================================
>>
>> _______________________________________________
>> bitbake-devel mailing list
>> bitbake-devel@lists.openembedded.org
>> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel



