Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B15C433F5
	for <webhook@archiver.kernel.org>; Sat, 13 Nov 2021 18:10:20 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.web10.32.1636827019479016356
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 13 Nov 2021 10:10:19 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57,
 mailfrom: mark.hatle@kernel.crashing.org)
Received: from [192.168.2.107] ([70.99.78.137])
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 1ADIAILK029929;
	Sat, 13 Nov 2021 12:10:18 -0600
Message-ID: <a855463e-f683-cd17-01c6-71794b8530c4@kernel.crashing.org>
Date: Sat, 13 Nov 2021 12:10:17 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Content-Language: en-US
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
From: Mark Hatle <mark.hatle@kernel.crashing.org>
Subject: uri_replace not working prooperly
Cc: Mark Hatle <mark.hatle@xilinx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 13 Nov 2021 18:10:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13042

I ran into a problem yesterday (which prompted the previous email I sent about 
lockfile and ENAMETOOLONG) that was triggered by the uri_replace code.

Specifically patches:

96c30007dc0b32eee2b15771daec7948bc9bfd97
fetch2: fix downloadfilename issue with premirror

and

8a3ff9f3eaf19d4258eb070c5dc230dface269b2
bitbake: fetch2: fix premirror URI when downloadfilename defined

(The former works to resolve an issue with the later.)


What is happening is the uri_mirror can (and should) adjust it's own mirror urls 
in a pattern.  However, something is going catastrophically wrong and ends up 
generating this long entry:

> DEBUG: For url ['http', 'petalinux.xilinx.com', '/sswreleases/rel-v2022.1/downloads/git2_git.qemu.org.git.seabios.git..tar.gz', '', '', OrderedDict()] comparing ['svn', '.*'
> , '/.*', '', '', OrderedDict()] to ['https', 'downloads.yoctoproject.org', '/mirror/sources/', '', '', OrderedDict()]
> DEBUG: For url ['https', 'downloads.yoctoproject.orggit2_git.qemu.org.git.seabios.git..tar.gz', '/git2_git.qemu.org.git.seabios.git..tar.gzmgit2_git.qemu.org.git.seabios.git
> ..tar.gzigit2_git.qemu.org.git.seabios.git..tar.gzrgit2_git.qemu.org.git.seabios.git..tar.gzrgit2_git.qemu.org.git.seabios.git..tar.gzogit2_git.qemu.org.git.seabios.git..tar
> .gzrgit2_git.qemu.org.git.seabios.git..tar.gz/git2_git.qemu.org.git.seabios.git..tar.gzsgit2_git.qemu.org.git.seabios.git..tar.gzogit2_git.qemu.org.git.seabios.git..tar.gzug
> it2_git.qemu.org.git.seabios.git..tar.gzrgit2_git.qemu.org.git.seabios.git..tar.gzcgit2_git.qemu.org.git.seabios.git..tar.gzegit2_git.qemu.org.git.seabios.git..tar.gzsgit2_g
> it.qemu.org.git.seabios.git..tar.gz/git2_git.qemu.org.git.seabios.git..tar.gz', '', '', OrderedDict()] comparing ['ftp', '.*', '/.*', '', '', OrderedDict()] to ['http', 'pet
> alinux.xilinx.com', '/sswreleases/rel-v2022.1/downloads', '', '', OrderedDict()]

(later line repeats for each type..)

The end result of this is that the locking code attemtps to lock a file with the 
name: 
git2_git.qemu.org.git.seabios.git..tar.gzmgit2_git.qemu.org.git.seabios.git..tar.gzigit2_git.qemu.org.git.seabios.git..tar.gzrgit2_git.qemu.org.git.seabios.git..tar.gzrgit2_git.qemu.org.git.seabios.git..tar.gzogit2_git.qemu.org.git.seabios.git..tar.gzrgit2_git.qemu.org.git.seabios.git..tar.gz/git2_git.qemu.org.git.seabios.git..tar.gzsgit2_git.qemu.org.git.seabios.git..tar.gzogit2_git.qemu.org.git.seabios.git..tar.gzugit2_git.qemu.org.git.seabios.git..tar.gzrgit2_git.qemu.org.git.seabios.git..tar.gzcgit2_git.qemu.org.git.seabios.git..tar.gzegit2_git.qemu.org.git.seabios.git..tar.gzsgit2_git.qemu.org.git.seabios.git..tar.gz_git2_git.qemu.org.git.seabios.git..tar.gz

Which needless to say is way way way too long.

I'm working to find a way to reproduce this issue outside of our internal 
configuration.  (as you can see what is being referenced is all public urls, so 
it's just a matter of me building a reproducer.)

The odd thing, if I do a -c cleanall on the recipe, and retry it then works 
fine.  So it may also have some issue with other tasks running at the same time.

If I can figure out a solid reproducer for this (even if it's complex), I'll 
reply to this with the details.

--Mark

