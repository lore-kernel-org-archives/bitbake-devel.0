Return-Path: <gary@mlbassoc.com>
X-Greylist: delayed 307 seconds by postgrey-1.34 at layers.openembedded.org;
	Fri, 12 May 2017 15:29:19 UTC
Received: from mail.analogue-micro.com (mail.analogue-micro.com
	[217.144.149.242])
	by mail.openembedded.org (Postfix) with ESMTP id B31A671DEE
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 May 2017 15:29:19 +0000 (UTC)
Received: by mail.analogue-micro.com (Postfix, from userid 999)
	id 5925068A019; Fri, 12 May 2017 16:24:12 +0100 (BST)
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on
	loki.analogue-micro-ltd.com
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=5.0 tests=ALL_TRUSTED,BAYES_20,
	DNS_FROM_AHBL_RHSBL autolearn=no version=3.3.2
Received: from zeus.mlbassoc.com (unknown [10.8.0.2])
	by mail.analogue-micro.com (Postfix) with ESMTP id C0A5D68A019;
	Fri, 12 May 2017 16:24:11 +0100 (BST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by zeus.mlbassoc.com (Postfix) with ESMTP id 3D1CC6740223;
	Fri, 12 May 2017 17:24:11 +0200 (CEST)
To: bitbake-devel@lists.openembedded.org
References: <1494577570-6677-1-git-send-email-richard.purdie@linuxfoundation.org>
	<6210109a-1d23-e245-00df-a70594eabb0b@windriver.com>
From: Gary Thomas <gary@mlbassoc.com>
Message-ID: <3dee6b52-5067-fc06-9e2d-a1db5bb5d90b@mlbassoc.com>
Date: Fri, 12 May 2017 17:24:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
	Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <6210109a-1d23-e245-00df-a70594eabb0b@windriver.com>
Subject: Re: [PATCH] data_smart: Don't cache/process capitalised overrides
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
X-List-Received-Date: Fri, 12 May 2017 15:29:21 -0000
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

On 2017-05-12 15:54, Mark Hatle wrote:
> On 5/12/17 3:26 AM, Richard Purdie wrote:
>> Bitbake now only processes overrides which are lowercase since
>> this allows variables like SRC_URI not to pollute the cache.
>>
>> There was a corner case where XXX_append_SomeThing was still being
>> processed (yet XXX_append_SomeThing_SomeOtherThing would not be).
>>
>> This patch ensures we're consistent and only process lowercase
>> _append/_prepend and _remove operators too.
>
> I just realized a ramification of the previous and this change.  It prevents
> recipe/package names with uppercase characters in them since overrides will no
> longer be processed (like pn-....).

Did recipe/package names *ever* work with uppercase letters?  Certainly not for me!

>
> This is something that probably should be documented.  "Don't use uppercase!"
>
> --Mark
>
>> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
>> ---
>>  lib/bb/data_smart.py | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
>> index 7dc1c68..7b09af5 100644
>> --- a/lib/bb/data_smart.py
>> +++ b/lib/bb/data_smart.py
>> @@ -39,7 +39,7 @@ from bb.COW  import COWDictBase
>>  logger = logging.getLogger("BitBake.Data")
>>
>>  __setvar_keyword__ = ["_append", "_prepend", "_remove"]
>> -__setvar_regexp__ = re.compile('(?P<base>.*?)(?P<keyword>_append|_prepend|_remove)(_(?P<add>.*))?$')
>> +__setvar_regexp__ = re.compile('(?P<base>.*?)(?P<keyword>_append|_prepend|_remove)(_(?P<add>[^A-Z]*))?$')
>>  __expand_var_regexp__ = re.compile(r"\${[^{}@\n\t :]+}")
>>  __expand_python_regexp__ = re.compile(r"\${@.+?}")
>>
>>
>


-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------

