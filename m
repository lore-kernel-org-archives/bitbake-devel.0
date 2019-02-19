Return-Path: <mark.hatle@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id 55E2A6C498
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Feb 2019 17:06:31 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x1JH5Ekw002684
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Tue, 19 Feb 2019 09:05:49 -0800
Received: from soho-mhatle-m.local (172.25.36.232) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.435.0;
	Tue, 19 Feb 2019 09:05:22 -0800
To: Krzysztof Zawadzki <mr.k.zawadzki@gmail.com>, Richard Purdie
	<richard.purdie@linuxfoundation.org>
References: <20190215032539.5297-1-mr.k.zawadzki@gmail.com>
	<7dd4a96220566dc8d9a1db6a6430aba8bed8b596.camel@linuxfoundation.org>
	<CAKdBavFaHM8xBNz0-HNydrqRtYPcCET6uhbQhFUKm78UjMcQAw@mail.gmail.com>
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
Message-ID: <14d1f53d-d003-ea6d-5d29-6b5699f4280b@windriver.com>
Date: Tue, 19 Feb 2019 11:05:21 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
	Gecko/20100101 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <CAKdBavFaHM8xBNz0-HNydrqRtYPcCET6uhbQhFUKm78UjMcQAw@mail.gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] fetch2/svn: adds svn --ignore-externals option
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
X-List-Received-Date: Tue, 19 Feb 2019 17:06:31 -0000
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit

I had a customer ask about this type of issue a few days ago as well.  I don't
know enough about SVN to comment directly on what should be default or not, just
that there is some type of an issue here, especially around svn:externals
pointing to bad external repositories and the need to pass --ignore-externals
for certain things.

On 2/16/19 1:36 AM, Krzysztof Zawadzki wrote:
> Hi,
> 
> I think so also. Subversion client is poor in exit statues when there are issues
> during svn:externals fetching. I have seen such issues previously. And it took a
> while to find there root cause (e.g switching revisions of svn:externals to non
> existing paths or revisions and some conflicts showed up).
> 
> @Richard Purdie
> It's better to create new patch which will add this option by default, with
> additional Docs update? Or update this one?

Do you have enough information to help create a reproducer case for this, so we
can add some additional fetcher test cases?

I know I needed to add a bunch of regression tests around the git submodule
fetcher to have any chance of preventing future regressions.

I suspect this may be a similar situation, we need more test cases.

--Mark

> Best Regards,
> Krzysztof Z.
> 
> sob., 16 lut 2019 o 00:00 Richard Purdie <richard.purdie@linuxfoundation.org
> <mailto:richard.purdie@linuxfoundation.org>> napisał(a):
> 
>     On Fri, 2019-02-15 at 04:25 +0100, Krzysztof Zawadzki wrote:
>     > With this option we can force users to provide all used sources in
>     > recipe.
>     > Without this there is possibility that repositories which are using
>     > svn:externals
>     >  can point to source code from HEAD or to nonexisting repository.
>     > This can cause attempt to reproduce build after some time impossible.
>     >
>     > Signed-off-by: Krzysztof Zawadzki <mr.k.zawadzki@gmail.com
>     <mailto:mr.k.zawadzki@gmail.com>>
>     > ---
>     >  lib/bb/fetch2/svn.py | 9 ++++++++-
>     >  1 file changed, 8 insertions(+), 1 deletion(-)
> 
>     I'm wondering if this should be the default and is something people
>     have to explicitly opt out of?
> 
>     Cheers,
> 
>     Richard
> 
> 


