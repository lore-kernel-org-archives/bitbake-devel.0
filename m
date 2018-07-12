Return-Path: <mark.hatle@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 2A4AE7871B
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Jul 2018 21:07:06 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id w6CL778G005837
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Jul 2018 14:07:08 -0700 (PDT)
Received: from soho-mhatle-m.local (172.25.36.226) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.399.0;
	Thu, 12 Jul 2018 14:07:07 -0700
From: Mark Hatle <mark.hatle@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
References: <20180712203413.118578-1-mark.hatle@windriver.com>
Openpgp: preference=signencrypt
Autocrypt: addr=mark.hatle@windriver.com; prefer-encrypt=mutual; keydata=
	xsBNBFYKxFgBCACt/pzutBp6p/xVKTFJjHbM3KpQKCblyot/YP+bpTr51Hrc5xDXBQhoG7TC
	aIRvRIvbhEevEQK9y04gW3JK/5lobq5ORebolcsHlYBUvpNeIPjupLQwGvz/TPtrLRNGLqDC
	rvsM6OA2XbQ2bwzxWaSQS3ImE2O2iXOZn9HhThMGeDB4Nff3fgUvXOTDIrgWOn9K2DgLL7Yc
	zkUIlFdj+Nraksd/7BSk8oH6tjeBVhFqSFvKta9QxWgdr58oPaTYaW/xNqUjlLrbJuMw/MSe
	xzuYfdfDfm6J8kRjMOnwQ0n8svJElzqAk+d83ow38gpGQ+LkjGgnf8ZFJ4rUJFADroX3ABEB
	AAHNJU1hcmsgSGF0bGUgPG1hcmsuaGF0bGVAd2luZHJpdmVyLmNvbT7CwHcEEwEIACEFAlYK
	xFgCGwMFCwkIBwIGFQgJCgsCBBYCAwECHgECF4AACgkQfv796/r0vvlvZAf9Gs+eN320yhRW
	V/fZCsngKhmOK4v3HrTwFrkSmoD9QHQiE/5IPdNacHwIPwZx07tNBohB8xOeNqCPRYRBwGhA
	AnxKOPyd0nnm6ZhPzbA57v4x3IGRQr4QzvcBTASJq91l3Ew4lpAslyx5w1DPPqRD7G8ycDKg
	peKyDwmdkvCunVisSAQI3XIMq2y230biTO98tDPEezg+lg+yTsz9ZT33F5KNuWrpf8VL5fG/
	mt+kAv7wtsx/KTRbqhH3iFXF6eBSwMjAfTXFlkLfbM9riJGXrWEl9n2S2R3cDHNHug0lb8f4
	whK370KEO4OwRKIYW/VUBmzk5XZUE9DTlDSV8ycsrs7ATQRWCsRYAQgAwK3FuHCE+HW3YWdH
	PUjeSn5p//xJ57u8g2rng8zm9zNjmYgpPv5UxozaD9i2jf4mlQLHGGOezhHae8K4Nj70oVcv
	8AmwcrJa9i9WL1oy/9R3fHMWf/Ctt9VXTO0qlCuq6PDzaUfvsXR61aJIjTKNQTOjCLjY1vXm
	VSewUgARysmA8WrjTfwGBihMBxAX0+kIjx8nOlam0WvekMBXZ0AbS56oTLRxYao6DI3GeB/N
	oWPy/5DfuTKaSdM0Pf8al20x9RuNN5/HLMlyDH/k8bIa1xd9aAqW+Feiw5gC107V2E6ULyIy
	q6em2UrsmIRxrvpHqbNgQKqvTehJ+V/i4g/uOwARAQABwsBfBBgBCAAJBQJWCsRYAhsMAAoJ
	EH7+/ev69L755XAH/3ZcNhooqd9OBhFkvXm1iWZ8EoC7motWqVn2oEyxoonsg8AD9kFXiN+T
	dYp7dH99EZu9q4ptj56AXm4uHzOgywL/5/V2TY6twCGAjUGzDjAB5gzoi+JLIBlDiyOip0eL
	QswIhRk473xy3j8DA4oVamnSPWgyNJ+qsdt37YWDzoDFFvtDoRU7Eb+znfIMDKzlny0XU/8L
	cW1bNHJlpv/78GPdfP4tjysEd8MuA5jf5o5w4XqcwTqalffEJtQ/s3pbkstEi7qm5uPui5Kt
	gq6YYLSqcSNe0GWAF9/T+qwyo7burSTxUWCWtMmlXdAQLW9SynLhB3Jbch0nFAh0fCKi6yY=
Organization: Wind River Systems
Message-ID: <cdb1b25d-9448-a43c-d345-7af3a5674a58@windriver.com>
Date: Thu, 12 Jul 2018 16:07:06 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
	Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180712203413.118578-1-mark.hatle@windriver.com>
Subject: Re: [PATCH 0/5] Add a standard module for accessing the layerindex
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
X-List-Received-Date: Thu, 12 Jul 2018 21:07:07 -0000
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 7/12/18 3:34 PM, Mark Hatle wrote:
> In order to simply existing components, and add support to create some
> new functionaly -- we need a common apporach for access the layerindex.
> 
> The class supports loading multilib layerindexes, but right now that
> functionality is not being used by either bitbake-layers or the toaster.
> 
> There are a few 'TODO' items that remain in the code.  These are related
> to either un-implemented, but planned functionality or to display stuff
> in bitbake-layers.  I'm hoping that part of this review can discuss the
> TODO items.

FYI 2/5 is a bit large, and is held up in list moderation.  I've posted all of
the patches to:

http://git.openembedded.org/bitbake-contrib/log/?h=mgh/bitbake-layerindex


The bitbake-layers layerindex-fetch display has changed.  For the example of:

$ bitbake-layers layerindex-fetch meta-python

Originally it would have produced:

Layer                Required by          Git repository
                 Subdirectory
===================================================================================================================
meta-python          -
git://git.openembedded.org/meta-openembedded            meta-python
meta-oe              meta-python
git://git.openembedded.org/meta-openembedded            meta-oe
openembedded-core    meta-python
git://git.openembedded.org/openembedded-core            meta
Adding layer "meta-python" (.../oe-core/meta-openembedded/meta-python) to
conf/bblayers.conf
Adding layer "meta-oe" (.../oe-core/meta-openembedded/meta-oe) to conf/bblayers.conf

With the new code, the output now looks like:

Layer                                              Git repository (branch)
                          Subdirectory
=============================================================================================================================
local:sumo:openembedded-core
git://github.com/openembedded/openembedded-core (master) meta
  required by: meta-python meta-oe
layers.openembedded.org:sumo:meta-oe
git://git.openembedded.org/meta-openembedded (sumo)     meta-oe
  required by: meta-python
layers.openembedded.org:sumo:meta-python
git://git.openembedded.org/meta-openembedded (sumo)     meta-python
Adding layer "meta-oe"
(/home/mhatle/git/oss/openembedded-core/meta-openembedded/meta-oe) to
conf/bblayers.conf
Adding layer "meta-python"
(/home/mhatle/git/oss/openembedded-core/meta-openembedded/meta-python) to
conf/bblayers.conf

You will see that the order changed... the requested layer(s) will not be last
instead of first.  And the requirements have been moved to the following line.
This was made to accommodate the 'layer' information changing.  The format there
is the '<index>:<index branch>:<layer>'

But as you can see the behavior is functionally equivalent, even though the
order has changed.

--Mark

> 
> Mark Hatle (5):
>   bblayers/layerindex.py: Fix addition of layers
>   layerindexlib: Initial layer index processing module implementation
>   bblayers/layerindex.py: Switch to use the new layerindexlib class
>   bitbake-layers: disable parsing for layerindex commands
>   toaster/orm/management/commands/lsupdates.py: Use new layerindexlib
>     module
> 
>  bin/bitbake-selftest                               |   6 +-
>  lib/bblayers/layerindex.py                         | 302 +++----
>  lib/layerindexlib/README                           |  28 +
>  lib/layerindexlib/__init__.py                      | 974 +++++++++++++++++++++
>  lib/layerindexlib/common.py                        | 161 ++++
>  lib/layerindexlib/cooker.py                        | 338 +++++++
>  lib/layerindexlib/restapi.py                       | 375 ++++++++
>  lib/layerindexlib/tests/__init__.py                |   0
>  lib/layerindexlib/tests/common.py                  |  37 +
>  lib/layerindexlib/tests/cooker.py                  | 125 +++
>  lib/layerindexlib/tests/layerindex.py              | 233 +++++
>  lib/layerindexlib/tests/restapi.py                 | 170 ++++
>  lib/layerindexlib/tests/testdata/README            |  11 +
>  .../tests/testdata/build/conf/bblayers.conf        |  15 +
>  .../tests/testdata/layer1/conf/layer.conf          |  17 +
>  .../tests/testdata/layer2/conf/layer.conf          |  20 +
>  .../tests/testdata/layer3/conf/layer.conf          |  19 +
>  .../tests/testdata/layer4/conf/layer.conf          |  22 +
>  lib/toaster/orm/management/commands/lsupdates.py   | 215 ++---
>  19 files changed, 2751 insertions(+), 317 deletions(-)
>  create mode 100644 lib/layerindexlib/README
>  create mode 100644 lib/layerindexlib/__init__.py
>  create mode 100644 lib/layerindexlib/common.py
>  create mode 100644 lib/layerindexlib/cooker.py
>  create mode 100644 lib/layerindexlib/restapi.py
>  create mode 100644 lib/layerindexlib/tests/__init__.py
>  create mode 100644 lib/layerindexlib/tests/common.py
>  create mode 100644 lib/layerindexlib/tests/cooker.py
>  create mode 100644 lib/layerindexlib/tests/layerindex.py
>  create mode 100644 lib/layerindexlib/tests/restapi.py
>  create mode 100644 lib/layerindexlib/tests/testdata/README
>  create mode 100644 lib/layerindexlib/tests/testdata/build/conf/bblayers.conf
>  create mode 100644 lib/layerindexlib/tests/testdata/layer1/conf/layer.conf
>  create mode 100644 lib/layerindexlib/tests/testdata/layer2/conf/layer.conf
>  create mode 100644 lib/layerindexlib/tests/testdata/layer3/conf/layer.conf
>  create mode 100644 lib/layerindexlib/tests/testdata/layer4/conf/layer.conf
> 


