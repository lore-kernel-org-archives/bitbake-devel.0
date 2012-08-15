Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Liezhi.Yang@windriver.com>) id 1T1eXI-0000JC-Ip
	for bitbake-devel@lists.openembedded.org;
	Wed, 15 Aug 2012 16:25:33 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id q7FEDRk2013552
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Wed, 15 Aug 2012 07:13:27 -0700 (PDT)
Received: from [128.224.163.142] (128.224.163.142) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.2.309.2;
	Wed, 15 Aug 2012 07:13:26 -0700
Message-ID: <502BAE85.5010804@windriver.com>
Date: Wed, 15 Aug 2012 22:13:25 +0800
From: Robert Yang <liezhi.yang@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux i686;
	rv:14.0) Gecko/20120714 Thunderbird/14.0
MIME-Version: 1.0
To: Richard Purdie <richard.purdie@linuxfoundation.org>
References: <cover.1344564039.git.liezhi.yang@windriver.com>
	<86c6fef246be4e70f22d24754abbc920470d5997.1344564039.git.liezhi.yang@windriver.com>
	<1345038156.538.15.camel@ted> <502BA8F2.9070606@windriver.com>
	<1345039247.538.23.camel@ted>
In-Reply-To: <1345039247.538.23.camel@ted>
Cc: Chris Larson <clarson@kergoth.com>, bitbake-devel@lists.openembedded.org,
	Zhenfeng.Zhao@windriver.com
Subject: Re: [PATCH 1/1] bitbake.conf: add BB_STAMPS_DIR for constructing STAMP
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
X-List-Received-Date: Wed, 15 Aug 2012 14:25:34 -0000
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit



On 08/15/2012 10:00 PM, Richard Purdie wrote:
> On Wed, 2012-08-15 at 21:49 +0800, Robert Yang wrote:
>>
>> On 08/15/2012 09:42 PM, Richard Purdie wrote:
>>> On Fri, 2012-08-10 at 10:02 +0800, Robert Yang wrote:
>>>> Add BB_STAMPS_DIR for constructing STAMP, the defination of STAMP
>>>> before:
>>>>
>>>> STAMP = "${TMPDIR}/stamps/${MULTIMACH_TARGET_SYS}/${PF}
>>>>
>>>> We can only change the TMPDIR if we want to change the STAMP's location,
>>>> but the cache would be regenerated if TMPDIR changed, so add
>>>> BB_STAMPS_DIR for constructing it, and add it to the BB_ENV_EXTRAWHITE,
>>>> this is very usefull for the "bitbake -S", since then it can be run by:
>>>>
>>>> BB_STAMPS_DIR=<path> bitbake -S <recipe>
>>>>
>>>> which will avoid putting the stamps to ${TMPDIR}/stamps.
>>>>
>>>> BTW, break the too long BB_ENV_EXTRAWHITE into several lines.
>>>>
>>>> [YOCTO #1659]
>>>>
>>>> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
>>>> ---
>>>>    meta/conf/bitbake.conf       | 3 ++-
>>>>    scripts/oe-buildenv-internal | 5 ++++-
>>>>    2 files changed, 6 insertions(+), 2 deletions(-)
>>>
>>> BB_ is a prefix for variables bitbake specifically uses for
>>> configuration. It doesn't fit in this context since its metadata defined
>>> and doesn't actually influence or is used by bitbake itself.
>>>
>>> We therefore need to use a different name for this.
>>>
>>
>> Thanks, how about "STAMPS_DIR" ? And can we put the bitbake-whatchanged
>> to bitbake/bin or bitbake/contrib as Chris Larson worried about ?
>
> He's right, it depends on the metadata and therefore shouldn't really be
> in bitbake. It could go into scripts/ in oe-core.
>

Thanks, I will send a V3 to oe-core list.

// Robert

> Cheers,
>
> Richard
>
>
>


