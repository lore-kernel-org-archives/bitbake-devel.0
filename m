Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <mark.hatle@windriver.com>) id 1TxkFq-0007KF-Ui
	for bitbake-devel@lists.openembedded.org;
	Tue, 22 Jan 2013 21:15:36 +0100
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id r0MGlvRs005264
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 22 Jan 2013 08:47:58 -0800 (PST)
Received: from Marks-MacBook-Pro.local (172.25.36.227) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.2.318.4; Tue, 22 Jan 2013 08:47:57 -0800
Message-ID: <50FEC2BE.3020902@windriver.com>
Date: Tue, 22 Jan 2013 10:47:58 -0600
From: Mark Hatle <mark.hatle@windriver.com>
Organization: Wind River Systems
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8;
	rv:17.0) Gecko/20130107 Thunderbird/17.0.2
MIME-Version: 1.0
To: <bitbake-devel@lists.openembedded.org>
References: <6811518C-5E13-40A7-8B8B-57C2810DEA8B@gmail.com>
	<CAHUNapSSaOqnkOZq3_BaMthqY6hG+JTxvi9XpgD_38yT6+wDhA@mail.gmail.com>
In-Reply-To: <CAHUNapSSaOqnkOZq3_BaMthqY6hG+JTxvi9XpgD_38yT6+wDhA@mail.gmail.com>
Subject: Re: Display mode
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
X-List-Received-Date: Tue, 22 Jan 2013 20:15:37 -0000
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit

On 1/22/13 10:37 AM, Trevor Woerner wrote:
> On Tue, Jan 22, 2013 at 1:20 AM, Trung Hoang <trungiee@gmail.com> wrote:
>> The current git HEAD of bit bake nicely displays the x threads and what is happening on them instead of constantly scrolling in detail what is exactly happening.
>
> This feature is called "knotty".
>
>> Is this feature configurable? How do i enable it on older versions of bitbake? As the gumstix setup scripts check out a older version of bit bake and it displays reams and reams of info.
>
> Knotty was added this past... August (?) (or, perhaps it is more
> correct to say "it was made the default" this past August?). So making
> it work on older versions would require back-porting it to those
> versions.

"In general", newer versions of bitbake work with older systems.  There is one 
main condition where this can be problematic however.  There was a period of 
time where, in python functions, tabs were all converted to spaces.  So code is 
in bitbake to check for this condition.

If you try to use a modern bitbake with an older system that still has tabs, you 
can get failures.

Note, it does require testing to verify that the newer bitbake will work on an 
older configuration, but it has in my experience.

--Mark

> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel
>



