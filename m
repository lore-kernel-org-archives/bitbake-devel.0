Return-Path: <mac@mcrowe.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D33C61CE8
	for <webhook@archiver.kernel.org>; Mon,  9 Jun 2025 14:45:27 +0000 (UTC)
Received: from smarthost01c.ixn.mail.zen.net.uk (smarthost01c.ixn.mail.zen.net.uk [212.23.1.22])
 by mx.groups.io with SMTP id smtpd.web11.61047.1749480323356024262
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 09 Jun 2025 07:45:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@mcrowe.com header.s=20191005 header.b=SqCXRu4z;
 spf=pass (domain: mcrowe.com, ip: 212.23.1.22, mailfrom: mac@mcrowe.com)
Received: from [88.97.37.36] (helo=deneb.mcrowe.com)
	by smarthost01c.ixn.mail.zen.net.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <mac@mcrowe.com>)
	id 1uOdkX-00Ed5X-H3;
	Mon, 09 Jun 2025 14:45:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mcrowe.com;
	s=20191005; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description; bh=UIytCArK1mV59JOp2a3Xmn9SkdN41KHGCkKkwzyFhck=; b=SqCXR
	u4z3TPzuoYnp7fMGkVWMEp9mv4rO6NorieijbWTmpmo4PCt/53WkO4G0YiRcNZaKlptB6v2+AVnZh
	Uqa1X7SV8twKXFbQEdVByHo2M4f4ZmmstcizTX7Q8B9XLpcbCJylsrqdFGxMa0Hc6CBq1hoOTkbF7
	gDGntdaXEAdTSnLJg+0gtmEmAsUtqdiq+XaeU7uDD/eQLdqs2QIJpJDbyv0J0vagiss+7LbNlpheH
	ZkK13bsv1vdoux1NyfWu6KWdHrh5XdoPdv7a2LNR+fhP9326WX4pkNFOgCjqvO/NaRjaa4+Q4n+a/
	Vu2VTaJL6QxGVsko+2stBJqNBe5Wg==;
Received: from mac by deneb.mcrowe.com with local (Exim 4.96)
	(envelope-from <mac@mcrowe.com>)
	id 1uOdkX-008xBy-11;
	Mon, 09 Jun 2025 15:45:21 +0100
Date: Mon, 9 Jun 2025 15:45:21 +0100
From: Mike Crowe <mac@mcrowe.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] Should stamp files for different versions of a
 recipe exist at the same time?
Message-ID: <aEbzgV0vynTD8ukH@mcrowe.com>
References: <aDnoNJFkC535qqiI@mcrowe.com>
 <18dd4e56-87a5-4de3-a148-bd42f67ba57a@cherry.de>
 <aD2ByO73juj7zy7I@mcrowe.com>
 <418eea7bdcd9b528623498a6139ae42389ef192d.camel@linuxfoundation.org>
 <aD3TP6hIE9vvFaAo@mcrowe.com>
 <a9296bd359abc522a135cbaa37995d5b5633046e.camel@linuxfoundation.org>
 <aEXier1YxgCzOv1F@mcrowe.com>
 <518ee0f0eef4e155c93ccba344a5ea1e6102b37b.camel@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <518ee0f0eef4e155c93ccba344a5ea1e6102b37b.camel@linuxfoundation.org>
X-Originating-smarthost01c-IP: [88.97.37.36]
Feedback-ID: 88.97.37.36
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 09 Jun 2025 14:45:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17692

On Sunday 08 June 2025 at 22:35:40 +0100, Richard Purdie wrote:
> On Sun, 2025-06-08 at 20:20 +0100, Mike Crowe wrote:
> > [
> > �Snip explanation of building first for MACHINE1, then MACHINE2, then back
> > �to MACHINE1 again with the same PACKAGE_ARCH and relying only on the task
> > �hashes being different to ensure that the right files end up being used.
> > ]
> > 
> > On 5/30/25 7:17 PM, Mike Crowe via lists.openembedded.org wrote:
> > > > > > > My guess is that the problem here is that the stamps from the first
> > > > > > > machine build weren't removed during the "SECOND MACHINE BUILD 1" step
> > > > > > > above. If I remove them myself then the problem goes away. Is that
> > > > > > > theory correct? If so, then I can start trying to work out why and any
> > > > > > > advice would be welcome. If that theory is not correct then does anyone
> > > > > > > have any idea where I should start investigating?
> > 
> > On Mon, 2025-06-02 at 17:37 +0100, Mike Crowe wrote:
> > > > I was hoping that someone would just know the answer to my first question
> > > > above off the top of their head. If so then I'm willing to try digging into
> > > > this myself to see what I can discover. I just need to make sure that I'm
> > > > chasing the right part of the problem.
> > 
> > On Monday 02 June 2025 at 22:04:39 +0100, Richard Purdie wrote:
> > > I've avoided answering this as I think you're right but I'm not 100%
> > > sure and I don't want to send you off in the wrong direction. There are
> > > reasons it might not wipe out stamps and those reasons may be
> > > intentional but without looking at what is going on I couldn't be
> > > completely sure. So I think you're right and I'd chase that way but...
> > 
> > It turns out that you were right to be hesitant.
> > 
> > Stamps are only removed if they were generated by the current MACHINE due
> > to oe-core#5634f2fb1740732056d2c1a22717184ef94405bf from 2018:
> > 
> > > sstate: Ensure a given machine only removes things which it created
> > > 
> > > Currently if you build qemux86 and then generic86, the latter will
> > > remove all of the former from deploy and workdir. This is because
> > > qemux86 is i586, genericx86 is i686 and the architctures are compatible
> > > therefore the sstate 'cleaup' code kicks in.
> > > 
> > > There was a valid reason for this to ensure i586 packages didn't get into
> > > an i686 rootfs for example. With the rootfs creation being filtered now, this
> > > is no longer necessary.
> > > 
> > > Instead, save out a list of stamps which a give machine has ever seen in
> > > a given build and only clean up these things if they're no longer
> > > "reachable".
> > > 
> > > In particular this means the autobuilder should no longer spend a load of time
> > > deleting files when switching MACHINE, improving build times.
> 
> Well, that makes sense and I think that change still makes sense. It
> does raise the question of whether/how we could detect your scenario
> and give better information to the user (and/or error?).
> 
> > I'm not sure if the situation the change describes can still occur.
> > genericx86 (which is presumably what was meant by generic86) no longer
> > seems to exist and TUNE_PKGARCH should be either i586 and i686, so the
> > stamps and work directories won't overlap with each other.
> 
> genericx86 definitely still exists:
> 
> https://git.yoctoproject.org/poky/tree/meta-yocto-bsp/conf/machine/genericx86.conf
> 
> however it is now core2-32.

Ah, I was only looking in oe-core. :(

> That doesn't mean the architecture issue can't exist but the default
> tunes have changed. genericx86 and qemux86 still probably share
> architecture compatibility and one would try and remove the other.

AFAICS both set DEFAULTTUNE ?= "core2-32", so they both have the same
PACKAGE_ARCH = "core2-32". This means that they ought to be identical and
there should be no stamps that need to be removed.

I think that the only time that change has any effect is if a recipe has a
single PACKAGE_ARCH but has different hashes for different MACHINEs. That's
exactly the situation that we think is bad and ought to be reported rather
than supported. But, I must be wrong. Perhaps I'm wrong because stamps for
compatible SSTATE_ARCHs would be removed without this fix too?

This part probably doesn't matter though if we're aiming to just detect
this situation.

> > This commit was also in Dunfell though, so the next question is why doesn't
> > Dunfell suffer from the same problem? The answer surprised me: Dunfell
> > appears to have been looking for mismatched stamp file names (for me at
> > least).
> > 
> > In Dunfell, the build for MACHINE1 creates a stamp named:
> > 
> > �1-r0.do_populate_lic.sigdata.14708a9f021d264f7c0a9c5c33a93417c6cb20ba936c5805ff96083a9cb05ee9
> 
> "sigdata" files are information only files and not actual stamps. This
> file contains stamp information but is not the actual stamp itself.
> 
> There are two possible versions of the stamp, either setscene or non-
> setscene. On my local build, for linux-libc-headers I see:
> 
> ./core2-64-poky-linux-musl/linux-libc-headers/6.12.do_populate_lic.73e166a4f76ae90f2785472dac9e88264c920aaf98ac2b43b71e0e4b9bec8469
> ./core2-64-poky-linux-musl/linux-libc-headers/6.12.do_populate_lic.sigdata.73e166a4f76ae90f2785472dac9e88264c920aaf98ac2b43b71e0e4b9bec8469
> 
> but I could also see:
> 
> ./core2-64-poky-linux-musl/linux-libc-headers/6.12.do_populate_lic_setscene.73e166a4f76ae90f2785472dac9e88264c920aaf98ac2b43b71e0e4b9bec8469
> 
> The sigdata file provides information on the 73e166a4f7 stamp hash.
> Stamps will have zero file size.

Understood. I have no zero-sized do_populate_lic stamp files for the recipe
in my tmp-glibc/stamps directory on Dunfell. This could be a
consequence of us backporting the fix for
https://bugzilla.yoctoproject.org/show_bug.cgi?id=14123 without some other
necessary prerequisite changes.

Anyway, I think I've got far enough to determine that the fact that this
problem didn't occur for us in Dunfell is a distraction so I won't pursue
that line of investigation any further and will try to work out how to
detect recipes that change task hashes between MACHINEs for the same
PACKAGE_ARCH instead.

It would be straightforward to look for other stamp files with different
hashes in the TUNE_PKGARCH directory, but that situation could arise
completely legitimately when recipes are being changed but haven't yet been
built for all MACHINEs. Attempting to process the stamp files after
building for all MACHINEs would only work from a clean TMPDIR for a similar
reason.

Instead I hacked together a Python script that reads the locked-sigs.inc
files, that are already conveniently arranged by PACKAGE_ARCH. It seems to
detect problematic recipes for me. At the very least it might help work out
whether this problem is common enough that more work would be worthwhile.

Thanks for all your advice.

Mike.

From 2662100c2d25ccc42ce9a6eafd46b36b0b87b176 Mon Sep 17 00:00:00 2001
From: Mike Crowe <mac@mcrowe.com>
Date: Mon, 9 Jun 2025 15:29:30 +0100
Subject: [PATCH] scripts/contrib: Add check-recipe-pkgarchs script

This script looks for recipes that modify their behaviour (usually,
though not necessarily for different MACHINEs) but don't use a unique
PACKAGE_ARCH when they do. This can lead to Bitbake thinking that tasks
don't need to be run when they should be.
---
 scripts/contrib/check-recipe-pkgarchs | 85 +++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)
 create mode 100755 scripts/contrib/check-recipe-pkgarchs

diff --git a/scripts/contrib/check-recipe-pkgarchs b/scripts/contrib/check-recipe-pkgarchs
new file mode 100755
index 0000000000..c232a69739
--- /dev/null
+++ b/scripts/contrib/check-recipe-pkgarchs
@@ -0,0 +1,85 @@
+#!/usr/bin/env python3
+#
+# Read a number of locked-sigs.inc files passed on the command line
+# looking for tasks for a given PACKAGE_ARCH that have distinct
+# hashes. This indicates that the recipes probably ought to be using
+# PACKAGE_ARCH = "${MACHINE_ARCH}" or otherwise ensuring that
+# PACKAGE_ARCH changes when any of their task hashes change.
+#
+# The output format is:
+#
+# pkgarch:recipe:task
+#   machines-with-hash-1...
+#   machines-with-hash-2...
+#   ...
+#
+# Example output:
+#
+# cortexa57:lictest:do_compile
+#   qemuarm64
+#   qemuarm64b qemuarm64c
+#
+# If each machine is on a line on its own then PACKAGE_ARCH =
+# "${MACHINE_ARCH}" is most likely to be the solution. If lines show
+# multiple machines then that would work, but it's possible that
+# another PACKAGE_ARCH might be more efficient.
+#
+# If no problems are found then there is no output and the script will
+# exit successfully. A non-zero exit status indicates that problems
+# were found.
+#
+# Usage:
+#
+# For each MACHINE run:
+#   bitbake -S lockedsigs target && mv locked-sigs.inc locked-sigs.${MACHINE}
+#
+# then:
+#   check-recipe-pkgarchs locked-sigs.*
+#
+import re, sys
+
+def parse_arch_package_tasks(file_path):
+    result = {}
+    with open(file_path, 'r') as file:
+        content = file.read()
+
+    pattern = re.compile(r'(SIGGEN_LOCKEDSIGS_t-[\w-]+)\s*=\s*"(.*?)"', re.DOTALL)
+    matches = pattern.findall(content)
+
+    for var_name, value in matches:
+        arch = var_name.split('SIGGEN_LOCKEDSIGS_t-')[-1]
+        lines = [line.strip().rstrip('\\\\') for line in value.strip().splitlines() if line.strip()]
+        for line in lines:
+            parts = line.split(':')
+            if len(parts) == 3:
+                package, task, hash = parts
+                key = f"{arch}:{package}:{task}"
+                result[key] = hash.strip()
+
+    return result
+
+sigmap = {}
+for file in sys.argv[1:]:
+    sigs = parse_arch_package_tasks(file)
+    build = file.removeprefix("locked-sigs.")
+    for task, hash in sigs.items():
+        if not task in sigmap:
+            # A new task
+            sigmap[task] = { hash : [build] }
+        elif hash in sigmap[task]:
+            # The same hash in a different build, may be good
+            sigmap[task][hash].append(build)
+        else:
+            # A different hash in a different file, bad
+            sigmap[task][hash] = [build]
+
+result=0
+for task, hashes in sigmap.items():
+    if len(hashes) > 1:
+        print(task)
+        for hash_val, files in hashes.items():
+            files = " ".join(files)
+            print(f"  {files}")
+            result=1
+
+sys.exit(result)
--
2.39.5

