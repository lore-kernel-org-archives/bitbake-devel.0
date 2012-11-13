Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <mark.hatle@windriver.com>) id 1TYJYj-0005hD-A4
	for bitbake-devel@lists.openembedded.org;
	Tue, 13 Nov 2012 17:41:57 +0100
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id qADGS2M0009053
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 13 Nov 2012 08:28:03 -0800 (PST)
Received: from msp-dhcp30.wrs.com (172.25.34.30) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.2.318.4;
	Tue, 13 Nov 2012 08:28:01 -0800
Message-ID: <50A27513.5030302@windriver.com>
Date: Tue, 13 Nov 2012 10:28:03 -0600
From: Mark Hatle <mark.hatle@windriver.com>
Organization: Wind River Systems
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8;
	rv:16.0) Gecko/20121026 Thunderbird/16.0.2
MIME-Version: 1.0
To: <bitbake-devel@lists.openembedded.org>
References: <20121113123509.Horde.cZcPJLuWis5QojBtb0_w6KA@webmail.df.eu>
	<1352816917.24487.130.camel@ted>
In-Reply-To: <1352816917.24487.130.camel@ted>
Subject: Re: BitBake & ClearCase
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
X-List-Received-Date: Tue, 13 Nov 2012 16:41:57 -0000
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit

On 11/13/12 8:28 AM, Richard Purdie wrote:
> On Tue, 2012-11-13 at 12:35 +0100, news@christianvolk.net wrote:
>> Dear bitbake-developer-community,
>>
>> I just stumbled across a problem and knows of no other advice than to
>> write to you here:
>>
>> In my company we have to use bitbake in combination with ClearCase (CC).
>> Bitbake has some problems with the ClearCase-owned files called
>> ?.copyarea.db?.
>> Unfortunately, CC adds such a file to each directory which is under
>> source-control.
>> The file is read-only and so the task do_unpack fails with the
>> following error message:
>>
>> cp: cannot create regular file
>> `/home/[...]/testability-1.0-r0/./testability_src_gen/.copyarea.db':
>> Permission Denied
>
> I'm a little confused about what the real problem is here. cp should be
> able to cope with a file that is marked as read-only. Is this saying the
> target already exists and can't be written to? Or is it unable to read
> from the source? Is the source locked?

Are you attempting to build inside of a ClearCase location?  Or are you copying 
from a ClearCase location within a recipe..  If it's the later, this is what 
Richard is referring to, if it's the former..  It likely won't work well. 
ClearCase has a number of issues with it's virtual filesystem that cause 
problems during the build.

What we have recommended to our customers using clearcase, is to define an 
alternative location for the 'tmp' directory that is outside of the clearcase 
filesystem and somewhere local to the machine.

--Mark

> Worst case you can implement a custom "unpack" function for your
> clearcase fetcher like git does and in there, exclude the problematic
> files.
>
> Cheers,
>
> Richard
>
>
>
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel
>



