Return-Path: <stefan@agner.ch>
X-Greylist: delayed 549 seconds by postgrey-1.34 at layers.openembedded.org;
	Wed, 09 Jan 2019 13:57:17 UTC
Received: from mail.kmu-office.ch (mail.kmu-office.ch [178.209.48.109])
	by mail.openembedded.org (Postfix) with ESMTP id A9AED7BDD4
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  9 Jan 2019 13:57:17 +0000 (UTC)
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
	by mail.kmu-office.ch (Postfix) with ESMTPSA id A96355C0170;
	Wed,  9 Jan 2019 14:48:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
	t=1547041688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	content-transfer-encoding:content-transfer-encoding:in-reply-to:
	references; bh=nScu+/XjdJt/QgutgwsaejtVp4Amfo/TY15vSPLQs4Q=;
	b=HtTsuaYILE9wYPL9hSHrSSC3AuOXjAJm4TRwIIrKI/z8VzaKTV70qYVYGreQXMGJWYljg7
	VC3oAQfCkAeieQ5d90WUTel6Q63tmfnauha5QWq0z2UcNMR7GJYFfqihugWgPDxeKuDi3k
	cyU3Qia5wy56GFOoP19G1d/s2S047bA=
MIME-Version: 1.0
Date: Wed, 09 Jan 2019 14:48:08 +0100
From: Stefan Agner <stefan@agner.ch>
To: bitbake-devel@lists.openembedded.org
Message-ID: <4e90ed7e8eea81f3f8e3abd072aedaca@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.7
Subject: gitsm shared DL_DIR and race conditions
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
X-List-Received-Date: Wed, 09 Jan 2019 13:57:17 -0000
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

We came across race conditions while fetching a repository using gitsm:
ERROR: aktualizr-native-1.0+gitAUTOINC+d00d1a04cc-7 do_fetch: Fetcher
failure: Fetch command export PSEUDO_DISABLED=1; export
PATH="/workdir/oe/layers/openembedded-core/scripts/native-intercept:/workdir/oe/layers/openembedded-core/scripts:/workdir/oe/tmp/work/x86_64-linux/aktualizr-native/1.0+gitAUTOINC+d00d1a04cc-7/recipe-sysroot-native/usr/bin/x86_64-linux:/workdir/oe/tmp/work/x86_64-linux/aktualizr-native/1.0+gitAUTOINC+d00d1a04cc-7/recipe-sysroot-native/usr/bin:/workdir/oe/tmp/work/x86_64-linux/aktualizr-native/1.0+gitAUTOINC+d00d1a04cc-7/recipe-sysroot-native/usr/sbin:/workdir/oe/tmp/work/x86_64-linux/aktualizr-native/1.0+gitAUTOINC+d00d1a04cc-7/recipe-sysroot-native/usr/bin:/workdir/oe/tmp/work/x86_64-linux/aktualizr-native/1.0+gitAUTOINC+d00d1a04cc-7/recipe-sysroot-native/sbin:/workdir/oe/tmp/work/x86_64-linux/aktualizr-native/1.0+gitAUTOINC+d00d1a04cc-7/recipe-sysroot-native/bin:/workdir/oe/bitbake/bin:/workdir/oe/tmp/hosttools";
export HOME="/home/yocto"; git -c core.fsyncobjectfiles=0 config
submodule.tests/tuf-test-vectors.url
/workdir/downloads/git2/github.com.advancedtelematic.tuf-test-vectors.
failed with exit code 255, output:
error: could not lock config file config: File exists

We share the same DL_DIR located on a NFS across multiple builders. We
are using latest state of the 1.40 branch  (thud) of bitbake.

It seems that two git config invocations raced in this case. Is there
locking required in the current gitsm implementation?

--
Stefan

