Return-Path: <mark.hatle@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id 295766BE3A
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  8 Jan 2019 19:08:19 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x08J5EUm013390
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Tue, 8 Jan 2019 11:05:51 -0800
Received: from soho-mhatle-m.local (172.25.36.226) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.408.0;
	Tue, 8 Jan 2019 11:05:22 -0800
To: <bitbake-devel@lists.openembedded.org>
References: <20190108074737.15427-1-krystian.garlinski@comarch.pl>
	<CAPm2bJ_ZAmsCU04_sqRL9KL7YELUPj2iMi8_efUNvtnKOgT=nw@mail.gmail.com>
From: Mark Hatle <mark.hatle@windriver.com>
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
Message-ID: <edee8347-d357-29b3-c8e3-2f964eeffdb2@windriver.com>
Date: Tue, 8 Jan 2019 13:05:21 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
	Gecko/20100101 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAPm2bJ_ZAmsCU04_sqRL9KL7YELUPj2iMi8_efUNvtnKOgT=nw@mail.gmail.com>
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
X-List-Received-Date: Tue, 08 Jan 2019 19:08:19 -0000
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit

The patch here and the other that didn't quite work either are close but not
completely correct.

There are apparently three (ssh) formats that git supports:

url format - ssh://user:password@host/path
ssh format - user@host:/path
(ssh)? format - user@host/path

Each have a different regex or splitting format required.  I'm working on a
specific reproducer test case for each of these, and then will work to combine
or tailor the various patches that have been submitted.  If anyone is aware of
any other odd formats please let me know and I'll add appropriate test cases for
those as well.

I'm guessing it'll be a couple of days for me to work through this, and then I
ask that people with the problem test this and verify it works in their specific
case.

--Mark

On 1/8/19 10:35 AM, Linus Ziegert wrote:
> Hello people,
> 
> I am working as well on fetch2/gitsm.py. We have a privat repo with submodules
> but the current gitsm.py does not support ssh.
> 
> I tested the patch by Krystian but it did not worked for me. I got the following
> ERROR:
> 
>     ERROR: <recipe> do_fetch: The URL:
>     'gitsm:git@github.com/<user>/<submodule_name1>.git;protocol=ssh;name=<submodule_name2>;bareclone=1;nocheckout=1;nobranch=1'
>     is invalid and cannot be interpreted
> 
> 
> The .gitmodules file used looks like this:
> 
> [submodule "submodule_name1"]
> path = submodule_name1
>         url = git@github.com/<user>/<submodule_name1>.git 
> [submodule "submodule_name2"]
> path = submodule_name2
>         url = git@github.com/<user>/<submodule_name2>.git 
> 
> Attached you find my proposal.
> 
> 
> Am Di., 8. Jan. 2019 um 08:48 Uhr schrieb Krystian Garliński
> <krystian.garlinski@comarch.pl>:
> 
>     Git allows to use both the proper URI's and SCP-like short style syntax
>     for the SSH protocol. This commit changes construction logic to detect which
>     one of the two is used in the submodule specification and to build a correct
>     URI out of it.
> 
>     Signed-off-by: Krystian Garliński <krystian.garlinski@comarch.pl
>     <mailto:krystian.garlinski@comarch.pl>>
>     ---
>      lib/bb/fetch2/gitsm.py | 16 ++++++++++++++--
>      1 file changed, 14 insertions(+), 2 deletions(-)
> 
>     diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
>     index 35729dbc..95d5f652 100644
>     --- a/lib/bb/fetch2/gitsm.py
>     +++ b/lib/bb/fetch2/gitsm.py
>     @@ -32,6 +32,7 @@ NOTE: Switching a SRC_URI from "git://" to "gitsm://"
>     requires a clean of your r
>      import os
>      import bb
>      import copy
>     +import re
>      from   bb.fetch2.git import Git
>      from   bb.fetch2 import runfetchcmd
>      from   bb.fetch2 import logger
>     @@ -39,6 +40,8 @@ from   bb.fetch2 import Fetch
>      from   bb.fetch2 import BBFetchException
> 
>      class GitSM(Git):
>     +    scp_regex = re.compile(r'^([a-zA-Z0-9_]+)@([a-zA-Z0-9._-]+):(.+)$')
>     +
>          def supports(self, ud, d):
>              """
>              Check to see if a given url can be fetched with git.
>     @@ -88,8 +91,17 @@ class GitSM(Git):
>                  module_hash = module_hash.split()[2]
> 
>                  # Build new SRC_URI
>     -            proto = uris[module].split(':', 1)[0]
>     -            url = uris[module].replace('%s:' % proto, 'gitsm:', 1)
>     +            uri = uris[module]
>     +            match = GitSM.scp_regex.match(uri)
>     +
>     +            if match:
>     +                # this URI follows the short SCP-like syntax
>     +                url = 'gitsm://{}@{}/{}'.format(match.group(1),
>     match.group(2), match.group(3))
>     +                proto = 'ssh'
>     +            else:
>     +                proto = uri.split(':', 1)[0]
>     +                url = 'gitsm' + uri[len(proto):]
>     +
>                  url += ';protocol=%s' % proto
>                  url += ";name=%s" % module
>                  url += ";bareclone=1;nocheckout=1;nobranch=1"
>     -- 
>     2.19.1
> 
>     -- 
>     _______________________________________________
>     bitbake-devel mailing list
>     bitbake-devel@lists.openembedded.org
>     <mailto:bitbake-devel@lists.openembedded.org>
>     http://lists.openembedded.org/mailman/listinfo/bitbake-devel
> 
> 
> 
> -- 
> 
> Cheers, 
> Linus
> 


