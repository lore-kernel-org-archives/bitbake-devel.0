Return-Path: <mark.hatle@kernel.crashing.org>
Received: from kernel.crashing.org (kernel.crashing.org [76.164.61.194])
	by mail.openembedded.org (Postfix) with ESMTP id 2B9ED7F7B7
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 13 Nov 2019 18:31:54 +0000 (UTC)
Received: from Marks-MacBook-Pro.local ([76.164.61.198]) (authenticated bits=0)
	by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id xADIVkce014358
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NO); Wed, 13 Nov 2019 12:31:53 -0600
To: Wayne Li <waynli329@gmail.com>, Khem Raj <raj.khem@gmail.com>
References: <CAM2K0nqA0QGCcaN8z=qvtVu-U_aHswjqKTbZJ0YoCXE6OsvzQw@mail.gmail.com>
	<20191113083317.GA7340@localhost>
	<83ee3505594a6b5cb00eb643ece131c85aedeea0.camel@gmail.com>
	<CAM2K0nr_gPrDtx5QLz6x74a2CnDb8kERKcYu5bMJi8sg5PE62A@mail.gmail.com>
	<CAM2K0nrhK-z1M9uFzxVOrsk0s4+npm3KX0rDh6dx+SOs6sn_gQ@mail.gmail.com>
	<CAM2K0npPofZEYUSjBvUXUN8TjpE_JaHZFr7EAdE=i2wSQVCQ8Q@mail.gmail.com>
From: Mark Hatle <mark.hatle@kernel.crashing.org>
Message-ID: <698c95f2-4784-f7de-7a4b-2283a3b2f16e@kernel.crashing.org>
Date: Wed, 13 Nov 2019 12:31:46 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
	Gecko/20100101 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAM2K0npPofZEYUSjBvUXUN8TjpE_JaHZFr7EAdE=i2wSQVCQ8Q@mail.gmail.com>
Cc: Yocto Project Discussion <yocto@yoctoproject.org>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>,
	Adrian Bunk <bunk@stusta.de>
Subject: Re: [yocto] No Package Provides /bin/awk
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
X-List-Received-Date: Wed, 13 Nov 2019 18:31:55 -0000
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit

Bitbake inspects the binaries and looks at the #! line.  You need to change the
line itself (via a patch) to /usr/bin/awk, and then it will pick up the
dependency automatically on a rebuild.

--Mark

On 11/13/19 12:14 PM, Wayne Li wrote:
> On further inspection of the older image my coworker made, it looks like awk is
> located at "/usr/bin/awk".  I see this by just doing a "which awk" in the
> console of the T4240 RDB when the old image is loaded.  So it looks like the
> most likely case is that Khem Raj is correct and that bitbake is expecting awk
> to be in "/bin" when awk is actually in "/usr/bin".  In that case, I need to
> know where the line telling bitbake to look for awk in the "/bin" directory is.
> 
> On Wed, Nov 13, 2019 at 12:02 PM Wayne Li <waynli329@gmail.com
> <mailto:waynli329@gmail.com>> wrote:
> 
>     I'd like also like to mention that my main concern with the ver_linux files
>     that I found in my project was that the shebang line was " #!/bin/sh"
>     instead of "#!/bin/awk -f" which is the shebang line in the ver_linux file
>     in the patch.  The patch wants to change the shebang line from "#!/bin/awk
>     -f" to  "#!/usr/bin/awk -f" so I'm not sure how that change would translate
>     when I'm working with the shebang line "#!/bin/sh".  Or perhaps Yocto has
>     changed since that patch was posted and maybe the place /bin/awk is
>     specified is different?
> 
>     On Wed, Nov 13, 2019 at 11:51 AM Wayne Li <waynli329@gmail.com
>     <mailto:waynli329@gmail.com>> wrote:
> 
>         So after further investigation, I'm fairly sure awk is actually present
>         in the target image.  Here are my reasons why I feel that this is the case:
> 
>         -I looked at the busybox menuconfig GUI that comes up when I run
>         "bitbake -c menuconfig busybox" and it says awk is built-in. 
>         -I looked at various def-config files I found by just doing a "grep -rn
>         "CONFIG_AWK"" and found that CONFIG_AWK seems to have been enabled
>         throughout the project (there was the line CONFIG_AWK=y uncommented in
>         the various def-config files I mentioned). 
>         -I have an older version of the target image that my coworker (who has
>         since left the company) created.  I just need to rebuild this image
>         because I am trying to add some kernel modules to the image.  When I run
>         the command "awk" in the console for the T4240 RDB when the older
>         version of the image is loaded, I do see the gawk help info come up.
>         This shows awk is present in the older image.
> 
>         But looking at what Khem Raj mentioned, perhaps bitbake is just not
>         finding the awk because it's actually in /usr/bin when bitbake expects
>         it to be in /bin?  Though I am a little confused about the link you
>         sent, Khem Raj.  How do exactly do I apply this patch?  I'm assuming we
>         have to change the file ver_linux?  I did a "find . -name "ver_linux""
>         and I see multiple results:
> 
>         bash-4.2$ find . -name "ver_linux"
>         ./build_t4240rdb-64b/tmp/work/ppc64e6500-fsl-linux/linux-libc-headers/4.1-r0/linux-4.1/scripts/ver_linux
>         ./build_t4240rdb-64b/tmp/work/ppce6500-fslmllib32-linux/lib32-linux-libc-headers/4.1-r0/linux-4.1/scripts/ver_linux
>         ./build_t4240rdb-64b/tmp/work/t4240rdb_64b-fsl-linux/kernel-devsrc/1.0-r0/package/usr/src/kernel/scripts/ver_linux
>         ./build_t4240rdb-64b/tmp/work/t4240rdb_64b-fsl-linux/kernel-devsrc/1.0-r0/image/usr/src/kernel/scripts/ver_linux
>         ./build_t4240rdb-64b/tmp/work/t4240rdb_64b-fsl-linux/kernel-devsrc/1.0-r0/packages-split/kernel-devsrc/usr/src/kernel/scripts/ver_linux
>         ./build_t4240rdb-64b/tmp/work-shared/t4240rdb-64b/kernel-source/scripts/ver_linux
>         ./build_t4240rdb/tmp/work/ppc64e6500-fslmllib64-linux/lib64-linux-libc-headers/4.1-r0/linux-4.1/scripts/ver_linux
>         ./build_t4240rdb/tmp/work/ppce6500-fsl-linux/linux-libc-headers/4.1-r0/linux-4.1/scripts/ver_linux
>         ./build_t4240rdb/tmp/work-shared/t4240rdb/kernel-source/scripts/ver_linux
> 
>         Now the build I'm working on is build_t4240rdb-64b so the last three
>         results in that search probably don't matter.  Though there are still
>         six more results for when I search ver_linux.  So I'm not sure which one
>         I need to change.  Moreover, all of the ver_linux files I found more or
>         less look like the following:
> 
>         https://gist.github.com/WayneZhenLi/c7475cf382a80bfd2de31e82c40c1677
> 
>         Which seems to be very different from the ver_linux file mentioned in
>         the patch.  This further confuses me on how to apply the patch. 
> 
>         Or maybe do you guys think maybe the patch isn't the solution here? 
>         Maybe there's some other reason bitbake isn't finding the awk?
> 
>         -Thanks!, Wayne Li
> 
>         On Wed, Nov 13, 2019 at 10:57 AM Khem Raj <raj.khem@gmail.com
>         <mailto:raj.khem@gmail.com>> wrote:
> 
>             On Wed, 2019-11-13 at 10:33 +0200, Adrian Bunk wrote:
>             > On Tue, Nov 12, 2019 at 04:08:48PM -0600, Wayne Li wrote:
>             > > Dear Yocto Developers,
>             > >
>             > > I'm trying to to build a Yocto kernel for a T4240 RDB.  When I run
>             > > "bitbake
>             > > fsl-image-full" to build the entire linux image, I get an error
>             > > that says
>             > > "Can't install kernel-devsrc-1.0-r0@t4240rdb_64b: no package
>             > > provides
>             > > /bin/awk".  Here's the entire error print that I see:
>             > >
>             > > https://gist.github.com/WayneZhenLi/e35f65081092cf1f24df29ec369c701c
>             > >
>             > > Anyway I'm confused about this error because /bin/awk does
>             > > exist.  Like if
>             > > I run "/bin/awk" in the console I see help info come up describing
>             > > how to
>             > > use a program called "gawk".  Why can't bitbake find /bin/awk
>             > > then?  Or am
>             > > I misunderstanding what this error is trying to say?  I mean I'm
>             > > assuming
>             > > it's just not able to find /bin/awk but maybe the error means
>             > > something
>             > > else?  Or maybe /bin/awk is actually relative to some path?  Let me
>             > > know
>             > > your thoughts.
>             >
>             > /bin/awk is missing on your target image that will run on the T4240
>             > RDB.
>             >
>             > The smallest implementation is to enable CONFIG_AWK in your busybox
>             > config.
>             >
> 
>             import something like below patch into your kernel will help too
> 
>             https://git.yoctoproject.org/cgit/cgit.cgi/linux-yocto/commit/?id=8af11c1cdd8fa08217e702b57cf96e9030db52b2
> 
>             > > -Thanks!, Wayne Li
>             >
>             > cu
>             > Adrian
>             >
>             > --
>             >
>             >        "Is there not promise of rain?" Ling Tan asked suddenly out
>             >         of the darkness. There had been need of rain for many days.
>             >        "Only a promise," Lao Er said.
>             >                                        Pearl S. Buck - Dragon Seed
>             >
> 
> 

