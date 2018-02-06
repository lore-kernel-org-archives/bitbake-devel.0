Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 10E3F600BC
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  6 Feb 2018 08:46:37 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id w168kaup013059
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Tue, 6 Feb 2018 00:46:37 -0800 (PST)
Received: from localhost.localdomain (128.224.163.240) by
	ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server id
	14.3.361.1; Tue, 6 Feb 2018 00:46:33 -0800
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	<bitbake-devel@lists.openembedded.org>
References: <cover.1517497731.git.liezhi.yang@windriver.com>
	<83c30f41462e2f78738b61f7beaf32411949fd7a.1517497731.git.liezhi.yang@windriver.com>
	<1517570355.3090.58.camel@linuxfoundation.org>
From: Robert Yang <liezhi.yang@windriver.com>
Message-ID: <da829266-9659-1c92-fa01-55907ff6f097@windriver.com>
Date: Tue, 6 Feb 2018 16:46:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1517570355.3090.58.camel@linuxfoundation.org>
Subject: Re: [PATCH 7/8] bitbake: cooker: fix event notifications
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
X-List-Received-Date: Tue, 06 Feb 2018 08:46:38 -0000
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit

Hi RP,

On 02/02/2018 07:19 PM, Richard Purdie wrote:
> On Thu, 2018-02-01 at 23:15 +0800, Robert Yang wrote:
>> There are two kinds of events:
>> * directory
>>    We always need handle the event since we don't know what inside the
>>    directory, for example:
>>    $ bitbake --server-only -T -1
>>    $ bitbake -p
>>    $ mkdir ${TOPDIR}/classes
>>    $ cp /path/to/base.bbclass classes
>>
>>    The "${TOPDIR}/classes" is a new directory, the event only reports
>> that the
>>    directory is created, we don't know there is a base.bbclass unless
>> the parser
>>    runs.
>>
>> * file:
>>    Use bb.parse.supports() to check whether bitbake supports it or
>> not.
>>
>> And now the bbwatchedfiles is not needed anymore.
>>
>> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
>> ---
>>   bitbake/lib/bb/cooker.py | 34 ++++++++++++++++++----------------
>>   1 file changed, 18 insertions(+), 16 deletions(-)
> 
> I'm not sure you can do this. For example, bitbake itself doesn't
> know/care about *.patch files, however if one is referenced in a
> SRC_URI and ends up on the watch list, would this change break a patch
> file changing causing task checksums to change?

I can confirm the the following 2 things:
1) The watcher only watches __depends (and __base_depends) which only contains
    files supported by bb.parse.supports(), so use bb.parse.supports() to check
    it is OK (or maybe it is the best way).

2) The *.patch is not part of of __depends, but file_checksums, and they are not
    watched by watchers. When a patch is updated, it would compare the saved
    mtime and current mtime (in lib/bb/checksum.py), and decide whether need
    recompute.

So I think that this patch is fine.

The testcase:

$ bitbake --server-only -T -1
$ bitbake quilt-native

# Update quilt-native's patch to test the rebuild:
$ echo "hello world" >> 
/path/to/meta/recipes-devtools/quilt/quilt/0001-tests-Allow-different-output-from-mv.patch

# Build quilt-native again
$ bitbake quilt-native

NOTE: Tasks Summary: Attempted 10 tasks of which 0 didn't need to be rerun and 
all succeeded.

We can see that it has been rebuilt.

// Robert

> 
> Its looking like we need better tests for some of this code too :/.
> 
> Cheers,
> 
> Richard
> 
> 

