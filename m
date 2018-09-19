Return-Path: <mark.hatle@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 2B95274551
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 19 Sep 2018 16:25:49 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id w8JGPocp029500
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Wed, 19 Sep 2018 09:25:50 -0700 (PDT)
Received: from soho-mhatle-m.local (172.25.36.227) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.408.0;
	Wed, 19 Sep 2018 09:25:49 -0700
To: bitbake-devel <bitbake-devel@lists.openembedded.org>, Matt Hoosier
	<matt.hoosier@gmail.com>
From: Mark Hatle <mark.hatle@windriver.com>
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
Message-ID: <63dcdf42-1ccc-1016-e540-807115c57f2d@windriver.com>
Date: Wed, 19 Sep 2018 11:25:49 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
	Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
Subject: Issues w/ gitsm fetcher and BB_NO_NETWORK
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
X-List-Received-Date: Wed, 19 Sep 2018 16:25:50 -0000
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit

I've been struggling for the past few days with gitsm, and have finally thrown
in the towel.

What is happening is that I am trying to use the 'ostree' recipe (not really
important), but that uses the gitsm fetcher against:

gitsm://github.com/ostreedev/ostree.git;branch=master

On a fetch the system correctly pulls down the 'ostree.git' from a local mirror
I have setup.  However, it then moves to the step of configuring the submodules
and fetching them, and goes out to the network and ALWAYS pulls them from the
network.

My mirror is setup using:

PREMIRRORS_append = " \
     gitsm://.*/.* gitsm://${LAYERDIR}/git/MIRRORNAME;protocol=file \n \
"

(my mirrors are simply local cloned bare repositories)

If I modify my /etc/hosts files to point github/gitlab to 127.0.0.1, I can
easily trigger the faults:

ERROR: ostree-2018.7+gitAUTOINC+4148918655-r0 do_unpack: Fetcher failure: Fetch
command export PSEUDO_DISABLED=1; ... git -c core.fsyncobjectfiles=0 submodule
update --init --recursive || (git -c core.fsyncobjectfiles=0 submodule sync
--recursive && git -c core.fsyncobjectfiles=0 submodule update --init
--recursive) failed with exit code 1, output:
Submodule 'bsdiff' (https://github.com/mendsley/bsdiff) registered for path 'bsdiff'
Submodule 'libglnx' (https://gitlab.gnome.org/GNOME/libglnx.git) registered for
path 'libglnx'
Cloning into 'bsdiff'...
Synchronizing submodule url for 'bsdiff'
Synchronizing submodule url for 'libglnx'
Cloning into 'bsdiff'...

fatal: unable to access 'https://github.com/mendsley/bsdiff/': Failed connect to
github.com:443; Connection refused
Clone of 'https://github.com/mendsley/bsdiff' into submodule path 'bsdiff' failed
fatal: unable to access 'https://github.com/mendsley/bsdiff/': Failed connect to
github.com:443; Connection refused
Clone of 'https://github.com/mendsley/bsdiff' into submodule path 'bsdiff' failed


I've tried a number of things, but so far I'm just not understanding how to
proceed.  I assume at some point the references to the modules really need to
refer to an alternative location and be fetched in, but I'm not sure that any of
the existing interfaces would allow that.

Any suggestions how to proceed?

--Mark

