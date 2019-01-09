Return-Path: <stefan@agner.ch>
Received: from mail.kmu-office.ch (mail.kmu-office.ch [178.209.48.109])
	by mail.openembedded.org (Postfix) with ESMTP id 46E886D99D
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  9 Jan 2019 16:21:08 +0000 (UTC)
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
	by mail.kmu-office.ch (Postfix) with ESMTPSA id 367BE5C1788;
	Wed,  9 Jan 2019 17:21:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
	t=1547050868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	content-transfer-encoding:content-transfer-encoding:
	in-reply-to:in-reply-to:references:references;
	bh=yLayG7K4b5S5xrHpC8i2x96VXU9sz8ZJ1MRtc/xes2g=;
	b=QRbZRXu3VfT8Qa7gCHEKxMYV7WYFiqkvDJRjLWqOi8UxuWvNy8Xw4VBN9N+qwjnwfU/kOe
	9p7GT4df+/eSg5i1McZBKsXQd1JOUXMd+2JrFgKaNOcccPyy3jRXSfltRnXD41vin26Pl/
	XR0Rb8ymANPEtCt08JSI5dJ+t0EvF0g=
MIME-Version: 1.0
Date: Wed, 09 Jan 2019 17:21:08 +0100
From: Stefan Agner <stefan@agner.ch>
To: Mark Hatle <mark.hatle@windriver.com>
In-Reply-To: <410903eb-7a0a-964c-9b3a-991a342284ec@windriver.com>
References: <4e90ed7e8eea81f3f8e3abd072aedaca@agner.ch>
	<410903eb-7a0a-964c-9b3a-991a342284ec@windriver.com>
Message-ID: <3585261e3fbb59fbacffbc7339a6f30a@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.7
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: gitsm shared DL_DIR and race conditions
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
X-List-Received-Date: Wed, 09 Jan 2019 16:21:08 -0000
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On 09.01.2019 16:38, Mark Hatle wrote:
> On 1/9/19 7:48 AM, Stefan Agner wrote:
>> Hi,
>>
>> We came across race conditions while fetching a repository using gitsm:
>> ERROR: aktualizr-native-1.0+gitAUTOINC+d00d1a04cc-7 do_fetch: Fetcher
>> failure: Fetch command export PSEUDO_DISABLED=1; export
>> PATH="/workdir/oe/layers/openembedded-core/scripts/native-intercept:/workdir/oe/layers/openembedded-core/scripts:/workdir/oe/tmp/work/x86_64-linux/aktualizr-native/1.0+gitAUTOINC+d00d1a04cc-7/recipe-sysroot-native/usr/bin/x86_64-linux:/workdir/oe/tmp/work/x86_64-linux/aktualizr-native/1.0+gitAUTOINC+d00d1a04cc-7/recipe-sysroot-native/usr/bin:/workdir/oe/tmp/work/x86_64-linux/aktualizr-native/1.0+gitAUTOINC+d00d1a04cc-7/recipe-sysroot-native/usr/sbin:/workdir/oe/tmp/work/x86_64-linux/aktualizr-native/1.0+gitAUTOINC+d00d1a04cc-7/recipe-sysroot-native/usr/bin:/workdir/oe/tmp/work/x86_64-linux/aktualizr-native/1.0+gitAUTOINC+d00d1a04cc-7/recipe-sysroot-native/sbin:/workdir/oe/tmp/work/x86_64-linux/aktualizr-native/1.0+gitAUTOINC+d00d1a04cc-7/recipe-sysroot-native/bin:/workdir/oe/bitbake/bin:/workdir/oe/tmp/hosttools";
>> export HOME="/home/yocto"; git -c core.fsyncobjectfiles=0 config
>> submodule.tests/tuf-test-vectors.url
>> /workdir/downloads/git2/github.com.advancedtelematic.tuf-test-vectors.
>> failed with exit code 255, output:
>> error: could not lock config file config: File exists
>>
>> We share the same DL_DIR located on a NFS across multiple builders. We
>> are using latest state of the 1.40 branch  (thud) of bitbake.
>>
>> It seems that two git config invocations raced in this case. Is there
>> locking required in the current gitsm implementation?
> 
> Did not expect git config to have locking issue... but it is showing that two
> fetches appear to have happened together... gitsm uses the regular git fetcher
> for that bit, and then after the fetch is complete updates the config (like git
> submodule init would) to point to downloaded components.  It's this
> configuration step that appears to have failed.
> 
> It should be fairly trivial to catch this issue and retry.

It does not happen often. It happened only once in the last ~100 builds
or so...

Since this is in the CI environment I need to check whether I can jump
into that environment.

As far as I can see git holds a lock to write its config file:
https://github.com/git/git/blob/master/config.c#L2715

Shouldn't we use a blocking lock on bitbake level to avoid running into
the git lock and erroring out?

--
Stefan

