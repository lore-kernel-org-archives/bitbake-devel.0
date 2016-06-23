Return-Path: <leonardo.sandoval.gonzalez@linux.intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id B13A173173
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 23 Jun 2016 20:48:27 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by fmsmga102.fm.intel.com with ESMTP; 23 Jun 2016 13:48:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.26,518,1459839600"; d="scan'208";a="127509893"
Received: from lsandov1-mobl2.zpn.intel.com (HELO [10.219.5.155])
	([10.219.5.155])
	by fmsmga004.fm.intel.com with ESMTP; 23 Jun 2016 13:48:28 -0700
To: Stefan Christ <s.christ@phytec.de>, akuster <akuster@mvista.com>
References: <1466588072-37331-1-git-send-email-s.christ@phytec.de>
	<576AB396.3020207@mvista.com> <20160623110038.GD2346@lws-christ>
From: Leonardo Sandoval <leonardo.sandoval.gonzalez@linux.intel.com>
Message-ID: <a3db0402-f89e-a971-29b1-ecfa02514688@linux.intel.com>
Date: Thu, 23 Jun 2016 15:50:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
	Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <20160623110038.GD2346@lws-christ>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH krogoth+] fetch2: fix unpack of symbolic links
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
X-List-Received-Date: Thu, 23 Jun 2016 20:48:30 -0000
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

I believe there is no agreement but in general, sending n patches 
(perhaps all identical) just changing the branch target would be the way 
to do this. Doing some patchwork patch fetching and parsing, this is 
what I found related to the format between [XXX]


* fraction only, i.e. [0/10]
* version only, i.e. [v2]
* fraction + branch, i.e. [0/10, fido]
* branch + fraction, i.e. [fido, 0/10]
* fraction + branch + version, i.e. [0/10, fido, v2]
* patch string, i.e. [PATCH]
* patch string + version, i.e. [PATCHv2]
* etc..

So this indicates that we need a better guideline to submit patches, at 
least on this area.

On 06/23/2016 06:00 AM, Stefan Christ wrote:
> Hi Armin,
>
> On Wed, Jun 22, 2016 at 08:49:42AM -0700, akuster wrote:
>> Does the "Krogoth+" mean "master" too?
>>
>> - armin
>>
> Yes. The patch applies on master and krogoth.
>
> Mit freundlichen Grüßen / Kind regards,
> 	Stefan Christ
>
>> On 06/22/2016 02:34 AM, Stefan Christ wrote:
>>> Files in the download directory can be symbolic links to the real file.
>>> The fetcher must copy the real file instead of copying the symbolic
>>> link. Otherwise other tasks will fail, like patching, or the recipe will
>>> modify files in the download directory.
>>>
>>> This patch fixes commit 865d2fef ("bitbake: fetch2: fixes copying of
>>> file://dir; subdir=foo, bug 6128 and bug 6129").
>>>
>>> Signed-off-by: Stefan Christ <s.christ@phytec.de>
>>> ---
>>>   bitbake/lib/bb/fetch2/__init__.py | 4 +++-
>>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
>>> index e8fbe89..a1819e7 100644
>>> --- a/bitbake/lib/bb/fetch2/__init__.py
>>> +++ b/bitbake/lib/bb/fetch2/__init__.py
>>> @@ -1423,7 +1423,9 @@ class FetchMethod(object):
>>>                       if urlpath.find("/") != -1:
>>>                           destdir = urlpath.rsplit("/", 1)[0] + '/'
>>>                           bb.utils.mkdirhier("%s/%s" % (unpackdir, destdir))
>>> -                cmd = 'cp -fpPR %s %s' % (file, destdir)
>>> +                # Use -L to always resolve symbolic links. Files in download
>>> +                # directory can be links to the real file.
>>> +                cmd = 'cp -fpLR %s %s' % (file, destdir)
>>>   
>>>           if not cmd:
>>>               return
>>>


