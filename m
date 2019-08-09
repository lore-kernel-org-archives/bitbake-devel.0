Return-Path: <mark.hatle@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 875D47F32E
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  9 Aug 2019 16:49:46 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id x79Gnlth025128
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 9 Aug 2019 09:49:47 -0700 (PDT)
Received: from soho-mhatle-m.local (172.25.36.227) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.468.0;
	Fri, 9 Aug 2019 09:49:46 -0700
To: <bitbake-devel@lists.openembedded.org>
References: <20190801203654.140427-1-mark.hatle@windriver.com>
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
Message-ID: <e1df1aa0-de09-f507-9868-65211538696b@windriver.com>
Date: Fri, 9 Aug 2019 11:49:46 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
	Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190801203654.140427-1-mark.hatle@windriver.com>
Subject: Re: [PATCH] layerindexlib: Fix parsing of recursive layer dependencies
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
X-List-Received-Date: Fri, 09 Aug 2019 16:49:46 -0000
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit

Ping.  I haven't seen any feedback on this and it doesn't appear to have been
included in -next.

--Mark

On 8/1/19 3:36 PM, Mark Hatle wrote:
> [YOCTO #13447]
> 
> When running bitbake-layers layerindex-fetch from 'master', there is a
> circular dependency between meta-oe and meta-python.  This triggered a maximum
> recursion depth exception.
> 
> To fix the exception, as we walk down a branch (depth first search), we track
> the layers we've already seen.  If we are about to recurse into a layer we've
> already seen we report a warning and then stop recursion.
> 
> Signed-off-by: Mark Hatle <mark.hatle@windriver.com>
> ---
>  lib/layerindexlib/__init__.py | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/layerindexlib/__init__.py b/lib/layerindexlib/__init__.py
> index d231cf6a..77196b40 100644
> --- a/lib/layerindexlib/__init__.py
> +++ b/lib/layerindexlib/__init__.py
> @@ -376,7 +376,7 @@ layerBranches set.  If not, they are effectively blank.'''
>                  invalid.append(name)
>  
>  
> -        def _resolve_dependencies(layerbranches, ignores, dependencies, invalid):
> +        def _resolve_dependencies(layerbranches, ignores, dependencies, invalid, processed=None):
>              for layerbranch in layerbranches:
>                  if ignores and layerbranch.layer.name in ignores:
>                      continue
> @@ -388,6 +388,13 @@ layerBranches set.  If not, they are effectively blank.'''
>                      if ignores and deplayerbranch.layer.name in ignores:
>                          continue
>  
> +                    # Since this is depth first, we need to know what we're currently processing
> +                    # in order to avoid infinite recursion on a loop.
> +                    if processed and deplayerbranch.layer.name in processed:
> +                        # We have found a recursion...
> +                        logger.warning('Circular layer dependency found: %s -> %s' % (processed, deplayerbranch.layer.name))
> +                        continue
> +
>                      # This little block is why we can't re-use the LayerIndexObj version,
>                      # we must be able to satisfy each dependencies across layer indexes and
>                      # use the layer index order for priority.  (r stands for replacement below)
> @@ -411,7 +418,17 @@ layerBranches set.  If not, they are effectively blank.'''
>  
>                      # New dependency, we need to resolve it now... depth-first
>                      if deplayerbranch.layer.name not in dependencies:
> -                        (dependencies, invalid) = _resolve_dependencies([deplayerbranch], ignores, dependencies, invalid)
> +                        # Avoid recursion on this branch.
> +                        # We copy so we don't end up polluting the depth-first branch with other
> +                        # branches.  Duplication between individual branches IS expected and
> +                        # handled by 'dependencies' processing.
> +                        if not processed:
> +                            local_processed = []
> +                        else:
> +                            local_processed = processed.copy()
> +                        local_processed.append(deplayerbranch.layer.name)
> +
> +                        (dependencies, invalid) = _resolve_dependencies([deplayerbranch], ignores, dependencies, invalid, local_processed)
>  
>                      if deplayerbranch.layer.name not in dependencies:
>                          dependencies[deplayerbranch.layer.name] = [deplayerbranch, layerdependency]
> 


