Return-Path: <gary@mlbassoc.com>
X-Greylist: delayed 518 seconds by postgrey-1.34 at layers.openembedded.org;
	Mon, 15 Jun 2015 13:47:02 UTC
Received: from mail.chez-thomas.org (mail.mlbassoc.com [65.100.170.105])
	by mail.openembedded.org (Postfix) with ESMTP id 84786608B6
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 15 Jun 2015 13:47:02 +0000 (UTC)
Received: by mail.chez-thomas.org (Postfix, from userid 1998)
	id ED214F811DD; Mon, 15 Jun 2015 07:38:25 -0600 (MDT)
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on
	hermes.chez-thomas.org
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=10.0 tests=ALL_TRUSTED,BAYES_00,
	DNS_FROM_AHBL_RHSBL autolearn=no version=3.3.2
Received: from [192.168.1.114] (zeus [192.168.1.114])
	by mail.chez-thomas.org (Postfix) with ESMTP id 88A33F811D9;
	Mon, 15 Jun 2015 07:38:15 -0600 (MDT)
Message-ID: <557ED558.10502@mlbassoc.com>
Date: Mon, 15 Jun 2015 07:38:32 -0600
From: Gary Thomas <gary@mlbassoc.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
References: <1429121824-31200-2-git-send-email-Liam.Howlett@WindRiver.com>	<1431429477.30971.123.camel@linuxfoundation.org>	<20150512142807.GB15805@yow-lhowlett-d0.wrs.com>
	<2131793.ifvVUYI7Oy@peggleto-mobl.ger.corp.intel.com>
In-Reply-To: <2131793.ifvVUYI7Oy@peggleto-mobl.ger.corp.intel.com>
Subject: Re: [PATCH v3] fetch2: Add BB_ALLOWED_NETWORKS support
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
X-List-Received-Date: Mon, 15 Jun 2015 13:47:05 -0000
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

On 2015-06-15 07:28, Paul Eggleton wrote:
> On Tuesday 12 May 2015 10:28:08 Liam R. Howlett wrote:
>> * Richard Purdie <richard.purdie@linuxfoundation.org> [150512 07:18]:
>>> On Thu, 2015-04-16 at 13:23 -0400, Liam R. Howlett wrote:
>>>> BB_ALLOWED_NETWORKS is a list of hosts that the fetcher will be allowed
>>>> to use when BB_NO_NETWORK is not set.
>>>>
>>>> If BB_NO_NETWORK is set, then networking is still disabled.
>>>>
>>>> If BB_ALLOWED_NETWORKS is not set, the behaviour remains the same as
>>>> today.
>>>>
>>>> If BB_NO_NETWORK is NOT set, and BB_ALLOWED_NETWORKS is configured, then
>>>> only the hosts in the list are usable by the fetcher.
>>>>
>>>> eg:
>>>> BB_ALLOWED_NETWORKS="yoctoproject.org git.gnu.org"
>>>> The fetcher will be able to download from yoctoproject.org, git.gnu.org,
>>>> but not ftp.gnu.org or any other hostname that is not in the list.
>>>>
>>>> There is also limited support for wildcards on the beginning of the
>>>> hosts, so BB_ALLOWED_NETWORKS="*.gnu.org" with match git.gnu.org and
>>>> ftp.gnu.org as well as foo.git.gnu.org
>>>>
>>>> Signed-off-by: Liam R. Howlett <Liam.Howlett@WindRiver.com>
>>>> ---
>>>>
>>>>   lib/bb/fetch2/__init__.py | 53
>>>>   +++++++++++++++++++++++++++++++++++++++++++++++ lib/bb/tests/fetch.py
>>>>      | 37 +++++++++++++++++++++++++++++++++
>>>>   2 files changed, 90 insertions(+)
>>>
>>> I've merged this, however, one of the things we're trying to do is
>>> improve the documentation of bitbake. Would you be able to work with
>>> Scott (cc'd) to ensure this is documented in the manual please?
>>>
>>> Cheers,
>>>
>>> Richard
>>
>> Absolutely, Thanks Richard.
>>
>> Hello Scott,
>>
>> If you don't have anything started, we can work from the text below if
>> you'd like.
>>
>> --------
>>
>> BB_ALLOWED_NETWORKS
>>
>> Specifies a space delimited list of hosts which are allowed to be used
>> by the fetcher to obtain the required source code.  This list is only
>> used if BB_NO_NETWORK is not set.  Wildcard matching at the beginning of

Hopefully BB_NO_NETWORK='0' (which is different from 'not set')as well?
That works for all other uses of BB_NO_NETWORK.

>> hosts is supported.  Mirrors that are not in the list will be skipped
>> and logged in debug.  Attempts to access networks that are not in the
>> BB_ALLOWED_NETWORKS will cause a failure.
>>
>> --------
>>
>> Thanks,
>> Liam
>
> Replying to add Scott on CC - I think he has something for review.
>
> Cheers,
> Paul
>

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------

