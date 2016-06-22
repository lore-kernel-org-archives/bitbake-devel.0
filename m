Return-Path: <mark.hatle@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 93FE665CB6;
	Wed, 22 Jun 2016 21:56:40 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id u5MLucUk024237
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Wed, 22 Jun 2016 14:56:38 -0700 (PDT)
Received: from soho-mhatle-m.local (172.25.36.230) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.248.2;
	Wed, 22 Jun 2016 14:56:37 -0700
To: Richard Purdie <richard.purdie@linuxfoundation.org>, Martin Jansa
	<martin.jansa@gmail.com>, <openembedded-core@lists.openembedded.org>,
	<bitbake-devel@lists.openembedded.org>
References: <20160615073901.27831.65435@opal.openembedded.org>
	<20160622155839.GC4153@jama>
	<1466631350.3319.200.camel@linuxfoundation.org>
From: Mark Hatle <mark.hatle@windriver.com>
Organization: Wind River Systems
Message-ID: <754f3c3e-6dfe-766f-eb7c-f0983c945cc7@windriver.com>
Date: Wed, 22 Jun 2016 16:56:36 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:45.0)
	Gecko/20100101 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <1466631350.3319.200.camel@linuxfoundation.org>
Cc: openembedded-commits@lists.openembedded.org
Subject: Re: Bitbake output format changed Was: [oe-commits] [bitbake] branch master updated (a3f464d -> 0219271)
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
X-List-Received-Date: Wed, 22 Jun 2016 21:56:40 -0000
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit

On 6/22/16 4:35 PM, Richard Purdie wrote:
> On Wed, 2016-06-22 at 17:58 +0200, Martin Jansa wrote:
>> On Wed, Jun 15, 2016 at 07:39:01AM +0000, git@git.openembedded.org wr
>> ote:
>>> rpurdie pushed a change to branch master
>>> in repository bitbake.
>>>
>>>       adds  2c88afb   taskdata/runqueue: Rewrite without use of ID
>>> indirection
>>
>> Is it expected that this change also changes the format of summary 
>> shown at the end of the build and failed tasks.
>>
>> The commit message doesn't mention this (it even says:
>> ..
>> On the most part there shouldn't be user visible changes.
>> ..
>> There should be no functionality changes in this patch, its purely a
>> data structure change and that is visible in the patch.
>> ..
>> )
>>
>> So before I start fixing scripts (e.g. test-dependencies) which are 
>> trying to parse bitbake output to work with new format, please 
>> confirm that this was intentional and that it will stay this way.
>>
>> It's also not clear why the task is mentioned twice, e.g. as:
>>   NOTE: Running task 512 of 548 (ID: /OE/build/oe-core/openembedded
>> -core/meta/recipes-devtools/rpm/sftp.bb:do_fetch, /OE/build/oe
>> -core/openembedded-core/meta/recipes-devtools/rpm/sftp.bb:do_fetch)
>>   ERROR: Task /OE/build/oe-core/openembedded-core/meta/recipes
>> -devtools/rpm/sftp.bb:do_fetch (/OE/build/oe-core/openembedded
>> -core/meta/recipes-devtools/rpm/sftp.bb:do_fetch) failed with exit
>> code '1'
>>
>> are there cases where these 2 are different? and can both messages
>> use the same "format" for task description?
> 
> The taskids are no more, there is simply no notion of them inside
> bitbake any longer. That means that yes, we probably do need to change
> the output a bit since the number doesn't mean anything.
> 
> Equally, it shouldn't be showing the same thing twice, that is a bug.
> Internally to bitbake, everthing is now in the form (or will be when
> multiconfig lands) "[multiconfig:<configname>:]<recipe
> filename>:<taskname>". The question is whether we expose that to the
> user or massage it at all. I'm tempted just to expose that string to
> the user.

I'm certainly and advocate of just exposing that string.  I think in the end
that is easier to explain to someone, then trying to understand a massaged output.

--Mark

> Sorry about the script changes, not sure we can avoid it though :( The
> code is *way* easier to understand, debug and extend after these
> changes FWIW so I do believe it very worth doing.
> 
> Cheers,
> 
> Richard
> 


