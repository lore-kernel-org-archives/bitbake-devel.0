Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 1E8D96028A
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  7 Jul 2014 06:16:07 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.5) with ESMTP id s676G876000601
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Sun, 6 Jul 2014 23:16:08 -0700 (PDT)
Received: from [128.224.162.181] (128.224.162.181) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.40) with Microsoft SMTP Server id 14.3.169.1;
	Sun, 6 Jul 2014 23:16:07 -0700
Message-ID: <53BA3B26.4050407@windriver.com>
Date: Mon, 7 Jul 2014 14:16:06 +0800
From: Robert Yang <liezhi.yang@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux i686;
	rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To: "Rifenbark, Scott M" <scott.m.rifenbark@intel.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
References: <cover.1404452300.git.liezhi.yang@windriver.com>
	<29052f940ce9526083a09d3ce4e665a5aa9e0db1.1404452300.git.liezhi.yang@windriver.com>
	<41DEA4B02DBDEF40A0F3B6D0DDB1237983FB63A9@ORSMSX101.amr.corp.intel.com>
In-Reply-To: <41DEA4B02DBDEF40A0F3B6D0DDB1237983FB63A9@ORSMSX101.amr.corp.intel.com>
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
X-List-Received-Date: Mon, 07 Jul 2014 06:16:11 -0000
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit



On 07/07/2014 02:13 PM, Rifenbark, Scott M wrote:
> Patch applied,
>

Sorry, this has not been approved, we need wait for RP's comments and update
it, and we should merge the part for bitbake first.

// Robert

> Thanks,
> Scott
>
>> -----Original Message-----
>> From: bitbake-devel-bounces@lists.openembedded.org [mailto:bitbake-
>> devel-bounces@lists.openembedded.org] On Behalf Of Robert Yang
>> Sent: Thursday, July 03, 2014 10:39 PM
>> To: bitbake-devel@lists.openembedded.org
>> Subject: [bitbake-devel] [PATCH 2/2] bitbake-user-manual-intro.xml: update
>> for dump-signatures
>>
>> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
>> ---
>> .../bitbake-user-manual-intro.xml                  |   10 ++++++----
>> 1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-intro.xml
>> b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-intro.xml
>> index ae267b4..e4025a8 100644
>> --- a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-intro.xml
>> +++ b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-intro.xml
>> @@ -471,11 +471,13 @@
>>         -D, --debug           Increase the debug level. You can specify this more
>>                               than once.
>>         -n, --dry-run         Don't execute, just go through the motions.
>> -       -S DUMP_SIGNATURES, --dump-signatures=DUMP_SIGNATURES
>> +       -S SIGNATURE_HANDLER, --dump-signatures=SIGNATURE_HANDLER
>>                               Dump out the signature construction information, with
>> -                             no task execution. Parameters are passed to the
>> -                             signature handling code, use 'none' if no specific
>> -                             handler is required.
>> +                             no task execution. The SIGNATURE_HANDLER can be none
>> +                             or printdiff, while none means only dump the
>> +                             signature, printdiff means compare the dumped
>> +                             signature with the cached one.
>> +
>>         -p, --parse-only      Quit after parsing the BB recipes.
>>         -s, --show-versions   Show current and preferred versions of all recipes.
>>         -e, --environment     Show the global or per-package environment
>> complete
>> --
>> 1.7.9.5
>>
>> --
>> _______________________________________________
>> bitbake-devel mailing list
>> bitbake-devel@lists.openembedded.org
>> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>
>

