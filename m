Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 1FB987282F
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 20 Jan 2015 09:33:40 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.9/8.14.5) with ESMTP id t0K9Xd8a020700
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
	Tue, 20 Jan 2015 01:33:39 -0800 (PST)
Received: from [128.224.162.174] (128.224.162.174) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.40) with Microsoft SMTP Server id 14.3.174.1;
	Tue, 20 Jan 2015 01:33:39 -0800
Message-ID: <54BE20F1.7060401@windriver.com>
Date: Tue, 20 Jan 2015 17:33:37 +0800
From: Robert Yang <liezhi.yang@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux i686;
	rv:31.0) Gecko/20100101 Thunderbird/31.3.0
MIME-Version: 1.0
To: Richard Purdie <richard.purdie@linuxfoundation.org>
References: <1421158296.31262.17.camel@linuxfoundation.org>		
	<54BCBBF6.4020904@windriver.com>	
	<1421663325.1798.31.camel@linuxfoundation.org>	
	<54BDBC83.9030007@windriver.com>
	<1421744147.1798.39.camel@linuxfoundation.org>
In-Reply-To: <1421744147.1798.39.camel@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] bitbake: Add pyinotify to lib/
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
X-List-Received-Date: Tue, 20 Jan 2015 09:33:48 -0000
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit



On 01/20/2015 04:55 PM, Richard Purdie wrote:
> On Tue, 2015-01-20 at 10:25 +0800, Robert Yang wrote:
>> Hello RP,
>>
>> I've got several errors like the following when the system's load is high,
>> not sure whether related to pyinotify.
>>
>> for example, when do_configure:
>> sh: 0: Cannot fork
>>
>> when do_package or others:
>> Exception: OSError: [Errno 11] Resource temporarily unavailable
>
> We've seen this on the autobuilders too. I don't think this should be
> from the pyinotify changes since the worker process is spawned
> separately and shouldn't hold watches. Its more likely with the kernel
> changes, we created more contention with the performance improvements
> and pushed things "over the edge" to the point where configurations
> which used to work, are now too contented.
>
> Can we install monitoring on these systems and figure out which
> resources are unavailable?

After more thoughts, maybe because of the "max open files" or
"max user processes", I will try to modify them to see what will happen
the day after tomorrow (I can't modify them today or tomorrow).

// Robert

>
> Cheers,
>
> Richard
>
>
>

