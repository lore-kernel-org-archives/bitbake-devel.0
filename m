Return-Path: <mark.hatle@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 5A0C17BFDB
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  8 Jan 2019 21:24:53 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id x08LObni019636
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Tue, 8 Jan 2019 13:24:37 -0800 (PST)
Received: from soho-mhatle-m.local (172.25.36.226) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.408.0;
	Tue, 8 Jan 2019 13:24:37 -0800
From: Mark Hatle <mark.hatle@windriver.com>
To: Linus Ziegert <linus.ziegert@holoplot.com>,
	=?UTF-8?Q?Krystian_Garli=c5=84ski?= <krystian.garlinski@comarch.pl>
References: <20190108074737.15427-1-krystian.garlinski@comarch.pl>
	<CAPm2bJ_ZAmsCU04_sqRL9KL7YELUPj2iMi8_efUNvtnKOgT=nw@mail.gmail.com>
	<35035dcf-86aa-a3d1-1af4-3866be48cd8a@windriver.com>
Openpgp: preference=signencrypt
Autocrypt: addr=mark.hatle@windriver.com; prefer-encrypt=mutual; keydata=
	mQENBFYKxFgBCACt/pzutBp6p/xVKTFJjHbM3KpQKCblyot/YP+bpTr51Hrc5xDXBQhoG7TC
	aIRvRIvbhEevEQK9y04gW3JK/5lobq5ORebolcsHlYBUvpNeIPjupLQwGvz/TPtrLRNGLqDC
	rvsM6OA2XbQ2bwzxWaSQS3ImE2O2iXOZn9HhThMGeDB4Nff3fgUvXOTDIrgWOn9K2DgLL7Yc
	zkUIlFdj+Nraksd/7BSk8oH6tjeBVhFqSFvKta9QxWgdr58oPaTYaW/xNqUjlLrbJuMw/MSe
	xzuYfdfDfm6J8kRjMOnwQ0n8svJElzqAk+d83ow38gpGQ+LkjGgnf8ZFJ4rUJFADroX3ABEB
	AAG0JU1hcmsgSGF0bGUgPG1hcmsuaGF0bGVAd2luZHJpdmVyLmNvbT6JATcEEwEIACEFAlYK
	xFgCGwMFCwkIBwIGFQgJCgsCBBYCAwECHgECF4AACgkQfv796/r0vvlvZAf9Gs+eN320yhRW
	V/fZCsngKhmOK4v3HrTwFrkSmoD9QHQiE/5IPdNacHwIPwZx07tNBohB8xOeNqCPRYRBwGhA
	AnxKOPyd0nnm6ZhPzbA57v4x3IGRQr4QzvcBTASJq91l3Ew4lpAslyx5w1DPPqRD7G8ycDKg
	peKyDwmdkvCunVisSAQI3XIMq2y230biTO98tDPEezg+lg+yTsz9ZT33F5KNuWrpf8VL5fG/
	mt+kAv7wtsx/KTRbqhH3iFXF6eBSwMjAfTXFlkLfbM9riJGXrWEl9n2S2R3cDHNHug0lb8f4
	whK370KEO4OwRKIYW/VUBmzk5XZUE9DTlDSV8ycsrrkBDQRWCsRYAQgAwK3FuHCE+HW3YWdH
	PUjeSn5p//xJ57u8g2rng8zm9zNjmYgpPv5UxozaD9i2jf4mlQLHGGOezhHae8K4Nj70oVcv
	8AmwcrJa9i9WL1oy/9R3fHMWf/Ctt9VXTO0qlCuq6PDzaUfvsXR61aJIjTKNQTOjCLjY1vXm
	VSewUgARysmA8WrjTfwGBihMBxAX0+kIjx8nOlam0WvekMBXZ0AbS56oTLRxYao6DI3GeB/N
	oWPy/5DfuTKaSdM0Pf8al20x9RuNN5/HLMlyDH/k8bIa1xd9aAqW+Feiw5gC107V2E6ULyIy
	q6em2UrsmIRxrvpHqbNgQKqvTehJ+V/i4g/uOwARAQABiQEfBBgBCAAJBQJWCsRYAhsMAAoJ
	EH7+/ev69L755XAH/3ZcNhooqd9OBhFkvXm1iWZ8EoC7motWqVn2oEyxoonsg8AD9kFXiN+T
	dYp7dH99EZu9q4ptj56AXm4uHzOgywL/5/V2TY6twCGAjUGzDjAB5gzoi+JLIBlDiyOip0eL
	QswIhRk473xy3j8DA4oVamnSPWgyNJ+qsdt37YWDzoDFFvtDoRU7Eb+znfIMDKzlny0XU/8L
	cW1bNHJlpv/78GPdfP4tjysEd8MuA5jf5o5w4XqcwTqalffEJtQ/s3pbkstEi7qm5uPui5Kt
	gq6YYLSqcSNe0GWAF9/T+qwyo7burSTxUWCWtMmlXdAQLW9SynLhB3Jbch0nFAh0fCKi6yY=
Organization: Wind River Systems
Message-ID: <ae981d94-fad3-9d8f-0afb-d464d4d1d1e7@windriver.com>
Date: Tue, 8 Jan 2019 15:24:35 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
	Gecko/20100101 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <35035dcf-86aa-a3d1-1af4-3866be48cd8a@windriver.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH v2] fetch2/gitsm.py: Change the URI construction logic
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
X-List-Received-Date: Tue, 08 Jan 2019 21:24:53 -0000
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit

On 1/8/19 3:19 PM, Mark Hatle wrote:
> Upon further work, I'm getting this:
> 
> [git-submodule-test]$ git submodule add git@git.yoctoproject.org/bitbake-gitsm-test3
> repo URL: 'git@git.yoctoproject.org/bitbake-gitsm-test3' must be absolute or
> begin with ./|../
> 
> This tells me that the format mentioned below is not actually valid.
> 
> I'm getting the message from git versions:
> 
> git version 1.8.3.1
> git version 2.16.0.rc2
> 
> If I change it to the following, it does work -- and this is the format we're
> already expecting...
> 
> git submodule add git@git.yoctoproject.org:/bitbake-gitsm-test3
> 
> I'll try to manually modify the .gitmodules for this format, but technically
> speaking it doesn't appear to be legal.

I did finally try it.  Without the ':' git is looking at the local hard disk and
assuming that is a path and failing:


fatal: repository 'git@git.yoctoproject.org/bitbake-gitsm-test3' does not exist
Clone of 'git@git.yoctoproject.org/bitbake-gitsm-test3' into submodule path
'bitbake-gitsm-test3' failed

So I'm not sure how the stuff below is even valid.  I need a reproducer to be
able to code for it and test things.  Until then, everything I see says that
it's one of three formats:

proto://user:pass@host/path  (url style)
user@host:path (ssh style)
/path or ./path or ../path  (local path)

--Mark

> --Mark
> 
> On 1/8/19 10:35 AM, Linus Ziegert wrote:
>> Hello people,
>>
>> I am working as well on fetch2/gitsm.py. We have a privat repo with submodules
>> but the current gitsm.py does not support ssh.
>>
>> I tested the patch by Krystian but it did not worked for me. I got the following
>> ERROR:
>>
>>     ERROR: <recipe> do_fetch: The URL:
>>     'gitsm:git@github.com/<user>/<submodule_name1>.git;protocol=ssh;name=<submodule_name2>;bareclone=1;nocheckout=1;nobranch=1'
>>     is invalid and cannot be interpreted
>>
>>
>> The .gitmodules file used looks like this:
>>
>> [submodule "submodule_name1"]
>> path = submodule_name1
>>         url = git@github.com/<user>/<submodule_name1>.git 
>> [submodule "submodule_name2"]
>> path = submodule_name2
>>         url = git@github.com/<user>/<submodule_name2>.git 
>>
>> Attached you find my proposal.
>>
>>
>> Am Di., 8. Jan. 2019 um 08:48 Uhr schrieb Krystian Garliński
>> <krystian.garlinski@comarch.pl>:
>>
>>     Git allows to use both the proper URI's and SCP-like short style syntax
>>     for the SSH protocol. This commit changes construction logic to detect which
>>     one of the two is used in the submodule specification and to build a correct
>>     URI out of it.
>>
>>     Signed-off-by: Krystian Garliński <krystian.garlinski@comarch.pl
>>     <mailto:krystian.garlinski@comarch.pl>>
>>     ---
>>      lib/bb/fetch2/gitsm.py | 16 ++++++++++++++--
>>      1 file changed, 14 insertions(+), 2 deletions(-)
>>
>>     diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
>>     index 35729dbc..95d5f652 100644
>>     --- a/lib/bb/fetch2/gitsm.py
>>     +++ b/lib/bb/fetch2/gitsm.py
>>     @@ -32,6 +32,7 @@ NOTE: Switching a SRC_URI from "git://" to "gitsm://"
>>     requires a clean of your r
>>      import os
>>      import bb
>>      import copy
>>     +import re
>>      from   bb.fetch2.git import Git
>>      from   bb.fetch2 import runfetchcmd
>>      from   bb.fetch2 import logger
>>     @@ -39,6 +40,8 @@ from   bb.fetch2 import Fetch
>>      from   bb.fetch2 import BBFetchException
>>
>>      class GitSM(Git):
>>     +    scp_regex = re.compile(r'^([a-zA-Z0-9_]+)@([a-zA-Z0-9._-]+):(.+)$')
>>     +
>>          def supports(self, ud, d):
>>              """
>>              Check to see if a given url can be fetched with git.
>>     @@ -88,8 +91,17 @@ class GitSM(Git):
>>                  module_hash = module_hash.split()[2]
>>
>>                  # Build new SRC_URI
>>     -            proto = uris[module].split(':', 1)[0]
>>     -            url = uris[module].replace('%s:' % proto, 'gitsm:', 1)
>>     +            uri = uris[module]
>>     +            match = GitSM.scp_regex.match(uri)
>>     +
>>     +            if match:
>>     +                # this URI follows the short SCP-like syntax
>>     +                url = 'gitsm://{}@{}/{}'.format(match.group(1),
>>     match.group(2), match.group(3))
>>     +                proto = 'ssh'
>>     +            else:
>>     +                proto = uri.split(':', 1)[0]
>>     +                url = 'gitsm' + uri[len(proto):]
>>     +
>>                  url += ';protocol=%s' % proto
>>                  url += ";name=%s" % module
>>                  url += ";bareclone=1;nocheckout=1;nobranch=1"
>>     -- 
>>     2.19.1
>>
>>     -- 
>>     _______________________________________________
>>     bitbake-devel mailing list
>>     bitbake-devel@lists.openembedded.org
>>     <mailto:bitbake-devel@lists.openembedded.org>
>>     http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>>
>>
>>
>> -- 
>>
>> Cheers, 
>> Linus
>>
> 


