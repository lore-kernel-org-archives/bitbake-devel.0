Received: from mail.mlbassoc.com ([65.100.170.105] helo=mail.chez-thomas.org)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <gary@mlbassoc.com>) id 1U9z4T-0003qN-PH
	for bitbake-devel@lists.openembedded.org;
	Mon, 25 Feb 2013 15:30:34 +0100
Received: by mail.chez-thomas.org (Postfix, from userid 1998)
	id DBADDF81223; Mon, 25 Feb 2013 07:07:33 -0700 (MST)
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on
	hermes.chez-thomas.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=unavailable version=3.3.2
Received: from [192.168.1.114] (zeus [192.168.1.114])
	by mail.chez-thomas.org (Postfix) with ESMTP id AB88BF81215;
	Mon, 25 Feb 2013 07:07:32 -0700 (MST)
Message-ID: <512B7034.1030504@mlbassoc.com>
Date: Mon, 25 Feb 2013 07:07:48 -0700
From: Gary Thomas <gary@mlbassoc.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:17.0) Gecko/20130106 Thunderbird/17.0.2
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
References: <CALbNGRRDr+6vLtJRDgRi1NbO+s0sUB5TLT7uTck5L5La6xfDQw@mail.gmail.com>
	<CABcZANn3JbnhTEEP85K5bxXQd9ipYmuP9-bqMizpw+z9R3HhiQ@mail.gmail.com>
	<CAPhnLPCYxVk8F72Tv=PJo2OQJQmMdN0RKXNmTj_JeVy+7VJ+qA@mail.gmail.com>
	<CAPhnLPBwwM84Pu25od0pLr2446-RSbGsDHQbayQE3g+xNV2tkw@mail.gmail.com>
	<CALbNGRSioFk7F3W9yp_VbHz6sXP-LjUtg0DqJorZmyHt_+J2sw@mail.gmail.com>
	<CABxcv=kdCzvj=Z4GDtYC4P-az9LnT5VhrspRrZq8p568uPo9QA@mail.gmail.com>
	<CALbNGRSZeOC0Tyv1-x6og6g+HOD148PUdCWcONYBE_YUQ7FASA@mail.gmail.com>
	<CAHUNapR3-Z57mPUScW6TnptFbawE3y=+bCcpnTVVfAy-2KjwjA@mail.gmail.com>
	<1361800868.25338.79.camel@ted>
In-Reply-To: <1361800868.25338.79.camel@ted>
Subject: Re: [meta-ti] trouble during parsing
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
X-List-Received-Date: Mon, 25 Feb 2013 14:30:36 -0000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 2013-02-25 07:01, Richard Purdie wrote:
> On Mon, 2013-02-25 at 08:44 -0500, Trevor Woerner wrote:
>> If the purpose of the ls-remote is to match a tag with a hash,
>> wouldn't it be easier to just:
>>
>>      cat .git/refs/tags/<tagid>
>>
>> ?
>
> If the git clone hasn't happened yet, this doesn't work.
>
>> And if the purpose of knowing the tagid is to use that version of the
>> code, wouldn't it be easier to just:
>>
>>      git checkout <tagid>
>
> That isn't the only purpose.

Additionally, the problem is that tags can move and the revid
will change.  Hence the need to probe the source GIT for the answer.

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------


