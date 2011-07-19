Received: from mailrelay3.sunrise.ch ([194.158.229.31]
	helo=smtp-be-01.be08.sunrise.ch)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dv@vollmann.ch>) id 1Qj9Ei-0005Ni-5y
	for bitbake-devel@lists.openembedded.org;
	Tue, 19 Jul 2011 14:17:16 +0200
Received: from [192.168.26.14] (212-98-43-140.static.adslpremium.ch
	[212.98.43.140])
	by smtp-be-01.be08.sunrise.ch (8.13.1/8.12.10) with ESMTP id
	p6JBQ4Pv012274; Tue, 19 Jul 2011 13:26:04 +0200
Message-ID: <4E2569BD.4070300@vollmann.ch>
Date: Tue, 19 Jul 2011 13:25:49 +0200
From: Detlef Vollmann <dv@vollmann.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US;
	rv:1.9.2.18) Gecko/20110617 Thunderbird/3.1.11
MIME-Version: 1.0
CC: bitbake-dev <bitbake-devel@lists.openembedded.org>
References: <4E248688.1030902@vollmann.ch>	<CABcZANnmZwTK147Vwgv8j9omd7xNQQK5EKT99_UEctC2itw3Jw@mail.gmail.com>	<4E253020.4050001@vollmann.ch>
	<201107191053.35867.paul.eggleton@linux.intel.com>
In-Reply-To: <201107191053.35867.paul.eggleton@linux.intel.com>
Subject: Re: [oe] preferred version not available
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
X-List-Received-Date: Tue, 19 Jul 2011 12:17:16 -0000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

[Resend to bitbake-devel due to new list address]
On 07/19/11 11:53, Paul Eggleton wrote:
> On Tuesday 19 July 2011 08:20:00 Detlef Vollmann wrote:
>> On 07/18/11 23:05, Chris Larson wrote:
>>> All variables which are typically set by the filename can be
>>> overridden. Those are simply defaults. See the definitions of PN, PV,
>>> and PR in bitbake.conf.
>>
>> Yes, I knew that (I actually wrote the line changing the PV myself).
>> What surprised me (though it makes sense) that PREFERRED_VERSION
>> refers to PV, and not directly to a part of the filename.
>> It's probably still too much of 'make' history in my brain...
>
> I wonder if it would make sense to add something to the error message that
> also lists the available versions? Then it would be a little more obvious what
> you need to set PREFERRED_VERSION to.
That would be great.
And while we are in wishlist mode ;-) :
With a high enough debug level (I think 2), you'll get a list of
providers for a specific target.
To get also a list of versions for a specific package (PN), would
be really helpful.

   Detlef



