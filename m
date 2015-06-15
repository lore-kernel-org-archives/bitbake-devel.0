Return-Path: <scott.m.rifenbark@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 2933873772
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 15 Jun 2015 14:03:27 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 15 Jun 2015 07:03:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.13,618,1427785200"; d="scan'208";a="746970483"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
	by orsmga002.jf.intel.com with ESMTP; 15 Jun 2015 07:03:12 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.217]) by
	ORSMSX105.amr.corp.intel.com ([169.254.4.113]) with mapi id
	14.03.0224.002; Mon, 15 Jun 2015 07:03:11 -0700
From: "Rifenbark, Scott M" <scott.m.rifenbark@intel.com>
To: Gary Thomas <gary@mlbassoc.com>, "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH v3] fetch2: Add BB_ALLOWED_NETWORKS
	support
Thread-Index: AQHQp3HNGNB67lkReUuAuyPDam9s952tmEfQ
Date: Mon, 15 Jun 2015 14:03:11 +0000
Message-ID: <41DEA4B02DBDEF40A0F3B6D0DDB123798D203356@ORSMSX101.amr.corp.intel.com>
References: <1429121824-31200-2-git-send-email-Liam.Howlett@WindRiver.com>
	<1431429477.30971.123.camel@linuxfoundation.org>
	<20150512142807.GB15805@yow-lhowlett-d0.wrs.com>
	<2131793.ifvVUYI7Oy@peggleto-mobl.ger.corp.intel.com>
	<557ED558.10502@mlbassoc.com>
In-Reply-To: <557ED558.10502@mlbassoc.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.22.254.139]
MIME-Version: 1.0
Cc: "Howlett, Liam \(Wind River\)" <liam.howlett@windriver.com>,
	Paul Eggleton <paul.eggleton@linux.intel.com>
Subject: Re: [PATCH v3] fetch2: Add BB_ALLOWED_NETWORKS	support
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
X-List-Received-Date: Mon, 15 Jun 2015 14:03:28 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,=20

Here is a first draft of documenting the BB_ALLOWED_NETWORKS variable in th=
e BitBake User Manual.  I re-wrote the original text to be active voice and=
 applied some different organization of the facts to help the flow out.  Re=
garding Gary's input about BB_NO_NETWORK..... I took a half guess at incorp=
orating it.  Please look this new description over and let me know of any c=
orrections I need to make.  http://www.yoctoproject.org/docs/1.9/bitbake-us=
er-manual/bitbake-user-manual.html#var-BB_ALLOWED_NETWORKS.

Thanks,
Scott

>-----Original Message-----
>From: bitbake-devel-bounces@lists.openembedded.org [mailto:bitbake-
>devel-bounces@lists.openembedded.org] On Behalf Of Gary Thomas
>Sent: Monday, June 15, 2015 6:39 AM
>To: bitbake-devel@lists.openembedded.org
>Subject: Re: [bitbake-devel] [PATCH v3] fetch2: Add
>BB_ALLOWED_NETWORKS support
>
>On 2015-06-15 07:28, Paul Eggleton wrote:
>> On Tuesday 12 May 2015 10:28:08 Liam R. Howlett wrote:
>>> * Richard Purdie <richard.purdie@linuxfoundation.org> [150512 07:18]:
>>>> On Thu, 2015-04-16 at 13:23 -0400, Liam R. Howlett wrote:
>>>>> BB_ALLOWED_NETWORKS is a list of hosts that the fetcher will be
>>>>> allowed to use when BB_NO_NETWORK is not set.
>>>>>
>>>>> If BB_NO_NETWORK is set, then networking is still disabled.
>>>>>
>>>>> If BB_ALLOWED_NETWORKS is not set, the behaviour remains the same
>>>>> as today.
>>>>>
>>>>> If BB_NO_NETWORK is NOT set, and BB_ALLOWED_NETWORKS is
>configured,
>>>>> then only the hosts in the list are usable by the fetcher.
>>>>>
>>>>> eg:
>>>>> BB_ALLOWED_NETWORKS=3D"yoctoproject.org git.gnu.org"
>>>>> The fetcher will be able to download from yoctoproject.org,
>>>>> git.gnu.org, but not ftp.gnu.org or any other hostname that is not in=
 the
>list.
>>>>>
>>>>> There is also limited support for wildcards on the beginning of the
>>>>> hosts, so BB_ALLOWED_NETWORKS=3D"*.gnu.org" with match git.gnu.org
>>>>> and ftp.gnu.org as well as foo.git.gnu.org
>>>>>
>>>>> Signed-off-by: Liam R. Howlett <Liam.Howlett@WindRiver.com>
>>>>> ---
>>>>>
>>>>>   lib/bb/fetch2/__init__.py | 53
>>>>>   +++++++++++++++++++++++++++++++++++++++++++++++
>lib/bb/tests/fetch.py
>>>>>      | 37 +++++++++++++++++++++++++++++++++
>>>>>   2 files changed, 90 insertions(+)
>>>>
>>>> I've merged this, however, one of the things we're trying to do is
>>>> improve the documentation of bitbake. Would you be able to work with
>>>> Scott (cc'd) to ensure this is documented in the manual please?
>>>>
>>>> Cheers,
>>>>
>>>> Richard
>>>
>>> Absolutely, Thanks Richard.
>>>
>>> Hello Scott,
>>>
>>> If you don't have anything started, we can work from the text below
>>> if you'd like.
>>>
>>> --------
>>>
>>> BB_ALLOWED_NETWORKS
>>>
>>> Specifies a space delimited list of hosts which are allowed to be
>>> used by the fetcher to obtain the required source code.  This list is
>>> only used if BB_NO_NETWORK is not set.  Wildcard matching at the
>>> beginning of
>
>Hopefully BB_NO_NETWORK=3D'0' (which is different from 'not set')as well?
>That works for all other uses of BB_NO_NETWORK.
>
>>> hosts is supported.  Mirrors that are not in the list will be skipped
>>> and logged in debug.  Attempts to access networks that are not in the
>>> BB_ALLOWED_NETWORKS will cause a failure.
>>>
>>> --------
>>>
>>> Thanks,
>>> Liam
>>
>> Replying to add Scott on CC - I think he has something for review.
>>
>> Cheers,
>> Paul
>>
>
>--
>------------------------------------------------------------
>Gary Thomas                 |  Consulting for the
>MLB Associates              |    Embedded world
>------------------------------------------------------------
>--
>_______________________________________________
>bitbake-devel mailing list
>bitbake-devel@lists.openembedded.org
>http://lists.openembedded.org/mailman/listinfo/bitbake-devel

