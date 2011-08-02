Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <mark.hatle@windriver.com>) id 1QoGS9-0004SY-0U
	for bitbake-devel@lists.openembedded.org;
	Tue, 02 Aug 2011 17:00:17 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id p72Ets1i018101
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 2 Aug 2011 07:55:55 -0700 (PDT)
Received: from Macintosh-5.local (172.25.36.226) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.1.255.0;
	Tue, 2 Aug 2011 07:55:54 -0700
Message-ID: <4E380FF9.7090106@windriver.com>
Date: Tue, 2 Aug 2011 09:55:53 -0500
From: Mark Hatle <mark.hatle@windriver.com>
Organization: Wind River Systems
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6;
	rv:5.0) Gecko/20110624 Thunderbird/5.0
MIME-Version: 1.0
To: <bitbake-devel@lists.openembedded.org>
References: <201108021226.34560.paul.eggleton@linux.intel.com>
	<1312293167.4325.38.camel@phil-desktop>
	<CABcZAN=rG0acoqcV6s-gNvvziM0ON97BzNwtZkESu+wz7vQO-g@mail.gmail.com>
	<201108021521.38404.paul.eggleton@linux.intel.com>
	<CABcZANmfd=HbE-wLQ6y-6s_DNYOhDQ7uYPuJ=Yebb6cpVpnykA@mail.gmail.com>
In-Reply-To: <CABcZANmfd=HbE-wLQ6y-6s_DNYOhDQ7uYPuJ=Yebb6cpVpnykA@mail.gmail.com>
Subject: Re: [OE-core] Layer priorities influencing default version selection
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
X-List-Received-Date: Tue, 02 Aug 2011 15:00:17 -0000
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

At Wind River, in our non bitbake based build system, the way layers work is
based on ordering.

The last layer listed has the highest priority.  So whatever is specified in
that layer (lower or higher versions) wins.  All of the priority information is
selected based on the equivalent of the order of entries in the BBLAYERS.
However, unlike bitbake -- in the WR build system we can only have one version
of a package available at any time.

(There is a second level of ordering for configuration files.  For instance if
you are looking for foo.conf, it will search the highest priority layer first
and work it's way down.  If foo.conf includes itself, foo.conf, it will
automatically search starting with the next lower priority layer.  If you
include a differently named configuration file it starts back at the highest
priority layer.  This is what allows a layer to provide snippets of
configuration files. -- I'm not sure this is relevant to this conversation
though... but I thought I'd point out a characteristic of the ordering.)

--Mark

On 8/2/11 9:27 AM, Chris Larson wrote:
> On Tue, Aug 2, 2011 at 7:21 AM, Paul Eggleton
> <paul.eggleton@linux.intel.com> wrote:
>> On Tuesday 02 August 2011 15:14:41 Chris Larson wrote:
>>> as config/class priority is
>>> determined by order of entries in BBLAYERS, whereas recipe priority is
>>> determined by layer.conf.
>>
>> Is that a good thing though? At the moment I'm not convinced that it is.
> 
> I probably could have worded my reply better. I was pointing out the
> fact that the order is determined in two places right now as being one
> reason why I agreed with his statement that ordering determined by the
> layer isn't ideal.



