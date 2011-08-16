Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Liezhi.Yang@windriver.com>) id 1QtF4G-0001Zj-Cu
	for bitbake-devel@lists.openembedded.org;
	Tue, 16 Aug 2011 10:32:12 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id p7G8R3ik026737
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Tue, 16 Aug 2011 01:27:03 -0700 (PDT)
Received: from [128.224.162.219] (128.224.162.219) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.1.255.0;
	Tue, 16 Aug 2011 01:27:03 -0700
Message-ID: <4E4A29D5.4000801@windriver.com>
Date: Tue, 16 Aug 2011 16:27:01 +0800
From: Robert Yang <liezhi.yang@windriver.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US;
	rv:1.9.2.18) Gecko/20110617 Lightning/1.0b2 Thunderbird/3.1.11
MIME-Version: 1.0
To: Richard Purdie <richard.purdie@linuxfoundation.org>
References: <4E40FDFD.3060809@windriver.com> <1313090662.14274.466.camel@rex>
In-Reply-To: <1313090662.14274.466.camel@rex>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: About bitbake-runtask
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
X-List-Received-Date: Tue, 16 Aug 2011 08:32:12 -0000
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

Hi experts,

I'm trying to fix it, but it seems it's not easy for me to finish it
by Aug. 24th, it would be great if anyone can help me.

The bug is:

Bug 1229 - bitbake-runtask doesn't work in both 1.0.1 and 1.1

Thank you very much!

// Robert

On 08/12/2011 03:24 AM, Richard Purdie wrote:
> On Tue, 2011-08-09 at 17:29 +0800, Robert Yang wrote:
>> Hi Richard,
>>
>> The bitbake-runtask doesn't work currently, it seems that we have decommissioned it:
>>
>> commit 1f3e313fd5cc5ae8ea838bf8fcdedace3cb72584
>> Author: Richard Purdie<rpurdie@linux.intel.com>
>> Date:   Wed Dec 8 00:08:04 2010 +0000
>>
>>       bitbake Revert bitbake exec() and go back to fork() for performace wins
>> (first draft)
>>
>> But it is still in bitbake/bin/bitbake-runtask. There is a bug for tracking
>> this, what shall we do for it? Remove the bitbake-runtask or fix it and make
>> it work?
>>
>> Bug 1229 - bitbake-runtask doesn't work in both 1.0.1 and 1.1
>
> Since I know that script has user and a valid use case we need to:
>
> a) Fix this to work after the fork() changes
> b) Include it in bitbake upstream
>
> b) never happened due to a).
>
> Cheers,
>
> Richard
>
>
>
>


