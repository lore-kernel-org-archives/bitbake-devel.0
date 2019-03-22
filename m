Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id A63D771BEE
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 22 Mar 2019 03:42:33 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x2M3flSH017246
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Thu, 21 Mar 2019 20:42:07 -0700
Received: from [128.224.163.177] (128.224.163.177) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.40) with Microsoft SMTP Server id 14.3.439.0;
	Thu, 21 Mar 2019 20:41:55 -0700
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	<bitbake-devel@lists.openembedded.org>
References: <cover.1553063929.git.liezhi.yang@windriver.com>
	<db5c32f158267831427a769f4db1a4f80125fd92.1553063929.git.liezhi.yang@windriver.com>
	<57405634beb17bee8c7cf82af7d8bf672a21ed52.camel@linuxfoundation.org>
From: Robert Yang <liezhi.yang@windriver.com>
Message-ID: <46033f6e-3fb0-36c1-7597-e2e2e3e2ebab@windriver.com>
Date: Fri, 22 Mar 2019 11:47:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <57405634beb17bee8c7cf82af7d8bf672a21ed52.camel@linuxfoundation.org>
Subject: Re: [PATCH 2/2] fetch2: Unify BB_FETCH_PREMIRRORONLY
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
X-List-Received-Date: Fri, 22 Mar 2019 03:42:33 -0000
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

Hi RP,

On 3/22/19 7:35 AM, Richard Purdie wrote:
> On Wed, 2019-03-20 at 14:40 +0800, Robert Yang wrote:
>> The fetch2/__init__.py checks whether "BB_FETCH_PREMIRRORONLY" ==
>> "1", but
>> fetch2/git.py and hg.py checks whether it is None, this makes it
>> discontinuous,
>> and BB_FETCH_PREMIRRORONLY = "0" doens't work as expected in the
>> later case,
>> so unify it to the previous one. (As BB_NO_NETWORK does).
>>
>> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
>> ---
>>   bitbake/lib/bb/fetch2/git.py | 2 +-
>>   bitbake/lib/bb/fetch2/hg.py  | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/bitbake/lib/bb/fetch2/git.py
>> b/bitbake/lib/bb/fetch2/git.py
>> index 1a8ebe3..e021f33 100644
>> --- a/bitbake/lib/bb/fetch2/git.py
>> +++ b/bitbake/lib/bb/fetch2/git.py
>> @@ -318,7 +318,7 @@ class Git(FetchMethod):
>>       def try_premirror(self, ud, d):
>>           # If we don't do this, updating an existing checkout with
>> only premirrors
>>           # is not possible
>> -        if d.getVar("BB_FETCH_PREMIRRORONLY") is not None:
>> +        if d.getVar("BB_FETCH_PREMIRRORONLY") == "1":
>>               return True
>>           if os.path.exists(ud.clonedir):
>>               return False
>> diff --git a/bitbake/lib/bb/fetch2/hg.py
>> b/bitbake/lib/bb/fetch2/hg.py
>> index 936d043..5a3db92 100644
>> --- a/bitbake/lib/bb/fetch2/hg.py
>> +++ b/bitbake/lib/bb/fetch2/hg.py
>> @@ -99,7 +99,7 @@ class Hg(FetchMethod):
>>       def try_premirror(self, ud, d):
>>           # If we don't do this, updating an existing checkout with
>> only premirrors
>>           # is not possible
>> -        if d.getVar("BB_FETCH_PREMIRRORONLY") is not None:
>> +        if d.getVar("BB_FETCH_PREMIRRORONLY") == "1":
>>               return True
>>           if os.path.exists(ud.moddir):
>>               return False
> 
> Can we use bb.utils.to_boolean() in all cases to be consistent please?

Thanks, I will update it.

I have another question about try_premirror(), are there any side effects
if we make try_premirror() always return true? I mean that:

def try_premirror(self, ud, d):
     return True

I've met a problem recently, when rework in an old build, e.g, suppose
there is a foo_git.bb:

1) Add foo.git to PREMIRROR

2) In builddir
$ bitbake foo
Then foo.git will be fetched into DL_DIR, which is premirror_foo.git.

3) Upgrade foo_git.bb's SRCREV, and this SRCREV isn't in premirror_foo.git since
    it's very new.

4) Upgrade foo.git in PREMIRROR, now it contains the SRCREV of step 3

5) Go to the old builddir
$ bitbake foo

Then it won't update from PREMIRROR if BB_FETCH_PREMIRRORONLY is not set,
and it would fail to build if BB_NO_NETWORK = "1" since SRCREV can't be found
in DL_DIR. Now the problem is:

- Set BB_FETCH_PREMIRRORONLY = "0" and BB_NO_NETWORK = "1" will make foo fail
   to build.

- Set BB_FETCH_PREMIRRORONLY = "1" will make it work for foo_git.bb, but it
   may not work for another recipe such as foo_X_git.bb even if
   BB_NO_NETWORK = "0".(Imagine the PREMIRROR doesn't contain foo_X_git.bb's
   SRCREV)

- Set BB_FETCH_PREMIRRORONLY = "0" and BB_NO_NETWORK = "0" will make foo work,
   but it won't upgrade from PREMIRROR, though everything is up-to-date there.
   It will update DL_DIR from SRC_URI, this isn't good when network is slow.

Things will be much easier if make try_premirror() always return True.

// Robert

> 
> Cheers,
> 
> Richard
> 
> 
> 

