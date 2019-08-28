Return-Path: <mark.hatle@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id 415617E97A
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 28 Aug 2019 14:00:45 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x7SDxEq9027817
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Wed, 28 Aug 2019 06:59:30 -0700
Received: from soho-mhatle-m.local (172.25.36.226) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.468.0;
	Wed, 28 Aug 2019 06:59:16 -0700
To: Andrew Jeffery <andrew@aj.id.au>, <bitbake-devel@lists.openembedded.org>
References: <20190827000358.25777-1-andrew@aj.id.au>
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
Message-ID: <a0279d01-3d06-3648-f63c-9392be141397@windriver.com>
Date: Wed, 28 Aug 2019 08:59:15 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
	Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190827000358.25777-1-andrew@aj.id.au>
Cc: bradleyb@fuzziesquirrel.com, ojayanth@in.ibm.com
Subject: Re: [RESEND RFC PATCH] gitsm: Control submodule recursion
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
X-List-Received-Date: Wed, 28 Aug 2019 14:00:45 -0000
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit

On 8/26/19 7:03 PM, Andrew Jeffery wrote:
> There exist some use-cases where repositories related by submodules do
> not require submodules be recursively initialised despite needing the
> first layer of submodules to be fetched. Enable this usecase in gitsm by
> implementing a `recurse=X` SRC_URI parameter. The current implementation
> of the recurse parameter defaults to enabling exhaustive recursion to
> match the current behaviour of gitsm, with the one alternative being no
> recursion. Enough rope is provided to allow specific recursion depths to
> be implemented if necessary via the same interface. Values currently
> unsupported for the recurse parameter raise a ValueError to ensure
> forward compatibility.

I was thinking about this patch and I'm not sure it's needed.  There are ways to
do this without using gitsm.

If you don't want recursion, then why are you specifying 'gitsm' at all?  The
'git' fetcher won't recurse and can be used to pull down a subset of what would
have been a recursive fetch.  The 'subpath' parameter can even be used to
combine the items in the same way as the gitsm fetcher if really needed.

(A few more comments below, as more of a technical review)

> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> ---
>  lib/bb/fetch2/gitsm.py | 34 ++++++++++++++++++++++++++++------
>  1 file changed, 28 insertions(+), 6 deletions(-)
> 
> diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
> index c622771d21aa..5a8426b486e3 100644
> --- a/lib/bb/fetch2/gitsm.py
> +++ b/lib/bb/fetch2/gitsm.py
> @@ -6,7 +6,15 @@ after cloning.
>  
>  SRC_URI = "gitsm://<see Git fetcher for syntax>"
>  
> -See the Git fetcher, git://, for usage documentation.
> +Supported SRC_URI options are:
> +
> +- recurse
> +    Control recursive nature of submodule initialisation.
> +
> +    The default value is -1, which will recursively initialise all submodules.
> +    Set to 0 to disable recursiion.
> +
> +See the Git fetcher, git://, for further usage documentation.
>  
>  NOTE: Switching a SRC_URI from "git://" to "gitsm://" requires a clean of your recipe.
>  
> @@ -26,6 +34,15 @@ from   bb.fetch2 import logger
>  from   bb.fetch2 import Fetch
>  from   bb.fetch2 import BBFetchException
>  
> +def should_recurse(ud):
> +    recurse = ud.parm.get("recurse", "-1")
> +
> +    # Change this condition if we end up supporting specific maximum depths
> +    if recurse in ( "-1", "0" ):
> +        return recurse == "-1"
> +
> +    raise ValueError("Recursion control value not supported: %s" % (recurse))
> +
>  class GitSM(Git):
>      def supports(self, ud, d):
>          """
> @@ -95,25 +112,28 @@ class GitSM(Git):
>          for module in submodules:
>              # Translate the module url into a SRC_URI
>  
> +            recurse = should_recurse(ud)
>              if "://" in uris[module]:
>                  # Properly formated URL already
>                  proto = uris[module].split(':', 1)[0]
> -                url = uris[module].replace('%s:' % proto, 'gitsm:', 1)
> +                desired = "gitsm:" if recurse else "git:"
> +                url = uris[module].replace('%s:' % proto, desired, 1)

Above 'desired' is used, below 'scheme' is used.  You should use the same
variable for both, and set it before the first 'if'.  To me 'scheme' is a better
variable.

>              else:
> +                scheme = "gitsm://" if recurse else "git://"
>                  if ":" in uris[module]:
>                      # Most likely an SSH style reference
>                      proto = "ssh"
>                      if ":/" in uris[module]:
>                          # Absolute reference, easy to convert..
> -                        url = "gitsm://" + uris[module].replace(':/', '/', 1)
> +                        url = scheme + uris[module].replace(':/', '/', 1)
>                      else:
>                          # Relative reference, no way to know if this is right!
>                          logger.warning("Submodule included by %s refers to relative ssh reference %s.  References may fail if not absolute." % (ud.url, uris[module]))
> -                        url = "gitsm://" + uris[module].replace(':', '/', 1)
> +                        url = scheme + uris[module].replace(':', '/', 1)
>                  else:
>                      # This has to be a file reference
>                      proto = "file"
> -                    url = "gitsm://" + uris[module]
> +                    url = scheme + uris[module]
>  
>              url += ';protocol=%s' % proto
>              url += ";name=%s" % module
> @@ -209,7 +229,9 @@ class GitSM(Git):
>          ret = self.process_submodules(ud, ud.destdir, unpack_submodules, d)
>  
>          if not ud.bareclone and ret:
> +            recurse = should_recurse(ud)
>              # All submodules should already be downloaded and configured in the tree.  This simply sets
>              # up the configuration and checks out the files.  The main project config should remain
>              # unmodified, and no download from the internet should occur.
> -            runfetchcmd("%s submodule update --recursive --no-fetch" % (ud.basecmd), d, quiet=True, workdir=ud.destdir)
> +            runfetchcmd("%s submodule update %s --no-fetch" % (ud.basecmd, "--recursive" if recurse else ""),
> +                        d, quiet=True, workdir=ud.destdir)
> 


