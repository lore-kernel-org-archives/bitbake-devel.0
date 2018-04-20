Return-Path: <mauro@faresoftware.it>
X-Greylist: delayed 449 seconds by postgrey-1.34 at layers.openembedded.org;
	Fri, 20 Apr 2018 09:50:32 UTC
Received: from smtpcmd01217.aruba.it (smtpcmd01217.aruba.it [62.149.158.217])
	by mail.openembedded.org (Postfix) with ESMTP id C11C7605BF
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 20 Apr 2018 09:50:31 +0000 (UTC)
Received: from [10.0.3.130] ([78.6.3.122])
	by smtpcmd01.ad.aruba.it with bizsmtp
	id cZiz1x0102dwwGE01Zj0fT; Fri, 20 Apr 2018 11:43:01 +0200
To: bitbake-devel@lists.openembedded.org
From: Mauro Ziliani <mauro@faresoftware.it>
Message-ID: <490261f1-ed2d-286c-a75d-6798008cef2c@faresoftware.it>
Date: Fri, 20 Apr 2018 11:42:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.7.0
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aruba.it; s=a1;
	t=1524217381; bh=+a5RteuqfITUg7GfoEiYrZBLQbqt57S4pIONv4aj170=;
	h=To:From:Subject:Date:MIME-Version:Content-Type;
	b=UNZcwjNPKnVgrdywKQK5OKekX6mYiwVjuiBCHI9JxRfLkftUlb+cqrkEI2um1HpFP
	2DRDinWJrPBSqis36ughvFNc+lAFOx9asztpQd2u0pU82oxY1xd3yDkuf8X+xF7pDC
	HkxoW8tnLiIXQoZBJd4yVQeHX6ENOjnMFicMzWKyNo8USdZIQ3pAwkNl1hRap8sp9o
	BmQYW8moXj3Q8wbGKKuNUvyR4+D+u/tPPpy7HWqVcRi/ayR7uo47ubo18hNp3WDPk3
	05ocbA8yHFIPtImH8cR3PgzpwzhjelOL6/A5hr8Lm4hmqOUyfv+NworH8ydeWOfSBN
	AMLrr2sHb0ptg==
Subject: PREFERRED_VERSION_db-native doesn't work?
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
X-List-Received-Date: Fri, 20 Apr 2018 09:50:35 -0000
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: it

Hi all

I'm Mauro from Parma, Italy.

I hope this is not OT from this mailing-list.


I'm working with Krogoth 15.0.3.

When I bitbake core-image-minimal bitbake fails compiling db-native 
recipe because it can't apply a patch

This is the error.

ERROR: db-native-6.0.30-r0 do_patch: Command Error: 'quilt --quiltrc 
/media/mauro/Sviluppo/CatellaniGroup/ibr115/bsp/clini5-build/tmp/sysroots/x86_64-linux/etc/quiltrc 
push' exited with 1  Output:
Applying patch fix-parallel-build.patch
patching file Makefile.in
Hunk #1 FAILED at 1034.
1 out of 1 hunk FAILED -- rejects in file Makefile.in
Patch fix-parallel-build.patch can be reverse-applied

So I try to compile against db-native_5.3.28 setting 
PREFERRED_VERSION_db-native = "5.%" in my conf/local.conf.


But bitbake keep on running db-native_6.0.30-r0 recipe.


Why?


Best regards,

    Mauro


