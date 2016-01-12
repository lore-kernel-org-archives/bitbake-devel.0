Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 310946FFCE
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 12 Jan 2016 01:31:25 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id u0C1VPgr008513
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Mon, 11 Jan 2016 17:31:25 -0800 (PST)
Received: from [128.224.162.155] (128.224.162.155) by ALA-HCB.corp.ad.wrs.com
	(147.11.189.41) with Microsoft SMTP Server id 14.3.248.2;
	Mon, 11 Jan 2016 17:31:24 -0800
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	<bitbake-devel@lists.openembedded.org>
References: <cover.1451902509.git.liezhi.yang@windriver.com>
	<11cf5052016496de57d2253aff35c20c62d90703.1451902509.git.liezhi.yang@windriver.com>
	<1452518596.7598.173.camel@linuxfoundation.org>
From: Robert Yang <liezhi.yang@windriver.com>
Message-ID: <5694576B.8080000@windriver.com>
Date: Tue, 12 Jan 2016 09:31:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
	Thunderbird/38.4.0
MIME-Version: 1.0
In-Reply-To: <1452518596.7598.173.camel@linuxfoundation.org>
Subject: Re: [PATCH 1/1] fetch2/local.py: avoid using PREMIRROR
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
X-List-Received-Date: Tue, 12 Jan 2016 01:31:28 -0000
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit


On 01/11/2016 09:23 PM, Richard Purdie wrote:
> On Mon, 2016-01-04 at 02:15 -0800, Robert Yang wrote:
>> The PREMIRROR isn't useful for "file://", so avoid using it, this is
>> good for searching speed and can reduce useless lines in
>> log.do_fetch.
>>
>> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
>> ---
>>   bitbake/lib/bb/fetch2/local.py |    5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/bitbake/lib/bb/fetch2/local.py
>> b/bitbake/lib/bb/fetch2/local.py
>> index 2d921f7..7245651 100644
>> --- a/bitbake/lib/bb/fetch2/local.py
>> +++ b/bitbake/lib/bb/fetch2/local.py
>> @@ -126,3 +126,8 @@ class Local(FetchMethod):
>>       def clean(self, urldata, d):
>>           return
>>
>> +    def try_premirror(self, urldata, d):
>> +        """
>> +        Should premirrors be used?
>> +        """
>> +        return False
>
> Hi Robert,
>
> I applied this but I think I'm going to have to revert this since it is
> in fact a valid use case.
>
> The sstate.bbclass code sets up SSTATE_MIRRORS as PREMIRRORS. Its quite
> common to map those file:// urls to remote http:// urls and with the
> above change, this no longer works.

Sorry, I didn't realize that sstate.bbclass code sets up SSTATE_MIRRORS
as PREMIRRORS. If file:// urls map to http://, I think that it should use
bitbake/lib/bb/fetch2/wget.py ? Here is a patch for wget.py:

   git://git.pokylinux.org/poky-contrib rbt/local.py
   http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=rbt/local.py

Robert Yang (1):
   wget.py: use PREMIRROR


Subject: [PATCH 1/1] wget.py: use PREMIRROR

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
  bitbake/lib/bb/fetch2/wget.py |    7 +++++++
  1 file changed, 7 insertions(+)

diff --git a/bitbake/lib/bb/fetch2/wget.py b/bitbake/lib/bb/fetch2/wget.py
index c8c6d5c..200f9aa 100644
--- a/bitbake/lib/bb/fetch2/wget.py
+++ b/bitbake/lib/bb/fetch2/wget.py
@@ -540,3 +540,10 @@ class Wget(FetchMethod):

          return (self._check_latest_version(uri, package, package_regex,
                  current_version, ud, d), '')
+
+    def try_premirror(self, urldata, d):
+        """
+        Should premirrors be used?
+        """
+        return True
+
-- 
1.7.9.5


// Robert

>
> Cheers,
>
> Richard
>
>
>

