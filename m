Return-Path: <mac@mcrowe.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78CBFC5AD49
	for <webhook@archiver.kernel.org>; Fri, 30 May 2025 17:17:49 +0000 (UTC)
Received: from smarthost01b.sbp.mail.zen.net.uk (smarthost01b.sbp.mail.zen.net.uk [212.23.1.3])
 by mx.groups.io with SMTP id smtpd.web11.886.1748625463254097980
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 30 May 2025 10:17:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@mcrowe.com header.s=20191005 header.b=OrLUDAno;
 spf=pass (domain: mcrowe.com, ip: 212.23.1.3, mailfrom: mac@mcrowe.com)
Received: from [88.97.37.36] (helo=deneb.mcrowe.com)
	by smarthost01b.sbp.mail.zen.net.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <mac@mcrowe.com>)
	id 1uL3MG-005Rba-Q9
	for bitbake-devel@lists.openembedded.org;
	Fri, 30 May 2025 17:17:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mcrowe.com;
	s=20191005; h=Content-Type:MIME-Version:Message-ID:Subject:To:From:Date:
	Sender:Reply-To:CC:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=oaE4mvVkyJpORmM1P1TMW4OaNd/NVuCrNnatCCOj+7Y=; b=Or
	LUDAnoJNNOBQDOHkYbluiULN69dNmM6ckyfggbBDeDoiBUqguFs7PULwNkVWsl9nGJI0TP0V7b7Zs
	l744/BJcbB7zkC3w2u4twERE4zW/JHw9VGpfU8xNU/PVecAlc3PsRu5bii/5LQ12xiKcCMd5cWAfi
	OF/nnZMwLOUo+trNZlS4CdP197FM7h9KtfCVSuEnjrJSpWTsyDsmqbRSl5K6FacoQ5V9vpukZogNZ
	6+SnxxyNOjfJaMTQX/falyqXCqEbOdXbn4+4J8Mv40vQRTFZ+VMukp8yJuuw+BOUjoBL1mbwgjlSH
	3ZuP4hqs4wcLeePR5AVI+3tST+pLixYg==;
Received: from mac by deneb.mcrowe.com with local (Exim 4.96)
	(envelope-from <mac@mcrowe.com>)
	id 1uL3MS-00Fo1p-1c
	for bitbake-devel@lists.openembedded.org;
	Fri, 30 May 2025 18:17:40 +0100
Date: Fri, 30 May 2025 18:17:40 +0100
From: Mike Crowe <mac@mcrowe.com>
To: bitbake-devel@lists.openembedded.org
Subject: Should stamp files for different versions of a recipe exist at the
 same time?
Message-ID: <aDnoNJFkC535qqiI@mcrowe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Originating-smarthost01b-IP: [88.97.37.36]
Feedback-ID: 88.97.37.36
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 30 May 2025 17:17:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17660

I seem to be running into a problem in Scarthgap that relates to outdated
stamp files not being removed. I think this results in tasks not running
when they should in later builds. I don't believe that this problem happens
with Dunfell[1], though it does still happen with current master (both
Bitbake and openembedded-core) too[2].

In case my description below isn't clear, the files required are available
in
https://github.com/mikecrowe/openembedded-core/tree/stamps-not-removed-repro
though
https://github.com/mikecrowe/openembedded-core/commit/8fd8055ab3e1d2d429c6076481952bace251750c
is probably the most interesting to look at.

My reproduction requires a package to have two different recipes with
different COMPATIBLE_MACHINEs and swapping between building for those two
different MACHINEs. I'm using dummy recipes called lictest_one.bb and
lictest_two.bb because I'm able to reproduce this problem with licence
files, though I suspect that it is not limited to them. I have two machines
named qemuarm64 and qemuarm64b.

# PREPARATION

I first start by running the cleansstate task for the recipe for both
MACHINEs in order to ensure we're starting from a sensible state:

 MACHINE=qemuarm64 bitbake -c cleansstate lictest
 MACHINE=qemuarm64b bitbake -c cleansstate lictest

# FIRST MACHINE BUILD 1

I build for the first machine:

 MACHINE=qemuarm64 bitbake core-image-minimal

At this point tmp-glibc/deploy/licenses/cortexa57/lictest contains the
licence files and tmp-glibc/stamps/cortexa57-oe-linux/lictest/ contains
stamp files only from lictest_one.bb as expected.

# SECOND MACHINE BUILD 1

I build for the second machine:

 MACHINE=qemuarm64b bitbake lictest

At this point tmp-glibc/deploy/licenses/cortexa57/lictest contains the
licence files from lictest_two.bb as expected.
tmp-glibc/stamps/cortexa57-oe-linux/lictest/ contains stamp files from both
recipes. This is unexpected to me as I would have expected the stamps from
lictest_one.bb to be removed due to them being unreachable.

# FIRST MACHINE BUILD 2

I go back to build for the first machine again with some debug output:

 MACHINE=qemuarm64 bitbake -DDD lictest

In that debug output I found:

 DEBUG: Stampfile /fast/mac/git/oe-core/build/tmp-glibc/stamps/cortexa57-oe-linux/lictest/1.do_populate_lic_setscene.eba2f40dbe8904031c070aeff35abee46485bfa827e27731e02e8c5a84ef3a46 not available
 DEBUG: Normal stamp current for task /fast/mac/git/oe-core/meta/recipes-core/lictest/lictest_one.bb:do_populate_lic
 DEBUG: Found task /fast/mac/git/oe-core/meta/recipes-core/lictest/lictest_one.bb:do_populate_lic which could be accelerated
 DEBUG: /fast/mac/git/oe-core/meta/recipes-core/lictest/lictest_one.bb:do_populate_lic has a valid stamp, skipping
/fast/mac/git/oe-core/meta/recipes-core/lictest/lictest_one.bb:do_populate_lic
 DEBUG: Marking task /fast/mac/git/oe-core/meta/recipes-core/lictest/lictest_one.bb:do_populate_lic as buildable
 DEBUG: Setscene covered task /fast/mac/git/oe-core/meta/recipes-core/lictest/lictest_one.bb:do_populate_lic

and tmp-glibc/deploy/licenses/cortexa57/lictest is either empty or it
contains the licence files from lictest_two! The stamps from lictest_two.bb
have been removed from tmp-glibc/stamps/cortexa57-oe-linux/lictest/, but
the ones from lictest_one.bb remain.

My guess is that the problem here is that the stamps from the first machine
build weren't removed during the "SECOND MACHINE BUILD 1" step above. If I
remove them myself then the problem goes away. Is that theory correct? If
so, then I can start trying to work out why and any advice would be
welcome. If that theory is not correct then does anyone have any idea where
I should start investigating?

Thanks.

Mike.

[1] But with the fix for
https://bugzilla.yoctoproject.org/show_bug.cgi?id=14123 cherry-picked.

[2] If the reproduction script is tweaked to replace tmp-glibc with tmp.

