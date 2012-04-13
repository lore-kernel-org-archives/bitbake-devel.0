Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Liezhi.Yang@windriver.com>) id 1SIUu0-0006AA-08
	for bitbake-devel@lists.openembedded.org;
	Fri, 13 Apr 2012 03:02:18 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id q3D0qpKR016103
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Thu, 12 Apr 2012 17:52:51 -0700 (PDT)
Received: from [128.224.162.196] (128.224.162.196) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.1.255.0;
	Thu, 12 Apr 2012 17:52:51 -0700
Message-ID: <4F8778E1.3010403@windriver.com>
Date: Fri, 13 Apr 2012 08:52:49 +0800
From: Robert Yang <liezhi.yang@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux i686;
	rv:11.0) Gecko/20120310 Thunderbird/11.0
MIME-Version: 1.0
To: Chris Larson <clarson@kergoth.com>
References: <4F83EE3C.8040904@windriver.com>
	<CABcZANm628Wm0TYo45eSjLsVjzpseV=4__he=s=Lz_r1ekyJBw@mail.gmail.com>
	<4F843FC1.1080309@windriver.com>
	<CABcZAN=LTh8GDhz5Zs0SsOkrfmsGK+-6t4+DsC23_Z-qHMk7xw@mail.gmail.com>
In-Reply-To: <CABcZAN=LTh8GDhz5Zs0SsOkrfmsGK+-6t4+DsC23_Z-qHMk7xw@mail.gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: questions about bitbake world
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
X-List-Received-Date: Fri, 13 Apr 2012 01:02:19 -0000
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit


Thanks, is there a way to skip the pkg if I don't want to build it
when bitbake world, please?

// Robert

On 04/10/2012 10:15 PM, Chris Larson wrote:
> On Tue, Apr 10, 2012 at 7:12 AM, Robert Yang<liezhi.yang@windriver.com>  wrote:
>> On 04/10/2012 09:58 PM, Chris Larson wrote:
>>>
>>> On Tue, Apr 10, 2012 at 1:24 AM, Robert Yang<liezhi.yang@windriver.com>
>>>   wrote:
>>>>
>>>> In the following code:
>>>>
>>>> def buildWorldTargetList(self):
>>>> ...
>>>>         for f in self.status.possible_world:
>>>>             terminal = True
>>>>             pn = self.status.pkg_fn[f]
>>>>
>>>>             for p in pn_provides[pn]:
>>>>                 if p.startswith('virtual/'):
>>>>                     parselog.debug(2, "World build skipping %s due to %s
>>>> provider starting with virtual/", f, p)
>>>>                     terminal = False
>>>>                     break
>>>> ...
>>>>
>>>> Does it mean that if a recipe contains:
>>>>
>>>> PROVIDES = "virtual/something"
>>>>
>>>> Then it would not be built until a pkg depends on it? Why we design it in
>>>> this
>>>> way, please?
>>>
>>>
>>> The original intent with world was that when two recipes provided the
>>> same thing, we'd still only want to build one of them, not both, as
>>> building both can cause problems with stepping on one another in
>>> sysroot, etc.
>>
>>
>> Thanks for your reply, but it seems that it builts none currently.
>
> Fair point, I think in certain cases we also only wanted to build
> things if they got pulled in via a dependency. For example, iirc
> native and cross both exclude themselves from world via a variable set
> in the classes. I don't recall if such was the case here, however.


