Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD02CC433F5
	for <webhook@archiver.kernel.org>; Sat, 13 Nov 2021 18:53:02 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.web10.496.1636829581508599403
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 13 Nov 2021 10:53:01 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57,
 mailfrom: mark.hatle@kernel.crashing.org)
Received: from [192.168.2.107] ([70.99.78.137])
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 1ADIr02j031717
	for <bitbake-devel@lists.openembedded.org>; Sat, 13 Nov 2021 12:53:00 -0600
Message-ID: <39349e48-9e22-1584-6ed1-14e170cea0d1@kernel.crashing.org>
Date: Sat, 13 Nov 2021 12:52:59 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: [bitbake-devel] uri_replace not working prooperly
Content-Language: en-US
To: bitbake-devel@lists.openembedded.org
References: <16B72D80A53E732A.9914@lists.openembedded.org>
From: Mark Hatle <mark.hatle@kernel.crashing.org>
In-Reply-To: <16B72D80A53E732A.9914@lists.openembedded.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 13 Nov 2021 18:53:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13043

Ok, figured out a public reproducer for the issue:

git clone git://git.yoctoproject.org/poky -b honister
cd poky/
git clone git://git.openembedded.org/meta-openembedded -b honister
git clone git://git.yoctoproject.org/meta-virtualization -b honister
git clone https://github.com/xilinx/meta-petalinux -b honister
git clone https://github.com/xilinx/meta-xilinx -b honister
git clone https://github.com/xilinx/meta-xilinx-tools -b honister
. ./oe-init-build-env
bitbake-layers add-layer ../meta-openembedded/meta-*
bitbake-layers add-layer ../meta-virtualization
bitbake-layers add-layer ../meta-xilinx/meta-xilinx-bsp \
     ../meta-xilinx/meta-xilinx-standalone \
     ../meta-xilinx/meta-xilinx-pynq
bitbake-layers add-layer ../meta-petalinux

echo 'DISTRO = "petalinux"' >> conf/local.conf
echo 'INHERIT+="plnx-mirrors"' >> conf/local.conf
echo 'PNBLACKLIST[qemu-native]="blacklist"' >> conf/local.conf
echo 'PNBLACKLIST[nativesdk-qemu]="blacklist"' >> conf/local.conf

bitbake qemu-xilinx-native


(Ya, it's messy, but it was able to reproduce the 'endless' fetch for me.)

DEBUG: For url ['https', 'downloads.yoctoproject.orggit2_git.qemu.org.git.seabio
s.git..tar.gz', '/git2_git.qemu.org.git.seabios.git..tar.gzmgit2_git.qemu.org.gi
t.seabios.git..tar.gzigit2_git.qemu.org.git.seabios.git..tar.gzrgit2_git.qemu.or
g.git.seabios.git..tar.gzrgit2_git.qemu.org.git.seabios.git..tar.gzogit2_git.qem
u.org.git.seabios.git..tar.gzrgit2_git.qemu.org.git.seabios.git..tar.gz/git2_git
.qemu.org.git.seabios.git..tar.gzsgit2_git.qemu.org.git.seabios.git..tar.gzogit2
_git.qemu.org.git.seabios.git..tar.gzugit2_git.qemu.org.git.seabios.git..tar.gzr
git2_git.qemu.org.git.seabios.git..tar.gzcgit2_git.qemu.org.git.seabios.git..tar
.gzegit2_git.qemu.org.git.seabios.git..tar.gzsgit2_git.qemu.org.git.seabios.git.
.tar.gz/git2_git.qemu.org.git.seabios.git..tar.gz', '', '', OrderedDict()] 
comparing ['svn', '.*', '/.*', '', '', OrderedDict()] to ['https', 
'downloads.yoctoproject.org', '/mirror/sources/', '', '', OrderedDict()]


--Mark

On 11/13/21 12:10 PM, Mark Hatle wrote:
> I ran into a problem yesterday (which prompted the previous email I sent about
> lockfile and ENAMETOOLONG) that was triggered by the uri_replace code.
> 
> Specifically patches:
> 
> 96c30007dc0b32eee2b15771daec7948bc9bfd97
> fetch2: fix downloadfilename issue with premirror
> 
> and
> 
> 8a3ff9f3eaf19d4258eb070c5dc230dface269b2
> bitbake: fetch2: fix premirror URI when downloadfilename defined
> 
> (The former works to resolve an issue with the later.)
> 
> 
> What is happening is the uri_mirror can (and should) adjust it's own mirror urls
> in a pattern.  However, something is going catastrophically wrong and ends up
> generating this long entry:
> 
>> DEBUG: For url ['http', 'petalinux.xilinx.com', '/sswreleases/rel-v2022.1/downloads/git2_git.qemu.org.git.seabios.git..tar.gz', '', '', OrderedDict()] comparing ['svn', '.*'
>> , '/.*', '', '', OrderedDict()] to ['https', 'downloads.yoctoproject.org', '/mirror/sources/', '', '', OrderedDict()]
>> DEBUG: For url ['https', 'downloads.yoctoproject.orggit2_git.qemu.org.git.seabios.git..tar.gz', '/git2_git.qemu.org.git.seabios.git..tar.gzmgit2_git.qemu.org.git.seabios.git
>> ..tar.gzigit2_git.qemu.org.git.seabios.git..tar.gzrgit2_git.qemu.org.git.seabios.git..tar.gzrgit2_git.qemu.org.git.seabios.git..tar.gzogit2_git.qemu.org.git.seabios.git..tar
>> .gzrgit2_git.qemu.org.git.seabios.git..tar.gz/git2_git.qemu.org.git.seabios.git..tar.gzsgit2_git.qemu.org.git.seabios.git..tar.gzogit2_git.qemu.org.git.seabios.git..tar.gzug
>> it2_git.qemu.org.git.seabios.git..tar.gzrgit2_git.qemu.org.git.seabios.git..tar.gzcgit2_git.qemu.org.git.seabios.git..tar.gzegit2_git.qemu.org.git.seabios.git..tar.gzsgit2_g
>> it.qemu.org.git.seabios.git..tar.gz/git2_git.qemu.org.git.seabios.git..tar.gz', '', '', OrderedDict()] comparing ['ftp', '.*', '/.*', '', '', OrderedDict()] to ['http', 'pet
>> alinux.xilinx.com', '/sswreleases/rel-v2022.1/downloads', '', '', OrderedDict()]
> 
> (later line repeats for each type..)
> 
> The end result of this is that the locking code attemtps to lock a file with the
> name:
> git2_git.qemu.org.git.seabios.git..tar.gzmgit2_git.qemu.org.git.seabios.git..tar.gzigit2_git.qemu.org.git.seabios.git..tar.gzrgit2_git.qemu.org.git.seabios.git..tar.gzrgit2_git.qemu.org.git.seabios.git..tar.gzogit2_git.qemu.org.git.seabios.git..tar.gzrgit2_git.qemu.org.git.seabios.git..tar.gz/git2_git.qemu.org.git.seabios.git..tar.gzsgit2_git.qemu.org.git.seabios.git..tar.gzogit2_git.qemu.org.git.seabios.git..tar.gzugit2_git.qemu.org.git.seabios.git..tar.gzrgit2_git.qemu.org.git.seabios.git..tar.gzcgit2_git.qemu.org.git.seabios.git..tar.gzegit2_git.qemu.org.git.seabios.git..tar.gzsgit2_git.qemu.org.git.seabios.git..tar.gz_git2_git.qemu.org.git.seabios.git..tar.gz
> 
> Which needless to say is way way way too long.
> 
> I'm working to find a way to reproduce this issue outside of our internal
> configuration.  (as you can see what is being referenced is all public urls, so
> it's just a matter of me building a reproducer.)
> 
> The odd thing, if I do a -c cleanall on the recipe, and retry it then works
> fine.  So it may also have some issue with other tasks running at the same time.
> 
> If I can figure out a solid reproducer for this (even if it's complex), I'll
> reply to this with the details.
> 
> --Mark
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#13042): https://lists.openembedded.org/g/bitbake-devel/message/13042
> Mute This Topic: https://lists.openembedded.org/mt/87032926/3616948
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [mark.hatle@kernel.crashing.org]
> -=-=-=-=-=-=-=-=-=-=-=-
> 

