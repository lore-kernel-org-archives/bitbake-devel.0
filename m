Return-Path: <scott.m.rifenbark@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 91B066028A
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  7 Jul 2014 06:18:10 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 06 Jul 2014 23:18:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.01,616,1400050800"; d="scan'208";a="539562338"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
	by orsmga001.jf.intel.com with ESMTP; 06 Jul 2014 23:18:11 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.157]) by
	ORSMSX104.amr.corp.intel.com ([169.254.3.57]) with mapi id
	14.03.0123.003; Sun, 6 Jul 2014 23:18:11 -0700
From: "Rifenbark, Scott M" <scott.m.rifenbark@intel.com>
To: "Yang, Liezhi (Wind River)" <liezhi.yang@windriver.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH 2/2] bitbake-user-manual-intro.xml:
	update for dump-signatures
Thread-Index: AQHPmar794/5w+nVXEuOHscJQHyp4JuUIscA
Date: Mon, 7 Jul 2014 06:18:11 +0000
Message-ID: <41DEA4B02DBDEF40A0F3B6D0DDB1237983FB63CD@ORSMSX101.amr.corp.intel.com>
References: <cover.1404452300.git.liezhi.yang@windriver.com>
	<29052f940ce9526083a09d3ce4e665a5aa9e0db1.1404452300.git.liezhi.yang@windriver.com>
	<41DEA4B02DBDEF40A0F3B6D0DDB1237983FB63A9@ORSMSX101.amr.corp.intel.com>
	<53BA3B26.4050407@windriver.com>
In-Reply-To: <53BA3B26.4050407@windriver.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.22.254.138]
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] bitbake-user-manual-intro.xml: update for dump-signatures
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
X-List-Received-Date: Mon, 07 Jul 2014 06:18:11 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Ok - if there is a problem or changes then let me know.  I have the doc cha=
nges pushed to poky-contrib/srifenbark/bb-manual only.  Richard would have =
to merge them from there into the upstream bitbake repository.

Scott

>-----Original Message-----
>From: Robert Yang [mailto:liezhi.yang@windriver.com]
>Sent: Sunday, July 06, 2014 11:16 PM
>To: Rifenbark, Scott M; bitbake-devel@lists.openembedded.org
>Subject: Re: [bitbake-devel] [PATCH 2/2] bitbake-user-manual-intro.xml:
>update for dump-signatures
>
>
>
>On 07/07/2014 02:13 PM, Rifenbark, Scott M wrote:
>> Patch applied,
>>
>
>Sorry, this has not been approved, we need wait for RP's comments and
>update it, and we should merge the part for bitbake first.
>
>// Robert
>
>> Thanks,
>> Scott
>>
>>> -----Original Message-----
>>> From: bitbake-devel-bounces@lists.openembedded.org [mailto:bitbake-
>>> devel-bounces@lists.openembedded.org] On Behalf Of Robert Yang
>>> Sent: Thursday, July 03, 2014 10:39 PM
>>> To: bitbake-devel@lists.openembedded.org
>>> Subject: [bitbake-devel] [PATCH 2/2] bitbake-user-manual-intro.xml:
>>> update for dump-signatures
>>>
>>> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
>>> ---
>>> .../bitbake-user-manual-intro.xml                  |   10 ++++++----
>>> 1 file changed, 6 insertions(+), 4 deletions(-)
>>>
>>> diff --git
>>> a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-intro.xml
>>> b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-intro.xml
>>> index ae267b4..e4025a8 100644
>>> --- a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-intro.xml
>>> +++ b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-intro.xml
>>> @@ -471,11 +471,13 @@
>>>         -D, --debug           Increase the debug level. You can specify=
 this more
>>>                               than once.
>>>         -n, --dry-run         Don't execute, just go through the motion=
s.
>>> -       -S DUMP_SIGNATURES, --dump-signatures=3DDUMP_SIGNATURES
>>> +       -S SIGNATURE_HANDLER, --dump-signatures=3DSIGNATURE_HANDLER
>>>                               Dump out the signature construction infor=
mation, with
>>> -                             no task execution. Parameters are passed =
to the
>>> -                             signature handling code, use 'none' if no=
 specific
>>> -                             handler is required.
>>> +                             no task execution. The SIGNATURE_HANDLER =
can be none
>>> +                             or printdiff, while none means only dump =
the
>>> +                             signature, printdiff means compare the du=
mped
>>> +                             signature with the cached one.
>>> +
>>>         -p, --parse-only      Quit after parsing the BB recipes.
>>>         -s, --show-versions   Show current and preferred versions of al=
l
>recipes.
>>>         -e, --environment     Show the global or per-package environmen=
t
>>> complete
>>> --
>>> 1.7.9.5
>>>
>>> --
>>> _______________________________________________
>>> bitbake-devel mailing list
>>> bitbake-devel@lists.openembedded.org
>>> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>>
>>

