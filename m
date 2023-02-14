Return-Path: <paulo@myneves.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C3AC6379F
	for <webhook@archiver.kernel.org>; Tue, 14 Feb 2023 11:27:04 +0000 (UTC)
Received: from mail-40136.proton.ch (mail-40136.proton.ch [185.70.40.136])
 by mx.groups.io with SMTP id smtpd.web11.4393.1676374014264469453
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 14 Feb 2023 03:26:55 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@myneves.com header.s=protonmail header.b=PKp8KqAY;
 spf=pass (domain: myneves.com, ip: 185.70.40.136, mailfrom: paulo@myneves.com)
Date: Tue, 14 Feb 2023 11:26:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=myneves.com;
	s=protonmail; t=1676374011; x=1676633211;
	bh=+Mx1iasxbhY9ZAqqUWdsvZ5pNsEMZoY89sHUauNzlZs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=PKp8KqAYBx9HFzslTBu5irSJE56JyL8XXIj/X3wJUYqcxWODUzI/CgpymdJbXk9F9
	 B0v5YlkVnpe6RLYYUd/asQ2qppvqhT4C/oVxuPaWvgioGaZIlJmeSUQer+M7TBbzYT
	 RrB4cnPpkB7CT1Vfij1mSTukWAGsv5uREvs56AuuKKApVQPcwj86p6ZthZ40Bv6grz
	 c69PHd1ytS1N2agKlV7KnqdYehLH4vZHxPQsSH1ryWLrNIXjAVp0tlY0fTishcWQMN
	 Uo0PJl5cTyeyM0bOSfd2eFeZP4S1rVoDHhnU5nTCb7FrOZfytIHmHwK7F08v5T0fJc
	 3bD0ovz0WEdwQ==
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
From: Paulo Neves <paulo@myneves.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH 2/3] tests: Make test_lfs_enabled actually test git-lfs
Message-ID: <ffb818e5-9dd4-68fd-1e4e-92f347f3d94e@myneves.com>
In-Reply-To: <Y+rJtR+pXaUUSSjK@mail.local>
References: <20230210133921.1268885-1-paulo@myneves.com> <20230210133921.1268885-2-paulo@myneves.com> <Y+rJtR+pXaUUSSjK@mail.local>
Feedback-ID: 59941854:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 14 Feb 2023 11:27:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14407

This means that the test cannot run in the autobuilder and should
probably be removed or re-done.

My whole patchset needs to be re-done as well. The reason is that the
current git-lfs support in bitbake has very confusing behavior and very
host configuration dependent. This patch highlights that, as before it
we were supposedly testing git-lfs without git-lfs on the host. I am of
the opinion we should not do that.

There is no documentation anywhere on the behavior of the lfs parameter.
My current understanding is the following:

What the lfs=3D0/1 parameter does is to force the filter to run on the
DL_DIR's bare repository by doing a checkout to a temporary directory.
If lfs is unset, bitbake will still checkout lfs contents but will do it
during the unpack method which usually happens in the WORKDIR. git does
this transparently on git checkout. This is not ideal as it means that
there can be network access during the do_unpack task. This situation is
only (possibly) avoided if the user sets lfs=3D1. Otherwise, the user will
have network access on the do_unpack task.

Expect a V2

Paulo Neves

On 2/14/23 00:37, Alexandre Belloni wrote:
> Hello,
>
> This fails on the AB with:
>
> FAIL: test_lfs_enabled (bb.tests.fetch.GitLfsTest)
> ----------------------------------------------------------------------
> Traceback (most recent call last):
>    File "/home/pokybuild/yocto-worker/oe-selftest-armhost/build/bitbake/l=
ib/bb/tests/fetch.py", line 2246, in test_lfs_enabled
>      self.assertTrue(ud.method._find_git_lfs(self.d),
> AssertionError: False is not true : git-lfs not found. Cannot test git-lf=
s without git-lfs in the PATH
>
>
> On 10/02/2023 13:39:32+0000, Paulo Neves wrote:
>> Due to the datastore not having the PATH variable set, _find_git_lfs
>> would never return true and thus fetcher's git lfs test logic was
>> unreachable.
>>
>> Now we set PATH on the datastore of the test and if the test host has
>> git-lfs the test will actually test git-lfs logic.
>>
>> Signed-off-by: Paulo Neves <paulo@myneves.com>
>> ---
>>   lib/bb/tests/fetch.py | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
>> index 122d7e05f..a9ad247d9 100644
>> --- a/lib/bb/tests/fetch.py
>> +++ b/lib/bb/tests/fetch.py
>> @@ -2237,6 +2237,7 @@ class GitLfsTest(FetcherTest):
>>
>>           uri =3D 'git://%s;protocol=3Dfile;branch=3Dmaster' % self.srcd=
ir
>>           self.d.setVar('SRC_URI', uri)
>> +        self.d.setVar('PATH', os.environ.get('PATH'))
>>
>>           # Careful: suppress initial attempt at downloading until
>>           # we know whether git-lfs is installed.
>> --
>> 2.34.1
>>
>>
>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>> Links: You receive all messages sent to this group.
>> View/Reply Online (#14392): https://lists.openembedded.org/g/bitbake-dev=
el/message/14392
>> Mute This Topic: https://lists.openembedded.org/mt/96875983/3617179
>> Group Owner: bitbake-devel+owner@lists.openembedded.org
>> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alexa=
ndre.belloni@bootlin.com]
>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>>
>
> --
> Alexandre Belloni, co-owner and COO, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com



